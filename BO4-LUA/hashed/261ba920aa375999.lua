require("x64:1bd8ac64244d75b")
CoD.PositionDraft_ReadyButtonContainer = InheritFrom(LUI.UIElement)
CoD.PositionDraft_ReadyButtonContainer.__defaultWidth = 368
CoD.PositionDraft_ReadyButtonContainer.__defaultHeight = 75
CoD.PositionDraft_ReadyButtonContainer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PositionDraft_ReadyButtonContainer)
	self.id = "PositionDraft_ReadyButtonContainer"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Blur = LUI.UIImage.new(0, 0, 0, 367, 0, 0, 0, 75)
	Blur:setMaterial(LUI.UIImage.GetCachedMaterial(0xE2354BE557C4C7A))
	Blur:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(Blur)
	self.Blur = Blur
	local Background = LUI.UIImage.new(-0.5, 0.5, 184, 184, -0.5, 0.5, 37.5, 37.5)
	Background:setRGB(0.06, 0.06, 0.06)
	Background:setAlpha(0.94)
	self:addElement(Background)
	self.Background = Background
	local Fill = LUI.UIImage.new(-0.5, 0.5, 184, 184, -0.5, 0.5, 37.5, 37.5)
	Fill:setRGB(ColorSet.PlayerYellow.r, ColorSet.PlayerYellow.g, ColorSet.PlayerYellow.b)
	Fill:setAlpha(0)
	Fill:setMaterial(LUI.UIImage.GetCachedMaterial(0x316E67E1DF2198E))
	Fill:setShaderVector(1, 0, 0, 0, 0)
	Fill:setShaderVector(2, 1, 0, 0, 0)
	Fill:setShaderVector(3, 0, 0, 0, 0)
	Fill:setShaderVector(4, 0, 0, 0, 0)
	Fill:linkToElementModel(self, "progress", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			Fill:setShaderVector(0, CoD.GetVectorComponentFromString(f2_local0, 1), CoD.GetVectorComponentFromString(f2_local0, 2), CoD.GetVectorComponentFromString(f2_local0, 3), CoD.GetVectorComponentFromString(f2_local0, 4))
		end
	end)
	self:addElement(Fill)
	self.Fill = Fill
	local ReadyText = LUI.UIText.new(-0.5, 0.5, 184, 184, 0, 0, 18.5, 56.5)
	ReadyText:setRGB(ColorSet.PlayerYellow.r, ColorSet.PlayerYellow.g, ColorSet.PlayerYellow.b)
	ReadyText:setText(Engine[0xF9F1239CFD921FE](0xB8B19A0CC3281E2))
	ReadyText:setTTF("ttmussels_regular")
	ReadyText:setLetterSpacing(10)
	ReadyText:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	ReadyText:setAlignment(Enum[0x7A5123B654282D2][0x6ED4298C93DC5ED])
	self:addElement(ReadyText)
	self.ReadyText = ReadyText
	local barTop = LUI.UIImage.new(0, 0, 26, 342, 0, 0, -13, -6)
	barTop:setRGB(ColorSet.T8__OCHRE.r, ColorSet.T8__OCHRE.g, ColorSet.T8__OCHRE.b)
	self:addElement(barTop)
	self.barTop = barTop
	local barTop2 = LUI.UIImage.new(0, 0, 343.5, 367.5, 0, 0, -13, -6)
	barTop2:setRGB(ColorSet.T8__OCHRE.r, ColorSet.T8__OCHRE.g, ColorSet.T8__OCHRE.b)
	self:addElement(barTop2)
	self.barTop2 = barTop2
	local barTop3 = LUI.UIImage.new(0, 0, 0, 24, 0, 0, -13, -6)
	barTop3:setRGB(ColorSet.T8__OCHRE.r, ColorSet.T8__OCHRE.g, ColorSet.T8__OCHRE.b)
	self:addElement(barTop3)
	self.barTop3 = barTop3
	local LineTop01 = LUI.UIImage.new(0, 0, 0, 368, 0, 0, 74.5, 75.5)
	LineTop01:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	LineTop01:setAlpha(0.5)
	self:addElement(LineTop01)
	self.LineTop01 = LineTop01
	local Corner01 = LUI.UIImage.new(0, 0, 0, 1, 0, 0, 62.5, 63.5)
	Corner01:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	Corner01:setAlpha(0.5)
	self:addElement(Corner01)
	self.Corner01 = Corner01
	local Corner = LUI.UIImage.new(0, 0, 367, 368, 0, 0, 63.5, 64.5)
	Corner:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	Corner:setAlpha(0.5)
	self:addElement(Corner)
	self.Corner = Corner
	local Corner2 = LUI.UIImage.new(0, 0, 367, 368, 0, 0, 68.5, 74.5)
	Corner2:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	Corner2:setAlpha(0.5)
	self:addElement(Corner2)
	self.Corner2 = Corner2
	local Corner3 = LUI.UIImage.new(0, 0, 0, 1, 0, 0, 68.5, 74.5)
	Corner3:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	Corner3:setAlpha(0.5)
	self:addElement(Corner3)
	self.Corner3 = Corner3
	local BarTopStripes2 = LUI.UIImage.new(0, 0, 0.5, 368.5, 0, 0, 81, 92)
	BarTopStripes2:setAlpha(0.1)
	BarTopStripes2:setImage(RegisterImage(0xA21C960676F4F2F))
	BarTopStripes2:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	BarTopStripes2:setShaderVector(0, 0, 0, 0, 0)
	BarTopStripes2:setupNineSliceShader(12, 12)
	self:addElement(BarTopStripes2)
	self.BarTopStripes2 = BarTopStripes2
	local arrow01 = LUI.UIImage.new(0, 0, 353, 358, 0, 0, -12, -7)
	arrow01:setRGB(0.06, 0.06, 0.06)
	arrow01:setImage(RegisterImage(0x19A57A2805CEECA))
	self:addElement(arrow01)
	self.arrow01 = arrow01
	local arrow = LUI.UIImage.new(0, 0, 9.5, 14.5, 0, 0, -12, -7)
	arrow:setRGB(0.06, 0.06, 0.06)
	arrow:setImage(RegisterImage(0x19A57A2805CEECA))
	self:addElement(arrow)
	self.arrow = arrow
	local PulseRight = CoD.PositionDraft_ReadyPulse.new(f1_arg0, f1_arg1, 0, 0, 364.5, 424.5, 0, 0, 0.5, 75.5)
	PulseRight:setAlpha(0.7)
	self:addElement(PulseRight)
	self.PulseRight = PulseRight
	local PulseLeft = CoD.PositionDraft_ReadyPulse.new(f1_arg0, f1_arg1, 0, 0, -56, 4, 0, 0, 0.5, 75.5)
	PulseLeft:setAlpha(0.7)
	PulseLeft:setZRot(180)
	self:addElement(PulseLeft)
	self.PulseLeft = PulseLeft
	self:appendEventHandler("input_source_changed", function(f3_arg0, f3_arg1)
		f3_arg1.menu = f3_arg1.menu or f1_arg0
		CoD.Menu.UpdateButtonShownState(f3_arg0, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8])
	end)
	local f1_local18 = self
	local f1_local19 = self.subscribeToModel
	local f1_local20 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local19(f1_local18, f1_local20.LastInput, function(f4_arg0, f4_arg1)
		CoD.Menu.UpdateButtonShownState(f4_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8])
	end, false)
	f1_arg0:AddButtonCallbackFunction(self, f1_arg1, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], "SPACE", function(element, menu, controller, model)
		if IsMouseOrKeyboard(controller) then
			PositionDraftReady(self, element, controller)
			SetState(self, "Ready", controller)
			CoD.BaseUtility.StopPlayOnceSound(element, "uin_draft_bar_fill_1shot")
			PlaySoundAlias("uind_draft_bar_done")
			return true
		else
		end
	end, function(element, menu, controller)
		if IsMouseOrKeyboard(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], 0x0, nil, "SPACE")
			return false
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(self, f1_arg1, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], "ui_confirm", function(element, menu, controller, model)
		if IsMouseOrKeyboard(controller) then
			PositionDraftReady(self, element, controller)
			SetState(self, "Ready", controller)
			CoD.BaseUtility.StopPlayOnceSound(element, "uin_draft_bar_fill_1shot")
			PlaySoundAlias("uind_draft_bar_done")
			return true
		else
		end
	end, function(element, menu, controller)
		if IsMouseOrKeyboard(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], 0x0, nil, "ui_confirm")
			return false
		else
			return false
		end
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(self, "setState", function(element, controller, f9_arg2, f9_arg3, f9_arg4)
		if IsElementInState(self, "Ready") then
			UpdateButtonPromptState(f1_arg0, f1_arg0, controller, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A])
			UpdateButtonPromptState(f1_arg0, f1_arg0, controller, Enum[0x3DD78803F918E9D][0xE6DB407A2AF8B09])
		end
	end)
	self:linkToElementModel(self, "progress", true, function(model)
		local f10_local0 = self
		if CoD.ModelUtility.IsParamModelEqualTo(model, 0) and IsElementInFocus(f10_local0) then
			CoD.BaseUtility.StopPlayOnceSound(f10_local0, "uin_draft_bar_fill_1shot")
		elseif IsElementInFocus(f10_local0) and not IsElementInState(self, "Ready") then
			CoD.BaseUtility.PlaySoundOnce(f10_local0, "uin_draft_bar_fill_1shot")
		end
	end)
	self:linkToElementModel(self, nil, true, function(model)
		local f11_local0 = self
		if CoD.ModelUtility.IsParamModelEqualTo(model, Enum[0xE29E259801BC1A4][0x715085B24AAB606] | Enum[0xE29E259801BC1A4][0x253A6F6CAAAE464]) and IsElementInFocus(f11_local0) then
			PositionDraftReady(self, f11_local0, f1_arg1)
			SetState(self, "Ready", f1_arg1)
			CoD.BaseUtility.StopPlayOnceSound(f11_local0, "uin_draft_bar_fill_1shot")
			PlaySoundAlias("uin_draft_bar_done")
		end
	end)
	self:subscribeToGlobalModel(f1_arg1, "PerController", "KeyPressBits.MOUSE1", function(model)
		local f12_local0 = self
		if CoD.BaseUtility.IsWidgetVisible(f12_local0) and IsElementInFocus(self) then
			PositionDraftReady(self, f12_local0, f1_arg1)
			SetState(self, "Ready", f1_arg1)
			CoD.BaseUtility.StopPlayOnceSound(f12_local0, "uin_draft_bar_fill_1shot")
			PlaySoundAlias("uin_draft_bar_done")
		end
	end)
	self:subscribeToGlobalModel(f1_arg1, "PositionDraft", "waitingForPlayers", function(model)
		local f13_local0 = self
		if CoD.ModelUtility.IsGlobalModelValueGreaterThan("PositionDraft.waitingForPlayers", 0) then
			SetState(self, "DefaultState", f1_arg1)
		end
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.PositionDraft_ReadyButtonContainer.__resetProperties = function(f14_arg0)
	f14_arg0.Background:completeAnimation()
	f14_arg0.Fill:completeAnimation()
	f14_arg0.ReadyText:completeAnimation()
	f14_arg0.PulseLeft:completeAnimation()
	f14_arg0.PulseRight:completeAnimation()
	f14_arg0.arrow:completeAnimation()
	f14_arg0.arrow01:completeAnimation()
	f14_arg0.barTop:completeAnimation()
	f14_arg0.barTop3:completeAnimation()
	f14_arg0.barTop2:completeAnimation()
	f14_arg0.BarTopStripes2:completeAnimation()
	f14_arg0.LineTop01:completeAnimation()
	f14_arg0.Corner2:completeAnimation()
	f14_arg0.Corner:completeAnimation()
	f14_arg0.Corner01:completeAnimation()
	f14_arg0.Corner3:completeAnimation()
	f14_arg0.Blur:completeAnimation()
	f14_arg0.Background:setAlpha(0.94)
	f14_arg0.Background:setScale(1, 1)
	f14_arg0.Fill:setAlpha(0)
	f14_arg0.Fill:setScale(1, 1)
	f14_arg0.ReadyText:setAlpha(1)
	f14_arg0.ReadyText:setScale(1, 1)
	f14_arg0.PulseLeft:setAlpha(0.7)
	f14_arg0.PulseRight:setAlpha(0.7)
	f14_arg0.arrow:setAlpha(1)
	f14_arg0.arrow01:setAlpha(1)
	f14_arg0.barTop:setAlpha(1)
	f14_arg0.barTop3:setAlpha(1)
	f14_arg0.barTop2:setAlpha(1)
	f14_arg0.BarTopStripes2:setAlpha(0.1)
	f14_arg0.LineTop01:setAlpha(0.5)
	f14_arg0.Corner2:setAlpha(0.5)
	f14_arg0.Corner:setAlpha(0.5)
	f14_arg0.Corner01:setAlpha(0.5)
	f14_arg0.Corner3:setAlpha(0.5)
	f14_arg0.Blur:setAlpha(1)
end
CoD.PositionDraft_ReadyButtonContainer.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(5)
			f15_arg0.Background:completeAnimation()
			f15_arg0.Background:setScale(1, 1)
			f15_arg0.clipFinished(f15_arg0.Background)
			f15_arg0.Fill:completeAnimation()
			f15_arg0.Fill:setAlpha(0)
			f15_arg0.Fill:setScale(1, 1)
			f15_arg0.clipFinished(f15_arg0.Fill)
			f15_arg0.ReadyText:completeAnimation()
			f15_arg0.ReadyText:setScale(1, 1)
			f15_arg0.clipFinished(f15_arg0.ReadyText)
			f15_arg0.PulseRight:completeAnimation()
			f15_arg0.PulseRight:setAlpha(0.5)
			f15_arg0.clipFinished(f15_arg0.PulseRight)
			f15_arg0.PulseLeft:completeAnimation()
			f15_arg0.PulseLeft:setAlpha(0.5)
			f15_arg0.clipFinished(f15_arg0.PulseLeft)
			f15_arg0.nextClip = "DefaultClip"
		end,
		Focus = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(1)
			f16_arg0.Fill:completeAnimation()
			f16_arg0.Fill:setAlpha(0.35)
			f16_arg0.clipFinished(f16_arg0.Fill)
		end,
	},
	Ready = {
		DefaultClip = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(17)
			f17_arg0.Blur:completeAnimation()
			f17_arg0.Blur:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.Blur)
			f17_arg0.Background:completeAnimation()
			f17_arg0.Background:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.Background)
			f17_arg0.Fill:completeAnimation()
			f17_arg0.Fill:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.Fill)
			f17_arg0.ReadyText:completeAnimation()
			f17_arg0.ReadyText:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.ReadyText)
			f17_arg0.barTop:completeAnimation()
			f17_arg0.barTop:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.barTop)
			f17_arg0.barTop2:completeAnimation()
			f17_arg0.barTop2:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.barTop2)
			f17_arg0.barTop3:completeAnimation()
			f17_arg0.barTop3:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.barTop3)
			f17_arg0.LineTop01:completeAnimation()
			f17_arg0.LineTop01:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.LineTop01)
			f17_arg0.Corner01:completeAnimation()
			f17_arg0.Corner01:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.Corner01)
			f17_arg0.Corner:completeAnimation()
			f17_arg0.Corner:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.Corner)
			f17_arg0.Corner2:completeAnimation()
			f17_arg0.Corner2:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.Corner2)
			f17_arg0.Corner3:completeAnimation()
			f17_arg0.Corner3:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.Corner3)
			f17_arg0.BarTopStripes2:completeAnimation()
			f17_arg0.BarTopStripes2:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.BarTopStripes2)
			f17_arg0.arrow01:completeAnimation()
			f17_arg0.arrow01:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.arrow01)
			f17_arg0.arrow:completeAnimation()
			f17_arg0.arrow:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.arrow)
			f17_arg0.PulseRight:completeAnimation()
			f17_arg0.PulseRight:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.PulseRight)
			f17_arg0.PulseLeft:completeAnimation()
			f17_arg0.PulseLeft:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.PulseLeft)
		end,
	},
}
CoD.PositionDraft_ReadyButtonContainer.__onClose = function(f18_arg0)
	f18_arg0.Fill:close()
	f18_arg0.PulseRight:close()
	f18_arg0.PulseLeft:close()
end
