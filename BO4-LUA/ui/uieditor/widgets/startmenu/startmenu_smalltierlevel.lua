require("ui/uieditor/widgets/loottierboostpercentcontraband")
require("ui/uieditor/widgets/startmenu/startmenu_smalltierboostnotification")
CoD.StartMenu_SmallTierLevel = InheritFrom(LUI.UIElement)
CoD.StartMenu_SmallTierLevel.__defaultWidth = 349
CoD.StartMenu_SmallTierLevel.__defaultHeight = 80
CoD.StartMenu_SmallTierLevel.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.StartMenu_SmallTierLevel)
	self.id = "StartMenu_SmallTierLevel"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	local Background = LUI.UIImage.new(0, 0, 0, 349, 0, 0, 16, 75)
	Background:setRGB(0.11, 0.18, 0.24)
	Background:setMaterial(LUI.UIImage.GetCachedMaterial("uie_wipe_normal"))
	Background:setShaderVector(0, 1, 0, 0, 0)
	Background:setShaderVector(1, 0, 0, 0, 0)
	Background:setShaderVector(2, 1, 0, 0, 0)
	Background:setShaderVector(3, 0, 0, 0, 0)
	Background:setShaderVector(4, 0, 0, 0, 0)
	self:addElement(Background)
	self.Background = Background
	local Gradient = LUI.UIImage.new(0, 0, 0, 349, 0, 0, 16, 72)
	Gradient:setRGB(0.08, 0.21, 0.31)
	Gradient:setAlpha(0.94)
	Gradient:setImage(RegisterImage("uie_ui_menu_common_gradient"))
	Gradient:setMaterial(LUI.UIImage.GetCachedMaterial("ui_add"))
	self:addElement(Gradient)
	self.Gradient = Gradient
	local TiledShaderImage = LUI.UIImage.new(0, 1, 0, 0, 0, 0.74, 16, 16)
	TiledShaderImage:setRGB(0, 0, 0)
	TiledShaderImage:setImage(RegisterImage("uie_ui_menu_store_repeat_dot_pattern"))
	TiledShaderImage:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	TiledShaderImage:setShaderVector(0, 0, 0, 0, 0)
	TiledShaderImage:setupNineSliceShader(24, 24)
	self:addElement(TiledShaderImage)
	self.TiledShaderImage = TiledShaderImage
	local TiledShaderImage2 = LUI.UIImage.new(0, 1, 0, 0, 0, 0.74, 16, 16)
	TiledShaderImage2:setRGB(0, 0, 0)
	TiledShaderImage2:setAlpha(0.7)
	TiledShaderImage2:setImage(RegisterImage("uie_ui_menu_store_repeat_dot_pattern"))
	TiledShaderImage2:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	TiledShaderImage2:setShaderVector(0, 0, 0, 0, 0)
	TiledShaderImage2:setupNineSliceShader(24, 24)
	self:addElement(TiledShaderImage2)
	self.TiledShaderImage2 = TiledShaderImage2
	local NextText = LUI.UIText.new(0, 0, 266, 345, 0, 0, 53.5, 70.5)
	NextText:setRGB(0.88, 0.96, 1)
	NextText:setTTF("ttmussels_regular")
	NextText:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_90D57B1E92D39D7"))
	NextText:setShaderVector(0, 0, 0, 0, 0)
	NextText:setShaderVector(1, 0, 0, 0, 0)
	NextText:setShaderVector(2, 0, 0.7, 1, 0.2)
	NextText:setLetterSpacing(1)
	NextText:setAlignment(Enum.LUIAlignment[@"lui_alignment_left"])
	NextText:setAlignment(Enum.LUIAlignment[@"hash_E821F0ECFF8D1C7"])
	NextText:subscribeToGlobalModel(f1_arg1, "LootStreamProgress", "nextTier", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			NextText:setText(f2_local0)
		end
	end)
	self:addElement(NextText)
	self.NextText = NextText
	local TierText = LUI.UIText.new(0, 0, 12.5, 129.5, 0, 0, 25.5, 53.5)
	TierText:setRGB(0.88, 0.96, 1)
	TierText:setTTF("ttmussels_demibold")
	TierText:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_90D57B1E92D39D7"))
	TierText:setShaderVector(0, 1, 0, 0, 0)
	TierText:setShaderVector(1, 0, 0, 0, 0)
	TierText:setShaderVector(2, 0, 0.7, 1, 0.2)
	TierText:setLetterSpacing(4)
	TierText:setAlignment(Enum.LUIAlignment[@"lui_alignment_left"])
	TierText:setAlignment(Enum.LUIAlignment[@"hash_E821F0ECFF8D1C7"])
	TierText:subscribeToGlobalModel(f1_arg1, "LootStreamProgress", "currentTier", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			TierText:setText(CoD.BlackMarketUtility.AppendCurrentSeasonTier(f3_local0))
		end
	end)
	self:addElement(TierText)
	self.TierText = TierText
	local Border = LUI.UIImage.new(0.04, 0.04, -3.5, 248.5, 0, 0, 55.5, 67.5)
	Border:setRGB(0.08, 0.14, 0.18)
	Border:setAlpha(0.8)
	Border:setMaterial(LUI.UIImage.GetCachedMaterial("uie_feather_edges"))
	Border:setShaderVector(0, 0, 0.1, 0, 0.1)
	self:addElement(Border)
	self.Border = Border
	local tierProgressBackground = LUI.UIImage.new(0.04, 0.76, -3, -3, 0, 0, 55, 67)
	tierProgressBackground:setRGB(0.09, 0.09, 0.09)
	tierProgressBackground:setImage(RegisterImage(@"hash_32F80AF66C054F97"))
	self:addElement(tierProgressBackground)
	self.tierProgressBackground = tierProgressBackground
	local tierProgressFill = LUI.UIImage.new(-0.27, -0.27, 107.5, 357.5, 1, 1, -23.5, -14.5)
	tierProgressFill:setRGB(0.88, 0.96, 1)
	tierProgressFill:setAlpha(0)
	tierProgressFill:setMaterial(LUI.UIImage.GetCachedMaterial("uie_wipe"))
	tierProgressFill:setShaderVector(0, 0.64, 0, 0, 0)
	tierProgressFill:setShaderVector(1, 0, 0, 0, 0)
	tierProgressFill:setShaderVector(2, 1, 0, 0, 0)
	tierProgressFill:setShaderVector(3, 0, 0, 0, 0)
	tierProgressFill:setShaderVector(4, 0, 0, 0, 0)
	self:addElement(tierProgressFill)
	self.tierProgressFill = tierProgressFill
	local tierProgress = LUI.UIImage.new(0, 0, 11, 263, 0, 0, 55, 67)
	tierProgress:setRGB(0.5, 0.85, 1)
	tierProgress:setImage(RegisterImage(@"hash_3E51FDFB95E8F82B"))
	tierProgress:setMaterial(LUI.UIImage.GetCachedMaterial("uie_wipe_normal"))
	tierProgress:setShaderVector(1, 0, 0, 0, 0)
	tierProgress:setShaderVector(2, 1, 0, 0, 0)
	tierProgress:setShaderVector(3, 0, 0, 0, 0)
	tierProgress:setShaderVector(4, 0, 0, 0, 0)
	tierProgress:subscribeToGlobalModel(f1_arg1, "LootStreamProgress", "tierProgress", function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			tierProgress:setShaderVector(0, CoD.GetVectorComponentFromString(f4_local0, 1), CoD.GetVectorComponentFromString(f4_local0, 2), CoD.GetVectorComponentFromString(f4_local0, 3), CoD.GetVectorComponentFromString(f4_local0, 4))
		end
	end)
	self:addElement(tierProgress)
	self.tierProgress = tierProgress
	local StartMenuSmallTierBoostNotification = CoD.StartMenu_SmallTierBoostNotification.new(f1_arg0, f1_arg1, 0, 0, 299, 349, 0, 0, 21, 71)
	StartMenuSmallTierBoostNotification:mergeStateConditions({
		{
			stateName = "TierBoost",
			condition = function(menu, element, event)
				return IsTierBoostActive(f1_arg1)
			end,
		},
	})
	self:addElement(StartMenuSmallTierBoostNotification)
	self.StartMenuSmallTierBoostNotification = StartMenuSmallTierBoostNotification
	local LootTierBoostPercent = CoD.LootTierBoostPercentContraband.new(f1_arg0, f1_arg1, 0, 0, 1, 136, 0, 0, -15, 1)
	LootTierBoostPercent:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return not CoD.BlackMarketUtility.ShowTierBoostPercent(f1_arg1, menu)
			end,
		},
	})
	local f1_local13 = LootTierBoostPercent
	local f1_local14 = LootTierBoostPercent.subscribeToModel
	local f1_local15 = Engine.GetModelForController(f1_arg1)
	f1_local14(f1_local13, f1_local15["LootStreamProgress.personalTierBoost"], function(f7_arg0)
		f1_arg0:updateElementState(LootTierBoostPercent, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f7_arg0:get(),
			modelName = "LootStreamProgress.personalTierBoost",
		})
	end, false)
	self:addElement(LootTierBoostPercent)
	self.LootTierBoostPercent = LootTierBoostPercent
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.StartMenu_SmallTierLevel.__onClose = function(f8_arg0)
	f8_arg0.NextText:close()
	f8_arg0.TierText:close()
	f8_arg0.tierProgress:close()
	f8_arg0.StartMenuSmallTierBoostNotification:close()
	f8_arg0.LootTierBoostPercent:close()
end
