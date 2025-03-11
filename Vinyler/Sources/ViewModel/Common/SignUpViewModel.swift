//
//  SignUpViewModel.swift
//  Vinyler
//
//  Created by Songkyung Min on 3/11/25.
//  Copyright © 2025 songkyung min. All rights reserved.
//

import Foundation

protocol SignUpViewModelInput {
}

protocol SignUpViewModelOutput {
}

protocol SignUpViewModelType {
}

class SignUpViewModel: SignUpViewModelInput, SignUpViewModelOutput, SignUpViewModelType {
    
    var input: SignUpViewModelInput { return self }
    var output: SignUpViewModelOutput { return self }
    
}
