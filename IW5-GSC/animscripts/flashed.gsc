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

main(var_0) {
  self endon("killanimscript");
  self setflaggedanimknoball("flashed_anim", var_0, %body, 0.2, randomfloatrange(0.9, 1.1));
  animscripts\shared::donotetracks("flashed_anim");
}

main() {
  self endon("death");
  self endon("killanimscript");
  animscripts\utility::initialize("flashed");
  var_0 = maps\_utility::flashbanggettimeleftsec();

  if(var_0 <= 0) {
    return;
  }
  animscripts\face::saygenericdialogue("flashbang");

  if(isDefined(self.specialflashedfunc)) {
    self[[self.specialflashedfunc]]();
    return;
  }

  var_1 = _id_2092();
  turrettimer(var_1, var_0);
}

turrettimer(var_0, var_1) {
  self endon("death");
  self endon("killanimscript");

  if(self.a.pose == "prone") {
    animscripts\utility::exitpronewrapper(1);
  }
  self.a.pose = "stand";
  self.allowdeath = 1;
  thread main(var_0);
  wait(var_1);
  self notify("stop_flashbang_effect");
  self.flashed = 0;
}