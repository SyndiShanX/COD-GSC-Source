require("x64:db806626fb64f10")
require("x64:f027dcc6409e42c")
CoD.PostSeasonPopup = InheritFrom(CoD.Menu)
LUI.createMenu.PostSeasonPopup = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("PostSeasonPopup", f1_arg0)
	local f1_local1 = self
	CoD.BaseUtility.SetPropertiesFromUserData(self, f1_arg1)
	self:setClass(CoD.PostSeasonPopup)
	self.soundSet = "none"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	f1_local1:addElementToPendingUpdateStateList(self)
	local BgBlur = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	BgBlur:setRGB(0, 0, 0)
	BgBlur:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_E2354BE557C4C7A"))
	BgBlur:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(BgBlur)
	self.BgBlur = BgBlur
	local Background = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Background:setRGB(0, 0, 0)
	Background:setAlpha(0.8)
	self:addElement(Background)
	self.Background = Background
	local Banner = LUI.UIImage.new(0.5, 0.5, -960, 960, 0.5, 0.5, -228, 228)
	Banner:setImage(RegisterImage(CoD.BlackMarketUtility.GetSeasonCompleteImage()))
	self:addElement(Banner)
	self.Banner = Banner
	local BannerAdd = LUI.UIImage.new(0.5, 0.5, -960, 960, 0.5, 0.5, -228, 228)
	BannerAdd:setImage(RegisterImage(CoD.BlackMarketUtility.GetSeasonCompleteImage()))
	BannerAdd:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(BannerAdd)
	self.BannerAdd = BannerAdd
	local Message = LUI.UIText.new(0.5, 0.5, -619, 619, 0.5, 0.5, 118, 148)
	Message:setRGB(CoD.BlackMarketUtility.GetSeasonCompleteMessageColor())
	Message:setText(Engine[@"hash_4F9F1239CFD921FE"](CoD.BlackMarketUtility.GetSeasonCompleteMessage()))
	Message:setTTF("ttmussels_regular")
	Message:setLetterSpacing(2)
	Message:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	Message:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(Message)
	self.Message = Message
	local CongratText = LUI.UIText.new(0.5, 0.5, -850, 850, 0.5, 0.5, 38, 92)
	CongratText:setRGB(0, 0.82, 1)
	CongratText:setText(Engine[@"hash_4F9F1239CFD921FE"](CoD.BlackMarketUtility.GetSeasonCompleteTitle(@"hash_7855929179B1E1C8")))
	CongratText:setTTF("dinnext_regular")
	CongratText:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_90D57B1E92D39D7"))
	CongratText:setShaderVector(0, 1, 0, 0, 0)
	CongratText:setShaderVector(1, 0, 0, 0, 0)
	CongratText:setShaderVector(2, 0, 0.2, 0.75, 1)
	CongratText:setLetterSpacing(8)
	CongratText:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	CongratText:setAlignment(Enum[@"luialignment"][@"lui_alignment_bottom"])
	self:addElement(CongratText)
	self.CongratText = CongratText
	local GenericMenuFrameIdentity = CoD.GenericMenuFrameIdentity.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	GenericMenuFrameIdentity.CommonHeader.subtitle.StageTitle:setText(LocalizeToUpperString(@"menu/black_market"))
	GenericMenuFrameIdentity:subscribeToGlobalModel(f1_arg0, "LobbyRoot", "lobbyTitle", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			GenericMenuFrameIdentity.CommonHeader.subtitle.subtitle:setText(Engine[@"hash_4F9F1239CFD921FE"](f2_local0))
		end
	end)
	self:addElement(GenericMenuFrameIdentity)
	self.GenericMenuFrameIdentity = GenericMenuFrameIdentity
	local PCButton = nil
	PCButton = CoD.PC_MOTD_Buttons.new(f1_local1, f1_arg0, 0.5, 0.5, -632.5, -392.5, 1, 1, -167.5, -87.5)
	PCButton.OptionText:setText(LocalizeToUpperString(@"menu/continue"))
	PCButton:linkToElementModel(self, "image", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			PCButton.Icon:setImage(RegisterImage(f3_local0))
		end
	end)
	PCButton:registerEventHandler("gain_focus", function(element, event)
		local f4_local0 = nil
		if element.gainFocus then
			f4_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f4_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f4_local0
	end)
	f1_local1:AddButtonCallbackFunction(PCButton, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function(element, menu, controller, model)
		GoBack(self, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_0", nil, "ui_confirm")
		return false
	end, false)
	self:addElement(PCButton)
	self.PCButton = PCButton
	self:registerEventHandler("occlusion_change", function(self, event)
		local f7_local0 = nil
		if self.OcclusionChange then
			f7_local0 = self:OcclusionChange(event)
		elseif self.super.OcclusionChange then
			f7_local0 = self.super:OcclusionChange(event)
		end
		if not CoD.BlackMarketUtility.IsMenuOccluded(f1_local1) then
			GoBack(self, f1_arg0)
		end
		if not f7_local0 then
			f7_local0 = self:dispatchEventToChildren(event)
		end
		return f7_local0
	end)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"], nil, function(element, menu, controller, model)
		if PropertyIsTrue(self, "goBackMultiple") then
			PlaySoundAlias("uin_press_generic")
			GoBackMultiple(menu, controller, 2)
			return true
		else
			PlaySoundAlias("uin_press_generic")
			GoBack(self, controller)
			return true
		end
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/continue", nil, nil)
		return true
	end, false)
	GenericMenuFrameIdentity:setModel(self.buttonModel, f1_arg0)
	GenericMenuFrameIdentity.id = "GenericMenuFrameIdentity"
	if CoD.isPC then
		PCButton.id = "PCButton"
	end
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	local f1_local10 = self
	PlaySoundAlias("Uin_cac_scorestreak_sniper_heli")
	return self
end
CoD.PostSeasonPopup.__resetProperties = function(f10_arg0)
	f10_arg0.Background:completeAnimation()
	f10_arg0.Banner:completeAnimation()
	f10_arg0.CongratText:completeAnimation()
	f10_arg0.Message:completeAnimation()
	f10_arg0.BannerAdd:completeAnimation()
	f10_arg0.Background:setAlpha(0.8)
	f10_arg0.Banner:setAlpha(1)
	f10_arg0.CongratText:setAlpha(1)
	f10_arg0.CongratText:setScale(1, 1)
	f10_arg0.Message:setAlpha(1)
	f10_arg0.BannerAdd:setAlpha(1)
end
CoD.PostSeasonPopup.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(5)
			local f11_local0 = function(f12_arg0)
				f11_arg0.Background:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_out"])
				f11_arg0.Background:setAlpha(0.8)
				f11_arg0.Background:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.Background:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
			end
			f11_arg0.Background:completeAnimation()
			f11_arg0.Background:setAlpha(0)
			f11_local0(f11_arg0.Background)
			local f11_local1 = function(f13_arg0)
				local f13_local0 = function(f14_arg0)
					f14_arg0:beginAnimation(199, Enum[@"luitween"][@"luitween_ease_both"])
					f14_arg0:setAlpha(1)
					f14_arg0:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
				end
				f11_arg0.Banner:beginAnimation(300)
				f11_arg0.Banner:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.Banner:registerEventHandler("transition_complete_keyframe", f13_local0)
			end
			f11_arg0.Banner:completeAnimation()
			f11_arg0.Banner:setAlpha(0)
			f11_local1(f11_arg0.Banner)
			local f11_local2 = function(f15_arg0)
				local f15_local0 = function(f16_arg0)
					local f16_local0 = function(f17_arg0)
						local f17_local0 = function(f18_arg0)
							f18_arg0:beginAnimation(200)
							f18_arg0:setAlpha(0.1)
							f18_arg0:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
						end
						f17_arg0:beginAnimation(199)
						f17_arg0:registerEventHandler("transition_complete_keyframe", f17_local0)
					end
					f16_arg0:beginAnimation(199)
					f16_arg0:setAlpha(0.4)
					f16_arg0:registerEventHandler("transition_complete_keyframe", f16_local0)
				end
				f11_arg0.BannerAdd:beginAnimation(500)
				f11_arg0.BannerAdd:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.BannerAdd:registerEventHandler("transition_complete_keyframe", f15_local0)
			end
			f11_arg0.BannerAdd:completeAnimation()
			f11_arg0.BannerAdd:setAlpha(0)
			f11_local2(f11_arg0.BannerAdd)
			local f11_local3 = function(f19_arg0)
				local f19_local0 = function(f20_arg0)
					local f20_local0 = function(f21_arg0)
						f21_arg0:beginAnimation(399)
						f21_arg0:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
					end
					f20_arg0:beginAnimation(500, Enum[@"luitween"][@"luitween_ease_out"])
					f20_arg0:setAlpha(1)
					f20_arg0:registerEventHandler("transition_complete_keyframe", f20_local0)
				end
				f11_arg0.Message:beginAnimation(1100)
				f11_arg0.Message:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.Message:registerEventHandler("transition_complete_keyframe", f19_local0)
			end
			f11_arg0.Message:completeAnimation()
			f11_arg0.Message:setAlpha(0)
			f11_local3(f11_arg0.Message)
			local f11_local4 = function(f22_arg0)
				local f22_local0 = function(f23_arg0)
					local f23_local0 = function(f24_arg0)
						local f24_local0 = function(f25_arg0)
							local f25_local0 = function(f26_arg0)
								f26_arg0:beginAnimation(19)
								f26_arg0:setScale(1, 1)
								f26_arg0:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
							end
							f25_arg0:beginAnimation(19)
							f25_arg0:setScale(0.97, 0.97)
							f25_arg0:registerEventHandler("transition_complete_keyframe", f25_local0)
						end
						f24_arg0:beginAnimation(20)
						f24_arg0:setScale(1.04, 1.04)
						f24_arg0:registerEventHandler("transition_complete_keyframe", f24_local0)
					end
					f23_arg0:beginAnimation(99, Enum[@"luitween"][@"luitween_ease_out"])
					f23_arg0:setAlpha(1)
					f23_arg0:setScale(0.94, 0.94)
					f23_arg0:registerEventHandler("transition_complete_keyframe", f23_local0)
				end
				f11_arg0.CongratText:beginAnimation(480)
				f11_arg0.CongratText:setScale(4.5, 4.5)
				f11_arg0.CongratText:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.CongratText:registerEventHandler("transition_complete_keyframe", f22_local0)
			end
			f11_arg0.CongratText:completeAnimation()
			f11_arg0.CongratText:setAlpha(0)
			f11_arg0.CongratText:setScale(5, 5)
			f11_local4(f11_arg0.CongratText)
		end,
	},
}
CoD.PostSeasonPopup.__onClose = function(f27_arg0)
	f27_arg0.GenericMenuFrameIdentity:close()
	f27_arg0.PCButton:close()
end
