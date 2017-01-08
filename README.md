Lisp Koans
-------
Working through [Google's Common Lisp](https://github.com/google/lisp-koans) koans.

Getting Started
---------------

From a terminal, execute your lisp interpreter on the file 'contemplate.lsp' e.g.

    sbcl --script contemplate.lsp

Running on a fresh version should output the following:

```
Thinking about ASSERTS
    ASSERT-TRUE requires more meditation.

You have not yet reached enlightenment ...
  A koan is incomplete.

Please meditate on the following code:
   File "koans/asserts.lsp"
   Koan "ASSERT-TRUE"
   Current koan assert status is "(INCOMPLETE)"

You are now 0/169 koans and 0/25 lessons closer to reaching enlightenment
```

This indicates that the script has completed, and that the learner should look
to asserts.lsp to locate and fix the problem.  The problem will be within 
a define-test expression such as

    (define-test assert-true
        "t is true.  Replace the blank with a t"
        (assert-true ___))

In this case, the test is incomplete, and the student should fill 
in the blank (____) with appropriate lisp code to make the assert pass.


In order to test code, or evaluate tests interactively, students may copy
and paste code into the lisp command line REPL.
