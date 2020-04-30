//
//  AddNameVC.swift
//  namerRX
//
//  Created by pop on 4/17/20.
//  Copyright © 2020 pop. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class AddNameVC: UIViewController {

    @IBOutlet weak var NewNameTXTF: UITextField!
    @IBOutlet weak var submitBTN: UIButton!
    
    let disposeBag = DisposeBag()
    let nameSubject = PublishSubject<String>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindnewname()
    }
    
    func bindnewname(){
        submitBTN.rx.tap.subscribe(onNext:{
            if self.NewNameTXTF.text != ""{
                self.nameSubject.onNext(
                    self.NewNameTXTF.text!
                )
            }
        })
            
        
        
    }
    


}
