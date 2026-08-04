CoD.CallingCards_Asset_swordstab = InheritFrom(LUI.UIElement)
CoD.CallingCards_Asset_swordstab.__defaultWidth = 960
CoD.CallingCards_Asset_swordstab.__defaultHeight = 240
CoD.CallingCards_Asset_swordstab.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CallingCards_Asset_swordstab)
	self.id = "CallingCards_Asset_swordstab"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local bandanna = LUI.UIImage.new(0, 0, 762, 922, 0, 0, 13, 133)
	bandanna:setImage(RegisterImage("uie_ui_icon_callingcards_operations_humiliation_unforgiving_bandanna"))
	bandanna:setMaterial(LUI.UIImage.GetCachedMaterial("uie_flipbook"))
	bandanna:setShaderVector(0, 0, 3, 0, 0)
	bandanna:setShaderVector(1, 9, 0, 0, 0)
	self:addElement(bandanna)
	self.bandanna = bandanna
	local gang1 = LUI.UIImage.new(0, 0, 0, 960, 0, 0, 0, 240)
	gang1:setAlpha(0)
	gang1:setImage(RegisterImage("uie_ui_icon_callingcards_operations_humiliation_unforgiving_gang1"))
	self:addElement(gang1)
	self.gang1 = gang1
	local gang2 = LUI.UIImage.new(0, 0, 0, 960, 0, 0, 0, 240)
	gang2:setImage(RegisterImage("uie_ui_icon_callingcards_operations_humiliation_unforgiving_gang2"))
	self:addElement(gang2)
	self.gang2 = gang2
	local gang3 = LUI.UIImage.new(0, 0, 0, 960, 0, 0, 0, 240)
	gang3:setAlpha(0)
	gang3:setImage(RegisterImage("uie_ui_icon_callingcards_operations_humiliation_unforgiving_gang3"))
	self:addElement(gang3)
	self.gang3 = gang3
	local BloodDrip = LUI.UIImage.new(0, 0, 473, 585, 0, 0, 163, 243)
	BloodDrip:setImage(RegisterImage("uie_ui_icon_callingcards_operations_humiliation_unforgiving_blooddrip"))
	BloodDrip:setMaterial(LUI.UIImage.GetCachedMaterial("uie_flipbook"))
	BloodDrip:setShaderVector(0, 0, 5, 0, 0)
	BloodDrip:setShaderVector(1, 10, 0, 0, 0)
	self:addElement(BloodDrip)
	self.BloodDrip = BloodDrip
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CallingCards_Asset_swordstab.__resetProperties = function(f2_arg0)
	f2_arg0.gang1:completeAnimation()
	f2_arg0.gang2:completeAnimation()
	f2_arg0.BloodDrip:completeAnimation()
	f2_arg0.gang3:completeAnimation()
	f2_arg0.gang1:setAlpha(0)
	f2_arg0.gang2:setAlpha(1)
	f2_arg0.BloodDrip:setAlpha(1)
	f2_arg0.gang3:setAlpha(0)
end
CoD.CallingCards_Asset_swordstab.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(4)
			local f3_local0 = function(f4_arg0)
				local f4_local0 = function(f5_arg0)
					f5_arg0:beginAnimation(10)
					f5_arg0:setAlpha(0)
					f5_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
				end
				f3_arg0.gang1:beginAnimation(390)
				f3_arg0.gang1:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.gang1:registerEventHandler("transition_complete_keyframe", f4_local0)
			end
			f3_arg0.gang1:completeAnimation()
			f3_arg0.gang1:setAlpha(1)
			f3_local0(f3_arg0.gang1)
			local f3_local1 = function(f6_arg0)
				local f6_local0 = function(f7_arg0)
					local f7_local0 = function(f8_arg0)
						local f8_local0 = function(f9_arg0)
							f9_arg0:beginAnimation(9)
							f9_arg0:setAlpha(0)
							f9_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
						end
						f8_arg0:beginAnimation(220)
						f8_arg0:registerEventHandler("transition_complete_keyframe", f8_local0)
					end
					f7_arg0:beginAnimation(10)
					f7_arg0:setAlpha(1)
					f7_arg0:registerEventHandler("transition_complete_keyframe", f7_local0)
				end
				f3_arg0.gang2:beginAnimation(390)
				f3_arg0.gang2:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.gang2:registerEventHandler("transition_complete_keyframe", f6_local0)
			end
			f3_arg0.gang2:completeAnimation()
			f3_arg0.gang2:setAlpha(0)
			f3_local1(f3_arg0.gang2)
			local f3_local2 = function(f10_arg0)
				local f10_local0 = function(f11_arg0)
					local f11_local0 = function(f12_arg0)
						f12_arg0:beginAnimation(1370)
						f12_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
					end
					f11_arg0:beginAnimation(9)
					f11_arg0:setAlpha(1)
					f11_arg0:registerEventHandler("transition_complete_keyframe", f11_local0)
				end
				f3_arg0.gang3:beginAnimation(620)
				f3_arg0.gang3:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.gang3:registerEventHandler("transition_complete_keyframe", f10_local0)
			end
			f3_arg0.gang3:completeAnimation()
			f3_arg0.gang3:setAlpha(0)
			f3_local2(f3_arg0.gang3)
			local f3_local3 = function(f13_arg0)
				local f13_local0 = function(f14_arg0)
					f14_arg0:beginAnimation(9)
					f14_arg0:setAlpha(1)
					f14_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
				end
				f3_arg0.BloodDrip:beginAnimation(620)
				f3_arg0.BloodDrip:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.BloodDrip:registerEventHandler("transition_complete_keyframe", f13_local0)
			end
			f3_arg0.BloodDrip:completeAnimation()
			f3_arg0.BloodDrip:setAlpha(0)
			f3_local3(f3_arg0.BloodDrip)
			f3_arg0.nextClip = "DefaultClip"
		end,
	},
}
