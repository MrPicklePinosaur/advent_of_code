
" execute file by running `source main.vim` from within vim

let b:file = readfile('input.txt')
let b:dirs = {}
let b:current_dir = '/'

let b:file_it = 0 " pseudo iterator for lines in file

" parse input
while b:file_it < len(b:file)

    let b:line = b:file[b:file_it]

    " add entry for current directory to the dict
    if !has_key(b:dirs, b:current_dir)
        let b:dirs[b:current_dir] = {"file_sizes": 0, "dirs": []}
    endif

    if match(b:line, '^\$ cd /') >= 0
        let b:current_dir = '/'
        " echo '> current dir: ' .. b:current_dir
    elseif match(b:line, '^\$ cd \.\.') >= 0
        " bad behavior if running `cd ..` at root
        let b:current_dir = substitute(b:current_dir, '/\w\+/$', '/', '')
        " echo '> current dir: ' .. b:current_dir
    elseif match(b:line, '^\$ cd .\+') >= 0
        " don't really like how we need to run the regex twice
        let b:dirname = substitute(b:line, '^\$ cd \(.\+\)', '\1', '')
        let b:current_dir = b:current_dir .. b:dirname .. '/'
        " echo '> current dir: ' .. b:current_dir
    elseif match(b:line, '^\$ ls') >= 0
        " echo '> ls'
    elseif match(b:line, '^dir .\+') >= 0
        let b:dirname = substitute(b:line, '^dir \(.\+\)', '\1', '')
        " echo '> directory entry: ' ..  b:dirname
        let b:dirs[b:current_dir]["dirs"] += [b:dirname]
    elseif match(b:line, '^\(\d\+\) \(.\+\)') >= 0
        let b:filesize = substitute(b:line, '^\(\d\+\) \(.\+\)', '\1', '')
        " echo '> file entry: ' .. b:filesize
        let b:dirs[b:current_dir]["file_sizes"] += b:filesize
    else

    endif

    let b:file_it += + 1

endwhile


" recursively compute total directory sizes
let b:dir_sizes = []
function! DirSize(dir_name)
    let l:dir_data = b:dirs[a:dir_name]
    let l:total_size = l:dir_data['file_sizes']

    " recurse
    for next_dir in l:dir_data['dirs']
        let l:total_size += DirSize(a:dir_name .. next_dir .. '/')
    endfor

    let b:dir_sizes += [l:total_size]

    return l:total_size
endfunction

let b:to_delete = 30000000 - (70000000 - DirSize('/'))
let b:answer = 10000000000 " pseudo max int

" linear search lol
for dir_size in b:dir_sizes
    if dir_size >= b:to_delete && dir_size < b:answer
        let b:answer = dir_size
    endif
endfor

echo b:answer
