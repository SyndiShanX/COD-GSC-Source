require("x64:e8e522d028bff36")
CoD.LaboratoryBottleLabelList = InheritFrom(LUI.UIElement)
CoD.LaboratoryBottleLabelList.__defaultWidth = 1342
CoD.LaboratoryBottleLabelList.__defaultHeight = 60
CoD.LaboratoryBottleLabelList.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.LaboratoryBottleLabelList)
	self.id = "LaboratoryBottleLabelList"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local BottleLabels = LUI.UIList.new(f1_arg0, f1_arg1, 100, 0, nil, false, false, false, false)
	BottleLabels:setLeftRight(0.5, 0.5, -800, 800)
	BottleLabels:setTopBottom(0, 0, 0, 90)
	BottleLabels:setWidgetType(CoD.LaboratoryElixirLabel)
	BottleLabels:setHorizontalCount(4)
	BottleLabels:setSpacing(100)
	BottleLabels:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	BottleLabels:setDataSource("ZMLaboratoryResultsItemList")
	BottleLabels:subscribeToGlobalModel(f1_arg1, "PerController", "Laboratory.firstBottleFilled", function(model)
		local f2_local0 = BottleLabels
		if CoD.ModelUtility.IsModelValueEqualTo(f1_arg1, "Laboratory.firstBottleFilled", 1) then
			CoD.ZMLaboratoryUtility.SetListElementModelsWithDelay(f1_arg1, f2_local0, "visible", 1, 400, 3)
		elseif CoD.ModelUtility.IsModelValueEqualTo(f1_arg1, "Laboratory.firstBottleFilled", 0) then
			CoD.ZMLaboratoryUtility.SetListElementModelsWithDelay(f1_arg1, f2_local0, "visible", 0, 400)
		end
	end)
	self:addElement(BottleLabels)
	self.BottleLabels = BottleLabels
	self:mergeStateConditions({
		{
			stateName = "ScaledDown",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueEqualTo(f1_arg1, "Laboratory.shrinkLabelList", 1)
			end,
		},
	})
	local f1_local2 = self
	local f1_local3 = self.subscribeToModel
	local f1_local4 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local3(f1_local2, f1_local4["Laboratory.shrinkLabelList"], function(f4_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f4_arg0:get(),
			modelName = "Laboratory.shrinkLabelList",
		})
	end, false)
	BottleLabels.id = "BottleLabels"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.LaboratoryBottleLabelList.__resetProperties = function(f5_arg0)
	f5_arg0.BottleLabels:completeAnimation()
	f5_arg0.BottleLabels:setLeftRight(0.5, 0.5, -800, 800)
	f5_arg0.BottleLabels:setTopBottom(0, 0, 0, 90)
	f5_arg0.BottleLabels:setScale(1, 1)
end
CoD.LaboratoryBottleLabelList.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(1)
			f6_arg0.BottleLabels:completeAnimation()
			f6_arg0.BottleLabels:setLeftRight(0, 0, 0, 1642)
			f6_arg0.BottleLabels:setTopBottom(0, 0, 0, 60)
			f6_arg0.BottleLabels:setScale(1, 1)
			f6_arg0.clipFinished(f6_arg0.BottleLabels)
		end,
		ScaledDown = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			local f7_local0 = function(f8_arg0)
				f7_arg0.BottleLabels:beginAnimation(1000)
				f7_arg0.BottleLabels:setLeftRight(0, 0, 211, 1853)
				f7_arg0.BottleLabels:setTopBottom(0, 0, -23, 37)
				f7_arg0.BottleLabels:setScale(0.65, 0.65)
				f7_arg0.BottleLabels:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.BottleLabels:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
			end
			f7_arg0.BottleLabels:completeAnimation()
			f7_arg0.BottleLabels:setLeftRight(0, 0, 0, 1642)
			f7_arg0.BottleLabels:setTopBottom(0, 0, 0, 60)
			f7_arg0.BottleLabels:setScale(1, 1)
			f7_local0(f7_arg0.BottleLabels)
		end,
	},
	ScaledDown = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(1)
			f9_arg0.BottleLabels:completeAnimation()
			f9_arg0.BottleLabels:setLeftRight(0, 0, 211, 1853)
			f9_arg0.BottleLabels:setTopBottom(0, 0, -23, 37)
			f9_arg0.BottleLabels:setScale(0.65, 0.65)
			f9_arg0.clipFinished(f9_arg0.BottleLabels)
		end,
	},
}
CoD.LaboratoryBottleLabelList.__onClose = function(f10_arg0)
	f10_arg0.BottleLabels:close()
end
