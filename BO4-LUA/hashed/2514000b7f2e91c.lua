CoD.DeployableNotifications_SensorDartIcon = InheritFrom(LUI.UIElement)
CoD.DeployableNotifications_SensorDartIcon.__defaultWidth = 60
CoD.DeployableNotifications_SensorDartIcon.__defaultHeight = 60
CoD.DeployableNotifications_SensorDartIcon.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.DeployableNotifications_SensorDartIcon)
	self.id = "DeployableNotifications_SensorDartIcon"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local DartIcon = LUI.UIImage.new(0, 0, -35, 93, 0, 0, -26, 102)
	DartIcon:setImage(RegisterImage(@"hash_7D67C4B118BE8D31"))
	self:addElement(DartIcon)
	self.DartIcon = DartIcon
	local DartEcho = LUI.UIImage.new(0, 0, 12, 48, 0, 0, 12, 48)
	DartEcho:setRGB(0, 0.76, 1)
	DartEcho:setAlpha(0)
	DartEcho:setImage(RegisterImage(@"hash_5B5CF7AB5AD5141B"))
	self:addElement(DartEcho)
	self.DartEcho = DartEcho
	self:mergeStateConditions({
		{
			stateName = "Destroyed",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local3 = self
	CoD.BaseUtility.SetStateOnClipOver(self, f1_arg1, "DefaultState")
	return self
end
CoD.DeployableNotifications_SensorDartIcon.__resetProperties = function(f3_arg0)
	f3_arg0.DartIcon:completeAnimation()
	f3_arg0.DartEcho:completeAnimation()
	f3_arg0.DartIcon:setRGB(1, 1, 1)
	f3_arg0.DartIcon:setAlpha(1)
	f3_arg0.DartIcon:setScale(1, 1)
	f3_arg0.DartEcho:setAlpha(0)
	f3_arg0.DartEcho:setScale(1, 1)
end
CoD.DeployableNotifications_SensorDartIcon.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(2)
			local f4_local0 = function(f5_arg0)
				local f5_local0 = function(f6_arg0)
					f6_arg0:beginAnimation(750)
					f6_arg0:setRGB(1, 1, 1)
					f6_arg0:registerEventHandler("transition_complete_keyframe", f4_arg0.clipFinished)
				end
				f4_arg0.DartIcon:beginAnimation(750)
				f4_arg0.DartIcon:setRGB(0, 0.72, 1)
				f4_arg0.DartIcon:registerEventHandler("interrupted_keyframe", f4_arg0.clipInterrupted)
				f4_arg0.DartIcon:registerEventHandler("transition_complete_keyframe", f5_local0)
			end
			f4_arg0.DartIcon:completeAnimation()
			f4_arg0.DartIcon:setRGB(1, 1, 1)
			f4_local0(f4_arg0.DartIcon)
			local f4_local1 = function(f7_arg0)
				local f7_local0 = function(f8_arg0)
					f8_arg0:beginAnimation(360)
					f8_arg0:setAlpha(0)
					f8_arg0:setScale(1.5, 1.5)
					f8_arg0:registerEventHandler("transition_complete_keyframe", f4_arg0.clipFinished)
				end
				f4_arg0.DartEcho:beginAnimation(390)
				f4_arg0.DartEcho:setAlpha(1)
				f4_arg0.DartEcho:setScale(1.26, 1.26)
				f4_arg0.DartEcho:registerEventHandler("interrupted_keyframe", f4_arg0.clipInterrupted)
				f4_arg0.DartEcho:registerEventHandler("transition_complete_keyframe", f7_local0)
			end
			f4_arg0.DartEcho:completeAnimation()
			f4_arg0.DartEcho:setAlpha(0)
			f4_arg0.DartEcho:setScale(1, 1)
			f4_local1(f4_arg0.DartEcho)
			f4_arg0.nextClip = "DefaultClip"
		end,
	},
	Destroyed = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(1)
			local f9_local0 = function(f10_arg0)
				local f10_local0 = function(f11_arg0)
					local f11_local0 = function(f12_arg0)
						local f12_local0 = function(f13_arg0)
							local f13_local0 = function(f14_arg0)
								local f14_local0 = function(f15_arg0)
									local f15_local0 = function(f16_arg0)
										local f16_local0 = function(f17_arg0)
											f17_arg0:beginAnimation(40)
											f17_arg0:setAlpha(0)
											f17_arg0:registerEventHandler("transition_complete_keyframe", f9_arg0.clipFinished)
										end
										f16_arg0:beginAnimation(39)
										f16_arg0:setAlpha(0.33)
										f16_arg0:registerEventHandler("transition_complete_keyframe", f16_local0)
									end
									f15_arg0:beginAnimation(40)
									f15_arg0:setAlpha(0)
									f15_arg0:registerEventHandler("transition_complete_keyframe", f15_local0)
								end
								f14_arg0:beginAnimation(9)
								f14_arg0:setAlpha(0.8)
								f14_arg0:setScale(1, 1)
								f14_arg0:registerEventHandler("transition_complete_keyframe", f14_local0)
							end
							f13_arg0:beginAnimation(49)
							f13_arg0:setAlpha(1)
							f13_arg0:setScale(1.08, 1.08)
							f13_arg0:registerEventHandler("transition_complete_keyframe", f13_local0)
						end
						f12_arg0:beginAnimation(30)
						f12_arg0:setAlpha(0)
						f12_arg0:setScale(1.49, 1.49)
						f12_arg0:registerEventHandler("transition_complete_keyframe", f12_local0)
					end
					f11_arg0:beginAnimation(10)
					f11_arg0:setScale(1.73, 1.73)
					f11_arg0:registerEventHandler("transition_complete_keyframe", f11_local0)
				end
				f9_arg0.DartIcon:beginAnimation(30)
				f9_arg0.DartIcon:registerEventHandler("interrupted_keyframe", f9_arg0.clipInterrupted)
				f9_arg0.DartIcon:registerEventHandler("transition_complete_keyframe", f10_local0)
			end
			f9_arg0.DartIcon:completeAnimation()
			f9_arg0.DartIcon:setRGB(1, 0, 0)
			f9_arg0.DartIcon:setAlpha(1)
			f9_arg0.DartIcon:setScale(1.81, 1.81)
			f9_local0(f9_arg0.DartIcon)
		end,
	},
}
