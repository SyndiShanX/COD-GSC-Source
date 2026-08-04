CoD.ZMDoubleNPWidget = InheritFrom(LUI.UIElement)
CoD.ZMDoubleNPWidget.__defaultWidth = 90
CoD.ZMDoubleNPWidget.__defaultHeight = 90
CoD.ZMDoubleNPWidget.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ZMDoubleNPWidget)
	self.id = "ZMDoubleNPWidget"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Image = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Image:setImage(RegisterImage("ui_icon_nebulium_2x"))
	self:addElement(Image)
	self.Image = Image
	self:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				local f2_local0 = CoD.ZombieUtility.IsDoubleNP(f1_arg1)
				if f2_local0 then
					f2_local0 = IsLobbyNetworkModeLive()
					if f2_local0 then
						f2_local0 = IsZombies()
					end
				end
				return f2_local0
			end,
		},
	})
	local f1_local2 = self
	local f1_local3 = self.subscribeToModel
	local f1_local4 = DataSources.AutoEvents.getModel(f1_arg1)
	f1_local3(f1_local2, f1_local4.cycled, function(f3_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f3_arg0:get(),
			modelName = "cycled",
		})
	end, false)
	f1_local2 = self
	f1_local3 = self.subscribeToModel
	f1_local4 = Engine.GetGlobalModel()
	f1_local3(f1_local2, f1_local4["lobbyRoot.lobbyNav"], function(f4_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f4_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(self, "setState", function(element, controller, f5_arg2, f5_arg3, f5_arg4)
		if not IsSelfInState(self, "Visible") then
			HideWidget(self)
		else
			ShowWidget(self)
		end
	end)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ZMDoubleNPWidget.__resetProperties = function(f6_arg0)
	f6_arg0.Image:completeAnimation()
	f6_arg0.Image:setAlpha(1)
end
CoD.ZMDoubleNPWidget.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			f7_arg0.Image:completeAnimation()
			f7_arg0.Image:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.Image)
		end,
	},
	Visible = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(1)
			f8_arg0.Image:completeAnimation()
			f8_arg0.Image:setAlpha(1)
			f8_arg0.clipFinished(f8_arg0.Image)
		end,
	},
}
