if exists('g:neovide')
    set guifont=JetBrainsMono\ Nerd\ Font:h26
    let g:neovide_input_use_logo=v:true

    nnoremap <silent> <D-q> <Cmd>wq<CR>
    nnoremap <silent> <D-s> <Cmd>write<CR>
    inoremap <silent> <D-s> <Esc><Cmd>write<CR>

    nmap ˙ <M-h>
    nmap ∆ <M-j>
    nmap ˚ <M-k>
    nmap ¬ <M-l>
    imap ¬ <M-l>
    nmap © <M-g>
    nmap † <M-t>
    nmap ø <M-o>
    nmap ∫ <M-b>
    nmap √ <M-v>
endif
