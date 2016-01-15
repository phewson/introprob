install.packages("exams")

require(exams)
chapter2 <- c("Set1/SampleSpaces.Rnw", "Set1/BasicSets.Rnw", "Set1/CoinTossing.Rnw", 
            "Set1/Venns1.Rnw", "Set1/Venns2.Rnw")
exams2pdf(chapter2, n = 1, tdir = "dummy2")



chapter4 <- c("Comb1/CommitteeGender.Rnw", "Comb1/Committee.Rnw", "Comb1/Lottery.Rnw")
exams2pdf(chapter4, n = 1, tdir = "dummy4")

chapter5 <- c("Set1/AdditionRuleProof.Rnw", "Set1/AdditionRule.Rnw", "Set1/LoadedDie.Rnw", "Set1/Options.Rnw")
exams2pdf(chapter5, n = 1, tdir = "dummy5")


chapter6 <- c("Cond1/BayesRuleProof.Rnw", "Cond1/BonzoFonzoGonzo.Rnw", "Cond1/IoA1.Rnw",
              "Cond1/IoA2.Rnw", "Cond1/ThreeUrnsRed.Rnw", "Cond1/ThreeUrnsGreen(Conditional).Rnw",
              "Cond1/LifeTables.Rnw", "Cond1/LifeTables2.Rnw", "Cond1/LifeTables3.Rnw")
exams2pdf(chapter6, n = 1, tdir = "dummy6")

chapter78 <- c("DiscreteExamples/Varx.Rnw", "DiscreteExamples/ValidPMF.Rnw", "DiscreteExamples/Asthma.Rnw",
               "DiscreteExamples/Cookies.Rnw", "DiscreteExamples/DiceRollingTillSuccess.Rnw", "DiscreteExamples/DiceRollingTillSuccess.Rnw",
               "DiscreteExamples/GAM.Rnw", "DiscreteExamples/GAM2.Rnw", "DiscreteExamples/HouseRepairs.Rnw",
               "DiscreteExamples/RoadAccidents.Rnw", "DiscreteExamples/StudentCallout.Rnw")
exams2pdf(chapter78, n=1, tdir = "dummy7")

chapter9 <- c("ContinuousExamples/FindF.Rnw", "ContinuousExamples/StandardNormal.Rnw", 
              "ContinuousExamples/NonStandardNormal.Rnw","ContinuousExamples/CoffeeDispenser.Rnw",
              "ContinuousExamples/ExpCDF.Rnw", "ContinuousExamples/ExponentialConcept.Rnw", 
              "ContinuousExamples/ExpQuantile.Rnw","ContinuousExamples/BetaQuantile.Rnw")
exams2pdf(chapter9, n=1, tdir = "dummy9")

