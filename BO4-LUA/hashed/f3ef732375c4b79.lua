require("x64:bd8855a84606d1")
require("x64:a16f9a48486dac9")
CoD.PC_Korea_Event_Month_Progression = InheritFrom(LUI.UIElement)
CoD.PC_Korea_Event_Month_Progression.__defaultWidth = 700
CoD.PC_Korea_Event_Month_Progression.__defaultHeight = 447
CoD.PC_Korea_Event_Month_Progression.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PC_Korea_Event_Month_Progression)
	self.id = "PC_Korea_Event_Month_Progression"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	local WeekList = LUI.UIList.new(f1_arg0, f1_arg1, 0, 0, nil, false, false, false, false)
	WeekList:setLeftRight(0.5, 0.5, -350, 210)
	WeekList:setTopBottom(0.5, 0.5, -222, 222)
	WeekList:setWidgetType(CoD.PC_Korea_Event_Week_Progression)
	WeekList:setVerticalCount(4)
	WeekList:setSpacing(0)
	WeekList:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	WeekList:setDataSource("PCKoreaEventWeekList")
	self:addElement(WeekList)
	self.WeekList = WeekList
	local MonthRewardBG = CoD.PC_Korea_Event_Month_Reward.new(f1_arg0, f1_arg1, 1, 1, -140, 0, 0.5, 0.5, -223.5, 223.5)
	MonthRewardBG:mergeStateConditions({
		{
			stateName = "Unlock",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueTrue(f1_arg1, "PCKoreaEventProgression.showCompletedMonthPopUp")
			end,
		},
		{
			stateName = "RewardUnlocked",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueTrue(f1_arg1, "PCKoreaEventProgression.isCompleted")
			end,
		},
	})
	local DescriptionLineBorder2 = MonthRewardBG
	local DescriptionLineBorder = MonthRewardBG.subscribeToModel
	local DescriptionLineBorder3 = Engine[0x4DF5CFBC1771947](f1_arg1)
	DescriptionLineBorder(DescriptionLineBorder2, DescriptionLineBorder3["PCKoreaEventProgression.showCompletedMonthPopUp"], function(f4_arg0)
		f1_arg0:updateElementState(MonthRewardBG, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f4_arg0:get(),
			modelName = "PCKoreaEventProgression.showCompletedMonthPopUp",
		})
	end, false)
	DescriptionLineBorder2 = MonthRewardBG
	DescriptionLineBorder = MonthRewardBG.subscribeToModel
	DescriptionLineBorder3 = Engine[0x4DF5CFBC1771947](f1_arg1)
	DescriptionLineBorder(DescriptionLineBorder2, DescriptionLineBorder3["PCKoreaEventProgression.isCompleted"], function(f5_arg0)
		f1_arg0:updateElementState(MonthRewardBG, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f5_arg0:get(),
			modelName = "PCKoreaEventProgression.isCompleted",
		})
	end, false)
	self:addElement(MonthRewardBG)
	self.MonthRewardBG = MonthRewardBG
	DescriptionLineBorder = LUI.UIImage.new(0, 0, 0, 560, 0.5, 0.5, -116.5, -97.5)
	DescriptionLineBorder:setRGB(0.8, 0.8, 0.8)
	DescriptionLineBorder:setImage(RegisterImage(0xC752149A1FA1AAE))
	DescriptionLineBorder:setMaterial(LUI.UIImage.GetCachedMaterial(0x44484DDFAF5C093))
	DescriptionLineBorder:setShaderVector(0, 0, 0, 0, 0)
	DescriptionLineBorder:setupNineSliceShader(6, 6)
	self:addElement(DescriptionLineBorder)
	self.DescriptionLineBorder = DescriptionLineBorder
	DescriptionLineBorder2 = LUI.UIImage.new(0, 0, 0, 560, 0.5, 0.5, -4.5, 14.5)
	DescriptionLineBorder2:setRGB(0.8, 0.8, 0.8)
	DescriptionLineBorder2:setImage(RegisterImage(0xC752149A1FA1AAE))
	DescriptionLineBorder2:setMaterial(LUI.UIImage.GetCachedMaterial(0x44484DDFAF5C093))
	DescriptionLineBorder2:setShaderVector(0, 0, 0, 0, 0)
	DescriptionLineBorder2:setupNineSliceShader(6, 6)
	self:addElement(DescriptionLineBorder2)
	self.DescriptionLineBorder2 = DescriptionLineBorder2
	DescriptionLineBorder3 = LUI.UIImage.new(0, 0, 0, 560, 0.5, 0.5, 107.5, 126.5)
	DescriptionLineBorder3:setRGB(0.8, 0.8, 0.8)
	DescriptionLineBorder3:setImage(RegisterImage(0xC752149A1FA1AAE))
	DescriptionLineBorder3:setMaterial(LUI.UIImage.GetCachedMaterial(0x44484DDFAF5C093))
	DescriptionLineBorder3:setShaderVector(0, 0, 0, 0, 0)
	DescriptionLineBorder3:setupNineSliceShader(6, 6)
	self:addElement(DescriptionLineBorder3)
	self.DescriptionLineBorder3 = DescriptionLineBorder3
	local DescriptionLineBorder4 = LUI.UIImage.new(0.8, 0.8, -218, 229, 0.5, 0.5, -9.5, 9.5)
	DescriptionLineBorder4:setRGB(0.59, 0.59, 0.59)
	DescriptionLineBorder4:setZRot(90)
	DescriptionLineBorder4:setImage(RegisterImage(0xC752149A1FA1AAE))
	DescriptionLineBorder4:setMaterial(LUI.UIImage.GetCachedMaterial(0x44484DDFAF5C093))
	DescriptionLineBorder4:setShaderVector(0, 0, 0, 0, 0)
	DescriptionLineBorder4:setupNineSliceShader(6, 6)
	self:addElement(DescriptionLineBorder4)
	self.DescriptionLineBorder4 = DescriptionLineBorder4
	local DescriptionLineBorder5 = LUI.UIImage.new(0.8, 0.8, -329, 118, 0.5, 0.5, -9.5, 9.5)
	DescriptionLineBorder5:setRGB(0.59, 0.59, 0.59)
	DescriptionLineBorder5:setZRot(90)
	DescriptionLineBorder5:setImage(RegisterImage(0xC752149A1FA1AAE))
	DescriptionLineBorder5:setMaterial(LUI.UIImage.GetCachedMaterial(0x44484DDFAF5C093))
	DescriptionLineBorder5:setShaderVector(0, 0, 0, 0, 0)
	DescriptionLineBorder5:setupNineSliceShader(6, 6)
	self:addElement(DescriptionLineBorder5)
	self.DescriptionLineBorder5 = DescriptionLineBorder5
	local Border = LUI.UIImage.new(0.45, 1.45, -317.5, -317.5, 0.03, 1.03, -14, -14)
	Border:setRGB(0.67, 0.67, 0.67)
	Border:setImage(RegisterImage(0x15BB65132BCEED9))
	Border:setMaterial(LUI.UIImage.GetCachedMaterial(0x44484DDFAF5C093))
	Border:setShaderVector(0, 0, 0, 0, 0)
	Border:setupNineSliceShader(11, 11)
	self:addElement(Border)
	self.Border = Border
	WeekList.id = "WeekList"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.PC_Korea_Event_Month_Progression.__onClose = function(f6_arg0)
	f6_arg0.WeekList:close()
	f6_arg0.MonthRewardBG:close()
end
