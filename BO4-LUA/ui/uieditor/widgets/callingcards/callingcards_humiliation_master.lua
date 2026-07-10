require("x64:277736d6c11a9b6")
require("x64:b15867d4020da07")
CoD[0x4D290CE58D45F81] = InheritFrom(LUI.UIElement)
CoD[0x4D290CE58D45F81].__defaultWidth = 960
CoD[0x4D290CE58D45F81].__defaultHeight = 240
CoD[0x4D290CE58D45F81].new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD[0x4D290CE58D45F81])
	self.id = "CallingCards_Humiliation_Master"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local bg = LUI.UIImage.new(0, 0, 0, 960, 0, 0, 0, 240)
	bg:setImage(RegisterImage(0x35487D8F59DABC7))
	bg:setMaterial(LUI.UIImage.GetCachedMaterial(0x73D72BCD14C2AAD))
	bg:setShaderVector(0, 1, 1, 0, 0)
	bg:setShaderVector(1, 0, 0.25, 0, 0)
	self:addElement(bg)
	self.bg = bg
	local grunt = CoD.CallingCards_Asset_grunt_radio.new(f1_arg0, f1_arg1, 0, 0, 414, 960, 0, 0, 0, 240)
	self:addElement(grunt)
	self.grunt = grunt
	local gun = CoD.CallingCards_Asset_grunt_gun.new(f1_arg0, f1_arg1, 0, 0, 158, 766, 0, 0, -5.5, 234.5)
	self:addElement(gun)
	self.gun = gun
	local cropper = LUI.UIImage.new(0, 0, -32, 992, 0, 0, -392, 632)
	cropper:setAlpha(0)
	cropper:setImage(RegisterImage(0x7EEE1693E39382A))
	self:addElement(cropper)
	self.cropper = cropper
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD[0x4D290CE58D45F81].__resetProperties = function(f2_arg0)
	f2_arg0.gun:completeAnimation()
	f2_arg0.grunt:completeAnimation()
	f2_arg0.gun:setLeftRight(0, 0, 158, 766)
	f2_arg0.gun:setTopBottom(0, 0, -5.5, 234.5)
end
CoD[0x4D290CE58D45F81].__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(2)
			f3_arg0.grunt:completeAnimation()
			f3_arg0.grunt:playClip("DefaultClip")
			f3_arg0.clipFinished(f3_arg0.grunt)
			f3_arg0.gun:completeAnimation()
			f3_arg0.gun:setLeftRight(0, 0, 176, 784)
			f3_arg0.gun:setTopBottom(0, 0, 16.5, 256.5)
			f3_arg0.gun:playClip("DefaultClip")
			f3_arg0.clipFinished(f3_arg0.gun)
			f3_arg0.nextClip = "DefaultClip"
		end,
	},
}
CoD[0x4D290CE58D45F81].__onClose = function(f4_arg0)
	f4_arg0.grunt:close()
	f4_arg0.gun:close()
end
