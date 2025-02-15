people = data.frame(
  name = c("Alice", "Bob", "Charlie", "Diana"),
  age = c(25, 35, 30, 28),
  gender = c("여", "남", "남", "여")
)

# 데이터의 상위 5개 행 출력하기
print(head(people))

# 데이터의 행과 열의 개수를 출력하기

print(dim(people))

# 전체 컬럼을 출력하기

print(colnames(people))

#3번째 컬럼의 3번째 값은 무엇인가?
print

# 데이터 마지막 3개행을 출력하기
print(tail(people,3))