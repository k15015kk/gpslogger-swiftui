import SwiftUI
import SwiftData
import CoreLocation

struct LoggingButtonView: View {
    
    // MARK: - State
    @ObservedObject var locationModel: LocationModel
    @Environment(\.modelContext) private var context
    @Query private var locations: [LocationItem]
    
    var body: some View {
        HStack {
            Button( action: {
                Task {
                    do {
                        if locationModel.isLocationUpdate {
                            locationModel.isLocationUpdate.toggle()
                        } else {
                            locationModel.isLocationUpdate.toggle()
                            locationModel.locationSaveHandler = self.add(location:)
                            try await locationModel.startLocation()
                        }
                    } catch {
                        print(error)
                        print("位置情報の取得ができませんでした")
                    }
                }
            }) {
                Label(
                    title: {
                        Text( locationModel.isLocationUpdate ? "停止" : "開始")
                            .foregroundStyle(.red)
                    },
                    icon: {
                        Image(systemName: "record.circle")
                            .foregroundStyle(.red)
                    }
                )
                .padding(8)
                .frame(maxWidth: .infinity)
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .shadow(color: .black.opacity(0.4), radius: 2, x: 0, y: 2)
                .padding(.bottom, 8)
            }
            
            Button( action: {
                // セーブ
            }) {
                Label(
                    title: {
                        Text("保存")
                            .foregroundStyle(.blue)
                    },
                    icon: {
                        Image(systemName: "square.and.arrow.down")
                            .foregroundStyle(.blue)
                    }
                )
                .padding(8)
                .frame(maxWidth: .infinity)
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .shadow(color: .black.opacity(0.4), radius: 2, x: 0, y: 2)
                .opacity(locationModel.isLocationUpdate ? 0.2 : 1.0)
                .padding(.bottom, 8)
            }
            .disabled(locationModel.isLocationUpdate)
            
            Button( action: {
                do {
                    try self.allDelete()
                }
                catch {
                    print(error)
                }
            }) {
                Label(
                    title: {
                        Text("削除")
                            .foregroundStyle(.white)
                    },
                    icon: {
                        Image(systemName: "trash")
                            .foregroundStyle(.white)
                    }
                )
                .padding(8)
                .frame(maxWidth: .infinity)
                .background(.red)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .shadow(color: .black.opacity(0.4), radius: 2, x: 0, y: 2)
                .opacity(locationModel.isLocationUpdate ? 0.2 : 1.0)
                .padding(.bottom, 8)
            }
            .disabled(locationModel.isLocationUpdate)
        }
        .padding(.horizontal, 16)
    }
    
    // MARK: - function
    
    private func add(location: CLLocation) {
        
        let data = LocationItem(
            latitude: location.coordinate.latitude,
            longitude: location.coordinate.longitude,
            altitude: location.altitude,
            ellipsoidalAltitude: location.ellipsoidalAltitude,
            horizontalAccuracy: location.horizontalAccuracy,
            verticalAccuracy: location.verticalAccuracy,
            speed: location.speed,
            speedAccuracy: location.speedAccuracy,
            course: location.course,
            courseAccuracy: location.courseAccuracy,
            timestamp: location.timestamp
        )
        
        context.insert(data)
        
        print(locations.count)
    }
    
    private func allDelete() throws {
        try context.delete(model: LocationItem.self)
        
        print(locations.count)
    }
}

#Preview {
    LoggingButtonView(locationModel: LocationModel())
}
