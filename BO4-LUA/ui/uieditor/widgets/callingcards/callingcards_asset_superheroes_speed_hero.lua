require("x64:a9f890241f5b6c3")
CoD.CallingCards_Asset_superheroes_speed_hero = InheritFrom(LUI.UIElement)
CoD.CallingCards_Asset_superheroes_speed_hero.__defaultWidth = 384
CoD.CallingCards_Asset_superheroes_speed_hero.__defaultHeight = 240
CoD.CallingCards_Asset_superheroes_speed_hero.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CallingCards_Asset_superheroes_speed_hero)
	self.id = "CallingCards_Asset_superheroes_speed_hero"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local rightarm = CoD.CallingCards_Asset_superheroes_speed_rightarm.new(f1_arg0, f1_arg1, 0, 0, 73.5, 83.5, 0, 0, 156, 166)
	self:addElement(rightarm)
	self.rightarm = rightarm
	local hero = LUI.UIImage.new(0, 0, 0, 384, 0, 0, 0, 240)
	hero:setImage(RegisterImage(@"hash_515FA951A24AE220"))
	self:addElement(hero)
	self.hero = hero
	local leftarm = LUI.UIImage.new(0, 0, 200, 384, 0, 0, 16.5, 96.5)
	leftarm:setImage(RegisterImage(@"hash_6E8474EBB573E401"))
	self:addElement(leftarm)
	self.leftarm = leftarm
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CallingCards_Asset_superheroes_speed_hero.__resetProperties = function(f2_arg0)
	f2_arg0.rightarm:completeAnimation()
	f2_arg0.leftarm:completeAnimation()
	f2_arg0.rightarm:setZRot(0)
	f2_arg0.leftarm:setTopBottom(0, 0, 16.5, 96.5)
end
CoD.CallingCards_Asset_superheroes_speed_hero.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(2)
			local f3_local0 = function(f4_arg0)
				local f4_local0 = function(f5_arg0)
					local f5_local0 = function(f6_arg0)
						local f6_local0 = function(f7_arg0)
							f7_arg0:beginAnimation(750, Enum[@"luitween"][@"luitween_ease_out"])
							f7_arg0:setZRot(10)
							f7_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
						end
						f6_arg0:beginAnimation(750, Enum[@"luitween"][@"luitween_ease_out"])
						f6_arg0:setZRot(-28)
						f6_arg0:registerEventHandler("transition_complete_keyframe", f6_local0)
					end
					f5_arg0:beginAnimation(800, Enum[@"luitween"][@"luitween_ease_out"])
					f5_arg0:setZRot(10)
					f5_arg0:registerEventHandler("transition_complete_keyframe", f5_local0)
				end
				f3_arg0.rightarm:beginAnimation(700, Enum[@"luitween"][@"luitween_ease_out"])
				f3_arg0.rightarm:setZRot(-28)
				f3_arg0.rightarm:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.rightarm:registerEventHandler("transition_complete_keyframe", f4_local0)
			end
			f3_arg0.rightarm:completeAnimation()
			f3_arg0.rightarm:setZRot(10)
			f3_local0(f3_arg0.rightarm)
			local f3_local1 = function(f8_arg0)
				local f8_local0 = function(f9_arg0)
					local f9_local0 = function(f10_arg0)
						local f10_local0 = function(f11_arg0)
							f11_arg0:beginAnimation(750, Enum[@"luitween"][@"luitween_ease_out"])
							f11_arg0:setTopBottom(0, 0, 12.5, 92.5)
							f11_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
						end
						f10_arg0:beginAnimation(750, Enum[@"luitween"][@"luitween_ease_out"])
						f10_arg0:setTopBottom(0, 0, 57.5, 137.5)
						f10_arg0:registerEventHandler("transition_complete_keyframe", f10_local0)
					end
					f9_arg0:beginAnimation(800, Enum[@"luitween"][@"luitween_ease_out"])
					f9_arg0:setTopBottom(0, 0, 12.5, 92.5)
					f9_arg0:registerEventHandler("transition_complete_keyframe", f9_local0)
				end
				f3_arg0.leftarm:beginAnimation(700, Enum[@"luitween"][@"luitween_ease_out"])
				f3_arg0.leftarm:setTopBottom(0, 0, 57.5, 137.5)
				f3_arg0.leftarm:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.leftarm:registerEventHandler("transition_complete_keyframe", f8_local0)
			end
			f3_arg0.leftarm:completeAnimation()
			f3_arg0.leftarm:setTopBottom(0, 0, 12.5, 92.5)
			f3_local1(f3_arg0.leftarm)
			f3_arg0.nextClip = "DefaultClip"
		end,
	},
}
CoD.CallingCards_Asset_superheroes_speed_hero.__onClose = function(f12_arg0)
	f12_arg0.rightarm:close()
end
