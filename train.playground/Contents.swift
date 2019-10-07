import CreateML
import Foundation

let data = try MLDataTable(contentsOf: URL(fileURLWithPath: "Users/lordchingiss/Desktop/CS/Personal/ML/iOS/Twittermenti-iOS12/kaggle-tweets.csv"))
let (trainingData, testingData) = data.randomSplit(by: 0.8, seed: 5)
let sentimentClassifier = try MLTextClassifier(trainingData: trainingData,
                                               textColumn: "text",
                                               labelColumn: "target")

let trainingAccuracy = (1.0 - sentimentClassifier.trainingMetrics.classificationError) * 100
let validationAccuracy = (1.0 - sentimentClassifier.validationMetrics.classificationError) * 100

print(trainingAccuracy)
print(validationAccuracy)

let evaluationMetrics = sentimentClassifier.evaluation(on: testingData)
let evaluationAccuracy = (1.0 - evaluationMetrics.classificationError) * 100

print(evaluationAccuracy)

let metadata = MLModelMetadata(author: "Jack Li",
                               shortDescription: "A model trained to classify tweets sentiment",
                               version: "1.0")
try sentimentClassifier.write(to: URL(fileURLWithPath: "Users/lordchingiss/Desktop/CS/Personal/ML/iOS/Twittermenti-iOS12/TweetSentiment.mlmodel"),
                              metadata: metadata)
