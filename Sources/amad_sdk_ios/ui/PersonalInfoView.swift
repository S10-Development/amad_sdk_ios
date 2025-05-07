
import SwiftUI

struct PersonalInfoView: View {

    var personalInformation: PersonalInformationModel?
    var fisrtPage:ViewComponent = createDefaultView()
    var idApplication: String = Constants.EMPTY_STRING
    @State private var validInputType:[PersonalInfoFieldType:Bool] = [:]
    @ObservedObject private var viewmodel: PersonalInformationViewModel = PersonalInformationViewModel()

    init(
        personalInformation: PersonalInformationModel? = nil,
        fisrtPage: ViewComponent,
        idApplication: String
    ) {
        self.personalInformation = personalInformation
        self.fisrtPage = fisrtPage
        self.idApplication = idApplication
        
        viewmodel.idApplication = idApplication
    }

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
                    ForEach(showTypesData, id: \.type) { type in
                        renderTypeView(showType: type)
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
                .disabled(validInputType.values.contains(false))
                .padding(.horizontal)
            }
            .padding(.top)
        }
        .navigationDestination(
            isPresented: self.$viewmodel.navigateToNextView
        ) {
            LayoutView(view: fisrtPage)
        }
        .navigationBarBackButtonHidden(true)

        .showLoadingDialog($viewmodel.isLoading)
        .showErrorDialog($viewmodel.showedError, by: viewmodel.dialogInformation) 
        .onAppear(perform: {
            self.viewmodel.idApplication = idApplication
            self.setupValidInputType()
        })
    }
    
    private func setupValidInputType() {
        guard let showTypesData = personalInformation?.showTypesData else {
            return
        }

        // Por cada tipo, si NO es requerido lo marcamos válido (true) desde el inicio
        for showType in showTypesData {
            validInputType[showType.type] = !showType.isRequeried
        }
    }

    @ViewBuilder
    private func renderTypeView(showType: ShowType) -> some View {
        switch  showType.type{
        case .localizacion:
            if let locationInfo = personalInformation?.locationInformation {
                LocationDropdownView(
                    locationInfo:  Binding.constant(locationInfo),
                    isRequired: showType.isRequeried,
                    onValidation: {
                        isValid in
                        self.validInputType[.localizacion] = showType.isRequeried ? isValid : true
                    },
                    onSelectedType: {
                        typeSelected,
                        locationInfo in
                        self.viewmodel.selectionLocation.location = locationInfo
                        self.viewmodel.selectionLocation.type = typeSelected
                        
                        
                    }
                )
            }
        case .telefono:
            InputFieldView(
                title: "Teléfono",
                text: self.$viewmodel.phone,
                isRequired: showType.isRequeried,
                keyboardType:  UIKeyboardType.phonePad,
                validationBuilder: { builder in
                    builder.phone()
                },

            ) { isValid in
                self.validInputType[.telefono] = showType.isRequeried ? isValid : true
            }
        case .correo:
            InputFieldView(
                title: "Correo",
                text: self.$viewmodel.email,
                isRequired: showType.isRequeried,
                keyboardType:  UIKeyboardType.emailAddress,
                validationBuilder: { builder in
                    builder.email()
                },
            ) { isValid in
                
                self.validInputType[.correo] = showType.isRequeried ? isValid : true
            }
        case .nombre:
            InputFieldView(
                title: "Nombre",
                text: self.$viewmodel.name,
                isRequired: showType.isRequeried,
                keyboardType:  UIKeyboardType.default,
                validationBuilder: { builder in
                    builder.name()
                },
            ) { isValid in
                self.validInputType[.nombre] = showType.isRequeried ? isValid : true
            }
        }
    }
    
    private func continueAction() {
        if(validInputType.values.contains(false)
        ){
            return
        }
        self.viewmodel.sendPersonalInformation()
    }
}
