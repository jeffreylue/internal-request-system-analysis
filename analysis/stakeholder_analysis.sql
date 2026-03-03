-- Purpose: Evaluate SLA metrics by stakeholder
-- Insight: Executives have a lower volume of requests, a lower average resolution time, and a 0% breach rate,
-- indicating there may be a ownership bias 
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

-- Purpose: Evaluate volume of requets by stakeholder and prioirty
-- Insight: Executives only submit Critical and High prioirty cases,
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
