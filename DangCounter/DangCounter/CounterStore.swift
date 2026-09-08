import Foundation
import Combine
import WidgetKit

final class CounterStore: ObservableObject {
    @Published private(set) var counts: [String: Int]

    private let defaults = DangCounterShared.sharedDefaults

    init() {
        counts = defaults.dictionary(forKey: DangCounterShared.storageKey) as? [String: Int] ?? [:]
    }

    private var todayKey: String {
        DangCounterShared.dayKey()
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
        defaults.set(counts, forKey: DangCounterShared.storageKey)
        WidgetCenter.shared.reloadAllTimelines()
    }
}
