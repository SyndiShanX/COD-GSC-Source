require("ui/uieditor/widgets/callingcards/callingcards_asset_cold_breath")
require("ui/uieditor/widgets/callingcards/callingcards_asset_firballs")
require("ui/uieditor/widgets/callingcards/callingcards_asset_robotdawg")
CoD.callingcards_wz_vehicular_master = InheritFrom(LUI.UIElement)
CoD.callingcards_wz_vehicular_master.__defaultWidth = 960
CoD.callingcards_wz_vehicular_master.__defaultHeight = 240
CoD.callingcards_wz_vehicular_master.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.callingcards_wz_vehicular_master)
	self.id = "CallingCards_wz_Vehicular_Master"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local bg = LUI.UIImage.new(0, 0, 0, 960, 0, 0, 0, 240)
	bg:setImage(RegisterImage("uie_ui_icon_callingcards_wz_vehicular_master_background"))
	bg:setMaterial(LUI.UIImage.GetCachedMaterial("uie_tile_scroll_normal"))
	bg:setShaderVector(0, 1, 1, 0, 0)
	bg:setShaderVector(1, -0.05, 0, 0, 0)
	self:addElement(bg)
	self.bg = bg
	local Fireball = CoD.CallingCards_Asset_firballs.new(f1_arg0, f1_arg1, 0, 0, -122, 838, 0, 0, -5.5, 234.5)
	self:addElement(Fireball)
	self.Fireball = Fireball
	local Fireball2 = CoD.CallingCards_Asset_firballs.new(f1_arg0, f1_arg1, 0, 0, -122, 838, 0, 0, -5.5, 234.5)
	self:addElement(Fireball2)
	self.Fireball2 = Fireball2
	local grass = LUI.UIImage.new(0, 0, 0, 960, 0, 0, 0, 240)
	grass:setImage(RegisterImage("uie_ui_icon_callingcards_wz_vehicular_master_grass"))
	self:addElement(grass)
	self.grass = grass
	local glowyBits = CoD.CallingCards_Asset_robotdawg.new(f1_arg0, f1_arg1, 0, 0, 0, 960, 0, 0, 0, 240)
	self:addElement(glowyBits)
	self.glowyBits = glowyBits
	local BreathSpot = CoD.CallingCards_Asset_cold_breath.new(f1_arg0, f1_arg1, 0, 0, 178, 306, 0, 0, 96, 224)
	self:addElement(BreathSpot)
	self.BreathSpot = BreathSpot
	local head = LUI.UIImage.new(0, 0, 201.5, 465.5, 0, 0, 12, 172)
	head:setScale(1.05, 1.05)
	head:setImage(RegisterImage("uie_ui_icon_callingcards_wz_vehicular_master_head"))
	self:addElement(head)
	self.head = head
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.callingcards_wz_vehicular_master.__resetProperties = function(f2_arg0)
	f2_arg0.Fireball:completeAnimation()
	f2_arg0.glowyBits:completeAnimation()
	f2_arg0.BreathSpot:completeAnimation()
	f2_arg0.head:completeAnimation()
	f2_arg0.Fireball2:completeAnimation()
	f2_arg0.BreathSpot:setLeftRight(0, 0, 178, 306)
	f2_arg0.BreathSpot:setTopBottom(0, 0, 96, 224)
	f2_arg0.BreathSpot:setAlpha(1)
	f2_arg0.BreathSpot:setScale(1, 1)
	f2_arg0.head:setTopBottom(0, 0, 12, 172)
	f2_arg0.head:setAlpha(1)
end
CoD.callingcards_wz_vehicular_master.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(5)
			f3_arg0.Fireball:completeAnimation()
			f3_arg0.Fireball:playClip("DefaultClip")
			f3_arg0.clipFinished(f3_arg0.Fireball)
			f3_arg0.Fireball2:beginAnimation(750)
			f3_arg0.Fireball2:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
			f3_arg0.Fireball2:registerEventHandler("transition_complete_keyframe", function(element, event)
				element:playClip("DefaultClip")
				f3_arg0.clipFinished(element, event)
			end)
			f3_arg0.glowyBits:completeAnimation()
			f3_arg0.glowyBits:playClip("DefaultClip")
			f3_arg0.clipFinished(f3_arg0.glowyBits)
			local f3_local0 = function(f5_arg0)
				local f5_local0 = function(f6_arg0)
					local f6_local0 = function(f7_arg0)
						local f7_local0 = function(f8_arg0)
							local f8_local0 = function(f9_arg0)
								local f9_local0 = function(f10_arg0)
									f10_arg0:beginAnimation(609)
									f10_arg0:registerEventHandler("transition_complete_keyframe", function(element, event)
										element:playClip("DefaultClip")
										f3_arg0.clipFinished(element, event)
									end)
								end
								f9_arg0:beginAnimation(680)
								f9_arg0:setLeftRight(0, 0, 226.5, 354.5)
								f9_arg0:setTopBottom(0, 0, 92, 220)
								f9_arg0:setAlpha(0)
								f9_arg0:registerEventHandler("transition_complete_keyframe", f9_local0)
							end
							f8_arg0:beginAnimation(620)
							f8_arg0:setLeftRight(0, 0, 256.5, 384.5)
							f8_arg0:setTopBottom(0, 0, 130, 258)
							f8_arg0:setAlpha(0.39)
							f8_arg0:setScale(0.5, 0.5)
							f8_arg0:registerEventHandler("transition_complete_keyframe", f8_local0)
						end
						f7_arg0:playClip("DefaultClip")
						f7_arg0:beginAnimation(430)
						f7_arg0:setLeftRight(0, 0, 303.5, 431.5)
						f7_arg0:setTopBottom(0, 0, 120, 248)
						f7_arg0:setAlpha(0.75)
						f7_arg0:setScale(0.75, 0.75)
						f7_arg0:registerEventHandler("transition_complete_keyframe", f7_local0)
					end
					f6_arg0:beginAnimation(39)
					f6_arg0:setAlpha(1)
					f6_arg0:setScale(0.87, 0.87)
					f6_arg0:registerEventHandler("transition_complete_keyframe", f6_local0)
				end
				f3_arg0.BreathSpot:beginAnimation(410)
				f3_arg0.BreathSpot:setScale(0.88, 0.88)
				f3_arg0.BreathSpot:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.BreathSpot:registerEventHandler("transition_complete_keyframe", f5_local0)
			end
			f3_arg0.BreathSpot:completeAnimation()
			f3_arg0.BreathSpot:setLeftRight(0, 0, 337.5, 465.5)
			f3_arg0.BreathSpot:setTopBottom(0, 0, 81, 209)
			f3_arg0.BreathSpot:setAlpha(0)
			f3_arg0.BreathSpot:setScale(1, 1)
			f3_local0(f3_arg0.BreathSpot)
			local f3_local1 = function(f12_arg0)
				local f12_local0 = function(f13_arg0)
					local f13_local0 = function(f14_arg0)
						local f14_local0 = function(f15_arg0)
							f15_arg0:beginAnimation(680)
							f15_arg0:setTopBottom(0, 0, 6, 166)
							f15_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
						end
						f14_arg0:beginAnimation(2290)
						f14_arg0:setTopBottom(0, 0, 8, 168)
						f14_arg0:setAlpha(0)
						f14_arg0:registerEventHandler("transition_complete_keyframe", f14_local0)
					end
					f13_arg0:beginAnimation(339)
					f13_arg0:setAlpha(0.87)
					f13_arg0:registerEventHandler("transition_complete_keyframe", f13_local0)
				end
				f3_arg0.head:beginAnimation(660)
				f3_arg0.head:setTopBottom(0, 0, 12, 172)
				f3_arg0.head:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.head:registerEventHandler("transition_complete_keyframe", f12_local0)
			end
			f3_arg0.head:completeAnimation()
			f3_arg0.head:setTopBottom(0, 0, 11, 171)
			f3_arg0.head:setAlpha(1)
			f3_local1(f3_arg0.head)
			f3_arg0.nextClip = "DefaultClip"
		end,
	},
}
CoD.callingcards_wz_vehicular_master.__onClose = function(f16_arg0)
	f16_arg0.Fireball:close()
	f16_arg0.Fireball2:close()
	f16_arg0.glowyBits:close()
	f16_arg0.BreathSpot:close()
end
