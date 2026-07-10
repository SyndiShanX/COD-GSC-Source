CoD.vhud_attack_helicopter_flare = InheritFrom(LUI.UIElement)
CoD.vhud_attack_helicopter_flare.__defaultWidth = 50
CoD.vhud_attack_helicopter_flare.__defaultHeight = 80
CoD.vhud_attack_helicopter_flare.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.vhud_attack_helicopter_flare)
	self.id = "vhud_attack_helicopter_flare"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local flareOutline = LUI.UIImage.new(0.5, 0.5, -41, 41, 0.5, 0.5, -19, 19)
	flareOutline:setRGB(0.33, 0.33, 0.33)
	flareOutline:setImage(RegisterImage(0x4D2AF0AA8C0A376))
	self:addElement(flareOutline)
	self.flareOutline = flareOutline
	local flare = LUI.UIImage.new(0.5, 0.5, -41, 41, 0.5, 0.5, -19, 19)
	flare:setImage(RegisterImage(0x4D2AF0AA8C0A376))
	self:addElement(flare)
	self.flare = flare
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.vhud_attack_helicopter_flare.__resetProperties = function(f2_arg0)
	f2_arg0.flare:completeAnimation()
	f2_arg0.flare:setAlpha(1)
end
CoD.vhud_attack_helicopter_flare.__clipsPerState = {
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
			f4_arg0.flare:completeAnimation()
			f4_arg0.flare:setAlpha(0)
			f4_arg0.clipFinished(f4_arg0.flare)
		end,
	},
}
