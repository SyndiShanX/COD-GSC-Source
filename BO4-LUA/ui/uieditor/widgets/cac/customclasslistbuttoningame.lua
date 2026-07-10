require("x64:eeba57f916954d1")
CoD.CustomClassListButtonInGame = InheritFrom(LUI.UIElement)
CoD.CustomClassListButtonInGame.__defaultWidth = 56
CoD.CustomClassListButtonInGame.__defaultHeight = 56
CoD.CustomClassListButtonInGame.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CustomClassListButtonInGame)
	self.id = "CustomClassListButtonInGame"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local backgroundBlur = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	backgroundBlur:setRGB(0, 0, 0)
	backgroundBlur:setScale(0.8, 0.8)
	backgroundBlur:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_E2354BE557C4C7A"))
	backgroundBlur:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(backgroundBlur)
	self.backgroundBlur = backgroundBlur
	local Panel = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Panel:setRGB(0, 0, 0)
	Panel:setAlpha(0.9)
	Panel:setScale(0.8, 0.8)
	self:addElement(Panel)
	self.Panel = Panel
	local LED = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	LED:setRGB(0.77, 0.77, 0.77)
	LED:setAlpha(0.02)
	LED:setScale(1.4, 1.4)
	LED:setImage(RegisterImage(@"hash_133C450A6E985AAC"))
	self:addElement(LED)
	self.LED = LED
	local Frame = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Frame:setScale(1.25, 1.25)
	Frame:setImage(RegisterImage(@"hash_46BBB6966B2A83CE"))
	self:addElement(Frame)
	self.Frame = Frame
	local Equipped = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Equipped:setAlpha(0)
	Equipped:setImage(RegisterImage(@"hash_58D73658E1267A41"))
	Equipped:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(Equipped)
	self.Equipped = Equipped
	local classNumber = LUI.UIText.new(0, 1, 0, 0, 0.5, 0.5, -19.5, 17.5)
	classNumber:setRGB(0.63, 0.62, 0.61)
	classNumber:setTTF("ttmussels_demibold")
	classNumber:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_171E049B161CD00A"))
	classNumber:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	classNumber:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	classNumber:linkToElementModel(self, "classNumber", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			classNumber:setText(StringAdd(1, f2_local0))
		end
	end)
	self:addElement(classNumber)
	self.classNumber = classNumber
	local caclock = CoD.cac_lock.new(f1_arg0, f1_arg1, 0, 0, 8, 56, 0, 0, 7, 55)
	caclock:setAlpha(0)
	self:addElement(caclock)
	self.caclock = caclock
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CustomClassListButtonInGame.__resetProperties = function(f3_arg0)
	f3_arg0.classNumber:completeAnimation()
	f3_arg0.backgroundBlur:completeAnimation()
	f3_arg0.Equipped:completeAnimation()
	f3_arg0.caclock:completeAnimation()
	f3_arg0.classNumber:setLeftRight(0, 1, 0, 0)
	f3_arg0.classNumber:setTopBottom(0.5, 0.5, -19.5, 17.5)
	f3_arg0.classNumber:setRGB(0.63, 0.62, 0.61)
	f3_arg0.classNumber:setAlpha(1)
	f3_arg0.backgroundBlur:setLeftRight(0, 1, 0, 0)
	f3_arg0.backgroundBlur:setRGB(0, 0, 0)
	f3_arg0.backgroundBlur:setAlpha(1)
	f3_arg0.Equipped:setAlpha(0)
	f3_arg0.caclock:setLeftRight(0, 0, 8, 56)
	f3_arg0.caclock:setTopBottom(0, 0, 7, 55)
	f3_arg0.caclock:setRGB(1, 1, 1)
	f3_arg0.caclock:setAlpha(0)
end
CoD.CustomClassListButtonInGame.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(0)
		end,
		Over = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			local f5_local0 = function(f6_arg0)
				f5_arg0.classNumber:beginAnimation(150)
				f5_arg0.classNumber:setLeftRight(0.5, 0.5, -35.5, 33.5)
				f5_arg0.classNumber:setRGB(0.92, 0.89, 0.72)
				f5_arg0.classNumber:registerEventHandler("interrupted_keyframe", f5_arg0.clipInterrupted)
				f5_arg0.classNumber:registerEventHandler("transition_complete_keyframe", f5_arg0.clipFinished)
			end
			f5_arg0.classNumber:completeAnimation()
			f5_arg0.classNumber:setLeftRight(0.5, 0.5, -33.5, 35.5)
			f5_arg0.classNumber:setTopBottom(0.5, 0.5, -19.5, 17.5)
			f5_arg0.classNumber:setRGB(0.63, 0.62, 0.61)
			f5_local0(f5_arg0.classNumber)
		end,
		LoseOver = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			local f7_local0 = function(f8_arg0)
				f7_arg0.classNumber:beginAnimation(150)
				f7_arg0.classNumber:setLeftRight(0.5, 0.5, -33.5, 35.5)
				f7_arg0.classNumber:setRGB(0.63, 0.62, 0.61)
				f7_arg0.classNumber:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.classNumber:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
			end
			f7_arg0.classNumber:completeAnimation()
			f7_arg0.classNumber:setLeftRight(0.5, 0.5, -35.5, 33.5)
			f7_arg0.classNumber:setTopBottom(0.5, 0.5, -19.5, 17.5)
			f7_arg0.classNumber:setRGB(0.92, 0.89, 0.72)
			f7_local0(f7_arg0.classNumber)
		end,
		StaggeredIntro = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(2)
			local f9_local0 = function(f10_arg0)
				local f10_local0 = function(f11_arg0)
					f11_arg0:beginAnimation(10)
					f11_arg0:setAlpha(0.8)
					f11_arg0:registerEventHandler("transition_complete_keyframe", f9_arg0.clipFinished)
				end
				f9_arg0.backgroundBlur:beginAnimation(160)
				f9_arg0.backgroundBlur:registerEventHandler("interrupted_keyframe", f9_arg0.clipInterrupted)
				f9_arg0.backgroundBlur:registerEventHandler("transition_complete_keyframe", f10_local0)
			end
			f9_arg0.backgroundBlur:completeAnimation()
			f9_arg0.backgroundBlur:setLeftRight(0, 1, 0, 0)
			f9_arg0.backgroundBlur:setRGB(0, 0, 0)
			f9_arg0.backgroundBlur:setAlpha(0)
			f9_local0(f9_arg0.backgroundBlur)
			local f9_local1 = function(f12_arg0)
				local f12_local0 = function(f13_arg0)
					f13_arg0:beginAnimation(150)
					f13_arg0:setAlpha(1)
					f13_arg0:registerEventHandler("transition_complete_keyframe", f9_arg0.clipFinished)
				end
				f9_arg0.classNumber:beginAnimation(340)
				f9_arg0.classNumber:registerEventHandler("interrupted_keyframe", f9_arg0.clipInterrupted)
				f9_arg0.classNumber:registerEventHandler("transition_complete_keyframe", f12_local0)
			end
			f9_arg0.classNumber:completeAnimation()
			f9_arg0.classNumber:setLeftRight(0.5, 0.5, -33.5, 35.5)
			f9_arg0.classNumber:setAlpha(0)
			f9_local1(f9_arg0.classNumber)
		end,
		Focus = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(1)
			local f14_local0 = function(f15_arg0)
				f14_arg0.classNumber:beginAnimation(150)
				f14_arg0.classNumber:setLeftRight(0.5, 0.5, -35.5, 33.5)
				f14_arg0.classNumber:setRGB(0.92, 0.89, 0.72)
				f14_arg0.classNumber:registerEventHandler("interrupted_keyframe", f14_arg0.clipInterrupted)
				f14_arg0.classNumber:registerEventHandler("transition_complete_keyframe", f14_arg0.clipFinished)
			end
			f14_arg0.classNumber:completeAnimation()
			f14_arg0.classNumber:setLeftRight(0.5, 0.5, -33.5, 35.5)
			f14_arg0.classNumber:setTopBottom(0.5, 0.5, -19.5, 17.5)
			f14_arg0.classNumber:setRGB(0.63, 0.62, 0.61)
			f14_local0(f14_arg0.classNumber)
		end,
	},
	Equipped = {
		DefaultClip = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(2)
			local f16_local0 = function(f17_arg0)
				f16_arg0.Equipped:beginAnimation(200)
				f16_arg0.Equipped:setAlpha(0.9)
				f16_arg0.Equipped:registerEventHandler("interrupted_keyframe", f16_arg0.clipInterrupted)
				f16_arg0.Equipped:registerEventHandler("transition_complete_keyframe", f16_arg0.clipFinished)
			end
			f16_arg0.Equipped:completeAnimation()
			f16_arg0.Equipped:setAlpha(0)
			f16_local0(f16_arg0.Equipped)
			local f16_local1 = function(f18_arg0)
				f16_arg0.classNumber:beginAnimation(200)
				f16_arg0.classNumber:setRGB(1, 1, 1)
				f16_arg0.classNumber:registerEventHandler("interrupted_keyframe", f16_arg0.clipInterrupted)
				f16_arg0.classNumber:registerEventHandler("transition_complete_keyframe", f16_arg0.clipFinished)
			end
			f16_arg0.classNumber:completeAnimation()
			f16_arg0.classNumber:setRGB(0.63, 0.62, 0.61)
			f16_local1(f16_arg0.classNumber)
		end,
		Active = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(1)
			local f19_local0 = function(f20_arg0)
				f19_arg0.classNumber:beginAnimation(150)
				f19_arg0.classNumber:setRGB(0.16, 0.16, 0.15)
				f19_arg0.classNumber:registerEventHandler("interrupted_keyframe", f19_arg0.clipInterrupted)
				f19_arg0.classNumber:registerEventHandler("transition_complete_keyframe", f19_arg0.clipFinished)
			end
			f19_arg0.classNumber:completeAnimation()
			f19_arg0.classNumber:setLeftRight(0.5, 0.5, -35.5, 33.5)
			f19_arg0.classNumber:setTopBottom(0.5, 0.5, -19.5, 17.5)
			f19_arg0.classNumber:setRGB(0.92, 0.89, 0.72)
			f19_local0(f19_arg0.classNumber)
		end,
		StaggeredIntro = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(2)
			local f21_local0 = function(f22_arg0)
				local f22_local0 = function(f23_arg0)
					f23_arg0:beginAnimation(10)
					f23_arg0:setAlpha(0.8)
					f23_arg0:registerEventHandler("transition_complete_keyframe", f21_arg0.clipFinished)
				end
				f21_arg0.backgroundBlur:beginAnimation(160)
				f21_arg0.backgroundBlur:registerEventHandler("interrupted_keyframe", f21_arg0.clipInterrupted)
				f21_arg0.backgroundBlur:registerEventHandler("transition_complete_keyframe", f22_local0)
			end
			f21_arg0.backgroundBlur:completeAnimation()
			f21_arg0.backgroundBlur:setLeftRight(0, 1, 0, 0)
			f21_arg0.backgroundBlur:setRGB(0, 0, 0)
			f21_arg0.backgroundBlur:setAlpha(0)
			f21_local0(f21_arg0.backgroundBlur)
			local f21_local1 = function(f24_arg0)
				local f24_local0 = function(f25_arg0)
					f25_arg0:beginAnimation(150)
					f25_arg0:setAlpha(1)
					f25_arg0:registerEventHandler("transition_complete_keyframe", f21_arg0.clipFinished)
				end
				f21_arg0.classNumber:beginAnimation(340)
				f21_arg0.classNumber:registerEventHandler("interrupted_keyframe", f21_arg0.clipInterrupted)
				f21_arg0.classNumber:registerEventHandler("transition_complete_keyframe", f24_local0)
			end
			f21_arg0.classNumber:completeAnimation()
			f21_arg0.classNumber:setLeftRight(0.5, 0.5, -35.5, 33.5)
			f21_arg0.classNumber:setRGB(0.16, 0.16, 0.15)
			f21_arg0.classNumber:setAlpha(0)
			f21_local1(f21_arg0.classNumber)
		end,
		Focus = function(f26_arg0, f26_arg1)
			f26_arg0:__resetProperties()
			f26_arg0:setupElementClipCounter(1)
			local f26_local0 = function(f27_arg0)
				f26_arg0.classNumber:beginAnimation(150)
				f26_arg0.classNumber:setRGB(0.16, 0.16, 0.15)
				f26_arg0.classNumber:registerEventHandler("interrupted_keyframe", f26_arg0.clipInterrupted)
				f26_arg0.classNumber:registerEventHandler("transition_complete_keyframe", f26_arg0.clipFinished)
			end
			f26_arg0.classNumber:completeAnimation()
			f26_arg0.classNumber:setLeftRight(0.5, 0.5, -35.5, 33.5)
			f26_arg0.classNumber:setTopBottom(0.5, 0.5, -19.5, 17.5)
			f26_arg0.classNumber:setRGB(0.92, 0.89, 0.72)
			f26_local0(f26_arg0.classNumber)
		end,
	},
	Locked = {
		DefaultClip = function(f28_arg0, f28_arg1)
			f28_arg0:__resetProperties()
			f28_arg0:setupElementClipCounter(2)
			f28_arg0.classNumber:completeAnimation()
			f28_arg0.classNumber:setAlpha(0.5)
			f28_arg0.clipFinished(f28_arg0.classNumber)
			f28_arg0.caclock:completeAnimation()
			f28_arg0.caclock:setLeftRight(0, 0, 40, 56)
			f28_arg0.caclock:setTopBottom(0, 0, 8, 23)
			f28_arg0.caclock:setRGB(1, 0.99, 0.99)
			f28_arg0.caclock:setAlpha(0.5)
			f28_arg0.clipFinished(f28_arg0.caclock)
		end,
	},
}
if not CoD.isPC then
	CoD.CustomClassListButtonInGame.__clipsPerState.DefaultState.Focus = nil
	CoD.CustomClassListButtonInGame.__clipsPerState.Equipped.Focus = nil
end
CoD.CustomClassListButtonInGame.__onClose = function(f29_arg0)
	f29_arg0.classNumber:close()
	f29_arg0.caclock:close()
end
