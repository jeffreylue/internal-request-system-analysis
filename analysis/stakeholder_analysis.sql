/* ============================================================
Section: SLA Performance by Stakeholder

Objective:
Evaluate whether SLA performance differences exist across stakeholder groups

Findings:
Executives submit fewer total requests.
Executives maintain a 0% breach rate.
Executives experience significantly lower average resolution times.
Employees’ average resolution time is more than double that of Executives.

Interpretation:
Performance discrepancies suggest potential stakeholder prioritization bias
or escalation asymmetry within workflow handling.
============================================================ */
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

/* ===========================================================
Objective: Evaluate prioirty classification distribution

Findings:
Executives submit only Critical and High-priority cases.
Employees rarely submit Critical cases and account for most Medium/Low volume.

Interpretation:
Priority escalation behavior differs by stakeholder group.
This may contribute to observed SLA performance asymmetries.
============================================================ */
SELECT
	request_source,
	COUNT (*) as total_requests,
	SUM (CASE WHEN priority = 'Critical' THEN 1 ELSE 0 END) AS total_critical_cases,
	SUM (CASE WHEN priority = 'High' THEN 1 ELSE 0 END) AS total_high_cases,
	SUM (CASE WHEN priority = 'Medium' THEN 1 ELSE 0 END) AS total_medium_cases,
	SUM (CASE WHEN priority = 'Low' THEN 1 ELSE 0 END) AS total_low_cases
	
FROM internal_requests
GROUP BY request_source;

/* ===========================================================
Objective: Evaluate SLA performance by case prioirty

Findings:
High-priority cases exhibit the highest breach rate and longest resolution time.
Medium-priority cases follow.
Critical cases demonstrate comparatively stronger SLA adherence.

Interpretation:
High/Medium-priority workflows may contain inefficiencies,
misclassification patterns, or resource allocation gaps.

Recommendation:
Assess High-priority classification standards to ensure
accurate escalation and resource alignment.
============================================================ */
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
