require("x64:1394ae5e9cdcb54")
require("x64:ff6e730e9cff499")
CoD.ZMLoadoutPreviewClassTabs = InheritFrom(LUI.UIElement)
CoD.ZMLoadoutPreviewClassTabs.__defaultWidth = 316
CoD.ZMLoadoutPreviewClassTabs.__defaultHeight = 52
CoD.ZMLoadoutPreviewClassTabs.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ZMLoadoutPreviewClassTabs)
	self.id = "ZMLoadoutPreviewClassTabs"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local LB = CoD.BumperButtonWithKeyMouseText.new(f1_arg0, f1_arg1, 0.5, 0.5, -287.5, -87.5, 0, 0, 26, 60)
	LB.GamepadPrompt:setText(Engine[0xF9F1239CFD921FE](0xBDCD5292604F434))
	LB.GamepadPrompt:setAlignment(Enum[0x7A5123B654282D2][0x830CFD395E6AA0A])
	self:addElement(LB)
	self.LB = LB
	local f1_local2 = nil
	f1_local2 = LUI.UIElement.createFake()
	self.customClasssList = f1_local2
	local f1_local3 = nil
	local customClasssListPC = LUI.GridLayout.new(f1_arg0, f1_arg1, false, 0, 0, 0, 0, nil, nil, false, false, false, false)
	customClasssListPC:setLeftRight(0.02, 0.98, 0, 0)
	customClasssListPC:setTopBottom(0.35, 0.64, 22, 22)
	customClasssListPC:setWidgetType(CoD.ZMLoadoutPreviewClassPipPC)
	customClasssListPC:setHorizontalCount(6)
	customClasssListPC:setSpacing(0)
	customClasssListPC:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	customClasssListPC:setStaggeredIntroTime(50)
	customClasssListPC:setDataSource("ChooseClassList")
	customClasssListPC:registerEventHandler("list_active_changed", function(element, event)
		local f2_local0 = nil
		if IsPC() then
			CoD.ZMLoadoutUtility.PreviewBubbleGumPack(element, f1_arg1, f1_arg0)
		end
		return f2_local0
	end)
	LUI.OverrideFunction_CallOriginalFirst(customClasssListPC, "close", function(element)
		if IsPC() then
			CoD.ZMLoadoutUtility.RemovePreviewBumperNavigationPC(self, f1_arg0, element, f1_arg1)
		end
	end)
	customClasssListPC:subscribeToGlobalModel(f1_arg1, "PerController", "selectedZMStory", function(model)
		local f4_local0 = customClasssListPC
		if IsPC() then
			UpdateDataSource(self, f4_local0, f1_arg1)
		end
	end)
	self:addElement(customClasssListPC)
	self.customClasssListPC = customClasssListPC
	local RB = CoD.BumperButtonWithKeyMouseText.new(f1_arg0, f1_arg1, 0.5, 0.5, 87.5, 287.5, 0, 0, 26, 60)
	RB.GamepadPrompt:setText(Engine[0xF9F1239CFD921FE](0xBFED5292621DA9A))
	self:addElement(RB)
	self.RB = RB
	self:mergeStateConditions({
		{
			stateName = "IsPC",
			condition = function(menu, element, event)
				return IsPC()
			end,
		},
	})
	f1_local2.id = "customClasssList"
	customClasssListPC.id = "customClasssListPC"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PreLoadFunc then
		PreLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local6 = self
	f1_local6 = f1_local2
	if not IsPC() then
		CoD.GridAndListUtility.AddBumperNavigation(f1_arg0, f1_local6, f1_arg1)
	end
	f1_local6 = customClasssListPC
	if IsPC() then
		CoD.ZMLoadoutUtility.AddPreviewBumperNavigationPC(self, f1_arg0, f1_local6, f1_arg1)
	end
	return self
end
CoD.ZMLoadoutPreviewClassTabs.__resetProperties = function(f6_arg0)
	f6_arg0.RB:completeAnimation()
	f6_arg0.LB:completeAnimation()
	f6_arg0.RB:setLeftRight(0.5, 0.5, 87.5, 287.5)
	f6_arg0.RB:setTopBottom(0, 0, 26, 60)
	f6_arg0.RB:setScale(1, 1)
	f6_arg0.LB:setLeftRight(0.5, 0.5, -287.5, -87.5)
	f6_arg0.LB:setTopBottom(0, 0, 26, 60)
	f6_arg0.LB:setScale(1, 1)
end
CoD.ZMLoadoutPreviewClassTabs.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(0)
		end,
	},
	IsPC = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(2)
			f8_arg0.LB:completeAnimation()
			f8_arg0.LB:setLeftRight(0.5, 0.5, -276, -76)
			f8_arg0.LB:setTopBottom(0.5, 0.94, 4, 4)
			f8_arg0.LB:setScale(0.78, 0.78)
			f8_arg0.clipFinished(f8_arg0.LB)
			f8_arg0.RB:completeAnimation()
			f8_arg0.RB:setLeftRight(0.5, 0.5, 74, 274)
			f8_arg0.RB:setTopBottom(0.5, 1, 4, 4)
			f8_arg0.RB:setScale(0.78, 0.78)
			f8_arg0.clipFinished(f8_arg0.RB)
		end,
	},
}
CoD.ZMLoadoutPreviewClassTabs.__onClose = function(f9_arg0)
	f9_arg0.LB:close()
	f9_arg0.customClasssList:close()
	f9_arg0.customClasssListPC:close()
	f9_arg0.RB:close()
end
