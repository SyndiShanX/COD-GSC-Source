require("x64:a9255c570c68aa8")
CoD.ZMInvPaPItem = InheritFrom(LUI.UIElement)
CoD.ZMInvPaPItem.__defaultWidth = 80
CoD.ZMInvPaPItem.__defaultHeight = 80
CoD.ZMInvPaPItem.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ZMInvPaPItem)
	self.id = "ZMInvPaPItem"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Backing = LUI.UIImage.new(0.5, 0.5, -50, 50, 0.5, 0.5, -50, 50)
	Backing:setAlpha(0)
	Backing:setImage(RegisterImage(@"hash_5198E62429893867"))
	self:addElement(Backing)
	self.Backing = Backing
	local Stage3Image = LUI.UIImage.new(0.5, 0.5, -40, 40, 0.5, 0.5, -40, 40)
	self:addElement(Stage3Image)
	self.Stage3Image = Stage3Image
	local Stage2Image = LUI.UIImage.new(0.5, 0.5, -40, 40, 0.5, 0.5, -40, 40)
	self:addElement(Stage2Image)
	self.Stage2Image = Stage2Image
	local Stage1Image = LUI.UIImage.new(0.5, 0.5, -40, 40, 0.5, 0.5, -40, 40)
	self:addElement(Stage1Image)
	self.Stage1Image = Stage1Image
	local MainFrame = CoD.StartMenuOptionsMainFrame.new(f1_arg0, f1_arg1, 0.5, 0.5, -30, 30, 0.5, 0.5, -30, 30)
	MainFrame:setAlpha(0.1)
	self:addElement(MainFrame)
	self.MainFrame = MainFrame
	self.Stage3Image:linkToElementModel(self, "image3", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			Stage3Image:setImage(RegisterImage(f2_local0))
		end
	end)
	self.Stage2Image:linkToElementModel(self, "image2", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			Stage2Image:setImage(RegisterImage(f3_local0))
		end
	end)
	self.Stage1Image:linkToElementModel(self, "image1", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			Stage1Image:setImage(RegisterImage(f4_local0))
		end
	end)
	self:mergeStateConditions({
		{
			stateName = "Stage1",
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
CoD.ZMInvPaPItem.__resetProperties = function(f9_arg0)
	f9_arg0.Stage1Image:completeAnimation()
	f9_arg0.Stage2Image:completeAnimation()
	f9_arg0.Stage3Image:completeAnimation()
	f9_arg0.Stage1Image:setAlpha(1)
	f9_arg0.Stage2Image:setAlpha(1)
	f9_arg0.Stage3Image:setAlpha(1)
end
CoD.ZMInvPaPItem.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(3)
			f10_arg0.Stage3Image:completeAnimation()
			f10_arg0.Stage3Image:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.Stage3Image)
			f10_arg0.Stage2Image:completeAnimation()
			f10_arg0.Stage2Image:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.Stage2Image)
			f10_arg0.Stage1Image:completeAnimation()
			f10_arg0.Stage1Image:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.Stage1Image)
		end,
	},
	Stage1 = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(2)
			f11_arg0.Stage3Image:completeAnimation()
			f11_arg0.Stage3Image:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.Stage3Image)
			f11_arg0.Stage2Image:completeAnimation()
			f11_arg0.Stage2Image:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.Stage2Image)
		end,
	},
	Stage2 = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(2)
			f12_arg0.Stage3Image:completeAnimation()
			f12_arg0.Stage3Image:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.Stage3Image)
			f12_arg0.Stage1Image:completeAnimation()
			f12_arg0.Stage1Image:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.Stage1Image)
		end,
	},
	Stage3 = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(2)
			f13_arg0.Stage2Image:completeAnimation()
			f13_arg0.Stage2Image:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.Stage2Image)
			f13_arg0.Stage1Image:completeAnimation()
			f13_arg0.Stage1Image:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.Stage1Image)
		end,
	},
}
CoD.ZMInvPaPItem.__onClose = function(f14_arg0)
	f14_arg0.Stage3Image:close()
	f14_arg0.Stage2Image:close()
	f14_arg0.Stage1Image:close()
	f14_arg0.MainFrame:close()
end
