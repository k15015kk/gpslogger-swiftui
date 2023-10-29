import SwiftUI
import MapKit
import SwiftData

struct LoggingView: View {
    
    // MARK: State
    @StateObject var locationModel = LocationModel()
    @State var isOpenSheet = true
    
    // MARK: Properties
    private let tokyoStationCoordinate: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 35.681111, longitude: 139.766667)
    
    var body: some View {
        ZStack {
            Map {
                Marker("TokyoStation", systemImage: "tram.circle.fill", coordinate: tokyoStationCoordinate)
            }
            .mapControls {
                MapCompass()
                MapUserLocationButton()
                MapScaleView()
            }
            .mapControlVisibility(.visible)
            
            VStack {
                Spacer()
            }
        }
        .sheet(isPresented: $isOpenSheet) {
            LoggingModalView(locationModel: locationModel)
                .interactiveDismissDisabled()
                .presentationDetents([.height(64.0)])
                .presentationDragIndicator(.visible)
        }
    }
}

#Preview {
    LoggingView()
}
