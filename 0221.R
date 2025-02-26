emp = data.frame(
  EMPNO = c(7369, 7499, 7521, 7566, 7698, 7782, 7788, 7839, 7844, 7900),
  ENAME = c("SMITH", "ALLEN", "WARD", "JONES", "BLAKE", "CLARK", "SCOTT", "KING", "TURNER", "ADAMS"),
  JOB = c("CLERK", "SALESMAN", "SALESMAN", "MANAGER", "MANAGER", "MANAGER", "ANALYST", "PRESIDENT", "SALESMAN", "CLERK"),
  MGR = c(7902, 7698, 7698, 7839, 7839, 7839, 7566, NA, 7698, 7788),
  HIREDATE = as.Date(c("1980-12-17", "1981-02-20", "1981-02-22", 
                       "1981-04-02", "1981-05-01", "1981-06-09",
                       "1982-12-09", "1981-11-17", "1981-09-08",
                       "1983-01-12")),
  SAL = c(800, 1600, 1250, 2975, 2850, 2450, 3000, 5000, 1500, 1100),
  COMM = c(NA, 300, 500, NA, NA, NA, NA, NA, NA, NA),
  DEPTNO = c(20, 30, 30, 20, 30, 10, 20, 10, 30, 20)
)

#특정 열 추가 후 데이터 넣기
## emp에 징계여부(DISCIPLINARY)라는 컬럼을 추가해주시고 boolean형으로 데이터를 넣어주세요.
emp$DISCIPLINARY = c(TRUE,FALSE,FALSE,TRUE,FALSE,TRUE,TRUE,TRUE,FALSE,FALSE)

#View(emp)  
# emp 데이터 프레임에서 JOB이 "MANAGER"인 직원들의 이름(ENAME)과 급여(SAL)를 출력하세요.
print(emp[emp$JOB=="MANAGER",c("ENAME","SAL")])
          
# COMM 열에 NA가 아닌 값을 가진 직원들의 사번(EMPNO)과 부서번호(DEPTNO)를 출력하세요.
emp$COMM[is.na(emp$COMM)]=0
print(emp[,c("EMPNO","DEPTNO")])

# 급여(SAL)가 2000 이상이고, 부서번호(DEPTNO)가 20인 직원들의 이름(ENAME)과 직업(JOB)을 출력하세요.
result = emp[emp$SAL >= 2000 & emp$DEPTNO ==20,c("ENAME", "JOB")]
print(result)
  
  
# emp 데이터 프레임에서 각 부서번호(DEPTNO)별 평균 급여(SAL)를 계산하고 출력하세요.
a = emp[emp$DEPTNO==10,c("SAL")]
b = emp[emp$DEPTNO==20,c("SAL")]
c = emp[emp$DEPTNO==30,c("SAL")]


average1 = mean(a)
print(paste("평균:", average1))

average2 = mean(b)
print(paste("평균:", average2))

average3 = mean(c)
print(paste("평균 :",average3))

