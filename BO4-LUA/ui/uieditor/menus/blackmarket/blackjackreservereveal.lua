require("x64:db806626fb64f10")
require("x64:2d64ca9d3c705ce")
require("x64:de4c66b722f8d67")
require("x64:e46165d5c607ec3")
require("x64:28b39fa069d1324")
require("x64:43a18b0c952dcc0")
CoD.BlackjackReserveReveal = InheritFrom(CoD.Menu)
LUI.createMenu.BlackjackReserveReveal = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("BlackjackReserveReveal", f1_arg0)
	local f1_local1 = self
	MenuHidesFreeCursor(f1_local1, f1_arg0)
	CoD.BaseUtility.SetModelFromUserData(f1_arg0, self, f1_arg1._model)
	CoD.BaseUtility.InitControllerModel(f1_arg0, "reservesRevealComplete", false)
	CoD.BaseUtility.InitControllerModel(f1_arg0, "reservesRevealSkipAvailable", false)
	self:setClass(CoD.BlackjackReserveReveal)
	self.soundSet = "default"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	f1_local1:addElementToPendingUpdateStateList(self)
	local backing = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	backing:setRGB(0, 0, 0)
	backing:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_E2354BE557C4C7A"))
	backing:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(backing)
	self.backing = backing
	local BackgroundImage = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	BackgroundImage:setAlpha(0.85)
	BackgroundImage:setImage(RegisterImage(@"uie_fe_cp_background"))
	self:addElement(BackgroundImage)
	self.BackgroundImage = BackgroundImage
	local FramingCornerBrackets = CoD.CommonCornerBrackets01.new(f1_local1, f1_arg0, 0.5, 0.5, -598.5, 598.5, 0.5, 0.5, -374, 374)
	FramingCornerBrackets:setAlpha(0.1)
	self:addElement(FramingCornerBrackets)
	self.FramingCornerBrackets = FramingCornerBrackets
	local NoiseTiledBackingRight = LUI.UIImage.new(0.5, 0.5, -565.5, 565.5, 0.5, 0.5, -342, 342)
	NoiseTiledBackingRight:setAlpha(0.4)
	NoiseTiledBackingRight:setImage(RegisterImage(@"uie_ui_menu_specialist_hub_repeat_bg"))
	NoiseTiledBackingRight:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	NoiseTiledBackingRight:setShaderVector(0, 0, 0, 0, 0)
	NoiseTiledBackingRight:setupNineSliceShader(196, 88)
	self:addElement(NoiseTiledBackingRight)
	self.NoiseTiledBackingRight = NoiseTiledBackingRight
	local DottedLineBtm = LUI.UIImage.new(0.5, 0.5, -566, 566, 0.5, 0.5, 354, 358)
	DottedLineBtm:setAlpha(0.35)
	DottedLineBtm:setImage(RegisterImage(@"uie_ui_menu_social_emblem_dotline_tiled"))
	DottedLineBtm:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_67C9C02F608D0A75"))
	DottedLineBtm:setShaderVector(0, 0, 0, 0, 0)
	DottedLineBtm:setupNineSliceShader(16, 4)
	self:addElement(DottedLineBtm)
	self.DottedLineBtm = DottedLineBtm
	local DottedLineTop = LUI.UIImage.new(0.5, 0.5, -566, 566, 0.5, 0.5, -359, -355)
	DottedLineTop:setAlpha(0.35)
	DottedLineTop:setImage(RegisterImage(@"uie_ui_menu_social_emblem_dotline_tiled"))
	DottedLineTop:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_67C9C02F608D0A75"))
	DottedLineTop:setShaderVector(0, 0, 0, 0, 0)
	DottedLineTop:setupNineSliceShader(16, 4)
	self:addElement(DottedLineTop)
	self.DottedLineTop = DottedLineTop
	local GenericMenuFrameIdentity = CoD.GenericMenuFrameIdentity.new(f1_local1, f1_arg0, 0.5, 0.5, -960, 960, 0, 1, 0, 0)
	GenericMenuFrameIdentity.CommonHeader.subtitle.StageTitle:setText(LocalizeToUpperString(@"hash_5B59099CB3805DEB"))
	GenericMenuFrameIdentity:subscribeToGlobalModel(f1_arg0, "LobbyRoot", "lobbyTitle", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			GenericMenuFrameIdentity.CommonHeader.subtitle.subtitle:setText(Engine[@"hash_4F9F1239CFD921FE"](f2_local0))
		end
	end)
	self:addElement(GenericMenuFrameIdentity)
	self.GenericMenuFrameIdentity = GenericMenuFrameIdentity
	local ReservesReroll = CoD.ReservesReroll.new(f1_local1, f1_arg0, 0.5, 0.5, -866.5, -616.5, 0.5, 0.5, -135.5, 135.5)
	ReservesReroll:linkToElementModel(self, nil, false, function(model)
		ReservesReroll:setModel(model, f1_arg0)
	end)
	self:addElement(ReservesReroll)
	self.ReservesReroll = ReservesReroll
	local DupeMeter = CoD.DupeMeter.new(f1_local1, f1_arg0, 0.5, 0.5, -174.5, 174.5, 0.5, 0.5, 361, 395)
	DupeMeter:mergeStateConditions({
		{
			stateName = "AllRngUnlocked",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualToHashString(f1_arg0, element, "name", @"hash_1717FF140F30014C") and AlwaysFalse()
			end,
		},
	})
	DupeMeter:linkToElementModel(DupeMeter, "name", true, function(model)
		f1_local1:updateElementState(DupeMeter, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = model:get(),
			modelName = "name",
		})
	end)
	DupeMeter.Backer.Blur:setAlpha(0)
	DupeMeter:linkToElementModel(self, nil, false, function(model)
		DupeMeter:setModel(model, f1_arg0)
	end)
	self:addElement(DupeMeter)
	self.DupeMeter = DupeMeter
	local SkipRevealPrompt = CoD.ReservesSkipRevealPromptContainer.new(f1_local1, f1_arg0, 0.5, 0.5, 539, 852, 0.5, 0.5, 378, 404)
	self:addElement(SkipRevealPrompt)
	self.SkipRevealPrompt = SkipRevealPrompt
	local RevealList = LUI.UIList.new(f1_local1, f1_arg0, 80, 0, nil, false, false, false, false)
	RevealList:setLeftRight(0.5, 0.5, -545, 545)
	RevealList:setTopBottom(0.5, 0.5, -316, 316)
	RevealList:setWidgetType(CoD.ReservesRevealItem)
	RevealList:setHorizontalCount(3)
	RevealList:setSpacing(80)
	RevealList:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	RevealList:setDataSource("BlackjackReserveRevealList")
	self:addElement(RevealList)
	self.RevealList = RevealList
	self:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return not MenuPropertyIsTrue(menu, "_reservesRevealIntroComplete")
			end,
		},
		{
			stateName = "Rolling",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsModelValueTrue(f1_arg0, "LootRNGResult.ready")
			end,
		},
		{
			stateName = "Results",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsModelValueTrue(f1_arg0, "reservesRevealComplete")
			end,
		},
		{
			stateName = "Reroll",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueTrue(f1_arg0, "reservesRevealComplete")
			end,
		},
	})
	local f1_local13 = self
	local f1_local14 = self.subscribeToModel
	local f1_local15 = Engine[@"getmodelforcontroller"](f1_arg0)
	f1_local14(f1_local13, f1_local15["LootRNGResult.ready"], function(f11_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f11_arg0:get(),
			modelName = "LootRNGResult.ready",
		})
	end, false)
	f1_local13 = self
	f1_local14 = self.subscribeToModel
	f1_local15 = Engine[@"getmodelforcontroller"](f1_arg0)
	f1_local14(f1_local13, f1_local15.reservesRevealComplete, function(f12_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f12_arg0:get(),
			modelName = "reservesRevealComplete",
		})
	end, false)
	f1_local13 = self
	f1_local14 = self.subscribeToModel
	f1_local15 = Engine[@"getmodelforcontroller"](f1_arg0)
	f1_local14(f1_local13, f1_local15.reservesRevealComplete, function(f13_arg0, f13_arg1)
		CoD.Menu.UpdateButtonShownState(f13_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xbb_pscircle"])
		CoD.Menu.UpdateButtonShownState(f13_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	f1_local13 = self
	f1_local14 = self.subscribeToModel
	f1_local15 = Engine[@"getmodelforcontroller"](f1_arg0)
	f1_local14(f1_local13, f1_local15["LootRNGResult.ready"], function(f14_arg0, f14_arg1)
		CoD.Menu.UpdateButtonShownState(f14_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	f1_local13 = self
	f1_local14 = self.subscribeToModel
	f1_local15 = Engine[@"getmodelforcontroller"](f1_arg0)
	f1_local14(f1_local13, f1_local15["LootRNGResult.allBribeItemsOwned"], function(f15_arg0, f15_arg1)
		CoD.Menu.UpdateButtonShownState(f15_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	f1_local13 = self
	f1_local14 = self.subscribeToModel
	f1_local15 = Engine[@"getmodelforcontroller"](f1_arg0)
	f1_local14(f1_local13, f1_local15.reservesRevealSkipAvailable, function(f16_arg0, f16_arg1)
		CoD.Menu.UpdateButtonShownState(f16_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], "ESCAPE", function(element, menu, controller, model)
		if CoD.ModelUtility.IsModelValueTrue(controller, "reservesRevealComplete") then
			GoBack(self, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.ModelUtility.IsModelValueTrue(controller, "reservesRevealComplete") then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], @"menu/back", nil, "ESCAPE")
			return true
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"], nil, function(element, menu, controller, model)
		if CoD.BlackMarketUtility.CanSkipReservesRevealAnimation(controller) then
			CoD.BlackMarketUtility.SkipReservesRevealAnimation(controller, menu, self.RevealList)
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.BlackMarketUtility.CanSkipReservesRevealAnimation(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_0", nil, nil)
			return false
		else
			return false
		end
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(self, "setState", function(element, controller, f21_arg2, f21_arg3, f21_arg4)
		if IsMenuInState(f1_local1, "Reroll") then
			SetMenuProperty(f1_local1, "m_disableNavigation", nil)
		elseif MenuPropertyIsTrue(f1_local1, "_reservesRevealIntroComplete") and CoD.ModelUtility.IsModelValueTrue(controller, "LootRNGResult.ready") and CoD.ModelUtility.IsModelValueTrue(controller, "LootRNGResult.allBribeItemsOwned") then
			GoBack(self, controller)
			CoD.BlackMarketUtility.ShowBribeNotSpentNotification(controller)
		else
			SetMenuProperty(f1_local1, "m_disableNavigation", true)
		end
	end)
	LUI.OverrideFunction_CallOriginalFirst(self, "close", function(element)
		CoD.BlackMarketUtility.ClearRNGModels(f1_arg0)
		CoD.BlackMarketUtility.ClearDupeMeterPulseModels(f1_arg0)
		CoD.BlackMarketUtility.SendClientScriptBlackjackReserveNotify(f1_arg0, true)
	end)
	self:subscribeToGlobalModel(f1_arg0, "PerController", "LootRNGResult.ready", function(model)
		local f23_local0 = self
		if not CoD.ModelUtility.IsModelValueTrue(f1_arg0, "LootRNGResult.ready") then
			CoD.BlackMarketUtility.SetupReservesRevealFailsafe(f1_arg0, f1_local1, 30)
			CoD.BlackMarketUtility.SetupReservesRevealSkipDelay(f1_arg0, f1_local1, 1000, 1500)
		end
	end)
	GenericMenuFrameIdentity:setModel(self.buttonModel, f1_arg0)
	GenericMenuFrameIdentity.id = "GenericMenuFrameIdentity"
	ReservesReroll.id = "ReservesReroll"
	RevealList.id = "RevealList"
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	self.__defaultFocus = ReservesReroll
	if CoD.isPC and (IsKeyboard(f1_arg0) or self.ignoreCursor) then
		self:restoreState(f1_arg0)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	f1_local14 = self
	CoD.BlackMarketUtility.ReservesRevealIntroDelay(f1_arg0, f1_local1, 3500)
	return self
end
CoD.BlackjackReserveReveal.__resetProperties = function(f24_arg0)
	f24_arg0.ReservesReroll:completeAnimation()
	f24_arg0.GenericMenuFrameIdentity:completeAnimation()
	f24_arg0.DupeMeter:completeAnimation()
	f24_arg0.RevealList:completeAnimation()
	f24_arg0.NoiseTiledBackingRight:completeAnimation()
	f24_arg0.FramingCornerBrackets:completeAnimation()
	f24_arg0.BackgroundImage:completeAnimation()
	f24_arg0.backing:completeAnimation()
	f24_arg0.DottedLineTop:completeAnimation()
	f24_arg0.DottedLineBtm:completeAnimation()
	f24_arg0.ReservesReroll:setAlpha(1)
	f24_arg0.GenericMenuFrameIdentity:setAlpha(1)
	f24_arg0.DupeMeter:setAlpha(1)
	f24_arg0.RevealList:setAlpha(1)
	f24_arg0.NoiseTiledBackingRight:setAlpha(0.4)
	f24_arg0.FramingCornerBrackets:setAlpha(0.1)
	f24_arg0.BackgroundImage:setAlpha(0.85)
	f24_arg0.backing:setAlpha(1)
	f24_arg0.DottedLineTop:setAlpha(0.35)
	f24_arg0.DottedLineBtm:setAlpha(0.35)
end
CoD.BlackjackReserveReveal.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f25_arg0, f25_arg1)
			f25_arg0:__resetProperties()
			f25_arg0:setupElementClipCounter(4)
			f25_arg0.GenericMenuFrameIdentity:completeAnimation()
			f25_arg0.GenericMenuFrameIdentity:setAlpha(0)
			f25_arg0.clipFinished(f25_arg0.GenericMenuFrameIdentity)
			f25_arg0.ReservesReroll:completeAnimation()
			f25_arg0.ReservesReroll:setAlpha(0)
			f25_arg0.clipFinished(f25_arg0.ReservesReroll)
			f25_arg0.DupeMeter:completeAnimation()
			f25_arg0.DupeMeter:setAlpha(0)
			f25_arg0.clipFinished(f25_arg0.DupeMeter)
			f25_arg0.RevealList:completeAnimation()
			f25_arg0.RevealList:setAlpha(0)
			f25_arg0.clipFinished(f25_arg0.RevealList)
		end,
	},
	Hidden = {
		DefaultClip = function(f26_arg0, f26_arg1)
			f26_arg0:__resetProperties()
			f26_arg0:setupElementClipCounter(10)
			f26_arg0.backing:completeAnimation()
			f26_arg0.backing:setAlpha(0)
			f26_arg0.clipFinished(f26_arg0.backing)
			f26_arg0.BackgroundImage:completeAnimation()
			f26_arg0.BackgroundImage:setAlpha(0)
			f26_arg0.clipFinished(f26_arg0.BackgroundImage)
			f26_arg0.FramingCornerBrackets:completeAnimation()
			f26_arg0.FramingCornerBrackets:setAlpha(0)
			f26_arg0.clipFinished(f26_arg0.FramingCornerBrackets)
			f26_arg0.NoiseTiledBackingRight:completeAnimation()
			f26_arg0.NoiseTiledBackingRight:setAlpha(0)
			f26_arg0.clipFinished(f26_arg0.NoiseTiledBackingRight)
			f26_arg0.DottedLineBtm:completeAnimation()
			f26_arg0.DottedLineBtm:setAlpha(0)
			f26_arg0.clipFinished(f26_arg0.DottedLineBtm)
			f26_arg0.DottedLineTop:completeAnimation()
			f26_arg0.DottedLineTop:setAlpha(0)
			f26_arg0.clipFinished(f26_arg0.DottedLineTop)
			f26_arg0.GenericMenuFrameIdentity:completeAnimation()
			f26_arg0.GenericMenuFrameIdentity:setAlpha(0)
			f26_arg0.clipFinished(f26_arg0.GenericMenuFrameIdentity)
			f26_arg0.ReservesReroll:completeAnimation()
			f26_arg0.ReservesReroll:setAlpha(0)
			f26_arg0.clipFinished(f26_arg0.ReservesReroll)
			f26_arg0.DupeMeter:completeAnimation()
			f26_arg0.DupeMeter:setAlpha(0)
			f26_arg0.clipFinished(f26_arg0.DupeMeter)
			f26_arg0.RevealList:completeAnimation()
			f26_arg0.RevealList:setAlpha(0)
			f26_arg0.clipFinished(f26_arg0.RevealList)
		end,
		Rolling = function(f27_arg0, f27_arg1)
			f27_arg0:__resetProperties()
			f27_arg0:setupElementClipCounter(9)
			local f27_local0 = function(f28_arg0)
				f27_arg0.backing:beginAnimation(1000)
				f27_arg0.backing:setAlpha(1)
				f27_arg0.backing:registerEventHandler("interrupted_keyframe", f27_arg0.clipInterrupted)
				f27_arg0.backing:registerEventHandler("transition_complete_keyframe", f27_arg0.clipFinished)
			end
			f27_arg0.backing:completeAnimation()
			f27_arg0.backing:setAlpha(0)
			f27_local0(f27_arg0.backing)
			local f27_local1 = function(f29_arg0)
				f27_arg0.BackgroundImage:beginAnimation(1000)
				f27_arg0.BackgroundImage:setAlpha(0.85)
				f27_arg0.BackgroundImage:registerEventHandler("interrupted_keyframe", f27_arg0.clipInterrupted)
				f27_arg0.BackgroundImage:registerEventHandler("transition_complete_keyframe", f27_arg0.clipFinished)
			end
			f27_arg0.BackgroundImage:completeAnimation()
			f27_arg0.BackgroundImage:setAlpha(0)
			f27_local1(f27_arg0.BackgroundImage)
			local f27_local2 = function(f30_arg0)
				f27_arg0.FramingCornerBrackets:beginAnimation(1000)
				f27_arg0.FramingCornerBrackets:setAlpha(0.1)
				f27_arg0.FramingCornerBrackets:registerEventHandler("interrupted_keyframe", f27_arg0.clipInterrupted)
				f27_arg0.FramingCornerBrackets:registerEventHandler("transition_complete_keyframe", f27_arg0.clipFinished)
			end
			f27_arg0.FramingCornerBrackets:completeAnimation()
			f27_arg0.FramingCornerBrackets:setAlpha(0)
			f27_local2(f27_arg0.FramingCornerBrackets)
			local f27_local3 = function(f31_arg0)
				f27_arg0.NoiseTiledBackingRight:beginAnimation(1000)
				f27_arg0.NoiseTiledBackingRight:setAlpha(0.4)
				f27_arg0.NoiseTiledBackingRight:registerEventHandler("interrupted_keyframe", f27_arg0.clipInterrupted)
				f27_arg0.NoiseTiledBackingRight:registerEventHandler("transition_complete_keyframe", f27_arg0.clipFinished)
			end
			f27_arg0.NoiseTiledBackingRight:completeAnimation()
			f27_arg0.NoiseTiledBackingRight:setAlpha(0)
			f27_local3(f27_arg0.NoiseTiledBackingRight)
			local f27_local4 = function(f32_arg0)
				f27_arg0.DottedLineBtm:beginAnimation(1000)
				f27_arg0.DottedLineBtm:setAlpha(0.35)
				f27_arg0.DottedLineBtm:registerEventHandler("interrupted_keyframe", f27_arg0.clipInterrupted)
				f27_arg0.DottedLineBtm:registerEventHandler("transition_complete_keyframe", f27_arg0.clipFinished)
			end
			f27_arg0.DottedLineBtm:completeAnimation()
			f27_arg0.DottedLineBtm:setAlpha(0)
			f27_local4(f27_arg0.DottedLineBtm)
			local f27_local5 = function(f33_arg0)
				f27_arg0.DottedLineTop:beginAnimation(1000)
				f27_arg0.DottedLineTop:setAlpha(0.35)
				f27_arg0.DottedLineTop:registerEventHandler("interrupted_keyframe", f27_arg0.clipInterrupted)
				f27_arg0.DottedLineTop:registerEventHandler("transition_complete_keyframe", f27_arg0.clipFinished)
			end
			f27_arg0.DottedLineTop:completeAnimation()
			f27_arg0.DottedLineTop:setAlpha(0)
			f27_local5(f27_arg0.DottedLineTop)
			local f27_local6 = function(f34_arg0)
				f27_arg0.GenericMenuFrameIdentity:beginAnimation(1000)
				f27_arg0.GenericMenuFrameIdentity:setAlpha(1)
				f27_arg0.GenericMenuFrameIdentity:registerEventHandler("interrupted_keyframe", f27_arg0.clipInterrupted)
				f27_arg0.GenericMenuFrameIdentity:registerEventHandler("transition_complete_keyframe", f27_arg0.clipFinished)
			end
			f27_arg0.GenericMenuFrameIdentity:completeAnimation()
			f27_arg0.GenericMenuFrameIdentity:setAlpha(0)
			f27_local6(f27_arg0.GenericMenuFrameIdentity)
			f27_arg0.ReservesReroll:completeAnimation()
			f27_arg0.ReservesReroll:setAlpha(0)
			f27_arg0.clipFinished(f27_arg0.ReservesReroll)
			f27_arg0.DupeMeter:completeAnimation()
			f27_arg0.DupeMeter:setAlpha(0)
			f27_arg0.clipFinished(f27_arg0.DupeMeter)
		end,
		Results = function(f35_arg0, f35_arg1)
			f35_arg0:__resetProperties()
			f35_arg0:setupElementClipCounter(9)
			local f35_local0 = function(f36_arg0)
				f35_arg0.backing:beginAnimation(1000)
				f35_arg0.backing:setAlpha(1)
				f35_arg0.backing:registerEventHandler("interrupted_keyframe", f35_arg0.clipInterrupted)
				f35_arg0.backing:registerEventHandler("transition_complete_keyframe", f35_arg0.clipFinished)
			end
			f35_arg0.backing:completeAnimation()
			f35_arg0.backing:setAlpha(0)
			f35_local0(f35_arg0.backing)
			local f35_local1 = function(f37_arg0)
				f35_arg0.BackgroundImage:beginAnimation(1000)
				f35_arg0.BackgroundImage:setAlpha(0.85)
				f35_arg0.BackgroundImage:registerEventHandler("interrupted_keyframe", f35_arg0.clipInterrupted)
				f35_arg0.BackgroundImage:registerEventHandler("transition_complete_keyframe", f35_arg0.clipFinished)
			end
			f35_arg0.BackgroundImage:completeAnimation()
			f35_arg0.BackgroundImage:setAlpha(0)
			f35_local1(f35_arg0.BackgroundImage)
			local f35_local2 = function(f38_arg0)
				f35_arg0.FramingCornerBrackets:beginAnimation(1000)
				f35_arg0.FramingCornerBrackets:setAlpha(0.1)
				f35_arg0.FramingCornerBrackets:registerEventHandler("interrupted_keyframe", f35_arg0.clipInterrupted)
				f35_arg0.FramingCornerBrackets:registerEventHandler("transition_complete_keyframe", f35_arg0.clipFinished)
			end
			f35_arg0.FramingCornerBrackets:completeAnimation()
			f35_arg0.FramingCornerBrackets:setAlpha(0)
			f35_local2(f35_arg0.FramingCornerBrackets)
			local f35_local3 = function(f39_arg0)
				f35_arg0.NoiseTiledBackingRight:beginAnimation(1000)
				f35_arg0.NoiseTiledBackingRight:setAlpha(0.4)
				f35_arg0.NoiseTiledBackingRight:registerEventHandler("interrupted_keyframe", f35_arg0.clipInterrupted)
				f35_arg0.NoiseTiledBackingRight:registerEventHandler("transition_complete_keyframe", f35_arg0.clipFinished)
			end
			f35_arg0.NoiseTiledBackingRight:completeAnimation()
			f35_arg0.NoiseTiledBackingRight:setAlpha(0)
			f35_local3(f35_arg0.NoiseTiledBackingRight)
			local f35_local4 = function(f40_arg0)
				f35_arg0.DottedLineBtm:beginAnimation(1000)
				f35_arg0.DottedLineBtm:setAlpha(0.35)
				f35_arg0.DottedLineBtm:registerEventHandler("interrupted_keyframe", f35_arg0.clipInterrupted)
				f35_arg0.DottedLineBtm:registerEventHandler("transition_complete_keyframe", f35_arg0.clipFinished)
			end
			f35_arg0.DottedLineBtm:completeAnimation()
			f35_arg0.DottedLineBtm:setAlpha(0)
			f35_local4(f35_arg0.DottedLineBtm)
			local f35_local5 = function(f41_arg0)
				f35_arg0.DottedLineTop:beginAnimation(1000)
				f35_arg0.DottedLineTop:setAlpha(0.35)
				f35_arg0.DottedLineTop:registerEventHandler("interrupted_keyframe", f35_arg0.clipInterrupted)
				f35_arg0.DottedLineTop:registerEventHandler("transition_complete_keyframe", f35_arg0.clipFinished)
			end
			f35_arg0.DottedLineTop:completeAnimation()
			f35_arg0.DottedLineTop:setAlpha(0)
			f35_local5(f35_arg0.DottedLineTop)
			local f35_local6 = function(f42_arg0)
				f35_arg0.GenericMenuFrameIdentity:beginAnimation(1000)
				f35_arg0.GenericMenuFrameIdentity:setAlpha(1)
				f35_arg0.GenericMenuFrameIdentity:registerEventHandler("interrupted_keyframe", f35_arg0.clipInterrupted)
				f35_arg0.GenericMenuFrameIdentity:registerEventHandler("transition_complete_keyframe", f35_arg0.clipFinished)
			end
			f35_arg0.GenericMenuFrameIdentity:completeAnimation()
			f35_arg0.GenericMenuFrameIdentity:setAlpha(0)
			f35_local6(f35_arg0.GenericMenuFrameIdentity)
			f35_arg0.ReservesReroll:completeAnimation()
			f35_arg0.ReservesReroll:setAlpha(0)
			f35_arg0.clipFinished(f35_arg0.ReservesReroll)
			f35_arg0.DupeMeter:completeAnimation()
			f35_arg0.DupeMeter:setAlpha(0)
			f35_arg0.clipFinished(f35_arg0.DupeMeter)
		end,
	},
	Rolling = {
		DefaultClip = function(f43_arg0, f43_arg1)
			f43_arg0:__resetProperties()
			f43_arg0:setupElementClipCounter(9)
			f43_arg0.backing:completeAnimation()
			f43_arg0.backing:setAlpha(1)
			f43_arg0.clipFinished(f43_arg0.backing)
			f43_arg0.BackgroundImage:completeAnimation()
			f43_arg0.BackgroundImage:setAlpha(0.85)
			f43_arg0.clipFinished(f43_arg0.BackgroundImage)
			f43_arg0.FramingCornerBrackets:completeAnimation()
			f43_arg0.FramingCornerBrackets:setAlpha(0.1)
			f43_arg0.clipFinished(f43_arg0.FramingCornerBrackets)
			f43_arg0.NoiseTiledBackingRight:completeAnimation()
			f43_arg0.NoiseTiledBackingRight:setAlpha(0.4)
			f43_arg0.clipFinished(f43_arg0.NoiseTiledBackingRight)
			f43_arg0.DottedLineBtm:completeAnimation()
			f43_arg0.DottedLineBtm:setAlpha(0.35)
			f43_arg0.clipFinished(f43_arg0.DottedLineBtm)
			f43_arg0.DottedLineTop:completeAnimation()
			f43_arg0.DottedLineTop:setAlpha(0.35)
			f43_arg0.clipFinished(f43_arg0.DottedLineTop)
			f43_arg0.GenericMenuFrameIdentity:completeAnimation()
			f43_arg0.GenericMenuFrameIdentity:setAlpha(1)
			f43_arg0.clipFinished(f43_arg0.GenericMenuFrameIdentity)
			f43_arg0.ReservesReroll:completeAnimation()
			f43_arg0.ReservesReroll:setAlpha(0)
			f43_arg0.clipFinished(f43_arg0.ReservesReroll)
			f43_arg0.DupeMeter:completeAnimation()
			f43_arg0.DupeMeter:setAlpha(0)
			f43_arg0.clipFinished(f43_arg0.DupeMeter)
		end,
	},
	Results = {
		DefaultClip = function(f44_arg0, f44_arg1)
			f44_arg0:__resetProperties()
			f44_arg0:setupElementClipCounter(9)
			f44_arg0.backing:completeAnimation()
			f44_arg0.backing:setAlpha(1)
			f44_arg0.clipFinished(f44_arg0.backing)
			f44_arg0.BackgroundImage:completeAnimation()
			f44_arg0.BackgroundImage:setAlpha(0.85)
			f44_arg0.clipFinished(f44_arg0.BackgroundImage)
			f44_arg0.FramingCornerBrackets:completeAnimation()
			f44_arg0.FramingCornerBrackets:setAlpha(0.1)
			f44_arg0.clipFinished(f44_arg0.FramingCornerBrackets)
			f44_arg0.NoiseTiledBackingRight:completeAnimation()
			f44_arg0.NoiseTiledBackingRight:setAlpha(0.4)
			f44_arg0.clipFinished(f44_arg0.NoiseTiledBackingRight)
			f44_arg0.DottedLineBtm:completeAnimation()
			f44_arg0.DottedLineBtm:setAlpha(0.35)
			f44_arg0.clipFinished(f44_arg0.DottedLineBtm)
			f44_arg0.DottedLineTop:completeAnimation()
			f44_arg0.DottedLineTop:setAlpha(0.35)
			f44_arg0.clipFinished(f44_arg0.DottedLineTop)
			f44_arg0.GenericMenuFrameIdentity:completeAnimation()
			f44_arg0.GenericMenuFrameIdentity:setAlpha(1)
			f44_arg0.clipFinished(f44_arg0.GenericMenuFrameIdentity)
			f44_arg0.ReservesReroll:completeAnimation()
			f44_arg0.ReservesReroll:setAlpha(0)
			f44_arg0.clipFinished(f44_arg0.ReservesReroll)
			f44_arg0.DupeMeter:completeAnimation()
			f44_arg0.DupeMeter:setAlpha(0)
			f44_arg0.clipFinished(f44_arg0.DupeMeter)
		end,
		Reroll = function(f45_arg0, f45_arg1)
			f45_arg0:__resetProperties()
			f45_arg0:setupElementClipCounter(2)
			local f45_local0 = function(f46_arg0)
				f45_arg0.ReservesReroll:beginAnimation(200)
				f45_arg0.ReservesReroll:setAlpha(1)
				f45_arg0.ReservesReroll:registerEventHandler("interrupted_keyframe", f45_arg0.clipInterrupted)
				f45_arg0.ReservesReroll:registerEventHandler("transition_complete_keyframe", f45_arg0.clipFinished)
			end
			f45_arg0.ReservesReroll:completeAnimation()
			f45_arg0.ReservesReroll:setAlpha(0)
			f45_local0(f45_arg0.ReservesReroll)
			local f45_local1 = function(f47_arg0)
				f45_arg0.DupeMeter:beginAnimation(200)
				f45_arg0.DupeMeter:setAlpha(1)
				f45_arg0.DupeMeter:registerEventHandler("interrupted_keyframe", f45_arg0.clipInterrupted)
				f45_arg0.DupeMeter:registerEventHandler("transition_complete_keyframe", f45_arg0.clipFinished)
			end
			f45_arg0.DupeMeter:completeAnimation()
			f45_arg0.DupeMeter:setAlpha(0)
			f45_local1(f45_arg0.DupeMeter)
		end,
	},
	Reroll = {
		DefaultClip = function(f48_arg0, f48_arg1)
			f48_arg0:__resetProperties()
			f48_arg0:setupElementClipCounter(0)
		end,
	},
}
CoD.BlackjackReserveReveal.__onClose = function(f49_arg0)
	f49_arg0.FramingCornerBrackets:close()
	f49_arg0.GenericMenuFrameIdentity:close()
	f49_arg0.ReservesReroll:close()
	f49_arg0.DupeMeter:close()
	f49_arg0.SkipRevealPrompt:close()
	f49_arg0.RevealList:close()
end
