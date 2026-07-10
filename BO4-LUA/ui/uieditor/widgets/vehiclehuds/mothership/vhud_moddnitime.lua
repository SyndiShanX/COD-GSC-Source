CoD.vhud_ModDNITime = InheritFrom(LUI.UIElement)
CoD.vhud_ModDNITime.__defaultWidth = 78
CoD.vhud_ModDNITime.__defaultHeight = 85
CoD.vhud_ModDNITime.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.vhud_ModDNITime)
	self.id = "vhud_ModDNITime"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ModDNI = LUI.UIImage.new(0, 0, 21, 57, 0, 0, 24, 60)
	ModDNI:setImage(RegisterImage(0xA99159E8773B43E))
	ModDNI:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(ModDNI)
	self.ModDNI = ModDNI
	local ModDNIBracketB = LUI.UIImage.new(0, 0, 15, 63, 0, 0, 45, 69)
	ModDNIBracketB:setAlpha(0.2)
	ModDNIBracketB:setImage(RegisterImage(0xAA0E9F848AD21D6))
	ModDNIBracketB:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(ModDNIBracketB)
	self.ModDNIBracketB = ModDNIBracketB
	local ModDNIBracketT = LUI.UIImage.new(0, 0, 15, 63, 0, 0, 12, 36)
	ModDNIBracketT:setAlpha(0.2)
	ModDNIBracketT:setImage(RegisterImage(0xAA0DBF848AD0A0C))
	ModDNIBracketT:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(ModDNIBracketT)
	self.ModDNIBracketT = ModDNIBracketT
	local TextBox0 = LUI.UIText.new(0.5, 0.5, -39, 39, 0.5, 0.5, 19, 33)
	TextBox0:setAlpha(0)
	TextBox0:setText("")
	TextBox0:setTTF("ttmussels_demibold")
	TextBox0:setRFTMaterial(LUI.UIImage.GetCachedMaterial(0xFAEF6B981087FCE))
	TextBox0:setShaderVector(0, 0.05, 0.4, 0, 0)
	TextBox0:setShaderVector(1, 0, 0, 0, 0)
	TextBox0:setShaderVector(2, 0, 0, 0, 0)
	TextBox0:setShaderVector(3, 0, 0, 0, 0)
	TextBox0:setShaderVector(4, 0, 0, 0, 0)
	TextBox0:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	TextBox0:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(TextBox0)
	self.TextBox0 = TextBox0
	local ModDNI0 = LUI.UIImage.new(0, 0, 14, 65, 0, 0, 16, 67)
	ModDNI0:setAlpha(0)
	ModDNI0:setImage(RegisterImage(0xA99159E8773B43E))
	ModDNI0:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(ModDNI0)
	self.ModDNI0 = ModDNI0
	self:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return HideVehicleReticle(self, f1_arg1, event)
			end,
		},
	})
	local f1_local6 = self
	local f1_local7 = self.subscribeToModel
	local f1_local8 = DataSources.VehicleInfo.getModel(f1_arg1)
	f1_local7(f1_local6, f1_local8.vehicleType, function(f3_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f3_arg0:get(),
			modelName = "vehicleType",
		})
	end, false)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.vhud_ModDNITime.__resetProperties = function(f4_arg0)
	f4_arg0.ModDNI:completeAnimation()
	f4_arg0.ModDNI0:completeAnimation()
	f4_arg0.ModDNIBracketT:completeAnimation()
	f4_arg0.ModDNIBracketB:completeAnimation()
	f4_arg0.ModDNI:setAlpha(1)
	f4_arg0.ModDNI:setXRot(0)
	f4_arg0.ModDNI:setYRot(0)
	f4_arg0.ModDNI:setZRot(0)
	f4_arg0.ModDNI:setZoom(0)
	f4_arg0.ModDNI0:setRGB(1, 1, 1)
	f4_arg0.ModDNI0:setAlpha(0)
	f4_arg0.ModDNI0:setXRot(0)
	f4_arg0.ModDNI0:setYRot(0)
	f4_arg0.ModDNI0:setZRot(0)
	f4_arg0.ModDNIBracketT:setLeftRight(0, 0, 15, 63)
	f4_arg0.ModDNIBracketT:setTopBottom(0, 0, 12, 36)
	f4_arg0.ModDNIBracketT:setRGB(1, 1, 1)
	f4_arg0.ModDNIBracketT:setZRot(0)
	f4_arg0.ModDNIBracketB:setLeftRight(0, 0, 15, 63)
	f4_arg0.ModDNIBracketB:setTopBottom(0, 0, 45, 69)
	f4_arg0.ModDNIBracketB:setRGB(1, 1, 1)
	f4_arg0.ModDNIBracketB:setZRot(0)
end
CoD.vhud_ModDNITime.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(4)
			local f5_local0 = function(f6_arg0)
				local f6_local0 = function(f7_arg0)
					f7_arg0:beginAnimation(1290)
					f7_arg0:registerEventHandler("transition_complete_keyframe", f5_arg0.clipFinished)
				end
				f5_arg0.ModDNI:beginAnimation(1210, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
				f5_arg0.ModDNI:setXRot(360)
				f5_arg0.ModDNI:setYRot(360)
				f5_arg0.ModDNI:setZRot(360)
				f5_arg0.ModDNI:registerEventHandler("interrupted_keyframe", f5_arg0.clipInterrupted)
				f5_arg0.ModDNI:registerEventHandler("transition_complete_keyframe", f6_local0)
			end
			f5_arg0.ModDNI:completeAnimation()
			f5_arg0.ModDNI:setAlpha(1)
			f5_arg0.ModDNI:setXRot(0)
			f5_arg0.ModDNI:setYRot(0)
			f5_arg0.ModDNI:setZRot(0)
			f5_arg0.ModDNI:setZoom(0)
			f5_local0(f5_arg0.ModDNI)
			local f5_local1 = function(f8_arg0)
				local f8_local0 = function(f9_arg0)
					local f9_local0 = function(f10_arg0)
						local f10_local0 = function(f11_arg0)
							local f11_local0 = function(f12_arg0)
								f12_arg0:beginAnimation(320, Enum[0xF50FFF429AB1890][0xE99F3A6467FC0CA] | Enum[0xF50FFF429AB1890][0x53CEB9A0427197])
								f12_arg0:setLeftRight(0, 0, 15, 63)
								f12_arg0:setTopBottom(0, 0, 45, 69)
								f12_arg0:setZRot(0)
								f12_arg0:registerEventHandler("transition_complete_keyframe", f5_arg0.clipFinished)
							end
							f11_arg0:beginAnimation(289)
							f11_arg0:setLeftRight(0, 0, 24.08, 72.08)
							f11_arg0:setTopBottom(0, 0, 50.3, 74.3)
							f11_arg0:setRGB(1, 1, 1)
							f11_arg0:setZRot(34)
							f11_arg0:registerEventHandler("transition_complete_keyframe", f11_local0)
						end
						f10_arg0:beginAnimation(360, Enum[0xF50FFF429AB1890][0xE99F3A6467FC0CA] | Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
						f10_arg0:setLeftRight(0, 0, -9, 39)
						f10_arg0:setTopBottom(0, 0, 31, 55)
						f10_arg0:setZRot(-90)
						f10_arg0:registerEventHandler("transition_complete_keyframe", f10_local0)
					end
					f9_arg0:beginAnimation(80)
					f9_arg0:setLeftRight(0, 0, -17.51, 30.49)
					f9_arg0:setTopBottom(0, 0, 26.04, 50.04)
					f9_arg0:setRGB(0.8, 1, 0.98)
					f9_arg0:setZRot(-122)
					f9_arg0:registerEventHandler("transition_complete_keyframe", f9_local0)
				end
				f5_arg0.ModDNIBracketB:beginAnimation(160)
				f5_arg0.ModDNIBracketB:setLeftRight(0, 0, -12.61, 35.39)
				f5_arg0.ModDNIBracketB:setTopBottom(0, 0, 28.89, 52.89)
				f5_arg0.ModDNIBracketB:setZRot(-104)
				f5_arg0.ModDNIBracketB:registerEventHandler("interrupted_keyframe", f5_arg0.clipInterrupted)
				f5_arg0.ModDNIBracketB:registerEventHandler("transition_complete_keyframe", f8_local0)
			end
			f5_arg0.ModDNIBracketB:completeAnimation()
			f5_arg0.ModDNIBracketB:setLeftRight(0, 0, 15, 63)
			f5_arg0.ModDNIBracketB:setTopBottom(0, 0, 45, 69)
			f5_arg0.ModDNIBracketB:setRGB(1, 1, 1)
			f5_arg0.ModDNIBracketB:setZRot(0)
			f5_local1(f5_arg0.ModDNIBracketB)
			local f5_local2 = function(f13_arg0)
				local f13_local0 = function(f14_arg0)
					local f14_local0 = function(f15_arg0)
						local f15_local0 = function(f16_arg0)
							f16_arg0:beginAnimation(320, Enum[0xF50FFF429AB1890][0xE99F3A6467FC0CA] | Enum[0xF50FFF429AB1890][0x53CEB9A0427197])
							f16_arg0:setLeftRight(0, 0, 15, 63)
							f16_arg0:setTopBottom(0, 0, 12, 36)
							f16_arg0:setZRot(0)
							f16_arg0:registerEventHandler("transition_complete_keyframe", f5_arg0.clipFinished)
						end
						f15_arg0:beginAnimation(289)
						f15_arg0:setLeftRight(0, 0, 5.54, 53.54)
						f15_arg0:setTopBottom(0, 0, 5.19, 29.19)
						f15_arg0:setRGB(1, 1, 1)
						f15_arg0:setZRot(34)
						f15_arg0:registerEventHandler("transition_complete_keyframe", f15_local0)
					end
					f14_arg0:beginAnimation(440, Enum[0xF50FFF429AB1890][0xE99F3A6467FC0CA] | Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
					f14_arg0:setLeftRight(0, 0, 40, 88)
					f14_arg0:setTopBottom(0, 0, 30, 54)
					f14_arg0:setRGB(0.8, 1, 0.98)
					f14_arg0:setZRot(-90)
					f14_arg0:registerEventHandler("transition_complete_keyframe", f14_local0)
				end
				f5_arg0.ModDNIBracketT:beginAnimation(160)
				f5_arg0.ModDNIBracketT:setLeftRight(0, 0, 43.77, 91.77)
				f5_arg0.ModDNIBracketT:setTopBottom(0, 0, 32.71, 56.71)
				f5_arg0.ModDNIBracketT:setZRot(-104)
				f5_arg0.ModDNIBracketT:registerEventHandler("interrupted_keyframe", f5_arg0.clipInterrupted)
				f5_arg0.ModDNIBracketT:registerEventHandler("transition_complete_keyframe", f13_local0)
			end
			f5_arg0.ModDNIBracketT:completeAnimation()
			f5_arg0.ModDNIBracketT:setLeftRight(0, 0, 15, 63)
			f5_arg0.ModDNIBracketT:setTopBottom(0, 0, 12, 36)
			f5_arg0.ModDNIBracketT:setRGB(1, 1, 1)
			f5_arg0.ModDNIBracketT:setZRot(0)
			f5_local2(f5_arg0.ModDNIBracketT)
			local f5_local3 = function(f17_arg0)
				local f17_local0 = function(f18_arg0)
					f18_arg0:beginAnimation(610, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
					f18_arg0:setAlpha(0)
					f18_arg0:setXRot(-360)
					f18_arg0:setYRot(-360)
					f18_arg0:setZRot(-360)
					f18_arg0:registerEventHandler("transition_complete_keyframe", f5_arg0.clipFinished)
				end
				f5_arg0.ModDNI0:beginAnimation(600)
				f5_arg0.ModDNI0:setAlpha(0.55)
				f5_arg0.ModDNI0:setXRot(-178)
				f5_arg0.ModDNI0:setYRot(-178)
				f5_arg0.ModDNI0:setZRot(-178)
				f5_arg0.ModDNI0:registerEventHandler("interrupted_keyframe", f5_arg0.clipInterrupted)
				f5_arg0.ModDNI0:registerEventHandler("transition_complete_keyframe", f17_local0)
			end
			f5_arg0.ModDNI0:completeAnimation()
			f5_arg0.ModDNI0:setRGB(0.8, 1, 0.98)
			f5_arg0.ModDNI0:setAlpha(0)
			f5_arg0.ModDNI0:setXRot(0)
			f5_arg0.ModDNI0:setYRot(0)
			f5_arg0.ModDNI0:setZRot(0)
			f5_local3(f5_arg0.ModDNI0)
			f5_arg0.nextClip = "DefaultClip"
		end,
	},
	Hidden = {
		DefaultClip = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(0)
		end,
	},
}
