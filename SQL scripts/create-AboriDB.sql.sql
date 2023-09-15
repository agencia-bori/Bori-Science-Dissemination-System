-- Table for storing journal data
CREATE TABLE dbo.journal (
    journal_id int IDENTITY(1, 1) PRIMARY KEY,
    title varchar(300) NULL,
    abbrev_title varchar(300) NULL,
    issn varchar(10) NULL,
    publisher_name varchar(300) NULL
);
GO

-- Table for storing articles' metadata
CREATE TABLE dbo.article (
    article_id int IDENTITY(1, 1) PRIMARY KEY,
    journal_id int FOREIGN KEY REFERENCES journal(journal_id),
    title varchar(300) NULL,
    doi varchar(200) NULL,
    publication_date date NULL,
    keywords varchar(500) NULL,
    scielo_area_id varchar(500) NULL,
    thematic_area varchar(500) NULL,
    file_name varchar(500) NULL,
    full_file_path varchar(500) NULL
);
GO

-- Table for storing researcher data
CREATE TABLE dbo.researcher (
    researcher_id int IDENTITY(1, 1) PRIMARY KEY,
    orcid varchar(50) NULL,
    name varchar(250) NULL,
    gender int NULL,
    birth_date date NULL,
    institution_id int NULL,
    lab_id int NULL,
    website varchar(100) NULL,
    email varchar(100) NULL,
    mobile_phone1 varchar(20) NULL,
    mobile_phone2 varchar(20) NULL,
    allow_contact binary(1) NULL,
    country varchar(200) NULL,
    region varchar(100) NULL,
    state varchar(100) NULL,
    city varchar(100) NULL
);
GO

-- Table for linking articles and authors
CREATE TABLE dbo.article_authors (
    article_id int FOREIGN KEY REFERENCES article(article_id),
    researcher_id int FOREIGN KEY REFERENCES researcher(researcher_id)
);
GO

-- Table for storing the full text of articles
CREATE TABLE dbo.article_fulltext (
    article_id int PRIMARY KEY FOREIGN KEY REFERENCES article(article_id),
    content varchar(max) NULL
);
GO

-- Table for storing processed results of articles
CREATE TABLE dbo.article_analysis (
    article_id int PRIMARY KEY FOREIGN KEY REFERENCES article(article_id),
    summary varchar(max) NULL,
    summary_en varchar(max) NULL,
    headlines varchar(max) NULL,
    target_audience varchar(500) NULL,
    inferred_theme varchar(500) NULL,
    inferred_keywords varchar(500) NULL,
    inferred_area varchar(500) NULL,
    inferred_conclusion varchar(max) NULL
);
GO
