require("x64:1128ed000805fc9")
require("x64:ce1e6b6549d478c")
require("x64:2cf4ad39ea2c548")
require("x64:95553e1dbf377f6")
require("x64:74865184d366449")
require("x64:a9255c570c68aa8")
CoD.ReservesSpecialContractMenu = InheritFrom(CoD.Menu)
LUI.createMenu.ReservesSpecialContractMenu = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("ReservesSpecialContractMenu", f1_arg0)
	local f1_local1 = self
	CoD.BaseUtility.SetModelFromUserData(f1_arg0, f1_local1, f1_arg1._model)
	self:setClass(CoD.ReservesSpecialContractMenu)
	self.soundSet = "none"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	local ItemShopBackgroundBlur = CoD.ItemShopBackgroundBlur.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	ItemShopBackgroundBlur:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	self:addElement(ItemShopBackgroundBlur)
	self.ItemShopBackgroundBlur = ItemShopBackgroundBlur
	local FooterContainerFrontendRight = CoD.FooterContainer_Frontend_Right.new(f1_local1, f1_arg0, 0, 1, 0, 0, 1, 1, -48, 0)
	FooterContainerFrontendRight:registerEventHandler("menu_loaded", function(element, event)
		local f3_local0 = nil
		if element.menuLoaded then
			f3_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f3_local0 = element.super:menuLoaded(event)
		end
		if not IsPC() then
			SizeToSafeArea(element, f1_arg0)
		end
		if not f3_local0 then
			f3_local0 = element:dispatchEventToChildren(event)
		end
		return f3_local0
	end)
	self:addElement(FooterContainerFrontendRight)
	self.FooterContainerFrontendRight = FooterContainerFrontendRight
	local ProgressBar = CoD.ReservesSpecialContractProgressBar.new(f1_local1, f1_arg0, 0.5, 0.5, -245, 355, 0.5, 0.5, 342, 360)
	ProgressBar:mergeStateConditions({
		{
			stateName = "Complete",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(self, f1_arg0, "complete")
			end,
		},
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	ProgressBar:linkToElementModel(ProgressBar, "complete", true, function(model)
		f1_local1:updateElementState(ProgressBar, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = model:get(),
			modelName = "complete",
		})
	end)
	ProgressBar:setScale(2, 2)
	ProgressBar.Progress:setImage(RegisterImage(0x6D2FBF31F53910C))
	ProgressBar.ProgressGlow:setImage(RegisterImage(0xA7D61A3302B55D0))
	ProgressBar:linkToElementModel(self, "progress", true, function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			ProgressBar.Progress:setShaderVector(0, CoD.GetVectorComponentFromString(f7_local0, 1), CoD.GetVectorComponentFromString(f7_local0, 2), CoD.GetVectorComponentFromString(f7_local0, 3), CoD.GetVectorComponentFromString(f7_local0, 4))
		end
	end)
	ProgressBar:linkToElementModel(self, "progress", true, function(model)
		local f8_local0 = model:get()
		if f8_local0 ~= nil then
			ProgressBar.ProgressGlow:setShaderVector(0, CoD.GetVectorComponentFromString(f8_local0, 1), CoD.GetVectorComponentFromString(f8_local0, 2), CoD.GetVectorComponentFromString(f8_local0, 3), CoD.GetVectorComponentFromString(f8_local0, 4))
		end
	end)
	ProgressBar:linkToElementModel(self, "endValue", true, function(model)
		local f9_local0 = model:get()
		if f9_local0 ~= nil then
			ProgressBar.ProgressFraction:setText(f9_local0)
		end
	end)
	self:addElement(ProgressBar)
	self.ProgressBar = ProgressBar
	local Title = LUI.UIText.new(0.5, 0.5, -600, 600, 0.5, 0.5, -429.5, -375.5)
	Title:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	Title:setTTF("ttmussels_demibold")
	Title:setLetterSpacing(4)
	Title:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	Title:setAlignment(Enum[0x7A5123B654282D2][0xE821F0ECFF8D1C7])
	Title:linkToElementModel(self, "categoryString", true, function(model)
		local f10_local0 = model:get()
		if f10_local0 ~= nil then
			Title:setText(ToUpper(CoD.BlackMarketUtility.ReservesSpecialContractAppendCompletion(self:getModel(), f10_local0)))
		end
	end)
	self:addElement(Title)
	self.Title = Title
	local Description = LUI.UIText.new(0.5, 0.5, -600, 600, 0.5, 0.5, -372.5, -347.5)
	Description:setRGB(ColorSet.T8__OFF__GRAY.r, ColorSet.T8__OFF__GRAY.g, ColorSet.T8__OFF__GRAY.b)
	Description:setTTF("ttmussels_regular")
	Description:setLetterSpacing(2)
	Description:setLineSpacing(1)
	Description:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	Description:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	Description:linkToElementModel(self, "detailsMenuDesc", true, function(model)
		local f11_local0 = model:get()
		if f11_local0 ~= nil then
			Description:setText(f11_local0)
		end
	end)
	self:addElement(Description)
	self.Description = Description
	local RewardName = LUI.UIText.new(0.5, 0.5, -600, 600, 0.5, 0.5, -232.5, -195.5)
	RewardName:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	RewardName:setTTF("ttmussels_demibold")
	RewardName:setLetterSpacing(8)
	RewardName:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	RewardName:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	RewardName:linkToElementModel(self, "rewardName", true, function(model)
		local f12_local0 = model:get()
		if f12_local0 ~= nil then
			RewardName:setText(LocalizeToUpperString(f12_local0))
		end
	end)
	self:addElement(RewardName)
	self.RewardName = RewardName
	local GoalType = LUI.UIText.new(0.5, 0.5, -600, 600, 0.5, 0.5, 270.5, 295.5)
	GoalType:setRGB(ColorSet.T8__OFF__GRAY.r, ColorSet.T8__OFF__GRAY.g, ColorSet.T8__OFF__GRAY.b)
	GoalType:setTTF("ttmussels_regular")
	GoalType:setLetterSpacing(2)
	GoalType:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	GoalType:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	GoalType:linkToElementModel(self, "detailsMenuGoalType", true, function(model)
		local f13_local0 = model:get()
		if f13_local0 ~= nil then
			GoalType:setText(Engine[0xF9F1239CFD921FE](f13_local0))
		end
	end)
	self:addElement(GoalType)
	self.GoalType = GoalType
	local GoalString = LUI.UIText.new(0.5, 0.5, -600, 600, 0.5, 0.5, 301, 337)
	GoalString:setRGB(ColorSet.T8__DARK__GOLD.r, ColorSet.T8__DARK__GOLD.g, ColorSet.T8__DARK__GOLD.b)
	GoalString:setTTF("ttmussels_demibold")
	GoalString:setLetterSpacing(4)
	GoalString:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	GoalString:setAlignment(Enum[0x7A5123B654282D2][0xE821F0ECFF8D1C7])
	GoalString:linkToElementModel(self, "endValuePlusUnits", true, function(model)
		local f14_local0 = model:get()
		if f14_local0 ~= nil then
			GoalString:setText(f14_local0)
		end
	end)
	self:addElement(GoalString)
	self.GoalString = GoalString
	local Backing = LUI.UIImage.new(0.5, 0.5, -397.5, 397.5, 0.5, 0.5, -176, 193)
	Backing:setRGB(0.92, 0.92, 0.92)
	Backing:setAlpha(0.02)
	self:addElement(Backing)
	self.Backing = Backing
	local Gradient = LUI.UIImage.new(0.5, 0.5, -397.5, 397.5, 0.5, 0.5, -176, 193)
	Gradient:setAlpha(0.01)
	Gradient:setImage(RegisterImage(0xCA43165960A9EAA))
	self:addElement(Gradient)
	self.Gradient = Gradient
	local RewardImage = LUI.UIFixedAspectRatioImage.new(0.5, 0.5, -128, 128, 0.5, 0.5, -118, 138)
	RewardImage:linkToElementModel(self, "detailsMenuRewardImage", true, function(model)
		local f15_local0 = model:get()
		if f15_local0 ~= nil then
			RewardImage:setImage(RegisterImage(f15_local0))
		end
	end)
	self:addElement(RewardImage)
	self.RewardImage = RewardImage
	local PlusTR = LUI.UIImage.new(0.5, 0.5, 337, 369, 0.5, 0.5, -149, -117)
	PlusTR:setAlpha(0.02)
	PlusTR:setScale(0.8, 0.8)
	PlusTR:setImage(RegisterImage(0x1ACA8BD7BB22ADB))
	PlusTR:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(PlusTR)
	self.PlusTR = PlusTR
	local PlusBR = LUI.UIImage.new(0.5, 0.5, 337, 369, 0.5, 0.5, 134, 166)
	PlusBR:setAlpha(0.02)
	PlusBR:setScale(0.8, 0.8)
	PlusBR:setImage(RegisterImage(0x1ACA8BD7BB22ADB))
	PlusBR:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(PlusBR)
	self.PlusBR = PlusBR
	local PlusTL = LUI.UIImage.new(0.5, 0.5, -368, -336, 0.5, 0.5, -149, -117)
	PlusTL:setAlpha(0.02)
	PlusTL:setScale(0.8, 0.8)
	PlusTL:setImage(RegisterImage(0x1ACA8BD7BB22ADB))
	PlusTL:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(PlusTL)
	self.PlusTL = PlusTL
	local PlusBL = LUI.UIImage.new(0.5, 0.5, -368, -336, 0.5, 0.5, 134, 166)
	PlusBL:setAlpha(0.02)
	PlusBL:setScale(0.8, 0.8)
	PlusBL:setImage(RegisterImage(0x1ACA8BD7BB22ADB))
	PlusBL:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(PlusBL)
	self.PlusBL = PlusBL
	local AmbientDiagonalBarBot = CoD.AARPlayerReward_DiagonalHeaderInternal.new(f1_local1, f1_arg0, 0.5, 0.5, -398, 215, 0.5, 0.5, 192, 200)
	AmbientDiagonalBarBot:setAlpha(0.3)
	self:addElement(AmbientDiagonalBarBot)
	self.AmbientDiagonalBarBot = AmbientDiagonalBarBot
	local AmbientBarBaseBot = LUI.UIImage.new(0.5, 0.5, 217.5, 397.5, 0.5, 0.5, 193, 199)
	AmbientBarBaseBot:setRGB(0.38, 0.38, 0.38)
	AmbientBarBaseBot:setAlpha(0.1)
	self:addElement(AmbientBarBaseBot)
	self.AmbientBarBaseBot = AmbientBarBaseBot
	local LineBaseBOT = CoD.StartMenuOptionsMainFrame.new(f1_local1, f1_arg0, 0.5, 0.5, -398, 215, 0.5, 0.5, 193, 199)
	LineBaseBOT:setAlpha(0.02)
	self:addElement(LineBaseBOT)
	self.LineBaseBOT = LineBaseBOT
	local infoBracketBot = LUI.UIImage.new(0.5, 0.5, -398.5, 398.5, 0.5, 0.5, 186, 194)
	infoBracketBot:setAlpha(0.6)
	infoBracketBot:setImage(RegisterImage(0xC325BED3F226657))
	infoBracketBot:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD777557404A7B3))
	infoBracketBot:setShaderVector(0, 0, 0, 0, 0)
	infoBracketBot:setupNineSliceShader(16, 4)
	self:addElement(infoBracketBot)
	self.infoBracketBot = infoBracketBot
	local infoBracketTop = LUI.UIImage.new(0.5, 0.5, -398.5, 399.5, 0.5, 0.5, -180, -148)
	infoBracketTop:setAlpha(0.6)
	infoBracketTop:setImage(RegisterImage(0xCAD52FFFB7C32C1))
	infoBracketTop:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD777557404A7B3))
	infoBracketTop:setShaderVector(0, 0, 0, 0, 0)
	infoBracketTop:setupNineSliceShader(10, 16)
	self:addElement(infoBracketTop)
	self.infoBracketTop = infoBracketTop
	local AmbientTopRepeatBar = LUI.UIImage.new(0.5, 0.5, -400.5, 213.5, 0.5, 0.5, -192, -176)
	AmbientTopRepeatBar:setImage(RegisterImage(0xC9793C8F59B834E))
	AmbientTopRepeatBar:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD777557404A7B3))
	AmbientTopRepeatBar:setShaderVector(0, 0, 0, 0, 0)
	AmbientTopRepeatBar:setupNineSliceShader(23, 16)
	self:addElement(AmbientTopRepeatBar)
	self.AmbientTopRepeatBar = AmbientTopRepeatBar
	local AmbientTopBar = LUI.UIImage.new(0.5, 0.5, 214.5, 402.5, 0.5, 0.5, -194, -174)
	AmbientTopBar:setImage(RegisterImage(0x8C511B26DCEEE3E))
	AmbientTopBar:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(AmbientTopBar)
	self.AmbientTopBar = AmbientTopBar
	local LayoutElement02 = CoD.CommonBgLayoutElement02.new(f1_local1, f1_arg0, 0.5, 0.5, 98.5, 402.5, 0.5, 0.5, 123, 199)
	LayoutElement02:setAlpha(0.5)
	LayoutElement02:setScale(0.25, 0.25)
	self:addElement(LayoutElement02)
	self.LayoutElement02 = LayoutElement02
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], nil, function(element, menu, controller, model)
		GoBack(self, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], 0x70A9FDC87CD3D48, nil, nil)
		return true
	end, false)
	FooterContainerFrontendRight:setModel(self.buttonModel, f1_arg0)
	if CoD.isPC then
		FooterContainerFrontendRight.id = "FooterContainerFrontendRight"
	end
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	return self
end
CoD.ReservesSpecialContractMenu.__onClose = function(f18_arg0)
	f18_arg0.ItemShopBackgroundBlur:close()
	f18_arg0.FooterContainerFrontendRight:close()
	f18_arg0.ProgressBar:close()
	f18_arg0.Title:close()
	f18_arg0.Description:close()
	f18_arg0.RewardName:close()
	f18_arg0.GoalType:close()
	f18_arg0.GoalString:close()
	f18_arg0.RewardImage:close()
	f18_arg0.AmbientDiagonalBarBot:close()
	f18_arg0.LineBaseBOT:close()
	f18_arg0.LayoutElement02:close()
end
