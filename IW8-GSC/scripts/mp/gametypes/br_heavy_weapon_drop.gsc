/*********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_heavy_weapon_drop.gsc
*********************************************************/

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
  var_0.destroyoncapture = 1;
  level.delaystreamtomovingplane = getdvarint("scr_br_pe_weapon_crate_useUltraLoot", 0) == 1;
  level.shrink_poi_into_the_bank = spawnStruct();
  level.shrink_poi_into_the_bank.besttimestate = 1;
  level.shrink_poi_into_the_bank.ref_13eff = [["brloot_killstreak_auav", 0], ["brloot_equip_gasmask_durable", 100], ["brloot_specialist_bonus", 0], ["brloot_weapon_la_juliet_lege", "brloot_ammo_rocket"]];
  level.shrink_poi_into_the_bank.chopper_gunner = [["brloot_weapon_la_t9standard_rare", "brloot_ammo_rocket"], ["brloot_weapon_la_t9freefire_rare", "brloot_ammo_rocket"], ["brloot_weapon_s4_la_mkilo1_epic", "brloot_ammo_rocket"]];
  level.shrink_poi_into_the_bank.waypoint_icon = [["brloot_killstreak_precision_airstrike", 0], ["brloot_equip_gasmask", 100], ["brloot_plate_pouch", 8], ["brloot_killstreak_clusterstrike", 0]];
  level.shrink_poi_into_the_bank.waypoints = [["brloot_weapon_s4_mg_sindia510_lege", "brloot_ammo_762"], ["brloot_weapon_s4_ar_fnovember2000_lege", "brloot_ammo_762"], ["brloot_weapon_s4_ar_hyankee44_lege", "brloot_ammo_762"], ["brloot_weapon_s4_sm_salpha26_lege", "brloot_ammo_919"], ["brloot_weapon_s4_sm_fromeo57_lege", "brloot_ammo_919"], ["brloot_weapon_s4_sm_aromeo43_lege", "brloot_ammo_919"]];
  level.shrink_poi_into_the_bank.weapon_xp_iw8_pi_mike1911 = [["brloot_offhand_c4", 2], ["brloot_offhand_molotov", 2], ["brloot_offhand_thermite", 2], ["brloot_offhand_frag", 2]];
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

function shut_down_station() {
  var_0 = [];
  var_1 = randomint(100);

  if(istrue(level.delaystreamtomovingplane)) {
    if(var_1 < 5) {
      var_2 = randomint(level.shrink_poi_into_the_bank.ref_13eff.size);
      var_0 = level.shrink_poi_into_the_bank.ref_13eff[var_2];
    } else {
      var_2 = randomint(level.shrink_poi_into_the_bank.waypoint_icon.size);
      var_1 = level.shrink_poi_into_the_bank.waypoint_icon[var_2];
    }

    var_2 = randomint(level.shrink_poi_into_the_bank.waypoints.size);
    var_1 = level.shrink_poi_into_the_bank.waypoints[var_2];
    var_2 = randomint(level.shrink_poi_into_the_bank.chopper_gunner.size);
    var_1 = level.shrink_poi_into_the_bank.chopper_gunner[var_2];
    var_2 = randomint(level.shrink_poi_into_the_bank.weapon_xp_iw8_pi_mike1911.size);
    var_1 = level.shrink_poi_into_the_bank.weapon_xp_iw8_pi_mike1911[var_2];

    if(istrue(level.shrink_poi_into_the_bank.besttimestate)) {
      var_1 = ["brloot_killstreak_uav", 0];
    }
  } else {
    if(var_2 < 5) {
      var_2 = ["brloot_weapon_la_mike32_lege", "brloot_ammo_rocket"];
    } else if(var_2 < 10) {
      var_2 = ["brloot_weapon_lm_dblmg_lege", "brloot_ammo_762"];
    } else {
      var_2 = randomint(level.shrink_poi_into_the_bank.waypoint_icon.size);
      var_2 = level.shrink_poi_into_the_bank.waypoint_icon[var_2];
    }

    var_2 = randomint(level.shrink_poi_into_the_bank.chopper_gunner.size);
    var_2 = level.shrink_poi_into_the_bank.chopper_gunner[var_2];
    var_2 = randomint(level.shrink_poi_into_the_bank.waypoints.size);
    var_2 = level.shrink_poi_into_the_bank.waypoints[var_2];
    var_2 = randomint(level.shrink_poi_into_the_bank.weapon_xp_iw8_pi_mike1911.size);
    var_2 = level.shrink_poi_into_the_bank.weapon_xp_iw8_pi_mike1911[var_2];

    if(istrue(level.shrink_poi_into_the_bank.besttimestate)) {
      var_2 = ["brloot_killstreak_uav", 0];
    }
  }

  var_3 = 0;
  var_4 = scripts\mp\gametypes\br_pickups::test_ai_anim();

  foreach(var_6 in var_2) {
    var_7 = var_6[0];

    if(scripts\mp\gametypes\br_lootcache::get_bonus_targets(var_7)) {
      var_8 = level.br_pickups.delay_hide_player_clip[var_7];

      if(!var_3 && isDefined(var_8) && var_8 == 4) {
        var_9 = scripts\mp\gametypes\br_lootcache::ref_11a41(var_7, var_4, self.origin, self.angles, 0, 1);
        var_3 = 1;
      } else {
        var_9 = scripts\mp\gametypes\br_lootcache::ref_11a41(var_11, var_5, self.origin, self.angles, 0, 0);
      }

      if(isstring(var_7[1])) {
        var_10 = scripts\mp\gametypes\br_lootcache::ref_11a41(var_7[1], var_5, self.origin, self.angles, 0, 0);
        var_10.count = level.br_pickups.maxcounts[var_7[1]];
      } else {
        var_9.count = var_7[1];
      }
    }
  }

  var_6 = undefined;
  var_8 = undefined;

  if(isDefined(level.shrink_poi_into_the_bank.beardone)) {
    [[level.shrink_poi_into_the_bank.beardone]](var_5, self.origin, self.angles);
  }

  if(istrue(self.ref_135b6)) {
    var_12 = spawnStruct();
    var_12.origin = self.origin;
    var_12.angles = (0, 90, 0);
    var_5 = scripts\mp\gametypes\br_pickups::test_ai_anim();
    scripts\mp\gametypes\br_lootcache::ref_11a41("brloot_soa_pow_dogtag", var_5, var_12.origin, var_12.angles, 0, 1);
    return;
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