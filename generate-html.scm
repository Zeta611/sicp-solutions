;;;; Utils
; Put `delim` after each element in list `l`.
(define (put-after delim l)
  (fold-right
    (lambda (hd tl)
      (cons hd (cons delim tl)))
    '()
    l))

(define (string-replace contents from to)
  (define (from->to contents)
    (string-replace contents from to))
  (let ((from-len (string-length from)))
    (cond ((string-null? contents) "")
          ((string-prefix? from contents)
           (string-append
             to
             (from->to (string-tail contents from-len))))
          (else
            (string-append
              (string-head contents 1)
              (from->to (string-tail contents 1)))))))

;;;; HTML Stuffs
(define html-decl "<!DOCTYPE html>")

(define (start tag)
  (string-append "<" (symbol->string tag) ">"))
(define (end tag)
  (string-append "</" (symbol->string tag) ">"))

(define (env tag . contents)
  (apply
    string-append
    (put-after
      "\n"
      (cons (start tag)
            (append contents
                    (list (end tag)))))))

; HTML tags
(define (html head body) (env 'html head body))
(define (head x) (env 'head x))
(define (title x) (env 'title x))
(define (body x) (env 'body x))
(define (p x) (env 'p x))
(define (i x) (env 'i x))
(define (tt x) (env 'tt x))
(define br (start 'br))

(define (html-document t b)
  (string-append
    html-decl
    "\n"
    (html
      (head (title t))
      (body b))))

(define (newline-><br> s)
  (string-replace s "\n" "<br>\n"))

(define (space->&nbsp s)
  (string-replace s " " "&nbsp;"))

;;;;; File I/O
; The list of all files in `directory`.
(define (files-in directory)
  (filter
    (lambda (path)
      (not (file-directory? path)))
    (directory-read directory)))

; The content of `file` as a character list.
(define (file->list file)
  (call-with-input-file
    file
    (lambda (input-port)
      (let loop ((x (read-char input-port)))
        (if (not (eof-object? x))
            (cons x
                  (loop (read-char input-port)))
            '())))))

; Read `file` as a string.
(define (read-file file)
  (list->string (file->list file)))

; Write `string` to `file`.
(define (write-file string file)
  (call-with-output-file
    file
    (lambda (output-port)
      (display string output-port))))

; test code
(define test-file
  (read-file
    (car (files-in "chapter-2/"))))

(define test-html
  (html-document
    "Sample HTML"
    (p (tt (space->&nbsp (newline-><br> test-file))))))

(write-file test-html "test-html.html")
