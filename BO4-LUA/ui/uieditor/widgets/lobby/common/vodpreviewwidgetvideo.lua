CoD.VoDPreviewWidgetVideo = InheritFrom(LUI.UIElement)
CoD.VoDPreviewWidgetVideo.__defaultWidth = 192
CoD.VoDPreviewWidgetVideo.__defaultHeight = 108
CoD.VoDPreviewWidgetVideo.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.VoDPreviewWidgetVideo)
	self.id = "VoDPreviewWidgetVideo"
	self.soundSet = "default"
	local Image = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Image:linkToElementModel(self, "stillPreview", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			Image:setImage(RegisterImage(f2_local0))
		end
	end)
	self:addElement(Image)
	self.Image = Image
	local CoreMoviePlayer = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	CoreMoviePlayer:linkToElementModel(self, "lowResVideo.movieName", true, function(model)
		if model:get() ~= nil then
			local f3_local0 = CoreMoviePlayer
			local f3_local1 = f3_local0
			f3_local0 = f3_local0.setupCoreMoviePlayback
			local f3_local2 = CoD.VideoStreamingUtility.SetupVoDPreviewWidget
			local f3_local3 = self:getModel()
			f3_local0(f3_local1, f3_local2(f3_local3.lowResVideo))
		end
	end)
	self:addElement(CoreMoviePlayer)
	self.CoreMoviePlayer = CoreMoviePlayer
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.VoDPreviewWidgetVideo.__onClose = function(f4_arg0)
	f4_arg0.Image:close()
	f4_arg0.CoreMoviePlayer:close()
end
