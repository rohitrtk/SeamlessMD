import sys
import datetime

days_in_year = 365

def get_age(birthdate):
    '''
    Returns an age relative to today given a birthdate. Birthdate
    is given as a string and in the following format: YYYY-MM-DD.

    #Assume today is 2021-06-23
    >>> get_age('1999-06-08')
    22
    >>> get_age('2010-07-15')
    10
    '''
    
    # Create a date object from the string that's been passed in
    bd = datetime.date(int(birthdate[0:4]), int(birthdate[5:7]), int(birthdate[8:11]))
    
    # Return the age based on the date
    return int((datetime.date.today() - bd).days / days_in_year)

if __name__ == '__main__':
    print(get_age(sys.argv[1]))
