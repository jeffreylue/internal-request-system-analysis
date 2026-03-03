-- Purpose: Evaluate SLA metrics by stakeholder
-- Insight: Executives have a lower volume of requests, a lower average resolution time, and a 0% breach rate,
-- average resolution time is more than double for Employees compared to Executives indicating there may be a stakeholder bias
SELECT
    request_source,
    COUNT(*) AS total_requests,
    ROUND(AVG(resolution_time_hours), 2) AS avg_resolution_time,
    ROUND(
        SUM(CASE WHEN sla_breached = 'Yes' THEN 1 ELSE 0 END)::decimal 
        / COUNT(*) * 100, 2
    ) AS breach_rate_percentage
FROM internal_requests
GROUP BY request_source;

-- Purpose: Evaluate volume of requests by stakeholder and priority
-- Insight: Executives only submit Critical and High priority cases,
-- employees rarely submit critical cases
SELECT
	request_source,
	COUNT (*) as total_requests,
	SUM (CASE WHEN priority = 'Critical' THEN 1 ELSE 0 END) AS total_critical_cases,
	SUM (CASE WHEN priority = 'High' THEN 1 ELSE 0 END) AS total_high_cases,
	SUM (CASE WHEN priority = 'Medium' THEN 1 ELSE 0 END) AS total_medium_cases,
	SUM (CASE WHEN priority = 'Low' THEN 1 ELSE 0 END) AS total_low_cases
	
FROM internal_requests
GROUP BY request_source;

-- Purpose: Evaluate SLA metrics by case priority (total_requests, breach_rate_percentage, avg_resolution_time)
-- Insight: High priority cases have the highest breach rate and longest resolution time
-- followed by Medium, and then Critical.
-- Further investigation of High/Medium priority cases could reveal categorical trends or operational inefficiencies. 
-- Recommendation: Asses how High-priority cases are being categorized to ensure accurate prioritization
SELECT
    priority,
    COUNT(*) AS total_requests,
    ROUND(
        SUM(CASE WHEN sla_breached = 'Yes' THEN 1 ELSE 0 END)::decimal 
        / COUNT(*) * 100, 2
    ) AS breach_rate_percentage,
	ROUND(AVG(resolution_time_hours), 2) AS avg_resolution_time
FROM internal_requests
GROUP BY 1
ORDER BY total_requests DESC
