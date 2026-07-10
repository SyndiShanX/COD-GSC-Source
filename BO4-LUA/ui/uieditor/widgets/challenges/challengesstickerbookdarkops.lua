require("x64:81384373cfadc50")
require("x64:8efc7e786ceb01e")
require("x64:79fe6ac43673588")
require("x64:7a9db52b8255fe4")
require("x64:38c11a77e96e48c")
CoD.ChallengesStickerbookDarkOps = InheritFrom(LUI.UIElement)
CoD.ChallengesStickerbookDarkOps.__defaultWidth = 1725
CoD.ChallengesStickerbookDarkOps.__defaultHeight = 780
CoD.ChallengesStickerbookDarkOps.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	CoD.BaseUtility.InitControllerModelIfNotSet(f1_arg1, "hudItems.profilingMasterCallingCard", 0)
	self:setClass(CoD.ChallengesStickerbookDarkOps)
	self.id = "ChallengesStickerbookDarkOps"
	self.soundSet = "ChooseDecal"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	local MasterCallingCardWidget = CoD.Challenges_MasterCallingCardWidget.new(f1_arg0, f1_arg1, 0, 0, 15, 1140, 1, 1, -129.5, -29.5)
	MasterCallingCardWidget:mergeStateConditions({
		{
			stateName = "Locked",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "isLocked") and AlwaysFalse()
			end,
		},
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "isLocked")
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
	MasterCallingCardWidget:subscribeToGlobalModel(f1_arg1, "MasterCallingCard", nil, function(model)
		MasterCallingCardWidget:setModel(model, f1_arg1)
	end)
	LUI.OverrideFunction_CallOriginalFirst(MasterCallingCardWidget, "childFocusGained", function(element)
		SetElementModelToFocusedElementModel(f1_arg1, self, element, "CallingCardProfiler")
	end)
	self:addElement(MasterCallingCardWidget)
	self.MasterCallingCardWidget = MasterCallingCardWidget
	local CallingCardGrid = LUI.UIList.new(f1_arg0, f1_arg1, 20, 0, nil, true, false, false, false)
	CallingCardGrid:mergeStateConditions({
		{
			stateName = "Locked",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "Classified",
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
	CallingCardGrid:setLeftRight(0, 0, 15, 1135)
	CallingCardGrid:setTopBottom(0, 0, 19, 583)
	CallingCardGrid:setWidgetType(CoD.Challenges_CallingCardWidget)
	CallingCardGrid:setHorizontalCount(3)
	CallingCardGrid:setVerticalCount(4)
	CallingCardGrid:setSpacing(20)
	CallingCardGrid:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	CallingCardGrid:setVerticalCounter(CoD.verticalCounter)
	CallingCardGrid:setDataSource("DarkOpsCallingCards")
	CallingCardGrid:registerEventHandler("list_item_gain_focus", function(element, event)
		local f11_local0 = nil
		SetElementModelToFocusedElementModel(f1_arg1, self, element, "CallingCardProfiler")
		return f11_local0
	end)
	self:addElement(CallingCardGrid)
	self.CallingCardGrid = CallingCardGrid
	local TitleBG = CoD.Challenges_FrameWidget_TitleBackground.new(f1_arg0, f1_arg1, 0.5, 0.5, 315.5, 848.5, 0, 0, 1, 769)
	TitleBG.HeaderStripeBot:setAlpha(0.5)
	self:addElement(TitleBG)
	self.TitleBG = TitleBG
	local CallingCardProfiler = CoD.Challenges_CallingCardProfiler_DarkOps.new(f1_arg0, f1_arg1, 0, 0, 1181, 1706, 0, 0, 20, 750)
	self:addElement(CallingCardProfiler)
	self.CallingCardProfiler = CallingCardProfiler
	CallingCardProfiler:linkToElementModel(CallingCardGrid, nil, false, function(model)
		CallingCardProfiler:setModel(model, f1_arg1)
	end)
	MasterCallingCardWidget.id = "MasterCallingCardWidget"
	CallingCardGrid.id = "CallingCardGrid"
	CallingCardProfiler.id = "CallingCardProfiler"
	self.__defaultFocus = CallingCardGrid
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ChallengesStickerbookDarkOps.__onClose = function(f13_arg0)
	f13_arg0.CallingCardProfiler:close()
	f13_arg0.MasterCallingCardWidget:close()
	f13_arg0.CallingCardGrid:close()
	f13_arg0.TitleBG:close()
end
