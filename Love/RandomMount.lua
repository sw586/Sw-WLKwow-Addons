﻿------------------------------------------------------------------------------
-- 文件名: RandomMount.lua
-- 日期: 2011-02-17
-- 作者: dugu@wowbox
-- 描述: 智能随机选择飞行和骑乘坐骑
-- 版权所有: duowan.com
-- 感谢: AMountGo
------------------------------------------------------------------------------

local RandomMount = LibStub("AceAddon-3.0"):NewAddon("RandomMount", "AceEvent-3.0", "AceConsole-3.0", "AceTimer-3.0");
local L = LibStub("AceLocale-3.0"):GetLocale("Love");
local RM = RandomMount;

-----------
-- 坐骑数据 from AmountGo
local MountData = {
	flying = {
		-- 310
		[1] = {
			[49193]=true,
			[60024]=true,
			[71810]=true,
			[37015]=true,
			[63963]=true,
			[67336]=true,
			[40192]=true,
			[59976]=true,
			[72808]=true,
			[58615]=true,
			[64927]=true,
			[65439]=true,
			[72807]=true,
			[63956]=true,
			[44744]=true,
			[63796]=true,
			[69395]=true,
			[32345]=true,
			[60021]=true,
		},
		-- 280
		[2] = {
			[32296]=true,
			[60002]=true,
			[44151]=true,
			[59571]=true,
			[41517]=true,
			[41518]=true,
			[54729]=true,
			[46199]=true,
			[32246]=true,
			[32289]=true,
			[32297]=true,
			[32292]=true,
			[32295]=true,
			[32290]=true,
			[32242]=true,
			[66088]=true,
			[39802]=true,
			[66087]=true,
			[39800]=true,
			[59961]=true,
			[60025]=true,
			[63844]=true,
			[61230]=true,
			[61229]=true,
			[59567]=true,
			[41514]=true,
			[71342]=true,
			[59650]=true,
			[61996]=true,
			[59568]=true,
			[59996]=true,
			[39803]=true,
			[59569]=true,
			[43927]=true,
			[41515]=true,
			[61294]=true,
			[39798]=true,
			[48025]=true,
			[61309]=true,
			[41513]=true,
			[41516]=true,
			[39801]=true,
			[61997]=true,
			[59570]=true,
			[72286]=true,
		},
		-- 150
		[3] = {
			[32243]=true,
			[46197]=true,
			[32240]=true,
			[32244]=true,
			[32239]=true,
			[61451]=true,
			[44153]=true,
			[32235]=true,
			[32245]=true,
		},
	},
	ground = {
		-- 100
		[1] = {
			[42777]=true,
			[23338]=true,
			[23251]=true,
			[65643]=true,
			[35028]=true,
			[46628]=true,
			[23223]=true,
			[23240]=true,
			[23228]=true,
			[23222]=true,
			[49322]=true,
			[24252]=true,
			[39318]=true,
			[34899]=true,
			[18992]=true,
			[63641]=true,
			[61425]=true,
			[61447]=true,
			[65642]=true,
			[64659]=true,
			[15779]=true,
			[54753]=true,
			[39319]=true,
			[65645]=true,
			[16083]=true,
			[34897]=true,
			[54729]=true,
			[16081]=true,
			[17229]=true,
			[59791]=true,
			[26055]=true,
			[59793]=true,
			[65639]=true,
			[24242]=true,
			[65644]=true,
			[35027]=true,
			[33660]=true,
			[23227]=true,
			[23243]=true,
			[23242]=true,
			[65638]=true,
			[23219]=true,
			[68056]=true,
			[23225]=true,
			[35025]=true,
			[35025]=true,
			[23252]=true,
			[65640]=true,
			[23239]=true,
			[23221]=true,
			[65646]=true,
			[23250]=true,
			[23229]=true,
			[23238]=true,
			[43900]=true,
			[23241]=true,
			[68057]=true,
			[66091]=true,
			[63232]=true,
			[23510]=true,
			[63642]=true,
			[34898]=true,
			[39317]=true,
			[16080]=true,
			[22722]=true,
			[26054]=true,
			[43688]=true,
			[16056]=true,
			[66906]=true,
			[67466]=true,
			[60114]=true,
			[60116]=true,
			[51412]=true,
			[58983]=true,
			[22719]=true,
			[16055]=true,
			[26656]=true,
			[17461]=true,
			[60118]=true,
			[60119]=true,
			[48027]=true,
			[22718]=true,
			[59785]=true,
			[59788]=true,
			[22720]=true,
			[22721]=true,
			[22717]=true,
			[22723]=true,
			[22724]=true,
			[25953]=true,
			[64656]=true,
			[39315]=true,
			[34896]=true,
			[68188]=true,
			[68187]=true,
			[39316]=true,
			[34790]=true,
			[63635]=true,
			[63637]=true,
			[63639]=true,
			[36702]=true,
			[63643]=true,
			[17460]=true,
			[23509]=true,
			[63638]=true,
			[61465]=true,
			[61467]=true,
			[61469]=true,
			[61470]=true,
			[35713]=true,
			[49379]=true,
			[23249]=true,
			[65641]=true,
			[23248]=true,
			[35712]=true,
			[35714]=true,
			[65637]=true,
			[23247]=true,
			[18991]=true,
			[26056]=true,
			[17465]=true,
			[48025]=true,
			[59797]=true,
			[59799]=true,
			[17459]=true,
			[63636]=true,
			[17450]=true,
			[55531]=true,
			[60424]=true,
			[16084]=true,
			[66846]=true,
			[63640]=true,
			[16082]=true,
			[23246]=true,
			[23161]=true,
			[66090]=true,
			[41252]=true,
			[34767]=true,
			[23214]=true,
			[72286]=true,
			[48778]=true,
			[17481]=true,
		},	
		-- 60
		[2] = {
			[580]=true,
			[10796]=true,
			[17454]=true,
			[10799]=true,
			[64657]=true,
			[6898]=true,
			[10793]=true,
			[8394]=true,
			[66847]=true,
			[10789]=true,
			[42776]=true,
			[64731]=true,
			[17462]=true,
			[66907]=true,
			[35022]=true,
			[64977]=true,
			[470]=true,
			[64658]=true,
			[35020]=true,
			[10969]=true,
			[17463]=true,
			[50869]=true,
			[43899]=true,
			[34406]=true,
			[458]=true,
			[18990]=true,
			[6899]=true,
			[17464]=true,
			[6654]=true,
			[6648]=true,
			[6653]=true,
			[8395]=true,
			[35710]=true,
			[18989]=true,
			[6777]=true,
			[17453]=true,
			[472]=true,
			[35711]=true,
			[35018]=true,
			[30174]=true,-- (0%)
			[65917]=true,--  (0%)
			[5784]=true,
			[34769]=true,
			[13819]=true,
			[34795]=true,
		},		
	},
	-- 安其拉
	aq40 = {		
		{
			
			[25953]=true,--蓝色其拉作战坦克
			[26056]=true,--绿色其拉作战坦克
			[26054]=true,--红色其拉作战坦克
			[26055]=true,--黄色其拉作战坦克
			
		},
	},
};

function RM:OnInitialize()
	-- 初始化特殊地区信息
	self.badZones = {[L["Dalaran"]]=true, [L["Wintergrasp"]]=true};
	self.subExceptions = {[L["Krasus\' Landing"]]=true, [L["Purple Parlor"]]=true, [L["Underbelly"]]=true};
	self.data = {flying = {}, ground = {}, aq40 = {}};
	self.playerMounts = {};
	self:RegisterChatCommand("RandomMount", "CallMount");
end

function RM:OnEnable()
	self:BuildMountData();
	self:ScheduleTimer("BuildMountData", 5);
	self:RegisterEvent("COMPANION_LEARNED", "OnLearndCompanion");
	dwSecureCall(function()
		self:RefreshMacro();
	end);
end

function RM:OnDisable()
	self:UnregisterEvent("COMPANION_LEARNED");
end

function RM:BuildMountData()
	self.data = {flying = {}, ground = {}, aq40 = {}};
	self.playerMounts = {};
	local numPlayerMount = GetNumCompanions("MOUNT");
	local spellID;
	-- 生成玩家已有的坐骑信息
	if (numPlayerMount < 1) then return end

	for i=1, numPlayerMount  do
		spellID = select(3, GetCompanionInfo("MOUNT", i));
		self.playerMounts[spellID] = i;
	end
	
	local lastSpeed, lastType;
	for _type, v1 in pairs(MountData) do		
		if (_type ~= lastType) then lastType=nil;lastSpeed = nil end
		for speed, v2 in ipairs(v1) do
			if (lastSpeed and lastSpeed < speed) then
				break;
			else
				for spellID, _ in pairs(v2) do
					if (self.playerMounts[spellID]) then
						if ((not lastType or lastType == _type) and (not lastSpeed or lastSpeed == speed)) then							
							table.insert(self.data[_type], spellID);
						end
						lastType = _type;
						lastSpeed = speed;
					end
				end
			end
		end
	end	
end

function RM:CallMount()
	local index, mountID;
	if (IsMounted()) then
		Dismount();
		return;
	end
	
	if (self:IsFlyableArea() and self:HasFlying()) then		
		index = math.random(#(self.data.flying));
		mountID = self.playerMounts[self.data.flying[index]];
		CallCompanion("MOUNT", mountID);
		--print(GetSpellInfo(self.data.flying[index]));
	elseif (GetZoneText() == L["Ahn'Qiraj"] and self:HasAQ40()) then
		index = math.random(#(self.data.aq40));
		mountID = self.playerMounts[self.data.aq40[index]];
		CallCompanion("MOUNT", mountID);
	elseif (self:HasMount()) then
		index = math.random(#(self.data.ground));		
		mountID = self.playerMounts[self.data.ground[index]];
		CallCompanion("MOUNT", mountID);
		--print(GetSpellInfo(self.data.ground[index]));
	end
end

function RM:RefreshMacro()
	if (GetMacroIndexByName("RandomMount") > 0) then
		EditMacro("RandomMount", L["Mount"], 224, "/RandomMount");
		return;
	end	
	
	local macroIndex = GetMacroIndexByName(L["Mount"]);
	
	if (macroIndex == 0) then
		CreateMacro(L["Mount"], 224, "/RandomMount");
		if (LearningAid) then
			LearningAid:AddButton("MACRO", 1);
		end
	else
		EditMacro(L["Mount"], L["Mount"], 224, "/RandomMount");
	end	
end

function RM:OnLearndCompanion()
	self:BuildMountData();
end

function RM:HasFlying()
	if (#(self.data.flying) > 0) then
		return true;
	end
	
	return false;
end

function RM:HasMount()
	if (#(self.data.ground) > 0) then		
		return true;
	end

	return false;
end

function RM:HasAQ40()
	if (#(self.data.aq40) > 0) then
		return true;
	end

	return false;
end

function RM:IsFlyableArea()
	if ( self.badZones[GetRealZoneText()] and not self.subExceptions[GetSubZoneText()]) then
		if (GetWintergraspWaitTime() and GetRealZoneText() == L['Wintergrasp']) then
			return IsFlyableArea();
		end
		return false;
	else
		return IsFlyableArea();
	end
end