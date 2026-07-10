require("x64:eeba57f916954d1")
CoD.Armory_AttachmentPip = InheritFrom(LUI.UIElement)
CoD.Armory_AttachmentPip.__defaultWidth = 12
CoD.Armory_AttachmentPip.__defaultHeight = 12
CoD.Armory_AttachmentPip.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Armory_AttachmentPip)
	self.id = "Armory_AttachmentPip"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local PipEmpty = LUI.UIImage.new(0.5, 0.5, -16, 16, 0.5, 0.5, -16, 16)
	PipEmpty:setAlpha(0)
	PipEmpty:setScale(0.8, 0.3)
	PipEmpty:setImage(RegisterImage(@"uie_ui_menu_zm_allocation_pip_empty"))
	PipEmpty:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_saturation_normal"))
	PipEmpty:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(PipEmpty)
	self.PipEmpty = PipEmpty
	local Pip = LUI.UIImage.new(0.5, 0.5, -16, 16, 0.5, 0.5, -16, 16)
	Pip:setScale(0.8, 0.3)
	Pip:setImage(RegisterImage(@"hash_2DEF2421CC0F94C"))
	self:addElement(Pip)
	self.Pip = Pip
	local PipCorners = LUI.UIImage.new(0.5, 0.5, -16, 16, 0.5, 0.5, -16, 16)
	PipCorners:setAlpha(0)
	PipCorners:setScale(0.8, 0.3)
	PipCorners:setImage(RegisterImage(@"uie_ui_menu_cac_allocation_pip_dots"))
	self:addElement(PipCorners)
	self.PipCorners = PipCorners
	local Lock = CoD.cac_lock.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	Lock:setAlpha(0)
	self:addElement(Lock)
	self.Lock = Lock
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.Armory_AttachmentPip.__resetProperties = function(f2_arg0)
	f2_arg0.Pip:completeAnimation()
	f2_arg0.PipCorners:completeAnimation()
	f2_arg0.Lock:completeAnimation()
	f2_arg0.PipEmpty:completeAnimation()
	f2_arg0.Pip:setRGB(1, 1, 1)
	f2_arg0.Pip:setAlpha(1)
	f2_arg0.PipCorners:setAlpha(0)
	f2_arg0.Lock:setAlpha(0)
	f2_arg0.PipEmpty:setRGB(1, 1, 1)
	f2_arg0.PipEmpty:setAlpha(0)
	f2_arg0.PipEmpty:setShaderVector(0, 1, 0, 0, 0)
end
CoD.Armory_AttachmentPip.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(0)
		end,
	},
	Hidden = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(2)
			f4_arg0.Pip:completeAnimation()
			f4_arg0.Pip:setAlpha(0)
			f4_arg0.clipFinished(f4_arg0.Pip)
			f4_arg0.PipCorners:completeAnimation()
			f4_arg0.PipCorners:setAlpha(0)
			f4_arg0.clipFinished(f4_arg0.PipCorners)
		end,
	},
	Locked = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(3)
			f5_arg0.PipEmpty:completeAnimation()
			f5_arg0.PipEmpty:setRGB(0.78, 0.78, 0.78)
			f5_arg0.PipEmpty:setAlpha(1)
			f5_arg0.PipEmpty:setShaderVector(0, 0.5, 0, 0, 0)
			f5_arg0.clipFinished(f5_arg0.PipEmpty)
			f5_arg0.Pip:completeAnimation()
			f5_arg0.Pip:setRGB(0.14, 0.14, 0.14)
			f5_arg0.Pip:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.Pip)
			f5_arg0.Lock:completeAnimation()
			f5_arg0.Lock:setAlpha(1)
			f5_arg0.clipFinished(f5_arg0.Lock)
		end,
	},
	Empty = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(2)
			f6_arg0.PipEmpty:completeAnimation()
			f6_arg0.PipEmpty:setAlpha(1)
			f6_arg0.clipFinished(f6_arg0.PipEmpty)
			f6_arg0.Pip:completeAnimation()
			f6_arg0.Pip:setRGB(0.2, 0.2, 0.02)
			f6_arg0.Pip:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.Pip)
		end,
	},
}
CoD.Armory_AttachmentPip.__onClose = function(f7_arg0)
	f7_arg0.Lock:close()
end
