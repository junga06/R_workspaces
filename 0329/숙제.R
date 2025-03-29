# 1. 24년도 총 직장 인구수가 가장많은 자치구 5개만 지도로 표현

library(ggplot2) # 그래프도구
library(dplyr) # 전처리도구
library(sf) # 지도시각화
library(ggiraph) # 지도 시각화 이벤트

work_data = read.csv('서울시 상권분석서비스(직장인구-자치구).csv', fileEncoding = 'CP949', encoding = 'UTF-8', check.names = FALSE)
#print(str(work_data))

work_data_y = work_data %>% mutate(year = substr(기준_년분기_코드,1,4))
#View(work_data_y)

work_data_top_5 = work_data_y %>% filter(year == 2024) %>% group_by(자치구_코드_명) %>% summarise(sum(총_직장_인구_수)) 
#View(work_data_top_5)
top_5 = head(work_data_top_5,5)
#View(top_5)

p = ggplot(data = work_data_y) + geom_sf(aes(fill=top_5), color = "black") + scale_fill_gradient(low = "blue", high = "red", name = "총 직장 인구수") + theme_minimal() + labs(title = "총 직장 인구수가 가장많은 자치구", x = "경도", y = "위도")

print(p)