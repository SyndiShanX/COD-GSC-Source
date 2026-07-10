require("x64:180ee4aff8754b")
CoD[0x6B87D0160EF7465] = InheritFrom(LUI.UIElement)
CoD[0x6B87D0160EF7465].__defaultWidth = 960
CoD[0x6B87D0160EF7465].__defaultHeight = 240
CoD[0x6B87D0160EF7465].new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD[0x6B87D0160EF7465])
	self.id = "CallingCards_Career_Game_Heroics_Master"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local background = LUI.UIImage.new(0, 0, 0, 960, 0, 0, 0, 240)
	background:setImage(RegisterImage(0x78650DB1D151D48))
	self:addElement(background)
	self.background = background
	local topcloud = LUI.UIImage.new(0, 0, 0, 960, 0, 0, 0, 240)
	topcloud:setImage(RegisterImage(0xE401A642A0DB3A8))
	self:addElement(topcloud)
	self.topcloud = topcloud
	local vortex = LUI.UIImage.new(0, 0, 257, 690, 0, 0, -157.5, 354.5)
	vortex:setAlpha(0.3)
	vortex:setImage(RegisterImage(0x646B7C17755125C))
	vortex:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(vortex)
	self.vortex = vortex
	local CallingCardsAssetbirdswhite = CoD.CallingCards_Asset_birds_white.new(f1_arg0, f1_arg1, 0, 0, 249.5, 433.5, 0, 0, 120, 480)
	CallingCardsAssetbirdswhite:setXRot(180)
	CallingCardsAssetbirdswhite:setZRot(148)
	self:addElement(CallingCardsAssetbirdswhite)
	self.CallingCardsAssetbirdswhite = CallingCardsAssetbirdswhite
	local badcape = LUI.UIImage.new(0, 0, 542, 626, 0, 0, 82.5, 226.5)
	badcape:setAlpha(0.9)
	badcape:setImage(RegisterImage(0xF601B72E83B7B5))
	badcape:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD526D3FD71F281))
	badcape:setShaderVector(0, 0, 3, 0, 0)
	badcape:setShaderVector(1, 12, 0, 0, 0)
	self:addElement(badcape)
	self.badcape = badcape
	local badguy = LUI.UIImage.new(0, 0, 405, 597, 0, 0, -25, 279)
	badguy:setScale(1.05, 1.05)
	badguy:setImage(RegisterImage(0x6EDD9C05817CAE5))
	badguy:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD526D3FD71F281))
	badguy:setShaderVector(0, 0, 3, 0, 0)
	badguy:setShaderVector(1, 15, 0, 0, 0)
	self:addElement(badguy)
	self.badguy = badguy
	local heroCape = LUI.UIImage.new(0, 0, 120.5, 378.5, 0, 0, -17.5, 165.5)
	heroCape:setImage(RegisterImage(0x8ACF51C1F2FB6FB))
	heroCape:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD526D3FD71F281))
	heroCape:setShaderVector(0, 0, 3, 0, 0)
	heroCape:setShaderVector(1, 9, 0, 0, 0)
	self:addElement(heroCape)
	self.heroCape = heroCape
	local heroguy = LUI.UIImage.new(0, 0, 98, 490, 0, 0, 0, 240)
	heroguy:setRGB(0.96, 0.89, 0.59)
	heroguy:setImage(RegisterImage(0x1A918C6244C994E))
	heroguy:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD526D3FD71F281))
	heroguy:setShaderVector(0, 0, 3, 0, 0)
	heroguy:setShaderVector(1, 9, 0, 0, 0)
	self:addElement(heroguy)
	self.heroguy = heroguy
	local cropper = LUI.UIImage.new(0, 0, -32, 992, 0, 0, -392, 632)
	cropper:setAlpha(0)
	cropper:setImage(RegisterImage(0x7EEE1693E39382A))
	self:addElement(cropper)
	self.cropper = cropper
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD[0x6B87D0160EF7465].__resetProperties = function(f2_arg0)
	f2_arg0.heroguy:completeAnimation()
	f2_arg0.badguy:completeAnimation()
	f2_arg0.badcape:completeAnimation()
	f2_arg0.CallingCardsAssetbirdswhite:completeAnimation()
	f2_arg0.heroguy:setTopBottom(0, 0, 0, 240)
	f2_arg0.badguy:setLeftRight(0, 0, 405, 597)
	f2_arg0.badguy:setTopBottom(0, 0, -25, 279)
	f2_arg0.badguy:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD526D3FD71F281))
	f2_arg0.badguy:setShaderVector(0, 0, 3, 0, 0)
	f2_arg0.badguy:setShaderVector(1, 15, 0, 0, 0)
	f2_arg0.badcape:setLeftRight(0, 0, 542, 626)
	f2_arg0.badcape:setTopBottom(0, 0, 82.5, 226.5)
	f2_arg0.badcape:setImage(RegisterImage(0xF601B72E83B7B5))
	f2_arg0.badcape:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD526D3FD71F281))
	f2_arg0.badcape:setShaderVector(0, 0, 3, 0, 0)
	f2_arg0.badcape:setShaderVector(1, 12, 0, 0, 0)
	f2_arg0.CallingCardsAssetbirdswhite:setLeftRight(0, 0, 249.5, 433.5)
	f2_arg0.CallingCardsAssetbirdswhite:setTopBottom(0, 0, 120, 480)
end
CoD[0x6B87D0160EF7465].__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(4)
			local f3_local0 = function(f4_arg0)
				f3_arg0.CallingCardsAssetbirdswhite:playClip("DefaultClip")
				f3_arg0.CallingCardsAssetbirdswhite:beginAnimation(5030)
				f3_arg0.CallingCardsAssetbirdswhite:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.CallingCardsAssetbirdswhite:registerEventHandler("transition_complete_keyframe", function(element, event)
					element:playClip("DefaultClip")
					f3_arg0.clipFinished(element, event)
				end)
			end
			f3_arg0.CallingCardsAssetbirdswhite:completeAnimation()
			f3_arg0.CallingCardsAssetbirdswhite:setLeftRight(0, 0, 422.5, 606.5)
			f3_arg0.CallingCardsAssetbirdswhite:setTopBottom(0, 0, 171.5, 531.5)
			f3_local0(f3_arg0.CallingCardsAssetbirdswhite)
			f3_arg0.badcape:completeAnimation()
			f3_arg0.badcape:setLeftRight(0, 0, 529, 613)
			f3_arg0.badcape:setTopBottom(0, 0, 82.5, 226.5)
			f3_arg0.badcape:setImage(RegisterImage(0xF601B72E83B7B5))
			f3_arg0.badcape:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD526D3FD71F281))
			f3_arg0.badcape:setShaderVector(0, 0, 3, 0, 0)
			f3_arg0.badcape:setShaderVector(1, 15, 0, 0, 0)
			f3_arg0.clipFinished(f3_arg0.badcape)
			f3_arg0.badguy:completeAnimation()
			f3_arg0.badguy:setLeftRight(0, 0, 401, 593)
			f3_arg0.badguy:setTopBottom(0, 0, -24, 280)
			f3_arg0.badguy:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD526D3FD71F281))
			f3_arg0.badguy:setShaderVector(0, 0, 3, 0, 0)
			f3_arg0.badguy:setShaderVector(1, 15, 0, 0, 0)
			f3_arg0.clipFinished(f3_arg0.badguy)
			f3_arg0.heroguy:completeAnimation()
			f3_arg0.heroguy:setTopBottom(0, 0, 0, 240)
			f3_arg0.clipFinished(f3_arg0.heroguy)
			f3_arg0.nextClip = "DefaultClip"
		end,
	},
}
CoD[0x6B87D0160EF7465].__onClose = function(f6_arg0)
	f6_arg0.CallingCardsAssetbirdswhite:close()
end
