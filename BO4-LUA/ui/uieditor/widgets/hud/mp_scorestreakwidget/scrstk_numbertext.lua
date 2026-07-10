CoD.ScrStk_NumberText = InheritFrom(LUI.UIElement)
CoD.ScrStk_NumberText.__defaultWidth = 60
CoD.ScrStk_NumberText.__defaultHeight = 16
CoD.ScrStk_NumberText.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ScrStk_NumberText)
	self.id = "ScrStk_NumberText"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local TextBox = LUI.UIText.new(0, 0, 0, 60, 0, 0, 0, 16)
	TextBox:setTTF("0arame_mono_stencil")
	TextBox:setMaterial(LUI.UIImage.GetCachedMaterial(0x90D57B1E92D39D7))
	TextBox:setShaderVector(0, 0.8, 0, 0, 0)
	TextBox:setShaderVector(1, 0, 0, 0, 0)
	TextBox:setShaderVector(2, 1, 1, 1, 0.25)
	TextBox:setLetterSpacing(1)
	TextBox:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	TextBox:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	TextBox:subscribeToGlobalModel(f1_arg1, "KillstreakRewards", "targetMomentum", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			TextBox:setText(f2_local0)
		end
	end)
	self:addElement(TextBox)
	self.TextBox = TextBox
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
CoD.ScrStk_NumberText.__resetProperties = function(f4_arg0)
	f4_arg0.TextBox:completeAnimation()
	f4_arg0.TextBox:setTopBottom(0, 0, 0, 16)
	f4_arg0.TextBox:setRGB(1, 1, 1)
end
CoD.ScrStk_NumberText.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(0)
		end,
	},
	AsianLanguage = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(1)
			f6_arg0.TextBox:completeAnimation()
			f6_arg0.TextBox:setTopBottom(0, 0, 5, 17)
			f6_arg0.TextBox:setRGB(1, 1, 1)
			f6_arg0.clipFinished(f6_arg0.TextBox)
		end,
	},
}
CoD.ScrStk_NumberText.__onClose = function(f7_arg0)
	f7_arg0.TextBox:close()
end
