require("x64:7889ce1e3e2e8a")
CoD.ItemShopBackgroundBlur = InheritFrom(LUI.UIElement)
CoD.ItemShopBackgroundBlur.__defaultWidth = 1920
CoD.ItemShopBackgroundBlur.__defaultHeight = 1080
CoD.ItemShopBackgroundBlur.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ItemShopBackgroundBlur)
	self.id = "ItemShopBackgroundBlur"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local SceneBlur = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	SceneBlur:setRGB(0, 0, 0)
	SceneBlur:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_E2354BE557C4C7A"))
	SceneBlur:setShaderVector(0, 0, 0.4, 0, 0)
	self:addElement(SceneBlur)
	self.SceneBlur = SceneBlur
	local Background = CoD.StartMenuOptionsBackground.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(Background)
	self.Background = Background
	local BGEnhancement = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	BGEnhancement:setRGB(0, 0, 0)
	BGEnhancement:setAlpha(0.2)
	self:addElement(BGEnhancement)
	self.BGEnhancement = BGEnhancement
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ItemShopBackgroundBlur.__resetProperties = function(f2_arg0)
	f2_arg0.SceneBlur:completeAnimation()
	f2_arg0.Background:completeAnimation()
	f2_arg0.BGEnhancement:completeAnimation()
	f2_arg0.SceneBlur:setAlpha(1)
	f2_arg0.Background:setAlpha(1)
	f2_arg0.BGEnhancement:setAlpha(0.2)
end
CoD.ItemShopBackgroundBlur.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(0)
		end,
	},
	Hidden = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(3)
			f4_arg0.SceneBlur:completeAnimation()
			f4_arg0.SceneBlur:setAlpha(0)
			f4_arg0.clipFinished(f4_arg0.SceneBlur)
			f4_arg0.Background:completeAnimation()
			f4_arg0.Background:setAlpha(0)
			f4_arg0.clipFinished(f4_arg0.Background)
			f4_arg0.BGEnhancement:completeAnimation()
			f4_arg0.BGEnhancement:setAlpha(0)
			f4_arg0.clipFinished(f4_arg0.BGEnhancement)
		end,
	},
}
CoD.ItemShopBackgroundBlur.__onClose = function(f5_arg0)
	f5_arg0.Background:close()
end
