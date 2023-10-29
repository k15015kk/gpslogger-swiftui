import SwiftUI
import SwiftData
import CoreLocation

struct LoggingModalView: View {
    
    // MARK: - State
    @ObservedObject var locationModel: LocationModel
    @Binding var presentationState: PresentationDetent
    
    // MARK: - Properties
    
    var body: some View {
        VStack {
            LoggingButtonView(locationModel: locationModel)
                .padding(.top, 32)
            
            if presentationState == .medium {
                Grid(alignment: .leading) {
                    GridRow{
                        InfomationPanelView(title: "緯度", value: $locationModel.latitude)
                        InfomationPanelView(title: "緯度", value: $locationModel.longitude)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 16)
                    GridRow{
                        InfomationPanelView(title: "標高(m)", value: $locationModel.altitude)
                        InfomationPanelView(title: "楕円体高(m)", value: $locationModel.ellipsoidalAltitude)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 16)
                    GridRow{
                        InfomationPanelView(title: "速度(km/h)", value: $locationModel.speed)
                        InfomationPanelView(title: "方向(°)", value: $locationModel.course)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 16)
                }
                Spacer()
            }
        }
    }
}

#Preview {
    LoggingModalView(locationModel: LocationModel(), presentationState: .constant(.small))
}
