⍝ dyalog -script Entry_Level.apl

⍝ ← + - × ÷ * ⍟ ⌹ ○ ! ? | ⌈ ⌊ ⊥ ⊤ ⊣ ⊢ = ≠ ≤ < > ≥ ≡ ≢ ∨ ∧ ⍲ ⍱ ↑ ↓ ⊂ ⊃ ⊆ ⌷ ⍋ ⍒ 
⍝ ⍳ ⍸ ∊ ⍷ ∪ ∩ ~ / \ ⌿ ⍀ , ⍪ ⍴ ⌽ ⊖ ⍉ ¨ ⍨ ⍣ . ∘ ⍛ ⍤ ⍥ @ ⍞ ⎕ ⍠ ⌸ ⌺ ⌶ ⍎ ⍕ ⋄ → ⍵ ⍺ ∇
⍝ & ¯ ⍬ ∆ ⍙

⎕←'A function for calculating sum of all numbers in a matrix:'
⎕←Sum←{+/+/⍵}
⍝ Check
m←2 2 ⍴ 1 2 3 4 ⍝ A sample matrix
10≡Sum m
⍝ ------------------------------------------------------------------------------
⎕←'Improve implemented sum function to be able to handle array of any rank'
⍝ Modified reduction. Because possible rank is less or equal to 15
⎕←Sum←{+/+/+/+/+/+/+/+/+/+/+/+/+/+/+/⍵}
⍝ Check
10≡Sum m
m←5 2 12⍴26 16 22 17 21 44 25 22 23 44 41 33 43 36 47 49 30 22 57 20 45 60 43 22 44 21 58 57 17 43 47 17 43 26 53 23 29 19 23 38 53 47 38 22 40 57 35 26 37 27 53 26 29 46 25 26 30 20 32 16 56 55 25 47 38 27 39 59 20 28 42 25 21 57 55 44 16 54 26 16 55 56 45 45 16 55 26 20 27 55 36 39 43 38 50 16 27 23 56 41 53 60 39 47 44 47 17 28 24 35 61 26 22 35 24 20 31 35 47 37
4302≡Sum m
m←8
8≡Sum m
⍝ ------------------------------------------------------------------------------
⎕←'Write a function to find all occurrence indices of a given character in a string'
⎕←allIndicesOf←{(⍵=⍺)/⍳⍴⍵}
⍝ Check
s←'Panama is a canal between Atlantic and Pacific'
ch←'a'
2 4 6 11 14 16 30 36 41≡ch allIndicesOf s