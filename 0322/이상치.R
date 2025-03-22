## 이상치(outlier)
# 이상치는 데이터 분석에서 가장 중요한 개념
# 데이터 분포에서 극단적으로 벗어난 값을 의미
# 이를 탐지하고 제거해야 올바른 예측 가능하다.

# 이상치 제거하는 알고리즘은 다양
# 'Z-Score'
# Z 스코어 공식
## Z = (원본 데이터 값 - 평균) / 표준편차
# Z 스코어가 0이면 데이터 값이 평균과 동일함을 의미
# 결과가 양수면 평균에서 멀리 떨어져 있음을 의미

# 데이터프레임 생성
students = data.frame(Student = c("Alice","Bob","Charlie","David","Jose"),
                    Score = c(50,60,70,80,150))

mean_score = mean(students$Score) # 스코어 평균 구하기
print("평균 : ")
print(mean_score)

# 이상치를 이용해서 튄 데이터 제거
## Z = (원본 데이터 값 - 평균) / 표준편차

students$z_score = (students$Score - mean(students$Score)) / sd(students$Score)
#View(students)
# 조제 z-score : 1.7
# abs = 절댓값
students$z_score = abs(students$z_score)
#View(students)

# 1.5 : 임계값, 상황에 따라 조절이 가능함.
# 일반적으로 2~3인 값을 이상치라고 간주한다.
students$is_outlier = students$z_score >= 1.5
#View(students)
# z 스코어는 정규분포에서 각 값이 평균으로 얼마나 떨어져 있는 지 알려줌

# emp.csv를 이용해서 사원 급여를 Z-스코어를 사용해서 이상치 탐지
# 임계값은 2로 설정
library(dplyr)
emp = read.csv('emp.csv')

#emp$z_score = (emp$SAL - mean(emp$SAL)) / sd(emp$SAL)
#emp$z_score = abs(emp$z_score)
#emp$is_outlier = emp$z_score >= 2
#result = emp %>% filter(emp$is_outlier)
#View(result)
#View(emp)

result = emp %>% mutate(z_score = abs((SAL - mean(SAL)) / sd(SAL)),is_outlier = ifelse(z_score >=2, TRUE, FALSE))
result = result %>% filter(is_outlier) # is_outlier == TRUE 라는 의미와 같음.

