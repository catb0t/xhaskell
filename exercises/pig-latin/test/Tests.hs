import Test.Hspec        (Spec, describe, it, shouldBe)
import Test.Hspec.Runner (configFastFail, defaultConfig, hspecWith)

import PigLatin (translate)

main :: IO ()
main = hspecWith defaultConfig {configFastFail = True} specs

specs :: Spec
specs = describe "pig-latin" $
          describe "translate" $ do

    -- Test cases adapted from `exercism/x-common/pig-latin.json` on 2016-09-08.

    describe "ay is added to words that start with vowels" $ do
        it "word beginning with a" $ translate "apple"  `shouldBe` "appleay"
        it "word beginning with e" $ translate "ear"    `shouldBe` "earay"
        it "word beginning with i" $ translate "igloo"  `shouldBe` "iglooay"
        it "word beginning with o" $ translate "object" `shouldBe` "objectay"
        it "word beginning with u" $ translate "under"  `shouldBe` "underay"

    describe "first letter and ay are moved to the end of words that start with consonants" $ do
        it "word beginning with p" $ translate "pig"    `shouldBe` "igpay"
        it "word beginning with k" $ translate "koala"  `shouldBe` "oalakay"
        it "word beginning with y" $ translate "yellow" `shouldBe` "ellowyay"
        it "word beginning with x" $ translate "xenon"  `shouldBe` "enonxay"
        it "word beginning with q without a following u" $ translate "qat" `shouldBe` "atqay"

    describe "some letter clusters are treated like a single consonant" $ do
        it "word beginning with ch"  $ translate "chair"   `shouldBe` "airchay"
        it "word beginning with qu"  $ translate "queen"   `shouldBe` "eenquay"
        it "word beginning with qu and a preceding consonant" $ translate "square" `shouldBe` "aresquay"
        it "word beginning with th"  $ translate "therapy" `shouldBe` "erapythay"
        it "word beginning with thr" $ translate "thrush"  `shouldBe` "ushthray"
        it "word beginning with sch" $ translate "school"  `shouldBe` "oolschay"

    describe "some letter clusters are treated like a single vowel" $ do
        it "word beginning with yt" $ translate "yttria" `shouldBe` "yttriaay"
        it "word beginning with xr" $ translate "xray"   `shouldBe` "xrayay"

    describe "phrases are translated" $ do
        it "a whole phrase" $ translate "quick fast run" `shouldBe` "ickquay astfay unray"
