const fs = require('fs');

// pass i/o handlers to wasm
const imports = {
    console: {
	log: (x) => { process.stdout.write(x); },
    },
    fs: {
	readFileSync(path) => fs.readFileSync(path),
    }
}

const jsMain = async () => {
    const buffer = fs.readFileSync('main.wasm');
    WebAssembly.instantiate(buffer, imports).then(wasm => {
	wasm.instance.exports.main(10);
    }).catch(e => console.log(e));
}
jsMain();
