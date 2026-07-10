require("x64:5cb43180fc65bb6")
require("x64:b49b35877fd007c")
CoD.EmblemDrawWidgetPreview = InheritFrom(LUI.UIElement)
CoD.EmblemDrawWidgetPreview.__defaultWidth = 540
CoD.EmblemDrawWidgetPreview.__defaultHeight = 480
CoD.EmblemDrawWidgetPreview.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.EmblemDrawWidgetPreview)
	self.id = "EmblemDrawWidgetPreview"
	self.soundSet = "default"
	self.onlyChildrenFocusable = CoD.isPC
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local BgImage01 = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	BgImage01:setAlpha(0.5)
	BgImage01:setImage(RegisterImage(0x34839E8065B1E53))
	BgImage01:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	BgImage01:setShaderVector(0, 0, 0, 0, 0)
	BgImage01:setupNineSliceShader(196, 88)
	self:addElement(BgImage01)
	self.BgImage01 = BgImage01
	local BgAdd = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	BgAdd:setRGB(0.92, 0.92, 0.92)
	BgAdd:setAlpha(0)
	BgAdd:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(BgAdd)
	self.BgAdd = BgAdd
	local EditorDrawEmblemFocusable = nil
	EditorDrawEmblemFocusable = CoD.EditorDrawEmblemFocusable.new(f1_arg0, f1_arg1, 0.5, 0.5, -230, 230, 0.5, 0.5, -230, 230)
	self:addElement(EditorDrawEmblemFocusable)
	self.EditorDrawEmblemFocusable = EditorDrawEmblemFocusable
	local f1_local4 = nil
	self.emblemDrawingArea = LUI.UIElement.createFake()
	local BMGoldBar = CoD.BM_GoldBarLarge.new(f1_arg0, f1_arg1, 0.5, 0.5, -270, 270, 0.5, 0.5, -29, 29)
	BMGoldBar:setAlpha(0)
	self:addElement(BMGoldBar)
	self.BMGoldBar = BMGoldBar
	local FrontendFrame02 = LUI.UIImage.new(0, 1, -1, 1, 0, 1, -1, 1)
	FrontendFrame02:setAlpha(0.2)
	FrontendFrame02:setImage(RegisterImage(0x185E11D74ECA3D7))
	FrontendFrame02:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD777557404A7B3))
	FrontendFrame02:setShaderVector(0, 0, 0, 0, 0)
	FrontendFrame02:setupNineSliceShader(12, 12)
	self:addElement(FrontendFrame02)
	self.FrontendFrame02 = FrontendFrame02
	local FrontendFrame01 = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	FrontendFrame01:setAlpha(0.2)
	FrontendFrame01:setImage(RegisterImage(0x185E11D74ECA3D7))
	FrontendFrame01:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD777557404A7B3))
	FrontendFrame01:setShaderVector(0, 0, 0, 0, 0)
	FrontendFrame01:setupNineSliceShader(12, 12)
	self:addElement(FrontendFrame01)
	self.FrontendFrame01 = FrontendFrame01
	local FrontendFrameSelected = LUI.UIImage.new(0, 1, -4, 4, 0, 1, -4, 4)
	FrontendFrameSelected:setAlpha(0)
	FrontendFrameSelected:setImage(RegisterImage(0xCB07CCC28498CB2))
	FrontendFrameSelected:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD777557404A7B3))
	FrontendFrameSelected:setShaderVector(0, 0, 0, 0, 0)
	FrontendFrameSelected:setupNineSliceShader(12, 12)
	self:addElement(FrontendFrameSelected)
	self.FrontendFrameSelected = FrontendFrameSelected
	local FrontendFrameSelectedGlow = LUI.UIImage.new(0, 1, -12, 12, 0, 1, -12, 12)
	FrontendFrameSelectedGlow:setAlpha(0)
	FrontendFrameSelectedGlow:setImage(RegisterImage(0xCB07CCC28498CB2))
	FrontendFrameSelectedGlow:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD777557404A7B3))
	FrontendFrameSelectedGlow:setShaderVector(0, 0, 0, 0, 0)
	FrontendFrameSelectedGlow:setupNineSliceShader(40, 40)
	self:addElement(FrontendFrameSelectedGlow)
	self.FrontendFrameSelectedGlow = FrontendFrameSelectedGlow
	local FrontendFocusPip = LUI.UIImage.new(0, 1, -7, 7, 0, 1, -7, 7)
	FrontendFocusPip:setAlpha(0)
	FrontendFocusPip:setScale(1.06, 1.06)
	FrontendFocusPip:setImage(RegisterImage(0x793C73633F620BB))
	FrontendFocusPip:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD777557404A7B3))
	FrontendFocusPip:setShaderVector(0, 0, 0, 0, 0)
	FrontendFocusPip:setupNineSliceShader(52, 52)
	self:addElement(FrontendFocusPip)
	self.FrontendFocusPip = FrontendFocusPip
	self:mergeStateConditions({
		{
			stateName = "BMClassified",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "isLoot") and not CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "available")
			end,
		},
		{
			stateName = "Unfocusable",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "EmptySlot",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "EditMode",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	self:linkToElementModel(self, "isLoot", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "isLoot",
		})
	end)
	self:linkToElementModel(self, "available", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "available",
		})
	end)
	if CoD.isPC then
		EditorDrawEmblemFocusable.id = "EditorDrawEmblemFocusable"
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local11 = self
	f1_local11 = EditorDrawEmblemFocusable
	if IsPC() then
		CoD.PCUtility.CraftLockFocusOnDrag(f1_local11, f1_arg1, f1_arg0)
	end
	return self
end
CoD.EmblemDrawWidgetPreview.__resetProperties = function(f8_arg0)
	f8_arg0.FrontendFrame01:completeAnimation()
	f8_arg0.FrontendFrame02:completeAnimation()
	f8_arg0.FrontendFrameSelected:completeAnimation()
	f8_arg0.FrontendFrameSelectedGlow:completeAnimation()
	f8_arg0.FrontendFocusPip:completeAnimation()
	f8_arg0.BgAdd:completeAnimation()
	f8_arg0.emblemDrawingArea:completeAnimation()
	f8_arg0.BMGoldBar:completeAnimation()
	f8_arg0.EditorDrawEmblemFocusable:completeAnimation()
	f8_arg0.FrontendFrame01:setAlpha(0.2)
	f8_arg0.FrontendFrame02:setAlpha(0.2)
	f8_arg0.FrontendFrameSelected:setAlpha(0)
	f8_arg0.FrontendFrameSelectedGlow:setAlpha(0)
	f8_arg0.FrontendFocusPip:setAlpha(0)
	f8_arg0.FrontendFocusPip:setScale(1.06, 1.06)
	f8_arg0.BgAdd:setAlpha(0)
	f8_arg0.emblemDrawingArea:setAlpha(1)
	f8_arg0.BMGoldBar:setAlpha(0)
	f8_arg0.EditorDrawEmblemFocusable:setAlpha(1)
end
CoD.EmblemDrawWidgetPreview.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(0)
		end,
		EditMode = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(6)
			local f10_local0 = function(f11_arg0)
				f10_arg0.BgAdd:beginAnimation(100)
				f10_arg0.BgAdd:setAlpha(0.02)
				f10_arg0.BgAdd:registerEventHandler("interrupted_keyframe", f10_arg0.clipInterrupted)
				f10_arg0.BgAdd:registerEventHandler("transition_complete_keyframe", f10_arg0.clipFinished)
			end
			f10_arg0.BgAdd:completeAnimation()
			f10_arg0.BgAdd:setAlpha(0)
			f10_local0(f10_arg0.BgAdd)
			local f10_local1 = function(f12_arg0)
				f10_arg0.FrontendFrame02:beginAnimation(150)
				f10_arg0.FrontendFrame02:setAlpha(1)
				f10_arg0.FrontendFrame02:registerEventHandler("interrupted_keyframe", f10_arg0.clipInterrupted)
				f10_arg0.FrontendFrame02:registerEventHandler("transition_complete_keyframe", f10_arg0.clipFinished)
			end
			f10_arg0.FrontendFrame02:completeAnimation()
			f10_arg0.FrontendFrame02:setAlpha(0.2)
			f10_local1(f10_arg0.FrontendFrame02)
			local f10_local2 = function(f13_arg0)
				f10_arg0.FrontendFrame01:beginAnimation(150)
				f10_arg0.FrontendFrame01:setAlpha(1)
				f10_arg0.FrontendFrame01:registerEventHandler("interrupted_keyframe", f10_arg0.clipInterrupted)
				f10_arg0.FrontendFrame01:registerEventHandler("transition_complete_keyframe", f10_arg0.clipFinished)
			end
			f10_arg0.FrontendFrame01:completeAnimation()
			f10_arg0.FrontendFrame01:setAlpha(0.2)
			f10_local2(f10_arg0.FrontendFrame01)
			local f10_local3 = function(f14_arg0)
				f10_arg0.FrontendFrameSelected:beginAnimation(150, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
				f10_arg0.FrontendFrameSelected:setAlpha(1)
				f10_arg0.FrontendFrameSelected:registerEventHandler("interrupted_keyframe", f10_arg0.clipInterrupted)
				f10_arg0.FrontendFrameSelected:registerEventHandler("transition_complete_keyframe", f10_arg0.clipFinished)
			end
			f10_arg0.FrontendFrameSelected:completeAnimation()
			f10_arg0.FrontendFrameSelected:setAlpha(0)
			f10_local3(f10_arg0.FrontendFrameSelected)
			local f10_local4 = function(f15_arg0)
				local f15_local0 = function(f16_arg0)
					f16_arg0:beginAnimation(150)
					f16_arg0:setAlpha(0.1)
					f16_arg0:registerEventHandler("transition_complete_keyframe", f10_arg0.clipFinished)
				end
				f10_arg0.FrontendFrameSelectedGlow:beginAnimation(150)
				f10_arg0.FrontendFrameSelectedGlow:setAlpha(0.2)
				f10_arg0.FrontendFrameSelectedGlow:registerEventHandler("interrupted_keyframe", f10_arg0.clipInterrupted)
				f10_arg0.FrontendFrameSelectedGlow:registerEventHandler("transition_complete_keyframe", f15_local0)
			end
			f10_arg0.FrontendFrameSelectedGlow:completeAnimation()
			f10_arg0.FrontendFrameSelectedGlow:setAlpha(0)
			f10_local4(f10_arg0.FrontendFrameSelectedGlow)
			local f10_local5 = function(f17_arg0)
				f10_arg0.FrontendFocusPip:beginAnimation(150, Enum[0xF50FFF429AB1890][0x53CEB9A0427197])
				f10_arg0.FrontendFocusPip:setAlpha(0.3)
				f10_arg0.FrontendFocusPip:setScale(1, 1)
				f10_arg0.FrontendFocusPip:registerEventHandler("interrupted_keyframe", f10_arg0.clipInterrupted)
				f10_arg0.FrontendFocusPip:registerEventHandler("transition_complete_keyframe", f10_arg0.clipFinished)
			end
			f10_arg0.FrontendFocusPip:completeAnimation()
			f10_arg0.FrontendFocusPip:setAlpha(0)
			f10_arg0.FrontendFocusPip:setScale(1.06, 1.06)
			f10_local5(f10_arg0.FrontendFocusPip)
		end,
	},
	BMClassified = {
		DefaultClip = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(2)
			f18_arg0.EditorDrawEmblemFocusable:completeAnimation()
			f18_arg0.EditorDrawEmblemFocusable:setAlpha(0)
			f18_arg0.clipFinished(f18_arg0.EditorDrawEmblemFocusable)
			f18_arg0.emblemDrawingArea:completeAnimation()
			f18_arg0.emblemDrawingArea:setAlpha(0)
			f18_arg0.clipFinished(f18_arg0.emblemDrawingArea)
			f18_arg0.BMGoldBar:completeAnimation()
			f18_arg0.BMGoldBar:setAlpha(1)
			f18_arg0.clipFinished(f18_arg0.BMGoldBar)
		end,
	},
	Unfocusable = {
		DefaultClip = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(1)
			f19_arg0.FrontendFrame02:completeAnimation()
			f19_arg0.FrontendFrame02:setAlpha(0.2)
			f19_arg0.clipFinished(f19_arg0.FrontendFrame02)
		end,
	},
	EmptySlot = {
		DefaultClip = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(1)
			f20_arg0.FrontendFrame02:completeAnimation()
			f20_arg0.FrontendFrame02:setAlpha(0.2)
			f20_arg0.clipFinished(f20_arg0.FrontendFrame02)
		end,
	},
	EditMode = {
		DefaultClip = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(6)
			f21_arg0.BgAdd:completeAnimation()
			f21_arg0.BgAdd:setAlpha(0.02)
			f21_arg0.clipFinished(f21_arg0.BgAdd)
			f21_arg0.FrontendFrame02:completeAnimation()
			f21_arg0.FrontendFrame02:setAlpha(1)
			f21_arg0.clipFinished(f21_arg0.FrontendFrame02)
			f21_arg0.FrontendFrame01:completeAnimation()
			f21_arg0.FrontendFrame01:setAlpha(1)
			f21_arg0.clipFinished(f21_arg0.FrontendFrame01)
			f21_arg0.FrontendFrameSelected:completeAnimation()
			f21_arg0.FrontendFrameSelected:setAlpha(1)
			f21_arg0.clipFinished(f21_arg0.FrontendFrameSelected)
			f21_arg0.FrontendFrameSelectedGlow:completeAnimation()
			f21_arg0.FrontendFrameSelectedGlow:setAlpha(0.1)
			f21_arg0.clipFinished(f21_arg0.FrontendFrameSelectedGlow)
			f21_arg0.FrontendFocusPip:completeAnimation()
			f21_arg0.FrontendFocusPip:setAlpha(0.3)
			f21_arg0.FrontendFocusPip:setScale(1, 1)
			f21_arg0.clipFinished(f21_arg0.FrontendFocusPip)
		end,
		DefaultState = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(6)
			local f22_local0 = function(f23_arg0)
				f22_arg0.BgAdd:beginAnimation(100)
				f22_arg0.BgAdd:setAlpha(0)
				f22_arg0.BgAdd:registerEventHandler("interrupted_keyframe", f22_arg0.clipInterrupted)
				f22_arg0.BgAdd:registerEventHandler("transition_complete_keyframe", f22_arg0.clipFinished)
			end
			f22_arg0.BgAdd:completeAnimation()
			f22_arg0.BgAdd:setAlpha(0.02)
			f22_local0(f22_arg0.BgAdd)
			local f22_local1 = function(f24_arg0)
				f22_arg0.FrontendFrame02:beginAnimation(150)
				f22_arg0.FrontendFrame02:setAlpha(0.2)
				f22_arg0.FrontendFrame02:registerEventHandler("interrupted_keyframe", f22_arg0.clipInterrupted)
				f22_arg0.FrontendFrame02:registerEventHandler("transition_complete_keyframe", f22_arg0.clipFinished)
			end
			f22_arg0.FrontendFrame02:completeAnimation()
			f22_arg0.FrontendFrame02:setAlpha(1)
			f22_local1(f22_arg0.FrontendFrame02)
			local f22_local2 = function(f25_arg0)
				f22_arg0.FrontendFrame01:beginAnimation(150)
				f22_arg0.FrontendFrame01:setAlpha(0.2)
				f22_arg0.FrontendFrame01:registerEventHandler("interrupted_keyframe", f22_arg0.clipInterrupted)
				f22_arg0.FrontendFrame01:registerEventHandler("transition_complete_keyframe", f22_arg0.clipFinished)
			end
			f22_arg0.FrontendFrame01:completeAnimation()
			f22_arg0.FrontendFrame01:setAlpha(1)
			f22_local2(f22_arg0.FrontendFrame01)
			local f22_local3 = function(f26_arg0)
				f22_arg0.FrontendFrameSelected:beginAnimation(150, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
				f22_arg0.FrontendFrameSelected:setAlpha(0)
				f22_arg0.FrontendFrameSelected:registerEventHandler("interrupted_keyframe", f22_arg0.clipInterrupted)
				f22_arg0.FrontendFrameSelected:registerEventHandler("transition_complete_keyframe", f22_arg0.clipFinished)
			end
			f22_arg0.FrontendFrameSelected:completeAnimation()
			f22_arg0.FrontendFrameSelected:setAlpha(1)
			f22_local3(f22_arg0.FrontendFrameSelected)
			local f22_local4 = function(f27_arg0)
				f22_arg0.FrontendFrameSelectedGlow:beginAnimation(150)
				f22_arg0.FrontendFrameSelectedGlow:setAlpha(0)
				f22_arg0.FrontendFrameSelectedGlow:registerEventHandler("interrupted_keyframe", f22_arg0.clipInterrupted)
				f22_arg0.FrontendFrameSelectedGlow:registerEventHandler("transition_complete_keyframe", f22_arg0.clipFinished)
			end
			f22_arg0.FrontendFrameSelectedGlow:completeAnimation()
			f22_arg0.FrontendFrameSelectedGlow:setAlpha(0.1)
			f22_local4(f22_arg0.FrontendFrameSelectedGlow)
			local f22_local5 = function(f28_arg0)
				f22_arg0.FrontendFocusPip:beginAnimation(150, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
				f22_arg0.FrontendFocusPip:setAlpha(0)
				f22_arg0.FrontendFocusPip:setScale(1.06, 1.06)
				f22_arg0.FrontendFocusPip:registerEventHandler("interrupted_keyframe", f22_arg0.clipInterrupted)
				f22_arg0.FrontendFocusPip:registerEventHandler("transition_complete_keyframe", f22_arg0.clipFinished)
			end
			f22_arg0.FrontendFocusPip:completeAnimation()
			f22_arg0.FrontendFocusPip:setAlpha(0.3)
			f22_arg0.FrontendFocusPip:setScale(1, 1)
			f22_local5(f22_arg0.FrontendFocusPip)
		end,
	},
}
CoD.EmblemDrawWidgetPreview.__onClose = function(f29_arg0)
	f29_arg0.EditorDrawEmblemFocusable:close()
	f29_arg0.emblemDrawingArea:close()
	f29_arg0.BMGoldBar:close()
end
