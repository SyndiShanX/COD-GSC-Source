CoD.AARGameInfo = InheritFrom(LUI.UIElement)
CoD.AARGameInfo.__defaultWidth = 1920
CoD.AARGameInfo.__defaultHeight = 200
CoD.AARGameInfo.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.AARGameInfo)
	self.id = "AARGameInfo"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local GametypeImage = LUI.UIImage.new(0, 0, 614, 734, 0, 0, -27.5, 92.5)
	GametypeImage:setAlpha(0.5)
	GametypeImage:linkToElementModel(self, "gametypeIcon", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			GametypeImage:setImage(RegisterImage(f2_local0))
		end
	end)
	self:addElement(GametypeImage)
	self.GametypeImage = GametypeImage
	local GametypeAndMap = LUI.UIText.new(0, 0, 737, 1591, 0, 0, -12.5, 8.5)
	GametypeAndMap:setRGB(0.9, 0.89, 0.78)
	GametypeAndMap:setAlpha(0.2)
	GametypeAndMap:setTTF("dinnext_regular")
	GametypeAndMap:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	GametypeAndMap:linkToElementModel(self, "gametypeAndMap", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			GametypeAndMap:setText(f3_local0)
		end
	end)
	self:addElement(GametypeAndMap)
	self.GametypeAndMap = GametypeAndMap
	local VictoryDefeatGlow = LUI.UIText.new(0, 0, 737, 1592, 0, 0, 12, 87)
	VictoryDefeatGlow:setRGB(0.9, 0.89, 0.78)
	VictoryDefeatGlow:setAlpha(0)
	VictoryDefeatGlow:setText(Engine[@"hash_4F9F1239CFD921FE"](@"aar/victory"))
	VictoryDefeatGlow:setTTF("ttmussels_demibold")
	VictoryDefeatGlow:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_90D57B1E92D39D7"))
	VictoryDefeatGlow:setShaderVector(0, 0.6, 0, 0, 0)
	VictoryDefeatGlow:setShaderVector(1, 0, 0, 0, 0)
	VictoryDefeatGlow:setShaderVector(2, 1, 1, 1, 0.6)
	VictoryDefeatGlow:setLetterSpacing(10)
	VictoryDefeatGlow:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	VictoryDefeatGlow:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(VictoryDefeatGlow)
	self.VictoryDefeatGlow = VictoryDefeatGlow
	local VictoryDefeat = LUI.UIText.new(0, 0, 737, 1592, 0, 0, 12, 87)
	VictoryDefeat:setRGB(0.9, 0.89, 0.78)
	VictoryDefeat:setText(Engine[@"hash_4F9F1239CFD921FE"](@"aar/victory"))
	VictoryDefeat:setTTF("ttmussels_demibold")
	VictoryDefeat:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_171E049B161CD00A"))
	VictoryDefeat:setLetterSpacing(10)
	VictoryDefeat:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	self:addElement(VictoryDefeat)
	self.VictoryDefeat = VictoryDefeat
	self:mergeStateConditions({
		{
			stateName = "Defeated",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "lastMatchOutcome", @"loss")
			end,
		},
		{
			stateName = "Draw",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "lastMatchOutcome", @"draw")
			end,
		},
	})
	self:linkToElementModel(self, "lastMatchOutcome", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "lastMatchOutcome",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.AARGameInfo.__resetProperties = function(f7_arg0)
	f7_arg0.VictoryDefeat:completeAnimation()
	f7_arg0.VictoryDefeatGlow:completeAnimation()
	f7_arg0.VictoryDefeat:setRGB(0.9, 0.89, 0.78)
	f7_arg0.VictoryDefeat:setAlpha(1)
	f7_arg0.VictoryDefeat:setText(Engine[@"hash_4F9F1239CFD921FE"](@"aar/victory"))
	f7_arg0.VictoryDefeatGlow:setAlpha(0)
	f7_arg0.VictoryDefeatGlow:setText(Engine[@"hash_4F9F1239CFD921FE"](@"aar/victory"))
	f7_arg0.VictoryDefeatGlow:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_90D57B1E92D39D7"))
	f7_arg0.VictoryDefeatGlow:setShaderVector(0, 0.6, 0, 0, 0)
	f7_arg0.VictoryDefeatGlow:setShaderVector(1, 0, 0, 0, 0)
	f7_arg0.VictoryDefeatGlow:setShaderVector(2, 1, 1, 1, 0.6)
	f7_arg0.VictoryDefeatGlow:setRFTMaterial(LUI.UIImage.GetCachedMaterial(@"ui_normal"))
	f7_arg0.VictoryDefeatGlow:setBackingMaterial(LUI.UIImage.GetCachedMaterial(@"ui_normal"))
	f7_arg0.VictoryDefeatGlow:setBackingMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_normal"))
end
CoD.AARGameInfo.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(2)
			f8_arg0.VictoryDefeatGlow:completeAnimation()
			f8_arg0.VictoryDefeatGlow:setAlpha(0.8)
			f8_arg0.VictoryDefeatGlow:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_90D57B1E92D39D7"))
			f8_arg0.VictoryDefeatGlow:setShaderVector(0, 0.6, 0, 0, 0)
			f8_arg0.VictoryDefeatGlow:setShaderVector(1, 0, 0, 0, 0)
			f8_arg0.VictoryDefeatGlow:setShaderVector(2, 0.4, 0.5, 0.21, 0.6)
			f8_arg0.VictoryDefeatGlow:setRFTMaterial(LUI.UIImage.GetCachedMaterial(@"ui_normal"))
			f8_arg0.VictoryDefeatGlow:setBackingMaterial(LUI.UIImage.GetCachedMaterial(@"ui_normal"))
			f8_arg0.VictoryDefeatGlow:setBackingMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_normal"))
			f8_arg0.clipFinished(f8_arg0.VictoryDefeatGlow)
			f8_arg0.VictoryDefeat:completeAnimation()
			f8_arg0.VictoryDefeat:setRGB(0.4, 0.55, 0.22)
			f8_arg0.VictoryDefeat:setAlpha(1)
			f8_arg0.clipFinished(f8_arg0.VictoryDefeat)
		end,
	},
	Defeated = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(2)
			f9_arg0.VictoryDefeatGlow:completeAnimation()
			f9_arg0.VictoryDefeatGlow:setAlpha(1)
			f9_arg0.VictoryDefeatGlow:setText(Engine[@"hash_4F9F1239CFD921FE"](@"aar/defeat"))
			f9_arg0.VictoryDefeatGlow:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_90D57B1E92D39D7"))
			f9_arg0.VictoryDefeatGlow:setShaderVector(0, 0.6, 0, 0, 0)
			f9_arg0.VictoryDefeatGlow:setShaderVector(1, 0, 0, 0, 0)
			f9_arg0.VictoryDefeatGlow:setShaderVector(2, 1, 0, 0, 0.6)
			f9_arg0.VictoryDefeatGlow:setRFTMaterial(LUI.UIImage.GetCachedMaterial(@"ui_normal"))
			f9_arg0.VictoryDefeatGlow:setBackingMaterial(LUI.UIImage.GetCachedMaterial(@"ui_normal"))
			f9_arg0.VictoryDefeatGlow:setBackingMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_normal"))
			f9_arg0.clipFinished(f9_arg0.VictoryDefeatGlow)
			f9_arg0.VictoryDefeat:completeAnimation()
			f9_arg0.VictoryDefeat:setRGB(0.82, 0.33, 0.18)
			f9_arg0.VictoryDefeat:setAlpha(1)
			f9_arg0.VictoryDefeat:setText(Engine[@"hash_4F9F1239CFD921FE"](@"aar/defeat"))
			f9_arg0.clipFinished(f9_arg0.VictoryDefeat)
		end,
	},
	Draw = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(2)
			f10_arg0.VictoryDefeatGlow:completeAnimation()
			f10_arg0.VictoryDefeatGlow:setAlpha(0)
			f10_arg0.VictoryDefeatGlow:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_90D57B1E92D39D7"))
			f10_arg0.VictoryDefeatGlow:setShaderVector(0, 0, 0, 0, 0)
			f10_arg0.VictoryDefeatGlow:setShaderVector(1, 0, 0, 0, 0)
			f10_arg0.VictoryDefeatGlow:setShaderVector(2, 1, 1, 1, 0)
			f10_arg0.VictoryDefeatGlow:setRFTMaterial(LUI.UIImage.GetCachedMaterial(@"ui_normal"))
			f10_arg0.VictoryDefeatGlow:setBackingMaterial(LUI.UIImage.GetCachedMaterial(@"ui_normal"))
			f10_arg0.VictoryDefeatGlow:setBackingMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_normal"))
			f10_arg0.clipFinished(f10_arg0.VictoryDefeatGlow)
			f10_arg0.VictoryDefeat:completeAnimation()
			f10_arg0.VictoryDefeat:setAlpha(0.3)
			f10_arg0.VictoryDefeat:setText(Engine[@"hash_4F9F1239CFD921FE"](@"aar/draw"))
			f10_arg0.clipFinished(f10_arg0.VictoryDefeat)
		end,
	},
}
CoD.AARGameInfo.__onClose = function(f11_arg0)
	f11_arg0.GametypeImage:close()
	f11_arg0.GametypeAndMap:close()
end
