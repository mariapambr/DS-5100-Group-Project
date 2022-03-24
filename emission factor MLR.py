# -*- coding: utf-8 -*-
"""
Created on Wed Mar 23 17:19:48 2022

@author: Brian

To perform multiple linear regression of CO2 emissions against multiple energy 
sources. Do the coefficients match published emission factors for each source.

Notes:
Should be able to extract the exact emissions factors used from MLR since they 
should be constant for all sites in the city.
Does energy star use location based factors?
"""

#Import Cleaned Data
exec(open("import data.py").read())