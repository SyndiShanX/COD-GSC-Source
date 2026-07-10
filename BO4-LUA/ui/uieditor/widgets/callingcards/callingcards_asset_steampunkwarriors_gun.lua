require("x64:b169fe8f8ecf71e")
require("x64:e3ca6e804d6d29c")
CoD.CallingCards_Asset_steampunkwarriors_gun = InheritFrom(LUI.UIElement)
CoD.CallingCards_Asset_steampunkwarriors_gun.__defaultWidth = 10
CoD.CallingCards_Asset_steampunkwarriors_gun.__defaultHeight = 10
CoD.CallingCards_Asset_steampunkwarriors_gun.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CallingCards_Asset_steampunkwarriors_gun)
	self.id = "CallingCards_Asset_steampunkwarriors_gun"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local gun = LUI.UIImage.new(0, 0, -176.5, 23.5, 0, 0, -141, 27)
	gun:setImage(RegisterImage(0x9D40B121013CB22))
	self:addElement(gun)
	self.gun = gun
	local gunsmoke = CoD.CallingCards_Asset_steampunkwarriors_gunsmoke.new(f1_arg0, f1_arg1, 0, 0, -159.5, -149.5, 0, 0, -106, -96)
	self:addElement(gunsmoke)
	self.gunsmoke = gunsmoke
	local gunshot = CoD.CallingCards_Asset_steampunkwarriors_gunshoteffect.new(f1_arg0, f1_arg1, 0, 0, -159.5, -149.5, 0, 0, -106, -96)
	gunshot:setZRot(-10)
	self:addElement(gunshot)
	self.gunshot = gunshot
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CallingCards_Asset_steampunkwarriors_gun.__resetProperties = function(f2_arg0)
	f2_arg0.gunshot:completeAnimation()
	f2_arg0.gunsmoke:completeAnimation()
	f2_arg0.gunshot:setAlpha(1)
	f2_arg0.gunshot:setZRot(-10)
	f2_arg0.gunshot:setScale(1, 1)
	f2_arg0.gunsmoke:setAlpha(1)
	f2_arg0.gunsmoke:setZRot(0)
	f2_arg0.gunsmoke:setScale(1, 1)
end
CoD.CallingCards_Asset_steampunkwarriors_gun.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(2)
			local f3_local0 = function(f4_arg0)
				local f4_local0 = function(f5_arg0)
					local f5_local0 = function(f6_arg0)
						f6_arg0:beginAnimation(1000)
						f6_arg0:setAlpha(0)
						f6_arg0:setZRot(-15)
						f6_arg0:setScale(1.5, 1)
						f6_arg0:registerEventHandler("transition_complete_keyframe", function(element, event)
							element:playClip("DefaultClip")
							f3_arg0.clipFinished(element, event)
						end)
					end
					f5_arg0:beginAnimation(870)
					f5_arg0:setAlpha(1)
					f5_arg0:setScale(1, 1)
					f5_arg0:registerEventHandler("transition_complete_keyframe", f5_local0)
				end
				f3_arg0.gunsmoke:playClip("DefaultClip")
				f3_arg0.gunsmoke:beginAnimation(1130)
				f3_arg0.gunsmoke:setScale(1, 0.5)
				f3_arg0.gunsmoke:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.gunsmoke:registerEventHandler("transition_complete_keyframe", f4_local0)
			end
			f3_arg0.gunsmoke:completeAnimation()
			f3_arg0.gunsmoke:setAlpha(0)
			f3_arg0.gunsmoke:setZRot(-12)
			f3_arg0.gunsmoke:setScale(0.93, 1)
			f3_local0(f3_arg0.gunsmoke)
			local f3_local1 = function(f8_arg0)
				local f8_local0 = function(f9_arg0)
					local f9_local0 = function(f10_arg0)
						local f10_local0 = function(f11_arg0)
							local f11_local0 = function(f12_arg0)
								f12_arg0:beginAnimation(1260)
								f12_arg0:registerEventHandler("transition_complete_keyframe", function(element, event)
									element:playClip("DefaultClip")
									f3_arg0.clipFinished(element, event)
								end)
							end
							f11_arg0:beginAnimation(9)
							f11_arg0:registerEventHandler("transition_complete_keyframe", f11_local0)
						end
						f10_arg0:beginAnimation(659)
						f10_arg0:setAlpha(0)
						f10_arg0:registerEventHandler("transition_complete_keyframe", f10_local0)
					end
					f9_arg0:beginAnimation(70)
					f9_arg0:setAlpha(1)
					f9_arg0:setScale(1, 1)
					f9_arg0:registerEventHandler("transition_complete_keyframe", f9_local0)
				end
				f3_arg0.gunshot:playClip("DefaultClip")
				f3_arg0.gunshot:beginAnimation(1000)
				f3_arg0.gunshot:setScale(0.9, 0.9)
				f3_arg0.gunshot:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.gunshot:registerEventHandler("transition_complete_keyframe", f8_local0)
			end
			f3_arg0.gunshot:completeAnimation()
			f3_arg0.gunshot:setAlpha(0)
			f3_arg0.gunshot:setZRot(-10)
			f3_arg0.gunshot:setScale(0.8, 0.8)
			f3_local1(f3_arg0.gunshot)
		end,
	},
}
CoD.CallingCards_Asset_steampunkwarriors_gun.__onClose = function(f14_arg0)
	f14_arg0.gunsmoke:close()
	f14_arg0.gunshot:close()
end
