" Create the cells

set noexpandtab
set list lcs=tab:__

let g:cellWidth = 15

" Setup column highlighting. Every other cell column is highlighted
function! g:Highlight_Cells(size)

    " There are 26 columns (A-Z)
    let c = a:size
    let stop = a:size * 26

    " This is for the first highlighted column, it's specisl
    let &l:cc = join(range(c+1, c + a:size + 1),',')
    let c += a:size * 2

    " And this is for the rest of them
    while c <= stop
        let &l:cc .= join(range(c, c + a:size + 1),',')
        let c += a:size * 2
    endwhile
endfunction

" Setup the actual cell columns
function! g:Set_Cells(size)
    let &shiftwidth = a:size
    let &softtabstop = a:size
    let &tabstop = a:size
    call g:Highlight_Cells(a:size)
endfunction

function! g:CopyMatches()
    let hits = []
    "%s/\([a-zA-Z0-9(){}\-_!@#$%^&*\[\]:;"'<,>.?\/+= ]\{1,}\)\t/\=len(add(hits, strlen(submatch(1)))) ? submatch(1) : ''/ge
    "%s/[a-zA-Z ]\{1,}\t/\=len(add(hits, strlen(submatch(0)))) ? submatch(0) : ''/e
    %s/[a-zA-Z0-9(){}\-_!@#$%^&*\[\]:;"'<,>.?\/+= ]\{1,}\t/\=len(add(hits, strlen(submatch(0)))) ? submatch(0) : ''/e
    echo hits

    for i in hits
        if i > g:cellWidth
            let g:cellWidth = i
        endif
    endfor

    call g:Set_Cells(g:cellWidth)

endfunction

" /\w\{16,\}\t

" Color the cell columns
highlight colorcolumn ctermbg=17

" Highlight the numbers along the side a nice dark red
highlight LineNr    guifg=darkred  ctermfg=darkred

" Highlight the first line red and underlined, the rest of the cells can have
" whatever characters they have underlined, but not the tab. Underlining the
" entire cell looks bad with such a smallish font
highlight FirstLine cterm=bold cterm=underline ctermfg=darkred
match FirstLine /\%1l./

highlight TheRest cterm=underline
2match TheRest /\%>1l\(\t\)\@!/

" Create more rows
map <F2> :r ~/.vim/templates/template.tsv<CR>
inoremap <F2> <Esc> :r ~/.vim/templates/template.tsv<CR>

" In insert mode, tab moves you left, and enter moves you down.
inoremap <buffer> <silent> <C-I> <Esc> li
inoremap <buffer> <silent> <Enter> <Esc> ji

" Now do everything Most of the above should probably be in a plugin, with
" only this in the syntax file, fix it later
call g:Set_Cells(g:cellWidth)