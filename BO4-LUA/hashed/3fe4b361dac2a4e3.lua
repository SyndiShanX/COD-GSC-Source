CoD.SpawnSelectTeamStatusItem = InheritFrom(LUI.UIElement)
CoD.SpawnSelectTeamStatusItem.__defaultWidth = 50
CoD.SpawnSelectTeamStatusItem.__defaultHeight = 40
CoD.SpawnSelectTeamStatusItem.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.SpawnSelectTeamStatusItem)
	self.id = "SpawnSelectTeamStatusItem"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local backing = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	backing:setRGB(0.49, 0.49, 0.49)
	backing:setImage(RegisterImage(0x8B3E318307FAB35))
	self:addElement(backing)
	self.backing = backing
	local hazardbackplate = LUI.UIImage.new(0, 0, 7.5, 42.5, 0, 0, 8, 32)
	hazardbackplate:setAlpha(0)
	hazardbackplate:setImage(RegisterImage(0x4F22E2837954FCC))
	self:addElement(hazardbackplate)
	self.hazardbackplate = hazardbackplate
	local Headshot = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Headshot:linkToElementModel(self, "characterIndex", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			Headshot:setImage(RegisterImage(GetPositionDraftIconByIndex(f2_local0)))
		end
	end)
	self:addElement(Headshot)
	self.Headshot = Headshot
	local toptrim = LUI.UIImage.new(0, 0, 0, 50, 0, 0, 0, 1)
	toptrim:setRGB(0.18, 0.18, 0.18)
	self:addElement(toptrim)
	self.toptrim = toptrim
	local bottomtrim = LUI.UIImage.new(0, 0, 0, 50, 0, 0, 39, 40)
	bottomtrim:setRGB(0.18, 0.18, 0.18)
	self:addElement(bottomtrim)
	self.bottomtrim = bottomtrim
	local lefttrim = LUI.UIImage.new(0, 0, -19, 20, 0, 0, 20, 21)
	lefttrim:setRGB(0.18, 0.18, 0.18)
	lefttrim:setZRot(90)
	self:addElement(lefttrim)
	self.lefttrim = lefttrim
	local righttrim = LUI.UIImage.new(0, 0, 30, 69, 0, 0, 20, 21)
	righttrim:setRGB(0.18, 0.18, 0.18)
	righttrim:setZRot(90)
	self:addElement(righttrim)
	self.righttrim = righttrim
	self:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return IsSelfClient(f1_arg1, element)
			end,
		},
		{
			stateName = "Dead",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "dead")
			end,
		},
	})
	self:linkToElementModel(self, "clientNum", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "clientNum",
		})
	end)
	self:linkToElementModel(self, "dead", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "dead",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.SpawnSelectTeamStatusItem.__resetProperties = function(f7_arg0)
	f7_arg0.Headshot:completeAnimation()
	f7_arg0.hazardbackplate:completeAnimation()
	f7_arg0.toptrim:completeAnimation()
	f7_arg0.backing:completeAnimation()
	f7_arg0.bottomtrim:completeAnimation()
	f7_arg0.lefttrim:completeAnimation()
	f7_arg0.righttrim:completeAnimation()
	f7_arg0.Headshot:setRGB(1, 1, 1)
	f7_arg0.Headshot:setAlpha(1)
	f7_arg0.hazardbackplate:setLeftRight(0, 0, 7.5, 42.5)
	f7_arg0.hazardbackplate:setTopBottom(0, 0, 8, 32)
	f7_arg0.hazardbackplate:setRGB(1, 1, 1)
	f7_arg0.hazardbackplate:setAlpha(0)
	f7_arg0.hazardbackplate:setMaterial(LUI.UIImage.GetCachedMaterial(0x6B34AA3F39208EF))
	f7_arg0.toptrim:setRGB(0.18, 0.18, 0.18)
	f7_arg0.toptrim:setAlpha(1)
	f7_arg0.backing:setRGB(0.49, 0.49, 0.49)
	f7_arg0.backing:setAlpha(1)
	f7_arg0.bottomtrim:setRGB(0.18, 0.18, 0.18)
	f7_arg0.bottomtrim:setAlpha(1)
	f7_arg0.lefttrim:setRGB(0.18, 0.18, 0.18)
	f7_arg0.lefttrim:setAlpha(1)
	f7_arg0.righttrim:setRGB(0.18, 0.18, 0.18)
	f7_arg0.righttrim:setAlpha(1)
end
CoD.SpawnSelectTeamStatusItem.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(2)
			f8_arg0.hazardbackplate:completeAnimation()
			f8_arg0.hazardbackplate:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.hazardbackplate)
			f8_arg0.Headshot:completeAnimation()
			f8_arg0.Headshot:setRGB(1, 1, 1)
			f8_arg0.clipFinished(f8_arg0.Headshot)
		end,
	},
	Hidden = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(7)
			f9_arg0.backing:completeAnimation()
			f9_arg0.backing:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.backing)
			f9_arg0.hazardbackplate:completeAnimation()
			f9_arg0.hazardbackplate:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.hazardbackplate)
			f9_arg0.Headshot:completeAnimation()
			f9_arg0.Headshot:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.Headshot)
			f9_arg0.toptrim:completeAnimation()
			f9_arg0.toptrim:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.toptrim)
			f9_arg0.bottomtrim:completeAnimation()
			f9_arg0.bottomtrim:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.bottomtrim)
			f9_arg0.lefttrim:completeAnimation()
			f9_arg0.lefttrim:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.lefttrim)
			f9_arg0.righttrim:completeAnimation()
			f9_arg0.righttrim:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.righttrim)
		end,
	},
	Dead = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(7)
			f10_arg0.backing:completeAnimation()
			f10_arg0.backing:setRGB(0.94, 0.05, 0.05)
			f10_arg0.clipFinished(f10_arg0.backing)
			f10_arg0.hazardbackplate:completeAnimation()
			f10_arg0.hazardbackplate:setLeftRight(0, 0, 0.5, 49.5)
			f10_arg0.hazardbackplate:setTopBottom(0, 0, 0, 40)
			f10_arg0.hazardbackplate:setRGB(0.79, 0.79, 0.79)
			f10_arg0.hazardbackplate:setAlpha(1)
			f10_arg0.hazardbackplate:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
			f10_arg0.clipFinished(f10_arg0.hazardbackplate)
			f10_arg0.Headshot:completeAnimation()
			f10_arg0.Headshot:setRGB(0.61, 0.19, 0.19)
			f10_arg0.Headshot:setAlpha(1)
			f10_arg0.clipFinished(f10_arg0.Headshot)
			f10_arg0.toptrim:completeAnimation()
			f10_arg0.toptrim:setRGB(0.47, 0.01, 0.01)
			f10_arg0.clipFinished(f10_arg0.toptrim)
			f10_arg0.bottomtrim:completeAnimation()
			f10_arg0.bottomtrim:setRGB(0.47, 0.01, 0.01)
			f10_arg0.clipFinished(f10_arg0.bottomtrim)
			f10_arg0.lefttrim:completeAnimation()
			f10_arg0.lefttrim:setRGB(0.47, 0.01, 0.01)
			f10_arg0.clipFinished(f10_arg0.lefttrim)
			f10_arg0.righttrim:completeAnimation()
			f10_arg0.righttrim:setRGB(0.47, 0.01, 0.01)
			f10_arg0.clipFinished(f10_arg0.righttrim)
		end,
	},
}
CoD.SpawnSelectTeamStatusItem.__onClose = function(f11_arg0)
	f11_arg0.Headshot:close()
end
