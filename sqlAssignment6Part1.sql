-- 1. computer the eaverage count of rentals across all films
-- rental : inventory_id , inventory: inventory_id
--inventory: film_id , film: film_id
WITH FilmRentalCounts_CTE AS(
SELECT 	seF.film_id,
		seF.title,
		count(seR.rental_id) as rentalCount
FROM film as seF
LEFT JOIN inventory as seI
ON seF.film_id = seI.film_id
LEFT JOIN rental as seR 
ON seI.inventory_id = seR.inventory_id
GROUP BY seF.film_id, seF.title
	),
-- make it a cte
--- average rental count
 averageRentalCount_CTE AS(
	SELECT AVG(rentalCount) AS avgRentalCount
	FROM FilmRentalCounts_CTE
	)
--make it cte 
-- compare each film's rental count to the avgRentalCount 
-- determine whether the total rentals for each film is above or below avg

SELECT
	seFr.film_id,
	seFr.title,
	CASE WHEN seFr.rentalCount > seAv.avgRentalCount THEN 'Above average'
	WHEN seFr.rentalCount < seAv.avgRentalCount THEN 'below average'
	END
	AS rentalPerformance
FROM FilmRentalCounts_CTE AS seFr, averageRentalCount_CTE AS seAv

