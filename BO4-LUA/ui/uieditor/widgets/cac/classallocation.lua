require("x64:70d765c7d630092")
CoD.ClassAllocation = InheritFrom(LUI.UIElement)
CoD.ClassAllocation.__defaultWidth = 445
CoD.ClassAllocation.__defaultHeight = 18
CoD.ClassAllocation.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ClassAllocation)
	self.id = "ClassAllocation"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local AllocationSpent = CoD.AllocationSpentWidget.new(f1_arg0, f1_arg1, 0, 0, 0, 429, 0, 0, 1, 18)
	AllocationSpent.AllocationBar10:setAlpha(0)
	AllocationSpent.AllocationBar11:setAlpha(0)
	AllocationSpent.AllocationBar12:setAlpha(0)
	AllocationSpent.AllocationBar13:setAlpha(0)
	AllocationSpent.AllocationBar14:setAlpha(0)
	AllocationSpent.AllocationBar15:setAlpha(0)
	AllocationSpent.AllocationBar16:setAlpha(0)
	AllocationSpent:registerEventHandler("update_class", function(element, event)
		local f2_local0 = nil
		UpdateAllocationBar(self, element, f1_arg1)
		if not f2_local0 then
			f2_local0 = element:dispatchEventToChildren(event)
		end
		return f2_local0
	end)
	self:addElement(AllocationSpent)
	self.AllocationSpent = AllocationSpent
	local TextBoxSlash = LUI.UIText.new(0, 0, 277, 316, 0, 0, 0, 18)
	TextBoxSlash:setRGB(0.58, 0.58, 0.58)
	TextBoxSlash:setAlpha(0.5)
	TextBoxSlash:setText(Engine[@"hash_4F9F1239CFD921FE"](@"mp/slash"))
	TextBoxSlash:setTTF("ttmussels_demibold")
	TextBoxSlash:setAlignment(Enum[@"luialignment"][@"lui_alignment_right"])
	TextBoxSlash:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(TextBoxSlash)
	self.TextBoxSlash = TextBoxSlash
	local TotalCapacityLabel = LUI.UIText.new(0, 0, 302, 360, 0, 0, 0, 18)
	TotalCapacityLabel:setRGB(0.58, 0.58, 0.58)
	TotalCapacityLabel:setText(GetMaxAllocationAmount(f1_arg1))
	TotalCapacityLabel:setTTF("ttmussels_demibold")
	TotalCapacityLabel:setLetterSpacing(4)
	TotalCapacityLabel:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	TotalCapacityLabel:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(TotalCapacityLabel)
	self.TotalCapacityLabel = TotalCapacityLabel
	local CapacityValueLabel = LUI.UIText.new(0, 0, 229, 301, 0, 0, 0, 18)
	CapacityValueLabel:setRGB(0.58, 0.58, 0.58)
	CapacityValueLabel:setTTF("ttmussels_demibold")
	CapacityValueLabel:setLetterSpacing(4)
	CapacityValueLabel:setAlignment(Enum[@"luialignment"][@"lui_alignment_right"])
	CapacityValueLabel:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	CapacityValueLabel:linkToElementModel(self, "allocationSpent", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			CapacityValueLabel:setText(f3_local0)
		end
	end)
	self:addElement(CapacityValueLabel)
	self.CapacityValueLabel = CapacityValueLabel
	self:mergeStateConditions({
		{
			stateName = "NoAllocationBar",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelPathNil(self, f1_arg1, "allocationSpent")
			end,
		},
		{
			stateName = "Alloc17",
			condition = function(menu, element, event)
				return IsClassAllocationInState(f1_arg1, 17)
			end,
		},
		{
			stateName = "Alloc16",
			condition = function(menu, element, event)
				return IsClassAllocationInState(f1_arg1, 16)
			end,
		},
		{
			stateName = "Alloc15",
			condition = function(menu, element, event)
				return IsClassAllocationInState(f1_arg1, 15)
			end,
		},
		{
			stateName = "Alloc14",
			condition = function(menu, element, event)
				return IsClassAllocationInState(f1_arg1, 14)
			end,
		},
		{
			stateName = "Alloc13",
			condition = function(menu, element, event)
				return IsClassAllocationInState(f1_arg1, 13)
			end,
		},
		{
			stateName = "Alloc12",
			condition = function(menu, element, event)
				return IsClassAllocationInState(f1_arg1, 12)
			end,
		},
		{
			stateName = "Alloc11",
			condition = function(menu, element, event)
				return IsClassAllocationInState(f1_arg1, 11)
			end,
		},
	})
	self:linkToElementModel(self, "allocationSpent", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "allocationSpent",
		})
	end)
	self:linkToElementModel(self, "allocationSpent", true, function(model)
		local f13_local0 = self
		UpdateAllocationBar(self, self.AllocationSpent, f1_arg1)
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ClassAllocation.__resetProperties = function(f14_arg0)
	f14_arg0.CapacityValueLabel:completeAnimation()
	f14_arg0.TotalCapacityLabel:completeAnimation()
	f14_arg0.TextBoxSlash:completeAnimation()
	f14_arg0.AllocationSpent:completeAnimation()
	f14_arg0.CapacityValueLabel:setAlpha(1)
	f14_arg0.TotalCapacityLabel:setAlpha(1)
	f14_arg0.TextBoxSlash:setAlpha(0.5)
	f14_arg0.AllocationSpent:setLeftRight(0, 0, 0, 429)
	f14_arg0.AllocationSpent:setTopBottom(0, 0, 1, 18)
	f14_arg0.AllocationSpent:setAlpha(1)
	f14_arg0.AllocationSpent.AllocationBar10:setAlpha(0)
	f14_arg0.AllocationSpent.AllocationBar11:setAlpha(0)
	f14_arg0.AllocationSpent.AllocationBar12:setAlpha(0)
	f14_arg0.AllocationSpent.AllocationBar13:setAlpha(0)
	f14_arg0.AllocationSpent.AllocationBar14:setAlpha(0)
	f14_arg0.AllocationSpent.AllocationBar15:setAlpha(0)
	f14_arg0.AllocationSpent.AllocationBar16:setAlpha(0)
end
CoD.ClassAllocation.__clipsPerState = {
	NoAllocationBar = {
		DefaultClip = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(4)
			f15_arg0.AllocationSpent:completeAnimation()
			f15_arg0.AllocationSpent:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.AllocationSpent)
			f15_arg0.TextBoxSlash:completeAnimation()
			f15_arg0.TextBoxSlash:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.TextBoxSlash)
			f15_arg0.TotalCapacityLabel:completeAnimation()
			f15_arg0.TotalCapacityLabel:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.TotalCapacityLabel)
			f15_arg0.CapacityValueLabel:completeAnimation()
			f15_arg0.CapacityValueLabel:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.CapacityValueLabel)
		end,
	},
	DefaultState = {
		DefaultClip = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(0)
		end,
	},
	Alloc17 = {
		DefaultClip = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(1)
			f17_arg0.AllocationSpent:completeAnimation()
			f17_arg0.AllocationSpent.AllocationBar10:completeAnimation()
			f17_arg0.AllocationSpent.AllocationBar11:completeAnimation()
			f17_arg0.AllocationSpent.AllocationBar12:completeAnimation()
			f17_arg0.AllocationSpent.AllocationBar13:completeAnimation()
			f17_arg0.AllocationSpent.AllocationBar14:completeAnimation()
			f17_arg0.AllocationSpent.AllocationBar15:completeAnimation()
			f17_arg0.AllocationSpent.AllocationBar16:completeAnimation()
			f17_arg0.AllocationSpent:setLeftRight(1, 1, -636, -146)
			f17_arg0.AllocationSpent:setTopBottom(0, 0, 2, 50)
			f17_arg0.AllocationSpent.AllocationBar10:setAlpha(1)
			f17_arg0.AllocationSpent.AllocationBar11:setAlpha(1)
			f17_arg0.AllocationSpent.AllocationBar12:setAlpha(1)
			f17_arg0.AllocationSpent.AllocationBar13:setAlpha(1)
			f17_arg0.AllocationSpent.AllocationBar14:setAlpha(1)
			f17_arg0.AllocationSpent.AllocationBar15:setAlpha(1)
			f17_arg0.AllocationSpent.AllocationBar16:setAlpha(1)
			f17_arg0.clipFinished(f17_arg0.AllocationSpent)
		end,
	},
	Alloc16 = {
		DefaultClip = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(1)
			f18_arg0.AllocationSpent:completeAnimation()
			f18_arg0.AllocationSpent.AllocationBar10:completeAnimation()
			f18_arg0.AllocationSpent.AllocationBar11:completeAnimation()
			f18_arg0.AllocationSpent.AllocationBar12:completeAnimation()
			f18_arg0.AllocationSpent.AllocationBar13:completeAnimation()
			f18_arg0.AllocationSpent.AllocationBar14:completeAnimation()
			f18_arg0.AllocationSpent.AllocationBar15:completeAnimation()
			f18_arg0.AllocationSpent:setLeftRight(1, 1, -607, -117)
			f18_arg0.AllocationSpent:setTopBottom(0, 0, 2, 50)
			f18_arg0.AllocationSpent.AllocationBar10:setAlpha(1)
			f18_arg0.AllocationSpent.AllocationBar11:setAlpha(1)
			f18_arg0.AllocationSpent.AllocationBar12:setAlpha(1)
			f18_arg0.AllocationSpent.AllocationBar13:setAlpha(1)
			f18_arg0.AllocationSpent.AllocationBar14:setAlpha(1)
			f18_arg0.AllocationSpent.AllocationBar15:setAlpha(1)
			f18_arg0.clipFinished(f18_arg0.AllocationSpent)
		end,
	},
	Alloc15 = {
		DefaultClip = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(1)
			f19_arg0.AllocationSpent:completeAnimation()
			f19_arg0.AllocationSpent.AllocationBar10:completeAnimation()
			f19_arg0.AllocationSpent.AllocationBar11:completeAnimation()
			f19_arg0.AllocationSpent.AllocationBar12:completeAnimation()
			f19_arg0.AllocationSpent.AllocationBar13:completeAnimation()
			f19_arg0.AllocationSpent.AllocationBar14:completeAnimation()
			f19_arg0.AllocationSpent:setLeftRight(1, 1, -579, -89)
			f19_arg0.AllocationSpent:setTopBottom(0, 0, 2, 50)
			f19_arg0.AllocationSpent.AllocationBar10:setAlpha(1)
			f19_arg0.AllocationSpent.AllocationBar11:setAlpha(1)
			f19_arg0.AllocationSpent.AllocationBar12:setAlpha(1)
			f19_arg0.AllocationSpent.AllocationBar13:setAlpha(1)
			f19_arg0.AllocationSpent.AllocationBar14:setAlpha(1)
			f19_arg0.clipFinished(f19_arg0.AllocationSpent)
		end,
	},
	Alloc14 = {
		DefaultClip = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(1)
			f20_arg0.AllocationSpent:completeAnimation()
			f20_arg0.AllocationSpent.AllocationBar10:completeAnimation()
			f20_arg0.AllocationSpent.AllocationBar11:completeAnimation()
			f20_arg0.AllocationSpent.AllocationBar12:completeAnimation()
			f20_arg0.AllocationSpent.AllocationBar13:completeAnimation()
			f20_arg0.AllocationSpent:setLeftRight(1, 1, -550, -60)
			f20_arg0.AllocationSpent:setTopBottom(0, 0, 2, 50)
			f20_arg0.AllocationSpent.AllocationBar10:setAlpha(1)
			f20_arg0.AllocationSpent.AllocationBar11:setAlpha(1)
			f20_arg0.AllocationSpent.AllocationBar12:setAlpha(1)
			f20_arg0.AllocationSpent.AllocationBar13:setAlpha(1)
			f20_arg0.clipFinished(f20_arg0.AllocationSpent)
		end,
	},
	Alloc13 = {
		DefaultClip = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(1)
			f21_arg0.AllocationSpent:completeAnimation()
			f21_arg0.AllocationSpent.AllocationBar10:completeAnimation()
			f21_arg0.AllocationSpent.AllocationBar11:completeAnimation()
			f21_arg0.AllocationSpent.AllocationBar12:completeAnimation()
			f21_arg0.AllocationSpent:setLeftRight(1, 1, -522, -32)
			f21_arg0.AllocationSpent:setTopBottom(0, 0, 2, 50)
			f21_arg0.AllocationSpent.AllocationBar10:setAlpha(1)
			f21_arg0.AllocationSpent.AllocationBar11:setAlpha(1)
			f21_arg0.AllocationSpent.AllocationBar12:setAlpha(1)
			f21_arg0.clipFinished(f21_arg0.AllocationSpent)
		end,
	},
	Alloc12 = {
		DefaultClip = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(1)
			f22_arg0.AllocationSpent:completeAnimation()
			f22_arg0.AllocationSpent.AllocationBar10:completeAnimation()
			f22_arg0.AllocationSpent.AllocationBar11:completeAnimation()
			f22_arg0.AllocationSpent:setLeftRight(1, 1, -493, -3)
			f22_arg0.AllocationSpent:setTopBottom(0, 0, 2, 50)
			f22_arg0.AllocationSpent.AllocationBar10:setAlpha(1)
			f22_arg0.AllocationSpent.AllocationBar11:setAlpha(1)
			f22_arg0.clipFinished(f22_arg0.AllocationSpent)
		end,
	},
	Alloc11 = {
		DefaultClip = function(f23_arg0, f23_arg1)
			f23_arg0:__resetProperties()
			f23_arg0:setupElementClipCounter(1)
			f23_arg0.AllocationSpent:completeAnimation()
			f23_arg0.AllocationSpent.AllocationBar10:completeAnimation()
			f23_arg0.AllocationSpent:setLeftRight(1, 1, -465, 25)
			f23_arg0.AllocationSpent:setTopBottom(0, 0, 2, 50)
			f23_arg0.AllocationSpent.AllocationBar10:setAlpha(1)
			f23_arg0.clipFinished(f23_arg0.AllocationSpent)
		end,
	},
}
CoD.ClassAllocation.__onClose = function(f24_arg0)
	f24_arg0.AllocationSpent:close()
	f24_arg0.CapacityValueLabel:close()
end
