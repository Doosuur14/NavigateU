//
//  EditProfileViewController.swift
//  NavigateU
//
//  Created by Faki Doosuur Doris on 15.08.2024.
//

import UIKit
import Combine

protocol EditProfileModuleProtocol: AnyObject {
    var editProfileView: EditProfileView? { get set }
    var viewModel: EditProfileViewModel { get }
}

class EditProfileViewController: UIViewController, EditProfileDelegate, EditProfileModuleProtocol {
    var editProfileView: EditProfileView?
    var viewModel: EditProfileViewModel
    private var cancellables: Set<AnyCancellable> = []

    init(viewModel:EditProfileViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        viewModel.fetchUserProfile()
        viewModel.onProfileDetails = { [weak self] in
            self?.bindViewModel()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchUserProfile()
    }


    func setupView() {
        editProfileView = EditProfileView(frame: view.bounds)
        view = editProfileView
        editProfileView?.delegate = self
        editProfileView?.backgroundColor = .systemBackground
    }

    private func bindViewModel() {
        viewModel.$profile
            .receive(on: DispatchQueue.main)
            .sink { [weak self] userProfile in
                self?.editProfileView?.firstName.text = userProfile?.firstName
                self?.editProfileView?.lastName.text = userProfile?.lastName
                self?.editProfileView?.email.text = userProfile?.email
                self?.editProfileView?.password.text = userProfile?.password
                self?.editProfileView?.countryOfOrigin.text = userProfile?.nationality
                self?.editProfileView?.cityOfResidence.text = userProfile?.cityOfResidence
            }
            .store(in: &cancellables)
    }
    
    func didTapSaveButton() {

        guard let form = editProfileView?.configureForm() else {
            AlertManager.shared.showEmptyFieldAlert(viewCon: self)
            return
        }
        guard isValidEmail(form.emailText ?? "") else {
            AlertManager.shared.showWrongEmailAlert(viewCon: self)
            return
        }

        viewModel.updateUserProfile(firstName: form.firstname ?? "", lastName: form.lastname ?? "", password: form.passwordText ?? "", cityOfResidence: form.city ?? "", nationality: form.country ?? "") { result in
            switch result {
            case .success:
                AlertManager.shared.showUpdateAlert(viewCon: self)
                self.editProfileView?.password.text = ""
            case .failure:
                AlertManager.shared.showUpdateFailureAlert(viewCon: self)
            }
        }
    }


    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPredicate.evaluate(with: email)
    }
}
