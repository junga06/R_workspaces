### 데이터프레임 *****
# R 기초단계에서 가장 중요한 것
# 데이터프레임, 벡터

# R프로그래밍에서 데이터프레임은 데이터를 '행'과 '열'로 구성한 2차원 구조
# 다양한 데이터 유형을 한 테이블에 저장할 수 있는 자료구조
# 데이터프레임으로 통계분석, 데이터처리, 그래프시각화

# 데이터 프레임 구조
#구조 : 행과 열
# 행 : 관측치
# 열 : 속성

ID = c(1,2,3)
Name = c('Alice', 'Bob', 'Charlie')
Age = c(25,30,35)
Salary = c(50000,60000,70000)

#데이터프레임 생성
# df = data.frame() 문법 암기하기
df = data.frame(ID, Name, Age, Salary)
print(df) #데이터 출력

## 데이터 프레임 조회하는 다른 방법들 ***
#head : 머리 -> 위에서부터
print(head(df, 1)) #1행만 출력.
print(head(df,2)) #1~2행만 출력.
print(head(df)) #뒤에 숫자가 없으면, 1~6행까지 출력

# 행과 열의 개수를 알고싶다
print(dim(df)) #출력-> 3행 4열

#전체 컬러조회
#colnames
print(colnames(df)) 
#마지막 1행 출력
#tail : 꼬리->아래에서부터
print(tail(df,1))

#View(df) #다른 화면으로 출력
### 특정 열만 선택하기
# '$'기호를 사용하면 결과는 벡터형태로 반환됨.
names = df$Name #데이터프레임에 Name에 해당하는 열 가져옴
cat('특정 열 추출 : ', names, '\n')

#Age만 출력
Ages = df$Age
cat('특정 열 추출 : ', Ages, '\n')

## 다수 열 선택
# 이름하고 나이만 출력
result = df[,c('Name','Age')]
print(result)

#ID하고 Salary만 출력
result = df[,c('ID','Salary')]
print(result)

# 특정 열값 수정, 추가
df$Salary = df$Salary + 100
print(df)

#Age 열값 수정 -> 1살씩 증가
df$Age = df$Age + 1
print(df)

# 데이터프레임에 새로운 열 추가
df$Penalty = c('예', '아니오', '예')
View(df)

