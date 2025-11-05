⍝ dyalog -script november25.apl
⍝ A set of daily coding challenges from www.freecodecamp.org

⍝ ← + - × ÷ * ⍟ ⌹ ○ ! ? | ⌈ ⌊ ⊥ ⊤ ⊣ ⊢ = ≠ ≤ < > ≥ ≡ ≢ ∨ ∧ ⍲ ⍱ ↑ ↓ ⊂ ⊃ ⊆ ⌷ ⍋ ⍒ 
⍝ ⍳ ⍸ ∊ ⍷ ∪ ∩ ~ / \ ⌿ ⍀ , ⍪ ⍴ ⌽ ⊖ ⍉ ¨ ⍨ ⍣ . ∘ ⍛ ⍤ ⍥ @ ⍞ ⎕ ⍠ ⌸ ⌺ ⌶ ⍎ ⍕ ⋄ → ⍵ ⍺ ∇
⍝ & ¯ ⍬ ∆ ⍙

Assert←{⍺≡⍵:0 ⋄ ⎕←⍺ (≡⍺) (⍴¨⍺) ⋄ ⎕←⍵ (≡⍵) (⍴¨⍵) ⋄ ⎕SIGNAL 11} ⍝ Custom assert function for testing

⍝ ------------------------------------------------------------------------------
⎕←'Matrix Builder'
⍝ Given two integers (a number of rows and a number of columns), return a matrix
⍝ filled with zeros (0) of the given size.
build_matrix←{⍵⍴0}
(2 3 ⍴ 0) Assert build_matrix 2 3
(3 2 ⍴ 0) Assert build_matrix 3 2
(4 3 ⍴ 0) Assert build_matrix 4 3
(9 1 ⍴ 0) Assert build_matrix 9 1
⍝ ------------------------------------------------------------------------------
⎕←'Image Search'
⍝ Given an array of image names and a search term, return an array of image
⍝ names containing the search term.
⍝ Ignore the case when matching the search terms.
⍝ Return the images in the same order they appear in the input array.
image_search←{
    files pattern←⍵
    upper←'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
    lower←'abcdefghijklmnopqrstuvwxyz'
    ((pattern∊upper)/pattern)←lower[upper⍳(pattern∊upper)/pattern]
    lower_case_files←{
        w←⍵
        ((w∊upper)/w)←lower[upper⍳(w∊upper)/w]
        w
        }¨files
    lx←{(⊂pattern)∊(⊃⍴pattern) ,/⍵}¨lower_case_files
    lx/files
}
(1⍴⊂'dog.png') Assert image_search ('dog.png' 'cat.jpg' 'parrot.jpeg') 'dog'
'Sunset.jpg' 'sunflower.jpeg' Assert image_search ('Sunset.jpg' 'Beach.png' 'sunflower.jpeg') 'sun'
'Moon.png' 'stars.png' Assert image_search ('Moon.png' 'sun.jpeg' 'stars.png') 'PNG'
'cat.jpg' 'kitty-cat.png' 'catNip.jpeg' 'franken_cat.gif' Assert image_search ('cat.jpg' 'dogToy.jpeg' 'kitty-cat.png' 'catNip.jpeg' 'franken_cat.gif') 'Cat'
⍝ ------------------------------------------------------------------------------
⎕←'Word Counter'
⍝ Given a sentence string, return the number of words that are in the sentence.
⍝ Words are any sequence of non-space characters and are separated by a single space.
count_words←{ ⊃⍴(' '(,⊂⍨⊣=,)⊢)⍵ }
2 Assert count_words 'Hello world'
9 Assert count_words 'The quick brown fox jumps over the lazy dog.'
4 Assert count_words 'I like coding challenges!'
7 Assert count_words 'Complete the challenge in JavaScript and Python.'
7 Assert count_words 'The missing semi-colon crashed the entire internet.'
⍝ ------------------------------------------------------------------------------
⎕←'Infected'
⍝ On November 2nd, 1988, the first major internet worm was released, infecting
⍝ about 10% of computers connected to the internet after only a day.
⍝ In this challenge, you are given a number of days that have passed since an
⍝ internet worm was released, and you need to determine how many computers are
⍝ infected using the following rules:
⍝ On day 0, the first computer is infected.
⍝ Each subsequent day, the number of infected computers doubles.
⍝ Every 3rd day, a patch is applied after the virus spreads and reduces the
⍝ number of infected computers by 20%. Round the number of patched computers up
⍝ to the nearest whole number.
⍝ For example, on:
⍝ Day 0: 1 total computer is infected.
⍝ Day 1: 2 total computers are infected.
⍝ Day 2: 4 total computers are infected.
⍝ Day 3: 8 total computers are infected. Then, apply the patch: 8 infected * 20%
⍝ = 1.6 patched. Round 1.6 up to 2. 8 computers infected - 2 patched = 6 total
⍝ computers infected after day 3.
⍝ Return the number of total infected computers after the given amount of days
⍝ have passed.
infected←{
    days←⍵
    new_day←{
        a←⍺×2
        a←(a (a-⌈0.2×a))[1+0=3|⍵]
        (⍵=days): a
        a new_day ⍵+1
        }
    1 new_day 1
}
2 Assert infected 1
6 Assert infected 3
152 Assert infected 8
39808 Assert infected 17
5217638 Assert infected 25
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
