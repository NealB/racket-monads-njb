#lang racket
(require racket/control)
(require racket-monads-njb/state racket-monads-njb/option racket-monads-njb/writer racket-utilities-njb/utilities-dev)

;(define-syntax-rule (~>> exprs ...)
 ; (reset (let () exprs ...)))

(define-namespace-anchor nsa)
(define ns (namespace-anchor->namespace nsa))

(define-syntax-rule (~>> arg ...)
  (State-run
   (reset
    (let*
        ((x (shift k (State-bind (State-modify (procedurize arg)) k))) ...)
      x))
   #f))

;; testing...................
(module+ main
  
  (define results
    (~>> 5
         add1
         (curry * 10)
         (curry + 55)))


  (display "results: ")
  (pretty-print results)
  (display "done\n")

  (eval `(define results ,results) ns))

(provide ~>>)

  
