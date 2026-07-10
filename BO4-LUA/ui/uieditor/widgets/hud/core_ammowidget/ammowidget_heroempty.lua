CoD.AmmoWidget_HeroEmpty = InheritFrom(LUI.UIElement)
CoD.AmmoWidget_HeroEmpty.__defaultWidth = 64
CoD.AmmoWidget_HeroEmpty.__defaultHeight = 59
CoD.AmmoWidget_HeroEmpty.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.AmmoWidget_HeroEmpty)
	self.id = "AmmoWidget_HeroEmpty"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ImgIcon = LUI.UIImage.new(0.5, 0.5, -54.5, 50.5, 0.5, 0.5, -59.5, 57.5)
	ImgIcon:setRGB(1, 0, 0)
	ImgIcon:setAlpha(0.3)
	ImgIcon:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	ImgIcon:linkToElementModel(self, "image", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			ImgIcon:setImage(RegisterImage(f2_local0))
		end
	end)
	self:addElement(ImgIcon)
	self.ImgIcon = ImgIcon
	local ImgIconGrow = LUI.UIImage.new(0.5, 0.5, -54.5, 50.5, 0.5, 0.5, -59.5, 57.5)
	ImgIconGrow:setRGB(1, 0, 0)
	ImgIconGrow:setAlpha(0.31)
	ImgIconGrow:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	ImgIconGrow:linkToElementModel(self, "image", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			ImgIconGrow:setImage(RegisterImage(f3_local0))
		end
	end)
	self:addElement(ImgIconGrow)
	self.ImgIconGrow = ImgIconGrow
	local Inactive = LUI.UIImage.new(0.5, 0.5, -30.5, 26.5, 0.5, 0.5, -32.5, 26.5)
	Inactive:setRGB(0.88, 0.07, 0.07)
	Inactive:setAlpha(0.25)
	Inactive:setScale(1.6, 1.6)
	Inactive:setImage(RegisterImage(0xCFDBE48B7A82C2C))
	Inactive:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(Inactive)
	self.Inactive = Inactive
	self:linkToElementModel(self, "pulseEmpty", true, function(model)
		local f4_local0 = self
		PlayClip(self, "Empty", f1_arg1)
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.AmmoWidget_HeroEmpty.__resetProperties = function(f5_arg0)
	f5_arg0.ImgIconGrow:completeAnimation()
	f5_arg0.ImgIcon:completeAnimation()
	f5_arg0.Inactive:completeAnimation()
	f5_arg0.ImgIconGrow:setLeftRight(0.5, 0.5, -54.5, 50.5)
	f5_arg0.ImgIconGrow:setTopBottom(0.5, 0.5, -59.5, 57.5)
	f5_arg0.ImgIconGrow:setAlpha(0.31)
	f5_arg0.ImgIconGrow:setScale(1, 1)
	f5_arg0.ImgIcon:setLeftRight(0.5, 0.5, -54.5, 50.5)
	f5_arg0.ImgIcon:setTopBottom(0.5, 0.5, -59.5, 57.5)
	f5_arg0.ImgIcon:setAlpha(0.3)
	f5_arg0.Inactive:setAlpha(0.25)
end
CoD.AmmoWidget_HeroEmpty.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(3)
			f6_arg0.ImgIcon:completeAnimation()
			f6_arg0.ImgIcon:setLeftRight(0.5, 0.5, -20, 19)
			f6_arg0.ImgIcon:setTopBottom(0.5, 0.5, -20, 19)
			f6_arg0.ImgIcon:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.ImgIcon)
			f6_arg0.ImgIconGrow:completeAnimation()
			f6_arg0.ImgIconGrow:setLeftRight(0.5, 0.5, -20, 19)
			f6_arg0.ImgIconGrow:setTopBottom(0.5, 0.5, -20, 19)
			f6_arg0.ImgIconGrow:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.ImgIconGrow)
			f6_arg0.Inactive:completeAnimation()
			f6_arg0.Inactive:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.Inactive)
		end,
		Empty = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(3)
			local f7_local0 = function(f8_arg0)
				f7_arg0.ImgIcon:beginAnimation(350)
				f7_arg0.ImgIcon:setAlpha(0)
				f7_arg0.ImgIcon:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.ImgIcon:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
			end
			f7_arg0.ImgIcon:completeAnimation()
			f7_arg0.ImgIcon:setAlpha(0.25)
			f7_local0(f7_arg0.ImgIcon)
			local f7_local1 = function(f9_arg0)
				f7_arg0.ImgIconGrow:beginAnimation(350)
				f7_arg0.ImgIconGrow:setAlpha(0)
				f7_arg0.ImgIconGrow:setScale(1.5, 1.5)
				f7_arg0.ImgIconGrow:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.ImgIconGrow:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
			end
			f7_arg0.ImgIconGrow:completeAnimation()
			f7_arg0.ImgIconGrow:setAlpha(0.25)
			f7_arg0.ImgIconGrow:setScale(1, 1)
			f7_local1(f7_arg0.ImgIconGrow)
			local f7_local2 = function(f10_arg0)
				local f10_local0 = function(f11_arg0)
					local f11_local0 = function(f12_arg0)
						local f12_local0 = function(f13_arg0)
							local f13_local0 = function(f14_arg0)
								local f14_local0 = function(f15_arg0)
									local f15_local0 = function(f16_arg0)
										local f16_local0 = function(f17_arg0)
											local f17_local0 = function(f18_arg0)
												local f18_local0 = function(f19_arg0)
													f19_arg0:beginAnimation(210)
													f19_arg0:setAlpha(0)
													f19_arg0:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
												end
												f18_arg0:beginAnimation(10)
												f18_arg0:setAlpha(0.76)
												f18_arg0:registerEventHandler("transition_complete_keyframe", f18_local0)
											end
											f17_arg0:beginAnimation(19)
											f17_arg0:setAlpha(0.5)
											f17_arg0:registerEventHandler("transition_complete_keyframe", f17_local0)
										end
										f16_arg0:beginAnimation(9)
										f16_arg0:setAlpha(0.51)
										f16_arg0:registerEventHandler("transition_complete_keyframe", f16_local0)
									end
									f15_arg0:beginAnimation(30)
									f15_arg0:registerEventHandler("transition_complete_keyframe", f15_local0)
								end
								f14_arg0:beginAnimation(10)
								f14_arg0:setAlpha(0.75)
								f14_arg0:registerEventHandler("transition_complete_keyframe", f14_local0)
							end
							f13_arg0:beginAnimation(20)
							f13_arg0:setAlpha(0.11)
							f13_arg0:registerEventHandler("transition_complete_keyframe", f13_local0)
						end
						f12_arg0:beginAnimation(10)
						f12_arg0:setAlpha(0)
						f12_arg0:registerEventHandler("transition_complete_keyframe", f12_local0)
					end
					f11_arg0:beginAnimation(20)
					f11_arg0:setAlpha(0.71)
					f11_arg0:registerEventHandler("transition_complete_keyframe", f11_local0)
				end
				f7_arg0.Inactive:beginAnimation(10)
				f7_arg0.Inactive:setAlpha(0.75)
				f7_arg0.Inactive:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.Inactive:registerEventHandler("transition_complete_keyframe", f10_local0)
			end
			f7_arg0.Inactive:completeAnimation()
			f7_arg0.Inactive:setAlpha(0)
			f7_local2(f7_arg0.Inactive)
		end,
	},
}
CoD.AmmoWidget_HeroEmpty.__onClose = function(f20_arg0)
	f20_arg0.ImgIcon:close()
	f20_arg0.ImgIconGrow:close()
end
