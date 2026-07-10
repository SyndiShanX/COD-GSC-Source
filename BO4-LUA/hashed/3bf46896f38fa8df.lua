require("x64:9633fcb728138fa")
require("x64:c08a2aab18ca343")
require("x64:5f8cf56752aa71b")
require("x64:19c1945d2e472b0")
CoD.BM_AvailabeContractItemInternal = InheritFrom(LUI.UIElement)
CoD.BM_AvailabeContractItemInternal.__defaultWidth = 200
CoD.BM_AvailabeContractItemInternal.__defaultHeight = 200
CoD.BM_AvailabeContractItemInternal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.BM_AvailabeContractItemInternal)
	self.id = "BM_AvailabeContractItemInternal"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Backing = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Backing:setRGB(0.11, 0.11, 0.11)
	Backing:setAlpha(0.9)
	self:addElement(Backing)
	self.Backing = Backing
	local DotTiledBacking = CoD.StoreCommonTextBacking.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 1, 1, -34, -1)
	DotTiledBacking:setAlpha(0)
	self:addElement(DotTiledBacking)
	self.DotTiledBacking = DotTiledBacking
	local CompletedBox = LUI.UIImage.new(0, 1, 0, 0, 0.83, 1, 0, 0)
	CompletedBox:setRGB(ColorSet.T8__GREEN.r, ColorSet.T8__GREEN.g, ColorSet.T8__GREEN.b)
	CompletedBox:setAlpha(0)
	self:addElement(CompletedBox)
	self.CompletedBox = CompletedBox
	local HardBox = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	HardBox:setRGB(0.96, 0.59, 0.06)
	HardBox:setAlpha(0)
	self:addElement(HardBox)
	self.HardBox = HardBox
	local TiledBacking = LUI.UIImage.new(-0, 0.99, 1, 1, 0, 1, 0, 0)
	TiledBacking:setAlpha(0.5)
	TiledBacking:setImage(RegisterImage(@"uie_ui_menu_specialist_hub_repeat_bg"))
	TiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	TiledBacking:setShaderVector(0, 0, 0, 0, 0)
	TiledBacking:setupNineSliceShader(196, 88)
	self:addElement(TiledBacking)
	self.TiledBacking = TiledBacking
	local PixelGridTiledBacking = LUI.UIImage.new(0, 0, 0, 200, 0, 0, 0, 200)
	PixelGridTiledBacking:setAlpha(0.04)
	PixelGridTiledBacking:setImage(RegisterImage(@"uie_ui_hud_notifications_pixelpattern"))
	PixelGridTiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	PixelGridTiledBacking:setShaderVector(0, 0, 0, 0, 0)
	PixelGridTiledBacking:setupNineSliceShader(128, 128)
	self:addElement(PixelGridTiledBacking)
	self.PixelGridTiledBacking = PixelGridTiledBacking
	local Icon = LUI.UIImage.new(0.5, 0.5, -95, 95, 0.5, 0.5, -100, 100)
	Icon:setScale(0.7, 0.7)
	Icon:linkToElementModel(self, "contractIcon", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			Icon:setImage(RegisterImage(f2_local0))
		end
	end)
	self:addElement(Icon)
	self.Icon = Icon
	local Completed = LUI.UIText.new(0.5, 0.5, -90, 90, 1, 1, -28, -6)
	Completed:setRGB(ColorSet.T8__GREEN.r, ColorSet.T8__GREEN.g, ColorSet.T8__GREEN.b)
	Completed:setAlpha(0)
	Completed:setText(LocalizeToUpperString(@"menu/completed"))
	Completed:setTTF("ttmussels_regular")
	Completed:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	Completed:setAlignment(Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"])
	self:addElement(Completed)
	self.Completed = Completed
	local BMContractEquippedTick = CoD.BM_ContractEquippedTick.new(f1_arg0, f1_arg1, 0, 0, 159.5, 203.5, 0, 0, -7.5, 36.5)
	BMContractEquippedTick:mergeStateConditions({
		{
			stateName = "Equipped",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "active")
			end,
		},
	})
	BMContractEquippedTick:linkToElementModel(BMContractEquippedTick, "active", true, function(model)
		f1_arg0:updateElementState(BMContractEquippedTick, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "active",
		})
	end)
	BMContractEquippedTick:linkToElementModel(self, nil, false, function(model)
		BMContractEquippedTick:setModel(model, f1_arg1)
	end)
	self:addElement(BMContractEquippedTick)
	self.BMContractEquippedTick = BMContractEquippedTick
	local CommonButtonOutline = CoD.CommonButtonOutline.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 1, -1)
	self:addElement(CommonButtonOutline)
	self.CommonButtonOutline = CommonButtonOutline
	local BMContractReveal = CoD.BM_ContractReveal.new(f1_arg0, f1_arg1, 0.35, 1.35, -70, -70, 0.4, 1.39, -79, -79)
	self:addElement(BMContractReveal)
	self.BMContractReveal = BMContractReveal
	self:mergeStateConditions({
		{
			stateName = "Completed",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "completed")
			end,
		},
		{
			stateName = "Hard",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "difficulty", 1)
			end,
		},
	})
	self:linkToElementModel(self, "completed", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "completed",
		})
	end)
	self:linkToElementModel(self, "difficulty", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "difficulty",
		})
	end)
	self:subscribeToGlobalModel(f1_arg1, "PerController", "Contracts.availableContractsExpired", function(model)
		local f10_local0 = self
		if CoD.ModelUtility.IsModelValueTrue(f1_arg1, "Contracts.availableContractsExpired") then
			CoD.BlackMarketUtility.DelayedContractReveal(f1_arg1, f10_local0)
		end
	end)
	CommonButtonOutline.id = "CommonButtonOutline"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.BM_AvailabeContractItemInternal.__resetProperties = function(f11_arg0)
	f11_arg0.Backing:completeAnimation()
	f11_arg0.Completed:completeAnimation()
	f11_arg0.CompletedBox:completeAnimation()
	f11_arg0.HardBox:completeAnimation()
	f11_arg0.Backing:setRGB(0.11, 0.11, 0.11)
	f11_arg0.Backing:setAlpha(0.9)
	f11_arg0.Completed:setAlpha(0)
	f11_arg0.CompletedBox:setAlpha(0)
	f11_arg0.HardBox:setAlpha(0)
end
CoD.BM_AvailabeContractItemInternal.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(1)
			f13_arg0.Backing:completeAnimation()
			f13_arg0.Backing:setRGB(0.65, 0.64, 0.61)
			f13_arg0.Backing:setAlpha(0.1)
			f13_arg0.clipFinished(f13_arg0.Backing)
		end,
		GainChildFocus = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(1)
			local f14_local0 = function(f15_arg0)
				f14_arg0.Backing:beginAnimation(200)
				f14_arg0.Backing:setRGB(0.65, 0.64, 0.61)
				f14_arg0.Backing:setAlpha(0.1)
				f14_arg0.Backing:registerEventHandler("interrupted_keyframe", f14_arg0.clipInterrupted)
				f14_arg0.Backing:registerEventHandler("transition_complete_keyframe", f14_arg0.clipFinished)
			end
			f14_arg0.Backing:completeAnimation()
			f14_arg0.Backing:setRGB(0.11, 0.11, 0.11)
			f14_arg0.Backing:setAlpha(0.9)
			f14_local0(f14_arg0.Backing)
		end,
		LoseChildFocus = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(1)
			local f16_local0 = function(f17_arg0)
				f16_arg0.Backing:beginAnimation(200)
				f16_arg0.Backing:setRGB(0.11, 0.11, 0.11)
				f16_arg0.Backing:setAlpha(0.9)
				f16_arg0.Backing:registerEventHandler("interrupted_keyframe", f16_arg0.clipInterrupted)
				f16_arg0.Backing:registerEventHandler("transition_complete_keyframe", f16_arg0.clipFinished)
			end
			f16_arg0.Backing:completeAnimation()
			f16_arg0.Backing:setRGB(0.65, 0.64, 0.61)
			f16_arg0.Backing:setAlpha(0.1)
			f16_local0(f16_arg0.Backing)
		end,
	},
	Completed = {
		DefaultClip = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(2)
			f18_arg0.CompletedBox:completeAnimation()
			f18_arg0.CompletedBox:setAlpha(0.24)
			f18_arg0.clipFinished(f18_arg0.CompletedBox)
			f18_arg0.Completed:completeAnimation()
			f18_arg0.Completed:setAlpha(1)
			f18_arg0.clipFinished(f18_arg0.Completed)
		end,
		ChildFocus = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(3)
			f19_arg0.Backing:completeAnimation()
			f19_arg0.Backing:setRGB(0.21, 0.2, 0.19)
			f19_arg0.clipFinished(f19_arg0.Backing)
			f19_arg0.CompletedBox:completeAnimation()
			f19_arg0.CompletedBox:setAlpha(0.2)
			f19_arg0.clipFinished(f19_arg0.CompletedBox)
			f19_arg0.Completed:completeAnimation()
			f19_arg0.Completed:setAlpha(1)
			f19_arg0.clipFinished(f19_arg0.Completed)
		end,
		GainChildFocus = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(3)
			local f20_local0 = function(f21_arg0)
				f20_arg0.Backing:beginAnimation(200)
				f20_arg0.Backing:setRGB(0.21, 0.2, 0.19)
				f20_arg0.Backing:registerEventHandler("interrupted_keyframe", f20_arg0.clipInterrupted)
				f20_arg0.Backing:registerEventHandler("transition_complete_keyframe", f20_arg0.clipFinished)
			end
			f20_arg0.Backing:completeAnimation()
			f20_arg0.Backing:setRGB(0.11, 0.11, 0.11)
			f20_local0(f20_arg0.Backing)
			local f20_local1 = function(f22_arg0)
				f20_arg0.CompletedBox:beginAnimation(200)
				f20_arg0.CompletedBox:setAlpha(0.2)
				f20_arg0.CompletedBox:registerEventHandler("interrupted_keyframe", f20_arg0.clipInterrupted)
				f20_arg0.CompletedBox:registerEventHandler("transition_complete_keyframe", f20_arg0.clipFinished)
			end
			f20_arg0.CompletedBox:completeAnimation()
			f20_arg0.CompletedBox:setAlpha(0.24)
			f20_local1(f20_arg0.CompletedBox)
			f20_arg0.Completed:completeAnimation()
			f20_arg0.Completed:setAlpha(1)
			f20_arg0.clipFinished(f20_arg0.Completed)
		end,
		LoseChildFocus = function(f23_arg0, f23_arg1)
			f23_arg0:__resetProperties()
			f23_arg0:setupElementClipCounter(3)
			local f23_local0 = function(f24_arg0)
				f23_arg0.Backing:beginAnimation(200)
				f23_arg0.Backing:setRGB(0.11, 0.11, 0.11)
				f23_arg0.Backing:registerEventHandler("interrupted_keyframe", f23_arg0.clipInterrupted)
				f23_arg0.Backing:registerEventHandler("transition_complete_keyframe", f23_arg0.clipFinished)
			end
			f23_arg0.Backing:completeAnimation()
			f23_arg0.Backing:setRGB(0.21, 0.2, 0.19)
			f23_local0(f23_arg0.Backing)
			local f23_local1 = function(f25_arg0)
				f23_arg0.CompletedBox:beginAnimation(200)
				f23_arg0.CompletedBox:setAlpha(0.24)
				f23_arg0.CompletedBox:registerEventHandler("interrupted_keyframe", f23_arg0.clipInterrupted)
				f23_arg0.CompletedBox:registerEventHandler("transition_complete_keyframe", f23_arg0.clipFinished)
			end
			f23_arg0.CompletedBox:completeAnimation()
			f23_arg0.CompletedBox:setAlpha(0.2)
			f23_local1(f23_arg0.CompletedBox)
			f23_arg0.Completed:completeAnimation()
			f23_arg0.Completed:setAlpha(1)
			f23_arg0.clipFinished(f23_arg0.Completed)
		end,
	},
	Hard = {
		DefaultClip = function(f26_arg0, f26_arg1)
			f26_arg0:__resetProperties()
			f26_arg0:setupElementClipCounter(1)
			f26_arg0.HardBox:completeAnimation()
			f26_arg0.HardBox:setAlpha(0.05)
			f26_arg0.clipFinished(f26_arg0.HardBox)
		end,
		ChildFocus = function(f27_arg0, f27_arg1)
			f27_arg0:__resetProperties()
			f27_arg0:setupElementClipCounter(1)
			f27_arg0.HardBox:completeAnimation()
			f27_arg0.HardBox:setAlpha(0.2)
			f27_arg0.clipFinished(f27_arg0.HardBox)
		end,
		GainChildFocus = function(f28_arg0, f28_arg1)
			f28_arg0:__resetProperties()
			f28_arg0:setupElementClipCounter(1)
			local f28_local0 = function(f29_arg0)
				f28_arg0.HardBox:beginAnimation(200)
				f28_arg0.HardBox:setAlpha(0.2)
				f28_arg0.HardBox:registerEventHandler("interrupted_keyframe", f28_arg0.clipInterrupted)
				f28_arg0.HardBox:registerEventHandler("transition_complete_keyframe", f28_arg0.clipFinished)
			end
			f28_arg0.HardBox:completeAnimation()
			f28_arg0.HardBox:setAlpha(0.05)
			f28_local0(f28_arg0.HardBox)
		end,
		LoseChildFocus = function(f30_arg0, f30_arg1)
			f30_arg0:__resetProperties()
			f30_arg0:setupElementClipCounter(1)
			local f30_local0 = function(f31_arg0)
				f30_arg0.HardBox:beginAnimation(200)
				f30_arg0.HardBox:setAlpha(0.05)
				f30_arg0.HardBox:registerEventHandler("interrupted_keyframe", f30_arg0.clipInterrupted)
				f30_arg0.HardBox:registerEventHandler("transition_complete_keyframe", f30_arg0.clipFinished)
			end
			f30_arg0.HardBox:completeAnimation()
			f30_arg0.HardBox:setAlpha(0.2)
			f30_local0(f30_arg0.HardBox)
		end,
	},
}
CoD.BM_AvailabeContractItemInternal.__onClose = function(f32_arg0)
	f32_arg0.DotTiledBacking:close()
	f32_arg0.Icon:close()
	f32_arg0.BMContractEquippedTick:close()
	f32_arg0.CommonButtonOutline:close()
	f32_arg0.BMContractReveal:close()
end
