;;; evil-move-region.el --- Move the region around 1 line at a time like in the Eclipse IDE.

;; Filename: evil-move-region.el
;; Description: Move current line or region with M-k, M-j, M-h, M-l.
;; Author: Gregory McIntyre <greg@gregorymcintyre.com>
;; Copyright (C) 2016, Gregory McIntyre, all rights reserved.
;; Keywords: edit
;; Package-Version:
;; Compatibility: GNU Emacs 23.0.60.1
;; Version: 1.0
;;
;;; This file is NOT part of GNU Emacs

;;; License
;;
;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 51 Franklin Street, Fifth
;; Floor, Boston, MA 02110-1301, USA.

;;; Installation:
;;
;; Put evil-move-region.el to your load-path.
;; The load-path is usually ~/elisp/.
;; It's set in your ~/.emacs like this:
;; (add-to-list 'load-path (expand-file-name "~/elisp"))
;;
;; And the following to your ~/.emacs startup file.
;;
;; (require 'evil-move-region)
;; (evil-move-region-default-bindings)
;;

;;;###autoload
(evil-define-operator evil-move-up (beg end)
  "Move region up by one line."
  :motion evil-line
  (interactive "<r>")
  (evil-visual-line)
  (let ((beg-line (line-number-at-pos beg))
        (end-line (line-number-at-pos end))
        (dest (- (line-number-at-pos beg) 2)))
    (evil-move beg end dest)
    (goto-line (- beg-line 1))
    (exchange-point-and-mark)
    (goto-line (- end-line 2))
    (evil-visual-line)
    )
  )

;;;###autoload
(evil-define-operator evil-move-down (beg end)
  "Move region down by one line."
  :motion evil-line
  (interactive "<r>")
  (evil-visual-line)
  (let ((beg-line (line-number-at-pos beg))
        (end-line (line-number-at-pos end))
        (dest (+ (line-number-at-pos end) 0)))
    (evil-move beg end dest)
    (goto-line (+ beg-line 1))
    (exchange-point-and-mark)
    (goto-line (+ end-line 0))
    (evil-visual-line)
    )
  )

;;;###autoload
(evil-define-operator evil-move-left (beg end)
  :motion evil-line
  (interactive "<r>")
  (evil-visual-line)
  (evil-shift-left beg end 1)
  (evil-visual-line)
  )

;;;###autoload
(evil-define-operator evil-move-right (beg end)
  :motion evil-line
  (interactive "<r>")
  (evil-visual-line)
  (evil-shift-right beg end 1)
  (evil-visual-line)
  )

;;;###autoload
(defun evil-move-region-default-bindings ()
  "Bind `evil-move-up', `evil-move-down`, `evil-move-left' and `evil-move-right' to M-k, M-j, M-h and M-l respectively"
  (define-key evil-normal-state-map (kbd "M-k") 'evil-move-up)
  (define-key evil-normal-state-map (kbd "M-j") 'evil-move-down)
  (define-key evil-normal-state-map (kbd "M-h") 'evil-move-left)
  (define-key evil-normal-state-map (kbd "M-l") 'evil-move-right)
  )

(provide 'evil-move-region)
