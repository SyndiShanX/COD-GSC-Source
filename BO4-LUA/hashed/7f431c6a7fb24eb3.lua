require("x64:5415c2f3330b8c9")
require("x64:2bad6fbafef4fa")
require("x64:6cfb14ab0b137a5")
CoD.WZAAR_MeritContainerInternal = InheritFrom(LUI.UIElement)
CoD.WZAAR_MeritContainerInternal.__defaultWidth = 540
CoD.WZAAR_MeritContainerInternal.__defaultHeight = 628
CoD.WZAAR_MeritContainerInternal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WZAAR_MeritContainerInternal)
	self.id = "WZAAR_MeritContainerInternal"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local IGRbg = CoD.WZAAR_IGR_background.new(f1_arg0, f1_arg1, 0, 0, 0, 540, 0, 0, 0, 628)
	self:addElement(IGRbg)
	self.IGRbg = IGRbg
	local NextEchelon = LUI.UIText.new(0, 0, 460, 518, 0, 0, 571, 599)
	NextEchelon:setTTF("ttmussels_regular")
	NextEchelon:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	NextEchelon:setAlignment(Enum[0x7A5123B654282D2][0xE821F0ECFF8D1C7])
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
	self:addElement(EchelonProgress)
	self.EchelonProgress = EchelonProgress
	local CurrentEchelon = LUI.UIText.new(0, 0, 22, 80, 0, 0, 571, 599)
	CurrentEchelon:setTTF("ttmussels_regular")
	CurrentEchelon:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	CurrentEchelon:setAlignment(Enum[0x7A5123B654282D2][0xE821F0ECFF8D1C7])
	CurrentEchelon:linkToElementModel(self, "rank", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			CurrentEchelon:setText(f4_local0)
		end
	end)
	self:addElement(CurrentEchelon)
	self.CurrentEchelon = CurrentEchelon
	local EarnedEchelonIcon = LUI.UIImage.new(0.5, 0.5, 196, 244, 0, 0, 515, 563)
	EarnedEchelonIcon:linkToElementModel(self, "echelon", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			EarnedEchelonIcon:setImage(RegisterImage(f5_local0))
		end
	end)
	self:addElement(EarnedEchelonIcon)
	self.EarnedEchelonIcon = EarnedEchelonIcon
	local Box = LUI.UIImage.new(0.5, 0.5, -200, 200, 0.5, 0.5, -213, 99)
	Box:setAlpha(0)
	Box:setImage(RegisterImage(0x60863710610A64E))
	self:addElement(Box)
	self.Box = Box
	local ProgressTitle = LUI.UIText.new(0.5, 0.5, -100, 100, 0, 0, 455, 479)
	ProgressTitle:setAlpha(0)
	ProgressTitle:setText(Engine[0xF9F1239CFD921FE](0xDB9EE2A23526998))
	ProgressTitle:setTTF("default")
	ProgressTitle:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	ProgressTitle:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(ProgressTitle)
	self.ProgressTitle = ProgressTitle
	local MeritDetails = CoD.WZAAR_MeritBreakdown.new(f1_arg0, f1_arg1, 0.5, 0.5, -180, 180, 0, 0, 119, 377)
	MeritDetails:linkToElementModel(self, nil, false, function(model)
		MeritDetails:setModel(model, f1_arg1)
	end)
	self:addElement(MeritDetails)
	self.MeritDetails = MeritDetails
	local MeritsHeader = LUI.UIText.new(0.5, 0.5, -256.5, 256.5, 0, 0, 76, 100)
	MeritsHeader:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	MeritsHeader:setText(LocalizeToUpperString(0x2FD7986ED047F25))
	MeritsHeader:setTTF("ttmussels_regular")
	MeritsHeader:setLetterSpacing(2)
	MeritsHeader:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	MeritsHeader:setAlignment(Enum[0x7A5123B654282D2][0x6ED4298C93DC5ED])
	self:addElement(MeritsHeader)
	self.MeritsHeader = MeritsHeader
	local Title = LUI.UIText.new(0.5, 0.5, -248, 248, 0, 0, 19, 51)
	Title:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	Title:setText(Engine[0xF9F1239CFD921FE](0x9C7C549DBCFDA00))
	Title:setTTF("ttmussels_demibold")
	Title:setLetterSpacing(4)
	Title:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	Title:setAlignment(Enum[0x7A5123B654282D2][0xE821F0ECFF8D1C7])
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
CoD.WZAAR_MeritContainerInternal.__resetProperties = function(f9_arg0)
	f9_arg0.Title:completeAnimation()
	f9_arg0.MeritDetails:completeAnimation()
	f9_arg0.EarnedEchelonIcon:completeAnimation()
	f9_arg0.ProgressTitle:completeAnimation()
	f9_arg0.CurrentEchelon:completeAnimation()
	f9_arg0.EchelonProgress:completeAnimation()
	f9_arg0.NextEchelon:completeAnimation()
	f9_arg0.MeritsHeader:completeAnimation()
	f9_arg0.IGRbg:completeAnimation()
	f9_arg0.Title:setAlpha(1)
	f9_arg0.MeritDetails:setAlpha(1)
	f9_arg0.EarnedEchelonIcon:setAlpha(1)
	f9_arg0.ProgressTitle:setAlpha(0)
	f9_arg0.CurrentEchelon:setAlpha(1)
	f9_arg0.EchelonProgress:setAlpha(1)
	f9_arg0.NextEchelon:setAlpha(1)
	f9_arg0.MeritsHeader:setAlpha(1)
	f9_arg0.IGRbg:setAlpha(1)
end
CoD.WZAAR_MeritContainerInternal.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(0)
		end,
	},
	Hidden = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(9)
			f11_arg0.IGRbg:completeAnimation()
			f11_arg0.IGRbg:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.IGRbg)
			f11_arg0.NextEchelon:completeAnimation()
			f11_arg0.NextEchelon:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.NextEchelon)
			f11_arg0.EchelonProgress:completeAnimation()
			f11_arg0.EchelonProgress:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.EchelonProgress)
			f11_arg0.CurrentEchelon:completeAnimation()
			f11_arg0.CurrentEchelon:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.CurrentEchelon)
			f11_arg0.EarnedEchelonIcon:completeAnimation()
			f11_arg0.EarnedEchelonIcon:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.EarnedEchelonIcon)
			f11_arg0.ProgressTitle:completeAnimation()
			f11_arg0.ProgressTitle:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.ProgressTitle)
			f11_arg0.MeritDetails:completeAnimation()
			f11_arg0.MeritDetails:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.MeritDetails)
			f11_arg0.MeritsHeader:completeAnimation()
			f11_arg0.MeritsHeader:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.MeritsHeader)
			f11_arg0.Title:completeAnimation()
			f11_arg0.Title:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.Title)
		end,
	},
}
CoD.WZAAR_MeritContainerInternal.__onClose = function(f12_arg0)
	f12_arg0.IGRbg:close()
	f12_arg0.NextEchelon:close()
	f12_arg0.EchelonProgress:close()
	f12_arg0.CurrentEchelon:close()
	f12_arg0.EarnedEchelonIcon:close()
	f12_arg0.MeritDetails:close()
end
