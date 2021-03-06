# Лабораторна робота No 3. Зчитування даних з WEB.
В цій лабораторній роботі необхідно зчитати WEB сторінку з сайту IMDB.com зі 100 фільмами 2017 року виходу за посиланням «http://www.imdb.com/search/title?count=100&release_date=2017,2017&title_ty pe=feature». Необхідно створити data.frame «movies» з наступними даними: номер фільму (rank_data), назва фільму (title_data), тривалість (runtime_data). Для виконання лабораторної рекомендується використати бібліотеку «rvest». CSS селектори для зчитування необхідних даних: rank_data: «.text-primary», title_data: «.lister-item-header a», runtime_data: «.text-muted .runtime». Для зчитування url використовується функція read_html, для зчитування даних по CSS селектору – html_nodes і для перетворення зчитаних html даних в текст - html_text. Рекомендується перетворити rank_data та runtime_data з тексту в числові значення. При формуванні дата фрейму функцією data.frame рекомендується використати параметр «stringsAsFactors = FALSE».
```r
library(rvest)

htmlPageUrl <- "http://www.imdb.com/search/title?count=100&release_date=2017,2017&title_type=feature"

htmlPage = read_html(htmlPageUrl)

rank_data_selector <- ".text-primary"
title_data_selector <- ".lister-item-header a"
runtime_data_selector <- ".text-muted .runtime"

getDataBySelector <- function(selector) {
  selectedData <- html_text(html_nodes(htmlPage, selector))
  return(selectedData)
}

rank_data <- as.numeric(getDataBySelector(rank_data_selector))
title_data <- getDataBySelector(title_data_selector)
runtime_data <- as.numeric(gsub(" min", "", getDataBySelector(runtime_data_selector)))

movies <- data.frame(rank = rank_data, title = title_data, runtime = runtime_data, stringsAsFactors = FALSE)
movies
```
```
    rank                                    title runtime
1      1             Той, хто біжить по лезу 2049     164
2      2                                Гра Моллі     140
3      3                            Тор: Раґнарок     130
4      4                   Назви мене своїм ім'ям     132
5      5                Вбивство священного оленя     121
6      6                                     Воно     135
7      7                               The Healer     113
8      8               Джуманджі: Поклик джунглів     119
9      9                     Найвеличніший шоумен     105
10    10                      Вартові Галактики 2     136
11    11                                     Коко     105
12    12          Людина-павук: Повернення додому     133
13    13                               Леді Бьорд      94
14    14                           Смерть Сталіна     107
15    15                                На драйві     113
16    16  Зоряні війни: Епізод 8 - Останні Джедаї     152
17    17                     Красуня і Чудовисько     129
18    18             Вбивство у Східному експресі     114
19    19                                  Дюнкерк     106
20    20                      Ліга справедливості     120
21    21                         Проект 'Флорида'     111
22    22 Пірати Карибського моря: Помста Салазара     129
23    23                                   Пастка     104
24    24                                     Диво     113
25    25       Три білборди під Еббінґом, Міссурі     115
26    26                      Рятувальники Малібу     116
27    27                               Форма води     123
28    28                                     Окча     120
29    29                                   Ритуал      94
30    30                          Логан: Росомаха     137
31    31             Трансформери: Останній лицар     154
32    32                                  Я, Тоня     119
33    33                               Гарні часи     102
34    34                             Удача Лоґана     118
35    35           Валеріан і місто тисячі планет     137
36    36                           Чужий: Заповіт     122
37    37                               Диво-жінка     141
38    38                  Kingsman: Золоте кільце     141
39    39                               Джон Вік 2     122
40    40                                    Мати!     121
41    41                               Темні часи     125
42    42                                    Життя     104
43    43                           Секретне досьє     116
44    44                  Розваги дорослих дівчат     101
45    45                             Гра Джералда     103
46    46                           Примарна нитка     130
47    47               Король Артур: Легенда меча     126
48    48                          The Current War     108
49    49                         Атомна Блондинка     115
50    50                               Сім сестер     123
51    51              П'ятдесят відтінків темряви     118
52    52                                The Shack     132
53    53                        1+1: Нова історія     126
54    54                                  Метелик     133
55    55                         Victoria & Abdul     111
56    56                                  Яскраві     117
57    57                     Американський убивця     112
58    58                                 Форсаж 8     136
59    59                                Time Trap      87
60    60                  Тебе ніколи тут не було      89
61    61                                   Вороги     134
62    62                      Конг: Острів черепа     118
63    63                             Вітряна ріка     107
64    64                                Іноземець     113
65    65                               Темна вежа      95
66    66                                     1922     102
67    67                               Обдарована     101
68    68                                   Нянька      85
69    69                             Горе-творець     104
70    70                              The Snowman     119
71    71                                  Джунглі     115
72    72                             Disobedience     114
73    73                     Тілоохоронець кілера     118
74    74                                    Сфера     110
75    75                      Життя і мета собаки     100
76    76                     Воно приходить уночі      91
77    77            Баррі Сіл: Король контрабанди     115
78    78                                    Мумія     110
79    79                    Війна за планету мавп     140
80    80                      Спекотні літні ночі     107
81    81                                  Тачки 3     102
82    82                        Кохання - хвороба     120
83    83                     Безсоромна мандрівка      90
84    84                        Моя кузина Рейчел     106
85    85                Saban's Могутні рейнджери     124
86    86                        Постріл в безодню     121
87    87                                Зменшення     135
88    88                           Ферма Мадбаунд     134
89    89                                     Amar     105
90    90                          Усі гроші світу     132
91    91                                 Геошторм     109
92    92                          Історія примари      92
93    93                           Привид у броні     107
94    94                    Пригоди Паддінгтона 2     103
95    95                                     Ноша     105
96    96                                  Новизна     117
97    97                              Знову вдома      97
98    98                   Історії сім'ї Майровіц     112
99    99                     Щасливий день смерті      96
100  100                             Синя безодня      89
```

В результаті виконання лабораторної роботи необхідно відповісти на запитання:
1. Виведіть перші 6 назв фільмів дата фрейму.
```r
head(movies$title, 6)
```
```
[1] "Той, хто біжить по лезу 2049" "Гра Моллі"                    "Тор: Раґнарок"                "Назви мене своїм ім'ям"      
[5] "Вбивство священного оленя"    "Воно"
```
2. Виведіть всі назви фільмів з тривалістю більше 120хв.
```r
movies[movies$runtime > 120, ]$title
```
```
 [1] "Той, хто біжить по лезу 2049"             "Гра Моллі"                                "Тор: Раґнарок"                           
 [4] "Назви мене своїм ім'ям"                   "Вбивство священного оленя"                "Воно"                                    
 [7] "Вартові Галактики 2"                      "Людина-павук: Повернення додому"          "Зоряні війни: Епізод 8 - Останні Джедаї" 
[10] "Красуня і Чудовисько"                     "Пірати Карибського моря: Помста Салазара" "Форма води"                              
[13] "Логан: Росомаха"                          "Трансформери: Останній лицар"             "Валеріан і місто тисячі планет"          
[16] "Чужий: Заповіт"                           "Диво-жінка"                               "Kingsman: Золоте кільце"                 
[19] "Джон Вік 2"                               "Мати!"                                    "Темні часи"                              
[22] "Примарна нитка"                           "Король Артур: Легенда меча"               "Сім сестер"                              
[25] "The Shack"                                "1+1: Нова історія"                        "Метелик"                                 
[28] "Форсаж 8"                                 "Вороги"                                   "Війна за планету мавп"                   
[31] "Saban's Могутні рейнджери"                "Постріл в безодню"                        "Зменшення"                               
[34] "Ферма Мадбаунд"                           "Усі гроші світу"
```
3. Скільки фільмів мають тривалість менше 100хв.
```r
nrow(movies[which(movies$runtime < 100),])
```
```
[1] 12
```
