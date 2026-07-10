CoD.CodCasterObjectiveStatusControlSite = InheritFrom(LUI.UIElement)
CoD.CodCasterObjectiveStatusControlSite.__defaultWidth = 60
CoD.CodCasterObjectiveStatusControlSite.__defaultHeight = 60
CoD.CodCasterObjectiveStatusControlSite.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CodCasterObjectiveStatusControlSite)
	self.id = "CodCasterObjectiveStatusControlSite"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local siteBacker = LUI.UIImage.new(0, 0, 0, 60, 0, 0, 0, 60)
	siteBacker:setAlpha(0)
	siteBacker:setScale(0.5, 0.5)
	siteBacker:setImage(RegisterImage(@"uie_ui_hud_core_waypoint_control_backer"))
	self:addElement(siteBacker)
	self.siteBacker = siteBacker
	local siteLED = LUI.UIImage.new(0, 0, 0, 60, 0, 0, 0, 60)
	siteLED:setScale(0.5, 0.5)
	siteLED:setImage(RegisterImage(@"uie_ui_hud_core_waypoint_led"))
	siteLED:subscribeToGlobalModel(f1_arg1, "HUDItems", "codcaster.ObjectiveA.color", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			siteLED:setRGB(f2_local0)
		end
	end)
	self:addElement(siteLED)
	self.siteLED = siteLED
	local siteEmpty = LUI.UIImage.new(0, 0, 0, 60, 0, 0, 0, 60)
	siteEmpty:setScale(0.5, 0.5)
	siteEmpty:setImage(RegisterImage(@"uie_ui_hud_core_waypoint_control_empty"))
	self:addElement(siteEmpty)
	self.siteEmpty = siteEmpty
	local siteFill = LUI.UIImage.new(0, 0, 0, 60, 0, 0, 0, 60)
	siteFill:setScale(0.5, 0.5)
	siteFill:setImage(RegisterImage(@"uie_ui_hud_core_waypoint_control_fill_02"))
	siteFill:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_clock_normal"))
	siteFill:setShaderVector(0, 1, 0, 0, 0)
	siteFill:setShaderVector(1, 0.5, 0, 0, 0)
	siteFill:setShaderVector(2, 0.5, 0, 0, 0)
	siteFill:setShaderVector(3, 0, 0, 0, 0)
	siteFill:setShaderVector(4, 0, 0, 0, 0)
	siteFill:subscribeToGlobalModel(f1_arg1, "HUDItems", "codcaster.attackTeamColor", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			siteFill:setRGB(f3_local0)
		end
	end)
	self:addElement(siteFill)
	self.siteFill = siteFill
	local siteLetter = LUI.UIImage.new(0, 0, 0, 60, 0, 0, 0, 60)
	siteLetter:setScale(0.5, 0.5)
	siteLetter:setImage(RegisterImage(@"uie_ui_hud_core_waypoint_letter_a_02"))
	siteLetter:subscribeToGlobalModel(f1_arg1, "HUDItems", "codcaster.ObjectiveA.color", function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			siteLetter:setRGB(f4_local0)
		end
	end)
	self:addElement(siteLetter)
	self.siteLetter = siteLetter
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CodCasterObjectiveStatusControlSite.__resetProperties = function(f5_arg0)
	f5_arg0.siteLetter:completeAnimation()
	f5_arg0.siteFill:completeAnimation()
	f5_arg0.siteBacker:completeAnimation()
	f5_arg0.siteEmpty:completeAnimation()
	f5_arg0.siteLED:completeAnimation()
	f5_arg0.siteLetter:setAlpha(1)
	f5_arg0.siteLetter:setScale(0.5, 0.5)
	f5_arg0.siteLetter:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_normal"))
	f5_arg0.siteFill:setAlpha(1)
	f5_arg0.siteBacker:setAlpha(0)
	f5_arg0.siteEmpty:setAlpha(1)
	f5_arg0.siteLED:setAlpha(1)
end
CoD.CodCasterObjectiveStatusControlSite.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(0)
		end,
		pulse = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			local f7_local0 = function(f8_arg0)
				local f8_local0 = function(f9_arg0)
					f9_arg0:beginAnimation(199)
					f9_arg0:setScale(0.5, 0.5)
					f9_arg0:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
				end
				f7_arg0.siteLetter:beginAnimation(600, Enum[@"luitween"][@"luitween_ease_both"])
				f7_arg0.siteLetter:setScale(0.55, 0.55)
				f7_arg0.siteLetter:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.siteLetter:registerEventHandler("transition_complete_keyframe", f8_local0)
			end
			f7_arg0.siteLetter:completeAnimation()
			f7_arg0.siteLetter:setScale(0.5, 0.5)
			f7_arg0.siteLetter:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_glow"))
			f7_local0(f7_arg0.siteLetter)
			f7_arg0.nextClip = "pulse"
		end,
	},
	Completed = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(5)
			f10_arg0.siteBacker:completeAnimation()
			f10_arg0.siteBacker:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.siteBacker)
			local f10_local0 = function(f11_arg0)
				f10_arg0.siteLED:beginAnimation(240, Enum[@"luitween"][@"luitween_ease_both"])
				f10_arg0.siteLED:setAlpha(0)
				f10_arg0.siteLED:registerEventHandler("interrupted_keyframe", f10_arg0.clipInterrupted)
				f10_arg0.siteLED:registerEventHandler("transition_complete_keyframe", f10_arg0.clipFinished)
			end
			f10_arg0.siteLED:completeAnimation()
			f10_arg0.siteLED:setAlpha(1)
			f10_local0(f10_arg0.siteLED)
			local f10_local1 = function(f12_arg0)
				f10_arg0.siteEmpty:beginAnimation(240, Enum[@"luitween"][@"luitween_ease_both"])
				f10_arg0.siteEmpty:setAlpha(0)
				f10_arg0.siteEmpty:registerEventHandler("interrupted_keyframe", f10_arg0.clipInterrupted)
				f10_arg0.siteEmpty:registerEventHandler("transition_complete_keyframe", f10_arg0.clipFinished)
			end
			f10_arg0.siteEmpty:completeAnimation()
			f10_arg0.siteEmpty:setAlpha(1)
			f10_local1(f10_arg0.siteEmpty)
			local f10_local2 = function(f13_arg0)
				f10_arg0.siteFill:beginAnimation(240, Enum[@"luitween"][@"luitween_ease_both"])
				f10_arg0.siteFill:setAlpha(0)
				f10_arg0.siteFill:registerEventHandler("interrupted_keyframe", f10_arg0.clipInterrupted)
				f10_arg0.siteFill:registerEventHandler("transition_complete_keyframe", f10_arg0.clipFinished)
			end
			f10_arg0.siteFill:completeAnimation()
			f10_arg0.siteFill:setAlpha(1)
			f10_local2(f10_arg0.siteFill)
			local f10_local3 = function(f14_arg0)
				f10_arg0.siteLetter:beginAnimation(240, Enum[@"luitween"][@"luitween_ease_both"])
				f10_arg0.siteLetter:setAlpha(0)
				f10_arg0.siteLetter:registerEventHandler("interrupted_keyframe", f10_arg0.clipInterrupted)
				f10_arg0.siteLetter:registerEventHandler("transition_complete_keyframe", f10_arg0.clipFinished)
			end
			f10_arg0.siteLetter:completeAnimation()
			f10_arg0.siteLetter:setAlpha(1)
			f10_local3(f10_arg0.siteLetter)
		end,
	},
}
CoD.CodCasterObjectiveStatusControlSite.__onClose = function(f15_arg0)
	f15_arg0.siteLED:close()
	f15_arg0.siteFill:close()
	f15_arg0.siteLetter:close()
end
