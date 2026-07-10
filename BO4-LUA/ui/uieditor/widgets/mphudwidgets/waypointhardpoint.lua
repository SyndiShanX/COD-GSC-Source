require("x64:b3cb3de9a683c02")
require("x64:c68e35524efc8d1")
require("x64:eae785b5338418f")
require("x64:3887b6415ad6188")
require("x64:f1ec649151bc0b8")
require("x64:da622980c9a8593")
require("x64:76c14e1bc07cd98")
CoD.WaypointHardpoint = InheritFrom(LUI.UIElement)
CoD.WaypointHardpoint.__defaultWidth = 120
CoD.WaypointHardpoint.__defaultHeight = 180
CoD.WaypointHardpoint.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WaypointHardpoint)
	self.id = "WaypointHardpoint"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ProgressBarBGBlur = LUI.UIImage.new(0.5, 0.5, -179, 179, 0.5, 0.5, 61, 79)
	ProgressBarBGBlur:setMaterial(LUI.UIImage.GetCachedMaterial(0xE2354BE557C4C7A))
	ProgressBarBGBlur:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(ProgressBarBGBlur)
	self.ProgressBarBGBlur = ProgressBarBGBlur
	local ProgressBarBGTint = LUI.UIImage.new(0.5, 0.5, -179, 179, 0.5, 0.5, 61, 79)
	ProgressBarBGTint:setRGB(0, 0, 0)
	ProgressBarBGTint:setAlpha(0.2)
	self:addElement(ProgressBarBGTint)
	self.ProgressBarBGTint = ProgressBarBGTint
	local ProgressBar = CoD.WaypointProgressBar.new(f1_arg0, f1_arg1, 0.5, 0.5, -175, 175, 0.5, 0.5, 65, 75)
	ProgressBar:linkToElementModel(self, nil, false, function(model)
		ProgressBar:setModel(model, f1_arg1)
	end)
	ProgressBar:linkToElementModel(self, "objId", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			ProgressBar.ProgressBarBacking:setShaderVector(4, CoD.WaypointUtility.SetProgressMeterSegmentationIfNeeded(f1_arg1, 0.01, CoD.GetVectorComponentFromString(f3_local0, 1), CoD.GetVectorComponentFromString(f3_local0, 2), CoD.GetVectorComponentFromString(f3_local0, 3), CoD.GetVectorComponentFromString(f3_local0, 4)))
		end
	end)
	ProgressBar:linkToElementModel(self, "objId", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			ProgressBar.ProgressBarWhite:setShaderVector(4, CoD.WaypointUtility.SetProgressMeterSegmentationIfNeeded(f1_arg1, 0.01, CoD.GetVectorComponentFromString(f4_local0, 1), CoD.GetVectorComponentFromString(f4_local0, 2), CoD.GetVectorComponentFromString(f4_local0, 3), CoD.GetVectorComponentFromString(f4_local0, 4)))
		end
	end)
	ProgressBar:linkToElementModel(self, "objId", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			ProgressBar.ProgressBarColor:setShaderVector(4, CoD.WaypointUtility.SetProgressMeterSegmentationIfNeeded(f1_arg1, 0.01, CoD.GetVectorComponentFromString(f5_local0, 1), CoD.GetVectorComponentFromString(f5_local0, 2), CoD.GetVectorComponentFromString(f5_local0, 3), CoD.GetVectorComponentFromString(f5_local0, 4)))
		end
	end)
	self:addElement(ProgressBar)
	self.ProgressBar = ProgressBar
	local WaypointArrowDownNotClampedContainer = CoD.WaypointArrowContainer.new(f1_arg0, f1_arg1, 0.5, 0.5, -21, 21, 0.5, 0.5, -23, 23)
	WaypointArrowDownNotClampedContainer:mergeStateConditions({
		{
			stateName = "Show",
			condition = function(menu, element, event)
				local f6_local0
				if not ParentObjectivePropertyIsTrue(element, "hide_arrow") and not CoD.HUDUtility.IsObjectiveXHashPropertyValueEqualTo(self, 0x129B22B0CDE96B, 1) then
					f6_local0 = not CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "clamped")
				else
					f6_local0 = false
				end
				return f6_local0
			end,
		},
	})
	WaypointArrowDownNotClampedContainer:linkToElementModel(WaypointArrowDownNotClampedContainer, "id", true, function(model)
		f1_arg0:updateElementState(WaypointArrowDownNotClampedContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "id",
		})
	end)
	WaypointArrowDownNotClampedContainer:linkToElementModel(WaypointArrowDownNotClampedContainer, "clamped", true, function(model)
		f1_arg0:updateElementState(WaypointArrowDownNotClampedContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "clamped",
		})
	end)
	WaypointArrowDownNotClampedContainer:setAlpha(0.95)
	WaypointArrowDownNotClampedContainer:linkToElementModel(self, nil, false, function(model)
		WaypointArrowDownNotClampedContainer:setModel(model, f1_arg1)
	end)
	self:addElement(WaypointArrowDownNotClampedContainer)
	self.WaypointArrowDownNotClampedContainer = WaypointArrowDownNotClampedContainer
	local WaypointArrowContainer = CoD.WaypointArrowContainer.new(f1_arg0, f1_arg1, 0.5, 0.5, -21, 21, 0.5, 0.5, -23, 23)
	WaypointArrowContainer:setAlpha(0.95)
	WaypointArrowContainer:linkToElementModel(self, "direction", true, function(model)
		local f10_local0 = model:get()
		if f10_local0 ~= nil then
			WaypointArrowContainer:setZRot(Add(90, f10_local0))
		end
	end)
	WaypointArrowContainer:linkToElementModel(self, nil, false, function(model)
		WaypointArrowContainer:setModel(model, f1_arg1)
	end)
	self:addElement(WaypointArrowContainer)
	self.WaypointArrowContainer = WaypointArrowContainer
	local WaypointText = CoD.Waypoint_TextBG.new(f1_arg0, f1_arg1, 0.5, 0.5, -60, 60, 0.5, 0.5, -93, -61)
	WaypointText:mergeStateConditions({
		{
			stateName = "Contested",
			condition = function(menu, element, event)
				return CoD.WaypointUtility.ShouldShowWaypointAsContested(f1_arg1, self)
			end,
		},
		{
			stateName = "Protect",
			condition = function(menu, element, event)
				return CoD.WaypointUtility.ShouldShowWaypointAsProtect(f1_arg1, self)
			end,
		},
	})
	WaypointText:linkToElementModel(WaypointText, "clientUseMask", true, function(model)
		f1_arg0:updateElementState(WaypointText, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "clientUseMask",
		})
	end)
	WaypointText:linkToElementModel(WaypointText, "gamemodeFlags", true, function(model)
		f1_arg0:updateElementState(WaypointText, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "gamemodeFlags",
		})
	end)
	WaypointText:linkToElementModel(WaypointText, "distanceText", true, function(model)
		f1_arg0:updateElementState(WaypointText, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "distanceText",
		})
	end)
	WaypointText:linkToElementModel(WaypointText, "clamped", true, function(model)
		f1_arg0:updateElementState(WaypointText, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "clamped",
		})
	end)
	WaypointText:linkToElementModel(WaypointText, "text", true, function(model)
		f1_arg0:updateElementState(WaypointText, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "text",
		})
	end)
	WaypointText:linkToElementModel(self, nil, false, function(model)
		WaypointText:setModel(model, f1_arg1)
	end)
	WaypointText:linkToElementModel(self, "text", true, function(model)
		local f20_local0 = model:get()
		if f20_local0 ~= nil then
			WaypointText.WaypointTextWithBG.text:setText(Engine[0xF9F1239CFD921FE](f20_local0))
		end
	end)
	WaypointText:linkToElementModel(self, "distanceText", true, function(model)
		local f21_local0 = model:get()
		if f21_local0 ~= nil then
			WaypointText.DistanceTextWithBG.text:setText(LocalizeIntoStringIfNotEmpty(0x7235825812D46C6, f21_local0))
		end
	end)
	self:addElement(WaypointText)
	self.WaypointText = WaypointText
	local WaypointBacker = LUI.UIImage.new(0.5, 0.5, -38, 38, 0.5, 0.5, -38, 38)
	WaypointBacker:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	WaypointBacker:linkToElementModel(self, "waypointBacking01", true, function(model)
		local f22_local0 = model:get()
		if f22_local0 ~= nil then
			WaypointBacker:setImage(RegisterImage(f22_local0))
		end
	end)
	self:addElement(WaypointBacker)
	self.WaypointBacker = WaypointBacker
	local WaypointPatternColor = CoD.WaypointHardpoint_ColorPattern.new(f1_arg0, f1_arg1, 0.5, 0.5, -38, 38, 0.5, 0.5, -38, 38)
	WaypointPatternColor:mergeStateConditions({
		{
			stateName = "Contested",
			condition = function(menu, element, event)
				return CoD.WaypointUtility.ShouldShowWaypointAsContested(f1_arg1, self)
			end,
		},
	})
	WaypointPatternColor:linkToElementModel(WaypointPatternColor, "clientUseMask", true, function(model)
		f1_arg0:updateElementState(WaypointPatternColor, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "clientUseMask",
		})
	end)
	WaypointPatternColor:linkToElementModel(self, nil, false, function(model)
		WaypointPatternColor:setModel(model, f1_arg1)
	end)
	self:addElement(WaypointPatternColor)
	self.WaypointPatternColor = WaypointPatternColor
	local WaypointPatternClock = LUI.UIImage.new(0.5, 0.5, -37, 39, 0.5, 0.5, -38, 38)
	WaypointPatternClock:setRGB(0.25, 0.25, 0.25)
	WaypointPatternClock:setAlpha(0.92)
	WaypointPatternClock:setImage(RegisterImage(0x159D9B7B7294C91))
	WaypointPatternClock:setMaterial(LUI.UIImage.GetCachedMaterial(0xD5CA1A25ED87F4F))
	WaypointPatternClock:setShaderVector(1, 0.5, 0, 0, 0)
	WaypointPatternClock:setShaderVector(2, 0.5, 0, 0, 0)
	WaypointPatternClock:setShaderVector(3, 0, 0, 0, 0)
	WaypointPatternClock:setShaderVector(4, 0, 0, 0, 0)
	WaypointPatternClock:subscribeToGlobalModel(f1_arg1, "BombTimer", "bomb0.timeRemainingMilliSec", function(model)
		local f26_local0 = model:get()
		if f26_local0 ~= nil then
			WaypointPatternClock:setShaderVector(0, CoD.HUDUtility.DivideByBombTimeLimit(f1_arg1, 2, SetVectorComponent(1, 1, SwapVectorComponents(1, 2, CoD.GetVectorComponentFromString(f26_local0, 1), CoD.GetVectorComponentFromString(f26_local0, 2), CoD.GetVectorComponentFromString(f26_local0, 3), CoD.GetVectorComponentFromString(f26_local0, 4)))))
		end
	end)
	self:addElement(WaypointPatternClock)
	self.WaypointPatternClock = WaypointPatternClock
	local BombTimer = CoD.WaypointHardpoint_Timer.new(f1_arg0, f1_arg1, 0.5, 0.5, -57, 57, 0.5, 0.5, 51.5, 77.5)
	BombTimer:linkToElementModel(self, nil, false, function(model)
		BombTimer:setModel(model, f1_arg1)
	end)
	self:addElement(BombTimer)
	self.BombTimer = BombTimer
	local WaypointProgressMeterEmpty = LUI.UIImage.new(0.5, 0.5, -38, 38, 0.5, 0.5, -38, 38)
	WaypointProgressMeterEmpty:setRGB(1, 0.98, 0.91)
	WaypointProgressMeterEmpty:linkToElementModel(self, "waypointBacking02", true, function(model)
		local f28_local0 = model:get()
		if f28_local0 ~= nil then
			WaypointProgressMeterEmpty:setImage(RegisterImage(f28_local0))
		end
	end)
	self:addElement(WaypointProgressMeterEmpty)
	self.WaypointProgressMeterEmpty = WaypointProgressMeterEmpty
	local WaypointProgressMeter = CoD.WaypointProgressRing.new(f1_arg0, f1_arg1, 0.5, 0.5, -35, 35, 0.5, 0.5, -35, 35)
	WaypointProgressMeter:linkToElementModel(self, nil, false, function(model)
		WaypointProgressMeter:setModel(model, f1_arg1)
	end)
	WaypointProgressMeter:linkToElementModel(self, "objId", true, function(model)
		local f30_local0 = model:get()
		if f30_local0 ~= nil then
			WaypointProgressMeter.progressMeter:setShaderVector(4, CoD.WaypointUtility.SetProgressMeterSegmentationIfNeeded(f1_arg1, 0.07, CoD.GetVectorComponentFromString(f30_local0, 1), CoD.GetVectorComponentFromString(f30_local0, 2), CoD.GetVectorComponentFromString(f30_local0, 3), CoD.GetVectorComponentFromString(f30_local0, 4)))
		end
	end)
	WaypointProgressMeter:linkToElementModel(self, "objId", true, function(model)
		local f31_local0 = model:get()
		if f31_local0 ~= nil then
			WaypointProgressMeter.progressMeterColoredByUsing:setShaderVector(4, CoD.WaypointUtility.SetProgressMeterSegmentationIfNeeded(f1_arg1, 0.07, CoD.GetVectorComponentFromString(f31_local0, 1), CoD.GetVectorComponentFromString(f31_local0, 2), CoD.GetVectorComponentFromString(f31_local0, 3), CoD.GetVectorComponentFromString(f31_local0, 4)))
		end
	end)
	self:addElement(WaypointProgressMeter)
	self.WaypointProgressMeter = WaypointProgressMeter
	local WaypointCenterIcon = CoD.WaypointHardpoint_ColorIcon.new(f1_arg0, f1_arg1, 0.5, 0.5, -38, 38, 0.5, 0.5, -39, 39)
	WaypointCenterIcon:mergeStateConditions({
		{
			stateName = "Contested",
			condition = function(menu, element, event)
				return CoD.WaypointUtility.ShouldShowWaypointAsContested(f1_arg1, self)
			end,
		},
	})
	WaypointCenterIcon:linkToElementModel(WaypointCenterIcon, "clientUseMask", true, function(model)
		f1_arg0:updateElementState(WaypointCenterIcon, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "clientUseMask",
		})
	end)
	WaypointCenterIcon:linkToElementModel(self, nil, false, function(model)
		WaypointCenterIcon:setModel(model, f1_arg1)
	end)
	self:addElement(WaypointCenterIcon)
	self.WaypointCenterIcon = WaypointCenterIcon
	self:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return CoD.WaypointUtility.ShouldHideWaypoint(element, f1_arg1)
			end,
		},
		{
			stateName = "NoIcon",
			condition = function(menu, element, event)
				return not CoD.WaypointUtility.ShouldShowWaypointIcon(f1_arg1, self)
			end,
		},
		{
			stateName = "ProgressBar",
			condition = function(menu, element, event)
				return CoD.WaypointUtility.ShouldShowWaypointFlatProgressBar(f1_arg1, self)
			end,
		},
		{
			stateName = "NoFrame",
			condition = function(menu, element, event)
				return not CoD.WaypointUtility.ShouldShowWaypointFrame(f1_arg1, self)
			end,
		},
	})
	self:linkToElementModel(self, "team", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "team",
		})
	end)
	self:linkToElementModel(self, "clientUseMask", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "clientUseMask",
		})
	end)
	self:linkToElementModel(self, "state", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "state",
		})
	end)
	self:linkToElementModel(self, "teamMask", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "teamMask",
		})
	end)
	self:linkToElementModel(self, "isOffscreen", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "isOffscreen",
		})
	end)
	local f1_local14 = self
	local f1_local15 = self.subscribeToModel
	local f1_local16 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local15(f1_local14, f1_local16["interactivePrompt.activeObjectiveID"], function(f44_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f44_arg0:get(),
			modelName = "interactivePrompt.activeObjectiveID",
		})
	end, false)
	f1_local14 = self
	f1_local15 = self.subscribeToModel
	f1_local16 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local15(f1_local14, f1_local16["hudItems.hacked"], function(f45_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f45_arg0:get(),
			modelName = "hudItems.hacked",
		})
	end, false)
	f1_local14 = self
	f1_local15 = self.subscribeToModel
	f1_local16 = DataSources.CurrentPrimaryOffhand.getModel(f1_arg1)
	f1_local15(f1_local14, f1_local16.ref, function(f46_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f46_arg0:get(),
			modelName = "ref",
		})
	end, false)
	f1_local14 = self
	f1_local15 = self.subscribeToModel
	f1_local16 = DataSources.LethalOffhands.getModel(f1_arg1)
	f1_local15(f1_local14, f1_local16.activeIndex, function(f47_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f47_arg0:get(),
			modelName = "activeIndex",
		})
	end, false)
	f1_local14 = self
	f1_local15 = self.subscribeToModel
	f1_local16 = DataSources.CurrentPrimaryOffhand.getModel(f1_arg1)
	f1_local15(f1_local14, f1_local16.count, function(f48_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f48_arg0:get(),
			modelName = "count",
		})
	end, false)
	f1_local14 = self
	f1_local15 = self.subscribeToModel
	f1_local16 = DataSources.CurrentSecondaryOffhand.getModel(f1_arg1)
	f1_local15(f1_local14, f1_local16.secondaryOffhand, function(f49_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f49_arg0:get(),
			modelName = "secondaryOffhand",
		})
	end, false)
	f1_local14 = self
	f1_local15 = self.subscribeToModel
	f1_local16 = DataSources.CurrentSecondaryOffhand.getModel(f1_arg1)
	f1_local15(f1_local14, f1_local16.secondaryOffhandCount, function(f50_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f50_arg0:get(),
			modelName = "secondaryOffhandCount",
		})
	end, false)
	f1_local14 = self
	f1_local15 = self.subscribeToModel
	f1_local16 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local15(f1_local14, f1_local16["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x6FFF566DCC09BBD]], function(f51_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f51_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x6FFF566DCC09BBD],
		})
	end, false)
	f1_local14 = self
	f1_local15 = self.subscribeToModel
	f1_local16 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local15(f1_local14, f1_local16["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xADC477DDE486DD7]], function(f52_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f52_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xADC477DDE486DD7],
		})
	end, false)
	f1_local14 = self
	f1_local15 = self.subscribeToModel
	f1_local16 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local15(f1_local14, f1_local16["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x59333FC97F7870]], function(f53_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f53_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x59333FC97F7870],
		})
	end, false)
	f1_local14 = self
	f1_local15 = self.subscribeToModel
	f1_local16 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local15(f1_local14, f1_local16["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x1C630DB86D235A5]], function(f54_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f54_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x1C630DB86D235A5],
		})
	end, false)
	self:linkToElementModel(self, "icon", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "icon",
		})
	end)
	self:linkToElementModel(self, "progress", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "progress",
		})
	end)
	LUI.OverrideFunction_CallOriginalFirst(self, "close", function(element)
		CoD.WaypointUtility.ShowMessageOnCloseIfNeeded(f1_arg1, self)
	end)
	LUI.OverrideFunction_CallOriginalFirst(self, "setModel", function(element, controller)
		CoD.HUDUtility.SetHardpointObjective(self)
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local15 = self
	CoD.HUDUtility.UseHintTextForActiveButtonPromptText(self, f1_arg1)
	CoD.HUDUtility.SetWaypointElementToFadeAlpha(self, self.WaypointText)
	CoD.HUDUtility.SetWaypointElementToFadeAlpha(self, self.WaypointCenter)
	return self
end
CoD.WaypointHardpoint.__resetProperties = function(f59_arg0)
	f59_arg0.WaypointArrowContainer:completeAnimation()
	f59_arg0.WaypointArrowDownNotClampedContainer:completeAnimation()
	f59_arg0.ProgressBar:completeAnimation()
	f59_arg0.ProgressBarBGBlur:completeAnimation()
	f59_arg0.ProgressBarBGTint:completeAnimation()
	f59_arg0.WaypointBacker:completeAnimation()
	f59_arg0.WaypointText:completeAnimation()
	f59_arg0.WaypointProgressMeterEmpty:completeAnimation()
	f59_arg0.WaypointProgressMeter:completeAnimation()
	f59_arg0.BombTimer:completeAnimation()
	f59_arg0.WaypointPatternClock:completeAnimation()
	f59_arg0.WaypointCenterIcon:completeAnimation()
	f59_arg0.WaypointPatternColor:completeAnimation()
	f59_arg0.WaypointArrowContainer:setAlpha(0.95)
	f59_arg0.WaypointArrowDownNotClampedContainer:setAlpha(0.95)
	f59_arg0.ProgressBar:setLeftRight(0.5, 0.5, -175, 175)
	f59_arg0.ProgressBar:setTopBottom(0.5, 0.5, 65, 75)
	f59_arg0.ProgressBar:setAlpha(1)
	f59_arg0.ProgressBarBGBlur:setLeftRight(0.5, 0.5, -179, 179)
	f59_arg0.ProgressBarBGBlur:setTopBottom(0.5, 0.5, 61, 79)
	f59_arg0.ProgressBarBGBlur:setAlpha(1)
	f59_arg0.ProgressBarBGTint:setLeftRight(0.5, 0.5, -179, 179)
	f59_arg0.ProgressBarBGTint:setTopBottom(0.5, 0.5, 61, 79)
	f59_arg0.ProgressBarBGTint:setAlpha(0.2)
	f59_arg0.WaypointBacker:setAlpha(1)
	f59_arg0.WaypointText:setLeftRight(0.5, 0.5, -60, 60)
	f59_arg0.WaypointText:setTopBottom(0.5, 0.5, -93, -61)
	f59_arg0.WaypointText:setAlpha(1)
	f59_arg0.WaypointProgressMeterEmpty:setAlpha(1)
	f59_arg0.WaypointProgressMeter:setLeftRight(0.5, 0.5, -35, 35)
	f59_arg0.WaypointProgressMeter:setTopBottom(0.5, 0.5, -35, 35)
	f59_arg0.WaypointProgressMeter:setAlpha(1)
	f59_arg0.BombTimer:setAlpha(1)
	f59_arg0.WaypointPatternClock:setAlpha(0.92)
	f59_arg0.WaypointCenterIcon:setAlpha(1)
	f59_arg0.WaypointPatternColor:setAlpha(1)
end
CoD.WaypointHardpoint.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f60_arg0, f60_arg1)
			f60_arg0:__resetProperties()
			f60_arg0:setupElementClipCounter(6)
			f60_arg0.ProgressBarBGBlur:completeAnimation()
			f60_arg0.ProgressBarBGBlur:setAlpha(0)
			f60_arg0.clipFinished(f60_arg0.ProgressBarBGBlur)
			f60_arg0.ProgressBarBGTint:completeAnimation()
			f60_arg0.ProgressBarBGTint:setAlpha(0)
			f60_arg0.clipFinished(f60_arg0.ProgressBarBGTint)
			f60_arg0.ProgressBar:completeAnimation()
			f60_arg0.ProgressBar:setAlpha(0)
			f60_arg0.clipFinished(f60_arg0.ProgressBar)
			f60_arg0.WaypointArrowDownNotClampedContainer:completeAnimation()
			f60_arg0.WaypointArrowDownNotClampedContainer:setAlpha(0.95)
			f60_arg0.clipFinished(f60_arg0.WaypointArrowDownNotClampedContainer)
			f60_arg0.WaypointArrowContainer:completeAnimation()
			f60_arg0.WaypointArrowContainer:setAlpha(0.95)
			f60_arg0.clipFinished(f60_arg0.WaypointArrowContainer)
			f60_arg0.WaypointBacker:completeAnimation()
			f60_arg0.WaypointBacker:setAlpha(1)
			f60_arg0.clipFinished(f60_arg0.WaypointBacker)
		end,
	},
	Hidden = {
		DefaultClip = function(f61_arg0, f61_arg1)
			f61_arg0:__resetProperties()
			f61_arg0:setupElementClipCounter(13)
			f61_arg0.ProgressBarBGBlur:completeAnimation()
			f61_arg0.ProgressBarBGBlur:setAlpha(0)
			f61_arg0.clipFinished(f61_arg0.ProgressBarBGBlur)
			f61_arg0.ProgressBarBGTint:completeAnimation()
			f61_arg0.ProgressBarBGTint:setAlpha(0)
			f61_arg0.clipFinished(f61_arg0.ProgressBarBGTint)
			f61_arg0.ProgressBar:completeAnimation()
			f61_arg0.ProgressBar:setAlpha(0)
			f61_arg0.clipFinished(f61_arg0.ProgressBar)
			f61_arg0.WaypointArrowDownNotClampedContainer:completeAnimation()
			f61_arg0.WaypointArrowDownNotClampedContainer:setAlpha(0)
			f61_arg0.clipFinished(f61_arg0.WaypointArrowDownNotClampedContainer)
			f61_arg0.WaypointArrowContainer:completeAnimation()
			f61_arg0.WaypointArrowContainer:setAlpha(0)
			f61_arg0.clipFinished(f61_arg0.WaypointArrowContainer)
			f61_arg0.WaypointText:completeAnimation()
			f61_arg0.WaypointText:setAlpha(0)
			f61_arg0.clipFinished(f61_arg0.WaypointText)
			f61_arg0.WaypointBacker:completeAnimation()
			f61_arg0.WaypointBacker:setAlpha(0)
			f61_arg0.clipFinished(f61_arg0.WaypointBacker)
			f61_arg0.WaypointPatternColor:completeAnimation()
			f61_arg0.WaypointPatternColor:setAlpha(0)
			f61_arg0.clipFinished(f61_arg0.WaypointPatternColor)
			f61_arg0.WaypointPatternClock:completeAnimation()
			f61_arg0.WaypointPatternClock:setAlpha(0)
			f61_arg0.clipFinished(f61_arg0.WaypointPatternClock)
			f61_arg0.BombTimer:completeAnimation()
			f61_arg0.BombTimer:setAlpha(0)
			f61_arg0.clipFinished(f61_arg0.BombTimer)
			f61_arg0.WaypointProgressMeterEmpty:completeAnimation()
			f61_arg0.WaypointProgressMeterEmpty:setAlpha(0)
			f61_arg0.clipFinished(f61_arg0.WaypointProgressMeterEmpty)
			f61_arg0.WaypointProgressMeter:completeAnimation()
			f61_arg0.WaypointProgressMeter:setAlpha(0)
			f61_arg0.clipFinished(f61_arg0.WaypointProgressMeter)
			f61_arg0.WaypointCenterIcon:completeAnimation()
			f61_arg0.WaypointCenterIcon:setAlpha(0)
			f61_arg0.clipFinished(f61_arg0.WaypointCenterIcon)
		end,
	},
	NoIcon = {
		DefaultClip = function(f62_arg0, f62_arg1)
			f62_arg0:__resetProperties()
			f62_arg0:setupElementClipCounter(12)
			f62_arg0.ProgressBarBGBlur:completeAnimation()
			f62_arg0.ProgressBarBGBlur:setAlpha(0)
			f62_arg0.clipFinished(f62_arg0.ProgressBarBGBlur)
			f62_arg0.ProgressBarBGTint:completeAnimation()
			f62_arg0.ProgressBarBGTint:setAlpha(0)
			f62_arg0.clipFinished(f62_arg0.ProgressBarBGTint)
			f62_arg0.ProgressBar:completeAnimation()
			f62_arg0.ProgressBar:setAlpha(0)
			f62_arg0.clipFinished(f62_arg0.ProgressBar)
			f62_arg0.WaypointArrowDownNotClampedContainer:completeAnimation()
			f62_arg0.WaypointArrowDownNotClampedContainer:setAlpha(0.95)
			f62_arg0.clipFinished(f62_arg0.WaypointArrowDownNotClampedContainer)
			f62_arg0.WaypointArrowContainer:completeAnimation()
			f62_arg0.WaypointArrowContainer:setAlpha(0.95)
			f62_arg0.clipFinished(f62_arg0.WaypointArrowContainer)
			f62_arg0.WaypointText:completeAnimation()
			f62_arg0.WaypointText:setLeftRight(0.5, 0.5, -60, 60)
			f62_arg0.WaypointText:setTopBottom(0.5, 0.5, -81, -49)
			f62_arg0.clipFinished(f62_arg0.WaypointText)
			f62_arg0.WaypointBacker:completeAnimation()
			f62_arg0.WaypointBacker:setAlpha(0)
			f62_arg0.clipFinished(f62_arg0.WaypointBacker)
			f62_arg0.WaypointPatternColor:completeAnimation()
			f62_arg0.WaypointPatternColor:setAlpha(0)
			f62_arg0.clipFinished(f62_arg0.WaypointPatternColor)
			f62_arg0.WaypointPatternClock:completeAnimation()
			f62_arg0.WaypointPatternClock:setAlpha(0)
			f62_arg0.clipFinished(f62_arg0.WaypointPatternClock)
			f62_arg0.WaypointProgressMeterEmpty:completeAnimation()
			f62_arg0.WaypointProgressMeterEmpty:setAlpha(0)
			f62_arg0.clipFinished(f62_arg0.WaypointProgressMeterEmpty)
			f62_arg0.WaypointProgressMeter:completeAnimation()
			f62_arg0.WaypointProgressMeter:setAlpha(0)
			f62_arg0.clipFinished(f62_arg0.WaypointProgressMeter)
			f62_arg0.WaypointCenterIcon:completeAnimation()
			f62_arg0.WaypointCenterIcon:setAlpha(0)
			f62_arg0.clipFinished(f62_arg0.WaypointCenterIcon)
		end,
	},
	ProgressBar = {
		DefaultClip = function(f63_arg0, f63_arg1)
			f63_arg0:__resetProperties()
			f63_arg0:setupElementClipCounter(12)
			f63_arg0.ProgressBarBGBlur:completeAnimation()
			f63_arg0.ProgressBarBGBlur:setLeftRight(0.5, 0.5, -179, 179)
			f63_arg0.ProgressBarBGBlur:setTopBottom(0.5, 0.5, -35, -17)
			f63_arg0.ProgressBarBGBlur:setAlpha(1)
			f63_arg0.clipFinished(f63_arg0.ProgressBarBGBlur)
			f63_arg0.ProgressBarBGTint:completeAnimation()
			f63_arg0.ProgressBarBGTint:setLeftRight(0.5, 0.5, -179, 179)
			f63_arg0.ProgressBarBGTint:setTopBottom(0.5, 0.5, -35, -17)
			f63_arg0.clipFinished(f63_arg0.ProgressBarBGTint)
			f63_arg0.ProgressBar:completeAnimation()
			f63_arg0.ProgressBar:setLeftRight(0.5, 0.5, -175, 175)
			f63_arg0.ProgressBar:setTopBottom(0.5, 0.5, -31, -21)
			f63_arg0.ProgressBar:setAlpha(1)
			f63_arg0.clipFinished(f63_arg0.ProgressBar)
			f63_arg0.WaypointArrowDownNotClampedContainer:completeAnimation()
			f63_arg0.WaypointArrowDownNotClampedContainer:setAlpha(0)
			f63_arg0.clipFinished(f63_arg0.WaypointArrowDownNotClampedContainer)
			f63_arg0.WaypointArrowContainer:completeAnimation()
			f63_arg0.WaypointArrowContainer:setAlpha(0)
			f63_arg0.clipFinished(f63_arg0.WaypointArrowContainer)
			f63_arg0.WaypointBacker:completeAnimation()
			f63_arg0.WaypointBacker:setAlpha(0)
			f63_arg0.clipFinished(f63_arg0.WaypointBacker)
			f63_arg0.WaypointPatternColor:completeAnimation()
			f63_arg0.WaypointPatternColor:setAlpha(0)
			f63_arg0.clipFinished(f63_arg0.WaypointPatternColor)
			f63_arg0.WaypointPatternClock:completeAnimation()
			f63_arg0.WaypointPatternClock:setAlpha(0)
			f63_arg0.clipFinished(f63_arg0.WaypointPatternClock)
			f63_arg0.BombTimer:completeAnimation()
			f63_arg0.BombTimer:setAlpha(0)
			f63_arg0.clipFinished(f63_arg0.BombTimer)
			f63_arg0.WaypointProgressMeterEmpty:completeAnimation()
			f63_arg0.WaypointProgressMeterEmpty:setAlpha(0)
			f63_arg0.clipFinished(f63_arg0.WaypointProgressMeterEmpty)
			f63_arg0.WaypointProgressMeter:completeAnimation()
			f63_arg0.WaypointProgressMeter:setLeftRight(0.5, 0.5, -35, 35)
			f63_arg0.WaypointProgressMeter:setTopBottom(0.5, 0.5, -35, 35)
			f63_arg0.WaypointProgressMeter:setAlpha(0)
			f63_arg0.clipFinished(f63_arg0.WaypointProgressMeter)
			f63_arg0.WaypointCenterIcon:completeAnimation()
			f63_arg0.WaypointCenterIcon:setAlpha(0)
			f63_arg0.clipFinished(f63_arg0.WaypointCenterIcon)
		end,
	},
	NoFrame = {
		DefaultClip = function(f64_arg0, f64_arg1)
			f64_arg0:__resetProperties()
			f64_arg0:setupElementClipCounter(7)
			f64_arg0.ProgressBarBGBlur:completeAnimation()
			f64_arg0.ProgressBarBGBlur:setAlpha(0)
			f64_arg0.clipFinished(f64_arg0.ProgressBarBGBlur)
			f64_arg0.ProgressBarBGTint:completeAnimation()
			f64_arg0.ProgressBarBGTint:setAlpha(0)
			f64_arg0.clipFinished(f64_arg0.ProgressBarBGTint)
			f64_arg0.ProgressBar:completeAnimation()
			f64_arg0.ProgressBar:setAlpha(0)
			f64_arg0.clipFinished(f64_arg0.ProgressBar)
			f64_arg0.WaypointArrowDownNotClampedContainer:completeAnimation()
			f64_arg0.WaypointArrowDownNotClampedContainer:setAlpha(0.95)
			f64_arg0.clipFinished(f64_arg0.WaypointArrowDownNotClampedContainer)
			f64_arg0.WaypointArrowContainer:completeAnimation()
			f64_arg0.WaypointArrowContainer:setAlpha(0.95)
			f64_arg0.clipFinished(f64_arg0.WaypointArrowContainer)
			f64_arg0.WaypointProgressMeterEmpty:completeAnimation()
			f64_arg0.WaypointProgressMeterEmpty:setAlpha(1)
			f64_arg0.clipFinished(f64_arg0.WaypointProgressMeterEmpty)
			f64_arg0.WaypointProgressMeter:completeAnimation()
			f64_arg0.WaypointProgressMeter:setAlpha(0)
			f64_arg0.clipFinished(f64_arg0.WaypointProgressMeter)
		end,
	},
}
CoD.WaypointHardpoint.__onClose = function(f65_arg0)
	f65_arg0.ProgressBar:close()
	f65_arg0.WaypointArrowDownNotClampedContainer:close()
	f65_arg0.WaypointArrowContainer:close()
	f65_arg0.WaypointText:close()
	f65_arg0.WaypointBacker:close()
	f65_arg0.WaypointPatternColor:close()
	f65_arg0.WaypointPatternClock:close()
	f65_arg0.BombTimer:close()
	f65_arg0.WaypointProgressMeterEmpty:close()
	f65_arg0.WaypointProgressMeter:close()
	f65_arg0.WaypointCenterIcon:close()
end
