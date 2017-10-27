from collections import defaultdict
import pandas as pd,codecs,json,os

path = 'raw_data/aps-dataset-metadata-2016'

papers_out = []
journals = [j for j in os.listdir(path+'/') if '.' not in j]
for journal in journals:
    volumes = [v for v in os.listdir(path+'/'+journal) if '.' not in v]
    for volume in volumes:
        papers = [p for p in os.listdir(path+'/'+journal+'/'+volume) if '.json' in p]
        for paper in papers:
            filename = path+'/'+journal+'/'+volume+'/'+paper
            pdata = codecs.open(filename,encoding='utf-8').read()
            pdata = json.loads(pdata)
            title = defaultdict(lambda:'NULL',pdata['title'])
            date = pdata['date'].split('-')
            if 'numPages' in pdata.keys():
                numPages = pdata['numPages']
            else:
                numPages = 'NULL'
            if len(date)<2:
                date = ['NULL','NULL']
            papers_out.append((pdata['identifiers']['doi'],title['value'],title['format'],journal,volume,pdata['issue']['number'],numPages,pdata['date'],date[0],date[1]))
papers_out = pd.DataFrame(papers_out,columns=['DOI','title','title_format','JID','volume','issue','numpages','date','year','month'])
papers_out.to_csv('processed_data/papers_out.csv',index=False,encoding='utf-8')