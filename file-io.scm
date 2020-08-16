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
