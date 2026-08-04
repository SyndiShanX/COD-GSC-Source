CoD.RestrictedItemWarningBar = InheritFrom(LUI.UIElement)
CoD.RestrictedItemWarningBar.__defaultWidth = 220
CoD.RestrictedItemWarningBar.__defaultHeight = 22
CoD.RestrictedItemWarningBar.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.RestrictedItemWarningBar)
	self.id = "RestrictedItemWarningBar"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local RestrictedBar = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	RestrictedBar:setRGB(0.98, 0.13, 0.23)
	RestrictedBar:setAlpha(0)
	RestrictedBar:setImage(RegisterImage("uie_ui_menu_common_tab_restriction_warning"))
	RestrictedBar:setMaterial(LUI.UIImage.GetCachedMaterial("uie_feather_edges"))
	RestrictedBar:setShaderVector(0, 0.4, 0.05, 0.4, 0.05)
	self:addElement(RestrictedBar)
	self.RestrictedBar = RestrictedBar
	local RestrictedWarning = LUI.UIImage.new(0.5, 0.5, -16, 16, 0.5, 0.5, -11, 14)
	RestrictedWarning:setRGB(0.82, 0.08, 0.16)
	RestrictedWarning:setAlpha(0)
	RestrictedWarning:setImage(RegisterImage("uie_t8_icon_restriction_warning"))
	self:addElement(RestrictedWarning)
	self.RestrictedWarning = RestrictedWarning
	self:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				local f2_local0
				if not CoD.DirectorUtility.ShowDirectorPregame(f1_arg1) and not IsPublicWZLobby() then
					f2_local0 = CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "isRestricted")
				else
					f2_local0 = false
				end
				return f2_local0
			end,
		},
	})
	local f1_local3 = self
	local f1_local4 = self.subscribeToModel
	local f1_local5 = Engine.GetGlobalModel()
	f1_local4(f1_local3, f1_local5["lobbyRoot.lobbyNav"], function(f3_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f3_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	self:linkToElementModel(self, "isRestricted", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "isRestricted",
		})
	end)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.RestrictedItemWarningBar.__resetProperties = function(f5_arg0)
	f5_arg0.RestrictedBar:completeAnimation()
	f5_arg0.RestrictedWarning:completeAnimation()
	f5_arg0.RestrictedBar:setAlpha(0)
	f5_arg0.RestrictedWarning:setAlpha(0)
end
CoD.RestrictedItemWarningBar.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(0)
		end,
	},
	Visible = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(2)
			f7_arg0.RestrictedBar:completeAnimation()
			f7_arg0.RestrictedBar:setAlpha(1)
			f7_arg0.clipFinished(f7_arg0.RestrictedBar)
			f7_arg0.RestrictedWarning:completeAnimation()
			f7_arg0.RestrictedWarning:setAlpha(1)
			f7_arg0.clipFinished(f7_arg0.RestrictedWarning)
		end,
	},
}
