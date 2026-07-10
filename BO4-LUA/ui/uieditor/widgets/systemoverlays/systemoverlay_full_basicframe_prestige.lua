require("x64:be779d5e87238aa")
CoD.systemOverlay_Full_BasicFrame_Prestige = InheritFrom(LUI.UIElement)
CoD.systemOverlay_Full_BasicFrame_Prestige.__defaultWidth = 1920
CoD.systemOverlay_Full_BasicFrame_Prestige.__defaultHeight = 480
CoD.systemOverlay_Full_BasicFrame_Prestige.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.systemOverlay_Full_BasicFrame_Prestige)
	self.id = "systemOverlay_Full_BasicFrame_Prestige"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local NoiseTiledBacking = LUI.UIImage.new(0, 0, 41, 494, 0, 0, 29, 429)
	NoiseTiledBacking:setAlpha(0.5)
	NoiseTiledBacking:setImage(RegisterImage(0x34839E8065B1E53))
	NoiseTiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	NoiseTiledBacking:setShaderVector(0, 0, 0, 0, 0)
	NoiseTiledBacking:setupNineSliceShader(196, 88)
	self:addElement(NoiseTiledBacking)
	self.NoiseTiledBacking = NoiseTiledBacking
	local GridTiled = LUI.UIImage.new(0, 0, 43, 492, 0, 0, 30, 287)
	GridTiled:setAlpha(0.05)
	GridTiled:setScale(1.01, 1.01)
	GridTiled:setImage(RegisterImage(0xCA386792563DE8))
	GridTiled:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	GridTiled:setShaderVector(0, 0, 0, 0, 0)
	GridTiled:setupNineSliceShader(64, 64)
	self:addElement(GridTiled)
	self.GridTiled = GridTiled
	local PixelGridTiledBacking = LUI.UIImage.new(0, 0, 41, 494, 0, 0, 287, 319)
	PixelGridTiledBacking:setAlpha(0.15)
	PixelGridTiledBacking:setImage(RegisterImage(0x311E811A3183347))
	PixelGridTiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	PixelGridTiledBacking:setShaderVector(0, 0, 0, 0, 0)
	PixelGridTiledBacking:setupNineSliceShader(128, 128)
	self:addElement(PixelGridTiledBacking)
	self.PixelGridTiledBacking = PixelGridTiledBacking
	local PixelGridTiledBacking2 = LUI.UIImage.new(0, 0, 584, 1880, 0, 0, 28, 74)
	PixelGridTiledBacking2:setAlpha(0.15)
	PixelGridTiledBacking2:setImage(RegisterImage(0x311E811A3183347))
	PixelGridTiledBacking2:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	PixelGridTiledBacking2:setShaderVector(0, 0, 0, 0, 0)
	PixelGridTiledBacking2:setupNineSliceShader(128, 128)
	self:addElement(PixelGridTiledBacking2)
	self.PixelGridTiledBacking2 = PixelGridTiledBacking2
	local Divider = LUI.UIImage.new(0, 0, 584, 589, 0, 0, 28, 74)
	Divider:setRGB(ColorSet.PlayerYellow.r, ColorSet.PlayerYellow.g, ColorSet.PlayerYellow.b)
	self:addElement(Divider)
	self.Divider = Divider
	local Title = LUI.UIText.new(0, 0, 602, 1352, 0, 0, 30.5, 75.5)
	Title:setRGB(ColorSet.T8__BEIGE__HEADER.r, ColorSet.T8__BEIGE__HEADER.g, ColorSet.T8__BEIGE__HEADER.b)
	Title:setTTF("ttmussels_demibold")
	Title:setLetterSpacing(6)
	Title:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	Title:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	Title:linkToElementModel(self, "title", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			Title:setText(Engine[0xF9F1239CFD921FE](f2_local0))
		end
	end)
	self:addElement(Title)
	self.Title = Title
	local Description = LUI.UIText.new(0, 0, 603, 1665, 0, 0, 84, 102)
	Description:setTTF("dinnext_regular")
	Description:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	Description:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	Description:linkToElementModel(self, "description", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			Description:setText(f3_local0)
		end
	end)
	self:addElement(Description)
	self.Description = Description
	local OptionList = LUI.UIList.new(f1_arg0, f1_arg1, 10, 0, nil, true, false, false, false)
	OptionList:setLeftRight(0.5, 0.5, -361, 169)
	OptionList:setTopBottom(0, 0, 264, 394)
	OptionList:setAutoScaleContent(true)
	OptionList:setWidgetType(CoD.featureOverlay_Button)
	OptionList:setVerticalCount(2)
	OptionList:setSpacing(10)
	OptionList:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	OptionList:linkToElementModel(self, "listDatasource", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			OptionList:setDataSource(f4_local0)
		end
	end)
	OptionList:registerEventHandler("gain_focus", function(element, event)
		local f5_local0 = nil
		if element.gainFocus then
			f5_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f5_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f5_local0
	end)
	f1_arg0:AddButtonCallbackFunction(OptionList, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], "ui_confirm", function(element, menu, controller, model)
		ProcessListAction(self, element, controller, menu)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, "ui_confirm")
		return true
	end, false)
	self:addElement(OptionList)
	self.OptionList = OptionList
	local WeaponImage = LUI.UIFixedAspectRatioImage.new(0, 0, 139, 395, 0, 0, 112, 246)
	WeaponImage:linkToElementModel(self, "weaponImage", true, function(model)
		local f8_local0 = model:get()
		if f8_local0 ~= nil then
			WeaponImage:setImage(RegisterImage(f8_local0))
		end
	end)
	self:addElement(WeaponImage)
	self.WeaponImage = WeaponImage
	local WeaponName = LUI.UIText.new(0, 0, 83.5, 450.5, 0, 0, 44.5, 80.5)
	WeaponName:setRGB(ColorSet.T8__BEIGE__HEADER.r, ColorSet.T8__BEIGE__HEADER.g, ColorSet.T8__BEIGE__HEADER.b)
	WeaponName:setTTF("ttmussels_demibold")
	WeaponName:setLetterSpacing(6)
	WeaponName:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	WeaponName:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	WeaponName:linkToElementModel(self, "weaponName", true, function(model)
		local f9_local0 = model:get()
		if f9_local0 ~= nil then
			WeaponName:setText(ToUpper(f9_local0))
		end
	end)
	self:addElement(WeaponName)
	self.WeaponName = WeaponName
	local RewardTitle = LUI.UIText.new(0, 0, 48, 248, 0, 0, 290, 317)
	RewardTitle:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	RewardTitle:setText(ToUpper(LocalizeString(0xA41F147063A78BA)))
	RewardTitle:setTTF("ttmussels_regular")
	RewardTitle:setLetterSpacing(4)
	RewardTitle:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	RewardTitle:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(RewardTitle)
	self.RewardTitle = RewardTitle
	local WeaponPrestigeRewardIcon = LUI.UIFixedAspectRatioImage.new(0, 0, 107, 173, 0, 0, 342, 408)
	WeaponPrestigeRewardIcon:linkToElementModel(self, "weaponPrestigeRewardIcon", true, function(model)
		local f10_local0 = model:get()
		if f10_local0 ~= nil then
			WeaponPrestigeRewardIcon:setImage(RegisterImage(f10_local0))
		end
	end)
	self:addElement(WeaponPrestigeRewardIcon)
	self.WeaponPrestigeRewardIcon = WeaponPrestigeRewardIcon
	local WeaponPrestigeReward = LUI.UIText.new(0, 0, 180.5, 426.5, 0, 0, 348, 373)
	WeaponPrestigeReward:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	WeaponPrestigeReward:setTTF("ttmussels_demibold")
	WeaponPrestigeReward:setLetterSpacing(2)
	WeaponPrestigeReward:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	WeaponPrestigeReward:setAlignment(Enum[0x7A5123B654282D2][0xE821F0ECFF8D1C7])
	WeaponPrestigeReward:linkToElementModel(self, "weaponPrestigeReward", true, function(model)
		local f11_local0 = model:get()
		if f11_local0 ~= nil then
			WeaponPrestigeReward:setText(ToUpper(LocalizeString(f11_local0)))
		end
	end)
	self:addElement(WeaponPrestigeReward)
	self.WeaponPrestigeReward = WeaponPrestigeReward
	local WeaponPrestigeRewardPreview = LUI.UIText.new(0, 0, 180.5, 426.5, 0, 0, 378, 401)
	WeaponPrestigeRewardPreview:setRGB(ColorSet.PlayerYellow.r, ColorSet.PlayerYellow.g, ColorSet.PlayerYellow.b)
	WeaponPrestigeRewardPreview:setTTF("ttmussels_regular")
	WeaponPrestigeRewardPreview:setLetterSpacing(4)
	WeaponPrestigeRewardPreview:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	WeaponPrestigeRewardPreview:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	WeaponPrestigeRewardPreview:linkToElementModel(self, "weaponPrestigeRewardPreview", true, function(model)
		local f12_local0 = model:get()
		if f12_local0 ~= nil then
			WeaponPrestigeRewardPreview:setText(StringAsClanTag(f12_local0))
		end
	end)
	self:addElement(WeaponPrestigeRewardPreview)
	self.WeaponPrestigeRewardPreview = WeaponPrestigeRewardPreview
	local Line = LUI.UIImage.new(0, 0, 41, 494, 0, 0, 319, 320)
	Line:setAlpha(0.2)
	self:addElement(Line)
	self.Line = Line
	local PrestigeStar1 = LUI.UIImage.new(0, 0, 553.5, 578.5, 0, 0, 38.5, 63.5)
	PrestigeStar1:setRGB(ColorSet.PlayerYellow.r, ColorSet.PlayerYellow.g, ColorSet.PlayerYellow.b)
	PrestigeStar1:setImage(RegisterImage(0xB94BBEF24882247))
	self:addElement(PrestigeStar1)
	self.PrestigeStar1 = PrestigeStar1
	local PrestigeStar2 = LUI.UIImage.new(0, 0, 523.5, 548.5, 0, 0, 38.5, 63.5)
	PrestigeStar2:setRGB(ColorSet.PlayerYellow.r, ColorSet.PlayerYellow.g, ColorSet.PlayerYellow.b)
	PrestigeStar2:setImage(RegisterImage(0xB94BBEF24882247))
	self:addElement(PrestigeStar2)
	self.PrestigeStar2 = PrestigeStar2
	local optionTextBracketR = LUI.UIImage.new(0.5, 0.5, -463, -451, 0.5, 0.5, -17, -5)
	optionTextBracketR:setAlpha(0.5)
	optionTextBracketR:setImage(RegisterImage(0x34B555F15CDD010))
	optionTextBracketR:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	optionTextBracketR:setShaderVector(0, 3, 0, 0, 0)
	self:addElement(optionTextBracketR)
	self.optionTextBracketR = optionTextBracketR
	local optionTextBracketL = LUI.UIImage.new(0.5, 0.5, -935, -923, 0.5, 0.5, -17, -5)
	optionTextBracketL:setAlpha(0.5)
	optionTextBracketL:setZRot(180)
	optionTextBracketL:setImage(RegisterImage(0x34B555F15CDD010))
	optionTextBracketL:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	optionTextBracketL:setShaderVector(0, 3, 0, 0, 0)
	self:addElement(optionTextBracketL)
	self.optionTextBracketL = optionTextBracketL
	local cornerBracket = LUI.UIImage.new(0, 0, 35, 47, 0, 0, 23, 35)
	cornerBracket:setAlpha(0.5)
	cornerBracket:setZRot(180)
	cornerBracket:setImage(RegisterImage(0x535662F512D5F90))
	cornerBracket:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(cornerBracket)
	self.cornerBracket = cornerBracket
	local cornerBracket4 = LUI.UIImage.new(0, 0, 35, 47, 0, 0, 423, 435)
	cornerBracket4:setAlpha(0.5)
	cornerBracket4:setZRot(270)
	cornerBracket4:setImage(RegisterImage(0x535662F512D5F90))
	cornerBracket4:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(cornerBracket4)
	self.cornerBracket4 = cornerBracket4
	local cornerBracket2 = LUI.UIImage.new(0, 0, 488, 500, 0, 0, 23, 35)
	cornerBracket2:setAlpha(0.5)
	cornerBracket2:setZRot(90)
	cornerBracket2:setImage(RegisterImage(0x535662F512D5F90))
	cornerBracket2:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(cornerBracket2)
	self.cornerBracket2 = cornerBracket2
	local cornerBracket3 = LUI.UIImage.new(0, 0, 488, 500, 0, 0, 423, 435)
	cornerBracket3:setAlpha(0.5)
	cornerBracket3:setImage(RegisterImage(0x535662F512D5F90))
	cornerBracket3:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(cornerBracket3)
	self.cornerBracket3 = cornerBracket3
	local BottomBracket9Slice = LUI.UIImage.new(0, 0, 1853, 1908, 0, 0, 46.5, 55.5)
	BottomBracket9Slice:setAlpha(0.2)
	BottomBracket9Slice:setZRot(90)
	BottomBracket9Slice:setImage(RegisterImage(0xC325BED3F226657))
	BottomBracket9Slice:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD777557404A7B3))
	BottomBracket9Slice:setShaderVector(0, 0, 0, 0, 0)
	BottomBracket9Slice:setupNineSliceShader(16, 4)
	self:addElement(BottomBracket9Slice)
	self.BottomBracket9Slice = BottomBracket9Slice
	self:mergeStateConditions({
		{
			stateName = "SecondPrestigeState",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "weaponPrestigeLevel", 2)
			end,
		},
	})
	self:linkToElementModel(self, "weaponPrestigeLevel", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "weaponPrestigeLevel",
		})
	end)
	OptionList.id = "OptionList"
	self.__defaultFocus = OptionList
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local25 = self
	HideWidget(PrestigeStar2)
	return self
end
CoD.systemOverlay_Full_BasicFrame_Prestige.__resetProperties = function(f15_arg0)
	f15_arg0.PrestigeStar2:completeAnimation()
	f15_arg0.PrestigeStar2:setAlpha(1)
end
CoD.systemOverlay_Full_BasicFrame_Prestige.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(1)
			f16_arg0.PrestigeStar2:completeAnimation()
			f16_arg0.PrestigeStar2:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.PrestigeStar2)
		end,
	},
	SecondPrestigeState = {
		DefaultClip = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(1)
			f17_arg0.PrestigeStar2:completeAnimation()
			f17_arg0.PrestigeStar2:setAlpha(1)
			f17_arg0.clipFinished(f17_arg0.PrestigeStar2)
		end,
	},
}
CoD.systemOverlay_Full_BasicFrame_Prestige.__onClose = function(f18_arg0)
	f18_arg0.Title:close()
	f18_arg0.Description:close()
	f18_arg0.OptionList:close()
	f18_arg0.WeaponImage:close()
	f18_arg0.WeaponName:close()
	f18_arg0.WeaponPrestigeRewardIcon:close()
	f18_arg0.WeaponPrestigeReward:close()
	f18_arg0.WeaponPrestigeRewardPreview:close()
	f18_arg0.PrestigeStar2:close()
end
