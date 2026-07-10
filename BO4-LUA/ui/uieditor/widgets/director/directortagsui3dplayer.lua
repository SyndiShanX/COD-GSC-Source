CoD.DirectorTagsUI3DPlayer = InheritFrom(LUI.UIElement)
CoD.DirectorTagsUI3DPlayer.__defaultWidth = 100
CoD.DirectorTagsUI3DPlayer.__defaultHeight = 100
CoD.DirectorTagsUI3DPlayer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.DirectorTagsUI3DPlayer)
	self.id = "DirectorTagsUI3DPlayer"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local tag = LUI.UIImage.new(0, 1, 5, -5, 0, 1, 5, -5)
	tag:linkToElementModel(self, "sprayGestureIndex", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			tag:setImage(RegisterImage(CoD.PlayerRoleUtility.GetTagIconFromIndex(f2_local0)))
		end
	end)
	self:addElement(tag)
	self.tag = tag
	self:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				local f3_local0
				if not CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "visible") then
					f3_local0 = CoD.ModelUtility.IsSelfModelValueGreaterThanOrEqualTo(element, f1_arg1, "sprayGestureIndex", 0)
				else
					f3_local0 = false
				end
				return f3_local0
			end,
		},
	})
	self:linkToElementModel(self, "visible", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "visible",
		})
	end)
	self:linkToElementModel(self, "sprayGestureIndex", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "sprayGestureIndex",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.DirectorTagsUI3DPlayer.__resetProperties = function(f6_arg0)
	f6_arg0.tag:completeAnimation()
	f6_arg0.tag:setAlpha(1)
end
CoD.DirectorTagsUI3DPlayer.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(0)
		end,
	},
	Hidden = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(1)
			f8_arg0.tag:completeAnimation()
			f8_arg0.tag:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.tag)
		end,
	},
}
CoD.DirectorTagsUI3DPlayer.__onClose = function(f9_arg0)
	f9_arg0.tag:close()
end
