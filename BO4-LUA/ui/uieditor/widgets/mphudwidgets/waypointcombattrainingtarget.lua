require("x64:7629ec7b99348f8")
require("x64:c68e35524efc8d1")
require("x64:27411b1d207dbc8")
require("x64:fd51e83e2e6dbd1")
CoD.WaypointCombatTrainingTarget = InheritFrom(LUI.UIElement)
CoD.WaypointCombatTrainingTarget.__defaultWidth = 120
CoD.WaypointCombatTrainingTarget.__defaultHeight = 180
CoD.WaypointCombatTrainingTarget.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WaypointCombatTrainingTarget)
	self.id = "WaypointCombatTrainingTarget"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local WaypointBacker = CoD.onOffImage.new(f1_arg0, f1_arg1, 0.5, 0.5, -38, 38, 0.5, 0.5, -38, 38)
	WaypointBacker:mergeStateConditions({
		{
			stateName = "On",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "clamped")
			end,
		},
	})
	WaypointBacker:linkToElementModel(WaypointBacker, "clamped", true, function(model)
		f1_arg0:updateElementState(WaypointBacker, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "clamped",
		})
	end)
	WaypointBacker.image:setImage(RegisterImage(0x8DDD1FDE43242E1))
	WaypointBacker.image:setMaterial(LUI.UIImage.GetCachedMaterial(0x6B34AA3F39208EF))
	WaypointBacker:linkToElementModel(self, nil, false, function(model)
		WaypointBacker:setModel(model, f1_arg1)
	end)
	self:addElement(WaypointBacker)
	self.WaypointBacker = WaypointBacker
	local WaypointArrowDownNotClampedContainer = CoD.WaypointArrowContainer.new(f1_arg0, f1_arg1, 0.5, 0.5, -21, 21, 0.5, 0.5, -23, 23)
	WaypointArrowDownNotClampedContainer:mergeStateConditions({
		{
			stateName = "Show",
			condition = function(menu, element, event)
				local f5_local0
				if not ParentObjectivePropertyIsTrue(element, "hide_arrow") and not CoD.HUDUtility.IsObjectiveXHashPropertyValueEqualTo(self, 0x129B22B0CDE96B, 1) then
					f5_local0 = not CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "clamped")
				else
					f5_local0 = false
				end
				return f5_local0
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
		local f9_local0 = model:get()
		if f9_local0 ~= nil then
			WaypointArrowContainer:setZRot(Add(90, f9_local0))
		end
	end)
	WaypointArrowContainer:linkToElementModel(self, nil, false, function(model)
		WaypointArrowContainer:setModel(model, f1_arg1)
	end)
	self:addElement(WaypointArrowContainer)
	self.WaypointArrowContainer = WaypointArrowContainer
	local WaypointText = CoD.Waypoint_TextBGTraining.new(f1_arg0, f1_arg1, 0.5, 0.5, -60, 60, 0.5, 0.5, -96, -55)
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
	WaypointText:setRGB(ColorSet.T8__OCHRE.r, ColorSet.T8__OCHRE.g, ColorSet.T8__OCHRE.b)
	WaypointText.WaypointTextWithBG.text:setMaterial(LUI.UIImage.GetCachedMaterial(0x71E049B161CD00A))
	WaypointText:linkToElementModel(self, nil, false, function(model)
		WaypointText:setModel(model, f1_arg1)
	end)
	WaypointText:linkToElementModel(self, "text", true, function(model)
		local f19_local0 = model:get()
		if f19_local0 ~= nil then
			WaypointText.WaypointTextWithBG.text:setText(Engine[0xF9F1239CFD921FE](f19_local0))
		end
	end)
	WaypointText:linkToElementModel(self, "distanceText", true, function(model)
		local f20_local0 = model:get()
		if f20_local0 ~= nil then
			WaypointText.DistanceTextWithBG.text:setText(LocalizeIntoStringIfNotEmpty(0x7235825812D46C6, f20_local0))
		end
	end)
	self:addElement(WaypointText)
	self.WaypointText = WaypointText
	local WaypointPatternNew = CoD.onOffImage.new(f1_arg0, f1_arg1, 0.5, 0.5, -37, 39, 0.5, 0.5, -38, 38)
	WaypointPatternNew:mergeStateConditions({
		{
			stateName = "On",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "clamped")
			end,
		},
	})
	WaypointPatternNew:linkToElementModel(WaypointPatternNew, "clamped", true, function(model)
		f1_arg0:updateElementState(WaypointPatternNew, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "clamped",
		})
	end)
	WaypointPatternNew.image:setImage(RegisterImage(0x159D9B7B7294C91))
	WaypointPatternNew.image:setMaterial(LUI.UIImage.GetCachedMaterial(0x6B34AA3F39208EF))
	WaypointPatternNew:linkToElementModel(self, "color", true, function(model)
		local f23_local0 = model:get()
		if f23_local0 ~= nil then
			WaypointPatternNew:setRGB(CoD.WaypointUtility.ConvertToBaseColor(f23_local0))
		end
	end)
	WaypointPatternNew:linkToElementModel(self, nil, false, function(model)
		WaypointPatternNew:setModel(model, f1_arg1)
	end)
	self:addElement(WaypointPatternNew)
	self.WaypointPatternNew = WaypointPatternNew
	local WaypointCenterIcon = CoD.WaypointCenter.new(f1_arg0, f1_arg1, 0.5, 0.5, -38, 38, 0.5, 0.5, -38, 38)
	WaypointCenterIcon:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "clamped")
			end,
		},
	})
	WaypointCenterIcon:linkToElementModel(WaypointCenterIcon, "clamped", true, function(model)
		f1_arg0:updateElementState(WaypointCenterIcon, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "clamped",
		})
	end)
	WaypointCenterIcon:linkToElementModel(WaypointCenterIcon, "progress", true, function(model)
		f1_arg0:updateElementState(WaypointCenterIcon, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "progress",
		})
	end)
	WaypointCenterIcon:linkToElementModel(WaypointCenterIcon, "clientUseMask", true, function(model)
		f1_arg0:updateElementState(WaypointCenterIcon, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "clientUseMask",
		})
	end)
	local CircleGlow = WaypointCenterIcon
	local RingGlow = WaypointCenterIcon.subscribeToModel
	local f1_local9 = Engine[0x8DF2E5447F384B9]()
	RingGlow(CircleGlow, f1_local9["lobbyRoot.lobbyNav"], function(f29_arg0)
		f1_arg0:updateElementState(WaypointCenterIcon, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f29_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	WaypointCenterIcon:setScale(0.7, 0.7)
	WaypointCenterIcon:linkToElementModel(self, nil, false, function(model)
		WaypointCenterIcon:setModel(model, f1_arg1)
	end)
	self:addElement(WaypointCenterIcon)
	self.WaypointCenterIcon = WaypointCenterIcon
	RingGlow = CoD.onOffImage.new(f1_arg0, f1_arg1, 0.5, 0.5, -37, 39, 0.5, 0.5, -39, 37)
	RingGlow:mergeStateConditions({
		{
			stateName = "On",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "clamped")
			end,
		},
	})
	RingGlow:linkToElementModel(RingGlow, "clamped", true, function(model)
		f1_arg0:updateElementState(RingGlow, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "clamped",
		})
	end)
	RingGlow:setAlpha(0)
	RingGlow:setScale(1.55, 1.55)
	RingGlow:setRFTMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	RingGlow.image:setImage(RegisterImage(0x333C550C1FAA4DA))
	RingGlow.image:setMaterial(LUI.UIImage.GetCachedMaterial(0x6B34AA3F39208EF))
	RingGlow:linkToElementModel(self, "color", true, function(model)
		local f33_local0 = model:get()
		if f33_local0 ~= nil then
			RingGlow:setRGB(CoD.WaypointUtility.ConvertToBaseColor(f33_local0))
		end
	end)
	RingGlow:linkToElementModel(self, nil, false, function(model)
		RingGlow:setModel(model, f1_arg1)
	end)
	self:addElement(RingGlow)
	self.RingGlow = RingGlow
	CircleGlow = CoD.onOffImage.new(f1_arg0, f1_arg1, 0.5, 0.5, -38, 38, 0.5, 0.5, -38, 38)
	CircleGlow:mergeStateConditions({
		{
			stateName = "On",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "clamped")
			end,
		},
	})
	CircleGlow:linkToElementModel(CircleGlow, "clamped", true, function(model)
		f1_arg0:updateElementState(CircleGlow, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "clamped",
		})
	end)
	CircleGlow:setAlpha(0)
	CircleGlow:setRFTMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	CircleGlow.image:setImage(RegisterImage(0xBA7D68F673291B4))
	CircleGlow.image:setMaterial(LUI.UIImage.GetCachedMaterial(0x6B34AA3F39208EF))
	CircleGlow:linkToElementModel(self, "color", true, function(model)
		local f37_local0 = model:get()
		if f37_local0 ~= nil then
			CircleGlow:setRGB(CoD.WaypointUtility.ConvertToBaseColor(f37_local0))
		end
	end)
	CircleGlow:linkToElementModel(self, nil, false, function(model)
		CircleGlow:setModel(model, f1_arg1)
	end)
	self:addElement(CircleGlow)
	self.CircleGlow = CircleGlow
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
	local f1_local10 = self
	f1_local9 = self.subscribeToModel
	local f1_local11 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local9(f1_local10, f1_local11["interactivePrompt.activeObjectiveID"], function(f48_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f48_arg0:get(),
			modelName = "interactivePrompt.activeObjectiveID",
		})
	end, false)
	f1_local10 = self
	f1_local9 = self.subscribeToModel
	f1_local11 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local9(f1_local10, f1_local11["hudItems.hacked"], function(f49_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f49_arg0:get(),
			modelName = "hudItems.hacked",
		})
	end, false)
	f1_local10 = self
	f1_local9 = self.subscribeToModel
	f1_local11 = DataSources.CurrentPrimaryOffhand.getModel(f1_arg1)
	f1_local9(f1_local10, f1_local11.ref, function(f50_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f50_arg0:get(),
			modelName = "ref",
		})
	end, false)
	f1_local10 = self
	f1_local9 = self.subscribeToModel
	f1_local11 = DataSources.LethalOffhands.getModel(f1_arg1)
	f1_local9(f1_local10, f1_local11.activeIndex, function(f51_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f51_arg0:get(),
			modelName = "activeIndex",
		})
	end, false)
	f1_local10 = self
	f1_local9 = self.subscribeToModel
	f1_local11 = DataSources.CurrentPrimaryOffhand.getModel(f1_arg1)
	f1_local9(f1_local10, f1_local11.count, function(f52_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f52_arg0:get(),
			modelName = "count",
		})
	end, false)
	f1_local10 = self
	f1_local9 = self.subscribeToModel
	f1_local11 = DataSources.CurrentSecondaryOffhand.getModel(f1_arg1)
	f1_local9(f1_local10, f1_local11.secondaryOffhand, function(f53_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f53_arg0:get(),
			modelName = "secondaryOffhand",
		})
	end, false)
	f1_local10 = self
	f1_local9 = self.subscribeToModel
	f1_local11 = DataSources.CurrentSecondaryOffhand.getModel(f1_arg1)
	f1_local9(f1_local10, f1_local11.secondaryOffhandCount, function(f54_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f54_arg0:get(),
			modelName = "secondaryOffhandCount",
		})
	end, false)
	f1_local10 = self
	f1_local9 = self.subscribeToModel
	f1_local11 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local9(f1_local10, f1_local11["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x6FFF566DCC09BBD]], function(f55_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f55_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x6FFF566DCC09BBD],
		})
	end, false)
	f1_local10 = self
	f1_local9 = self.subscribeToModel
	f1_local11 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local9(f1_local10, f1_local11["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xADC477DDE486DD7]], function(f56_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f56_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xADC477DDE486DD7],
		})
	end, false)
	f1_local10 = self
	f1_local9 = self.subscribeToModel
	f1_local11 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local9(f1_local10, f1_local11["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x59333FC97F7870]], function(f57_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f57_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x59333FC97F7870],
		})
	end, false)
	f1_local10 = self
	f1_local9 = self.subscribeToModel
	f1_local11 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local9(f1_local10, f1_local11["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x1C630DB86D235A5]], function(f58_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f58_arg0:get(),
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
	f1_local9 = self
	CoD.HUDUtility.UseHintTextForActiveButtonPromptText(self, f1_arg1)
	CoD.HUDUtility.SetWaypointElementToFadeAlpha(self, self.WaypointText)
	CoD.HUDUtility.SetWaypointElementToFadeAlpha(self, self.WaypointCenter)
	return self
end
CoD.WaypointCombatTrainingTarget.__resetProperties = function(f62_arg0)
	f62_arg0.WaypointArrowContainer:completeAnimation()
	f62_arg0.WaypointArrowDownNotClampedContainer:completeAnimation()
	f62_arg0.WaypointCenterIcon:completeAnimation()
	f62_arg0.WaypointText:completeAnimation()
	f62_arg0.WaypointPatternNew:completeAnimation()
	f62_arg0.WaypointBacker:completeAnimation()
	f62_arg0.RingGlow:completeAnimation()
	f62_arg0.CircleGlow:completeAnimation()
	f62_arg0.WaypointArrowContainer:setAlpha(0.95)
	f62_arg0.WaypointArrowDownNotClampedContainer:setAlpha(0.95)
	f62_arg0.WaypointCenterIcon:setAlpha(1)
	f62_arg0.WaypointText:setLeftRight(0.5, 0.5, -60, 60)
	f62_arg0.WaypointText:setTopBottom(0.5, 0.5, -96, -55)
	f62_arg0.WaypointText:setAlpha(1)
	f62_arg0.WaypointPatternNew:setAlpha(1)
	f62_arg0.WaypointBacker:setAlpha(1)
	f62_arg0.RingGlow:setAlpha(0)
	f62_arg0.RingGlow:setScale(1.55, 1.55)
	f62_arg0.CircleGlow:setAlpha(0)
end
CoD.WaypointCombatTrainingTarget.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f63_arg0, f63_arg1)
			f63_arg0:__resetProperties()
			f63_arg0:setupElementClipCounter(7)
			f63_arg0.WaypointBacker:completeAnimation()
			f63_arg0.WaypointBacker:setAlpha(0)
			f63_arg0.clipFinished(f63_arg0.WaypointBacker)
			f63_arg0.WaypointArrowDownNotClampedContainer:completeAnimation()
			f63_arg0.WaypointArrowDownNotClampedContainer:setAlpha(0.95)
			f63_arg0.clipFinished(f63_arg0.WaypointArrowDownNotClampedContainer)
			f63_arg0.WaypointArrowContainer:completeAnimation()
			f63_arg0.WaypointArrowContainer:setAlpha(0.95)
			f63_arg0.clipFinished(f63_arg0.WaypointArrowContainer)
			f63_arg0.WaypointText:completeAnimation()
			f63_arg0.WaypointText:setTopBottom(0.5, 0.5, -20.5, 20.5)
			f63_arg0.clipFinished(f63_arg0.WaypointText)
			f63_arg0.WaypointPatternNew:completeAnimation()
			f63_arg0.WaypointPatternNew:setAlpha(0)
			f63_arg0.clipFinished(f63_arg0.WaypointPatternNew)
			f63_arg0.WaypointCenterIcon:completeAnimation()
			f63_arg0.WaypointCenterIcon:setAlpha(1)
			f63_arg0.clipFinished(f63_arg0.WaypointCenterIcon)
			f63_arg0.RingGlow:completeAnimation()
			f63_arg0.RingGlow:setAlpha(0)
			f63_arg0.clipFinished(f63_arg0.RingGlow)
			f63_arg0.nextClip = "DefaultClip"
		end,
	},
	Hidden = {
		DefaultClip = function(f64_arg0, f64_arg1)
			f64_arg0:__resetProperties()
			f64_arg0:setupElementClipCounter(7)
			f64_arg0.WaypointBacker:completeAnimation()
			f64_arg0.WaypointBacker:setAlpha(0)
			f64_arg0.clipFinished(f64_arg0.WaypointBacker)
			f64_arg0.WaypointArrowDownNotClampedContainer:completeAnimation()
			f64_arg0.WaypointArrowDownNotClampedContainer:setAlpha(0)
			f64_arg0.clipFinished(f64_arg0.WaypointArrowDownNotClampedContainer)
			f64_arg0.WaypointArrowContainer:completeAnimation()
			f64_arg0.WaypointArrowContainer:setAlpha(0)
			f64_arg0.clipFinished(f64_arg0.WaypointArrowContainer)
			f64_arg0.WaypointText:completeAnimation()
			f64_arg0.WaypointText:setAlpha(0)
			f64_arg0.clipFinished(f64_arg0.WaypointText)
			f64_arg0.WaypointPatternNew:completeAnimation()
			f64_arg0.WaypointPatternNew:setAlpha(0)
			f64_arg0.clipFinished(f64_arg0.WaypointPatternNew)
			f64_arg0.WaypointCenterIcon:completeAnimation()
			f64_arg0.WaypointCenterIcon:setAlpha(0)
			f64_arg0.clipFinished(f64_arg0.WaypointCenterIcon)
			f64_arg0.RingGlow:completeAnimation()
			f64_arg0.RingGlow:setAlpha(0)
			f64_arg0.clipFinished(f64_arg0.RingGlow)
		end,
	},
	NoIcon = {
		DefaultClip = function(f65_arg0, f65_arg1)
			f65_arg0:__resetProperties()
			f65_arg0:setupElementClipCounter(7)
			f65_arg0.WaypointBacker:completeAnimation()
			f65_arg0.WaypointBacker:setAlpha(0)
			f65_arg0.clipFinished(f65_arg0.WaypointBacker)
			f65_arg0.WaypointArrowDownNotClampedContainer:completeAnimation()
			f65_arg0.WaypointArrowDownNotClampedContainer:setAlpha(0.95)
			f65_arg0.clipFinished(f65_arg0.WaypointArrowDownNotClampedContainer)
			f65_arg0.WaypointArrowContainer:completeAnimation()
			f65_arg0.WaypointArrowContainer:setAlpha(0.95)
			f65_arg0.clipFinished(f65_arg0.WaypointArrowContainer)
			f65_arg0.WaypointText:completeAnimation()
			f65_arg0.WaypointText:setLeftRight(0.5, 0.5, -60, 60)
			f65_arg0.WaypointText:setTopBottom(0.5, 0.5, -14, 18)
			f65_arg0.clipFinished(f65_arg0.WaypointText)
			f65_arg0.WaypointPatternNew:completeAnimation()
			f65_arg0.WaypointPatternNew:setAlpha(0)
			f65_arg0.clipFinished(f65_arg0.WaypointPatternNew)
			f65_arg0.WaypointCenterIcon:completeAnimation()
			f65_arg0.WaypointCenterIcon:setAlpha(0)
			f65_arg0.clipFinished(f65_arg0.WaypointCenterIcon)
			f65_arg0.RingGlow:completeAnimation()
			f65_arg0.RingGlow:setAlpha(0)
			f65_arg0.clipFinished(f65_arg0.RingGlow)
		end,
	},
	ProgressBar = {
		DefaultClip = function(f66_arg0, f66_arg1)
			f66_arg0:__resetProperties()
			f66_arg0:setupElementClipCounter(6)
			f66_arg0.WaypointBacker:completeAnimation()
			f66_arg0.WaypointBacker:setAlpha(0)
			f66_arg0.clipFinished(f66_arg0.WaypointBacker)
			f66_arg0.WaypointArrowDownNotClampedContainer:completeAnimation()
			f66_arg0.WaypointArrowDownNotClampedContainer:setAlpha(0)
			f66_arg0.clipFinished(f66_arg0.WaypointArrowDownNotClampedContainer)
			f66_arg0.WaypointArrowContainer:completeAnimation()
			f66_arg0.WaypointArrowContainer:setAlpha(0)
			f66_arg0.clipFinished(f66_arg0.WaypointArrowContainer)
			f66_arg0.WaypointPatternNew:completeAnimation()
			f66_arg0.WaypointPatternNew:setAlpha(0)
			f66_arg0.clipFinished(f66_arg0.WaypointPatternNew)
			f66_arg0.WaypointCenterIcon:completeAnimation()
			f66_arg0.WaypointCenterIcon:setAlpha(0)
			f66_arg0.clipFinished(f66_arg0.WaypointCenterIcon)
			f66_arg0.RingGlow:completeAnimation()
			f66_arg0.RingGlow:setAlpha(0)
			f66_arg0.clipFinished(f66_arg0.RingGlow)
		end,
	},
	NoFrame = {
		DefaultClip = function(f67_arg0, f67_arg1)
			f67_arg0:__resetProperties()
			f67_arg0:setupElementClipCounter(5)
			f67_arg0.WaypointArrowDownNotClampedContainer:completeAnimation()
			f67_arg0.WaypointArrowDownNotClampedContainer:setAlpha(0.95)
			f67_arg0.clipFinished(f67_arg0.WaypointArrowDownNotClampedContainer)
			f67_arg0.WaypointArrowContainer:completeAnimation()
			f67_arg0.WaypointArrowContainer:setAlpha(0.95)
			f67_arg0.clipFinished(f67_arg0.WaypointArrowContainer)
			f67_arg0.WaypointCenterIcon:completeAnimation()
			f67_arg0.WaypointCenterIcon:setAlpha(1)
			f67_arg0.clipFinished(f67_arg0.WaypointCenterIcon)
			local f67_local0 = function(f68_arg0)
				local f68_local0 = function(f69_arg0)
					local f69_local0 = function(f70_arg0)
						local f70_local0 = function(f71_arg0)
							f71_arg0:beginAnimation(2000)
							f71_arg0:registerEventHandler("transition_complete_keyframe", f67_arg0.clipFinished)
						end
						f70_arg0:beginAnimation(750)
						f70_arg0:setAlpha(0)
						f70_arg0:registerEventHandler("transition_complete_keyframe", f70_local0)
					end
					f69_arg0:beginAnimation(750, Enum[0xF50FFF429AB1890][0x53CEB9A0427197])
					f69_arg0:setScale(1.55, 1.55)
					f69_arg0:registerEventHandler("transition_complete_keyframe", f69_local0)
				end
				f67_arg0.RingGlow:beginAnimation(500)
				f67_arg0.RingGlow:setAlpha(1)
				f67_arg0.RingGlow:registerEventHandler("interrupted_keyframe", f67_arg0.clipInterrupted)
				f67_arg0.RingGlow:registerEventHandler("transition_complete_keyframe", f68_local0)
			end
			f67_arg0.RingGlow:completeAnimation()
			f67_arg0.RingGlow:setAlpha(0)
			f67_arg0.RingGlow:setScale(0, 0)
			f67_local0(f67_arg0.RingGlow)
			local f67_local1 = function(f72_arg0)
				local f72_local0 = function(f73_arg0)
					local f73_local0 = function(f74_arg0)
						local f74_local0 = function(f75_arg0)
							f75_arg0:beginAnimation(1800)
							f75_arg0:setAlpha(0)
							f75_arg0:registerEventHandler("transition_complete_keyframe", f67_arg0.clipFinished)
						end
						f74_arg0:beginAnimation(49)
						f74_arg0:setAlpha(1)
						f74_arg0:registerEventHandler("transition_complete_keyframe", f74_local0)
					end
					f73_arg0:beginAnimation(100)
					f73_arg0:setAlpha(0)
					f73_arg0:registerEventHandler("transition_complete_keyframe", f73_local0)
				end
				f67_arg0.CircleGlow:beginAnimation(50, Enum[0xF50FFF429AB1890][0x53CEB9A0427197])
				f67_arg0.CircleGlow:setAlpha(1)
				f67_arg0.CircleGlow:registerEventHandler("interrupted_keyframe", f67_arg0.clipInterrupted)
				f67_arg0.CircleGlow:registerEventHandler("transition_complete_keyframe", f72_local0)
			end
			f67_arg0.CircleGlow:completeAnimation()
			f67_arg0.CircleGlow:setAlpha(0)
			f67_local1(f67_arg0.CircleGlow)
			f67_arg0.nextClip = "DefaultClip"
		end,
	},
}
CoD.WaypointCombatTrainingTarget.__onClose = function(f76_arg0)
	f76_arg0.WaypointBacker:close()
	f76_arg0.WaypointArrowDownNotClampedContainer:close()
	f76_arg0.WaypointArrowContainer:close()
	f76_arg0.WaypointText:close()
	f76_arg0.WaypointPatternNew:close()
	f76_arg0.WaypointCenterIcon:close()
	f76_arg0.RingGlow:close()
	f76_arg0.CircleGlow:close()
end
