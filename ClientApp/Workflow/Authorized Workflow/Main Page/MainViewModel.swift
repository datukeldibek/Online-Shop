//
//  MainViewModel.swift
//  ClientApp
//
//  Created by Рамазан Юсупов on 7/11/21.
//

import Foundation

protocol MainViewModelType {
    func getPopularDishes(completion: @escaping (Result<[FullCategoryDTO], Error>) -> Void)
    func getCategoriesDish(completion: @escaping (Result<[CategoryDTO], Error>) -> Void)
    func getBonuses(completion: @escaping(Result<Int, Error>) -> Void)
}

class MainViewModel: MainViewModelType {
    
    let authService: AuthServiceType = AuthService.shared
    let webApi: WebApiServiceType = WebApiService.shared
    
    func getPopularDishes(completion: @escaping (Result<[FullCategoryDTO], Error>) -> Void) {
        webApi.getPopularDishes(completion: completion)
    }
    
    func getCategoriesDish(completion: @escaping (Result<[CategoryDTO], Error>) -> Void) {
        webApi.getAllCategories(completion: completion)
    }
    
    func getBonuses(completion: @escaping(Result<Int, Error>) -> Void) {
        webApi.getBonuses(completion: completion)
    }
}
