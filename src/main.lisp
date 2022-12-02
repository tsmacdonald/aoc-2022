(defpackage aoc-2022
  (:use :cl))
(in-package :aoc-2022)

;; Util
(defun slurp-lines (filepath)
  (with-open-file (in filepath)
    (loop for l = (read-line in nil) while l collecting l)))

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

;; Day 2
(defparameter +winners+ '((rock . scissors) (scissors . paper) (paper . rock)))

(defun winner-score (opp-move your-move)
  (if (eql opp-move your-move)
      3
      (if (member (cons opp-move your-move) +winners+ :test #'equal)
	  0
	  6)))

(defparameter +move->score+ '((rock . 1) (paper . 2) (scissors . 3)))
(defparameter +your-move->move+ '(("X" . rock) ("Y" . paper) ("Z" . scissors)))
(defparameter +opp-move->move+ '(("A" . rock) ("B" . paper) ("C" . scissors)))

(defun calculate-score (moves)
  (let ((opp-move  (cdr (assoc (first moves) +opp-move->move+ :test #'string=)))
	(your-move (cdr (assoc (second moves) +your-move->move+ :test #'string=))))
    (+ (cdr (assoc your-move +move->score+ :test #'eql))
       (winner-score opp-move your-move))))

(defun line->moves (line)
  (str:split " " line))

(defun day-2 ()
  (reduce #'+
	  (mapcar #'calculate-score
	       (mapcar #'line->moves (slurp-lines "../resources/day-2")))))
