CoD.ZMInvTalisman = InheritFrom(LUI.UIElement)
CoD.ZMInvTalisman.__defaultWidth = 128
CoD.ZMInvTalisman.__defaultHeight = 128
CoD.ZMInvTalisman.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ZMInvTalisman)
	self.id = "ZMInvTalisman"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Image = LUI.UIImage.new(0, 0, 0, 128, 0, 0, 0, 128)
	self:addElement(Image)
	self.Image = Image
	local Name = LUI.UIText.new(0, 0, -211, -11, 0, 0, 44.5, 65.5)
	Name:setText(Engine[0xF9F1239CFD921FE](0x93E719493E9E18F))
	Name:setTTF("skorzhen")
	Name:setLetterSpacing(1)
	Name:setAlignment(Enum[0x7A5123B654282D2][0x830CFD395E6AA0A])
	Name:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(Name)
	self.Name = Name
	self:mergeStateConditions({
		{
			stateName = "Show",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalDataSourceModelValueEqualTo(f1_arg1, "ZMInvTalisman", "show", 1)
			end,
		},
	})
	local f1_local3 = self
	local f1_local4 = self.subscribeToModel
	local f1_local5 = DataSources.ZMInvTalisman.getModel(f1_arg1)
	f1_local4(f1_local3, f1_local5.show, function(f3_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f3_arg0:get(),
			modelName = "show",
		})
	end, false)
	self:subscribeToGlobalModel(f1_arg1, "PerController", "selectedCustomClass", function(model)
		local f4_local0 = self
		CoD.ZMInventoryUtility.SetupInventoryTalisman(f1_arg1, model, self.Name, self.Image)
	end)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ZMInvTalisman.__resetProperties = function(f5_arg0)
	f5_arg0.Name:completeAnimation()
	f5_arg0.Image:completeAnimation()
	f5_arg0.Name:setAlpha(1)
	f5_arg0.Image:setAlpha(1)
end
CoD.ZMInvTalisman.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(2)
			f6_arg0.Image:completeAnimation()
			f6_arg0.Image:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.Image)
			f6_arg0.Name:completeAnimation()
			f6_arg0.Name:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.Name)
		end,
	},
	Show = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(0)
		end,
	},
}
