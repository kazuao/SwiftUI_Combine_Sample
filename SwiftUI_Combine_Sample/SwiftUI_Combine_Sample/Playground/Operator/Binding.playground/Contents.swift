import Combine

final class Model {
    @Published var value: String = "0"
}

let model = Model()

final class ViewModel {
    var text: String = "" {
        didSet {
            print("didset text:", text)
        }
    }
}

final class Receiver {
    var subscriptions = Set<AnyCancellable>()
    let viewModel = ViewModel()

    init() {
        model.$value
            .assign(to: \.text, on: viewModel)
            .store(in: &subscriptions)
    }
}
