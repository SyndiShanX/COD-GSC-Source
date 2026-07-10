require("x64:73c969b5dbad3ea")
require("x64:eeba57f916954d1")
CoD.EmblemMaterialElement = InheritFrom(LUI.UIElement)
CoD.EmblemMaterialElement.__defaultWidth = 100
CoD.EmblemMaterialElement.__defaultHeight = 100
CoD.EmblemMaterialElement.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.EmblemMaterialElement)
	self.id = "EmblemMaterialElement"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local FrontendFrameSelected = LUI.UIImage.new(-1.85, -0.97, 185, 197, -0.18, 0.7, 18, 30)
	FrontendFrameSelected:setAlpha(0)
	FrontendFrameSelected:setImage(RegisterImage(0xCB07CCC28498CB2))
	FrontendFrameSelected:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD777557404A7B3))
	FrontendFrameSelected:setShaderVector(0, 0, 0, 0, 0)
	FrontendFrameSelected:setupNineSliceShader(14, 14)
	self:addElement(FrontendFrameSelected)
	self.FrontendFrameSelected = FrontendFrameSelected
	local emblemMaterial = LUI.UIImage.new(0, 1, 9.5, -10.5, 0, 1, 10, -10)
	emblemMaterial:linkToElementModel(self, "materialName", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			emblemMaterial:setImage(RegisterImage(f2_local0))
		end
	end)
	self:addElement(emblemMaterial)
	self.emblemMaterial = emblemMaterial
	local bgImage = LUI.UIImage.new(0, 1, 10, -10, 0, 1, 10, -10)
	bgImage:setRGB(0.2, 0.2, 0.2)
	bgImage:setAlpha(0)
	self:addElement(bgImage)
	self.bgImage = bgImage
	local smallbargold = LUI.UIImage.new(0.5, 0.5, -41, 41, 0, 0, 25, 75)
	smallbargold:setAlpha(0)
	smallbargold:setImage(RegisterImage(0xFE2F687C254A523))
	self:addElement(smallbargold)
	self.smallbargold = smallbargold
	local blackMarketBrandIcon = LUI.UIImage.new(0.5, 0.5, -32, 37, 0.5, 0.5, -33, 36)
	blackMarketBrandIcon:setAlpha(0)
	blackMarketBrandIcon:setImage(RegisterImage(0xD26541E94E02E90))
	self:addElement(blackMarketBrandIcon)
	self.blackMarketBrandIcon = blackMarketBrandIcon
	local lockedIcon = CoD.cac_lock.new(f1_arg0, f1_arg1, 0.5, 0.5, -18, 18, 0.5, 0.5, -18, 18)
	lockedIcon:setAlpha(0)
	self:addElement(lockedIcon)
	self.lockedIcon = lockedIcon
	local IconNew = CoD.cac_LabelNew.new(f1_arg0, f1_arg1, 0.5, 0.5, -48, 48, 0.5, 0.5, -18, 18)
	IconNew:setAlpha(0)
	self:addElement(IconNew)
	self.IconNew = IconNew
	self:mergeStateConditions({
		{
			stateName = "BMClassified",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "isBMClassified")
			end,
		},
		{
			stateName = "Locked",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "New",
			condition = function(menu, element, event)
				return CoD.CraftUtility.Emblems_IsMaterialNew(element, f1_arg1)
			end,
		},
	})
	self:linkToElementModel(self, "isBMClassified", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "isBMClassified",
		})
	end)
	self:linkToElementModel(self, "materialID", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "materialID",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.EmblemMaterialElement.__resetProperties = function(f8_arg0)
	f8_arg0.FrontendFrameSelected:completeAnimation()
	f8_arg0.emblemMaterial:completeAnimation()
	f8_arg0.bgImage:completeAnimation()
	f8_arg0.blackMarketBrandIcon:completeAnimation()
	f8_arg0.smallbargold:completeAnimation()
	f8_arg0.lockedIcon:completeAnimation()
	f8_arg0.IconNew:completeAnimation()
	f8_arg0.FrontendFrameSelected:setLeftRight(-1.85, -0.97, 185, 197)
	f8_arg0.FrontendFrameSelected:setTopBottom(-0.18, 0.7, 18, 30)
	f8_arg0.FrontendFrameSelected:setAlpha(0)
	f8_arg0.emblemMaterial:setLeftRight(0, 1, 9.5, -10.5)
	f8_arg0.emblemMaterial:setTopBottom(0, 1, 10, -10)
	f8_arg0.emblemMaterial:setAlpha(1)
	f8_arg0.bgImage:setAlpha(0)
	f8_arg0.blackMarketBrandIcon:setAlpha(0)
	f8_arg0.smallbargold:setAlpha(0)
	f8_arg0.lockedIcon:setAlpha(0)
	f8_arg0.IconNew:setAlpha(0)
end
CoD.EmblemMaterialElement.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(0)
		end,
		Focus = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(2)
			f10_arg0.FrontendFrameSelected:completeAnimation()
			f10_arg0.FrontendFrameSelected:setLeftRight(-1.88, -0.94, 187, 195)
			f10_arg0.FrontendFrameSelected:setTopBottom(-0.21, 0.73, 20, 28)
			f10_arg0.FrontendFrameSelected:setAlpha(1)
			f10_arg0.clipFinished(f10_arg0.FrontendFrameSelected)
			f10_arg0.emblemMaterial:completeAnimation()
			f10_arg0.emblemMaterial:setLeftRight(-0.02, 1.02, 9.5, -10.5)
			f10_arg0.emblemMaterial:setTopBottom(-0.02, 1.02, 10, -10)
			f10_arg0.clipFinished(f10_arg0.emblemMaterial)
		end,
		GainFocus = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(2)
			local f11_local0 = function(f12_arg0)
				f11_arg0.FrontendFrameSelected:beginAnimation(200)
				f11_arg0.FrontendFrameSelected:setLeftRight(-1.88, -0.94, 187, 195)
				f11_arg0.FrontendFrameSelected:setTopBottom(-0.21, 0.73, 20, 28)
				f11_arg0.FrontendFrameSelected:setAlpha(1)
				f11_arg0.FrontendFrameSelected:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.FrontendFrameSelected:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
			end
			f11_arg0.FrontendFrameSelected:completeAnimation()
			f11_arg0.FrontendFrameSelected:setLeftRight(-1.85, -0.97, 187, 195)
			f11_arg0.FrontendFrameSelected:setTopBottom(-0.18, 0.7, 20, 28)
			f11_arg0.FrontendFrameSelected:setAlpha(0)
			f11_local0(f11_arg0.FrontendFrameSelected)
			local f11_local1 = function(f13_arg0)
				f11_arg0.emblemMaterial:beginAnimation(200)
				f11_arg0.emblemMaterial:setLeftRight(-0.02, 1.02, 9.5, -10.5)
				f11_arg0.emblemMaterial:setTopBottom(-0.02, 1.02, 10, -10)
				f11_arg0.emblemMaterial:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.emblemMaterial:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
			end
			f11_arg0.emblemMaterial:completeAnimation()
			f11_arg0.emblemMaterial:setLeftRight(0, 1, 9.5, -10.5)
			f11_arg0.emblemMaterial:setTopBottom(0, 1, 10, -10)
			f11_local1(f11_arg0.emblemMaterial)
		end,
		LoseFocus = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(2)
			local f14_local0 = function(f15_arg0)
				f14_arg0.FrontendFrameSelected:beginAnimation(100)
				f14_arg0.FrontendFrameSelected:setLeftRight(-1.85, -0.97, 185, 197)
				f14_arg0.FrontendFrameSelected:setTopBottom(-0.18, 0.7, 18, 30)
				f14_arg0.FrontendFrameSelected:setAlpha(0)
				f14_arg0.FrontendFrameSelected:registerEventHandler("interrupted_keyframe", f14_arg0.clipInterrupted)
				f14_arg0.FrontendFrameSelected:registerEventHandler("transition_complete_keyframe", f14_arg0.clipFinished)
			end
			f14_arg0.FrontendFrameSelected:completeAnimation()
			f14_arg0.FrontendFrameSelected:setLeftRight(-1.88, -0.94, 187, 195)
			f14_arg0.FrontendFrameSelected:setTopBottom(-0.21, 0.73, 20, 28)
			f14_arg0.FrontendFrameSelected:setAlpha(1)
			f14_local0(f14_arg0.FrontendFrameSelected)
			local f14_local1 = function(f16_arg0)
				f14_arg0.emblemMaterial:beginAnimation(100)
				f14_arg0.emblemMaterial:setLeftRight(0, 1, 9.5, -10.5)
				f14_arg0.emblemMaterial:setTopBottom(0, 1, 10, -10)
				f14_arg0.emblemMaterial:registerEventHandler("interrupted_keyframe", f14_arg0.clipInterrupted)
				f14_arg0.emblemMaterial:registerEventHandler("transition_complete_keyframe", f14_arg0.clipFinished)
			end
			f14_arg0.emblemMaterial:completeAnimation()
			f14_arg0.emblemMaterial:setLeftRight(-0.02, 1.02, 9.5, -10.5)
			f14_arg0.emblemMaterial:setTopBottom(-0.02, 1.02, 10, -10)
			f14_local1(f14_arg0.emblemMaterial)
		end,
	},
	BMClassified = {
		DefaultClip = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(4)
			f17_arg0.emblemMaterial:completeAnimation()
			f17_arg0.emblemMaterial:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.emblemMaterial)
			f17_arg0.bgImage:completeAnimation()
			f17_arg0.bgImage:setAlpha(1)
			f17_arg0.clipFinished(f17_arg0.bgImage)
			f17_arg0.smallbargold:completeAnimation()
			f17_arg0.smallbargold:setAlpha(0.65)
			f17_arg0.clipFinished(f17_arg0.smallbargold)
			f17_arg0.blackMarketBrandIcon:completeAnimation()
			f17_arg0.blackMarketBrandIcon:setAlpha(1)
			f17_arg0.clipFinished(f17_arg0.blackMarketBrandIcon)
		end,
		Focus = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(3)
			f18_arg0.bgImage:completeAnimation()
			f18_arg0.bgImage:setAlpha(1)
			f18_arg0.clipFinished(f18_arg0.bgImage)
			f18_arg0.smallbargold:completeAnimation()
			f18_arg0.smallbargold:setAlpha(1)
			f18_arg0.clipFinished(f18_arg0.smallbargold)
			f18_arg0.blackMarketBrandIcon:completeAnimation()
			f18_arg0.blackMarketBrandIcon:setAlpha(1)
			f18_arg0.clipFinished(f18_arg0.blackMarketBrandIcon)
		end,
	},
	Locked = {
		DefaultClip = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(2)
			f19_arg0.emblemMaterial:completeAnimation()
			f19_arg0.emblemMaterial:setAlpha(0)
			f19_arg0.clipFinished(f19_arg0.emblemMaterial)
			f19_arg0.lockedIcon:completeAnimation()
			f19_arg0.lockedIcon:setAlpha(1)
			f19_arg0.clipFinished(f19_arg0.lockedIcon)
		end,
		Focus = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(2)
			f20_arg0.emblemMaterial:completeAnimation()
			f20_arg0.emblemMaterial:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.emblemMaterial)
			f20_arg0.lockedIcon:completeAnimation()
			f20_arg0.lockedIcon:setAlpha(1)
			f20_arg0.clipFinished(f20_arg0.lockedIcon)
		end,
		Over = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(2)
			f21_arg0.emblemMaterial:completeAnimation()
			f21_arg0.emblemMaterial:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.emblemMaterial)
			f21_arg0.lockedIcon:completeAnimation()
			f21_arg0.lockedIcon:setAlpha(1)
			f21_arg0.clipFinished(f21_arg0.lockedIcon)
		end,
	},
	New = {
		DefaultClip = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(1)
			f22_arg0.IconNew:completeAnimation()
			f22_arg0.IconNew:setAlpha(1)
			f22_arg0.clipFinished(f22_arg0.IconNew)
		end,
		Focus = function(f23_arg0, f23_arg1)
			f23_arg0:__resetProperties()
			f23_arg0:setupElementClipCounter(1)
			f23_arg0.IconNew:completeAnimation()
			f23_arg0.IconNew:setAlpha(1)
			f23_arg0.clipFinished(f23_arg0.IconNew)
		end,
		Over = function(f24_arg0, f24_arg1)
			f24_arg0:__resetProperties()
			f24_arg0:setupElementClipCounter(1)
			f24_arg0.IconNew:completeAnimation()
			f24_arg0.IconNew:setAlpha(1)
			f24_arg0.clipFinished(f24_arg0.IconNew)
		end,
	},
}
CoD.EmblemMaterialElement.__onClose = function(f25_arg0)
	f25_arg0.emblemMaterial:close()
	f25_arg0.lockedIcon:close()
	f25_arg0.IconNew:close()
end
