CoD.FirstTimeBrightnessPreview = InheritFrom(LUI.UIElement)
CoD.FirstTimeBrightnessPreview.__defaultWidth = 612
CoD.FirstTimeBrightnessPreview.__defaultHeight = 640
CoD.FirstTimeBrightnessPreview.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	CoD.OptionsUtility.UpdateBrightnessPreviewColor(f1_arg1)
	self:setClass(CoD.FirstTimeBrightnessPreview)
	self.id = "FirstTimeBrightnessPreview"
	self.soundSet = "default"
	local OverlaySmall = LUI.UIImage.new(0.5, 0.5, -306, 306, 0.5, 0.5, -320, 320)
	OverlaySmall:setRGB(0, 0, 0)
	OverlaySmall:setAlpha(0.99)
	OverlaySmall:setupUIStreamedImage(0)
	self:addElement(OverlaySmall)
	self.OverlaySmall = OverlaySmall
	local DescText = LUI.UIText.new(0.5, 0.5, -306, 306, 0, 0, 19.5, 40.5)
	DescText:setRGB(0.6, 0.6, 0.6)
	DescText:setText(Engine[@"hash_4F9F1239CFD921FE"]("menu/adjust_brightness_firsttime"))
	DescText:setTTF("ttmussels_regular")
	DescText:setAlignment(Enum.LUIAlignment[@"lui_alignment_center"])
	DescText:setAlignment(Enum.LUIAlignment[@"lui_alignment_top"])
	self:addElement(DescText)
	self.DescText = DescText
	local Logo = LUI.UIImage.new(0.5, 0.5, -210.5, 210.5, 0, 0, 104, 556)
	Logo:setImage(RegisterImage("uie_ui_icon_startmenu_option_brightnesslogo"))
	Logo:setupUIStreamedImage(0)
	Logo:subscribeToGlobalModel(f1_arg1, "PerController", "profile.brightnessPreviewColor", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			Logo:setRGB(f2_local0)
		end
	end)
	self:addElement(Logo)
	self.Logo = Logo
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.FirstTimeBrightnessPreview.__onClose = function(f3_arg0)
	f3_arg0.Logo:close()
end
