/*********************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\zombies\weapons\_zombie_raven_gun.gsc
*********************************************************/

func_00D5() {
  level.ravengunisactive = 0;
  common_scripts\utility::func_3C87("flag_outlaw_raven_puzzle_complete");
  common_scripts\utility::func_3C9F("flag_outlaw_raven_puzzle_complete");
  thread raven_gun_delayed_init();
  lib_054D::func_7BC6(::raven_gun_check_for_crit);
  lib_0547::func_7BA9(::raven_gun_pap_check_for_crit_kill);
}

raven_gun_delayed_init() {
  while(!isDefined(level.var_62B3)) {
    wait 0.05;
  }

  level.var_62B3["raven_gun_zm"] = ::raven_gun_modify_damage;
  level.var_62B3["raven_gun_pap_zm"] = ::raven_gun_modify_damage;
}

raven_gun_modify_damage(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07) {
  if(!isDefined(param_00.var_A4B)) {
    return param_02;
  }

  if(param_00[[param_00 maps\mp\agents\_agent_utility::func_A59("is_hit_weak_point")]](self, param_01, param_01, param_02, param_03, param_04, undefined, param_06, param_07)) {
    return param_02 * 4;
  }

  return param_02;
}

raven_gun_check_for_crit(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A) {
  if(!isDefined(param_01)) {
    return;
  }

  if(!isPlayer(param_01)) {
    return;
  }

  param_01 endon("disconnect");
  if(!isDefined(param_05)) {
    return;
  }

  if(!issubstr(param_05, "raven_gun_")) {
    return;
  }

  if(!self[[maps\mp\agents\_agent_utility::func_A59("is_hit_weak_point")]](self, param_00, param_01, param_02, param_04, param_05, undefined, param_07, param_08)) {
    return;
  }

  raven_gun_refund_ammo(param_01, param_05);
}

raven_gun_refund_ammo(param_00, param_01) {
  var_02 = param_00 getweaponammoclip(param_01);
  param_00 method_82FA(param_01, var_02 + 1);
}

raven_gun_pap_check_for_crit_kill(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08) {
  if(level.ravengunisactive) {
    return;
  }

  if(!isDefined(param_01)) {
    return;
  }

  if(!isPlayer(param_01)) {
    return;
  }

  if(!self[[maps\mp\agents\_agent_utility::func_A59("is_hit_weak_point")]](self, param_00, param_01, param_02, param_03, param_04, undefined, param_05, param_06)) {
    return;
  }

  if(!issubstr(param_04, "raven_gun_pap_zm")) {
    return;
  }

  level.ravengunisactive = 1;
  var_09 = spawn("script_model", self.var_116 + (0, 0, 64));
  var_09.var_1D = (0, param_01.var_1D[1], 180);
  var_09 setModel("tag_origin");
  raven_feather_poof(var_09.var_116);
  var_09.ravenfx = playFXOnTag(common_scripts\utility::func_44F5("raven_fly"), var_09, "tag_origin");
  var_0A = randomfloatrange(var_09.var_116[0] - 32, var_09.var_116[0] + 32);
  var_0B = randomfloatrange(var_09.var_116[1] - 32, var_09.var_116[1] + 32);
  var_0C = randomfloatrange(var_09.var_116[2] + 32, var_09.var_116[2] + 64);
  var_09 moveto((var_0A, var_0B, var_0C), 2, 0.5, 1.5);
  wait(2);
  var_09 raven_seek_targets(param_01, param_04, param_03);
  level.ravengunisactive = 0;
}

raven_seek_targets(param_00, param_01, param_02) {
  for(var_03 = 0; var_03 < 5; var_03++) {
    var_04 = undefined;
    var_04 = common_scripts\utility::func_4461(self.var_116, lib_0547::func_408F(), 200);
    if(isDefined(var_04)) {
      self moveto(var_04.var_116 + (0, 0, 48), 0.15);
      wait(0.15);
      var_05 = maps\mp\gametypes\zombies::func_1E59(lib_0547::func_A51("zombie_generic"), level.var_A980);
      var_04 dodamage(var_05, self.var_116, param_00, param_00, param_02, param_01);
      raven_feather_poof(var_04.var_116);
    }

    wait 0.05;
    if(!isDefined(var_04) || isalive(var_04)) {
      raven_feather_poof(self.var_116);
      break;
    }

    wait 0.05;
  }

  if(isDefined(self.ravenfx)) {
    self.ravenfx delete();
  }

  self delete();
}

raven_feather_poof(param_00) {
  playFX(common_scripts\utility::func_44F5("zmb_desc_raven_feathers_pop"), param_00);
}