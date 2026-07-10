require("x64:a9255c570c68aa8")
CoD.ZMInvQuestItem = InheritFrom(LUI.UIElement)
CoD.ZMInvQuestItem.__defaultWidth = 80
CoD.ZMInvQuestItem.__defaultHeight = 80
CoD.ZMInvQuestItem.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ZMInvQuestItem)
	self.id = "ZMInvQuestItem"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Backing = LUI.UIImage.new(0.03, 0.96, 0, 0, 0.05, 0.95, 0, 0)
	Backing:setAlpha(0)
	Backing:setImage(RegisterImage(@"hash_5198E62429893867"))
	self:addElement(Backing)
	self.Backing = Backing
	local StageImage3 = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	StageImage3:setAlpha(0)
	StageImage3:linkToElementModel(self, "image3", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			StageImage3:setImage(RegisterImage(f2_local0))
		end
	end)
	self:addElement(StageImage3)
	self.StageImage3 = StageImage3
	local StageImage2 = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	StageImage2:setAlpha(0)
	StageImage2:linkToElementModel(self, "image2", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			StageImage2:setImage(RegisterImage(f3_local0))
		end
	end)
	self:addElement(StageImage2)
	self.StageImage2 = StageImage2
	local Image = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Image:setAlpha(0)
	Image:linkToElementModel(self, "image1", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			Image:setImage(RegisterImage(f4_local0))
		end
	end)
	self:addElement(Image)
	self.Image = Image
	local MainFrame = CoD.StartMenuOptionsMainFrame.new(f1_arg0, f1_arg1, 0.5, 0.5, -30, 30, 0.5, 0.5, -30, 30)
	MainFrame:setAlpha(0.2)
	self:addElement(MainFrame)
	self.MainFrame = MainFrame
	self:mergeStateConditions({
		{
			stateName = "Acquired",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(self, f1_arg1, "stage", 1)
			end,
		},
		{
			stateName = "Stage2",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(self, f1_arg1, "stage", 2)
			end,
		},
		{
			stateName = "Stage3",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(self, f1_arg1, "stage", 3)
			end,
		},
	})
	self:linkToElementModel(self, "stage", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "stage",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ZMInvQuestItem.__resetProperties = function(f9_arg0)
	f9_arg0.Image:completeAnimation()
	f9_arg0.StageImage2:completeAnimation()
	f9_arg0.StageImage3:completeAnimation()
	f9_arg0.Image:setAlpha(0)
	f9_arg0.StageImage2:setAlpha(0)
	f9_arg0.StageImage3:setAlpha(0)
end
CoD.ZMInvQuestItem.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(0)
		end,
	},
	Acquired = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(1)
			f11_arg0.Image:completeAnimation()
			f11_arg0.Image:setAlpha(1)
			f11_arg0.clipFinished(f11_arg0.Image)
		end,
	},
	Stage2 = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(1)
			f12_arg0.StageImage2:completeAnimation()
			f12_arg0.StageImage2:setAlpha(1)
			f12_arg0.clipFinished(f12_arg0.StageImage2)
		end,
	},
	Stage3 = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(1)
			f13_arg0.StageImage3:completeAnimation()
			f13_arg0.StageImage3:setAlpha(1)
			f13_arg0.clipFinished(f13_arg0.StageImage3)
		end,
	},
}
CoD.ZMInvQuestItem.__onClose = function(f14_arg0)
	f14_arg0.StageImage3:close()
	f14_arg0.StageImage2:close()
	f14_arg0.Image:close()
	f14_arg0.MainFrame:close()
end
