CoD.Codcaster_annoncement_bg = InheritFrom(LUI.UIElement)
CoD.Codcaster_annoncement_bg.__defaultWidth = 460
CoD.Codcaster_annoncement_bg.__defaultHeight = 32
CoD.Codcaster_annoncement_bg.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Codcaster_annoncement_bg)
	self.id = "Codcaster_annoncement_bg"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local blur = LUI.UIImage.new(0.5, 0.5, -217, 217, 1.1, 1.1, -29, -9)
	blur:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_E2354BE557C4C7A"))
	blur:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(blur)
	self.blur = blur
	local colorbg = LUI.UIImage.new(0.5, 0.5, -217, 217, 0, 0, 7, 27)
	colorbg:setAlpha(0.9)
	colorbg:setImage(RegisterImage(@"uie_codcaster_teamcolloredbg_generic"))
	self:addElement(colorbg)
	self.colorbg = colorbg
	local AnnouncementImageBackground = LUI.UIImage.new(0.5, 0.5, -230, 230, 0, 0, 0, 32)
	AnnouncementImageBackground:setImage(RegisterImage(@"uie_codcaster_announcement_bg"))
	self:addElement(AnnouncementImageBackground)
	self.AnnouncementImageBackground = AnnouncementImageBackground
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.Codcaster_annoncement_bg.__resetProperties = function(f2_arg0)
	f2_arg0.AnnouncementImageBackground:completeAnimation()
	f2_arg0.AnnouncementImageBackground:setAlpha(1)
end
CoD.Codcaster_annoncement_bg.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(1)
			f3_arg0.AnnouncementImageBackground:completeAnimation()
			f3_arg0.AnnouncementImageBackground:setAlpha(1)
			f3_arg0.clipFinished(f3_arg0.AnnouncementImageBackground)
		end,
	},
}
