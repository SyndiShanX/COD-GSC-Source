require("x64:1394ae5e9cdcb54")
require("x64:9dc2d0c43534ce4")
require("x64:512dc4835b93364")
CoD.CommonSecondaryTabBar = InheritFrom(LUI.UIElement)
CoD.CommonSecondaryTabBar.__defaultWidth = 3300
CoD.CommonSecondaryTabBar.__defaultHeight = 61
CoD.CommonSecondaryTabBar.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIHorizontalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 0, false)
	self:setAlignment(LUI.Alignment.Center)
	self:setClass(CoD.CommonSecondaryTabBar)
	self.id = "CommonSecondaryTabBar"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local LTrig = CoD.BumperButtonWithKeyMouseText.new(f1_arg0, f1_arg1, 0, 0, 586, 786, 0.5, 0.5, -17, 17)
	LTrig:setRGB(0.92, 0.92, 0.92)
	LTrig.GamepadPrompt:setText(Engine[0xF9F1239CFD921FE](0xBA3A27E061CC812))
	LTrig.GamepadPrompt:setAlignment(Enum[0x7A5123B654282D2][0x830CFD395E6AA0A])
	self:addElement(LTrig)
	self.LTrig = LTrig
	local Tabs = CoD.basicTabList_Trigger.new(f1_arg0, f1_arg1, 0, 0, 786, 2514, 0.5, 0.5, -30, 30)
	Tabs.grid:setWidgetType(CoD.CommonTabButton)
	Tabs.grid:setSpacing(0)
	self:addElement(Tabs)
	self.Tabs = Tabs
	local RTrig = CoD.BumperButtonWithKeyMouseText.new(f1_arg0, f1_arg1, 0, 0, 2514, 2714, 0.5, 0.5, -17, 17)
	RTrig:setRGB(0.92, 0.92, 0.92)
	RTrig.GamepadPrompt:setText(Engine[0xF9F1239CFD921FE](0x2B144B0EB22E484))
	self:addElement(RTrig)
	self.RTrig = RTrig
	Tabs.id = "Tabs"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CommonSecondaryTabBar.__resetProperties = function(f2_arg0)
	f2_arg0.RTrig:completeAnimation()
	f2_arg0.LTrig:completeAnimation()
	f2_arg0.Tabs:completeAnimation()
	f2_arg0.RTrig:setAlpha(1)
	f2_arg0.LTrig:setAlpha(1)
	f2_arg0.Tabs:setAlpha(1)
end
CoD.CommonSecondaryTabBar.__clipsPerState = {
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
			f4_arg0.LTrig:completeAnimation()
			f4_arg0.LTrig:setAlpha(0)
			f4_arg0.clipFinished(f4_arg0.LTrig)
			f4_arg0.Tabs:completeAnimation()
			f4_arg0.Tabs:setAlpha(0)
			f4_arg0.clipFinished(f4_arg0.Tabs)
			f4_arg0.RTrig:completeAnimation()
			f4_arg0.RTrig:setAlpha(0)
			f4_arg0.clipFinished(f4_arg0.RTrig)
		end,
	},
}
CoD.CommonSecondaryTabBar.__onClose = function(f5_arg0)
	f5_arg0.LTrig:close()
	f5_arg0.Tabs:close()
	f5_arg0.RTrig:close()
end
