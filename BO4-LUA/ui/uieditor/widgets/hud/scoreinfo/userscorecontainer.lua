require("x64:4670ea036861b35")
require("x64:7e82c855df95ad7")
CoD.UserScoreContainer = InheritFrom(LUI.UIElement)
CoD.UserScoreContainer.__defaultWidth = 334
CoD.UserScoreContainer.__defaultHeight = 67
CoD.UserScoreContainer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.UserScoreContainer)
	self.id = "UserScoreContainer"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local UserScore = LUI.UIText.new(0, 0, 11, 93, 0.5, 0.5, -36, 30)
	UserScore:setRGB(ColorSet.FriendlyBlue.r, ColorSet.FriendlyBlue.g, ColorSet.FriendlyBlue.b)
	UserScore:setTTF("ttmussels_demibold")
	UserScore:setLetterSpacing(-1.9)
	UserScore:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	UserScore:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	UserScore:linkToElementModel(self, "playerScore", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			UserScore:setText(f2_local0)
		end
	end)
	self:addElement(UserScore)
	self.UserScore = UserScore
	local Meter = CoD.ScoreInfo_Meter.new(f1_arg0, f1_arg1, 0, 0, 109, 185, 0.5, 0.5, -19, 15)
	Meter:setRGB(ColorSet.FriendlyBlue.r, ColorSet.FriendlyBlue.g, ColorSet.FriendlyBlue.b)
	Meter:setXRot(180)
	Meter:linkToElementModel(self, nil, false, function(model)
		Meter:setModel(model, f1_arg1)
	end)
	Meter.ImgMeterEnvFillLine.__ScoreMeterUpperWipe = function(f4_arg0)
		local f4_local0 = f4_arg0:get()
		if f4_local0 ~= nil then
			Meter.ImgMeterEnvFillLine:setShaderVector(0, DivideByScoreLimit(f1_arg1, CoD.GetVectorComponentFromString(f4_local0, 1), CoD.GetVectorComponentFromString(f4_local0, 2), CoD.GetVectorComponentFromString(f4_local0, 3), CoD.GetVectorComponentFromString(f4_local0, 4)))
		end
	end
	Meter:linkToElementModel(self, "playerScore", true, Meter.ImgMeterEnvFillLine.__ScoreMeterUpperWipe)
	Meter.ImgMeterEnvFillLine.__ScoreMeterUpperWipe_FullPath = function()
		local f5_local0 = self:getModel()
		if f5_local0 then
			f5_local0 = self:getModel()
			f5_local0 = f5_local0.playerScore
		end
		if f5_local0 then
			Meter.ImgMeterEnvFillLine.__ScoreMeterUpperWipe(f5_local0)
		end
	end
	self:addElement(Meter)
	self.Meter = Meter
	local MeterLine = CoD.ScoreInfo_MeterLine.new(f1_arg0, f1_arg1, 0.5, 0.5, -55, 21, 0.5, 0.5, -19, 15)
	MeterLine:mergeStateConditions({
		{
			stateName = "Active",
			condition = function(menu, element, event)
				local f6_local0
				if not HideScoreMeterDueToGameType() then
					f6_local0 = IsAtLeastHalfGameScore(f1_arg1, "gameScore.playerScore")
				else
					f6_local0 = false
				end
				return f6_local0
			end,
		},
	})
	local f1_local4 = MeterLine
	local f1_local5 = MeterLine.subscribeToModel
	local f1_local6 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local5(f1_local4, f1_local6["gameScore.playerScore"], function(f7_arg0)
		f1_arg0:updateElementState(MeterLine, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f7_arg0:get(),
			modelName = "gameScore.playerScore",
		})
	end, false)
	f1_local4 = MeterLine
	f1_local5 = MeterLine.subscribeToModel
	f1_local6 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local5(f1_local4, f1_local6["gameScore.scoreLimit"], function(f8_arg0)
		f1_arg0:updateElementState(MeterLine, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f8_arg0:get(),
			modelName = "gameScore.scoreLimit",
		})
	end, false)
	MeterLine:setAlpha(0)
	self:addElement(MeterLine)
	self.MeterLine = MeterLine
	f1_local4 = Meter
	f1_local5 = Meter.subscribeToModel
	f1_local6 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local5(f1_local4, f1_local6["gameScore.roundsPlayed"], Meter.ImgMeterEnvFillLine.__ScoreMeterUpperWipe_FullPath)
	self:mergeStateConditions({
		{
			stateName = "Count3",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueLessThan(f1_arg1, "gameScore.playerScore", 1000)
			end,
		},
		{
			stateName = "Count4",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueLessThan(f1_arg1, "gameScore.playerScore", 10000)
			end,
		},
		{
			stateName = "Count5",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueLessThan(f1_arg1, "gameScore.playerScore", 100000)
			end,
		},
		{
			stateName = "Count6",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueLessThan(f1_arg1, "gameScore.playerScore", 1000000)
			end,
		},
		{
			stateName = "Count7",
			condition = function(menu, element, event)
				return AlwaysTrue()
			end,
		},
	})
	f1_local4 = self
	f1_local5 = self.subscribeToModel
	f1_local6 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local5(f1_local4, f1_local6["gameScore.playerScore"], function(f14_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f14_arg0:get(),
			modelName = "gameScore.playerScore",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.UserScoreContainer.__resetProperties = function(f15_arg0)
	f15_arg0.MeterLine:completeAnimation()
	f15_arg0.Meter:completeAnimation()
	f15_arg0.UserScore:completeAnimation()
	f15_arg0.MeterLine:setLeftRight(0.5, 0.5, -55, 21)
	f15_arg0.MeterLine:setTopBottom(0.5, 0.5, -19, 15)
	f15_arg0.Meter:setLeftRight(0, 0, 109, 185)
	f15_arg0.Meter:setTopBottom(0.5, 0.5, -19, 15)
	f15_arg0.UserScore:setLeftRight(0, 0, 11, 93)
	f15_arg0.UserScore:setTopBottom(0.5, 0.5, -36, 30)
end
CoD.UserScoreContainer.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(2)
			f16_arg0.Meter:completeAnimation()
			f16_arg0.Meter:setLeftRight(0, 0, 102, 178)
			f16_arg0.Meter:setTopBottom(0.5, 0.5, 593, 627)
			f16_arg0.clipFinished(f16_arg0.Meter)
			f16_arg0.MeterLine:completeAnimation()
			f16_arg0.MeterLine:setLeftRight(0.5, 0.5, -60, 16)
			f16_arg0.MeterLine:setTopBottom(0.5, 0.5, 593, 627)
			f16_arg0.clipFinished(f16_arg0.MeterLine)
		end,
	},
	Count3 = {
		DefaultClip = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(1)
			f17_arg0.Meter:completeAnimation()
			f17_arg0.Meter:setLeftRight(0, 0, 124, 200)
			f17_arg0.Meter:setTopBottom(0.5, 0.5, -19, 15)
			f17_arg0.clipFinished(f17_arg0.Meter)
		end,
	},
	Count4 = {
		DefaultClip = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(3)
			f18_arg0.UserScore:completeAnimation()
			f18_arg0.UserScore:setLeftRight(0, 0, 11, 125)
			f18_arg0.UserScore:setTopBottom(0.5, 0.5, -36, 30)
			f18_arg0.clipFinished(f18_arg0.UserScore)
			f18_arg0.Meter:completeAnimation()
			f18_arg0.Meter:setLeftRight(0, 0, 156, 232)
			f18_arg0.Meter:setTopBottom(0.5, 0.5, -19, 15)
			f18_arg0.clipFinished(f18_arg0.Meter)
			f18_arg0.MeterLine:completeAnimation()
			f18_arg0.MeterLine:setLeftRight(0.5, 0.5, -25, 51)
			f18_arg0.MeterLine:setTopBottom(0.5, 0.5, -19, 15)
			f18_arg0.clipFinished(f18_arg0.MeterLine)
		end,
	},
	Count5 = {
		DefaultClip = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(3)
			f19_arg0.UserScore:completeAnimation()
			f19_arg0.UserScore:setLeftRight(0, 0, 11, 155)
			f19_arg0.UserScore:setTopBottom(0.5, 0.5, -36, 30)
			f19_arg0.clipFinished(f19_arg0.UserScore)
			f19_arg0.Meter:completeAnimation()
			f19_arg0.Meter:setLeftRight(0, 0, 182, 258)
			f19_arg0.Meter:setTopBottom(0.5, 0.5, -19, 15)
			f19_arg0.clipFinished(f19_arg0.Meter)
			f19_arg0.MeterLine:completeAnimation()
			f19_arg0.MeterLine:setLeftRight(0.5, 0.5, 5, 81)
			f19_arg0.MeterLine:setTopBottom(0.5, 0.5, -19, 15)
			f19_arg0.clipFinished(f19_arg0.MeterLine)
		end,
	},
	Count6 = {
		DefaultClip = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(3)
			f20_arg0.UserScore:completeAnimation()
			f20_arg0.UserScore:setLeftRight(0, 0, 12, 184)
			f20_arg0.UserScore:setTopBottom(0.5, 0.5, -36, 30)
			f20_arg0.clipFinished(f20_arg0.UserScore)
			f20_arg0.Meter:completeAnimation()
			f20_arg0.Meter:setLeftRight(0, 0, 211, 287)
			f20_arg0.Meter:setTopBottom(0.5, 0.5, -19, 15)
			f20_arg0.clipFinished(f20_arg0.Meter)
			f20_arg0.MeterLine:completeAnimation()
			f20_arg0.MeterLine:setLeftRight(0.5, 0.5, 35, 111)
			f20_arg0.MeterLine:setTopBottom(0.5, 0.5, -19, 15)
			f20_arg0.clipFinished(f20_arg0.MeterLine)
		end,
	},
	Count7 = {
		DefaultClip = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(3)
			f21_arg0.UserScore:completeAnimation()
			f21_arg0.UserScore:setLeftRight(0, 0, 11, 217)
			f21_arg0.UserScore:setTopBottom(0.5, 0.5, -36, 30)
			f21_arg0.clipFinished(f21_arg0.UserScore)
			f21_arg0.Meter:completeAnimation()
			f21_arg0.Meter:setLeftRight(0, 0, 240, 316)
			f21_arg0.Meter:setTopBottom(0.5, 0.5, -19, 15)
			f21_arg0.clipFinished(f21_arg0.Meter)
			f21_arg0.MeterLine:completeAnimation()
			f21_arg0.MeterLine:setLeftRight(0.5, 0.5, 65, 141)
			f21_arg0.MeterLine:setTopBottom(0.5, 0.5, -19, 15)
			f21_arg0.clipFinished(f21_arg0.MeterLine)
		end,
	},
}
CoD.UserScoreContainer.__onClose = function(f22_arg0)
	f22_arg0.UserScore:close()
	f22_arg0.Meter:close()
	f22_arg0.MeterLine:close()
end
