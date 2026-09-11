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

function kittoicon(var0) {
  switch (var0) {
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

function kittohintstring(var0) {
  switch (var0) {
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

function enabletacopsstations(var0) {
  foreach(var2 in var0) {
    enabletacopskit(var2);
  }
}

function initroles() {
  level.teamspotindices = [];
  level.teamspotindices["allies"] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
  level.teamspotindices["axis"] = [11, 12, 13, 14, 15, 16, 17, 18, 19, 20];
  thread managespotteromnvars();
}

function createtacopskitstation(var0, var1, var2, var3) {
  var4 = spawn("script_model", var1);
  var4 setModel("prop_suitcase_bomb");
  var4.kittype = var0;
  var4.forteam = var2;

  if(!istrue(var3)) {
    enabletacopskit(var4);
  }

  if(!isDefined(level.tacopsstations)) {
    level.tacopsstations = [];
  }

  level.tacopsstations[level.tacopsstations.size] = var4;
}

function enabletacopskit() {
  self makeusable();
  thread tacopskitsuseteamupdater();
  var0 = kittoicon(self.kittype);
  self.curobjid = createkitobjective(var0, self.forteam);
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

function setusablebyteam(var0) {
  foreach(var2 in level.players) {
    if(var2.team != var0 || isDefined(var2.tacopskit)) {
      self disableplayeruse(var2);
      continue;
    }

    self enableplayeruse(var2);
  }
}

function tacopskitstationonuse(var0) {
  level endon("game_ended");
  var0 waittill("trigger", var1);
  var1.tacopskit = var0.kittype;
  var2 = [];

  switch (var0.kittype) {
    case 1:
    default:
      if(var1.team == "allies") {
        scripts\mp\tac_ops\radio_utility::queue_dialogue("dx_mpb_ovl_rolesa_beacons", var1);
      } else {
        scripts\mp\tac_ops\radio_utility::queue_dialogue("dx_mpb_aqcm_rolesb_beacons", var1);
      }

      var1 scripts\mp\supers::givesuper("super_tac_ops_spawn");
      var1 scripts\mp\supers::givesuperpoints(400000);
      var1.pers["tac_ops_super"] = "super_tac_ops_spawn";
      GscBinSkip0(0x2e, 0, &"MISC_MESSAGES_MP/TO_ALLY_ROLE_COMMAND_1");

    case 5:
      if(var1.team == "allies") {
        scripts\mp\tac_ops\radio_utility::queue_dialogue("dx_mpb_ovl_rolesa_sigint", var1);
      } else {
        scripts\mp\tac_ops\radio_utility::queue_dialogue("dx_mpb_aqcm_rolesb_intel", var1);
      }

      grantspotterkit(var1);
      var1 scripts\mp\supers::givesuper("super_tacops_uav");
      var1 scripts\mp\supers::givesuperpoints(400000);
      var1.pers["tac_ops_super"] = "super_tacops_uav";
      GscBinSkip0(0x2e, 0, &"MISC_MESSAGES_MP/TO_ALLY_ROLE_SIGINT_1");

    case 2:
      scripts\mp\tac_ops\radio_utility::queue_dialogue("dx_mpb_ovl_rolesa_jtac", var1);
      var1 scripts\mp\supers::givesuper("super_tacops_heli");
      var1 scripts\mp\supers::givesuperpoints(400000);
      var1.pers["tac_ops_super"] = "super_tacops_heli";
      GscBinSkip0(0x2e, 0, &"MISC_MESSAGES_MP/TO_ALLY_ROLE_AIR_1");

    case 10:
      scripts\mp\tac_ops\radio_utility::queue_dialogue("dx_mpb_aqcm_rolesb_bio", var1);
      var1 scripts\mp\supers::givesuper("super_tac_ops_gas");
      var1 scripts\mp\supers::givesuperpoints(400000);
      var1.pers["tac_ops_super"] = "super_tac_ops_gas";
      var1.tacopsgasrole = 1;
      GscBinSkip0(0x2e, 0, &"MISC_MESSAGES_MP_TO_ALLY_ROLE_GAS_1");

    case 8:
    case 3:
      scripts\mp\tac_ops\radio_utility::queue_dialogue("dx_mpb_ovl_rolesa_artillery", var1);
      var1 scripts\mp\supers::givesuper("super_tacops_artillery");
      var1 scripts\mp\supers::givesuperpoints(400000);
      var1.pers["tac_ops_super"] = "super_tacops_artillery";
      GscBinSkip0(0x2e, 0, &"MISC_MESSAGES_MP/TO_ALLY_ROLE_ARTILLERY_1");

    case 4:
      scripts\mp\tac_ops\radio_utility::queue_dialogue("dx_mpb_ovl_rolesa_armor", var1);
      var1 scripts\mp\supers::givesuper("super_tacops_juggernaut");
      var1 scripts\mp\supers::givesuperpoints(400000);
      var1.pers["tac_ops_super"] = "super_tacops_juggernaut";
      GscBinSkip0(0x2e, 0, &"MISC_MESSAGES_MP/TO_ALLY_ROLE_JUGG_1");

    case 7:
      scripts\mp\tac_ops\radio_utility::queue_dialogue("dx_mpb_aqcm_rolesb_scout", var1);
      givestealthperks(var1);
      GscBinSkip0(0x2e, 0, &"MISC_MESSAGES_MP/TO_ALLY_ROLE_STEALTH_1");

    case 6:
      if(var1.team == "allies") {
        scripts\mp\tac_ops\radio_utility::queue_dialogue("dx_mpb_ovl_rolesa_medic8", var1);
      } else {
        scripts\mp\tac_ops\radio_utility::queue_dialogue("dx_mpb_aqcm_rolesb_medic", var1);
      }

      var1 scripts\mp\supers::givesuper("super_tac_ops_supply_pack");
      var1 scripts\mp\supers::givesuperpoints(400000);
      var1.pers["tac_ops_super"] = "super_tac_ops_supply_pack";
      var1.tacopsmedicrole = 1;
      GscBinSkip0(0x2e, 0, &"MISC_MESSAGES_MP/TO_ALLY_ROLE_MEDIC_1");

    case 9:
      scripts\mp\tac_ops\radio_utility::queue_dialogue("dx_mpb_aqcm_rolesb_engineer", var1);
      var1 scripts\mp\supers::givesuper("super_tacops_turret");
      var1 scripts\mp\supers::givesuperpoints(400000);
      var1.pers["tac_ops_super"] = "super_tacops_turret";
      GscBinSkip0(0x2e, 0, &"MISC_MESSAGES_MP/TO_ALLY_ROLE_ENGINEER_1");
  }

  thread describerole(var1);
  disabletacopskitstationuse(var1);
  var0 delete();
}

function givestealthperks() {
  self.tacopsstealthrole = 1;
  scripts\mp\utility\perk::giveperk("specialty_coldblooded");
  scripts\mp\utility\perk::giveperk("specialty_tracker_jammer");
  scripts\mp\utility\perk::giveperk("specialty_blindeye");
  scripts\mp\utility\perk::giveperk("specialty_engineer");
  scripts\mp\utility\perk::giveperk("specialty_ghost");
}

function describerole(var0) {
  foreach(var2 in var0) {
    scripts\mp\gametypes\tac_ops::tutorialprint(var2, 5);
    wait 0.5;
  }
}

function disabletacopskitstationuse() {
  for(var0 = 0; var0 < level.tacopsstations.size; var0++) {
    if(isDefined(level.tacopsstations[var0])) {
      level.tacopsstations[var0] disableplayeruse(self);
    }
  }

  var1 = level.tacopskitobjectives[self.team];

  for(var0 = 0; var0 < var1.size; var0++) {
    if(isDefined(var1[var0])) {
      scripts\mp\objidpoolmanager::objective_playermask_hidefrom(var1[var0], self);
    }
  }
}

function createkitobjective(var0, var1) {
  var2 = scripts\mp\objidpoolmanager::requestobjectiveid(10);

  if(var2 == -1) {
    return -1;
  }

  scripts\mp\objidpoolmanager::objective_add_objective(var2, "invisible", (0, 0, 0), var0);
  scripts\mp\objidpoolmanager::update_objective_onentity(var2, self);
  scripts\mp\objidpoolmanager::update_objective_state(var2, "active");
  scripts\mp\objidpoolmanager::update_objective_icon(var2, var0);

  if(isDefined(level.objvisall)) {
    [[level.objvisall]](var2);
  }

  if(!isDefined(level.tacopskitobjectives)) {
    level.tacopskitobjectives = [];
    level.tacopskitobjectives["allies"] = [];
    level.tacopskitobjectives["axis"] = [];
  }

  level.tacopskitobjectives[var1][level.tacopskitobjectives[var1].size] = var2;
  scripts\mp\objidpoolmanager::objective_playermask_hidefromall(var2);

  foreach(var4 in level.players) {
    if(isDefined(var4.team) && var4.team == var1) {
      scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(var2, var4);
      continue;
    }

    scripts\mp\objidpoolmanager::objective_playermask_hidefrom(var2, var4);
  }

  return var2;
}

function latejointeamkitobjective() {
  if(!isDefined(level.tacopskitobjectives)) {
    return;
  }

  foreach(var1 in level.tacopskitobjectives[self.team]) {
    scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(var1, self);
  }

  foreach(var1 in level.tacopskitobjectives[scripts\mp\utility\game::getotherteam(self.team)[0]]) {
    scripts\mp\objidpoolmanager::objective_playermask_hidefrom(var1, self);
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

function recyclespotted(var0) {
  var1 = var0 getentitynumber();

  if(isDefined(level.playertoomnvarmap["allies"][var1])) {
    var2 = level.playertoomnvarmap["allies"][var1];
    level.playertoomnvarmap["allies"][var1] = undefined;
    level.teamspotindices["allies"][level.teamspotindices["allies"].size] = var2;
  }

  if(isDefined(level.playertoomnvarmap["axis"][var1])) {
    var2 = level.playertoomnvarmap["axis"][var1];
    level.playertoomnvarmap["axis"][var1] = undefined;
    level.teamspotindices["axis"][level.teamspotindices["axis"].size] = var2;
    return;
  }
}

function spotplayer(var0) {
  if(!isDefined(var0.tacopsspottedbyteam)) {
    thread spotexpire();
    var0.tacopsspottedbyteam = scripts\mp\utility\game::getotherteam(var0.team)[0];
    var1 = scripts\mp\utility\teams::getteamdata(scripts\mp\utility\game::getotherteam(var0.team)[0], "players");

    foreach(var3 in var1) {}

    return;
  }

  refreshspottimer(var0);
}

function spotexpire() {
  self endon("disconnect");
  self endon("refresh_spot_timer");
  level endon("game_ended");
  scripts\engine\utility::waittill_notify_or_timeout("death", 3);
  unspotplayer(self);
}

function refreshspottimer(var0) {
  var0 notify("refresh_spot_timer");
  thread spotexpire();
}

function unspotplayer(var0) {
  if(!isDefined(var0.tacopsspottedbyteam)) {
    return;
  }

  var1 = level.playertoomnvarmap[scripts\mp\utility\game::getotherteam(var0.tacopsspottedbyteam)[0]];
  var2 = scripts\mp\utility\teams::getteamdata(var0.tacopsspottedbyteam, "players");
  var0.tacopsspottedbyteam = undefined;

  foreach(var4 in var2) {}
}

function hackspottest(var0) {
  wait 5;

  if(isbot(var0) == 0) {
    thread spotterthink();
    return;
  }
}

function spotterthink() {
  for(;;) {
    var0 = scripts\mp\utility\teams::getteamdata(scripts\mp\utility\game::getotherteam(self.team)[0], "players");

    foreach(var2 in var0) {
      if(!isDefined(var2) || var2 == self || !scripts\mp\utility\player::isreallyalive(var2) || istrue(var2.tacopsstealthrole)) {
        continue;
      }

      if(distancesquared(self getEye(), var2 getEye()) < 7290000) {
        if(sighttracepassed(self getEye(), var2 getEye(), 0, self)) {
          spotplayer(var2);
        }
      }
    }

    wait 0.333;
  }
}

function throwsupplypack(var0) {
  if(!isDefined(level.tacopssupplypacks)) {
    level.tacopssupplypacks = [];
  }

  if(!isDefined(level.tacopssupplypacks[var0.owner.team])) {
    level.tacopssupplypacks[var0.owner.team] = [];
  }

  var1 = level.tacopssupplypacks[var0.owner.team].size;

  if(var1 >= 4) {
    var2 = level.tacopssupplypacks[var0.owner.team][0];
    level.tacopssupplypacks[var0.owner.team] = scripts\engine\utility::array_remove_index(level.tacopssupplypacks[var0.owner.team], 0);
    dovisualdeath(var2);
  }

  var0.team = var0.owner.team;
  var0.throwangles2d = (var0.angles[0], var0.angles[1], 0);
  var0 waittill("missile_stuck");
  var3 = createsupplypack(self, var0.origin);
  var1 = level.tacopssupplypacks[var3.owner.team].size;
  level.tacopssupplypacks[var0.owner.team][var1] = var3;
  var0 delete();
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

function createsupplypack(var0, var1) {
  var2 = "equipment";
  var3 = 20;
  var4 = 20;
  var5 = spawn("script_model", var1 + (0, 0, 10));
  var6 = "equipment_resupply_bag";
  var5 scriptmoverthermal();
  var5 setModel(var6);
  var5.owner = var0;
  var5.team = var0.team;
  var5.type = var2;
  var7 = spawn("trigger_radius", var1, 0, var3, var4);
  thread watchsupplypackuse(var7);
  thread watchsupplypackdeath(var7);
  return var5;
}

function watchsupplypackdeath(var0) {
  self endon("death");
  var0 waittill("death");

  if(isDefined(self)) {
    self delete();
    return;
  }
}

function watchsupplypackuse(var0) {
  self endon("death");

  for(;;) {
    self waittill("trigger", var1);

    if(!isPlayer(var1) || !isalive(var1)) {
      continue;
    }

    level.tacopssupplypacks[var0.team] = scripts\engine\utility::array_remove(level.tacopssupplypacks[var0.team], var0);
    var1.health = var1.maxhealth;
    scripts\mp\weapons::scavengergiveammo(var1);
    var1 playlocalsound("scavenger_pack_pickup");
    var0 delete();
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

function watchturretdeployfailed(var0) {
  self endon("disconnect");
  self endon("microTurret_spawned");
  self endon("microTurret_end");
  self waittill("equip_deploy_end", var1, var2, var3, var4);
  scripts\mp\supers::givesuperpoints(400000);
}

function useuavrole() {
  return true;
}

function usejuggernautrole() {
  thread scripts\mp\gametypes\cmd::givejuggernaut();
  return true;
}