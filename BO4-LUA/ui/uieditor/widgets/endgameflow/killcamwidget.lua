require("x64:a3bf59b02ee9e3c")
require("x64:163ae1497736852")
require("x64:37c24d33c50231f")
require("x64:bd15fd80b6b0985")
CoD.KillcamWidget = InheritFrom(LUI.UIElement)
CoD.KillcamWidget.__defaultWidth = 1920
CoD.KillcamWidget.__defaultHeight = 1080
CoD.KillcamWidget.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setUseCylinderMapping(false)
	self:setClass(CoD.KillcamWidget)
	self.id = "KillcamWidget"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local blackplateblur = LUI.UIImage.new(-0.1, 1.1, 0, 0, 1, 1, -161, 5)
	blackplateblur:setRGB(0, 0, 0)
	blackplateblur:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_E2354BE557C4C7A"))
	blackplateblur:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(blackplateblur)
	self.blackplateblur = blackplateblur
	local bottombarblack = LUI.UIImage.new(-0.1, 1.1, 0, 0, 1, 1, -161, 5)
	bottombarblack:setRGB(0, 0, 0)
	bottombarblack:setAlpha(0.95)
	self:addElement(bottombarblack)
	self.bottombarblack = bottombarblack
	local topbarblackblur = LUI.UIImage.new(-0.1, 1.1, 0, 0, 0, 0, -13, 95)
	topbarblackblur:setRGB(0, 0, 0)
	topbarblackblur:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_E2354BE557C4C7A"))
	topbarblackblur:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(topbarblackblur)
	self.topbarblackblur = topbarblackblur
	local KillcamPlayerInfo = CoD.KillcamPlayerInfo.new(f1_arg0, f1_arg1, 0.5, 0.5, -960, 960, 1, 1, -173, 5)
	self:addElement(KillcamPlayerInfo)
	self.KillcamPlayerInfo = KillcamPlayerInfo
	local topbarblack = LUI.UIImage.new(-0.1, 1.1, 0, 0, 0, 0, -13, 95)
	topbarblack:setRGB(0, 0, 0)
	topbarblack:setAlpha(0.95)
	topbarblack:setImage(RegisterImage(@"hash_5128E65A576FCBB8"))
	self:addElement(topbarblack)
	self.topbarblack = topbarblack
	local KillcamHeader = CoD.KillcamHeader.new(f1_arg0, f1_arg1, 0.5, 0.5, -905, 1015, 0, 0, 9, 149)
	self:addElement(KillcamHeader)
	self.KillcamHeader = KillcamHeader
	local KilledByAttachments = CoD.KillcamKilledByAttachments.new(f1_arg0, f1_arg1, 0.5, 0.5, 489, 864, 0, 0, 95, 165)
	self:addElement(KilledByAttachments)
	self.KilledByAttachments = KilledByAttachments
	local KilledByEquipment = CoD.KillcamKilledByEquipment.new(f1_arg0, f1_arg1, 0.5, 0.5, 369, 864, 0.5, 0.5, -362, 158)
	self:addElement(KilledByEquipment)
	self.KilledByEquipment = KilledByEquipment
	self:mergeStateConditions({
		{
			stateName = "Killcam",
			condition = function(menu, element, event)
				local f2_local0
				if not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_nemesis_killcam"]) then
					f2_local0 = Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_killcam"])
					if f2_local0 then
						if not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_final_killcam"]) and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_round_end_killcam"]) then
							f2_local0 = not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_play_of_the_match"])
						else
							f2_local0 = false
						end
					end
				elseif not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_final_killcam"]) and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_round_end_killcam"]) then
					f2_local0 = not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_play_of_the_match"])
				else
					f2_local0 = false
				end
				return f2_local0
			end,
		},
	})
	local f1_local9 = self
	local f1_local10 = self.subscribeToModel
	local f1_local11 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local10(f1_local9, f1_local11["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_nemesis_killcam"]], function(f3_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f3_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_nemesis_killcam"],
		})
	end, false)
	f1_local9 = self
	f1_local10 = self.subscribeToModel
	f1_local11 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local10(f1_local9, f1_local11["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_killcam"]], function(f4_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f4_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_killcam"],
		})
	end, false)
	f1_local9 = self
	f1_local10 = self.subscribeToModel
	f1_local11 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local10(f1_local9, f1_local11["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_final_killcam"]], function(f5_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f5_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_final_killcam"],
		})
	end, false)
	f1_local9 = self
	f1_local10 = self.subscribeToModel
	f1_local11 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local10(f1_local9, f1_local11["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_round_end_killcam"]], function(f6_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_round_end_killcam"],
		})
	end, false)
	f1_local9 = self
	f1_local10 = self.subscribeToModel
	f1_local11 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local10(f1_local9, f1_local11["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_play_of_the_match"]], function(f7_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f7_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_play_of_the_match"],
		})
	end, false)
	KillcamPlayerInfo.id = "KillcamPlayerInfo"
	KilledByEquipment.id = "KilledByEquipment"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.KillcamWidget.__resetProperties = function(f8_arg0)
	f8_arg0.KillcamHeader:completeAnimation()
	f8_arg0.KillcamPlayerInfo:completeAnimation()
	f8_arg0.topbarblack:completeAnimation()
	f8_arg0.bottombarblack:completeAnimation()
	f8_arg0.blackplateblur:completeAnimation()
	f8_arg0.topbarblackblur:completeAnimation()
	f8_arg0.KilledByAttachments:completeAnimation()
	f8_arg0.KilledByEquipment:completeAnimation()
	f8_arg0.KillcamHeader:setTopBottom(0, 0, 9, 149)
	f8_arg0.KillcamHeader:setAlpha(1)
	f8_arg0.KillcamPlayerInfo:setTopBottom(1, 1, -173, 5)
	f8_arg0.KillcamPlayerInfo:setAlpha(1)
	f8_arg0.topbarblack:setTopBottom(0, 0, -13, 95)
	f8_arg0.topbarblack:setAlpha(0.95)
	f8_arg0.bottombarblack:setTopBottom(1, 1, -161, 5)
	f8_arg0.bottombarblack:setAlpha(0.95)
	f8_arg0.blackplateblur:setTopBottom(1, 1, -161, 5)
	f8_arg0.blackplateblur:setAlpha(1)
	f8_arg0.topbarblackblur:setTopBottom(0, 0, -13, 95)
	f8_arg0.topbarblackblur:setAlpha(1)
	f8_arg0.KilledByAttachments:setAlpha(1)
	f8_arg0.KilledByEquipment:setAlpha(1)
end
CoD.KillcamWidget.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(8)
			f9_arg0.blackplateblur:completeAnimation()
			f9_arg0.blackplateblur:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.blackplateblur)
			f9_arg0.bottombarblack:completeAnimation()
			f9_arg0.bottombarblack:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.bottombarblack)
			f9_arg0.topbarblackblur:completeAnimation()
			f9_arg0.topbarblackblur:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.topbarblackblur)
			f9_arg0.KillcamPlayerInfo:completeAnimation()
			f9_arg0.KillcamPlayerInfo:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.KillcamPlayerInfo)
			f9_arg0.topbarblack:completeAnimation()
			f9_arg0.topbarblack:setTopBottom(0, 0, -13, 99)
			f9_arg0.topbarblack:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.topbarblack)
			f9_arg0.KillcamHeader:completeAnimation()
			f9_arg0.KillcamHeader:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.KillcamHeader)
			f9_arg0.KilledByAttachments:completeAnimation()
			f9_arg0.KilledByAttachments:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.KilledByAttachments)
			f9_arg0.KilledByEquipment:completeAnimation()
			f9_arg0.KilledByEquipment:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.KilledByEquipment)
		end,
	},
	Killcam = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(8)
			local f10_local0 = function(f11_arg0)
				local f11_local0 = function(f12_arg0)
					f12_arg0:beginAnimation(60)
					f12_arg0:registerEventHandler("transition_complete_keyframe", f10_arg0.clipFinished)
				end
				f10_arg0.blackplateblur:beginAnimation(420)
				f10_arg0.blackplateblur:setTopBottom(1, 1, -155, 9)
				f10_arg0.blackplateblur:setAlpha(1)
				f10_arg0.blackplateblur:registerEventHandler("interrupted_keyframe", f10_arg0.clipInterrupted)
				f10_arg0.blackplateblur:registerEventHandler("transition_complete_keyframe", f11_local0)
			end
			f10_arg0.blackplateblur:completeAnimation()
			f10_arg0.blackplateblur:setTopBottom(1, 1, 0, 164)
			f10_arg0.blackplateblur:setAlpha(0)
			f10_local0(f10_arg0.blackplateblur)
			local f10_local1 = function(f13_arg0)
				local f13_local0 = function(f14_arg0)
					local f14_local0 = function(f15_arg0)
						f15_arg0:beginAnimation(60)
						f15_arg0:registerEventHandler("transition_complete_keyframe", f10_arg0.clipFinished)
					end
					f14_arg0:beginAnimation(219)
					f14_arg0:setTopBottom(1, 1, -155, 10)
					f14_arg0:registerEventHandler("transition_complete_keyframe", f14_local0)
				end
				f10_arg0.bottombarblack:beginAnimation(200)
				f10_arg0.bottombarblack:setTopBottom(1, 1, -73.81, 91.19)
				f10_arg0.bottombarblack:setAlpha(0.97)
				f10_arg0.bottombarblack:registerEventHandler("interrupted_keyframe", f10_arg0.clipInterrupted)
				f10_arg0.bottombarblack:registerEventHandler("transition_complete_keyframe", f13_local0)
			end
			f10_arg0.bottombarblack:completeAnimation()
			f10_arg0.bottombarblack:setTopBottom(1, 1, 0, 165)
			f10_arg0.bottombarblack:setAlpha(0)
			f10_local1(f10_arg0.bottombarblack)
			local f10_local2 = function(f16_arg0)
				f10_arg0.topbarblackblur:beginAnimation(420)
				f10_arg0.topbarblackblur:setTopBottom(0, 0, -13, 95)
				f10_arg0.topbarblackblur:setAlpha(0.95)
				f10_arg0.topbarblackblur:registerEventHandler("interrupted_keyframe", f10_arg0.clipInterrupted)
				f10_arg0.topbarblackblur:registerEventHandler("transition_complete_keyframe", f10_arg0.clipFinished)
			end
			f10_arg0.topbarblackblur:completeAnimation()
			f10_arg0.topbarblackblur:setTopBottom(0, 0, -121, -13)
			f10_arg0.topbarblackblur:setAlpha(0)
			f10_local2(f10_arg0.topbarblackblur)
			local f10_local3 = function(f17_arg0)
				local f17_local0 = function(f18_arg0)
					f18_arg0:beginAnimation(60)
					f18_arg0:setAlpha(1)
					f18_arg0:registerEventHandler("transition_complete_keyframe", f10_arg0.clipFinished)
				end
				f10_arg0.KillcamPlayerInfo:beginAnimation(420)
				f10_arg0.KillcamPlayerInfo:setTopBottom(1, 1, -167, 11)
				f10_arg0.KillcamPlayerInfo:registerEventHandler("interrupted_keyframe", f10_arg0.clipInterrupted)
				f10_arg0.KillcamPlayerInfo:registerEventHandler("transition_complete_keyframe", f17_local0)
			end
			f10_arg0.KillcamPlayerInfo:completeAnimation()
			f10_arg0.KillcamPlayerInfo:setTopBottom(1, 1, -5.5, 172.5)
			f10_arg0.KillcamPlayerInfo:setAlpha(0)
			f10_local3(f10_arg0.KillcamPlayerInfo)
			local f10_local4 = function(f19_arg0)
				local f19_local0 = function(f20_arg0)
					f20_arg0:beginAnimation(219)
					f20_arg0:setTopBottom(0, 0, -13, 95)
					f20_arg0:registerEventHandler("transition_complete_keyframe", f10_arg0.clipFinished)
				end
				f10_arg0.topbarblack:beginAnimation(200)
				f10_arg0.topbarblack:setTopBottom(0, 0, -69.05, 38.95)
				f10_arg0.topbarblack:setAlpha(0.97)
				f10_arg0.topbarblack:registerEventHandler("interrupted_keyframe", f10_arg0.clipInterrupted)
				f10_arg0.topbarblack:registerEventHandler("transition_complete_keyframe", f19_local0)
			end
			f10_arg0.topbarblack:completeAnimation()
			f10_arg0.topbarblack:setTopBottom(0, 0, -120, -12)
			f10_arg0.topbarblack:setAlpha(0)
			f10_local4(f10_arg0.topbarblack)
			local f10_local5 = function(f21_arg0)
				local f21_local0 = function(f22_arg0)
					f22_arg0:beginAnimation(60)
					f22_arg0:setAlpha(1)
					f22_arg0:registerEventHandler("transition_complete_keyframe", f10_arg0.clipFinished)
				end
				f21_arg0:beginAnimation(279)
				f21_arg0:registerEventHandler("transition_complete_keyframe", f21_local0)
			end
			f10_arg0.KillcamHeader:beginAnimation(140)
			f10_arg0.KillcamHeader:setTopBottom(0, 0, 6, 146)
			f10_arg0.KillcamHeader:setAlpha(0)
			f10_arg0.KillcamHeader:registerEventHandler("interrupted_keyframe", f10_arg0.clipInterrupted)
			f10_arg0.KillcamHeader:registerEventHandler("transition_complete_keyframe", f10_local5)
			local f10_local6 = function(f23_arg0)
				local f23_local0 = function(f24_arg0)
					f24_arg0:beginAnimation(60)
					f24_arg0:setAlpha(1)
					f24_arg0:registerEventHandler("transition_complete_keyframe", f10_arg0.clipFinished)
				end
				f10_arg0.KilledByAttachments:beginAnimation(420)
				f10_arg0.KilledByAttachments:registerEventHandler("interrupted_keyframe", f10_arg0.clipInterrupted)
				f10_arg0.KilledByAttachments:registerEventHandler("transition_complete_keyframe", f23_local0)
			end
			f10_arg0.KilledByAttachments:completeAnimation()
			f10_arg0.KilledByAttachments:setAlpha(0)
			f10_local6(f10_arg0.KilledByAttachments)
			local f10_local7 = function(f25_arg0)
				local f25_local0 = function(f26_arg0)
					f26_arg0:beginAnimation(60)
					f26_arg0:setAlpha(1)
					f26_arg0:registerEventHandler("transition_complete_keyframe", f10_arg0.clipFinished)
				end
				f10_arg0.KilledByEquipment:beginAnimation(420)
				f10_arg0.KilledByEquipment:registerEventHandler("interrupted_keyframe", f10_arg0.clipInterrupted)
				f10_arg0.KilledByEquipment:registerEventHandler("transition_complete_keyframe", f25_local0)
			end
			f10_arg0.KilledByEquipment:completeAnimation()
			f10_arg0.KilledByEquipment:setAlpha(0)
			f10_local7(f10_arg0.KilledByEquipment)
		end,
	},
}
CoD.KillcamWidget.__onClose = function(f27_arg0)
	f27_arg0.KillcamPlayerInfo:close()
	f27_arg0.KillcamHeader:close()
	f27_arg0.KilledByAttachments:close()
	f27_arg0.KilledByEquipment:close()
end
