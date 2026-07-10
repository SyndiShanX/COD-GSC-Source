CoD.CodCasterPlayerListHeaderObjectiveColumn = InheritFrom(LUI.UIElement)
CoD.CodCasterPlayerListHeaderObjectiveColumn.__defaultWidth = 36
CoD.CodCasterPlayerListHeaderObjectiveColumn.__defaultHeight = 36
CoD.CodCasterPlayerListHeaderObjectiveColumn.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CodCasterPlayerListHeaderObjectiveColumn)
	self.id = "CodCasterPlayerListHeaderObjectiveColumn"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local FlagCTF = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	FlagCTF:setAlpha(0)
	FlagCTF:setImage(RegisterImage(0xDA4F726904CBAA9))
	self:addElement(FlagCTF)
	self.FlagCTF = FlagCTF
	local Bomb = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Bomb:setAlpha(0)
	Bomb:setImage(RegisterImage(0x1384926403E5879))
	self:addElement(Bomb)
	self.Bomb = Bomb
	local Hardpoint = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Hardpoint:setAlpha(0)
	Hardpoint:setImage(RegisterImage(0x48ED8422CAFED83))
	self:addElement(Hardpoint)
	self.Hardpoint = Hardpoint
	local Ball = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Ball:setAlpha(0)
	Ball:setImage(RegisterImage(0xA013C07155EC0C3))
	self:addElement(Ball)
	self.Ball = Ball
	local FlagDom = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	FlagDom:setAlpha(0)
	FlagDom:setImage(RegisterImage(0x8832159AB9E923A))
	self:addElement(FlagDom)
	self.FlagDom = FlagDom
	local Default = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Default:setImage(RegisterImage(0xC731D2658B4AEFD))
	self:addElement(Default)
	self.Default = Default
	self:mergeStateConditions({
		{
			stateName = "CTF",
			condition = function(menu, element, event)
				return CoD.HUDUtility.IsGameTypeEqualToString("ctf")
			end,
		},
		{
			stateName = "SDorSRorDem",
			condition = function(menu, element, event)
				return IsBombBasedGameMode()
			end,
		},
		{
			stateName = "Dom",
			condition = function(menu, element, event)
				return CoD.HUDUtility.IsGameTypeEqualToString("dom")
			end,
		},
		{
			stateName = "Hardpoint",
			condition = function(menu, element, event)
				return CoD.HUDUtility.IsGameTypeEqualToString("koth")
			end,
		},
		{
			stateName = "Uplink",
			condition = function(menu, element, event)
				return CoD.HUDUtility.IsGameTypeEqualToString("ball")
			end,
		},
		{
			stateName = "Safeguard",
			condition = function(menu, element, event)
				return CoD.HUDUtility.IsGameTypeEqualToString("escort")
			end,
		},
		{
			stateName = "GunGame",
			condition = function(menu, element, event)
				return CoD.HUDUtility.IsGameTypeEqualToString("gun")
			end,
		},
		{
			stateName = "FFA",
			condition = function(menu, element, event)
				return CoD.HUDUtility.IsGameTypeEqualToString("dm")
			end,
		},
	})
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CodCasterPlayerListHeaderObjectiveColumn.__resetProperties = function(f10_arg0)
	f10_arg0.FlagCTF:completeAnimation()
	f10_arg0.Default:completeAnimation()
	f10_arg0.Bomb:completeAnimation()
	f10_arg0.FlagDom:completeAnimation()
	f10_arg0.Hardpoint:completeAnimation()
	f10_arg0.Ball:completeAnimation()
	f10_arg0.FlagCTF:setAlpha(0)
	f10_arg0.Default:setAlpha(1)
	f10_arg0.Bomb:setAlpha(0)
	f10_arg0.FlagDom:setAlpha(0)
	f10_arg0.Hardpoint:setAlpha(0)
	f10_arg0.Ball:setAlpha(0)
end
CoD.CodCasterPlayerListHeaderObjectiveColumn.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(0)
		end,
	},
	CTF = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(2)
			f12_arg0.FlagCTF:completeAnimation()
			f12_arg0.FlagCTF:setAlpha(1)
			f12_arg0.clipFinished(f12_arg0.FlagCTF)
			f12_arg0.Default:completeAnimation()
			f12_arg0.Default:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.Default)
		end,
	},
	SDorSRorDem = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(2)
			f13_arg0.Bomb:completeAnimation()
			f13_arg0.Bomb:setAlpha(1)
			f13_arg0.clipFinished(f13_arg0.Bomb)
			f13_arg0.Default:completeAnimation()
			f13_arg0.Default:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.Default)
		end,
	},
	Dom = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(2)
			f14_arg0.FlagDom:completeAnimation()
			f14_arg0.FlagDom:setAlpha(1)
			f14_arg0.clipFinished(f14_arg0.FlagDom)
			f14_arg0.Default:completeAnimation()
			f14_arg0.Default:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.Default)
		end,
	},
	Hardpoint = {
		DefaultClip = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(2)
			f15_arg0.Hardpoint:completeAnimation()
			f15_arg0.Hardpoint:setAlpha(1)
			f15_arg0.clipFinished(f15_arg0.Hardpoint)
			f15_arg0.Default:completeAnimation()
			f15_arg0.Default:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.Default)
		end,
	},
	Uplink = {
		DefaultClip = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(2)
			f16_arg0.Ball:completeAnimation()
			f16_arg0.Ball:setAlpha(1)
			f16_arg0.clipFinished(f16_arg0.Ball)
			f16_arg0.Default:completeAnimation()
			f16_arg0.Default:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.Default)
		end,
	},
	Safeguard = {
		DefaultClip = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(2)
			f17_arg0.FlagDom:completeAnimation()
			f17_arg0.FlagDom:setAlpha(1)
			f17_arg0.clipFinished(f17_arg0.FlagDom)
			f17_arg0.Default:completeAnimation()
			f17_arg0.Default:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.Default)
		end,
	},
	GunGame = {
		DefaultClip = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(0)
		end,
	},
	FFA = {
		DefaultClip = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(0)
		end,
	},
}
