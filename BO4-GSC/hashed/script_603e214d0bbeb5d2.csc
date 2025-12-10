/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: script\script_603e214d0bbeb5d2.csc
***********************************************/

#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\character_customization;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\duplicaterender_mgr;
#using scripts\core_common\player\player_role;
#using scripts\core_common\serverfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#namespace draft;

autoexec __init__system__() {
  system::register(#"draft", &__init__, undefined, undefined);
}

__init__() {
  clientfield::register("world", "draft", 1, 3, "int", &handledraftstage, 0, 0);
  clientfield::register("clientuimodel", "PositionDraft.stage", 1, 3, "int", undefined, 0, 0);
  clientfield::register("clientuimodel", "PositionDraft.autoSelected", 1, 1, "int", undefined, 0, 0);
  clientfield::register("clientuimodel", "PositionDraft.cooldown", 1, 5, "int", undefined, 0, 0);
  clientfield::register("worlduimodel", "PositionDraft.timeRemaining", 1, 7, "int", undefined, 0, 0);
  serverfield::register("PositionDraft.uiLoaded", 1, 1, "int");
  level.var_86428271 = [];
  level.var_86428271[# "free"] = [];
  level.var_86428271[# "free"][0] = # "hash_6ffe41bf6b79cd07";
  level.var_86428271[# "free"][1] = # "hash_6ffe40bf6b79cb54";
  level.var_86428271[# "free"][2] = # "hash_6ffe43bf6b79d06d";
  level.var_86428271[# "free"][3] = # "hash_6ffe42bf6b79ceba";
  level.var_86428271[# "free"][4] = # "hash_6ffe3dbf6b79c63b";
  level.var_86428271[# "allies"] = [];
  level.var_86428271[# "allies"][0] = # "hash_6ffe41bf6b79cd07";
  level.var_86428271[# "allies"][1] = # "hash_6ffe40bf6b79cb54";
  level.var_86428271[# "allies"][2] = # "hash_6ffe43bf6b79d06d";
  level.var_86428271[# "allies"][3] = # "hash_6ffe42bf6b79ceba";
  level.var_86428271[# "allies"][4] = # "hash_6ffe3dbf6b79c63b";
  level.var_86428271[# "axis"] = [];
  level.var_86428271[# "axis"][0] = # "hash_6ffe41bf6b79cd07";
  level.var_86428271[# "axis"][1] = # "hash_6ffe40bf6b79cb54";
  level.var_86428271[# "axis"][2] = # "hash_6ffe43bf6b79d06d";
  level.var_86428271[# "axis"][3] = # "hash_6ffe42bf6b79ceba";
  level.var_86428271[# "axis"][4] = # "hash_6ffe3dbf6b79c63b";
  level.var_aac1999 = [];
  level.var_aac1999[# "free"] = # "hash_24d789c80dba10e6";
  level.var_aac1999[# "allies"] = # "hash_e2e52f9cab15dce";
  level.var_aac1999[# "axis"] = # "hash_50c9ef9e41155cf9";
  level.draftstructs = [];
  level.draftstructs[# "free"] = # "draft_team_struct";
  level.draftstructs[# "allies"] = # "draft_team_struct";
  level.draftstructs[# "axis"] = # "hash_700492f71a083a7c";
  level.var_e5f8a54 = [];
  level.var_e5f8a54[# "allies"] = "mp_draft_lights_allies";
  level.var_e5f8a54[# "axis"] = "mp_draft_lights_axis";
  level.var_90991f70 = undefined;
  level.playerscriptstructs = [];
  level.playerscriptstructs[# "free"] = [];
  level.playerscriptstructs[# "allies"] = [];
  level.playerscriptstructs[# "axis"] = [];
  for(i = 0; i < 5; i++) {
    level.playerscriptstructs[# "free"][i] = struct::get(level.var_86428271[# "free"][i]);
    level.playerscriptstructs[# "allies"][i] = struct::get(level.var_86428271[# "allies"][i]);
    level.playerscriptstructs[# "axis"][i] = struct::get(level.var_86428271[# "axis"][i]);
  }
  level thread function_c277b2a1();
  level thread function_a305a32b();
  level.draftxcam = # "ui_cam_draft_common";
  level.var_a49d0b27 = # "hash_12263e5d70551bf9";
  level.draftstage = 0;
  level.var_8962241 = "";
  level.var_24f5a391 = "";
  level.draftcharacters = [];
}

function_835971c7(team, index) {
  if(!isDefined(level.var_86428271[team])) {
    team = # "free";
  }
  return struct::get(level.var_86428271[team][index]);
}

getpositionforlocalclient(localclientnum) {
  localclientmapping = [];
  localclientmapping[0] = 2;
  localclientmapping[1] = 1;
  localclientmapping[2] = 3;
  localclientmapping[3] = 0;
  return localclientmapping[localclientnum];
}

play_intro_cinematic(localclientnum) {
  if(isDefined(level.draftintroplayed) && level.draftintroplayed) {
    return false;
  }
  localplayer = function_f97e7787(localclientnum);
  if(isDefined(level.var_aac1999[localplayer.team])) {
    var_843c3e66 = struct::get(level.var_aac1999[localplayer.team]);
    if(isDefined(var_843c3e66) && isDefined(level.var_b0a63eb6) && isDefined(level.var_b0a63eb6[localplayer.team])) {
      level.var_8962241 = "cam_draft_intro";
      playmaincamxcam(localclientnum, level.var_b0a63eb6[localplayer.team], 0, "cam_draft_intro", "", var_843c3e66.origin, var_843c3e66.angles);
      duration = getcamanimtime(level.var_b0a63eb6[localplayer.team]);
      wait float(duration) / 1000;
      level.draftintroplayed = 1;
    }
  }
  setuimodelvalue(createuimodel(getuimodelforcontroller(localclientnum), "PositionDraft.introPlayed"), 1);
  function_396382a0(localclientnum, 0);
  function_86022e3a();
  return isDefined(level.draftintroplayed) && level.draftintroplayed;
}

show_cam(localclientnum, xcam, animname, lerpduration) {
  if(isDefined(level.var_6fba5d94) && level.var_6fba5d94) {
    return;
  }
  if(!isDefined(xcam) || !isDefined(animname)) {
    return;
  }
  if(isDefined(level.var_8962241) && level.var_8962241 == animname && isDefined(level.var_24f5a391) && level.var_24f5a391 == xcam) {
    return;
  }
  localplayer = function_f97e7787(localclientnum);
  if(isDefined(level.draftstructs[localplayer.team])) {
    draftstruct = struct::get(level.draftstructs[localplayer.team], "targetname");
    if(isDefined(draftstruct)) {
      playmaincamxcam(localclientnum, xcam, lerpduration, animname, "", draftstruct.origin - (85, -150, 65), draftstruct.angles + (0, -180, 0));
      level.var_8962241 = animname;
      level.var_24f5a391 = xcam;
    }
  }
}

stop_cameras(localclientnum) {
  stopmaincamxcam(localclientnum);
  level.var_8962241 = undefined;
  level.var_24f5a391 = undefined;
}

function_362ca1c3(localclientnum, lerpduration) {
  show_cam(localclientnum, level.var_a49d0b27, "cam_draft_zoom", lerpduration);
}

function_396382a0(localclientnum, lerpduration) {
  show_cam(localclientnum, level.draftxcam, "cam_draft_ingame", lerpduration);
}

function_a02d2a2b(localclientnum, lerpduration) {
  show_cam(localclientnum, "ui_cam_frontend_loadout_mp", "cam_loadout_mp", lerpduration);
}

enable_lights(localclientnum) {
  localplayer = function_f97e7787(localclientnum);
  if(isDefined(level.var_e5f8a54[localplayer.team])) {
    level.var_90991f70 = level.var_e5f8a54[localplayer.team];
    playradiantexploder(localclientnum, level.var_90991f70);
  }
}

function_eef40235(localclientnum) {
  localplayer = function_f97e7787(localclientnum);
  if(isDefined(level.var_90991f70)) {
    killradiantexploder(localclientnum, level.var_90991f70);
    level.var_90991f70 = undefined;
  }
}

handledraftstage(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(isDefined(newval)) {
    controllermodel = getuimodelforcontroller(localclientnum);
    var_da2ad088 = createuimodel(controllermodel, "PositionDraft.stage");
    setuimodelvalue(var_da2ad088, newval);
  }
}

function_9f457d30(localclientnum, draftcharacter, masked) {
  if(masked && !(isDefined([[draftcharacter]] - > function_e5bdd4ae().masked) && [[draftcharacter]] - > function_e5bdd4ae().masked)) {
    [[draftcharacter]] - > function_43f376f0(1);
    [[draftcharacter]] - > function_e5bdd4ae().masked = 1;
    return;
  }
  if(!masked && isDefined([[draftcharacter]] - > function_e5bdd4ae().masked) && [[draftcharacter]] - > function_e5bdd4ae().masked) {
    [[draftcharacter]] - > function_43f376f0(0);
    [[draftcharacter]] - > function_e5bdd4ae().masked = 0;
  }
}

function_938519dd() {
  foreach(character in level.draftcharacters) {
    [[character]] - > show_model();
  }
}

function_86022e3a() {
  foreach(character in level.draftcharacters) {
    [[character]] - > hide_model();
  }
}

function_b2f5a53(localclientnum) {
  for(j = 0; j < level.draftcharacters.size; j++) {
    if(j != getpositionforlocalclient(localclientnum)) {
      [
        [level.draftcharacters[j]]
      ] - > hide_model();
      continue;
    }
    [[level.draftcharacters[j]]] - > show_model();
  }
}

function_2996cfb6(localclientnum, draftcharacter, oldcharacterindex, var_e506b18e) {
  if(!isDefined([[draftcharacter]] - > function_e5bdd4ae().player)) {
    return;
  }
  if(isDefined([[draftcharacter]] - > function_e5bdd4ae().localclientnum) && [[draftcharacter]] - > function_e5bdd4ae().localclientnum == localclientnum && player_role::is_valid([[draftcharacter]] - > function_e5bdd4ae().selectedcharacterindex)) {}
}

function_bd9af109(localclientnum, draftcharacter) {
  if(player_role::is_valid([[draftcharacter]] - > function_e5bdd4ae().focusedcharacterindex)) {
    if(isDefined([
        [draftcharacter]
      ] - > function_e5bdd4ae().activecharacter) && [
        [draftcharacter]
      ] - > function_e5bdd4ae().activecharacter == [
        [draftcharacter]
      ] - > function_e5bdd4ae().focusedcharacterindex) {
      return false;
    }
    [[draftcharacter]] - > function_e5bdd4ae().activecharacter = [[draftcharacter]] - > function_e5bdd4ae().focusedcharacterindex;
  } else if(!isDefined([[draftcharacter]] - > function_e5bdd4ae().activecharacter) || [[draftcharacter]] - > function_e5bdd4ae().activecharacter != [[draftcharacter]] - > function_e5bdd4ae().selectedcharacterindex) {
    function_2996cfb6(localclientnum, draftcharacter, [[draftcharacter]] - > function_e5bdd4ae().activecharacter, [[draftcharacter]] - > function_e5bdd4ae().selectedcharacterindex);
    [[draftcharacter]] - > function_e5bdd4ae().activecharacter = [[draftcharacter]] - > function_e5bdd4ae().selectedcharacterindex;
  }
  [[draftcharacter]] - > set_character_mode(currentsessionmode());
  if(player_role::is_valid([[draftcharacter]] - > function_e5bdd4ae().activecharacter)) {
    [[draftcharacter]] - > function_abb62848(0);
    [[draftcharacter]] - > function_e5bdd4ae().params.anim_name = [[draftcharacter]] - > function_e5bdd4ae().var_34de0799;
    [[draftcharacter]] - > set_character_index([[draftcharacter]] - > function_e5bdd4ae().activecharacter);
    [[draftcharacter]] - > function_fd80d28b();
    function_9f457d30(localclientnum, draftcharacter, 0);
  } else {
    [[draftcharacter]] - > function_abb62848(1);
    [[draftcharacter]] - > set_character_index(0);
    [[draftcharacter]] - > function_e5bdd4ae().params.anim_name = [[draftcharacter]] - > function_e5bdd4ae().var_49d2d833;
    function_9f457d30(localclientnum, draftcharacter, 1);
  }
  return true;
}

function_2263ff6(localclientnum, draftcharacter, oldweapon, newweapon) {
}

update_player_weapon(localclientnum, draftcharacter) {
  changed = 0;
  if(isDefined([[draftcharacter]] - > function_e5bdd4ae().primaryweapon) && (!isDefined([[draftcharacter]] - > function_e5bdd4ae().activeweapon) || [[draftcharacter]] - > function_e5bdd4ae().activeweapon != [[draftcharacter]] - > function_e5bdd4ae().primaryweapon)) {
    function_2263ff6(localclientnum, draftcharacter, [[draftcharacter]] - > function_e5bdd4ae().activeweapon, [[draftcharacter]] - > function_e5bdd4ae().primaryweapon);
    [[draftcharacter]] - > function_e5bdd4ae().activeweapon = [[draftcharacter]] - > function_e5bdd4ae().primaryweapon;
    changed = 1;
  }
  if(isDefined([[draftcharacter]] - > function_e5bdd4ae().activeweapon) && [[draftcharacter]] - > function_e5bdd4ae().activeweapon != level.weaponnone) {
    [[draftcharacter]] - > function_e5bdd4ae().params.anim_name = [[draftcharacter]] - > function_e5bdd4ae().var_49d2d833;
  }
  return changed;
}

function_a251e6d6(localclientnum, draftcharacter) {
  update = 0;
  if(function_bd9af109(localclientnum, draftcharacter)) {
    update = 1;
  }
  if(update_player_weapon(localclientnum, draftcharacter)) {
    update = 1;
  }
  if(update) {
    [[draftcharacter]] - > update([[draftcharacter]] - > function_e5bdd4ae().params);
  }
}

update_team(localclientnum) {
  localplayer = function_f97e7787(localclientnum);
  controllermodel = getuimodelforcontroller(localclientnum);
  positiondraftclientsmodel = getuimodel(controllermodel, "PositionDraftClients");
  for(i = 0; i < 5; i++) {
    if(!isDefined(level.draftcharacters[i])) {
      continue;
    }
    draftcharacter = level.draftcharacters[i];
    [[draftcharacter]] - > function_e5bdd4ae().selectedcharacterindex = 0;
    [[draftcharacter]] - > function_e5bdd4ae().primaryweapon = level.weaponnone;
    if(isDefined(positiondraftclientsmodel)) {
      luaindex = i + 1;
      positionmodel = getuimodel(positiondraftclientsmodel, luaindex);
      clientnum = getuimodelvalue(getuimodel(positionmodel, "clientNum"));
      if(clientnum >= 0) {
        player = getentbynum(localclientnum, clientnum);
        if(isDefined(player)) {
          [
            [draftcharacter]
          ] - > function_e5bdd4ae().player = player;
          [
            [draftcharacter]
          ] - > function_e5bdd4ae().selectedcharacterindex = player getselectedcharacterindex();
          if(player_role::is_valid([
              [draftcharacter]
            ] - > function_e5bdd4ae().selectedcharacterindex) && player_role::is_valid([
              [draftcharacter]
            ] - > function_e5bdd4ae().focusedcharacterindex)) {
            [
              [draftcharacter]
            ] - > function_e5bdd4ae().activecharacter = 0;
            [
              [draftcharacter]
            ] - > function_e5bdd4ae().focusedcharacterindex = 0;
          }
          [
            [draftcharacter]
          ] - > function_e5bdd4ae().primaryweapon = player getprimaryweapon();
        } else {
          [
            [draftcharacter]
          ] - > function_e5bdd4ae().player = undefined;
        }
        if(getpositionforlocalclient(localclientnum) == i) {
          if(!isDefined([
              [draftcharacter]
            ] - > function_e5bdd4ae().player)) {
            [
              [draftcharacter]
            ] - > function_e5bdd4ae().player = localplayer;
            [
              [draftcharacter]
            ] - > function_e5bdd4ae().primaryweapon = localplayer getprimaryweapon();
          }
          [
            [draftcharacter]
          ] - > function_e5bdd4ae().localclientnum = localclientnum;
          if(player_role::is_valid([
              [draftcharacter]
            ] - > function_e5bdd4ae().selectedcharacterindex)) {
            function_938519dd();
            function_396382a0(localclientnum, 1000);
          } else {
            function_b2f5a53(localclientnum);
            function_362ca1c3(localclientnum, 1000);
            positiondraftmodel = getuimodel(controllermodel, "PositionDraft");
            if(isDefined(positiondraftmodel)) {
              [
                [draftcharacter]
              ] - > function_e5bdd4ae().focusedcharacterindex = getuimodelvalue(getuimodel(positiondraftmodel, "focusedCharacterIndex"));
            }
          }
        } else {
          [
            [draftcharacter]
          ] - > function_e5bdd4ae().localclientnum = undefined;
        }
      }
    }
    function_a251e6d6(localclientnum, draftcharacter);
  }
}

function_123364a3(localclientnum) {
  for(i = 0; i < level.draftcharacters.size; i++) {
    [[level.draftcharacters[i]]] - > delete_models();
  }
  level.draftcharacters = [];
}

setup_team(localclientnum) {
  function_123364a3(localclientnum);
  localplayer = function_f97e7787(localclientnum);
  if(isDefined(level.playerscriptstructs[localplayer.team])) {
    var_caf8b806 = array::randomize(array(#"pb_launcher_alt_endgame_1stplace_idle", # "pb_sniper_endgame_1stplace_idle", # "pb_lmg_endgame_1stplace_idle"));
    for(i = 0; i < level.playerscriptstructs[localplayer.team].size; i++) {
      if(!isDefined(level.draftcharacters[i])) {
        model = util::spawn_model(localclientnum, "tag_origin", level.playerscriptstructs[localplayer.team][i].origin, level.playerscriptstructs[localplayer.team][i].angles);
        model.targetname = level.playerscriptstructs[localplayer.team][i].targetname;
        level.draftcharacters[i] = character_customization::function_9de1b403(model, localclientnum, 0);
        [
          [level.draftcharacters[i]]
        ] - > function_e5bdd4ae().var_34de0799 = var_caf8b806[i % var_caf8b806.size];
        [
          [level.draftcharacters[i]]
        ] - > function_e5bdd4ae().var_49d2d833 = array("pb_rifle_endgame_1stplace_idle", "pb_rifle_endgame_1stplace_idle", "pb_rifle_endgame_1stplace_idle", "pb_rifle_endgame_1stplace_idle", "pb_rifle_endgame_1stplace_idle")[i % array("pb_rifle_endgame_1stplace_idle", "pb_rifle_endgame_1stplace_idle", "pb_rifle_endgame_1stplace_idle", "pb_rifle_endgame_1stplace_idle", "pb_rifle_endgame_1stplace_idle").size];
        [
          [level.draftcharacters[i]]
        ] - > function_e5bdd4ae().params = spawnStruct();
        [
          [level.draftcharacters[i]]
        ] - > function_e5bdd4ae().params.sessionmode = currentsessionmode();
      }
    }
  }
}

watchupdate(localclientnum) {
  level notify(#"watchupdate");
  level endon(#"watchupdate", # "disconnect", # "draft_closed");
  while(true) {
    waitresult = level waittill(#"positiondraft_update", # "positiondraft_reject");
    update_team(localclientnum);
  }
}

watchteamchange(localclientnum) {
  self notify(#"hash_5dd2b3ae6fc4afa5");
  self endon(#"hash_5dd2b3ae6fc4afa5", # "disconnect", # "draft_closed");
  while(true) {
    waitresult = level waittill(#"team_changed");
    if(localclientnum == waitresult.localclientnum) {
      setup_team(localclientnum);
      update_team(localclientnum);
    }
  }
}

watchkillcam() {
  self notify(#"hash_79dc7957d60fa25");
  self endon(#"hash_79dc7957d60fa25", # "disconnect", # "draft_closed");
  while(true) {
    level.var_6fba5d94 = 0;
    level waittill(#"killcam_begin");
    level.var_6fba5d94 = 1;
    level waittill(#"killcam_end");
  }
}

function_c301db9c(localclientnum) {
  self notify("1e48b4d510c0af68");
  self endon("1e48b4d510c0af68");
  self endon(#"draft_closed");
  if(!(isDefined(level.draftactive) && level.draftactive)) {
    level.draftactive = 1;
    setup_team(localclientnum);
    play_intro_cinematic(localclientnum);
    enable_lights(localclientnum);
    level thread watchupdate(localclientnum);
    level thread watchteamchange(localclientnum);
    level thread watchkillcam();
    update_team(localclientnum);
  }
  level notify(#"setup_draft_complete");
}

function_c277b2a1() {
  level endon(#"disconnect");
  while(true) {
    waitresult = level waittill(#"positiondraft_open");
    localclientnum = waitresult.localclientnum;
    localplayer = function_f97e7787(localclientnum);
    localplayer serverfield::set("PositionDraft.uiLoaded", 1);
    level thread function_c301db9c(localclientnum);
    level util::waittill_either("setup_draft_complete", "draft_closed");
  }
}

function_a305a32b() {
  level endon(#"disconnect");
  while(true) {
    waitresult = level waittill(#"positiondraft_close");
    localclientnum = waitresult.localclientnum;
    if(isDefined(level.draftactive) && level.draftactive) {
      level notify(#"draft_closed");
      function_123364a3(localclientnum);
      function_eef40235(localclientnum);
      stop_cameras(localclientnum);
      clearstreamerloadinghints();
      level.draftactive = 0;
    }
  }
}