import sys
import datetime

days_in_year = 365

def get_age(birthdate):
    bd = datetime.date(int(birthdate[0:4]), int(birthdate[5:7]), int(birthdate[8:11]))
    return int((datetime.date.today() - bd).days / days_in_year)

if __name__ == '__main__':
    print(get_age(sys.argv[1]))
