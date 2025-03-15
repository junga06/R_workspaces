# 2021년에 제작된 영화의 평균 길이를 구하세요.
# filter, mean, summarise, gsub(문자제거)-as.numeric(형변환)

result = netflix %>% filter(type == 'Movie' & release_year == 2021) %>% summarise(AVG_duration = mean(as.numeric(gsub(' min',"",duration))))
#View(result) 

# 년도별 제작된 영화의 평균 길이를 구하세요.
# group_by + summarise
# filter
# mean
# gsub
result = netflix %>% 
  filter(type == 'Movie') %>% 
  group_by(release_year) %>% 
  summarise(avg_duraion = mean(as.numeric(gsub(" min","",duration
  )),na.rm = TRUE)) 
#View(result)
### 오류 발생??
### result = netflix %>% filter(type == "Movie") %>% group_by(release_year) %>% summarise(avg_duration = mean(as.numeric(gsub(" min","",duration)), na.rm = TRUE))
#View(result)

# 장르가 Comedies인 영화의 제목
# listed_in %in% c('Comedies') : listed_in에 Comedies가 포함되어있는 지 체크
result = netflix %>% filter(type == 'Movie' & listed_in %in% c('Comedies')) %>% select(title)
#View(result)

# 'International TV Shows' 장르에 속하고 TV-MA 등급인 TV Show의 title과 제작국가 추출

result = netflix %>% filter(type == 'TV Show' & rating == 'TV-MA' & listed_in %in% c('International TV Shows')) %>% nrow()#select(title,country)
# nrow() : 행 개수, number of rows
# View(result)

# United States에서 제작된 '영화' 의 개수 추출
result = netflix %>% filter(type == 'Movie' & country == 'United States') %>% nrow()
print(result)

# 국가별 영화 수
# country != '' -> 빈값체크하는 방법

result = netflix %>% filter(type == 'Movie' & country != '') %>% group_by(country) %>% summarise(count = n())
#View(result)

# 국가별 영화 수 -> 가장 영화가 많은 국가 (상위 5개국가만 추출)
# 등수 구하는 분석할 때 "정렬" 중요
result = netflix %>% filter(type == 'Movie' & country != '') %>% group_by(country) %>% summarise(count = n()) %>% arrange(desc(count)) %>% slice_head(n = 5)
#View(result)

# 감독별 가장 많이 넷플릭스에 등록한 감독 상위 1명 조회
top_director = netflix %>% filter(director != '') %>% group_by(director) %>% summarise(count = n()) %>% arrange(desc(count)) %>% slice_head(n = 1)
#View(top_director)

# 넷플릭스 가장 많이 등장하는 장르 상위 5개
#install.packages("tidyr")
library(tidyr)
top_genre = netflix %>% separate_rows(listed_in, sep = ",") %>% group_by(listed_in) %>% summarise(count = n()) %>% arrange(desc(count)) %>% slice_head(n=5)
#View(top_genre)

result = netflix %>% select(date_added) %>% slice_head(n=5)
#View(result)

# 퀴즈) 2021년에 추가된 영화의 타이틀 추출
# 1. formatted_add_date 컬럼 추가
# 2. %B %d %Y 형태로 포맷한 날짜 형변환
netflix = netflix %>% mutate(formatted_add_date = as.Date(date_added, format = '%B %d, %Y'))
#View(netflix)
result = netflix %>% filter(type == 'Movie' & format(formatted_add_date, '%Y')==2021) %>% select(title)
View(result)