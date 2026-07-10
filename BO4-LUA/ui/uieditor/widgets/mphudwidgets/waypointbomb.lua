require("x64:b3cb3de9a683c02")
require("x64:c68e35524efc8d1")
require("x64:b4f84b3d9622974")
require("x64:fb2a50f7282d0bf")
require("x64:27411b1d207dbc8")
require("x64:da622980c9a8593")
require("x64:76c14e1bc07cd98")
CoD.WaypointBomb = InheritFrom(LUI.UIElement)
CoD.WaypointBomb.__defaultWidth = 120
CoD.WaypointBomb.__defaultHeight = 180
CoD.WaypointBomb.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WaypointBomb)
	self.id = "WaypointBomb"
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
	local WaypointText = CoD.Waypoint_TextBG.new(f1_arg0, f1_arg1, 0.5, 0.5, -60, 60, 0.5, 0.5, -88, -56)
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
	local WaypointPattern = LUI.UIImage.new(0.5, 0.5, -37, 39, 0.5, 0.5, -38, 38)
	WaypointPattern:setAlpha(0.92)
	WaypointPattern:setImage(RegisterImage(0x159D9B7B7294C91))
	WaypointPattern:linkToElementModel(self, "color", true, function(model)
		local f23_local0 = model:get()
		if f23_local0 ~= nil then
			WaypointPattern:setRGB(CoD.WaypointUtility.ConvertToBaseColor(f23_local0))
		end
	end)
	self:addElement(WaypointPattern)
	self.WaypointPattern = WaypointPattern
	local ArrowRight = CoD.WaypointBomb_PlantArrowWidget.new(f1_arg0, f1_arg1, 0.5, 0.5, 48, 72, 0.5, 0.5, -12, 12)
	ArrowRight:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "gamemodeFlags", 1)
			end,
		},
	})
	ArrowRight:linkToElementModel(ArrowRight, "gamemodeFlags", true, function(model)
		f1_arg0:updateElementState(ArrowRight, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "gamemodeFlags",
		})
	end)
	ArrowRight:linkToElementModel(self, "color", true, function(model)
		local f26_local0 = model:get()
		if f26_local0 ~= nil then
			ArrowRight:setRGB(CoD.WaypointUtility.ConvertToBaseColor(f26_local0))
		end
	end)
	ArrowRight:linkToElementModel(self, nil, false, function(model)
		ArrowRight:setModel(model, f1_arg1)
	end)
	self:addElement(ArrowRight)
	self.ArrowRight = ArrowRight
	local ArrowLeft = CoD.WaypointBomb_PlantArrowWidget.new(f1_arg0, f1_arg1, 0.5, 0.5, -72, -48, 0.5, 0.5, -12, 12)
	ArrowLeft:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "gamemodeFlags", 1)
			end,
		},
	})
	ArrowLeft:linkToElementModel(ArrowLeft, "gamemodeFlags", true, function(model)
		f1_arg0:updateElementState(ArrowLeft, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "gamemodeFlags",
		})
	end)
	ArrowLeft:setYRot(180)
	ArrowLeft:linkToElementModel(self, "color", true, function(model)
		local f30_local0 = model:get()
		if f30_local0 ~= nil then
			ArrowLeft:setRGB(CoD.WaypointUtility.ConvertToBaseColor(f30_local0))
		end
	end)
	ArrowLeft:linkToElementModel(self, nil, false, function(model)
		ArrowLeft:setModel(model, f1_arg1)
	end)
	self:addElement(ArrowLeft)
	self.ArrowLeft = ArrowLeft
	local BombTimer = CoD.WaypointBomb_Timer.new(f1_arg0, f1_arg1, 0.5, 0.5, -57, 57, 0.5, 0.5, 61.5, 88.5)
	BombTimer:mergeStateConditions({
		{
			stateName = "TimeLow",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "gamemodeFlags", 1) and CoD.ModelUtility.IsModelValueEqualTo(f1_arg1, "gameScore.gameTimeLow", 1)
			end,
		},
		{
			stateName = "Active",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "gamemodeFlags", 1)
			end,
		},
	})
	BombTimer:linkToElementModel(BombTimer, "gamemodeFlags", true, function(model)
		f1_arg0:updateElementState(BombTimer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "gamemodeFlags",
		})
	end)
	local WaypointProgressMeter = BombTimer
	local WaypointProgressMeterEmpty = BombTimer.subscribeToModel
	local WaypointCenterIcon2 = Engine[0x4DF5CFBC1771947](f1_arg1)
	WaypointProgressMeterEmpty(WaypointProgressMeter, WaypointCenterIcon2["gameScore.gameTimeLow"], function(f35_arg0)
		f1_arg0:updateElementState(BombTimer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f35_arg0:get(),
			modelName = "gameScore.gameTimeLow",
		})
	end, false)
	BombTimer:linkToElementModel(self, nil, false, function(model)
		BombTimer:setModel(model, f1_arg1)
	end)
	self:addElement(BombTimer)
	self.BombTimer = BombTimer
	WaypointProgressMeterEmpty = LUI.UIImage.new(0.5, 0.5, -38, 38, 0.5, 0.5, -38, 38)
	WaypointProgressMeterEmpty:setRGB(1, 0.98, 0.91)
	WaypointProgressMeterEmpty:linkToElementModel(self, "waypointBacking02", true, function(model)
		local f37_local0 = model:get()
		if f37_local0 ~= nil then
			WaypointProgressMeterEmpty:setImage(RegisterImage(f37_local0))
		end
	end)
	self:addElement(WaypointProgressMeterEmpty)
	self.WaypointProgressMeterEmpty = WaypointProgressMeterEmpty
	WaypointProgressMeter = CoD.WaypointProgressRing.new(f1_arg0, f1_arg1, 0.5, 0.5, -35, 35, 0.5, 0.5, -35, 35)
	WaypointProgressMeter:linkToElementModel(self, nil, false, function(model)
		WaypointProgressMeter:setModel(model, f1_arg1)
	end)
	WaypointProgressMeter:linkToElementModel(self, "objId", true, function(model)
		local f39_local0 = model:get()
		if f39_local0 ~= nil then
			WaypointProgressMeter.progressMeter:setShaderVector(4, CoD.WaypointUtility.SetProgressMeterSegmentationIfNeeded(f1_arg1, 0.07, CoD.GetVectorComponentFromString(f39_local0, 1), CoD.GetVectorComponentFromString(f39_local0, 2), CoD.GetVectorComponentFromString(f39_local0, 3), CoD.GetVectorComponentFromString(f39_local0, 4)))
		end
	end)
	WaypointProgressMeter:linkToElementModel(self, "objId", true, function(model)
		local f40_local0 = model:get()
		if f40_local0 ~= nil then
			WaypointProgressMeter.progressMeterColoredByUsing:setShaderVector(4, CoD.WaypointUtility.SetProgressMeterSegmentationIfNeeded(f1_arg1, 0.07, CoD.GetVectorComponentFromString(f40_local0, 1), CoD.GetVectorComponentFromString(f40_local0, 2), CoD.GetVectorComponentFromString(f40_local0, 3), CoD.GetVectorComponentFromString(f40_local0, 4)))
		end
	end)
	self:addElement(WaypointProgressMeter)
	self.WaypointProgressMeter = WaypointProgressMeter
	WaypointCenterIcon2 = CoD.WaypointCenter.new(f1_arg0, f1_arg1, 0.5, 0.5, -38, 38, 0.5, 0.5, -36, 40)
	WaypointCenterIcon2:setAlpha(0.1)
	WaypointCenterIcon2:linkToElementModel(self, nil, false, function(model)
		WaypointCenterIcon2:setModel(model, f1_arg1)
	end)
	self:addElement(WaypointCenterIcon2)
	self.WaypointCenterIcon2 = WaypointCenterIcon2
	local WaypointCenterIcon = CoD.WaypointCenter.new(f1_arg0, f1_arg1, 0.5, 0.5, -38, 38, 0.5, 0.5, -38, 38)
	WaypointCenterIcon:linkToElementModel(self, nil, false, function(model)
		WaypointCenterIcon:setModel(model, f1_arg1)
	end)
	self:addElement(WaypointCenterIcon)
	self.WaypointCenterIcon = WaypointCenterIcon
	self:mergeStateConditions({
		{
			stateName = "Explosion",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "gamemodeFlags", 2)
			end,
		},
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
	self:linkToElementModel(self, "gamemodeFlags", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "gamemodeFlags",
		})
	end)
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
	local f1_local16 = self
	local f1_local17 = self.subscribeToModel
	local f1_local18 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local17(f1_local16, f1_local18["interactivePrompt.activeObjectiveID"], function(f54_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f54_arg0:get(),
			modelName = "interactivePrompt.activeObjectiveID",
		})
	end, false)
	f1_local16 = self
	f1_local17 = self.subscribeToModel
	f1_local18 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local17(f1_local16, f1_local18["hudItems.hacked"], function(f55_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f55_arg0:get(),
			modelName = "hudItems.hacked",
		})
	end, false)
	f1_local16 = self
	f1_local17 = self.subscribeToModel
	f1_local18 = DataSources.CurrentPrimaryOffhand.getModel(f1_arg1)
	f1_local17(f1_local16, f1_local18.ref, function(f56_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f56_arg0:get(),
			modelName = "ref",
		})
	end, false)
	f1_local16 = self
	f1_local17 = self.subscribeToModel
	f1_local18 = DataSources.LethalOffhands.getModel(f1_arg1)
	f1_local17(f1_local16, f1_local18.activeIndex, function(f57_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f57_arg0:get(),
			modelName = "activeIndex",
		})
	end, false)
	f1_local16 = self
	f1_local17 = self.subscribeToModel
	f1_local18 = DataSources.CurrentPrimaryOffhand.getModel(f1_arg1)
	f1_local17(f1_local16, f1_local18.count, function(f58_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f58_arg0:get(),
			modelName = "count",
		})
	end, false)
	f1_local16 = self
	f1_local17 = self.subscribeToModel
	f1_local18 = DataSources.CurrentSecondaryOffhand.getModel(f1_arg1)
	f1_local17(f1_local16, f1_local18.secondaryOffhand, function(f59_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f59_arg0:get(),
			modelName = "secondaryOffhand",
		})
	end, false)
	f1_local16 = self
	f1_local17 = self.subscribeToModel
	f1_local18 = DataSources.CurrentSecondaryOffhand.getModel(f1_arg1)
	f1_local17(f1_local16, f1_local18.secondaryOffhandCount, function(f60_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f60_arg0:get(),
			modelName = "secondaryOffhandCount",
		})
	end, false)
	f1_local16 = self
	f1_local17 = self.subscribeToModel
	f1_local18 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local17(f1_local16, f1_local18["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x6FFF566DCC09BBD]], function(f61_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f61_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x6FFF566DCC09BBD],
		})
	end, false)
	f1_local16 = self
	f1_local17 = self.subscribeToModel
	f1_local18 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local17(f1_local16, f1_local18["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xADC477DDE486DD7]], function(f62_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f62_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xADC477DDE486DD7],
		})
	end, false)
	f1_local16 = self
	f1_local17 = self.subscribeToModel
	f1_local18 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local17(f1_local16, f1_local18["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x59333FC97F7870]], function(f63_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f63_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x59333FC97F7870],
		})
	end, false)
	f1_local16 = self
	f1_local17 = self.subscribeToModel
	f1_local18 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local17(f1_local16, f1_local18["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x1C630DB86D235A5]], function(f64_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f64_arg0:get(),
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
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local17 = self
	CoD.HUDUtility.UseHintTextForActiveButtonPromptText(self, f1_arg1)
	CoD.HUDUtility.SetWaypointElementToFadeAlpha(self, self.WaypointText)
	CoD.HUDUtility.SetWaypointElementToFadeAlpha(self, self.WaypointCenter)
	return self
end
CoD.WaypointBomb.__resetProperties = function(f68_arg0)
	f68_arg0.WaypointArrowContainer:completeAnimation()
	f68_arg0.WaypointArrowDownNotClampedContainer:completeAnimation()
	f68_arg0.ProgressBar:completeAnimation()
	f68_arg0.ProgressBarBGBlur:completeAnimation()
	f68_arg0.ProgressBarBGTint:completeAnimation()
	f68_arg0.WaypointBacker:completeAnimation()
	f68_arg0.WaypointCenterIcon2:completeAnimation()
	f68_arg0.WaypointText:completeAnimation()
	f68_arg0.WaypointProgressMeterEmpty:completeAnimation()
	f68_arg0.WaypointProgressMeter:completeAnimation()
	f68_arg0.WaypointCenterIcon:completeAnimation()
	f68_arg0.WaypointPattern:completeAnimation()
	f68_arg0.ArrowRight:completeAnimation()
	f68_arg0.ArrowLeft:completeAnimation()
	f68_arg0.BombTimer:completeAnimation()
	f68_arg0.WaypointArrowContainer:setAlpha(0.95)
	f68_arg0.WaypointArrowDownNotClampedContainer:setAlpha(0.95)
	f68_arg0.ProgressBar:setLeftRight(0.5, 0.5, -175, 175)
	f68_arg0.ProgressBar:setTopBottom(0.5, 0.5, 65, 75)
	f68_arg0.ProgressBar:setAlpha(1)
	f68_arg0.ProgressBarBGBlur:setLeftRight(0.5, 0.5, -179, 179)
	f68_arg0.ProgressBarBGBlur:setTopBottom(0.5, 0.5, 61, 79)
	f68_arg0.ProgressBarBGBlur:setAlpha(1)
	f68_arg0.ProgressBarBGTint:setLeftRight(0.5, 0.5, -179, 179)
	f68_arg0.ProgressBarBGTint:setTopBottom(0.5, 0.5, 61, 79)
	f68_arg0.ProgressBarBGTint:setAlpha(0.2)
	f68_arg0.WaypointBacker:setAlpha(1)
	f68_arg0.WaypointCenterIcon2:setAlpha(0.1)
	f68_arg0.WaypointText:setLeftRight(0.5, 0.5, -60, 60)
	f68_arg0.WaypointText:setTopBottom(0.5, 0.5, -88, -56)
	f68_arg0.WaypointText:setAlpha(1)
	f68_arg0.WaypointProgressMeterEmpty:setAlpha(1)
	f68_arg0.WaypointProgressMeter:setLeftRight(0.5, 0.5, -35, 35)
	f68_arg0.WaypointProgressMeter:setTopBottom(0.5, 0.5, -35, 35)
	f68_arg0.WaypointProgressMeter:setAlpha(1)
	f68_arg0.WaypointCenterIcon:setAlpha(1)
	f68_arg0.WaypointPattern:setAlpha(0.92)
	f68_arg0.ArrowRight:setAlpha(1)
	f68_arg0.ArrowLeft:setAlpha(1)
	f68_arg0.BombTimer:setAlpha(1)
end
CoD.WaypointBomb.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f69_arg0, f69_arg1)
			f69_arg0:__resetProperties()
			f69_arg0:setupElementClipCounter(6)
			f69_arg0.ProgressBarBGBlur:completeAnimation()
			f69_arg0.ProgressBarBGBlur:setAlpha(0)
			f69_arg0.clipFinished(f69_arg0.ProgressBarBGBlur)
			f69_arg0.ProgressBarBGTint:completeAnimation()
			f69_arg0.ProgressBarBGTint:setAlpha(0)
			f69_arg0.clipFinished(f69_arg0.ProgressBarBGTint)
			f69_arg0.ProgressBar:completeAnimation()
			f69_arg0.ProgressBar:setAlpha(0)
			f69_arg0.clipFinished(f69_arg0.ProgressBar)
			f69_arg0.WaypointArrowDownNotClampedContainer:completeAnimation()
			f69_arg0.WaypointArrowDownNotClampedContainer:setAlpha(0.95)
			f69_arg0.clipFinished(f69_arg0.WaypointArrowDownNotClampedContainer)
			f69_arg0.WaypointArrowContainer:completeAnimation()
			f69_arg0.WaypointArrowContainer:setAlpha(0.95)
			f69_arg0.clipFinished(f69_arg0.WaypointArrowContainer)
			f69_arg0.WaypointBacker:completeAnimation()
			f69_arg0.WaypointBacker:setAlpha(1)
			f69_arg0.clipFinished(f69_arg0.WaypointBacker)
		end,
	},
	Explosion = {
		DefaultClip = function(f70_arg0, f70_arg1)
			f70_arg0:__resetProperties()
			f70_arg0:setupElementClipCounter(6)
			f70_arg0.ProgressBarBGBlur:completeAnimation()
			f70_arg0.ProgressBarBGBlur:setAlpha(0)
			f70_arg0.clipFinished(f70_arg0.ProgressBarBGBlur)
			f70_arg0.ProgressBarBGTint:completeAnimation()
			f70_arg0.ProgressBarBGTint:setAlpha(0)
			f70_arg0.clipFinished(f70_arg0.ProgressBarBGTint)
			f70_arg0.ProgressBar:completeAnimation()
			f70_arg0.ProgressBar:setAlpha(0)
			f70_arg0.clipFinished(f70_arg0.ProgressBar)
			f70_arg0.WaypointArrowDownNotClampedContainer:completeAnimation()
			f70_arg0.WaypointArrowDownNotClampedContainer:setAlpha(0.95)
			f70_arg0.clipFinished(f70_arg0.WaypointArrowDownNotClampedContainer)
			f70_arg0.WaypointArrowContainer:completeAnimation()
			f70_arg0.WaypointArrowContainer:setAlpha(0.95)
			f70_arg0.clipFinished(f70_arg0.WaypointArrowContainer)
			f70_arg0.WaypointBacker:completeAnimation()
			f70_arg0.WaypointBacker:setAlpha(1)
			f70_arg0.clipFinished(f70_arg0.WaypointBacker)
			f70_arg0.nextClip = "DefaultClip"
		end,
	},
	Hidden = {
		DefaultClip = function(f71_arg0, f71_arg1)
			f71_arg0:__resetProperties()
			f71_arg0:setupElementClipCounter(15)
			f71_arg0.ProgressBarBGBlur:completeAnimation()
			f71_arg0.ProgressBarBGBlur:setAlpha(0)
			f71_arg0.clipFinished(f71_arg0.ProgressBarBGBlur)
			f71_arg0.ProgressBarBGTint:completeAnimation()
			f71_arg0.ProgressBarBGTint:setAlpha(0)
			f71_arg0.clipFinished(f71_arg0.ProgressBarBGTint)
			f71_arg0.ProgressBar:completeAnimation()
			f71_arg0.ProgressBar:setAlpha(0)
			f71_arg0.clipFinished(f71_arg0.ProgressBar)
			f71_arg0.WaypointArrowDownNotClampedContainer:completeAnimation()
			f71_arg0.WaypointArrowDownNotClampedContainer:setAlpha(0)
			f71_arg0.clipFinished(f71_arg0.WaypointArrowDownNotClampedContainer)
			f71_arg0.WaypointArrowContainer:completeAnimation()
			f71_arg0.WaypointArrowContainer:setAlpha(0)
			f71_arg0.clipFinished(f71_arg0.WaypointArrowContainer)
			f71_arg0.WaypointText:completeAnimation()
			f71_arg0.WaypointText:setAlpha(0)
			f71_arg0.clipFinished(f71_arg0.WaypointText)
			f71_arg0.WaypointBacker:completeAnimation()
			f71_arg0.WaypointBacker:setAlpha(0)
			f71_arg0.clipFinished(f71_arg0.WaypointBacker)
			f71_arg0.WaypointPattern:completeAnimation()
			f71_arg0.WaypointPattern:setAlpha(0)
			f71_arg0.clipFinished(f71_arg0.WaypointPattern)
			f71_arg0.ArrowRight:completeAnimation()
			f71_arg0.ArrowRight:setAlpha(0)
			f71_arg0.clipFinished(f71_arg0.ArrowRight)
			f71_arg0.ArrowLeft:completeAnimation()
			f71_arg0.ArrowLeft:setAlpha(0)
			f71_arg0.clipFinished(f71_arg0.ArrowLeft)
			f71_arg0.BombTimer:completeAnimation()
			f71_arg0.BombTimer:setAlpha(0)
			f71_arg0.clipFinished(f71_arg0.BombTimer)
			f71_arg0.WaypointProgressMeterEmpty:completeAnimation()
			f71_arg0.WaypointProgressMeterEmpty:setAlpha(0)
			f71_arg0.clipFinished(f71_arg0.WaypointProgressMeterEmpty)
			f71_arg0.WaypointProgressMeter:completeAnimation()
			f71_arg0.WaypointProgressMeter:setAlpha(0)
			f71_arg0.clipFinished(f71_arg0.WaypointProgressMeter)
			f71_arg0.WaypointCenterIcon2:completeAnimation()
			f71_arg0.WaypointCenterIcon2:setAlpha(0)
			f71_arg0.clipFinished(f71_arg0.WaypointCenterIcon2)
			f71_arg0.WaypointCenterIcon:completeAnimation()
			f71_arg0.WaypointCenterIcon:setAlpha(0)
			f71_arg0.clipFinished(f71_arg0.WaypointCenterIcon)
		end,
	},
	NoIcon = {
		DefaultClip = function(f72_arg0, f72_arg1)
			f72_arg0:__resetProperties()
			f72_arg0:setupElementClipCounter(12)
			f72_arg0.ProgressBarBGBlur:completeAnimation()
			f72_arg0.ProgressBarBGBlur:setAlpha(0)
			f72_arg0.clipFinished(f72_arg0.ProgressBarBGBlur)
			f72_arg0.ProgressBarBGTint:completeAnimation()
			f72_arg0.ProgressBarBGTint:setAlpha(0)
			f72_arg0.clipFinished(f72_arg0.ProgressBarBGTint)
			f72_arg0.ProgressBar:completeAnimation()
			f72_arg0.ProgressBar:setAlpha(0)
			f72_arg0.clipFinished(f72_arg0.ProgressBar)
			f72_arg0.WaypointArrowDownNotClampedContainer:completeAnimation()
			f72_arg0.WaypointArrowDownNotClampedContainer:setAlpha(0.95)
			f72_arg0.clipFinished(f72_arg0.WaypointArrowDownNotClampedContainer)
			f72_arg0.WaypointArrowContainer:completeAnimation()
			f72_arg0.WaypointArrowContainer:setAlpha(0.95)
			f72_arg0.clipFinished(f72_arg0.WaypointArrowContainer)
			f72_arg0.WaypointText:completeAnimation()
			f72_arg0.WaypointText:setLeftRight(0.5, 0.5, -60, 60)
			f72_arg0.WaypointText:setTopBottom(0.5, 0.5, -14, 18)
			f72_arg0.clipFinished(f72_arg0.WaypointText)
			f72_arg0.ArrowRight:completeAnimation()
			f72_arg0.ArrowRight:setAlpha(0)
			f72_arg0.clipFinished(f72_arg0.ArrowRight)
			f72_arg0.ArrowLeft:completeAnimation()
			f72_arg0.ArrowLeft:setAlpha(0)
			f72_arg0.clipFinished(f72_arg0.ArrowLeft)
			f72_arg0.WaypointProgressMeterEmpty:completeAnimation()
			f72_arg0.WaypointProgressMeterEmpty:setAlpha(0)
			f72_arg0.clipFinished(f72_arg0.WaypointProgressMeterEmpty)
			f72_arg0.WaypointProgressMeter:completeAnimation()
			f72_arg0.WaypointProgressMeter:setAlpha(0)
			f72_arg0.clipFinished(f72_arg0.WaypointProgressMeter)
			f72_arg0.WaypointCenterIcon2:completeAnimation()
			f72_arg0.WaypointCenterIcon2:setAlpha(0)
			f72_arg0.clipFinished(f72_arg0.WaypointCenterIcon2)
			f72_arg0.WaypointCenterIcon:completeAnimation()
			f72_arg0.WaypointCenterIcon:setAlpha(0)
			f72_arg0.clipFinished(f72_arg0.WaypointCenterIcon)
		end,
	},
	ProgressBar = {
		DefaultClip = function(f73_arg0, f73_arg1)
			f73_arg0:__resetProperties()
			f73_arg0:setupElementClipCounter(14)
			f73_arg0.ProgressBarBGBlur:completeAnimation()
			f73_arg0.ProgressBarBGBlur:setLeftRight(0.5, 0.5, -179, 179)
			f73_arg0.ProgressBarBGBlur:setTopBottom(0.5, 0.5, -35, -17)
			f73_arg0.ProgressBarBGBlur:setAlpha(1)
			f73_arg0.clipFinished(f73_arg0.ProgressBarBGBlur)
			f73_arg0.ProgressBarBGTint:completeAnimation()
			f73_arg0.ProgressBarBGTint:setLeftRight(0.5, 0.5, -179, 179)
			f73_arg0.ProgressBarBGTint:setTopBottom(0.5, 0.5, -35, -17)
			f73_arg0.clipFinished(f73_arg0.ProgressBarBGTint)
			f73_arg0.ProgressBar:completeAnimation()
			f73_arg0.ProgressBar:setLeftRight(0.5, 0.5, -175, 175)
			f73_arg0.ProgressBar:setTopBottom(0.5, 0.5, -31, -21)
			f73_arg0.ProgressBar:setAlpha(1)
			f73_arg0.clipFinished(f73_arg0.ProgressBar)
			f73_arg0.WaypointArrowDownNotClampedContainer:completeAnimation()
			f73_arg0.WaypointArrowDownNotClampedContainer:setAlpha(0)
			f73_arg0.clipFinished(f73_arg0.WaypointArrowDownNotClampedContainer)
			f73_arg0.WaypointArrowContainer:completeAnimation()
			f73_arg0.WaypointArrowContainer:setAlpha(0)
			f73_arg0.clipFinished(f73_arg0.WaypointArrowContainer)
			f73_arg0.WaypointBacker:completeAnimation()
			f73_arg0.WaypointBacker:setAlpha(0)
			f73_arg0.clipFinished(f73_arg0.WaypointBacker)
			f73_arg0.WaypointPattern:completeAnimation()
			f73_arg0.WaypointPattern:setAlpha(0)
			f73_arg0.clipFinished(f73_arg0.WaypointPattern)
			f73_arg0.ArrowRight:completeAnimation()
			f73_arg0.ArrowRight:setAlpha(0)
			f73_arg0.clipFinished(f73_arg0.ArrowRight)
			f73_arg0.ArrowLeft:completeAnimation()
			f73_arg0.ArrowLeft:setAlpha(0)
			f73_arg0.clipFinished(f73_arg0.ArrowLeft)
			f73_arg0.BombTimer:completeAnimation()
			f73_arg0.BombTimer:setAlpha(0)
			f73_arg0.clipFinished(f73_arg0.BombTimer)
			f73_arg0.WaypointProgressMeterEmpty:completeAnimation()
			f73_arg0.WaypointProgressMeterEmpty:setAlpha(0)
			f73_arg0.clipFinished(f73_arg0.WaypointProgressMeterEmpty)
			f73_arg0.WaypointProgressMeter:completeAnimation()
			f73_arg0.WaypointProgressMeter:setLeftRight(0.5, 0.5, -35, 35)
			f73_arg0.WaypointProgressMeter:setTopBottom(0.5, 0.5, -35, 35)
			f73_arg0.WaypointProgressMeter:setAlpha(0)
			f73_arg0.clipFinished(f73_arg0.WaypointProgressMeter)
			f73_arg0.WaypointCenterIcon2:completeAnimation()
			f73_arg0.WaypointCenterIcon2:setAlpha(0)
			f73_arg0.clipFinished(f73_arg0.WaypointCenterIcon2)
			f73_arg0.WaypointCenterIcon:completeAnimation()
			f73_arg0.WaypointCenterIcon:setAlpha(0)
			f73_arg0.clipFinished(f73_arg0.WaypointCenterIcon)
		end,
	},
	NoFrame = {
		DefaultClip = function(f74_arg0, f74_arg1)
			f74_arg0:__resetProperties()
			f74_arg0:setupElementClipCounter(7)
			f74_arg0.ProgressBarBGBlur:completeAnimation()
			f74_arg0.ProgressBarBGBlur:setAlpha(0)
			f74_arg0.clipFinished(f74_arg0.ProgressBarBGBlur)
			f74_arg0.ProgressBarBGTint:completeAnimation()
			f74_arg0.ProgressBarBGTint:setAlpha(0)
			f74_arg0.clipFinished(f74_arg0.ProgressBarBGTint)
			f74_arg0.ProgressBar:completeAnimation()
			f74_arg0.ProgressBar:setAlpha(0)
			f74_arg0.clipFinished(f74_arg0.ProgressBar)
			f74_arg0.WaypointArrowDownNotClampedContainer:completeAnimation()
			f74_arg0.WaypointArrowDownNotClampedContainer:setAlpha(0.95)
			f74_arg0.clipFinished(f74_arg0.WaypointArrowDownNotClampedContainer)
			f74_arg0.WaypointArrowContainer:completeAnimation()
			f74_arg0.WaypointArrowContainer:setAlpha(0.95)
			f74_arg0.clipFinished(f74_arg0.WaypointArrowContainer)
			f74_arg0.WaypointProgressMeterEmpty:completeAnimation()
			f74_arg0.WaypointProgressMeterEmpty:setAlpha(1)
			f74_arg0.clipFinished(f74_arg0.WaypointProgressMeterEmpty)
			f74_arg0.WaypointProgressMeter:completeAnimation()
			f74_arg0.WaypointProgressMeter:setAlpha(0)
			f74_arg0.clipFinished(f74_arg0.WaypointProgressMeter)
		end,
	},
}
CoD.WaypointBomb.__onClose = function(f75_arg0)
	f75_arg0.ProgressBar:close()
	f75_arg0.WaypointArrowDownNotClampedContainer:close()
	f75_arg0.WaypointArrowContainer:close()
	f75_arg0.WaypointText:close()
	f75_arg0.WaypointBacker:close()
	f75_arg0.WaypointPattern:close()
	f75_arg0.ArrowRight:close()
	f75_arg0.ArrowLeft:close()
	f75_arg0.BombTimer:close()
	f75_arg0.WaypointProgressMeterEmpty:close()
	f75_arg0.WaypointProgressMeter:close()
	f75_arg0.WaypointCenterIcon2:close()
	f75_arg0.WaypointCenterIcon:close()
end
