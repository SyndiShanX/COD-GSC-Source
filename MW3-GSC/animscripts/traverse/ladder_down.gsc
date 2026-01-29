/************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\traverse\ladder_down.gsc
************************************************/

#using_animtree("generic_human");

main() {
  self._id_247C = "crouch";
  animscripts\utility::_id_247B();
  self endon("killanimscript");
  self traversemode("nogravity");
  self traversemode("noclip");
  var_0 = self getnegotiationendnode();
  var_1 = var_0.origin;
  var_2 = self getnegotiationstartnode();
  self orientmode("face angle", var_2.angles[1]);
  var_3 = 1;

  if(isDefined(self._id_0FC6)) {
    var_3 = self._id_0FC6;

  }
  self setflaggedanimknoballrestart("climbanim", % ladder_climbon, % body, 1, 0.1, var_3);
  animscripts\shared::_id_0C51("climbanim");
  var_4 = % ladder_climbdown;
  self setflaggedanimknoballrestart("climbanim", var_4, % body, 1, 0.1, var_3);
  var_5 = getmovedelta(var_4, 0, 1);
  var_6 = var_5[2] * var_3 / getanimlength(var_4);
  var_7 = (var_1[2] - self.origin[2]) / var_6;
  animscripts\notetracks::_id_0D4F(var_7, "climbanim");
  self traversemode("gravity");
  self.a._id_0D2B = "stop";
  self.a._id_0D26 = "stand";
}