require("x64:8efc7e786ceb01e")
require("x64:79fe6ac43673588")
require("x64:7a9db52b8255fe4")
require("x64:e5789686f9ce588")
CoD.Challenges_MP_Stickerbook_CombatTraining = InheritFrom(LUI.UIElement)
CoD.Challenges_MP_Stickerbook_CombatTraining.__defaultWidth = 1920
CoD.Challenges_MP_Stickerbook_CombatTraining.__defaultHeight = 780
CoD.Challenges_MP_Stickerbook_CombatTraining.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	CoD.BaseUtility.InitControllerModelIfNotSet(f1_arg1, "hudItems.profilingMasterCallingCard", 0)
	self:setClass(CoD.Challenges_MP_Stickerbook_CombatTraining)
	self.id = "Challenges_MP_Stickerbook_CombatTraining"
	self.soundSet = "ChooseDecal"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local CallingCardGrid = LUI.UIList.new(f1_arg0, f1_arg1, 20, 0, nil, true, false, false, false)
	CallingCardGrid:mergeStateConditions({
		{
			stateName = "Locked",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "ClassifiedShowProgress",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "isLocked")
			end,
		},
	})
	CallingCardGrid:linkToElementModel(CallingCardGrid, "isLocked", true, function(model)
		f1_arg0:updateElementState(CallingCardGrid, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "isLocked",
		})
	end)
	CallingCardGrid:setLeftRight(0.5, 0.5, -847.5, 272.5)
	CallingCardGrid:setTopBottom(0.5, 0.5, -366, 198)
	CallingCardGrid:setWidgetType(CoD.Challenges_CallingCardWidget)
	CallingCardGrid:setHorizontalCount(3)
	CallingCardGrid:setVerticalCount(4)
	CallingCardGrid:setSpacing(20)
	CallingCardGrid:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	CallingCardGrid:setDataSource("CombatTrainingCallingCards")
	CallingCardGrid:registerEventHandler("list_item_gain_focus", function(element, event)
		local f5_local0 = nil
		SetElementModelToFocusedElementModel(f1_arg1, self, element, "CTProfiler")
		return f5_local0
	end)
	self:addElement(CallingCardGrid)
	self.CallingCardGrid = CallingCardGrid
	local TitleBG = CoD.Challenges_FrameWidget_TitleBackground.new(f1_arg0, f1_arg1, 0.5, 0.5, 314.5, 847.5, 0.5, 0.5, -389, 379)
	TitleBG.HeaderStripeBot:setAlpha(0.5)
	self:addElement(TitleBG)
	self.TitleBG = TitleBG
	local CTProfiler = CoD.ChallengesCallingCardProfilerCombatTraining.new(f1_arg0, f1_arg1, 0.5, 0.5, 318.5, 843.5, 0.5, 0.5, -366, 366)
	self:addElement(CTProfiler)
	self.CTProfiler = CTProfiler
	local MasterCallingCardWidget = CoD.Challenges_MasterCallingCardWidget.new(f1_arg0, f1_arg1, 0.5, 0.5, -847.5, 277.5, 0.5, 0.5, 266, 366)
	MasterCallingCardWidget:mergeStateConditions({
		{
			stateName = "Classified",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "isLocked")
			end,
		},
		{
			stateName = "Locked",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "isLocked") and AlwaysFalse()
			end,
		},
	})
	MasterCallingCardWidget:linkToElementModel(MasterCallingCardWidget, "isLocked", true, function(model)
		f1_arg0:updateElementState(MasterCallingCardWidget, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "isLocked",
		})
	end)
	MasterCallingCardWidget:linkToElementModel(MasterCallingCardWidget, "percentComplete", true, function(model)
		f1_arg0:updateElementState(MasterCallingCardWidget, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "percentComplete",
		})
	end)
	MasterCallingCardWidget:subscribeToGlobalModel(f1_arg1, "MasterCTCallingCard", nil, function(model)
		MasterCallingCardWidget:setModel(model, f1_arg1)
	end)
	LUI.OverrideFunction_CallOriginalFirst(MasterCallingCardWidget, "childFocusGained", function(element)
		SetElementModelToFocusedElementModel(f1_arg1, self, element, "CTProfiler")
	end)
	self:addElement(MasterCallingCardWidget)
	self.MasterCallingCardWidget = MasterCallingCardWidget
	CTProfiler:linkToElementModel(CallingCardGrid, nil, false, function(model)
		CTProfiler:setModel(model, f1_arg1)
	end)
	self:mergeStateConditions({
		{
			stateName = "MasterCardInFocus",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueGreaterThan(f1_arg1, "hudItems.profilingMasterCallingCard", 0)
			end,
		},
	})
	local f1_local5 = self
	local f1_local6 = self.subscribeToModel
	local f1_local7 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local6(f1_local5, f1_local7["hudItems.profilingMasterCallingCard"], function(f14_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f14_arg0:get(),
			modelName = "hudItems.profilingMasterCallingCard",
		})
	end, false)
	CallingCardGrid.id = "CallingCardGrid"
	MasterCallingCardWidget.id = "MasterCallingCardWidget"
	self.__defaultFocus = CallingCardGrid
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local6 = self
	CoD.ChallengesUtility.SetTotalMasterCTInfo(f1_arg1)
	return self
end
CoD.Challenges_MP_Stickerbook_CombatTraining.__resetProperties = function(f15_arg0)
	f15_arg0.CTProfiler:completeAnimation()
	f15_arg0.CTProfiler:setAlpha(1)
end
CoD.Challenges_MP_Stickerbook_CombatTraining.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(0)
		end,
	},
	MasterCardInFocus = {
		DefaultClip = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(1)
			f17_arg0.CTProfiler:completeAnimation()
			f17_arg0.CTProfiler:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.CTProfiler)
		end,
	},
}
CoD.Challenges_MP_Stickerbook_CombatTraining.__onClose = function(f18_arg0)
	f18_arg0.CTProfiler:close()
	f18_arg0.CallingCardGrid:close()
	f18_arg0.TitleBG:close()
	f18_arg0.MasterCallingCardWidget:close()
end
