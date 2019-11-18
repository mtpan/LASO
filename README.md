# LASO
Longitudinal study of psychotic-like symptoms among undergraduate students in UCLA. 

## Background 
Recent research has indicated psychosis and psychotic disorders are better framed on a spectrum (Insel, 2010). Within this framework, some research has investigated psychotic-like experiences (PLE) in healthy populations. Many studies have shown psychotic-like experiences (PLE) such as persecution and thought interference, are prevalent in the general population with 7.2% of the population endorsing high levels, and these experiences show continuity with more severe clinical psychotic states (Hanssen, 2005; Barber, 2017). Moreover, high PLE functional impairments have shown similarities to clinically significant disorders, like schizophrenia in cognition and social functioning (Barber, 2017). Linscott and van Os (2013) further demonstrated that psychotic experience was more common among younger individuals and occurred in association with exposure to stressful or traumatic events. A study done by Kelleher and colleagues in 2015 shows that young people with psychotic experiences have poorer global functioning, and 75% of them also reported feeling distressed by their experiences. However, there has been little research on school performances in college students who report psychotic experiences. 

## Research Questions 
Here are several questions that I'm interested in asking 
- [] How prevalent are PLE in undergrad population?  
- [x] The correlation between anhedonia and PLE (any similarity between PLE and SZ) 
- [] The correlation between childhood trauma and PLE (possible indicators of PLE)
- [] The correlation between school performance and PLE (how does it impact students) 

- [] Change in PLE and change in school performance, does it worsen overtime  
- [] Does perceived social support mediate the negative effect of PLE
- [x] What items from the screening questions can predict a high CAPE score
- [] What are the predictors that predict an elevated high CAPE score in the long run

## Participants 
The baseline version consists of 141 participant responses. Due to some data collection mistakes there are a lot of missing values. *(review Stats 102B)*

## Surveys 

### CAPE
CAPE stands for Community Assessment of Psychic Experiences. [link here.](http://cape42.homestead.com/)
It has 18 positive symptom items, 14 negative symptom items and 8 depressive symptom items. 

**positive symptom sample question**: Do you ever feel as if you are being persecuted in some way?

**negative symptom sample question**: Do you ever feel that you experience few or no emotions at important events?

**depressive symptom sample question**: Do you ever feel pessimistic about everything?

A preliminary principal component analysis on 42 items.

```R
pca_cape_a <- prcomp(cape_a, center = T, scale = T) 
ggbiplot(pca_cape_a)
```

![](https://github.com/mtpan/LASO/blob/master/PCA_all_items_biplot.png)

![](https://github.com/mtpan/LASO/blob/master/PCA_biplot.png)



#### Item Response Theory 
![](https://github.com/mtpan/LASO/blob/master/rasch_model.png)
![](https://github.com/mtpan/LASO/blob/master/item_information_curves.png)

The information curves typically have similart height and width, suggesting that no particular item has larger discrimination than the others. 
Might need to do factor analysis/PCA and select certain items out. 

#### Screening Questions
- 18 questions were taken out from CAPE and used for Psych10 screening
- Used Psych10 data from fall2018, winter2019, spring2019 (approximately 1500 participants)
- From the tracking spreadsheet, 106 of them were asked back to do the baseline LASO 
- Matched this 106 people to the existing LASO CAPE data (141 participants, duplicates included) 
- 103 values used because of missing values 
- Used the 18 questions as predictors, total CAPE score from their first baseline as an outcome variable, performed best subset regression, and based on lowest BIC, 4-variable model is the best model
- fit a 4-variable linear regression model using lm()

1. (CAPE 2) Do you ever feel as if people seem to drop hints about you or say things with a double meaning?
4. (CAPE 7) Do you ever feel as if you are being persecuted in some way?
10. (CAPE 26) Do you ever feel as if the thoughts in your head are not your own?
15. (CAPE 34) Do you ever hear voices talking to each other when you are alone?

![](https://github.com/mtpan/LASO/blob/master/four_variable_CAPE.png)

### Chapman Anhedonia 

- The Revised Physical Anhedonia Scale (Chapman & Chapman,1978) (61 items) assesses a self-reported deficit in the ability to experience pleasure from typically pleasurable physical stimuli such as food, sex, and settings (e.g., “Beautiful scenery
has been a great delight to me.”).

- The Revised Social Anhedonia Scale (Eckblad et al., 1982) (40 items) assesses
deficits in the ability to experience pleasure from non physical stimuli such as other
people, talking, exchanging expressions of feelings (e.g., “A car ride is much more
enjoyable if someone is with me.”). 

Correlation tests show that the total, positive, negative, and depressive CAPE scores are all positively correlated with both the physical scale and the social scale. 

![](https://github.com/mtpan/LASO/blob/master/cape_anhed_total.png)

![](https://github.com/mtpan/LASO/blob/master/cape_anhed_3_categories.png)

Pearson's product-moment correlation

|            | Physical | Social |
|------------|----------|--------|
| Positive   | 0.219    | 0.423  |
| Negative   | 0.562    | 0.687  |
| Depressive | 0.278    | 0.461  |
| Total      | 0.446    | 0.643  |



## Notes 

#### CAPE Papers 
- [papers i need to finish reading](https://www.cambridge.org/core/services/aop-cambridge-core/content/view/BA0A9032B266E8CFFBA3E3B8B762E41C/S0033291701005141a.pdf/evidence_that_three_dimensions_of_psychosis_have_a_distribution_in_the_general_population.pdf)

- https://link.springer.com/article/10.1007/s00127-003-0622-7

- https://academic.oup.com/schizophreniabulletin/article/42/1/34/2518916

- https://link.springer.com/article/10.1186/s12888-019-2210-8

- [a papaer on multidimensional cape vs 3-dimension](https://www.sciencedirect.com/science/article/pii/S0920996415300347)

- [they proposed the 9 subcategory but i need to double check; they have 2 categories for pos including loadings](https://academic.oup.com/schizophreniabulletin/article/42/1/34/2518916)

#### Item Response Theory

- [use IRT in R](https://blog.dominodatalab.com/item-response-theory-r-survey-analysis/)

- [additional material to help understand IRT](https://www.metheval.uni-jena.de/irt/VisualIRT.pdf)

- [also this one](https://www.personality-project.org/r/book/Chapter8.pdf)

- [and this one](http://personality-project.org/r/book/)

#### CTQ Childhood Maltreatment 
- [this paper used CTQ and CAPE](https://www.sciencedirect.com/science/article/pii/S0920996414001170?via%3Dihub)
