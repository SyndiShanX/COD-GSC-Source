/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\helicopter\utility.gsc
***********************************************/

callback_defaultplayerlaststand(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(isDefined(var_1)) {
    if(isPlayer(var_1) || isagent(var_1))
      self.last_damaged_by = var_1;
  }

  if(scripts\cp_mp\utility\player_utility::isinvehicle())
    self.bhitbyvehicle = undefined;

  if(isDefined(level.last_stand_hud_update))
    self[[level.last_stand_hud_update]]();

  var_10 = scripts\cp\cp_endgame::get_current_zone(self);
  var_11 = 1;
  scripts\cp\cp_analytics::_id_119B2(self, var_1);
  default_playerlaststand(var_9, var_1);
  return 1;
}

default_playerlaststand(var_0, var_1) {
  var_2 = gameshouldend(self);

  if(var_2 && isDefined(level.endgame) && isDefined(level.end_game_string_index))
    level thread[[level.endgame]]("_encstr_8E8405EA382B2A", level.end_game_string_index["_encstr_BA19049B7723"]);

  thread completepayloadexfilobjective();
  thread dropintolaststand(var_0, var_2, var_1);
}

completepayloadexfilobjective() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 = newclienthudelem(self);
  var_0.sort = 0;
  var_0.x = 0;
  var_0.y = 0;
  var_0.alignx = "_encstr_A5AD056A019C63";
  var_0.aligny = "_encstr_AC190479FF92";
  var_0.foreground = 0;
  var_0.horzalign = "_encstr_9A940B9FAB606CCB46157F7705";
  var_0.vertalign = "_encstr_9A940B9FAB606CCB46157F7705";
  var_0.alpha = 0.5;
  var_0.enablehudlighting = 1;
  var_0.lowresbackground = 1;
  var_0 setshader("_encstr_AD7F285796EBC1630B2F569CBE38C2A537AF23AC0B4743DC23DEEDC9F583BAB1E62BBE7BB32B4E632CBC", 640, 480);
  var_0 fadeovertime(20);
  var_0.alpha = 1.25;
  self shellshock("_encstr_822D103D758B39F30563D140CA9A8FF3D31C", 2.0);
  var_1 = scripts\engine\utility::waittill_notify_or_timeout_return("_encstr_9695073995D94BD959", 20);

  if(var_1 == "_encstr_995408F398012F656821") {
    self playlocalsound("_encstr_AA6A0F3B8081C4325F10DF1560051991C8");
    scripts\common\utility::allow_weapon(0);
    scripts\common\utility::allow_melee(0);
    self shellshock("_encstr_822D103D758B39F30563D140CA9A8FF3D31C", 4.0);
    self waittill("_encstr_9695073995D94BD959");
    scripts\common\utility::allow_weapon(1);
    scripts\common\utility::allow_melee(1);
  }

  var_2 = 1.0;
  var_0 fadeovertime(var_2);
  var_0.alpha = 0.0;
  wait(var_2);
  var_0 destroy();
}

completeobjstr() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_9695073995D94BD959");
  var_0 = 0.85;
  var_1 = 0.95;

  for(;;) {
    self playlocalsound("_encstr_BEDA14BE1EE33A443870FBD7A9500D6265B506F70F39");
    var_2 = randomfloatrange(var_0, var_1);
    wait(var_2);
  }
}

forcebleedout(var_0) {
  if(scripts\cp\utility::isplayingsolo() || level.only_one_player)
    self setOrigin(var_0.origin);

  self.bleedoutspawnentityoverride = var_0;
  self notify("_encstr_966410CE10EB2FC727804AD250B9B1E7E305");
}

dropintolaststand(var_0, var_1, var_2) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self notify("_encstr_8CBE0BD1BED30936AB03C0B02B");
  self notify("_encstr_8FE01132F817F3978BE5B9BEF5567FBB5B183B");
  var_3 = gettime() + 3000;
  var_4 = scripts\cp\utility::has_auto_revive();
  enter_gamemodespecificaction(var_2);
  enter_globaldefaultaction();
  enter_laststand();

  if((scripts\cp\utility::isplayingsolo() || level.only_one_player) && haveselfrevive())
    waitinlaststand(var_0, var_1, var_4);
  else if(shouldgodirectlytospectate(self))
    waitinspectator(var_0, var_1);
  else if(maydolaststand(var_1, var_0)) {
    var_5 = waitinlaststand(var_0, var_1);

    if(istrue(self.trackriotshield_trydetach))
      var_5 = 1;

    if(!var_5)
      waitinspectator(var_0, var_1);
  } else
    waitinspectator(var_0, var_1);

  var_6 = (var_3 - gettime()) / 1000;

  if(var_6 > 0)
    wait(var_6);

  self notify("_encstr_9695073995D94BD959");
  level notify("_encstr_99E70F8E496BBA33A51FAE55ABF8FAAB23", self);
  self.trackriotshield_trydetach = 0;
  exit_laststand();
  exit_globaldefaultaction();
  exit_gamemodespecificaction();
  var_7 = scripts\cp\cp_outofbounds::getlastoobtrigger(self);

  if(isDefined(var_7) && isDefined(var_7.entstouching[self getentitynumber()])) {
    var_7.entstouching[self getentitynumber()] = undefined;
    scripts\cp\cp_outofbounds::clearoob(self, 0);
  }
}

setupcellspawn() {
  self.watch_for_long_death = createnavobstaclebyent(self);
  thread _id_11DAA();
  scripts\engine\utility::_id_143A9("_encstr_AD75063D571AE108", "_encstr_8D820B49520F0EC02DDE6367EC", "_encstr_9695073995D94BD959", "_encstr_9B1D0BC7932875276230426AA1", "_encstr_91BB10B2F05AD1AFC658B9D1D7E6E8C2CD32", "_encstr_AAED1130FA03EB6BBF54988638C731812EC3B8");
  destroynavobstacle(self.watch_for_long_death);
}

_id_11DAA() {
  self.watch_for_maze_ai_events = self.origin;
  var_0 = 2500;

  while(isDefined(self.last_stand_state) && self.last_stand_state == "_encstr_8CBE0BD1BED30936AB03C0B02B") {
    if(distancesquared(self.watch_for_maze_ai_events, self.origin) > var_0) {
      destroynavobstacle(self.watch_for_long_death);
      self.watch_for_long_death = createnavobstaclebyent(self);
      self.watch_for_maze_ai_events = self.origin;
    }

    wait 0.2;
  }
}

enter_laststand() {
  self.last_stand_state = "_encstr_8CBE0BD1BED30936AB03C0B02B";
  self.inlaststand = 1;
  self._id_140AE = undefined;
  self.health = 1;
  scripts\common\utility::allow_usability(0);
  scripts\cp\utility::allow_player_ignore_me(1);
  self notify("_encstr_AA7D13C37B919B5363C2E994D398B2CB9A93219A3B");
  thread setupcellspawn();
}

exit_laststand() {
  self notify("_encstr_91BB10B2F05AD1AFC658B9D1D7E6E8C2CD32");
  self laststandrevive();
  self setstance("_encstr_A5AD069B231F0BAF");
  self.inlaststand = 0;
  self.last_stand_state = undefined;
  self.health = gethealthcap();
  scripts\engine\utility::delaythread(3, scripts\cp\utility::force_usability_enabled);
  thread wasinlaststand();
  thread scripts\cp\utility::hint_prompt("_encstr_A2BA0EB6C237BA2C1BD79CAC3B96D9AC", 0);

  if(isDefined(level.revived_hud_update))
    self[[level.revived_hud_update]]();

  set_cam();
  self.last_damaged_by = undefined;
}

wasinlaststand() {
  var_0 = scripts\cp\cp_outofbounds::getlastoobtrigger(self);

  if(isDefined(var_0) && isDefined(var_0.entstouching[self getentitynumber()])) {
    scripts\cp\utility::allow_player_ignore_me(0);
    return;
  }

  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self.ability_invulnerable = 1;
  wait 5;
  scripts\cp\utility::allow_player_ignore_me(0);
  self.ability_invulnerable = undefined;
}

set_cam(var_0) {
  if(!isDefined(var_0))
    self cameradefault();
  else
    self cameraset(var_0);
}

delay_orbit_cam(var_0) {
  self endon("_encstr_86660C9CCAEC969DACF58C7BCDB2");
  wait(var_0);
  set_cam("_encstr_ADF219108F65A9E5EA215E5D02931710EF1F9390D714A65DD1D6CF");
}

gethealthcap() {
  if(isDefined(level.get_player_health_after_revived_func))
    return [[level.get_player_health_after_revived_func]](self);

  return int(self.maxhealth);
}

enter_globaldefaultaction() {
  if(!scripts\cp\utility::_hasperk("_encstr_95AA16DC1C95C62D0BC6E8E5EB832DB9A37BB13259164743"))
    scripts\cp\utility::giveperk("_encstr_95AA16DC1C95C62D0BC6E8E5EB832DB9A37BB13259164743");

  scripts\cp\cp_gamescore::update_team_encounter_performance(scripts\cp\cp_gamescore::get_team_score_component_name(), "_encstr_859A1C125B4187E260CB697DC5B0E1D778D33A5B66A9371A78177C41E570");
  var_0 = [getcompleteweaponname("_encstr_9A0D0C4B54606F8F63C84B8B53EE")];

  if(isDefined(level.additional_laststand_weapon_exclusion))
    var_0 = scripts\engine\utility::array_combine(var_0, level.additional_laststand_weapon_exclusion);

  if(isDefined(self.former_mule_weapon))
    var_0[var_0.size] = self.former_mule_weapon;

  var_1 = [];

  foreach(var_3 in self getweaponslistprimaries()) {
    if(var_3.isalternate) {
      continue;
    }
    var_1[var_1.size] = var_3;
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

  if(isDefined(var_5.loadoutaccessorydata) && isDefined(var_5.loadoutaccessoryweapon) && var_5.loadoutaccessoryweapon != "_encstr_8BBA05185F8B99")
    var_5 scripts\cp\cp_accessories::giveplayeraccessory(var_5.loadoutaccessorydata, var_5.loadoutaccessoryweapon, var_5.loadoutaccessorylogic);

  scripts\cp\cp_persistence::increment_player_career_downs(self);
  scripts\cp\cp_analytics::inc_downed_counts();
  scripts\cp\cp_globallogic::broadcast_status(self, 1);
  self stopgestureviewmodel();
  self stopanimscriptsceneevent();

  if(self isviewmodelanimplaying())
    self stopviewmodelanim();
}

check_for_invalid_attachments() {
  if(!isDefined(self.copy_fullweaponlist)) {
    return;
  }
  if(scripts\cp\utility::is_consumable_active("_encstr_8E7D134D5DDCE8BEB07D33B1AC9B0DEBBBF6AE3723")) {
    return;
  }
  var_0 = undefined;

  if(isDefined(self.lastweapon) && !scripts\engine\utility::array_contains(self.copy_fullweaponlist, self.lastweapon))
    self.copy_fullweaponlist = scripts\engine\utility::array_add(self.copy_fullweaponlist, self.lastweapon);

  foreach(var_2 in self.copy_fullweaponlist) {
    if(var_2 hasattachment("_encstr_92B50AC8BDABC4D8AC8E580E", 1)) {
      var_0 = var_2 withoutattachment("_encstr_92B50AC8BDABC4D8AC8E580E");
      var_3 = createheadicon(var_0);

      if(scripts\engine\utility::array_contains(self.copy_fullweaponlist, var_2)) {
        self.copy_fullweaponlist = scripts\engine\utility::array_remove(self.copy_fullweaponlist, var_2);
        self.copy_fullweaponlist[self.copy_fullweaponlist.size] = var_0;
      }

      if(issubstr(self.copy_weapon_current.basename, var_2.basename))
        self.copy_weapon_current = var_0;

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

      if(issubstr(self.lastweapon.basename, var_2.basename))
        self.lastweapon = var_0;

      if(issubstr(self.pre_laststand_weapon.basename, var_2.basename))
        self.pre_laststand_weapon = var_0;
    }
  }
}

enter_globaldefaultaction_getcurrentweapon(var_0, var_1) {
  var_2 = scripts\cp\utility::getvalidtakeweapon(var_0);

  if(isDefined(self.pre_arcade_game_weapon))
    var_2 = self.pre_arcade_game_weapon;

  var_3 = 0;

  if(nullweapon(var_2))
    var_3 = 1;
  else if(scripts\engine\utility::array_contains(var_0, var_2))
    var_3 = 1;
  else if(scripts\engine\utility::array_contains(var_0, var_2 getbaseweapon()))
    var_3 = 1;
  else if(istrue(var_1) && scripts\cp\utility::is_melee_weapon(var_2, 1))
    var_3 = 1;

  if(scripts\cp\utility::is_primary_melee_weapon(var_2))
    var_3 = 0;

  if(var_3)
    return choose_last_weapon(var_0, var_1, 1);
  else
    return var_2;
}

choose_last_weapon(var_0, var_1, var_2) {
  for(var_3 = 0; var_3 < self.copy_fullweaponlist.size; var_3++) {
    if(nullweapon(self.copy_fullweaponlist[var_3]))
      continue;
    else if(scripts\engine\utility::array_contains(var_0, self.copy_fullweaponlist[var_3]))
      continue;
    else if(scripts\engine\utility::array_contains(var_0, self.copy_fullweaponlist[var_3] getbaseweapon()))
      continue;
    else if(istrue(var_1) && scripts\cp\utility::is_melee_weapon(self.copy_fullweaponlist[var_3], var_2))
      continue;
    else
      return self.copy_fullweaponlist[var_3];
  }
}

exit_globaldefaultaction() {
  self.bhitbyvehicle = undefined;
  self.haveinvulnerabilityavailable = 1;
  self.damageshieldexpiretime = gettime() + 3000;
  var_0 = [];
  scripts\cp\utility::restore_weapons_status(var_0);

  if(isDefined(self.pre_laststand_weapon_stock))
    self setweaponammostock(self.pre_laststand_weapon, self.pre_laststand_weapon_stock);

  if(isDefined(self.pre_laststand_weapon_ammo_clip))
    self setweaponammoclip(self.pre_laststand_weapon, self.pre_laststand_weapon_ammo_clip);

  self setspawnweapon(self.lastweapon, 1);
  give_fists_if_no_real_weapon(self);
  var_1 = self;
  var_1.loadoutaccessoryweapon = var_1 scripts\cp\cp_loadout::cac_getaccessoryweapon();
  var_1.loadoutaccessorydata = var_1 scripts\cp\cp_loadout::cac_getaccessorydata();
  var_1.loadoutaccessorylogic = var_1 scripts\cp\cp_loadout::force_interrupt_all_current_combat_actions();

  if(isDefined(var_1.loadoutaccessorydata) && isDefined(var_1.loadoutaccessoryweapon) && var_1.loadoutaccessoryweapon != "_encstr_8BBA05185F8B99")
    var_1 scripts\cp\cp_accessories::giveplayeraccessory(var_1.loadoutaccessorydata, var_1.loadoutaccessoryweapon, var_1.loadoutaccessorylogic);

  scripts\cp\cp_globallogic::broadcast_status(self, 0);
  self.bleedoutspawnentityoverride = undefined;
  scripts\cp\cp_analytics::inc_revived_counts();
  scripts\cp\cp_damage::set_kill_trigger_event_processed(self, 0);
  updatemovespeedscale();
  scripts\cp\cp_globallogic::updatematchhasmorethan1playeromnvaronplayersfirstspawn();
}

enter_gamemodespecificaction(var_0) {
  if(isDefined(level.laststand_enter_gamemodespecificaction))
    [[level.laststand_enter_gamemodespecificaction]](self, var_0);

  if(isDefined(level.laststand_enter_levelspecificaction))
    [[level.laststand_enter_levelspecificaction]](self);
}

exit_gamemodespecificaction() {
  if(isDefined(level.laststand_exit_gamemodespecificaction))
    [[level.laststand_exit_gamemodespecificaction]](self);
}

waitinlaststand(var_0, var_1, var_2) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_9695073995D94BD959");
  self endon("_encstr_99E70F8E496BBA33A51FAE55ABF8FAAB23");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(self_revive_activated())
    return self_revive(self);

  var_3 = undefined;
  var_4 = 3;

  if(isDefined(level.self_revive_wait_override))
    var_4 = level.self_revive_wait_override;

  if(scripts\cp\utility::has_auto_revive() && !npc_revive_available()) {
    wait(var_4);
    self setclientomnvar("_encstr_8C910F25C4697F39FC1379E8E71E70BD12", 0);
    return 1;
  }

  if(!var_1) {
    thread playdeathsoundinlaststand(var_3);

    if(scripts\cp\utility::isplayingsolo() || level.only_one_player) {
      take_laststand(self, 1);

      if(npc_revive_available())
        set_last_stand_timer(self, 35);
      else
        set_last_stand_timer(self, 5);
    } else
      set_last_stand_timer(self, var_3);
  }

  foreach(var_6 in level.players) {
    if(var_6 != self)
      var_6 thread scripts\cp\cp_hud_message::showsplash("_encstr_826910639FF7E8B621E591CF9B1FCBB1CDB4", undefined, self);
  }

  if(scripts\cp\utility::isplayingsolo() || level.only_one_player && !npc_revive_available())
    return wait_for_self_revive(var_0, var_1);
  else
    return wait_to_be_revived(self, self.origin, undefined, undefined, 1, get_normal_revive_time(), (0.33, 0.75, 0.24), var_3, 0, var_1, 1, var_2);
}

getbleedouttime() {
  if(isDefined(level.get_bleed_out_time))
    return [[level.get_bleed_out_time]]();

  return 35;
}

waitinspectator(var_0, var_1) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  wait 0.5;
  scripts\cp\cp_globallogic::updatematchhasmorethan1playeromnvaronplayerdisconnect();
  self notify("_encstr_AD75063D571AE108");
  self setclientomnvar("_encstr_A1A21B281251572343C72894EF33283B45AA60F12AF5AB98BBE42014A6", 0);
  waitframe();
  scripts\cp\cp_globallogic::broadcast_status(self, 2);
  record_bleedout(var_0);

  if(isDefined(self.bleedoutspawnentityoverride)) {
    var_0 = self.bleedoutspawnentityoverride;
    self.bleedoutspawnentityoverride = undefined;
  }

  if(is_killed_by_kill_trigger(var_0)) {
    var_2 = self;

    if(isDefined(var_0))
      var_2 = var_0;

    var_3 = scripts\engine\utility::drop_to_ground(var_2.origin, 32, -64) + (0, 0, 5);
    var_4 = var_2.angles;
  } else {
    var_3 = self.origin;
    var_4 = self.angles;
  }

  clear_last_stand_timer(self);
  self.spectating = 1;

  if(isDefined(level.respawn_func) && !istrue(level.dogtag_revive) && !scripts\cp\utility::turn_off_sniper_laser()) {
    self.last_stand_state = "_encstr_8FE20AD2903BB77B0E68ADA4";

    if(isDefined(level.automated_respawn_func)) {
      while(!istrue(level.automated_respawn_available))
        wait 1;

      if(!istrue(level.automated_respawn_delay_skip))
        level thread[[level.automated_respawn_func]]();
    }

    if(self[[level.respawn_func]](self, var_3)) {
      show_all_revive_icons(self);
      scripts\cp\cp_globallogic::broadcast_status(self, 0);
      self.spectating = undefined;
      scripts\cp\utility::updatesessionstate("_encstr_877508C1D8C22F2DDC3B");

      if(!isDefined(self.forcespawnorigin) && !isDefined(self.forcespawnangles)) {
        self.forcespawnorigin = var_3;
        self.forcespawnangles = var_4;
      }

      if(isDefined(level.prespawnfromspectaorfunc))
        [[level.prespawnfromspectaorfunc]](self);

      if(istrue(self.playerjailwaitvo)) {
        self.playerjailwaitvo = undefined;
        [[level.spawnplayerfunc]]();
      } else
        [[level.spawnplayerfunc]](1);

      self.shouldskiplaststand = 0;
    } else {}
  } else {
    if(isDefined(level.enter_spectator_func))
      level thread[[level.enter_spectator_func]](self);

    self notify("_encstr_AAED1130FA03EB6BBF54988638C731812EC3B8");

    if(!scripts\cp\utility::turn_off_sniper_laser())
      var_5 = wait_to_be_revived(self, var_3, undefined, undefined, 0, get_spectator_revive_time(), (1, 0, 0), undefined, 1, var_1, 0);
    else {
      thread enter_spectate(self, var_3, undefined);
      self.last_stand_state = "_encstr_8FE20AD2903BB77B0E68ADA4";
      level waittill("_encstr_A6370DE8B4DA597BAEA3F5EE0BCE59");
    }

    show_all_revive_icons(self);
    scripts\cp\cp_globallogic::broadcast_status(self, 0);
    self.spectating = undefined;
    scripts\cp\utility::updatesessionstate("_encstr_877508C1D8C22F2DDC3B");

    if(!isDefined(self.forcespawnorigin) && !isDefined(self.forcespawnangles)) {
      self.forcespawnorigin = var_3;
      self.forcespawnangles = var_4;
    }

    if(isDefined(level.prespawnfromspectaorfunc))
      [[level.prespawnfromspectaorfunc]](self);

    [[level.spawnplayerfunc]]();
    self.shouldskiplaststand = 0;
  }
}

record_bleedout(var_0) {
  scripts\cp\cp_persistence::eog_player_update_stat("_encstr_8E0607055DBFB3919A", 1);

  if(!is_killed_by_kill_trigger(var_0)) {
    scripts\cp\cp_gamescore::update_team_encounter_performance(scripts\cp\cp_gamescore::get_team_score_component_name(), "_encstr_B1DB16B3E3B1F17098D9B0BF9348979A996B0713CFE81B4C");
    scripts\cp\cp_analytics::inc_bleedout_counts();
  }
}

wait_for_self_revive(var_0, var_1) {
  if(var_1) {
    level waittill("_encstr_ABA008615A631510C7EA");
    clear_last_stand_timer(self);
    return 0;
  }

  if(is_killed_by_kill_trigger(var_0))
    self setOrigin(var_0.origin);
  else
    wait 5;

  clear_last_stand_timer(self);
  return 1;
}

wait_to_be_revived(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  var_12 = makereviveentity(var_0, var_1, var_2, var_3, var_4);

  if(var_8) {
    thread enter_spectate(var_0, var_1, var_12);
    var_0.last_stand_state = "_encstr_8FE20AD2903BB77B0E68ADA4";
  } else
    level notify("_encstr_B49925EEC2968ED2CDECEB47EDD731ACFA93B23B2D67B291F5CC93DEADFAB12CE63AB91DB0E623", var_0);

  if(var_9) {
    level waittill("_encstr_ABA008615A631510C7EA");
    return 0;
  } else {
    var_13 = var_12;

    if(var_8)
      var_13 = makereviveiconentity(var_0, var_12);

    if(var_10)
      var_13 scripts\cp\cp_laststand::makereviveicon(var_13, var_0, var_6, var_7);

    var_0.reviveent = var_12;
    var_0.reviveiconent = var_13;

    if(isDefined(level.give_up_func) && (!var_0 isspectatingplayer() || !istrue(var_8)))
      var_0 thread[[level.give_up_func]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);

    if(var_10)
      var_12 thread laststandwaittillrevivebyteammate(var_0, var_5);

    if(istrue(1))
      var_12 thread laststandmoveawayfromvehicles(var_0, var_5);

    if(isDefined(var_7))
      var_14 = var_12 scripts\engine\utility::waittill_any_ents_or_timeout_return(var_7, var_12, "_encstr_99E70F8E496BBA33A51FAE55ABF8FAAB23", var_0, "_encstr_966410CE10EB2FC727804AD250B9B1E7E305", var_0, "_encstr_99E70F8E496BBA33A51FAE55ABF8FAAB23", var_0, "_encstr_910C1AF758764811B7FAF9A1F1775888CAA47341FD51E0ED93A2D3A9");
    else
      var_14 = var_12 scripts\engine\utility::waittill_any_ents_return(var_12, "_encstr_99E70F8E496BBA33A51FAE55ABF8FAAB23", var_0, "_encstr_910C1AF758764811B7FAF9A1F1775888CAA47341FD51E0ED93A2D3A9", var_0, "_encstr_966410CE10EB2FC727804AD250B9B1E7E305");

    if(var_14 == "_encstr_995408F398012F656821" && is_being_revived(var_0))
      var_14 = var_12 scripts\engine\utility::_id_143AD("_encstr_99E70F8E496BBA33A51FAE55ABF8FAAB23", "_encstr_AF770C1AB53B3BCBB7A92B6F41E8");

    if(isDefined(var_0.reviveent))
      var_0.reviveent delete();

    if(isDefined(var_0.reviveiconent))
      var_0.reviveiconent delete();

    var_0 notify("_encstr_BA3A0D5797E3F30765E2418C3F95F8");

    if(var_14 == "_encstr_99E70F8E496BBA33A51FAE55ABF8FAAB23" || var_14 == "_encstr_910C1AF758764811B7FAF9A1F1775888CAA47341FD51E0ED93A2D3A9")
      return 1;
    else
      return 0;
  }
}

manualreviveinspec(var_0) {
  self endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_9695073995D94BD959");
  var_1 = 120;
  wait(var_1);
  var_0 notifyonplayercommand("_encstr_A2BA0EB6C237BA2C1BD79CAC3B96D9AC", "_encstr_97410B23BD6B976233901AF2F8");
  var_0 thread scripts\cp\utility::hint_prompt("_encstr_A2BA0EB6C237BA2C1BD79CAC3B96D9AC", 1);
  var_0 waittill("_encstr_A2BA0EB6C237BA2C1BD79CAC3B96D9AC");
  var_0 thread scripts\cp\utility::hint_prompt("_encstr_A2BA0EB6C237BA2C1BD79CAC3B96D9AC", 0);

  if(isDefined(var_0.dogtag))
    var_0.dogtag delete();

  var_0 thread teleport_to_location();
  var_0 thread instant_revive(var_0);
}

teleport_to_location() {
  level.manual_revive_location = level.vehicle_travel_array[0].origin + (0, 0, 200);

  if(!isDefined(level.manual_revive_location)) {
    return;
  }
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  scripts\engine\utility::_id_143B9(3, "_encstr_9695073995D94BD959");
  self setOrigin(level.manual_revive_location);
}

putonground(var_0) {
  if(!var_0 isonground()) {
    var_1 = scripts\engine\utility::drop_to_ground(var_0.origin, 5, -1500);
    var_1 = getclosestpointonnavmesh(var_1);
    var_0 setOrigin(var_1);
  }
}

laststandwaittillrevivebyteammate(var_0, var_1) {
  self endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(isDefined(level.revive_ent_usability_func))
    self thread[[level.revive_ent_usability_func]](var_0, self);

  putonground(var_0);

  for(;;) {
    self makeusable();
    self setuseprioritymax();
    self waittill("_encstr_8F5C086405E70FBA4B4A", var_2);
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
    if(!isDefined(var_2._id_12D16))
      var_2._id_12D16 = 0;

    if(gettime() > var_2._id_12D16) {
      level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(var_2, "_encstr_B4EE096B6BA40AEED8405F");
      var_2._id_12D16 = gettime() + 10000;
    }

    disable_bleedout_ent_usability(var_0);

    if(istrue(var_2.class == "_encstr_A6C7065BAC91D28D"))
      var_1 = level.perks_suppressasserts;

    var_2 scripts\common\utility::allow_weapon(0);
    level thread _id_12D17(var_0, var_2);
    var_3 = get_revive_result(var_0, var_2, self.origin, int(var_1));
    enable_bleedout_ent_usability(var_0);

    if(var_3) {
      var_2 scripts\common\utility::allow_weapon(1);
      stop_revive_gesture(var_2, var_2.validtakeweapon);

      if(isDefined(var_2.vo_prefix)) {
        if(isDefined(level.revive_success_vo_func))
          level thread[[level.revive_success_vo_func]](var_2, var_0);
      } else
        level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(var_0, "_encstr_8E4208C9ACEC5A3BAC46");

      record_revive_success(var_2, var_0);
      var_2 notify("_encstr_8C8A103333CC6286C00EC38FE1A8D5BAA55B", var_0);
      scripts\cp\cp_analytics::_id_119BC(var_0, var_2);
      var_4 = scripts\cp\cp_endgame::get_current_zone(var_2);
      var_5 = 1;
      var_0.last_stand_state = undefined;

      if(isPlayer(var_2) && istrue(var_2.can_give_revive_xp))
        var_2.can_give_revive_xp = 0;

      break;
    } else {
      var_2 notify("_encstr_86660C9CCAEC969DACF58C7BCDB2");
      var_0 notify("_encstr_86660C9CCAEC969DACF58C7BCDB2");
      set_revive_icon_color(var_0.reviveent, (0.33, 0.75, 0.24));
      var_2 scripts\common\utility::allow_weapon(1);
      var_2 stop_revive_gesture(var_2, var_2.validtakeweapon);
      self notify("_encstr_AF770C1AB53B3BCBB7A92B6F41E8");
      continue;
    }
  }

  clear_last_stand_timer(var_0);
  self notify("_encstr_99E70F8E496BBA33A51FAE55ABF8FAAB23");
}

_id_12D17(var_0, var_1) {
  var_0 endon("_encstr_86660C9CCAEC969DACF58C7BCDB2");
  var_0 endon("_encstr_99E70F8E496BBA33A51FAE55ABF8FAAB23");
  var_1 endon("_encstr_8CBE0BD1BED30936AB03C0B02B");
  var_1 endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  var_0 waittill("_encstr_8D820B49520F0EC02DDE6367EC");
  wait 2;
  var_1 scripts\common\utility::allow_weapon(1);
  var_1 stop_revive_gesture(var_1, var_1.validtakeweapon);
}

_id_12C4D() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  wait 2;
  self.ability_invulnerable = undefined;
}

disable_bleedout_ent_usability(var_0) {
  if(isDefined(var_0.executeent)) {
    if(isDefined(level.disable_bleedout_ent_usability_func))
      level thread[[level.disable_bleedout_ent_usability_func]](var_0);
  }
}

enable_bleedout_ent_usability(var_0) {
  if(isDefined(var_0.executeent)) {
    if(isDefined(level.enable_bleedout_ent_usability_func))
      level thread[[level.enable_bleedout_ent_usability_func]](var_0);
  }
}

laststandmoveawayfromvehicles(var_0, var_1) {}

getrevivetimescaler(var_0, var_1) {
  if(istrue(var_0.can_revive))
    return 2;

  var_2 = var_0 scripts\cp\perks\cp_perks::get_perk("_encstr_8C5B1339CAECB49DACD71D96B62BFAB98DB08D859C");

  if(var_1 scripts\cp\utility::is_consumable_active("_encstr_81D11666856ED1954EEBC9593B4B3BACEBBAE076C958232B"))
    var_2 = var_2 * 2;

  return var_2;
}

record_revive_success(var_0, var_1) {
  if(isPlayer(var_0)) {
    var_0 scripts\cp\cp_merits::processmerit("_encstr_87030B6883BF86902BD9456BEA");
    var_0 scripts\cp\cp_persistence::increment_player_career_revives(var_0);
    var_0 scripts\cp\cp_merits::processmerit("_encstr_BD030BB5ED3E1B972588DBE230");
    var_0 scripts\cp\cp_persistence::eog_player_update_stat("_encstr_B642089B65A658E8F597", 1);
    var_1 thread scripts\cp\cp_hud_message::showsplash("_encstr_A2EE0BA873EFE363C3C4AC3D9F", undefined, var_0);

    if(isDefined(level.revive_success_analytics_func))
      [[level.revive_success_analytics_func]](var_0);
  }
}

makereviveentity(var_0, var_1, var_2, var_3, var_4) {
  var_5 = (0, 0, 20);
  var_6 = anglesToForward(var_0.angles) * 30;
  var_1 = scripts\engine\utility::drop_to_ground(var_1 + var_5 + var_6, 32, -64);
  var_7 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_1);
  var_7 setHintString(&"_encstr_86B11AF1183D511EE741A1AD4763A4BB10A6F159E1C40515AFBD56B5");
  var_7 sethintdisplayrange(256);
  var_7 setuserange(84);
  var_7 setusefov(180);
  var_7 setCursorHint("_encstr_829A0C23D4C1F35E818FDB4134BD");
  var_7 sethintdisplayfov(180);
  var_7 sethintonobstruction("_encstr_BECC055CF3811A");
  var_7 setuseholdduration("_encstr_97C20EB5FD43A179CC6AD05152651579");
  var_7.owner = var_0;
  var_7.inuse = 0;
  var_7.targetname = "_encstr_81C90FCAF9E0392BF5FFEBFBFBAC626D68";

  if(isDefined(var_2))
    var_7 setModel(var_2);

  if(isDefined(var_3))
    var_7 scriptmodelplayanim(var_3);

  if(var_4)
    var_7 linkTo(var_0, "_encstr_A2B40B8E2C3B7DDB274B9D4B37", var_5, (0, 0, 0));

  var_7 thread cleanuplaststandent(var_0);
  return var_7;
}

makeexecuteentity(var_0, var_1) {
  var_2 = (0, 0, 20);
  var_1 = scripts\engine\utility::drop_to_ground(var_1 + var_2, 32, -64);
  var_3 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_1);
  var_3 setCursorHint("_encstr_829A0C23D4C1F35E818FDB4134BD");
  var_3 setHintString(&"_encstr_9A7417A1D33D147DA30A3554F5A09850AC7951612A68AA458A");
  var_3.owner = var_0;
  var_3.inuse = 0;
  var_3 linkTo(var_0, "_encstr_A2B40B8E2C3B7DDB274B9D4B37", var_2, (0, 0, 0));
  var_3 thread executeent_use_think(var_3);
  var_3 thread cleanuplaststandent(var_0);
  var_0.executeent = var_3;
  return var_3;
}

executeent_use_think(var_0) {
  var_0 endon("_encstr_AD75063D571AE108");

  for(;;) {
    var_0 makeusable();
    var_0 setuseprioritymax();
    var_0 waittill("_encstr_8F5C086405E70FBA4B4A", var_1);
    var_0 makeunusable();
    var_2 = var_0.owner;
    var_2.reviveent makeunusable();
    var_3 = enter_execution_sequence(var_2, var_1);
    var_4 = execute_use_hold_think(var_2, var_1);
    exit_execution_sequence(var_2, var_1, var_3);

    if(var_4) {
      var_2 playerhide();
      var_2 notify("_encstr_966410CE10EB2FC727804AD250B9B1E7E305");
      return;
    }
  }
}

enter_execution_sequence(var_0, var_1) {
  var_0 iprintlnbold("_encstr_AFBE2156BDBA080BE4954026595ACDCE08BCC4CAC3596CBAE8958C97B90126CB40E589" + var_1.name);
  var_1 cameraset("_encstr_B8CB169FD3B95A7A08162EB38B78BF1218775303AB5DA172");
  var_2 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0.origin);
  var_2 setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_2.angles = var_1 getplayerangles();
  var_0 playerlinktodelta(var_2, "_encstr_A2B40B8E2C3B7DDB274B9D4B37", 0.5, 60, 60);
  return var_2;
}

exit_execution_sequence(var_0, var_1, var_2) {
  if(var_0 scripts\cp_mp\utility\player_utility::_isalive())
    var_0 unlink();

  if(isPlayer(var_1))
    var_1 cameradefault();

  var_2 delete();
}

execute_use_hold_think(var_0, var_1) {
  var_0 setclientomnvar("_encstr_83370CD0DF271BBB5A3B66E3D532", 1);
  var_1 setclientomnvar("_encstr_83370CD0DF271BBB5A3B66E3D532", 1);
  var_0 setclientomnvar("_encstr_AAB915BA96D76EB2C6EA9C2D3776EBC19CBD3BE4566ECD", 0);
  var_1 setclientomnvar("_encstr_AAB915BA96D76EB2C6EA9C2D3776EBC19CBD3BE4566ECD", 0);
  var_2 = 0;
  var_3 = 0;

  while(should_execute_continue(var_1)) {
    if(var_2 >= 2.5) {
      var_3 = 1;
      break;
    }

    var_4 = var_2 / 2.5;
    var_0 setclientomnvar("_encstr_AAB915BA96D76EB2C6EA9C2D3776EBC19CBD3BE4566ECD", var_4);
    var_1 setclientomnvar("_encstr_AAB915BA96D76EB2C6EA9C2D3776EBC19CBD3BE4566ECD", var_4);
    var_2 = var_2 + 0.05;
    waitframe();
  }

  if(var_0 scripts\cp_mp\utility\player_utility::_isalive())
    var_0 setclientomnvar("_encstr_83370CD0DF271BBB5A3B66E3D532", 0);

  if(isPlayer(var_1))
    var_1 setclientomnvar("_encstr_83370CD0DF271BBB5A3B66E3D532", 0);

  return var_3;
}

makereviveiconentity(var_0, var_1) {
  var_2 = (0, 0, 30);
  var_3 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_1.origin + var_2);
  var_3 thread cleanuplaststandent(var_0);
  return var_3;
}

maydolaststand(var_0, var_1) {
  if(scripts\cp\utility::isplayingsolo() || level.only_one_player)
    return solo_maydolaststand(var_0, var_1);
  else
    return coop_maydolaststand(var_1);
}

solo_maydolaststand(var_0, var_1) {
  if(var_0 && is_killed_by_kill_trigger(var_1))
    return 0;

  return 1;
}

coop_maydolaststand(var_0) {
  if(is_killed_by_kill_trigger(var_0))
    return 0;

  return 1;
}

only_use_weapon() {
  if(istrue(self.iscarrying))
    wait 0.5;

  var_0 = get_last_stand_pistol();

  if(self hasweapon(var_0))
    self takeweapon(var_0);

  if(weaponclass(var_0) != "_encstr_8D940738966ED1DB8D")
    var_0 = scripts\cp\cp_weapon::buildweapon("_encstr_9106102387E011DF472978E0722F376ADAB9", ["_encstr_A5510A30AA778D28B3C97D51"], "_encstr_8BBA05185F8B99", "_encstr_8BBA05185F8B99", -1);

  var_0 = var_0 withattachment("_encstr_A5510A30AA778D28B3C97D51");
  self giveweapon(var_0);
  var_1 = [getcompleteweaponname("_encstr_BED80D7C9C59D95BF870DBDFA9F018"), getcompleteweaponname("_encstr_BEB611F03B72BB3B07E435BCF9772051117388")];
  var_2 = can_use_pistol_during_last_stand(self);

  if(var_2)
    var_1[var_1.size] = var_0;

  _takeweaponsexceptlist(var_1);
  var_3 = get_number_of_last_stand_clips();

  if(var_2) {
    var_4 = self getammocount(var_0);
    var_5 = weaponclipsize(var_0);
    self setweaponammostock(var_0, var_5 * var_3);
    self setweaponammoclip(var_0, var_5);
    self switchtoweaponimmediate(var_0);
  }
}

get_number_of_last_stand_clips() {
  return 2;
}

get_last_stand_pistol() {
  if(isDefined(self.last_stand_pistol))
    return self.last_stand_pistol;

  var_0 = self.default_starting_pistol;
  var_1 = self getweaponslistprimaries()[0];

  if(scripts\cp\utility::getbaseweaponname(var_0) == scripts\cp\utility::getbaseweaponname(var_1))
    return var_1;
  else
    return var_0;
}

can_use_pistol_during_last_stand(var_0) {
  if(isDefined(level.can_use_pistol_during_laststand_func))
    return [[level.can_use_pistol_during_laststand_func]](var_0);
  else
    return 1;
}

cleanuplaststandent(var_0) {
  self endon("_encstr_AD75063D571AE108");
  var_0 scripts\engine\utility::_id_143A6("_encstr_AD75063D571AE108", "_encstr_8D820B49520F0EC02DDE6367EC", "_encstr_9695073995D94BD959");
  self delete();
}

remove_from_owner_revive_icon_list(var_0, var_1) {
  if(!isDefined(var_1)) {
    return;
  }
  var_1.revive_icons = scripts\engine\utility::array_remove(var_1.revive_icons, var_0);
}

default_player_init_laststand() {
  init_revive_icon_list(self);
}

give_laststand(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = 1;

  var_2 = var_0 get_last_stand_count() + var_1;
  set_last_stand_count(var_0, var_2);
}

take_laststand(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = 1;

  var_2 = var_0 get_last_stand_count() - var_1;
  set_last_stand_count(var_0, max(var_2, 0));
}

gameshouldend(var_0) {
  if(var_0 self_revive_activated())
    return 0;

  if((scripts\cp\utility::isplayingsolo() || level.only_one_player) && (var_0 scripts\cp\utility::has_auto_revive() || npc_revive_available()))
    return 0;

  if(scripts\cp\utility::isplayingsolo() || level.only_one_player)
    return solo_gameshouldend(var_0);
  else
    return coop_gameshouldend(var_0);
}

solo_gameshouldend(var_0) {
  if(player_in_laststand(var_0))
    return 0;

  return var_0 get_last_stand_count() == 0;
}

coop_gameshouldend(var_0) {
  if(isDefined(level.coop_gameshouldendfunc))
    return [[level.coop_gameshouldendfunc]](var_0);

  return everyone_else_all_in_laststand(var_0);
}

everyone_else_all_in_laststand(var_0) {
  foreach(var_2 in level.players) {
    if(var_2 == var_0) {
      continue;
    }
    if(!player_in_laststand(var_2))
      return 0;
  }

  return 1;
}

get_revive_result(var_0, var_1, var_2, var_3) {
  var_4 = scripts\cp\utility::createuseent(var_2);
  var_4 thread cleanuplaststandent(var_0);
  var_5 = revive_use_hold_think(var_0, var_1, var_4, var_3 - 1500);
  return var_5;
}

playdeathsoundinlaststand(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_9695073995D94BD959");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(!isDefined(var_0)) {
    return;
  }
  scripts\cp\utility::playdeathsound();
  wait(var_0 / 3);
  scripts\cp\utility::playdeathsound();
  wait(var_0 / 3);
  level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(self, "_encstr_ACBE12F049519F2F9591A24AC8A1E9FFABA7669C");
  scripts\cp\utility::playdeathsound();
}

enter_spectate(var_0, var_1, var_2) {
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(isDefined(var_0.carryicon))
    var_0.carryicon destroy();

  var_0.has_building_upgrade = 0;

  if(istrue(level.enable_manual_revive))
    var_2 thread manualreviveinspec(var_0);

  enter_camera_zoomout();

  if(istrue(var_0.fauxdead) || istrue(var_0.binc130)) {
    var_0.fauxdead = undefined;
    var_0 enter_bleed_out(var_0);
    var_0 playslamzoomflash();
  } else
    camera_zoomout(var_0, var_1, var_2);

  exit_camera_zoomout();
}

camera_zoomout(var_0, var_1, var_2) {
  if(isDefined(var_2))
    var_2 endon("_encstr_99E70F8E496BBA33A51FAE55ABF8FAAB23");

  var_3 = (0, 0, 30);
  var_4 = (0, 0, 100);
  var_5 = (0, 0, 400);
  var_6 = 2.0;
  var_7 = 0.6;
  var_8 = 0.6;
  var_9 = var_1 + var_3;
  var_10 = scripts\engine\trace::_bullet_trace(var_9, var_9 + var_4, 0, var_0);
  var_11 = var_10["_encstr_BD260953AA97E3F014279D"];
  var_10 = scripts\engine\trace::_bullet_trace(var_11, var_11 + var_5, 0, var_0);
  var_12 = var_10["_encstr_BD260953AA97E3F014279D"];
  var_13 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_11);
  var_13 setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_13.angles = vectortoangles((0, 0, -1));
  var_13 thread cleanuplaststandent(var_0);
  var_0 cameralinkTo(var_13, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_13 moveTo(var_12, var_6, var_7, var_8);
  var_13 waittill("_encstr_9B420907FD535DAC6DF285");
  var_13 delete();
  var_0 enter_bleed_out(var_0);
}

enter_bleed_out(var_0) {
  hide_all_revive_icons(var_0);

  if(isDefined(level.player_bleed_out_func))
    var_0[[level.player_bleed_out_func]](var_0);
  else if(isDefined(level.enterspectatorfunc))
    var_0[[level.enterspectatorfunc]]();
}

enter_camera_zoomout() {
  self playerhide();
  self freezecontrols(1);
}

exit_camera_zoomout() {
  self cameraunlink();
  self freezecontrols(0);
}

playslamzoomflash() {
  var_0 = newclienthudelem(self);
  var_0.x = 0;
  var_0.y = 0;
  var_0.alignx = "_encstr_A5AD056A019C63";
  var_0.aligny = "_encstr_AC190479FF92";
  var_0.sort = 1;
  var_0.horzalign = "_encstr_9A940B9FAB606CCB46157F7705";
  var_0.vertalign = "_encstr_9A940B9FAB606CCB46157F7705";
  var_0.alpha = 0;
  var_0.foreground = 1;
  var_0 setshader("_encstr_998806DD1A96D12B", 640, 480);
  var_0 fadeovertime(0.05);
  var_0.alpha = 1;
  wait 0.05;
  var_0 destroy();
}

revive_use_hold_think(var_0, var_1, var_2, var_3) {
  if(isDefined(var_1.vo_prefix)) {
    if(isDefined(level.revive_use_hold_vo_func))
      level thread[[level.revive_use_hold_vo_func]](var_1, var_0);
  }

  var_1 setclientomnvar("_encstr_AAB915BA96D76EB2C6EA9C2D3776EBC19CBD3BE4566ECD", 0);
  var_0 setclientomnvar("_encstr_AAB915BA96D76EB2C6EA9C2D3776EBC19CBD3BE4566ECD", 0);
  enter_revive_use_hold_think(var_0, var_1, var_2, var_3);
  set_revive_icon_color(var_0.reviveent, (0.0117, 0.9882, 0.9882));
  play_revive_gesture(var_1, var_0);
  var_1.validtakeweapon = var_1 scripts\cp\utility::getvalidtakeweapon();
  thread wait_for_exit_revive_use_hold_think(var_0, var_1, var_2, var_1.validtakeweapon);
  var_0.reviver = var_1;
  var_4 = 0;
  var_5 = 0;
  enable_on_world_progress_bar_for_other_players(var_0, var_1);

  if(isPlayer(var_1))
    var_0 notify("_encstr_B4EE096B6BA40AEED8405F");

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
    var_4 = var_4 + 50;
    waitframe();
  }

  disable_on_world_progress_bar_for_other_players(var_0, var_1);
  var_2 notify("_encstr_972218AD63DF47BAB7E90249530908FD68D058307878F00FF05F");
  var_2 waittill("_encstr_8E3D1D56F05AA3D7BAE6CAAFD0BD8D91F5D1A14B9BB6EBD8DBB638B1593A56");
  return var_5;
}

play_revive_gesture(var_0, var_1) {
  if(isDefined(level.nuclear_core_carrier)) {
    if(level.nuclear_core_carrier == var_0)
      return;
  }

  var_0 allowmelee(0);
  var_0 disableweaponswitch();
  var_0 notify("_encstr_9A630C851C886BC33D8221E3EEB1");
}

stop_revive_gesture(var_0, var_1) {
  if(isDefined(level.nuclear_core_carrier)) {
    if(level.nuclear_core_carrier == var_0)
      return;
  }

  var_0 enableweaponswitch();
  var_0 allowmelee(1);
}

get_revive_gesture(var_0) {
  return "_encstr_B8E210B359CDD727563BA5EC597D16363697";
}

update_players_revive_progress_bar(var_0, var_1, var_2) {
  foreach(var_4 in level.players) {
    if(var_4 == var_0 || var_4 == var_1) {
      var_4 setclientomnvar("_encstr_AAB915BA96D76EB2C6EA9C2D3776EBC19CBD3BE4566ECD", var_2);
      continue;
    }

    var_4 setclientomnvar("_encstr_93D10FED75C180BDD3923359196B675869" + var_0.revive_progress_bar_id + "_encstr_97510AEB389C7BB3E495CD6E", var_2);
  }
}

enter_revive_use_hold_think(var_0, var_1, var_2, var_3) {
  var_1 setclientomnvar("_encstr_AAB915BA96D76EB2C6EA9C2D3776EBC19CBD3BE4566ECD", 0);
  var_0 setclientomnvar("_encstr_AAB915BA96D76EB2C6EA9C2D3776EBC19CBD3BE4566ECD", 0);
  var_0 setclientomnvar("_encstr_ADFC0EEB491FDE8F28B12E6FAE1160AC", var_1 getentitynumber());
  var_0 setclientomnvar("_encstr_83370CD0DF271BBB5A3B66E3D532", 6);
  var_1 setclientomnvar("_encstr_83370CD0DF271BBB5A3B66E3D532", 5);
  var_0.being_revived = 1;

  if(isPlayer(var_1))
    var_1 scripts\cp\cp_powers::power_disablepower();

  var_1.isreviving = 1;
}

wait_for_exit_revive_use_hold_think(var_0, var_1, var_2, var_3) {
  scripts\engine\utility::waittill_any_ents(var_2, "_encstr_972218AD63DF47BAB7E90249530908FD68D058307878F00FF05F", var_0, "_encstr_8D820B49520F0EC02DDE6367EC", var_0, "_encstr_99E70F8E496BBA33A51FAE55ABF8FAAB23", var_0, "_encstr_966410CE10EB2FC727804AD250B9B1E7E305", var_1, "_encstr_8172130FC0A9E44A5BA047FFAF7F32BDD3886FDB30", var_0, "_encstr_AD75063D571AE108");

  if(var_0 scripts\cp_mp\utility\player_utility::_isalive()) {
    var_0 setclientomnvar("_encstr_83370CD0DF271BBB5A3B66E3D532", 0);
    var_0 setclientomnvar("_encstr_ADFC0EEB491FDE8F28B12E6FAE1160AC", -1);
    var_0 setclientomnvar("_encstr_AAB915BA96D76EB2C6EA9C2D3776EBC19CBD3BE4566ECD", 0);
    var_0 thread _id_12C51();
  }

  var_1.isreviving = 0;

  if(isPlayer(var_1)) {
    var_1 setclientomnvar("_encstr_83370CD0DF271BBB5A3B66E3D532", 0);
    var_1 setclientomnvar("_encstr_AAB915BA96D76EB2C6EA9C2D3776EBC19CBD3BE4566ECD", 0);
    var_1 setclientomnvar("_encstr_ADFC0EEB491FDE8F28B12E6FAE1160AC", -1);
    var_1 scripts\cp\cp_powers::power_enablepower();
    var_1 unlink();
    var_1 notify("_encstr_8CBF0C5EFB120136AA47788863D5");
  }

  var_2 notify("_encstr_8E3D1D56F05AA3D7BAE6CAAFD0BD8D91F5D1A14B9BB6EBD8DBB638B1593A56");
}

_id_12C51() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  wait 1.6;
  self.being_revived = 0;
}

play_rescue_anim(var_0) {
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 endon("_encstr_BE21195B0D1040B7C2217F9A115E977FAEA3136C6B9D27A348E29F");
  var_0 playanimscriptevent("_encstr_8DC71061EFA3504E0F7A09D3C2938DC9FE68", "_encstr_A1A50BB8D25A61235BFD873F85");
}

should_revive_continue(var_0) {
  if(istrue(var_0.can_revive))
    return 1;

  return !level.gameended && var_0 scripts\cp_mp\utility\player_utility::_isalive() && var_0 useButtonPressed() && !player_in_laststand(var_0);
}

should_execute_continue(var_0) {
  return !level.gameended && var_0 scripts\cp_mp\utility\player_utility::_isalive() && var_0 useButtonPressed() && !player_in_laststand(var_0);
}

_takeweaponsexceptlist(var_0) {
  var_1 = self getweaponslistall();

  foreach(var_3 in var_1) {
    if(scripts\engine\utility::array_contains(var_0, var_3))
      continue;
    else
      self takeweapon(var_3);
  }
}

is_killed_by_kill_trigger(var_0) {
  return isDefined(var_0);
}

set_last_stand_count(var_0, var_1) {
  var_1 = int(var_1);
  var_0 setplayerdata("_encstr_850703B7D9", "_encstr_8D720DB1E3340748613532E3D0F095", "_encstr_8CB611C62C371DEB9BD1589B23FAC67BBA378E", var_1);
}

set_last_stand_timer(var_0, var_1) {
  if(isDefined(var_1))
    var_0 setclientomnvar("_encstr_847521F4D6F5EAD2AF1BB0CDA3DCD1B0CD32F5597323BEB5968D63B46EAC1BF69B8CB9", gettime() + var_1 * 1000);
}

clear_last_stand_timer(var_0) {
  var_0 setclientomnvar("_encstr_847521F4D6F5EAD2AF1BB0CDA3DCD1B0CD32F5597323BEB5968D63B46EAC1BF69B8CB9", 0);
}

instant_revive(var_0) {
  if(is_being_revived(var_0)) {
    return;
  }
  var_0.trackriotshield_trydetach = 1;
  var_0 notify("_encstr_99E70F8E496BBA33A51FAE55ABF8FAAB23");

  if(isDefined(var_0.reviveent))
    var_0.reviveent notify("_encstr_99E70F8E496BBA33A51FAE55ABF8FAAB23");

  if(is_being_revived(var_0))
    disable_on_world_progress_bar_for_other_players(var_0, var_0.reviver);

  clear_last_stand_timer(var_0);
}

set_revive_time(var_0, var_1, var_2) {
  if(isDefined(var_0))
    level.normal_revive_time = var_0;

  if(isDefined(var_1))
    level.spectator_revive_time = var_1;

  level.perks_suppressasserts = var_2;
}

get_normal_revive_time() {
  if(isDefined(level.normal_revive_time))
    return level.normal_revive_time;
  else
    return 5000;
}

get_spectator_revive_time() {
  if(isDefined(level.spectator_revive_time))
    return level.spectator_revive_time;
  else
    return 6000;
}

updatemovespeedscale() {
  self[[level.move_speed_scale]]();
}

get_currency_penalty_amount(var_0) {
  if(isDefined(level.laststand_currency_penalty_amount_func))
    return [[level.laststand_currency_penalty_amount_func]](var_0);

  return 500;
}

makereviveicon(var_0, var_1, var_2, var_3) {
  setup_revive_icon_ent(var_0);
  var_0.current_revive_icon_color = var_2;
  var_0 thread reviveiconentcleanup(var_0);
  var_4 = undefined;

  foreach(var_6 in level.players) {
    if(var_6 == var_1) {
      continue;
    }
    if(isDefined(level.should_show_revive_icon_to_player_func) && ![[level.should_show_revive_icon_to_player_func]](var_6, var_1)) {
      continue;
    }
    var_4 = show_revive_icon_to_player(var_0, var_6);
    add_to_revive_icon_ent_icon_list(var_0, var_4);
  }

  return var_4;
}

show_revive_icon_to_player(var_0, var_1) {
  var_2 = newclienthudelem(var_1);
  var_2 setshader("_encstr_A26513341A43097AEFCD0BD1A6B91910A556F3F0CD", 8, 8);
  var_2 setwaypoint(1, 1);
  var_2 settargetEnt(var_0);
  var_2.alpha = get_revive_icon_initial_alpha(var_1);
  var_2.color = var_0.current_revive_icon_color;
  add_to_player_revive_icon_list(var_1, var_2);
  var_2 thread reviveiconcleanup(var_0, var_1);
  return var_2;
}

reviveiconentcleanup(var_0) {
  var_0 waittill("_encstr_AD75063D571AE108");
  remove_from_revive_icon_entity_list(var_0);
}

reviveiconcleanup(var_0, var_1) {
  scripts\engine\utility::waittill_any_ents_return(var_0, "_encstr_AD75063D571AE108", var_1, "_encstr_8D820B49520F0EC02DDE6367EC");
  remove_from_owner_revive_icon_list(self, var_1);

  if(isDefined(self))
    self destroy();
}

set_revive_icon_color(var_0, var_1) {
  var_0.current_revive_icon_color = var_1;
  var_0.revive_icons = scripts\engine\utility::array_removeundefined(var_0.revive_icons);

  foreach(var_3 in var_0.revive_icons)
  var_3.color = var_1;
}

init_laststand() {
  level.revive_icon_entities = [];
  level.players_being_revived = [];
  level thread revive_icon_player_connect_monitor();
}

add_to_revive_icon_entity_list(var_0) {
  level.revive_icon_entities[level.revive_icon_entities.size] = var_0;
}

remove_from_revive_icon_entity_list(var_0) {
  level.revive_icon_entities = scripts\engine\utility::array_remove(level.revive_icon_entities, var_0);
  level.revive_icon_entities = scripts\engine\utility::array_removeundefined(level.revive_icon_entities);
}

revive_icon_player_connect_monitor() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(istrue(level.disable_revive_icon_hotjoin_monitor)) {
    return;
  }
  for(;;) {
    level waittill("_encstr_AA940A6CB7DC9B2B6C3ACA91", var_0);

    foreach(var_2 in level.revive_icon_entities)
    show_revive_icon_to_player(var_2, var_0);

    foreach(var_5 in level.players_being_revived) {
      if(isDefined(var_5))
        var_0 setclientomnvar("_encstr_93D10FED75C180BDD3923359196B675869" + var_5.revive_progress_bar_id + "_encstr_8ACE08F84B42B5A12D93", var_5);
    }
  }
}

setup_revive_icon_ent(var_0) {
  var_0.revive_icons = [];
  add_to_revive_icon_entity_list(var_0);
}

add_to_revive_icon_ent_icon_list(var_0, var_1) {
  var_0.revive_icons[var_0.revive_icons.size] = var_1;
}

init_revive_icon_list(var_0) {
  var_0.revive_icons = [];
}

add_to_player_revive_icon_list(var_0, var_1) {
  var_0.revive_icons[var_0.revive_icons.size] = var_1;
}

remove_from_player_revive_icon_list(var_0, var_1) {
  var_0.revive_icons = scripts\engine\utility::array_remove(var_0.revive_icons, var_1);
}

get_revive_icon_initial_alpha(var_0) {
  if(isDefined(var_0.last_stand_state) && var_0.last_stand_state == "_encstr_8FE20AD2903BB77B0E68ADA4")
    return 0;
  else
    return 1;
}

show_all_revive_icons(var_0) {
  foreach(var_2 in var_0.revive_icons)
  var_2.alpha = 1;
}

hide_all_revive_icons(var_0) {
  foreach(var_2 in var_0.revive_icons)
  var_2.alpha = 0;
}

enable_on_world_progress_bar_for_other_players(var_0, var_1) {
  var_2 = add_to_players_being_revived(var_0);
  var_3 = "_encstr_93D10FED75C180BDD3923359196B675869" + var_2 + "_encstr_8ACE08F84B42B5A12D93";

  foreach(var_5 in level.players) {
    if(var_5 == var_0 || var_5 == var_1) {
      continue;
    }
    var_5 setclientomnvar(var_3, var_0);
  }
}

disable_on_world_progress_bar_for_other_players(var_0, var_1) {
  var_2 = "_encstr_93D10FED75C180BDD3923359196B675869" + var_0.revive_progress_bar_id + "_encstr_8ACE08F84B42B5A12D93";
  remove_from_players_being_revived(var_0);

  foreach(var_4 in level.players) {
    if(var_4 == var_0 || var_4 == var_1) {
      continue;
    }
    var_4 setclientomnvar(var_2, undefined);
  }
}

self_revive_activated() {
  return isDefined(self.self_revive) && self.self_revive > 0;
}

add_to_players_being_revived(var_0) {
  for(var_1 = 0; var_1 < 2; var_1++) {
    if(!isDefined(level.players_being_revived[var_1])) {
      level.players_being_revived[var_1] = var_0;
      var_2 = var_1 + 1;
      var_0.revive_progress_bar_id = var_2;
      return var_2;
    }
  }
}

remove_from_players_being_revived(var_0) {
  for(var_1 = 0; var_1 < 2; var_1++) {
    if(isDefined(level.players_being_revived[var_1]) && level.players_being_revived[var_1] == var_0) {
      level.players_being_revived[var_1] = undefined;
      var_0.revive_progress_bar_id = undefined;
      return;
    }
  }
}

shouldgodirectlytospectate(var_0) {
  if(getdvarint("_encstr_B448132B9FC889FBD023422A6EBE2BFF9809BF9519", 0) != 0)
    return 1;

  if(isDefined(level.shouldgodirectlytospectatefunc))
    return [[level.shouldgodirectlytospectatefunc]](var_0);

  if(istrue(var_0.bhitbyvehicle))
    return 1;

  if(debugafterlifearcadeenabled())
    return 1;

  return 0;
}

debugafterlifearcadeenabled() {
  return 0;
}

haveselfrevive() {
  return istrue(self.have_self_revive);
}

get_last_stand_count() {
  return self getplayerdata("_encstr_850703B7D9", "_encstr_8D720DB1E3340748613532E3D0F095", "_encstr_8CB611C62C371DEB9BD1589B23FAC67BBA378E");
}

is_being_revived(var_0) {
  return istrue(var_0.being_revived);
}

player_in_laststand(var_0) {
  return var_0.inlaststand;
}

enable_self_revive(var_0) {
  if(!isDefined(var_0.self_revive))
    var_0.self_revive = 0;

  var_0.self_revive++;
}

disable_self_revive(var_0) {
  var_0.self_revive--;
}

self_revive(var_0) {
  putonground(var_0);
  var_1 = 3;

  if(isDefined(level.self_revive_wait_override))
    var_1 = level.self_revive_wait_override;

  if(isDefined(var_0.self_revive_wait_override))
    var_1 = var_0.self_revive_wait_override;

  var_0 scripts\engine\utility::_id_143B9(var_1, "_encstr_99E70F8E496BBA33A51FAE55ABF8FAAB23");
  return 1;
}

give_fists_if_no_real_weapon(var_0) {
  if(has_no_real_weapon(var_0)) {
    self giveweapon("_encstr_A7660DA5EE0EAFCCD237D1DC7D6B1C");
    self switchtoweaponimmediate("_encstr_A7660DA5EE0EAFCCD237D1DC7D6B1C");
    self setspawnweapon("_encstr_A7660DA5EE0EAFCCD237D1DC7D6B1C", 1);
  }
}

has_no_real_weapon(var_0) {
  var_1 = var_0 getweaponslistall();

  foreach(var_3 in var_1) {
    var_4 = var_3.basename;

    if(var_4 == "_encstr_BEB611F03B72BB3B07E435BCF9772051117388") {
      continue;
    }
    if(issubstr(var_4, "_encstr_A59306426009CA07")) {
      continue;
    }
    if(var_4 == "_encstr_A7660DA5EE0EAFCCD237D1DC7D6B1C") {
      continue;
    }
    return 0;
  }

  return 1;
}

npc_revive_available() {
  return istrue(level.the_hoff_revive);
}

give_up_loop(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  self notify("_encstr_91F80DB3A5D92BAF57837D63ED7B1C");
  self endon("_encstr_91F80DB3A5D92BAF57837D63ED7B1C");
  self endon("_encstr_BA3A0D5797E3F30765E2418C3F95F8");
  self.give_up_counter = 0;
  self.give_up_state = "_encstr_A7C5056BD931D1";
  self.give_up_requested = 0;
  self.give_up_rumble_ent = get_rumble_ent();
  self.give_up_rumble_ent set_rumble_intensity(0);
  thread give_up_monitor();

  for(;;) {
    self waittill("_encstr_9BBD160FBBD8370FCD7371BB1B2F7BEF39178891DD287FAB");

    if(self.give_up_requested) {
      if(self.give_up_counter >= 10) {
        break;
      }

      give_up_request_sequence();
      continue;
    }

    if(self.give_up_state != "_encstr_A7C5056BD931D1")
      give_up_release_sequence();
  }

  if(isDefined(self.give_up_asset))
    self.give_up_asset delete();

  self iprintln("_encstr_965D234097B7AB401A583BB280CD578DB12BDCCDCCAB1B1BCB109D5AEC597301D538120980");
  return 0;
}

give_up_request_sequence() {
  self endon("_encstr_BA3A0D5797E3F30765E2418C3F95F8");
  self.give_up_counter++;

  if(self.give_up_state == "_encstr_A7C5056BD931D1") {
    self iprintln("_encstr_A9BC17E123174B5B89896966BF4ACDEA4FA76A4A331D429DEA" + self.give_up_counter);
    self.give_up_state = "_encstr_A24C088995166B602DC7";
  } else if(self.give_up_state == "_encstr_A24C088995166B602DC7") {
    give_up_push_anim(self);
    self.give_up_rumble_ent thread rumble_ramp_on(0.25);
  } else if(self.give_up_state == "_encstr_8CFD0AC27BD0EF3F06E82AA2") {
    self iprintln("_encstr_A9BC17E123174B5B89896966BF4ACDEA4FA76A4A331D429DEA" + self.give_up_counter);
    self.give_up_state = "_encstr_A24C088995166B602DC7";
  }
}

give_up_release_sequence() {
  self endon("_encstr_BA3A0D5797E3F30765E2418C3F95F8");

  if(self.give_up_state == "_encstr_8CFD0AC27BD0EF3F06E82AA2")
    self.give_up_rumble_ent thread rumble_ramp_off(0.25);
  else if(self.give_up_state == "_encstr_A24C088995166B602DC7") {
    self iprintln("_encstr_A70919A52D1E81AD3B50D59F78DB74BA359EE13DE175F0F5B2CE01" + self.give_up_counter);
    give_up_release_anim(self);
    self.give_up_state = "_encstr_8CFD0AC27BD0EF3F06E82AA2";
  }
}

give_up_monitor() {
  self notifyonplayercommand("_encstr_BED312749CA30B56CD7351300FE12BB35B43FD0D", "_encstr_A9E60828803C73F11780");
  self notifyonplayercommand("_encstr_BED312749CA30B56CD7351300FE12BB35B43FD0D", "_encstr_B4C60AD707B2BDC0E6CE1309");
  self notifyonplayercommand("_encstr_BED312749CA30B56CD7351300FE12BB35B43FD0D", "_encstr_97410B23BD6B976233901AF2F8");
  self notifyonplayercommand("_encstr_B6651293B3C86B0F6BF7D0A3AD6B4B81A0238229", "_encstr_97120D65B983599519EB1D86C9B7EE");
  self notifyonplayercommand("_encstr_B6651293B3C86B0F6BF7D0A3AD6B4B81A0238229", "_encstr_9B0D065699E485D9");
  self notifyonplayercommand("_encstr_B6651293B3C86B0F6BF7D0A3AD6B4B81A0238229", "_encstr_8E5F0795E6AD7BAD2B");

  for(;;) {
    var_0 = scripts\engine\utility::_id_143BA(0.3, "_encstr_BED312749CA30B56CD7351300FE12BB35B43FD0D", "_encstr_B6651293B3C86B0F6BF7D0A3AD6B4B81A0238229");

    if(isDefined(var_0) && var_0 == "_encstr_995408F398012F656821") {
      self.give_up_counter--;

      if(self.give_up_counter <= 0)
        self.give_up_counter = 0;

      continue;
    }

    if(isDefined(var_0) && var_0 == "_encstr_BED312749CA30B56CD7351300FE12BB35B43FD0D")
      self.give_up_requested = 0;
    else
      self.give_up_requested = 1;

    self notify("_encstr_9BBD160FBBD8370FCD7371BB1B2F7BEF39178891DD287FAB");
  }
}

get_rumble_ent(var_0) {
  var_1 = scripts\cp\utility::get_player_from_self();

  if(!isDefined(var_0))
    var_0 = "_encstr_82D50EB91D5685192FAF9357AD31D82B";

  var_2 = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", var_1 getEye());
  var_2.intensity = 1;
  var_2 thread update_rumble_intensity(var_1, var_0);
  return var_2;
}

set_rumble_intensity(var_0) {
  self.intensity = var_0;
}

rumble_ramp_on(var_0) {
  thread rumble_ramp_to(1, var_0);
}

rumble_ramp_off(var_0) {
  thread rumble_ramp_to(0, var_0);
}

rumble_ramp_to(var_0, var_1) {
  self notify("_encstr_9642091AA7D7DE83192A0A");
  self endon("_encstr_9642091AA7D7DE83192A0A");
  self endon("_encstr_AD75063D571AE108");
  var_2 = var_1 * 20;
  var_3 = var_0 - self.intensity;
  var_4 = var_3 / var_2;

  for(var_5 = 0; var_5 < var_2; var_5++) {
    self.intensity = self.intensity + var_4;
    wait 0.05;
  }

  self.intensity = var_0;
}

update_rumble_intensity(var_0, var_1) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BA3A0D5797E3F30765E2418C3F95F8");
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
    var_3 = var_3 * 1000;
    self.origin = var_0 getEye() + (0, 0, var_3);
    wait 0.05;
  }
}

give_up_push_anim(var_0) {
  var_1 = var_0 getEye();
  var_2 = var_0 getplayerangles();
  var_3 = anglesToForward(var_2);
  var_4 = anglestoright(var_2);
  var_5 = anglestoup(var_2) * -1;
  var_6 = var_1 + var_3 * 17 + var_4 * 3 + var_5 * 0.16;

  if(!isDefined(var_0.give_up_asset)) {
    var_7 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_6);
    var_7 setModel("_encstr_9AE61A90BF492BFFFAC134B129222336A37F28B817F2868FA274244D");
    var_8 = (var_2[0], var_2[1], var_2[2] + 90);
    var_7.angles = var_8;
    var_7 linkTo(var_0);
    var_0.give_up_asset = var_7;
  } else
    var_0.give_up_asset moveTo(var_6, 5);
}

give_up_release_anim(var_0) {
  var_1 = var_0 getEye();
  var_2 = var_0 getplayerangles();
  var_3 = anglesToForward(var_2);
  var_4 = anglestoright(var_2);
  var_5 = anglestoup(var_2) * -1;
  var_6 = var_1 + var_3 * 17 + var_4 * -3 + var_5 * 0.16;

  if(!isDefined(var_0.give_up_asset)) {
    var_7 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_6);
    var_7 setModel("_encstr_9AE61A90BF492BFFFAC134B129222336A37F28B817F2868FA274244D");
    var_8 = (var_2[0], var_2[1], var_2[2] + 90);
    var_7.angles = var_8;
    var_7 linkTo(var_0);
    var_0.give_up_asset = var_7;
  } else
    var_0.give_up_asset moveTo(var_6, 5);
}

give_up_easy_setup(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_99E70F8E496BBA33A51FAE55ABF8FAAB23");
  self endon("_encstr_9695073995D94BD959");
  self endon("_encstr_AF770C1AB53B3BCBB7A92B6F41E8");
  self endon("_encstr_852B140A41FF7CB923B8C7BB5FAF0691C293D8337B69");
  self endon("_encstr_AAED1130FA03EB6BBF54988638C731812EC3B8");
  self endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  wait 15;

  if(self isspectatingplayer()) {
    return;
  }
  thread show_give_up_hint();
  self notifyonplayercommand("_encstr_BED312749CA30B56CD7351300FE12BB35B43FD0D", "_encstr_B4C60AD707B2BDC0E6CE1309");
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
      var_12 = var_12 + level.framedurationseconds;

      if(var_12 >= 0.3 || istrue(level.timer_override)) {
        break;
      }
    } else
      var_12 = 0;

    self setclientomnvar("_encstr_9BB011D3B5BE862D3747AFC1C9F63BC9596E37", var_12 / 0.3);
  }

  self notify("_encstr_BA3A0D5797E3F30765E2418C3F95F8");
  var_0 notify("_encstr_966410CE10EB2FC727804AD250B9B1E7E305");

  if(scripts\cp\utility::isplayingsolo())
    return 1;
  else
    return 0;
}

show_give_up_hint() {
  thread scripts\cp\utility::hint_prompt("_encstr_8B31089A58DCF7C94552", 1);
  var_0 = scripts\engine\utility::waittill_any_ents_return(self, "_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5", self, "_encstr_BA3A0D5797E3F30765E2418C3F95F8", level, "_encstr_9B1D0BC7932875276230426AA1", self, "_encstr_99E70F8E496BBA33A51FAE55ABF8FAAB23", self, "_encstr_995408F398012F656821", self, "_encstr_BE3009989F7CABE51AAFDD");

  if(isDefined(var_0) && (var_0 == "_encstr_99E70F8E496BBA33A51FAE55ABF8FAAB23" || var_0 == "_encstr_BE3009989F7CABE51AAFDD" || var_0 == "_encstr_995408F398012F656821"))
    level.timer_override = 1;

  self setclientomnvar("_encstr_A3AD0E1299C1C2EBD2554FF0C20D3A99", 0);
  self setclientomnvar("_encstr_9BB011D3B5BE862D3747AFC1C9F63BC9596E37", 0);
}

#using_animtree("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");

init_laststand_anims() {
  if(istrue(level.ls_anims_init)) {
    return;
  }
  level.ls_anims_init = 1;
  level.scr_animtree["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"] = #animtree;
  level.scr_animtree["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"] = #animtree;
  level.scr_anim["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_B60A0B3A6AB96AFB10B069213E"] = % _encstr_8BAA2A739D7AB180C319096953990750693B0710D0F4033AA4777B3BDB23F8D516B24ED1D0FFB5323D8BD15A;
  level.scr_animname["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_B60A0B3A6AB96AFB10B069213E"] = "_encstr_8BAA2A739D7AB180C319096953990750693B0710D0F4033AA4777B3BDB23F8D516B24ED1D0FFB5323D8BD15A";
  level.scr_eventanim["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_B60A0B3A6AB96AFB10B069213E"] = "_encstr_9BBD10048F91B2A3C7B0C27998300F2D39B3";
  level.scr_anim["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_A20A0B03D6C7D3299E2AF021C7"] = % _encstr_86AA2ACD4639FAAD38BEB1C29B8EB98EB0B919EBB98EC2E691AF4EACCEA59DB2AF4B73EB43AC1BE0B239FA91;
  level.scr_animname["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_A20A0B03D6C7D3299E2AF021C7"] = "_encstr_86AA2ACD4639FAAD38BEB1C29B8EB98EB0B919EBB98EC2E691AF4EACCEA59DB2AF4B73EB43AC1BE0B239FA91";
  level.scr_eventanim["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_A20A0B03D6C7D3299E2AF021C7"] = "_encstr_99BD10115EEFCF1BAFF2192F39278B35DFFA";
  level.scr_anim["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_950A0B2DDCBECD3A0B9B32FACC"] = % _encstr_A5AA2A9B2196CFED387FA4B13F40322BB7D862C12B6DEFE5B017B2BD1D40BBD7F0507A49D04D935A4075E7D3;
  level.scr_animname["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_950A0B2DDCBECD3A0B9B32FACC"] = "_encstr_A5AA2A9B2196CFED387FA4B13F40322BB7D862C12B6DEFE5B017B2BD1D40BBD7F0507A49D04D935A4075E7D3";
  level.scr_eventanim["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_950A0B2DDCBECD3A0B9B32FACC"] = "_encstr_ABBD1036CDF56E4758E68CD743F54B37FA33";
  level.scr_anim["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_BA0A0BD44071FBC3CFA5E31709"] = % _encstr_8DAA2ACA593398890B57810237A063613A42E159BBF4113D817FC26F9DB23B58E14FA86FE20830022BE2809B;
  level.scr_animname["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_BA0A0BD44071FBC3CFA5E31709"] = "_encstr_8DAA2ACA593398890B57810237A063613A42E159BBF4113D817FC26F9DB23B58E14FA86FE20830022BE2809B";
  level.scr_eventanim["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_BA0A0BD44071FBC3CFA5E31709"] = "_encstr_A7BD1072280F727B89A8FCCFB396D7FDE7EA";
  level.scr_anim["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_8C0A0B11A581A2533740D26963"] = % _encstr_9AAA2AE68C27F5B583F5D858B9E86EA3B07332AF371D85E6C8BE39CACEA5B356F5D273FA435936E0ACC9EBC6;
  level.scr_animname["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_8C0A0B11A581A2533740D26963"] = "_encstr_9AAA2AE68C27F5B583F5D858B9E86EA3B07332AF371D85E6C8BE39CACEA5B356F5D273FA435936E0ACC9EBC6";
  level.scr_eventanim["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_8C0A0B11A581A2533740D26963"] = "_encstr_93BD108A23E09F4B50BD0C2FA979D4230873";
  level.scr_anim["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_A90A0B71C5E1C2F397E072C9A3"] = % _encstr_8CAA2AA748232FA299D09DD62E499BCCE9A0738F989B49DA99C8E2CF941B8365F670E307D8118C03E376A153;
  level.scr_animname["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_A90A0B71C5E1C2F397E072C9A3"] = "_encstr_8CAA2AA748232FA299D09DD62E499BCCE9A0738F989B49DA99C8E2CF941B8365F670E307D8118C03E376A153";
  level.scr_eventanim["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_A90A0B71C5E1C2F397E072C9A3"] = "_encstr_A3BD10A0F26FA80D2AFB81EFFB91DB08D75B";
  level.scr_anim["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_970A0B2D37FA6EA32C9B46BE70"] = % _encstr_8FAA2AD3E872B9F0080F8D374735DB65AEC068F0E06073AD61368EBD56ABDDA777F3E8B9A4D1A10A37EBCFA2;
  level.scr_animname["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_970A0B2D37FA6EA32C9B46BE70"] = "_encstr_8FAA2AD3E872B9F0080F8D374735DB65AEC068F0E06073AD61368EBD56ABDDA777F3E8B9A4D1A10A37EBCFA2";
  level.scr_eventanim["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_970A0B2D37FA6EA32C9B46BE70"] = "_encstr_A9BD10C26BA8C71318C54477E1C11CEBF06A";
  level.scr_anim["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_AA0A0B2D37FADCE8B0738CF593"] = % _encstr_A3AA2A1B1DA8B1E333C083B013055B81189B19A91B11B30811983D81A3517337FF4060BEB2C26DBB5292B92A;
  level.scr_animname["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_AA0A0B2D37FADCE8B0738CF593"] = "_encstr_A3AA2A1B1DA8B1E333C083B013055B81189B19A91B11B30811983D81A3517337FF4060BEB2C26DBB5292B92A";
  level.scr_eventanim["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_AA0A0B2D37FADCE8B0738CF593"] = "_encstr_8CBD10D13A110753B96BE8391BEF88457930";
  level.scr_anim["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_83750D5A23D82BBEE6E8C2CD8CFA98"] = % _encstr_8B8F2C62CFCB570DB961AD30AB6B0B612785E7969049B2C6CB3F0BC5A8939B4F768987286019EB8F7C0B1D5361FF;
  level.scr_animname["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_83750D5A23D82BBEE6E8C2CD8CFA98"] = "_encstr_8B8F2C62CFCB570DB961AD30AB6B0B612785E7969049B2C6CB3F0BC5A8939B4F768987286019EB8F7C0B1D5361FF";
  level.scr_eventanim["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_83750D5A23D82BBEE6E8C2CD8CFA98"] = "_encstr_88E61060F30E03FB2728A779D359523BEF62";
  level.scr_anim["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_A5750D7989F907D83F9341A57921E7"] = % _encstr_8D8F2CF8734B57BD0B79930B33BB836CB27D2128E3A3A1A8AF4F4D953B635D7DB7719A47B189A0E2C3CB3D5B516F;
  level.scr_animname["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_A5750D7989F907D83F9341A57921E7"] = "_encstr_8D8F2CF8734B57BD0B79930B33BB836CB27D2128E3A3A1A8AF4F4D953B635D7DB7719A47B189A0E2C3CB3D5B516F";
  level.scr_eventanim["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_A5750D7989F907D83F9341A57921E7"] = "_encstr_97E6107B5026A3931BE8FF39C3BFCA68CEA2";
  level.scr_anim["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_86750DB111B8879F5E63E21A89A0D6"] = % _encstr_A58F2C2B92E5DFE728A82C37AFD9D74D50C0D1E702E0DE866DB6F5FF93C8640107DC7B571A6F2325FCC009EA27AA;
  level.scr_animname["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_86750DB111B8879F5E63E21A89A0D6"] = "_encstr_A58F2C2B92E5DFE728A82C37AFD9D74D50C0D1E702E0DE866DB6F5FF93C8640107DC7B571A6F2325FCC009EA27AA";
  level.scr_eventanim["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_86750DB111B8879F5E63E21A89A0D6"] = "_encstr_AAE610C093714F2337D68D68B8A76811293F";
  level.scr_anim["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_AF750D0135782359EF1B37E84C7173"] = % _encstr_9A8F2CCD91E4F55B38EBB10BB9E8B91D0BDC46BE6E4758CD19F54ECACE5AB359D7C6EDED1CF51AB236E0B2277D1A;
  level.scr_animname["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_AF750D0135782359EF1B37E84C7173"] = "_encstr_9A8F2CCD91E4F55B38EBB10BB9E8B91D0BDC46BE6E4758CD19F54ECACE5AB359D7C6EDED1CF51AB236E0B2277D1A";
  level.scr_eventanim["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_AF750D0135782359EF1B37E84C7173"] = "_encstr_85E610E05B17DEC0063699F728E148276F47";
  level.scr_anim["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_8C750D64B1585DC196C1A7A3D9A89F"] = % _encstr_A98F2CC8142B69C55348842F2805D30DE35BE79682FB9AAB90A7CA17E528664B2112CF28AB91808F7103316B790F;
  level.scr_animname["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_8C750D64B1585DC196C1A7A3D9A89F"] = "_encstr_A98F2CC8142B69C55348842F2805D30DE35BE79682FB9AAB90A7CA17E528664B2112CF28AB91808F7103316B790F";
  level.scr_eventanim["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_8C750D64B1585DC196C1A7A3D9A89F"] = "_encstr_84E61070DF4F63E11265C540FC2909CBE772";
  level.scr_anim["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_9A750DB419B1597DB9A385E646BE6E"] = % _encstr_8C8F2C3731CE019D680EC58EA360CBEB2F4D130F87752A4630167A977BD0F632E8F1B75729080205581BB75A76CA;
  level.scr_animname["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_9A750DB419B1597DB9A385E646BE6E"] = "_encstr_8C8F2C3731CE019D680EC58EA360CBEB2F4D130F87752A4630167A977BD0F632E8F1B75729080205581BB75A76CA";
  level.scr_eventanim["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_9A750DB419B1597DB9A385E646BE6E"] = "_encstr_8AE610B1B9BE6E1D85E6917DD07D3607D79B";
  level.scr_anim["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_BA750DD8B9F139C1439B0B4091E1E0"] = % _encstr_B18F2C5E8C23062BEA09600B2303CFBBC73E6DC0F3438965D71168384B1C8DD1E7D460406847504BBDCBD888B160;
  level.scr_animname["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_BA750DD8B9F139C1439B0B4091E1E0"] = "_encstr_B18F2C5E8C23062BEA09600B2303CFBBC73E6DC0F3438965D71168384B1C8DD1E7D460406847504BBDCBD888B160";
  level.scr_eventanim["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_BA750DD8B9F139C1439B0B4091E1E0"] = "_encstr_A6E610189AFF7BBB30AE4D074BD9A102A773";
  level.scr_anim["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_A9750D1B5B0A7D29ABC3C920EF5FC2"] = % _encstr_BA8F2C37C839EBDA1CFA36B0DCA3DCE82CCD19AFE68E16B991EB93B2B3A5B3AC7D36F6B783FAD056C6E02B39BEE4;
  level.scr_animname["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_A9750D1B5B0A7D29ABC3C920EF5FC2"] = "_encstr_BA8F2C37C839EBDA1CFA36B0DCA3DCE82CCD19AFE68E16B991EB93B2B3A5B3AC7D36F6B783FAD056C6E02B39BEE4";
  level.scr_eventanim["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_A9750D1B5B0A7D29ABC3C920EF5FC2"] = "_encstr_B2E61048E7774BC90A8D3DA8E40131D38F26";
  level.scr_anim["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_9A6C0CFF3503F75A6970922A993B"] = % _encstr_912C2B888362E6D30329C15F3A9B374BD913B871B71C799D6AC1C655532275D13FFF88A09FA831A153773E70FA;
  level.scr_animname["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_9A6C0CFF3503F75A6970922A993B"] = "_encstr_912C2B888362E6D30329C15F3A9B374BD913B871B71C799D6AC1C655532275D13FFF88A09FA831A153773E70FA";
  level.scr_eventanim["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_9A6C0CFF3503F75A6970922A993B"] = "_encstr_ACB211D3A719AFD847A2E177D3AFAD102B9FEB";
  level.scr_anim["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_BA6C0CF2A8E929377B5F8684788B"] = % _encstr_932C2B0BFD330FE08BEF69FE5BE8AFFB61FAF8475F1CA07E8DE060BB9B1B7B85278FAB41515BA7209B89E8D99A;
  level.scr_animname["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_BA6C0CF2A8E929377B5F8684788B"] = "_encstr_932C2B0BFD330FE08BEF69FE5BE8AFFB61FAF8475F1CA07E8DE060BB9B1B7B85278FAB41515BA7209B89E8D99A";
  level.scr_eventanim["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_BA6C0CF2A8E929377B5F8684788B"] = "_encstr_91B211FD8B19939B670D5BBF69AF52ED2896E2";
  level.scr_anim["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_A96C0C18AB8C0146438FCDD15F1F"] = % _encstr_A32C2BCFC9C609957006FD86BB68B3F317451B078F6D525E38EE728F73E8FE3AE0EFC7236F9BDA04C0B16A19C3;
  level.scr_animname["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_A96C0C18AB8C0146438FCDD15F1F"] = "_encstr_A32C2BCFC9C609957006FD86BB68B3F317451B078F6D525E38EE728F73E8FE3AE0EFC7236F9BDA04C0B16A19C3";
  level.scr_eventanim["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_A96C0C18AB8C0146438FCDD15F1F"] = "_encstr_8FB21163E6BE6EE8589BC8BE34AFB75D3AF5CC";
  level.scr_anim["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_A56C0CF7FF6B80A84C6688C18154"] = % _encstr_8E2C2B3B28EDD1B7F3589C89665B07A373D0D271E8891683A9A08A85FC804B2FE7404BBB2169CFC343957287B5;
  level.scr_animname["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_A56C0CF7FF6B80A84C6688C18154"] = "_encstr_8E2C2B3B28EDD1B7F3589C89665B07A373D0D271E8891683A9A08A85FC804B2FE7404BBB2169CFC343957287B5";
  level.scr_eventanim["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_A56C0CF7FF6B80A84C6688C18154"] = "_encstr_82B211BC37290A0B6F28AA01F0A8AF4388877C";
  level.scr_anim["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_AF6C0CF83D0BCF9260834D7A11A3"] = % _encstr_AC2C2BB9C8C9AFB6E0F5B1B06ED1B93AC29B19EB6EA3C29B32FAE459EC2DCE95BEDBAB3AD7D09563075627FA8D;
  level.scr_animname["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_AF6C0CF83D0BCF9260834D7A11A3"] = "_encstr_AC2C2BB9C8C9AFB6E0F5B1B06ED1B93AC29B19EB6EA3C29B32FAE459EC2DCE95BEDBAB3AD7D09563075627FA8D";
  level.scr_eventanim["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_AF6C0CF83D0BCF9260834D7A11A3"] = "_encstr_BEB21133186EFBCB53A087719B0732A5531122";
  level.scr_anim["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_8D6C0C18CD2540CA0BEA36A387EC"] = % _encstr_B82C2B06A79B0718C0D7C0905FFC139972CD7598FA53C320BCBF38B8A3098BE3F935759559EA83A8704F2071BE;
  level.scr_animname["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_8D6C0C18CD2540CA0BEA36A387EC"] = "_encstr_B82C2B06A79B0718C0D7C0905FFC139972CD7598FA53C320BCBF38B8A3098BE3F935759559EA83A8704F2071BE";
  level.scr_eventanim["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_8D6C0C18CD2540CA0BEA36A387EC"] = "_encstr_8EB2116A30177A73B1A0F4D74B9ED703B9B947";
  level.scr_anim["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_9B6C0CDBBA47EB373A16B9237D1C"] = % _encstr_BD2C2BFAA9B07FCA2FAFBB871FD5D3ACC070B749E3D809B20D97DB6F0D73CBF589B86B0B1E90D54A5F8BD38FB9;
  level.scr_animname["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_9B6C0CDBBA47EB373A16B9237D1C"] = "_encstr_BD2C2BFAA9B07FCA2FAFBB871FD5D3ACC070B749E3D809B20D97DB6F0D73CBF589B86B0B1E90D54A5F8BD38FB9";
  level.scr_eventanim["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_9B6C0CDBBA47EB373A16B9237D1C"] = "_encstr_88B211802FBFB331C255F510AC597F3BFC07AA";
  level.scr_anim["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_996C0CC86BFB87608930B0E1897A"] = % _encstr_872C2B0B22ABF0304A0F91834B33B82D8F1A6136FB6B17E06737B5F3565C587DCF62DBDBC1B35DA8BAE5BD8F31;
  level.scr_animname["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_996C0CC86BFB87608930B0E1897A"] = "_encstr_872C2B0B22ABF0304A0F91834B33B82D8F1A6136FB6B17E06737B5F3565C587DCF62DBDBC1B35DA8BAE5BD8F31";
  level.scr_eventanim["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_996C0CC86BFB87608930B0E1897A"] = "_encstr_96B2116446A16339B6A8311F1B11A5C0FBB75F";
  level.scr_anim["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_B60A0B3A6AB96AFB10B069213E"] = % _encstr_999A2F421108C742B73733FF975D6B2448F83FC16B50812A851F43E7B58B436D11E0355983305DE2ED73031723B8AF9F2A;
  level.scr_animname["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_B60A0B3A6AB96AFB10B069213E"] = "_encstr_999A2F421108C742B73733FF975D6B2448F83FC16B50812A851F43E7B58B436D11E0355983305DE2ED73031723B8AF9F2A";
  level.scr_eventanim["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_B60A0B3A6AB96AFB10B069213E"] = "_encstr_8CD712DA80A7CAC3213064A7540E7F557F3AE7E7";
  level.scr_anim["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_A20A0B03D6C7D3299E2AF021C7"] = % _encstr_9A7D2B6EC893D7D6E07D63589BE8B93A0BCD19AFDCE885E6C8F59C56D95AEC95D7B49BF5EEBDAEDC32CA327D19;
  level.scr_animname["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_A20A0B03D6C7D3299E2AF021C7"] = "_encstr_9A7D2B6EC893D7D6E07D63589BE8B93A0BCD19AFDCE885E6C8F59C56D95AEC95D7B49BF5EEBDAEDC32CA327D19";
  level.scr_eventanim["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_A20A0B03D6C7D3299E2AF021C7"] = "_encstr_B4721059F3A9E04DF78AE9B623378B40F12A";
  level.scr_anim["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_950A0B2DDCBECD3A0B9B32FACC"] = % _encstr_838C2F0EAF930FADD8DFF89847F41B814AD50D80C24B3B28B4C730A0AB31F3EBF1BCF0085B92ABD09C478879966FC3673F;
  level.scr_animname["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_950A0B2DDCBECD3A0B9B32FACC"] = "_encstr_838C2F0EAF930FADD8DFF89847F41B814AD50D80C24B3B28B4C730A0AB31F3EBF1BCF0085B92ABD09C478879966FC3673F";
  level.scr_eventanim["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_950A0B2DDCBECD3A0B9B32FACC"] = "_encstr_B4D7123637EBB93AC2CD23FABB7D2DB9FA666CC9";
  level.scr_anim["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_BA0A0BD44071FBC3CFA5E31709"] = % _encstr_999A2F421108C742B73733FF975D6B2448F83FC16B50812A851F43E7B58B436D11E0355983305DE2ED73031723B8AF9F2A;
  level.scr_animname["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_BA0A0BD44071FBC3CFA5E31709"] = "_encstr_999A2F421108C742B73733FF975D6B2448F83FC16B50812A851F43E7B58B436D11E0355983305DE2ED73031723B8AF9F2A";
  level.scr_eventanim["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_BA0A0BD44071FBC3CFA5E31709"] = "_encstr_8CD712DA80A7CAC3213064A7540E7F557F3AE7E7";
  level.scr_anim["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_8C0A0B11A581A2533740D26963"] = % _encstr_838C2F0EAF930FADD8DFF89847F41B814AD50D80C24B3B28B4C730A0AB31F3EBF1BCF0085B92ABD09C478879966FC3673F;
  level.scr_animname["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_8C0A0B11A581A2533740D26963"] = "_encstr_838C2F0EAF930FADD8DFF89847F41B814AD50D80C24B3B28B4C730A0AB31F3EBF1BCF0085B92ABD09C478879966FC3673F";
  level.scr_eventanim["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_8C0A0B11A581A2533740D26963"] = "_encstr_B4D7123637EBB93AC2CD23FABB7D2DB9FA666CC9";
  level.scr_anim["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_A90A0B71C5E1C2F397E072C9A3"] = % _encstr_999A2F421108C742B73733FF975D6B2448F83FC16B50812A851F43E7B58B436D11E0355983305DE2ED73031723B8AF9F2A;
  level.scr_animname["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_A90A0B71C5E1C2F397E072C9A3"] = "_encstr_999A2F421108C742B73733FF975D6B2448F83FC16B50812A851F43E7B58B436D11E0355983305DE2ED73031723B8AF9F2A";
  level.scr_eventanim["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_A90A0B71C5E1C2F397E072C9A3"] = "_encstr_8CD712DA80A7CAC3213064A7540E7F557F3AE7E7";
  level.scr_anim["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_970A0B2D37FA6EA32C9B46BE70"] = % _encstr_957D2B33837369CAB891D339CF13BBAB70A032E1881BDFE057A74B492BFB9BD549D3F329D7C0D01A87985C87AA;
  level.scr_animname["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_970A0B2D37FA6EA32C9B46BE70"] = "_encstr_957D2B33837369CAB891D339CF13BBAB70A032E1881BDFE057A74B492BFB9BD549D3F329D7C0D01A87985C87AA";
  level.scr_eventanim["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_970A0B2D37FA6EA32C9B46BE70"] = "_encstr_81721033186EFBCB53A08771140752BE362A";
  level.scr_anim["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_AA0A0B2D37FADCE8B0738CF593"] = % _encstr_838C2F0EAF930FADD8DFF89847F41B814AD50D80C24B3B28B4C730A0AB31F3EBF1BCF0085B92ABD09C478879966FC3673F;
  level.scr_animname["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_AA0A0B2D37FADCE8B0738CF593"] = "_encstr_838C2F0EAF930FADD8DFF89847F41B814AD50D80C24B3B28B4C730A0AB31F3EBF1BCF0085B92ABD09C478879966FC3673F";
  level.scr_eventanim["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_AA0A0B2D37FADCE8B0738CF593"] = "_encstr_B4D7123637EBB93AC2CD23FABB7D2DB9FA666CC9";
  level.scr_anim["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_83750D5A23D82BBEE6E8C2CD8CFA98"] = % _encstr_87DD314B6493AEDFD7114C4B3B2396D9276A1869FBE1978859C9DE52DC9A960A278A6D5A17EE7C27E3C2F7208D11F1B6B73E6B;
  level.scr_animname["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_83750D5A23D82BBEE6E8C2CD8CFA98"] = "_encstr_87DD314B6493AEDFD7114C4B3B2396D9276A1869FBE1978859C9DE52DC9A960A278A6D5A17EE7C27E3C2F7208D11F1B6B73E6B";
  level.scr_eventanim["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_83750D5A23D82BBEE6E8C2CD8CFA98"] = "_encstr_8A68121BDCFA3747C23719F5EEAFD8C17D4C86DC";
  level.scr_anim["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_A5750D7989F907D83F9341A57921E7"] = % _encstr_A9DF2D938045492F9B20E4E1CEE3AF4B8B486AE99011BE6B3108E21D6468F3574FB04262F0EFF3B74B88FC1575F63A;
  level.scr_animname["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_A5750D7989F907D83F9341A57921E7"] = "_encstr_A9DF2D938045492F9B20E4E1CEE3AF4B8B486AE99011BE6B3108E21D6468F3574FB04262F0EFF3B74B88FC1575F63A";
  level.scr_eventanim["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_A5750D7989F907D83F9341A57921E7"] = "_encstr_8E8E108BDF98034420E807C1E3F994EB70B5";
  level.scr_anim["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_86750DB111B8879F5E63E21A89A0D6"] = % _encstr_B8ED3157B8D3FF7249AFADE67E39EB9CD970835FA8CB398A4938329FE42B7355A6083717480667C2B348BF97C59F7F276329E6;
  level.scr_animname["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_86750DB111B8879F5E63E21A89A0D6"] = "_encstr_B8ED3157B8D3FF7249AFADE67E39EB9CD970835FA8CB398A4938329FE42B7355A6083717480667C2B348BF97C59F7F276329E6";
  level.scr_eventanim["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_86750DB111B8879F5E63E21A89A0D6"] = "_encstr_A56812F3F6E8BB04E7B85139AB0163176F6383E0";
  level.scr_anim["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_AF750D0135782359EF1B37E84C7173"] = % _encstr_87DD314B6493AEDFD7114C4B3B2396D9276A1869FBE1978859C9DE52DC9A960A278A6D5A17EE7C27E3C2F7208D11F1B6B73E6B;
  level.scr_animname["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_AF750D0135782359EF1B37E84C7173"] = "_encstr_87DD314B6493AEDFD7114C4B3B2396D9276A1869FBE1978859C9DE52DC9A960A278A6D5A17EE7C27E3C2F7208D11F1B6B73E6B";
  level.scr_eventanim["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_AF750D0135782359EF1B37E84C7173"] = "_encstr_8A68121BDCFA3747C23719F5EEAFD8C17D4C86DC";
  level.scr_anim["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_8C750D64B1585DC196C1A7A3D9A89F"] = % _encstr_B8ED3157B8D3FF7249AFADE67E39EB9CD970835FA8CB398A4938329FE42B7355A6083717480667C2B348BF97C59F7F276329E6;
  level.scr_animname["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_8C750D64B1585DC196C1A7A3D9A89F"] = "_encstr_B8ED3157B8D3FF7249AFADE67E39EB9CD970835FA8CB398A4938329FE42B7355A6083717480667C2B348BF97C59F7F276329E6";
  level.scr_eventanim["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_8C750D64B1585DC196C1A7A3D9A89F"] = "_encstr_A56812F3F6E8BB04E7B85139AB0163176F6383E0";
  level.scr_anim["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_9A750DB419B1597DB9A385E646BE6E"] = % _encstr_87DD314B6493AEDFD7114C4B3B2396D9276A1869FBE1978859C9DE52DC9A960A278A6D5A17EE7C27E3C2F7208D11F1B6B73E6B;
  level.scr_animname["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_9A750DB419B1597DB9A385E646BE6E"] = "_encstr_87DD314B6493AEDFD7114C4B3B2396D9276A1869FBE1978859C9DE52DC9A960A278A6D5A17EE7C27E3C2F7208D11F1B6B73E6B";
  level.scr_eventanim["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_9A750DB419B1597DB9A385E646BE6E"] = "_encstr_8A68121BDCFA3747C23719F5EEAFD8C17D4C86DC";
  level.scr_anim["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_BA750DD8B9F139C1439B0B4091E1E0"] = % _encstr_86DF2D3732C9AFDA0EFA8DC29BA36EE80B7332AF374716DC467DE456EC2D67CAEBD87BB71CD7BBDE5DDC46AC91FA70;
  level.scr_animname["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_BA750DD8B9F139C1439B0B4091E1E0"] = "_encstr_86DF2D3732C9AFDA0EFA8DC29BA36EE80B7332AF374716DC467DE456EC2D67CAEBD87BB71CD7BBDE5DDC46AC91FA70";
  level.scr_eventanim["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_BA750DD8B9F139C1439B0B4091E1E0"] = "_encstr_998E1090C3211F7387663DB85757B8A199DF";
  level.scr_anim["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_A9750D1B5B0A7D29ABC3C920EF5FC2"] = % _encstr_B8ED3157B8D3FF7249AFADE67E39EB9CD970835FA8CB398A4938329FE42B7355A6083717480667C2B348BF97C59F7F276329E6;
  level.scr_animname["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_A9750D1B5B0A7D29ABC3C920EF5FC2"] = "_encstr_B8ED3157B8D3FF7249AFADE67E39EB9CD970835FA8CB398A4938329FE42B7355A6083717480667C2B348BF97C59F7F276329E6";
  level.scr_eventanim["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_A9750D1B5B0A7D29ABC3C920EF5FC2"] = "_encstr_A56812F3F6E8BB04E7B85139AB0163176F6383E0";
  level.scr_anim["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_9A6C0CFF3503F75A6970922A993B"] = % _encstr_9966307747D34170E09FA9F027FBD3DB37DBBD68A655F6783037A398DB48FB11915FB584CF9717C31D59E8999617C7A18177;
  level.scr_animname["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_9A6C0CFF3503F75A6970922A993B"] = "_encstr_9966307747D34170E09FA9F027FBD3DB37DBBD68A655F6783037A398DB48FB11915FB584CF9717C31D59E8999617C7A18177";
  level.scr_eventanim["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_9A6C0CFF3503F75A6970922A993B"] = "_encstr_936C13D8CDAF373AC2E619EBEED7BDEA3AFA130DE6";
  level.scr_anim["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_BA6C0CF2A8E929377B5F8684788B"] = % _encstr_96962C1813F296A373B951EF8A0BA7BB49A3280127ACE96DDA5156E5A3B2E5418F0F38D02F47E0032287C57DF1DF;
  level.scr_animname["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_BA6C0CF2A8E929377B5F8684788B"] = "_encstr_96962C1813F296A373B951EF8A0BA7BB49A3280127ACE96DDA5156E5A3B2E5418F0F38D02F47E0032287C57DF1DF";
  level.scr_eventanim["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_BA6C0CF2A8E929377B5F8684788B"] = "_encstr_8D3F1109E2C9DFBB519323E1CF57101BA301DE";
  level.scr_anim["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_A96C0C18AB8C0146438FCDD15F1F"] = % _encstr_997730BBF71DFE6B79D980277718EB703F52528E0EE5B152D9FF056F4CB8FE27992D9D08DF30823D22A90FC0E983C12EB12F;
  level.scr_animname["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_A96C0C18AB8C0146438FCDD15F1F"] = "_encstr_997730BBF71DFE6B79D980277718EB703F52528E0EE5B152D9FF056F4CB8FE27992D9D08DF30823D22A90FC0E983C12EB12F";
  level.scr_eventanim["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_A96C0C18AB8C0146438FCDD15F1F"] = "_encstr_836C1320273938119F23A991ACE72F70FB814A03AB";
  level.scr_anim["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_A56C0CF7FF6B80A84C6688C18154"] = % _encstr_9966307747D34170E09FA9F027FBD3DB37DBBD68A655F6783037A398DB48FB11915FB584CF9717C31D59E8999617C7A18177;
  level.scr_animname["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_A56C0CF7FF6B80A84C6688C18154"] = "_encstr_9966307747D34170E09FA9F027FBD3DB37DBBD68A655F6783037A398DB48FB11915FB584CF9717C31D59E8999617C7A18177";
  level.scr_eventanim["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_A56C0CF7FF6B80A84C6688C18154"] = "_encstr_936C13D8CDAF373AC2E619EBEED7BDEA3AFA130DE6";
  level.scr_anim["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_AF6C0CF83D0BCF9260834D7A11A3"] = % _encstr_997730BBF71DFE6B79D980277718EB703F52528E0EE5B152D9FF056F4CB8FE27992D9D08DF30823D22A90FC0E983C12EB12F;
  level.scr_animname["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_AF6C0CF83D0BCF9260834D7A11A3"] = "_encstr_997730BBF71DFE6B79D980277718EB703F52528E0EE5B152D9FF056F4CB8FE27992D9D08DF30823D22A90FC0E983C12EB12F";
  level.scr_eventanim["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_AF6C0CF83D0BCF9260834D7A11A3"] = "_encstr_836C1320273938119F23A991ACE72F70FB814A03AB";
  level.scr_anim["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_8D6C0C18CD2540CA0BEA36A387EC"] = % _encstr_9966307747D34170E09FA9F027FBD3DB37DBBD68A655F6783037A398DB48FB11915FB584CF9717C31D59E8999617C7A18177;
  level.scr_animname["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_8D6C0C18CD2540CA0BEA36A387EC"] = "_encstr_9966307747D34170E09FA9F027FBD3DB37DBBD68A655F6783037A398DB48FB11915FB584CF9717C31D59E8999617C7A18177";
  level.scr_eventanim["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_8D6C0C18CD2540CA0BEA36A387EC"] = "_encstr_936C13D8CDAF373AC2E619EBEED7BDEA3AFA130DE6";
  level.scr_anim["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_9B6C0CDBBA47EB373A16B9237D1C"] = % _encstr_85962CC379CE87A580B77C79C788EA93FF902A89E3A5375DF84F7A45D518F31F0828B343CEFCD7D3C011654CEFBA;
  level.scr_animname["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_9B6C0CDBBA47EB373A16B9237D1C"] = "_encstr_85962CC379CE87A580B77C79C788EA93FF902A89E3A5375DF84F7A45D518F31F0828B343CEFCD7D3C011654CEFBA";
  level.scr_eventanim["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_9B6C0CDBBA47EB373A16B9237D1C"] = "_encstr_993F11CA90B7DAD3D1C094B7643E77E3595917";
  level.scr_anim["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_996C0CC86BFB87608930B0E1897A"] = % _encstr_997730BBF71DFE6B79D980277718EB703F52528E0EE5B152D9FF056F4CB8FE27992D9D08DF30823D22A90FC0E983C12EB12F;
  level.scr_animname["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_996C0CC86BFB87608930B0E1897A"] = "_encstr_997730BBF71DFE6B79D980277718EB703F52528E0EE5B152D9FF056F4CB8FE27992D9D08DF30823D22A90FC0E983C12EB12F";
  level.scr_eventanim["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_996C0CC86BFB87608930B0E1897A"] = "_encstr_836C1320273938119F23A991ACE72F70FB814A03AB";
  level.scr_anim["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_8FCB0CB4B9BE3627DEEA3643EB89"] = % _encstr_9B102BE619E47D5BC1AFC6B0CDA3373A16CD19BE1B9CEDBA6C1AD79395B32DECCAD72D9BF50DCA360E2B39FA62;
  level.scr_animname["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_8FCB0CB4B9BE3627DEEA3643EB89"] = "_encstr_9B102BE619E47D5BC1AFC6B0CDA3373A16CD19BE1B9CEDBA6C1AD79395B32DECCAD72D9BF50DCA360E2B39FA62";
  level.scr_eventanim["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_8FCB0CB4B9BE3627DEEA3643EB89"] = "_encstr_ABF9118DCDFAB1E47B578DA1FAD0F5D2DC7D26";
  level.scr_anim["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_B8CB0CB7CDA03A7A78532EF40E4A"] = % _encstr_A7102B3AD9DBB655FB8FD06F9A0B632DF08BFFC1B85B6235D2202FDBFF16CA1B2157914038C303D1F937C807B5;
  level.scr_animname["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_B8CB0CB7CDA03A7A78532EF40E4A"] = "_encstr_A7102B3AD9DBB655FB8FD06F9A0B632DF08BFFC1B85B6235D2202FDBFF16CA1B2157914038C303D1F937C807B5";
  level.scr_eventanim["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_B8CB0CB7CDA03A7A78532EF40E4A"] = "_encstr_A7F91163B9BE8D4EEDAED886D71A7D9637F591";
  level.scr_anim["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_ACCB0CD2E6EB1B27B7D5D886D766"] = % _encstr_AB102BDC32E4FAD6C1EB362C6EA36EE8B0738C7DC639DEEA8D0DEB4E59EC4BD92BEBA59BF5A1591BC1ACE4EBCC;
  level.scr_animname["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_ACCB0CD2E6EB1B27B7D5D886D766"] = "_encstr_AB102BDC32E4FAD6C1EB362C6EA36EE8B0738C7DC639DEEA8D0DEB4E59EC4BD92BEBA59BF5A1591BC1ACE4EBCC";
  level.scr_eventanim["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_ACCB0CD2E6EB1B27B7D5D886D766"] = "_encstr_A1F911346BDF616548BF11B00951E10A96A62A";
  level.scr_anim["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_A1CB0C64F0C15B1398C3AFBBAF1D"] = % _encstr_86102B53E95E1735F0C7ECE977387A630FCD9A1991369F6B50B127E263708423A5DEC2927E834FE5A08302C7A9;
  level.scr_animname["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_A1CB0C64F0C15B1398C3AFBBAF1D"] = "_encstr_86102B53E95E1735F0C7ECE977387A630FCD9A1991369F6B50B127E263708423A5DEC2927E834FE5A08302C7A9";
  level.scr_eventanim["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_A1CB0C64F0C15B1398C3AFBBAF1D"] = "_encstr_93F91163DC7D6CC9ED5DB10DAFD0BE2DCDAF43";
  level.scr_anim["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_A3CB0CCA90F0EFFA109B1BE83722"] = % _encstr_83102B6EC893FAB61CF5C616E63ADCE8163791EBC627BDD53634D79395B3A5B3B2F54B73AFD0CAD883594ED71B;
  level.scr_animname["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_A3CB0CCA90F0EFFA109B1BE83722"] = "_encstr_83102B6EC893FAB61CF5C616E63ADCE8163791EBC627BDD53634D79395B3A5B3B2F54B73AFD0CAD883594ED71B";
  level.scr_eventanim["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_A3CB0CCA90F0EFFA109B1BE83722"] = "_encstr_8FF911CBE096E3A357354E84086149A118192A";
  level.scr_anim["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_93CB0C67B02EABEB0F6D06FC4097"] = % _encstr_8B102B6E1993FAB683F5C62CCDE86EA358DC8C7DC627BD5DC643F54E95CED2ECACF54BDCF586B28D07AC4EBEDC;
  level.scr_animname["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_93CB0C67B02EABEB0F6D06FC4097"] = "_encstr_8B102B6E1993FAB683F5C62CCDE86EA358DC8C7DC627BD5DC643F54E95CED2ECACF54BDCF586B28D07AC4EBEDC";
  level.scr_eventanim["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_93CB0C67B02EABEB0F6D06FC4097"] = "_encstr_91F91136CD7D1B39F6AB8D43EB43D7B4E6EB9B";
  level.scr_anim["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_9BCB0CF70361AE18E51B904B8140"] = % _encstr_9A102BD0DDF26F8522EE4B83536DB3ABFF300F58829BC80D6E602E960733795BB74F906D518005DA1BEFE5B707;
  level.scr_animname["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_9BCB0CF70361AE18E51B904B8140"] = "_encstr_9A102BD0DDF26F8522EE4B83536DB3ABFF300F58829BC80D6E602E960733795BB74F906D518005DA1BEFE5B707";
  level.scr_eventanim["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_9BCB0CF70361AE18E51B904B8140"] = "_encstr_ACF911A9BF81C6E8EFDBE19849C0490B2AA799";
  level.scr_anim["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_83CB0C58920FDEF8BD159F811770"] = % _encstr_8C102B0251488702F777733F579DABE488B87F8129A04F5B4631B77B5344F23E2BE6B45546C80D8227331BD7F3;
  level.scr_animname["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_83CB0C58920FDEF8BD159F811770"] = "_encstr_8C102B0251488702F777733F579DABE488B87F8129A04F5B4631B77B5344F23E2BE6B45546C80D8227331BD7F3";
  level.scr_eventanim["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_83CB0C58920FDEF8BD159F811770"] = "_encstr_B8F911C1D7E9AEB0477359309138A1D392FFE3";
  level.scr_anim["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_ACE60E9C92708A6906A830DB0BFBD16B"] = % _encstr_87432DAA22735188D327C22A432412D09295CB50C3D83FD726037F482BD4A97B4BFF611FB298E852BBA8D34223F783;
  level.scr_animname["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_ACE60E9C92708A6906A830DB0BFBD16B"] = "_encstr_87432DAA22735188D327C22A432412D09295CB50C3D83FD726037F482BD4A97B4BFF611FB298E852BBA8D34223F783";
  level.scr_eventanim["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_ACE60E9C92708A6906A830DB0BFBD16B"] = "_encstr_BE2411C44F51767BB713F24A3EEB97ED80AF11";
  level.scr_anim["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_B8E60E9CF5119A8FB9485F3FE8F05737"] = % _encstr_96432DCBE7DDDE603B090DBE3B838BFD99BB28A16FB8C7EB605B213650182CB3218912B54093CFF2F2FD726DEA2753;
  level.scr_animname["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_B8E60E9CF5119A8FB9485F3FE8F05737"] = "_encstr_96432DCBE7DDDE603B090DBE3B838BFD99BB28A16FB8C7EB605B213650182CB3218912B54093CFF2F2FD726DEA2753";
  level.scr_eventanim["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_B8E60E9CF5119A8FB9485F3FE8F05737"] = "_encstr_BD2411D06B27E6C0953D87E96F3CE139C301A3";
  level.scr_anim["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_8EE60EC0AA5B551906AA0F23A3AC5106"] = % _encstr_88432D77F41271314389F841538BF6E06E46D1B79B7AA8052712962B1AEBA348879F795F0F22E1C3476A8BF1137746;
  level.scr_animname["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_8EE60EC0AA5B551906AA0F23A3AC5106"] = "_encstr_88432D77F41271314389F841538BF6E06E46D1B79B7AA8052712962B1AEBA348879F795F0F22E1C3476A8BF1137746";
  level.scr_eventanim["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_8EE60EC0AA5B551906AA0F23A3AC5106"] = "_encstr_8224116982A99F1B3F9F58784F40F6C903217E";
  level.scr_anim["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_BEE60E9710B85DC9877E950BEEB981B4"] = % _encstr_81432D338F65E138C2CEF1E74A2B239BCA3DBD48FFF39FDF378B4F1D8A968BD575A788879A23F108C8F3E3BFEAD014;
  level.scr_animname["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_BEE60E9710B85DC9877E950BEEB981B4"] = "_encstr_81432D338F65E138C2CEF1E74A2B239BCA3DBD48FFF39FDF378B4F1D8A968BD575A788879A23F108C8F3E3BFEAD014";
  level.scr_eventanim["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_BEE60E9710B85DC9877E950BEEB981B4"] = "_encstr_962411910859862035D32FA807FBAE52394993";
  level.scr_anim["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_82E60EB446B156D78D27EDD51B43AF63"] = % _encstr_97432DBAE9F03F8A6FEFFBC7DF15136C0B30F709A128C7C3CEB92FF3EB3C7AA6987E6D8DD890AF4A15599BA7ED70D7;
  level.scr_animname["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_82E60EB446B156D78D27EDD51B43AF63"] = "_encstr_97432DBAE9F03F8A6FEFFBC7DF15136C0B30F709A128C7C3CEB92FF3EB3C7AA6987E6D8DD890AF4A15599BA7ED70D7";
  level.scr_eventanim["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_82E60EB446B156D78D27EDD51B43AF63"] = "_encstr_8124119CF721465B1F0B2A1A58F0C898394963";
  level.scr_anim["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_BDE60EB0DA2B256956FA5F93137CA1D4"] = % _encstr_AD432DAB235B2FB1BBD7A15AFB9DE3752110CC4F6FA3487FD629A98B3546036CBFB7CC621A731FD34DB88049AB771A;
  level.scr_animname["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_BDE60EB0DA2B256956FA5F93137CA1D4"] = "_encstr_AD432DAB235B2FB1BBD7A15AFB9DE3752110CC4F6FA3487FD629A98B3546036CBFB7CC621A731FD34DB88049AB771A";
  level.scr_eventanim["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_BDE60EB0DA2B256956FA5F93137CA1D4"] = "_encstr_88241178F3F710AE675BFE692F53060AE00F8C";
  level.scr_anim["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_87E60E96C86395D7B1E4DEEAC686D7C1"] = % _encstr_8F432D03FF8DE68BDFE7D18EF2DD9FAB4BCA12478386BD43E8EB674B83F3176D67B1598FC22289BBFF71827F1AE7AA;
  level.scr_animname["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_87E60E96C86395D7B1E4DEEAC686D7C1"] = "_encstr_8F432D03FF8DE68BDFE7D18EF2DD9FAB4BCA12478386BD43E8EB674B83F3176D67B1598FC22289BBFF71827F1AE7AA";
  level.scr_eventanim["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_87E60E96C86395D7B1E4DEEAC686D7C1"] = "_encstr_932411E14BE1281697737118F9A35888C28FB1";
  level.scr_anim["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_96E60E933FE2EBF67BDB70A877980EAB"] = % _encstr_91432DDFC3BB6F92F7566AA37F4B9FF163F8FCBFB02B0FA382FBA706B0A3539C2DD9A9A8FFE056EB82C0D3C213F9A3;
  level.scr_animname["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_96E60E933FE2EBF67BDB70A877980EAB"] = "_encstr_91432DDFC3BB6F92F7566AA37F4B9FF163F8FCBFB02B0FA382FBA706B0A3539C2DD9A9A8FFE056EB82C0D3C213F9A3";
  level.scr_eventanim["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_96E60E933FE2EBF67BDB70A877980EAB"] = "_encstr_A1241198CB29C74BB765A62B7793D6914A91BA";
  level.scr_anim["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_AC820D80ABE3BF69C37FADAE404F1B"] = % _encstr_8DF72C2330F5D9BF0B5094915E531FDB7BD8DA79608D8D9741235F9A7D7B3FE3ABB9D253407F84EFD8176D9218AB;
  level.scr_animname["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_AC820D80ABE3BF69C37FADAE404F1B"] = "_encstr_8DF72C2330F5D9BF0B5094915E531FDB7BD8DA79608D8D9741235F9A7D7B3FE3ABB9D253407F84EFD8176D9218AB";
  level.scr_eventanim["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_AC820D80ABE3BF69C37FADAE404F1B"] = "_encstr_99D1122A9891D32A50CB6E6856534055CD056663";
  level.scr_anim["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_B8820DA02B1B493BD622078B23CEBA"] = % _encstr_A5F72C6E239CFAADE0EBD82C6E1D6ED10B7323BE1BE4DEABC61A7D93953B5ACE56BEBDAED1AF34B2B1382BE47D23;
  level.scr_animname["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_B8820DA02B1B493BD622078B23CEBA"] = "_encstr_A5F72C6E239CFAADE0EBD82C6E1D6ED10B7323BE1BE4DEABC61A7D93953B5ACE56BEBDAED1AF34B2B1382BE47D23";
  level.scr_eventanim["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_B8820DA02B1B493BD622078B23CEBA"] = "_encstr_9BD1126337EBB1C9F6EAC634FA1AD7EDAB3AD764";
  level.scr_anim["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_8E820DEFE7739820329DE3394437EA"] = % _encstr_86F72CCD9127D76BC1FA6385B91DE6A316E623BEC6C9DBD51B34FAC956EC4B9DACAF7BAB1DAF1A2BC60E5993EB99;
  level.scr_animname["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_8E820DEFE7739820329DE3394437EA"] = "_encstr_86F72CCD9127D76BC1FA6385B91DE6A316E623BEC6C9DBD51B34FAC956EC4B9DACAF7BAB1DAF1A2BC60E5993EB99";
  level.scr_eventanim["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_8E820DEFE7739820329DE3394437EA"] = "_encstr_83D1121B37AF8D27B7D536A1D70DEBB7BA47F566";
  level.scr_anim["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_A1820DB703B31F1135889F22F07EA3"] = % _encstr_BAF72CE62327F5D6C1AF635837E8CDD10BB932EBD8E4F6AB8D86FAC956B3D2B3CAEB7BAB477D86B21BC1954EEB1A;
  level.scr_animname["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_A1820DB703B31F1135889F22F07EA3"] = "_encstr_BAF72CE62327F5D6C1AF635837E8CDD10BB932EBD8E4F6AB8D86FAC956B3D2B3CAEB7BAB477D86B21BC1954EEB1A";
  level.scr_eventanim["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_A1820DB703B31F1135889F22F07EA3"] = "_encstr_A3D1128BA0D6236397F58E44C8A189E73BA3CF12";
  level.scr_anim["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_A3820DDEAE8EFAD89CB75D6C1AD7B1"] = % _encstr_8CF72CF02AF2CFD8BBDFB13FEB73C3519E32C009328AF793DF68D0AED513C8ED47C920D0DB6931A99B20C5A6972A;
  level.scr_animname["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_A3820DDEAE8EFAD89CB75D6C1AD7B1"] = "_encstr_8CF72CF02AF2CFD8BBDFB13FEB73C3519E32C009328AF793DF68D0AED513C8ED47C920D0DB6931A99B20C5A6972A";
  level.scr_eventanim["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_A3820DDEAE8EFAD89CB75D6C1AD7B1"] = "_encstr_A1D1121BE6F58D4EB7AE1B34FA0DAFB7578ED76C";
  level.scr_anim["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_8F820D205B8B06B342D8381EC0E80E"] = % _encstr_9AF72C735AD3B8781257D93B83FB40F54752297EB2BBE8E0EE48B715BD23E8BCFFB9C0A3ABB793A84548DB0D9F5B;
  level.scr_animname["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_8F820D205B8B06B342D8381EC0E80E"] = "_encstr_9AF72C735AD3B8781257D93B83FB40F54752297EB2BBE8E0EE48B715BD23E8BCFFB9C0A3ABB793A84548DB0D9F5B";
  level.scr_eventanim["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_8F820D205B8B06B342D8381EC0E80E"] = "_encstr_A7D112D5766FE2AA3048675301084FEAC30D919B";
  level.scr_anim["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_87820D20CBD32FE1FA3FD068CB3F52"] = % _encstr_ABF72C6E9193AFDA83F5B1859BE837E8C2B98CD7369CDBBAC643BE4E2BD94BCEB2FA7BD5A3AF86951B0E56C9F5E0;
  level.scr_animname["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_87820D20CBD32FE1FA3FD068CB3F52"] = "_encstr_ABF72C6E9193AFDA83F5B1859BE837E8C2B98CD7369CDBBAC643BE4E2BD94BCEB2FA7BD5A3AF86951B0E56C9F5E0";
  level.scr_eventanim["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_87820D20CBD32FE1FA3FD068CB3F52"] = "_encstr_AFD11236E67DC627BDAED8A1AFD0F57BBAD1F583";
  level.scr_anim["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_96820DE00BC3AF1F9658532243B9E2"] = % _encstr_A7F72C9B32E47DAD0EEB1B16DC1DCD47B0E623BED8397BEA36D0BE9CB2ECD2D9B27DF6EA47FA34958DE056C9AF27;
  level.scr_animname["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_96820DE00BC3AF1F9658532243B9E2"] = "_encstr_A7F72C9B32E47DAD0EEB1B16DC1DCD47B0E623BED8397BEA36D0BE9CB2ECD2D9B27DF6EA47FA34958DE056C9AF27";
  level.scr_eventanim["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_96820DE00BC3AF1F9658532243B9E2"] = "_encstr_9AD112B5160F82CA5068477321E8AF0AE32DF178";
  level.scr_anim["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_8FCB0CB4B9BE3627DEEA3643EB89"] = % _encstr_B6EF3093299ED7F53007ACA937783A234FC05AD95176DF2B9071E7A223B044E3E59E02523E4CA7631041D5BCBFA28152AF3B;
  level.scr_animname["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_8FCB0CB4B9BE3627DEEA3643EB89"] = "_encstr_B6EF3093299ED7F53007ACA937783A234FC05AD95176DF2B9071E7A223B044E3E59E02523E4CA7631041D5BCBFA28152AF3B";
  level.scr_eventanim["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_8FCB0CB4B9BE3627DEEA3643EB89"] = "_encstr_917D1363B9BEB193DED5C61AD7777DB49BAF89689B";
  level.scr_anim["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_B8CB0CB7CDA03A7A78532EF40E4A"] = % _encstr_8DDB2C9B464E7DB51CD71B2CB91DE6A385CD32FA6C39B7AE6C34EB4EAC67969D2BEB4BDCF5DD7BD59B8C5619BE46;
  level.scr_animname["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_B8CB0CB7CDA03A7A78532EF40E4A"] = "_encstr_8DDB2C9B464E7DB51CD71B2CB91DE6A385CD32FA6C39B7AE6C34EB4EAC67969D2BEB4BDCF5DD7BD59B8C5619BE46";
  level.scr_eventanim["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_B8CB0CB7CDA03A7A78532EF40E4A"] = "_encstr_8F851163DCBEB139EDAE6C1AEB77D75AB9BE46";
  level.scr_anim["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_ACCB0CD2E6EB1B27B7D5D886D766"] = % _encstr_A3EA304B057B4F75C9D9DA0290E92A3BF1F8A4EF2EC3C73B9778D12BD835E47B29C82146A80B7FC3A5707A4221D75182C663;
  level.scr_animname["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_ACCB0CD2E6EB1B27B7D5D886D766"] = "_encstr_A3EA304B057B4F75C9D9DA0290E92A3BF1F8A4EF2EC3C73B9778D12BD835E47B29C82146A80B7FC3A5707A4221D75182C663";
  level.scr_eventanim["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_ACCB0CD2E6EB1B27B7D5D886D766"] = "_encstr_BA7D137992B98F0B2FEF28685F6FE6D312314EDCF8";
  level.scr_anim["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_A1CB0C64F0C15B1398C3AFBBAF1D"] = % _encstr_B6EF3093299ED7F53007ACA937783A234FC05AD95176DF2B9071E7A223B044E3E59E02523E4CA7631041D5BCBFA28152AF3B;
  level.scr_animname["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_A1CB0C64F0C15B1398C3AFBBAF1D"] = "_encstr_B6EF3093299ED7F53007ACA937783A234FC05AD95176DF2B9071E7A223B044E3E59E02523E4CA7631041D5BCBFA28152AF3B";
  level.scr_eventanim["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_A1CB0C64F0C15B1398C3AFBBAF1D"] = "_encstr_917D1363B9BEB193DED5C61AD7777DB49BAF89689B";
  level.scr_anim["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_A3CB0CCA90F0EFFA109B1BE83722"] = % _encstr_A3EA304B057B4F75C9D9DA0290E92A3BF1F8A4EF2EC3C73B9778D12BD835E47B29C82146A80B7FC3A5707A4221D75182C663;
  level.scr_animname["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_A3CB0CCA90F0EFFA109B1BE83722"] = "_encstr_A3EA304B057B4F75C9D9DA0290E92A3BF1F8A4EF2EC3C73B9778D12BD835E47B29C82146A80B7FC3A5707A4221D75182C663";
  level.scr_eventanim["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_A3CB0CCA90F0EFFA109B1BE83722"] = "_encstr_BA7D137992B98F0B2FEF28685F6FE6D312314EDCF8";
  level.scr_anim["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_93CB0C67B02EABEB0F6D06FC4097"] = % _encstr_B6EF3093299ED7F53007ACA937783A234FC05AD95176DF2B9071E7A223B044E3E59E02523E4CA7631041D5BCBFA28152AF3B;
  level.scr_animname["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_93CB0C67B02EABEB0F6D06FC4097"] = "_encstr_B6EF3093299ED7F53007ACA937783A234FC05AD95176DF2B9071E7A223B044E3E59E02523E4CA7631041D5BCBFA28152AF3B";
  level.scr_eventanim["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_93CB0C67B02EABEB0F6D06FC4097"] = "_encstr_917D1363B9BEB193DED5C61AD7777DB49BAF89689B";
  level.scr_anim["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_9BCB0CF70361AE18E51B904B8140"] = % _encstr_B6DB2CDC1927F5B50ED7C60BDCE8CDA32CE6C87D6C4EB7EA6C1AD7E4563B5ACE59D7A5DCEBEEDBAE9B23B2C8F50E;
  level.scr_animname["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_9BCB0CF70361AE18E51B904B8140"] = "_encstr_B6DB2CDC1927F5B50ED7C60BDCE8CDA32CE6C87D6C4EB7EA6C1AD7E4563B5ACE59D7A5DCEBEEDBAE9B23B2C8F50E";
  level.scr_eventanim["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_9BCB0CF70361AE18E51B904B8140"] = "_encstr_9285114AE3201F0AE04BCBD80778197FD01E87";
  level.scr_anim["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_83CB0C58920FDEF8BD159F811770"] = % _encstr_A3EA304B057B4F75C9D9DA0290E92A3BF1F8A4EF2EC3C73B9778D12BD835E47B29C82146A80B7FC3A5707A4221D75182C663;
  level.scr_animname["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_83CB0C58920FDEF8BD159F811770"] = "_encstr_A3EA304B057B4F75C9D9DA0290E92A3BF1F8A4EF2EC3C73B9778D12BD835E47B29C82146A80B7FC3A5707A4221D75182C663";
  level.scr_eventanim["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_83CB0C58920FDEF8BD159F811770"] = "_encstr_BA7D137992B98F0B2FEF28685F6FE6D312314EDCF8";
  level.scr_anim["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_ACE60E9C92708A6906A830DB0BFBD16B"] = % _encstr_A53E32F349FEB79550678C891758DAC3AFE07AB931563FCBB0118782C3906483C57E7222182F4783F843BE9CEB68A166607BD92F;
  level.scr_animname["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_ACE60E9C92708A6906A830DB0BFBD16B"] = "_encstr_A53E32F349FEB79550678C891758DAC3AFE07AB931563FCBB0118782C3906483C57E7222182F4783F843BE9CEB68A166607BD92F";
  level.scr_eventanim["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_ACE60E9C92708A6906A830DB0BFBD16B"] = "_encstr_A72E1336CDF56C39F6AEB143D7DDD78DE07D4CA1CD";
  level.scr_anim["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_B8E60E9CF5119A8FB9485F3FE8F05737"] = % _encstr_B2A12E331A93F838521799FB433B80358712693EF27B2820AE08F7D57D63A8FC3F79E0A0DACB4878450D8DE165CF5166;
  level.scr_animname["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_B8E60E9CF5119A8FB9485F3FE8F05737"] = "_encstr_B2A12E331A93F838521799FB433B80358712693EF27B2820AE08F7D57D63A8FC3F79E0A0DACB4878450D8DE165CF5166";
  level.scr_eventanim["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_B8E60E9CF5119A8FB9485F3FE8F05737"] = "_encstr_A29D11C69BF5D89CF657B186D7DD7D63C1AF91";
  level.scr_anim["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_8EE60EC0AA5B551906AA0F23A3AC5106"] = % _encstr_840532372393F5DAE0AFD885378EE6A358DC8CAFC69CDEAB361AD793B29D5A3B2BBED8DBBD0EFABBDEBA9B91CAC8AFCCFA63EB72;
  level.scr_animname["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_8EE60EC0AA5B551906AA0F23A3AC5106"] = "_encstr_840532372393F5DAE0AFD885378EE6A358DC8CAFC69CDEAB361AD793B29D5A3B2BBED8DBBD0EFABBDEBA9B91CAC8AFCCFA63EB72";
  level.scr_eventanim["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_8EE60EC0AA5B551906AA0F23A3AC5106"] = "_encstr_A92E13ED4E47CA72E8A09FBBD9C36782B1F0A2F313";
  level.scr_anim["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_BEE60E9710B85DC9877E950BEEB981B4"] = % _encstr_A53E32F349FEB79550678C891758DAC3AFE07AB931563FCBB0118782C3906483C57E7222182F4783F843BE9CEB68A166607BD92F;
  level.scr_animname["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_BEE60E9710B85DC9877E950BEEB981B4"] = "_encstr_A53E32F349FEB79550678C891758DAC3AFE07AB931563FCBB0118782C3906483C57E7222182F4783F843BE9CEB68A166607BD92F";
  level.scr_eventanim["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_BEE60E9710B85DC9877E950BEEB981B4"] = "_encstr_A72E1336CDF56C39F6AEB143D7DDD78DE07D4CA1CD";
  level.scr_anim["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_82E60EB446B156D78D27EDD51B43AF63"] = % _encstr_840532372393F5DAE0AFD885378EE6A358DC8CAFC69CDEAB361AD793B29D5A3B2BBED8DBBD0EFABBDEBA9B91CAC8AFCCFA63EB72;
  level.scr_animname["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_82E60EB446B156D78D27EDD51B43AF63"] = "_encstr_840532372393F5DAE0AFD885378EE6A358DC8CAFC69CDEAB361AD793B29D5A3B2BBED8DBBD0EFABBDEBA9B91CAC8AFCCFA63EB72";
  level.scr_eventanim["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_82E60EB446B156D78D27EDD51B43AF63"] = "_encstr_A92E13ED4E47CA72E8A09FBBD9C36782B1F0A2F313";
  level.scr_anim["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_BDE60EB0DA2B256956FA5F93137CA1D4"] = % _encstr_A53E32F349FEB79550678C891758DAC3AFE07AB931563FCBB0118782C3906483C57E7222182F4783F843BE9CEB68A166607BD92F;
  level.scr_animname["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_BDE60EB0DA2B256956FA5F93137CA1D4"] = "_encstr_A53E32F349FEB79550678C891758DAC3AFE07AB931563FCBB0118782C3906483C57E7222182F4783F843BE9CEB68A166607BD92F";
  level.scr_eventanim["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_BDE60EB0DA2B256956FA5F93137CA1D4"] = "_encstr_A72E1336CDF56C39F6AEB143D7DDD78DE07D4CA1CD";
  level.scr_anim["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_87E60E96C86395D7B1E4DEEAC686D7C1"] = % _encstr_9AA12E5B69AA878367285A41B76B2B33AFF2D907FF237D4FBE4C096D537BE0FB63AF352870814174E8905801B58B5960;
  level.scr_animname["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_87E60E96C86395D7B1E4DEEAC686D7C1"] = "_encstr_9AA12E5B69AA878367285A41B76B2B33AFF2D907FF237D4FBE4C096D537BE0FB63AF352870814174E8905801B58B5960";
  level.scr_eventanim["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_87E60E96C86395D7B1E4DEEAC686D7C1"] = "_encstr_AF9D113B7E1F37F33F5BF6514E20910840670E";
  level.scr_anim["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_96E60E933FE2EBF67BDB70A877980EAB"] = % _encstr_840532372393F5DAE0AFD885378EE6A358DC8CAFC69CDEAB361AD793B29D5A3B2BBED8DBBD0EFABBDEBA9B91CAC8AFCCFA63EB72;
  level.scr_animname["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_96E60E933FE2EBF67BDB70A877980EAB"] = "_encstr_840532372393F5DAE0AFD885378EE6A358DC8CAFC69CDEAB361AD793B29D5A3B2BBED8DBBD0EFABBDEBA9B91CAC8AFCCFA63EB72";
  level.scr_eventanim["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_96E60E933FE2EBF67BDB70A877980EAB"] = "_encstr_A92E13ED4E47CA72E8A09FBBD9C36782B1F0A2F313";
  level.scr_anim["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_AC820D80ABE3BF69C37FADAE404F1B"] = % _encstr_A2E6311BA1164F6DB8FF2431BFC0B2AB3758E241A9EE57A308F91F2ABB38FC1B6D16EA6BD3D07F1D40CD5C05414992772D8EE7;
  level.scr_animname["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_AC820D80ABE3BF69C37FADAE404F1B"] = "_encstr_A2E6311BA1164F6DB8FF2431BFC0B2AB3758E241A9EE57A308F91F2ABB38FC1B6D16EA6BD3D07F1D40CD5C05414992772D8EE7";
  level.scr_eventanim["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_AC820D80ABE3BF69C37FADAE404F1B"] = "_encstr_971E14B463373F1BB7DB72849937CEBDAB45B91FB23F";
  level.scr_anim["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_B8820DA02B1B493BD622078B23CEBA"] = % _encstr_86A02D4EEFD34F40989FB8D807B4DB418A154DC0866BE78B735B195827EE508D12F1B05DDB516FB04DABC8E80B2F03;
  level.scr_animname["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_B8820DA02B1B493BD622078B23CEBA"] = "_encstr_86A02D4EEFD34F40989FB8D807B4DB418A154DC0866BE78B735B195827EE508D12F1B05DDB516FB04DABC8E80B2F03";
  level.scr_eventanim["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_B8820DA02B1B493BD622078B23CEBA"] = "_encstr_847B1258F76759D5DA7BAE23D97347ED95033922";
  level.scr_anim["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_8E820DEFE7739820329DE3394437EA"] = % _encstr_86AD31CD4639FAAD38BEB1C29B8EB98EB0B919EBB14EDE578D34EB4EACD95A3BB2FA7BAEA3EBDDDEBA37232BC8EB66BE637D93;
  level.scr_animname["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_8E820DEFE7739820329DE3394437EA"] = "_encstr_86AD31CD4639FAAD38BEB1C29B8EB98EB0B919EBB14EDE578D34EB4EACD95A3BB2FA7BAEA3EBDDDEBA37232BC8EB66BE637D93";
  level.scr_eventanim["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_8E820DEFE7739820329DE3394437EA"] = "_encstr_831E147B2F68F2B2C01B76BC7628D78AD5892F8E5D83";
  level.scr_anim["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_A1820DB703B31F1135889F22F07EA3"] = % _encstr_A2E6311BA1164F6DB8FF2431BFC0B2AB3758E241A9EE57A308F91F2ABB38FC1B6D16EA6BD3D07F1D40CD5C05414992772D8EE7;
  level.scr_animname["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_A1820DB703B31F1135889F22F07EA3"] = "_encstr_A2E6311BA1164F6DB8FF2431BFC0B2AB3758E241A9EE57A308F91F2ABB38FC1B6D16EA6BD3D07F1D40CD5C05414992772D8EE7";
  level.scr_eventanim["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_A1820DB703B31F1135889F22F07EA3"] = "_encstr_971E14B463373F1BB7DB72849937CEBDAB45B91FB23F";
  level.scr_anim["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_A3820DDEAE8EFAD89CB75D6C1AD7B1"] = % _encstr_86AD31CD4639FAAD38BEB1C29B8EB98EB0B919EBB14EDE578D34EB4EACD95A3BB2FA7BAEA3EBDDDEBA37232BC8EB66BE637D93;
  level.scr_animname["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_A3820DDEAE8EFAD89CB75D6C1AD7B1"] = "_encstr_86AD31CD4639FAAD38BEB1C29B8EB98EB0B919EBB14EDE578D34EB4EACD95A3BB2FA7BAEA3EBDDDEBA37232BC8EB66BE637D93";
  level.scr_eventanim["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_A3820DDEAE8EFAD89CB75D6C1AD7B1"] = "_encstr_831E147B2F68F2B2C01B76BC7628D78AD5892F8E5D83";
  level.scr_anim["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_8F820D205B8B06B342D8381EC0E80E"] = % _encstr_A2E6311BA1164F6DB8FF2431BFC0B2AB3758E241A9EE57A308F91F2ABB38FC1B6D16EA6BD3D07F1D40CD5C05414992772D8EE7;
  level.scr_animname["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_8F820D205B8B06B342D8381EC0E80E"] = "_encstr_A2E6311BA1164F6DB8FF2431BFC0B2AB3758E241A9EE57A308F91F2ABB38FC1B6D16EA6BD3D07F1D40CD5C05414992772D8EE7";
  level.scr_eventanim["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_8F820D205B8B06B342D8381EC0E80E"] = "_encstr_971E14B463373F1BB7DB72849937CEBDAB45B91FB23F";
  level.scr_anim["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_87820D20CBD32FE1FA3FD068CB3F52"] = % _encstr_8FA02DC3D015395FEB70B4B17E337FBB5BF83A9940ADEDF761C3BFBA1D5BDFC38BD9F2B3601FA3E79B388CA5A586A2;
  level.scr_animname["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_87820D20CBD32FE1FA3FD068CB3F52"] = "_encstr_8FA02DC3D015395FEB70B4B17E337FBB5BF83A9940ADEDF761C3BFBA1D5BDFC38BD9F2B3601FA3E79B388CA5A586A2";
  level.scr_eventanim["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_87820D20CBD32FE1FA3FD068CB3F52"] = "_encstr_BD7B129913D84F168A7B57D02968AE074374C6E3";
  level.scr_anim["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_96820DE00BC3AF1F9658532243B9E2"] = % _encstr_86AD31CD4639FAAD38BEB1C29B8EB98EB0B919EBB14EDE578D34EB4EACD95A3BB2FA7BAEA3EBDDDEBA37232BC8EB66BE637D93;
  level.scr_animname["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_96820DE00BC3AF1F9658532243B9E2"] = "_encstr_86AD31CD4639FAAD38BEB1C29B8EB98EB0B919EBB14EDE578D34EB4EACD95A3BB2FA7BAEA3EBDDDEBA37232BC8EB66BE637D93";
  level.scr_eventanim["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_96820DE00BC3AF1F9658532243B9E2"] = "_encstr_831E147B2F68F2B2C01B76BC7628D78AD5892F8E5D83";
  level.scr_anim["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_BDF50BEAB0D0431AF04DFDFFCB"] = % _encstr_ABF42BBF503B27AA612895CE264183B4E1A87B8788535FA293C01AC78C038B6DCE08DBFF18289DEAF9E5677157;
  level.scr_animname["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_BDF50BEAB0D0431AF04DFDFFCB"] = "_encstr_ABF42BBF503B27AA612895CE264183B4E1A87B8788535FA293C01AC78C038B6DCE08DBFF18289DEAF9E5677157";
  level.scr_eventanim["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_BDF50BEAB0D0431AF04DFDFFCB"] = "_encstr_B138108197A967F007F5D9965BCFD0904106";
  level.scr_anim["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_82F50B6203874B5DC0A5C95FDA"] = % _encstr_93F42BFE2C83A68B4AA9636043636F1B27DE8D60903BE8C577B1C858EBFC2D71877137F80F27133D1F7A708187;
  level.scr_animname["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_82F50B6203874B5DC0A5C95FDA"] = "_encstr_93F42BFE2C83A68B4AA9636043636F1B27DE8D60903BE8C577B1C858EBFC2D71877137F80F27133D1F7A708187";
  level.scr_eventanim["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_82F50B6203874B5DC0A5C95FDA"] = "_encstr_A23810C12A0111A3875BF029179F98756902";
  level.scr_anim["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_92F50BA5B9BE0EC97B7395AF99"] = % _encstr_A1F42BDC23C9F5B507EB1BB0B9D19B47B0E619F5E09CBDB9CAFA27B2EC5AD956EBB4DCFADD7BEA73915946D799;
  level.scr_animname["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_92F50BA5B9BE0EC97B7395AF99"] = "_encstr_A1F42BDC23C9F5B507EB1BB0B9D19B47B0E619F5E09CBDB9CAFA27B2EC5AD956EBB4DCFADD7BEA73915946D799";
  level.scr_eventanim["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_92F50BA5B9BE0EC97B7395AF99"] = "_encstr_953810C0A8102005E83DB70933E6D8385603";
  level.scr_anim["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_AAF50BCFC8DF48D2DF75A8D8CA"] = % _encstr_8FF42BA3319B791BBFCF73419B0B1EEBC2301FD12B0B90BB21F13B9F43780D63E990C80E03C02FD8CDCA8B0991;
  level.scr_animname["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_AAF50BCFC8DF48D2DF75A8D8CA"] = "_encstr_8FF42BA3319B791BBFCF73419B0B1EEBC2301FD12B0B90BB21F13B9F43780D63E990C80E03C02FD8CDCA8B0991";
  level.scr_eventanim["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_AAF50BCFC8DF48D2DF75A8D8CA"] = "_encstr_AF3810293F01CF686F9DA1FEC3777808B98A";
  level.scr_anim["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_88F50B96B9FAE0E4BD3795F58D"] = % _encstr_ACF42BA7F59A679DA32FCB619E8BE803E0E8CD499B0AD8E88FE950B9A42DBB2D09CB65EFDBBF7BEB0CF979917E;
  level.scr_animname["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_88F50B96B9FAE0E4BD3795F58D"] = "_encstr_ACF42BA7F59A679DA32FCB619E8BE803E0E8CD499B0AD8E88FE950B9A42DBB2D09CB65EFDBBF7BEB0CF979917E";
  level.scr_eventanim["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_88F50B96B9FAE0E4BD3795F58D"] = "_encstr_8C3810F1BBB7C3350D3AC8118329DBD85F06";
  level.scr_anim["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_96F50B23F6E793457D4A9841B7"] = % _encstr_91F42B7B354B7FA519092AF240391A6B81A8F4DF5713F7ADEBF1D38A707B13E7BE8376A76C5847F58108BA2112;
  level.scr_animname["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_96F50B23F6E793457D4A9841B7"] = "_encstr_91F42B7B354B7FA519092AF240391A6B81A8F4DF5713F7ADEBF1D38A707B13E7BE8376A76C5847F58108BA2112";
  level.scr_eventanim["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_96F50B23F6E793457D4A9841B7"] = "_encstr_A93810BABFC9E06BEA0E9FEFA4C7C0E8A7BC";
  level.scr_anim["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_8AF50B4BCDEBE0C9B7CDB2FA83"] = % _encstr_8EF42B0E948857723F28BC5E706463AC7F60D341BF435AE081F11D85E34BB06D09A768E9685705102ABAD057B3;
  level.scr_animname["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_8AF50B4BCDEBE0C9B7CDB2FA83"] = "_encstr_8EF42B0E948857723F28BC5E706463AC7F60D341BF435AE081F11D85E34BB06D09A768E9685705102ABAD057B3";
  level.scr_eventanim["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_8AF50B4BCDEBE0C9B7CDB2FA83"] = "_encstr_843810CDBB29A0EB701D2FCF473002E6816A";
  level.scr_anim["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_85F50B2B056979DBFF33A88196"] = % _encstr_B8F42BC812CAE7F0A33759C7F35BFB49F65AE821EB62CFE8AF0F5ECDEE170323D1B23099F37D2320835D6D2889;
  level.scr_animname["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_85F50B2B056979DBFF33A88196"] = "_encstr_B8F42BC812CAE7F0A33759C7F35BFB49F65AE821EB62CFE8AF0F5ECDEE170323D1B23099F37D2320835D6D2889";
  level.scr_eventanim["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_85F50B2B056979DBFF33A88196"] = "_encstr_8A38104B60167023D7384FC99C8FAA26BEAA";
  level.scr_anim["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_8BA90D699DFD12C6C3CB886691CF0E"] = % _encstr_95C32D4B057B4F75C9D9DA0290E92A3BF1F8A4EFA7C3C7FD9BC1035A400B23376E5127473F0E1F4593206A52F80FCA;
  level.scr_animname["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_8BA90D699DFD12C6C3CB886691CF0E"] = "_encstr_95C32D4B057B4F75C9D9DA0290E92A3BF1F8A4EFA7C3C7FD9BC1035A400B23376E5127473F0E1F4593206A52F80FCA";
  level.scr_eventanim["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_8BA90D699DFD12C6C3CB886691CF0E"] = "_encstr_B80E1052B7C19BC0DD4675AF0FEFB4D31727";
  level.scr_anim["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_83A90DDBE5347A4FC0B3B7450AA192"] = % _encstr_A6C32D1BB3CBC1A7B9A8C9A683E5F0D4FF3813D7381B7AAB8DF74D1DDB5B4C2A3989088DA270F730931B0B778FB102;
  level.scr_animname["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_83A90DDBE5347A4FC0B3B7450AA192"] = "_encstr_A6C32D1BB3CBC1A7B9A8C9A683E5F0D4FF3813D7381B7AAB8DF74D1DDB5B4C2A3989088DA270F730931B0B778FB102";
  level.scr_eventanim["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_83A90DDBE5347A4FC0B3B7450AA192"] = "_encstr_8F0E1063E6D7834EB7E695D7DDD71B07FA64";
  level.scr_anim["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_9BA90DA54663597DE039BD37ACFA66"] = % _encstr_B6C32D927DB5A1355399DBF7E00BE3DB6B80DF01DF1DFA4E99B1ABEF2080BEB2BF29E585471FB387A340CB17883E33;
  level.scr_animname["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_9BA90DA54663597DE039BD37ACFA66"] = "_encstr_B6C32D927DB5A1355399DBF7E00BE3DB6B80DF01DF1DFA4E99B1ABEF2080BEB2BF29E585471FB387A340CB17883E33";
  level.scr_eventanim["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_9BA90DA54663597DE039BD37ACFA66"] = "_encstr_910E10E943F9A81E9FFAB9E67387D96001FB";
  level.scr_anim["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_99A90DC9AD100F417118729A58D753"] = % _encstr_BAC32DBAA7F88EC503A9603AD2430203300E0D2FE2C3C086C5EEE2D9EE50AB60DFEB7D27D7C7FFE0BDDBD3928907DB;
  level.scr_animname["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_99A90DC9AD100F417118729A58D753"] = "_encstr_BAC32DBAA7F88EC503A9603AD2430203300E0D2FE2C3C086C5EEE2D9EE50AB60DFEB7D27D7C7FFE0BDDBD3928907DB";
  level.scr_eventanim["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_99A90DC9AD100F417118729A58D753"] = "_encstr_920E10A5067FC3BA20A04F9F501E6C0BA73D";
  level.scr_anim["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_A7A90DD246D859F51C4EB7B9ACAF8D"] = % _encstr_A2C32D628D2531A5C3296B67707B734BDB102F916F8D8AFE09411B7FB0304E02CFB97515D7AF4337D3D05B6738AE46;
  level.scr_animname["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_A7A90DD246D859F51C4EB7B9ACAF8D"] = "_encstr_A2C32D628D2531A5C3296B67707B734BDB102F916F8D8AFE09411B7FB0304E02CFB97515D7AF4337D3D05B6738AE46";
  level.scr_eventanim["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_A7A90DD246D859F51C4EB7B9ACAF8D"] = "_encstr_8E0E1011FAD1C15377AB20F927AF68393933";
  level.scr_anim["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_A1A90D2329D492E9279B45D30DB707"] = % _encstr_B1C32D9B23E47DD638FA1B2CB98E37E8853723D7E093EDDC957D9C95CE4B3B56FAB1BDF607F5EEDEABCD91ACC87DE6;
  level.scr_animname["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_A1A90D2329D492E9279B45D30DB707"] = "_encstr_B1C32D9B23E47DD638FA1B2CB98E37E8853723D7E093EDDC957D9C95CE4B3B56FAB1BDF607F5EEDEABCD91ACC87DE6";
  level.scr_eventanim["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_A1A90D2329D492E9279B45D30DB707"] = "_encstr_BE0E10E1F7C907D027D5F9B6BB2F18BF617E";
  level.scr_anim["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_B1A90D174849D277BA904775B04F52"] = % _encstr_97C32D3EEC43664B8A69C0A083A32F5B679ECDA050FBA88537710898ABBCEDB14734C020C8A713FF1B8AB090A2D949;
  level.scr_animname["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_B1A90D174849D277BA904775B04F52"] = "_encstr_97C32D3EEC43664B8A69C0A083A32F5B679ECDA050FBA88537710898ABBCEDB14734C020C8A713FF1B8AB090A2D949";
  level.scr_eventanim["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_B1A90D174849D277BA904775B04F52"] = "_encstr_960E1021A04E283D4F808F9743C91953E160";
  level.scr_anim["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_BAA90D586F1450D083434F4537592B"] = % _encstr_ADC32D13A9F0B1DF579EBA92E3AD6FB3B015BCB71998C58BF5B653DA6B0B03AFE9E93F1F71490B47A5882AC23148F6;
  level.scr_animname["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_BAA90D586F1450D083434F4537592B"] = "_encstr_ADC32D13A9F0B1DF579EBA92E3AD6FB3B015BCB71998C58BF5B653DA6B0B03AFE9E93F1F71490B47A5882AC23148F6";
  level.scr_eventanim["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_BAA90D586F1450D083434F4537592B"] = "_encstr_880E10D8A3C028CD888BA511DF8F54EAD710";
  level.scr_anim["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_8E2B0CFAA0E1D1C3B3409E8D70F3"] = % _encstr_B8092C528480F1904239FC529021C79B5F558CD10B2257529FBED629B4A0CB5F17FF2383FF0BF72B3B51156109EF;
  level.scr_animname["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_8E2B0CFAA0E1D1C3B3409E8D70F3"] = "_encstr_B8092C528480F1904239FC529021C79B5F558CD10B2257529FBED629B4A0CB5F17FF2383FF0BF72B3B51156109EF";
  level.scr_eventanim["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_8E2B0CFAA0E1D1C3B3409E8D70F3"] = "_encstr_A1EF11A00F9FB35D423515304B795FDB1C27C2";
  level.scr_anim["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_BE2B0C37EDDB2F52AD38DA62D145"] = % _encstr_8F092C508A526F781BBFD15F8BD363F17ED260A963EA57502797E645668F8BABA96A107809C39FCB33D465CD779A;
  level.scr_animname["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_BE2B0C37EDDB2F52AD38DA62D145"] = "_encstr_8F092C508A526F781BBFD15F8BD363F17ED260A963EA57502797E645668F8BABA96A107809C39FCB33D465CD779A";
  level.scr_eventanim["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_BE2B0C37EDDB2F52AD38DA62D145"] = "_encstr_99EF11E2DFB1716E9048B3C1804FD07883D7FD";
  level.scr_anim["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_922B0C07ADCB29F703327019596E"] = % _encstr_91092C1794721151232958E1F36B16A3CEE6B1D728DA48289F019369CB374C70E94FEB099F437BED8B4A493161A6;
  level.scr_animname["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_922B0C07ADCB29F703327019596E"] = "_encstr_91092C1794721151232958E1F36B16A3CEE6B1D728DA48289F019369CB374C70E94FEB099F437BED8B4A493161A6";
  level.scr_eventanim["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_922B0C07ADCB29F703327019596E"] = "_encstr_ABEF1182D8FF22F3D8184D7FACE6BFAB0121FF";
  level.scr_anim["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_A32B0CBFEBC5098860ED7D873E6A"] = % _encstr_93092C9F1CEA89D9AB91D0797B938E88467EC94F9052C09007892BE153BFC4C811C7638117FB786503D2C1C9E922;
  level.scr_animname["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_A32B0CBFEBC5098860ED7D873E6A"] = "_encstr_93092C9F1CEA89D9AB91D0797B938E88467EC94F9052C09007892BE153BFC4C811C7638117FB786503D2C1C9E922";
  level.scr_eventanim["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_A32B0CBFEBC5098860ED7D873E6A"] = "_encstr_8FEF11641887B35057F557B7CB4FAAFB48C1A3";
  level.scr_anim["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_912B0C68C764E6E92325C05D31BF"] = % _encstr_A7092CFF7C8AE9B9CBF170D9DB336E68E6DE692FF0F22070A7E94B41B31FA4A8B127C3E1B71BD8C5E372A169494A;
  level.scr_animname["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_912B0C68C764E6E92325C05D31BF"] = "_encstr_A7092CFF7C8AE9B9CBF170D9DB336E68E6DE692FF0F22070A7E94B41B31FA4A8B127C3E1B71BD8C5E372A169494A";
  level.scr_eventanim["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_912B0C68C764E6E92325C05D31BF"] = "_encstr_93EF111B3046C09367889F196C5F1A8D8BE9FA";
  level.scr_anim["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_AC2B0CB7EAD1AF38E4F6B9B2EBDC"] = % _encstr_A1092CBB01B6EFCD181FC4D15F60120B573842E12B0EF7C55837D2DD3DA09BB790B02BDB5664BF7B38B9FDA457AA;
  level.scr_animname["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_AC2B0CB7EAD1AF38E4F6B9B2EBDC"] = "_encstr_A1092CBB01B6EFCD181FC4D15F60120B573842E12B0EF7C55837D2DD3DA09BB790B02BDB5664BF7B38B9FDA457AA";
  level.scr_eventanim["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_AC2B0CB7EAD1AF38E4F6B9B2EBDC"] = "_encstr_A3EF11548EDEF3B2F7504AE1B0BF2D3F5360F7";
  level.scr_anim["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_AB2B0CE85B7CF13733A7FDE34FBF"] = % _encstr_99092CB851AAC9F929F890B14FE872E352F062A1D84030C2C5D00BA53D5C2E69BE67C57B3F93E8A35BA511A3B8C8;
  level.scr_animname["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_AB2B0CE85B7CF13733A7FDE34FBF"] = "_encstr_99092CB851AAC9F929F890B14FE872E352F062A1D84030C2C5D00BA53D5C2E69BE67C57B3F93E8A35BA511A3B8C8";
  level.scr_eventanim["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_AB2B0CE85B7CF13733A7FDE34FBF"] = "_encstr_8EEF1119B369388E0F4A0976E3F7C8D87B0739";
  level.scr_anim["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_A72B0CB7D547EB3827ED372BD7E4"] = % _encstr_AB092CDC919C7DAD38F5B1B0E6A39BD1583723F50E93DE372BF539B267D23B95F5DB5D47F5DDB7BADC46CA19AFE4;
  level.scr_animname["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_A72B0CB7D547EB3827ED372BD7E4"] = "_encstr_AB092CDC919C7DAD38F5B1B0E6A39BD1583723F50E93DE372BF539B267D23B95F5DB5D47F5DDB7BADC46CA19AFE4";
  level.scr_eventanim["_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532"]["_encstr_A72B0CB7D547EB3827ED372BD7E4"] = "_encstr_BEEF11F47F61826B1060E2492B6067BB50BF29";
  level.scr_anim["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_BDF50BEAB0D0431AF04DFDFFCB"] = % _encstr_BA9D2ACD329CBEAD07D76385CD8ECDA385E6C8FAE0E4BD9B56BE9CCACE5ACE2BF5B4DCAF342B8D072B27EB89;
  level.scr_animname["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_BDF50BEAB0D0431AF04DFDFFCB"] = "_encstr_BA9D2ACD329CBEAD07D76385CD8ECDA385E6C8FAE0E4BD9B56BE9CCACE5ACE2BF5B4DCAF342B8D072B27EB89";
  level.scr_eventanim["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_BDF50BEAB0D0431AF04DFDFFCB"] = "_encstr_826C10845E0E234207A09A31F80FFC2366E7";
  level.scr_anim["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_82F50B6203874B5DC0A5C95FDA"] = % _encstr_9A9D2A5B69AA878367285A41B76B2B33AFF2D907B3237D23BD81604375BC18991799B5A9F3AB8DF7EDA8D1AD;
  level.scr_animname["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_82F50B6203874B5DC0A5C95FDA"] = "_encstr_9A9D2A5B69AA878367285A41B76B2B33AFF2D907B3237D23BD81604375BC18991799B5A9F3AB8DF7EDA8D1AD";
  level.scr_eventanim["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_82F50B6203874B5DC0A5C95FDA"] = "_encstr_8E6C10719AB1A173578B2BD9BB4F28251952";
  level.scr_anim["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_92F50BA5B9BE0EC97B7395AF99"] = % _encstr_8C9D2AD04305A760B259B053D7330B192AF06989BA83B795E288A36DDB135BD1EF6C860EC879BDCB6DDD97FE;
  level.scr_animname["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_92F50BA5B9BE0EC97B7395AF99"] = "_encstr_8C9D2AD04305A760B259B053D7330B192AF06989BA83B795E288A36DDB135BD1EF6C860EC879BDCB6DDD97FE";
  level.scr_eventanim["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_92F50BA5B9BE0EC97B7395AF99"] = "_encstr_BE6C108DB9FAE0277BE6CABE43F54B9BEB99";
  level.scr_anim["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_AAF50BCFC8DF48D2DF75A8D8CA"] = % _encstr_959D2ABFB9569905E0B64D162B984363A7D56B9739FE42CEA09EC21FE3588E8A10733B1F91AD3AA898C3B133;
  level.scr_animname["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_AAF50BCFC8DF48D2DF75A8D8CA"] = "_encstr_959D2ABFB9569905E0B64D162B984363A7D56B9739FE42CEA09EC21FE3588E8A10733B1F91AD3AA898C3B133";
  level.scr_eventanim["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_AAF50BCFC8DF48D2DF75A8D8CA"] = "_encstr_AC6C1088DB3911BB476EB5A0705F2DE59117";
  level.scr_anim["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_88F50B96B9FAE0E4BD3795F58D"] = % _encstr_B19D2ADCC8E4D76BE07DB158CDA337D1B073327D1C9CB7B9ACD72759B3969DCAAFD2CD7D86591B83CA39EBD8;
  level.scr_animname["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_88F50B96B9FAE0E4BD3795F58D"] = "_encstr_B19D2ADCC8E4D76BE07DB158CDA337D1B073327D1C9CB7B9ACD72759B3969DCAAFD2CD7D86591B83CA39EBD8";
  level.scr_eventanim["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_88F50B96B9FAE0E4BD3795F58D"] = "_encstr_8F6C10D8CDBE83E4EDB9957DA1BED237EB8D";
  level.scr_anim["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_96F50B23F6E793457D4A9841B7"] = % _encstr_A29D2A372327D75B07F53616DC1DCDA3853723D78393EDE6CAD7392B3B4B9DACEB2DCDEB0D59C607569CF5DC;
  level.scr_animname["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_96F50B23F6E793457D4A9841B7"] = "_encstr_A29D2A372327D75B07F53616DC1DCDA3853723D78393EDE6CAD7392B3B4B9DACEB2DCDEB0D59C607569CF5DC";
  level.scr_eventanim["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_96F50B23F6E793457D4A9841B7"] = "_encstr_916C10E46F71925B2050F259B8106F4D199F";
  level.scr_anim["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_8AF50B4BCDEBE0C9B7CDB2FA83"] = % _encstr_839D2AFFF916D945A0F60D566B5883A367152BD779BE820E60DE825F2398CECAD0B3FB5FD16D7AE85803F1F0;
  level.scr_animname["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_8AF50B4BCDEBE0C9B7CDB2FA83"] = "_encstr_839D2AFFF916D945A0F60D566B5883A367152BD779BE820E60DE825F2398CECAD0B3FB5FD16D7AE85803F1F0";
  level.scr_eventanim["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_8AF50B4BCDEBE0C9B7CDB2FA83"] = "_encstr_976C10636E7D8339B7B9ACEB1AEBB4377D1C";
  level.scr_anim["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_85F50B2B056979DBFF33A88196"] = % _encstr_8B9D2A7798F39F122960CD865E19CB7C3950A33FD02B176A6B1852BFC4CB533586C013B7A8A15C53B3A611A0;
  level.scr_animname["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_85F50B2B056979DBFF33A88196"] = "_encstr_8B9D2A7798F39F122960CD865E19CB7C3950A33FD02B176A6B1852BFC4CB533586C013B7A8A15C53B3A611A0";
  level.scr_eventanim["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_85F50B2B056979DBFF33A88196"] = "_encstr_AD6C1036DCF58327DEDC95AF43BE5A37F5E4";
  level.scr_anim["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_8BA90D699DFD12C6C3CB886691CF0E"] = % _encstr_88B52CB9194EEBD60E7D1B2C378E6E470B7391FAC139ED3759F59C2BECA59D59EB8DEDB738FA0D2B36E0CA4EAFC4;
  level.scr_animname["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_8BA90D699DFD12C6C3CB886691CF0E"] = "_encstr_88B52CB9194EEBD60E7D1B2C378E6E470B7391FAC139ED3759F59C2BECA59D59EB8DEDB738FA0D2B36E0CA4EAFC4";
  level.scr_eventanim["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_8BA90D699DFD12C6C3CB886691CF0E"] = "_encstr_A34F1019F2D9C96B4FA338F1A3A76001218A";
  level.scr_anim["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_83A90DDBE5347A4FC0B3B7450AA192"] = % _encstr_81B52CD23DF5E17513D99BB7A0CB231BAB409F419F5D3A8E59F1EBAFE040FEF27FE925C507DF02CD40708F8B91D3;
  level.scr_animname["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_83A90DDBE5347A4FC0B3B7450AA192"] = "_encstr_81B52CD23DF5E17513D99BB7A0CB231BAB409F419F5D3A8E59F1EBAFE040FEF27FE925C507DF02CD40708F8B91D3";
  level.scr_eventanim["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_83A90DDBE5347A4FC0B3B7450AA192"] = "_encstr_934F1091DBD7A3556D5AE831520931FB7F22";
  level.scr_anim["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_9BA90DA54663597DE039BD37ACFA66"] = % _encstr_AAB52CB9469CEBB6E0BE1B2CB9476ED158B923BE074EBDCDACBE272BCED2EC95D7D8F6BD38EB34ACB1E0B24ED766;
  level.scr_animname["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_9BA90DA54663597DE039BD37ACFA66"] = "_encstr_AAB52CB9469CEBB6E0BE1B2CB9476ED158B923BE074EBDCDACBE272BCED2EC95D7D8F6BD38EB34ACB1E0B24ED766";
  level.scr_eventanim["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_9BA90DA54663597DE039BD37ACFA66"] = "_encstr_A14F10E0B22FF04E8A3B432F3B519938971A";
  level.scr_anim["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_99A90DC9AD100F417118729A58D753"] = % _encstr_97B52C6F80EBF77A5118A59E7631D384D1788B57B8030F9243302A97DCD37B5DBE102F0F501E706AB9BFF74A5041;
  level.scr_animname["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_99A90DC9AD100F417118729A58D753"] = "_encstr_97B52C6F80EBF77A5118A59E7631D384D1788B57B8030F9243302A97DCD37B5DBE102F0F501E706AB9BFF74A5041";
  level.scr_eventanim["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_99A90DC9AD100F417118729A58D753"] = "_encstr_8E4F10AC06567B2A6FD8F269D03765B38E4D";
  level.scr_anim["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_A7A90DD246D859F51C4EB7B9ACAF8D"] = % _encstr_85B52C16A4409FF10376A21F1EC3AA609050A3AE919B405DF751FBADB37C6BBD61B02295E19989EB30CBBB7BB8E2;
  level.scr_animname["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_A7A90DD246D859F51C4EB7B9ACAF8D"] = "_encstr_85B52C16A4409FF10376A21F1EC3AA609050A3AE919B405DF751FBADB37C6BBD61B02295E19989EB30CBBB7BB8E2";
  level.scr_eventanim["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_A7A90DD246D859F51C4EB7B9ACAF8D"] = "_encstr_AC4F101AB370237A902D9D5FD9E905EB9883";
  level.scr_anim["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_A1A90D2329D492E9279B45D30DB707"] = % _encstr_8AB52C72E02A270BB08108F6D3343B0BD175EA51BBE565D6BD6FA3ADC3D1DB65485B1832980993930A5317537883;
  level.scr_animname["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_A1A90D2329D492E9279B45D30DB707"] = "_encstr_8AB52C72E02A270BB08108F6D3343B0BD175EA51BBE565D6BD6FA3ADC3D1DB65485B1832980993930A5317537883";
  level.scr_eventanim["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_A1A90D2329D492E9279B45D30DB707"] = "_encstr_914F10520357FFD2A7FB9A0720DF34AB775A";
  level.scr_anim["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_B1A90D174849D277BA904775B04F52"] = % _encstr_84B52CE623E4BEB6C1D7B1C2E63A6EA3B0B991F5E039BD73AC7D9CB2CEB4EC59F5D8F6DB0E7D1AB2D80E56277D83;
  level.scr_animname["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_B1A90D174849D277BA904775B04F52"] = "_encstr_84B52CE623E4BEB6C1D7B1C2E63A6EA3B0B991F5E039BD73AC7D9CB2CEB4EC59F5D8F6DB0E7D1AB2D80E56277D83";
  level.scr_eventanim["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_B1A90D174849D277BA904775B04F52"] = "_encstr_834F10F153A9782ABF3B5291C9091D92AFE3";
  level.scr_anim["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_BAA90D586F1450D083434F4537592B"] = % _encstr_B2B52CF8CA2ED91D208E8A6E5F788ADB71CD925F7BC3CA9208AF528B0BE780026E0CC730D329C83F62908BF0615E;
  level.scr_animname["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_BAA90D586F1450D083434F4537592B"] = "_encstr_B2B52CF8CA2ED91D208E8A6E5F788ADB71CD925F7BC3CA9208AF528B0BE780026E0CC730D329C83F62908BF0615E";
  level.scr_eventanim["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_BAA90D586F1450D083434F4537592B"] = "_encstr_8B4F10C6E6F507E4B7E656BE34EB8D1CBE27";
  level.scr_anim["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_8E2B0CFAA0E1D1C3B3409E8D70F3"] = % _encstr_93022B6F80EBF77A5118A59E7631D384D1788B57B8030F9243302A97DCD37B5DBE08476329F87DFA8135320167;
  level.scr_animname["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_8E2B0CFAA0E1D1C3B3409E8D70F3"] = "_encstr_93022B6F80EBF77A5118A59E7631D384D1788B57B8030F9243302A97DCD37B5DBE08476329F87DFA8135320167";
  level.scr_eventanim["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_8E2B0CFAA0E1D1C3B3409E8D70F3"] = "_encstr_B87711C12A0111A3875BF0296B9F5843DB59E7";
  level.scr_anim["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_BE2B0C37EDDB2F52AD38DA62D145"] = % _encstr_A3022B4F3B8BAFD8C86948E10A9470CD12ABE98F8373D008F571F3797361908DA9C77351A77AAD2018D7FB368A;
  level.scr_animname["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_BE2B0C37EDDB2F52AD38DA62D145"] = "_encstr_A3022B4F3B8BAFD8C86948E10A9470CD12ABE98F8373D008F571F3797361908DA9C77351A77AAD2018D7FB368A";
  level.scr_eventanim["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_BE2B0C37EDDB2F52AD38DA62D145"] = "_encstr_927711D288AF12C3E8C89DAFD3366F9B5151BF";
  level.scr_anim["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_922B0C07ADCB29F703327019596E"] = % _encstr_8F022BE6199CFAD638FA1B169B47B91DB0CD237DC139DE37957D93ACB34B3BCAAFF65DE8D71A951B0ECAE47D99;
  level.scr_animname["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_922B0C07ADCB29F703327019596E"] = "_encstr_8F022BE6199CFAD638FA1B169B47B91DB0CD237DC139DE37957D93ACB34B3BCAAFF65DE8D71A951B0ECAE47D99";
  level.scr_eventanim["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_922B0C07ADCB29F703327019596E"] = "_encstr_BE77116513810853D8B5F72781E8CA4580FECA";
  level.scr_anim["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_A32B0CBFEBC5098860ED7D873E6A"] = % _encstr_9B022B0F7DB8E7ADF06E30E7C77CE8B36E63344E7F8BC758B878E6A0A37843C291C837832940E248A89F268925;
  level.scr_animname["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_A32B0CBFEBC5098860ED7D873E6A"] = "_encstr_9B022B0F7DB8E7ADF06E30E7C77CE8B36E63344E7F8BC758B878E6A0A37843C291C837832940E248A89F268925";
  level.scr_eventanim["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_A32B0CBFEBC5098860ED7D873E6A"] = "_encstr_8F77114533A12873F895D747E188EA65A01EEB";
  level.scr_anim["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_912B0C68C764E6E92325C05D31BF"] = % _encstr_AB022B433742C9813B3F91939723D6D8E90D295EDAAA90C84257A593AB1A9CE8BF25B3B389E888F1EB87DDDF52;
  level.scr_animname["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_912B0C68C764E6E92325C05D31BF"] = "_encstr_AB022B433742C9813B3F91939723D6D8E90D295EDAAA90C84257A593AB1A9CE8BF25B3B389E888F1EB87DDDF52";
  level.scr_eventanim["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_912B0C68C764E6E92325C05D31BF"] = "_encstr_AC77117A0BCF0B932FE0F7D6A34117E37BB196";
  level.scr_anim["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_AC2B0CB7EAD1AF38E4F6B9B2EBDC"] = % _encstr_A7022B037D7D579F03A93AC810DB9B1C4B1E2C593B82BDBD0D20434F562B1D6DD7807554B7E89DB368E1F8F93B;
  level.scr_animname["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_AC2B0CB7EAD1AF38E4F6B9B2EBDC"] = "_encstr_A7022B037D7D579F03A93AC810DB9B1C4B1E2C593B82BDBD0D20434F562B1D6DD7807554B7E89DB368E1F8F93B";
  level.scr_eventanim["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_AC2B0CB7EAD1AF38E4F6B9B2EBDC"] = "_encstr_9177116190D820D3A778250F50E768481B1F13";
  level.scr_anim["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_AB2B0CE85B7CF13733A7FDE34FBF"] = % _encstr_A5022B9B46E4FAB5C1FA8D169BD1DCD1B0DC23EBC1C97B37B2EB9CB2ECB49D567DDEAE47BED02BD8E0CA4EBEE0;
  level.scr_animname["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_AB2B0CE85B7CF13733A7FDE34FBF"] = "_encstr_A5022B9B46E4FAB5C1FA8D169BD1DCD1B0DC23EBC1C97B37B2EB9CB2ECB49D567DDEAE47BED02BD8E0CA4EBEE0";
  level.scr_eventanim["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_AB2B0CE85B7CF13733A7FDE34FBF"] = "_encstr_A77711DBF0867053A748DF59A31F5ACD4B2902";
  level.scr_anim["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_A72B0CB7D547EB3827ED372BD7E4"] = % _encstr_86022B37D8B35FD2E9A00D469ED90B3C7910E3FF10EBD72A2B58927F048B13F546B03FDBD1401552596D9AF9CB;
  level.scr_animname["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_A72B0CB7D547EB3827ED372BD7E4"] = "_encstr_86022B37D8B35FD2E9A00D469ED90B3C7910E3FF10EBD72A2B58927F048B13F546B03FDBD1401552596D9AF9CB";
  level.scr_eventanim["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_A72B0CB7D547EB3827ED372BD7E4"] = "_encstr_AB7711A0D7578B4A6F03AD0870B9B8459DB727";
  scripts\common\anim::addnotetrack_customfunction("_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532", "_encstr_A5501DD1BBC784C8B5CD5327E2DFC8DBBB02AEDBD2C7C8C88FA41759178330", ::_id_12D18);
  scripts\common\anim::addnotetrack_customfunction("_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532", "_encstr_BE3F21F740F94897EF5BFE63437FD8C001BA7345F11B58F0F76393EE9B6F0DE8670589", ::_id_12D19);
  scripts\common\anim::addnotetrack_customfunction("_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532", "_encstr_AF1D29AFC1B07A7770A15829BBC09642FC73D74757CD823410A9D96A71D8C7EBDDB54FDF197F4AEC28F0CF", ::_id_12D1A);
}

_id_12D18(var_0) {
  var_0 playsoundonmovingent("_encstr_A5501DD1BBC784C8B5CD5327E2DFC8DBBB02AEDBD2C7C8C88FA41759178330");
}

_id_12D19(var_0) {
  var_0 playsoundonmovingent("_encstr_BE3F21F740F94897EF5BFE63437FD8C001BA7345F11B58F0F76393EE9B6F0DE8670589");
}

_id_12D1A(var_0) {
  var_0 playsoundonmovingent("_encstr_AF1D29AFC1B07A7770A15829BBC09642FC73D74757CD823410A9D96A71D8C7EBDDB54FDF197F4AEC28F0CF");
}

play_laststand_scripted_anim(var_0, var_1) {
  var_0 endon("_encstr_86660C9CCAEC969DACF58C7BCDB2");
  var_1 endon("_encstr_86660C9CCAEC969DACF58C7BCDB2");
  var_2 = var_0 get_closest_ls_entrance(var_1);

  if(!isDefined(var_2)) {
    var_3 = level.scr_anim["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_A6C505019B7F9B"];
    var_2 = spawnStruct();
    var_2.origin = getstartorigin(var_1.origin, var_1.angles, var_3);
    var_2.angles = getstartangles(var_1.origin, var_1.angles, var_3);
    var_2.xanim_name = "_encstr_8F4C026A";
    var_2.xanim_string = level.scr_animname["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_A6C505019B7F9B"];
  }

  var_0 thread delay_orbit_cam(0.25);
  var_1 thread delay_orbit_cam(1);
  var_4 = scripts\cp_mp\anim_scene::anim_scene_create_actor(var_0, "_encstr_8601114B60167252E5BB8B4788E16A245B48BB", 1, 0, 1);
  var_5 = scripts\cp_mp\anim_scene::anim_scene_create_actor(var_1, "_encstr_A9531236E6AF9C59CE4BCE59EB777B5DDC8C9532", 1, 0, 1);
  var_6 = spawnStruct();
  var_6.origin = var_1.origin;
  var_6.angles = var_1.angles;
  var_1.scenenode = var_6;
  var_0._id_12D13 = var_0.origin;
  var_7 = "_encstr_83BA072175C8D7E951";
  var_8 = "_encstr_9B67062A53DB8EAB";

  if(issubstr(var_2.xanim_string, "_encstr_9207034F26")) {
    var_7 = "_encstr_86BA07D0DA856B4E72";
    var_8 = "_encstr_8B670620BBB546DA";
  }

  var_0 thread handle_stim(var_6, var_1);

  if(istrue(var_0.isjuggernaut))
    var_6 scripts\cp_mp\anim_scene::anim_scene([var_4, var_5], "_encstr_BA1904996B5F" + var_2.xanim_name, 1, 0, undefined, undefined, undefined, 1);
  else
    var_6 scripts\cp_mp\anim_scene::anim_scene([var_4, var_5], "_encstr_BA1904996B5F" + var_2.xanim_name, 1, 0);

  if(!istrue(var_0.class == "_encstr_A6C7065BAC91D28D")) {
    if(istrue(var_0.isjuggernaut))
      var_6 scripts\cp_mp\anim_scene::anim_scene([var_4, var_5], var_7, 0, 0, undefined, undefined, undefined, 1);
    else
      var_6 scripts\cp_mp\anim_scene::anim_scene([var_4, var_5], var_7, 0, 0);
  }

  if(istrue(var_0.isjuggernaut))
    var_6 scripts\cp_mp\anim_scene::anim_scene([var_4, var_5], var_8, 0, 1, undefined, undefined, undefined, 1);
  else
    var_6 scripts\cp_mp\anim_scene::anim_scene([var_4, var_5], var_8, 0, 1);

  var_1 setOrigin(var_6.origin);
}

handle_stim(var_0, var_1) {
  var_2 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", self gettagorigin("_encstr_B2AE148D118849F9F696852B6A0702D239A5810FEBC5"));
  var_2.angles = self gettagangles("_encstr_B2AE148D118849F9F696852B6A0702D239A5810FEBC5");
  var_2 setModel("_encstr_ACEE10EF9D7CCA2930B1E1F388E163434333");
  var_2 linkTo(self, "_encstr_B2AE148D118849F9F696852B6A0702D239A5810FEBC5", (0, 0, 0), (0, 0, 0));
  scripts\engine\utility::_id_143A7("_encstr_86660C9CCAEC969DACF58C7BCDB2", "_encstr_8C8A103333CC6286C00EC38FE1A8D5BAA55B", "_encstr_8D820B49520F0EC02DDE6367EC", "_encstr_8CBE0BD1BED30936AB03C0B02B");

  if(scripts\cp\utility::is_valid_player(1)) {
    var_3 = var_0.origin + (0, 0, 20);
    var_4 = physics_createcontents(["_encstr_959C16B3A1D35B0178338E95889855C22DEF872707F122C4", "_encstr_8DDD1C83862FCDA5D8DCD8ED371DCA73D16EAFB3AC34B46C8DB26C8D2D07", "_encstr_A9D615B373CA8B4BDEFABEFFE0EB656594733F2BF3DBD3", "_encstr_9A171A1CA19737D26CB9B17BDC3A5973A3B9F5165AE6B76E437BBDD1"]);
    var_5 = physics_raycast(var_3, self.origin + (0, 0, 20), var_4, [self, var_1], 1, "_encstr_838C158FAC235780CB6F10381FF25AD76A558896473B11", 1);

    if(isDefined(var_5) && var_5.size > 0)
      self setOrigin(self._id_12D13);
  }

  var_2 delete();
}

get_closest_ls_entrance(var_0) {
  var_1 = ["_encstr_A34C02BB", "_encstr_A707037D74", "_encstr_9707034639", "_encstr_A14C023B", "_encstr_AC4C024A", "_encstr_8F4C026A", "_encstr_914C02DC", "_encstr_BD07033924", "_encstr_930703090A", "_encstr_A507039CC9"];
  var_2 = [];

  for(var_3 = 0; var_3 < var_1.size; var_3++) {
    var_4 = get_ls_entrance(var_0, var_1[var_3]);

    if(isDefined(var_4))
      var_2[var_2.size] = var_4;
  }

  return scripts\engine\utility::getclosest(self.origin, var_2);
}

get_ls_entrance(var_0, var_1) {
  var_2 = level.scr_anim["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_BA1904996B5F" + var_1];
  var_3 = spawnStruct();
  var_3.origin = getstartorigin(var_0.origin, var_0.angles, var_2);
  var_3.angles = getstartangles(var_0.origin, var_0.angles, var_2);
  var_3.xanim_name = var_1;
  var_3.xanim_string = level.scr_animname["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_BA1904996B5F" + var_1];
  var_4 = self.origin + (0, 0, 20);
  var_5 = physics_createcontents(["_encstr_959C16B3A1D35B0178338E95889855C22DEF872707F122C4", "_encstr_8DDD1C83862FCDA5D8DCD8ED371DCA73D16EAFB3AC34B46C8DB26C8D2D07", "_encstr_A9D615B373CA8B4BDEFABEFFE0EB656594733F2BF3DBD3", "_encstr_9A171A1CA19737D26CB9B17BDC3A5973A3B9F5165AE6B76E437BBDD1"]);

  if(!scripts\engine\trace::player_trace_passed(var_4, var_3.origin + (0, 0, 20), self.angles, [self, var_0]))
    return undefined;

  return var_3;
}