CoD.RestrictedItemWarning = InheritFrom(LUI.UIElement)
CoD.RestrictedItemWarning.__defaultWidth = 60
CoD.RestrictedItemWarning.__defaultHeight = 50
CoD.RestrictedItemWarning.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.RestrictedItemWarning)
	self.id = "RestrictedItemWarning"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local RestrictedWarning = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	RestrictedWarning:setRGB(0.82, 0.08, 0.17)
	RestrictedWarning:setAlpha(0)
	RestrictedWarning:setImage(RegisterImage(0x2503EE8C658BEE6))
	self:addElement(RestrictedWarning)
	self.RestrictedWarning = RestrictedWarning
	self:mergeStateConditions({
		{
			stateName = "CharacterRestricted",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				local f3_local0
				if not CoD.DirectorUtility.ShowDirectorPregame(f1_arg1) and not IsPublicWZLobby() then
					f3_local0 = CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "isRestricted")
				else
					f3_local0 = false
				end
				return f3_local0
			end,
		},
		{
			stateName = "OneAbilityVisible",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	local f1_local2 = self
	local f1_local3 = self.subscribeToModel
	local f1_local4 = Engine[0x8DF2E5447F384B9]()
	f1_local3(f1_local2, f1_local4["lobbyRoot.lobbyNav"], function(f5_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f5_arg0:get(),
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
CoD.RestrictedItemWarning.__resetProperties = function(f7_arg0)
	f7_arg0.RestrictedWarning:completeAnimation()
	f7_arg0.RestrictedWarning:setLeftRight(0, 1, 0, 0)
	f7_arg0.RestrictedWarning:setTopBottom(0, 1, 0, 0)
	f7_arg0.RestrictedWarning:setRGB(0.82, 0.08, 0.17)
	f7_arg0.RestrictedWarning:setAlpha(0)
end
CoD.RestrictedItemWarning.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(0)
		end,
	},
	CharacterRestricted = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(1)
			f9_arg0.RestrictedWarning:completeAnimation()
			f9_arg0.RestrictedWarning:setAlpha(1)
			f9_arg0.clipFinished(f9_arg0.RestrictedWarning)
		end,
	},
	Visible = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(1)
			f10_arg0.RestrictedWarning:completeAnimation()
			f10_arg0.RestrictedWarning:setRGB(1, 0, 0)
			f10_arg0.RestrictedWarning:setAlpha(1)
			f10_arg0.clipFinished(f10_arg0.RestrictedWarning)
		end,
	},
	OneAbilityVisible = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(1)
			f11_arg0.RestrictedWarning:completeAnimation()
			f11_arg0.RestrictedWarning:setLeftRight(0, 0, -45, -25)
			f11_arg0.RestrictedWarning:setTopBottom(0, 0, 79, 96)
			f11_arg0.RestrictedWarning:setRGB(ColorSet.EnemyOrange_Base.r, ColorSet.EnemyOrange_Base.g, ColorSet.EnemyOrange_Base.b)
			f11_arg0.RestrictedWarning:setAlpha(1)
			f11_arg0.clipFinished(f11_arg0.RestrictedWarning)
		end,
	},
}
