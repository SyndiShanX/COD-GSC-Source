require("x64:98f1288a89a9af6")
CoD.EmblemDrawWidgetNoImage = InheritFrom(LUI.UIElement)
CoD.EmblemDrawWidgetNoImage.__defaultWidth = 540
CoD.EmblemDrawWidgetNoImage.__defaultHeight = 540
CoD.EmblemDrawWidgetNoImage.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.EmblemDrawWidgetNoImage)
	self.id = "EmblemDrawWidgetNoImage"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local CommonDetailPanel = CoD.CommonDetailPanel.new(f1_arg0, f1_arg1, 0, 0, 0, 540, 0, 0, 0, 540)
	CommonDetailPanel:setAlpha(0)
	self:addElement(CommonDetailPanel)
	self.CommonDetailPanel = CommonDetailPanel
	local BgImage01 = LUI.UIImage.new(0, 0, 0, 540, 0, 0, 0, 540)
	BgImage01:setAlpha(0.5)
	BgImage01:setImage(RegisterImage(@"uie_ui_menu_specialist_hub_repeat_bg"))
	BgImage01:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	BgImage01:setShaderVector(0, 0, 0, 0, 0)
	BgImage01:setupNineSliceShader(196, 88)
	self:addElement(BgImage01)
	self.BgImage01 = BgImage01
	local TiledPlusGrid = LUI.UIImage.new(0, 0, -663, 1137, 0, 0, -649, 1151)
	TiledPlusGrid:setAlpha(0)
	TiledPlusGrid:setScale(0.3, 0.3)
	TiledPlusGrid:setImage(RegisterImage(@"uie_ui_hud_vehicle_hellstorm_repeat_plusgrid"))
	TiledPlusGrid:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_67C9C02F608D0A75"))
	TiledPlusGrid:setShaderVector(0, 0, 0, 0, 0)
	TiledPlusGrid:setupNineSliceShader(220, 220)
	self:addElement(TiledPlusGrid)
	self.TiledPlusGrid = TiledPlusGrid
	local FrontendFrame02 = LUI.UIImage.new(0.5, 1.5, -271, -269, 0.5, 1.5, -271, -269)
	FrontendFrame02:setAlpha(0.2)
	FrontendFrame02:setImage(RegisterImage(@"uie_ui_menu_store_common_frame"))
	FrontendFrame02:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_add"))
	FrontendFrame02:setShaderVector(0, 0, 0, 0, 0)
	FrontendFrame02:setupNineSliceShader(12, 12)
	self:addElement(FrontendFrame02)
	self.FrontendFrame02 = FrontendFrame02
	local FrontendFrame01 = LUI.UIImage.new(0.5, 1.5, -270, -270, 0.5, 1.5, -270, -270)
	FrontendFrame01:setAlpha(0.2)
	FrontendFrame01:setImage(RegisterImage(@"uie_ui_menu_store_common_frame"))
	FrontendFrame01:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_add"))
	FrontendFrame01:setShaderVector(0, 0, 0, 0, 0)
	FrontendFrame01:setupNineSliceShader(12, 12)
	self:addElement(FrontendFrame01)
	self.FrontendFrame01 = FrontendFrame01
	local FrontendFrameSelected = LUI.UIImage.new(0, 1, -4, 4, 0, 1, -4, 4)
	FrontendFrameSelected:setAlpha(0)
	FrontendFrameSelected:setImage(RegisterImage(@"uie_ui_menu_store_focus_frame"))
	FrontendFrameSelected:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_add"))
	FrontendFrameSelected:setShaderVector(0, 0, 0, 0, 0)
	FrontendFrameSelected:setupNineSliceShader(12, 12)
	self:addElement(FrontendFrameSelected)
	self.FrontendFrameSelected = FrontendFrameSelected
	local FrontendFrameSelectedGlow = LUI.UIImage.new(0, 1, -12, 12, 0, 1, -12, 12)
	FrontendFrameSelectedGlow:setAlpha(0)
	FrontendFrameSelectedGlow:setImage(RegisterImage(@"uie_ui_menu_store_focus_frame"))
	FrontendFrameSelectedGlow:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_add"))
	FrontendFrameSelectedGlow:setShaderVector(0, 0, 0, 0, 0)
	FrontendFrameSelectedGlow:setupNineSliceShader(40, 40)
	self:addElement(FrontendFrameSelectedGlow)
	self.FrontendFrameSelectedGlow = FrontendFrameSelectedGlow
	local FrontendFocusPip = LUI.UIImage.new(0, 1, -7, 7, 0, 1, -7, 7)
	FrontendFocusPip:setAlpha(0)
	FrontendFocusPip:setScale(1.06, 1.06)
	FrontendFocusPip:setImage(RegisterImage(@"uie_ui_menu_store_focus_pips"))
	FrontendFocusPip:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_add"))
	FrontendFocusPip:setShaderVector(0, 0, 0, 0, 0)
	FrontendFocusPip:setupNineSliceShader(52, 52)
	self:addElement(FrontendFocusPip)
	self.FrontendFocusPip = FrontendFocusPip
	self:mergeStateConditions({
		{
			stateName = "BMClassified",
			condition = function(menu, element, event)
				return AlwaysFalse()
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
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.EmblemDrawWidgetNoImage.__resetProperties = function(f6_arg0)
	f6_arg0.TiledPlusGrid:completeAnimation()
	f6_arg0.FrontendFrame01:completeAnimation()
	f6_arg0.FrontendFrame02:completeAnimation()
	f6_arg0.FrontendFrameSelected:completeAnimation()
	f6_arg0.FrontendFrameSelectedGlow:completeAnimation()
	f6_arg0.FrontendFocusPip:completeAnimation()
	f6_arg0.TiledPlusGrid:setAlpha(0)
	f6_arg0.FrontendFrame01:setAlpha(0.2)
	f6_arg0.FrontendFrame02:setAlpha(0.2)
	f6_arg0.FrontendFrameSelected:setAlpha(0)
	f6_arg0.FrontendFrameSelectedGlow:setAlpha(0)
	f6_arg0.FrontendFocusPip:setAlpha(0)
	f6_arg0.FrontendFocusPip:setScale(1.06, 1.06)
end
CoD.EmblemDrawWidgetNoImage.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			f7_arg0.TiledPlusGrid:completeAnimation()
			f7_arg0.TiledPlusGrid:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.TiledPlusGrid)
		end,
		EditMode = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(6)
			f8_arg0.TiledPlusGrid:completeAnimation()
			f8_arg0.TiledPlusGrid:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.TiledPlusGrid)
			local f8_local0 = function(f9_arg0)
				f8_arg0.FrontendFrame02:beginAnimation(150)
				f8_arg0.FrontendFrame02:setAlpha(1)
				f8_arg0.FrontendFrame02:registerEventHandler("interrupted_keyframe", f8_arg0.clipInterrupted)
				f8_arg0.FrontendFrame02:registerEventHandler("transition_complete_keyframe", f8_arg0.clipFinished)
			end
			f8_arg0.FrontendFrame02:completeAnimation()
			f8_arg0.FrontendFrame02:setAlpha(0.2)
			f8_local0(f8_arg0.FrontendFrame02)
			local f8_local1 = function(f10_arg0)
				f8_arg0.FrontendFrame01:beginAnimation(150)
				f8_arg0.FrontendFrame01:setAlpha(1)
				f8_arg0.FrontendFrame01:registerEventHandler("interrupted_keyframe", f8_arg0.clipInterrupted)
				f8_arg0.FrontendFrame01:registerEventHandler("transition_complete_keyframe", f8_arg0.clipFinished)
			end
			f8_arg0.FrontendFrame01:completeAnimation()
			f8_arg0.FrontendFrame01:setAlpha(0.2)
			f8_local1(f8_arg0.FrontendFrame01)
			local f8_local2 = function(f11_arg0)
				f8_arg0.FrontendFrameSelected:beginAnimation(150, Enum[@"luitween"][@"luitween_ease_both"])
				f8_arg0.FrontendFrameSelected:setAlpha(1)
				f8_arg0.FrontendFrameSelected:registerEventHandler("interrupted_keyframe", f8_arg0.clipInterrupted)
				f8_arg0.FrontendFrameSelected:registerEventHandler("transition_complete_keyframe", f8_arg0.clipFinished)
			end
			f8_arg0.FrontendFrameSelected:completeAnimation()
			f8_arg0.FrontendFrameSelected:setAlpha(0)
			f8_local2(f8_arg0.FrontendFrameSelected)
			local f8_local3 = function(f12_arg0)
				f8_arg0.FrontendFrameSelectedGlow:beginAnimation(150)
				f8_arg0.FrontendFrameSelectedGlow:setAlpha(0.05)
				f8_arg0.FrontendFrameSelectedGlow:registerEventHandler("interrupted_keyframe", f8_arg0.clipInterrupted)
				f8_arg0.FrontendFrameSelectedGlow:registerEventHandler("transition_complete_keyframe", f8_arg0.clipFinished)
			end
			f8_arg0.FrontendFrameSelectedGlow:completeAnimation()
			f8_arg0.FrontendFrameSelectedGlow:setAlpha(0)
			f8_local3(f8_arg0.FrontendFrameSelectedGlow)
			local f8_local4 = function(f13_arg0)
				f8_arg0.FrontendFocusPip:beginAnimation(150, Enum[@"luitween"][@"luitween_ease_in"])
				f8_arg0.FrontendFocusPip:setAlpha(0.3)
				f8_arg0.FrontendFocusPip:setScale(1, 1)
				f8_arg0.FrontendFocusPip:registerEventHandler("interrupted_keyframe", f8_arg0.clipInterrupted)
				f8_arg0.FrontendFocusPip:registerEventHandler("transition_complete_keyframe", f8_arg0.clipFinished)
			end
			f8_arg0.FrontendFocusPip:completeAnimation()
			f8_arg0.FrontendFocusPip:setAlpha(0)
			f8_arg0.FrontendFocusPip:setScale(1.06, 1.06)
			f8_local4(f8_arg0.FrontendFocusPip)
		end,
	},
	BMClassified = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(0)
		end,
	},
	Unfocusable = {
		DefaultClip = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(1)
			f15_arg0.FrontendFrame02:completeAnimation()
			f15_arg0.FrontendFrame02:setAlpha(0.2)
			f15_arg0.clipFinished(f15_arg0.FrontendFrame02)
		end,
	},
	EmptySlot = {
		DefaultClip = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(2)
			f16_arg0.TiledPlusGrid:completeAnimation()
			f16_arg0.TiledPlusGrid:setAlpha(0.1)
			f16_arg0.clipFinished(f16_arg0.TiledPlusGrid)
			f16_arg0.FrontendFrame02:completeAnimation()
			f16_arg0.FrontendFrame02:setAlpha(0.2)
			f16_arg0.clipFinished(f16_arg0.FrontendFrame02)
		end,
	},
	EditMode = {
		DefaultClip = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(5)
			f17_arg0.FrontendFrame02:completeAnimation()
			f17_arg0.FrontendFrame02:setAlpha(1)
			f17_arg0.clipFinished(f17_arg0.FrontendFrame02)
			f17_arg0.FrontendFrame01:completeAnimation()
			f17_arg0.FrontendFrame01:setAlpha(1)
			f17_arg0.clipFinished(f17_arg0.FrontendFrame01)
			f17_arg0.FrontendFrameSelected:completeAnimation()
			f17_arg0.FrontendFrameSelected:setAlpha(1)
			f17_arg0.clipFinished(f17_arg0.FrontendFrameSelected)
			f17_arg0.FrontendFrameSelectedGlow:completeAnimation()
			f17_arg0.FrontendFrameSelectedGlow:setAlpha(0.05)
			f17_arg0.clipFinished(f17_arg0.FrontendFrameSelectedGlow)
			f17_arg0.FrontendFocusPip:completeAnimation()
			f17_arg0.FrontendFocusPip:setAlpha(0.3)
			f17_arg0.FrontendFocusPip:setScale(1, 1)
			f17_arg0.clipFinished(f17_arg0.FrontendFocusPip)
		end,
		DefaultState = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(6)
			f18_arg0.TiledPlusGrid:completeAnimation()
			f18_arg0.TiledPlusGrid:setAlpha(0)
			f18_arg0.clipFinished(f18_arg0.TiledPlusGrid)
			local f18_local0 = function(f19_arg0)
				f18_arg0.FrontendFrame02:beginAnimation(150)
				f18_arg0.FrontendFrame02:setAlpha(0.2)
				f18_arg0.FrontendFrame02:registerEventHandler("interrupted_keyframe", f18_arg0.clipInterrupted)
				f18_arg0.FrontendFrame02:registerEventHandler("transition_complete_keyframe", f18_arg0.clipFinished)
			end
			f18_arg0.FrontendFrame02:completeAnimation()
			f18_arg0.FrontendFrame02:setAlpha(1)
			f18_local0(f18_arg0.FrontendFrame02)
			local f18_local1 = function(f20_arg0)
				f18_arg0.FrontendFrame01:beginAnimation(150)
				f18_arg0.FrontendFrame01:setAlpha(0.2)
				f18_arg0.FrontendFrame01:registerEventHandler("interrupted_keyframe", f18_arg0.clipInterrupted)
				f18_arg0.FrontendFrame01:registerEventHandler("transition_complete_keyframe", f18_arg0.clipFinished)
			end
			f18_arg0.FrontendFrame01:completeAnimation()
			f18_arg0.FrontendFrame01:setAlpha(1)
			f18_local1(f18_arg0.FrontendFrame01)
			local f18_local2 = function(f21_arg0)
				f18_arg0.FrontendFrameSelected:beginAnimation(150, Enum[@"luitween"][@"luitween_ease_both"])
				f18_arg0.FrontendFrameSelected:setAlpha(0)
				f18_arg0.FrontendFrameSelected:registerEventHandler("interrupted_keyframe", f18_arg0.clipInterrupted)
				f18_arg0.FrontendFrameSelected:registerEventHandler("transition_complete_keyframe", f18_arg0.clipFinished)
			end
			f18_arg0.FrontendFrameSelected:completeAnimation()
			f18_arg0.FrontendFrameSelected:setAlpha(1)
			f18_local2(f18_arg0.FrontendFrameSelected)
			local f18_local3 = function(f22_arg0)
				f18_arg0.FrontendFrameSelectedGlow:beginAnimation(150)
				f18_arg0.FrontendFrameSelectedGlow:setAlpha(0)
				f18_arg0.FrontendFrameSelectedGlow:registerEventHandler("interrupted_keyframe", f18_arg0.clipInterrupted)
				f18_arg0.FrontendFrameSelectedGlow:registerEventHandler("transition_complete_keyframe", f18_arg0.clipFinished)
			end
			f18_arg0.FrontendFrameSelectedGlow:completeAnimation()
			f18_arg0.FrontendFrameSelectedGlow:setAlpha(0.05)
			f18_local3(f18_arg0.FrontendFrameSelectedGlow)
			local f18_local4 = function(f23_arg0)
				f18_arg0.FrontendFocusPip:beginAnimation(150, Enum[@"luitween"][@"luitween_ease_out"])
				f18_arg0.FrontendFocusPip:setAlpha(0)
				f18_arg0.FrontendFocusPip:setScale(1.06, 1.06)
				f18_arg0.FrontendFocusPip:registerEventHandler("interrupted_keyframe", f18_arg0.clipInterrupted)
				f18_arg0.FrontendFocusPip:registerEventHandler("transition_complete_keyframe", f18_arg0.clipFinished)
			end
			f18_arg0.FrontendFocusPip:completeAnimation()
			f18_arg0.FrontendFocusPip:setAlpha(0.3)
			f18_arg0.FrontendFocusPip:setScale(1, 1)
			f18_local4(f18_arg0.FrontendFocusPip)
		end,
	},
}
CoD.EmblemDrawWidgetNoImage.__onClose = function(f24_arg0)
	f24_arg0.CommonDetailPanel:close()
end
