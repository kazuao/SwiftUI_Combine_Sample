import SwiftUI
import Combine

let url = URL(string: "https://www.example.com")!
let publisher = URLSession.shared.dataTaskPublisher(for: url)

final class Receiver {
    var subscriptions = Set<AnyCancellable>()

    init() {
        publisher
            .sink(receiveCompletion: { completion in

                if case let .failure(error) = completion {
                    print("Received error", error)
                } else {
                    print("Received completion:", completion)
                }

            }, receiveValue: { data, response in
                print("Received data:", data)
                print("Received response:", response)
            })
            .store(in: &subscriptions)
    }
}

let receiver = Receiver()

