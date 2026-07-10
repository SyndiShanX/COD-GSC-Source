require("x64:4b970b419e5a3db")
require("x64:342f5d0578127d5")
require("x64:30848365bee34fe")
require("x64:6d88601770c0432")
require("x64:268b19728179583")
require("x64:3a1772776cde124")
require("x64:ae1040cb9e1ab23")
CoD.Main = InheritFrom(CoD.Menu)
LUI.createMenu.Main = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("Main", f1_arg0)
	local f1_local1 = self
	if IsPC() then
		CoD.LobbyUtility.MainPreLoad(self)
		CoD.PCWidgetUtility.ResetAllKeysColor()
		CoD.PCWidgetUtility.DefaultKeyboardPulseColor()
	else
		CoD.LobbyUtility.MainPreLoad(self)
	end
	self:setClass(CoD.Main)
	self.soundSet = "FrontendMain"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	f1_local1:addElementToPendingUpdateStateList(self)
	local BGFill = nil
	BGFill = LUI.UIImage.new(-0.03, 1.02, -50, 50, 0, 1, 0, 0)
	BGFill:setRGB(0, 0, 0)
	self:addElement(BGFill)
	self.BGFill = BGFill
	local PCBnetStoreKeyart = nil
	PCBnetStoreKeyart = CoD.PC_BnetStore_Keyart.new(f1_local1, f1_arg0, 0.5, 0.5, -744, 1176, 1, 1, -1304, 1)
	self:addElement(PCBnetStoreKeyart)
	self.PCBnetStoreKeyart = PCBnetStoreKeyart
	local AspectRatioBorder = nil
	AspectRatioBorder = LUI.UIImage.new(0.5, 0.5, -2066, -197, 0, 1, 0, 0)
	AspectRatioBorder:setRGB(0, 0, 0)
	AspectRatioBorder:setMaterial(LUI.UIImage.GetCachedMaterial(0xE125638BF94665F))
	AspectRatioBorder:setShaderVector(0, 0, 0, 0.39, 0)
	self:addElement(AspectRatioBorder)
	self.AspectRatioBorder = AspectRatioBorder
	local AspectRatioBorder2 = nil
	AspectRatioBorder2 = LUI.UIImage.new(0.5, 0.5, 303, 2172, 0, 1, 0, 0)
	AspectRatioBorder2:setRGB(0, 0, 0)
	AspectRatioBorder2:setMaterial(LUI.UIImage.GetCachedMaterial(0xE125638BF94665F))
	AspectRatioBorder2:setShaderVector(0, 0.39, 0, 0, 0)
	self:addElement(AspectRatioBorder2)
	self.AspectRatioBorder2 = AspectRatioBorder2
	local f1_local6 = nil
	self.FullScreenBlack = LUI.UIElement.createFake()
	local StartLabel = CoD.StartLabel.new(f1_local1, f1_arg0, 0, 0, 0, 1920, 0, 0, 0, 1080)
	StartLabel:setZoom(20)
	StartLabel:registerEventHandler("menu_loaded", function(element, event)
		local f2_local0 = nil
		if element.menuLoaded then
			f2_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f2_local0 = element.super:menuLoaded(event)
		end
		SizeToSafeArea(element, f1_arg0)
		if not f2_local0 then
			f2_local0 = element:dispatchEventToChildren(event)
		end
		return f2_local0
	end)
	StartLabel:registerEventHandler("gain_focus", function(element, event)
		local f3_local0 = nil
		if element.gainFocus then
			f3_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f3_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0xA86639565BE5841])
		return f3_local0
	end)
	f1_local1:AddButtonCallbackFunction(StartLabel, f1_arg0, Enum[0x3DD78803F918E9D][0xA86639565BE5841], nil, function(element, menu, controller, model)
		SendButtonPressToMenu(menu, controller, model, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0xA86639565BE5841], 0x0, nil, nil)
		return false
	end, false)
	self:addElement(StartLabel)
	self.StartLabel = StartLabel
	local ConnectionLabel = CoD.ConnectionLabel.new(f1_local1, f1_arg0, 0.5, 0.5, -960, 960, 0.5, 0.5, -540, 540)
	ConnectionLabel:setAlpha(0)
	ConnectionLabel:setZoom(20)
	self:addElement(ConnectionLabel)
	self.ConnectionLabel = ConnectionLabel
	local feFooterContainer = CoD.fe_FooterContainerMain.new(f1_local1, f1_arg0, 0, 1, 0, 0, 1, 1, -153, -33)
	feFooterContainer:registerEventHandler("menu_loaded", function(element, event)
		local f6_local0 = nil
		if element.menuLoaded then
			f6_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f6_local0 = element.super:menuLoaded(event)
		end
		SizeToSafeArea(element, f1_arg0)
		if not f6_local0 then
			f6_local0 = element:dispatchEventToChildren(event)
		end
		return f6_local0
	end)
	self:addElement(feFooterContainer)
	self.feFooterContainer = feFooterContainer
	local AtviCopyDurango = CoD.AtviCopy.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	AtviCopyDurango:registerEventHandler("menu_loaded", function(element, event)
		local f7_local0 = nil
		if element.menuLoaded then
			f7_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f7_local0 = element.super:menuLoaded(event)
		end
		SizeToSafeArea(element, f1_arg0)
		if not f7_local0 then
			f7_local0 = element:dispatchEventToChildren(event)
		end
		return f7_local0
	end)
	self:addElement(AtviCopyDurango)
	self.AtviCopyDurango = AtviCopyDurango
	local DirectorQuitButtonContainer = nil
	DirectorQuitButtonContainer = CoD.DirectorQuitButtonContainer.new(f1_local1, f1_arg0, 0.5, 0.5, 655, 855, 0, 0, 125, 161)
	self:addElement(DirectorQuitButtonContainer)
	self.DirectorQuitButtonContainer = DirectorQuitButtonContainer
	local PCConnectionQueuingOverlayContainer = nil
	PCConnectionQueuingOverlayContainer = CoD.PC_ConnectionQueuingOverlayContainer.new(f1_local1, f1_arg0, 0.5, 0.5, -960, 960, 0.5, 0.5, -540, 540)
	PCConnectionQueuingOverlayContainer:subscribeToGlobalModel(f1_arg0, "PCConnectionQueue", nil, function(model)
		PCConnectionQueuingOverlayContainer:setModel(model, f1_arg0)
	end)
	self:addElement(PCConnectionQueuingOverlayContainer)
	self.PCConnectionQueuingOverlayContainer = PCConnectionQueuingOverlayContainer
	self:mergeStateConditions({
		{
			stateName = "Durango",
			condition = function(menu, element, event)
				return IsDurango()
			end,
		},
		{
			stateName = "PC",
			condition = function(menu, element, event)
				return IsPC()
			end,
		},
	})
	self:registerEventHandler("menu_loaded", function(self, event)
		local f11_local0 = nil
		if self.menuLoaded then
			f11_local0 = self:menuLoaded(event)
		elseif self.super.menuLoaded then
			f11_local0 = self.super:menuLoaded(event)
		end
		CoD.LobbyUtility.SetInitLobbyMenu(self, f1_arg0)
		MenuHidesFreeCursor(f1_local1, f1_arg0)
		if not f11_local0 then
			f11_local0 = self:dispatchEventToChildren(event)
		end
		return f11_local0
	end)
	self:registerEventHandler("occlusion_change", function(self, event)
		local f12_local0 = nil
		if self.OcclusionChange then
			f12_local0 = self:OcclusionChange(event)
		elseif self.super.OcclusionChange then
			f12_local0 = self.super:OcclusionChange(event)
		end
		if IsEventPropertyEqualTo(event, "occluded", true) then
			MenuUnhideFreeCursor(f1_local1, f1_arg0)
		else
			MenuHidesFreeCursor(f1_local1, f1_arg0)
		end
		if not f12_local0 then
			f12_local0 = self:dispatchEventToChildren(event)
		end
		return f12_local0
	end)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[0x3DD78803F918E9D][0x93AB4C84F113EE1], nil, function(element, menu, controller, model)
		if IsDurango() then
			ShowAccountPicker(controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsDurango() then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x93AB4C84F113EE1], 0x0, nil, nil)
			return false
		else
			return false
		end
	end, false)
	self.__on_menuOpened_self = function(f15_arg0, f15_arg1, f15_arg2, f15_arg3)
		local f15_local0 = self
		CoD.DirectorUtility.TryOpenFreshRestartPopup(f15_arg2, f15_arg1)
	end
	f1_local1:addMenuOpenedCallback(self.__on_menuOpened_self)
	feFooterContainer:setModel(self.buttonModel, f1_arg0)
	feFooterContainer.id = "feFooterContainer"
	if CoD.isPC then
		DirectorQuitButtonContainer.id = "DirectorQuitButtonContainer"
	end
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	self.__on_close_removeOverrides = function()
		f1_local1:removeMenuOpenedCallback(self.__on_menuOpened_self)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	local f1_local13 = self
	CoD.LobbyUtility.MainPostLoad(self, f1_arg0)
	return self
end
CoD.Main.__resetProperties = function(f17_arg0)
	f17_arg0.StartLabel:completeAnimation()
	f17_arg0.feFooterContainer:completeAnimation()
	f17_arg0.AtviCopyDurango:completeAnimation()
	f17_arg0.ConnectionLabel:completeAnimation()
	f17_arg0.StartLabel:setAlpha(1)
	f17_arg0.feFooterContainer:setAlpha(1)
	f17_arg0.AtviCopyDurango:setLeftRight(0, 1, 0, 0)
	f17_arg0.AtviCopyDurango:setTopBottom(0, 1, 0, 0)
	f17_arg0.AtviCopyDurango:setAlpha(1)
	f17_arg0.ConnectionLabel:setAlpha(0)
end
CoD.Main.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(3)
			local f18_local0 = function(f19_arg0)
				local f19_local0 = function(f20_arg0)
					f20_arg0:beginAnimation(520)
					f20_arg0:setAlpha(1)
					f20_arg0:registerEventHandler("transition_complete_keyframe", f18_arg0.clipFinished)
				end
				f18_arg0.StartLabel:beginAnimation(1500)
				f18_arg0.StartLabel:registerEventHandler("interrupted_keyframe", f18_arg0.clipInterrupted)
				f18_arg0.StartLabel:registerEventHandler("transition_complete_keyframe", f19_local0)
			end
			f18_arg0.StartLabel:completeAnimation()
			f18_arg0.StartLabel:setAlpha(0)
			f18_local0(f18_arg0.StartLabel)
			f18_arg0.feFooterContainer:completeAnimation()
			f18_arg0.feFooterContainer:setAlpha(0)
			f18_arg0.clipFinished(f18_arg0.feFooterContainer)
			local f18_local1 = function(f21_arg0)
				f18_arg0.AtviCopyDurango:beginAnimation(2820)
				f18_arg0.AtviCopyDurango:registerEventHandler("interrupted_keyframe", f18_arg0.clipInterrupted)
				f18_arg0.AtviCopyDurango:registerEventHandler("transition_complete_keyframe", f18_arg0.clipFinished)
			end
			f18_arg0.AtviCopyDurango:completeAnimation()
			f18_arg0.AtviCopyDurango:setLeftRight(0, 1, 0, 0)
			f18_arg0.AtviCopyDurango:setTopBottom(0, 1, 0, 0)
			f18_arg0.AtviCopyDurango:setAlpha(0)
			f18_local1(f18_arg0.AtviCopyDurango)
		end,
	},
	Durango = {
		DefaultClip = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(2)
			f22_arg0.StartLabel:completeAnimation()
			f22_arg0.StartLabel:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.StartLabel)
			local f22_local0 = function(f23_arg0)
				f22_arg0.AtviCopyDurango:beginAnimation(1500)
				f22_arg0.AtviCopyDurango:registerEventHandler("interrupted_keyframe", f22_arg0.clipInterrupted)
				f22_arg0.AtviCopyDurango:registerEventHandler("transition_complete_keyframe", f22_arg0.clipFinished)
			end
			f22_arg0.AtviCopyDurango:completeAnimation()
			f22_arg0.AtviCopyDurango:setAlpha(1)
			f22_local0(f22_arg0.AtviCopyDurango)
		end,
	},
	PC = {
		DefaultClip = function(f24_arg0, f24_arg1)
			f24_arg0:__resetProperties()
			f24_arg0:setupElementClipCounter(4)
			f24_arg0.StartLabel:completeAnimation()
			f24_arg0.StartLabel:setAlpha(0)
			f24_arg0.clipFinished(f24_arg0.StartLabel)
			local f24_local0 = function(f25_arg0)
				f24_arg0.ConnectionLabel:beginAnimation(1000)
				f24_arg0.ConnectionLabel:setAlpha(1)
				f24_arg0.ConnectionLabel:registerEventHandler("interrupted_keyframe", f24_arg0.clipInterrupted)
				f24_arg0.ConnectionLabel:registerEventHandler("transition_complete_keyframe", f24_arg0.clipFinished)
			end
			f24_arg0.ConnectionLabel:completeAnimation()
			f24_arg0.ConnectionLabel:setAlpha(0)
			f24_local0(f24_arg0.ConnectionLabel)
			f24_arg0.feFooterContainer:completeAnimation()
			f24_arg0.feFooterContainer:setAlpha(0)
			f24_arg0.clipFinished(f24_arg0.feFooterContainer)
			local f24_local1 = function(f26_arg0)
				local f26_local0 = function(f27_arg0)
					f27_arg0:beginAnimation(1099)
					f27_arg0:registerEventHandler("transition_complete_keyframe", f24_arg0.clipFinished)
				end
				f24_arg0.AtviCopyDurango:beginAnimation(1720)
				f24_arg0.AtviCopyDurango:registerEventHandler("interrupted_keyframe", f24_arg0.clipInterrupted)
				f24_arg0.AtviCopyDurango:registerEventHandler("transition_complete_keyframe", f26_local0)
			end
			f24_arg0.AtviCopyDurango:completeAnimation()
			f24_arg0.AtviCopyDurango:setLeftRight(0, 1, 0, 0)
			f24_arg0.AtviCopyDurango:setTopBottom(0, 1, 0, 0)
			f24_arg0.AtviCopyDurango:setAlpha(0)
			f24_local1(f24_arg0.AtviCopyDurango)
		end,
	},
}
CoD.Main.__onClose = function(f28_arg0)
	f28_arg0.__on_close_removeOverrides()
	f28_arg0.PCBnetStoreKeyart:close()
	f28_arg0.FullScreenBlack:close()
	f28_arg0.StartLabel:close()
	f28_arg0.ConnectionLabel:close()
	f28_arg0.feFooterContainer:close()
	f28_arg0.AtviCopyDurango:close()
	f28_arg0.DirectorQuitButtonContainer:close()
	f28_arg0.PCConnectionQueuingOverlayContainer:close()
end
