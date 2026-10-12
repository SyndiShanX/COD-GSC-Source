/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\utility\player.gsc
***********************************************/



#using script_cbb0697de4c5728;
#using scripts\common\lighting;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp\damage;
#using scripts\cp\utility;
#using scripts\cp\utility\entity;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\engine\math;
#using scripts\engine\trace;
#using scripts\engine\utility;
#namespace player;

function getstancecenter() {
  if(self getstance() == "crouch") {
    center = self.origin + 0.5 * (0, 0, 48);
  } else if(self getstance() == "prone") {
    center = self.origin + 0.5 * (0, 0, 20);
  } else {
    center = self.origin + 0.5 * (0, 0, 64);
  }

  return center;
}

function getstancetop(stanceoverride) {
  curstance = self getstance();

  if(isDefined(stanceoverride)) {
    curstance = stanceoverride;
  }

  if(curstance == "crouch") {
    center = self.origin + (0, 0, 48);
  } else if(curstance == "prone") {
    center = self.origin + (0, 0, 20);
  } else {
    center = self.origin + (0, 0, 64);
  }

  return center;
}

function isreallyalive(player) {
  return isalive(player) && !isDefined(player.fauxdead) && !istrue(self.delayedspawnedplayernotify);
}

function isarchetype(type) {
  return isDefined(self.loadoutarchetype) && type == self.loadoutarchetype;
}

function isplayerads() {
  return self playerads() > 0.5;
}

function setthirdpersondof(isenabled) {
  if(isenabled) {
    setdof_thirdperson();
    return;
  }

  setdof_default();
}

function updatesessionstate(sessionstate, statusicon) {
  assert(sessionstate == "playing" || sessionstate == "dead" || sessionstate == "spectator" || sessionstate == "intermission");

  switch (sessionstate) {
    case #"hash_6e223a17d0eb5015":
    case #"hash_7135993aa112803d":
      statusicon = "";
      break;
    case #"hash_9430ae82e6671e2a":
    case #"hash_cf14c509efeb3c87":
      if(istrue(level.var_286c2c7b34d03b04)) {
        statusicon = "";
      } else if(istrue(level.numlifelimited)) {
        if(istrue(self.tagavailable)) {
          statusicon = "hud_status_dogtag";
        } else if(istrue(self.revivetriggeravailable)) {
          if(isDefined(self.statusicon) && self.statusicon == "hud_status_revive_or") {
            statusicon = "hud_status_revive_or";
          } else {
            statusicon = "hud_status_revive_wh";
          }
        } else {
          statusicon = "hud_status_dead";
        }
      } else {
        statusicon = "hud_status_dead";
      }

      break;
  }

  if(!isDefined(statusicon)) {
    statusicon = "";
  }

  self.sessionstate = sessionstate;
  self.statusicon = statusicon;
  self setclientomnvar("ui_session_state", sessionstate);
}

function get_players_watching(just_spectators, just_killcam) {
  if(!isDefined(just_spectators)) {
    just_spectators = 0;
  }

  if(!isDefined(just_killcam)) {
    just_killcam = 0;
  }

  var_ade4ed7fadba8194 = self getentitynumber();
  players_watching = [];

  foreach(player in level.players) {
    if(player == self) {
      continue;
    }

    var_7bec920eea9088e7 = 0;

    if(!just_killcam) {
      if(isDefined(player.team) && (player.team == "spectator" || player.sessionstate == "spectator")) {
        spectatingplayer = player getspectatingplayer();

        if(isDefined(spectatingplayer) && spectatingplayer == self) {
          var_7bec920eea9088e7 = 1;
        }
      }

      if(player.forcespectatorclient == var_ade4ed7fadba8194) {
        var_7bec920eea9088e7 = 1;
      }
    }

    if(!just_spectators) {
      if(player.killcamentity == var_ade4ed7fadba8194) {
        var_7bec920eea9088e7 = 1;
      }
    }

    if(var_7bec920eea9088e7) {
      players_watching[players_watching.size] = player;
    }
  }

  return players_watching;
}

function set_visionset_for_watching_players(new_visionset, var_98b0a8ec6eeff568, var_e0d7f346bd955cdc, var_fc0b50f08da38b65, just_spectators, just_killcam) {
  players_watching = get_players_watching(just_spectators, just_killcam);

  foreach(player in players_watching) {
    player notify("changing_watching_visionset");

    if(isDefined(var_fc0b50f08da38b65) && var_fc0b50f08da38b65) {
      player visionsetmissilecamforplayer(new_visionset, var_98b0a8ec6eeff568);
    } else {
      player visionsetnakedforplayer(new_visionset, var_98b0a8ec6eeff568);
    }

    if(new_visionset != "" && isDefined(var_e0d7f346bd955cdc)) {
      player thread reset_visionset_on_team_change(self, var_98b0a8ec6eeff568 + var_e0d7f346bd955cdc);
      player thread reset_visionset_on_disconnect(self);

      if(player isinkillcam()) {
        player thread reset_visionset_on_spawn();
      }
    }
  }
}

function reset_visionset_on_spawn() {
  self endon("disconnect");
  self waittill("spawned");
  self visionsetnakedforplayer("", 0);
}

function reset_visionset_on_team_change(var_d6263ebe22d2bee2, var_e4b1ee6125b0d25b) {
  self endon("changing_watching_visionset");
  time_started = gettime();
  team_started = self.team;

  while(gettime() - time_started < var_e4b1ee6125b0d25b * 1000) {
    if(self.team != team_started || !array_contains(var_d6263ebe22d2bee2 get_players_watching(), self)) {
      self visionsetnakedforplayer("", 0);
      self notify("changing_visionset");
      break;
    }

    waitframe();
  }
}

function reset_visionset_on_disconnect(entity_watching) {
  self endon("changing_watching_visionset");
  entity_watching waittill("disconnect");
  self visionsetnakedforplayer("", 0);
}

function restorebasevisionset(fadetime) {
  if(istrue(level.wpinprogress)) {
    return;
  }

  self visionsetnakedforplayer("", fadetime);
}

function init_visionsetnight() {
  if(isDefined(level.nvgvisionsetoverride) && isstring(level.nvgvisionsetoverride)) {
    visionsetnight(level.nvgvisionsetoverride);
    return;
  }

  visionsetnight("nvg_base_mp");
}

function overridevisionsetnightforlevel(newvisionset) {
  assertex(isDefined(newvisionset), "New VisionSet must be passed to function");
  visionsetnight(newvisionset);
  level.nvgvisionsetoverride = newvisionset;
}

function resetvisionsetnighttodefault() {
  level.nvgvisionsetoverride = undefined;
  visionsetnight("nvg_base_mp");
}

function isenemy(other) {
  if(level.teambased) {
    return (other.team != self.team);
  }

  if(isDefined(other.owner)) {
    return (other.owner != self);
  }

  return other != self;
}

function getuniqueid() {
  if(!isDefined(self.pers)) {
    self.pers = [];
  }

  if(isDefined(self.pers["guid"])) {
    return self.pers["guid"];
  }

  playerguid = self getguid();

  if(playerguid == "0000000000000000") {
    if(isDefined(level.guidgen)) {
      level.guidgen++;
    } else {
      level.guidgen = 1;
    }

    playerguid = "script" + level.guidgen;
  }

  self.pers["guid"] = playerguid;
  return self.pers["guid"];
}

function getplayersinradius(origin, radius, desiredteam, excludeent) {
  return scripts\cp_mp\utility\player_utility::getplayersinradius(origin, radius, desiredteam, excludeent);
}

function getplayersinradiusview(origin, radius, desiredteam, excludeent) {
  var_305f0639560a5707 = [];
  playersinradius = getplayersinradius(origin, radius, desiredteam, excludeent);

  foreach(player in playersinradius) {
    structcreated = undefined;
    tracepoints = [player gettagorigin("j_head"), player gettagorigin("j_mainroot"), player gettagorigin("tag_origin")];

    for(i = 0; i < tracepoints.size; i++) {
      if(!scripts\engine\trace::ray_trace_passed(origin, tracepoints[i], level.characters, scripts\engine\trace::create_contents(0, 1, 1, 1, 1, 1))) {
        continue;
      }

      if(!isDefined(structcreated)) {
        var_305f0639560a5707[var_305f0639560a5707.size] = spawnStruct();
        var_305f0639560a5707[var_305f0639560a5707.size - 1].player = player;
        var_305f0639560a5707[var_305f0639560a5707.size - 1].visiblelocations = [];
        structcreated = 1;
      }

      var_305f0639560a5707[var_305f0639560a5707.size - 1].visiblelocations[var_305f0639560a5707[var_305f0639560a5707.size - 1].visiblelocations.size] = tracepoints[i];
    }
  }

  return var_305f0639560a5707;
}

function isfriendly(teamtocheck, var_c4b81997f0120a97) {
  assertex(isDefined(var_c4b81997f0120a97), "isFriendlyTeam argument 2 is not defined");

  if(!level.teambased) {
    return false;
  }

  if(!isPlayer(var_c4b81997f0120a97) && !isDefined(var_c4b81997f0120a97.team)) {
    return false;
  }

  if(teamtocheck != var_c4b81997f0120a97.team) {
    return false;
  }

  return true;
}

function _enablecollisionnotifies(bool) {
  if(!isDefined(self.enabledcollisionnotifies)) {
    self.enabledcollisionnotifies = 0;
  }

  if(bool) {
    if(self.enabledcollisionnotifies == 0) {
      self enablecollisionnotifies(1);
    }

    self.enabledcollisionnotifies++;
  } else {
    if(self.enabledcollisionnotifies == 1) {
      self enablecollisionnotifies(0);
    }

    self.enabledcollisionnotifies--;
  }

  assert(self.enabledcollisionnotifies >= 0);
}

function allow_dodge(bool) {
  if(self.loadoutarchetype != "archetype_scout") {
    return;
  }

  if(bool) {
    if(!isDefined(self.disableddodge)) {
      self.disableddodge = 0;
    }

    self.disableddodge--;
    assert(self.disableddodge >= 0);

    if(!self.disableddodge) {
      self allowdodge(1);
    }

    return;
  }

  if(!isDefined(self.disableddodge)) {
    self.disableddodge = 0;
  }

  self.disableddodge++;
  self allowdodge(0);
}

function allow_gesture(bool, tag) {
  if(!isDefined(tag)) {
    tag = "allow_gesture";
  }

  if(!bool) {
    val::set(tag, "gesture", 0);
    return;
  }

  val::reset_all(tag);
}

function isplayerproxyagent(ent, player) {
  proxyagent = 0;

  if(isagent(ent) && isDefined(ent.agent_type) && ent.agent_type == "playerProxy") {
    if(ent.owner == player) {
      proxyagent = 1;
    }
  }

  return proxyagent;
}

function enableragdollzerog(arg, scale) {
  if(arg) {
    physics_setgravityragdollscalar(scale);
    level.ragdollzerog = 1;
    return;
  }

  physics_setgravityragdollscalar(1);
  level.ragdollzerog = undefined;
}

function isragdollzerog() {
  return istrue(level.ragdollzerog);
}

function _visionsetnaked(visionset, time) {
  foreach(player in level.players) {
    if(!isDefined(player)) {
      continue;
    }

    if(isai(player)) {
      continue;
    }

    player visionsetnakedforplayer(visionset, time);
  }
}

function hidehudenable() {
  if(!isDefined(self.ui_hudhidden)) {
    self.hidehudenabled = 0;
  }

  if(self.hidehudenabled == 0) {
    self setclientomnvar("ui_hide_hud", 1);
  }

  self.hidehudenabled++;
}

function hidehuddisable() {
  assert(isDefined(self.hidehudenabled) && self.hidehudenabled > 0, "hideHudDisable called when hud is not hidden.");

  if(self.hidehudenabled == 1) {
    self setclientomnvar("ui_hide_hud", 0);
  }

  self.hidehudenabled--;
}

function hideminimap(forcehide) {
  if(alwaysshowminimap() && !istrue(forcehide)) {
    return;
  }

  if(!isDefined(self.minimapstatetracker)) {
    self.minimapstatetracker = 0;
  }

  var_5546bbd6b68a186d = self.minimapstatetracker;
  self.minimapstatetracker--;

  if(self.minimapstatetracker < 0) {
    self.minimapstatetracker = 0;
  }

  if(istrue(forcehide) || self.minimapstatetracker == 0 && var_5546bbd6b68a186d > self.minimapstatetracker) {
    self setclientomnvar("ui_hide_minimap", 1);

    if(istrue(forcehide)) {
      self.minimapstatetracker = 0;
    }
  }
}

function showminimap() {
  if(scripts\cp\utility::is_minimap_forcedisabled()) {
    self iprintln("<dev string:x1c>");

    return;
  }

  if(!isDefined(self.minimapstatetracker)) {
    self.minimapstatetracker = 0;
  }

  var_5546bbd6b68a186d = self.minimapstatetracker;
  self.minimapstatetracker++;

  if(self.minimapstatetracker == 1 && var_5546bbd6b68a186d < self.minimapstatetracker) {
    self setclientomnvar("ui_hide_minimap", 0);
  }
}

function alwaysshowminimap() {
  return istrue(level.minimaponbydefault) || scripts\cp_mp\utility\game_utility::isbrstylegametype() || level.gametype == "brm";
}

function isfemale() {
  return isDefined(self.operatorcustomization) && isDefined(self.operatorcustomization.gender) && self.operatorcustomization.gender == "female";
}

function getlowestclientnum(players, var_e1fea15ff7126a10) {
  lowestclientnum = undefined;
  assertex(isDefined(players), "getLowestClientNum: Players array is undefined.");

  foreach(player in players) {
    if(player.team != "spectator" && (!var_e1fea15ff7126a10 || player scripts\cp_mp\utility\player_utility::_isalive())) {
      if(!isDefined(lowestclientnum) || player getentitynumber() < lowestclientnum) {
        lowestclientnum = player getentitynumber();
      }
    }
  }

  return lowestclientnum;
}

function setusingremote(remotename) {
  if(isDefined(self.carryicon)) {
    self.carryicon.alpha = 0;
  }

  assert(!isusingremote());
  self.usingremote = remotename;
  val::set("using_remote", "vehicle_use", 0);
  val::set("using_remote", "crate_use", 0);
  val::set("using_remote", "offhand_weapons", 0);
  val::set("using_remote", "ads", 0);
  self setclientomnvar("ui_using_killstreak_remote", 1);
  self notify("using_remote");
}

function getremotename() {
  assert(isusingremote());
  return self.usingremote;
}

function clearusingremote(bypassweaponswitch) {
  val::reset_all("using_remote");

  if(isDefined(self.carryicon)) {
    self.carryicon.alpha = 1;
  }

  self.usingremote = undefined;

  if(!isDefined(bypassweaponswitch)) {
    _freezecontrols(0);
  }

  self setclientomnvar("ui_using_killstreak_remote", 0);
  self notify("stopped_using_remote");
}

function _freezecontrols(frozen, force) {
  if(!isDefined(self.pers)) {
    return;
  }

  if(!isDefined(self.pers["controllerFreezeStack"])) {
    self.pers["controllerFreezeStack"] = 0;
  }

  if(frozen) {
    assert(!isDefined(force));
    self.pers["controllerFreezeStack"]++;
  } else if(istrue(force)) {
    self.pers["controllerFreezeStack"] = 0;
  } else {
    self.pers["controllerFreezeStack"]--;
  }

  if(self.pers["controllerFreezeStack"] <= 0) {
    self.pers["controllerFreezeStack"] = 0;
    self freezecontrols(0);
    self.controlsfrozen = 0;
    return;
  }

  self freezecontrols(1);
  self.controlsfrozen = 1;
}

function _freezelookcontrols(frozen, force) {
  if(!isDefined(self.pers)) {
    return;
  }

  if(!isDefined(self.pers["controllerLookFreezeStack"])) {
    self.pers["controllerLookFreezeStack"] = 0;
  }

  if(frozen) {
    assert(!isDefined(force));
    self.pers["controllerLookFreezeStack"]++;
  } else if(istrue(force)) {
    self.pers["controllerLookFreezeStack"] = 0;
  } else {
    self.pers["controllerLookFreezeStack"]--;
  }

  if(self.pers["controllerLookFreezeStack"] <= 0) {
    self.pers["controllerLookFreezeStack"] = 0;
    self freezelookcontrols(0);
    self.lookcontrolsfrozen = 0;
    return;
  }

  self freezelookcontrols(1);
  self.lookcontrolsfrozen = 1;
}

function getplayerforguid(guid) {
  foreach(player in level.players) {
    if(player.guid == guid) {
      return player;
    }
  }

  return undefined;
}

function set_temp_energy_restore_rate(energygroup, temprate, time, untilfull) {
  var_4c1e617deaa58718 = self energy_getrestorerate(energygroup);
  self.temprateset = 1;
  assertex(var_4c1e617deaa58718 != temprate, "Attempting to set temp recharge rate same as default rate.");
  self energy_setrestorerate(energygroup, temprate);

  if(!isDefined(untilfull) || !untilfull) {
    wait time;
  } else {
    assertex(temprate > 0, "attempted to set a zero restore rate until full");
    maxenergy = self energy_getmax(energygroup);

    for(;;) {
      if(self energy_getenergy(energygroup) >= maxenergy) {
        break;
      }

      waitframe();
    }
  }

  self energy_setrestorerate(energygroup, var_4c1e617deaa58718);
  self.temprateset = 0;
}

function set_temp_energy_rest_time(energygroup, tempresttime, time, untilfull) {
  var_25c4d960831fd0a1 = self energy_getresttimems(energygroup);
  self.tempresttime = 1;
  assertex(var_25c4d960831fd0a1 != tempresttime, "Attempting to set temp rest Time same as default.");
  self energy_setresttimems(energygroup, tempresttime);

  if(!isDefined(untilfull) || !untilfull) {
    wait time;
  } else {
    assertex(tempresttime > 0, "attempted to set a zero rest time until full");
    maxenergy = self energy_getmax(energygroup);

    for(;;) {
      if(self energy_getenergy(energygroup) >= maxenergy) {
        break;
      }

      waitframe();
    }
  }

  self energy_setresttimems(energygroup, var_25c4d960831fd0a1);
  self.tempresttime = 0;
}

function _enableignoreme() {
  if(!isDefined(self.enabledignoreme)) {
    self.enabledignoreme = 0;
  }

  if(self.enabledignoreme == 0) {
    self.ignoreme = 1;
  }

  self.enabledignoreme++;
}

function _disableignoreme() {
  assert(isDefined(self.enabledignoreme) && self.enabledignoreme > 0, "_disableIgnoreMe when ignoreme is already disabled.");

  if(self.enabledignoreme == 1) {
    self.ignoreme = 0;
  }

  self.enabledignoreme--;
}

function _resetenableignoreme() {
  self.enabledignoreme = undefined;
  self.ignoreme = 0;
}

function watchbuttonPressed(key, commanddown, commandup, startpressed) {
  if(!isDefined(self.buttonspressed)) {
    self.buttonspressed = [];
  }

  if(!isDefined(self.buttonspressed[key])) {
    struct = spawnStruct();
    struct.player = self;
    struct.key = key;
    struct.commanddown = commanddown;
    struct.commandup = commandup;
    struct.notifydown = key + "_buttonDown";
    struct.notifyup = key + "_buttonUp";
    struct.pressed = istrue(startpressed);
    self.buttonspressed[key] = struct;
    struct thread watchbuttonpressedinternal();
  }
}

function getbuttonPressed(key) {
  if(!isDefined(self.buttonspressed)) {
    return 0;
  }

  if(!isDefined(self.buttonspressed[key])) {
    return 0;
  }

  return self.buttonspressed[key].pressed;
}

function watchbuttonpressedend(key) {
  if(!isDefined(self) || !isDefined(self.buttonspressed) || self.buttonspressed[key]) {
    return;
  }

  self.buttonspressed[key] notify("watchButtonPressedEnd");
  self.buttonspressed[key] = undefined;
}

function watchbuttonpressedinternal() {
  self.player endon("disconnect");
  self endon("watchButtonPressedEnd");

  while(true) {
    self.down = 0;
    self.up = 0;
    childthread watchbuttondown();
    childthread watchbuttonup();
    self waittill("start_race");
    waittillframeend();
    self notify("end_race");

    if(self.down && self.up) {
      continue;
    }

    if(self.down) {
      self.pressed = 1;
      continue;
    }

    self.pressed = 0;
  }
}

function watchbuttondown() {
  self endon("end_race");
  self.player notifyonplayercommand(self.notifydown, self.commanddown);
  self.player waittill(self.notifydown);
  self.down = 1;
  self notify("start_race");
}

function watchbuttonup() {
  self endon("end_race");
  self.player notifyonplayercommand(self.notifyup, self.commandup);
  self.player waittill(self.notifyup);
  self.up = 1;
  self notify("start_race");
}

function watchbuttonpressendondisconnect() {
  self endon("watchButtonPressedEnd");
  self.player waittill("disconnect");
  self notify("watchButtonPressedEnd");
}

function _setdof_internal(nearstart, nearend, farstart, farend, nearblur, farblur) {
  if(true) {
    return;
  }

  if(!isDefined(self)) {
    return;
  }

  nearstart = max(nearstart, 0);
  nearend = clamp(nearend, 1, 9994);
  farstart = clamp(farstart, 2, 9998);
  farend = clamp(farend, 3, 9999);

  if(farstart > 9994) {
    farblur = 0;
  }
}

function setdof_dynamic() {
  self endon("death_or_disconnect");
  setdof_default();

  if(isai(self)) {
    return;
  }

  content = ["physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_vehicle", "physicscontents_characterproxy", "physicscontents_glass", "physicscontents_itemclip"];
  contentoverride = physics_createcontents(content);
  playercontent = ["physicscontents_characterproxy"];
  var_30d537ea3164e799 = physics_createcontents(playercontent);
  useinterest = 1;
  tracegeo = 1;
  var_2e3c1d928388c537 = cos(27);
  var_a906be9cea201732 = 1;
  var_641ef3fc1ef694a5 = 0;
  dofsettings = [];
  dofsettings["geo"] = spawnStruct();
  dofsettings["geo"].nearstartfactor = getdvarfloat(@ "hash_477d20ac52a6d418", 0.01);
  dofsettings["geo"].nearendfactor = getdvarfloat(@ "hash_e3404a5a9ae5315d", 0.95);
  dofsettings["geo"].farstartfactor = getdvarfloat(@ "hash_3207700a54cd601", 1.5);
  dofsettings["geo"].farendfactor = getdvarfloat(@ "hash_db3504caf0e15404", 2.5);
  dofsettings["geo"].nearblur = getdvarfloat(@ "hash_ae45baa306e4ae81", 3.9);
  dofsettings["geo"].farblur = getdvarfloat(@ "hash_8bc87003c9fc085e", 2.25);
  dofsettings["interest"] = spawnStruct();
  dofsettings["interest"].nearstartfactor = getdvarfloat(@ "dof_nearstart", 0.01);
  dofsettings["interest"].nearendfactor = getdvarfloat(@ "dof_nearend", 0.95);
  dofsettings["interest"].farstartfactor = getdvarfloat(@ "dof_farstart", 1.5);
  dofsettings["interest"].farendfactor = getdvarfloat(@ "dof_farend", 2.5);
  dofsettings["interest"].nearblur = getdvarfloat(@ "dof_nearblur", 7);
  dofsettings["interest"].farblur = getdvarfloat(@ "dof_farblur", 3.5);

  while(true) {
    waitframe();
    usesetting = "geo";

    if(istrue(self.usingcustomdof)) {
      continue;
    }

    var_a519a2a30c26b6da = self playerads() > 0.9;

    if(var_a906be9cea201732 && !var_a519a2a30c26b6da) {
      if(var_641ef3fc1ef694a5) {
        var_641ef3fc1ef694a5 = 0;
        _setdof_internal(0, 0, 512, 512, 4, 0);
      }

      continue;
    }

    startpos = self getEye();
    viewangles = self getplayerangles();
    fwd = anglesToForward(viewangles);
    disttotarget = -1;
    neardist = undefined;
    fardist = undefined;
    bestenemy = undefined;
    tracedist = undefined;

    if(useinterest) {
      bestdot = 0;

      foreach(enemy in level.players) {
        if(!scripts\cp_mp\utility\player_utility::playersareenemies(self, enemy)) {
          continue;
        }

        if(!enemy scripts\cp_mp\utility\player_utility::_isalive()) {
          continue;
        }

        enemypos = enemy getEye();
        headdot = vectordot(fwd, vectorNormalize(enemypos - startpos));

        if(headdot < var_2e3c1d928388c537) {
          continue;
        }

        dist = distance(startpos, enemypos);

        if(!isDefined(neardist) || dist < neardist) {
          if(enemy sightconetrace(startpos, self) > 0) {
            neardist = dist;
          }
        }

        if(!isDefined(fardist) || dist > fardist) {
          if(enemy sightconetrace(startpos, self) > 0) {
            fardist = dist;
          }
        }
      }
    }

    endpos = startpos + fwd * 10000;
    trace = scripts\engine\trace::sphere_trace(startpos, endpos, 0.1, self, contentoverride, 0);
    tracedist = distance(startpos, trace["position"]);
    playertrace = scripts\engine\trace::sphere_trace(startpos, endpos, 20, self, var_30d537ea3164e799, 0);
    traceent = playertrace["entity"];
    entisenemy = isDefined(traceent) && isPlayer(traceent) && scripts\cp_mp\utility\player_utility::playersareenemies(self, traceent);
    var_59131f90f8665fae = entisenemy && traceent sightconetrace(startpos, self) > 0;

    if(!isDefined(neardist) || tracedist < neardist) {
      neardist = tracedist;
    }

    if(!isDefined(fardist) || tracedist > fardist) {
      fardist = tracedist;
    }

    var_641ef3fc1ef694a5 = 1;
    middist = max(abs(neardist - fardist) * 0.5, 300);
    nearstart = 0;
    nearend = max(neardist - 50, 1);
    farstart = fardist + 50;
    farend = farstart + middist;
    nearblur = ter_op(var_59131f90f8665fae, 6, 4);
    farblur = ter_op(var_59131f90f8665fae, 2.5, 1.25);
    _setdof_internal(nearstart, nearend, farstart, farend, nearblur, farblur);
  }
}

function setdof_killer() {
  self endon("disconnect");
  self.usingcustomdof = 1;
  setdof_killer_update();
  setdof_default();
}

function setdof_killer_update() {
  self endon("disconnect");
  self endon("death_delay_finished");
  content = ["physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_vehicle", "physicscontents_characterproxy", "physicscontents_glass", "physicscontents_itemclip"];
  contentoverride = physics_createcontents(content);
  tokiller = vectorNormalize(self.origin - self.lastkilledby.origin);
  startpos = self.origin + (0, 0, 42);
  endpos = startpos + tokiller * 120;
  trace = scripts\engine\trace::sphere_trace(startpos, endpos, 2, self, contentoverride, 0);
  camposition = trace["position"];

  while(istrue(self.usingcustomdof)) {
    if(!isDefined(self.lastkilledby)) {
      break;
    }

    disttotarget = distance(camposition, self.lastkilledby.origin);
    nearstart = 0;
    nearend = max(disttotarget - 12, 1);
    farstart = disttotarget + 12;
    farend = farstart + 50;
    nearblur = 8;
    farblur = 4.5;
    _setdof_internal(nearstart, nearend, farstart, farend, nearblur, farblur);
    waitframe();
  }
}

function setdof_default() {
  self.usingcustomdof = 0;
  _setdof_internal(0, 0, 512, 512, 4, 0);
}

function setdof_spectator() {
  self.usingcustomdof = 1;
  _setdof_internal(0, 0, 512, 512, 4, 0);
}

function setdof_infil() {
  self.usingcustomdof = 1;
  _setdof_internal(0, 128, 512, 4000, 6, 1.8);
}

function setdof_apache() {
  self.usingcustomdof = 1;
  _setdof_internal(10, 80, 1000, 6500, 7, 3.5);
}

function setdof_cruisethird() {
  self.usingcustomdof = 1;
  _setdof_internal(10, 80, 1000, 6500, 7, 3.5);
}

function setdof_cruisefirst() {
  self.usingcustomdof = 1;
  _setdof_internal(10, 80, 1000, 1000, 7, 0);
}

function setdof_tank() {
  self.usingcustomdof = 1;
  _setdof_internal(10, 120, 1000, 6500, 7, 3.5);
}

function setdof_thirdperson() {
  self.usingcustomdof = 1;
  _setdof_internal(0, 110, 512, 4096, 6, 1.8);
}

function setdof_gunship() {
  self.usingcustomdof = 1;
  _setdof_internal(10, 80, 1000, 1000, 7, 0);
}

function setdof_gunship_zoom() {
  self.usingcustomdof = 1;
  _setdof_internal(10, 80, 1000, 6500, 10, 5);
}

function setdof_scrambler_strength_1() {
  self.usingcustomdof = 1;
  _setdof_internal(10, 80, 1000, 5000, 4, 3.5);
}

function setdof_scrambler_strength_2() {
  self.usingcustomdof = 1;
  _setdof_internal(10, 80, 800, 4000, 4.5, 3.5);
}

function setdof_scrambler_strength_3() {
  self.usingcustomdof = 1;
  _setdof_internal(10, 80, 600, 3000, 5, 3.5);
}

function setdof_scrambler_strength_4() {
  self.usingcustomdof = 1;
  _setdof_internal(10, 80, 500, 2000, 5.5, 3.5);
}

function setdof_scrambler_strength_5() {
  self.usingcustomdof = 1;
  _setdof_internal(10, 80, 400, 1000, 6, 3.5);
}

function clearkillcamstate() {
  self.forcespectatorclient = -1;
  self.killcamentity = -1;
  self.archivetime = 0;
  self.archiveusepotg = 0;
  self.psoffsettime = 0;
  self.spectatekillcam = 0;
}

function isinkillcam() {
  if(isai(self)) {
    return 0;
  }

  if(self.spectatekillcam) {
    if(self.forcespectatorclient == -1 && self.killcamentity == -1) {
      return 0;
    }
  }

  return self.spectatekillcam;
}

function waittillrecoveredhealth(time, interval) {
  self endon("death_or_disconnect");
  fullhealthtime = 0;

  if(!isDefined(interval)) {
    interval = 0.05;
  }

  if(!isDefined(time)) {
    time = 0;
  }

  while(true) {
    if(self.health != self.maxhealth) {
      fullhealthtime = 0;
    } else {
      fullhealthtime += interval;
    }

    wait interval;

    if(self.health == self.maxhealth && fullhealthtime >= time) {
      break;
    }
  }
}

function _setsuit(suit) {
  if(isDefined(self.suit) && self.suit == suit) {
    return;
  }

  self setsuit(suit);
  self.suit = suit;
  namespace_46e942396566f2da::function_7c62c6c14aba289b();
}

function earthquake_for_client(var_46a291e8d3338ad9, var_cc2caa1cddc1e026) {
  if(!isDefined(self.eq)) {
    init_earthquake_for_client();
  }

  if(!isDefined(var_cc2caa1cddc1e026)) {
    var_cc2caa1cddc1e026 = 0;
  }

  partname = undefined;

  if(var_cc2caa1cddc1e026) {
    partname = level.eqforclient.partnamesview[var_46a291e8d3338ad9];
  } else {
    partname = level.eqforclient.partnames[var_46a291e8d3338ad9];
  }

  curstate = self.eq.curstates[partname];
  statename = "active" + curstate;
  self setscriptablepartstate(partname, statename, 0);
  curstate++;

  if(curstate > 4) {
    curstate = mod(curstate, 4);
  }

  self.eq.curstates[partname] = curstate;
}

function clear_earthquake_for_client() {
  if(!isDefined(self.eq)) {
    return;
  }

  if(!isDefined(level.eqforclient)) {
    init_earthquake();
  }

  foreach(partname in level.eqforclient.partnames) {
    self setscriptablepartstate(partname, "neutral", 0);
  }

  foreach(partname in level.eqforclient.partnamesview) {
    self setscriptablepartstate(partname, "neutral", 0);
  }

  self.eq = undefined;
}

function rumble_for_client(var_46a291e8d3338ad9, var_cc2caa1cddc1e026) {
  if(!isDefined(self.rumb)) {
    init_rumble_for_client();
  }

  if(!isDefined(var_cc2caa1cddc1e026)) {
    var_cc2caa1cddc1e026 = 0;
  }

  partname = undefined;

  if(var_cc2caa1cddc1e026) {
    partname = level.rumbforclient.partnamesview[var_46a291e8d3338ad9];
  } else {
    partname = level.rumbforclient.partnames[var_46a291e8d3338ad9];
  }

  curstate = self.rumb.curstates[partname];
  statename = "active" + curstate;
  self setscriptablepartstate(partname, statename, 0);
  curstate++;

  if(curstate > 4) {
    curstate = mod(curstate, 4);
  }

  self.rumb.curstates[partname] = curstate;
}

function clear_rumble_for_client() {
  if(!isDefined(self.rumb)) {
    return;
  }

  foreach(partname in level.rumbforclient.partnames) {
    self setscriptablepartstate(partname, "neutral", 0);
  }

  foreach(partname in level.rumbforclient.partnamesview) {
    self setscriptablepartstate(partname, "neutral", 0);
  }

  self.rumb = undefined;
}

function init_earthquake() {
  level.eqforclient = spawnStruct();
  partnames = [];
  var_4e578e99aed19b32 = "shake" + "eq";

  for(i = 1; i <= 4; i++) {
    partnames[i] = var_4e578e99aed19b32 + i;
  }

  level.eqforclient.partnames = partnames;
  partnames = [];
  var_4e578e99aed19b32 = "shake" + "eq" + "view";

  for(i = 1; i <= 4; i++) {
    partnames[i] = var_4e578e99aed19b32 + i;
  }

  level.eqforclient.partnamesview = partnames;
}

function init_earthquake_for_client() {
  if(!isDefined(level.eqforclient)) {
    init_earthquake();
  }

  self.eq = spawnStruct();
  curstates = [];

  foreach(partname in level.eqforclient.partnames) {
    curstates[partname] = 1;
  }

  foreach(partname in level.eqforclient.partnamesview) {
    curstates[partname] = 1;
  }

  self.eq.curstates = curstates;
}

function init_rumble() {
  level.rumbforclient = spawnStruct();
  partnames = [];
  var_4e578e99aed19b32 = "shake" + "rumb";

  for(i = 1; i <= 4; i++) {
    partnames[i] = var_4e578e99aed19b32 + i;
  }

  level.rumbforclient.partnames = partnames;
  partnames = [];
  var_4e578e99aed19b32 = "shake" + "rumb" + "view";

  for(i = 1; i <= 4; i++) {
    partnames[i] = var_4e578e99aed19b32 + i;
  }

  level.rumbforclient.partnamesview = partnames;
}

function init_rumble_for_client() {
  if(!isDefined(level.rumbforclient)) {
    init_rumble();
  }

  self.rumb = spawnStruct();
  curstates = [];

  foreach(partname in level.rumbforclient.partnames) {
    curstates[partname] = 1;
  }

  foreach(partname in level.rumbforclient.partnamesview) {
    curstates[partname] = 1;
  }

  self.rumb.curstates = curstates;
}

function teleport_player(object) {
  self setOrigin(object.origin);

  if(isDefined(object.angles)) {
    self setplayerangles(object.angles);
  }
}

function function_678eed0af59b69eb(breath, isbreathcritical, var_21c40030c467a5f6, var_247ffbb0ea77edf7) {
  if(isbreathcritical) {
    colormax = (0.15, 0.7, 0.7);
    colormin = (0.7, 0.4, 0.4);
    factor = math::normalize_value(0, var_21c40030c467a5f6, breath);
  } else {
    colormax = (0.1, 0.1, 0.1);
    colormin = (0.1, 0.5, 0.5);
    factor = math::normalize_value(var_21c40030c467a5f6, var_247ffbb0ea77edf7, breath);
  }

  color = math::factor_value(colormin, colormax, factor);
  return color;
}

function function_8196ea3bc8d5538a() {
  if(isDefined(level.var_fd357adea109f55)) {
    self thread[[level.var_fd357adea109f55]]();
  }
}

function function_1c0f3b6933eb1c87() {
  level endon("game_ended");
  flag_wait("player_spawned_with_loadout");
  level.player endon("death");
  level.foliagecontent = scripts\engine\trace::function_416688b9ffe933c4();
  shadow_vols = array_merge(getEntArray("shadow_vol", "targetname"), getEntArray("tall_grass_vol", "targetname"));
  level.var_1c0f3b6933eb1c87 = 1;

  while(true) {
    player_touching = 0;

    foreach(vol in shadow_vols) {
      if(level.player istouching(vol)) {
        player_touching += 1;
      }
    }

    if(player_touching > 0) {
      function_3b992a66c2e901bb(level.player, 1);
      level.var_1c0f3b6933eb1c87 = 1;
    } else if(function_ebf6c163be94738a()) {
      function_3b992a66c2e901bb(level.player, 1);
      level.var_1c0f3b6933eb1c87 = 1;
      player_touching = 1;
    } else {
      function_3b992a66c2e901bb(level.player, 0);
      level.var_1c0f3b6933eb1c87 = 0;
    }

    level.player function_d5ab926594e0b3f3(function_9bb204334d8c88e(player_touching));
    waitframe();
  }
}

function function_ebf6c163be94738a() {
  assertex(isDefined(level.foliagecontent), "Script expects there to be a predefined value of level.foliageContent in this level.");

  if(level.player getstance() == "stand") {
    return false;
  }

  if(!scripts\engine\trace::sphere_trace_passed(level.player getEye(), level.player getEye() - (0, 0, 15), 20, undefined, level.foliagecontent)) {
    return true;
  }

  return false;
}

function function_9bb204334d8c88e(var_bf8b0540bf4c4150) {
  if(level.player getstance() == "stand") {
    return false;
  }

  if(!isDefined(var_bf8b0540bf4c4150)) {
    return false;
  }

  if(var_bf8b0540bf4c4150 <= 0) {
    return false;
  }

  return true;
}

function function_d5ab926594e0b3f3(shoulddisplay) {
  if(self getclientomnvar("ui_display_foliage_vignette") != shoulddisplay) {
    self setclientomnvar("ui_display_foliage_vignette", shoulddisplay);
  }
}

function remove_damage_effects_instantly(var_2625c6f710d4e980) {
  self notify("stopPainOverlays");

  if(!isDefined(var_2625c6f710d4e980)) {
    var_2625c6f710d4e980 = 0;
  }

  self painvisionoff();

  if(utility::damageflag(2)) {
    scripts\cp\damage::disabledeathsdoor(1);
  }

  removefiredamageimmediate();
  removeradialdistortion(0);
  stopimpactsfx();

  if(!var_2625c6f710d4e980) {
    foreach(overlay in self.damage.activescreeneffectoverlays) {
      overlay notify("destroySreenEffectOverlay");
    }
  }

  if(isDefined(self.damage.overlay)) {
    self.damage.overlay destroy();
  }

  if(isDefined(self.damage.bloodoverlay)) {
    self.damage.bloodoverlay destroy();
  }

  if(isDefined(self.damage.deathsdooroverlaypulse)) {
    self.damage.deathsdooroverlaypulse destroy();
  }

  scripts\cp\damage::initdamageoverlay();
}

function removefiredamageimmediate() {
  if(!utility::damageflag(32)) {
    return;
  }

  self notify("damage_fire");
  self.damage.firedamage = 0;

  if(utility::damageflag(16)) {
    setplayeroutoffire();
  }

  setplayerofffire();
}

function removeradialdistortion(outtime) {
  childthread scripts\common\lighting::lerp_dvar(@ "hash_ed28298c207316ae", 0, outtime);
  childthread scripts\common\lighting::lerp_dvar(@ "hash_979b5474be3b9b47", 0, outtime);
  childthread scripts\common\lighting::lerp_dvar(@ "hash_960ef00238357bbc", 0, outtime);
  childthread scripts\common\lighting::lerp_dvar(@ "hash_bc02f8e41595c9a8", 0, outtime);
}

function stopimpactsfx() {
  self.damage.impactsfx stopsounds();
}

function setplayeroutoffire() {
  utility::setdamageflag(16, 0);
  firedamagegesturesoff();
}

function setplayerofffire() {
  self notify("damage_fire_off");
  utility::setdamageflag(32, 0);
  firedamagefxoff();
}

function firedamagegesturesoff() {
  if(!isDefined(level.player.firegesture)) {
    return;
  }

  level.player stopgestureviewmodel("ges_player_onfire", 0.5, 0);
  level.player val::reset_all("onfire");
  level.player.firegesture = undefined;
}

function firedamagefxoff() {
  self.damage.firevfx delete();
  self.damage.firerumble delete();
  thread fadeoverlayanddestroy(self.damage.firedamageoverlay, 1);
  thread fadeoverlayanddestroy(self.damage.firepainoverlay, 1);
  thread fadesoundanddelete(self.damage.firesfx, 1);
  thread fadesoundanddelete(self.damage.firedronesfx, 1);
  thread fadesoundanddelete(self.damage.firesmolsfx, 1);
  thread removeradialdistortion(0.5);
}

function fadeoverlayanddestroy(overlay, fadetime) {
  self endon("damage_fire");

  if(!isDefined(overlay)) {
    return;
  }

  overlay fadeovertime(fadetime);
  overlay.alpha = 0;
  wait fadetime;

  if(!isDefined(overlay)) {
    return;
  }

  overlay destroy();
}

function fadesoundanddelete(soundent, fadetime) {
  self endon("damage_fire");

  if(!isDefined(soundent)) {
    return;
  }

  wait fadetime;

  if(!isDefined(soundent)) {
    return;
  }

  soundent delete();
}