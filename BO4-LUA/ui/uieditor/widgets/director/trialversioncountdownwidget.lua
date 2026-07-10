require("x64:acbf06924421e35")
require("x64:19c1945d2e472b0")
require("x64:2d361ac3553c22a")
CoD.TrialVersionCountdownWidget = InheritFrom(LUI.UIElement)
CoD.TrialVersionCountdownWidget.__defaultWidth = 312
CoD.TrialVersionCountdownWidget.__defaultHeight = 64
CoD.TrialVersionCountdownWidget.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.TrialVersionCountdownWidget)
	self.id = "TrialVersionCountdownWidget"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local SceneBlur = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	SceneBlur:setRGB(0, 0, 0)
	SceneBlur:setMaterial(LUI.UIImage.GetCachedMaterial(0xE2354BE557C4C7A))
	SceneBlur:setShaderVector(0, 0, 0.4, 0, 0)
	self:addElement(SceneBlur)
	self.SceneBlur = SceneBlur
	local NoiseTiledBacking = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	NoiseTiledBacking:setAlpha(0.95)
	NoiseTiledBacking:setImage(RegisterImage(0x34839E8065B1E53))
	NoiseTiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	NoiseTiledBacking:setShaderVector(0, 0, 0, 0, 0)
	NoiseTiledBacking:setupNineSliceShader(196, 88)
	self:addElement(NoiseTiledBacking)
	self.NoiseTiledBacking = NoiseTiledBacking
	local Tint = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Tint:setRGB(0, 0, 0)
	Tint:setAlpha(0.75)
	self:addElement(Tint)
	self.Tint = Tint
	local StoreCommonTextBacking = CoD.StoreCommonTextBacking.new(f1_arg0, f1_arg1, 0, 1, 2, -2, 0, 1, 2, -2)
	StoreCommonTextBacking.TiledShaderImage:setupNineSliceShader(36, 36)
	self:addElement(StoreCommonTextBacking)
	self.StoreCommonTextBacking = StoreCommonTextBacking
	local TrialWidget = CoD.TrialWidget.new(f1_arg0, f1_arg1, 0, 0, 9, 49, 0, 0, 12, 52)
	self:addElement(TrialWidget)
	self.TrialWidget = TrialWidget
	local TrialText = LUI.UIText.new(0, 0, 58, 305, 0, 0, 10.5, 31.5)
	TrialText:setRGB(ColorSet.T8__OCHRE.r, ColorSet.T8__OCHRE.g, ColorSet.T8__OCHRE.b)
	TrialText:setText(LocalizeToUpperString(0xF16F4088C060F3A))
	TrialText:setTTF("ttmussels_demibold")
	TrialText:setLetterSpacing(3)
	TrialText:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	self:addElement(TrialText)
	self.TrialText = TrialText
	local TrialCountdownText = LUI.UIText.new(0, 0, 58, 305, 0, 0, 36.5, 54.5)
	TrialCountdownText:setRGB(0.92, 0.92, 0.92)
	TrialCountdownText:setTTF("ttmussels_demibold")
	TrialCountdownText:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	TrialCountdownText:setAlignment(Enum[0x7A5123B654282D2][0xE821F0ECFF8D1C7])
	TrialCountdownText:subscribeToGlobalModel(f1_arg1, "WarzoneTrialInfo", "countdown_timer", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			TrialCountdownText:setText(LocalizeIntoStringIfNotEmpty(0xC0CE2452CF87DB1, f2_local0))
		end
	end)
	self:addElement(TrialCountdownText)
	self.TrialCountdownText = TrialCountdownText
	local FrontendFrame02 = LUI.UIImage.new(0, 1, -1, 1, 0, 1, -1, 1)
	FrontendFrame02:setAlpha(0.8)
	FrontendFrame02:setImage(RegisterImage(0x185E11D74ECA3D7))
	FrontendFrame02:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD777557404A7B3))
	FrontendFrame02:setShaderVector(0, 0, 0, 0, 0)
	FrontendFrame02:setupNineSliceShader(10, 10)
	self:addElement(FrontendFrame02)
	self.FrontendFrame02 = FrontendFrame02
	local CommonCornerPips = CoD.CommonCornerPips01.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(CommonCornerPips)
	self.CommonCornerPips = CommonCornerPips
	self:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return not IsGameTrial()
			end,
		},
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local10 = self
	CoD.DirectorUtility.EnableTrialTick(self)
	return self
end
CoD.TrialVersionCountdownWidget.__resetProperties = function(f4_arg0)
	f4_arg0.TrialCountdownText:completeAnimation()
	f4_arg0.TrialText:completeAnimation()
	f4_arg0.TrialWidget:completeAnimation()
	f4_arg0.TrialCountdownText:setAlpha(1)
	f4_arg0.TrialText:setAlpha(1)
	f4_arg0.TrialWidget:setAlpha(1)
end
CoD.TrialVersionCountdownWidget.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			local f5_local0 = function(f6_arg0)
				local f6_local0 = function(f7_arg0)
					local f7_local0 = function(f8_arg0)
						f8_arg0:beginAnimation(1000)
						f8_arg0:registerEventHandler("transition_complete_keyframe", f5_arg0.clipFinished)
					end
					f7_arg0:beginAnimation(1000)
					f7_arg0:setAlpha(1)
					f7_arg0:registerEventHandler("transition_complete_keyframe", f7_local0)
				end
				f5_arg0.TrialCountdownText:beginAnimation(1000)
				f5_arg0.TrialCountdownText:setAlpha(0.4)
				f5_arg0.TrialCountdownText:registerEventHandler("interrupted_keyframe", f5_arg0.clipInterrupted)
				f5_arg0.TrialCountdownText:registerEventHandler("transition_complete_keyframe", f6_local0)
			end
			f5_arg0.TrialCountdownText:completeAnimation()
			f5_arg0.TrialCountdownText:setAlpha(1)
			f5_local0(f5_arg0.TrialCountdownText)
			f5_arg0.nextClip = "DefaultClip"
		end,
	},
	Hidden = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(3)
			f9_arg0.TrialWidget:completeAnimation()
			f9_arg0.TrialWidget:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.TrialWidget)
			f9_arg0.TrialText:completeAnimation()
			f9_arg0.TrialText:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.TrialText)
			f9_arg0.TrialCountdownText:completeAnimation()
			f9_arg0.TrialCountdownText:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.TrialCountdownText)
		end,
	},
}
CoD.TrialVersionCountdownWidget.__onClose = function(f10_arg0)
	f10_arg0.StoreCommonTextBacking:close()
	f10_arg0.TrialWidget:close()
	f10_arg0.TrialCountdownText:close()
	f10_arg0.CommonCornerPips:close()
end
