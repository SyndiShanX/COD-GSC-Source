require("ui/uieditor/widgets/callingcards/callingcards_asset_astromonkey")
CoD.callingcards_signature_weapon_master = InheritFrom(LUI.UIElement)
CoD.callingcards_signature_weapon_master.__defaultWidth = 960
CoD.callingcards_signature_weapon_master.__defaultHeight = 240
CoD.callingcards_signature_weapon_master.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.callingcards_signature_weapon_master)
	self.id = "CallingCards_Signature_Weapon_Master"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local bg = LUI.UIImage.new(0, 0, 0, 960, 0, 0, 0, 240)
	bg:setImage(RegisterImage("uie_ui_icon_callingcards_signature_weapon_master_bg"))
	self:addElement(bg)
	self.bg = bg
	local monkeyShines = CoD.CallingCards_Asset_AstroMonkey.new(f1_arg0, f1_arg1, 0, 0, 251, 619, 0, 0, -53, 340)
	self:addElement(monkeyShines)
	self.monkeyShines = monkeyShines
	local bannana01 = LUI.UIImage.new(0, 0, 607, 687, 0, 0, 64.5, 160.5)
	bannana01:setImage(RegisterImage("uie_ui_icon_callingcards_signature_weapon_master_bannana_01"))
	self:addElement(bannana01)
	self.bannana01 = bannana01
	local bannana02 = LUI.UIImage.new(0, 0, 258.5, 354.5, 0, 0, -11, 77)
	bannana02:setImage(RegisterImage("uie_ui_icon_callingcards_signature_weapon_master_bannana_02"))
	self:addElement(bannana02)
	self.bannana02 = bannana02
	local bannana03 = LUI.UIImage.new(0, 0, 149, 261, 0, 0, 59, 155)
	bannana03:setImage(RegisterImage("uie_ui_icon_callingcards_signature_weapon_master_bannana_03"))
	self:addElement(bannana03)
	self.bannana03 = bannana03
	local bannana04 = LUI.UIImage.new(0, 0, 192.5, 256.5, 0, 0, 161, 225)
	bannana04:setImage(RegisterImage("uie_ui_icon_callingcards_signature_weapon_master_bannana_04"))
	self:addElement(bannana04)
	self.bannana04 = bannana04
	local bannana05 = LUI.UIImage.new(0, 0, 66.5, 138.5, 0, 0, 49, 121)
	bannana05:setImage(RegisterImage("uie_ui_icon_callingcards_signature_weapon_master_bannana_05"))
	self:addElement(bannana05)
	self.bannana05 = bannana05
	local bannana06 = LUI.UIImage.new(0, 0, 95, 151, 0, 0, 153, 209)
	bannana06:setImage(RegisterImage("uie_ui_icon_callingcards_signature_weapon_master_bannana_06"))
	self:addElement(bannana06)
	self.bannana06 = bannana06
	local cropper = LUI.UIImage.new(0, 0, -32, 992, 0, 0, -392, 632)
	cropper:setAlpha(0)
	cropper:setImage(RegisterImage("uie_stage_crop_prop"))
	self:addElement(cropper)
	self.cropper = cropper
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.callingcards_signature_weapon_master.__resetProperties = function(f2_arg0)
	f2_arg0.monkeyShines:completeAnimation()
	f2_arg0.bannana01:completeAnimation()
	f2_arg0.bannana02:completeAnimation()
	f2_arg0.bannana03:completeAnimation()
	f2_arg0.bannana04:completeAnimation()
	f2_arg0.bannana05:completeAnimation()
	f2_arg0.bannana06:completeAnimation()
	f2_arg0.monkeyShines:setTopBottom(0, 0, -53, 340)
	f2_arg0.bannana01:setTopBottom(0, 0, 64.5, 160.5)
	f2_arg0.bannana02:setLeftRight(0, 0, 258.5, 354.5)
	f2_arg0.bannana02:setTopBottom(0, 0, -11, 77)
	f2_arg0.bannana03:setTopBottom(0, 0, 59, 155)
	f2_arg0.bannana04:setTopBottom(0, 0, 161, 225)
	f2_arg0.bannana05:setTopBottom(0, 0, 49, 121)
	f2_arg0.bannana06:setTopBottom(0, 0, 153, 209)
end
CoD.callingcards_signature_weapon_master.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(7)
			local f3_local0 = function(f4_arg0)
				local f4_local0 = function(f5_arg0)
					f5_arg0:beginAnimation(2530)
					f5_arg0:setTopBottom(0, 0, -35, 358)
					f5_arg0:registerEventHandler("transition_complete_keyframe", function(element, event)
						element:playClip("DefaultClip")
						f3_arg0.clipFinished(element, event)
					end)
				end
				f3_arg0.monkeyShines:playClip("DefaultClip")
				f3_arg0.monkeyShines:beginAnimation(2480)
				f3_arg0.monkeyShines:setTopBottom(0, 0, -22, 371)
				f3_arg0.monkeyShines:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.monkeyShines:registerEventHandler("transition_complete_keyframe", f4_local0)
			end
			f3_arg0.monkeyShines:completeAnimation()
			f3_arg0.monkeyShines:setTopBottom(0, 0, -35, 358)
			f3_local0(f3_arg0.monkeyShines)
			local f3_local1 = function(f7_arg0)
				local f7_local0 = function(f8_arg0)
					local f8_local0 = function(f9_arg0)
						local f9_local0 = function(f10_arg0)
							f10_arg0:beginAnimation(1010)
							f10_arg0:setTopBottom(0, 0, 64.5, 160.5)
							f10_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
						end
						f9_arg0:beginAnimation(1500)
						f9_arg0:setTopBottom(0, 0, 85.5, 181.5)
						f9_arg0:registerEventHandler("transition_complete_keyframe", f9_local0)
					end
					f8_arg0:beginAnimation(1500)
					f8_arg0:setTopBottom(0, 0, 64.5, 160.5)
					f8_arg0:registerEventHandler("transition_complete_keyframe", f8_local0)
				end
				f3_arg0.bannana01:beginAnimation(1000)
				f3_arg0.bannana01:setTopBottom(0, 0, 85.5, 181.5)
				f3_arg0.bannana01:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.bannana01:registerEventHandler("transition_complete_keyframe", f7_local0)
			end
			f3_arg0.bannana01:completeAnimation()
			f3_arg0.bannana01:setTopBottom(0, 0, 64.5, 160.5)
			f3_local1(f3_arg0.bannana01)
			local f3_local2 = function(f11_arg0)
				local f11_local0 = function(f12_arg0)
					local f12_local0 = function(f13_arg0)
						local f13_local0 = function(f14_arg0)
							f14_arg0:beginAnimation(1470)
							f14_arg0:setTopBottom(0, 0, -11, 77)
							f14_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
						end
						f13_arg0:beginAnimation(970)
						f13_arg0:setTopBottom(0, 0, -22, 66)
						f13_arg0:registerEventHandler("transition_complete_keyframe", f13_local0)
					end
					f12_arg0:beginAnimation(1569)
					f12_arg0:setTopBottom(0, 0, -11, 77)
					f12_arg0:registerEventHandler("transition_complete_keyframe", f12_local0)
				end
				f3_arg0.bannana02:beginAnimation(1000)
				f3_arg0.bannana02:setTopBottom(0, 0, -22, 66)
				f3_arg0.bannana02:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.bannana02:registerEventHandler("transition_complete_keyframe", f11_local0)
			end
			f3_arg0.bannana02:completeAnimation()
			f3_arg0.bannana02:setLeftRight(0, 0, 259.5, 355.5)
			f3_arg0.bannana02:setTopBottom(0, 0, -11, 77)
			f3_local2(f3_arg0.bannana02)
			local f3_local3 = function(f15_arg0)
				local f15_local0 = function(f16_arg0)
					f16_arg0:beginAnimation(2290)
					f16_arg0:setTopBottom(0, 0, 59, 155)
					f16_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
				end
				f3_arg0.bannana03:beginAnimation(2720)
				f3_arg0.bannana03:setTopBottom(0, 0, 107, 203)
				f3_arg0.bannana03:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.bannana03:registerEventHandler("transition_complete_keyframe", f15_local0)
			end
			f3_arg0.bannana03:completeAnimation()
			f3_arg0.bannana03:setTopBottom(0, 0, 59, 155)
			f3_local3(f3_arg0.bannana03)
			local f3_local4 = function(f17_arg0)
				local f17_local0 = function(f18_arg0)
					f18_arg0:beginAnimation(2710)
					f18_arg0:setTopBottom(0, 0, 161, 225)
					f18_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
				end
				f3_arg0.bannana04:beginAnimation(2300)
				f3_arg0.bannana04:setTopBottom(0, 0, 146, 210)
				f3_arg0.bannana04:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.bannana04:registerEventHandler("transition_complete_keyframe", f17_local0)
			end
			f3_arg0.bannana04:completeAnimation()
			f3_arg0.bannana04:setTopBottom(0, 0, 161, 225)
			f3_local4(f3_arg0.bannana04)
			local f3_local5 = function(f19_arg0)
				local f19_local0 = function(f20_arg0)
					f20_arg0:beginAnimation(3370)
					f20_arg0:setTopBottom(0, 0, 49, 121)
					f20_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
				end
				f3_arg0.bannana05:beginAnimation(1640)
				f3_arg0.bannana05:setTopBottom(0, 0, 9, 81)
				f3_arg0.bannana05:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.bannana05:registerEventHandler("transition_complete_keyframe", f19_local0)
			end
			f3_arg0.bannana05:completeAnimation()
			f3_arg0.bannana05:setTopBottom(0, 0, 49, 121)
			f3_local5(f3_arg0.bannana05)
			local f3_local6 = function(f21_arg0)
				local f21_local0 = function(f22_arg0)
					f22_arg0:beginAnimation(2330)
					f22_arg0:setTopBottom(0, 0, 153, 209)
					f22_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
				end
				f3_arg0.bannana06:beginAnimation(2680)
				f3_arg0.bannana06:setTopBottom(0, 0, 145, 201)
				f3_arg0.bannana06:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.bannana06:registerEventHandler("transition_complete_keyframe", f21_local0)
			end
			f3_arg0.bannana06:completeAnimation()
			f3_arg0.bannana06:setTopBottom(0, 0, 153, 209)
			f3_local6(f3_arg0.bannana06)
			f3_arg0.nextClip = "DefaultClip"
		end,
	},
}
CoD.callingcards_signature_weapon_master.__onClose = function(f23_arg0)
	f23_arg0.monkeyShines:close()
end
