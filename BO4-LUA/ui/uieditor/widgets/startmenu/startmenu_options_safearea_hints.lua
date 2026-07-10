require("x64:d019ee604df7ce4")
CoD.StartMenu_Options_SafeArea_Hints = InheritFrom(LUI.UIElement)
CoD.StartMenu_Options_SafeArea_Hints.__defaultWidth = 1920
CoD.StartMenu_Options_SafeArea_Hints.__defaultHeight = 1080
CoD.StartMenu_Options_SafeArea_Hints.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.StartMenu_Options_SafeArea_Hints)
	self.id = "StartMenu_Options_SafeArea_Hints"
	self.soundSet = "ChooseDecal"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local BestResults = LUI.UIText.new(0.5, 0.5, -700, 700, 0.38, 0.38, -15, 15)
	BestResults:setText(Engine[0xF9F1239CFD921FE](0xFFAE216C06B818))
	BestResults:setTTF("dinnext_regular")
	BestResults:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	BestResults:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(BestResults)
	self.BestResults = BestResults
	local AdjustInSoundAndScreen = LUI.UIText.new(0, 0, 0, 1920, 0, 0, 632, 662)
	AdjustInSoundAndScreen:setText(Engine[0xF9F1239CFD921FE](0x37A7998E13FAB88))
	AdjustInSoundAndScreen:setTTF("dinnext_regular")
	AdjustInSoundAndScreen:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	AdjustInSoundAndScreen:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(AdjustInSoundAndScreen)
	self.AdjustInSoundAndScreen = AdjustInSoundAndScreen
	local InstructionText = LUI.UIText.new(0, 1, 0, 0, 0.5, 0.5, -20, 10)
	InstructionText:setText(Engine[0xF9F1239CFD921FE](0x988D4F345D061))
	InstructionText:setTTF("dinnext_regular")
	InstructionText:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	InstructionText:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(InstructionText)
	self.InstructionText = InstructionText
	local HorizontalAdjustment = LUI.UIText.new(0, 1, 0, 0, 0.5, 0.5, 14, 46)
	HorizontalAdjustment:setText(Engine[0xF9F1239CFD921FE](0x89C37DF996CF951))
	HorizontalAdjustment:setTTF("dinnext_regular")
	HorizontalAdjustment:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	HorizontalAdjustment:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(HorizontalAdjustment)
	self.HorizontalAdjustment = HorizontalAdjustment
	local VerticalAdjustment = LUI.UIText.new(0, 1, 0, 0, 0.5, 0.5, 52, 84)
	VerticalAdjustment:setText(Engine[0xF9F1239CFD921FE](0x94BC45B00FCF2F3))
	VerticalAdjustment:setTTF("dinnext_regular")
	VerticalAdjustment:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	VerticalAdjustment:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(VerticalAdjustment)
	self.VerticalAdjustment = VerticalAdjustment
	local SafeAreaAdjustment = LUI.UIText.new(0, 0, 260, 1660, 0, 0, 317, 368)
	SafeAreaAdjustment:setText(Engine[0xF9F1239CFD921FE](0x159E1557183121C))
	SafeAreaAdjustment:setTTF("ttmussels_demibold")
	SafeAreaAdjustment:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	SafeAreaAdjustment:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(SafeAreaAdjustment)
	self.SafeAreaAdjustment = SafeAreaAdjustment
	local ConfirmButtonPrompt = CoD.buttonprompt.new(f1_arg0, f1_arg1, 0, 0, 938, 1082, 0, 0, 706, 752)
	ConfirmButtonPrompt:setScale(2, 2)
	ConfirmButtonPrompt.label:setText(Engine[0xF9F1239CFD921FE](0xEF7CFBE53FD6CD0))
	ConfirmButtonPrompt:subscribeToGlobalModel(f1_arg1, "Controller", "primary_button_image", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			ConfirmButtonPrompt.buttonPromptImage:setImage(RegisterImage(f2_local0))
		end
	end)
	self:addElement(ConfirmButtonPrompt)
	self.ConfirmButtonPrompt = ConfirmButtonPrompt
	local GotItButtonPrompt = CoD.buttonprompt.new(f1_arg0, f1_arg1, 0, 0, 937, 1081, 0, 0, 706, 752)
	GotItButtonPrompt:setScale(2, 2)
	GotItButtonPrompt.label:setText(Engine[0xF9F1239CFD921FE](0x127692C63C00054))
	GotItButtonPrompt:subscribeToGlobalModel(f1_arg1, "Controller", "primary_button_image", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			GotItButtonPrompt.buttonPromptImage:setImage(RegisterImage(f3_local0))
		end
	end)
	self:addElement(GotItButtonPrompt)
	self.GotItButtonPrompt = GotItButtonPrompt
	local DisplayAreaAdjustment = LUI.UIText.new(0, 0, 260, 1660, 0, 0, 317, 368)
	DisplayAreaAdjustment:setText(Engine[0xF9F1239CFD921FE](0x2CCB8DC93E73DA1))
	DisplayAreaAdjustment:setTTF("ttmussels_demibold")
	DisplayAreaAdjustment:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	DisplayAreaAdjustment:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(DisplayAreaAdjustment)
	self.DisplayAreaAdjustment = DisplayAreaAdjustment
	local SettingPS4 = LUI.UIText.new(0, 0, 260, 1660, 0, 0, 519, 549)
	SettingPS4:setText(Engine[0xF9F1239CFD921FE](0x7855C33B39CFA84))
	SettingPS4:setTTF("dinnext_regular")
	SettingPS4:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	SettingPS4:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(SettingPS4)
	self.SettingPS4 = SettingPS4
	self:mergeStateConditions({
		{
			stateName = "Durango",
			condition = function(menu, element, event)
				return IsDurango()
			end,
		},
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.StartMenu_Options_SafeArea_Hints.__resetProperties = function(f5_arg0)
	f5_arg0.SafeAreaAdjustment:completeAnimation()
	f5_arg0.VerticalAdjustment:completeAnimation()
	f5_arg0.HorizontalAdjustment:completeAnimation()
	f5_arg0.InstructionText:completeAnimation()
	f5_arg0.ConfirmButtonPrompt:completeAnimation()
	f5_arg0.AdjustInSoundAndScreen:completeAnimation()
	f5_arg0.SettingPS4:completeAnimation()
	f5_arg0.BestResults:completeAnimation()
	f5_arg0.DisplayAreaAdjustment:completeAnimation()
	f5_arg0.GotItButtonPrompt:completeAnimation()
	f5_arg0.SafeAreaAdjustment:setAlpha(1)
	f5_arg0.VerticalAdjustment:setAlpha(1)
	f5_arg0.HorizontalAdjustment:setAlpha(1)
	f5_arg0.InstructionText:setAlpha(1)
	f5_arg0.ConfirmButtonPrompt:setAlpha(1)
	f5_arg0.AdjustInSoundAndScreen:setAlpha(1)
	f5_arg0.SettingPS4:setAlpha(1)
	f5_arg0.BestResults:setAlpha(1)
	f5_arg0.DisplayAreaAdjustment:setAlpha(1)
	f5_arg0.GotItButtonPrompt:setAlpha(1)
end
CoD.StartMenu_Options_SafeArea_Hints.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(5)
			f6_arg0.InstructionText:completeAnimation()
			f6_arg0.InstructionText:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.InstructionText)
			f6_arg0.HorizontalAdjustment:completeAnimation()
			f6_arg0.HorizontalAdjustment:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.HorizontalAdjustment)
			f6_arg0.VerticalAdjustment:completeAnimation()
			f6_arg0.VerticalAdjustment:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.VerticalAdjustment)
			f6_arg0.SafeAreaAdjustment:completeAnimation()
			f6_arg0.SafeAreaAdjustment:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.SafeAreaAdjustment)
			f6_arg0.ConfirmButtonPrompt:completeAnimation()
			f6_arg0.ConfirmButtonPrompt:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.ConfirmButtonPrompt)
		end,
	},
	Durango = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(5)
			f7_arg0.BestResults:completeAnimation()
			f7_arg0.BestResults:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.BestResults)
			f7_arg0.AdjustInSoundAndScreen:completeAnimation()
			f7_arg0.AdjustInSoundAndScreen:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.AdjustInSoundAndScreen)
			f7_arg0.GotItButtonPrompt:completeAnimation()
			f7_arg0.GotItButtonPrompt:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.GotItButtonPrompt)
			f7_arg0.DisplayAreaAdjustment:completeAnimation()
			f7_arg0.DisplayAreaAdjustment:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.DisplayAreaAdjustment)
			f7_arg0.SettingPS4:completeAnimation()
			f7_arg0.SettingPS4:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.SettingPS4)
		end,
	},
}
CoD.StartMenu_Options_SafeArea_Hints.__onClose = function(f8_arg0)
	f8_arg0.ConfirmButtonPrompt:close()
	f8_arg0.GotItButtonPrompt:close()
end
