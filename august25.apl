⍝ dyalog -script august.apl

⍝ ← + - × ÷ * ⍟ ⌹ ○ ! ? | ⌈ ⌊ ⊥ ⊤ ⊣ ⊢ = ≠ ≤ < > ≥ ≡ ≢ ∨ ∧ ⍲ ⍱ ↑ ↓ ⊂ ⊃ ⊆ ⌷ ⍋ ⍒ 
⍝ ⍳ ⍸ ∊ ⍷ ∪ ∩ ~ / \ ⌿ ⍀ , ⍪ ⍴ ⌽ ⊖ ⍉ ¨ ⍨ ⍣ . ∘ ⍛ ⍤ ⍥ @ ⍞ ⎕ ⍠ ⌸ ⌺ ⌶ ⍎ ⍕ ⋄ → ⍵ ⍺ ∇
⍝ & ¯ ⍬ ∆ ⍙

Assert←{⍺≡⍵:0 ⋄ ⎕SIGNAL 11}  ⍝ Custom assert function for testing

⍝ ------------------------------------------------------------------------------
⎕←'Vowel Balance'
⍝ Given a string, determine whether the number of vowels in the first half of
⍝ the string is equal to the number of vowels in the second half.
⍝ The string can contain any characters.
⍝ The letters a, e, i, o, and u, in either uppercase or lowercase, are
⍝ considered vowels.
⍝ If there's an odd number of characters in the string, ignore the center
⍝ character
is_balanced←{
    vowels←'aeiouAEIOU'
    n←⌊.5×⍴⍵
    (+/(n↑⍵)∊vowels)=+/((-n)↑⍵)∊vowels
}
1 Assert is_balanced 'racecar'
1 Assert is_balanced 'Lorem Ipsum'
0 Assert is_balanced 'Kitty Ipsum'
0 Assert is_balanced 'string'
1 Assert is_balanced ' '
0 Assert is_balanced 'abcdefghijklmnopqrstuvwxyz'
1 Assert is_balanced '123A#b!E&*456-o.U'
