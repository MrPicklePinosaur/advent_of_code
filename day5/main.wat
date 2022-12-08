(module
    (import "console" "log" (func $log (param i32)))
    (import "fs" "readFileSync" (func $readFileSync (param i32)))
    (export "main" (func $main))

    (func $main (param $a i32)
        (call $log (local.get $a))
    )
)
