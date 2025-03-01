#대문자와 소문자를 구별한다.
#사람끼리 정보를 주고받을 떄는 1(숫자)와 2(문자)로 충분
#컴퓨터는 논리형(bool)이 필요함.
#3(논리형) => true, false
#4(범주형) => (ex. 혈액형, 성별, 고객만족도)
#범주형 특징 => '그룹핑', '계산적 의미' 는 없다.
#5(결측값*****) => 관측/측정에 실패한 값

###*****데이터 프레임 : 행과 열로 구성된 2차원 구조
#데이터 프레임 생성
df = data.frame(
  ID = c(1,2,3),
  NAME = c('김길동','박길동','홍길동')
)

#View(df)

#***데이터 프레임 조회
print(head(df,2)) # 1행과, 2행 출력
print(dim(df)) # 행과 열의 개수
print(tail(df,2)) # 맨 마지막 행부터(아래에서부터)=마지막 2행 출력
print(str(df)) #각 열의 데이터타입을 확인할 수 있음-num은 숫자, chr은 문자

#특정 열 선택
name = df$NAME
print(name)

# 다중 열 선택
emp = df[,c('ID','NAME')] #id, name 컬럼(열)만 조회
print(emp)

#새로운 열 추가
df$JOB = c('MANAGER','MANAGER','SALES')
#View(df)

df$SAL = c(100,200,500)
#View(df)

#특정 열 값 수정
df$SAL = df$SAL * 2 #기존급여에 2배
print(df)

#데이터프레임 -> CSV(엑셀) 파일로 저장
write.csv(df,file = 'sample_dataframe.csv')
#기본 경로는 '문서'에 저장됩니다. 

