# Chick_Weight
This is a source code of a Shiny web application: https://nguyenlong923.shinyapps.io/Chick_Weight/  
The application presents an analysis of a Chick Weight data.  
The application was built as an assignment for the course "Developing Data Products"  
within the "Data Science Specialization" of Jons Hopkins University on Coursera.  

The ChickWeight data frame has 578 rows and 4 variables from an experiment 
on the effect of diet on early growth of chicks:
- weight: a numeric vector giving the body weight of the chick (gm).
- Time: a numeric vector giving the number of days since birth when the 
measurement was made.
- Chick: an ordered factor with levels 18 < ... < 48 giving a unique 
identifier for the chick. The ordering of the levels groups chicks on the 
same diet together and orders them according to their final weight 
(lightest to heaviest) within diet.
- Diet: a factor with levels 1, ..., 4 indicating which experimental diet 
the chick received.

This application will fit a linear model of weight versus age of chicks 
and predict the weight. You can:
1) Change the age (days since birth) by sliding
2) Choose to account for the effects of different diet by click on 
Show/Hide Diet
After choosing the option, please click the button Execute to start the
applicaton.
