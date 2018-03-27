import pandas as pd
import numpy as np
import math
#from matplotlib import pyplot as plt 
#import matplotlib.style as style
from sklearn import preprocessing, cross_validation, svm
from sklearn.linear_model import LinearRegression

#style.use('dark_background')
df = pd.read_excel("S&Pdata1.xls")
#plt.scatter(df['S&P_HIGH'],df['S&P_CLOSE'])
#plt.show()

forecast_col = 'S&P_CLOSE'

df.fillna(-99999, inplace=True)
forecast_out = int(math.ceil(0.01*len(df)))

df['label'] = df[forecast_col].shift(-forecast_out)

df.dropna(inplace=True)

X = np.array(df.drop(['label'],1))
y = np.array(df['label'])
X = preprocessing.scale(X)
y = np.array(df['label'])

X_train, X_test, y_train, y_test = cross_validation.train_test_split(X, y, test_size=0.2)
clf = svm.SVR(kernel = 'rbf')
#this is key line which tells classifier what algo to perform
clf.fit(X_train, y_train)
accuracy = clf.score(X_test, y_test)

print(accuracy)

