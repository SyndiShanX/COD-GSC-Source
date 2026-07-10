CoD.MOTD_NoText_HeavyImage = InheritFrom(LUI.UIElement)
CoD.MOTD_NoText_HeavyImage.__defaultWidth = 1392
CoD.MOTD_NoText_HeavyImage.__defaultHeight = 680
CoD.MOTD_NoText_HeavyImage.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.MOTD_NoText_HeavyImage)
	self.id = "MOTD_NoText_HeavyImage"
	self.soundSet = "none"
	local Image = LUI.UIImage.new(0, 0, 0, 1392, 0, 0, 0, 680)
	Image:linkToElementModel(self, "popup_image", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			Image:setImage(RegisterImage(f2_local0))
		end
	end)
	self:addElement(Image)
	self.Image = Image
	local ItemFrame = LUI.UIImage.new(0, 1, -1, 1, 0, 1, -1, 1)
	ItemFrame:setImage(RegisterImage(0x185E11D74ECA3D7))
	ItemFrame:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD777557404A7B3))
	ItemFrame:setShaderVector(0, 0, 0, 0, 0)
	ItemFrame:setupNineSliceShader(12, 12)
	self:addElement(ItemFrame)
	self.ItemFrame = ItemFrame
	local ItemFrameAdd = LUI.UIImage.new(0, 1, -1, 1, 0, 1, -1, 1)
	ItemFrameAdd:setAlpha(0)
	ItemFrameAdd:setImage(RegisterImage(0x185E11D74ECA3D7))
	ItemFrameAdd:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD777557404A7B3))
	ItemFrameAdd:setShaderVector(0, 0, 0, 0, 0)
	ItemFrameAdd:setupNineSliceShader(12, 12)
	self:addElement(ItemFrameAdd)
	self.ItemFrameAdd = ItemFrameAdd
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.MOTD_NoText_HeavyImage.__onClose = function(f3_arg0)
	f3_arg0.Image:close()
end
