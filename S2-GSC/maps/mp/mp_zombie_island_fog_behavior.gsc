/*****************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\mp_zombie_island_fog_behavior.gsc
*****************************************************/

func_00D5() {
  level thread maps\mp\_utility::func_6F74(::monitor_fog_shots);
  level thread maps\mp\_utility::func_6F74(::monitor_reload);
  level thread maps\mp\_utility::func_6F74(::monitor_grenades);
  level thread lib_0547::perzombiethread(::fog_turn_zombies_passive_thread);
  lib_053C::humanoid_passive_register_wakeup_func(::activate_passive_fog_zombie);
  level.passive_wakeup_range_func = ::override_fog_passive_wakeup_range;
}

set_foggy_passive_behavior(param_00) {
  level.zmb_island_foggy_passive_behavior_enabled = param_00;
}

override_fog_passive_wakeup_range() {
  var_00 = self;
  var_01 = undefined;
  if(island_fog_is_active()) {
    var_01 = var_00 can_see_a_player();
  } else {
    var_01 = lib_053C::humanoid_passive_default_should_wakeup_range();
  }

  return var_01;
}

activate_passive_fog_zombie() {
  var_00 = self;
  for(;;) {
    if(common_scripts\utility::func_562E(level.zmb_fog_passive_lock)) {} else {
      if(lib_0547::func_5565(level.zmb_island_foggy_passive_behavior_enabled, 0)) {
        var_00 lib_053C::func_4F7F("passive behavior disabled for this objective");
        return;
      }

      if(isDefined(var_00.var_3043) || isDefined(var_00.var_1928)) {
        var_00 lib_053C::func_4F7F("jack-in-boxes or bossWaitingPoint");
        return;
      }

      if(var_00 lib_053C::humanoid_has_valid_targets()) {
        if(!var_00 is_in_a_fog_filled_zone()) {
          wait(randomfloatrange(1, 3));
          var_00 lib_053C::func_4F7F("fog doesnt exist here");
          return;
        }

        if(common_scripts\utility::func_562E(self.is_boss_buffed)) {
          var_00 lib_053C::func_4F7F("woken by boss assassin");
          return;
        }

        if(!island_fog_is_active()) {
          wait(randomfloatrange(1, 3));
          var_00 lib_053C::func_4F7F("fog hasnt left");
          return;
        }
      }
    }

    wait(1);
  }
}

fog_turn_zombies_passive_thread() {
  var_00 = self;
  var_00 endon("death");
  if(!common_scripts\utility::func_F79(["zombie_generic", "zombie_exploder", "zombie_heavy", "zombie_berserker"], var_00.var_A4B)) {
    return;
  }

  thread maps\mp\mp_zombie_island_fog_zones::run_fog_callbacks(undefined, 1);
  self.custom_passive_action = ::zombie_passive_with_turns;
  var_01 = 0.125;
  var_02 = int(20 * var_01);
  for(;;) {
    if(common_scripts\utility::func_3794("zombie_passive")) {} else if(lib_0547::func_5565(level.zmb_island_foggy_passive_behavior_enabled, 0)) {} else if(isDefined(self.passive_activation_time_ms)) {
      var_04 = gettime() - self.passive_activation_time_ms / 1000;
      if(var_04 < 13.5) {} else if(!is_in_a_fog_filled_zone()) {} else if(!island_fog_is_active()) {} else if(common_scripts\utility::func_562E(self.is_boss_buffed)) {} else if(!island_fog_is_settled_long_enough()) {} else if(can_see_a_player()) {} else if(!has_entered_playable_area()) {} else if(!is_allowed_to_go_passive()) {} else if(common_scripts\utility::func_562E(self.woken_by_player_aggro)) {
        var_05 = 0;
        var_06 = 512;
        var_07 = squared(var_06);
        foreach(var_09 in level.var_744A) {
          if(distancesquared(self.var_116, var_09.var_116) > var_07) {
            continue;
          }

          if(!lib_053C::humanoid_is_valid_target(var_09)) {
            continue;
          }

          var_05 = 1;
          break;
        }

        if(var_05) {} else {
          common_scripts\utility::func_379A("zombie_passive");
        }
      }
    }

    wait(var_01);
  }
}

zombie_passive_with_taunt_wakeup() {
  self endon("death");
  self endon("assassin_awoken");
  var_00 = maps\mp\agents\_scripted_agent_anim_util::func_434D("idle_noncombat");
  var_01 = maps\mp\agents\_scripted_agent_anim_util::func_7A35(var_00);
  self method_839C("anim deltas");
  self scragentsetorientmode("face angle abs", self.var_1D);
  maps\mp\agents\_scripted_agent_anim_util::func_71FA(var_00, var_01, 1, "idle_anim");
}

zombie_passive_with_turns() {
  self endon("zombie_passive");
  self endon("death");
  for(;;) {
    var_00 = maps\mp\agents\_scripted_agent_anim_util::func_434D("idle_noncombat_turn");
    var_01 = maps\mp\agents\_scripted_agent_anim_util::func_7A35(var_00);
    self method_839C("anim deltas");
    self scragentsetorientmode("face angle abs", self.var_1D);
    maps\mp\agents\_scripted_agent_anim_util::func_71FA(var_00, var_01, 1, "idle_anim");
    maps\mp\agents\_scripted_agent_anim_util::func_8410("idle_noncombat");
    wait(randomint(4) + 4);
  }
}

is_in_a_fog_filled_zone() {
  return common_scripts\utility::func_562E(self.isinfogzone);
}

is_allowed_to_go_passive() {
  return !lib_0547::func_5565(self.isobjectiveexemptfromfog, 1) && !lib_053C::is_passive_exempt();
}

has_entered_playable_area() {
  return lib_0547::func_4B2C() && !is_in_anti_passive_zone();
}

island_fog_is_thick() {
  return common_scripts\utility::func_562E(level.island_fog_is_thick);
}

island_fog_is_active() {
  return maps\mp\mp_zombie_island_ee_fog_manager::get_is_fog_active();
}

island_fog_is_settled_long_enough() {
  return isDefined(level.island_fog_settle_time) && level.island_fog_settle_time > 4.3;
}

is_in_anti_passive_zone() {
  var_00 = getEntArray("zmi_anti_passive_zone", "targetname");
  foreach(var_02 in var_00) {
    if(self istouching(var_02)) {
      return 1;
    }
  }

  return 0;
}

monitor_fog_shots() {
  var_00 = self;
  var_00 endon("disconnect");
  for(;;) {
    var_00 waittill("weapon_fired", var_01);
    if(!issubstr(var_01, "austen_pap_zm")) {
      var_00 alarm_fog_zombies(900);
      continue;
    }

    wait 0.05;
  }
}

monitor_reload() {
  var_00 = self;
  var_00 endon("disconnect");
  for(;;) {
    var_00 waittill("reload_start");
    var_00 alarm_fog_zombies(500);
  }
}

monitor_grenades() {
  var_00 = self;
  var_00 endon("disconnect");
  for(;;) {
    var_00 waittill("grenade_fire", var_01, var_02);
    var_01 thread projectile_alarm_fog_zombies();
  }
}

projectile_alarm_fog_zombies() {
  var_00 = self;
  var_00 waittill("explode", var_01);
  var_02 = spawn("script_model", var_01);
  var_02 setModel("tag_origin");
  var_02 thread delete_after(1.7);
  var_00 alarm_fog_zombies(2250, var_01, var_02);
}

delete_after(param_00) {
  wait(param_00);
  self delete();
}

alarm_fog_zombies(param_00, param_01, param_02) {
  if(!isDefined(param_01)) {
    param_01 = self.var_116;
  }

  var_03 = lib_0547::func_408F();
  var_04 = squared(param_00);
  foreach(var_06 in var_03) {
    if(lib_0547::func_5565(var_06.var_A4B, "zombie_assassin")) {
      var_06 maps\mp\zombies\zombie_assassin::assassin_notify_gunshot();
    }

    if(!var_06 common_scripts\utility::func_3794("zombie_passive")) {
      continue;
    }

    if(distancesquared(var_06.var_116, param_01) > var_04) {
      continue;
    }

    if(isDefined(param_02) && !isDefined(var_06.var_1928) && var_06 common_scripts\utility::func_3794("zombie_passive")) {
      var_06.var_1928 = param_02;
    } else if(!var_06 lib_053C::humanoid_has_valid_targets()) {
      continue;
    }

    if(isPlayer(self)) {
      var_06.woken_by_player_aggro = 1;
    }

    var_06 thread lib_053C::func_4F7F("fog alarmed", 0);
  }
}

can_see_a_player() {
  var_00 = self gettagorigin("j_head");
  if(!isDefined(var_00)) {
    return 0;
  }

  var_01 = self gettagangles("j_head");
  var_02 = anglestoright(var_01);
  foreach(var_04 in level.var_744A) {
    if(!lib_053C::humanoid_is_valid_target(var_04)) {
      continue;
    }

    if(distance(self.var_116, var_04.var_116) > 96) {
      continue;
    }

    if(!maps\mp\_utility::findisfacingvectors(var_00, var_02, var_04.var_116, 30)) {
      continue;
    }

    var_05 = var_04 method_81D8(var_00, self);
    if(var_05 != 1) {
      continue;
    }

    return 1;
  }

  return 0;
}