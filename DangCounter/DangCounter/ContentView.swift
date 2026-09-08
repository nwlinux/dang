import SwiftUI
#if canImport(UIKit)
import UIKit
#endif

struct ContentView: View {
    @StateObject private var store = CounterStore()

    private static let displayDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        return formatter
    }()

    private static let historyDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()

    private static let historyDisplayFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }()

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text(Self.displayDateFormatter.string(from: Date()))
                    .font(.subheadline)
                    .foregroundStyle(.secondary)

                Text("\(store.todayCount)")
                    .font(.system(size: 88, weight: .bold, design: .rounded))
                    .foregroundStyle(.red)
                    .animation(.snappy, value: store.todayCount)

                Text("times today")
                    .font(.title3)
                    .foregroundStyle(.secondary)

                Button {
                    store.increment()
                    #if canImport(UIKit)
                    UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
                    #endif
                } label: {
                    Text("DANG!")
                        .font(.system(size: 36, weight: .heavy, design: .rounded))
                        .foregroundStyle(.white)
                        .frame(width: 200, height: 200)
                        .background(Circle().fill(Color.red))
                        .shadow(radius: 8)
                }
                .buttonStyle(.plain)

                HStack(spacing: 16) {
                    Button("Undo", role: .destructive) {
                        store.undo()
                    }
                    .disabled(store.todayCount == 0)

                    Button("Reset Today") {
                        store.resetToday()
                    }
                    .disabled(store.todayCount == 0)
                }
                .buttonStyle(.bordered)

                if !store.history.isEmpty {
                    List {
                        Section("History") {
                            ForEach(store.history, id: \.day) { entry in
                                HStack {
                                    Text(displayDay(entry.day))
                                    Spacer()
                                    Text("\(entry.count)")
                                        .fontWeight(.semibold)
                                }
                            }
                        }
                    }
                    .listStyle(.plain)
                }
            }
            .padding()
            .navigationTitle("Dang Counter")
        }
    }

    private func displayDay(_ key: String) -> String {
        guard let date = Self.historyDateFormatter.date(from: key) else { return key }
        return Self.historyDisplayFormatter.string(from: date)
    }
}

#Preview {
    ContentView()
}
