require("x64:eda152e1d10147a")
require("x64:7646e77429ecfc2")
require("x64:131d34d6abd22fe")
require("x64:54a41db003228cc")
require("x64:3e7363f43bb91")
require("x64:38c11a77e96e48c")
CoD.Paintshop = InheritFrom(CoD.Menu)
LUI.createMenu.Paintshop = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("Paintshop", f1_arg0)
	local f1_local1 = self
	CoD.CraftUtility.PaintshopPreLoad(self, f1_arg0)
	SendClientScriptMenuChangeNotify(f1_arg0, f1_local1, true)
	CoD.BaseUtility.SetPropertiesFromUserData(self, f1_arg1)
	self:setClass(CoD.Paintshop)
	self.soundSet = "Paintshop"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	f1_local1:addElementToPendingUpdateStateList(self)
	local BlackTransition = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	BlackTransition:setRGB(0, 0, 0)
	BlackTransition:setAlpha(0)
	self:addElement(BlackTransition)
	self.BlackTransition = BlackTransition
	local TitleDotsWidget0 = CoD.TitleDotsWidget.new(f1_local1, f1_arg0, 0.5, 0.5, -955, -167, 0.5, 0.5, -637.5, -400.5)
	TitleDotsWidget0:setAlpha(0)
	self:addElement(TitleDotsWidget0)
	self.TitleDotsWidget0 = TitleDotsWidget0
	local LeftPanel = CoD.FE_ButtonPanelShaderContainer.new(f1_local1, f1_arg0, 0.5, 0.5, -864, -408, 0.5, 0.5, -403, 537)
	LeftPanel:setRGB(0.5, 0.5, 0.5)
	self:addElement(LeftPanel)
	self.LeftPanel = LeftPanel
	local paintjobSelector = CoD.PaintjobSelector.new(f1_local1, f1_arg0, 0.5, 0.5, -960, 960, 0.5, 0.5, -540, 540)
	paintjobSelector:registerEventHandler("gain_focus", function(element, event)
		local f2_local0 = nil
		if element.gainFocus then
			f2_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f2_local0 = element.super:gainFocus(event)
		end
		UpdateElementState(self, "slotsFull", f1_arg0)
		return f2_local0
	end)
	paintjobSelector:registerEventHandler("menu_loaded", function(element, event)
		local f3_local0 = nil
		if element.menuLoaded then
			f3_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f3_local0 = element.super:menuLoaded(event)
		end
		if not IsPC() then
			SizeToSafeArea(element, f1_arg0)
		end
		if not f3_local0 then
			f3_local0 = element:dispatchEventToChildren(event)
		end
		return f3_local0
	end)
	self:addElement(paintjobSelector)
	self.paintjobSelector = paintjobSelector
	local MenuFrame = CoD.GenericMenuFrame.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	MenuFrame.CommonHeader.subtitle.StageTitle:setText(LocalizeToUpperString(0xD5133E81D776975))
	MenuFrame:subscribeToGlobalModel(f1_arg0, "LobbyRoot", "lobbyTitle", function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			MenuFrame.CommonHeader.subtitle.subtitle:setText(Engine[0xF9F1239CFD921FE](f4_local0))
		end
	end)
	self:addElement(MenuFrame)
	self.MenuFrame = MenuFrame
	local slotsFull = CoD.PaintshopSlotsFull.new(f1_local1, f1_arg0, 0.5, 0.5, -286, -109, 0.5, 0.5, 351, 432)
	slotsFull:mergeStateConditions({
		{
			stateName = "SlotsFull",
			condition = function(menu, element, event)
				return CraftSlotsFullByStorageType(f1_arg0, Enum[0xBBD4F9E70101BA8][0x743B8404C246F61])
			end,
		},
	})
	slotsFull:setAlpha(0)
	slotsFull:subscribeToGlobalModel(f1_arg0, "PerController", "Paintshop.UpdateDataSource", function(model)
		UpdateSelfElementState(f1_local1, slotsFull, f1_arg0)
	end)
	self:addElement(slotsFull)
	self.slotsFull = slotsFull
	local categoryName = LUI.UIText.new(0.5, 0.5, -378, 7, 0.5, 0.5, -368, -340)
	categoryName:setRGB(0.97, 0.32, 0.05)
	categoryName:setAlpha(0)
	categoryName:setText(LocalizeToUpperString(0x7E4B041D9216644))
	categoryName:setTTF("dinnext_regular")
	categoryName:setLetterSpacing(1)
	categoryName:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	categoryName:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(categoryName)
	self.categoryName = categoryName
	local weaponVerticalCounter = CoD.verticalCounter.new(f1_local1, f1_arg0, 0.5, 0.5, -787, -487, 0.5, 0.5, 399, 437)
	weaponVerticalCounter:setAlpha(0)
	weaponVerticalCounter:registerEventHandler("menu_loaded", function(element, event)
		local f7_local0 = nil
		if element.menuLoaded then
			f7_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f7_local0 = element.super:menuLoaded(event)
		end
		SetAsListVerticalCounter(self, element, "weaponList")
		if not f7_local0 then
			f7_local0 = element:dispatchEventToChildren(event)
		end
		return f7_local0
	end)
	self:addElement(weaponVerticalCounter)
	self.weaponVerticalCounter = weaponVerticalCounter
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], nil, function(element, menu, controller, model)
		GoBack(self, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], 0x70A9FDC87CD3D48, nil, nil)
		return true
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[0x3DD78803F918E9D][0x22361E23588705A], nil, function(element, menu, controller, model)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x22361E23588705A], 0x0, nil, nil)
		return false
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(self, "close", function(element)
		PaintshopWeaponList_Back(self, element, f1_arg0)
		ClearMenuSavedState(f1_local1)
		SendClientScriptMenuChangeNotify(f1_arg0, f1_local1, false)
	end)
	paintjobSelector.id = "paintjobSelector"
	MenuFrame:setModel(self.buttonModel, f1_arg0)
	if CoD.isPC then
		MenuFrame.id = "MenuFrame"
	end
	weaponVerticalCounter.id = "weaponVerticalCounter"
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	self.__defaultFocus = paintjobSelector
	if CoD.isPC and (IsKeyboard(f1_arg0) or self.ignoreCursor) then
		self:restoreState(f1_arg0)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	local f1_local10 = self
	CoD.OverlayUtility.DisableBlur(self)
	CoD.OverlayUtility.DisablePopupOpenCloseAnim(self)
	return self
end
CoD.Paintshop.__resetProperties = function(f13_arg0)
	f13_arg0.LeftPanel:completeAnimation()
	f13_arg0.BlackTransition:completeAnimation()
	f13_arg0.LeftPanel:setLeftRight(0.5, 0.5, -864, -408)
	f13_arg0.LeftPanel:setTopBottom(0.5, 0.5, -403, 537)
	f13_arg0.BlackTransition:setAlpha(0)
end
CoD.Paintshop.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(1)
			f14_arg0.LeftPanel:completeAnimation()
			f14_arg0.LeftPanel:setLeftRight(0.5, 0.5, 96, 552)
			f14_arg0.LeftPanel:setTopBottom(0.5, 0.5, 136, 1020)
			f14_arg0.clipFinished(f14_arg0.LeftPanel)
		end,
		Intro = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(1)
			local f15_local0 = function(f16_arg0)
				local f16_local0 = function(f17_arg0)
					f17_arg0:beginAnimation(300)
					f17_arg0:setAlpha(0)
					f17_arg0:registerEventHandler("transition_complete_keyframe", f15_arg0.clipFinished)
				end
				f15_arg0.BlackTransition:beginAnimation(200)
				f15_arg0.BlackTransition:registerEventHandler("interrupted_keyframe", f15_arg0.clipInterrupted)
				f15_arg0.BlackTransition:registerEventHandler("transition_complete_keyframe", f16_local0)
			end
			f15_arg0.BlackTransition:completeAnimation()
			f15_arg0.BlackTransition:setAlpha(1)
			f15_local0(f15_arg0.BlackTransition)
		end,
	},
}
CoD.Paintshop.__onClose = function(f18_arg0)
	f18_arg0.TitleDotsWidget0:close()
	f18_arg0.LeftPanel:close()
	f18_arg0.paintjobSelector:close()
	f18_arg0.MenuFrame:close()
	f18_arg0.slotsFull:close()
	f18_arg0.weaponVerticalCounter:close()
end
