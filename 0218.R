people = data.frame(
  name = c("Alice", "Bob", "Charlie", "Diana"),
  age = c(25, 35, 30, 28),
  gender = c("여", "남", "남", "여")
)


#3번째 컬럼의 3번째 값은 무엇인가?
people[3,3]

# 새로운 컬럼 'weight' 추가, 데이터는 52,77,81,46 차례로 넣어주세요.
people$weight = c(52,77,81,46)
# View(people)

# 나이가 30 이상인 사람들만 출력하는 코드를 작성하세요.
 
result = people[people$age >= 30,]
print(result)

# name , age 두개의 컬럼으로 구성된 새로운 데이터 프레임을 정의하기.

new_people = people[,c(name, age)]