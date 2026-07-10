require("x64:e95c1a1a693ac70")
CoD.nameLabel = InheritFrom(LUI.UIElement)
CoD.nameLabel.__defaultWidth = 159
CoD.nameLabel.__defaultHeight = 30
CoD.nameLabel.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.nameLabel)
	self.id = "nameLabel"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Glow = LUI.UIImage.new(0, 1, -80, 74, 0.5, 0.5, -45, 65)
	Glow:setAlpha(0.14)
	Glow:setImage(RegisterImage(0x1078C36A022A4FE))
	Glow:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(Glow)
	self.Glow = Glow
	local TitleGlow1 = CoD.cac_ItemTitleGlow.new(f1_arg0, f1_arg1, 0, 1, -3, 5, 0, 1, -4, 4)
	TitleGlow1:setRGB(0.44, 0.44, 0.44)
	TitleGlow1:setAlpha(0.97)
	self:addElement(TitleGlow1)
	self.TitleGlow1 = TitleGlow1
	local nameLabel = LUI.UIText.new(0, 0, 36, 198, 0, 0, 0, 30)
	nameLabel:setRGB(0, 0, 0)
	nameLabel:setAlpha(0.92)
	nameLabel:setTTF("default")
	nameLabel:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	nameLabel:linkToElementModel(self, "text", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			nameLabel:setText(Engine[0xF9F1239CFD921FE](f2_local0))
		end
	end)
	LUI.OverrideFunction_CallOriginalFirst(nameLabel, "setText", function(element, controller)
		if not IsSelfInState(self, "ShowDistance") then
			ScaleWidgetToLabelLeftJustify(self, element, -14)
		end
	end)
	self:addElement(nameLabel)
	self.nameLabel = nameLabel
	local distanceLabel = LUI.UIText.new(0, 0, 36, 198, 0, 0, 0, 30)
	distanceLabel:setRGB(0, 0, 0)
	distanceLabel:setAlpha(0)
	distanceLabel:setTTF("default")
	distanceLabel:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	distanceLabel:linkToElementModel(self, "distanceText", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			distanceLabel:setText(LocalizeIntoStringIfNotEmpty(0x7235825812D46C6, f4_local0))
		end
	end)
	LUI.OverrideFunction_CallOriginalFirst(distanceLabel, "setText", function(element, controller)
		if IsSelfInState(self, "ShowDistance") then
			ScaleWidgetToLabelLeftJustify(self, element, -14)
		end
	end)
	self:addElement(distanceLabel)
	self.distanceLabel = distanceLabel
	self:mergeStateConditions({
		{
			stateName = "ShowDistance",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueNonEmptyString(self, f1_arg1, "distanceText")
			end,
		},
	})
	self:linkToElementModel(self, "distanceText", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "distanceText",
		})
	end)
	LUI.OverrideFunction_CallOriginalFirst(self, "setState", function(element, controller, f8_arg2, f8_arg3, f8_arg4)
		if IsSelfInState(self, "ShowDistance") then
			ScaleWidgetToLabelLeftJustify(self, self.distanceLabel, -14)
		else
			ScaleWidgetToLabelLeftJustify(self, self.nameLabel, -14)
		end
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.nameLabel.__resetProperties = function(f9_arg0)
	f9_arg0.distanceLabel:completeAnimation()
	f9_arg0.nameLabel:completeAnimation()
	f9_arg0.distanceLabel:setAlpha(0)
	f9_arg0.nameLabel:setAlpha(0.92)
end
CoD.nameLabel.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(0)
		end,
	},
	ShowDistance = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(2)
			f11_arg0.nameLabel:completeAnimation()
			f11_arg0.nameLabel:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.nameLabel)
			f11_arg0.distanceLabel:completeAnimation()
			f11_arg0.distanceLabel:setAlpha(0.92)
			f11_arg0.clipFinished(f11_arg0.distanceLabel)
		end,
	},
}
CoD.nameLabel.__onClose = function(f12_arg0)
	f12_arg0.TitleGlow1:close()
	f12_arg0.nameLabel:close()
	f12_arg0.distanceLabel:close()
end
