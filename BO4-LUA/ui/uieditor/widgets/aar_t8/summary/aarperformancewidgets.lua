require("x64:2cdae5a5c0acd06")
require("x64:47b2d5d8d3d4cb4")
require("x64:4d7d7b08e1c6bc")
require("x64:12a5550a78e3459")
CoD.AARPerformanceWidgets = InheritFrom(LUI.UIElement)
CoD.AARPerformanceWidgets.__defaultWidth = 1184
CoD.AARPerformanceWidgets.__defaultHeight = 132
CoD.AARPerformanceWidgets.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIHorizontalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 30, false)
	self:setAlignment(LUI.Alignment.Left)
	self:setClass(CoD.AARPerformanceWidgets)
	self.id = "AARPerformanceWidgets"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local AARKillsWidget = CoD.AARKillsWidget.new(f1_arg0, f1_arg1, 0.5, 0.5, -592, -177, 0.5, 0.5, -66, 66)
	AARKillsWidget:linkToElementModel(self, nil, false, function(model)
		AARKillsWidget:setModel(model, f1_arg1)
	end)
	self:addElement(AARKillsWidget)
	self.AARKillsWidget = AARKillsWidget
	local DamageStat = CoD.AARSingleStat.new(f1_arg0, f1_arg1, 0.5, 0.5, -147, 78, 0.5, 0.5, -66, 66)
	DamageStat.StatLabel:setText(Engine[0xF9F1239CFD921FE](0x61100A6B91B62C1))
	DamageStat:subscribeToGlobalModel(f1_arg1, "AARSummaryStats", "damage", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			DamageStat.StatValueGlow:setText(f3_local0)
		end
	end)
	DamageStat:subscribeToGlobalModel(f1_arg1, "AARSummaryStats", "damage", function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			DamageStat.StatValue:setText(f4_local0)
		end
	end)
	self:addElement(DamageStat)
	self.DamageStat = DamageStat
	local AAREfficiencyWidget = CoD.AAREfficiencyWidget.new(f1_arg0, f1_arg1, 0.5, 0.5, 108, 378, 0.5, 0.5, -66, 66)
	AAREfficiencyWidget:linkToElementModel(self, nil, false, function(model)
		AAREfficiencyWidget:setModel(model, f1_arg1)
	end)
	self:addElement(AAREfficiencyWidget)
	self.AAREfficiencyWidget = AAREfficiencyWidget
	local AARPaintCansStat = CoD.AARPaintCansStat.new(f1_arg0, f1_arg1, 0.5, 0.5, 408, 588, 0.5, 0.5, -66, 66)
	AARPaintCansStat:subscribeToGlobalModel(f1_arg1, "AARSummaryStats", "paintCans", function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			AARPaintCansStat.StatValueGlow:setText(f6_local0)
		end
	end)
	AARPaintCansStat:subscribeToGlobalModel(f1_arg1, "AARSummaryStats", "paintCans", function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			AARPaintCansStat.StatValue:setText(f7_local0)
		end
	end)
	self:addElement(AARPaintCansStat)
	self.AARPaintCansStat = AARPaintCansStat
	self:mergeStateConditions({
		{
			stateName = "VisibleSolo",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueEqualToEnum(f1_arg1, "AAR.activeTab", CoD.AARUtility.AARTabs.AAR_SUMMARY) and CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "gametype", 0x5F8EE90CBFFA9E7)
			end,
		},
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueEqualToEnum(f1_arg1, "AAR.activeTab", CoD.AARUtility.AARTabs.AAR_SUMMARY)
			end,
		},
	})
	local f1_local5 = self
	local f1_local6 = self.subscribeToModel
	local f1_local7 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local6(f1_local5, f1_local7["AAR.activeTab"], function(f10_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f10_arg0:get(),
			modelName = "AAR.activeTab",
		})
	end, false)
	self:linkToElementModel(self, "gametype", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "gametype",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.AARPerformanceWidgets.__resetProperties = function(f12_arg0)
	f12_arg0.DamageStat:completeAnimation()
	f12_arg0.AAREfficiencyWidget:completeAnimation()
	f12_arg0.AARKillsWidget:completeAnimation()
	f12_arg0.AARPaintCansStat:completeAnimation()
	f12_arg0.DamageStat:setAlpha(1)
	f12_arg0.AAREfficiencyWidget:setAlpha(1)
	f12_arg0.AARKillsWidget:setAlpha(1)
	f12_arg0.AARPaintCansStat:setAlpha(1)
end
CoD.AARPerformanceWidgets.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(4)
			f13_arg0.AARKillsWidget:completeAnimation()
			f13_arg0.AARKillsWidget:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.AARKillsWidget)
			f13_arg0.DamageStat:completeAnimation()
			f13_arg0.DamageStat:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.DamageStat)
			f13_arg0.AAREfficiencyWidget:completeAnimation()
			f13_arg0.AAREfficiencyWidget:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.AAREfficiencyWidget)
			f13_arg0.AARPaintCansStat:completeAnimation()
			f13_arg0.AARPaintCansStat:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.AARPaintCansStat)
		end,
	},
	VisibleSolo = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(4)
			local f14_local0 = function(f15_arg0)
				local f15_local0 = function(f16_arg0)
					local f16_local0 = function(f17_arg0)
						f17_arg0:beginAnimation(100)
						f17_arg0:setAlpha(1)
						f17_arg0:registerEventHandler("transition_complete_keyframe", f14_arg0.clipFinished)
					end
					f16_arg0:beginAnimation(100)
					f16_arg0:registerEventHandler("transition_complete_keyframe", f16_local0)
				end
				f14_arg0.AARKillsWidget:beginAnimation(100)
				f14_arg0.AARKillsWidget:registerEventHandler("interrupted_keyframe", f14_arg0.clipInterrupted)
				f14_arg0.AARKillsWidget:registerEventHandler("transition_complete_keyframe", f15_local0)
			end
			f14_arg0.AARKillsWidget:completeAnimation()
			f14_arg0.AARKillsWidget:setAlpha(0)
			f14_local0(f14_arg0.AARKillsWidget)
			local f14_local1 = function(f18_arg0)
				local f18_local0 = function(f19_arg0)
					local f19_local0 = function(f20_arg0)
						f20_arg0:beginAnimation(99)
						f20_arg0:setAlpha(1)
						f20_arg0:registerEventHandler("transition_complete_keyframe", f14_arg0.clipFinished)
					end
					f19_arg0:beginAnimation(120)
					f19_arg0:registerEventHandler("transition_complete_keyframe", f19_local0)
				end
				f14_arg0.DamageStat:beginAnimation(100)
				f14_arg0.DamageStat:registerEventHandler("interrupted_keyframe", f14_arg0.clipInterrupted)
				f14_arg0.DamageStat:registerEventHandler("transition_complete_keyframe", f18_local0)
			end
			f14_arg0.DamageStat:completeAnimation()
			f14_arg0.DamageStat:setAlpha(0)
			f14_local1(f14_arg0.DamageStat)
			f14_arg0.AAREfficiencyWidget:completeAnimation()
			f14_arg0.AAREfficiencyWidget:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.AAREfficiencyWidget)
			local f14_local2 = function(f21_arg0)
				local f21_local0 = function(f22_arg0)
					local f22_local0 = function(f23_arg0)
						f23_arg0:beginAnimation(100)
						f23_arg0:setAlpha(1)
						f23_arg0:registerEventHandler("transition_complete_keyframe", f14_arg0.clipFinished)
					end
					f22_arg0:beginAnimation(160)
					f22_arg0:registerEventHandler("transition_complete_keyframe", f22_local0)
				end
				f14_arg0.AARPaintCansStat:beginAnimation(100)
				f14_arg0.AARPaintCansStat:registerEventHandler("interrupted_keyframe", f14_arg0.clipInterrupted)
				f14_arg0.AARPaintCansStat:registerEventHandler("transition_complete_keyframe", f21_local0)
			end
			f14_arg0.AARPaintCansStat:completeAnimation()
			f14_arg0.AARPaintCansStat:setAlpha(0)
			f14_local2(f14_arg0.AARPaintCansStat)
		end,
	},
	Visible = {
		DefaultClip = function(f24_arg0, f24_arg1)
			f24_arg0:__resetProperties()
			f24_arg0:setupElementClipCounter(4)
			local f24_local0 = function(f25_arg0)
				local f25_local0 = function(f26_arg0)
					local f26_local0 = function(f27_arg0)
						f27_arg0:beginAnimation(100)
						f27_arg0:setAlpha(1)
						f27_arg0:registerEventHandler("transition_complete_keyframe", f24_arg0.clipFinished)
					end
					f26_arg0:beginAnimation(100)
					f26_arg0:registerEventHandler("transition_complete_keyframe", f26_local0)
				end
				f24_arg0.AARKillsWidget:beginAnimation(100)
				f24_arg0.AARKillsWidget:registerEventHandler("interrupted_keyframe", f24_arg0.clipInterrupted)
				f24_arg0.AARKillsWidget:registerEventHandler("transition_complete_keyframe", f25_local0)
			end
			f24_arg0.AARKillsWidget:completeAnimation()
			f24_arg0.AARKillsWidget:setAlpha(0)
			f24_local0(f24_arg0.AARKillsWidget)
			local f24_local1 = function(f28_arg0)
				local f28_local0 = function(f29_arg0)
					local f29_local0 = function(f30_arg0)
						f30_arg0:beginAnimation(99)
						f30_arg0:setAlpha(1)
						f30_arg0:registerEventHandler("transition_complete_keyframe", f24_arg0.clipFinished)
					end
					f29_arg0:beginAnimation(120)
					f29_arg0:registerEventHandler("transition_complete_keyframe", f29_local0)
				end
				f24_arg0.DamageStat:beginAnimation(100)
				f24_arg0.DamageStat:registerEventHandler("interrupted_keyframe", f24_arg0.clipInterrupted)
				f24_arg0.DamageStat:registerEventHandler("transition_complete_keyframe", f28_local0)
			end
			f24_arg0.DamageStat:completeAnimation()
			f24_arg0.DamageStat:setAlpha(0)
			f24_local1(f24_arg0.DamageStat)
			local f24_local2 = function(f31_arg0)
				local f31_local0 = function(f32_arg0)
					local f32_local0 = function(f33_arg0)
						f33_arg0:beginAnimation(100)
						f33_arg0:setAlpha(1)
						f33_arg0:registerEventHandler("transition_complete_keyframe", f24_arg0.clipFinished)
					end
					f32_arg0:beginAnimation(139)
					f32_arg0:registerEventHandler("transition_complete_keyframe", f32_local0)
				end
				f24_arg0.AAREfficiencyWidget:beginAnimation(100)
				f24_arg0.AAREfficiencyWidget:registerEventHandler("interrupted_keyframe", f24_arg0.clipInterrupted)
				f24_arg0.AAREfficiencyWidget:registerEventHandler("transition_complete_keyframe", f31_local0)
			end
			f24_arg0.AAREfficiencyWidget:completeAnimation()
			f24_arg0.AAREfficiencyWidget:setAlpha(0)
			f24_local2(f24_arg0.AAREfficiencyWidget)
			local f24_local3 = function(f34_arg0)
				local f34_local0 = function(f35_arg0)
					local f35_local0 = function(f36_arg0)
						f36_arg0:beginAnimation(100)
						f36_arg0:setAlpha(1)
						f36_arg0:registerEventHandler("transition_complete_keyframe", f24_arg0.clipFinished)
					end
					f35_arg0:beginAnimation(160)
					f35_arg0:registerEventHandler("transition_complete_keyframe", f35_local0)
				end
				f24_arg0.AARPaintCansStat:beginAnimation(100)
				f24_arg0.AARPaintCansStat:registerEventHandler("interrupted_keyframe", f24_arg0.clipInterrupted)
				f24_arg0.AARPaintCansStat:registerEventHandler("transition_complete_keyframe", f34_local0)
			end
			f24_arg0.AARPaintCansStat:completeAnimation()
			f24_arg0.AARPaintCansStat:setAlpha(0)
			f24_local3(f24_arg0.AARPaintCansStat)
		end,
	},
}
CoD.AARPerformanceWidgets.__onClose = function(f37_arg0)
	f37_arg0.AARKillsWidget:close()
	f37_arg0.DamageStat:close()
	f37_arg0.AAREfficiencyWidget:close()
	f37_arg0.AARPaintCansStat:close()
end
