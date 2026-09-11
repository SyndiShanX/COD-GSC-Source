/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\helicopter\utility.gsc
***********************************************/

function callback_defaultplayerlaststand(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(isDefined(var_1)) {
    if(isPlayer(var_1) || isagent(var_1)) {
      self.last_damaged_by = var_1;
    }
  }

  if(scripts\cp_mp\utility\player_utility::isinvehicle()) {
    self.bhitbyvehicle = undefined;
  }

  if(isDefined(level.last_stand_hud_update)) {
    self[[level.last_stand_hud_update]]();
  }

  var_10 = scripts\cp\cp_endgame::get_current_zone(self);
  var_11 = 1;
  scripts\cp\cp_analytics::ref_119b2(self, var_1);
  default_playerlaststand(var_9, var_1);
  return true;
}

function default_playerlaststand(var_0, var_1) {
  var_2 = gameshouldend(self);

  if(var_2 && isDefined(level.endgame) && isDefined(level.end_game_string_index)) {
    level thread[[level.endgame]]("axis", level.end_game_string_index["kia"]);
  }

  thread completepayloadexfilobjective();
  thread dropintolaststand(var_0, var_2, var_1);
}

function completepayloadexfilobjective() {
  self endon("disconnect");
  var_0 = newclienthudelem(self);
  var_0.sort = 0;
  var_0.x = 0;
  var_0.y = 0;
  var_0.alignx = "left";
  var_0.aligny = "top";
  var_0.foreground = 0;
  var_0.horzalign = "fullscreen";
  var_0.vertalign = "fullscreen";
  var_0.alpha = 0.5;
  var_0.enablehudlighting = 1;
  var_0.lowresbackground = 1;
  var_0 setshader("ui_player_pain_deathsdoor_pulse_overlay", 640, 480);
  var_0 fadeovertime(20);
  var_0.alpha = 1.25;
  self shellshock("default_nosound", 2);
  var_1 = scripts\engine\utility::waittill_notify_or_timeout_return("revive", 20);

  if(var_1 == "timeout") {
    self playlocalsound("deaths_door_in");
    scripts\common\utility::allow_weapon(0);
    scripts\common\utility::allow_melee(0);
    self shellshock("default_nosound", 4);
    self waittill("revive");
    scripts\common\utility::allow_weapon(1);
    scripts\common\utility::allow_melee(1);
  }

  var_2 = 1;
  var_0 fadeovertime(var_2);
  var_0.alpha = 0;
  wait var_2;
  var_0 destroy();
}

function completeobjstr() {
  self endon("disconnect");
  self endon("revive");
  var_0 = 0.85;
  var_1 = 0.95;

  for(;;) {
    self playlocalsound("breathing_heartbeat");
    var_2 = randomfloatrange(var_0, var_1);
    wait var_2;
  }
}

function forcebleedout(var_0) {
  if(scripts\cp\utility::isplayingsolo() || level.only_one_player) {
    self setOrigin(var_0.origin);
  }

  self.bleedoutspawnentityoverride = var_0;
  self notify("force_bleed_out");
}

function dropintolaststand(var_0, var_1, var_2) {
  self endon("disconnect");
  level endon("game_ended");
  self notify("last_stand");
  self notify("last_stand_start");
  var_3 = gettime() + 3000;
  var_4 = scripts\cp\utility::has_auto_revive();
  enter_gamemodespecificaction(var_2);
  enter_globaldefaultaction();
  enter_laststand();

  if((scripts\cp\utility::isplayingsolo() || level.only_one_player) && haveselfrevive()) {
    waitinlaststand(var_0, var_1, var_4);
  } else if(shouldgodirectlytospectate(self)) {
    waitinspectator(var_0, var_1);
  } else if(maydolaststand(var_1, var_0)) {
    var_5 = waitinlaststand(var_0, var_1);

    if(istrue(self.trackriotshield_trydetach)) {
      var_5 = 1;
    }

    if(!var_5) {
      waitinspectator(var_0, var_1);
    }
  } else {
    waitinspectator(var_0, var_1);
  }

  var_6 = (var_3 - gettime()) / 1000;

  if(var_6 > 0) {
    wait var_6;
  }

  self notify("revive");
  level notify("revive_success", self);
  self.trackriotshield_trydetach = 0;
  exit_laststand();
  exit_globaldefaultaction();
  exit_gamemodespecificaction();
  var_7 = scripts\cp\cp_outofbounds::getlastoobtrigger(self);

  if(isDefined(var_7) && isDefined(var_7.entstouching[self getentitynumber()])) {
    var_7.entstouching[self getentitynumber()] = undefined;
    scripts\cp\cp_outofbounds::clearoob(self, 0);
    return;
  }
}

function setupcellspawn() {
  self.watch_for_long_death = createnavobstaclebyent(self);
  thread ref_11daa();
  scripts\engine\utility::ref_143a9("death", "disconnect", "revive", "game_ended", "exit_last_stand", "entered_spectate");
  destroynavobstacle(self.watch_for_long_death);
}

function ref_11daa() {
  self.watch_for_maze_ai_events = self.origin;
  var_0 = 2500;

  while(isDefined(self.last_stand_state) && self.last_stand_state == "last_stand") {
    if(distancesquared(self.watch_for_maze_ai_events, self.origin) > var_0) {
      destroynavobstacle(self.watch_for_long_death);
      self.watch_for_long_death = createnavobstaclebyent(self);
      self.watch_for_maze_ai_events = self.origin;
    }

    wait 0.2;
  }
}

function enter_laststand() {
  self.last_stand_state = "last_stand";
  self.inlaststand = 1;
  self.ref_140ae = undefined;
  self.health = 1;
  scripts\common\utility::allow_usability(0);
  scripts\cp\utility::allow_player_ignore_me(1);
  self notify("healthRegeneration");
  thread setupcellspawn();
}

function exit_laststand() {
  self notify("exit_last_stand");
  self laststandrevive();
  self setstance("stand");
  self.inlaststand = 0;
  self.last_stand_state = undefined;
  self.health = gethealthcap();
  scripts\engine\utility::delaythread(3, &scripts\cp\utility::force_usability_enabled);
  thread wasinlaststand();
  thread scripts\cp\utility::hint_prompt("manual_revive", 0);

  if(isDefined(level.revived_hud_update)) {
    self[[level.revived_hud_update]]();
  }

  set_cam();
  self.last_damaged_by = undefined;
}

function wasinlaststand() {
  var_0 = scripts\cp\cp_outofbounds::getlastoobtrigger(self);

  if(isDefined(var_0) && isDefined(var_0.entstouching[self getentitynumber()])) {
    scripts\cp\utility::allow_player_ignore_me(0);
    return;
  }

  self endon("disconnect");
  self.ability_invulnerable = 1;
  wait 5;
  scripts\cp\utility::allow_player_ignore_me(0);
  self.ability_invulnerable = undefined;
}

function set_cam(var_0) {
  if(!isDefined(var_0)) {
    self cameradefault();
    return;
  }

  self cameraset(var_0);
}

function delay_orbit_cam(var_0) {
  self endon("revive_done");
  wait var_0;
  set_cam("camera_custom_orbit_2_cp");
}

function gethealthcap() {
  if(isDefined(level.get_player_health_after_revived_func)) {
    return [[level.get_player_health_after_revived_func]](self);
  }

  return int(self.maxhealth);
}

function enter_globaldefaultaction() {
  if(!scripts\cp\utility::_hasperk("specialty_pistoldeath")) {
    scripts\cp\utility::giveperk("specialty_pistoldeath");
  }

  scripts\cp\cp_gamescore::update_team_encounter_performance(scripts\cp\cp_gamescore::get_team_score_component_name(), "num_players_enter_laststand");
  var_0 = [getcompleteweaponname("iw8_gunless")];

  if(isDefined(level.additional_laststand_weapon_exclusion)) {
    var_0 = scripts\engine\utility::array_combine(var_0, level.additional_laststand_weapon_exclusion);
  }

  if(isDefined(self.former_mule_weapon)) {
    GscBinSkip0(0x2e, var_0.size, self.former_mule_weapon);
  }

  var_1 = [];

  foreach(var_3 in self getweaponslistprimaries()) {
    if(var_3.isalternate) {
      continue;
    }

    var_1 = var_3;
  }

  self.lost_and_found_primary_count = var_1;
  scripts\cp\utility::store_weapons_status(var_0, 1);
  self.lastweapon = enter_globaldefaultaction_getcurrentweapon(var_0, 1);
  self.bleedoutspawnentityoverride = undefined;
  self.saved_last_stand_pistol = self.last_stand_pistol;
  self.pre_laststand_weapon = self getweaponslistprimaries()[0];
  self.pre_laststand_weapon_stock = self getweaponammostock(self.pre_laststand_weapon.basename);
  self.pre_laststand_weapon_ammo_clip = self getweaponammoclip(self.pre_laststand_weapon);
  self.being_revived = 0;
  check_for_invalid_attachments();
  thread only_use_weapon();
  var_5 = self;
  var_5.loadoutaccessoryweapon = var_5 scripts\cp\cp_loadout::cac_getaccessoryweapon();
  var_5.loadoutaccessorydata = var_5 scripts\cp\cp_loadout::cac_getaccessorydata();
  var_5.loadoutaccessorylogic = var_5 scripts\cp\cp_loadout::force_interrupt_all_current_combat_actions();

  if(isDefined(var_5.loadoutaccessorydata) && isDefined(var_5.loadoutaccessoryweapon) && var_5.loadoutaccessoryweapon != "none") {
    var_5 scripts\cp\cp_accessories::giveplayeraccessory(var_5.loadoutaccessorydata, var_5.loadoutaccessoryweapon, var_5.loadoutaccessorylogic);
  }

  scripts\cp\cp_persistence::increment_player_career_downs(self);
  scripts\cp\cp_analytics::inc_downed_counts();
  scripts\cp\cp_globallogic::broadcast_status(self, 1);
  self stopgestureviewmodel();
  self stopanimscriptsceneevent();

  if(self isviewmodelanimplaying()) {
    self stopviewmodelanim();
    return;
  }
}

function check_for_invalid_attachments() {
  if(!isDefined(self.copy_fullweaponlist)) {
    return;
  }

  if(scripts\cp\utility::is_consumable_active("just_a_flesh_wound")) {
    return;
  }

  var_0 = undefined;

  if(isDefined(self.lastweapon) && !scripts\engine\utility::array_contains(self.copy_fullweaponlist, self.lastweapon)) {
    self.copy_fullweaponlist = scripts\engine\utility::array_add(self.copy_fullweaponlist, self.lastweapon);
  }

  foreach(var_2 in self.copy_fullweaponlist) {
    if(var_2 hasattachment("doubletap", 1)) {
      var_0 = var_2 withoutattachment("doubletap");
      var_3 = createheadicon(var_0);

      if(scripts\engine\utility::array_contains(self.copy_fullweaponlist, var_2)) {
        self.copy_fullweaponlist = scripts\engine\utility::array_remove(self.copy_fullweaponlist, var_2);
        self.copy_fullweaponlist[self.copy_fullweaponlist.size] = var_0;
      }

      if(issubstr(self.copy_weapon_current.basename, var_2.basename)) {
        self.copy_weapon_current = var_0;
      }

      var_4 = getarraykeys(self.copy_weapon_ammo_clip);
      var_5 = getarraykeys(self.copy_weapon_ammo_stock);

      foreach(var_7 in var_4) {
        if(issubstr(var_7, var_2.basename)) {
          if(var_3 != var_7) {
            self.copy_weapon_ammo_clip[var_3] = self.copy_weapon_ammo_clip[var_7];
            self.copy_weapon_ammo_clip[var_7] = undefined;
          }
        }
      }

      foreach(var_10 in var_5) {
        if(issubstr(var_10, var_2.basename)) {
          if(var_3 != var_10) {
            self.copy_weapon_ammo_stock[var_3] = self.copy_weapon_ammo_stock[var_10];
            self.copy_weapon_ammo_stock[var_10] = undefined;
          }
        }
      }

      if(issubstr(self.lastweapon.basename, var_2.basename)) {
        self.lastweapon = var_0;
      }

      if(issubstr(self.pre_laststand_weapon.basename, var_2.basename)) {
        self.pre_laststand_weapon = var_0;
      }
    }
  }
}

function enter_globaldefaultaction_getcurrentweapon(var_0, var_1) {
  var_2 = scripts\cp\utility::getvalidtakeweapon(var_0);

  if(isDefined(self.pre_arcade_game_weapon)) {
    var_2 = self.pre_arcade_game_weapon;
  }

  var_3 = 0;

  if(nullweapon(var_2)) {
    var_3 = 1;
  } else if(scripts\engine\utility::array_contains(var_0, var_2)) {
    var_3 = 1;
  } else if(scripts\engine\utility::array_contains(var_0, var_2 getbaseweapon())) {
    var_3 = 1;
  } else if(istrue(var_1) && scripts\cp\utility::is_melee_weapon(var_2, 1)) {
    var_3 = 1;
  }

  if(scripts\cp\utility::is_primary_melee_weapon(var_2)) {
    var_3 = 0;
  }

  if(var_3) {
    return choose_last_weapon(var_0, var_1, 1);
  }

  return var_2;
}

function choose_last_weapon(var_0, var_1, var_2) {
  for(var_3 = 0; var_3 < self.copy_fullweaponlist.size; var_3++) {
    if(nullweapon(self.copy_fullweaponlist[var_3])) {
      continue;
    }

    if(scripts\engine\utility::array_contains(var_0, self.copy_fullweaponlist[var_3])) {
      continue;
    }

    if(scripts\engine\utility::array_contains(var_0, self.copy_fullweaponlist[var_3] getbaseweapon())) {
      continue;
    }

    if(istrue(var_1) && scripts\cp\utility::is_melee_weapon(self.copy_fullweaponlist[var_3], var_2)) {
      continue;
    }

    return self.copy_fullweaponlist[var_3];
  }
}

function exit_globaldefaultaction() {
  self.bhitbyvehicle = undefined;
  self.haveinvulnerabilityavailable = 1;
  self.damageshieldexpiretime = gettime() + 3000;
  var_0 = [];
  scripts\cp\utility::restore_weapons_status(var_0);

  if(isDefined(self.pre_laststand_weapon_stock)) {
    self setweaponammostock(self.pre_laststand_weapon, self.pre_laststand_weapon_stock);
  }

  if(isDefined(self.pre_laststand_weapon_ammo_clip)) {
    self setweaponammoclip(self.pre_laststand_weapon, self.pre_laststand_weapon_ammo_clip);
  }

  self setspawnweapon(self.lastweapon, 1);
  give_fists_if_no_real_weapon(self);
  var_1 = self;
  var_1.loadoutaccessoryweapon = var_1 scripts\cp\cp_loadout::cac_getaccessoryweapon();
  var_1.loadoutaccessorydata = var_1 scripts\cp\cp_loadout::cac_getaccessorydata();
  var_1.loadoutaccessorylogic = var_1 scripts\cp\cp_loadout::force_interrupt_all_current_combat_actions();

  if(isDefined(var_1.loadoutaccessorydata) && isDefined(var_1.loadoutaccessoryweapon) && var_1.loadoutaccessoryweapon != "none") {
    var_1 scripts\cp\cp_accessories::giveplayeraccessory(var_1.loadoutaccessorydata, var_1.loadoutaccessoryweapon, var_1.loadoutaccessorylogic);
  }

  scripts\cp\cp_globallogic::broadcast_status(self, 0);
  self.bleedoutspawnentityoverride = undefined;
  scripts\cp\cp_analytics::inc_revived_counts();
  scripts\cp\cp_damage::set_kill_trigger_event_processed(self, 0);
  updatemovespeedscale();
  scripts\cp\cp_globallogic::updatematchhasmorethan1playeromnvaronplayersfirstspawn();
}

function enter_gamemodespecificaction(var_0) {
  if(isDefined(level.laststand_enter_gamemodespecificaction)) {
    [[level.laststand_enter_gamemodespecificaction]](self, var_0);
  }

  if(isDefined(level.laststand_enter_levelspecificaction)) {
    [[level.laststand_enter_levelspecificaction]](self);
    return;
  }
}

function exit_gamemodespecificaction() {
  if(isDefined(level.laststand_exit_gamemodespecificaction)) {
    [[level.laststand_exit_gamemodespecificaction]](self);
    return;
  }
}

function waitinlaststand(var_0, var_1, var_2) {
  self endon("disconnect");
  self endon("revive");
  self endon("revive_success");
  level endon("game_ended");

  if(self_revive_activated()) {
    return self_revive(self);
  }

  var_3 = undefined;
  var_4 = 3;

  if(isDefined(level.self_revive_wait_override)) {
    var_4 = level.self_revive_wait_override;
  }

  if(scripts\cp\utility::has_auto_revive() && !npc_revive_available()) {
    wait var_4;
    self setclientomnvar("ui_self_revive", 0);
    return 1;
  }

  if(!var_1) {
    thread playdeathsoundinlaststand(var_3);

    if(scripts\cp\utility::isplayingsolo() || level.only_one_player) {
      take_laststand(self, 1);

      if(npc_revive_available()) {
        set_last_stand_timer(self, 35);
      } else {
        set_last_stand_timer(self, 5);
      }
    } else {
      set_last_stand_timer(self, var_3);
    }
  }

  foreach(var_6 in level.players) {
    if(var_6 != self) {
      var_6 thread scripts\cp\cp_hud_message::showsplash("cp_in_laststand", undefined, self);
    }
  }

  if(scripts\cp\utility::isplayingsolo() || level.only_one_player && !npc_revive_available()) {
    return wait_for_self_revive(var_0, var_1);
  }

  return wait_to_be_revived(self, self.origin, undefined, undefined, 1, get_normal_revive_time(), (0.33, 0.75, 0.24), var_3, 0, var_1, 1, var_2);
}

function getbleedouttime() {
  if(isDefined(level.get_bleed_out_time)) {
    return [[level.get_bleed_out_time]]();
  }

  return 35;
}

function waitinspectator(var_0, var_1) {
  self endon("disconnect");
  level endon("game_ended");
  wait 0.5;
  scripts\cp\cp_globallogic::updatematchhasmorethan1playeromnvaronplayerdisconnect();
  self notify("death");
  self setclientomnvar("ui_out_of_bounds_countdown", 0);
  waitframe();
  scripts\cp\cp_globallogic::broadcast_status(self, 2);
  record_bleedout(var_0);

  if(isDefined(self.bleedoutspawnentityoverride)) {
    var_0 = self.bleedoutspawnentityoverride;
    self.bleedoutspawnentityoverride = undefined;
  }

  if(is_killed_by_kill_trigger(var_0)) {
    var_2 = self;

    if(isDefined(var_0)) {
      var_2 = var_0;
    }

    var_3 = scripts\engine\utility::drop_to_ground(var_2.origin, 32, -64) + (0, 0, 5);
    var_4 = var_2.angles;
  } else {
    var_3 = self.origin;
    var_4 = self.angles;
  }

  clear_last_stand_timer(self);
  self.spectating = 1;

  if(isDefined(level.respawn_func) && !istrue(level.dogtag_revive) && !scripts\cp\utility::turn_off_sniper_laser()) {
    self.last_stand_state = "bleed_out";

    if(isDefined(level.automated_respawn_func)) {
      while(!istrue(level.automated_respawn_available)) {
        wait 1;
      }

      if(!istrue(level.automated_respawn_delay_skip)) {
        level thread[[level.automated_respawn_func]]();
      }
    }

    if(self[[level.respawn_func]](self, var_3)) {
      show_all_revive_icons(self);
      scripts\cp\cp_globallogic::broadcast_status(self, 0);
      self.spectating = undefined;
      scripts\cp\utility::updatesessionstate("playing");

      if(!isDefined(self.forcespawnorigin) && !isDefined(self.forcespawnangles)) {
        self.forcespawnorigin = var_3;
        self.forcespawnangles = var_4;
      }

      if(isDefined(level.prespawnfromspectaorfunc)) {
        [[level.prespawnfromspectaorfunc]](self);
      }

      if(istrue(self.playerjailwaitvo)) {
        self.playerjailwaitvo = undefined;
        [[level.spawnplayerfunc]]();
      } else {
        [[level.spawnplayerfunc]](1);
      }

      self.shouldskiplaststand = 0;
      return;
    }

    return;
  }

  if(isDefined(level.enter_spectator_func)) {
    level thread[[level.enter_spectator_func]](self);
  }

  self notify("entered_spectate");

  if(!scripts\cp\utility::turn_off_sniper_laser()) {
    var_5 = wait_to_be_revived(self, var_3, undefined, undefined, 0, get_spectator_revive_time(), (1, 0, 0), undefined, 1, var_4, 0);
  } else {
    thread enter_spectate(self, var_3, undefined);
    self.last_stand_state = "bleed_out";
    level waittill("timeout_wave");
  }

  show_all_revive_icons(self);
  scripts\cp\cp_globallogic::broadcast_status(self, 0);
  self.spectating = undefined;
  scripts\cp\utility::updatesessionstate("playing");

  if(!isDefined(self.forcespawnorigin) && !isDefined(self.forcespawnangles)) {
    self.forcespawnorigin = var_3;
    self.forcespawnangles = var_4;
  }

  if(isDefined(level.prespawnfromspectaorfunc)) {
    [[level.prespawnfromspectaorfunc]](self);
  }

  [[level.spawnplayerfunc]]();
  self.shouldskiplaststand = 0;
}

function record_bleedout(var_0) {
  scripts\cp\cp_persistence::eog_player_update_stat("deaths", 1);

  if(!is_killed_by_kill_trigger(var_0)) {
    scripts\cp\cp_gamescore::update_team_encounter_performance(scripts\cp\cp_gamescore::get_team_score_component_name(), "num_players_bleed_out");
    scripts\cp\cp_analytics::inc_bleedout_counts();
    return;
  }
}

function wait_for_self_revive(var_0, var_1) {
  if(var_1) {
    level waittill("forever");
    clear_last_stand_timer(self);
    return false;
  }

  if(is_killed_by_kill_trigger(var_0)) {
    self setOrigin(var_0.origin);
  } else {
    wait 5;
  }

  clear_last_stand_timer(self);
  return true;
}

function wait_to_be_revived(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  var_12 = makereviveentity(var_0, var_1, var_2, var_3, var_4);

  if(var_8) {
    thread enter_spectate(var_0, var_1, var_12);
    var_0.last_stand_state = "bleed_out";
  } else {
    level notify("waiting_to_be_revived_from_laststand", var_0);
  }

  if(var_9) {
    level waittill("forever");
    return 0;
  }

  var_13 = var_12;

  if(var_8) {
    var_13 = makereviveiconentity(var_0, var_12);
  }

  if(var_10) {
    var_13 scripts\cp\cp_laststand::makereviveicon(var_13, var_0, var_6, var_7);
  }

  var_0.reviveent = var_12;
  var_0.reviveiconent = var_13;

  if(isDefined(level.give_up_func) && (!var_0 isspectatingplayer() || !istrue(var_8))) {
    var_0 thread[[level.give_up_func]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);
  }

  if(var_10) {
    thread laststandwaittillrevivebyteammate(var_12, var_0);
  }

  if(istrue(1)) {
    thread laststandmoveawayfromvehicles(var_12, var_0);
  }

  if(isDefined(var_7)) {
    var_14 = var_12 scripts\engine\utility::waittill_any_ents_or_timeout_return(var_7, var_12, "revive_success", var_0, "force_bleed_out", var_0, "revive_success", var_0, "challenge_complete_revive");
  } else {
    var_14 = var_13 scripts\engine\utility::waittill_any_ents_return(var_13, "revive_success", var_1, "challenge_complete_revive", var_1, "force_bleed_out");
  }

  if(var_14 == "timeout" && is_being_revived(var_1)) {
    var_14 = var_13 scripts\engine\utility::ref_143ad("revive_success", "revive_fail");
  }

  if(isDefined(var_1.reviveent)) {
    var_1.reviveent delete();
  }

  if(isDefined(var_1.reviveiconent)) {
    var_1.reviveiconent delete();
  }

  var_1 notify("give_up_done");

  if(var_14 == "revive_success" || var_14 == "challenge_complete_revive") {
    return 1;
  }

  return 0;
}

function manualreviveinspec(var_0) {
  self endon("death");
  level endon("game_ended");
  var_0 endon("revive");
  var_1 = 120;
  wait var_1;
  var_0 notifyonplayercommand("manual_revive", "+usereload");
  var_0 thread scripts\cp\utility::hint_prompt("manual_revive", 1);
  var_0 waittill("manual_revive");
  var_0 thread scripts\cp\utility::hint_prompt("manual_revive", 0);

  if(isDefined(var_0.dogtag)) {
    var_0.dogtag delete();
  }

  thread teleport_to_location();
  thread instant_revive(var_0);
}

function teleport_to_location() {
  level.manual_revive_location = level.vehicle_travel_array[0].origin + (0, 0, 200);

  if(!isDefined(level.manual_revive_location)) {
    return;
  }

  level endon("game_ended");
  scripts\engine\utility::ref_143b9(3, "revive");
  self setOrigin(level.manual_revive_location);
}

function putonground(var_0) {
  if(!var_0 isonground()) {
    var_1 = scripts\engine\utility::drop_to_ground(var_0.origin, 5, -1500);
    var_1 = getclosestpointonnavmesh(var_1);
    var_0 setOrigin(var_1);
    return;
  }
}

function laststandwaittillrevivebyteammate(var_0, var_1) {
  self endon("death");
  level endon("game_ended");

  if(isDefined(level.revive_ent_usability_func)) {
    self thread[[level.revive_ent_usability_func]](var_0, self);
  }

  putonground(var_0);

  for(;;) {
    self makeusable();
    self setuseprioritymax();
    self waittill("trigger", var_2);
    self makeunusable();

    if(!var_2 isonground()) {
      continue;
    }

    if(var_2 ismeleeing()) {
      continue;
    }

    if(istrue(var_2.waitgiveammo)) {
      continue;
    }

    if(!isPlayer(var_2) && !istrue(var_2.can_revive)) {
      continue;
    }

    if(istrue(var_0.adrenalinepoweractive)) {
      continue;
    }

    if(istrue(var_2.usingascender)) {
      continue;
    }

    if(!isDefined(var_2.ref_12d16)) {
      var_2.ref_12d16 = 0;
    }

    if(gettime() > var_2.ref_12d16) {
      level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(var_2, "reviving");
      var_2.ref_12d16 = gettime() + 10000;
    }

    disable_bleedout_ent_usability(var_0);

    if(istrue(var_2.class == "medic")) {
      var_1 = level.perks_suppressasserts;
    }

    var_2 scripts\common\utility::allow_weapon(0);
    thread ref_12d17(level, var_0);
    var_3 = get_revive_result(var_0, var_2, self.origin, int(var_1));
    enable_bleedout_ent_usability(var_0);

    if(var_3) {
      var_2 scripts\common\utility::allow_weapon(1);
      stop_revive_gesture(var_2, var_2.validtakeweapon);

      if(isDefined(var_2.vo_prefix)) {
        if(isDefined(level.revive_success_vo_func)) {
          level thread[[level.revive_success_vo_func]](var_2, var_0);
        }
      } else {
        level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(var_0, "revived");
      }

      record_revive_success(var_2, var_0);
      var_2 notify("revive_teammate", var_0);
      scripts\cp\cp_analytics::ref_119bc(var_0, var_2);
      var_4 = scripts\cp\cp_endgame::get_current_zone(var_2);
      var_5 = 1;
      var_0.last_stand_state = undefined;

      if(isPlayer(var_2) && istrue(var_2.can_give_revive_xp)) {
        var_2.can_give_revive_xp = 0;
      }

      break;
    }

    var_2 notify("revive_done");
    var_0 notify("revive_done");
    set_revive_icon_color(var_0.reviveent, (0.33, 0.75, 0.24));
    var_2 scripts\common\utility::allow_weapon(1);
    stop_revive_gesture(var_2, var_2, var_2.validtakeweapon);
    self notify("revive_fail");
  }

  clear_last_stand_timer(var_0);
  self notify("revive_success");
}

function ref_12d17(var_0, var_1) {
  var_0 endon("revive_done");
  var_0 endon("revive_success");
  var_1 endon("last_stand");
  var_1 endon("death_or_disconnect");
  var_0 waittill("disconnect");
  wait 2;
  var_1 scripts\common\utility::allow_weapon(1);
  stop_revive_gesture(var_1, var_1, var_1.validtakeweapon);
}

function ref_12c4d() {
  self endon("disconnect");
  wait 2;
  self.ability_invulnerable = undefined;
}

function disable_bleedout_ent_usability(var_0) {
  if(isDefined(var_0.executeent)) {
    if(isDefined(level.disable_bleedout_ent_usability_func)) {
      level thread[[level.disable_bleedout_ent_usability_func]](var_0);
      return;
    }

    return;
  }
}

function enable_bleedout_ent_usability(var_0) {
  if(isDefined(var_0.executeent)) {
    if(isDefined(level.enable_bleedout_ent_usability_func)) {
      level thread[[level.enable_bleedout_ent_usability_func]](var_0);
      return;
    }

    return;
  }
}

function laststandmoveawayfromvehicles(var_0, var_1) {}

function getrevivetimescaler(var_0, var_1) {
  if(istrue(var_0.can_revive)) {
    return 2;
  }

  var_2 = var_0 scripts\cp\perks\cp_perks::get_perk("revive_time_scalar");

  if(var_1 scripts\cp\utility::is_consumable_active("faster_revive_upgrade")) {
    var_2 *= 2;
  }

  return var_2;
}

function record_revive_success(var_0, var_1) {
  if(isPlayer(var_0)) {
    var_0 scripts\cp\cp_merits::processmerit("mt_reviver");
    var_0 scripts\cp\cp_persistence::increment_player_career_revives(var_0);
    var_0 scripts\cp\cp_merits::processmerit("mt_revives");
    var_0 scripts\cp\cp_persistence::eog_player_update_stat("revives", 1);
    var_1 thread scripts\cp\cp_hud_message::showsplash("cp_revived", undefined, var_0);

    if(isDefined(level.revive_success_analytics_func)) {
      [[level.revive_success_analytics_func]](var_0);
      return;
    }

    return;
  }
}

function makereviveentity(var_0, var_1, var_2, var_3, var_4) {
  var_5 = (0, 0, 20);
  var_6 = anglesToForward(var_0.angles) * 30;
  var_1 = scripts\engine\utility::drop_to_ground(var_1 + var_5 + var_6, 32, -64);
  var_7 = spawn("script_model", var_1);
  var_7 setHintString(&"COOP_GAME_PLAY/REVIVE_USE");
  var_7 sethintdisplayrange(256);
  var_7 setuserange(84);
  var_7 setusefov(180);
  var_7 setCursorHint("HINT_NOICON");
  var_7 sethintdisplayfov(180);
  var_7 sethintonobstruction("hide");
  var_7 setuseholdduration("duration_none");
  var_7.owner = var_0;
  var_7.inuse = 0;
  var_7.targetname = "revive_trigger";

  if(isDefined(var_2)) {
    var_7 setModel(var_2);
  }

  if(isDefined(var_3)) {
    var_7 scriptmodelplayanim(var_3);
  }

  if(var_4) {
    var_7 linkTo(var_0, "tag_origin", var_5, (0, 0, 0));
  }

  thread cleanuplaststandent(var_7);
  return var_7;
}

function makeexecuteentity(var_0, var_1) {
  var_2 = (0, 0, 20);
  var_1 = scripts\engine\utility::drop_to_ground(var_1 + var_2, 32, -64);
  var_3 = spawn("script_model", var_1);
  var_3 setCursorHint("HINT_NOICON");
  var_3 setHintString(&"COOP_GAME_PLAY/EXECUTE");
  var_3.owner = var_0;
  var_3.inuse = 0;
  var_3 linkTo(var_0, "tag_origin", var_2, (0, 0, 0));
  thread executeent_use_think(var_3);
  thread cleanuplaststandent(var_3);
  var_0.executeent = var_3;
  return var_3;
}

function executeent_use_think(var_0) {
  var_0 endon("death");

  for(;;) {
    var_0 makeusable();
    var_0 setuseprioritymax();
    var_0 waittill("trigger", var_1);
    var_0 makeunusable();
    var_2 = var_0.owner;
    var_2.reviveent makeunusable();
    var_3 = enter_execution_sequence(var_2, var_1);
    var_4 = execute_use_hold_think(var_2, var_1);
    exit_execution_sequence(var_2, var_1, var_3);

    if(var_4) {
      var_2 playerhide();
      var_2 notify("force_bleed_out");
      return;
    }
  }
}

function enter_execution_sequence(var_0, var_1) {
  var_0 iprintlnbold("You are being ^1executed^7 by ^1" + var_1.name);
  var_1 cameraset("camera_custom_orbit_2");
  var_2 = spawn("script_model", var_0.origin);
  var_2 setModel("tag_origin");
  var_2.angles = var_1 getplayerangles();
  var_0 playerlinktodelta(var_2, "tag_origin", 0.5, 60, 60);
  return var_2;
}

function exit_execution_sequence(var_0, var_1, var_2) {
  if(var_0 scripts\cp_mp\utility\player_utility::_isalive()) {
    var_0 unlink();
  }

  if(isPlayer(var_1)) {
    var_1 cameradefault();
  }

  var_2 delete();
}

function execute_use_hold_think(var_0, var_1) {
  var_0 setclientomnvar("ui_securing", 1);
  var_1 setclientomnvar("ui_securing", 1);
  var_0 setclientomnvar("ui_securing_progress", 0);
  var_1 setclientomnvar("ui_securing_progress", 0);
  var_2 = 0;
  var_3 = 0;

  while(should_execute_continue(var_1)) {
    if(var_2 >= 2.5) {
      var_3 = 1;
      break;
    }

    var_4 = var_2 / 2.5;
    var_0 setclientomnvar("ui_securing_progress", var_4);
    var_1 setclientomnvar("ui_securing_progress", var_4);
    var_2 += 0.05;
    waitframe();
  }

  if(var_0 scripts\cp_mp\utility\player_utility::_isalive()) {
    var_0 setclientomnvar("ui_securing", 0);
  }

  if(isPlayer(var_1)) {
    var_1 setclientomnvar("ui_securing", 0);
  }

  return var_3;
}

function makereviveiconentity(var_0, var_1) {
  var_2 = (0, 0, 30);
  var_3 = spawn("script_model", var_1.origin + var_2);
  thread cleanuplaststandent(var_3);
  return var_3;
}

function maydolaststand(var_0, var_1) {
  if(scripts\cp\utility::isplayingsolo() || level.only_one_player) {
    return solo_maydolaststand(var_0, var_1);
  }

  return coop_maydolaststand(var_1);
}

function solo_maydolaststand(var_0, var_1) {
  if(var_0 && is_killed_by_kill_trigger(var_1)) {
    return false;
  }

  return true;
}

function coop_maydolaststand(var_0) {
  if(is_killed_by_kill_trigger(var_0)) {
    return false;
  }

  return true;
}

function only_use_weapon() {
  if(istrue(self.iscarrying)) {
    wait 0.5;
  }

  var_0 = get_last_stand_pistol();

  if(self hasweapon(var_0)) {
    self takeweapon(var_0);
  }

  if(weaponclass(var_0) != "pistol") {
    var_0 = scripts\cp\cp_weapon::buildweapon("iw8_pi_mike1911", ["laststand"], "none", "none", -1);
  }

  var_0 = var_0 withattachment("laststand");
  self giveweapon(var_0);
  var_1 = [getcompleteweaponname("iw8_knife_mp"), getcompleteweaponname("super_default_zm")];
  var_2 = can_use_pistol_during_last_stand(self);

  if(var_2) {
    var_1 = var_0;
  }

  _takeweaponsexceptlist(var_1);
  var_3 = get_number_of_last_stand_clips();

  if(var_2) {
    var_4 = self getammocount(var_0);
    var_5 = weaponclipsize(var_0);
    self setweaponammostock(var_0, var_5 * var_3);
    self setweaponammoclip(var_0, var_5);
    self switchtoweaponimmediate(var_0);
    return;
  }
}

function get_number_of_last_stand_clips() {
  return 2;
}

function get_last_stand_pistol() {
  if(isDefined(self.last_stand_pistol)) {
    return self.last_stand_pistol;
  }

  var_0 = self.default_starting_pistol;
  var_1 = self getweaponslistprimaries()[0];

  if(scripts\cp\utility::getbaseweaponname(var_0) == scripts\cp\utility::getbaseweaponname(var_1)) {
    return var_1;
  }

  return var_0;
}

function can_use_pistol_during_last_stand(var_0) {
  if(isDefined(level.can_use_pistol_during_laststand_func)) {
    return [[level.can_use_pistol_during_laststand_func]](var_0);
  }

  return 1;
}

function cleanuplaststandent(var_0) {
  self endon("death");
  var_0 scripts\engine\utility::ref_143a6("death", "disconnect", "revive");
  self delete();
}

function remove_from_owner_revive_icon_list(var_0, var_1) {
  if(!isDefined(var_1)) {
    return;
  }

  var_1.revive_icons = scripts\engine\utility::array_remove(var_1.revive_icons, var_0);
}

function default_player_init_laststand() {
  init_revive_icon_list(self);
}

function give_laststand(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 1;
  }

  var_2 = get_last_stand_count(var_0) + var_1;
  set_last_stand_count(var_0, var_2);
}

function take_laststand(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 1;
  }

  var_2 = get_last_stand_count(var_0) - var_1;
  set_last_stand_count(var_0, max(var_2, 0));
}

function gameshouldend(var_0) {
  if(self_revive_activated(var_0)) {
    return 0;
  }

  if((scripts\cp\utility::isplayingsolo() || level.only_one_player) && (var_0 scripts\cp\utility::has_auto_revive() || npc_revive_available())) {
    return 0;
  }

  if(scripts\cp\utility::isplayingsolo() || level.only_one_player) {
    return solo_gameshouldend(var_0);
  }

  return coop_gameshouldend(var_0);
}

function solo_gameshouldend(var_0) {
  if(player_in_laststand(var_0)) {
    return false;
  }

  return get_last_stand_count(var_0) == 0;
}

function coop_gameshouldend(var_0) {
  if(isDefined(level.coop_gameshouldendfunc)) {
    return [[level.coop_gameshouldendfunc]](var_0);
  }

  return everyone_else_all_in_laststand(var_0);
}

function everyone_else_all_in_laststand(var_0) {
  foreach(var_2 in level.players) {
    if(var_2 == var_0) {
      continue;
    }

    if(!player_in_laststand(var_2)) {
      return false;
    }
  }

  return true;
}

function get_revive_result(var_0, var_1, var_2, var_3) {
  var_4 = scripts\cp\utility::createuseent(var_2);
  thread cleanuplaststandent(var_4);
  var_5 = revive_use_hold_think(var_0, var_1, var_4, var_3 - 1500);
  return var_5;
}

function playdeathsoundinlaststand(var_0) {
  self endon("disconnect");
  self endon("revive");
  level endon("game_ended");

  if(!isDefined(var_0)) {
    return;
  }

  scripts\cp\utility::playdeathsound();
  wait var_0 / 3;
  scripts\cp\utility::playdeathsound();
  wait var_0 / 3;
  level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(self, "player_last_stand");
  scripts\cp\utility::playdeathsound();
}

function enter_spectate(var_0, var_1, var_2) {
  var_0 endon("disconnect");
  level endon("game_ended");

  if(isDefined(var_0.carryicon)) {
    var_0.carryicon destroy();
  }

  var_0.has_building_upgrade = 0;

  if(istrue(level.enable_manual_revive)) {
    thread manualreviveinspec(var_2);
  }

  enter_camera_zoomout();

  if(istrue(var_0.fauxdead) || istrue(var_0.binc130)) {
    var_0.fauxdead = undefined;
    enter_bleed_out(var_0, var_0);
    playslamzoomflash(var_0);
  } else {
    camera_zoomout(var_0, var_1, var_2);
  }

  exit_camera_zoomout();
}

function camera_zoomout(var_0, var_1, var_2) {
  if(isDefined(var_2)) {
    var_2 endon("revive_success");
  }

  var_3 = (0, 0, 30);
  var_4 = (0, 0, 100);
  var_5 = (0, 0, 400);
  var_6 = 2;
  var_7 = 0.6;
  var_8 = 0.6;
  var_9 = var_1 + var_3;
  var_10 = scripts\engine\trace::_bullet_trace(var_9, var_9 + var_4, 0, var_0);
  var_11 = var_10["position"];
  var_10 = scripts\engine\trace::_bullet_trace(var_11, var_11 + var_5, 0, var_0);
  var_12 = var_10["position"];
  var_13 = spawn("script_model", var_11);
  var_13 setModel("tag_origin");
  var_13.angles = vectortoangles((0, 0, -1));
  thread cleanuplaststandent(var_13);
  var_0 cameralinkTo(var_13, "tag_origin");
  var_13 moveTo(var_12, var_6, var_7, var_8);
  var_13 waittill("movedone");
  var_13 delete();
  enter_bleed_out(var_0, var_0);
}

function enter_bleed_out(var_0) {
  hide_all_revive_icons(var_0);

  if(isDefined(level.player_bleed_out_func)) {
    var_0[[level.player_bleed_out_func]](var_0);
    return;
  }

  if(isDefined(level.enterspectatorfunc)) {
    var_0[[level.enterspectatorfunc]]();
    return;
  }
}

function enter_camera_zoomout() {
  self playerhide();
  self freezecontrols(1);
}

function exit_camera_zoomout() {
  self cameraunlink();
  self freezecontrols(0);
}

function playslamzoomflash() {
  var_0 = newclienthudelem(self);
  var_0.x = 0;
  var_0.y = 0;
  var_0.alignx = "left";
  var_0.aligny = "top";
  var_0.sort = 1;
  var_0.horzalign = "fullscreen";
  var_0.vertalign = "fullscreen";
  var_0.alpha = 0;
  var_0.foreground = 1;
  var_0 setshader("white", 640, 480);
  var_0 fadeovertime(0.05);
  var_0.alpha = 1;
  wait 0.05;
  var_0 destroy();
}

function revive_use_hold_think(var_0, var_1, var_2, var_3) {
  if(isDefined(var_1.vo_prefix)) {
    if(isDefined(level.revive_use_hold_vo_func)) {
      level thread[[level.revive_use_hold_vo_func]](var_1, var_0);
    }
  }

  var_1 setclientomnvar("ui_securing_progress", 0);
  var_0 setclientomnvar("ui_securing_progress", 0);
  enter_revive_use_hold_think(var_0, var_1, var_2, var_3);
  set_revive_icon_color(var_0.reviveent, (0.0117, 0.9882, 0.9882));
  play_revive_gesture(var_1, var_0);
  var_1.validtakeweapon = var_1 scripts\cp\utility::getvalidtakeweapon();
  thread wait_for_exit_revive_use_hold_think(var_0, var_1, var_2, var_1.validtakeweapon);
  var_0.reviver = var_1;
  var_4 = 0;
  var_5 = 0;
  enable_on_world_progress_bar_for_other_players(var_0, var_1);
  jumpiffalse(isPlayer(var_1)) LOC_000000ab;
  var_0 notify("reviving");

  while(should_revive_continue(var_1)) {
    if(var_4 >= var_3) {
      var_5 = 1;
      break;
    }

    if(distancesquared(var_1.origin, var_0.origin) > 14400) {
      var_5 = 0;
      break;
    }

    var_6 = var_4 / var_3;
    update_players_revive_progress_bar(var_0, var_1, var_6);
    var_4 += 50;
    waitframe();
  }

  disable_on_world_progress_bar_for_other_players(var_0, var_1);
  var_2 notify("use_hold_think_complete");
  var_2 waittill("exit_use_hold_think_complete");
  return var_5;
}

function play_revive_gesture(var_0, var_1) {
  if(isDefined(level.nuclear_core_carrier)) {
    if(level.nuclear_core_carrier == var_0) {
      return;
    }
  }

  var_0 allowmelee(0);
  var_0 disableweaponswitch();
  var_0 notify("offhand_end");
}

function stop_revive_gesture(var_0, var_1) {
  if(isDefined(level.nuclear_core_carrier)) {
    if(level.nuclear_core_carrier == var_0) {
      return;
    }
  }

  var_0 enableweaponswitch();
  var_0 allowmelee(1);
}

function get_revive_gesture(var_0) {
  return "ges_revive_ally";
}

function update_players_revive_progress_bar(var_0, var_1, var_2) {
  foreach(var_4 in level.players) {
    if(var_4 == var_0 || var_4 == var_1) {
      var_4 setclientomnvar("ui_securing_progress", var_2);
      continue;
    }

    var_4 setclientomnvar("zm_revive_bar_" + var_0.revive_progress_bar_id + "_progress", var_2);
  }
}

function enter_revive_use_hold_think(var_0, var_1, var_2, var_3) {
  var_1 setclientomnvar("ui_securing_progress", 0);
  var_0 setclientomnvar("ui_securing_progress", 0);
  var_0 setclientomnvar("ui_reviver_id", var_1 getentitynumber());
  var_0 setclientomnvar("ui_securing", 6);
  var_1 setclientomnvar("ui_securing", 5);
  var_0.being_revived = 1;

  if(isPlayer(var_1)) {
    var_1 scripts\cp\cp_powers::power_disablepower();
  }

  var_1.isreviving = 1;
}

function wait_for_exit_revive_use_hold_think(var_0, var_1, var_2, var_3) {
  scripts\engine\utility::waittill_any_ents(var_2, "use_hold_think_complete", var_0, "disconnect", var_0, "revive_success", var_0, "force_bleed_out", var_1, "challenge_complete", var_0, "death");

  if(var_0 scripts\cp_mp\utility\player_utility::_isalive()) {
    var_0 setclientomnvar("ui_securing", 0);
    var_0 setclientomnvar("ui_reviver_id", -1);
    var_0 setclientomnvar("ui_securing_progress", 0);
    thread ref_12c51();
  }

  var_1.isreviving = 0;

  if(isPlayer(var_1)) {
    var_1 setclientomnvar("ui_securing", 0);
    var_1 setclientomnvar("ui_securing_progress", 0);
    var_1 setclientomnvar("ui_reviver_id", -1);
    var_1 scripts\cp\cp_powers::power_enablepower();
    var_1 unlink();
    var_1 notify("stop_revive");
  }

  var_2 notify("exit_use_hold_think_complete");
}

function ref_12c51() {
  self endon("disconnect");
  wait 1.6;
  self.being_revived = 0;
}

function play_rescue_anim(var_0) {
  var_0 endon("disconnect");
  var_0 endon("stop_playing_revive_anim");
  var_0 playanimscriptevent("power_active_cp", "gesture015");
}

function should_revive_continue(var_0) {
  if(istrue(var_0.can_revive)) {
    return true;
  }

  return !level.gameended && var_0 scripts\cp_mp\utility\player_utility::_isalive() && var_0 useButtonPressed() && !player_in_laststand(var_0);
}

function should_execute_continue(var_0) {
  return !level.gameended && var_0 scripts\cp_mp\utility\player_utility::_isalive() && var_0 useButtonPressed() && !player_in_laststand(var_0);
}

function _takeweaponsexceptlist(var_0) {
  var_1 = self getweaponslistall();

  foreach(var_3 in var_1) {
    if(scripts\engine\utility::array_contains(var_0, var_3)) {
      continue;
    }

    self takeweapon(var_3);
  }
}

function is_killed_by_kill_trigger(var_0) {
  return isDefined(var_0);
}

function set_last_stand_count(var_0, var_1) {
  var_1 = int(var_1);
  var_0 setplayerdata("cp", "alienSession", "last_stand_count", var_1);
}

function set_last_stand_timer(var_0, var_1) {
  if(isDefined(var_1)) {
    var_0 setclientomnvar("zm_ui_laststand_end_milliseconds", gettime() + var_1 * 1000);
    return;
  }
}

function clear_last_stand_timer(var_0) {
  var_0 setclientomnvar("zm_ui_laststand_end_milliseconds", 0);
}

function instant_revive(var_0) {
  if(is_being_revived(var_0)) {
    return;
  }

  var_0.trackriotshield_trydetach = 1;
  var_0 notify("revive_success");

  if(isDefined(var_0.reviveent)) {
    var_0.reviveent notify("revive_success");
  }

  if(is_being_revived(var_0)) {
    disable_on_world_progress_bar_for_other_players(var_0, var_0.reviver);
  }

  clear_last_stand_timer(var_0);
}

function set_revive_time(var_0, var_1, var_2) {
  if(isDefined(var_0)) {
    level.normal_revive_time = var_0;
  }

  if(isDefined(var_1)) {
    level.spectator_revive_time = var_1;
  }

  level.perks_suppressasserts = var_2;
}

function get_normal_revive_time() {
  if(isDefined(level.normal_revive_time)) {
    return level.normal_revive_time;
  }

  return 5000;
}

function get_spectator_revive_time() {
  if(isDefined(level.spectator_revive_time)) {
    return level.spectator_revive_time;
  }

  return 6000;
}

function updatemovespeedscale() {
  self[[level.move_speed_scale]]();
}

function get_currency_penalty_amount(var_0) {
  if(isDefined(level.laststand_currency_penalty_amount_func)) {
    return [[level.laststand_currency_penalty_amount_func]](var_0);
  }

  return 500;
}

function makereviveicon(var_0, var_1, var_2, var_3) {
  setup_revive_icon_ent(var_0);
  var_0.current_revive_icon_color = var_2;
  thread reviveiconentcleanup(var_0);
  var_4 = undefined;

  foreach(var_6 in level.players) {
    if(isDefined(level.should_show_revive_icon_to_player_func) && ![[level.should_show_revive_icon_to_player_func]](var_6, var_1)) {
      continue;
    }

    var_4 = show_revive_icon_to_player(var_0, var_6);
    add_to_revive_icon_ent_icon_list(var_0, var_4);
    LOC_00000075:
  }

  return var_4;
}

function show_revive_icon_to_player(var_0, var_1) {
  var_2 = newclienthudelem(var_1);
  var_2 setshader("waypoint_cp_revive", 8, 8);
  var_2 setwaypoint(1, 1);
  var_2 settargetEnt(var_0);
  var_2.alpha = get_revive_icon_initial_alpha(var_1);
  var_2.color = var_0.current_revive_icon_color;
  add_to_player_revive_icon_list(var_1, var_2);
  thread reviveiconcleanup(var_2, var_0);
  return var_2;
}

function reviveiconentcleanup(var_0) {
  var_0 waittill("death");
  remove_from_revive_icon_entity_list(var_0);
}

function reviveiconcleanup(var_0, var_1) {
  scripts\engine\utility::waittill_any_ents_return(var_0, "death", var_1, "disconnect");
  remove_from_owner_revive_icon_list(self, var_1);

  if(isDefined(self)) {
    self destroy();
    return;
  }
}

function set_revive_icon_color(var_0, var_1) {
  var_0.current_revive_icon_color = var_1;
  var_0.revive_icons = scripts\engine\utility::array_removeundefined(var_0.revive_icons);

  foreach(var_3 in var_0.revive_icons) {
    var_3.color = var_1;
  }
}

function init_laststand() {
  level.revive_icon_entities = [];
  level.players_being_revived = [];
  thread revive_icon_player_connect_monitor();
}

function add_to_revive_icon_entity_list(var_0) {
  level.revive_icon_entities[level.revive_icon_entities.size] = var_0;
}

function remove_from_revive_icon_entity_list(var_0) {
  level.revive_icon_entities = scripts\engine\utility::array_remove(level.revive_icon_entities, var_0);
  level.revive_icon_entities = scripts\engine\utility::array_removeundefined(level.revive_icon_entities);
}

function revive_icon_player_connect_monitor() {
  level endon("game_ended");
  jumpiffalse(istrue(level.disable_revive_icon_hotjoin_monitor)) LOC_00000012;
  return;
}

function setup_revive_icon_ent(var_0) {
  var_0.revive_icons = [];
  add_to_revive_icon_entity_list(var_0);
}

function add_to_revive_icon_ent_icon_list(var_0, var_1) {
  var_0.revive_icons[var_0.revive_icons.size] = var_1;
}

function init_revive_icon_list(var_0) {
  var_0.revive_icons = [];
}

function add_to_player_revive_icon_list(var_0, var_1) {
  var_0.revive_icons[var_0.revive_icons.size] = var_1;
}

function remove_from_player_revive_icon_list(var_0, var_1) {
  var_0.revive_icons = scripts\engine\utility::array_remove(var_0.revive_icons, var_1);
}

function get_revive_icon_initial_alpha(var_0) {
  if(isDefined(var_0.last_stand_state) && var_0.last_stand_state == "bleed_out") {
    return 0;
  }

  return 1;
}

function show_all_revive_icons(var_0) {
  foreach(var_2 in var_0.revive_icons) {
    var_2.alpha = 1;
  }
}

function hide_all_revive_icons(var_0) {
  foreach(var_2 in var_0.revive_icons) {
    var_2.alpha = 0;
  }
}

function enable_on_world_progress_bar_for_other_players(var_0, var_1) {
  var_2 = add_to_players_being_revived(var_0);
  var_3 = "zm_revive_bar_" + var_2 + "_target";

  foreach(var_5 in level.players) {
    if(var_5 == var_0 || var_5 == var_1) {
      continue;
    }

    var_5 setclientomnvar(var_3, var_0);
  }
}

function disable_on_world_progress_bar_for_other_players(var_0, var_1) {
  var_2 = "zm_revive_bar_" + var_0.revive_progress_bar_id + "_target";
  remove_from_players_being_revived(var_0);

  foreach(var_4 in level.players) {
    if(var_4 == var_0 || var_4 == var_1) {
      continue;
    }

    var_4 setclientomnvar(var_2, undefined);
  }
}

function self_revive_activated() {
  return isDefined(self.self_revive) && self.self_revive > 0;
}

function add_to_players_being_revived(var_0) {
  var_1 = 0;

  while(var_1 < 2) {
    if(!isDefined(level.players_being_revived[var_1])) {
      level.players_being_revived[var_1] = var_0;
      var_2 = var_1 + 1;
      var_0.revive_progress_bar_id = var_2;
      return var_2;
    }

    var_2++;
  }
}

function remove_from_players_being_revived(var_0) {
  for(var_1 = 0; var_1 < 2; var_1++) {
    if(isDefined(level.players_being_revived[var_1]) && level.players_being_revived[var_1] == var_0) {
      level.players_being_revived[var_1] = undefined;
      var_0.revive_progress_bar_id = undefined;
      return;
    }
  }
}

function shouldgodirectlytospectate(var_0) {
  if(getdvarint("scr_force_bleedout", 0) != 0) {
    return 1;
  }

  if(isDefined(level.shouldgodirectlytospectatefunc)) {
    return [[level.shouldgodirectlytospectatefunc]](var_0);
  }

  if(istrue(var_0.bhitbyvehicle)) {
    return 1;
  }

  if(debugafterlifearcadeenabled()) {
    return 1;
  }

  return 0;
}

function debugafterlifearcadeenabled() {
  return false;
}

function haveselfrevive() {
  return istrue(self.have_self_revive);
}

function get_last_stand_count() {
  return self getplayerdata("cp", "alienSession", "last_stand_count");
}

function is_being_revived(var_0) {
  return istrue(var_0.being_revived);
}

function player_in_laststand(var_0) {
  return var_0.inlaststand;
}

function enable_self_revive(var_0) {
  if(!isDefined(var_0.self_revive)) {
    var_0.self_revive = 0;
  }

  var_0.self_revive++;
}

function disable_self_revive(var_0) {
  var_0.self_revive--;
}

function self_revive(var_0) {
  putonground(var_0);
  var_1 = 3;

  if(isDefined(level.self_revive_wait_override)) {
    var_1 = level.self_revive_wait_override;
  }

  if(isDefined(var_0.self_revive_wait_override)) {
    var_1 = var_0.self_revive_wait_override;
  }

  var_0 scripts\engine\utility::ref_143b9(var_1, "revive_success");
  return true;
}

function give_fists_if_no_real_weapon(var_0) {
  if(has_no_real_weapon(var_0)) {
    self giveweapon("iw8_fists_mp");
    self switchtoweaponimmediate("iw8_fists_mp");
    self setspawnweapon("iw8_fists_mp", 1);
    return;
  }
}

function has_no_real_weapon(var_0) {
  var_1 = var_0 getweaponslistall();

  foreach(var_3 in var_1) {
    var_4 = var_3.basename;

    if(var_4 == "super_default_zm") {
      continue;
    }

    if(issubstr(var_4, "knife")) {
      continue;
    }

    if(var_4 == "iw8_fists_mp") {
      continue;
    }

    return false;
  }

  return true;
}

function npc_revive_available() {
  return istrue(level.the_hoff_revive);
}

function give_up_loop(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  self notify("give_up_loop");
  self endon("give_up_loop");
  self endon("give_up_done");
  self.give_up_counter = 0;
  self.give_up_state = "idle";
  self.give_up_requested = 0;
  self.give_up_rumble_ent = get_rumble_ent();
  set_rumble_intensity(self.give_up_rumble_ent, 0);
  thread give_up_monitor();

  for(;;) {
    self waittill("give_up_state_changed");

    if(self.give_up_requested) {
      if(self.give_up_counter >= 10) {
        break;
      }

      give_up_request_sequence();
      continue;
    }

    if(self.give_up_state != "idle") {
      give_up_release_sequence();
    }
  }

  if(isDefined(self.give_up_asset)) {
    self.give_up_asset delete();
  }

  self iprintln(" you have successfully given up!! ");
  return false;
}

function give_up_request_sequence() {
  self endon("give_up_done");
  self.give_up_counter++;

  if(self.give_up_state == "idle") {
    self iprintln("^1 PUSHING... Value - " + self.give_up_counter);
    self.give_up_state = "pushing";
    return;
  }

  if(self.give_up_state == "pushing") {
    give_up_push_anim(self);
    thread rumble_ramp_on(self.give_up_rumble_ent);
    return;
  }

  if(self.give_up_state == "releasing") {
    self iprintln("^1 PUSHING... Value - " + self.give_up_counter);
    self.give_up_state = "pushing";
    return;
  }
}

function give_up_release_sequence() {
  self endon("give_up_done");

  if(self.give_up_state == "releasing") {
    thread rumble_ramp_off(self.give_up_rumble_ent);
    return;
  }

  if(self.give_up_state == "pushing") {
    self iprintln("^5 RELEASING... Value - " + self.give_up_counter);
    give_up_release_anim(self);
    self.give_up_state = "releasing";
    return;
  }
}

function give_up_monitor() {
  self notifyonplayercommand("give_up_requested", "+attack");
  self notifyonplayercommand("give_up_requested", "+activate");
  self notifyonplayercommand("give_up_requested", "+usereload");
  self notifyonplayercommand("release_requested", "+speed_throw");
  self notifyonplayercommand("release_requested", "+frag");
  self notifyonplayercommand("release_requested", "+smoke");

  for(;;) {
    var_0 = scripts\engine\utility::ref_143ba(0.3, "give_up_requested", "release_requested");

    if(isDefined(var_0) && var_0 == "timeout") {
      self.give_up_counter--;

      if(self.give_up_counter <= 0) {
        self.give_up_counter = 0;
      }

      continue;
    }

    if(isDefined(var_0) && var_0 == "give_up_requested") {
      self.give_up_requested = 0;
    } else {
      self.give_up_requested = 1;
    }

    self notify("give_up_state_changed");
  }
}

function get_rumble_ent(var_0) {
  var_1 = scripts\cp\utility::get_player_from_self();

  if(!isDefined(var_0)) {
    var_0 = "steady_rumble";
  }

  var_2 = spawn("script_origin", var_1 getEye());
  var_2.intensity = 1;
  thread update_rumble_intensity(var_2, var_1);
  return var_2;
}

function set_rumble_intensity(var_0) {
  self.intensity = var_0;
}

function rumble_ramp_on(var_0) {
  thread rumble_ramp_to(1, var_0);
}

function rumble_ramp_off(var_0) {
  thread rumble_ramp_to(0, var_0);
}

function rumble_ramp_to(var_0, var_1) {
  self notify("new_ramp");
  self endon("new_ramp");
  self endon("death");
  var_2 = var_1 * 20;
  var_3 = var_0 - self.intensity;
  var_4 = var_3 / var_2;

  for(var_5 = 0; var_5 < var_2; var_5++) {
    self.intensity += var_4;
    wait 0.05;
  }

  self.intensity = var_0;
}

function update_rumble_intensity(var_0, var_1) {
  self endon("death");
  self endon("give_up_done");
  var_2 = 0;

  for(;;) {
    if(self.intensity > 0.0001 && gettime() > 300) {
      if(!var_2) {
        self playrumblelooponentity(var_1);
        var_2 = 1;
      }
    } else if(var_2) {
      self stoprumble(var_1);
      var_2 = 0;
    }

    var_3 = 1 - self.intensity;
    var_3 *= 1000;
    self.origin = var_0 getEye() + (0, 0, var_3);
    wait 0.05;
  }
}

function give_up_push_anim(var_0) {
  var_1 = var_0 getEye();
  var_2 = var_0 getplayerangles();
  var_3 = anglesToForward(var_2);
  var_4 = anglestoright(var_2);
  var_5 = anglestoup(var_2) * -1;
  var_6 = var_1 + var_3 * 17 + var_4 * 3 + var_5 * 0.16;

  if(!isDefined(var_0.give_up_asset)) {
    var_7 = spawn("script_model", var_6);
    var_7 setModel("weapon_vm_me_soscar_knife");
    var_8 = (var_2[0], var_2[1], var_2[2] + 90);
    var_7.angles = var_8;
    var_7 linkTo(var_0);
    var_0.give_up_asset = var_7;
    return;
  }

  var_0.give_up_asset moveTo(var_6, 5);
}

function give_up_release_anim(var_0) {
  var_1 = var_0 getEye();
  var_2 = var_0 getplayerangles();
  var_3 = anglesToForward(var_2);
  var_4 = anglestoright(var_2);
  var_5 = anglestoup(var_2) * -1;
  var_6 = var_1 + var_3 * 17 + var_4 * -3 + var_5 * 0.16;

  if(!isDefined(var_0.give_up_asset)) {
    var_7 = spawn("script_model", var_6);
    var_7 setModel("weapon_vm_me_soscar_knife");
    var_8 = (var_2[0], var_2[1], var_2[2] + 90);
    var_7.angles = var_8;
    var_7 linkTo(var_0);
    var_0.give_up_asset = var_7;
    return;
  }

  var_0.give_up_asset moveTo(var_6, 5);
}

function give_up_easy_setup(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  self endon("death_or_disconnect");
  self endon("revive_success");
  self endon("revive");
  self endon("revive_fail");
  self endon("last_stand_finished");
  self endon("entered_spectate");
  self endon("death");
  level endon("game_ended");
  wait 15;

  if(self isspectatingplayer()) {
    return;
  }

  thread show_give_up_hint();
  self notifyonplayercommand("give_up_requested", "+activate");
  var_12 = 0;
  level.timer_override = 0;
  var_13 = var_5;

  for(;;) {
    waitframe();

    if(istrue(level.timer_override)) {
      break;
    }

    if(is_being_revived(var_0)) {
      continue;
    }

    if(self isspectatingplayer()) {
      return;
    }

    if(self useButtonPressed()) {
      var_12 += level.framedurationseconds;

      if(var_12 >= 0.3 || istrue(level.timer_override)) {
        break;
      }
    } else {
      var_12 = 0;
    }

    self setclientomnvar("zm_hint_progress", var_12 / 0.3);
  }

  self notify("give_up_done");
  var_0 notify("force_bleed_out");

  if(scripts\cp\utility::isplayingsolo()) {
    return 1;
  }

  return 0;
}

function show_give_up_hint() {
  thread scripts\cp\utility::hint_prompt("give_up", 1);
  var_0 = scripts\engine\utility::waittill_any_ents_return(self, "death_or_disconnect", self, "give_up_done", level, "game_ended", self, "revive_success", self, "timeout", self, "returned");

  if(isDefined(var_0) && (var_0 == "revive_success" || var_0 == "returned" || var_0 == "timeout")) {
    level.timer_override = 1;
  }

  self setclientomnvar("zm_hint_index", 0);
  self setclientomnvar("zm_hint_progress", 0);
}

#using_animtree("");

function init_laststand_anims() {
  if(istrue(level.ls_anims_init)) {
    return;
  }

  level.ls_anims_init = 1;
  level.scr_animtree["ls_revive_helper"] = #animtree;
  level.scr_animtree["ls_revive_wounded"] = $;
  level.scr_anim["ls_revive_helper"]["in_stand_1"] = % sdr_mp_laststand_stand_revive_in_helper_1;
  level.scr_animname["ls_revive_helper"]["in_stand_1"] = "sdr_mp_laststand_stand_revive_in_helper_1";
  level.scr_eventanim["ls_revive_helper"]["in_stand_1"] = "ls_stand_h_in_1";
  level.scr_anim["ls_revive_helper"]["in_stand_2"] = % sdr_mp_laststand_stand_revive_in_helper_2;
  level.scr_animname["ls_revive_helper"]["in_stand_2"] = "sdr_mp_laststand_stand_revive_in_helper_2";
  level.scr_eventanim["ls_revive_helper"]["in_stand_2"] = "ls_stand_h_in_2";
  level.scr_anim["ls_revive_helper"]["in_stand_3"] = % sdr_mp_laststand_stand_revive_in_helper_3;
  level.scr_animname["ls_revive_helper"]["in_stand_3"] = "sdr_mp_laststand_stand_revive_in_helper_3";
  level.scr_eventanim["ls_revive_helper"]["in_stand_3"] = "ls_stand_h_in_3";
  level.scr_anim["ls_revive_helper"]["in_stand_4"] = % sdr_mp_laststand_stand_revive_in_helper_4;
  level.scr_animname["ls_revive_helper"]["in_stand_4"] = "sdr_mp_laststand_stand_revive_in_helper_4";
  level.scr_eventanim["ls_revive_helper"]["in_stand_4"] = "ls_stand_h_in_4";
  level.scr_anim["ls_revive_helper"]["in_stand_6"] = % sdr_mp_laststand_stand_revive_in_helper_6;
  level.scr_animname["ls_revive_helper"]["in_stand_6"] = "sdr_mp_laststand_stand_revive_in_helper_6";
  level.scr_eventanim["ls_revive_helper"]["in_stand_6"] = "ls_stand_h_in_6";
  level.scr_anim["ls_revive_helper"]["in_stand_7"] = % sdr_mp_laststand_stand_revive_in_helper_7;
  level.scr_animname["ls_revive_helper"]["in_stand_7"] = "sdr_mp_laststand_stand_revive_in_helper_7";
  level.scr_eventanim["ls_revive_helper"]["in_stand_7"] = "ls_stand_h_in_7";
  level.scr_anim["ls_revive_helper"]["in_stand_8"] = % sdr_mp_laststand_stand_revive_in_helper_8;
  level.scr_animname["ls_revive_helper"]["in_stand_8"] = "sdr_mp_laststand_stand_revive_in_helper_8";
  level.scr_eventanim["ls_revive_helper"]["in_stand_8"] = "ls_stand_h_in_8";
  level.scr_anim["ls_revive_helper"]["in_stand_9"] = % sdr_mp_laststand_stand_revive_in_helper_9;
  level.scr_animname["ls_revive_helper"]["in_stand_9"] = "sdr_mp_laststand_stand_revive_in_helper_9";
  level.scr_eventanim["ls_revive_helper"]["in_stand_9"] = "ls_stand_h_in_9";
  level.scr_anim["ls_revive_helper"]["idle_stand_1"] = % sdr_mp_laststand_stand_revive_loop_helper_1;
  level.scr_animname["ls_revive_helper"]["idle_stand_1"] = "sdr_mp_laststand_stand_revive_loop_helper_1";
  level.scr_eventanim["ls_revive_helper"]["idle_stand_1"] = "ls_stand_h_lp_1";
  level.scr_anim["ls_revive_helper"]["idle_stand_2"] = % sdr_mp_laststand_stand_revive_loop_helper_2;
  level.scr_animname["ls_revive_helper"]["idle_stand_2"] = "sdr_mp_laststand_stand_revive_loop_helper_2";
  level.scr_eventanim["ls_revive_helper"]["idle_stand_2"] = "ls_stand_h_lp_2";
  level.scr_anim["ls_revive_helper"]["idle_stand_3"] = % sdr_mp_laststand_stand_revive_loop_helper_3;
  level.scr_animname["ls_revive_helper"]["idle_stand_3"] = "sdr_mp_laststand_stand_revive_loop_helper_3";
  level.scr_eventanim["ls_revive_helper"]["idle_stand_3"] = "ls_stand_h_lp_3";
  level.scr_anim["ls_revive_helper"]["idle_stand_4"] = % sdr_mp_laststand_stand_revive_loop_helper_4;
  level.scr_animname["ls_revive_helper"]["idle_stand_4"] = "sdr_mp_laststand_stand_revive_loop_helper_4";
  level.scr_eventanim["ls_revive_helper"]["idle_stand_4"] = "ls_stand_h_lp_4";
  level.scr_anim["ls_revive_helper"]["idle_stand_6"] = % sdr_mp_laststand_stand_revive_loop_helper_6;
  level.scr_animname["ls_revive_helper"]["idle_stand_6"] = "sdr_mp_laststand_stand_revive_loop_helper_6";
  level.scr_eventanim["ls_revive_helper"]["idle_stand_6"] = "ls_stand_h_lp_6";
  level.scr_anim["ls_revive_helper"]["idle_stand_7"] = % sdr_mp_laststand_stand_revive_loop_helper_7;
  level.scr_animname["ls_revive_helper"]["idle_stand_7"] = "sdr_mp_laststand_stand_revive_loop_helper_7";
  level.scr_eventanim["ls_revive_helper"]["idle_stand_7"] = "ls_stand_h_lp_7";
  level.scr_anim["ls_revive_helper"]["idle_stand_8"] = % sdr_mp_laststand_stand_revive_loop_helper_8;
  level.scr_animname["ls_revive_helper"]["idle_stand_8"] = "sdr_mp_laststand_stand_revive_loop_helper_8";
  level.scr_eventanim["ls_revive_helper"]["idle_stand_8"] = "ls_stand_h_lp_8";
  level.scr_anim["ls_revive_helper"]["idle_stand_9"] = % sdr_mp_laststand_stand_revive_loop_helper_9;
  level.scr_animname["ls_revive_helper"]["idle_stand_9"] = "sdr_mp_laststand_stand_revive_loop_helper_9";
  level.scr_eventanim["ls_revive_helper"]["idle_stand_9"] = "ls_stand_h_lp_9";
  level.scr_anim["ls_revive_helper"]["out_stand_1"] = % sdr_mp_laststand_stand_revive_out_helper_1;
  level.scr_animname["ls_revive_helper"]["out_stand_1"] = "sdr_mp_laststand_stand_revive_out_helper_1";
  level.scr_eventanim["ls_revive_helper"]["out_stand_1"] = "ls_stand_h_out_1";
  level.scr_anim["ls_revive_helper"]["out_stand_2"] = % sdr_mp_laststand_stand_revive_out_helper_2;
  level.scr_animname["ls_revive_helper"]["out_stand_2"] = "sdr_mp_laststand_stand_revive_out_helper_2";
  level.scr_eventanim["ls_revive_helper"]["out_stand_2"] = "ls_stand_h_out_2";
  level.scr_anim["ls_revive_helper"]["out_stand_3"] = % sdr_mp_laststand_stand_revive_out_helper_3;
  level.scr_animname["ls_revive_helper"]["out_stand_3"] = "sdr_mp_laststand_stand_revive_out_helper_3";
  level.scr_eventanim["ls_revive_helper"]["out_stand_3"] = "ls_stand_h_out_3";
  level.scr_anim["ls_revive_helper"]["out_stand_4"] = % sdr_mp_laststand_stand_revive_out_helper_4;
  level.scr_animname["ls_revive_helper"]["out_stand_4"] = "sdr_mp_laststand_stand_revive_out_helper_4";
  level.scr_eventanim["ls_revive_helper"]["out_stand_4"] = "ls_stand_h_out_4";
  level.scr_anim["ls_revive_helper"]["out_stand_6"] = % sdr_mp_laststand_stand_revive_out_helper_6;
  level.scr_animname["ls_revive_helper"]["out_stand_6"] = "sdr_mp_laststand_stand_revive_out_helper_6";
  level.scr_eventanim["ls_revive_helper"]["out_stand_6"] = "ls_stand_h_out_6";
  level.scr_anim["ls_revive_helper"]["out_stand_7"] = % sdr_mp_laststand_stand_revive_out_helper_7;
  level.scr_animname["ls_revive_helper"]["out_stand_7"] = "sdr_mp_laststand_stand_revive_out_helper_7";
  level.scr_eventanim["ls_revive_helper"]["out_stand_7"] = "ls_stand_h_out_7";
  level.scr_anim["ls_revive_helper"]["out_stand_8"] = % sdr_mp_laststand_stand_revive_out_helper_8;
  level.scr_animname["ls_revive_helper"]["out_stand_8"] = "sdr_mp_laststand_stand_revive_out_helper_8";
  level.scr_eventanim["ls_revive_helper"]["out_stand_8"] = "ls_stand_h_out_8";
  level.scr_anim["ls_revive_helper"]["out_stand_9"] = % sdr_mp_laststand_stand_revive_out_helper_9;
  level.scr_animname["ls_revive_helper"]["out_stand_9"] = "sdr_mp_laststand_stand_revive_out_helper_9";
  level.scr_eventanim["ls_revive_helper"]["out_stand_9"] = "ls_stand_h_out_9";
  level.scr_anim["ls_revive_wounded"]["in_stand_1"] = % sdr_mp_laststand_stand_revive_in_wounded_1_4_7;
  level.scr_animname["ls_revive_wounded"]["in_stand_1"] = "sdr_mp_laststand_stand_revive_in_wounded_1_4_7";
  level.scr_eventanim["ls_revive_wounded"]["in_stand_1"] = "ls_stand_w_in_147";
  level.scr_anim["ls_revive_wounded"]["in_stand_2"] = % sdr_mp_laststand_stand_revive_in_wounded_2;
  level.scr_animname["ls_revive_wounded"]["in_stand_2"] = "sdr_mp_laststand_stand_revive_in_wounded_2";
  level.scr_eventanim["ls_revive_wounded"]["in_stand_2"] = "ls_stand_w_in_2";
  level.scr_anim["ls_revive_wounded"]["in_stand_3"] = % sdr_mp_laststand_stand_revive_in_wounded_3_6_9;
  level.scr_animname["ls_revive_wounded"]["in_stand_3"] = "sdr_mp_laststand_stand_revive_in_wounded_3_6_9";
  level.scr_eventanim["ls_revive_wounded"]["in_stand_3"] = "ls_stand_w_in_369";
  level.scr_anim["ls_revive_wounded"]["in_stand_4"] = % sdr_mp_laststand_stand_revive_in_wounded_1_4_7;
  level.scr_animname["ls_revive_wounded"]["in_stand_4"] = "sdr_mp_laststand_stand_revive_in_wounded_1_4_7";
  level.scr_eventanim["ls_revive_wounded"]["in_stand_4"] = "ls_stand_w_in_147";
  level.scr_anim["ls_revive_wounded"]["in_stand_6"] = % sdr_mp_laststand_stand_revive_in_wounded_3_6_9;
  level.scr_animname["ls_revive_wounded"]["in_stand_6"] = "sdr_mp_laststand_stand_revive_in_wounded_3_6_9";
  level.scr_eventanim["ls_revive_wounded"]["in_stand_6"] = "ls_stand_w_in_369";
  level.scr_anim["ls_revive_wounded"]["in_stand_7"] = % sdr_mp_laststand_stand_revive_in_wounded_1_4_7;
  level.scr_animname["ls_revive_wounded"]["in_stand_7"] = "sdr_mp_laststand_stand_revive_in_wounded_1_4_7";
  level.scr_eventanim["ls_revive_wounded"]["in_stand_7"] = "ls_stand_w_in_147";
  level.scr_anim["ls_revive_wounded"]["in_stand_8"] = % sdr_mp_laststand_stand_revive_in_wounded_8;
  level.scr_animname["ls_revive_wounded"]["in_stand_8"] = "sdr_mp_laststand_stand_revive_in_wounded_8";
  level.scr_eventanim["ls_revive_wounded"]["in_stand_8"] = "ls_stand_w_in_8";
  level.scr_anim["ls_revive_wounded"]["in_stand_9"] = % sdr_mp_laststand_stand_revive_in_wounded_3_6_9;
  level.scr_animname["ls_revive_wounded"]["in_stand_9"] = "sdr_mp_laststand_stand_revive_in_wounded_3_6_9";
  level.scr_eventanim["ls_revive_wounded"]["in_stand_9"] = "ls_stand_w_in_369";
  level.scr_anim["ls_revive_wounded"]["idle_stand_1"] = % sdr_mp_laststand_stand_revive_loop_wounded_1_4_7;
  level.scr_animname["ls_revive_wounded"]["idle_stand_1"] = "sdr_mp_laststand_stand_revive_loop_wounded_1_4_7";
  level.scr_eventanim["ls_revive_wounded"]["idle_stand_1"] = "ls_stand_w_lp_147";
  level.scr_anim["ls_revive_wounded"]["idle_stand_2"] = % sdr_mp_laststand_stand_revive_loop_wounded_2;
  level.scr_animname["ls_revive_wounded"]["idle_stand_2"] = "sdr_mp_laststand_stand_revive_loop_wounded_2";
  level.scr_eventanim["ls_revive_wounded"]["idle_stand_2"] = "ls_stand_w_lp_2";
  level.scr_anim["ls_revive_wounded"]["idle_stand_3"] = % sdr_mp_laststand_stand_revive_loop_wounded_3_6_9;
  level.scr_animname["ls_revive_wounded"]["idle_stand_3"] = "sdr_mp_laststand_stand_revive_loop_wounded_3_6_9";
  level.scr_eventanim["ls_revive_wounded"]["idle_stand_3"] = "ls_stand_w_lp_369";
  level.scr_anim["ls_revive_wounded"]["idle_stand_4"] = % sdr_mp_laststand_stand_revive_loop_wounded_1_4_7;
  level.scr_animname["ls_revive_wounded"]["idle_stand_4"] = "sdr_mp_laststand_stand_revive_loop_wounded_1_4_7";
  level.scr_eventanim["ls_revive_wounded"]["idle_stand_4"] = "ls_stand_w_lp_147";
  level.scr_anim["ls_revive_wounded"]["idle_stand_6"] = % sdr_mp_laststand_stand_revive_loop_wounded_3_6_9;
  level.scr_animname["ls_revive_wounded"]["idle_stand_6"] = "sdr_mp_laststand_stand_revive_loop_wounded_3_6_9";
  level.scr_eventanim["ls_revive_wounded"]["idle_stand_6"] = "ls_stand_w_lp_369";
  level.scr_anim["ls_revive_wounded"]["idle_stand_7"] = % sdr_mp_laststand_stand_revive_loop_wounded_1_4_7;
  level.scr_animname["ls_revive_wounded"]["idle_stand_7"] = "sdr_mp_laststand_stand_revive_loop_wounded_1_4_7";
  level.scr_eventanim["ls_revive_wounded"]["idle_stand_7"] = "ls_stand_w_lp_147";
  level.scr_anim["ls_revive_wounded"]["idle_stand_8"] = % sdr_mp_laststand_stand_revive_loop_wounded_8;
  level.scr_animname["ls_revive_wounded"]["idle_stand_8"] = "sdr_mp_laststand_stand_revive_loop_wounded_8";
  level.scr_eventanim["ls_revive_wounded"]["idle_stand_8"] = "ls_stand_w_lp_8";
  level.scr_anim["ls_revive_wounded"]["idle_stand_9"] = % sdr_mp_laststand_stand_revive_loop_wounded_3_6_9;
  level.scr_animname["ls_revive_wounded"]["idle_stand_9"] = "sdr_mp_laststand_stand_revive_loop_wounded_3_6_9";
  level.scr_eventanim["ls_revive_wounded"]["idle_stand_9"] = "ls_stand_w_lp_369";
  level.scr_anim["ls_revive_wounded"]["out_stand_1"] = % sdr_mp_laststand_stand_revive_out_wounded_1_4_7;
  level.scr_animname["ls_revive_wounded"]["out_stand_1"] = "sdr_mp_laststand_stand_revive_out_wounded_1_4_7";
  level.scr_eventanim["ls_revive_wounded"]["out_stand_1"] = "ls_stand_w_out_147";
  level.scr_anim["ls_revive_wounded"]["out_stand_2"] = % sdr_mp_laststand_stand_revive_out_wounded_2;
  level.scr_animname["ls_revive_wounded"]["out_stand_2"] = "sdr_mp_laststand_stand_revive_out_wounded_2";
  level.scr_eventanim["ls_revive_wounded"]["out_stand_2"] = "ls_stand_w_out_2";
  level.scr_anim["ls_revive_wounded"]["out_stand_3"] = % sdr_mp_laststand_stand_revive_out_wounded_3_6_9;
  level.scr_animname["ls_revive_wounded"]["out_stand_3"] = "sdr_mp_laststand_stand_revive_out_wounded_3_6_9";
  level.scr_eventanim["ls_revive_wounded"]["out_stand_3"] = "ls_stand_w_out_369";
  level.scr_anim["ls_revive_wounded"]["out_stand_4"] = % sdr_mp_laststand_stand_revive_out_wounded_1_4_7;
  level.scr_animname["ls_revive_wounded"]["out_stand_4"] = "sdr_mp_laststand_stand_revive_out_wounded_1_4_7";
  level.scr_eventanim["ls_revive_wounded"]["out_stand_4"] = "ls_stand_w_out_147";
  level.scr_anim["ls_revive_wounded"]["out_stand_6"] = % sdr_mp_laststand_stand_revive_out_wounded_3_6_9;
  level.scr_animname["ls_revive_wounded"]["out_stand_6"] = "sdr_mp_laststand_stand_revive_out_wounded_3_6_9";
  level.scr_eventanim["ls_revive_wounded"]["out_stand_6"] = "ls_stand_w_out_369";
  level.scr_anim["ls_revive_wounded"]["out_stand_7"] = % sdr_mp_laststand_stand_revive_out_wounded_1_4_7;
  level.scr_animname["ls_revive_wounded"]["out_stand_7"] = "sdr_mp_laststand_stand_revive_out_wounded_1_4_7";
  level.scr_eventanim["ls_revive_wounded"]["out_stand_7"] = "ls_stand_w_out_147";
  level.scr_anim["ls_revive_wounded"]["out_stand_8"] = % sdr_mp_laststand_stand_revive_out_wounded_8;
  level.scr_animname["ls_revive_wounded"]["out_stand_8"] = "sdr_mp_laststand_stand_revive_out_wounded_8";
  level.scr_eventanim["ls_revive_wounded"]["out_stand_8"] = "ls_stand_w_out_8";
  level.scr_anim["ls_revive_wounded"]["out_stand_9"] = % sdr_mp_laststand_stand_revive_out_wounded_3_6_9;
  level.scr_animname["ls_revive_wounded"]["out_stand_9"] = "sdr_mp_laststand_stand_revive_out_wounded_3_6_9";
  level.scr_eventanim["ls_revive_wounded"]["out_stand_9"] = "ls_stand_w_out_369";
  level.scr_anim["ls_revive_helper"]["in_crouch_1"] = % sdr_mp_laststand_crouch_revive_in_helper_1;
  level.scr_animname["ls_revive_helper"]["in_crouch_1"] = "sdr_mp_laststand_crouch_revive_in_helper_1";
  level.scr_eventanim["ls_revive_helper"]["in_crouch_1"] = "ls_crouch_h_in_1";
  level.scr_anim["ls_revive_helper"]["in_crouch_2"] = % sdr_mp_laststand_crouch_revive_in_helper_2;
  level.scr_animname["ls_revive_helper"]["in_crouch_2"] = "sdr_mp_laststand_crouch_revive_in_helper_2";
  level.scr_eventanim["ls_revive_helper"]["in_crouch_2"] = "ls_crouch_h_in_2";
  level.scr_anim["ls_revive_helper"]["in_crouch_3"] = % sdr_mp_laststand_crouch_revive_in_helper_3;
  level.scr_animname["ls_revive_helper"]["in_crouch_3"] = "sdr_mp_laststand_crouch_revive_in_helper_3";
  level.scr_eventanim["ls_revive_helper"]["in_crouch_3"] = "ls_crouch_h_in_3";
  level.scr_anim["ls_revive_helper"]["in_crouch_4"] = % sdr_mp_laststand_crouch_revive_in_helper_4;
  level.scr_animname["ls_revive_helper"]["in_crouch_4"] = "sdr_mp_laststand_crouch_revive_in_helper_4";
  level.scr_eventanim["ls_revive_helper"]["in_crouch_4"] = "ls_crouch_h_in_4";
  level.scr_anim["ls_revive_helper"]["in_crouch_6"] = % sdr_mp_laststand_crouch_revive_in_helper_6;
  level.scr_animname["ls_revive_helper"]["in_crouch_6"] = "sdr_mp_laststand_crouch_revive_in_helper_6";
  level.scr_eventanim["ls_revive_helper"]["in_crouch_6"] = "ls_crouch_h_in_6";
  level.scr_anim["ls_revive_helper"]["in_crouch_7"] = % sdr_mp_laststand_crouch_revive_in_helper_7;
  level.scr_animname["ls_revive_helper"]["in_crouch_7"] = "sdr_mp_laststand_crouch_revive_in_helper_7";
  level.scr_eventanim["ls_revive_helper"]["in_crouch_7"] = "ls_crouch_h_in_7";
  level.scr_anim["ls_revive_helper"]["in_crouch_8"] = % sdr_mp_laststand_crouch_revive_in_helper_8;
  level.scr_animname["ls_revive_helper"]["in_crouch_8"] = "sdr_mp_laststand_crouch_revive_in_helper_8";
  level.scr_eventanim["ls_revive_helper"]["in_crouch_8"] = "ls_crouch_h_in_8";
  level.scr_anim["ls_revive_helper"]["in_crouch_9"] = % sdr_mp_laststand_crouch_revive_in_helper_9;
  level.scr_animname["ls_revive_helper"]["in_crouch_9"] = "sdr_mp_laststand_crouch_revive_in_helper_9";
  level.scr_eventanim["ls_revive_helper"]["in_crouch_9"] = "ls_crouch_h_in_9";
  level.scr_anim["ls_revive_helper"]["idle_crouch_1"] = % sdr_mp_laststand_crouch_revive_loop_helper_1;
  level.scr_animname["ls_revive_helper"]["idle_crouch_1"] = "sdr_mp_laststand_crouch_revive_loop_helper_1";
  level.scr_eventanim["ls_revive_helper"]["idle_crouch_1"] = "ls_crouch_h_lp_1";
  level.scr_anim["ls_revive_helper"]["idle_crouch_2"] = % sdr_mp_laststand_crouch_revive_loop_helper_2;
  level.scr_animname["ls_revive_helper"]["idle_crouch_2"] = "sdr_mp_laststand_crouch_revive_loop_helper_2";
  level.scr_eventanim["ls_revive_helper"]["idle_crouch_2"] = "ls_crouch_h_lp_2";
  level.scr_anim["ls_revive_helper"]["idle_crouch_3"] = % sdr_mp_laststand_crouch_revive_loop_helper_3;
  level.scr_animname["ls_revive_helper"]["idle_crouch_3"] = "sdr_mp_laststand_crouch_revive_loop_helper_3";
  level.scr_eventanim["ls_revive_helper"]["idle_crouch_3"] = "ls_crouch_h_lp_3";
  level.scr_anim["ls_revive_helper"]["idle_crouch_4"] = % sdr_mp_laststand_crouch_revive_loop_helper_4;
  level.scr_animname["ls_revive_helper"]["idle_crouch_4"] = "sdr_mp_laststand_crouch_revive_loop_helper_4";
  level.scr_eventanim["ls_revive_helper"]["idle_crouch_4"] = "ls_crouch_h_lp_4";
  level.scr_anim["ls_revive_helper"]["idle_crouch_6"] = % sdr_mp_laststand_crouch_revive_loop_helper_6;
  level.scr_animname["ls_revive_helper"]["idle_crouch_6"] = "sdr_mp_laststand_crouch_revive_loop_helper_6";
  level.scr_eventanim["ls_revive_helper"]["idle_crouch_6"] = "ls_crouch_h_lp_6";
  level.scr_anim["ls_revive_helper"]["idle_crouch_7"] = % sdr_mp_laststand_crouch_revive_loop_helper_7;
  level.scr_animname["ls_revive_helper"]["idle_crouch_7"] = "sdr_mp_laststand_crouch_revive_loop_helper_7";
  level.scr_eventanim["ls_revive_helper"]["idle_crouch_7"] = "ls_crouch_h_lp_7";
  level.scr_anim["ls_revive_helper"]["idle_crouch_8"] = % sdr_mp_laststand_crouch_revive_loop_helper_8;
  level.scr_animname["ls_revive_helper"]["idle_crouch_8"] = "sdr_mp_laststand_crouch_revive_loop_helper_8";
  level.scr_eventanim["ls_revive_helper"]["idle_crouch_8"] = "ls_crouch_h_lp_8";
  level.scr_anim["ls_revive_helper"]["idle_crouch_9"] = % sdr_mp_laststand_crouch_revive_loop_helper_9;
  level.scr_animname["ls_revive_helper"]["idle_crouch_9"] = "sdr_mp_laststand_crouch_revive_loop_helper_9";
  level.scr_eventanim["ls_revive_helper"]["idle_crouch_9"] = "ls_crouch_h_lp_9";
  level.scr_anim["ls_revive_helper"]["out_crouch_1"] = % sdr_mp_laststand_crouch_revive_out_helper_1;
  level.scr_animname["ls_revive_helper"]["out_crouch_1"] = "sdr_mp_laststand_crouch_revive_out_helper_1";
  level.scr_eventanim["ls_revive_helper"]["out_crouch_1"] = "ls_crouch_h_out_1";
  level.scr_anim["ls_revive_helper"]["out_crouch_2"] = % sdr_mp_laststand_crouch_revive_out_helper_2;
  level.scr_animname["ls_revive_helper"]["out_crouch_2"] = "sdr_mp_laststand_crouch_revive_out_helper_2";
  level.scr_eventanim["ls_revive_helper"]["out_crouch_2"] = "ls_crouch_h_out_2";
  level.scr_anim["ls_revive_helper"]["out_crouch_3"] = % sdr_mp_laststand_crouch_revive_out_helper_3;
  level.scr_animname["ls_revive_helper"]["out_crouch_3"] = "sdr_mp_laststand_crouch_revive_out_helper_3";
  level.scr_eventanim["ls_revive_helper"]["out_crouch_3"] = "ls_crouch_h_out_3";
  level.scr_anim["ls_revive_helper"]["out_crouch_4"] = % sdr_mp_laststand_crouch_revive_out_helper_4;
  level.scr_animname["ls_revive_helper"]["out_crouch_4"] = "sdr_mp_laststand_crouch_revive_out_helper_4";
  level.scr_eventanim["ls_revive_helper"]["out_crouch_4"] = "ls_crouch_h_out_4";
  level.scr_anim["ls_revive_helper"]["out_crouch_6"] = % sdr_mp_laststand_crouch_revive_out_helper_6;
  level.scr_animname["ls_revive_helper"]["out_crouch_6"] = "sdr_mp_laststand_crouch_revive_out_helper_6";
  level.scr_eventanim["ls_revive_helper"]["out_crouch_6"] = "ls_crouch_h_out_6";
  level.scr_anim["ls_revive_helper"]["out_crouch_7"] = % sdr_mp_laststand_crouch_revive_out_helper_7;
  level.scr_animname["ls_revive_helper"]["out_crouch_7"] = "sdr_mp_laststand_crouch_revive_out_helper_7";
  level.scr_eventanim["ls_revive_helper"]["out_crouch_7"] = "ls_crouch_h_out_7";
  level.scr_anim["ls_revive_helper"]["out_crouch_8"] = % sdr_mp_laststand_crouch_revive_out_helper_8;
  level.scr_animname["ls_revive_helper"]["out_crouch_8"] = "sdr_mp_laststand_crouch_revive_out_helper_8";
  level.scr_eventanim["ls_revive_helper"]["out_crouch_8"] = "ls_crouch_h_out_8";
  level.scr_anim["ls_revive_helper"]["out_crouch_9"] = % sdr_mp_laststand_crouch_revive_out_helper_9;
  level.scr_animname["ls_revive_helper"]["out_crouch_9"] = "sdr_mp_laststand_crouch_revive_out_helper_9";
  level.scr_eventanim["ls_revive_helper"]["out_crouch_9"] = "ls_crouch_h_out_9";
  level.scr_anim["ls_revive_wounded"]["in_crouch_1"] = % sdr_mp_laststand_crouch_revive_in_wounded_1_4_7;
  level.scr_animname["ls_revive_wounded"]["in_crouch_1"] = "sdr_mp_laststand_crouch_revive_in_wounded_1_4_7";
  level.scr_eventanim["ls_revive_wounded"]["in_crouch_1"] = "ls_crouch_w_in_147";
  level.scr_anim["ls_revive_wounded"]["in_crouch_2"] = % sdr_mp_laststand_crouch_revive_in_wounded_2;
  level.scr_animname["ls_revive_wounded"]["in_crouch_2"] = "sdr_mp_laststand_crouch_revive_in_wounded_2";
  level.scr_eventanim["ls_revive_wounded"]["in_crouch_2"] = "ls_crouch_w_in_2";
  level.scr_anim["ls_revive_wounded"]["in_crouch_3"] = % sdr_mp_laststand_crouch_revive_in_wounded_3_6_9;
  level.scr_animname["ls_revive_wounded"]["in_crouch_3"] = "sdr_mp_laststand_crouch_revive_in_wounded_3_6_9";
  level.scr_eventanim["ls_revive_wounded"]["in_crouch_3"] = "ls_crouch_w_in_369";
  level.scr_anim["ls_revive_wounded"]["in_crouch_4"] = % sdr_mp_laststand_crouch_revive_in_wounded_1_4_7;
  level.scr_animname["ls_revive_wounded"]["in_crouch_4"] = "sdr_mp_laststand_crouch_revive_in_wounded_1_4_7";
  level.scr_eventanim["ls_revive_wounded"]["in_crouch_4"] = "ls_crouch_w_in_147";
  level.scr_anim["ls_revive_wounded"]["in_crouch_6"] = % sdr_mp_laststand_crouch_revive_in_wounded_3_6_9;
  level.scr_animname["ls_revive_wounded"]["in_crouch_6"] = "sdr_mp_laststand_crouch_revive_in_wounded_3_6_9";
  level.scr_eventanim["ls_revive_wounded"]["in_crouch_6"] = "ls_crouch_w_in_369";
  level.scr_anim["ls_revive_wounded"]["in_crouch_7"] = % sdr_mp_laststand_crouch_revive_in_wounded_1_4_7;
  level.scr_animname["ls_revive_wounded"]["in_crouch_7"] = "sdr_mp_laststand_crouch_revive_in_wounded_1_4_7";
  level.scr_eventanim["ls_revive_wounded"]["in_crouch_7"] = "ls_crouch_w_in_147";
  level.scr_anim["ls_revive_wounded"]["in_crouch_8"] = % sdr_mp_laststand_crouch_revive_in_wounded_8;
  level.scr_animname["ls_revive_wounded"]["in_crouch_8"] = "sdr_mp_laststand_crouch_revive_in_wounded_8";
  level.scr_eventanim["ls_revive_wounded"]["in_crouch_8"] = "ls_crouch_w_in_8";
  level.scr_anim["ls_revive_wounded"]["in_crouch_9"] = % sdr_mp_laststand_crouch_revive_in_wounded_3_6_9;
  level.scr_animname["ls_revive_wounded"]["in_crouch_9"] = "sdr_mp_laststand_crouch_revive_in_wounded_3_6_9";
  level.scr_eventanim["ls_revive_wounded"]["in_crouch_9"] = "ls_crouch_w_in_369";
  level.scr_anim["ls_revive_wounded"]["idle_crouch_1"] = % sdr_mp_laststand_crouch_revive_loop_wounded_1_4_7;
  level.scr_animname["ls_revive_wounded"]["idle_crouch_1"] = "sdr_mp_laststand_crouch_revive_loop_wounded_1_4_7";
  level.scr_eventanim["ls_revive_wounded"]["idle_crouch_1"] = "ls_crouch_w_lp_147";
  level.scr_anim["ls_revive_wounded"]["idle_crouch_2"] = % sdr_mp_laststand_crouch_revive_loop_wounded_2;
  level.scr_animname["ls_revive_wounded"]["idle_crouch_2"] = "sdr_mp_laststand_crouch_revive_loop_wounded_2";
  level.scr_eventanim["ls_revive_wounded"]["idle_crouch_2"] = "ls_crouch_w_lp_2";
  level.scr_anim["ls_revive_wounded"]["idle_crouch_3"] = % sdr_mp_laststand_crouch_revive_loop_wounded_3_6_9;
  level.scr_animname["ls_revive_wounded"]["idle_crouch_3"] = "sdr_mp_laststand_crouch_revive_loop_wounded_3_6_9";
  level.scr_eventanim["ls_revive_wounded"]["idle_crouch_3"] = "ls_crouch_w_lp_369";
  level.scr_anim["ls_revive_wounded"]["idle_crouch_4"] = % sdr_mp_laststand_crouch_revive_loop_wounded_1_4_7;
  level.scr_animname["ls_revive_wounded"]["idle_crouch_4"] = "sdr_mp_laststand_crouch_revive_loop_wounded_1_4_7";
  level.scr_eventanim["ls_revive_wounded"]["idle_crouch_4"] = "ls_crouch_w_lp_147";
  level.scr_anim["ls_revive_wounded"]["idle_crouch_6"] = % sdr_mp_laststand_crouch_revive_loop_wounded_3_6_9;
  level.scr_animname["ls_revive_wounded"]["idle_crouch_6"] = "sdr_mp_laststand_crouch_revive_loop_wounded_3_6_9";
  level.scr_eventanim["ls_revive_wounded"]["idle_crouch_6"] = "ls_crouch_w_lp_369";
  level.scr_anim["ls_revive_wounded"]["idle_crouch_7"] = % sdr_mp_laststand_crouch_revive_loop_wounded_1_4_7;
  level.scr_animname["ls_revive_wounded"]["idle_crouch_7"] = "sdr_mp_laststand_crouch_revive_loop_wounded_1_4_7";
  level.scr_eventanim["ls_revive_wounded"]["idle_crouch_7"] = "ls_crouch_w_lp_147";
  level.scr_anim["ls_revive_wounded"]["idle_crouch_8"] = % sdr_mp_laststand_crouch_revive_loop_wounded_8;
  level.scr_animname["ls_revive_wounded"]["idle_crouch_8"] = "sdr_mp_laststand_crouch_revive_loop_wounded_8";
  level.scr_eventanim["ls_revive_wounded"]["idle_crouch_8"] = "ls_crouch_w_lp_8";
  level.scr_anim["ls_revive_wounded"]["idle_crouch_9"] = % sdr_mp_laststand_crouch_revive_loop_wounded_3_6_9;
  level.scr_animname["ls_revive_wounded"]["idle_crouch_9"] = "sdr_mp_laststand_crouch_revive_loop_wounded_3_6_9";
  level.scr_eventanim["ls_revive_wounded"]["idle_crouch_9"] = "ls_crouch_w_lp_369";
  level.scr_anim["ls_revive_wounded"]["out_crouch_1"] = % sdr_mp_laststand_crouch_revive_out_wounded_1_4_7;
  level.scr_animname["ls_revive_wounded"]["out_crouch_1"] = "sdr_mp_laststand_crouch_revive_out_wounded_1_4_7";
  level.scr_eventanim["ls_revive_wounded"]["out_crouch_1"] = "ls_crouch_w_out_147";
  level.scr_anim["ls_revive_wounded"]["out_crouch_2"] = % sdr_mp_laststand_crouch_revive_out_wounded_2;
  level.scr_animname["ls_revive_wounded"]["out_crouch_2"] = "sdr_mp_laststand_crouch_revive_out_wounded_2";
  level.scr_eventanim["ls_revive_wounded"]["out_crouch_2"] = "ls_crouch_w_out_2";
  level.scr_anim["ls_revive_wounded"]["out_crouch_3"] = % sdr_mp_laststand_crouch_revive_out_wounded_3_6_9;
  level.scr_animname["ls_revive_wounded"]["out_crouch_3"] = "sdr_mp_laststand_crouch_revive_out_wounded_3_6_9";
  level.scr_eventanim["ls_revive_wounded"]["out_crouch_3"] = "ls_crouch_w_out_369";
  level.scr_anim["ls_revive_wounded"]["out_crouch_4"] = % sdr_mp_laststand_crouch_revive_out_wounded_1_4_7;
  level.scr_animname["ls_revive_wounded"]["out_crouch_4"] = "sdr_mp_laststand_crouch_revive_out_wounded_1_4_7";
  level.scr_eventanim["ls_revive_wounded"]["out_crouch_4"] = "ls_crouch_w_out_147";
  level.scr_anim["ls_revive_wounded"]["out_crouch_6"] = % sdr_mp_laststand_crouch_revive_out_wounded_3_6_9;
  level.scr_animname["ls_revive_wounded"]["out_crouch_6"] = "sdr_mp_laststand_crouch_revive_out_wounded_3_6_9";
  level.scr_eventanim["ls_revive_wounded"]["out_crouch_6"] = "ls_crouch_w_out_369";
  level.scr_anim["ls_revive_wounded"]["out_crouch_7"] = % sdr_mp_laststand_crouch_revive_out_wounded_1_4_7;
  level.scr_animname["ls_revive_wounded"]["out_crouch_7"] = "sdr_mp_laststand_crouch_revive_out_wounded_1_4_7";
  level.scr_eventanim["ls_revive_wounded"]["out_crouch_7"] = "ls_crouch_w_out_147";
  level.scr_anim["ls_revive_wounded"]["out_crouch_8"] = % sdr_mp_laststand_crouch_revive_out_wounded_8;
  level.scr_animname["ls_revive_wounded"]["out_crouch_8"] = "sdr_mp_laststand_crouch_revive_out_wounded_8";
  level.scr_eventanim["ls_revive_wounded"]["out_crouch_8"] = "ls_crouch_w_out_8";
  level.scr_anim["ls_revive_wounded"]["out_crouch_9"] = % sdr_mp_laststand_crouch_revive_out_wounded_3_6_9;
  level.scr_animname["ls_revive_wounded"]["out_crouch_9"] = "sdr_mp_laststand_crouch_revive_out_wounded_3_6_9";
  level.scr_eventanim["ls_revive_wounded"]["out_crouch_9"] = "ls_crouch_w_out_369";
  level.scr_anim["ls_revive_wounded"]["in_prone_1"] = % sdr_mp_laststand_prone_revive_in_wounded_1;
  level.scr_animname["ls_revive_wounded"]["in_prone_1"] = "sdr_mp_laststand_prone_revive_in_wounded_1";
  level.scr_eventanim["ls_revive_wounded"]["in_prone_1"] = "ls_prone_w_in_1";
  level.scr_anim["ls_revive_wounded"]["in_prone_2"] = % sdr_mp_laststand_prone_revive_in_wounded_2;
  level.scr_animname["ls_revive_wounded"]["in_prone_2"] = "sdr_mp_laststand_prone_revive_in_wounded_2";
  level.scr_eventanim["ls_revive_wounded"]["in_prone_2"] = "ls_prone_w_in_2";
  level.scr_anim["ls_revive_wounded"]["in_prone_3"] = % sdr_mp_laststand_prone_revive_in_wounded_3;
  level.scr_animname["ls_revive_wounded"]["in_prone_3"] = "sdr_mp_laststand_prone_revive_in_wounded_3";
  level.scr_eventanim["ls_revive_wounded"]["in_prone_3"] = "ls_prone_w_in_3";
  level.scr_anim["ls_revive_wounded"]["in_prone_4"] = % sdr_mp_laststand_prone_revive_in_wounded_4;
  level.scr_animname["ls_revive_wounded"]["in_prone_4"] = "sdr_mp_laststand_prone_revive_in_wounded_4";
  level.scr_eventanim["ls_revive_wounded"]["in_prone_4"] = "ls_prone_w_in_4";
  level.scr_anim["ls_revive_wounded"]["in_prone_6"] = % sdr_mp_laststand_prone_revive_in_wounded_6;
  level.scr_animname["ls_revive_wounded"]["in_prone_6"] = "sdr_mp_laststand_prone_revive_in_wounded_6";
  level.scr_eventanim["ls_revive_wounded"]["in_prone_6"] = "ls_prone_w_in_6";
  level.scr_anim["ls_revive_wounded"]["in_prone_7"] = % sdr_mp_laststand_prone_revive_in_wounded_7;
  level.scr_animname["ls_revive_wounded"]["in_prone_7"] = "sdr_mp_laststand_prone_revive_in_wounded_7";
  level.scr_eventanim["ls_revive_wounded"]["in_prone_7"] = "ls_prone_w_in_7";
  level.scr_anim["ls_revive_wounded"]["in_prone_8"] = % sdr_mp_laststand_prone_revive_in_wounded_8;
  level.scr_animname["ls_revive_wounded"]["in_prone_8"] = "sdr_mp_laststand_prone_revive_in_wounded_8";
  level.scr_eventanim["ls_revive_wounded"]["in_prone_8"] = "ls_prone_w_in_8";
  level.scr_anim["ls_revive_wounded"]["in_prone_9"] = % sdr_mp_laststand_prone_revive_in_wounded_9;
  level.scr_animname["ls_revive_wounded"]["in_prone_9"] = "sdr_mp_laststand_prone_revive_in_wounded_9";
  level.scr_eventanim["ls_revive_wounded"]["in_prone_9"] = "ls_prone_w_in_9";
  level.scr_anim["ls_revive_wounded"]["idle_prone_1"] = % sdr_mp_laststand_prone_revive_loop_wounded_1;
  level.scr_animname["ls_revive_wounded"]["idle_prone_1"] = "sdr_mp_laststand_prone_revive_loop_wounded_1";
  level.scr_eventanim["ls_revive_wounded"]["idle_prone_1"] = "ls_prone_w_lp_1";
  level.scr_anim["ls_revive_wounded"]["idle_prone_2"] = % sdr_mp_laststand_prone_revive_loop_wounded_2;
  level.scr_animname["ls_revive_wounded"]["idle_prone_2"] = "sdr_mp_laststand_prone_revive_loop_wounded_2";
  level.scr_eventanim["ls_revive_wounded"]["idle_prone_2"] = "ls_prone_w_lp_2";
  level.scr_anim["ls_revive_wounded"]["idle_prone_3"] = % sdr_mp_laststand_prone_revive_loop_wounded_3;
  level.scr_animname["ls_revive_wounded"]["idle_prone_3"] = "sdr_mp_laststand_prone_revive_loop_wounded_3";
  level.scr_eventanim["ls_revive_wounded"]["idle_prone_3"] = "ls_prone_w_lp_3";
  level.scr_anim["ls_revive_wounded"]["idle_prone_4"] = % sdr_mp_laststand_prone_revive_loop_wounded_4;
  level.scr_animname["ls_revive_wounded"]["idle_prone_4"] = "sdr_mp_laststand_prone_revive_loop_wounded_4";
  level.scr_eventanim["ls_revive_wounded"]["idle_prone_4"] = "ls_prone_w_lp_4";
  level.scr_anim["ls_revive_wounded"]["idle_prone_6"] = % sdr_mp_laststand_prone_revive_loop_wounded_6;
  level.scr_animname["ls_revive_wounded"]["idle_prone_6"] = "sdr_mp_laststand_prone_revive_loop_wounded_6";
  level.scr_eventanim["ls_revive_wounded"]["idle_prone_6"] = "ls_prone_w_lp_6";
  level.scr_anim["ls_revive_wounded"]["idle_prone_7"] = % sdr_mp_laststand_prone_revive_loop_wounded_7;
  level.scr_animname["ls_revive_wounded"]["idle_prone_7"] = "sdr_mp_laststand_prone_revive_loop_wounded_7";
  level.scr_eventanim["ls_revive_wounded"]["idle_prone_7"] = "ls_prone_w_lp_7";
  level.scr_anim["ls_revive_wounded"]["idle_prone_8"] = % sdr_mp_laststand_prone_revive_loop_wounded_8;
  level.scr_animname["ls_revive_wounded"]["idle_prone_8"] = "sdr_mp_laststand_prone_revive_loop_wounded_8";
  level.scr_eventanim["ls_revive_wounded"]["idle_prone_8"] = "ls_prone_w_lp_8";
  level.scr_anim["ls_revive_wounded"]["idle_prone_9"] = % sdr_mp_laststand_prone_revive_loop_wounded_9;
  level.scr_animname["ls_revive_wounded"]["idle_prone_9"] = "sdr_mp_laststand_prone_revive_loop_wounded_9";
  level.scr_eventanim["ls_revive_wounded"]["idle_prone_9"] = "ls_prone_w_lp_9";
  level.scr_anim["ls_revive_wounded"]["out_prone_1"] = % sdr_mp_laststand_prone_revive_out_wounded_1;
  level.scr_animname["ls_revive_wounded"]["out_prone_1"] = "sdr_mp_laststand_prone_revive_out_wounded_1";
  level.scr_eventanim["ls_revive_wounded"]["out_prone_1"] = "ls_prone_w_out_1";
  level.scr_anim["ls_revive_wounded"]["out_prone_2"] = % sdr_mp_laststand_prone_revive_out_wounded_2;
  level.scr_animname["ls_revive_wounded"]["out_prone_2"] = "sdr_mp_laststand_prone_revive_out_wounded_2";
  level.scr_eventanim["ls_revive_wounded"]["out_prone_2"] = "ls_prone_w_out_2";
  level.scr_anim["ls_revive_wounded"]["out_prone_3"] = % sdr_mp_laststand_prone_revive_out_wounded_3;
  level.scr_animname["ls_revive_wounded"]["out_prone_3"] = "sdr_mp_laststand_prone_revive_out_wounded_3";
  level.scr_eventanim["ls_revive_wounded"]["out_prone_3"] = "ls_prone_w_out_3";
  level.scr_anim["ls_revive_wounded"]["out_prone_4"] = % sdr_mp_laststand_prone_revive_out_wounded_4;
  level.scr_animname["ls_revive_wounded"]["out_prone_4"] = "sdr_mp_laststand_prone_revive_out_wounded_4";
  level.scr_eventanim["ls_revive_wounded"]["out_prone_4"] = "ls_prone_w_out_4";
  level.scr_anim["ls_revive_wounded"]["out_prone_6"] = % sdr_mp_laststand_prone_revive_out_wounded_6;
  level.scr_animname["ls_revive_wounded"]["out_prone_6"] = "sdr_mp_laststand_prone_revive_out_wounded_6";
  level.scr_eventanim["ls_revive_wounded"]["out_prone_6"] = "ls_prone_w_out_6";
  level.scr_anim["ls_revive_wounded"]["out_prone_7"] = % sdr_mp_laststand_prone_revive_out_wounded_7;
  level.scr_animname["ls_revive_wounded"]["out_prone_7"] = "sdr_mp_laststand_prone_revive_out_wounded_7";
  level.scr_eventanim["ls_revive_wounded"]["out_prone_7"] = "ls_prone_w_out_7";
  level.scr_anim["ls_revive_wounded"]["out_prone_8"] = % sdr_mp_laststand_prone_revive_out_wounded_8;
  level.scr_animname["ls_revive_wounded"]["out_prone_8"] = "sdr_mp_laststand_prone_revive_out_wounded_8";
  level.scr_eventanim["ls_revive_wounded"]["out_prone_8"] = "ls_prone_w_out_8";
  level.scr_anim["ls_revive_wounded"]["out_prone_9"] = % sdr_mp_laststand_prone_revive_out_wounded_9;
  level.scr_animname["ls_revive_wounded"]["out_prone_9"] = "sdr_mp_laststand_prone_revive_out_wounded_9";
  level.scr_eventanim["ls_revive_wounded"]["out_prone_9"] = "ls_prone_w_out_9";
  level.scr_anim["ls_revive_helper"]["in_prone_1"] = % sdr_mp_laststand_prone_revive_in_helper_1;
  level.scr_animname["ls_revive_helper"]["in_prone_1"] = "sdr_mp_laststand_prone_revive_in_helper_1";
  level.scr_eventanim["ls_revive_helper"]["in_prone_1"] = "ls_prone_h_in_1";
  level.scr_anim["ls_revive_helper"]["in_prone_2"] = % sdr_mp_laststand_prone_revive_in_helper_2;
  level.scr_animname["ls_revive_helper"]["in_prone_2"] = "sdr_mp_laststand_prone_revive_in_helper_2";
  level.scr_eventanim["ls_revive_helper"]["in_prone_2"] = "ls_prone_h_in_2";
  level.scr_anim["ls_revive_helper"]["in_prone_3"] = % sdr_mp_laststand_prone_revive_in_helper_3;
  level.scr_animname["ls_revive_helper"]["in_prone_3"] = "sdr_mp_laststand_prone_revive_in_helper_3";
  level.scr_eventanim["ls_revive_helper"]["in_prone_3"] = "ls_prone_h_in_3";
  level.scr_anim["ls_revive_helper"]["in_prone_4"] = % sdr_mp_laststand_prone_revive_in_helper_4;
  level.scr_animname["ls_revive_helper"]["in_prone_4"] = "sdr_mp_laststand_prone_revive_in_helper_4";
  level.scr_eventanim["ls_revive_helper"]["in_prone_4"] = "ls_prone_h_in_4";
  level.scr_anim["ls_revive_helper"]["in_prone_6"] = % sdr_mp_laststand_prone_revive_in_helper_6;
  level.scr_animname["ls_revive_helper"]["in_prone_6"] = "sdr_mp_laststand_prone_revive_in_helper_6";
  level.scr_eventanim["ls_revive_helper"]["in_prone_6"] = "ls_prone_h_in_6";
  level.scr_anim["ls_revive_helper"]["in_prone_7"] = % sdr_mp_laststand_prone_revive_in_helper_7;
  level.scr_animname["ls_revive_helper"]["in_prone_7"] = "sdr_mp_laststand_prone_revive_in_helper_7";
  level.scr_eventanim["ls_revive_helper"]["in_prone_7"] = "ls_prone_h_in_7";
  level.scr_anim["ls_revive_helper"]["in_prone_8"] = % sdr_mp_laststand_prone_revive_in_helper_8;
  level.scr_animname["ls_revive_helper"]["in_prone_8"] = "sdr_mp_laststand_prone_revive_in_helper_8";
  level.scr_eventanim["ls_revive_helper"]["in_prone_8"] = "ls_prone_h_in_8";
  level.scr_anim["ls_revive_helper"]["in_prone_9"] = % sdr_mp_laststand_prone_revive_in_helper_9;
  level.scr_animname["ls_revive_helper"]["in_prone_9"] = "sdr_mp_laststand_prone_revive_in_helper_9";
  level.scr_eventanim["ls_revive_helper"]["in_prone_9"] = "ls_prone_h_in_9";
  level.scr_anim["ls_revive_helper"]["idle_prone_1"] = % sdr_mp_laststand_prone_revive_loop_helper_1;
  level.scr_animname["ls_revive_helper"]["idle_prone_1"] = "sdr_mp_laststand_prone_revive_loop_helper_1";
  level.scr_eventanim["ls_revive_helper"]["idle_prone_1"] = "ls_prone_h_lp_1";
  level.scr_anim["ls_revive_helper"]["idle_prone_2"] = % sdr_mp_laststand_prone_revive_loop_helper_2;
  level.scr_animname["ls_revive_helper"]["idle_prone_2"] = "sdr_mp_laststand_prone_revive_loop_helper_2";
  level.scr_eventanim["ls_revive_helper"]["idle_prone_2"] = "ls_prone_h_lp_2";
  level.scr_anim["ls_revive_helper"]["idle_prone_3"] = % sdr_mp_laststand_prone_revive_loop_helper_3;
  level.scr_animname["ls_revive_helper"]["idle_prone_3"] = "sdr_mp_laststand_prone_revive_loop_helper_3";
  level.scr_eventanim["ls_revive_helper"]["idle_prone_3"] = "ls_prone_h_lp_3";
  level.scr_anim["ls_revive_helper"]["idle_prone_4"] = % sdr_mp_laststand_prone_revive_loop_helper_4;
  level.scr_animname["ls_revive_helper"]["idle_prone_4"] = "sdr_mp_laststand_prone_revive_loop_helper_4";
  level.scr_eventanim["ls_revive_helper"]["idle_prone_4"] = "ls_prone_h_lp_4";
  level.scr_anim["ls_revive_helper"]["idle_prone_6"] = % sdr_mp_laststand_prone_revive_loop_helper_6;
  level.scr_animname["ls_revive_helper"]["idle_prone_6"] = "sdr_mp_laststand_prone_revive_loop_helper_6";
  level.scr_eventanim["ls_revive_helper"]["idle_prone_6"] = "ls_prone_h_lp_6";
  level.scr_anim["ls_revive_helper"]["idle_prone_7"] = % sdr_mp_laststand_prone_revive_loop_helper_7;
  level.scr_animname["ls_revive_helper"]["idle_prone_7"] = "sdr_mp_laststand_prone_revive_loop_helper_7";
  level.scr_eventanim["ls_revive_helper"]["idle_prone_7"] = "ls_prone_h_lp_7";
  level.scr_anim["ls_revive_helper"]["idle_prone_8"] = % sdr_mp_laststand_prone_revive_loop_helper_8;
  level.scr_animname["ls_revive_helper"]["idle_prone_8"] = "sdr_mp_laststand_prone_revive_loop_helper_8";
  level.scr_eventanim["ls_revive_helper"]["idle_prone_8"] = "ls_prone_h_lp_8";
  level.scr_anim["ls_revive_helper"]["idle_prone_9"] = % sdr_mp_laststand_prone_revive_loop_helper_9;
  level.scr_animname["ls_revive_helper"]["idle_prone_9"] = "sdr_mp_laststand_prone_revive_loop_helper_9";
  level.scr_eventanim["ls_revive_helper"]["idle_prone_9"] = "ls_prone_h_lp_9";
  level.scr_anim["ls_revive_helper"]["out_prone_1"] = % sdr_mp_laststand_prone_revive_out_helper_1;
  level.scr_animname["ls_revive_helper"]["out_prone_1"] = "sdr_mp_laststand_prone_revive_out_helper_1";
  level.scr_eventanim["ls_revive_helper"]["out_prone_1"] = "ls_prone_h_out_1";
  level.scr_anim["ls_revive_helper"]["out_prone_2"] = % sdr_mp_laststand_prone_revive_out_helper_2;
  level.scr_animname["ls_revive_helper"]["out_prone_2"] = "sdr_mp_laststand_prone_revive_out_helper_2";
  level.scr_eventanim["ls_revive_helper"]["out_prone_2"] = "ls_prone_h_out_2";
  level.scr_anim["ls_revive_helper"]["out_prone_3"] = % sdr_mp_laststand_prone_revive_out_helper_3;
  level.scr_animname["ls_revive_helper"]["out_prone_3"] = "sdr_mp_laststand_prone_revive_out_helper_3";
  level.scr_eventanim["ls_revive_helper"]["out_prone_3"] = "ls_prone_h_out_3";
  level.scr_anim["ls_revive_helper"]["out_prone_4"] = % sdr_mp_laststand_prone_revive_out_helper_4;
  level.scr_animname["ls_revive_helper"]["out_prone_4"] = "sdr_mp_laststand_prone_revive_out_helper_4";
  level.scr_eventanim["ls_revive_helper"]["out_prone_4"] = "ls_prone_h_out_4";
  level.scr_anim["ls_revive_helper"]["out_prone_6"] = % sdr_mp_laststand_prone_revive_out_helper_6;
  level.scr_animname["ls_revive_helper"]["out_prone_6"] = "sdr_mp_laststand_prone_revive_out_helper_6";
  level.scr_eventanim["ls_revive_helper"]["out_prone_6"] = "ls_prone_h_out_6";
  level.scr_anim["ls_revive_helper"]["out_prone_7"] = % sdr_mp_laststand_prone_revive_out_helper_7;
  level.scr_animname["ls_revive_helper"]["out_prone_7"] = "sdr_mp_laststand_prone_revive_out_helper_7";
  level.scr_eventanim["ls_revive_helper"]["out_prone_7"] = "ls_prone_h_out_7";
  level.scr_anim["ls_revive_helper"]["out_prone_8"] = % sdr_mp_laststand_prone_revive_out_helper_8;
  level.scr_animname["ls_revive_helper"]["out_prone_8"] = "sdr_mp_laststand_prone_revive_out_helper_8";
  level.scr_eventanim["ls_revive_helper"]["out_prone_8"] = "ls_prone_h_out_8";
  level.scr_anim["ls_revive_helper"]["out_prone_9"] = % sdr_mp_laststand_prone_revive_out_helper_9;
  level.scr_animname["ls_revive_helper"]["out_prone_9"] = "sdr_mp_laststand_prone_revive_out_helper_9";
  level.scr_eventanim["ls_revive_helper"]["out_prone_9"] = "ls_prone_h_out_9";
  scripts\common\anim::addnotetrack_customfunction("ls_revive_wounded", "cp_foley_revive_wounded_down", &ref_12d18);
  scripts\common\anim::addnotetrack_customfunction("ls_revive_wounded", "cp_last_stand_revive_out_wounded", &ref_12d19);
  scripts\common\anim::addnotetrack_customfunction("ls_revive_wounded", "cp_foley_revive_wounded_recover_standing", &ref_12d1a);
}

function ref_12d18(var_0) {
  var_0 playsoundonmovingent("cp_foley_revive_wounded_down");
}

function ref_12d19(var_0) {
  var_0 playsoundonmovingent("cp_last_stand_revive_out_wounded");
}

function ref_12d1a(var_0) {
  var_0 playsoundonmovingent("cp_foley_revive_wounded_recover_standing");
}

function play_laststand_scripted_anim(var_0, var_1) {
  var_0 endon("revive_done");
  var_1 endon("revive_done");
  var_2 = get_closest_ls_entrance(var_0, var_1);

  if(!isDefined(var_2)) {
    var_3 = level.scr_anim["ls_revive_helper"]["in_6"];
    var_2 = spawnStruct();
    var_2.origin = getstartorigin(var_1.origin, var_1.angles, var_3);
    var_2.angles = getstartangles(var_1.origin, var_1.angles, var_3);
    var_2.xanim_name = "6";
    var_2.xanim_string = level.scr_animname["ls_revive_helper"]["in_6"];
  }

  thread delay_orbit_cam(var_0);
  thread delay_orbit_cam(var_1);
  var_4 = scripts\cp_mp\anim_scene::anim_scene_create_actor(var_0, "ls_revive_helper", 1, 0, 1);
  var_5 = scripts\cp_mp\anim_scene::anim_scene_create_actor(var_1, "ls_revive_wounded", 1, 0, 1);
  var_6 = spawnStruct();
  var_6.origin = var_1.origin;
  var_6.angles = var_1.angles;
  var_1.scenenode = var_6;
  var_0.ref_12d13 = var_0.origin;
  var_7 = "idle_4";
  var_8 = "out_4";

  if(issubstr(var_2.xanim_string, "_R")) {
    var_7 = "idle_6";
    var_8 = "out_6";
  }

  thread handle_stim(var_0, var_6);

  if(istrue(var_0.isjuggernaut)) {
    var_6 scripts\cp_mp\anim_scene::anim_scene([var_4, var_5], "in_" + var_2.xanim_name, 1, 0, undefined, undefined, undefined, 1);
  } else {
    var_6 scripts\cp_mp\anim_scene::anim_scene([var_4, var_5], "in_" + var_2.xanim_name, 1, 0);
  }

  if(!istrue(var_0.class == "medic")) {
    if(istrue(var_0.isjuggernaut)) {
      var_6 scripts\cp_mp\anim_scene::anim_scene([var_4, var_5], var_7, 0, 0, undefined, undefined, undefined, 1);
    } else {
      var_6 scripts\cp_mp\anim_scene::anim_scene([var_4, var_5], var_7, 0, 0);
    }
  }

  if(istrue(var_0.isjuggernaut)) {
    var_6 scripts\cp_mp\anim_scene::anim_scene([var_4, var_5], var_8, 0, 1, undefined, undefined, undefined, 1);
  } else {
    var_6 scripts\cp_mp\anim_scene::anim_scene([var_4, var_5], var_8, 0, 1);
  }

  var_1 setOrigin(var_6.origin);
}

function handle_stim(var_0, var_1) {
  var_2 = spawn("script_model", self gettagorigin("tag_accessory_right"));
  var_2.angles = self gettagangles("tag_accessory_right");
  var_2 setModel("offhand_wm_stim");
  var_2 linkTo(self, "tag_accessory_right", (0, 0, 0), (0, 0, 0));
  scripts\engine\utility::ref_143a7("revive_done", "revive_teammate", "disconnect", "last_stand");

  if(scripts\cp\utility::is_valid_player(1)) {
    var_3 = var_0.origin + (0, 0, 20);
    var_4 = physics_createcontents(["physicscontents_solid", "physicscontents_vehicleclip", "physicscontents_item", "physicscontents_ainoshoot"]);
    var_5 = physics_raycast(var_3, self.origin + (0, 0, 20), var_4, [self, var_1], 1, "physicsquery_closest", 1);

    if(isDefined(var_5) && var_5.size > 0) {
      self setOrigin(self.ref_12d13);
    }
  }

  var_2 delete();
}

function get_closest_ls_entrance(var_0) {
  var_1 = ["1", "2l", "2r", "3", "4", "6", "7", "8l", "8r", "9r"];
  var_2 = [];

  for(var_3 = 0; var_3 < var_1.size; var_3++) {
    var_4 = get_ls_entrance(var_0, var_1[var_3]);

    if(isDefined(var_4)) {
      var_2 = var_4;
    }
  }

  return scripts\engine\utility::getclosest(self.origin, var_2);
}

function get_ls_entrance(var_0, var_1) {
  var_2 = level.scr_anim["ls_revive_helper"]["in_" + var_1];
  var_3 = spawnStruct();
  var_3.origin = getstartorigin(var_0.origin, var_0.angles, var_2);
  var_3.angles = getstartangles(var_0.origin, var_0.angles, var_2);
  var_3.xanim_name = var_1;
  var_3.xanim_string = level.scr_animname["ls_revive_helper"]["in_" + var_1];
  var_4 = self.origin + (0, 0, 20);
  var_5 = physics_createcontents(["physicscontents_solid", "physicscontents_vehicleclip", "physicscontents_item", "physicscontents_ainoshoot"]);

  if(!scripts\engine\trace::player_trace_passed(var_4, var_3.origin + (0, 0, 20), self.angles, [self, var_0])) {
    return undefined;
  }

  return var_3;
}