//
//  Fragment.swift
//  GraphiQL
//
//  Created by Felix Dietz on 07/04/16.
//  Copyright © 2016 WeltN24. All rights reserved.
//

import Foundation

public struct Fragment {
  public let alias: String
  public let name: String
  public let fields: [Field]
  
  public init(withAlias alias: String, name: String, fields: [Field]) {
    self.alias = alias.withoutWhiteSpaces
    self.name = name.withoutWhiteSpaces
    self.fields = fields
  }
}

extension Fragment: Field {
  public var asGraphQLField: String {
    return "...\(alias)"
  }
  
  public var asGraphQLString: String {
    return [
      "fragment",
      alias,
      "on",
      name,
      getFieldsString()].joinWithSeparator(" ")
  }
  
  private func getFieldsString() -> String {
    guard fields.count > 0 else {
      return ""
    }
    // TODO: Check for fix in Xcode 7.3
    return "{\(fields.map{$0.asGraphQLString}.joinWithSeparator(","))}"
  }
}