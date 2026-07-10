require("x64:19c1945d2e472b0")
CoD.insertion_passenger_count = InheritFrom(CoD.Menu)
LUI.createMenu.insertion_passenger_count = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("insertion_passenger_count", f1_arg0)
	local f1_local1 = self
	CallCustomElementFunction_Self(self, "setPriority", -1)
	self:setClass(CoD.insertion_passenger_count)
	self.soundSet = "none"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.ignoreCursor = true
	f1_local1:addElementToPendingUpdateStateList(self)
	local ExitPrompt = LUI.UIText.new(0.5, 0.5, -211, 211, 1, 1, -155, -129)
	ExitPrompt:setAlpha(0)
	ExitPrompt:setText(Engine[0xF9F1239CFD921FE](0x758C01E7483E028))
	ExitPrompt:setTTF("ttmussels_regular")
	ExitPrompt:setLetterSpacing(3)
	ExitPrompt:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	ExitPrompt:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	ExitPrompt:setBackingType(2)
	ExitPrompt:setBackingColor(0, 0, 0)
	ExitPrompt:setBackingXPadding(10)
	ExitPrompt:setBackingYPadding(6)
	ExitPrompt:setBackingMaterial(LUI.UIImage.GetCachedMaterial(0xE2354BE557C4C7A))
	ExitPrompt:setBackingShaderVector(0, 0, 0.5, 0, 0)
	self:addElement(ExitPrompt)
	self.ExitPrompt = ExitPrompt
	local BackingBlur = LUI.UIImage.new(1, 1, -155, -39, 0, 0, 349.5, 453.5)
	BackingBlur:setAlpha(0)
	BackingBlur:setMaterial(LUI.UIImage.GetCachedMaterial(0xE2354BE557C4C7A))
	BackingBlur:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(BackingBlur)
	self.BackingBlur = BackingBlur
	local NoiseTiledBacking = LUI.UIImage.new(1, 1, -155, -39, 0, 0, 349.5, 453.5)
	NoiseTiledBacking:setAlpha(0)
	NoiseTiledBacking:setImage(RegisterImage(0x34839E8065B1E53))
	NoiseTiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	NoiseTiledBacking:setShaderVector(0, 0, 0, 0, 0)
	NoiseTiledBacking:setupNineSliceShader(196, 88)
	self:addElement(NoiseTiledBacking)
	self.NoiseTiledBacking = NoiseTiledBacking
	local DotTiledBacking = CoD.StoreCommonTextBacking.new(f1_local1, f1_arg0, 1, 1, -150.5, -43.5, 0, 0, 355, 415)
	DotTiledBacking:setAlpha(0)
	DotTiledBacking.TiledShaderImage:setupNineSliceShader(30, 30)
	self:addElement(DotTiledBacking)
	self.DotTiledBacking = DotTiledBacking
	local CountBacking = LUI.UIImage.new(1, 1, -150.5, -43.5, 0, 0, 418.5, 448.5)
	CountBacking:setRGB(0, 0, 0)
	CountBacking:setAlpha(0)
	self:addElement(CountBacking)
	self.CountBacking = CountBacking
	local Image = LUI.UIImage.new(1, 1, -137, -57, 0, 0, 345, 425)
	Image:setAlpha(0)
	Image:setZRot(-90)
	Image:setImage(RegisterImage(0xB024F5E0D917C61))
	Image:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD526D3FD71F281))
	Image:setShaderVector(0, 4, 4, 0, 0)
	Image:setShaderVector(1, 30, 0, 0, 0)
	self:addElement(Image)
	self.Image = Image
	local TextBox = LUI.UIText.new(1, 1, -164, -30, 0, 0, 418.5, 450.5)
	TextBox:setAlpha(0)
	TextBox:setTTF("0arame_mono_stencil")
	TextBox:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	TextBox:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	TextBox:linkToElementModel(self, "count", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			TextBox:setText(CoD.BaseUtility.AlreadyLocalized(f2_local0))
		end
	end)
	self:addElement(TextBox)
	self.TextBox = TextBox
	local border = LUI.UIImage.new(1, 1, -161, -33, 0, 0, 345, 458)
	border:setRGB(0.07, 0.07, 0.07)
	border:setAlpha(0)
	border:setImage(RegisterImage(0xA3C76B80B69874D))
	border:setMaterial(LUI.UIImage.GetCachedMaterial(0x44484DDFAF5C093))
	border:setShaderVector(0, 0, 0, 0, 0)
	border:setupNineSliceShader(18, 24)
	self:addElement(border)
	self.border = border
	self:mergeStateConditions({
		{
			stateName = "HiddenPreference",
			condition = function(menu, element, event)
				return CoD.WZUtility.IsWarzoneUIHidden(f1_arg0, "wzHideInsertionCountUI", "warzoneHideInsertionCount")
			end,
		},
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueEqualTo(f1_arg0, "hudItems.infiltrationVehicle", 1)
			end,
		},
	})
	local f1_local10 = self
	local f1_local11 = self.subscribeToModel
	local f1_local12 = Engine[0x4DF5CFBC1771947](f1_arg0)
	f1_local11(f1_local10, f1_local12.PlayerSettingsUpdate, function(f5_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f5_arg0:get(),
			modelName = "PlayerSettingsUpdate",
		})
	end, false)
	f1_local10 = self
	f1_local11 = self.subscribeToModel
	f1_local12 = Engine[0x4DF5CFBC1771947](f1_arg0)
	f1_local11(f1_local10, f1_local12["hudItems.infiltrationVehicle"], function(f6_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f6_arg0:get(),
			modelName = "hudItems.infiltrationVehicle",
		})
	end, false)
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PreLoadFunc then
		PreLoadFunc(self, f1_arg0)
	end
	f1_local11 = self
	if IsPC() then
		SizeToHudArea(f1_local11, f1_arg0)
	end
	return self
end
CoD.insertion_passenger_count.__resetProperties = function(f7_arg0)
	f7_arg0.ExitPrompt:completeAnimation()
	f7_arg0.border:completeAnimation()
	f7_arg0.TextBox:completeAnimation()
	f7_arg0.Image:completeAnimation()
	f7_arg0.CountBacking:completeAnimation()
	f7_arg0.DotTiledBacking:completeAnimation()
	f7_arg0.NoiseTiledBacking:completeAnimation()
	f7_arg0.BackingBlur:completeAnimation()
	f7_arg0.ExitPrompt:setAlpha(0)
	f7_arg0.border:setAlpha(0)
	f7_arg0.TextBox:setAlpha(0)
	f7_arg0.Image:setAlpha(0)
	f7_arg0.CountBacking:setAlpha(0)
	f7_arg0.DotTiledBacking:setAlpha(0)
	f7_arg0.NoiseTiledBacking:setAlpha(0)
	f7_arg0.BackingBlur:setAlpha(0)
end
CoD.insertion_passenger_count.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(0)
		end,
	},
	HiddenPreference = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(8)
			local f9_local0 = function(f10_arg0)
				f9_arg0.ExitPrompt:beginAnimation(1000)
				f9_arg0.ExitPrompt:setAlpha(1)
				f9_arg0.ExitPrompt:registerEventHandler("interrupted_keyframe", f9_arg0.clipInterrupted)
				f9_arg0.ExitPrompt:registerEventHandler("transition_complete_keyframe", f9_arg0.clipFinished)
			end
			f9_arg0.ExitPrompt:completeAnimation()
			f9_arg0.ExitPrompt:setAlpha(0)
			f9_local0(f9_arg0.ExitPrompt)
			f9_arg0.BackingBlur:completeAnimation()
			f9_arg0.BackingBlur:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.BackingBlur)
			f9_arg0.NoiseTiledBacking:completeAnimation()
			f9_arg0.NoiseTiledBacking:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.NoiseTiledBacking)
			f9_arg0.DotTiledBacking:completeAnimation()
			f9_arg0.DotTiledBacking:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.DotTiledBacking)
			f9_arg0.CountBacking:completeAnimation()
			f9_arg0.CountBacking:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.CountBacking)
			f9_arg0.Image:completeAnimation()
			f9_arg0.Image:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.Image)
			f9_arg0.TextBox:completeAnimation()
			f9_arg0.TextBox:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.TextBox)
			f9_arg0.border:completeAnimation()
			f9_arg0.border:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.border)
		end,
	},
	Visible = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(8)
			local f11_local0 = function(f12_arg0)
				f11_arg0.ExitPrompt:beginAnimation(1000)
				f11_arg0.ExitPrompt:setAlpha(1)
				f11_arg0.ExitPrompt:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.ExitPrompt:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
			end
			f11_arg0.ExitPrompt:completeAnimation()
			f11_arg0.ExitPrompt:setAlpha(0)
			f11_local0(f11_arg0.ExitPrompt)
			local f11_local1 = function(f13_arg0)
				f13_arg0:beginAnimation(299)
				f13_arg0:setAlpha(1)
				f13_arg0:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
			end
			f11_arg0.BackingBlur:beginAnimation(1000)
			f11_arg0.BackingBlur:setAlpha(0)
			f11_arg0.BackingBlur:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
			f11_arg0.BackingBlur:registerEventHandler("transition_complete_keyframe", f11_local1)
			local f11_local2 = function(f14_arg0)
				f14_arg0:beginAnimation(299)
				f14_arg0:setAlpha(0.5)
				f14_arg0:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
			end
			f11_arg0.NoiseTiledBacking:beginAnimation(1000)
			f11_arg0.NoiseTiledBacking:setAlpha(0)
			f11_arg0.NoiseTiledBacking:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
			f11_arg0.NoiseTiledBacking:registerEventHandler("transition_complete_keyframe", f11_local2)
			local f11_local3 = function(f15_arg0)
				local f15_local0 = function(f16_arg0)
					f16_arg0:beginAnimation(300)
					f16_arg0:setAlpha(1)
					f16_arg0:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
				end
				f15_arg0:beginAnimation(299)
				f15_arg0:registerEventHandler("transition_complete_keyframe", f15_local0)
			end
			f11_arg0.DotTiledBacking:beginAnimation(1000)
			f11_arg0.DotTiledBacking:setAlpha(0)
			f11_arg0.DotTiledBacking:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
			f11_arg0.DotTiledBacking:registerEventHandler("transition_complete_keyframe", f11_local3)
			local f11_local4 = function(f17_arg0)
				local f17_local0 = function(f18_arg0)
					f18_arg0:beginAnimation(299)
					f18_arg0:setAlpha(0.5)
					f18_arg0:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
				end
				f17_arg0:beginAnimation(600)
				f17_arg0:registerEventHandler("transition_complete_keyframe", f17_local0)
			end
			f11_arg0.CountBacking:beginAnimation(1000)
			f11_arg0.CountBacking:setAlpha(0)
			f11_arg0.CountBacking:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
			f11_arg0.CountBacking:registerEventHandler("transition_complete_keyframe", f11_local4)
			local f11_local5 = function(f19_arg0)
				local f19_local0 = function(f20_arg0)
					f20_arg0:beginAnimation(300)
					f20_arg0:setAlpha(1)
					f20_arg0:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
				end
				f19_arg0:beginAnimation(900)
				f19_arg0:registerEventHandler("transition_complete_keyframe", f19_local0)
			end
			f11_arg0.Image:beginAnimation(1000)
			f11_arg0.Image:setAlpha(0)
			f11_arg0.Image:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
			f11_arg0.Image:registerEventHandler("transition_complete_keyframe", f11_local5)
			local f11_local6 = function(f21_arg0)
				local f21_local0 = function(f22_arg0)
					f22_arg0:beginAnimation(299)
					f22_arg0:setAlpha(1)
					f22_arg0:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
				end
				f21_arg0:beginAnimation(1200)
				f21_arg0:registerEventHandler("transition_complete_keyframe", f21_local0)
			end
			f11_arg0.TextBox:beginAnimation(1000)
			f11_arg0.TextBox:setAlpha(0)
			f11_arg0.TextBox:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
			f11_arg0.TextBox:registerEventHandler("transition_complete_keyframe", f11_local6)
			local f11_local7 = function(f23_arg0)
				f23_arg0:beginAnimation(289)
				f23_arg0:setAlpha(1)
				f23_arg0:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
			end
			f11_arg0.border:beginAnimation(1000)
			f11_arg0.border:setAlpha(0)
			f11_arg0.border:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
			f11_arg0.border:registerEventHandler("transition_complete_keyframe", f11_local7)
		end,
	},
}
CoD.insertion_passenger_count.__onClose = function(f24_arg0)
	f24_arg0.DotTiledBacking:close()
	f24_arg0.TextBox:close()
end
