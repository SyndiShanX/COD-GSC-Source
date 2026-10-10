/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_1c7f9d74d59b2416.gsc
*************************************************/

#using script_1c7f9d74d59b2416;
#using script_294dda4a4b00ffe3;
#using script_f820c96419fe887;
#using scripts\cp_mp\utility\audio_utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\engine\utility;
#using scripts\mp\gametypes\br_gametypes;
#using scripts\mp\gametypes\br_public;
#using scripts\mp\gametypes\br_publicevents;
#using scripts\mp\hud_message;
#using scripts\mp\utility\game;
#using scripts\mp\utility\player;
#using scripts\mp\utility\teams;
#namespace namespace_6ef1a894a05e9ba5;

function autoexec main() {
  scripts\mp\gametypes\br_publicevents::function_dbc8f6cb3760cd82(%"outbreak", &init);
}

function init(eventinfo) {
  eventinfo.weight = getdvarfloat(@ "hash_af5f123ddbd1aba0", 1);
  eventinfo.validatefunc = &validatefunc;
  eventinfo.activatefunc = &activatefunc;
  eventinfo.waitfunc = &waitfunc;
  eventinfo.postinitfunc = &postinitfunc;
  eventinfo.var_d72a1842c5b57d1d = getdvarint(@ "hash_6d1ab4854eccfd8b", 0);
  eventinfo.circleeventweights = scripts\mp\gametypes\br_publicevents::function_4634160166fb7f8b("outbreak", "0 20 20 20 0 0 0 0 0 0 0 0");
  eventinfo.var_b9b56551e1acfee2 = namespace_c711384b1335919::function_8be9bae8228a91f7("outbreak");
}

function postinitfunc() {
  game["dialog"]["human_outbreak_meter_25percent"] = "zxp1_wzan_mt75";
  game["dialog"]["human_outbreak_meter_50percent"] = "zxp1_wzan_mt50";
  game["dialog"]["human_outbreak_meter_75percent"] = "zxp1_wzan_mt25";
  game["dialog"]["zmb_outbreak_meter_25percent"] = "zxp1_wzan_mz75";
  game["dialog"]["zmb_outbreak_meter_50percent"] = "zxp1_wzan_mz50";
  game["dialog"]["zmb_outbreak_meter_75percent"] = "zxp1_wzan_mz25";
  game["dialog"]["human_outbreak_announcement"] = "zxp1_wzan_mtfl";
  game["dialog"]["zmb_outbreak_announcement"] = "zxp1_wzan_mzfl";
  var_ec17c5d2776fa83 = function_8e69ed234b909498(0.05, "human_outbreak_announcement", "zmb_outbreak_announcement", 2.5, -1);
  var_e050855ae9b4bf4 = function_8e69ed234b909498(0.25, "human_outbreak_meter_25percent", "zmb_outbreak_meter_25percent", 0.5, 0);
  var_8e1b9588b2a5ced4 = function_8e69ed234b909498(0.5, "human_outbreak_meter_50percent", "zmb_outbreak_meter_50percent", 0.5, 1);
  var_1cad5690c51334e7 = function_8e69ed234b909498(0.75, "human_outbreak_meter_75percent", "zmb_outbreak_meter_75percent", 0.5, 2);
  level.brgametype.var_cac7326db3301cc1 = [var_ec17c5d2776fa83, var_e050855ae9b4bf4, var_8e1b9588b2a5ced4, var_1cad5690c51334e7];
  level.brgametype.var_e7cdd3fb24f93391 = 3;
  level.brgametype.var_d2da0bd454548d48 = getdvarfloat(@ "hash_58e3fe90e58c6e2", 47);
  level.brgametype.var_37a6fef4ebdcd6a4 = (0, 0, 0);

  if(isDefined(level.brgametype.var_ef005d8aad03c36c)) {
    level.brgametype.var_37a6fef4ebdcd6a4 = level.brgametype.var_ef005d8aad03c36c;
  }
}

function validatefunc() {
  subgametype = level getsubgametype();
  var_b3074827e0d12849 = subgametype == "zxp" || subgametype == "brz" || subgametype == "gxp";
  isvalid = 0;
  var_2d70c3e4d540cb04 = istrue(level.usegulag) && !scripts\mp\gametypes\br_gametypes::isfeaturedisabled("gulag");

  if(var_b3074827e0d12849 && !var_2d70c3e4d540cb04) {
    isvalid = 1;
  }

  return isvalid;
}

function waitfunc() {
  level endon("game_ended");
  level endon("cancel_public_event");
  eventstarttime = calculateeventstarttime();
  wait eventstarttime;
}

function activatefunc() {
  level endon("game_ended");
  var_79324a8bcfc504a1 = 3.5;
  var_1491d8d252ad642 = namespace_c711384b1335919::function_4ad287e0971672a6();

  if(!var_1491d8d252ad642) {
    function_3d710ebc0f4c181b("br_pe_outbreak_incoming");
  }

  wait var_79324a8bcfc504a1;
  thread function_1b203c25fda5e3a8();
  clockobject = spawn("script_origin", (0, 0, 0));
  clockobject hide();
  var_5e660c5ed0f2504c = undefined;
  var_81a566d2f1047439 = undefined;
  var_827c53020f6f228f = getdvarint(@ "hash_520f4dfd896e0888", 1);

  if(!var_1491d8d252ad642) {
    scripts\mp\gametypes\br_publicevents::showsplashtoall("br_pe_outbreak_active", "splash_list_br_pe_outbreak");
  }

  if(var_827c53020f6f228f && scripts\mp\gametypes\br_gametypes::isbrgametypefuncdefined("onEliminatedTeamsRespawn")) {
    scripts\mp\gametypes\br_gametypes::runbrgametypefunc("onEliminatedTeamsRespawn");
  }

  thread respawnplayers(var_827c53020f6f228f);
}

function calculateeventstarttime() {
  minstarttime = getdvarfloat(@ "hash_17d74bba636e9a92", 795);
  maxstarttime = getdvarfloat(@ "hash_17b455ba634868d8", 1110);

  if(maxstarttime > minstarttime) {
    return randomfloatrange(minstarttime, maxstarttime);
  }

  return minstarttime;
}

function private function_c725a0493496f7aa(player, var_827c53020f6f228f) {
  if(!isDefined(player)) {
    return false;
  }

  aliveteammates = scripts\mp\utility\teams::getteamdata(player.team, "alivePlayers");
  var_18ab43b1d2dabccb = array_contains(aliveteammates, player);

  if(var_18ab43b1d2dabccb || istrue(player.respawningfromtoken) || istrue(player.var_5166e5e6229b88ee)) {
    return false;
  }

  if(!var_827c53020f6f228f && aliveteammates.size == 0) {
    return false;
  }

  return true;
}

function respawnplayers(var_827c53020f6f228f) {
  level endon("game_ended");
  var_2302534ae6df535f = 0;

  foreach(player in level.players) {
    if(function_c725a0493496f7aa(player, var_827c53020f6f228f)) {
      player.var_584c38d71aa17739 = 1;
      var_2302534ae6df535f += 1;
      player thread namespace_27c39fecb94c2a6d::playerzombierespawn(0, 1);
      waitframe();
    }
  }

  if(scripts\cp_mp\utility\game_utility::function_fa7bfcc1d68b7b73()) {
    var_c492f22d5c11b367 = namespace_c711384b1335919::function_c6b950c21813b5cd();
    dlog_recordevent("dlog_event_zxp_mgl_infestation_triggered", ["infestation_index", var_c492f22d5c11b367, "number_respawned", var_2302534ae6df535f]);
  }
}

function function_3d710ebc0f4c181b(splashname) {
  foreach(player in level.players) {
    if(isreallyalive(player)) {
      player scripts\mp\hud_message::showsplash(splashname, undefined, undefined, undefined, undefined, "splash_list_br_pe_outbreak");
    }
  }
}

function function_8e69ed234b909498(ratio, var_a16d41fb5b817106, var_4f990706b21f9cd3, var_d0e34a284e587aa8, var_e445f60177fd30d7) {
  var_36933c75f6c4f948 = spawnStruct();
  var_36933c75f6c4f948.ratio = ratio;
  var_36933c75f6c4f948.var_a16d41fb5b817106 = var_a16d41fb5b817106;
  var_36933c75f6c4f948.var_4f990706b21f9cd3 = var_4f990706b21f9cd3;
  var_36933c75f6c4f948.var_d0e34a284e587aa8 = var_d0e34a284e587aa8;
  var_36933c75f6c4f948.var_e445f60177fd30d7 = var_e445f60177fd30d7;
  return var_36933c75f6c4f948;
}

function function_c8b0148638fb3f0a() {
  currentratio = namespace_c711384b1335919::function_3168dda92f94de9c();

  if(!isDefined(currentratio)) {
    return;
  }

  var_aea01ed6c64ef3c = level.brgametype.var_e7cdd3fb24f93391;

  if(isDefined(level.brgametype.var_cac7326db3301cc1)) {
    for(index = 0; index <= level.brgametype.var_e7cdd3fb24f93391; index++) {
      state = level.brgametype.var_cac7326db3301cc1[index];

      if(currentratio <= state.ratio) {
        humanplayers = [];
        var_926296fa3aeecb13 = [];
        var_69b535cdfdcf807d = [];

        foreach(player in level.players) {
          if(!isDefined(player)) {
            continue;
          }

          if(isreallyalive(player)) {
            if(istrue(player scripts\mp\gametypes\br_public::playeriszombie())) {
              var_926296fa3aeecb13[var_926296fa3aeecb13.size] = player;
            } else {
              humanplayers[humanplayers.size] = player;
            }

            continue;
          }

          var_69b535cdfdcf807d[var_69b535cdfdcf807d.size] = player;
        }

        var_2f2c13fe976a62c3 = state.ratio == level.brgametype.var_cac7326db3301cc1[0].ratio;
        var_44558ddfe2e91dbf = ter_op(var_2f2c13fe976a62c3, array_combine(var_926296fa3aeecb13, var_69b535cdfdcf807d), var_69b535cdfdcf807d);

        if(isDefined(state.var_a16d41fb5b817106)) {
          scripts\mp\gametypes\br_public::brleaderdialog(state.var_a16d41fb5b817106, 1, humanplayers, 1, state.var_d0e34a284e587aa8, undefined, "dx_br_bds6_");
        }

        if(isDefined(state.var_4f990706b21f9cd3)) {
          scripts\mp\gametypes\br_public::brleaderdialog(state.var_4f990706b21f9cd3, 1, var_44558ddfe2e91dbf, 1, state.var_d0e34a284e587aa8, undefined, "dx_br_bds6_");
        }

        level.brgametype.var_e7cdd3fb24f93391 = state.var_e445f60177fd30d7;
        return;
      }
    }
  }
}

function function_eb754127266d1dec() {
  currentratio = namespace_c711384b1335919::function_3168dda92f94de9c();

  if(!isDefined(currentratio)) {
    return;
  }

  if(currentratio <= 0.1 && !istrue(level.brgametype.var_1f9e3ce0a38eb72f)) {
    thread namespace_8e8724a22777d228::function_549e7eb58b82ce6f();
  }
}

function function_549e7eb58b82ce6f() {
  level endon("game_ended");
  script_origin = spawn("script_origin", level.brgametype.var_37a6fef4ebdcd6a4);
  script_origin hide();
  waitframe();
  script_origin playSound("scn_zr_infestation_siren");
  level.brgametype.var_1f9e3ce0a38eb72f = 1;
  wait level.brgametype.var_d2da0bd454548d48;
  script_origin delete();
  level.brgametype.var_1f9e3ce0a38eb72f = 0;
}

function function_1b203c25fda5e3a8() {
  level endon("game_ended");
  script_origin = spawn("script_origin", level.brgametype.var_37a6fef4ebdcd6a4);
  script_origin hide();
  waitframe();
  script_origin playSound("scn_zr_infestation_zombies_far");
  wait 10;
  script_origin delete();
}