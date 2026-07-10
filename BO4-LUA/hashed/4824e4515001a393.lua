CoD.Loading_WZ_TrialBanner = InheritFrom(LUI.UIElement)
CoD.Loading_WZ_TrialBanner.__defaultWidth = 500
CoD.Loading_WZ_TrialBanner.__defaultHeight = 300
CoD.Loading_WZ_TrialBanner.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIVerticalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 0, true)
	self:setAlignment(LUI.Alignment.Middle)
	self:setClass(CoD.Loading_WZ_TrialBanner)
	self.id = "Loading_WZ_TrialBanner"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Backing = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Backing:setRGB(0, 0, 0)
	Backing:setAlpha(0.2)
	self:addElement(Backing)
	self.Backing = Backing
	local TrialInfoTop = LUI.UIText.new(1, 1, -609, -200, 0.5, 0.5, -147, -75)
	TrialInfoTop:setText(LocalizeToUpperString(0x18058A1BEEE18EA))
	TrialInfoTop:setTTF("ttmussels_regular")
	TrialInfoTop:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	self:addElement(TrialInfoTop)
	self.TrialInfoTop = TrialInfoTop
	local TrialInfoMid = LUI.UIText.new(1, 1, -609, -200, 0.5, 0.5, -75, 75)
	TrialInfoMid:setText(LocalizeToUpperString(0xA2DD20750465431))
	TrialInfoMid:setTTF("ttmussels_demibold")
	TrialInfoMid:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	self:addElement(TrialInfoMid)
	self.TrialInfoMid = TrialInfoMid
	local TrialInfoBot = LUI.UIText.new(1, 1, -609, -200, 0.5, 0.5, 75, 147)
	TrialInfoBot:setText(LocalizeToUpperString(0x82CDAA1F009C7D0))
	TrialInfoBot:setTTF("ttmussels_regular")
	TrialInfoBot:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	self:addElement(TrialInfoBot)
	self.TrialInfoBot = TrialInfoBot
	self:mergeStateConditions({
		{
			stateName = "Shown",
			condition = function(menu, element, event)
				return IsGameTrial()
			end,
		},
	})
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.Loading_WZ_TrialBanner.__resetProperties = function(f3_arg0)
	f3_arg0.TrialInfoBot:completeAnimation()
	f3_arg0.TrialInfoMid:completeAnimation()
	f3_arg0.TrialInfoTop:completeAnimation()
	f3_arg0.Backing:completeAnimation()
	f3_arg0.TrialInfoBot:setAlpha(1)
	f3_arg0.TrialInfoMid:setAlpha(1)
	f3_arg0.TrialInfoTop:setAlpha(1)
	f3_arg0.Backing:setAlpha(0.2)
end
CoD.Loading_WZ_TrialBanner.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(4)
			f4_arg0.Backing:completeAnimation()
			f4_arg0.Backing:setAlpha(0)
			f4_arg0.clipFinished(f4_arg0.Backing)
			f4_arg0.TrialInfoTop:completeAnimation()
			f4_arg0.TrialInfoTop:setAlpha(0)
			f4_arg0.clipFinished(f4_arg0.TrialInfoTop)
			f4_arg0.TrialInfoMid:completeAnimation()
			f4_arg0.TrialInfoMid:setAlpha(0)
			f4_arg0.clipFinished(f4_arg0.TrialInfoMid)
			f4_arg0.TrialInfoBot:completeAnimation()
			f4_arg0.TrialInfoBot:setAlpha(0)
			f4_arg0.clipFinished(f4_arg0.TrialInfoBot)
		end,
	},
	Shown = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(0)
		end,
	},
}
