CoD.freeCursorHeaderLabelPC = InheritFrom(LUI.UIElement)
CoD.freeCursorHeaderLabelPC.__defaultWidth = 405
CoD.freeCursorHeaderLabelPC.__defaultHeight = 36
CoD.freeCursorHeaderLabelPC.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.freeCursorHeaderLabelPC)
	self.id = "freeCursorHeaderLabelPC"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local backing = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	backing:setRGB(0.09, 0.09, 0.09)
	backing:setAlpha(0)
	self:addElement(backing)
	self.backing = backing
	local title = LUI.UIText.new(0, 0, 10, 210, 0, 0, 7, 29)
	title:setRGB(0.86, 0.74, 0.25)
	title:setTTF("ttmussels_regular")
	title:setMaterial(LUI.UIImage.GetCachedMaterial(0x71E049B161CD00A))
	title:setLetterSpacing(4)
	title:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	title:setBackingType(2)
	title:setBackingColor(0.09, 0.09, 0.09)
	title:setBackingAlpha(0)
	title:setBackingXPadding(10)
	title:setBackingYPadding(7)
	title:linkToElementModel(self, "title", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			title:setText(LocalizeToUpperString(f2_local0))
		end
	end)
	LUI.OverrideFunction_CallOriginalFirst(title, "setText", function(element, controller)
		if not IsTextEmpty(element) then
			ScaleWidgetToLabel(self, self.title, 10)
			SetContainerWidthToText(self, element, 10)
		end
	end)
	self:addElement(title)
	self.title = title
	self:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return CoD.FreeCursorUtility.IsTooltipTitleVisible(element, f1_arg1)
			end,
		},
		{
			stateName = "VisibleDetailed",
			condition = function(menu, element, event)
				return CoD.FreeCursorUtility.IsTooltipTitleVisible(element, f1_arg1)
			end,
		},
	})
	self:linkToElementModel(self, "title", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "title",
		})
	end)
	local f1_local3 = self
	local f1_local4 = self.subscribeToModel
	local f1_local5 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local4(f1_local3, f1_local5["ButtonBits." .. Enum[0x3DD78803F918E9D][0x820DDD869ABBFAA]], function(f7_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f7_arg0:get(),
			modelName = "ButtonBits." .. Enum[0x3DD78803F918E9D][0x820DDD869ABBFAA],
		})
	end, false)
	self:linkToElementModel(self, "detailedViewPC", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "detailedViewPC",
		})
	end)
	LUI.OverrideFunction_CallOriginalFirst(self, "setState", function(element, controller, f9_arg2, f9_arg3, f9_arg4)
		if IsInDefaultState(self) then
			CollapseFreeCursorElement(self)
			CollapseFreeCursorElementParent(self)
		else
			ExpandFreeCursorElement(self)
		end
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.freeCursorHeaderLabelPC.__resetProperties = function(f10_arg0)
	f10_arg0.title:completeAnimation()
	f10_arg0.backing:completeAnimation()
	f10_arg0.title:setTopBottom(0, 0, 7, 29)
	f10_arg0.title:setAlpha(1)
	f10_arg0.title:setBackingAlpha(0)
	f10_arg0.title:setBackingYPadding(7)
	f10_arg0.backing:setAlpha(0)
end
CoD.freeCursorHeaderLabelPC.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(1)
			f11_arg0.title:completeAnimation()
			f11_arg0.title:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.title)
		end,
	},
	Visible = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(2)
			f12_arg0.backing:completeAnimation()
			f12_arg0.backing:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.backing)
			f12_arg0.title:completeAnimation()
			f12_arg0.title:setBackingAlpha(1)
			f12_arg0.title:setBackingYPadding(8)
			f12_arg0.clipFinished(f12_arg0.title)
		end,
	},
	VisibleDetailed = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(2)
			f13_arg0.backing:completeAnimation()
			f13_arg0.backing:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.backing)
			f13_arg0.title:completeAnimation()
			f13_arg0.title:setTopBottom(0, 0, 9, 31)
			f13_arg0.clipFinished(f13_arg0.title)
		end,
	},
}
CoD.freeCursorHeaderLabelPC.__onClose = function(f14_arg0)
	f14_arg0.title:close()
end
