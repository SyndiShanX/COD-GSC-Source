require("x64:eda152e1d10147a")
require("x64:436f2d3868d3737")
require("x64:c8e36d66138f434")
require("x64:38c11a77e96e48c")
require("x64:7889ce1e3e2e8a")
CoD.Prestige_CustomizeIcon = InheritFrom(CoD.Menu)
LUI.createMenu.Prestige_CustomizeIcon = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("Prestige_CustomizeIcon", f1_arg0)
	local f1_local1 = self
	self:setClass(CoD.Prestige_CustomizeIcon)
	self.soundSet = "none"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	local Background = CoD.StartMenuOptionsBackground.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(Background)
	self.Background = Background
	local BlackBacking = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	BlackBacking:setRGB(0, 0, 0)
	BlackBacking:setAlpha(0.2)
	self:addElement(BlackBacking)
	self.BlackBacking = BlackBacking
	local TiledPlusGrid = LUI.UIImage.new(0.5, 0.5, -1095, 960, 0.5, 0.5, -540, 540)
	TiledPlusGrid:setAlpha(0.05)
	TiledPlusGrid:setImage(RegisterImage(0x6E37BAE22631294))
	TiledPlusGrid:setMaterial(LUI.UIImage.GetCachedMaterial(0x7C9C02F608D0A75))
	TiledPlusGrid:setShaderVector(0, 0, 0, 0, 0)
	TiledPlusGrid:setupNineSliceShader(220, 220)
	self:addElement(TiledPlusGrid)
	self.TiledPlusGrid = TiledPlusGrid
	local GenericMenuFrame = CoD.GenericMenuFrame.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	GenericMenuFrame.CommonHeader.subtitle.StageTitle:setText(LocalizeToUpperString(CoD.CustomizePrestigeIconUtility.GetCustomizePrestigeIconMenuTitleString(0x754A8D073F00C06)))
	GenericMenuFrame.CommonHeader.subtitle.subtitle:setText("")
	self:addElement(GenericMenuFrame)
	self.GenericMenuFrame = GenericMenuFrame
	local Details = CoD.CustomizeIconDetails.new(f1_local1, f1_arg0, 0.5, 0.5, 217, 617, 0.5, 0.5, -322, 322)
	Details:mergeStateConditions({
		{
			stateName = "LockedVictoryCoin",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg0, "isLockedByWins") and CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg0, "isLocked")
			end,
		},
		{
			stateName = "Locked",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg0, "isLocked")
			end,
		},
	})
	Details:linkToElementModel(Details, "isLockedByWins", true, function(model)
		f1_local1:updateElementState(Details, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = model:get(),
			modelName = "isLockedByWins",
		})
	end)
	Details:linkToElementModel(Details, "isLocked", true, function(model)
		f1_local1:updateElementState(Details, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = model:get(),
			modelName = "isLocked",
		})
	end)
	self:addElement(Details)
	self.Details = Details
	local IconList = LUI.UIList.new(f1_local1, f1_arg0, 20, 0, nil, true, false, false, false)
	IconList:setLeftRight(0.5, 0.5, -622, 130)
	IconList:setTopBottom(0.5, 0.5, -322, 322)
	IconList:setWidgetType(CoD.CustomizeIconGridItem)
	IconList:setHorizontalCount(4)
	IconList:setVerticalCount(4)
	IconList:setSpacing(20)
	IconList:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	IconList:setVerticalCounter(CoD.verticalCounter)
	IconList:setDataSource("PrestigeIcon")
	IconList:registerEventHandler("gain_focus", function(element, event)
		local f6_local0 = nil
		if element.gainFocus then
			f6_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f6_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f6_local0
	end)
	f1_local1:AddButtonCallbackFunction(IconList, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], nil, function(element, menu, controller, model)
		CoD.CustomizePrestigeIconUtility.PrestigeIconSelected(menu, element, controller)
		UpdateElementDataSource(self, "IconList")
		CoD.PrestigeUtility.ClearHasPrestigedStatus(self, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, nil)
		return true
	end, false)
	self:addElement(IconList)
	self.IconList = IconList
	Details:linkToElementModel(IconList, nil, false, function(model)
		Details:setModel(model, f1_arg0)
	end)
	self:registerEventHandler("list_item_gain_focus", function(self, event)
		local f10_local0 = nil
		UpdateElementState(self, "Details", f1_arg0)
		return f10_local0
	end)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], nil, function(element, menu, controller, model)
		GoBack(self, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], 0x70A9FDC87CD3D48, nil, nil)
		return true
	end, false)
	if CoD.isPC then
		GenericMenuFrame.id = "GenericMenuFrame"
	end
	IconList.id = "IconList"
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	return self
end
CoD.Prestige_CustomizeIcon.__onClose = function(f13_arg0)
	f13_arg0.Details:close()
	f13_arg0.Background:close()
	f13_arg0.GenericMenuFrame:close()
	f13_arg0.IconList:close()
end
