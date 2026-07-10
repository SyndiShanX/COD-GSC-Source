require("x64:b3cb3de9a683c02")
require("x64:c68e35524efc8d1")
require("x64:27411b1d207dbc8")
require("x64:da622980c9a8593")
require("x64:76c14e1bc07cd98")
CoD.Waypoint = InheritFrom(LUI.UIElement)
CoD.Waypoint.__defaultWidth = 120
CoD.Waypoint.__defaultHeight = 180
CoD.Waypoint.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	CoD.BaseUtility.CreateControllerModel(f1_arg1, "interactivePrompt.activeObjectiveID")
	self:setClass(CoD.Waypoint)
	self.id = "Waypoint"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ProgressBarBGBlur = LUI.UIImage.new(0.5, 0.5, -179, 179, 0.5, 0.5, 60, 80)
	ProgressBarBGBlur:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_E2354BE557C4C7A"))
	ProgressBarBGBlur:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(ProgressBarBGBlur)
	self.ProgressBarBGBlur = ProgressBarBGBlur
	local ProgressBarBGTint = LUI.UIImage.new(0.5, 0.5, -181.5, 181.5, 0.5, 0.5, 60, 80)
	ProgressBarBGTint:setRGB(0, 0, 0)
	ProgressBarBGTint:setAlpha(0.7)
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
			ProgressBar.ProgressBarColor2:setShaderVector(4, CoD.WaypointUtility.SetProgressMeterSegmentationIfNeeded(f1_arg1, 0.01, CoD.GetVectorComponentFromString(f5_local0, 1), CoD.GetVectorComponentFromString(f5_local0, 2), CoD.GetVectorComponentFromString(f5_local0, 3), CoD.GetVectorComponentFromString(f5_local0, 4)))
		end
	end)
	ProgressBar:linkToElementModel(self, "objId", true, function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			ProgressBar.ProgressBarColor:setShaderVector(4, CoD.WaypointUtility.SetProgressMeterSegmentationIfNeeded(f1_arg1, 0.01, CoD.GetVectorComponentFromString(f6_local0, 1), CoD.GetVectorComponentFromString(f6_local0, 2), CoD.GetVectorComponentFromString(f6_local0, 3), CoD.GetVectorComponentFromString(f6_local0, 4)))
		end
	end)
	ProgressBar:linkToElementModel(self, "objId", true, function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			ProgressBar.ProgressBarColoByFlags2:setShaderVector(4, CoD.WaypointUtility.SetProgressMeterSegmentationIfNeeded(f1_arg1, 0.01, CoD.GetVectorComponentFromString(f7_local0, 1), CoD.GetVectorComponentFromString(f7_local0, 2), CoD.GetVectorComponentFromString(f7_local0, 3), CoD.GetVectorComponentFromString(f7_local0, 4)))
		end
	end)
	self:addElement(ProgressBar)
	self.ProgressBar = ProgressBar
	local WaypointArrowDownNotClampedContainer = CoD.WaypointArrowContainer.new(f1_arg0, f1_arg1, 0.5, 0.5, -21, 21, 0.5, 0.5, -23, 23)
	WaypointArrowDownNotClampedContainer:mergeStateConditions({
		{
			stateName = "Show",
			condition = function(menu, element, event)
				local f8_local0
				if not ParentObjectivePropertyIsTrue(element, "hide_arrow") and not CoD.HUDUtility.IsObjectiveXHashPropertyValueEqualTo(self, 0x129B22B0CDE96B, 1) then
					f8_local0 = not CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "clamped")
				else
					f8_local0 = false
				end
				return f8_local0
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
		local f12_local0 = model:get()
		if f12_local0 ~= nil then
			WaypointArrowContainer:setZRot(Add(90, f12_local0))
		end
	end)
	WaypointArrowContainer:linkToElementModel(self, nil, false, function(model)
		WaypointArrowContainer:setModel(model, f1_arg1)
	end)
	self:addElement(WaypointArrowContainer)
	self.WaypointArrowContainer = WaypointArrowContainer
	local WaypointText = CoD.Waypoint_TextBG.new(f1_arg0, f1_arg1, 0.5, 0.5, -60, 60, 0.5, 0.5, -85, -53)
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
		local f22_local0 = model:get()
		if f22_local0 ~= nil then
			WaypointText.WaypointTextWithBG.text:setText(Engine[@"hash_4F9F1239CFD921FE"](f22_local0))
		end
	end)
	WaypointText:linkToElementModel(self, "distanceText", true, function(model)
		local f23_local0 = model:get()
		if f23_local0 ~= nil then
			WaypointText.DistanceTextWithBG.text:setText(LocalizeIntoStringIfNotEmpty(@"hash_37235825812D46C6", f23_local0))
		end
	end)
	self:addElement(WaypointText)
	self.WaypointText = WaypointText
	local WaypointBacker = LUI.UIImage.new(0.5, 0.5, -38, 38, 0.5, 0.5, -38, 38)
	WaypointBacker:setRGB(0.27, 0.27, 0.26)
	WaypointBacker:linkToElementModel(self, "waypointBacking01", true, function(model)
		local f24_local0 = model:get()
		if f24_local0 ~= nil then
			WaypointBacker:setImage(RegisterImage(f24_local0))
		end
	end)
	self:addElement(WaypointBacker)
	self.WaypointBacker = WaypointBacker
	local WaypointPattern = LUI.UIImage.new(0.5, 0.5, -37, 39, 0.5, 0.5, -38, 38)
	WaypointPattern:setImage(RegisterImage(@"uie_ui_hud_core_waypoint_led"))
	WaypointPattern:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_F755127C95CF5B6"))
	WaypointPattern:setShaderVector(0, 1.3, 0, 0, 0)
	WaypointPattern:linkToElementModel(self, "color", true, function(model)
		local f25_local0 = model:get()
		if f25_local0 ~= nil then
			WaypointPattern:setRGB(CoD.WaypointUtility.ConvertToBaseColor(f25_local0))
		end
	end)
	self:addElement(WaypointPattern)
	self.WaypointPattern = WaypointPattern
	local WaypointProgressMeterEmpty = LUI.UIImage.new(0.5, 0.5, -38, 38, 0.5, 0.5, -38, 38)
	WaypointProgressMeterEmpty:setRGB(1, 0.98, 0.91)
	WaypointProgressMeterEmpty:linkToElementModel(self, "waypointBacking02", true, function(model)
		local f26_local0 = model:get()
		if f26_local0 ~= nil then
			WaypointProgressMeterEmpty:setImage(RegisterImage(f26_local0))
		end
	end)
	self:addElement(WaypointProgressMeterEmpty)
	self.WaypointProgressMeterEmpty = WaypointProgressMeterEmpty
	local WaypointProgressMeter = CoD.WaypointProgressRing.new(f1_arg0, f1_arg1, 0.5, 0.5, -35, 35, 0.5, 0.5, -35, 35)
	WaypointProgressMeter:linkToElementModel(self, nil, false, function(model)
		WaypointProgressMeter:setModel(model, f1_arg1)
	end)
	WaypointProgressMeter:linkToElementModel(self, "objId", true, function(model)
		local f28_local0 = model:get()
		if f28_local0 ~= nil then
			WaypointProgressMeter.progressMeter:setShaderVector(4, CoD.WaypointUtility.SetProgressMeterSegmentationIfNeeded(f1_arg1, 0.07, CoD.GetVectorComponentFromString(f28_local0, 1), CoD.GetVectorComponentFromString(f28_local0, 2), CoD.GetVectorComponentFromString(f28_local0, 3), CoD.GetVectorComponentFromString(f28_local0, 4)))
		end
	end)
	WaypointProgressMeter:linkToElementModel(self, "objId", true, function(model)
		local f29_local0 = model:get()
		if f29_local0 ~= nil then
			WaypointProgressMeter.progressMeterColoredByUsing:setShaderVector(4, CoD.WaypointUtility.SetProgressMeterSegmentationIfNeeded(f1_arg1, 0.07, CoD.GetVectorComponentFromString(f29_local0, 1), CoD.GetVectorComponentFromString(f29_local0, 2), CoD.GetVectorComponentFromString(f29_local0, 3), CoD.GetVectorComponentFromString(f29_local0, 4)))
		end
	end)
	WaypointProgressMeter:linkToElementModel(self, "objId", true, function(model)
		local f30_local0 = model:get()
		if f30_local0 ~= nil then
			WaypointProgressMeter.progressMeterColoredByUsing2:setShaderVector(4, CoD.WaypointUtility.SetProgressMeterSegmentationIfNeeded(f1_arg1, 0.07, CoD.GetVectorComponentFromString(f30_local0, 1), CoD.GetVectorComponentFromString(f30_local0, 2), CoD.GetVectorComponentFromString(f30_local0, 3), CoD.GetVectorComponentFromString(f30_local0, 4)))
		end
	end)
	WaypointProgressMeter:linkToElementModel(self, "objId", true, function(model)
		local f31_local0 = model:get()
		if f31_local0 ~= nil then
			WaypointProgressMeter.progressMeterColoredByUsing3:setShaderVector(4, CoD.WaypointUtility.SetProgressMeterSegmentationIfNeeded(f1_arg1, 0.07, CoD.GetVectorComponentFromString(f31_local0, 1), CoD.GetVectorComponentFromString(f31_local0, 2), CoD.GetVectorComponentFromString(f31_local0, 3), CoD.GetVectorComponentFromString(f31_local0, 4)))
		end
	end)
	self:addElement(WaypointProgressMeter)
	self.WaypointProgressMeter = WaypointProgressMeter
	local WaypointCenterIcon2 = CoD.WaypointCenter.new(f1_arg0, f1_arg1, 0.5, 0.5, -38, 38, 0.5, 0.5, -35, 41)
	WaypointCenterIcon2:setAlpha(0.06)
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
	local LED = LUI.UIImage.new(0, 0, 73, 254, 0, 0, 141.5, 181.5)
	LED:setRGB(0, 0, 0)
	LED:setAlpha(0.18)
	LED:setScale(0.94, 0.94)
	LED:setImage(RegisterImage(@"uie_ui_hud_core_player_widget_led_status"))
	LED:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_wipe_delta_normal"))
	LED:setShaderVector(0, 0, 1, 0, 0)
	LED:setShaderVector(1, 0, 0, 0, 0)
	LED:setShaderVector(2, 0.24, 0.67, 0, 0)
	LED:setShaderVector(3, 0, 0, 0, 0)
	LED:setShaderVector(4, 0, 0, 0, 0)
	self:addElement(LED)
	self.LED = LED
	local LED2 = LUI.UIImage.new(0, 0, -79, 102, 0, 0, 141.5, 181.5)
	LED2:setRGB(0, 0, 0)
	LED2:setAlpha(0.18)
	LED2:setScale(0.94, 0.94)
	LED2:setImage(RegisterImage(@"uie_ui_hud_core_player_widget_led_status"))
	LED2:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_wipe_delta_normal"))
	LED2:setShaderVector(0, 0, 1, 0, 0)
	LED2:setShaderVector(1, 0, 0, 0, 0)
	LED2:setShaderVector(2, 0.24, 0.67, 0, 0)
	LED2:setShaderVector(3, 0, 0, 0, 0)
	LED2:setShaderVector(4, 0, 0, 0, 0)
	self:addElement(LED2)
	self.LED2 = LED2
	local LED3 = LUI.UIImage.new(0, 0, -231, -50, 0, 0, 141.5, 181.5)
	LED3:setRGB(0, 0, 0)
	LED3:setAlpha(0.18)
	LED3:setScale(0.94, 0.94)
	LED3:setImage(RegisterImage(@"uie_ui_hud_core_player_widget_led_status"))
	LED3:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_wipe_delta_normal"))
	LED3:setShaderVector(0, 0.63, 1, 0, 0)
	LED3:setShaderVector(1, 0, 0, 0, 0)
	LED3:setShaderVector(2, 0.24, 0.67, 0, 0)
	LED3:setShaderVector(3, 0, 0, 0, 0)
	LED3:setShaderVector(4, 0, 0, 0, 0)
	self:addElement(LED3)
	self.LED3 = LED3
	local Cap = LUI.UIImage.new(0, 0, -125.5, -106.5, 0, 0, 155, 165)
	Cap:setZRot(90)
	Cap:setImage(RegisterImage(@"hash_7F3E81C52AE39D91"))
	Cap:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(Cap)
	self.Cap = Cap
	local Cap2 = LUI.UIImage.new(0, 0, 225.5, 244.5, 0, 0, 155, 165)
	Cap2:setZRot(90)
	Cap2:setImage(RegisterImage(@"hash_7F3E81C52AE39D91"))
	Cap2:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(Cap2)
	self.Cap2 = Cap2
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
	local f1_local18 = self
	local f1_local19 = self.subscribeToModel
	local f1_local20 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local19(f1_local18, f1_local20["interactivePrompt.activeObjectiveID"], function(f43_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f43_arg0:get(),
			modelName = "interactivePrompt.activeObjectiveID",
		})
	end, false)
	f1_local18 = self
	f1_local19 = self.subscribeToModel
	f1_local20 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local19(f1_local18, f1_local20["hudItems.hacked"], function(f44_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f44_arg0:get(),
			modelName = "hudItems.hacked",
		})
	end, false)
	f1_local18 = self
	f1_local19 = self.subscribeToModel
	f1_local20 = DataSources.CurrentPrimaryOffhand.getModel(f1_arg1)
	f1_local19(f1_local18, f1_local20.ref, function(f45_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f45_arg0:get(),
			modelName = "ref",
		})
	end, false)
	f1_local18 = self
	f1_local19 = self.subscribeToModel
	f1_local20 = DataSources.LethalOffhands.getModel(f1_arg1)
	f1_local19(f1_local18, f1_local20.activeIndex, function(f46_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f46_arg0:get(),
			modelName = "activeIndex",
		})
	end, false)
	f1_local18 = self
	f1_local19 = self.subscribeToModel
	f1_local20 = DataSources.CurrentPrimaryOffhand.getModel(f1_arg1)
	f1_local19(f1_local18, f1_local20.count, function(f47_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f47_arg0:get(),
			modelName = "count",
		})
	end, false)
	f1_local18 = self
	f1_local19 = self.subscribeToModel
	f1_local20 = DataSources.CurrentSecondaryOffhand.getModel(f1_arg1)
	f1_local19(f1_local18, f1_local20.secondaryOffhand, function(f48_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f48_arg0:get(),
			modelName = "secondaryOffhand",
		})
	end, false)
	f1_local18 = self
	f1_local19 = self.subscribeToModel
	f1_local20 = DataSources.CurrentSecondaryOffhand.getModel(f1_arg1)
	f1_local19(f1_local18, f1_local20.secondaryOffhandCount, function(f49_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f49_arg0:get(),
			modelName = "secondaryOffhandCount",
		})
	end, false)
	f1_local18 = self
	f1_local19 = self.subscribeToModel
	f1_local20 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local19(f1_local18, f1_local20["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_spectating_client"]], function(f50_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f50_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_spectating_client"],
		})
	end, false)
	f1_local18 = self
	f1_local19 = self.subscribeToModel
	f1_local20 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local19(f1_local18, f1_local20["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_hud_visible"]], function(f51_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f51_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_hud_visible"],
		})
	end, false)
	f1_local18 = self
	f1_local19 = self.subscribeToModel
	f1_local20 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local19(f1_local18, f1_local20["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_emp_active"]], function(f52_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f52_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_emp_active"],
		})
	end, false)
	f1_local18 = self
	f1_local19 = self.subscribeToModel
	f1_local20 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local19(f1_local18, f1_local20["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_selecting_locational_killstreak"]], function(f53_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f53_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_selecting_locational_killstreak"],
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
	f1_local19 = self
	CoD.HUDUtility.UseHintTextForActiveButtonPromptText(self, f1_arg1)
	CoD.HUDUtility.SetWaypointElementToFadeAlpha(self, self.WaypointText)
	CoD.HUDUtility.SetWaypointElementToFadeAlpha(self, self.WaypointCenter)
	return self
end
CoD.Waypoint.__resetProperties = function(f57_arg0)
	f57_arg0.WaypointArrowContainer:completeAnimation()
	f57_arg0.WaypointArrowDownNotClampedContainer:completeAnimation()
	f57_arg0.ProgressBar:completeAnimation()
	f57_arg0.ProgressBarBGBlur:completeAnimation()
	f57_arg0.ProgressBarBGTint:completeAnimation()
	f57_arg0.WaypointBacker:completeAnimation()
	f57_arg0.LED3:completeAnimation()
	f57_arg0.LED2:completeAnimation()
	f57_arg0.LED:completeAnimation()
	f57_arg0.Cap2:completeAnimation()
	f57_arg0.Cap:completeAnimation()
	f57_arg0.WaypointText:completeAnimation()
	f57_arg0.WaypointCenterIcon2:completeAnimation()
	f57_arg0.WaypointProgressMeterEmpty:completeAnimation()
	f57_arg0.WaypointProgressMeter:completeAnimation()
	f57_arg0.WaypointCenterIcon:completeAnimation()
	f57_arg0.WaypointPattern:completeAnimation()
	f57_arg0.WaypointArrowContainer:setAlpha(0.95)
	f57_arg0.WaypointArrowDownNotClampedContainer:setAlpha(0.95)
	f57_arg0.ProgressBar:setLeftRight(0.5, 0.5, -175, 175)
	f57_arg0.ProgressBar:setTopBottom(0.5, 0.5, 65, 75)
	f57_arg0.ProgressBar:setAlpha(1)
	f57_arg0.ProgressBarBGBlur:setLeftRight(0.5, 0.5, -179, 179)
	f57_arg0.ProgressBarBGBlur:setTopBottom(0.5, 0.5, 60, 80)
	f57_arg0.ProgressBarBGBlur:setAlpha(1)
	f57_arg0.ProgressBarBGTint:setLeftRight(0.5, 0.5, -181.5, 181.5)
	f57_arg0.ProgressBarBGTint:setTopBottom(0.5, 0.5, 60, 80)
	f57_arg0.ProgressBarBGTint:setAlpha(0.7)
	f57_arg0.WaypointBacker:setAlpha(1)
	f57_arg0.LED3:setTopBottom(0, 0, 141.5, 181.5)
	f57_arg0.LED3:setAlpha(0.18)
	f57_arg0.LED2:setTopBottom(0, 0, 141.5, 181.5)
	f57_arg0.LED2:setAlpha(0.18)
	f57_arg0.LED:setTopBottom(0, 0, 141.5, 181.5)
	f57_arg0.LED:setAlpha(0.18)
	f57_arg0.Cap2:setLeftRight(0, 0, 225.5, 244.5)
	f57_arg0.Cap2:setTopBottom(0, 0, 155, 165)
	f57_arg0.Cap2:setAlpha(1)
	f57_arg0.Cap:setLeftRight(0, 0, -125.5, -106.5)
	f57_arg0.Cap:setTopBottom(0, 0, 155, 165)
	f57_arg0.Cap:setAlpha(1)
	f57_arg0.WaypointText:setLeftRight(0.5, 0.5, -60, 60)
	f57_arg0.WaypointText:setTopBottom(0.5, 0.5, -85, -53)
	f57_arg0.WaypointText:setAlpha(1)
	f57_arg0.WaypointCenterIcon2:setAlpha(0.06)
	f57_arg0.WaypointProgressMeterEmpty:setAlpha(1)
	f57_arg0.WaypointProgressMeter:setLeftRight(0.5, 0.5, -35, 35)
	f57_arg0.WaypointProgressMeter:setTopBottom(0.5, 0.5, -35, 35)
	f57_arg0.WaypointProgressMeter:setAlpha(1)
	f57_arg0.WaypointCenterIcon:setAlpha(1)
	f57_arg0.WaypointPattern:setAlpha(1)
end
CoD.Waypoint.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f58_arg0, f58_arg1)
			f58_arg0:__resetProperties()
			f58_arg0:setupElementClipCounter(12)
			f58_arg0.ProgressBarBGBlur:completeAnimation()
			f58_arg0.ProgressBarBGBlur:setAlpha(0)
			f58_arg0.clipFinished(f58_arg0.ProgressBarBGBlur)
			f58_arg0.ProgressBarBGTint:completeAnimation()
			f58_arg0.ProgressBarBGTint:setAlpha(0)
			f58_arg0.clipFinished(f58_arg0.ProgressBarBGTint)
			f58_arg0.ProgressBar:completeAnimation()
			f58_arg0.ProgressBar:setAlpha(0)
			f58_arg0.clipFinished(f58_arg0.ProgressBar)
			f58_arg0.WaypointArrowDownNotClampedContainer:completeAnimation()
			f58_arg0.WaypointArrowDownNotClampedContainer:setAlpha(0.95)
			f58_arg0.clipFinished(f58_arg0.WaypointArrowDownNotClampedContainer)
			f58_arg0.WaypointArrowContainer:completeAnimation()
			f58_arg0.WaypointArrowContainer:setAlpha(0.95)
			f58_arg0.clipFinished(f58_arg0.WaypointArrowContainer)
			f58_arg0.WaypointText:completeAnimation()
			f58_arg0.WaypointText:setLeftRight(0.5, 0.5, -60, 60)
			f58_arg0.WaypointText:setTopBottom(0.5, 0.5, -85, -53)
			f58_arg0.clipFinished(f58_arg0.WaypointText)
			f58_arg0.WaypointBacker:completeAnimation()
			f58_arg0.WaypointBacker:setAlpha(1)
			f58_arg0.clipFinished(f58_arg0.WaypointBacker)
			f58_arg0.LED:completeAnimation()
			f58_arg0.LED:setAlpha(0)
			f58_arg0.clipFinished(f58_arg0.LED)
			f58_arg0.LED2:completeAnimation()
			f58_arg0.LED2:setAlpha(0)
			f58_arg0.clipFinished(f58_arg0.LED2)
			f58_arg0.LED3:completeAnimation()
			f58_arg0.LED3:setAlpha(0)
			f58_arg0.clipFinished(f58_arg0.LED3)
			f58_arg0.Cap:completeAnimation()
			f58_arg0.Cap:setAlpha(0)
			f58_arg0.clipFinished(f58_arg0.Cap)
			f58_arg0.Cap2:completeAnimation()
			f58_arg0.Cap2:setAlpha(0)
			f58_arg0.clipFinished(f58_arg0.Cap2)
		end,
	},
	Hidden = {
		DefaultClip = function(f59_arg0, f59_arg1)
			f59_arg0:__resetProperties()
			f59_arg0:setupElementClipCounter(17)
			f59_arg0.ProgressBarBGBlur:completeAnimation()
			f59_arg0.ProgressBarBGBlur:setAlpha(0)
			f59_arg0.clipFinished(f59_arg0.ProgressBarBGBlur)
			f59_arg0.ProgressBarBGTint:completeAnimation()
			f59_arg0.ProgressBarBGTint:setAlpha(0)
			f59_arg0.clipFinished(f59_arg0.ProgressBarBGTint)
			f59_arg0.ProgressBar:completeAnimation()
			f59_arg0.ProgressBar:setAlpha(0)
			f59_arg0.clipFinished(f59_arg0.ProgressBar)
			f59_arg0.WaypointArrowDownNotClampedContainer:completeAnimation()
			f59_arg0.WaypointArrowDownNotClampedContainer:setAlpha(0)
			f59_arg0.clipFinished(f59_arg0.WaypointArrowDownNotClampedContainer)
			f59_arg0.WaypointArrowContainer:completeAnimation()
			f59_arg0.WaypointArrowContainer:setAlpha(0)
			f59_arg0.clipFinished(f59_arg0.WaypointArrowContainer)
			f59_arg0.WaypointText:completeAnimation()
			f59_arg0.WaypointText:setAlpha(0)
			f59_arg0.clipFinished(f59_arg0.WaypointText)
			f59_arg0.WaypointBacker:completeAnimation()
			f59_arg0.WaypointBacker:setAlpha(0)
			f59_arg0.clipFinished(f59_arg0.WaypointBacker)
			f59_arg0.WaypointPattern:completeAnimation()
			f59_arg0.WaypointPattern:setAlpha(0)
			f59_arg0.clipFinished(f59_arg0.WaypointPattern)
			f59_arg0.WaypointProgressMeterEmpty:completeAnimation()
			f59_arg0.WaypointProgressMeterEmpty:setAlpha(0)
			f59_arg0.clipFinished(f59_arg0.WaypointProgressMeterEmpty)
			f59_arg0.WaypointProgressMeter:completeAnimation()
			f59_arg0.WaypointProgressMeter:setAlpha(0)
			f59_arg0.clipFinished(f59_arg0.WaypointProgressMeter)
			f59_arg0.WaypointCenterIcon2:completeAnimation()
			f59_arg0.WaypointCenterIcon2:setAlpha(0)
			f59_arg0.clipFinished(f59_arg0.WaypointCenterIcon2)
			f59_arg0.WaypointCenterIcon:completeAnimation()
			f59_arg0.WaypointCenterIcon:setAlpha(0)
			f59_arg0.clipFinished(f59_arg0.WaypointCenterIcon)
			f59_arg0.LED:completeAnimation()
			f59_arg0.LED:setAlpha(0)
			f59_arg0.clipFinished(f59_arg0.LED)
			f59_arg0.LED2:completeAnimation()
			f59_arg0.LED2:setAlpha(0)
			f59_arg0.clipFinished(f59_arg0.LED2)
			f59_arg0.LED3:completeAnimation()
			f59_arg0.LED3:setAlpha(0)
			f59_arg0.clipFinished(f59_arg0.LED3)
			f59_arg0.Cap:completeAnimation()
			f59_arg0.Cap:setAlpha(0)
			f59_arg0.clipFinished(f59_arg0.Cap)
			f59_arg0.Cap2:completeAnimation()
			f59_arg0.Cap2:setAlpha(0)
			f59_arg0.clipFinished(f59_arg0.Cap2)
		end,
	},
	NoIcon = {
		DefaultClip = function(f60_arg0, f60_arg1)
			f60_arg0:__resetProperties()
			f60_arg0:setupElementClipCounter(17)
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
			f60_arg0.WaypointText:completeAnimation()
			f60_arg0.WaypointText:setLeftRight(0.5, 0.5, -60, 60)
			f60_arg0.WaypointText:setTopBottom(0.5, 0.5, -51, -19)
			f60_arg0.clipFinished(f60_arg0.WaypointText)
			f60_arg0.WaypointBacker:completeAnimation()
			f60_arg0.WaypointBacker:setAlpha(0)
			f60_arg0.clipFinished(f60_arg0.WaypointBacker)
			f60_arg0.WaypointPattern:completeAnimation()
			f60_arg0.WaypointPattern:setAlpha(0)
			f60_arg0.clipFinished(f60_arg0.WaypointPattern)
			f60_arg0.WaypointProgressMeterEmpty:completeAnimation()
			f60_arg0.WaypointProgressMeterEmpty:setAlpha(0)
			f60_arg0.clipFinished(f60_arg0.WaypointProgressMeterEmpty)
			f60_arg0.WaypointProgressMeter:completeAnimation()
			f60_arg0.WaypointProgressMeter:setAlpha(0)
			f60_arg0.clipFinished(f60_arg0.WaypointProgressMeter)
			f60_arg0.WaypointCenterIcon2:completeAnimation()
			f60_arg0.WaypointCenterIcon2:setAlpha(0)
			f60_arg0.clipFinished(f60_arg0.WaypointCenterIcon2)
			f60_arg0.WaypointCenterIcon:completeAnimation()
			f60_arg0.WaypointCenterIcon:setAlpha(0)
			f60_arg0.clipFinished(f60_arg0.WaypointCenterIcon)
			f60_arg0.LED:completeAnimation()
			f60_arg0.LED:setAlpha(0)
			f60_arg0.clipFinished(f60_arg0.LED)
			f60_arg0.LED2:completeAnimation()
			f60_arg0.LED2:setAlpha(0)
			f60_arg0.clipFinished(f60_arg0.LED2)
			f60_arg0.LED3:completeAnimation()
			f60_arg0.LED3:setAlpha(0)
			f60_arg0.clipFinished(f60_arg0.LED3)
			f60_arg0.Cap:completeAnimation()
			f60_arg0.Cap:setAlpha(0)
			f60_arg0.clipFinished(f60_arg0.Cap)
			f60_arg0.Cap2:completeAnimation()
			f60_arg0.Cap2:setAlpha(0)
			f60_arg0.clipFinished(f60_arg0.Cap2)
		end,
	},
	ProgressBar = {
		DefaultClip = function(f61_arg0, f61_arg1)
			f61_arg0:__resetProperties()
			f61_arg0:setupElementClipCounter(17)
			f61_arg0.ProgressBarBGBlur:completeAnimation()
			f61_arg0.ProgressBarBGBlur:setLeftRight(0.5, 0.5, -179, 179)
			f61_arg0.ProgressBarBGBlur:setTopBottom(0.5, 0.5, -36, -16)
			f61_arg0.ProgressBarBGBlur:setAlpha(1)
			f61_arg0.clipFinished(f61_arg0.ProgressBarBGBlur)
			f61_arg0.ProgressBarBGTint:completeAnimation()
			f61_arg0.ProgressBarBGTint:setLeftRight(0.5, 0.5, -181.5, 181.5)
			f61_arg0.ProgressBarBGTint:setTopBottom(0.5, 0.5, -36, -16)
			f61_arg0.clipFinished(f61_arg0.ProgressBarBGTint)
			f61_arg0.ProgressBar:completeAnimation()
			f61_arg0.ProgressBar:setLeftRight(0.5, 0.5, -175, 175)
			f61_arg0.ProgressBar:setTopBottom(0.5, 0.5, -31, -21)
			f61_arg0.ProgressBar:setAlpha(1)
			f61_arg0.clipFinished(f61_arg0.ProgressBar)
			f61_arg0.WaypointArrowDownNotClampedContainer:completeAnimation()
			f61_arg0.WaypointArrowDownNotClampedContainer:setAlpha(0)
			f61_arg0.clipFinished(f61_arg0.WaypointArrowDownNotClampedContainer)
			f61_arg0.WaypointArrowContainer:completeAnimation()
			f61_arg0.WaypointArrowContainer:setAlpha(0)
			f61_arg0.clipFinished(f61_arg0.WaypointArrowContainer)
			f61_arg0.WaypointText:completeAnimation()
			f61_arg0.WaypointText:setLeftRight(0.5, 0.5, -59, 61)
			f61_arg0.WaypointText:setTopBottom(0.5, 0.5, -81, -49)
			f61_arg0.clipFinished(f61_arg0.WaypointText)
			f61_arg0.WaypointBacker:completeAnimation()
			f61_arg0.WaypointBacker:setAlpha(0)
			f61_arg0.clipFinished(f61_arg0.WaypointBacker)
			f61_arg0.WaypointPattern:completeAnimation()
			f61_arg0.WaypointPattern:setAlpha(0)
			f61_arg0.clipFinished(f61_arg0.WaypointPattern)
			f61_arg0.WaypointProgressMeterEmpty:completeAnimation()
			f61_arg0.WaypointProgressMeterEmpty:setAlpha(0)
			f61_arg0.clipFinished(f61_arg0.WaypointProgressMeterEmpty)
			f61_arg0.WaypointProgressMeter:completeAnimation()
			f61_arg0.WaypointProgressMeter:setLeftRight(0.5, 0.5, -35, 35)
			f61_arg0.WaypointProgressMeter:setTopBottom(0.5, 0.5, -35, 35)
			f61_arg0.WaypointProgressMeter:setAlpha(0)
			f61_arg0.clipFinished(f61_arg0.WaypointProgressMeter)
			f61_arg0.WaypointCenterIcon2:completeAnimation()
			f61_arg0.WaypointCenterIcon2:setAlpha(0)
			f61_arg0.clipFinished(f61_arg0.WaypointCenterIcon2)
			f61_arg0.WaypointCenterIcon:completeAnimation()
			f61_arg0.WaypointCenterIcon:setAlpha(0)
			f61_arg0.clipFinished(f61_arg0.WaypointCenterIcon)
			f61_arg0.LED:completeAnimation()
			f61_arg0.LED:setTopBottom(0, 0, 45.5, 85.5)
			f61_arg0.clipFinished(f61_arg0.LED)
			f61_arg0.LED2:completeAnimation()
			f61_arg0.LED2:setTopBottom(0, 0, 45.5, 85.5)
			f61_arg0.clipFinished(f61_arg0.LED2)
			f61_arg0.LED3:completeAnimation()
			f61_arg0.LED3:setTopBottom(0, 0, 45.5, 85.5)
			f61_arg0.clipFinished(f61_arg0.LED3)
			f61_arg0.Cap:completeAnimation()
			f61_arg0.Cap:setLeftRight(0, 0, -124.5, -107.5)
			f61_arg0.Cap:setTopBottom(0, 0, 58, 70)
			f61_arg0.clipFinished(f61_arg0.Cap)
			f61_arg0.Cap2:completeAnimation()
			f61_arg0.Cap2:setLeftRight(0, 0, 226.5, 243.5)
			f61_arg0.Cap2:setTopBottom(0, 0, 58, 70)
			f61_arg0.clipFinished(f61_arg0.Cap2)
		end,
	},
	NoFrame = {
		DefaultClip = function(f62_arg0, f62_arg1)
			f62_arg0:__resetProperties()
			f62_arg0:setupElementClipCounter(13)
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
			f62_arg0.WaypointText:setTopBottom(0.5, 0.5, -85, -53)
			f62_arg0.clipFinished(f62_arg0.WaypointText)
			f62_arg0.WaypointProgressMeterEmpty:completeAnimation()
			f62_arg0.WaypointProgressMeterEmpty:setAlpha(1)
			f62_arg0.clipFinished(f62_arg0.WaypointProgressMeterEmpty)
			f62_arg0.WaypointProgressMeter:completeAnimation()
			f62_arg0.WaypointProgressMeter:setAlpha(0)
			f62_arg0.clipFinished(f62_arg0.WaypointProgressMeter)
			f62_arg0.LED:completeAnimation()
			f62_arg0.LED:setAlpha(0)
			f62_arg0.clipFinished(f62_arg0.LED)
			f62_arg0.LED2:completeAnimation()
			f62_arg0.LED2:setAlpha(0)
			f62_arg0.clipFinished(f62_arg0.LED2)
			f62_arg0.LED3:completeAnimation()
			f62_arg0.LED3:setAlpha(0)
			f62_arg0.clipFinished(f62_arg0.LED3)
			f62_arg0.Cap:completeAnimation()
			f62_arg0.Cap:setAlpha(0)
			f62_arg0.clipFinished(f62_arg0.Cap)
			f62_arg0.Cap2:completeAnimation()
			f62_arg0.Cap2:setAlpha(0)
			f62_arg0.clipFinished(f62_arg0.Cap2)
		end,
	},
}
CoD.Waypoint.__onClose = function(f63_arg0)
	f63_arg0.ProgressBar:close()
	f63_arg0.WaypointArrowDownNotClampedContainer:close()
	f63_arg0.WaypointArrowContainer:close()
	f63_arg0.WaypointText:close()
	f63_arg0.WaypointBacker:close()
	f63_arg0.WaypointPattern:close()
	f63_arg0.WaypointProgressMeterEmpty:close()
	f63_arg0.WaypointProgressMeter:close()
	f63_arg0.WaypointCenterIcon2:close()
	f63_arg0.WaypointCenterIcon:close()
end
