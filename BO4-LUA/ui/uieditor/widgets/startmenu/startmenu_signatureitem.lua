require("x64:76fa323de4745ba")
require("x64:94dab3a4d2d79b2")
CoD.StartMenu_SignatureItem = InheritFrom(LUI.UIElement)
CoD.StartMenu_SignatureItem.__defaultWidth = 540
CoD.StartMenu_SignatureItem.__defaultHeight = 115
CoD.StartMenu_SignatureItem.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.StartMenu_SignatureItem)
	self.id = "StartMenu_SignatureItem"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local backgroundBlur = LUI.UIImage.new(0, 0, 1, 537, 0, 0, 0, 115)
	backgroundBlur:setRGB(0, 0, 0)
	backgroundBlur:setMaterial(LUI.UIImage.GetCachedMaterial(0xE2354BE557C4C7A))
	backgroundBlur:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(backgroundBlur)
	self.backgroundBlur = backgroundBlur
	local background = LUI.UIImage.new(0.03, 0.03, -16, 521, 0.05, 0.05, -5.5, 109.5)
	background:setRGB(0, 0, 0)
	background:setAlpha(0.92)
	self:addElement(background)
	self.background = background
	local LED = LUI.UIImage.new(0, 0, 0, 538, 0, 0, 0, 166)
	LED:setAlpha(0.2)
	LED:setImage(RegisterImage(0x35AB669B497516))
	LED:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(LED)
	self.LED = LED
	local descriptionTextBox = LUI.UIText.new(0, 0, 130, 521, 0, 0, 36, 54)
	descriptionTextBox:setRGB(0.78, 0.78, 0.78)
	descriptionTextBox:setZoom(10)
	descriptionTextBox:setTTF("dinnext_regular")
	descriptionTextBox:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	descriptionTextBox:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	descriptionTextBox:linkToElementModel(self, "description", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			descriptionTextBox:setText(Engine[0xF9F1239CFD921FE](f2_local0))
		end
	end)
	self:addElement(descriptionTextBox)
	self.descriptionTextBox = descriptionTextBox
	local nameLabel = LUI.UIText.new(0, 0, 130, 332, 0, 0, 13, 31)
	nameLabel:setRGB(ColorSet.T8__BEIGE__HEADER.r, ColorSet.T8__BEIGE__HEADER.g, ColorSet.T8__BEIGE__HEADER.b)
	nameLabel:setZoom(10)
	nameLabel:setTTF("ttmussels_demibold")
	nameLabel:setLetterSpacing(5)
	nameLabel:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	nameLabel:linkToElementModel(self, "displayName", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			nameLabel:setText(LocalizeToUpperString(f3_local0))
		end
	end)
	self:addElement(nameLabel)
	self.nameLabel = nameLabel
	local Corner9Slice = CoD.Corner9Slice.new(f1_arg0, f1_arg1, 0, 0, 7, 109, 0, 0, 13, 104)
	Corner9Slice:setAlpha(0.5)
	self:addElement(Corner9Slice)
	self.Corner9Slice = Corner9Slice
	local Icon = LUI.UIFixedAspectRatioImage.new(0, 0, 10, 105, 0, 0, 8.5, 106.5)
	Icon:setStretchedDimension(4)
	Icon:linkToElementModel(self, "image", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			Icon:setImage(RegisterImage(f4_local0))
		end
	end)
	self:addElement(Icon)
	self.Icon = Icon
	local Bracket = LUI.UIImage.new(0, 0, -12, 552, 0, 0, -9.5, 122.5)
	Bracket:setAlpha(0.5)
	Bracket:setImage(RegisterImage(0xE657E04763BA68E))
	Bracket:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(Bracket)
	self.Bracket = Bracket
	local RestrictionIcon = CoD.RestrictedItemWarning.new(f1_arg0, f1_arg1, 0.5, 0.5, -243, -183, 0.5, 0.5, -29, 21)
	RestrictionIcon:linkToElementModel(self, nil, false, function(model)
		RestrictionIcon:setModel(model, f1_arg1)
	end)
	self:addElement(RestrictionIcon)
	self.RestrictionIcon = RestrictionIcon
	self:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return CoD.HUDUtility.HideSignatureItem(f1_arg1)
			end,
		},
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.StartMenu_SignatureItem.__resetProperties = function(f7_arg0)
	f7_arg0.backgroundBlur:completeAnimation()
	f7_arg0.Bracket:completeAnimation()
	f7_arg0.Icon:completeAnimation()
	f7_arg0.Corner9Slice:completeAnimation()
	f7_arg0.nameLabel:completeAnimation()
	f7_arg0.descriptionTextBox:completeAnimation()
	f7_arg0.LED:completeAnimation()
	f7_arg0.background:completeAnimation()
	f7_arg0.RestrictionIcon:completeAnimation()
	f7_arg0.backgroundBlur:setAlpha(1)
	f7_arg0.Bracket:setAlpha(0.5)
	f7_arg0.Icon:setAlpha(1)
	f7_arg0.Corner9Slice:setAlpha(0.5)
	f7_arg0.nameLabel:setAlpha(1)
	f7_arg0.descriptionTextBox:setAlpha(1)
	f7_arg0.LED:setAlpha(0.2)
	f7_arg0.background:setAlpha(0.92)
	f7_arg0.RestrictionIcon:setAlpha(1)
end
CoD.StartMenu_SignatureItem.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(0)
		end,
	},
	Hidden = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(9)
			f9_arg0.backgroundBlur:completeAnimation()
			f9_arg0.backgroundBlur:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.backgroundBlur)
			f9_arg0.background:completeAnimation()
			f9_arg0.background:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.background)
			f9_arg0.LED:completeAnimation()
			f9_arg0.LED:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.LED)
			f9_arg0.descriptionTextBox:completeAnimation()
			f9_arg0.descriptionTextBox:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.descriptionTextBox)
			f9_arg0.nameLabel:completeAnimation()
			f9_arg0.nameLabel:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.nameLabel)
			f9_arg0.Corner9Slice:completeAnimation()
			f9_arg0.Corner9Slice:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.Corner9Slice)
			f9_arg0.Icon:completeAnimation()
			f9_arg0.Icon:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.Icon)
			f9_arg0.Bracket:completeAnimation()
			f9_arg0.Bracket:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.Bracket)
			f9_arg0.RestrictionIcon:completeAnimation()
			f9_arg0.RestrictionIcon:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.RestrictionIcon)
		end,
	},
}
CoD.StartMenu_SignatureItem.__onClose = function(f10_arg0)
	f10_arg0.descriptionTextBox:close()
	f10_arg0.nameLabel:close()
	f10_arg0.Corner9Slice:close()
	f10_arg0.Icon:close()
	f10_arg0.RestrictionIcon:close()
end
