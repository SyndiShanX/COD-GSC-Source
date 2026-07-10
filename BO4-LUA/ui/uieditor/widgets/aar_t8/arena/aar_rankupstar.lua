CoD.AAR_RankUpStar = InheritFrom(LUI.UIElement)
CoD.AAR_RankUpStar.__defaultWidth = 65
CoD.AAR_RankUpStar.__defaultHeight = 65
CoD.AAR_RankUpStar.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.AAR_RankUpStar)
	self.id = "AAR_RankUpStar"
	self.soundSet = "none"
	local Star = LUI.UIImage.new(0, 0, 2.5, 62.5, 0, 0, 2.5, 62.5)
	self:addElement(Star)
	self.Star = Star
	self.Star:linkToElementModel(self, "image", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			Star:setImage(RegisterImage(f2_local0))
		end
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.AAR_RankUpStar.__onClose = function(f3_arg0)
	f3_arg0.Star:close()
end
