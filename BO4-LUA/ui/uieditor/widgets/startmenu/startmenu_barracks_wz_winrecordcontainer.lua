require("x64:46728994d8c06c0")
require("x64:53c0405b8145697")
require("x64:fc4c3dc5d489f9b")
require("x64:c049b7a5f07c1e")
CoD.StartMenu_Barracks_WZ_WinRecordContainer = InheritFrom(LUI.UIElement)
CoD.StartMenu_Barracks_WZ_WinRecordContainer.__defaultWidth = 477
CoD.StartMenu_Barracks_WZ_WinRecordContainer.__defaultHeight = 677
CoD.StartMenu_Barracks_WZ_WinRecordContainer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.StartMenu_Barracks_WZ_WinRecordContainer)
	self.id = "StartMenu_Barracks_WZ_WinRecordContainer"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local BG = CoD.CommonDetailPanel02.new(f1_arg0, f1_arg1, 0, 0, 0, 477, 0, 0, 0, 678)
	BG.BackingBlur:setAlpha(0)
	BG.BackingTint:setAlpha(0.5)
	self:addElement(BG)
	self.BG = BG
	local QuadWins = CoD.StartMenu_Barracks_WZ_WinRecordWidget.new(f1_arg0, f1_arg1, 0, 0, 11, 468, 0, 0, 455, 667)
	QuadWins:mergeStateConditions({
		{
			stateName = "HideIcon",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalDataSourceModelValueEqualTo(f1_arg1, "BarrackWinsWZ", "quadWins", 0)
			end,
		},
	})
	local SoloWins = QuadWins
	local DuoWins = QuadWins.subscribeToModel
	local DotlineTop = DataSources.BarrackWinsWZ.getModel(f1_arg1)
	DuoWins(SoloWins, DotlineTop.quadWins, function(f3_arg0)
		f1_arg0:updateElementState(QuadWins, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f3_arg0:get(),
			modelName = "quadWins",
		})
	end, false)
	QuadWins.GametypeTitle:setText(LocalizeToUpperString(0x5BE69820FD79596))
	QuadWins:subscribeToGlobalModel(f1_arg1, "BarrackWinsWZ", "quadWins", function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			QuadWins.WinCount:setText(f4_local0)
		end
	end)
	QuadWins:subscribeToGlobalModel(f1_arg1, "BarrackWinsWZ", "quadWins", function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			QuadWins.ChallengeCoinIcon:setImage(RegisterImage(CoD.GameEndScoreUtility.GetChallengeCoinImageForWins(f5_local0)))
		end
	end)
	self:addElement(QuadWins)
	self.QuadWins = QuadWins
	DuoWins = CoD.StartMenu_Barracks_WZ_WinRecordWidget.new(f1_arg0, f1_arg1, 0, 0, 11, 468, 0, 0, 232.5, 444.5)
	DuoWins:mergeStateConditions({
		{
			stateName = "HideIcon",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalDataSourceModelValueEqualTo(f1_arg1, "BarrackWinsWZ", "duoWins", 0)
			end,
		},
	})
	DotlineTop = DuoWins
	SoloWins = DuoWins.subscribeToModel
	local DotlineBot = DataSources.BarrackWinsWZ.getModel(f1_arg1)
	SoloWins(DotlineTop, DotlineBot.duoWins, function(f7_arg0)
		f1_arg0:updateElementState(DuoWins, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f7_arg0:get(),
			modelName = "duoWins",
		})
	end, false)
	DuoWins.GametypeTitle:setText(LocalizeToUpperString(0x24D573075A30555))
	DuoWins:subscribeToGlobalModel(f1_arg1, "BarrackWinsWZ", "duoWins", function(model)
		local f8_local0 = model:get()
		if f8_local0 ~= nil then
			DuoWins.WinCount:setText(f8_local0)
		end
	end)
	DuoWins:subscribeToGlobalModel(f1_arg1, "BarrackWinsWZ", "duoWins", function(model)
		local f9_local0 = model:get()
		if f9_local0 ~= nil then
			DuoWins.ChallengeCoinIcon:setImage(RegisterImage(CoD.GameEndScoreUtility.GetChallengeCoinImageForWins(f9_local0)))
		end
	end)
	self:addElement(DuoWins)
	self.DuoWins = DuoWins
	SoloWins = CoD.StartMenu_Barracks_WZ_WinRecordWidget.new(f1_arg0, f1_arg1, 0, 0, 11, 468, 0, 0, 10.5, 224.5)
	SoloWins:mergeStateConditions({
		{
			stateName = "HideIcon",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalDataSourceModelValueEqualTo(f1_arg1, "BarrackWinsWZ", "soloWins", 0)
			end,
		},
	})
	DotlineBot = SoloWins
	DotlineTop = SoloWins.subscribeToModel
	local Medals = DataSources.BarrackWinsWZ.getModel(f1_arg1)
	DotlineTop(DotlineBot, Medals.soloWins, function(f11_arg0)
		f1_arg0:updateElementState(SoloWins, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f11_arg0:get(),
			modelName = "soloWins",
		})
	end, false)
	SoloWins.GametypeTitle:setText(LocalizeToUpperString(0xF40E0D95F95E04E))
	SoloWins:subscribeToGlobalModel(f1_arg1, "BarrackWinsWZ", "soloWins", function(model)
		local f12_local0 = model:get()
		if f12_local0 ~= nil then
			SoloWins.WinCount:setText(f12_local0)
		end
	end)
	SoloWins:subscribeToGlobalModel(f1_arg1, "BarrackWinsWZ", "soloWins", function(model)
		local f13_local0 = model:get()
		if f13_local0 ~= nil then
			SoloWins.ChallengeCoinIcon:setImage(RegisterImage(CoD.GameEndScoreUtility.GetChallengeCoinImageForWins(f13_local0)))
		end
	end)
	self:addElement(SoloWins)
	self.SoloWins = SoloWins
	DotlineTop = LUI.UIImage.new(0, 0, 8.5, 468.5, 0, 0, 224.5, 228.5)
	DotlineTop:setAlpha(0.2)
	DotlineTop:setImage(RegisterImage(0xF9C7F41C631866E))
	DotlineTop:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	DotlineTop:setShaderVector(0, 1.2, 0, 0, 0)
	self:addElement(DotlineTop)
	self.DotlineTop = DotlineTop
	DotlineBot = LUI.UIImage.new(0, 0, 8.5, 468.5, 0, 0, 446.5, 450.5)
	DotlineBot:setAlpha(0.2)
	DotlineBot:setImage(RegisterImage(0xF9C7F41C631866E))
	DotlineBot:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	DotlineBot:setShaderVector(0, 1.2, 0, 0, 0)
	self:addElement(DotlineBot)
	self.DotlineBot = DotlineBot
	Medals = CoD.StartMenu_Button_LG.new(f1_arg0, f1_arg1, 0.5, 0.5, -239, 239, 0.5, 0.5, 57, 335)
	Medals:setAlpha(0)
	Medals.ButtonInternal.ImageContainer.ImageContainer:setImage(RegisterImage(0xCB7B28E1ED13921))
	Medals.ButtonInternal.StartMenuButtonFrame:changeFrameWidget(CoD.ButtonFrame_MedalWZ)
	Medals.ButtonInternal.ButtonTitle.HeaderText:setText(LocalizeHash(0x8F69F5BDD4F7C26))
	Medals:subscribeToGlobalModel(f1_arg1, "PlayerShowcase", "medal", function(model)
		Medals.ButtonInternal.ButtonTitle.NewIcon:setModel(model, f1_arg1)
	end)
	Medals:registerEventHandler("gain_focus", function(element, event)
		local f15_local0 = nil
		if element.gainFocus then
			f15_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f15_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f15_local0
	end)
	f1_arg0:AddButtonCallbackFunction(Medals, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], "ui_confirm", function(element, menu, controller, model)
		if IsInDefaultState(element) then
			CoD.StartMenuUtility.OpenStartMenuOverlay(self, menu, controller, "Barracks_Medals")
			PlaySoundAlias("uin_toggle_generic")
			return true
		else
		end
	end, function(element, menu, controller)
		if IsInDefaultState(element) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, "ui_confirm")
			return true
		else
			return false
		end
	end, false)
	self:addElement(Medals)
	self.Medals = Medals
	self:mergeStateConditions({
		{
			stateName = "WZMedalsEnabled",
			condition = function(menu, element, event)
				return IsBooleanDvarSet("ui_wzMedalsEnabled")
			end,
		},
	})
	Medals.id = "Medals"
	self.__defaultFocus = Medals
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.StartMenu_Barracks_WZ_WinRecordContainer.__resetProperties = function(f19_arg0)
	f19_arg0.SoloWins:completeAnimation()
	f19_arg0.DuoWins:completeAnimation()
	f19_arg0.QuadWins:completeAnimation()
	f19_arg0.BG:completeAnimation()
	f19_arg0.DotlineTop:completeAnimation()
	f19_arg0.DotlineBot:completeAnimation()
	f19_arg0.Medals:completeAnimation()
	f19_arg0.SoloWins:setTopBottom(0, 0, 10.5, 224.5)
	f19_arg0.SoloWins.ChallengeCoinIcon:setScale(1, 1)
	f19_arg0.SoloWins.IconEmpty:setScale(1, 1)
	f19_arg0.DuoWins:setTopBottom(0, 0, 232.5, 444.5)
	f19_arg0.DuoWins.ChallengeCoinIcon:setScale(1, 1)
	f19_arg0.DuoWins.IconEmpty:setScale(1, 1)
	f19_arg0.QuadWins:setTopBottom(0, 0, 455, 667)
	f19_arg0.QuadWins.ChallengeCoinIcon:setScale(1, 1)
	f19_arg0.QuadWins.IconEmpty:setScale(1, 1)
	f19_arg0.BG:setTopBottom(0, 0, 0, 678)
	f19_arg0.DotlineTop:setTopBottom(0, 0, 224.5, 228.5)
	f19_arg0.DotlineBot:setTopBottom(0, 0, 446.5, 450.5)
	f19_arg0.Medals:setTopBottom(0.5, 0.5, 57, 335)
	f19_arg0.Medals:setAlpha(0)
end
CoD.StartMenu_Barracks_WZ_WinRecordContainer.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(0)
		end,
	},
	WZMedalsEnabled = {
		DefaultClip = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(7)
			f21_arg0.BG:completeAnimation()
			f21_arg0.BG:setTopBottom(0, 0, 0, 381)
			f21_arg0.clipFinished(f21_arg0.BG)
			f21_arg0.QuadWins:completeAnimation()
			f21_arg0.QuadWins.ChallengeCoinIcon:completeAnimation()
			f21_arg0.QuadWins.IconEmpty:completeAnimation()
			f21_arg0.QuadWins:setTopBottom(0, 0, 255, 369)
			f21_arg0.QuadWins.ChallengeCoinIcon:setScale(0.7, 0.7)
			f21_arg0.QuadWins.IconEmpty:setScale(0.7, 0.7)
			f21_arg0.clipFinished(f21_arg0.QuadWins)
			f21_arg0.DuoWins:completeAnimation()
			f21_arg0.DuoWins.ChallengeCoinIcon:completeAnimation()
			f21_arg0.DuoWins.IconEmpty:completeAnimation()
			f21_arg0.DuoWins:setTopBottom(0, 0, 132.5, 246.5)
			f21_arg0.DuoWins.ChallengeCoinIcon:setScale(0.7, 0.7)
			f21_arg0.DuoWins.IconEmpty:setScale(0.7, 0.7)
			f21_arg0.clipFinished(f21_arg0.DuoWins)
			f21_arg0.SoloWins:completeAnimation()
			f21_arg0.SoloWins.ChallengeCoinIcon:completeAnimation()
			f21_arg0.SoloWins.IconEmpty:completeAnimation()
			f21_arg0.SoloWins:setTopBottom(0, 0, 10.5, 124.5)
			f21_arg0.SoloWins.ChallengeCoinIcon:setScale(0.7, 0.7)
			f21_arg0.SoloWins.IconEmpty:setScale(0.7, 0.7)
			f21_arg0.clipFinished(f21_arg0.SoloWins)
			f21_arg0.DotlineTop:completeAnimation()
			f21_arg0.DotlineTop:setTopBottom(0, 0, 126.5, 130.5)
			f21_arg0.clipFinished(f21_arg0.DotlineTop)
			f21_arg0.DotlineBot:completeAnimation()
			f21_arg0.DotlineBot:setTopBottom(0, 0, 248.5, 252.5)
			f21_arg0.clipFinished(f21_arg0.DotlineBot)
			f21_arg0.Medals:completeAnimation()
			f21_arg0.Medals.ButtonInternal.StartMenuButtonFrame:completeAnimation()
			f21_arg0.Medals:setTopBottom(0.5, 0.5, 68, 338)
			f21_arg0.Medals:setAlpha(1)
			f21_arg0.clipFinished(f21_arg0.Medals)
		end,
		ChildFocus = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(7)
			f22_arg0.BG:completeAnimation()
			f22_arg0.BG:setTopBottom(0, 0, 0, 381)
			f22_arg0.clipFinished(f22_arg0.BG)
			f22_arg0.QuadWins:completeAnimation()
			f22_arg0.QuadWins.ChallengeCoinIcon:completeAnimation()
			f22_arg0.QuadWins.IconEmpty:completeAnimation()
			f22_arg0.QuadWins:setTopBottom(0, 0, 255, 369)
			f22_arg0.QuadWins.ChallengeCoinIcon:setScale(0.7, 0.7)
			f22_arg0.QuadWins.IconEmpty:setScale(0.7, 0.7)
			f22_arg0.clipFinished(f22_arg0.QuadWins)
			f22_arg0.DuoWins:completeAnimation()
			f22_arg0.DuoWins.ChallengeCoinIcon:completeAnimation()
			f22_arg0.DuoWins.IconEmpty:completeAnimation()
			f22_arg0.DuoWins:setTopBottom(0, 0, 132.5, 246.5)
			f22_arg0.DuoWins.ChallengeCoinIcon:setScale(0.7, 0.7)
			f22_arg0.DuoWins.IconEmpty:setScale(0.7, 0.7)
			f22_arg0.clipFinished(f22_arg0.DuoWins)
			f22_arg0.SoloWins:completeAnimation()
			f22_arg0.SoloWins.ChallengeCoinIcon:completeAnimation()
			f22_arg0.SoloWins.IconEmpty:completeAnimation()
			f22_arg0.SoloWins:setTopBottom(0, 0, 10.5, 124.5)
			f22_arg0.SoloWins.ChallengeCoinIcon:setScale(0.7, 0.7)
			f22_arg0.SoloWins.IconEmpty:setScale(0.7, 0.7)
			f22_arg0.clipFinished(f22_arg0.SoloWins)
			f22_arg0.DotlineTop:completeAnimation()
			f22_arg0.DotlineTop:setTopBottom(0, 0, 126.5, 130.5)
			f22_arg0.clipFinished(f22_arg0.DotlineTop)
			f22_arg0.DotlineBot:completeAnimation()
			f22_arg0.DotlineBot:setTopBottom(0, 0, 248.5, 252.5)
			f22_arg0.clipFinished(f22_arg0.DotlineBot)
			f22_arg0.Medals:completeAnimation()
			f22_arg0.Medals.ButtonInternal.StartMenuButtonFrame:completeAnimation()
			f22_arg0.Medals:setTopBottom(0.5, 0.5, 68, 338)
			f22_arg0.Medals:setAlpha(1)
			f22_arg0.clipFinished(f22_arg0.Medals)
		end,
		GainChildFocus = function(f23_arg0, f23_arg1)
			f23_arg0:__resetProperties()
			f23_arg0:setupElementClipCounter(7)
			f23_arg0.BG:completeAnimation()
			f23_arg0.BG:setTopBottom(0, 0, 0, 381)
			f23_arg0.clipFinished(f23_arg0.BG)
			f23_arg0.QuadWins:completeAnimation()
			f23_arg0.QuadWins.ChallengeCoinIcon:completeAnimation()
			f23_arg0.QuadWins.IconEmpty:completeAnimation()
			f23_arg0.QuadWins:setTopBottom(0, 0, 255, 369)
			f23_arg0.QuadWins.ChallengeCoinIcon:setScale(0.7, 0.7)
			f23_arg0.QuadWins.IconEmpty:setScale(0.7, 0.7)
			f23_arg0.clipFinished(f23_arg0.QuadWins)
			f23_arg0.DuoWins:completeAnimation()
			f23_arg0.DuoWins.ChallengeCoinIcon:completeAnimation()
			f23_arg0.DuoWins.IconEmpty:completeAnimation()
			f23_arg0.DuoWins:setTopBottom(0, 0, 132.5, 246.5)
			f23_arg0.DuoWins.ChallengeCoinIcon:setScale(0.7, 0.7)
			f23_arg0.DuoWins.IconEmpty:setScale(0.7, 0.7)
			f23_arg0.clipFinished(f23_arg0.DuoWins)
			f23_arg0.SoloWins:completeAnimation()
			f23_arg0.SoloWins.ChallengeCoinIcon:completeAnimation()
			f23_arg0.SoloWins.IconEmpty:completeAnimation()
			f23_arg0.SoloWins:setTopBottom(0, 0, 10.5, 124.5)
			f23_arg0.SoloWins.ChallengeCoinIcon:setScale(0.7, 0.7)
			f23_arg0.SoloWins.IconEmpty:setScale(0.7, 0.7)
			f23_arg0.clipFinished(f23_arg0.SoloWins)
			f23_arg0.DotlineTop:completeAnimation()
			f23_arg0.DotlineTop:setTopBottom(0, 0, 126.5, 130.5)
			f23_arg0.clipFinished(f23_arg0.DotlineTop)
			f23_arg0.DotlineBot:completeAnimation()
			f23_arg0.DotlineBot:setTopBottom(0, 0, 248.5, 252.5)
			f23_arg0.clipFinished(f23_arg0.DotlineBot)
			f23_arg0.Medals:completeAnimation()
			f23_arg0.Medals.ButtonInternal.StartMenuButtonFrame:completeAnimation()
			f23_arg0.Medals:setTopBottom(0.5, 0.5, 68, 338)
			f23_arg0.Medals:setAlpha(1)
			f23_arg0.clipFinished(f23_arg0.Medals)
		end,
		LoseChildFocus = function(f24_arg0, f24_arg1)
			f24_arg0:__resetProperties()
			f24_arg0:setupElementClipCounter(7)
			f24_arg0.BG:completeAnimation()
			f24_arg0.BG:setTopBottom(0, 0, 0, 381)
			f24_arg0.clipFinished(f24_arg0.BG)
			f24_arg0.QuadWins:completeAnimation()
			f24_arg0.QuadWins.ChallengeCoinIcon:completeAnimation()
			f24_arg0.QuadWins.IconEmpty:completeAnimation()
			f24_arg0.QuadWins:setTopBottom(0, 0, 255, 369)
			f24_arg0.QuadWins.ChallengeCoinIcon:setScale(0.7, 0.7)
			f24_arg0.QuadWins.IconEmpty:setScale(0.7, 0.7)
			f24_arg0.clipFinished(f24_arg0.QuadWins)
			f24_arg0.DuoWins:completeAnimation()
			f24_arg0.DuoWins.ChallengeCoinIcon:completeAnimation()
			f24_arg0.DuoWins.IconEmpty:completeAnimation()
			f24_arg0.DuoWins:setTopBottom(0, 0, 132.5, 246.5)
			f24_arg0.DuoWins.ChallengeCoinIcon:setScale(0.7, 0.7)
			f24_arg0.DuoWins.IconEmpty:setScale(0.7, 0.7)
			f24_arg0.clipFinished(f24_arg0.DuoWins)
			f24_arg0.SoloWins:completeAnimation()
			f24_arg0.SoloWins.ChallengeCoinIcon:completeAnimation()
			f24_arg0.SoloWins.IconEmpty:completeAnimation()
			f24_arg0.SoloWins:setTopBottom(0, 0, 10.5, 124.5)
			f24_arg0.SoloWins.ChallengeCoinIcon:setScale(0.7, 0.7)
			f24_arg0.SoloWins.IconEmpty:setScale(0.7, 0.7)
			f24_arg0.clipFinished(f24_arg0.SoloWins)
			f24_arg0.DotlineTop:completeAnimation()
			f24_arg0.DotlineTop:setTopBottom(0, 0, 126.5, 130.5)
			f24_arg0.clipFinished(f24_arg0.DotlineTop)
			f24_arg0.DotlineBot:completeAnimation()
			f24_arg0.DotlineBot:setTopBottom(0, 0, 248.5, 252.5)
			f24_arg0.clipFinished(f24_arg0.DotlineBot)
			f24_arg0.Medals:completeAnimation()
			f24_arg0.Medals.ButtonInternal.StartMenuButtonFrame:completeAnimation()
			f24_arg0.Medals:setTopBottom(0.5, 0.5, 68, 338)
			f24_arg0.Medals:setAlpha(1)
			f24_arg0.clipFinished(f24_arg0.Medals)
		end,
	},
}
CoD.StartMenu_Barracks_WZ_WinRecordContainer.__onClose = function(f25_arg0)
	f25_arg0.BG:close()
	f25_arg0.QuadWins:close()
	f25_arg0.DuoWins:close()
	f25_arg0.SoloWins:close()
	f25_arg0.Medals:close()
end
