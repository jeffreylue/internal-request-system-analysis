-- Create table
CREATE TABLE internal_requests (
    request_id SERIAL PRIMARY KEY,
    created_at DATE,
    resolved_at DATE,
    request_source VARCHAR(20),
    department VARCHAR(50),
    service_type VARCHAR(50),
    priority VARCHAR(20),
    resolution_time_hours INT,
    sla_hours INT,
    sla_breached BOOLEAN
);
