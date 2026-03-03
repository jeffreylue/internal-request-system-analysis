-- Purpose: Evaluate total volume and SLA metrics (breach_rate_percentage, avg_resolution_time) by department
-- Insight: IT has the highest volume and lowest average resolution time,
-- while operations has the highest breach rate % and average resolution time.
-- Operations and Finance are tied for second highest volume and both have higher breach rate %s than IT.
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
-- Insight: Finance only submits High prioirty requests,
-- HR has a high breach rate but a low volume of case examples,
-- IT has a high volume of Critical requests, while having a low breach rate,
-- Operations has mostly 100% breach rate for High priority requests, which is majority of their volume. 
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

-- Purpose: Evaluate the key performance metrics and changes in performance over time
-- Insight: IT has the highest volume while maintaining a consistent breach rate,
-- Operations has stable case volume, but their breach rate and resolution time are increasing, indicating strain
-- Recommendation: We will need to investigate case examples, workflows, and standards to see what has changed in the past 2 months.
SELECT
	DATE_TRUNC('month', created_at) AS month,
	department,
	COUNT (*) AS total_cases,
	SUM(CASE WHEN sla_breached = 'Yes' THEN 1 ELSE 0 END) AS cases_breached,
	ROUND(
        SUM(CASE WHEN sla_breached = 'Yes' THEN 1 ELSE 0 END)::decimal 
        / COUNT(*) * 100, 2) AS breach_rate,
	ROUND(AVG(resolution_time_hours), 2) AS avg_resolution_time
FROM internal_requests
GROUP BY 1,2
ORDER BY 2,1

-- Purpose: Evaluate breach_rate_percentage and avg_resolution_time based on service_type,
-- Insight: Majority of service types only have 1 case example,
-- at a glance we can see there are a significant number of AI tags, which could we could sum for however, 
-- AI tags have a low breach rate on average.
-- Access Requests and Password Resets have higher volume - these are operational requests
-- Recommendation: Investigate applications being used or root cause of Access Requests and Password Resets,
-- to see if there are trends that can be aided by systematic improvement
-- [Meta Observation]: This type of analysis would benefit from a larger dataset because we could further group examples to find trends,
-- a potential challenge of this would be grouping if there are a lot of unique service_types
SELECT
    service_type,
    COUNT(*) AS total_requests,
    ROUND(
        SUM(CASE WHEN sla_breached = 'Yes' THEN 1 ELSE 0 END)::decimal 
        / COUNT(*) * 100, 2
    ) AS breach_rate_percentage,
	ROUND(AVG(resolution_time_hours), 2) AS avg_resolution_time
FROM internal_requests
GROUP BY service_type;










