require("ui/uieditor/widgets/buttonprogressring")
CoD.ButtonProgressRingContainer = InheritFrom(LUI.UIElement)
CoD.ButtonProgressRingContainer.__defaultWidth = 42
CoD.ButtonProgressRingContainer.__defaultHeight = 42
CoD.ButtonProgressRingContainer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ButtonProgressRingContainer)
	self.id = "ButtonProgressRingContainer"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local progressRing = CoD.ButtonProgressRing.new(f1_arg0, f1_arg1, 0, 0, 0, 42, 0, 0, 0, 42)
	progressRing:linkToElementModel(self, "buttonBit", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			progressRing:setModel(f2_local0, f1_arg1)
		end
	end)
	progressRing:linkToElementModel(self, "progress", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			progressRing.progressRing:setShaderVector(0, CoD.GetVectorComponentFromString(f3_local0, 1), CoD.GetVectorComponentFromString(f3_local0, 2), CoD.GetVectorComponentFromString(f3_local0, 3), CoD.GetVectorComponentFromString(f3_local0, 4))
		end
	end)
	self:addElement(progressRing)
	self.progressRing = progressRing
	self:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				local f4_local0
				if not CoD.ModelUtility.IsSelfModelValueEnumFlagSet(self, f1_arg1, "flags", Enum[@"luibuttonpromptflags"][@"hash_72919C98A7A845F0"]) then
					f4_local0 = not CoD.ModelUtility.IsSelfModelValueEnumFlagSet(self, f1_arg1, "flags", Enum[@"luibuttonpromptflags"][@"hash_771B04FAC5BE0E35"])
				else
					f4_local0 = false
				end
				return f4_local0
			end,
		},
	})
	self:linkToElementModel(self, "flags", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "flags",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ButtonProgressRingContainer.__resetProperties = function(f6_arg0)
	f6_arg0.progressRing:completeAnimation()
	f6_arg0.progressRing:setAlpha(1)
end
CoD.ButtonProgressRingContainer.__clipsPerState = {
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
			f8_arg0.progressRing:completeAnimation()
			f8_arg0.progressRing:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.progressRing)
		end,
	},
}
CoD.ButtonProgressRingContainer.__onClose = function(f9_arg0)
	f9_arg0.progressRing:close()
end
