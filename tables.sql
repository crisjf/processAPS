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
	DOI_s VARCHAR(40) NOT NULL,
	DOI_t VARCHAR(10) NOT NULL,
	CONSTRAINT citationspk PRIMARY KEY (DOI_s,DOI_t),
	CONSTRAINT citations_sFk FOREIGN KEY (DOI_s) REFERENCES papers(DOI),
	CONSTRAINT citations_tFk FOREIGN KEY (DOI_t) REFERENCES papers(DOI)
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

CREATE TABLE authors (
	AID INT NOT NULL,
	first_name VARCHAR(40),
	surname VARCHAR(120),
	name VARCHAR(150),
	is_person boolean,
	CONSTRAINT authorspk PRIMARY KEY (AID)
);

CREATE TABLE journals (
	JID VARCHAR(10) NOT NULL,
	jname VARCHAR(60),
	jabbrevname VARCHAR(30),
	CONSTRAINT journalspk PRIMARY KEY (JID)
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

CREATE TABLE discipline_concept (
	DOI VARCHAR(40)   NOT NULL,
	d_id VARCHAR(40) NOT NULL,
	CONSTRAINT discipline_paperFk FOREIGN KEY (DOI) REFERENCES papers(DOI),
	CONSTRAINT discipline_disciplineFk FOREIGN KEY (d_id) REFERENCES disciplines(d_id)
);
