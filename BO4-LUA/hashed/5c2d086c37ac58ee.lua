CoD.BountyHunterHealthCount = InheritFrom(LUI.UIElement)
CoD.BountyHunterHealthCount.__defaultWidth = 27
CoD.BountyHunterHealthCount.__defaultHeight = 24
CoD.BountyHunterHealthCount.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.BountyHunterHealthCount)
	self.id = "BountyHunterHealthCount"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local BountyHealthCount = LUI.UIImage.new(0, 0, 0, 27, 0, 0, 0, 24)
	BountyHealthCount:setRGB(0, 0, 0)
	BountyHealthCount:setAlpha(0)
	self:addElement(BountyHealthCount)
	self.BountyHealthCount = BountyHealthCount
	local Text = LUI.UIText.new(0, 0, 2.5, 24.5, 0, 0, 1.5, 22.5)
	Text:setAlpha(0)
	Text:setTTF("0arame_mono_stencil")
	Text:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	Text:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	Text:subscribeToGlobalModel(f1_arg1, "HUDItems", "numHealthPickups", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			Text:setText(CoD.BaseUtility.AlreadyLocalized(f2_local0))
		end
	end)
	self:addElement(Text)
	self.Text = Text
	self:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return CoD.BountyHunterUtility.GameTypeIsBounty(f1_arg1) and CoD.ModelUtility.IsModelValueGreaterThan(f1_arg1, "hudItems.numHealthPickups", 0)
			end,
		},
	})
	local f1_local3 = self
	local f1_local4 = self.subscribeToModel
	local f1_local5 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local4(f1_local3, f1_local5["hudItems.numHealthPickups"], function(f4_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f4_arg0:get(),
			modelName = "hudItems.numHealthPickups",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.BountyHunterHealthCount.__resetProperties = function(f5_arg0)
	f5_arg0.BountyHealthCount:completeAnimation()
	f5_arg0.Text:completeAnimation()
	f5_arg0.BountyHealthCount:setAlpha(0)
	f5_arg0.Text:setAlpha(0)
end
CoD.BountyHunterHealthCount.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(0)
		end,
	},
	Visible = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(2)
			f7_arg0.BountyHealthCount:completeAnimation()
			f7_arg0.BountyHealthCount:setAlpha(1)
			f7_arg0.clipFinished(f7_arg0.BountyHealthCount)
			f7_arg0.Text:completeAnimation()
			f7_arg0.Text:setAlpha(1)
			f7_arg0.clipFinished(f7_arg0.Text)
		end,
	},
}
CoD.BountyHunterHealthCount.__onClose = function(f8_arg0)
	f8_arg0.Text:close()
end
