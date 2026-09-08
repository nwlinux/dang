import Foundation

enum DangCounterShared {
    static let appGroupID = "group.com.nwlinux.dangcounter"
    static let storageKey = "dangCounts"

    static var sharedDefaults: UserDefaults {
        UserDefaults(suiteName: appGroupID) ?? .standard
    }

    private static let dayFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()

    static func dayKey(for date: Date = Date()) -> String {
        dayFormatter.string(from: date)
    }

    static func todayCount() -> Int {
        let counts = sharedDefaults.dictionary(forKey: storageKey) as? [String: Int] ?? [:]
        return counts[dayKey()] ?? 0
    }
}
