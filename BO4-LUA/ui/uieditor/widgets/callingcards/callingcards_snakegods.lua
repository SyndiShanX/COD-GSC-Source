require("x64:a5324162e5573cf")
require("x64:bb90b5ec911d16f")
CoD[0xC44AA3B51953556] = InheritFrom(LUI.UIElement)
CoD[0xC44AA3B51953556].__defaultWidth = 960
CoD[0xC44AA3B51953556].__defaultHeight = 240
CoD[0xC44AA3B51953556].new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD[0xC44AA3B51953556])
	self.id = "callingcards_snakegods"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local background = LUI.UIImage.new(0, 0, 0, 960, 0, 0, 0, 240)
	background:setImage(RegisterImage(0x72BB0B85F7587BD))
	self:addElement(background)
	self.background = background
	local building = LUI.UIImage.new(0, 0, 0, 608, 0, 0, -72, 240)
	building:setImage(RegisterImage(0x19BCD7B2F237955))
	self:addElement(building)
	self.building = building
	local hero = CoD.callingcards_snakegods_asset_hero.new(f1_arg0, f1_arg1, 0, 0, 563, 573, 0, 0, 294, 304)
	self:addElement(hero)
	self.hero = hero
	local lefthand = CoD.callingcards_snakegods_asset_lefthand.new(f1_arg0, f1_arg1, 0, 0, 869, 879, 0, 0, 240, 250)
	self:addElement(lefthand)
	self.lefthand = lefthand
	local Image = LUI.UIImage.new(0, 0, 600, 1500, 0, 0, -433, 467)
	Image:setImage(RegisterImage(0x8CCA9609921F32A))
	Image:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(Image)
	self.Image = Image
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD[0xC44AA3B51953556].__resetProperties = function(f2_arg0)
	f2_arg0.hero:completeAnimation()
	f2_arg0.lefthand:completeAnimation()
	f2_arg0.building:completeAnimation()
	f2_arg0.Image:completeAnimation()
	f2_arg0.hero:setLeftRight(0, 0, 563, 573)
	f2_arg0.hero:setTopBottom(0, 0, 294, 304)
	f2_arg0.hero:setScale(1, 1)
	f2_arg0.building:setLeftRight(0, 0, 0, 608)
	f2_arg0.Image:setAlpha(1)
	f2_arg0.Image:setZRot(0)
end
CoD[0xC44AA3B51953556].__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(4)
			local f3_local0 = function(f4_arg0)
				local f4_local0 = function(f5_arg0)
					f5_arg0:beginAnimation(1500, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
					f5_arg0:setLeftRight(0, 0, -31, 577)
					f5_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
				end
				f3_arg0.building:beginAnimation(1500, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
				f3_arg0.building:setLeftRight(0, 0, 0, 608)
				f3_arg0.building:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.building:registerEventHandler("transition_complete_keyframe", f4_local0)
			end
			f3_arg0.building:completeAnimation()
			f3_arg0.building:setLeftRight(0, 0, -31, 577)
			f3_local0(f3_arg0.building)
			local f3_local1 = function(f6_arg0)
				local f6_local0 = function(f7_arg0)
					f7_arg0:beginAnimation(1500, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
					f7_arg0:setLeftRight(0, 0, 563, 573)
					f7_arg0:registerEventHandler("transition_complete_keyframe", function(element, event)
						element:playClip("DefaultClip")
						f3_arg0.clipFinished(element, event)
					end)
				end
				f3_arg0.hero:playClip("DefaultClip")
				f3_arg0.hero:beginAnimation(1500, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
				f3_arg0.hero:setLeftRight(0, 0, 527, 537)
				f3_arg0.hero:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.hero:registerEventHandler("transition_complete_keyframe", f6_local0)
			end
			f3_arg0.hero:completeAnimation()
			f3_arg0.hero:setLeftRight(0, 0, 563, 573)
			f3_arg0.hero:setTopBottom(0, 0, 294, 304)
			f3_arg0.hero:setScale(1, 1)
			f3_local1(f3_arg0.hero)
			f3_arg0.lefthand:completeAnimation()
			f3_arg0.lefthand:playClip("DefaultClip")
			f3_arg0.clipFinished(f3_arg0.lefthand)
			local f3_local2 = function(f9_arg0)
				local f9_local0 = function(f10_arg0)
					local f10_local0 = function(f11_arg0)
						local f11_local0 = function(f12_arg0)
							local f12_local0 = function(f13_arg0)
								local f13_local0 = function(f14_arg0)
									local f14_local0 = function(f15_arg0)
										local f15_local0 = function(f16_arg0)
											local f16_local0 = function(f17_arg0)
												f17_arg0:beginAnimation(500)
												f17_arg0:setAlpha(1)
												f17_arg0:setZRot(0)
												f17_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
											end
											f16_arg0:beginAnimation(230)
											f16_arg0:setAlpha(0.5)
											f16_arg0:setZRot(-3)
											f16_arg0:registerEventHandler("transition_complete_keyframe", f16_local0)
										end
										f15_arg0:beginAnimation(620)
										f15_arg0:setAlpha(1)
										f15_arg0:setZRot(-4)
										f15_arg0:registerEventHandler("transition_complete_keyframe", f15_local0)
									end
									f14_arg0:beginAnimation(370)
									f14_arg0:setAlpha(0.5)
									f14_arg0:setZRot(-8)
									f14_arg0:registerEventHandler("transition_complete_keyframe", f14_local0)
								end
								f13_arg0:beginAnimation(179)
								f13_arg0:setAlpha(0.84)
								f13_arg0:setZRot(-10)
								f13_arg0:registerEventHandler("transition_complete_keyframe", f13_local0)
							end
							f12_arg0:beginAnimation(120)
							f12_arg0:setAlpha(1)
							f12_arg0:setZRot(-9)
							f12_arg0:registerEventHandler("transition_complete_keyframe", f12_local0)
						end
						f11_arg0:beginAnimation(590)
						f11_arg0:setAlpha(0.5)
						f11_arg0:setZRot(-8)
						f11_arg0:registerEventHandler("transition_complete_keyframe", f11_local0)
					end
					f10_arg0:beginAnimation(79)
					f10_arg0:setAlpha(1)
					f10_arg0:setZRot(-3)
					f10_arg0:registerEventHandler("transition_complete_keyframe", f10_local0)
				end
				f3_arg0.Image:beginAnimation(310)
				f3_arg0.Image:setAlpha(0.5)
				f3_arg0.Image:setZRot(-2)
				f3_arg0.Image:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.Image:registerEventHandler("transition_complete_keyframe", f9_local0)
			end
			f3_arg0.Image:completeAnimation()
			f3_arg0.Image:setAlpha(1)
			f3_arg0.Image:setZRot(0)
			f3_local2(f3_arg0.Image)
			f3_arg0.nextClip = "DefaultClip"
		end,
	},
}
CoD[0xC44AA3B51953556].__onClose = function(f18_arg0)
	f18_arg0.hero:close()
	f18_arg0.lefthand:close()
end
