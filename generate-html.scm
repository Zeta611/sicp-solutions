(load "./utils.scm")
(load "./file-io.scm")

;;;; HTML Stuffs
(define html-decl "<!DOCTYPE html>")

(define (start tag)
  (string-append "<" (symbol->string tag) ">"))
(define (end tag)
  (string-append "</" (symbol->string tag) ">"))

(define (env tag . contents)
  (string-append (start tag)
                 "\n"
                 (apply string-append
                        (put-between "\n" contents))
                 "\n"
                 (end tag)))

; HTML tags
(define (html head body) (env 'html head body))
(define (head x) (env 'head x))
(define (title x) (env 'title x))
(define (body x) (env 'body x))
(define (p x) (env 'p x))
(define (i x) (env 'i x))
(define (code x) (env 'code x))
(define (pre x) (env 'pre x))
(define br (start 'br))

(define (html-document t b)
  (string-append
    html-decl
    "\n"
    (html
      (head (title t))
      (body b))
    "\n"))

; test code
(define test-file
  (read-file
    (car (files-in "chapter-2/"))))

(define test-html
  (html-document
    "Sample HTML"
    (p (code (pre test-file)))))

(write-file test-html "test-html.html")
