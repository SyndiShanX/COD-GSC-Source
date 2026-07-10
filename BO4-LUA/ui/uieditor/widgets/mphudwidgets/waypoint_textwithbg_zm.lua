CoD.Waypoint_TextWithBG_Zm = InheritFrom(LUI.UIElement)
CoD.Waypoint_TextWithBG_Zm.__defaultWidth = 384
CoD.Waypoint_TextWithBG_Zm.__defaultHeight = 38
CoD.Waypoint_TextWithBG_Zm.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Waypoint_TextWithBG_Zm)
	self.id = "Waypoint_TextWithBG_Zm"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local text = LUI.UIText.new(0.5, 0.5, -192, 192, 0.5, 0.5, -15, 15)
	text:setText(Engine[@"hash_4F9F1239CFD921FE"](@"menu/new"))
	text:setTTF("skorzhen")
	text:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_90D57B1E92D39D7"))
	text:setShaderVector(0, 0.8, 0, 0, 0)
	text:setShaderVector(1, 0, 0, 0, 0)
	text:setShaderVector(2, 1, 1, 1, 0.4)
	text:setLetterSpacing(2)
	text:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	text:setAlignment(Enum[@"luialignment"][@"lui_alignment_bottom"])
	text:setBackingType(2)
	text:setBackingXPadding(6)
	text:setBackingYPadding(4)
	text:setBackingImage(RegisterImage(@"hash_675D661B612187DF"))
	LUI.OverrideFunction_CallOriginalFirst(text, "setText", function(element, controller)
		ScaleWidgetToLabelCentered(self, element, 4)
	end)
	self:addElement(text)
	self.text = text
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.Waypoint_TextWithBG_Zm.__resetProperties = function(f3_arg0)
	f3_arg0.text:completeAnimation()
	f3_arg0.text:setAlpha(1)
end
CoD.Waypoint_TextWithBG_Zm.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(0)
		end,
	},
	Hidden = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			f5_arg0.text:completeAnimation()
			f5_arg0.text:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.text)
		end,
	},
}
