# 종로구하고 중구, 용산구가 현재 가장 폐업율이 높다.
# 왜?
# 1. 물가상승 2. 노인 수 급증

# 노인 수가 많을 것 이다.(추측)
# 종로구 노인 인구 비율을 조회!

library(ggplot2) # 그래프도구
library(dplyr) # 전처리도구

elder = read.csv('고령인구현황.csv', fileEncoding = 'CP949', encoding = 'UTF-8', check.names = FALSE)

# 전처리- 종로구의 23년, 24년, 25년 65세이상 전체 컬럼 조회
elder_group = elder %>% filter(행정구역 == '서울특별시 종로구 (1111000000)') %>% select(`2022년_65세이상전체`,
                                                                           `2023년_65세이상전체`,
                                                                           `2024년_65세이상전체`)
#View(elder_group)

df = data.frame(time = c('2022-01-01','2023-01-01','2024-01-01'),
                elder_count = c(elder_group$`2022년_65세이상전체`,elder_group$`2023년_65세이상전체`,elder_group$`2024년_65세이상전체`))

# 형변환
df$time = as.Date(df$time) # 문자 -> 날짜
df$elder_count = as.numeric(gsub(",","",df$elder_count))

print(df)

p = ggplot(data = df, aes(x = time, y = elder_count)) + geom_line() + labs(title = "종로구 인구수 변화", x = "연도", y = "노인(65세)")
print(p)

# 상승률 계산
# 상승률 : 최종값 - 초기값 / 초기값*100
# 올해-작년 / 작년*100
# increase_rate 컬럼생성

df$increase_rate = c(0, diff(df$elder_count)/df$elder_count[-length(df$elder_count)]*100)
#print(df) # 상승률 확인
# diff : 연속된 값들 사이의 차이를 계산
x = c(10,20,30,40)
print(diff(x)) # 20-10/30-20/40-30

# length : 길이
print(length(df$elder_count)) # 데이터 수(길이) == count
print(df$elder_count[-3]) # 3번째 데이터 빼고 출력
 
# 폐업 확률 구해보자
# 폐점 확률(가중평균!)
# 노인율 = 초기노인율 + 노인증가율
# 폐업율 = 초기폐점율 + 폐업증가율

# 가중치는 우리가 정하는 것
# 전체 가중치 합 = 1
# 노인가중치=0.6(유동인구 증가, 노인소비패턴..) 폐업가중치=0.4(임대료상승, 경기침체..)
# 폐점 확률 = (노인율*노인가중치) + (폐점율*폐점가중치)

# 노인율 
elder2 = read.csv('2022_2024_주민등록인구기타현황(고령 인구현황)_연간 (1).csv',fileEncoding = 'CP949', encoding = 'UTF-8', check.names = FALSE)

# 콤마 제거하기
# 2024년_전체, 2024년_65세이상전체 컬럼들 콤마 제거하기(디플리알 이용)
elder2 = elder2 %>% mutate(인구수_2024 = as.numeric(gsub(",","",`2024년_전체`)),
                           노인수_2024 = as.numeric(gsub(",","",`2024년_65세이상전체`)),
                           인구수대비노인율 = (노인수_2024/인구수_2024)*100)
#View(elder2)

# 초기노인율(2024 가정)
jongno_init_elder_rate = elder2 %>% filter(행정구역 == '서울특별시 종로구 (1111000000)') %>%
  select(인구수대비노인율)

print(jongno_init_elder_rate)

# 노인율 = 초기노인율 + 노인증가율
jongno = jongno_init_elder_rate + 3.7

# 폐업율 = 초기폐점율 + 폐업증가율
close = 13 # 가정

# 가중치 설정
# 가중치 0.6과 0.4 설정 이유
# 두 요인의 상대적 기여도 비율 6 : 4 라고 가정
elder_w = 0.6 # 노인가중치
close_w = 0.4 # 폐점가중치

# 최종 폐점 확률(종로구) # 폐점 확률 = (노인율*노인가중치) + (폐점율*폐점가중치)
close_rate = (jongno * elder_w) + (close * close_w)
print('종로구에 신규오픈 시 예상 폐점 확률 : ')
print(close_rate$인구수대비노인율) # 폐점확률 20%







