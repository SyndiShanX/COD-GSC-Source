/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2445.gsc
*************************************************/

init() {
  level._effect["energy_mine_effect"] = loadfx("vfx/s4/zombie_weapon/vfx_fld_energy_mine");
  level._effect["energy_mine_trigger"] = loadfx("vfx/s4/zombie_weapon/vfx_fld_energy_mine_trigger");
  level._effect["energy_mine_trigger_pulse"] = loadfx("vfx/s4/zombie_weapon/vfx_fld_energy_mine_trigger_pulse");
  level._effect["energy_mine_trigger_large_pulse"] = loadfx("vfx/s4/zombie_weapon/vfx_fld_energy_mine_trigger_pulse_lg");
  level._effect["energy_mine_stun"] = loadfx("vfx/s4/zombie_weapon/vfx_fld_energy_mine_stun_zmb_torso");
  level._effect["energy_mine_stun_lg"] = loadfx("vfx/s4/zombie_weapon/vfx_fld_energy_mine_stun_zmb_torso_lg");
  _id_06CB::_id_AA4A(::energy_mine_kill_zombie);
  _id_06CB::_id_AA65(::energy_mine_player_setup);
}

energy_mine_kill_zombie(var_0) {
  if(!isPlayer(var_0._id_50FF) || var_0._id_DE2B != "MOD_EXPLOSIVE" || var_0._id_04F6.basename != "s4_energy_mine_zm") {
    return;
  }
  if(getdvarint("#x3ce6f1c71a4bdefaa", 0) == 1) {
    if(_id_06FE::is_zm_normal()) {
      var_1 = vectornormalize((var_0._id_FFD4[0], var_0._id_FFD4[1], 0)) * 1000;
      var_1 = (var_1[0], var_1[1], 0);
      self._id_BF53 = var_1;
      self._id_BF52 = "torso_lower";
    }
  }
}

energy_mine_player_setup() {
  scripts\engine\utility::_id_5473("zm_field_upgrade_in_use");
  level scripts\engine\utility::_id_5473("energy_mine_in_use");
}

set_energy_mine() {
  var_0 = get_energy_mine_level();

  if(var_0 >= 3) {
    var_1 = _id_0766::getcurrentsuper();
    var_1._id_9C5C = 3;
  }
}

_id_4BF5() {
  scripts\engine\utility::_id_5474("zm_field_upgrade_in_use");
  var_0 = anglesToForward(self.angles);
  var_1 = (0, 0, 1);
  var_2 = self.origin + var_1 * 40 + var_0 * 15;
  var_3 = var_0 * 400 + self getvelocity();
  var_4 = magicgrenademanual("s4_energy_mine_zm", var_2, var_3, 99999, self);
  self playlocalsound("zmb_energy_mine_use_st");
  self playsoundtoteam("zmb_energy_mine_use_m", self.team, self);

  if(isDefined(var_4)) {
    var_4 thread track_mine();
    var_5 = var_4 _id_606D("energy_mine_effect", "tag_origin");

    if(isDefined(var_4)) {
      var_4 delete();
    }

    if(!isDefined(var_5)) {
      return 0;
    }

    var_4 = var_5;
    thread watch_mine(var_4);
  } else
    return 0;

  return 1;
}

watch_mine(var_0) {
  var_0 endon("death");
  var_1 = get_energy_mine_level();
  var_2 = get_num_bonus_detonations(var_1);
  var_0 thread watch_for_portal_activation();
  var_0 playSound("zmb_energy_mine_placed");
  var_0 playLoopSound("zmb_energy_mine_lp");
  var_0 _id_10709(self, 64);
  var_0 stoploopsound("zmb_energy_mine_lp");
  var_0 playSound("zmb_energy_mine_trip_explo");

  if(isDefined(var_0)) {
    var_0 notify("starting_detonation");
    stopFXOnTag(scripts\engine\utility::getfx("energy_mine_effect"), var_0, "tag_origin");
    play_explosion_fx(var_0);
    wait 0.6;

    if(isPlayer(self)) {
      var_0 do_explosion(self);
    }

    for(var_3 = 0; var_3 < var_2; var_3++) {
      wait 0.5;

      if(isPlayer(self)) {
        switch (var_3) {
          case 0:
            var_0 playSound("zmb_energy_mine_explo_2");
            break;
          case 1:
            var_0 playSound("zmb_energy_mine_explo_3");
            break;
        }

        var_0 do_explosion(self);
        continue;
      }

      break;
    }

    var_0 delete();
  }
}

track_mine() {
  self endon("death");
  thread watch_for_portal_activation();

  for(;;) {
    thread scripts\cp\utility::_id_4F48(self.origin, 10, 5, (1, 0, 0));
    waitframe();
  }
}

get_num_bonus_detonations(var_0) {
  if(var_0 >= 2) {
    return 2;
  }

  return 0;
}

get_explosion_radius(var_0) {
  if(var_0 >= 4) {
    return 500;
  } else {
    return 300;
  }
}

get_energy_mine_level() {
  return scripts\cp\utility::_id_459B(self.super_level, 0);
}

do_explosion(var_0) {
  var_1 = var_0 get_energy_mine_level();
  var_2 = var_1 >= 1;
  var_3 = get_explosion_radius(var_1);
  var_0 radiusdamage(self.origin, var_3, 300, 300, var_0, "MOD_EXPLOSIVE", "s4_energy_mine_zm");

  if(istrue(var_2)) {
    var_4 = scripts\cp\utility::_id_66CD(var_3, self.origin);
    thread _id_5437(var_0, var_4, self.origin);
  }
}

play_explosion_fx(var_0) {
  var_1 = get_energy_mine_level();

  if(var_1 >= 4) {
    playFXOnTag(scripts\engine\utility::getfx("energy_mine_trigger_large_pulse"), var_0, "tag_origin");
  } else if(var_1 >= 2) {
    playFXOnTag(scripts\engine\utility::getfx("energy_mine_trigger_pulse"), var_0, "tag_origin");
  } else {
    playFXOnTag(scripts\engine\utility::getfx("energy_mine_trigger"), var_0, "tag_origin");
  }
}

_id_5437(var_0, var_1, var_2) {
  foreach(var_4 in var_1) {
    if(!isalive(var_4)) {
      continue;
    }
    switch (var_4.zm_ai_category) {
      case "special":
      case "normal":
        var_4 thread play_stun_fx();
        var_4 scripts\aitypes\zombie_common\stun::stun(3);
        _id_072A::addplayereffects("energy_mine_stun", var_4, var_0, 3);
        var_0 _id_0752::_id_7003("energy_mine_stunned_enemy", undefined, undefined, undefined, var_4);
        break;
      default:
        if(var_4._id_110B0 == "trickster") {
          thread scripts\aitypes\zombie_trickster\trickster::play_cc_immune_vo();
        }

        break;
    }

    waitframe();
  }
}

_id_606D(var_0, var_1, var_2) {
  self endon("starting_detonation");
  scripts\engine\utility::_id_108A8(3, "death", "missile_stuck");

  if(!isDefined(self)) {
    return;
  }
  var_3 = (0, 0, 1);
  var_4 = scripts\engine\utility::spawn_tag_origin(self.origin + var_3, self.angles);
  var_4 show();
  waitframe();

  if(isDefined(var_2)) {
    wait(var_2);
  }

  playFXOnTag(scripts\engine\utility::getfx(var_0), var_4, var_1);
  return var_4;
}

watch_for_portal_activation() {
  self endon("death");
  level waittill("portal_activated");
  self stoploopsound("zmb_energy_mine_lp");
  waitframe();
  self delete();
}

_id_10709(var_0, var_1) {
  self endon("death");

  for(;;) {
    var_2 = scripts\cp\utility::_id_66CD(var_1, self.origin);

    if(var_2.size) {
      return;
    }
    waitframe();
  }
}

_id_AA52(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14) {
  if(isent(var_0) && isPlayer(var_1)) {
    self._id_5436 = var_0.origin;
  }
}

play_stun_fx() {
  level endon("game_ended");
  self endon("death");

  switch (self._id_110B0) {
    case "trickster":
    case "base":
    case "screamer":
      playFXOnTag(scripts\engine\utility::getfx("energy_mine_stun"), self, "j_spine4");
      break;
    case "juggernaut":
      playFXOnTag(scripts\engine\utility::getfx("energy_mine_stun_lg"), self, "j_spine4");
      break;
  }

  wait 3;

  switch (self._id_110B0) {
    case "trickster":
    case "base":
    case "screamer":
      stopFXOnTag(scripts\engine\utility::getfx("energy_mine_stun"), self, "j_spine4");
      break;
    case "juggernaut":
      stopFXOnTag(scripts\engine\utility::getfx("energy_mine_stun_lg"), self, "j_spine4");
      break;
  }
}