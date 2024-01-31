import Foundation
import SwiftUI


class CustomNavigationStack:ObservableObject {
    
    @Published var selectedTab: TabCustom = .menu
    @Published var showCustomTapbar = true
}
