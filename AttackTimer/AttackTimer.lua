--==================================================
-- Attack Timer - ver 1.00
-- 日期: 2008年4月11日
-- 作者: 独孤傲雪
-- 描述: 显示你近战武器攻击的间隔时间, 该插件缺省只作为战士和圣騎士职业专用.
-- 版权所有: 艾泽拉斯国家地理
-- 鸣谢: AttackBar - 很抱歉我没找到他的作者, 非常感谢他提供的招架后攻击速度的公式.
--==================================================
local AE = {};
local L = {};
if (GetLocale() == "zhCN") then
	L["Attack"] = "攻击";
	L["Whirlwind"] = "旋风斩";
	L["Heroic Strike"] = "英勇打击";
	L["Raptor Strike"] = "猛禽一击";
elseif (GetLocale() =="zhTW") then
	L["Attack"] = "攻擊";
	L["Whirlwind"] = "旋風斬";
	L["Heroic Strike"] = "英勇打擊";
	L["Raptor Strike"] = "猛禽一擊";
else
	L["Attack"] = "Attack";
	L["Whirlwind"] = "Whirlwind";
	L["Heroic Strike"] = "Heroic Strike";
	L["Raptor Strike"] = "Raptor Strike";
end

local AttackTimer_Enabled = false;
local AttackTimer_LastSpeed = UnitAttackSpeed("player");
local AttackTimer_TriggerSpells = {L["Whirlwind"], L["Heroic Strike"], L["Raptor Strike"]};

function AttackTimer_OnLoad(self)
	dwRegisterForSaveFrame(self, self:GetName());
	self:SetMinMaxValues(0, 1);
	self:SetValue(1);
end
----------------------------------------------------------------------------------------------------
-- 闪烁
----------------------------------------------------------------------------------------------------
local function AttackTimer_FlashBar()
	if (not AttackTimerBar:IsVisible()) then
		AttackTimerBar:Hide();
	end
	if AttackTimerBar:IsShown() then
		local min, max = AttackTimerBar:GetMinMaxValues();
		AttackTimerBar:SetValue(max);
		AttackTimerBar:SetStatusBarColor(0.0, 1.0, 0.0);
		AttackTimerBarSpark:Hide();
		AttackTimerBarFlash:SetAlpha(0.0);
		AttackTimerBarFlash:Show();
		AttackTimerBar.casting = nil;
		AttackTimerBar.flash = 1;
		AttackTimerBar.fadeOut = 1;
	end
end
---------------------------------------------------------------------------------------------
-- 攻击
----------------------------------------------------------------------------------------------
local function AttackTimer_OnAttack(parry)
	local min, max = GetTime();
	local curTime, mainS = min, UnitAttackSpeed("player");
	
	if (parry and AttackTimerBar.start and AttackTimerBar.stop) then
		if (not AttackTimerBar:IsVisible()) then return; end

		min = AttackTimerBar.start;
		max = AttackTimerBar.stop;
		if ((curTime - min) < 0.6*mainS) then
			max = max - 0.4*mainS;
		end
	else
		max = min + mainS;
	end

	AttackTimerBar:SetStatusBarColor(1.0, 0.7, 0.0);
	AttackTimerBar:SetMinMaxValues(min, max);
	AttackTimerBar:SetValue(curTime);	
	AttackTimerBar:SetAlpha(1.0);
	AttackTimerBar.start = min;
	AttackTimerBar.stop = max;
	AttackTimerBar.casting = 1;
	AttackTimerBar.fadeOut = nil;
	AttackTimerBarSpark:Show();
	AttackTimerBar:Show();
	
	AttackTimerBarTextLeft:SetText(L["Attack"]);
end
---------------------------------------------------------------------------------------------
-- OnEvent
---------------------------------------------------------------------------------------------
local function isAttackSpell(spell)
	for k, v in pairs(AttackTimer_TriggerSpells) do
		if (v == spell) then
			return true;
		end
	end
	return false;
end

function AE:COMBAT_LOG_EVENT_UNFILTERED (...)
	local event, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, spellID, spell = select(1, ...);		
	if (event == "SPELL_DAMAGE") then
		if (CombatLog_Object_IsA(srcFlags,  COMBATLOG_FILTER_ME) and isAttackSpell(spell)) then
			AttackTimer_OnAttack();
		end
	elseif (event == "SWING_DAMAGE") then
		if (CombatLog_Object_IsA(srcFlags,  COMBATLOG_FILTER_ME)) then
			AttackTimer_OnAttack();
		end
	elseif (event == "SWING_MISSED") then
		if (CombatLog_Object_IsA(srcFlags,  COMBATLOG_FILTER_ME)) then
			AttackTimer_OnAttack();
		elseif (CombatLog_Object_IsA(dstFlags,  COMBATLOG_FILTER_ME) and arg1 == "PARRY") then
			AttackTimer_OnAttack(true);
		end
	elseif (event == "SPELL_MISSED") then
		if (CombatLog_Object_IsA(srcFlags,  COMBATLOG_FILTER_ME) and isAttackSpell(spell)) then
			AttackTimer_OnAttack();
		end
	end
end


function AE:PLAYER_LEAVE_COMBAT()	
	AttackTimer_FlashBar();
end

function AE:UNIT_ATTACK_SPEED()	
	local mainSpeed = UnitAttackSpeed("player");
	if (mainSpeed ~= AttackTimer_LastSpeed and AttackTimerBar.start) then
		AttackTimer_LastSpeed = mainSpeed;
		AttackTimerBar.stop = AttackTimerBar.start + mainSpeed;
		AttackTimerBar:SetMinMaxValues(AttackTimerBar.start, AttackTimerBar.stop);
		AttackTimerBar:SetValue(GetTime());
	end
end

function AE:PLAYER_REGEN_DISABLED()	
	if (AttackTimerMove:IsVisible()) then
		AttackTimerMove:Hide();
	end
end

function AttackTimer_OnEvent(self, event, ...)	
	if (AE[event]) then
		AE[event](...);
	end
end

function AttackTimer_OnUpdate(self)
	if (not AttackTimer_Enabled) then
		return;
	end

	local min, max = AttackTimerBar:GetMinMaxValues();
	if self.casting then
		local status = GetTime();
		if status > max then
			status = max;
		end
		AttackTimerBarTextRight:SetText(format("%0.1f", max-status));
		AttackTimerBar:SetValue(status);
		AttackTimerBarFlash:Hide();
		local sparkPosition = ((status - min) / (max - min)) * 195;
		if sparkPosition < 0 then
			sparkPosition = 0;
		end
		AttackTimerBarSpark:SetPoint("CENTER", AttackTimerBar, "LEFT", sparkPosition, 0);
	elseif self.flash then
		local alpha = AttackTimerBarFlash:GetAlpha() + CASTING_BAR_FLASH_STEP;
		if alpha < 1 then
			AttackTimerBarFlash:SetAlpha(alpha);
		else
			AttackTimerBarFlash:SetAlpha(1.0);
			self.flash = nil;
		end
	elseif self.fadeOut then
		local alpha =self:GetAlpha() - CASTING_BAR_ALPHA_STEP;
		if alpha > 0 then
			self:SetAlpha(alpha);
		else
			self.fadeOut = nil;
			self:Hide();
		end
	end
end	

function AttackTimer_Toggle(switch)
	if (switch) then
		AttackTimerBar:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED");
		AttackTimerBar:RegisterEvent("PLAYER_LEAVE_COMBAT");
		AttackTimerBar:RegisterEvent("UNIT_ATTACK_SPEED");
		AttackTimerBar:RegisterEvent("PLAYER_REGEN_DISABLED");
		AttackTimer_Enabled = true;
	else
		AttackTimerBar:UnregisterAllEvents();	
		AttackTimer_FlashBar();

		AttackTimer_Enabled = false;
	end
end

function AttackTimer_AjustPosition()
	if (AttackTimerMove:IsVisible()) then
		AttackTimerMove:Hide();
		AttackTimerBar:Hide();
	else
		AttackTimerMove:Show();
		AttackTimerBar:Show();
		AttackTimerBar:SetAlpha(1);
	end
end


--AttackTimer:Init{
--	name = "AttackTimer",
--	func = function()
--		AttackTimer_Toggle(true);
--	end
--};
