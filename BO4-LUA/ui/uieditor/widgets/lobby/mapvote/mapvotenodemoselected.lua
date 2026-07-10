require("x64:acbf06924421e35")
require("x64:a89616c2a8dc68d")
require("x64:921141524671081")
CoD.MapVoteNoDemoSelected = InheritFrom(LUI.UIElement)
CoD.MapVoteNoDemoSelected.__defaultWidth = 356
CoD.MapVoteNoDemoSelected.__defaultHeight = 200
CoD.MapVoteNoDemoSelected.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.MapVoteNoDemoSelected)
	self.id = "MapVoteNoDemoSelected"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local BlackBack = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	BlackBack:setRGB(0, 0, 0)
	self:addElement(BlackBack)
	self.BlackBack = BlackBack
	local FEMemberBlurPanelContainer0 = CoD.FE_MemberBlurPanelContainer.new(f1_arg0, f1_arg1, 0, 1, 1, -1, 0, 1, 0, 0)
	FEMemberBlurPanelContainer0:setRGB(0.5, 0.5, 0.5)
	self:addElement(FEMemberBlurPanelContainer0)
	self.FEMemberBlurPanelContainer0 = FEMemberBlurPanelContainer0
	local Icon = LUI.UIImage.new(0.5, 0.5, -139.5, 139.5, 0.5, 0.5, -139.5, 139.5)
	Icon:setScale(0.7, 0.7)
	Icon:setImage(RegisterImage(@"theater_film"))
	self:addElement(Icon)
	self.Icon = Icon
	local GameModeNew = CoD.MapVoteLabelLower.new(f1_arg0, f1_arg1, 0.5, 0.5, -140, 140, 1, 1, -39.5, -12.5)
	GameModeNew.StartMenuIdentitySubtitleBG00:setAlpha(0.42)
	GameModeNew.SubTitle:setText(LocalizeToUpperString(0x0))
	self:addElement(GameModeNew)
	self.GameModeNew = GameModeNew
	local CommonCornerPips = CoD.CommonCornerPips01.new(f1_arg0, f1_arg1, 0, 0.99, 1, 1, 0, 1, 0, 0)
	self:addElement(CommonCornerPips)
	self.CommonCornerPips = CommonCornerPips
	self:mergeStateConditions({
		{
			stateName = "CPHidden",
			condition = function(menu, element, event)
				return IsCPMapVoteHidden(f1_arg1)
			end,
		},
	})
	local f1_local6 = self
	local f1_local7 = self.subscribeToModel
	local f1_local8 = Engine[@"getglobalmodel"]()
	f1_local7(f1_local6, f1_local8["lobbyRoot.lobbyNav"], function(f3_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f3_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.MapVoteNoDemoSelected.__resetProperties = function(f4_arg0)
	f4_arg0.FEMemberBlurPanelContainer0:completeAnimation()
	f4_arg0.BlackBack:completeAnimation()
	f4_arg0.Icon:completeAnimation()
	f4_arg0.GameModeNew:completeAnimation()
	f4_arg0.FEMemberBlurPanelContainer0:setRGB(0.5, 0.5, 0.5)
	f4_arg0.FEMemberBlurPanelContainer0:setAlpha(1)
	f4_arg0.BlackBack:setRGB(0, 0, 0)
	f4_arg0.Icon:setAlpha(1)
	f4_arg0.GameModeNew:setAlpha(1)
end
CoD.MapVoteNoDemoSelected.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(0)
		end,
		Focus = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(2)
			f6_arg0.BlackBack:completeAnimation()
			f6_arg0.BlackBack:setRGB(0.51, 0.51, 0.51)
			f6_arg0.clipFinished(f6_arg0.BlackBack)
			f6_arg0.FEMemberBlurPanelContainer0:completeAnimation()
			f6_arg0.FEMemberBlurPanelContainer0:setRGB(0.82, 0.82, 0.82)
			f6_arg0.clipFinished(f6_arg0.FEMemberBlurPanelContainer0)
		end,
	},
	CPHidden = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(3)
			f7_arg0.FEMemberBlurPanelContainer0:completeAnimation()
			f7_arg0.FEMemberBlurPanelContainer0:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.FEMemberBlurPanelContainer0)
			f7_arg0.Icon:completeAnimation()
			f7_arg0.Icon:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.Icon)
			f7_arg0.GameModeNew:completeAnimation()
			f7_arg0.GameModeNew:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.GameModeNew)
		end,
	},
}
CoD.MapVoteNoDemoSelected.__onClose = function(f8_arg0)
	f8_arg0.FEMemberBlurPanelContainer0:close()
	f8_arg0.GameModeNew:close()
	f8_arg0.CommonCornerPips:close()
end
