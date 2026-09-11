/************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_heavy_weapon_drop_x2.gsc
************************************************************/

function init() {
  level.shutdownattractionicontrigger = [];
  var_0 = scripts\cp_mp\killstreaks\airdrop::getleveldata("heavy_weapon_crate");
  var_0.capturestring = &"MP/GENERIC_LOOT_CRATE_CAPTURE";
  var_0.dummymodel = "military_carepackage_01_br_legendary";
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
  var_0.ownerusetime = 0.5;
  var_0.otherusetime = 0.5;
  var_0.activatecallback = &signal_nag;
  var_0.capturecallback = &signal_strength;
  var_0.destroycallback = &signal_yaw;
  var_0.ingame = &signalomnvar;
  var_0.destroyoncapture = 1;
  level.shrink_poi_into_the_bank = spawnStruct();
  var_1 = getdvarint("x2_heavy_drop_loadout", 0);
  level.shrink_poi_into_the_bank.equipment = remove_from_bomb_detonator_waiting_for_pick_up_array(var_1);
}

function remove_from_bomb_detonator_waiting_for_pick_up_array(var_0) {
  switch (var_0) {
    case 1:
      return [["brloot_super_munitionsbox", 8]];
    default:
      return [["brloot_weapon_lm_dblmg_lege", 1], ["brloot_weapon_ar_t9british_lege", 1], ["brloot_weapon_ar_t9accurate_lege", 1], ["brloot_weapon_la_mike32_lege", 1]];
  }
}

function signal_nag(var_0) {
  if(istrue(var_0)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airdrop", "registerCrateForCleanup")) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("airdrop", "registerCrateForCleanup")]](self);
    }
  }

  level.shutdownattractionicontrigger[level.shutdownattractionicontrigger.size] = self;
}

function signal_strength(var_0) {
  if(isDefined(self.ref_13428)) {
    self.ref_13428 setscriptablepartstate("smoke_signal", "off", 0);
    self.ref_13428 delete();
  }

  level.shutdownattractionicontrigger = scripts\engine\utility::array_remove(level.shutdownattractionicontrigger, self);
  shut_down_station();
}

function signal_yaw(var_0) {
  if(isDefined(self.ref_13428)) {
    self.ref_13428 setscriptablepartstate("smoke_signal", "off", 0);
    self.ref_13428 delete();
  }

  level.shutdownattractionicontrigger = scripts\engine\utility::array_remove(level.shutdownattractionicontrigger, self);
}

function signalomnvar(var_0, var_1) {
  self setscriptablepartstate("crate_audio", "detach", 0);
}

function shut_down_station() {
  var_0 = [];
  var_1 = 0;
  var_2 = scripts\mp\gametypes\br_pickups::test_ai_anim();

  foreach(var_4 in level.shrink_poi_into_the_bank.equipment) {
    var_5 = var_4[0];
    var_6 = var_4[1];

    if(scripts\mp\gametypes\br_lootcache::get_bonus_targets(var_5)) {
      for(var_7 = 0; var_7 < var_6; var_7++) {
        var_8 = scripts\mp\gametypes\br_lootcache::ref_11a41(var_5, var_2, self.origin, self.angles, 0, 1);
      }
    }
  }
}

function shut_down_laser_trap() {
  playFX(level.conf_fx["vanish"], self.origin);

  if(isDefined(self.ref_13428)) {
    self.ref_13428 setscriptablepartstate("smoke_signal", "off", 0);
    self.ref_13428 delete();
  }

  level.shutdownattractionicontrigger = scripts\engine\utility::array_remove(level.shutdownattractionicontrigger, self);
  scripts\cp_mp\killstreaks\airdrop::lastactivateinstruct();
}