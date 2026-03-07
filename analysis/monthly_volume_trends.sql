/* ============================================================
// Monthly Macro Performance Trends //

Objective:
Evaluate overall system performance over time,
including total request volume and SLA breach rate.

Findings:
Overall request volume remains relatively stable month-over-month.
Breach rate shows an upward trend over time.
April exhibits a noticeable spike in breach rate.

Interpretation:
Increasing breach rate without significant volume growth
suggests emerging operational inefficiencies rather than capacity overload.
The April spike may indicate a discrete operational disruption
or workflow change requiring further review.
============================================================ */
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

/* ============================================================
// Monthly Volume by Stakeholder //

Objective:
Evaluate whether stakeholder submission patterns
contribute to macro performance trends.

Findings:
Employees consistently submit more than twice the number of requests
compared to Executives.
Overall volume remains stable across stakeholder groups.

Interpretation:
Stable stakeholder distribution suggests that
rising breach rates are unlikely driven by shifts
in submission behavior between Executives and Employees.
Further departmental or priority-level analysis is required.
============================================================== */
-- Monthly Volume by Stakeholder [SQL Query] --
SELECT 
    DATE_TRUNC('month', created_at) AS month,
    request_source,
    COUNT(*) AS total_requests
FROM internal_requests
GROUP BY 1, 2
ORDER BY 1, 2;

/* =========================================================================
// Department-level SLA performance //

Objective:
Evaluate total request volume and SLA performance by department.

Findings: IT handles the highest request volume while maintaining the lowest 
average resolution time and comparatively low breach rate.
Operations has the highest breach rate and longest average resolution time.
Operations and Finance are tied for second-highest volume, 
both with higher breach rates than IT.

Interpretation: Operational strain appears concentrated within Operations, 
despite stable comparative volume. 
========================================================================= */
-- Department-level SLA performance [SQL Query] --
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
