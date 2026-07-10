require("x64:4a27c4a09aafd11")
CoD.grapple_reticle_internal = InheritFrom(LUI.UIElement)
CoD.grapple_reticle_internal.__defaultWidth = 150
CoD.grapple_reticle_internal.__defaultHeight = 150
CoD.grapple_reticle_internal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.grapple_reticle_internal)
	self.id = "grapple_reticle_internal"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local validCenter = LUI.UIImage.new(0.5, 0.5, -10, 10, 0.5, 0.5, -10, 10)
	validCenter:setAlpha(0)
	validCenter:setImage(RegisterImage(@"uie_ui_hud_reticles_grapple_valid_center"))
	self:addElement(validCenter)
	self.validCenter = validCenter
	local validProngRight = CoD.grapple_reticle_prong.new(f1_arg0, f1_arg1, 0.5, 0.5, -50, 50, 0.5, 0.5, -75, 75)
	validProngRight:setAlpha(0.15)
	validProngRight:setZRot(-120)
	self:addElement(validProngRight)
	self.validProngRight = validProngRight
	local validProngTop = CoD.grapple_reticle_prong.new(f1_arg0, f1_arg1, 0.5, 0.5, -50, 50, 0.5, 0.5, -75, 75)
	validProngTop:setAlpha(0.15)
	self:addElement(validProngTop)
	self.validProngTop = validProngTop
	local validProngLeft = CoD.grapple_reticle_prong.new(f1_arg0, f1_arg1, 0.5, 0.5, -50, 50, 0.5, 0.5, -75, 75)
	validProngLeft:setAlpha(0.15)
	validProngLeft:setZRot(120)
	self:addElement(validProngLeft)
	self.validProngLeft = validProngLeft
	self:mergeStateConditions({
		{
			stateName = "Valid",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalDataSourceModelValueTrue(f1_arg1, "CurrentWeapon", "grappleLockOn")
			end,
		},
	})
	local f1_local5 = self
	local f1_local6 = self.subscribeToModel
	local f1_local7 = DataSources.CurrentWeapon.getModel(f1_arg1)
	f1_local6(f1_local5, f1_local7.grappleLockOn, function(f3_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f3_arg0:get(),
			modelName = "grappleLockOn",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.grapple_reticle_internal.__resetProperties = function(f4_arg0)
	f4_arg0.validProngRight:completeAnimation()
	f4_arg0.validProngTop:completeAnimation()
	f4_arg0.validProngLeft:completeAnimation()
	f4_arg0.validCenter:completeAnimation()
	f4_arg0.validProngRight:setLeftRight(0.5, 0.5, -50, 50)
	f4_arg0.validProngRight:setTopBottom(0.5, 0.5, -75, 75)
	f4_arg0.validProngRight:setAlpha(0.15)
	f4_arg0.validProngTop:setLeftRight(0.5, 0.5, -50, 50)
	f4_arg0.validProngTop:setTopBottom(0.5, 0.5, -75, 75)
	f4_arg0.validProngTop:setAlpha(0.15)
	f4_arg0.validProngLeft:setLeftRight(0.5, 0.5, -50, 50)
	f4_arg0.validProngLeft:setTopBottom(0.5, 0.5, -75, 75)
	f4_arg0.validProngLeft:setAlpha(0.15)
	f4_arg0.validCenter:setAlpha(0)
end
CoD.grapple_reticle_internal.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(4)
			f5_arg0.validCenter:completeAnimation()
			f5_arg0.validCenter:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.validCenter)
			f5_arg0.validProngRight:completeAnimation()
			f5_arg0.validProngRight:setAlpha(0.15)
			f5_arg0.clipFinished(f5_arg0.validProngRight)
			f5_arg0.validProngTop:completeAnimation()
			f5_arg0.validProngTop:setAlpha(0.15)
			f5_arg0.clipFinished(f5_arg0.validProngTop)
			f5_arg0.validProngLeft:completeAnimation()
			f5_arg0.validProngLeft:setAlpha(0.15)
			f5_arg0.clipFinished(f5_arg0.validProngLeft)
		end,
		Valid = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(4)
			local f6_local0 = function(f7_arg0)
				f6_arg0.validCenter:beginAnimation(30)
				f6_arg0.validCenter:setAlpha(1)
				f6_arg0.validCenter:registerEventHandler("interrupted_keyframe", f6_arg0.clipInterrupted)
				f6_arg0.validCenter:registerEventHandler("transition_complete_keyframe", f6_arg0.clipFinished)
			end
			f6_arg0.validCenter:completeAnimation()
			f6_arg0.validCenter:setAlpha(0)
			f6_local0(f6_arg0.validCenter)
			local f6_local1 = function(f8_arg0)
				local f8_local0 = function(f9_arg0)
					f9_arg0:beginAnimation(70, Enum[@"luitween"][@"luitween_ease_out"])
					f9_arg0:setTopBottom(0.5, 0.5, -45, 45)
					f9_arg0:registerEventHandler("transition_complete_keyframe", f6_arg0.clipFinished)
				end
				f6_arg0.validProngRight:beginAnimation(30)
				f6_arg0.validProngRight:setTopBottom(0.5, 0.5, -66, 66)
				f6_arg0.validProngRight:setAlpha(1)
				f6_arg0.validProngRight:registerEventHandler("interrupted_keyframe", f6_arg0.clipInterrupted)
				f6_arg0.validProngRight:registerEventHandler("transition_complete_keyframe", f8_local0)
			end
			f6_arg0.validProngRight:completeAnimation()
			f6_arg0.validProngRight:setLeftRight(0.5, 0.5, -50, 50)
			f6_arg0.validProngRight:setTopBottom(0.5, 0.5, -75, 75)
			f6_arg0.validProngRight:setAlpha(0.15)
			f6_local1(f6_arg0.validProngRight)
			local f6_local2 = function(f10_arg0)
				local f10_local0 = function(f11_arg0)
					f11_arg0:beginAnimation(70, Enum[@"luitween"][@"luitween_ease_out"])
					f11_arg0:setTopBottom(0.5, 0.5, -45, 45)
					f11_arg0:registerEventHandler("transition_complete_keyframe", f6_arg0.clipFinished)
				end
				f6_arg0.validProngTop:beginAnimation(30)
				f6_arg0.validProngTop:setTopBottom(0.5, 0.5, -66, 66)
				f6_arg0.validProngTop:setAlpha(1)
				f6_arg0.validProngTop:registerEventHandler("interrupted_keyframe", f6_arg0.clipInterrupted)
				f6_arg0.validProngTop:registerEventHandler("transition_complete_keyframe", f10_local0)
			end
			f6_arg0.validProngTop:completeAnimation()
			f6_arg0.validProngTop:setLeftRight(0.5, 0.5, -50, 50)
			f6_arg0.validProngTop:setTopBottom(0.5, 0.5, -75, 75)
			f6_arg0.validProngTop:setAlpha(0.15)
			f6_local2(f6_arg0.validProngTop)
			local f6_local3 = function(f12_arg0)
				local f12_local0 = function(f13_arg0)
					f13_arg0:beginAnimation(70, Enum[@"luitween"][@"luitween_ease_out"])
					f13_arg0:setTopBottom(0.5, 0.5, -45, 45)
					f13_arg0:registerEventHandler("transition_complete_keyframe", f6_arg0.clipFinished)
				end
				f6_arg0.validProngLeft:beginAnimation(30)
				f6_arg0.validProngLeft:setTopBottom(0.5, 0.5, -66, 66)
				f6_arg0.validProngLeft:setAlpha(1)
				f6_arg0.validProngLeft:registerEventHandler("interrupted_keyframe", f6_arg0.clipInterrupted)
				f6_arg0.validProngLeft:registerEventHandler("transition_complete_keyframe", f12_local0)
			end
			f6_arg0.validProngLeft:completeAnimation()
			f6_arg0.validProngLeft:setLeftRight(0.5, 0.5, -50, 50)
			f6_arg0.validProngLeft:setTopBottom(0.5, 0.5, -75, 75)
			f6_arg0.validProngLeft:setAlpha(0.15)
			f6_local3(f6_arg0.validProngLeft)
		end,
	},
	Valid = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(4)
			f14_arg0.validCenter:completeAnimation()
			f14_arg0.validCenter:setAlpha(1)
			f14_arg0.clipFinished(f14_arg0.validCenter)
			f14_arg0.validProngRight:completeAnimation()
			f14_arg0.validProngRight:setLeftRight(0.5, 0.5, -50, 50)
			f14_arg0.validProngRight:setTopBottom(0.5, 0.5, -45, 45)
			f14_arg0.validProngRight:setAlpha(1)
			f14_arg0.clipFinished(f14_arg0.validProngRight)
			f14_arg0.validProngTop:completeAnimation()
			f14_arg0.validProngTop:setLeftRight(0.5, 0.5, -50, 50)
			f14_arg0.validProngTop:setTopBottom(0.5, 0.5, -45, 45)
			f14_arg0.validProngTop:setAlpha(1)
			f14_arg0.clipFinished(f14_arg0.validProngTop)
			f14_arg0.validProngLeft:completeAnimation()
			f14_arg0.validProngLeft:setLeftRight(0.5, 0.5, -50, 50)
			f14_arg0.validProngLeft:setTopBottom(0.5, 0.5, -45, 45)
			f14_arg0.validProngLeft:setAlpha(1)
			f14_arg0.clipFinished(f14_arg0.validProngLeft)
		end,
		DefaultState = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(4)
			local f15_local0 = function(f16_arg0)
				f15_arg0.validCenter:beginAnimation(100)
				f15_arg0.validCenter:setAlpha(0)
				f15_arg0.validCenter:registerEventHandler("interrupted_keyframe", f15_arg0.clipInterrupted)
				f15_arg0.validCenter:registerEventHandler("transition_complete_keyframe", f15_arg0.clipFinished)
			end
			f15_arg0.validCenter:completeAnimation()
			f15_arg0.validCenter:setAlpha(1)
			f15_local0(f15_arg0.validCenter)
			local f15_local1 = function(f17_arg0)
				f15_arg0.validProngRight:beginAnimation(100, Enum[@"luitween"][@"luitween_ease_in"])
				f15_arg0.validProngRight:setTopBottom(0.5, 0.5, -75, 75)
				f15_arg0.validProngRight:setAlpha(0.15)
				f15_arg0.validProngRight:registerEventHandler("interrupted_keyframe", f15_arg0.clipInterrupted)
				f15_arg0.validProngRight:registerEventHandler("transition_complete_keyframe", f15_arg0.clipFinished)
			end
			f15_arg0.validProngRight:completeAnimation()
			f15_arg0.validProngRight:setLeftRight(0.5, 0.5, -50, 50)
			f15_arg0.validProngRight:setTopBottom(0.5, 0.5, -45, 45)
			f15_arg0.validProngRight:setAlpha(1)
			f15_local1(f15_arg0.validProngRight)
			local f15_local2 = function(f18_arg0)
				f15_arg0.validProngTop:beginAnimation(100, Enum[@"luitween"][@"luitween_ease_in"])
				f15_arg0.validProngTop:setTopBottom(0.5, 0.5, -75, 75)
				f15_arg0.validProngTop:setAlpha(0.15)
				f15_arg0.validProngTop:registerEventHandler("interrupted_keyframe", f15_arg0.clipInterrupted)
				f15_arg0.validProngTop:registerEventHandler("transition_complete_keyframe", f15_arg0.clipFinished)
			end
			f15_arg0.validProngTop:completeAnimation()
			f15_arg0.validProngTop:setLeftRight(0.5, 0.5, -50, 50)
			f15_arg0.validProngTop:setTopBottom(0.5, 0.5, -45, 45)
			f15_arg0.validProngTop:setAlpha(1)
			f15_local2(f15_arg0.validProngTop)
			local f15_local3 = function(f19_arg0)
				f15_arg0.validProngLeft:beginAnimation(100, Enum[@"luitween"][@"luitween_ease_in"])
				f15_arg0.validProngLeft:setTopBottom(0.5, 0.5, -75, 75)
				f15_arg0.validProngLeft:setAlpha(0.15)
				f15_arg0.validProngLeft:registerEventHandler("interrupted_keyframe", f15_arg0.clipInterrupted)
				f15_arg0.validProngLeft:registerEventHandler("transition_complete_keyframe", f15_arg0.clipFinished)
			end
			f15_arg0.validProngLeft:completeAnimation()
			f15_arg0.validProngLeft:setLeftRight(0.5, 0.5, -50, 50)
			f15_arg0.validProngLeft:setTopBottom(0.5, 0.5, -45, 45)
			f15_arg0.validProngLeft:setAlpha(1)
			f15_local3(f15_arg0.validProngLeft)
		end,
	},
}
CoD.grapple_reticle_internal.__onClose = function(f20_arg0)
	f20_arg0.validProngRight:close()
	f20_arg0.validProngTop:close()
	f20_arg0.validProngLeft:close()
end
