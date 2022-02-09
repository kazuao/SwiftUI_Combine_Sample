import Combine

let subject = PassthroughSubject<String, Never>()
let publisher = subject.eraseToAnyPublisher()

final class Receiver {
    var subscriptions = Set<AnyCancellable>()

    init() {
        publisher
            .sink { value in
                print("Received value:", value)
            }
            .store(in: &subscriptions)
    }
}

// publisherにはsendできない
// subjectは限定公開にして、publisherで購読だけする
