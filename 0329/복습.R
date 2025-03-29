# 산점도 그래프 -> 두 개의 변수 관계 확인
# 예) 키 vs 몸무게, 중간고사 vs 기말고사

# 막대 그래프 -> 그룹별 빈도나 크기 비교할 때
# 예) 판매량 비교, 직업별 소득

# 박스 플롯 -> 데이터의 분포를 표현 
# 예) 각 반 또는 학년 별 성적 분포, 주식 차트

## 오늘 배울 그래프
# 선 그래프
# 지도 시각화

# 산점도 그래프 복습
# 넷플릭스 데이터셋을 사용하여 출시연도 vs 영화 길이 관계 파악

library(ggplot2) # 그래프도구
library(dplyr) # 전처리도구

setwd('D:/R-data')
netflix_data = read.csv('netflix.csv')
#View(netflix_data) -> 데이터확인

# 데이터 전처리
# 영화의 상영시간 알아내야함. -> 문자를 지워주어야함
### 문자열 복습
# gsub : 다른 문자로 '대체'
# strsplit : 특정 문자를 기준으로 '나누다'
# substr : 특정 위치 문자만 '추출(오려내기)'
# as.numeric 문자에서 숫자로 형변환
movie_data = netflix_data %>% filter(type == 'Movie') %>% mutate(gsub_duration = as.numeric(gsub(' min',"",duration)))
# gsub(' min',"",duration) -> duration 컬럼 데이터 ' min' 을 ""으로 대체
#View(movie_data)
# 산점도 그래프 생성 
# 1. data = movie_data : 그래프에 데이터 삽입
# 2. aes(aesthetics) 미학 : x축, y축 설정
# 3. 산점도생성: geom_point()
# geom_smooth() : 회귀선추가 "lm"(linear model)
p = ggplot(data = movie_data, aes(x = release_year, y = gsub_duration)) + geom_point() + 
  geom_smooth(method = 'lm', color = "blue") +  labs(title = "영화 길이 vs 출시연도",x = "출시연도",y = "영화길이(분)") + theme_minimal()

print(p)