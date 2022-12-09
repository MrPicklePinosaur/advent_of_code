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
    (global $globalStackBase i32 (i32.const 65536))
    (global $fileContents i32 (i32.const 256))

    (func $main (param $stacks i32) (result i32)

    	(local $fileLength i32)
	(local $i i32) ;; loop counter
	(local $offset i32)
	(local $rowOffset i32)
	(local $char i32)

	(local.set $fileLength
	    (call $readFileSync (i32.const 0) (i32.const 9) (global.get $fileContents))
	)

	(call $logString (global.get $fileContents) (i32.const 300))

	;; parse input
	(block $done
	    (loop $rowLoop
		(local.set $i (i32.const 0))
		(loop $itemLoop
		    ;; 4*i + 3 + fileContents
		    (local.set $offset
			(i32.add
			    (i32.add (i32.add (i32.mul (i32.const 4) (local.get $i)) (i32.const 1)) (global.get $fileContents))
			    (local.get $rowOffset)
			)
		    )

		    (local.set $char (i32.load8_u (local.get $offset)))
		    (if (i32.eq (local.get $char) (i32.const 49))
			(then (br $done))
		    )
		    (if (i32.ne (local.get $char) (i32.const 32))
			(then

			    ;; push to respective stack
			    (call $stackPush (local.get $i) (local.get $char))
			    (call $logI32
				(call $stackTop (local.get $i))
			    )
			)
		    )

		    (local.set $i (i32.add (local.get $i) (i32.const 1)))
		    (br_if $itemLoop (i32.lt_u (local.get $i) (local.get $stacks)))
		)
		(local.set $rowOffset
		    (i32.add
			(local.get $rowOffset)
			(i32.mul (local.get $stacks) (i32.const 4))
		    )
		)
		(call $logString (i32.const 0) (i32.const 5))
		(br $rowLoop)
	    )
	)

	(i32.const 0)
    )

    (func $stackPush (param $stackNum i32) (param $value i32)
        (local $stackBase i32) ;; address of stack base
        (local $stackPtr i32) ;; value of the stack pointer
        (local $stackTop i32) ;; address of stack top (next avaliable)

	(local.set $stackBase
	    (i32.sub
		(global.get $globalStackBase)
		(i32.mul (local.get $stackNum) (global.get $stackSize))
	    )
	)
	(local.set $stackPtr (i32.load8_u (local.get $stackBase)))
	(local.set $stackTop
	    (i32.sub
		(local.get $stackBase)
		(i32.add (local.get $stackPtr) (i32.const 1))
	    )
	)

	;; store value
	(i32.store8 (local.get $stackTop) (local.get $value))

	;; increment stack pointer
	(i32.store8
	    (local.get $stackBase)
	    (i32.add
		(local.get $stackPtr)
		(i32.const 1)
	    )
	)
    )

    (func $stackPop (param $stackNum i32) (param $value i32)
        (local $stackBase i32) ;; address of stack base
        (local $stackPtr i32) ;; value of the stack pointer

	(local.set $stackBase
	    (i32.sub
		(global.get $globalStackBase)
		(i32.mul (local.get $stackNum) (global.get $stackSize))
	    )
	)
	(i32.store8
	    (local.get $stackBase)
	    (i32.sub
		(i32.load8_u (local.get $stackBase))
		(i32.const 1)
	    )
	)
    )

    ;; will not work if stack empty
    (func $stackTop (param $stackNum i32) (result i32)
        (local $stackBase i32) ;; address of stack base
        (local $stackPtr i32) ;; value of the stack pointer

	(local.set $stackBase
	    (i32.sub
		(global.get $globalStackBase)
		(i32.mul (local.get $stackNum) (global.get $stackSize))
	    )
	)
	(local.set $stackPtr (i32.load8_u (local.get $stackBase)))

	(i32.load8_u (i32.sub (local.get $stackBase) (local.get $stackPtr)))
    )
    
)
