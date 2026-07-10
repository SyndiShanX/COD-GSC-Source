require("x64:5cc9b001c3ddd6f")
CoD[@"hash_13890464C4936BF0"] = InheritFrom(LUI.UIElement)
CoD[@"hash_13890464C4936BF0"].__defaultWidth = 960
CoD[@"hash_13890464C4936BF0"].__defaultHeight = 240
CoD[@"hash_13890464C4936BF0"].new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD[@"hash_13890464C4936BF0"])
	self.id = "CallingCards_Marksman_Master"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local blueBG = LUI.UIImage.new(0, 0, 0, 960, 0, 0, 0, 240)
	blueBG:setImage(RegisterImage(@"uie_ui_icon_callingcards_bootcamp_master_bluebackground"))
	blueBG:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_tile_scroll_normal"))
	blueBG:setShaderVector(0, 1, 1, 0, 0)
	blueBG:setShaderVector(1, 0.03, 0, 0, 0)
	self:addElement(blueBG)
	self.blueBG = blueBG
	local MainBG = LUI.UIImage.new(0, 0, 0, 960, 0, 0, 0, 240)
	MainBG:setImage(RegisterImage(@"uie_ui_icon_callingcards_marksman_master_background"))
	self:addElement(MainBG)
	self.MainBG = MainBG
	local LightSpin = CoD.CallingCards_Asset_spinburst_container.new(f1_arg0, f1_arg1, 0, 0, -173, 653, 0, 0, -92, 360)
	LightSpin:setScale(0.5, 0.5)
	LightSpin:setRFTMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(LightSpin)
	self.LightSpin = LightSpin
	local LightSpin2 = CoD.CallingCards_Asset_spinburst_container.new(f1_arg0, f1_arg1, 0, 0, 246, 1072, 0, 0, -106, 346)
	LightSpin2:setAlpha(0.5)
	LightSpin2:setScale(0.5, 0.5)
	LightSpin2:setRFTMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(LightSpin2)
	self.LightSpin2 = LightSpin2
	local bgCover = LUI.UIImage.new(0, 0, 0, 960, 0, 0, 0, 240)
	bgCover:setImage(RegisterImage(@"uie_ui_icon_callingcards_marksman_master_background_cover"))
	self:addElement(bgCover)
	self.bgCover = bgCover
	local bgGlow = LUI.UIImage.new(0, 0, 0, 960, 0, 0, 0, 240)
	bgGlow:setImage(RegisterImage(@"uie_ui_icon_callingcards_marksman_master_background_bg_glow"))
	bgGlow:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(bgGlow)
	self.bgGlow = bgGlow
	local Ghost01 = LUI.UIImage.new(0, 0, 240, 488, 0, 0, -10.5, 181.5)
	Ghost01:setAlpha(0.8)
	Ghost01:setZRot(-26)
	Ghost01:setImage(RegisterImage(@"uie_ui_icon_callingcards_marksman_master_background_ghost_01"))
	self:addElement(Ghost01)
	self.Ghost01 = Ghost01
	local Ghost = LUI.UIImage.new(0, 0, 561, 809, 0, 0, -39.5, 152.5)
	Ghost:setAlpha(0.8)
	Ghost:setImage(RegisterImage(@"uie_ui_icon_callingcards_marksman_master_background_ghost_02"))
	self:addElement(Ghost)
	self.Ghost = Ghost
	local shimmer = LUI.UIImage.new(0, 0, 0, 960, 0, 0, 0, 240)
	shimmer:setRGB(0.97, 0.96, 0.1)
	shimmer:setAlpha(0.5)
	shimmer:setImage(RegisterImage(@"uie_ui_icon_callingcards_marksman_master_background_bg_shimmer"))
	shimmer:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_flipbook_add"))
	shimmer:setShaderVector(0, 0, 3, 0, 0)
	shimmer:setShaderVector(1, 12, 0, 0, 0)
	self:addElement(shimmer)
	self.shimmer = shimmer
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD[@"hash_13890464C4936BF0"].__resetProperties = function(f2_arg0)
	f2_arg0.bgGlow:completeAnimation()
	f2_arg0.Ghost:completeAnimation()
	f2_arg0.Ghost01:completeAnimation()
	f2_arg0.LightSpin2:completeAnimation()
	f2_arg0.LightSpin:completeAnimation()
	f2_arg0.bgGlow:setAlpha(1)
	f2_arg0.Ghost:setTopBottom(0, 0, -39.5, 152.5)
	f2_arg0.Ghost:setScale(1, 1)
	f2_arg0.Ghost01:setTopBottom(0, 0, -10.5, 181.5)
	f2_arg0.Ghost01:setScale(1, 1)
	f2_arg0.LightSpin2:setAlpha(0.5)
	f2_arg0.LightSpin:setAlpha(1)
end
CoD[@"hash_13890464C4936BF0"].__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(5)
			f3_arg0.LightSpin:completeAnimation()
			f3_arg0.LightSpin:setAlpha(0.7)
			f3_arg0.clipFinished(f3_arg0.LightSpin)
			f3_arg0.LightSpin2:completeAnimation()
			f3_arg0.LightSpin2:setAlpha(0.7)
			f3_arg0.clipFinished(f3_arg0.LightSpin2)
			local f3_local0 = function(f4_arg0)
				local f4_local0 = function(f5_arg0)
					f5_arg0:beginAnimation(1520)
					f5_arg0:setAlpha(1)
					f5_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
				end
				f3_arg0.bgGlow:beginAnimation(1480)
				f3_arg0.bgGlow:setAlpha(0.25)
				f3_arg0.bgGlow:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.bgGlow:registerEventHandler("transition_complete_keyframe", f4_local0)
			end
			f3_arg0.bgGlow:completeAnimation()
			f3_arg0.bgGlow:setAlpha(1)
			f3_local0(f3_arg0.bgGlow)
			local f3_local1 = function(f6_arg0)
				local f6_local0 = function(f7_arg0)
					local f7_local0 = function(f8_arg0)
						local f8_local0 = function(f9_arg0)
							f9_arg0:beginAnimation(809)
							f9_arg0:setTopBottom(0, 0, -10.5, 181.5)
							f9_arg0:setScale(0.89, 1.06)
							f9_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
						end
						f8_arg0:beginAnimation(710)
						f8_arg0:setTopBottom(0, 0, 11.35, 203.35)
						f8_arg0:setScale(0.9, 1.13)
						f8_arg0:registerEventHandler("transition_complete_keyframe", f8_local0)
					end
					f7_arg0:beginAnimation(860)
					f7_arg0:setTopBottom(0, 0, 30.5, 222.5)
					f7_arg0:setScale(1.01, 1.1)
					f7_arg0:registerEventHandler("transition_complete_keyframe", f7_local0)
				end
				f3_arg0.Ghost01:beginAnimation(620)
				f3_arg0.Ghost01:setTopBottom(0, 0, 6.68, 198.68)
				f3_arg0.Ghost01:setScale(1, 1)
				f3_arg0.Ghost01:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.Ghost01:registerEventHandler("transition_complete_keyframe", f6_local0)
			end
			f3_arg0.Ghost01:completeAnimation()
			f3_arg0.Ghost01:setTopBottom(0, 0, -10.5, 181.5)
			f3_arg0.Ghost01:setScale(0.89, 1.06)
			f3_local1(f3_arg0.Ghost01)
			local f3_local2 = function(f10_arg0)
				local f10_local0 = function(f11_arg0)
					f11_arg0:beginAnimation(1520)
					f11_arg0:setTopBottom(0, 0, -39.5, 152.5)
					f11_arg0:setScale(1, 1)
					f11_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
				end
				f3_arg0.Ghost:beginAnimation(1480)
				f3_arg0.Ghost:setTopBottom(0, 0, -65.5, 126.5)
				f3_arg0.Ghost:setScale(1.08, 0.9)
				f3_arg0.Ghost:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.Ghost:registerEventHandler("transition_complete_keyframe", f10_local0)
			end
			f3_arg0.Ghost:completeAnimation()
			f3_arg0.Ghost:setTopBottom(0, 0, -39.5, 152.5)
			f3_arg0.Ghost:setScale(1, 1)
			f3_local2(f3_arg0.Ghost)
			f3_arg0.nextClip = "DefaultClip"
		end,
	},
}
CoD[@"hash_13890464C4936BF0"].__onClose = function(f12_arg0)
	f12_arg0.LightSpin:close()
	f12_arg0.LightSpin2:close()
end
