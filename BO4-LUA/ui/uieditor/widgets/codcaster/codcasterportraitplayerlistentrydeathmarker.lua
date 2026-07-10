CoD.CodCasterPortraitPlayerListEntryDeathMarker = InheritFrom(LUI.UIElement)
CoD.CodCasterPortraitPlayerListEntryDeathMarker.__defaultWidth = 43
CoD.CodCasterPortraitPlayerListEntryDeathMarker.__defaultHeight = 43
CoD.CodCasterPortraitPlayerListEntryDeathMarker.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CodCasterPortraitPlayerListEntryDeathMarker)
	self.id = "CodCasterPortraitPlayerListEntryDeathMarker"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local PlayerXDead = LUI.UIImage.new(0, 0, 0, 43, 0, 0, 0, 43)
	PlayerXDead:setAlpha(0)
	PlayerXDead:setImage(RegisterImage(0x1B2A931534C28C1))
	self:addElement(PlayerXDead)
	self.PlayerXDead = PlayerXDead
	self:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "health.healthValue", 0)
			end,
		},
	})
	self:linkToElementModel(self, "health.healthValue", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "health.healthValue",
		})
	end)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CodCasterPortraitPlayerListEntryDeathMarker.__resetProperties = function(f4_arg0)
	f4_arg0.PlayerXDead:completeAnimation()
	f4_arg0.PlayerXDead:setAlpha(0)
end
CoD.CodCasterPortraitPlayerListEntryDeathMarker.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(0)
		end,
	},
	Visible = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(1)
			f6_arg0.PlayerXDead:completeAnimation()
			f6_arg0.PlayerXDead:setAlpha(1)
			f6_arg0.clipFinished(f6_arg0.PlayerXDead)
		end,
	},
}
