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
  var0 = getEntArray("minimap_corner", "targetname");
  var1 = level.mapcenter;

  if(var0.size) {
    var1 = scripts\cp\cp_globallogic::findboxcenter(var0[0].origin, var0[1].origin);
  }

  level.ac130 = spawn("script_model", var1);
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
  var0 = 10;
  var1 = level.ac130_speed["rotate"] / 360 * var0;
  level.ac130 rotateYaw(level.ac130.angles[2] + var0, var1, var1, 0);
  var2 = 360 / level.ac130_speed["rotate"];
  var3 = var2 * 0.0174533;
  level.ac130_magnitude = var3 * 9000;

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

  foreach(var1 in level.players) {
    var1 thread scripts\cp\cp_hud_message::showsplash("cp_used_respawn", undefined, self);
    thread toggle_respawn_functionality_after_timeout(var1);
  }

  level notify("respawn_used");
  level.respawn_in_progress = undefined;
}

function respawn_bleedout_func(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11) {
  scripts\cp\cp_laststand::enter_camera_zoomout();

  if(istrue(var0.fauxdead) || istrue(var0.binc130)) {
    var0.fauxdead = undefined;
    var0 scripts\cp\cp_laststand::enter_bleed_out(var0);
    var0 scripts\cp\cp_laststand::playslamzoomflash();
  } else {
    scripts\cp\cp_laststand::camera_zoomout(var0, var1, undefined);
  }

  scripts\cp\cp_laststand::exit_camera_zoomout();

  if(!isDefined(level.players_in_respawn_queue)) {
    level.players_in_respawn_queue = [];
  }

  level.players_in_respawn_queue = scripts\engine\utility::array_add(level.players_in_respawn_queue, var0);
  var12 = 0;
  var13 = undefined;

  foreach(var15 in level.players) {
    if(var15.sessionstate == "spectator") {
      var12++;
    }
  }

  if(var12 == level.players.size - 1) {
    foreach(var15 in level.players) {
      if(var15.sessionstate == "spectator") {}
    }
  }

  foreach(var15 in level.players) {
    if(!istrue(level.player_cam_disable)) {
      level.player_cam_disable = 1;

      foreach(var15 in level.players) {
        var15.respawn_active = 0;
        var15 notify("toggle_respawn_function", 1);
      }
    }
  }

  for(;;) {
    var23 = var0 scripts\engine\utility::ref_143ae("respawn_player", "auto_respawn", "forced_revive_to_regroup");

    if(isDefined(var23)) {
      if(istrue(var0.binc130)) {
        continue;
      }

      if(istrue(level.ref_12213)) {
        continue;
      }

      if(var23 == "auto_respawn") {
        scripts\cp\respawn\cp_ac130_respawn::start_ac130_respawn_sequence(var0.origin, level.players_in_respawn_queue, var0);

        foreach(var15 in level.players) {
          var15 thread scripts\cp\cp_hud_message::showsplash("cp_auto_respawn");
        }

        var0 setclientomnvar("ui_hide_hud", 1);
        wait 2;
        var0 setclientomnvar("ui_hide_hud", 1);
        scripts\cp\cp_analytics::ref_119bb(var0);
      } else if(var23 == "respawn_player") {
        scripts\cp\cp_analytics::ref_119bd(var0);
      } else {
        var0.playerjailwaitvo = 1;
      }

      level.players_in_respawn_queue = scripts\engine\utility::array_remove(level.players_in_respawn_queue, var0);
      return 1;
    }
  }
}

function launch_respawn_functionality_for_players() {
  level notify("launch_respawn_functionality_for_players");
  level endon("launch_respawn_functionality_for_players");

  foreach(var1 in level.players) {
    if(scripts\engine\utility::array_contains(level.players_in_respawn_queue, var1)) {
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

    foreach(var1 in level.players_in_respawn_queue) {
      thread do_resurrection_logic(var1);
      level.players_in_respawn_queue = scripts\engine\utility::array_remove(level.players_in_respawn_queue, var1);
    }
  }
}

function do_resurrection_logic(var0) {
  scripts\cp\cp_laststand::record_revive_success(var0, self);
  var0 notify("revive_teammate", self);
  var1 = scripts\cp\cp_endgame::get_current_zone(var0);
  var2 = 1;
  self.last_stand_state = undefined;

  if(isPlayer(var0) && istrue(var0.can_give_revive_xp)) {
    var0.can_give_revive_xp = 0;
    return;
  }
}

function ref_13a9c(var0, var1, var2) {
  self setweaponhudiconoverride("actionslot" + var0, var1);

  if(isDefined(var2)) {
    thread ref_13a9d(var0, var2);
    return;
  }
}

function ref_13a9d(var0, var1) {
  self endon("death");
  self endon("removeActionslot" + var0);
  self notifyonplayercommand("team_revive_kbm", "killstreak4");

  for(;;) {
    self waittill("team_revive_kbm");
    self thread[[var1]]();
  }
}

function respawn_function_toggle() {
  self notify("respawn_function_toggle");
  self endon("respawn_function_toggle");

  for(;;) {
    self waittill("toggle_respawn_function", var0);

    if(istrue(var0)) {
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

function toggle_respawn_functionality_after_timeout(var0, var1) {
  self notify("start_respawn_cooldown");
  self endon("start_respawn_cooldown");
  level.automated_respawn_available = 0;
  self notify("toggle_respawn_function", 0);

  if(isDefined(var1) && isstring(var1)) {
    level waittill(var1);
  } else {
    level.time_till_next_respawn = level.respawn_cooldown;
    thread time_till_next_respawn_tick();
    var2 = gettime() + var0 * 1000;
    setomnvar("cp_team_respawn_timer", var2);

    for(var3 = var0; var3 >= 0; var3--) {
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
    var0 = gettime() + level.automated_respawn_delay * 1000;
    setomnvar("cp_auto_respawn_timer", var0);
    setomnvar("cp_team_respawn_display", 4);
    level.initialize_flag_role = level.automated_respawn_delay;

    while(level.initialize_flag_role >= 0) {
      wait 1;
      level.initialize_flag_role--;
    }

    setomnvar("cp_auto_respawn_timer", 0);
    setomnvar("cp_team_respawn_display", 0);

    foreach(var2 in level.players) {
      var2 notify("auto_respawn");
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
      foreach(var1 in self.copy_fullweaponlist) {
        if(!self hasweapon(var1)) {
          self giveweapon(var1, -1, 0, -1, 1);
        }

        var2 = createheadicon(var1);

        if(isDefined(self.powerprimarygrenade) && self.powerprimarygrenade == var2) {
          self assignweaponoffhandprimary(var1);
        }

        if(isDefined(self.powersecondarygrenade) && self.powersecondarygrenade == var2) {
          self assignweaponoffhandsecondary(var1);
        }

        if(isDefined(self.specialoffhandgrenade) && self.specialoffhandgrenade == var2) {
          self assignweaponoffhandspecial(var1);
        }

        var3 = self getweaponammoclip(var1, "left");
        var4 = self getweaponammoclip(var1, "right");
        self setweaponammoclip(var1, var3, "left");
        self setweaponammoclip(var1, var4, "right");

        if(isDefined(self.copy_weapon_ammo_stock[var2])) {
          self setweaponammostock(var1, self.copy_weapon_ammo_stock[var2]);
        }
      }

      var6 = self.copy_weapon_current;

      if(getqueuedspleveltransients(var6)) {
        foreach(var8 in self.copy_fullweaponlist) {
          if(scripts\cp\cp_weapon::isbulletweapon(var8)) {
            var6 = var8;
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
      var10 = scripts\cp\loot_system::get_empty_munition_slot(self);

      if(isDefined(var10)) {
        scripts\cp\cp_munitions::give_munition_to_slot("juggernaut", var10);
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
        var11 = getcompleteweaponname("iw8_nukecore_mp");
        scripts\cp\utility::_giveweapon(var11, undefined, undefined, 0);
        self switchtoweaponimmediate(var11);
        scripts\mp\playeractions::allowactionset("nuke_core", 0);
        self allowmountside(0);
        self allowmounttop(0);
        self allowjog(0);
        watchnukeweaponenduse(var11, self.primaryweaponobj);
      } else {
        scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(self.weaponlist[0]);
      }
    } else {
      scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(self.weaponlist[0]);
    }

    if(isDefined(self.weaponlist) && self.weaponlist.size > 1) {
      if(scripts\cp\cp_weapon::iscacprimaryweapon(self.weaponlist[0].basename)) {
        var12 = 0;

        for(var13 = 0; var13 < self.weaponlist.size; var13++) {
          if(istrue(self.weaponlist[var13].isalternate)) {
            continue;
          }

          if(!var12) {
            self.primaryweaponobj = self.weaponlist[var13];
            var12 = 1;
            continue;
          }

          self.secondaryweaponobj = self.weaponlist[var13];
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
      var14 = weaponclipsize(self.primaryweaponobj);
      var15 = self getweaponammoclip(self.primaryweaponobj);
      var16 = self getweaponammostock(self.primaryweaponobj);

      if(var15 < var14) {
        var17 = var14 - var15;

        if(var17 >= var16) {
          var15 += var16;
          var16 = 0;
        } else {
          var15 = var14;
          var16 -= var17;
        }
      }

      self.primaryweaponclipammo = var15;
      self.primaryweaponstockammo = var16;

      if(isDefined(self.primaryweaponclipammo)) {
        self setweaponammoclip(self.primaryweaponobj, self.primaryweaponclipammo);
        self setweaponammostock(self.primaryweaponobj, self.primaryweaponstockammo);
      }
    }

    if(isDefined(self.secondaryweaponobj)) {
      var14 = weaponclipsize(self.secondaryweaponobj);
      var15 = self getweaponammoclip(self.secondaryweaponobj);
      var16 = self getweaponammostock(self.secondaryweaponobj);

      if(var15 < var14) {
        var17 = var14 - var15;

        if(var17 >= var16) {
          var15 += var16;
          var16 = 0;
        } else {
          var15 = var14;
          var16 -= var17;
        }
      }

      self.secondaryweaponclipammo = var15;
      self.secondaryweaponstockammo = var16;

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

function little_bird_mg_initdamage(var0) {
  self endon("death");
  thread ref_12bfa();
  self.waitgiveammo = 1;
  scripts\common\utility::allow_usability(0);
  wait var0;
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

function watchnukeweaponenduse(var0, var1) {
  self notify("watchNukeWeaponEndUse");
  self endon("watchNukeWeaponEndUse");
  self notifyonplayercommand("manual_switch_from_core", "+weapnext");
  thread ref_13c53();
  thread ref_13367();
  thread removenukeweapononaction("switched_from_core", var1);
  thread removenukeweapononaction("death", var1);
  thread removenukeweapononaction("last_stand", var1);
  thread watchnukeweaponswitch(var0, var1);
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

  var0 = level.ref_11edf.origin;
  level.nuclear_core_carrier = undefined;
  level.nuclear_core = ref_11aa1(var0 + (0, 0, 64));
}

function watchnukeweaponswitch(var0, var1) {
  self endon("death");
  self endon("disconnect");
  self endon("dropped_core");
  level endon("game_ended");
  self notify("watchNukeWeaponSwitch");
  self endon("watchNukeWeaponSwitch");

  for(;;) {
    self waittill("manual_switch_from_core", var2, var3);

    if(istrue(var3)) {
      self notify("switched_from_core");
    }

    if(isDefined(var2)) {
      self takeweapon(var1);
      self notify("switched_from_core");
      continue;
    }

    if(self getcurrentweapon() != var0) {
      continue;
    }

    self notify("switched_from_core");
    break;
  }
}

function removenukeweapononaction(var0, var1) {
  if(!isDefined(var0)) {
    return;
  }

  self endon("disconnect");
  self endon("dropped_core");
  level endon("game_ended");
  self endon("end_nuke_threads");
  self notify("removeNukeWeaponOnAction" + var0);
  self endon("removeNukeWeaponOnAction" + var0);
  self waittill(var0, var2);

  if(var0 == "death") {
    return;
  }

  level.nuclear_core_carrier = undefined;

  if(isDefined(var2)) {
    dropnukeweapon(var0, var1, var2);
  } else {
    dropnukeweapon(var0, var1);
  }

  self.c4_placed_bc = undefined;
}

function dropnukeweapon(var0, var1, var2) {
  self.mine_explosion_vfx = 1;
  self.playerstreakspeedscale = undefined;

  if(!istrue(self.c4_placed_bc) && istrue(self.inlaststand)) {
    if(!isDefined(var1)) {
      var1 = self.lastdroppableweaponobj;
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

  var3 = self.origin;

  if(scripts\cp\cp_outofbounds::isoob(self, 0)) {
    var3 = level.ref_11edf.origin;
  }

  scripts\cp\utility::hint_prompt("drop_core", 0);
  var4 = self getcurrentweapon();

  if(!isDefined(var4) || var4.basename == "none") {
    var4 = getcompleteweaponname("iw8_nukecore_mp");
  }

  if(var4.basename == "iw8_lm_dblmg_mp") {
    scripts\cp_mp\utility\inventory_utility::_takeweapon(getcompleteweaponname("iw8_nukecore_mp"));
  } else if(isDefined(var2)) {
    if(issameweapon(var2)) {
      scripts\cp_mp\utility\inventory_utility::_takeweapon(var1);
    } else if(isstring(var2)) {
      scripts\cp_mp\utility\inventory_utility::_takeweapon(var1);
    }
  } else {
    scripts\cp_mp\utility\inventory_utility::_takeweapon(var4);
  }

  level.nuclear_core = ref_11aa1(var3 + (0, 0, 64));

  if(isDefined(var2)) {
    if(issameweapon(var2)) {
      self.lastdroppableweaponobj = var2;
      self switchtoweaponimmediate(var2);
    } else if(isstring(var2)) {
      var5 = getcompleteweaponname(var2);
      self.lastdroppableweaponobj = var5;
      self switchtoweaponimmediate(var5);
    }
  } else if(isDefined(var1)) {
    self.lastdroppableweaponobj = var1;
    self switchtoweaponimmediate(var1);
  }

  self.mine_explosion_vfx = undefined;
  self notify("dropped_core");
}

function ref_11aa1(var0) {
  var1 = spawn("script_model", var0);
  var1 setModel("military_nuke_core_ball");
  var1 physicslaunchserver(var1.origin, (0, 0, -1));
  var2 = var1 physics_getbodyid(0);
  physics_setbodycenterofmassnormal(var2, (0, 0, -1));
  var1 physics_registerforcollisioncallback();
  watchnukeimpact(var1);

  if(!isDefined(var1)) {} else {
    var1 scripts\cp\utility::createhintobject("tag_origin", "HINT_BUTTON", undefined, &"CP_FUBAR/PICKUP_CORE", undefined, "duration_short", undefined, 500, 120, 100, 120, var1);
    var1.objid = scripts\cp\utility::nonobjective_requestobjectiveid();
    scripts\cp\cp_objectives::minimap_objective_add(var1.objid, "current", var1.origin, "cp_tac_hud_icon_nuke");
    scripts\cp\cp_objectives::minimap_objective_onentitywithrotation(var1.objid, var1);
    scripts\cp\cp_objectives::minimap_objective_icon(var1.objid, "cp_tac_hud_icon_nuke");
    objective_setzoffset(var1.objid, 32);
    objective_setbackground(var1.objid, 1);
    objective_setshowdistance(var1.objid, 1);
    objective_sethot(var1.objid, 1);
    objective_setpulsate(var1.objid, 1);
    objective_setplayintro(var1.objid, 0);
    thread give_nuclear_core();
  }

  level notify("dropped_core", var1);
  return var1;
}

function watchnukeimpact() {
  level endon("endthis");
  var0 = 1;

  for(;;) {
    self waittill("collision", var1, var2, var3, var4, var5, var6, var7, var8);
    var9 = "airdrop_crate_impact";
    var10 = gettime();
    self notify("current_impact_time", var10);

    if(var7 < 100) {} else if(var7 < 200) {} else if(var7 < 300) {} else if(var7 < 400) {} else if(var7 > 400) {}

    if(istrue(var0)) {
      var0 = 0;
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
    self waittill("finish_pickup_of_weapon", var0, var1);
    scripts\cp\utility::_giveweapon(var0);
    self notify("switched_from_core", var0);
  }
}

function watchpickup() {
  self endon("death");
  var0 = scripts\cp\cp_weapon::getitemweaponname();

  for(;;) {
    self waittill("trigger", var1, var2);
    var3 = undefined;

    if(isDefined(var2)) {
      var3 = var1.lastdroppableweaponobj;
    } else if(var1.lastweaponobj.basename == "iw8_nukecore_mp") {
      var3 = var1.lastdroppableweaponobj;
      forcedropweapon(var1);
      var1 scripts\cp\utility::_giveweapon("iw8_nukecore_mp");
    } else {
      var3 = var1 getcurrentweapon();
    }

    thread watchpickupcomplete(var1, self.objweapon);
    var1 notify("weapon_pickup", self.objweapon);
    var4 = fixupplayerweapons(var1, var0);
  }

  LOC_000000a9:
    if(isDefined(var2)) {
      var5 = var2 scripts\cp\cp_weapon::getitemweaponname();
      var6 = asmdevgetallstates(var5);

      if(isDefined(var1.tookweaponfrom[var5])) {
        var2.owner = var1.tookweaponfrom[var5];
        var1.tookweaponfrom[var5] = undefined;
      }

      var2.objweapon = var6;
      var2.targetname = "dropped_weapon";
      thread watchpickup();
    }

  var1.tookweaponfrom[var0] = self.owner;
}

function forcedropweapon(var0) {
  if(isDefined(level.blockweapondrops)) {
    return;
  }

  if(isDefined(self.droppeddeathweapon)) {
    return;
  }

  var1 = self.lastdroppableweaponobj;

  if(isDefined(var0)) {
    var1 = var0;
  }

  if(!isDefined(var1)) {
    return;
  }

  if(var1.basename == "none") {
    return;
  }

  if(!self hasweapon(var1)) {
    return;
  }

  if(isDefined(level.gamemodemaydropweapon) && !self[[level.gamemodemaydropweapon]](var1)) {
    return;
  }

  var1 = var1 getnoaltweapon();
  var2 = 0;
  var3 = 0;
  var4 = 0;

  if(!scripts\cp_mp\parachute::isriotshield_parachute(var1.basename)) {
    if(!self anyammoforweaponmodes(var1)) {
      return;
    }

    var2 = self getweaponammoclip(var1, "right");
    var3 = self getweaponammoclip(var1, "left");

    if(!var2 && !var3) {
      return;
    }

    var4 = self getweaponammostock(var1);
    var5 = weaponmaxammo(var1);

    if(var4 > var5) {
      var4 = var5;
    }

    var6 = self dropitem(var1);

    if(!isDefined(var6)) {
      return;
    }

    if(istrue(level.clearstockondrop)) {
      var4 = 0;
    }

    var6 itemweaponsetammo(var2, var4, var3);
  } else {
    var6 = self dropitem(var2);

    if(!isDefined(var6)) {
      return;
    }

    var6 itemweaponsetammo(1, 1, 0);
  }

  var6 sethintdisplayrange(96);
  var6 setuserange(96);
  var6.owner = self;
  var6.targetname = "dropped_weapon";
  var6.objweapon = var2;
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

function fixupplayerweapons(var0, var1) {
  var2 = var0 getweaponslistprimaries();
  var3 = 1;
  var4 = 1;
  var5 = undefined;

  if(issameweapon(var1)) {
    var5 = createheadicon(var1);
  } else {
    var5 = var1;
  }

  foreach(var7 in var2) {
    if(isDefined(var0.primaryweaponobj) && var0.primaryweaponobj == var7) {
      var3 = 0;
      continue;
    }

    if(isDefined(var0.secondaryweaponobj) && var0.secondaryweaponobj == var7) {
      var4 = 0;
    }
  }

  if(var3) {
    var0.primaryweapon = var5;
    var0.primaryweaponobj = asmdevgetallstates(var5);
  } else if(var4) {
    var0.secondaryweapon = var5;
    var0.secondaryweaponobj = asmdevgetallstates(var5);
  }

  return var3 || var4;
}

function watchpickupcomplete(var0, var1, var2) {
  self endon("death_or_disconnect");
  self notify("watchPickupComplete()");
  self endon("watchPickupComplete()");
  var3 = self.currentweapon;
  var4 = 0;
  jumpiffalse(var3 == var0) LOC_00000033;
  var4 = 1;
  goto LOC_00000069;
}

function nuclearcorepickedup(var0, var1) {
  scripts\mp\playeractions::allowactionset("nuke_core", 0);
  self allowmountside(0);
  self allowmounttop(0);
  self allowjog(0);
  watchnukeweaponenduse(var0, var1);
}

function give_nuclear_core() {
  self endon("death");
  self notify("give_nuclear_core");
  self endon("give_nuclear_core");

  for(;;) {
    self waittill("trigger", var0);

    if(!isPlayer(var0)) {
      continue;
    }

    if(var0 meleeButtonPressed()) {
      continue;
    }

    level.nuclear_core_carrier = var0;

    if(var0 hasweapon("iw8_lm_dblmg_mp")) {
      var0 thread scripts\cp\utility::hint_prompt("cant_pick_jugg", 1, 2);
      continue;
    }

    var1 = var0 getcurrentweapon();
    var2 = getcompleteweaponname("iw8_nukecore_mp");
    var0 scripts\cp\utility::_giveweapon(var2);
    var0 switchtoweapon(var2);
    var0 scripts\mp\playeractions::allowactionset("nuke_core", 0);
    var0 allowmountside(0);
    var0 allowmounttop(0);
    var0 allowjog(0);
    watchnukeweaponenduse(var0, var2, var1);
    thread watcher_for_core_pickup();
    var0.headicon = var0 thread scripts\cp_mp\entityheadicons::setheadicon_singleimage(level.players, "cp_tac_hud_icon_nuke", 30, 1, 29000, 29000, undefined, 1, 0, undefined, 1);

    foreach(var4 in level.players) {
      if(istrue(var4.binc130)) {
        if(istrue(level.ref_11eda)) {
          scripts\cp_mp\entityheadicons::ref_1315e(var0.headicon, var4);
        }

        continue;
      }

      if(istrue(level.ref_11eda)) {
        thread autofeeder(var4, 4);
        continue;
      }

      scripts\cp_mp\entityheadicons::ref_1315e(var0.headicon, var4);
      LOC_00000154:
    }

    scripts\cp\utility::nonobjective_returnobjectiveid(self.objid);
    self delete();
  }
}

function autofeeder(var0, var1) {
  var0 endon("disconnect");
  wait var1;

  if(isDefined(level.nuclear_core_carrier)) {
    scripts\cp_mp\entityheadicons::ref_1315d(level.nuclear_core_carrier.headicon, var0);
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
  var0 = [];

  foreach(var2 in level.players) {
    if(scripts\cp\cp_laststand::player_in_laststand(var2)) {
      continue;
    }

    var0 = scripts\engine\utility::array_add(var0, var2);
  }

  var4 = scripts\engine\utility::random(var0);
  scripts\cp\respawn\cp_ac130_respawn::start_ac130_respawn_sequence(var4.origin, level.players_in_respawn_queue, var4);

  foreach(var2 in level.players) {
    var2 thread scripts\cp\cp_hud_message::showsplash("cp_used_respawn");
    thread toggle_respawn_functionality_after_timeout(var2);
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
  var0 = (0, 0, 0);
  var1 = scripts\cp\respawn\cp_ac130_respawn::get_path_over_players(var0, undefined, 1);
  thread scripts\cp\respawn\cp_ac130_respawn::spawnc130(var1, 1, self);
  thread scripts\cp\respawn\cp_ac130_respawn::start_black_screen(self, 1);
}

function can_do_hotjoin_via_ac130() {
  return !istrue(level.disable_hotjoin_via_ac130);
}

function takeweaponsdefaultfunc() {
  if(isDefined(level.nuclear_core_carrier)) {
    if(level.nuclear_core_carrier == self) {
      var0 = self getcurrentweapon();
      self takeweapon(var0);
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

  var1 = getcompleteweaponname("iw8_fists_mp");
  var2 = getcompleteweaponname("none");
  self.weaponlist = self.primaryweapons;

  for(var3 = 0; var3 < self.weaponlist.size; var3++) {
    var4 = self.weaponlist[var3];

    if(isDefined(var4) && !isnullweapon(var1, var4) && !isnullweapon(var2, var4)) {
      self takeweapon(var4);
    }
  }

  self clearaccessory();

  if(!self hasweapon(var1)) {
    scripts\cp_mp\utility\inventory_utility::_giveweapon(var1, undefined, undefined, 1);
  }

  scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(var1, 1);
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

function removecameraondisconnect(var0) {
  self endon("spawn_camera_deleted");
  self waittill("disconnect");

  if(isDefined(var0)) {
    var0 delete();
    return;
  }
}

function ref_1380a(var0, var1) {
  var2 = vectorNormalize(var0.origin - var1.origin);
  var3 = var0.origin + var2 * -8500 + (0, 0, 7000);
  var4 = vectorNormalize(var0.origin - var3);
  var5 = scripts\cp\utility::vectortoanglessafe(var4, (0, 0, 1));
  var6 = spawnStruct();
  var6.origin = var3;
  var6.angles = var5;
  var7 = var6.origin;
  var8 = var6.angles;
  var9 = var0.spawncameraent.origin;
  var10 = vectorNormalize(var9 - var6.origin);
  var11 = scripts\cp\utility::vectortoanglessafe(var10, (0, 0, 1));
  var0.spawncameraent.angles = var11;
  var12 = distance(var9, var7);
  var13 = var12 / 3520;
  var13 = clamp(var13, 1.5, 3);
  var0.spawncameratargetpos = var7;
  var0.spawncameratargetang = var8;
  var0.spawncameratime = var13;
  var0.spawncameraendtime = gettime() + var13 * 1000;
  var0 earthquakeforplayer(0.03, 15, var7, 1000);
}

function startspawncamera(var0) {
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
  var1 = self getEye();
  var2 = self.angles;
  self.deathspectatepos = var1;
  self.deathspectateangles = var2;

  if(!isDefined(self.spawncameraent)) {
    var3 = spawn("script_model", self.deathspectatepos);
    var3 setModel("tag_origin");
    var3.angles = self.deathspectateangles;
    self.spawncameraent = var3;
    self playerlinkTo(self.spawncameraent);
  } else {
    self.spawncameraent.origin = self.deathspectatepos;
    self.spawncameraent.angles = self.deathspectateangles;
  }

  thread removecameraondisconnect(self.spawncameraent);
  self cameralinkTo(self.spawncameraent, "tag_origin", 1, 1);
  snaptospawncamera(var0);
}

function entitylerpovertime(var0, var1, var2, var3, var4) {
  var0 endon("death");

  if(var3 <= 0) {
    var3 = 1;
  }

  var5 = 1 / var3 / 0.05;
  var6 = 0;
  var7 = var0.origin;
  var8 = var0.angles;
  jumpiffalse(var4 == 2) LOC_00000053;
  level.c130 notify("players_viewing_crash");

  while(var6 < 1) {
    var9 = vectorlerp(var7, var1, var6);
    var10 = scripts\engine\math::fake_slerp(var8, var2, var6);

    if(isPlayer(var0) || isagent(var0)) {
      var0 setOrigin(var9, 1);
      var0 setplayerangles(var10);
    } else {
      var0.origin = var9;
      var0.angles = var10;
    }

    var6 += var5;
    waitframe();
  }

  if(isPlayer(var0) || isagent(var0)) {
    var0 setOrigin(var1, 1);
    var0 setplayerangles(var2);
    return;
  }

  var0.origin = var1;
  var0.angles = var2;
}

function get_lerped_origin(var0, var1, var2) {
  return vectorlerp(var0, var1, var2);
}

function get_fake_slerped_angles(var0, var1, var2) {
  return scripts\engine\math::fake_slerp(var0, var1, var2);
}

function ref_12768(var0, var1, var2, var3) {
  if(!isDefined(var3)) {
    var3 = "black";
  }

  var4 = newclienthudelem(self);
  var4.x = 0;
  var4.y = 0;
  var4.alignx = "left";
  var4.aligny = "top";
  var4.sort = 1;
  var4.horzalign = "fullscreen";
  var4.vertalign = "fullscreen";
  var4.foreground = 1;

  if(isDefined(var0) && var0 > 0) {
    var4.alpha = 0;
  } else {
    var4.alpha = 1;
  }

  var4 setshader(var3, 640, 480);

  if(isDefined(var0) && var0 > 0) {
    self notify("fadeDown_start");
    var4 fadeovertime(var0);
    var4.alpha = 1;
    wait var0;
    self notify("fadeDown_complete");
  }

  if(isDefined(var1) && var1 > 0) {
    wait var1;
  }

  self notify("fadeUp_start");

  if(!isDefined(var2)) {
    var2 = 0.5;
  }

  var4 fadeovertime(var2);
  var4.alpha = 0;
  wait var2;
  self notify("fadeUp_complete");

  if(isDefined(var4)) {
    var4 destroy();
    return;
  }
}

function snaptospawncamera(var0) {
  self endon("disconnect");
  self waittill("fadeUp_start");
  var1 = var0;
  self.spawncameraent.origin = var1.origin;
  self.spawncameraent.angles = var1.angles;
  self visionsetnakedforplayer("", 0);
  applythermal();

  if(isDefined(self) && isDefined(self.spawncameraent)) {
    var2 = anglesToForward(self.spawncameraent.angles) * 300;
    var2 *= (1, 1, 0);
    self.spawncameraent moveTo(self.spawncameraent.origin + var2, 15, 1, 1);
    self earthquakeforplayer(0.03, 15, self.spawncameraent.origin, 1000);
  }

  self cameraunlink();
  self notify("spawn_camera_idle");
}

function runslamzoomonspawn(var0) {
  self endon("disconnect");
  thread scripts\cp\utility::drawline(self.spawncameraent.origin, self.origin, 100000, (1, 0, 0));
  self cameralinkTo(self.spawncameraent, "tag_origin", 1, 1);
  handlemovetoblended(var0);
}

function deletespawncamera() {
  self cameraunlink();

  if(isDefined(self.spawncameraent)) {
    self.spawncameraent delete();
  }

  self notify("spawn_camera_deleted");
}

function handlemovetoblended(var0) {
  self endon("disconnect");
  var1 = var0.origin + (0, 0, 60);
  var2 = var0.angles;
  var3 = angle_diff(self.spawncameraent.angles[1], var2[1]) < 45;
  var4 = distance2dsquared(self.spawncameraent.origin, var1) > 1000000;

  if(!var3 || !var4) {
    removethermal();
    self visionsetnakedforplayer("", 0);
    wait 0.05;
    self.spawncameraent moveTo(var1, 1, 0.1, 0.9);
    self.spawncameraent rotateTo(var2, 1, 0.9, 0.1);
    self visionsetnakedforplayer("tac_ops_slamzoom", 0.8);
    wait 0.8;
    self visionsetnakedforplayer("", 0.2);
    wait 0.2;
  } else {
    var5 = vectorNormalize(var1 - self.spawncameraent.origin);
    var6 = scripts\cp\utility::vectortoanglessafe(var5, (0, 0, 1));
    self.spawncameraent rotateTo(var6, 0.7, 0.2, 0.2);
    removethermal();
    self visionsetnakedforplayer("", 0);
    wait 0.05;
    self.spawncameraent moveTo(var1, 1, 0.1, 0.9);
    self visionsetnakedforplayer("tac_ops_slamzoom", 0.8);
    wait 0.5;
    self.spawncameraent rotateTo(var2, 0.5, 0.2, 0.1);
    wait 0.3;
    self visionsetnakedforplayer("", 0.2);
  }

  self notify("spawn_camera_complete");
}

function angle_diff(var0, var1) {
  return 180 - abs(abs(var0 - var1) - 180);
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

  for(var0 = 0; var0 < level.mhc_escape_ents_array.size; var0++) {
    entitylerpovertime(self.spawncameraent, level.mhc_escape_ents_array[var0].origin + (0, 0, 64), level.mhc_escape_ents_array[var0].angles, 1 - var0 * 0.25, var0);
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
  var0 = getEnt("mhc_camera_start", "script_noteworthy");
  var1 = [var0];

  while(isDefined(var0.target)) {
    var0 = getEnt(var0.target, "targetname");

    if(isDefined(var0.script_linkto)) {
      var2 = [var0];
      var3 = var0 scripts\engine\utility::get_linked_structs();
      var1 = scripts\engine\utility::array_combine(var2, var3);
      continue;
    }

    GscBinSkip0(0x2e, var1.size, var0);
  }

  return var1;
}

function camera_setup_for_lerping(var0, var1) {
  var0 endon("disconnect");

  if(isai(var0)) {
    return;
  }

  if(istrue(var0.inmhccam)) {
    return;
  }

  if(istrue(level.gameended)) {
    return;
  }

  var0.inmhccam = 1;
  var0.deathspectatepos = var1.origin;
  var0.deathspectateangles = var1.angles;

  if(!isDefined(var0.spawncameraent)) {
    var2 = spawn("script_model", var0.deathspectatepos);
    var2 setModel("tag_origin");
    var2.angles = var0.deathspectateangles;
    var0.spawncameraent = var2;
    var0 playerlinkTo(var0.spawncameraent);
  } else {
    var0.spawncameraent.origin = var0.deathspectatepos;
    var0.spawncameraent.angles = var0.deathspectateangles;
  }

  thread removecameraondisconnect(var0);
  var0 cameralinkTo(var0.spawncameraent, "tag_origin", 1, 1);
  thread ref_12768(var0, 0, 1, 0.25);
  var3 = vectorNormalize(var0.origin - var1.origin);
  var4 = var0.origin + var3 * -8500 + (0, 0, 7000);
  var5 = vectorNormalize(var0.origin - var4);
  var6 = scripts\cp\utility::vectortoanglessafe(var5, (0, 0, 1));
  var7 = spawnStruct();
  var7.origin = var4;
  var7.angles = var6;
  var8 = var7.origin;
  var9 = var7.angles;
  var10 = var0.spawncameraent.origin;
  var11 = vectorNormalize(var10 - var7.origin);
  var12 = scripts\cp\utility::vectortoanglessafe(var11, (0, 0, 1));
  var0.spawncameraent.angles = var12;
  var13 = distance(var10, var8);
  var14 = var13 / 3520;
  var14 = clamp(var14, 1.5, 3);
  var0.spawncameratargetpos = var8;
  var0.spawncameratargetang = var9;
  var0.spawncameratime = var14;
  var0.spawncameraendtime = gettime() + var14 * 1000;
  var0 earthquakeforplayer(0.03, 15, var8, 1000);
  var0.spawncameraent moveTo(var8, 1, 0.25, 0.75);
  var0.spawncameraent rotateTo(var9, 1, 0.25, 0.75);
  wait 1;
  thread ref_12768(var0, 0, 0.25);
  applythermal(var0);
  thread startoperatorsound();

  if(isDefined(var0) && isDefined(var0.spawncameraent)) {
    var15 = anglesToForward(var9) * 300;
    var15 *= (1, 1, 0);
    var0.spawncameraent moveTo(var1.origin + var15, 15, 1, 1);
    var0 earthquakeforplayer(0.03, 15, var1.origin, 1000);
  }

  wait 1;
  removethermal(var0);
  var0 visionsetnakedforplayer("", 0);
  deletespawncamera(var0);
  var0.inmhccam = undefined;
}

function startoperatorsound() {
  self endon("disconnect");
  self endon("game_ended");

  if(istrue(self.spawnselectionoperatorsound)) {
    return;
  }

  var0 = spawn("script_origin", (0, 0, 0));
  var0 showonlytoplayer(self);
  self setsoundsubmix("iw8_mp_spawn_camera");
  var1 = scripts\cp\cp_player_battlechatter::getteamvoiceinfix(self.team);
  var2 = "dx_mpo_" + var1 + "op_drone_deathchatter";

  if(soundexists(var2)) {
    var0 playLoopSound(var2);
  } else {
    var0 playLoopSound("dx_mpo_usop_drone_deathchatter");
  }

  self.spawnselectionoperatorsound = 1;
  self waittill("spawned_player");
  self clearsoundsubmix("iw8_mp_spawn_camera");
  var0 stoploopsound(var2);
  var0 delete();
  self.spawnselectionoperatorsound = 0;
}