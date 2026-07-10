CoD.MPHintTextContainer = InheritFrom(LUI.UIElement)
CoD.MPHintTextContainer.__defaultWidth = 1288
CoD.MPHintTextContainer.__defaultHeight = 42
CoD.MPHintTextContainer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.MPHintTextContainer)
	self.id = "MPHintTextContainer"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local MPHintText = LUI.UIText.new(0.5, 0.5, -864, 864, 0.5, 0.5, -18, 18)
	MPHintText:setText("")
	MPHintText:setTTF("default")
	MPHintText:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	MPHintText:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	MPHintText:setBackingType(2)
	MPHintText:setBackingColor(0, 0, 0)
	MPHintText:setBackingXPadding(3)
	MPHintText:setBackingMaterial(LUI.UIImage.GetCachedMaterial(@"hash_381EEB1F96D4BE0A"))
	MPHintText:setBackingShaderVector(0, 0, 0, 0, 0)
	self:addElement(MPHintText)
	self.MPHintText = MPHintText
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.MPHintTextContainer.__resetProperties = function(f2_arg0)
	f2_arg0.MPHintText:completeAnimation()
	f2_arg0.MPHintText:setTopBottom(0.5, 0.5, -18, 18)
	f2_arg0.MPHintText:setAlpha(1)
end
CoD.MPHintTextContainer.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(1)
			f3_arg0.MPHintText:completeAnimation()
			f3_arg0.MPHintText:setAlpha(0)
			f3_arg0.clipFinished(f3_arg0.MPHintText)
		end,
		display_noblink = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(1)
			local f4_local0 = function(f5_arg0)
				f4_arg0.MPHintText:beginAnimation(200)
				f4_arg0.MPHintText:setTopBottom(0.5, 0.5, -21, 21)
				f4_arg0.MPHintText:setAlpha(1)
				f4_arg0.MPHintText:registerEventHandler("interrupted_keyframe", f4_arg0.clipInterrupted)
				f4_arg0.MPHintText:registerEventHandler("transition_complete_keyframe", f4_arg0.clipFinished)
			end
			f4_arg0.MPHintText:completeAnimation()
			f4_arg0.MPHintText:setTopBottom(0.5, 0.5, -18, 18)
			f4_arg0.MPHintText:setAlpha(0)
			f4_local0(f4_arg0.MPHintText)
		end,
	},
	display_noblink = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(1)
			f6_arg0.MPHintText:completeAnimation()
			f6_arg0.MPHintText:setTopBottom(0.5, 0.5, -21, 21)
			f6_arg0.MPHintText:setAlpha(1)
			f6_arg0.clipFinished(f6_arg0.MPHintText)
		end,
	},
}
