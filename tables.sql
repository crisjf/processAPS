CREATE TABLE journals (
	JID VARCHAR(10) NOT NULL,
	jname VARCHAR(60),
	jabbrevname VARCHAR(30),
	CONSTRAINT journalspk PRIMARY KEY (JID)
);

CREATE TABLE papers (
	DOI VARCHAR(40)   NOT NULL,
	JID VARCHAR(10),
	dt DATE,
	yr int,
	mth int,
	title VARCHAR(4000),
	volume int,
	issue VARCHAR(10),
	numpages int,
	CONSTRAINT paperspk PRIMARY KEY (DOI),
	CONSTRAINT paper_journalFk  FOREIGN KEY (JID) REFERENCES journals(JID)
);

CREATE TABLE citations (
	DOI_citing VARCHAR(40) NOT NULL,
	DOI_cited VARCHAR(40) NOT NULL,
	CONSTRAINT citationspk PRIMARY KEY (DOI_citing,DOI_cited),
	CONSTRAINT citations_sFk FOREIGN KEY (DOI_citing) REFERENCES papers(DOI),
	CONSTRAINT citations_tFk FOREIGN KEY (DOI_cited) REFERENCES papers(DOI)
);

CREATE TABLE authors (
	AID INT NOT NULL,
	first_name VARCHAR(40),
	surname VARCHAR(120),
	name VARCHAR(150),
	is_person boolean,
	CONSTRAINT authorspk PRIMARY KEY (AID)
);

CREATE TABLE paper_author (
	DOI VARCHAR(40) NOT NULL,
	AID INT NOT NULL,
	CONSTRAINT paper_authorpk PRIMARY KEY (DOI,AID),
	CONSTRAINT paper_author_paperFk FOREIGN KEY (DOI) REFERENCES papers(DOI),
	CONSTRAINT paper_author_authorFk FOREIGN KEY (AID) REFERENCES authors(AID)
);

CREATE TABLE affiliations (
	DOI VARCHAR(40) NOT NULL,
	AID INT NOT NULL,
	aff_name VARCHAR(800),
	CONSTRAINT affiliations_paperFk FOREIGN KEY (DOI) REFERENCES papers(DOI),
	CONSTRAINT affiliations_authorFk FOREIGN KEY (AID) REFERENCES authors(AID)
);

CREATE TABLE subjectareas (
	sa_id VARCHAR(20) NOT NULL,
	sa_label VARCHAR(30) NOT NULL,
	CONSTRAINT subjectareaspk PRIMARY KEY (sa_id)
);

CREATE TABLE paper_subjectarea (
	DOI VARCHAR(40)   NOT NULL,
	sa_id VARCHAR(20) NOT NULL,
	CONSTRAINT subjectarea_paperFk FOREIGN KEY (DOI) REFERENCES papers(DOI),
	CONSTRAINT subjectarea_areaFk FOREIGN KEY (sa_id) REFERENCES subjectareas(sa_id)
);

CREATE TABLE concepts (
	c_id VARCHAR(40) NOT NULL,
	c_label VARCHAR(75),
	CONSTRAINT conceptspk PRIMARY KEY (c_id)
);

CREATE TABLE paper_concept (
	DOI VARCHAR(40)   NOT NULL,
	c_id VARCHAR(40) NOT NULL,
	CONSTRAINT concept_paperFk FOREIGN KEY (DOI) REFERENCES papers(DOI),
	CONSTRAINT concept_conceptFk FOREIGN KEY (c_id) REFERENCES concepts(c_id)
);

CREATE TABLE disciplines (
	d_id VARCHAR(40) NOT NULL,
	d_label VARCHAR(40),
	CONSTRAINT disciplinespk PRIMARY KEY (d_id)
);

CREATE TABLE paper_discipline (
	DOI VARCHAR(40)   NOT NULL,
	d_id VARCHAR(40) NOT NULL,
	CONSTRAINT discipline_paperFk FOREIGN KEY (DOI) REFERENCES papers(DOI),
	CONSTRAINT discipline_disciplineFk FOREIGN KEY (d_id) REFERENCES disciplines(d_id)
);

COPY INTO journals FROM '/data/APS/processAPS/processed_data/journals_db.csv';
COPY INTO papers FROM '/data/APS/processAPS/processed_data/papers_out_db.csv';
COPY INTO citations FROM '/data/APS/processAPS/processed_data/citations_db.csv';
COPY INTO authors FROM '/data/APS/processAPS/processed_data/authors_db.csv';
COPY INTO paper_author FROM '/data/APS/processAPS/processed_data/paper_author_db.csv';
COPY INTO affiliations FROM '/data/APS/processAPS/processed_data/affiliations_db.csv';
COPY INTO subjectareas FROM '/data/APS/processAPS/processed_data/subjectareas_db.csv';
COPY INTO paper_subjectarea FROM '/data/APS/processAPS/processed_data/paper_subjectarea_db.csv';
COPY INTO concepts FROM '/data/APS/processAPS/processed_data/concepts_db.csv';
COPY INTO paper_concept FROM '/data/APS/processAPS/processed_data/paper_concept_db.csv';
COPY INTO disciplines FROM '/data/APS/processAPS/processed_data/disciplines_db.csv';
COPY INTO paper_discipline FROM '/data/APS/processAPS/processed_data/paper_discipline_db.csv';

CREATE INDEX papers_jid_idx ON papers (JID);
CREATE INDEX papers_doi_idx ON papers (DOI);
CREATE INDEX authors_aid_idx ON authors (AID);
CREATE INDEX paper_author_aid_idx ON paper_author (AID);
CREATE INDEX paper_author_doi_idx ON paper_author (DOI);
CREATE INDEX citations_idx ON citations (DOI_cited);
