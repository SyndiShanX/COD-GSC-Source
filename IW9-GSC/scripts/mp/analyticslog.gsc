/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\analyticslog.gsc
***********************************************/

init() {
  setdvarifuninitialized("enable_analytics_log", 0);
  level.analyticslog = spawnStruct();
  level.analyticslog.nextplayerid = 0;
  level.analyticslog.nextobjectid = 0;
  level.analyticslog.nextdeathid = 0;

  if(!analyticsactive()) {
    return;
  }
  thread watchforconnectedplayers();

  if(analyticslogenabled()) {
    thread logmatchtags();
    thread logallplayerposthink();
    thread logevent_minimapcorners();
  }
}

analyticsactive() {
  if(analyticsspawnlogenabled())
    return 1;

  if(analyticslogenabled())
    return 1;

  return 0;
}

analyticslogenabled() {
  return getdvarint("enable_analytics_log") == 1;
}

getuniqueobjectid() {
  id = level.analyticslog.nextobjectid;
  level.analyticslog.nextobjectid++;
  return id;
}

cacheplayeraction(_id_AA9E39088CE26EEE) {
  if(!isDefined(self.analyticslog.cachedactions))
    self.analyticslog.cachedactions = 0;

  self.analyticslog.cachedactions = self.analyticslog.cachedactions | _id_AA9E39088CE26EEE;
}

watchforconnectedplayers() {
  if(!analyticsactive()) {
    return;
  }
  for(;;) {
    level waittill("connected", player);
    player logevent_playerconnected();
    player thread watchforbasicplayerevents();
    player thread watchforplayermovementevents();
    player thread watchforusermessageevents();
  }
}

watchforbasicplayerevents() {
  self endon("disconnect");

  if(!analyticslogenabled()) {
    return;
  }
  for(;;) {
    _id_ADBD34525F139FC9 = scripts\engine\utility::waittill_any_return_no_endon_death_5("adjustedStance", "jumped", "weapon_fired", "reload_start", "spawned_player");

    if(_id_ADBD34525F139FC9 == "adjustedStance") {
      checkstancestatus();
      continue;
    }

    if(_id_ADBD34525F139FC9 == "jumped") {
      cacheplayeraction(4);
      continue;
    }

    if(_id_ADBD34525F139FC9 == "weapon_fired") {
      cacheplayeraction(8);
      continue;
    }

    if(_id_ADBD34525F139FC9 == "reload_start") {
      cacheplayeraction(16);
      continue;
    }

    if(_id_ADBD34525F139FC9 == "spawned_player") {
      thread logevent_playerspawn();
      thread logevent_spawnpointupdate();
    }
  }
}

watchforplayermovementevents() {
  self endon("disconnect");

  if(!analyticslogenabled()) {
    return;
  }
  for(;;) {
    _id_ADBD34525F139FC9 = scripts\engine\utility::waittill_any_return_no_endon_death_3("doubleJumpBegin", "doubleJumpEnd", "sprint_slide_begin");

    if(_id_ADBD34525F139FC9 == "doubleJumpBegin") {
      cacheplayeraction(64);
      continue;
    }

    if(_id_ADBD34525F139FC9 == "doubleJumpEnd") {
      cacheplayeraction(128);
      continue;
    }

    if(_id_ADBD34525F139FC9 == "sprint_slide_begin")
      cacheplayeraction(256);
  }
}

watchforusermessageevents() {
  self endon("disconnect");

  if(isai(self)) {
    return;
  }
  if(getdvarint("scr_playtest", 0) == 0) {
    return;
  }
  self notifyonplayercommand("log_user_event_start", "+actionslot 3");
  self notifyonplayercommand("log_user_event_end", "-actionslot 3");
  self notifyonplayercommand("log_user_event_generic_event", "+gostand");

  for(;;) {
    self waittill("log_user_event_start");
    _id_EA3E3B2121E6713A = scripts\engine\utility::waittill_any_return_2("log_user_event_end", "log_user_event_generic_event");

    if(isDefined(_id_EA3E3B2121E6713A) && _id_EA3E3B2121E6713A == "log_user_event_generic_event") {
      self iprintlnbold("Event Logged");
      logevent_message(self.name, self.origin, "Generic User Event");
    }
  }
}

checkstancestatus() {
  stance = self getstance();

  if(stance == "prone")
    cacheplayeraction(1);
  else if(stance == "crouch")
    cacheplayeraction(2);
}

logallplayerposthink() {
  if(!analyticslogenabled()) {
    return;
  }
  for(;;) {
    _id_071DF66B50009254 = gettime();
    players = level.players;

    foreach(player in players) {
      if(!shouldplayerlogevents(player)) {
        continue;
      }
      if(isDefined(player) && scripts\mp\utility\player::isreallyalive(player)) {
        player logevent_path();
        player logevent_scoreupdate();
        waitframe();
      }
    }

    wait(max(0.05, 1.5 - (gettime() - _id_071DF66B50009254) / 1000));
  }
}

recordbreadcrumbdata() {
  level endon("game_ended");

  if(getDvar("online_breadcrumbing_enabled") == "0") {
    return;
  }
  if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508())
    _id_2FE6A798E49F4DE6 = getdvarfloat("online_br_breadcrumbing_frequency", 4.0);
  else
    _id_2FE6A798E49F4DE6 = getdvarfloat("online_mp_breadcrumbing_frequency", 2.0);

  scripts\mp\flags::gameflagwait("prematch_done");

  for(;;) {
    _id_D12A341B40354143 = level.players.size;
    starttime = gettime();

    for(startplayer = 0; startplayer < _id_D12A341B40354143; startplayer = startplayer + 20) {
      for(_id_82555C709FBE7CCC = 0; _id_82555C709FBE7CCC < 20; _id_82555C709FBE7CCC++) {
        _id_EF50426720E1DBB8 = startplayer + _id_82555C709FBE7CCC;
        player = level.players[_id_EF50426720E1DBB8];

        if(!isDefined(player)) {
          continue;
        }
        if(!isDefined(player.team)) {
          continue;
        }
        if(!scripts\mp\utility\player::isreallyalive(player)) {
          continue;
        }
        if(player.team == "spectator") {
          continue;
        }
        if(player.sessionstate != "playing") {
          continue;
        }
        if(isai(player)) {
          continue;
        }
        if(!isDefined(player.pers["telemetry"]) || !isDefined(player.pers["telemetry"].life) || !isDefined(player.pers["telemetry"].life._id_6F9BBED303902680)) {
          continue;
        }
        if(!_id_4A6760982B403BAD::_id_0892570944F6B6A2(player)) {
          continue;
        }
        isads = player scripts\mp\utility\player::isplayerads();
        _id_0A086AAA8477D2C6 = scripts\mp\matchdata::gettimefrommatchstart(gettime());
        player recordbreadcrumbdataforplayer(_id_0A086AAA8477D2C6, player.pers["telemetry"].life._id_6F9BBED303902680, isads);
      }

      waitframe();
    }

    _id_48A78BEE31DAA649 = (gettime() - starttime) * 0.001;
    waittime = max(_id_2FE6A798E49F4DE6 - _id_48A78BEE31DAA649, level.framedurationseconds);
    wait(waittime);
  }
}

getpathactionvalue() {
  actions = scripts\engine\utility::ter_op(isDefined(self.analyticslog.cachedactions), self.analyticslog.cachedactions, 0);

  if(self iswallrunning())
    actions = actions | 32;

  return actions;
}

clearpathactionvalue() {
  self.analyticslog.cachedactions = 0;
  checkstancestatus();
}

buildkilldeathactionvalue() {
  _id_818060D4E74DDBA0 = 0;
  stance = self getstance();

  if(stance == "prone")
    _id_818060D4E74DDBA0 = _id_818060D4E74DDBA0 | 1;
  else if(stance == "crouch")
    _id_818060D4E74DDBA0 = _id_818060D4E74DDBA0 | 2;

  if(self isjumping())
    _id_818060D4E74DDBA0 = _id_818060D4E74DDBA0 | 4;

  if(isDefined(self.lastshotfiredtime) && gettime() - self.lastshotfiredtime < 500)
    _id_818060D4E74DDBA0 = _id_818060D4E74DDBA0 | 8;

  if(self isreloading())
    _id_818060D4E74DDBA0 = _id_818060D4E74DDBA0 | 16;

  return _id_818060D4E74DDBA0;
}

buildloadoutstring() {
  _id_63AC6FB2EAA0E5D2 = "archetype=" + self.loadoutarchetype + ";" + "powerPrimary=" + self.loadoutequipmentprimary + ";" + "powerSecondary=" + self.loadoutequipmentsecondary + ";" + "weaponPrimary\t =" + self.primaryweapon + ";" + "weaponSecondary =" + self.secondaryweapon + ";";
  return _id_63AC6FB2EAA0E5D2;
}

buildspawnpointstatestring(spawnpoint) {
  _id_3068716C250A5E58 = "";

  if(isDefined(spawnpoint.lastbucket)) {
    if(isDefined(spawnpoint.lastbucket["allies"]))
      _id_3068716C250A5E58 = _id_3068716C250A5E58 + ("alliesBucket=" + spawnpoint.lastbucket["allies"] + ";");

    if(isDefined(spawnpoint.lastbucket["axis"]))
      _id_3068716C250A5E58 = _id_3068716C250A5E58 + ("axisBucket=" + spawnpoint.lastbucket["axis"] + ";");
  }

  return _id_3068716C250A5E58;
}

logevent_path() {
  if(!shouldplayerlogevents(self)) {
    return;
  }
  _id_53F4B69AE494195A = anglesToForward(self getplayerangles());
  dlog_recordevent("gamemp_path", ["playerid", self.analyticslog.playerid, "x", self.origin[0], "y", self.origin[1], "z", self.origin[2], "gun_orientx", _id_53F4B69AE494195A[0], "gun_orienty", _id_53F4B69AE494195A[1], "gun_orientz", _id_53F4B69AE494195A[2], "action", getpathactionvalue(), "health", getsantizedhealth()]);
  clearpathactionvalue();
}

logevent_playerspawn() {
  if(!shouldplayerlogevents(self)) {
    return;
  }
  _id_C6C41B96B7C2EF2A = isDefined(self.lastspawnpoint) && isDefined(self.lastspawnpoint.buddyspawn) && self.lastspawnpoint.buddyspawn;
  _id_20AF753DED3657E1 = anglesToForward(self.angles);
  dlog_recordevent("gamemp_spawn_in", ["playerid", self.analyticslog.playerid, "x", self.origin[0], "y", self.origin[1], "z", self.origin[2], "orientx", _id_20AF753DED3657E1[0], "orienty", _id_20AF753DED3657E1[1], "orientz", _id_20AF753DED3657E1[2], "loadout", buildloadoutstring(), "type", scripts\engine\utility::ter_op(_id_C6C41B96B7C2EF2A, "Buddy", "Normal"), "team", self.team]);
}

logevent_playerconnected() {
  if(!analyticsactive()) {
    return;
  }
  if(!isDefined(self.analyticslog))
    self.analyticslog = spawnStruct();

  self.analyticslog.playerid = level.analyticslog.nextplayerid;
  level.analyticslog.nextplayerid++;

  if(!analyticslogenabled()) {
    return;
  }
  super = undefined;

  if(isDefined(self.changedarchetypeinfo))
    super = self.changedarchetypeinfo.super;
  else
    super = self getplayerdata(level.loadoutsgroup, "squadMembers", "archetypeSuper");

  xuid = self getxuid();
  dlog_recordevent("gamemp_player_connect", ["playerid", self.analyticslog.playerid, "player_name", self.name, "player_xuid", xuid, "player_super_name", super]);
}

logevent_playerdeath(attacker, meansofdeath, weaponname) {
  if(!shouldplayerlogevents(self) || !isPlayer(self)) {
    return;
  }
  _id_53F4B69AE494195A = anglesToForward(self getplayerangles());
  _id_77295BBD7B1B8155 = -1;
  _id_798130B7F1830880 = 0;
  _id_798131B7F1830AB3 = 0;
  _id_798132B7F1830CE6 = 0;
  _id_40CFB0F1536D4858 = 0;
  _id_40CFB1F1536D4A8B = 0;
  _id_40CFB2F1536D4CBE = 0;
  attackerteam = "s";
  _id_02B835290A32BC05 = 0;

  if(isDefined(attacker) && isPlayer(attacker)) {
    _id_77295BBD7B1B8155 = attacker.analyticslog.playerid;

    if(isDefined(attacker.team)) {
      if(attacker.team == "axis")
        attackerteam = "a";
      else
        attackerteam = "l";
    }

    if(isDefined(attacker.origin)) {
      _id_798130B7F1830880 = attacker.origin[0];
      _id_798131B7F1830AB3 = attacker.origin[1];
      _id_798132B7F1830CE6 = attacker.origin[2];
    }

    if(isDefined(attacker.lifeid))
      _id_02B835290A32BC05 = attacker.lifeid;

    _id_0FDE6939445AAE30 = anglesToForward(attacker getplayerangles());

    if(isDefined(_id_0FDE6939445AAE30)) {
      _id_40CFB0F1536D4858 = _id_0FDE6939445AAE30[0];
      _id_40CFB1F1536D4A8B = _id_0FDE6939445AAE30[1];
      _id_40CFB2F1536D4CBE = _id_0FDE6939445AAE30[2];
    }
  }

  _id_79F00192DD16D2AC = level.analyticslog.nextdeathid;
  level.analyticslog.nextdeathid++;
  weaponname = scripts\engine\utility::ter_op(isDefined(weaponname), weaponname, "None");
  victimteam = "s";

  if(self.team == "axis")
    victimteam = "a";
  else
    victimteam = "l";

  dlog_recordevent("134death", ["playerid", self.analyticslog.playerid, "x", self.origin[0], "y", self.origin[1], "z", self.origin[2], "gun_orientx", _id_53F4B69AE494195A[0], "gun_orienty", _id_53F4B69AE494195A[1], "gun_orientz", _id_53F4B69AE494195A[2], "weapon", weaponname, "mean_of_death", scripts\engine\utility::ter_op(isDefined(meansofdeath), meansofdeath, "None"), "attackerid", _id_77295BBD7B1B8155, "action", buildkilldeathactionvalue(), "server_death_id", _id_79F00192DD16D2AC, "victim_life_index", self.lifeid, "attacker_life_index", _id_02B835290A32BC05, "victim_team", victimteam, "attacker_team", attackerteam, "attacker_pos_x", _id_798130B7F1830880, "attacker_pos_y", _id_798131B7F1830AB3, "attacker_pos_z", _id_798132B7F1830CE6, "attacker_gun_orientx", _id_40CFB0F1536D4858, "attacker_gun_orienty", _id_40CFB1F1536D4A8B, "attacker_gun_orientz", _id_40CFB2F1536D4CBE, "victim_weapon", self.primaryweapon]);

  if(getdvarint("mount_bb_analytics")) {
    _id_562D65AB35BBB12B = "NO_ATTACKER";

    if(isDefined(attacker) && isPlayer(attacker))
      _id_562D65AB35BBB12B = attacker playermounttype();

    _id_91F9EBED6E3C837E = self playermounttype();
    dlog_recordevent("dlog_event_gamemp_death_mount", ["playerid", self.analyticslog.playerid, "x", self.origin[0], "y", self.origin[1], "z", self.origin[2], "gun_orientx", _id_53F4B69AE494195A[0], "gun_orienty", _id_53F4B69AE494195A[1], "gun_orientz", _id_53F4B69AE494195A[2], "weapon", weaponname, "mean_of_death", scripts\engine\utility::ter_op(isDefined(meansofdeath), meansofdeath, "None"), "attackerid", _id_77295BBD7B1B8155, "action", buildkilldeathactionvalue(), "server_death_id", _id_79F00192DD16D2AC, "victim_life_index", self.lifeid, "attacker_life_index", _id_02B835290A32BC05, "victim_team", victimteam, "attacker_team", attackerteam, "attacker_pos_x", _id_798130B7F1830880, "attacker_pos_y", _id_798131B7F1830AB3, "attacker_pos_z", _id_798132B7F1830CE6, "attacker_gun_orientx", _id_40CFB0F1536D4858, "attacker_gun_orienty", _id_40CFB1F1536D4A8B, "attacker_gun_orientz", _id_40CFB2F1536D4CBE, "victim_weapon", self.primaryweapon, "attacker_mount_type", _id_562D65AB35BBB12B, "victim_mount_type", _id_91F9EBED6E3C837E]);
  }

  if(isDefined(meansofdeath) && isexplosivedamagemod(meansofdeath))
    logevent_explosion(scripts\engine\utility::ter_op(isDefined(weaponname), weaponname, "generic"), self.origin, attacker, 1.0);

  if(isDefined(self.attackers)) {
    foreach(_id_2C5B6AA194FE1165 in self.attackers) {
      if(isDefined(_id_2C5B6AA194FE1165) && isPlayer(_id_2C5B6AA194FE1165) && _id_2C5B6AA194FE1165 != attacker)
        logevent_assist(_id_2C5B6AA194FE1165.analyticslog.playerid, _id_79F00192DD16D2AC, weaponname);
    }
  }
}

logevent_playerkill(victim, meansofdeath, weaponname) {
  if(!shouldplayerlogevents(self)) {
    return;
  }
  _id_53F4B69AE494195A = anglesToForward(self getplayerangles());
  dlog_recordevent("gamemp_kill", ["playerid", self.analyticslog.playerid, "x", self.origin[0], "y", self.origin[1], "z", self.origin[2], "gun_orientx", _id_53F4B69AE494195A[0], "gun_orienty", _id_53F4B69AE494195A[1], "gun_orientz", _id_53F4B69AE494195A[2], "weapon", scripts\engine\utility::ter_op(isDefined(weaponname), weaponname, "None"), "mean_of_kill", scripts\engine\utility::ter_op(isDefined(meansofdeath), meansofdeath, "None"), "victimid", scripts\engine\utility::ter_op(isDefined(victim) && isPlayer(victim), victim.analyticslog.playerid, "-1"), "action", buildkilldeathactionvalue(), "attacker_health", getsantizedhealth(), "victim_pixel_count", 0]);
}

logevent_explosion(type, center, _id_E83217ED09C27313, duration, direction) {
  if(!analyticslogenabled()) {
    return;
  }
  if(!isDefined(direction))
    direction = (1, 0, 0);

  dlog_recordevent("gamemp_explosion", ["playerid", _id_E83217ED09C27313.analyticslog.playerid, "x", center[0], "y", center[1], "z", center[2], "orientx", direction[0], "orienty", direction[1], "orientz", direction[2], "duration", duration, "type", type]);
}

logevent_spawnpointupdate() {
  if(!analyticslogenabled()) {
    return;
  }
  if(!isDefined(level.spawnpoints)) {
    return;
  }
  foreach(spawnpoint in level.spawnpoints)
  dlog_recordevent("gamemp_spawn_point", ["x", spawnpoint.origin[0], "y", spawnpoint.origin[1], "z", spawnpoint.origin[2], "allies_score", scripts\engine\utility::ter_op(isDefined(spawnpoint.lastscore["allies"]), spawnpoint.lastscore["allies"], 0), "axis_score", scripts\engine\utility::ter_op(isDefined(spawnpoint.lastscore["axis"]), spawnpoint.lastscore["axis"], 0), "allies_max_score", scripts\engine\utility::ter_op(isDefined(spawnpoint.totalpossiblescore), spawnpoint.totalpossiblescore, 0), "axis_max_score", scripts\engine\utility::ter_op(isDefined(spawnpoint.totalpossiblescore), spawnpoint.totalpossiblescore, 0), "state", buildspawnpointstatestring(spawnpoint)]);
}

logevent_frontlineupdate(startpos, endpos, _id_C43D9EC2E9A839C6, _id_FABE25D5659F05A9, _id_E036BEB70DA584EC) {
  if(!analyticslogenabled()) {
    return;
  }
  dlog_recordevent("gamemp_front_line", ["startx", startpos[0], "starty", startpos[1], "endx", endpos[0], "endy", endpos[1], "axis_centerx", _id_FABE25D5659F05A9[0], "axis_centery", _id_FABE25D5659F05A9[1], "allies_centerx", _id_C43D9EC2E9A839C6[0], "allies_centery", _id_C43D9EC2E9A839C6[1], "state", _id_E036BEB70DA584EC]);
}

logevent_gameobject(type, uniqueid, pos, ownerid, state) {
  if(!analyticslogenabled()) {
    return;
  }
  dlog_recordevent("gamemp_object", ["uniqueid", uniqueid, "x", pos[0], "y", pos[1], "z", pos[2], "ownerid", ownerid, "type", type, "state", state]);
}

logevent_message(ownerid, pos, message) {
  if(!analyticslogenabled()) {
    return;
  }
  dlog_recordevent("gamemp_message", ["ownerid", ownerid, "x", pos[0], "y", pos[1], "z", pos[2], "message", message]);
}

logevent_tag(message) {
  if(!analyticslogenabled()) {
    return;
  }
  bbprint("gamemp_matchtags", "message %s", message);
}

logevent_powerused(_id_DC34121B4BB07FB9, state) {
  if(!shouldplayerlogevents(self)) {
    return;
  }
  _id_20AF753DED3657E1 = anglesToForward(self.angles);
  dlog_recordevent("gamemp_power", ["ownerid", self.analyticslog.playerid, "x", self.origin[0], "y", self.origin[1], "z", self.origin[2], "orientx", _id_20AF753DED3657E1[0], "orienty", _id_20AF753DED3657E1[1], "orientz", _id_20AF753DED3657E1[2], "type", _id_DC34121B4BB07FB9, "state", state]);
}

logevent_scoreupdate() {
  if(!shouldplayerlogevents(self)) {
    return;
  }
  _id_20AF753DED3657E1 = anglesToForward(self.angles);
  dlog_recordevent("gamemp_scoreboard", ["ownerid", self.analyticslog.playerid, "score", self.score]);
}

logevent_minimapcorners() {
  if(!analyticslogenabled()) {
    return;
  }
  _id_7BA521E5CC4CB125 = getEntArray("minimap_corner", "targetname");

  if(!isDefined(_id_7BA521E5CC4CB125) || _id_7BA521E5CC4CB125.size != 2) {
    return;
  }
  dlog_recordevent("gamemp_map", ["cornera_x", _id_7BA521E5CC4CB125[0].origin[0], "cornera_y", _id_7BA521E5CC4CB125[0].origin[1], "cornerb_x", _id_7BA521E5CC4CB125[1].origin[0], "cornerb_y", _id_7BA521E5CC4CB125[1].origin[1], "north", getnorthyaw()]);
}

logevent_assist(playerid, _id_79F00192DD16D2AC, weapon) {
  if(!analyticslogenabled()) {
    return;
  }
  dlog_recordevent("gamemp_assists", ["playerid", playerid, "server_death_id", _id_79F00192DD16D2AC, "weapon", weapon]);
}

getsantizedhealth() {
  return int(clamp(self.health, 0, 100000));
}

shouldplayerlogevents(player) {
  if(!analyticslogenabled())
    return 0;

  if(!isDefined(player.team) || player.team == "spectator" || player.sessionstate != "playing" && player.sessionstate != "dead")
    return 0;

  return 1;
}

logmatchtags() {
  _id_57191FDAEA1096DC = getDvar("scr_analytics_tag", "");

  if(_id_57191FDAEA1096DC != "")
    logevent_tag(_id_57191FDAEA1096DC);

  if(scripts\mp\utility\game::matchmakinggame())
    logevent_tag("OnlineMatch");
  else if(getdvarint("xblive_privatematch"))
    logevent_tag("PrivateMatch");
  else if(!getdvarint("onlinegame"))
    logevent_tag("OfflineMatch");
}

logevent_superended(_id_8F272B9312A01FC6, _id_0CD15FD5F49695B8, _id_9B9DBC948C253172, _id_464BC67340E2E2E9) {
  if(!analyticslogenabled()) {
    return;
  }
  _id_6698924DFF3AA2FC = -1;

  if(isDefined(self.analyticslog) && isDefined(self.analyticslog.playerid))
    _id_6698924DFF3AA2FC = self.analyticslog.playerid;

  dlog_recordevent("analytics_mp_supers", ["super_name", _id_8F272B9312A01FC6, "time_to_use", _id_0CD15FD5F49695B8, "num_hits", _id_9B9DBC948C253172, "num_kills", _id_464BC67340E2E2E9, "player_id", _id_6698924DFF3AA2FC]);
}

logevent_superearned(_id_A119B718BF250DDE) {
  if(!analyticslogenabled()) {
    return;
  }
  _id_6698924DFF3AA2FC = -1;

  if(isDefined(self.analyticslog) && isDefined(self.analyticslog.playerid))
    _id_6698924DFF3AA2FC = self.analyticslog.playerid;

  dlog_recordevent("analytics_mp_super_earned", ["match_time", _id_A119B718BF250DDE, "player_id", _id_6698924DFF3AA2FC]);
}

logevent_awardgained(_id_80919F898FFFB17E) {
  if(!analyticslogenabled()) {
    return;
  }
  if(_func_D03495FE6418377B(_id_80919F898FFFB17E))
    _id_80919F898FFFB17E = _func_0F28FD66285FA2C9(_id_80919F898FFFB17E);

  dlog_recordevent("analytics_mp_awards", ["award_message", _id_80919F898FFFB17E]);
}

logevent_giveplayerxp(_id_814960839FF2DC12, _id_8FF4765EAC369993, _id_24134E683F793784, source) {
  if(!analyticslogenabled()) {
    return;
  }
  _id_6698924DFF3AA2FC = -1;

  if(isDefined(self.analyticslog) && isDefined(self.analyticslog.playerid))
    _id_6698924DFF3AA2FC = self.analyticslog.playerid;

  dlog_recordevent("analytics_mp_player_xp", ["current_prestige", _id_814960839FF2DC12, "current_level", _id_8FF4765EAC369993, "xp_gained", _id_24134E683F793784, "xp_source", source, "player_id", _id_6698924DFF3AA2FC]);
}

logevent_givempweaponxp(objweapon, _id_814960839FF2DC12, _id_8FF4765EAC369993, _id_24134E683F793784, source) {
  if(!analyticslogenabled()) {
    return;
  }
  _id_6698924DFF3AA2FC = -1;

  if(isDefined(self.analyticslog) && isDefined(self.analyticslog.playerid))
    _id_6698924DFF3AA2FC = self.analyticslog.playerid;

  weapon_name = getcompleteweaponname(objweapon);
  dlog_recordevent("analytics_mp_weapon_xp", ["weapon", weapon_name, "current_prestige", _id_814960839FF2DC12, "current_level", _id_8FF4765EAC369993, "xp_gained", _id_24134E683F793784, "xp_source", source, "player_id", _id_6698924DFF3AA2FC]);
}

logevent_sendplayerindexdata() {
  if(!analyticslogenabled()) {
    return;
  }
  _id_D6228DADA168A8A6 = [];
  _id_07866D1BB4718AC7 = [];
  _id_D12A341B40354143 = 0;

  for(_id_D12A341B40354143 = 0; _id_D12A341B40354143 < 12; _id_D12A341B40354143++) {
    _id_D6228DADA168A8A6[_id_D12A341B40354143] = 0;
    _id_07866D1BB4718AC7[_id_D12A341B40354143] = "";
  }

  _id_D12A341B40354143 = 0;

  foreach(player in level.players) {
    if(!isai(player)) {
      _id_D6228DADA168A8A6[_id_D12A341B40354143] = player.analyticslog.playerid;
      _id_07866D1BB4718AC7[_id_D12A341B40354143] = player getxuid();
    }

    _id_D12A341B40354143 = _id_D12A341B40354143 + 1;
  }

  dlog_recordevent("analytics_match_player_index_init", ["player1_index", _id_D6228DADA168A8A6[0], "player1_xuid", _id_07866D1BB4718AC7[0], "player2_index", _id_D6228DADA168A8A6[1], "player2_xuid", _id_07866D1BB4718AC7[1], "player3_index", _id_D6228DADA168A8A6[2], "player3_xuid", _id_07866D1BB4718AC7[2], "player4_index", _id_D6228DADA168A8A6[3], "player4_xuid", _id_07866D1BB4718AC7[3], "player5_index", _id_D6228DADA168A8A6[4], "player5_xuid", _id_07866D1BB4718AC7[4], "player6_index", _id_D6228DADA168A8A6[5], "player6_xuid", _id_07866D1BB4718AC7[5], "player7_index", _id_D6228DADA168A8A6[6], "player7_xuid", _id_07866D1BB4718AC7[6], "player8_index", _id_D6228DADA168A8A6[7], "player8_xuid", _id_07866D1BB4718AC7[7], "player9_index", _id_D6228DADA168A8A6[8], "player9_xuid", _id_07866D1BB4718AC7[8], "player10_index", _id_D6228DADA168A8A6[9], "player10_xuid", _id_07866D1BB4718AC7[9], "player11_index", _id_D6228DADA168A8A6[10], "player11_xuid", _id_07866D1BB4718AC7[10], "player12_index", _id_D6228DADA168A8A6[11], "player12_xuid", _id_07866D1BB4718AC7[11]]);
}

analyticsspawnlogenabled() {
  return getdvarint("enable_analytics_spawn_log") != 0;
}

is_spawnid_a_less_than_b(a, b) {
  return a < b;
}

analyticsstorespawndata() {
  if(isDefined(level.spawncount) && isDefined(level.spawnidstobeinstrumented) && isDefined(level.nextspawntobeinstrumented)) {
    game["spawnCount"] = level.spawncount;
    game["spawnIdsToBeInstrumented"] = level.spawnidstobeinstrumented;
    game["nextSpawnToBeInstrumented"] = level.nextspawntobeinstrumented;
  }
}

analyticsdoesspawndataexist() {
  if(isDefined(level.spawncount) && isDefined(level.spawnidstobeinstrumented) && isDefined(level.nextspawntobeinstrumented))
    return 1;

  return 0;
}

analyticsinitspawndata() {
  spawncount = game["spawnCount"];
  _id_684B19BE1A3362F9 = game["spawnIdsToBeInstrumented"];
  nextspawntobeinstrumented = game["nextSpawnToBeInstrumented"];

  if(isDefined(spawncount) && isDefined(_id_684B19BE1A3362F9) && isDefined(nextspawntobeinstrumented)) {
    level.spawncount = spawncount;
    level.spawnidstobeinstrumented = _id_684B19BE1A3362F9;
    level.nextspawntobeinstrumented = nextspawntobeinstrumented;
  } else {
    level.spawncount = 0;
    level.spawnidstobeinstrumented = [];
    level.nextspawntobeinstrumented = 0;
    _id_9B5E7BBE7BBE2095 = getdvarint("analytics_spawn_event_log_count");
    _id_F173D241CDE30ED5 = analytics_getmaxspawneventsforcurrentmode();
    _id_ED9BCF1D68316223 = [];

    for(_id_F7B3DB25022143DF = 0; _id_F7B3DB25022143DF < _id_9B5E7BBE7BBE2095; _id_F7B3DB25022143DF++) {
      _id_47839683093FA30E = randomintrange(20, _id_F173D241CDE30ED5);

      if(isDefined(_id_ED9BCF1D68316223[_id_47839683093FA30E])) {
        level.spawnidstobeinstrumented[_id_F7B3DB25022143DF] = -1;
        continue;
      }

      _id_ED9BCF1D68316223[_id_47839683093FA30E] = 1;
      level.spawnidstobeinstrumented[_id_F7B3DB25022143DF] = _id_47839683093FA30E;
    }

    level.spawnidstobeinstrumented = scripts\engine\utility::array_sort_with_func(level.spawnidstobeinstrumented, ::is_spawnid_a_less_than_b);
  }
}

analyticssend_shouldsenddata(_id_8EF89542D7D7C021) {
  if(isDefined(level.nextspawntobeinstrumented) && isDefined(level.spawnidstobeinstrumented)) {
    if(level.nextspawntobeinstrumented < level.spawnidstobeinstrumented.size) {
      if(level.spawnidstobeinstrumented[level.nextspawntobeinstrumented] == -1)
        level.nextspawntobeinstrumented++;

      if(level.spawnidstobeinstrumented[level.nextspawntobeinstrumented] == _id_8EF89542D7D7C021) {
        level.nextspawntobeinstrumented++;
        return 1;
      }
    }
  }

  return 0;
}

analyticssend_spawntype(spawn_pos, _id_A3BF560B25C4A33E, _id_6F9BBED303902680, _id_8EF89542D7D7C021) {
  frontlineinfo = getglobalfrontlineinfo();
  _id_E01C3EAFF8656FFF = frontlineinfo.midpoint;
  _id_A4A67D69520E0248 = 0;
  _id_A4A67E69520E047B = 0;
  _id_A4A67F69520E06AE = 0;

  if(isDefined(_id_E01C3EAFF8656FFF)) {
    _id_A4A67D69520E0248 = _id_E01C3EAFF8656FFF[0];
    _id_A4A67E69520E047B = _id_E01C3EAFF8656FFF[1];
    _id_A4A67F69520E06AE = _id_E01C3EAFF8656FFF[2];
  }

  _id_EDFD8EBB152D7D02 = 0;

  if(isDefined(frontlineinfo.teamdiffyaw))
    _id_EDFD8EBB152D7D02 = frontlineinfo.teamdiffyaw;

  _id_2CF02E998291F5EA = frontlineinfo.isactive[_id_A3BF560B25C4A33E];
  _id_B3372BBD4EC17E38 = 0;

  if(isDefined(frontlineinfo.disabledreason) && isDefined(frontlineinfo.disabledreason[_id_A3BF560B25C4A33E]))
    _id_B3372BBD4EC17E38 = frontlineinfo.disabledreason[_id_A3BF560B25C4A33E];

  _id_86F685E81768EA92 = level.spawnglobals.logicvariantid;
  buddyspawnid = 0;

  if(isDefined(level.spawnglobals.buddyplayerid)) {
    buddyspawnid = level.spawnglobals.buddyplayerid;
    level.spawnglobals.buddyplayerid = 0;
  }

  bbreportspawntypes(_id_A4A67D69520E0248, _id_A4A67E69520E047B, _id_A4A67F69520E06AE, _id_EDFD8EBB152D7D02, _id_8EF89542D7D7C021, _id_2CF02E998291F5EA, _id_B3372BBD4EC17E38, _id_6F9BBED303902680, _id_86F685E81768EA92, buddyspawnid);
}

analyticssend_spawnplayerdetails(spawnplayer, spawnorigin, _id_8EF89542D7D7C021) {
  foreach(player in level.players) {
    if(scripts\mp\utility\player::isreallyalive(player)) {
      _id_B8ECDA907D8351E5 = player getplayerangles();
      _id_F511AC87A4EC676C = vectortoyaw(_id_B8ECDA907D8351E5);
      _id_48133D2CBBB25B21 = player.origin[0];
      _id_48133C2CBBB258EE = player.origin[1];
      _id_48133B2CBBB256BB = player.origin[2];
      _id_A4B47809B71BF9CE = 0;

      if(player == spawnplayer)
        _id_A4B47809B71BF9CE = 1;

      _id_1BF050CAD818D5C0 = 0;

      if(isDefined(spawnplayer.lastattacker) && spawnplayer.lastattacker == player)
        _id_1BF050CAD818D5C0 = 1;

      _id_A369F87F8A7A9868 = 0;

      if(player.team == "axis")
        _id_A369F87F8A7A9868 = 1;
      else if(player.team == "allies")
        _id_A369F87F8A7A9868 = 2;

      _id_6698924DFF3AA2FC = 0;

      if(isDefined(player.analyticslog.playerid))
        _id_6698924DFF3AA2FC = player.analyticslog.playerid;

      bbreportspawnplayerdetails(_id_8EF89542D7D7C021, _id_F511AC87A4EC676C, _id_48133D2CBBB25B21, _id_48133C2CBBB258EE, _id_48133B2CBBB256BB, _id_6698924DFF3AA2FC, _id_A369F87F8A7A9868, _id_A4B47809B71BF9CE, _id_1BF050CAD818D5C0);
    }
  }
}

analyticssend_spawnfactors(spawnplayer, _id_B46D2A4B62C02CFE, _id_DD99E302964270EC, _id_BAC9C46B10034944) {
  foreach(spawnpoint in level.spawnglobals.spawnpointslist) {
    totalscore = spawnpoint.totalscore;
    allyaveragedist = spawnpoint.analytics.allyaveragedist;
    enemyaveragedist = spawnpoint.analytics.enemyaveragedist;
    timesincelastspawn = spawnpoint.analytics.timesincelastspawn;
    _id_7C710F0108211E9E = 0;

    if(isDefined(spawnplayer.lastspawnpoint) && spawnplayer.lastspawnpoint == spawnpoint)
      _id_7C710F0108211E9E = 1;

    _id_7F1500B202DDAD69 = 0;

    if(_id_BAC9C46B10034944 == spawnpoint)
      _id_7F1500B202DDAD69 = 1;

    maxenemysightfraction = spawnpoint.analytics.maxenemysightfraction;
    randomscore = spawnpoint.analytics.randomscore;
    spawnusedbyenemies = spawnpoint.analytics.spawnusedbyenemies;
    lastspawnteam = 0;

    if(isDefined(spawnpoint.lastspawnteam) && spawnpoint.lastspawnteam == "axis")
      lastspawnteam = 1;
    else if(isDefined(spawnpoint.lastspawnteam) && spawnpoint.lastspawnteam == "allies")
      lastspawnteam = 2;

    lastspawntime = spawnpoint.lastspawntime;
    maxjumpingenemysightfraction = spawnpoint.analytics.maxjumpingenemysightfraction;
    _id_F1CC4BC5FF3D4D6F = 0;

    if(isDefined(spawnpoint.index) && spawnpoint.index <= 1023)
      _id_F1CC4BC5FF3D4D6F = spawnpoint.index;

    spawn_type = 0;

    if(isDefined(spawnpoint.analytics) && isDefined(spawnpoint.analytics.spawntype))
      spawn_type = spawnpoint.analytics.spawntype;

    _id_A60B2840CB045255 = 0;

    if(isDefined(spawnpoint.badspawnreason))
      _id_A60B2840CB045255 = spawnpoint.badspawnreason;

    bbreportspawnfactors(2, totalscore, maxenemysightfraction, maxjumpingenemysightfraction, randomscore, _id_DD99E302964270EC, allyaveragedist, enemyaveragedist, _id_7F1500B202DDAD69, _id_7C710F0108211E9E, lastspawnteam, _id_F1CC4BC5FF3D4D6F, spawnusedbyenemies, timesincelastspawn, spawn_type, _id_A60B2840CB045255);
  }
}

analytics_getmaxspawneventsforcurrentmode() {
  _id_7AD0F060D966EC01 = 120;

  if(isDefined(scripts\mp\utility\game::getgametype())) {
    if(scripts\mp\utility\game::getgametype() == "war")
      _id_7AD0F060D966EC01 = 120;
    else if(scripts\mp\utility\game::getgametype() == "dom")
      _id_7AD0F060D966EC01 = 120;
    else if(scripts\mp\utility\game::getgametype() == "conf")
      _id_7AD0F060D966EC01 = 120;
    else if(scripts\mp\utility\game::getgametype() == "front")
      _id_7AD0F060D966EC01 = 40;
    else if(scripts\mp\utility\game::getgametype() == "sd")
      _id_7AD0F060D966EC01 = 50;
    else if(scripts\mp\utility\game::getgametype() == "dm")
      _id_7AD0F060D966EC01 = 50;
    else if(scripts\mp\utility\game::getgametype() == "koth")
      _id_7AD0F060D966EC01 = 125;
    else if(scripts\mp\utility\game::getgametype() == "ctf")
      _id_7AD0F060D966EC01 = 50;
    else if(scripts\mp\utility\game::getgametype() == "tdef")
      _id_7AD0F060D966EC01 = 120;
    else if(scripts\mp\utility\game::getgametype() == "siege")
      _id_7AD0F060D966EC01 = 25;
    else if(scripts\mp\utility\game::getgametype() == "gun")
      _id_7AD0F060D966EC01 = 50;
    else if(scripts\mp\utility\game::getgametype() == "sr")
      _id_7AD0F060D966EC01 = 25;
    else if(scripts\mp\utility\game::getgametype() == "grind")
      _id_7AD0F060D966EC01 = 75;
    else if(scripts\mp\utility\game::getgametype() == "pill")
      _id_7AD0F060D966EC01 = 75;
    else if(scripts\mp\utility\game::getgametype() == "ball")
      _id_7AD0F060D966EC01 = 50;
  }

  return _id_7AD0F060D966EC01;
}

logevent_reportgamescore(_id_361A6F5D4A917B75, _id_DE862444CD52328D, _id_26594EABBAE8DC73) {
  if(!analyticslogenabled()) {
    return;
  }
  _id_3D502F7F8DD15102 = 1;

  if(!isDefined(_id_26594EABBAE8DC73))
    _id_26594EABBAE8DC73 = -1;

  dlog_recordevent("analytics_mp_score_event", ["score_type", _id_3D502F7F8DD15102, "score_points", _id_361A6F5D4A917B75, "score_eventid", _id_26594EABBAE8DC73, "game_time", _id_DE862444CD52328D, "player_id", self.analyticslog.playerid]);
}

logevent_reportstreakscore(_id_361A6F5D4A917B75, _id_DE862444CD52328D, _id_26594EABBAE8DC73) {
  if(!analyticslogenabled()) {
    return;
  }
  _id_3D502F7F8DD15102 = 2;

  if(!isDefined(_id_26594EABBAE8DC73))
    _id_26594EABBAE8DC73 = -1;

  dlog_recordevent("analytics_mp_score_event", ["score_type", _id_3D502F7F8DD15102, "score_points", _id_361A6F5D4A917B75, "score_eventid", _id_26594EABBAE8DC73, "game_time", _id_DE862444CD52328D, "player_id", self.analyticslog.playerid]);
}

logevent_reportsuperscore(_id_361A6F5D4A917B75, _id_DE862444CD52328D) {
  if(!analyticslogenabled()) {
    return;
  }
  _id_3D502F7F8DD15102 = 3;
  dlog_recordevent("analytics_mp_score_event", ["score_type", _id_3D502F7F8DD15102, "score_points", _id_361A6F5D4A917B75, "game_time", _id_DE862444CD52328D, "player_id", self.analyticslog.playerid]);
}

logevent_nvgtoggled(_id_DE862444CD52328D, _id_062B79318F912CE8, pos, enabled, duration, _id_7929C5AB5D171B8C) {
  if(!analyticslogenabled()) {
    return;
  }
  _id_6698924DFF3AA2FC = -1;

  if(isDefined(self.analyticslog) && isDefined(self.analyticslog.playerid))
    _id_6698924DFF3AA2FC = self.analyticslog.playerid;

  dlog_recordevent("dlog_event_gamemp_nvg_toggle", ["playerid", _id_6698924DFF3AA2FC, "game_time", _id_DE862444CD52328D, "player_life_index", _id_062B79318F912CE8, "x", pos[0], "y", pos[1], "z", pos[2], "enabled", enabled, "duration", duration, "disable_reason", _id_7929C5AB5D171B8C]);
}

getglobalfrontlineinfo() {
  if(!isDefined(level.frontlineinfo)) {
    level.frontlineinfo = spawnStruct();
    level.frontlineinfo.isactive = [];
    level.frontlineinfo.isactive["allies"] = 0;
    level.frontlineinfo.isactive["axis"] = 0;
    level.frontlineinfo.uptime = 0.0;
    level.frontlineinfo.downtime = 0.0;
  }

  return level.frontlineinfo;
}

logevent_playerhealed(player, amount, reviver) {
  amount = scripts\engine\utility::_id_53C4C53197386572(amount, 0);
  _id_7E660B31C7F8811D = isDefined(reviver);

  if(!_id_7E660B31C7F8811D)
    reviver = player;

  _id_6F9BBED303902680 = -1;

  if(isDefined(player.pers["telemetry"]) && isDefined(player.pers["telemetry"].life) && isDefined(player.pers["telemetry"].life._id_6F9BBED303902680))
    _id_6F9BBED303902680 = player.pers["telemetry"].life._id_6F9BBED303902680;

  player dlog_recordplayerevent("dlog_event_player_heal", ["reviver", reviver, "player_life_index", _id_6F9BBED303902680, "pos_x", player.origin[0], "pos_y", player.origin[1], "pos_z", player.origin[2], "heal_ammount", amount, "was_revived", _id_7E660B31C7F8811D]);
}

logevent_playerregen(player, amount) {
  if(!isDefined(player)) {
    return;
  }
  _id_6F9BBED303902680 = -1;

  if(isDefined(player.pers["telemetry"]) && isDefined(player.pers["telemetry"].life) && isDefined(player.pers["telemetry"].life._id_6F9BBED303902680))
    _id_6F9BBED303902680 = player.pers["telemetry"].life._id_6F9BBED303902680;

  player dlog_recordplayerevent("dlog_event_player_regen", ["player_life_index", _id_6F9BBED303902680, "heal_amount", amount]);
}

logevent_fieldupgradeearned(player, _id_A0897B14E0F4554B) {
  _id_6F9BBED303902680 = -1;
  _id_A0897B14E0F4554B = scripts\engine\utility::_id_53C4C53197386572(_id_A0897B14E0F4554B, 0);

  if(isDefined(player.pers["telemetry"]) && isDefined(player.pers["telemetry"].life) && isDefined(player.pers["telemetry"].life._id_6F9BBED303902680))
    _id_6F9BBED303902680 = player.pers["telemetry"].life._id_6F9BBED303902680;

  player dlog_recordplayerevent("dlog_event_player_field_upgrade_earned", ["player_life_index", _id_6F9BBED303902680, "pos_x", player.origin[0], "pos_y", player.origin[1], "pos_z", player.origin[2], "field_upgrade_index", _id_A0897B14E0F4554B]);
}

logevent_fieldupgradeactivated(player, _id_A0897B14E0F4554B) {
  _id_6F9BBED303902680 = -1;
  _id_A0897B14E0F4554B = scripts\engine\utility::_id_53C4C53197386572(_id_A0897B14E0F4554B, 0);

  if(isDefined(player.pers["telemetry"]) && isDefined(player.pers["telemetry"].life) && isDefined(player.pers["telemetry"].life._id_6F9BBED303902680))
    _id_6F9BBED303902680 = player.pers["telemetry"].life._id_6F9BBED303902680;

  player dlog_recordplayerevent("dlog_event_player_field_upgrade_activated", ["player_life_index", _id_6F9BBED303902680, "pos_x", player.origin[0], "pos_y", player.origin[1], "pos_z", player.origin[2], "field_upgrade_index", _id_A0897B14E0F4554B]);
}

logevent_fieldupgradeexpired(player, _id_A0897B14E0F4554B, _id_547DDFB5ABD1D0AB, _id_4FAC8B8CE36E09F1) {
  if(!isDefined(player)) {
    return;
  }
  _id_A0897B14E0F4554B = scripts\engine\utility::_id_53C4C53197386572(_id_A0897B14E0F4554B, 0);

  if(!isDefined(_id_547DDFB5ABD1D0AB))
    _id_547DDFB5ABD1D0AB = 0;

  _id_6F9BBED303902680 = -1;

  if(isDefined(player.pers["telemetry"]) && isDefined(player.pers["telemetry"].life) && isDefined(player.pers["telemetry"].life._id_6F9BBED303902680))
    _id_6F9BBED303902680 = player.pers["telemetry"].life._id_6F9BBED303902680;

  player dlog_recordplayerevent("dlog_event_player_field_upgrade_expired", ["player_life_index", _id_6F9BBED303902680, "pos_x", player.origin[0], "pos_y", player.origin[1], "pos_z", player.origin[2], "field_upgrade_index", _id_A0897B14E0F4554B, "efficacy", _id_547DDFB5ABD1D0AB, "was_destroyed", _id_4FAC8B8CE36E09F1]);
}

logevent_killstreakavailable(player, lifeid, _id_D8061F26B5ECA018, pickedup, _id_FF9358B3AC96C7AB, _id_1925D24D0AE333E6) {
  streaktype = "Killstreaks";

  if(istrue(player._id_8BC1DDAD56AB00BF))
    streaktype = "Points";

  player dlog_recordplayerevent("dlog_event_kill_streak_available", ["lifeindex", lifeid, "killstreak_name", _id_D8061F26B5ECA018, "killstreak_pickedup", pickedup, "time_msfrommatchstart", _id_FF9358B3AC96C7AB, "playerposx", _id_1925D24D0AE333E6[0], "playerposy", _id_1925D24D0AE333E6[1], "playerposz", _id_1925D24D0AE333E6[2], "streak_type", _func_1823FF50BB28148D(streaktype)]);
}

logevent_killstreakactivated(player, lifeid, _id_D8061F26B5ECA018, pickedup, _id_FF9358B3AC96C7AB, _id_1925D24D0AE333E6) {
  streaktype = "Killstreaks";

  if(istrue(player._id_8BC1DDAD56AB00BF))
    streaktype = "Points";

  player dlog_recordplayerevent("dlog_event_kill_streak_activated", ["lifeindex", lifeid, "killstreak_name", _id_D8061F26B5ECA018, "killstreak_pickedup", pickedup, "time_msfrommatchstart", _id_FF9358B3AC96C7AB, "playerposx", _id_1925D24D0AE333E6[0], "playerposy", _id_1925D24D0AE333E6[1], "playerposz", _id_1925D24D0AE333E6[2], "streak_type", _func_1823FF50BB28148D(streaktype)]);
}

logevent_killstreakexpired(player, lifeid, _id_D8061F26B5ECA018, pickedup, _id_6BEFA2534ACB8DF6, _id_1925D24D0AE333E6, expiredbydeath, shotsfired, _id_8F52823E77ACA0D3, _id_F5FF9A2F5217B3EC, _id_7E6DBB913989CF29) {
  if(!isDefined(player)) {
    return;
  }
  _id_E44B504BF7CF1A67 = scripts\mp\matchdata::gettimefrommatchstart(_id_6BEFA2534ACB8DF6);
  streaktype = "Killstreaks";

  if(istrue(player._id_8BC1DDAD56AB00BF))
    streaktype = "Points";

  _id_D3CF11436C80A43E = player dlog_recordplayerevent("dlog_event_kill_streak_expired", ["lifeindex", lifeid, "killstreak_name", _id_D8061F26B5ECA018, "killstreak_pickedup", pickedup, "expiration_thru_death", expiredbydeath, "shots", shotsfired, "hits", _id_8F52823E77ACA0D3, "kills", _id_F5FF9A2F5217B3EC, "score", _id_7E6DBB913989CF29, "time_msfrommatchstart", _id_E44B504BF7CF1A67, "playerposx", _id_1925D24D0AE333E6[0], "playerposy", _id_1925D24D0AE333E6[1], "playerposz", _id_1925D24D0AE333E6[2], "streak_type", _func_1823FF50BB28148D(streaktype)]);

  if(isDefined(player.pers["telemetry"]._id_6BE038725A124802) && _id_D3CF11436C80A43E)
    player.pers["telemetry"]._id_6BE038725A124802++;
}

logevent_xpearned(player, _id_5746D9F038B58234, weaponname, _id_CC603E175ABFEF2D, type) {
  _id_6F9BBED303902680 = -1;

  if(isDefined(player.pers["telemetry"]) && isDefined(player.pers["telemetry"].life) && isDefined(player.pers["telemetry"].life._id_6F9BBED303902680))
    _id_6F9BBED303902680 = player.pers["telemetry"].life._id_6F9BBED303902680;

  player dlog_recordplayerevent("dlog_event_player_xp_earned", ["player_life_index", _id_6F9BBED303902680, "player_xp_earned", _id_5746D9F038B58234, "weapon_s", weaponname, "weapon_xp_earned", _id_CC603E175ABFEF2D, "xp_event", type]);
  _id_715028F54BAD19A1::_id_CB3B3CBF2D1AC3F3(_id_5746D9F038B58234, _id_CC603E175ABFEF2D, _id_6F9BBED303902680, weaponname, player, type);
}

logevent_spawnselectionchoice(player, selection) {
  _id_6F9BBED303902680 = -1;

  if(isDefined(player.pers["telemetry"]) && isDefined(player.pers["telemetry"].life) && isDefined(player.pers["telemetry"].life._id_6F9BBED303902680))
    _id_6F9BBED303902680 = player.pers["telemetry"].life._id_6F9BBED303902680;

  player dlog_recordplayerevent("dlog_event_player_spawnselection_choice", ["player_life_index", _id_6F9BBED303902680, "selection", selection]);
}

logevent_challengeitemunlocked(player, _id_443F88E60A6C1697, itemtype, _id_DB35956D84816F27) {
  player dlog_recordplayerevent("dlog_event_player_challenge_item_unlocked", ["item_unlock_ref", _id_443F88E60A6C1697, "item_type", itemtype, "item_id", _id_DB35956D84816F27]);
}

_id_B4E1D087442647EF(_id_4EC493E39340A7CE, _id_48B7B944A7A02B2C, _id_9FB1EA0D886F8C27, _id_0244D4AAC201AA9D, _id_FC4A790CBD8E6140, _id_1EA736D378B0D412) {
  dlog_recordevent("dlog_event_player_interrogation_complete", ["player_interrogator", _id_4EC493E39340A7CE, "player_victim", _id_48B7B944A7A02B2C, "player_squad_size", _id_9FB1EA0D886F8C27, "player_squad_equipment", _id_0244D4AAC201AA9D, "player_interrogation_duration", _id_FC4A790CBD8E6140, "end_reason", _id_1EA736D378B0D412]);
}