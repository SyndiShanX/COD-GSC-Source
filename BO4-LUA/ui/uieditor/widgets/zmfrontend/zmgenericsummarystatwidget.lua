require("x64:3c71a587b3212e8")
CoD.ZMGenericSummaryStatWidget = InheritFrom(LUI.UIElement)
CoD.ZMGenericSummaryStatWidget.__defaultWidth = 182
CoD.ZMGenericSummaryStatWidget.__defaultHeight = 140
CoD.ZMGenericSummaryStatWidget.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ZMGenericSummaryStatWidget)
	self.id = "ZMGenericSummaryStatWidget"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local PerformBg = CoD.AARPerformanceBg.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 0, 45.5, 109.5)
	self:addElement(PerformBg)
	self.PerformBg = PerformBg
	local ValueGlow = LUI.UIText.new(0.03, 0.98, 0, 0, 0, 0, 67.5, 93.5)
	ValueGlow:setRGB(ColorSet.PlayerYellow.r, ColorSet.PlayerYellow.g, ColorSet.PlayerYellow.b)
	ValueGlow:setAlpha(0.4)
	ValueGlow:setTTF("skorzhen")
	ValueGlow:setMaterial(LUI.UIImage.GetCachedMaterial(0x90D57B1E92D39D7))
	ValueGlow:setShaderVector(0, 0.3, 0, 0, 0)
	ValueGlow:setShaderVector(1, 0, 0, 0, 0)
	ValueGlow:setShaderVector(2, 1, 0, 0, 0.8)
	ValueGlow:setLetterSpacing(1)
	ValueGlow:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	ValueGlow:setAlignment(Enum[0x7A5123B654282D2][0x6ED4298C93DC5ED])
	ValueGlow:linkToElementModel(self, "value", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			ValueGlow:setText(f2_local0)
		end
	end)
	self:addElement(ValueGlow)
	self.ValueGlow = ValueGlow
	local ValueGlow2 = LUI.UIText.new(0.03, 0.98, 0, 0, 0, 0, 67.5, 93.5)
	ValueGlow2:setRGB(ColorSet.PlayerYellow.r, ColorSet.PlayerYellow.g, ColorSet.PlayerYellow.b)
	ValueGlow2:setAlpha(0)
	ValueGlow2:setTTF("skorzhen")
	ValueGlow2:setMaterial(LUI.UIImage.GetCachedMaterial(0x90D57B1E92D39D7))
	ValueGlow2:setShaderVector(0, 0.3, 0, 0, 0)
	ValueGlow2:setShaderVector(1, 0, 0, 0, 0)
	ValueGlow2:setShaderVector(2, 1, 0, 0, 0.8)
	ValueGlow2:setLetterSpacing(1)
	ValueGlow2:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	ValueGlow2:setAlignment(Enum[0x7A5123B654282D2][0x6ED4298C93DC5ED])
	ValueGlow2:linkToElementModel(self, "value", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			ValueGlow2:setText(f3_local0)
		end
	end)
	self:addElement(ValueGlow2)
	self.ValueGlow2 = ValueGlow2
	local Value = LUI.UIText.new(0.03, 0.98, 0, 0, 0, 0, 67.5, 93.5)
	Value:setRGB(ColorSet.PlayerYellow.r, ColorSet.PlayerYellow.g, ColorSet.PlayerYellow.b)
	Value:setAlpha(0.8)
	Value:setTTF("skorzhen")
	Value:setMaterial(LUI.UIImage.GetCachedMaterial(0x71E049B161CD00A))
	Value:setLetterSpacing(1)
	Value:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	Value:setAlignment(Enum[0x7A5123B654282D2][0x6ED4298C93DC5ED])
	Value:linkToElementModel(self, "value", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			Value:setText(f4_local0)
		end
	end)
	self:addElement(Value)
	self.Value = Value
	local Title = LUI.UIText.new(0, 1, 0, 0, 0, 0, 20.5, 38.5)
	Title:setRGB(ColorSet.PlayerYellow.r, ColorSet.PlayerYellow.g, ColorSet.PlayerYellow.b)
	Title:setAlpha(0.5)
	Title:setTTF("dinnext_regular")
	Title:setLetterSpacing(1)
	Title:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	Title:setAlignment(Enum[0x7A5123B654282D2][0x70510683C22104B])
	Title:linkToElementModel(self, "title", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			Title:setText(LocalizeToUpperString(f5_local0))
		end
	end)
	self:addElement(Title)
	self.Title = Title
	local YellowLine = LUI.UIImage.new(0, 1, 0, 0, 0, 0, 41.5, 49.5)
	YellowLine:setImage(RegisterImage(0xE6E505307F7B8D7))
	YellowLine:setMaterial(LUI.UIImage.GetCachedMaterial(0x44484DDFAF5C093))
	YellowLine:setShaderVector(0, 0, 0, 0, 0)
	YellowLine:setupNineSliceShader(3, 60)
	self:addElement(YellowLine)
	self.YellowLine = YellowLine
	local TopBar = LUI.UIImage.new(-0.02, 1.02, 0, 0, 0, 0, 37.5, 45.5)
	TopBar:setImage(RegisterImage(0x712894B3AB5924C))
	TopBar:setMaterial(LUI.UIImage.GetCachedMaterial(0x44484DDFAF5C093))
	TopBar:setShaderVector(0, 0, 0, 0, 0)
	TopBar:setupNineSliceShader(20, 4)
	self:addElement(TopBar)
	self.TopBar = TopBar
	local TopBarAdd = LUI.UIImage.new(-0.02, 1.02, 0, 0, 0, 0, 37.5, 45.5)
	TopBarAdd:setRGB(0.92, 0.92, 0.92)
	TopBarAdd:setAlpha(0)
	TopBarAdd:setImage(RegisterImage(0x712894B3AB5924C))
	TopBarAdd:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD777557404A7B3))
	TopBarAdd:setShaderVector(0, 0, 0, 0, 0)
	TopBarAdd:setupNineSliceShader(20, 4)
	self:addElement(TopBarAdd)
	self.TopBarAdd = TopBarAdd
	self:mergeStateConditions({
		{
			stateName = "TraditionalChinese",
			condition = function(menu, element, event)
				return IsCurrentLanguageTraditionalChinese()
			end,
		},
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ZMGenericSummaryStatWidget.__resetProperties = function(f7_arg0)
	f7_arg0.Title:completeAnimation()
	f7_arg0.Title:setTopBottom(0, 0, 20.5, 38.5)
end
CoD.ZMGenericSummaryStatWidget.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(0)
		end,
	},
	TraditionalChinese = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(1)
			f9_arg0.Title:completeAnimation()
			f9_arg0.Title:setTopBottom(0, 0, 17, 34)
			f9_arg0.clipFinished(f9_arg0.Title)
		end,
	},
}
CoD.ZMGenericSummaryStatWidget.__onClose = function(f10_arg0)
	f10_arg0.PerformBg:close()
	f10_arg0.ValueGlow:close()
	f10_arg0.ValueGlow2:close()
	f10_arg0.Value:close()
	f10_arg0.Title:close()
end
