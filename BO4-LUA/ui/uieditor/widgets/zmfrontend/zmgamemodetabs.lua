require("x64:1394ae5e9cdcb54")
require("x64:aaefcdf6bb981b7")
CoD.ZMGameModeTabs = InheritFrom(LUI.UIElement)
CoD.ZMGameModeTabs.__defaultWidth = 3300
CoD.ZMGameModeTabs.__defaultHeight = 61
CoD.ZMGameModeTabs.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIHorizontalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 4, false)
	self:setAlignment(LUI.Alignment.Center)
	self:setClass(CoD.ZMGameModeTabs)
	self.id = "ZMGameModeTabs"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local LB = CoD.BumperButtonWithKeyMouseText.new(f1_arg0, f1_arg1, 0, 0, 936, 1136, 0, 0, 17, 51)
	LB.GamepadPrompt:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_5BDCD5292604F434"))
	LB.GamepadPrompt:setAlignment(Enum[@"luialignment"][@"lui_alignment_right"])
	self:addElement(LB)
	self.LB = LB
	local customClasssList = LUI.GridLayout.new(f1_arg0, f1_arg1, false, 0, 0, 0, 0, nil, nil, false, false, false, false)
	customClasssList:setLeftRight(0.5, 0.5, -510, 894)
	customClasssList:setTopBottom(0, 0, 17, 51)
	customClasssList:setWidgetType(CoD.DirectorSelectTextTab)
	customClasssList:setHorizontalCount(6)
	customClasssList:setSpacing(0)
	customClasssList:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	customClasssList:setStaggeredIntroTime(50)
	customClasssList:setDataSource("DirectorPlaylistGameTypeList")
	customClasssList:registerEventHandler("list_active_changed", function(element, event)
		local f2_local0 = nil
		if not IsLobbyNetworkModeLAN() then
			CoD.ZombieUtility.PlaylistTabSelected(self, element, f1_arg1)
		elseif IsLobbyNetworkModeLAN() then
			GameModeSelected(element, f1_arg1)
			CoD.DirectorUtility.SetDefaultGameTypeDifficulty(f1_arg1, element)
		elseif IsMenuInState(f1_arg0, "movedleft") then
			PlaySoundAlias("uin_list_horizontal_generic")
		elseif IsMenuInState(f1_arg0, "movedright") then
			PlaySoundAlias("uin_list_horizontal_generic")
		end
		return f2_local0
	end)
	self:addElement(customClasssList)
	self.customClasssList = customClasssList
	local RB = CoD.BumperButtonWithKeyMouseText.new(f1_arg0, f1_arg1, 0, 0, 2164, 2364, 0, 0, 17, 51)
	RB.GamepadPrompt:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_5BFED5292621DA9A"))
	self:addElement(RB)
	self.RB = RB
	customClasssList.id = "customClasssList"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local4 = self
	CoD.GridAndListUtility.AddBumperNavigation(f1_arg0, customClasssList, f1_arg1)
	return self
end
CoD.ZMGameModeTabs.__resetProperties = function(f3_arg0)
	f3_arg0.RB:completeAnimation()
	f3_arg0.LB:completeAnimation()
	f3_arg0.RB:setAlpha(1)
	f3_arg0.LB:setAlpha(1)
end
CoD.ZMGameModeTabs.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(0)
		end,
	},
	Hidden = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(2)
			f5_arg0.LB:completeAnimation()
			f5_arg0.LB:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.LB)
			f5_arg0.RB:completeAnimation()
			f5_arg0.RB:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.RB)
		end,
	},
}
CoD.ZMGameModeTabs.__onClose = function(f6_arg0)
	f6_arg0.LB:close()
	f6_arg0.customClasssList:close()
	f6_arg0.RB:close()
end
