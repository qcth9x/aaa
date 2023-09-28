//
//  LawJerryMessageViewController.swift
//  LawJerry
//
//  Created by Lê Đình Linh on 25/09/2023.
//

import UIKit

class LawJerryMessageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextViewDelegate, UITextFieldDelegate{

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var imageIcon: UIImageView!
    @IBOutlet weak var tbnMessage: UITableView!
    
    var messageRequest: [Any] = []
    var hasReceivedResponse = true
    let apiHandler = APIHandler()
    var messageBOT: [LawJerryResponseModel] = []

        override func viewDidLoad() {
            super.viewDidLoad()
            imageIcon.layer.cornerRadius = 26
            textField.delegate = self
            tbnMessage.dataSource = self
            tbnMessage.delegate = self
            tbnMessage.register(UINib(nibName: "MessageUserTableViewCell", bundle: nil), forCellReuseIdentifier: "MessageUserIdentifier")
            tbnMessage.register(UINib(nibName: "MessageBOTTableViewCell", bundle: nil), forCellReuseIdentifier: "MessageBOTIdentifier")
            getMessageBOT()
        }

        func getMessageBOT() {
            textField.isEnabled = hasReceivedResponse
            if hasReceivedResponse {
                textField.placeholder = "Nhập câu hỏi của bạn..."
            } else {
                textField.placeholder = "Vui lòng đợi câu trả lời trước khi tiếp tục"
            }

            apiHandler.getMessageBOT { [weak self] responseMessage in
                if let response = responseMessage {
                    let responseModel = LawJerryResponseModel(answer: response)
                    self?.messageRequest.append(responseModel)
                    self?.tbnMessage.reloadData()

                    let responseIndexPath = IndexPath(row: (self?.messageRequest.count ?? 0) - 1, section: 0)
                    self?.tbnMessage.scrollToRow(at: responseIndexPath, at: .bottom, animated: true)

                    self?.hasReceivedResponse = true
                    self?.textField.isEnabled = true
                    self?.textField.placeholder = "Nhập câu hỏi của bạn..."
                }
            }
        }

        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return messageRequest.count
        }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = messageRequest[indexPath.row]

        if let requestModel = message as? LawJerryRequestModel {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MessageUserIdentifier", for: indexPath) as! MessageUserTableViewCell
            cell.lblMessageUser.text = requestModel.text
            return cell
        } else if let responseModel = message as? LawJerryResponseModel {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MessageBOTIdentifier", for: indexPath) as! MessageBOTTableViewCell
            cell.lblMessageBOT.text = responseModel.answer
            return cell
        }

        return UITableViewCell()
    }

        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 60
        }

        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            sendChatMessage()
            return true
        }

        @IBAction func sendButtonTapped(_ sender: UIButton) {
            sendChatMessage()
        }

        func sendChatMessage() {
            if hasReceivedResponse {
                if let text = textField.text,
                   !text.isEmpty {
                    let requestModel = LawJerryRequestModel(text: text)
                    messageRequest.append(requestModel)
                    tbnMessage.reloadData()

                    let indexPath = IndexPath(row: messageRequest.count - 1, section: 0)
                    tbnMessage.scrollToRow(at: indexPath, at: .bottom, animated: true)

                    apiHandler.postMessageUser(newPost: ["text": text]) { [weak self] success in
                        if success {
                            self?.getMessageBOT()
                        }
                    }

                    textField.text = ""
                    textField.isEnabled = false
                    hasReceivedResponse = false
                }
            } else {
                textField.placeholder = "Vui lòng đợi câu trả lời trước khi tiếp tục"
            }
        }
    }
