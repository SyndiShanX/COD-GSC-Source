/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\helicopter\utility.gsc
***********************************************/

function callback_defaultplayerlaststand(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9) {
  if(isDefined(var1)) {
    if(isPlayer(var1) || isagent(var1)) {
      self.last_damaged_by = var1;
    }
  }

  if(scripts\cp_mp\utility\player_utility::isinvehicle()) {
    self.bhitbyvehicle = undefined;
  }

  if(isDefined(level.last_stand_hud_update)) {
    self[[level.last_stand_hud_update]]();
  }

  var10 = scripts\cp\cp_endgame::get_current_zone(self);
  var11 = 1;
  scripts\cp\cp_analytics::ref_119b2(self, var1);
  default_playerlaststand(var9, var1);
  return true;
}

function default_playerlaststand(var0, var1) {
  var2 = gameshouldend(self);

  if(var2 && isDefined(level.endgame) && isDefined(level.end_game_string_index)) {
    level thread[[level.endgame]]("axis", level.end_game_string_index["kia"]);
  }

  thread completepayloadexfilobjective();
  thread dropintolaststand(var0, var2, var1);
}

function completepayloadexfilobjective() {
  self endon("disconnect");
  var0 = newclienthudelem(self);
  var0.sort = 0;
  var0.x = 0;
  var0.y = 0;
  var0.alignx = "left";
  var0.aligny = "top";
  var0.foreground = 0;
  var0.horzalign = "fullscreen";
  var0.vertalign = "fullscreen";
  var0.alpha = 0.5;
  var0.enablehudlighting = 1;
  var0.lowresbackground = 1;
  var0 setshader("ui_player_pain_deathsdoor_pulse_overlay", 640, 480);
  var0 fadeovertime(20);
  var0.alpha = 1.25;
  self shellshock("default_nosound", 2);
  var1 = scripts\engine\utility::waittill_notify_or_timeout_return("revive", 20);

  if(var1 == "timeout") {
    self playlocalsound("deaths_door_in");
    scripts\common\utility::allow_weapon(0);
    scripts\common\utility::allow_melee(0);
    self shellshock("default_nosound", 4);
    self waittill("revive");
    scripts\common\utility::allow_weapon(1);
    scripts\common\utility::allow_melee(1);
  }

  var2 = 1;
  var0 fadeovertime(var2);
  var0.alpha = 0;
  wait var2;
  var0 destroy();
}

function completeobjstr() {
  self endon("disconnect");
  self endon("revive");
  var0 = 0.85;
  var1 = 0.95;

  for(;;) {
    self playlocalsound("breathing_heartbeat");
    var2 = randomfloatrange(var0, var1);
    wait var2;
  }
}

function forcebleedout(var0) {
  if(scripts\cp\utility::isplayingsolo() || level.only_one_player) {
    self setOrigin(var0.origin);
  }

  self.bleedoutspawnentityoverride = var0;
  self notify("force_bleed_out");
}

function dropintolaststand(var0, var1, var2) {
  self endon("disconnect");
  level endon("game_ended");
  self notify("last_stand");
  self notify("last_stand_start");
  var3 = gettime() + 3000;
  var4 = scripts\cp\utility::has_auto_revive();
  enter_gamemodespecificaction(var2);
  enter_globaldefaultaction();
  enter_laststand();

  if((scripts\cp\utility::isplayingsolo() || level.only_one_player) && haveselfrevive()) {
    waitinlaststand(var0, var1, var4);
  } else if(shouldgodirectlytospectate(self)) {
    waitinspectator(var0, var1);
  } else if(maydolaststand(var1, var0)) {
    var5 = waitinlaststand(var0, var1);

    if(istrue(self.trackriotshield_trydetach)) {
      var5 = 1;
    }

    if(!var5) {
      waitinspectator(var0, var1);
    }
  } else {
    waitinspectator(var0, var1);
  }

  var6 = (var3 - gettime()) / 1000;

  if(var6 > 0) {
    wait var6;
  }

  self notify("revive");
  level notify("revive_success", self);
  self.trackriotshield_trydetach = 0;
  exit_laststand();
  exit_globaldefaultaction();
  exit_gamemodespecificaction();
  var7 = scripts\cp\cp_outofbounds::getlastoobtrigger(self);

  if(isDefined(var7) && isDefined(var7.entstouching[self getentitynumber()])) {
    var7.entstouching[self getentitynumber()] = undefined;
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
  var0 = 2500;

  while(isDefined(self.last_stand_state) && self.last_stand_state == "last_stand") {
    if(distancesquared(self.watch_for_maze_ai_events, self.origin) > var0) {
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
  var0 = scripts\cp\cp_outofbounds::getlastoobtrigger(self);

  if(isDefined(var0) && isDefined(var0.entstouching[self getentitynumber()])) {
    scripts\cp\utility::allow_player_ignore_me(0);
    return;
  }

  self endon("disconnect");
  self.ability_invulnerable = 1;
  wait 5;
  scripts\cp\utility::allow_player_ignore_me(0);
  self.ability_invulnerable = undefined;
}

function set_cam(var0) {
  if(!isDefined(var0)) {
    self cameradefault();
    return;
  }

  self cameraset(var0);
}

function delay_orbit_cam(var0) {
  self endon("revive_done");
  wait var0;
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
  var0 = [getcompleteweaponname("iw8_gunless")];

  if(isDefined(level.additional_laststand_weapon_exclusion)) {
    var0 = scripts\engine\utility::array_combine(var0, level.additional_laststand_weapon_exclusion);
  }

  if(isDefined(self.former_mule_weapon)) {
    GscBinSkip0(0x2e, var0.size, self.former_mule_weapon);
  }

  var1 = [];

  foreach(var3 in self getweaponslistprimaries()) {
    if(var3.isalternate) {
      continue;
    }

    var1 = var3;
  }

  self.lost_and_found_primary_count = var1;
  scripts\cp\utility::store_weapons_status(var0, 1);
  self.lastweapon = enter_globaldefaultaction_getcurrentweapon(var0, 1);
  self.bleedoutspawnentityoverride = undefined;
  self.saved_last_stand_pistol = self.last_stand_pistol;
  self.pre_laststand_weapon = self getweaponslistprimaries()[0];
  self.pre_laststand_weapon_stock = self getweaponammostock(self.pre_laststand_weapon.basename);
  self.pre_laststand_weapon_ammo_clip = self getweaponammoclip(self.pre_laststand_weapon);
  self.being_revived = 0;
  check_for_invalid_attachments();
  thread only_use_weapon();
  var5 = self;
  var5.loadoutaccessoryweapon = var5 scripts\cp\cp_loadout::cac_getaccessoryweapon();
  var5.loadoutaccessorydata = var5 scripts\cp\cp_loadout::cac_getaccessorydata();
  var5.loadoutaccessorylogic = var5 scripts\cp\cp_loadout::force_interrupt_all_current_combat_actions();

  if(isDefined(var5.loadoutaccessorydata) && isDefined(var5.loadoutaccessoryweapon) && var5.loadoutaccessoryweapon != "none") {
    var5 scripts\cp\cp_accessories::giveplayeraccessory(var5.loadoutaccessorydata, var5.loadoutaccessoryweapon, var5.loadoutaccessorylogic);
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

  var0 = undefined;

  if(isDefined(self.lastweapon) && !scripts\engine\utility::array_contains(self.copy_fullweaponlist, self.lastweapon)) {
    self.copy_fullweaponlist = scripts\engine\utility::array_add(self.copy_fullweaponlist, self.lastweapon);
  }

  foreach(var2 in self.copy_fullweaponlist) {
    if(var2 hasattachment("doubletap", 1)) {
      var0 = var2 withoutattachment("doubletap");
      var3 = createheadicon(var0);

      if(scripts\engine\utility::array_contains(self.copy_fullweaponlist, var2)) {
        self.copy_fullweaponlist = scripts\engine\utility::array_remove(self.copy_fullweaponlist, var2);
        self.copy_fullweaponlist[self.copy_fullweaponlist.size] = var0;
      }

      if(issubstr(self.copy_weapon_current.basename, var2.basename)) {
        self.copy_weapon_current = var0;
      }

      var4 = getarraykeys(self.copy_weapon_ammo_clip);
      var5 = getarraykeys(self.copy_weapon_ammo_stock);

      foreach(var7 in var4) {
        if(issubstr(var7, var2.basename)) {
          if(var3 != var7) {
            self.copy_weapon_ammo_clip[var3] = self.copy_weapon_ammo_clip[var7];
            self.copy_weapon_ammo_clip[var7] = undefined;
          }
        }
      }

      foreach(var10 in var5) {
        if(issubstr(var10, var2.basename)) {
          if(var3 != var10) {
            self.copy_weapon_ammo_stock[var3] = self.copy_weapon_ammo_stock[var10];
            self.copy_weapon_ammo_stock[var10] = undefined;
          }
        }
      }

      if(issubstr(self.lastweapon.basename, var2.basename)) {
        self.lastweapon = var0;
      }

      if(issubstr(self.pre_laststand_weapon.basename, var2.basename)) {
        self.pre_laststand_weapon = var0;
      }
    }
  }
}

function enter_globaldefaultaction_getcurrentweapon(var0, var1) {
  var2 = scripts\cp\utility::getvalidtakeweapon(var0);

  if(isDefined(self.pre_arcade_game_weapon)) {
    var2 = self.pre_arcade_game_weapon;
  }

  var3 = 0;

  if(nullweapon(var2)) {
    var3 = 1;
  } else if(scripts\engine\utility::array_contains(var0, var2)) {
    var3 = 1;
  } else if(scripts\engine\utility::array_contains(var0, var2 getbaseweapon())) {
    var3 = 1;
  } else if(istrue(var1) && scripts\cp\utility::is_melee_weapon(var2, 1)) {
    var3 = 1;
  }

  if(scripts\cp\utility::is_primary_melee_weapon(var2)) {
    var3 = 0;
  }

  if(var3) {
    return choose_last_weapon(var0, var1, 1);
  }

  return var2;
}

function choose_last_weapon(var0, var1, var2) {
  for(var3 = 0; var3 < self.copy_fullweaponlist.size; var3++) {
    if(nullweapon(self.copy_fullweaponlist[var3])) {
      continue;
    }

    if(scripts\engine\utility::array_contains(var0, self.copy_fullweaponlist[var3])) {
      continue;
    }

    if(scripts\engine\utility::array_contains(var0, self.copy_fullweaponlist[var3] getbaseweapon())) {
      continue;
    }

    if(istrue(var1) && scripts\cp\utility::is_melee_weapon(self.copy_fullweaponlist[var3], var2)) {
      continue;
    }

    return self.copy_fullweaponlist[var3];
  }
}

function exit_globaldefaultaction() {
  self.bhitbyvehicle = undefined;
  self.haveinvulnerabilityavailable = 1;
  self.damageshieldexpiretime = gettime() + 3000;
  var0 = [];
  scripts\cp\utility::restore_weapons_status(var0);

  if(isDefined(self.pre_laststand_weapon_stock)) {
    self setweaponammostock(self.pre_laststand_weapon, self.pre_laststand_weapon_stock);
  }

  if(isDefined(self.pre_laststand_weapon_ammo_clip)) {
    self setweaponammoclip(self.pre_laststand_weapon, self.pre_laststand_weapon_ammo_clip);
  }

  self setspawnweapon(self.lastweapon, 1);
  give_fists_if_no_real_weapon(self);
  var1 = self;
  var1.loadoutaccessoryweapon = var1 scripts\cp\cp_loadout::cac_getaccessoryweapon();
  var1.loadoutaccessorydata = var1 scripts\cp\cp_loadout::cac_getaccessorydata();
  var1.loadoutaccessorylogic = var1 scripts\cp\cp_loadout::force_interrupt_all_current_combat_actions();

  if(isDefined(var1.loadoutaccessorydata) && isDefined(var1.loadoutaccessoryweapon) && var1.loadoutaccessoryweapon != "none") {
    var1 scripts\cp\cp_accessories::giveplayeraccessory(var1.loadoutaccessorydata, var1.loadoutaccessoryweapon, var1.loadoutaccessorylogic);
  }

  scripts\cp\cp_globallogic::broadcast_status(self, 0);
  self.bleedoutspawnentityoverride = undefined;
  scripts\cp\cp_analytics::inc_revived_counts();
  scripts\cp\cp_damage::set_kill_trigger_event_processed(self, 0);
  updatemovespeedscale();
  scripts\cp\cp_globallogic::updatematchhasmorethan1playeromnvaronplayersfirstspawn();
}

function enter_gamemodespecificaction(var0) {
  if(isDefined(level.laststand_enter_gamemodespecificaction)) {
    [[level.laststand_enter_gamemodespecificaction]](self, var0);
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

function waitinlaststand(var0, var1, var2) {
  self endon("disconnect");
  self endon("revive");
  self endon("revive_success");
  level endon("game_ended");

  if(self_revive_activated()) {
    return self_revive(self);
  }

  var3 = undefined;
  var4 = 3;

  if(isDefined(level.self_revive_wait_override)) {
    var4 = level.self_revive_wait_override;
  }

  if(scripts\cp\utility::has_auto_revive() && !npc_revive_available()) {
    wait var4;
    self setclientomnvar("ui_self_revive", 0);
    return 1;
  }

  if(!var1) {
    thread playdeathsoundinlaststand(var3);

    if(scripts\cp\utility::isplayingsolo() || level.only_one_player) {
      take_laststand(self, 1);

      if(npc_revive_available()) {
        set_last_stand_timer(self, 35);
      } else {
        set_last_stand_timer(self, 5);
      }
    } else {
      set_last_stand_timer(self, var3);
    }
  }

  foreach(var6 in level.players) {
    if(var6 != self) {
      var6 thread scripts\cp\cp_hud_message::showsplash("cp_in_laststand", undefined, self);
    }
  }

  if(scripts\cp\utility::isplayingsolo() || level.only_one_player && !npc_revive_available()) {
    return wait_for_self_revive(var0, var1);
  }

  return wait_to_be_revived(self, self.origin, undefined, undefined, 1, get_normal_revive_time(), (0.33, 0.75, 0.24), var3, 0, var1, 1, var2);
}

function getbleedouttime() {
  if(isDefined(level.get_bleed_out_time)) {
    return [[level.get_bleed_out_time]]();
  }

  return 35;
}

function waitinspectator(var0, var1) {
  self endon("disconnect");
  level endon("game_ended");
  wait 0.5;
  scripts\cp\cp_globallogic::updatematchhasmorethan1playeromnvaronplayerdisconnect();
  self notify("death");
  self setclientomnvar("ui_out_of_bounds_countdown", 0);
  waitframe();
  scripts\cp\cp_globallogic::broadcast_status(self, 2);
  record_bleedout(var0);

  if(isDefined(self.bleedoutspawnentityoverride)) {
    var0 = self.bleedoutspawnentityoverride;
    self.bleedoutspawnentityoverride = undefined;
  }

  if(is_killed_by_kill_trigger(var0)) {
    var2 = self;

    if(isDefined(var0)) {
      var2 = var0;
    }

    var3 = scripts\engine\utility::drop_to_ground(var2.origin, 32, -64) + (0, 0, 5);
    var4 = var2.angles;
  } else {
    var3 = self.origin;
    var4 = self.angles;
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

    if(self[[level.respawn_func]](self, var3)) {
      show_all_revive_icons(self);
      scripts\cp\cp_globallogic::broadcast_status(self, 0);
      self.spectating = undefined;
      scripts\cp\utility::updatesessionstate("playing");

      if(!isDefined(self.forcespawnorigin) && !isDefined(self.forcespawnangles)) {
        self.forcespawnorigin = var3;
        self.forcespawnangles = var4;
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
    var5 = wait_to_be_revived(self, var3, undefined, undefined, 0, get_spectator_revive_time(), (1, 0, 0), undefined, 1, var4, 0);
  } else {
    thread enter_spectate(self, var3, undefined);
    self.last_stand_state = "bleed_out";
    level waittill("timeout_wave");
  }

  show_all_revive_icons(self);
  scripts\cp\cp_globallogic::broadcast_status(self, 0);
  self.spectating = undefined;
  scripts\cp\utility::updatesessionstate("playing");

  if(!isDefined(self.forcespawnorigin) && !isDefined(self.forcespawnangles)) {
    self.forcespawnorigin = var3;
    self.forcespawnangles = var4;
  }

  if(isDefined(level.prespawnfromspectaorfunc)) {
    [[level.prespawnfromspectaorfunc]](self);
  }

  [[level.spawnplayerfunc]]();
  self.shouldskiplaststand = 0;
}

function record_bleedout(var0) {
  scripts\cp\cp_persistence::eog_player_update_stat("deaths", 1);

  if(!is_killed_by_kill_trigger(var0)) {
    scripts\cp\cp_gamescore::update_team_encounter_performance(scripts\cp\cp_gamescore::get_team_score_component_name(), "num_players_bleed_out");
    scripts\cp\cp_analytics::inc_bleedout_counts();
    return;
  }
}

function wait_for_self_revive(var0, var1) {
  if(var1) {
    level waittill("forever");
    clear_last_stand_timer(self);
    return false;
  }

  if(is_killed_by_kill_trigger(var0)) {
    self setOrigin(var0.origin);
  } else {
    wait 5;
  }

  clear_last_stand_timer(self);
  return true;
}

function wait_to_be_revived(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11) {
  var12 = makereviveentity(var0, var1, var2, var3, var4);

  if(var8) {
    thread enter_spectate(var0, var1, var12);
    var0.last_stand_state = "bleed_out";
  } else {
    level notify("waiting_to_be_revived_from_laststand", var0);
  }

  if(var9) {
    level waittill("forever");
    return 0;
  }

  var13 = var12;

  if(var8) {
    var13 = makereviveiconentity(var0, var12);
  }

  if(var10) {
    var13 scripts\cp\cp_laststand::makereviveicon(var13, var0, var6, var7);
  }

  var0.reviveent = var12;
  var0.reviveiconent = var13;

  if(isDefined(level.give_up_func) && (!var0 isspectatingplayer() || !istrue(var8))) {
    var0 thread[[level.give_up_func]](var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11);
  }

  if(var10) {
    thread laststandwaittillrevivebyteammate(var12, var0);
  }

  if(istrue(1)) {
    thread laststandmoveawayfromvehicles(var12, var0);
  }

  if(isDefined(var7)) {
    var14 = var12 scripts\engine\utility::waittill_any_ents_or_timeout_return(var7, var12, "revive_success", var0, "force_bleed_out", var0, "revive_success", var0, "challenge_complete_revive");
  } else {
    var14 = var13 scripts\engine\utility::waittill_any_ents_return(var13, "revive_success", var1, "challenge_complete_revive", var1, "force_bleed_out");
  }

  if(var14 == "timeout" && is_being_revived(var1)) {
    var14 = var13 scripts\engine\utility::ref_143ad("revive_success", "revive_fail");
  }

  if(isDefined(var1.reviveent)) {
    var1.reviveent delete();
  }

  if(isDefined(var1.reviveiconent)) {
    var1.reviveiconent delete();
  }

  var1 notify("give_up_done");

  if(var14 == "revive_success" || var14 == "challenge_complete_revive") {
    return 1;
  }

  return 0;
}

function manualreviveinspec(var0) {
  self endon("death");
  level endon("game_ended");
  var0 endon("revive");
  var1 = 120;
  wait var1;
  var0 notifyonplayercommand("manual_revive", "+usereload");
  var0 thread scripts\cp\utility::hint_prompt("manual_revive", 1);
  var0 waittill("manual_revive");
  var0 thread scripts\cp\utility::hint_prompt("manual_revive", 0);

  if(isDefined(var0.dogtag)) {
    var0.dogtag delete();
  }

  thread teleport_to_location();
  thread instant_revive(var0);
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

function putonground(var0) {
  if(!var0 isonground()) {
    var1 = scripts\engine\utility::drop_to_ground(var0.origin, 5, -1500);
    var1 = getclosestpointonnavmesh(var1);
    var0 setOrigin(var1);
    return;
  }
}

function laststandwaittillrevivebyteammate(var0, var1) {
  self endon("death");
  level endon("game_ended");

  if(isDefined(level.revive_ent_usability_func)) {
    self thread[[level.revive_ent_usability_func]](var0, self);
  }

  putonground(var0);

  for(;;) {
    self makeusable();
    self setuseprioritymax();
    self waittill("trigger", var2);
    self makeunusable();

    if(!var2 isonground()) {
      continue;
    }

    if(var2 ismeleeing()) {
      continue;
    }

    if(istrue(var2.waitgiveammo)) {
      continue;
    }

    if(!isPlayer(var2) && !istrue(var2.can_revive)) {
      continue;
    }

    if(istrue(var0.adrenalinepoweractive)) {
      continue;
    }

    if(istrue(var2.usingascender)) {
      continue;
    }

    if(!isDefined(var2.ref_12d16)) {
      var2.ref_12d16 = 0;
    }

    if(gettime() > var2.ref_12d16) {
      level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(var2, "reviving");
      var2.ref_12d16 = gettime() + 10000;
    }

    disable_bleedout_ent_usability(var0);

    if(istrue(var2.class == "medic")) {
      var1 = level.perks_suppressasserts;
    }

    var2 scripts\common\utility::allow_weapon(0);
    thread ref_12d17(level, var0);
    var3 = get_revive_result(var0, var2, self.origin, int(var1));
    enable_bleedout_ent_usability(var0);

    if(var3) {
      var2 scripts\common\utility::allow_weapon(1);
      stop_revive_gesture(var2, var2.validtakeweapon);

      if(isDefined(var2.vo_prefix)) {
        if(isDefined(level.revive_success_vo_func)) {
          level thread[[level.revive_success_vo_func]](var2, var0);
        }
      } else {
        level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(var0, "revived");
      }

      record_revive_success(var2, var0);
      var2 notify("revive_teammate", var0);
      scripts\cp\cp_analytics::ref_119bc(var0, var2);
      var4 = scripts\cp\cp_endgame::get_current_zone(var2);
      var5 = 1;
      var0.last_stand_state = undefined;

      if(isPlayer(var2) && istrue(var2.can_give_revive_xp)) {
        var2.can_give_revive_xp = 0;
      }

      break;
    }

    var2 notify("revive_done");
    var0 notify("revive_done");
    set_revive_icon_color(var0.reviveent, (0.33, 0.75, 0.24));
    var2 scripts\common\utility::allow_weapon(1);
    stop_revive_gesture(var2, var2, var2.validtakeweapon);
    self notify("revive_fail");
  }

  clear_last_stand_timer(var0);
  self notify("revive_success");
}

function ref_12d17(var0, var1) {
  var0 endon("revive_done");
  var0 endon("revive_success");
  var1 endon("last_stand");
  var1 endon("death_or_disconnect");
  var0 waittill("disconnect");
  wait 2;
  var1 scripts\common\utility::allow_weapon(1);
  stop_revive_gesture(var1, var1, var1.validtakeweapon);
}

function ref_12c4d() {
  self endon("disconnect");
  wait 2;
  self.ability_invulnerable = undefined;
}

function disable_bleedout_ent_usability(var0) {
  if(isDefined(var0.executeent)) {
    if(isDefined(level.disable_bleedout_ent_usability_func)) {
      level thread[[level.disable_bleedout_ent_usability_func]](var0);
      return;
    }

    return;
  }
}

function enable_bleedout_ent_usability(var0) {
  if(isDefined(var0.executeent)) {
    if(isDefined(level.enable_bleedout_ent_usability_func)) {
      level thread[[level.enable_bleedout_ent_usability_func]](var0);
      return;
    }

    return;
  }
}

function laststandmoveawayfromvehicles(var0, var1) {}

function getrevivetimescaler(var0, var1) {
  if(istrue(var0.can_revive)) {
    return 2;
  }

  var2 = var0 scripts\cp\perks\cp_perks::get_perk("revive_time_scalar");

  if(var1 scripts\cp\utility::is_consumable_active("faster_revive_upgrade")) {
    var2 *= 2;
  }

  return var2;
}

function record_revive_success(var0, var1) {
  if(isPlayer(var0)) {
    var0 scripts\cp\cp_merits::processmerit("mt_reviver");
    var0 scripts\cp\cp_persistence::increment_player_career_revives(var0);
    var0 scripts\cp\cp_merits::processmerit("mt_revives");
    var0 scripts\cp\cp_persistence::eog_player_update_stat("revives", 1);
    var1 thread scripts\cp\cp_hud_message::showsplash("cp_revived", undefined, var0);

    if(isDefined(level.revive_success_analytics_func)) {
      [[level.revive_success_analytics_func]](var0);
      return;
    }

    return;
  }
}

function makereviveentity(var0, var1, var2, var3, var4) {
  var5 = (0, 0, 20);
  var6 = anglesToForward(var0.angles) * 30;
  var1 = scripts\engine\utility::drop_to_ground(var1 + var5 + var6, 32, -64);
  var7 = spawn("script_model", var1);
  var7 setHintString(&"COOP_GAME_PLAY/REVIVE_USE");
  var7 sethintdisplayrange(256);
  var7 setuserange(84);
  var7 setusefov(180);
  var7 setCursorHint("HINT_NOICON");
  var7 sethintdisplayfov(180);
  var7 sethintonobstruction("hide");
  var7 setuseholdduration("duration_none");
  var7.owner = var0;
  var7.inuse = 0;
  var7.targetname = "revive_trigger";

  if(isDefined(var2)) {
    var7 setModel(var2);
  }

  if(isDefined(var3)) {
    var7 scriptmodelplayanim(var3);
  }

  if(var4) {
    var7 linkTo(var0, "tag_origin", var5, (0, 0, 0));
  }

  thread cleanuplaststandent(var7);
  return var7;
}

function makeexecuteentity(var0, var1) {
  var2 = (0, 0, 20);
  var1 = scripts\engine\utility::drop_to_ground(var1 + var2, 32, -64);
  var3 = spawn("script_model", var1);
  var3 setCursorHint("HINT_NOICON");
  var3 setHintString(&"COOP_GAME_PLAY/EXECUTE");
  var3.owner = var0;
  var3.inuse = 0;
  var3 linkTo(var0, "tag_origin", var2, (0, 0, 0));
  thread executeent_use_think(var3);
  thread cleanuplaststandent(var3);
  var0.executeent = var3;
  return var3;
}

function executeent_use_think(var0) {
  var0 endon("death");

  for(;;) {
    var0 makeusable();
    var0 setuseprioritymax();
    var0 waittill("trigger", var1);
    var0 makeunusable();
    var2 = var0.owner;
    var2.reviveent makeunusable();
    var3 = enter_execution_sequence(var2, var1);
    var4 = execute_use_hold_think(var2, var1);
    exit_execution_sequence(var2, var1, var3);

    if(var4) {
      var2 playerhide();
      var2 notify("force_bleed_out");
      return;
    }
  }
}

function enter_execution_sequence(var0, var1) {
  var0 iprintlnbold("You are being ^1executed^7 by ^1" + var1.name);
  var1 cameraset("camera_custom_orbit_2");
  var2 = spawn("script_model", var0.origin);
  var2 setModel("tag_origin");
  var2.angles = var1 getplayerangles();
  var0 playerlinktodelta(var2, "tag_origin", 0.5, 60, 60);
  return var2;
}

function exit_execution_sequence(var0, var1, var2) {
  if(var0 scripts\cp_mp\utility\player_utility::_isalive()) {
    var0 unlink();
  }

  if(isPlayer(var1)) {
    var1 cameradefault();
  }

  var2 delete();
}

function execute_use_hold_think(var0, var1) {
  var0 setclientomnvar("ui_securing", 1);
  var1 setclientomnvar("ui_securing", 1);
  var0 setclientomnvar("ui_securing_progress", 0);
  var1 setclientomnvar("ui_securing_progress", 0);
  var2 = 0;
  var3 = 0;

  while(should_execute_continue(var1)) {
    if(var2 >= 2.5) {
      var3 = 1;
      break;
    }

    var4 = var2 / 2.5;
    var0 setclientomnvar("ui_securing_progress", var4);
    var1 setclientomnvar("ui_securing_progress", var4);
    var2 += 0.05;
    waitframe();
  }

  if(var0 scripts\cp_mp\utility\player_utility::_isalive()) {
    var0 setclientomnvar("ui_securing", 0);
  }

  if(isPlayer(var1)) {
    var1 setclientomnvar("ui_securing", 0);
  }

  return var3;
}

function makereviveiconentity(var0, var1) {
  var2 = (0, 0, 30);
  var3 = spawn("script_model", var1.origin + var2);
  thread cleanuplaststandent(var3);
  return var3;
}

function maydolaststand(var0, var1) {
  if(scripts\cp\utility::isplayingsolo() || level.only_one_player) {
    return solo_maydolaststand(var0, var1);
  }

  return coop_maydolaststand(var1);
}

function solo_maydolaststand(var0, var1) {
  if(var0 && is_killed_by_kill_trigger(var1)) {
    return false;
  }

  return true;
}

function coop_maydolaststand(var0) {
  if(is_killed_by_kill_trigger(var0)) {
    return false;
  }

  return true;
}

function only_use_weapon() {
  if(istrue(self.iscarrying)) {
    wait 0.5;
  }

  var0 = get_last_stand_pistol();

  if(self hasweapon(var0)) {
    self takeweapon(var0);
  }

  if(weaponclass(var0) != "pistol") {
    var0 = scripts\cp\cp_weapon::buildweapon("iw8_pi_mike1911", ["laststand"], "none", "none", -1);
  }

  var0 = var0 withattachment("laststand");
  self giveweapon(var0);
  var1 = [getcompleteweaponname("iw8_knife_mp"), getcompleteweaponname("super_default_zm")];
  var2 = can_use_pistol_during_last_stand(self);

  if(var2) {
    var1 = var0;
  }

  _takeweaponsexceptlist(var1);
  var3 = get_number_of_last_stand_clips();

  if(var2) {
    var4 = self getammocount(var0);
    var5 = weaponclipsize(var0);
    self setweaponammostock(var0, var5 * var3);
    self setweaponammoclip(var0, var5);
    self switchtoweaponimmediate(var0);
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

  var0 = self.default_starting_pistol;
  var1 = self getweaponslistprimaries()[0];

  if(scripts\cp\utility::getbaseweaponname(var0) == scripts\cp\utility::getbaseweaponname(var1)) {
    return var1;
  }

  return var0;
}

function can_use_pistol_during_last_stand(var0) {
  if(isDefined(level.can_use_pistol_during_laststand_func)) {
    return [[level.can_use_pistol_during_laststand_func]](var0);
  }

  return 1;
}

function cleanuplaststandent(var0) {
  self endon("death");
  var0 scripts\engine\utility::ref_143a6("death", "disconnect", "revive");
  self delete();
}

function remove_from_owner_revive_icon_list(var0, var1) {
  if(!isDefined(var1)) {
    return;
  }

  var1.revive_icons = scripts\engine\utility::array_remove(var1.revive_icons, var0);
}

function default_player_init_laststand() {
  init_revive_icon_list(self);
}

function give_laststand(var0, var1) {
  if(!isDefined(var1)) {
    var1 = 1;
  }

  var2 = get_last_stand_count(var0) + var1;
  set_last_stand_count(var0, var2);
}

function take_laststand(var0, var1) {
  if(!isDefined(var1)) {
    var1 = 1;
  }

  var2 = get_last_stand_count(var0) - var1;
  set_last_stand_count(var0, max(var2, 0));
}

function gameshouldend(var0) {
  if(self_revive_activated(var0)) {
    return 0;
  }

  if((scripts\cp\utility::isplayingsolo() || level.only_one_player) && (var0 scripts\cp\utility::has_auto_revive() || npc_revive_available())) {
    return 0;
  }

  if(scripts\cp\utility::isplayingsolo() || level.only_one_player) {
    return solo_gameshouldend(var0);
  }

  return coop_gameshouldend(var0);
}

function solo_gameshouldend(var0) {
  if(player_in_laststand(var0)) {
    return false;
  }

  return get_last_stand_count(var0) == 0;
}

function coop_gameshouldend(var0) {
  if(isDefined(level.coop_gameshouldendfunc)) {
    return [[level.coop_gameshouldendfunc]](var0);
  }

  return everyone_else_all_in_laststand(var0);
}

function everyone_else_all_in_laststand(var0) {
  foreach(var2 in level.players) {
    if(var2 == var0) {
      continue;
    }

    if(!player_in_laststand(var2)) {
      return false;
    }
  }

  return true;
}

function get_revive_result(var0, var1, var2, var3) {
  var4 = scripts\cp\utility::createuseent(var2);
  thread cleanuplaststandent(var4);
  var5 = revive_use_hold_think(var0, var1, var4, var3 - 1500);
  return var5;
}

function playdeathsoundinlaststand(var0) {
  self endon("disconnect");
  self endon("revive");
  level endon("game_ended");

  if(!isDefined(var0)) {
    return;
  }

  scripts\cp\utility::playdeathsound();
  wait var0 / 3;
  scripts\cp\utility::playdeathsound();
  wait var0 / 3;
  level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(self, "player_last_stand");
  scripts\cp\utility::playdeathsound();
}

function enter_spectate(var0, var1, var2) {
  var0 endon("disconnect");
  level endon("game_ended");

  if(isDefined(var0.carryicon)) {
    var0.carryicon destroy();
  }

  var0.has_building_upgrade = 0;

  if(istrue(level.enable_manual_revive)) {
    thread manualreviveinspec(var2);
  }

  enter_camera_zoomout();

  if(istrue(var0.fauxdead) || istrue(var0.binc130)) {
    var0.fauxdead = undefined;
    enter_bleed_out(var0, var0);
    playslamzoomflash(var0);
  } else {
    camera_zoomout(var0, var1, var2);
  }

  exit_camera_zoomout();
}

function camera_zoomout(var0, var1, var2) {
  if(isDefined(var2)) {
    var2 endon("revive_success");
  }

  var3 = (0, 0, 30);
  var4 = (0, 0, 100);
  var5 = (0, 0, 400);
  var6 = 2;
  var7 = 0.6;
  var8 = 0.6;
  var9 = var1 + var3;
  var10 = scripts\engine\trace::_bullet_trace(var9, var9 + var4, 0, var0);
  var11 = var10["position"];
  var10 = scripts\engine\trace::_bullet_trace(var11, var11 + var5, 0, var0);
  var12 = var10["position"];
  var13 = spawn("script_model", var11);
  var13 setModel("tag_origin");
  var13.angles = vectortoangles((0, 0, -1));
  thread cleanuplaststandent(var13);
  var0 cameralinkTo(var13, "tag_origin");
  var13 moveTo(var12, var6, var7, var8);
  var13 waittill("movedone");
  var13 delete();
  enter_bleed_out(var0, var0);
}

function enter_bleed_out(var0) {
  hide_all_revive_icons(var0);

  if(isDefined(level.player_bleed_out_func)) {
    var0[[level.player_bleed_out_func]](var0);
    return;
  }

  if(isDefined(level.enterspectatorfunc)) {
    var0[[level.enterspectatorfunc]]();
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
  var0 = newclienthudelem(self);
  var0.x = 0;
  var0.y = 0;
  var0.alignx = "left";
  var0.aligny = "top";
  var0.sort = 1;
  var0.horzalign = "fullscreen";
  var0.vertalign = "fullscreen";
  var0.alpha = 0;
  var0.foreground = 1;
  var0 setshader("white", 640, 480);
  var0 fadeovertime(0.05);
  var0.alpha = 1;
  wait 0.05;
  var0 destroy();
}

function revive_use_hold_think(var0, var1, var2, var3) {
  if(isDefined(var1.vo_prefix)) {
    if(isDefined(level.revive_use_hold_vo_func)) {
      level thread[[level.revive_use_hold_vo_func]](var1, var0);
    }
  }

  var1 setclientomnvar("ui_securing_progress", 0);
  var0 setclientomnvar("ui_securing_progress", 0);
  enter_revive_use_hold_think(var0, var1, var2, var3);
  set_revive_icon_color(var0.reviveent, (0.0117, 0.9882, 0.9882));
  play_revive_gesture(var1, var0);
  var1.validtakeweapon = var1 scripts\cp\utility::getvalidtakeweapon();
  thread wait_for_exit_revive_use_hold_think(var0, var1, var2, var1.validtakeweapon);
  var0.reviver = var1;
  var4 = 0;
  var5 = 0;
  enable_on_world_progress_bar_for_other_players(var0, var1);
  jumpiffalse(isPlayer(var1)) LOC_000000ab;
  var0 notify("reviving");

  while(should_revive_continue(var1)) {
    if(var4 >= var3) {
      var5 = 1;
      break;
    }

    if(distancesquared(var1.origin, var0.origin) > 14400) {
      var5 = 0;
      break;
    }

    var6 = var4 / var3;
    update_players_revive_progress_bar(var0, var1, var6);
    var4 += 50;
    waitframe();
  }

  disable_on_world_progress_bar_for_other_players(var0, var1);
  var2 notify("use_hold_think_complete");
  var2 waittill("exit_use_hold_think_complete");
  return var5;
}

function play_revive_gesture(var0, var1) {
  if(isDefined(level.nuclear_core_carrier)) {
    if(level.nuclear_core_carrier == var0) {
      return;
    }
  }

  var0 allowmelee(0);
  var0 disableweaponswitch();
  var0 notify("offhand_end");
}

function stop_revive_gesture(var0, var1) {
  if(isDefined(level.nuclear_core_carrier)) {
    if(level.nuclear_core_carrier == var0) {
      return;
    }
  }

  var0 enableweaponswitch();
  var0 allowmelee(1);
}

function get_revive_gesture(var0) {
  return "ges_revive_ally";
}

function update_players_revive_progress_bar(var0, var1, var2) {
  foreach(var4 in level.players) {
    if(var4 == var0 || var4 == var1) {
      var4 setclientomnvar("ui_securing_progress", var2);
      continue;
    }

    var4 setclientomnvar("zm_revive_bar_" + var0.revive_progress_bar_id + "_progress", var2);
  }
}

function enter_revive_use_hold_think(var0, var1, var2, var3) {
  var1 setclientomnvar("ui_securing_progress", 0);
  var0 setclientomnvar("ui_securing_progress", 0);
  var0 setclientomnvar("ui_reviver_id", var1 getentitynumber());
  var0 setclientomnvar("ui_securing", 6);
  var1 setclientomnvar("ui_securing", 5);
  var0.being_revived = 1;

  if(isPlayer(var1)) {
    var1 scripts\cp\cp_powers::power_disablepower();
  }

  var1.isreviving = 1;
}

function wait_for_exit_revive_use_hold_think(var0, var1, var2, var3) {
  scripts\engine\utility::waittill_any_ents(var2, "use_hold_think_complete", var0, "disconnect", var0, "revive_success", var0, "force_bleed_out", var1, "challenge_complete", var0, "death");

  if(var0 scripts\cp_mp\utility\player_utility::_isalive()) {
    var0 setclientomnvar("ui_securing", 0);
    var0 setclientomnvar("ui_reviver_id", -1);
    var0 setclientomnvar("ui_securing_progress", 0);
    thread ref_12c51();
  }

  var1.isreviving = 0;

  if(isPlayer(var1)) {
    var1 setclientomnvar("ui_securing", 0);
    var1 setclientomnvar("ui_securing_progress", 0);
    var1 setclientomnvar("ui_reviver_id", -1);
    var1 scripts\cp\cp_powers::power_enablepower();
    var1 unlink();
    var1 notify("stop_revive");
  }

  var2 notify("exit_use_hold_think_complete");
}

function ref_12c51() {
  self endon("disconnect");
  wait 1.6;
  self.being_revived = 0;
}

function play_rescue_anim(var0) {
  var0 endon("disconnect");
  var0 endon("stop_playing_revive_anim");
  var0 playanimscriptevent("power_active_cp", "gesture015");
}

function should_revive_continue(var0) {
  if(istrue(var0.can_revive)) {
    return true;
  }

  return !level.gameended && var0 scripts\cp_mp\utility\player_utility::_isalive() && var0 useButtonPressed() && !player_in_laststand(var0);
}

function should_execute_continue(var0) {
  return !level.gameended && var0 scripts\cp_mp\utility\player_utility::_isalive() && var0 useButtonPressed() && !player_in_laststand(var0);
}

function _takeweaponsexceptlist(var0) {
  var1 = self getweaponslistall();

  foreach(var3 in var1) {
    if(scripts\engine\utility::array_contains(var0, var3)) {
      continue;
    }

    self takeweapon(var3);
  }
}

function is_killed_by_kill_trigger(var0) {
  return isDefined(var0);
}

function set_last_stand_count(var0, var1) {
  var1 = int(var1);
  var0 setplayerdata("cp", "alienSession", "last_stand_count", var1);
}

function set_last_stand_timer(var0, var1) {
  if(isDefined(var1)) {
    var0 setclientomnvar("zm_ui_laststand_end_milliseconds", gettime() + var1 * 1000);
    return;
  }
}

function clear_last_stand_timer(var0) {
  var0 setclientomnvar("zm_ui_laststand_end_milliseconds", 0);
}

function instant_revive(var0) {
  if(is_being_revived(var0)) {
    return;
  }

  var0.trackriotshield_trydetach = 1;
  var0 notify("revive_success");

  if(isDefined(var0.reviveent)) {
    var0.reviveent notify("revive_success");
  }

  if(is_being_revived(var0)) {
    disable_on_world_progress_bar_for_other_players(var0, var0.reviver);
  }

  clear_last_stand_timer(var0);
}

function set_revive_time(var0, var1, var2) {
  if(isDefined(var0)) {
    level.normal_revive_time = var0;
  }

  if(isDefined(var1)) {
    level.spectator_revive_time = var1;
  }

  level.perks_suppressasserts = var2;
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

function get_currency_penalty_amount(var0) {
  if(isDefined(level.laststand_currency_penalty_amount_func)) {
    return [[level.laststand_currency_penalty_amount_func]](var0);
  }

  return 500;
}

function makereviveicon(var0, var1, var2, var3) {
  setup_revive_icon_ent(var0);
  var0.current_revive_icon_color = var2;
  thread reviveiconentcleanup(var0);
  var4 = undefined;

  foreach(var6 in level.players) {
    if(isDefined(level.should_show_revive_icon_to_player_func) && ![[level.should_show_revive_icon_to_player_func]](var6, var1)) {
      continue;
    }

    var4 = show_revive_icon_to_player(var0, var6);
    add_to_revive_icon_ent_icon_list(var0, var4);
    LOC_00000075:
  }

  return var4;
}

function show_revive_icon_to_player(var0, var1) {
  var2 = newclienthudelem(var1);
  var2 setshader("waypoint_cp_revive", 8, 8);
  var2 setwaypoint(1, 1);
  var2 settargetEnt(var0);
  var2.alpha = get_revive_icon_initial_alpha(var1);
  var2.color = var0.current_revive_icon_color;
  add_to_player_revive_icon_list(var1, var2);
  thread reviveiconcleanup(var2, var0);
  return var2;
}

function reviveiconentcleanup(var0) {
  var0 waittill("death");
  remove_from_revive_icon_entity_list(var0);
}

function reviveiconcleanup(var0, var1) {
  scripts\engine\utility::waittill_any_ents_return(var0, "death", var1, "disconnect");
  remove_from_owner_revive_icon_list(self, var1);

  if(isDefined(self)) {
    self destroy();
    return;
  }
}

function set_revive_icon_color(var0, var1) {
  var0.current_revive_icon_color = var1;
  var0.revive_icons = scripts\engine\utility::array_removeundefined(var0.revive_icons);

  foreach(var3 in var0.revive_icons) {
    var3.color = var1;
  }
}

function init_laststand() {
  level.revive_icon_entities = [];
  level.players_being_revived = [];
  thread revive_icon_player_connect_monitor();
}

function add_to_revive_icon_entity_list(var0) {
  level.revive_icon_entities[level.revive_icon_entities.size] = var0;
}

function remove_from_revive_icon_entity_list(var0) {
  level.revive_icon_entities = scripts\engine\utility::array_remove(level.revive_icon_entities, var0);
  level.revive_icon_entities = scripts\engine\utility::array_removeundefined(level.revive_icon_entities);
}

function revive_icon_player_connect_monitor() {
  level endon("game_ended");
  jumpiffalse(istrue(level.disable_revive_icon_hotjoin_monitor)) LOC_00000012;
  return;
}

function setup_revive_icon_ent(var0) {
  var0.revive_icons = [];
  add_to_revive_icon_entity_list(var0);
}

function add_to_revive_icon_ent_icon_list(var0, var1) {
  var0.revive_icons[var0.revive_icons.size] = var1;
}

function init_revive_icon_list(var0) {
  var0.revive_icons = [];
}

function add_to_player_revive_icon_list(var0, var1) {
  var0.revive_icons[var0.revive_icons.size] = var1;
}

function remove_from_player_revive_icon_list(var0, var1) {
  var0.revive_icons = scripts\engine\utility::array_remove(var0.revive_icons, var1);
}

function get_revive_icon_initial_alpha(var0) {
  if(isDefined(var0.last_stand_state) && var0.last_stand_state == "bleed_out") {
    return 0;
  }

  return 1;
}

function show_all_revive_icons(var0) {
  foreach(var2 in var0.revive_icons) {
    var2.alpha = 1;
  }
}

function hide_all_revive_icons(var0) {
  foreach(var2 in var0.revive_icons) {
    var2.alpha = 0;
  }
}

function enable_on_world_progress_bar_for_other_players(var0, var1) {
  var2 = add_to_players_being_revived(var0);
  var3 = "zm_revive_bar_" + var2 + "_target";

  foreach(var5 in level.players) {
    if(var5 == var0 || var5 == var1) {
      continue;
    }

    var5 setclientomnvar(var3, var0);
  }
}

function disable_on_world_progress_bar_for_other_players(var0, var1) {
  var2 = "zm_revive_bar_" + var0.revive_progress_bar_id + "_target";
  remove_from_players_being_revived(var0);

  foreach(var4 in level.players) {
    if(var4 == var0 || var4 == var1) {
      continue;
    }

    var4 setclientomnvar(var2, undefined);
  }
}

function self_revive_activated() {
  return isDefined(self.self_revive) && self.self_revive > 0;
}

function add_to_players_being_revived(var0) {
  var1 = 0;

  while(var1 < 2) {
    if(!isDefined(level.players_being_revived[var1])) {
      level.players_being_revived[var1] = var0;
      var2 = var1 + 1;
      var0.revive_progress_bar_id = var2;
      return var2;
    }

    var2++;
  }
}

function remove_from_players_being_revived(var0) {
  for(var1 = 0; var1 < 2; var1++) {
    if(isDefined(level.players_being_revived[var1]) && level.players_being_revived[var1] == var0) {
      level.players_being_revived[var1] = undefined;
      var0.revive_progress_bar_id = undefined;
      return;
    }
  }
}

function shouldgodirectlytospectate(var0) {
  if(getdvarint("scr_force_bleedout", 0) != 0) {
    return 1;
  }

  if(isDefined(level.shouldgodirectlytospectatefunc)) {
    return [[level.shouldgodirectlytospectatefunc]](var0);
  }

  if(istrue(var0.bhitbyvehicle)) {
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

function is_being_revived(var0) {
  return istrue(var0.being_revived);
}

function player_in_laststand(var0) {
  return var0.inlaststand;
}

function enable_self_revive(var0) {
  if(!isDefined(var0.self_revive)) {
    var0.self_revive = 0;
  }

  var0.self_revive++;
}

function disable_self_revive(var0) {
  var0.self_revive--;
}

function self_revive(var0) {
  putonground(var0);
  var1 = 3;

  if(isDefined(level.self_revive_wait_override)) {
    var1 = level.self_revive_wait_override;
  }

  if(isDefined(var0.self_revive_wait_override)) {
    var1 = var0.self_revive_wait_override;
  }

  var0 scripts\engine\utility::ref_143b9(var1, "revive_success");
  return true;
}

function give_fists_if_no_real_weapon(var0) {
  if(has_no_real_weapon(var0)) {
    self giveweapon("iw8_fists_mp");
    self switchtoweaponimmediate("iw8_fists_mp");
    self setspawnweapon("iw8_fists_mp", 1);
    return;
  }
}

function has_no_real_weapon(var0) {
  var1 = var0 getweaponslistall();

  foreach(var3 in var1) {
    var4 = var3.basename;

    if(var4 == "super_default_zm") {
      continue;
    }

    if(issubstr(var4, "knife")) {
      continue;
    }

    if(var4 == "iw8_fists_mp") {
      continue;
    }

    return false;
  }

  return true;
}

function npc_revive_available() {
  return istrue(level.the_hoff_revive);
}

function give_up_loop(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11) {
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
    var0 = scripts\engine\utility::ref_143ba(0.3, "give_up_requested", "release_requested");

    if(isDefined(var0) && var0 == "timeout") {
      self.give_up_counter--;

      if(self.give_up_counter <= 0) {
        self.give_up_counter = 0;
      }

      continue;
    }

    if(isDefined(var0) && var0 == "give_up_requested") {
      self.give_up_requested = 0;
    } else {
      self.give_up_requested = 1;
    }

    self notify("give_up_state_changed");
  }
}

function get_rumble_ent(var0) {
  var1 = scripts\cp\utility::get_player_from_self();

  if(!isDefined(var0)) {
    var0 = "steady_rumble";
  }

  var2 = spawn("script_origin", var1 getEye());
  var2.intensity = 1;
  thread update_rumble_intensity(var2, var1);
  return var2;
}

function set_rumble_intensity(var0) {
  self.intensity = var0;
}

function rumble_ramp_on(var0) {
  thread rumble_ramp_to(1, var0);
}

function rumble_ramp_off(var0) {
  thread rumble_ramp_to(0, var0);
}

function rumble_ramp_to(var0, var1) {
  self notify("new_ramp");
  self endon("new_ramp");
  self endon("death");
  var2 = var1 * 20;
  var3 = var0 - self.intensity;
  var4 = var3 / var2;

  for(var5 = 0; var5 < var2; var5++) {
    self.intensity += var4;
    wait 0.05;
  }

  self.intensity = var0;
}

function update_rumble_intensity(var0, var1) {
  self endon("death");
  self endon("give_up_done");
  var2 = 0;

  for(;;) {
    if(self.intensity > 0.0001 && gettime() > 300) {
      if(!var2) {
        self playrumblelooponentity(var1);
        var2 = 1;
      }
    } else if(var2) {
      self stoprumble(var1);
      var2 = 0;
    }

    var3 = 1 - self.intensity;
    var3 *= 1000;
    self.origin = var0 getEye() + (0, 0, var3);
    wait 0.05;
  }
}

function give_up_push_anim(var0) {
  var1 = var0 getEye();
  var2 = var0 getplayerangles();
  var3 = anglesToForward(var2);
  var4 = anglestoright(var2);
  var5 = anglestoup(var2) * -1;
  var6 = var1 + var3 * 17 + var4 * 3 + var5 * 0.16;

  if(!isDefined(var0.give_up_asset)) {
    var7 = spawn("script_model", var6);
    var7 setModel("weapon_vm_me_soscar_knife");
    var8 = (var2[0], var2[1], var2[2] + 90);
    var7.angles = var8;
    var7 linkTo(var0);
    var0.give_up_asset = var7;
    return;
  }

  var0.give_up_asset moveTo(var6, 5);
}

function give_up_release_anim(var0) {
  var1 = var0 getEye();
  var2 = var0 getplayerangles();
  var3 = anglesToForward(var2);
  var4 = anglestoright(var2);
  var5 = anglestoup(var2) * -1;
  var6 = var1 + var3 * 17 + var4 * -3 + var5 * 0.16;

  if(!isDefined(var0.give_up_asset)) {
    var7 = spawn("script_model", var6);
    var7 setModel("weapon_vm_me_soscar_knife");
    var8 = (var2[0], var2[1], var2[2] + 90);
    var7.angles = var8;
    var7 linkTo(var0);
    var0.give_up_asset = var7;
    return;
  }

  var0.give_up_asset moveTo(var6, 5);
}

function give_up_easy_setup(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11) {
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
  var12 = 0;
  level.timer_override = 0;
  var13 = var5;

  for(;;) {
    waitframe();

    if(istrue(level.timer_override)) {
      break;
    }

    if(is_being_revived(var0)) {
      continue;
    }

    if(self isspectatingplayer()) {
      return;
    }

    if(self useButtonPressed()) {
      var12 += level.framedurationseconds;

      if(var12 >= 0.3 || istrue(level.timer_override)) {
        break;
      }
    } else {
      var12 = 0;
    }

    self setclientomnvar("zm_hint_progress", var12 / 0.3);
  }

  self notify("give_up_done");
  var0 notify("force_bleed_out");

  if(scripts\cp\utility::isplayingsolo()) {
    return 1;
  }

  return 0;
}

function show_give_up_hint() {
  thread scripts\cp\utility::hint_prompt("give_up", 1);
  var0 = scripts\engine\utility::waittill_any_ents_return(self, "death_or_disconnect", self, "give_up_done", level, "game_ended", self, "revive_success", self, "timeout", self, "returned");

  if(isDefined(var0) && (var0 == "revive_success" || var0 == "returned" || var0 == "timeout")) {
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

function ref_12d18(var0) {
  var0 playsoundonmovingent("cp_foley_revive_wounded_down");
}

function ref_12d19(var0) {
  var0 playsoundonmovingent("cp_last_stand_revive_out_wounded");
}

function ref_12d1a(var0) {
  var0 playsoundonmovingent("cp_foley_revive_wounded_recover_standing");
}

function play_laststand_scripted_anim(var0, var1) {
  var0 endon("revive_done");
  var1 endon("revive_done");
  var2 = get_closest_ls_entrance(var0, var1);

  if(!isDefined(var2)) {
    var3 = level.scr_anim["ls_revive_helper"]["in_6"];
    var2 = spawnStruct();
    var2.origin = getstartorigin(var1.origin, var1.angles, var3);
    var2.angles = getstartangles(var1.origin, var1.angles, var3);
    var2.xanim_name = "6";
    var2.xanim_string = level.scr_animname["ls_revive_helper"]["in_6"];
  }

  thread delay_orbit_cam(var0);
  thread delay_orbit_cam(var1);
  var4 = scripts\cp_mp\anim_scene::anim_scene_create_actor(var0, "ls_revive_helper", 1, 0, 1);
  var5 = scripts\cp_mp\anim_scene::anim_scene_create_actor(var1, "ls_revive_wounded", 1, 0, 1);
  var6 = spawnStruct();
  var6.origin = var1.origin;
  var6.angles = var1.angles;
  var1.scenenode = var6;
  var0.ref_12d13 = var0.origin;
  var7 = "idle_4";
  var8 = "out_4";

  if(issubstr(var2.xanim_string, "_R")) {
    var7 = "idle_6";
    var8 = "out_6";
  }

  thread handle_stim(var0, var6);

  if(istrue(var0.isjuggernaut)) {
    var6 scripts\cp_mp\anim_scene::anim_scene([var4, var5], "in_" + var2.xanim_name, 1, 0, undefined, undefined, undefined, 1);
  } else {
    var6 scripts\cp_mp\anim_scene::anim_scene([var4, var5], "in_" + var2.xanim_name, 1, 0);
  }

  if(!istrue(var0.class == "medic")) {
    if(istrue(var0.isjuggernaut)) {
      var6 scripts\cp_mp\anim_scene::anim_scene([var4, var5], var7, 0, 0, undefined, undefined, undefined, 1);
    } else {
      var6 scripts\cp_mp\anim_scene::anim_scene([var4, var5], var7, 0, 0);
    }
  }

  if(istrue(var0.isjuggernaut)) {
    var6 scripts\cp_mp\anim_scene::anim_scene([var4, var5], var8, 0, 1, undefined, undefined, undefined, 1);
  } else {
    var6 scripts\cp_mp\anim_scene::anim_scene([var4, var5], var8, 0, 1);
  }

  var1 setOrigin(var6.origin);
}

function handle_stim(var0, var1) {
  var2 = spawn("script_model", self gettagorigin("tag_accessory_right"));
  var2.angles = self gettagangles("tag_accessory_right");
  var2 setModel("offhand_wm_stim");
  var2 linkTo(self, "tag_accessory_right", (0, 0, 0), (0, 0, 0));
  scripts\engine\utility::ref_143a7("revive_done", "revive_teammate", "disconnect", "last_stand");

  if(scripts\cp\utility::is_valid_player(1)) {
    var3 = var0.origin + (0, 0, 20);
    var4 = physics_createcontents(["physicscontents_solid", "physicscontents_vehicleclip", "physicscontents_item", "physicscontents_ainoshoot"]);
    var5 = physics_raycast(var3, self.origin + (0, 0, 20), var4, [self, var1], 1, "physicsquery_closest", 1);

    if(isDefined(var5) && var5.size > 0) {
      self setOrigin(self.ref_12d13);
    }
  }

  var2 delete();
}

function get_closest_ls_entrance(var0) {
  var1 = ["1", "2l", "2r", "3", "4", "6", "7", "8l", "8r", "9r"];
  var2 = [];

  for(var3 = 0; var3 < var1.size; var3++) {
    var4 = get_ls_entrance(var0, var1[var3]);

    if(isDefined(var4)) {
      var2 = var4;
    }
  }

  return scripts\engine\utility::getclosest(self.origin, var2);
}

function get_ls_entrance(var0, var1) {
  var2 = level.scr_anim["ls_revive_helper"]["in_" + var1];
  var3 = spawnStruct();
  var3.origin = getstartorigin(var0.origin, var0.angles, var2);
  var3.angles = getstartangles(var0.origin, var0.angles, var2);
  var3.xanim_name = var1;
  var3.xanim_string = level.scr_animname["ls_revive_helper"]["in_" + var1];
  var4 = self.origin + (0, 0, 20);
  var5 = physics_createcontents(["physicscontents_solid", "physicscontents_vehicleclip", "physicscontents_item", "physicscontents_ainoshoot"]);

  if(!scripts\engine\trace::player_trace_passed(var4, var3.origin + (0, 0, 20), self.angles, [self, var0])) {
    return undefined;
  }

  return var3;
}