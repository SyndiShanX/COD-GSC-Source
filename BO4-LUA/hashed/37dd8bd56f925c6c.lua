CoD.DupeIndicator = InheritFrom(LUI.UIElement)
CoD.DupeIndicator.__defaultWidth = 20
CoD.DupeIndicator.__defaultHeight = 20
CoD.DupeIndicator.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.DupeIndicator)
	self.id = "DupeIndicator"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local DupeIcon = LUI.UIImage.new(0, 0, 0, 20, 0, 0, 0, 20)
	DupeIcon:setRGB(ColorSet.T8__OCHRE.r, ColorSet.T8__OCHRE.g, ColorSet.T8__OCHRE.b)
	DupeIcon:setImage(RegisterImage(0xF395928C19E9B99))
	self:addElement(DupeIcon)
	self.DupeIcon = DupeIcon
	local RerollIcon = LUI.UIImage.new(0, 0, 0, 20, 0, 0, 0, 20)
	RerollIcon:setRGB(0.54, 0.87, 0.31)
	RerollIcon:setImage(RegisterImage(0xB259D817A83EFDB))
	self:addElement(RerollIcon)
	self.RerollIcon = RerollIcon
	local Contraband = LUI.UIImage.new(0, 0, 0, 40, 0, 0, 0, 20)
	Contraband:setAlpha(0)
	Contraband:setImage(RegisterImage(0x3AFA9E5CE99FEDF))
	self:addElement(Contraband)
	self.Contraband = Contraband
	self:mergeStateConditions({
		{
			stateName = "Dupe",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "dupe", true)
			end,
		},
		{
			stateName = "Reroll",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "reroll", true)
			end,
		},
		{
			stateName = "Contraband",
			condition = function(menu, element, event)
				local f4_local0 = CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, f1_arg1, "lootType", LuaEnum.LOOT_TYPE.CONTRABAND)
				if f4_local0 then
					if not CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "itemName", 0x0) then
						f4_local0 = not CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "itemName", 0x37934F15B706913)
					else
						f4_local0 = false
					end
				end
				return f4_local0
			end,
		},
	})
	self:linkToElementModel(self, "dupe", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "dupe",
		})
	end)
	self:linkToElementModel(self, "reroll", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "reroll",
		})
	end)
	self:linkToElementModel(self, "lootType", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "lootType",
		})
	end)
	self:linkToElementModel(self, "itemName", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "itemName",
		})
	end)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.DupeIndicator.__resetProperties = function(f9_arg0)
	f9_arg0.DupeIcon:completeAnimation()
	f9_arg0.RerollIcon:completeAnimation()
	f9_arg0.Contraband:completeAnimation()
	f9_arg0.DupeIcon:setAlpha(1)
	f9_arg0.RerollIcon:setAlpha(1)
	f9_arg0.Contraband:setLeftRight(0, 0, 0, 40)
	f9_arg0.Contraband:setTopBottom(0, 0, 0, 20)
	f9_arg0.Contraband:setRGB(1, 1, 1)
	f9_arg0.Contraband:setAlpha(0)
end
CoD.DupeIndicator.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(2)
			f10_arg0.DupeIcon:completeAnimation()
			f10_arg0.DupeIcon:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.DupeIcon)
			f10_arg0.RerollIcon:completeAnimation()
			f10_arg0.RerollIcon:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.RerollIcon)
		end,
	},
	Dupe = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(2)
			f11_arg0.DupeIcon:completeAnimation()
			f11_arg0.DupeIcon:setAlpha(0.8)
			f11_arg0.clipFinished(f11_arg0.DupeIcon)
			f11_arg0.RerollIcon:completeAnimation()
			f11_arg0.RerollIcon:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.RerollIcon)
		end,
	},
	Reroll = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(2)
			f12_arg0.DupeIcon:completeAnimation()
			f12_arg0.DupeIcon:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.DupeIcon)
			f12_arg0.RerollIcon:completeAnimation()
			f12_arg0.RerollIcon:setAlpha(0.8)
			f12_arg0.clipFinished(f12_arg0.RerollIcon)
		end,
	},
	Contraband = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(3)
			f13_arg0.DupeIcon:completeAnimation()
			f13_arg0.DupeIcon:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.DupeIcon)
			f13_arg0.RerollIcon:completeAnimation()
			f13_arg0.RerollIcon:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.RerollIcon)
			f13_arg0.Contraband:completeAnimation()
			f13_arg0.Contraband:setLeftRight(0, 0, 0, 32)
			f13_arg0.Contraband:setTopBottom(0, 0, 0, 20)
			f13_arg0.Contraband:setRGB(0.52, 0.6, 0.68)
			f13_arg0.Contraband:setAlpha(1)
			f13_arg0.clipFinished(f13_arg0.Contraband)
		end,
	},
}
