#install.packages("exams")

#Create all the dummy folders needed
for (i in 1:12){
eval(parse(text = paste("dir.create(\"dummy",i, "\")", sep = "")))
}

require(exams)
chapter2 <- c("Set1/SampleSpaces.Rnw", "Set1/CoinTossing.Rnw", 
            "Set1/Venns1.Rnw", "Set1/Venns2.Rnw")#, "Set1/DeMorgan.Rnw")
exams2pdf(chapter2, n = 1, tdir = "dummy2", verbose=TRUE)
exams2moodle(chapter2, n=5)

chapter2m <- c("Set1/CoinTossing.Rnw", 
"Set1/Venns1.Rnw", "Set1/Venns2.Rnw")
exams2moodle(chapter2m, n=5)

chapter3 <- c("Set1/ValidProb.Rnw", "Naive/family.Rnw")
exams2pdf(chapter3, n=1, tdir = "dummy3")
exams2moodle(chapter3, n=5)


chapter4 <- c("Comb1/CommitteeGender.Rnw", "Comb1/Committee.Rnw", "Comb1/Lottery.Rnw",
              "Comb1/AngelinaJolie.Rnw", "Comb1/AngelinaJolie2.Rnw", "Comb1/AngelinaJolie3.Rnw", "Comb1/AngelinaJolie4.Rnw")
exams2pdf(chapter4, n = 1, tdir = "dummy4")
exams2moodle(chapter4, n=5)


chapter5 <- c("Set1/AdditionRuleProof.Rnw", "Set1/AdditionRule.Rnw", "Set1/LoadedDie.Rnw", 
              "Set1/Options.Rnw", "Set1/BasicSets.Rnw", "Set1/WhichTyre1.Rnw", "Set1/WhichTyre2.Rnw")
exams2pdf(chapter5, n = 1, tdir = "dummy5")
exams2moodle(chapter5, n=5)

chapter6 <- c("Cond1/BayesRuleProof.Rnw", "Cond1/BonzoFonzoGonzo.Rnw", "Cond1/IoA1.Rnw",
              "Cond1/IoA2.Rnw", "Cond1/ThreeUrnsRed.Rnw", "Cond1/ThreeUrnsGreen(Conditional).Rnw",
              "Cond1/LifeTables.Rnw", "Cond1/LifeTables2.Rnw", "Cond1/LifeTables3.Rnw")

chapter6M1 <- c("Cond1/ThreeUrnsRed.Rnw",
              "Cond1/LifeTables.Rnw", "Cond1/LifeTables2.Rnw", "Cond1/LifeTables3.Rnw")

chapter6M2 <- c( "Cond1/BonzoFonzoGonzo.Rnw", "Cond1/IoA1.Rnw",
                 "Cond1/IoA2.Rnw", "Cond1/ThreeUrnsGreen(Conditional).Rnw")

exams2moodle(chapter6M1, n=5)
exams2moodle("Cond1/BayesRuleProof.Rnw", n = 5)
exams2moodle(chapter6M2, n=5)

exams2pdf(chapter6, n = 1, tdir = "dummy6")


chapter8 <- c("DiscreteExamples/Varx.Rnw", "Exp/RiggedDie.Rnw", "Exp/JamesBond.Rnw", "Exp/Forecourt.Rnw")
exams2pdf(chapter8, n=1, tdir = "dummy8")
exams2moodle(chapter8, n= 5)
exams2moodle("Exp/JamesBond.Rnw", n = 5)
exams2pdf("Exp/Forecourt.Rnw")
exams2moodle("Exp/Forecourt.Rnw", n = 10)

chapter9 <- c("DiscreteExamples/Asthma.Rnw",
              "DiscreteExamples/Cookies.Rnw", "DiscreteExamples/DiceRollingTillSuccess.Rnw",
              "DiscreteExamples/GAM.Rnw", "DiscreteExamples/GAM2.Rnw", "DiscreteExamples/HouseRepairs.Rnw",
              "DiscreteExamples/RoadAccidents.Rnw", "DiscreteExamples/StudentCallout.Rnw",
              "DiscreteExamples/LogarithmicConstant.Rnw", "DiscreteExamples/LogarithmicEX.Rnw",
              "DiscreteExamples/LogarithmicVar.Rnw", "DiscreteExamples/LogarithmicCDF.Rnw")
exams2pdf(chapter9, n=1, tdir = "dummy9")
exams2moodle(chapter9, n = 5)
exams2moodle("DiscreteExamples/LogarithmicCDF.Rnw", n=5)


chapter10 <- c("ContinuousExamples/WhichDefinition.Rnw", "ContinuousExamples/ConstantInt.Rnw", "ContinuousExamples/FindF.Rnw", "ContinuousExamples/StandardNormal.Rnw", 
              "ContinuousExamples/NonStandardNormal.Rnw","ContinuousExamples/CoffeeDispenser.Rnw",
              "ContinuousExamples/ExpCDF.Rnw", "ContinuousExamples/ExponentialConcept.Rnw", 
              "ContinuousExamples/ExpQuantile.Rnw","ContinuousExamples/BetaQuantile.Rnw", 
              "ContinuousExamples/Pareto.Rnw", "ContinuousExamples/ParetoQuantile.Rnw", "ContinuousExamples/Rayleigh.Rnw",
              "ContinuousExamples/RayleighQuantile.Rnw")
              
exams2pdf(chapter10, n=1, tdir = "dummy10")
require(exams)
concepts <- c("ContinuousExamples/WhichDefinition.Rnw", "ContinuousExamples/ExponentialConcept.Rnw")

problem2 <- c("ContinuousExamples/ConstantInt.Rnw", "ContinuousExamples/FindF.Rnw",
              "ContinuousExamples/ExpCDF.Rnw", "ContinuousExamples/ExpQuantile.Rnw",
              "ContinuousExamples/Pareto.Rnw", "ContinuousExamples/ParetoQuantile.Rnw",
              "ContinuousExamples/Rayleigh.Rnw", "ContinuousExamples/RayleighQuantile.Rnw")
exams2moodle(concepts, n=5)
exams2moodle(problem2, n=5)

require(exams)
final <- c("ContinuousExamples/StandardNormal.Rnw", "ContinuousExamples/NonStandardNormal.Rnw",
           "ContinuousExamples/CoffeeDispenser.Rnw", "ContinuousExamples/BetaQuantile.Rnw")
exams2pdf(final)
exams2moodle(final, n=5)
0.036