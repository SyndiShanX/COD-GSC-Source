/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\respawn\cp_respawn.gsc
***********************************************/

function main() {
  level._effect["vfx_snatch_ac130_clouds"] = loadfx("vfx/iw8_mp/gamemode/vfx_snatch_ac130_clouds.vfx");
  level._effect["c130_clouds"] = loadfx("vfx/iw8_mp/killstreak/vfx_ac130_clouds.vfx");
  level._effect["c130_lights"] = loadfx("vfx/iw8_mp/killstreak/vfx_ac130_lights.vfx");
  setomnvar("ui_br_altimeter_c130_height", 6666);
  setomnvar("ui_br_altimeter_sea_height", scripts\cp_mp\parachute::getc130sealevel());
  var_0 = getEntArray("minimap_corner", "targetname");
  var_1 = level.mapcenter;

  if(var_0.size) {
    var_1 = scripts\cp\cp_globallogic::findboxcenter(var_0[0].origin, var_0[1].origin);
  }

  level.ac130 = spawn("script_model", var_1);
  level.ac130 setModel("tag_origin");
  level.ac130.angles = (0, 115, 0);
  thread rotate_plane();
  level.respawn_func = &respawn_bleedout_func;
  level.parachutetakeweaponscb = &takeweaponsdefaultfunc;
  level.parachuterestoreweaponscb = &give_loadout_back_after_landing;
  level.respawn_uses = 0;
  level.ref_12880 = [];

  if(scripts\cp\respawn\cp_ac130_respawn::trial_ui_decrease_tries_remaining()) {
    scripts\cp\respawn\cp_ac130_respawn::ref_131d9();
  }

  if(getdvarint("scr_short_rspwn", 0) != 0) {
    level.respawn_cooldown = 5;
  }

  level.respawn_cooldown = 60 + 0 * level.respawn_uses;
  level.time_till_next_respawn = level.respawn_cooldown;
  level.automated_respawn_delay = 60;
  level.initialize_flag_role = 0;
  level.disable_hotjoin_via_ac130 = 1;
  scripts\cp_mp\parachute::initparachutedvars();
  level.respawn_c130 = [];
}

function rotate_plane() {
  level.ac130_speed["move"] = 250;
  level.ac130_speed["rotate"] = 120;
  var_0 = 10;
  var_1 = level.ac130_speed["rotate"] / 360 * var_0;
  level.ac130 rotateYaw(level.ac130.angles[2] + var_0, var_1, var_1, 0);
  var_2 = 360 / level.ac130_speed["rotate"];
  var_3 = var_2 * 0.0174533;
  level.ac130_magnitude = var_3 * 9000;

  for(;;) {
    level.ac130 rotateYaw(360, level.ac130_speed["rotate"]);
    wait level.ac130_speed["rotate"];
  }
}

function get_respawn_cooldown() {
  level.respawn_cooldown = 60 + 0 * level.respawn_uses;

  if(getdvarint("scr_short_rspwn", 0) != 0) {
    level.respawn_cooldown = 5;
  }

  return level.respawn_cooldown;
}

function activate_respawn_flare() {
  if(istrue(self.bgivensentry)) {
    return;
  }

  if(istrue(self.tablet_out)) {
    return;
  }

  if(istrue(self.waiting_to_spawn)) {
    return;
  }

  if(self isskydiving()) {
    return;
  }

  if(istrue(self.spectating)) {
    return;
  }

  if(istrue(self.binc130)) {
    return;
  }

  if(istrue(self.isreviving)) {
    return;
  }

  if(istrue(self.inlaststand)) {
    return;
  }

  if(!istrue(self.respawn_active)) {
    return;
  }

  if(!isDefined(level.players_in_respawn_queue)) {
    return;
  }

  if(level.players_in_respawn_queue.size == 0) {
    return;
  }

  level.respawn_uses++;
  level.respawn_in_progress = 1;

  if(!istrue(self.ref_12c9c)) {
    self.ref_12c9c = 1;
    thread scripts\cp\agents\gametype_cp_wave_sv::giveunifiedpoints("reviver");
  }

  scripts\cp\crafting_system::scriptable_autouse_funcs();
  scripts\cp\respawn\cp_ac130_respawn::start_ac130_respawn_sequence(self.origin, level.players_in_respawn_queue, self);

  foreach(var_1 in level.players) {
    var_1 thread scripts\cp\cp_hud_message::showsplash("cp_used_respawn", undefined, self);
    thread toggle_respawn_functionality_after_timeout(var_1);
  }

  level notify("respawn_used");
  level.respawn_in_progress = undefined;
}

function respawn_bleedout_func(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  scripts\cp\cp_laststand::enter_camera_zoomout();

  if(istrue(var_0.fauxdead) || istrue(var_0.binc130)) {
    var_0.fauxdead = undefined;
    var_0 scripts\cp\cp_laststand::enter_bleed_out(var_0);
    var_0 scripts\cp\cp_laststand::playslamzoomflash();
  } else {
    scripts\cp\cp_laststand::camera_zoomout(var_0, var_1, undefined);
  }

  scripts\cp\cp_laststand::exit_camera_zoomout();

  if(!isDefined(level.players_in_respawn_queue)) {
    level.players_in_respawn_queue = [];
  }

  level.players_in_respawn_queue = scripts\engine\utility::array_add(level.players_in_respawn_queue, var_0);
  var_12 = 0;
  var_13 = undefined;

  foreach(var_15 in level.players) {
    if(var_15.sessionstate == "spectator") {
      var_12++;
    }
  }

  if(var_12 == level.players.size - 1) {
    foreach(var_15 in level.players) {
      if(var_15.sessionstate == "spectator") {}
    }
  }

  foreach(var_15 in level.players) {
    if(!istrue(level.player_cam_disable)) {
      level.player_cam_disable = 1;

      foreach(var_15 in level.players) {
        var_15.respawn_active = 0;
        var_15 notify("toggle_respawn_function", 1);
      }
    }
  }

  for(;;) {
    var_23 = var_0 scripts\engine\utility::ref_143ae("respawn_player", "auto_respawn", "forced_revive_to_regroup");

    if(isDefined(var_23)) {
      if(istrue(var_0.binc130)) {
        continue;
      }

      if(istrue(level.ref_12213)) {
        continue;
      }

      if(var_23 == "auto_respawn") {
        scripts\cp\respawn\cp_ac130_respawn::start_ac130_respawn_sequence(var_0.origin, level.players_in_respawn_queue, var_0);

        foreach(var_15 in level.players) {
          var_15 thread scripts\cp\cp_hud_message::showsplash("cp_auto_respawn");
        }

        var_0 setclientomnvar("ui_hide_hud", 1);
        wait 2;
        var_0 setclientomnvar("ui_hide_hud", 1);
        scripts\cp\cp_analytics::ref_119bb(var_0);
      } else if(var_23 == "respawn_player") {
        scripts\cp\cp_analytics::ref_119bd(var_0);
      } else {
        var_0.playerjailwaitvo = 1;
      }

      level.players_in_respawn_queue = scripts\engine\utility::array_remove(level.players_in_respawn_queue, var_0);
      return 1;
    }
  }
}

function launch_respawn_functionality_for_players() {
  level notify("launch_respawn_functionality_for_players");
  level endon("launch_respawn_functionality_for_players");

  foreach(var_1 in level.players) {
    if(scripts\engine\utility::array_contains(level.players_in_respawn_queue, var_1)) {
      continue;
    }

    thread respawn_dpad_func();
  }
}

function respawn_dpad_func() {
  self endon("last_stand");
  self notify("respawn_dpad_func");
  self endon("respawn_dpad_func");
  self notifyonplayercommand("respawn_players", "+usereload");
  waitframe();

  for(;;) {
    self waittill("respawn_players");

    foreach(var_1 in level.players_in_respawn_queue) {
      thread do_resurrection_logic(var_1);
      level.players_in_respawn_queue = scripts\engine\utility::array_remove(level.players_in_respawn_queue, var_1);
    }
  }
}

function do_resurrection_logic(var_0) {
  scripts\cp\cp_laststand::record_revive_success(var_0, self);
  var_0 notify("revive_teammate", self);
  var_1 = scripts\cp\cp_endgame::get_current_zone(var_0);
  var_2 = 1;
  self.last_stand_state = undefined;

  if(isPlayer(var_0) && istrue(var_0.can_give_revive_xp)) {
    var_0.can_give_revive_xp = 0;
    return;
  }
}

function ref_13a9c(var_0, var_1, var_2) {
  self setweaponhudiconoverride("actionslot" + var_0, var_1);

  if(isDefined(var_2)) {
    thread ref_13a9d(var_0, var_2);
    return;
  }
}

function ref_13a9d(var_0, var_1) {
  self endon("death");
  self endon("removeActionslot" + var_0);
  self notifyonplayercommand("team_revive_kbm", "killstreak4");

  for(;;) {
    self waittill("team_revive_kbm");
    self thread[[var_1]]();
  }
}

function respawn_function_toggle() {
  self notify("respawn_function_toggle");
  self endon("respawn_function_toggle");

  for(;;) {
    self waittill("toggle_respawn_function", var_0);

    if(istrue(var_0)) {
      if(!istrue(self.respawn_active)) {
        thread ref_119df();
        thread ref_12de7();
      }

      self.respawn_active = 1;
      continue;
    }

    self.respawn_active = 0;
    self setclientomnvar("cp_team_respawn_display", 2);
  }
}

function ref_12de7() {
  level endon("respawn_used");
  self endon("game_ended");
  self endon("disconnect");
  self.ref_12c98 = undefined;
  self.ref_12c96 = undefined;

  for(;;) {
    if(!istrue(level.automated_respawn_available)) {
      wait 1;
      continue;
    }

    if(level.players.size > 1) {
      if(isDefined(level.players_in_respawn_queue) && level.players_in_respawn_queue.size > 0) {
        if(istrue(self.binc130)) {
          wait 1;
          continue;
        }

        if(!istrue(self.ref_12c98)) {
          self.ref_12c98 = 1;
          self setclientomnvar("cp_team_respawn_display", 3);
          self.ref_12c96 = undefined;
        }
      } else if(!istrue(self.ref_12c96)) {
        self.ref_12c96 = 1;
        self setclientomnvar("cp_team_respawn_display", 1);
        self.ref_12c98 = undefined;
      }
    }

    wait 0.5;
  }
}

function getcpcratedropcaststart() {
  self endon("game_ended");
  self endon("disconnect");
  self.ref_12c97 = undefined;
  self.ref_12c95 = undefined;
  thread respawn_function_toggle();

  for(;;) {
    if(level.players.size == 1) {
      if(!istrue(self.ref_12c97)) {
        self.ref_12c97 = 1;
        self.ref_12c98 = undefined;
        self.ref_12c96 = undefined;
        level notify("respawn_used");
        self notify("respawn_function_toggle");
        self setclientomnvar("cp_team_respawn_display", 0);
        self.ref_12c95 = 1;
      }
    } else {
      self.ref_12c97 = undefined;

      if(istrue(self.ref_12c95)) {
        self setclientomnvar("cp_team_respawn_display", 1);
        thread respawn_function_toggle();
        level.players_in_respawn_queue = [];
      }

      self.ref_12c95 = undefined;
    }

    wait 1;
  }
}

function ref_119df() {
  level endon("respawn_used");
  self endon("game_ended");
  self endon("disconnect");
  self notify("loop_respawn_ready_splash");
  self endon("loop_respawn_ready_splash");

  for(;;) {
    if(!istrue(self.respawn_active)) {
      wait 1;
      continue;
    }

    if(level.players_in_respawn_queue.size > 0) {
      if(istrue(self.binc130)) {
        continue;
      }

      thread scripts\cp\cp_hud_message::showsplash("cp_respawn_ready", undefined, self);
    }

    wait 15;
  }
}

function toggle_respawn_functionality_after_timeout(var_0, var_1) {
  self notify("start_respawn_cooldown");
  self endon("start_respawn_cooldown");
  level.automated_respawn_available = 0;
  self notify("toggle_respawn_function", 0);

  if(isDefined(var_1) && isstring(var_1)) {
    level waittill(var_1);
  } else {
    level.time_till_next_respawn = level.respawn_cooldown;
    thread time_till_next_respawn_tick();
    var_2 = gettime() + var_0 * 1000;
    setomnvar("cp_team_respawn_timer", var_2);

    for(var_3 = var_0; var_3 >= 0; var_3--) {
      wait 1;
    }

    setomnvar("cp_team_respawn_timer", 0);
  }

  self notify("toggle_respawn_function", 1);
  level.automated_respawn_available = 1;
}

function checkforactiveobjicon() {
  level endon("game_ended");
  level endon("respawn_used");
  level endon("auto_respawn");
  level notify("auto_respawn_timer");
  level endon("auto_respawn_timer");

  for(;;) {
    var_0 = gettime() + level.automated_respawn_delay * 1000;
    setomnvar("cp_auto_respawn_timer", var_0);
    setomnvar("cp_team_respawn_display", 4);
    level.initialize_flag_role = level.automated_respawn_delay;

    while(level.initialize_flag_role >= 0) {
      wait 1;
      level.initialize_flag_role--;
    }

    setomnvar("cp_auto_respawn_timer", 0);
    setomnvar("cp_team_respawn_display", 0);

    foreach(var_2 in level.players) {
      var_2 notify("auto_respawn");
    }

    level.automated_respawn_delay = 60;
    level.initialize_flag_role = 0;
    level notify("auto_respawn");
  }
}

function time_till_next_respawn_tick() {
  for(;;) {
    if(level.time_till_next_respawn <= 0) {
      break;
    }

    level.time_till_next_respawn--;
    wait 1;
  }
}

function give_loadout_back_after_landing() {
  thread give_loadout_after_entire_landing_is_done();
}

function give_loadout_after_entire_landing_is_done() {
  self waittill("parachute_complete");
  self getclientomnvar();
  self skydive_cutautodeployon();
  thread little_bird_mg_initdamage(3);
  self.parachuting = undefined;

  if(self hasweapon("iw8_fists_mp")) {
    self takeweapon("iw8_fists_mp");
  }

  if(isDefined(self.classstruct.loadoutaccessorydata) && isDefined(self.classstruct.loadoutaccessoryweapon) && self.classstruct.loadoutaccessoryweapon != "none") {
    scripts\cp\cp_accessories::giveplayeraccessory(self.classstruct.loadoutaccessorydata, self.classstruct.loadoutaccessoryweapon, self.classstruct.loadoutaccessorylogic);
  }

  if(istrue(self.bspawningviaac130)) {
    self.bspawningviaac130 = undefined;

    if(!istrue(self.inlaststand)) {
      foreach(var_1 in self.copy_fullweaponlist) {
        if(!self hasweapon(var_1)) {
          self giveweapon(var_1, -1, 0, -1, 1);
        }

        var_2 = createheadicon(var_1);

        if(isDefined(self.powerprimarygrenade) && self.powerprimarygrenade == var_2) {
          self assignweaponoffhandprimary(var_1);
        }

        if(isDefined(self.powersecondarygrenade) && self.powersecondarygrenade == var_2) {
          self assignweaponoffhandsecondary(var_1);
        }

        if(isDefined(self.specialoffhandgrenade) && self.specialoffhandgrenade == var_2) {
          self assignweaponoffhandspecial(var_1);
        }

        var_3 = self getweaponammoclip(var_1, "left");
        var_4 = self getweaponammoclip(var_1, "right");
        self setweaponammoclip(var_1, var_3, "left");
        self setweaponammoclip(var_1, var_4, "right");

        if(isDefined(self.copy_weapon_ammo_stock[var_2])) {
          self setweaponammostock(var_1, self.copy_weapon_ammo_stock[var_2]);
        }
      }

      var_6 = self.copy_weapon_current;

      if(getqueuedspleveltransients(var_6)) {
        foreach(var_8 in self.copy_fullweaponlist) {
          if(scripts\cp\cp_weapon::isbulletweapon(var_8)) {
            var_6 = var_8;
            break;
          }
        }
      }

      self.copy_fullweaponlist = undefined;
      self.copy_weapon_current = undefined;
      self.copy_weapon_ammo_clip = undefined;
      self.copy_weapon_ammo_stock = undefined;
      self.copy_weapon_ammo_clip_left = undefined;
    }
  } else {
    if(istrue(self.fly_to_end_point)) {
      var_10 = scripts\cp\loot_system::get_empty_munition_slot(self);

      if(isDefined(var_10)) {
        scripts\cp\cp_munitions::give_munition_to_slot("juggernaut", var_10);
      }

      self.fly_to_end_point = undefined;
    }

    if(isDefined(self.primaryweaponobj)) {
      scripts\cp_mp\utility\inventory_utility::_giveweapon(self.primaryweaponobj, undefined, undefined, 0);

      if(isDefined(self.primaryweaponclipammo)) {
        self setweaponammoclip(self.primaryweaponobj, self.primaryweaponclipammo);
        self setweaponammostock(self.primaryweaponobj, self.primaryweaponstockammo);
      }
    }

    if(isDefined(self.secondaryweaponobj)) {
      scripts\cp_mp\utility\inventory_utility::_giveweapon(self.secondaryweaponobj, undefined, undefined, 1);

      if(isDefined(self.secondaryweaponclipammo)) {
        self setweaponammoclip(self.secondaryweaponobj, self.secondaryweaponclipammo);
        self setweaponammostock(self.secondaryweaponobj, self.secondaryweaponstockammo);
      }
    }
  }

  if(!istrue(self.inlaststand)) {
    self.weaponlist = self.primaryweapons;

    if(isDefined(level.nuclear_core_carrier)) {
      if(level.nuclear_core_carrier == self) {
        var_11 = getcompleteweaponname("iw8_nukecore_mp");
        scripts\cp\utility::_giveweapon(var_11, undefined, undefined, 0);
        self switchtoweaponimmediate(var_11);
        scripts\mp\playeractions::allowactionset("nuke_core", 0);
        self allowmountside(0);
        self allowmounttop(0);
        self allowjog(0);
        watchnukeweaponenduse(var_11, self.primaryweaponobj);
      } else {
        scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(self.weaponlist[0]);
      }
    } else {
      scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(self.weaponlist[0]);
    }

    if(isDefined(self.weaponlist) && self.weaponlist.size > 1) {
      if(scripts\cp\cp_weapon::iscacprimaryweapon(self.weaponlist[0].basename)) {
        var_12 = 0;

        for(var_13 = 0; var_13 < self.weaponlist.size; var_13++) {
          if(istrue(self.weaponlist[var_13].isalternate)) {
            continue;
          }

          if(!var_12) {
            self.primaryweaponobj = self.weaponlist[var_13];
            var_12 = 1;
            continue;
          }

          self.secondaryweaponobj = self.weaponlist[var_13];
          break;
        }
      } else {
        self.secondaryweaponobj = self.weaponlist[0];
        self.primaryweaponobj = self.weaponlist[1];
      }
    } else {
      if(isDefined(self.weaponlist) && isDefined(self.weaponlist[0])) {
        self.primaryweaponobj = self.weaponlist[0];
      }

      if(isDefined(self.weaponlist) && isDefined(self.weaponlist[1])) {
        self.secondaryweaponobj = self.weaponlist[1];
      }
    }

    if(isDefined(self.primaryweaponobj)) {
      var_14 = weaponclipsize(self.primaryweaponobj);
      var_15 = self getweaponammoclip(self.primaryweaponobj);
      var_16 = self getweaponammostock(self.primaryweaponobj);

      if(var_15 < var_14) {
        var_17 = var_14 - var_15;

        if(var_17 >= var_16) {
          var_15 += var_16;
          var_16 = 0;
        } else {
          var_15 = var_14;
          var_16 -= var_17;
        }
      }

      self.primaryweaponclipammo = var_15;
      self.primaryweaponstockammo = var_16;

      if(isDefined(self.primaryweaponclipammo)) {
        self setweaponammoclip(self.primaryweaponobj, self.primaryweaponclipammo);
        self setweaponammostock(self.primaryweaponobj, self.primaryweaponstockammo);
      }
    }

    if(isDefined(self.secondaryweaponobj)) {
      var_14 = weaponclipsize(self.secondaryweaponobj);
      var_15 = self getweaponammoclip(self.secondaryweaponobj);
      var_16 = self getweaponammostock(self.secondaryweaponobj);

      if(var_15 < var_14) {
        var_17 = var_14 - var_15;

        if(var_17 >= var_16) {
          var_15 += var_16;
          var_16 = 0;
        } else {
          var_15 = var_14;
          var_16 -= var_17;
        }
      }

      self.secondaryweaponclipammo = var_15;
      self.secondaryweaponstockammo = var_16;

      if(isDefined(self.secondaryweaponclipammo)) {
        self setweaponammoclip(self.secondaryweaponobj, self.secondaryweaponclipammo);
        self setweaponammostock(self.secondaryweaponobj, self.secondaryweaponstockammo);
      }
    }
  } else if(scripts\cp\cp_loadout::is_player_carrying_special_item()) {
    scripts\cp\cp_loadout::drop_special_item();
  }

  if(isDefined(self.operatorcustomization) && isDefined(self.operatorcustomization.execution)) {
    scripts\cp_mp\execution::_giveexecution(self.operatorcustomization.execution);
  }

  if(isDefined(level.outofboundstriggers) && level.outofboundstriggers.size > 0) {
    if(istrue(self.oob) || self.origin[2] <= -1429) {
      if(!istrue(self.binc130)) {
        thread scripts\cp\cp_outofbounds::playeroutoftimecallback("oob_timeout_end", "clear_oob");
      }
    }
  }

  if(istrue(self.unset_relic_oneclip)) {
    thread ref_12de6();
  }

  self notify("landed_after_respawn");
}

function ref_12de6() {
  self.unset_relic_oneclip = undefined;
}

function little_bird_mg_initdamage(var_0) {
  self endon("death");
  thread ref_12bfa();
  self.waitgiveammo = 1;
  scripts\common\utility::allow_usability(0);
  wait var_0;
  self.waitgiveammo = undefined;
  scripts\common\utility::allow_usability(1);
  self notify("kill_watcher_threads_for_this");
}

function ref_12bfa() {
  self endon("kill_watcher_threads_for_this");
  scripts\engine\utility::ref_143a5("death", "last_stand");
  scripts\common\utility::allow_usability(1);
  self.waitgiveammo = undefined;
}

function watchnukeweaponenduse(var_0, var_1) {
  self notify("watchNukeWeaponEndUse");
  self endon("watchNukeWeaponEndUse");
  self notifyonplayercommand("manual_switch_from_core", "+weapnext");
  thread ref_13c53();
  thread ref_13367();
  thread removenukeweapononaction("switched_from_core", var_1);
  thread removenukeweapononaction("death", var_1);
  thread removenukeweapononaction("last_stand", var_1);
  thread watchnukeweaponswitch(var_0, var_1);
  thread ref_1196e();
  thread ref_144af();
  self.c4_placed_bc = 1;
}

function ref_13c53() {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self endon("dropped_core");
  self notify("trackNonOOBPlayerLocation");
  self endon("trackNonOOBPlayerLocation");
  self.waittill_any_timeout_6 = self.origin;

  for(;;) {
    wait 1;

    if(scripts\cp\cp_outofbounds::isoob(self, 0)) {
      continue;
    }

    self.waittill_any_timeout_6 = self.origin;
  }
}

function ref_13367() {
  self notify("showPlayerLowerMessageHint");
  self endon("showPlayerLowerMessageHint");
  scripts\cp\utility::hint_prompt("drop_core", 1);
}

function ref_1196e() {
  self endon("disconnect");
  self notify("location_tracker");
  self endon("location_tracker");
  self endon("dropped_core");
  level.ref_11edf = spawnStruct();
  level.ref_11edf.origin = (0, 0, 0);
  level.ref_11edf.angles = (0, 0, 0);

  for(;;) {
    if(scripts\cp\cp_outofbounds::isoob(self, 0)) {
      waitframe();
      continue;
    }

    level.ref_11edf.origin = self.origin;
    level.ref_11edf.angles = self.angles;
    waitframe();
  }
}

function ref_144af() {
  self notify("watchForCarrierDisconnect");
  self endon("watchForCarrierDisconnect");
  self waittill("disconnect");

  if(isDefined(self.headicon)) {
    thread scripts\cp\utility::ent_deleteheadicon(self, self.headicon);
  }

  var_0 = level.ref_11edf.origin;
  level.nuclear_core_carrier = undefined;
  level.nuclear_core = ref_11aa1(var_0 + (0, 0, 64));
}

function watchnukeweaponswitch(var_0, var_1) {
  self endon("death");
  self endon("disconnect");
  self endon("dropped_core");
  level endon("game_ended");
  self notify("watchNukeWeaponSwitch");
  self endon("watchNukeWeaponSwitch");

  for(;;) {
    self waittill("manual_switch_from_core", var_2, var_3);

    if(istrue(var_3)) {
      self notify("switched_from_core");
    }

    if(isDefined(var_2)) {
      self takeweapon(var_1);
      self notify("switched_from_core");
      continue;
    }

    if(self getcurrentweapon() != var_0) {
      continue;
    }

    self notify("switched_from_core");
    break;
  }
}

function removenukeweapononaction(var_0, var_1) {
  if(!isDefined(var_0)) {
    return;
  }

  self endon("disconnect");
  self endon("dropped_core");
  level endon("game_ended");
  self endon("end_nuke_threads");
  self notify("removeNukeWeaponOnAction" + var_0);
  self endon("removeNukeWeaponOnAction" + var_0);
  self waittill(var_0, var_2);

  if(var_0 == "death") {
    return;
  }

  level.nuclear_core_carrier = undefined;

  if(isDefined(var_2)) {
    dropnukeweapon(var_0, var_1, var_2);
  } else {
    dropnukeweapon(var_0, var_1);
  }

  self.c4_placed_bc = undefined;
}

function dropnukeweapon(var_0, var_1, var_2) {
  self.mine_explosion_vfx = 1;
  self.playerstreakspeedscale = undefined;

  if(!istrue(self.c4_placed_bc) && istrue(self.inlaststand)) {
    if(!isDefined(var_1)) {
      var_1 = self.lastdroppableweaponobj;
    }
  } else if(!isDefined(self.play_disguise_vo)) {
    scripts\mp\playeractions::allowactionset("nuke_core", 1);
  }

  if(isDefined(level.outofboundstriggers) && level.outofboundstriggers.size > 0) {
    if(istrue(self.oob)) {
      self notify("location_tracker");
      level.ref_11edf.origin = getEnt("nuclear_core_crashed", "targetname").origin;
      level.ref_11edf.angles = getEnt("nuclear_core_crashed", "targetname").angles;
    }
  }

  self allowmountside(1);
  self allowmounttop(1);
  self allowjog(1);

  if(isDefined(self.headicon)) {
    scripts\cp_mp\entityheadicons::setheadicon_deleteicon(self.headicon);
    self.headicon = undefined;
  }

  var_3 = self.origin;

  if(scripts\cp\cp_outofbounds::isoob(self, 0)) {
    var_3 = level.ref_11edf.origin;
  }

  scripts\cp\utility::hint_prompt("drop_core", 0);
  var_4 = self getcurrentweapon();

  if(!isDefined(var_4) || var_4.basename == "none") {
    var_4 = getcompleteweaponname("iw8_nukecore_mp");
  }

  if(var_4.basename == "iw8_lm_dblmg_mp") {
    scripts\cp_mp\utility\inventory_utility::_takeweapon(getcompleteweaponname("iw8_nukecore_mp"));
  } else if(isDefined(var_2)) {
    if(issameweapon(var_2)) {
      scripts\cp_mp\utility\inventory_utility::_takeweapon(var_1);
    } else if(isstring(var_2)) {
      scripts\cp_mp\utility\inventory_utility::_takeweapon(var_1);
    }
  } else {
    scripts\cp_mp\utility\inventory_utility::_takeweapon(var_4);
  }

  level.nuclear_core = ref_11aa1(var_3 + (0, 0, 64));

  if(isDefined(var_2)) {
    if(issameweapon(var_2)) {
      self.lastdroppableweaponobj = var_2;
      self switchtoweaponimmediate(var_2);
    } else if(isstring(var_2)) {
      var_5 = getcompleteweaponname(var_2);
      self.lastdroppableweaponobj = var_5;
      self switchtoweaponimmediate(var_5);
    }
  } else if(isDefined(var_1)) {
    self.lastdroppableweaponobj = var_1;
    self switchtoweaponimmediate(var_1);
  }

  self.mine_explosion_vfx = undefined;
  self notify("dropped_core");
}

function ref_11aa1(var_0) {
  var_1 = spawn("script_model", var_0);
  var_1 setModel("military_nuke_core_ball");
  var_1 physicslaunchserver(var_1.origin, (0, 0, -1));
  var_2 = var_1 physics_getbodyid(0);
  physics_setbodycenterofmassnormal(var_2, (0, 0, -1));
  var_1 physics_registerforcollisioncallback();
  watchnukeimpact(var_1);

  if(!isDefined(var_1)) {} else {
    var_1 scripts\cp\utility::createhintobject("tag_origin", "HINT_BUTTON", undefined, &"CP_FUBAR/PICKUP_CORE", undefined, "duration_short", undefined, 500, 120, 100, 120, var_1);
    var_1.objid = scripts\cp\utility::nonobjective_requestobjectiveid();
    scripts\cp\cp_objectives::minimap_objective_add(var_1.objid, "current", var_1.origin, "cp_tac_hud_icon_nuke");
    scripts\cp\cp_objectives::minimap_objective_onentitywithrotation(var_1.objid, var_1);
    scripts\cp\cp_objectives::minimap_objective_icon(var_1.objid, "cp_tac_hud_icon_nuke");
    objective_setzoffset(var_1.objid, 32);
    objective_setbackground(var_1.objid, 1);
    objective_setshowdistance(var_1.objid, 1);
    objective_sethot(var_1.objid, 1);
    objective_setpulsate(var_1.objid, 1);
    objective_setplayintro(var_1.objid, 0);
    thread give_nuclear_core();
  }

  level notify("dropped_core", var_1);
  return var_1;
}

function watchnukeimpact() {
  level endon("endthis");
  var_0 = 1;

  for(;;) {
    self waittill("collision", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
    var_9 = "airdrop_crate_impact";
    var_10 = gettime();
    self notify("current_impact_time", var_10);

    if(var_7 < 100) {} else if(var_7 < 200) {} else if(var_7 < 300) {} else if(var_7 < 400) {} else if(var_7 > 400) {}

    if(istrue(var_0)) {
      var_0 = 0;
    } else {
      self waittill("play_impact_fx");
    }

    level notify("interactions_start");
    level notify("endthis");
  }
}

function nuclear_core_delete_after_timeout() {
  self endon("death");
  wait 60;

  if(!isDefined(self)) {
    return;
  }

  announcement(" Your ENTIRE Squad Left the Nuclear Core in open Space for over a minute. FAILED! ");
  level thread[[level.endgame]]("axis", level.end_game_string_index["kia"]);
  self delete();
}

function watcher_for_core_pickup() {
  self endon("dropped_core");

  for(;;) {
    self waittill("finish_pickup_of_weapon", var_0, var_1);
    scripts\cp\utility::_giveweapon(var_0);
    self notify("switched_from_core", var_0);
  }
}

function watchpickup() {
  self endon("death");
  var_0 = scripts\cp\cp_weapon::getitemweaponname();

  for(;;) {
    self waittill("trigger", var_1, var_2);
    var_3 = undefined;

    if(isDefined(var_2)) {
      var_3 = var_1.lastdroppableweaponobj;
    } else if(var_1.lastweaponobj.basename == "iw8_nukecore_mp") {
      var_3 = var_1.lastdroppableweaponobj;
      forcedropweapon(var_1);
      var_1 scripts\cp\utility::_giveweapon("iw8_nukecore_mp");
    } else {
      var_3 = var_1 getcurrentweapon();
    }

    thread watchpickupcomplete(var_1, self.objweapon);
    var_1 notify("weapon_pickup", self.objweapon);
    var_4 = fixupplayerweapons(var_1, var_0);
  }

  LOC_000000a9:
    if(isDefined(var_2)) {
      var_5 = var_2 scripts\cp\cp_weapon::getitemweaponname();
      var_6 = asmdevgetallstates(var_5);

      if(isDefined(var_1.tookweaponfrom[var_5])) {
        var_2.owner = var_1.tookweaponfrom[var_5];
        var_1.tookweaponfrom[var_5] = undefined;
      }

      var_2.objweapon = var_6;
      var_2.targetname = "dropped_weapon";
      thread watchpickup();
    }

  var_1.tookweaponfrom[var_0] = self.owner;
}

function forcedropweapon(var_0) {
  if(isDefined(level.blockweapondrops)) {
    return;
  }

  if(isDefined(self.droppeddeathweapon)) {
    return;
  }

  var_1 = self.lastdroppableweaponobj;

  if(isDefined(var_0)) {
    var_1 = var_0;
  }

  if(!isDefined(var_1)) {
    return;
  }

  if(var_1.basename == "none") {
    return;
  }

  if(!self hasweapon(var_1)) {
    return;
  }

  if(isDefined(level.gamemodemaydropweapon) && !self[[level.gamemodemaydropweapon]](var_1)) {
    return;
  }

  var_1 = var_1 getnoaltweapon();
  var_2 = 0;
  var_3 = 0;
  var_4 = 0;

  if(!scripts\cp_mp\parachute::isriotshield_parachute(var_1.basename)) {
    if(!self anyammoforweaponmodes(var_1)) {
      return;
    }

    var_2 = self getweaponammoclip(var_1, "right");
    var_3 = self getweaponammoclip(var_1, "left");

    if(!var_2 && !var_3) {
      return;
    }

    var_4 = self getweaponammostock(var_1);
    var_5 = weaponmaxammo(var_1);

    if(var_4 > var_5) {
      var_4 = var_5;
    }

    var_6 = self dropitem(var_1);

    if(!isDefined(var_6)) {
      return;
    }

    if(istrue(level.clearstockondrop)) {
      var_4 = 0;
    }

    var_6 itemweaponsetammo(var_2, var_4, var_3);
  } else {
    var_6 = self dropitem(var_2);

    if(!isDefined(var_6)) {
      return;
    }

    var_6 itemweaponsetammo(1, 1, 0);
  }

  var_6 sethintdisplayrange(96);
  var_6 setuserange(96);
  var_6.owner = self;
  var_6.targetname = "dropped_weapon";
  var_6.objweapon = var_2;
  thread watchpickup();
}

function deletepickupafterawhile() {
  self endon("death");
  wait 60;

  if(!isDefined(self)) {
    return;
  }

  self delete();
}

function fixupplayerweapons(var_0, var_1) {
  var_2 = var_0 getweaponslistprimaries();
  var_3 = 1;
  var_4 = 1;
  var_5 = undefined;

  if(issameweapon(var_1)) {
    var_5 = createheadicon(var_1);
  } else {
    var_5 = var_1;
  }

  foreach(var_7 in var_2) {
    if(isDefined(var_0.primaryweaponobj) && var_0.primaryweaponobj == var_7) {
      var_3 = 0;
      continue;
    }

    if(isDefined(var_0.secondaryweaponobj) && var_0.secondaryweaponobj == var_7) {
      var_4 = 0;
    }
  }

  if(var_3) {
    var_0.primaryweapon = var_5;
    var_0.primaryweaponobj = asmdevgetallstates(var_5);
  } else if(var_4) {
    var_0.secondaryweapon = var_5;
    var_0.secondaryweaponobj = asmdevgetallstates(var_5);
  }

  return var_3 || var_4;
}

function watchpickupcomplete(var_0, var_1, var_2) {
  self endon("death_or_disconnect");
  self notify("watchPickupComplete()");
  self endon("watchPickupComplete()");
  var_3 = self.currentweapon;
  var_4 = 0;
  jumpiffalse(var_3 == var_0) LOC_00000033;
  var_4 = 1;
  goto LOC_00000069;
}

function nuclearcorepickedup(var_0, var_1) {
  scripts\mp\playeractions::allowactionset("nuke_core", 0);
  self allowmountside(0);
  self allowmounttop(0);
  self allowjog(0);
  watchnukeweaponenduse(var_0, var_1);
}

function give_nuclear_core() {
  self endon("death");
  self notify("give_nuclear_core");
  self endon("give_nuclear_core");

  for(;;) {
    self waittill("trigger", var_0);

    if(!isPlayer(var_0)) {
      continue;
    }

    if(var_0 meleeButtonPressed()) {
      continue;
    }

    level.nuclear_core_carrier = var_0;

    if(var_0 hasweapon("iw8_lm_dblmg_mp")) {
      var_0 thread scripts\cp\utility::hint_prompt("cant_pick_jugg", 1, 2);
      continue;
    }

    var_1 = var_0 getcurrentweapon();
    var_2 = getcompleteweaponname("iw8_nukecore_mp");
    var_0 scripts\cp\utility::_giveweapon(var_2);
    var_0 switchtoweapon(var_2);
    var_0 scripts\mp\playeractions::allowactionset("nuke_core", 0);
    var_0 allowmountside(0);
    var_0 allowmounttop(0);
    var_0 allowjog(0);
    watchnukeweaponenduse(var_0, var_2, var_1);
    thread watcher_for_core_pickup();
    var_0.headicon = var_0 thread scripts\cp_mp\entityheadicons::setheadicon_singleimage(level.players, "cp_tac_hud_icon_nuke", 30, 1, 29000, 29000, undefined, 1, 0, undefined, 1);

    foreach(var_4 in level.players) {
      if(istrue(var_4.binc130)) {
        if(istrue(level.ref_11eda)) {
          scripts\cp_mp\entityheadicons::ref_1315e(var_0.headicon, var_4);
        }

        continue;
      }

      if(istrue(level.ref_11eda)) {
        thread autofeeder(var_4, 4);
        continue;
      }

      scripts\cp_mp\entityheadicons::ref_1315e(var_0.headicon, var_4);
      LOC_00000154:
    }

    scripts\cp\utility::nonobjective_returnobjectiveid(self.objid);
    self delete();
  }
}

function autofeeder(var_0, var_1) {
  var_0 endon("disconnect");
  wait var_1;

  if(isDefined(level.nuclear_core_carrier)) {
    scripts\cp_mp\entityheadicons::ref_1315d(level.nuclear_core_carrier.headicon, var_0);
    return;
  }
}

function start_automated_respawn_func() {
  level.automated_respawn_delay_skip = 1;
  wait level.automated_respawn_delay;
  automated_respawn_sequence();
  level.automated_respawn_delay_skip = undefined;
}

function automated_respawn_sequence() {
  level.respawn_uses++;
  level.respawn_in_progress = 1;
  var_0 = [];

  foreach(var_2 in level.players) {
    if(scripts\cp\cp_laststand::player_in_laststand(var_2)) {
      continue;
    }

    var_0 = scripts\engine\utility::array_add(var_0, var_2);
  }

  var_4 = scripts\engine\utility::random(var_0);
  scripts\cp\respawn\cp_ac130_respawn::start_ac130_respawn_sequence(var_4.origin, level.players_in_respawn_queue, var_4);

  foreach(var_2 in level.players) {
    var_2 thread scripts\cp\cp_hud_message::showsplash("cp_used_respawn");
    thread toggle_respawn_functionality_after_timeout(var_2);
  }

  level.respawn_in_progress = undefined;
}

function show_respawn_hint_lastplayer() {
  self setclientomnvar("ui_gettocover_text", "coop_game_play_respawn_allies_hint");
  self.disabletakecoverwarning = 1;
  self setclientomnvar("ui_gettocover_state", 1);
  wait 1;
  self setclientomnvar("ui_gettocover_state", 2);
  wait 1;
  self setclientomnvar("ui_gettocover_state", 3);
  wait 1;
  self setclientomnvar("ui_gettocover_state", 4);
  wait 1;
  self setclientomnvar("ui_gettocover_state", 5);
  wait 1;
  self setclientomnvar("ui_gettocover_state", 0);
  self setclientomnvar("ui_gettocover_text", "game/get_to_cover");
  self.disabletakecoverwarning = undefined;
}

function show_respawn_hint() {
  thread scripts\cp\utility::hint_prompt("respawn_jump", 1);
  scripts\engine\utility::ref_143b9(6, "br_jump");
  self setclientomnvar("zm_hint_index", 0);
}

function hotjoin_via_ac130() {
  if(!can_do_hotjoin_via_ac130()) {
    return;
  }

  if(istrue(level.dogtag_revive)) {
    return;
  }

  self.unset_relic_oneclip = 1;
  self notify("start_hotjoining_via_c130");
  var_0 = (0, 0, 0);
  var_1 = scripts\cp\respawn\cp_ac130_respawn::get_path_over_players(var_0, undefined, 1);
  thread scripts\cp\respawn\cp_ac130_respawn::spawnc130(var_1, 1, self);
  thread scripts\cp\respawn\cp_ac130_respawn::start_black_screen(self, 1);
}

function can_do_hotjoin_via_ac130() {
  return !istrue(level.disable_hotjoin_via_ac130);
}

function takeweaponsdefaultfunc() {
  if(isDefined(level.nuclear_core_carrier)) {
    if(level.nuclear_core_carrier == self) {
      var_0 = self getcurrentweapon();
      self takeweapon(var_0);
      self notify("end_nuke_threads");
      scripts\mp\playeractions::allowactionset("nuke_core", 1);
      self allowmountside(1);
      self allowmounttop(1);
      self allowjog(1);
      thread ref_1196e();
    }
  }

  if(isDefined(self.primaryweaponobj)) {
    self.primaryweaponclipammo = self getweaponammoclip(self.primaryweaponobj);
    self.primaryweaponstockammo = self getweaponammostock(self.primaryweaponobj);
  }

  if(isDefined(self.secondaryweaponobj)) {
    self.secondaryweaponclipammo = self getweaponammoclip(self.secondaryweaponobj);
    self.secondaryweaponstockammo = self getweaponammostock(self.secondaryweaponobj);
  }

  var_1 = getcompleteweaponname("iw8_fists_mp");
  var_2 = getcompleteweaponname("none");
  self.weaponlist = self.primaryweapons;

  for(var_3 = 0; var_3 < self.weaponlist.size; var_3++) {
    var_4 = self.weaponlist[var_3];

    if(isDefined(var_4) && !isnullweapon(var_1, var_4) && !isnullweapon(var_2, var_4)) {
      self takeweapon(var_4);
    }
  }

  self clearaccessory();

  if(!self hasweapon(var_1)) {
    scripts\cp_mp\utility\inventory_utility::_giveweapon(var_1, undefined, undefined, 1);
  }

  scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(var_1, 1);
  thread ref_14468();
}

function ref_14468() {
  self endon("death");
  self endon("disconnect");
  self endon("kill_thread_watch_for_player_going_belowmap_or_oob");
  self notify("watch_for_player_going_belowmap_or_oob");
  self endon("watch_for_player_going_belowmap_or_oob");
  self endon("parachute_complete");

  for(;;) {
    wait 1;

    if(isDefined(level.outofboundstriggers) && level.outofboundstriggers.size > 0) {
      if(self.origin[2] <= -1429) {
        if(istrue(self.binc130)) {
          continue;
        }

        self skydive_interrupt();
        self.shouldskiplaststand = 1;
        self.shouldskipdeathshield = 1;
        thread scripts\cp\cp_outofbounds::playeroutoftimecallback("oob_timeout_end", "clear_oob");
        self notify("kill_thread_watch_for_player_going_belowmap_or_oob");
      }
    }

    waitframe();
  }
}

function removecameraondisconnect(var_0) {
  self endon("spawn_camera_deleted");
  self waittill("disconnect");

  if(isDefined(var_0)) {
    var_0 delete();
    return;
  }
}

function ref_1380a(var_0, var_1) {
  var_2 = vectorNormalize(var_0.origin - var_1.origin);
  var_3 = var_0.origin + var_2 * -8500 + (0, 0, 7000);
  var_4 = vectorNormalize(var_0.origin - var_3);
  var_5 = scripts\cp\utility::vectortoanglessafe(var_4, (0, 0, 1));
  var_6 = spawnStruct();
  var_6.origin = var_3;
  var_6.angles = var_5;
  var_7 = var_6.origin;
  var_8 = var_6.angles;
  var_9 = var_0.spawncameraent.origin;
  var_10 = vectorNormalize(var_9 - var_6.origin);
  var_11 = scripts\cp\utility::vectortoanglessafe(var_10, (0, 0, 1));
  var_0.spawncameraent.angles = var_11;
  var_12 = distance(var_9, var_7);
  var_13 = var_12 / 3520;
  var_13 = clamp(var_13, 1.5, 3);
  var_0.spawncameratargetpos = var_7;
  var_0.spawncameratargetang = var_8;
  var_0.spawncameratime = var_13;
  var_0.spawncameraendtime = gettime() + var_13 * 1000;
  var_0 earthquakeforplayer(0.03, 15, var_7, 1000);
}

function startspawncamera(var_0) {
  self endon("disconnect");
  scripts\cp\utility::hideminimap(1);

  if(isai(self)) {
    return;
  }

  if(istrue(self.inmhccam)) {
    return;
  }

  if(istrue(level.gameended)) {
    return;
  }

  self.inmhccam = 1;
  thread ref_12768(0, 0.25, 0.25);
  waitframe();
  scripts\engine\utility::ref_143bf(0.1, "force_spawn");
  var_1 = self getEye();
  var_2 = self.angles;
  self.deathspectatepos = var_1;
  self.deathspectateangles = var_2;

  if(!isDefined(self.spawncameraent)) {
    var_3 = spawn("script_model", self.deathspectatepos);
    var_3 setModel("tag_origin");
    var_3.angles = self.deathspectateangles;
    self.spawncameraent = var_3;
    self playerlinkTo(self.spawncameraent);
  } else {
    self.spawncameraent.origin = self.deathspectatepos;
    self.spawncameraent.angles = self.deathspectateangles;
  }

  thread removecameraondisconnect(self.spawncameraent);
  self cameralinkTo(self.spawncameraent, "tag_origin", 1, 1);
  snaptospawncamera(var_0);
}

function entitylerpovertime(var_0, var_1, var_2, var_3, var_4) {
  var_0 endon("death");

  if(var_3 <= 0) {
    var_3 = 1;
  }

  var_5 = 1 / var_3 / 0.05;
  var_6 = 0;
  var_7 = var_0.origin;
  var_8 = var_0.angles;
  jumpiffalse(var_4 == 2) LOC_00000053;
  level.c130 notify("players_viewing_crash");

  while(var_6 < 1) {
    var_9 = vectorlerp(var_7, var_1, var_6);
    var_10 = scripts\engine\math::fake_slerp(var_8, var_2, var_6);

    if(isPlayer(var_0) || isagent(var_0)) {
      var_0 setOrigin(var_9, 1);
      var_0 setplayerangles(var_10);
    } else {
      var_0.origin = var_9;
      var_0.angles = var_10;
    }

    var_6 += var_5;
    waitframe();
  }

  if(isPlayer(var_0) || isagent(var_0)) {
    var_0 setOrigin(var_1, 1);
    var_0 setplayerangles(var_2);
    return;
  }

  var_0.origin = var_1;
  var_0.angles = var_2;
}

function get_lerped_origin(var_0, var_1, var_2) {
  return vectorlerp(var_0, var_1, var_2);
}

function get_fake_slerped_angles(var_0, var_1, var_2) {
  return scripts\engine\math::fake_slerp(var_0, var_1, var_2);
}

function ref_12768(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_3)) {
    var_3 = "black";
  }

  var_4 = newclienthudelem(self);
  var_4.x = 0;
  var_4.y = 0;
  var_4.alignx = "left";
  var_4.aligny = "top";
  var_4.sort = 1;
  var_4.horzalign = "fullscreen";
  var_4.vertalign = "fullscreen";
  var_4.foreground = 1;

  if(isDefined(var_0) && var_0 > 0) {
    var_4.alpha = 0;
  } else {
    var_4.alpha = 1;
  }

  var_4 setshader(var_3, 640, 480);

  if(isDefined(var_0) && var_0 > 0) {
    self notify("fadeDown_start");
    var_4 fadeovertime(var_0);
    var_4.alpha = 1;
    wait var_0;
    self notify("fadeDown_complete");
  }

  if(isDefined(var_1) && var_1 > 0) {
    wait var_1;
  }

  self notify("fadeUp_start");

  if(!isDefined(var_2)) {
    var_2 = 0.5;
  }

  var_4 fadeovertime(var_2);
  var_4.alpha = 0;
  wait var_2;
  self notify("fadeUp_complete");

  if(isDefined(var_4)) {
    var_4 destroy();
    return;
  }
}

function snaptospawncamera(var_0) {
  self endon("disconnect");
  self waittill("fadeUp_start");
  var_1 = var_0;
  self.spawncameraent.origin = var_1.origin;
  self.spawncameraent.angles = var_1.angles;
  self visionsetnakedforplayer("", 0);
  applythermal();

  if(isDefined(self) && isDefined(self.spawncameraent)) {
    var_2 = anglesToForward(self.spawncameraent.angles) * 300;
    var_2 *= (1, 1, 0);
    self.spawncameraent moveTo(self.spawncameraent.origin + var_2, 15, 1, 1);
    self earthquakeforplayer(0.03, 15, self.spawncameraent.origin, 1000);
  }

  self cameraunlink();
  self notify("spawn_camera_idle");
}

function runslamzoomonspawn(var_0) {
  self endon("disconnect");
  thread scripts\cp\utility::drawline(self.spawncameraent.origin, self.origin, 100000, (1, 0, 0));
  self cameralinkTo(self.spawncameraent, "tag_origin", 1, 1);
  handlemovetoblended(var_0);
}

function deletespawncamera() {
  self cameraunlink();

  if(isDefined(self.spawncameraent)) {
    self.spawncameraent delete();
  }

  self notify("spawn_camera_deleted");
}

function handlemovetoblended(var_0) {
  self endon("disconnect");
  var_1 = var_0.origin + (0, 0, 60);
  var_2 = var_0.angles;
  var_3 = angle_diff(self.spawncameraent.angles[1], var_2[1]) < 45;
  var_4 = distance2dsquared(self.spawncameraent.origin, var_1) > 1000000;

  if(!var_3 || !var_4) {
    removethermal();
    self visionsetnakedforplayer("", 0);
    wait 0.05;
    self.spawncameraent moveTo(var_1, 1, 0.1, 0.9);
    self.spawncameraent rotateTo(var_2, 1, 0.9, 0.1);
    self visionsetnakedforplayer("tac_ops_slamzoom", 0.8);
    wait 0.8;
    self visionsetnakedforplayer("", 0.2);
    wait 0.2;
  } else {
    var_5 = vectorNormalize(var_1 - self.spawncameraent.origin);
    var_6 = scripts\cp\utility::vectortoanglessafe(var_5, (0, 0, 1));
    self.spawncameraent rotateTo(var_6, 0.7, 0.2, 0.2);
    removethermal();
    self visionsetnakedforplayer("", 0);
    wait 0.05;
    self.spawncameraent moveTo(var_1, 1, 0.1, 0.9);
    self visionsetnakedforplayer("tac_ops_slamzoom", 0.8);
    wait 0.5;
    self.spawncameraent rotateTo(var_2, 0.5, 0.2, 0.1);
    wait 0.3;
    self visionsetnakedforplayer("", 0.2);
  }

  self notify("spawn_camera_complete");
}

function angle_diff(var_0, var_1) {
  return 180 - abs(abs(var_0 - var_1) - 180);
}

function applythermal() {
  self visionsetthermalforplayer("proto_apache_flir_mp");
  self thermalvisionon();
}

function removethermal() {
  self thermalvisionoff();
}

function play_mhc_plane_escape_skit() {
  self freezecontrols(1);
  self playerhide();
  camera_setup_for_lerping();
  self visionsetnakedforplayer("tac_ops_slamzoom", 0.8);

  for(var_0 = 0; var_0 < level.mhc_escape_ents_array.size; var_0++) {
    entitylerpovertime(self.spawncameraent, level.mhc_escape_ents_array[var_0].origin + (0, 0, 64), level.mhc_escape_ents_array[var_0].angles, 1 - var_0 * 0.25, var_0);
  }

  self visionsetnakedforplayer("", 1);
  deletespawncamera();
  self unlink();
  self playershow();
}

function delay_giving_controls_back() {
  wait 10;
  self freezecontrols(0);
}

function create_mhc_path() {
  var_0 = getEnt("mhc_camera_start", "script_noteworthy");
  var_1 = [var_0];

  while(isDefined(var_0.target)) {
    var_0 = getEnt(var_0.target, "targetname");

    if(isDefined(var_0.script_linkto)) {
      var_2 = [var_0];
      var_3 = var_0 scripts\engine\utility::get_linked_structs();
      var_1 = scripts\engine\utility::array_combine(var_2, var_3);
      continue;
    }

    GscBinSkip0(0x2e, var_1.size, var_0);
  }

  return var_1;
}

function camera_setup_for_lerping(var_0, var_1) {
  var_0 endon("disconnect");

  if(isai(var_0)) {
    return;
  }

  if(istrue(var_0.inmhccam)) {
    return;
  }

  if(istrue(level.gameended)) {
    return;
  }

  var_0.inmhccam = 1;
  var_0.deathspectatepos = var_1.origin;
  var_0.deathspectateangles = var_1.angles;

  if(!isDefined(var_0.spawncameraent)) {
    var_2 = spawn("script_model", var_0.deathspectatepos);
    var_2 setModel("tag_origin");
    var_2.angles = var_0.deathspectateangles;
    var_0.spawncameraent = var_2;
    var_0 playerlinkTo(var_0.spawncameraent);
  } else {
    var_0.spawncameraent.origin = var_0.deathspectatepos;
    var_0.spawncameraent.angles = var_0.deathspectateangles;
  }

  thread removecameraondisconnect(var_0);
  var_0 cameralinkTo(var_0.spawncameraent, "tag_origin", 1, 1);
  thread ref_12768(var_0, 0, 1, 0.25);
  var_3 = vectorNormalize(var_0.origin - var_1.origin);
  var_4 = var_0.origin + var_3 * -8500 + (0, 0, 7000);
  var_5 = vectorNormalize(var_0.origin - var_4);
  var_6 = scripts\cp\utility::vectortoanglessafe(var_5, (0, 0, 1));
  var_7 = spawnStruct();
  var_7.origin = var_4;
  var_7.angles = var_6;
  var_8 = var_7.origin;
  var_9 = var_7.angles;
  var_10 = var_0.spawncameraent.origin;
  var_11 = vectorNormalize(var_10 - var_7.origin);
  var_12 = scripts\cp\utility::vectortoanglessafe(var_11, (0, 0, 1));
  var_0.spawncameraent.angles = var_12;
  var_13 = distance(var_10, var_8);
  var_14 = var_13 / 3520;
  var_14 = clamp(var_14, 1.5, 3);
  var_0.spawncameratargetpos = var_8;
  var_0.spawncameratargetang = var_9;
  var_0.spawncameratime = var_14;
  var_0.spawncameraendtime = gettime() + var_14 * 1000;
  var_0 earthquakeforplayer(0.03, 15, var_8, 1000);
  var_0.spawncameraent moveTo(var_8, 1, 0.25, 0.75);
  var_0.spawncameraent rotateTo(var_9, 1, 0.25, 0.75);
  wait 1;
  thread ref_12768(var_0, 0, 0.25);
  applythermal(var_0);
  thread startoperatorsound();

  if(isDefined(var_0) && isDefined(var_0.spawncameraent)) {
    var_15 = anglesToForward(var_9) * 300;
    var_15 *= (1, 1, 0);
    var_0.spawncameraent moveTo(var_1.origin + var_15, 15, 1, 1);
    var_0 earthquakeforplayer(0.03, 15, var_1.origin, 1000);
  }

  wait 1;
  removethermal(var_0);
  var_0 visionsetnakedforplayer("", 0);
  deletespawncamera(var_0);
  var_0.inmhccam = undefined;
}

function startoperatorsound() {
  self endon("disconnect");
  self endon("game_ended");

  if(istrue(self.spawnselectionoperatorsound)) {
    return;
  }

  var_0 = spawn("script_origin", (0, 0, 0));
  var_0 showonlytoplayer(self);
  self setsoundsubmix("iw8_mp_spawn_camera");
  var_1 = scripts\cp\cp_player_battlechatter::getteamvoiceinfix(self.team);
  var_2 = "dx_mpo_" + var_1 + "op_drone_deathchatter";

  if(soundexists(var_2)) {
    var_0 playLoopSound(var_2);
  } else {
    var_0 playLoopSound("dx_mpo_usop_drone_deathchatter");
  }

  self.spawnselectionoperatorsound = 1;
  self waittill("spawned_player");
  self clearsoundsubmix("iw8_mp_spawn_camera");
  var_0 stoploopsound(var_2);
  var_0 delete();
  self.spawnselectionoperatorsound = 0;
}