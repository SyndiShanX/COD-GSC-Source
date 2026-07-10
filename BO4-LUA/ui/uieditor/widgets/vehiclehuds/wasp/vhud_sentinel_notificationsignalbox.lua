CoD.vhud_sentinel_NotificationSignalBox = InheritFrom(LUI.UIElement)
CoD.vhud_sentinel_NotificationSignalBox.__defaultWidth = 121
CoD.vhud_sentinel_NotificationSignalBox.__defaultHeight = 45
CoD.vhud_sentinel_NotificationSignalBox.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.vhud_sentinel_NotificationSignalBox)
	self.id = "vhud_sentinel_NotificationSignalBox"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local STRONG = LUI.UIText.new(0, 1, 0, 0, 0, 0, 10, 34)
	STRONG:setText(Engine[0xF9F1239CFD921FE](0x2E90397EC44E953))
	STRONG:setTTF("default")
	STRONG:setRFTMaterial(LUI.UIImage.GetCachedMaterial(0xD756CD9A5F1F1B4))
	STRONG:setShaderVector(0, 0, 1, 0, 0)
	STRONG:setShaderVector(1, 0, 0, 0, 0)
	STRONG:setShaderVector(2, 0, 0, 0, 0)
	STRONG:setShaderVector(3, 0, 0, 0, 0)
	STRONG:setShaderVector(4, 0, 0, 0, 0)
	STRONG:setLetterSpacing(6)
	STRONG:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	STRONG:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(STRONG)
	self.STRONG = STRONG
	local STRONG0 = LUI.UIText.new(0, 1, 0, 0, 0, 0, 10, 34)
	STRONG0:setText(Engine[0xF9F1239CFD921FE](0x2E90397EC44E953))
	STRONG0:setTTF("default")
	STRONG0:setRFTMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	STRONG0:setLetterSpacing(6)
	STRONG0:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	STRONG0:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(STRONG0)
	self.STRONG0 = STRONG0
	local WEAK = LUI.UIText.new(0, 1, 0, 0, 0, 0, 10, 34)
	WEAK:setRGB(1, 0, 0)
	WEAK:setText(Engine[0xF9F1239CFD921FE](0xF33AED3A709B334))
	WEAK:setTTF("default")
	WEAK:setRFTMaterial(LUI.UIImage.GetCachedMaterial(0xD756CD9A5F1F1B4))
	WEAK:setShaderVector(0, 0, 1, 0, 0)
	WEAK:setShaderVector(1, 0, 0, 0, 0)
	WEAK:setShaderVector(2, 0, 0, 0, 0)
	WEAK:setShaderVector(3, 0, 0, 0, 0)
	WEAK:setShaderVector(4, 0, 0, 0, 0)
	WEAK:setLetterSpacing(6)
	WEAK:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	WEAK:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(WEAK)
	self.WEAK = WEAK
	local WEAK0 = LUI.UIText.new(0, 1, 0, 0, 0, 0, 10, 34)
	WEAK0:setRGB(1, 0, 0)
	WEAK0:setAlpha(0)
	WEAK0:setText(Engine[0xF9F1239CFD921FE](0xF33AED3A709B334))
	WEAK0:setTTF("default")
	WEAK0:setLetterSpacing(6)
	WEAK0:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	WEAK0:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(WEAK0)
	self.WEAK0 = WEAK0
	local WEAK00 = LUI.UIText.new(0, 1, 0, 0, 0, 0, 10, 34)
	WEAK00:setRGB(1, 0, 0)
	WEAK00:setText(Engine[0xF9F1239CFD921FE](0xF33AED3A709B334))
	WEAK00:setTTF("default")
	WEAK00:setRFTMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	WEAK00:setLetterSpacing(6)
	WEAK00:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	WEAK00:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(WEAK00)
	self.WEAK00 = WEAK00
	local WEAK000 = LUI.UIText.new(0, 1, 0, 0, 0, 0, 10, 34)
	WEAK000:setRGB(1, 0, 0)
	WEAK000:setAlpha(0)
	WEAK000:setText(Engine[0xF9F1239CFD921FE](0xF33AED3A709B334))
	WEAK000:setTTF("default")
	WEAK000:setRFTMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	WEAK000:setLetterSpacing(6)
	WEAK000:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	WEAK000:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(WEAK000)
	self.WEAK000 = WEAK000
	local GlowOrangeOver = LUI.UIImage.new(0.5, 0.5, -21, 18, 0, 0, -30, 76)
	GlowOrangeOver:setRGB(1, 0, 0.03)
	GlowOrangeOver:setAlpha(0.5)
	GlowOrangeOver:setZRot(-90)
	GlowOrangeOver:setImage(RegisterImage(0x5BE416E17DAB33B))
	GlowOrangeOver:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(GlowOrangeOver)
	self.GlowOrangeOver = GlowOrangeOver
	self:mergeStateConditions({
		{
			stateName = "OutOfRange",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "outOfRange")
			end,
		},
	})
	self:linkToElementModel(self, "outOfRange", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "outOfRange",
		})
	end)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.vhud_sentinel_NotificationSignalBox.__resetProperties = function(f4_arg0)
	f4_arg0.WEAK:completeAnimation()
	f4_arg0.WEAK00:completeAnimation()
	f4_arg0.GlowOrangeOver:completeAnimation()
	f4_arg0.STRONG:completeAnimation()
	f4_arg0.STRONG0:completeAnimation()
	f4_arg0.WEAK000:completeAnimation()
	f4_arg0.WEAK:setAlpha(1)
	f4_arg0.WEAK00:setAlpha(1)
	f4_arg0.GlowOrangeOver:setAlpha(0.5)
	f4_arg0.STRONG:setAlpha(1)
	f4_arg0.STRONG0:setAlpha(1)
	f4_arg0.WEAK000:setAlpha(0)
end
CoD.vhud_sentinel_NotificationSignalBox.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(3)
			f5_arg0.WEAK:completeAnimation()
			f5_arg0.WEAK:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.WEAK)
			f5_arg0.WEAK00:completeAnimation()
			f5_arg0.WEAK00:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.WEAK00)
			f5_arg0.GlowOrangeOver:completeAnimation()
			f5_arg0.GlowOrangeOver:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.GlowOrangeOver)
		end,
		StartUp = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(3)
			f6_arg0.WEAK:completeAnimation()
			f6_arg0.WEAK:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.WEAK)
			f6_arg0.WEAK00:completeAnimation()
			f6_arg0.WEAK00:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.WEAK00)
			f6_arg0.GlowOrangeOver:completeAnimation()
			f6_arg0.GlowOrangeOver:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.GlowOrangeOver)
		end,
	},
	OutOfRange = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(6)
			f7_arg0.STRONG:completeAnimation()
			f7_arg0.STRONG:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.STRONG)
			f7_arg0.STRONG0:completeAnimation()
			f7_arg0.STRONG0:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.STRONG0)
			local f7_local0 = function(f8_arg0)
				local f8_local0 = function(f9_arg0)
					local f9_local0 = function(f10_arg0)
						f10_arg0:beginAnimation(199, Enum[0xF50FFF429AB1890][0x53CEB9A0427197])
						f10_arg0:setAlpha(0.6)
						f10_arg0:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
					end
					f9_arg0:beginAnimation(100)
					f9_arg0:registerEventHandler("transition_complete_keyframe", f9_local0)
				end
				f7_arg0.WEAK:beginAnimation(210, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
				f7_arg0.WEAK:setAlpha(1)
				f7_arg0.WEAK:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.WEAK:registerEventHandler("transition_complete_keyframe", f8_local0)
			end
			f7_arg0.WEAK:completeAnimation()
			f7_arg0.WEAK:setAlpha(0.6)
			f7_local0(f7_arg0.WEAK)
			local f7_local1 = function(f11_arg0)
				local f11_local0 = function(f12_arg0)
					local f12_local0 = function(f13_arg0)
						f13_arg0:beginAnimation(199)
						f13_arg0:setAlpha(0)
						f13_arg0:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
					end
					f12_arg0:beginAnimation(100)
					f12_arg0:registerEventHandler("transition_complete_keyframe", f12_local0)
				end
				f7_arg0.WEAK00:beginAnimation(210)
				f7_arg0.WEAK00:setAlpha(1)
				f7_arg0.WEAK00:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.WEAK00:registerEventHandler("transition_complete_keyframe", f11_local0)
			end
			f7_arg0.WEAK00:completeAnimation()
			f7_arg0.WEAK00:setAlpha(0)
			f7_local1(f7_arg0.WEAK00)
			local f7_local2 = function(f14_arg0)
				local f14_local0 = function(f15_arg0)
					local f15_local0 = function(f16_arg0)
						f16_arg0:beginAnimation(199)
						f16_arg0:setAlpha(0)
						f16_arg0:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
					end
					f15_arg0:beginAnimation(100)
					f15_arg0:registerEventHandler("transition_complete_keyframe", f15_local0)
				end
				f7_arg0.WEAK000:beginAnimation(210)
				f7_arg0.WEAK000:setAlpha(1)
				f7_arg0.WEAK000:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.WEAK000:registerEventHandler("transition_complete_keyframe", f14_local0)
			end
			f7_arg0.WEAK000:completeAnimation()
			f7_arg0.WEAK000:setAlpha(0)
			f7_local2(f7_arg0.WEAK000)
			local f7_local3 = function(f17_arg0)
				local f17_local0 = function(f18_arg0)
					local f18_local0 = function(f19_arg0)
						f19_arg0:beginAnimation(199)
						f19_arg0:setAlpha(0.1)
						f19_arg0:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
					end
					f18_arg0:beginAnimation(100)
					f18_arg0:registerEventHandler("transition_complete_keyframe", f18_local0)
				end
				f7_arg0.GlowOrangeOver:beginAnimation(210)
				f7_arg0.GlowOrangeOver:setAlpha(0.5)
				f7_arg0.GlowOrangeOver:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.GlowOrangeOver:registerEventHandler("transition_complete_keyframe", f17_local0)
			end
			f7_arg0.GlowOrangeOver:completeAnimation()
			f7_arg0.GlowOrangeOver:setAlpha(0.1)
			f7_local3(f7_arg0.GlowOrangeOver)
			f7_arg0.nextClip = "DefaultClip"
		end,
	},
}
