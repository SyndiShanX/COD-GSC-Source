require("ui/uieditor/widgets/callingcards/callingcards_asset_grunt_radio_container")
CoD.CallingCards_Asset_grunt_radio = InheritFrom(LUI.UIElement)
CoD.CallingCards_Asset_grunt_radio.__defaultWidth = 546
CoD.CallingCards_Asset_grunt_radio.__defaultHeight = 240
CoD.CallingCards_Asset_grunt_radio.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CallingCards_Asset_grunt_radio)
	self.id = "CallingCards_Asset_grunt_radio"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local radioFirefight = CoD.CallingCards_Asset_grunt_radio_container.new(f1_arg0, f1_arg1, 0, 0, 320, 536, 0, 0, 39, 232)
	self:addElement(radioFirefight)
	self.radioFirefight = radioFirefight
	local grunt = LUI.UIImage.new(0, 0, 0, 392, 0, 0, 0.5, 240.5)
	grunt:setScale(1.02, 1.02)
	grunt:setImage(RegisterImage("uie_grunt_body"))
	self:addElement(grunt)
	self.grunt = grunt
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CallingCards_Asset_grunt_radio.__resetProperties = function(f2_arg0)
	f2_arg0.grunt:completeAnimation()
	f2_arg0.radioFirefight:completeAnimation()
	f2_arg0.grunt:setTopBottom(0, 0, 0.5, 240.5)
	f2_arg0.radioFirefight:setTopBottom(0, 0, 39, 232)
end
CoD.CallingCards_Asset_grunt_radio.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(2)
			local f3_local0 = function(f4_arg0)
				local f4_local0 = function(f5_arg0)
					local f5_local0 = function(f6_arg0)
						local f6_local0 = function(f7_arg0)
							local f7_local0 = function(f8_arg0)
								f8_arg0:beginAnimation(410)
								f8_arg0:setTopBottom(0, 0, 39, 232)
								f8_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
							end
							f7_arg0:beginAnimation(1619)
							f7_arg0:registerEventHandler("transition_complete_keyframe", f7_local0)
						end
						f6_arg0:beginAnimation(340)
						f6_arg0:setTopBottom(0, 0, 44, 237)
						f6_arg0:registerEventHandler("transition_complete_keyframe", f6_local0)
					end
					f5_arg0:beginAnimation(329)
					f5_arg0:setTopBottom(0, 0, 39, 232)
					f5_arg0:registerEventHandler("transition_complete_keyframe", f5_local0)
				end
				f3_arg0.radioFirefight:beginAnimation(300)
				f3_arg0.radioFirefight:setTopBottom(0, 0, 44, 237)
				f3_arg0.radioFirefight:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.radioFirefight:registerEventHandler("transition_complete_keyframe", f4_local0)
			end
			f3_arg0.radioFirefight:completeAnimation()
			f3_arg0.radioFirefight:setTopBottom(0, 0, 39, 232)
			f3_local0(f3_arg0.radioFirefight)
			local f3_local1 = function(f9_arg0)
				local f9_local0 = function(f10_arg0)
					local f10_local0 = function(f11_arg0)
						f11_arg0:beginAnimation(2370)
						f11_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
					end
					f10_arg0:beginAnimation(329)
					f10_arg0:setTopBottom(0, 0, 2, 242)
					f10_arg0:registerEventHandler("transition_complete_keyframe", f10_local0)
				end
				f3_arg0.grunt:beginAnimation(300)
				f3_arg0.grunt:setTopBottom(0, 0, -2, 238)
				f3_arg0.grunt:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.grunt:registerEventHandler("transition_complete_keyframe", f9_local0)
			end
			f3_arg0.grunt:completeAnimation()
			f3_arg0.grunt:setTopBottom(0, 0, 2, 242)
			f3_local1(f3_arg0.grunt)
			f3_arg0.nextClip = "DefaultClip"
		end,
	},
}
CoD.CallingCards_Asset_grunt_radio.__onClose = function(f12_arg0)
	f12_arg0.radioFirefight:close()
end
