require("x64:5cb43180fc65bb6")
require("x64:b49b35877fd007c")
local f0_local0 = function(f1_arg0, f1_arg1, f1_arg2)
	if CoD.isPC then
		f1_arg0.m_preventFromBeingCurrentMouseFocus = true
	end
end
CoD.EmblemDrawWidgetNew = InheritFrom(LUI.UIElement)
CoD.EmblemDrawWidgetNew.__defaultWidth = 540
CoD.EmblemDrawWidgetNew.__defaultHeight = 540
CoD.EmblemDrawWidgetNew.new = function(f2_arg0, f2_arg1, f2_arg2, f2_arg3, f2_arg4, f2_arg5, f2_arg6, f2_arg7, f2_arg8, f2_arg9)
	local self = LUI.UIElement.new(f2_arg2, f2_arg3, f2_arg4, f2_arg5, f2_arg6, f2_arg7, f2_arg8, f2_arg9)
	self:setClass(CoD.EmblemDrawWidgetNew)
	self.id = "EmblemDrawWidgetNew"
	self.soundSet = "default"
	self.onlyChildrenFocusable = CoD.isPC
	self.anyChildUsesUpdateState = true
	f2_arg0:addElementToPendingUpdateStateList(self)
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
	local EditGrid = LUI.UIImage.new(0, 0, 14, 526, 0, 0, 14, 526)
	EditGrid:setAlpha(0)
	EditGrid:setImage(RegisterImage(0x3793FD6AAAABDCD))
	self:addElement(EditGrid)
	self.EditGrid = EditGrid
	local EditorDrawEmblemFocusable = nil
	EditorDrawEmblemFocusable = CoD.EditorDrawEmblemFocusable.new(f2_arg0, f2_arg1, 0, 1, 15, -15, 0, 1, 15, -15)
	self:addElement(EditorDrawEmblemFocusable)
	self.EditorDrawEmblemFocusable = EditorDrawEmblemFocusable
	local f2_local5 = nil
	self.emblemDrawingArea = LUI.UIElement.createFake()
	local BMGoldBar = CoD.BM_GoldBarLarge.new(f2_arg0, f2_arg1, 0.5, 0.5, -270, 270, 0.5, 0.5, -29, 29)
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
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f2_arg1, "isLoot") and not CoD.ModelUtility.IsSelfModelValueTrue(element, f2_arg1, "available")
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
		f2_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f2_arg0,
			controller = f2_arg1,
			modelValue = model:get(),
			modelName = "isLoot",
		})
	end)
	self:linkToElementModel(self, "available", true, function(model)
		f2_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f2_arg0,
			controller = f2_arg1,
			modelValue = model:get(),
			modelName = "available",
		})
	end)
	if CoD.isPC then
		EditorDrawEmblemFocusable.id = "EditorDrawEmblemFocusable"
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if f0_local0 then
		f0_local0(self, f2_arg1, f2_arg0)
	end
	local f2_local12 = self
	f2_local12 = EditorDrawEmblemFocusable
	if IsPC() then
		CoD.PCUtility.CraftLockFocusOnDrag(f2_local12, f2_arg1, f2_arg0)
	end
	return self
end
CoD.EmblemDrawWidgetNew.__resetProperties = function(f9_arg0)
	f9_arg0.FrontendFrame01:completeAnimation()
	f9_arg0.FrontendFrame02:completeAnimation()
	f9_arg0.FrontendFrameSelected:completeAnimation()
	f9_arg0.FrontendFrameSelectedGlow:completeAnimation()
	f9_arg0.FrontendFocusPip:completeAnimation()
	f9_arg0.BgAdd:completeAnimation()
	f9_arg0.EditGrid:completeAnimation()
	f9_arg0.emblemDrawingArea:completeAnimation()
	f9_arg0.BMGoldBar:completeAnimation()
	f9_arg0.FrontendFrame01:setAlpha(0.2)
	f9_arg0.FrontendFrame02:setAlpha(0.2)
	f9_arg0.FrontendFrameSelected:setAlpha(0)
	f9_arg0.FrontendFrameSelectedGlow:setAlpha(0)
	f9_arg0.FrontendFocusPip:setAlpha(0)
	f9_arg0.FrontendFocusPip:setScale(1.06, 1.06)
	f9_arg0.BgAdd:setAlpha(0)
	f9_arg0.EditGrid:setAlpha(0)
	f9_arg0.emblemDrawingArea:setAlpha(1)
	f9_arg0.BMGoldBar:setAlpha(0)
end
CoD.EmblemDrawWidgetNew.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(0)
		end,
		EditMode = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(7)
			local f11_local0 = function(f12_arg0)
				f11_arg0.BgAdd:beginAnimation(100)
				f11_arg0.BgAdd:setAlpha(0.02)
				f11_arg0.BgAdd:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.BgAdd:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
			end
			f11_arg0.BgAdd:completeAnimation()
			f11_arg0.BgAdd:setAlpha(0)
			f11_local0(f11_arg0.BgAdd)
			local f11_local1 = function(f13_arg0)
				f11_arg0.EditGrid:beginAnimation(150)
				f11_arg0.EditGrid:setAlpha(0.3)
				f11_arg0.EditGrid:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.EditGrid:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
			end
			f11_arg0.EditGrid:completeAnimation()
			f11_arg0.EditGrid:setAlpha(0)
			f11_local1(f11_arg0.EditGrid)
			local f11_local2 = function(f14_arg0)
				f11_arg0.FrontendFrame02:beginAnimation(150)
				f11_arg0.FrontendFrame02:setAlpha(1)
				f11_arg0.FrontendFrame02:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.FrontendFrame02:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
			end
			f11_arg0.FrontendFrame02:completeAnimation()
			f11_arg0.FrontendFrame02:setAlpha(0.2)
			f11_local2(f11_arg0.FrontendFrame02)
			local f11_local3 = function(f15_arg0)
				f11_arg0.FrontendFrame01:beginAnimation(150)
				f11_arg0.FrontendFrame01:setAlpha(1)
				f11_arg0.FrontendFrame01:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.FrontendFrame01:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
			end
			f11_arg0.FrontendFrame01:completeAnimation()
			f11_arg0.FrontendFrame01:setAlpha(0.2)
			f11_local3(f11_arg0.FrontendFrame01)
			local f11_local4 = function(f16_arg0)
				f11_arg0.FrontendFrameSelected:beginAnimation(150, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
				f11_arg0.FrontendFrameSelected:setAlpha(1)
				f11_arg0.FrontendFrameSelected:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.FrontendFrameSelected:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
			end
			f11_arg0.FrontendFrameSelected:completeAnimation()
			f11_arg0.FrontendFrameSelected:setAlpha(0)
			f11_local4(f11_arg0.FrontendFrameSelected)
			local f11_local5 = function(f17_arg0)
				local f17_local0 = function(f18_arg0)
					f18_arg0:beginAnimation(150)
					f18_arg0:setAlpha(0.1)
					f18_arg0:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
				end
				f11_arg0.FrontendFrameSelectedGlow:beginAnimation(150)
				f11_arg0.FrontendFrameSelectedGlow:setAlpha(0.2)
				f11_arg0.FrontendFrameSelectedGlow:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.FrontendFrameSelectedGlow:registerEventHandler("transition_complete_keyframe", f17_local0)
			end
			f11_arg0.FrontendFrameSelectedGlow:completeAnimation()
			f11_arg0.FrontendFrameSelectedGlow:setAlpha(0)
			f11_local5(f11_arg0.FrontendFrameSelectedGlow)
			local f11_local6 = function(f19_arg0)
				f11_arg0.FrontendFocusPip:beginAnimation(150, Enum[0xF50FFF429AB1890][0x53CEB9A0427197])
				f11_arg0.FrontendFocusPip:setAlpha(0.3)
				f11_arg0.FrontendFocusPip:setScale(1, 1)
				f11_arg0.FrontendFocusPip:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.FrontendFocusPip:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
			end
			f11_arg0.FrontendFocusPip:completeAnimation()
			f11_arg0.FrontendFocusPip:setAlpha(0)
			f11_arg0.FrontendFocusPip:setScale(1.06, 1.06)
			f11_local6(f11_arg0.FrontendFocusPip)
		end,
	},
	BMClassified = {
		DefaultClip = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(1)
			f20_arg0.emblemDrawingArea:completeAnimation()
			f20_arg0.emblemDrawingArea:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.emblemDrawingArea)
			f20_arg0.BMGoldBar:completeAnimation()
			f20_arg0.BMGoldBar:setAlpha(1)
			f20_arg0.clipFinished(f20_arg0.BMGoldBar)
		end,
	},
	Unfocusable = {
		DefaultClip = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(1)
			f21_arg0.FrontendFrame02:completeAnimation()
			f21_arg0.FrontendFrame02:setAlpha(0.2)
			f21_arg0.clipFinished(f21_arg0.FrontendFrame02)
		end,
	},
	EmptySlot = {
		DefaultClip = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(1)
			f22_arg0.FrontendFrame02:completeAnimation()
			f22_arg0.FrontendFrame02:setAlpha(0.2)
			f22_arg0.clipFinished(f22_arg0.FrontendFrame02)
		end,
	},
	EditMode = {
		DefaultClip = function(f23_arg0, f23_arg1)
			f23_arg0:__resetProperties()
			f23_arg0:setupElementClipCounter(7)
			f23_arg0.BgAdd:completeAnimation()
			f23_arg0.BgAdd:setAlpha(0.02)
			f23_arg0.clipFinished(f23_arg0.BgAdd)
			f23_arg0.EditGrid:completeAnimation()
			f23_arg0.EditGrid:setAlpha(0.3)
			f23_arg0.clipFinished(f23_arg0.EditGrid)
			f23_arg0.FrontendFrame02:completeAnimation()
			f23_arg0.FrontendFrame02:setAlpha(1)
			f23_arg0.clipFinished(f23_arg0.FrontendFrame02)
			f23_arg0.FrontendFrame01:completeAnimation()
			f23_arg0.FrontendFrame01:setAlpha(1)
			f23_arg0.clipFinished(f23_arg0.FrontendFrame01)
			f23_arg0.FrontendFrameSelected:completeAnimation()
			f23_arg0.FrontendFrameSelected:setAlpha(1)
			f23_arg0.clipFinished(f23_arg0.FrontendFrameSelected)
			f23_arg0.FrontendFrameSelectedGlow:completeAnimation()
			f23_arg0.FrontendFrameSelectedGlow:setAlpha(0.1)
			f23_arg0.clipFinished(f23_arg0.FrontendFrameSelectedGlow)
			f23_arg0.FrontendFocusPip:completeAnimation()
			f23_arg0.FrontendFocusPip:setAlpha(0.3)
			f23_arg0.FrontendFocusPip:setScale(1, 1)
			f23_arg0.clipFinished(f23_arg0.FrontendFocusPip)
		end,
		DefaultState = function(f24_arg0, f24_arg1)
			f24_arg0:__resetProperties()
			f24_arg0:setupElementClipCounter(6)
			local f24_local0 = function(f25_arg0)
				f24_arg0.BgAdd:beginAnimation(100)
				f24_arg0.BgAdd:setAlpha(0)
				f24_arg0.BgAdd:registerEventHandler("interrupted_keyframe", f24_arg0.clipInterrupted)
				f24_arg0.BgAdd:registerEventHandler("transition_complete_keyframe", f24_arg0.clipFinished)
			end
			f24_arg0.BgAdd:completeAnimation()
			f24_arg0.BgAdd:setAlpha(0.02)
			f24_local0(f24_arg0.BgAdd)
			local f24_local1 = function(f26_arg0)
				f24_arg0.FrontendFrame02:beginAnimation(150)
				f24_arg0.FrontendFrame02:setAlpha(0.2)
				f24_arg0.FrontendFrame02:registerEventHandler("interrupted_keyframe", f24_arg0.clipInterrupted)
				f24_arg0.FrontendFrame02:registerEventHandler("transition_complete_keyframe", f24_arg0.clipFinished)
			end
			f24_arg0.FrontendFrame02:completeAnimation()
			f24_arg0.FrontendFrame02:setAlpha(1)
			f24_local1(f24_arg0.FrontendFrame02)
			local f24_local2 = function(f27_arg0)
				f24_arg0.FrontendFrame01:beginAnimation(150)
				f24_arg0.FrontendFrame01:setAlpha(0.2)
				f24_arg0.FrontendFrame01:registerEventHandler("interrupted_keyframe", f24_arg0.clipInterrupted)
				f24_arg0.FrontendFrame01:registerEventHandler("transition_complete_keyframe", f24_arg0.clipFinished)
			end
			f24_arg0.FrontendFrame01:completeAnimation()
			f24_arg0.FrontendFrame01:setAlpha(1)
			f24_local2(f24_arg0.FrontendFrame01)
			local f24_local3 = function(f28_arg0)
				f24_arg0.FrontendFrameSelected:beginAnimation(150, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
				f24_arg0.FrontendFrameSelected:setAlpha(0)
				f24_arg0.FrontendFrameSelected:registerEventHandler("interrupted_keyframe", f24_arg0.clipInterrupted)
				f24_arg0.FrontendFrameSelected:registerEventHandler("transition_complete_keyframe", f24_arg0.clipFinished)
			end
			f24_arg0.FrontendFrameSelected:completeAnimation()
			f24_arg0.FrontendFrameSelected:setAlpha(1)
			f24_local3(f24_arg0.FrontendFrameSelected)
			local f24_local4 = function(f29_arg0)
				f24_arg0.FrontendFrameSelectedGlow:beginAnimation(150)
				f24_arg0.FrontendFrameSelectedGlow:setAlpha(0)
				f24_arg0.FrontendFrameSelectedGlow:registerEventHandler("interrupted_keyframe", f24_arg0.clipInterrupted)
				f24_arg0.FrontendFrameSelectedGlow:registerEventHandler("transition_complete_keyframe", f24_arg0.clipFinished)
			end
			f24_arg0.FrontendFrameSelectedGlow:completeAnimation()
			f24_arg0.FrontendFrameSelectedGlow:setAlpha(0.1)
			f24_local4(f24_arg0.FrontendFrameSelectedGlow)
			local f24_local5 = function(f30_arg0)
				f24_arg0.FrontendFocusPip:beginAnimation(150, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
				f24_arg0.FrontendFocusPip:setAlpha(0)
				f24_arg0.FrontendFocusPip:setScale(1.06, 1.06)
				f24_arg0.FrontendFocusPip:registerEventHandler("interrupted_keyframe", f24_arg0.clipInterrupted)
				f24_arg0.FrontendFocusPip:registerEventHandler("transition_complete_keyframe", f24_arg0.clipFinished)
			end
			f24_arg0.FrontendFocusPip:completeAnimation()
			f24_arg0.FrontendFocusPip:setAlpha(0.3)
			f24_arg0.FrontendFocusPip:setScale(1, 1)
			f24_local5(f24_arg0.FrontendFocusPip)
		end,
	},
}
CoD.EmblemDrawWidgetNew.__onClose = function(f31_arg0)
	f31_arg0.EditorDrawEmblemFocusable:close()
	f31_arg0.emblemDrawingArea:close()
	f31_arg0.BMGoldBar:close()
end
