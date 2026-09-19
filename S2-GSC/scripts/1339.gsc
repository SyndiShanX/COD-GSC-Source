/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1339.gsc
**************************************/

init() {
  self._id_983B = 0;
  level._effect["taunt_burst_aoe"] = loadfx("vfx/zombie/abilities_perks/zmb_storm_taunt_aoe");
  level._effect["taunt_lure"] = loadfx("vfx/zombie/abilities_perks/zmb_storm_zmb_lure");
  level._effect["zmb_moon_zmb_instakill"] = loadfx("vfx/zombie/abilities_perks/zmb_moon_zmb_instakill");
  level._effect["zmb_death_hand_to_hand_melee_hit"] = loadfx("vfx/zombie/abilities_perks/zmb_death_hand_to_hand_melee_hit");
}

_id_3662() {
  _id_054B::_id_6AB2("role_ability_taunt_zm");
  self._id_983B = 1;
  var_0 = self.origin;
  var_1 = 0;
  playFX(common_scripts\utility::_id_44F5("taunt_burst_aoe"), var_0 + (0, 0, var_1));
  _id_0378::_id_8D74("aud_taunt_use");
  var_2 = _id_0547::_id_408F();

  foreach(var_4 in var_2)
  thread _id_983E(var_4);

  if(_id_0547::_id_4BA7("specialty_class_improvised_def_zm")) {
    var_6 = _id_0547::_id_73E9() + 2;
    _id_0547::_id_7454(int(_func_0AF(var_6, 3)));
  }

  if(_id_0547::_id_4BA7("specialty_class_resilient_zm"))
    self._id_98E1 = 1;

  if(_id_0547::_id_4BA7("specialty_class_team_effort_zm")) {
    foreach(var_8 in level.players) {
      if(var_8 == self) {
        continue;
      }
      var_8 _meth_866C(&"add_teammate_mod_buffs", 3, "specialty_class_team_effort_zm", 0, self);
    }
  }

  thread _id_A95A();
}

_id_2F9E() {
  if(common_scripts\utility::_id_562E(self._id_983B)) {
    self notify("taunt_expired");
    self._id_983B = 0;

    if(_id_0547::_id_4BA7("specialty_class_resilient_zm"))
      self._id_98E1 = undefined;

    if(_id_0547::_id_4BA7("specialty_class_team_effort_zm")) {
      foreach(var_1 in level.players) {
        if(var_1 == self) {
          continue;
        }
        var_1 _meth_866C(&"remove_teammate_mod_buffs", 1, "specialty_class_team_effort_zm");
      }
    }
  }
}

_id_983E(var_0) {
  if(common_scripts\utility::_id_562E(var_0._id_57FD)) {
    return;
  }
  var_0 endon("death");
  self endon("disconnect");
  thread handlezombietauntfx(var_0, "taunt_lure", "J_Spine4", 1.5);
  var_0 maps\mp\agents\humanoid\_humanoid_util::_id_867E(self);
  var_0 notify("watchFavoriteEnemyDeath");

  if(!isDefined(var_0._id_983C))
    var_0._id_983C = [];

  var_0._id_983C = common_scripts\utility::_id_0F6F(var_0._id_983C, self);
  common_scripts\utility::_id_A70A("taunt_expired", "disconnect");
  var_0 maps\mp\agents\humanoid\_humanoid_util::_id_867E(undefined);
  var_0._id_983C = common_scripts\utility::_id_0F93(var_0._id_983C, self);
}

handlezombietauntfx(var_0, var_1, var_2, var_3) {
  var_0 notify("taunt_fx_thread");
  self endon("disconnect");
  self endon("taunt_expired");
  var_0 endon("death");
  var_0 endon("taunt_fx_thread");

  for(;;) {
    var_4 = gettime() / 1000;

    if(isDefined(self.recenttauntfxtime) && var_4 - var_0.recenttauntfxtime < var_3)
      wait(var_3 - (var_4 - var_0.recenttauntfxtime));

    _func_147(common_scripts\utility::_id_44F5(var_1), var_0, var_2);
    var_0.recenttauntfxtime = var_4;
    wait(var_3);
  }
}

_id_A95A() {
  self endon("taunt_expired");

  for(;;) {
    level waittill("zombie_spawned", var_0);
    thread _id_983E(var_0);
  }
}

_id_62A6(var_0, var_1, var_2) {
  var_3 = 1;

  if(!common_scripts\utility::_id_562E(self._id_57FD) && isDefined(self._id_983C)) {
    foreach(var_5 in self._id_983C) {
      var_6 = 2;

      if(var_5 _id_0547::_id_4BA7("specialty_class_counter_offensive_zm"))
        var_6 = 3;

      if(var_5 _id_0547::_id_4BA7("specialty_class_team_effort_zm"))
        var_3 = max(var_6, var_3);

      if(var_5 == var_1)
        var_3 = max(var_6, var_3);
    }

    if(maps\mp\_utility::_id_5755(var_2) && common_scripts\utility::_id_562E(var_1._id_983B) && var_1 _id_0547::_id_4BA7("specialty_class_come_get_zm")) {
      var_3 = var_3 * 4;
      thread play_crit_melee_effects();
      var_1 _meth_866C(&"trigger_mod_proc", 1, "specialty_class_come_get_zm");
    }
  }

  if(isDefined(var_3))
    var_0 = var_0 * var_3;

  return var_0;
}

play_crit_melee_effects() {
  self waittill("body_spawned", var_0);

  if(!isDefined(var_0)) {
    return;
  }
  var_1 = _func_2A8(level._effect["zmb_death_hand_to_hand_melee_hit"], var_0, "J_Head");
  _func_14C(var_1);
  wait 1;
  var_1 delete();
}

_id_6B73(var_0) {
  if(isDefined(var_0) && _func_0C1(var_0) && common_scripts\utility::_id_562E(self._id_983B) && _id_0547::_id_4BA7("specialty_class_hit_em_hard_zm")) {
    playFX(level._effect["zmb_moon_zmb_instakill"], var_0.origin + (0, 0, 40));
    var_1 = var_0.health + 1;
    var_2 = 0;

    if(isDefined(var_0._id_0A4B)) {
      switch (var_0._id_0A4B) {
        case "zombie_heavy":
        case "zombie_boss_village":
        case "zombie_fireman":
          var_2 = 1;
          break;
      }
    }

    if(common_scripts\utility::_id_562E(var_0._id_55AB))
      var_2 = 1;

    if(var_2)
      var_1 = maps\mp\gametypes\zombies::_id_1E59(_id_0547::_id_0A51("zombie_generic"), level._id_A980);

    var_0 thread _id_AB11(0.1, var_1, var_0.origin, self, undefined, undefined, "hitem_hard_zm");
    self _meth_866C(&"trigger_mod_proc", 1, "specialty_class_hit_em_hard_zm");
  }
}

_id_AB11(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  self endon("death");

  if(!isDefined(var_0) || var_0 < 0.05)
    var_0 = 1;

  wait(var_0);
  self _meth_8059(var_1, var_2, var_3, var_4, var_5, var_6);
}