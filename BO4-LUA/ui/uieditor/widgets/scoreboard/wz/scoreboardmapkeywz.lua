require("x64:637063c9f34e6f3")
require("x64:eda3c59d915dd99")
require("x64:fd8754c012d4e07")
CoD.ScoreboardMapKeyWZ = InheritFrom(LUI.UIElement)
CoD.ScoreboardMapKeyWZ.__defaultWidth = 271
CoD.ScoreboardMapKeyWZ.__defaultHeight = 254
CoD.ScoreboardMapKeyWZ.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ScoreboardMapKeyWZ)
	self.id = "ScoreboardMapKeyWZ"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local gameInfoBacking = LUI.UIImage.new(1, 1, -313, -42, 1, 1, -354, -59)
	gameInfoBacking:setRGB(0, 0, 0)
	gameInfoBacking:setAlpha(0.4)
	self:addElement(gameInfoBacking)
	self.gameInfoBacking = gameInfoBacking
	local gameInfoBackingTint = LUI.UIImage.new(1, 1, -313, -42, 1, 1, -354, -59)
	gameInfoBackingTint:setRGB(0, 0, 0)
	gameInfoBackingTint:setAlpha(0.8)
	gameInfoBackingTint:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_F755127C95CF5B6"))
	gameInfoBackingTint:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(gameInfoBackingTint)
	self.gameInfoBackingTint = gameInfoBackingTint
	local MoveMarker = CoD.WarzoneMapKeyItemWithMarker.new(f1_arg0, f1_arg1, 1, 1, -298, -42, 1, 1, -346, -306)
	MoveMarker:mergeStateConditions({
		{
			stateName = "NotAvailablePC",
			condition = function(menu, element, event)
				return IsMouseOrKeyboard(f1_arg1) and AlwaysFalse()
			end,
		},
		{
			stateName = "NotAvailable",
			condition = function(menu, element, event)
				local f3_local0
				if not IsMouseOrKeyboard(f1_arg1) then
					f3_local0 = AlwaysFalse()
				else
					f3_local0 = false
				end
				return f3_local0
			end,
		},
	})
	MoveMarker:appendEventHandler("input_source_changed", function(f4_arg0, f4_arg1)
		f4_arg1.menu = f4_arg1.menu or f1_arg0
		f1_arg0:updateElementState(MoveMarker, f4_arg1)
	end)
	local Drag = MoveMarker
	local BringCursor = MoveMarker.subscribeToModel
	local ZoomOut = Engine[@"getmodelforcontroller"](f1_arg1)
	BringCursor(Drag, ZoomOut.LastInput, function(f5_arg0)
		f1_arg0:updateElementState(MoveMarker, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f5_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	MoveMarker.Action:setText(Engine[@"hash_4F9F1239CFD921FE"](@"warzone/move_marker"))
	MoveMarker:subscribeToGlobalModel(f1_arg1, "Controller", "move_right_stick_button_image", function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			MoveMarker.Image:setImage(RegisterImage(f6_local0))
		end
	end)
	self:addElement(MoveMarker)
	self.MoveMarker = MoveMarker
	BringCursor = nil
	BringCursor = CoD.WarzoneMapKeyItem.new(f1_arg0, f1_arg1, 1, 1, -314, -58, 1, 1, -340, -300)
	BringCursor:mergeStateConditions({
		{
			stateName = "Available",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "NotAvailablePC",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	BringCursor:appendEventHandler("input_source_changed", function(f9_arg0, f9_arg1)
		f9_arg1.menu = f9_arg1.menu or f1_arg0
		f1_arg0:updateElementState(BringCursor, f9_arg1)
	end)
	ZoomOut = BringCursor
	Drag = BringCursor.subscribeToModel
	local ZoomIn = Engine[@"getmodelforcontroller"](f1_arg1)
	Drag(ZoomOut, ZoomIn.LastInput, function(f10_arg0)
		f1_arg0:updateElementState(BringCursor, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f10_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	BringCursor:setAlpha(0)
	BringCursor.ControllerDependentTextBox.KBMText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_7179672091387CD6"))
	BringCursor.Action:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_5E2C616EB9F5BBF6"))
	BringCursor:subscribeToGlobalModel(f1_arg1, "Controller", "left_stick_button_image", function(model)
		local f11_local0 = model:get()
		if f11_local0 ~= nil then
			BringCursor.Image:setImage(RegisterImage(f11_local0))
		end
	end)
	self:addElement(BringCursor)
	self.BringCursor = BringCursor
	Drag = nil
	Drag = CoD.WarzoneMapKeyItem.new(f1_arg0, f1_arg1, 1, 1, -314, -58, 1, 1, -152, -112)
	Drag:mergeStateConditions({
		{
			stateName = "Available",
			condition = function(menu, element, event)
				local f12_local0
				if not IsMouseOrKeyboard(f1_arg1) then
					f12_local0 = CoD.ModelUtility.IsGlobalDataSourceModelValueGreaterThan(f1_arg1, "WarzonePerController", "mapZoom", CoD.WZUtility.ZoomRange.MAP_ZOOM_MIN)
				else
					f12_local0 = false
				end
				return f12_local0
			end,
		},
		{
			stateName = "PC",
			condition = function(menu, element, event)
				return IsMouseOrKeyboard(f1_arg1) and CoD.ModelUtility.IsGlobalDataSourceModelValueGreaterThan(f1_arg1, "WarzonePerController", "mapZoom", CoD.WZUtility.ZoomRange.MAP_ZOOM_MIN)
			end,
		},
	})
	Drag:appendEventHandler("input_source_changed", function(f14_arg0, f14_arg1)
		f14_arg1.menu = f14_arg1.menu or f1_arg0
		f1_arg0:updateElementState(Drag, f14_arg1)
	end)
	ZoomIn = Drag
	ZoomOut = Drag.subscribeToModel
	local PlaceWaypoint = Engine[@"getmodelforcontroller"](f1_arg1)
	ZoomOut(ZoomIn, PlaceWaypoint.LastInput, function(f15_arg0)
		f1_arg0:updateElementState(Drag, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f15_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	ZoomIn = Drag
	ZoomOut = Drag.subscribeToModel
	PlaceWaypoint = DataSources.WarzonePerController.getModel(f1_arg1)
	ZoomOut(ZoomIn, PlaceWaypoint.mapZoom, function(f16_arg0)
		f1_arg0:updateElementState(Drag, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f16_arg0:get(),
			modelName = "mapZoom",
		})
	end, false)
	Drag:setAlpha(0)
	Drag.ControllerDependentTextBox.KBMText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_7179672091387CD6"))
	Drag.Action:setText(Engine[@"hash_4F9F1239CFD921FE"](@"warzone/drag"))
	Drag:subscribeToGlobalModel(f1_arg1, "Controller", "left_trigger_button_image", function(model)
		local f17_local0 = model:get()
		if f17_local0 ~= nil then
			Drag.Image:setImage(RegisterImage(f17_local0))
		end
	end)
	self:addElement(Drag)
	self.Drag = Drag
	ZoomOut = CoD.WarzoneMapKeyItem.new(f1_arg0, f1_arg1, 1, 1, -298, -42, 1, 1, -262, -222)
	ZoomOut:mergeStateConditions({
		{
			stateName = "Available",
			condition = function(menu, element, event)
				local f18_local0
				if not IsMouseOrKeyboard(f1_arg1) then
					f18_local0 = CoD.ModelUtility.IsGlobalDataSourceModelValueGreaterThan(f1_arg1, "WarzonePerController", "mapZoom", CoD.WZUtility.ZoomRange.MAP_ZOOM_MIN)
				else
					f18_local0 = false
				end
				return f18_local0
			end,
		},
		{
			stateName = "PC",
			condition = function(menu, element, event)
				return IsMouseOrKeyboard(f1_arg1) and CoD.ModelUtility.IsGlobalDataSourceModelValueGreaterThan(f1_arg1, "WarzonePerController", "mapZoom", CoD.WZUtility.ZoomRange.MAP_ZOOM_MIN)
			end,
		},
	})
	ZoomOut:appendEventHandler("input_source_changed", function(f20_arg0, f20_arg1)
		f20_arg1.menu = f20_arg1.menu or f1_arg0
		f1_arg0:updateElementState(ZoomOut, f20_arg1)
	end)
	PlaceWaypoint = ZoomOut
	ZoomIn = ZoomOut.subscribeToModel
	local DeleteWaypoint = Engine[@"getmodelforcontroller"](f1_arg1)
	ZoomIn(PlaceWaypoint, DeleteWaypoint.LastInput, function(f21_arg0)
		f1_arg0:updateElementState(ZoomOut, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f21_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	PlaceWaypoint = ZoomOut
	ZoomIn = ZoomOut.subscribeToModel
	DeleteWaypoint = DataSources.WarzonePerController.getModel(f1_arg1)
	ZoomIn(PlaceWaypoint, DeleteWaypoint.mapZoom, function(f22_arg0)
		f1_arg0:updateElementState(ZoomOut, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f22_arg0:get(),
			modelName = "mapZoom",
		})
	end, false)
	ZoomOut.ControllerDependentTextBox.KBMText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_7F802FE61568E12F"))
	ZoomOut.Action:setText(Engine[@"hash_4F9F1239CFD921FE"](@"warzone/zoom_out"))
	ZoomOut:subscribeToGlobalModel(f1_arg1, "Controller", "left_trigger_button_image", function(model)
		local f23_local0 = model:get()
		if f23_local0 ~= nil then
			ZoomOut.Image:setImage(RegisterImage(f23_local0))
		end
	end)
	self:addElement(ZoomOut)
	self.ZoomOut = ZoomOut
	ZoomIn = CoD.WarzoneMapKeyItem.new(f1_arg0, f1_arg1, 1, 1, -298, -42, 1, 1, -302, -262)
	ZoomIn:mergeStateConditions({
		{
			stateName = "Available",
			condition = function(menu, element, event)
				local f24_local0
				if not IsMouseOrKeyboard(f1_arg1) then
					f24_local0 = CoD.ModelUtility.IsGlobalDataSourceModelValueLessThan(f1_arg1, "WarzonePerController", "mapZoom", CoD.WZUtility.ZoomRange.MAP_ZOOM_MAX)
				else
					f24_local0 = false
				end
				return f24_local0
			end,
		},
		{
			stateName = "PC",
			condition = function(menu, element, event)
				return IsMouseOrKeyboard(f1_arg1) and CoD.ModelUtility.IsGlobalDataSourceModelValueLessThan(f1_arg1, "WarzonePerController", "mapZoom", CoD.WZUtility.ZoomRange.MAP_ZOOM_MAX)
			end,
		},
	})
	ZoomIn:appendEventHandler("input_source_changed", function(f26_arg0, f26_arg1)
		f26_arg1.menu = f26_arg1.menu or f1_arg0
		f1_arg0:updateElementState(ZoomIn, f26_arg1)
	end)
	DeleteWaypoint = ZoomIn
	PlaceWaypoint = ZoomIn.subscribeToModel
	local CloseMap = Engine[@"getmodelforcontroller"](f1_arg1)
	PlaceWaypoint(DeleteWaypoint, CloseMap.LastInput, function(f27_arg0)
		f1_arg0:updateElementState(ZoomIn, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f27_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	DeleteWaypoint = ZoomIn
	PlaceWaypoint = ZoomIn.subscribeToModel
	CloseMap = DataSources.WarzonePerController.getModel(f1_arg1)
	PlaceWaypoint(DeleteWaypoint, CloseMap.mapZoom, function(f28_arg0)
		f1_arg0:updateElementState(ZoomIn, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f28_arg0:get(),
			modelName = "mapZoom",
		})
	end, false)
	ZoomIn.ControllerDependentTextBox.KBMText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_76B0AA0A6A3C2DC6"))
	ZoomIn.Action:setText(Engine[@"hash_4F9F1239CFD921FE"](@"warzone/zoom_in"))
	ZoomIn:subscribeToGlobalModel(f1_arg1, "Controller", "right_trigger_button_image", function(model)
		local f29_local0 = model:get()
		if f29_local0 ~= nil then
			ZoomIn.Image:setImage(RegisterImage(f29_local0))
		end
	end)
	self:addElement(ZoomIn)
	self.ZoomIn = ZoomIn
	PlaceWaypoint = CoD.WarzoneMapKeyItem.new(f1_arg0, f1_arg1, 1, 1, -298, -42, 1, 1, -221.5, -181.5)
	PlaceWaypoint:mergeStateConditions({
		{
			stateName = "Available",
			condition = function(menu, element, event)
				local f30_local0
				if not IsMouseOrKeyboard(f1_arg1) and not CoD.WZUtility.IsControllerDeadAndNotRespawning(f1_arg1) and not CoD.ModelUtility.IsModelValueEqualToEnum(f1_arg1, "hudItems.waypointStatus", CoD.WZUtility.WaypointStatus.POST_PLACEMENT_DELAY) then
					f30_local0 = not CoD.ModelUtility.IsModelValueEqualToEnum(f1_arg1, "hudItems.waypointStatus", CoD.WZUtility.WaypointStatus.POST_DELETION_DELAY)
				else
					f30_local0 = false
				end
				return f30_local0
			end,
		},
		{
			stateName = "PC",
			condition = function(menu, element, event)
				local f31_local0 = IsMouseOrKeyboard(f1_arg1)
				if f31_local0 then
					if not CoD.WZUtility.IsControllerDeadAndNotRespawning(f1_arg1) and not CoD.ModelUtility.IsModelValueEqualToEnum(f1_arg1, "hudItems.waypointStatus", CoD.WZUtility.WaypointStatus.POST_PLACEMENT_DELAY) then
						f31_local0 = not CoD.ModelUtility.IsModelValueEqualToEnum(f1_arg1, "hudItems.waypointStatus", CoD.WZUtility.WaypointStatus.POST_DELETION_DELAY)
					else
						f31_local0 = false
					end
				end
				return f31_local0
			end,
		},
	})
	PlaceWaypoint:appendEventHandler("input_source_changed", function(f32_arg0, f32_arg1)
		f32_arg1.menu = f32_arg1.menu or f1_arg0
		f1_arg0:updateElementState(PlaceWaypoint, f32_arg1)
	end)
	CloseMap = PlaceWaypoint
	DeleteWaypoint = PlaceWaypoint.subscribeToModel
	local CenterCursor = Engine[@"getmodelforcontroller"](f1_arg1)
	DeleteWaypoint(CloseMap, CenterCursor.LastInput, function(f33_arg0)
		f1_arg0:updateElementState(PlaceWaypoint, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f33_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	PlaceWaypoint:appendEventHandler("deadSpectator.playerIndex", function(f34_arg0, f34_arg1)
		f34_arg1.menu = f34_arg1.menu or f1_arg0
		f1_arg0:updateElementState(PlaceWaypoint, f34_arg1)
	end)
	CloseMap = PlaceWaypoint
	DeleteWaypoint = PlaceWaypoint.subscribeToModel
	CenterCursor = Engine[@"getmodelforcontroller"](f1_arg1)
	DeleteWaypoint(CloseMap, CenterCursor["hudItems.waypointStatus"], function(f35_arg0)
		f1_arg0:updateElementState(PlaceWaypoint, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f35_arg0:get(),
			modelName = "hudItems.waypointStatus",
		})
	end, false)
	PlaceWaypoint.ControllerDependentTextBox.KBMText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_7179662091387B23"))
	PlaceWaypoint.Action:setText(Engine[@"hash_4F9F1239CFD921FE"](@"warzone/place_waypoint"))
	PlaceWaypoint:subscribeToGlobalModel(f1_arg1, "Controller", "right_shoulder_button_image", function(model)
		local f36_local0 = model:get()
		if f36_local0 ~= nil then
			PlaceWaypoint.Image:setImage(RegisterImage(f36_local0))
		end
	end)
	self:addElement(PlaceWaypoint)
	self.PlaceWaypoint = PlaceWaypoint
	DeleteWaypoint = CoD.WarzoneMapKeyItem.new(f1_arg0, f1_arg1, 1, 1, -298, -42, 1, 1, -181, -141)
	DeleteWaypoint:mergeStateConditions({
		{
			stateName = "Available",
			condition = function(menu, element, event)
				local f37_local0
				if not IsMouseOrKeyboard(f1_arg1) then
					f37_local0 = CoD.ModelUtility.IsModelValueEqualToEnum(f1_arg1, "hudItems.waypointStatus", CoD.WZUtility.WaypointStatus.ALLOW_DELETION)
					if f37_local0 then
						f37_local0 = not CoD.WZUtility.IsControllerDeadAndNotRespawning(f1_arg1)
					end
				else
					f37_local0 = false
				end
				return f37_local0
			end,
		},
		{
			stateName = "PC",
			condition = function(menu, element, event)
				local f38_local0 = IsMouseOrKeyboard(f1_arg1)
				if f38_local0 then
					f38_local0 = CoD.ModelUtility.IsModelValueEqualToEnum(f1_arg1, "hudItems.waypointStatus", CoD.WZUtility.WaypointStatus.ALLOW_DELETION)
					if f38_local0 then
						f38_local0 = not CoD.WZUtility.IsControllerDeadAndNotRespawning(f1_arg1)
					end
				end
				return f38_local0
			end,
		},
	})
	DeleteWaypoint:appendEventHandler("input_source_changed", function(f39_arg0, f39_arg1)
		f39_arg1.menu = f39_arg1.menu or f1_arg0
		f1_arg0:updateElementState(DeleteWaypoint, f39_arg1)
	end)
	CenterCursor = DeleteWaypoint
	CloseMap = DeleteWaypoint.subscribeToModel
	local frame = Engine[@"getmodelforcontroller"](f1_arg1)
	CloseMap(CenterCursor, frame.LastInput, function(f40_arg0)
		f1_arg0:updateElementState(DeleteWaypoint, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f40_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	CenterCursor = DeleteWaypoint
	CloseMap = DeleteWaypoint.subscribeToModel
	frame = Engine[@"getmodelforcontroller"](f1_arg1)
	CloseMap(CenterCursor, frame["hudItems.waypointStatus"], function(f41_arg0)
		f1_arg0:updateElementState(DeleteWaypoint, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f41_arg0:get(),
			modelName = "hudItems.waypointStatus",
		})
	end, false)
	DeleteWaypoint:appendEventHandler("deadSpectator.playerIndex", function(f42_arg0, f42_arg1)
		f42_arg1.menu = f42_arg1.menu or f1_arg0
		f1_arg0:updateElementState(DeleteWaypoint, f42_arg1)
	end)
	DeleteWaypoint.ControllerDependentTextBox.KBMText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_7179682091387E89"))
	DeleteWaypoint.Action:setText(Engine[@"hash_4F9F1239CFD921FE"](@"warzone/delete_waypoint"))
	DeleteWaypoint:subscribeToGlobalModel(f1_arg1, "Controller", "left_shoulder_button_image", function(model)
		local f43_local0 = model:get()
		if f43_local0 ~= nil then
			DeleteWaypoint.Image:setImage(RegisterImage(f43_local0))
		end
	end)
	self:addElement(DeleteWaypoint)
	self.DeleteWaypoint = DeleteWaypoint
	CloseMap = CoD.WarzoneMapKeyItem.new(f1_arg0, f1_arg1, 1, 1, -298, -42, 1, 1, -100, -60)
	CloseMap:mergeStateConditions({
		{
			stateName = "NotAvailablePC",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	CloseMap:appendEventHandler("input_source_changed", function(f45_arg0, f45_arg1)
		f45_arg1.menu = f45_arg1.menu or f1_arg0
		f1_arg0:updateElementState(CloseMap, f45_arg1)
	end)
	frame = CloseMap
	CenterCursor = CloseMap.subscribeToModel
	local HeaderBacking = Engine[@"getmodelforcontroller"](f1_arg1)
	CenterCursor(frame, HeaderBacking.LastInput, function(f46_arg0)
		f1_arg0:updateElementState(CloseMap, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f46_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	CloseMap.Action:setText(Engine[@"hash_4F9F1239CFD921FE"](@"warzone/close_map"))
	CloseMap:subscribeToGlobalModel(f1_arg1, "Controller", "secondary_button_image", function(model)
		local f47_local0 = model:get()
		if f47_local0 ~= nil then
			CloseMap.Image:setImage(RegisterImage(f47_local0))
		end
	end)
	self:addElement(CloseMap)
	self.CloseMap = CloseMap
	CenterCursor = CoD.WarzoneMapKeyItemWithPlayerIcon.new(f1_arg0, f1_arg1, 1, 1, -298, -42, 1, 1, -141, -101)
	CenterCursor:mergeStateConditions({
		{
			stateName = "NotAvailablePC",
			condition = function(menu, element, event)
				return IsMouseOrKeyboard(f1_arg1) and AlwaysFalse()
			end,
		},
		{
			stateName = "NotAvailable",
			condition = function(menu, element, event)
				local f49_local0
				if not IsMouseOrKeyboard(f1_arg1) then
					f49_local0 = AlwaysFalse()
				else
					f49_local0 = false
				end
				return f49_local0
			end,
		},
	})
	CenterCursor:appendEventHandler("input_source_changed", function(f50_arg0, f50_arg1)
		f50_arg1.menu = f50_arg1.menu or f1_arg0
		f1_arg0:updateElementState(CenterCursor, f50_arg1)
	end)
	HeaderBacking = CenterCursor
	frame = CenterCursor.subscribeToModel
	local RepeatDotline01 = Engine[@"getmodelforcontroller"](f1_arg1)
	frame(HeaderBacking, RepeatDotline01.LastInput, function(f51_arg0)
		f1_arg0:updateElementState(CenterCursor, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f51_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	CenterCursor.Action:setText(Engine[@"hash_4F9F1239CFD921FE"](@"warzone/marker_to"))
	CenterCursor:subscribeToGlobalModel(f1_arg1, "Controller", "left_stick_button_image", function(model)
		local f52_local0 = model:get()
		if f52_local0 ~= nil then
			CenterCursor.Image:setImage(RegisterImage(f52_local0))
		end
	end)
	self:addElement(CenterCursor)
	self.CenterCursor = CenterCursor
	frame = LUI.UIImage.new(1, 1, -318, -38, 1, 1, -374, -54)
	frame:setImage(RegisterImage(@"hash_33D54BC53A40189A"))
	frame:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_normal"))
	frame:setShaderVector(0, 0, 0, 0, 0)
	frame:setupNineSliceShader(16, 16)
	self:addElement(frame)
	self.frame = frame
	HeaderBacking = LUI.UIImage.new(1, 1, -313, -42, 1, 1, -370, -350)
	HeaderBacking:setRGB(0.07, 0.06, 0.06)
	self:addElement(HeaderBacking)
	self.HeaderBacking = HeaderBacking
	RepeatDotline01 = LUI.UIImage.new(1, 1, -313, -42, 1, 1, -304, -300)
	RepeatDotline01:setAlpha(0.2)
	RepeatDotline01:setImage(RegisterImage(@"hash_6F5E8F1B8586D9C5"))
	RepeatDotline01:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_67C9C02F608D0A75"))
	RepeatDotline01:setShaderVector(0, 0, 0, 0, 0)
	RepeatDotline01:setupNineSliceShader(8, 4)
	self:addElement(RepeatDotline01)
	self.RepeatDotline01 = RepeatDotline01
	local RepeatDotline02 = LUI.UIImage.new(1, 1, -313, -42, 1, 1, -263, -259)
	RepeatDotline02:setAlpha(0.2)
	RepeatDotline02:setImage(RegisterImage(@"hash_6F5E8F1B8586D9C5"))
	RepeatDotline02:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_67C9C02F608D0A75"))
	RepeatDotline02:setShaderVector(0, 0, 0, 0, 0)
	RepeatDotline02:setupNineSliceShader(8, 4)
	self:addElement(RepeatDotline02)
	self.RepeatDotline02 = RepeatDotline02
	local RepeatDotline03 = LUI.UIImage.new(1, 1, -313, -42, 1, 1, -223, -219)
	RepeatDotline03:setAlpha(0.2)
	RepeatDotline03:setImage(RegisterImage(@"hash_6F5E8F1B8586D9C5"))
	RepeatDotline03:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_67C9C02F608D0A75"))
	RepeatDotline03:setShaderVector(0, 0, 0, 0, 0)
	RepeatDotline03:setupNineSliceShader(8, 4)
	self:addElement(RepeatDotline03)
	self.RepeatDotline03 = RepeatDotline03
	local RepeatDotline04 = LUI.UIImage.new(1, 1, -313, -42, 1, 1, -182, -178)
	RepeatDotline04:setAlpha(0.2)
	RepeatDotline04:setImage(RegisterImage(@"hash_6F5E8F1B8586D9C5"))
	RepeatDotline04:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_67C9C02F608D0A75"))
	RepeatDotline04:setShaderVector(0, 0, 0, 0, 0)
	RepeatDotline04:setupNineSliceShader(8, 4)
	self:addElement(RepeatDotline04)
	self.RepeatDotline04 = RepeatDotline04
	local RepeatDotline05 = LUI.UIImage.new(1, 1, -313, -42, 1, 1, -142, -138)
	RepeatDotline05:setAlpha(0.2)
	RepeatDotline05:setImage(RegisterImage(@"hash_6F5E8F1B8586D9C5"))
	RepeatDotline05:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_67C9C02F608D0A75"))
	RepeatDotline05:setShaderVector(0, 0, 0, 0, 0)
	RepeatDotline05:setupNineSliceShader(8, 4)
	self:addElement(RepeatDotline05)
	self.RepeatDotline05 = RepeatDotline05
	local RepeatDotline06 = LUI.UIImage.new(1, 1, -313, -42, 1, 1, -101, -97)
	RepeatDotline06:setAlpha(0.2)
	RepeatDotline06:setImage(RegisterImage(@"hash_6F5E8F1B8586D9C5"))
	RepeatDotline06:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_67C9C02F608D0A75"))
	RepeatDotline06:setShaderVector(0, 0, 0, 0, 0)
	RepeatDotline06:setupNineSliceShader(8, 4)
	self:addElement(RepeatDotline06)
	self.RepeatDotline06 = RepeatDotline06
	local ControlHeader = LUI.UIText.new(0, 0, -28, 172, 0, 0, -113, -98)
	ControlHeader:setRGB(0.92, 0.92, 0.92)
	ControlHeader:setAlpha(0.2)
	ControlHeader:setText(LocalizeToUpperString(@"menu/controls"))
	ControlHeader:setTTF("ttmussels_demibold")
	ControlHeader:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	ControlHeader:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(ControlHeader)
	self.ControlHeader = ControlHeader
	self:mergeStateConditions({
		{
			stateName = "PC",
			condition = function(menu, element, event)
				return IsMouseOrKeyboard(f1_arg1)
			end,
		},
	})
	self:appendEventHandler("input_source_changed", function(f54_arg0, f54_arg1)
		f54_arg1.menu = f54_arg1.menu or f1_arg0
		f1_arg0:updateElementState(self, f54_arg1)
	end)
	local f1_local21 = self
	local f1_local22 = self.subscribeToModel
	local f1_local23 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local22(f1_local21, f1_local23.LastInput, function(f55_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f55_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ScoreboardMapKeyWZ.__resetProperties = function(f56_arg0)
	f56_arg0.CloseMap:completeAnimation()
	f56_arg0.DeleteWaypoint:completeAnimation()
	f56_arg0.PlaceWaypoint:completeAnimation()
	f56_arg0.ZoomOut:completeAnimation()
	f56_arg0.ZoomIn:completeAnimation()
	f56_arg0.MoveMarker:completeAnimation()
	f56_arg0.BringCursor:completeAnimation()
	f56_arg0.RepeatDotline06:completeAnimation()
	f56_arg0.RepeatDotline05:completeAnimation()
	f56_arg0.RepeatDotline04:completeAnimation()
	f56_arg0.RepeatDotline03:completeAnimation()
	f56_arg0.RepeatDotline02:completeAnimation()
	f56_arg0.RepeatDotline01:completeAnimation()
	f56_arg0.Drag:completeAnimation()
	f56_arg0.CenterCursor:completeAnimation()
	f56_arg0.CloseMap:setLeftRight(1, 1, -298, -42)
	f56_arg0.CloseMap:setTopBottom(1, 1, -100, -60)
	f56_arg0.CloseMap:setAlpha(1)
	f56_arg0.CloseMap.ControllerDependentTextBox.KBMText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"menu/new"))
	f56_arg0.DeleteWaypoint:setLeftRight(1, 1, -298, -42)
	f56_arg0.DeleteWaypoint:setTopBottom(1, 1, -181, -141)
	f56_arg0.DeleteWaypoint.ControllerDependentTextBox.KBMText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_7179682091387E89"))
	f56_arg0.PlaceWaypoint:setLeftRight(1, 1, -298, -42)
	f56_arg0.PlaceWaypoint:setTopBottom(1, 1, -221.5, -181.5)
	f56_arg0.PlaceWaypoint.ControllerDependentTextBox.KBMText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_7179662091387B23"))
	f56_arg0.ZoomOut:setLeftRight(1, 1, -298, -42)
	f56_arg0.ZoomOut:setTopBottom(1, 1, -262, -222)
	f56_arg0.ZoomIn:setLeftRight(1, 1, -298, -42)
	f56_arg0.ZoomIn:setTopBottom(1, 1, -302, -262)
	f56_arg0.MoveMarker:setLeftRight(1, 1, -298, -42)
	f56_arg0.MoveMarker:setAlpha(1)
	f56_arg0.BringCursor:setTopBottom(1, 1, -340, -300)
	f56_arg0.BringCursor:setAlpha(0)
	f56_arg0.BringCursor.ControllerDependentTextBox.KBMText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_7179672091387CD6"))
	f56_arg0.BringCursor.Action:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_5E2C616EB9F5BBF6"))
	f56_arg0.RepeatDotline06:setTopBottom(1, 1, -101, -97)
	f56_arg0.RepeatDotline05:setTopBottom(1, 1, -142, -138)
	f56_arg0.RepeatDotline04:setTopBottom(1, 1, -182, -178)
	f56_arg0.RepeatDotline03:setTopBottom(1, 1, -223, -219)
	f56_arg0.RepeatDotline02:setTopBottom(1, 1, -263, -259)
	f56_arg0.RepeatDotline01:setTopBottom(1, 1, -304, -300)
	f56_arg0.RepeatDotline01:setAlpha(0.2)
	f56_arg0.Drag:setTopBottom(1, 1, -152, -112)
	f56_arg0.Drag:setAlpha(0)
	f56_arg0.CenterCursor:setAlpha(1)
end
CoD.ScoreboardMapKeyWZ.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f57_arg0, f57_arg1)
			f57_arg0:__resetProperties()
			f57_arg0:setupElementClipCounter(0)
		end,
	},
	PC = {
		DefaultClip = function(f58_arg0, f58_arg1)
			f58_arg0:__resetProperties()
			f58_arg0:setupElementClipCounter(15)
			f58_arg0.MoveMarker:completeAnimation()
			f58_arg0.MoveMarker:setLeftRight(1, 1, -314, -58)
			f58_arg0.MoveMarker:setAlpha(0)
			f58_arg0.clipFinished(f58_arg0.MoveMarker)
			f58_arg0.BringCursor:completeAnimation()
			f58_arg0.BringCursor.ControllerDependentTextBox.KBMText:completeAnimation()
			f58_arg0.BringCursor.Action:completeAnimation()
			f58_arg0.BringCursor:setTopBottom(1, 1, -105, -65)
			f58_arg0.BringCursor:setAlpha(0)
			f58_arg0.BringCursor.ControllerDependentTextBox.KBMText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_7179672091387CD6"))
			f58_arg0.BringCursor.Action:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_5E2C616EB9F5BBF6"))
			f58_arg0.clipFinished(f58_arg0.BringCursor)
			f58_arg0.Drag:completeAnimation()
			f58_arg0.Drag:setTopBottom(1, 1, -135, -95)
			f58_arg0.Drag:setAlpha(1)
			f58_arg0.clipFinished(f58_arg0.Drag)
			f58_arg0.ZoomOut:completeAnimation()
			f58_arg0.ZoomOut:setLeftRight(1, 1, -314, -58)
			f58_arg0.ZoomOut:setTopBottom(1, 1, -184, -144)
			f58_arg0.clipFinished(f58_arg0.ZoomOut)
			f58_arg0.ZoomIn:completeAnimation()
			f58_arg0.ZoomIn:setLeftRight(1, 1, -314, -58)
			f58_arg0.ZoomIn:setTopBottom(1, 1, -233, -193)
			f58_arg0.clipFinished(f58_arg0.ZoomIn)
			f58_arg0.PlaceWaypoint:completeAnimation()
			f58_arg0.PlaceWaypoint.ControllerDependentTextBox.KBMText:completeAnimation()
			f58_arg0.PlaceWaypoint:setLeftRight(1, 1, -314, -58)
			f58_arg0.PlaceWaypoint:setTopBottom(1, 1, -331.5, -291.5)
			f58_arg0.PlaceWaypoint.ControllerDependentTextBox.KBMText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_7179662091387B23"))
			f58_arg0.clipFinished(f58_arg0.PlaceWaypoint)
			f58_arg0.DeleteWaypoint:completeAnimation()
			f58_arg0.DeleteWaypoint.ControllerDependentTextBox.KBMText:completeAnimation()
			f58_arg0.DeleteWaypoint:setLeftRight(1, 1, -314, -58)
			f58_arg0.DeleteWaypoint:setTopBottom(1, 1, -281, -241)
			f58_arg0.DeleteWaypoint.ControllerDependentTextBox.KBMText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_7179682091387E89"))
			f58_arg0.clipFinished(f58_arg0.DeleteWaypoint)
			f58_arg0.CloseMap:completeAnimation()
			f58_arg0.CloseMap.ControllerDependentTextBox.KBMText:completeAnimation()
			f58_arg0.CloseMap:setLeftRight(1, 1, -314, -58)
			f58_arg0.CloseMap:setTopBottom(1, 1, -104, -64)
			f58_arg0.CloseMap:setAlpha(0)
			f58_arg0.CloseMap.ControllerDependentTextBox.KBMText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"menu/map"))
			f58_arg0.clipFinished(f58_arg0.CloseMap)
			f58_arg0.CenterCursor:completeAnimation()
			f58_arg0.CenterCursor:setAlpha(0)
			f58_arg0.clipFinished(f58_arg0.CenterCursor)
			f58_arg0.RepeatDotline01:completeAnimation()
			f58_arg0.RepeatDotline01:setTopBottom(1, 1, -337, -333)
			f58_arg0.RepeatDotline01:setAlpha(0)
			f58_arg0.clipFinished(f58_arg0.RepeatDotline01)
			f58_arg0.RepeatDotline02:completeAnimation()
			f58_arg0.RepeatDotline02:setTopBottom(1, 1, -290, -286)
			f58_arg0.clipFinished(f58_arg0.RepeatDotline02)
			f58_arg0.RepeatDotline03:completeAnimation()
			f58_arg0.RepeatDotline03:setTopBottom(1, 1, -241, -237)
			f58_arg0.clipFinished(f58_arg0.RepeatDotline03)
			f58_arg0.RepeatDotline04:completeAnimation()
			f58_arg0.RepeatDotline04:setTopBottom(1, 1, -193, -189)
			f58_arg0.clipFinished(f58_arg0.RepeatDotline04)
			f58_arg0.RepeatDotline05:completeAnimation()
			f58_arg0.RepeatDotline05:setTopBottom(1, 1, -143, -139)
			f58_arg0.clipFinished(f58_arg0.RepeatDotline05)
			f58_arg0.RepeatDotline06:completeAnimation()
			f58_arg0.RepeatDotline06:setTopBottom(1, 1, -90, -86)
			f58_arg0.clipFinished(f58_arg0.RepeatDotline06)
		end,
	},
}
CoD.ScoreboardMapKeyWZ.__onClose = function(f59_arg0)
	f59_arg0.MoveMarker:close()
	f59_arg0.BringCursor:close()
	f59_arg0.Drag:close()
	f59_arg0.ZoomOut:close()
	f59_arg0.ZoomIn:close()
	f59_arg0.PlaceWaypoint:close()
	f59_arg0.DeleteWaypoint:close()
	f59_arg0.CloseMap:close()
	f59_arg0.CenterCursor:close()
end
