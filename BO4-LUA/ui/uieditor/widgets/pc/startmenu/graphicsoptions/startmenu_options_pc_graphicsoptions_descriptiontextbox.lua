CoD.StartMenu_Options_PC_GraphicsOptions_DescriptionTextBox = InheritFrom(LUI.UIElement)
CoD.StartMenu_Options_PC_GraphicsOptions_DescriptionTextBox.__defaultWidth = 673
CoD.StartMenu_Options_PC_GraphicsOptions_DescriptionTextBox.__defaultHeight = 200
CoD.StartMenu_Options_PC_GraphicsOptions_DescriptionTextBox.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.StartMenu_Options_PC_GraphicsOptions_DescriptionTextBox)
	self.id = "StartMenu_Options_PC_GraphicsOptions_DescriptionTextBox"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local bg = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	bg:setRGB(0.13, 0.12, 0.12)
	bg:setAlpha(0.5)
	self:addElement(bg)
	self.bg = bg
	local detailedDescription = LUI.UIText.new(0, 0.98, 7, 7, 0, 0, 5, 23)
	detailedDescription:setRGB(0.63, 0.62, 0.61)
	detailedDescription:setTTF("ttmussels_regular")
	detailedDescription:setLetterSpacing(2)
	detailedDescription:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	detailedDescription:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(detailedDescription)
	self.detailedDescription = detailedDescription
	local LineBottom01 = LUI.UIImage.new(0, 1, 0, 0, 0, 0, 0, 1)
	LineBottom01:setRGB(0.38, 0.36, 0.33)
	LineBottom01:setAlpha(0.25)
	self:addElement(LineBottom01)
	self.LineBottom01 = LineBottom01
	local CornerDotBR01 = LUI.UIImage.new(1, 1, -1, 0, 0, 0, 0, 1)
	CornerDotBR01:setAlpha(0.25)
	self:addElement(CornerDotBR01)
	self.CornerDotBR01 = CornerDotBR01
	local CornerDotBL01 = LUI.UIImage.new(0, 0, 0, 1, 0, 0, 0, 1)
	CornerDotBL01:setAlpha(0.25)
	self:addElement(CornerDotBL01)
	self.CornerDotBL01 = CornerDotBL01
	local LineBottom = LUI.UIImage.new(0, 1, 0, 0, 1, 1, -1, 0)
	LineBottom:setRGB(0.38, 0.36, 0.33)
	LineBottom:setAlpha(0.25)
	self:addElement(LineBottom)
	self.LineBottom = LineBottom
	local CornerDotBR = LUI.UIImage.new(1, 1, -1, 0, 1, 1, -1, 0)
	CornerDotBR:setAlpha(0.25)
	self:addElement(CornerDotBR)
	self.CornerDotBR = CornerDotBR
	local CornerDotBL = LUI.UIImage.new(0, 0, 0, 1, 1, 1, -1, 0)
	CornerDotBL:setAlpha(0.25)
	self:addElement(CornerDotBL)
	self.CornerDotBL = CornerDotBL
	local CornerDotBR2 = LUI.UIImage.new(1, 1, -1, 0, 0.85, 0.85, -1, 0)
	CornerDotBR2:setAlpha(0.25)
	self:addElement(CornerDotBR2)
	self.CornerDotBR2 = CornerDotBR2
	local CornerDotBL2 = LUI.UIImage.new(0, 0, 0, 1, 0.85, 0.85, -1, 0)
	CornerDotBL2:setAlpha(0.25)
	self:addElement(CornerDotBL2)
	self.CornerDotBL2 = CornerDotBL2
	local CornerDotBR3 = LUI.UIImage.new(1, 1, -1, 0, 0.15, 0.15, 0, 1)
	CornerDotBR3:setAlpha(0.25)
	self:addElement(CornerDotBR3)
	self.CornerDotBR3 = CornerDotBR3
	local CornerDotBL3 = LUI.UIImage.new(0, 0, 0, 1, 0.15, 0.15, 0, 1)
	CornerDotBL3:setAlpha(0.25)
	self:addElement(CornerDotBL3)
	self.CornerDotBL3 = CornerDotBL3
	self.detailedDescription:linkToElementModel(self, "desc", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			detailedDescription:setText(Engine[0xF9F1239CFD921FE](f2_local0))
		end
	end)
	self:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueNonEmptyString(element, f1_arg1, "detailedDescription") and CoD.ModelUtility.AreButtonModelValueBitsSet(f1_arg1, Enum[0x3DD78803F918E9D][0x820DDD869ABBFAA], Enum[0xE29E259801BC1A4][0x253A6F6CAAAE464])
			end,
		},
	})
	self:linkToElementModel(self, "detailedDescription", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "detailedDescription",
		})
	end)
	local f1_local13 = self
	local f1_local14 = self.subscribeToModel
	local f1_local15 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local14(f1_local13, f1_local15["ButtonBits." .. Enum[0x3DD78803F918E9D][0x820DDD869ABBFAA]], function(f5_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f5_arg0:get(),
			modelName = "ButtonBits." .. Enum[0x3DD78803F918E9D][0x820DDD869ABBFAA],
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.StartMenu_Options_PC_GraphicsOptions_DescriptionTextBox.__resetProperties = function(f6_arg0)
	f6_arg0.detailedDescription:completeAnimation()
	f6_arg0.bg:completeAnimation()
	f6_arg0.detailedDescription:setAlpha(1)
	f6_arg0.bg:setLeftRight(0, 1, 0, 0)
	f6_arg0.bg:setTopBottom(0, 1, 0, 0)
	f6_arg0.bg:setAlpha(0.5)
end
CoD.StartMenu_Options_PC_GraphicsOptions_DescriptionTextBox.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(2)
			f7_arg0.bg:completeAnimation()
			f7_arg0.bg:setLeftRight(0, 1, 0, 0)
			f7_arg0.bg:setTopBottom(0, 1, 0, 0)
			f7_arg0.bg:setAlpha(1)
			f7_arg0.clipFinished(f7_arg0.bg)
			f7_arg0.detailedDescription:completeAnimation()
			f7_arg0.detailedDescription:setAlpha(1)
			f7_arg0.clipFinished(f7_arg0.detailedDescription)
		end,
		Active = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(2)
			f8_arg0.bg:completeAnimation()
			f8_arg0.bg:setLeftRight(0, 1, 0, 0)
			f8_arg0.bg:setTopBottom(0, 1, 0, 0)
			f8_arg0.bg:setAlpha(1)
			f8_arg0.clipFinished(f8_arg0.bg)
			f8_arg0.detailedDescription:completeAnimation()
			f8_arg0.detailedDescription:setAlpha(1)
			f8_arg0.clipFinished(f8_arg0.detailedDescription)
		end,
	},
	Visible = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(2)
			f9_arg0.bg:completeAnimation()
			f9_arg0.bg:setAlpha(1)
			f9_arg0.clipFinished(f9_arg0.bg)
			f9_arg0.detailedDescription:completeAnimation()
			f9_arg0.detailedDescription:setAlpha(1)
			f9_arg0.clipFinished(f9_arg0.detailedDescription)
		end,
		DefaultState = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(2)
			local f10_local0 = function(f11_arg0)
				f11_arg0:beginAnimation(80)
				f11_arg0:setTopBottom(0, 0, 0, 0)
				f11_arg0:registerEventHandler("transition_complete_keyframe", f10_arg0.clipFinished)
			end
			f10_arg0.bg:beginAnimation(20)
			f10_arg0.bg:setLeftRight(0, 1, 0, 0)
			f10_arg0.bg:setTopBottom(0, 1, 0, 0)
			f10_arg0.bg:registerEventHandler("interrupted_keyframe", f10_arg0.clipInterrupted)
			f10_arg0.bg:registerEventHandler("transition_complete_keyframe", f10_local0)
			local f10_local1 = function(f12_arg0)
				f12_arg0:beginAnimation(80)
				f12_arg0:setAlpha(0)
				f12_arg0:registerEventHandler("transition_complete_keyframe", f10_arg0.clipFinished)
			end
			f10_arg0.detailedDescription:beginAnimation(20)
			f10_arg0.detailedDescription:setAlpha(1)
			f10_arg0.detailedDescription:registerEventHandler("interrupted_keyframe", f10_arg0.clipInterrupted)
			f10_arg0.detailedDescription:registerEventHandler("transition_complete_keyframe", f10_local1)
		end,
	},
}
CoD.StartMenu_Options_PC_GraphicsOptions_DescriptionTextBox.__onClose = function(f13_arg0)
	f13_arg0.detailedDescription:close()
end
