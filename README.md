# DemPoRT

**Dementia Population Risk Tool (DemPoRT)**

The Dementia Population Risk Tool (DemPoRT) is a predictive algorithm for calculating 5-year risk for developing dementia. DemPoRT was developed population-level use and it is discriminating and well-calibrated across a wide range of population subgroups, despite using only self-reported risk factors (with a focus on health behaviours including smoking, diet and physical inactivity). DemPoRT uses include predicting how many people will develop dementia, calculate future dementia burden, identify high risk population subgroups, and inform the development of dementia prevention strategies. It can also be used by patients and their clinicians to assess an individual's risk of developing dementia.

<ins>See www.projectbiglife.ca for individual (available) and population-level (in development) DemPoRT implementation tools</ins>

DemPoRT was developed and validated using Ontario individuals age 55+ from the 2001 to 2012 Canadian Community Health Surveys (CCHS). There were 75,460 survey respondents, 8,448 dementia events, and 348,677 person-years follow-up in the combined derivation and validation cohorts.

_5-year cumulative incidence of dementia_

- Males: 0.044 (95% CI: 0.042, 0.047); Females: 0.057 (95% CI: 0.055, 0.060)

_Discrimination in temporal validation_

- Males: C statistic 0.83 (95% CI: 0.81, 0.85); Females: 0.83 (95% CI: 0.81, 0.85)

_Calibration in temporal validation_

- Calibration slopes in the validation data were 0.7859 among males and 0.8666 among females.

Trial registration: ClinicalTrials.gov, no. NCT03155815

## Reduced algorithm (DemPoRT-R)

The recommended algorithm for use in the clinical or population setting.

### Files include:

These files capture all of the information needed to calcuate the model outcome from starting variables:

- _variables.csv_ - Starting variable information, including labels

- _variable-details.csv_ - More information about starting variables, including information about continuous variable units and valid range, and categorical variable categories and dummy variable specification

- _fine-and-gray.csv_ - Model beta coefficients; DemPoRT uses a Fine and Gray subdistribution model

- _model-steps.csv_ - Documents how the starting variables are transformed into the final model variables, including the creation of dummy variables, variable centering, creation of restricted cubic spline and interaction variables

- _center.csv_ - Specifies the mean values to use for variable centering

- _rcs.csv_ - Specifies the variables used to create restricted cubic spline variables, including knot locations and names of the new variables

- _interactions.csv_ - Specifies the variables to be interacted and the names of the new variables

Other files:

- _DemPoRT-R-survey-structure.lss_ - Lime Survey file survey questions used to collect model variable information, when DemPoRT is to be used for individual-level prediction, including skip patterns -- coming soon

- _DemPoRT-R-transformations.xml_ - Links the variable outputs from the Lime Survey file to the starting variables (listed in variables.csv) -- coming soon

## References

1. Fisher S, Hsu AT, Mojaverian N, Taljaard M, Huyer G, Manuel DG, Tanuseputro P (2018) **Dementia Population Risk Tool (DemPoRT): Study protocol for a predictive algorithm assessing dementia risk in the community**. [BMJ Open 2017;7(10):e01801](https://bmjopen.bmj.com/content/7/10/e018018)
2. Fisher S, Manuel DG, Hsu AT, Bennett C, Tuna M, Bader Eddeen A, Sequeira Y, Taljaard M, Anderson GM, Tanuseputro P (2020). **Development and validation of a predictive algorithm for risk of dementia in the community setting**. [J Epidemiol Community Health;75(9):843-853](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC8372383/)

## Building the PMML and engine file

* Clone this repo
* Clone the bllflow repo at https://github.com/Big-Life-Lab/bllflow.git
* In the terminal, cd into the root of the bllflow project and install it as an R package using the command `devtools::install_local(".")`
* Run the command, `pmml <- bllflow::convert_model_export_to_pmml("E:/Code/ProjectBigLife/DemPoRT/PoRT-cchsshared-dementia-v1-PBLwebsite-imp/model-export/DemPoRT-Full/male/DemPoRT-full-male-model-export.csv", "limesurvey", c(normalizePath("E:/Code/ProjectBigLife/DemPoRT/PoRT-cchsshared-dementia-v1-PBLwebsite-imp/R/limesurvey-flow-functions.R")))` where the first and last arguments to the function should be 
    * The path to male model export CSV file and 
    * The path to the limesurvey-flow-function.R file
* Run the command, `cat(XML::toString.XMLNode(pmml), file="./model.xml")` to save the PMML into a file
* Clone the ts-algorithm-gen repo at https://github.com/Big-Life-Lab/ts-algorithm-gen.git and switch to the v2.x.x branch
* Use the following script file to convert the previously generated `model.xml` file into the JSON file used by the engine,

```{javascript}
import 'source-map-support/register';

import { buildModelJson } from './convert-pmml-to-model-json/convert-pmml-to-model-json';
import fs from 'fs';
import path from 'path';

const pmmlString = fs.readFileSync(
    path.join(__dirname, '../../../DataScience/bllflow/out/model.xml'),
    'utf8',
);
const pmmlCustomFunctionNames = [
    'exp',
    'ln',
    'is.na',
    'not',
    'notEqual',
    'formatDatetime',
    'max',
    'sum',
    'isIn',
    'colonOperator',
    'log',
    'ifelse',
    'ifelse2',
    'pmax',
    'floor',
    'pmax',
    'exists',
    'substr',
    'nchar',
    'as.numeric',
    'is.null',
    'zScore',
    'as.Date',
    'format',
    'Sys.Date',
    'rcs',
    'round',
];

buildModelJson(pmmlString, pmmlCustomFunctionNames).then((modelJson) => {
    fs.writeFileSync(
        path.join(__dirname, '../model.json'),
        JSON.stringify(modelJson, null, 4),
    );
});
```

* Run the same commands to generate the files for the female model but switching out the male model export file for the female one

