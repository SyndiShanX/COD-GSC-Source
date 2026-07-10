require("x64:10239005cc36b68")
require("x64:8a3543a913958f1")
require("x64:c08a2aab18ca343")
require("x64:acbed692442191c")
require("x64:f78acfcbc465bba")
require("x64:a2c4a319ea5353")
CoD.BM_ContractDetailsInternal = InheritFrom(LUI.UIElement)
CoD.BM_ContractDetailsInternal.__defaultWidth = 460
CoD.BM_ContractDetailsInternal.__defaultHeight = 636
CoD.BM_ContractDetailsInternal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.BM_ContractDetailsInternal)
	self.id = "BM_ContractDetailsInternal"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local BottomDarkening = LUI.UIImage.new(0, 0, 0, 460, 1, 1, -139, 0)
	BottomDarkening:setRGB(0, 0, 0)
	BottomDarkening:setAlpha(0.33)
	self:addElement(BottomDarkening)
	self.BottomDarkening = BottomDarkening
	local Art = LUI.UIImage.new(0, 0, 3, 459, 0, 0, 4, 500)
	Art:setImage(RegisterImage(0xA806569052CB2E3))
	Art:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(Art)
	self.Art = Art
	local Backer = LUI.UIImage.new(0.5, 0.5, -58.5, 59.5, 0, 0, 95, 213)
	Backer:setRGB(0.09, 0.09, 0.09)
	Backer:setScale(2.5, 2.5)
	Backer:setMaterial(LUI.UIImage.GetCachedMaterial(0x15B163CA03FCE8B))
	Backer:setShaderVector(0, 40, 10, 0, 0)
	Backer:setShaderVector(1, 100, 100, 0, 0)
	Backer:setShaderVector(2, 0.1, 0.05, 0, 0)
	self:addElement(Backer)
	self.Backer = Backer
	local dashedRing = LUI.UIImage.new(0, 0, 102.5, 358.5, 0, 0, 26.5, 282.5)
	dashedRing:setAlpha(0)
	dashedRing:setScale(1.02, 1.04)
	dashedRing:setImage(RegisterImage(0x9CB47A4FF976C1C))
	self:addElement(dashedRing)
	self.dashedRing = dashedRing
	local CompletedBox = LUI.UIImage.new(0, 0, 15, 447, 0, 0, 13.5, 483.5)
	CompletedBox:setRGB(ColorSet.T8__GREEN.r, ColorSet.T8__GREEN.g, ColorSet.T8__GREEN.b)
	CompletedBox:setAlpha(0)
	self:addElement(CompletedBox)
	self.CompletedBox = CompletedBox
	local PixelGridTiledBacking = LUI.UIImage.new(0, 1, 0, 0, 0, 0, 0, 637)
	PixelGridTiledBacking:setAlpha(0.04)
	PixelGridTiledBacking:setImage(RegisterImage(0x311E811A3183347))
	PixelGridTiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	PixelGridTiledBacking:setShaderVector(0, 0, 0, 0, 0)
	PixelGridTiledBacking:setupNineSliceShader(128, 128)
	self:addElement(PixelGridTiledBacking)
	self.PixelGridTiledBacking = PixelGridTiledBacking
	local ButtonTopLine9Slice = LUI.UIImage.new(0, 0, -6, 466, 0, 0, 489, 509)
	ButtonTopLine9Slice:setAlpha(0.11)
	ButtonTopLine9Slice:setImage(RegisterImage(0xC752149A1FA1AAE))
	ButtonTopLine9Slice:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD777557404A7B3))
	ButtonTopLine9Slice:setShaderVector(0, 0, 0, 0, 0)
	ButtonTopLine9Slice:setupNineSliceShader(120, 10)
	self:addElement(ButtonTopLine9Slice)
	self.ButtonTopLine9Slice = ButtonTopLine9Slice
	local BMContractProgress = CoD.BM_ContractProgress.new(f1_arg0, f1_arg1, 0.5, 0.5, -200, 200, 0, 0, 0, 400)
	BMContractProgress:mergeStateConditions({
		{
			stateName = "Completed",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "completed")
			end,
		},
	})
	BMContractProgress:linkToElementModel(BMContractProgress, "completed", true, function(model)
		f1_arg0:updateElementState(BMContractProgress, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "completed",
		})
	end)
	BMContractProgress:linkToElementModel(self, nil, false, function(model)
		BMContractProgress:setModel(model, f1_arg1)
	end)
	self:addElement(BMContractProgress)
	self.BMContractProgress = BMContractProgress
	local BMActiveContractItemRewardsContainer = CoD.BM_ActiveContractItemRewardsContainer.new(f1_arg0, f1_arg1, 0.5, 0.5, -250, 250, 1, 1, -139, -11)
	BMActiveContractItemRewardsContainer:linkToElementModel(self, nil, false, function(model)
		BMActiveContractItemRewardsContainer:setModel(model, f1_arg1)
	end)
	self:addElement(BMActiveContractItemRewardsContainer)
	self.BMActiveContractItemRewardsContainer = BMActiveContractItemRewardsContainer
	local Name = LUI.UIText.new(0.04, 0.04, 22.5, 402.5, 0, 0, 377.5, 409.5)
	Name:setRGB(ColorSet.T8__OCHRE.r, ColorSet.T8__OCHRE.g, ColorSet.T8__OCHRE.b)
	Name:setTTF("ttmussels_demibold")
	Name:setLetterSpacing(2)
	Name:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	Name:setAlignment(Enum[0x7A5123B654282D2][0x70510683C22104B])
	Name:linkToElementModel(self, "displayName", true, function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			Name:setText(LocalizeToUpperString(f6_local0))
		end
	end)
	self:addElement(Name)
	self.Name = Name
	local Description = LUI.UIText.new(0.05, 0.05, 2, 414, 0, 0, 414, 430)
	Description:setTTF("dinnext_regular")
	Description:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	Description:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	Description:linkToElementModel(self, "description", true, function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			Description:setText(f7_local0)
		end
	end)
	self:addElement(Description)
	self.Description = Description
	local FETitleNumBrdr00 = CoD.FE_TitleNumBrdr.new(f1_arg0, f1_arg1, 0, 0, 15, 447, 0, 0, 13.5, 483.5)
	FETitleNumBrdr00:setAlpha(0.2)
	self:addElement(FETitleNumBrdr00)
	self.FETitleNumBrdr00 = FETitleNumBrdr00
	local Lines = CoD.DirectorSelectButtonLines.new(f1_arg0, f1_arg1, 0, 0, 0, 460, 0, 0, 0, 634)
	Lines:setRGB(0.91, 0.91, 0.91)
	Lines:setAlpha(0.5)
	self:addElement(Lines)
	self.Lines = Lines
	local SelectNewContract = LUI.UIText.new(0.5, 0.5, -215, 215, 0, 0, 294.5, 316.5)
	SelectNewContract:setRGB(0.58, 0.58, 0.58)
	SelectNewContract:setAlpha(0)
	SelectNewContract:setText(LocalizeToUpperString(0xB87969FDAE93020))
	SelectNewContract:setTTF("dinnext_regular")
	SelectNewContract:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	SelectNewContract:setAlignment(Enum[0x7A5123B654282D2][0xE821F0ECFF8D1C7])
	SelectNewContract:setBackingType(1)
	SelectNewContract:setBackingWidget(CoD.CommonCornerPips02, f1_arg0, f1_arg1)
	SelectNewContract:setBackingColor(0.8, 0.8, 0.8)
	SelectNewContract:setBackingXPadding(12)
	SelectNewContract:setBackingYPadding(2)
	self:addElement(SelectNewContract)
	self.SelectNewContract = SelectNewContract
	local BMContractReveal = CoD.BM_ContractReveal.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(BMContractReveal)
	self.BMContractReveal = BMContractReveal
	self:mergeStateConditions({
		{
			stateName = "Empty",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "displayName", 0x0)
			end,
		},
		{
			stateName = "Completed",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "completed")
			end,
		},
		{
			stateName = "CompletedSlot",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "completed")
			end,
		},
	})
	self:linkToElementModel(self, "displayName", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "displayName",
		})
	end)
	self:linkToElementModel(self, "completed", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "completed",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.BM_ContractDetailsInternal.__resetProperties = function(f13_arg0)
	f13_arg0.Description:completeAnimation()
	f13_arg0.Name:completeAnimation()
	f13_arg0.BMActiveContractItemRewardsContainer:completeAnimation()
	f13_arg0.BMContractProgress:completeAnimation()
	f13_arg0.ButtonTopLine9Slice:completeAnimation()
	f13_arg0.SelectNewContract:completeAnimation()
	f13_arg0.Backer:completeAnimation()
	f13_arg0.dashedRing:completeAnimation()
	f13_arg0.CompletedBox:completeAnimation()
	f13_arg0.Description:setAlpha(1)
	f13_arg0.Name:setAlpha(1)
	f13_arg0.Name:setScale(1, 1)
	f13_arg0.BMActiveContractItemRewardsContainer:setAlpha(1)
	f13_arg0.BMContractProgress:setAlpha(1)
	f13_arg0.BMContractProgress:setScale(1, 1)
	f13_arg0.BMContractProgress.Difficulty:setAlpha(1)
	f13_arg0.BMContractProgress.Completed:setScale(1, 1)
	f13_arg0.ButtonTopLine9Slice:setAlpha(0.11)
	f13_arg0.SelectNewContract:setAlpha(0)
	f13_arg0.Backer:setRGB(0.09, 0.09, 0.09)
	f13_arg0.dashedRing:setAlpha(0)
	f13_arg0.CompletedBox:setAlpha(0)
end
CoD.BM_ContractDetailsInternal.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(0)
		end,
	},
	Empty = {
		DefaultClip = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(8)
			f15_arg0.Backer:completeAnimation()
			f15_arg0.Backer:setRGB(0, 0, 0)
			f15_arg0.clipFinished(f15_arg0.Backer)
			f15_arg0.dashedRing:completeAnimation()
			f15_arg0.dashedRing:setAlpha(0.05)
			f15_arg0.clipFinished(f15_arg0.dashedRing)
			f15_arg0.ButtonTopLine9Slice:completeAnimation()
			f15_arg0.ButtonTopLine9Slice:setAlpha(0.11)
			f15_arg0.clipFinished(f15_arg0.ButtonTopLine9Slice)
			f15_arg0.BMContractProgress:completeAnimation()
			f15_arg0.BMContractProgress:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.BMContractProgress)
			f15_arg0.BMActiveContractItemRewardsContainer:completeAnimation()
			f15_arg0.BMActiveContractItemRewardsContainer:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.BMActiveContractItemRewardsContainer)
			f15_arg0.Name:completeAnimation()
			f15_arg0.Name:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.Name)
			f15_arg0.Description:completeAnimation()
			f15_arg0.Description:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.Description)
			f15_arg0.SelectNewContract:completeAnimation()
			f15_arg0.SelectNewContract:setAlpha(1)
			f15_arg0.clipFinished(f15_arg0.SelectNewContract)
		end,
	},
	Completed = {
		DefaultClip = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(2)
			f16_arg0.CompletedBox:completeAnimation()
			f16_arg0.CompletedBox:setAlpha(0.02)
			f16_arg0.clipFinished(f16_arg0.CompletedBox)
			f16_arg0.SelectNewContract:completeAnimation()
			f16_arg0.SelectNewContract:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.SelectNewContract)
		end,
	},
	CompletedSlot = {
		DefaultClip = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(8)
			f17_arg0.Backer:completeAnimation()
			f17_arg0.Backer:setRGB(0, 0, 0)
			f17_arg0.clipFinished(f17_arg0.Backer)
			local f17_local0 = function(f18_arg0)
				local f18_local0 = function(f19_arg0)
					f19_arg0:beginAnimation(269)
					f19_arg0:setAlpha(0.05)
					f19_arg0:registerEventHandler("transition_complete_keyframe", f17_arg0.clipFinished)
				end
				f17_arg0.dashedRing:beginAnimation(3150)
				f17_arg0.dashedRing:registerEventHandler("interrupted_keyframe", f17_arg0.clipInterrupted)
				f17_arg0.dashedRing:registerEventHandler("transition_complete_keyframe", f18_local0)
			end
			f17_arg0.dashedRing:completeAnimation()
			f17_arg0.dashedRing:setAlpha(0)
			f17_local0(f17_arg0.dashedRing)
			local f17_local1 = function(f20_arg0)
				local f20_local0 = function(f21_arg0)
					local f21_local0 = function(f22_arg0)
						local f22_local0 = function(f23_arg0)
							local f23_local0 = function(f24_arg0)
								f24_arg0:beginAnimation(289)
								f24_arg0:setAlpha(0)
								f24_arg0:registerEventHandler("transition_complete_keyframe", f17_arg0.clipFinished)
							end
							f23_arg0:beginAnimation(1930)
							f23_arg0:registerEventHandler("transition_complete_keyframe", f23_local0)
						end
						f22_arg0:beginAnimation(190, Enum[0xF50FFF429AB1890][0x5D2D9CF90AB1735])
						f22_arg0:setAlpha(0.02)
						f22_arg0:registerEventHandler("transition_complete_keyframe", f22_local0)
					end
					f21_arg0:beginAnimation(179, Enum[0xF50FFF429AB1890][0x5D2D9CF90AB1735])
					f21_arg0:setAlpha(0.1)
					f21_arg0:registerEventHandler("transition_complete_keyframe", f21_local0)
				end
				f17_arg0.CompletedBox:beginAnimation(270)
				f17_arg0.CompletedBox:registerEventHandler("interrupted_keyframe", f17_arg0.clipInterrupted)
				f17_arg0.CompletedBox:registerEventHandler("transition_complete_keyframe", f20_local0)
			end
			f17_arg0.CompletedBox:completeAnimation()
			f17_arg0.CompletedBox:setAlpha(0.02)
			f17_local1(f17_arg0.CompletedBox)
			local f17_local2 = function(f25_arg0)
				local f25_local0 = function(f26_arg0)
					local f26_local0 = function(f27_arg0)
						local f27_local0 = function(f28_arg0)
							local f28_local0 = function(f29_arg0)
								local f29_local0 = function(f30_arg0)
									local f30_local0 = function(f31_arg0)
										f31_arg0:beginAnimation(9)
										f31_arg0:registerEventHandler("transition_complete_keyframe", f17_arg0.clipFinished)
									end
									f30_arg0:beginAnimation(289)
									f30_arg0:setAlpha(0)
									f30_arg0:registerEventHandler("transition_complete_keyframe", f30_local0)
								end
								f29_arg0:beginAnimation(1770)
								f29_arg0:registerEventHandler("transition_complete_keyframe", f29_local0)
							end
							f28_arg0:beginAnimation(79, Enum[0xF50FFF429AB1890][0x5D2D9CF90AB1735])
							f28_arg0.Completed:beginAnimation(79, Enum[0xF50FFF429AB1890][0x5D2D9CF90AB1735])
							f28_arg0.Completed:setScale(1, 1)
							f28_arg0:registerEventHandler("transition_complete_keyframe", f28_local0)
						end
						f27_arg0:beginAnimation(60)
						f27_arg0.Completed:beginAnimation(60)
						f27_arg0.Completed:setScale(1.3, 1.3)
						f27_arg0:registerEventHandler("transition_complete_keyframe", f27_local0)
					end
					f26_arg0:beginAnimation(20)
					f26_arg0.Difficulty:beginAnimation(20)
					f26_arg0.Completed:beginAnimation(20)
					f26_arg0.Difficulty:setAlpha(1)
					f26_arg0.Completed:setScale(0.33, 0.33)
					f26_arg0:registerEventHandler("transition_complete_keyframe", f26_local0)
				end
				f17_arg0.BMContractProgress:beginAnimation(640, Enum[0xF50FFF429AB1890][0x5D2D9CF90AB1735])
				f17_arg0.BMContractProgress:setAlpha(1)
				f17_arg0.BMContractProgress:setScale(1, 1)
				f17_arg0.BMContractProgress:registerEventHandler("interrupted_keyframe", f17_arg0.clipInterrupted)
				f17_arg0.BMContractProgress:registerEventHandler("transition_complete_keyframe", f25_local0)
			end
			f17_arg0.BMContractProgress:completeAnimation()
			f17_arg0.BMContractProgress.Difficulty:completeAnimation()
			f17_arg0.BMContractProgress.Completed:completeAnimation()
			f17_arg0.BMContractProgress:setAlpha(0)
			f17_arg0.BMContractProgress:setScale(1.8, 1.8)
			f17_arg0.BMContractProgress.Difficulty:setAlpha(0)
			f17_arg0.BMContractProgress.Completed:setScale(0, 0)
			f17_local2(f17_arg0.BMContractProgress)
			local f17_local3 = function(f32_arg0)
				local f32_local0 = function(f33_arg0)
					f33_arg0:beginAnimation(289)
					f33_arg0:setAlpha(0)
					f33_arg0:registerEventHandler("transition_complete_keyframe", f17_arg0.clipFinished)
				end
				f17_arg0.BMActiveContractItemRewardsContainer:beginAnimation(3010)
				f17_arg0.BMActiveContractItemRewardsContainer:registerEventHandler("interrupted_keyframe", f17_arg0.clipInterrupted)
				f17_arg0.BMActiveContractItemRewardsContainer:registerEventHandler("transition_complete_keyframe", f32_local0)
			end
			f17_arg0.BMActiveContractItemRewardsContainer:completeAnimation()
			f17_arg0.BMActiveContractItemRewardsContainer:setAlpha(1)
			f17_local3(f17_arg0.BMActiveContractItemRewardsContainer)
			local f17_local4 = function(f34_arg0)
				local f34_local0 = function(f35_arg0)
					local f35_local0 = function(f36_arg0)
						f36_arg0:beginAnimation(289)
						f36_arg0:setAlpha(0)
						f36_arg0:registerEventHandler("transition_complete_keyframe", f17_arg0.clipFinished)
					end
					f35_arg0:beginAnimation(2080)
					f35_arg0:registerEventHandler("transition_complete_keyframe", f35_local0)
				end
				f17_arg0.Name:beginAnimation(640)
				f17_arg0.Name:registerEventHandler("interrupted_keyframe", f17_arg0.clipInterrupted)
				f17_arg0.Name:registerEventHandler("transition_complete_keyframe", f34_local0)
			end
			f17_arg0.Name:completeAnimation()
			f17_arg0.Name:setAlpha(1)
			f17_arg0.Name:setScale(1, 1)
			f17_local4(f17_arg0.Name)
			local f17_local5 = function(f37_arg0)
				local f37_local0 = function(f38_arg0)
					f38_arg0:beginAnimation(290)
					f38_arg0:setAlpha(0)
					f38_arg0:registerEventHandler("transition_complete_keyframe", f17_arg0.clipFinished)
				end
				f17_arg0.Description:beginAnimation(2860)
				f17_arg0.Description:registerEventHandler("interrupted_keyframe", f17_arg0.clipInterrupted)
				f17_arg0.Description:registerEventHandler("transition_complete_keyframe", f37_local0)
			end
			f17_arg0.Description:completeAnimation()
			f17_arg0.Description:setAlpha(1)
			f17_local5(f17_arg0.Description)
			local f17_local6 = function(f39_arg0)
				local f39_local0 = function(f40_arg0)
					f40_arg0:beginAnimation(269)
					f40_arg0:setAlpha(1)
					f40_arg0:registerEventHandler("transition_complete_keyframe", f17_arg0.clipFinished)
				end
				f17_arg0.SelectNewContract:beginAnimation(3150)
				f17_arg0.SelectNewContract:registerEventHandler("interrupted_keyframe", f17_arg0.clipInterrupted)
				f17_arg0.SelectNewContract:registerEventHandler("transition_complete_keyframe", f39_local0)
			end
			f17_arg0.SelectNewContract:completeAnimation()
			f17_arg0.SelectNewContract:setAlpha(0)
			f17_local6(f17_arg0.SelectNewContract)
		end,
	},
}
CoD.BM_ContractDetailsInternal.__onClose = function(f41_arg0)
	f41_arg0.BMContractProgress:close()
	f41_arg0.BMActiveContractItemRewardsContainer:close()
	f41_arg0.Name:close()
	f41_arg0.Description:close()
	f41_arg0.FETitleNumBrdr00:close()
	f41_arg0.Lines:close()
	f41_arg0.BMContractReveal:close()
end
