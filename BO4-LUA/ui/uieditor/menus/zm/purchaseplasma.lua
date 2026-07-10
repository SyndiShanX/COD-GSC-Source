require("x64:413987f664adb29")
require("x64:8989b94e9945f9a")
require("x64:ba72b08fda6493")
require("x64:c829ac7d797ba4c")
CoD.PurchasePlasma = InheritFrom(CoD.Menu)
LUI.createMenu.PurchasePlasma = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("PurchasePlasma", f1_arg0)
	local f1_local1 = self
	self:setClass(CoD.PurchasePlasma)
	self.soundSet = "default"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	f1_local1:addElementToPendingUpdateStateList(self)
	local Blackfade = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Blackfade:setRGB(0, 0, 0)
	Blackfade:setAlpha(0.35)
	self:addElement(Blackfade)
	self.Blackfade = Blackfade
	local plasmaContainer = CoD.LaboratoryPlasma_PopoutContainer.new(f1_local1, f1_arg0, 0, 0, 1920, 2720, 0, 1, 0, 0)
	self:addElement(plasmaContainer)
	self.plasmaContainer = plasmaContainer
	local fefooterRighSlideIn = CoD.fe_footerRighSlideIn.new(f1_local1, f1_arg0, 1, 1, -670, -22, 1, 1, -48, 0)
	fefooterRighSlideIn:registerEventHandler("menu_loaded", function(element, event)
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
	self:addElement(fefooterRighSlideIn)
	self.fefooterRighSlideIn = fefooterRighSlideIn
	local featureOverlayButtonMouseOnly = nil
	featureOverlayButtonMouseOnly = CoD.featureOverlay_Button_MouseOnly.new(f1_local1, f1_arg0, 0.5, 0.5, 1035, 1161, 0.5, 0.5, 418, 475)
	featureOverlayButtonMouseOnly.featureOverlayButtonContainer.Title:setText(Engine[0xF9F1239CFD921FE](0x78D439E1B360368))
	featureOverlayButtonMouseOnly:registerEventHandler("gain_focus", function(element, event)
		local f3_local0 = nil
		if element.gainFocus then
			f3_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f3_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f3_local0
	end)
	f1_local1:AddButtonCallbackFunction(featureOverlayButtonMouseOnly, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], "ui_confirm", function(element, menu, controller, model)
		PlaySoundSetSound(self, "menu_no_selection")
		PlayClip(self, "Close", controller)
		DelayGoBack(menu, controller, 300)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x0, nil, "ui_confirm")
		return false
	end, false)
	self:addElement(featureOverlayButtonMouseOnly)
	self.featureOverlayButtonMouseOnly = featureOverlayButtonMouseOnly
	local PCSmallCloseButton = nil
	PCSmallCloseButton = CoD.PC_SmallCloseButton.new(f1_local1, f1_arg0, 0.5, 0.5, 1717, 1751, 0.5, 0.5, -531, -497)
	PCSmallCloseButton:registerEventHandler("gain_focus", function(element, event)
		local f6_local0 = nil
		if element.gainFocus then
			f6_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f6_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8])
		return f6_local0
	end)
	f1_local1:AddButtonCallbackFunction(PCSmallCloseButton, f1_arg0, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], "MOUSE1", function(element, menu, controller, model)
		PlayClip(self, "Close", controller)
		DelayGoBack(menu, controller, 300)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], 0x0, nil, "MOUSE1")
		return false
	end, false)
	f1_local1:AddButtonCallbackFunction(PCSmallCloseButton, f1_arg0, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], "ui_confirm", function(element, menu, controller, model)
		PlayClip(self, "Close", controller)
		DelayGoBack(menu, controller, 300)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], 0x0, nil, "ui_confirm")
		return false
	end, false)
	self:addElement(PCSmallCloseButton)
	self.PCSmallCloseButton = PCSmallCloseButton
	self:mergeStateConditions({
		{
			stateName = "DefaultState_PC",
			condition = function(menu, element, event)
				return IsPC()
			end,
		},
	})
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], nil, function(element, menu, controller, model)
		PlayClip(self, "Close", controller)
		DelayGoBack(menu, controller, 300)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], 0x70A9FDC87CD3D48, nil, nil)
		return true
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(self, "close", function(element)
		ClearMenuSavedState(f1_local1)
	end)
	plasmaContainer.id = "plasmaContainer"
	fefooterRighSlideIn.buttons:setModel(self.buttonModel, f1_arg0)
	if CoD.isPC then
		fefooterRighSlideIn.id = "fefooterRighSlideIn"
	end
	if CoD.isPC then
		featureOverlayButtonMouseOnly.id = "featureOverlayButtonMouseOnly"
	end
	if CoD.isPC then
		PCSmallCloseButton.id = "PCSmallCloseButton"
	end
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	self.__defaultFocus = plasmaContainer
	if CoD.isPC and (IsKeyboard(f1_arg0) or self.ignoreCursor) then
		self:restoreState(f1_arg0)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	local f1_local7 = self
	CoD.BaseUtility.SetModelFromUserData(f1_arg0, self.plasmaContainer, f1_arg1)
	return self
end
CoD.PurchasePlasma.__resetProperties = function(f15_arg0)
	f15_arg0.plasmaContainer:completeAnimation()
	f15_arg0.fefooterRighSlideIn:completeAnimation()
	f15_arg0.Blackfade:completeAnimation()
	f15_arg0.featureOverlayButtonMouseOnly:completeAnimation()
	f15_arg0.PCSmallCloseButton:completeAnimation()
	f15_arg0.plasmaContainer:setLeftRight(0, 0, 1920, 2720)
	f15_arg0.plasmaContainer:setTopBottom(0, 1, 0, 0)
	f15_arg0.plasmaContainer:setAlpha(1)
	f15_arg0.fefooterRighSlideIn:setLeftRight(1, 1, -670, -22)
	f15_arg0.fefooterRighSlideIn:setTopBottom(1, 1, -48, 0)
	f15_arg0.fefooterRighSlideIn:setAlpha(1)
	f15_arg0.Blackfade:setAlpha(0.35)
	f15_arg0.featureOverlayButtonMouseOnly:setLeftRight(0.5, 0.5, 1035, 1161)
	f15_arg0.featureOverlayButtonMouseOnly:setTopBottom(0.5, 0.5, 418, 475)
	f15_arg0.featureOverlayButtonMouseOnly:setAlpha(1)
	f15_arg0.PCSmallCloseButton:setLeftRight(0.5, 0.5, 1717, 1751)
	f15_arg0.PCSmallCloseButton:setTopBottom(0.5, 0.5, -531, -497)
end
CoD.PurchasePlasma.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(2)
			f16_arg0.plasmaContainer:completeAnimation()
			f16_arg0.plasmaContainer:setLeftRight(0, 0, 1120, 1920)
			f16_arg0.plasmaContainer:setTopBottom(0, 0, 0, 1080)
			f16_arg0.clipFinished(f16_arg0.plasmaContainer)
			f16_arg0.fefooterRighSlideIn:completeAnimation()
			f16_arg0.fefooterRighSlideIn:setLeftRight(1, 1, -670, -22)
			f16_arg0.fefooterRighSlideIn:setTopBottom(1, 1, -48, 0)
			f16_arg0.clipFinished(f16_arg0.fefooterRighSlideIn)
		end,
		Intro = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(3)
			local f17_local0 = function(f18_arg0)
				f17_arg0.Blackfade:beginAnimation(300)
				f17_arg0.Blackfade:setAlpha(0.35)
				f17_arg0.Blackfade:registerEventHandler("interrupted_keyframe", f17_arg0.clipInterrupted)
				f17_arg0.Blackfade:registerEventHandler("transition_complete_keyframe", f17_arg0.clipFinished)
			end
			f17_arg0.Blackfade:completeAnimation()
			f17_arg0.Blackfade:setAlpha(0)
			f17_local0(f17_arg0.Blackfade)
			local f17_local1 = function(f19_arg0)
				f17_arg0.plasmaContainer:beginAnimation(300)
				f17_arg0.plasmaContainer:setLeftRight(0, 0, 1120, 1920)
				f17_arg0.plasmaContainer:registerEventHandler("interrupted_keyframe", f17_arg0.clipInterrupted)
				f17_arg0.plasmaContainer:registerEventHandler("transition_complete_keyframe", f17_arg0.clipFinished)
			end
			f17_arg0.plasmaContainer:completeAnimation()
			f17_arg0.plasmaContainer:setLeftRight(0, 0, 1920, 2720)
			f17_arg0.plasmaContainer:setTopBottom(0, 0, 0, 1080)
			f17_local1(f17_arg0.plasmaContainer)
			local f17_local2 = function(f20_arg0)
				f17_arg0.fefooterRighSlideIn:beginAnimation(300)
				f17_arg0.fefooterRighSlideIn:setLeftRight(1, 1, -670, -22)
				f17_arg0.fefooterRighSlideIn:registerEventHandler("interrupted_keyframe", f17_arg0.clipInterrupted)
				f17_arg0.fefooterRighSlideIn:registerEventHandler("transition_complete_keyframe", f17_arg0.clipFinished)
			end
			f17_arg0.fefooterRighSlideIn:completeAnimation()
			f17_arg0.fefooterRighSlideIn:setLeftRight(1, 1, 130, 778)
			f17_local2(f17_arg0.fefooterRighSlideIn)
		end,
		Close = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(3)
			local f21_local0 = function(f22_arg0)
				f21_arg0.Blackfade:beginAnimation(300)
				f21_arg0.Blackfade:setAlpha(0)
				f21_arg0.Blackfade:registerEventHandler("interrupted_keyframe", f21_arg0.clipInterrupted)
				f21_arg0.Blackfade:registerEventHandler("transition_complete_keyframe", f21_arg0.clipFinished)
			end
			f21_arg0.Blackfade:completeAnimation()
			f21_arg0.Blackfade:setAlpha(0.35)
			f21_local0(f21_arg0.Blackfade)
			local f21_local1 = function(f23_arg0)
				f21_arg0.plasmaContainer:beginAnimation(300)
				f21_arg0.plasmaContainer:setLeftRight(0, 0, 1920, 2720)
				f21_arg0.plasmaContainer:registerEventHandler("interrupted_keyframe", f21_arg0.clipInterrupted)
				f21_arg0.plasmaContainer:registerEventHandler("transition_complete_keyframe", f21_arg0.clipFinished)
			end
			f21_arg0.plasmaContainer:completeAnimation()
			f21_arg0.plasmaContainer:setLeftRight(0, 0, 1120, 1920)
			f21_arg0.plasmaContainer:setTopBottom(0, 0, 0, 1080)
			f21_local1(f21_arg0.plasmaContainer)
			local f21_local2 = function(f24_arg0)
				f21_arg0.fefooterRighSlideIn:beginAnimation(300)
				f21_arg0.fefooterRighSlideIn:setLeftRight(1, 1, 130, 778)
				f21_arg0.fefooterRighSlideIn:registerEventHandler("interrupted_keyframe", f21_arg0.clipInterrupted)
				f21_arg0.fefooterRighSlideIn:registerEventHandler("transition_complete_keyframe", f21_arg0.clipFinished)
			end
			f21_arg0.fefooterRighSlideIn:completeAnimation()
			f21_arg0.fefooterRighSlideIn:setLeftRight(1, 1, -670, -22)
			f21_local2(f21_arg0.fefooterRighSlideIn)
		end,
	},
	DefaultState_PC = {
		DefaultClip = function(f25_arg0, f25_arg1)
			f25_arg0:__resetProperties()
			f25_arg0:setupElementClipCounter(4)
			f25_arg0.plasmaContainer:completeAnimation()
			f25_arg0.plasmaContainer:setLeftRight(0.5, 0.5, -400, 400)
			f25_arg0.clipFinished(f25_arg0.plasmaContainer)
			f25_arg0.fefooterRighSlideIn:completeAnimation()
			f25_arg0.fefooterRighSlideIn:setLeftRight(0.5, 0.5, -324, 324)
			f25_arg0.fefooterRighSlideIn:setTopBottom(1, 1, -48, 0)
			f25_arg0.clipFinished(f25_arg0.fefooterRighSlideIn)
			f25_arg0.featureOverlayButtonMouseOnly:completeAnimation()
			f25_arg0.featureOverlayButtonMouseOnly:setLeftRight(0.5, 0.5, -323, -197)
			f25_arg0.clipFinished(f25_arg0.featureOverlayButtonMouseOnly)
			f25_arg0.PCSmallCloseButton:completeAnimation()
			f25_arg0.PCSmallCloseButton:setLeftRight(0.5, 0.5, 357, 391)
			f25_arg0.PCSmallCloseButton:setTopBottom(0.5, 0.5, -531, -497)
			f25_arg0.clipFinished(f25_arg0.PCSmallCloseButton)
		end,
		Intro = function(f26_arg0, f26_arg1)
			f26_arg0:__resetProperties()
			f26_arg0:setupElementClipCounter(4)
			local f26_local0 = function(f27_arg0)
				f27_arg0:beginAnimation(120)
				f27_arg0:setAlpha(0.35)
				f27_arg0:registerEventHandler("transition_complete_keyframe", f26_arg0.clipFinished)
			end
			f26_arg0.Blackfade:beginAnimation(180)
			f26_arg0.Blackfade:setAlpha(0)
			f26_arg0.Blackfade:registerEventHandler("interrupted_keyframe", f26_arg0.clipInterrupted)
			f26_arg0.Blackfade:registerEventHandler("transition_complete_keyframe", f26_local0)
			local f26_local1 = function(f28_arg0)
				local f28_local0 = function(f29_arg0)
					local f29_local0 = function(f30_arg0)
						f30_arg0:beginAnimation(20)
						f30_arg0:setLeftRight(0.5, 0.5, -400, 400)
						f30_arg0:registerEventHandler("transition_complete_keyframe", f26_arg0.clipFinished)
					end
					f29_arg0:beginAnimation(160)
					f29_arg0:setLeftRight(0.47, 0.47, -240, 560)
					f29_arg0:setAlpha(1)
					f29_arg0:registerEventHandler("transition_complete_keyframe", f29_local0)
				end
				f26_arg0.plasmaContainer:beginAnimation(120)
				f26_arg0.plasmaContainer:setLeftRight(0.2, 0.2, 1040, 1840)
				f26_arg0.plasmaContainer:registerEventHandler("interrupted_keyframe", f26_arg0.clipInterrupted)
				f26_arg0.plasmaContainer:registerEventHandler("transition_complete_keyframe", f28_local0)
			end
			f26_arg0.plasmaContainer:completeAnimation()
			f26_arg0.plasmaContainer:setLeftRight(0, 0, 2000, 2800)
			f26_arg0.plasmaContainer:setAlpha(0)
			f26_local1(f26_arg0.plasmaContainer)
			local f26_local2 = function(f31_arg0)
				local f31_local0 = function(f32_arg0)
					local f32_local0 = function(f33_arg0)
						f33_arg0:beginAnimation(20)
						f33_arg0:setLeftRight(0.5, 0.5, -324, 324)
						f33_arg0:registerEventHandler("transition_complete_keyframe", f26_arg0.clipFinished)
					end
					f32_arg0:beginAnimation(160)
					f32_arg0:setLeftRight(0.5, 0.5, -228.13, 419.87)
					f32_arg0:setAlpha(1)
					f32_arg0:registerEventHandler("transition_complete_keyframe", f32_local0)
				end
				f26_arg0.fefooterRighSlideIn:beginAnimation(120)
				f26_arg0.fefooterRighSlideIn:setLeftRight(0.5, 0.5, 538.8, 1186.8)
				f26_arg0.fefooterRighSlideIn:registerEventHandler("interrupted_keyframe", f26_arg0.clipInterrupted)
				f26_arg0.fefooterRighSlideIn:registerEventHandler("transition_complete_keyframe", f31_local0)
			end
			f26_arg0.fefooterRighSlideIn:completeAnimation()
			f26_arg0.fefooterRighSlideIn:setLeftRight(0.5, 0.5, 1114, 1762)
			f26_arg0.fefooterRighSlideIn:setAlpha(0)
			f26_local2(f26_arg0.fefooterRighSlideIn)
			local f26_local3 = function(f34_arg0)
				local f34_local0 = function(f35_arg0)
					local f35_local0 = function(f36_arg0)
						f36_arg0:beginAnimation(20)
						f36_arg0:setLeftRight(0.5, 0.5, -323, -197)
						f36_arg0:registerEventHandler("transition_complete_keyframe", f26_arg0.clipFinished)
					end
					f35_arg0:beginAnimation(160)
					f35_arg0:setLeftRight(0.5, 0.5, -227.13, -101.13)
					f35_arg0:setAlpha(1)
					f35_arg0:registerEventHandler("transition_complete_keyframe", f35_local0)
				end
				f26_arg0.featureOverlayButtonMouseOnly:beginAnimation(120)
				f26_arg0.featureOverlayButtonMouseOnly:setLeftRight(0.5, 0.5, 539.8, 665.8)
				f26_arg0.featureOverlayButtonMouseOnly:registerEventHandler("interrupted_keyframe", f26_arg0.clipInterrupted)
				f26_arg0.featureOverlayButtonMouseOnly:registerEventHandler("transition_complete_keyframe", f34_local0)
			end
			f26_arg0.featureOverlayButtonMouseOnly:completeAnimation()
			f26_arg0.featureOverlayButtonMouseOnly:setLeftRight(0.5, 0.5, 1115, 1241)
			f26_arg0.featureOverlayButtonMouseOnly:setTopBottom(0.5, 0.5, 415, 472)
			f26_arg0.featureOverlayButtonMouseOnly:setAlpha(0)
			f26_local3(f26_arg0.featureOverlayButtonMouseOnly)
		end,
		Close = function(f37_arg0, f37_arg1)
			f37_arg0:__resetProperties()
			f37_arg0:setupElementClipCounter(4)
			local f37_local0 = function(f38_arg0)
				f38_arg0:beginAnimation(160)
				f38_arg0:setAlpha(0)
				f38_arg0:registerEventHandler("transition_complete_keyframe", f37_arg0.clipFinished)
			end
			f37_arg0.Blackfade:beginAnimation(20)
			f37_arg0.Blackfade:setAlpha(0.35)
			f37_arg0.Blackfade:registerEventHandler("interrupted_keyframe", f37_arg0.clipInterrupted)
			f37_arg0.Blackfade:registerEventHandler("transition_complete_keyframe", f37_local0)
			local f37_local1 = function(f39_arg0)
				local f39_local0 = function(f40_arg0)
					local f40_local0 = function(f41_arg0)
						f41_arg0:beginAnimation(110)
						f41_arg0:setLeftRight(0, 0, 2000, 2800)
						f41_arg0:registerEventHandler("transition_complete_keyframe", f37_arg0.clipFinished)
					end
					f40_arg0:beginAnimation(170)
					f40_arg0:setLeftRight(0.18, 0.18, 1120, 1920)
					f40_arg0:setAlpha(0)
					f40_arg0:registerEventHandler("transition_complete_keyframe", f40_local0)
				end
				f37_arg0.plasmaContainer:beginAnimation(20)
				f37_arg0.plasmaContainer:setLeftRight(0.47, 0.47, -240, 560)
				f37_arg0.plasmaContainer:registerEventHandler("interrupted_keyframe", f37_arg0.clipInterrupted)
				f37_arg0.plasmaContainer:registerEventHandler("transition_complete_keyframe", f39_local0)
			end
			f37_arg0.plasmaContainer:completeAnimation()
			f37_arg0.plasmaContainer:setLeftRight(0.5, 0.5, -400, 400)
			f37_arg0.plasmaContainer:setAlpha(1)
			f37_local1(f37_arg0.plasmaContainer)
			local f37_local2 = function(f42_arg0)
				local f42_local0 = function(f43_arg0)
					local f43_local0 = function(f44_arg0)
						f44_arg0:beginAnimation(110)
						f44_arg0:setLeftRight(0.5, 0.5, 1114, 1762)
						f44_arg0:registerEventHandler("transition_complete_keyframe", f37_arg0.clipFinished)
					end
					f43_arg0:beginAnimation(170)
					f43_arg0:setLeftRight(0.5, 0.5, 586.73, 1234.73)
					f43_arg0:setAlpha(0)
					f43_arg0:registerEventHandler("transition_complete_keyframe", f43_local0)
				end
				f37_arg0.fefooterRighSlideIn:beginAnimation(20)
				f37_arg0.fefooterRighSlideIn:setLeftRight(0.5, 0.5, -228.13, 419.87)
				f37_arg0.fefooterRighSlideIn:registerEventHandler("interrupted_keyframe", f37_arg0.clipInterrupted)
				f37_arg0.fefooterRighSlideIn:registerEventHandler("transition_complete_keyframe", f42_local0)
			end
			f37_arg0.fefooterRighSlideIn:completeAnimation()
			f37_arg0.fefooterRighSlideIn:setLeftRight(0.5, 0.5, -324, 324)
			f37_arg0.fefooterRighSlideIn:setAlpha(1)
			f37_local2(f37_arg0.fefooterRighSlideIn)
			local f37_local3 = function(f45_arg0)
				local f45_local0 = function(f46_arg0)
					local f46_local0 = function(f47_arg0)
						f47_arg0:beginAnimation(110)
						f47_arg0:setLeftRight(0.5, 0.5, 1117, 1243)
						f47_arg0:registerEventHandler("transition_complete_keyframe", f37_arg0.clipFinished)
					end
					f46_arg0:beginAnimation(170)
					f46_arg0:setLeftRight(0.5, 0.5, 589, 715)
					f46_arg0:setAlpha(0)
					f46_arg0:registerEventHandler("transition_complete_keyframe", f46_local0)
				end
				f37_arg0.featureOverlayButtonMouseOnly:beginAnimation(20)
				f37_arg0.featureOverlayButtonMouseOnly:setLeftRight(0.5, 0.5, -227, -101)
				f37_arg0.featureOverlayButtonMouseOnly:registerEventHandler("interrupted_keyframe", f37_arg0.clipInterrupted)
				f37_arg0.featureOverlayButtonMouseOnly:registerEventHandler("transition_complete_keyframe", f45_local0)
			end
			f37_arg0.featureOverlayButtonMouseOnly:completeAnimation()
			f37_arg0.featureOverlayButtonMouseOnly:setLeftRight(0.5, 0.5, -323, -197)
			f37_arg0.featureOverlayButtonMouseOnly:setAlpha(1)
			f37_local3(f37_arg0.featureOverlayButtonMouseOnly)
		end,
	},
}
CoD.PurchasePlasma.__onClose = function(f48_arg0)
	f48_arg0.plasmaContainer:close()
	f48_arg0.fefooterRighSlideIn:close()
	f48_arg0.featureOverlayButtonMouseOnly:close()
	f48_arg0.PCSmallCloseButton:close()
end
