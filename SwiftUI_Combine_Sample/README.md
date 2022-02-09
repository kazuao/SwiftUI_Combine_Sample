# PassthoughSubject
- completionやerrorをthrowすると処理が終了する
- cancellableの戻り値を使用しないと発火しない

# SubscribeとSubscription
- sinkメソッド→RxSwiftでいうsubscribe()
- cancelする場合は、cancellable.cancel()
- 複数subscribeすることができる

- store
	- anyCancellablesで複数のsubscribeを保持できる
	
- assign
	- sinkと違って、オブジェクトを指定する
	- .assign(to: \.value, on: object)（object内のvalueオブジェクトにassginする）
	- RxSwiftでいうbind
	
# Publisher
- Sequence
	- let publisher = [1, 2, 3, 4, 5].publisher ←ここ
	- 配列などをPublisher.sequence型にして.finishで終わる
	
- Timer
	- let publisher = Timer.publish(every: 1, on: .main, in: .common)
	- publisher.connect() // connectをしないとpublishしない
	- .autoconnect().sink()でもいける
	
- Notification
	- let publisher = NotificationCenter.default.publisher(for: Notification.Name("Hoge")
	- NotificationCenter.default.post(Notification(name: "Hoge")
	- でsinkで受け取る
	
- URLSession
	
# Operator

# Combineのコンセプト
