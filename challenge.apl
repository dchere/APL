⍝ dyalog -script challenge.apl
⍝ A set of APL coding challenge from Dyalog Ltd.

⍝ ← + - × ÷ * ⍟ ⌹ ○ ! ? | ⌈ ⌊ ⊥ ⊤ ⊣ ⊢ = ≠ ≤ < > ≥ ≡ ≢ ∨ ∧ ⍲ ⍱ ↑ ↓ ⊂ ⊃ ⊆ ⌷ ⍋ ⍒ 
⍝ ⍳ ⍸ ∊ ⍷ ∪ ∩ ~ / \ ⌿ ⍀ , ⍪ ⍴ ⌽ ⊖ ⍉ ¨ ⍨ ⍣ . ∘ ⍛ ⍤ ⍥ @ ⍞ ⎕ ⍠ ⌸ ⌺ ⌶ ⍎ ⍕ ⋄ → ⍵ ⍺ ∇
⍝ & ¯ ⍬ ∆ ⍙

Assert←{⍺≡⍵:0 ⋄ ⎕←⍺ (≡⍺) (⍴¨⍺) ⋄ ⎕←⍵ (≡⍵) (⍴¨⍵) ⋄ ⎕SIGNAL 11} ⍝ Custom assert function for testing

⍝ ------------------------------------------------------------------------------
⎕←'Wolfram Rules'
⍝ You will be writing the code for rules invented by Stephen Wolfram. Each set
⍝ of rules shows how to change a list of 0s and 1s into a new list of the same
⍝ length, again only with 0s and 1s. For every number in the given list, you
⍝ need to look at it together with its neighbours to the left and right, then
⍝ check whether this triplet of numbers exists in a given list of triplets. If
⍝ found, that number becomes a 1. Otherwise it becomes a 0. Consider the first
⍝ number to have an invisible 0 on its left and the last number to have an
⍝ invisible 0 on its right.
⍝ Write a function that takes a rule set and an initial list, and then
⍝ calculates a new list based on those. The rule set will be the left argument,
⍝ and is a list of lists of 0s and 1s. The initial list is the right argument,
⍝ and is a simple list of 0s and 1s. For example:
⍝     (1 1 0) (1 0 0) (0 1 1) (0 0 1) {answer} 0 1 1 0 1
⍝ 1 1 1 0 0
⍝ Here are the reasons for the numbers in the result:
⍝ 1 because 0 has the triplet 0 0 1 (invisible 0 on the left) which is found in the rule set
⍝ 1 because 1 has the triplet 0 1 1 which is found in the rule set
⍝ 1 because 1 has the triplet 1 1 0 which is found in the rule set
⍝ 0 because 0 has the triplet 1 0 1 which is not found in the rule set
⍝ 0 because 0 has the triplet 0 1 0 (invisible 0 on the right) which is not found in the rule set
wolfram←{(3 ,/0,⍵,0)∊⍺}
1 1 1 1 1 0 1 1 Assert (1 0 0) (0 1 1) (0 1 0) (0 0 1) wolfram 0 1 0 0 1 0 1 0
0 0 0 1 1 Assert (1 1 0) (1 0 1) (0 1 1) (0 1 0) (0 0 1) wolfram 0 0 0 0 1
0 0 1 1 1 Assert (1 1 0) (1 0 1) (0 1 1) (0 1 0) (0 0 1) wolfram 0 0 0 1 1
0 1 1 0 1 Assert (1 1 0) (1 0 1) (0 1 1) (0 1 0) (0 0 1) wolfram 0 0 1 1 1
1 1 1 1 1 Assert (1 1 0) (1 0 1) (0 1 1) (0 1 0) (0 0 1) wolfram 0 1 1 0 1
⍝ ------------------------------------------------------------------------------
⎕←'DNA'
⍝ Genes are grouped into codons which are three DNA letters in a row. Reading
⍝ can begin at any point in the DNA code, so to find all possible codons, you
⍝ need to read three letters starting from every base, except the last two.
⍝ For example, the DNA string 'ACCTGGCCT' has the following possible codons:
⍝ 'ACC'
⍝ 'CCT'
⍝ 'CTG'
⍝ 'TGG'
⍝ 'GGC'
⍝ 'GCC'
⍝ 'CCT'
⍝ Note that there can be duplicate codons, and the number of codons is smaller
⍝ than the number of given DNA letters.
⍝ You need to write a function that takes a DNA string and gives all the possible
⍝ codons. For example:
codons←{3 ,/⍵}
'GTT' 'TTT' 'TTC' 'TCG' 'CGG' 'GGT' 'GTG' Assert codons 'GTTTCGGTG'
'CCC' 'CCA' 'CAC' 'ACT' Assert codons 'CCCACT'
'GAT' 'ATT' 'TTA' 'TAC' 'ACA' Assert codons 'GATTACA'
⍝ ------------------------------------------------------------------------------
