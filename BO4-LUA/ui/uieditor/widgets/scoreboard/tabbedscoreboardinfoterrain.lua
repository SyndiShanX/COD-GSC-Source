CoD.TabbedScoreboardInfoTerrain = InheritFrom(LUI.UIElement)
CoD.TabbedScoreboardInfoTerrain.__defaultWidth = 190
CoD.TabbedScoreboardInfoTerrain.__defaultHeight = 70
CoD.TabbedScoreboardInfoTerrain.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.TabbedScoreboardInfoTerrain)
	self.id = "TabbedScoreboardInfoTerrain"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Terrain = LUI.UIImage.new(0, 0, 0, 190, 0, 0, 0, 70)
	Terrain:setImage(RegisterImage(0x7DF0D9748126905))
	self:addElement(Terrain)
	self.Terrain = Terrain
	local TerrainAdd = LUI.UIImage.new(0, 0, 0, 190, 0, 0, 0, 70)
	TerrainAdd:setImage(RegisterImage(0x7DF0D9748126905))
	TerrainAdd:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	TerrainAdd:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(TerrainAdd)
	self.TerrainAdd = TerrainAdd
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.TabbedScoreboardInfoTerrain.__resetProperties = function(f2_arg0)
	f2_arg0.TerrainAdd:completeAnimation()
	f2_arg0.TerrainAdd:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	f2_arg0.TerrainAdd:setShaderVector(0, 1, 0, 0, 0)
end
CoD.TabbedScoreboardInfoTerrain.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(1)
			local f3_local0 = function(f4_arg0)
				local f4_local0 = function(f5_arg0)
					local f5_local0 = function(f6_arg0)
						f6_arg0:beginAnimation(1000)
						f6_arg0:setShaderVector(0, 0, 0, 0, 0)
						f6_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
					end
					f5_arg0:beginAnimation(1000)
					f5_arg0:setShaderVector(0, 1.2, 0, 0, 0)
					f5_arg0:registerEventHandler("transition_complete_keyframe", f5_local0)
				end
				f3_arg0.TerrainAdd:beginAnimation(1000)
				f3_arg0.TerrainAdd:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.TerrainAdd:registerEventHandler("transition_complete_keyframe", f4_local0)
			end
			f3_arg0.TerrainAdd:completeAnimation()
			f3_arg0.TerrainAdd:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
			f3_arg0.TerrainAdd:setShaderVector(0, 0, 0, 0, 0)
			f3_local0(f3_arg0.TerrainAdd)
			f3_arg0.nextClip = "DefaultClip"
		end,
	},
}
