#!/usr/local/bin/python3
import pandas as pd


df = pd.read_csv('kaggle-tweets.csv', encoding='utf-8')
"""
df.columns = ["Unnamed: 0", "target", "id", "date", "flag", "user", "text"]
df.drop(["id", "date", "flag", "user"], axis=1, inplace=True)
df.drop(['Unnamed: 0'], axis=1, inplace=True)
"""


# df = pd.DataFrame([data])
# print(df.head())
# df[df['target'] == 0] = "Negative"


# print(df.info())
df['target'] = df['target'].apply({0: 'Negative', 2: 'Neutral', 4: 'Positive'}.get)
# df.replace(0, "Negative")
# print(df.head())
# print(df.columns)

"""
df[df['target'] == 2] = "Neutral"
df[df['target'] == 4] = "Positive"
df.to_csv('kaggle-tweets.csv')
"""
df.to_csv('kaggle-tweets.csv')