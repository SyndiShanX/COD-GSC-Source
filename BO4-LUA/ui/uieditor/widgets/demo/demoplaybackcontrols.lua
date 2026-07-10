require("x64:71cd64e828f536")
require("x64:abd9d2111472f07")
require("x64:2260fedb8a3a02f")
CoD.DemoPlaybackControls = InheritFrom(LUI.UIElement)
CoD.DemoPlaybackControls.__defaultWidth = 750
CoD.DemoPlaybackControls.__defaultHeight = 176
CoD.DemoPlaybackControls.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.DemoPlaybackControls)
	self.id = "DemoPlaybackControls"
	self.soundSet = "HUD"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local FrameBackground = CoD.DemoPlaybackControlsBackground.new(f1_arg0, f1_arg1, 0.5, 0.5, -480, 480, 0.5, 0.5, -88, 88)
	FrameBackground:setScale(0.8, 0.8)
	self:addElement(FrameBackground)
	self.FrameBackground = FrameBackground
	local TimLineBacking = LUI.UIImage.new(0.5, 0.5, -293, 293, 0, 0, 20.5, 47.5)
	TimLineBacking:setRGB(0, 0, 0)
	TimLineBacking:setAlpha(0.7)
	self:addElement(TimLineBacking)
	self.TimLineBacking = TimLineBacking
	local Timeline = LUI.UIElement.new(0.5, 0.5, -293, 293, 0, 0, 27, 41)
	Timeline:setAlpha(0.5)
	Timeline:setupDemoTimeline()
	self:addElement(Timeline)
	self.Timeline = Timeline
	local f1_local4 = nil
	self.ButtonPrompt = LUI.UIElement.createFake()
	local ButtonPromptPC = nil
	ButtonPromptPC = CoD.DemoButtonPrompt.new(f1_arg0, f1_arg1, 0.5, 0.5, -131, 131, 0, 0, 137, 167)
	ButtonPromptPC.label:setScale(0.85, 0.85)
	ButtonPromptPC.label:setText(LocalizeString(0x3EE76DC3EE23FA2))
	ButtonPromptPC.KBMlabel:setText(Engine[0xF9F1239CFD921FE](0x5F062F5AEAAA492))
	ButtonPromptPC:subscribeToGlobalModel(f1_arg1, "Controller", "left_stick_button_image", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			ButtonPromptPC.buttonPromptImage:setImage(RegisterImage(f2_local0))
		end
	end)
	self:addElement(ButtonPromptPC)
	self.ButtonPromptPC = ButtonPromptPC
	local ButtonList = LUI.UIList.new(f1_arg0, f1_arg1, 12, 0, nil, false, false, false, false)
	ButtonList:setLeftRight(0.5, 0.5, -294, 294)
	ButtonList:setTopBottom(0, 0, 53, 129)
	ButtonList:setWidgetType(CoD.DemoControlsButton)
	ButtonList:setHorizontalCount(12)
	ButtonList:setSpacing(12)
	ButtonList:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	ButtonList:setDataSource("DemoControlsButtons")
	ButtonList:appendEventHandler("input_source_changed", function(f3_arg0, f3_arg1)
		f3_arg1.menu = f3_arg1.menu or f1_arg0
		CoD.Menu.UpdateButtonShownState(f3_arg0, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end)
	local f1_local7 = ButtonList
	local f1_local8 = ButtonList.subscribeToModel
	local f1_local9 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local8(f1_local7, f1_local9.LastInput, function(f4_arg0, f4_arg1)
		CoD.Menu.UpdateButtonShownState(f4_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	ButtonList:registerEventHandler("gain_focus", function(element, event)
		local f5_local0 = nil
		if element.gainFocus then
			f5_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f5_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f5_local0
	end)
	f1_arg0:AddButtonCallbackFunction(ButtonList, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], "ui_confirm", function(element, menu, controller, model)
		if IsMouseOrKeyboard(controller) then
			ProcessListAction(self, element, controller, menu)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsMouseOrKeyboard(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x0, nil, "ui_confirm")
			return false
		else
			return false
		end
	end, false)
	self:addElement(ButtonList)
	self.ButtonList = ButtonList
	self:mergeStateConditions({
		{
			stateName = "ScoreboardOpen",
			condition = function(menu, element, event)
				return Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xF4EDA8B636F3F04])
			end,
		},
	})
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local8(f1_local7, f1_local9["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xF4EDA8B636F3F04]], function(f9_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f9_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xF4EDA8B636F3F04],
		})
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(self, "setState", function(element, controller, f10_arg2, f10_arg3, f10_arg4)
		if IsSelfInState(self, "DefaultState") then
			SetFocusToSelf(self, controller)
		end
	end)
	ButtonList.id = "ButtonList"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PreLoadFunc then
		PreLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local8 = self
	if IsPC() then
		CoD.HUDUtility.SetUseCylinderMapping(f1_local8, false)
	end
	return self
end
CoD.DemoPlaybackControls.__resetProperties = function(f11_arg0)
	f11_arg0.ButtonList:completeAnimation()
	f11_arg0.ButtonPromptPC:completeAnimation()
	f11_arg0.ButtonPrompt:completeAnimation()
	f11_arg0.Timeline:completeAnimation()
	f11_arg0.TimLineBacking:completeAnimation()
	f11_arg0.ButtonList:setAlpha(1)
	f11_arg0.ButtonPromptPC:setAlpha(1)
	f11_arg0.ButtonPrompt:setAlpha(1)
	f11_arg0.Timeline:setAlpha(0.5)
	f11_arg0.TimLineBacking:setAlpha(0.7)
end
CoD.DemoPlaybackControls.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(0)
		end,
	},
	ScoreboardOpen = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(4)
			f13_arg0.TimLineBacking:completeAnimation()
			f13_arg0.TimLineBacking:setAlpha(0.5)
			f13_arg0.clipFinished(f13_arg0.TimLineBacking)
			f13_arg0.Timeline:completeAnimation()
			f13_arg0.Timeline:setAlpha(0.5)
			f13_arg0.clipFinished(f13_arg0.Timeline)
			f13_arg0.ButtonPrompt:completeAnimation()
			f13_arg0.ButtonPrompt:setAlpha(0.5)
			f13_arg0.clipFinished(f13_arg0.ButtonPrompt)
			f13_arg0.ButtonPromptPC:completeAnimation()
			f13_arg0.ButtonPromptPC:setAlpha(0.5)
			f13_arg0.clipFinished(f13_arg0.ButtonPromptPC)
			f13_arg0.ButtonList:completeAnimation()
			f13_arg0.ButtonList:setAlpha(0.5)
			f13_arg0.clipFinished(f13_arg0.ButtonList)
		end,
	},
}
CoD.DemoPlaybackControls.__onClose = function(f14_arg0)
	f14_arg0.FrameBackground:close()
	f14_arg0.ButtonPrompt:close()
	f14_arg0.ButtonPromptPC:close()
	f14_arg0.ButtonList:close()
end
