CoD.StartMenu_ConnectionMeter_PingImage = InheritFrom(LUI.UIElement)
CoD.StartMenu_ConnectionMeter_PingImage.__defaultWidth = 43
CoD.StartMenu_ConnectionMeter_PingImage.__defaultHeight = 46
CoD.StartMenu_ConnectionMeter_PingImage.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.StartMenu_ConnectionMeter_PingImage)
	self.id = "StartMenu_ConnectionMeter_PingImage"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Level1Image = LUI.UIImage.new(0, 0, 0, 44, 0, 0, 0, 46)
	Level1Image:setAlpha(0)
	Level1Image:setImage(RegisterImage(@"uie_t7_icon_network_wired1"))
	self:addElement(Level1Image)
	self.Level1Image = Level1Image
	local Level2Image = LUI.UIImage.new(0, 0, 0, 44, 0, 0, 0, 46)
	Level2Image:setAlpha(0)
	Level2Image:setImage(RegisterImage(@"t7_network_icon_wired2"))
	self:addElement(Level2Image)
	self.Level2Image = Level2Image
	local Level3Image = LUI.UIImage.new(0, 0, 0, 44, 0, 0, 0, 46)
	Level3Image:setAlpha(0)
	Level3Image:setImage(RegisterImage(@"t7_network_icon_wired3"))
	self:addElement(Level3Image)
	self.Level3Image = Level3Image
	local Level4Image = LUI.UIImage.new(0, 0, 0, 44, 0, 0, 0, 46)
	Level4Image:setAlpha(0)
	Level4Image:setImage(RegisterImage(@"t7_network_icon_wired4"))
	self:addElement(Level4Image)
	self.Level4Image = Level4Image
	self:mergeStateConditions({
		{
			stateName = "Level1",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueGreaterThanOrEqualTo(element, f1_arg1, "NETSTATS_LATENCY", 300)
			end,
		},
		{
			stateName = "Level2",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueGreaterThanOrEqualTo(element, f1_arg1, "NETSTATS_LATENCY", 200)
			end,
		},
		{
			stateName = "Level3",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueGreaterThanOrEqualTo(element, f1_arg1, "NETSTATS_LATENCY", 100)
			end,
		},
		{
			stateName = "Level4",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueGreaterThanOrEqualTo(element, f1_arg1, "NETSTATS_LATENCY", 0)
			end,
		},
	})
	self:linkToElementModel(self, "NETSTATS_LATENCY", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "NETSTATS_LATENCY",
		})
	end)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.StartMenu_ConnectionMeter_PingImage.__resetProperties = function(f7_arg0)
	f7_arg0.Level1Image:completeAnimation()
	f7_arg0.Level2Image:completeAnimation()
	f7_arg0.Level3Image:completeAnimation()
	f7_arg0.Level4Image:completeAnimation()
	f7_arg0.Level1Image:setAlpha(0)
	f7_arg0.Level2Image:setAlpha(0)
	f7_arg0.Level3Image:setAlpha(0)
	f7_arg0.Level4Image:setAlpha(0)
end
CoD.StartMenu_ConnectionMeter_PingImage.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(0)
		end,
	},
	Level1 = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(1)
			f9_arg0.Level1Image:completeAnimation()
			f9_arg0.Level1Image:setAlpha(1)
			f9_arg0.clipFinished(f9_arg0.Level1Image)
		end,
	},
	Level2 = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(1)
			f10_arg0.Level2Image:completeAnimation()
			f10_arg0.Level2Image:setAlpha(1)
			f10_arg0.clipFinished(f10_arg0.Level2Image)
		end,
	},
	Level3 = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(1)
			f11_arg0.Level3Image:completeAnimation()
			f11_arg0.Level3Image:setAlpha(1)
			f11_arg0.clipFinished(f11_arg0.Level3Image)
		end,
	},
	Level4 = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(1)
			f12_arg0.Level4Image:completeAnimation()
			f12_arg0.Level4Image:setAlpha(1)
			f12_arg0.clipFinished(f12_arg0.Level4Image)
		end,
	},
}
