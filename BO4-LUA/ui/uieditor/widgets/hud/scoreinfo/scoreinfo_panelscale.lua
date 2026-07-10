require("x64:4c633fa5960ca67")
CoD.ScoreInfo_PanelScale = InheritFrom(LUI.UIElement)
CoD.ScoreInfo_PanelScale.__defaultWidth = 84
CoD.ScoreInfo_PanelScale.__defaultHeight = 84
CoD.ScoreInfo_PanelScale.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ScoreInfo_PanelScale)
	self.id = "ScoreInfo_PanelScale"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ScoreInfoPanelScaleContainer0 = CoD.ScoreInfo_PanelScaleContainer.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	ScoreInfoPanelScaleContainer0:setRFTMaterial(LUI.UIImage.GetCachedMaterial(@"uie_scene_blur_pass_2_highquality"))
	ScoreInfoPanelScaleContainer0:setShaderVector(0, 30, 10, 0, 0)
	self:addElement(ScoreInfoPanelScaleContainer0)
	self.ScoreInfoPanelScaleContainer0 = ScoreInfoPanelScaleContainer0
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ScoreInfo_PanelScale.__resetProperties = function(f2_arg0)
	f2_arg0.ScoreInfoPanelScaleContainer0:completeAnimation()
	f2_arg0.ScoreInfoPanelScaleContainer0:setAlpha(1)
end
CoD.ScoreInfo_PanelScale.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(0)
		end,
	},
	Invisible = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(1)
			f4_arg0.ScoreInfoPanelScaleContainer0:completeAnimation()
			f4_arg0.ScoreInfoPanelScaleContainer0:setAlpha(0)
			f4_arg0.clipFinished(f4_arg0.ScoreInfoPanelScaleContainer0)
		end,
	},
}
CoD.ScoreInfo_PanelScale.__onClose = function(f5_arg0)
	f5_arg0.ScoreInfoPanelScaleContainer0:close()
end
