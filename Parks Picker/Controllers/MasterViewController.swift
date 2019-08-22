//
//  MasterViewController.swift
//  Parks Picker
//
//  Created by Vasilii on 20/08/2019.
//  Copyright © 2019 Vasilii Burenkov. All rights reserved.
//

import UIKit

class MasterViewController: UICollectionViewController {
    
    
    @IBOutlet weak var addButton: UIBarButtonItem!
    
    fileprivate var parkDataSource = ParksDataSource()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 3 cells in a row
        let width = collectionView.frame.width / 3
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: width, height: width)
        layout.sectionHeadersPinToVisibleBounds = true //прикрепляем заголовок к верхy
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshDidFire), for: .valueChanged)
        collectionView.refreshControl = refreshControl
        
        navigationItem.leftBarButtonItem = editButtonItem //создаем кнопку для редактирования
        navigationController?.isToolbarHidden = true // скрыаем тулбар
        
        installsStandardGestureForInteractiveMovement = true //чтобы перемещать ячейки
    }
    //добавляем новые пакри когда тяним вниз
    @objc func refreshDidFire() {
        if !isEditing {
        addButtonTapped(nil)
        }
        collectionView.refreshControl?.endRefreshing()
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        
        addButton.isEnabled = !editing
        collectionView.allowsMultipleSelection = editing // если находимся в режим редактирования можно выделить несколько ячеек
        let indexPaths = collectionView.indexPathsForVisibleItems // здесь получаем массив видимых ячеек
        for indexPath in indexPaths {
            collectionView.deselectItem(at: indexPath, animated: false)
            let cell = collectionView.cellForItem(at: indexPath) as? ParkCell
            cell?.editing = editing
        }
        //когда не в режиме редактирования прячим тулбар
        if !editing {
            navigationController?.setToolbarHidden(true, animated: animated)
        }
    }
    
// добавляем новые парки
    @IBAction func addButtonTapped(_ sender: UIBarButtonItem?) {
        let indexPath = parkDataSource.indexPathForNewRandomPark()
        
        let layout = collectionViewLayout as! ParkViewFlowLayout
        layout.appearingIndexPath = indexPath
        
        UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 0.65, initialSpringVelocity: 0, options: [], animations: {
            self.collectionView.insertItems(at: [indexPath])
        }, completion: {
            (finished) in layout.appearingIndexPath = nil
        })
    }
    @IBAction func deletButtonTapped(_ sender: Any) {
    
        let indexPaths = collectionView.indexPathsForSelectedItems!
        parkDataSource.deleteItemsAtIndexPaths(indexPaths)
        
        let layout = collectionViewLayout as! ParkViewFlowLayout
        layout.disappiringIndexPaths = indexPaths
        
        UIView.animate(withDuration: 0.7, delay: 0, options: [], animations: {
            self.collectionView.deleteItems(at: indexPaths)
        }) { (finished) in
            layout.disappiringIndexPaths = nil
            self.navigationController?.setToolbarHidden(true, animated: true)
        }
        
        //collectionView.deleteItems(at: indexPaths)
        
        
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MasterToDetail" {
           let detailViewController = segue.destination as! DetailViewController
                    detailViewController.park = sender as? Park
        }
    }
    

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return parkDataSource.numberOfSections
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return parkDataSource.numberOfParksInSection(section)
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! ParkCell
        
        if let park = parkDataSource.parkForItemAtIndexPath(indexPath) {
            cell.park = park
            cell.editing = isEditing // передаем информацию о режиме редактирования
        }
    
        return cell
    }
    //описываем заголовок для дополнительного элемента (хедера)
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let sectionHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "SectionHeader", for: indexPath) as! SectionHeaderView
        if let title = parkDataSource.titleForSectionAtIndexPath(indexPath) {
            sectionHeaderView.title = title
        }
        return sectionHeaderView
    }

    // MARK: UICollectionViewDelegate
    
    // срабатывает, когда пользователь нажмет по ячейке
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let natioanlPark = parkDataSource.parkForItemAtIndexPath(indexPath) {
            if !isEditing { // если не режим редактирования, делаем переход
            
            performSegue(withIdentifier: "MasterToDetail", sender: natioanlPark)
            } else { // показываем тулбар
                navigationController?.setToolbarHidden(false, animated: true)
            }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if isEditing { //если нет помеченых ячеек
            if collectionView.indexPathsForSelectedItems?.count == 0 {
                navigationController?.setToolbarHidden(true, animated: true)
            }
        }
    }
    // для перемещения ячеек
    
    

    override func collectionView(_ collectionView: UICollectionView, moveItemAt sourceindexPath: IndexPath, to destinationIndexPath: IndexPath) {
        parkDataSource.moveParkAtIndexPath(sourceindexPath, toIndexPath: destinationIndexPath)
    }

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
