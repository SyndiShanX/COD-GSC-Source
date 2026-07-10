CoD.verticalScrollingTextContainer = InheritFrom(LUI.UIElement)
CoD.verticalScrollingTextContainer.__defaultWidth = 900
CoD.verticalScrollingTextContainer.__defaultHeight = 21
CoD.verticalScrollingTextContainer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.verticalScrollingTextContainer)
	self.id = "verticalScrollingTextContainer"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local text = LUI.UIText.new(0, 1, 0, 0, 0, 0, 0, 21)
	text:setText(Engine[@"hash_4F9F1239CFD921FE"](@"menu/new"))
	text:setTTF("dinnext_regular")
	text:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_171E049B161CD00A"))
	text:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	text:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(text)
	self.text = text
	self:mergeStateConditions({
		{
			stateName = "PC",
			condition = function(menu, element, event)
				return IsPC()
			end,
		},
	})
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.verticalScrollingTextContainer.__resetProperties = function(f3_arg0)
	f3_arg0.text:completeAnimation()
	f3_arg0.text:setLeftRight(0, 1, 0, 0)
end
CoD.verticalScrollingTextContainer.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(0)
		end,
	},
	PC = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			f5_arg0.text:completeAnimation()
			f5_arg0.text:setLeftRight(0, 1, 15, -15)
			f5_arg0.clipFinished(f5_arg0.text)
		end,
	},
}
