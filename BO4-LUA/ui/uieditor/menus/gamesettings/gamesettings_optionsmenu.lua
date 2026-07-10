require("x64:2675595fa323085")
require("x64:413987f664adb29")
require("x64:4ef91bc306473ff")
CoD.GameSettings_OptionsMenu = InheritFrom(CoD.Menu)
LUI.createMenu.GameSettings_OptionsMenu = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("GameSettings_OptionsMenu", f1_arg0)
	local f1_local1 = self
	self:setClass(CoD.GameSettings_OptionsMenu)
	self.soundSet = "default"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	f1_local1:addElementToPendingUpdateStateList(self)
	local Blackfade = LUI.UIImage.new(0, 1, -393, 17, 0, 0, 0, 1080)
	Blackfade:setRGB(0, 0, 0)
	Blackfade:setAlpha(0.35)
	self:addElement(Blackfade)
	self.Blackfade = Blackfade
	local leftBackground = LUI.UIImage.new(1, 1, -532, 0, 0, 1, 0, 0)
	leftBackground:setRGB(0.04, 0.04, 0.04)
	leftBackground:setAlpha(0.98)
	self:addElement(leftBackground)
	self.leftBackground = leftBackground
	local GameSettingsOptionsContainer0 = CoD.GameSettings_OptionsContainer.new(f1_local1, f1_arg0, 1, 1, -544, 0, 0, 0, 0, 1080)
	GameSettingsOptionsContainer0:registerEventHandler("gain_focus", function(element, event)
		local f2_local0 = nil
		if element.gainFocus then
			f2_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f2_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xbb_pscircle"])
		return f2_local0
	end)
	f1_local1:AddButtonCallbackFunction(GameSettingsOptionsContainer0, f1_arg0, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], nil, function(element, menu, controller, model)
		GoBack(self, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], @"menu/back", nil, nil)
		return true
	end, false)
	self:addElement(GameSettingsOptionsContainer0)
	self.GameSettingsOptionsContainer0 = GameSettingsOptionsContainer0
	local tileTexture = LUI.UIImage.new(1, 1, -533, 4, 0, 1, 0, 0)
	tileTexture:setAlpha(0.5)
	tileTexture:setImage(RegisterImage(@"uie_t7_tile_texture"))
	tileTexture:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_tile_scroll"))
	tileTexture:setShaderVector(0, 30, 55, 0, 0)
	tileTexture:setShaderVector(1, 0, 0, 0, 0)
	self:addElement(tileTexture)
	self.tileTexture = tileTexture
	local fefooterRighSlideIn = CoD.fe_footerRighSlideIn.new(f1_local1, f1_arg0, 1, 1, -696, -48, 1, 1, -112, -64)
	self:addElement(fefooterRighSlideIn)
	self.fefooterRighSlideIn = fefooterRighSlideIn
	local emptyFocusable = CoD.emptyFocusable.new(f1_local1, f1_arg0, 0, 0, -393, 1387, 0, 0, 0, 1080)
	emptyFocusable:registerEventHandler("gain_focus", function(element, event)
		local f5_local0 = nil
		if element.gainFocus then
			f5_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f5_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_none"])
		return f5_local0
	end)
	f1_local1:AddButtonCallbackFunction(emptyFocusable, f1_arg0, Enum[@"luibutton"][@"lui_key_none"], "MOUSE1", function(element, menu, controller, model)
		if not IsRepeatButtonPress(model) then
			GoBack(self, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if not IsRepeatButtonPress(nil) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_none"], @"hash_0", nil, "MOUSE1")
			return false
		else
			return false
		end
	end, false)
	self:addElement(emptyFocusable)
	self.emptyFocusable = emptyFocusable
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_start"], "ui_contextual_1", function(element, menu, controller, model)
		GoBack(self, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_start"], @"hash_0", nil, "ui_contextual_1")
		return false
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], "ESCAPE", function(element, menu, controller, model)
		if IsPC() then
			GoBack(self, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsPC() then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], @"menu/back", nil, "ESCAPE")
			return true
		else
			return false
		end
	end, false)
	GameSettingsOptionsContainer0.id = "GameSettingsOptionsContainer0"
	fefooterRighSlideIn.buttons:setModel(self.buttonModel, f1_arg0)
	if CoD.isPC then
		fefooterRighSlideIn.id = "fefooterRighSlideIn"
	end
	emptyFocusable.id = "emptyFocusable"
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	self.__defaultFocus = GameSettingsOptionsContainer0
	if CoD.isPC and (IsKeyboard(f1_arg0) or self.ignoreCursor) then
		self:restoreState(f1_arg0)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	return self
end
CoD.GameSettings_OptionsMenu.__resetProperties = function(f12_arg0)
	f12_arg0.emptyFocusable:completeAnimation()
	f12_arg0.fefooterRighSlideIn:completeAnimation()
	f12_arg0.tileTexture:completeAnimation()
	f12_arg0.GameSettingsOptionsContainer0:completeAnimation()
	f12_arg0.leftBackground:completeAnimation()
	f12_arg0.Blackfade:completeAnimation()
	f12_arg0.emptyFocusable:setLeftRight(0, 0, -393, 1387)
	f12_arg0.emptyFocusable:setTopBottom(0, 0, 0, 1080)
	f12_arg0.emptyFocusable:setAlpha(1)
	f12_arg0.fefooterRighSlideIn:setLeftRight(1, 1, -696, -48)
	f12_arg0.fefooterRighSlideIn:setTopBottom(1, 1, -112, -64)
	f12_arg0.fefooterRighSlideIn:setAlpha(1)
	f12_arg0.tileTexture:setLeftRight(1, 1, -533, 4)
	f12_arg0.tileTexture:setTopBottom(0, 1, 0, 0)
	f12_arg0.tileTexture:setAlpha(0.5)
	f12_arg0.GameSettingsOptionsContainer0:setLeftRight(1, 1, -544, 0)
	f12_arg0.GameSettingsOptionsContainer0:setTopBottom(0, 0, 0, 1080)
	f12_arg0.GameSettingsOptionsContainer0:setAlpha(1)
	f12_arg0.leftBackground:setLeftRight(1, 1, -532, 0)
	f12_arg0.leftBackground:setTopBottom(0, 1, 0, 0)
	f12_arg0.leftBackground:setAlpha(0.98)
	f12_arg0.Blackfade:setLeftRight(0, 1, -393, 17)
	f12_arg0.Blackfade:setTopBottom(0, 0, 0, 1080)
	f12_arg0.Blackfade:setAlpha(0.35)
end
CoD.GameSettings_OptionsMenu.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(0)
		end,
		Intro = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(6)
			local f14_local0 = function(f15_arg0)
				f14_arg0.Blackfade:beginAnimation(150)
				f14_arg0.Blackfade:setLeftRight(0, 1, -393, 17)
				f14_arg0.Blackfade:setAlpha(0.35)
				f14_arg0.Blackfade:registerEventHandler("interrupted_keyframe", f14_arg0.clipInterrupted)
				f14_arg0.Blackfade:registerEventHandler("transition_complete_keyframe", f14_arg0.clipFinished)
			end
			f14_arg0.Blackfade:completeAnimation()
			f14_arg0.Blackfade:setLeftRight(0.19, 1.19, -393, 17)
			f14_arg0.Blackfade:setTopBottom(0, 0, 0, 1080)
			f14_arg0.Blackfade:setAlpha(0)
			f14_local0(f14_arg0.Blackfade)
			local f14_local1 = function(f16_arg0)
				f14_arg0.leftBackground:beginAnimation(150)
				f14_arg0.leftBackground:setLeftRight(1, 1, -532, 0)
				f14_arg0.leftBackground:setAlpha(0.98)
				f14_arg0.leftBackground:registerEventHandler("interrupted_keyframe", f14_arg0.clipInterrupted)
				f14_arg0.leftBackground:registerEventHandler("transition_complete_keyframe", f14_arg0.clipFinished)
			end
			f14_arg0.leftBackground:completeAnimation()
			f14_arg0.leftBackground:setLeftRight(1, 1, -160, 372)
			f14_arg0.leftBackground:setTopBottom(0, 1, 0, 0)
			f14_arg0.leftBackground:setAlpha(0)
			f14_local1(f14_arg0.leftBackground)
			local f14_local2 = function(f17_arg0)
				f14_arg0.GameSettingsOptionsContainer0:beginAnimation(150)
				f14_arg0.GameSettingsOptionsContainer0:setLeftRight(1, 1, -544, 0)
				f14_arg0.GameSettingsOptionsContainer0:setAlpha(1)
				f14_arg0.GameSettingsOptionsContainer0:registerEventHandler("interrupted_keyframe", f14_arg0.clipInterrupted)
				f14_arg0.GameSettingsOptionsContainer0:registerEventHandler("transition_complete_keyframe", f14_arg0.clipFinished)
			end
			f14_arg0.GameSettingsOptionsContainer0:completeAnimation()
			f14_arg0.GameSettingsOptionsContainer0:setLeftRight(1, 1, -172, 372)
			f14_arg0.GameSettingsOptionsContainer0:setTopBottom(0, 0, 0, 1080)
			f14_arg0.GameSettingsOptionsContainer0:setAlpha(0)
			f14_local2(f14_arg0.GameSettingsOptionsContainer0)
			local f14_local3 = function(f18_arg0)
				f14_arg0.tileTexture:beginAnimation(150)
				f14_arg0.tileTexture:setLeftRight(1, 1, -533, 4)
				f14_arg0.tileTexture:setAlpha(0.5)
				f14_arg0.tileTexture:registerEventHandler("interrupted_keyframe", f14_arg0.clipInterrupted)
				f14_arg0.tileTexture:registerEventHandler("transition_complete_keyframe", f14_arg0.clipFinished)
			end
			f14_arg0.tileTexture:completeAnimation()
			f14_arg0.tileTexture:setLeftRight(1, 1, -161, 376)
			f14_arg0.tileTexture:setTopBottom(0, 1, 0, 0)
			f14_arg0.tileTexture:setAlpha(0)
			f14_local3(f14_arg0.tileTexture)
			local f14_local4 = function(f19_arg0)
				f14_arg0.fefooterRighSlideIn:beginAnimation(150)
				f14_arg0.fefooterRighSlideIn:setLeftRight(1, 1, -696, -48)
				f14_arg0.fefooterRighSlideIn:setAlpha(1)
				f14_arg0.fefooterRighSlideIn:registerEventHandler("interrupted_keyframe", f14_arg0.clipInterrupted)
				f14_arg0.fefooterRighSlideIn:registerEventHandler("transition_complete_keyframe", f14_arg0.clipFinished)
			end
			f14_arg0.fefooterRighSlideIn:completeAnimation()
			f14_arg0.fefooterRighSlideIn:setLeftRight(1, 1, -324, 324)
			f14_arg0.fefooterRighSlideIn:setTopBottom(1, 1, -112, -64)
			f14_arg0.fefooterRighSlideIn:setAlpha(0)
			f14_local4(f14_arg0.fefooterRighSlideIn)
			local f14_local5 = function(f20_arg0)
				f14_arg0.emptyFocusable:beginAnimation(150)
				f14_arg0.emptyFocusable:setLeftRight(0, 0, -393, 1387)
				f14_arg0.emptyFocusable:setAlpha(1)
				f14_arg0.emptyFocusable:registerEventHandler("interrupted_keyframe", f14_arg0.clipInterrupted)
				f14_arg0.emptyFocusable:registerEventHandler("transition_complete_keyframe", f14_arg0.clipFinished)
			end
			f14_arg0.emptyFocusable:completeAnimation()
			f14_arg0.emptyFocusable:setLeftRight(0, 0, -21, 1759)
			f14_arg0.emptyFocusable:setTopBottom(0, 0, 0, 1080)
			f14_arg0.emptyFocusable:setAlpha(0)
			f14_local5(f14_arg0.emptyFocusable)
		end,
	},
}
CoD.GameSettings_OptionsMenu.__onClose = function(f21_arg0)
	f21_arg0.GameSettingsOptionsContainer0:close()
	f21_arg0.fefooterRighSlideIn:close()
	f21_arg0.emptyFocusable:close()
end
