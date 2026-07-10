CoD.PaintCanCount = InheritFrom(LUI.UIElement)
CoD.PaintCanCount.__defaultWidth = 180
CoD.PaintCanCount.__defaultHeight = 132
CoD.PaintCanCount.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PaintCanCount)
	self.id = "PaintCanCount"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local backing = LUI.UIImage.new(0, 0, 0.5, 218.5, 0, 0, 33, 132)
	backing:setRGB(0, 0, 0)
	backing:setAlpha(0)
	self:addElement(backing)
	self.backing = backing
	local NoiseTiledBacking = LUI.UIImage.new(0, 0, 0.5, 180.5, 0.09, 0.09, 41.5, 120.5)
	NoiseTiledBacking:setAlpha(0.8)
	NoiseTiledBacking:setImage(RegisterImage(@"uie_ui_menu_specialist_hub_repeat_bg"))
	NoiseTiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	NoiseTiledBacking:setShaderVector(0, 0, 0, 0, 0)
	NoiseTiledBacking:setupNineSliceShader(196, 88)
	self:addElement(NoiseTiledBacking)
	self.NoiseTiledBacking = NoiseTiledBacking
	local StatLabel = LUI.UIText.new(0, 0, 0.5, 162.5, 0, 0, 30, 51)
	StatLabel:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	StatLabel:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_49FE863E6425C8CE"))
	StatLabel:setTTF("dinnext_regular")
	StatLabel:setLetterSpacing(2)
	StatLabel:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	self:addElement(StatLabel)
	self.StatLabel = StatLabel
	local maxedLabel = LUI.UIText.new(0, 0, 0.5, 162.5, 0, 0, 136, 157)
	maxedLabel:setRGB(1, 0, 0)
	maxedLabel:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_4F3D13CF35DD7B2A"))
	maxedLabel:setTTF("dinnext_regular")
	maxedLabel:setLetterSpacing(2)
	maxedLabel:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	self:addElement(maxedLabel)
	self.maxedLabel = maxedLabel
	local StatValue = LUI.UIText.new(0, 0, 65.5, 168.5, 0, 0, 71.5, 116.5)
	StatValue:setRGB(0.93, 0.91, 0.84)
	StatValue:setTTF("ttmussels_demibold")
	StatValue:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	StatValue:setAlignment(Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"])
	StatValue:subscribeToGlobalModel(f1_arg1, "PerController", "paintCanCount", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			StatValue:setText(f2_local0)
		end
	end)
	self:addElement(StatValue)
	self.StatValue = StatValue
	local PaintCanImage = LUI.UIImage.new(0, 0, 0, 80, 0, 0, 54, 134)
	PaintCanImage:setImage(RegisterImage(@"ui_icon_inventory_spray_can"))
	self:addElement(PaintCanImage)
	self.PaintCanImage = PaintCanImage
	local infoBracketBot = LUI.UIImage.new(0, 0, 0, 181, 0, 0, 124, 132)
	infoBracketBot:setAlpha(0.26)
	infoBracketBot:setImage(RegisterImage(@"hash_4C325BED3F226657"))
	infoBracketBot:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_add"))
	infoBracketBot:setShaderVector(0, 0, 0, 0, 0)
	infoBracketBot:setupNineSliceShader(16, 4)
	self:addElement(infoBracketBot)
	self.infoBracketBot = infoBracketBot
	local infoBracketBot2 = LUI.UIImage.new(0, 0, 0, 181, 0, 0, 52.5, 60.5)
	infoBracketBot2:setAlpha(0.16)
	infoBracketBot2:setZRot(180)
	infoBracketBot2:setImage(RegisterImage(@"hash_4C325BED3F226657"))
	infoBracketBot2:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_add"))
	infoBracketBot2:setShaderVector(0, 0, 0, 0, 0)
	infoBracketBot2:setupNineSliceShader(16, 4)
	self:addElement(infoBracketBot2)
	self.infoBracketBot2 = infoBracketBot2
	self:mergeStateConditions({
		{
			stateName = "VisibleMaxed",
			condition = function(menu, element, event)
				local f3_local0 = CoD.WeaponOptionsUtility.IsWarzoneCamoFilter(menu, self, f1_arg1)
				if f3_local0 then
					if not IsLocal() then
						f3_local0 = CoD.WZUtility.IsPaintCansMaxed(f1_arg1)
					else
						f3_local0 = false
					end
				end
				return f3_local0
			end,
		},
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return CoD.WeaponOptionsUtility.IsWarzoneCamoFilter(menu, self, f1_arg1) and not IsLocal()
			end,
		},
	})
	local f1_local9 = self
	local f1_local10 = self.subscribeToModel
	local f1_local11 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local10(f1_local9, f1_local11["WeaponPersonalization.listUpdate"], function(f5_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f5_arg0:get(),
			modelName = "WeaponPersonalization.listUpdate",
		})
	end, false)
	f1_local9 = self
	f1_local10 = self.subscribeToModel
	f1_local11 = Engine[@"getglobalmodel"]()
	f1_local10(f1_local9, f1_local11["lobbyRoot.lobbyNetworkMode"], function(f6_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "lobbyRoot.lobbyNetworkMode",
		})
	end, false)
	f1_local9 = self
	f1_local10 = self.subscribeToModel
	f1_local11 = Engine[@"getglobalmodel"]()
	f1_local10(f1_local9, f1_local11["lobbyRoot.lobbyNav"], function(f7_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f7_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	f1_local9 = self
	f1_local10 = self.subscribeToModel
	f1_local11 = DataSources.PerController.getModel(f1_arg1)
	f1_local10(f1_local9, f1_local11.paintCanCount, function(f8_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f8_arg0:get(),
			modelName = "paintCanCount",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.PaintCanCount.__resetProperties = function(f9_arg0)
	f9_arg0.StatLabel:completeAnimation()
	f9_arg0.StatValue:completeAnimation()
	f9_arg0.PaintCanImage:completeAnimation()
	f9_arg0.infoBracketBot2:completeAnimation()
	f9_arg0.infoBracketBot:completeAnimation()
	f9_arg0.NoiseTiledBacking:completeAnimation()
	f9_arg0.maxedLabel:completeAnimation()
	f9_arg0.StatLabel:setAlpha(1)
	f9_arg0.StatValue:setTopBottom(0, 0, 71.5, 116.5)
	f9_arg0.StatValue:setRGB(0.93, 0.91, 0.84)
	f9_arg0.StatValue:setAlpha(1)
	f9_arg0.PaintCanImage:setAlpha(1)
	f9_arg0.infoBracketBot2:setRGB(1, 1, 1)
	f9_arg0.infoBracketBot2:setAlpha(0.16)
	f9_arg0.infoBracketBot:setRGB(1, 1, 1)
	f9_arg0.infoBracketBot:setAlpha(0.26)
	f9_arg0.NoiseTiledBacking:setAlpha(0.8)
	f9_arg0.maxedLabel:setLeftRight(0, 0, 0.5, 162.5)
	f9_arg0.maxedLabel:setTopBottom(0, 0, 136, 157)
	f9_arg0.maxedLabel:setRGB(1, 0, 0)
	f9_arg0.maxedLabel:setAlpha(1)
	f9_arg0.maxedLabel:setLetterSpacing(2)
	f9_arg0.maxedLabel:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
end
CoD.PaintCanCount.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(7)
			f10_arg0.NoiseTiledBacking:completeAnimation()
			f10_arg0.NoiseTiledBacking:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.NoiseTiledBacking)
			f10_arg0.StatLabel:completeAnimation()
			f10_arg0.StatLabel:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.StatLabel)
			f10_arg0.maxedLabel:completeAnimation()
			f10_arg0.maxedLabel:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.maxedLabel)
			f10_arg0.StatValue:completeAnimation()
			f10_arg0.StatValue:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.StatValue)
			f10_arg0.PaintCanImage:completeAnimation()
			f10_arg0.PaintCanImage:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.PaintCanImage)
			f10_arg0.infoBracketBot:completeAnimation()
			f10_arg0.infoBracketBot:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.infoBracketBot)
			f10_arg0.infoBracketBot2:completeAnimation()
			f10_arg0.infoBracketBot2:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.infoBracketBot2)
		end,
	},
	VisibleMaxed = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(4)
			f11_arg0.maxedLabel:completeAnimation()
			f11_arg0.maxedLabel:setLeftRight(0, 0, 59, 175)
			f11_arg0.maxedLabel:setTopBottom(0, 0, 106.5, 120.5)
			f11_arg0.maxedLabel:setRGB(1, 0, 0)
			f11_arg0.maxedLabel:setLetterSpacing(0)
			f11_arg0.maxedLabel:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
			f11_arg0.maxedLabel:setAlignment(Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"])
			f11_arg0.clipFinished(f11_arg0.maxedLabel)
			f11_arg0.StatValue:completeAnimation()
			f11_arg0.StatValue:setTopBottom(0, 0, 60.5, 105.5)
			f11_arg0.StatValue:setRGB(0.92, 0.09, 0.09)
			f11_arg0.clipFinished(f11_arg0.StatValue)
			f11_arg0.infoBracketBot:completeAnimation()
			f11_arg0.infoBracketBot:setRGB(1, 1, 1)
			f11_arg0.infoBracketBot:setAlpha(0.26)
			f11_arg0.clipFinished(f11_arg0.infoBracketBot)
			f11_arg0.infoBracketBot2:completeAnimation()
			f11_arg0.infoBracketBot2:setRGB(1, 1, 1)
			f11_arg0.infoBracketBot2:setAlpha(0.16)
			f11_arg0.clipFinished(f11_arg0.infoBracketBot2)
		end,
	},
	Visible = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(1)
			f12_arg0.maxedLabel:completeAnimation()
			f12_arg0.maxedLabel:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.maxedLabel)
		end,
	},
}
CoD.PaintCanCount.__onClose = function(f13_arg0)
	f13_arg0.StatValue:close()
end
