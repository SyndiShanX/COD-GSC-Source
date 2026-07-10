CoD.ButtonFrame_MaxLevelNotify = InheritFrom(LUI.UIElement)
CoD.ButtonFrame_MaxLevelNotify.__defaultWidth = 600
CoD.ButtonFrame_MaxLevelNotify.__defaultHeight = 100
CoD.ButtonFrame_MaxLevelNotify.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ButtonFrame_MaxLevelNotify)
	self.id = "ButtonFrame_MaxLevelNotify"
	self.soundSet = "none"
	local PrestigeIcon = LUI.UIImage.new(0, 0, 0, 100, 0, 0, 0, 100)
	PrestigeIcon:subscribeToGlobalModel(f1_arg1, "PrestigeMenuInfo", "hasPrestiged", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			PrestigeIcon:setImage(RegisterImage(CoD.PlayerStatsUtility.GetNextPrestigeIcon(f1_arg0, true, f2_local0)))
		end
	end)
	self:addElement(PrestigeIcon)
	self.PrestigeIcon = PrestigeIcon
	local MaxLevel = LUI.UIText.new(0.5, 0.5, -199.5, 239.5, 1, 1, -80, -59)
	MaxLevel:setRGB(0.92, 0.92, 0.92)
	MaxLevel:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_53266CB6BCE7419E"))
	MaxLevel:setTTF("ttmussels_demibold")
	MaxLevel:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_90D57B1E92D39D7"))
	MaxLevel:setShaderVector(0, 1, 0, 0, 0)
	MaxLevel:setShaderVector(1, 0, 0, 0, 0)
	MaxLevel:setShaderVector(2, 0, 0, 0, 0.5)
	MaxLevel:setLetterSpacing(2)
	MaxLevel:setLineSpacing(1)
	MaxLevel:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	self:addElement(MaxLevel)
	self.MaxLevel = MaxLevel
	local PrestigeAvailable = LUI.UIText.new(0.5, 0.5, -200.5, 239.5, 1, 1, -50, -20)
	PrestigeAvailable:setRGB(0.92, 0.92, 0.92)
	PrestigeAvailable:setText(Engine[@"hash_4F9F1239CFD921FE"](0xAAAEEE2695C5F4))
	PrestigeAvailable:setTTF("ttmussels_demibold")
	PrestigeAvailable:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_90D57B1E92D39D7"))
	PrestigeAvailable:setShaderVector(0, 1, 0, 0, 0)
	PrestigeAvailable:setShaderVector(1, 0, 0, 0, 0)
	PrestigeAvailable:setShaderVector(2, 0, 0, 0, 0.5)
	PrestigeAvailable:setLetterSpacing(2)
	PrestigeAvailable:setLineSpacing(1)
	PrestigeAvailable:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	self:addElement(PrestigeAvailable)
	self.PrestigeAvailable = PrestigeAvailable
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ButtonFrame_MaxLevelNotify.__onClose = function(f3_arg0)
	f3_arg0.PrestigeIcon:close()
end
