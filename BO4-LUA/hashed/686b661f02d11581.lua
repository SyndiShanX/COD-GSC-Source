require("x64:76fa323de4745ba")
require("x64:7a75ec1647cc628")
require("x64:42e9560149fc926")
CoD.ZMTalismanSlot = InheritFrom(LUI.UIElement)
CoD.ZMTalismanSlot.__defaultWidth = 90
CoD.ZMTalismanSlot.__defaultHeight = 90
CoD.ZMTalismanSlot.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ZMTalismanSlot)
	self.id = "ZMTalismanSlot"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Blur = LUI.UIImage.new(0, 0, -20, 112, 0, 0, -23, 109)
	Blur:setZRot(45)
	Blur:setMaterial(LUI.UIImage.GetCachedMaterial(0xE2354BE557C4C7A))
	Blur:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(Blur)
	self.Blur = Blur
	local Tint = LUI.UIImage.new(0, 0, 0, 90, 0, 0, 0, 90)
	Tint:setRGB(0, 0, 0)
	Tint:setAlpha(0)
	Tint:setZRot(45)
	self:addElement(Tint)
	self.Tint = Tint
	local Box = LUI.UIImage.new(0, 0, -63, 153, 0, 0, -63, 153)
	Box:setAlpha(0.5)
	Box:setImage(RegisterImage(0x3BCBBC8226622A5))
	self:addElement(Box)
	self.Box = Box
	local PerkPreviewIcon = CoD.TalentPreviewIcon.new(f1_arg0, f1_arg1, 0.1, 0.9, 0, 0, 0.1, 0.9, 0, 0)
	PerkPreviewIcon:mergeStateConditions({
		{
			stateName = "Preview",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalDataSourceModelValueNonEmptyString(f1_arg1, "TalentSelect", "previewImage")
			end,
		},
	})
	local EmptyText = PerkPreviewIcon
	local PerkIcon = PerkPreviewIcon.subscribeToModel
	local EmptyIcon = DataSources.TalentSelect.getModel(f1_arg1)
	PerkIcon(EmptyText, EmptyIcon.previewImage, function(f3_arg0)
		f1_arg0:updateElementState(PerkPreviewIcon, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f3_arg0:get(),
			modelName = "previewImage",
		})
	end, false)
	PerkPreviewIcon:setAlpha(0)
	PerkPreviewIcon:linkToElementModel(self, "image", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			PerkPreviewIcon.TalentIcon:setImage(RegisterImage(BlackTransparentIfNilOrEmpty(f4_local0)))
		end
	end)
	self:addElement(PerkPreviewIcon)
	self.PerkPreviewIcon = PerkPreviewIcon
	PerkIcon = LUI.UIImage.new(0.1, 0.9, 0, 0, 0.1, 0.9, -2, -2)
	PerkIcon:linkToElementModel(self, "image", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			PerkIcon:setImage(RegisterImage(f5_local0))
		end
	end)
	self:addElement(PerkIcon)
	self.PerkIcon = PerkIcon
	EmptyText = LUI.UIText.new(0.5, 0.5, -100, 100, 0, 0, 114, 138)
	EmptyText:setRGB(0.56, 0.56, 0.56)
	EmptyText:setAlpha(0)
	EmptyText:setText(Engine[0xF9F1239CFD921FE](0xB67F7FB585D594C))
	EmptyText:setTTF("dinnext_regular")
	EmptyText:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	EmptyText:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(EmptyText)
	self.EmptyText = EmptyText
	EmptyIcon = LUI.UIImage.new(0.5, 0.5, -40, 40, 0.5, 0.5, -43, 37)
	EmptyIcon:setRGB(ColorSet.T8__BEIGE__HEADER.r, ColorSet.T8__BEIGE__HEADER.g, ColorSet.T8__BEIGE__HEADER.b)
	EmptyIcon:setAlpha(0)
	EmptyIcon:setImage(RegisterImage(0x8813AFA41490306))
	EmptyIcon:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(EmptyIcon)
	self.EmptyIcon = EmptyIcon
	local Selected = CoD.uie_Border.new(f1_arg0, f1_arg1, 0, 0, 0, 90, 0, 0, 0, 90)
	Selected:setRGB(0.93, 0.93, 0)
	Selected:setAlpha(0)
	Selected:setZRot(45)
	self:addElement(Selected)
	self.Selected = Selected
	local RestrictionIcon = CoD.RestrictedItemWarning.new(f1_arg0, f1_arg1, 0.5, 0.5, -29, 31, 0.5, 0.5, -35, 15)
	RestrictionIcon:linkToElementModel(self, nil, false, function(model)
		RestrictionIcon:setModel(model, f1_arg1)
	end)
	self:addElement(RestrictionIcon)
	self.RestrictionIcon = RestrictionIcon
	self:mergeStateConditions({
		{
			stateName = "Empty",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "itemIndex", CoD.CACUtility.EmptyItemIndex)
			end,
		},
	})
	self:linkToElementModel(self, "itemIndex", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "itemIndex",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ZMTalismanSlot.__resetProperties = function(f9_arg0)
	f9_arg0.EmptyIcon:completeAnimation()
	f9_arg0.EmptyText:completeAnimation()
	f9_arg0.PerkIcon:completeAnimation()
	f9_arg0.EmptyIcon:setAlpha(0)
	f9_arg0.EmptyText:setAlpha(0)
	f9_arg0.PerkIcon:setAlpha(1)
end
CoD.ZMTalismanSlot.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(0)
		end,
	},
	Empty = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(3)
			f11_arg0.PerkIcon:completeAnimation()
			f11_arg0.PerkIcon:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.PerkIcon)
			f11_arg0.EmptyText:completeAnimation()
			f11_arg0.EmptyText:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.EmptyText)
			f11_arg0.EmptyIcon:completeAnimation()
			f11_arg0.EmptyIcon:setAlpha(0.35)
			f11_arg0.clipFinished(f11_arg0.EmptyIcon)
		end,
	},
}
CoD.ZMTalismanSlot.__onClose = function(f12_arg0)
	f12_arg0.PerkPreviewIcon:close()
	f12_arg0.PerkIcon:close()
	f12_arg0.Selected:close()
	f12_arg0.RestrictionIcon:close()
end
