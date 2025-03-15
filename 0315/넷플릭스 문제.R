library(dplyr)

# 문제 3: 데이터셋에서 title, type, release_year 열만 선택하세요.
netflix = read.csv('netflix.csv') # 데이터셋 읽기

result = netflix %>% select('title' , 'type' ,'release_year')
print(result)

#문제 6: TV-MA 등급의 TV 프로그램만 필터링하세요.

result = netflix %>% filter(type == 'TV Show' & rating == 'TV-MA')
#View(result)

#문제 7: director가 "Mike Flanagan"인 영화의 title, director, country 열을 선택하세요.

result = netflix %>% filter(type == 'Movie' & director == "Mike Flanagan") %>% select('title','director','country') 
# type 있는 지 없는 지 중요!! 확인 잘 하기 
#View(result)

#문제 10: TV 프로그램(type == "TV Show") 중 시즌 수(duration)를 기준으로 오름차순으로 정렬하세요.
#문제발생! -> 'duration' 컬럼에 숫자와 문자가 존재함
#문제해결 -> 문자열을 제거(특정 문자로 대체) -> gsub
#텍스트 데이터에서 숫자만 추출 뒤 정렬하는게 포인트!
result = netflix %>% filter(type == 'TV Show') %>% mutate(seasons = as.numeric(gsub(' Season[s]?',"",duration))) %>% arrange(seasons)

