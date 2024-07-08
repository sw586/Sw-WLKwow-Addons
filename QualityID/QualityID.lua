--######################
-- Interface: 30000
-- Title: QualityID
-- Notes: Displays an items basic info in the color of the item's quality, in the tooltip.
-- License: GNUv2GPL
-- Author: Anaral
-- Version: 3.05
--#######################

QualityID = {}
QIDDB = {
enabled = true;
showid = true;
showitemLvl = true;
showStackCount = true;
showIcon = true;
showType = true;
}

QIDDB.enabled	= true
QIDDB.showid = true
QIDDB.showitemLvl = true
QIDDB.showStackCount = true
QIDDB.showIcon = true
QIDDB.showitemType = true
QIDDB.QualityIDVersion = "3.05"

--For testing if version is doubling info, if it shows twice, then we are sad pandas.
--DEFAULT_CHAT_FRAME:AddMessage("|cff00dd88" .. "QualityID: v"..QIDDB.QualityIDVersion.." enabled!")

function QualityID:CheckSavedVars()
	if (not (QIDDB)) then DEFAULT_CHAT_FRAME:AddMessage("Setting up QIDDB.") end
	if (not (QIDDB)) then QIDDB = {} end
	if (not (QIDDB.enabled))	then QIDDB.enabled = self.enabled	end
	if (not (QIDDB.showId)) then QIDDB.showId = self.showId end
	if (not (QIDDB.showitemLvl)) then QIDDB.showitemLvl = self.showitemLvl end
	if (not (QIDDB.showStackCount)) then QIDDB.showStackCount = self.showStackCount end
	if (not (QIDDB.showIcon)) then QIDDB.showIcon = self.showIcon end
	if (not (QIDDB.showitemType)) then QIDDB.showitemType = self.showitemType end
end

function QualityID:VARIABLES_LOADED()
	QualityID:CheckSavedVars()
end

function chat(text)
	if(type(text) == "boolean") then
        if(text) then
            text = "True";
        else
            text = "False";
        end
    end
	if(text ~= nil) then
		DEFAULT_CHAT_FRAME:AddMessage("|cff00dd88" .. text .. "|r");
	end
end

SLASH_QUALITYID1 = "/qualityid"
SLASH_QUALITYID2 = "/qid"
--	SlashCmdList["SLASHCMD"] = function (msg, editBox) end;  <--- blizz function for 3.0
SlashCmdList["QUALITYID"] = function(msg)
	QualityID_SlashCommandHandler(msg);
end
--slashcommand functions
function QualityID_SlashCommandHandler(msg)
    if(msg ~= "") then
        chat("QualityID: " .. msg .. " 是否显示已切换.");
    end
    if(msg:lower() == "切换") then
        QIDDB.enabled = not QIDDB.enabled;
    elseif(msg:lower() == "打开") then
        QIDDB.enabled = true;
    elseif(msg:lower() == "关闭") then
        QIDDB.enabled = false;
	elseif(msg:lower() == "编号") then
		QIDDB.showid = not QIDDB.showid;
	elseif(msg:lower() == "等级") then
		QIDDB.showitemLvl = not QIDDB.showitemLvl;	
	elseif(msg:lower() == "堆叠") then
		QIDDB.showStackCount = not QIDDB.showStackCount;
	elseif(msg:lower() == "类型") then
		QIDDB.showitemType = not QIDDB.showitemType;
	elseif(msg:lower() == "图标") then
		QIDDB.showIcon = not QIDDB.showIcon;
	elseif(msg == "") then
               chat("QualityID 设置:  /qid <切换 | 打开 | 关闭>");
		chat("/qid 编号 <切换是否显示物品编号> ");
		chat("/qid 等级 <切换是否显示物品等级> ");
		chat("/qid 堆叠 <切换是否显示堆叠数量>");
		chat("/qid 类型 <切换是否显示物品类型>");
		chat("/qid 图标 <切换是否显示物品图标>");
    end
end

local origs = {}
local origs2 = {}
--adds id, ilvl, stkct, and type
local function OnTooltipSetItem(frame, ...)
	local name, link = frame:GetItem()
	if QIDDB.enabled and link then
		local _, _, id, id2 = strfind(link, "item:(%d+).+:(.+:.+)%[")
		--While not all returns will be called, all are listed for personal reference.
		local name,link,quality,ilvl,reqLevel,type,subType,stackCount = GetItemInfo(id)
		--text that you see in the tooltip
		frame:AddLine(" ")
		if quality then
			if id and QIDDB.showid then
				frame:AddLine( "物品编号："..ITEM_QUALITY_COLORS[quality].hex..id)
			end
			if ilvl and QIDDB.showitemLvl then
				frame:AddLine( "物品等级："..ITEM_QUALITY_COLORS[quality].hex..ilvl)
			end
			if subType and QIDDB.showitemType then
				frame:AddLine( ""..type.."："..ITEM_QUALITY_COLORS[quality].hex..subType)
			end
			if stackCount and QIDDB.showStackCount and stackCount > 2 then
				frame:AddLine( "堆叠数量："..ITEM_QUALITY_COLORS[quality].hex..stackCount)
			end
		end
		frame:AddLine("")
	end
	if origs[frame] then
		return origs[frame](frame, ...)
	end
end
local function OnTooltipSetSpell(frame, ...)
	local name,_ = frame:GetSpell()
	s=GetSpellLink(name)
	if s then
		local _,_,id = s:find("|c%x%x%x%x%x%x%x%x|Hspell:(%d+)|h")
		if id then
			frame:AddLine(" ")
			if id and QIDDB.showid then
				frame:AddLine( "技能编号："..id)
			end
			frame:AddLine("")
		end
		if origs2[frame] then
			return origs2[frame](frame, ...)
		end
	end
end

--Add item icon to the tooltip.
local function hookTip(frame, ...)
	local _G = getfenv(0)
	local set = frame:GetScript('OnTooltipSetItem')
	frame:SetScript('OnTooltipSetItem', function(self, ...)
		local link = select(2, self:GetItem())
		if  link and GetItemInfo(link) then
			local text = _G[self:GetName() .. 'TextLeft1']
			--显示物品图标
			--make sure the icon does not display twice on recipies, which fire OnTooltipSetItem twice
			icon = GetItemIcon(link)
--			icon=icon or "Interface\icons\INV_Misc_QuestionMark"
			if QIDDB.showIcon and text and text:GetText():sub(1, 2) ~= '|T' and icon then 
				text:SetFormattedText('|T%s:%d|t%s', icon, 36, text:GetText())
				self:AddLine("图标："..icon)
			end
		end
		if set then
			return set(self, ...)
		end
	end)
	local set = frame:GetScript('OnTooltipSetSpell')
	frame:SetScript('OnTooltipSetSpell', function(self, ...)
		local name = self:GetSpell()
		if name then
			local text = _G[self:GetName() .. 'TextLeft1']
			--显示图标
			_,_,icon = GetSpellInfo(name)
--			icon=icon or "Interface\icons\INV_Misc_QuestionMark"
			if QIDDB.showIcon and text and text:GetText():sub(1, 2) ~= '|T' and icon then 
				text:SetFormattedText('|T%s:%d|t%s', icon, 36, text:GetText())
				self:AddLine("图标："..icon)
			end
		end
		if set then
			return set(self, ...)
		end
	end)
end
hookTip(GameTooltip)
hookTip(ItemRefTooltip)
hookTip(ShoppingTooltip1)
hookTip(ShoppingTooltip2)

for _,frame in pairs{GameTooltip, ItemRefTooltip, ShoppingTooltip1, ShoppingTooltip2} do
	origs[frame] = frame:GetScript("OnTooltipSetItem")
	frame:SetScript("OnTooltipSetItem", OnTooltipSetItem)
	origs2[frame] = frame:GetScript("OnTooltipSetSpell")
	frame:SetScript("OnTooltipSetSpell", OnTooltipSetSpell)
end


--Run once when first loaded.
	QID = CreateFrame("Frame", "QID")
	QID:RegisterEvent("VARIABLES_LOADED")
	QID:SetScript("OnEvent", function(self, event, ...) QualityID[event](QualityID, event, ...) end)
	
	DEFAULT_CHAT_FRAME:AddMessage("|cff00dd88" .. "QualityID: v"..QIDDB.QualityIDVersion.." 成功载入！汉化作者：默若朝阳 六区桑德兰<榮耀>");