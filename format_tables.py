import pandas as pd

authors = pd.read_csv('processed_data/authors.csv',encoding='utf-8')
paper_author = pd.read_csv('processed_data/paper_author.csv',encoding='utf-8')
affiliations = pd.read_csv('processed_data/affiliations.csv',encoding='utf-8')
journal_data = pd.read_csv('processed_data/journals.csv',encoding='utf-8')
papers_out = pd.read_csv('processed_data/papers_out.csv',encoding='utf-8')
subjectareas = pd.read_csv('processed_data/subjectareas.csv',encoding='utf-8')
paper_subjectarea = pd.read_csv('processed_data/paper_subjectarea.csv',encoding='utf-8')
concepts = pd.read_csv('processed_data/concepts.csv',encoding='utf-8')
paper_concept = pd.read_csv('processed_data/paper_concept.csv',encoding='utf-8')
disciplines = pd.read_csv('processed_data/disciplines.csv',encoding='utf-8')
paper_discipline = pd.read_csv('processed_data/paper_discipline.csv',encoding='utf-8')
citations = pd.read_csv('raw_data/aps-dataset-citations-2016/aps-dataset-citations-2016.csv',encoding='utf-8')

authors = authors[['AID','firstname','surname','name','person']].fillna('NULL')
for col in ['firstname','surname','name']:
	authors[col] = authors[col].str.replace('|',';')
paper_author = paper_author[['DOI','AID']].fillna('NULL')
affiliations = affiliations[['DOI','AID','af_name']].fillna('NULL')
affiliations['af_name'] = affiliations['af_name'].str.replace('|',';')
journal_data = journal_data[['JID','jname','jabbrev']].fillna('NULL')
papers_out = papers_out[['DOI','JID','date','year','month','title','volume','issue','numpages']].fillna('NULL')
papers_out['title'] = papers_out['title'].str.replace('|',';')
papers_out['numpages'] = papers_out['numpages'].astype(str)
papers_out.loc[papers_out['numpages']==' ','numpages'] = 'NULL'
papers_out.loc[papers_out['numpages']=='','numpages'] = 'NULL'
subjectareas = subjectareas[['sa_id','sa_label']].dropna()
paper_subjectarea = paper_subjectarea[['DOI','sa_id']].dropna()
paper_subjectarea = paper_subjectarea[paper_subjectarea['sa_id'].isin(set(subjectareas['sa_id']))]
concepts = concepts[['c_id','c_label']].fillna('NULL')
paper_concept = paper_concept[['DOI','c_id']].fillna('NULL')
disciplines = disciplines[['d_id','d_label']].fillna('NULL')
paper_discipline = paper_discipline[['DOI','d_id']].fillna('NULL')
citations = citations[['citing_doi','cited_doi']].dropna().drop_duplicates()

dois = set(papers_out['DOI'])
citations = citations[(citations['citing_doi'].isin(dois))&(citations['cited_doi'].isin(dois))]

authors.to_csv('processed_data/authors_db.csv',index=False,encoding='utf-8',sep='|',header=False)
paper_author.to_csv('processed_data/paper_author_db.csv',index=False,encoding='utf-8',sep='|',header=False)
affiliations.to_csv('processed_data/affiliations_db.csv',index=False,encoding='utf-8',sep='|',header=False)
journal_data.to_csv('processed_data/journals_db.csv',index=False,encoding='utf-8',sep='|',header=False)
papers_out.to_csv('processed_data/papers_out_db.csv',index=False,encoding='utf-8',sep='|',header=False)
subjectareas.to_csv('processed_data/subjectareas_db.csv',index=False,encoding='utf-8',sep='|',header=False)
paper_subjectarea.to_csv('processed_data/paper_subjectarea_db.csv',index=False,encoding='utf-8',sep='|',header=False)
concepts.to_csv('processed_data/concepts_db.csv',index=False,encoding='utf-8',sep='|',header=False)
paper_concept.to_csv('processed_data/paper_concept_db.csv',index=False,encoding='utf-8',sep='|',header=False)
disciplines.to_csv('processed_data/disciplines_db.csv',index=False,encoding='utf-8',sep='|',header=False)
paper_discipline.to_csv('processed_data/paper_discipline_db.csv',index=False,encoding='utf-8',sep='|',header=False)
citations.to_csv('processed_data/citations_db.csv',index=False,encoding='utf-8',sep='|',header=False)