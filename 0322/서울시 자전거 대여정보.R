library(ggplot2)
library(dplyr)
setwd('D:/R-data')
bicycle_data = read.csv('seoul_public_bicycle_data.csv', fileEncoding = 'CP949',encoding = "UTF-8",check.names = FALSE)
#View(bicycle_data)

# 1. 대여소번호별 이용건 수 막대그래프 표현(x축: 대여소번호, y축: 이용건 수)

p = ggplot(data = bicycle_data , aes(x = 대여소번호, y = 이용건수)) + geom_col(fill = "steelblue") + labs(title = "대여소번호별 이용건수", x = "대여소번호", y = "이용건수")
#print(p)

#pdf.options(family = "Korea1deb")
#ggsave("bicycle_data.pdf")

# 2. 정기권을 구매한 이용자 중 연령대 별 평균 운동량 막대그래프로 표현. 단, 이용시간(분) 5분 이하는 평균에서 제외 (x축 : 연령대 , y축: 평균 운동량)

#View(bicycle_data)
result = bicycle_data %>% filter(대여구분코드 == "정기권" & `이용시간(분)` > 5) %>% group_by(연령대코드) %>% summarise(평균운동량 = mean(운동량)) %>% mutate(평균운동량)

p = ggplot(data = result, aes(x = 연령대코드, y = 평균운동량 )) + geom_col(fill = "steelblue") + labs(title = "연령대 별 평균 운동량" , x = "연령대" , y = "평균 운동량")
print(p)

#pdf.options(family = "Korea1deb")
#ggsave("bicycle_mean.pdf")


# 3. 연령대코드 별 이용시간과 운동량을 비교하는 산점도 그래프 표현.
#(x축 : 이용시간, y축: 운동량 )
#조건 1. 연령대 별 색깔 (10대 : 노랑(yellow), 20대 : 블루(blue), 30대 : 퍼플(purple), 40대: 초록(green), 50대 : 블랙(black))

result = bicycle_data %>% group_by(연령대코드) %>% mutate()
