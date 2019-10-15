# LASO
Longitudinal study of psychotic-like symptoms among undergraduate students

## Background 
Recent research has indicated psychosis and psychotic disorders are better framed on a spectrum (Insel, 2010). Within this framework, some research has investigated psychotic-like experiences (PLE) in healthy populations. Many studies have shown psychotic-like experiences (PLE) such as persecution and thought interference, are prevalent in the general population with 7.2% of the population endorsing high levels, and these experiences show continuity with more severe clinical psychotic states (Hanssen, 2005; Barber, 2017). Moreover, high PLE functional impairments have shown similarities to clinically significant disorders, like schizophrenia in cognition and social functioning (Barber, 2017). Linscott and van Os (2013) further demonstrated that psychotic experience was more common among younger individuals and occurred in association with exposure to stressful or traumatic events. A study done by Kelleher and colleagues in 2015 shows that young people with psychotic experiences have poorer global functioning, and 75% of them also reported feeling distressed by their experiences. However, there has been little research on school performances in college students who report psychotic experiences. 

## Research Questions 
Here are several questions that I'm interested in asking 
1. How prevalent are PLE in undergrad population?  
2. The correlation between anhedonia and PLE (any similarity between PLE and SZ) 
3. The correlation between childhood trauma and PLE (possible indicators of PLE)
4. The correlation between school performance and PLE (how does it impact students) 

5. Change in PLE and change in school performance, does it worsen overtime  
6. Does perceived social support mediate the negative effect of PLE

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







### Chapman Anhedonia 




## Notes 
[papers i need to finish reading](https://www.cambridge.org/core/services/aop-cambridge-core/content/view/BA0A9032B266E8CFFBA3E3B8B762E41C/S0033291701005141a.pdf/evidence_that_three_dimensions_of_psychosis_have_a_distribution_in_the_general_population.pdf)

https://link.springer.com/article/10.1007/s00127-003-0622-7

https://academic.oup.com/schizophreniabulletin/article/42/1/34/2518916

https://link.springer.com/article/10.1186/s12888-019-2210-8

[use IRT in R](https://blog.dominodatalab.com/item-response-theory-r-survey-analysis/)

[additional material to help understand IRT](https://www.metheval.uni-jena.de/irt/VisualIRT.pdf)

[also this one] (https://www.personality-project.org/r/book/Chapter8.pdf)
