//
//  File.swift
//  
//
//  Created by atakishiyev on 11/4/23.
//

import Foundation

public protocol Mapper {
    associatedtype Entity
    associatedtype Dto
    
    func mapEntityConvertToDto(input: Entity) -> Dto
    func mapDtoConvertToEntity(input: Dto) -> Entity
}

public extension Mapper {
    func mapEntitiesConvertToDto(input: [Entity]) -> [Dto] {
        return input.map { mapEntityConvertToDto(input: $0) }
    }
    
    func mapDtoConvertToEntities(input: [Dto]) -> [Entity] {
        return input.map { mapDtoConvertToEntity(input: $0) }
    }
}
