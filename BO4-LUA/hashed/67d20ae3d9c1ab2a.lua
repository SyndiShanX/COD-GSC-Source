require("x64:5f8cf56752aa71b")
CoD.BountyHunterTierBacking = InheritFrom(LUI.UIElement)
CoD.BountyHunterTierBacking.__defaultWidth = 345
CoD.BountyHunterTierBacking.__defaultHeight = 127
CoD.BountyHunterTierBacking.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.BountyHunterTierBacking)
	self.id = "BountyHunterTierBacking"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local SceneBlur = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	SceneBlur:setAlpha(0)
	SceneBlur:setMaterial(LUI.UIImage.GetCachedMaterial(0xE2354BE557C4C7A))
	SceneBlur:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(SceneBlur)
	self.SceneBlur = SceneBlur
	local NoiseTiledBacking = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	NoiseTiledBacking:setAlpha(0.8)
	NoiseTiledBacking:setImage(RegisterImage(0x34839E8065B1E53))
	NoiseTiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	NoiseTiledBacking:setShaderVector(0, 0, 0, 0, 0)
	NoiseTiledBacking:setupNineSliceShader(196, 88)
	self:addElement(NoiseTiledBacking)
	self.NoiseTiledBacking = NoiseTiledBacking
	local SelectOvelay = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	SelectOvelay:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	SelectOvelay:setAlpha(0.01)
	self:addElement(SelectOvelay)
	self.SelectOvelay = SelectOvelay
	local ButtonBGTiled = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	ButtonBGTiled:setRGB(0.28, 0.28, 0.28)
	ButtonBGTiled:setAlpha(0.8)
	ButtonBGTiled:setImage(RegisterImage(0xD78A9159503BFBB))
	ButtonBGTiled:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	ButtonBGTiled:setShaderVector(0, 0, 0, 0, 0)
	ButtonBGTiled:setupNineSliceShader(16, 16)
	self:addElement(ButtonBGTiled)
	self.ButtonBGTiled = ButtonBGTiled
	local PixelGrid = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	PixelGrid:setAlpha(0.05)
	PixelGrid:setImage(RegisterImage(0x311E811A3183347))
	PixelGrid:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	PixelGrid:setShaderVector(0, 0, 0, 0, 0)
	PixelGrid:setupNineSliceShader(128, 128)
	self:addElement(PixelGrid)
	self.PixelGrid = PixelGrid
	local CommonButtonOutline = CoD.CommonButtonOutline.new(f1_arg0, f1_arg1, 0, 1, -1, 1, 0, 1, 0, 0)
	self:addElement(CommonButtonOutline)
	self.CommonButtonOutline = CommonButtonOutline
	self:mergeStateConditions({
		{
			stateName = "Purchased",
			condition = function(menu, element, event)
				return CoD.BountyHunterUtility.IsTrackPackagePurchased(self, menu, f1_arg1)
			end,
		},
		{
			stateName = "Unavailable",
			condition = function(menu, element, event)
				return not CoD.BountyHunterUtility.IsPackageTierAvailable(self)
			end,
		},
	})
	self:linkToElementModel(self, "trackModel", true, function(model)
		if self["__stateValidation_trackModel->tierPurchased"] then
			self:removeSubscription(self["__stateValidation_trackModel->tierPurchased"])
			self["__stateValidation_trackModel->tierPurchased"] = nil
		end
		if model then
			local f4_local0 = model:get()
			local f4_local1 = model:get()
			model = f4_local0 and f4_local1.tierPurchased
		end
		if model then
			self["__stateValidation_trackModel->tierPurchased"] = self:subscribeToModel(model, function(model)
				f1_arg0:updateElementState(self, {
					name = "model_validation",
					menu = f1_arg0,
					controller = f1_arg1,
					modelValue = model:get(),
					modelName = "trackModel->tierPurchased",
				})
			end)
		end
	end)
	CommonButtonOutline.id = "CommonButtonOutline"
	self.__defaultFocus = CommonButtonOutline
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.BountyHunterTierBacking.__resetProperties = function(f6_arg0)
	f6_arg0.SelectOvelay:completeAnimation()
	f6_arg0.ButtonBGTiled:completeAnimation()
	f6_arg0.SelectOvelay:setAlpha(0.01)
	f6_arg0.ButtonBGTiled:setRGB(0.28, 0.28, 0.28)
end
CoD.BountyHunterTierBacking.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(1)
			f8_arg0.SelectOvelay:completeAnimation()
			f8_arg0.SelectOvelay:setAlpha(0.04)
			f8_arg0.clipFinished(f8_arg0.SelectOvelay)
		end,
		GainChildFocus = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(1)
			local f9_local0 = function(f10_arg0)
				f9_arg0.SelectOvelay:beginAnimation(200)
				f9_arg0.SelectOvelay:setAlpha(0.04)
				f9_arg0.SelectOvelay:registerEventHandler("interrupted_keyframe", f9_arg0.clipInterrupted)
				f9_arg0.SelectOvelay:registerEventHandler("transition_complete_keyframe", f9_arg0.clipFinished)
			end
			f9_arg0.SelectOvelay:completeAnimation()
			f9_arg0.SelectOvelay:setAlpha(0.01)
			f9_local0(f9_arg0.SelectOvelay)
		end,
		LoseChildFocus = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(1)
			local f11_local0 = function(f12_arg0)
				f11_arg0.SelectOvelay:beginAnimation(200)
				f11_arg0.SelectOvelay:setAlpha(0.01)
				f11_arg0.SelectOvelay:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.SelectOvelay:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
			end
			f11_arg0.SelectOvelay:completeAnimation()
			f11_arg0.SelectOvelay:setAlpha(0.04)
			f11_local0(f11_arg0.SelectOvelay)
		end,
	},
	Purchased = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(1)
			f13_arg0.ButtonBGTiled:completeAnimation()
			f13_arg0.ButtonBGTiled:setRGB(0.18, 0.18, 0.18)
			f13_arg0.clipFinished(f13_arg0.ButtonBGTiled)
		end,
	},
	Unavailable = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(1)
			f14_arg0.ButtonBGTiled:completeAnimation()
			f14_arg0.ButtonBGTiled:setRGB(0.18, 0.18, 0.18)
			f14_arg0.clipFinished(f14_arg0.ButtonBGTiled)
		end,
	},
}
CoD.BountyHunterTierBacking.__onClose = function(f15_arg0)
	f15_arg0.CommonButtonOutline:close()
end
