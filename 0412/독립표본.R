# 독립표본(서로 다른 두 집단 비교)
library(dplyr)
library(ggplot2)

# 남 vs 녀 국어점수 비교
score_data = read.csv('korean_scores.csv')
#View(score_data)

# 성별에 따른 국어점수 비교
# ~ : 왼쪽 변수를 오른쪽 변수 기준으로 분석
# korea_score ~ gender: 국어점수를 성별 기준으로 T검정 수행
t_test_result = t.test(korean_score ~ gender, data = score_data)
if(t_test_result$p.value < 0.05){
  print('성별에 따른 국어점수 차이가 있을 가능성이 있다.')
}else{
  print('성별에 따른 국어점수 차이는 없다.')
}

# 박스플롯
p = ggplot(score_data, aes(x = gender, y = korean_score, fill = gender)) + geom_boxplot() + scale_fill_manual(values = c('Male' = 'lightblue', 'Female' = 'pink')) +
  labs(title = '성별에 따른 국어점수', x = '성별', y = '국어점수') + theme_minimal()

print(p)