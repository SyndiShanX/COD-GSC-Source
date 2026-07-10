CoD.DemoSideBarButtonIcon = InheritFrom(LUI.UIElement)
CoD.DemoSideBarButtonIcon.__defaultWidth = 40
CoD.DemoSideBarButtonIcon.__defaultHeight = 40
CoD.DemoSideBarButtonIcon.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.DemoSideBarButtonIcon)
	self.id = "DemoSideBarButtonIcon"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Icon = LUI.UIImage.new(0, 0, 0, 40, 0.5, 0.5, -20, 20)
	self:addElement(Icon)
	self.Icon = Icon
	self.Icon:linkToElementModel(self, "icon", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			Icon:setImage(RegisterImage(f2_local0))
		end
	end)
	self:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueNil(self, f1_arg1, "icon")
			end,
		},
	})
	self:linkToElementModel(self, "icon", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "icon",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.DemoSideBarButtonIcon.__resetProperties = function(f5_arg0)
	f5_arg0.Icon:completeAnimation()
	f5_arg0.Icon:setAlpha(1)
end
CoD.DemoSideBarButtonIcon.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(1)
			f6_arg0.Icon:completeAnimation()
			f6_arg0.Icon:setAlpha(1)
			f6_arg0.clipFinished(f6_arg0.Icon)
		end,
	},
	Hidden = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			f7_arg0.Icon:completeAnimation()
			f7_arg0.Icon:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.Icon)
		end,
	},
}
CoD.DemoSideBarButtonIcon.__onClose = function(f8_arg0)
	f8_arg0.Icon:close()
end
