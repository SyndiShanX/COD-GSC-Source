/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1374.gsc
**************************************/

init() {
  level._id_0A41["zombie_boss"] = level._id_0A41["zombie"];
  level._id_0A41["zombie_boss"]["think"] = ::_id_AB60;
  level._id_0A41["zombie_boss"]["move_mode"] = ::_id_AB5F;
  level._id_0A41["zombie_boss"]["get_action_params"] = ::_id_AB5D;
  level._id_0A41["zombie_boss"]["tesla_delayed_dmg"] = ::zombie_boss_tesla_delayed_dmg;
  var_0 = spawnStruct();
  var_0._id_0A4B = "zombie_boss";
  var_0._id_0EAE = "zombie_boss_animclass";
  var_0._id_0879 = "zombie_boss";
  var_0._id_5ED2["default"]["whole_body"] = "zom_brute_b_base";
  var_0._id_5ED2["default"]["heads"] = ["zom_head_fdr02_org1"];
  var_0._id_4C12 = 1;
  var_0._id_7F1A = 15000;
  var_0._id_60E2 = 40;
  var_0.parenttype = "zombie_generic";
  _id_0547::_id_0A52(var_0, "zombie_boss");
}

_id_AB5F() {
  return "walk";
}

_id_AB5D() {
  var_0 = _id_054D::_id_AC22();
  return var_0;
}

zombie_boss_tesla_delayed_dmg(var_0, var_1, var_2) {
  return var_0;
}

_id_AB61() {
  maps\mp\agents\humanoid\_humanoid::_id_8A27();
  thread _id_054D::_id_A146();
}

_id_AB60() {
  self endon("death");
  level endon("game_ended");
  self endon("owner_disconnect");
  _id_AB61();

  for(;;) {
    self scragentsetgoalpos(self.origin);
    wait 0.5;
  }
}

_id_AAF6() {}