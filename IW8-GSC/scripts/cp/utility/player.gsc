/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\utility\player.gsc
***********************************************/

function getstancecenter() {
  if(self getstance() == "crouch") {
    var_0 = self.origin + (0, 0, 24);
  } else if(self getstance() == "prone") {
    var_0 = self.origin + (0, 0, 10);
  } else {
    var_0 = self.origin + (0, 0, 32);
  }

  return var_0;
}

function round_smoke_logic() {
  if(self getstance() == "crouch") {
    var_0 = self.origin + (0, 0, 48);
  } else if(self getstance() == "prone") {
    var_0 = self.origin + (0, 0, 20);
  } else {
    var_0 = self.origin + (0, 0, 64);
  }

  return var_0;
}

function isreallyalive(var_0) {
  return isalive(var_0) && !isDefined(var_0.fauxdead) && !istrue(self.delayedspawnedplayernotify);
}

function isarchetype(var_0) {
  return isDefined(self.loadoutarchetype) && var_0 == self.loadoutarchetype;
}

function isplayerads() {
  return self playerads() > 0.5;
}

function setthirdpersondof(var_0) {
  if(var_0) {
    setdof_thirdperson();
    return;
  }

  setdof_default();
}

function updatesessionstate(var_0, var_1) {
  switch (var_0) {
    case "playing":
    case "intermission":
      var_1 = "";
      break;
    case "dead":
    case "spectator":
      if(istrue(level.doingbroshot)) {
        var_1 = "";
      } else if(istrue(level.numlifelimited)) {
        if(istrue(self.tagavailable)) {
          var_1 = "hud_status_dogtag";
        } else if(istrue(self.revivetriggeravailable)) {
          if(isDefined(self.statusicon) && self.statusicon == "hud_status_revive_or") {
            var_1 = "hud_status_revive_or";
          } else {
            var_1 = "hud_status_revive_wh";
          }
        } else {
          var_1 = "hud_status_dead";
        }
      } else {
        var_1 = "hud_status_dead";
      }

      break;
  }

  if(!isDefined(var_1)) {
    var_1 = "";
  }

  self.sessionstate = var_0;
  self.statusicon = var_1;
  self setclientomnvar("ui_session_state", var_0);
}

function getteamarray(var_0, var_1) {
  var_2 = [];
  jumpiffalse(!isDefined(var_1) || var_1) LOC_0000005b;

  foreach(var_4 in level.characters) {
    if(isDefined(var_4.team) && var_4.team == var_0) {
      var_2 = var_4;
    }
  }

  goto LOC_0000009f;
}

function get_players_watching(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  var_2 = self getentitynumber();
  var_3 = [];

  foreach(var_5 in level.players) {
    if(var_5 == self) {
      continue;
    }

    var_6 = 0;

    if(!var_1) {
      if(isDefined(var_5.team) && (var_5.team == "spectator" || var_5.sessionstate == "spectator")) {
        var_7 = var_5 getspectatingplayer();

        if(isDefined(var_7) && var_7 == self) {
          var_6 = 1;
        }
      }

      if(var_5.forcespectatorclient == var_2) {
        var_6 = 1;
      }
    }

    if(!var_0) {
      if(var_5.killcamentity == var_2) {
        var_6 = 1;
      }
    }

    if(var_6) {
      var_3 = var_5;
    }
  }

  return var_3;
}

function set_visionset_for_watching_players(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = get_players_watching(var_4, var_5);

  foreach(var_8 in var_6) {
    var_8 notify("changing_watching_visionset");

    if(isDefined(var_3) && var_3) {
      var_8 visionsetmissilecamforplayer(var_0, var_1);
    } else {
      var_8 visionsetnakedforplayer(var_0, var_1);
    }

    if(var_0 != "" && isDefined(var_2)) {
      thread reset_visionset_on_team_change(var_8, self);
      thread reset_visionset_on_disconnect(var_8);

      if(isinkillcam(var_8)) {
        thread reset_visionset_on_spawn();
      }
    }
  }
}

function reset_visionset_on_spawn() {
  self endon("disconnect");
  self waittill("spawned");
  self visionsetnakedforplayer("", 0);
}

function reset_visionset_on_team_change(var_0, var_1) {
  self endon("changing_watching_visionset");
  var_2 = gettime();
  var_3 = self.team;

  while(gettime() - var_2 < var_1 * 1000) {
    if(self.team != var_3 || !scripts\engine\utility::array_contains(get_players_watching(var_0), self)) {
      self visionsetnakedforplayer("", 0);
      self notify("changing_visionset");
      break;
    }

    waitframe();
  }
}

function reset_visionset_on_disconnect(var_0) {
  self endon("changing_watching_visionset");
  var_0 waittill("disconnect");
  self visionsetnakedforplayer("", 0);
}

function restorebasevisionset(var_0) {
  if(istrue(level.wpinprogress)) {
    return;
  }

  self visionsetnakedforplayer("", var_0);
}

function init_visionsetnight() {
  if(isDefined(level.ref_11f4a) && isstring(level.ref_11f4a)) {
    visionsetnight(level.ref_11f4a);
    return;
  }

  visionsetnight("nvg_base_mp");
}

function overridevisionsetnightforlevel(var_0) {
  visionsetnight(var_0);
  level.ref_11f4a = var_0;
}

function ref_12c86() {
  level.ref_11f4a = undefined;
  visionsetnight("nvg_base_mp");
}

function isenemy(var_0) {
  if(level.teambased) {
    return (var_0.team != self.team);
  }

  if(isDefined(var_0.owner)) {
    return (var_0.owner != self);
  }

  return var_0 != self;
}

function getuniqueid() {
  if(!isDefined(self.pers)) {
    self.pers = [];
  }

  if(isDefined(self.pers["guid"])) {
    return self.pers["guid"];
  }

  var_0 = self getguid();

  if(var_0 == "0000000000000000") {
    if(isDefined(level.guidgen)) {
      level.guidgen++;
    } else {
      level.guidgen = 1;
    }

    var_0 = "script" + level.guidgen;
  }

  self.pers["guid"] = var_0;
  return self.pers["guid"];
}

function getplayersinradius(var_0, var_1, var_2, var_3) {
  var_4 = ["physicscontents_player"];
  return scripts\cp\utility\entity::getentitiesinradius(var_0, var_1, var_2, var_3, physics_createcontents(var_4));
}

function getplayersinradiusview(var_0, var_1, var_2, var_3) {
  var_4 = ["physicscontents_player"];
  var_5 = [];
  var_6 = scripts\cp\utility\entity::getentitiesinradius(var_0, var_1, var_2, var_3, physics_createcontents(var_4));

  foreach(var_8 in var_6) {
    var_9 = undefined;
    var_10 = [var_8 gettagorigin("j_head"), var_8 gettagorigin("j_mainroot"), var_8 gettagorigin("tag_origin")];

    for(var_11 = 0; var_11 < var_10.size; var_11++) {
      if(!scripts\engine\trace::ray_trace_passed(var_0, var_10[var_11], level.characters, scripts\engine\trace::create_contents(0, 1, 1, 1, 1, 1))) {
        continue;
      }

      if(!isDefined(var_9)) {
        var_5 = spawnStruct();
        var_5[var_5.size - 1].player = var_8;
        var_5[var_5.size - 1].visiblelocations = [];
        var_9 = 1;
      }

      var_5[var_5.size - 1].visiblelocations[var_5[var_5.size - 1].visiblelocations.size] = var_10[var_11];
    }
  }

  return var_5;
}

function isfriendly(var_0, var_1) {
  if(!level.teambased) {
    return false;
  }

  if(!isPlayer(var_1) && !isDefined(var_1.team)) {
    return false;
  }

  if(var_0 != var_1.team) {
    return false;
  }

  return true;
}

function _enablecollisionnotifies(var_0) {
  if(!isDefined(self.enabledcollisionnotifies)) {
    self.enabledcollisionnotifies = 0;
  }

  if(var_0) {
    if(self.enabledcollisionnotifies == 0) {
      self enablecollisionnotifies(1);
    }

    self.enabledcollisionnotifies++;
    return;
  }

  if(self.enabledcollisionnotifies == 1) {
    self enablecollisionnotifies(0);
  }

  self.enabledcollisionnotifies--;
}

function allow_dodge(var_0) {
  if(self.loadoutarchetype != "archetype_scout") {
    return;
  }

  if(var_0) {
    if(!isDefined(self.disableddodge)) {
      self.disableddodge = 0;
    }

    self.disableddodge--;

    if(!self.disableddodge) {
      self allowdodge(1);
      return;
    }

    return;
  }

  if(!isDefined(self.disableddodge)) {
    self.disableddodge = 0;
  }

  self.disableddodge++;
  self allowdodge(0);
}

function allow_gesture(var_0, var_1) {
  var_2 = scripts\common\input_allow::allow_input_internal("gesture", var_0, var_1);

  if(!isDefined(var_2)) {
    return;
  }

  if(var_0) {
    if(scripts\engine\utility::is_player_gamepad_enabled()) {
      self setactionslot(1, "taunt");
      return;
    }

    self setactionslot(7, "taunt");
    return;
  }

  if(scripts\engine\utility::is_player_gamepad_enabled()) {
    self setactionslot(1, "");
    return;
  }

  self setactionslot(7, "");
}

function isplayerproxyagent(var_0, var_1) {
  var_2 = 0;

  if(isagent(var_0) && isDefined(var_0.agent_type) && var_0.agent_type == "playerProxy") {
    if(var_0.owner == var_1) {
      var_2 = 1;
    }
  }

  return var_2;
}

function enableragdollzerog(var_0, var_1) {
  if(var_0) {
    physics_setgravityragdollscalar(var_1);
    level.ragdollzerog = 1;
    return;
  }

  physics_setgravityragdollscalar(1);
  level.ragdollzerog = undefined;
}

function isragdollzerog() {
  return istrue(level.ragdollzerog);
}

function _visionsetnaked(var_0, var_1) {
  foreach(var_3 in level.players) {
    if(!isDefined(var_3)) {
      continue;
    }

    if(isai(var_3)) {
      continue;
    }

    var_3 visionsetnakedforplayer(var_0, var_1);
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
  if(self.hidehudenabled == 1) {
    self setclientomnvar("ui_hide_hud", 0);
  }

  self.hidehudenabled--;
}

function hideminimap(var_0) {
  if(alwaysshowminimap() && !istrue(var_0)) {
    return;
  }

  if(!isDefined(self.minimapstatetracker)) {
    self.minimapstatetracker = 0;
  }

  var_1 = self.minimapstatetracker;
  self.minimapstatetracker--;

  if(self.minimapstatetracker < 0) {
    self.minimapstatetracker = 0;
  }

  if(istrue(var_0) || self.minimapstatetracker == 0 && var_1 > self.minimapstatetracker) {
    self setclientomnvar("ui_hide_minimap", 1);

    if(istrue(var_0)) {
      self.minimapstatetracker = 0;
      return;
    }

    return;
  }
}

function showminimap() {
  if(scripts\cp\utility::trophy_get_part_by_tag()) {
    return;
  }

  if(!isDefined(self.minimapstatetracker)) {
    self.minimapstatetracker = 0;
  }

  var_0 = self.minimapstatetracker;
  self.minimapstatetracker++;

  if(self.minimapstatetracker == 1 && var_0 < self.minimapstatetracker) {
    self setclientomnvar("ui_hide_minimap", 0);
    return;
  }
}

function alwaysshowminimap() {
  return istrue(level.minimaponbydefault) || level.gametype == "br" || level.gametype == "brm";
}

function isfemale() {
  return isDefined(self.operatorcustomization) && isDefined(self.operatorcustomization.gender) && self.operatorcustomization.gender == "female";
}

function getlowestclientnum(var_0, var_1) {
  var_2 = undefined;

  foreach(var_4 in var_0) {
    if(var_4.team != "spectator" && (!var_1 || var_4 scripts\cp_mp\utility\player_utility::_isalive())) {
      if(!isDefined(var_2) || var_4 getentitynumber() < var_2) {
        var_2 = var_4 getentitynumber();
      }
    }
  }

  return var_2;
}

function setusingremote(var_0) {
  if(isDefined(self.carryicon)) {
    self.carryicon.alpha = 0;
  }

  self.usingremote = var_0;
  scripts\common\utility::allow_vehicle_use(0);
  scripts\common\utility::allow_crate_use(0);
  scripts\common\utility::allow_offhand_weapons(0);
  scripts\common\utility::allow_ads(0);
  self setclientomnvar("ui_using_killstreak_remote", 1);
  self notify("using_remote");
}

function getremotename() {
  return self.usingremote;
}

function clearusingremote(var_0) {
  scripts\common\utility::allow_vehicle_use(1);
  scripts\common\utility::allow_crate_use(1);
  scripts\common\utility::allow_ads(1);

  if(isDefined(self.carryicon)) {
    self.carryicon.alpha = 1;
  }

  self.usingremote = undefined;

  if(!isDefined(var_0)) {
    scripts\common\utility::allow_offhand_weapons(1);
    scripts\cp\utility::_freezecontrols(0);
  }

  self setclientomnvar("ui_using_killstreak_remote", 0);
  self notify("stopped_using_remote");
}

function isusingremote() {
  return isDefined(self.usingremote);
}

function getplayerforguid(var_0) {
  foreach(var_2 in level.players) {
    if(var_2.guid == var_0) {
      return var_2;
    }
  }

  return undefined;
}

function set_temp_energy_restore_rate(var_0, var_1, var_2, var_3) {
  var_4 = self energy_getrestorerate(var_0);
  self.temprateset = 1;
  self energy_setrestorerate(var_0, var_1);

  if(!isDefined(var_3) || !var_3) {
    wait var_2;
  } else {
    var_5 = self energy_getmax(var_0);

    for(;;) {
      if(self energy_getenergy(var_0) >= var_5) {
        break;
      }

      waitframe();
    }
  }

  self energy_setrestorerate(var_0, var_4);
  self.temprateset = 0;
}

function set_temp_energy_rest_time(var_0, var_1, var_2, var_3) {
  var_4 = self energy_getresttimems(var_0);
  self.tempresttime = 1;
  self energy_setresttimems(var_0, var_1);

  if(!isDefined(var_3) || !var_3) {
    wait var_2;
  } else {
    var_5 = self energy_getmax(var_0);

    for(;;) {
      if(self energy_getenergy(var_0) >= var_5) {
        break;
      }

      waitframe();
    }
  }

  self energy_setresttimems(var_0, var_4);
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
  if(self.enabledignoreme == 1) {
    self.ignoreme = 0;
  }

  self.enabledignoreme--;
}

function _resetenableignoreme() {
  self.enabledignoreme = undefined;
  self.ignoreme = 0;
}

function watchbuttonPressed(var_0, var_1, var_2, var_3) {
  if(!isDefined(self.buttonspressed)) {
    self.buttonspressed = [];
  }

  if(!isDefined(self.buttonspressed[var_0])) {
    var_4 = spawnStruct();
    var_4.player = self;
    var_4.key = var_0;
    var_4.commanddown = var_1;
    var_4.commandup = var_2;
    var_4.notifydown = var_0 + "_buttonDown";
    var_4.notifyup = var_0 + "_buttonUp";
    var_4.pressed = istrue(var_3);
    self.buttonspressed[var_0] = var_4;
    thread watchbuttonpressedinternal();
    return;
  }
}

function getbuttonPressed(var_0) {
  if(!isDefined(self.buttonspressed)) {
    return 0;
  }

  if(!isDefined(self.buttonspressed[var_0])) {
    return 0;
  }

  return self.buttonspressed[var_0].pressed;
}

function watchbuttonpressedend(var_0) {
  if(!isDefined(self) || !isDefined(self.buttonspressed) || self.buttonspressed[var_0]) {
    return;
  }

  self.buttonspressed[var_0] notify("watchButtonPressedEnd");
  self.buttonspressed[var_0] = undefined;
}

function watchbuttonpressedinternal() {
  self.player endon("disconnect");
  self endon("watchButtonPressedEnd");
  self.down = 0;
  self.up = 0;
  GscBinSkip4(0x35);
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

function _setdof_internal(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(true) {
    return;
  }

  if(!isDefined(self)) {
    return;
  }

  var_0 = max(var_0, 0);
  var_1 = clamp(var_1, 1, 9994);
  var_2 = clamp(var_2, 2, 9998);
  var_3 = clamp(var_3, 3, 9999);

  if(var_2 > 9994) {
    var_5 = 0;
    return;
  }
}

function setdof_dynamic() {
  self endon("death_or_disconnect");
  setdof_default();

  if(isai(self)) {
    return;
  }

  var_0 = ["physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_solid", "physicscontents_vehicle", "physicscontents_player", "physicscontents_actor", "physicscontents_glass", "physicscontents_itemclip"];
  var_1 = physics_createcontents(var_0);
  var_2 = ["physicscontents_player"];
  var_3 = physics_createcontents(var_2);
  var_4 = 1;
  var_5 = 1;
  var_6 = cos(27);
  var_7 = 1;
  var_8 = 0;
  var_9 = [];
  GscBinSkip0(0x2e, "geo", spawnStruct());
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
  var_0 = ["physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_solid", "physicscontents_vehicle", "physicscontents_player", "physicscontents_actor", "physicscontents_glass", "physicscontents_itemclip"];
  var_1 = physics_createcontents(var_0);
  var_2 = vectorNormalize(self.origin - self.lastkilledby.origin);
  var_3 = self.origin + (0, 0, 42);
  var_4 = var_3 + var_2 * 120;
  var_5 = scripts\engine\trace::sphere_trace(var_3, var_4, 2, self, var_1, 0);
  var_6 = var_5["position"];

  while(istrue(self.usingcustomdof)) {
    if(!isDefined(self.lastkilledby)) {
      break;
    }

    var_7 = distance(var_6, self.lastkilledby.origin);
    var_8 = 0;
    var_9 = max(var_7 - 12, 1);
    var_10 = var_7 + 12;
    var_11 = var_10 + 50;
    var_12 = 8;
    var_13 = 4.5;
    _setdof_internal(var_8, var_9, var_10, var_11, var_12, var_13);
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

function enableplayerforspawnlogic(var_0, var_1) {
  var_2 = scripts\common\input_allow::allow_input_internal("spawn_ignore", var_0, var_1);

  if(isDefined(var_2)) {
    self ignorecharacterduringspawnselection(!var_2);
    return;
  }
}

function isplayerallowedforspawnlogic() {
  return scripts\common\input_allow::is_input_allowed_internal("spawn_ignore");
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

function waittillrecoveredhealth(var_0, var_1) {
  self endon("death_or_disconnect");
  var_2 = 0;

  if(!isDefined(var_1)) {
    var_1 = 0.05;
  }

  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  for(;;) {
    if(self.health != self.maxhealth) {
      var_2 = 0;
    } else {
      var_2 += var_1;
    }

    wait var_1;

    if(self.health == self.maxhealth && var_2 >= var_0) {
      break;
    }
  }
}

function allow_health_regen(var_0, var_1) {
  scripts\common\input_allow::allow_input_internal("health_regen", var_0, var_1);
}

function is_health_regen_allowed() {
  return scripts\common\input_allow::is_input_allowed_internal("health_regen");
}

function allow_one_hit_melee_victim(var_0, var_1) {
  scripts\common\input_allow::allow_input_internal("one_hit_melee_victim", var_0, var_1);
}

function is_one_hit_melee_victim_allowed() {
  return scripts\common\input_allow::is_input_allowed_internal("one_hit_melee_victim");
}

function allow_flashed(var_0, var_1) {
  scripts\common\input_allow::allow_input_internal("flashed", var_0, var_1);
}

function is_allowed_to_be_flashed() {
  return scripts\common\input_allow::is_input_allowed_internal("flashed");
}

function allow_stunned(var_0, var_1) {
  scripts\common\input_allow::allow_input_internal("stunned", var_0, var_1);
}

function is_allowed_to_be_stunned() {
  return scripts\common\input_allow::is_input_allowed_internal("stunned");
}

function allow_stick_kill(var_0, var_1) {
  scripts\common\input_allow::allow_input_internal("stick_kill", var_0, var_1);
}

function is_stick_kill_allowed() {
  return scripts\common\input_allow::is_input_allowed_internal("stick_kill");
}

function _setsuit(var_0) {
  self setsuit(var_0);
  self.suit = var_0;
}

function earthquake_for_client(var_0, var_1) {
  if(!isDefined(self.eq)) {
    init_earthquake_for_client();
  }

  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  var_2 = undefined;

  if(var_1) {
    var_2 = level.eqforclient.partnamesview[var_0];
  } else {
    var_2 = level.eqforclient.partnames[var_0];
  }

  var_3 = self.eq.curstates[var_2];
  var_4 = "active" + var_3;
  self setscriptablepartstate(var_2, var_4, 0);
  var_3++;

  if(var_3 > 4) {
    var_3 = scripts\engine\utility::mod(var_3, 4);
  }

  self.eq.curstates[var_2] = var_3;
}

function clear_earthquake_for_client() {
  if(!isDefined(self.eq)) {
    return;
  }

  if(!isDefined(level.eqforclient)) {
    init_earthquake();
  }

  foreach(var_1 in level.eqforclient.partnames) {
    self setscriptablepartstate(var_1, "neutral", 0);
  }

  foreach(var_1 in level.eqforclient.partnamesview) {
    self setscriptablepartstate(var_1, "neutral", 0);
  }

  self.eq = undefined;
}

function rumble_for_client(var_0, var_1) {
  if(!isDefined(self.rumb)) {
    init_rumble_for_client();
  }

  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  var_2 = undefined;

  if(var_1) {
    var_2 = level.rumbforclient.partnamesview[var_0];
  } else {
    var_2 = level.rumbforclient.partnames[var_0];
  }

  var_3 = self.rumb.curstates[var_2];
  var_4 = "active" + var_3;
  self setscriptablepartstate(var_2, var_4, 0);
  var_3++;

  if(var_3 > 4) {
    var_3 = scripts\engine\utility::mod(var_3, 4);
  }

  self.rumb.curstates[var_2] = var_3;
}

function clear_rumble_for_client() {
  if(!isDefined(self.rumb)) {
    return;
  }

  foreach(var_1 in level.rumbforclient.partnames) {
    self setscriptablepartstate(var_1, "neutral", 0);
  }

  foreach(var_1 in level.rumbforclient.partnamesview) {
    self setscriptablepartstate(var_1, "neutral", 0);
  }

  self.rumb = undefined;
}

function init_earthquake() {
  level.eqforclient = spawnStruct();
  var_0 = [];
  var_1 = "shakeeq";

  for(var_2 = 1; var_2 <= 4; var_2++) {
    var_0 = var_1 + var_2;
  }

  level.eqforclient.partnames = var_0;
  var_0 = [];
  var_1 = "shakeeqview";

  for(var_2 = 1; var_2 <= 4; var_2++) {
    var_0 = var_1 + var_2;
  }

  level.eqforclient.partnamesview = var_0;
}

function init_earthquake_for_client() {
  if(!isDefined(level.eqforclient)) {
    init_earthquake();
  }

  self.eq = spawnStruct();
  var_0 = [];

  foreach(var_2 in level.eqforclient.partnames) {
    var_0 = 1;
  }

  foreach(var_2 in level.eqforclient.partnamesview) {
    var_0 = 1;
  }

  self.eq.curstates = var_0;
}

function init_rumble() {
  level.rumbforclient = spawnStruct();
  var_0 = [];
  var_1 = "shakerumb";

  for(var_2 = 1; var_2 <= 4; var_2++) {
    var_0 = var_1 + var_2;
  }

  level.rumbforclient.partnames = var_0;
  var_0 = [];
  var_1 = "shakerumbview";

  for(var_2 = 1; var_2 <= 4; var_2++) {
    var_0 = var_1 + var_2;
  }

  level.rumbforclient.partnamesview = var_0;
}

function init_rumble_for_client() {
  if(!isDefined(level.rumbforclient)) {
    init_rumble();
  }

  self.rumb = spawnStruct();
  var_0 = [];

  foreach(var_2 in level.rumbforclient.partnames) {
    var_0 = 1;
  }

  foreach(var_2 in level.rumbforclient.partnamesview) {
    var_0 = 1;
  }

  self.rumb.curstates = var_0;
}