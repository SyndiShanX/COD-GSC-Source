require("x64:29187ea00d726c3")
CoD.AARWinLoseMessage = InheritFrom(LUI.UIElement)
CoD.AARWinLoseMessage.__defaultWidth = 1500
CoD.AARWinLoseMessage.__defaultHeight = 38
CoD.AARWinLoseMessage.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIHorizontalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 0, false)
	self:setAlignment(LUI.Alignment.Left)
	self:setClass(CoD.AARWinLoseMessage)
	self.id = "AARWinLoseMessage"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local GametypeLabel = LUI.UIText.new(0, 0, 0, 500, 0, 0, 8.5, 29.5)
	GametypeLabel:setRGB(ColorSet.PlayerYellow.r, ColorSet.PlayerYellow.g, ColorSet.PlayerYellow.b)
	GametypeLabel:setAlpha(0.3)
	GametypeLabel:setTTF("ttmussels_regular")
	GametypeLabel:setLetterSpacing(4)
	GametypeLabel:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	GametypeLabel:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	GametypeLabel:linkToElementModel(self, "gametype", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			GametypeLabel:setText(LocalizeStringWithParameter(@"hash_695BAA5F888415EF", CoD.GameTypeUtility.GameTypeToLocalizeName(f2_local0)))
		end
	end)
	self:addElement(GametypeLabel)
	self.GametypeLabel = GametypeLabel
	local VerticalListSpacer2 = CoD.VerticalListSpacer.new(f1_arg0, f1_arg1, 0, 0, 500, 515, 0, 0, 0, 38)
	self:addElement(VerticalListSpacer2)
	self.VerticalListSpacer2 = VerticalListSpacer2
	local Percentage = LUI.UIText.new(0, 0, 515, 769, 0, 0, 4, 32)
	Percentage:setRGB(ColorSet.PlayerYellow.r, ColorSet.PlayerYellow.g, ColorSet.PlayerYellow.b)
	Percentage:setAlpha(0.3)
	Percentage:setTTF("ttmussels_regular")
	Percentage:setLetterSpacing(4)
	Percentage:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	Percentage:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	Percentage:linkToElementModel(self, "winRatio", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			Percentage:setText(LocalizeStringWithParameter(@"aar/percentage", f3_local0))
		end
	end)
	self:addElement(Percentage)
	self.Percentage = Percentage
	local VerticalListSpacer3 = CoD.VerticalListSpacer.new(f1_arg0, f1_arg1, 0, 0, 769, 789, 0, 0, 0, 38)
	self:addElement(VerticalListSpacer3)
	self.VerticalListSpacer3 = VerticalListSpacer3
	local Wins = LUI.UIText.new(0, 0, 789, 1044, 0, 0, 4, 35)
	Wins:setRGB(ColorSet.PlayerYellow.r, ColorSet.PlayerYellow.g, ColorSet.PlayerYellow.b)
	Wins:setAlpha(0.5)
	Wins:setTTF("0arame_mono_stencil")
	Wins:setLetterSpacing(1)
	Wins:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	Wins:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	Wins:linkToElementModel(self, "wins", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			Wins:setText(LocalizeStringWithParameter(@"hash_5A18D24749F0ABA6", f4_local0))
		end
	end)
	self:addElement(Wins)
	self.Wins = Wins
	local VerticalListSpacer = CoD.VerticalListSpacer.new(f1_arg0, f1_arg1, 0, 0, 1044, 1064, 0, 0, 0, 38)
	self:addElement(VerticalListSpacer)
	self.VerticalListSpacer = VerticalListSpacer
	local Losses = LUI.UIText.new(0, 0, 1064, 1456, 0, 0, 4, 35)
	Losses:setRGB(ColorSet.PlayerYellow.r, ColorSet.PlayerYellow.g, ColorSet.PlayerYellow.b)
	Losses:setAlpha(0.5)
	Losses:setTTF("0arame_mono_stencil")
	Losses:setLetterSpacing(1)
	Losses:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	Losses:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	Losses:linkToElementModel(self, "losses", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			Losses:setText(LocalizeStringWithParameter(@"hash_24E395ED8142BC76", f5_local0))
		end
	end)
	self:addElement(Losses)
	self.Losses = Losses
	self:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return not CoD.AARUtility.IsWinLoseStat(f1_arg1)
			end,
		},
	})
	local f1_local8 = self
	local f1_local9 = self.subscribeToModel
	local f1_local10 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local9(f1_local8, f1_local10["AAR.activeStat"], function(f7_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f7_arg0:get(),
			modelName = "AAR.activeStat",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.AARWinLoseMessage.__resetProperties = function(f8_arg0)
	f8_arg0.Losses:completeAnimation()
	f8_arg0.VerticalListSpacer:completeAnimation()
	f8_arg0.Wins:completeAnimation()
	f8_arg0.VerticalListSpacer3:completeAnimation()
	f8_arg0.Percentage:completeAnimation()
	f8_arg0.VerticalListSpacer2:completeAnimation()
	f8_arg0.GametypeLabel:completeAnimation()
	f8_arg0.Losses:setAlpha(0.5)
	f8_arg0.VerticalListSpacer:setAlpha(1)
	f8_arg0.Wins:setAlpha(0.5)
	f8_arg0.VerticalListSpacer3:setAlpha(1)
	f8_arg0.Percentage:setAlpha(0.3)
	f8_arg0.VerticalListSpacer2:setAlpha(1)
	f8_arg0.GametypeLabel:setAlpha(0.3)
end
CoD.AARWinLoseMessage.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(0)
		end,
	},
	Hidden = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(7)
			f10_arg0.GametypeLabel:completeAnimation()
			f10_arg0.GametypeLabel:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.GametypeLabel)
			f10_arg0.VerticalListSpacer2:completeAnimation()
			f10_arg0.VerticalListSpacer2:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.VerticalListSpacer2)
			f10_arg0.Percentage:completeAnimation()
			f10_arg0.Percentage:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.Percentage)
			f10_arg0.VerticalListSpacer3:completeAnimation()
			f10_arg0.VerticalListSpacer3:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.VerticalListSpacer3)
			f10_arg0.Wins:completeAnimation()
			f10_arg0.Wins:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.Wins)
			f10_arg0.VerticalListSpacer:completeAnimation()
			f10_arg0.VerticalListSpacer:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.VerticalListSpacer)
			f10_arg0.Losses:completeAnimation()
			f10_arg0.Losses:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.Losses)
		end,
	},
}
CoD.AARWinLoseMessage.__onClose = function(f11_arg0)
	f11_arg0.GametypeLabel:close()
	f11_arg0.VerticalListSpacer2:close()
	f11_arg0.Percentage:close()
	f11_arg0.VerticalListSpacer3:close()
	f11_arg0.Wins:close()
	f11_arg0.VerticalListSpacer:close()
	f11_arg0.Losses:close()
end
