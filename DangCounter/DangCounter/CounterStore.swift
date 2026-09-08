import Foundation
import Combine

final class CounterStore: ObservableObject {
    @Published private(set) var counts: [String: Int]

    private let defaults = UserDefaults.standard
    private let storageKey = "dangCounts"

    private static let dayFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()

    init() {
        counts = defaults.dictionary(forKey: storageKey) as? [String: Int] ?? [:]
    }

    private var todayKey: String {
        Self.dayFormatter.string(from: Date())
    }

    var todayCount: Int {
        counts[todayKey] ?? 0
    }

    func increment() {
        counts[todayKey, default: 0] += 1
        save()
    }

    func undo() {
        guard let current = counts[todayKey], current > 0 else { return }
        counts[todayKey] = current - 1
        save()
    }

    func resetToday() {
        counts[todayKey] = 0
        save()
    }

    var history: [(day: String, count: Int)] {
        counts
            .sorted { $0.key > $1.key }
            .prefix(30)
            .map { (day: $0.key, count: $0.value) }
    }

    private func save() {
        defaults.set(counts, forKey: storageKey)
    }
}
