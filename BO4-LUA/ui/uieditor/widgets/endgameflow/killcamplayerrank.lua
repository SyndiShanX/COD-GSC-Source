CoD.KillcamPlayerRank = InheritFrom(LUI.UIElement)
CoD.KillcamPlayerRank.__defaultWidth = 147
CoD.KillcamPlayerRank.__defaultHeight = 40
CoD.KillcamPlayerRank.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.KillcamPlayerRank)
	self.id = "KillcamPlayerRank"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Backing = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Backing:setRGB(0.06, 0.06, 0.06)
	Backing:setAlpha(0.8)
	self:addElement(Backing)
	self.Backing = Backing
	local Rank = LUI.UIText.new(0.5, 0.5, 0, 74, 0.5, 0.5, -16, 20)
	Rank:setText(88)
	Rank:setTTF("0arame_mono_stencil")
	Rank:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	self:addElement(Rank)
	self.Rank = Rank
	local RankIcon = LUI.UIImage.new(0.5, 0.5, -45, -5, 0.5, 0.5, -20, 20)
	self:addElement(RankIcon)
	self.RankIcon = RankIcon
	self:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return not IsLAN()
			end,
		},
	})
	local f1_local4 = self
	local f1_local5 = self.subscribeToModel
	local f1_local6 = Engine[0x8DF2E5447F384B9]()
	f1_local5(f1_local4, f1_local6["lobbyRoot.lobbyNetworkMode"], function(f3_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f3_arg0:get(),
			modelName = "lobbyRoot.lobbyNetworkMode",
		})
	end, false)
	f1_local4 = self
	f1_local5 = self.subscribeToModel
	f1_local6 = Engine[0x8DF2E5447F384B9]()
	f1_local5(f1_local4, f1_local6["lobbyRoot.lobbyNav"], function(f4_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f4_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.KillcamPlayerRank.__resetProperties = function(f5_arg0)
	f5_arg0.RankIcon:completeAnimation()
	f5_arg0.Rank:completeAnimation()
	f5_arg0.Backing:completeAnimation()
	f5_arg0.RankIcon:setAlpha(1)
	f5_arg0.Rank:setAlpha(1)
	f5_arg0.Backing:setAlpha(0.8)
end
CoD.KillcamPlayerRank.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(3)
			f6_arg0.Backing:completeAnimation()
			f6_arg0.Backing:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.Backing)
			f6_arg0.Rank:completeAnimation()
			f6_arg0.Rank:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.Rank)
			f6_arg0.RankIcon:completeAnimation()
			f6_arg0.RankIcon:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.RankIcon)
		end,
	},
	Visible = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(0)
		end,
	},
}
