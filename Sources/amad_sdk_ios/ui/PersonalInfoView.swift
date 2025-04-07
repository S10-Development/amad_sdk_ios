
import SwiftUI

 struct PersonalInfoView: View {

    var personalInformation: PersonalInformationModel?
    var fisrtPage:ViewComponent = createDefaultView()
    @State private var selectedLocation: String = ""
    @State private var phone: String = ""
    @State private var email: String = ""
    @State private var name: String = ""
    @State private var navigateToNextView: Bool = false

     var body: some View {
         ScrollView{
             
             
             VStack(alignment: .leading, spacing: 16) {
                 // Imagen desde URL
                 if let urlImage = personalInformation?.urlImage {
                     AsyncProgressImage(url: urlImage)
                         .frame(maxWidth: .infinity, maxHeight: 200)
                 }
                 
                 // Título
                 if let title = personalInformation?.title {
                     Text(title)
                         .font(.title)
                         .fontWeight(.bold)
                         .padding(.horizontal)
                 }
                 
                 // Renderizado de showTypesData
                 if let showTypesData = personalInformation?.showTypesData {
                     ForEach(showTypesData, id: \.self) { type in
                         renderTypeView(type: type)
                     }
                 }
                 
                 Spacer()
                 
                 // Botón de continuar
                 Button(action: {
                     continueAction()
                 }) {
                     Text("Continuar")
                         .font(.headline)
                         .foregroundColor(.white)
                         .frame(maxWidth: .infinity)
                         .padding()
                         .background(Color.blue)
                         .cornerRadius(8)
                 }
                 .padding(.horizontal)
             }
             .padding(.top)
         }
         .navigationDestination(isPresented: $navigateToNextView) {
             
             LayoutView(view: fisrtPage)

         }
    }

    @ViewBuilder
    private func renderTypeView(type: ShowType) -> some View {
        switch type {
        case .localizacion:
            if let locationInfo = personalInformation?.locationInformation {
                LocationDropdownView(locationInfo:  Binding.constant(locationInfo))
            }
        case .telefono:
            InputFieldView(title: "Teléfono", text: $phone)
        case .correo:
            InputFieldView(title: "Correo", text: $email)
        case .nombre:
            InputFieldView(title: "Nombre", text: $name)
        }
    }
    
    private func continueAction() {
        self.navigateToNextView = true 
    }
}
