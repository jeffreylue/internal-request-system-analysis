-- Purpose: Evaluate SLA performance by stakeholder group.
-- Insight: Executives submit fewer requests, maintain a 0% breach rate, 
-- and experience significantly lower average resolution times.
-- Employees’ average resolution time is more than double that of Executives.
-- Interpretation: This pattern may indicate potential stakeholder prioritization bias.
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

-- Purpose: Evaluate request distribution by stakeholder and priority level.
-- Insight: Executives submit only Critical and High-priority cases.
-- Employees rarely submit Critical cases and account for most Medium/Low priority volume.
-- Interpretation: Priority escalation behavior may differ by stakeholder group.
SELECT
	request_source,
	COUNT (*) as total_requests,
	SUM (CASE WHEN priority = 'Critical' THEN 1 ELSE 0 END) AS total_critical_cases,
	SUM (CASE WHEN priority = 'High' THEN 1 ELSE 0 END) AS total_high_cases,
	SUM (CASE WHEN priority = 'Medium' THEN 1 ELSE 0 END) AS total_medium_cases,
	SUM (CASE WHEN priority = 'Low' THEN 1 ELSE 0 END) AS total_low_cases
	
FROM internal_requests
GROUP BY request_source;

-- Purpose: Evaluate SLA performance by case priority 
-- (total_requests, breach_rate_percentage, avg_resolution_time).
-- Insight: High-priority cases have the highest breach rate and longest resolution time.
-- Medium-priority cases follow, while Critical cases show comparatively stronger SLA performance.
-- Interpretation: High/Medium cases may contain workflow inefficiencies or inconsistent classification.
-- Recommendation: Assess how High-priority cases are categorized to ensure accurate prioritization standards.
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
