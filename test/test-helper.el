;;; test-helper.el --- Test helper for helm-github-stars test suite.
;;
;; Author: Sliim <sliim@mailoo.org>
;; Version: 1.1.0

;; This file is not part of GNU Emacs.

;;; Commentary:

;; Test helper for helm-github-stars test suite.

;;; License:

;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License
;; as published by the Free Software Foundation; either version 3
;; of the License, or (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING. If not, write to the
;; Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
;; Boston, MA 02110-1301, USA.

;;; Code:

(defvar test-dir (file-name-directory load-file-name)
  "Test directory.")

(defvar root-dir (file-name-directory
                  (directory-file-name
                   test-dir))
  "Root directory.")

(defvar cache-test-file (expand-file-name "cache" test-dir)
  "Test file for cache tests.")

(require 'f)
(require 'helm-github-stars
         (expand-file-name "helm-github-stars.el" root-dir))

(defmacro with-cache (&rest body)
  "Evaluate TEST with cache interaction."
  `(let ((helm-github-stars-cache-file cache-test-file))
     (when (f-file? cache-test-file)
       (f-delete cache-test-file))
     ,@body
     (when (f-file? cache-test-file)
       (f-delete cache-test-file))))

;;Stubing
(defvar hgs-test/github-stars-response-stub
  ["[ {\"full_name\": \"star/1\"},{\"full_name\": \"star/2\"}]"
   "[ {\"full_name\": \"star/3\"}]"
   "[ ]"])

(defvar hgs-test/github-repos-response-stub
  ["[ {\"full_name\": \"repo/1\"},{\"full_name\": \"repo/2\"}]"
   "[ {\"full_name\": \"repo/3\"}]"
   "[ ]"])

(defvar hgs-test/cache-json-string
  "{\"repos\":[\"repo\\/1\", \"repo\\/2\", \"repo\\/3\"], \"stars\":[\"star\\/1\", \"star\\/2\", \"star\\/3\"]}")

(defvar hgs-test/repos-list
  ["repo/1" "repo/2" "repo/3"])

(defvar hgs-test/stars-list
  ["star/1" "star/2" "star/3"])

(defvar hgs-test/cache-hash-table
  (make-hash-table :test 'equal))

(puthash '"stars" hgs-test/stars-list hgs-test/cache-hash-table)
(puthash '"repos" hgs-test/repos-list hgs-test/cache-hash-table)

;;; test-helper.el ends here
