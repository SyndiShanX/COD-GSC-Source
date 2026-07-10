require("x64:c19fef5f3472006")
CoD.OneInTheChamberLives = InheritFrom(LUI.UIElement)
CoD.OneInTheChamberLives.__defaultWidth = 150
CoD.OneInTheChamberLives.__defaultHeight = 50
CoD.OneInTheChamberLives.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.OneInTheChamberLives)
	self.id = "OneInTheChamberLives"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local LifeList = LUI.UIList.new(f1_arg0, f1_arg1, -14, 0, nil, false, false, false, false)
	LifeList:setLeftRight(0.5, 0.5, -50.5, 50.5)
	LifeList:setTopBottom(0.5, 0.5, -21.5, 21.5)
	LifeList:setWidgetType(CoD.OIC_LifePip)
	LifeList:setHorizontalCount(3)
	LifeList:setSpacing(-14)
	LifeList:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	LifeList:setDataSource("OneInTheChamberLifeList")
	self:addElement(LifeList)
	self.LifeList = LifeList
	local LifeSurplusText = LUI.UIText.new(0, 0, 10, 140, 0, 0, 6.5, 43.5)
	LifeSurplusText:setTTF("default")
	LifeSurplusText:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	LifeSurplusText:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	LifeSurplusText:subscribeToGlobalModel(f1_arg1, "HUDItems", "playerLivesCount", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			LifeSurplusText:setText(f2_local0)
		end
	end)
	self:addElement(LifeSurplusText)
	self.LifeSurplusText = LifeSurplusText
	self:mergeStateConditions({
		{
			stateName = "LifeSurplus",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalDataSourceModelValueGreaterThan(f1_arg1, "HUDItems", "playerLivesCount", 5)
			end,
		},
	})
	local f1_local3 = self
	local f1_local4 = self.subscribeToModel
	local f1_local5 = DataSources.HUDItems.getModel(f1_arg1)
	f1_local4(f1_local3, f1_local5.playerLivesCount, function(f4_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f4_arg0:get(),
			modelName = "playerLivesCount",
		})
	end, false)
	LifeList.id = "LifeList"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.OneInTheChamberLives.__resetProperties = function(f5_arg0)
	f5_arg0.LifeSurplusText:completeAnimation()
	f5_arg0.LifeList:completeAnimation()
	f5_arg0.LifeSurplusText:setAlpha(1)
	f5_arg0.LifeList:setAlpha(1)
end
CoD.OneInTheChamberLives.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(1)
			f6_arg0.LifeSurplusText:completeAnimation()
			f6_arg0.LifeSurplusText:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.LifeSurplusText)
		end,
	},
	LifeSurplus = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			f7_arg0.LifeList:completeAnimation()
			f7_arg0.LifeList:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.LifeList)
		end,
	},
}
CoD.OneInTheChamberLives.__onClose = function(f8_arg0)
	f8_arg0.LifeList:close()
	f8_arg0.LifeSurplusText:close()
end
