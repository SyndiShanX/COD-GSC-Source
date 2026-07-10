require("x64:1394ae5e9cdcb54")
require("x64:aaefcdf6bb981b7")
require("x64:ce7f7f6abb8b87")
CoD.DirectorSelect_Tabbar_Center = InheritFrom(LUI.UIElement)
CoD.DirectorSelect_Tabbar_Center.__defaultWidth = 1200
CoD.DirectorSelect_Tabbar_Center.__defaultHeight = 61
CoD.DirectorSelect_Tabbar_Center.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIHorizontalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, -6, false)
	self:setAlignment(LUI.Alignment.Center)
	self:setClass(CoD.DirectorSelect_Tabbar_Center)
	self.id = "DirectorSelect_Tabbar_Center"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local LB = CoD.BumperButtonWithKeyMouseText.new(f1_arg0, f1_arg1, 0, 0, 167.5, 367.5, 0, 0, 0, 34)
	LB:setRGB(0.66, 0.63, 0.52)
	LB:setAlpha(0.45)
	LB.GamepadPrompt:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_5BDCD5292604F434"))
	LB.GamepadPrompt:setAlignment(Enum[@"luialignment"][@"lui_alignment_right"])
	self:addElement(LB)
	self.LB = LB
	local Tabs = CoD.basicTabList.new(f1_arg0, f1_arg1, 0, 0, 361.5, 838.5, 0, 0, 0, 60)
	Tabs.grid:setWidgetType(CoD.DirectorSelectTextTab)
	Tabs.grid:setHorizontalCount(2)
	Tabs.grid:setSpacing(0)
	self:addElement(Tabs)
	self.Tabs = Tabs
	local RB = CoD.BumperButtonWithKeyMouseText.new(f1_arg0, f1_arg1, 0, 0, 832.5, 1032.5, 0, 0, 0, 34)
	RB:setRGB(0.66, 0.63, 0.52)
	RB:setAlpha(0.45)
	RB.GamepadPrompt:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_5BFED5292621DA9A"))
	self:addElement(RB)
	self.RB = RB
	Tabs.id = "Tabs"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.DirectorSelect_Tabbar_Center.__resetProperties = function(f2_arg0)
	f2_arg0.RB:completeAnimation()
	f2_arg0.LB:completeAnimation()
	f2_arg0.RB:setRGB(0.66, 0.63, 0.52)
	f2_arg0.RB:setAlpha(0.45)
	f2_arg0.LB:setRGB(0.66, 0.63, 0.52)
	f2_arg0.LB:setAlpha(0.45)
end
CoD.DirectorSelect_Tabbar_Center.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(0)
		end,
	},
	DimBumperIcons = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(2)
			f4_arg0.LB:completeAnimation()
			f4_arg0.LB:setRGB(0.5, 0.5, 0.5)
			f4_arg0.LB:setAlpha(0.1)
			f4_arg0.clipFinished(f4_arg0.LB)
			f4_arg0.RB:completeAnimation()
			f4_arg0.RB:setRGB(0.5, 0.5, 0.5)
			f4_arg0.RB:setAlpha(0.1)
			f4_arg0.clipFinished(f4_arg0.RB)
		end,
	},
}
CoD.DirectorSelect_Tabbar_Center.__onClose = function(f5_arg0)
	f5_arg0.LB:close()
	f5_arg0.Tabs:close()
	f5_arg0.RB:close()
end
