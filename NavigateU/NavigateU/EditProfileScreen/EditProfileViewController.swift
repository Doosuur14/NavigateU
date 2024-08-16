//
//  EditProfileViewController.swift
//  NavigateU
//
//  Created by Faki Doosuur Doris on 15.08.2024.
//

import UIKit

class EditProfileViewController: UIViewController, EditProfileDelegate {

    var editProfileView: EditProfileView?
    let viewModel: EditProfileViewModel

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
            self?.loadPage()
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
        editProfileView?.backgroundColor = .white
    }

    private func loadPage() {
        self.editProfileView?.firstName.text = self.viewModel.firstName
        self.editProfileView?.lastName.text = self.viewModel.lastName
        self.editProfileView?.email.text = self.viewModel.email
        self.editProfileView?.password.text = self.viewModel.password
        self.editProfileView?.cityOfResidence.text = self.viewModel.cityOfResidence
        self.editProfileView?.countryOfOrigin.text = self.viewModel.nationality
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
