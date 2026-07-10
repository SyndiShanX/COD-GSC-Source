CoD.TabbedScoreboardHeaderTopbar02 = InheritFrom(LUI.UIElement)
CoD.TabbedScoreboardHeaderTopbar02.__defaultWidth = 688
CoD.TabbedScoreboardHeaderTopbar02.__defaultHeight = 10
CoD.TabbedScoreboardHeaderTopbar02.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.TabbedScoreboardHeaderTopbar02)
	self.id = "TabbedScoreboardHeaderTopbar02"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local EnemyTeamBar = LUI.UIImage.new(0.5, 0.5, -344, 344, 0, 0, 0, 10)
	EnemyTeamBar:setRGB(0.95, 0.95, 0.95)
	EnemyTeamBar:setImage(RegisterImage(0x59D632AC9663362))
	self:addElement(EnemyTeamBar)
	self.EnemyTeamBar = EnemyTeamBar
	local EnemyTeamBarWipe = LUI.UIImage.new(0.5, 0.5, -344, 344, 0, 0, 0, 10)
	EnemyTeamBarWipe:setRGB(0.95, 0.95, 0.95)
	EnemyTeamBarWipe:setImage(RegisterImage(0x59D632AC9663362))
	EnemyTeamBarWipe:setMaterial(LUI.UIImage.GetCachedMaterial(0xE992BD5A540E2D))
	EnemyTeamBarWipe:setShaderVector(0, 0, 1, 0, 0)
	EnemyTeamBarWipe:setShaderVector(1, 0, 0, 0, 0)
	EnemyTeamBarWipe:setShaderVector(2, 0, 1, 0, 0)
	EnemyTeamBarWipe:setShaderVector(3, 0, 0, 0, 0)
	EnemyTeamBarWipe:setShaderVector(4, 0, 0, 0, 0)
	self:addElement(EnemyTeamBarWipe)
	self.EnemyTeamBarWipe = EnemyTeamBarWipe
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.TabbedScoreboardHeaderTopbar02.__resetProperties = function(f2_arg0)
	f2_arg0.EnemyTeamBarWipe:completeAnimation()
	f2_arg0.EnemyTeamBarWipe:setMaterial(LUI.UIImage.GetCachedMaterial(0xE992BD5A540E2D))
	f2_arg0.EnemyTeamBarWipe:setShaderVector(0, 0, 1, 0, 0)
	f2_arg0.EnemyTeamBarWipe:setShaderVector(1, 0, 0, 0, 0)
	f2_arg0.EnemyTeamBarWipe:setShaderVector(2, 0, 1, 0, 0)
	f2_arg0.EnemyTeamBarWipe:setShaderVector(3, 0, 0, 0, 0)
	f2_arg0.EnemyTeamBarWipe:setShaderVector(4, 0, 0, 0, 0)
end
CoD.TabbedScoreboardHeaderTopbar02.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(1)
			local f3_local0 = function(f4_arg0)
				f3_arg0.EnemyTeamBarWipe:beginAnimation(300, Enum[0xF50FFF429AB1890][0x53CEB9A0427197])
				f3_arg0.EnemyTeamBarWipe:setShaderVector(0, 0, 1, 0, 0)
				f3_arg0.EnemyTeamBarWipe:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.EnemyTeamBarWipe:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
			end
			f3_arg0.EnemyTeamBarWipe:completeAnimation()
			f3_arg0.EnemyTeamBarWipe:setMaterial(LUI.UIImage.GetCachedMaterial(0xE992BD5A540E2D))
			f3_arg0.EnemyTeamBarWipe:setShaderVector(0, 0, 0, 0, 0)
			f3_arg0.EnemyTeamBarWipe:setShaderVector(1, 0, 0, 0, 0)
			f3_arg0.EnemyTeamBarWipe:setShaderVector(2, 0, 1, 0, 0)
			f3_arg0.EnemyTeamBarWipe:setShaderVector(3, 0, 0, 0, 0)
			f3_arg0.EnemyTeamBarWipe:setShaderVector(4, 0, 0, 0, 0)
			f3_local0(f3_arg0.EnemyTeamBarWipe)
		end,
	},
}
