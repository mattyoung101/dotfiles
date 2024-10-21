" Source: https://www.reddit.com/r/neovim/comments/eu866g/any_way_to_make_nvim_act_as_if_jenkinsfile_is/

augroup filetypedetect
    autocmd BufRead,BufNewFile *.Jenkinsfile set filetype=groovy
augroup END
