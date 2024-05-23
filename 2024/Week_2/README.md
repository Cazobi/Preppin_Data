<h6> &nbsp;&nbsp;&nbsp;<a href="../Week_2/README.md">Next Week  ▶</a></h6>

# Preppin' Data Week 02 - Average Price Analysis

[Challenge description](https://preppindata.blogspot.com/2024/01/2024-week-2-average-price-analysis.html)

## SQL

<i>click the image to view the code</i><br>
<br>
<a href="Snowflake SQL.sql">
<img src="PD 2024 wk 2 SQL.png?raw=true" alt="SQL Code">
</a>

## Tableau Prep

<i>click the image to download the workflow</i><br>
<br>
<a href="Challenge 2024 week 2.tflx">
<img src="PD 2024 wk 2.png?raw=true" alt="Tableau Prep Workflow">
</a>

### Thoughts

This was really challenging for me because I had to change my way of thinking. The challenge suggested Unpivoting, and then Pivoting again on a separate column as well as several unions. I already knew that solving these challenges in Snowflake would be different to doing it in Tableau Prep, but I went in with the expection to do the double transformation and this took me ages to let go off. Once I decided to address it right from the Temp table, things wen't much smoother. The main issue was that it seems you can't directl'y use a subquery or dynamic SQL inside the 'PIVOT' clause. I'm glad this is over 😅😅
