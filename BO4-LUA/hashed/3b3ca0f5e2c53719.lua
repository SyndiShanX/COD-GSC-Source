require("x64:413987f664adb29")
require("x64:68669756704846e")
require("x64:156d841adc02c80")
require("x64:ba72b08fda6493")
CoD.PurchaseCodPoints = InheritFrom(CoD.Menu)
LUI.createMenu.PurchaseCodPoints = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("PurchaseCodPoints", f1_arg0)
	local f1_local1 = self
	self:setClass(CoD.PurchaseCodPoints)
	self.soundSet = "none"
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
	local CoDPointsContainer = CoD.CoDPoints_Container.new(f1_local1, f1_arg0, 0.5, 0.5, -400, 400, 0, 1, 0, 0)
	self:addElement(CoDPointsContainer)
	self.CoDPointsContainer = CoDPointsContainer
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
	local TiledwhiteNoiseBacking = nil
	TiledwhiteNoiseBacking = LUI.UIImage.new(0.5, 0.5, 103, 325, 0, 0, 85, 127)
	TiledwhiteNoiseBacking:setAlpha(0.02)
	TiledwhiteNoiseBacking:setImage(RegisterImage(@"uie_ui_menu_aar_repeat_white_bg"))
	TiledwhiteNoiseBacking:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_67C9C02F608D0A75"))
	TiledwhiteNoiseBacking:setShaderVector(0, 0, 0, 0, 0)
	TiledwhiteNoiseBacking:setupNineSliceShader(64, 64)
	self:addElement(TiledwhiteNoiseBacking)
	self.TiledwhiteNoiseBacking = TiledwhiteNoiseBacking
	local SpinnerLoadingAnimation = CoD.SpinnerLoadingAnimation.new(f1_local1, f1_arg0, 0, 0, 912, 1008, 0, 0, 492, 588)
	SpinnerLoadingAnimation:setAlpha(0)
	self:addElement(SpinnerLoadingAnimation)
	self.SpinnerLoadingAnimation = SpinnerLoadingAnimation
	local PCSmallCloseButton = nil
	PCSmallCloseButton = CoD.PC_SmallCloseButton.new(f1_local1, f1_arg0, 0.5, 0.5, 342, 376, 0.5, 0.5, -531.5, -497.5)
	PCSmallCloseButton:registerEventHandler("gain_focus", function(element, event)
		local f3_local0 = nil
		if element.gainFocus then
			f3_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f3_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_none"])
		return f3_local0
	end)
	f1_local1:AddButtonCallbackFunction(PCSmallCloseButton, f1_arg0, Enum[@"luibutton"][@"lui_key_none"], "MOUSE1", function(element, menu, controller, model)
		HidePsStoreIcon(controller)
		PlayClip(self, "Close", controller)
		DelayGoBack(menu, controller, 300)
		PlaySoundAlias("uin_party_ease_slide_back")
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_none"], @"hash_0", nil, "MOUSE1")
		return false
	end, false)
	f1_local1:AddButtonCallbackFunction(PCSmallCloseButton, f1_arg0, Enum[@"luibutton"][@"lui_key_none"], "ui_confirm", function(element, menu, controller, model)
		HidePsStoreIcon(controller)
		PlayClip(self, "Close", controller)
		DelayGoBack(menu, controller, 300)
		PlaySoundAlias("uin_party_ease_slide_back")
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_none"], @"hash_0", nil, "ui_confirm")
		return false
	end, false)
	self:addElement(PCSmallCloseButton)
	self.PCSmallCloseButton = PCSmallCloseButton
	self:mergeStateConditions({
		{
			stateName = "Working",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueEqualTo(f1_arg0, "StoreRoot.ready", 0) and not IsPC()
			end,
		},
		{
			stateName = "WorkingPC",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueEqualTo(f1_arg0, "StoreRoot.ready", 0) and IsPC()
			end,
		},
		{
			stateName = "DefaultStatePC",
			condition = function(menu, element, event)
				return IsPC()
			end,
		},
	})
	local f1_local8 = self
	local f1_local9 = self.subscribeToModel
	local f1_local10 = Engine[@"getmodelforcontroller"](f1_arg0)
	f1_local9(f1_local8, f1_local10["StoreRoot.ready"], function(f11_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f11_arg0:get(),
			modelName = "StoreRoot.ready",
		})
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], nil, function(element, menu, controller, model)
		HidePsStoreIcon(controller)
		PlayClip(self, "Close", controller)
		DelayGoBack(menu, controller, 300)
		PlaySoundAlias("uin_party_ease_slide_back")
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], @"menu/back", nil, nil)
		return true
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(self, "close", function(element)
		ClearMenuSavedState(f1_local1)
		HidePsStoreIcon(f1_arg0)
	end)
	self.__on_menuOpened_self = function(f15_arg0, f15_arg1, f15_arg2, f15_arg3)
		local f15_local0 = self
		ShowPsStoreIcon(f15_arg1, Enum[@"hash_6784DC8CE13E1E13"][@"right"])
		PlaySoundAlias("uin_party_ease_slide")
		MenuHidesFreeCursor(f15_arg2, f15_arg1)
	end
	f1_local1:addMenuOpenedCallback(self.__on_menuOpened_self)
	self:subscribeToGlobalModel(f1_arg0, "PerController", "CoDPointStoreList", function(model)
		local f16_local0 = self
		AutoSelectCodPointCategory(self, f1_arg0)
	end)
	self:subscribeToGlobalModel(f1_arg0, "PerController", "StoreRoot.storeError", function(model)
		local f17_local0 = self
		if CoD.ModelUtility.IsModelValueEqualTo(f1_arg0, "StoreRoot.storeError", 2) and IsPC() then
			CoD.PCUtility.ShowBattleNetReconciliationError(f1_local1, f1_arg0)
			GoBack(self, f1_arg0)
		elseif CoD.ModelUtility.IsModelValueEqualTo(f1_arg0, "StoreRoot.storeError", 1) then
			CoD.PCUtility.ShowBattleNetCatalogError(f1_local1, f1_arg0)
			GoBack(self, f1_arg0)
		end
	end)
	CoDPointsContainer.id = "CoDPointsContainer"
	fefooterRighSlideIn.buttons:setModel(self.buttonModel, f1_arg0)
	if CoD.isPC then
		fefooterRighSlideIn.id = "fefooterRighSlideIn"
	end
	if CoD.isPC then
		PCSmallCloseButton.id = "PCSmallCloseButton"
	end
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	self.__defaultFocus = CoDPointsContainer
	if CoD.isPC and (IsKeyboard(f1_arg0) or self.ignoreCursor) then
		self:restoreState(f1_arg0)
	end
	self.__on_close_removeOverrides = function()
		f1_local1:removeMenuOpenedCallback(self.__on_menuOpened_self)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	f1_local9 = self
	CoD.BaseUtility.SetModelFromUserData(f1_arg0, self.CoDPointsContainer, f1_arg1)
	AutoSelectCodPointCategory(self, f1_arg0)
	SetControllerModelValue(f1_arg0, "StoreRoot.storeError", 0)
	return self
end
CoD.PurchaseCodPoints.__resetProperties = function(f19_arg0)
	f19_arg0.CoDPointsContainer:completeAnimation()
	f19_arg0.fefooterRighSlideIn:completeAnimation()
	f19_arg0.SpinnerLoadingAnimation:completeAnimation()
	f19_arg0.Blackfade:completeAnimation()
	f19_arg0.TiledwhiteNoiseBacking:completeAnimation()
	f19_arg0.CoDPointsContainer:setLeftRight(0.5, 0.5, -400, 400)
	f19_arg0.CoDPointsContainer:setTopBottom(0, 1, 0, 0)
	f19_arg0.CoDPointsContainer:setAlpha(1)
	f19_arg0.fefooterRighSlideIn:setLeftRight(1, 1, -670, -22)
	f19_arg0.fefooterRighSlideIn:setTopBottom(1, 1, -48, 0)
	f19_arg0.fefooterRighSlideIn:setAlpha(1)
	f19_arg0.SpinnerLoadingAnimation:setAlpha(0)
	f19_arg0.Blackfade:setAlpha(0.35)
	f19_arg0.TiledwhiteNoiseBacking:setAlpha(0.02)
end
CoD.PurchaseCodPoints.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(3)
			f20_arg0.CoDPointsContainer:completeAnimation()
			f20_arg0.CoDPointsContainer:setLeftRight(0, 0, 1120, 1920)
			f20_arg0.CoDPointsContainer:setTopBottom(0, 0, 0, 1080)
			f20_arg0.clipFinished(f20_arg0.CoDPointsContainer)
			f20_arg0.fefooterRighSlideIn:completeAnimation()
			f20_arg0.fefooterRighSlideIn:setLeftRight(1, 1, -670, -22)
			f20_arg0.fefooterRighSlideIn:setTopBottom(1, 1, -48, 0)
			f20_arg0.clipFinished(f20_arg0.fefooterRighSlideIn)
			f20_arg0.SpinnerLoadingAnimation:completeAnimation()
			f20_arg0.SpinnerLoadingAnimation:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.SpinnerLoadingAnimation)
		end,
		Intro = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(3)
			local f21_local0 = function(f22_arg0)
				f21_arg0.Blackfade:beginAnimation(300)
				f21_arg0.Blackfade:setAlpha(0.35)
				f21_arg0.Blackfade:registerEventHandler("interrupted_keyframe", f21_arg0.clipInterrupted)
				f21_arg0.Blackfade:registerEventHandler("transition_complete_keyframe", f21_arg0.clipFinished)
			end
			f21_arg0.Blackfade:completeAnimation()
			f21_arg0.Blackfade:setAlpha(0)
			f21_local0(f21_arg0.Blackfade)
			local f21_local1 = function(f23_arg0)
				f21_arg0.CoDPointsContainer:beginAnimation(300)
				f21_arg0.CoDPointsContainer:setLeftRight(0, 0, 1120, 1920)
				f21_arg0.CoDPointsContainer:registerEventHandler("interrupted_keyframe", f21_arg0.clipInterrupted)
				f21_arg0.CoDPointsContainer:registerEventHandler("transition_complete_keyframe", f21_arg0.clipFinished)
			end
			f21_arg0.CoDPointsContainer:completeAnimation()
			f21_arg0.CoDPointsContainer:setLeftRight(0, 0, 1920, 2720)
			f21_arg0.CoDPointsContainer:setTopBottom(0, 0, 0, 1080)
			f21_local1(f21_arg0.CoDPointsContainer)
			local f21_local2 = function(f24_arg0)
				f21_arg0.fefooterRighSlideIn:beginAnimation(300)
				f21_arg0.fefooterRighSlideIn:setLeftRight(1, 1, -670, -22)
				f21_arg0.fefooterRighSlideIn:registerEventHandler("interrupted_keyframe", f21_arg0.clipInterrupted)
				f21_arg0.fefooterRighSlideIn:registerEventHandler("transition_complete_keyframe", f21_arg0.clipFinished)
			end
			f21_arg0.fefooterRighSlideIn:completeAnimation()
			f21_arg0.fefooterRighSlideIn:setLeftRight(1, 1, 130, 778)
			f21_local2(f21_arg0.fefooterRighSlideIn)
		end,
		Close = function(f25_arg0, f25_arg1)
			f25_arg0:__resetProperties()
			f25_arg0:setupElementClipCounter(3)
			local f25_local0 = function(f26_arg0)
				f25_arg0.Blackfade:beginAnimation(300)
				f25_arg0.Blackfade:setAlpha(0)
				f25_arg0.Blackfade:registerEventHandler("interrupted_keyframe", f25_arg0.clipInterrupted)
				f25_arg0.Blackfade:registerEventHandler("transition_complete_keyframe", f25_arg0.clipFinished)
			end
			f25_arg0.Blackfade:completeAnimation()
			f25_arg0.Blackfade:setAlpha(0.35)
			f25_local0(f25_arg0.Blackfade)
			local f25_local1 = function(f27_arg0)
				f25_arg0.CoDPointsContainer:beginAnimation(300)
				f25_arg0.CoDPointsContainer:setLeftRight(0, 0, 1920, 2720)
				f25_arg0.CoDPointsContainer:registerEventHandler("interrupted_keyframe", f25_arg0.clipInterrupted)
				f25_arg0.CoDPointsContainer:registerEventHandler("transition_complete_keyframe", f25_arg0.clipFinished)
			end
			f25_arg0.CoDPointsContainer:completeAnimation()
			f25_arg0.CoDPointsContainer:setLeftRight(0, 0, 1120, 1920)
			f25_arg0.CoDPointsContainer:setTopBottom(0, 0, 0, 1080)
			f25_local1(f25_arg0.CoDPointsContainer)
			local f25_local2 = function(f28_arg0)
				f25_arg0.fefooterRighSlideIn:beginAnimation(300)
				f25_arg0.fefooterRighSlideIn:setLeftRight(1, 1, 130, 778)
				f25_arg0.fefooterRighSlideIn:registerEventHandler("interrupted_keyframe", f25_arg0.clipInterrupted)
				f25_arg0.fefooterRighSlideIn:registerEventHandler("transition_complete_keyframe", f25_arg0.clipFinished)
			end
			f25_arg0.fefooterRighSlideIn:completeAnimation()
			f25_arg0.fefooterRighSlideIn:setLeftRight(1, 1, -670, -22)
			f25_local2(f25_arg0.fefooterRighSlideIn)
		end,
	},
	Working = {
		DefaultClip = function(f29_arg0, f29_arg1)
			f29_arg0:__resetProperties()
			f29_arg0:setupElementClipCounter(2)
			f29_arg0.CoDPointsContainer:completeAnimation()
			f29_arg0.CoDPointsContainer:setLeftRight(0.5, 0.5, 973, 1773)
			f29_arg0.clipFinished(f29_arg0.CoDPointsContainer)
			f29_arg0.SpinnerLoadingAnimation:completeAnimation()
			f29_arg0.SpinnerLoadingAnimation:setAlpha(1)
			f29_arg0.clipFinished(f29_arg0.SpinnerLoadingAnimation)
		end,
		DefaultState = function(f30_arg0, f30_arg1)
			f30_arg0:__resetProperties()
			f30_arg0:setupElementClipCounter(2)
			local f30_local0 = function(f31_arg0)
				f30_arg0.CoDPointsContainer:beginAnimation(300)
				f30_arg0.CoDPointsContainer:setLeftRight(0.5, 0.5, 1120, 1920)
				f30_arg0.CoDPointsContainer:registerEventHandler("interrupted_keyframe", f30_arg0.clipInterrupted)
				f30_arg0.CoDPointsContainer:registerEventHandler("transition_complete_keyframe", f30_arg0.clipFinished)
			end
			f30_arg0.CoDPointsContainer:completeAnimation()
			f30_arg0.CoDPointsContainer:setLeftRight(0, 0, 1920, 2720)
			f30_arg0.CoDPointsContainer:setTopBottom(0, 0, 0, 1080)
			f30_local0(f30_arg0.CoDPointsContainer)
			f30_arg0.fefooterRighSlideIn:completeAnimation()
			f30_arg0.fefooterRighSlideIn:setLeftRight(1, 1, -670, -22)
			f30_arg0.fefooterRighSlideIn:setTopBottom(1, 1, -48, 0)
			f30_arg0.clipFinished(f30_arg0.fefooterRighSlideIn)
		end,
	},
	WorkingPC = {
		DefaultClip = function(f32_arg0, f32_arg1)
			f32_arg0:__resetProperties()
			f32_arg0:setupElementClipCounter(4)
			f32_arg0.CoDPointsContainer:completeAnimation()
			f32_arg0.CoDPointsContainer:setAlpha(0)
			f32_arg0.clipFinished(f32_arg0.CoDPointsContainer)
			f32_arg0.fefooterRighSlideIn:completeAnimation()
			f32_arg0.fefooterRighSlideIn:setLeftRight(0.5, 0.5, -508, 140)
			f32_arg0.fefooterRighSlideIn:setTopBottom(1, 1, -48, 0)
			f32_arg0.fefooterRighSlideIn:setAlpha(0)
			f32_arg0.clipFinished(f32_arg0.fefooterRighSlideIn)
			f32_arg0.TiledwhiteNoiseBacking:completeAnimation()
			f32_arg0.TiledwhiteNoiseBacking:setAlpha(0)
			f32_arg0.clipFinished(f32_arg0.TiledwhiteNoiseBacking)
			f32_arg0.SpinnerLoadingAnimation:completeAnimation()
			f32_arg0.SpinnerLoadingAnimation:setAlpha(1)
			f32_arg0.clipFinished(f32_arg0.SpinnerLoadingAnimation)
		end,
		DefaultState = function(f33_arg0, f33_arg1)
			f33_arg0:__resetProperties()
			f33_arg0:setupElementClipCounter(2)
			local f33_local0 = function(f34_arg0)
				f34_arg0:beginAnimation(239, Enum[@"luitween"][@"luitween_ease_both"])
				f34_arg0:setAlpha(1)
				f34_arg0:registerEventHandler("transition_complete_keyframe", f33_arg0.clipFinished)
			end
			f33_arg0.CoDPointsContainer:beginAnimation(180)
			f33_arg0.CoDPointsContainer:setLeftRight(0.5, 0.5, -400, 400)
			f33_arg0.CoDPointsContainer:setTopBottom(0, 0, 0, 1080)
			f33_arg0.CoDPointsContainer:setAlpha(0)
			f33_arg0.CoDPointsContainer:registerEventHandler("interrupted_keyframe", f33_arg0.clipInterrupted)
			f33_arg0.CoDPointsContainer:registerEventHandler("transition_complete_keyframe", f33_local0)
			local f33_local1 = function(f35_arg0)
				local f35_local0 = function(f36_arg0)
					f36_arg0:beginAnimation(239, Enum[@"luitween"][@"luitween_ease_both"])
					f36_arg0:setAlpha(1)
					f36_arg0:registerEventHandler("transition_complete_keyframe", f33_arg0.clipFinished)
				end
				f33_arg0.fefooterRighSlideIn:beginAnimation(180)
				f33_arg0.fefooterRighSlideIn:registerEventHandler("interrupted_keyframe", f33_arg0.clipInterrupted)
				f33_arg0.fefooterRighSlideIn:registerEventHandler("transition_complete_keyframe", f35_local0)
			end
			f33_arg0.fefooterRighSlideIn:completeAnimation()
			f33_arg0.fefooterRighSlideIn:setLeftRight(0.5, 0.5, -508, 140)
			f33_arg0.fefooterRighSlideIn:setTopBottom(1, 1, -48, 0)
			f33_arg0.fefooterRighSlideIn:setAlpha(0)
			f33_local1(f33_arg0.fefooterRighSlideIn)
		end,
	},
	DefaultStatePC = {
		DefaultClip = function(f37_arg0, f37_arg1)
			f37_arg0:__resetProperties()
			f37_arg0:setupElementClipCounter(3)
			f37_arg0.CoDPointsContainer:completeAnimation()
			f37_arg0.CoDPointsContainer:setLeftRight(0.5, 0.5, -400, 400)
			f37_arg0.CoDPointsContainer:setTopBottom(0, 1, 0, 0)
			f37_arg0.clipFinished(f37_arg0.CoDPointsContainer)
			f37_arg0.fefooterRighSlideIn:completeAnimation()
			f37_arg0.fefooterRighSlideIn:setLeftRight(0.5, 0.5, -508, 140)
			f37_arg0.fefooterRighSlideIn:setTopBottom(1, 1, -48, 0)
			f37_arg0.clipFinished(f37_arg0.fefooterRighSlideIn)
			f37_arg0.SpinnerLoadingAnimation:completeAnimation()
			f37_arg0.SpinnerLoadingAnimation:setAlpha(0)
			f37_arg0.clipFinished(f37_arg0.SpinnerLoadingAnimation)
		end,
		Intro = function(f38_arg0, f38_arg1)
			f38_arg0:__resetProperties()
			f38_arg0:setupElementClipCounter(4)
			local f38_local0 = function(f39_arg0)
				f38_arg0.Blackfade:beginAnimation(300)
				f38_arg0.Blackfade:setAlpha(0.35)
				f38_arg0.Blackfade:registerEventHandler("interrupted_keyframe", f38_arg0.clipInterrupted)
				f38_arg0.Blackfade:registerEventHandler("transition_complete_keyframe", f38_arg0.clipFinished)
			end
			f38_arg0.Blackfade:completeAnimation()
			f38_arg0.Blackfade:setAlpha(0)
			f38_local0(f38_arg0.Blackfade)
			local f38_local1 = function(f40_arg0)
				f38_arg0.CoDPointsContainer:beginAnimation(300, Enum[@"luitween"][@"luitween_ease_both"])
				f38_arg0.CoDPointsContainer:setAlpha(1)
				f38_arg0.CoDPointsContainer:registerEventHandler("interrupted_keyframe", f38_arg0.clipInterrupted)
				f38_arg0.CoDPointsContainer:registerEventHandler("transition_complete_keyframe", f38_arg0.clipFinished)
			end
			f38_arg0.CoDPointsContainer:completeAnimation()
			f38_arg0.CoDPointsContainer:setLeftRight(0.5, 0.5, -400, 400)
			f38_arg0.CoDPointsContainer:setAlpha(0)
			f38_local1(f38_arg0.CoDPointsContainer)
			local f38_local2 = function(f41_arg0)
				f38_arg0.fefooterRighSlideIn:beginAnimation(300, Enum[@"luitween"][@"luitween_ease_both"])
				f38_arg0.fefooterRighSlideIn:setAlpha(1)
				f38_arg0.fefooterRighSlideIn:registerEventHandler("interrupted_keyframe", f38_arg0.clipInterrupted)
				f38_arg0.fefooterRighSlideIn:registerEventHandler("transition_complete_keyframe", f38_arg0.clipFinished)
			end
			f38_arg0.fefooterRighSlideIn:completeAnimation()
			f38_arg0.fefooterRighSlideIn:setLeftRight(0.5, 0.5, -508, 140)
			f38_arg0.fefooterRighSlideIn:setTopBottom(1, 1, -48, 0)
			f38_arg0.fefooterRighSlideIn:setAlpha(0)
			f38_local2(f38_arg0.fefooterRighSlideIn)
			local f38_local3 = function(f42_arg0)
				f42_arg0:beginAnimation(150)
				f42_arg0:setAlpha(0.02)
				f42_arg0:registerEventHandler("transition_complete_keyframe", f38_arg0.clipFinished)
			end
			f38_arg0.TiledwhiteNoiseBacking:beginAnimation(80)
			f38_arg0.TiledwhiteNoiseBacking:setAlpha(0)
			f38_arg0.TiledwhiteNoiseBacking:registerEventHandler("interrupted_keyframe", f38_arg0.clipInterrupted)
			f38_arg0.TiledwhiteNoiseBacking:registerEventHandler("transition_complete_keyframe", f38_local3)
		end,
		Close = function(f43_arg0, f43_arg1)
			f43_arg0:__resetProperties()
			f43_arg0:setupElementClipCounter(4)
			local f43_local0 = function(f44_arg0)
				f43_arg0.Blackfade:beginAnimation(250)
				f43_arg0.Blackfade:setAlpha(0)
				f43_arg0.Blackfade:registerEventHandler("interrupted_keyframe", f43_arg0.clipInterrupted)
				f43_arg0.Blackfade:registerEventHandler("transition_complete_keyframe", f43_arg0.clipFinished)
			end
			f43_arg0.Blackfade:completeAnimation()
			f43_arg0.Blackfade:setAlpha(0.35)
			f43_local0(f43_arg0.Blackfade)
			local f43_local1 = function(f45_arg0)
				f43_arg0.CoDPointsContainer:beginAnimation(150)
				f43_arg0.CoDPointsContainer:setAlpha(0)
				f43_arg0.CoDPointsContainer:registerEventHandler("interrupted_keyframe", f43_arg0.clipInterrupted)
				f43_arg0.CoDPointsContainer:registerEventHandler("transition_complete_keyframe", f43_arg0.clipFinished)
			end
			f43_arg0.CoDPointsContainer:completeAnimation()
			f43_arg0.CoDPointsContainer:setLeftRight(0.5, 0.5, -400, 400)
			f43_arg0.CoDPointsContainer:setTopBottom(0, 0, 0, 1080)
			f43_arg0.CoDPointsContainer:setAlpha(1)
			f43_local1(f43_arg0.CoDPointsContainer)
			local f43_local2 = function(f46_arg0)
				f43_arg0.fefooterRighSlideIn:beginAnimation(150)
				f43_arg0.fefooterRighSlideIn:setAlpha(0)
				f43_arg0.fefooterRighSlideIn:registerEventHandler("interrupted_keyframe", f43_arg0.clipInterrupted)
				f43_arg0.fefooterRighSlideIn:registerEventHandler("transition_complete_keyframe", f43_arg0.clipFinished)
			end
			f43_arg0.fefooterRighSlideIn:completeAnimation()
			f43_arg0.fefooterRighSlideIn:setLeftRight(0.5, 0.5, -508, 140)
			f43_arg0.fefooterRighSlideIn:setTopBottom(1, 1, -48, 0)
			f43_arg0.fefooterRighSlideIn:setAlpha(1)
			f43_local2(f43_arg0.fefooterRighSlideIn)
			local f43_local3 = function(f47_arg0)
				f43_arg0.TiledwhiteNoiseBacking:beginAnimation(150)
				f43_arg0.TiledwhiteNoiseBacking:setAlpha(0)
				f43_arg0.TiledwhiteNoiseBacking:registerEventHandler("interrupted_keyframe", f43_arg0.clipInterrupted)
				f43_arg0.TiledwhiteNoiseBacking:registerEventHandler("transition_complete_keyframe", f43_arg0.clipFinished)
			end
			f43_arg0.TiledwhiteNoiseBacking:completeAnimation()
			f43_arg0.TiledwhiteNoiseBacking:setAlpha(0.02)
			f43_local3(f43_arg0.TiledwhiteNoiseBacking)
		end,
	},
}
CoD.PurchaseCodPoints.__onClose = function(f48_arg0)
	f48_arg0.__on_close_removeOverrides()
	f48_arg0.CoDPointsContainer:close()
	f48_arg0.fefooterRighSlideIn:close()
	f48_arg0.SpinnerLoadingAnimation:close()
	f48_arg0.PCSmallCloseButton:close()
end
