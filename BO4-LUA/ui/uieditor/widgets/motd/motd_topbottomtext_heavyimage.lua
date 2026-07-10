CoD.MOTD_TopBottomText_HeavyImage = InheritFrom(LUI.UIElement)
CoD.MOTD_TopBottomText_HeavyImage.__defaultWidth = 1392
CoD.MOTD_TopBottomText_HeavyImage.__defaultHeight = 680
CoD.MOTD_TopBottomText_HeavyImage.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.MOTD_TopBottomText_HeavyImage)
	self.id = "MOTD_TopBottomText_HeavyImage"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Image = LUI.UIImage.new(0, 0, 0, 1392, 0, 0, 0, 680)
	Image:linkToElementModel(self, "popup_image", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			Image:setImage(RegisterImage(f2_local0))
		end
	end)
	self:addElement(Image)
	self.Image = Image
	local TopBorder = LUI.UIImage.new(0, 0, 0, 1392, 0, 0, -1.5, 80.5)
	TopBorder:setRGB(0, 0, 0)
	TopBorder:setAlpha(0.5)
	self:addElement(TopBorder)
	self.TopBorder = TopBorder
	local BottomBorder = LUI.UIImage.new(0, 0, 0, 1392, 0, 0, 582, 680)
	BottomBorder:setRGB(0, 0, 0)
	BottomBorder:setAlpha(0.5)
	self:addElement(BottomBorder)
	self.BottomBorder = BottomBorder
	local TitleLbl = LUI.UIText.new(0, 0, 45.5, 1345.5, 0, 0, 19, 64)
	TitleLbl:setRGB(0.86, 0.74, 0.25)
	TitleLbl:setAlpha(0.1)
	TitleLbl:setTTF("ttmussels_demibold")
	TitleLbl:setMaterial(LUI.UIImage.GetCachedMaterial(0x90D57B1E92D39D7))
	TitleLbl:setShaderVector(0, 0, 0, 0, 0)
	TitleLbl:setShaderVector(1, 0, 0, 0, 0)
	TitleLbl:setShaderVector(2, 1, 1, 1, 0)
	TitleLbl:setLetterSpacing(10)
	TitleLbl:setAlignment(Engine[0x7F8853DC3581AA4](Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041]))
	TitleLbl:linkToElementModel(self, "title", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			TitleLbl:setText(ConvertToUpperString(f3_local0))
		end
	end)
	self:addElement(TitleLbl)
	self.TitleLbl = TitleLbl
	local TitleLbl0 = LUI.UIText.new(0, 0, 45.5, 1345.5, 0, 0, 19, 64)
	TitleLbl0:setRGB(0.86, 0.74, 0.25)
	TitleLbl0:setTTF("ttmussels_demibold")
	TitleLbl0:setLetterSpacing(10)
	TitleLbl0:setAlignment(Engine[0x7F8853DC3581AA4](Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041]))
	TitleLbl0:linkToElementModel(self, "title", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			TitleLbl0:setText(ConvertToUpperString(f4_local0))
		end
	end)
	self:addElement(TitleLbl0)
	self.TitleLbl0 = TitleLbl0
	local spacer = LUI.UIImage.new(0, 0, 0, 63, 0, 0, 64, 67)
	spacer:setAlpha(0)
	self:addElement(spacer)
	self.spacer = spacer
	local txtDescription = LUI.UIText.new(0, 0, 11, 1377, 0, 0, 592.5, 613.5)
	txtDescription:setRGB(0.92, 0.92, 0.92)
	txtDescription:setTTF("dinnext_regular")
	txtDescription:setLetterSpacing(1)
	txtDescription:setLineSpacing(2)
	txtDescription:setAlignment(Engine[0x7F8853DC3581AA4](Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041]))
	txtDescription:setAlignment(Engine[0x7F8853DC3581AA4](Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3]))
	self:addElement(txtDescription)
	self.txtDescription = txtDescription
	local ItemFrame = LUI.UIImage.new(0, 1, -1, 1, 0, 1, -1, 1)
	ItemFrame:setImage(RegisterImage(0x185E11D74ECA3D7))
	ItemFrame:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD777557404A7B3))
	ItemFrame:setShaderVector(0, 0, 0, 0, 0)
	ItemFrame:setupNineSliceShader(12, 12)
	self:addElement(ItemFrame)
	self.ItemFrame = ItemFrame
	local ItemFrameAdd = LUI.UIImage.new(0, 1, -1, 1, 0, 1, -1, 1)
	ItemFrameAdd:setAlpha(0)
	ItemFrameAdd:setImage(RegisterImage(0x185E11D74ECA3D7))
	ItemFrameAdd:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD777557404A7B3))
	ItemFrameAdd:setShaderVector(0, 0, 0, 0, 0)
	ItemFrameAdd:setupNineSliceShader(12, 12)
	self:addElement(ItemFrameAdd)
	self.ItemFrameAdd = ItemFrameAdd
	self.txtDescription:linkToElementModel(self, "content_long", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			txtDescription:setText(f5_local0)
		end
	end)
	self:mergeStateConditions({
		{
			stateName = "Arabic",
			condition = function(menu, element, event)
				return IsCurrentLanguageArabic()
			end,
		},
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.MOTD_TopBottomText_HeavyImage.__resetProperties = function(f7_arg0)
	f7_arg0.txtDescription:completeAnimation()
	f7_arg0.txtDescription:setLeftRight(0, 0, 11, 1377)
	f7_arg0.txtDescription:setTopBottom(0, 0, 592.5, 613.5)
end
CoD.MOTD_TopBottomText_HeavyImage.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(0)
		end,
	},
	Arabic = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(1)
			f9_arg0.txtDescription:completeAnimation()
			f9_arg0.txtDescription:setLeftRight(0, 0, 11, 1377)
			f9_arg0.txtDescription:setTopBottom(0, 0, 592.5, 613.5)
			f9_arg0.clipFinished(f9_arg0.txtDescription)
		end,
	},
}
CoD.MOTD_TopBottomText_HeavyImage.__onClose = function(f10_arg0)
	f10_arg0.Image:close()
	f10_arg0.TitleLbl:close()
	f10_arg0.TitleLbl0:close()
	f10_arg0.txtDescription:close()
end
