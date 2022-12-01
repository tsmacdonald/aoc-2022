(defpackage aoc-2022
  (:use :cl))
(in-package :aoc-2022)

;; Day 1
(defun max-calories (provisions)
  (let ((total 0)
	(max   0))
    (loop for calories in provisions
	  do (if calories
		 (progn
		   (incf total calories)
		   (when (> total max) (setf max total)))
		 (setf total 0)))
    max))

(defun foods->calorie-counts (food-list)
  (reduce (lambda (tally-cons calories)
	    (if calories
		(cons (+ (car tally-cons) calories)
		      (cdr tally-cons))
		(cons 0
		      (cons (car tally-cons) (cdr tally-cons)))))
	  food-list
	  :initial-value (cons 0 '())))

(defun max-n-calories (n provisions)
  ;; Would be nicer with a priority queue
  (subseq (sort provisions #'>) 0 n))

(defun day-1 ()
  (with-open-file (in "../resources/day-1")
    (reduce #'+
	    (max-n-calories
	     3
	     (foods->calorie-counts
	      (loop for l = (read-line in nil)
		    while l collecting (parse-integer l :junk-allowed t)))))))
