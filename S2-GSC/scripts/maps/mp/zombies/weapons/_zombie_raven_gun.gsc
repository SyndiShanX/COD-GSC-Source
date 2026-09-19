/*****************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\zombies\weapons\_zombie_raven_gun.gsc
*****************************************************************/

init() {
  level.ravengunisactive = 0;
  common_scripts\utility::flag_init("flag_outlaw_raven_puzzle_complete");
  common_scripts\utility::_id_3C9F("flag_outlaw_raven_puzzle_complete");
  thread raven_gun_delayed_init();
  _id_054D::_id_7BC6(::raven_gun_check_for_crit);
  _id_0547::_id_7BA9(::raven_gun_pap_check_for_crit_kill);
}

raven_gun_delayed_init() {
  while(!isDefined(level._id_62B3))
    waitframe();

  level._id_62B3["raven_gun_zm"] = ::raven_gun_modify_damage;
  level._id_62B3["raven_gun_pap_zm"] = ::raven_gun_modify_damage;
}

raven_gun_modify_damage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(!isDefined(var_0._id_0A4B))
    return var_2;

  if(var_0[[var_0 maps\mp\agents\_agent_utility::_id_0A59("is_hit_weak_point")]](self, var_1, var_1, var_2, var_3, var_4, undefined, var_6, var_7))
    return var_2 * 4;

  return var_2;
}

raven_gun_check_for_crit(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  if(!isDefined(var_1)) {
    return;
  }
  if(!isPlayer(var_1)) {
    return;
  }
  var_1 endon("disconnect");

  if(!isDefined(var_5)) {
    return;
  }
  if(!issubstr(var_5, "raven_gun_")) {
    return;
  }
  if(!self[[maps\mp\agents\_agent_utility::_id_0A59("is_hit_weak_point")]](self, var_0, var_1, var_2, var_4, var_5, undefined, var_7, var_8)) {
    return;
  }
  raven_gun_refund_ammo(var_1, var_5);
}

raven_gun_refund_ammo(var_0, var_1) {
  var_2 = var_0 getweaponammoclip(var_1);
  var_0 setweaponammoclip(var_1, var_2 + 1);
}

raven_gun_pap_check_for_crit_kill(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(level.ravengunisactive) {
    return;
  }
  if(!isDefined(var_1)) {
    return;
  }
  if(!isPlayer(var_1)) {
    return;
  }
  if(!self[[maps\mp\agents\_agent_utility::_id_0A59("is_hit_weak_point")]](self, var_0, var_1, var_2, var_3, var_4, undefined, var_5, var_6)) {
    return;
  }
  if(!issubstr(var_4, "raven_gun_pap_zm")) {
    return;
  }
  level.ravengunisactive = 1;
  var_9 = spawn("script_model", self.origin + (0, 0, 64));
  var_9.angles = (0, var_1.angles[1], 180);
  var_9 setModel("tag_origin");
  raven_feather_poof(var_9.origin);
  var_9.ravenfx = _func_147(common_scripts\utility::_id_44F5("raven_fly"), var_9, "tag_origin");
  var_10 = _func_0A5(var_9.origin[0] - 32, var_9.origin[0] + 32);
  var_11 = _func_0A5(var_9.origin[1] - 32, var_9.origin[1] + 32);
  var_12 = _func_0A5(var_9.origin[2] + 32, var_9.origin[2] + 64);
  var_9 _meth_82B1((var_10, var_11, var_12), 2, 0.5, 1.5);
  wait 2;
  var_9 raven_seek_targets(var_1, var_4, var_3);
  level.ravengunisactive = 0;
}

raven_seek_targets(var_0, var_1, var_2) {
  for(var_3 = 0; var_3 < 5; var_3++) {
    var_4 = undefined;
    var_4 = common_scripts\utility::_id_4461(self.origin, _id_0547::_id_408F(), 200);

    if(isDefined(var_4)) {
      self _meth_82B1(var_4.origin + (0, 0, 48), 0.15);
      wait 0.15;
      var_5 = maps\mp\gametypes\zombies::_id_1E59(_id_0547::_id_0A51("zombie_generic"), level._id_A980);
      var_4 _meth_8059(var_5, self.origin, var_0, var_0, var_2, var_1);
      raven_feather_poof(var_4.origin);
    }

    waitframe();

    if(!isDefined(var_4) || isalive(var_4)) {
      raven_feather_poof(self.origin);
      break;
    }

    waitframe();
  }

  if(isDefined(self.ravenfx))
    self.ravenfx delete();

  self delete();
}

raven_feather_poof(var_0) {
  playFX(common_scripts\utility::_id_44F5("zmb_desc_raven_feathers_pop"), var_0);
}