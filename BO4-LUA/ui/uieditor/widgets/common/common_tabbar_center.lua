require("ui/uieditor/widgets/bumperbuttonwithkeymousetext")
require("ui/uieditor/widgets/director/directorselecttexttab")
require("ui/uieditor/widgets/tabbedwidgets/basictablist")
require("ui/uieditor/widgets/pc/pc_tabsarrow")
CoD.Common_Tabbar_Center = InheritFrom(LUI.UIElement)
CoD.Common_Tabbar_Center.__defaultWidth = 3300
CoD.Common_Tabbar_Center.__defaultHeight = 61
CoD.Common_Tabbar_Center.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIHorizontalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 12, false)
	self:setAlignment(LUI.Alignment.Center)
	CoD.BaseUtility.InitGlobalModel("CommonCurrentActiveTabIndex", 1)
	self:setClass(CoD.Common_Tabbar_Center)
	self.id = "Common_Tabbar_Center"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local LB = CoD.BumperButtonWithKeyMouseText.new(f1_arg0, f1_arg1, 0.5, 0.5, -1148, -948, 0, 0.56, 17, 17)
	LB.GamepadPrompt:setText(Engine[@"hash_4F9F1239CFD921FE"]("groups/lb"))
	LB.GamepadPrompt:setAlignment(Enum.LUIAlignment[@"lui_alignment_right"])
	self:addElement(LB)
	self.LB = LB
	local left = nil
	left = CoD.PC_TabsArrow.new(f1_arg0, f1_arg1, 1, 1, -2586, -2526, 0.5, 0.5, -17, 23)
	left:mergeStateConditions({
		{
			stateName = "Disabled",
			condition = function(menu, element, event)
				return CoD.CACUtility.IsFirstCommonTabInRowActive(f1_arg1)
			end,
		},
	})
	local RB = left
	local Tabs = left.subscribeToModel
	local right = Engine.GetGlobalModel()
	Tabs(RB, right.CommonCurrentActiveTabIndex, function(f3_arg0)
		f1_arg0:updateElementState(left, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f3_arg0:get(),
			modelName = "CommonCurrentActiveTabIndex",
		})
	end, false)
	left:setAlpha(0)
	left:registerEventHandler("gain_focus", function(element, event)
		local f4_local0 = nil
		if element.gainFocus then
			f4_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f4_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum.LUIButton[@"lui_key_xba_pscross"])
		return f4_local0
	end)
	f1_arg0:AddButtonCallbackFunction(left, f1_arg1, Enum.LUIButton[@"lui_key_xba_pscross"], "ui_confirm", function(f5_arg0, f5_arg1, f5_arg2, f5_arg3)
		CoD.GridAndListUtility.DoBumperGridButton(f5_arg1, f5_arg2, true)
		return true
	end, function(f6_arg0, f6_arg1, f6_arg2)
		CoD.Menu.SetButtonLabel(f6_arg1, Enum.LUIButton[@"lui_key_xba_pscross"], @"menu/select", nil, "ui_confirm")
		return true
	end, false)
	self:addElement(left)
	self.left = left
	Tabs = CoD.basicTabList.new(f1_arg0, f1_arg1, 0.5, 0.5, -864, 864, 0, 0.98, 17, 17)
	Tabs.grid:setWidgetType(CoD.DirectorSelectTextTab)
	self:addElement(Tabs)
	self.Tabs = Tabs
	RB = CoD.BumperButtonWithKeyMouseText.new(f1_arg0, f1_arg1, 0.5, 0.5, 876, 1076, 0, 0.56, 17, 17)
	RB.GamepadPrompt:setText(Engine[@"hash_4F9F1239CFD921FE"]("groups/rb"))
	self:addElement(RB)
	self.RB = RB
	right = nil
	right = CoD.PC_TabsArrow.new(f1_arg0, f1_arg1, 1, 1, -562, -502, 0.5, 0.5, -17, 23)
	right:mergeStateConditions({
		{
			stateName = "Disabled",
			condition = function(menu, element, event)
				return CoD.CACUtility.IsLastCommonTabInRowActive(f1_arg1, self.Tabs)
			end,
		},
	})
	local f1_local6 = right
	local f1_local7 = right.subscribeToModel
	local f1_local8 = Engine.GetGlobalModel()
	f1_local7(f1_local6, f1_local8.CommonCurrentActiveTabIndex, function(f8_arg0)
		f1_arg0:updateElementState(right, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f8_arg0:get(),
			modelName = "CommonCurrentActiveTabIndex",
		})
	end, false)
	right:setAlpha(0)
	right:setZRot(180)
	right:registerEventHandler("gain_focus", function(element, event)
		local f9_local0 = nil
		if element.gainFocus then
			f9_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f9_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum.LUIButton[@"lui_key_xba_pscross"])
		return f9_local0
	end)
	f1_arg0:AddButtonCallbackFunction(right, f1_arg1, Enum.LUIButton[@"lui_key_xba_pscross"], "ui_confirm", function(f10_arg0, f10_arg1, f10_arg2, f10_arg3)
		CoD.GridAndListUtility.DoBumperGridButton(f10_arg1, f10_arg2, false)
		return true
	end, function(f11_arg0, f11_arg1, f11_arg2)
		CoD.Menu.SetButtonLabel(f11_arg1, Enum.LUIButton[@"lui_key_xba_pscross"], @"menu/select", nil, "ui_confirm")
		return true
	end, false)
	self:addElement(right)
	self.right = right
	self:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "ArrowShown",
			condition = function(menu, element, event)
				return CoD.GridAndListUtility.ShowTabArrows(f1_arg1, self.Tabs) and not IsGamepad(f1_arg1)
			end,
		},
	})
	self:appendEventHandler("grid_updated", function(f14_arg0, f14_arg1)
		f14_arg1.menu = f14_arg1.menu or f1_arg0
		f1_arg0:updateElementState(self, f14_arg1)
	end)
	self:appendEventHandler("input_source_changed", function(f15_arg0, f15_arg1)
		f15_arg1.menu = f15_arg1.menu or f1_arg0
		f1_arg0:updateElementState(self, f15_arg1)
	end)
	f1_local6 = self
	f1_local7 = self.subscribeToModel
	f1_local8 = Engine.GetModelForController(f1_arg1)
	f1_local7(f1_local6, f1_local8.LastInput, function(f16_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f16_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	if CoD.isPC then
		left.id = "left"
	end
	Tabs.id = "Tabs"
	if CoD.isPC then
		right.id = "right"
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.Common_Tabbar_Center.__resetProperties = function(f17_arg0)
	f17_arg0.RB:completeAnimation()
	f17_arg0.LB:completeAnimation()
	f17_arg0.Tabs:completeAnimation()
	f17_arg0.left:completeAnimation()
	f17_arg0.right:completeAnimation()
	f17_arg0.RB:setAlpha(1)
	f17_arg0.LB:setAlpha(1)
	f17_arg0.Tabs:setAlpha(1)
	f17_arg0.left:setAlpha(0)
	f17_arg0.right:setAlpha(0)
end
CoD.Common_Tabbar_Center.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(0)
		end,
	},
	Hidden = {
		DefaultClip = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(3)
			f19_arg0.LB:completeAnimation()
			f19_arg0.LB:setAlpha(0)
			f19_arg0.clipFinished(f19_arg0.LB)
			f19_arg0.Tabs:completeAnimation()
			f19_arg0.Tabs:setAlpha(0)
			f19_arg0.clipFinished(f19_arg0.Tabs)
			f19_arg0.RB:completeAnimation()
			f19_arg0.RB:setAlpha(0)
			f19_arg0.clipFinished(f19_arg0.RB)
		end,
	},
	ArrowShown = {
		DefaultClip = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(4)
			f20_arg0.LB:completeAnimation()
			f20_arg0.LB:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.LB)
			f20_arg0.left:completeAnimation()
			f20_arg0.left:setAlpha(1)
			f20_arg0.clipFinished(f20_arg0.left)
			f20_arg0.RB:completeAnimation()
			f20_arg0.RB:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.RB)
			f20_arg0.right:completeAnimation()
			f20_arg0.right:setAlpha(1)
			f20_arg0.clipFinished(f20_arg0.right)
		end,
	},
}
CoD.Common_Tabbar_Center.__onClose = function(f21_arg0)
	f21_arg0.LB:close()
	f21_arg0.left:close()
	f21_arg0.Tabs:close()
	f21_arg0.RB:close()
	f21_arg0.right:close()
end
