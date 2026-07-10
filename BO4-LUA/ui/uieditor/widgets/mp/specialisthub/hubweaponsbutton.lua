require("x64:80eb9706d854cc4")
CoD.HubWeaponsButton = InheritFrom(LUI.UIElement)
CoD.HubWeaponsButton.__defaultWidth = 393
CoD.HubWeaponsButton.__defaultHeight = 379
CoD.HubWeaponsButton.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.HubWeaponsButton)
	self.id = "HubWeaponsButton"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local CommonTiledDotline = CoD.HubWeaponsButtonInternal.new(f1_arg0, f1_arg1, 0, 0, 0, 393, 0, 0, 0, 379)
	CommonTiledDotline:linkToElementModel(self, nil, false, function(model)
		CommonTiledDotline:setModel(model, f1_arg1)
	end)
	self:addElement(CommonTiledDotline)
	self.CommonTiledDotline = CommonTiledDotline
	CommonTiledDotline.id = "CommonTiledDotline"
	self.__defaultFocus = CommonTiledDotline
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.HubWeaponsButton.__resetProperties = function(f3_arg0)
	f3_arg0.CommonTiledDotline:completeAnimation()
	f3_arg0.CommonTiledDotline:setScale(1, 1)
end
CoD.HubWeaponsButton.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			f5_arg0.CommonTiledDotline:completeAnimation()
			f5_arg0.CommonTiledDotline:setScale(1.02, 1.03)
			f5_arg0.clipFinished(f5_arg0.CommonTiledDotline)
		end,
		GainChildFocus = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(1)
			local f6_local0 = function(f7_arg0)
				f6_arg0.CommonTiledDotline:beginAnimation(150, Enum[@"luitween"][@"luitween_ease_in"])
				f6_arg0.CommonTiledDotline:setScale(1.02, 1.03)
				f6_arg0.CommonTiledDotline:registerEventHandler("interrupted_keyframe", f6_arg0.clipInterrupted)
				f6_arg0.CommonTiledDotline:registerEventHandler("transition_complete_keyframe", f6_arg0.clipFinished)
			end
			f6_arg0.CommonTiledDotline:completeAnimation()
			f6_arg0.CommonTiledDotline:setScale(1, 1)
			f6_local0(f6_arg0.CommonTiledDotline)
		end,
		LoseChildFocus = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(1)
			local f8_local0 = function(f9_arg0)
				f8_arg0.CommonTiledDotline:beginAnimation(100, Enum[@"luitween"][@"luitween_ease_out"])
				f8_arg0.CommonTiledDotline:setScale(1, 1)
				f8_arg0.CommonTiledDotline:registerEventHandler("interrupted_keyframe", f8_arg0.clipInterrupted)
				f8_arg0.CommonTiledDotline:registerEventHandler("transition_complete_keyframe", f8_arg0.clipFinished)
			end
			f8_arg0.CommonTiledDotline:completeAnimation()
			f8_arg0.CommonTiledDotline:setScale(1.02, 1.03)
			f8_local0(f8_arg0.CommonTiledDotline)
		end,
	},
}
CoD.HubWeaponsButton.__onClose = function(f10_arg0)
	f10_arg0.CommonTiledDotline:close()
end
