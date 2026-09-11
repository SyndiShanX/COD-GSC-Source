/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\tac_ops\roles_utility.gsc
************************************************/

function kitspawn() {
  if(istrue(self.tacopsstealthrole)) {
    givestealthperks();
    return;
  }
}

function kittoicon(var_0) {
  switch (var_0) {
    case 1:
    default:
      return "popup_safeguard_levelup";
    case 2:
      return "icon_ks_heli_attack_hud";
    case 8:
    case 3:
      return "icon_ks_air_super_hud";
    case 4:
      return "icon_ks_jugg_hud";
    case 5:
      return "icon_ks_sat_com_hud";
    case 6:
      return "popup_safeguard_revived";
    case 7:
      return "icon_ks_skylark_uav_hud";
    case 9:
      return "icon_ks_sentry_gun_hud";
    case 10:
      return "icon_ks_maniac_hud";
  }
}

function kittohintstring(var_0) {
  switch (var_0) {
    case 1:
    default:
      return &"MP/HOLD_TO_EQUIP_TACOPS_SPAWNER";
    case 2:
      return &"MP/HOLD_TO_EQUIP_TACOPS_COPTER";
    case 8:
    case 3:
      return &"MP/HOLD_TO_EQUIP_TACOPS_ARTILLERY";
    case 4:
      return &"MP/HOLD_TO_EQUIP_TACOPS_JUGG";
    case 5:
      return &"MP/HOLD_TO_EQUIP_TACOPS_SPOTTER";
    case 6:
      return &"MP/HOLD_TO_EQUIP_TACOPS_MEDIC";
    case 7:
      return &"MP/HOLD_TO_EQUIP_TACOPS_STEALTH";
    case 9:
      return &"MP/HOLD_TO_EQUIP_TACOPS_TURRET";
    case 10:
      return &"MP/HOLD_TO_EQUIP_TACOPS_GAS";
  }
}

function enabletacopsstations(var_0) {
  foreach(var_2 in var_0) {
    enabletacopskit(var_2);
  }
}

function initroles() {
  level.teamspotindices = [];
  level.teamspotindices["allies"] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
  level.teamspotindices["axis"] = [11, 12, 13, 14, 15, 16, 17, 18, 19, 20];
  thread managespotteromnvars();
}

function createtacopskitstation(var_0, var_1, var_2, var_3) {
  var_4 = spawn("script_model", var_1);
  var_4 setModel("prop_suitcase_bomb");
  var_4.kittype = var_0;
  var_4.forteam = var_2;

  if(!istrue(var_3)) {
    enabletacopskit(var_4);
  }

  if(!isDefined(level.tacopsstations)) {
    level.tacopsstations = [];
  }

  level.tacopsstations[level.tacopsstations.size] = var_4;
}

function enabletacopskit() {
  self makeusable();
  thread tacopskitsuseteamupdater();
  var_0 = kittoicon(self.kittype);
  self.curobjid = createkitobjective(var_0, self.forteam);
  scripts\mp\gameobjects::setusetext(&"MP/PLANTING_EXPLOSIVE");
  self setHintString(kittohintstring(self.kittype));
  self setusepriority(0);
  thread tacopskitstationonuse(level);
}

function tacopskitsuseteamupdater() {
  level endon("game_ended");
  self endon("death");

  for(;;) {
    setusablebyteam(self.forteam);
    level waittill("joined_team");
  }
}

function setusablebyteam(var_0) {
  foreach(var_2 in level.players) {
    if(var_2.team != var_0 || isDefined(var_2.tacopskit)) {
      self disableplayeruse(var_2);
      continue;
    }

    self enableplayeruse(var_2);
  }
}

function tacopskitstationonuse(var_0) {
  level endon("game_ended");
  var_0 waittill("trigger", var_1);
  var_1.tacopskit = var_0.kittype;
  var_2 = [];

  switch (var_0.kittype) {
    case 1:
    default:
      if(var_1.team == "allies") {
        scripts\mp\tac_ops\radio_utility::queue_dialogue("dx_mpb_ovl_rolesa_beacons", var_1);
      } else {
        scripts\mp\tac_ops\radio_utility::queue_dialogue("dx_mpb_aqcm_rolesb_beacons", var_1);
      }

      var_1 scripts\mp\supers::givesuper("super_tac_ops_spawn");
      var_1 scripts\mp\supers::givesuperpoints(400000);
      var_1.pers["tac_ops_super"] = "super_tac_ops_spawn";
      GscBinSkip0(0x2e, 0, &"MISC_MESSAGES_MP/TO_ALLY_ROLE_COMMAND_1");

    case 5:
      if(var_1.team == "allies") {
        scripts\mp\tac_ops\radio_utility::queue_dialogue("dx_mpb_ovl_rolesa_sigint", var_1);
      } else {
        scripts\mp\tac_ops\radio_utility::queue_dialogue("dx_mpb_aqcm_rolesb_intel", var_1);
      }

      grantspotterkit(var_1);
      var_1 scripts\mp\supers::givesuper("super_tacops_uav");
      var_1 scripts\mp\supers::givesuperpoints(400000);
      var_1.pers["tac_ops_super"] = "super_tacops_uav";
      GscBinSkip0(0x2e, 0, &"MISC_MESSAGES_MP/TO_ALLY_ROLE_SIGINT_1");

    case 2:
      scripts\mp\tac_ops\radio_utility::queue_dialogue("dx_mpb_ovl_rolesa_jtac", var_1);
      var_1 scripts\mp\supers::givesuper("super_tacops_heli");
      var_1 scripts\mp\supers::givesuperpoints(400000);
      var_1.pers["tac_ops_super"] = "super_tacops_heli";
      GscBinSkip0(0x2e, 0, &"MISC_MESSAGES_MP/TO_ALLY_ROLE_AIR_1");

    case 10:
      scripts\mp\tac_ops\radio_utility::queue_dialogue("dx_mpb_aqcm_rolesb_bio", var_1);
      var_1 scripts\mp\supers::givesuper("super_tac_ops_gas");
      var_1 scripts\mp\supers::givesuperpoints(400000);
      var_1.pers["tac_ops_super"] = "super_tac_ops_gas";
      var_1.tacopsgasrole = 1;
      GscBinSkip0(0x2e, 0, &"MISC_MESSAGES_MP_TO_ALLY_ROLE_GAS_1");

    case 8:
    case 3:
      scripts\mp\tac_ops\radio_utility::queue_dialogue("dx_mpb_ovl_rolesa_artillery", var_1);
      var_1 scripts\mp\supers::givesuper("super_tacops_artillery");
      var_1 scripts\mp\supers::givesuperpoints(400000);
      var_1.pers["tac_ops_super"] = "super_tacops_artillery";
      GscBinSkip0(0x2e, 0, &"MISC_MESSAGES_MP/TO_ALLY_ROLE_ARTILLERY_1");

    case 4:
      scripts\mp\tac_ops\radio_utility::queue_dialogue("dx_mpb_ovl_rolesa_armor", var_1);
      var_1 scripts\mp\supers::givesuper("super_tacops_juggernaut");
      var_1 scripts\mp\supers::givesuperpoints(400000);
      var_1.pers["tac_ops_super"] = "super_tacops_juggernaut";
      GscBinSkip0(0x2e, 0, &"MISC_MESSAGES_MP/TO_ALLY_ROLE_JUGG_1");

    case 7:
      scripts\mp\tac_ops\radio_utility::queue_dialogue("dx_mpb_aqcm_rolesb_scout", var_1);
      givestealthperks(var_1);
      GscBinSkip0(0x2e, 0, &"MISC_MESSAGES_MP/TO_ALLY_ROLE_STEALTH_1");

    case 6:
      if(var_1.team == "allies") {
        scripts\mp\tac_ops\radio_utility::queue_dialogue("dx_mpb_ovl_rolesa_medic8", var_1);
      } else {
        scripts\mp\tac_ops\radio_utility::queue_dialogue("dx_mpb_aqcm_rolesb_medic", var_1);
      }

      var_1 scripts\mp\supers::givesuper("super_tac_ops_supply_pack");
      var_1 scripts\mp\supers::givesuperpoints(400000);
      var_1.pers["tac_ops_super"] = "super_tac_ops_supply_pack";
      var_1.tacopsmedicrole = 1;
      GscBinSkip0(0x2e, 0, &"MISC_MESSAGES_MP/TO_ALLY_ROLE_MEDIC_1");

    case 9:
      scripts\mp\tac_ops\radio_utility::queue_dialogue("dx_mpb_aqcm_rolesb_engineer", var_1);
      var_1 scripts\mp\supers::givesuper("super_tacops_turret");
      var_1 scripts\mp\supers::givesuperpoints(400000);
      var_1.pers["tac_ops_super"] = "super_tacops_turret";
      GscBinSkip0(0x2e, 0, &"MISC_MESSAGES_MP/TO_ALLY_ROLE_ENGINEER_1");
  }

  thread describerole(var_1);
  disabletacopskitstationuse(var_1);
  var_0 delete();
}

function givestealthperks() {
  self.tacopsstealthrole = 1;
  scripts\mp\utility\perk::giveperk("specialty_coldblooded");
  scripts\mp\utility\perk::giveperk("specialty_tracker_jammer");
  scripts\mp\utility\perk::giveperk("specialty_blindeye");
  scripts\mp\utility\perk::giveperk("specialty_engineer");
  scripts\mp\utility\perk::giveperk("specialty_ghost");
}

function describerole(var_0) {
  foreach(var_2 in var_0) {
    scripts\mp\gametypes\tac_ops::tutorialprint(var_2, 5);
    wait 0.5;
  }
}

function disabletacopskitstationuse() {
  for(var_0 = 0; var_0 < level.tacopsstations.size; var_0++) {
    if(isDefined(level.tacopsstations[var_0])) {
      level.tacopsstations[var_0] disableplayeruse(self);
    }
  }

  var_1 = level.tacopskitobjectives[self.team];

  for(var_0 = 0; var_0 < var_1.size; var_0++) {
    if(isDefined(var_1[var_0])) {
      scripts\mp\objidpoolmanager::objective_playermask_hidefrom(var_1[var_0], self);
    }
  }
}

function createkitobjective(var_0, var_1) {
  var_2 = scripts\mp\objidpoolmanager::requestobjectiveid(10);

  if(var_2 == -1) {
    return -1;
  }

  scripts\mp\objidpoolmanager::objective_add_objective(var_2, "invisible", (0, 0, 0), var_0);
  scripts\mp\objidpoolmanager::update_objective_onentity(var_2, self);
  scripts\mp\objidpoolmanager::update_objective_state(var_2, "active");
  scripts\mp\objidpoolmanager::update_objective_icon(var_2, var_0);

  if(isDefined(level.objvisall)) {
    [[level.objvisall]](var_2);
  }

  if(!isDefined(level.tacopskitobjectives)) {
    level.tacopskitobjectives = [];
    level.tacopskitobjectives["allies"] = [];
    level.tacopskitobjectives["axis"] = [];
  }

  level.tacopskitobjectives[var_1][level.tacopskitobjectives[var_1].size] = var_2;
  scripts\mp\objidpoolmanager::objective_playermask_hidefromall(var_2);

  foreach(var_4 in level.players) {
    if(isDefined(var_4.team) && var_4.team == var_1) {
      scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(var_2, var_4);
      continue;
    }

    scripts\mp\objidpoolmanager::objective_playermask_hidefrom(var_2, var_4);
  }

  return var_2;
}

function latejointeamkitobjective() {
  if(!isDefined(level.tacopskitobjectives)) {
    return;
  }

  foreach(var_1 in level.tacopskitobjectives[self.team]) {
    scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(var_1, self);
  }

  foreach(var_1 in level.tacopskitobjectives[scripts\mp\utility\game::getotherteam(self.team)[0]]) {
    scripts\mp\objidpoolmanager::objective_playermask_hidefrom(var_1, self);
  }
}

function grantspotterkit() {
  thread spotterthink();
}

function managespotteromnvars() {
  level endon("game_ended");
  level.playertoomvarmap = [];
  level.playertoomnvarmap["allies"] = [];
  level.playertoomnvarmap["axis"] = [];
}

function listendisconnectspotted() {
  level endon("game_ended");
  self endon("listenDisconnectSpotted");
  self waittill("disconnect");
  recyclespotted(self);
}

function recyclespotted(var_0) {
  var_1 = var_0 getentitynumber();

  if(isDefined(level.playertoomnvarmap["allies"][var_1])) {
    var_2 = level.playertoomnvarmap["allies"][var_1];
    level.playertoomnvarmap["allies"][var_1] = undefined;
    level.teamspotindices["allies"][level.teamspotindices["allies"].size] = var_2;
  }

  if(isDefined(level.playertoomnvarmap["axis"][var_1])) {
    var_2 = level.playertoomnvarmap["axis"][var_1];
    level.playertoomnvarmap["axis"][var_1] = undefined;
    level.teamspotindices["axis"][level.teamspotindices["axis"].size] = var_2;
    return;
  }
}

function spotplayer(var_0) {
  if(!isDefined(var_0.tacopsspottedbyteam)) {
    thread spotexpire();
    var_0.tacopsspottedbyteam = scripts\mp\utility\game::getotherteam(var_0.team)[0];
    var_1 = scripts\mp\utility\teams::getteamdata(scripts\mp\utility\game::getotherteam(var_0.team)[0], "players");

    foreach(var_3 in var_1) {}

    return;
  }

  refreshspottimer(var_0);
}

function spotexpire() {
  self endon("disconnect");
  self endon("refresh_spot_timer");
  level endon("game_ended");
  scripts\engine\utility::waittill_notify_or_timeout("death", 3);
  unspotplayer(self);
}

function refreshspottimer(var_0) {
  var_0 notify("refresh_spot_timer");
  thread spotexpire();
}

function unspotplayer(var_0) {
  if(!isDefined(var_0.tacopsspottedbyteam)) {
    return;
  }

  var_1 = level.playertoomnvarmap[scripts\mp\utility\game::getotherteam(var_0.tacopsspottedbyteam)[0]];
  var_2 = scripts\mp\utility\teams::getteamdata(var_0.tacopsspottedbyteam, "players");
  var_0.tacopsspottedbyteam = undefined;

  foreach(var_4 in var_2) {}
}

function hackspottest(var_0) {
  wait 5;

  if(isbot(var_0) == 0) {
    thread spotterthink();
    return;
  }
}

function spotterthink() {
  for(;;) {
    var_0 = scripts\mp\utility\teams::getteamdata(scripts\mp\utility\game::getotherteam(self.team)[0], "players");

    foreach(var_2 in var_0) {
      if(!isDefined(var_2) || var_2 == self || !scripts\mp\utility\player::isreallyalive(var_2) || istrue(var_2.tacopsstealthrole)) {
        continue;
      }

      if(distancesquared(self getEye(), var_2 getEye()) < 7290000) {
        if(sighttracepassed(self getEye(), var_2 getEye(), 0, self)) {
          spotplayer(var_2);
        }
      }
    }

    wait 0.333;
  }
}

function throwsupplypack(var_0) {
  if(!isDefined(level.tacopssupplypacks)) {
    level.tacopssupplypacks = [];
  }

  if(!isDefined(level.tacopssupplypacks[var_0.owner.team])) {
    level.tacopssupplypacks[var_0.owner.team] = [];
  }

  var_1 = level.tacopssupplypacks[var_0.owner.team].size;

  if(var_1 >= 4) {
    var_2 = level.tacopssupplypacks[var_0.owner.team][0];
    level.tacopssupplypacks[var_0.owner.team] = scripts\engine\utility::array_remove_index(level.tacopssupplypacks[var_0.owner.team], 0);
    dovisualdeath(var_2);
  }

  var_0.team = var_0.owner.team;
  var_0.throwangles2d = (var_0.angles[0], var_0.angles[1], 0);
  var_0 waittill("missile_stuck");
  var_3 = createsupplypack(self, var_0.origin);
  var_1 = level.tacopssupplypacks[var_3.owner.team].size;
  level.tacopssupplypacks[var_0.owner.team][var_1] = var_3;
  var_0 delete();
}

function dovisualdeath() {
  self delete();
}

function supplypackmonitor() {
  level endon("game_ended");
  self waittill("death");
  dovisualdeath();
}

function beginusegas() {
  return true;
}

function beginusesupplypack() {
  self giveandfireoffhand("tac_ops_supply_pack_grenade_mp");
  return true;
}

function createsupplypack(var_0, var_1) {
  var_2 = "equipment";
  var_3 = 20;
  var_4 = 20;
  var_5 = spawn("script_model", var_1 + (0, 0, 10));
  var_6 = "equipment_resupply_bag";
  var_5 scriptmoverthermal();
  var_5 setModel(var_6);
  var_5.owner = var_0;
  var_5.team = var_0.team;
  var_5.type = var_2;
  var_7 = spawn("trigger_radius", var_1, 0, var_3, var_4);
  thread watchsupplypackuse(var_7);
  thread watchsupplypackdeath(var_7);
  return var_5;
}

function watchsupplypackdeath(var_0) {
  self endon("death");
  var_0 waittill("death");

  if(isDefined(self)) {
    self delete();
    return;
  }
}

function watchsupplypackuse(var_0) {
  self endon("death");

  for(;;) {
    self waittill("trigger", var_1);

    if(!isPlayer(var_1) || !isalive(var_1)) {
      continue;
    }

    level.tacopssupplypacks[var_0.team] = scripts\engine\utility::array_remove(level.tacopssupplypacks[var_0.team], var_0);
    var_1.health = var_1.maxhealth;
    scripts\mp\weapons::scavengergiveammo(var_1);
    var_1 playlocalsound("scavenger_pack_pickup");
    var_0 delete();
  }
}

function granthelicopterpilot() {
  scripts\mp\supers::givesuper("super_tacops_heli", 1);
}

function usehelicopterpilot() {
  return true;
}

function useartilleryrole() {
  return true;
}

function useturretrole() {
  return true;
}

function watchturretdeployfailed(var_0) {
  self endon("disconnect");
  self endon("microTurret_spawned");
  self endon("microTurret_end");
  self waittill("equip_deploy_end", var_1, var_2, var_3, var_4);
  scripts\mp\supers::givesuperpoints(400000);
}

function useuavrole() {
  return true;
}

function usejuggernautrole() {
  thread scripts\mp\gametypes\cmd::givejuggernaut();
  return true;
}