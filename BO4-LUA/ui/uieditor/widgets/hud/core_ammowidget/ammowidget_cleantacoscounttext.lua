CoD.AmmoWidget_CleanTacosCountText = InheritFrom(LUI.UIElement)
CoD.AmmoWidget_CleanTacosCountText.__defaultWidth = 51
CoD.AmmoWidget_CleanTacosCountText.__defaultHeight = 16
CoD.AmmoWidget_CleanTacosCountText.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.AmmoWidget_CleanTacosCountText)
	self.id = "AmmoWidget_CleanTacosCountText"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local NumberCount = LUI.UIText.new(0, 0, 0, 51, 0, 0, 0, 16)
	NumberCount:setRGB(0, 0, 0)
	NumberCount:setText(Engine[0xF9F1239CFD921FE](0x93E719493E9E18F))
	NumberCount:setTTF("ttmussels_demibold")
	NumberCount:setMaterial(LUI.UIImage.GetCachedMaterial(0x90D57B1E92D39D7))
	NumberCount:setShaderVector(0, 0.68, 0, 0, 0)
	NumberCount:setShaderVector(1, 0, 0, 0, 0)
	NumberCount:setShaderVector(2, 0.07, 0.09, 0.04, 0.4)
	NumberCount:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	NumberCount:setAlignment(Enum[0x7A5123B654282D2][0xE821F0ECFF8D1C7])
	self:addElement(NumberCount)
	self.NumberCount = NumberCount
	self:mergeStateConditions({
		{
			stateName = "AsianLanguage",
			condition = function(menu, element, event)
				return CoD.BaseUtility.IsCurrentLanguageAsian()
			end,
		},
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.AmmoWidget_CleanTacosCountText.__resetProperties = function(f3_arg0)
	f3_arg0.NumberCount:completeAnimation()
	f3_arg0.NumberCount:setTopBottom(0, 0, 0, 16)
end
CoD.AmmoWidget_CleanTacosCountText.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(0)
		end,
	},
	AsianLanguage = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			f5_arg0.NumberCount:completeAnimation()
			f5_arg0.NumberCount:setTopBottom(0, 0, 4, 16)
			f5_arg0.clipFinished(f5_arg0.NumberCount)
		end,
	},
}
CoD.AmmoWidget_CleanTacosCountText.__onClose = function(f6_arg0)
	f6_arg0.NumberCount:close()
end
