# PBL-DemPoRT
**Dementia Population Risk Tool (DemPoRT)**

The Dementia Population Risk Tool (DemPoRT) is a predictive algorithm for calculating 5-year dementia risk, designed specifically for population-level use.  DemPoRT is discriminating and well-calibrated across a wide range of population subgroups, despite using only self-reported risk factors (with a focus on health behaviours including smoking, diet and physical inactivity).

Most dementia algorithms are unsuitable for population-level assessment and planning as they are desinged for use in the clinical setting. DemPoRT is the first dementia risk algorithm designed for population use and can be used to produce improved estimates of current and future dementia burden, identify high risk population subgroups, and inform the development of dementia prevention strategies. It can also be used by patients and their clinicians to assess individual dementia risk.

<ins>Stay tuned for individual and population-level DemPoRT implementation tools at www.projectbiglife.ca</ins>

DemPoRT was developed and validated using Ontario individuals age 55+ from the 2001 to 2012 Canadian Community Health Surveys (CCHS). There were 75,460 survey respondents, 8,448 dementia events, and 348,677 person-years follow-up in the combined derivation and validation cohorts.

*5-year cumulative incidence of dementia*

* Males: 0.044 (95% CI: 0.042, 0.047); Females: 0.057 (95% CI: 0.055, 0.060)

*Discrimination in temporal validation*

* Males: C statistic 0.83 (95% CI: 0.81, 0.85); Females: 0.83 (95% CI: 0.81, 0.85)

*Calibration in temporal validation*

* Calibration slopes in the validation data were 0.7859 among males and 0.8666 among females. 

Trial registration: ClinicalTrials.gov, no. NCT03155815

## Reduced algorithm (DemPoRT-R)

The recommended algorithm for use in the clinical or population setting.

### Files include:
These files capture all of the information needed to calcuate the model outcome from starting variables:

* *variables.csv* - Starting variable information, including labels

* *variable-details.csv* - More infomration about starting variables, inlcuding information about continuous varibale units and valid range, and categorical variable categories and dummy variable specification

* *fine-and-gray.csv* - Model beta coefficients; DemPoRT uses a Fine and Gray subdistribution model

* *model-steps.csv* - Documents how the starting variables are transformed into the final model variables, including the creation of dummy variables, variable centering, creation of restricted cubic spline and interaction variables

* *center.csv* - Specifies the mean values to use for variable centering

* *rcs.csv* - Specifies the variables used to create restricted cubic spline variables, including knot locations and names of the new variables

* *interactions.csv* - Specifies the variables to be interacted and the names of the new variables  

Other files:

* *DemPoRT-R-survey-structure.lss* - Lime Survey file survey questions used to collect model variable information, when DemPoRT is to be used for individual-level prediction, including skip patterns -- coming soon

* *DemPoRT-R-transformations.xml* - Links the variable outputs from the Lime Survey file to the starting variables (listed in variables.csv) -- coming soon


## References

1. Fisher S, Hsu AT, Mojaverian N, Taljaard M, Huyer G, Manuel DG, Tanuseputro P (2018) **Dementia Population Risk Tool (DemPoRT): Study protocol for a predictive algorithm assessing dementia risk in the community**. [BMJ Open 2017;7(10):e01801](https://bmjopen.bmj.com/content/7/10/e018018)
2. Fisher S, Manuel DG, Hsu AT, Bennett C, Tuna M, Bader Eddeen A, Sequeira Y, Taljaard M, Anderson GM, Tanuseputro P (2020). **Development and validation of a predictive algorithm for risk of dementia in the community setting**. [Under review at JECH]
