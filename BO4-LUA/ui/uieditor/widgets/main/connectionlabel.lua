CoD.ConnectionLabel = InheritFrom(LUI.UIElement)
CoD.ConnectionLabel.__defaultWidth = 1920
CoD.ConnectionLabel.__defaultHeight = 1080
CoD.ConnectionLabel.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ConnectionLabel)
	self.id = "ConnectionLabel"
	self.soundSet = "FrontendMain"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local lblConnecting = LUI.UIText.new(0, 0, 160, 960, 1, 1, -134, -104)
	lblConnecting:setRGB(0.26, 0.25, 0.25)
	lblConnecting:setText(LocalizeToUpperString(@"menu/connecting_dw"))
	lblConnecting:setTTF("ttmussels_demibold")
	lblConnecting:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_171E049B161CD00A"))
	lblConnecting:setLetterSpacing(6)
	lblConnecting:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	lblConnecting:setAlignment(Enum[@"luialignment"][@"lui_alignment_bottom"])
	self:addElement(lblConnecting)
	self.lblConnecting = lblConnecting
	local lblSubStatus = LUI.UIText.new(0, 0, 160, 960, 1, 1, -92, -62)
	lblSubStatus:setRGB(0.26, 0.25, 0.25)
	lblSubStatus:setAlpha(0)
	lblSubStatus:setText(LocalizeToUpperString(@"menu/checking_files"))
	lblSubStatus:setTTF("ttmussels_demibold")
	lblSubStatus:setLetterSpacing(6)
	lblSubStatus:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	lblSubStatus:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(lblSubStatus)
	self.lblSubStatus = lblSubStatus
	self:mergeStateConditions({
		{
			stateName = "DefaultStatePC",
			condition = function(menu, element, event)
				return IsPC()
			end,
		},
	})
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ConnectionLabel.__resetProperties = function(f3_arg0)
	f3_arg0.lblConnecting:completeAnimation()
	f3_arg0.lblSubStatus:completeAnimation()
	f3_arg0.lblConnecting:setRGB(0.26, 0.25, 0.25)
	f3_arg0.lblConnecting:setAlpha(1)
	f3_arg0.lblSubStatus:setRGB(0.26, 0.25, 0.25)
	f3_arg0.lblSubStatus:setAlpha(0)
end
CoD.ConnectionLabel.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(1)
			local f4_local0 = function(f5_arg0)
				local f5_local0 = function(f6_arg0)
					f6_arg0:beginAnimation(400)
					f6_arg0:setAlpha(1)
					f6_arg0:registerEventHandler("transition_complete_keyframe", f4_arg0.clipFinished)
				end
				f4_arg0.lblConnecting:beginAnimation(800)
				f4_arg0.lblConnecting:setAlpha(0.25)
				f4_arg0.lblConnecting:registerEventHandler("interrupted_keyframe", f4_arg0.clipInterrupted)
				f4_arg0.lblConnecting:registerEventHandler("transition_complete_keyframe", f5_local0)
			end
			f4_arg0.lblConnecting:completeAnimation()
			f4_arg0.lblConnecting:setAlpha(1)
			f4_local0(f4_arg0.lblConnecting)
			f4_arg0.nextClip = "DefaultClip"
		end,
		ShowStatus = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(2)
			local f7_local0 = function(f8_arg0)
				local f8_local0 = function(f9_arg0)
					f9_arg0:beginAnimation(400)
					f9_arg0:setAlpha(1)
					f9_arg0:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
				end
				f7_arg0.lblConnecting:beginAnimation(800)
				f7_arg0.lblConnecting:setAlpha(0.25)
				f7_arg0.lblConnecting:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.lblConnecting:registerEventHandler("transition_complete_keyframe", f8_local0)
			end
			f7_arg0.lblConnecting:completeAnimation()
			f7_arg0.lblConnecting:setAlpha(1)
			f7_local0(f7_arg0.lblConnecting)
			local f7_local1 = function(f10_arg0)
				local f10_local0 = function(f11_arg0)
					f11_arg0:beginAnimation(400)
					f11_arg0:setAlpha(1)
					f11_arg0:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
				end
				f7_arg0.lblSubStatus:beginAnimation(800)
				f7_arg0.lblSubStatus:setAlpha(0.25)
				f7_arg0.lblSubStatus:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.lblSubStatus:registerEventHandler("transition_complete_keyframe", f10_local0)
			end
			f7_arg0.lblSubStatus:completeAnimation()
			f7_arg0.lblSubStatus:setAlpha(1)
			f7_local1(f7_arg0.lblSubStatus)
			f7_arg0.nextClip = "ShowStatus"
		end,
	},
	DefaultStatePC = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(1)
			local f12_local0 = function(f13_arg0)
				local f13_local0 = function(f14_arg0)
					f14_arg0:beginAnimation(400)
					f14_arg0:setAlpha(1)
					f14_arg0:registerEventHandler("transition_complete_keyframe", f12_arg0.clipFinished)
				end
				f12_arg0.lblConnecting:beginAnimation(800)
				f12_arg0.lblConnecting:setAlpha(0.6)
				f12_arg0.lblConnecting:registerEventHandler("interrupted_keyframe", f12_arg0.clipInterrupted)
				f12_arg0.lblConnecting:registerEventHandler("transition_complete_keyframe", f13_local0)
			end
			f12_arg0.lblConnecting:completeAnimation()
			f12_arg0.lblConnecting:setRGB(0.95, 0.95, 0.95)
			f12_arg0.lblConnecting:setAlpha(1)
			f12_local0(f12_arg0.lblConnecting)
			f12_arg0.nextClip = "DefaultClip"
		end,
		ShowStatus = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(2)
			local f15_local0 = function(f16_arg0)
				local f16_local0 = function(f17_arg0)
					f17_arg0:beginAnimation(400)
					f17_arg0:setAlpha(1)
					f17_arg0:registerEventHandler("transition_complete_keyframe", f15_arg0.clipFinished)
				end
				f15_arg0.lblConnecting:beginAnimation(800)
				f15_arg0.lblConnecting:setAlpha(0.6)
				f15_arg0.lblConnecting:registerEventHandler("interrupted_keyframe", f15_arg0.clipInterrupted)
				f15_arg0.lblConnecting:registerEventHandler("transition_complete_keyframe", f16_local0)
			end
			f15_arg0.lblConnecting:completeAnimation()
			f15_arg0.lblConnecting:setRGB(0.95, 0.95, 0.95)
			f15_arg0.lblConnecting:setAlpha(1)
			f15_local0(f15_arg0.lblConnecting)
			local f15_local1 = function(f18_arg0)
				local f18_local0 = function(f19_arg0)
					f19_arg0:beginAnimation(400)
					f19_arg0:setAlpha(1)
					f19_arg0:registerEventHandler("transition_complete_keyframe", f15_arg0.clipFinished)
				end
				f15_arg0.lblSubStatus:beginAnimation(800)
				f15_arg0.lblSubStatus:setAlpha(0.6)
				f15_arg0.lblSubStatus:registerEventHandler("interrupted_keyframe", f15_arg0.clipInterrupted)
				f15_arg0.lblSubStatus:registerEventHandler("transition_complete_keyframe", f18_local0)
			end
			f15_arg0.lblSubStatus:completeAnimation()
			f15_arg0.lblSubStatus:setRGB(0.95, 0.95, 0.95)
			f15_arg0.lblSubStatus:setAlpha(1)
			f15_local1(f15_arg0.lblSubStatus)
			f15_arg0.nextClip = "ShowStatus"
		end,
	},
}
if not CoD.isPC then
	CoD.ConnectionLabel.__clipsPerState.DefaultStatePC.DefaultClip = nil
	CoD.ConnectionLabel.__clipsPerState.DefaultStatePC.ShowStatus = nil
end
