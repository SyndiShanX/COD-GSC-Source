CoD.LightmanColorElement = InheritFrom(LUI.UIElement)
CoD.LightmanColorElement.__defaultWidth = 40
CoD.LightmanColorElement.__defaultHeight = 20
CoD.LightmanColorElement.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.LightmanColorElement)
	self.id = "LightmanColorElement"
	self.soundSet = "SelectColor_ColorSwatchPicker"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local colorElement = LUI.UIImage.new(-0.1, 1.1, 4, -4, -0.2, 1.2, 4, -4)
	colorElement:linkToElementModel(self, "color", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			colorElement:setRGB(f2_local0)
		end
	end)
	self:addElement(colorElement)
	self.colorElement = colorElement
	local SelectorOverlay = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	SelectorOverlay:setRGB(0, 0, 0)
	SelectorOverlay:setAlpha(0)
	self:addElement(SelectorOverlay)
	self.SelectorOverlay = SelectorOverlay
	local FrontendFrameSelected = LUI.UIImage.new(0.5, 0.5, -25, 25, 0.5, 0.5, -15, 15)
	FrontendFrameSelected:setAlpha(0)
	FrontendFrameSelected:setImage(RegisterImage(@"uie_ui_menu_store_focus_frame"))
	FrontendFrameSelected:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_add"))
	FrontendFrameSelected:setShaderVector(0, 0, 0, 0, 0)
	FrontendFrameSelected:setupNineSliceShader(16, 16)
	self:addElement(FrontendFrameSelected)
	self.FrontendFrameSelected = FrontendFrameSelected
	local FrontendFrameSelectedGlow = LUI.UIImage.new(0.5, 0.5, -26, 26, 0.5, 0.5, -15, 15)
	FrontendFrameSelectedGlow:setAlpha(0)
	FrontendFrameSelectedGlow:setImage(RegisterImage(@"uie_ui_menu_store_focus_frame"))
	FrontendFrameSelectedGlow:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_add"))
	FrontendFrameSelectedGlow:setShaderVector(0, 0, 0, 0, 0)
	FrontendFrameSelectedGlow:setupNineSliceShader(20, 20)
	self:addElement(FrontendFrameSelectedGlow)
	self.FrontendFrameSelectedGlow = FrontendFrameSelectedGlow
	local FrontendFrame = LUI.UIImage.new(0.5, 0.5, -20.5, 20.5, 0.5, 0.5, -10.5, 10.5)
	FrontendFrame:setAlpha(0.8)
	FrontendFrame:setImage(RegisterImage(@"uie_ui_menu_store_common_frame"))
	FrontendFrame:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_add"))
	FrontendFrame:setShaderVector(0, 0, 0, 0, 0)
	FrontendFrame:setupNineSliceShader(7, 7)
	self:addElement(FrontendFrame)
	self.FrontendFrame = FrontendFrame
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.LightmanColorElement.__resetProperties = function(f3_arg0)
	f3_arg0.FrontendFrameSelected:completeAnimation()
	f3_arg0.FrontendFrameSelectedGlow:completeAnimation()
	f3_arg0.SelectorOverlay:completeAnimation()
	f3_arg0.FrontendFrameSelected:setAlpha(0)
	f3_arg0.FrontendFrameSelectedGlow:setAlpha(0)
	f3_arg0.SelectorOverlay:setAlpha(0)
end
CoD.LightmanColorElement.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(0)
		end,
		Focus = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(3)
			f5_arg0.SelectorOverlay:completeAnimation()
			f5_arg0.SelectorOverlay:setAlpha(0.02)
			f5_arg0.clipFinished(f5_arg0.SelectorOverlay)
			f5_arg0.FrontendFrameSelected:completeAnimation()
			f5_arg0.FrontendFrameSelected:setAlpha(1)
			f5_arg0.clipFinished(f5_arg0.FrontendFrameSelected)
			f5_arg0.FrontendFrameSelectedGlow:completeAnimation()
			f5_arg0.FrontendFrameSelectedGlow:setAlpha(0.05)
			f5_arg0.clipFinished(f5_arg0.FrontendFrameSelectedGlow)
		end,
	},
}
CoD.LightmanColorElement.__onClose = function(f6_arg0)
	f6_arg0.colorElement:close()
end
