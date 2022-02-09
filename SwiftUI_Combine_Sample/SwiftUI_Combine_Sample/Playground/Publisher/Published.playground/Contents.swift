import Combine

final class Sender {
    @Published var event: String = "A"
}

let sender = Sender()

final class Receiver {
    var subscriptions = Set<AnyCancellable>()

    init() {
        sender.$event
            .sink { value in
                print("Received value:", value)
            }
            .store(in: &subscriptions)
    }
}

let receiver = Receiver()
sender.event = "あ"
sender.event = "い"
sender.event = "う"
sender.event = "え"
sender.event = "お"
