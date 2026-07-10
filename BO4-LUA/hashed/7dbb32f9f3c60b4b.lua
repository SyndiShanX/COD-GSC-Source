require("x64:a1894b7b8146455")
require("x64:a3cd2c05bf5a4e0")
CoD.SpecialistInfoCTOverallProgress = InheritFrom(LUI.UIElement)
CoD.SpecialistInfoCTOverallProgress.__defaultWidth = 487
CoD.SpecialistInfoCTOverallProgress.__defaultHeight = 290
CoD.SpecialistInfoCTOverallProgress.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.SpecialistInfoCTOverallProgress)
	self.id = "SpecialistInfoCTOverallProgress"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	local RightProgress = CoD.SpecialistInfoCTProgress.new(f1_arg0, f1_arg1, 0.5, 0.5, 112.5, 187.5, 0, 0, 54, 154)
	RightProgress:linkToElementModel(self, "veteranStars", false, function(model)
		RightProgress:setModel(model, f1_arg1)
	end)
	self:addElement(RightProgress)
	self.RightProgress = RightProgress
	local MiddleProgress = CoD.SpecialistInfoCTProgress.new(f1_arg0, f1_arg1, 0.5, 0.5, -37.5, 37.5, 0, 0, 54, 154)
	MiddleProgress:linkToElementModel(self, "regularStars", false, function(model)
		MiddleProgress:setModel(model, f1_arg1)
	end)
	self:addElement(MiddleProgress)
	self.MiddleProgress = MiddleProgress
	local LeftProgress = CoD.SpecialistInfoCTProgress.new(f1_arg0, f1_arg1, 0.5, 0.5, -187.5, -112.5, 0, 0, 54, 154)
	LeftProgress:linkToElementModel(self, "recruitStars", false, function(model)
		LeftProgress:setModel(model, f1_arg1)
	end)
	self:addElement(LeftProgress)
	self.LeftProgress = LeftProgress
	local Header = LUI.UIText.new(0, 1, 0, 0, 0, 0, 0, 24)
	Header:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	Header:setText(LocalizeToUpperString(@"hash_51F548D4609D9566"))
	Header:setTTF("ttmussels_regular")
	Header:setLetterSpacing(5)
	Header:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	self:addElement(Header)
	self.Header = Header
	local DiffDesc = LUI.UIText.new(0, 1, 0, 0, 0, 0, 31, 49)
	DiffDesc:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	DiffDesc:setAlpha(0.5)
	DiffDesc:setTTF("ttmussels_regular")
	DiffDesc:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	DiffDesc:linkToElementModel(self, "difficulty", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			DiffDesc:setText(Engine[@"hash_4F9F1239CFD921FE"](CoD.CTUtility.CTDifficultyToDesc(f5_local0)))
		end
	end)
	self:addElement(DiffDesc)
	self.DiffDesc = DiffDesc
	local MapImage = CoD.CombatTrainingSkirmishPreview.new(f1_arg0, f1_arg1, 0.5, 0.5, -244, 244, 1, 1, -130, 0)
	MapImage:linkToElementModel(self, nil, false, function(model)
		MapImage:setModel(model, f1_arg1)
	end)
	self:addElement(MapImage)
	self.MapImage = MapImage
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.SpecialistInfoCTOverallProgress.__onClose = function(f7_arg0)
	f7_arg0.RightProgress:close()
	f7_arg0.MiddleProgress:close()
	f7_arg0.LeftProgress:close()
	f7_arg0.DiffDesc:close()
	f7_arg0.MapImage:close()
end
