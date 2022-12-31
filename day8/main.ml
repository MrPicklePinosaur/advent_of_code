let explode_string s = List.init (String.length s) (String.get s);;

let char_to_int c = int_of_char c - int_of_char '0';;

let filename = "input.txt"
let read_file filename =
    let ic = open_in filename in
    let try_read () =
        try Some (input_line ic) with End_of_file -> None in
    let rec loop acc = match try_read () with
        | Some line -> loop ((List.map char_to_int (explode_string line)) :: acc)
        | None -> close_in ic; List.rev acc in
    loop [];;

read_file filename
