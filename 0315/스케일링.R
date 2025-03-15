#***** 데이터스케일링
# `데이터 분석` 및 `머신러닝`에서 중요한 전처리 과정
# 변수의 크기를 조정하여 성능을 향상시키거나 결과를 해석하기 쉽게 만든다.

# Min-Max 정규화
# 데이터 스케일링 방법 중 하나 (대표적)
# Min-Max는 데이터를 0에서 1사이로 변환하는 데이터 전처리 기법

# 예제 데이터 프레임
data = data.frame(height = c(150,160,170,180,190), weight = c(50,60,70,80,90))

#View(data)

# 키와 몸무게는 단위와 범위가 다르기 때문에 두 데이터를 그대로 비교하거나 분석하기 어려움
# 이를 해결하기 위해 키와 몸무게를 0~1 사이로 스케일링하면 두 변수는 동일한 기준에서 비교할 수 있다.

# 스케일링값 = (원래 값 - 최솟값) / (최댓값 - 최솟값)
heigh_min = min(data$height) # 키 최솟값
heigh_max = max(data$height) # 키 최댓값

data$scaled_height = (data$height - heigh_min) / (heigh_max - heigh_min)

weigh_min = min(data$weight) # 몸무게 최솟값
weigh_max = max(data$weight) # 몸무게 최댓값

data$scaled_weight = (data$weight - weigh_min) / (weigh_max - weigh_min)

#View(data)

# emp 데이터에서 급여(SAL) 열에 대해 Min-Max 정규화를 수행하기(SAL_MinMax컬럼 추가)
# 디플리알로 0.5보다 큰 값을 가지는 데이터 추출
library(dplyr)
emp = read.csv('emp.csv')

sal_min = min(emp$SAL)
sal_max = max(emp$SAL)

emp$SAL_MinMax = (emp$SAL - sal_min) / (sal_max - sal_min)
#View(emp)
result = emp %>% filter(SAL_MinMax > 0.5) %>% select(ENAME, SAL, SAL_MinMax) %>% arrange(desc(SAL_MinMax))
#View(result)
