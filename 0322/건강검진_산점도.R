# 퀴즈: 건강검진 csv 파일을 사용해서 신장과 몸무게 관계를 산점도 그래프로 표현
# x축은 신장, y축은 체중
# 회귀선 추가할 것
library(dplyr)
setwd('d:/R-data')
library(ggplot2)
health_data = read.csv('health.csv', fileEncoding = 'CP949',encoding = "UTF-8",check.names = FALSE)

p = ggplot(health_data, aes(x = `신장(5cm단위)`, y = `체중(5kg단위)`)) + geom_point(size = 2) + geom_smooth(method = "lm", color = 'red') + labs(title = "신장과 체중 관계", x = "신장", y = "몸무게")
print(p)

# 혈색소 vs BMI 관계 파악하고싶다 (명제)
# 혈색소가 높은 사람은 세모표시, 그외는 동그라미 표시 -혈색소가 높으면 심장마비, 뇌졸증 발생할 가능성 높음
# 남자,여자 구분
# BMI를 구해야함. 체중/(신장/100)^2

# 디플리알을 이용해서 전처리 작업을 한다.
# BMI 구합니다.

# mutate로 BMI 구하기
# 혈색소가 높은 사람 세모표시? -> 혈색소가 16이 넘으면 높은 것
health_data2 = health_data %>% mutate(BMI = `체중(5kg단위)` / (`신장(5cm단위)`/100)^2, Grade = ifelse(혈색소 >= 16, "High","Normal"), Gender = ifelse(성별 == 1,"Male","Female"))

# View(health_data2)

# 전처리 끝났으면 그래프로 표현하기
# 17번 세모, 16번 동그라미
p = ggplot(data = health_data2, aes(x = 혈색소, y = BMI)) + geom_point(aes(color = Gender, shape = Grade), size = 1.5) + scale_color_manual(values = c("Male" = "blue", "Female" = "red")) + scale_shape_manual(values = c("High"=17, "Normal" = 16)) +
  geom_smooth(method = "lm", color = "orange") + labs(title = "BMI와 혈색소 관계", x = "혈색소" , y = "BMI", color = "Gender", shape = "Grade")+
  theme_minimal() # 뒤에 회색배경 지우기

pdf.options(family = "Korea1deb")
ggsave("plot.pdf")
#print(p)

# 퀴즈
# 연령코드가 5~8번이고, 지역코드가 41번인 사람의 허리둘레와 식전혈당(공복혈당) 관계를 그래프 표현하기
# 단, 남성은 파랑 여성은 빨강 표기
# 식전혈당(공복혈당) 100 이상은 별 모양(11번) 그 외 동그라미 표기

health_data3 = health_data %>% filter(`연령대코드(5세단위)` >= 5 & `연령대코드(5세단위)` <= 8 & 시도코드 == 41) %>% mutate(Gender=ifelse(성별==1,"Male","Female"),Grade = ifelse(`식전혈당(공복혈당)` >= 100, "High","Normal")
) %>% select(허리둘레, `식전혈당(공복혈당)`,Gender,Grade)

p = ggplot(data = health_data3, aes(x = `식전혈당(공복혈당)`,  y = 허리둘레)) + geom_point(aes(color = Gender, shape = Grade ), size = 1.5) + 
  scale_color_manual(values = c("Male" = "blue", "Female" = "red")) + scale_shape_manual(values = c("High" = 11, "Normal" = 16)) + geom_smooth(method = "lm", color = "orange") +
  labs(title = "허리둘레와 식전혈당(공복혈당) 관계" , x = "식전혈당(공복혈당)", y = "허리둘레",color = "Gender", shape = "Grade")+ theme_minimal()

print(p)

