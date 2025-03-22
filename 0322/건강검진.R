library(dplyr)
setwd('d:/R-data')

# 컬럼이 한글일 때 fileEncoding = 'CP949' 
health_data = read.csv('health.csv', fileEncoding = 'CP949',encoding = "UTF-8",check.names = FALSE)
#View(health_data)
# 컬럼에 괄호가 있으면 `` 으로 묶어준다. (탭키 위)
#health_data = health_data %>% select(`연령대코드(5세단위)`, `시력(좌)`)
#View(health_data)

##문제##
# 시력(좌)와 시력(우) 평균이 0.9 이하면 vision 이라는 컬럼에 Check 아니면 No Check를 생성하시오.
# 컬럼생성-mutate  /  평균-mean
# ~~라면(가정) -> ifelse

result = health_data %>% mutate(vision = ifelse((`시력(좌)` + `시력(우)`)/2 <= 0.9,'Check','No Check'))
#View(result)

# vision별 Check수와 No Check수 조회
# 그룹핑 결과 count -> summarise(count = n()) , 여기서 count는 변수이름
check_no = result %>% group_by(vision) %>% summarise(count = n())
# View(check_no)

# 이완기 혈압이 평균보다 낮은 사람 행의 수
# nrow() 사용!!!
# filter에 mean, max, min, sd 다 사용 가능 ... 기초통계 사용 가능
mean_low = health_data %>% filter(이완기혈압 <= mean(이완기혈압)) %>% nrow()

#View(mean_low)

# min-max 스케일링
# '남성'의 혈청지오티(간기능 검사)를 최소-최대 적도(=min-max)로 변환 후 변환된 값이 0.8보다 큰 남성의 연령대코드,신장,체중,혈정지오티 추출
# 단, 혈청지오티 기준으로 내림차순
# 혈청지오티 40 U/L 이하는 정상
# 남성 = 1 /// 여성 = 2
scaled_health = result %>% filter(성별 == 1) %>% mutate(AST_Scaled = (`혈청지오티(AST)`-min(`혈청지오티(AST)`)) 
                                                      / (max(`혈청지오티(AST)`-min(`혈청지오티(AST)`))))  %>% filter(AST_Scaled > 0.8) %>% select(`연령대코드(5세단위)`,`신장(5cm단위)`,`체중(5kg단위)`,`혈청지오티(AST)` ) %>% arrange(desc(`혈청지오티(AST)`))

#View(scaled_health)

# 연령대코드 5에서 15사이 중 연령대코드 별 시력(좌), 시력(우) 평균값 조회
# 단, 시력(좌), 시력(우) 각각 내림차순

result = health_data %>% filter(`연령대코드(5세단위)`>= 5 & `연령대코드(5세단위)` <= 15) %>% group_by(`연령대코드(5세단위)`) %>%
  summarise(시력좌평균 = mean(`시력(좌)`,na.rm = TRUE), 시력우평균 = mean(`시력(우)`, na.rm = TRUE)) %>% arrange(desc(시력좌평균), desc(시력우평균))
#View(result)

