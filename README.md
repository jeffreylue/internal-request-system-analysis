# Internal Request Management System

## Project Overview
This case study simulates an internal request management system where leadership wants to assess the sustainability and fairness of SLA performance across the organization. 
<br>The [dataset](https://github.com/jeffreylue/internal-request-system-analysis/blob/main/data/sample_data.sql) was synthetically generated to reflect common service desk operational patterns.

The objective of this analysis was to determine whether increasing SLA breaches were driven by higher demand, stakeholder behavior, departmental strain, or structural workflow inefficiencies.

Rather than focusing purely on query complexity, this analysis emphasizes structured investigation, business interpretation, and actionable insights. 

## Repository Structure
```
/data
Dataset creation script used to generate the synthetic internal request dataset.

/analysis

monthly_trends.sql
- Monthly macro performance trends
- Monthly request volume by stakeholder

stakeholder_analysis.sql
- SLA performance by stakeholder group
- Priority volume distribution
- SLA performance by case priority

department_analysis.sql
- Department-level SLA performance
- Priority × Department interaction analysis
- Department performance trends over time
- Service type performance review

/images
Query result screenshots used to support key findings.

Executive_Summary.pdf
Concise business summary of findings and recommendations.

README.md
Project documentation and analytical framework.
```
## Business Problem
Leadership observed an increase in SLA breaches and wants to understand the underlying causes.
Key questions include:
<br>•	Is the system experiencing demand overload?
<br>•	Are certain departments under operational strain?
<br>•	Is priority classification influencing performance outcomes? 
<br>•	Are stakeholders experiencing unequal service levels?
<br>
<br>This analysis aims to isolate the primary drivers behind SLA degradation and identify areas requiring operational intervention. 

## Investigation Framework
My analysis followed these structured progressions:
<br>
<br>1.	Monthly Macro Trends (Evaluate overall request volume and breach rates over time)
<br>2.	Stakeholder Analysis (Compare SLA performance between Employees and Executives)
<br>3.	Priority Level Analysis (Assess breach rates and resolution time by case priority level)
<br>4.	Department Performance (Identify operational bottlenecks across departments)
<br>5.	Priority x Department Interaction (Examine structural drivers of breach concentration)
<br>6.	Service Type Review (Explore recurring operational tasks and automation opportunities)
<br>
<br>This layered approach moves from macro-level performance to increasingly granular operational indicators.

## Key Findings
•	Overall request volume has remained stable month-over-month
<br>•	SLA breach rates increased over time, with a notable spike in April
<br>•	Executive requests maintained a 0% breach rate and lower average resolution times
<br>•	High-priority cases exhibited the highest breach rate and longest resolution times
<br>•	The Operations department demonstrated increasing breach rates and resolution times despite stable volume
<br>•	Access Requests and Password Resets represent high-volume, repeatable operational tasks

## Risk & Interpretation
The increase in SLA breaches despite stable volume suggests structural inefficiencies rather than capacity overload. 
<br>
<br>Differences in stakeholder performance may indicate prioritization asymmetry or escalation bias. 
<br>
<br>Operational strain appears concentrated with specific departments and high-priority workflows.

## Recommendations
Immediate
<br>•	Conduct workflow review within Operations Department
<br>•	Audit High-priority case classification standards
<br>
<br>Structural
<br>•	Standardize escalation criteria across stakeholders and request type 
<br>•	Implement ongoing SLA monitoring dashboards
<br>
<br>Modernization Opportunity
<br>•	Explore AI-assisted ticket classification and validation
<br>•	Assess automation potential for recurring operational requests
<br>•	Consider system/workflow adjustments where operational strain is identified
