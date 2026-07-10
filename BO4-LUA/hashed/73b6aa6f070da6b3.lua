require("x64:a9255c570c68aa8")
CoD.ZMInvShieldItem = InheritFrom(LUI.UIElement)
CoD.ZMInvShieldItem.__defaultWidth = 80
CoD.ZMInvShieldItem.__defaultHeight = 80
CoD.ZMInvShieldItem.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ZMInvShieldItem)
	self.id = "ZMInvShieldItem"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Backing = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Backing:setAlpha(0)
	Backing:setImage(RegisterImage(0x198E62429893867))
	self:addElement(Backing)
	self.Backing = Backing
	local PieceImage = LUI.UIImage.new(0.5, 0.5, -40, 40, 0.5, 0.5, -40, 40)
	PieceImage:linkToElementModel(self, "image1", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			PieceImage:setImage(RegisterImage(f2_local0))
		end
	end)
	self:addElement(PieceImage)
	self.PieceImage = PieceImage
	local MainFrame = CoD.StartMenuOptionsMainFrame.new(f1_arg0, f1_arg1, 0.5, 0.5, -30, 30, 0.5, 0.5, -30, 30)
	MainFrame:setAlpha(0.1)
	self:addElement(MainFrame)
	self.MainFrame = MainFrame
	self:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return CoD.HUDUtility.IsAnyGameType(f1_arg1, "zstandard")
			end,
		},
		{
			stateName = "Acquired",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(self, f1_arg1, "stage", 1)
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
CoD.ZMInvShieldItem.__resetProperties = function(f6_arg0)
	f6_arg0.PieceImage:completeAnimation()
	f6_arg0.Backing:completeAnimation()
	f6_arg0.PieceImage:setAlpha(1)
	f6_arg0.Backing:setAlpha(0)
end
CoD.ZMInvShieldItem.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			f7_arg0.PieceImage:completeAnimation()
			f7_arg0.PieceImage:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.PieceImage)
		end,
	},
	Hidden = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(2)
			f8_arg0.Backing:completeAnimation()
			f8_arg0.Backing:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.Backing)
			f8_arg0.PieceImage:completeAnimation()
			f8_arg0.PieceImage:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.PieceImage)
		end,
	},
	Acquired = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(0)
		end,
	},
}
CoD.ZMInvShieldItem.__onClose = function(f10_arg0)
	f10_arg0.PieceImage:close()
	f10_arg0.MainFrame:close()
end
