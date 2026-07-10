require("x64:6f0631f55e67e8c")
require("x64:9e0119b0fcb0fb8")
require("x64:398feba0c63bacd")
require("x64:f74707c16abff2b")
require("x64:a9da787adb62c2a")
CoD.SpawnBeaconMarker = InheritFrom(LUI.UIElement)
CoD.SpawnBeaconMarker.__defaultWidth = 98
CoD.SpawnBeaconMarker.__defaultHeight = 93
CoD.SpawnBeaconMarker.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.SpawnBeaconMarker)
	self.id = "SpawnBeaconMarker"
	self.soundSet = "ChooseDecal"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local SpawnSelectRadius = CoD.SpawnRegionRadius.new(f1_arg0, f1_arg1, 0.5, 0.5, -150, 150, 0.5, 0.5, -150, 150)
	SpawnSelectRadius:setAlpha(0)
	SpawnSelectRadius:linkToElementModel(self, nil, false, function(model)
		SpawnSelectRadius:setModel(model, f1_arg1)
	end)
	self:addElement(SpawnSelectRadius)
	self.SpawnSelectRadius = SpawnSelectRadius
	local SpawnSelectIconBg = CoD.SpawnSelectLocationMarker.new(f1_arg0, f1_arg1, 0, 0, -49.5, 148.5, 0, 0, -17.5, 110.5)
	self:addElement(SpawnSelectIconBg)
	self.SpawnSelectIconBg = SpawnSelectIconBg
	local SpawnSelectLabel = CoD.SpawnSelectionLabel.new(f1_arg0, f1_arg1, 0, 0, 112.5, 242.5, 0, 0, -80.5, -40.5)
	SpawnSelectLabel:linkToElementModel(self, nil, false, function(model)
		SpawnSelectLabel:setModel(model, f1_arg1)
	end)
	self:addElement(SpawnSelectLabel)
	self.SpawnSelectLabel = SpawnSelectLabel
	local SpawnSelectPulse = CoD.SpawnRegionPulse.new(f1_arg0, f1_arg1, 0, 0, -71, 169, 0, 0, -67.5, 160.5)
	self:addElement(SpawnSelectPulse)
	self.SpawnSelectPulse = SpawnSelectPulse
	local SpawnBeaconPoint = CoD.SpawnRegionName.new(f1_arg0, f1_arg1, 0, 0, 9, 89, 0, 0, 6.5, 86.5)
	SpawnBeaconPoint:mergeStateConditions({
		{
			stateName = "Destroyed",
			condition = function(menu, element, event)
				return not CoD.SpawnSelectionUtility.IsSpawnBeaconActive(f1_arg1, self)
			end,
		},
		{
			stateName = "ThreatLow",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(self, f1_arg1, "gamemodeFlags", 0)
			end,
		},
		{
			stateName = "ThreatMedium",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(self, f1_arg1, "gamemodeFlags", 1)
			end,
		},
		{
			stateName = "ThreatHigh",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(self, f1_arg1, "gamemodeFlags", 2)
			end,
		},
		{
			stateName = "DisabledEMP",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(self, f1_arg1, "gamemodeFlags", 3)
			end,
		},
		{
			stateName = "ManualDisabled",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(self, f1_arg1, "gamemodeFlags", 4)
			end,
		},
	})
	SpawnBeaconPoint:linkToElementModel(SpawnBeaconPoint, "state", true, function(model)
		f1_arg0:updateElementState(SpawnBeaconPoint, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "state",
		})
	end)
	SpawnBeaconPoint:linkToElementModel(SpawnBeaconPoint, "gamemodeFlags", true, function(model)
		f1_arg0:updateElementState(SpawnBeaconPoint, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "gamemodeFlags",
		})
	end)
	SpawnBeaconPoint:linkToElementModel(self, nil, false, function(model)
		SpawnBeaconPoint:setModel(model, f1_arg1)
	end)
	self:addElement(SpawnBeaconPoint)
	self.SpawnBeaconPoint = SpawnBeaconPoint
	self:mergeStateConditions({
		{
			stateName = "Destroyed",
			condition = function(menu, element, event)
				return CoD.SpawnSelectionUtility.IsSpawnBeaconDisabledOrDestroyed(f1_arg1, element)
			end,
		},
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	self:linkToElementModel(self, "state", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "state",
		})
	end)
	self:linkToElementModel(self, "gamemodeFlags", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "gamemodeFlags",
		})
	end)
	SpawnSelectIconBg.id = "SpawnSelectIconBg"
	SpawnSelectLabel.id = "SpawnSelectLabel"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.SpawnBeaconMarker.__resetProperties = function(f17_arg0)
	f17_arg0.SpawnSelectPulse:completeAnimation()
	f17_arg0.SpawnBeaconPoint:completeAnimation()
	f17_arg0.SpawnSelectIconBg:completeAnimation()
	f17_arg0.SpawnSelectRadius:completeAnimation()
	f17_arg0.SpawnSelectLabel:completeAnimation()
	f17_arg0.SpawnSelectPulse:setAlpha(1)
	f17_arg0.SpawnSelectPulse:setScale(1, 1)
	f17_arg0.SpawnBeaconPoint:setRGB(1, 1, 1)
	f17_arg0.SpawnBeaconPoint:setAlpha(1)
	f17_arg0.SpawnBeaconPoint:setScale(1, 1)
	f17_arg0.SpawnSelectIconBg:setRGB(1, 1, 1)
	f17_arg0.SpawnSelectIconBg:setAlpha(1)
	f17_arg0.SpawnSelectIconBg:setScale(1, 1)
	f17_arg0.SpawnSelectRadius:setAlpha(0)
	f17_arg0.SpawnSelectRadius:setScale(1, 1)
	f17_arg0.SpawnSelectLabel:setLeftRight(0, 0, 112.5, 242.5)
	f17_arg0.SpawnSelectLabel:setTopBottom(0, 0, -80.5, -40.5)
	f17_arg0.SpawnSelectLabel:setAlpha(1)
end
CoD.SpawnBeaconMarker.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(5)
			f18_arg0.SpawnSelectRadius:completeAnimation()
			f18_arg0.SpawnSelectRadius:setAlpha(0)
			f18_arg0.SpawnSelectRadius:setScale(0.2, 0.2)
			f18_arg0.clipFinished(f18_arg0.SpawnSelectRadius)
			f18_arg0.SpawnSelectIconBg:completeAnimation()
			f18_arg0.SpawnSelectIconBg:setAlpha(1)
			f18_arg0.SpawnSelectIconBg:playClip("DefaultClip")
			f18_arg0.clipFinished(f18_arg0.SpawnSelectIconBg)
			f18_arg0.SpawnSelectLabel:completeAnimation()
			f18_arg0.SpawnSelectLabel:setAlpha(0)
			f18_arg0.clipFinished(f18_arg0.SpawnSelectLabel)
			f18_arg0.SpawnSelectPulse:completeAnimation()
			f18_arg0.SpawnSelectPulse:setAlpha(0)
			f18_arg0.clipFinished(f18_arg0.SpawnSelectPulse)
			f18_arg0.SpawnBeaconPoint:completeAnimation()
			f18_arg0.SpawnBeaconPoint:setAlpha(1)
			f18_arg0.clipFinished(f18_arg0.SpawnBeaconPoint)
		end,
		Focus = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(5)
			f19_arg0.SpawnSelectRadius:completeAnimation()
			f19_arg0.SpawnSelectRadius:setAlpha(1)
			f19_arg0.clipFinished(f19_arg0.SpawnSelectRadius)
			f19_arg0.SpawnSelectIconBg:completeAnimation()
			f19_arg0.SpawnSelectIconBg:setAlpha(1)
			f19_arg0.SpawnSelectIconBg:setScale(1.2, 1.2)
			f19_arg0.SpawnSelectIconBg:playClip("Focused")
			f19_arg0.clipFinished(f19_arg0.SpawnSelectIconBg)
			f19_arg0.SpawnSelectLabel:completeAnimation()
			f19_arg0.SpawnSelectLabel:setLeftRight(0, 0, 112.5, 242.5)
			f19_arg0.SpawnSelectLabel:setTopBottom(0, 0, -78.5, -38.5)
			f19_arg0.SpawnSelectLabel:setAlpha(1)
			f19_arg0.SpawnSelectLabel:playClip("Focused")
			f19_arg0.clipFinished(f19_arg0.SpawnSelectLabel)
			f19_arg0.SpawnSelectPulse:completeAnimation()
			f19_arg0.SpawnSelectPulse:setAlpha(1)
			f19_arg0.SpawnSelectPulse:setScale(1.2, 1.2)
			f19_arg0.clipFinished(f19_arg0.SpawnSelectPulse)
			f19_arg0.SpawnBeaconPoint:completeAnimation()
			f19_arg0.SpawnBeaconPoint:setAlpha(1)
			f19_arg0.SpawnBeaconPoint:setScale(1.2, 1.2)
			f19_arg0.clipFinished(f19_arg0.SpawnBeaconPoint)
		end,
		GainFocus = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(5)
			local f20_local0 = function(f21_arg0)
				f20_arg0.SpawnSelectRadius:beginAnimation(100)
				f20_arg0.SpawnSelectRadius:setAlpha(1)
				f20_arg0.SpawnSelectRadius:setScale(1, 1)
				f20_arg0.SpawnSelectRadius:registerEventHandler("interrupted_keyframe", f20_arg0.clipInterrupted)
				f20_arg0.SpawnSelectRadius:registerEventHandler("transition_complete_keyframe", f20_arg0.clipFinished)
			end
			f20_arg0.SpawnSelectRadius:completeAnimation()
			f20_arg0.SpawnSelectRadius:setAlpha(0)
			f20_arg0.SpawnSelectRadius:setScale(0.2, 0.2)
			f20_local0(f20_arg0.SpawnSelectRadius)
			local f20_local1 = function(f22_arg0)
				f20_arg0.SpawnSelectIconBg:playClip("TransitionGainFocus")
				f20_arg0.SpawnSelectIconBg:beginAnimation(100)
				f20_arg0.SpawnSelectIconBg:setScale(1.2, 1.2)
				f20_arg0.SpawnSelectIconBg:registerEventHandler("interrupted_keyframe", f20_arg0.clipInterrupted)
				f20_arg0.SpawnSelectIconBg:registerEventHandler("transition_complete_keyframe", function(element, event)
					element:playClip("TransitionGainFocus")
					f20_arg0.clipFinished(element, event)
				end)
			end
			f20_arg0.SpawnSelectIconBg:completeAnimation()
			f20_arg0.SpawnSelectIconBg:setScale(1, 1)
			f20_local1(f20_arg0.SpawnSelectIconBg)
			f20_arg0.SpawnSelectLabel:completeAnimation()
			f20_arg0.SpawnSelectLabel:setAlpha(1)
			f20_arg0.SpawnSelectLabel:playClip("TransitionGainFocus")
			f20_arg0.clipFinished(f20_arg0.SpawnSelectLabel)
			local f20_local2 = function(f24_arg0)
				f20_arg0.SpawnSelectPulse:beginAnimation(100)
				f20_arg0.SpawnSelectPulse:setAlpha(1)
				f20_arg0.SpawnSelectPulse:setScale(1.2, 1.2)
				f20_arg0.SpawnSelectPulse:registerEventHandler("interrupted_keyframe", f20_arg0.clipInterrupted)
				f20_arg0.SpawnSelectPulse:registerEventHandler("transition_complete_keyframe", f20_arg0.clipFinished)
			end
			f20_arg0.SpawnSelectPulse:completeAnimation()
			f20_arg0.SpawnSelectPulse:setAlpha(0)
			f20_arg0.SpawnSelectPulse:setScale(1, 1)
			f20_local2(f20_arg0.SpawnSelectPulse)
			local f20_local3 = function(f25_arg0)
				local f25_local0 = function(f26_arg0)
					f26_arg0:beginAnimation(100)
					f26_arg0:registerEventHandler("transition_complete_keyframe", f20_arg0.clipFinished)
				end
				f20_arg0.SpawnBeaconPoint:beginAnimation(100)
				f20_arg0.SpawnBeaconPoint:setScale(1.2, 1.2)
				f20_arg0.SpawnBeaconPoint:registerEventHandler("interrupted_keyframe", f20_arg0.clipInterrupted)
				f20_arg0.SpawnBeaconPoint:registerEventHandler("transition_complete_keyframe", f25_local0)
			end
			f20_arg0.SpawnBeaconPoint:completeAnimation()
			f20_arg0.SpawnBeaconPoint:setAlpha(1)
			f20_arg0.SpawnBeaconPoint:setScale(1, 1)
			f20_local3(f20_arg0.SpawnBeaconPoint)
		end,
		LoseFocus = function(f27_arg0, f27_arg1)
			f27_arg0:__resetProperties()
			f27_arg0:setupElementClipCounter(5)
			local f27_local0 = function(f28_arg0)
				f27_arg0.SpawnSelectRadius:beginAnimation(100)
				f27_arg0.SpawnSelectRadius:setAlpha(0)
				f27_arg0.SpawnSelectRadius:setScale(0.2, 0.2)
				f27_arg0.SpawnSelectRadius:registerEventHandler("interrupted_keyframe", f27_arg0.clipInterrupted)
				f27_arg0.SpawnSelectRadius:registerEventHandler("transition_complete_keyframe", f27_arg0.clipFinished)
			end
			f27_arg0.SpawnSelectRadius:completeAnimation()
			f27_arg0.SpawnSelectRadius:setAlpha(1)
			f27_arg0.SpawnSelectRadius:setScale(1, 1)
			f27_local0(f27_arg0.SpawnSelectRadius)
			local f27_local1 = function(f29_arg0)
				f27_arg0.SpawnSelectIconBg:playClip("TransitionLoseFocus")
				f27_arg0.SpawnSelectIconBg:beginAnimation(100)
				f27_arg0.SpawnSelectIconBg:setScale(1, 1)
				f27_arg0.SpawnSelectIconBg:registerEventHandler("interrupted_keyframe", f27_arg0.clipInterrupted)
				f27_arg0.SpawnSelectIconBg:registerEventHandler("transition_complete_keyframe", function(element, event)
					element:playClip("TransitionLoseFocus")
					f27_arg0.clipFinished(element, event)
				end)
			end
			f27_arg0.SpawnSelectIconBg:completeAnimation()
			f27_arg0.SpawnSelectIconBg:setAlpha(1)
			f27_arg0.SpawnSelectIconBg:setScale(1.2, 1.2)
			f27_local1(f27_arg0.SpawnSelectIconBg)
			f27_arg0.SpawnSelectLabel:completeAnimation()
			f27_arg0.SpawnSelectLabel:setAlpha(1)
			f27_arg0.SpawnSelectLabel:playClip("TransitionLoseFocus")
			f27_arg0.clipFinished(f27_arg0.SpawnSelectLabel)
			local f27_local2 = function(f31_arg0)
				f27_arg0.SpawnSelectPulse:beginAnimation(100)
				f27_arg0.SpawnSelectPulse:setAlpha(0)
				f27_arg0.SpawnSelectPulse:setScale(1, 1)
				f27_arg0.SpawnSelectPulse:registerEventHandler("interrupted_keyframe", f27_arg0.clipInterrupted)
				f27_arg0.SpawnSelectPulse:registerEventHandler("transition_complete_keyframe", f27_arg0.clipFinished)
			end
			f27_arg0.SpawnSelectPulse:completeAnimation()
			f27_arg0.SpawnSelectPulse:setAlpha(1)
			f27_arg0.SpawnSelectPulse:setScale(1.2, 1.2)
			f27_local2(f27_arg0.SpawnSelectPulse)
			local f27_local3 = function(f32_arg0)
				f27_arg0.SpawnBeaconPoint:beginAnimation(100)
				f27_arg0.SpawnBeaconPoint:setScale(1, 1)
				f27_arg0.SpawnBeaconPoint:registerEventHandler("interrupted_keyframe", f27_arg0.clipInterrupted)
				f27_arg0.SpawnBeaconPoint:registerEventHandler("transition_complete_keyframe", f27_arg0.clipFinished)
			end
			f27_arg0.SpawnBeaconPoint:completeAnimation()
			f27_arg0.SpawnBeaconPoint:setAlpha(1)
			f27_arg0.SpawnBeaconPoint:setScale(1.2, 1.2)
			f27_local3(f27_arg0.SpawnBeaconPoint)
		end,
	},
	Destroyed = {
		DefaultClip = function(f33_arg0, f33_arg1)
			f33_arg0:__resetProperties()
			f33_arg0:setupElementClipCounter(5)
			f33_arg0.SpawnSelectRadius:completeAnimation()
			f33_arg0.SpawnSelectRadius:setAlpha(0)
			f33_arg0.SpawnSelectRadius:setScale(0.2, 0.2)
			f33_arg0.clipFinished(f33_arg0.SpawnSelectRadius)
			f33_arg0.SpawnSelectIconBg:completeAnimation()
			f33_arg0.SpawnSelectIconBg:setRGB(ColorSet.Disabled.r, ColorSet.Disabled.g, ColorSet.Disabled.b)
			f33_arg0.SpawnSelectIconBg:setAlpha(0.5)
			f33_arg0.SpawnSelectIconBg:playClip("DefaultClip")
			f33_arg0.clipFinished(f33_arg0.SpawnSelectIconBg)
			f33_arg0.SpawnSelectLabel:completeAnimation()
			f33_arg0.SpawnSelectLabel:setAlpha(0)
			f33_arg0.clipFinished(f33_arg0.SpawnSelectLabel)
			f33_arg0.SpawnSelectPulse:completeAnimation()
			f33_arg0.SpawnSelectPulse:setAlpha(0)
			f33_arg0.clipFinished(f33_arg0.SpawnSelectPulse)
			f33_arg0.SpawnBeaconPoint:completeAnimation()
			f33_arg0.SpawnBeaconPoint:setAlpha(0.5)
			f33_arg0.clipFinished(f33_arg0.SpawnBeaconPoint)
		end,
		Focus = function(f34_arg0, f34_arg1)
			f34_arg0:__resetProperties()
			f34_arg0:setupElementClipCounter(5)
			f34_arg0.SpawnSelectRadius:completeAnimation()
			f34_arg0.SpawnSelectRadius:setAlpha(0)
			f34_arg0.clipFinished(f34_arg0.SpawnSelectRadius)
			f34_arg0.SpawnSelectIconBg:completeAnimation()
			f34_arg0.SpawnSelectIconBg:setRGB(ColorSet.Disabled.r, ColorSet.Disabled.g, ColorSet.Disabled.b)
			f34_arg0.SpawnSelectIconBg:setAlpha(0.5)
			f34_arg0.SpawnSelectIconBg:setScale(1.2, 1.2)
			f34_arg0.clipFinished(f34_arg0.SpawnSelectIconBg)
			f34_arg0.SpawnSelectLabel:completeAnimation()
			f34_arg0.SpawnSelectLabel:setLeftRight(0, 0, 112.5, 242.5)
			f34_arg0.SpawnSelectLabel:setTopBottom(0, 0, -78.5, -38.5)
			f34_arg0.clipFinished(f34_arg0.SpawnSelectLabel)
			f34_arg0.SpawnSelectPulse:completeAnimation()
			f34_arg0.SpawnSelectPulse:setAlpha(0)
			f34_arg0.SpawnSelectPulse:setScale(1.2, 1.2)
			f34_arg0.clipFinished(f34_arg0.SpawnSelectPulse)
			f34_arg0.SpawnBeaconPoint:completeAnimation()
			f34_arg0.SpawnBeaconPoint:setRGB(ColorSet.Disabled.r, ColorSet.Disabled.g, ColorSet.Disabled.b)
			f34_arg0.SpawnBeaconPoint:setAlpha(0.5)
			f34_arg0.SpawnBeaconPoint:setScale(1.2, 1.2)
			f34_arg0.clipFinished(f34_arg0.SpawnBeaconPoint)
		end,
		GainFocus = function(f35_arg0, f35_arg1)
			f35_arg0:__resetProperties()
			f35_arg0:setupElementClipCounter(5)
			f35_arg0.SpawnSelectRadius:completeAnimation()
			f35_arg0.SpawnSelectRadius:setAlpha(0)
			f35_arg0.SpawnSelectRadius:setScale(0.2, 0.2)
			f35_arg0.clipFinished(f35_arg0.SpawnSelectRadius)
			local f35_local0 = function(f36_arg0)
				f35_arg0.SpawnSelectIconBg:playClip("TransitionGainFocus")
				f35_arg0.SpawnSelectIconBg:beginAnimation(100)
				f35_arg0.SpawnSelectIconBg:setScale(1.2, 1.2)
				f35_arg0.SpawnSelectIconBg:registerEventHandler("interrupted_keyframe", f35_arg0.clipInterrupted)
				f35_arg0.SpawnSelectIconBg:registerEventHandler("transition_complete_keyframe", function(element, event)
					element:playClip("TransitionGainFocus")
					f35_arg0.clipFinished(element, event)
				end)
			end
			f35_arg0.SpawnSelectIconBg:completeAnimation()
			f35_arg0.SpawnSelectIconBg:setRGB(ColorSet.Disabled.r, ColorSet.Disabled.g, ColorSet.Disabled.b)
			f35_arg0.SpawnSelectIconBg:setAlpha(0.5)
			f35_arg0.SpawnSelectIconBg:setScale(1, 1)
			f35_local0(f35_arg0.SpawnSelectIconBg)
			f35_arg0.SpawnSelectLabel:completeAnimation()
			f35_arg0.SpawnSelectLabel:setAlpha(1)
			f35_arg0.SpawnSelectLabel:playClip("TransitionGainFocus")
			f35_arg0.clipFinished(f35_arg0.SpawnSelectLabel)
			f35_arg0.SpawnSelectPulse:completeAnimation()
			f35_arg0.SpawnSelectPulse:setAlpha(0)
			f35_arg0.SpawnSelectPulse:setScale(1, 1)
			f35_arg0.clipFinished(f35_arg0.SpawnSelectPulse)
			local f35_local1 = function(f38_arg0)
				f35_arg0.SpawnBeaconPoint:beginAnimation(100)
				f35_arg0.SpawnBeaconPoint:setScale(1.2, 1.2)
				f35_arg0.SpawnBeaconPoint:registerEventHandler("interrupted_keyframe", f35_arg0.clipInterrupted)
				f35_arg0.SpawnBeaconPoint:registerEventHandler("transition_complete_keyframe", f35_arg0.clipFinished)
			end
			f35_arg0.SpawnBeaconPoint:completeAnimation()
			f35_arg0.SpawnBeaconPoint:setRGB(ColorSet.Disabled.r, ColorSet.Disabled.g, ColorSet.Disabled.b)
			f35_arg0.SpawnBeaconPoint:setAlpha(0.5)
			f35_arg0.SpawnBeaconPoint:setScale(1, 1)
			f35_local1(f35_arg0.SpawnBeaconPoint)
		end,
		LoseFocus = function(f39_arg0, f39_arg1)
			f39_arg0:__resetProperties()
			f39_arg0:setupElementClipCounter(5)
			f39_arg0.SpawnSelectRadius:completeAnimation()
			f39_arg0.SpawnSelectRadius:setAlpha(0)
			f39_arg0.SpawnSelectRadius:setScale(1, 1)
			f39_arg0.clipFinished(f39_arg0.SpawnSelectRadius)
			local f39_local0 = function(f40_arg0)
				f39_arg0.SpawnSelectIconBg:playClip("TransitionLoseFocus")
				f39_arg0.SpawnSelectIconBg:beginAnimation(100)
				f39_arg0.SpawnSelectIconBg:setScale(1, 1)
				f39_arg0.SpawnSelectIconBg:registerEventHandler("interrupted_keyframe", f39_arg0.clipInterrupted)
				f39_arg0.SpawnSelectIconBg:registerEventHandler("transition_complete_keyframe", function(element, event)
					element:playClip("TransitionLoseFocus")
					f39_arg0.clipFinished(element, event)
				end)
			end
			f39_arg0.SpawnSelectIconBg:completeAnimation()
			f39_arg0.SpawnSelectIconBg:setRGB(ColorSet.Disabled.r, ColorSet.Disabled.g, ColorSet.Disabled.b)
			f39_arg0.SpawnSelectIconBg:setAlpha(0.5)
			f39_arg0.SpawnSelectIconBg:setScale(1.2, 1.2)
			f39_local0(f39_arg0.SpawnSelectIconBg)
			f39_arg0.SpawnSelectLabel:completeAnimation()
			f39_arg0.SpawnSelectLabel:setAlpha(1)
			f39_arg0.SpawnSelectLabel:playClip("TransitionLoseFocus")
			f39_arg0.clipFinished(f39_arg0.SpawnSelectLabel)
			f39_arg0.SpawnSelectPulse:completeAnimation()
			f39_arg0.SpawnSelectPulse:setAlpha(0)
			f39_arg0.SpawnSelectPulse:setScale(1.2, 1.2)
			f39_arg0.clipFinished(f39_arg0.SpawnSelectPulse)
			local f39_local1 = function(f42_arg0)
				f39_arg0.SpawnBeaconPoint:beginAnimation(100)
				f39_arg0.SpawnBeaconPoint:setScale(1, 1)
				f39_arg0.SpawnBeaconPoint:registerEventHandler("interrupted_keyframe", f39_arg0.clipInterrupted)
				f39_arg0.SpawnBeaconPoint:registerEventHandler("transition_complete_keyframe", f39_arg0.clipFinished)
			end
			f39_arg0.SpawnBeaconPoint:completeAnimation()
			f39_arg0.SpawnBeaconPoint:setRGB(ColorSet.Disabled.r, ColorSet.Disabled.g, ColorSet.Disabled.b)
			f39_arg0.SpawnBeaconPoint:setAlpha(0.5)
			f39_arg0.SpawnBeaconPoint:setScale(1.2, 1.2)
			f39_local1(f39_arg0.SpawnBeaconPoint)
		end,
	},
	Hidden = {
		DefaultClip = function(f43_arg0, f43_arg1)
			f43_arg0:__resetProperties()
			f43_arg0:setupElementClipCounter(5)
			f43_arg0.SpawnSelectRadius:completeAnimation()
			f43_arg0.SpawnSelectRadius:setAlpha(0)
			f43_arg0.clipFinished(f43_arg0.SpawnSelectRadius)
			f43_arg0.SpawnSelectIconBg:completeAnimation()
			f43_arg0.SpawnSelectIconBg:setAlpha(0)
			f43_arg0.clipFinished(f43_arg0.SpawnSelectIconBg)
			f43_arg0.SpawnSelectLabel:completeAnimation()
			f43_arg0.SpawnSelectLabel:setAlpha(0)
			f43_arg0.clipFinished(f43_arg0.SpawnSelectLabel)
			f43_arg0.SpawnSelectPulse:completeAnimation()
			f43_arg0.SpawnSelectPulse:setAlpha(0)
			f43_arg0.clipFinished(f43_arg0.SpawnSelectPulse)
			f43_arg0.SpawnBeaconPoint:completeAnimation()
			f43_arg0.SpawnBeaconPoint:setAlpha(0)
			f43_arg0.clipFinished(f43_arg0.SpawnBeaconPoint)
		end,
	},
}
CoD.SpawnBeaconMarker.__onClose = function(f44_arg0)
	f44_arg0.SpawnSelectRadius:close()
	f44_arg0.SpawnSelectIconBg:close()
	f44_arg0.SpawnSelectLabel:close()
	f44_arg0.SpawnSelectPulse:close()
	f44_arg0.SpawnBeaconPoint:close()
end
