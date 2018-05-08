//
//  ConcentrationThemeChooserViewController.swift
//  Concentration
//
//  Created by Olivia Brown on 5/7/18.
//  Copyright © 2018 Olivia Brown. All rights reserved.
//

import UIKit

class ConcentrationThemeChooserViewController: UIViewController, UISplitViewControllerDelegate {
    
    private let themes = [
        "Animals": ConcentrationTheme(name: "Animals",
                           emojiChoices:["🦓", "🦒", "🦔", "🐂", "🐑", "🐒", "🐖", "🐓"],
                           backgroundColor: #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1),
                           cardBackgroundColor: #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)),
        "Sports": ConcentrationTheme(name: "Sports",
                           emojiChoices:["🏈", "🏀", "🎾", "⚽️", "🏐", "⚾️", "🎳", "⛸"],
                           backgroundColor: #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1),
                           cardBackgroundColor: #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)),
        "Smiles": ConcentrationTheme(name: "Smiles",
                           emojiChoices:["😀", "😁", "😂", "😃", "😄", "😊", "🙂", "☺️"],
                           backgroundColor: #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1),
                           cardBackgroundColor: #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)),
        "Cats": ConcentrationTheme(name: "Cats",
                           emojiChoices:["😸", "😹", "😺", "😻", "😼", "😽", "😿", "🙀"],
                           backgroundColor: #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1),
                           cardBackgroundColor: #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)),
        "Hearts": ConcentrationTheme(name: "Hearts",
                           emojiChoices:["💕", "💓", "💖", "💗", "💘", "💝", "💞", "❣️"],
                           backgroundColor: #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1),
                           cardBackgroundColor: #colorLiteral(red: 0.6670553684, green: 0.4118469357, blue: 0.8984902501, alpha: 1)),
        "Ocean": ConcentrationTheme(name: "Ocean",
                           emojiChoices:["🐠", "🏖", "🏝", "⛵️", "🐋", "🐬", "🦀", "🐚"],
                           backgroundColor: #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1),
                           cardBackgroundColor: #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1))
    ]
    
    override func awakeFromNib() {
        splitViewController?.delegate = self
    }
    
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        
        if let cvc = secondaryViewController as? ConcentrationViewController {
            if cvc.theme == nil {
                return true
            }
        }
        return false
    }
    
    @IBAction func changeTheme(_ sender: Any) {
        if let cvc = splitViewDetailConcentrationVC {
            if let themeName = (sender as? UIButton)?.currentTitle, let theme = themes[themeName] {
                cvc.theme = theme
            }
        }
        else if let cvc = lastSeguedToConcentrationViewController {
            if let themeName = (sender as? UIButton)?.currentTitle, let theme = themes[themeName] {
                cvc.theme = theme
            }
            navigationController?.pushViewController(cvc, animated: true)
        }
        else {
            performSegue(withIdentifier: "chooseTheme", sender: sender)
        }
    }
    
    private var splitViewDetailConcentrationVC: ConcentrationViewController? {
        return splitViewController?.viewControllers.last as? ConcentrationViewController
    }
    

    private var lastSeguedToConcentrationViewController: ConcentrationViewController?
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "chooseTheme" {
            if let themeName = (sender as? UIButton)?.currentTitle, let theme = themes[themeName] {
                if let cvc = segue.destination as? ConcentrationViewController {
                    cvc.theme = theme
                    lastSeguedToConcentrationViewController = cvc
                }
            }
        }
    }
}
