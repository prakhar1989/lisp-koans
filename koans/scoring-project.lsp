;;   Copyright 2013 Google Inc.
;;
;;   Licensed under the Apache License, Version 2.0 (the "License");
;;   you may not use this file except in compliance with the License.
;;   You may obtain a copy of the License at
;;
;;       http://www.apache.org/licenses/LICENSE-2.0
;;
;;   Unless required by applicable law or agreed to in writing, software
;;   distributed under the License is distributed on an "AS IS" BASIS,
;;   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
;;   See the License for the specific language governing permissions and
;;   limitations under the License.


;;;;;;;;;;;;;;
;; GREED !! ;;
;;;;;;;;;;;;;;


;; Modified from Ruby Koans: about_scoring_project.rb

; *Greed* is a dice game where you roll up to five dice to accumulate
; points.  The following "score" function will be used to calculate the
; score of a single roll of the dice.
;
; A greed roll is scored as follows:
;
; * A set of three ones is 1000 points
;
; * A set of three numbers (other than ones) is worth 100 times the
;   number. (e.g. three fives is 500 points).
;
; * A one (that is not part of a set of three) is worth 100 points.
;
; * A five (that is not part of a set of three) is worth 50 points.
;
; * Everything else is worth 0 points.
;
;
; Examples:
;
; (score '(1 1 1 5 1)) => 1150 points
; (score '(2 3 4 6 2)) => 0 points
; (score '(3 4 5 3 3)) => 350 points
; (score '(1 5 1 2 4)) => 250 points
;
; More scoring examples are given in the tests below:
;
; Your goal is to write the score method.

(defun count-num (n xs)
  (let ((count 0))
    (loop for x in xs when (equal x n)
       do (setf count (1+ count)))
    count))

					;
;; 1. get the counts of each number?
;; 2. check the number of 1s. update count of 1s accordingly
;; 3. do for other numbers as well
(defun score (dice)
  (let* ((total 0)
	 (loop-result (loop for x in '(1 2 3 4 5 6)
			 collect (count-num x dice)))
	 (counts (make-array 6 :initial-contents loop-result)))
    ;; check for count >= 3
    (loop for x in '(1 2 3 4 5 6)
       do (let ((c (aref counts (1- x))))
	    (when (> c 2)
	      (setf (aref counts (1- x)) (- c 3))
	      (if (equal 1 x)
		  (setf total (+ total 1000))
		  (setf total (+ total (* 100 x)))))))
    ;; one-off checks for 1 and 5
    (+ total (* 100 (aref counts 0)) (* 50 (aref counts 4)))))

(define-test test-score-of-an-empty-list-is-zero
    (assert-equal 0 (score nil)))

(define-test test-score-of-a-single-roll-of-5-is-50
    (assert-equal 50 (score '(5))))


(define-test test-score-of-a-single-roll-of-1-is-100
    (assert-equal 100 (score '(1))))

(define-test test-score-of-multiple-1s-and-5s-is-the-sum-of-individual-scores
    (assert-equal 300 (score '(1 5 5 1))))

(define-test test-score-of-single-2s-3s-4s-and-6s-are-zero
    (assert-equal 0 (score '(2 3 4 6))))


(define-test test-score-of-a-triple-1-is-1000
    (assert-equal 1000  (score '(1 1 1))))

(define-test test-score-of-other-triples-is-100x
    (assert-equal 200  (score '(2 2 2)))
    (assert-equal 300  (score '(3 3 3)))
    (assert-equal 400  (score '(4 4 4)))
    (assert-equal 500  (score '(5 5 5)))
    (assert-equal 600  (score '(6 6 6))))

(define-test test-score-of-mixed-is-sum
    (assert-equal 250  (score '(2 5 2 2 3)))
    (assert-equal 550  (score '(5 5 5 5))))
