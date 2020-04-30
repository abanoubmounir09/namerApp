//
//  ViewController.swift
//  namerRX
//
//  Created by pop on 4/15/20.
//  Copyright © 2020 pop. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    
    var namesArray:Variable<[String]> = Variable([])
    
    @IBOutlet weak var nameLB: UILabel!
    @IBOutlet weak var TXFName: UITextField!
    @IBOutlet weak var submitBTN: UIButton!
    @IBOutlet weak var resultLB: UILabel!
    @IBOutlet weak var AddNameBTN: UIButton!
    
    let disposve = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
//       // bund()
//        bindpublishSubject()
        bindTextField()
        bindSubmitButn()
        bindAddBTn()
        namesArray.asObservable().subscribe(onNext:{ names in
            self.resultLB.text = names.joined(separator: ", ")
        }).disposed(by: disposve)
    }
    
    func bindTextField(){
        TXFName.rx.text.map{
            if $0 == ""{
                return "write ur name below "
            }else{
                return "helloo , \($0!)"
            }
            
        }
        .bind(to: nameLB.rx.text)
        .addDisposableTo(disposve)
    }
    
    func bindSubmitButn(){
        submitBTN.rx.tap.subscribe(onNext:{
            if self.TXFName.text != ""{
                self.namesArray.value.append(self.TXFName.text!)
                self.resultLB.rx.text.onNext(self.namesArray.value.joined(separator: ", "))
                self.TXFName.rx.text.onNext("")
                self.nameLB.rx.text.onNext("")
            }
        })
            .addDisposableTo(disposve)
    }
    
    func bindAddBTn(){
        AddNameBTN.rx.tap.throttle(0.5,scheduler:MainScheduler.instance).subscribe(onNext:{
           guard let addNameVC = self.storyboard?.instantiateViewController(withIdentifier: "AddNameVC")as? AddNameVC else{fatalError("couldnot creat addname vc")}
            addNameVC.nameSubject.subscribe(onNext:{name in
                self.namesArray.value.append(name)
                addNameVC.dismiss(animated: true, completion: nil)
            }).disposed(by: self.disposve)
            self.present(addNameVC, animated: true, completion: nil)
        })
    }
    
    
//    func bund(){
//        let numseq = Observable.just(5)
//        let numsubsc = numseq.subscribe(onNext : {print($0)})
//
//        let hellosq = Observable.from(["a","b","c","d","e","f"])
//        let helsub = hellosq.subscribe { (event) in
//            switch event{
//            case .next(let value):
//                print( value)
//            case .error(let error):
//                print(error)
//            case .completed:
//                print("its completed")
//            }
//        }
//        //
//       let helsub2 = hellosq.subscribe(onNext:{print($0)})
//    }
//
//    // PUBLISHSUBJECT :- subscrip just all after it
//    func bindpublishSubject(){
//        var pubsub = PublishSubject<String>()
//        pubsub.onNext("publish Subject kind in observable")
//        let pubsubcrip = pubsub.subscribe(onNext:{print($0)})
//        pubsub.onNext("publish Subject kind in observable read onlyafter subscription")
//    }
//
//    // BehaviorSubject : execute one above it and all after
//    func bindBehaviorSubject(){
//        var behSub = BehaviorSubject(value: "value A")
//        var subsubscrip = behSub.subscribe(onNext: {print($0)})
//        behSub.onNext("Two")
//    }
//
//    // replaySubject: usr buffer subscriprlast three element above it
//    func BindreplaySubject(){
//        var accountSubj = ReplaySubject<Double>.create(bufferSize: 3)
//
//    }
    
    
    
    
    
}

