/*********************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\zombies\zombie_assassin_spawner_logic.gsc
*********************************************************************/

spawn_an_assassin(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  var_12 = get_valid_assassin_spawner(undefined, isDefined(var_0) && var_0 != "zombie_assassin", var_11);

  if(!isDefined(var_12)) {
    var_12 = get_valid_assassin_spawner(undefined, isDefined(var_0) && var_0 != "zombie_assassin", var_11, 0);
  }

  if(isDefined(var_2)) {
    var_12 = var_2;
  }

  if(!isDefined(var_0) || var_0 == "zombie_assassin") {
    var_10 = "default look";
  } else {
    var_10 = "boss look";
  }

  var_12 thread cool_down();
  var_13 = _id_054D::_id_90BA("zombie_assassin", var_12, "assassin_spawn", 0, 1, 0, var_10);

  if(!isDefined(var_13._id_9024) && isDefined(var_12.getnegotiationnextnode)) {
    var_13._id_9024 = var_12.getnegotiationnextnode;
  }

  if(isDefined(var_11)) {
    var_13.forcedzones = var_11;
  }

  if(isDefined(var_7)) {
    var_13.optionalassassinactionoverrides = var_7;
  }

  if(isDefined(var_4)) {
    var_13.optionalinitialstate = var_4;
  }

  if(isDefined(var_5)) {
    var_13.optionaldisablefogsensitivity = var_5;
  }

  if(isDefined(var_6)) {
    var_13.optionaldisableexits = var_6;
  }

  if(isDefined(var_8)) {
    var_13.aggrofuncsoverride = var_8;
  }

  if(isDefined(var_9)) {
    var_13.optionaldisablecrouchedambush = var_9;
  }

  if(isDefined(var_1)) {
    var_13.maxhealth = var_1;
    var_13.health = var_13.maxhealth;
  } else if(var_13.health <= 17500) {
    var_13.maxhealth = 17500;
    var_13.health = var_13.maxhealth;
  } else {}

  if(common_scripts\utility::_id_562E(var_3)) {
    var_13 _id_0547::disableoffhandsecondaryweapons();
  }

  var_13.previoushole = var_12;
  var_13.lastassassinspawner = var_12;
  var_13 apply_modifier(var_0);
  return var_13;
}

cool_down() {
  self notify("new_cooldown");
  self endon("new_cooldown");
  self.recentspawn = 1;
  wait 4;
  self.recentspawn = 0;
}

wait_for_activation() {
  waitframe();
  self.assassin_spawn_activated = 0;
  common_scripts\utility::_id_3C9F(self.getnegotiationnextnode);
  self.assassin_spawn_activated = 1;
}

get_valid_assassin_spawner(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(var_0)) {
    var_6 = [];
    var_7 = undefined;

    foreach(var_9 in level.players) {
      if(!isalive(var_9) || common_scripts\utility::_id_562E(var_9.inlaststand)) {
        continue;
      }
      var_6 = common_scripts\utility::_id_0F6F(var_6, var_9);
    }

    if(var_6.size) {
      var_0 = common_scripts\utility::random(var_6).origin;
    }
  }

  var_11 = [];
  var_12 = common_scripts\utility::_id_46B7("zmb_assassin_spawnpoint", "targetname");

  foreach(var_14 in var_12) {
    if(!_id_0547::_id_5565(var_14._id_0165, "zombie_spawner")) {
      continue;
    }
    if(isDefined(var_4) && common_scripts\utility::_id_0F79(var_4, var_14)) {
      continue;
    }
    if(!issubstr(var_14.setlookatent, "spawn")) {
      continue;
    }
    if(issubstr(var_14.setlookatent, "disable")) {
      continue;
    }
    if(issubstr(var_14.setlookatent, "respawn_only") && !common_scripts\utility::_id_562E(var_5)) {
      continue;
    }
    if(common_scripts\utility::_id_562E(var_1) && !issubstr(var_14.setlookatent, "boss")) {
      continue;
    }
    if(common_scripts\utility::_id_562E(var_1) && issubstr(var_14.setlookatent, "boss_late")) {
      continue;
    }
    if(common_scripts\utility::_id_562E(var_3) && common_scripts\utility::_id_562E(var_1) && common_scripts\utility::_id_562E(var_14.isassassincooling)) {
      continue;
    }
    if(common_scripts\utility::_id_562E(var_14.assassin_spawn_activated) || _id_0547::_id_5565(var_14.getnegotiationnextnode, "start_zone")) {
      var_11 = common_scripts\utility::_id_0F6F(var_11, var_14);
    }
  }

  var_16 = get_ideal_spawner_near_origin(var_11, var_0, var_2);
  var_16 thread assassin_spawn_cooldown();
  return var_16;
}

assassin_spawn_cooldown() {
  self.isassassincooling = 1;
  wait 5;
  self.isassassincooling = 0;
}

get_valid_assassin_exit_points(var_0) {
  var_1 = common_scripts\utility::_id_46B7("zmb_assassin_spawnpoint", "targetname");
  var_2 = [];
  var_3 = 0;
  var_4 = self.forcedzones;

  if(isDefined(level.zmb_locked_spawn_zones) && level.zmb_locked_spawn_zones.size > 0) {
    var_4 = level.zmb_locked_spawn_zones;
  }

  while(var_2.size == 0) {
    foreach(var_6 in var_1) {
      if(!issubstr(var_6.setlookatent, "exit")) {
        if(common_scripts\utility::_id_562E(var_0)) {
          if(!issubstr(var_6.setlookatent, "hc_escape")) {
            continue;
          }
        } else
          continue;
      }

      if(issubstr(var_6.setlookatent, "disable")) {
        continue;
      }
      if(common_scripts\utility::_id_562E(var_6.isassassincooling)) {
        continue;
      }
      if(_id_0547::_id_5565(self.previoushole, var_6) && distance(self.origin, self.previoushole.origin) < 512) {
        continue;
      }
      if(!_id_055A::_id_586A(var_6.getnegotiationnextnode)) {
        continue;
      }
      if(isDefined(var_4) && !common_scripts\utility::_id_0F79(var_4, var_6.getnegotiationnextnode)) {
        continue;
      }
      var_2 = common_scripts\utility::_id_0F6F(var_2, var_6);
    }

    if(var_3) {
      break;
    }

    var_3 = 1;
  }

  return var_2;
}

seek_exit_that_maintains_momentum(var_0) {
  self endon("death");
  var_1 = get_valid_assassin_exit_points(var_0);
  var_1 = common_scripts\utility::_id_40B0(self.origin, var_1);
  var_2 = [];
  var_3 = [];
  var_4 = [];
  var_5 = _id_055A::getagentzone();

  if(isDefined(var_5)) {
    var_4 = _id_055A::getadjacentzones(var_5);
  }

  foreach(var_7 in var_1) {
    var_8 = var_7.getnegotiationnextnode;

    if(_id_0547::_id_5565(var_5, var_8)) {
      var_2 = common_scripts\utility::_id_0F6F(var_2, var_7);
      continue;
    }

    foreach(var_10 in var_4) {
      if(_id_0547::_id_5565(var_10._id_AC8A, var_8)) {
        var_3 = common_scripts\utility::_id_0F6F(var_2, var_7);
      }
    }
  }

  if(var_2.size > 0) {
    return var_2[0];
  } else if(var_3.size > 0) {
    return var_3[0];
  } else {
    return common_scripts\utility::random(var_1);
  }
}

set_assassin_removed_from_game() {
  while(_id_0547::_id_5565(self._id_0BA4, "traverse")) {
    waitframe();
  }

  killassassinzombie();
}

killassassinzombie() {
  self._id_6701 = 1;
  self._id_2A9D = "idle_noncombat";

  if(maps\mp\zombies\zombie_assassin::is_boss_assassin()) {
    self suicide();
  } else {
    self dodamage(self.health + 500000, self.origin);
  }
}

respawnanassassinzombie() {
  var_0 = self.health;
  var_1 = common_scripts\utility::_id_46B7("zombie_assassin_pagan_room_spawner", "targetname");

  if(everyone_in_pommel_room()) {
    var_2 = spawn_an_assassin(undefined, undefined, common_scripts\utility::random(var_1), undefined, "Phase 1: Entrance", 1, 1);
  } else {
    var_2 = spawn_an_assassin(undefined, var_0);
  }

  killassassinzombie();
}

everyone_in_pommel_room(var_0, var_1) {
  if(!_id_055A::_id_3155("isolated_room_zone")) {
    return 0;
  }

  if(!common_scripts\utility::_id_562E(var_1) && !_id_055A::_id_586A("isolated_room_zone")) {
    return 0;
  }

  var_2 = [];

  foreach(var_4 in level.players) {
    if(var_4.sessionstate == "spectator") {
      continue;
    }
    if(common_scripts\utility::_id_562E(var_4._id_5728)) {
      continue;
    }
    var_2 = common_scripts\utility::_id_0F6F(var_2, var_4);
  }

  var_6 = [];

  foreach(var_4 in var_2) {
    if(_id_055A::_id_7413(var_4, "isolated_room_zone") || _id_055A::_id_7413(var_4, "isolated_room_entry_zone")) {
      var_6 = common_scripts\utility::_id_0F6F(var_6, var_4);
    }
  }

  if(common_scripts\utility::_id_562E(var_0)) {
    return var_6.size > 0;
  }

  if(var_2.size == var_6.size) {
    return 1;
  } else {
    return 0;
  }
}

set_new_assassin_origin(var_0) {
  self endon("death");
  self.lastexitpoint = var_0;
  var_1 = get_valid_assassin_spawner(undefined, undefined, undefined, undefined, [var_0], 1);

  while(_id_0547::_id_5565(self._id_0BA4, "traverse")) {
    waitframe();
  }

  var_2 = spawn("script_model", self.origin);
  var_2 setModel("tag_origin");
  self linkTo(var_2);
  var_2 thread _id_0547::_id_2D19(self);

  while(!_id_053C::humanoid_has_valid_targets(1)) {
    waitframe();
  }

  self unlink();
  self setOrigin(var_1.origin);

  if(isDefined(var_2)) {
    var_2 delete();
  }

  if(isDefined(var_1.angles)) {
    self.angles = var_1.angles;
  }

  self.previoushole = var_1;
  set_assassin_has_teleported();
  _playFXOnTag(common_scripts\utility::_id_44F5("zmb_isl_assassin_spawn_wisp01"), self, "TAG_ORIGIN");
  self.assassinmustleave = undefined;
  thread restore_assassin_ability(6);

  if(_id_0547::_id_5565(var_1.setflaggedanimknoball, "spawn_riser")) {
    self scragentsetscripted(1);
    var_3 = maps\mp\agents\_scripted_agent_anim_util::_id_434D("spawn_riser");
    var_4 = maps\mp\agents\_scripted_agent_anim_util::_id_7A35(var_3);
    self scragentsetanimmode("anim deltas");
    self scragentsetorientmode("face angle abs", self.angles);
    maps\mp\agents\_scripted_agent_anim_util::_id_71FA(var_3, var_4, 1.0, "spawn_riser");
    self scragentsetscripted(0);
  }
}

restore_assassin_ability(var_0) {
  var_1 = 0;

  while(var_1 < var_0) {
    wait 0.1;

    if(!_id_0547::_id_5565(self._id_0BA4, "traverse")) {
      var_1 = var_1 + 0.1;
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
  return common_scripts\utility::_id_562E(self.hasassassinteleported);
}

set_assassin_has_teleported() {
  self.hasassassinteleported = 1;
}

unset_assassin_has_teleported() {
  self.hasassassinteleported = 0;
}

get_ideal_spawner_near_origin(var_0, var_1, var_2) {
  var_3 = [];
  var_4 = [];
  var_5 = [];
  var_6 = undefined;
  var_7 = [];

  if(isDefined(var_1)) {
    var_3 = common_scripts\utility::_id_40B0(var_1, var_0);
    var_6 = _id_055A::_id_4562(var_1);

    if(isDefined(var_6)) {
      var_7 = _id_055A::getadjacentzones(var_6);
    }
  } else
    var_3 = common_scripts\utility::array_randomize(var_0);

  foreach(var_9 in var_3) {
    var_10 = var_9.getnegotiationnextnode;

    if(isDefined(var_2)) {
      if(common_scripts\utility::_id_0F79(var_2, var_9.getnegotiationnextnode) && !common_scripts\utility::_id_562E(var_9.isassassincooling)) {
        var_5 = common_scripts\utility::_id_0F6F(var_5, var_9);
      }

      continue;
    }

    if(_id_0547::_id_5565(var_6, var_10) && !common_scripts\utility::_id_562E(var_9.isassassincooling)) {
      var_4 = common_scripts\utility::_id_0F6F(var_4, var_9);
      continue;
    }

    foreach(var_12 in var_7) {
      if(_id_0547::_id_5565(var_12._id_AC8A, var_10) && !common_scripts\utility::_id_562E(var_9.isassassincooling)) {
        var_5 = common_scripts\utility::_id_0F6F(var_5, var_9);
      }
    }
  }

  if(var_4.size > 0) {
    return var_4[0];
  } else if(var_5.size > 0) {
    return var_5[0];
  } else {
    return common_scripts\utility::random(var_3);
  }
}

get_ideal_spawner_near_player(var_0, var_1, var_2) {
  var_3 = [];
  var_3 = common_scripts\utility::_id_40B0(var_0.origin, var_1);

  foreach(var_5 in var_3) {
    var_8 = [];

    if(isDefined(var_2)) {
      foreach(var_10 in var_2) {
        if(common_scripts\utility::_id_562E(var_5.recentspawn)) {
          continue;
        }
        if(var_5.getnegotiationnextnode == var_10) {
          return var_5;
        }
      }

      continue;
    }

    for(var_12 = 0; var_12 < 3; var_12++) {
      var_13 = var_5.getnegotiationnextnode;

      if(var_12 == 0) {
        if(!_id_055A::_id_7413(var_0, var_13)) {
          continue;
        }
        if(common_scripts\utility::_id_562E(var_5.recentspawn)) {
          continue;
        }
      }

      if(var_12 == 1) {
        var_14 = var_0 _id_055A::getagentzone();
        var_15 = _id_055A::getadjacentzones(var_14);

        foreach(var_10 in var_15) {
          var_8 = common_scripts\utility::_id_0F6F(var_8, var_10._id_AC8A);

          if(var_5.getnegotiationnextnode == var_10._id_AC8A) {
            return var_5;
          }
        }

        continue;
      }

      return var_5;
    }
  }

  return var_3[0];
}

apply_modifier(var_0) {
  if(!isDefined(var_0)) {
    self.assassin_modifier = "zombie_assassin";
  } else {
    self.assassin_modifier = var_0;
  }

  self.player_facing_times = [];

  switch (self.assassin_modifier) {
    case "zombie_assassin":
      break;
    case "zombie_assassin_frontline":
      self._id_2A9D = "death_stand_elt";
      self.assassinabilityactivateaction = "assassin_activate_attack";
      set_number_of_assassin_specials(3);
      self.reverse_assassin_specials_visuals = 1;
      self.assassin_seek_func = maps\mp\zombies\zombie_assassin_frontline::seek_special_ability_use;
      self.assassin_attack_func = maps\mp\zombies\zombie_assassin_frontline::activate_special_ability;
      self.assassin_special_damage_callback = maps\mp\zombies\zombie_assassin_frontline::special_assassin_damaged;
      break;
    case "zombie_assassin_freefire":
      self._id_2A9D = "death_stand_elt";
      self.assassinabilityactivateaction = "assassin_active_shoot_straight";
      self.player_facing_times["assassin_active_shoot_straight"] = 1.85;
      set_number_of_assassin_specials(2);
      self.assassinabilityactivateactionnotetrackhandler = maps\mp\zombies\zombie_assassin_freefire::assassin_throw_notetrack_handler;
      self.assassin_seek_func = maps\mp\zombies\zombie_assassin_freefire::seek_special_ability_use;
      self.assassin_attack_func = maps\mp\zombies\zombie_assassin_freefire::activate_special_ability;
      self.assassin_special_damage_callback = maps\mp\zombies\zombie_assassin_freefire::special_assassin_damaged;
      break;
    case "zombie_assassin_shellshock":
      self._id_2A9D = "death_stand_elt";
      self.assassinabilityactivateaction = "assassin_active_stunning_burst";
      set_number_of_assassin_specials(2);
      self.assassinabilityactivateactionnotetrackhandler = maps\mp\zombies\zombie_assassin_shellshock::assassin_stunning_burst_notetrack_handler;
      self.assassin_seek_func = maps\mp\zombies\zombie_assassin_shellshock::seek_special_ability_use;
      self.assassin_attack_func = maps\mp\zombies\zombie_assassin_shellshock::activate_special_ability;
      self.assassin_special_damage_callback = maps\mp\zombies\zombie_assassin_shellshock::special_assassin_damaged;
      break;
    case "zombie_assassin_camoflauge":
      self._id_2A9D = "death_stand_elt";
      self.assassinabilityactivateaction = "assassin_activate_attack";
      set_number_of_assassin_specials(1);
      self.assassinabilityactivateactionnotetrackhandler = maps\mp\zombies\zombie_assassin_camoflauge::assassin_camo_notetrack_handler;
      self.assassin_seek_func = maps\mp\zombies\zombie_assassin_camoflauge::seek_special_ability_use;
      self.assassin_attack_func = maps\mp\zombies\zombie_assassin_camoflauge::activate_special_ability;
      self.assassin_special_damage_callback = maps\mp\zombies\zombie_assassin_camoflauge::special_assassin_damaged;
      break;
  }
}

set_number_of_assassin_specials(var_0) {
  if(level.players.size == 1) {
    var_0 = common_scripts\utility::random([1, 1, 1, 2]);
  }

  self.max_special_activations = var_0;
  self.remaining_special_activations = self.max_special_activations;

  if(!common_scripts\utility::_id_562E(self.reverse_assassin_specials_visuals)) {
    maps\mp\zombies\zombie_assassin::enable_assassin_chest_fx();
  }
}

assassin_needs_vfx_refresh() {
  return common_scripts\utility::_id_562E(self.assassin_should_refresh_boss_vfx);
}

assassin_vfx_refreshed() {
  self.assassin_should_refresh_boss_vfx = 0;
}