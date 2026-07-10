require("x64:1394ae5e9cdcb54")
require("x64:391b667b0cbcc40")
CoD.ScoreboardTabs = InheritFrom(LUI.UIElement)
CoD.ScoreboardTabs.__defaultWidth = 720
CoD.ScoreboardTabs.__defaultHeight = 34
CoD.ScoreboardTabs.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ScoreboardTabs)
	self.id = "ScoreboardTabs"
	self.soundSet = "none"
	self.onlyChildrenFocusable = CoD.isPC
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Tabs = LUI.GridLayout.new(f1_arg0, f1_arg1, false, 0, 0, 2, 0, nil, nil, true, false, false, false)
	Tabs:setLeftRight(0, 0, 200, 542)
	Tabs:setTopBottom(0, 0, 4, 38)
	Tabs:setWidgetType(CoD.TabbedScoreboardTab)
	Tabs:setHorizontalCount(2)
	Tabs:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	Tabs:setDataSource("TabbedScoreboardTabs")
	Tabs:registerEventHandler("mouse_left_click", function(element, event)
		local f2_local0 = nil
		CoD.BaseUtility.ProcessGridAction(self, element, f1_arg1, event)
		if not f2_local0 then
			f2_local0 = element:dispatchEventToChildren(event)
		end
		return f2_local0
	end)
	self:addElement(Tabs)
	self.Tabs = Tabs
	local RB = CoD.BumperButtonWithKeyMouseText.new(f1_arg0, f1_arg1, 0.5, 0.5, 234, 430, 0, 0, 0, 34)
	RB:mergeStateConditions({
		{
			stateName = "KBM",
			condition = function(menu, element, event)
				return IsMouseOrKeyboard(f1_arg1)
			end,
		},
	})
	RB:appendEventHandler("input_source_changed", function(f4_arg0, f4_arg1)
		f4_arg1.menu = f4_arg1.menu or f1_arg0
		f1_arg0:updateElementState(RB, f4_arg1)
	end)
	local f1_local3 = RB
	local LB = RB.subscribeToModel
	local f1_local5 = Engine[@"getmodelforcontroller"](f1_arg1)
	LB(f1_local3, f1_local5.LastInput, function(f5_arg0)
		f1_arg0:updateElementState(RB, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f5_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	RB.GamepadPrompt:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_5BFED5292621DA9A"))
	RB.KeyPrompt.keybind:setText(CoD.BaseUtility.AlreadyLocalized("E"))
	self:addElement(RB)
	self.RB = RB
	LB = CoD.BumperButtonWithKeyMouseText.new(f1_arg0, f1_arg1, 0.5, 0.5, -272, -76, 0, 0, 0, 34)
	LB:mergeStateConditions({
		{
			stateName = "KBM",
			condition = function(menu, element, event)
				return IsMouseOrKeyboard(f1_arg1)
			end,
		},
	})
	LB:appendEventHandler("input_source_changed", function(f7_arg0, f7_arg1)
		f7_arg1.menu = f7_arg1.menu or f1_arg0
		f1_arg0:updateElementState(LB, f7_arg1)
	end)
	f1_local5 = LB
	f1_local3 = LB.subscribeToModel
	local f1_local6 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local3(f1_local5, f1_local6.LastInput, function(f8_arg0)
		f1_arg0:updateElementState(LB, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f8_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	LB.GamepadPrompt:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_5BDCD5292604F434"))
	LB.KeyPrompt.keybind:setText(CoD.BaseUtility.AlreadyLocalized("Q"))
	self:addElement(LB)
	self.LB = LB
	self:mergeStateConditions({
		{
			stateName = "KBM",
			condition = function(menu, element, event)
				return IsMouseOrKeyboard(f1_arg1)
			end,
		},
		{
			stateName = "Shoutcaster",
			condition = function(menu, element, event)
				return IsCodCaster(f1_arg1)
			end,
		},
	})
	self:appendEventHandler("input_source_changed", function(f11_arg0, f11_arg1)
		f11_arg1.menu = f11_arg1.menu or f1_arg0
		f1_arg0:updateElementState(self, f11_arg1)
	end)
	f1_local5 = self
	f1_local3 = self.subscribeToModel
	f1_local6 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local3(f1_local5, f1_local6.LastInput, function(f12_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f12_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	f1_local5 = self
	f1_local3 = self.subscribeToModel
	f1_local6 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local3(f1_local5, f1_local6["factions.isCoDCaster"], function(f13_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f13_arg0:get(),
			modelName = "factions.isCoDCaster",
		})
	end, false)
	Tabs.id = "Tabs"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local3 = self
	CoD.HUDUtility.AddScoreboardBumperNavigation(f1_arg0, Tabs, f1_arg1)
	return self
end
CoD.ScoreboardTabs.__resetProperties = function(f14_arg0)
	f14_arg0.LB:completeAnimation()
	f14_arg0.RB:completeAnimation()
	f14_arg0.Tabs:completeAnimation()
	f14_arg0.LB:setAlpha(1)
	f14_arg0.RB:setAlpha(1)
	f14_arg0.Tabs:setAlpha(1)
end
CoD.ScoreboardTabs.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(3)
			f15_arg0.Tabs:completeAnimation()
			f15_arg0.Tabs:setAlpha(1)
			f15_arg0.clipFinished(f15_arg0.Tabs)
			f15_arg0.RB:completeAnimation()
			f15_arg0.RB:setAlpha(1)
			f15_arg0.clipFinished(f15_arg0.RB)
			f15_arg0.LB:completeAnimation()
			f15_arg0.LB:setAlpha(1)
			f15_arg0.clipFinished(f15_arg0.LB)
		end,
	},
	KBM = {
		DefaultClip = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(3)
			f16_arg0.Tabs:completeAnimation()
			f16_arg0.Tabs:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.Tabs)
			f16_arg0.RB:completeAnimation()
			f16_arg0.RB:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.RB)
			f16_arg0.LB:completeAnimation()
			f16_arg0.LB:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.LB)
		end,
	},
	Shoutcaster = {
		DefaultClip = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(3)
			f17_arg0.Tabs:completeAnimation()
			f17_arg0.Tabs:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.Tabs)
			f17_arg0.RB:completeAnimation()
			f17_arg0.RB:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.RB)
			f17_arg0.LB:completeAnimation()
			f17_arg0.LB:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.LB)
		end,
	},
}
CoD.ScoreboardTabs.__onClose = function(f18_arg0)
	f18_arg0.Tabs:close()
	f18_arg0.RB:close()
	f18_arg0.LB:close()
end
