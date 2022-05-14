//
//  MainViewModel.swift
//  ClientApp
//
//  Created by Рамазан Юсупов on 7/11/21.
//

import Foundation

protocol MainViewModelType {
    var dishesInBasket: [OrderDTO] { get set }
    
    func getPopularDishes(completion: @escaping (Result<[FullCategoryDTO], Error>) -> Void)
    func getCategoriesDish(completion: @escaping (Result<[CategoryDTO], Error>) -> Void)
    func getBonuses(completion: @escaping(Result<Int, Error>) -> Void)
    func getDishesByCategory(categoryId: Int, completion: @escaping(Result<[DishDTO], Error>) -> Void)
}

class MainViewModel: MainViewModelType {
    var webApi: WebApiServiceType
    var basketManager: BasketManagerType
    
    var dishesInBasket: [OrderDTO] = [] {
        didSet {
            basketManager.dishes = dishesInBasket
        }
    }
    
    init(webApi: WebApiServiceType, basketManager: BasketManagerType ) {
        self.webApi = webApi
        self.basketManager = basketManager
    }
    
    func getPopularDishes(completion: @escaping (Result<[FullCategoryDTO], Error>) -> Void) {
        webApi.getPopularDishes(completion: completion)
    }
    
    func getCategoriesDish(completion: @escaping (Result<[CategoryDTO], Error>) -> Void) {
        webApi.getAllCategories(completion: completion)
    }
    
    func getBonuses(completion: @escaping(Result<Int, Error>) -> Void) {
        webApi.getBonuses(completion: completion)
    }
    
    func getDishesByCategory(categoryId: Int, completion: @escaping(Result<[DishDTO], Error>) -> Void) {
        webApi.getDishesBy(categoryId: categoryId, completion: completion)
    }
}
