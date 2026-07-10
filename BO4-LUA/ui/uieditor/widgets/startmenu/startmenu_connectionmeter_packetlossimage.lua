CoD.StartMenu_ConnectionMeter_PacketLossImage = InheritFrom(LUI.UIElement)
CoD.StartMenu_ConnectionMeter_PacketLossImage.__defaultWidth = 43
CoD.StartMenu_ConnectionMeter_PacketLossImage.__defaultHeight = 46
CoD.StartMenu_ConnectionMeter_PacketLossImage.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.StartMenu_ConnectionMeter_PacketLossImage)
	self.id = "StartMenu_ConnectionMeter_PacketLossImage"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Level1Image = LUI.UIImage.new(0, 0, 0, 44, 0, 0, 0, 46)
	Level1Image:setAlpha(0)
	Level1Image:setImage(RegisterImage(@"uie_t7_icon_network_packet1"))
	self:addElement(Level1Image)
	self.Level1Image = Level1Image
	local Level2Image = LUI.UIImage.new(0, 0, 0, 44, 0, 0, 0, 46)
	Level2Image:setAlpha(0)
	Level2Image:setImage(RegisterImage(@"uie_t7_icon_network_packet2"))
	self:addElement(Level2Image)
	self.Level2Image = Level2Image
	local Level3Image = LUI.UIImage.new(0, 0, 0, 44, 0, 0, 0, 46)
	Level3Image:setAlpha(0)
	Level3Image:setImage(RegisterImage(@"uie_t7_icon_network_packet3"))
	self:addElement(Level3Image)
	self.Level3Image = Level3Image
	self:mergeStateConditions({
		{
			stateName = "Level1",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueGreaterThanOrEqualTo(element, f1_arg1, "NETSTATS_PACKETLOSS", 5)
			end,
		},
		{
			stateName = "Level2",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueGreaterThanOrEqualTo(element, f1_arg1, "NETSTATS_PACKETLOSS", 2)
			end,
		},
		{
			stateName = "Level3",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueGreaterThanOrEqualTo(element, f1_arg1, "NETSTATS_PACKETLOSS", 0)
			end,
		},
	})
	self:linkToElementModel(self, "NETSTATS_PACKETLOSS", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "NETSTATS_PACKETLOSS",
		})
	end)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.StartMenu_ConnectionMeter_PacketLossImage.__resetProperties = function(f6_arg0)
	f6_arg0.Level1Image:completeAnimation()
	f6_arg0.Level2Image:completeAnimation()
	f6_arg0.Level3Image:completeAnimation()
	f6_arg0.Level1Image:setAlpha(0)
	f6_arg0.Level2Image:setAlpha(0)
	f6_arg0.Level3Image:setAlpha(0)
end
CoD.StartMenu_ConnectionMeter_PacketLossImage.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(0)
		end,
	},
	Level1 = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(1)
			f8_arg0.Level1Image:completeAnimation()
			f8_arg0.Level1Image:setAlpha(1)
			f8_arg0.clipFinished(f8_arg0.Level1Image)
		end,
	},
	Level2 = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(1)
			f9_arg0.Level2Image:completeAnimation()
			f9_arg0.Level2Image:setAlpha(1)
			f9_arg0.clipFinished(f9_arg0.Level2Image)
		end,
	},
	Level3 = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(1)
			f10_arg0.Level3Image:completeAnimation()
			f10_arg0.Level3Image:setAlpha(1)
			f10_arg0.clipFinished(f10_arg0.Level3Image)
		end,
	},
}
