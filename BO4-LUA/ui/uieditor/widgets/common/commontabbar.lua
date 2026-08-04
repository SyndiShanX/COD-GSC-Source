require("ui/uieditor/widgets/bumperbuttonwithkeymousetext")
require("ui/uieditor/widgets/common/commontabbutton")
require("ui/uieditor/widgets/tabbedwidgets/basictablist")
CoD.CommonTabBar = InheritFrom(LUI.UIElement)
CoD.CommonTabBar.__defaultWidth = 3300
CoD.CommonTabBar.__defaultHeight = 61
CoD.CommonTabBar.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIHorizontalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 4, false)
	self:setAlignment(LUI.Alignment.Center)
	self:setClass(CoD.CommonTabBar)
	self.id = "CommonTabBar"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local LB = CoD.BumperButtonWithKeyMouseText.new(f1_arg0, f1_arg1, 0, 0, 582, 782, 0, 0, 16.5, 50.5)
	LB.GamepadPrompt:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_F0418298D80E185"))
	LB.GamepadPrompt:setAlignment(Enum.LUIAlignment[@"lui_alignment_right"])
	self:addElement(LB)
	self.LB = LB
	local Tabs = CoD.basicTabList.new(f1_arg0, f1_arg1, 0, 0, 786, 2514, 0, 0, 16.5, 76.5)
	Tabs.grid:setWidgetType(CoD.CommonTabButton)
	self:addElement(Tabs)
	self.Tabs = Tabs
	local RB = CoD.BumperButtonWithKeyMouseText.new(f1_arg0, f1_arg1, 0, 0, 2518, 2718, 0, 0, 16.5, 50.5)
	RB.GamepadPrompt:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_7F5CE97BDE3585DB"))
	self:addElement(RB)
	self.RB = RB
	Tabs.id = "Tabs"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CommonTabBar.__resetProperties = function(f2_arg0)
	f2_arg0.RB:completeAnimation()
	f2_arg0.LB:completeAnimation()
	f2_arg0.Tabs:completeAnimation()
	f2_arg0.RB:setAlpha(1)
	f2_arg0.LB:setAlpha(1)
	f2_arg0.Tabs:setAlpha(1)
end
CoD.CommonTabBar.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(0)
		end,
	},
	Hidden = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(3)
			f4_arg0.LB:completeAnimation()
			f4_arg0.LB:setAlpha(0)
			f4_arg0.clipFinished(f4_arg0.LB)
			f4_arg0.Tabs:completeAnimation()
			f4_arg0.Tabs:setAlpha(0)
			f4_arg0.clipFinished(f4_arg0.Tabs)
			f4_arg0.RB:completeAnimation()
			f4_arg0.RB:setAlpha(0)
			f4_arg0.clipFinished(f4_arg0.RB)
		end,
	},
}
CoD.CommonTabBar.__onClose = function(f5_arg0)
	f5_arg0.LB:close()
	f5_arg0.Tabs:close()
	f5_arg0.RB:close()
end
