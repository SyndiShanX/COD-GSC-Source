require("ui/uieditor/widgets/systemoverlays/systemoverlay_layout_foregroundmultilinetext")
CoD.systemOverlay_Layout_GenericForeground_FreeCursor_Full = InheritFrom(LUI.UIElement)
CoD.systemOverlay_Layout_GenericForeground_FreeCursor_Full.__defaultWidth = 1920
CoD.systemOverlay_Layout_GenericForeground_FreeCursor_Full.__defaultHeight = 480
CoD.systemOverlay_Layout_GenericForeground_FreeCursor_Full.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.systemOverlay_Layout_GenericForeground_FreeCursor_Full)
	self.id = "systemOverlay_Layout_GenericForeground_FreeCursor_Full"
	self.soundSet = "default"
	local categoryTypeImage = LUI.UIImage.new(0, 0, 576, 621, 0, 0, 17, 62)
	categoryTypeImage:setRGB(ColorSet.T8__BEIGE__HEADER.r, ColorSet.T8__BEIGE__HEADER.g, ColorSet.T8__BEIGE__HEADER.b)
	categoryTypeImage:linkToElementModel(self, "categoryType", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			categoryTypeImage:setImage(RegisterImage(GetCategoryIconForOverlayType(f2_local0)))
		end
	end)
	self:addElement(categoryTypeImage)
	self.categoryTypeImage = categoryTypeImage
	local title = LUI.UIText.new(0, 0, 632, 932, 0, 0, 20, 56)
	title:setRGB(ColorSet.T8__BEIGE__HEADER.r, ColorSet.T8__BEIGE__HEADER.g, ColorSet.T8__BEIGE__HEADER.b)
	title:setTTF("ttmussels_demibold")
	title:setLetterSpacing(6)
	title:setAlignment(Enum.LUIAlignment[@"lui_alignment_left"])
	title:linkToElementModel(self, "title", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			title:setText(LocalizeToUpperString(f3_local0))
		end
	end)
	self:addElement(title)
	self.title = title
	local text = CoD.systemOverlay_Layout_ForegroundMultilineText.new(f1_arg0, f1_arg1, 0, 0, 633, 1755, 0, 0, 70, 100)
	text:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	text:setScale(LanguageOverrideNumber("japanese", 0.85, 1, 1))
	text:linkToElementModel(self, "description", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			text.text:setText(f4_local0)
		end
	end)
	self:addElement(text)
	self.text = text
	local SubHeaderDivider = LUI.UIImage.new(0, 0, 633, 1003, 0, 0, 60, 61)
	SubHeaderDivider:setRGB(0.58, 0.58, 0.58)
	self:addElement(SubHeaderDivider)
	self.SubHeaderDivider = SubHeaderDivider
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.systemOverlay_Layout_GenericForeground_FreeCursor_Full.__onClose = function(f5_arg0)
	f5_arg0.categoryTypeImage:close()
	f5_arg0.title:close()
	f5_arg0.text:close()
end
