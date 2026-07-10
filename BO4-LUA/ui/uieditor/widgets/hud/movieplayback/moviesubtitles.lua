CoD.MovieSubtitles = InheritFrom(LUI.UIElement)
CoD.MovieSubtitles.__defaultWidth = 1920
CoD.MovieSubtitles.__defaultHeight = 1080
CoD.MovieSubtitles.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.MovieSubtitles)
	self.id = "MovieSubtitles"
	self.soundSet = "default"
	local MovieSubtitles = LUI.UIElement.new(0.5, 0.5, -567, 567, 0, 0, 891, 929)
	MovieSubtitles:setupCinematicSubtitles()
	self:addElement(MovieSubtitles)
	self.MovieSubtitles = MovieSubtitles
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
