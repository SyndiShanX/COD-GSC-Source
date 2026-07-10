require("x64:73c969b5dbad3ea")
require("x64:5f8cf56752aa71b")
CoD.EmblemGroupNew_Internal = InheritFrom(LUI.UIElement)
CoD.EmblemGroupNew_Internal.__defaultWidth = 144
CoD.EmblemGroupNew_Internal.__defaultHeight = 144
CoD.EmblemGroupNew_Internal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.EmblemGroupNew_Internal)
	self.id = "EmblemGroupNew_Internal"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local NoiseTiledBacking = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	NoiseTiledBacking:setAlpha(0.8)
	NoiseTiledBacking:setImage(RegisterImage(0x34839E8065B1E53))
	NoiseTiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	NoiseTiledBacking:setShaderVector(0, 0, 0, 0, 0)
	NoiseTiledBacking:setupNineSliceShader(196, 88)
	self:addElement(NoiseTiledBacking)
	self.NoiseTiledBacking = NoiseTiledBacking
	local SelectorOverlay = LUI.UIImage.new(0.44, 1.44, -64, -64, 0.44, 1.44, -64, -64)
	SelectorOverlay:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	SelectorOverlay:setAlpha(0.01)
	self:addElement(SelectorOverlay)
	self.SelectorOverlay = SelectorOverlay
	local DrawGroupDecalByIndex = LUI.UIElement.new(0, 0, 6, 138, 0, 0, 6, 138)
	self:addElement(DrawGroupDecalByIndex)
	self.DrawGroupDecalByIndex = DrawGroupDecalByIndex
	local IconNew = CoD.cac_LabelNew.new(f1_arg0, f1_arg1, 0.5, 0.5, -81, 81, 0.5, 0.5, -17, 19)
	IconNew:setAlpha(0)
	self:addElement(IconNew)
	self.IconNew = IconNew
	local FrontendFrame = LUI.UIImage.new(0, 1, -1, 1, 0, 1, -1, 1)
	FrontendFrame:setAlpha(0.2)
	FrontendFrame:setImage(RegisterImage(0x185E11D74ECA3D7))
	FrontendFrame:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD777557404A7B3))
	FrontendFrame:setShaderVector(0, 0, 0, 0, 0)
	FrontendFrame:setupNineSliceShader(12, 12)
	self:addElement(FrontendFrame)
	self.FrontendFrame = FrontendFrame
	local groupIcon = LUI.UIImage.new(0, 0, 6, 36, 0.5, 0.5, -66, -36)
	groupIcon:setImage(RegisterImage(0x964B04560791FCF))
	self:addElement(groupIcon)
	self.groupIcon = groupIcon
	local layerNumber = LUI.UIText.new(0, 0, 36, 57, 0.04, 0.24, 0, 0)
	layerNumber:setText(Engine[0xF9F1239CFD921FE](0x6D1701FCBBE8ED8))
	layerNumber:setTTF("ttmussels_demibold")
	layerNumber:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	self:addElement(layerNumber)
	self.layerNumber = layerNumber
	local CommonButtonOutline = CoD.CommonButtonOutline.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(CommonButtonOutline)
	self.CommonButtonOutline = CommonButtonOutline
	self.DrawGroupDecalByIndex:linkToElementModel(self, "emblemIndex", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			DrawGroupDecalByIndex:setupDecalGroupByIndex(GetDecalGroupIndexParams(f1_arg1, f2_local0))
		end
	end)
	self:mergeStateConditions({
		{
			stateName = "BMClassified",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "isBMClassified")
			end,
		},
		{
			stateName = "CantFit",
			condition = function(menu, element, event)
				return not CoD.CraftUtility.EmblemChooseIcon_CanFitDecalGroup(self, element, f1_arg1)
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
	CommonButtonOutline.id = "CommonButtonOutline"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.EmblemGroupNew_Internal.__resetProperties = function(f6_arg0)
	f6_arg0.SelectorOverlay:completeAnimation()
	f6_arg0.layerNumber:completeAnimation()
	f6_arg0.SelectorOverlay:setAlpha(0.01)
	f6_arg0.layerNumber:setRGB(1, 1, 1)
end
CoD.EmblemGroupNew_Internal.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(1)
			f8_arg0.SelectorOverlay:completeAnimation()
			f8_arg0.SelectorOverlay:setAlpha(0.04)
			f8_arg0.clipFinished(f8_arg0.SelectorOverlay)
		end,
		GainChildFocus = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(1)
			local f9_local0 = function(f10_arg0)
				f9_arg0.SelectorOverlay:beginAnimation(200)
				f9_arg0.SelectorOverlay:setAlpha(0.04)
				f9_arg0.SelectorOverlay:registerEventHandler("interrupted_keyframe", f9_arg0.clipInterrupted)
				f9_arg0.SelectorOverlay:registerEventHandler("transition_complete_keyframe", f9_arg0.clipFinished)
			end
			f9_arg0.SelectorOverlay:completeAnimation()
			f9_arg0.SelectorOverlay:setAlpha(0.01)
			f9_local0(f9_arg0.SelectorOverlay)
		end,
		LoseChildFocus = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(1)
			local f11_local0 = function(f12_arg0)
				f11_arg0.SelectorOverlay:beginAnimation(200)
				f11_arg0.SelectorOverlay:setAlpha(0.01)
				f11_arg0.SelectorOverlay:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.SelectorOverlay:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
			end
			f11_arg0.SelectorOverlay:completeAnimation()
			f11_arg0.SelectorOverlay:setAlpha(0.04)
			f11_local0(f11_arg0.SelectorOverlay)
		end,
	},
	BMClassified = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(0)
		end,
		Focus = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(1)
			f14_arg0.SelectorOverlay:completeAnimation()
			f14_arg0.SelectorOverlay:setAlpha(0.04)
			f14_arg0.clipFinished(f14_arg0.SelectorOverlay)
		end,
	},
	CantFit = {
		DefaultClip = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(1)
			f15_arg0.layerNumber:completeAnimation()
			f15_arg0.layerNumber:setRGB(ColorSet.ResistanceHigh.r, ColorSet.ResistanceHigh.g, ColorSet.ResistanceHigh.b)
			f15_arg0.clipFinished(f15_arg0.layerNumber)
		end,
	},
}
CoD.EmblemGroupNew_Internal.__onClose = function(f16_arg0)
	f16_arg0.DrawGroupDecalByIndex:close()
	f16_arg0.IconNew:close()
	f16_arg0.CommonButtonOutline:close()
end
