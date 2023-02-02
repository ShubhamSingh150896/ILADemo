//
//  ViewController.swift
//  ILABankDemo
//
//  Created by Neosoft on 29/01/23.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Outlet Declaration
    @IBOutlet weak var listTableView: UITableView!
    
    // MARK: - Variables Declaration
    weak var searchBar: UISearchBar!
    
    // MARK: - ViewModel Declaration
    private var viewModel = ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupObserver()
    }
    
    // MARK: - Get Data
    func setupObserver(){
        viewModel.getLocalDataList(completion: { reload in
            if reload{
                self.reloadTableView()
            }
        })
    }
    
    //MARK: - Setup UI & Registering View
    func setupUI(){
        listTableView.register(UINib(nibName: Constants.table_Image_View_cell, bundle: nil), forCellReuseIdentifier: Constants.table_Image_View_cell)
        listTableView.register(UINib(nibName: Constants.table_View_cell, bundle: nil), forCellReuseIdentifier: Constants.table_View_cell)
        if #available(iOS 15.0, *) {
            listTableView.sectionHeaderTopPadding = 0
        }
    }
    
    func reloadTableView() {
        DispatchQueue.main.async {
            self.listTableView.reloadData()
        }
    }
}

//MARK: - UITableViewDelegate And Datasource
extension ViewController: UITableViewDataSource,UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 { return 1 }
        return self.viewModel.getListCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.table_Image_View_cell, for: indexPath) as? TableImageViewCell
            cell?.contentList = self.viewModel.getCarouselList()
            cell?.delegate = self
            return cell!
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.table_View_cell, for: indexPath) as? TableViewCell
            cell?.data = self.viewModel.getIndexModel(index: indexPath.row)
            return cell!
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 { return nil }
        if  let view = Bundle.main.loadNibNamed(Constants.search_View, owner: nil, options: nil)?.first as? SearchView{
            self.searchBar = view.searchBar
            view.searchBar.delegate = self
            return view
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 { return 0 }
        return 50
    }
    
}

//MARK: - UISearchBarDelegate
extension ViewController:UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.viewModel.searchList(searchText: searchText)
        if searchText == "" {
            viewModel.searchActive = false
            self.view.endEditing(true)
        } else if searchText.count >= 3 {
            viewModel.searchActive = true
            viewModel.searchList(searchText: searchText)
        }
        reloadTableView()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.viewModel.searchActive = false
        self.view.endEditing(true)
        reloadTableView()
    }
}

// Delegate Protocol callback function
extension ViewController: ImageCellDelegate{
    func suffleList(index: Int) {
        self.viewModel.searchActive = false
        self.viewModel.refreshData()
        reloadTableView()
        self.searchBar.text = ""
    }
}




