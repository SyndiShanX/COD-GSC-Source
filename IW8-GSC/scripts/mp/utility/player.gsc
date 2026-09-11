/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\utility\player.gsc
***********************************************/

function getstancecenter() {
  if(self getstance() == "crouch") {
    var0 = self.origin + (0, 0, 24);
  } else if(self getstance() == "prone") {
    var0 = self.origin + (0, 0, 10);
  } else {
    var0 = self.origin + (0, 0, 32);
  }

  return var0;
}

function round_smoke_logic(var0) {
  var1 = self getstance();

  if(isDefined(var0)) {
    var1 = var0;
  }

  if(var1 == "crouch") {
    var2 = self.origin + (0, 0, 48);
  } else if(var2 == "prone") {
    var2 = self.origin + (0, 0, 20);
  } else {
    var2 = self.origin + (0, 0, 64);
  }

  return var2;
}

function isreallyalive(var0) {
  return isalive(var0) && !isDefined(var0.fauxdead) && !istrue(var0.delayedspawnedplayernotify);
}

function unset_relic_trex(var0) {
  return isDefined(var0) && istrue(var0.inlaststand);
}

function isarchetype(var0) {
  return isDefined(self.loadoutarchetype) && var0 == self.loadoutarchetype;
}

function isplayerads() {
  return self playerads() > 0.5;
}

function setthirdpersondof(var0) {
  if(var0) {
    setdof_thirdperson();
    return;
  }

  setdof_default();
}

function updatesessionstate(var0, var1) {
  switch (var0) {
    case "playing":
    case "intermission":
      var1 = "";
      break;
    case "dead":
    case "spectator":
      if(istrue(level.doingbroshot)) {
        var1 = "";
      } else if(istrue(level.numlifelimited)) {
        if(istrue(self.tagavailable)) {
          var1 = "hud_status_dogtag";
        } else if(istrue(self.revivetriggeravailable)) {
          if(isDefined(self.statusicon) && self.statusicon == "hud_status_revive_or") {
            var1 = "hud_status_revive_or";
          } else {
            var1 = "hud_status_revive_wh";
          }
        } else {
          var1 = "hud_status_dead";
        }
      } else {
        var1 = "hud_status_dead";
      }

      break;
  }

  if(!isDefined(var1)) {
    var1 = "";
  }

  self.sessionstate = var0;
  self.statusicon = var1;
  self setclientomnvar("ui_session_state", var0);
  ref_12898("player::updateSessionState() " + var0);
}

function getteamarray(var0, var1) {
  var2 = [];
  jumpiffalse(!isDefined(var1) || var1) LOC_0000005b;

  foreach(var4 in level.characters) {
    if(isDefined(var4.team) && var4.team == var0) {
      var2 = var4;
    }
  }

  goto LOC_0000009f;
}

function get_players_watching(var0, var1) {
  if(!isDefined(var0)) {
    var0 = 0;
  }

  if(!isDefined(var1)) {
    var1 = 0;
  }

  var2 = self getentitynumber();
  var3 = [];

  foreach(var5 in level.players) {
    if(var5 == self) {
      continue;
    }

    var6 = 0;

    if(!var1) {
      if(isDefined(var5.team) && (var5.team == "spectator" || var5.team == "follower" || var5.sessionstate == "spectator")) {
        var7 = var5 getspectatingplayer();

        if(isDefined(var7) && var7 == self) {
          var6 = 1;
        }
      }

      if(var5.forcespectatorclient == var2) {
        var6 = 1;
      }
    }

    if(!var0) {
      if(var5.killcamentity == var2) {
        var6 = 1;
      }
    }

    if(var6) {
      var3 = var5;
    }
  }

  return var3;
}

function set_visionset_for_watching_players(var0, var1, var2, var3, var4, var5) {
  var6 = get_players_watching(var4, var5);

  foreach(var8 in var6) {
    var8 notify("changing_watching_visionset");

    if(isDefined(var3) && var3) {
      var8 visionsetmissilecamforplayer(var0, var1);
    } else {
      var8 visionsetnakedforplayer(var0, var1);
    }

    if(var0 != "" && isDefined(var2)) {
      thread reset_visionset_on_team_change(var8, self);
      thread reset_visionset_on_disconnect(var8);

      if(isinkillcam(var8)) {
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

function reset_visionset_on_team_change(var0, var1) {
  self endon("changing_watching_visionset");
  var2 = gettime();
  var3 = self.team;

  while(gettime() - var2 < var1 * 1000) {
    if(self.team != var3 || !scripts\engine\utility::array_contains(get_players_watching(var0), self)) {
      self visionsetnakedforplayer("", 0);
      self notify("changing_visionset");
      break;
    }

    waitframe();
  }
}

function reset_visionset_on_disconnect(var0) {
  self endon("changing_watching_visionset");
  var0 waittill("disconnect");
  self visionsetnakedforplayer("", 0);
}

function ref_12cc4(var0, var1) {
  if(!istrue(var1)) {
    if(istrue(level.wpinprogress)) {
      return;
    }
  }

  if(isDefined(level.ref_142d1)) {
    self visionsetnakedforplayer(level.ref_142d1, var0);
    return;
  }

  self visionsetnakedforplayer("", var0);
}

function ref_12cc5(var0) {
  ref_12cc4(var0, 1);
}

function restorebasevisionset(var0) {
  ref_12cc4(var0, undefined);
}

function init_visionsetnight() {
  visionsetnight("nvg_base_mp");
}

function overridevisionsetnightforlevel(var0) {
  visionsetnight(var0);
}

function isenemy(var0) {
  if(level.teambased) {
    if(isDefined(var0.team)) {
      return (var0.team != self.team);
    }

    return 0;
  }

  if(isDefined(var0.owner)) {
    return (var0.owner != self);
  }

  return var0 != self;
}

function getuniqueid() {
  if(isDefined(self.pers["guid"])) {
    return self.pers["guid"];
  }

  var0 = self getguid();

  if(var0 == "0000000000000000") {
    if(isDefined(level.guidgen)) {
      level.guidgen++;
    } else {
      level.guidgen = 1;
    }

    var0 = "script" + level.guidgen;
  }

  self.pers["guid"] = var0;
  return self.pers["guid"];
}

function getplayersinradius(var0, var1, var2, var3) {
  var4 = ["physicscontents_player"];
  return scripts\mp\utility\entity::getentitiesinradius(var0, var1, var2, var3, physics_createcontents(var4));
}

function getplayersinradiusview(var0, var1, var2, var3) {
  var4 = ["physicscontents_player"];
  var5 = [];
  var6 = scripts\mp\utility\entity::getentitiesinradius(var0, var1, var2, var3, physics_createcontents(var4));

  foreach(var8 in var6) {
    var9 = undefined;
    var10 = [var8 gettagorigin("j_head"), var8 gettagorigin("j_mainroot"), var8 gettagorigin("tag_origin")];

    for(var11 = 0; var11 < var10.size; var11++) {
      if(!scripts\engine\trace::ray_trace_passed(var0, var10[var11], level.characters, scripts\engine\trace::create_contents(0, 1, 1, 1, 1, 1))) {
        continue;
      }

      if(!isDefined(var9)) {
        var5 = spawnStruct();
        var5[var5.size - 1].player = var8;
        var5[var5.size - 1].visiblelocations = [];
        var9 = 1;
      }

      var5[var5.size - 1].visiblelocations[var5[var5.size - 1].visiblelocations.size] = var10[var11];
    }
  }

  return var5;
}

function isfriendly(var0, var1) {
  if(!level.teambased) {
    return false;
  }

  if(!isPlayer(var1) && !isDefined(var1.team)) {
    return false;
  }

  if(var0 != var1.team) {
    return false;
  }

  return true;
}

function _enablecollisionnotifies(var0) {
  if(!isDefined(self.enabledcollisionnotifies)) {
    self.enabledcollisionnotifies = 0;
  }

  if(var0) {
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

function allow_dodge(var0) {
  if(self.loadoutarchetype != "archetype_scout") {
    return;
  }

  if(var0) {
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

function allow_gesture(var0, var1) {
  var2 = scripts\common\input_allow::allow_input_internal("gesture", var0, var1);

  if(!isDefined(var2)) {
    return;
  }

  if(var0) {
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

function isplayerproxyagent(var0, var1) {
  var2 = 0;

  if(isagent(var0) && isDefined(var0.agent_type) && var0.agent_type == "playerProxy") {
    if(var0.owner == var1) {
      var2 = 1;
    }
  }

  return var2;
}

function enableragdollzerog(var0, var1) {
  if(var0) {
    physics_setgravityragdollscalar(var1);
    level.ragdollzerog = 1;
    return;
  }

  physics_setgravityragdollscalar(1);
  level.ragdollzerog = undefined;
}

function isragdollzerog() {
  return istrue(level.ragdollzerog);
}

function _visionsetnaked(var0, var1) {
  foreach(var3 in level.players) {
    if(!isDefined(var3)) {
      continue;
    }

    if(isai(var3)) {
      continue;
    }

    var3 visionsetnakedforplayer(var0, var1);
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

function spawn_carriables_from_scriptables_total_percentage() {
  self.hidehudenabled = undefined;
  self setclientomnvar("ui_hide_hud", 0);
}

function hideminimap(var0) {
  if(alwaysshowminimap() && !istrue(var0)) {
    return;
  }

  if(!isDefined(self.minimapstatetracker)) {
    self.minimapstatetracker = 0;
  }

  var1 = self.minimapstatetracker;
  self.minimapstatetracker--;

  if(self.minimapstatetracker < 0) {
    self.minimapstatetracker = 0;
  }

  if(istrue(var0) || self.minimapstatetracker == 0 && var1 > self.minimapstatetracker) {
    self setclientomnvar("ui_hide_minimap", 1);

    if(istrue(var0)) {
      self.minimapstatetracker = 0;
      return;
    }

    return;
  }
}

function showminimap() {
  if(!isDefined(self.minimapstatetracker)) {
    self.minimapstatetracker = 0;
  }

  var0 = self.minimapstatetracker;
  self.minimapstatetracker++;

  if(self.minimapstatetracker == 1 && var0 < self.minimapstatetracker) {
    self setclientomnvar("ui_hide_minimap", 0);
    return;
  }
}

function alwaysshowminimap() {
  if(level.gametype == "brm") {
    return true;
  }

  var0 = scripts\cp_mp\utility\game_utility::isrealismenabled();

  if(level.gametype == "br" && !var0) {
    return true;
  }

  return istrue(level.minimaponbydefault);
}

function isfemale() {
  return isDefined(self.operatorcustomization) && isDefined(self.operatorcustomization.gender) && self.operatorcustomization.gender == "female";
}

function getlowestclientnum(var0, var1) {
  var2 = undefined;

  foreach(var4 in var0) {
    if(var4.team != "spectator" && var4.team != "follower" && (!var1 || var4 scripts\cp_mp\utility\player_utility::_isalive())) {
      if(!isDefined(var2) || var4 getentitynumber() < var2) {
        var2 = var4 getentitynumber();
      }
    }
  }

  return var2;
}

function setusingremote(var0) {
  if(isDefined(self.carryicon)) {
    self.carryicon.alpha = 0;
  }

  self.usingremote = var0;

  if(scripts\cp_mp\utility\game_utility::isnightmap()) {
    scripts\common\utility::brjugg_oncrateuse(0);
  }

  scripts\common\utility::allow_vehicle_use(0);
  scripts\common\utility::allow_crate_use(0);
  scripts\common\utility::allow_offhand_weapons(0);
  scripts\common\utility::allow_ads(0);
  scripts\common\utility::brjugg_droponplayerdeath(0);
  scripts\cp_mp\killstreaks\white_phosphorus::enableloopingcoughaudiosupression();
  self setclientomnvar("ui_using_killstreak_remote", 1);
  self notify("using_remote");
  self.pers["distTrackingPassed"] = 1;
}

function getremotename() {
  return self.usingremote;
}

function clearusingremote(var0) {
  if(scripts\cp_mp\utility\game_utility::isnightmap()) {
    scripts\common\utility::brjugg_oncrateuse(1);
  }

  scripts\common\utility::allow_vehicle_use(1);
  scripts\common\utility::allow_crate_use(1);
  scripts\common\utility::allow_ads(1);
  scripts\common\utility::brjugg_droponplayerdeath(1);
  scripts\cp_mp\killstreaks\white_phosphorus::disableloopingcoughaudiosupression();

  if(isDefined(self.carryicon)) {
    self.carryicon.alpha = 1;
  }

  self.usingremote = undefined;

  if(!isDefined(var0)) {
    scripts\common\utility::allow_offhand_weapons(1);
    _freezecontrols(0, undefined, "usingRemote");
  }

  self setclientomnvar("ui_using_killstreak_remote", 0);
  self notify("stopped_using_remote");
}

function isusingremote() {
  return isDefined(self.usingremote);
}

function _freezecontrols(var0, var1, var2) {
  if(!isDefined(self.pers)) {
    return;
  }

  if(!isDefined(self.pers["controllerFreezeStack"])) {
    self.pers["controllerFreezeStack"] = 0;
    self.pers["controllerFreezeDebug"] = [];
  }

  if(var0) {
    self.pers["controllerFreezeStack"]++;
  } else if(istrue(var1)) {
    self.pers["controllerFreezeStack"] = 0;
  } else {
    self.pers["controllerFreezeStack"]--;
  }

  if(isDefined(var2)) {
    if(var0) {
      if(!isDefined(self.pers["controllerFreezeDebug"][var2])) {
        self.pers["controllerFreezeDebug"][var2] = 0;
      }

      self.pers["controllerFreezeDebug"][var2]++;
    } else if(istrue(var1)) {
      self.pers["controllerFreezeDebug"] = [];
    } else if(!isDefined(self.pers["controllerFreezeDebug"][var2]) || self.pers["controllerFreezeDebug"][var2] == 0) {} else {
      self.pers["controllerFreezeDebug"][var2]--;

      if(self.pers["controllerFreezeDebug"][var2] == 0) {
        self.pers["controllerFreezeDebug"][var2] = undefined;
      }
    }
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

function ai_offhandfiremanager() {
  var0 = 0;

  if(isDefined(self.pers["controllerFreezeStack"])) {
    var0 = self.pers["controllerFreezeStack"];
  }

  if(var0 <= 0) {
    return;
  }

  var1 = "";

  if(isDefined(self.pers["controllerFreezeDebug"])) {
    foreach(var3 in self.pers["controllerFreezeDebug"]) {
      var1 += var4 + "=" + var3 + " | ";
    }
  }

  var5 = "Current _freezeControls() stack size: " + var0 + " contexts: " + var1;
  logstring(var5);
}

function _freezelookcontrols(var0, var1) {
  if(!isDefined(self.pers)) {
    return;
  }

  if(!isDefined(self.pers["controllerLookFreezeStack"])) {
    self.pers["controllerLookFreezeStack"] = 0;
  }

  if(var0) {
    self.pers["controllerLookFreezeStack"]++;
  } else if(istrue(var1)) {
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

function getplayerforguid(var0) {
  foreach(var2 in level.players) {
    if(var2.guid == var0) {
      return var2;
    }
  }

  return undefined;
}

function set_temp_energy_restore_rate(var0, var1, var2, var3) {
  var4 = self energy_getrestorerate(var0);
  self.temprateset = 1;
  self energy_setrestorerate(var0, var1);

  if(!isDefined(var3) || !var3) {
    wait var2;
  } else {
    var5 = self energy_getmax(var0);

    for(;;) {
      if(self energy_getenergy(var0) >= var5) {
        break;
      }

      waitframe();
    }
  }

  self energy_setrestorerate(var0, var4);
  self.temprateset = 0;
}

function set_temp_energy_rest_time(var0, var1, var2, var3) {
  var4 = self energy_getresttimems(var0);
  self.tempresttime = 1;
  self energy_setresttimems(var0, var1);

  if(!isDefined(var3) || !var3) {
    wait var2;
  } else {
    var5 = self energy_getmax(var0);

    for(;;) {
      if(self energy_getenergy(var0) >= var5) {
        break;
      }

      waitframe();
    }
  }

  self energy_setresttimems(var0, var4);
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

function watchbuttonPressed(var0, var1, var2, var3) {
  if(!isDefined(self.buttonspressed)) {
    self.buttonspressed = [];
  }

  if(!isDefined(self.buttonspressed[var0])) {
    var4 = spawnStruct();
    var4.player = self;
    var4.key = var0;
    var4.commanddown = var1;
    var4.commandup = var2;
    var4.notifydown = var0 + "_buttonDown";
    var4.notifyup = var0 + "_buttonUp";
    var4.pressed = istrue(var3);
    self.buttonspressed[var0] = var4;
    thread watchbuttonpressedinternal();
    return;
  }
}

function getbuttonPressed(var0) {
  if(!isDefined(self.buttonspressed)) {
    return 0;
  }

  if(!isDefined(self.buttonspressed[var0])) {
    return 0;
  }

  return self.buttonspressed[var0].pressed;
}

function watchbuttonpressedend(var0) {
  if(!isDefined(self) || !isDefined(self.buttonspressed) || self.buttonspressed[var0]) {
    return;
  }

  self.buttonspressed[var0] notify("watchButtonPressedEnd");
  self.buttonspressed[var0] = undefined;
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

function _setdof_internal(var0, var1, var2, var3, var4, var5) {
  if(true) {
    return;
  }

  if(!isDefined(self)) {
    return;
  }

  var0 = max(var0, 0);
  var1 = clamp(var1, 1, 9994);
  var2 = clamp(var2, 2, 9998);
  var3 = clamp(var3, 3, 9999);

  if(var2 > 9994) {
    var5 = 0;
    return;
  }
}

function setdof_dynamic() {
  self endon("death_or_disconnect");
  setdof_default();

  if(isai(self)) {
    return;
  }

  var0 = ["physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_solid", "physicscontents_vehicle", "physicscontents_player", "physicscontents_actor", "physicscontents_glass", "physicscontents_itemclip"];
  var1 = physics_createcontents(var0);
  var2 = ["physicscontents_player"];
  var3 = physics_createcontents(var2);
  var4 = 1;
  var5 = 1;
  var6 = cos(27);
  var7 = 1;
  var8 = 0;
  var9 = [];
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
  var0 = ["physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_solid", "physicscontents_vehicle", "physicscontents_player", "physicscontents_actor", "physicscontents_glass", "physicscontents_itemclip"];
  var1 = physics_createcontents(var0);
  var2 = vectorNormalize(self.origin - self.lastkilledby.origin);
  var3 = self.origin + (0, 0, 42);
  var4 = var3 + var2 * 120;
  var5 = scripts\engine\trace::sphere_trace(var3, var4, 2, self, var1, 0);
  var6 = var5["position"];

  while(istrue(self.usingcustomdof)) {
    if(!isDefined(self.lastkilledby)) {
      break;
    }

    var7 = distance(var6, self.lastkilledby.origin);
    var8 = 0;
    var9 = max(var7 - 12, 1);
    var10 = var7 + 12;
    var11 = var10 + 50;
    var12 = 8;
    var13 = 4.5;
    _setdof_internal(var8, var9, var10, var11, var12, var13);
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

function enableplayerforspawnlogic(var0, var1) {
  var2 = scripts\common\input_allow::allow_input_internal("spawn_ignore", var0, var1);

  if(isDefined(var2)) {
    self ignorecharacterduringspawnselection(!var2);
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

function waittillrecoveredhealth(var0, var1) {
  self endon("death_or_disconnect");
  var2 = 0;

  if(!isDefined(var1)) {
    var1 = 0.05;
  }

  if(!isDefined(var0)) {
    var0 = 0;
  }

  for(;;) {
    if(self.health != self.maxhealth) {
      var2 = 0;
    } else {
      var2 += var1;
    }

    wait var1;

    if(self.health == self.maxhealth && var2 >= var0) {
      break;
    }
  }
}

function allow_health_regen(var0, var1) {
  scripts\common\input_allow::allow_input_internal("health_regen", var0, var1);
}

function is_health_regen_allowed() {
  return scripts\common\input_allow::is_input_allowed_internal("health_regen");
}

function allow_one_hit_melee_victim(var0, var1) {
  scripts\common\input_allow::allow_input_internal("one_hit_melee_victim", var0, var1);
}

function is_one_hit_melee_victim_allowed() {
  return scripts\common\input_allow::is_input_allowed_internal("one_hit_melee_victim");
}

function allow_flashed(var0, var1) {
  scripts\common\input_allow::allow_input_internal("flashed", var0, var1);
}

function is_allowed_to_be_flashed() {
  return scripts\common\input_allow::is_input_allowed_internal("flashed");
}

function allow_stunned(var0, var1) {
  scripts\common\input_allow::allow_input_internal("stunned", var0, var1);
}

function is_allowed_to_be_stunned() {
  return scripts\common\input_allow::is_input_allowed_internal("stunned");
}

function allow_stick_kill(var0, var1) {
  scripts\common\input_allow::allow_input_internal("stick_kill", var0, var1);
}

function is_stick_kill_allowed() {
  return scripts\common\input_allow::is_input_allowed_internal("stick_kill");
}

function _setsuit(var0) {
  if(isDefined(self.suit) && self.suit == var0) {
    return;
  }

  self setsuit(var0);
  self.suit = var0;
}

function ref_1328c(var0, var1) {
  if(!self isscriptable() || !self getscriptablehaspart("wind") || !isreallyalive(self)) {
    return;
  }

  self.manualoverridewindmaterial = var1;
  self setscriptablepartstate("wind", var0, 0);
}

function ref_12898(var0) {
  if(getdvarint("scr_debug_spawn_print", 0) == 1) {
    if(isDefined(self.spawncameraent)) {
      return;
    }

    return;
  }
}

function ref_1312b(var0) {
  self.beingrevived = var0;
  self setisusingspecialist(var0);
}

function registerpuzzleinteractions() {
  return istrue(self.beingrevived) || istrue(self.usedprops);
}