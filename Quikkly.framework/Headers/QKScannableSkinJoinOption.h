//
//  QKScannableSkinJoinOption.h
//  Quikkly
//
//  Created by Julian Gruber on 08/05/2017.
//  Copyright © 2017 Quikkly Ltd. All rights reserved.
//

typedef NS_OPTIONS(NSInteger, QKScannableSkinJoinOption) {
    QKScannableSkinJoinOptionTemplateDefault    = -1,
    QKScannableSkinJoinOptionNone               = 0,
    QKScannableSkinJoinOptionHorizontal         = 1,
    QKScannableSkinJoinOptionVertical           = 2,
    QKScannableSkinJoinOptionDiagonalRight      = 4,
    QKScannableSkinJoinOptionDiagonalLeft       = 8
};
