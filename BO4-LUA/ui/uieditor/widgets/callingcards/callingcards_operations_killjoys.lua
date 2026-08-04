CoD.callingcards_operations_killjoys = InheritFrom(LUI.UIElement)
CoD.callingcards_operations_killjoys.__defaultWidth = 960
CoD.callingcards_operations_killjoys.__defaultHeight = 240
CoD.callingcards_operations_killjoys.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.callingcards_operations_killjoys)
	self.id = "CallingCards_Operations_Killjoys"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local CardIcon = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	CardIcon:setImage(RegisterImage("uie_t7_icon_callingcard_temp2_lrg"))
	CardIcon:setMaterial(LUI.UIImage.GetCachedMaterial("uie_feather_blend"))
	self:addElement(CardIcon)
	self.CardIcon = CardIcon
	local background = LUI.UIImage.new(0, 0, 0, 960, 0, 0, 0, 240)
	background:setImage(RegisterImage("uie_ui_icon_callingcards_operations_killjoys_background"))
	background:setMaterial(LUI.UIImage.GetCachedMaterial("uie_tile_scroll_normal"))
	background:setShaderVector(0, 1, 1, 0, 0)
	background:setShaderVector(1, 0.03, 0, 0, 0)
	self:addElement(background)
	self.background = background
	local characters = LUI.UIImage.new(0, 0, 0, 960, 0, 0, 0, 240)
	characters:setImage(RegisterImage("uie_ui_icon_callingcards_operations_killjoys_characters"))
	self:addElement(characters)
	self.characters = characters
	local bloodSpurting = LUI.UIImage.new(0, 0, 142, 261, 0, 0, 40, 159)
	bloodSpurting:setAlpha(0)
	bloodSpurting:setImage(RegisterImage("uie_ui_icon_callingcards_operations_killjoys_bloodspurt"))
	bloodSpurting:setMaterial(LUI.UIImage.GetCachedMaterial("uie_flipbook"))
	bloodSpurting:setShaderVector(0, 0, 4, 0, 0)
	bloodSpurting:setShaderVector(1, 6, 0, 0, 0)
	self:addElement(bloodSpurting)
	self.bloodSpurting = bloodSpurting
	local GlowFist = LUI.UIImage.new(0, 0, 671, 786, 0, 0, 90.5, 195.5)
	GlowFist:setAlpha(0.7)
	GlowFist:setImage(RegisterImage("uie_ui_icon_callingcards_operations_killjoys_greenfist"))
	GlowFist:setMaterial(LUI.UIImage.GetCachedMaterial("ui_add"))
	self:addElement(GlowFist)
	self.GlowFist = GlowFist
	local gloweyes = LUI.UIImage.new(0, 0, 641, 753, 0, 0, 2, 42)
	gloweyes:setImage(RegisterImage("uie_ui_icon_callingcards_operations_killjoys_greeneyes"))
	gloweyes:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_F755127C95CF5B6"))
	gloweyes:setShaderVector(0, 1.5, 0, 0, 0)
	self:addElement(gloweyes)
	self.gloweyes = gloweyes
	local SwordSheen = LUI.UIImage.new(0, 0, 502, 622, 0, 0, 85.5, 221.5)
	SwordSheen:setImage(RegisterImage("uie_ui_icon_callingcards_operations_killjoys_swordsheen"))
	SwordSheen:setMaterial(LUI.UIImage.GetCachedMaterial("uie_wipe_delta_normal"))
	SwordSheen:setShaderVector(0, 0, 1, 0, 0)
	SwordSheen:setShaderVector(1, 0, 0, 0, 0)
	SwordSheen:setShaderVector(2, 0, 1, 0, 0)
	SwordSheen:setShaderVector(3, 0, 0, 0, 0)
	SwordSheen:setShaderVector(4, 0, 0, 0, 0)
	self:addElement(SwordSheen)
	self.SwordSheen = SwordSheen
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.callingcards_operations_killjoys.__resetProperties = function(f2_arg0)
	f2_arg0.gloweyes:completeAnimation()
	f2_arg0.GlowFist:completeAnimation()
	f2_arg0.SwordSheen:completeAnimation()
	f2_arg0.gloweyes:setAlpha(1)
	f2_arg0.GlowFist:setAlpha(0.7)
	f2_arg0.GlowFist:setMaterial(LUI.UIImage.GetCachedMaterial("ui_add"))
	f2_arg0.SwordSheen:setShaderVector(0, 0, 1, 0, 0)
	f2_arg0.SwordSheen:setShaderVector(1, 0, 0, 0, 0)
	f2_arg0.SwordSheen:setShaderVector(2, 0, 1, 0, 0)
	f2_arg0.SwordSheen:setShaderVector(3, 0, 0, 0, 0)
	f2_arg0.SwordSheen:setShaderVector(4, 0, 0, 0, 0)
end
CoD.callingcards_operations_killjoys.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(3)
			local f3_local0 = function(f4_arg0)
				local f4_local0 = function(f5_arg0)
					f5_arg0:beginAnimation(1060)
					f5_arg0:setAlpha(0)
					f5_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
				end
				f3_arg0.GlowFist:beginAnimation(940)
				f3_arg0.GlowFist:setAlpha(0.6)
				f3_arg0.GlowFist:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.GlowFist:registerEventHandler("transition_complete_keyframe", f4_local0)
			end
			f3_arg0.GlowFist:completeAnimation()
			f3_arg0.GlowFist:setAlpha(0)
			f3_arg0.GlowFist:setMaterial(LUI.UIImage.GetCachedMaterial("ui_add"))
			f3_local0(f3_arg0.GlowFist)
			local f3_local1 = function(f6_arg0)
				local f6_local0 = function(f7_arg0)
					local f7_local0 = function(f8_arg0)
						f8_arg0:beginAnimation(1000)
						f8_arg0:setAlpha(0)
						f8_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
					end
					f7_arg0:beginAnimation(1000)
					f7_arg0:setAlpha(1)
					f7_arg0:registerEventHandler("transition_complete_keyframe", f7_local0)
				end
				f3_arg0.gloweyes:beginAnimation(1000)
				f3_arg0.gloweyes:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.gloweyes:registerEventHandler("transition_complete_keyframe", f6_local0)
			end
			f3_arg0.gloweyes:completeAnimation()
			f3_arg0.gloweyes:setAlpha(0)
			f3_local1(f3_arg0.gloweyes)
			local f3_local2 = function(f9_arg0)
				local f9_local0 = function(f10_arg0)
					f10_arg0:beginAnimation(500)
					f10_arg0:setShaderVector(0, -0.03, 0.05, 0, 0)
					f10_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
				end
				f3_arg0.SwordSheen:beginAnimation(500)
				f3_arg0.SwordSheen:setShaderVector(0, 0.24, 0.37, 0, 0)
				f3_arg0.SwordSheen:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.SwordSheen:registerEventHandler("transition_complete_keyframe", f9_local0)
			end
			f3_arg0.SwordSheen:completeAnimation()
			f3_arg0.SwordSheen:setShaderVector(0, 0.9, 0.97, 0, 0)
			f3_arg0.SwordSheen:setShaderVector(1, 0.06, 0.06, 0, 0)
			f3_arg0.SwordSheen:setShaderVector(2, 0, 1, 0, 0)
			f3_arg0.SwordSheen:setShaderVector(3, 0, 0, 0, 0)
			f3_arg0.SwordSheen:setShaderVector(4, 0, 0, 0, 0)
			f3_local2(f3_arg0.SwordSheen)
			f3_arg0.nextClip = "DefaultClip"
		end,
	},
}
