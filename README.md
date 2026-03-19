# Incubyte Salary Management API

## Overview

This application is a **RESTful API** built to manage employee data and perform salary-related calculations and analytics.

It supports:

* Employee CRUD operations
* Salary deduction calculations
* Salary metrics and analytics

The application follows **Test-Driven Development (TDD)** principles and is designed with clean architecture and scalability in mind.

---

## Tech Stack

* Ruby on Rails
* SQLite (Database)
* RSpec (Testing)

---

## Setup Instructions

### Prerequisites

* Ruby (3.4.4)
* Rails (8.1.2)
* Bundler

### Installation

```bash
git clone <repo_url>
cd salary_management
bundle install
rails db:create db:migrate
```

### Run Server

```bash
rails s
```

### Run Tests

```bash
bundle exec rspec
```

---

## API Endpoints

### 1. Employee CRUD

| Method | Endpoint       | Description        |
| ------ | -------------- | ------------------ |
| GET    | /employees     | List all employees |
| GET    | /employees/:id | Fetch employee     |
| POST   | /employees     | Create employee    |
| PUT    | /employees/:id | Update employee    |
| DELETE | /employees/:id | Delete employee    |

#### Required Fields

* `full_name`
* `job_title`
* `country`
* `salary`

---

### 2. Salary Calculation

#### Endpoint

```
GET /employees/:id/salary_breakdown
```

#### Description

Returns salary breakdown including deductions and net salary.

#### Deduction Rules

* India → 10% TDS
* United States → 12% TDS
* Others → No deduction

#### Sample Response

```json
{
  "employee_id": 1,
  "full_name": "Sowmya",
  "country": "India",
  "gross_salary": 100000.0,
  "tds": 10000.0,
  "net_salary": 90000.0
}
```

---

### 3. Salary Metrics

#### Endpoint

```
GET /employees/salary_metrics
```

#### Query Params

* `country`
* `job_title`

#### Examples

**By Country**

```
/employees/salary_metrics?country=India
```

Response:

```json
{
  "country": "India",
  "min_salary": 10000.0,
  "max_salary": 20000.0,
  "avg_salary": 15000.0
}
```

**By Job Title**

```
/employees/salary_metrics?job_title=Engineer
```

Response:

```json
{
  "job_title": "Engineer",
  "avg_salary": 20000.0
}
```

---

## Validations

* Presence validation for all fields
* Salary must be numeric and greater than 0

---

## Testing Strategy (TDD)

This project strictly follows **Test-Driven Development**:

1. Write failing tests
2. Implement minimal code
3. Refactor

### Test Coverage Includes:

* Employee model validations
* CRUD endpoints
* Salary calculation logic
* Salary metrics (including edge cases)

---

## Architecture & Design Decisions

### 1. Service Objects

Business logic is extracted into service classes:

* `SalaryCalculator`
* `SalaryMetrics`

This keeps controllers thin and improves testability.

---

### 2. Database-Level Aggregation

Salary metrics use SQL functions:

* `MIN`
* `MAX`
* `AVG`

This ensures:

* Better performance
* Reduced memory usage

---

### 3. Error Handling

* Graceful handling of empty datasets
* Clear API error responses

---

### 4. Scalability Considerations

* Query optimization using aggregation
* Index-ready fields (`country`, `job_title`)
* Extensible service layer

---

## Implementation Details (AI Usage)

AI tools (ChatGPT) were used for:

* Scaffolding initial CRUD structure
* Generating test cases (RSpec)
* Optimizing service objects
* Drafting this README

### Rationale

* Improved development speed
* Helped explore multiple design approaches
* Ensured clean and maintainable code

All generated code was:

* Reviewed manually
* Refactored for clarity and performance
* Tested thoroughly using TDD

---

## Future Improvements

* Add authentication (JWT)
* Pagination & filtering
* Caching for metrics (Redis)

---

## Author

Sowmya M R

---

## Submission

This repository is submitted as part of the Incubyte engineering hiring process.

Thank you for the opportunity!
