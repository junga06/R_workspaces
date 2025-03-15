date_str = 'September 24, 2021'
# R은 해당문자를 바로 날짜형으로 변환할 수 없다.

Sys.setlocale("LC_TIME","C") #임시로 장소 변경
date_str = as.Date(date_str, format = '%B %d, %Y') #형식맞추기
formatted_date = as.Date(date_str, '%Y')#년도만 나오게
print(date_str)
print(formatted_date)

date_str_1 = '2025-03-15'
date = as.Date(date_str_1)
formatted_date = format(date, '%Y')
print(formatted_date)

