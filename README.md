Portable Gvim On Windows
------------------------

To make gvim portable on Windows and work with Vundle, following the below instructions.

### Setup Vundle.

Make a bundle directory in the `vim` directory, then clone Vundle into it. Change the `Vundle.vim` file, search for `let g:bundle_dir = len(a:000) > 0 ? expand(a:1, 1) : expand('PATH_TO_BUNDLE_DIR', 1)`, change it. For example, my modification is `let g:bundle_dir = len(a:000) > 0 ? expand(a:1, 1) : expand('D:/devKits/vim/bundle', 1)`. After that, change your `vimrc` file, edit the file like this.

  ```bash
    let $DOTVIM = 'D:/devkits/vim'
    ; ... other stuff
    set rtp+=$DOTVIM/bundle/Vundle.vim
    call vundle#begin()
    call vundle#rc(expand('$DOTVIM/bundle'))

    Plugin 'gmarik/Vundle.vim'

    call vundle#end()
 ```

 Run `BundleInstall` to install those plugins.

### Add `Edit with Vim` to the context menu.

So if you want right click a file and see `Edit with Vim` option on the context menu, this is the way. change the `setting.ini` file along with this repo, then run `helper.vbs` script.

---

Copyright 2014 Towry Wang
