CoD.DeployableNotifications_MiniTurretIcon = InheritFrom(LUI.UIElement)
CoD.DeployableNotifications_MiniTurretIcon.__defaultWidth = 60
CoD.DeployableNotifications_MiniTurretIcon.__defaultHeight = 60
CoD.DeployableNotifications_MiniTurretIcon.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.DeployableNotifications_MiniTurretIcon)
	self.id = "DeployableNotifications_MiniTurretIcon"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local DartIcon = LUI.UIImage.new(0, 0, 1, 59, 0, 0, 3.5, 55.5)
	DartIcon:setZRot(-360)
	DartIcon:setScale(0.9, 0.9)
	DartIcon:setImage(RegisterImage(0xF39CAC55C73AC03))
	DartIcon:setMaterial(LUI.UIImage.GetCachedMaterial(0xE992BD5A540E2D))
	DartIcon:setShaderVector(0, 0, 1, 0, 0)
	DartIcon:setShaderVector(1, 0, 0, 0, 0)
	DartIcon:setShaderVector(2, 0, 1, 0, 0)
	DartIcon:setShaderVector(3, 0, 0, 0, 0)
	DartIcon:setShaderVector(4, 0, 0, 0, 0)
	self:addElement(DartIcon)
	self.DartIcon = DartIcon
	self:mergeStateConditions({
		{
			stateName = "Destroyed",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "EnemyKilled",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local2 = self
	CoD.HUDUtility.MiniTurretPostLoad(self, f1_arg1)
	return self
end
CoD.DeployableNotifications_MiniTurretIcon.__resetProperties = function(f4_arg0)
	f4_arg0.DartIcon:completeAnimation()
	f4_arg0.DartIcon:setLeftRight(0, 0, 1, 59)
	f4_arg0.DartIcon:setTopBottom(0, 0, 3.5, 55.5)
	f4_arg0.DartIcon:setRGB(1, 1, 1)
	f4_arg0.DartIcon:setAlpha(1)
	f4_arg0.DartIcon:setZRot(-360)
	f4_arg0.DartIcon:setScale(0.9, 0.9)
end
CoD.DeployableNotifications_MiniTurretIcon.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			local f5_local0 = function(f6_arg0)
				f5_arg0.DartIcon:beginAnimation(500)
				f5_arg0.DartIcon:registerEventHandler("interrupted_keyframe", f5_arg0.clipInterrupted)
				f5_arg0.DartIcon:registerEventHandler("transition_complete_keyframe", f5_arg0.clipFinished)
			end
			f5_arg0.DartIcon:completeAnimation()
			f5_arg0.DartIcon:setLeftRight(0, 0, 1, 59)
			f5_arg0.DartIcon:setTopBottom(0, 0, 4, 56)
			f5_arg0.DartIcon:setScale(0.9, 0.9)
			f5_local0(f5_arg0.DartIcon)
		end,
	},
	Destroyed = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			local f7_local0 = function(f8_arg0)
				local f8_local0 = function(f9_arg0)
					local f9_local0 = function(f10_arg0)
						local f10_local0 = function(f11_arg0)
							local f11_local0 = function(f12_arg0)
								local f12_local0 = function(f13_arg0)
									local f13_local0 = function(f14_arg0)
										local f14_local0 = function(f15_arg0)
											local f15_local0 = function(f16_arg0)
												f16_arg0:beginAnimation(40)
												f16_arg0:setAlpha(0)
												f16_arg0:setScale(0, 0)
												f16_arg0:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
											end
											f15_arg0:beginAnimation(19)
											f15_arg0:setAlpha(0.33)
											f15_arg0:setScale(1.05, 1.05)
											f15_arg0:registerEventHandler("transition_complete_keyframe", f15_local0)
										end
										f14_arg0:beginAnimation(19)
										f14_arg0:setAlpha(0.17)
										f14_arg0:setScale(1.57, 1.57)
										f14_arg0:registerEventHandler("transition_complete_keyframe", f14_local0)
									end
									f13_arg0:beginAnimation(40)
									f13_arg0:setAlpha(0)
									f13_arg0:setScale(1.38, 1.38)
									f13_arg0:registerEventHandler("transition_complete_keyframe", f13_local0)
								end
								f12_arg0:beginAnimation(9)
								f12_arg0:setAlpha(0.8)
								f12_arg0:setScale(1, 1)
								f12_arg0:registerEventHandler("transition_complete_keyframe", f12_local0)
							end
							f11_arg0:beginAnimation(49)
							f11_arg0:setAlpha(1)
							f11_arg0:setScale(1.08, 1.08)
							f11_arg0:registerEventHandler("transition_complete_keyframe", f11_local0)
						end
						f10_arg0:beginAnimation(30)
						f10_arg0:setAlpha(0)
						f10_arg0:setScale(1.49, 1.49)
						f10_arg0:registerEventHandler("transition_complete_keyframe", f10_local0)
					end
					f9_arg0:beginAnimation(10)
					f9_arg0:setScale(1.73, 1.73)
					f9_arg0:registerEventHandler("transition_complete_keyframe", f9_local0)
				end
				f7_arg0.DartIcon:beginAnimation(30)
				f7_arg0.DartIcon:setScale(1.81, 1.81)
				f7_arg0.DartIcon:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.DartIcon:registerEventHandler("transition_complete_keyframe", f8_local0)
			end
			f7_arg0.DartIcon:completeAnimation()
			f7_arg0.DartIcon:setRGB(1, 1, 1)
			f7_arg0.DartIcon:setAlpha(1)
			f7_arg0.DartIcon:setScale(0.8, 0.8)
			f7_local0(f7_arg0.DartIcon)
		end,
	},
	EnemyKilled = {
		DefaultClip = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(1)
			local f17_local0 = function(f18_arg0)
				local f18_local0 = function(f19_arg0)
					local f19_local0 = function(f20_arg0)
						local f20_local0 = function(f21_arg0)
							f21_arg0:beginAnimation(79)
							f21_arg0:setTopBottom(0, 0, 4, 56)
							f21_arg0:registerEventHandler("transition_complete_keyframe", f17_arg0.clipFinished)
						end
						f20_arg0:beginAnimation(80)
						f20_arg0:setTopBottom(0, 0, -6, 46)
						f20_arg0:setZRot(-360)
						f20_arg0:registerEventHandler("transition_complete_keyframe", f20_local0)
					end
					f19_arg0:beginAnimation(70)
					f19_arg0:registerEventHandler("transition_complete_keyframe", f19_local0)
				end
				f17_arg0.DartIcon:beginAnimation(160)
				f17_arg0.DartIcon:setTopBottom(0, 0, -36, 16)
				f17_arg0.DartIcon:setZRot(-180)
				f17_arg0.DartIcon:registerEventHandler("interrupted_keyframe", f17_arg0.clipInterrupted)
				f17_arg0.DartIcon:registerEventHandler("transition_complete_keyframe", f18_local0)
			end
			f17_arg0.DartIcon:completeAnimation()
			f17_arg0.DartIcon:setLeftRight(0, 0, 1, 59)
			f17_arg0.DartIcon:setTopBottom(0, 0, 4, 56)
			f17_arg0.DartIcon:setZRot(0)
			f17_arg0.DartIcon:setScale(0.9, 0.9)
			f17_local0(f17_arg0.DartIcon)
		end,
	},
}
