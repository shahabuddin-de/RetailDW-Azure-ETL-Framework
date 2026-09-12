# RetailDW – Metadata-Driven Azure Data Factory ETL Framework

Enterprise-style Azure Data Engineering project built using Azure Data Factory, Azure SQL Database, SQL Server, ADLS Gen2, Parquet and Self-hosted Integration Runtime (SHIR).


Project Overview

RetailDW is a metadata-driven ETL framework that ingests SQL Server tables into Azure Data Lake Storage Gen2 using reusable Azure Data Factory pipelines.

The framework supports:

* Full Load
* Incremental Load (Watermark Based)
* Automatic Onboarding of New Tables
* Centralized Metadata Management
* ETL Execution Logging
* Independent Schema Validation Pipeline



🏗️ Solution Architecture

Architecture diagram available inside /architecture.


🔄 Pipelines

1. PPL_SQLServer_ADLS_Incremental_and_full

Core reusable ETL pipeline.

Features:

* Reads metadata from Azure SQL.
* Performs Full or Incremental Load dynamically.
* Copies SQL Server data into ADLS Gen2 as Parquet.
* Updates watermark after successful execution.
* Logs execution status.

2. PL_Controller_AutoOnboarding

Controller pipeline.

Features:

* Detects newly created SQL Server tables.
* Inserts metadata automatically into ETL_Metadata.
* Executes the ETL pipeline.

3. PL_Schema_Validation

Independent validation pipeline.

Features:

* Compares source and target column counts.
* Logs PASS/FAIL validation results.
* Keeps ETL pipeline untouched.


⚙️ Tech Stack

Service	Purpose
Azure Data Factory	ETL Orchestration
SQL Server	Source Database
Azure SQL Database	Metadata & Logging
ADLS Gen2	Parquet Landing Zone
SHIR	SQL Server Connectivity
Parquet	Storage Format
PySpark	Future Transformations



⭐ Key Features

* Metadata-driven ETL architecture.
* Watermark-based Incremental Loading.
* Automatic table onboarding.
* Azure SQL metadata repository.
* Execution logging with stored procedures.
* Schema validation pipeline.


👨‍💻 Author

Built as an end-to-end Azure Data Engineering portfolio project.


