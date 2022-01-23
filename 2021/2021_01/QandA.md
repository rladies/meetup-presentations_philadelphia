# Q&A from January 2021 RLadies Philly Event

Links
R-Ladies Philly
Mentor/Speaker directory: rladiesphilly.shinyapps.io/mentorship/
Youtube channel: https://yt.vu/+rladiesphilly 
Slack: https://rebrand.ly/slack-signup-jan21 

Today’s meetup
Pre-workshop poll: http://tiny.cc/2questions 
Slides & GitHub: https://git.io/JLxVo  

Q&A
Q: Can we change the look and feel depending upon our own theme?
A: This can be done, but we won’t be doing this today in the workshop. There are a variety of themes to choose from, and if you know CSS, you have more flexibility.


Q: The objects shown earlier (Text Input/Sliders), are those the only objects which can be used or are there more objects? And can we change the look and feel depending upon our own theme?
A: These are the most often used, but there are others: https://shiny.rstudio.com/gallery/widget-gallery.html
http://shinyapps.dreamrs.fr/shinyWidgets/


Q: What about data sensitive dashboards? Can we deploy on company’s internal website? Or does Shiny need something more?
A: Depends on requirements of organization and data use agreements.
For her work, they needed authentication, so they set up a server and a proxy. You can also deploy Shiny apps on a company’s internal network (for example with: https://rstudio.com/products/connect/)


Q: Can we dockerize a shiny app?
A: yes
https://ropenscilabs.github.io/r-docker-tutorial/

Q:Does the “Listening on http:// “ in red matter? usually text in red is a warning
A: as far as I know, that's just telling you the app is running and "listening" for input on that port

Q: Would the plot render faster if I transform the dataframe outside of the server()?
A: Anastasia will have the answer later in the workshop


Q:If I type in 1 or 2 it still plots 1 or 2 words, bypassing the minimum, is that an issue? 
oops sorry Caira just said that! 
A: Not an issue. You can override the min/max. Also can create error for user if they go past min/max. 

Q: Can you use Shiny with databricks?
A: Yes I think you can use shy/databricks : https://docs.databricks.com/spark/latest/sparkr/shiny.html 

Q: Can the bars be shown in asc/desc order of sort? Or is it going to come in a while?
A: In ggplot2 you can change the order - consider using fct_reorder 
( https://forcats.tidyverse.org/reference/fct_reorder.html )
x=forcats::fct_reorder(word, occurrences)

Q: Do I have to stop the app to execute another function?
A: Yes

Q: Where did the dropdown and search bar for the table come from? 
A: https://shiny.rstudio.com/reference/shiny/0.14/tableOutput.html renderDataTable has this included; you can get a more basic table with tableOut  put
(Martine added:  It came from datatableinput)

Q: I use PowerBI and Quicksight for visualization at present which are GUI drag/drop based apps. Why should one more to R and code everything? I need to make a case to my company hence checking. 
A: One motivation is that it is free and open source. In addition, you may have more control and flexibility with R.
Another consideration is reproducibility. 




Q: How should we optimize for speed?
A: Process data as much as possible ahead of time

