(module

    (import "memory" "block" (memory 1))
    (import "console" "string" (func $logString (param i32 i32)))
    (import "console" "i32" (func $logI32 (param i32)))
    (import "fs" "readFileSync" (func $readFileSync (param i32 i32 i32) (result i32)))
    (export "main" (func $main))

    (data (i32.const 0) "input.txt") ;; constant holding name of input file
    (data (i32.const 4) "") ;; used for file data

    (func $main (result i32)

    	(local $fileLength i32)

	(local.set $fileLength
	    (call $readFileSync (i32.const 0) (i32.const 9) (i32.const 4))
	)

	(call $logI32 (local.get $fileLength))
	(call $logString (i32.const 4) (i32.const 100))

	(i32.const 0)
    )
)
