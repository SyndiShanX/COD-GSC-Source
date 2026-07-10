CoD.ContractSeasonalOverlay_PreviewButton = InheritFrom(LUI.UIElement)
CoD.ContractSeasonalOverlay_PreviewButton.__defaultWidth = 225
CoD.ContractSeasonalOverlay_PreviewButton.__defaultHeight = 309
CoD.ContractSeasonalOverlay_PreviewButton.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ContractSeasonalOverlay_PreviewButton)
	self.id = "ContractSeasonalOverlay_PreviewButton"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Border2 = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Border2:setRGB(0.67, 0.67, 0.67)
	Border2:setMaterial(LUI.UIImage.GetCachedMaterial(0xE7BDCB879A5176D))
	Border2:setShaderVector(0, 0, 0, 0, 0)
	Border2:setShaderVector(1, 0, 0, 0, 0)
	Border2:setupNineSliceShader(1, 1)
	self:addElement(Border2)
	self.Border2 = Border2
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ContractSeasonalOverlay_PreviewButton.__resetProperties = function(f2_arg0)
	f2_arg0.Border2:completeAnimation()
	f2_arg0.Border2:setAlpha(1)
end
CoD.ContractSeasonalOverlay_PreviewButton.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(1)
			f3_arg0.Border2:completeAnimation()
			f3_arg0.Border2:setAlpha(0)
			f3_arg0.clipFinished(f3_arg0.Border2)
		end,
	},
	Show = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(1)
			f4_arg0.Border2:completeAnimation()
			f4_arg0.Border2:setAlpha(1)
			f4_arg0.clipFinished(f4_arg0.Border2)
		end,
	},
}
