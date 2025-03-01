# R디렉토리 변경
setwd('D:/R-data')
print(list.files()) #해당 경로 파일 확인

#CSV(엑셀) 불러오기
data = read.csv('student_data.csv')
#View(data)

# 각 과목의 평균 점수 계산
# ***mean
math = mean(data$Math)
cat("수학 평균 점수 : ",math,'\n')
science = mean(data$Science)
cat("과학 평균 점수 : ",science,'\n')
english = mean(data$English)
cat("영어 평균 점수 : ",english,'\n')

#컴퓨터 총합 구하시오. na.rm = TRUE 이용
# rm = remove 삭제
computer = sum(data$Computer, na.rm=TRUE)
cat("컴퓨터 총합 : ",computer,'\n')

# 영어과목 표준편차
english_sd = sd(data$English)
cat("영어 과목 표준편차 : ",english_sd,'\n') #영어 값들이 평균으로 부터 +=4.9만큼 퍼져있다는 것을 의미.
# 과학 중앙값
science_median = median(data$Science)
cat("과학 과목 중앙값 : ",science_median,'\n')
# 수학 사분위수
math_quantile = quantile(data$Math)
print(math_quantile)

# 최댓값, 최솟값
# 수학 과목의 최댓값과 최솟값 
math_max = max(data$Math)
math_min = min(data$Math)
cat("최댓값 : ",math_max,'\n')
cat("최솟값 : ",math_min,'\n')

#table
print(table(data$English)) #점수별 인원 통계

#데이터프레임 기초 통계량 전체 확인
# summary 사용하면 각 껍질(열)별 기본 통계 확인
print(summary(data))

#install.packages("ggplot2")
library(ggplot2)
graph_data = data.frame(
  x = c('수학평균','영어평균','과학평균'),
  y = c(math,english,science)#각과목 평균값
  
)

#그래프 생성
result = ggplot(data = graph_data, 
                aes(x =x , y=y))+
  geom_col(fill = 'steelblue')+
  labs(
    title = "과목평균",
    x = "과목",
    y = "평균점수"
  )+
  theme_minimal()
print(result)
