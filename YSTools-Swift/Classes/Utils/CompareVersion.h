//
//  CompareVersion.h
//  YSTools-Swift
//
//  Created by Joseph Koh on 2019/8/30.
//  Copyright © 2019 Joseph Koh. All rights reserved.
//

#ifndef CompareVersion_h
#define CompareVersion_h

#include <stdio.h>

/// 版本号比较
/// 如果版本号一样，返回 0；
/// 如果v1 大于 v2，返回 1；
/// 如果 v1 小于 v2，返回 -1 ；
/// @param v1 第一个版本号
/// @param v2 第二个版本号
int compareVersion(const char *v1, const char *v2);

#endif /* CompareVersion_h */
