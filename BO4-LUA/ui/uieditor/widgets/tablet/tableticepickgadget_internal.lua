require("x64:74865184d366449")
require("x64:1b7b1de10a4e4f4")
require("x64:6deaa4e20818d8a")
require("x64:47d94f38b12f180")
require("x64:455cbd55130b176")
require("x64:2c0aff913623b4b")
require("x64:fa67d3befeb0e9b")
require("x64:fa67c3befeb0ce8")
require("x64:8ce41ebda83b888")
require("x64:90d82f7fbf3980f")
require("x64:ca8908628d8ccab")
require("x64:3b3d5d11ecc1ee6")
CoD.TabletIcePickGadget_Internal = InheritFrom(LUI.UIElement)
CoD.TabletIcePickGadget_Internal.__defaultWidth = 1336
CoD.TabletIcePickGadget_Internal.__defaultHeight = 740
CoD.TabletIcePickGadget_Internal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.TabletIcePickGadget_Internal)
	self.id = "TabletIcePickGadget_Internal"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local BG = LUI.UIImage.new(0, 0, -10, 1670, 0, 0, -10.5, 929.5)
	BG:setRGB(0.02, 0.08, 0.12)
	self:addElement(BG)
	self.BG = BG
	local BgGrad = LUI.UIImage.new(0, 0, -10, 1670, 0, 0, -10.5, 929.5)
	BgGrad:setAlpha(0.25)
	BgGrad:setImage(RegisterImage(@"hash_7F92F0E135E1791D"))
	self:addElement(BgGrad)
	self.BgGrad = BgGrad
	local CenterFractal05 = LUI.UIImage.new(0, 0, -86, 1115, 0, 0, -230, 380)
	CenterFractal05:setAlpha(0.15)
	CenterFractal05:setImage(RegisterImage(0x86F05135B82FD3))
	CenterFractal05:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	CenterFractal05:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(CenterFractal05)
	self.CenterFractal05 = CenterFractal05
	local CenterFractal03 = LUI.UIImage.new(0, 0, 946, 1846, 0, 0, 707.5, 1127.5)
	CenterFractal03:setAlpha(0.2)
	CenterFractal03:setImage(RegisterImage(0x86F65135B83A05))
	CenterFractal03:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	CenterFractal03:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(CenterFractal03)
	self.CenterFractal03 = CenterFractal03
	local PixelGridTiledBacking = LUI.UIImage.new(0, 0, -10, 1670, 0, 0, -10, 930)
	PixelGridTiledBacking:setAlpha(0.1)
	PixelGridTiledBacking:setImage(RegisterImage(@"uie_ui_hud_notifications_pixelpattern"))
	PixelGridTiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_67C9C02F608D0A75"))
	PixelGridTiledBacking:setShaderVector(0, 0, 0, 0, 0)
	PixelGridTiledBacking:setupNineSliceShader(256, 256)
	self:addElement(PixelGridTiledBacking)
	self.PixelGridTiledBacking = PixelGridTiledBacking
	local GridLine = LUI.UIImage.new(0, 0, -10, 1670, 0, 0, -10, 930)
	GridLine:setImage(RegisterImage(@"hash_7F7700E135C91995"))
	GridLine:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_67C9C02F608D0A75"))
	GridLine:setShaderVector(0, 0, 0, 0, 0)
	GridLine:setupNineSliceShader(144, 144)
	self:addElement(GridLine)
	self.GridLine = GridLine
	local GridLineAdd = LUI.UIImage.new(0, 0, -10, 1670, 0, 0, -10, 930)
	GridLineAdd:setAlpha(0.5)
	GridLineAdd:setImage(RegisterImage(@"hash_7F7700E135C91995"))
	GridLineAdd:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_67C9C02F608D0A75"))
	GridLineAdd:setShaderVector(0, 0, 0, 0, 0)
	GridLineAdd:setupNineSliceShader(144, 144)
	self:addElement(GridLineAdd)
	self.GridLineAdd = GridLineAdd
	local WindowBg02 = CoD.TabletIcePickGadget_BgWindow.new(f1_arg0, f1_arg1, 0, 0, -655, 491, 0, 0, 659.5, 1039.5)
	WindowBg02.PixelGrid:setAlpha(0.05)
	WindowBg02.BG:setAlpha(0.25)
	WindowBg02.Frame:setAlpha(0)
	WindowBg02.BlurFrame:setAlpha(0.1)
	self:addElement(WindowBg02)
	self.WindowBg02 = WindowBg02
	local binaryFUI02 = CoD.TabletIcePickGadget_BgElementBinary.new(f1_arg0, f1_arg1, 0, 0, -180, 476, 0, 0, 700, 820)
	self:addElement(binaryFUI02)
	self.binaryFUI02 = binaryFUI02
	local WindowBg01 = CoD.TabletIcePickGadget_BgWindow.new(f1_arg0, f1_arg1, 0, 0, -255, 635, 0, 0, -148, 712)
	WindowBg01.PixelGrid:setAlpha(0.05)
	WindowBg01.BG:setAlpha(0.25)
	WindowBg01.Frame:setAlpha(0)
	WindowBg01.BlurFrame:setAlpha(0.1)
	self:addElement(WindowBg01)
	self.WindowBg01 = WindowBg01
	local binaryFUI01 = CoD.TabletIcePickGadget_BgElementBinary.new(f1_arg0, f1_arg1, 0, 0, -10, 646, 0, 0, 260, 380)
	self:addElement(binaryFUI01)
	self.binaryFUI01 = binaryFUI01
	local binaryFUI03 = CoD.TabletIcePickGadget_BgElementBinary2.new(f1_arg0, f1_arg1, 0, 0, 52.5, 583.5, 0, 0, 64.5, 128.5)
	binaryFUI03:setAlpha(0)
	self:addElement(binaryFUI03)
	self.binaryFUI03 = binaryFUI03
	local LineFUI02 = CoD.TabletIcePickGadget_BgElementLines.new(f1_arg0, f1_arg1, 0, 0, -97, 203, 0, 0, 140, 304)
	LineFUI02:setZRot(180)
	self:addElement(LineFUI02)
	self.LineFUI02 = LineFUI02
	local LineFUI01 = CoD.TabletIcePickGadget_BgElementLines.new(f1_arg0, f1_arg1, 0, 0, -45, 255, 0, 0, 359, 523)
	self:addElement(LineFUI01)
	self.LineFUI01 = LineFUI01
	local AnalysingBacking = CoD.TabletIcePickGadget_BgElementFui2.new(f1_arg0, f1_arg1, 0, 0, 40, 288, 0, 0, 70.5, 108.5)
	self:addElement(AnalysingBacking)
	self.AnalysingBacking = AnalysingBacking
	local ProgressFui = CoD.TabletIcePickGadget_BgElementFui3.new(f1_arg0, f1_arg1, 0, 0, -156, 392, 0, 0, -90, 302)
	self:addElement(ProgressFui)
	self.ProgressFui = ProgressFui
	local WindowMain = CoD.TabletIcePickGadget_BgWindow.new(f1_arg0, f1_arg1, 0, 0, 174.5, 1579.5, 0, 0, 67.5, 830.5)
	WindowMain.PixelGrid:setAlpha(0.07)
	WindowMain.Frame:setAlpha(0.35)
	WindowMain.BlurFrame:setAlpha(0)
	self:addElement(WindowMain)
	self.WindowMain = WindowMain
	local CenterFractal02 = LUI.UIImage.new(0, 0, 1000, 2000, 0, 0, -320, 160)
	CenterFractal02:setAlpha(0.2)
	CenterFractal02:setImage(RegisterImage(0x86F55135B83852))
	CenterFractal02:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	CenterFractal02:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(CenterFractal02)
	self.CenterFractal02 = CenterFractal02
	local LayoutElement02 = CoD.CommonBgLayoutElement02.new(f1_arg0, f1_arg1, 0, 0, 123, 427, 0, 0, 763, 839)
	LayoutElement02:setRGB(0.02, 0.59, 0.99)
	LayoutElement02:setScale(0.5, 0.5)
	self:addElement(LayoutElement02)
	self.LayoutElement02 = LayoutElement02
	local SectionAGAdd = LUI.UIImage.new(0, 0, 1500, 1568, 0, 0, 59, 75)
	SectionAGAdd:setRGB(0.22, 0.77, 1)
	SectionAGAdd:setAlpha(0.5)
	SectionAGAdd:setImage(RegisterImage(@"uie_ui_hud_tak5_layout_common_element01"))
	SectionAGAdd:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	SectionAGAdd:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(SectionAGAdd)
	self.SectionAGAdd = SectionAGAdd
	local HackBg = LUI.UIImage.new(0, 0, 206, 1430, 0, 0, 151.5, 295.5)
	HackBg:setAlpha(0.02)
	HackBg:setImage(RegisterImage(@"hash_2816694178B99B8A"))
	HackBg:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_67C9C02F608D0A75"))
	HackBg:setShaderVector(0, 0, 0, 0, 0)
	HackBg:setupNineSliceShader(72, 72)
	self:addElement(HackBg)
	self.HackBg = HackBg
	local DestroyBg = LUI.UIImage.new(0, 0, 205, 1429, 0, 0, 368, 512)
	DestroyBg:setAlpha(0.02)
	DestroyBg:setImage(RegisterImage(@"hash_2816694178B99B8A"))
	DestroyBg:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_67C9C02F608D0A75"))
	DestroyBg:setShaderVector(0, 0, 0, 0, 0)
	DestroyBg:setupNineSliceShader(72, 72)
	self:addElement(DestroyBg)
	self.DestroyBg = DestroyBg
	local PlayersBg = LUI.UIImage.new(0, 0, 205, 1429, 0, 0, 583.5, 727.5)
	PlayersBg:setAlpha(0.02)
	PlayersBg:setImage(RegisterImage(@"hash_2816694178B99B8A"))
	PlayersBg:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_67C9C02F608D0A75"))
	PlayersBg:setShaderVector(0, 0, 0, 0, 0)
	PlayersBg:setupNineSliceShader(72, 72)
	self:addElement(PlayersBg)
	self.PlayersBg = PlayersBg
	local TiledPlusGrid = LUI.UIImage.new(0, 0, 70.5, 1333.5, 0, 0, 15.5, 704.5)
	TiledPlusGrid:setRGB(0, 1, 0.92)
	TiledPlusGrid:setAlpha(0.4)
	TiledPlusGrid:setImage(RegisterImage(@"uie_ui_hud_vehicle_hellstorm_repeat_plusgrid"))
	TiledPlusGrid:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_67C9C02F608D0A75"))
	TiledPlusGrid:setShaderVector(0, 0, 0, 0, 0)
	TiledPlusGrid:setupNineSliceShader(216, 216)
	self:addElement(TiledPlusGrid)
	self.TiledPlusGrid = TiledPlusGrid
	local FuiR02 = CoD.TabletIcePickGadget_BgElementFui.new(f1_arg0, f1_arg1, 0, 0, 1442, 1562, 0, 0, 492, 564)
	self:addElement(FuiR02)
	self.FuiR02 = FuiR02
	local FuiR01 = CoD.TabletIcePickGadget_BgElementFui.new(f1_arg0, f1_arg1, 0, 0, 1442, 1562, 0, 0, 277, 349)
	self:addElement(FuiR01)
	self.FuiR01 = FuiR01
	local Players = CoD.TabletIcePick_Category.new(f1_arg0, f1_arg1, 0, 0, 205, 505, 0, 0, 549, 732)
	Players.Entries:setFilter(function(f2_arg0)
		return f2_arg0.hackableCategory:get() == CoD.HUDUtility.IcePickCategories.PLAYER
	end)
	Players.Entries:setDataSource("IcePickHackables")
	Players.Category:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_47D0772660420087"))
	Players:registerEventHandler("gain_focus", function(element, event)
		local f3_local0 = nil
		if element.gainFocus then
			f3_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f3_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_right"])
		return f3_local0
	end)
	f1_arg0:AddButtonCallbackFunction(Players, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], nil, function(element, menu, controller, model)
		CoD.BaseUtility.SendCustomMenuResponse(controller, "IcePick", "id", CoD.HUDUtility.IcePickCategories.PLAYER)
		BlockGameFromKeyEvent(controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_0", nil, nil)
		return false
	end, false)
	f1_arg0:AddButtonCallbackFunction(Players, f1_arg1, Enum[@"luibutton"][@"lui_key_right"], "ui_navright", function(element, menu, controller, model)
		BlockGameFromKeyEvent(controller)
		SetFocusToElement(self, "Equipment", controller)
		SetLoseFocusToElement(self, "Players", controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_right"], @"hash_0", nil, "ui_navright")
		return false
	end, false)
	self:addElement(Players)
	self.Players = Players
	local Vehicles = CoD.TabletIcePick_Category.new(f1_arg0, f1_arg1, 0, 0, 205, 505, 0, 0, 335, 518)
	Vehicles:mergeStateConditions({
		{
			stateName = "FullyHacked",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueGreaterThan(f1_arg1, "IcePickInfo.hackVehicleFinished", 0)
			end,
		},
	})
	local HackDetectionBar = Vehicles
	local Equipment = Vehicles.subscribeToModel
	local HackingFinished = Engine[@"getmodelforcontroller"](f1_arg1)
	Equipment(HackDetectionBar, HackingFinished["IcePickInfo.hackVehicleFinished"], function(f9_arg0)
		f1_arg0:updateElementState(Vehicles, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f9_arg0:get(),
			modelName = "IcePickInfo.hackVehicleFinished",
		})
	end, false)
	Vehicles.Entries:setFilter(function(f10_arg0)
		return f10_arg0.hackableCategory:get() == CoD.HUDUtility.IcePickCategories.VEHICLE
	end)
	Vehicles.Entries:setDataSource("IcePickHackables")
	Vehicles.Category:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_426CC5EC4EC38576"))
	Vehicles:registerEventHandler("gain_focus", function(element, event)
		local f11_local0 = nil
		if element.gainFocus then
			f11_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f11_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_left"])
		return f11_local0
	end)
	f1_arg0:AddButtonCallbackFunction(Vehicles, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], nil, function(element, menu, controller, model)
		CoD.BaseUtility.SendCustomMenuResponse(controller, "IcePick", "id", CoD.HUDUtility.IcePickCategories.VEHICLE)
		BlockGameFromKeyEvent(controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_0", nil, nil)
		return false
	end, false)
	f1_arg0:AddButtonCallbackFunction(Vehicles, f1_arg1, Enum[@"luibutton"][@"lui_key_left"], "ui_navleft", function(element, menu, controller, model)
		BlockGameFromKeyEvent(controller)
		SetFocusToElement(self, "Equipment", controller)
		SetLoseFocusToElement(self, "Vehicles", controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_left"], @"hash_0", nil, "ui_navleft")
		return false
	end, false)
	self:addElement(Vehicles)
	self.Vehicles = Vehicles
	Equipment = CoD.TabletIcePick_Category.new(f1_arg0, f1_arg1, 0, 0, 206, 506, 0, 0, 119, 302)
	Equipment:mergeStateConditions({
		{
			stateName = "FullyHacked",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueGreaterThan(f1_arg1, "IcePickInfo.hackEquipFinished", 0)
			end,
		},
	})
	HackingFinished = Equipment
	HackDetectionBar = Equipment.subscribeToModel
	local JoinButtonPrompt = Engine[@"getmodelforcontroller"](f1_arg1)
	HackDetectionBar(HackingFinished, JoinButtonPrompt["IcePickInfo.hackEquipFinished"], function(f17_arg0)
		f1_arg0:updateElementState(Equipment, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f17_arg0:get(),
			modelName = "IcePickInfo.hackEquipFinished",
		})
	end, false)
	Equipment.Entries:setFilter(function(f18_arg0)
		return f18_arg0.hackableCategory:get() == CoD.HUDUtility.IcePickCategories.EQUIPMENT
	end)
	Equipment.Entries:setDataSource("IcePickHackables")
	Equipment.Category:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_38CF80EAA40E482"))
	Equipment:registerEventHandler("gain_focus", function(element, event)
		local f19_local0 = nil
		if element.gainFocus then
			f19_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f19_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_right"])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_left"])
		return f19_local0
	end)
	f1_arg0:AddButtonCallbackFunction(Equipment, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], nil, function(element, menu, controller, model)
		CoD.BaseUtility.SendCustomMenuResponse(controller, "IcePick", "id", CoD.HUDUtility.IcePickCategories.EQUIPMENT)
		BlockGameFromKeyEvent(controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_0", nil, nil)
		return false
	end, false)
	f1_arg0:AddButtonCallbackFunction(Equipment, f1_arg1, Enum[@"luibutton"][@"lui_key_right"], "ui_navright", function(element, menu, controller, model)
		BlockGameFromKeyEvent(controller)
		SetFocusToElement(self, "Vehicles", controller)
		SetLoseFocusToElement(self, "Equipment", controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_right"], @"hash_0", nil, "ui_navright")
		return false
	end, false)
	f1_arg0:AddButtonCallbackFunction(Equipment, f1_arg1, Enum[@"luibutton"][@"lui_key_left"], "ui_navleft", function(element, menu, controller, model)
		BlockGameFromKeyEvent(controller)
		SetFocusToElement(self, "Players", controller)
		SetLoseFocusToElement(self, "Equipment", controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_left"], @"hash_0", nil, "ui_navleft")
		return false
	end, false)
	self:addElement(Equipment)
	self.Equipment = Equipment
	HackDetectionBar = CoD.TabletIcePickHackDetectionBar.new(f1_arg0, f1_arg1, 0, 0, 760.5, 875.5, 1, 1, 28.5, 48.5)
	HackDetectionBar:linkToElementModel(self, nil, false, function(model)
		HackDetectionBar:setModel(model, f1_arg1)
	end)
	self:addElement(HackDetectionBar)
	self.HackDetectionBar = HackDetectionBar
	HackingFinished = CoD.TabletIcePickGadget_HackFinished.new(f1_arg0, f1_arg1, 0, 0, 514, 1115, 0, 0, 156, 742)
	HackingFinished:setScale(1.5, 1.5)
	self:addElement(HackingFinished)
	self.HackingFinished = HackingFinished
	JoinButtonPrompt = CoD.TabletIcePick_Prompt.new(f1_arg0, f1_arg1, 0, 0, 682, 954, 1, 1, -647.5, -608.5)
	JoinButtonPrompt:linkToElementModel(self, nil, false, function(model)
		JoinButtonPrompt:setModel(model, f1_arg1)
	end)
	self:addElement(JoinButtonPrompt)
	self.JoinButtonPrompt = JoinButtonPrompt
	local windowDotline = LUI.UIImage.new(0, 0, 786, 850, 0, 0, 69, 81)
	windowDotline:setAlpha(0)
	windowDotline:setImage(RegisterImage(@"hash_3C4E6168A6CB350B"))
	windowDotline:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_67C9C02F608D0A75"))
	windowDotline:setShaderVector(0, 0, 0, 0, 0)
	windowDotline:setupNineSliceShader(36, 12)
	self:addElement(windowDotline)
	self.windowDotline = windowDotline
	self:mergeStateConditions({
		{
			stateName = "Finished",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueGreaterThan(element, f1_arg1, "hackFinished", 0)
			end,
		},
	})
	self:linkToElementModel(self, "hackFinished", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "hackFinished",
		})
	end)
	Players.id = "Players"
	Vehicles.id = "Vehicles"
	Equipment.id = "Equipment"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local34 = self
	DelaySetFocusToElement(self, "JoinButtonPrompt", f1_arg1, 0)
	f1_local34 = JoinButtonPrompt
	CoD.HUDUtility[@"hash_3E213B828E44EBE4"](f1_arg0, self, f1_arg1)
	return self
end
CoD.TabletIcePickGadget_Internal.__resetProperties = function(f30_arg0)
	f30_arg0.PlayersBg:completeAnimation()
	f30_arg0.DestroyBg:completeAnimation()
	f30_arg0.HackBg:completeAnimation()
	f30_arg0.Vehicles:completeAnimation()
	f30_arg0.Players:completeAnimation()
	f30_arg0.PixelGridTiledBacking:completeAnimation()
	f30_arg0.binaryFUI01:completeAnimation()
	f30_arg0.GridLine:completeAnimation()
	f30_arg0.TiledPlusGrid:completeAnimation()
	f30_arg0.LineFUI01:completeAnimation()
	f30_arg0.LineFUI02:completeAnimation()
	f30_arg0.HackDetectionBar:completeAnimation()
	f30_arg0.Equipment:completeAnimation()
	f30_arg0.GridLineAdd:completeAnimation()
	f30_arg0.binaryFUI02:completeAnimation()
	f30_arg0.FuiR01:completeAnimation()
	f30_arg0.FuiR02:completeAnimation()
	f30_arg0.LayoutElement02:completeAnimation()
	f30_arg0.AnalysingBacking:completeAnimation()
	f30_arg0.ProgressFui:completeAnimation()
	f30_arg0.binaryFUI03:completeAnimation()
	f30_arg0.WindowBg02:completeAnimation()
	f30_arg0.WindowBg01:completeAnimation()
	f30_arg0.WindowMain:completeAnimation()
	f30_arg0.HackingFinished:completeAnimation()
	f30_arg0.JoinButtonPrompt:completeAnimation()
	f30_arg0.windowDotline:completeAnimation()
	f30_arg0.PlayersBg:setAlpha(0.02)
	f30_arg0.DestroyBg:setAlpha(0.02)
	f30_arg0.HackBg:setAlpha(0.02)
	f30_arg0.Vehicles:setAlpha(1)
	f30_arg0.Players:setAlpha(1)
	f30_arg0.PixelGridTiledBacking:setAlpha(0.1)
	f30_arg0.binaryFUI01:setAlpha(1)
	f30_arg0.GridLine:setAlpha(1)
	f30_arg0.TiledPlusGrid:setAlpha(0.4)
	f30_arg0.LineFUI01:setAlpha(1)
	f30_arg0.LineFUI02:setTopBottom(0, 0, 140, 304)
	f30_arg0.LineFUI02:setAlpha(1)
	f30_arg0.HackDetectionBar:setAlpha(1)
	f30_arg0.Equipment:setAlpha(1)
	f30_arg0.GridLineAdd:setAlpha(0.5)
	f30_arg0.binaryFUI02:setAlpha(1)
	f30_arg0.FuiR01:setAlpha(1)
	f30_arg0.FuiR02:setAlpha(1)
	f30_arg0.LayoutElement02:setAlpha(1)
	f30_arg0.AnalysingBacking:setAlpha(1)
	f30_arg0.ProgressFui:setAlpha(1)
	f30_arg0.binaryFUI03:setAlpha(0)
	f30_arg0.WindowBg02:setAlpha(1)
	f30_arg0.WindowBg01:setAlpha(1)
	f30_arg0.WindowMain:setAlpha(1)
	f30_arg0.HackingFinished:setTopBottom(0, 0, 156, 742)
	f30_arg0.HackingFinished:setAlpha(1)
	f30_arg0.JoinButtonPrompt:setAlpha(1)
	f30_arg0.windowDotline:setAlpha(0)
end
CoD.TabletIcePickGadget_Internal.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f31_arg0, f31_arg1)
			f31_arg0:__resetProperties()
			f31_arg0:setupElementClipCounter(27)
			local f31_local0 = function(f32_arg0)
				local f32_local0 = function(f33_arg0)
					local f33_local0 = function(f34_arg0)
						f34_arg0:beginAnimation(79)
						f34_arg0:setAlpha(0.05)
						f34_arg0:registerEventHandler("transition_complete_keyframe", f31_arg0.clipFinished)
					end
					f33_arg0:beginAnimation(220)
					f33_arg0:setAlpha(0.1)
					f33_arg0:registerEventHandler("transition_complete_keyframe", f33_local0)
				end
				f31_arg0.PixelGridTiledBacking:beginAnimation(400)
				f31_arg0.PixelGridTiledBacking:registerEventHandler("interrupted_keyframe", f31_arg0.clipInterrupted)
				f31_arg0.PixelGridTiledBacking:registerEventHandler("transition_complete_keyframe", f32_local0)
			end
			f31_arg0.PixelGridTiledBacking:completeAnimation()
			f31_arg0.PixelGridTiledBacking:setAlpha(0)
			f31_local0(f31_arg0.PixelGridTiledBacking)
			local f31_local1 = function(f35_arg0)
				local f35_local0 = function(f36_arg0)
					local f36_local0 = function(f37_arg0)
						local f37_local0 = function(f38_arg0)
							f38_arg0:beginAnimation(380)
							f38_arg0:setAlpha(0.7)
							f38_arg0:registerEventHandler("transition_complete_keyframe", f31_arg0.clipFinished)
						end
						f37_arg0:beginAnimation(220)
						f37_arg0:registerEventHandler("transition_complete_keyframe", f37_local0)
					end
					f36_arg0:beginAnimation(200)
					f36_arg0:setAlpha(1)
					f36_arg0:registerEventHandler("transition_complete_keyframe", f36_local0)
				end
				f31_arg0.GridLine:beginAnimation(200)
				f31_arg0.GridLine:registerEventHandler("interrupted_keyframe", f31_arg0.clipInterrupted)
				f31_arg0.GridLine:registerEventHandler("transition_complete_keyframe", f35_local0)
			end
			f31_arg0.GridLine:completeAnimation()
			f31_arg0.GridLine:setAlpha(0)
			f31_local1(f31_arg0.GridLine)
			local f31_local2 = function(f39_arg0)
				local f39_local0 = function(f40_arg0)
					local f40_local0 = function(f41_arg0)
						f41_arg0:beginAnimation(210)
						f41_arg0:setAlpha(0.8)
						f41_arg0:registerEventHandler("transition_complete_keyframe", f31_arg0.clipFinished)
					end
					f40_arg0:beginAnimation(89)
					f40_arg0:registerEventHandler("transition_complete_keyframe", f40_local0)
				end
				f31_arg0.GridLineAdd:beginAnimation(200)
				f31_arg0.GridLineAdd:setAlpha(1)
				f31_arg0.GridLineAdd:registerEventHandler("interrupted_keyframe", f31_arg0.clipInterrupted)
				f31_arg0.GridLineAdd:registerEventHandler("transition_complete_keyframe", f39_local0)
			end
			f31_arg0.GridLineAdd:completeAnimation()
			f31_arg0.GridLineAdd:setAlpha(0)
			f31_local2(f31_arg0.GridLineAdd)
			local f31_local3 = function(f42_arg0)
				f31_arg0.WindowBg02:beginAnimation(100, Enum[@"luitween"][@"luitween_ease_out"])
				f31_arg0.WindowBg02:setAlpha(1)
				f31_arg0.WindowBg02:registerEventHandler("interrupted_keyframe", f31_arg0.clipInterrupted)
				f31_arg0.WindowBg02:registerEventHandler("transition_complete_keyframe", f31_arg0.clipFinished)
			end
			f31_arg0.WindowBg02:completeAnimation()
			f31_arg0.WindowBg02:setAlpha(0)
			f31_local3(f31_arg0.WindowBg02)
			local f31_local4 = function(f43_arg0)
				local f43_local0 = function(f44_arg0)
					local f44_local0 = function(f45_arg0)
						local f45_local0 = function(f46_arg0)
							f46_arg0:beginAnimation(600)
							f46_arg0:setAlpha(0.15)
							f46_arg0:registerEventHandler("transition_complete_keyframe", function(element, event)
								element:playClip("DefaultClip")
								f31_arg0.clipFinished(element, event)
							end)
						end
						f45_arg0:beginAnimation(400)
						f45_arg0:registerEventHandler("transition_complete_keyframe", f45_local0)
					end
					f44_arg0:playClip("DefaultClip")
					f44_arg0:beginAnimation(100)
					f44_arg0:setAlpha(0.6)
					f44_arg0:registerEventHandler("transition_complete_keyframe", f44_local0)
				end
				f31_arg0.binaryFUI02:beginAnimation(100)
				f31_arg0.binaryFUI02:registerEventHandler("interrupted_keyframe", f31_arg0.clipInterrupted)
				f31_arg0.binaryFUI02:registerEventHandler("transition_complete_keyframe", f43_local0)
			end
			f31_arg0.binaryFUI02:completeAnimation()
			f31_arg0.binaryFUI02:setAlpha(0)
			f31_local4(f31_arg0.binaryFUI02)
			local f31_local5 = function(f48_arg0)
				local f48_local0 = function(f49_arg0)
					f49_arg0:beginAnimation(100, Enum[@"luitween"][@"luitween_ease_out"])
					f49_arg0:setAlpha(1)
					f49_arg0:registerEventHandler("transition_complete_keyframe", f31_arg0.clipFinished)
				end
				f31_arg0.WindowBg01:beginAnimation(100)
				f31_arg0.WindowBg01:registerEventHandler("interrupted_keyframe", f31_arg0.clipInterrupted)
				f31_arg0.WindowBg01:registerEventHandler("transition_complete_keyframe", f48_local0)
			end
			f31_arg0.WindowBg01:completeAnimation()
			f31_arg0.WindowBg01:setAlpha(0)
			f31_local5(f31_arg0.WindowBg01)
			local f31_local6 = function(f50_arg0)
				local f50_local0 = function(f51_arg0)
					local f51_local0 = function(f52_arg0)
						local f52_local0 = function(f53_arg0)
							f53_arg0:beginAnimation(900)
							f53_arg0:setAlpha(0.2)
							f53_arg0:registerEventHandler("transition_complete_keyframe", function(element, event)
								element:playClip("DefaultClip")
								f31_arg0.clipFinished(element, event)
							end)
						end
						f52_arg0:beginAnimation(400)
						f52_arg0:registerEventHandler("transition_complete_keyframe", f52_local0)
					end
					f51_arg0:beginAnimation(100)
					f51_arg0:setAlpha(0.8)
					f51_arg0:registerEventHandler("transition_complete_keyframe", f51_local0)
				end
				f31_arg0.binaryFUI01:playClip("DefaultClip")
				f31_arg0.binaryFUI01:beginAnimation(100)
				f31_arg0.binaryFUI01:registerEventHandler("interrupted_keyframe", f31_arg0.clipInterrupted)
				f31_arg0.binaryFUI01:registerEventHandler("transition_complete_keyframe", f50_local0)
			end
			f31_arg0.binaryFUI01:completeAnimation()
			f31_arg0.binaryFUI01:setAlpha(0)
			f31_local6(f31_arg0.binaryFUI01)
			local f31_local7 = function(f55_arg0)
				local f55_local0 = function(f56_arg0)
					local f56_local0 = function(f57_arg0)
						f57_arg0:beginAnimation(299)
						f57_arg0:setAlpha(0.15)
						f57_arg0:registerEventHandler("transition_complete_keyframe", f31_arg0.clipFinished)
					end
					f56_arg0:beginAnimation(150)
					f56_arg0:setAlpha(0.4)
					f56_arg0:registerEventHandler("transition_complete_keyframe", f56_local0)
				end
				f31_arg0.binaryFUI03:beginAnimation(450)
				f31_arg0.binaryFUI03:registerEventHandler("interrupted_keyframe", f31_arg0.clipInterrupted)
				f31_arg0.binaryFUI03:registerEventHandler("transition_complete_keyframe", f55_local0)
			end
			f31_arg0.binaryFUI03:completeAnimation()
			f31_arg0.binaryFUI03:setAlpha(0)
			f31_local7(f31_arg0.binaryFUI03)
			local f31_local8 = function(f58_arg0)
				local f58_local0 = function(f59_arg0)
					local f59_local0 = function(f60_arg0)
						local f60_local0 = function(f61_arg0)
							local f61_local0 = function(f62_arg0)
								f62_arg0:beginAnimation(900)
								f62_arg0:setAlpha(0.15)
								f62_arg0:registerEventHandler("transition_complete_keyframe", function(element, event)
									element:playClip("DefaultClip")
									f31_arg0.clipFinished(element, event)
								end)
							end
							f61_arg0:beginAnimation(89)
							f61_arg0:registerEventHandler("transition_complete_keyframe", f61_local0)
						end
						f60_arg0:beginAnimation(310)
						f60_arg0:registerEventHandler("transition_complete_keyframe", f60_local0)
					end
					f59_arg0:playClip("DefaultClip")
					f59_arg0:beginAnimation(200)
					f59_arg0:setAlpha(0.5)
					f59_arg0:registerEventHandler("transition_complete_keyframe", f59_local0)
				end
				f31_arg0.LineFUI02:beginAnimation(100)
				f31_arg0.LineFUI02:registerEventHandler("interrupted_keyframe", f31_arg0.clipInterrupted)
				f31_arg0.LineFUI02:registerEventHandler("transition_complete_keyframe", f58_local0)
			end
			f31_arg0.LineFUI02:completeAnimation()
			f31_arg0.LineFUI02:setTopBottom(0, 0, 142.5, 306.5)
			f31_arg0.LineFUI02:setAlpha(0)
			f31_local8(f31_arg0.LineFUI02)
			local f31_local9 = function(f64_arg0)
				local f64_local0 = function(f65_arg0)
					local f65_local0 = function(f66_arg0)
						local f66_local0 = function(f67_arg0)
							f67_arg0:beginAnimation(900)
							f67_arg0:setAlpha(0.2)
							f67_arg0:registerEventHandler("transition_complete_keyframe", function(element, event)
								element:playClip("DefaultClip")
								f31_arg0.clipFinished(element, event)
							end)
						end
						f66_arg0:beginAnimation(400)
						f66_arg0:registerEventHandler("transition_complete_keyframe", f66_local0)
					end
					f65_arg0:beginAnimation(100)
					f65_arg0:setAlpha(0.8)
					f65_arg0:registerEventHandler("transition_complete_keyframe", f65_local0)
				end
				f31_arg0.LineFUI01:playClip("DefaultClip")
				f31_arg0.LineFUI01:beginAnimation(100)
				f31_arg0.LineFUI01:registerEventHandler("interrupted_keyframe", f31_arg0.clipInterrupted)
				f31_arg0.LineFUI01:registerEventHandler("transition_complete_keyframe", f64_local0)
			end
			f31_arg0.LineFUI01:completeAnimation()
			f31_arg0.LineFUI01:setAlpha(0)
			f31_local9(f31_arg0.LineFUI01)
			local f31_local10 = function(f69_arg0)
				local f69_local0 = function(f70_arg0)
					f70_arg0:beginAnimation(199, Enum[@"luitween"][@"luitween_ease_out"])
					f70_arg0:setAlpha(1)
					f70_arg0:registerEventHandler("transition_complete_keyframe", f31_arg0.clipFinished)
				end
				f31_arg0.AnalysingBacking:beginAnimation(300)
				f31_arg0.AnalysingBacking:registerEventHandler("interrupted_keyframe", f31_arg0.clipInterrupted)
				f31_arg0.AnalysingBacking:registerEventHandler("transition_complete_keyframe", f69_local0)
			end
			f31_arg0.AnalysingBacking:completeAnimation()
			f31_arg0.AnalysingBacking:setAlpha(0)
			f31_local10(f31_arg0.AnalysingBacking)
			local f31_local11 = function(f71_arg0)
				local f71_local0 = function(f72_arg0)
					local f72_local0 = function(f73_arg0)
						local f73_local0 = function(f74_arg0)
							f74_arg0:beginAnimation(500)
							f74_arg0:setAlpha(0.3)
							f74_arg0:registerEventHandler("transition_complete_keyframe", f31_arg0.clipFinished)
						end
						f73_arg0:beginAnimation(399)
						f73_arg0:registerEventHandler("transition_complete_keyframe", f73_local0)
					end
					f72_arg0:beginAnimation(150)
					f72_arg0:setAlpha(0.5)
					f72_arg0:registerEventHandler("transition_complete_keyframe", f72_local0)
				end
				f31_arg0.ProgressFui:beginAnimation(450)
				f31_arg0.ProgressFui:registerEventHandler("interrupted_keyframe", f31_arg0.clipInterrupted)
				f31_arg0.ProgressFui:registerEventHandler("transition_complete_keyframe", f71_local0)
			end
			f31_arg0.ProgressFui:completeAnimation()
			f31_arg0.ProgressFui:setAlpha(0)
			f31_local11(f31_arg0.ProgressFui)
			local f31_local12 = function(f75_arg0)
				local f75_local0 = function(f76_arg0)
					f76_arg0:beginAnimation(100, Enum[@"luitween"][@"luitween_ease_out"])
					f76_arg0:setAlpha(1)
					f76_arg0:registerEventHandler("transition_complete_keyframe", f31_arg0.clipFinished)
				end
				f31_arg0.WindowMain:beginAnimation(200)
				f31_arg0.WindowMain:registerEventHandler("interrupted_keyframe", f31_arg0.clipInterrupted)
				f31_arg0.WindowMain:registerEventHandler("transition_complete_keyframe", f75_local0)
			end
			f31_arg0.WindowMain:completeAnimation()
			f31_arg0.WindowMain:setAlpha(0)
			f31_local12(f31_arg0.WindowMain)
			local f31_local13 = function(f77_arg0)
				f31_arg0.LayoutElement02:beginAnimation(200)
				f31_arg0.LayoutElement02:setAlpha(1)
				f31_arg0.LayoutElement02:registerEventHandler("interrupted_keyframe", f31_arg0.clipInterrupted)
				f31_arg0.LayoutElement02:registerEventHandler("transition_complete_keyframe", f31_arg0.clipFinished)
			end
			f31_arg0.LayoutElement02:completeAnimation()
			f31_arg0.LayoutElement02:setAlpha(0)
			f31_local13(f31_arg0.LayoutElement02)
			local f31_local14 = function(f78_arg0)
				local f78_local0 = function(f79_arg0)
					local f79_local0 = function(f80_arg0)
						local f80_local0 = function(f81_arg0)
							local f81_local0 = function(f82_arg0)
								local f82_local0 = function(f83_arg0)
									local f83_local0 = function(f84_arg0)
										local f84_local0 = function(f85_arg0)
											local f85_local0 = function(f86_arg0)
												local f86_local0 = function(f87_arg0)
													f87_arg0:beginAnimation(50)
													f87_arg0:setAlpha(0.05)
													f87_arg0:registerEventHandler("transition_complete_keyframe", f31_arg0.clipFinished)
												end
												f86_arg0:beginAnimation(30)
												f86_arg0:registerEventHandler("transition_complete_keyframe", f86_local0)
											end
											f85_arg0:beginAnimation(89)
											f85_arg0:setAlpha(0.2)
											f85_arg0:registerEventHandler("transition_complete_keyframe", f85_local0)
										end
										f84_arg0:beginAnimation(30)
										f84_arg0:setAlpha(0)
										f84_arg0:registerEventHandler("transition_complete_keyframe", f84_local0)
									end
									f83_arg0:beginAnimation(20)
									f83_arg0:setAlpha(0.15)
									f83_arg0:registerEventHandler("transition_complete_keyframe", f83_local0)
								end
								f82_arg0:beginAnimation(19)
								f82_arg0:setAlpha(0)
								f82_arg0:registerEventHandler("transition_complete_keyframe", f82_local0)
							end
							f81_arg0:beginAnimation(20)
							f81_arg0:setAlpha(0.09)
							f81_arg0:registerEventHandler("transition_complete_keyframe", f81_local0)
						end
						f80_arg0:beginAnimation(20)
						f80_arg0:setAlpha(0)
						f80_arg0:registerEventHandler("transition_complete_keyframe", f80_local0)
					end
					f79_arg0:beginAnimation(19)
					f79_arg0:setAlpha(0.05)
					f79_arg0:registerEventHandler("transition_complete_keyframe", f79_local0)
				end
				f31_arg0.HackBg:beginAnimation(300)
				f31_arg0.HackBg:registerEventHandler("interrupted_keyframe", f31_arg0.clipInterrupted)
				f31_arg0.HackBg:registerEventHandler("transition_complete_keyframe", f78_local0)
			end
			f31_arg0.HackBg:completeAnimation()
			f31_arg0.HackBg:setAlpha(0)
			f31_local14(f31_arg0.HackBg)
			local f31_local15 = function(f88_arg0)
				local f88_local0 = function(f89_arg0)
					local f89_local0 = function(f90_arg0)
						local f90_local0 = function(f91_arg0)
							local f91_local0 = function(f92_arg0)
								local f92_local0 = function(f93_arg0)
									local f93_local0 = function(f94_arg0)
										local f94_local0 = function(f95_arg0)
											local f95_local0 = function(f96_arg0)
												local f96_local0 = function(f97_arg0)
													f97_arg0:beginAnimation(50)
													f97_arg0:setAlpha(0.05)
													f97_arg0:registerEventHandler("transition_complete_keyframe", f31_arg0.clipFinished)
												end
												f96_arg0:beginAnimation(29)
												f96_arg0:registerEventHandler("transition_complete_keyframe", f96_local0)
											end
											f95_arg0:beginAnimation(90)
											f95_arg0:setAlpha(0.2)
											f95_arg0:registerEventHandler("transition_complete_keyframe", f95_local0)
										end
										f94_arg0:beginAnimation(30)
										f94_arg0:setAlpha(0)
										f94_arg0:registerEventHandler("transition_complete_keyframe", f94_local0)
									end
									f93_arg0:beginAnimation(19)
									f93_arg0:setAlpha(0.15)
									f93_arg0:registerEventHandler("transition_complete_keyframe", f93_local0)
								end
								f92_arg0:beginAnimation(20)
								f92_arg0:setAlpha(0)
								f92_arg0:registerEventHandler("transition_complete_keyframe", f92_local0)
							end
							f91_arg0:beginAnimation(20)
							f91_arg0:setAlpha(0.09)
							f91_arg0:registerEventHandler("transition_complete_keyframe", f91_local0)
						end
						f90_arg0:beginAnimation(19)
						f90_arg0:setAlpha(0)
						f90_arg0:registerEventHandler("transition_complete_keyframe", f90_local0)
					end
					f89_arg0:beginAnimation(20)
					f89_arg0:setAlpha(0.09)
					f89_arg0:registerEventHandler("transition_complete_keyframe", f89_local0)
				end
				f31_arg0.DestroyBg:beginAnimation(380)
				f31_arg0.DestroyBg:registerEventHandler("interrupted_keyframe", f31_arg0.clipInterrupted)
				f31_arg0.DestroyBg:registerEventHandler("transition_complete_keyframe", f88_local0)
			end
			f31_arg0.DestroyBg:completeAnimation()
			f31_arg0.DestroyBg:setAlpha(0)
			f31_local15(f31_arg0.DestroyBg)
			local f31_local16 = function(f98_arg0)
				local f98_local0 = function(f99_arg0)
					local f99_local0 = function(f100_arg0)
						local f100_local0 = function(f101_arg0)
							local f101_local0 = function(f102_arg0)
								local f102_local0 = function(f103_arg0)
									local f103_local0 = function(f104_arg0)
										local f104_local0 = function(f105_arg0)
											local f105_local0 = function(f106_arg0)
												local f106_local0 = function(f107_arg0)
													f107_arg0:beginAnimation(50)
													f107_arg0:setAlpha(0.05)
													f107_arg0:registerEventHandler("transition_complete_keyframe", f31_arg0.clipFinished)
												end
												f106_arg0:beginAnimation(29)
												f106_arg0:registerEventHandler("transition_complete_keyframe", f106_local0)
											end
											f105_arg0:beginAnimation(90)
											f105_arg0:setAlpha(0.2)
											f105_arg0:registerEventHandler("transition_complete_keyframe", f105_local0)
										end
										f104_arg0:beginAnimation(29)
										f104_arg0:setAlpha(0)
										f104_arg0:registerEventHandler("transition_complete_keyframe", f104_local0)
									end
									f103_arg0:beginAnimation(19)
									f103_arg0:setAlpha(0.15)
									f103_arg0:registerEventHandler("transition_complete_keyframe", f103_local0)
								end
								f102_arg0:beginAnimation(20)
								f102_arg0:setAlpha(0)
								f102_arg0:registerEventHandler("transition_complete_keyframe", f102_local0)
							end
							f101_arg0:beginAnimation(19)
							f101_arg0:setAlpha(0.1)
							f101_arg0:registerEventHandler("transition_complete_keyframe", f101_local0)
						end
						f100_arg0:beginAnimation(20)
						f100_arg0:setAlpha(0)
						f100_arg0:registerEventHandler("transition_complete_keyframe", f100_local0)
					end
					f99_arg0:beginAnimation(19)
					f99_arg0:setAlpha(0.08)
					f99_arg0:registerEventHandler("transition_complete_keyframe", f99_local0)
				end
				f31_arg0.PlayersBg:beginAnimation(460)
				f31_arg0.PlayersBg:registerEventHandler("interrupted_keyframe", f31_arg0.clipInterrupted)
				f31_arg0.PlayersBg:registerEventHandler("transition_complete_keyframe", f98_local0)
			end
			f31_arg0.PlayersBg:completeAnimation()
			f31_arg0.PlayersBg:setAlpha(0)
			f31_local16(f31_arg0.PlayersBg)
			local f31_local17 = function(f108_arg0)
				local f108_local0 = function(f109_arg0)
					local f109_local0 = function(f110_arg0)
						f110_arg0:beginAnimation(199)
						f110_arg0:setAlpha(0.7)
						f110_arg0:registerEventHandler("transition_complete_keyframe", f31_arg0.clipFinished)
					end
					f109_arg0:beginAnimation(100)
					f109_arg0:registerEventHandler("transition_complete_keyframe", f109_local0)
				end
				f31_arg0.TiledPlusGrid:beginAnimation(500)
				f31_arg0.TiledPlusGrid:setAlpha(1)
				f31_arg0.TiledPlusGrid:registerEventHandler("interrupted_keyframe", f31_arg0.clipInterrupted)
				f31_arg0.TiledPlusGrid:registerEventHandler("transition_complete_keyframe", f108_local0)
			end
			f31_arg0.TiledPlusGrid:completeAnimation()
			f31_arg0.TiledPlusGrid:setAlpha(0)
			f31_local17(f31_arg0.TiledPlusGrid)
			local f31_local18 = function(f111_arg0)
				local f111_local0 = function(f112_arg0)
					local f112_local0 = function(f113_arg0)
						local f113_local0 = function(f114_arg0)
							f114_arg0:beginAnimation(200)
							f114_arg0:setAlpha(0.6)
							f114_arg0:registerEventHandler("transition_complete_keyframe", f31_arg0.clipFinished)
						end
						f113_arg0:beginAnimation(199)
						f113_arg0:registerEventHandler("transition_complete_keyframe", f113_local0)
					end
					f112_arg0:beginAnimation(300)
					f112_arg0:setAlpha(1)
					f112_arg0:registerEventHandler("transition_complete_keyframe", f112_local0)
				end
				f31_arg0.FuiR02:beginAnimation(800)
				f31_arg0.FuiR02:registerEventHandler("interrupted_keyframe", f31_arg0.clipInterrupted)
				f31_arg0.FuiR02:registerEventHandler("transition_complete_keyframe", f111_local0)
			end
			f31_arg0.FuiR02:completeAnimation()
			f31_arg0.FuiR02:setAlpha(0)
			f31_local18(f31_arg0.FuiR02)
			local f31_local19 = function(f115_arg0)
				local f115_local0 = function(f116_arg0)
					local f116_local0 = function(f117_arg0)
						local f117_local0 = function(f118_arg0)
							f118_arg0:beginAnimation(200)
							f118_arg0:setAlpha(0.6)
							f118_arg0:registerEventHandler("transition_complete_keyframe", f31_arg0.clipFinished)
						end
						f117_arg0:beginAnimation(499)
						f117_arg0:registerEventHandler("transition_complete_keyframe", f117_local0)
					end
					f116_arg0:beginAnimation(300)
					f116_arg0:setAlpha(1)
					f116_arg0:registerEventHandler("transition_complete_keyframe", f116_local0)
				end
				f31_arg0.FuiR01:beginAnimation(500)
				f31_arg0.FuiR01:registerEventHandler("interrupted_keyframe", f31_arg0.clipInterrupted)
				f31_arg0.FuiR01:registerEventHandler("transition_complete_keyframe", f115_local0)
			end
			f31_arg0.FuiR01:completeAnimation()
			f31_arg0.FuiR01:setAlpha(0)
			f31_local19(f31_arg0.FuiR01)
			local f31_local20 = function(f119_arg0)
				local f119_local0 = function(f120_arg0)
					f120_arg0:beginAnimation(250, Enum[@"luitween"][@"luitween_ease_out"])
					f120_arg0:setAlpha(1)
					f120_arg0:registerEventHandler("transition_complete_keyframe", f31_arg0.clipFinished)
				end
				f31_arg0.Players:beginAnimation(590)
				f31_arg0.Players:registerEventHandler("interrupted_keyframe", f31_arg0.clipInterrupted)
				f31_arg0.Players:registerEventHandler("transition_complete_keyframe", f119_local0)
			end
			f31_arg0.Players:completeAnimation()
			f31_arg0.Players:setAlpha(0)
			f31_local20(f31_arg0.Players)
			local f31_local21 = function(f121_arg0)
				local f121_local0 = function(f122_arg0)
					f122_arg0:beginAnimation(250, Enum[@"luitween"][@"luitween_ease_out"])
					f122_arg0:setAlpha(1)
					f122_arg0:registerEventHandler("transition_complete_keyframe", f31_arg0.clipFinished)
				end
				f31_arg0.Vehicles:beginAnimation(510)
				f31_arg0.Vehicles:registerEventHandler("interrupted_keyframe", f31_arg0.clipInterrupted)
				f31_arg0.Vehicles:registerEventHandler("transition_complete_keyframe", f121_local0)
			end
			f31_arg0.Vehicles:completeAnimation()
			f31_arg0.Vehicles:setAlpha(0)
			f31_local21(f31_arg0.Vehicles)
			local f31_local22 = function(f123_arg0)
				local f123_local0 = function(f124_arg0)
					f124_arg0:beginAnimation(250, Enum[@"luitween"][@"luitween_ease_out"])
					f124_arg0:setAlpha(1)
					f124_arg0:registerEventHandler("transition_complete_keyframe", f31_arg0.clipFinished)
				end
				f31_arg0.Equipment:beginAnimation(430)
				f31_arg0.Equipment:registerEventHandler("interrupted_keyframe", f31_arg0.clipInterrupted)
				f31_arg0.Equipment:registerEventHandler("transition_complete_keyframe", f123_local0)
			end
			f31_arg0.Equipment:completeAnimation()
			f31_arg0.Equipment:setAlpha(0)
			f31_local22(f31_arg0.Equipment)
			local f31_local23 = function(f125_arg0)
				local f125_local0 = function(f126_arg0)
					local f126_local0 = function(f127_arg0)
						local f127_local0 = function(f128_arg0)
							local f128_local0 = function(f129_arg0)
								local f129_local0 = function(f130_arg0)
									f130_arg0:beginAnimation(599, Enum[@"luitween"][@"luitween_ease_out"])
									f130_arg0:setAlpha(1)
									f130_arg0:registerEventHandler("transition_complete_keyframe", f31_arg0.clipFinished)
								end
								f129_arg0:beginAnimation(400)
								f129_arg0:setAlpha(0.5)
								f129_arg0:registerEventHandler("transition_complete_keyframe", f129_local0)
							end
							f128_arg0:beginAnimation(399, Enum[@"luitween"][@"luitween_ease_out"])
							f128_arg0:setAlpha(1)
							f128_arg0:registerEventHandler("transition_complete_keyframe", f128_local0)
						end
						f127_arg0:beginAnimation(360)
						f127_arg0:setAlpha(0.2)
						f127_arg0:registerEventHandler("transition_complete_keyframe", f127_local0)
					end
					f126_arg0:beginAnimation(400, Enum[@"luitween"][@"luitween_ease_out"])
					f126_arg0:setAlpha(1)
					f126_arg0:registerEventHandler("transition_complete_keyframe", f126_local0)
				end
				f31_arg0.HackDetectionBar:beginAnimation(840)
				f31_arg0.HackDetectionBar:registerEventHandler("interrupted_keyframe", f31_arg0.clipInterrupted)
				f31_arg0.HackDetectionBar:registerEventHandler("transition_complete_keyframe", f125_local0)
			end
			f31_arg0.HackDetectionBar:completeAnimation()
			f31_arg0.HackDetectionBar:setAlpha(0)
			f31_local23(f31_arg0.HackDetectionBar)
			f31_arg0.HackingFinished:completeAnimation()
			f31_arg0.HackingFinished:setTopBottom(0, 0, 119, 700)
			f31_arg0.HackingFinished:setAlpha(0)
			f31_arg0.clipFinished(f31_arg0.HackingFinished)
			local f31_local24 = function(f131_arg0)
				local f131_local0 = function(f132_arg0)
					f132_arg0:beginAnimation(100, Enum[@"luitween"][@"luitween_ease_out"])
					f132_arg0:setAlpha(1)
					f132_arg0:registerEventHandler("transition_complete_keyframe", f31_arg0.clipFinished)
				end
				f31_arg0.JoinButtonPrompt:beginAnimation(200)
				f31_arg0.JoinButtonPrompt:registerEventHandler("interrupted_keyframe", f31_arg0.clipInterrupted)
				f31_arg0.JoinButtonPrompt:registerEventHandler("transition_complete_keyframe", f131_local0)
			end
			f31_arg0.JoinButtonPrompt:completeAnimation()
			f31_arg0.JoinButtonPrompt:setAlpha(0)
			f31_local24(f31_arg0.JoinButtonPrompt)
			local f31_local25 = function(f133_arg0)
				local f133_local0 = function(f134_arg0)
					local f134_local0 = function(f135_arg0)
						f135_arg0:beginAnimation(399)
						f135_arg0:setAlpha(0.3)
						f135_arg0:registerEventHandler("transition_complete_keyframe", f31_arg0.clipFinished)
					end
					f134_arg0:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_out"])
					f134_arg0:setAlpha(1)
					f134_arg0:registerEventHandler("transition_complete_keyframe", f134_local0)
				end
				f31_arg0.windowDotline:beginAnimation(400)
				f31_arg0.windowDotline:registerEventHandler("interrupted_keyframe", f31_arg0.clipInterrupted)
				f31_arg0.windowDotline:registerEventHandler("transition_complete_keyframe", f133_local0)
			end
			f31_arg0.windowDotline:completeAnimation()
			f31_arg0.windowDotline:setAlpha(0)
			f31_local25(f31_arg0.windowDotline)
		end,
	},
	Finished = {
		DefaultClip = function(f136_arg0, f136_arg1)
			f136_arg0:__resetProperties()
			f136_arg0:setupElementClipCounter(7)
			f136_arg0.PixelGridTiledBacking:completeAnimation()
			f136_arg0.PixelGridTiledBacking:setAlpha(0.05)
			f136_arg0.clipFinished(f136_arg0.PixelGridTiledBacking)
			local f136_local0 = function(f137_arg0)
				f136_arg0.Players:beginAnimation(100, Enum[@"luitween"][@"luitween_ease_out"])
				f136_arg0.Players:setAlpha(0)
				f136_arg0.Players:registerEventHandler("interrupted_keyframe", f136_arg0.clipInterrupted)
				f136_arg0.Players:registerEventHandler("transition_complete_keyframe", f136_arg0.clipFinished)
			end
			f136_arg0.Players:completeAnimation()
			f136_arg0.Players:setAlpha(1)
			f136_local0(f136_arg0.Players)
			local f136_local1 = function(f138_arg0)
				local f138_local0 = function(f139_arg0)
					f139_arg0:beginAnimation(100)
					f139_arg0:setAlpha(0)
					f139_arg0:registerEventHandler("transition_complete_keyframe", f136_arg0.clipFinished)
				end
				f136_arg0.Vehicles:beginAnimation(50)
				f136_arg0.Vehicles:registerEventHandler("interrupted_keyframe", f136_arg0.clipInterrupted)
				f136_arg0.Vehicles:registerEventHandler("transition_complete_keyframe", f138_local0)
			end
			f136_arg0.Vehicles:completeAnimation()
			f136_arg0.Vehicles:setAlpha(1)
			f136_local1(f136_arg0.Vehicles)
			local f136_local2 = function(f140_arg0)
				local f140_local0 = function(f141_arg0)
					f141_arg0:beginAnimation(100)
					f141_arg0:setAlpha(0)
					f141_arg0:registerEventHandler("transition_complete_keyframe", f136_arg0.clipFinished)
				end
				f136_arg0.Equipment:beginAnimation(100)
				f136_arg0.Equipment:registerEventHandler("interrupted_keyframe", f136_arg0.clipInterrupted)
				f136_arg0.Equipment:registerEventHandler("transition_complete_keyframe", f140_local0)
			end
			f136_arg0.Equipment:completeAnimation()
			f136_arg0.Equipment:setAlpha(1)
			f136_local2(f136_arg0.Equipment)
			local f136_local3 = function(f142_arg0)
				local f142_local0 = function(f143_arg0)
					local f143_local0 = function(f144_arg0)
						f144_arg0:beginAnimation(399)
						f144_arg0:setAlpha(0.5)
						f144_arg0:registerEventHandler("transition_complete_keyframe", f136_arg0.clipFinished)
					end
					f143_arg0:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_out"])
					f143_arg0:setAlpha(1)
					f143_arg0:registerEventHandler("transition_complete_keyframe", f143_local0)
				end
				f136_arg0.HackingFinished:beginAnimation(100)
				f136_arg0.HackingFinished:registerEventHandler("interrupted_keyframe", f136_arg0.clipInterrupted)
				f136_arg0.HackingFinished:registerEventHandler("transition_complete_keyframe", f142_local0)
			end
			f136_arg0.HackingFinished:completeAnimation()
			f136_arg0.HackingFinished:setAlpha(0)
			f136_local3(f136_arg0.HackingFinished)
			local f136_local4 = function(f145_arg0)
				f136_arg0.JoinButtonPrompt:beginAnimation(100)
				f136_arg0.JoinButtonPrompt:setAlpha(0)
				f136_arg0.JoinButtonPrompt:registerEventHandler("interrupted_keyframe", f136_arg0.clipInterrupted)
				f136_arg0.JoinButtonPrompt:registerEventHandler("transition_complete_keyframe", f136_arg0.clipFinished)
			end
			f136_arg0.JoinButtonPrompt:completeAnimation()
			f136_arg0.JoinButtonPrompt:setAlpha(1)
			f136_local4(f136_arg0.JoinButtonPrompt)
			local f136_local5 = function(f146_arg0)
				local f146_local0 = function(f147_arg0)
					f147_arg0:beginAnimation(200)
					f147_arg0:setAlpha(0)
					f147_arg0:registerEventHandler("transition_complete_keyframe", f136_arg0.clipFinished)
				end
				f136_arg0.windowDotline:beginAnimation(100)
				f136_arg0.windowDotline:setAlpha(0.5)
				f136_arg0.windowDotline:registerEventHandler("interrupted_keyframe", f136_arg0.clipInterrupted)
				f136_arg0.windowDotline:registerEventHandler("transition_complete_keyframe", f146_local0)
			end
			f136_arg0.windowDotline:completeAnimation()
			f136_arg0.windowDotline:setAlpha(0.3)
			f136_local5(f136_arg0.windowDotline)
		end,
	},
}
CoD.TabletIcePickGadget_Internal.__onClose = function(f148_arg0)
	f148_arg0.WindowBg02:close()
	f148_arg0.binaryFUI02:close()
	f148_arg0.WindowBg01:close()
	f148_arg0.binaryFUI01:close()
	f148_arg0.binaryFUI03:close()
	f148_arg0.LineFUI02:close()
	f148_arg0.LineFUI01:close()
	f148_arg0.AnalysingBacking:close()
	f148_arg0.ProgressFui:close()
	f148_arg0.WindowMain:close()
	f148_arg0.LayoutElement02:close()
	f148_arg0.FuiR02:close()
	f148_arg0.FuiR01:close()
	f148_arg0.Players:close()
	f148_arg0.Vehicles:close()
	f148_arg0.Equipment:close()
	f148_arg0.HackDetectionBar:close()
	f148_arg0.HackingFinished:close()
	f148_arg0.JoinButtonPrompt:close()
end
