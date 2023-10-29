import SwiftUI
import SwiftData
import CoreLocation

struct LoggingModalView: View {
    
    // MARK: - State
    @ObservedObject var locationModel: LocationModel
    
    // MARK: - Properties
    
    var body: some View {
        VStack {
            LoggingButtonView(locationModel: locationModel)
                .padding(.top, 32)
                Spacer()
        }
    }
}

#Preview {
    LoggingModalView(locationModel: LocationModel())
}
