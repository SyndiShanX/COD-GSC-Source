/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp_common\draft.csc
***********************************************/

#include scripts\core_common\array_shared;
#include scripts\core_common\character_customization;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\dialog_shared;
#include scripts\core_common\player\player_role;
#include scripts\core_common\serverfield_shared;
#include scripts\core_common\shoutcaster;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\killstreaks\killstreak_detect;

#namespace draft;

autoexec __init__system__() {
  system::register(#"draft", &__init__, undefined, undefined);
}

__init__() {
  clientfield::register("world", "draft", 1, 3, "int", &handledraftstage, 0, 0);
  clientfield::register("clientuimodel", "PositionDraft.stage", 1, 4, "int", undefined, 0, 0);
  clientfield::register("clientuimodel", "PositionDraft.autoSelected", 1, 1, "int", undefined, 0, 0);
  clientfield::register("clientuimodel", "PositionDraft.cooldown", 1, 5, "int", undefined, 0, 0);
  clientfield::register("worlduimodel", "PositionDraft.timeRemaining", 1, 7, "int", undefined, 0, 0);
  clientfield::register("worlduimodel", "PositionDraft.waitingForPlayers", 1, 1, "int", undefined, 0, 0);
  serverfield::register("PositionDraft.uiLoaded", 1, 1, "int");
  level.var_a968beb = [];
  level.var_a968beb[0] = #"free";
  level.var_a968beb[1] = #"allies";
  level.var_a968beb[2] = #"axis";
  level.var_8cb8d474 = [];
  level.var_8cb8d474[#"free"] = [];
  level.var_8cb8d474[#"free"][0] = #"hash_6eb882c3b52cdbb3";
  level.var_8cb8d474[#"free"][2] = #"hash_6eb881c3b52cda00";
  level.var_8cb8d474[#"free"][1] = #"hash_6eb884c3b52cdf19";
  level.var_8cb8d474[#"free"][3] = #"hash_6eb883c3b52cdd66";
  level.var_8cb8d474[#"free"][4] = #"hash_6eb886c3b52ce27f";
  level.var_8cb8d474[#"allies"] = [];
  level.var_8cb8d474[#"allies"][0] = #"draft_player_struct_0_allies";
  level.var_8cb8d474[#"allies"][2] = #"draft_player_struct_1_allies";
  level.var_8cb8d474[#"allies"][1] = #"draft_player_struct_2_allies";
  level.var_8cb8d474[#"allies"][3] = #"draft_player_struct_3_allies";
  level.var_8cb8d474[#"allies"][4] = #"draft_player_struct_4_allies";
  level.var_8cb8d474[#"axis"] = [];
  level.var_8cb8d474[#"axis"][0] = #"hash_3b2607cfca030035";
  level.var_8cb8d474[#"axis"][2] = #"hash_253fd3975ea7547c";
  level.var_8cb8d474[#"axis"][1] = #"hash_1edd5ff5456df7f7";
  level.var_8cb8d474[#"axis"][3] = #"hash_61f816d9a00b29c6";
  level.var_8cb8d474[#"axis"][4] = #"hash_753a11f84aa8941";
  level.var_a72b250f = [];
  level.var_a72b250f[#"free"] = #"hash_24d789c80dba10e6";
  level.var_a72b250f[#"allies"] = #"hash_e2e52f9cab15dce";
  level.var_a72b250f[#"axis"] = #"hash_50c9ef9e41155cf9";
  level.var_a72b250f[#"spectator"] = #"hash_e2e52f9cab15dce";
  level.draftstructs = [];
  level.draftstructs[#"free"] = #"draft_team_struct";
  level.draftstructs[#"allies"] = #"draft_team_struct_allies";
  level.draftstructs[#"axis"] = #"hash_700492f71a083a7c";
  level.draftstructs[#"spectator"] = #"draft_team_struct_allies";
  level.draftexploders = [];
  level.draftexploders[#"allies"] = "mp_draft_lights_allies";
  level.draftexploders[#"axis"] = "mp_draft_lights_axis";
  level.activeexploder = undefined;
  level.playerscriptstructs = [];
  level.playerscriptstructs[#"free"] = [];
  level.playerscriptstructs[#"allies"] = [];
  level.playerscriptstructs[#"axis"] = [];

  for(i = 0; i < 5; i++) {
    level.playerscriptstructs[#"free"][i] = struct::get(level.var_8cb8d474[#"free"][i]);
    level.playerscriptstructs[#"allies"][i] = struct::get(level.var_8cb8d474[#"allies"][i]);
    level.playerscriptstructs[#"axis"][i] = struct::get(level.var_8cb8d474[#"axis"][i]);
  }

  level thread function_ca03ab69();
  level thread function_91858511();
  level.draftstage = 0;
  level.draftcharacters = [];
  level.draftactive = [];
  level.draftactivecam = [];
  level.var_df72fe54 = [];
  level.draftintroplayed = [];

  for(i = 0; i < getmaxlocalclients(); i++) {
    level.draftactive[i] = 0;
    level.draftintroplayed[i] = 0;
    level.draftactivecam[i] = "";
    level.var_df72fe54[i] = "";

    for(t = 0; t < level.var_a968beb.size; t++) {
      level.draftcharacters[i][level.var_a968beb[t]] = [];
    }
  }

  autoselectcharacter = getdvarint(#"auto_select_character", -1);

  if(player_role::is_valid(autoselectcharacter)) {
    clearstreamerloadinghints();
  }

  level.var_8c099032 = getgametypesetting(#"draftenabled") && !getroundsplayed(0);
  level.var_f35699bc = [#"melee_slaybell_t8": "melee_alt", #"melee_secretsanta_t8": "melee_alt", #"melee_coinbag_t8": "melee_alt", #"melee_demohammer_t8": "melee_alt", #"melee_club_t8": "melee_alt", #"melee_cutlass_t8": "melee_alt", #"special_ballisticknife_t8_dw": "melee_alt", #"special_ballisticknife_t8_dw_dw": "melee_alt", #"melee_zombiearm_t8": "melee_backhand", #"melee_actionfigure_t8": "melee_actionfigure"];
}

function_c4dfe16e(localclientnum) {
  localplayer = function_5c10bd79(localclientnum);
  isteambased = isgametypeteambased();

  if(!isteambased && localplayer.team != #"free") {
    return #"allies";
  }

  return localplayer.team;
}

function_75442e78(team, index) {
  if(!isDefined(level.var_8cb8d474[team])) {
    team = #"free";
  }

  return struct::get(level.var_8cb8d474[team][index]);
}

play_intro_cinematic(localclientnum) {
  if(isDefined(level.draftintroplayed[localclientnum]) && level.draftintroplayed[localclientnum]) {
    return false;
  }

  team = function_c4dfe16e(localclientnum);

  if(isDefined(level.var_a72b250f[team])) {
    var_17e3fc35 = struct::get(level.var_a72b250f[team]);

    if(isDefined(var_17e3fc35) && isDefined(level.var_99ef4320) && isDefined(level.var_99ef4320[team])) {
      level.draftactivecam[localclientnum] = "cam_draft_intro";
      playmaincamxcam(localclientnum, level.var_99ef4320[team], 0, "cam_draft_intro", "", var_17e3fc35.origin, var_17e3fc35.angles);
      duration = getcamanimtime(level.var_99ef4320[team]);
      wait float(duration) / 1000;
      level.draftintroplayed[localclientnum] = 1;
    }
  }

  setuimodelvalue(createuimodel(getuimodelforcontroller(localclientnum), "PositionDraft.introPlayed"), 1);

  if(team == #"spectator") {
    function_532dfc0b(localclientnum, 0);
  } else {
    function_e79c182b(localclientnum, 0);

    if(isDefined(level.var_a72b250f[team])) {
      function_26c00d58(localclientnum);
    }
  }

  return isDefined(level.draftintroplayed[localclientnum]) && level.draftintroplayed[localclientnum];
}

show_cam(localclientnum, xcam, animname, lerpduration) {
  if(isDefined(level.var_84e5adfd) && level.var_84e5adfd) {
    return;
  }

  if(!isDefined(xcam) || !isDefined(animname)) {
    return;
  }

  if(isDefined(level.draftactivecam[localclientnum]) && level.draftactivecam[localclientnum] == animname && isDefined(level.var_df72fe54[localclientnum]) && level.var_df72fe54[localclientnum] == xcam) {
    return;
  }

  if(shoutcaster::is_shoutcaster(localclientnum)) {
    lerpduration = 0;
  }

  team = function_c4dfe16e(localclientnum);

  if(isDefined(level.draftstructs[team])) {
    draftstruct = struct::get(level.draftstructs[team], "targetname");

    if(isDefined(draftstruct)) {
      playmaincamxcam(localclientnum, xcam, lerpduration, animname, "", draftstruct.origin, draftstruct.angles);
      level.draftactivecam[localclientnum] = animname;
      level.var_df72fe54[localclientnum] = xcam;
    }
  }
}

stop_cameras(localclientnum) {
  stopmaincamxcam(localclientnum);
  level.draftactivecam[localclientnum] = undefined;
  level.var_df72fe54[localclientnum] = undefined;
}

function_532dfc0b(localclientnum, lerpduration) {
  show_cam(localclientnum, level.var_482af62e, "cam_draft_zoom", lerpduration);
}

function_e79c182b(localclientnum, lerpduration) {
  show_cam(localclientnum, level.draftxcam, "cam_draft_ingame", lerpduration);
}

function_fccaf2ed(localclientnum, lerpduration) {
  show_cam(localclientnum, "ui_cam_frontend_loadout_mp", "cam_loadout_mp", lerpduration);
}

enable_lights(localclientnum) {
  team = function_c4dfe16e(localclientnum);

  if(isDefined(level.draftexploders[team])) {
    level.activeexploder = level.draftexploders[team];
    playradiantexploder(localclientnum, level.activeexploder);
  }
}

function_2c486f35(localclientnum) {
  if(isDefined(level.activeexploder)) {
    killradiantexploder(localclientnum, level.activeexploder);
    level.activeexploder = undefined;
  }
}

handledraftstage(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(isDefined(newval)) {
    controllermodel = getuimodelforcontroller(localclientnum);
    var_a5976120 = createuimodel(controllermodel, "PositionDraft.stage");
    setuimodelvalue(var_a5976120, newval);
    level.draftstage = newval;

    if(newval != 0) {
      level.var_8c099032 = undefined;
    }
  }

  if(oldval != 0 && newval == 0) {
    killstreak_detect::function_3eff7815(localclientnum);
    killstreak_detect::function_32c8b999(localclientnum);
  }
}

function_799e0ac1(localclientnum, draftcharacter, masked) {
  if(masked && !(isDefined([[draftcharacter]] - > function_82e05d64().masked) && [[draftcharacter]] - > function_82e05d64().masked)) {
    [[draftcharacter]] - > function_27945cb8(1);
    [[draftcharacter]] - > function_82e05d64().masked = 1;
    return;
  }

  if(!masked && isDefined([[draftcharacter]] - > function_82e05d64().masked) && [[draftcharacter]] - > function_82e05d64().masked) {
    [[draftcharacter]] - > function_27945cb8(0);
    [[draftcharacter]] - > function_82e05d64().masked = 0;
  }
}

function_236a944e(localclientnum) {
  team = function_c4dfe16e(localclientnum);

  foreach(character in level.draftcharacters[localclientnum][team]) {
    if([
        [character]
      ] - > function_82e05d64().showmodel) {
      [
        [character]
      ] - > show_model();
    }
  }
}

function_26c00d58(localclientnum) {
  team = function_c4dfe16e(localclientnum);

  foreach(character in level.draftcharacters[localclientnum][team]) {
    [[character]] - > hide_model();
  }
}

function_b139ecfb(localclientnum) {
  team = function_c4dfe16e(localclientnum);

  for(i = 0; i < level.draftcharacters[localclientnum][team].size; i++) {
    character = level.draftcharacters[localclientnum][team][i];
    var_2d0192e5 = [[character]] - > function_82e05d64();

    if(var_2d0192e5.islocalclient && var_2d0192e5.showmodel) {
      [
        [character]
      ] - > show_model();
      continue;
    }

    [[character]] - > hide_model();
  }
}

function_1cf2437c(localclientnum, draftcharacter, oldcharacterindex, newcharacterindex) {
  if(!isDefined([[draftcharacter]] - > function_82e05d64().player)) {
    return;
  }

  if([[draftcharacter]] - > function_82e05d64().localclientnum === localclientnum && isDefined([[draftcharacter]] - > function_82e05d64().selectedcharacterdata) && player_role::is_valid([[draftcharacter]] - > function_82e05d64().selectedcharacterdata.charactertype)) {
    if(isDefined(level.var_aefa616f) && level.var_aefa616f && dialog_shared::dialog_chance("characterSelectMaldivesChance")) {
      [
        [draftcharacter]
      ] - > function_82e05d64().player dialog_shared::play_dialog("maldivesCharacterSelectOverride", localclientnum);
      return;
    }

    [[draftcharacter]] - > function_82e05d64().player dialog_shared::play_dialog("characterSelect", localclientnum);
  }
}

function_bb0565d0(var_de58f286) {
  weapon_group_anim = "default";
  weapon = var_de58f286.activeweapon;

  if(isDefined(weapon)) {
    weapon_group = function_e2703c27(weapon);

    if(isDefined(level.var_f35699bc[weapon.name])) {
      weapon_group_anim = level.var_f35699bc[weapon.name];
    } else if(weapon_group == #"") {
      weapon_group_anim = "brawler";
      dualwield = getweapon(#"smg_handling_t8_dw");

      if(weapon.name == dualwield.name) {
        weapon_group_anim = "pistol";
      }
    } else if(weapon_group == #"weapon_launcher" || weapon_group == #"weapon_launcher_alt") {
      weapon_group_anim = "launcher";
    } else if(weapon_group == #"weapon_pistol" || weapon_group == #"weapon_pistol_dw") {
      weapon_group_anim = "pistol";
    } else if(weapon_group == #"weapon_smg") {
      weapon_group_anim = "smg";
    } else if(weapon_group == #"weapon_knife") {
      weapon_group_anim = "melee";
    }
  }

  return associativearray(#"default", associativearray(#"select", associativearray(#"male", "pb_rifle_male_draft_ch_select_3", #"female", "pb_rifle_fem_draft_ch_select_3"), #"hash_6eaac8719751cb14", associativearray(#"male", "pb_rifle_male_draft_select_to_preready_3", #"female", "pb_rifle_fem_draft_select_to_preready_3"), #"hash_2fe61241a25ee67c", associativearray(#"male", "pb_rifle_male_draft_preready_to_select_3", #"female", "pb_rifle_fem_draft_preready_to_select_3"), #"preready", associativearray(#"male", array("pb_rifle_male_draft_preready_1", "pb_rifle_male_draft_preready_2", "pb_rifle_male_draft_preready_3", "pb_rifle_male_draft_preready_4", "pb_rifle_male_draft_preready_5"), #"female", array("pb_rifle_fem_draft_preready_1", "pb_rifle_fem_draft_preready_2", "pb_rifle_fem_draft_preready_3", "pb_rifle_fem_draft_preready_4", "pb_rifle_fem_draft_preready_5")), #"ready", associativearray(#"male", array("pb_rifle_male_draft_transition_1", "pb_rifle_male_draft_transition_2", "pb_rifle_male_draft_transition_3", "pb_rifle_male_draft_transition_4", "pb_rifle_male_draft_transition_5"), #"female", array("pb_rifle_fem_draft_transition_1", "pb_rifle_fem_draft_transition_2", "pb_rifle_fem_draft_transition_3", "pb_rifle_fem_draft_transition_4", "pb_rifle_fem_draft_transition_5")), #"readyidle", associativearray(#"male", array("pb_rifle_male_draft_readyup_1", "pb_rifle_male_draft_readyup_2", "pb_rifle_male_draft_readyup_3", "pb_rifle_male_draft_readyup_4", "pb_rifle_male_draft_readyup_5"), #"female", array("pb_rifle_fem_draft_readyup_1", "pb_rifle_fem_draft_readyup_2", "pb_rifle_fem_draft_readyup_3", "pb_rifle_fem_draft_readyup_4", "pb_rifle_fem_draft_readyup_5"))), #"brawler", associativearray(#"select", associativearray(#"male", "pb_brawler_male_draft_idle_ch_select_3", #"female", "pb_brawler_fem_draft_idle_ch_select_3"), #"hash_6eaac8719751cb14", associativearray(#"male", "pb_brawler_male_draft_select_to_preready_3", #"female", "pb_brawler_fem_draft_select_to_preready_3"), #"hash_2fe61241a25ee67c", associativearray(#"male", "pb_brawler_male_draft_preready_to_select_3", #"female", "pb_brawler_fem_draft_preready_to_select_3"), #"preready", associativearray(#"male", array("pb_brawler_male_draft_idle_preready1", "pb_brawler_male_draft_idle_preready2", "pb_brawler_male_draft_idle_preready3", "pb_brawler_male_draft_idle_preready4", "pb_brawler_male_draft_idle_preready5"), #"female", array("pb_brawler_fem_draft_idle_preready1", "pb_brawler_fem_draft_idle_preready2", "pb_brawler_fem_draft_idle_preready3", "pb_brawler_fem_draft_idle_preready4", "pb_brawler_fem_draft_idle_preready5")), #"ready", associativearray(#"male", array("pb_brawler_male_draft_idle_transition_1", "pb_brawler_male_draft_idle_transition_2", "pb_brawler_male_draft_idle_transition_3", "pb_brawler_male_draft_idle_transition_4", "pb_brawler_male_draft_idle_transition_5"), #"female", array("pb_brawler_fem_draft_idle_transition_1", "pb_brawler_fem_draft_idle_transition_2", "pb_brawler_fem_draft_idle_transition_3", "pb_brawler_fem_draft_idle_transition_4", "pb_brawler_fem_draft_idle_transition_5")), #"readyidle", associativearray(#"male", array("pb_brawler_male_draft_readyup_1", "pb_brawler_male_draft_readyup_2", "pb_brawler_male_draft_readyup_3", "pb_brawler_male_draft_readyup_4", "pb_brawler_male_draft_readyup_5"), #"female", array("pb_brawler_fem_draft_readyup_1", "pb_brawler_fem_draft_readyup_2", "pb_brawler_fem_draft_readyup_3", "pb_brawler_fem_draft_readyup_4", "pb_brawler_fem_draft_readyup_5"))), #"melee", associativearray(#"select", associativearray(#"male", "pb_melee_male_draft_ch_select_3", #"female", "pb_melee_fem_draft_ch_select_3"), #"hash_6eaac8719751cb14", associativearray(#"male", "pb_melee_male_draft_select_to_preready_3", #"female", "pb_melee_fem_draft_select_to_preready_3"), #"hash_2fe61241a25ee67c", associativearray(#"male", "pb_melee_male_draft_preready_to_select_3", #"female", "pb_melee_fem_draft_preready_to_select_3"), #"preready", associativearray(#"male", array("pb_melee_male_draft_preready_1", "pb_melee_male_draft_preready_2", "pb_melee_male_draft_preready_3", "pb_melee_male_draft_preready_4", "pb_melee_male_draft_preready_5"), #"female", array("pb_melee_fem_draft_preready_1", "pb_melee_fem_draft_preready_2", "pb_melee_fem_draft_preready_3", "pb_melee_fem_draft_preready_4", "pb_melee_fem_draft_preready_5")), #"ready", associativearray(#"male", array("pb_melee_male_draft_transition_1", "pb_melee_male_draft_transition_2", "pb_melee_male_draft_transition_3", "pb_melee_male_draft_transition_4", "pb_melee_male_draft_transition_5"), #"female", array("pb_melee_fem_draft_transition_1", "pb_melee_fem_draft_transition_2", "pb_melee_fem_draft_transition_3", "pb_melee_fem_draft_transition_4", "pb_melee_fem_draft_transition_5")), #"readyidle", associativearray(#"male", array("pb_melee_male_draft_readyup_1", "pb_melee_male_draft_readyup_2", "pb_melee_male_draft_readyup_3", "pb_melee_male_draft_readyup_4", "pb_melee_male_draft_readyup_5"), #"female", array("pb_melee_fem_draft_readyup_1", "pb_melee_fem_draft_readyup_2", "pb_melee_fem_draft_readyup_3", "pb_melee_fem_draft_readyup_4", "pb_melee_fem_draft_readyup_5"))), #"melee_alt", associativearray(#"select", associativearray(#"male", "pb_melee_alt_male_draft_ch_select_3", #"female", "pb_melee_alt_fem_draft_ch_select_3"), #"hash_6eaac8719751cb14", associativearray(#"male", "pb_melee_alt_male_draft_select_to_preready_3", #"female", "pb_melee_alt_fem_draft_select_to_preready_3"), #"hash_2fe61241a25ee67c", associativearray(#"male", "pb_melee_alt_male_draft_preready_to_select_3", #"female", "pb_melee_alt_fem_draft_preready_to_select_3"), #"preready", associativearray(#"male", array("pb_melee_alt_male_draft_preready_1", "pb_melee_alt_male_draft_preready_2", "pb_melee_alt_male_draft_preready_3", "pb_melee_alt_male_draft_preready_4", "pb_melee_alt_male_draft_preready_5"), #"female", array("pb_melee_alt_fem_draft_preready_1", "pb_melee_alt_fem_draft_preready_2", "pb_melee_alt_fem_draft_preready_3", "pb_melee_alt_fem_draft_preready_4", "pb_melee_alt_fem_draft_preready_5")), #"ready", associativearray(#"male", array("pb_melee_alt_male_draft_transition_1", "pb_melee_alt_male_draft_transition_2", "pb_melee_alt_male_draft_transition_3", "pb_melee_alt_male_draft_transition_4", "pb_melee_alt_male_draft_transition_5"), #"female", array("pb_melee_alt_fem_draft_transition_1", "pb_melee_alt_fem_draft_transition_2", "pb_melee_alt_fem_draft_transition_3", "pb_melee_alt_fem_draft_transition_4", "pb_melee_alt_fem_draft_transition_5")), #"readyidle", associativearray(#"male", array("pb_melee_alt_male_draft_readyup_1", "pb_melee_alt_male_draft_readyup_2", "pb_melee_alt_male_draft_readyup_3", "pb_melee_alt_male_draft_readyup_4", "pb_melee_alt_male_draft_readyup_5"), #"female", array("pb_melee_alt_fem_draft_readyup_1", "pb_melee_alt_fem_draft_readyup_2", "pb_melee_alt_fem_draft_readyup_3", "pb_melee_alt_fem_draft_readyup_4", "pb_melee_alt_fem_draft_readyup_5"))), #"melee_backhand", associativearray(#"select", associativearray(#"male", "pb_backhander_male_draft_ch_select_3", #"female", "pb_backhander_fem_draft_ch_select_3"), #"hash_6eaac8719751cb14", associativearray(#"male", "pb_backhander_male_draft_select_to_preready_3", #"female", "pb_backhander_fem_draft_select_to_preready_3"), #"hash_2fe61241a25ee67c", associativearray(#"male", "pb_backhander_male_draft_preready_to_select_3", #"female", "pb_backhander_fem_draft_preready_to_select_3"), #"preready", associativearray(#"male", array("pb_backhander_male_draft_preready_1", "pb_backhander_male_draft_preready_2", "pb_backhander_male_draft_preready_3", "pb_backhander_male_draft_preready_4", "pb_backhander_male_draft_preready_5"), #"female", array("pb_backhander_fem_draft_preready_1", "pb_backhander_fem_draft_preready_2", "pb_backhander_fem_draft_preready_3", "pb_backhander_fem_draft_preready_4", "pb_backhander_fem_draft_preready_5")), #"ready", associativearray(#"male", array("pb_backhander_male_draft_transition_1", "pb_backhander_male_draft_transition_2", "pb_backhander_male_draft_transition_3", "pb_backhander_male_draft_transition_4", "pb_backhander_male_draft_transition_5"), #"female", array("pb_backhander_fem_draft_transition_1", "pb_backhander_fem_draft_transition_2", "pb_backhander_fem_draft_transition_3", "pb_backhander_fem_draft_transition_4", "pb_backhander_fem_draft_transition_5")), #"readyidle", associativearray(#"male", array("pb_backhander_male_draft_readyup_1", "pb_backhander_male_draft_readyup_2", "pb_backhander_male_draft_readyup_3", "pb_backhander_male_draft_readyup_4", "pb_backhander_male_draft_readyup_5"), #"female", array("pb_backhander_fem_draft_readyup_1", "pb_backhander_fem_draft_readyup_2", "pb_backhander_fem_draft_readyup_3", "pb_backhander_fem_draft_readyup_4", "pb_backhander_fem_draft_readyup_5"))), #"melee_actionfigure", associativearray(#"select", associativearray(#"male", "pb_action_figure_male_draft_ch_select_3", #"female", "pb_action_figure_fem_draft_ch_select_3"), #"hash_6eaac8719751cb14", associativearray(#"male", "pb_action_figure_male_draft_select_to_preready_3", #"female", "pb_action_figure_fem_draft_select_to_preready_3"), #"hash_2fe61241a25ee67c", associativearray(#"male", "pb_action_figure_male_draft_preready_to_select_3", #"female", "pb_action_figure_fem_draft_preready_to_select_3"), #"preready", associativearray(#"male", array("pb_action_figure_male_draft_preready_1", "pb_action_figure_male_draft_preready_2", "pb_action_figure_male_draft_preready_3", "pb_action_figure_male_draft_preready_4", "pb_action_figure_male_draft_preready_5"), #"female", array("pb_action_figure_fem_draft_preready_1", "pb_action_figure_fem_draft_preready_2", "pb_action_figure_fem_draft_preready_3", "pb_action_figure_fem_draft_preready_4", "pb_action_figure_fem_draft_preready_5")), #"ready", associativearray(#"male", array("pb_action_figure_male_draft_transition_1", "pb_action_figure_male_draft_transition_2", "pb_action_figure_male_draft_transition_3", "pb_action_figure_male_draft_transition_4", "pb_action_figure_male_draft_transition_5"), #"female", array("pb_action_figure_fem_draft_transition_1", "pb_action_figure_fem_draft_transition_2", "pb_action_figure_fem_draft_transition_3", "pb_action_figure_fem_draft_transition_4", "pb_action_figure_fem_draft_transition_5")), #"readyidle", associativearray(#"male", array("pb_action_figure_male_draft_readyup_1", "pb_action_figure_male_draft_readyup_2", "pb_action_figure_male_draft_readyup_3", "pb_action_figure_male_draft_readyup_4", "pb_action_figure_male_draft_readyup_5"), #"female", array("pb_action_figure_fem_draft_readyup_1", "pb_action_figure_fem_draft_readyup_2", "pb_action_figure_fem_draft_readyup_3", "pb_action_figure_fem_draft_readyup_4", "pb_action_figure_fem_draft_readyup_5"))), #"launcher", associativearray(#"select", associativearray(#"male", "pb_launcher_male_draft_ch_select_3", #"female", "pb_launcher_fem_draft_ch_select_3"), #"hash_6eaac8719751cb14", associativearray(#"male", "pb_launcher_male_draft_select_to_preready_3", #"female", "pb_launcher_fem_draft_select_to_preready_3"), #"hash_2fe61241a25ee67c", associativearray(#"male", "pb_launcher_male_draft_preready_to_select_3", #"female", "pb_launcher_fem_draft_preready_to_select_3"), #"preready", associativearray(#"male", array("pb_launcher_male_draft_preready1", "pb_launcher_male_draft_preready2", "pb_launcher_male_draft_preready3", "pb_launcher_male_draft_preready4", "pb_launcher_male_draft_preready5"), #"female", array("pb_launcher_fem_draft_ch_preready_1", "pb_launcher_fem_draft_ch_preready_2", "pb_launcher_fem_draft_ch_preready_3", "pb_launcher_fem_draft_ch_preready_4", "pb_launcher_fem_draft_ch_preready_5")), #"ready", associativearray(#"male", array("pb_launcher_male_draft_transition_1", "pb_launcher_male_draft_transition_2", "pb_launcher_male_draft_transition_3", "pb_launcher_male_draft_transition_4", "pb_launcher_male_draft_transition_5"), #"female", array("pb_launcher_fem_draft_transition_1", "pb_launcher_fem_draft_transition_2", "pb_launcher_fem_draft_transition_3", "pb_launcher_fem_draft_transition_4", "pb_launcher_fem_draft_transition_5")), #"readyidle", associativearray(#"male", array("pb_launcher_male_draft_readyup_1", "pb_launcher_male_draft_readyup_2", "pb_launcher_male_draft_readyup_3", "pb_launcher_male_draft_readyup_4", "pb_launcher_male_draft_readyup_5"), #"female", array("pb_launcher_fem_draft_readyup_1", "pb_launcher_fem_draft_readyup_2", "pb_launcher_fem_draft_readyup_3", "pb_launcher_fem_draft_readyup_4", "pb_launcher_fem_draft_readyup_5"))), #"pistol", associativearray(#"select", associativearray(#"male", "pb_pistol_male_draft_ch_select_3", #"female", "pb_pistol_fem_draft_ch_select_3"), #"hash_6eaac8719751cb14", associativearray(#"male", "pb_pistol_male_draft_select_to_preready_3", #"female", "pb_pistol_fem_draft_select_to_preready_3"), #"hash_2fe61241a25ee67c", associativearray(#"male", "pb_pistol_male_draft_preready_to_select_3", #"female", "pb_pistol_fem_draft_preready_to_select_3"), #"preready", associativearray(#"male", array("pb_pistol_male_draft_preready_1", "pb_pistol_male_draft_preready_2", "pb_pistol_male_draft_preready_3", "pb_pistol_male_draft_preready_4", "pb_pistol_male_draft_preready_5"), #"female", array("pb_pistol_fem_draft_preready_1", "pb_pistol_fem_draft_preready_2", "pb_pistol_fem_draft_preready_3", "pb_pistol_fem_draft_preready_4", "pb_pistol_fem_draft_preready_5")), #"ready", associativearray(#"male", array("pb_pistol_male_draft_transition_1", "pb_pistol_male_draft_transition_2", "pb_pistol_male_draft_transition_3", "pb_pistol_male_draft_transition_4", "pb_pistol_male_draft_transition_5"), #"female", array("pb_pistol_fem_draft_transition_1", "pb_pistol_fem_draft_transition_2", "pb_pistol_fem_draft_transition_3", "pb_pistol_fem_draft_transition_4", "pb_pistol_fem_draft_transition_5")), #"readyidle", associativearray(#"male", array("pb_pistol_male_draft_readyup_1", "pb_pistol_male_draft_readyup_2", "pb_pistol_male_draft_readyup_3", "pb_pistol_male_draft_readyup_4", "pb_pistol_male_draft_readyup_5"), #"female", array("pb_pistol_fem_draft_readyup_1", "pb_pistol_fem_draft_readyup_2", "pb_pistol_fem_draft_readyup_3", "pb_pistol_fem_draft_readyup_4", "pb_pistol_fem_draft_readyup_5"))), #"smg", associativearray(#"select", associativearray(#"male", "pb_smg_male_draft_idle_ch_select_3", #"female", "pb_smg_fem_draft_idle_ch_select_3"), #"hash_6eaac8719751cb14", associativearray(#"male", "pb_smg_male_draft_select_to_preready_3", #"female", "pb_smg_fem_draft_select_to_preready_3"), #"hash_2fe61241a25ee67c", associativearray(#"male", "pb_smg_male_draft_preready_to_select_3", #"female", "pb_smg_fem_draft_preready_to_select_3"), #"preready", associativearray(#"male", array("pb_smg_male_draft_preready_1", "pb_smg_male_draft_preready_2", "pb_smg_male_draft_preready_3", "pb_smg_male_draft_preready_4", "pb_smg_male_draft_preready_5"), #"female", array("pb_smg_fem_draft_preready_1", "pb_smg_fem_draft_preready_2", "pb_smg_fem_draft_preready_3", "pb_smg_fem_draft_preready_4", "pb_smg_fem_draft_preready_5")), #"ready", associativearray(#"male", array("pb_smg_male_draft_transition_1", "pb_smg_male_draft_transition_2", "pb_smg_male_draft_transition_3", "pb_smg_male_draft_transition_4", "pb_smg_male_draft_transition_5"), #"female", array("pb_smg_fem_draft_transition_1", "pb_smg_fem_draft_transition_2", "pb_smg_fem_draft_transition_3", "pb_smg_fem_draft_transition_4", "pb_smg_fem_draft_transition_5")), #"readyidle", associativearray(#"male", array("pb_smg_male_draft_readyup_1", "pb_smg_male_draft_readyup_2", "pb_smg_male_draft_readyup_3", "pb_smg_male_draft_readyup_4", "pb_smg_male_draft_readyup_5"), #"female", array("pb_smg_fem_draft_readyup_1", "pb_smg_fem_draft_readyup_2", "pb_smg_fem_draft_readyup_3", "pb_smg_fem_draft_readyup_4", "pb_smg_fem_draft_readyup_5"))))[weapon_group_anim];
}

function_6b532f83(localclientnum, var_de58f286, sessionmode) {
  posindex = var_de58f286.positionindex;
  anim_intro_name = undefined;
  anim_name = undefined;
  weapongroupanim = function_bb0565d0(var_de58f286);

  if(isDefined(var_de58f286.activecharacter) && player_role::is_valid(var_de58f286.activecharacter.charactertype)) {
    if(!isDefined(var_de58f286) || !isDefined(var_de58f286.var_91065a59) || !isDefined(var_de58f286.var_3afd181d)) {
      assert(isDefined(var_de58f286));
      assert(isDefined(var_de58f286.var_91065a59));
      assert(isDefined(var_de58f286.var_3afd181d));
      return;
    }

    gender = getherogender(var_de58f286.activecharacter.charactertype, sessionmode);

    if(var_de58f286.var_91065a59 != var_de58f286.var_3afd181d) {
      if(var_de58f286.var_91065a59) {
        var_ca1716fe = weapongroupanim[#"ready"][gender];
        anim_intro_name = var_ca1716fe[posindex % var_ca1716fe.size];
        var_177782dd = weapongroupanim[#"readyidle"][gender];
        anim_name = var_177782dd[posindex % var_177782dd.size];
      }

      var_de58f286.var_3afd181d = var_de58f286.var_91065a59;
    } else if(player_role::is_valid(var_de58f286.focusedcharacterindex)) {
      if(var_de58f286.selected) {
        anim_intro_name = weapongroupanim[#"hash_2fe61241a25ee67c"][gender];
        var_de58f286.selected = 0;
      }

      anim_name = weapongroupanim[#"select"][gender];
    } else {
      if(!var_de58f286.var_91065a59) {
        if(posindex == 1 && !shoutcaster::is_shoutcaster(localclientnum)) {
          anim_intro_name = weapongroupanim[#"hash_6eaac8719751cb14"][gender];
        }

        var_b793aad = weapongroupanim[#"preready"][gender];
        anim_name = var_b793aad[posindex % var_b793aad.size];
      } else {
        var_ca1716fe = weapongroupanim[#"ready"][gender];
        anim_intro_name = var_ca1716fe[posindex % var_ca1716fe.size];
        var_177782dd = weapongroupanim[#"readyidle"][gender];
        anim_name = var_177782dd[posindex % var_177782dd.size];
      }

      var_de58f286.selected = 1;
    }
  } else {
    anim_name = array("pb_rifle_male_draft_preready_1", "pb_rifle_male_draft_preready_2", "pb_rifle_male_draft_preready_3", "pb_rifle_male_draft_preready_4", "pb_rifle_male_draft_preready_5")[posindex % array("pb_rifle_male_draft_preready_1", "pb_rifle_male_draft_preready_2", "pb_rifle_male_draft_preready_3", "pb_rifle_male_draft_preready_4", "pb_rifle_male_draft_preready_5").size];
  }

  var_de58f286.params.anim_intro_name = anim_intro_name;
  var_de58f286.params.anim_name = anim_name;
}

function_93a4f3c5(localclientnum, draftcharacter) {
  sessionmode = currentsessionmode();
  var_de58f286 = [[draftcharacter]] - > function_82e05d64();

  if(player_role::is_valid(var_de58f286.focusedcharacterindex)) {
    var_3f83e0ee = character_customization::function_7474681d(localclientnum, sessionmode, [[draftcharacter]] - > function_82e05d64().focusedcharacterindex);

    if(!character_customization::function_aa5382ed(var_de58f286.activecharacter, var_3f83e0ee)) {
      return false;
    }

    [[draftcharacter]] - > function_82e05d64().activecharacter = var_3f83e0ee;
  } else if(!isDefined(var_de58f286.activecharacter) || character_customization::function_aa5382ed(var_de58f286.activecharacter, var_de58f286.selectedcharacterdata)) {
    function_1cf2437c(localclientnum, draftcharacter, var_de58f286.activecharacter, var_de58f286.selectedcharacterdata);
    var_de58f286.activecharacter = var_de58f286.selectedcharacterdata;
  }

  if(isDefined(var_de58f286.activecharacter) && player_role::is_valid(var_de58f286.activecharacter.charactertype)) {
    [[draftcharacter]] - > function_1ec9448d(0);
    [[draftcharacter]] - > function_15a8906a([[draftcharacter]] - > function_82e05d64().activecharacter);
    function_799e0ac1(localclientnum, draftcharacter, 0);
  } else {
    [[draftcharacter]] - > function_1ec9448d(1);
    [[draftcharacter]] - > set_character_index(0);
    function_799e0ac1(localclientnum, draftcharacter, 1);
  }

  return true;
}

function_2dfe152c(localclientnum, draftcharacter, oldweapon, newweapon) {}

function_4ccc033d(localclientnum, draftcharacter) {
  if(isDefined([[draftcharacter]] - > function_82e05d64().primaryweapon)) {
    if(!isDefined([
        [draftcharacter]
      ] - > function_82e05d64().activeweapon)) {
      return 1;
    }

    if(isDefined(level.var_ea696257) && level.var_ea696257) {
      return ([
        [draftcharacter]
      ] - > function_82e05d64().activeweapon != getweapon(#"pistol_standard_t8"));
    } else if(isDefined(level.var_8eef5741) && level.var_8eef5741) {
      return ([
        [draftcharacter]
      ] - > function_82e05d64().activeweapon != level.var_bf82f6b0);
    } else if(isDefined(level.isgungame) && level.isgungame) {
      return ([
        [draftcharacter]
      ] - > function_82e05d64().activeweapon != getweapon(#"pistol_fullauto_t8"));
    } else if(isDefined(level.var_207a1c9a) && level.var_207a1c9a) {
      return ([
        [draftcharacter]
      ] - > function_82e05d64().activeweapon != getweapon(#"crossbow_special_t8"));
    } else {
      newprimary = [
        [draftcharacter]
      ] - > function_82e05d64().activeweapon != [
        [draftcharacter]
      ] - > function_82e05d64().primaryweapon || [
        [draftcharacter]
      ] - > function_82e05d64().var_b8f20727 !== [
        [draftcharacter]
      ] - > function_82e05d64().primaryweaponoptions;
      return newprimary;
    }
  }

  return 0;
}

update_player_weapon(localclientnum, draftcharacter) {
  changed = 0;

  if(function_4ccc033d(localclientnum, draftcharacter)) {
    function_2dfe152c(localclientnum, draftcharacter, [[draftcharacter]] - > function_82e05d64().activeweapon, [[draftcharacter]] - > function_82e05d64().primaryweapon);

    if(isDefined(level.var_ea696257) && level.var_ea696257) {
      [
        [draftcharacter]
      ] - > function_82e05d64().activeweapon = getweapon(#"pistol_standard_t8");
      [
        [draftcharacter]
      ] - > function_82e05d64().var_b8f20727 = 0;
    } else if(isDefined(level.var_8eef5741) && level.var_8eef5741) {
      [
        [draftcharacter]
      ] - > function_82e05d64().activeweapon = level.var_bf82f6b0;
      [
        [draftcharacter]
      ] - > function_82e05d64().var_b8f20727 = 0;
    } else if(isDefined(level.isgungame) && level.isgungame) {
      [
        [draftcharacter]
      ] - > function_82e05d64().activeweapon = getweapon(#"pistol_fullauto_t8");
      [
        [draftcharacter]
      ] - > function_82e05d64().var_b8f20727 = 0;
    } else if(isDefined(level.var_207a1c9a) && level.var_207a1c9a) {
      [
        [draftcharacter]
      ] - > function_82e05d64().activeweapon = getweapon(#"special_crossbow_t8");
      [
        [draftcharacter]
      ] - > function_82e05d64().var_b8f20727 = 0;
    } else if([
        [draftcharacter]
      ] - > function_82e05d64().primaryweapon == level.weaponnone) {
      [
        [draftcharacter]
      ] - > function_82e05d64().activeweapon = [
        [draftcharacter]
      ] - > function_82e05d64().secondaryweapon;
      [
        [draftcharacter]
      ] - > function_82e05d64().var_b8f20727 = [
        [draftcharacter]
      ] - > function_82e05d64().secondaryweaponoptions;
    } else {
      [
        [draftcharacter]
      ] - > function_82e05d64().activeweapon = [
        [draftcharacter]
      ] - > function_82e05d64().primaryweapon;
      [
        [draftcharacter]
      ] - > function_82e05d64().var_b8f20727 = [
        [draftcharacter]
      ] - > function_82e05d64().primaryweaponoptions;
    }

    [[draftcharacter]] - > function_82e05d64().params.activeweapon = [[draftcharacter]] - > function_82e05d64().activeweapon;
    [[draftcharacter]] - > function_82e05d64().params.var_b8f20727 = [[draftcharacter]] - > function_82e05d64().var_b8f20727;
    changed = 1;
  }

  return changed;
}

function_71a9fb67(localclientnum, draftcharacter) {
  update = 0;

  if(function_93a4f3c5(localclientnum, draftcharacter)) {
    update = 1;
  }

  if(update_player_weapon(localclientnum, draftcharacter)) {
    update = 1;
  }

  if(update) {
    sessionmode = currentsessionmode();
    var_de58f286 = [[draftcharacter]] - > function_82e05d64();
    function_6b532f83(localclientnum, var_de58f286, sessionmode);
    [[draftcharacter]] - > update([[draftcharacter]] - > function_82e05d64().params);
  }
}

update_team(localclientnum, var_4123f2c1) {
  localplayer = function_5c10bd79(localclientnum);
  team = function_c4dfe16e(localclientnum);
  controllermodel = getuimodelforcontroller(localclientnum);
  positiondraftclientsmodel = getuimodel(controllermodel, "PositionDraftClients");

  for(i = 0; i < 5; i++) {
    if(!isDefined(level.draftcharacters[localclientnum][team]) || !isDefined(level.draftcharacters[localclientnum][team][i])) {
      continue;
    }

    draftcharacter = level.draftcharacters[localclientnum][team][i];
    [[draftcharacter]] - > function_82e05d64().selectedcharacterdata = undefined;
    [[draftcharacter]] - > function_82e05d64().primaryweapon = level.weaponnone;
    [[draftcharacter]] - > function_82e05d64().primaryweaponoptions = 0;
    [[draftcharacter]] - > function_82e05d64().secondaryweapon = level.weaponnone;
    [[draftcharacter]] - > function_82e05d64().secondaryweaponoptions = 0;

    if(isDefined(positiondraftclientsmodel)) {
      luaindex = i + 1;
      positionmodel = getuimodel(positiondraftclientsmodel, luaindex);
      clientnum = getuimodelvalue(getuimodel(positionmodel, "clientNum"));
      [
        [draftcharacter]
      ] - > function_82e05d64().islocalclient = getuimodelvalue(getuimodel(positionmodel, "isLocalClient"));
      [
        [draftcharacter]
      ] - > function_82e05d64().entnummodel = createuimodel(positionmodel, "entNum");
      setuimodelvalue([
        [draftcharacter]
      ] - > function_82e05d64().entnummodel, [
        [draftcharacter]
      ] - > function_47cb6b19());

      if(clientnum >= 0) {
        player = getentbynum(localclientnum, clientnum);

        if(isDefined(player) && player function_e4f35989()) {
          [
            [draftcharacter]
          ] - > function_82e05d64().player = player;
          [
            [draftcharacter]
          ] - > function_82e05d64().selectedcharacterdata = player function_79a48799();

          if(isDefined([
              [draftcharacter]
            ] - > function_82e05d64().selectedcharacterdata) && player_role::is_valid([
              [draftcharacter]
            ] - > function_82e05d64().selectedcharacterdata.charactertype) && player_role::is_valid([
              [draftcharacter]
            ] - > function_82e05d64().focusedcharacterindex)) {
            [
              [draftcharacter]
            ] - > function_82e05d64().activecharacter = undefined;
            [
              [draftcharacter]
            ] - > function_82e05d64().focusedcharacterindex = 0;
          }

          [
            [draftcharacter]
          ] - > function_82e05d64().primaryweapon = player getprimaryweapon();
          [
            [draftcharacter]
          ] - > function_82e05d64().primaryweaponoptions = player function_519bc773();
          [
            [draftcharacter]
          ] - > function_82e05d64().secondaryweapon = player getsecondaryweapon();
          [
            [draftcharacter]
          ] - > function_82e05d64().secondaryweaponoptions = player function_64c66c4b();
        } else {
          [
            [draftcharacter]
          ] - > function_82e05d64().player = undefined;
        }

        if(isDefined([
            [draftcharacter]
          ] - > function_82e05d64().islocalclient) && [
            [draftcharacter]
          ] - > function_82e05d64().islocalclient || shoutcaster::is_shoutcaster(localclientnum)) {
          if(!isDefined([
              [draftcharacter]
            ] - > function_82e05d64().player)) {
            [
              [draftcharacter]
            ] - > function_82e05d64().player = localplayer;
            [
              [draftcharacter]
            ] - > function_82e05d64().primaryweapon = localplayer getprimaryweapon();
            [
              [draftcharacter]
            ] - > function_82e05d64().primaryweaponoptions = localplayer function_519bc773();
            [
              [draftcharacter]
            ] - > function_82e05d64().secondaryweapon = localplayer getsecondaryweapon();
            [
              [draftcharacter]
            ] - > function_82e05d64().secondaryweaponoptions = localplayer function_64c66c4b();
          }

          [
            [draftcharacter]
          ] - > function_82e05d64().localclientnum = localclientnum;

          if(isDefined([
              [draftcharacter]
            ] - > function_82e05d64().selectedcharacterdata) && player_role::is_valid([
              [draftcharacter]
            ] - > function_82e05d64().selectedcharacterdata.charactertype) || shoutcaster::is_shoutcaster(localclientnum)) {
            function_236a944e(localclientnum);
            lerpduration = 1000;

            if(var_4123f2c1) {
              lerpduration = 0;
            }

            function_e79c182b(localclientnum, lerpduration);
          } else {
            function_b139ecfb(localclientnum);
            lerpduration = 1000;

            if(var_4123f2c1) {
              lerpduration = 0;
            }

            function_532dfc0b(localclientnum, lerpduration);
            positiondraftmodel = getuimodel(controllermodel, "PositionDraft");

            if(isDefined(positiondraftmodel)) {
              [
                [draftcharacter]
              ] - > function_82e05d64().focusedcharacterindex = getuimodelvalue(getuimodel(positiondraftmodel, "focusedCharacterIndex"));
            }
          }
        } else {
          [
            [draftcharacter]
          ] - > function_82e05d64().localclientnum = undefined;
        }

        var_24b754fa = getuimodelvalue(getuimodel(positionmodel, "clientInfo"));
        [
          [draftcharacter]
        ] - > function_82e05d64().var_91065a59 = getuimodelvalue(getuimodel(var_24b754fa, "ready"));

        if(shoutcaster::is_shoutcaster(localclientnum) && !isDefined([
            [draftcharacter]
          ] - > function_82e05d64().var_91065a59) && isDefined(player) && isbot(player)) {
          [
            [draftcharacter]
          ] - > function_82e05d64().var_91065a59 = 0;
        }
      }
    }

    function_71a9fb67(localclientnum, draftcharacter);
  }
}

function_9e9e1117(localclientnum, draftcharacter) {
  if(isDefined([[draftcharacter]] - > function_82e05d64().entnummodel)) {
    setuimodelvalue([[draftcharacter]] - > function_82e05d64().entnummodel, [[draftcharacter]] - > function_47cb6b19());
  }
}

function_20811f66(localclientnum) {
  foreach(team in getarraykeys(level.draftcharacters[localclientnum])) {
    foreach(char in level.draftcharacters[localclientnum][team]) {
      [
        [char]
      ] - > delete_models();
    }

    level.draftcharacters[localclientnum][team] = [];
  }
}

setup_team(localclientnum) {
  function_20811f66(localclientnum);
  teambased = isgametypeteambased();
  team = function_c4dfe16e(localclientnum);

  if(isDefined(level.playerscriptstructs[team])) {
    for(i = 0; i < level.playerscriptstructs[team].size; i++) {
      if(!isDefined(level.draftcharacters[localclientnum][team][i])) {
        model = util::spawn_model(localclientnum, "tag_origin", level.playerscriptstructs[team][i].origin, level.playerscriptstructs[team][i].angles);
        model.targetname = level.playerscriptstructs[team][i].targetname;
        draftcharacter = character_customization::function_dd295310(model, localclientnum, 0);
        [
          [draftcharacter]
        ] - > function_184a4d2e(&function_9e9e1117);
        [
          [draftcharacter]
        ] - > set_character_mode(currentsessionmode());
        var_de58f286 = [
          [draftcharacter]
        ] - > function_82e05d64();
        var_de58f286.positionindex = i;
        var_de58f286.var_3afd181d = 0;
        var_de58f286.var_91065a59 = 0;
        var_de58f286.selected = 0;
        var_de58f286.params = spawnStruct();
        var_de58f286.params.sessionmode = currentsessionmode();
        var_de58f286.islocalclient = 0;
        var_de58f286.showmodel = teambased || i == 1;
        level.draftcharacters[localclientnum][team][i] = draftcharacter;
      }
    }
  }
}

watchupdate(localclientnum) {
  level endon(#"disconnect", #"draft_closed");

  while(true) {
    waitresult = level waittill(#"positiondraft_update", #"positiondraft_reject");

    if(localclientnum == waitresult.localclientnum) {
      if(shoutcaster::is_shoutcaster(localclientnum)) {
        setup_team(localclientnum);
      }

      update_team(localclientnum, 0);
    }
  }
}

watchteamchange(localclientnum) {
  self endon(#"disconnect", #"draft_closed");

  while(true) {
    waitresult = level waittill(#"team_changed");

    if(localclientnum == waitresult.localclientnum) {
      setup_team(localclientnum);
      update_team(localclientnum, 1);
    }
  }
}

watchkillcam() {
  self notify(#"hash_79dc7957d60fa25");
  self endon(#"hash_79dc7957d60fa25", #"disconnect", #"draft_closed");

  while(true) {
    level.var_84e5adfd = 0;
    level waittill(#"killcam_begin");
    level.var_84e5adfd = 1;
    level waittill(#"killcam_end");
  }
}

function_9afd868e(localclientnum) {
  self notify("5d2e4287c1d8f08d");
  self endon("5d2e4287c1d8f08d");
  self endon(#"draft_closed");

  if(!(isDefined(level.draftactive[localclientnum]) && level.draftactive[localclientnum])) {
    level.draftactive[localclientnum] = 1;
    setup_team(localclientnum);
    play_intro_cinematic(localclientnum);
    enable_lights(localclientnum);
    level thread watchupdate(localclientnum);
    level thread watchteamchange(localclientnum);

    if(!(isDefined(level.var_f6501ae8) && level.var_f6501ae8)) {
      level.var_f6501ae8 = 1;
      level thread watchkillcam();
    }

    update_team(localclientnum, 1);
  }
}

function_ca03ab69() {
  level endon(#"disconnect");

  while(true) {
    waitresult = level waittill(#"positiondraft_open");
    localclientnum = waitresult.localclientnum;
    localplayer = function_5c10bd79(localclientnum);
    localplayer serverfield::set("PositionDraft.uiLoaded", 1);
    level thread function_9afd868e(localclientnum);
  }
}

function_91858511() {
  level endon(#"disconnect");

  while(true) {
    waitresult = level waittill(#"positiondraft_close");
    localclientnum = waitresult.localclientnum;

    if(isDefined(level.draftactive[localclientnum]) && level.draftactive[localclientnum]) {
      if(!(isDefined(level.draftclosed) && level.draftclosed)) {
        level notify(#"draft_closed");
        clearstreamerloadinghints();
        level.draftclosed = 1;
      }

      function_20811f66(localclientnum);
      function_2c486f35(localclientnum);
      stop_cameras(localclientnum);
      level.draftactive[localclientnum] = 0;
    }
  }
}