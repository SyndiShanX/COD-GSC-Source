require("x64:acbf06924421e35")
CoD.TipWidgetBacking = InheritFrom(LUI.UIElement)
CoD.TipWidgetBacking.__defaultWidth = 683
CoD.TipWidgetBacking.__defaultHeight = 48
CoD.TipWidgetBacking.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.TipWidgetBacking)
	self.id = "TipWidgetBacking"
	self.soundSet = "default"
	local BackingNoise = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	BackingNoise:setAlpha(0.9)
	BackingNoise:setImage(RegisterImage(@"uie_ui_menu_specialist_hub_repeat_bg"))
	BackingNoise:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	BackingNoise:setShaderVector(0, 0, 0, 0, 0)
	BackingNoise:setupNineSliceShader(196, 88)
	self:addElement(BackingNoise)
	self.BackingNoise = BackingNoise
	local CommonCornerPips = CoD.CommonCornerPips01.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	CommonCornerPips:setAlpha(0.5)
	self:addElement(CommonCornerPips)
	self.CommonCornerPips = CommonCornerPips
	local Tip = LUI.UIText.new(0, 1, 5, -5, 0.5, 0.5, -9.5, 7.5)
	Tip:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	Tip:setTTF("dinnext_regular")
	Tip:setLetterSpacing(0.5)
	Tip:setAlignment(Engine[@"hash_67F8853DC3581AA4"](Enum[@"luialignment"][@"lui_alignment_left"]))
	Tip:setAlignment(Engine[@"hash_67F8853DC3581AA4"](Enum[@"luialignment"][@"lui_alignment_middle"]))
	Tip:setBackingType(1)
	Tip:setBackingColor(0, 0, 0)
	Tip:setBackingXPadding(5)
	Tip:setBackingYPadding(5)
	Tip:subscribeToGlobalModel(f1_arg1, "LoadingScreenTeamInfo", "tip", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			Tip:setText(CoD.BaseUtility.AlreadyLocalized(f2_local0))
		end
	end)
	self:addElement(Tip)
	self.Tip = Tip
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.TipWidgetBacking.__onClose = function(f3_arg0)
	f3_arg0.CommonCornerPips:close()
	f3_arg0.Tip:close()
end
