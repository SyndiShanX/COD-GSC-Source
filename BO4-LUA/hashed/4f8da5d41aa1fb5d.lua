CoD.PositionDraft_CasterControls = InheritFrom(LUI.UIElement)
CoD.PositionDraft_CasterControls.__defaultWidth = 361
CoD.PositionDraft_CasterControls.__defaultHeight = 38
CoD.PositionDraft_CasterControls.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PositionDraft_CasterControls)
	self.id = "PositionDraft_CasterControls"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Background = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Background:setRGB(0, 0, 0)
	Background:setAlpha(0.4)
	self:addElement(Background)
	self.Background = Background
	local LBButton = LUI.UIImage.new(0, 0.15, 0, 0, 0, 1, 0, 0)
	LBButton:subscribeToGlobalModel(f1_arg1, "Controller", "left_shoulder_button_image", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			LBButton:setImage(RegisterImage(f2_local0))
		end
	end)
	self:addElement(LBButton)
	self.LBButton = LBButton
	local RBButton = LUI.UIImage.new(0.85, 1, 0, 0, 0, 1, 0, 0)
	RBButton:subscribeToGlobalModel(f1_arg1, "Controller", "right_shoulder_button_image", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			RBButton:setImage(RegisterImage(f3_local0))
		end
	end)
	self:addElement(RBButton)
	self.RBButton = RBButton
	local Text = LUI.UIText.new(0.15, 0.85, 0, 0, 0.01, 0.98, 0, 0)
	Text:setText(Engine[@"hash_4F9F1239CFD921FE"](@"menu/spectate_team"))
	Text:setTTF("default")
	Text:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	Text:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(Text)
	self.Text = Text
	local rightButton = nil
	rightButton = LUI.UIImage.new(0.5, 0.5, 134.5, 172.5, 0.5, 0.5, -22, 18)
	rightButton:setAlpha(0)
	rightButton:subscribeToGlobalModel(f1_arg1, "Controller", "mouse_right_button_image", function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			rightButton:setImage(RegisterImage(f4_local0))
		end
	end)
	self:addElement(rightButton)
	self.rightButton = rightButton
	local leftButton = nil
	leftButton = LUI.UIImage.new(0.5, 0.5, -172.5, -134.5, 0.5, 0.5, -22, 18)
	leftButton:setAlpha(0)
	leftButton:subscribeToGlobalModel(f1_arg1, "Controller", "mouse_left_button_image", function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			leftButton:setImage(RegisterImage(f5_local0))
		end
	end)
	self:addElement(leftButton)
	self.leftButton = leftButton
	self:mergeStateConditions({
		{
			stateName = "CodCasterPC",
			condition = function(menu, element, event)
				local f6_local0 = IsCodCaster(f1_arg1)
				if f6_local0 then
					f6_local0 = IsPC()
					if f6_local0 then
						f6_local0 = IsMouseOrKeyboard(f1_arg1)
					end
				end
				return f6_local0
			end,
		},
		{
			stateName = "CodCaster",
			condition = function(menu, element, event)
				return IsCodCaster(f1_arg1)
			end,
		},
	})
	local f1_local7 = self
	local f1_local8 = self.subscribeToModel
	local f1_local9 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local8(f1_local7, f1_local9["factions.isCoDCaster"], function(f8_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f8_arg0:get(),
			modelName = "factions.isCoDCaster",
		})
	end, false)
	self:appendEventHandler("input_source_changed", function(f9_arg0, f9_arg1)
		f9_arg1.menu = f9_arg1.menu or f1_arg0
		f1_arg0:updateElementState(self, f9_arg1)
	end)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local8(f1_local7, f1_local9.LastInput, function(f10_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f10_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.PositionDraft_CasterControls.__resetProperties = function(f11_arg0)
	f11_arg0.Background:completeAnimation()
	f11_arg0.LBButton:completeAnimation()
	f11_arg0.RBButton:completeAnimation()
	f11_arg0.Text:completeAnimation()
	f11_arg0.rightButton:completeAnimation()
	f11_arg0.leftButton:completeAnimation()
	f11_arg0.Background:setAlpha(0.4)
	f11_arg0.LBButton:setAlpha(1)
	f11_arg0.RBButton:setLeftRight(0.85, 1, 0, 0)
	f11_arg0.RBButton:setTopBottom(0, 1, 0, 0)
	f11_arg0.RBButton:setAlpha(1)
	f11_arg0.Text:setAlpha(1)
	f11_arg0.rightButton:setLeftRight(0.5, 0.5, 134.5, 172.5)
	f11_arg0.rightButton:setTopBottom(0.5, 0.5, -22, 18)
	f11_arg0.rightButton:setAlpha(0)
	f11_arg0.leftButton:setLeftRight(0.5, 0.5, -172.5, -134.5)
	f11_arg0.leftButton:setTopBottom(0.5, 0.5, -22, 18)
	f11_arg0.leftButton:setAlpha(0)
end
CoD.PositionDraft_CasterControls.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(6)
			f12_arg0.Background:completeAnimation()
			f12_arg0.Background:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.Background)
			f12_arg0.LBButton:completeAnimation()
			f12_arg0.LBButton:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.LBButton)
			f12_arg0.RBButton:completeAnimation()
			f12_arg0.RBButton:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.RBButton)
			f12_arg0.Text:completeAnimation()
			f12_arg0.Text:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.Text)
			f12_arg0.rightButton:completeAnimation()
			f12_arg0.rightButton:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.rightButton)
			f12_arg0.leftButton:completeAnimation()
			f12_arg0.leftButton:setLeftRight(0.5, 0.5, -172.5, -134.5)
			f12_arg0.leftButton:setTopBottom(0.5, 0.5, -22, 18)
			f12_arg0.leftButton:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.leftButton)
		end,
	},
	CodCasterPC = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(4)
			f13_arg0.LBButton:completeAnimation()
			f13_arg0.LBButton:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.LBButton)
			f13_arg0.RBButton:completeAnimation()
			f13_arg0.RBButton:setLeftRight(0.85, 1, 0, 0)
			f13_arg0.RBButton:setTopBottom(0, 1, 0, 0)
			f13_arg0.RBButton:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.RBButton)
			f13_arg0.rightButton:completeAnimation()
			f13_arg0.rightButton:setLeftRight(0.5, 0.5, 134.5, 172.5)
			f13_arg0.rightButton:setTopBottom(0.5, 0.5, -22, 18)
			f13_arg0.rightButton:setAlpha(1)
			f13_arg0.clipFinished(f13_arg0.rightButton)
			f13_arg0.leftButton:completeAnimation()
			f13_arg0.leftButton:setAlpha(1)
			f13_arg0.clipFinished(f13_arg0.leftButton)
		end,
	},
	CodCaster = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(6)
			f14_arg0.Background:completeAnimation()
			f14_arg0.Background:setAlpha(0.4)
			f14_arg0.clipFinished(f14_arg0.Background)
			f14_arg0.LBButton:completeAnimation()
			f14_arg0.LBButton:setAlpha(1)
			f14_arg0.clipFinished(f14_arg0.LBButton)
			f14_arg0.RBButton:completeAnimation()
			f14_arg0.RBButton:setAlpha(1)
			f14_arg0.clipFinished(f14_arg0.RBButton)
			f14_arg0.Text:completeAnimation()
			f14_arg0.Text:setAlpha(1)
			f14_arg0.clipFinished(f14_arg0.Text)
			f14_arg0.rightButton:completeAnimation()
			f14_arg0.rightButton:setLeftRight(0.5, 0.5, 134.5, 172.5)
			f14_arg0.rightButton:setTopBottom(0.5, 0.5, -22, 18)
			f14_arg0.rightButton:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.rightButton)
			f14_arg0.leftButton:completeAnimation()
			f14_arg0.leftButton:setLeftRight(0.5, 0.5, -172.5, -134.5)
			f14_arg0.leftButton:setTopBottom(0.5, 0.5, -22, 18)
			f14_arg0.leftButton:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.leftButton)
		end,
	},
}
CoD.PositionDraft_CasterControls.__onClose = function(f15_arg0)
	f15_arg0.LBButton:close()
	f15_arg0.RBButton:close()
	f15_arg0.rightButton:close()
	f15_arg0.leftButton:close()
end
