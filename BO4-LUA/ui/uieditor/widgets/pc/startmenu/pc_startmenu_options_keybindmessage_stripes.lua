require("x64:44485d23f771954")
CoD.PC_StartMenu_Options_KeybindMessage_Stripes = InheritFrom(LUI.UIElement)
CoD.PC_StartMenu_Options_KeybindMessage_Stripes.__defaultWidth = 200
CoD.PC_StartMenu_Options_KeybindMessage_Stripes.__defaultHeight = 32
CoD.PC_StartMenu_Options_KeybindMessage_Stripes.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PC_StartMenu_Options_KeybindMessage_Stripes)
	self.id = "PC_StartMenu_Options_KeybindMessage_Stripes"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local StripesRight = CoD.VerticalStripes.new(f1_arg0, f1_arg1, 1, 1, -60, 574, 0.5, 0.5, -16, 16)
	StripesRight:setRGB(0.75, 0.75, 0.75)
	StripesRight:setAlpha(0.75)
	StripesRight:setRFTMaterial(LUI.UIImage.GetCachedMaterial(@"hash_51DE43899593E67E"))
	StripesRight:setShaderVector(0, 0, 1, 0, 0)
	StripesRight:setShaderVector(1, 0.2, 0.5, 0, 0)
	StripesRight:setShaderVector(2, 0, 1, 0, 0)
	StripesRight:setShaderVector(3, 0, 0, 0, 0)
	self:addElement(StripesRight)
	self.StripesRight = StripesRight
	local StripesLeft = CoD.VerticalStripes.new(f1_arg0, f1_arg1, 0, 0, -574, 60, 0.5, 0.5, -16, 16)
	StripesLeft:setAlpha(0.75)
	StripesLeft:setZRot(180)
	StripesLeft:setRFTMaterial(LUI.UIImage.GetCachedMaterial(@"hash_51DE43899593E67E"))
	StripesLeft:setShaderVector(0, 0, 1, 0, 0)
	StripesLeft:setShaderVector(1, 0.5, 0.2, 0, 0)
	StripesLeft:setShaderVector(2, 0, 1, 0, 0)
	StripesLeft:setShaderVector(3, 0, 0, 0, 0)
	self:addElement(StripesLeft)
	self.StripesLeft = StripesLeft
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.PC_StartMenu_Options_KeybindMessage_Stripes.__resetProperties = function(f2_arg0)
	f2_arg0.StripesRight:completeAnimation()
	f2_arg0.StripesLeft:completeAnimation()
end
CoD.PC_StartMenu_Options_KeybindMessage_Stripes.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(2)
			f3_arg0.StripesRight:completeAnimation()
			f3_arg0.StripesRight:playClip("DefaultClip")
			f3_arg0.clipFinished(f3_arg0.StripesRight)
			f3_arg0.StripesLeft:completeAnimation()
			f3_arg0.StripesLeft:playClip("DefaultClip")
			f3_arg0.clipFinished(f3_arg0.StripesLeft)
			f3_arg0.nextClip = "DefaultClip"
		end,
	},
}
CoD.PC_StartMenu_Options_KeybindMessage_Stripes.__onClose = function(f4_arg0)
	f4_arg0.StripesRight:close()
	f4_arg0.StripesLeft:close()
end
