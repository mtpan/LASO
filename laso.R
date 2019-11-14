# created on 10/7 
library(dplyr)
look <- read.csv("/Users/CCNL2/Desktop/Mengtong/laso_look.csv")

unscored <- readxl::read_xlsx("/Users/CCNL2/Desktop/Mengtong/LASO_unscored_100219.xlsx")

colnames(look)

anhed_unscored <- unscored[-1,c(1,102:276)]

look_col <- colnames(look)

mean(look[45:142,194]);sd(look[45:142,194])

mean(look[45:142,196]);sd(look[45:142,196])

# physical and social anhedonia were extracted. Scoring is already provided. Dropped the NAs. Scatter plot, linear regression, and correlation all showed a positive correlation between these two scores.  
anhed <- (look[-1,c(2,93:197)])
anhed <- na.omit(anhed)
plot(anhed$C_P.Phys_Score_1,anhed$C_S.Soc_Score_1)
summary(lm(anhed$C_P.Phys_Score_1~anhed$C_S.Soc_Score_1))
cor(anhed$C_P.Phys_Score_1,anhed$C_S.Soc_Score_1)

cape <- look[-1,c(2,3:90)]

# next step, clean up cape and score it, then compare with physical and social anhedonia scores 

# Bizarre Experiences: a5+a17+a24+a26+a28+a30+a31
# Hallucinations: a33+a34+a41+a42
# Paranoia: a2+a6+a7+a10+a22
# Grandiosity: a11+a13
# Magical Thinking: a15+a20
# Social Withdrawal: a3+a4+a16+a29
# Affective Flattening:a8+a27+a32
# Avolition:a18+a21+a23+a25+a35+a36+a37

# Positive dimension: a2+a5+a6+a7+a10+a11+a13+a15+a17+a20+a22+a24+a26+a28+a30+a31+a33+a34+a41+a42 
# Negative dimension: a3+a4+a8+a16+a18+a21+a23+a25+a27+a29+a32+a35+a36+a37
# Depressive dimension: a1+a9+a12+a14+a19+a38+a39+a40 

# Distress associated with positive: b2+b5+b6+b7+b10+b11+b13+b15+b17+b20+b22+b24+b26+b28+b30+b31+b33+b34+b41+b42
# Distress associated with negative: b3+b4+b8+b16+b18+b21+b23+b25+b27+b29+b32+b35+b36+b37
# Distress associated with depressive: 

cape_categories <- cape %>% mutate(
                        bizarre = CAPE5a_1+CAPE17a_1+CAPE24a_1+CAPE26a_1+CAPE28a_1+CAPE30a_1+CAPE31a_1,
                        hallucination = CAPE33a_1+CAPE34a_1+CAPE41a_1+CAPE42a_1,
                        paranoia = CAPE2a_1+CAPE6a_1+CAPE7a_1+CAPE10a_1+CAPE22a_1,
                        grandiosity = CAPE11a_1+CAPE13a_1,
                        magical_thinking = CAPE15a_1+CAPE20a_1,
                        
                        social_withdrawal = CAPE3a_1+CAPE4a_1+CAPE16a_1+CAPE29a_1,
                        affective_flattening = CAPE8a_1+CAPE27a_1+CAPE32a_1,
                        avolition = CAPE18a_1+CAPE21a_1+CAPE23a_1+CAPE25a_1+CAPE35a_1+CAPE36a_1+CAPE37a_1,
                        
                      positive = CAPE2a_1+CAPE5a_1+CAPE6a_1+CAPE7a_1+CAPE10a_1+CAPE11a_1+CAPE13a_1+CAPE15a_1+CAPE17a_1+
                      CAPE20a_1+CAPE22a_1+CAPE24a_1+CAPE26a_1+CAPE28a_1+CAPE30a_1+CAPE31a_1+CAPE33a_1+CAPE34a_1+CAPE41a_1+CAPE42a_1,
                      
                      negative = CAPE3a_1+CAPE4a_1+CAPE8a_1+CAPE16a_1+CAPE18a_1+CAPE21a_1+CAPE23a_1+CAPE25a_1+CAPE27a_1+CAPE29a_1+CAPE32a_1+
                      CAPE35a_1+CAPE36a_1+CAPE37a_1,
                      
                      depressive = CAPE1a_1+CAPE9a_1+CAPE12a_1+CAPE19a_1+CAPE38a_1+CAPE39a_1+CAPE40a_1
                      ) 
cape_categories <- cape_categories %>% mutate(total = positive + negative + depressive)

# PCA of CAPE 
cape_a <- cape[,seq(2, 83, by = 2)] # select cape scores with column A 
cape_a <- na.omit(cape_a) # exclude NAs 
pca_cape_a <- prcomp(cape_a, center = T, scale = T) 
summary(pca_cape_a)

library(devtools)
#install_github("vqv/ggbiplot")
library(ggbiplot)
ggbiplot(pca_cape_a) # plot of PCA with items on 2 components 
plot(pca_cape_a,type = 'l') # plot of how much variance each component explains
loadings <- data.frame(pca_cape_a$rotation, 
                       .names = row.names(pca_cape_a$rotation))

# do PCA again, not on every variable but on summary scores 
pca_cape_categories <- prcomp(na.omit(cape_categories[,90:97]), center = T, scale. = T)
summary(pca_cape_categories)
ggbiplot(pca_cape_categories)
plot(pca_cape_categories,type = 'l')

theta <- seq(0,2*pi,length.out = 100)
circle <- data.frame(x = cos(theta), y = sin(theta))
p <- ggplot(circle,aes(x,y)) + geom_path()

loadings_category <- data.frame(pca_cape_categories$rotation, 
                       .names = row.names(pca_cape_categories$rotation))
p + geom_text(data=loadings, 
              mapping=aes(x = PC1, y = PC2, label = .names, colour = .names)) +
  coord_fixed(ratio=1) +
  labs(x = "PC1", y = "PC2")

# Ok so let's do factor analysis 
fit <- factanal(cape_a, 3, rotation="varimax")
print(fit, digits=2, cutoff=.3, sort=TRUE)
# plot factor 1 by factor 2
load <- fit$loadings[,1:2]
plot(load,type="n") # set up plot
text(load,labels=rownames(cape_a),cex=.7) # add variable names

library(FactoMineR)
result <- PCA(cape_a) # graphs generated automatically



# try to do IRT, coded 1 and 2 to 1, 3 and 4 to 2, dichotomous, 1PL model
library(ltm)
cape_a_code <- cape_a
cape_a_code[cape_a <= 2] <- 1;cape_a_code[cape_a > 2] <- 2
rasch_model <- rasch(cape_a_code)
summary(rasch_model)
plot(rasch_model)
plot(rasch_model,type = "IIC")


cronbach.alpha(cape_a_code) # alpha: 0.914
cronbach.alpha(cape_a_code)  # Items: 41 Sample units: 138 alpha: 0.88, >0.7 is considered acceptable 
# Cronbach’s alpha is a measure of internal consistency, that is, how closely related a set of items are as a group.

factor.scores(rasch_model) %>% View()

information(rasch_model,range = 0:2)


# back to my research question, do people who endorse more PLEs also show elevated levels of anhedonia?
anhed <- look[,c(2, 93:197)]
anhed <- anhed %>% na.omit()

# merge the cape and anhedonia surveys
cape_anhed <- inner_join(cape_categories[,c(1,90:101)], anhed[, c(1, 103:106)])

# plot and correlation test of the total cape scores against physical and social scores
cor.test(cape_anhed$total, cape_anhed$C_P.Phys_Score_1)
cor.test(cape_anhed$total, cape_anhed$C_S.Soc_Score_1)

# plot and correlation test of the positive cape scores against physical and social scores
cor.test(cape_anhed$positive, cape_anhed$C_P.Phys_Score_1)
cor.test(cape_anhed$positive, cape_anhed$C_S.Soc_Score_1)

# plot and correlation test of the negative cape scores against physical and social scores
cor.test(cape_anhed$negative, cape_anhed$C_P.Phys_Score_1)
cor.test(cape_anhed$negative, cape_anhed$C_S.Soc_Score_1)

# plot and correlation test of the depressive cape scores against physical and social scores
cor.test(cape_anhed$depressive, cape_anhed$C_P.Phys_Score_1)
cor.test(cape_anhed$depressive, cape_anhed$C_S.Soc_Score_1)

par(mfrow = c(3, 2))
plot(cape_anhed$total ~ cape_anhed$C_P.Phys_Score_1, xlab = "Physical Scores", ylab = "Cape Total Scores")
abline(lm(cape_anhed$total ~ cape_anhed$C_P.Phys_Score_1), col = "red")

plot(cape_anhed$total ~ cape_anhed$C_S.Soc_Score_1, xlab = "Social Scores", ylab = "Cape Total Scores")
abline(lm(cape_anhed$total ~ cape_anhed$C_S.Soc_Score_1), col = "red")

plot(cape_anhed$positive ~ cape_anhed$C_P.Phys_Score_1, xlab = "Physical Scores", ylab = "CAPE Positive")
abline(lm(cape_anhed$positive ~ cape_anhed$C_P.Phys_Score_1), col = "red")

plot(cape_anhed$positive ~ cape_anhed$C_S.Soc_Score_1, xlab = "Social Scores", ylab = "CAPE Positive")
abline(lm(cape_anhed$positive ~ cape_anhed$C_S.Soc_Score_1), col = "red")

plot(cape_anhed$depressive ~ cape_anhed$C_P.Phys_Score_1, xlab = "Physical Scores", ylab = "CAPE Depressive")
abline(lm(cape_anhed$depressive ~ cape_anhed$C_P.Phys_Score_1), col = "red")

plot(cape_anhed$depressive ~ cape_anhed$C_S.Soc_Score_1, xlab = "Social Scores", ylab = "CAPE Depressive")
abline(lm(cape_anhed$depressive ~ cape_anhed$C_S.Soc_Score_1), col = "red")

plot(cape_anhed$negative ~ cape_anhed$C_P.Phys_Score_1, xlab = "Physical Scores", ylab = "CAPE Negative")
abline(lm(cape_anhed$negative ~ cape_anhed$C_P.Phys_Score_1), col = "red")

plot(cape_anhed$negative ~ cape_anhed$C_S.Soc_Score_1, xlab = "Social Scores", ylab = "CAPE Negative")
abline(lm(cape_anhed$negative ~ cape_anhed$C_S.Soc_Score_1), col = "red")


# BRIEF and CTQ next? 

brief <- look[,c(2,198:286)] #an adolescent's view of his/her cognitive, emotional, and behavioral functions
psq <- look[,c(2,287:309)] # not scored
sfs <- look[,c(2, 310:369)]
isel <- look[, c(2, 370:396)] #perceived availability of support (the Interpersonal Support Evaluation List)
ctq <- look[, c(2, 397:431)]  #childhood trauma
nsse <- look[, c(2, 432:450)] #The National Survey of Student Engagement











