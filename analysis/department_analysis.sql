-- Purpose: Evaluate total volume and SLA metrics (breach_rate_percentage, avg_resolution_time) by department
-- Insight: IT has the highest volume and lowest average resolution time,
-- while operations has the highest breach rate % and average resolution time.
-- Operations and Finance are tied for second highest volume and both have higher breach rate %s than IT
SELECT
    department,
    COUNT(*) AS total_requests,
    ROUND(
        SUM(CASE WHEN sla_breached = 'Yes' THEN 1 ELSE 0 END)::decimal 
        / COUNT(*) * 100, 2
    ) AS breach_rate_percentage,
	ROUND(AVG(resolution_time_hours), 2) AS avg_resolution_time
FROM internal_requests
GROUP BY department;

-- Purpose: I have observed that priority and departments are major factors in SLA indicators, plot both of them together to evaluate trends
-- Insight:
SELECT
	priority,
	department,
	COUNT (*) AS total_cases,
	SUM(CASE WHEN sla_breached = 'Yes' THEN 1 ELSE 0 END) AS cases_breached,
	ROUND(
        SUM(CASE WHEN sla_breached = 'Yes' THEN 1 ELSE 0 END)::decimal 
        / COUNT(*) * 100, 2) AS breach_rate
FROM internal_requests
GROUP BY 1,2
ORDER BY 2,1
