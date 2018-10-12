SELECT COUNT(DISTINCT utm_campaign) 
FROM page_visits;

SELECT COUNT(DISTINCT utm_source) 
FROM page_visits;

SELECT DISTINCT utm_campaign, utm_source 
FROM page_visits 
GROUP BY utm_campaign, utm_source;

SELECT DISTINCT page_name FROM page_visits;

WITH first_touch AS (
    SELECT user_id,
        MIN(timestamp) as first_touch_at
    FROM page_visits
    GROUP BY user_id)
SELECT pv.utm_campaign, 
    COUNT(*) AS first_touch
FROM first_touch ft
JOIN page_visits pv
    ON ft.user_id = pv.user_id
    AND ft.first_touch_at = pv.timestamp
    GROUP BY 1 
    ORDER BY 2 DESC;

WITH last_touch AS (
    SELECT user_id,
        MAX(timestamp) as last_touch_at
    FROM page_visits
    GROUP BY user_id)
SELECT pv.utm_campaign, 
    COUNT(*) AS last_touch
FROM last_touch lt
JOIN page_visits pv
    ON lt.user_id = pv.user_id
    AND lt.last_touch_at = pv.timestamp
    GROUP BY 1 
    ORDER BY 2 DESC;

SELECT COUNT(DISTINCT user_id) AS num_purchase 
FROM page_visits 
WHERE page_name = '4 - purchase' 
GROUP BY page_name;

WITH last_touch AS (
    SELECT user_id,
        MAX(timestamp) as last_touch_at
    FROM page_visits
    WHERE page_name = '4 - purchase'
    GROUP BY user_id)
SELECT pv.utm_campaign, 
    COUNT(*) AS last_touch
FROM last_touch lt
JOIN page_visits pv
    ON lt.user_id = pv.user_id
    AND lt.last_touch_at = pv.timestamp
    GROUP BY 1 
    ORDER BY 2 DESC;
