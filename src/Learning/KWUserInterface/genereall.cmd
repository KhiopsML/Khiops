@echo off

echo. > genere.log

rem Dans la plus cas, on ne genere que les classe de type vue, les classe de type modele etant geree par ailleur

genere -nomodel -noarrayview KWDatabase "Database" KWDatabase.dd >> genere.log

genere -nomodel -super KWDatabase -noarrayview KWSTDatabaseTextFile "Database" KWSTDatabaseTextFile.dd >> genere.log

genere -nomodel -super KWDatabase -noarrayview KWMTDatabaseTextFile "Database" KWMTDatabaseTextFile.dd >> genere.log

genere -nomodel KWMTDatabaseMapping "Multi-table mapping" KWMTDatabaseMapping.dd >> genere.log

genere -noarrayview KWClassManagement "Dictionary management" KWClassManagement.dd >> genere.log

genere KWClassSpec "Dictionary" KWClassSpec.dd >> genere.log

genere KWAttributeSpec "Variable" KWAttributeSpec.dd >> genere.log

genere -nomodel KWAttributeName "Variable" KWAttributeName.dd >> genere.log

genere -nomodel KWAttributePairName "Variable pair" KWAttributePairName.dd >> genere.log

genere KWEvaluatedPredictorSpec "Evaluated predictor" KWEvaluatedPredictorSpec.dd >> genere.log

genere -nomodel KWPreprocessingSpec "Preprocessing parameters" KWPreprocessingSpec.dd >> genere.log

genere -nomodel -noarrayview KWDiscretizerSpec "Discretization" KWDiscretizerSpec.dd >> genere.log

genere -nomodel -noarrayview KWGrouperSpec "Value grouping" KWGrouperSpec.dd >> genere.log

genere -nomodel -noarrayview KWDataGridOptimizerParameters "Data Grid optimization" KWDataGridOptimizerParameters.dd >> genere.log

genere -nomodel KWBenchmarkSpec "Benchmark" KWBenchmarkSpec.dd >> genere.log

genere -nomodel -noarrayview KWLearningBenchmark "Learning benchmark" KWLearningBenchmark.dd >> genere.log

genere -nomodel -noarrayview KWBenchmarkClassSpec "Benchmark dictionary" KWBenchmarkClassSpec.dd >> genere.log

rem La partie modele est geree dans la librairie KWModeling
genere -outputdir ..\KWModeling -noview KWRecodingSpec "Recoding parameters" KWRecodingSpec.dd >> genere.log
genere -nomodel -noarrayview KWRecodingSpec "Recoding parameters" KWRecodingSpec.dd >> genere.log

genere -nomodel -noarrayview KWAttributePairsSpec "Variable pairs parameters" KWAttributePairsSpec.dd >> genere.log

genere -nomodel -noarrayview KWAttributeConstructionSpec "Feature engineering parameters" KWAttributeConstructionSpec.dd >> genere.log

rem La partie modele est geree dans la librairie KDDomainKnowledge
genere -outputdir ..\KDDomainKnowledge -noview KDTextFeatureSpec "Text feature parameters" KDTextFeatureSpec.dd >> genere.log
genere -nomodel -noarrayview KDTextFeatureSpec "Text feature parameters" KDTextFeatureSpec.dd >> genere.log

genere -nomodel -noarrayview KDConstructionDomain "Variable construction parameters" KDConstructionDomain.dd >> genere.log

genere -nomodel KDConstructionRule "Construction rule" KDConstructionRule.dd >> genere.log
