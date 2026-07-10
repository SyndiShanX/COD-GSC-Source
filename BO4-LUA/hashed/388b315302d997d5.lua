require("x64:eab40f398bbf5a3")
CoD.AbilityCallout = InheritFrom(LUI.UIElement)
CoD.AbilityCallout.__defaultWidth = 300
CoD.AbilityCallout.__defaultHeight = 75
CoD.AbilityCallout.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.AbilityCallout)
	self.id = "AbilityCallout"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ClanTag = CoD.AbilityCallout_Internal.new(f1_arg0, f1_arg1, 0, 0, 0, 300, 0, 0, 0, 75)
	ClanTag:linkToElementModel(self, nil, false, function(model)
		ClanTag:setModel(model, f1_arg1)
	end)
	self:addElement(ClanTag)
	self.ClanTag = ClanTag
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.AbilityCallout.__resetProperties = function(f3_arg0)
	f3_arg0.ClanTag:completeAnimation()
	f3_arg0.ClanTag:setLeftRight(0, 0, 0, 300)
	f3_arg0.ClanTag:setTopBottom(0, 0, 0, 75)
	f3_arg0.ClanTag:setAlpha(1)
end
CoD.AbilityCallout.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(1)
			f4_arg0.ClanTag:completeAnimation()
			f4_arg0.ClanTag:setAlpha(0)
			f4_arg0.clipFinished(f4_arg0.ClanTag)
		end,
		Activate = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			local f5_local0 = function(f6_arg0)
				local f6_local0 = function(f7_arg0)
					local f7_local0 = function(f8_arg0)
						f8_arg0:beginAnimation(500)
						f8_arg0:setAlpha(0)
						f8_arg0:registerEventHandler("transition_complete_keyframe", f5_arg0.clipFinished)
					end
					f7_arg0:beginAnimation(5000)
					f7_arg0:registerEventHandler("transition_complete_keyframe", f7_local0)
				end
				f5_arg0.ClanTag:beginAnimation(250)
				f5_arg0.ClanTag:setLeftRight(0, 0, 0, 300)
				f5_arg0.ClanTag:registerEventHandler("interrupted_keyframe", f5_arg0.clipInterrupted)
				f5_arg0.ClanTag:registerEventHandler("transition_complete_keyframe", f6_local0)
			end
			f5_arg0.ClanTag:completeAnimation()
			f5_arg0.ClanTag:setLeftRight(0, 0, -300, 0)
			f5_arg0.ClanTag:setTopBottom(0, 0, 0, 75)
			f5_arg0.ClanTag:setAlpha(1)
			f5_local0(f5_arg0.ClanTag)
		end,
	},
}
CoD.AbilityCallout.__onClose = function(f9_arg0)
	f9_arg0.ClanTag:close()
end
