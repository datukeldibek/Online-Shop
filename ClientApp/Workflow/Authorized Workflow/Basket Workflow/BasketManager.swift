//
//  BasketManager.swift
//  ClientApp
//
//  Created by Рамазан Юсупов on 2/12/21.
//

import Foundation

protocol OrderType {
    var dishId: Int { get }
    var dishName: String { get }
    var dishPrice: Double { get }
    var description: String { get }
    var quanitity: Int? { get set }
    var dishUrl: URL? { get }
    var sum: Double? { get }
}

protocol BasketManagerType {
    func addNewDish(_ dish: OrderType)
    func getDishes() -> [OrderType]
}

class BasketManager: BasketManagerType, Hashable {
    static func == (lhs: BasketManager, rhs: BasketManager) -> Bool {
        lhs.uuid == rhs.uuid
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(uuid)
    }
    
    private var uuid = UUID()
    private var authService: AuthServiceType
    private var webApi: WebApiServiceType
    private var dishesInCart: [OrderType] = []
    
    init(webApi: WebApiServiceType, authService: AuthServiceType) {
        self.webApi = webApi
        self.authService = authService
    }
    
    func addNewDish(_ dish: OrderType) {
        dishesInCart.append(dish)
        print("uuid of mainvc \(self.uuid)")
    }
    
    func getDishes() -> [OrderType] {
        return [
            DishDTO(description: "Брауни — американская шоколадная выпечка, довольно простая в приготовлении, как и многие другие американские рецепты.",
                    generalAdditionals: nil, id: 17,
                    imageUrl: URL(string: "https://daily-menu.ru/public/modules/dailymenu/dailymenurecipes/38977/67e2ebdde37b3662d1c672acaaf1f50d.jpg"),
                    name: "Брауни",
                    price: 320),
            DishDTO(description: "Капучи́но (от итал. cappuccino — капуцин) — кофейный напиток итальянской кухни на основе эспрессо с добавлением в него подогретого вспененного молока.",
                    generalAdditionals: nil,
                    id: 1,
                    imageUrl: URL(string: "https://i.obozrevatel.com/food/recipemain/2019/3/16/kapuchino.jpg?size=636x424"),
                    name: "Капучино",
                    price: 250)
        ]
    }
}

