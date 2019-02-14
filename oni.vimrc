let g:wsl_vimrc_dir = resolve(expand('<sfile>:p:h'))

execute 'source '.g:wsl_vimrc_dir.'\init.vimrc'
execute 'source '.g:wsl_vimrc_dir.'\settings.vimrc'
execute 'source '.g:wsl_vimrc_dir.'\functions.vimrc'
execute 'source '.g:wsl_vimrc_dir.'\keybind.vimrc'
execute 'source '.g:wsl_vimrc_dir.'\filespecific.vimrc'
execute 'source '.g:wsl_vimrc_dir.'\pluginspecific.vimrc'
execute 'source '.g:wsl_vimrc_dir.'\debuggers.vimrc'
execute 'source '.g:wsl_vimrc_dir.'\startdebugger.vimrc'
execute 'source '.g:wsl_vimrc_dir.'\bufferevents.vimrc'

let g:HOME = maktaba#path#Dirname(g:wsl_vimrc_dir)
