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
  var0 = level.juggksglobals;
  var1 = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("juggernaut", "initConfig")) {
    var1 = self[[scripts\cp_mp\utility\script_utility::getsharedfunc("juggernaut", "initConfig")]]();
  }

  var0.config = var1;
  var1.infiniteammo = 1;
  var1.infiniteammoupdaterate = 4;
  var1.maxhealth = 3000;
  var1.startinghealth = 3000;
  var2 = "iw8_ks_juggernaut_mp";

  if(scripts\common\utility::iscp()) {
    var2 = "iw8_ks_juggernaut_cp";
  }

  var1.suit = var2;
  var1.clothtype = "vestheavy";
  var1.classstruct.loadoutprimary = "iw8_minigunksjugg_mp";
  var1.classstruct.loadoutsecondary = "none";

  if(isDefined(level.battle_tracks_stopbattletracksforplayer)) {
    var1[[level.battle_tracks_stopbattletracksforplayer]]();
    return;
  }
}

function initmarker() {
  var0 = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("juggernaut", "levelData")) {
    var0 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("juggernaut", "levelData")]]("juggernaut");
  }

  var0.capturecallback = &oncratecaptured;
  var0.destroycallback = &oncratedestroyed;
  var0.activatecallback = &oncrateactivated;
  var0.headicon = "hud_icon_killstreak_juggernaut";
  var0.capturestring = &"KILLSTREAKS_HINTS/JUGG_CRATE_PICKUP";

  if(level.gametype != "br") {
    var0.friendlymodel = "military_carepackage_01_juggernaut";
    var0.enemymodel = "military_carepackage_01_juggernaut";
    return;
  }
}

function init_jugg_vo() {
  game["dialog"]["juggernaut_normal_breath"] = "juggernaut_breath";
  game["dialog"]["juggernaut_labored_breath"] = "juggernaut_labored_breath";
}

function tryusejuggernaut(var0) {
  var1 = scripts\cp_mp\utility\killstreak_utility::createstreakinfo("juggernaut", self);
  tryusejuggernautfromstruct(var1, var0);
}

function tryusejuggernautfromstruct(var0, var1) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("juggernaut", "canTriggerJuggernaut")) {
    if(!self[[scripts\cp_mp\utility\script_utility::getsharedfunc("juggernaut", "canTriggerJuggernaut")]](var0)) {
      return false;
    }
  }

  if(isDefined(level.killstreaktriggeredfunc)) {
    if(!level[[level.killstreaktriggeredfunc]](var0)) {
      return false;
    }
  }

  var2 = getdvarint("scr_ks_jugg_instant_use");

  if(var2 || istrue(var1)) {
    thread activatejugg(var0);
  } else {
    scripts\cp_mp\vehicles\vehicle_tracking::reservevehicle();
    var3 = getcompleteweaponname("deploy_juggernaut_mp");
    var4 = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_doweaponfireddeploy(var0, var3, "grenade_fire", undefined, undefined, &markerthrown);

    if(!istrue(var4)) {
      scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
      return false;
    }
  }

  if(isDefined(level.killstreakbeginusefunc)) {
    if(!level[[level.killstreakbeginusefunc]](var0)) {
      return false;
    }
  }

  return true;
}

function markerthrown(var0, var1, var2) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle", "incrementFauxVehicleCount")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle", "incrementFauxVehicleCount")]]();
  }

  var2.owner = self;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "logKillstreakEvent")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "logKillstreakEvent")]](var0.streakname, self.origin);
  }

  thread watchmarkeractivate(var2);
  var0 notify("killstreak_finished_with_deploy_weapon");
  return "success";
}

function watchmarkeractivate(var0) {
  level endon("game_ended");
  var1 = self.owner.angles;
  var2 = self.owner;
  self waittill("explode", var3);

  if(!isDefined(var2)) {
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
    var0.vehicleisreserved = 1;
    var4 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("juggernaut", "dropCrateFromScriptedHeli")]](var2, var2.team, "juggernaut", var3, var1, var1 + (0, 180, 0), var0);
    var2 thread scripts\cp_mp\killstreaks\airdrop::br_c130spawndone(var0, "airdrop");

    if(!isDefined(var4)) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
        var2[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/VEHICLE_REFUND_KILLSTREAK");
      }

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "awardKillstreakFromStruct")) {
        var2[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "awardKillstreakFromStruct")]](var0.mpstreaksysteminfo, "other");
        return;
      }

      return;
    }

    return;
  }

  scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();

  if(level.gametype == "br") {
    var5 = 1;
    var2 thread scripts\cp_mp\killstreaks\airdrop::ref_13669(var3, var5);
    return;
  }
}

function oncrateactivated(var0) {
  if(istrue(var0)) {
    playFX(scripts\engine\utility::getfx("juggernaut_crate_vfx"), self.origin);
    return;
  }
}

function oncratecaptured(var0) {
  var1 = self.data;

  if(istrue(var0.isjuggernaut)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airdrop", "awardKillstreak")) {
      self.streakinfo = var1;
      var0[[scripts\cp_mp\utility\script_utility::getsharedfunc("airdrop", "awardKillstreak")]](var1.streakname, var0, self);
    }

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airdrop", "showKillstreakSplash")) {
      var0[[scripts\cp_mp\utility\script_utility::getsharedfunc("airdrop", "showKillstreakSplash")]](var1.streakname, undefined, 1);
      return;
    }

    return;
  }

  activatejugg(var0, var1);
}

function oncratedestroyed(var0) {
  var1 = self.data;

  if(isDefined(level.killstreakfinishusefunc)) {
    level[[level.killstreakfinishusefunc]](var1);
    return;
  }
}

function activatejugg(var0) {
  var1 = level.juggksglobals;
  var2 = 0;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("juggernaut", "makeJuggernaut")) {
    var2 = self[[scripts\cp_mp\utility\script_utility::getsharedfunc("juggernaut", "makeJuggernaut")]](var1.config, var0);
  }

  if(!var2) {
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
  thread ref_144bd(var0);
  thread watchforjuggernautend(var0);
  thread ref_144bc(var0);

  if(level.gametype != "br" && !scripts\common\utility::iscp()) {
    thread modelaststandallowed();
    return;
  }
}

function modelaststandallowed() {
  self endon("disconnect");
  level endon("game_ended");
  self waittill("death");
  var0 = getcompleteweaponname("iw8_lm_dblmg_mp");
  self giveweapon(var0);
  var1 = self dropitem(var0);

  if(!isDefined(var1)) {
    self takeallweapons();
    return;
  }

  var1.objweapon = var0;
  var1.targetname = "dropped_weapon";

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("juggernaut", "watchPickup")) {
    var1 thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("juggernaut", "watchPickup")]](self);
  }

  waitframe();
  self takeallweapons();
}

function ref_144bd(var0) {
  self endon("disconnect");
  self endon("juggernaut_end");
  level waittill("game_ended");

  if(isDefined(self) && isDefined(var0)) {
    scripts\cp_mp\utility\killstreak_utility::ref_12aa7(var0);
    return;
  }
}

function watchforjuggernautend(var0) {
  level endon("game_ended");
  self endon("disconnect");
  var1 = self.juggcontext;
  self waittill("juggernaut_end");

  if(isDefined(self.operatorcustomization)) {
    if(isDefined(self.operatorcustomization.gender) && self.operatorcustomization.gender == "female") {
      self method_87aa("female");
    } else {
      self method_87aa("");
    }
  }

  self clearsoundsubmix("mp_juggernaut", 0.5);
  onjuggernautend(var0, var1);
}

function onjuggernautend(var0, var1) {
  if(level.gametype != "br") {
    if(isDefined(level.killstreakfinishusefunc)) {
      level[[level.killstreakfinishusefunc]](var0);
    }

    var0.onspray = 1;
    scripts\cp_mp\utility\killstreak_utility::ref_12aa7(var0);
  }

  cleanupjuggobjective(var1);
}

function ref_144bc(var0) {
  self endon("juggernaut_end");
  level endon("game_ended");
  var1 = self.juggcontext;
  self waittill("disconnect");
  cleanupjuggobjective(var1);
}

function createjuggobjective() {
  self setscriptablepartstate("compassicon", "juggHide", 0);

  if(istrue(level.vehicle_occupancy_forceweaponswitchallowed)) {
    var0 = 0;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "squadAsTeamEnabled")) {
      var0 = level[[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "squadAsTeamEnabled")]]();
    }

    var1 = getdvarint("scr_juggernaut_always_yellow", 0) == 1;

    if(var1) {
      self setscriptablepartstate("playerObjective", "juggernaut", 0);
      return;
    }

    self setscriptablepartstate("playerObjective", "juggernaut_big_team", 0);
    return;
  }

  var2 = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "requestObjectiveID")) {
    var2 = scripts\cp_mp\utility\script_utility::getsharedfunc("game", "requestObjectiveID");
  }

  if(isDefined(var2)) {
    var3 = [[var2]](99);
    self.juggcontext.juggobjid = var3;
    scripts\mp\objidpoolmanager::objective_add_objective(var3, "active", self.origin, "icon_minimap_juggernaut");
    scripts\mp\objidpoolmanager::objective_set_play_intro(var3, 0);
    scripts\mp\objidpoolmanager::objective_set_play_outro(var3, 0);

    foreach(var5 in level.players) {
      if(isDefined(var5)) {
        if(var5 != self) {
          scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(var3, var5);
          continue;
        }

        scripts\mp\objidpoolmanager::objective_playermask_hidefrom(var3, var5);
      }
    }

    scripts\mp\objidpoolmanager::update_objective_onentity(var3, self);
    scripts\mp\objidpoolmanager::update_objective_setbackground(var3, 1);

    if(level.teambased) {
      scripts\mp\objidpoolmanager::update_objective_ownerteam(var3, self.team);
      return;
    }

    scripts\mp\objidpoolmanager::ref_13fa2(var3, self);
    return;
  }
}

function cleanupjuggobjective(var0) {
  if(isDefined(self)) {
    self setscriptablepartstate("compassicon", "defaulticon", 0);
  }

  if(isDefined(self) && level.gametype == "br") {
    self setscriptablepartstate("playerObjective", "off", 0);
    return;
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "returnObjectiveID")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "returnObjectiveID")]](var0.juggobjid);
    return;
  }
}

function watchjuggernautweaponenduse(var0, var1) {
  self notifyonplayercommand("manual_switch_from_minigun", "+weapnext");
  thread removejuggernautweapononaction("switched_from_minigun", var1);
  thread removejuggernautweapononaction("minigun_ammo_depleted", var1);
  thread removejuggernautweapononaction("death");
  thread watchjuggernautweaponswitch(var0);
  thread watchjuggernautweaponammo(var0);
}

function watchjuggernautweaponswitch(var0) {
  self endon("death");
  self endon("disconnect");
  self endon("juggernaut_start");
  self endon("dropped_minigun");
  level endon("game_ended");

  for(;;) {
    scripts\engine\utility::ref_143a5("manual_switch_from_minigun", "weapon_pickup");

    if(self getcurrentweapon() != var0) {
      continue;
    }

    self notify("switched_from_minigun");
    break;
  }
}

function watchjuggernautweaponammo(var0) {
  self endon("death");
  self endon("disconnect");
  self endon("juggernaut_start");
  self endon("dropped_minigun");
  level endon("game_ended");

  for(;;) {
    var1 = self getweaponammoclip(var0);

    if(var1 <= 0) {
      self notify("minigun_ammo_depleted");
      break;
    }

    waitframe();
  }
}

function removejuggernautweapononaction(var0, var1) {
  self endon("disconnect");
  self endon("juggernaut_start");
  self endon("dropped_minigun");
  level endon("game_ended");
  self waittill(var0);
  dropjuggernautweapon(var0, var1);
}

function dropjuggernautweapon(var0, var1) {
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

  var2 = getcompleteweaponname("iw8_lm_dblmg_mp");

  if(var0 == "switched_from_minigun" || var0 == "used_ammo_box") {
    if(self hasweapon(var2)) {
      var3 = self dropitem(var2);
      var3.objweapon = var2;
      var3.targetname = "dropped_weapon";

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("juggernaut", "watchPickup")) {
        var3 thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("juggernaut", "watchPickup")]](self);
      }
    }
  } else if(var0 == "minigun_ammo_depleted") {
    if(self hasweapon(var2)) {
      thread delaytakeminigun(0.5, var2);
    }
  }

  if(isDefined(var1)) {
    self.lastdroppableweaponobj = var1;
    self switchtoweapon(var1);
  }

  self notify("dropped_minigun");
}

function delaytakeminigun(var0, var1) {
  self endon("death_or_disconnect");
  level endon("game_ended");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var0);
  self takeweapon(var1);
}