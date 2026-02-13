/****************************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\cp\zombies\zm_field_upgrades_frost_blast.gsc
****************************************************************/

init() {
  level._effect["frost_blast_aoe"] = loadfx("vfx/s4/zombie_weapon/vfx_fld_frost_blast.vfx");
  level._effect["frost_blast_aoe_large"] = loadfx("vfx/s4/zombie/vfx_fld_frost_blast_lg.vfx");
  level._effect["frost_blast_slow"] = loadfx("vfx/s4/zombie_weapon/vfx_fld_frost_blast_frozen_zmb_torso_loop.vfx");
  level._effect["frost_blast_large_slow"] = loadfx("vfx/s4/zombie_weapon/vfx_fld_frost_blast_frozen_zmb_torso_lg_loop.vfx");
  level._effect["frost_blast_slow_end"] = loadfx("vfx/s4/zombie_weapon/vfx_fld_frost_blast_frozen_zmb_torso_end.vfx");
  level._effect["frost_blast_slow_lg_end"] = loadfx("vfx/s4/zombie_weapon/vfx_fld_frost_blast_frozen_zmb_torso_lg_end.vfx");
  _id_06CB::_id_AA65(::frost_blast_player_setup);
}

frost_blast_player_setup() {
  scripts\engine\utility::_id_5473("zm_field_upgrade_in_use");
}

set_frost_blast() {
  var_0 = get_frost_blast_level();
  var_1 = var_0 >= 4;

  if(var_1 && !scripts\engine\utility::array_contains(level.flat_damage_callbacks, ::apply_freezing_instakill_damage)) {
    level.flat_damage_callbacks = scripts\engine\utility::array_add(level.damage_multiplier_callbacks, ::apply_freezing_instakill_damage);
  }

  if(var_0 >= 3) {
    var_2 = _id_0766::getcurrentsuper();
    var_2._id_9C5C = 3;
  }
}

unset_frost_blast() {
  var_0 = 0;

  foreach(var_2 in level.players) {
    var_3 = var_2 get_frost_blast_level();

    if(var_3 >= 4) {
      var_4 = 1;
      break;
    }
  }

  if(!istrue(var_0)) {
    level.flat_damage_callbacks = scripts\engine\utility::array_remove(level.flat_damage_callbacks, ::apply_freezing_instakill_damage);
  }
}

do_frost_blast() {
  var_0 = self.origin;
  var_1 = scripts\engine\utility::ter_op(get_frost_blast_level() >= 2, "frost_blast_aoe_large", "frost_blast_aoe");
  playFX(scripts\engine\utility::getfx(var_1), var_0, anglesToForward(self.angles));
  self radiusdamage(var_0, 200, 150, 150, self, "MOD_EXPLOSIVE", "s4_frost_blast_zm");
  self playlocalsound("zmb_frost_blast_use_st");
  self playsoundtoteam("zmb_frost_blast_use_m", self.team, self);
  playsoundatpos(var_0, "zmb_frost_blast_swirl");
  var_2 = _func_0071(var_0, 200);
  var_3 = get_frost_blast_level();
  thread spawn_zone(var_0);
  return 1;
}

slow_target(var_0, var_1, var_2, var_3) {
  var_1 = 1.0 - var_1;

  if(!is_slow_effect_applied() && !_id_06FE::is_zm_elite()) {
    play_slow_fx();
    self playSound("zmb_frost_blast_freeze");
  }

  scripts\cp\zombies\zombie_slow::slow(var_0, var_1, var_2, var_3, ::on_slow_end);
}

is_slow_effect_applied() {
  return scripts\cp\zombies\zombie_slow::has_slow("frost_blast_aoe_slow");
}

on_slow_end() {
  if(!is_slow_effect_applied()) {
    stop_slow_fx();
  }

  self playSound("zmb_frost_blast_burst");
}

stop_slow(var_0) {
  if(scripts\cp\zombies\zombie_slow::has_slow(var_0)) {
    scripts\cp\zombies\zombie_slow::end_slow(var_0);
  }
}

get_frost_blast_level() {
  return scripts\cp\utility::_id_459B(self.super_level, 0);
}

spawn_zone(var_0) {
  self.b_frost_blast_active = 1;
  var_1 = scripts\engine\utility::spawn_tag_origin(var_0);
  var_1.remainingduration = 3000.0;
  var_1._id_90B3 = gettime();
  var_1.currentai = [];
  var_1.owner = self;
  var_1.blast_zone_radius = scripts\engine\utility::ter_op(get_frost_blast_level() >= 2, 400, 200);
  var_1.should_freeze = get_frost_blast_level() >= 1;
  var_1 thread watch_zone(self);
}

watch_zone(var_0) {
  var_1 = var_0 get_frost_blast_level();
  var_2 = gettime();

  while(self.remainingduration > 0) {
    var_3 = gettime();
    var_4 = var_3 - self._id_90B3;
    self._id_90B3 = var_3;
    self.remainingduration = self.remainingduration - var_4;
    var_5 = _func_0071(self.origin, self.blast_zone_radius, "bad_guys");

    foreach(var_7 in self.currentai) {
      if(!scripts\engine\utility::array_contains(var_5, var_7._id_122C)) {
        if(isDefined(var_7._id_122C)) {
          var_7._id_122C stop_slow("frost_blast_aoe_slow");

          if(istrue(var_7._id_122C._id_8873)) {
            var_7._id_122C _id_08EA::set_frozen(0);
          }
        }

        self.currentai = scripts\engine\utility::array_remove(self.currentai, var_7);
      }
    }

    foreach(var_10 in var_5) {
      if(!scripts\engine\utility::_id_1BA1(self.currentai, var_10 getentitynumber())) {
        if(gettime() == var_2 && var_1 >= 2) {
          if(distancesquared(var_10.origin, self.origin) > 40000) {
            var_10 dodamage(50, var_10.origin, var_0, var_0, "MOD_EXPLOSIVE", "s4_frost_blast_zm");

            if(!isalive(var_10)) {
              continue;
            }
          }
        }

        var_11 = spawnStruct();
        var_11._id_122C = var_10;
        var_11.enter_time = var_3;
        self.currentai[var_10 getentitynumber()] = var_11;
      }

      var_7 = self.currentai[var_10 getentitynumber()];

      if(!var_10 scripts\cp\zombies\zombie_slow::is_slowed() && var_3 - var_7.enter_time < 500.0) {
        var_10 slow_target("frost_blast_aoe_slow", 0.7, 3.0, self.owner);
        var_10 thread watch_slow_end(3.0);
      } else if(!istrue(var_10._id_8873) && self.should_freeze) {
        if(var_10 can_freeze_ai()) {
          var_10 slow_target("frost_blast_aoe_slow", 1.0, 5.0, self.owner);
          var_10 _id_08EA::set_frozen(1);
          var_10 thread watch_slow_end(5.0);
          var_10 playSound("zmb_frost_blast_freeze");
        } else if(var_10._id_110B0 == "trickster")
          var_10 thread scripts\aitypes\zombie_trickster\trickster::play_cc_immune_vo();
      }

      _id_072A::addplayereffects("frost_blast_frozen", var_10, self.owner, 3.0);
    }

    waitframe();
  }

  var_0.b_frost_blast_active = undefined;
  self delete();
}

watch_slow_end(var_0) {
  self notify("notify_singleton_watch_slow_end");
  self endon("notify_singleton_watch_slow_end");
  level endon("game_ended");
  self endon("death");
  var_1 = int(gettime() + var_0 * 1000);

  if(!isDefined(self.slow_end_time)) {
    self.slow_end_time = var_1;
  } else {
    self.slow_end_time = int(max(self.slow_end_time, var_1));
  }

  wait(scripts\cp\utility::_id_A2B8(self.slow_end_time - gettime()));

  if(istrue(self._id_8873)) {
    _id_08EA::set_frozen(0);
  }

  stop_slow("frost_blast_aoe_slow");
  self.slow_end_time = undefined;
}

apply_freezing_instakill_damage(var_0) {
  if(!isPlayer(var_0.attacker)) {
    return 0.0;
  }

  if(can_freeze_ai() && istrue(self._id_8873)) {
    var_1 = var_0.attacker get_frost_blast_level();

    if(var_1 >= 4) {
      self playSound("zmb_frost_blast_burst");
      return self.health + self.maxhealth;
    }
  }

  return 0.0;
}

can_freeze_ai() {
  return self.zm_ai_category == "normal" || self.zm_ai_category == "special";
}

play_slow_fx() {
  if(!isDefined(self._id_110B0)) {
    return;
  }
  switch (self._id_110B0) {
    case "trickster":
    case "base":
    case "screamer":
      playFXOnTag(scripts\engine\utility::getfx("frost_blast_slow"), self, "j_spine4");
      break;
    case "juggernaut":
      playFXOnTag(scripts\engine\utility::getfx("frost_blast_large_slow"), self, "j_spine4");
      break;
  }
}

stop_slow_fx() {
  if(!isDefined(self._id_110B0)) {
    return;
  }
  switch (self._id_110B0) {
    case "trickster":
    case "base":
    case "screamer":
      playFXOnTag(scripts\engine\utility::getfx("frost_blast_slow_end"), self, "j_spine4");
      stopFXOnTag(scripts\engine\utility::getfx("frost_blast_slow"), self, "j_spine4");
      break;
    case "juggernaut":
      playFXOnTag(scripts\engine\utility::getfx("frost_blast_slow_lg_end"), self, "j_spine4");
      stopFXOnTag(scripts\engine\utility::getfx("frost_blast_large_slow"), self, "j_spine4");
      break;
  }
}