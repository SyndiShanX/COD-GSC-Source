require("x64:7ff987c19dcb981")
CoD.CombatTrainingSkirmishPreview = InheritFrom(LUI.UIElement)
CoD.CombatTrainingSkirmishPreview.__defaultWidth = 487
CoD.CombatTrainingSkirmishPreview.__defaultHeight = 130
CoD.CombatTrainingSkirmishPreview.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CombatTrainingSkirmishPreview)
	self.id = "CombatTrainingSkirmishPreview"
	self.soundSet = "default"
	local MapImage = LUI.UIImage.new(0.5, 0.5, -243.5, 243.5, 1, 1, -130, 0)
	MapImage:linkToElementModel(self, "map", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			MapImage:setImage(RegisterImage(CoD.MapUtility.MapNameToMapImage(f2_local0)))
		end
	end)
	self:addElement(MapImage)
	self.MapImage = MapImage
	local GametypeImage = LUI.UIImage.new(1, 1, -150, 0, 1, 1, -130, 20)
	GametypeImage:linkToElementModel(self, "gametype", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			GametypeImage:setImage(RegisterImage(GameTypeToImage(f3_local0)))
		end
	end)
	self:addElement(GametypeImage)
	self.GametypeImage = GametypeImage
	local NamesBacking = CoD.CombatTrainingSkirmishNames.new(f1_arg0, f1_arg1, 0, 0, 0, 234, 1, 1, -93, 0)
	NamesBacking:linkToElementModel(self, nil, false, function(model)
		NamesBacking:setModel(model, f1_arg1)
	end)
	self:addElement(NamesBacking)
	self.NamesBacking = NamesBacking
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CombatTrainingSkirmishPreview.__onClose = function(f5_arg0)
	f5_arg0.MapImage:close()
	f5_arg0.GametypeImage:close()
	f5_arg0.NamesBacking:close()
end
