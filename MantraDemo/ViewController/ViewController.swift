//
//  ViewController.swift
//  MantraDemo
//
//  Created by Jeetendra on 16/03/21.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var listTableView: UITableView!
    var categoryObj = NameModelView()

    var categoryArray: [Category] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchChatDataFromServer()
        // Do any additional setup after loading the view.
    }
    /**
       @Description :- Get the Category list from  server and reload the Table view.
       @Author : Jeetendra
       @Para : nil
       @ Returns: void
       @Date     : 16/03/2021
    */
     func fetchChatDataFromServer() {
        categoryArray = categoryObj.fetchCategoryData()
        self.listTableView.reloadData()
    }

}
extension ViewController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let imageViewLeft = UIImageView(frame: CGRect(x: 10, y: 20, width: 20, height: 20))
        imageViewLeft.image = #imageLiteral(resourceName: "category_Image")
        let headerHeading = UILabel(frame: CGRect(x: 40, y: 10, width: self.view.frame.width, height: 40))
        let headerBottumLine = UILabel(frame: CGRect(x: 0, y: 59, width: self.view.frame.width, height: 1))
        let headerTopLine = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 1))
        headerBottumLine.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        headerTopLine.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        let imageView = UIImageView(frame: CGRect(x: self.view.frame.width - 30, y: 20, width: 20, height: 20))
        if categoryArray[section].collapsed ?? false{
            imageView.image = #imageLiteral(resourceName: "Up-arrow-black")
        }else{
            imageView.image = #imageLiteral(resourceName: "down-arrow-black")
        }
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 60))
        let tapGuesture = UITapGestureRecognizer(target: self, action: #selector(headerViewTapped))
        tapGuesture.numberOfTapsRequired = 1
        headerView.addGestureRecognizer(tapGuesture)
        headerView.backgroundColor = #colorLiteral(red: 0.9249405265, green: 0.9250735641, blue: 0.9249115586, alpha: 1)
        headerView.tag = section
        headerHeading.text = categoryArray[section].name
        headerHeading.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        headerView.addSubview(imageViewLeft)
        headerView.addSubview(headerHeading)
        headerView.addSubview(imageView)
        headerView.addSubview(headerTopLine)
        headerView.addSubview(headerBottumLine)
        return headerView
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return categoryArray.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let itms = categoryArray[section]
        return !(itms.collapsed ?? false) ? 0 : itms.sub_category.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = listTableView.dequeueReusableCell(withIdentifier: CellIdentifierName.SubNameTVC) as! SubNameTVC
        let subCategory = categoryArray[indexPath.section].sub_category[indexPath.row]
        cell.nameLabel.text = subCategory.name
        cell.displayNameLabel.text = subCategory.display_name
        return cell
    }
    @objc func headerViewTapped(tapped:UITapGestureRecognizer){
        print(tapped.view?.tag ?? "")
        if categoryArray[tapped.view!.tag].collapsed == true{
            categoryArray[tapped.view!.tag].collapsed = false
        }else{
            categoryArray[tapped.view!.tag].collapsed = true
        }
        if let imView = tapped.view?.subviews[1] as? UIImageView{
            if imView.isKind(of: UIImageView.self){
                if categoryArray[tapped.view!.tag].collapsed ?? false{
                    imView.image = #imageLiteral(resourceName: "Up-arrow-black")
                }else{
                    imView.image = #imageLiteral(resourceName: "down-arrow-black")
                }
            }
        }
        listTableView.reloadData()
    }
    
}
