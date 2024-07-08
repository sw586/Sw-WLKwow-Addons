--[[
Name: LibBabble-Faction-3.0
Revision: $Rev: 112 $
Maintainers: ckknight, nevcairiel, Ackis
Website: http://www.wowace.com/projects/libbabble-faction-3-0/
Dependencies: None
License: MIT
]]

local MAJOR_VERSION = "LibBabble-Faction-3.0"
local MINOR_VERSION = 90000 + tonumber(("$Rev: 112 $"):match("%d+"))

if not LibStub then error(MAJOR_VERSION .. " requires LibStub.") end
local lib = LibStub("LibBabble-3.0"):New(MAJOR_VERSION, MINOR_VERSION)
if not lib then return end

local GAME_LOCALE = GetLocale()

lib:SetBaseTranslations {
	Alliance = "Alliance",
	["Alliance Vanguard"] = "Alliance Vanguard",
	["Argent Crusade"] = "Argent Crusade",
	["Argent Dawn"] = "Argent Dawn",
	["Ashtongue Deathsworn"] = "Ashtongue Deathsworn",
	["Bloodsail Buccaneers"] = "Bloodsail Buccaneers",
	["Booty Bay"] = "Booty Bay",
	["Brood of Nozdormu"] = "Brood of Nozdormu",
	["Cenarion Circle"] = "Cenarion Circle",
	["Cenarion Expedition"] = "Cenarion Expedition",
	["Darkmoon Faire"] = "Darkmoon Faire",
	["Darkspear Trolls"] = "Darkspear Trolls",
	Darnassus = "Darnassus",
	Everlook = "Everlook",
	Exalted = "Exalted",
	Exodar = "Exodar",
	["Explorers' League"] = "Explorers' League",
	["Frenzyheart Tribe"] = "Frenzyheart Tribe",
	Friendly = "Friendly",
	["Frostwolf Clan"] = "Frostwolf Clan",
	Gadgetzan = "Gadgetzan",
	["Gelkis Clan Centaur"] = "Gelkis Clan Centaur",
	["Gnomeregan Exiles"] = "Gnomeregan Exiles",
	Honored = "Honored",
	["Honor Hold"] = "Honor Hold",
	Horde = "Horde",
	["Horde Expedition"] = "Horde Expedition",
	["Hydraxian Waterlords"] = "Hydraxian Waterlords",
	Ironforge = "Ironforge",
	["Keepers of Time"] = "Keepers of Time",
	["Kirin Tor"] = "Kirin Tor",
	["Knights of the Ebon Blade"] = "Knights of the Ebon Blade",
	Kurenai = "Kurenai",
	["Lower City"] = "Lower City",
	["Magram Clan Centaur"] = "Magram Clan Centaur",
	Netherwing = "Netherwing",
	Neutral = "Neutral",
	["Ogri'la"] = "Ogri'la",
	Orgrimmar = "Orgrimmar",
	Ratchet = "Ratchet",
	Ravenholdt = "Ravenholdt",
	Revered = "Revered",
	["Sha'tari Skyguard"] = "Sha'tari Skyguard",
	["Shattered Sun Offensive"] = "Shattered Sun Offensive",
	["Shen'dralar"] = "Shen'dralar",
	["Silvermoon City"] = "Silvermoon City",
	["Silverwing Sentinels"] = "Silverwing Sentinels",
	Sporeggar = "Sporeggar",
	["Stormpike Guard"] = "Stormpike Guard",
	Stormwind = "Stormwind",
	Syndicate = "Syndicate",
	["The Aldor"] = "The Aldor",
	["The Ashen Verdict"] = "The Ashen Verdict",
	["The Consortium"] = "The Consortium",
	["The Defilers"] = "The Defilers",
	["The Frostborn"] = "The Frostborn",
	["The Hand of Vengeance"] = "The Hand of Vengeance",
	["The Kalu'ak"] = "The Kalu'ak",
	["The League of Arathor"] = "The League of Arathor",
	["The Mag'har"] = "The Mag'har",
	["The Oracles"] = "The Oracles",
	["The Scale of the Sands"] = "The Scale of the Sands",
	["The Scryers"] = "The Scryers",
	["The Sha'tar"] = "The Sha'tar",
	["The Silver Covenant"] = "The Silver Covenant",
	["The Sons of Hodir"] = "The Sons of Hodir",
	["The Sunreavers"] = "The Sunreavers",
	["The Taunka"] = "The Taunka",
	["The Violet Eye"] = "The Violet Eye",
	["The Wyrmrest Accord"] = "The Wyrmrest Accord",
	["Thorium Brotherhood"] = "Thorium Brotherhood",
	Thrallmar = "Thrallmar",
	["Thunder Bluff"] = "Thunder Bluff",
	["Timbermaw Hold"] = "Timbermaw Hold",
	Tranquillien = "Tranquillien",
	Undercity = "Undercity",
	["Valiance Expedition"] = "Valiance Expedition",
	["Warsong Offensive"] = "Warsong Offensive",
	["Warsong Outriders"] = "Warsong Outriders",
	["Wildhammer Clan"] = "Wildhammer Clan",
	["Winterfin Retreat"] = "Winterfin Retreat",
	["Wintersaber Trainers"] = "Wintersaber Trainers",
	["Zandalar Tribe"] = "Zandalar Tribe",
}


if GAME_LOCALE == "enUS" then
	lib:SetCurrentTranslations(true)
elseif GAME_LOCALE == "zhCN" then
	lib:SetCurrentTranslations {
	Alliance = "联盟",
	["Alliance Vanguard"] = "联盟先遣军",
	["Argent Crusade"] = "银色北伐军",
	["Argent Dawn"] = "银色黎明",
	["Ashtongue Deathsworn"] = "灰舌死誓者",
	["Bloodsail Buccaneers"] = "血帆海盗",
	["Booty Bay"] = "藏宝海湾",
	["Brood of Nozdormu"] = "诺兹多姆的子嗣",
	["Cenarion Circle"] = "塞纳里奥议会",
	["Cenarion Expedition"] = "塞纳里奥远征队",
	["Darkmoon Faire"] = "暗月马戏团",
	["Darkspear Trolls"] = "暗矛巨魔",
	Darnassus = "达纳苏斯",
	Everlook = "永望镇",
	Exalted = "崇拜",
	Exodar = "埃索达",
	["Explorers' League"] = "探险者协会",
	["Frenzyheart Tribe"] = "狂心氏族",
	Friendly = "友善",
	["Frostwolf Clan"] = "霜狼氏族",
	Gadgetzan = "加基森",
	["Gelkis Clan Centaur"] = "吉尔吉斯半人马",
	["Gnomeregan Exiles"] = "诺莫瑞根流亡者",
	Honored = "尊敬",
	["Honor Hold"] = "荣耀堡",
	Horde = "部落",
	["Horde Expedition"] = "部落先遣军",
	["Hydraxian Waterlords"] = "海达希亚水元素",
	Ironforge = "铁炉堡",
	["Keepers of Time"] = "时光守护者",
	["Kirin Tor"] = "肯瑞托",
	["Knights of the Ebon Blade"] = "黑锋骑士团",
	Kurenai = "库雷尼",
	["Lower City"] = "贫民窟",
	["Magram Clan Centaur"] = "玛格拉姆半人马",
	Netherwing = "灵翼之龙",
	Neutral = "中立",
	["Ogri'la"] = "奥格瑞拉",
	Orgrimmar = "奥格瑞玛",
	Ratchet = "棘齿城",
	Ravenholdt = "拉文霍德",
	Revered = "崇敬",
	["Sha'tari Skyguard"] = "沙塔尔天空卫士",
	["Shattered Sun Offensive"] = "破碎残阳",
	["Shen'dralar"] = "辛德拉",
	["Silvermoon City"] = "银月城",
	["Silverwing Sentinels"] = "银翼哨兵",
	Sporeggar = "孢子村",
	["Stormpike Guard"] = "雷矛卫队",
	Stormwind = "暴风城",
	Syndicate = "辛迪加",
	["The Aldor"] = "奥尔多",
	["The Ashen Verdict"] = "灰烬审判军",
	["The Consortium"] = "星界财团",
	["The Defilers"] = "污染者",
	["The Frostborn"] = "霜脉矮人",
	["The Hand of Vengeance"] = "复仇之手",
	["The Kalu'ak"] = "卡鲁亚克",
	["The League of Arathor"] = "阿拉索联军",
	["The Mag'har"] = "玛格汉",
	["The Oracles"] = "神谕者",
	["The Scale of the Sands"] = "流沙之鳞",
	["The Scryers"] = "占星者",
	["The Sha'tar"] = "沙塔尔",
	["The Silver Covenant"] = "银色盟约",
	["The Sons of Hodir"] = "霍迪尔之子",
	["The Sunreavers"] = "夺日者",
	["The Taunka"] = "牦牛人",
	["The Violet Eye"] = "紫罗兰之眼",
	["The Wyrmrest Accord"] = "龙眠联军",
	["Thorium Brotherhood"] = "瑟银兄弟会",
	Thrallmar = "萨尔玛",
	["Thunder Bluff"] = "雷霆崖",
	["Timbermaw Hold"] = "木喉要塞",
	Tranquillien = "塔奎林",
	Undercity = "幽暗城",
	["Valiance Expedition"] = "无畏远征军",
	["Warsong Offensive"] = "战歌远征军",
	["Warsong Outriders"] = "战歌侦察骑兵",
	["Wildhammer Clan"] = "蛮锤部族",
	["Winterfin Retreat"] = "冬鳞避难所",
	["Wintersaber Trainers"] = "冬刃豹训练师",
	["Zandalar Tribe"] = "赞达拉部族",
}
elseif GAME_LOCALE == "zhTW" then
	lib:SetCurrentTranslations {
	Alliance = "聯盟",
	["Alliance Vanguard"] = "聯盟先鋒",
	["Argent Crusade"] = "銀白十字軍",
	["Argent Dawn"] = "銀色黎明",
	["Ashtongue Deathsworn"] = "灰舌死亡誓言者",
	["Bloodsail Buccaneers"] = "血帆海盜",
	["Booty Bay"] = "藏寶海灣",
	["Brood of Nozdormu"] = "諾茲多姆的子嗣",
	["Cenarion Circle"] = "塞納里奧議會",
	["Cenarion Expedition"] = "塞納里奧遠征隊",
	["Darkmoon Faire"] = "暗月馬戲團",
	["Darkspear Trolls"] = "暗矛食人妖",
	Darnassus = "達納蘇斯",
	Everlook = "永望鎮",
	Exalted = "崇拜",
	Exodar = "艾克索達",
	["Explorers' League"] = "探險者協會",
	["Frenzyheart Tribe"] = "狂心部族",
	Friendly = "友好",
	["Frostwolf Clan"] = "霜狼氏族",
	Gadgetzan = "加基森",
	["Gelkis Clan Centaur"] = "吉爾吉斯半人馬",
	["Gnomeregan Exiles"] = "諾姆瑞根流亡者",
	Honored = "尊敬",
	["Honor Hold"] = "榮譽堡",
	Horde = "部落",
	["Horde Expedition"] = "部落遠征軍",
	["Hydraxian Waterlords"] = "海達希亞水元素",
	Ironforge = "鐵爐堡",
	["Keepers of Time"] = "時光守望者",
	["Kirin Tor"] = "祈倫托",
	["Knights of the Ebon Blade"] = "黯刃騎士團",
	Kurenai = "卡爾奈",
	["Lower City"] = "陰鬱城",
	["Magram Clan Centaur"] = "瑪格拉姆半人馬",
	Netherwing = "虛空之翼",
	Neutral = "中立",
	["Ogri'la"] = "歐格利拉",
	Orgrimmar = "奧格瑪",
	Ratchet = "棘齒城",
	Ravenholdt = "拉文霍德",
	Revered = "崇敬",
	["Sha'tari Skyguard"] = "薩塔禦天者",
	["Shattered Sun Offensive"] = "破碎之日進攻部隊",
	["Shen'dralar"] = "辛德拉",
	["Silvermoon City"] = "銀月城",
	["Silverwing Sentinels"] = "銀翼哨兵",
	Sporeggar = "斯博格爾",
	["Stormpike Guard"] = "雷矛衛隊",
	Stormwind = "暴風城",
	Syndicate = "辛迪加",
	["The Aldor"] = "奧多爾",
	["The Ashen Verdict"] = "灰燼裁決軍",
	["The Consortium"] = "聯合團",
	["The Defilers"] = "污染者",
	["The Frostborn"] = "霜誕矮人",
	["The Hand of Vengeance"] = "復仇之手",
	["The Kalu'ak"] = "卡魯耶克",
	["The League of Arathor"] = "阿拉索聯軍",
	["The Mag'har"] = "瑪格哈",
	["The Oracles"] = "神諭者",
	["The Scale of the Sands"] = "流沙之鱗",
	["The Scryers"] = "占卜者",
	["The Sha'tar"] = "薩塔",
	["The Silver Covenant"] = "白銀誓盟",
	["The Sons of Hodir"] = "霍迪爾之子",
	["The Sunreavers"] = "奪日者",
	["The Taunka"] = "坦卡族",
	["The Violet Eye"] = "紫羅蘭之眼",
	["The Wyrmrest Accord"] = "龍眠協調者",
	["Thorium Brotherhood"] = "瑟銀兄弟會",
	Thrallmar = "索爾瑪",
	["Thunder Bluff"] = "雷霆崖",
	["Timbermaw Hold"] = "木喉要塞",
	Tranquillien = "安寧地",
	Undercity = "幽暗城",
	["Valiance Expedition"] = "驍勇遠征隊",
	["Warsong Offensive"] = "戰歌進攻部隊",
	["Warsong Outriders"] = "戰歌偵察騎兵",
	["Wildhammer Clan"] = "蠻錘氏族",
	["Winterfin Retreat"] = "冬鰭避居地",
	["Wintersaber Trainers"] = "冬刃豹訓練師",
	["Zandalar Tribe"] = "贊達拉部族",
}

else
	error(("%s: Locale %q not supported"):format(MAJOR_VERSION, GAME_LOCALE))
end
