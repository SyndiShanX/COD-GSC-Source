CoD.CraftActionButton = InheritFrom(LUI.UIElement)
CoD.CraftActionButton.__defaultWidth = 375
CoD.CraftActionButton.__defaultHeight = 38
CoD.CraftActionButton.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CraftActionButton)
	self.id = "CraftActionButton"
	self.soundSet = "SelectColor"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Background = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Background:setAlpha(0.95)
	Background:setImage(RegisterImage(0x34839E8065B1E53))
	Background:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	Background:setShaderVector(0, 0, 0, 0, 0)
	Background:setupNineSliceShader(196, 88)
	self:addElement(Background)
	self.Background = Background
	local Backing = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Backing:setRGB(0.84, 0.82, 0.74)
	Backing:setAlpha(0)
	self:addElement(Backing)
	self.Backing = Backing
	local flash = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	flash:setRGB(1, 0.47, 0)
	flash:setAlpha(0)
	self:addElement(flash)
	self.flash = flash
	local Frame = LUI.UIImage.new(0, 1, -1, 1, 0, 1, -2, 2)
	Frame:setRGB(0.2, 0.2, 0.2)
	Frame:setImage(RegisterImage(0x185E11D74ECA3D7))
	Frame:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD777557404A7B3))
	Frame:setShaderVector(0, 0, 0, 0, 0)
	Frame:setupNineSliceShader(16, 16)
	self:addElement(Frame)
	self.Frame = Frame
	local actionName = LUI.UIText.new(0, 1, 10, -10, 0.5, 0.5, -11, 11)
	actionName:setRGB(0.92, 0.92, 0.92)
	actionName:setTTF("ttmussels_regular")
	actionName:setLetterSpacing(2)
	actionName:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	actionName:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(actionName)
	self.actionName = actionName
	self.actionName:linkToElementModel(self, "actionName", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			actionName:setText(Engine[0xF9F1239CFD921FE](f2_local0))
		end
	end)
	f1_arg0:AddButtonCallbackFunction(self, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], nil, function(element, menu, controller, model)
		ProcessListAction(self, element, controller, menu)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x0, nil, nil)
		return false
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PreLoadFunc then
		PreLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local6 = self
	if IsPC() then
		CoD.PCUtility.SetCraftActionStatusModel(self, self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CraftActionButton.__resetProperties = function(f5_arg0)
	f5_arg0.flash:completeAnimation()
	f5_arg0.Backing:completeAnimation()
	f5_arg0.actionName:completeAnimation()
	f5_arg0.flash:setAlpha(0)
	f5_arg0.Backing:setAlpha(0)
	f5_arg0.actionName:setRGB(0.92, 0.92, 0.92)
end
CoD.CraftActionButton.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(0)
		end,
		Flash = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			local f7_local0 = function(f8_arg0)
				local f8_local0 = function(f9_arg0)
					f9_arg0:beginAnimation(50)
					f9_arg0:setAlpha(0)
					f9_arg0:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
				end
				f7_arg0.flash:beginAnimation(100)
				f7_arg0.flash:setAlpha(1)
				f7_arg0.flash:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.flash:registerEventHandler("transition_complete_keyframe", f8_local0)
			end
			f7_arg0.flash:completeAnimation()
			f7_arg0.flash:setAlpha(0)
			f7_local0(f7_arg0.flash)
		end,
		Focus = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(2)
			f10_arg0.Backing:completeAnimation()
			f10_arg0.Backing:setAlpha(0.03)
			f10_arg0.clipFinished(f10_arg0.Backing)
			f10_arg0.actionName:completeAnimation()
			f10_arg0.actionName:setRGB(1, 1, 1)
			f10_arg0.clipFinished(f10_arg0.actionName)
		end,
		GainFocus = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(2)
			local f11_local0 = function(f12_arg0)
				f11_arg0.Backing:beginAnimation(200)
				f11_arg0.Backing:setAlpha(0.03)
				f11_arg0.Backing:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.Backing:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
			end
			f11_arg0.Backing:completeAnimation()
			f11_arg0.Backing:setAlpha(0)
			f11_local0(f11_arg0.Backing)
			local f11_local1 = function(f13_arg0)
				f11_arg0.actionName:beginAnimation(200)
				f11_arg0.actionName:setRGB(1, 1, 1)
				f11_arg0.actionName:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.actionName:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
			end
			f11_arg0.actionName:completeAnimation()
			f11_arg0.actionName:setRGB(0.92, 0.92, 0.92)
			f11_local1(f11_arg0.actionName)
		end,
		LoseFocus = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(2)
			local f14_local0 = function(f15_arg0)
				f14_arg0.Backing:beginAnimation(200)
				f14_arg0.Backing:setAlpha(0)
				f14_arg0.Backing:registerEventHandler("interrupted_keyframe", f14_arg0.clipInterrupted)
				f14_arg0.Backing:registerEventHandler("transition_complete_keyframe", f14_arg0.clipFinished)
			end
			f14_arg0.Backing:completeAnimation()
			f14_arg0.Backing:setAlpha(0.03)
			f14_local0(f14_arg0.Backing)
			local f14_local1 = function(f16_arg0)
				f14_arg0.actionName:beginAnimation(200)
				f14_arg0.actionName:setRGB(0.92, 0.92, 0.92)
				f14_arg0.actionName:registerEventHandler("interrupted_keyframe", f14_arg0.clipInterrupted)
				f14_arg0.actionName:registerEventHandler("transition_complete_keyframe", f14_arg0.clipFinished)
			end
			f14_arg0.actionName:completeAnimation()
			f14_arg0.actionName:setRGB(1, 1, 1)
			f14_local1(f14_arg0.actionName)
		end,
	},
}
CoD.CraftActionButton.__onClose = function(f17_arg0)
	f17_arg0.actionName:close()
end
