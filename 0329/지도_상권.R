library(ggplot2) # 그래프도구
library(dplyr) # 전처리도구
library(sf) # 지도시각화
library(ggiraph) # 지도 시각화 이벤트

korea_map = st_read('sig.shp')

# 서울만 가져오기
seoul_map = korea_map %>% filter(substr(SIG_CD, 1 ,2)=="11")

# 상권분석 csv 파일 불러오기
seoul_comm_data = read.csv('seoul_commercial_analysis.csv', fileEncoding = 'CP949', encoding = 'UTF-8', check.names = FALSE)

# seoul_commercial_analysis.csv 확인 후 새로운 컬럼 `자치구_코드` 생성 후 기존`자치구_코드`를 문자로 형변환해서 대입하기.
#as.character = 문자로 형변환

# 1. 데이터프레임의 구조를 확인!
#print(str(seoul_comm_data))

# 형변환
seoul_comm_data = seoul_comm_data %>% mutate(자치구_코드 = as.character(자치구_코드))
# 자치구 코드를 문자로 바꾼 이유 -> 지도 파일에 자치구 코드가 문자형이어서-> 형변환해서 병합(join) 하기 위해서

# 지도데이터(shp)와 상권데이터(csv) 병합하기
# seoul_map에 있는 SIG_CD와 seoul_comm_data에 있는 자치구_코드를 `기준`으로 두 파일 병합하기
merged_data = inner_join(seoul_map, seoul_comm_data, by = c("SIG_CD" = "자치구_코드"))

#View(merged_data)

# SIG_CD, 자치구_코드_명, geometry(위,경도)를 그룹핑해서 전체  `폐업영업 개월 평균`의 평균 구하기
# 폐업영업평균이 60이하면 high, 아니면 Normal을 나타내는 위험도 컬럼 추가할 것

merged_data = merged_data %>% group_by(SIG_CD,자치구_코드_명,geometry) %>% summarise(영업평균 = mean(폐업_영업_개월_평균)) %>%
  mutate(위험도 = ifelse(영업평균 <= 60 , "High","Normal"))

#View(result)
quantiles = quantile(merged_data$영업평균)
merged_data = merged_data %>% filter(영업평균 >= quantiles["75%"])
# 사분위수를 이용해서 특정 구간 알고 싶을 때
# quantile : 사분위수(데이터를 4등분하는 기준 값)
# 25% 50% 75% 

# 지도 시각화
p = ggplot(data = merged_data) + scale_fill_gradient(low = "#ececec", high = "blue", name = "영업평균") + geom_sf_interactive(aes(fill = 영업평균, tooltip = 자치구_코드_명, data_id = SIG_CD))+theme_minimal()+ labs(title = "서울시 폐업 평균 개월 ",x = "경도",y = "위도")
girafe_plot = girafe(ggobj = p) #인터랙티브 지도 생성
print(girafe_plot)