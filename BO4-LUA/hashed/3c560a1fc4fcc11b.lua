require("x64:1e60cbe5188f2c2")
require("x64:6a31173ca2293cf")
require("x64:d5c930d2fd55eb0")
CoD.MeritOverlayBoardWithMedals = InheritFrom(LUI.UIElement)
CoD.MeritOverlayBoardWithMedals.__defaultWidth = 540
CoD.MeritOverlayBoardWithMedals.__defaultHeight = 628
CoD.MeritOverlayBoardWithMedals.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.MeritOverlayBoardWithMedals)
	self.id = "MeritOverlayBoardWithMedals"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local MeritOverlayManualLayoutVerticalBG = CoD.MeritOverlayManualLayoutVerticalBG.new(f1_arg0, f1_arg1, 0.5, 0.5, -270, 270, 0.5, 0.5, -314, 314)
	MeritOverlayManualLayoutVerticalBG:linkToElementModel(self, nil, false, function(model)
		MeritOverlayManualLayoutVerticalBG:setModel(model, f1_arg1)
	end)
	self:addElement(MeritOverlayManualLayoutVerticalBG)
	self.MeritOverlayManualLayoutVerticalBG = MeritOverlayManualLayoutVerticalBG
	local MeritOverlayManualLayoutVertical = CoD.MeritOverlayManualLayoutVertical.new(f1_arg0, f1_arg1, 0.5, 0.5, -180, 180, 0.5, 0.5, -187, 71)
	MeritOverlayManualLayoutVertical:mergeStateConditions({
		{
			stateName = "FiveEntriesNoIntro",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueGreaterThan(element, f1_arg1, "numInGameEntries", 4) and CoD.BaseUtility.IsSelfInState(self, "NoIntro")
			end,
		},
		{
			stateName = "FiveEntries",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueGreaterThan(element, f1_arg1, "numInGameEntries", 4) and not CoD.BaseUtility.IsSelfInState(self, "NoIntro")
			end,
		},
		{
			stateName = "FourEntriesNoIntro",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueGreaterThan(element, f1_arg1, "numInGameEntries", 3) and CoD.BaseUtility.IsSelfInState(self, "NoIntro")
			end,
		},
		{
			stateName = "FourEntries",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueGreaterThan(element, f1_arg1, "numInGameEntries", 3) and not CoD.BaseUtility.IsSelfInState(self, "NoIntro")
			end,
		},
		{
			stateName = "ThreeEntriesNoIntro",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueGreaterThan(element, f1_arg1, "numInGameEntries", 2) and CoD.BaseUtility.IsSelfInState(self, "NoIntro")
			end,
		},
		{
			stateName = "ThreeEntries",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueGreaterThan(element, f1_arg1, "numInGameEntries", 2) and not CoD.BaseUtility.IsSelfInState(self, "NoIntro")
			end,
		},
		{
			stateName = "TwoEntriesNoIntro",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueGreaterThan(element, f1_arg1, "numInGameEntries", 1) and CoD.BaseUtility.IsSelfInState(self, "NoIntro")
			end,
		},
		{
			stateName = "TwoEntries",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueGreaterThan(element, f1_arg1, "numInGameEntries", 1) and not CoD.BaseUtility.IsSelfInState(self, "NoIntro")
			end,
		},
		{
			stateName = "OneEntryNoIntro",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueGreaterThan(element, f1_arg1, "numInGameEntries", 0) and CoD.BaseUtility.IsSelfInState(self, "NoIntro")
			end,
		},
		{
			stateName = "OneEntry",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueGreaterThan(element, f1_arg1, "numInGameEntries", 0) and not CoD.BaseUtility.IsSelfInState(self, "NoIntro")
			end,
		},
	})
	MeritOverlayManualLayoutVertical:linkToElementModel(MeritOverlayManualLayoutVertical, "numInGameEntries", true, function(model)
		f1_arg0:updateElementState(MeritOverlayManualLayoutVertical, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "numInGameEntries",
		})
	end)
	MeritOverlayManualLayoutVertical:linkToElementModel(self, nil, false, function(model)
		MeritOverlayManualLayoutVertical:setModel(model, f1_arg1)
	end)
	self:addElement(MeritOverlayManualLayoutVertical)
	self.MeritOverlayManualLayoutVertical = MeritOverlayManualLayoutVertical
	local AAREchelon = CoD.AAREchelon.new(f1_arg0, f1_arg1, 0, 0, 70, 470, 0, 0, 77, 477)
	AAREchelon.NoiseTiledBacking:setAlpha(1)
	AAREchelon:linkToElementModel(self, nil, false, function(model)
		AAREchelon:setModel(model, f1_arg1)
	end)
	self:addElement(AAREchelon)
	self.AAREchelon = AAREchelon
	self:mergeStateConditions({
		{
			stateName = "NoIntro",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	LUI.OverrideFunction_CallOriginalFirst(self, "setState", function(element, controller, f17_arg2, f17_arg3, f17_arg4)
		UpdateElementState(self, "MeritOverlayManualLayoutVertical", controller)
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.MeritOverlayBoardWithMedals.__onClose = function(f18_arg0)
	f18_arg0.MeritOverlayManualLayoutVerticalBG:close()
	f18_arg0.MeritOverlayManualLayoutVertical:close()
	f18_arg0.AAREchelon:close()
end
