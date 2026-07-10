require("x64:4dfe5c6b3fbb32a")
require("x64:e1a4ff2280da16d")
require("x64:5e684e2d39669cd")
require("x64:e5724ea40c9bd4e")
CoD.ScoreboardMapWZInternal = InheritFrom(LUI.UIElement)
CoD.ScoreboardMapWZInternal.__defaultWidth = 967
CoD.ScoreboardMapWZInternal.__defaultHeight = 966
CoD.ScoreboardMapWZInternal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	CoD.BaseUtility.InitControllerModelEnumIfNotSet(f1_arg1, "hudItems.waypointStatus", CoD.WZUtility.WaypointStatus.ALLOW_PLACEMENT)
	InitDataSourceModel(f1_arg1, "WarzonePerController")
	CoD.WZUtility.InitWidgetForScaleAndPan(f1_arg1, self)
	CoD.WZUtility.InitWidgetForMouseDrag(self, f1_arg1, f1_arg0)
	self:setClass(CoD.ScoreboardMapWZInternal)
	self.id = "ScoreboardMapWZInternal"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local BlurBG = LUI.UIImage.new(0.5, 1.5, -474, -484, 0.49, 1.49, -473, -483)
	BlurBG:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_E2354BE557C4C7A"))
	BlurBG:setShaderVector(0, 0.5, 0, 0, 0)
	self:addElement(BlurBG)
	self.BlurBG = BlurBG
	local BlurBGTint = LUI.UIImage.new(0.5, 1.5, -475, -483, 0.49, 1.49, -474, -482)
	BlurBGTint:setRGB(0.11, 0.11, 0.11)
	BlurBGTint:setAlpha(0.9)
	BlurBGTint:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_F755127C95CF5B6"))
	BlurBGTint:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(BlurBGTint)
	self.BlurBGTint = BlurBGTint
	local ScoreboardGameStatusMap = CoD.ScoreboardGameStatusMapWZ.new(f1_arg0, f1_arg1, 0.5, 0.5, -436, 460, 0.5, 0.5, -436, 460)
	self:addElement(ScoreboardGameStatusMap)
	self.ScoreboardGameStatusMap = ScoreboardGameStatusMap
	local MapGrid02 = LUI.UIImage.new(0.46, 1.46, -402, -474, 0.47, 1.47, -403, -469)
	MapGrid02:setImage(RegisterImage(@"uie_ui_menu_mp_scoreboard_map_grid01"))
	MapGrid02:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_17EA4827662D4CD4"))
	MapGrid02:setShaderVector(0, 4, 5.92, 0, 0)
	MapGrid02:setShaderVector(1, 0, 1, 0, 1)
	self:addElement(MapGrid02)
	self.MapGrid02 = MapGrid02
	local ColumnHeadingBG = LUI.UIImage.new(0.5, 1.47, -479, -479, 0, 0, 5, 47)
	ColumnHeadingBG:setRGB(0, 0, 0)
	ColumnHeadingBG:setAlpha(0)
	self:addElement(ColumnHeadingBG)
	self.ColumnHeadingBG = ColumnHeadingBG
	local RowHeadingBG = LUI.UIImage.new(0, 0, 4.5, 46.5, 0.5, 1.47, -478, -478)
	RowHeadingBG:setRGB(0, 0, 0)
	RowHeadingBG:setAlpha(0)
	self:addElement(RowHeadingBG)
	self.RowHeadingBG = RowHeadingBG
	local ColumnHeadings = CoD.ScoreboardMapColumnHeadingsContainer.new(f1_arg0, f1_arg1, 0.5, 1.43, -436, -436, 0, 0, 6, 46)
	self:addElement(ColumnHeadings)
	self.ColumnHeadings = ColumnHeadings
	local TopLeftCornerElement = LUI.UIImage.new(0, 0, 5.5, 45.5, 0, 0, 6, 46)
	TopLeftCornerElement:setRGB(0, 0, 0)
	TopLeftCornerElement:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_E2354BE557C4C7A"))
	TopLeftCornerElement:setShaderVector(0, 0, 0.5, 0, 0)
	self:addElement(TopLeftCornerElement)
	self.TopLeftCornerElement = TopLeftCornerElement
	local RowHeadings = CoD.ScoreboardMapRowHeadingsContainer.new(f1_arg0, f1_arg1, 0, 0, 5.5, 45.5, 0.5, 1.43, -435, -435)
	self:addElement(RowHeadings)
	self.RowHeadings = RowHeadings
	local BlurBgTLCorner = LUI.UIImage.new(0, 0, 5.5, 46.5, 0, 0, 6, 47)
	BlurBgTLCorner:setRGB(0, 0, 0)
	BlurBgTLCorner:setAlpha(0.8)
	BlurBgTLCorner:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_F755127C95CF5B6"))
	BlurBgTLCorner:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(BlurBgTLCorner)
	self.BlurBgTLCorner = BlurBgTLCorner
	local BoundaryLine01 = LUI.UIImage.new(0.5, 1.47, -479, -479, 1, 1, -24, -22)
	BoundaryLine01:setRGB(0, 0, 0)
	self:addElement(BoundaryLine01)
	self.BoundaryLine01 = BoundaryLine01
	local BoundaryLine03 = LUI.UIImage.new(0, 0, 45.5, 47.5, 0.5, 1.47, -477, -477)
	BoundaryLine03:setRGB(0, 0, 0)
	self:addElement(BoundaryLine03)
	self.BoundaryLine03 = BoundaryLine03
	local BoundaryLine02 = LUI.UIImage.new(0.5, 1.47, -478, -478, 0, 0, 46, 48)
	BoundaryLine02:setRGB(0, 0, 0)
	self:addElement(BoundaryLine02)
	self.BoundaryLine02 = BoundaryLine02
	local BoundaryLine04 = LUI.UIImage.new(1, 1, -25.5, -23.5, 0.5, 1.47, -478, -478)
	BoundaryLine04:setRGB(0, 0, 0)
	self:addElement(BoundaryLine04)
	self.BoundaryLine04 = BoundaryLine04
	local TiledDotRight = LUI.UIImage.new(1, 1, -25, -5, 0.5, 1.49, -476, -476)
	TiledDotRight:setAlpha(0.02)
	TiledDotRight:setImage(RegisterImage(@"hash_71D86AD0278EBECC"))
	TiledDotRight:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_67C9C02F608D0A75"))
	TiledDotRight:setShaderVector(0, 0, 0, 0, 0)
	TiledDotRight:setupNineSliceShader(12, 12)
	self:addElement(TiledDotRight)
	self.TiledDotRight = TiledDotRight
	local TiledDotBot = LUI.UIImage.new(0.5, 0.5, -477.5, 458.5, 0.5, 0.5, 460, 478)
	TiledDotBot:setAlpha(0.02)
	TiledDotBot:setImage(RegisterImage(@"hash_71D86AD0278EBECC"))
	TiledDotBot:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_67C9C02F608D0A75"))
	TiledDotBot:setShaderVector(0, 0, 0, 0, 0)
	TiledDotBot:setupNineSliceShader(12, 12)
	self:addElement(TiledDotBot)
	self.TiledDotBot = TiledDotBot
	local MapFrame = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	MapFrame:setImage(RegisterImage(@"hash_33D54BC53A40189A"))
	MapFrame:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_normal"))
	MapFrame:setShaderVector(0, 0, 0, 0, 0)
	MapFrame:setupNineSliceShader(16, 16)
	self:addElement(MapFrame)
	self.MapFrame = MapFrame
	local MarkerImage = CoD.WarzonePlayerMarker.new(f1_arg0, f1_arg1, 0.5, 0.5, -6, 26, 0.5, 0.5, -5, 27)
	MarkerImage:subscribeToGlobalModel(f1_arg1, "PerController", "clientModel", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			MarkerImage:setModel(f2_local0, f1_arg1)
		end
	end)
	MarkerImage:registerEventHandler("menu_loaded", function(element, event)
		local f3_local0 = nil
		if element.menuLoaded then
			f3_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f3_local0 = element.super:menuLoaded(event)
		end
		CoD.WZUtility.InitPlayerMarker(self, element, self.ScoreboardGameStatusMap, f1_arg1)
		if not f3_local0 then
			f3_local0 = element:dispatchEventToChildren(event)
		end
		return f3_local0
	end)
	MarkerImage:registerEventHandler("input_source_changed", function(element, event)
		local f4_local0 = nil
		if IsMouseOrKeyboard(f1_arg1) then
			HideWidget(element)
		elseif not IsMouseOrKeyboard(f1_arg1) then
			ShowWidget(element)
		end
		MarkerImage:updateState(MarkerImage, {
			name = "update_state",
			controller = f1_arg1,
			menu = f1_arg0,
		})
		if not f4_local0 then
			f4_local0 = element:dispatchEventToChildren(event)
		end
		return f4_local0
	end)
	self:addElement(MarkerImage)
	self.MarkerImage = MarkerImage
	local f1_local19 = self
	local f1_local20 = self.subscribeToModel
	local f1_local21 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local20(f1_local19, f1_local21["hudItems.waypointStatus"], function(f5_arg0, f5_arg1)
		CoD.Menu.UpdateButtonShownState(f5_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_rb"])
		CoD.Menu.UpdateButtonShownState(f5_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_lb"])
	end, false)
	self:appendEventHandler("deadSpectator.playerIndex", function(f6_arg0, f6_arg1)
		f6_arg1.menu = f6_arg1.menu or f1_arg0
		CoD.Menu.UpdateButtonShownState(f6_arg0, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_rb"])
		CoD.Menu.UpdateButtonShownState(f6_arg0, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_lb"])
	end)
	self:appendEventHandler("input_source_changed", function(f7_arg0, f7_arg1)
		f7_arg1.menu = f7_arg1.menu or f1_arg0
		CoD.Menu.UpdateButtonShownState(f7_arg0, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_rb"])
		CoD.Menu.UpdateButtonShownState(f7_arg0, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_lb"])
	end)
	f1_local19 = self
	f1_local20 = self.subscribeToModel
	f1_local21 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local20(f1_local19, f1_local21.LastInput, function(f8_arg0, f8_arg1)
		CoD.Menu.UpdateButtonShownState(f8_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_rb"])
		CoD.Menu.UpdateButtonShownState(f8_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_lb"])
	end, false)
	f1_arg0:AddButtonCallbackFunction(self, f1_arg1, Enum[@"luibutton"][@"lui_key_rb"], "MOUSE1", function(element, menu, controller, model)
		if not CoD.ModelUtility.IsModelValueEqualToEnum(controller, "hudItems.waypointStatus", CoD.WZUtility.WaypointStatus.POST_PLACEMENT_DELAY) and not CoD.ModelUtility.IsModelValueEqualToEnum(controller, "hudItems.waypointStatus", CoD.WZUtility.WaypointStatus.POST_DELETION_DELAY) and not CoD.WZUtility.IsControllerDeadAndNotRespawning(controller) then
			CoD.WZUtility.PlaceMarker(controller, self.MarkerImage, self.ScoreboardGameStatusMap)
			return true
		elseif not CoD.WZUtility.IsControllerDeadAndNotRespawning(controller) and IsGamepad(controller) then
			BlockGameFromKeyEvent(controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if not CoD.ModelUtility.IsModelValueEqualToEnum(controller, "hudItems.waypointStatus", CoD.WZUtility.WaypointStatus.POST_PLACEMENT_DELAY) and not CoD.ModelUtility.IsModelValueEqualToEnum(controller, "hudItems.waypointStatus", CoD.WZUtility.WaypointStatus.POST_DELETION_DELAY) and not CoD.WZUtility.IsControllerDeadAndNotRespawning(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_rb"], @"hash_0", nil, "MOUSE1")
			return false
		elseif not CoD.WZUtility.IsControllerDeadAndNotRespawning(controller) and IsGamepad(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_rb"], @"hash_0", nil, "MOUSE1")
			return false
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(self, f1_arg1, Enum[@"luibutton"][@"lui_key_lb"], "MOUSE3", function(element, menu, controller, model)
		if CoD.ModelUtility.IsModelValueEqualToEnum(controller, "hudItems.waypointStatus", CoD.WZUtility.WaypointStatus.ALLOW_DELETION) and not CoD.WZUtility.IsControllerDeadAndNotRespawning(controller) then
			CoD.WZUtility.RemoveMarker(controller, self.MarkerImage)
			return true
		elseif not CoD.WZUtility.IsControllerDeadAndNotRespawning(controller) and IsGamepad(controller) then
			BlockGameFromKeyEvent(controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.ModelUtility.IsModelValueEqualToEnum(controller, "hudItems.waypointStatus", CoD.WZUtility.WaypointStatus.ALLOW_DELETION) and not CoD.WZUtility.IsControllerDeadAndNotRespawning(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_lb"], @"hash_0", nil, "MOUSE3")
			return false
		elseif not CoD.WZUtility.IsControllerDeadAndNotRespawning(controller) and IsGamepad(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_lb"], @"hash_0", nil, "MOUSE3")
			return false
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(self, f1_arg1, Enum[@"luibutton"][@"lui_key_ltrig"], "MWHEELDOWN", function(element, menu, controller, model)
		CoD.WZUtility.ZoomMap(controller, false, self.ScoreboardGameStatusMap)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_ltrig"], @"hash_0", nil, "MWHEELDOWN")
		return false
	end, false)
	f1_arg0:AddButtonCallbackFunction(self, f1_arg1, Enum[@"luibutton"][@"lui_key_rtrig"], "MWHEELUP", function(element, menu, controller, model)
		CoD.WZUtility.ZoomMap(controller, true, self.ScoreboardGameStatusMap)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_rtrig"], @"hash_0", nil, "MWHEELUP")
		return false
	end, false)
	f1_arg0:AddButtonCallbackFunction(self, f1_arg1, Enum[@"luibutton"][@"lui_key_lstick_pressed"], nil, function(element, menu, controller, model)
		CoD.WZUtility.CenterCursorOnPlayer(controller, self.ScoreboardGameStatusMap)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_lstick_pressed"], @"hash_0", nil, nil)
		return false
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PreLoadFunc then
		PreLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local20 = self
	f1_local20 = MarkerImage
	if IsPC() and IsMouseOrKeyboard(f1_arg1) then
		HideWidget(f1_local20)
	end
	return self
end
CoD.ScoreboardMapWZInternal.__resetProperties = function(f19_arg0)
	f19_arg0.MarkerImage:completeAnimation()
	f19_arg0.MarkerImage:setAlpha(1)
end
CoD.ScoreboardMapWZInternal.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(0)
		end,
		Focus = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(1)
			f21_arg0.MarkerImage:completeAnimation()
			f21_arg0.MarkerImage:setAlpha(1)
			f21_arg0.clipFinished(f21_arg0.MarkerImage)
		end,
	},
}
CoD.ScoreboardMapWZInternal.__onClose = function(f22_arg0)
	f22_arg0.ScoreboardGameStatusMap:close()
	f22_arg0.ColumnHeadings:close()
	f22_arg0.RowHeadings:close()
	f22_arg0.MarkerImage:close()
end
