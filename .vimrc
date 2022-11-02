" Hack to open file at a specific line with colon syntax.
function! AcmeOpen(match)
    " let l:match_data = split(a:match, ":")
    " let l:path = l:match_data[0]
    " let l:line = l:match_data[-1]
    " let l:col = l:match_data[2]
    let l:reg = matchlist(a:match, '\(.*\):\(.*\)$')
    echo l:reg
    let l:path = l:reg[1]
    let l:line = l:reg[2]
    if filereadable(l:path) && !bufexists(l:path)
        bw! "required so we don't pollute the bufferlist
        exe "edit ".l:path
        try
            silent exe l:line
        catch /E486/
        endtry
     else
        noautocmd exe "edit ".a:match
    endif
endfunction

au BufReadCmd *:* nested call AcmeOpen(expand("<amatch>"))

" General coding visuals
syntax on
set ruler
set number " line numbers
set hlsearch " show all search matches
set autoindent
filetype indent plugin on

" Show trailing whitespace
"highlight RedundantSpaces ctermbg=red guibg=red
"match RedundantSpaces /\s\+$/
autocmd BufWinEnter <buffer> match Error /\s\+$/
autocmd InsertEnter <buffer> match Error /\s\+\%#\@<!$/
autocmd InsertLeave <buffer> match Error /\s\+$/
autocmd BufWinLeave <buffer> call clearmatches()

" Case insensitive searching
set ignorecase
set smartcase

" Sane tabbing
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif
"source $VIMRUNTIME/vimrc_example.vim " doesn't work?

" Maintain undo history between sessions
set undofile
set undodir=~/.vim/undodir

" Tab for next buffer
nnoremap  <silent>   <tab>  :if &modifiable && !&readonly && &modified <CR> :write<CR> :endif<CR>:bnext<CR>
nnoremap  <silent> <s-tab>  :if &modifiable && !&readonly && &modified <CR> :write<CR> :endif<CR>:bprevious<CR>

" Removes trailing spaces
function TrimWhiteSpace()
   %s/\s*$//
   ''
endfunction
" Alias to old plugin name..
command StripWhitespace call TrimWhiteSpace()
