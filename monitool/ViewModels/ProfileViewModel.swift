//
//  ProfileViewModel.swift
//  monitool
//
//  Created by Christianto Budisaputra on 05/08/21.
//

import FirebaseFirestore
import Foundation
import FirebaseAuth
import FirebaseStorage

class ProfileViewModel: ObservableObject {
	
	@Published var employees = [Employee]()
    @Published var company: Company
    
	// UI State
	@Published var isPinHidden = true
	@Published var isPinPresenting = false
	@Published var isAddEmployeePresenting = false
    
    @Published var pinInputted = ""
    @Published var showingAlert = false
    @Published var isPasscodeFieldDisabled = false
    @Published var isPinRight = true

    private let companyRepository: CompanyRepository = .shared
    
    
    
    init() {
        company = Company(name: "", minReview: 0, ownerPin: "", hasLoggedIn: true, profileImage: "")
        getCompany()
    }

	func delete(_ offsets: IndexSet) {
		offsets.forEach { index in
			employees.remove(at: index)
		}
	}

	var reviewerString: String {
        "\(company.minReview) Reviewer\(company.minReview > 1 ? "s" : "")"
	}

	func incrementReviewer() {
        company.minReview += 1
        if company.minReview > employees.count { company.minReview = employees.count }
	}

	func decrementReviewer() {
        company.minReview -= 1
        if company.minReview < 0 { company.minReview = 0 }
	}
    
    func getCompany() {
        if let ref = companyRepository.companyRef {
            ref.getDocument(completion: { doc, err in
                if let err = err {
                    fatalError("Unresolved error: \(err)")
                }
                if let doc = doc, doc.exists {
                    do {
                        self.company = Company(name: doc.get("name") as! String, minReview: doc.get("minReview") as! Int, ownerPin: doc.get("ownerPin") as! String, hasLoggedIn: true, profileImage: doc.get("profileImage") as! String)
                    } catch {
                        print("Unresolved error: \(error.localizedDescription)")
                    }
                }
            })
        }
    }
}
