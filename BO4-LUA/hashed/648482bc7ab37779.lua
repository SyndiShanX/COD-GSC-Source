require("x64:d4d452563872b67")
CoD.LaboratoryMixAgainButton = InheritFrom(LUI.UIElement)
CoD.LaboratoryMixAgainButton.__defaultWidth = 230
CoD.LaboratoryMixAgainButton.__defaultHeight = 60
CoD.LaboratoryMixAgainButton.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.LaboratoryMixAgainButton)
	self.id = "LaboratoryMixAgainButton"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Button = CoD.LaboratoryMixAgainButton_Internal.new(f1_arg0, f1_arg1, 0.5, 0.5, -115, 115, 0.5, 0.5, -30, 30)
	Button.Cost:setTTF("skorzhen")
	Button:linkToElementModel(self, nil, false, function(model)
		Button:setModel(model, f1_arg1)
	end)
	Button:linkToElementModel(self, "plasmaPrice", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			Button.Cost:setText(ConvertToUpperString(LocalizeIntoStringIfNotEmpty(@"hash_310EE05AA87A5498", f3_local0)))
		end
	end)
	self:addElement(Button)
	self.Button = Button
	Button.id = "Button"
	self.__defaultFocus = Button
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.LaboratoryMixAgainButton.__resetProperties = function(f4_arg0)
	f4_arg0.Button:completeAnimation()
	f4_arg0.Button:setScale(1, 1)
end
CoD.LaboratoryMixAgainButton.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(1)
			f6_arg0.Button:completeAnimation()
			f6_arg0.Button:setScale(1.05, 1.05)
			f6_arg0.clipFinished(f6_arg0.Button)
		end,
		GainChildFocus = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			local f7_local0 = function(f8_arg0)
				f7_arg0.Button:beginAnimation(200)
				f7_arg0.Button:setScale(1.05, 1.05)
				f7_arg0.Button:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.Button:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
			end
			f7_arg0.Button:completeAnimation()
			f7_arg0.Button:setScale(1, 1)
			f7_local0(f7_arg0.Button)
		end,
		LoseChildFocus = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(1)
			local f9_local0 = function(f10_arg0)
				f9_arg0.Button:beginAnimation(200)
				f9_arg0.Button:setScale(1, 1)
				f9_arg0.Button:registerEventHandler("interrupted_keyframe", f9_arg0.clipInterrupted)
				f9_arg0.Button:registerEventHandler("transition_complete_keyframe", f9_arg0.clipFinished)
			end
			f9_arg0.Button:completeAnimation()
			f9_arg0.Button:setScale(1.05, 1.05)
			f9_local0(f9_arg0.Button)
		end,
	},
	Disabled = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(0)
		end,
	},
}
CoD.LaboratoryMixAgainButton.__onClose = function(f12_arg0)
	f12_arg0.Button:close()
end
