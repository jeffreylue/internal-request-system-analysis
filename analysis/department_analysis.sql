/*--------------------------------------------------------------------------
Department-level SLA performance
Objective:
Evaluate total request volume and SLA performance by department.

Findings: IT handles the highest request volume while maintaining the lowest 
average resolution time and comparatively low breach rate.
Operations has the highest breach rate and longest average resolution time.
Operations and Finance are tied for second-highest volume, 
both with higher breach rates than IT.

Interpretation: Operational strain appears concentrated within Operations, 
despite stable comparative volume. 
---------------------------------------------------------------------------*/
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

/*--------------------------------------------------------------
Section: Priority × Department Cross Analysis
Objective: 
Evaluate how priority distribution within departments 
impacts SLA performance trends.

Findings:
Finance submits exclusively High-priority cases.
HR exhibits a high breach rate but low total volume.
IT manages a high volume of Critical cases with low breach rates.
Operations shows near-total breach rates for High-priority cases,
which represent the majority of its request volume.

Interpretation:
High-priority handling within Operations appears to be 
a primary driver of system-level SLA breaches.
-----------------------------------------------------------------*/
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

/*-----------------------------------------------------------------------------------
Section: Department Performance Over Time
Objective: 
Evaluate trends in volume, breach rate, and resolution time by department.

Findings:
IT maintains the highest volume with a stable breach rate.
Operations shows stable volume but increasing breach rate 
and resolution time over recent months.

Interpretation:
Rising breach rate without corresponding volume increase 
suggests operational inefficiency or workflow degradation.

Recommendation:
Conduct targeted workflow review for Operations, 
focusing on changes implemented within the past two months
(system, workflow, and nature of cases).
---------------------------------------------------------------------------------- */
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

/*--------------------------------------------------------------------------
Section: Service Type Performance Review
Objective:
Evaluate SLA performance across service types to identify 
operational bottlenecks and automation opportunities.

Findings:
Most service types contain only one case instance, 
limiting trend reliability.
AI-tagged cases appear frequently and maintain relatively low breach rates.
Access Requests and Password Resets show higher volume and represent
operationally repetitive tasks.

Interpretation:
Recurring operational requests may present opportunities 
for workflow optimization or automation.

Recommendation:
Investigate root causes behind Access Requests and Password Resets 
to identify systematic improvement opportunities.

Meta Consideration:
This type of analysis would benefit from a larger dataset
because we could further group examples and trends would be more reliable.
--------------------------------------------------------------------------*/
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
