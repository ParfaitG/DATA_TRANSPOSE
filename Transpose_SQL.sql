SELECT 
DoodleYear, DoodleDay, 

Min(CASE WHEN DoodleMonth='January' THEN DoodleName END) AS January,
Min(CASE WHEN DoodleMonth='February' THEN DoodleName END) AS February, 
Min(CASE WHEN DoodleMonth='March' THEN DoodleName END) AS March, 
Min(CASE WHEN DoodleMonth='April' THEN DoodleName END) AS April, 
Min(CASE WHEN DoodleMonth='May' THEN DoodleName END) AS May, 
Min(CASE WHEN DoodleMonth='June' THEN DoodleName END) AS June, 
Min(CASE WHEN DoodleMonth='July' THEN DoodleName END) AS July, 
Min(CASE WHEN DoodleMonth='August' THEN DoodleName END) AS August, 
Min(CASE WHEN DoodleMonth='September' THEN DoodleName END) AS September, 
Min(CASE WHEN DoodleMonth='October' THEN DoodleName END) AS October, 
Min(CASE WHEN DoodleMonth='November' THEN DoodleName END) AS November, 
Min(CASE WHEN DoodleMonth='December' THEN DoodleName END) AS December

FROM 
    (SELECT DATENAME(month, t1.DoodleDate) AS DoodleMonth, 
          Year(t1.DoodleDate) AS DoodleYear, 
          DoodleName, 
          Day(t1.DoodleDate) AS DoodleDay 
     FROM GoogleDoodles AS t1 
     )  AS dT1

GROUP BY  DoodleYear, DoodleDay;


