CoD.BM_ContractEquippedTick = InheritFrom(LUI.UIElement)
CoD.BM_ContractEquippedTick.__defaultWidth = 44
CoD.BM_ContractEquippedTick.__defaultHeight = 44
CoD.BM_ContractEquippedTick.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.BM_ContractEquippedTick)
	self.id = "BM_ContractEquippedTick"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local EquippedMarkerBG = LUI.UIImage.new(0.5, 0.5, -22, 22, 0.5, 0.5, -22, 22)
	EquippedMarkerBG:setZoom(4)
	EquippedMarkerBG:setImage(RegisterImage(0x7AF532D84DE505A))
	EquippedMarkerBG:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(EquippedMarkerBG)
	self.EquippedMarkerBG = EquippedMarkerBG
	local EquippedMarkerTick = LUI.UIImage.new(0.5, 0.5, -22, 22, 0.5, 0.5, -22, 22)
	EquippedMarkerTick:setZoom(4)
	EquippedMarkerTick:setImage(RegisterImage(0x9A8B26C9B001758))
	self:addElement(EquippedMarkerTick)
	self.EquippedMarkerTick = EquippedMarkerTick
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.BM_ContractEquippedTick.__resetProperties = function(f2_arg0)
	f2_arg0.EquippedMarkerTick:completeAnimation()
	f2_arg0.EquippedMarkerBG:completeAnimation()
	f2_arg0.EquippedMarkerTick:setAlpha(1)
	f2_arg0.EquippedMarkerBG:setAlpha(1)
end
CoD.BM_ContractEquippedTick.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(2)
			f3_arg0.EquippedMarkerBG:completeAnimation()
			f3_arg0.EquippedMarkerBG:setAlpha(0)
			f3_arg0.clipFinished(f3_arg0.EquippedMarkerBG)
			f3_arg0.EquippedMarkerTick:completeAnimation()
			f3_arg0.EquippedMarkerTick:setAlpha(0)
			f3_arg0.clipFinished(f3_arg0.EquippedMarkerTick)
		end,
	},
	Equipped = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(2)
			f4_arg0.EquippedMarkerBG:completeAnimation()
			f4_arg0.EquippedMarkerBG:setAlpha(1)
			f4_arg0.clipFinished(f4_arg0.EquippedMarkerBG)
			f4_arg0.EquippedMarkerTick:completeAnimation()
			f4_arg0.EquippedMarkerTick:setAlpha(1)
			f4_arg0.clipFinished(f4_arg0.EquippedMarkerTick)
		end,
	},
}
