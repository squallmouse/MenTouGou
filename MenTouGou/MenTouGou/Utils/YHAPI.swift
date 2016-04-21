//
//  YHAPI.swift
//  MenTouGou
//
//  Created by 袁昊 on 16/4/8.
//  Copyright © 2016年 squallmouse. All rights reserved.
//

import Foundation

let DEFAULTPIC      = ""//默认图
let PAGESIZE        = "10"


let MTG             = "http://mtg.ritontech.com"           //url

//主页
let GETADVERTLIST   = "/api/Mtg/GetAdvertList"//获取焦点图列表

let GETBANNERLIST   = "/api/Mtg/GetBannerList"//轮播图
let LEISURELIST     = "/api/Leisure/LeisureList"//休闲农业园区列表


//个人
let UPDATEUSER      = "/api/Account/UpdateUser/"//改变用户信息 GET

let FORGETPASSWORD  = "/api/Account/ForgetPassword"//找回密码 POST

let REGIEST         = "/api/Account/Register"//注册 POST
let LOGIN           = "/api/Account/Login/"//登录 GET
let USERINFO        = "/api/Account/UserInfo/"//获取用户信息 GET



//资讯
let NEWLIST         = "/api/Mtg/NewsList/"//获取资讯
let LEISURE         = "/api/Leisure/Leisure/"//获取详情



//周边
let NEARLEISURELIST = "/api/Leisure/NearLeisureList/"//获取周边


//农产品
let PRODUCTLIST     = "/api/Leisure/ProductList"//获取农产品列表
let PRODUCT         = "/api/Leisure/Product/"