CoD.HUD_ZM_ServerPauseNotification = InheritFrom(LUI.UIElement)
CoD.HUD_ZM_ServerPauseNotification.__defaultWidth = 3840
CoD.HUD_ZM_ServerPauseNotification.__defaultHeight = 1080
CoD.HUD_ZM_ServerPauseNotification.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.HUD_ZM_ServerPauseNotification)
	self.id = "HUD_ZM_ServerPauseNotification"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Backing = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Backing:setRGB(ColorSet.Disabled.r, ColorSet.Disabled.g, ColorSet.Disabled.b)
	Backing:setAlpha(0)
	Backing:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_scene_blur_pass_1"))
	Backing:setShaderVector(0, 3, 0, 0, 0)
	self:addElement(Backing)
	self.Backing = Backing
	local Paused = LUI.UIText.new(0.5, 0.5, -960, 960, 0, 0, 480, 600)
	Paused:setAlpha(0)
	Paused:setText(LocalizeToUpperString(@"menu/paused"))
	Paused:setTTF("ttmussels_demibold")
	Paused:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	Paused:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(Paused)
	self.Paused = Paused
	self:mergeStateConditions({
		{
			stateName = "ServerPaused",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueTrue(f1_arg1, "hudItems.serverPaused")
			end,
		},
	})
	local f1_local3 = self
	local f1_local4 = self.subscribeToModel
	local f1_local5 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local4(f1_local3, f1_local5["hudItems.serverPaused"], function(f3_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f3_arg0:get(),
			modelName = "hudItems.serverPaused",
		})
	end, false)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.HUD_ZM_ServerPauseNotification.__resetProperties = function(f4_arg0)
	f4_arg0.Backing:completeAnimation()
	f4_arg0.Paused:completeAnimation()
	f4_arg0.Backing:setAlpha(0)
	f4_arg0.Paused:setAlpha(0)
end
CoD.HUD_ZM_ServerPauseNotification.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(0)
		end,
	},
	ServerPaused = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(2)
			f6_arg0.Backing:completeAnimation()
			f6_arg0.Backing:setAlpha(0.25)
			f6_arg0.clipFinished(f6_arg0.Backing)
			f6_arg0.Paused:completeAnimation()
			f6_arg0.Paused:setAlpha(1)
			f6_arg0.clipFinished(f6_arg0.Paused)
		end,
	},
}
