require("x64:62eee6f7ab7e3b3")
CoD.ZMInventoryListBackingInternal = InheritFrom(LUI.UIElement)
CoD.ZMInventoryListBackingInternal.__defaultWidth = 1380
CoD.ZMInventoryListBackingInternal.__defaultHeight = 80
CoD.ZMInventoryListBackingInternal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ZMInventoryListBackingInternal)
	self.id = "ZMInventoryListBackingInternal"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local SceneBlur = LUI.UIImage.new(-0.03, 1.03, 0, 0, 0, 1, 0, 0)
	SceneBlur:setRGB(0, 0, 0)
	SceneBlur:setMaterial(LUI.UIImage.GetCachedMaterial(0x81EEB1F96D4BE0A))
	SceneBlur:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(SceneBlur)
	self.SceneBlur = SceneBlur
	local SolidBase = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	SolidBase:setRGB(0, 0, 0)
	SolidBase:setAlpha(0.5)
	self:addElement(SolidBase)
	self.SolidBase = SolidBase
	local BaseGradientL = LUI.UIImage.new(-0.03, 0.5, 0, 0, 0, 1, 0, 0)
	BaseGradientL:setRGB(0, 0, 0)
	BaseGradientL:setAlpha(0.1)
	BaseGradientL:setMaterial(LUI.UIImage.GetCachedMaterial(0xDE760AC0E801E57))
	BaseGradientL:setShaderVector(0, 0, 0, 0, 15)
	BaseGradientL:setShaderVector(1, 0, 0, 0, 0)
	BaseGradientL:setShaderVector(2, 0.5, 0, 0, 0)
	self:addElement(BaseGradientL)
	self.BaseGradientL = BaseGradientL
	local BaseGradientR = LUI.UIImage.new(0.5, 1.03, 0, 0, 0, 1, 0, 0)
	BaseGradientR:setRGB(0, 0, 0)
	BaseGradientR:setAlpha(0.1)
	BaseGradientR:setMaterial(LUI.UIImage.GetCachedMaterial(0xDE760AC0E801E57))
	BaseGradientR:setShaderVector(0, 0, 0, 0, 0)
	BaseGradientR:setShaderVector(1, 0, 0, 0, 15)
	BaseGradientR:setShaderVector(2, 0.5, 0, 0, 0)
	self:addElement(BaseGradientR)
	self.BaseGradientR = BaseGradientR
	local TextureMid = LUI.UIImage.new(0, 1, 0, 0, 0.5, 0.5, -40, 40)
	TextureMid:setAlpha(0.8)
	TextureMid:setImage(RegisterImage(0xBB35BC5D2F0269C))
	TextureMid:setMaterial(LUI.UIImage.GetCachedMaterial(0xA02C44161370F6D))
	TextureMid:setShaderVector(0, 1, 0, 0, 0)
	TextureMid:setShaderVector(1, 1, 0, 0, 0)
	TextureMid:setShaderVector(2, 0, 0, 0, 0)
	self:addElement(TextureMid)
	self.TextureMid = TextureMid
	local Tip = CoD.ZMInventoryListBackingInternalTip.new(f1_arg0, f1_arg1, 0, 0, -100, 0, 0, 0, 0, 80)
	self:addElement(Tip)
	self.Tip = Tip
	local End = CoD.ZMInventoryListBackingInternalTip.new(f1_arg0, f1_arg1, 1, 1, 0, 100, 0, 0, 0, 80)
	End:setYRot(180)
	self:addElement(End)
	self.End = End
	local BGTip = LUI.UIImage.new(0, 0, -100, 0, 0, 0, -10, 90)
	BGTip:setImage(RegisterImage(0x92701A5677AD076))
	self:addElement(BGTip)
	self.BGTip = BGTip
	local BGEnd = LUI.UIImage.new(1, 1, 0, 100, 0, 0, -10, 90)
	BGEnd:setYRot(180)
	BGEnd:setImage(RegisterImage(0x92701A5677AD076))
	self:addElement(BGEnd)
	self.BGEnd = BGEnd
	local DividerBottom = LUI.UIImage.new(0.5, 0.5, -70, 70, 0, 0, 70, 90)
	DividerBottom:setImage(RegisterImage(0xE7AE208C672D6E3))
	self:addElement(DividerBottom)
	self.DividerBottom = DividerBottom
	self:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xF4EDA8B636F3F04])
			end,
		},
	})
	local f1_local11 = self
	local f1_local12 = self.subscribeToModel
	local f1_local13 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local12(f1_local11, f1_local13["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xF4EDA8B636F3F04]], function(f3_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f3_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xF4EDA8B636F3F04],
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ZMInventoryListBackingInternal.__onClose = function(f4_arg0)
	f4_arg0.Tip:close()
	f4_arg0.End:close()
end
