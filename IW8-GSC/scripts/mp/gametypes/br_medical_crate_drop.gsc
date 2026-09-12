/**********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_medical_crate_drop.gsc
**********************************************************/

function init() {
  level.medical_crates = [];
  var_0 = scripts\cp_mp\killstreaks\airdrop::getleveldata("medical_crate");
  var_0.capturestring = &"MP/GENERIC_LOOT_CRATE_CAPTURE";
  var_0.dummymodel = "military_carepackage_01_br_medical";
  var_0.friendlymodel = undefined;
  var_0.enemymodel = undefined;
  var_0.mountmantlemodel = undefined;
  var_0.supportsownercapture = 0;
  var_0.headicon = undefined;
  var_0.minimapicon = undefined;
  var_0.usepriority = -1;
  var_0.usefov = 180;
  var_0.timeout = undefined;
  var_0.friendlyuseonly = 0;
  var_0.ownerusetime = 1.5;
  var_0.otherusetime = 1.5;
  var_0.activatecallback = &brmedicalcrateactivatecallback;
  var_0.capturecallback = &brmedicalcratecapturecallback;
  var_0.destroyoncapture = 1;
  level.medical_crate = spawnStruct();
  level.medical_crate.revive_items = [["brloot_self_revive", 1], ["brloot_self_revive", 1], ["brloot_zmb_stim", 4]];
  level.medical_crate.tactical_equipment = [["brloot_health_adrenaline", 2]];
  level.medical_crate.perks_points = [["brloot_perk_point_quick_fix", 1], ["brloot_perk_point_quick_fix", 1], ["brloot_perk_point_cold_blooded", 1], ["brloot_perk_point_cold_blooded", 1]];
}

function brmedicalcrateactivatecallback(var_0) {
  if(istrue(var_0)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airdrop", "registerCrateForCleanup")) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("airdrop", "registerCrateForCleanup")]](self);
    }
  }

  level.medical_crates[level.medical_crates.size] = self;
}

function brmedicalcratecapturecallback(var_0) {
  if(isDefined(self.ref_13428)) {
    self.ref_13428 setscriptablepartstate("smoke_signal", "off", 0);
    self.ref_13428 delete();
  }

  level.medical_crates = scripts\engine\utility::array_remove(level.medical_crates, self);
  medical_crate_loot_distribution();
}

function medical_crate_loot_distribution() {
  var_0 = [];

  foreach(var_2 in level.medical_crate.revive_items) {
    var_0 = var_2;
  }

  foreach(var_2 in level.medical_crate.tactical_equipment) {
    var_0 = var_2;
  }

  foreach(var_2 in level.medical_crate.perks_points) {
    var_0 = var_2;
  }

  var_8 = scripts\mp\gametypes\br_pickups::test_ai_anim();

  foreach(var_2 in var_0) {
    var_10 = var_2[0];

    if(var_10 == "brloot_zmb_stim") {
      scripts\mp\gametypes\br_gametype_zxp::spawnlootsyringe(self.origin, self.angles, self, 4);
      continue;
    }

    if(scripts\mp\gametypes\br_lootcache::get_bonus_targets(var_10)) {
      var_11 = level.br_pickups.delay_hide_player_clip[var_10];

      if(isDefined(var_11) && var_11 == 4) {
        var_12 = scripts\mp\gametypes\br_lootcache::ref_11A41(var_10, var_8, self.origin, self.angles, 0, 1);
        var_13 = 1;
      } else {
        var_12 = scripts\mp\gametypes\br_lootcache::ref_11A41(var_14, var_9, self.origin, self.angles, 0, 0);
      }

      var_12.count = var_3[1];
    }
  }

  var_10 = undefined;
  var_11 = undefined;
}

function medical_crate_cleanup() {
  playFX(level.conf_fx["vanish"], self.origin);

  if(isDefined(self.ref_13428)) {
    self.ref_13428 setscriptablepartstate("smoke_signal", "off", 0);
    self.ref_13428 delete();
  }

  level.medical_crates = scripts\engine\utility::array_remove(level.medical_crates, self);
  scripts\cp_mp\killstreaks\airdrop::lastactivateinstruct();
}

function getusetimeoverride() {
  var_0 = scripts\cp_mp\killstreaks\airdrop::getleveldata("medical_crate");
  return var_0.ownerusetime;
}