require("x64:e95c1a1a693ac70")
CoD.requirementLabel = InheritFrom(LUI.UIElement)
CoD.requirementLabel.__defaultWidth = 144
CoD.requirementLabel.__defaultHeight = 36
CoD.requirementLabel.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.requirementLabel)
	self.id = "requirementLabel"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local TitleGlow1 = CoD.cac_ItemTitleGlow.new(f1_arg0, f1_arg1, 0, 1, -3, 5, 0, 1, -4, 4)
	TitleGlow1:setRGB(0.9, 0.9, 0.9)
	self:addElement(TitleGlow1)
	self.TitleGlow1 = TitleGlow1
	local requirementLabel2 = LUI.UIText.new(0, 0, 35, 149, 0, 0, -5, 40)
	requirementLabel2:setRGB(0, 0, 0)
	requirementLabel2:setAlpha(0.92)
	requirementLabel2:setText(Engine[0xF9F1239CFD921FE](0x525BE5A39DF06CA))
	requirementLabel2:setTTF("dinnext_regular")
	requirementLabel2:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	LUI.OverrideFunction_CallOriginalFirst(requirementLabel2, "setText", function(element, controller)
		ScaleWidgetToLabelLeftJustify(self, element, -10)
	end)
	self:addElement(requirementLabel2)
	self.requirementLabel2 = requirementLabel2
	local requirementLabel = LUI.UIText.new(0, 0, 34, 148, 0, 0, -5, 40)
	requirementLabel:setRGB(0, 0, 0)
	requirementLabel:setAlpha(0.92)
	requirementLabel:setText(Engine[0xF9F1239CFD921FE](0x525BE5A39DF06CA))
	requirementLabel:setTTF("dinnext_regular")
	requirementLabel:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	LUI.OverrideFunction_CallOriginalFirst(requirementLabel, "setText", function(element, controller)
		ScaleWidgetToLabelLeftJustify(self, element, -10)
	end)
	self:addElement(requirementLabel)
	self.requirementLabel = requirementLabel
	local Glow = LUI.UIImage.new(0, 1, -80, 74, 0.5, 0.5, -45, 65)
	Glow:setAlpha(0.14)
	Glow:setImage(RegisterImage(0x1078C36A022A4FE))
	Glow:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(Glow)
	self.Glow = Glow
	self:mergeStateConditions({
		{
			stateName = "InUse",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueGreaterThan(element, f1_arg1, "progress", 0)
			end,
		},
	})
	self:linkToElementModel(self, "progress", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "progress",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.requirementLabel.__resetProperties = function(f6_arg0)
	f6_arg0.requirementLabel2:completeAnimation()
	f6_arg0.requirementLabel2:setAlpha(0.92)
end
CoD.requirementLabel.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			f7_arg0.requirementLabel2:completeAnimation()
			f7_arg0.requirementLabel2:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.requirementLabel2)
		end,
	},
	InUse = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(0)
		end,
	},
}
CoD.requirementLabel.__onClose = function(f9_arg0)
	f9_arg0.TitleGlow1:close()
end
