CoD.AnimationLoadingWidget = InheritFrom(LUI.UIElement)
CoD.AnimationLoadingWidget.__defaultWidth = 216
CoD.AnimationLoadingWidget.__defaultHeight = 216
CoD.AnimationLoadingWidget.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.AnimationLoadingWidget)
	self.id = "AnimationLoadingWidget"
	self.soundSet = "Special_widgets"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Base = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Base:setImage(RegisterImage("t7_menu_loadingspinner_flipbook"))
	Base:setMaterial(LUI.UIImage.GetCachedMaterial("uie_flipbook_animated"))
	Base:setShaderVector(0, 28, 1, 0, 0)
	Base:setShaderVector(1, 0, 0, 0, 0)
	self:addElement(Base)
	self.Base = Base
	local Add = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Add:setAlpha(0.8)
	Add:setImage(RegisterImage("t7_menu_loadingspinner_flipbook"))
	Add:setMaterial(LUI.UIImage.GetCachedMaterial("uie_flipbook_animated"))
	Add:setShaderVector(0, 28, 1, 0, 0)
	Add:setShaderVector(1, 0, 0, 0, 0)
	self:addElement(Add)
	self.Add = Add
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.AnimationLoadingWidget.__resetProperties = function(f2_arg0)
	f2_arg0.Add:completeAnimation()
	f2_arg0.Base:completeAnimation()
	f2_arg0.Add:setMaterial(LUI.UIImage.GetCachedMaterial("uie_flipbook_animated"))
	f2_arg0.Add:setShaderVector(0, 28, 1, 0, 0)
	f2_arg0.Add:setShaderVector(1, 0, 0, 0, 0)
	f2_arg0.Base:setMaterial(LUI.UIImage.GetCachedMaterial("uie_flipbook_animated"))
	f2_arg0.Base:setShaderVector(0, 28, 1, 0, 0)
	f2_arg0.Base:setShaderVector(1, 0, 0, 0, 0)
end
CoD.AnimationLoadingWidget.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(2)
			local f3_local0 = function(f4_arg0)
				f3_arg0.Base:beginAnimation(1000)
				f3_arg0.Base:setShaderVector(1, 28, 0, 0, 0)
				f3_arg0.Base:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.Base:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
			end
			f3_arg0.Base:completeAnimation()
			f3_arg0.Base:setMaterial(LUI.UIImage.GetCachedMaterial("uie_flipbook_animated"))
			f3_arg0.Base:setShaderVector(0, 28, 1, 0, 0)
			f3_arg0.Base:setShaderVector(1, 0, 0, 0, 0)
			f3_local0(f3_arg0.Base)
			local f3_local1 = function(f5_arg0)
				f3_arg0.Add:beginAnimation(1000)
				f3_arg0.Add:setShaderVector(1, 28, 0, 0, 0)
				f3_arg0.Add:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.Add:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
			end
			f3_arg0.Add:completeAnimation()
			f3_arg0.Add:setMaterial(LUI.UIImage.GetCachedMaterial("uie_flipbook_animated"))
			f3_arg0.Add:setShaderVector(0, 28, 1, 0, 0)
			f3_arg0.Add:setShaderVector(1, 0, 0, 0, 0)
			f3_local1(f3_arg0.Add)
			f3_arg0.nextClip = "DefaultClip"
		end,
	},
}
