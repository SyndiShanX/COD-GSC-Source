CoD.TabletIcePickGadget_ItemIcon = InheritFrom(LUI.UIElement)
CoD.TabletIcePickGadget_ItemIcon.__defaultWidth = 144
CoD.TabletIcePickGadget_ItemIcon.__defaultHeight = 144
CoD.TabletIcePickGadget_ItemIcon.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.TabletIcePickGadget_ItemIcon)
	self.id = "TabletIcePickGadget_ItemIcon"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local SpecialistImage = LUI.UIFixedAspectRatioImage.new(0.5, 0.5, -68, 68, 1, 1, -136, 0)
	SpecialistImage:setRGB(0.22, 0.77, 1)
	SpecialistImage:linkToElementModel(self, "hackableId", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			SpecialistImage:setImage(RegisterImage(GetPositionDraftIconByIndex(CoD.CodCasterUtility.CharacterIndexForClientNum(f1_arg1, f2_local0))))
		end
	end)
	self:addElement(SpecialistImage)
	self.SpecialistImage = SpecialistImage
	local SpecialistImageScan = LUI.UIFixedAspectRatioImage.new(0.5, 0.5, -68, 68, 1, 1, -136, 0)
	SpecialistImageScan:setRGB(0.22, 0.77, 1)
	SpecialistImageScan:setAlpha(0.6)
	SpecialistImageScan:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_scanlines"))
	SpecialistImageScan:setShaderVector(0, 2, 0, 0, 0)
	SpecialistImageScan:setShaderVector(1, 2, 0, 0, 0)
	SpecialistImageScan:setShaderVector(2, 0.02, 0, 0, 0)
	SpecialistImageScan:linkToElementModel(self, "hackableId", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			SpecialistImageScan:setImage(RegisterImage(GetPositionDraftIconByIndex(CoD.CodCasterUtility.CharacterIndexForClientNum(f1_arg1, f3_local0))))
		end
	end)
	self:addElement(SpecialistImageScan)
	self.SpecialistImageScan = SpecialistImageScan
	local NonSpecialistImage = LUI.UIFixedAspectRatioImage.new(0.5, 0.5, -72, 72, 0, 0, 0, 144)
	NonSpecialistImage:setRGB(0.22, 0.77, 1)
	NonSpecialistImage:linkToElementModel(self, "hackableItemIndex", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			NonSpecialistImage:setImage(RegisterImage(CoD.CACUtility.GetItemImageFromIndex(f1_arg0, Enum[@"statindexoffset"][@"hash_6569E84652131CD7"], f4_local0)))
		end
	end)
	self:addElement(NonSpecialistImage)
	self.NonSpecialistImage = NonSpecialistImage
	local NonSpecialistImageScan = LUI.UIFixedAspectRatioImage.new(0.5, 0.5, -72, 72, 0, 0, 0, 144)
	NonSpecialistImageScan:setRGB(0.22, 0.77, 1)
	NonSpecialistImageScan:setAlpha(0.6)
	NonSpecialistImageScan:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_scanlines"))
	NonSpecialistImageScan:setShaderVector(0, 2, 0, 0, 0)
	NonSpecialistImageScan:setShaderVector(1, 2, 0, 0, 0)
	NonSpecialistImageScan:setShaderVector(2, 0.02, 0, 0, 0)
	NonSpecialistImageScan:linkToElementModel(self, "hackableItemIndex", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			NonSpecialistImageScan:setImage(RegisterImage(CoD.CACUtility.GetItemImageFromIndex(f1_arg0, Enum[@"statindexoffset"][@"hash_6569E84652131CD7"], f5_local0)))
		end
	end)
	self:addElement(NonSpecialistImageScan)
	self.NonSpecialistImageScan = NonSpecialistImageScan
	self:mergeStateConditions({
		{
			stateName = "NonSpecialist",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, f1_arg1, "hackableCategory", CoD.HUDUtility.IcePickCategories.PLAYER)
			end,
		},
	})
	self:linkToElementModel(self, "hackableCategory", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "hackableCategory",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.TabletIcePickGadget_ItemIcon.__resetProperties = function(f8_arg0)
	f8_arg0.NonSpecialistImage:completeAnimation()
	f8_arg0.SpecialistImage:completeAnimation()
	f8_arg0.NonSpecialistImageScan:completeAnimation()
	f8_arg0.SpecialistImageScan:completeAnimation()
	f8_arg0.NonSpecialistImage:setAlpha(1)
	f8_arg0.SpecialistImage:setAlpha(1)
	f8_arg0.NonSpecialistImageScan:setAlpha(0.6)
	f8_arg0.SpecialistImageScan:setAlpha(0.6)
end
CoD.TabletIcePickGadget_ItemIcon.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(4)
			local f9_local0 = function(f10_arg0)
				f9_arg0.SpecialistImage:beginAnimation(120)
				f9_arg0.SpecialistImage:setAlpha(1)
				f9_arg0.SpecialistImage:registerEventHandler("interrupted_keyframe", f9_arg0.clipInterrupted)
				f9_arg0.SpecialistImage:registerEventHandler("transition_complete_keyframe", f9_arg0.clipFinished)
			end
			f9_arg0.SpecialistImage:completeAnimation()
			f9_arg0.SpecialistImage:setAlpha(0)
			f9_local0(f9_arg0.SpecialistImage)
			local f9_local1 = function(f11_arg0)
				local f11_local0 = function(f12_arg0)
					local f12_local0 = function(f13_arg0)
						local f13_local0 = function(f14_arg0)
							local f14_local0 = function(f15_arg0)
								local f15_local0 = function(f16_arg0)
									local f16_local0 = function(f17_arg0)
										f17_arg0:beginAnimation(49)
										f17_arg0:setAlpha(0.6)
										f17_arg0:registerEventHandler("transition_complete_keyframe", f9_arg0.clipFinished)
									end
									f16_arg0:beginAnimation(19)
									f16_arg0:setAlpha(0.1)
									f16_arg0:registerEventHandler("transition_complete_keyframe", f16_local0)
								end
								f15_arg0:beginAnimation(20)
								f15_arg0:setAlpha(0.6)
								f15_arg0:registerEventHandler("transition_complete_keyframe", f15_local0)
							end
							f14_arg0:beginAnimation(19)
							f14_arg0:setAlpha(0.1)
							f14_arg0:registerEventHandler("transition_complete_keyframe", f14_local0)
						end
						f13_arg0:beginAnimation(20)
						f13_arg0:setAlpha(0.6)
						f13_arg0:registerEventHandler("transition_complete_keyframe", f13_local0)
					end
					f12_arg0:beginAnimation(19)
					f12_arg0:setAlpha(0.1)
					f12_arg0:registerEventHandler("transition_complete_keyframe", f12_local0)
				end
				f9_arg0.SpecialistImageScan:beginAnimation(100)
				f9_arg0.SpecialistImageScan:setAlpha(0.6)
				f9_arg0.SpecialistImageScan:registerEventHandler("interrupted_keyframe", f9_arg0.clipInterrupted)
				f9_arg0.SpecialistImageScan:registerEventHandler("transition_complete_keyframe", f11_local0)
			end
			f9_arg0.SpecialistImageScan:completeAnimation()
			f9_arg0.SpecialistImageScan:setAlpha(0)
			f9_local1(f9_arg0.SpecialistImageScan)
			f9_arg0.NonSpecialistImage:completeAnimation()
			f9_arg0.NonSpecialistImage:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.NonSpecialistImage)
			f9_arg0.NonSpecialistImageScan:completeAnimation()
			f9_arg0.NonSpecialistImageScan:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.NonSpecialistImageScan)
		end,
	},
	NonSpecialist = {
		DefaultClip = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(4)
			f18_arg0.SpecialistImage:completeAnimation()
			f18_arg0.SpecialistImage:setAlpha(0)
			f18_arg0.clipFinished(f18_arg0.SpecialistImage)
			f18_arg0.SpecialistImageScan:completeAnimation()
			f18_arg0.SpecialistImageScan:setAlpha(0)
			f18_arg0.clipFinished(f18_arg0.SpecialistImageScan)
			local f18_local0 = function(f19_arg0)
				local f19_local0 = function(f20_arg0)
					local f20_local0 = function(f21_arg0)
						local f21_local0 = function(f22_arg0)
							local f22_local0 = function(f23_arg0)
								local f23_local0 = function(f24_arg0)
									local f24_local0 = function(f25_arg0)
										f25_arg0:beginAnimation(49)
										f25_arg0:setAlpha(1)
										f25_arg0:registerEventHandler("transition_complete_keyframe", f18_arg0.clipFinished)
									end
									f24_arg0:beginAnimation(19)
									f24_arg0:setAlpha(0.4)
									f24_arg0:registerEventHandler("transition_complete_keyframe", f24_local0)
								end
								f23_arg0:beginAnimation(20)
								f23_arg0:setAlpha(1)
								f23_arg0:registerEventHandler("transition_complete_keyframe", f23_local0)
							end
							f22_arg0:beginAnimation(19)
							f22_arg0:setAlpha(0.4)
							f22_arg0:registerEventHandler("transition_complete_keyframe", f22_local0)
						end
						f21_arg0:beginAnimation(20)
						f21_arg0:setAlpha(0.9)
						f21_arg0:registerEventHandler("transition_complete_keyframe", f21_local0)
					end
					f20_arg0:beginAnimation(19)
					f20_arg0:setAlpha(0.4)
					f20_arg0:registerEventHandler("transition_complete_keyframe", f20_local0)
				end
				f18_arg0.NonSpecialistImage:beginAnimation(100)
				f18_arg0.NonSpecialistImage:setAlpha(1)
				f18_arg0.NonSpecialistImage:registerEventHandler("interrupted_keyframe", f18_arg0.clipInterrupted)
				f18_arg0.NonSpecialistImage:registerEventHandler("transition_complete_keyframe", f19_local0)
			end
			f18_arg0.NonSpecialistImage:completeAnimation()
			f18_arg0.NonSpecialistImage:setAlpha(0)
			f18_local0(f18_arg0.NonSpecialistImage)
			local f18_local1 = function(f26_arg0)
				local f26_local0 = function(f27_arg0)
					local f27_local0 = function(f28_arg0)
						local f28_local0 = function(f29_arg0)
							local f29_local0 = function(f30_arg0)
								local f30_local0 = function(f31_arg0)
									local f31_local0 = function(f32_arg0)
										f32_arg0:beginAnimation(49)
										f32_arg0:setAlpha(0.6)
										f32_arg0:registerEventHandler("transition_complete_keyframe", f18_arg0.clipFinished)
									end
									f31_arg0:beginAnimation(19)
									f31_arg0:setAlpha(0.1)
									f31_arg0:registerEventHandler("transition_complete_keyframe", f31_local0)
								end
								f30_arg0:beginAnimation(20)
								f30_arg0:setAlpha(0.6)
								f30_arg0:registerEventHandler("transition_complete_keyframe", f30_local0)
							end
							f29_arg0:beginAnimation(19)
							f29_arg0:setAlpha(0.1)
							f29_arg0:registerEventHandler("transition_complete_keyframe", f29_local0)
						end
						f28_arg0:beginAnimation(20)
						f28_arg0:setAlpha(1)
						f28_arg0:registerEventHandler("transition_complete_keyframe", f28_local0)
					end
					f27_arg0:beginAnimation(19)
					f27_arg0:setAlpha(0.1)
					f27_arg0:registerEventHandler("transition_complete_keyframe", f27_local0)
				end
				f18_arg0.NonSpecialistImageScan:beginAnimation(100)
				f18_arg0.NonSpecialistImageScan:setAlpha(0.6)
				f18_arg0.NonSpecialistImageScan:registerEventHandler("interrupted_keyframe", f18_arg0.clipInterrupted)
				f18_arg0.NonSpecialistImageScan:registerEventHandler("transition_complete_keyframe", f26_local0)
			end
			f18_arg0.NonSpecialistImageScan:completeAnimation()
			f18_arg0.NonSpecialistImageScan:setAlpha(0)
			f18_local1(f18_arg0.NonSpecialistImageScan)
		end,
	},
}
CoD.TabletIcePickGadget_ItemIcon.__onClose = function(f33_arg0)
	f33_arg0.SpecialistImage:close()
	f33_arg0.SpecialistImageScan:close()
	f33_arg0.NonSpecialistImage:close()
	f33_arg0.NonSpecialistImageScan:close()
end
