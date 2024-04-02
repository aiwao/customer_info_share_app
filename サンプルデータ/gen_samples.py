import random

_chars = 'あいうえおかきくけこがぎぐげごさしすせそざじずぜそたちつてとだぢづでどなにぬねのはひふへほばびぶべぼぱぴぷぺぽやゆよわん'

_types = (
  '有限会社',
  '株式会社',
  '社会福祉法人',
  ''
)

_dst = 'data/sample.json'

class Person:
  def __init__(self, no, name, phonetic, company, phone):
    self.no = no
    self.name = name
    self.phonetic = phonetic
    self.company = company
    self.phone = phone
    
  def json_strA(self):
    return '''
    "person{0}" : {{  
      "no": {1},
      "name": "{2}",
      "phonetic": "{3}",
      "company": "{4}"
    }}'''.format(self.no, self.no, self.name, self.phonetic, self.company)

  def json_strB(self):
    return '''
    "person{0}" : {{
      "phone" : "{1}"
    }}'''.format(self.no, self.phone)        

class Org:
  def __init__(self, no, name, phonet, type, phone):
    self.no = no
    self.name = name
    self.type = type
    self.phonetic = phonet
    self.phone = phone
    self.address = '熊本県天草市本渡町本戸馬場1580-6'
    self.pcode = '863-0002'
    
  def json_str(self):
    return '''
    "organization{0}" : {{
      "no": {1},
      "name": "{2}",
      "phonetic": "{3}",
      "phone": "{4}",
      "address": "{5}",
      "pcode": "{6}",
      "type": "{7}"
    }}'''.format(self.no, self.no, self.name, self.phonetic, self.phone, self.address, self.pcode, self.type)

if __name__ == '__main__':  
  persons= []

  s = ''
  
  # 個人の情報

  for i in range(0, 30):
    nc1 = _chars[random.randint(0, len(_chars)-2)] # ンを除く
    nc2 = _chars[random.randint(0, len(_chars)-1)] 
    nc3 = _chars[random.randint(0, len(_chars)-1)]     
    nc4 = _chars[random.randint(0, len(_chars)-1)] 
    nc5 = _chars[random.randint(0, len(_chars)-1)] 
    nc6 = _chars[random.randint(0, len(_chars)-1)] 
    name = f'{nc1}{nc2}{nc3}{nc4}{nc5}{nc6}'
    phonet = name
    phone = '0{0}{1}-{2}{3}{4}{5}-{6}{7}{8}{9}'.format(random.randint(0,9),random.randint(0,9),random.randint(0,9),random.randint(0,9),random.randint(0,9),random.randint(0,9),random.randint(0,9),random.randint(0,9),random.randint(0,9),random.randint(0,9))
    cc1 = _chars[random.randint(0, len(_chars)-2)] # ンを除く
    cc2 = _chars[random.randint(0, len(_chars)-1)]
    cc3 = _chars[random.randint(0, len(_chars)-1)]
    cc4 = _chars[random.randint(0, len(_chars)-1)]
    cc5 = _chars[random.randint(0, len(_chars)-1)]
    cc6 = _chars[random.randint(0, len(_chars)-1)]
    company = f'{cc1}{cc2}{cc3}{cc4}{cc5}{cc6}'
#    print(company)
    persons.append(Person(i+1, name, phonet, company, phone))
    
  # 企業
  orgs = []
  
  for i in range(0, 100):
    c1 = _chars[random.randint(0, len(_chars)-2)] # ンを除く
    c2 = _chars[random.randint(0, len(_chars)-1)] 
    c3 = _chars[random.randint(0, len(_chars)-1)]     
    c4 = _chars[random.randint(0, len(_chars)-1)] 
    c5 = _chars[random.randint(0, len(_chars)-1)] 
    c6 = _chars[random.randint(0, len(_chars)-1)] 
    name = f'{c1}{c2}{c3}{c4}{c5}{c6}'
    phonet = name
    phone = '0{0}{1}-{2}{3}{4}{5}-{6}{7}{8}{9}'.format(random.randint(0,9),random.randint(0,9),random.randint(0,9),random.randint(0,9),random.randint(0,9),random.randint(0,9),random.randint(0,9),random.randint(0,9),random.randint(0,9),random.randint(0,9))
    type = _types[random.randint(0, len(_types)-  1)]
    orgs.append(Org(i + 1, name, phonet, type, phone))
    
  #出力
  s = '''{
  "personinfoA": {'''
  for i in range(len(persons)-1):
    s += persons[i].json_strA()
    if i != len(persons)-2:
      s += ","
  s += '''
  },
  "personinfoB": {'''
  for i in range(len(persons)-1):
    s += persons[i].json_strB()
    if i != len(persons)-2:
      s += ","
  s += '''
  },
  "organizations": {'''           
  for i in range(len(orgs)-1):
    s += orgs[i].json_str()
    if i != len(orgs)-2:
      s += ","
#    else:
#      s += "\n"

  s += '''
  }
}'''
  with open(_dst, 'w', encoding='utf-8', newline='\n') as sock:
    sock.write(s)
