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
	CONSTRAINT paper_author_paperFk FOREIGN KEY REFERENCES papers(DOI),
	CONSTRAINT paper_author_authorFk FOREIGN KEY REFERENCES authors(AID)
);

CREATE TABLE affiliations (
	DOI VARCHAR(40) NOT NULL,
	AID INT NOT NULL,
	aff_name VARCHAR(800),
	CONSTRAINT affiliations_paperFk FOREIGN KEY REFERENCES papers(DOI),
	CONSTRAINT affiliations_authorFk FOREIGN KEY REFERENCES authors(AID)
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
	JID VARCHAR(10),
	jname VARCHAR(60),
	jabbrevname VARCHAR(30),
	CONSTRAINT journalspk PRIMARY KEY (JID)
);

