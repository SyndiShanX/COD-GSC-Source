/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\flashed.gsc
**************************************/

#using_animtree("generic_human");

_id_208E() {
  anim._id_208F[0] = % exposed_flashbang_v1;
  anim._id_208F[1] = % exposed_flashbang_v2;
  anim._id_208F[2] = % exposed_flashbang_v3;
  anim._id_208F[3] = % exposed_flashbang_v4;
  anim._id_208F[4] = % exposed_flashbang_v5;
  _id_2091();
  anim._id_2090 = 0;
}

_id_2091() {
  for(var_0 = 0; var_0 < anim._id_208F.size; var_0++) {
    var_1 = randomint(anim._id_208F.size);
    var_2 = anim._id_208F[var_0];
    anim._id_208F[var_0] = anim._id_208F[var_1];
    anim._id_208F[var_1] = var_2;
  }
}

_id_2092() {
  anim._id_2090++;

  if(anim._id_2090 >= anim._id_208F.size) {
    anim._id_2090 = 0;
    _id_2091();
  }

  return anim._id_208F[anim._id_2090];
}

_id_2093(var_0) {
  self endon("killanimscript");
  self setflaggedanimknoball("flashed_anim", var_0, %body, 0.2, randomfloatrange(0.9, 1.1));
  animscripts\shared::_id_0C51("flashed_anim");
}

main() {
  self endon("death");
  self endon("killanimscript");
  animscripts\utility::_id_0D15("flashed");
  var_0 = maps\_utility::_id_2094();

  if(var_0 <= 0) {
    return;
  }
  animscripts\face::_id_0C41("flashbang");

  if(isDefined(self._id_2095)) {
    self[[self._id_2095]]();
    return;
  }

  var_1 = _id_2092();
  _id_2096(var_1, var_0);
}

_id_2096(var_0, var_1) {
  self endon("death");
  self endon("killanimscript");

  if(self.a._id_0D26 == "prone") {
    animscripts\utility::_id_0F7D(1);
  }
  self.a._id_0D26 = "stand";
  self.allowdeath = 1;
  thread _id_2093(var_0);
  wait(var_1);
  self notify("stop_flashbang_effect");
  self._id_2097 = 0;
}