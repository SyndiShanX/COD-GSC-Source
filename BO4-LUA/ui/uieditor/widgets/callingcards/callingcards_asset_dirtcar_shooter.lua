CoD.CallingCards_Asset_dirtcar_shooter = InheritFrom(LUI.UIElement)
CoD.CallingCards_Asset_dirtcar_shooter.__defaultWidth = 960
CoD.CallingCards_Asset_dirtcar_shooter.__defaultHeight = 250
CoD.CallingCards_Asset_dirtcar_shooter.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CallingCards_Asset_dirtcar_shooter)
	self.id = "CallingCards_Asset_dirtcar_shooter"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local car = LUI.UIImage.new(0, 0, 0, 970, 0, 0, 0, 250)
	car:setImage(RegisterImage(@"uie_dirt_car"))
	self:addElement(car)
	self.car = car
	local dude = LUI.UIImage.new(0, 0, 441, 659, 0, 0, 8, 218)
	dude:setImage(RegisterImage(@"uie_dude_shoots"))
	self:addElement(dude)
	self.dude = dude
	local dude2 = LUI.UIImage.new(0, 0, 441, 659, 0, 0, 8, 218)
	dude2:setImage(RegisterImage(@"uie_dude_shoots_fire"))
	self:addElement(dude2)
	self.dude2 = dude2
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CallingCards_Asset_dirtcar_shooter.__resetProperties = function(f2_arg0)
	f2_arg0.car:completeAnimation()
	f2_arg0.dude:completeAnimation()
	f2_arg0.dude2:completeAnimation()
	f2_arg0.car:setAlpha(1)
	f2_arg0.dude:setAlpha(1)
	f2_arg0.dude2:setAlpha(1)
end
CoD.CallingCards_Asset_dirtcar_shooter.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(3)
			f3_arg0.car:completeAnimation()
			f3_arg0.car:setAlpha(1)
			f3_arg0.clipFinished(f3_arg0.car)
			local f3_local0 = function(f4_arg0)
				f3_arg0.dude:beginAnimation(180)
				f3_arg0.dude:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.dude:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
			end
			f3_arg0.dude:completeAnimation()
			f3_arg0.dude:setAlpha(1)
			f3_local0(f3_arg0.dude)
			local f3_local1 = function(f5_arg0)
				local f5_local0 = function(f6_arg0)
					local f6_local0 = function(f7_arg0)
						local f7_local0 = function(f8_arg0)
							f8_arg0:beginAnimation(90)
							f8_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
						end
						f7_arg0:beginAnimation(30)
						f7_arg0:setAlpha(0)
						f7_arg0:registerEventHandler("transition_complete_keyframe", f7_local0)
					end
					f6_arg0:beginAnimation(29)
					f6_arg0:registerEventHandler("transition_complete_keyframe", f6_local0)
				end
				f3_arg0.dude2:beginAnimation(100)
				f3_arg0.dude2:setAlpha(1)
				f3_arg0.dude2:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.dude2:registerEventHandler("transition_complete_keyframe", f5_local0)
			end
			f3_arg0.dude2:completeAnimation()
			f3_arg0.dude2:setAlpha(0)
			f3_local1(f3_arg0.dude2)
			f3_arg0.nextClip = "DefaultClip"
		end,
	},
}
