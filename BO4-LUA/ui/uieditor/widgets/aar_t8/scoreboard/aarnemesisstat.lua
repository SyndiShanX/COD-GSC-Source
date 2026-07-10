CoD.AARNemesisStat = InheritFrom(LUI.UIElement)
CoD.AARNemesisStat.__defaultWidth = 60
CoD.AARNemesisStat.__defaultHeight = 40
CoD.AARNemesisStat.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.AARNemesisStat)
	self.id = "AARNemesisStat"
	self.soundSet = "none"
	local Label = LUI.UIText.new(0.5, 0.5, -100, 100, 0, 0, 0, 16)
	Label:setAlpha(0.8)
	Label:setText(Engine[@"hash_4F9F1239CFD921FE"](@"menu/new"))
	Label:setTTF("ttmussels_regular")
	Label:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	Label:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(Label)
	self.Label = Label
	local Stat = LUI.UIText.new(0.5, 0.5, -100, 100, 0, 0, 18, 48)
	Stat:setAlpha(0.8)
	Stat:setText(Engine[@"hash_4F9F1239CFD921FE"](@"menu/new"))
	Stat:setTTF("ttmussels_demibold")
	Stat:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	Stat:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(Stat)
	self.Stat = Stat
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
