CoD.LobbyProcessQueueDebugItemText = InheritFrom(LUI.UIElement)
CoD.LobbyProcessQueueDebugItemText.__defaultWidth = 83
CoD.LobbyProcessQueueDebugItemText.__defaultHeight = 25
CoD.LobbyProcessQueueDebugItemText.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.LobbyProcessQueueDebugItemText)
	self.id = "LobbyProcessQueueDebugItemText"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Name = LUI.UIText.new(0, 0, 0, 1083, 0, 0, 0, 20)
	Name:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_6808E4CA838AD72E"))
	Name:setTTF("dinnext_regular")
	Name:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	Name:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(Name)
	self.Name = Name
	self:mergeStateConditions({
		{
			stateName = "Pending",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "processState", 0)
			end,
		},
		{
			stateName = "Running",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "processState", 1)
			end,
		},
		{
			stateName = "Success",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "processState", 2)
			end,
		},
		{
			stateName = "Failure",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "processState", 3)
			end,
		},
		{
			stateName = "Error",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "processState", 4)
			end,
		},
		{
			stateName = "Throttled",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "processState", 5)
			end,
		},
	})
	self:linkToElementModel(self, "processState", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "processState",
		})
	end)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.LobbyProcessQueueDebugItemText.__resetProperties = function(f9_arg0)
	f9_arg0.Name:completeAnimation()
	f9_arg0.Name:setRGB(1, 1, 1)
end
CoD.LobbyProcessQueueDebugItemText.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(0)
		end,
	},
	Pending = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(1)
			f11_arg0.Name:completeAnimation()
			f11_arg0.Name:setRGB(1, 1, 1)
			f11_arg0.clipFinished(f11_arg0.Name)
		end,
	},
	Running = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(1)
			f12_arg0.Name:completeAnimation()
			f12_arg0.Name:setRGB(0, 1, 0.04)
			f12_arg0.clipFinished(f12_arg0.Name)
		end,
	},
	Success = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(1)
			f13_arg0.Name:completeAnimation()
			f13_arg0.Name:setRGB(1, 1, 1)
			f13_arg0.clipFinished(f13_arg0.Name)
		end,
	},
	Failure = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(1)
			f14_arg0.Name:completeAnimation()
			f14_arg0.Name:setRGB(1, 0.96, 0)
			f14_arg0.clipFinished(f14_arg0.Name)
		end,
	},
	Error = {
		DefaultClip = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(1)
			f15_arg0.Name:completeAnimation()
			f15_arg0.Name:setRGB(1, 0, 0)
			f15_arg0.clipFinished(f15_arg0.Name)
		end,
	},
	Throttled = {
		DefaultClip = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(1)
			f16_arg0.Name:completeAnimation()
			f16_arg0.Name:setRGB(0, 0.82, 1)
			f16_arg0.clipFinished(f16_arg0.Name)
		end,
	},
}
