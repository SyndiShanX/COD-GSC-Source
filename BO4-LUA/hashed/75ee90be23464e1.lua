CoD.SpecialistHeadquartersSpecialistComplete = InheritFrom(LUI.UIElement)
CoD.SpecialistHeadquartersSpecialistComplete.__defaultWidth = 148
CoD.SpecialistHeadquartersSpecialistComplete.__defaultHeight = 24
CoD.SpecialistHeadquartersSpecialistComplete.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.SpecialistHeadquartersSpecialistComplete)
	self.id = "SpecialistHeadquartersSpecialistComplete"
	self.soundSet = "default"
	local Backing = LUI.UIImage.new(0.5, 0.5, -74, 74, 0.5, 0.5, -12, 12)
	Backing:setRGB(0.5, 0.5, 0.5)
	Backing:setAlpha(0.1)
	self:addElement(Backing)
	self.Backing = Backing
	local MiddleStar = LUI.UIImage.new(0.5, 0.5, -12, 12, 0.5, 0.5, -12, 12)
	MiddleStar:linkToElementModel(self, "regularStars.starImage", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			MiddleStar:setImage(RegisterImage(f2_local0))
		end
	end)
	self:addElement(MiddleStar)
	self.MiddleStar = MiddleStar
	local RightStar = LUI.UIImage.new(0.5, 0.5, 31, 55, 0.5, 0.5, -12, 12)
	RightStar:linkToElementModel(self, "veteranStars.starImage", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			RightStar:setImage(RegisterImage(f3_local0))
		end
	end)
	self:addElement(RightStar)
	self.RightStar = RightStar
	local LeftStar = LUI.UIImage.new(0.5, 0.5, -55, -31, 0.5, 0.5, -12, 12)
	LeftStar:linkToElementModel(self, "recruitStars.starImage", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			LeftStar:setImage(RegisterImage(f4_local0))
		end
	end)
	self:addElement(LeftStar)
	self.LeftStar = LeftStar
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.SpecialistHeadquartersSpecialistComplete.__onClose = function(f5_arg0)
	f5_arg0.MiddleStar:close()
	f5_arg0.RightStar:close()
	f5_arg0.LeftStar:close()
end
