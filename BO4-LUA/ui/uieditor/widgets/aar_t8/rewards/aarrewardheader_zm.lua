require("x64:94dab3a4d2d79b2")
CoD.AARRewardHeader_ZM = InheritFrom(LUI.UIElement)
CoD.AARRewardHeader_ZM.__defaultWidth = 412
CoD.AARRewardHeader_ZM.__defaultHeight = 210
CoD.AARRewardHeader_ZM.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.AARRewardHeader_ZM)
	self.id = "AARRewardHeader_ZM"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Pointer = LUI.UIImage.new(0, 0, 190, 222, 0, 0, 209.5, 221.5)
	Pointer:setRGB(0.32, 0.34, 0.13)
	Pointer:setAlpha(0.2)
	Pointer:setZRot(180)
	Pointer:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_BE6E734C31AE757"))
	self:addElement(Pointer)
	self.Pointer = Pointer
	local headerBacking = LUI.UIImage.new(0.5, 0.5, -206, 206, 0, 0, 0, 210)
	headerBacking:setRGB(0.43, 0.16, 0.16)
	headerBacking:setAlpha(0.4)
	self:addElement(headerBacking)
	self.headerBacking = headerBacking
	local mainTitle = LUI.UIText.new(0.5, 0.5, -201, 201, 0, 0, 180, 201)
	mainTitle:setRGB(1, 1, 1)
	mainTitle:setText("")
	mainTitle:setTTF("dinnext_regular")
	mainTitle:setLetterSpacing(2)
	mainTitle:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	mainTitle:setAlignment(Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"])
	self:addElement(mainTitle)
	self.mainTitle = mainTitle
	local BgZmStar = LUI.UIImage.new(0, 0, 150, 262, 0, 0, 91, 203)
	BgZmStar:setImage(RegisterImage(@"uie_ui_hud_zm_arr_reward_star"))
	BgZmStar:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	BgZmStar:setShaderVector(0, 1.5, 0, 0, 0)
	self:addElement(BgZmStar)
	self.BgZmStar = BgZmStar
	local TitleBacker = LUI.UIImage.new(0, 1, 0, 0, 0, 0, 127, 167)
	TitleBacker:setRGB(0, 0, 0)
	TitleBacker:setAlpha(0.5)
	self:addElement(TitleBacker)
	self.TitleBacker = TitleBacker
	local BgZmStarZdepth = LUI.UIImage.new(0, 0, 150, 262, 0, 0, 91, 203)
	BgZmStarZdepth:setImage(RegisterImage(@"uie_ui_hud_zm_arr_reward_star"))
	BgZmStarZdepth:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	BgZmStarZdepth:setShaderVector(0, 0.71, 0, 0, 0)
	self:addElement(BgZmStarZdepth)
	self.BgZmStarZdepth = BgZmStarZdepth
	local TiledBacking = LUI.UIImage.new(0, 1, 0, 0, 0.51, 0.8, 20, 0)
	TiledBacking:setAlpha(0.5)
	TiledBacking:setImage(RegisterImage(@"uie_ui_menu_specialist_hub_repeat_bg"))
	TiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	TiledBacking:setShaderVector(0, 0, 0, 0, 0)
	TiledBacking:setupNineSliceShader(196, 88)
	self:addElement(TiledBacking)
	self.TiledBacking = TiledBacking
	local levelText = LUI.UIText.new(0.5, 0.5, -201, 201, 0, 0, 135.5, 163.5)
	levelText:setText("")
	levelText:setTTF("skorzhen")
	levelText:setLetterSpacing(3)
	levelText:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	levelText:setAlignment(Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"])
	self:addElement(levelText)
	self.levelText = levelText
	local mainIcon = LUI.UIFixedAspectRatioImage.new(0.5, 0.5, -60, 60, 0, 0, 3, 123)
	self:addElement(mainIcon)
	self.mainIcon = mainIcon
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.AARRewardHeader_ZM.__resetProperties = function(f2_arg0)
	f2_arg0.BgZmStar:completeAnimation()
	f2_arg0.BgZmStarZdepth:completeAnimation()
	f2_arg0.BgZmStar:setZRot(0)
	f2_arg0.BgZmStar:setShaderVector(0, 1.5, 0, 0, 0)
	f2_arg0.BgZmStarZdepth:setZRot(0)
	f2_arg0.BgZmStarZdepth:setZoom(0)
	f2_arg0.BgZmStarZdepth:setShaderVector(0, 0.71, 0, 0, 0)
end
CoD.AARRewardHeader_ZM.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(2)
			local f3_local0 = function(f4_arg0)
				local f4_local0 = function(f5_arg0)
					f5_arg0:beginAnimation(15000)
					f5_arg0:setZRot(360)
					f5_arg0:setShaderVector(0, 1, 0, 0, 0)
					f5_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
				end
				f3_arg0.BgZmStar:beginAnimation(15000)
				f3_arg0.BgZmStar:setZRot(180)
				f3_arg0.BgZmStar:setShaderVector(0, 2, 0, 0, 0)
				f3_arg0.BgZmStar:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.BgZmStar:registerEventHandler("transition_complete_keyframe", f4_local0)
			end
			f3_arg0.BgZmStar:completeAnimation()
			f3_arg0.BgZmStar:setZRot(0)
			f3_arg0.BgZmStar:setShaderVector(0, 1, 0, 0, 0)
			f3_local0(f3_arg0.BgZmStar)
			local f3_local1 = function(f6_arg0)
				local f6_local0 = function(f7_arg0)
					local f7_local0 = function(f8_arg0)
						local f8_local0 = function(f9_arg0)
							f9_arg0:beginAnimation(7500)
							f9_arg0:setZRot(360)
							f9_arg0:setZoom(0)
							f9_arg0:setShaderVector(0, 0.5, 0, 0, 0)
							f9_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
						end
						f8_arg0:beginAnimation(7500)
						f8_arg0:setZRot(270)
						f8_arg0:setZoom(-10)
						f8_arg0:setShaderVector(0, 1.2, 0, 0, 0)
						f8_arg0:registerEventHandler("transition_complete_keyframe", f8_local0)
					end
					f7_arg0:beginAnimation(7500)
					f7_arg0:setZRot(180)
					f7_arg0:setZoom(0)
					f7_arg0:setShaderVector(0, 0.5, 0, 0, 0)
					f7_arg0:registerEventHandler("transition_complete_keyframe", f7_local0)
				end
				f3_arg0.BgZmStarZdepth:beginAnimation(7500)
				f3_arg0.BgZmStarZdepth:setZRot(90)
				f3_arg0.BgZmStarZdepth:setZoom(10)
				f3_arg0.BgZmStarZdepth:setShaderVector(0, 1, 0, 0, 0)
				f3_arg0.BgZmStarZdepth:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.BgZmStarZdepth:registerEventHandler("transition_complete_keyframe", f6_local0)
			end
			f3_arg0.BgZmStarZdepth:completeAnimation()
			f3_arg0.BgZmStarZdepth:setZRot(0)
			f3_arg0.BgZmStarZdepth:setZoom(0)
			f3_arg0.BgZmStarZdepth:setShaderVector(0, 0.5, 0, 0, 0)
			f3_local1(f3_arg0.BgZmStarZdepth)
			f3_arg0.nextClip = "DefaultClip"
		end,
	},
}
