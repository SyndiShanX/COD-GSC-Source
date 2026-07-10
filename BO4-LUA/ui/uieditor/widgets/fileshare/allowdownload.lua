CoD.AllowDownload = InheritFrom(LUI.UIElement)
CoD.AllowDownload.__defaultWidth = 30
CoD.AllowDownload.__defaultHeight = 28
CoD.AllowDownload.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.AllowDownload)
	self.id = "AllowDownload"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ImgAllowDownload = LUI.UIImage.new(0, 0, 0, 30, 0, 0, 0, 28)
	ImgAllowDownload:setRGB(0.21, 0.21, 0.21)
	self:addElement(ImgAllowDownload)
	self.ImgAllowDownload = ImgAllowDownload
	local Image0 = LUI.UIImage.new(0, 0, 3, 28, 0, 0, 3, 25)
	Image0:setRGB(0.5, 0.5, 0.5)
	self:addElement(Image0)
	self.Image0 = Image0
	self:mergeStateConditions({
		{
			stateName = "AllowDownload",
			condition = function(menu, element, event)
				return FileshareShouldAllowDownload()
			end,
		},
	})
	local f1_local3 = self
	local f1_local4 = self.subscribeToModel
	local f1_local5 = Engine[@"getglobalmodel"]()
	f1_local4(f1_local3, f1_local5["fileshareRoot.publishAllowDownload"], function(f3_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f3_arg0:get(),
			modelName = "fileshareRoot.publishAllowDownload",
		})
	end, false)
	self:subscribeToGlobalModel(f1_arg1, "FileshareRoot", "publishAllowDownload", function(model)
		local f4_local0 = self
		UpdateSelfState(self, f1_arg1)
	end)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.AllowDownload.__resetProperties = function(f5_arg0)
	f5_arg0.Image0:completeAnimation()
	f5_arg0.Image0:setRGB(0.5, 0.5, 0.5)
end
CoD.AllowDownload.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(0)
		end,
	},
	AllowDownload = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			f7_arg0.Image0:completeAnimation()
			f7_arg0.Image0:setRGB(0.02, 1, 0)
			f7_arg0.clipFinished(f7_arg0.Image0)
		end,
	},
}
