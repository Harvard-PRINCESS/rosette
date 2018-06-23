#lang racket

(require "env.rkt")

(provide array array-var array-make!
         assert-array-declare assert-array-declare?
         assert-array-select assert-array-select?
         assert-array-store assert-array-store?)

; array handle structure
; var is the array's smtlib2 name
(struct array (var))

(define count 0)

; array names are prefixed with arr since this is not used by enc or env
(define (ref-next-array!)
  (writeln (format "next count is ~a" (+ count 1)))
  (set! count (+ count 1))
  (format "arr~a" count))

; return fresh array handle
(define (array-make!)
  (array (ref-next-array!)))

; array assertion structures
(struct assert-array-declare (arr))
(struct assert-array-select (arr idx val))
(struct assert-array-store (arr idx val new-arr))

#|
; add an array def to the solver stack (we have no env management)
(define (solver-array-declare solver)
  (define new-array (array-make!))
  (solver-assert solver (assert-array-declare new-array))
  new-array)

; add (assert (eq? value (select array index)))
(define (solver-array-select solver array index value)
  (solver-assert solver (assert-array-select array index value)))

; return fresh array handle that will be eq? (store array index value)
(define (solver-array-store solver array index value)
  (define new-array (solver-array-declare solver))
  (solver-assert solver (assert-array-store array index new-array))
  new-array)
|#

