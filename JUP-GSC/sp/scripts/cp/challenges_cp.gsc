/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\cp\challenges_cp.gsc
***********************************************/

#using scripts\common\ae_utility;
#using scripts\common\utility;
#using scripts\cp\cp_analytics;
#using scripts\cp\cp_gameskill;
#using scripts\cp\kits;
#using scripts\cp\progression;
#using scripts\cp\utility;
#using scripts\cp_mp\challenges;
#using scripts\cp_mp\utility\loot;
#using scripts\engine\utility;
#namespace challenges_cp;

function init() {
  if(!scripts\cp_mp\challenges::challengesenabled()) {
    return;
  }
}

function function_b7193191c525b263() {
  if(!istrue(game["stealth_was_broken"])) {
    function_7665dcad8b978321("Maintained stealth for Challenge");

    if(function_24d5a807c593dc49()) {
      aeeventname = #"collect_item";
      aeeventid = function_6e2deb013c9ca85e(aeeventname);
      typeid = function_7042dad035dc176c("complete_mission_stealth");

      foreach(player in level.players) {
        player function_db073176839d77fb(aeeventid, [function_d6f771aedba70ce7(aeeventname, #"version"), 1, function_d6f771aedba70ce7(aeeventname, #"string_ref"), typeid, function_d6f771aedba70ce7(aeeventname, #"value"), 1, function_d6f771aedba70ce7(aeeventname, #"gamemode"), function_2b0b870d1cf29add(), function_d6f771aedba70ce7(aeeventname, #"gametype"), function_2ff6fac4cf0827a6()]);
      }
    }
  }
}

function function_472e90d2e14c4b53(eattacker) {
  equipmentid = scripts\cp_mp\utility\loot::getlootidfromref("equip_bunkerbuster");
  function_7665dcad8b978321("Player killed the Jugg with a drill charge.");

  if(function_24d5a807c593dc49()) {
    enemytype = function_bdfe9c25f2838f5d("juggernaut");
    aeeventname = #"kill";
    aeeventid = function_6e2deb013c9ca85e(aeeventname);
    eattacker function_db073176839d77fb(aeeventid, [function_d6f771aedba70ce7(aeeventname, #"gamemode"), function_2b0b870d1cf29add(), function_d6f771aedba70ce7(aeeventname, #"gametype"), function_2ff6fac4cf0827a6(), function_d6f771aedba70ce7(aeeventname, #"version"), 1, function_d6f771aedba70ce7(aeeventname, #"hash_e2f5c601b57b3960"), enemytype, function_d6f771aedba70ce7(aeeventname, #"weapon_loot_id"), equipmentid, function_d6f771aedba70ce7(aeeventname, #"kill_amount"), 1]);
  }
}

function destroyvehicles() {
  function_7665dcad8b978321("Player has destroyed a vehicle");
  enemytype = function_bdfe9c25f2838f5d("vehicle");

  if(function_24d5a807c593dc49()) {
    aeeventname = #"kill";
    aeeventid = function_6e2deb013c9ca85e(aeeventname);
    self function_db073176839d77fb(aeeventid, [function_d6f771aedba70ce7(aeeventname, #"gamemode"), function_2b0b870d1cf29add(), function_d6f771aedba70ce7(aeeventname, #"gametype"), function_2ff6fac4cf0827a6(), function_d6f771aedba70ce7(aeeventname, #"version"), 1, function_d6f771aedba70ce7(aeeventname, #"hash_e2f5c601b57b3960"), enemytype, function_d6f771aedba70ce7(aeeventname, #"kill_amount"), 1]);
  }
}

function function_38154b1c06023442(eattacker) {
  enemytype = function_bdfe9c25f2838f5d();
  function_7665dcad8b978321("Demon Dog got a kill.");

  if(function_24d5a807c593dc49()) {
    var_c24e8fa2bc7818bc = 0;
    var_c24e8fa2bc7818bc = scripts\cp_mp\challenges::function_6d40f12a09494350(var_c24e8fa2bc7818bc, function_e2ff8f4b4e94f723(#"hash_7f94e81c1787ff7a", #"ontrain"));
    aeeventname = #"kill";
    aeeventid = function_6e2deb013c9ca85e(aeeventname);
    eattacker function_db073176839d77fb(aeeventid, [function_d6f771aedba70ce7(aeeventname, #"gamemode"), function_2b0b870d1cf29add(), function_d6f771aedba70ce7(aeeventname, #"gametype"), function_2ff6fac4cf0827a6(), function_d6f771aedba70ce7(aeeventname, #"version"), 1, function_d6f771aedba70ce7(aeeventname, #"hash_e2f5c601b57b3960"), enemytype, function_d6f771aedba70ce7(aeeventname, #"kill_amount"), 1, function_d6f771aedba70ce7(aeeventname, #"hash_7f94e81c1787ff7a"), var_c24e8fa2bc7818bc]);
  }
}

function function_15c867e400749a3b() {
  if(istrue(self.var_ca56839b2e00edce)) {
    return;
  }

  function_7665dcad8b978321("Player has equipped Juggernaut");

  if(function_24d5a807c593dc49()) {
    typeid = function_7042dad035dc176c("juggernaut");
    aeeventname = #"use_item";
    aeeventid = function_6e2deb013c9ca85e(aeeventname);
    self function_db073176839d77fb(aeeventid, [function_d6f771aedba70ce7(aeeventname, #"version"), 1, function_d6f771aedba70ce7(aeeventname, #"string_ref"), typeid, function_d6f771aedba70ce7(aeeventname, #"value"), 1, function_d6f771aedba70ce7(aeeventname, #"gamemode"), function_2b0b870d1cf29add(), function_d6f771aedba70ce7(aeeventname, #"gametype"), function_2ff6fac4cf0827a6()]);
  }
}

function function_ce271d4118a0475d(money_spent) {
  function_7665dcad8b978321("Player has spent money");

  if(function_24d5a807c593dc49()) {
    typeid = function_7042dad035dc176c("special");
    aeeventname = #"buy_item";
    aeeventid = function_6e2deb013c9ca85e(aeeventname);
    self function_db073176839d77fb(aeeventid, [function_d6f771aedba70ce7(aeeventname, #"version"), 1, function_d6f771aedba70ce7(aeeventname, #"string_ref"), typeid, function_d6f771aedba70ce7(aeeventname, #"value"), money_spent, function_d6f771aedba70ce7(aeeventname, #"gamemode"), function_2b0b870d1cf29add(), function_d6f771aedba70ce7(aeeventname, #"gametype"), function_2ff6fac4cf0827a6()]);
  }
}

function function_d8b00758a4ecbda7(item) {
  function_7665dcad8b978321("Player has successfully purchased an item" + item);

  if(function_24d5a807c593dc49()) {
    typeid = function_7042dad035dc176c(item);
    aeeventname = #"buy_item";
    aeeventid = function_6e2deb013c9ca85e(aeeventname);
    self function_db073176839d77fb(aeeventid, [function_d6f771aedba70ce7(aeeventname, #"version"), 1, function_d6f771aedba70ce7(aeeventname, #"string_ref"), typeid, function_d6f771aedba70ce7(aeeventname, #"value"), 1, function_d6f771aedba70ce7(aeeventname, #"gamemode"), function_2b0b870d1cf29add(), function_d6f771aedba70ce7(aeeventname, #"gametype"), function_2ff6fac4cf0827a6()]);
  }
}

function function_9ec128ba953ab4e0() {
  function_7665dcad8b978321("Player has destroyed a chopper using an MGL.");

  if(function_24d5a807c593dc49()) {
    typeid = function_7042dad035dc176c("destroy_chopper_with_mgl");
    aeeventname = #"collect_item";
    aeeventid = function_6e2deb013c9ca85e(aeeventname);
    self function_db073176839d77fb(aeeventid, [function_d6f771aedba70ce7(aeeventname, #"version"), 1, function_d6f771aedba70ce7(aeeventname, #"string_ref"), typeid, function_d6f771aedba70ce7(aeeventname, #"value"), 1, function_d6f771aedba70ce7(aeeventname, #"gamemode"), function_2b0b870d1cf29add(), function_d6f771aedba70ce7(aeeventname, #"gametype"), function_2ff6fac4cf0827a6()]);
  }
}

function function_fc52996338c115d1() {
  function_7665dcad8b978321("Player has destroyed a chopper using a cruise missile.");

  if(function_24d5a807c593dc49()) {
    typeid = function_7042dad035dc176c("destroy_chopper_with_cruise");
    aeeventname = #"collect_item";
    aeeventid = function_6e2deb013c9ca85e(aeeventname);
    self function_db073176839d77fb(aeeventid, [function_d6f771aedba70ce7(aeeventname, #"version"), 1, function_d6f771aedba70ce7(aeeventname, #"string_ref"), typeid, function_d6f771aedba70ce7(aeeventname, #"value"), 1, function_d6f771aedba70ce7(aeeventname, #"gamemode"), function_2b0b870d1cf29add(), function_d6f771aedba70ce7(aeeventname, #"gametype"), function_2ff6fac4cf0827a6()]);
  }
}

function function_3d55d46e36d8430b() {
  function_7665dcad8b978321("Player has filled their plates.");

  if(function_24d5a807c593dc49()) {
    typeid = function_7042dad035dc176c("super_armor_drop");
    aeeventname = #"use_item";
    aeeventid = function_6e2deb013c9ca85e(aeeventname);
    self function_db073176839d77fb(aeeventid, [function_d6f771aedba70ce7(aeeventname, #"version"), 1, function_d6f771aedba70ce7(aeeventname, #"string_ref"), typeid, function_d6f771aedba70ce7(aeeventname, #"value"), 1, function_d6f771aedba70ce7(aeeventname, #"gamemode"), function_2b0b870d1cf29add(), function_d6f771aedba70ce7(aeeventname, #"gametype"), function_2ff6fac4cf0827a6()]);
  }
}

function function_613a81f77b1154d0(enemycount) {
  if(enemycount < 5) {
    return;
  }

  typeid = function_7042dad035dc176c("cp_snapshot_five");
  function_7665dcad8b978321("Player has outlined 5 enemies at once");

  if(function_24d5a807c593dc49()) {
    aeeventname = #"collect_item";
    aeeventid = function_6e2deb013c9ca85e(aeeventname);
    self function_db073176839d77fb(aeeventid, [function_d6f771aedba70ce7(aeeventname, #"version"), 1, function_d6f771aedba70ce7(aeeventname, #"string_ref"), typeid, function_d6f771aedba70ce7(aeeventname, #"value"), enemycount, function_d6f771aedba70ce7(aeeventname, #"gamemode"), function_2b0b870d1cf29add(), function_d6f771aedba70ce7(aeeventname, #"gametype"), function_2ff6fac4cf0827a6()]);
  }
}

function function_b036c3abb6389913() {
  function_7665dcad8b978321("Player has successfully used a loadout crate");
  var_c34d57f3d8027c2 = 0;
  var_c34d57f3d8027c2 = scripts\cp_mp\challenges::function_6d40f12a09494350(var_c34d57f3d8027c2, function_e2ff8f4b4e94f723(#"hash_83a2d67994d7e295", #"use"));
  loadouttype = function_7042dad035dc176c("loot_supply_drop");

  if(function_24d5a807c593dc49()) {
    aeeventname = #"use_item";
    aeeventid = function_6e2deb013c9ca85e(aeeventname);
    self function_db073176839d77fb(aeeventid, [function_d6f771aedba70ce7(aeeventname, #"version"), 1, function_d6f771aedba70ce7(aeeventname, #"hash_83a2d67994d7e295"), var_c34d57f3d8027c2, function_d6f771aedba70ce7(aeeventname, #"value"), 1, function_d6f771aedba70ce7(aeeventname, #"gamemode"), function_2b0b870d1cf29add(), function_d6f771aedba70ce7(aeeventname, #"gametype"), function_2ff6fac4cf0827a6() function_d6f771aedba70ce7(aeeventname, #"string_ref"), loadouttype]);
  }
}

function function_ff3ffccac94c5578(mission, stars_earned) {
  foreach(player in level.players) {
    missionname = function_862a7d40f77a77d6(mission);
    missionid = function_7042dad035dc176c(missionname);
    modifiers = 0;

    if(!isDefined(player.modifiers)) {
      player.modifiers = [];
    }

    player.modifiers["endGameMask"] = 0;

    if(scripts\cp\cp_gameskill::function_f8448fd91abb54c8()) {
      player function_266d25f14be47e20("raidHardMode", function_e2ff8f4b4e94f723(#"hash_8dd9828579063e7", #"hash_f19eccdd7c2bdc77"));
      function_7665dcad8b978321("Players have completed on Hard Mode.");
    }

    if(!istrue(level.laststandentered)) {
      player function_266d25f14be47e20("lastStandNotEntered", function_e2ff8f4b4e94f723(#"hash_8dd9828579063e7", #"hash_a02ff71215416a62"));
      function_7665dcad8b978321("Players have completed the mission without anybody going down.");
    }

    if(!istrue(level.var_f091400016c92e56)) {
      player function_266d25f14be47e20("noPurchaseMade", function_e2ff8f4b4e94f723(#"hash_8dd9828579063e7", #"hash_c2a437fb4240d6b0"));
    }

    modifiers = player.modifiers["endGameMask"];
    rolename = player scripts\cp\kits::function_cc1ccc9e93b22c24();
    var_aa83d0f8bb75bea8 = function_7042dad035dc176c(rolename);
    careerstars = player scripts\cp\progression::function_cbaa41c477d4c53f();
    var_e8ec973ec9fe7d09 = player scripts\cp\kits::kit_getrank();
    var_7f721e60f7d473c1 = stars_earned;
    function_7665dcad8b978321("Player has completed the given mission");

    if(function_24d5a807c593dc49()) {
      aeeventname = #"end_match";
      aeeventid = function_6e2deb013c9ca85e(aeeventname);
      player function_db073176839d77fb(aeeventid, [function_d6f771aedba70ce7(aeeventname, #"gamemode"), function_2b0b870d1cf29add(), function_d6f771aedba70ce7(aeeventname, #"gametype"), function_2ff6fac4cf0827a6(), function_d6f771aedba70ce7(aeeventname, #"version"), 1, function_d6f771aedba70ce7(aeeventname, #"hash_4f965de7c7e8ca6c"), stars_earned, function_d6f771aedba70ce7(aeeventname, #"hash_6ded7124daf81bbf"), var_7f721e60f7d473c1, function_d6f771aedba70ce7(aeeventname, #"hash_87c3da69c8339ef5"), careerstars, function_d6f771aedba70ce7(aeeventname, #"hash_17746d12d7b3cc71"), missionid, function_d6f771aedba70ce7(aeeventname, #"hash_8dd9828579063e7"), modifiers, function_d6f771aedba70ce7(aeeventname, #"cp_role"), var_aa83d0f8bb75bea8, function_d6f771aedba70ce7(aeeventname, #"hash_2e01536cc1e8b800"), var_e8ec973ec9fe7d09]);
    }

    playlist_id = 0;
    playlist_name = "private_match";

    if(scripts\cp\utility::matchmakinggame()) {
      playlist_id = getplaylistid();
      playlist_name = getplaylistname();
    }

    dlog_recordevent("dlog_event_cpdata_stars_rewarded", ["levelname", level.script, "playername", player.name, "player_kit", player scripts\cp\kits::function_cab56589fd214c7e(), "sharedaccount_uid", int(player scripts\cp\cp_analytics::function_512417bddbe63792()), "stars_earned", int(stars_earned), "career_stars", int(player scripts\cp\progression::function_cbaa41c477d4c53f()), "playlist_id", int(playlist_id), "playlist_name", playlist_name]);
  }
}

function function_862a7d40f77a77d6(missionname) {
  switch (missionname) {
    case #"hash_e7978e13d7ba3321":
      if(istrue(level.var_5f694efafeb95d7)) {
        return "high_ground_cp";
      }

      return "denied_area_cp";
    case #"hash_d9c138fad5b09bff":
      return "saba_hydro";
    case #"hash_fac4357bd021125d":
      return "saba_observatory";
    case #"hash_5e656a0bf62ec176":
      return "raid_s1";
    case #"hash_e8510abc4b5e935c":
      return "raid_s2";
    case #"hash_1a6467aaad3208f1":
      return "raid_s3";
    case #"hash_1725f94e0ec2b5f2":
      return "raid_s4";
  }

  return undefined;
}

function function_51bbba3794076bf4() {
  if(!isDefined(level.var_9dcc9f8cadbc7c6a)) {
    return;
  }

  if(level.var_9dcc9f8cadbc7c6a > 0) {
    return;
  }

  function_7665dcad8b978321("Players have completed wave 6 without a bomb being planted.");
  stringid = function_7042dad035dc176c("complete_defender_wave_6_no_bomb_plant");

  if(function_24d5a807c593dc49()) {
    aeeventname = #"collect_item";
    aeeventid = function_6e2deb013c9ca85e(aeeventname);

    foreach(player in level.players) {
      player function_db073176839d77fb(aeeventid, [function_d6f771aedba70ce7(aeeventname, #"version"), 1, function_d6f771aedba70ce7(aeeventname, #"string_ref"), stringid, function_d6f771aedba70ce7(aeeventname, #"value"), 1, function_d6f771aedba70ce7(aeeventname, #"gamemode"), function_2b0b870d1cf29add(), function_d6f771aedba70ce7(aeeventname, #"gametype"), function_2ff6fac4cf0827a6()]);
    }
  }
}

function function_a4f684e73d9ec4c6(eattacker) {
  if(isDefined(eattacker.var_ac19f9b9c6c841b9)) {
    if(eattacker.var_ac19f9b9c6c841b9 == "chopper") {
      enemytype = function_bdfe9c25f2838f5d();
      var_c24e8fa2bc7818bc = 0;
      var_c24e8fa2bc7818bc = scripts\cp_mp\challenges::function_6d40f12a09494350(var_c24e8fa2bc7818bc, function_e2ff8f4b4e94f723(#"hash_7f94e81c1787ff7a", #"choppergunner"));
      function_7665dcad8b978321("Player has gotten a kill as the heli pilot");

      if(function_24d5a807c593dc49()) {
        aeeventname = #"kill";
        aeeventid = function_6e2deb013c9ca85e(aeeventname);
        eattacker function_db073176839d77fb(aeeventid, [function_d6f771aedba70ce7(aeeventname, #"gamemode"), function_2b0b870d1cf29add(), function_d6f771aedba70ce7(aeeventname, #"gametype"), function_2ff6fac4cf0827a6(), function_d6f771aedba70ce7(aeeventname, #"version"), 1, function_d6f771aedba70ce7(aeeventname, #"hash_e2f5c601b57b3960"), enemytype, function_d6f771aedba70ce7(aeeventname, #"kill_amount"), 1, function_d6f771aedba70ce7(aeeventname, #"hash_7f94e81c1787ff7a"), var_c24e8fa2bc7818bc]);
      }
    }
  }
}

function destroysamsitenoplant(mission, objweapon, player) {
  if(isDefined(objweapon) && mission == "cp_mission_esc" && !istrue(level.var_5f694efafeb95d7)) {
    if(objweapon.basename != "c4_cp_noproj") {
      function_7665dcad8b978321("Player destroyed SAM without planting an explosive");

      if(function_24d5a807c593dc49()) {
        typeid = function_7042dad035dc176c("sam_site_no_plant");
        aeeventname = #"collect_item";
        aeeventid = function_6e2deb013c9ca85e(aeeventname);
        player function_db073176839d77fb(aeeventid, [function_d6f771aedba70ce7(aeeventname, #"version"), 1, function_d6f771aedba70ce7(aeeventname, #"string_ref"), typeid, function_d6f771aedba70ce7(aeeventname, #"value"), 1, function_d6f771aedba70ce7(aeeventname, #"gamemode"), function_2b0b870d1cf29add(), function_d6f771aedba70ce7(aeeventname, #"gametype"), function_2ff6fac4cf0827a6()]);
      }
    }
  }
}

function function_66b45cb5dd35268c() {
  function_7665dcad8b978321("Player purchased a skip timer");

  if(function_24d5a807c593dc49()) {
    typeid = function_7042dad035dc176c("defender_skip_timer");
    aeeventname = #"use_item";
    aeeventid = function_6e2deb013c9ca85e(aeeventname);
    self function_db073176839d77fb(aeeventid, [function_d6f771aedba70ce7(aeeventname, #"version"), 1, function_d6f771aedba70ce7(aeeventname, #"string_ref"), typeid, function_d6f771aedba70ce7(aeeventname, #"value"), 1, function_d6f771aedba70ce7(aeeventname, #"gamemode"), function_2b0b870d1cf29add(), function_d6f771aedba70ce7(aeeventname, #"gametype"), function_2ff6fac4cf0827a6()]);
  }
}

function function_bdfe9c25f2838f5d(typename) {
  if(!isDefined(typename)) {
    typename = "";
  }

  enemytype = 0;

  switch (typename) {
    case #"hash_4ad475e6e15635bd":
      enemytype = scripts\cp_mp\challenges::function_6d40f12a09494350(enemytype, function_e2ff8f4b4e94f723(#"hash_e2f5c601b57b3960", #"juggernaut"));
      break;
    case #"hash_b9c0ff6cd406fe0f":
      enemytype = scripts\cp_mp\challenges::function_6d40f12a09494350(enemytype, function_e2ff8f4b4e94f723(#"hash_e2f5c601b57b3960", #"vehicle"));
      break;
    default:
      enemytype = scripts\cp_mp\challenges::function_6d40f12a09494350(enemytype, function_e2ff8f4b4e94f723(#"hash_e2f5c601b57b3960", #"agent"));
      break;
  }

  return enemytype;
}

function function_284bd74f0f8d5534(bitname, var_6859cf87418e7fa0) {
  self.modifiers[bitname] = 1;
  self.modifiers["mask"] = scripts\cp_mp\challenges::function_6d40f12a09494350(self.modifiers["mask"], var_6859cf87418e7fa0);
}

function function_266d25f14be47e20(bitname, var_6859cf87418e7fa0) {
  if(!isDefined(self.modifiers["endGameMask"])) {
    self.modifiers["endGameMask"] = 0;
  }

  self.modifiers[bitname] = 1;
  self.modifiers["endGameMask"] = scripts\cp_mp\challenges::function_6d40f12a09494350(self.modifiers["endGameMask"], var_6859cf87418e7fa0);
}

function function_7665dcad8b978321(msg) {
  if(getdvarint(@ "hash_eb41582d8f0999ab", 1)) {
    announcement(msg);
  }
}

function function_24d5a807c593dc49() {
  return getdvarint(@ "hash_86f5418dec919161", 1);
}

function function_2b0b870d1cf29add() {
  return scripts\cp_mp\challenges::getchallengegamemode();
}

function function_2ff6fac4cf0827a6() {
  return scripts\cp_mp\challenges::function_17c5d7feb226e256();
}

function function_7d7322bf935ab06a(player, typeid) {
  aeeventname = #"collect_item";
  aeeventid = function_6e2deb013c9ca85e(aeeventname);
  player function_db073176839d77fb(aeeventid, [function_d6f771aedba70ce7(aeeventname, #"version"), 1, function_d6f771aedba70ce7(aeeventname, #"string_ref"), typeid, function_d6f771aedba70ce7(aeeventname, #"value"), 1, function_d6f771aedba70ce7(aeeventname, #"gamemode"), function_2b0b870d1cf29add(), function_d6f771aedba70ce7(aeeventname, #"gametype"), function_2ff6fac4cf0827a6()]);
}