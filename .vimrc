""" general settings
set nu
set shiftwidth=2
set tabstop=2
set expandtab
syntax on
set autoindent
set cindent
set smartindent
set incsearch
set ic
set hls
" set encoding to avoid LeaderF error
set encoding=utf-8
let mapleader=","
noremap \ ,
noremap <C-J> <C-W>j
noremap <C-K> <C-W>k
noremap <C-L> <C-W>l
noremap <C-H> <C-W>h
noremap <C-C> <C-W>c
noremap <f4> "+y


""" download vimplug if it's not found
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif


""" plugin list
call plug#begin('~/.vim/plugged')
Plug 'Yggdroot/LeaderF', { 'do': './install.sh' }
Plug 'tpope/vim-eunuch'
Plug 'ludovicchabant/vim-gutentags'
Plug 'skywind3000/gutentags_plus'
Plug 'skywind3000/vim-preview'
Plug 'vim-scripts/a.vim'
Plug 'justinmk/vim-dirvish'
call plug#end()


""" configuration for leaderf fuzzy finder
let g:Lf_ShortcutF = '<c-p>'
" don't use <C-m> as <C-m> is equivalent to enter
noremap <c-n> :LeaderfMru<cr>
noremap <leader>f :LeaderfFunction!<cr>
noremap <leader>b :LeaderfBuffer<cr>
noremap <leader>t :LeaderfTag<cr>
noremap <leader>g :LeaderfRgInteractive<cr>
let g:Lf_StlSeparator = { 'left': '', 'right': '', 'font': '' }
let g:Lf_RootMarkers = ['.project', '.root', '.svn', '.git']
let g:Lf_WorkingDirectoryMode = 'Ac'
let g:Lf_WindowHeight = 0.30
let g:Lf_CacheDirectory = expand('~/.vim/cache')
let g:Lf_ShowRelativePath = 0
let g:Lf_HideHelp = 1
let g:Lf_StlColorscheme = 'powerline'
let g:Lf_PreviewResult = {'Function':0, 'BufTag':0}


""" gutentags configuration
" gutentags 搜索工程目录的标志，当前文件路径向上递归直到碰到这些文件/目录名
let g:gutentags_project_root = ['.root', '.svn', '.git', '.hg', '.project']
" 所生成的数据文件的名称
let g:gutentags_ctags_tagfile = '.tags'
" 同时开启 ctags 和 gtags 支持：
let g:gutentags_modules = []
if executable('ctags')
	let g:gutentags_modules += ['ctags']
endif
if executable('gtags-cscope') && executable('gtags')
	let g:gutentags_modules += ['gtags_cscope']
endif
" 将自动生成的 ctags/gtags 文件全部放入 ~/.cache/tags 目录中，避免污染工程目录
let g:gutentags_cache_dir = expand('~/.cache/tags')
" 配置 ctags 的参数，老的 Exuberant-ctags 不能有 --extra=+q，注意
let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
let g:gutentags_ctags_extra_args += ['--c-kinds=+px']
" 如果使用 universal ctags 需要增加下面一行，老的 Exuberant-ctags 不能加下一行
"let g:gutentags_ctags_extra_args += ['--output-format=e-ctags']
" 禁用 gutentags 自动加载 gtags 数据库的行为
let g:gutentags_auto_add_gtags_cscope = 0
" debug gtags errors
"let g:gutentags_define_advanced_commands = 1
" change focus to quickfix window after search (optional).
let g:gutentags_plus_switch = 1


""" vim-preview configuration
noremap <m-u> :PreviewScroll -1<cr>
noremap <m-d> :PreviewScroll +1<cr>
autocmd FileType qf nnoremap <silent><buffer> p :PreviewQuickfix<cr>
autocmd FileType qf nnoremap <silent><buffer> P :PreviewClose<cr>
autocmd FileType qf nnoremap <silent><buffer> <leader><cr> <c-w><cr>
" position of the preview window
let g:preview#preview_position="bottom"
noremap <f3> :PreviewTag<cr>
