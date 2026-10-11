/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_60db63277bd86169.gsc
*************************************************/

#using script_112ce5394d514e2f;
#using script_29b6494509ba7685;
#using script_2a1239c9bdda2e7;
#using script_347008fff8d477e;
#using script_511dbb84a7b7553e;
#using script_60db63277bd86169;
#using script_640f33037ba8d927;
#using script_699beeb185d284d2;
#using script_6be10b56f79771f3;
#using script_769dc3897af7ecc2;
#using script_7de25d0724236990;
#using scripts\common\callbacks;
#using scripts\cp_mp\killstreaks\nuke;
#using scripts\cp_mp\parachute;
#using scripts\cp_mp\vehicles\vehicle_tracking;
#using scripts\engine\utility;
#using scripts\mp\flags;
#using scripts\mp\gamelogic;
#using scripts\mp\gametypes\br;
#using scripts\mp\gametypes\br_deployable_kiosk;
#using scripts\mp\gametypes\br_gametype_plunder;
#using scripts\mp\gametypes\br_gametype_resurgence;
#using scripts\mp\gametypes\br_gametypes;
#using scripts\mp\gametypes\br_public;
#using scripts\mp\gametypes\br_vehicles;
#using scripts\mp\hud_message;
#using scripts\mp\juggernaut;
#using scripts\mp\killstreaks\juggernaut_mp;
#using scripts\mp\killstreaks\killstreaks;
#using scripts\mp\supers;
#using scripts\mp\utility\game;
#using scripts\mp\utility\points;
#using scripts\mp\utility\stats;
#using scripts\mp\utility\teams;
#namespace namespace_be780cb10b9c129a;

function main() {
  level.var_cdc15ee14362fbf = &namespace_edc49135aaf885cb::init;
  scripts\mp\gametypes\br::main();
}

function init() {
  level thread function_8b2c09581ee6e32a();
  level thread scripts\mp\gametypes\br_gametype_resurgence::function_d7a7aa9ee1cc1071();
  level thread namespace_3269a6faf5094cf5::function_34b491f2bdf6da40();
  level thread function_b54de60f1c39483c();
  level thread initpostmain();
  level.var_92d567c8b79046c2 = getdvarint(@ "hash_3b98d123f6db5764", 0);
  scripts\mp\gametypes\br_gametypes::disablefeature("circle");
  scripts\mp\gametypes\br_gametypes::disablefeature("gulag");
  scripts\mp\gametypes\br_gametypes::enablefeature("allowLateJoiners");

  if(getdvarint(@ "hash_595e408ab2bb9b32", 1) == 1) {
    scripts\mp\gametypes\br_gametypes::enablefeature("tabletReplace");
  }

  namespace_83b142ab0b1210c0::main();
  namespace_a29f8cee9c2cca5c::main();
  namespace_46405b2f43c48ded::main();
  namespace_bf4d47cca9186faa::main();
  namespace_35aa905bbd8fdc12::main();
  namespace_c07bfd0e51dd0a75::main();
  namespace_2a9cffd769289a8::main();
  namespace_156887a0efffbfeb::main();
  namespace_db65270d1872d5f7::main();
  level callback::add("player_death", &onplayerdeath);
  level callback::add("player_connect", &onplayerconnect);
  namespace_3269a6faf5094cf5::function_920c1da6479ae205();
  level.ignoregulagredeploysplash = 1;
  level.var_af67cf91fef6a11c = 1;

  foreach(struct in level.brgametype.var_af41098889966ee1) {
    foreach(str, time in struct.respawntimes) {
      struct.respawntimes[str] = 5;
    }
  }

  scripts\mp\gametypes\br_gametypes::registerbrgametypefunc("playerSkipLootPickup", &function_72beb1ef200ff1b3);
  scripts\mp\gametypes\br_gametypes::registerbrgametypefunc("spawnInitialVehicles", &function_96b5d7cc3634457);
  level.mapcustomkillstreakfunc = &function_334ef6f269d49b8b;
  registersharedfunc("limbo", "checkCanTriggerSuper", &function_91cd71050f13e80e);

  if(getdvarint(@ "hash_d2e4b81f77ebc4ad", 0)) {
    registersharedfunc("limbo", "isOnSpaceShipment", &namespace_db65270d1872d5f7::function_93c1540bbbb4de0b);
  }

  level thread function_b3b9a7191a24bbd2();
}

function function_8b2c09581ee6e32a() {
  scripts\mp\gametypes\br_gametype_resurgence::function_7269c88a927e7937();
  function_1347692ede3af161();
}

function function_1347692ede3af161() {
  game["dialog"]["prematch_enter"] = "dx_br_brcs_bcsh_grav_ac01";
  game["dialog"]["prematch_end"] = "dx_br_brcs_bcsh_grav_ac02";
  game["dialog"]["match_start"] = "dx_br_brcs_bcsh_grav_ac03";
  game["dialog"]["limbo_enterSafeZone"] = "dx_br_brcs_bcsh_grav_ac04";
  game["dialog"]["limbo_leaveSafeZone"] = "dx_br_brcs_bcsh_grav_ac05";
  game["dialog"]["limbo_shipmentNear"] = "dx_br_brcs_bcsh_grav_ac06";
  game["dialog"]["limbo_portalNear"] = "dx_br_brcs_bcsh_grav_ac07";
  game["dialog"]["limbo_supplyIncoming"] = "dx_br_brcs_bcsh_grav_ac08";
  game["dialog"]["limbo_supplyLanded"] = "dx_br_brcs_bcsh_grav_ac09";
  game["dialog"]["limbo_supplyNear"] = "dx_br_brcs_bcsh_grav_ac10";
  game["dialog"]["limbo_becomeMutant"] = "dx_br_brcs_bcsh_grav_ac13";
  game["dialog"]["limbo_killChainSelf"] = "dx_br_brcs_bcsh_grav_ac14";
  game["dialog"]["limbo_killChainEnemy"] = "dx_br_brcs_bcsh_grav_ac15";
  game["dialog"]["limbo_killChainSquad"] = "dx_br_brcs_bcsh_grav_ac16";
  game["dialog"]["mission_ass_accept"] = "dx_br_brcs_bcsh_grav_ac17";
  game["dialog"]["mission_hvt_accept_first_person"] = "dx_br_brcs_bcsh_grav_ac18";
  game["dialog"]["mission_safecrack_accept"] = "dx_br_brcs_bcsh_grav_ac19";
  game["dialog"]["limbo_gameEnded"] = "dx_br_brcs_bcsh_grav_endg";
}

function function_96b5d7cc3634457() {
  function_235b4f0d253af143();
  scripts\mp\gametypes\br_vehicles::spawninitialvehicles();
}

function function_235b4f0d253af143() {
  vehicletypes = ["little_bird", "atv", "veh9_acv_6x6", "veh9_blima", "veh9_pwc", "veh9_rhib", "veh9_utv"];

  foreach(vehicletype in vehicletypes) {
    switch (vehicletype) {
      case #"hash_9d4e22a00fc630b5":
        limit = 4;
        break;
      case #"hash_c93466c10cc10ba":
        limit = 4;
        break;
      case #"hash_112ffa8db1ed9ebd":
        limit = 2;
        break;
      case #"hash_81ea99824b4eacca":
        limit = 2;
        break;
      case #"hash_44d67727616d3059":
        limit = 3;
        break;
      case #"hash_a7bdb3825f53a60d":
        limit = 2;
        break;
      default:
        limit = 0;
        break;
    }

    limit = getdvarint(hashcat(@ "hash_efdb2d7d9e35f2a8", vehicletype), limit);

    if(getdvarint(@ "hash_d31789694e5a8f61", 0)) {
      limit = 0;
    }

    if(limit == 0) {
      setDvar(hashcat(@ "hash_e4fa5e1677f011e4", vehicletype), 0);
      continue;
    }

    scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_limitgameinstances(vehicletype, limit);
  }
}

function onplayerconnect(params) {
  if(istrue(level.infiltransistioning) || istrue(level.snatchspawnalltoc130done) || istrue(level.br_c130spawndone)) {
    self setclientomnvar("ui_br_infiled", 1);
  }
}

function onplayerdeath(data) {
  if(!isDefined(data.attacker) || !isPlayer(data.attacker) || is_equal(data.attacker, self)) {
    return;
  }

  thread function_d21e69acb65ee4b9(data);
  function_21de1f4b60801c91(data.attacker, level.scoremod["kill"]);
}

function function_14808f27c3db4d53(player) {
  var_135375584354a66d = 0;

  if(!level.var_92d567c8b79046c2) {
    if(player.commends >= level.brgametype.var_f90379d3a1b525e8) {
      var_135375584354a66d = 1;
      function_761d2f3c0ae08a4c(player, "commend");
    }
  } else {
    team = player.pers["team"];
    teamplayers = array_removeundefined(getteamdata(team, "players"));
    var_edc18a0885af9293 = 0;

    foreach(player in teamplayers) {
      if(!isDefined(player.commends)) {
        continue;
      }

      var_edc18a0885af9293 += player.commends;
    }

    if(var_edc18a0885af9293 >= level.brgametype.var_f90379d3a1b525e8) {
      var_135375584354a66d = 1;
      function_761d2f3c0ae08a4c(team, "commend");
    }
  }

  return var_135375584354a66d;
}

function function_21de1f4b60801c91(player, var_36f3228e1d630f1b, debug) {
  var_135375584354a66d = 0;
  team = player.pers["team"];

  if(!level.var_92d567c8b79046c2) {
    if(istrue(debug)) {
      player stats::incpersstat("kills", var_36f3228e1d630f1b);
      player.kills = player.pers["kills"];
    }

    kills = player.pers["kills"] + 1;

    if(isDefined(kills) && kills > level.brgametype.var_72a3808f03841546) {
      var_135375584354a66d = 1;
      function_761d2f3c0ae08a4c(player, "kill");
    }
  } else {
    score = function_a97d64dd14f6d878(team) + var_36f3228e1d630f1b;

    if(score > level.brgametype.var_72a3808f03841546) {
      var_36f3228e1d630f1b = level.brgametype.var_72a3808f03841546 - score;
      var_135375584354a66d = 1;
      function_761d2f3c0ae08a4c(team, "kill");
    }

    if(var_36f3228e1d630f1b <= 0) {
      return 1;
    }
  }

  namespace_3269a6faf5094cf5::function_a5125e3bb9aa0b2a(team, var_36f3228e1d630f1b);
  namespace_3269a6faf5094cf5::function_17dafc2a055018cd();
  return var_135375584354a66d;
}

function function_d21e69acb65ee4b9(data) {
  data.victim.var_8bd55dc703cb54e5 = 0;
  function_849f27cc02732999(data.victim.team);
  function_8ca32cb009789bd7(data.attacker.team);

  if(isDefined(data.attacker) && !isDefined(data.attacker.var_8bd55dc703cb54e5)) {
    data.attacker.var_8bd55dc703cb54e5 = 1;
  } else {
    data.attacker.var_8bd55dc703cb54e5++;
  }

  if(isDefined(data.attacker) && isDefined(data.attacker.var_8bd55dc703cb54e5) && isDefined(data.attacker.var_e3b459d01b8351c0)) {
    if(data.attacker.var_8bd55dc703cb54e5 % 5 == 0 && data.attacker.var_e3b459d01b8351c0 % 10 == 0 || data.attacker.var_e3b459d01b8351c0 % 10 == 0) {
      foreach(player in level.players) {
        if(isDefined(player.team) && isDefined(data.attacker.team) && player.team == data.attacker.team) {
          level thread scripts\mp\gametypes\br_public::brleaderdialogplayer("limbo_killChainSquad", player, 1, 0);
          continue;
        }

        level thread scripts\mp\gametypes\br_public::brleaderdialogplayer("limbo_killChainEnemy", player, 1, 0);
      }

      return;
    }

    if(data.attacker.var_8bd55dc703cb54e5 % 5 == 0) {
      level thread scripts\mp\gametypes\br_public::brleaderdialogplayer("limbo_killChainSelf", data.attacker, 1, 0);
    }
  }
}

function function_849f27cc02732999(team) {
  foreach(player in level.players) {
    if(isDefined(player.team) && isDefined(team) && player.team == team) {
      player.var_e3b459d01b8351c0 = 0;
    }
  }
}

function function_8ca32cb009789bd7(team) {
  foreach(player in level.players) {
    if(isDefined(player.team) && isDefined(team) && player.team == team) {
      if(!isDefined(player.var_e3b459d01b8351c0)) {
        player.var_e3b459d01b8351c0 = 1;
        continue;
      }

      player.var_e3b459d01b8351c0++;
    }
  }
}

function function_761d2f3c0ae08a4c(param, scoretype) {
  if(isstring(param)) {
    team = param;
    function_df99022626bf8436(team, scoretype);
    return;
  }

  player = param;
  function_433cdc353263b087(player, scoretype);
}

function function_433cdc353263b087(player, scoretype) {
  if(istrue(player.var_c70dbb153c958d4d)) {
    return;
  }

  player.var_c70dbb153c958d4d = 1;
  player thread scripts\mp\utility\points::doscoreevent(#"hash_24596cf53c625fe5");
  player function_50177f77c9533e72(scoretype);
}

function function_df99022626bf8436(team, scoretype) {
  if(!isDefined(level.var_81ca33f88bea7baa)) {
    level.var_81ca33f88bea7baa = [];
  }

  if(!isDefined(level.var_81ca33f88bea7baa[team])) {
    level.var_81ca33f88bea7baa[team] = 0;
  }

  if(level.var_81ca33f88bea7baa[team]) {
    return;
  }

  teamplayers = array_removeundefined(getteamdata(team, "players"));

  foreach(player in teamplayers) {
    player thread scripts\mp\utility\points::doscoreevent(#"hash_24596cf53c625fe5");
    player function_50177f77c9533e72(scoretype);
  }
}

function function_50177f77c9533e72(scoretype) {
  var_6f0cb8869acbec96 = undefined;

  if(getdvarint(@ "hash_9289248170809eab", 1)) {
    var_6f0cb8869acbec96 = scoretype == "kill" ? level.brgametype.var_72a3808f03841546 : level.brgametype.var_f90379d3a1b525e8;
  }

  if(scoretype == "kill") {
    thread scripts\mp\hud_message::showsplash("limbo_kill_goal_reached", var_6f0cb8869acbec96, undefined, undefined, undefined, "splash_list_br_jup_limbo");
  }

  if(scoretype == "commend") {
    thread scripts\mp\hud_message::showsplash("limbo_commend_goal_reached", var_6f0cb8869acbec96, undefined, undefined, undefined, "splash_list_br_jup_limbo");
  }
}

function initpostmain() {
  waittillframeend();
  level.parachutetakeweaponscb = &scripts\cp_mp\parachute::leaveweaponsdefaultfunc;
  setomnvar("ui_br_circle_state", 5);
  level thread function_7382ba3bf14d6eba();
}

function function_b54de60f1c39483c() {
  level endon("game_ended");
  waittillframeend();
  level.numendgame = undefined;
  level.ontimelimit = &function_7e5b547e8d543872;
  level.brgametype.var_72a3808f03841546 = getdvarint(@ "hash_69bcfb71d23d39b1", 1000);
  level.brgametype.var_f90379d3a1b525e8 = getdvarint(@ "hash_e2e1e3808a02d558", 150);
  namespace_3269a6faf5094cf5::function_c453d69202cbfb0f();
  function_56355c272f045e8c();
  namespace_3269a6faf5094cf5::function_56355c272f045e8c();
  thread namespace_3269a6faf5094cf5::function_5129b71105a55fcf();
}

function function_7382ba3bf14d6eba() {
  level endon("game_ended");
  scripts\mp\flags::gameflagwait("prematch_done");

  if(scripts\mp\gametypes\br_public::function_d6ae35e0ce14bbaf()) {
    return;
  }

  var_eacd60b8536f883d = 0;

  while(true) {
    timeremaining = scripts\mp\gamelogic::gettimeremaining() / 1000;
    var_f72912fa007531d9 = function_f72912fa007531d9();

    if(gettimelimit() != 0 && timeremaining <= 300 && !var_eacd60b8536f883d) {
      setomnvar("ui_br_circle_state", 6);
      var_eacd60b8536f883d = 1;
    }

    if(gettimelimit() != 0 && timeremaining <= 16 || var_f72912fa007531d9) {
      level.nukeinfo.starttimer = 0;
      level.var_3616e3387d78c61 = 1;
      level.blocknukekills = 1;
      setomnvar("ui_nuke_countdown_active", 0);
      var_39e8f33513c716cd = scripts\mp\gametypes\br_gametype_plunder::findanyaliveplayer();

      if(isDefined(var_39e8f33513c716cd)) {
        var_39e8f33513c716cd scripts\cp_mp\killstreaks\nuke::tryusenuke("nuke_multi");
      }

      level thread function_e6c27c70bc0dfa5b(22);
      break;
    } else if(timeremaining <= getdvarint(@ "hash_2bf7785a2d6eb17d", 900) && !istrue(level.nojip)) {
      setnojipscore(1, 1);
      setnojiptime(1, 1);
      level.nojip = 1;
    }

    wait 1;
  }
}

function function_e6c27c70bc0dfa5b(time) {
  level.var_5cfcf0bf9ae68644 = 1;
  wait time;
  function_7e5b547e8d543872(1);
}

function function_7e5b547e8d543872(var_d8ba9e055a77256c) {
  if(istrue(level.var_5cfcf0bf9ae68644) && !istrue(var_d8ba9e055a77256c)) {
    return;
  }

  if(istrue(level.var_5eb7e154a4336320)) {
    return;
  }

  level.var_5eb7e154a4336320 = 1;
  setomnvar("ui_br_circle_state", -1);
  level thread scripts\mp\gametypes\br_public::brleaderdialog("limbo_gameEnded");
  level thread scripts\mp\gamelogic::endgame("tie", game["end_reason"]["game_ended"], game["end_reason"]["game_ended"], 0, 1);
}

function function_56355c272f045e8c() {
  foreach(teamname in level.teamnamelist) {
    if(getteamcount(teamname) == 0) {
      continue;
    }

    if(!isDefined(level.brgametype.teampoints[teamname])) {
      level.brgametype.teampoints[teamname] = 0;
    }
  }
}

function function_29b527d8b0e817c3(dvar, defaultvalue) {
  valuestring = getDvar(dvar, defaultvalue);
  return strtok(valuestring, " ");
}

function function_72beb1ef200ff1b3(instance, bautouse) {
  var_193f0fcc8883b966 = isDefined(self.var_e5520effcbe8bd30);

  if(!var_193f0fcc8883b966) {
    return false;
  }

  if(instance scriptableislootcache()) {
    return false;
  }

  if(isDefined(instance.type) && issubstr(instance.type, "brloot_plunder_cash")) {
    return false;
  }

  return true;
}

function function_334ef6f269d49b8b() {
  level.killstreaktriggeredfunc = &function_412c471ac00f23bd;
  scripts\engine\utility::registersharedfunc("juggernaut", "init", &function_196f7ae64e1433b5);
  level.var_ff4bbeb786042d78 = &function_29109ffcd4ebb19a;
}

function function_412c471ac00f23bd(streakinfo) {
  switch (streakinfo.streakname) {
    case #"hash_19dd9a3a4147e09e":
    case #"hash_4ad475e6e15635bd":
    case #"hash_4d5aa76e8707f47b":
    case #"hash_9e36e3bd3a9dd00d":
      if(namespace_db65270d1872d5f7::function_93c1540bbbb4de0b(streakinfo.owner)) {
        streakinfo.owner callsharedfunc("hud", "showErrorMessage", "MP_BR_INGAME/LIMBO_CANNOT_BE_USED_SHIPMENT");
        return 0;
      }

      break;
  }

  return scripts\mp\killstreaks\killstreaks::streakglobals_onkillstreaktriggered(streakinfo);
}

function function_196f7ae64e1433b5() {
  scripts\mp\killstreaks\juggernaut_mp::init();
  scripts\engine\utility::registersharedfunc("juggernaut", "makeJuggernaut", &function_c44ed43098b74fb1);
}

function function_c44ed43098b74fb1(config, streakinfo) {
  if(namespace_c07bfd0e51dd0a75::function_d204f8977e5c0697()) {
    namespace_c07bfd0e51dd0a75::function_76ae8c199e0cdf45();
  }

  return scripts\mp\juggernaut::jugg_makejuggernaut(config, streakinfo);
}

function function_91cd71050f13e80e(owner, supername) {
  switch (supername) {
    case #"hash_51eb45211286556e":
    case #"hash_a14e62dad73e983d":
      if(namespace_db65270d1872d5f7::function_93c1540bbbb4de0b(owner)) {
        owner callsharedfunc("hud", "showErrorMessage", "MP_BR_INGAME/LIMBO_CANNOT_BE_USED_SHIPMENT");
        return 0;
      } else {
        return 1;
      }

      break;
    default:
      return 1;
  }
}

function function_29109ffcd4ebb19a(grenade) {
  if(!function_91cd71050f13e80e(self, "deployable_kiosk")) {
    scripts\mp\supers::superusefinished(1);
    grenade delete();
    return;
  }

  scripts\mp\gametypes\br_deployable_kiosk::function_ff4bbeb786042d78(grenade);
}

function function_b3b9a7191a24bbd2() {
  if(matchmakinggame()) {
    return;
  }

  while(true) {
    if(getdvarint(@ "hash_2a708ab39e5be9d1", 0)) {
      setDvar(@ "hash_2a708ab39e5be9d1", 0);
      level thread debugscore();
    }

    if(getdvarint(@ "hash_5fa3384039d8dd6c", 0)) {
      setDvar(@ "hash_5fa3384039d8dd6c", 0);
      level thread debugscore(level.brgametype.var_72a3808f03841546 - 25);
    }

    if(getdvarint(@ "hash_37c97d84a0add15b", 0)) {
      setDvar(@ "hash_37c97d84a0add15b", 0);
      level thread debugscore(undefined, 1);
    }

    if(getdvarint(@ "hash_9c33e1ce701b2ae2", 0)) {
      setDvar(@ "hash_9c33e1ce701b2ae2", 0);
      level thread debugscore(level.brgametype.var_f90379d3a1b525e8 - 25, 1);
    }

    waitframe();
  }
}

function debugscore(var_fedeab4edff92da5, var_c04a504cc245c1b3) {
  var_7dab539c50d2fbce = 0;

  while(true) {
    if(isDefined(level.players) && isDefined(level.players[0])) {
      team = level.players[0].pers["<dev string:x1c>"];

      if(isDefined(var_fedeab4edff92da5) && !var_7dab539c50d2fbce) {
        var_7dab539c50d2fbce = 1;
        var_36f3228e1d630f1b = var_fedeab4edff92da5;
      } else {
        var_36f3228e1d630f1b = 1;
      }

      if(!istrue(var_c04a504cc245c1b3)) {
        var_135375584354a66d = function_21de1f4b60801c91(level.players[0], var_36f3228e1d630f1b, 1);
      } else {
        if(!isDefined(level.players[0].commends)) {
          level.players[0].commends = 140;
        }

        level.players[0] namespace_a29f8cee9c2cca5c::function_b6c9a22dc916543d();
        var_135375584354a66d = namespace_edc49135aaf885cb::function_14808f27c3db4d53(level.players[0]);
      }

      if(var_135375584354a66d) {
        return;
      }
    }

    wait 0.25;
  }
}

# /