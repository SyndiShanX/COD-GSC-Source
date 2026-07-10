CoD.ScoreInfo_Meter = InheritFrom(LUI.UIElement)
CoD.ScoreInfo_Meter.__defaultWidth = 79
CoD.ScoreInfo_Meter.__defaultHeight = 36
CoD.ScoreInfo_Meter.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ScoreInfo_Meter)
	self.id = "ScoreInfo_Meter"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ImgMeterEnvBack = LUI.UIImage.new(0, 0, 0, 132, 0, 0, 0, 12)
	self:addElement(ImgMeterEnvBack)
	self.ImgMeterEnvBack = ImgMeterEnvBack
	local ImgMeterEnvFillLine = LUI.UIImage.new(0, 0, 0, 126, 0, 0, 3, 9)
	ImgMeterEnvFillLine:setMaterial(LUI.UIImage.GetCachedMaterial(0x910274CA3518744))
	ImgMeterEnvFillLine:setShaderVector(0, 1, 0, 0, 0)
	ImgMeterEnvFillLine:setShaderVector(1, 0, 0, 0, 0)
	ImgMeterEnvFillLine:setShaderVector(2, 1, 0, 0, 0)
	ImgMeterEnvFillLine:setShaderVector(3, 0, 0, 0, 0)
	ImgMeterEnvFillLine:setShaderVector(4, 0, 0, 0, 0)
	self:addElement(ImgMeterEnvFillLine)
	self.ImgMeterEnvFillLine = ImgMeterEnvFillLine
	self:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return not HideScoreMeterDueToGameType()
			end,
		},
	})
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ScoreInfo_Meter.__resetProperties = function(f3_arg0)
	f3_arg0.ImgMeterEnvBack:completeAnimation()
	f3_arg0.ImgMeterEnvFillLine:completeAnimation()
	f3_arg0.ImgMeterEnvBack:setAlpha(1)
	f3_arg0.ImgMeterEnvFillLine:setAlpha(1)
end
CoD.ScoreInfo_Meter.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(2)
			f4_arg0.ImgMeterEnvBack:completeAnimation()
			f4_arg0.ImgMeterEnvBack:setAlpha(0)
			f4_arg0.clipFinished(f4_arg0.ImgMeterEnvBack)
			f4_arg0.ImgMeterEnvFillLine:completeAnimation()
			f4_arg0.ImgMeterEnvFillLine:setAlpha(0)
			f4_arg0.clipFinished(f4_arg0.ImgMeterEnvFillLine)
		end,
	},
	Visible = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(0)
		end,
	},
}
