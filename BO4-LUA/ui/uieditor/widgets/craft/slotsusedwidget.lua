CoD.SlotsUsedWidget = InheritFrom(LUI.UIElement)
CoD.SlotsUsedWidget.__defaultWidth = 530
CoD.SlotsUsedWidget.__defaultHeight = 93
CoD.SlotsUsedWidget.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.SlotsUsedWidget)
	self.id = "SlotsUsedWidget"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local HeaderStripe = LUI.UIImage.new(-0, 1, 1, -1, 1, 1, -90, -68)
	HeaderStripe:setAlpha(0.16)
	HeaderStripe:setImage(RegisterImage(@"hash_2C7A051F5EFC70E5"))
	HeaderStripe:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	HeaderStripe:setShaderVector(0, 0, 0, 0, 0)
	HeaderStripe:setupNineSliceShader(60, 35)
	self:addElement(HeaderStripe)
	self.HeaderStripe = HeaderStripe
	local Total = LUI.UIText.new(1, 1, -70, -30, 0, 0, 36.5, 60.5)
	Total:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	Total:setTTF("dinnext_regular")
	Total:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	Total:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	Total:subscribeToGlobalModel(f1_arg1, "CraftSlots", "totalSlots", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			Total:setText(f2_local0)
		end
	end)
	self:addElement(Total)
	self.Total = Total
	local Slice = LUI.UIImage.new(1, 1, -83, -81, 0, 0, 34, 63)
	Slice:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	Slice:setYRot(42)
	Slice:setZRot(-18)
	self:addElement(Slice)
	self.Slice = Slice
	local Used = LUI.UIText.new(1, 1, -134, -94, 0, 0, 36.5, 60.5)
	Used:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	Used:setTTF("dinnext_regular")
	Used:setAlignment(Enum[@"luialignment"][@"lui_alignment_right"])
	Used:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	Used:subscribeToGlobalModel(f1_arg1, "CraftSlots", "usedSlots", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			Used:setText(f3_local0)
		end
	end)
	self:addElement(Used)
	self.Used = Used
	local totalBar = LUI.UIImage.new(0, 0.9, 5, -75, 0, 0, 32, 61)
	totalBar:setRGB(0.37, 0.4, 0.44)
	totalBar:setImage(RegisterImage(@"hash_75CDE8BCCBD6F24"))
	totalBar:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_5BEEFD90021D3628"))
	totalBar:setShaderVector(0, 0, 0, 0, 0)
	totalBar:setShaderVector(2, 0, 1, 0, 1)
	totalBar:setupNineSliceShader(6, 6)
	totalBar:subscribeToGlobalModel(f1_arg1, "CraftSlots", "totalSlots", function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			totalBar:setShaderVector(1, SetVectorComponent(2, 1, CoD.GetVectorComponentFromString(f4_local0, 1), CoD.GetVectorComponentFromString(f4_local0, 2), CoD.GetVectorComponentFromString(f4_local0, 3), CoD.GetVectorComponentFromString(f4_local0, 4)))
		end
	end)
	self:addElement(totalBar)
	self.totalBar = totalBar
	local usedBar = LUI.UIImage.new(0, 0.9, 5, -75, 0, 0, 32, 61)
	usedBar:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	usedBar:setImage(RegisterImage(@"hash_5700B275CC09FEF2"))
	usedBar:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_17E89392B94A41DE"))
	usedBar:setShaderVector(0, 0, 0, 0, 0)
	usedBar:setupNineSliceShader(6, 6)
	usedBar:subscribeToGlobalModel(f1_arg1, "CraftSlots", "totalSlots", function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			usedBar:setShaderVector(1, SetVectorComponent(2, 1, CoD.GetVectorComponentFromString(f5_local0, 1), CoD.GetVectorComponentFromString(f5_local0, 2), CoD.GetVectorComponentFromString(f5_local0, 3), CoD.GetVectorComponentFromString(f5_local0, 4)))
		end
	end)
	usedBar:subscribeToGlobalModel(f1_arg1, "CraftSlots", "percent", function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			usedBar:setShaderVector(2, SetVectorComponent(4, 1, SetVectorComponent(3, 0, SetVectorComponent(1, 0, SwapVectorComponents(1, 2, CoD.GetVectorComponentFromString(f6_local0, 1), CoD.GetVectorComponentFromString(f6_local0, 2), CoD.GetVectorComponentFromString(f6_local0, 3), CoD.GetVectorComponentFromString(f6_local0, 4))))))
		end
	end)
	self:addElement(usedBar)
	self.usedBar = usedBar
	local alertTriangle = LUI.UIImage.new(0, 0, 2, 26, 0, 0, 68, 92)
	alertTriangle:setImage(RegisterImage(@"warning_triangle"))
	self:addElement(alertTriangle)
	self.alertTriangle = alertTriangle
	local alertText = LUI.UIText.new(0, 0, 32, 392, 0, 0, 72, 92)
	alertText:setText(LocalizeToUpperString(@"menu/slots_full"))
	alertText:setTTF("default")
	alertText:setLetterSpacing(1)
	alertText:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	self:addElement(alertText)
	self.alertText = alertText
	local Title = LUI.UIText.new(0.5, 0.5, -265, 265, 0, 0, 4, 25)
	Title:setRGB(ColorSet.T8__OFF__GRAY.r, ColorSet.T8__OFF__GRAY.g, ColorSet.T8__OFF__GRAY.b)
	Title.__String_Reference = function()
		Title:setText(LocalizeToUpperString(CoD.CraftUtility.GetSlotsUsedHeader(f1_arg1)))
	end
	Title.__String_Reference()
	Title:setTTF("ttmussels_regular")
	Title:setLetterSpacing(2)
	Title:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	Title:setAlignment(Enum[@"luialignment"][@"lui_alignment_bottom"])
	self:addElement(Title)
	self.Title = Title
	local BracketTop = LUI.UIImage.new(0, 1, 0, 0, 0, 0, 27, 35)
	BracketTop:setAlpha(0.2)
	BracketTop:setZRot(180)
	BracketTop:setImage(RegisterImage(@"hash_4C325BED3F226657"))
	BracketTop:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_add"))
	BracketTop:setShaderVector(0, 0, 0, 0, 0)
	BracketTop:setupNineSliceShader(16, 4)
	self:addElement(BracketTop)
	self.BracketTop = BracketTop
	local BracketBottom = LUI.UIImage.new(0, 1, 0, 0, 0, 0, 58, 66)
	BracketBottom:setAlpha(0.2)
	BracketBottom:setImage(RegisterImage(@"hash_4C325BED3F226657"))
	BracketBottom:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_add"))
	BracketBottom:setShaderVector(0, 0, 0, 0, 0)
	BracketBottom:setupNineSliceShader(16, 4)
	self:addElement(BracketBottom)
	self.BracketBottom = BracketBottom
	local f1_local12 = Title
	local f1_local13 = Title.subscribeToModel
	local f1_local14 = DataSources.SlotCustomization.getModel(f1_arg1)
	f1_local13(f1_local12, f1_local14.type, Title.__String_Reference)
	self:mergeStateConditions({
		{
			stateName = "Invisible",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "Warning",
			condition = function(menu, element, event)
				return CoD.CraftUtility.IsLowOnSlots(f1_arg1)
			end,
		},
		{
			stateName = "SlotsFull",
			condition = function(menu, element, event)
				return CoD.CraftUtility.AreSlotsFull(f1_arg1)
			end,
		},
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.SlotsUsedWidget.__resetProperties = function(f11_arg0)
	f11_arg0.alertText:completeAnimation()
	f11_arg0.alertTriangle:completeAnimation()
	f11_arg0.Title:completeAnimation()
	f11_arg0.usedBar:completeAnimation()
	f11_arg0.totalBar:completeAnimation()
	f11_arg0.Used:completeAnimation()
	f11_arg0.Slice:completeAnimation()
	f11_arg0.Total:completeAnimation()
	f11_arg0.BracketTop:completeAnimation()
	f11_arg0.BracketBottom:completeAnimation()
	f11_arg0.HeaderStripe:completeAnimation()
	f11_arg0.alertText:setRGB(1, 1, 1)
	f11_arg0.alertText:setAlpha(1)
	f11_arg0.alertText:setText(LocalizeToUpperString(@"menu/slots_full"))
	f11_arg0.alertTriangle:setRGB(1, 1, 1)
	f11_arg0.alertTriangle:setAlpha(1)
	f11_arg0.Title:setAlpha(1)
	f11_arg0.usedBar:setAlpha(1)
	f11_arg0.totalBar:setAlpha(1)
	f11_arg0.Used:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	f11_arg0.Used:setAlpha(1)
	f11_arg0.Slice:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	f11_arg0.Slice:setAlpha(1)
	f11_arg0.Total:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	f11_arg0.Total:setAlpha(1)
	f11_arg0.BracketTop:setAlpha(0.2)
	f11_arg0.BracketBottom:setAlpha(0.2)
	f11_arg0.HeaderStripe:setAlpha(0.16)
end
CoD.SlotsUsedWidget.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(2)
			f12_arg0.alertTriangle:completeAnimation()
			f12_arg0.alertTriangle:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.alertTriangle)
			f12_arg0.alertText:completeAnimation()
			f12_arg0.alertText:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.alertText)
		end,
	},
	Invisible = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(11)
			f13_arg0.HeaderStripe:completeAnimation()
			f13_arg0.HeaderStripe:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.HeaderStripe)
			f13_arg0.Total:completeAnimation()
			f13_arg0.Total:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.Total)
			f13_arg0.Slice:completeAnimation()
			f13_arg0.Slice:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.Slice)
			f13_arg0.Used:completeAnimation()
			f13_arg0.Used:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.Used)
			f13_arg0.totalBar:completeAnimation()
			f13_arg0.totalBar:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.totalBar)
			f13_arg0.usedBar:completeAnimation()
			f13_arg0.usedBar:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.usedBar)
			f13_arg0.alertTriangle:completeAnimation()
			f13_arg0.alertTriangle:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.alertTriangle)
			f13_arg0.alertText:completeAnimation()
			f13_arg0.alertText:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.alertText)
			f13_arg0.Title:completeAnimation()
			f13_arg0.Title:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.Title)
			f13_arg0.BracketTop:completeAnimation()
			f13_arg0.BracketTop:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.BracketTop)
			f13_arg0.BracketBottom:completeAnimation()
			f13_arg0.BracketBottom:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.BracketBottom)
		end,
	},
	Warning = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(5)
			f14_arg0.Total:completeAnimation()
			f14_arg0.Total:setRGB(ColorSet.T8__GOLD.r, ColorSet.T8__GOLD.g, ColorSet.T8__GOLD.b)
			f14_arg0.clipFinished(f14_arg0.Total)
			f14_arg0.Slice:completeAnimation()
			f14_arg0.Slice:setRGB(ColorSet.T8__GOLD.r, ColorSet.T8__GOLD.g, ColorSet.T8__GOLD.b)
			f14_arg0.clipFinished(f14_arg0.Slice)
			f14_arg0.Used:completeAnimation()
			f14_arg0.Used:setRGB(ColorSet.T8__GOLD.r, ColorSet.T8__GOLD.g, ColorSet.T8__GOLD.b)
			f14_arg0.clipFinished(f14_arg0.Used)
			f14_arg0.alertTriangle:completeAnimation()
			f14_arg0.alertTriangle:setRGB(ColorSet.T8__OCHRE.r, ColorSet.T8__OCHRE.g, ColorSet.T8__OCHRE.b)
			f14_arg0.clipFinished(f14_arg0.alertTriangle)
			f14_arg0.alertText:completeAnimation()
			f14_arg0.alertText:setRGB(ColorSet.T8__OCHRE.r, ColorSet.T8__OCHRE.g, ColorSet.T8__OCHRE.b)
			f14_arg0.alertText:setText(LocalizeToUpperString(@"menu/slots_low"))
			f14_arg0.clipFinished(f14_arg0.alertText)
		end,
	},
	SlotsFull = {
		DefaultClip = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(5)
			f15_arg0.Total:completeAnimation()
			f15_arg0.Total:setRGB(ColorSet.T8__RED.r, ColorSet.T8__RED.g, ColorSet.T8__RED.b)
			f15_arg0.clipFinished(f15_arg0.Total)
			f15_arg0.Slice:completeAnimation()
			f15_arg0.Slice:setRGB(ColorSet.T8__RED.r, ColorSet.T8__RED.g, ColorSet.T8__RED.b)
			f15_arg0.clipFinished(f15_arg0.Slice)
			f15_arg0.Used:completeAnimation()
			f15_arg0.Used:setRGB(ColorSet.T8__RED.r, ColorSet.T8__RED.g, ColorSet.T8__RED.b)
			f15_arg0.clipFinished(f15_arg0.Used)
			local f15_local0 = function(f16_arg0)
				local f16_local0 = function(f17_arg0)
					f17_arg0:beginAnimation(1000)
					f17_arg0:setAlpha(1)
					f17_arg0:registerEventHandler("transition_complete_keyframe", f15_arg0.clipFinished)
				end
				f15_arg0.alertTriangle:beginAnimation(1000)
				f15_arg0.alertTriangle:setAlpha(0.5)
				f15_arg0.alertTriangle:registerEventHandler("interrupted_keyframe", f15_arg0.clipInterrupted)
				f15_arg0.alertTriangle:registerEventHandler("transition_complete_keyframe", f16_local0)
			end
			f15_arg0.alertTriangle:completeAnimation()
			f15_arg0.alertTriangle:setRGB(0.76, 0.28, 0.28)
			f15_arg0.alertTriangle:setAlpha(1)
			f15_local0(f15_arg0.alertTriangle)
			local f15_local1 = function(f18_arg0)
				local f18_local0 = function(f19_arg0)
					f19_arg0:beginAnimation(1000)
					f19_arg0:setAlpha(1)
					f19_arg0:registerEventHandler("transition_complete_keyframe", f15_arg0.clipFinished)
				end
				f15_arg0.alertText:beginAnimation(1000)
				f15_arg0.alertText:setAlpha(0.5)
				f15_arg0.alertText:registerEventHandler("interrupted_keyframe", f15_arg0.clipInterrupted)
				f15_arg0.alertText:registerEventHandler("transition_complete_keyframe", f18_local0)
			end
			f15_arg0.alertText:completeAnimation()
			f15_arg0.alertText:setRGB(0.76, 0.28, 0.28)
			f15_arg0.alertText:setAlpha(1)
			f15_local1(f15_arg0.alertText)
			f15_arg0.nextClip = "DefaultClip"
		end,
	},
}
CoD.SlotsUsedWidget.__onClose = function(f20_arg0)
	f20_arg0.Total:close()
	f20_arg0.Used:close()
	f20_arg0.totalBar:close()
	f20_arg0.usedBar:close()
	f20_arg0.Title:close()
end
