//
//  ContentView.swift
//  LifeCycle
//
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("Hello, world!")
            .onViewDidLoad {
                print("onViewDidLoad")
            }
            .onViewWillAppear {
                print("onViewWillAppear")
            }
            .onViewDidAppear {
                print("onViewDidAppear")
            }
            .onAppear {
                print("onAppear")
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

// MARK: - viewWillAppear
extension View {
    func onViewWillAppear(_ perform: @escaping (() -> Void)) -> some View {
        self.modifier(ViewWillAppearModifier(callback: perform))
    }
}

struct ViewWillAppearModifier: ViewModifier {
    let callback: () -> Void

    func body(content: Content) -> some View {
        content
            .background(ViewWillAppearHandler(onWillAppear: callback))
    }
}

struct ViewWillAppearHandler: UIViewControllerRepresentable {
    func makeCoordinator() -> ViewWillAppearHandler.Coordinator {
        Coordinator(onWillAppear: onWillAppear)
    }

    let onWillAppear: () -> Void

    func makeUIViewController(context: UIViewControllerRepresentableContext<ViewWillAppearHandler>) -> UIViewController {
        context.coordinator
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<ViewWillAppearHandler>) {
    }

    typealias UIViewControllerType = UIViewController

    class Coordinator: UIViewController {
        let onWillAppear: () -> Void

        init(onWillAppear: @escaping () -> Void) {
            self.onWillAppear = onWillAppear
            super.init(nibName: nil, bundle: nil)
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            onWillAppear()
        }
    }
}


extension View {
    func onViewDidLoad(_ perform: @escaping (() -> Void)) -> some View {
        self.modifier(ViewWillAppearModifier(callback: perform))
    }
}

struct ViewDidLoadHandler: UIViewControllerRepresentable {
    func makeCoordinator() -> ViewDidLoadHandler.Coordinator {
        Coordinator(onViewDidLoad: onViewDidLoad)
    }

    let onViewDidLoad: () -> Void

    func makeUIViewController(context: UIViewControllerRepresentableContext<ViewDidLoadHandler>) -> UIViewController {
        context.coordinator
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<ViewDidLoadHandler>) {
    }

    typealias UIViewControllerType = UIViewController

    class Coordinator: UIViewController {
        let onViewDidLoad: () -> Void

        init(onViewDidLoad: @escaping () -> Void) {
            self.onViewDidLoad = onViewDidLoad
            super.init(nibName: nil, bundle: nil)
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            onViewDidLoad()
        }
    }
}

struct ViewDidLoadModifier: ViewModifier {
    let callback: () -> Void

    func body(content: Content) -> some View {
        content
            .background(ViewDidLoadHandler(onViewDidLoad: callback))
    }
}

extension View {
    func onViewDidAppear(_ perform: @escaping (() -> Void)) -> some View {
        self.modifier(ViewDidAppearModifier(callback: perform))
    }
}

struct ViewDidAppearHandler: UIViewControllerRepresentable {
    func makeCoordinator() -> ViewDidAppearHandler.Coordinator {
        Coordinator(onViewDidAppear: onViewDidAppear)
    }

    let onViewDidAppear: () -> Void

    func makeUIViewController(context: UIViewControllerRepresentableContext<ViewDidAppearHandler>) -> UIViewController {
        context.coordinator
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<ViewDidAppearHandler>) {
    }

    typealias UIViewControllerType = UIViewController

    class Coordinator: UIViewController {
        let onViewDidAppear: () -> Void

        init(onViewDidAppear: @escaping () -> Void) {
            self.onViewDidAppear = onViewDidAppear
            super.init(nibName: nil, bundle: nil)
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
            onViewDidAppear()
        }
    }
}

struct ViewDidAppearModifier: ViewModifier {
    let callback: () -> Void

    func body(content: Content) -> some View {
        content
            .background(ViewDidAppearHandler(onViewDidAppear: callback))
    }
}
