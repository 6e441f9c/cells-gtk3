#|

 Gtk ffi

 Copyright (c) 2009 by Jakub Higersberger <ramarren@gmail.com>

 You have the right to distribute and use this software as governed by 
 the terms of the Lisp Lesser GNU Public License (LLGPL):

    (http://opensource.franz.com/preamble.html)
 
 This program is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 Lisp Lesser GNU Public License for more details.
 
|#

(in-package :gtk-ffi)

;;;; Library loading

;;; note: on Intel Macs sbcl built from Macports has both unix and darwin features, also I think
;;; there is Quartz based GTK

(cffi:define-foreign-library :gobject
  (cffi-features:darwin "libgobject-2.0.dylib")
  (cffi-features:unix (:or "libgobject-2.0.so" "libgobject-2.0.so.0"))
  (cffi-features:windows "libgobject-2.0-0.dll"))

(cffi:define-foreign-library :glib
  (cffi-features:darwin "libglib-2.0.dylib")
  (cffi-features:unix (:or "libglib-2.0.so" "libglib-2.0.so.0"))
  (cffi-features:windows "libglib-2.0-0.dll"))

(cffi:define-foreign-library :gthread
  (cffi-features:darwin "libgthread-2.0.dylib")
  (cffi-features:unix (:or "libgthread-2.0.so" "libgthread-2.0.so.0"))
  (cffi-features:windows "libgthread-2.0-0.dll"))

(cffi:define-foreign-library :gdk
  (cffi-features:darwin "libgdk-x11-2.0.dylib")
  (cffi-features:unix (:or "libgdk-x11-2.0.so" "libgdk-x11-2.0.so.0"))
  (cffi-features:windows "libgdk-win32-2.0-0.dll"))

(cffi:define-foreign-library :gtk
  (cffi-features:darwin "libgtk-x11-2.0.dylib")
  (cffi-features:unix (:or "libgtk-x11-2.0.so" "libgtk-x11-2.0.so.0"))
  (cffi-features:windows "libgtk-win32-2.0-0.dll"))

#+libcellsgtk
(cffi:define-foreign-library :cgtk
  (cffi-features:darwin #.(merge-pathnames "libcellsgtk.dylib" *compile-file-pathname*))
  (cffi-features:unix #.(merge-pathnames "libcellsgtk.so" *compile-file-pathname*))
  (cffi-features:windows #.(merge-pathnames "libcellsgtk.dll" *compile-file-pathname*)))

;;; comment moved from gtk-ffi.lisp
;;; LW Win32 is hanging on POD's machine only:
;;; (fli:register-module "libgdk-win32-2.0-0.dll" :connection-style :immediate)
;;; (fli:register-module "c:\\Program Files\\Common Files\\GTK\\2.0\\bin\\libgdk-win32-2.0-0.dll" 
;;;                      :connection-style :immediate)

(defun load-gtk-libs ()
  (handler-bind ((style-warning #'muffle-warning))
    (cffi:load-foreign-library :gobject)
    (cffi:load-foreign-library :glib)
    (cffi:load-foreign-library :gthread)
    (cffi:load-foreign-library :gdk)
    (cffi:load-foreign-library :gtk)
    #+libcellsgtk (cffi:load-foreign-library :cgtk)))