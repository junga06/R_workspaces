# 데이터프레임

# 첫번째-경로확인
print(list.files()) # 해당 경로에 있는 파일 목록
print(getwd()) # 해당 경로 조회

# getwd : Get Working Directory
# 프로그래밍에서 get이라는 용어 -> '불러온다'
# setwd : Setting Working Directory


# 두번째-경로 수정
setwd('D:/R-data')

# 세번째-파일 불러오기
emp = read.csv('emp.csv') # 파일 불러오기
#View(emp) 

### 암기(시험 단골)
print(dim(emp)) # 행/열의 수 확인
print(head(emp,4)) # 데이터 상위 1~4행
print(tail(emp,4)) # 데이터 하위 1~4행

print(str(emp)) # 데이터 프레임 '데이터 타입 확인'

### 특정 열 출력
print(emp$ENAME) 

### dplyr(data frame plier) # 데이터 프레임을 다루는 '공구'
#install.packages("dplyr") #처음에만 설치 필요함(설치한 후 사용 가능)
library(dplyr)

emp_ename = emp %>% select(ENAME) # ENAME만 선택
print(emp_ename)

# 필터링 후 select
# & -> 두 조건이 모두 만족해야 함
emp_data = emp %>% filter(SAL >= 2000 & DEPTNO == 20) %>% select(ENAME,JOB,DEPTNO)
print(emp_data)
# filter : 행 필터링
# select : 특정 벡터(열) 선택
# mutate : 새로운 벡터(열) 추가
# arrange : 정렬(오름/내림차순)
# summarize + group_by : 데이터그룹 + 데이터요약
# R에서 group_by 단독 사용 불가능
# join : 여러 데이터프레임 '병합'

# + slice : 지정된 행 번호에 해당하는 행 선택(head, tail)

