import SwiftUI
import SwiftData

struct MainView: View {
    
    // MARK: - State
    @State var selectingTabNumber: Int = 1
    
    // MARK: - View
    var body: some View {
        TabView(selection: $selectingTabNumber) {
            LoggingView()
                .tabItem { Label("Logging", systemImage: "mappin.and.ellipse")}
                .tag(1)
        }
    }
    
}

#Preview {
    MainView()
}
