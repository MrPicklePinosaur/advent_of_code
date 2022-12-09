(module

    (import "memory" "block" (memory 1))
    (import "console" "string" (func $logString (param i32 i32)))
    (import "console" "i32" (func $logI32 (param i32)))
    (import "console" "i32Decode" (func $logI32Decode (param i32)))
    (import "fs" "readFileSync" (func $readFileSync (param i32 i32 i32) (result i32)))
    (export "main" (func $main))

    (data (i32.const 0) "input.txt") ;; constant holding name of input file
    (data (i32.const 256) "") ;; used for file data

    ;; very bottom of stack is reserved for stack pointer
    (global $stackSize i32 (i32.const 128))
    (global $stackBase i32 (i32.const 65536))
    (global $fileContents i32 (i32.const 256))

    (func $main (param $stacks i32) (result i32)

    	(local $fileLength i32)
	(local $i i32) ;; loop counter
	(local $offset i32)
	(local $char i32)

	(local.set $fileLength
	    (call $readFileSync (i32.const 0) (i32.const 9) (global.get $fileContents))
	)
	;; (call $logI32 (local.get $fileLength))

	(call $logString (global.get $fileContents) (i32.const 300))

	;; parse input
	(local.set $i (i32.const 0))
	(loop $loop
	    ;; 4*i + 3 + fileContents
	    (local.set $offset
	        (i32.add (i32.add (i32.mul (i32.const 4) (local.get $i)) (i32.const 1)) (global.get $fileContents))
	    )
	    (local.set $char (i32.load8_u (local.get $offset)))
	    (if (i32.ne (local.get $char) (i32.const 32))
	    	(then (call $logI32 (local.get $char)))
	    )

	    (local.set $i (i32.add (local.get $i) (i32.const 1)))
	    (br_if $loop (i32.lt_u (local.get $i) (local.get $stacks)))
	)

	(i32.const 0)
    )
)
