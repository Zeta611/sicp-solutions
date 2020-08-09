;(load "huffman-deps.scm")
(load "2.67.scm")

(define (encode message tree)
  (if (null? message)
      '()
      (append (encode-symbol (car message) tree)
              (encode (cdr message) tree))))

(define (encode-symbol symbol tree)
  ; car is an encoded bit and cdr is the selected branch
  (define (choose-branch branch)
    (let ((left (left-branch branch))
          (right (right-branch branch)))
      (if (memq symbol (symbols branch))
          (if (memq symbol (symbols left))
              (cons 0 left)
              (cons 1 right))
          (error "unknown symbol -- ENCODE-SYMBOL" symbol))))
  (let ((pair (choose-branch tree)))
    (let ((bit (car pair))
          (next-branch (cdr pair)))
      (if (leaf? next-branch)
          (list bit)
          (cons bit
                (encode-symbol symbol next-branch))))))

(define (display-all . args)
  (for-each display args))

; test code
(let ((decoded (decode sample-message sample-tree)))
  (let ((encoded (encode decoded sample-tree)))
    (if (equal? sample-message encoded)
        (display "Successfully encoded!\n")
        (display-all "Wrong! Got\n"
                     encoded
                     "\nbut\n"
                     sample-message
                     "\nexpected."))))
