require("x64:2675595fa323085")
require("x64:cef42fd3249a6be")
require("x64:edfe9269a474224")
require("x64:55aca670e9903a3")
CoD.StartMenu_Options_PC_Voice_VoiceBar = InheritFrom(LUI.UIElement)
CoD.StartMenu_Options_PC_Voice_VoiceBar.__defaultWidth = 675
CoD.StartMenu_Options_PC_Voice_VoiceBar.__defaultHeight = 70
CoD.StartMenu_Options_PC_Voice_VoiceBar.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	InitDataSourceModel(f1_arg1, "SpeakingEnergy")
	CoD.PCOptionsUtility.SetVoiceDvars()
	self:setClass(CoD.StartMenu_Options_PC_Voice_VoiceBar)
	self.id = "StartMenu_Options_PC_Voice_VoiceBar"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Maximum = LUI.UIText.new(0.5, 0.5, 211.5, 336.5, 0.5, 0.5, 12.5, 27.5)
	Maximum:setRGB(0.76, 0.76, 0.76)
	Maximum:setAlpha(0.44)
	Maximum:setText(LocalizeToUpperString(0x4EF66575DDB929))
	Maximum:setTTF("dinnext_regular")
	Maximum:setLetterSpacing(1)
	Maximum:setAlignment(Enum[@"luialignment"][@"lui_alignment_right"])
	self:addElement(Maximum)
	self.Maximum = Maximum
	local OverflowIndicator1 = LUI.UIImage.new(0.5, 0.5, 342.5, 347.5, 0.5, 0.5, -3, 5)
	OverflowIndicator1:setRGB(0.68, 0.14, 0.1)
	self:addElement(OverflowIndicator1)
	self.OverflowIndicator1 = OverflowIndicator1
	local OverflowIndicator2 = LUI.UIImage.new(0.5, 0.5, 351.5, 356.5, 0.5, 0.5, -3, 5)
	OverflowIndicator2:setRGB(0.68, 0.14, 0.1)
	self:addElement(OverflowIndicator2)
	self.OverflowIndicator2 = OverflowIndicator2
	local OverflowIndicator3 = LUI.UIImage.new(0.5, 0.5, 360.5, 365.5, 0.5, 0.5, -3, 5)
	OverflowIndicator3:setRGB(0.68, 0.14, 0.1)
	self:addElement(OverflowIndicator3)
	self.OverflowIndicator3 = OverflowIndicator3
	local OverflowIndicator4 = LUI.UIImage.new(0.5, 0.5, 337.5, 367.5, 0.5, 0.5, -34, -4)
	OverflowIndicator4:setRGB(0.76, 0.76, 0.76)
	OverflowIndicator4:setAlpha(0.44)
	OverflowIndicator4:setImage(RegisterImage(@"uie_warning_small"))
	self:addElement(OverflowIndicator4)
	self.OverflowIndicator4 = OverflowIndicator4
	local TextBox = LUI.UIText.new(0.5, 0.5, -252.5, 171.5, 0.5, 0.5, -23.5, -6.5)
	TextBox:setRGB(0.76, 0.76, 0.76)
	TextBox:setAlpha(0.6)
	TextBox:setText(LocalizeToUpperString(@"hash_554E2339D1B444AD"))
	TextBox:setTTF("dinnext_regular")
	TextBox:setLetterSpacing(1)
	TextBox:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	TextBox:setAlignment(Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"])
	self:addElement(TextBox)
	self.TextBox = TextBox
	local TooltipFocus = CoD.emptyFocusable.new(f1_arg0, f1_arg1, 0, 0, 0, 366, 0, 0, 0, 62)
	TooltipFocus:subscribeToGlobalModel(f1_arg1, "PerController", "CurrentOptionTab", function(model)
		local f2_local0 = TooltipFocus
		if not CoD.PCOptionsUtility.IsGraphicsOptions(f1_arg1) then
			MakeNotFocusable(f2_local0, f1_arg1)
		elseif CoD.PCOptionsUtility.IsGraphicsOptions(f1_arg1) then
			MakeFocusable(f2_local0, f1_arg1)
		end
	end)
	self:addElement(TooltipFocus)
	self.TooltipFocus = TooltipFocus
	local DynamicBar = CoD.StartMenu_Options_PC_Voice_VoiceBar_Bar.new(f1_arg0, f1_arg1, 0.5, 0.5, -250.5, 336.5, 0.5, 0.5, -3, 5)
	self:addElement(DynamicBar)
	self.DynamicBar = DynamicBar
	local Corners = CoD.StartMenuOptionsMainCorners.new(f1_arg0, f1_arg1, 0.5, 0.5, -250.5, 336.5, 0.5, 0.5, -3, 5)
	Corners:setAlpha(0.5)
	self:addElement(Corners)
	self.Corners = Corners
	local MicImage = LUI.UIImage.new(0.5, 0.5, -299, -247, 0.5, 0.5, -26, 26)
	MicImage:setRGB(0.76, 0.76, 0.76)
	MicImage:setAlpha(0.8)
	MicImage:setImage(RegisterImage(@"uie_mic"))
	self:addElement(MicImage)
	self.MicImage = MicImage
	local GenericSimpleButton = CoD.StartMenu_Options_PC_Voice_VoiceBar_RecordButton.new(f1_arg0, f1_arg1, 0.5, 0.5, -337.5, -295.5, 0.5, 0.5, -21, 21)
	local f1_local12 = GenericSimpleButton
	local f1_local13 = GenericSimpleButton.subscribeToModel
	local f1_local14 = Engine[@"getglobalmodel"]()
	f1_local13(f1_local12, f1_local14["SpeakingEnergy.isRecording"], function(f3_arg0, f3_arg1)
		CoD.Menu.UpdateButtonShownState(f3_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	GenericSimpleButton:registerEventHandler("gain_focus", function(element, event)
		local f4_local0 = nil
		if element.gainFocus then
			f4_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f4_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f4_local0
	end)
	f1_arg0:AddButtonCallbackFunction(GenericSimpleButton, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function(element, menu, controller, model)
		if not CoD.PCOptionsUtility.IsRecordingLoopBack(controller) then
			CoD.PCOptionsUtility.StartLoopBackCalibrationRecording(controller)
			return true
		else
			CoD.PCOptionsUtility.StopLoopBackCalibrationRecording(controller)
			return true
		end
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_0", nil, "ui_confirm")
		return false
	end, false)
	self:addElement(GenericSimpleButton)
	self.GenericSimpleButton = GenericSimpleButton
	self:subscribeToGlobalModel(f1_arg1, "GlobalModel", "SpeakingEnergy.displayText", function(model)
		local f7_local0 = self
		CoD.PCOptionsUtility.UpdateVoiceBar(f1_arg1, self, model)
	end)
	TooltipFocus.id = "TooltipFocus"
	GenericSimpleButton.id = "GenericSimpleButton"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local13 = self
	f1_local13 = TooltipFocus
	CoD.PCWidgetUtility.SetupEmptyFocusableTooltip(f1_local13, f1_arg1, @"hash_5CCC02F6B5D8DCE1", 0xA669610927190D)
	DisableKeyboardNavigationByElement(f1_local13)
	return self
end
CoD.StartMenu_Options_PC_Voice_VoiceBar.__resetProperties = function(f8_arg0)
	f8_arg0.OverflowIndicator4:completeAnimation()
	f8_arg0.OverflowIndicator3:completeAnimation()
	f8_arg0.OverflowIndicator2:completeAnimation()
	f8_arg0.OverflowIndicator1:completeAnimation()
	f8_arg0.DynamicBar:completeAnimation()
	f8_arg0.Maximum:completeAnimation()
	f8_arg0.TextBox:completeAnimation()
	f8_arg0.Corners:completeAnimation()
	f8_arg0.GenericSimpleButton:completeAnimation()
	f8_arg0.MicImage:completeAnimation()
	f8_arg0.OverflowIndicator4:setRGB(0.76, 0.76, 0.76)
	f8_arg0.OverflowIndicator4:setAlpha(0.44)
	f8_arg0.OverflowIndicator3:setAlpha(1)
	f8_arg0.OverflowIndicator2:setAlpha(1)
	f8_arg0.OverflowIndicator1:setAlpha(1)
	f8_arg0.DynamicBar:setRGB(1, 1, 1)
	f8_arg0.DynamicBar:setAlpha(1)
	f8_arg0.Maximum:setAlpha(0.44)
	f8_arg0.TextBox:setAlpha(0.6)
	f8_arg0.Corners:setAlpha(0.5)
	f8_arg0.GenericSimpleButton:setAlpha(1)
	f8_arg0.MicImage:setAlpha(0.8)
end
CoD.StartMenu_Options_PC_Voice_VoiceBar.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(5)
			f9_arg0.OverflowIndicator1:completeAnimation()
			f9_arg0.OverflowIndicator1:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.OverflowIndicator1)
			f9_arg0.OverflowIndicator2:completeAnimation()
			f9_arg0.OverflowIndicator2:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.OverflowIndicator2)
			f9_arg0.OverflowIndicator3:completeAnimation()
			f9_arg0.OverflowIndicator3:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.OverflowIndicator3)
			f9_arg0.OverflowIndicator4:completeAnimation()
			f9_arg0.OverflowIndicator4:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.OverflowIndicator4)
			f9_arg0.DynamicBar:completeAnimation()
			f9_arg0.DynamicBar:setRGB(1, 1, 1)
			f9_arg0.clipFinished(f9_arg0.DynamicBar)
		end,
	},
	Hidden = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(10)
			f10_arg0.Maximum:completeAnimation()
			f10_arg0.Maximum:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.Maximum)
			f10_arg0.OverflowIndicator1:completeAnimation()
			f10_arg0.OverflowIndicator1:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.OverflowIndicator1)
			f10_arg0.OverflowIndicator2:completeAnimation()
			f10_arg0.OverflowIndicator2:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.OverflowIndicator2)
			f10_arg0.OverflowIndicator3:completeAnimation()
			f10_arg0.OverflowIndicator3:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.OverflowIndicator3)
			f10_arg0.OverflowIndicator4:completeAnimation()
			f10_arg0.OverflowIndicator4:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.OverflowIndicator4)
			f10_arg0.TextBox:completeAnimation()
			f10_arg0.TextBox:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.TextBox)
			f10_arg0.DynamicBar:completeAnimation()
			f10_arg0.DynamicBar:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.DynamicBar)
			f10_arg0.Corners:completeAnimation()
			f10_arg0.Corners:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.Corners)
			f10_arg0.MicImage:completeAnimation()
			f10_arg0.MicImage:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.MicImage)
			f10_arg0.GenericSimpleButton:completeAnimation()
			f10_arg0.GenericSimpleButton:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.GenericSimpleButton)
		end,
	},
	Overflow = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(2)
			local f11_local0 = function(f12_arg0)
				local f12_local0 = function(f13_arg0)
					f13_arg0:beginAnimation(280)
					f13_arg0:setRGB(0.76, 0.76, 0.76)
					f13_arg0:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
				end
				f11_arg0.OverflowIndicator4:beginAnimation(220)
				f11_arg0.OverflowIndicator4:setRGB(1, 0, 0)
				f11_arg0.OverflowIndicator4:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.OverflowIndicator4:registerEventHandler("transition_complete_keyframe", f12_local0)
			end
			f11_arg0.OverflowIndicator4:completeAnimation()
			f11_arg0.OverflowIndicator4:setRGB(0.76, 0.76, 0.76)
			f11_local0(f11_arg0.OverflowIndicator4)
			f11_arg0.DynamicBar:completeAnimation()
			f11_arg0.DynamicBar:setRGB(1, 0, 0)
			f11_arg0.clipFinished(f11_arg0.DynamicBar)
			f11_arg0.nextClip = "DefaultClip"
		end,
	},
	OverRecommended = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(4)
			f14_arg0.OverflowIndicator1:completeAnimation()
			f14_arg0.OverflowIndicator1:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.OverflowIndicator1)
			f14_arg0.OverflowIndicator2:completeAnimation()
			f14_arg0.OverflowIndicator2:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.OverflowIndicator2)
			f14_arg0.OverflowIndicator3:completeAnimation()
			f14_arg0.OverflowIndicator3:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.OverflowIndicator3)
			f14_arg0.OverflowIndicator4:completeAnimation()
			f14_arg0.OverflowIndicator4:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.OverflowIndicator4)
		end,
	},
}
CoD.StartMenu_Options_PC_Voice_VoiceBar.__onClose = function(f15_arg0)
	f15_arg0.TooltipFocus:close()
	f15_arg0.DynamicBar:close()
	f15_arg0.Corners:close()
	f15_arg0.GenericSimpleButton:close()
end
