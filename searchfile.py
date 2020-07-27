from openpyxl import load_workbook
import glob

wb2 = load_workbook('db.xlsx')

na = []
ta = []
d = {}
a = wb2['Sheet1']  # one way to load a worksheet
names = a['A']
tags = a['B']

for n in names:
    na.append(n.value)

for t in tags:
    ta.append(t.value)
for x in range(len(na)):
    y = {names[x].value: tags[x].value}
    d.update(y)

def search_Tags(t):
    caseN = []
    #split in case of multiple tags
    t1 = t.split(',')
    for u in t1:
        for v in range(len(ta)):
            if (u in ta[v]):
                caseN.append(na[v])
    return caseN

if __name__ == '__main__':
    allCases = []
    #for searching by queries, use search_Tags func with any tags.
    s = search_Tags("robbery")
    for g in glob.glob("Cases/*.pdf"):
        h1 = g.replace("Cases/", "")
        h1 = g.replace(".pdf", "")

        if (h1 in s):
            allCases.append(g)
    #all cases with tags are in array, can use to send files
    print(allCases)
