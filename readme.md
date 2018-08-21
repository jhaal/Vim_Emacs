<div id="table-of-contents">
<h2>Table of Contents</h2>
<div id="text-table-of-contents">
<ul>
<li><a href="#sec-1">1. Settings start here onwards</a>
<ul>
<li><a href="#sec-1-1">1.1. Set column width to 80 columns, highlight characters after that limit</a></li>
<li><a href="#sec-1-2">1.2. Blank scratch pad and start emacs in text mode by default</a></li>
<li><a href="#sec-1-3">1.3. Always kill current buffer</a></li>
<li><a href="#sec-1-4">1.4. Kill all buffers with C-M-super-k</a></li>
<li><a href="#sec-1-5">1.5. Kill whole word backwards as well as foreards with C-c ww</a></li>
<li><a href="#sec-1-6">1.6. Disable hippie-exapnd warnings</a></li>
<li><a href="#sec-1-7">1.7. Make typing select and delete/overwrite selected text</a></li>
<li><a href="#sec-1-8">1.8. Turn on highlighting current line and use pretty symbols for words</a></li>
<li><a href="#sec-1-9">1.9. Autosave files in /tmp/autosaves and don't create lock files</a></li>
<li><a href="#sec-1-10">1.10. Inhibit splash screen and create backup files</a></li>
<li><a href="#sec-1-11">1.11. Line numbering utility</a></li>
<li><a href="#sec-1-12">1.12. Display time in modeline</a></li>
<li><a href="#sec-1-13">1.13. Auto-complete brackets and quotes</a></li>
<li><a href="#sec-1-14">1.14. No blinking cursor, wrap long lines by arrow</a></li>
<li><a href="#sec-1-15">1.15. Make emacs remember cursor position</a></li>
<li><a href="#sec-1-16">1.16. Language settings</a></li>
<li><a href="#sec-1-17">1.17. Set new buffer open in new pop-up tab(Optional)</a></li>
<li><a href="#sec-1-18">1.18. CUA mode to enave C-x,C-c,C-v</a></li>
<li><a href="#sec-1-19">1.19. Abbreviation &amp; Expansion</a></li>
<li><a href="#sec-1-20">1.20. Disable toolbar and menubar</a></li>
<li><a href="#sec-1-21">1.21. Set tab width to 4-columns &amp; no tab but space for C-r/N-l</a></li>
<li><a href="#sec-1-22">1.22. Custom compile commands</a></li>
<li><a href="#sec-1-23">1.23. Links to websites that I have used to build this setup</a>
<ul>
<li><a href="#sec-1-23-1">1.23.1. </a></li>
<li><a href="#sec-1-23-2">1.23.2. </a></li>
<li><a href="#sec-1-23-3">1.23.3. </a></li>
<li><a href="#sec-1-23-4">1.23.4. </a></li>
<li><a href="#sec-1-23-5">1.23.5. </a></li>
<li><a href="#sec-1-23-6">1.23.6. </a></li>
<li><a href="#sec-1-23-7">1.23.7. </a></li>
</ul>
</li>
</ul>
</li>
</ul>
</div>
</div>

# Settings start here onwards<a id="sec-1" name="sec-1"></a>

## Set column width to 80 columns, highlight characters after that limit<a id="sec-1-1" name="sec-1-1"></a>

    (require 'whitespace)
    (setq whitespace-line-column 80) ;; limit line length
    (setq whitespace-style '(face empty-tabs lines-tail))
    (global-whitespace-mode t)

## Blank scratch pad and start emacs in text mode by default<a id="sec-1-2" name="sec-1-2"></a>

    (setq initial-scratch-message "")
    (setq initial-major-mode 'text-mode)
    (add-hook 'text-mode-hook 'turn-on-auto-fill)

## Always kill current buffer<a id="sec-1-3" name="sec-1-3"></a>

    (defun kill-curr-buffer ()
    (interactive)
    (kill-buffer (current-buffer)))
    (global-set-key (kbd "C-x k") 'kill-curr-buffer)

## Kill all buffers with C-M-super-k<a id="sec-1-4" name="sec-1-4"></a>

    (defun kill-all-buffers()
    (interactive)
    (mapc 'kill-buffer (buffer-list)))
    (global-set-key (kbd "C-M-s-k") 'kill-all-buffers)

## Kill whole word backwards as well as foreards with C-c ww<a id="sec-1-5" name="sec-1-5"></a>

    (defun kill-whole-word ()
     (interactive)
     (backward-word)
     (kill-word 1))
    (global-set-key (kbd "C-c w w") 'kill-whole-word)
    ;; subword-mode
    (global-subword-mode 1)

## Disable hippie-exapnd warnings<a id="sec-1-6" name="sec-1-6"></a>

    (setq ad-redefinition-action 'accept)

## Make typing select and delete/overwrite selected text<a id="sec-1-7" name="sec-1-7"></a>

    (delete-selection-mode 1)

## Turn on highlighting current line and use pretty symbols for words<a id="sec-1-8" name="sec-1-8"></a>

    (when window-system (global-hl-line-mode t))
    (when window-system (global-prettify-symbols-mode t))

## Autosave files in /tmp/autosaves and don't create lock files<a id="sec-1-9" name="sec-1-9"></a>

1.  url-github.com/kshenoy/dotfiles/blob/master/emacs.d/config.org

        ;;(setq auto-save-default nil)
        (defvar autosave-directory (concat user-emacs-directory "/tmp/autosave"))
        (if (not (file-exists-p autosave-directory)) (make-directory autosave-directory t))
        (setq create-lockfiles nil)
        ;; (setq auto-save-file-name-transforms `(("." ,autosave-directory t)))
        (setq auto-save-default t)  ; auto-save every buffer that visits a file
        (setq history-delete-duplicates t)

## Inhibit splash screen and create backup files<a id="sec-1-10" name="sec-1-10"></a>

1.  url-github.com/kshenoy/dotfiles/blob/master/emacs.d/config.org

        (setq inhibit-splash-screen t)
        ;;(setq make-backup-files nil)
        (defvar backup-directory (concat user-emacs-directory "/tmp/backups"))
        (if (not (file-exists-p backup-directory)) (make-directory backup-directory t))
        (setq backup-directory-alist `(("." . ,backup-directory)))
        (setq make-backup-files         t)  ; backup of a file the first time it is saved.
        (setq backup-by-copying         t)  ; don't clobber symlinks
        (setq version-control           t)  ; version numbers for backup files
        (setq delete-old-versions       t)  ; delete excess backup files silently
        (setq delete-by-moving-to-trash t)
        (setq kept-old-versions         2)  ; oldest versions to keep when a new numbered backup is made (default: 2)
        (setq kept-new-versions         2)  ; newest versions to keep when a new numbered backup is made (default: 2)

## Line numbering utility<a id="sec-1-11" name="sec-1-11"></a>

    (global-linum-mode t)

## Display time in modeline<a id="sec-1-12" name="sec-1-12"></a>

    (display-time-mode 1)

## Auto-complete brackets and quotes<a id="sec-1-13" name="sec-1-13"></a>

    (setq electric-pair-pairs '(
                    (?\( . ?\))
                    (?\{ . ?\})
                    (?\[ . ?\])
                                (?\" . ?\")
                    ))
    (electric-pair-mode t)

## No blinking cursor, wrap long lines by arrow<a id="sec-1-14" name="sec-1-14"></a>

    (global-visual-line-mode 1)
    (blink-cursor-mode 0)

## Make emacs remember cursor position<a id="sec-1-15" name="sec-1-15"></a>

    (save-place-mode 1)
    (desktop-save-mode 1)

## Language settings<a id="sec-1-16" name="sec-1-16"></a>

    (set-language-environment    "UTF-8")
    (set-default-coding-systems  'utf-8)
    (setq locale-coding-system   'utf-8)
    (set-terminal-coding-system  'utf-8)
    (set-keyboard-coding-system  'utf-8)
    (set-selection-coding-system 'utf-8)
    (prefer-coding-system        'utf-8)

## Set new buffer open in new pop-up tab(Optional)<a id="sec-1-17" name="sec-1-17"></a>

    ;;(setq pop-up-frames t)

## CUA mode to enave C-x,C-c,C-v<a id="sec-1-18" name="sec-1-18"></a>

    (cua-mode 1)

## Abbreviation & Expansion<a id="sec-1-19" name="sec-1-19"></a>

1.  pp-78

        (setq-default abbrev-mode t)
        (read-abbrev-file "~/.emacs.d/.abbrev_defs")
        (setq save-abbrevs t)

## Disable toolbar and menubar<a id="sec-1-20" name="sec-1-20"></a>

    (menu-bar-mode -1)
    (tool-bar-mode -1)

## Set tab width to 4-columns & no tab but space for C-r/N-l<a id="sec-1-21" name="sec-1-21"></a>

    (setq-default tab-width 4)
    (setq-default indent-tabs-mode nil)

## Custom compile commands<a id="sec-1-22" name="sec-1-22"></a>

1.  C code

    ;;#+BEGIN<sub>SRC</sub> emacs-lisp
    ;;(c-mode . "icc -Wall -o %n %f")
    ;;#+END<sub>SRC</sub>

2.  C++ code

    ;;#+BEGIN<sub>SRC</sub> emacs-lisp
    ;;(c++-mode . "icpc -O2 -Wall -o %n %f")
    ;;#+END<sub>SRC</sub>

## Links to websites that I have used to build this setup<a id="sec-1-23" name="sec-1-23"></a>

### <https://github.com/makuto/editorPreferences/blob/master/Emacs/emacsConfig.txt><a id="sec-1-23-1" name="sec-1-23-1"></a>

### <https://www.youtube.com/watch?v=HTUE03LnaXA><a id="sec-1-23-2" name="sec-1-23-2"></a>

### <https://www.emacswiki.org/emacs/SmoothScrolling><a id="sec-1-23-3" name="sec-1-23-3"></a>

### <https://www.emacswiki.org/emacs/AutoInsertMode><a id="sec-1-23-4" name="sec-1-23-4"></a>

### <http://ergoemacs.org/emacs/emacs_make_modern.html><a id="sec-1-23-5" name="sec-1-23-5"></a>

### <https://www.gnu.org/software/auctex/manual/reftex.html#Installation><a id="sec-1-23-6" name="sec-1-23-6"></a>

### <https://www.emacswiki.org/emacs/YesOrNoP><a id="sec-1-23-7" name="sec-1-23-7"></a>
