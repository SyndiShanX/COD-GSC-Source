CoD.vhud_gunship_flare_indicator = InheritFrom(LUI.UIElement)
CoD.vhud_gunship_flare_indicator.__defaultWidth = 80
CoD.vhud_gunship_flare_indicator.__defaultHeight = 18
CoD.vhud_gunship_flare_indicator.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.vhud_gunship_flare_indicator)
	self.id = "vhud_gunship_flare_indicator"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local FlareStatusText = LUI.UIText.new(0, 0, 0, 80, 0, 0, 0, 15)
	FlareStatusText:setText(Engine[0xF9F1239CFD921FE](0xE6D5A4CC38BEBB7))
	FlareStatusText:setTTF("ttmussels_regular")
	FlareStatusText:setLetterSpacing(1)
	FlareStatusText:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	FlareStatusText:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(FlareStatusText)
	self.FlareStatusText = FlareStatusText
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.vhud_gunship_flare_indicator.__resetProperties = function(f2_arg0)
	f2_arg0.FlareStatusText:completeAnimation()
	f2_arg0.FlareStatusText:setAlpha(1)
end
CoD.vhud_gunship_flare_indicator.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(0)
		end,
	},
	Inactive = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(1)
			f4_arg0.FlareStatusText:completeAnimation()
			f4_arg0.FlareStatusText:setAlpha(0.2)
			f4_arg0.clipFinished(f4_arg0.FlareStatusText)
		end,
	},
}
