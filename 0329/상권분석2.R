# 특정 지역의 상권 생존률과 폐업률 알아내기-가중치없이
library(ggplot2) # 그래프도구
library(dplyr) # 전처리도구

# 2024년 통계를 가지고 2025년 생존률, 폐업률 예상하기
# 분기로 되어있음.

# substr 을 이용해서 2024년 1분기 부터 4분기까지
# 운영_영업_개월_평균, 폐업_영업_개월_평균
# 서울_운영_영업_개얼_평균, 서울 폐업 개월 평균
# 총 4개의 컬럼평균 구하기
seoul_comm_data = read.csv('seoul_commercial_analysis.csv', fileEncoding = 'CP949', encoding = 'UTF-8', check.names = FALSE)

# 분기로 되어있는 데이터를 년도로 바꾸자
seoul_commercial_data = seoul_comm_data %>% mutate(year = substr(기준_년분기_코드,1,4))
#View(seoul_commercial_data)
seoul_2024_data = seoul_commercial_data %>% filter(year == 2024) %>% group_by(자치구_코드_명) %>%
  summarise(평균폐업 = mean(폐업_영업_개월_평균),
            평균운영 = mean(운영_영업_개월_평균),
            서울전체평균운영 = mean(서울_운영_영업_개월_평균),
            서울전체평균폐업 = mean(서울_폐업_영업_개월_평균))
#View(seoul_2024_data)
#result = seoul_comm_data %>% group_by(자치구_코드_명) %>% summarise(운영평균 = mean(운영_영업_개월_평균))
#print(result)-> 자치구별 운영평균

# 서초구 생존확률
# 2024년도 데이터가 없어서, 2022년도로 대체
seochogu_live_rate = 33
seochogu_close_rate = 32

# 서초구 평균영업, 평균폐업 조회
seochogu = seoul_2024_data %>% filter(자치구_코드_명 == '서초구') %>% select(평균운영, 평균폐업)
#View(seochogu)

#2025년도 서초구 상권 생존율/폐업률 계산
생존확률_2025 = seochogu_live_rate * (seochogu$평균운영 / (seochogu$평균운영 + seochogu$평균폐업))
폐업확률_2025 = seochogu_close_rate * (seochogu$평균폐업 / (seochogu$평균운영 + seochogu$평균폐업))
# %.2f%%\n -> 소수점 2자리까지만 출력

cat(sprintf('2025년 서초구 상권 생존확률 예상 : %.2f%%\n',생존확률_2025), 
    sprintf('2025년 서초구 상권 폐업확률 예상 : %.2f%%\n',폐업확률_2025)
    )

# 종로구 생존확률, 폐업확률 구해보기
# 24년 종로구 상권 생존율 20%
# 24년 종로구 상권 폐업율 35% 가정.

jongno_live_rate = 20
jongno_close_rate = 35

jongno1 = seoul_2024_data %>% filter(자치구_코드_명 == '종로구') %>% select(평균운영, 평균폐업)

생존확률_종로구 = jongno_live_rate * (jongno1$평균운영/(jongno1$평균운영 + jongno1$평균폐업))
폐업확률_종로구 = jongno_close_rate * (jongno1$평균폐업 /(jongno1$평균운영 + jongno1$평균폐업))

cat(sprintf('2025년 종로구 상권 생존확률 예상 : %.2f%%\n',생존확률_종로구), 
    sprintf('2025년 종로구 상권 폐업확률 예상 : %.2f%%\n',폐업확률_종로구)
)
# 영업/폐업 지속 개월수를 고려한 비율 계산