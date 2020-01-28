# LASO
Longitudinal study of psychotic-like symptoms among undergraduate students in UCLA. 

Students were recruited to do a baseline survey that measures psychotic-like experience, perceived social support, executive functioning, school performance, sleep quality, etc., and were invited to do follow-up surveys each quarter for a whole year. 

## Background 
Recent research has indicated psychosis and psychotic disorders are better framed on a spectrum (Insel, 2010). Within this framework, some research has investigated psychotic-like experiences (PLE) in healthy populations. Many studies have shown psychotic-like experiences (PLE) such as persecution and thought interference, are prevalent in the general population with 7.2% of the population endorsing high levels, and these experiences show continuity with more severe clinical psychotic states (Hanssen, 2005; Barber, 2017). Moreover, high PLE functional impairments have shown similarities to clinically significant disorders, like schizophrenia in cognition and social functioning (Barber, 2017). Linscott and van Os (2013) further demonstrated that psychotic experience was more common among younger individuals and occurred in association with exposure to stressful or traumatic events. A study done by Kelleher and colleagues in 2015 shows that young people with psychotic experiences have poorer global functioning, and 75% of them also reported feeling distressed by their experiences. However, there has been little research on school performances in college students who report psychotic experiences. 

## Table of Contents 
[Background/Lit Review](https://github.com/mtpan/LASO#background)
			
[Research Questions](https://github.com/mtpan/LASO#research-questions)
			
[Participants](https://github.com/mtpan/LASO#participants)
			
[Sample CAPE questions and PCA/Item Response Theory](https://github.com/mtpan/LASO#cape)
			
[Analyzed which questions on the screening survey would predict a higher level of psychotic-like experience on the baseline survey](https://github.com/mtpan/LASO#screening-questions)

[Anhedonia is correlated to psychotic-like experience in baseline data](https://github.com/mtpan/LASO#chapman-anhedonia)
			
[Participants who reported higher level of psychotic-like experience also reported poorer overall executive functioning](https://github.com/mtpan/LASO#brief)

## Research Questions 
Here are several questions that I'm interested in asking 
- [x] The correlation between anhedonia and PLE (any similarity between PLE and SZ) 
- [x] What items from the screening questions can predict a high CAPE score
- [ ] The correlation between childhood trauma and PLE (possible indicators of PLE)
- [ ] The correlation between school performance and PLE (how does it impact students) 
- [ ] If there is a change in PLE, does it worsen overtime? If it does, how does it affect school performance/global functioning?  
- [ ] Does perceived social support mediate/buffer the negative effect of PLE on school performance/global functioning?
			
- [ ] Change in PLE and change in school performance, does it worsen overtime  
- [ ] Does perceived social support mediate the negative effect of PLE
- [x] What items from the screening questions can predict a high CAPE score
- [ ] What are the predictors that predict an elevated high CAPE score in the long run

## Participants 
The baseline version consists of 141 participant responses. Due to some data collection mistakes there are a lot of missing values. *(review Stats 102B)*

## Stats
Updated on 11/21/19. based on the tracking file 

Baseline: 106 

1st follow-up: 44

2nd follow-up: 37 (including 6 participants who didn't do the 1st but did the 2rd) 

3rd follow-up: 36 (including 6 participants who did the 1st but not the 2rd, 10 participants who didn't do 1st and 2rd, 4 particiapnts who did the 2rd but not the 1st)


Updated on 12/2/19. based on the data downloaded from SurveyMonkey 

1st follow-up: 56

2nd follow-up: 38 

3rd follow-up: 48 

Updated on 12/5/2019. based on the data downloaded on 12/2/2019, a joined file was created. They are calculated by 

```r
sum(!is.na(temp3$total.x))
sum(!is.na(temp3$total.y))
sum(!is.na(temp3$total.x.x))
sum(!is.na(temp3$total.y.y))
```
If a participants skips a question, that will result in total = NA, so summing up total scores do not necessarily reflect how many people did the survey. Some people did the survey but left most of the questions blank are not included in the following stats. 

baseline: 112

1st follow-up: 52

2nd follow-up: 35

3rd follow-up: 44

### Data cleaning issues 
1/9/20. Removed Subject 10601 because the follow-up was done by another person. 

1/10/20. In baseline data there are two 10623. The one at 12:00 PM should be 10622. Need to change it on SurveyMonkey as well. 

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

*One question that arises from this: answers "Never", "sometimes", "Often", and "Always" are treated as numeric value 1 to 4 in the regression model, will it affect the results and interpretability?*

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


### BRIEF 

Behavior Rating Inventory of Executive Function

Sample questions include: 
- I have trouble changing from one activity or task to another 
- I have a messy closet
- I don't plan ahead for future activities
- People say I'm easily distracted 

Answer choices are Never, Sometimes, and Often. 

- Based on the original BRIEF, the BRIEF-A includes 75 items within nine nonoverlapping theoretically and empirically derived clinical scales: Inhibit, Self-Monitor, Plan/Organize, Shift, Initiate, Task Monitor, Emotional Control, Working Memory, and Organization of Materials.
- Useful for a wide variety of developmental, systemic, neurological, and psychiatric disorders such as attention disorders, learning disabilities, autism spectrum disorders, traumatic brain injury, multiple sclerosis, depression, mild cognitive impairment, dementias, and schizophrenia.

![](https://github.com/mtpan/LASO/blob/master/Brief_CAPE_Corr.png)


### ISEL (Interpersonal Support Eavluation List)

1/16/20 finished scoring it (baseline)! 

Sample questions include: 
- If I wanted to go on a trip for a day (e.g., to the mountains, beach, or country), I would have a hard time finding someone to go with me.
- I feel that there is no one I can share my most private worries and fears with. 
- If I was stranded 10 miles from home, there is someone I could call who would come and get me. 

Answer choices are Definitely True, Probably True, Definitely False, Probably False. 

![](https://github.com/mtpan/LASO/blob/master/isel_brief_cape_plot.png)

I did a simple linear regression treating brief as the dependent variable and cape as the independent variable. The result is significant. In the multiple regression model with cape and isel as predictors, isel is not significant. In the multiple regression with interaction, isel and the interaction term are not significant. 


![](https://github.com/mtpan/LASO/blob/master/moderation.png)

Higher CAPE scores and BRIEF scores mean more PLEs and poorer global functions. Higher ISEL scores mean more perceived social support. 

The result is not significant but we can see that for people with less perceived social support (black line), they tend to have more impaired global functions when they experience more PLEs. 

### PSQI (Pittusburgh Sleep Quality Index)

### CTQ (childhood trauma)
### NSSE (the National Survey of Student Engagement)

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

#### PSQI Pittsburgh Sleep Quality Index 
- [this paper assesses PLE and sleep quality](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC5955607/?report=classic)

-[young people who self-identify as having subthreshold psychotic symptoms and who are therefore at risk for psychosis
(Kline, Wilson, Ereshefsky, Tsuji, et al., 2012) may benefit from
enhanced social support, Subthreshold psychotic symptom distress, self-stigma, and peer social support among college students with mental health concerns](https://sci-hub.tw/https://doi.org/10.1037/prj0000124)
