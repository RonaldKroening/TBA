//
//  ChVC.swift
//  Arm2
//
//  Created by Bianca on 7/28/20.
//  Copyright © 2020 Rift Labs. All rights reserved.
//

import Foundation
import MessageKit

struct Sender: SenderType{
    var senderId: String
    var displayName: String
}
struct Message: MessageType{
    var sender: SenderType
    var messageId: String
    var sentDate: Date
    var kind: MessageKind
    
}
class ChVC: MessagesViewController, MessagesDataSource, MessagesLayoutDelegate, MessagesDisplayDelegate{
    
    let currentUser = Sender(senderId: "self", displayName: "You")
    let cb = Sender(senderId: "other", displayName: "Chatbot")
    var messages = [MessageType]()
    override func viewDidLoad() {
        super.viewDidLoad()
        messages.append(Message(sender: cb,
                                messageId: "1",
                                sentDate: Date().addingTimeInterval(-86400),
                                kind: .text("Hello! How may I help you?")))
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
    }
    func currentSender() -> SenderType {
        return currentUser
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        return messages[indexPath.row]
    }
    
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        return messages.count
}
}

