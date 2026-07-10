require("x64:665072306db8376")
CoD.MOTD_BannerImage = InheritFrom(LUI.UIElement)
CoD.MOTD_BannerImage.__defaultWidth = 328
CoD.MOTD_BannerImage.__defaultHeight = 160
CoD.MOTD_BannerImage.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.MOTD_BannerImage)
	self.id = "MOTD_BannerImage"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local FrameSelectedCorner = CoD.MOTD_BannerImageInternal.new(f1_arg0, f1_arg1, 0, 0, 0, 328, 0, 0, 0, 160)
	FrameSelectedCorner:linkToElementModel(self, nil, false, function(model)
		FrameSelectedCorner:setModel(model, f1_arg1)
	end)
	self:addElement(FrameSelectedCorner)
	self.FrameSelectedCorner = FrameSelectedCorner
	self:mergeStateConditions({
		{
			stateName = "DefaultPC",
			condition = function(menu, element, event)
				return IsPC()
			end,
		},
		{
			stateName = "Selected",
			condition = function(menu, element, event)
				return true
			end,
		},
	})
	self:appendEventHandler("input_source_changed", function(f5_arg0, f5_arg1)
		f5_arg1.menu = f5_arg1.menu or f1_arg0
		CoD.Menu.UpdateButtonShownState(f5_arg0, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end)
	local f1_local2 = self
	local f1_local3 = self.subscribeToModel
	local f1_local4 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local3(f1_local2, f1_local4.LastInput, function(f6_arg0, f6_arg1)
		CoD.Menu.UpdateButtonShownState(f6_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	f1_arg0:AddButtonCallbackFunction(self, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], "ui_confirm", function(element, menu, controller, model)
		if IsPC() and IsMouseOrKeyboard(controller) then
			CoD.MOTDUtility.MOTD_SelectItemPC(menu, self, controller, "ButtonsList")
			ClearMenuSavedState(menu)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsPC() and IsMouseOrKeyboard(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x0, nil, "ui_confirm")
			return false
		else
			return false
		end
	end, false)
	FrameSelectedCorner.id = "FrameSelectedCorner"
	self.__defaultFocus = FrameSelectedCorner
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.MOTD_BannerImage.__resetProperties = function(f9_arg0)
	f9_arg0.FrameSelectedCorner:completeAnimation()
	f9_arg0.FrameSelectedCorner:setScale(1, 1)
end
CoD.MOTD_BannerImage.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(1)
			f10_arg0.FrameSelectedCorner:completeAnimation()
			f10_arg0.FrameSelectedCorner:setScale(1, 1)
			f10_arg0.clipFinished(f10_arg0.FrameSelectedCorner)
		end,
		ChildFocus = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(1)
			f11_arg0.FrameSelectedCorner:completeAnimation()
			f11_arg0.FrameSelectedCorner:setScale(1.03, 1.03)
			f11_arg0.clipFinished(f11_arg0.FrameSelectedCorner)
		end,
		GainChildFocus = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(1)
			local f12_local0 = function(f13_arg0)
				f12_arg0.FrameSelectedCorner:beginAnimation(150, Enum[0xF50FFF429AB1890][0x53CEB9A0427197])
				f12_arg0.FrameSelectedCorner:setScale(1.03, 1.03)
				f12_arg0.FrameSelectedCorner:registerEventHandler("interrupted_keyframe", f12_arg0.clipInterrupted)
				f12_arg0.FrameSelectedCorner:registerEventHandler("transition_complete_keyframe", f12_arg0.clipFinished)
			end
			f12_arg0.FrameSelectedCorner:completeAnimation()
			f12_arg0.FrameSelectedCorner:setScale(1, 1)
			f12_local0(f12_arg0.FrameSelectedCorner)
		end,
		LoseChildFocus = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(1)
			local f14_local0 = function(f15_arg0)
				f14_arg0.FrameSelectedCorner:beginAnimation(150, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
				f14_arg0.FrameSelectedCorner:setScale(1, 1)
				f14_arg0.FrameSelectedCorner:registerEventHandler("interrupted_keyframe", f14_arg0.clipInterrupted)
				f14_arg0.FrameSelectedCorner:registerEventHandler("transition_complete_keyframe", f14_arg0.clipFinished)
			end
			f14_arg0.FrameSelectedCorner:completeAnimation()
			f14_arg0.FrameSelectedCorner:setScale(1.03, 1.03)
			f14_local0(f14_arg0.FrameSelectedCorner)
		end,
	},
	DefaultPC = {
		DefaultClip = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(1)
			f16_arg0.FrameSelectedCorner:completeAnimation()
			f16_arg0.FrameSelectedCorner:setScale(1, 1)
			f16_arg0.clipFinished(f16_arg0.FrameSelectedCorner)
		end,
		ChildFocus = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(1)
			f17_arg0.FrameSelectedCorner:completeAnimation()
			f17_arg0.FrameSelectedCorner:setScale(1.03, 1.03)
			f17_arg0.clipFinished(f17_arg0.FrameSelectedCorner)
		end,
		GainChildFocus = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(1)
			local f18_local0 = function(f19_arg0)
				f18_arg0.FrameSelectedCorner:beginAnimation(150, Enum[0xF50FFF429AB1890][0x53CEB9A0427197])
				f18_arg0.FrameSelectedCorner:setScale(1.03, 1.03)
				f18_arg0.FrameSelectedCorner:registerEventHandler("interrupted_keyframe", f18_arg0.clipInterrupted)
				f18_arg0.FrameSelectedCorner:registerEventHandler("transition_complete_keyframe", f18_arg0.clipFinished)
			end
			f18_arg0.FrameSelectedCorner:completeAnimation()
			f18_arg0.FrameSelectedCorner:setScale(1, 1)
			f18_local0(f18_arg0.FrameSelectedCorner)
		end,
		LoseChildFocus = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(1)
			local f20_local0 = function(f21_arg0)
				f20_arg0.FrameSelectedCorner:beginAnimation(150, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
				f20_arg0.FrameSelectedCorner:setScale(1, 1)
				f20_arg0.FrameSelectedCorner:registerEventHandler("interrupted_keyframe", f20_arg0.clipInterrupted)
				f20_arg0.FrameSelectedCorner:registerEventHandler("transition_complete_keyframe", f20_arg0.clipFinished)
			end
			f20_arg0.FrameSelectedCorner:completeAnimation()
			f20_arg0.FrameSelectedCorner:setScale(1.03, 1.03)
			f20_local0(f20_arg0.FrameSelectedCorner)
		end,
		Active = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(1)
			f22_arg0.FrameSelectedCorner:completeAnimation()
			f22_arg0.FrameSelectedCorner:setScale(1.03, 1.03)
			f22_arg0.clipFinished(f22_arg0.FrameSelectedCorner)
		end,
	},
	Selected = {
		DefaultClip = function(f23_arg0, f23_arg1)
			f23_arg0:__resetProperties()
			f23_arg0:setupElementClipCounter(0)
		end,
	},
}
CoD.MOTD_BannerImage.__onClose = function(f24_arg0)
	f24_arg0.FrameSelectedCorner:close()
end
