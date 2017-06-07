# snake
## input
- switch 4個(sw[3:0]使用sw9~6)(用來控制小數點p)
- button 3個(使用button3~0)
    - button2 調整上下(按下時往下，不按時往上)
    - button1 往左
    - button0 往右
## output
- 七段顯示器4個7-seg(hex_d 使用二維陣列)
- 七段顯示器中的小數點額外用變數p
## 移動方式
1. 頭部的使用function依據目前的移動方向多一格亮的
2. 尾部因為移動而消失，如果吃到點點就不會消失(等於增長)
