require("x64:5150cdf5affac6")
CoD.PlayOfTheMatchGamertag = InheritFrom(LUI.UIElement)
CoD.PlayOfTheMatchGamertag.__defaultWidth = 1600
CoD.PlayOfTheMatchGamertag.__defaultHeight = 106
CoD.PlayOfTheMatchGamertag.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PlayOfTheMatchGamertag)
	self.id = "PlayOfTheMatchGamertag"
	self.soundSet = "default"
	local Gamertag = LUI.UIText.new(1, 1, -1600, -4, 0, 0, 10, 95)
	Gamertag:setText("")
	Gamertag:setTTF("notosans_regular")
	Gamertag:setLetterSpacing(6)
	Gamertag:setAlignment(Enum[@"luialignment"][@"lui_alignment_right"])
	Gamertag:setBackingType(1)
	Gamertag:setBackingWidget(CoD.PlayOfTheMatchGamertagBacking, f1_arg0, f1_arg1)
	Gamertag:setBackingXPadding(14)
	self:addElement(Gamertag)
	self.Gamertag = Gamertag
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
