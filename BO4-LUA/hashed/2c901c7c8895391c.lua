require("x64:5415c2f3330b8c9")
require("x64:6cfb14ab0b137a5")
CoD.MeritOverlayManualLayoutVerticalBG = InheritFrom(LUI.UIElement)
CoD.MeritOverlayManualLayoutVerticalBG.__defaultWidth = 540
CoD.MeritOverlayManualLayoutVerticalBG.__defaultHeight = 628
CoD.MeritOverlayManualLayoutVerticalBG.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.MeritOverlayManualLayoutVerticalBG)
	self.id = "MeritOverlayManualLayoutVerticalBG"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local IGRbg = CoD.WZAAR_IGR_background.new(f1_arg0, f1_arg1, 0, 0, 0, 540, 0, 0, 0, 628)
	self:addElement(IGRbg)
	self.IGRbg = IGRbg
	local NextEchelon = LUI.UIText.new(0, 0, 460, 518, 0, 0, 571, 599)
	NextEchelon:setTTF("ttmussels_regular")
	NextEchelon:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	NextEchelon:setAlignment(Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"])
	NextEchelon:linkToElementModel(self, "nextRank", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			NextEchelon:setText(f2_local0)
		end
	end)
	self:addElement(NextEchelon)
	self.NextEchelon = NextEchelon
	local EchelonProgress = CoD.WZAAR_MeritProgressBar.new(f1_arg0, f1_arg1, 0.5, 0.5, -184, 184, 0, 0, 575, 595)
	EchelonProgress:linkToElementModel(self, nil, false, function(model)
		EchelonProgress:setModel(model, f1_arg1)
	end)
	EchelonProgress:linkToElementModel(self, "earnedXpProgress", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			EchelonProgress.EarnedXP.Meter:setShaderVector(0, CoD.GetVectorComponentFromString(f4_local0, 1), CoD.GetVectorComponentFromString(f4_local0, 2), CoD.GetVectorComponentFromString(f4_local0, 3), CoD.GetVectorComponentFromString(f4_local0, 4))
		end
	end)
	EchelonProgress:linkToElementModel(self, "earnedXpProgress", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			EchelonProgress.EarnedXP.MeterAdd:setShaderVector(0, CoD.GetVectorComponentFromString(f5_local0, 1), CoD.GetVectorComponentFromString(f5_local0, 2), CoD.GetVectorComponentFromString(f5_local0, 3), CoD.GetVectorComponentFromString(f5_local0, 4))
		end
	end)
	EchelonProgress:linkToElementModel(self, "earnedXpProgress", true, function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			EchelonProgress.EarnedXP.MeterGlow:setShaderVector(0, CoD.GetVectorComponentFromString(f6_local0, 1), CoD.GetVectorComponentFromString(f6_local0, 2), CoD.GetVectorComponentFromString(f6_local0, 3), CoD.GetVectorComponentFromString(f6_local0, 4))
		end
	end)
	self:addElement(EchelonProgress)
	self.EchelonProgress = EchelonProgress
	local CurrentEchelon = LUI.UIText.new(0, 0, 22, 80, 0, 0, 571, 599)
	CurrentEchelon:setTTF("ttmussels_regular")
	CurrentEchelon:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	CurrentEchelon:setAlignment(Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"])
	CurrentEchelon:linkToElementModel(self, "rank", true, function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			CurrentEchelon:setText(f7_local0)
		end
	end)
	self:addElement(CurrentEchelon)
	self.CurrentEchelon = CurrentEchelon
	local EarnedEchelonIcon = LUI.UIImage.new(0.5, 0.5, 196, 244, 0, 0, 515, 563)
	EarnedEchelonIcon:linkToElementModel(self, "echelon", true, function(model)
		local f8_local0 = model:get()
		if f8_local0 ~= nil then
			EarnedEchelonIcon:setImage(RegisterImage(f8_local0))
		end
	end)
	self:addElement(EarnedEchelonIcon)
	self.EarnedEchelonIcon = EarnedEchelonIcon
	local Box = LUI.UIImage.new(0.5, 0.5, -200, 200, 0.5, 0.5, -213, 99)
	Box:setAlpha(0)
	Box:setImage(RegisterImage(@"uie_ui_hud_wz_endgame_merits_box"))
	self:addElement(Box)
	self.Box = Box
	local ProgressTitle = LUI.UIText.new(0.5, 0.5, -100, 100, 0, 0, 455, 479)
	ProgressTitle:setAlpha(0)
	ProgressTitle:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_5DB9EE2A23526998"))
	ProgressTitle:setTTF("default")
	ProgressTitle:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	ProgressTitle:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(ProgressTitle)
	self.ProgressTitle = ProgressTitle
	local MeritsHeader = LUI.UIText.new(0.5, 0.5, -256.5, 256.5, 0, 0, 76, 100)
	MeritsHeader:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	MeritsHeader:setText(LocalizeToUpperString(@"hash_32FD7986ED047F25"))
	MeritsHeader:setTTF("ttmussels_regular")
	MeritsHeader:setLetterSpacing(2)
	MeritsHeader:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	MeritsHeader:setAlignment(Enum[@"luialignment"][@"lui_alignment_middle"])
	self:addElement(MeritsHeader)
	self.MeritsHeader = MeritsHeader
	local Title = LUI.UIText.new(0.5, 0.5, -248, 248, 0, 0, 19, 51)
	Title:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	Title:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_29C7C549DBCFDA00"))
	Title:setTTF("ttmussels_demibold")
	Title:setLetterSpacing(4)
	Title:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	Title:setAlignment(Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"])
	self:addElement(Title)
	self.Title = Title
	self:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsSelfModelValueGreaterThan(self, f1_arg1, "totalMerit", 0)
			end,
		},
	})
	self:linkToElementModel(self, "totalMerit", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "totalMerit",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.MeritOverlayManualLayoutVerticalBG.__resetProperties = function(f11_arg0)
	f11_arg0.Title:completeAnimation()
	f11_arg0.MeritsHeader:completeAnimation()
	f11_arg0.ProgressTitle:completeAnimation()
	f11_arg0.Box:completeAnimation()
	f11_arg0.EarnedEchelonIcon:completeAnimation()
	f11_arg0.CurrentEchelon:completeAnimation()
	f11_arg0.EchelonProgress:completeAnimation()
	f11_arg0.NextEchelon:completeAnimation()
	f11_arg0.IGRbg:completeAnimation()
	f11_arg0.Title:setAlpha(1)
	f11_arg0.MeritsHeader:setAlpha(1)
	f11_arg0.ProgressTitle:setAlpha(0)
	f11_arg0.Box:setAlpha(0)
	f11_arg0.EarnedEchelonIcon:setAlpha(1)
	f11_arg0.CurrentEchelon:setAlpha(1)
	f11_arg0.EchelonProgress:setAlpha(1)
	f11_arg0.NextEchelon:setAlpha(1)
	f11_arg0.IGRbg:setAlpha(1)
end
CoD.MeritOverlayManualLayoutVerticalBG.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(0)
		end,
	},
	Hidden = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(9)
			f13_arg0.IGRbg:completeAnimation()
			f13_arg0.IGRbg:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.IGRbg)
			f13_arg0.NextEchelon:completeAnimation()
			f13_arg0.NextEchelon:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.NextEchelon)
			f13_arg0.EchelonProgress:completeAnimation()
			f13_arg0.EchelonProgress:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.EchelonProgress)
			f13_arg0.CurrentEchelon:completeAnimation()
			f13_arg0.CurrentEchelon:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.CurrentEchelon)
			f13_arg0.EarnedEchelonIcon:completeAnimation()
			f13_arg0.EarnedEchelonIcon:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.EarnedEchelonIcon)
			f13_arg0.Box:completeAnimation()
			f13_arg0.Box:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.Box)
			f13_arg0.ProgressTitle:completeAnimation()
			f13_arg0.ProgressTitle:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.ProgressTitle)
			f13_arg0.MeritsHeader:completeAnimation()
			f13_arg0.MeritsHeader:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.MeritsHeader)
			f13_arg0.Title:completeAnimation()
			f13_arg0.Title:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.Title)
		end,
	},
}
CoD.MeritOverlayManualLayoutVerticalBG.__onClose = function(f14_arg0)
	f14_arg0.IGRbg:close()
	f14_arg0.NextEchelon:close()
	f14_arg0.EchelonProgress:close()
	f14_arg0.CurrentEchelon:close()
	f14_arg0.EarnedEchelonIcon:close()
end
