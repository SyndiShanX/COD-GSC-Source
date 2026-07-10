require("x64:e48ccd31f36318d")
require("x64:dfa7abc470d2678")
CoD.ObituaryCalloutContainer = InheritFrom(LUI.UIElement)
CoD.ObituaryCalloutContainer.__defaultWidth = 280
CoD.ObituaryCalloutContainer.__defaultHeight = 30
CoD.ObituaryCalloutContainer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setUseCylinderMapping(false)
	self:setClass(CoD.ObituaryCalloutContainer)
	self.id = "ObituaryCalloutContainer"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ContribText2 = CoD.ObituaryCalloutContainerPlayerKilled.new(f1_arg0, f1_arg1, 0.5, 0.5, -275, 275, 0, 0, 0, 26)
	ContribText2:linkToElementModel(self, nil, false, function(model)
		ContribText2:setModel(model, f1_arg1)
	end)
	self:addElement(ContribText2)
	self.ContribText2 = ContribText2
	local ContribText = CoD.ObituaryCalloutContainerDamageDealt.new(f1_arg0, f1_arg1, 0.5, 0.5, -110.5, 110.5, 0.5, 0.5, 15, 41)
	ContribText:linkToElementModel(self, nil, false, function(model)
		ContribText:setModel(model, f1_arg1)
	end)
	self:addElement(ContribText)
	self.ContribText = ContribText
	self:mergeStateConditions({
		{
			stateName = "PC",
			condition = function(menu, element, event)
				return IsPC()
			end,
		},
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ObituaryCalloutContainer.__resetProperties = function(f5_arg0)
	f5_arg0.ContribText:completeAnimation()
	f5_arg0.ContribText2:completeAnimation()
	f5_arg0.ContribText:setTopBottom(0.5, 0.5, 15, 41)
	f5_arg0.ContribText2:setTopBottom(0, 0, 0, 26)
end
CoD.ObituaryCalloutContainer.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(0)
		end,
	},
	PC = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(2)
			f7_arg0.ContribText2:completeAnimation()
			f7_arg0.ContribText2:setTopBottom(0, 0, -21, 5)
			f7_arg0.clipFinished(f7_arg0.ContribText2)
			f7_arg0.ContribText:completeAnimation()
			f7_arg0.ContribText:setTopBottom(0.5, 0.5, -6, 20)
			f7_arg0.clipFinished(f7_arg0.ContribText)
		end,
	},
}
CoD.ObituaryCalloutContainer.__onClose = function(f8_arg0)
	f8_arg0.ContribText2:close()
	f8_arg0.ContribText:close()
end
