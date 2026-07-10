require("x64:c13ed5fbec79763")
CoD.PCVoiceChatWidget = InheritFrom(LUI.UIElement)
CoD.PCVoiceChatWidget.__defaultWidth = 430
CoD.PCVoiceChatWidget.__defaultHeight = 100
CoD.PCVoiceChatWidget.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PCVoiceChatWidget)
	self.id = "PCVoiceChatWidget"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Image = LUI.UIImage.new(0, 0, 8, 419, 0, 0, 26, 73)
	Image:setRGB(0, 0, 0)
	Image:setAlpha(0.5)
	self:addElement(Image)
	self.Image = Image
	local ButtonList2 = LUI.UIList.new(f1_arg0, f1_arg1, 40, 0, nil, false, false, false, false)
	ButtonList2:setLeftRight(0, 0, -50, 480)
	ButtonList2:setTopBottom(0, 0, 20, 80)
	ButtonList2:setScale(0.78, 0.78)
	ButtonList2:setWidgetType(CoD.Social_Options_SliderNarrow)
	ButtonList2:setSpacing(40)
	ButtonList2:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	ButtonList2:setDataSource("PartyVoiceChatControl")
	ButtonList2:registerEventHandler("gain_focus", function(element, event)
		local f2_local0 = nil
		if element.gainFocus then
			f2_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f2_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f2_local0
	end)
	f1_arg0:AddButtonCallbackFunction(ButtonList2, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], "ui_confirm", function(element, menu, controller, model)
		if HasProperty(element, "action") then
			ProcessListAction(self, element, controller, menu)
			return true
		else
		end
	end, function(element, menu, controller)
		if HasProperty(element, "action") then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, "ui_confirm")
			return true
		else
			return false
		end
	end, false)
	self:addElement(ButtonList2)
	self.ButtonList2 = ButtonList2
	self:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return IsPC()
			end,
		},
	})
	ButtonList2.id = "ButtonList2"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.PCVoiceChatWidget.__onClose = function(f6_arg0)
	f6_arg0.ButtonList2:close()
end
