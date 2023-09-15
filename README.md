# Bori-Science-Dissemination-System
System for Agência Bori to curate and disseminate scientific studies. Includes a Flask app, SQL scripts, ETL tools for XML, and a PowerBI template. Harnesses Generative AI for efficient science communication

## Table of Contents
- [Goals](#goals)
- [Overview](#overview)
  - [Info Retrieved from Database](#info-retrieved-from-database)
  - [Curatorial Assistance](#curatorial-assistance)
  - [For ABori Publications](#for-abori-publications)
- [Folder Structure](#folder-structure)
- [How to Use](#how-to-use)
  - [Prerequisites](#prerequisites)
  - [Setting up the Database](#setting-up-the-database)
  - [Setting up Azure Data Factory Pipeline](#setting-up-azure-data-factory-pipeline)
  - [Installing and Running Flask App](#installing-and-running-flask-app)
  - [Additional Setup for PowerBI and Bicep](#additional-setup-for-powerbi-and-bicep)
- [Components](#components)
- [ETL Process: Extract, Transform, Load](#etl-process-extract-transform-load)
- [Database Tables](#database-tables)
- [Power BI Dashboard: Insights at a Glance](#power-bi-dashboard-insights-at-a-glance)

## Goals

SciBoriReporter aims to streamline the curation and reporting process for scientific articles by:
1. **Automating the Summarization of Abstracts**: To make articles more digestible for journalists, laypeople, and the public.
2. **Assisting in Curation**: Providing automated insights on the potential newsworthiness, uniqueness, and public impact of an article.
3. **Storing and Retrieving Article Details**: Using a structured database to store article metadata, summaries, and curation insights.
4. **Seamlessly Integrating Data**: Through an ETL process that ensures data integrity, timeliness, and accessibility.
5. **Data Analytics with Power BI**: Deliver insightful data visualizations and analytics to stakeholders, facilitating data-driven decision-making and strategic planning.

## 📑 **Overview**

### **Info Retrieved from Database**

- **Title**: The title of the academic article.
- **Institution**: Academic or research institution associated with the article.
- **Authors**: Individuals who contributed to the article.
- **Abstract**: Brief summary of the article's content.
- **Keywords**: Tags or phrases associated with the content and theme of the article.
- **Journal**: The academic journal where the article was published.

### **Curatorial Assistance**

In order to aid the curation process, we have incorporated a series of prompts and buttons, which will gauge:

- The likelihood of the article making the news.
- Whether the study presents new, groundbreaking information.
- The potential impact of the study's results on the general public.

### **For ABori Publications**

The following data points will be generated to assist journalists in producing a concise, yet comprehensive, summary or news piece:

- **Summary**: A condensed version of the article.
- **Layman's Summary**: A translation of the article into terms easily understood by the general public.
- **Main Results**: Key findings of the study.
- **Short News Piece**: A brief news article based on the academic article.
- **Detailed News Piece**: A news article that delves deeper, including details about the main results, affiliated institutions, the study's objectives, methodologies employed by the researchers, and the main conclusions.
- **Bullet-point Headlines**: Quick highlights of the article's key points.
- **Target Audiences**: Specific groups or demographics who might be particularly interested in or affected by the article's findings.

Our aim is to provide a seamless interface where abstracts can be submitted, reviewed, and transformed into engaging news pieces, making scientific knowledge more accessible to all.

## Folder strucure

```plaintext
.
├── README.md
├── BoriSciReporter
│   ├── .gitignore
│   ├── config.py
│   ├── requirements.txt
│   ├── run.py
│   ├── app
│   │   ├── routes.py
│   │   ├── __init__.py
│   │   ├── static
│   │   │   ├── css
│   │   │   │   └── main.css
│   │   │   ├── images
│   │   │   │   ├── agenciabori-favicon-solid.jpg
│   │   │   │   ├── pdf.htm
│   │   │   │   ├── pdf.jfif
│   │   │   │   └── pdf_337946.htm
│   │   │   └── js
│   │   │       └── main.js
│   │   ├── templates
│   │   │   ├── paper_details.html
│   │   │   └── paper_details_old.html
│   │   └── __pycache__
│   │       ├── routes.cpython-310.pyc
│   │       └── __init__.cpython-310.pyc
│   └── __pycache__
│       └── config.cpython-310.pyc
├── ETL
│   ├── AboriDB-XML-Ingestion.ipynb
│   └── Extract text from XML.ipynb
├── PowerBI
│   └── aBori-Curatorship-Dash.pbix
├── Sample
│   └── 1807-0337-soc-24-61-0198.xml
└── SQL scripts
    └── create-AboriDB.sql.sql
```


## How to Use

### Prerequisites:

- Ensure you have Azure CLI and Azure Data Factory CLI installed.
- Python and Pip should be installed on your system.

### Setting up the Database:

- Navigate to the `sql_scripts` directory.
- Use the provided SQL script (`create_tables.sql`) to create the necessary tables in your database.

### Setting up Azure Data Factory Pipeline:

- First, log in to your Azure account using Azure CLI.
- Set up the Azure Data Factory pipeline using the ADF command with the pipeline name and the path to the definition file.
- Schedule the pipeline to execute whenever new data arrives at the blob storage.

### Installing and Running Flask App:

- Navigate to the root directory of the `BoriSciReporter` application.
- Install the required Python packages using the `requirements.txt` file.
- Set the Flask environment variables: specify the Flask app as `run.py` and choose between a `development` or `production` environment.
- Initiate the Flask app. Once started, you'll see a message indicating that the server is operational. Access the BoriSciReporter web application by navigating to the provided link in your browser.

### Additional Setup for PowerBI and Bicep:

- **PowerBI**: Load the PowerBI template located within the `powerBI` directory to visualize your data.
  
- **Bicep**: Go to the `bicep` directory and deploy your bicep files to configure Azure resources as per your project requirements.



## Components

### Flask App (`app.py`)

Handles the application's routes, interactions with the database, and summary generation using OpenAI's GPT.

### Templates (`templates/`)

HTML templates that render the data and provide interfaces for users.

### Static Content (`static/`)

Comprises styling (CSS), frontend scripts (JS), and images for the application.

## ETL Process: Extract, Transform, Load

The ETL (Extract, Transform, Load) process is responsible for taking data from raw XML files, extracting meaningful information, transforming it into a structured format, and then loading it into our database.

### Extract Text from XML

The first part of our ETL process deals with the extraction of relevant content from XML files. These XML files contain information about academic papers, including metadata and full-text content.

Function `extract_data_from_xml` performs this extraction:
- `journal_title`, `issn`, `abbrev_journal_title`, and `publisher_name` for journal information.
- Article data like `article_title`, `abstract`, and `full_text`.
- Authors' data, identified by their names.
- Keywords associated with the paper.

### AboriDB-XML-Ingestion

Once data is extracted, it needs to be ingested into the Abori Database.

Function `connect_to_db` is responsible for establishing a connection to the Azure SQL database.

Function `insert_data_to_db` inserts the data:
- Journal data is inserted into the `journal` table.
- Article data, including extracted keywords, is inserted into the `article` table.
- Authors are inserted into the `researcher` table if not already present and linked to articles in the `article_authors` table.
- The full text of the articles is stored in the `article_fulltext` table.

The `get_or_create_researcher_id` function ensures that if a researcher is already in the database, it fetches their ID. Otherwise, a new entry is made.

### Azure Data Factory (ADF) and Managed Identity

To automate and manage this ETL process, we use Fabric ADF pipelines. The pipeline is set to trigger as soon as new XMLs containing paper information arrive at the Azure Blob Storage. This ensures timely processing and ingestion of new data.

Additionally, for enhanced security and ease of management, we connect to Azure SQL using Azure's Managed Identity. This way, we don't need to manage or rotate database credentials manually; Azure takes care of it, ensuring that our connection is both seamless and secure.

Remember to replace placeholders like `YOUR_SERVER_NAME`, `YOUR_USER_ID`, and `YOUR_PASSWORD` with your actual credentials or connection details before executing the scripts.


## Database Tables

### 1. journal
Stores information about the various journals.
- `journal_id`: Unique identifier for each journal.
- `title`: Title of the journal.
- `abbrev_title`: Abbreviated title of the journal.
- `issn`: ISSN number of the journal.
- `publisher_name`: Publisher's name of the journal.

### 2. article
Stores metadata about articles.
- `article_id`: Unique identifier for each article.
- `journal_id`: Foreign key linking to the `journal` table.
- `title`: Title of the article.
- `doi`: DOI (Digital Object Identifier) for the article.
- `publication_date`: Publication date of the article.
- `keywords`: Keywords associated with the article.
- `scielo_area_id`: Scielo area identifier.
- `thematic_area`: Thematic area of the article.
- `file_name`: File name of the stored article.
- `full_file_path`: Complete path to the stored article file.

### 3. researcher
Stores data about researchers or authors.
- `researcher_id`: Unique identifier for each researcher.
- `orcid`: ORCID identifier for the researcher.
- `name`: Name of the researcher.
- `gender`: Gender of the researcher.
- `birth_date`: Birthdate of the researcher.
- `institution_id`: Identifier for the institution the researcher is affiliated with.
- `lab_id`: Identifier for the lab the researcher works in.
- `website`: Researcher's personal website or portfolio.
- `email`: Researcher's email.
- `mobile_phone1`: Primary mobile number.
- `mobile_phone2`: Secondary mobile number.
- `allow_contact`: Flag indicating whether the researcher can be contacted.
- `country`: Researcher's country.
- `region`: Researcher's region.
- `state`: Researcher's state.
- `city`: Researcher's city.

### 4. article_authors
Table that links articles to their respective authors.
- `article_id`: Foreign key linking to the `article` table.
- `researcher_id`: Foreign key linking to the `researcher` table.

### 5. article_fulltext
Stores the full text of articles.
- `article_id`: Foreign key linking to the `article` table.
- `content`: Full content or body of the article.

### 6. article_analysis
Stores the processed results of the articles.
- `article_id`: Foreign key linking to the `article` table.
- `summary`: Summary of the article in the original language.
- `summary_en`: English summary of the article.
- `headlines`: Extracted or generated headlines for the article.
- `target_audience`: Target audience for the article.
- `inferred_theme`: Inferred theme or subject of the article.
- `inferred_keywords`: Extracted or inferred keywords.
- `inferred_area`: Inferred research area or domain.
- `inferred_conclusion`: Inferred or extracted conclusion of the article.

## Power BI Dashboard: Insights at a Glance

Our Power BI dashboard offers a comprehensive view of the scientific papers' data and insights, split into various tabs that cater to different analytical needs:

### Side Menu Overview
The side menu provides a quick snapshot of the data:
- **Total Scientific Papers:** Count of all scientific papers available in our database.
- **Reviewed Papers:** Count of papers that underwent review.
- **Accepted Papers:** Count of papers deemed ready for offering to journalists.

### Tabs on Power BI

1. **Topics Tab:**
   - **Knowledge Area:** Visual distribution of papers across different knowledge areas.
   - **Themes Count:** Count of papers categorized by themes.
   - **Keywords Word Cloud:** A visual representation of the frequency of keywords across papers.
   - **Table Overview:** This table showcases the likelihood of an article being published, its title, authors, institution, journal, impact factor, and a link to "Submit Review" which triggers the Flask app. Additionally, it displays the review status, indicating if it's reviewed and whether it's accepted.

2. **Diversity Tab:**
   - **By Region:** Distribution of papers across various regions.
   - **By State:** Distribution of papers by state.
   - **By Gender:** Visual representation of paper authorship split by gender.
   - **Table Overview:** Similar to the "Topics" tab, this table provides a detailed view of each paper, its authors, and review status.

3. **Trends Tab:** Under construction. Stay tuned for insights on emerging trends in the data.

4. **Engagement Tab:** Under construction. Keep an eye out for metrics and insights related to user engagement and paper outreach.

Our Power BI dashboard ensures that stakeholders have clear, visual, and timely insights from the data, enabling data-driven decision-making and strategic planning.
