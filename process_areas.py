from collections import defaultdict
import pandas as pd,codecs,json,os

path = 'raw_data/aps-dataset-metadata-2016'

sa = []
cc = []
dd = []
journals = [j for j in os.listdir(path+'/') if '.' not in j]
for journal in journals[1:]:
    journal='PRAPPLIED'
    volumes = [v for v in os.listdir(path+'/'+journal) if '.' not in v]
    for volume in volumes[::-1]:
        papers = [p for p in os.listdir(path+'/'+journal+'/'+volume) if '.json' in p]
        for paper in papers:
            filename = path+'/'+journal+'/'+volume+'/'+paper
            pdata = open(filename).read()
            pdata = json.loads(pdata)
            doi = pdata['identifiers']['doi']
            try:
                if 'subjectAreas' in set(pdata[u'classificationSchemes'].keys()):
                    areas = pdata['classificationSchemes'][u'subjectAreas']
                    for area in areas:
                        area = defaultdict(lambda:'NULL',area)
                        sa.append(( doi,area['id'],area['label']))
            except:
                pass
            try:
                if 'physh' in set(pdata[u'classificationSchemes'].keys()):
                    try:
                        concepts = pdata['classificationSchemes'][u'physh']['concepts']
                        for concept in concepts:
                            concept = defaultdict(lambda:'NULL',concept)
                            cc.append(( doi,concept['id'],concept['label']))
                    except:
                        pass
                    try:
                        disciplines = pdata['classificationSchemes'][u'physh']['disciplines']
                        for discipline in disciplines:
                            discipline = defaultdict(lambda:'NULL',discipline)
                            dd.append(( doi,discipline['id'],discipline['label']))
                    except:
                        pass
            except:
                pass
            
        break
    break
sa = pd.DataFrame(sa,columns=['DOI','sa_id','sa_label'])
subjectareas = sa[['sa_id','sa_label']].drop_duplicates()
paper_subjectarea = sa[['DOI','sa_id']].drop_duplicates()

cc = pd.DataFrame(cc,columns=['DOI','c_id','c_label'])
concepts = cc[['c_id','c_label']].drop_duplicates()
paper_concept = cc[['DOI','c_id']].drop_duplicates()

dd = pd.DataFrame(dd,columns=['DOI','d_id','d_label'])
disciplines = dd[['d_id','d_label']].drop_duplicates()
paper_discipline = dd[['DOI','d_id']].drop_duplicates()

print 'subjectareas',len(subjectareas),len(set(subjectareas['sa_id']))
print 'concepts',len(concepts),len(set(concepts['c_id']))
print 'disciplines',len(disciplines),len(set(disciplines['d_id']))


subjectareas.to_csv('processed_data/subjectareas.csv',index=False,encoding='utf-8')
paper_subjectarea.to_csv('processed_data/paper_subjectarea.csv',index=False,encoding='utf-8')

concepts.to_csv('processed_data/concepts.csv',index=False,encoding='utf-8')
paper_concept.to_csv('processed_data/paper_concept.csv',index=False,encoding='utf-8')

disciplines.to_csv('processed_data/disciplines.csv',index=False,encoding='utf-8')
paper_discipline.to_csv('processed_data/paper_discipline.csv',index=False,encoding='utf-8')

