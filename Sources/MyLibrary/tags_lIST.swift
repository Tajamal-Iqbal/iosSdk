//
//  File.swift
//  
//
//  Created by Toseef Ahmed on 05/09/2022.
//

import Foundation
import UIKit
class TagsView : UIView{
    
    let view = UIView()
    var collectiontags : UICollectionView?
    let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
    
    var btnCroosStatus: Bool
    var tagBackColor: UIColor
    var tagTextColor: UIColor
    var btnBackgroundColor : UIColor
    var btnBorderColor : UIColor
    var arryTags : [String]?
    
    fileprivate let cellid = "Cella"
    
    init(btnCross: Bool ,viewBacColor: UIColor,btnCancelBackColor: UIColor,btnBorderColor: UIColor,tagTextcolor:UIColor,TagsArray: [String],scrolTags: Bool,frame: CGRect = .zero) {
        self.btnBorderColor = btnBorderColor
        self.btnBackgroundColor = btnCancelBackColor
        self.tagTextColor = tagTextcolor
        self.tagBackColor = viewBacColor
        self.btnCroosStatus = btnCross
        self.arryTags = TagsArray
        self.collectiontags?.isScrollEnabled = scrolTags

        super.init(frame: frame)
        SetupUi()
    }
    func reloadCollection() {
       // self.arryTags = TagsArray
        collectiontags?.reloadData()
    }
    
    func SetupUi(){
        Initilizer()
        
        addSubview(view)
        view.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor , padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        
        view.backgroundColor = .white
        layout.scrollDirection = UICollectionView.ScrollDirection.vertical
        collectiontags?.delegate = self
        collectiontags?.dataSource = self
        collectiontags?.backgroundColor = .white

        view.addSubview(collectiontags!)
        collectiontags?.register(TagCell.self, forCellWithReuseIdentifier: cellid)
        
        collectiontags?.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor,padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        
    }
    func Initilizer(){
        collectiontags  = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())
    }
    
    func appendNewTags(txtTags:String){
        arryTags?.append(txtTags)
        collectiontags?.reloadData()
    }
    
    func SetTags(txtTags:[String]){
        arryTags = txtTags
        collectiontags?.reloadData()
    }
  
    func RemoveTags(){
        arryTags?.removeAll()
        collectiontags?.reloadData()
    }
   
    @objc func btnCross(sender: UIButton){
        let buttonTag = sender.tag
        print(buttonTag)
        arryTags?.remove(at: buttonTag)
        collectiontags?.reloadData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension TagsView : UICollectionViewDataSource,UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arryTags!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellid, for: indexPath) as! TagCell
        cell.labedisp?.text = arryTags?[indexPath.row]
        cell.btnCross?.tag = indexPath.row
        cell.btnCross?.isHidden = btnCroosStatus
        cell.viewBack?.backgroundColor = tagBackColor
        return cell
    }
    
}
extension TagsView:UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let label = UILabel(frame: CGRect.zero)
        label.text = arryTags?[indexPath.item]
        label.sizeToFit()
        
        if btnCroosStatus != true{
        return CGSize(width: label.frame.width + 65, height: 25)
        }
        else{
            print(label.frame.width)
            return CGSize(width: label.frame.width - 18, height: 25)
        
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt: Int) -> CGFloat {
        return 0.5
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 2, left: 1, bottom: 2, right: 2)
    }
}

class TagCell: UICollectionViewCell {
    var viewBack : UIView?
    var btnCross : UIButton?
    var labedisp : UILabel?
    override init(frame: CGRect) {
        super.init(frame: frame)
        SetupUI()
    }
    func Initilization() {
        viewBack = UIView()
        viewBack?.backgroundColor = .red
        labedisp = UILabel()
        labedisp?.textColor = .gray
        labedisp?.text = "sdfsdfsdfsdfs"
        btnCross = UIButton()
    }
    
    func SetupUI() {
        Initilization()
        addSubview(viewBack!)
        viewBack?.anchor(top: contentView.topAnchor, leading: contentView.leadingAnchor, bottom: contentView.bottomAnchor, trailing: contentView.trailingAnchor,padding: .init(top: 1, left: 1, bottom: 1, right: 1))
        btnCross?.constraintsWidth(width: 18)
        let stackItems = UIStackView(views: [labedisp!,btnCross!], axis: .horizontal, spacing: 2, distribution: .fill)
        viewBack?.addSubview(stackItems)
        stackItems.fillSuperView(padding: .init(top: 1, left: 0.5, bottom: 1, right: 3))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
func secondsToHoursMinutesSeconds (seconds : Int) -> (Int, Int, Int) {
    return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
}

