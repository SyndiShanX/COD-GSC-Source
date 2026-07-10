require("x64:bbbdf370351d3bc")
CoD.CodCasterObjectiveStatusControl = InheritFrom(LUI.UIElement)
CoD.CodCasterObjectiveStatusControl.__defaultWidth = 412
CoD.CodCasterObjectiveStatusControl.__defaultHeight = 64
CoD.CodCasterObjectiveStatusControl.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CodCasterObjectiveStatusControl)
	self.id = "CodCasterObjectiveStatusControl"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local CodCasterObjectiveStatusControlSiteA2 = CoD.CodCasterObjectiveStatusControlSite.new(f1_arg0, f1_arg1, 0, 0, 155, 215, 0.45, 0.45, -30, 30)
	CodCasterObjectiveStatusControlSiteA2:setAlpha(0)
	CodCasterObjectiveStatusControlSiteA2:subscribeToGlobalModel(f1_arg1, "HUDItems", "codcaster.ObjectiveA.color", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			CodCasterObjectiveStatusControlSiteA2.siteLED:setRGB(f2_local0)
		end
	end)
	CodCasterObjectiveStatusControlSiteA2:subscribeToGlobalModel(f1_arg1, "HUDItems", "codcaster.ObjectiveA.progress", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			CodCasterObjectiveStatusControlSiteA2.siteFill:setShaderVector(0, CoD.GetVectorComponentFromString(f3_local0, 1), CoD.GetVectorComponentFromString(f3_local0, 2), CoD.GetVectorComponentFromString(f3_local0, 3), CoD.GetVectorComponentFromString(f3_local0, 4))
		end
	end)
	CodCasterObjectiveStatusControlSiteA2:subscribeToGlobalModel(f1_arg1, "HUDItems", "codcaster.ObjectiveA.color", function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			CodCasterObjectiveStatusControlSiteA2.siteLetter:setRGB(f4_local0)
		end
	end)
	self:addElement(CodCasterObjectiveStatusControlSiteA2)
	self.CodCasterObjectiveStatusControlSiteA2 = CodCasterObjectiveStatusControlSiteA2
	local CodCasterObjectiveStatusControlSiteB2 = CoD.CodCasterObjectiveStatusControlSite.new(f1_arg0, f1_arg1, 0.55, 0.55, -30, 30, 0.45, 0.45, -30, 30)
	CodCasterObjectiveStatusControlSiteB2:setAlpha(0)
	CodCasterObjectiveStatusControlSiteB2.siteLetter:setImage(RegisterImage(0xFEE9CEC7F9FF4BC))
	CodCasterObjectiveStatusControlSiteB2:subscribeToGlobalModel(f1_arg1, "HUDItems", "codcaster.ObjectiveB.color", function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			CodCasterObjectiveStatusControlSiteB2.siteLED:setRGB(f5_local0)
		end
	end)
	CodCasterObjectiveStatusControlSiteB2:subscribeToGlobalModel(f1_arg1, "HUDItems", "codcaster.ObjectiveB.progress", function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			CodCasterObjectiveStatusControlSiteB2.siteFill:setShaderVector(0, CoD.GetVectorComponentFromString(f6_local0, 1), CoD.GetVectorComponentFromString(f6_local0, 2), CoD.GetVectorComponentFromString(f6_local0, 3), CoD.GetVectorComponentFromString(f6_local0, 4))
		end
	end)
	CodCasterObjectiveStatusControlSiteB2:subscribeToGlobalModel(f1_arg1, "HUDItems", "codcaster.ObjectiveB.color", function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			CodCasterObjectiveStatusControlSiteB2.siteLetter:setRGB(f7_local0)
		end
	end)
	self:addElement(CodCasterObjectiveStatusControlSiteB2)
	self.CodCasterObjectiveStatusControlSiteB2 = CodCasterObjectiveStatusControlSiteB2
	local CodCasterObjectiveStatusControlSiteB = CoD.CodCasterObjectiveStatusControlSite.new(f1_arg0, f1_arg1, 0.55, 0.55, -30, 30, 0.45, 0.45, -30, 30)
	CodCasterObjectiveStatusControlSiteB.siteLetter:setImage(RegisterImage(0xFEE9CEC7F9FF4BC))
	CodCasterObjectiveStatusControlSiteB:subscribeToGlobalModel(f1_arg1, "HUDItems", "codcaster.ObjectiveB.color", function(model)
		local f8_local0 = model:get()
		if f8_local0 ~= nil then
			CodCasterObjectiveStatusControlSiteB.siteLED:setRGB(f8_local0)
		end
	end)
	CodCasterObjectiveStatusControlSiteB:subscribeToGlobalModel(f1_arg1, "HUDItems", "codcaster.ObjectiveB.progress", function(model)
		local f9_local0 = model:get()
		if f9_local0 ~= nil then
			CodCasterObjectiveStatusControlSiteB.siteFill:setShaderVector(0, CoD.GetVectorComponentFromString(f9_local0, 1), CoD.GetVectorComponentFromString(f9_local0, 2), CoD.GetVectorComponentFromString(f9_local0, 3), CoD.GetVectorComponentFromString(f9_local0, 4))
		end
	end)
	CodCasterObjectiveStatusControlSiteB:subscribeToGlobalModel(f1_arg1, "HUDItems", "codcaster.ObjectiveB.color", function(model)
		local f10_local0 = model:get()
		if f10_local0 ~= nil then
			CodCasterObjectiveStatusControlSiteB.siteLetter:setRGB(f10_local0)
		end
	end)
	self:addElement(CodCasterObjectiveStatusControlSiteB)
	self.CodCasterObjectiveStatusControlSiteB = CodCasterObjectiveStatusControlSiteB
	local CodCasterObjectiveStatusControlSiteA = CoD.CodCasterObjectiveStatusControlSite.new(f1_arg0, f1_arg1, 0, 0, 155, 215, 0.45, 0.45, -30, 30)
	CodCasterObjectiveStatusControlSiteA:subscribeToGlobalModel(f1_arg1, "HUDItems", "codcaster.ObjectiveA.color", function(model)
		local f11_local0 = model:get()
		if f11_local0 ~= nil then
			CodCasterObjectiveStatusControlSiteA.siteLED:setRGB(f11_local0)
		end
	end)
	CodCasterObjectiveStatusControlSiteA:subscribeToGlobalModel(f1_arg1, "HUDItems", "codcaster.ObjectiveA.progress", function(model)
		local f12_local0 = model:get()
		if f12_local0 ~= nil then
			CodCasterObjectiveStatusControlSiteA.siteFill:setShaderVector(0, CoD.GetVectorComponentFromString(f12_local0, 1), CoD.GetVectorComponentFromString(f12_local0, 2), CoD.GetVectorComponentFromString(f12_local0, 3), CoD.GetVectorComponentFromString(f12_local0, 4))
		end
	end)
	CodCasterObjectiveStatusControlSiteA:subscribeToGlobalModel(f1_arg1, "HUDItems", "codcaster.ObjectiveA.color", function(model)
		local f13_local0 = model:get()
		if f13_local0 ~= nil then
			CodCasterObjectiveStatusControlSiteA.siteLetter:setRGB(f13_local0)
		end
	end)
	self:addElement(CodCasterObjectiveStatusControlSiteA)
	self.CodCasterObjectiveStatusControlSiteA = CodCasterObjectiveStatusControlSiteA
	local glow = LUI.UIImage.new(0.5, 0.5, -16, 16, 0.5, 0.5, -19, 13)
	glow:setAlpha(0)
	glow:setImage(RegisterImage(0xD9007F963116063))
	self:addElement(glow)
	self.glow = glow
	self:mergeStateConditions({
		{
			stateName = "EndRound",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueEqualTo(f1_arg1, "hudItems.codcaster.ObjectiveB.progress", 1) and CoD.ModelUtility.IsModelValueEqualTo(f1_arg1, "hudItems.codcaster.ObjectiveA.progress", 1)
			end,
		},
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return true
			end,
		},
		{
			stateName = "A",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueEqualTo(f1_arg1, "hudItems.codcaster.ObjectiveB.progress", 1) and not CoD.ModelUtility.IsModelValueEqualTo(f1_arg1, "hudItems.codcaster.ObjectiveA.progress", 1)
			end,
		},
		{
			stateName = "B",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueEqualTo(f1_arg1, "hudItems.codcaster.ObjectiveA.progress", 1) and not CoD.ModelUtility.IsModelValueEqualTo(f1_arg1, "hudItems.codcaster.ObjectiveB.progress", 1)
			end,
		},
	})
	local f1_local6 = self
	local f1_local7 = self.subscribeToModel
	local f1_local8 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local7(f1_local6, f1_local8["hudItems.codcaster.ObjectiveB.progress"], function(f18_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f18_arg0:get(),
			modelName = "hudItems.codcaster.ObjectiveB.progress",
		})
	end, false)
	f1_local6 = self
	f1_local7 = self.subscribeToModel
	f1_local8 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local7(f1_local6, f1_local8["hudItems.codcaster.ObjectiveA.progress"], function(f19_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f19_arg0:get(),
			modelName = "hudItems.codcaster.ObjectiveA.progress",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(self, "setState", function(element, controller, f20_arg2, f20_arg3, f20_arg4)
		if IsSelfInState(self, "A") then
			PlayClip(self, "topA", controller)
		elseif IsSelfInState(self, "B") then
			PlayClip(self, "topB", controller)
		end
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CodCasterObjectiveStatusControl.__resetProperties = function(f21_arg0)
	f21_arg0.CodCasterObjectiveStatusControlSiteA:completeAnimation()
	f21_arg0.CodCasterObjectiveStatusControlSiteB:completeAnimation()
	f21_arg0.CodCasterObjectiveStatusControlSiteB2:completeAnimation()
	f21_arg0.CodCasterObjectiveStatusControlSiteA2:completeAnimation()
	f21_arg0.glow:completeAnimation()
	f21_arg0.CodCasterObjectiveStatusControlSiteA:setLeftRight(0, 0, 155, 215)
	f21_arg0.CodCasterObjectiveStatusControlSiteA:setAlpha(1)
	f21_arg0.CodCasterObjectiveStatusControlSiteA:setScale(1, 1)
	f21_arg0.CodCasterObjectiveStatusControlSiteB:setLeftRight(0.55, 0.55, -30, 30)
	f21_arg0.CodCasterObjectiveStatusControlSiteB:setAlpha(1)
	f21_arg0.CodCasterObjectiveStatusControlSiteB:setScale(1, 1)
	f21_arg0.CodCasterObjectiveStatusControlSiteB2:setLeftRight(0.55, 0.55, -30, 30)
	f21_arg0.CodCasterObjectiveStatusControlSiteB2:setAlpha(0)
	f21_arg0.CodCasterObjectiveStatusControlSiteB2:setScale(1, 1)
	f21_arg0.CodCasterObjectiveStatusControlSiteA2:setLeftRight(0, 0, 155, 215)
	f21_arg0.CodCasterObjectiveStatusControlSiteA2:setAlpha(0)
	f21_arg0.CodCasterObjectiveStatusControlSiteA2:setScale(1, 1)
	f21_arg0.glow:setAlpha(0)
	f21_arg0.glow:setScale(1, 1)
end
CoD.CodCasterObjectiveStatusControl.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(0)
		end,
	},
	EndRound = {
		DefaultClip = function(f23_arg0, f23_arg1)
			f23_arg0:__resetProperties()
			f23_arg0:setupElementClipCounter(2)
			f23_arg0.CodCasterObjectiveStatusControlSiteB:completeAnimation()
			f23_arg0.CodCasterObjectiveStatusControlSiteB:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.CodCasterObjectiveStatusControlSiteB)
			f23_arg0.CodCasterObjectiveStatusControlSiteA:completeAnimation()
			f23_arg0.CodCasterObjectiveStatusControlSiteA:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.CodCasterObjectiveStatusControlSiteA)
		end,
	},
	Hidden = {
		DefaultClip = function(f24_arg0, f24_arg1)
			f24_arg0:__resetProperties()
			f24_arg0:setupElementClipCounter(4)
			f24_arg0.CodCasterObjectiveStatusControlSiteA2:completeAnimation()
			f24_arg0.CodCasterObjectiveStatusControlSiteA2:setAlpha(0)
			f24_arg0.clipFinished(f24_arg0.CodCasterObjectiveStatusControlSiteA2)
			f24_arg0.CodCasterObjectiveStatusControlSiteB2:completeAnimation()
			f24_arg0.CodCasterObjectiveStatusControlSiteB2:setAlpha(0)
			f24_arg0.clipFinished(f24_arg0.CodCasterObjectiveStatusControlSiteB2)
			f24_arg0.CodCasterObjectiveStatusControlSiteB:completeAnimation()
			f24_arg0.CodCasterObjectiveStatusControlSiteB:setAlpha(0)
			f24_arg0.clipFinished(f24_arg0.CodCasterObjectiveStatusControlSiteB)
			f24_arg0.CodCasterObjectiveStatusControlSiteA:completeAnimation()
			f24_arg0.CodCasterObjectiveStatusControlSiteA:setAlpha(0)
			f24_arg0.clipFinished(f24_arg0.CodCasterObjectiveStatusControlSiteA)
		end,
	},
	A = {
		DefaultClip = function(f25_arg0, f25_arg1)
			f25_arg0:__resetProperties()
			f25_arg0:setupElementClipCounter(0)
		end,
		topA = function(f26_arg0, f26_arg1)
			f26_arg0:__resetProperties()
			f26_arg0:setupElementClipCounter(5)
			f26_arg0.CodCasterObjectiveStatusControlSiteA2:completeAnimation()
			f26_arg0.CodCasterObjectiveStatusControlSiteA2:setAlpha(0)
			f26_arg0.clipFinished(f26_arg0.CodCasterObjectiveStatusControlSiteA2)
			f26_arg0.CodCasterObjectiveStatusControlSiteB2:completeAnimation()
			f26_arg0.CodCasterObjectiveStatusControlSiteB2:setAlpha(0)
			f26_arg0.clipFinished(f26_arg0.CodCasterObjectiveStatusControlSiteB2)
			local f26_local0 = function(f27_arg0)
				local f27_local0 = function(f28_arg0)
					f28_arg0:beginAnimation(200, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
					f28_arg0:setLeftRight(0, 0, 176, 236)
					f28_arg0:setAlpha(0)
					f28_arg0:setScale(1, 1)
					f28_arg0:registerEventHandler("transition_complete_keyframe", f26_arg0.clipFinished)
				end
				f26_arg0.CodCasterObjectiveStatusControlSiteB:beginAnimation(200)
				f26_arg0.CodCasterObjectiveStatusControlSiteB:setLeftRight(0, 0, 186.25, 246.25)
				f26_arg0.CodCasterObjectiveStatusControlSiteB:setScale(0.8, 0.8)
				f26_arg0.CodCasterObjectiveStatusControlSiteB:registerEventHandler("interrupted_keyframe", f26_arg0.clipInterrupted)
				f26_arg0.CodCasterObjectiveStatusControlSiteB:registerEventHandler("transition_complete_keyframe", f27_local0)
			end
			f26_arg0.CodCasterObjectiveStatusControlSiteB:completeAnimation()
			f26_arg0.CodCasterObjectiveStatusControlSiteB:setLeftRight(0, 0, 196.5, 256.5)
			f26_arg0.CodCasterObjectiveStatusControlSiteB:setAlpha(1)
			f26_arg0.CodCasterObjectiveStatusControlSiteB:setScale(1, 1)
			f26_local0(f26_arg0.CodCasterObjectiveStatusControlSiteB)
			local f26_local1 = function(f29_arg0)
				local f29_local0 = function(f30_arg0)
					f30_arg0:beginAnimation(200, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
					f30_arg0:setLeftRight(0, 0, 176, 236)
					f30_arg0:setScale(1, 1)
					f30_arg0:registerEventHandler("transition_complete_keyframe", f26_arg0.clipFinished)
				end
				f26_arg0.CodCasterObjectiveStatusControlSiteA:beginAnimation(200)
				f26_arg0.CodCasterObjectiveStatusControlSiteA:setLeftRight(0, 0, 165.5, 225.5)
				f26_arg0.CodCasterObjectiveStatusControlSiteA:setScale(1.2, 1.2)
				f26_arg0.CodCasterObjectiveStatusControlSiteA:registerEventHandler("interrupted_keyframe", f26_arg0.clipInterrupted)
				f26_arg0.CodCasterObjectiveStatusControlSiteA:registerEventHandler("transition_complete_keyframe", f29_local0)
			end
			f26_arg0.CodCasterObjectiveStatusControlSiteA:completeAnimation()
			f26_arg0.CodCasterObjectiveStatusControlSiteA:setLeftRight(0, 0, 155, 215)
			f26_arg0.CodCasterObjectiveStatusControlSiteA:setScale(1, 1)
			f26_local1(f26_arg0.CodCasterObjectiveStatusControlSiteA)
			local f26_local2 = function(f31_arg0)
				local f31_local0 = function(f32_arg0)
					f32_arg0:beginAnimation(100)
					f32_arg0:setAlpha(0)
					f32_arg0:setScale(1.25, 1.25)
					f32_arg0:registerEventHandler("transition_complete_keyframe", f26_arg0.clipFinished)
				end
				f31_arg0:beginAnimation(99)
				f31_arg0:setAlpha(1)
				f31_arg0:registerEventHandler("transition_complete_keyframe", f31_local0)
			end
			f26_arg0.glow:beginAnimation(400)
			f26_arg0.glow:setAlpha(0)
			f26_arg0.glow:setScale(1, 1)
			f26_arg0.glow:registerEventHandler("interrupted_keyframe", f26_arg0.clipInterrupted)
			f26_arg0.glow:registerEventHandler("transition_complete_keyframe", f26_local2)
		end,
	},
	B = {
		DefaultClip = function(f33_arg0, f33_arg1)
			f33_arg0:__resetProperties()
			f33_arg0:setupElementClipCounter(0)
		end,
		topB = function(f34_arg0, f34_arg1)
			f34_arg0:__resetProperties()
			f34_arg0:setupElementClipCounter(5)
			local f34_local0 = function(f35_arg0)
				local f35_local0 = function(f36_arg0)
					f36_arg0:beginAnimation(200, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
					f36_arg0:setLeftRight(0, 0, 176, 236)
					f36_arg0:setAlpha(0)
					f36_arg0:registerEventHandler("transition_complete_keyframe", f34_arg0.clipFinished)
				end
				f34_arg0.CodCasterObjectiveStatusControlSiteA2:beginAnimation(200)
				f34_arg0.CodCasterObjectiveStatusControlSiteA2:setLeftRight(0, 0, 165.5, 225.5)
				f34_arg0.CodCasterObjectiveStatusControlSiteA2:registerEventHandler("interrupted_keyframe", f34_arg0.clipInterrupted)
				f34_arg0.CodCasterObjectiveStatusControlSiteA2:registerEventHandler("transition_complete_keyframe", f35_local0)
			end
			f34_arg0.CodCasterObjectiveStatusControlSiteA2:completeAnimation()
			f34_arg0.CodCasterObjectiveStatusControlSiteA2:setLeftRight(0, 0, 155, 215)
			f34_arg0.CodCasterObjectiveStatusControlSiteA2:setAlpha(1)
			f34_arg0.CodCasterObjectiveStatusControlSiteA2:setScale(0.8, 0.8)
			f34_local0(f34_arg0.CodCasterObjectiveStatusControlSiteA2)
			local f34_local1 = function(f37_arg0)
				local f37_local0 = function(f38_arg0)
					f38_arg0:beginAnimation(200, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
					f38_arg0:setLeftRight(0, 0, 176, 236)
					f38_arg0:setScale(1, 1)
					f38_arg0:registerEventHandler("transition_complete_keyframe", f34_arg0.clipFinished)
				end
				f34_arg0.CodCasterObjectiveStatusControlSiteB2:beginAnimation(200)
				f34_arg0.CodCasterObjectiveStatusControlSiteB2:setLeftRight(0, 0, 186.25, 246.25)
				f34_arg0.CodCasterObjectiveStatusControlSiteB2:setScale(1.2, 1.2)
				f34_arg0.CodCasterObjectiveStatusControlSiteB2:registerEventHandler("interrupted_keyframe", f34_arg0.clipInterrupted)
				f34_arg0.CodCasterObjectiveStatusControlSiteB2:registerEventHandler("transition_complete_keyframe", f37_local0)
			end
			f34_arg0.CodCasterObjectiveStatusControlSiteB2:completeAnimation()
			f34_arg0.CodCasterObjectiveStatusControlSiteB2:setLeftRight(0, 0, 196.5, 256.5)
			f34_arg0.CodCasterObjectiveStatusControlSiteB2:setAlpha(1)
			f34_arg0.CodCasterObjectiveStatusControlSiteB2:setScale(1, 1)
			f34_local1(f34_arg0.CodCasterObjectiveStatusControlSiteB2)
			f34_arg0.CodCasterObjectiveStatusControlSiteB:completeAnimation()
			f34_arg0.CodCasterObjectiveStatusControlSiteB:setAlpha(0)
			f34_arg0.clipFinished(f34_arg0.CodCasterObjectiveStatusControlSiteB)
			f34_arg0.CodCasterObjectiveStatusControlSiteA:completeAnimation()
			f34_arg0.CodCasterObjectiveStatusControlSiteA:setAlpha(0)
			f34_arg0.clipFinished(f34_arg0.CodCasterObjectiveStatusControlSiteA)
			local f34_local2 = function(f39_arg0)
				local f39_local0 = function(f40_arg0)
					f40_arg0:beginAnimation(100)
					f40_arg0:setAlpha(0)
					f40_arg0:setScale(1.2, 1.2)
					f40_arg0:registerEventHandler("transition_complete_keyframe", f34_arg0.clipFinished)
				end
				f39_arg0:beginAnimation(99)
				f39_arg0:setAlpha(1)
				f39_arg0:registerEventHandler("transition_complete_keyframe", f39_local0)
			end
			f34_arg0.glow:beginAnimation(400)
			f34_arg0.glow:setAlpha(0)
			f34_arg0.glow:setScale(1, 1)
			f34_arg0.glow:registerEventHandler("interrupted_keyframe", f34_arg0.clipInterrupted)
			f34_arg0.glow:registerEventHandler("transition_complete_keyframe", f34_local2)
		end,
	},
}
CoD.CodCasterObjectiveStatusControl.__onClose = function(f41_arg0)
	f41_arg0.CodCasterObjectiveStatusControlSiteA2:close()
	f41_arg0.CodCasterObjectiveStatusControlSiteB2:close()
	f41_arg0.CodCasterObjectiveStatusControlSiteB:close()
	f41_arg0.CodCasterObjectiveStatusControlSiteA:close()
end
