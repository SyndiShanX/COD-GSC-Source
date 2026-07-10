require("x64:472d32d2ed46dc6")
require("x64:a82c27407cbda10")
CoD.TrialsEndGameScoreboard = InheritFrom(LUI.UIElement)
CoD.TrialsEndGameScoreboard.__defaultWidth = 888
CoD.TrialsEndGameScoreboard.__defaultHeight = 383
CoD.TrialsEndGameScoreboard.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.TrialsEndGameScoreboard)
	self.id = "TrialsEndGameScoreboard"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	local Scoreboard = LUI.UIList.new(f1_arg0, f1_arg1, 20, 0, nil, false, false, false, false)
	Scoreboard:setLeftRight(0.5, 0.5, -444, 444)
	Scoreboard:setTopBottom(0, 0, 51, 383)
	Scoreboard:setWidgetType(CoD.ScoreboardRowZM)
	Scoreboard:setVerticalCount(4)
	Scoreboard:setSpacing(20)
	Scoreboard:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	Scoreboard:setDataSource("Clients")
	Scoreboard:registerEventHandler("list_item_gain_focus", function(element, event)
		local f2_local0 = nil
		CoD.ScoreboardUtility.SetCurrentFocusedClient(element, f1_arg1)
		return f2_local0
	end)
	Scoreboard:registerEventHandler("gain_focus", function(element, event)
		local f3_local0 = nil
		if element.gainFocus then
			f3_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f3_local0 = element.super:gainFocus(event)
		end
		CoD.ScoreboardUtility.SetSavedActiveItemToLocalPlayer(element, f1_arg1)
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f3_local0
	end)
	f1_arg0:AddButtonCallbackFunction(Scoreboard, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], nil, function(element, menu, controller, model)
		CoD.ScoreboardUtility.ToggleClientMute(element, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x0, nil, nil)
		return false
	end, false)
	self.__on_onStartMenuOpened_Scoreboard = function(f6_arg0, f6_arg1)
		CoD.GridAndListUtility.SortListByControllerModelKeys(f6_arg1, Scoreboard, "scoreboardInfo.sortKey0", "scoreboardInfo.sortKey1", "scoreboardInfo.sortKey2")
	end
	LUI.OverrideFunction_CallOriginalFirst(f1_arg0, "onStartMenuOpened", self.__on_onStartMenuOpened_Scoreboard)
	self:addElement(Scoreboard)
	self.Scoreboard = Scoreboard
	local BackingBase = LUI.UIImage.new(0, 0, 0, 888, 0, 0, 0, 30)
	BackingBase:setAlpha(0)
	BackingBase:setImage(RegisterImage(0xBB35BC5D2F0269C))
	self:addElement(BackingBase)
	self.BackingBase = BackingBase
	local ScoreboardColHeadersZM = CoD.ScoreboardColHeadersZM.new(f1_arg0, f1_arg1, 0.5, 0.5, -444, 444, 0, 0, 0, 30)
	self:addElement(ScoreboardColHeadersZM)
	self.ScoreboardColHeadersZM = ScoreboardColHeadersZM
	Scoreboard.id = "Scoreboard"
	self.__on_close_removeOverrides = function()
		LUI.OverrideFunction_Remove(f1_arg0, "onStartMenuOpened", self.__on_onStartMenuOpened_Scoreboard)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local4 = self
	f1_local4 = Scoreboard
	SetElementProperty(f1_local4, "friendlyTeam", true)
	CoD.GridAndListUtility.AddListUpDownNavigation(f1_arg0, f1_local4, f1_arg1)
	CoD.FreeCursorUtility.SetListFocusIgnoresFreeCursor(f1_local4, f1_arg1)
	CoD.GridAndListUtility.SortListByControllerModelKeys(f1_arg1, f1_local4, "scoreboardInfo.sortKey0", "scoreboardInfo.sortKey1", "scoreboardInfo.sortKey2")
	return self
end
CoD.TrialsEndGameScoreboard.__onClose = function(f8_arg0)
	f8_arg0.__on_close_removeOverrides()
	f8_arg0.Scoreboard:close()
	f8_arg0.ScoreboardColHeadersZM:close()
end
