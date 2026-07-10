require("x64:7a4ceca81c49387")
require("x64:f82e80882a4dd63")
CoD.DirectorContractsButton = InheritFrom(LUI.UIElement)
CoD.DirectorContractsButton.__defaultWidth = 354
CoD.DirectorContractsButton.__defaultHeight = 142
CoD.DirectorContractsButton.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.DirectorContractsButton)
	self.id = "DirectorContractsButton"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local DirectorContractsButtonInternal = CoD.DirectorContractsButtonInternal.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	DirectorContractsButtonInternal:registerEventHandler("gain_focus", function(element, event)
		local f2_local0 = nil
		if element.gainFocus then
			f2_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f2_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f2_local0
	end)
	f1_arg0:AddButtonCallbackFunction(DirectorContractsButtonInternal, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], nil, function(element, menu, controller, model)
		PlaySoundAlias("uin_toggle_generic")
		OpenOverlay(self, "BlackMarketContracts", controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, nil)
		return true
	end, false)
	self:addElement(DirectorContractsButtonInternal)
	self.DirectorContractsButtonInternal = DirectorContractsButtonInternal
	DirectorContractsButtonInternal.id = "DirectorContractsButtonInternal"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.DirectorContractsButton.__resetProperties = function(f5_arg0)
	f5_arg0.DirectorContractsButtonInternal:completeAnimation()
	f5_arg0.DirectorContractsButtonInternal:setScale(1, 1)
end
CoD.DirectorContractsButton.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			f7_arg0.DirectorContractsButtonInternal:completeAnimation()
			f7_arg0.DirectorContractsButtonInternal:setScale(1.05, 1.05)
			f7_arg0.clipFinished(f7_arg0.DirectorContractsButtonInternal)
		end,
		GainChildFocus = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(1)
			local f8_local0 = function(f9_arg0)
				f8_arg0.DirectorContractsButtonInternal:beginAnimation(150)
				f8_arg0.DirectorContractsButtonInternal:setScale(1.05, 1.05)
				f8_arg0.DirectorContractsButtonInternal:registerEventHandler("interrupted_keyframe", f8_arg0.clipInterrupted)
				f8_arg0.DirectorContractsButtonInternal:registerEventHandler("transition_complete_keyframe", f8_arg0.clipFinished)
			end
			f8_arg0.DirectorContractsButtonInternal:completeAnimation()
			f8_arg0.DirectorContractsButtonInternal:setScale(1, 1)
			f8_local0(f8_arg0.DirectorContractsButtonInternal)
		end,
		LoseChildFocus = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(1)
			local f10_local0 = function(f11_arg0)
				f10_arg0.DirectorContractsButtonInternal:beginAnimation(100)
				f10_arg0.DirectorContractsButtonInternal:setScale(1, 1)
				f10_arg0.DirectorContractsButtonInternal:registerEventHandler("interrupted_keyframe", f10_arg0.clipInterrupted)
				f10_arg0.DirectorContractsButtonInternal:registerEventHandler("transition_complete_keyframe", f10_arg0.clipFinished)
			end
			f10_arg0.DirectorContractsButtonInternal:completeAnimation()
			f10_arg0.DirectorContractsButtonInternal:setScale(1.05, 1.05)
			f10_local0(f10_arg0.DirectorContractsButtonInternal)
		end,
	},
	Hidden = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(0)
		end,
	},
}
CoD.DirectorContractsButton.__onClose = function(f13_arg0)
	f13_arg0.DirectorContractsButtonInternal:close()
end
