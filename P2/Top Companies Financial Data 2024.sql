-- SELECT * FROM companies
-- WHERE company LIKE '%Sino%' ;

# TOP 5 COMPANIES WITH HIGHEST SALES
WITH Company_Sales AS
(
SELECT company, country, sales, sales_scale, DENSE_RANK() OVER (ORDER BY sales DESC) AS Ranking
FROM companies
WHERE sales_scale = 'Billion'
)
SELECT * 
FROM Company_Sales
LIMIT 5;


# TOP 5 COMPANIES WITH HIGHEST PROFIT
WITH Company_Profit AS
(
SELECT company, country, profit, profit_scale, DENSE_RANK() OVER (ORDER BY profit DESC) AS Ranking
FROM companies
WHERE profit_scale = 'Billion'
)
SELECT * 
FROM Company_Profit
LIMIT 5;


# TOP 5 COMPANIES WITH HIGHEST ASSETS
WITH Company_Assets AS
(
SELECT company, country, assets, assets_scale, DENSE_RANK() OVER (ORDER BY assets DESC) AS Ranking
FROM companies
WHERE assets_scale = 'Billion'
)
SELECT * 
FROM Company_Assets
LIMIT 5;


# TOP 5 COMPANIES WITH HIGHEST MARKET VALUE
WITH Company_Market_Value AS
(
SELECT company, country, market_value, market_value_scale, DENSE_RANK() OVER (ORDER BY market_value DESC) AS Ranking
FROM companies
WHERE market_value_scale = 'Billion'
)
SELECT * 
FROM Company_Market_Value
LIMIT 5;