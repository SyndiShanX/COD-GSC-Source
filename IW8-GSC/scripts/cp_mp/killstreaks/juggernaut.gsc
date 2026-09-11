/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\killstreaks\juggernaut.gsc
****************************************************/

function init() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("juggernaut", "init")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("juggernaut", "init")]]();
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("juggernaut", "registerActionSet")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("juggernaut", "registerActionSet")]]();
  }

  level.juggksglobals = spawnStruct();
  level._effect["juggernaut_crate_vfx"] = loadfx("vfx/iw8_mp/killstreak/vfx_jugg_carepackage_smoke.vfx");
  initconfig();
  initmarker();
  init_jugg_vo();
  scripts\cp_mp\utility\killstreak_utility::registervisibilityomnvarforkillstreak("juggernaut", "mask_on", 1);
  scripts\cp_mp\utility\killstreak_utility::registervisibilityomnvarforkillstreak("juggernaut", "mask_damage_low", 2);
  scripts\cp_mp\utility\killstreak_utility::registervisibilityomnvarforkillstreak("juggernaut", "mask_damage_med", 3);
  scripts\cp_mp\utility\killstreak_utility::registervisibilityomnvarforkillstreak("juggernaut", "mask_damage_high", 4);
  scripts\cp_mp\utility\killstreak_utility::registervisibilityomnvarforkillstreak("juggernaut", "mask_damage_critical", 5);
}

function initconfig() {
  var_0 = level.juggksglobals;
  var_1 = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("juggernaut", "initConfig")) {
    var_1 = self[[scripts\cp_mp\utility\script_utility::getsharedfunc("juggernaut", "initConfig")]]();
  }

  var_0.config = var_1;
  var_1.infiniteammo = 1;
  var_1.infiniteammoupdaterate = 4;
  var_1.maxhealth = 3000;
  var_1.startinghealth = 3000;
  var_2 = "iw8_ks_juggernaut_mp";

  if(scripts\common\utility::iscp()) {
    var_2 = "iw8_ks_juggernaut_cp";
  }

  var_1.suit = var_2;
  var_1.clothtype = "vestheavy";
  var_1.classstruct.loadoutprimary = "iw8_minigunksjugg_mp";
  var_1.classstruct.loadoutsecondary = "none";

  if(isDefined(level.battle_tracks_stopbattletracksforplayer)) {
    var_1[[level.battle_tracks_stopbattletracksforplayer]]();
    return;
  }
}

function initmarker() {
  var_0 = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("juggernaut", "levelData")) {
    var_0 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("juggernaut", "levelData")]]("juggernaut");
  }

  var_0.capturecallback = &oncratecaptured;
  var_0.destroycallback = &oncratedestroyed;
  var_0.activatecallback = &oncrateactivated;
  var_0.headicon = "hud_icon_killstreak_juggernaut";
  var_0.capturestring = &"KILLSTREAKS_HINTS/JUGG_CRATE_PICKUP";

  if(level.gametype != "br") {
    var_0.friendlymodel = "military_carepackage_01_juggernaut";
    var_0.enemymodel = "military_carepackage_01_juggernaut";
    return;
  }
}

function init_jugg_vo() {
  game["dialog"]["juggernaut_normal_breath"] = "juggernaut_breath";
  game["dialog"]["juggernaut_labored_breath"] = "juggernaut_labored_breath";
}

function tryusejuggernaut(var_0) {
  var_1 = scripts\cp_mp\utility\killstreak_utility::createstreakinfo("juggernaut", self);
  tryusejuggernautfromstruct(var_1, var_0);
}

function tryusejuggernautfromstruct(var_0, var_1) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("juggernaut", "canTriggerJuggernaut")) {
    if(!self[[scripts\cp_mp\utility\script_utility::getsharedfunc("juggernaut", "canTriggerJuggernaut")]](var_0)) {
      return false;
    }
  }

  if(isDefined(level.killstreaktriggeredfunc)) {
    if(!level[[level.killstreaktriggeredfunc]](var_0)) {
      return false;
    }
  }

  var_2 = getdvarint("scr_ks_jugg_instant_use");

  if(var_2 || istrue(var_1)) {
    thread activatejugg(var_0);
  } else {
    scripts\cp_mp\vehicles\vehicle_tracking::reservevehicle();
    var_3 = getcompleteweaponname("deploy_juggernaut_mp");
    var_4 = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_doweaponfireddeploy(var_0, var_3, "grenade_fire", undefined, undefined, &markerthrown);

    if(!istrue(var_4)) {
      scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
      return false;
    }
  }

  if(isDefined(level.killstreakbeginusefunc)) {
    if(!level[[level.killstreakbeginusefunc]](var_0)) {
      return false;
    }
  }

  return true;
}

function markerthrown(var_0, var_1, var_2) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle", "incrementFauxVehicleCount")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle", "incrementFauxVehicleCount")]]();
  }

  var_2.owner = self;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "logKillstreakEvent")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "logKillstreakEvent")]](var_0.streakname, self.origin);
  }

  thread watchmarkeractivate(var_2);
  var_0 notify("killstreak_finished_with_deploy_weapon");
  return "success";
}

function watchmarkeractivate(var_0) {
  level endon("game_ended");
  var_1 = self.owner.angles;
  var_2 = self.owner;
  self waittill("explode", var_3);

  if(!isDefined(var_2)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle", "decrementFauxVehicleCount")) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle", "decrementFauxVehicleCount")]]();
    }

    scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
    return;
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle", "decrementFauxVehicleCount")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle", "decrementFauxVehicleCount")]]();
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("juggernaut", "dropCrateFromScriptedHeli") && level.gametype != "br") {
    var_0.vehicleisreserved = 1;
    var_4 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("juggernaut", "dropCrateFromScriptedHeli")]](var_2, var_2.team, "juggernaut", var_3, var_1, var_1 + (0, 180, 0), var_0);
    var_2 thread scripts\cp_mp\killstreaks\airdrop::br_c130spawndone(var_0, "airdrop");

    if(!isDefined(var_4)) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
        var_2[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/VEHICLE_REFUND_KILLSTREAK");
      }

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "awardKillstreakFromStruct")) {
        var_2[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "awardKillstreakFromStruct")]](var_0.mpstreaksysteminfo, "other");
        return;
      }

      return;
    }

    return;
  }

  scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();

  if(level.gametype == "br") {
    var_5 = 1;
    var_2 thread scripts\cp_mp\killstreaks\airdrop::ref_13669(var_3, var_5);
    return;
  }
}

function oncrateactivated(var_0) {
  if(istrue(var_0)) {
    playFX(scripts\engine\utility::getfx("juggernaut_crate_vfx"), self.origin);
    return;
  }
}

function oncratecaptured(var_0) {
  var_1 = self.data;

  if(istrue(var_0.isjuggernaut)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airdrop", "awardKillstreak")) {
      self.streakinfo = var_1;
      var_0[[scripts\cp_mp\utility\script_utility::getsharedfunc("airdrop", "awardKillstreak")]](var_1.streakname, var_0, self);
    }

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airdrop", "showKillstreakSplash")) {
      var_0[[scripts\cp_mp\utility\script_utility::getsharedfunc("airdrop", "showKillstreakSplash")]](var_1.streakname, undefined, 1);
      return;
    }

    return;
  }

  activatejugg(var_0, var_1);
}

function oncratedestroyed(var_0) {
  var_1 = self.data;

  if(isDefined(level.killstreakfinishusefunc)) {
    level[[level.killstreakfinishusefunc]](var_1);
    return;
  }
}

function activatejugg(var_0) {
  var_1 = level.juggksglobals;
  var_2 = 0;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("juggernaut", "makeJuggernaut")) {
    var_2 = self[[scripts\cp_mp\utility\script_utility::getsharedfunc("juggernaut", "makeJuggernaut")]](var_1.config, var_0);
  }

  if(!var_2) {
    return 0;
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("juggernaut", "playOperatorUseLine")) {
    level thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("juggernaut", "playOperatorUseLine")]](self);
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "teamPlayerCardSplash")) {
    level thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "teamPlayerCardSplash")]]("used_juggernaut", self);
  }

  createjuggobjective();

  if(isDefined(self.operatorcustomization.gender) && self.operatorcustomization.gender == "female") {
    self method_87aa("gasmask_female");
  } else {
    self method_87aa("gasmask_male");
  }

  self setsoundsubmix("mp_juggernaut", 0.5);
  thread ref_144bd(var_0);
  thread watchforjuggernautend(var_0);
  thread ref_144bc(var_0);

  if(level.gametype != "br" && !scripts\common\utility::iscp()) {
    thread modelaststandallowed();
    return;
  }
}

function modelaststandallowed() {
  self endon("disconnect");
  level endon("game_ended");
  self waittill("death");
  var_0 = getcompleteweaponname("iw8_lm_dblmg_mp");
  self giveweapon(var_0);
  var_1 = self dropitem(var_0);

  if(!isDefined(var_1)) {
    self takeallweapons();
    return;
  }

  var_1.objweapon = var_0;
  var_1.targetname = "dropped_weapon";

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("juggernaut", "watchPickup")) {
    var_1 thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("juggernaut", "watchPickup")]](self);
  }

  waitframe();
  self takeallweapons();
}

function ref_144bd(var_0) {
  self endon("disconnect");
  self endon("juggernaut_end");
  level waittill("game_ended");

  if(isDefined(self) && isDefined(var_0)) {
    scripts\cp_mp\utility\killstreak_utility::ref_12aa7(var_0);
    return;
  }
}

function watchforjuggernautend(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  var_1 = self.juggcontext;
  self waittill("juggernaut_end");

  if(isDefined(self.operatorcustomization)) {
    if(isDefined(self.operatorcustomization.gender) && self.operatorcustomization.gender == "female") {
      self method_87aa("female");
    } else {
      self method_87aa("");
    }
  }

  self clearsoundsubmix("mp_juggernaut", 0.5);
  onjuggernautend(var_0, var_1);
}

function onjuggernautend(var_0, var_1) {
  if(level.gametype != "br") {
    if(isDefined(level.killstreakfinishusefunc)) {
      level[[level.killstreakfinishusefunc]](var_0);
    }

    var_0.onspray = 1;
    scripts\cp_mp\utility\killstreak_utility::ref_12aa7(var_0);
  }

  cleanupjuggobjective(var_1);
}

function ref_144bc(var_0) {
  self endon("juggernaut_end");
  level endon("game_ended");
  var_1 = self.juggcontext;
  self waittill("disconnect");
  cleanupjuggobjective(var_1);
}

function createjuggobjective() {
  self setscriptablepartstate("compassicon", "juggHide", 0);

  if(istrue(level.vehicle_occupancy_forceweaponswitchallowed)) {
    var_0 = 0;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "squadAsTeamEnabled")) {
      var_0 = level[[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "squadAsTeamEnabled")]]();
    }

    var_1 = getdvarint("scr_juggernaut_always_yellow", 0) == 1;

    if(var_1) {
      self setscriptablepartstate("playerObjective", "juggernaut", 0);
      return;
    }

    self setscriptablepartstate("playerObjective", "juggernaut_big_team", 0);
    return;
  }

  var_2 = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "requestObjectiveID")) {
    var_2 = scripts\cp_mp\utility\script_utility::getsharedfunc("game", "requestObjectiveID");
  }

  if(isDefined(var_2)) {
    var_3 = [[var_2]](99);
    self.juggcontext.juggobjid = var_3;
    scripts\mp\objidpoolmanager::objective_add_objective(var_3, "active", self.origin, "icon_minimap_juggernaut");
    scripts\mp\objidpoolmanager::objective_set_play_intro(var_3, 0);
    scripts\mp\objidpoolmanager::objective_set_play_outro(var_3, 0);

    foreach(var_5 in level.players) {
      if(isDefined(var_5)) {
        if(var_5 != self) {
          scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(var_3, var_5);
          continue;
        }

        scripts\mp\objidpoolmanager::objective_playermask_hidefrom(var_3, var_5);
      }
    }

    scripts\mp\objidpoolmanager::update_objective_onentity(var_3, self);
    scripts\mp\objidpoolmanager::update_objective_setbackground(var_3, 1);

    if(level.teambased) {
      scripts\mp\objidpoolmanager::update_objective_ownerteam(var_3, self.team);
      return;
    }

    scripts\mp\objidpoolmanager::ref_13fa2(var_3, self);
    return;
  }
}

function cleanupjuggobjective(var_0) {
  if(isDefined(self)) {
    self setscriptablepartstate("compassicon", "defaulticon", 0);
  }

  if(isDefined(self) && level.gametype == "br") {
    self setscriptablepartstate("playerObjective", "off", 0);
    return;
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "returnObjectiveID")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "returnObjectiveID")]](var_0.juggobjid);
    return;
  }
}

function watchjuggernautweaponenduse(var_0, var_1) {
  self notifyonplayercommand("manual_switch_from_minigun", "+weapnext");
  thread removejuggernautweapononaction("switched_from_minigun", var_1);
  thread removejuggernautweapononaction("minigun_ammo_depleted", var_1);
  thread removejuggernautweapononaction("death");
  thread watchjuggernautweaponswitch(var_0);
  thread watchjuggernautweaponammo(var_0);
}

function watchjuggernautweaponswitch(var_0) {
  self endon("death");
  self endon("disconnect");
  self endon("juggernaut_start");
  self endon("dropped_minigun");
  level endon("game_ended");

  for(;;) {
    scripts\engine\utility::ref_143a5("manual_switch_from_minigun", "weapon_pickup");

    if(self getcurrentweapon() != var_0) {
      continue;
    }

    self notify("switched_from_minigun");
    break;
  }
}

function watchjuggernautweaponammo(var_0) {
  self endon("death");
  self endon("disconnect");
  self endon("juggernaut_start");
  self endon("dropped_minigun");
  level endon("game_ended");

  for(;;) {
    var_1 = self getweaponammoclip(var_0);

    if(var_1 <= 0) {
      self notify("minigun_ammo_depleted");
      break;
    }

    waitframe();
  }
}

function removejuggernautweapononaction(var_0, var_1) {
  self endon("disconnect");
  self endon("juggernaut_start");
  self endon("dropped_minigun");
  level endon("game_ended");
  self waittill(var_0);
  dropjuggernautweapon(var_0, var_1);
}

function dropjuggernautweapon(var_0, var_1) {
  self.ref_12346 = undefined;
  self.minigunprevweaponobject = undefined;
  self.playerstreakspeedscale = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("juggernaut", "updateMoveSpeedScale")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("juggernaut", "updateMoveSpeedScale")]]();
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("juggernaut", "allowActionSet")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("juggernaut", "allowActionSet")]]("fakeJugg", 1);
  }

  if(!istrue(level.loadout_updateammo)) {
    scripts\common\utility::allow_mount_top(1, "fakeJugg");
    scripts\common\utility::allow_mount_side(1, "fakeJugg");
  }

  var_2 = getcompleteweaponname("iw8_lm_dblmg_mp");

  if(var_0 == "switched_from_minigun" || var_0 == "used_ammo_box") {
    if(self hasweapon(var_2)) {
      var_3 = self dropitem(var_2);
      var_3.objweapon = var_2;
      var_3.targetname = "dropped_weapon";

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("juggernaut", "watchPickup")) {
        var_3 thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("juggernaut", "watchPickup")]](self);
      }
    }
  } else if(var_0 == "minigun_ammo_depleted") {
    if(self hasweapon(var_2)) {
      thread delaytakeminigun(0.5, var_2);
    }
  }

  if(isDefined(var_1)) {
    self.lastdroppableweaponobj = var_1;
    self switchtoweapon(var_1);
  }

  self notify("dropped_minigun");
}

function delaytakeminigun(var_0, var_1) {
  self endon("death_or_disconnect");
  level endon("game_ended");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_0);
  self takeweapon(var_1);
}