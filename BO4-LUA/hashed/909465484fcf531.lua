CoD.EquippedBGBCount = InheritFrom(LUI.UIElement)
CoD.EquippedBGBCount.__defaultWidth = 78
CoD.EquippedBGBCount.__defaultHeight = 28
CoD.EquippedBGBCount.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.EquippedBGBCount)
	self.id = "EquippedBGBCount"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Count = LUI.UIText.new(0, 1, 0, 0, 0, 1, 3, 3)
	Count:setRGB(0.58, 0.58, 0.58)
	Count:setText(888)
	Count:setTTF("skorzhen")
	Count:setMaterial(LUI.UIImage.GetCachedMaterial(0x90D57B1E92D39D7))
	Count:setShaderVector(0, 1, 0, 0, 0)
	Count:setShaderVector(1, 0, 0, 0, 0)
	Count:setShaderVector(2, 0, 0, 0, 0.9)
	Count:setLetterSpacing(2)
	Count:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	Count:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(Count)
	self.Count = Count
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.EquippedBGBCount.__resetProperties = function(f2_arg0)
	f2_arg0.Count:completeAnimation()
	f2_arg0.Count:setAlpha(1)
end
CoD.EquippedBGBCount.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(0)
		end,
	},
	Hidden = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(1)
			f4_arg0.Count:completeAnimation()
			f4_arg0.Count:setAlpha(0)
			f4_arg0.clipFinished(f4_arg0.Count)
		end,
	},
}
