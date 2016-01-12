install.packages("exams")

require(exams)
chapter1 <- c("Set1//SampleSpaces.Rnw", "Set1/BasicSets.Rnw", "Set1//CoinTossing.Rnw", "Set1//AdditionRuleProof.Rnw", "Set1//AdditionRule.Rnw")
exams2pdf(chapter1, n = 1, tdir = "/Users/phewson", dir = "/Users/phewson")