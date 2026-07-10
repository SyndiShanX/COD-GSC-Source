require("x64:968e0059783ebe7")
require("x64:38716dffd7a5258")
require("x64:8503431250d50b7")
require("x64:67035dcc0ce94cc")
require("x64:d1bb2b99fadfab6")
require("x64:2675595fa323085")
require("x64:dc94decf3a09a57")
CoD.TabbedScoreboard = InheritFrom(LUI.UIElement)
CoD.TabbedScoreboard.__defaultWidth = 1920
CoD.TabbedScoreboard.__defaultHeight = 1080
CoD.TabbedScoreboard.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	DataSourceHelperRecreate(f1_arg1, "PositionEditLoadout")
	CoD.BaseUtility.InitControllerModelIfNotSet(f1_arg1, "scoreboardInfo.activeTab", 0)
	self:setClass(CoD.TabbedScoreboard)
	self.id = "TabbedScoreboard"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local emptyFocusable = nil
	emptyFocusable = CoD.emptyFocusable.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(emptyFocusable)
	self.emptyFocusable = emptyFocusable
	local ScoreboardGameMap = CoD.ScoreboardGameStatus.new(f1_arg0, f1_arg1, 0.5, 0.5, -960, 960, 0.5, 0.5, -470, 323)
	self:addElement(ScoreboardGameMap)
	self.ScoreboardGameMap = ScoreboardGameMap
	local PCTabbedScoreboardAccessMapPrompt = nil
	PCTabbedScoreboardAccessMapPrompt = CoD.PCTabbedScoreboardAccessMapPrompt.new(f1_arg0, f1_arg1, 0.5, 1.5, -726, -1194, 0.5, 0.5, -470, -430)
	self:addElement(PCTabbedScoreboardAccessMapPrompt)
	self.PCTabbedScoreboardAccessMapPrompt = PCTabbedScoreboardAccessMapPrompt
	local ScoreboardGameStatusScores = CoD.ScoreboardGameStatusScores.new(f1_arg0, f1_arg1, 0.5, 0.5, -960, 960, 1, 1, -200, 0)
	ScoreboardGameStatusScores:mergeStateConditions({
		{
			stateName = "HiddenByEvent",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsModelValueEqualToEnum(f1_arg1, "scoreboardInfo.activeTab", CoD.HUDUtility.GameStatusMode.MODE_SHOW_SCORES)
			end,
		},
	})
	local TabbedScoreboardScores = ScoreboardGameStatusScores
	local TabbedScoreboardHeader = ScoreboardGameStatusScores.subscribeToModel
	local ScoreboardTabs = Engine[@"getmodelforcontroller"](f1_arg1)
	TabbedScoreboardHeader(TabbedScoreboardScores, ScoreboardTabs["scoreboardInfo.activeTab"], function(f3_arg0)
		f1_arg0:updateElementState(ScoreboardGameStatusScores, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f3_arg0:get(),
			modelName = "scoreboardInfo.activeTab",
		})
	end, false)
	TabbedScoreboardScores = ScoreboardGameStatusScores
	TabbedScoreboardHeader = ScoreboardGameStatusScores.subscribeToModel
	ScoreboardTabs = Engine[@"getmodelforcontroller"](f1_arg1)
	TabbedScoreboardHeader(TabbedScoreboardScores, ScoreboardTabs["factions.isCoDCaster"], function(f4_arg0)
		f1_arg0:updateElementState(ScoreboardGameStatusScores, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f4_arg0:get(),
			modelName = "factions.isCoDCaster",
		})
	end, false)
	TabbedScoreboardScores = ScoreboardGameStatusScores
	TabbedScoreboardHeader = ScoreboardGameStatusScores.subscribeToModel
	ScoreboardTabs = Engine[@"getglobalmodel"]()
	TabbedScoreboardHeader(TabbedScoreboardScores, ScoreboardTabs["scoreboard.team1.count"], function(f5_arg0)
		f1_arg0:updateElementState(ScoreboardGameStatusScores, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f5_arg0:get(),
			modelName = "scoreboard.team1.count",
		})
	end, false)
	TabbedScoreboardScores = ScoreboardGameStatusScores
	TabbedScoreboardHeader = ScoreboardGameStatusScores.subscribeToModel
	ScoreboardTabs = Engine[@"getglobalmodel"]()
	TabbedScoreboardHeader(TabbedScoreboardScores, ScoreboardTabs["scoreboard.team2.count"], function(f6_arg0)
		f1_arg0:updateElementState(ScoreboardGameStatusScores, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "scoreboard.team2.count",
		})
	end, false)
	ScoreboardGameStatusScores:linkToElementModel(ScoreboardGameStatusScores, "scoreboard.characterIndex", true, function(model)
		f1_arg0:updateElementState(ScoreboardGameStatusScores, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "scoreboard.characterIndex",
		})
	end)
	ScoreboardGameStatusScores:setAlpha(0)
	self:addElement(ScoreboardGameStatusScores)
	self.ScoreboardGameStatusScores = ScoreboardGameStatusScores
	TabbedScoreboardHeader = CoD.TabbedScoreboardHeader.new(f1_arg0, f1_arg1, 0.5, 0.5, -725, 725, 0.5, 0.5, -470, -300)
	self:addElement(TabbedScoreboardHeader)
	self.TabbedScoreboardHeader = TabbedScoreboardHeader
	TabbedScoreboardScores = CoD.TabbedScoreboardScores.new(f1_arg0, f1_arg1, 0.5, 0.5, -960, 960, 0.5, 0.5, -470, 323)
	self:addElement(TabbedScoreboardScores)
	self.TabbedScoreboardScores = TabbedScoreboardScores
	ScoreboardTabs = CoD.ScoreboardTabs.new(f1_arg0, f1_arg1, 0.5, 0.5, -360, 360, 0.5, 0.5, -470, -436)
	self:addElement(ScoreboardTabs)
	self.ScoreboardTabs = ScoreboardTabs
	self:mergeStateConditions({
		{
			stateName = "Active",
			condition = function(menu, element, event)
				return Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_scoreboard_open"])
			end,
		},
		{
			stateName = "Forced",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueEqualTo(f1_arg1, "forceScoreboard", 1)
			end,
		},
	})
	local f1_local8 = self
	local f1_local9 = self.subscribeToModel
	local f1_local10 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local9(f1_local8, f1_local10["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_scoreboard_open"]], function(f10_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f10_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_scoreboard_open"],
		})
	end, false)
	f1_local8 = self
	f1_local9 = self.subscribeToModel
	f1_local10 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local9(f1_local8, f1_local10.forceScoreboard, function(f11_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f11_arg0:get(),
			modelName = "forceScoreboard",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(self, "setState", function(element, controller, f12_arg2, f12_arg3, f12_arg4)
		if IsSelfInState(self, "Active") and IsPC() and IsDemoPlaying() then
			SetElementProperty(self.ScoreboardTabs, "m_disableNavigation", nil)
		elseif IsSelfInState(self, "Active") and IsPC() then
			SetElementProperty(self.ScoreboardTabs, "m_disableNavigation", nil)
			EnableMouseLockInputBinding(f1_arg0, controller, true, false)
		elseif IsSelfInState(self, "Active") then
			SetElementProperty(self.ScoreboardTabs, "m_disableNavigation", nil)
		elseif IsSelfInState(self, "Forced") then
			SetElementProperty(self.ScoreboardTabs, "m_disableNavigation", nil)
			EnableMouseLockInputBinding(f1_arg0, controller, false, false)
		elseif IsSelfInState(self, "DefaultState") and IsDemoPlaying() then
			SetElementProperty(self.ScoreboardTabs, "m_disableNavigation", true)
			SetControllerModelValue(controller, "scoreboardInfo.activeTab", CoD.HUDUtility.GameStatusMode.MODE_SHOW_SCORES)
			SetFocusToElement(self, "ScoreboardTabs", controller)
			CoD.ScoreboardUtility.UpdateScoreboardTabsFocus(self.ScoreboardTabs)
			CoD.HUDUtility.GiveFocusToMenu(f1_arg0, controller)
			CloseContextualMenu(f1_arg0, controller)
			CoD.ScoreboardUtility.CloseOccluders(controller, f1_arg0)
		elseif IsSelfInState(self, "DefaultState") then
			SetElementProperty(self.ScoreboardTabs, "m_disableNavigation", true)
			SetControllerModelValue(controller, "scoreboardInfo.activeTab", CoD.HUDUtility.GameStatusMode.MODE_SHOW_SCORES)
			SetFocusToElement(self, "ScoreboardTabs", controller)
			CoD.ScoreboardUtility.UpdateScoreboardTabsFocus(self.ScoreboardTabs)
			CoD.HUDUtility.GiveFocusToMenu(f1_arg0, controller)
			CloseContextualMenu(f1_arg0, controller)
			CoD.ScoreboardUtility.CloseOccluders(controller, f1_arg0)
			EnableMouseLockInputBinding(f1_arg0, controller, false, false)
		end
	end)
	if CoD.isPC then
		emptyFocusable.id = "emptyFocusable"
	end
	TabbedScoreboardHeader.id = "TabbedScoreboardHeader"
	TabbedScoreboardScores.id = "TabbedScoreboardScores"
	ScoreboardTabs.id = "ScoreboardTabs"
	self.__defaultFocus = TabbedScoreboardScores
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local9 = self
	SetElementProperty(self.ScoreboardTabs, "m_disableNavigation", true)
	CoD.ScoreboardUtility.SetupFooterSubscription(self.ScoreboardGameStatusScores, f1_arg1)
	DisableKeyboardNavigationByElement(emptyFocusable)
	return self
end
CoD.TabbedScoreboard.__resetProperties = function(f13_arg0)
	f13_arg0.ScoreboardGameMap:completeAnimation()
	f13_arg0.ScoreboardGameMap:setAlpha(1)
end
CoD.TabbedScoreboard.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(1)
			f14_arg0.ScoreboardGameMap:completeAnimation()
			f14_arg0.ScoreboardGameMap:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.ScoreboardGameMap)
		end,
	},
	Active = {
		DefaultClip = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(0)
		end,
	},
	Forced = {
		DefaultClip = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(0)
		end,
	},
}
CoD.TabbedScoreboard.__onClose = function(f17_arg0)
	f17_arg0.emptyFocusable:close()
	f17_arg0.ScoreboardGameMap:close()
	f17_arg0.PCTabbedScoreboardAccessMapPrompt:close()
	f17_arg0.ScoreboardGameStatusScores:close()
	f17_arg0.TabbedScoreboardHeader:close()
	f17_arg0.TabbedScoreboardScores:close()
	f17_arg0.ScoreboardTabs:close()
end
