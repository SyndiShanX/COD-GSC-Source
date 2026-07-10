CoD.AttachmentDescriptionHeader = InheritFrom(LUI.UIElement)
CoD.AttachmentDescriptionHeader.__defaultWidth = 200
CoD.AttachmentDescriptionHeader.__defaultHeight = 30
CoD.AttachmentDescriptionHeader.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.AttachmentDescriptionHeader)
	self.id = "AttachmentDescriptionHeader"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local IconBacking = LUI.UIImage.new(0, 0, 0, 37, 0, 1, 0, 0)
	IconBacking:setRGB(0, 0, 0)
	IconBacking:setAlpha(0.5)
	IconBacking:setScale(1.01, 1.01)
	self:addElement(IconBacking)
	self.IconBacking = IconBacking
	local Icon = LUI.UIImage.new(0, 0, -4, 41, 0, 0, 0, 30)
	Icon:linkToElementModel(self, "image", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			Icon:setImage(RegisterImage(f2_local0))
		end
	end)
	self:addElement(Icon)
	self.Icon = Icon
	local Text = LUI.UIText.new(0, 0, 39, 339, 0, 0, 4, 26)
	Text:setTTF("ttmussels_regular")
	Text:setLetterSpacing(2)
	Text:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	Text:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	Text:setBackingType(2)
	Text:setBackingColor(0, 0, 0)
	Text:setBackingAlpha(0.5)
	Text:setBackingXPadding(2)
	Text:setBackingYPadding(4)
	Text:linkToElementModel(self, "displayName", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			Text:setText(Engine[@"hash_4F9F1239CFD921FE"](f3_local0))
		end
	end)
	self:addElement(Text)
	self.Text = Text
	self:mergeStateConditions({
		{
			stateName = "Left",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "stateLeft")
			end,
		},
	})
	self:linkToElementModel(self, "stateLeft", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "stateLeft",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.AttachmentDescriptionHeader.__resetProperties = function(f6_arg0)
	f6_arg0.Icon:completeAnimation()
	f6_arg0.Text:completeAnimation()
	f6_arg0.IconBacking:completeAnimation()
	f6_arg0.Icon:setLeftRight(0, 0, -4, 41)
	f6_arg0.Text:setLeftRight(0, 0, 39, 339)
	f6_arg0.Text:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	f6_arg0.IconBacking:setLeftRight(0, 0, 0, 37)
end
CoD.AttachmentDescriptionHeader.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(0)
		end,
	},
	Left = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(3)
			f8_arg0.IconBacking:completeAnimation()
			f8_arg0.IconBacking:setLeftRight(0.84, 1, 0, 0)
			f8_arg0.clipFinished(f8_arg0.IconBacking)
			f8_arg0.Icon:completeAnimation()
			f8_arg0.Icon:setLeftRight(0, 0, 168, 213)
			f8_arg0.clipFinished(f8_arg0.Icon)
			f8_arg0.Text:completeAnimation()
			f8_arg0.Text:setLeftRight(0, 0, -134, 166)
			f8_arg0.Text:setAlignment(Enum[@"luialignment"][@"lui_alignment_right"])
			f8_arg0.clipFinished(f8_arg0.Text)
		end,
	},
}
CoD.AttachmentDescriptionHeader.__onClose = function(f9_arg0)
	f9_arg0.Icon:close()
	f9_arg0.Text:close()
end
