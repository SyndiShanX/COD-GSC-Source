require("x64:ffbba8158c738c9")
require("x64:c3fa19037d61cad")
CoD.SpecialistHeadquartersSpecialist = InheritFrom(LUI.UIElement)
CoD.SpecialistHeadquartersSpecialist.__defaultWidth = 152
CoD.SpecialistHeadquartersSpecialist.__defaultHeight = 173
CoD.SpecialistHeadquartersSpecialist.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.SpecialistHeadquartersSpecialist)
	self.id = "SpecialistHeadquartersSpecialist"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local HubSpecialistcharacter = CoD.HubSpecialist_character.new(f1_arg0, f1_arg1, 0, 0, 0, 152, 0, 0, 0, 173)
	HubSpecialistcharacter:linkToElementModel(self, nil, false, function(model)
		HubSpecialistcharacter:setModel(model, f1_arg1)
	end)
	self:addElement(HubSpecialistcharacter)
	self.HubSpecialistcharacter = HubSpecialistcharacter
	local Complete = CoD.SpecialistHeadquartersSpecialistComplete.new(f1_arg0, f1_arg1, 0.5, 0.5, -74, 74, 0, 0, 171, 195)
	Complete:setScale(0.8, 0.8)
	Complete.Backing:setAlpha(0)
	Complete:linkToElementModel(self, nil, false, function(model)
		Complete:setModel(model, f1_arg1)
	end)
	self:addElement(Complete)
	self.Complete = Complete
	local EquippedMarkerBG = LUI.UIImage.new(0, 0, 113, 157, 0, 0, 24, 68)
	EquippedMarkerBG:setAlpha(0)
	EquippedMarkerBG:setZoom(4)
	EquippedMarkerBG:setImage(RegisterImage(0x7AF532D84DE505A))
	EquippedMarkerBG:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(EquippedMarkerBG)
	self.EquippedMarkerBG = EquippedMarkerBG
	local EquippedMarkerTick = LUI.UIImage.new(0, 0, 113, 157, 0, 0, 24, 68)
	EquippedMarkerTick:setAlpha(0)
	EquippedMarkerTick:setZoom(4)
	EquippedMarkerTick:setImage(RegisterImage(0x9A8B26C9B001758))
	self:addElement(EquippedMarkerTick)
	self.EquippedMarkerTick = EquippedMarkerTick
	self:mergeStateConditions({
		{
			stateName = "Selected",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalDataSourceModelValueEqualToSelfModelValue(self, f1_arg1, "SpecialistHeadquarters", "ChosenSpecialistID", "characterIndex")
			end,
		},
	})
	local f1_local5 = self
	local f1_local6 = self.subscribeToModel
	local f1_local7 = DataSources.SpecialistHeadquarters.getModel(f1_arg1)
	f1_local6(f1_local5, f1_local7.ChosenSpecialistID, function(f5_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f5_arg0:get(),
			modelName = "ChosenSpecialistID",
		})
	end, false)
	self:linkToElementModel(self, "characterIndex", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "characterIndex",
		})
	end)
	HubSpecialistcharacter.id = "HubSpecialistcharacter"
	self.__defaultFocus = HubSpecialistcharacter
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.SpecialistHeadquartersSpecialist.__resetProperties = function(f7_arg0)
	f7_arg0.EquippedMarkerBG:completeAnimation()
	f7_arg0.EquippedMarkerTick:completeAnimation()
	f7_arg0.EquippedMarkerBG:setAlpha(0)
	f7_arg0.EquippedMarkerTick:setAlpha(0)
end
CoD.SpecialistHeadquartersSpecialist.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(0)
		end,
	},
	Selected = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(2)
			f9_arg0.EquippedMarkerBG:completeAnimation()
			f9_arg0.EquippedMarkerBG:setAlpha(1)
			f9_arg0.clipFinished(f9_arg0.EquippedMarkerBG)
			f9_arg0.EquippedMarkerTick:completeAnimation()
			f9_arg0.EquippedMarkerTick:setAlpha(1)
			f9_arg0.clipFinished(f9_arg0.EquippedMarkerTick)
		end,
	},
}
CoD.SpecialistHeadquartersSpecialist.__onClose = function(f10_arg0)
	f10_arg0.HubSpecialistcharacter:close()
	f10_arg0.Complete:close()
end
