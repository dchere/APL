⍝ dyalog -script november25.apl
⍝ A set of daily coding challenges from www.freecodecamp.org

⍝ ← + - × ÷ * ⍟ ⌹ ○ ! ? | ⌈ ⌊ ⊥ ⊤ ⊣ ⊢ = ≠ ≤ < > ≥ ≡ ≢ ∨ ∧ ⍲ ⍱ ↑ ↓ ⊂ ⊃ ⊆ ⌷ ⍋ ⍒ 
⍝ ⍳ ⍸ ∊ ⍷ ∪ ∩ ~ / \ ⌿ ⍀ , ⍪ ⍴ ⌽ ⊖ ⍉ ¨ ⍨ ⍣ . ∘ ⍛ ⍤ ⍥ @ ⍞ ⎕ ⍠ ⌸ ⌺ ⌶ ⍎ ⍕ ⋄ → ⍵ ⍺ ∇
⍝ & ¯ ⍬ ∆ ⍙

Assert←{⍺≡⍵:0 ⋄ ⎕←⍺ (≡⍺) (⍴¨⍺) ⋄ ⎕←⍵ (≡⍵) (⍴¨⍵) ⋄ ⎕SIGNAL 11} ⍝ Custom assert function for testing

⍝ ------------------------------------------------------------------------------
⎕←'Signature Validation'
⍝ Given a message string, a secret key string, and a signature number, determine
⍝ if the signature is valid using this encoding method:
⍝ Letters in the message and secret key have these values:
⍝ a to z have values 1 to 26 respectively.
⍝ A to Z have values 27 to 52 respectively.
⍝ All other characters have no value.
⍝ Compute the signature by taking the sum of the message plus the sum of the secret key.
⍝ For example, given the message "foo" and the secret key "bar", the signature would be 57:
⍝ f (6) + o (15) + o (15) = 36
⍝ b (2) + a (1) + r (18) = 21
⍝ 36 + 21 = 57
⍝ Check if the computed signature matches the provided signature.
verify←{
    msg key sig ← ⍵
    characters ← 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'
    value←{+/characters⍳(⍵∊characters)/⍵}
    sig=+/value¨msg key
}
1 Assert verify 'foo' 'bar' 57
0 Assert verify 'foo' 'bar' 54
1 Assert verify 'freeCodeCamp' 'Rocks' 238
0 Assert verify 'Is this valid?' 'No' 210
1 Assert verify 'Is this valid?' 'Yes' 233
1 Assert verify 'Check out the freeCodeCamp podcast,' 'in the mobile app' 514
⍝ ------------------------------------------------------------------------------
