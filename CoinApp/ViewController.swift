//
//  ViewController.swift
//  CoinApp
//
//  Created by 高橋康之 on 2020/09/13.
//  Copyright © 2020 yasu.com. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate,CoinManegerDelegate {
    
    
    func didUpdatePrice(price: String, currency: String, cA: String) {
        
        DispatchQueue.main.async {
            self.coinLabel.text = price
            self.virtualCurrencyLabel.text = currency
            self.currencyLabel.text = cA
        
        }
    }
    //エラー処理として必要
    func didFailWithError(error: Error) {
        print("error")
    }
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
//    構造体CoinManagerにアクセス
    var coinManager = CoinManager()
    
//    ピッカービューのセルの数
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return coinManager.virtualCurrencyArray.count
        case 1:
            return coinManager.currencyArray.count
        default:
            return 0
        }
//        構造体の中のcurrencyArrayのカウント分
//        return coinManager.virtualCurrencyArray.count
//        return coinManager.currencyArray.count
    }
    
//    セルに表示するラベル
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0:
            return coinManager.virtualCurrencyArray[row]
        case 1:
            return coinManager.currencyArray[row]
        default:
            return "error"
        }
//        return coinManager.virtualCurrencyArray[row]
//        return coinManager.currencyArray[row]
        
    }
    
//    選択されたピッカーの値を取得（何をユーザーが選んでいるのか分かるところ）
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //ここ追加
//        switch component {
//        case 0:
//            virtualCurrencyLabel.text = coinManager.virtualCurrencyArray[row]
//        case 1:
//            currencyLabel.text = coinManager.currencyArray[row]
//        default:
//            break
//        }
        
        
        //pickerViewの選択が分技する場合は[pickerView.selectedRow(inComponent: 0)]とする｡switchの定数式で指定した値を使うのだろうか？
        let selectedCurrency = coinManager.virtualCurrencyArray[pickerView.selectedRow(inComponent: 0)]
        let selectedCurrency2 =
        coinManager.currencyArray[pickerView.selectedRow(inComponent: 1)]
        print(selectedCurrency)
        print(selectedCurrency2)
        
        
        //        コインマネージャーの値をgetCoinPriceに送る(それはslectCurrency)の値
        //        値渡しCoinManagerに格納されている値をgetCoinPriceに送る｡それはselectedCurrencyに格納された値です｡
                
        coinManager.getCoinPrice(for: selectedCurrency2, cA: selectedCurrency)
                
   
//
////        取得の確認
        print(row,coinManager.virtualCurrencyArray[row])
        print(row,coinManager.currencyArray[row])
//
////        入れて
//        let selectedCurrency = coinManager.virtualCurrencyArray[row]
//        let selectedCurrency2 = coinManager.currencyArray[row]
//
////        コインマネージャーに送る
      
        
       
        
        
//
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
        
        coinManager.delegate = self
//        currencyLabel.text = ""
        
    }
    
    @IBOutlet var coinLabel: UILabel!
    
    @IBOutlet var currencyLabel: UILabel!
    
    @IBOutlet var virtualCurrencyLabel: UILabel!
    
    @IBOutlet var currencyPicker: UIPickerView!
    


}

