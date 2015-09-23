#!/usr/bin/python
import os, sys
import pandas as pd

cd = os.path.dirname(os.path.abspath(__file__))

# READ IN CSV FILES
Doodles2010 = pd.read_csv(os.path.join(cd, 'Data', 'GoogleDoodles2010.csv'), encoding = 'iso-8859-1')
Doodles2011 = pd.read_csv(os.path.join(cd, 'Data', 'GoogleDoodles2011.csv'), encoding = 'iso-8859-1')
Doodles2012 = pd.read_csv(os.path.join(cd, 'Data', 'GoogleDoodles2012.csv'), encoding = 'iso-8859-1')
Doodles2013 = pd.read_csv(os.path.join(cd, 'Data', 'GoogleDoodles2013.csv'), encoding = 'iso-8859-1')
Doodles2014 = pd.read_csv(os.path.join(cd, 'Data', 'GoogleDoodles2014.csv'), encoding = 'iso-8859-1')
Doodles2015 = pd.read_csv(os.path.join(cd, 'Data', 'GoogleDoodles2015.csv'), encoding = 'iso-8859-1')

# CONCATENATE ALL CSV FILES
DoodlesAll = pd.concat([Doodles2010, Doodles2011, Doodles2012, Doodles2013, Doodles2014, Doodles2015], axis=0)

# MODIFYING DATE FIELDS
DoodlesAll['DoodleDate'] = pd.to_datetime(DoodlesAll['DoodleDate'], format='%m/%d/%Y')
DoodlesAll = DoodlesAll.sort(['DoodleDate']).reset_index()
DoodlesAll['Year'] = DoodlesAll['DoodleDate'].dt.year
DoodlesAll['Month'] = DoodlesAll['DoodleDate'].dt.month
DoodlesAll['Day'] = DoodlesAll['DoodleDate'].dt.day

monthsdf = pd.DataFrame({'MonthName': ['January', 'February', 'March', 'April', 'May', 'June', \
                                     'July', 'August', 'September', 'October', 'November', 'December'],
                         'MonthNum': [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]})

DoodlesAll = pd.merge(DoodlesAll, monthsdf, how='inner', left_on='Month', right_on='MonthNum')


# PIVOTING DATA FRAME
DoodlesPivot = DoodlesAll.pivot_table(values='Doodle', index=['Year', 'Day'],
                     columns=['MonthName'], aggfunc='min')

DoodlesPivot.to_csv('DoodlesTransposedPy.csv', columns=['January', 'February', 'March', 'April', 'May', 'June', \
                                                      'July', 'August', 'September', 'October', 'November', 'December'])

print('Successfully transposed data from long to wide format!')
