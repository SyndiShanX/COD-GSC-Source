require("x64:4ea348be4e00fe1")
CoD.DupeMeterInternal = InheritFrom(LUI.UIElement)
CoD.DupeMeterInternal.__defaultWidth = 118
CoD.DupeMeterInternal.__defaultHeight = 27
CoD.DupeMeterInternal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.DupeMeterInternal)
	self.id = "DupeMeterInternal"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Dupe01 = CoD.DupeMeterIcon.new(f1_arg0, f1_arg1, 0, 0, 0, 20, 0, 0, 3, 23)
	Dupe01:mergeStateConditions({
		{
			stateName = "Full",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueGreaterThan(f1_arg1, "LootStreamProgress.dupes", 0)
			end,
		},
	})
	local Dupe03 = Dupe01
	local Dupe02 = Dupe01.subscribeToModel
	local RerollIcon = Engine[@"getmodelforcontroller"](f1_arg1)
	Dupe02(Dupe03, RerollIcon["LootStreamProgress.dupes"], function(f3_arg0)
		f1_arg0:updateElementState(Dupe01, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f3_arg0:get(),
			modelName = "LootStreamProgress.dupes",
		})
	end, false)
	Dupe01:linkToElementModel(self, nil, false, function(model)
		Dupe01:setModel(model, f1_arg1)
	end)
	self:addElement(Dupe01)
	self.Dupe01 = Dupe01
	Dupe02 = CoD.DupeMeterIcon.new(f1_arg0, f1_arg1, 0, 0, 25, 45, 0, 0, 3, 23)
	Dupe02:mergeStateConditions({
		{
			stateName = "Full",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueGreaterThan(f1_arg1, "LootStreamProgress.dupes", 1)
			end,
		},
	})
	RerollIcon = Dupe02
	Dupe03 = Dupe02.subscribeToModel
	local RerollIconPulse = Engine[@"getmodelforcontroller"](f1_arg1)
	Dupe03(RerollIcon, RerollIconPulse["LootStreamProgress.dupes"], function(f6_arg0)
		f1_arg0:updateElementState(Dupe02, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "LootStreamProgress.dupes",
		})
	end, false)
	Dupe02:linkToElementModel(self, nil, false, function(model)
		Dupe02:setModel(model, f1_arg1)
	end)
	self:addElement(Dupe02)
	self.Dupe02 = Dupe02
	Dupe03 = CoD.DupeMeterIcon.new(f1_arg0, f1_arg1, 0, 0, 50, 70, 0, 0, 3, 23)
	self:addElement(Dupe03)
	self.Dupe03 = Dupe03
	RerollIcon = LUI.UIImage.new(0, 0, 97.5, 117.5, 0, 0, 3, 23)
	RerollIcon:setRGB(0.54, 0.87, 0.31)
	RerollIcon:setScale(1.3, 1.3)
	RerollIcon:setImage(RegisterImage(@"hash_7B259D817A83EFDB"))
	self:addElement(RerollIcon)
	self.RerollIcon = RerollIcon
	RerollIconPulse = LUI.UIImage.new(0, 0, 97.5, 117.5, 0, 0, 3, 23)
	RerollIconPulse:setRGB(0.54, 0.87, 0.31)
	RerollIconPulse:setAlpha(0)
	RerollIconPulse:setScale(1.3, 1.3)
	RerollIconPulse:setImage(RegisterImage(@"hash_7B259D817A83EFDB"))
	RerollIconPulse:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(RerollIconPulse)
	self.RerollIconPulse = RerollIconPulse
	local Linker = LUI.UIImage.new(0, 0, 82.5, 86.5, 0, 0, 0, 27)
	Linker:setAlpha(0.6)
	Linker:setZRot(90)
	Linker:setImage(RegisterImage(@"hash_C49B0C8991A541F"))
	Linker:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_67C9C02F608D0A75"))
	Linker:setShaderVector(0, 0, 0, 0, 0)
	Linker:setupNineSliceShader(4, 8)
	self:addElement(Linker)
	self.Linker = Linker
	self:subscribeToGlobalModel(f1_arg1, "DupeMeterPulse", "pulseDupeIcon", function(model)
		local f8_local0 = self
		if CoD.ModelUtility.IsGlobalDataSourceModelValueTrue(f1_arg1, "DupeMeterPulse", "pulseDupeIcon") then
			PlayClipOnElement(self, {
				elementName = "Dupe01",
				clipName = "Pulse",
			}, f1_arg1)
			PlayClipOnElement(self, {
				elementName = "Dupe02",
				clipName = "Pulse",
			}, f1_arg1)
		end
	end)
	self:subscribeToGlobalModel(f1_arg1, "DupeMeterPulse", "pulseRerollIcon", function(model)
		local f9_local0 = self
		if CoD.ModelUtility.IsGlobalDataSourceModelValueTrue(f1_arg1, "DupeMeterPulse", "pulseRerollIcon") then
			PlayClip(self, "Pulse", f1_arg1)
		end
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.DupeMeterInternal.__resetProperties = function(f10_arg0)
	f10_arg0.RerollIconPulse:completeAnimation()
	f10_arg0.RerollIcon:completeAnimation()
	f10_arg0.RerollIconPulse:setAlpha(0)
	f10_arg0.RerollIconPulse:setScale(1.3, 1.3)
	f10_arg0.RerollIcon:setZRot(0)
end
CoD.DupeMeterInternal.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(0)
		end,
		Pulse = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(2)
			f12_arg0.RerollIcon:completeAnimation()
			f12_arg0.RerollIcon:setZRot(0)
			f12_arg0.clipFinished(f12_arg0.RerollIcon)
			local f12_local0 = function(f13_arg0)
				local f13_local0 = function(f14_arg0)
					f14_arg0:beginAnimation(200)
					f14_arg0:setAlpha(0)
					f14_arg0:setScale(4, 4)
					f14_arg0:registerEventHandler("transition_complete_keyframe", f12_arg0.clipFinished)
				end
				f12_arg0.RerollIconPulse:beginAnimation(100)
				f12_arg0.RerollIconPulse:setAlpha(1)
				f12_arg0.RerollIconPulse:registerEventHandler("interrupted_keyframe", f12_arg0.clipInterrupted)
				f12_arg0.RerollIconPulse:registerEventHandler("transition_complete_keyframe", f13_local0)
			end
			f12_arg0.RerollIconPulse:completeAnimation()
			f12_arg0.RerollIconPulse:setAlpha(0)
			f12_arg0.RerollIconPulse:setScale(1.3, 1.3)
			f12_local0(f12_arg0.RerollIconPulse)
		end,
	},
}
CoD.DupeMeterInternal.__onClose = function(f15_arg0)
	f15_arg0.Dupe01:close()
	f15_arg0.Dupe02:close()
	f15_arg0.Dupe03:close()
end
