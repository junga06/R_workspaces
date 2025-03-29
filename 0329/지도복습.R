library(ggplot2) # 그래프도구
library(dplyr) # 전처리도구
library(sf) # 지도시각화
library(ggiraph) # 지도 시각화 이벤트

korea_map = st_read('sig.shp')
# 서울만 가져오기
seoul_map = korea_map %>% filter(substr(SIG_CD, 1 ,2)=="11")

# 미세먼지 데이터 불러오기
dust_data = read.csv('data.csv', fileEncoding = 'CP949', encoding = 'UTF-8', check.names = FALSE)
#View(dust_data)
# 미세먼저 station_code(지역코드)
# 퀴즈 join을 이용해서 shp파일과 data.csv 병합하기

#print(str(dust_data))
# 데이터 타입 같도록!
dust_data = dust_data %>% mutate(station_code = as.character(station_code))
# 교집합 컬럼 데이터 타입이 동일해야 병합이 가능하다!!!
merged_data = inner_join(seoul_map, dust_data, by = c("SIG_CD" = "station_code"))
#View(merged_data)

# 심플 지도
# 지도는 x축경도, y축 위도로 정해져있음.
# 어떤 데이터 채울 것인가, 경계선 색 -> scale_fill_gradient 알아서 크기에 맞게 색 
p = ggplot(data = merged_data) + geom_sf(aes(fill = pm10_concentration_ug_m3), color = "black") +
  scale_fill_gradient(low = "blue", high = "red", name = "미세먼지농도") + theme_minimal() + labs(title = "서울시 미세먼지 농도", x = "경도", y = "위도")
print(p)