require("x64:37febb2086ad7e7")
require("x64:29187ea00d726c3")
CoD.PC_StartMenu_Options_KeybindMessage_Text = InheritFrom(LUI.UIElement)
CoD.PC_StartMenu_Options_KeybindMessage_Text.__defaultWidth = 200
CoD.PC_StartMenu_Options_KeybindMessage_Text.__defaultHeight = 25
CoD.PC_StartMenu_Options_KeybindMessage_Text.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIHorizontalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 0, true)
	self:setAlignment(LUI.Alignment.Center)
	self:setClass(CoD.PC_StartMenu_Options_KeybindMessage_Text)
	self.id = "PC_StartMenu_Options_KeybindMessage_Text"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Stripes = CoD.PC_StartMenu_Options_KeybindMessage_Stripes.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	Stripes:setAlpha(0.75)
	self:addElement(Stripes)
	self.Stripes = Stripes
	local Icon = LUI.UIImage.new(0, 0, -70, -10, 0.5, 0.5, -30, 30)
	Icon:setImage(RegisterImage(@"uie_success_icon"))
	self:addElement(Icon)
	self.Icon = Icon
	local VerticalListSpacer2 = CoD.VerticalListSpacer.new(f1_arg0, f1_arg1, 0, 0, -10, 10, 0.5, 0.5, -30, 30)
	self:addElement(VerticalListSpacer2)
	self.VerticalListSpacer2 = VerticalListSpacer2
	local KeybindMessage = LUI.UIText.new(0, 0, 10, 210, 0.5, 0.5, -9, 15)
	KeybindMessage:setRGB(0.76, 0.76, 0.76)
	KeybindMessage:setTTF("dinnext_regular")
	KeybindMessage:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_171E049B161CD00A"))
	KeybindMessage:setLetterSpacing(1)
	KeybindMessage:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	KeybindMessage:setBackingType(1)
	KeybindMessage:subscribeToGlobalModel(f1_arg1, "KeybindMessages", "keybindMessage", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			KeybindMessage:setText(f2_local0)
		end
	end)
	self:addElement(KeybindMessage)
	self.KeybindMessage = KeybindMessage
	local RecordMessage = LUI.UIText.new(0, 0, 10, 210, 0.5, 0.5, -9, 15)
	RecordMessage:setRGB(0.76, 0.76, 0.76)
	RecordMessage:setAlpha(0)
	RecordMessage:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_7FDB192EEA5C2466"))
	RecordMessage:setTTF("dinnext_regular")
	RecordMessage:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_171E049B161CD00A"))
	RecordMessage:setLetterSpacing(1)
	RecordMessage:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	RecordMessage:setBackingType(1)
	self:addElement(RecordMessage)
	self.RecordMessage = RecordMessage
	local VerticalListSpacer = CoD.VerticalListSpacer.new(f1_arg0, f1_arg1, 0, 0, 210, 270, 0.5, 0.5, -30, 30)
	self:addElement(VerticalListSpacer)
	self.VerticalListSpacer = VerticalListSpacer
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.PC_StartMenu_Options_KeybindMessage_Text.__resetProperties = function(f3_arg0)
	f3_arg0.Icon:completeAnimation()
	f3_arg0.KeybindMessage:completeAnimation()
	f3_arg0.Stripes:completeAnimation()
	f3_arg0.RecordMessage:completeAnimation()
	f3_arg0.Icon:setRGB(1, 1, 1)
	f3_arg0.Icon:setAlpha(1)
	f3_arg0.Icon:setImage(RegisterImage(@"uie_success_icon"))
	f3_arg0.KeybindMessage:setAlpha(1)
	f3_arg0.Stripes:setRGB(1, 1, 1)
	f3_arg0.Stripes:setAlpha(0.75)
	f3_arg0.RecordMessage:setAlpha(0)
end
CoD.PC_StartMenu_Options_KeybindMessage_Text.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(3)
			f4_arg0.Stripes:completeAnimation()
			f4_arg0.Stripes:setAlpha(0)
			f4_arg0.Stripes:playClip("DefaultClip")
			f4_arg0.clipFinished(f4_arg0.Stripes)
			f4_arg0.Icon:completeAnimation()
			f4_arg0.Icon:setAlpha(0)
			f4_arg0.clipFinished(f4_arg0.Icon)
			f4_arg0.KeybindMessage:completeAnimation()
			f4_arg0.KeybindMessage:setAlpha(0)
			f4_arg0.clipFinished(f4_arg0.KeybindMessage)
		end,
	},
	Error = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(3)
			f5_arg0.Stripes:completeAnimation()
			f5_arg0.Stripes:setRGB(0.96, 0.34, 0.34)
			f5_arg0.Stripes:setAlpha(0.95)
			f5_arg0.Stripes:playClip("DefaultClip")
			f5_arg0.clipFinished(f5_arg0.Stripes)
			f5_arg0.Icon:completeAnimation()
			f5_arg0.Icon:setRGB(0.72, 0.21, 0.21)
			f5_arg0.Icon:setAlpha(1)
			f5_arg0.Icon:setImage(RegisterImage(@"uie_error_icon"))
			f5_arg0.clipFinished(f5_arg0.Icon)
			f5_arg0.KeybindMessage:completeAnimation()
			f5_arg0.KeybindMessage:setAlpha(1)
			f5_arg0.clipFinished(f5_arg0.KeybindMessage)
		end,
	},
	Binding = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(3)
			f6_arg0.Stripes:completeAnimation()
			f6_arg0.Stripes:playClip("DefaultClip")
			f6_arg0.clipFinished(f6_arg0.Stripes)
			f6_arg0.Icon:completeAnimation()
			f6_arg0.Icon:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.Icon)
			f6_arg0.KeybindMessage:completeAnimation()
			f6_arg0.KeybindMessage:setAlpha(1)
			f6_arg0.clipFinished(f6_arg0.KeybindMessage)
		end,
	},
	Success = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(3)
			f7_arg0.Stripes:completeAnimation()
			f7_arg0.Stripes:setRGB(0.68, 0.95, 0.37)
			f7_arg0.Stripes:playClip("DefaultClip")
			f7_arg0.clipFinished(f7_arg0.Stripes)
			f7_arg0.Icon:completeAnimation()
			f7_arg0.Icon:setRGB(0.4, 0.55, 0.22)
			f7_arg0.Icon:setAlpha(1)
			f7_arg0.clipFinished(f7_arg0.Icon)
			f7_arg0.KeybindMessage:completeAnimation()
			f7_arg0.KeybindMessage:setAlpha(1)
			f7_arg0.clipFinished(f7_arg0.KeybindMessage)
		end,
	},
	Warning = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(3)
			f8_arg0.Stripes:completeAnimation()
			f8_arg0.Stripes:setRGB(0.93, 0.78, 0.27)
			f8_arg0.Stripes:playClip("DefaultClip")
			f8_arg0.clipFinished(f8_arg0.Stripes)
			f8_arg0.Icon:completeAnimation()
			f8_arg0.Icon:setRGB(0.85, 0.69, 0.11)
			f8_arg0.Icon:setAlpha(1)
			f8_arg0.Icon:setImage(RegisterImage(@"uie_warning_small"))
			f8_arg0.clipFinished(f8_arg0.Icon)
			f8_arg0.KeybindMessage:completeAnimation()
			f8_arg0.KeybindMessage:setAlpha(1)
			f8_arg0.clipFinished(f8_arg0.KeybindMessage)
		end,
	},
	Recording = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(4)
			f9_arg0.Stripes:completeAnimation()
			f9_arg0.Stripes:setRGB(0.96, 0.34, 0.34)
			f9_arg0.Stripes:setAlpha(0.95)
			f9_arg0.Stripes:playClip("DefaultClip")
			f9_arg0.clipFinished(f9_arg0.Stripes)
			f9_arg0.Icon:completeAnimation()
			f9_arg0.Icon:setRGB(0.72, 0.21, 0.21)
			f9_arg0.Icon:setAlpha(1)
			f9_arg0.Icon:setImage(RegisterImage(@"uie_warning_small"))
			f9_arg0.clipFinished(f9_arg0.Icon)
			f9_arg0.KeybindMessage:completeAnimation()
			f9_arg0.KeybindMessage:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.KeybindMessage)
			f9_arg0.RecordMessage:completeAnimation()
			f9_arg0.RecordMessage:setAlpha(1)
			f9_arg0.clipFinished(f9_arg0.RecordMessage)
		end,
	},
}
CoD.PC_StartMenu_Options_KeybindMessage_Text.__onClose = function(f10_arg0)
	f10_arg0.Stripes:close()
	f10_arg0.VerticalListSpacer2:close()
	f10_arg0.KeybindMessage:close()
	f10_arg0.VerticalListSpacer:close()
end
