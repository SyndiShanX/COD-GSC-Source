CoD.CodCasterPortraitPlayerListNumber = InheritFrom(LUI.UIElement)
CoD.CodCasterPortraitPlayerListNumber.__defaultWidth = 18
CoD.CodCasterPortraitPlayerListNumber.__defaultHeight = 25
CoD.CodCasterPortraitPlayerListNumber.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CodCasterPortraitPlayerListNumber)
	self.id = "CodCasterPortraitPlayerListNumber"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Id = LUI.UIText.new(1, 1, -18, 0, 0, 0, 3, 21)
	Id:setText("")
	Id:setTTF("0arame_mono_stencil")
	Id:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	Id:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(Id)
	self.Id = Id
	self:mergeStateConditions({
		{
			stateName = "PlayerDead",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "health.healthValue", 0)
			end,
		},
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return not IsCodCasterProfileValueEqualTo(f1_arg1, "shoutcaster_ds_playernumbers", 1)
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
	local f1_local2 = self
	local f1_local3 = self.subscribeToModel
	local f1_local4 = DataSources.CodCaster.getModel(f1_arg1)
	f1_local3(f1_local2, f1_local4.profileSettingsUpdated, function(f5_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f5_arg0:get(),
			modelName = "profileSettingsUpdated",
		})
	end, false)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CodCasterPortraitPlayerListNumber.__resetProperties = function(f6_arg0)
	f6_arg0.Id:completeAnimation()
	f6_arg0.Id:setTopBottom(0, 0, 3, 21)
	f6_arg0.Id:setAlpha(1)
end
CoD.CodCasterPortraitPlayerListNumber.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			f7_arg0.Id:completeAnimation()
			f7_arg0.Id:setTopBottom(0, 0, 2, 23)
			f7_arg0.clipFinished(f7_arg0.Id)
		end,
	},
	PlayerDead = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(1)
			f8_arg0.Id:completeAnimation()
			f8_arg0.Id:setAlpha(0.03)
			f8_arg0.clipFinished(f8_arg0.Id)
		end,
	},
	Hidden = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(1)
			f9_arg0.Id:completeAnimation()
			f9_arg0.Id:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.Id)
		end,
	},
}
