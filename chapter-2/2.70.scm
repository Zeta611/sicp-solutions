;(load "huffman-deps.scm")
(load "2.68.scm")
(load "2.69.scm")

(define pairs
  '((A 2) (BOOM 1) (GET 2) (JOB 2) (NA 16) (SHA 3) (YIP 9) (WAH 1)))

(define lyrics
  '(Get a job
    Sha na na na na na na na na
    Get a job
    Sha na na na na na na na na
    Wah yip yip yip yip yip yip yip yip yip
    Sha boom))

; test code
(let ((huffman-tree (generate-huffman-tree pairs)))
  (let ((encoded-lyrics (encode lyrics huffman-tree)))
    (display-all
      "Generated Huffman encoding tree:\n"
      huffman-tree
      "\nEncoded lyrics:\n"
      encoded-lyrics
      "\nNumber of Huffman-encoded bits:\n"
      (length encoded-lyrics)
      "\nNumber of fixed-length code bits:\n"
      (* 3 (length lyrics)))))
(newline)
; Encoded lyrics:
; (1 1 1 1 1 1 1 0 0 1 1 1 1 0 1 1 1 0 0 0 0 0 0 0 0 0 1 1 1 1 1 1 1 0 0 1 1 1 1 0 1 1 1 0 0 0 0 0 0 0 0 0 1 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 1 1 0 1 1 0 1 1)
; The Number of Huffman-encoded bits is 84,
; whereas the number of fixed-length code bits is 108.
