# -*- coding: utf-8 -*-
"""
DS 5100 Group Project
Authors: Brian Wickens, Mariapaola Ambrosona, Theophilus Braimoh, 
Robert Andrews, DeAyrra Greene
"""

import numpy as np
import pandas as pd


#Read and clean data
d16 = pd.read_csv('data\Building_Energy_Benchmarking_2016.csv')
d19 = pd.read_csv('data\Building_Energy_Benchmarking_2019.csv')
d20 = pd.read_csv('data\Building_Energy_Benchmarking_2020.csv')

#Function to Remove non-compliant sites then apply to the three years' datasets
def compliant_sites(df):
    df = df[df['ComplianceStatus'] == 'Compliant']
    return df

d16 = compliant_sites(d16)
d19 = compliant_sites(d19)
d20 = compliant_sites(d20)






