CoD.codcaster_ScoreLogoWidget = InheritFrom(LUI.UIElement)
CoD.codcaster_ScoreLogoWidget.__defaultWidth = 315
CoD.codcaster_ScoreLogoWidget.__defaultHeight = 100
CoD.codcaster_ScoreLogoWidget.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.codcaster_ScoreLogoWidget)
	self.id = "codcaster_ScoreLogoWidget"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local teamcolor = LUI.UIImage.new(0.5, 0.5, -157.5, 157.5, 0, 0, 0, 98)
	teamcolor:setImage(RegisterImage(0x23D16DB74116F90))
	self:addElement(teamcolor)
	self.teamcolor = teamcolor
	local logobacking = LUI.UIImage.new(0, 0, 107, 273, 0, 0, 3, 101)
	logobacking:setImage(RegisterImage(0x2AC54E7868409F8))
	self:addElement(logobacking)
	self.logobacking = logobacking
	local emblem = LUI.UIImage.new(0, 0, 138, 256, 0, 0, 8, 95)
	self:addElement(emblem)
	self.emblem = emblem
	local logo = LUI.UIImage.new(0, 0, 112, 271, 0, 0, 7, 95)
	self:addElement(logo)
	self.logo = logo
	local logotopRight = LUI.UIImage.new(0, 0, 108, 280, 0, 0, 3, 101)
	logotopRight:setImage(RegisterImage(0x91669C6409EFB66))
	self:addElement(logotopRight)
	self.logotopRight = logotopRight
	local numberbacking = LUI.UIImage.new(0, 0, 2, 138, 0, 0, 2, 101)
	numberbacking:setImage(RegisterImage(0x6CDBC64E321582))
	self:addElement(numberbacking)
	self.numberbacking = numberbacking
	local teamiconbg = LUI.UIImage.new(0.5, 0.5, 90, 126, 0, 0, 2, 100)
	teamiconbg:setImage(RegisterImage(0x5840333C83A0F2C))
	self:addElement(teamiconbg)
	self.teamiconbg = teamiconbg
	self:mergeStateConditions({
		{
			stateName = "NonTeamBased",
			condition = function(menu, element, event)
				return not IsGametypeTeambased()
			end,
		},
	})
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.codcaster_ScoreLogoWidget.__resetProperties = function(f3_arg0)
	f3_arg0.emblem:completeAnimation()
	f3_arg0.logo:completeAnimation()
	f3_arg0.emblem:setAlpha(1)
	f3_arg0.logo:setAlpha(1)
end
CoD.codcaster_ScoreLogoWidget.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(1)
			f4_arg0.emblem:completeAnimation()
			f4_arg0.emblem:setAlpha(0)
			f4_arg0.clipFinished(f4_arg0.emblem)
		end,
	},
	NonTeamBased = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			f5_arg0.logo:completeAnimation()
			f5_arg0.logo:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.logo)
		end,
	},
}
