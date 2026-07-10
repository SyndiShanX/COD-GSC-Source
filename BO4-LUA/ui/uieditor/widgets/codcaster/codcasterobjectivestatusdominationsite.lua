CoD.CodCasterObjectiveStatusDominationSite = InheritFrom(LUI.UIElement)
CoD.CodCasterObjectiveStatusDominationSite.__defaultWidth = 60
CoD.CodCasterObjectiveStatusDominationSite.__defaultHeight = 60
CoD.CodCasterObjectiveStatusDominationSite.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CodCasterObjectiveStatusDominationSite)
	self.id = "CodCasterObjectiveStatusDominationSite"
	self.soundSet = "none"
	local siteBackground = LUI.UIImage.new(0, 0, 0, 60, 0, 0, 0, 60)
	siteBackground:setScale(0.5, 0.5)
	siteBackground:setImage(RegisterImage(0x159D9B7B7294C91))
	self:addElement(siteBackground)
	self.siteBackground = siteBackground
	local siteLetter = LUI.UIImage.new(0, 0, 0, 60, 0, 0, 0, 60)
	siteLetter:setScale(0.5, 0.5)
	siteLetter:setImage(RegisterImage(0x1859ED472AB4E4F))
	self:addElement(siteLetter)
	self.siteLetter = siteLetter
	local siteBackground2 = LUI.UIImage.new(0, 0, 0, 60, 0, 0, 0, 60)
	siteBackground2:setScale(0.5, 0.5)
	siteBackground2:setImage(RegisterImage(0x2E4DBA41E983343))
	self:addElement(siteBackground2)
	self.siteBackground2 = siteBackground2
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
