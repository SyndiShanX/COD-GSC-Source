/*************************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\zombies\zombie_assassin_spawner_logic.gsc
*************************************************************/

spawn_an_assassin(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B) {
  var_0C = get_valid_assassin_spawner(undefined, isDefined(param_00) && param_00 != "zombie_assassin", param_0B);
  if(!isDefined(var_0C)) {
    var_0C = get_valid_assassin_spawner(undefined, isDefined(param_00) && param_00 != "zombie_assassin", param_0B, 0);
  }

  if(isDefined(param_02)) {
    var_0C = param_02;
  }

  if(!isDefined(param_00) || param_00 == "zombie_assassin") {
    param_0A = "default look";
  } else {
    param_0A = "boss look";
  }

  var_0C thread cool_down();
  var_0D = lib_054D::func_90BA("zombie_assassin", var_0C, "assassin_spawn", 0, 1, 0, param_0A);
  if(!isDefined(var_0D.var_9024) && isDefined(var_0C.var_819A)) {
    var_0D.var_9024 = var_0C.var_819A;
  }

  if(isDefined(param_0B)) {
    var_0D.forcedzones = param_0B;
  }

  if(isDefined(param_07)) {
    var_0D.optionalassassinactionoverrides = param_07;
  }

  if(isDefined(param_04)) {
    var_0D.optionalinitialstate = param_04;
  }

  if(isDefined(param_05)) {
    var_0D.optionaldisablefogsensitivity = param_05;
  }

  if(isDefined(param_06)) {
    var_0D.optionaldisableexits = param_06;
  }

  if(isDefined(param_08)) {
    var_0D.aggrofuncsoverride = param_08;
  }

  if(isDefined(param_09)) {
    var_0D.optionaldisablecrouchedambush = param_09;
  }

  if(isDefined(param_01)) {
    var_0D.var_FB = param_01;
    var_0D.var_BC = var_0D.var_FB;
  } else if(var_0D.var_BC <= 17500) {
    var_0D.var_FB = 17500;
    var_0D.var_BC = var_0D.var_FB;
  } else {}

  if(common_scripts\utility::func_562E(param_03)) {
    var_0D lib_0547::func_84CB();
  }

  var_0D.previoushole = var_0C;
  var_0D.lastassassinspawner = var_0C;
  var_0D apply_modifier(param_00);
  return var_0D;
}

cool_down() {
  self notify("new_cooldown");
  self endon("new_cooldown");
  self.recentspawn = 1;
  wait(4);
  self.recentspawn = 0;
}

wait_for_activation() {
  wait 0.05;
  self.assassin_spawn_activated = 0;
  common_scripts\utility::func_3C9F(self.var_819A);
  self.assassin_spawn_activated = 1;
}

get_valid_assassin_spawner(param_00, param_01, param_02, param_03, param_04, param_05) {
  if(!isDefined(param_00)) {
    var_06 = [];
    var_07 = undefined;
    foreach(var_09 in level.var_744A) {
      if(!isalive(var_09) || common_scripts\utility::func_562E(var_09.var_5378)) {
        continue;
      }

      var_06 = common_scripts\utility::func_F6F(var_06, var_09);
    }

    if(var_06.size) {
      param_00 = common_scripts\utility::func_7A33(var_06).var_116;
    }
  }

  var_0B = [];
  var_0C = common_scripts\utility::func_46B7("zmb_assassin_spawnpoint", "targetname");
  foreach(var_0E in var_0C) {
    if(!lib_0547::func_5565(var_0E.var_165, "zombie_spawner")) {
      continue;
    }

    if(isDefined(param_04) && common_scripts\utility::func_F79(param_04, var_0E)) {
      continue;
    }

    if(!issubstr(var_0E.var_8260, "spawn")) {
      continue;
    }

    if(issubstr(var_0E.var_8260, "disable")) {
      continue;
    }

    if(issubstr(var_0E.var_8260, "respawn_only") && !common_scripts\utility::func_562E(param_05)) {
      continue;
    }

    if(common_scripts\utility::func_562E(param_01) && !issubstr(var_0E.var_8260, "boss")) {
      continue;
    }

    if(common_scripts\utility::func_562E(param_01) && issubstr(var_0E.var_8260, "boss_late")) {
      continue;
    }

    if(common_scripts\utility::func_562E(param_03) && common_scripts\utility::func_562E(param_01) && common_scripts\utility::func_562E(var_0E.isassassincooling)) {
      continue;
    }

    if(common_scripts\utility::func_562E(var_0E.assassin_spawn_activated) || lib_0547::func_5565(var_0E.var_819A, "start_zone")) {
      var_0B = common_scripts\utility::func_F6F(var_0B, var_0E);
    }
  }

  var_10 = get_ideal_spawner_near_origin(var_0B, param_00, param_02);
  var_10 thread assassin_spawn_cooldown();
  return var_10;
}

assassin_spawn_cooldown() {
  self.isassassincooling = 1;
  wait(5);
  self.isassassincooling = 0;
}

get_valid_assassin_exit_points(param_00) {
  var_01 = common_scripts\utility::func_46B7("zmb_assassin_spawnpoint", "targetname");
  var_02 = [];
  var_03 = 0;
  var_04 = self.forcedzones;
  if(isDefined(level.zmb_locked_spawn_zones) && level.zmb_locked_spawn_zones.size > 0) {
    var_04 = level.zmb_locked_spawn_zones;
  }

  while(var_02.size == 0) {
    foreach(var_06 in var_01) {
      if(!issubstr(var_06.var_8260, "exit")) {
        if(common_scripts\utility::func_562E(param_00)) {
          if(!issubstr(var_06.var_8260, "hc_escape")) {
            continue;
          }
        } else {
          continue;
        }
      }

      if(issubstr(var_06.var_8260, "disable")) {
        continue;
      }

      if(common_scripts\utility::func_562E(var_06.isassassincooling)) {
        continue;
      }

      if(lib_0547::func_5565(self.previoushole, var_06) && distance(self.var_116, self.previoushole.var_116) < 512) {
        continue;
      }

      if(!lib_055A::func_586A(var_06.var_819A)) {
        continue;
      }

      if(isDefined(var_04) && !common_scripts\utility::func_F79(var_04, var_06.var_819A)) {
        continue;
      }

      var_02 = common_scripts\utility::func_F6F(var_02, var_06);
    }

    if(var_03) {
      break;
    }

    var_03 = 1;
  }

  return var_02;
}

seek_exit_that_maintains_momentum(param_00) {
  self endon("death");
  var_01 = get_valid_assassin_exit_points(param_00);
  var_01 = common_scripts\utility::func_40B0(self.var_116, var_01);
  var_02 = [];
  var_03 = [];
  var_04 = [];
  var_05 = lib_055A::getagentzone();
  if(isDefined(var_05)) {
    var_04 = lib_055A::getadjacentzones(var_05);
  }

  foreach(var_07 in var_01) {
    var_08 = var_07.var_819A;
    if(lib_0547::func_5565(var_05, var_08)) {
      var_02 = common_scripts\utility::func_F6F(var_02, var_07);
      continue;
    }

    foreach(var_0A in var_04) {
      if(lib_0547::func_5565(var_0A.var_AC8A, var_08)) {
        var_03 = common_scripts\utility::func_F6F(var_02, var_07);
      }
    }
  }

  if(var_02.size > 0) {
    return var_02[0];
  }

  if(var_03.size > 0) {
    return var_03[0];
  }

  return common_scripts\utility::func_7A33(var_01);
}

set_assassin_removed_from_game() {
  while(lib_0547::func_5565(self.var_BA4, "traverse")) {
    wait 0.05;
  }

  killassassinzombie();
}

killassassinzombie() {
  self.var_6701 = 1;
  self.var_2A9D = "idle_noncombat";
  if(maps\mp\zombies\zombie_assassin::is_boss_assassin()) {
    self suicide();
    return;
  }

  self dodamage(self.var_BC + 500000, self.var_116);
}

respawnanassassinzombie() {
  var_00 = self.var_BC;
  var_01 = common_scripts\utility::func_46B7("zombie_assassin_pagan_room_spawner", "targetname");
  if(everyone_in_pommel_room()) {
    var_02 = spawn_an_assassin(undefined, undefined, common_scripts\utility::func_7A33(var_01), undefined, "Phase 1: Entrance", 1, 1);
  } else {
    var_02 = spawn_an_assassin(undefined, var_01);
  }

  killassassinzombie();
}

everyone_in_pommel_room(param_00, param_01) {
  if(!lib_055A::func_3155("isolated_room_zone")) {
    return 0;
  }

  if(!common_scripts\utility::func_562E(param_01) && !lib_055A::func_586A("isolated_room_zone")) {
    return 0;
  }

  var_02 = [];
  foreach(var_04 in level.var_744A) {
    if(var_04.var_178 == "spectator") {
      continue;
    }

    if(common_scripts\utility::func_562E(var_04.var_5728)) {
      continue;
    }

    var_02 = common_scripts\utility::func_F6F(var_02, var_04);
  }

  var_06 = [];
  foreach(var_04 in var_02) {
    if(lib_055A::func_7413(var_04, "isolated_room_zone") || lib_055A::func_7413(var_04, "isolated_room_entry_zone")) {
      var_06 = common_scripts\utility::func_F6F(var_06, var_04);
    }
  }

  if(common_scripts\utility::func_562E(param_00)) {
    return var_06.size > 0;
  }

  if(var_02.size == var_06.size) {
    return 1;
  }

  return 0;
}

set_new_assassin_origin(param_00) {
  self endon("death");
  self.lastexitpoint = param_00;
  var_01 = get_valid_assassin_spawner(undefined, undefined, undefined, undefined, [param_00], 1);
  while(lib_0547::func_5565(self.var_BA4, "traverse")) {
    wait 0.05;
  }

  var_02 = spawn("script_model", self.var_116);
  var_02 setModel("tag_origin");
  self linkto(var_02);
  var_02 thread lib_0547::func_2D19(self);
  while(!lib_053C::humanoid_has_valid_targets(1)) {
    wait 0.05;
  }

  self unlink();
  self setorigin(var_01.var_116);
  if(isDefined(var_02)) {
    var_02 delete();
  }

  if(isDefined(var_01.var_1D)) {
    self.var_1D = var_01.var_1D;
  }

  self.previoushole = var_01;
  set_assassin_has_teleported();
  playFXOnTag(common_scripts\utility::func_44F5("zmb_isl_assassin_spawn_wisp01"), self, "TAG_ORIGIN");
  self.assassinmustleave = undefined;
  thread restore_assassin_ability(6);
  if(lib_0547::func_5565(var_01.var_8109, "spawn_riser")) {
    self scragentsetscripted(1);
    var_03 = maps\mp\agents\_scripted_agent_anim_util::func_434D("spawn_riser");
    var_04 = maps\mp\agents\_scripted_agent_anim_util::func_7A35(var_03);
    self method_839C("anim deltas");
    self scragentsetorientmode("face angle abs", self.var_1D);
    maps\mp\agents\_scripted_agent_anim_util::func_71FA(var_03, var_04, 1, "spawn_riser");
    self scragentsetscripted(0);
  }
}

restore_assassin_ability(param_00) {
  var_01 = 0;
  while(var_01 < param_00) {
    wait(0.1);
    if(!lib_0547::func_5565(self.var_BA4, "traverse")) {
      var_01 = var_01 + 0.1;
    }
  }

  if(isDefined(self.remaining_special_activations)) {
    self.assassin_special_wait = undefined;
    self.remaining_special_activations = self.max_special_activations;
    self.is_being_asked_to_leave_soon = 0;
    thread maps\mp\zombies\zombie_assassin::recharge_special_ability(0);
  }
}

assassin_has_teleported() {
  return common_scripts\utility::func_562E(self.hasassassinteleported);
}

set_assassin_has_teleported() {
  self.hasassassinteleported = 1;
}

unset_assassin_has_teleported() {
  self.hasassassinteleported = 0;
}

get_ideal_spawner_near_origin(param_00, param_01, param_02) {
  var_03 = [];
  var_04 = [];
  var_05 = [];
  var_06 = undefined;
  var_07 = [];
  if(isDefined(param_01)) {
    var_03 = common_scripts\utility::func_40B0(param_01, param_00);
    var_06 = lib_055A::func_4562(param_01);
    if(isDefined(var_06)) {
      var_07 = lib_055A::getadjacentzones(var_06);
    }
  } else {
    var_03 = common_scripts\utility::func_F92(param_00);
  }

  foreach(var_09 in var_03) {
    var_0A = var_09.var_819A;
    if(isDefined(param_02)) {
      if(common_scripts\utility::func_F79(param_02, var_09.var_819A) && !common_scripts\utility::func_562E(var_09.isassassincooling)) {
        var_05 = common_scripts\utility::func_F6F(var_05, var_09);
      }

      continue;
    }

    if(lib_0547::func_5565(var_06, var_0A) && !common_scripts\utility::func_562E(var_09.isassassincooling)) {
      var_04 = common_scripts\utility::func_F6F(var_04, var_09);
      continue;
    }

    foreach(var_0C in var_07) {
      if(lib_0547::func_5565(var_0C.var_AC8A, var_0A) && !common_scripts\utility::func_562E(var_09.isassassincooling)) {
        var_05 = common_scripts\utility::func_F6F(var_05, var_09);
      }
    }
  }

  if(var_04.size > 0) {
    return var_04[0];
  }

  if(var_05.size > 0) {
    return var_05[0];
  }

  return common_scripts\utility::func_7A33(var_03);
}

get_ideal_spawner_near_player(param_00, param_01, param_02) {
  var_03 = [];
  var_03 = common_scripts\utility::func_40B0(param_00.var_116, param_01);
  foreach(var_05 in var_03) {
    var_08 = [];
    if(isDefined(param_02)) {
      foreach(var_0A in param_02) {
        if(common_scripts\utility::func_562E(var_05.recentspawn)) {
          continue;
        }

        if(var_05.var_819A == var_0A) {
          return var_05;
        }
      }

      continue;
    }

    for(var_0C = 0; var_0C < 3; var_0C++) {
      var_0D = var_05.var_819A;
      if(var_0C == 0) {
        if(!lib_055A::func_7413(param_00, var_0D)) {
          continue;
        }

        if(common_scripts\utility::func_562E(var_05.recentspawn)) {
          continue;
        }
      }

      if(var_0C == 1) {
        var_0E = param_00 lib_055A::getagentzone();
        var_0F = lib_055A::getadjacentzones(var_0E);
        foreach(var_0A in var_0F) {
          var_08 = common_scripts\utility::func_F6F(var_08, var_0A.var_AC8A);
          if(var_05.var_819A == var_0A.var_AC8A) {
            return var_05;
          }
        }

        continue;
      }

      return var_05;
    }
  }

  return var_03[0];
}

apply_modifier(param_00) {
  if(!isDefined(param_00)) {
    self.assassin_modifier = "zombie_assassin";
  } else {
    self.assassin_modifier = param_00;
  }

  self.player_facing_times = [];
  switch (self.assassin_modifier) {
    case "zombie_assassin":
      break;

    case "zombie_assassin_frontline":
      self.var_2A9D = "death_stand_elt";
      self.assassinabilityactivateaction = "assassin_activate_attack";
      set_number_of_assassin_specials(3);
      self.reverse_assassin_specials_visuals = 1;
      self.assassin_seek_func = ::maps\mp\zombies\zombie_assassin_frontline::seek_special_ability_use;
      self.assassin_attack_func = ::maps\mp\zombies\zombie_assassin_frontline::activate_special_ability;
      self.assassin_special_damage_callback = ::maps\mp\zombies\zombie_assassin_frontline::special_assassin_damaged;
      break;

    case "zombie_assassin_freefire":
      self.var_2A9D = "death_stand_elt";
      self.assassinabilityactivateaction = "assassin_active_shoot_straight";
      self.player_facing_times["assassin_active_shoot_straight"] = 1.85;
      set_number_of_assassin_specials(2);
      self.assassinabilityactivateactionnotetrackhandler = ::maps\mp\zombies\zombie_assassin_freefire::assassin_throw_notetrack_handler;
      self.assassin_seek_func = ::maps\mp\zombies\zombie_assassin_freefire::seek_special_ability_use;
      self.assassin_attack_func = ::maps\mp\zombies\zombie_assassin_freefire::activate_special_ability;
      self.assassin_special_damage_callback = ::maps\mp\zombies\zombie_assassin_freefire::special_assassin_damaged;
      break;

    case "zombie_assassin_shellshock":
      self.var_2A9D = "death_stand_elt";
      self.assassinabilityactivateaction = "assassin_active_stunning_burst";
      set_number_of_assassin_specials(2);
      self.assassinabilityactivateactionnotetrackhandler = ::maps\mp\zombies\zombie_assassin_shellshock::assassin_stunning_burst_notetrack_handler;
      self.assassin_seek_func = ::maps\mp\zombies\zombie_assassin_shellshock::seek_special_ability_use;
      self.assassin_attack_func = ::maps\mp\zombies\zombie_assassin_shellshock::activate_special_ability;
      self.assassin_special_damage_callback = ::maps\mp\zombies\zombie_assassin_shellshock::special_assassin_damaged;
      break;

    case "zombie_assassin_camoflauge":
      self.var_2A9D = "death_stand_elt";
      self.assassinabilityactivateaction = "assassin_activate_attack";
      set_number_of_assassin_specials(1);
      self.assassinabilityactivateactionnotetrackhandler = ::maps\mp\zombies\zombie_assassin_camoflauge::assassin_camo_notetrack_handler;
      self.assassin_seek_func = ::maps\mp\zombies\zombie_assassin_camoflauge::seek_special_ability_use;
      self.assassin_attack_func = ::maps\mp\zombies\zombie_assassin_camoflauge::activate_special_ability;
      self.assassin_special_damage_callback = ::maps\mp\zombies\zombie_assassin_camoflauge::special_assassin_damaged;
      break;
  }
}

set_number_of_assassin_specials(param_00) {
  if(level.var_744A.size == 1) {
    param_00 = common_scripts\utility::func_7A33([1, 1, 1, 2]);
  }

  self.max_special_activations = param_00;
  self.remaining_special_activations = self.max_special_activations;
  if(!common_scripts\utility::func_562E(self.reverse_assassin_specials_visuals)) {
    maps\mp\zombies\zombie_assassin::enable_assassin_chest_fx();
  }
}

assassin_needs_vfx_refresh() {
  return common_scripts\utility::func_562E(self.assassin_should_refresh_boss_vfx);
}

assassin_vfx_refreshed() {
  self.assassin_should_refresh_boss_vfx = 0;
}