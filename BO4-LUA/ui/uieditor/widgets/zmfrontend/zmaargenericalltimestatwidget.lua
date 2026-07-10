require("x64:3c71a587b3212e8")
CoD.ZMAARGenericAllTimeStatWidget = InheritFrom(LUI.UIElement)
CoD.ZMAARGenericAllTimeStatWidget.__defaultWidth = 163
CoD.ZMAARGenericAllTimeStatWidget.__defaultHeight = 114
CoD.ZMAARGenericAllTimeStatWidget.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ZMAARGenericAllTimeStatWidget)
	self.id = "ZMAARGenericAllTimeStatWidget"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local PerformBg = CoD.AARPerformanceBg.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 0, 26.5, 90.5)
	PerformBg.Tint:setRGB(0, 0, 0)
	PerformBg.Tint:setAlpha(0.4)
	self:addElement(PerformBg)
	self.PerformBg = PerformBg
	local YellowLine = LUI.UIImage.new(0, 1, 0, 0, 0, 0, 22, 30)
	YellowLine:setImage(RegisterImage(@"hash_1E6E505307F7B8D7"))
	YellowLine:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_normal"))
	YellowLine:setShaderVector(0, 0, 0, 0, 0)
	YellowLine:setupNineSliceShader(3, 60)
	self:addElement(YellowLine)
	self.YellowLine = YellowLine
	local Value = LUI.UIText.new(-0.01, 1.01, 0, 0, 0.5, 0.5, -12.5, 20.5)
	Value:setRGB(0.75, 0.75, 0.75)
	Value:setAlpha(0.8)
	Value:setTTF("skorzhen")
	Value:setLetterSpacing(2)
	Value:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	Value:setAlignment(Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"])
	Value:linkToElementModel(self, "value", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			Value:setText(f2_local0)
		end
	end)
	self:addElement(Value)
	self.Value = Value
	local Title = LUI.UIText.new(0.01, 0.99, -1, 1, 0, 0, 1, 19)
	Title:setRGB(0.75, 0.75, 0.75)
	Title:setAlpha(0.5)
	Title:setTTF("dinnext_regular")
	Title:setLetterSpacing(1)
	Title:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	Title:setAlignment(Enum[@"luialignment"][@"lui_alignment_bottom"])
	Title:linkToElementModel(self, "title", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			Title:setText(LocalizeToUpperString(f3_local0))
		end
	end)
	self:addElement(Title)
	self.Title = Title
	local TopBar = LUI.UIImage.new(0, 1, -5, 5, 0, 0, 17, 25)
	TopBar:setImage(RegisterImage(@"uie_ui_hud_zm_aar_common_bar"))
	TopBar:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_normal"))
	TopBar:setShaderVector(0, 0, 0, 0, 0)
	TopBar:setupNineSliceShader(20, 4)
	self:addElement(TopBar)
	self.TopBar = TopBar
	self:mergeStateConditions({
		{
			stateName = "ShowMp",
			condition = function(menu, element, event)
				return not IsZombies()
			end,
		},
		{
			stateName = "ShowZm",
			condition = function(menu, element, event)
				return IsZombies() and not CoD.HUDUtility.IsAnyGameType(f1_arg1, "zstandard")
			end,
		},
	})
	local f1_local6 = self
	local f1_local7 = self.subscribeToModel
	local f1_local8 = Engine[@"getglobalmodel"]()
	f1_local7(f1_local6, f1_local8["lobbyRoot.lobbyNav"], function(f6_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ZMAARGenericAllTimeStatWidget.__onClose = function(f7_arg0)
	f7_arg0.PerformBg:close()
	f7_arg0.Value:close()
	f7_arg0.Title:close()
end
