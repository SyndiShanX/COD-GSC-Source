CoD.WarzoneInventoryCalloutGestureHintText = InheritFrom(LUI.UIElement)
CoD.WarzoneInventoryCalloutGestureHintText.__defaultWidth = 470
CoD.WarzoneInventoryCalloutGestureHintText.__defaultHeight = 18
CoD.WarzoneInventoryCalloutGestureHintText.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WarzoneInventoryCalloutGestureHintText)
	self.id = "WarzoneInventoryCalloutGestureHintText"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local QuickLabel2 = LUI.UIText.new(0, 0, -63, 195, 0, 0, 0, 18)
	QuickLabel2:setText(LocalizeToUpperString(@"hash_2141F3EAEF2341BB"))
	QuickLabel2:setTTF("ttmussels_regular")
	QuickLabel2:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_90D57B1E92D39D7"))
	QuickLabel2:setShaderVector(0, 0.6, 0, 0, 0)
	QuickLabel2:setShaderVector(1, 0.3, 0, 0, 0)
	QuickLabel2:setShaderVector(2, 0, 0, 0, 1)
	QuickLabel2:setLetterSpacing(2)
	QuickLabel2:setAlignment(Enum[@"luialignment"][@"lui_alignment_right"])
	QuickLabel2:setAlignment(Enum[@"luialignment"][@"lui_alignment_middle"])
	self:addElement(QuickLabel2)
	self.QuickLabel2 = QuickLabel2
	local QuickLabel3 = LUI.UIText.new(0, 0, 275, 526, 0, 0, 0, 18)
	QuickLabel3:setText(LocalizeToUpperString(@"hash_34A2541E3E7EACED"))
	QuickLabel3:setTTF("ttmussels_regular")
	QuickLabel3:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_90D57B1E92D39D7"))
	QuickLabel3:setShaderVector(0, 0.6, 0, 0, 0)
	QuickLabel3:setShaderVector(1, 0.3, 0, 0, 0)
	QuickLabel3:setShaderVector(2, 0, 0, 0, 1)
	QuickLabel3:setLetterSpacing(2)
	QuickLabel3:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	QuickLabel3:setAlignment(Enum[@"luialignment"][@"lui_alignment_middle"])
	self:addElement(QuickLabel3)
	self.QuickLabel3 = QuickLabel3
	self:mergeStateConditions({
		{
			stateName = "HasActivatedCallotusOrGestures",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.WarzoneInventoryCalloutGestureHintText.__resetProperties = function(f3_arg0)
	f3_arg0.QuickLabel2:completeAnimation()
	f3_arg0.QuickLabel3:completeAnimation()
	f3_arg0.QuickLabel2:setAlpha(1)
	f3_arg0.QuickLabel3:setAlpha(1)
end
CoD.WarzoneInventoryCalloutGestureHintText.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(2)
			local f4_local0 = function(f5_arg0)
				local f5_local0 = function(f6_arg0)
					f6_arg0:beginAnimation(300)
					f6_arg0:setAlpha(0)
					f6_arg0:registerEventHandler("transition_complete_keyframe", f4_arg0.clipFinished)
				end
				f4_arg0.QuickLabel2:beginAnimation(5000)
				f4_arg0.QuickLabel2:registerEventHandler("interrupted_keyframe", f4_arg0.clipInterrupted)
				f4_arg0.QuickLabel2:registerEventHandler("transition_complete_keyframe", f5_local0)
			end
			f4_arg0.QuickLabel2:completeAnimation()
			f4_arg0.QuickLabel2:setAlpha(1)
			f4_local0(f4_arg0.QuickLabel2)
			local f4_local1 = function(f7_arg0)
				local f7_local0 = function(f8_arg0)
					f8_arg0:beginAnimation(300)
					f8_arg0:setAlpha(0)
					f8_arg0:registerEventHandler("transition_complete_keyframe", f4_arg0.clipFinished)
				end
				f4_arg0.QuickLabel3:beginAnimation(5000)
				f4_arg0.QuickLabel3:registerEventHandler("interrupted_keyframe", f4_arg0.clipInterrupted)
				f4_arg0.QuickLabel3:registerEventHandler("transition_complete_keyframe", f7_local0)
			end
			f4_arg0.QuickLabel3:completeAnimation()
			f4_arg0.QuickLabel3:setAlpha(1)
			f4_local1(f4_arg0.QuickLabel3)
		end,
		HasActivatedCallotusOrGestures = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(2)
			local f9_local0 = function(f10_arg0)
				f9_arg0.QuickLabel2:beginAnimation(200)
				f9_arg0.QuickLabel2:setAlpha(0)
				f9_arg0.QuickLabel2:registerEventHandler("interrupted_keyframe", f9_arg0.clipInterrupted)
				f9_arg0.QuickLabel2:registerEventHandler("transition_complete_keyframe", f9_arg0.clipFinished)
			end
			f9_arg0.QuickLabel2:completeAnimation()
			f9_arg0.QuickLabel2:setAlpha(1)
			f9_local0(f9_arg0.QuickLabel2)
			local f9_local1 = function(f11_arg0)
				f9_arg0.QuickLabel3:beginAnimation(200)
				f9_arg0.QuickLabel3:setAlpha(0)
				f9_arg0.QuickLabel3:registerEventHandler("interrupted_keyframe", f9_arg0.clipInterrupted)
				f9_arg0.QuickLabel3:registerEventHandler("transition_complete_keyframe", f9_arg0.clipFinished)
			end
			f9_arg0.QuickLabel3:completeAnimation()
			f9_arg0.QuickLabel3:setAlpha(1)
			f9_local1(f9_arg0.QuickLabel3)
		end,
	},
	HasActivatedCallotusOrGestures = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(2)
			f12_arg0.QuickLabel2:completeAnimation()
			f12_arg0.QuickLabel2:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.QuickLabel2)
			f12_arg0.QuickLabel3:completeAnimation()
			f12_arg0.QuickLabel3:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.QuickLabel3)
		end,
	},
}
