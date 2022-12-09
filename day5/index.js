const fs = require('fs');
const util = require('util');

const decode = (mem, offset, len) => {
    const bytes = new Uint8Array(mem.buffer, offset, len);
    return new util.TextDecoder('ascii').decode(bytes);
}

const encode = (mem, offset, str) => {
    const bytes = new util.TextEncoder('ascii').encode(str);
    const buffer = new Uint8Array(mem.buffer, offset, bytes.byteLength +1);
    buffer.set(bytes);
}

// pass i/o handlers to wasm
const block = new WebAssembly.Memory({initial: 1 });
const imports = {
    console: {
	string: (offset, len) => { process.stdout.write(decode(block, offset, len)+"\n") },
	i32: (n) => { process.stdout.write(n+"\n") },
	i32Decode: (ptr) => { process.stdout.write(decode(block, ptr, 1)+"\n") }
    },
    fs: {
	readFileSync: (offset, len, outOffset) => {
	    const file = fs.readFileSync(decode(block, offset, len), { encoding: 'ascii' });
	    encode(block, outOffset, file);
	    return file.length;
	},
    },
    memory: {
	block: block
    }
}

const jsMain = async () => {
    const buffer = fs.readFileSync('main.wasm');
    WebAssembly.instantiate(buffer, imports).then(wasm => {
	wasm.instance.exports.main(9);
    }).catch(e => console.log(e));
}
jsMain();
