require("x64:b1264dcdcf2dd99")
require("x64:be779d5e87238aa")
require("x64:91ee3f5c466ea3a")
CoD.systemOverlay_Prestige = InheritFrom(LUI.UIElement)
CoD.systemOverlay_Prestige.__defaultWidth = 1920
CoD.systemOverlay_Prestige.__defaultHeight = 480
CoD.systemOverlay_Prestige.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	MenuHidesFreeCursor(f1_arg0, f1_arg1)
	self:setClass(CoD.systemOverlay_Prestige)
	self.id = "systemOverlay_Prestige"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local MainImage = LUI.UIFixedAspectRatioImage.new(0.5, 0.5, -884.5, -524.5, 0, 0, 55, 415)
	MainImage:setStretchedDimension(6)
	MainImage:linkToElementModel(self, "image", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			MainImage:setImage(CoD.BaseUtility.AlreadyRegisteredIfUserData(f2_local0))
		end
	end)
	self:addElement(MainImage)
	self.MainImage = MainImage
	local MainText = LUI.UIText.new(0.5, 0.5, -919.5, -489.5, 0, 0, 422, 459)
	MainText:setTTF("ttmussels_demibold")
	MainText:setLetterSpacing(4)
	MainText:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	MainText:setAlignment(Enum[0x7A5123B654282D2][0xE821F0ECFF8D1C7])
	MainText:linkToElementModel(self, "prestigeItemName", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			MainText:setText(LocalizeToUpperString(f3_local0))
		end
	end)
	self:addElement(MainText)
	self.MainText = MainText
	local Title = LUI.UIText.new(0.5, 0.5, -360.5, 156.5, 0, 0, 10, 55)
	Title:setRGB(ColorSet.T8__BEIGE__HEADER.r, ColorSet.T8__BEIGE__HEADER.g, ColorSet.T8__BEIGE__HEADER.b)
	Title:setTTF("ttmussels_demibold")
	Title:setLetterSpacing(6)
	Title:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	Title:linkToElementModel(self, "title", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			Title:setText(ConvertToUpperString(f4_local0))
		end
	end)
	self:addElement(Title)
	self.Title = Title
	local Subtitle = LUI.UIText.new(0.5, 0.5, -358, 159, 0, 0, 55, 79)
	Subtitle:setRGB(ColorSet.T8__BEIGE__HEADER.r, ColorSet.T8__BEIGE__HEADER.g, ColorSet.T8__BEIGE__HEADER.b)
	Subtitle:setTTF("ttmussels_demibold")
	Subtitle:setLetterSpacing(6)
	Subtitle:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	Subtitle:linkToElementModel(self, "subtitle", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			Subtitle:setText(ConvertToUpperString(f5_local0))
		end
	end)
	self:addElement(Subtitle)
	self.Subtitle = Subtitle
	local text = LUI.UIText.new(0.5, 0.5, -358, 182, 0, 0, 86, 104)
	text:setRGB(0.92, 0.92, 0.92)
	text:setTTF("notosans_regular")
	text:setLetterSpacing(1)
	text:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	text:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	text:linkToElementModel(self, "description", true, function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			text:setText(f6_local0)
		end
	end)
	LUI.OverrideFunction_CallOriginalFirst(text, "setText", function(element, controller)
		UpdateWidgetHeightToMultilineTextWithMinimum(self, element, 0, 20)
	end)
	self:addElement(text)
	self.text = text
	local options = LUI.UIList.new(f1_arg0, f1_arg1, 4, 0, nil, true, false, false, false)
	options:setLeftRight(0.5, 0.5, -361, 18)
	options:setTopBottom(0, 0, 278, 402)
	options:setAutoScaleContent(true)
	options:setWidgetType(CoD.featureOverlay_Button)
	options:setVerticalCount(2)
	options:setSpacing(4)
	options:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	options:linkToElementModel(self, "listDatasource", true, function(model)
		local f8_local0 = model:get()
		if f8_local0 ~= nil then
			options:setDataSource(f8_local0)
		end
	end)
	options:linkToElementModel(options, "disabled", true, function(model, f9_arg1)
		CoD.Menu.UpdateButtonShownState(f9_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end)
	options:registerEventHandler("gain_focus", function(element, event)
		local f10_local0 = nil
		if element.gainFocus then
			f10_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f10_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f10_local0
	end)
	f1_arg0:AddButtonCallbackFunction(options, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], "ui_confirm", function(element, menu, controller, model)
		if not IsDisabled(element, controller) then
			ProcessListAction(self, element, controller, menu)
			return true
		else
		end
	end, function(element, menu, controller)
		if not IsDisabled(element, controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, "ui_confirm")
			return true
		else
			return false
		end
	end, false)
	self:addElement(options)
	self.options = options
	local RewardImageCallingCard = CoD.systemOverlay_PrestigeRewards.new(f1_arg0, f1_arg1, 0.5, 0.5, 365, 882, 0, 0, 55, 359)
	self:addElement(RewardImageCallingCard)
	self.RewardImageCallingCard = RewardImageCallingCard
	local WarningText = LUI.UIText.new(0.5, 0.5, -358, 182, 0, 0, 231.5, 249.5)
	WarningText:setRGB(ColorSet.Orange.r, ColorSet.Orange.g, ColorSet.Orange.b)
	WarningText:setTTF("dinnext_regular")
	WarningText:setLetterSpacing(1)
	WarningText:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	WarningText:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	WarningText:linkToElementModel(self, "supportText", true, function(model)
		local f13_local0 = model:get()
		if f13_local0 ~= nil then
			WarningText:setText(Engine[0xF9F1239CFD921FE](f13_local0))
		end
	end)
	self:addElement(WarningText)
	self.WarningText = WarningText
	local PermanentUnlockTokenButton = CoD.Prestige_PlayerLevelButton.new(f1_arg0, f1_arg1, 0.5, 0.5, 365, 711, 0, 0, 31.5, 88.5)
	PermanentUnlockTokenButton:mergeStateConditions({
		{
			stateName = "UnlockTokenIndicator",
			condition = function(menu, element, event)
				return AlwaysTrue()
			end,
		},
	})
	PermanentUnlockTokenButton:setAlpha(0)
	PermanentUnlockTokenButton.CommonButtonOutlineThin.ButtonIcon:setImage(RegisterImage(0x5DB5170C4871157))
	PermanentUnlockTokenButton:subscribeToGlobalModel(f1_arg1, "PerController", "permanentUnlockTokensCount", function(model)
		local f15_local0 = model:get()
		if f15_local0 ~= nil then
			PermanentUnlockTokenButton.CommonButtonOutlineThin.CountText:setText(f15_local0)
		end
	end)
	PermanentUnlockTokenButton:subscribeToGlobalModel(f1_arg1, "PerController", "permanentUnlockTokensCount", function(model)
		local f16_local0 = model:get()
		if f16_local0 ~= nil then
			PermanentUnlockTokenButton.CommonButtonOutlineThin.MainText:setText(ToUpper(GetPermanentUnlockTokenText(f1_arg1, f16_local0)))
		end
	end)
	self:addElement(PermanentUnlockTokenButton)
	self.PermanentUnlockTokenButton = PermanentUnlockTokenButton
	self:mergeStateConditions({
		{
			stateName = "NoRewards",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, f1_arg1, "prestigeLayout", CoD.PrestigeUtility.PrestigeOverlayLayouts.NoReward)
			end,
		},
		{
			stateName = "FreshStart",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, f1_arg1, "prestigeLayout", CoD.PrestigeUtility.PrestigeOverlayLayouts.FreshStart)
			end,
		},
		{
			stateName = "TokenUnlock",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, f1_arg1, "prestigeLayout", CoD.PrestigeUtility.PrestigeOverlayLayouts.TokenUnlock)
			end,
		},
		{
			stateName = "RequestProcessing",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, f1_arg1, "prestigeLayout", CoD.PrestigeUtility.PrestigeOverlayLayouts.RequestProcessing)
			end,
		},
	})
	self:linkToElementModel(self, "prestigeLayout", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "prestigeLayout",
		})
	end)
	LUI.OverrideFunction_CallOriginalFirst(self, "close", function(element)
		MenuUnhideFreeCursor(f1_arg0, f1_arg1)
	end)
	options.id = "options"
	RewardImageCallingCard.id = "RewardImageCallingCard"
	PermanentUnlockTokenButton.id = "PermanentUnlockTokenButton"
	self.__defaultFocus = options
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.systemOverlay_Prestige.__resetProperties = function(f23_arg0)
	f23_arg0.RewardImageCallingCard:completeAnimation()
	f23_arg0.WarningText:completeAnimation()
	f23_arg0.PermanentUnlockTokenButton:completeAnimation()
	f23_arg0.MainText:completeAnimation()
	f23_arg0.text:completeAnimation()
	f23_arg0.Subtitle:completeAnimation()
	f23_arg0.Title:completeAnimation()
	f23_arg0.MainImage:completeAnimation()
	f23_arg0.RewardImageCallingCard:setAlpha(1)
	f23_arg0.WarningText:setAlpha(1)
	f23_arg0.PermanentUnlockTokenButton:setAlpha(0)
	f23_arg0.MainText:setAlpha(1)
	f23_arg0.text:setAlpha(1)
	f23_arg0.Subtitle:setTopBottom(0, 0, 55, 79)
	f23_arg0.Subtitle:setAlpha(1)
	f23_arg0.Title:setTopBottom(0, 0, 10, 55)
	f23_arg0.Title:setAlpha(1)
	f23_arg0.MainImage:setAlpha(1)
end
CoD.systemOverlay_Prestige.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f24_arg0, f24_arg1)
			f24_arg0:__resetProperties()
			f24_arg0:setupElementClipCounter(0)
		end,
	},
	NoRewards = {
		DefaultClip = function(f25_arg0, f25_arg1)
			f25_arg0:__resetProperties()
			f25_arg0:setupElementClipCounter(3)
			f25_arg0.RewardImageCallingCard:completeAnimation()
			f25_arg0.RewardImageCallingCard:setAlpha(0)
			f25_arg0.clipFinished(f25_arg0.RewardImageCallingCard)
			f25_arg0.WarningText:completeAnimation()
			f25_arg0.WarningText:setAlpha(0)
			f25_arg0.clipFinished(f25_arg0.WarningText)
			f25_arg0.PermanentUnlockTokenButton:completeAnimation()
			f25_arg0.PermanentUnlockTokenButton:setAlpha(0)
			f25_arg0.clipFinished(f25_arg0.PermanentUnlockTokenButton)
		end,
	},
	FreshStart = {
		DefaultClip = function(f26_arg0, f26_arg1)
			f26_arg0:__resetProperties()
			f26_arg0:setupElementClipCounter(4)
			f26_arg0.MainText:completeAnimation()
			f26_arg0.MainText:setAlpha(0)
			f26_arg0.clipFinished(f26_arg0.MainText)
			f26_arg0.RewardImageCallingCard:completeAnimation()
			f26_arg0.RewardImageCallingCard:setAlpha(0)
			f26_arg0.clipFinished(f26_arg0.RewardImageCallingCard)
			f26_arg0.WarningText:completeAnimation()
			f26_arg0.WarningText:setAlpha(1)
			f26_arg0.clipFinished(f26_arg0.WarningText)
			f26_arg0.PermanentUnlockTokenButton:completeAnimation()
			f26_arg0.PermanentUnlockTokenButton:setAlpha(0)
			f26_arg0.clipFinished(f26_arg0.PermanentUnlockTokenButton)
		end,
	},
	TokenUnlock = {
		DefaultClip = function(f27_arg0, f27_arg1)
			f27_arg0:__resetProperties()
			f27_arg0:setupElementClipCounter(3)
			f27_arg0.RewardImageCallingCard:completeAnimation()
			f27_arg0.RewardImageCallingCard:setAlpha(0)
			f27_arg0.clipFinished(f27_arg0.RewardImageCallingCard)
			f27_arg0.WarningText:completeAnimation()
			f27_arg0.WarningText:setAlpha(0)
			f27_arg0.clipFinished(f27_arg0.WarningText)
			f27_arg0.PermanentUnlockTokenButton:completeAnimation()
			f27_arg0.PermanentUnlockTokenButton:setAlpha(1)
			f27_arg0.clipFinished(f27_arg0.PermanentUnlockTokenButton)
		end,
	},
	RequestProcessing = {
		DefaultClip = function(f28_arg0, f28_arg1)
			f28_arg0:__resetProperties()
			f28_arg0:setupElementClipCounter(7)
			f28_arg0.MainImage:completeAnimation()
			f28_arg0.MainImage:setAlpha(0)
			f28_arg0.clipFinished(f28_arg0.MainImage)
			f28_arg0.MainText:completeAnimation()
			f28_arg0.MainText:setAlpha(0)
			f28_arg0.clipFinished(f28_arg0.MainText)
			f28_arg0.Title:completeAnimation()
			f28_arg0.Title:setTopBottom(0, 0, 189.5, 234.5)
			f28_arg0.Title:setAlpha(1)
			f28_arg0.clipFinished(f28_arg0.Title)
			f28_arg0.Subtitle:completeAnimation()
			f28_arg0.Subtitle:setTopBottom(0, 0, 234.5, 258.5)
			f28_arg0.Subtitle:setAlpha(1)
			f28_arg0.clipFinished(f28_arg0.Subtitle)
			f28_arg0.text:completeAnimation()
			f28_arg0.text:setAlpha(0)
			f28_arg0.clipFinished(f28_arg0.text)
			f28_arg0.RewardImageCallingCard:completeAnimation()
			f28_arg0.RewardImageCallingCard:setAlpha(0)
			f28_arg0.clipFinished(f28_arg0.RewardImageCallingCard)
			f28_arg0.WarningText:completeAnimation()
			f28_arg0.WarningText:setAlpha(0)
			f28_arg0.clipFinished(f28_arg0.WarningText)
		end,
	},
}
CoD.systemOverlay_Prestige.__onClose = function(f29_arg0)
	f29_arg0.MainImage:close()
	f29_arg0.MainText:close()
	f29_arg0.Title:close()
	f29_arg0.Subtitle:close()
	f29_arg0.text:close()
	f29_arg0.options:close()
	f29_arg0.RewardImageCallingCard:close()
	f29_arg0.WarningText:close()
	f29_arg0.PermanentUnlockTokenButton:close()
end
