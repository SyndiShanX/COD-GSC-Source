CoD.PC_StartMenu_Options_Glow = InheritFrom(LUI.UIElement)
CoD.PC_StartMenu_Options_Glow.__defaultWidth = 46
CoD.PC_StartMenu_Options_Glow.__defaultHeight = 64
CoD.PC_StartMenu_Options_Glow.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PC_StartMenu_Options_Glow)
	self.id = "PC_StartMenu_Options_Glow"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Glow = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Glow:setZRot(180)
	Glow:setImage(RegisterImage(@"hash_61F4A521D2954B6"))
	Glow:setMaterial(LUI.UIImage.GetCachedMaterial("ui_add"))
	self:addElement(Glow)
	self.Glow = Glow
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.PC_StartMenu_Options_Glow.__resetProperties = function(f2_arg0)
	f2_arg0.Glow:completeAnimation()
	f2_arg0.Glow:setRGB(1, 1, 1)
end
CoD.PC_StartMenu_Options_Glow.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(1)
			f3_arg0.Glow:completeAnimation()
			f3_arg0.Glow:setRGB(0.42, 0.4, 0.37)
			f3_arg0.clipFinished(f3_arg0.Glow)
		end,
	},
	Custom = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(1)
			f4_arg0.Glow:completeAnimation()
			f4_arg0.Glow:setRGB(0.84, 0.47, 0.17)
			f4_arg0.clipFinished(f4_arg0.Glow)
		end,
	},
}
