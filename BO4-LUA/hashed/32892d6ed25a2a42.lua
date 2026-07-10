require("x64:c4ffbae6031ab73")
require("x64:8c42d352a93c414")
require("x64:5d82dfdd9f543e2")
CoD.PC_Korea_Event_TierProgress = InheritFrom(LUI.UIElement)
CoD.PC_Korea_Event_TierProgress.__defaultWidth = 906
CoD.PC_Korea_Event_TierProgress.__defaultHeight = 460
CoD.PC_Korea_Event_TierProgress.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PC_Korea_Event_TierProgress)
	self.id = "PC_Korea_Event_TierProgress"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local TierTitle = LUI.UIText.new(0.5, 0.5, -378, 378, 0.5, 0.5, -130, -105)
	TierTitle:setRGB(ColorSet.T8__OCHRE.r, ColorSet.T8__OCHRE.g, ColorSet.T8__OCHRE.b)
	TierTitle:setText(Engine[0xF9F1239CFD921FE](0xD6B512C1C4B5EC5))
	TierTitle:setTTF("ttmussels_demibold")
	TierTitle:setLetterSpacing(5)
	TierTitle:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	TierTitle:setAlignment(Enum[0x7A5123B654282D2][0x70510683C22104B])
	self:addElement(TierTitle)
	self.TierTitle = TierTitle
	local TierTimeRemaining = LUI.UIText.new(0.5, 0.5, -317.5, 317.5, 0.5, 0.5, -98, -83)
	TierTimeRemaining:setTTF("dinnext_regular")
	TierTimeRemaining:setLetterSpacing(5)
	TierTimeRemaining:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	TierTimeRemaining:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	TierTimeRemaining:subscribeToGlobalModel(f1_arg1, "PCKoreaEventCurrentDayProgression", "timeRemaining", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			TierTimeRemaining:setText(f2_local0)
		end
	end)
	self:addElement(TierTimeRemaining)
	self.TierTimeRemaining = TierTimeRemaining
	local ProgressFill = LUI.UIImage.new(0.5, 0.5, -317.5, 317.5, 0.5, 0.5, -28, 0)
	ProgressFill:setImage(RegisterImage(0x2DB280070E6C877))
	ProgressFill:setMaterial(LUI.UIImage.GetCachedMaterial(0x316E67E1DF2198E))
	ProgressFill:setShaderVector(1, 0, 0, 0, 0)
	ProgressFill:setShaderVector(2, 1, 0, 0, 0)
	ProgressFill:setShaderVector(3, 0, 0, 0, 0)
	ProgressFill:setShaderVector(4, 0, 0, 0, 0)
	ProgressFill:subscribeToGlobalModel(f1_arg1, "PCKoreaEventCurrentDayProgression", "progressBarRatio", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			ProgressFill:setShaderVector(0, CoD.GetVectorComponentFromString(f3_local0, 1), CoD.GetVectorComponentFromString(f3_local0, 2), CoD.GetVectorComponentFromString(f3_local0, 3), CoD.GetVectorComponentFromString(f3_local0, 4))
		end
	end)
	self:addElement(ProgressFill)
	self.ProgressFill = ProgressFill
	local Border = LUI.UIImage.new(0.5, 0.5, -317.5, 317.5, 0.5, 0.5, -28, 0)
	Border:setRGB(0.45, 0.45, 0.45)
	Border:setImage(RegisterImage(0x15BB65132BCEED9))
	Border:setMaterial(LUI.UIImage.GetCachedMaterial(0x44484DDFAF5C093))
	Border:setShaderVector(0, 0, 0, 0.02, 0)
	Border:setupNineSliceShader(25, 25)
	self:addElement(Border)
	self.Border = Border
	local CornerPips = LUI.UIImage.new(0.5, 0.5, 314.5, 319.5, 0.5, 0.5, -30.5, -25.5)
	CornerPips:setImage(RegisterImage(0xCD2D51C614BCB51))
	self:addElement(CornerPips)
	self.CornerPips = CornerPips
	local CornerPips2 = LUI.UIImage.new(0.5, 0.5, 314.5, 319.5, 0.5, 0.5, -2.5, 2.5)
	CornerPips2:setImage(RegisterImage(0xCD2D51C614BCB51))
	self:addElement(CornerPips2)
	self.CornerPips2 = CornerPips2
	local CornerPips3 = LUI.UIImage.new(0.5, 0.5, -319.5, -314.5, 0.5, 0.5, -2.5, 2.5)
	CornerPips3:setImage(RegisterImage(0xCD2D51C614BCB51))
	self:addElement(CornerPips3)
	self.CornerPips3 = CornerPips3
	local CornerPips4 = LUI.UIImage.new(0.5, 0.5, -319.5, -314.5, 0.5, 0.5, -30.5, -25.5)
	CornerPips4:setImage(RegisterImage(0xCD2D51C614BCB51))
	self:addElement(CornerPips4)
	self.CornerPips4 = CornerPips4
	local TextNumber = CoD.PC_Korea_Event_Day_Progression_Numbers.new(f1_arg0, f1_arg1, 0.5, 0.5, -348, -288, 0.5, 0.5, 6, 38)
	TextNumber:mergeStateConditions({
		{
			stateName = "TimeCompleted",
			condition = function(menu, element, event)
				return AlwaysTrue()
			end,
		},
	})
	self:addElement(TextNumber)
	self.TextNumber = TextNumber
	local TextNumber2 = CoD.PC_Korea_Event_Day_Progression_Numbers.new(f1_arg0, f1_arg1, 0.5, 0.5, -190, -130, 0.5, 0.5, 6, 38)
	TextNumber2:mergeStateConditions({
		{
			stateName = "TimeCompleted",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueGreaterThanOrEqualTo(f1_arg1, "PCKoreaEventCurrentDayProgression.progression", 30)
			end,
		},
	})
	local TextNumber4 = TextNumber2
	local TextNumber3 = TextNumber2.subscribeToModel
	local TextNumber5 = Engine[0x4DF5CFBC1771947](f1_arg1)
	TextNumber3(TextNumber4, TextNumber5["PCKoreaEventCurrentDayProgression.progression"], function(f6_arg0)
		f1_arg0:updateElementState(TextNumber2, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "PCKoreaEventCurrentDayProgression.progression",
		})
	end, false)
	TextNumber2.TextNumber:setText(30)
	self:addElement(TextNumber2)
	self.TextNumber2 = TextNumber2
	TextNumber3 = CoD.PC_Korea_Event_Day_Progression_Numbers.new(f1_arg0, f1_arg1, 0.5, 0.5, -30, 30, 0.5, 0.5, 6, 38)
	TextNumber3:mergeStateConditions({
		{
			stateName = "TimeCompleted",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueGreaterThanOrEqualTo(f1_arg1, "PCKoreaEventCurrentDayProgression.progression", 60)
			end,
		},
	})
	TextNumber5 = TextNumber3
	TextNumber4 = TextNumber3.subscribeToModel
	local Star = Engine[0x4DF5CFBC1771947](f1_arg1)
	TextNumber4(TextNumber5, Star["PCKoreaEventCurrentDayProgression.progression"], function(f8_arg0)
		f1_arg0:updateElementState(TextNumber3, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f8_arg0:get(),
			modelName = "PCKoreaEventCurrentDayProgression.progression",
		})
	end, false)
	TextNumber3.TextNumber:setText(60)
	self:addElement(TextNumber3)
	self.TextNumber3 = TextNumber3
	TextNumber4 = CoD.PC_Korea_Event_Day_Progression_Numbers.new(f1_arg0, f1_arg1, 0.5, 0.5, 130, 190, 0.5, 0.5, 6, 38)
	TextNumber4:mergeStateConditions({
		{
			stateName = "TimeCompleted",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueGreaterThanOrEqualTo(f1_arg1, "PCKoreaEventCurrentDayProgression.progression", 90)
			end,
		},
	})
	Star = TextNumber4
	TextNumber5 = TextNumber4.subscribeToModel
	local StarFull = Engine[0x4DF5CFBC1771947](f1_arg1)
	TextNumber5(Star, StarFull["PCKoreaEventCurrentDayProgression.progression"], function(f10_arg0)
		f1_arg0:updateElementState(TextNumber4, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f10_arg0:get(),
			modelName = "PCKoreaEventCurrentDayProgression.progression",
		})
	end, false)
	TextNumber4.TextNumber:setText(90)
	self:addElement(TextNumber4)
	self.TextNumber4 = TextNumber4
	TextNumber5 = CoD.PC_Korea_Event_Day_Progression_Numbers.new(f1_arg0, f1_arg1, 0.5, 0.5, 288, 348, 0.5, 0.5, 6, 38)
	TextNumber5:mergeStateConditions({
		{
			stateName = "TimeCompleted",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueGreaterThanOrEqualTo(f1_arg1, "PCKoreaEventCurrentDayProgression.progression", 120)
			end,
		},
	})
	StarFull = TextNumber5
	Star = TextNumber5.subscribeToModel
	local TierAcquiredGlow = Engine[0x4DF5CFBC1771947](f1_arg1)
	Star(StarFull, TierAcquiredGlow["PCKoreaEventCurrentDayProgression.progression"], function(f12_arg0)
		f1_arg0:updateElementState(TextNumber5, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f12_arg0:get(),
			modelName = "PCKoreaEventCurrentDayProgression.progression",
		})
	end, false)
	TextNumber5.TextNumber:setText(120)
	self:addElement(TextNumber5)
	self.TextNumber5 = TextNumber5
	Star = LUI.UIImage.new(0.5, 0.5, 160, 200, 0.5, 0.5, 38, 74)
	Star:setAlpha(0.7)
	Star:setImage(RegisterImage(0xA90716DCE74FFF2))
	Star:setMaterial(LUI.UIImage.GetCachedMaterial(0x98A2728B4675FB5))
	Star:setShaderVector(0, 0, 0, 0, 0)
	Star:setShaderVector(1, -46.8, 0, 0, 0)
	self:addElement(Star)
	self.Star = Star
	StarFull = LUI.UIImage.new(0.5, 0.5, 160, 200, 0.5, 0.5, 38, 74)
	StarFull:setAlpha(0)
	StarFull:setScale(1.1, 1.1)
	StarFull:setImage(RegisterImage(0x78D95A993908FDE))
	StarFull:setMaterial(LUI.UIImage.GetCachedMaterial(0x98A2728B4675FB5))
	StarFull:setShaderVector(0, 0.95, 0, 0, 0)
	StarFull:setShaderVector(1, -46.8, 0, 0, 0)
	self:addElement(StarFull)
	self.StarFull = StarFull
	TierAcquiredGlow = LUI.UIImage.new(0.5, 0.5, -80, 80, 0.5, 0.5, 46, 206)
	TierAcquiredGlow:setAlpha(0)
	TierAcquiredGlow:setImage(RegisterImage(0x6752D35CBDA5874))
	self:addElement(TierAcquiredGlow)
	self.TierAcquiredGlow = TierAcquiredGlow
	local TierToken = LUI.UIImage.new(0.5, 0.5, -40, 40, 0.5, 0.5, 86, 166)
	TierToken:setAlpha(0)
	TierToken:setScale(2, 2)
	TierToken:setImage(RegisterImage(0x3162CFF8BC56A18))
	self:addElement(TierToken)
	self.TierToken = TierToken
	local TierAcquiredText = LUI.UIText.new(0.5, 0.5, -350, 350, 0.5, 0.5, 166, 187)
	TierAcquiredText:setRGB(ColorSet.T8__OCHRE.r, ColorSet.T8__OCHRE.g, ColorSet.T8__OCHRE.b)
	TierAcquiredText:setAlpha(0)
	TierAcquiredText:setText(Engine[0xF9F1239CFD921FE](0xE483DAF970FDA40))
	TierAcquiredText:setTTF("ttmussels_demibold")
	TierAcquiredText:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	TierAcquiredText:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(TierAcquiredText)
	self.TierAcquiredText = TierAcquiredText
	local TokenEmpty = CoD.PC_Korea_Event_Daily_Tier.new(f1_arg0, f1_arg1, 0.5, 0.5, 119, 159, 0.5, 0.5, 37, 77)
	TokenEmpty:mergeStateConditions({
		{
			stateName = "TokenReward",
			condition = function(menu, element, event)
				local f13_local0 = CoD.ModelUtility.IsModelValueGreaterThanOrEqualTo(f1_arg1, "PCKoreaEventCurrentDayProgression.progression", 90)
				if f13_local0 then
					f13_local0 = IsMenuAARKoreaEvent(menu)
					if f13_local0 then
						f13_local0 = CoD.ModelUtility.IsModelValueTrue(f1_arg1, "PCKoreaEventCurrentDayProgression.showCompletedAnimation")
					end
				end
				return f13_local0
			end,
		},
		{
			stateName = "TokenReceived",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueGreaterThanOrEqualTo(f1_arg1, "PCKoreaEventCurrentDayProgression.progression", 90)
			end,
		},
	})
	local TokenEmpty3 = TokenEmpty
	local TokenEmpty2 = TokenEmpty.subscribeToModel
	local TokenEmpty4 = Engine[0x4DF5CFBC1771947](f1_arg1)
	TokenEmpty2(TokenEmpty3, TokenEmpty4["PCKoreaEventCurrentDayProgression.progression"], function(f15_arg0)
		f1_arg0:updateElementState(TokenEmpty, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f15_arg0:get(),
			modelName = "PCKoreaEventCurrentDayProgression.progression",
		})
	end, false)
	TokenEmpty3 = TokenEmpty
	TokenEmpty2 = TokenEmpty.subscribeToModel
	TokenEmpty4 = Engine[0x4DF5CFBC1771947](f1_arg1)
	TokenEmpty2(TokenEmpty3, TokenEmpty4["PCKoreaEventCurrentDayProgression.showCompletedAnimation"], function(f16_arg0)
		f1_arg0:updateElementState(TokenEmpty, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f16_arg0:get(),
			modelName = "PCKoreaEventCurrentDayProgression.showCompletedAnimation",
		})
	end, false)
	self:addElement(TokenEmpty)
	self.TokenEmpty = TokenEmpty
	TokenEmpty2 = CoD.PC_Korea_Event_Daily_Tier.new(f1_arg0, f1_arg1, 0.5, 0.5, -20, 20, 0.5, 0.5, 37, 77)
	TokenEmpty2:mergeStateConditions({
		{
			stateName = "TokenReward",
			condition = function(menu, element, event)
				local f17_local0 = CoD.ModelUtility.IsModelValueGreaterThanOrEqualTo(f1_arg1, "PCKoreaEventCurrentDayProgression.progression", 60)
				if f17_local0 then
					f17_local0 = IsMenuAARKoreaEvent(menu)
					if f17_local0 then
						f17_local0 = CoD.ModelUtility.IsModelValueTrue(f1_arg1, "PCKoreaEventCurrentDayProgression.showCompletedAnimation")
					end
				end
				return f17_local0
			end,
		},
		{
			stateName = "TokenReceived",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueGreaterThanOrEqualTo(f1_arg1, "PCKoreaEventCurrentDayProgression.progression", 60)
			end,
		},
	})
	TokenEmpty4 = TokenEmpty2
	TokenEmpty3 = TokenEmpty2.subscribeToModel
	local SeparatorsList = Engine[0x4DF5CFBC1771947](f1_arg1)
	TokenEmpty3(TokenEmpty4, SeparatorsList["PCKoreaEventCurrentDayProgression.progression"], function(f19_arg0)
		f1_arg0:updateElementState(TokenEmpty2, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f19_arg0:get(),
			modelName = "PCKoreaEventCurrentDayProgression.progression",
		})
	end, false)
	TokenEmpty4 = TokenEmpty2
	TokenEmpty3 = TokenEmpty2.subscribeToModel
	SeparatorsList = Engine[0x4DF5CFBC1771947](f1_arg1)
	TokenEmpty3(TokenEmpty4, SeparatorsList["PCKoreaEventCurrentDayProgression.showCompletedAnimation"], function(f20_arg0)
		f1_arg0:updateElementState(TokenEmpty2, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f20_arg0:get(),
			modelName = "PCKoreaEventCurrentDayProgression.showCompletedAnimation",
		})
	end, false)
	self:addElement(TokenEmpty2)
	self.TokenEmpty2 = TokenEmpty2
	TokenEmpty3 = CoD.PC_Korea_Event_Daily_Tier.new(f1_arg0, f1_arg1, 0.5, 0.5, -180, -140, 0.5, 0.5, 37, 77)
	TokenEmpty3:mergeStateConditions({
		{
			stateName = "TokenReward",
			condition = function(menu, element, event)
				local f21_local0 = CoD.ModelUtility.IsModelValueGreaterThanOrEqualTo(f1_arg1, "PCKoreaEventCurrentDayProgression.progression", 30)
				if f21_local0 then
					f21_local0 = IsMenuAARKoreaEvent(menu)
					if f21_local0 then
						f21_local0 = CoD.ModelUtility.IsModelValueTrue(f1_arg1, "PCKoreaEventCurrentDayProgression.showCompletedAnimation")
					end
				end
				return f21_local0
			end,
		},
		{
			stateName = "TokenReceived",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueGreaterThanOrEqualTo(f1_arg1, "PCKoreaEventCurrentDayProgression.progression", 30)
			end,
		},
	})
	SeparatorsList = TokenEmpty3
	TokenEmpty4 = TokenEmpty3.subscribeToModel
	local PCKoreaEventDayProgressionSeparators2 = Engine[0x4DF5CFBC1771947](f1_arg1)
	TokenEmpty4(SeparatorsList, PCKoreaEventDayProgressionSeparators2["PCKoreaEventCurrentDayProgression.progression"], function(f23_arg0)
		f1_arg0:updateElementState(TokenEmpty3, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f23_arg0:get(),
			modelName = "PCKoreaEventCurrentDayProgression.progression",
		})
	end, false)
	SeparatorsList = TokenEmpty3
	TokenEmpty4 = TokenEmpty3.subscribeToModel
	PCKoreaEventDayProgressionSeparators2 = Engine[0x4DF5CFBC1771947](f1_arg1)
	TokenEmpty4(SeparatorsList, PCKoreaEventDayProgressionSeparators2["PCKoreaEventCurrentDayProgression.showCompletedAnimation"], function(f24_arg0)
		f1_arg0:updateElementState(TokenEmpty3, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f24_arg0:get(),
			modelName = "PCKoreaEventCurrentDayProgression.showCompletedAnimation",
		})
	end, false)
	self:addElement(TokenEmpty3)
	self.TokenEmpty3 = TokenEmpty3
	TokenEmpty4 = CoD.PC_Korea_Event_Daily_Tier.new(f1_arg0, f1_arg1, 0.5, 0.5, 297.5, 337.5, 0.5, 0.5, 37, 77)
	TokenEmpty4:mergeStateConditions({
		{
			stateName = "TokenReward",
			condition = function(menu, element, event)
				local f25_local0 = CoD.ModelUtility.IsModelValueGreaterThanOrEqualTo(f1_arg1, "PCKoreaEventCurrentDayProgression.progression", 120)
				if f25_local0 then
					f25_local0 = IsMenuAARKoreaEvent(menu)
					if f25_local0 then
						f25_local0 = CoD.ModelUtility.IsModelValueTrue(f1_arg1, "PCKoreaEventCurrentDayProgression.showCompletedAnimation")
					end
				end
				return f25_local0
			end,
		},
		{
			stateName = "TokenReceived",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueGreaterThanOrEqualTo(f1_arg1, "PCKoreaEventCurrentDayProgression.progression", 120)
			end,
		},
	})
	PCKoreaEventDayProgressionSeparators2 = TokenEmpty4
	SeparatorsList = TokenEmpty4.subscribeToModel
	local PCKoreaEventDayProgressionSeparators = Engine[0x4DF5CFBC1771947](f1_arg1)
	SeparatorsList(PCKoreaEventDayProgressionSeparators2, PCKoreaEventDayProgressionSeparators["PCKoreaEventCurrentDayProgression.progression"], function(f27_arg0)
		f1_arg0:updateElementState(TokenEmpty4, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f27_arg0:get(),
			modelName = "PCKoreaEventCurrentDayProgression.progression",
		})
	end, false)
	PCKoreaEventDayProgressionSeparators2 = TokenEmpty4
	SeparatorsList = TokenEmpty4.subscribeToModel
	PCKoreaEventDayProgressionSeparators = Engine[0x4DF5CFBC1771947](f1_arg1)
	SeparatorsList(PCKoreaEventDayProgressionSeparators2, PCKoreaEventDayProgressionSeparators["PCKoreaEventCurrentDayProgression.showCompletedAnimation"], function(f28_arg0)
		f1_arg0:updateElementState(TokenEmpty4, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f28_arg0:get(),
			modelName = "PCKoreaEventCurrentDayProgression.showCompletedAnimation",
		})
	end, false)
	self:addElement(TokenEmpty4)
	self.TokenEmpty4 = TokenEmpty4
	SeparatorsList = LUI.UIList.new(f1_arg0, f1_arg1, 150, 0, nil, false, false, false, false)
	SeparatorsList:setLeftRight(0.5, 0.5, -317.5, 164.5)
	SeparatorsList:setTopBottom(0.5, 0.5, -51, -23)
	SeparatorsList:setAlpha(0)
	SeparatorsList:setWidgetType(CoD.PC_Korea_Event_Day_Progression_Separators)
	SeparatorsList:setHorizontalCount(3)
	SeparatorsList:setSpacing(150)
	SeparatorsList:setFirstElementXOffset(152)
	SeparatorsList:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	self:addElement(SeparatorsList)
	self.SeparatorsList = SeparatorsList
	PCKoreaEventDayProgressionSeparators2 = CoD.PC_Korea_Event_Day_Progression_Separators.new(f1_arg0, f1_arg1, 0.5, 0.5, -6, 4, 0.5, 0.5, -28, 0)
	self:addElement(PCKoreaEventDayProgressionSeparators2)
	self.PCKoreaEventDayProgressionSeparators2 = PCKoreaEventDayProgressionSeparators2
	PCKoreaEventDayProgressionSeparators = CoD.PC_Korea_Event_Day_Progression_Separators.new(f1_arg0, f1_arg1, 0.5, 0.5, -166, -156, 0.5, 0.5, -28, 0)
	self:addElement(PCKoreaEventDayProgressionSeparators)
	self.PCKoreaEventDayProgressionSeparators = PCKoreaEventDayProgressionSeparators
	local PCKoreaEventDayProgressionSeparators3 = CoD.PC_Korea_Event_Day_Progression_Separators.new(f1_arg0, f1_arg1, 0.5, 0.5, 154, 164, 0.5, 0.5, -28, 0)
	self:addElement(PCKoreaEventDayProgressionSeparators3)
	self.PCKoreaEventDayProgressionSeparators3 = PCKoreaEventDayProgressionSeparators3
	local StarTierSound = LUI.UIElement.new(0, 0, 803, 835, 0, 0, 200.5, 232.5)
	StarTierSound:setPlaySoundDirect(true)
	self:addElement(StarTierSound)
	self.StarTierSound = StarTierSound
	self:mergeStateConditions({
		{
			stateName = "StarReward",
			condition = function(menu, element, event)
				local f29_local0 = CoD.ModelUtility.IsModelValueGreaterThanOrEqualTo(f1_arg1, "PCKoreaEventCurrentDayProgression.progression", 90)
				if f29_local0 then
					f29_local0 = IsMenuAARKoreaEvent(menu)
					if f29_local0 then
						f29_local0 = CoD.ModelUtility.IsModelValueTrue(f1_arg1, "PCKoreaEventCurrentDayProgression.showStarCompletedAnimation")
					end
				end
				return f29_local0
			end,
		},
		{
			stateName = "TierAcquiredWithStar",
			condition = function(menu, element, event)
				local f30_local0 = IsMenuAARKoreaEvent(menu)
				if f30_local0 then
					f30_local0 = CoD.ModelUtility.IsModelValueTrue(f1_arg1, "PCKoreaEventCurrentDayProgression.showCompletedAnimation")
					if f30_local0 then
						f30_local0 = CoD.ModelUtility.IsModelValueGreaterThanOrEqualTo(f1_arg1, "PCKoreaEventCurrentDayProgression.progression", 120)
					end
				end
				return f30_local0
			end,
		},
		{
			stateName = "TierAcquired",
			condition = function(menu, element, event)
				return IsMenuAARKoreaEvent(menu) and CoD.ModelUtility.IsModelValueTrue(f1_arg1, "PCKoreaEventCurrentDayProgression.showCompletedAnimation")
			end,
		},
		{
			stateName = "StarReceived",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueGreaterThanOrEqualTo(f1_arg1, "PCKoreaEventCurrentDayProgression.progression", 90)
			end,
		},
	})
	local f1_local28 = self
	local f1_local29 = self.subscribeToModel
	local f1_local30 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local29(f1_local28, f1_local30["PCKoreaEventCurrentDayProgression.progression"], function(f33_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f33_arg0:get(),
			modelName = "PCKoreaEventCurrentDayProgression.progression",
		})
	end, false)
	f1_local28 = self
	f1_local29 = self.subscribeToModel
	f1_local30 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local29(f1_local28, f1_local30["PCKoreaEventCurrentDayProgression.showStarCompletedAnimation"], function(f34_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f34_arg0:get(),
			modelName = "PCKoreaEventCurrentDayProgression.showStarCompletedAnimation",
		})
	end, false)
	f1_local28 = self
	f1_local29 = self.subscribeToModel
	f1_local30 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local29(f1_local28, f1_local30["PCKoreaEventCurrentDayProgression.showCompletedAnimation"], function(f35_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f35_arg0:get(),
			modelName = "PCKoreaEventCurrentDayProgression.showCompletedAnimation",
		})
	end, false)
	SeparatorsList.id = "SeparatorsList"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PreLoadFunc then
		PreLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local29 = self
	if CoD.ModelUtility.IsModelValueGreaterThanOrEqualTo(f1_arg1, "PCKoreaEventCurrentDayProgression.progression", 120) then
		HideWidget(self.TierTimeRemaining)
	end
	return self
end
CoD.PC_Korea_Event_TierProgress.__resetProperties = function(f36_arg0)
	f36_arg0.StarTierSound:completeAnimation()
	f36_arg0.StarFull:completeAnimation()
	f36_arg0.TierToken:completeAnimation()
	f36_arg0.TierAcquiredText:completeAnimation()
	f36_arg0.TierAcquiredGlow:completeAnimation()
	f36_arg0.StarTierSound:setPlaySoundDirect(true)
	f36_arg0.StarFull:setAlpha(0)
	f36_arg0.StarFull:setScale(1.1, 1.1)
	f36_arg0.StarFull:setShaderVector(0, 0.95, 0, 0, 0)
	f36_arg0.StarFull:setShaderVector(1, -46.8, 0, 0, 0)
	f36_arg0.TierToken:setAlpha(0)
	f36_arg0.TierToken:setScale(2, 2)
	f36_arg0.TierAcquiredText:setAlpha(0)
	f36_arg0.TierAcquiredGlow:setAlpha(0)
	f36_arg0.TierAcquiredGlow:setZRot(0)
end
CoD.PC_Korea_Event_TierProgress.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f37_arg0, f37_arg1)
			f37_arg0:__resetProperties()
			f37_arg0:setupElementClipCounter(0)
		end,
	},
	StarReward = {
		DefaultClip = function(f38_arg0, f38_arg1)
			f38_arg0:__resetProperties()
			f38_arg0:setupElementClipCounter(5)
			local f38_local0 = function(f39_arg0)
				local f39_local0 = function(f40_arg0)
					local f40_local0 = function(f41_arg0)
						local f41_local0 = function(f42_arg0)
							local f42_local0 = function(f43_arg0)
								f43_arg0:beginAnimation(149)
								f43_arg0:registerEventHandler("transition_complete_keyframe", f38_arg0.clipFinished)
							end
							f42_arg0:beginAnimation(900)
							f42_arg0:setShaderVector(0, 0.95, 0, 0, 0)
							f42_arg0:registerEventHandler("transition_complete_keyframe", f42_local0)
						end
						f41_arg0:beginAnimation(269)
						f41_arg0:registerEventHandler("transition_complete_keyframe", f41_local0)
					end
					f40_arg0:beginAnimation(39)
					f40_arg0:setScale(1.1, 1.1)
					f40_arg0:registerEventHandler("transition_complete_keyframe", f40_local0)
				end
				f39_arg0:beginAnimation(200)
				f39_arg0:setAlpha(1)
				f39_arg0:setScale(0.8, 0.8)
				f39_arg0:registerEventHandler("transition_complete_keyframe", f39_local0)
			end
			f38_arg0.StarFull:beginAnimation(1010)
			f38_arg0.StarFull:setAlpha(0)
			f38_arg0.StarFull:setScale(2, 2)
			f38_arg0.StarFull:setShaderVector(0, 0, 0, 0, 0)
			f38_arg0.StarFull:setShaderVector(1, -46.8, 0, 0, 0)
			f38_arg0.StarFull:registerEventHandler("interrupted_keyframe", f38_arg0.clipInterrupted)
			f38_arg0.StarFull:registerEventHandler("transition_complete_keyframe", f38_local0)
			local f38_local1 = function(f44_arg0)
				local f44_local0 = function(f45_arg0)
					local f45_local0 = function(f46_arg0)
						local f46_local0 = function(f47_arg0)
							local f47_local0 = function(f48_arg0)
								local f48_local0 = function(f49_arg0)
									f49_arg0:beginAnimation(329)
									f49_arg0:setAlpha(0)
									f49_arg0:registerEventHandler("transition_complete_keyframe", f38_arg0.clipFinished)
								end
								f48_arg0:beginAnimation(900)
								f48_arg0:setAlpha(1)
								f48_arg0:registerEventHandler("transition_complete_keyframe", f48_local0)
							end
							f47_arg0:beginAnimation(879)
							f47_arg0:setAlpha(0.2)
							f47_arg0:registerEventHandler("transition_complete_keyframe", f47_local0)
						end
						f46_arg0:beginAnimation(789)
						f46_arg0:setAlpha(1)
						f46_arg0:registerEventHandler("transition_complete_keyframe", f46_local0)
					end
					f45_arg0:beginAnimation(660)
					f45_arg0:setAlpha(0.4)
					f45_arg0:registerEventHandler("transition_complete_keyframe", f45_local0)
				end
				f44_arg0:beginAnimation(659)
				f44_arg0:setAlpha(1)
				f44_arg0:registerEventHandler("transition_complete_keyframe", f44_local0)
			end
			f38_arg0.TierAcquiredGlow:beginAnimation(2710)
			f38_arg0.TierAcquiredGlow:setAlpha(0)
			f38_arg0.TierAcquiredGlow:setZRot(0)
			f38_arg0.TierAcquiredGlow:registerEventHandler("interrupted_keyframe", f38_arg0.clipInterrupted)
			f38_arg0.TierAcquiredGlow:registerEventHandler("transition_complete_keyframe", f38_local1)
			local f38_local2 = function(f50_arg0)
				local f50_local0 = function(f51_arg0)
					local f51_local0 = function(f52_arg0)
						local f52_local0 = function(f53_arg0)
							f53_arg0:beginAnimation(329)
							f53_arg0:setAlpha(0)
							f53_arg0:setScale(1.5, 1.5)
							f53_arg0:registerEventHandler("transition_complete_keyframe", f38_arg0.clipFinished)
						end
						f52_arg0:beginAnimation(3649)
						f52_arg0:registerEventHandler("transition_complete_keyframe", f52_local0)
					end
					f51_arg0:beginAnimation(39)
					f51_arg0:setAlpha(1)
					f51_arg0:setScale(1, 1)
					f51_arg0:registerEventHandler("transition_complete_keyframe", f51_local0)
				end
				f50_arg0:beginAnimation(220)
				f50_arg0:setAlpha(0.85)
				f50_arg0:setScale(0.8, 0.8)
				f50_arg0:registerEventHandler("transition_complete_keyframe", f50_local0)
			end
			f38_arg0.TierToken:beginAnimation(2690)
			f38_arg0.TierToken:setAlpha(0)
			f38_arg0.TierToken:setScale(2, 2)
			f38_arg0.TierToken:registerEventHandler("interrupted_keyframe", f38_arg0.clipInterrupted)
			f38_arg0.TierToken:registerEventHandler("transition_complete_keyframe", f38_local2)
			local f38_local3 = function(f54_arg0)
				local f54_local0 = function(f55_arg0)
					local f55_local0 = function(f56_arg0)
						f56_arg0:beginAnimation(329)
						f56_arg0:setAlpha(0)
						f56_arg0:registerEventHandler("transition_complete_keyframe", f38_arg0.clipFinished)
					end
					f55_arg0:beginAnimation(3649)
					f55_arg0:registerEventHandler("transition_complete_keyframe", f55_local0)
				end
				f54_arg0:beginAnimation(260)
				f54_arg0:setAlpha(1)
				f54_arg0:registerEventHandler("transition_complete_keyframe", f54_local0)
			end
			f38_arg0.TierAcquiredText:beginAnimation(2690)
			f38_arg0.TierAcquiredText:setAlpha(0)
			f38_arg0.TierAcquiredText:registerEventHandler("interrupted_keyframe", f38_arg0.clipInterrupted)
			f38_arg0.TierAcquiredText:registerEventHandler("transition_complete_keyframe", f38_local3)
			local f38_local4 = function(f57_arg0)
				local f57_local0 = function(f58_arg0)
					local f58_local0 = function(f59_arg0)
						f59_arg0:playSound("uin_igr_tieracquired_in", f38_arg1)
						f59_arg0:beginAnimation(3909)
						f59_arg0:registerEventHandler("transition_complete_keyframe", function(element, event)
							element:playSound("uin_igr_tieracquired_out", f38_arg1)
							f38_arg0.clipFinished(element, event)
						end)
					end
					f58_arg0:playSound("uin_igr_starreward", f38_arg1)
					f58_arg0:beginAnimation(1690)
					f58_arg0:registerEventHandler("transition_complete_keyframe", f58_local0)
				end
				f38_arg0.StarTierSound:beginAnimation(1000)
				f38_arg0.StarTierSound:setPlaySoundDirect(true)
				f38_arg0.StarTierSound:registerEventHandler("interrupted_keyframe", f38_arg0.clipInterrupted)
				f38_arg0.StarTierSound:registerEventHandler("transition_complete_keyframe", f57_local0)
			end
			f38_arg0.StarTierSound:completeAnimation()
			f38_arg0.StarTierSound:setPlaySoundDirect(false)
			f38_local4(f38_arg0.StarTierSound)
		end,
	},
	TierAcquiredWithStar = {
		DefaultClip = function(f61_arg0, f61_arg1)
			f61_arg0:__resetProperties()
			f61_arg0:setupElementClipCounter(5)
			local f61_local0 = function(f62_arg0)
				f61_arg0.StarFull:beginAnimation(5750)
				f61_arg0.StarFull:registerEventHandler("interrupted_keyframe", f61_arg0.clipInterrupted)
				f61_arg0.StarFull:registerEventHandler("transition_complete_keyframe", f61_arg0.clipFinished)
			end
			f61_arg0.StarFull:completeAnimation()
			f61_arg0.StarFull:setAlpha(1)
			f61_arg0.StarFull:setShaderVector(0, 1.2, 0, 0, 0)
			f61_arg0.StarFull:setShaderVector(1, -46.8, 0, 0, 0)
			f61_local0(f61_arg0.StarFull)
			local f61_local1 = function(f63_arg0)
				local f63_local0 = function(f64_arg0)
					local f64_local0 = function(f65_arg0)
						local f65_local0 = function(f66_arg0)
							local f66_local0 = function(f67_arg0)
								local f67_local0 = function(f68_arg0)
									f68_arg0:beginAnimation(329)
									f68_arg0:setAlpha(0)
									f68_arg0:registerEventHandler("transition_complete_keyframe", f61_arg0.clipFinished)
								end
								f67_arg0:beginAnimation(900)
								f67_arg0:setAlpha(1)
								f67_arg0:registerEventHandler("transition_complete_keyframe", f67_local0)
							end
							f66_arg0:beginAnimation(880)
							f66_arg0:setAlpha(0.2)
							f66_arg0:registerEventHandler("transition_complete_keyframe", f66_local0)
						end
						f65_arg0:beginAnimation(789)
						f65_arg0:setAlpha(1)
						f65_arg0:registerEventHandler("transition_complete_keyframe", f65_local0)
					end
					f64_arg0:beginAnimation(659)
					f64_arg0:setAlpha(0.4)
					f64_arg0:registerEventHandler("transition_complete_keyframe", f64_local0)
				end
				f63_arg0:beginAnimation(660)
				f63_arg0:setAlpha(1)
				f63_arg0:registerEventHandler("transition_complete_keyframe", f63_local0)
			end
			f61_arg0.TierAcquiredGlow:beginAnimation(2240)
			f61_arg0.TierAcquiredGlow:setAlpha(0)
			f61_arg0.TierAcquiredGlow:setZRot(0)
			f61_arg0.TierAcquiredGlow:registerEventHandler("interrupted_keyframe", f61_arg0.clipInterrupted)
			f61_arg0.TierAcquiredGlow:registerEventHandler("transition_complete_keyframe", f61_local1)
			local f61_local2 = function(f69_arg0)
				local f69_local0 = function(f70_arg0)
					local f70_local0 = function(f71_arg0)
						local f71_local0 = function(f72_arg0)
							f72_arg0:beginAnimation(329)
							f72_arg0:setAlpha(0)
							f72_arg0:setScale(1.5, 1.5)
							f72_arg0:registerEventHandler("transition_complete_keyframe", f61_arg0.clipFinished)
						end
						f71_arg0:beginAnimation(3650)
						f71_arg0:registerEventHandler("transition_complete_keyframe", f71_local0)
					end
					f70_arg0:beginAnimation(39)
					f70_arg0:setAlpha(1)
					f70_arg0:setScale(1, 1)
					f70_arg0:registerEventHandler("transition_complete_keyframe", f70_local0)
				end
				f69_arg0:beginAnimation(220)
				f69_arg0:setAlpha(0.85)
				f69_arg0:setScale(0.8, 0.8)
				f69_arg0:registerEventHandler("transition_complete_keyframe", f69_local0)
			end
			f61_arg0.TierToken:beginAnimation(2220)
			f61_arg0.TierToken:setAlpha(0)
			f61_arg0.TierToken:setScale(2, 2)
			f61_arg0.TierToken:registerEventHandler("interrupted_keyframe", f61_arg0.clipInterrupted)
			f61_arg0.TierToken:registerEventHandler("transition_complete_keyframe", f61_local2)
			local f61_local3 = function(f73_arg0)
				local f73_local0 = function(f74_arg0)
					local f74_local0 = function(f75_arg0)
						f75_arg0:beginAnimation(329)
						f75_arg0:setAlpha(0)
						f75_arg0:registerEventHandler("transition_complete_keyframe", f61_arg0.clipFinished)
					end
					f74_arg0:beginAnimation(3650)
					f74_arg0:registerEventHandler("transition_complete_keyframe", f74_local0)
				end
				f73_arg0:beginAnimation(260)
				f73_arg0:setAlpha(1)
				f73_arg0:registerEventHandler("transition_complete_keyframe", f73_local0)
			end
			f61_arg0.TierAcquiredText:beginAnimation(2220)
			f61_arg0.TierAcquiredText:setAlpha(0)
			f61_arg0.TierAcquiredText:registerEventHandler("interrupted_keyframe", f61_arg0.clipInterrupted)
			f61_arg0.TierAcquiredText:registerEventHandler("transition_complete_keyframe", f61_local3)
			local f61_local4 = function(f76_arg0)
				local f76_local0 = function(f77_arg0)
					f77_arg0:playSound("uin_igr_tieracquired_in", f61_arg1)
					f77_arg0:beginAnimation(3910)
					f77_arg0:registerEventHandler("transition_complete_keyframe", function(element, event)
						element:playSound("uin_igr_tieracquired_out", f61_arg1)
						f61_arg0.clipFinished(element, event)
					end)
				end
				f61_arg0.StarTierSound:beginAnimation(2220)
				f61_arg0.StarTierSound:setPlaySoundDirect(true)
				f61_arg0.StarTierSound:registerEventHandler("interrupted_keyframe", f61_arg0.clipInterrupted)
				f61_arg0.StarTierSound:registerEventHandler("transition_complete_keyframe", f76_local0)
			end
			f61_arg0.StarTierSound:completeAnimation()
			f61_arg0.StarTierSound:setPlaySoundDirect(false)
			f61_local4(f61_arg0.StarTierSound)
		end,
	},
	TierAcquired = {
		DefaultClip = function(f79_arg0, f79_arg1)
			f79_arg0:__resetProperties()
			f79_arg0:setupElementClipCounter(4)
			local f79_local0 = function(f80_arg0)
				local f80_local0 = function(f81_arg0)
					local f81_local0 = function(f82_arg0)
						local f82_local0 = function(f83_arg0)
							local f83_local0 = function(f84_arg0)
								local f84_local0 = function(f85_arg0)
									f85_arg0:beginAnimation(329)
									f85_arg0:setAlpha(0)
									f85_arg0:registerEventHandler("transition_complete_keyframe", f79_arg0.clipFinished)
								end
								f84_arg0:beginAnimation(900)
								f84_arg0:setAlpha(1)
								f84_arg0:registerEventHandler("transition_complete_keyframe", f84_local0)
							end
							f83_arg0:beginAnimation(880)
							f83_arg0:setAlpha(0.2)
							f83_arg0:registerEventHandler("transition_complete_keyframe", f83_local0)
						end
						f82_arg0:beginAnimation(789)
						f82_arg0:setAlpha(1)
						f82_arg0:registerEventHandler("transition_complete_keyframe", f82_local0)
					end
					f81_arg0:beginAnimation(659)
					f81_arg0:setAlpha(0.4)
					f81_arg0:registerEventHandler("transition_complete_keyframe", f81_local0)
				end
				f80_arg0:beginAnimation(660)
				f80_arg0:setAlpha(1)
				f80_arg0:registerEventHandler("transition_complete_keyframe", f80_local0)
			end
			f79_arg0.TierAcquiredGlow:beginAnimation(2240)
			f79_arg0.TierAcquiredGlow:setAlpha(0)
			f79_arg0.TierAcquiredGlow:setZRot(0)
			f79_arg0.TierAcquiredGlow:registerEventHandler("interrupted_keyframe", f79_arg0.clipInterrupted)
			f79_arg0.TierAcquiredGlow:registerEventHandler("transition_complete_keyframe", f79_local0)
			local f79_local1 = function(f86_arg0)
				local f86_local0 = function(f87_arg0)
					local f87_local0 = function(f88_arg0)
						local f88_local0 = function(f89_arg0)
							f89_arg0:beginAnimation(329)
							f89_arg0:setAlpha(0)
							f89_arg0:setScale(1.5, 1.5)
							f89_arg0:registerEventHandler("transition_complete_keyframe", f79_arg0.clipFinished)
						end
						f88_arg0:beginAnimation(3650)
						f88_arg0:registerEventHandler("transition_complete_keyframe", f88_local0)
					end
					f87_arg0:beginAnimation(39)
					f87_arg0:setAlpha(1)
					f87_arg0:setScale(1, 1)
					f87_arg0:registerEventHandler("transition_complete_keyframe", f87_local0)
				end
				f86_arg0:beginAnimation(220)
				f86_arg0:setAlpha(0.85)
				f86_arg0:setScale(0.8, 0.8)
				f86_arg0:registerEventHandler("transition_complete_keyframe", f86_local0)
			end
			f79_arg0.TierToken:beginAnimation(2220)
			f79_arg0.TierToken:setAlpha(0)
			f79_arg0.TierToken:setScale(2, 2)
			f79_arg0.TierToken:registerEventHandler("interrupted_keyframe", f79_arg0.clipInterrupted)
			f79_arg0.TierToken:registerEventHandler("transition_complete_keyframe", f79_local1)
			local f79_local2 = function(f90_arg0)
				local f90_local0 = function(f91_arg0)
					local f91_local0 = function(f92_arg0)
						f92_arg0:beginAnimation(329)
						f92_arg0:setAlpha(0)
						f92_arg0:registerEventHandler("transition_complete_keyframe", f79_arg0.clipFinished)
					end
					f91_arg0:beginAnimation(3650)
					f91_arg0:registerEventHandler("transition_complete_keyframe", f91_local0)
				end
				f90_arg0:beginAnimation(260)
				f90_arg0:setAlpha(1)
				f90_arg0:registerEventHandler("transition_complete_keyframe", f90_local0)
			end
			f79_arg0.TierAcquiredText:beginAnimation(2220)
			f79_arg0.TierAcquiredText:setAlpha(0)
			f79_arg0.TierAcquiredText:registerEventHandler("interrupted_keyframe", f79_arg0.clipInterrupted)
			f79_arg0.TierAcquiredText:registerEventHandler("transition_complete_keyframe", f79_local2)
			local f79_local3 = function(f93_arg0)
				local f93_local0 = function(f94_arg0)
					f94_arg0:playSound("uin_igr_tieracquired_in", f79_arg1)
					f94_arg0:beginAnimation(3910)
					f94_arg0:registerEventHandler("transition_complete_keyframe", function(element, event)
						element:playSound("uin_igr_tieracquired_out", f79_arg1)
						f79_arg0.clipFinished(element, event)
					end)
				end
				f79_arg0.StarTierSound:beginAnimation(2220)
				f79_arg0.StarTierSound:setPlaySoundDirect(true)
				f79_arg0.StarTierSound:registerEventHandler("interrupted_keyframe", f79_arg0.clipInterrupted)
				f79_arg0.StarTierSound:registerEventHandler("transition_complete_keyframe", f93_local0)
			end
			f79_arg0.StarTierSound:completeAnimation()
			f79_arg0.StarTierSound:setPlaySoundDirect(false)
			f79_local3(f79_arg0.StarTierSound)
		end,
	},
	StarReceived = {
		DefaultClip = function(f96_arg0, f96_arg1)
			f96_arg0:__resetProperties()
			f96_arg0:setupElementClipCounter(1)
			local f96_local0 = function(f97_arg0)
				local f97_local0 = function(f98_arg0)
					f98_arg0:beginAnimation(900)
					f98_arg0:setShaderVector(0, 1.2, 0, 0, 0)
					f98_arg0:registerEventHandler("transition_complete_keyframe", f96_arg0.clipFinished)
				end
				f96_arg0.StarFull:beginAnimation(3000)
				f96_arg0.StarFull:registerEventHandler("interrupted_keyframe", f96_arg0.clipInterrupted)
				f96_arg0.StarFull:registerEventHandler("transition_complete_keyframe", f97_local0)
			end
			f96_arg0.StarFull:completeAnimation()
			f96_arg0.StarFull:setAlpha(1)
			f96_arg0.StarFull:setScale(1.1, 1.1)
			f96_arg0.StarFull:setShaderVector(0, 0, 0, 0, 0)
			f96_arg0.StarFull:setShaderVector(1, -46.8, 0, 0, 0)
			f96_local0(f96_arg0.StarFull)
			f96_arg0.nextClip = "DefaultClip"
		end,
	},
}
CoD.PC_Korea_Event_TierProgress.__onClose = function(f99_arg0)
	f99_arg0.TierTimeRemaining:close()
	f99_arg0.ProgressFill:close()
	f99_arg0.TextNumber:close()
	f99_arg0.TextNumber2:close()
	f99_arg0.TextNumber3:close()
	f99_arg0.TextNumber4:close()
	f99_arg0.TextNumber5:close()
	f99_arg0.TokenEmpty:close()
	f99_arg0.TokenEmpty2:close()
	f99_arg0.TokenEmpty3:close()
	f99_arg0.TokenEmpty4:close()
	f99_arg0.SeparatorsList:close()
	f99_arg0.PCKoreaEventDayProgressionSeparators2:close()
	f99_arg0.PCKoreaEventDayProgressionSeparators:close()
	f99_arg0.PCKoreaEventDayProgressionSeparators3:close()
end
