-- Purpose: Evaluate monthly trends in macro performance (total_requests, breached_requests,breach_rate_percentage)
-- Insight: Increasing breach rate over time,
-- while April shows a spike in breach rate.
SELECT 
    DATE_TRUNC('month', created_at) AS month,
    COUNT(*) AS total_requests,
    SUM(CASE WHEN sla_breached = 'Yes' THEN 1 ELSE 0 END) AS breached_requests,
    ROUND(
        SUM(CASE WHEN sla_breached = 'Yes' THEN 1 ELSE 0 END)::decimal 
        / COUNT(*) * 100, 2
    ) AS breach_rate_percentage
FROM internal_requests
GROUP BY 1
ORDER BY 1;

-- Purpose: View 2 major request sources and evaluate monthly volume trend
-- Insight: Employees submit more than twice the number of requests compared to Executives,
-- while overall request volume remains stable over time.
SELECT 
    DATE_TRUNC('month', created_at) AS month,
    request_source,
    COUNT(*) AS total_requests
FROM internal_requests
GROUP BY 1, 2
ORDER BY 1, 2;
