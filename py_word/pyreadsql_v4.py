from docx import Document
from docx.shared import Inches
from docx.oxml import OxmlElement, ns
import re
import pathlib

filePath = ""+str(pathlib.Path(__file__).parent.resolve())+"/sql/sp_sample.sql"

#fd = open(filePath, encoding="utf-8")
#encoding="ISO-8859-1"
#encoding="utf8"
with open(filePath, encoding="utf-16le", errors='ignore') as fd:
    sqlFile = fd.read()
wh_result = re.findall(r'IN ((.*)', sqlFile)
print(wh_result)
#print(type(sqlFile))
"""
fd = open("/workspace/py_word/py_word/sql/sp_sample.sql", encoding="utf-8")
sqlFile = fd.read()
#print(sqlFile)
print(type(u'疑癮'))
sq_result = re.findall('insert(.*)values|from(.*)where|update(.*)set', sqlFile)

wh_result = re.findall(r'(\w+) = (\w+)', sqlFile)
print(pathlib.Path(__file__).parent.resolve())
#print('start')
#print(sq_result)
#print(wh_result)
#print('end')

#iq_result = re.findall('insert(.*)values', sqlFile)
#print(iq_result)

#uq_result = re.findall('update(.*)set', sqlFile)
#print(uq_result)


fd.close()
s = 'asdf=5;iwantthis123jasd'
result = re.search('asdf=5;(.*)123jasd', s)"""