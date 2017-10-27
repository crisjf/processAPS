from collections import defaultdict
import pandas as pd,codecs,json,os

path = 'raw_data/aps-dataset-metadata-2016'

journal_data = []
journals = [j for j in os.listdir(path+'/') if '.' not in j]
for journal in journals:
    print journal
    volumes = [v for v in os.listdir(path+'/'+journal) if '.' not in v]
    volume = volumes[0]
    papers = [p for p in os.listdir(path+'/'+journal+'/'+volume) if '.json' in p]
    paper = papers[0]
    filename = path+'/'+journal+'/'+volume+'/'+paper
    pdata = codecs.open(filename,encoding='utf-8').read()
    pdata = json.loads(pdata)
    jdata = defaultdict(lambda:'NULL',pdata['journal'])
    journal_data.append((jdata['id'],jdata['name'],jdata[u'abbreviatedName']))
journal_data = pd.DataFrame(journal_data,columns=['JID','jname','jabbrev']).drop_duplicates()
journal_data.to_csv('processed_data/journals.csv',index=False,encoding='utf-8')