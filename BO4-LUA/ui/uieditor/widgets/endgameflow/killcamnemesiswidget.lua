require("x64:30310b25e42d7ee")
CoD.KillcamNemesisWidget = InheritFrom(LUI.UIElement)
CoD.KillcamNemesisWidget.__defaultWidth = 327
CoD.KillcamNemesisWidget.__defaultHeight = 168
CoD.KillcamNemesisWidget.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.KillcamNemesisWidget)
	self.id = "KillcamNemesisWidget"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Nemesisbar = LUI.UIImage.new(0.5, 0.5, -538, 538, 0, 0, 128, 162)
	Nemesisbar:setRGB(0.54, 0.01, 0.01)
	Nemesisbar:setImage(RegisterImage(@"uie_ui_hud_nemesis_bar"))
	self:addElement(Nemesisbar)
	self.Nemesisbar = Nemesisbar
	local KillsLabel20 = LUI.UIText.new(0.5, 0.5, -88, 91, 0, 0, 132, 159)
	KillsLabel20:setRGB(0.92, 0.92, 0.92)
	KillsLabel20:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_330FB1CA77CF4B0C"))
	KillsLabel20:setTTF("0arame_mono_stencil")
	KillsLabel20:setLetterSpacing(4)
	KillsLabel20:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	KillsLabel20:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(KillsLabel20)
	self.KillsLabel20 = KillsLabel20
	local NemesisIcon = LUI.UIImage.new(0, 0, 42.5, 290.5, 0, 0, -14, 86)
	NemesisIcon:setRGB(0.65, 0, 0)
	NemesisIcon:setScale(0.8, 0.8)
	NemesisIcon:setImage(RegisterImage(@"uie_ui_hud_nemesis_icon"))
	self:addElement(NemesisIcon)
	self.NemesisIcon = NemesisIcon
	local NemesisSkull = LUI.UIImage.new(0, 0, 42.5, 290.5, 0, 0, -24, 76)
	NemesisSkull:setScale(0.75, 0.75)
	NemesisSkull:setImage(RegisterImage(@"uie_ui_hud_nemesis_skull"))
	self:addElement(NemesisSkull)
	self.NemesisSkull = NemesisSkull
	local KillcamNemesisArrow = CoD.KillcamNemesisArrow.new(f1_arg0, f1_arg1, 0, 0, 91, 237, 0, 0, -9, 51)
	KillcamNemesisArrow:setScale(1.2, 1.2)
	self:addElement(KillcamNemesisArrow)
	self.KillcamNemesisArrow = KillcamNemesisArrow
	local spark = LUI.UIImage.new(0, 0, -92, 420, 0, 0, -235, 277)
	spark:setScale(1.2, 1.2)
	spark:setImage(RegisterImage(@"hash_786A85E0C09931D2"))
	spark:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(spark)
	self.spark = spark
	self:mergeStateConditions({
		{
			stateName = "NemesisKillcam",
			condition = function(menu, element, event)
				return Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_nemesis_killcam"])
			end,
		},
	})
	local f1_local7 = self
	local f1_local8 = self.subscribeToModel
	local f1_local9 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local8(f1_local7, f1_local9["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_nemesis_killcam"]], function(f3_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f3_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_nemesis_killcam"],
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.KillcamNemesisWidget.__resetProperties = function(f4_arg0)
	f4_arg0.KillsLabel20:completeAnimation()
	f4_arg0.NemesisIcon:completeAnimation()
	f4_arg0.Nemesisbar:completeAnimation()
	f4_arg0.NemesisSkull:completeAnimation()
	f4_arg0.KillcamNemesisArrow:completeAnimation()
	f4_arg0.spark:completeAnimation()
	f4_arg0.KillsLabel20:setAlpha(1)
	f4_arg0.NemesisIcon:setTopBottom(0, 0, -14, 86)
	f4_arg0.NemesisIcon:setAlpha(1)
	f4_arg0.Nemesisbar:setAlpha(1)
	f4_arg0.NemesisSkull:setTopBottom(0, 0, -24, 76)
	f4_arg0.NemesisSkull:setAlpha(1)
	f4_arg0.KillcamNemesisArrow:setTopBottom(0, 0, -9, 51)
	f4_arg0.KillcamNemesisArrow:setAlpha(1)
	f4_arg0.spark:setTopBottom(0, 0, -235, 277)
	f4_arg0.spark:setAlpha(1)
	f4_arg0.spark:setScale(1.2, 1.2)
end
CoD.KillcamNemesisWidget.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(6)
			f5_arg0.Nemesisbar:completeAnimation()
			f5_arg0.Nemesisbar:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.Nemesisbar)
			f5_arg0.KillsLabel20:completeAnimation()
			f5_arg0.KillsLabel20:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.KillsLabel20)
			f5_arg0.NemesisIcon:completeAnimation()
			f5_arg0.NemesisIcon:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.NemesisIcon)
			f5_arg0.NemesisSkull:completeAnimation()
			f5_arg0.NemesisSkull:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.NemesisSkull)
			f5_arg0.KillcamNemesisArrow:completeAnimation()
			f5_arg0.KillcamNemesisArrow:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.KillcamNemesisArrow)
			f5_arg0.spark:completeAnimation()
			f5_arg0.spark:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.spark)
		end,
	},
	NemesisKillcam = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(5)
			local f6_local0 = function(f7_arg0)
				local f7_local0 = function(f8_arg0)
					f8_arg0:beginAnimation(160)
					f8_arg0:setAlpha(1)
					f8_arg0:registerEventHandler("transition_complete_keyframe", f6_arg0.clipFinished)
				end
				f6_arg0.KillsLabel20:beginAnimation(700)
				f6_arg0.KillsLabel20:registerEventHandler("interrupted_keyframe", f6_arg0.clipInterrupted)
				f6_arg0.KillsLabel20:registerEventHandler("transition_complete_keyframe", f7_local0)
			end
			f6_arg0.KillsLabel20:completeAnimation()
			f6_arg0.KillsLabel20:setAlpha(0)
			f6_local0(f6_arg0.KillsLabel20)
			local f6_local1 = function(f9_arg0)
				local f9_local0 = function(f10_arg0)
					f10_arg0:beginAnimation(160)
					f10_arg0:setTopBottom(0, 0, -11, 89)
					f10_arg0:setAlpha(1)
					f10_arg0:registerEventHandler("transition_complete_keyframe", f6_arg0.clipFinished)
				end
				f6_arg0.NemesisIcon:beginAnimation(700)
				f6_arg0.NemesisIcon:registerEventHandler("interrupted_keyframe", f6_arg0.clipInterrupted)
				f6_arg0.NemesisIcon:registerEventHandler("transition_complete_keyframe", f9_local0)
			end
			f6_arg0.NemesisIcon:completeAnimation()
			f6_arg0.NemesisIcon:setTopBottom(0, 0, -82, 18)
			f6_arg0.NemesisIcon:setAlpha(0)
			f6_local1(f6_arg0.NemesisIcon)
			local f6_local2 = function(f11_arg0)
				local f11_local0 = function(f12_arg0)
					f12_arg0:beginAnimation(160)
					f12_arg0:setTopBottom(0, 0, -11, 89)
					f12_arg0:setAlpha(1)
					f12_arg0:registerEventHandler("transition_complete_keyframe", f6_arg0.clipFinished)
				end
				f6_arg0.NemesisSkull:beginAnimation(700)
				f6_arg0.NemesisSkull:registerEventHandler("interrupted_keyframe", f6_arg0.clipInterrupted)
				f6_arg0.NemesisSkull:registerEventHandler("transition_complete_keyframe", f11_local0)
			end
			f6_arg0.NemesisSkull:completeAnimation()
			f6_arg0.NemesisSkull:setTopBottom(0, 0, -81, 19)
			f6_arg0.NemesisSkull:setAlpha(0)
			f6_local2(f6_arg0.NemesisSkull)
			local f6_local3 = function(f13_arg0)
				local f13_local0 = function(f14_arg0)
					f14_arg0:beginAnimation(160)
					f14_arg0:registerEventHandler("transition_complete_keyframe", f6_arg0.clipFinished)
				end
				f6_arg0.KillcamNemesisArrow:beginAnimation(700)
				f6_arg0.KillcamNemesisArrow:setAlpha(0)
				f6_arg0.KillcamNemesisArrow:registerEventHandler("interrupted_keyframe", f6_arg0.clipInterrupted)
				f6_arg0.KillcamNemesisArrow:registerEventHandler("transition_complete_keyframe", f13_local0)
			end
			f6_arg0.KillcamNemesisArrow:completeAnimation()
			f6_arg0.KillcamNemesisArrow:setTopBottom(0, 0, -23, 37)
			f6_arg0.KillcamNemesisArrow:setAlpha(1)
			f6_local3(f6_arg0.KillcamNemesisArrow)
			local f6_local4 = function(f15_arg0)
				local f15_local0 = function(f16_arg0)
					local f16_local0 = function(f17_arg0)
						f17_arg0:beginAnimation(19)
						f17_arg0:setAlpha(0)
						f17_arg0:setScale(0, 0)
						f17_arg0:registerEventHandler("transition_complete_keyframe", f6_arg0.clipFinished)
					end
					f16_arg0:beginAnimation(9)
					f16_arg0:setAlpha(0.67)
					f16_arg0:setScale(1.25, 1.25)
					f16_arg0:registerEventHandler("transition_complete_keyframe", f16_local0)
				end
				f15_arg0:beginAnimation(20)
				f15_arg0:setAlpha(1)
				f15_arg0:setScale(1, 0.1)
				f15_arg0:registerEventHandler("transition_complete_keyframe", f15_local0)
			end
			f6_arg0.spark:beginAnimation(840)
			f6_arg0.spark:setTopBottom(0, 0, -249, 263)
			f6_arg0.spark:setAlpha(0)
			f6_arg0.spark:setScale(0.5, 1)
			f6_arg0.spark:registerEventHandler("interrupted_keyframe", f6_arg0.clipInterrupted)
			f6_arg0.spark:registerEventHandler("transition_complete_keyframe", f6_local4)
		end,
	},
}
CoD.KillcamNemesisWidget.__onClose = function(f18_arg0)
	f18_arg0.KillcamNemesisArrow:close()
end
