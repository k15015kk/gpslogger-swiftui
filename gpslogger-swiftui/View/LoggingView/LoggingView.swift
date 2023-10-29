import SwiftUI
import MapKit

struct LoggingView: View {
    
    // MARK: State
    @StateObject var locationModel = LocationModel()
    
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
                Button(
                    action: {
                        Task {
                            do {
                                if locationModel.isLocationUpdate {
                                    locationModel.isLocationUpdate.toggle()
                                } else {
                                    locationModel.isLocationUpdate.toggle()
                                    try await locationModel.startLocation()
                                }
                            } catch {
                                print(error)
                                print("位置情報の取得ができませんでした")
                            }
                        }
                    },
                    label: {
                        Label(
                            title: {
                                Text( locationModel.isLocationUpdate ? "LocationStop" : "Location Start")
                                    .foregroundStyle(.white)
                            },
                            icon: {
                                Image(systemName: "record.circle")
                                    .foregroundStyle(.white)
                            }
                        )
                        .padding(8)
                        .background(.red)
                        .clipShape(RoundedRectangle(cornerRadius: 4))
                        .padding(.bottom, 8)
                    }
                )
            }
        }
    }
}

#Preview {
    LoggingView()
}
