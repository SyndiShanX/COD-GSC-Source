require("x64:db806626fb64f10")
require("x64:f027dcc6409e42c")
CoD.AllRNGPopup = InheritFrom(CoD.Menu)
LUI.createMenu.AllRNGPopup = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("AllRNGPopup", f1_arg0)
	local f1_local1 = self
	CoD.BaseUtility.SetPropertiesFromUserData(self, f1_arg1)
	self:setClass(CoD.AllRNGPopup)
	self.soundSet = "none"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	f1_local1:addElementToPendingUpdateStateList(self)
	local BgBlur = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	BgBlur:setRGB(0, 0, 0)
	BgBlur:setMaterial(LUI.UIImage.GetCachedMaterial(0xE2354BE557C4C7A))
	BgBlur:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(BgBlur)
	self.BgBlur = BgBlur
	local Background = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Background:setRGB(0, 0, 0)
	Background:setAlpha(0.8)
	self:addElement(Background)
	self.Background = Background
	local Banner = LUI.UIImage.new(0.5, 0.5, -960, 960, 0.5, 0.5, -190, 190)
	Banner:setImage(RegisterImage(0x1B35139AF5FC958))
	self:addElement(Banner)
	self.Banner = Banner
	local BannerAdd = LUI.UIImage.new(0.5, 0.5, -960, 960, 0.5, 0.5, -190, 190)
	BannerAdd:setImage(RegisterImage(0x1B35139AF5FC958))
	BannerAdd:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(BannerAdd)
	self.BannerAdd = BannerAdd
	local Message = LUI.UIText.new(0.5, 0.5, -619, 619, 0.5, 0.5, 89, 119)
	Message:setRGB(0.92, 0.92, 0.92)
	Message:setText(Engine[0xF9F1239CFD921FE](0xA2536C60411E11C))
	Message:setTTF("ttmussels_regular")
	Message:setLetterSpacing(2)
	Message:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	Message:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(Message)
	self.Message = Message
	local CompleteText = LUI.UIText.new(0.5, 0.5, -750, 750, 0.5, 0.5, 9, 63)
	CompleteText:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	CompleteText:setText(Engine[0xF9F1239CFD921FE](0x63075DE006C879D))
	CompleteText:setTTF("dinnext_regular")
	CompleteText:setLetterSpacing(8)
	CompleteText:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	self:addElement(CompleteText)
	self.CompleteText = CompleteText
	local GenericMenuFrameIdentity = CoD.GenericMenuFrameIdentity.new(f1_local1, f1_arg0, 0.5, 0.5, -960, 960, 0, 1, 0, 0)
	GenericMenuFrameIdentity.CommonHeader.subtitle.StageTitle:setText(LocalizeToUpperString(0x29C903C6DF90D6F))
	GenericMenuFrameIdentity:subscribeToGlobalModel(f1_arg0, "LobbyRoot", "lobbyTitle", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			GenericMenuFrameIdentity.CommonHeader.subtitle.subtitle:setText(Engine[0xF9F1239CFD921FE](f2_local0))
		end
	end)
	self:addElement(GenericMenuFrameIdentity)
	self.GenericMenuFrameIdentity = GenericMenuFrameIdentity
	local PCButtons = nil
	PCButtons = CoD.PC_MOTD_Buttons.new(f1_local1, f1_arg0, 0.5, 0.5, -632.5, -392.5, 1, 1, -167.5, -87.5)
	PCButtons.OptionText:setText(LocalizeToUpperString(0x6393FF34EA56966))
	PCButtons:linkToElementModel(self, "image", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			PCButtons.Icon:setImage(RegisterImage(f3_local0))
		end
	end)
	PCButtons:registerEventHandler("gain_focus", function(element, event)
		local f4_local0 = nil
		if element.gainFocus then
			f4_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f4_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f4_local0
	end)
	f1_local1:AddButtonCallbackFunction(PCButtons, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], "ui_confirm", function(element, menu, controller, model)
		GoBack(self, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x0, nil, "ui_confirm")
		return false
	end, false)
	self:addElement(PCButtons)
	self.PCButtons = PCButtons
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], nil, function(element, menu, controller, model)
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
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x6393FF34EA56966, nil, nil)
		return true
	end, false)
	GenericMenuFrameIdentity:setModel(self.buttonModel, f1_arg0)
	GenericMenuFrameIdentity.id = "GenericMenuFrameIdentity"
	if CoD.isPC then
		PCButtons.id = "PCButtons"
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
	PlaySoundAlias("Uin_cac_attach_stabilizer")
	return self
end
CoD.AllRNGPopup.__resetProperties = function(f9_arg0)
	f9_arg0.Background:completeAnimation()
	f9_arg0.Banner:completeAnimation()
	f9_arg0.CompleteText:completeAnimation()
	f9_arg0.Message:completeAnimation()
	f9_arg0.BannerAdd:completeAnimation()
	f9_arg0.Background:setAlpha(0.8)
	f9_arg0.Banner:setAlpha(1)
	f9_arg0.CompleteText:setAlpha(1)
	f9_arg0.CompleteText:setScale(1, 1)
	f9_arg0.Message:setAlpha(1)
	f9_arg0.BannerAdd:setAlpha(1)
end
CoD.AllRNGPopup.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(5)
			local f10_local0 = function(f11_arg0)
				f10_arg0.Background:beginAnimation(200, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
				f10_arg0.Background:setAlpha(0.8)
				f10_arg0.Background:registerEventHandler("interrupted_keyframe", f10_arg0.clipInterrupted)
				f10_arg0.Background:registerEventHandler("transition_complete_keyframe", f10_arg0.clipFinished)
			end
			f10_arg0.Background:completeAnimation()
			f10_arg0.Background:setAlpha(0)
			f10_local0(f10_arg0.Background)
			local f10_local1 = function(f12_arg0)
				local f12_local0 = function(f13_arg0)
					f13_arg0:beginAnimation(199, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
					f13_arg0:setAlpha(1)
					f13_arg0:registerEventHandler("transition_complete_keyframe", f10_arg0.clipFinished)
				end
				f10_arg0.Banner:beginAnimation(300)
				f10_arg0.Banner:registerEventHandler("interrupted_keyframe", f10_arg0.clipInterrupted)
				f10_arg0.Banner:registerEventHandler("transition_complete_keyframe", f12_local0)
			end
			f10_arg0.Banner:completeAnimation()
			f10_arg0.Banner:setAlpha(0)
			f10_local1(f10_arg0.Banner)
			local f10_local2 = function(f14_arg0)
				local f14_local0 = function(f15_arg0)
					local f15_local0 = function(f16_arg0)
						local f16_local0 = function(f17_arg0)
							f17_arg0:beginAnimation(200)
							f17_arg0:setAlpha(0.1)
							f17_arg0:registerEventHandler("transition_complete_keyframe", f10_arg0.clipFinished)
						end
						f16_arg0:beginAnimation(199)
						f16_arg0:registerEventHandler("transition_complete_keyframe", f16_local0)
					end
					f15_arg0:beginAnimation(199)
					f15_arg0:setAlpha(0.4)
					f15_arg0:registerEventHandler("transition_complete_keyframe", f15_local0)
				end
				f10_arg0.BannerAdd:beginAnimation(500)
				f10_arg0.BannerAdd:registerEventHandler("interrupted_keyframe", f10_arg0.clipInterrupted)
				f10_arg0.BannerAdd:registerEventHandler("transition_complete_keyframe", f14_local0)
			end
			f10_arg0.BannerAdd:completeAnimation()
			f10_arg0.BannerAdd:setAlpha(0)
			f10_local2(f10_arg0.BannerAdd)
			local f10_local3 = function(f18_arg0)
				local f18_local0 = function(f19_arg0)
					local f19_local0 = function(f20_arg0)
						f20_arg0:beginAnimation(399)
						f20_arg0:registerEventHandler("transition_complete_keyframe", f10_arg0.clipFinished)
					end
					f19_arg0:beginAnimation(500, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
					f19_arg0:setAlpha(1)
					f19_arg0:registerEventHandler("transition_complete_keyframe", f19_local0)
				end
				f10_arg0.Message:beginAnimation(1100)
				f10_arg0.Message:registerEventHandler("interrupted_keyframe", f10_arg0.clipInterrupted)
				f10_arg0.Message:registerEventHandler("transition_complete_keyframe", f18_local0)
			end
			f10_arg0.Message:completeAnimation()
			f10_arg0.Message:setAlpha(0)
			f10_local3(f10_arg0.Message)
			local f10_local4 = function(f21_arg0)
				local f21_local0 = function(f22_arg0)
					local f22_local0 = function(f23_arg0)
						local f23_local0 = function(f24_arg0)
							local f24_local0 = function(f25_arg0)
								f25_arg0:beginAnimation(19)
								f25_arg0:setScale(1, 1)
								f25_arg0:registerEventHandler("transition_complete_keyframe", f10_arg0.clipFinished)
							end
							f24_arg0:beginAnimation(19)
							f24_arg0:setScale(0.97, 0.97)
							f24_arg0:registerEventHandler("transition_complete_keyframe", f24_local0)
						end
						f23_arg0:beginAnimation(20)
						f23_arg0:setScale(1.04, 1.04)
						f23_arg0:registerEventHandler("transition_complete_keyframe", f23_local0)
					end
					f22_arg0:beginAnimation(99, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
					f22_arg0:setAlpha(1)
					f22_arg0:setScale(0.94, 0.94)
					f22_arg0:registerEventHandler("transition_complete_keyframe", f22_local0)
				end
				f10_arg0.CompleteText:beginAnimation(480)
				f10_arg0.CompleteText:setScale(4.5, 4.5)
				f10_arg0.CompleteText:registerEventHandler("interrupted_keyframe", f10_arg0.clipInterrupted)
				f10_arg0.CompleteText:registerEventHandler("transition_complete_keyframe", f21_local0)
			end
			f10_arg0.CompleteText:completeAnimation()
			f10_arg0.CompleteText:setAlpha(0)
			f10_arg0.CompleteText:setScale(5, 5)
			f10_local4(f10_arg0.CompleteText)
		end,
	},
}
CoD.AllRNGPopup.__onClose = function(f26_arg0)
	f26_arg0.GenericMenuFrameIdentity:close()
	f26_arg0.PCButtons:close()
end
