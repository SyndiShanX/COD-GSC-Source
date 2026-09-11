/************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_heavy_weapon_drop_x2.gsc
************************************************************/

function init() {
  level.shutdownattractionicontrigger = [];
  var0 = scripts\cp_mp\killstreaks\airdrop::getleveldata("heavy_weapon_crate");
  var0.capturestring = &"MP/GENERIC_LOOT_CRATE_CAPTURE";
  var0.dummymodel = "military_carepackage_01_br_legendary";
  var0.friendlymodel = undefined;
  var0.enemymodel = undefined;
  var0.mountmantlemodel = undefined;
  var0.supportsownercapture = 0;
  var0.headicon = undefined;
  var0.minimapicon = undefined;
  var0.usepriority = -1;
  var0.usefov = 180;
  var0.timeout = undefined;
  var0.friendlyuseonly = 0;
  var0.ownerusetime = 0.5;
  var0.otherusetime = 0.5;
  var0.activatecallback = &signal_nag;
  var0.capturecallback = &signal_strength;
  var0.destroycallback = &signal_yaw;
  var0.ingame = &signalomnvar;
  var0.destroyoncapture = 1;
  level.shrink_poi_into_the_bank = spawnStruct();
  var1 = getdvarint("x2_heavy_drop_loadout", 0);
  level.shrink_poi_into_the_bank.equipment = remove_from_bomb_detonator_waiting_for_pick_up_array(var1);
}

function remove_from_bomb_detonator_waiting_for_pick_up_array(var0) {
  switch (var0) {
    case 1:
      return [["brloot_super_munitionsbox", 8]];
    default:
      return [["brloot_weapon_lm_dblmg_lege", 1], ["brloot_weapon_ar_t9british_lege", 1], ["brloot_weapon_ar_t9accurate_lege", 1], ["brloot_weapon_la_mike32_lege", 1]];
  }
}

function signal_nag(var0) {
  if(istrue(var0)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airdrop", "registerCrateForCleanup")) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("airdrop", "registerCrateForCleanup")]](self);
    }
  }

  level.shutdownattractionicontrigger[level.shutdownattractionicontrigger.size] = self;
}

function signal_strength(var0) {
  if(isDefined(self.ref_13428)) {
    self.ref_13428 setscriptablepartstate("smoke_signal", "off", 0);
    self.ref_13428 delete();
  }

  level.shutdownattractionicontrigger = scripts\engine\utility::array_remove(level.shutdownattractionicontrigger, self);
  shut_down_station();
}

function signal_yaw(var0) {
  if(isDefined(self.ref_13428)) {
    self.ref_13428 setscriptablepartstate("smoke_signal", "off", 0);
    self.ref_13428 delete();
  }

  level.shutdownattractionicontrigger = scripts\engine\utility::array_remove(level.shutdownattractionicontrigger, self);
}

function signalomnvar(var0, var1) {
  self setscriptablepartstate("crate_audio", "detach", 0);
}

function shut_down_station() {
  var0 = [];
  var1 = 0;
  var2 = scripts\mp\gametypes\br_pickups::test_ai_anim();

  foreach(var4 in level.shrink_poi_into_the_bank.equipment) {
    var5 = var4[0];
    var6 = var4[1];

    if(scripts\mp\gametypes\br_lootcache::get_bonus_targets(var5)) {
      for(var7 = 0; var7 < var6; var7++) {
        var8 = scripts\mp\gametypes\br_lootcache::ref_11a41(var5, var2, self.origin, self.angles, 0, 1);
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