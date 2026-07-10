CoD.AmmoWidgetWZ_EquipmentEmpty = InheritFrom(LUI.UIElement)
CoD.AmmoWidgetWZ_EquipmentEmpty.__defaultWidth = 64
CoD.AmmoWidgetWZ_EquipmentEmpty.__defaultHeight = 59
CoD.AmmoWidgetWZ_EquipmentEmpty.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.AmmoWidgetWZ_EquipmentEmpty)
	self.id = "AmmoWidgetWZ_EquipmentEmpty"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ImgIcon = LUI.UIImage.new(0.5, 0.5, -40, 40, 0.5, 0.5, -40, 40)
	ImgIcon:setRGB(1, 0, 0)
	ImgIcon:setAlpha(0.31)
	ImgIcon:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	ImgIcon:linkToElementModel(self, "image", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			ImgIcon:setImage(RegisterImage(f2_local0))
		end
	end)
	self:addElement(ImgIcon)
	self.ImgIcon = ImgIcon
	local ImgIconGrow = LUI.UIImage.new(0.5, 0.5, -40, 40, 0.5, 0.5, -41, 39)
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
	local Inactive = LUI.UIImage.new(0.5, 0.5, -26, 26, 0.5, 0.5, -24.5, 22.5)
	Inactive:setRGB(0.88, 0.07, 0.07)
	Inactive:setAlpha(0.25)
	Inactive:setScale(1.4, 1.4)
	Inactive:setImage(RegisterImage(0x8440A4FA2F1A6DC))
	self:addElement(Inactive)
	self.Inactive = Inactive
	self:mergeStateConditions({
		{
			stateName = "IconHidden",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	self:linkToElementModel(self, "pulseEmpty", true, function(model)
		local f5_local0 = self
		PlayClip(self, "Empty", f1_arg1)
	end)
	self:subscribeToGlobalModel(f1_arg1, "PerController", "HUDItems.pulseNoTactical", function(model)
		local f6_local0 = self
		if IsSelfPropertyValue(self, "show_empty_health_flash", true) and CoD.ModelUtility.IsGlobalDataSourceModelValueGreaterThan(f1_arg1, "HUDItems", "pulseNoTactical", 0) then
			PlayClip(self, "Empty", f1_arg1)
		end
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.AmmoWidgetWZ_EquipmentEmpty.__resetProperties = function(f7_arg0)
	f7_arg0.ImgIconGrow:completeAnimation()
	f7_arg0.ImgIcon:completeAnimation()
	f7_arg0.Inactive:completeAnimation()
	f7_arg0.ImgIconGrow:setLeftRight(0.5, 0.5, -40, 40)
	f7_arg0.ImgIconGrow:setTopBottom(0.5, 0.5, -41, 39)
	f7_arg0.ImgIconGrow:setAlpha(0.31)
	f7_arg0.ImgIconGrow:setScale(1, 1)
	f7_arg0.ImgIcon:setLeftRight(0.5, 0.5, -40, 40)
	f7_arg0.ImgIcon:setTopBottom(0.5, 0.5, -40, 40)
	f7_arg0.ImgIcon:setAlpha(0.31)
	f7_arg0.Inactive:setAlpha(0.25)
end
CoD.AmmoWidgetWZ_EquipmentEmpty.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(3)
			f8_arg0.ImgIcon:completeAnimation()
			f8_arg0.ImgIcon:setLeftRight(0.5, 0.5, -20, 19)
			f8_arg0.ImgIcon:setTopBottom(0.5, 0.5, -20, 19)
			f8_arg0.ImgIcon:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.ImgIcon)
			f8_arg0.ImgIconGrow:completeAnimation()
			f8_arg0.ImgIconGrow:setLeftRight(0.5, 0.5, -20, 19)
			f8_arg0.ImgIconGrow:setTopBottom(0.5, 0.5, -20, 19)
			f8_arg0.ImgIconGrow:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.ImgIconGrow)
			f8_arg0.Inactive:completeAnimation()
			f8_arg0.Inactive:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.Inactive)
		end,
		Empty = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(3)
			local f9_local0 = function(f10_arg0)
				f9_arg0.ImgIcon:beginAnimation(350)
				f9_arg0.ImgIcon:setAlpha(0)
				f9_arg0.ImgIcon:registerEventHandler("interrupted_keyframe", f9_arg0.clipInterrupted)
				f9_arg0.ImgIcon:registerEventHandler("transition_complete_keyframe", f9_arg0.clipFinished)
			end
			f9_arg0.ImgIcon:completeAnimation()
			f9_arg0.ImgIcon:setAlpha(0.5)
			f9_local0(f9_arg0.ImgIcon)
			local f9_local1 = function(f11_arg0)
				f9_arg0.ImgIconGrow:beginAnimation(350)
				f9_arg0.ImgIconGrow:setAlpha(0)
				f9_arg0.ImgIconGrow:setScale(1.5, 1.5)
				f9_arg0.ImgIconGrow:registerEventHandler("interrupted_keyframe", f9_arg0.clipInterrupted)
				f9_arg0.ImgIconGrow:registerEventHandler("transition_complete_keyframe", f9_arg0.clipFinished)
			end
			f9_arg0.ImgIconGrow:completeAnimation()
			f9_arg0.ImgIconGrow:setAlpha(0.25)
			f9_arg0.ImgIconGrow:setScale(1, 1)
			f9_local1(f9_arg0.ImgIconGrow)
			local f9_local2 = function(f12_arg0)
				local f12_local0 = function(f13_arg0)
					local f13_local0 = function(f14_arg0)
						local f14_local0 = function(f15_arg0)
							local f15_local0 = function(f16_arg0)
								local f16_local0 = function(f17_arg0)
									local f17_local0 = function(f18_arg0)
										local f18_local0 = function(f19_arg0)
											local f19_local0 = function(f20_arg0)
												local f20_local0 = function(f21_arg0)
													f21_arg0:beginAnimation(210)
													f21_arg0:setAlpha(0)
													f21_arg0:registerEventHandler("transition_complete_keyframe", f9_arg0.clipFinished)
												end
												f20_arg0:beginAnimation(10)
												f20_arg0:setAlpha(0.76)
												f20_arg0:registerEventHandler("transition_complete_keyframe", f20_local0)
											end
											f19_arg0:beginAnimation(19)
											f19_arg0:setAlpha(0.5)
											f19_arg0:registerEventHandler("transition_complete_keyframe", f19_local0)
										end
										f18_arg0:beginAnimation(9)
										f18_arg0:setAlpha(0.51)
										f18_arg0:registerEventHandler("transition_complete_keyframe", f18_local0)
									end
									f17_arg0:beginAnimation(30)
									f17_arg0:registerEventHandler("transition_complete_keyframe", f17_local0)
								end
								f16_arg0:beginAnimation(10)
								f16_arg0:setAlpha(0.75)
								f16_arg0:registerEventHandler("transition_complete_keyframe", f16_local0)
							end
							f15_arg0:beginAnimation(20)
							f15_arg0:setAlpha(0.11)
							f15_arg0:registerEventHandler("transition_complete_keyframe", f15_local0)
						end
						f14_arg0:beginAnimation(10)
						f14_arg0:setAlpha(0)
						f14_arg0:registerEventHandler("transition_complete_keyframe", f14_local0)
					end
					f13_arg0:beginAnimation(20)
					f13_arg0:setAlpha(0.71)
					f13_arg0:registerEventHandler("transition_complete_keyframe", f13_local0)
				end
				f9_arg0.Inactive:beginAnimation(10)
				f9_arg0.Inactive:setAlpha(0.75)
				f9_arg0.Inactive:registerEventHandler("interrupted_keyframe", f9_arg0.clipInterrupted)
				f9_arg0.Inactive:registerEventHandler("transition_complete_keyframe", f12_local0)
			end
			f9_arg0.Inactive:completeAnimation()
			f9_arg0.Inactive:setAlpha(0)
			f9_local2(f9_arg0.Inactive)
		end,
	},
	IconHidden = {
		DefaultClip = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(3)
			f22_arg0.ImgIcon:completeAnimation()
			f22_arg0.ImgIcon:setLeftRight(0.5, 0.5, -20, 19)
			f22_arg0.ImgIcon:setTopBottom(0.5, 0.5, -20, 19)
			f22_arg0.ImgIcon:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.ImgIcon)
			f22_arg0.ImgIconGrow:completeAnimation()
			f22_arg0.ImgIconGrow:setLeftRight(0.5, 0.5, -20, 19)
			f22_arg0.ImgIconGrow:setTopBottom(0.5, 0.5, -20, 19)
			f22_arg0.ImgIconGrow:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.ImgIconGrow)
			f22_arg0.Inactive:completeAnimation()
			f22_arg0.Inactive:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.Inactive)
		end,
		Empty = function(f23_arg0, f23_arg1)
			f23_arg0:__resetProperties()
			f23_arg0:setupElementClipCounter(3)
			f23_arg0.ImgIcon:completeAnimation()
			f23_arg0.ImgIcon:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.ImgIcon)
			f23_arg0.ImgIconGrow:completeAnimation()
			f23_arg0.ImgIconGrow:setAlpha(0)
			f23_arg0.ImgIconGrow:setScale(1, 1)
			f23_arg0.clipFinished(f23_arg0.ImgIconGrow)
			local f23_local0 = function(f24_arg0)
				local f24_local0 = function(f25_arg0)
					local f25_local0 = function(f26_arg0)
						local f26_local0 = function(f27_arg0)
							local f27_local0 = function(f28_arg0)
								local f28_local0 = function(f29_arg0)
									local f29_local0 = function(f30_arg0)
										local f30_local0 = function(f31_arg0)
											local f31_local0 = function(f32_arg0)
												local f32_local0 = function(f33_arg0)
													f33_arg0:beginAnimation(210)
													f33_arg0:setAlpha(0)
													f33_arg0:registerEventHandler("transition_complete_keyframe", f23_arg0.clipFinished)
												end
												f32_arg0:beginAnimation(10)
												f32_arg0:setAlpha(0.76)
												f32_arg0:registerEventHandler("transition_complete_keyframe", f32_local0)
											end
											f31_arg0:beginAnimation(19)
											f31_arg0:setAlpha(0.5)
											f31_arg0:registerEventHandler("transition_complete_keyframe", f31_local0)
										end
										f30_arg0:beginAnimation(9)
										f30_arg0:setAlpha(0.51)
										f30_arg0:registerEventHandler("transition_complete_keyframe", f30_local0)
									end
									f29_arg0:beginAnimation(30)
									f29_arg0:registerEventHandler("transition_complete_keyframe", f29_local0)
								end
								f28_arg0:beginAnimation(10)
								f28_arg0:setAlpha(0.75)
								f28_arg0:registerEventHandler("transition_complete_keyframe", f28_local0)
							end
							f27_arg0:beginAnimation(20)
							f27_arg0:setAlpha(0.11)
							f27_arg0:registerEventHandler("transition_complete_keyframe", f27_local0)
						end
						f26_arg0:beginAnimation(10)
						f26_arg0:setAlpha(0)
						f26_arg0:registerEventHandler("transition_complete_keyframe", f26_local0)
					end
					f25_arg0:beginAnimation(20)
					f25_arg0:setAlpha(0.71)
					f25_arg0:registerEventHandler("transition_complete_keyframe", f25_local0)
				end
				f23_arg0.Inactive:beginAnimation(10)
				f23_arg0.Inactive:setAlpha(0.75)
				f23_arg0.Inactive:registerEventHandler("interrupted_keyframe", f23_arg0.clipInterrupted)
				f23_arg0.Inactive:registerEventHandler("transition_complete_keyframe", f24_local0)
			end
			f23_arg0.Inactive:completeAnimation()
			f23_arg0.Inactive:setAlpha(0)
			f23_local0(f23_arg0.Inactive)
		end,
	},
}
CoD.AmmoWidgetWZ_EquipmentEmpty.__onClose = function(f34_arg0)
	f34_arg0.ImgIcon:close()
	f34_arg0.ImgIconGrow:close()
end
