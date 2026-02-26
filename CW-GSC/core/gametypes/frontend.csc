/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core\gametypes\frontend.csc
***********************************************/

#using script_209c9c119ef6fc06;
#using script_53cd49b939f89fd7;
#using script_7ca3324ffa5389e4;
#using scripts\core_common\activecamo_shared;
#using scripts\core_common\activecamo_shared_util;
#using scripts\core_common\animation_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\audio_shared;
#using scripts\core_common\battlechatter;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\character_customization;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\custom_class;
#using scripts\core_common\exploder_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\core_common\weapon_customization_icon;
#using scripts\mp_common\devgui;
#namespace frontend;

function function_9bfe9255(var_f75a02ea, mode) {
  var_a2865de6 = getplayerroletemplatecount(mode);

  for(i = 0; i < var_a2865de6; i++) {
    var_eb49090f = function_b14806c6(i, mode);

    if(isDefined(var_eb49090f) && var_eb49090f == var_f75a02ea) {
      return i;
    }
  }
}

function function_b9f8bbd9(character_index, session_mode, var_3f0e790b) {
  if(var_3f0e790b == 4) {
    return false;
  }

  if(!function_f4bf7e3f(session_mode, var_3f0e790b)) {
    return false;
  }

  fields = getcharacterfields(session_mode, var_3f0e790b);

  if(!isDefined(fields)) {
    return false;
  }

  return true;
}

function function_8d1cae0b(character_index, session_mode, var_3f0e790b) {
  if(!function_b9f8bbd9(character_index, session_mode, var_3f0e790b)) {
    return 0;
  }

  if(session_mode == 3) {
    fields = getplayerrolefields(character_index, session_mode);
    return is_true(fields.isdefaultcharacter);
  }

  characterfields = getcharacterfields(character_index, session_mode);

  if(isDefined(characterfields.requireddvar) && !getdvarint(characterfields.requireddvar, 0)) {
    return 0;
  }

  return 1;
}

function function_b24ced2b(xuid) {
  return (xuid >> 32 &-1334837248) == -1334837248;
}

function function_e3efec59(localclientnum, xuid, session_mode, var_3f0e790b, var_6ddefc3d = 0) {
  if(!isDefined(level.var_dd1c817)) {
    level.var_dd1c817 = [];
  }

  if(!isDefined(level.var_dd1c817[session_mode])) {
    level.var_dd1c817[session_mode] = [];
  }

  character_index = undefined;

  if(var_6ddefc3d > 0) {
    character_index = var_6ddefc3d;
  } else {
    character_index = getequippedheroindex(localclientnum, session_mode);

    if(!function_8d1cae0b(character_index, session_mode, var_3f0e790b)) {
      if(isDefined(level.var_dd1c817[session_mode][xuid])) {
        return level.var_dd1c817[session_mode][xuid];
      } else {
        playerroletemplatecount = getplayerroletemplatecount(session_mode);
        var_53b30724 = [];

        for(i = 0; i < playerroletemplatecount; i++) {
          if(function_8d1cae0b(i, session_mode, var_3f0e790b)) {
            if(session_mode == 1 && function_b24ced2b(xuid)) {
              rf = getplayerrolefields(i, session_mode);

              if(isDefined(rf) && is_true(rf.var_ae8ab113)) {
                if(!isDefined(var_53b30724)) {
                  var_53b30724 = [];
                } else if(!isarray(var_53b30724)) {
                  var_53b30724 = array(var_53b30724);
                }

                var_53b30724[var_53b30724.size] = i;
              }

              continue;
            }

            if(!isDefined(var_53b30724)) {
              var_53b30724 = [];
            } else if(!isarray(var_53b30724)) {
              var_53b30724 = array(var_53b30724);
            }

            var_53b30724[var_53b30724.size] = i;
          }
        }

        if(var_53b30724.size > 0) {
          character_index = array::random(var_53b30724);
        } else {
          character_index = 0;
        }
      }
    }
  }

  level.var_dd1c817[session_mode][xuid] = character_index;
  return level.var_dd1c817[session_mode][xuid];
}

function event_handler[gametype_init] main(eventstruct) {
  level.callbackentityspawned = &entityspawned;
  level.callbacklocalclientconnect = &localclientconnect;
  level.orbis = getdvarstring(#"orbisgame") == "true";
  level.durango = getdvarstring(#"durangogame") == "true";
  level.var_762a4ab = &function_79ac87ac;
  level.var_696537bb = &function_8567daf2;
  level.var_29369e8c = &function_d47a6728;
  level.var_1c6f63ee = &function_c91a9fae;
  level.var_6365df1f = &function_286efebf;
  level.var_633071d0 = 1;
  level.var_d508403d = findvolumedecalindexarray("decals_zm_lobby");
  level.var_8a620c67 = findstaticmodelindexarray("misc_models_zm_lobby");
  level.var_1a55d2dd = findvolumedecalindexarray("decals_mp_lobby");
  level.var_fec4a8fd = findstaticmodelindexarray("misc_models_mp_lobby");
  level.var_cf0ec8f9 = findstaticmodelindexarray("misc_models_s3_lobby");
  function_5d293b95();
  level thread blackscreen_watcher();
  setstreamerrequest(1, "core_frontend");
  util::function_21aef83c();
  util::function_5ff170ee();
  function_24ae4ffb();
}

function function_5d293b95() {
  if(getdvarint(#"hash_7f0099222a51b5f6", 7) == 7) {
    scene::add_scene_func(#"scene_frontend_t9_lobby_player1_s7_geo_camera", &function_65f1afd1);
    scene::add_scene_func(#"scene_frontend_start_s7", &function_65f1afd1);
    setDvar(#"hash_7b06b8037c26b99b", 200);
    return;
  }

  if(getdvarint(#"hash_7f0099222a51b5f6", 7) == 6) {
    scene::add_scene_func(#"scene_frontend_t9_lobby_player1_s6_geo_camera", &function_65f1afd1);
    scene::add_scene_func(#"scene_frontend_start_s6", &function_65f1afd1);
    setDvar(#"hash_7b06b8037c26b99b", 200);
    function_3552e8e2("gfx8_smk_puff_volume_varied_lit", "material");
    function_3552e8e2("gfx9_smk_wispy_swirl_loop_soft_lit_high_lite", "material");
    function_3552e8e2("gfx9_stitch_body", "material");
    function_3552e8e2("gfx8_smk_lg_vapor_anim_loop_lit_full_darker", "material");
    function_3552e8e2("gfx8_smk_md_thick_lobe_anim_lit_full_darker", "material");
    function_3552e8e2("gfx_dust_fall_lg_anim_lit_full_lite_st50", "material");
    function_3552e8e2("gfx_dust_swirl_md_anim_lit_full_lite", "material");
    function_3552e8e2("gfx_dust_fall_lg_anim_lit_full_lite", "material");
    function_3552e8e2("gfx9_spark_streak_long_hdrg", "material");
    function_3552e8e2("gfx8_debris_ember_em_pb_i16", "material");
    return;
  }

  if(getdvarint(#"hash_7f0099222a51b5f6", 7) == 5) {
    scene::add_scene_func(#"hash_6d750c42af02bd6d", &function_65f1afd1);
    scene::add_scene_func(#"hash_1fab79676927341c", &function_65f1afd1);
    setDvar(#"hash_7b06b8037c26b99b", 200);
    return;
  }

  if(getdvarint(#"hash_7f0099222a51b5f6", 7) == 4) {
    scene::add_scene_func(#"hash_190740d0e91e0fe4", &function_65f1afd1);
    scene::add_scene_func(#"hash_1fab7a67692735cf", &function_65f1afd1);
    setDvar(#"hash_7b06b8037c26b99b", 200);
    return;
  }

  if(getdvarint(#"hash_7f0099222a51b5f6", 7) == 3) {
    scene::add_scene_func(#"hash_9038a1b76b82cfb", &function_65f1afd1);
    scene::add_scene_func(#"hash_1fab7767692730b6", &function_65f1afd1);
    setDvar(#"hash_7b06b8037c26b99b", 200);
  }
}

function event_handler[gametype_start] start(eventstruct) {
  setupclientmenus();
}

function function_e843475e(menuname) {
  lui_camera::function_f603fc4d(menuname, #"tag_align_frontend_background", #"ui_scene_cam_background");
  lui_camera::function_460e6001(menuname, 3, #"tag_align_frontend_background", #"ui_scene_cam_background");
}

function function_43a2bce() {
  if(getdvarint(#"hash_7f0099222a51b5f6", 7) == 7) {
    var_d909a5b5 = # "scene_frontend_start_s7";
  } else if(getdvarint(#"hash_7f0099222a51b5f6", 7) == 6) {
    var_d909a5b5 = # "scene_frontend_start_s6";
  } else if(getdvarint(#"hash_7f0099222a51b5f6", 7) == 5) {
    var_d909a5b5 = # "hash_1fab79676927341c";
  } else if(getdvarint(#"hash_7f0099222a51b5f6", 7) == 4) {
    var_d909a5b5 = # "hash_1fab7a67692735cf";
  } else if(getdvarint(#"hash_7f0099222a51b5f6", 7) == 3) {
    var_d909a5b5 = # "hash_1fab7767692730b6";
  } else {
    var_d909a5b5 = # "scene_frontend_start";
  }

  return var_d909a5b5;
}

function setupclientmenus() {
  lui_camera::function_6425472c("PressStart");
  lui_camera::function_13b48f53("PressStart", &function_f2fffb6f);
  lui_camera::function_17384292("PressStart", &lobby_main);
  lui_camera::function_866692f8("PressStart", #"loadout_room", #"scene_frontend_t9_cac_overview", undefined, "overview");
  lui_camera::function_f852c52c("PressStart", #"loadout_room", 1);
  lui_camera::function_866692f8("PressStart", #"scorestreaks", #"scene_frontend_t9_scorestreak", undefined, "idle");
  lui_camera::function_866692f8("PressStart", #"zmskills", #"scene_frontend_t9_cac_overview", undefined, "overview");
  lui_camera::function_f852c52c("PressStart", #"scorestreaks", 1);
  lui_camera::function_f852c52c("PressStart", #"zmskills", 1);
  lui_camera::function_866692f8("PressStart", #"armory", #"scene_frontend_t9_cac_overview", undefined, "overview");
  lui_camera::function_f852c52c("PressStart", #"armory", 1);
  lui_camera::function_866692f8("PressStart", #"accessories", #"scene_frontend_t9_cac_overview", undefined, "wrist_accessories");
  lui_camera::function_f852c52c("PressStart", #"accessories", 1);
  lui_camera::function_866692f8("PressStart", #"character_room", #"scene_frontend_t9_character_customization_camera", undefined, "select_idle");
  var_d909a5b5 = function_43a2bce();
  lui_camera::function_866692f8("PressStart", #"room1", var_d909a5b5, undefined, "start", undefined);
  lui_camera::function_866692f8("PressStart", #"room2", var_d909a5b5, undefined, "start", undefined);
  lui_camera::function_866692f8("PressStart", #"mode_select", var_d909a5b5, undefined, "main", undefined);
  lui_camera::function_866692f8("PressStart", #"cp_story", #"scene_frontend_t9_cp_mission_select", undefined, "idle");
  lui_camera::function_866692f8("PressStart", #"cp_evidence", #"scene_frontend_t9_cp_evidence", undefined, "idle");
  lui_camera::function_866692f8("PressStart", #"hash_3262189f972fcd0e", #"scene_frontend_t9_mtx_store", undefined, "idle");
  lui_camera::function_866692f8("PressStart", #"arcade", #"scene_frontend_t9_arcade", undefined, "idle");
  lui_camera::function_8950260c("PressStart", #"character_room", #"lobby_pose", "idle");
  lui_camera::function_8950260c("PressStart", #"loadout_room", #"lobby_pose", "idle");
  lui_camera::function_8950260c("PressStart", #"character_room", #"lobby_pose", "idle");
  lui_camera::function_8950260c("PressStart", #"loadout_room", #"lobby_pose", "idle");
  lui_camera::function_8950260c("PressStart", #"character_room", #"lobby_pose", "idle");
  lui_camera::function_8950260c("PressStart", #"loadout_room", #"lobby_pose", "idle");
  lui_camera::function_8950260c("PressStart", #"armory", #"lobby_pose", "idle");
  lui_camera::function_8950260c("PressStart", #"scorestreaks", #"lobby_pose", "idle");
  lui_camera::function_8950260c("PressStart", #"character_room", #"private_lobby_pose", "idle");
  lui_camera::function_8950260c("PressStart", #"loadout_room", #"private_lobby_pose", "idle");
  lui_camera::function_8950260c("PressStart", #"character_room", #"private_lobby_pose", "idle");
  lui_camera::function_8950260c("PressStart", #"loadout_room", #"private_lobby_pose", "idle");
  lui_camera::function_8950260c("PressStart", #"character_room", #"private_lobby_pose", "idle");
  lui_camera::function_8950260c("PressStart", #"loadout_room", #"private_lobby_pose", "idle");
  lui_camera::function_8950260c("PressStart", #"armory", #"private_lobby_pose", "idle");
  lui_camera::function_8950260c("PressStart", #"scorestreaks", #"private_lobby_pose", "idle");
  lui_camera::function_8950260c("PressStart", #"zmskills", #"private_lobby_pose", "idle");
  lui_camera::function_6425472c("Armory", #"scene_frontend_t9_cac_overview", undefined, "overview");
  lui_camera::function_866692f8("Armory", #"gunsmith", #"scene_frontend_t9_gunsmith", undefined, "overview");
  lui_camera::function_f852c52c("Armory", undefined, 1);
  lui_camera::function_969a2881("LobbyInspection", &handle_inspect_player, 0, undefined, &function_4ff9b4cb);
  lui_camera::function_1337c436("LobbyInspection", "inspection_character", 0);
  lui_camera::function_969a2881("Paintshop", undefined, 0, undefined, undefined);
  lui_camera::function_969a2881("PaintjobWeaponSelect", undefined, 0, undefined, undefined);
  lui_camera::function_969a2881("Gunsmith", undefined);
  lui_camera::function_f852c52c("Gunsmith", undefined, 1);
  lui_camera::function_969a2881("GunsmithAttachmentSelect", undefined);
  lui_camera::function_f852c52c("GunsmithAttachmentSelect", undefined, 1);
  lui_camera::function_6425472c("GunsmithMTXPreview", #"scene_frontend_t9_gunsmith", undefined, "overview");
  lui_camera::function_866692f8("GunsmithMTXPreview", #"stickers_mtx", #"scene_frontend_t9_gunsmith", undefined, "stickers_mtx", undefined);
  lui_camera::function_866692f8("GunsmithMTXPreview", #"charms_mtx", #"scene_frontend_t9_gunsmith", undefined, "charms_mtx", undefined);
  lui_camera::function_f852c52c("GunsmithMTXPreview", undefined, 1, 0);
  lui_camera::function_969a2881("WeaponInspect", undefined, 0);
  lui_camera::function_f852c52c("WeaponInspect", undefined, 1);
  lui_camera::function_969a2881("WristAccessoriesMTXPreview", undefined, 0);
  lui_camera::function_f852c52c("WristAccessoriesMTXPreview", undefined, 1, 0);
  lui_camera::function_6425472c("LeaguePlayRewards", #"scene_frontend_t9_gunsmith", undefined, "overview");
  lui_camera::function_866692f8("LeaguePlayRewards", #"charms_mtx", #"scene_frontend_t9_gunsmith", undefined, "charms_mtx", undefined);
  lui_camera::function_f852c52c("LeaguePlayRewards", undefined, 1);
  lui_camera::function_6425472c("SupportSelection", #"scene_frontend_t9_scorestreak", undefined, "idle");
  lui_camera::function_6425472c("ZMUpgrades");
  lui_camera::function_6425472c("ZMFactionOverview", #"scene_frontend_t9_cp_evidence", undefined, "idle");
  lui_camera::function_6425472c("ZMIntelInspect", #"scene_frontend_t9_cp_evidence", undefined, "idle");
  lui_camera::function_969a2881("BubblegumBuffSelect", undefined, undefined, undefined, undefined);
  lui_camera::function_969a2881("Pregame_Main", &lobby_main, 1);
  lui_camera::function_969a2881("MPCustomizeClassMenu", undefined, 0, undefined, undefined);
  lui_camera::function_f852c52c("MPCustomizeClassMenu", undefined, 1);
  lui_camera::function_969a2881("ZMCustomizeClassMenu", undefined, 0, undefined, undefined);
  lui_camera::function_f852c52c("ZMCustomizeClassMenu", undefined, 1);
  lui_camera::function_6425472c("WeaponSelectFlyout", #"scene_frontend_t9_cac_overview", undefined, "overview");
  lui_camera::function_f852c52c("WeaponSelectFlyout", undefined, 1);
  function_e843475e("EmblemSelect");
  function_e843475e("EmblemChooseIcon");
  function_e843475e("EmblemEditor");
  function_e843475e("Store");
  function_e843475e("Store_DLC");
  function_e843475e("DirectorFindGame");
  lui_camera::function_6425472c("CharacterSelectionMenu", #"scene_frontend_t9_character_customization_camera", undefined, "select_idle");
  lui_camera::function_de0ab("CharacterSelectionMenu", &function_5eb72c78);
  lui_camera::function_6425472c("CharacterSelection_OperatorPreview", #"scene_frontend_t9_operator_inspect_camera", undefined, "inspect_idle");
  lui_camera::function_17384292("CharacterSelection_OperatorPreview", &function_763f40c4);
  lui_camera::function_866692f8("CharacterSelection_OperatorPreview", #"hash_be671ade60002b", #"scene_frontend_t9_operator_inspect_camera", undefined, "inspect_idle");
  lui_camera::function_6425472c("OperatorMissionsOverview", #"scene_frontend_t9_operator_inspect_camera", undefined, "operator_missions");
  lui_camera::function_17384292("OperatorMissionsOverview", &function_763f40c4);
  lui_camera::function_866692f8("OperatorMissionsOverview", #"character", #"scene_frontend_t9_operator_inspect_camera", undefined, "operator_missions", undefined);
  lui_camera::function_6425472c("PersonalizeCharacter", #"scene_frontend_t9_character_customization_camera", undefined, "outfit_idle");
  lui_camera::function_17384292("PersonalizeCharacter", &function_763f40c4);
  lui_camera::function_866692f8("PersonalizeCharacter", #"character", #"scene_frontend_t9_character_customization_camera", undefined, "outfit_idle", undefined);
  lui_camera::function_866692f8("PersonalizeCharacter", #"face", #"scene_frontend_t9_character_customization_camera", undefined, "outfit_idle", undefined);
  lui_camera::function_8950260c("PersonalizeCharacter", #"character", #"face", "outfit_idle");
  lui_camera::function_8950260c("PersonalizeCharacter", #"face", #"character", "outfit_idle");
  lui_camera::function_6425472c("ArcadeMachineFrontend", #"scene_frontend_t9_arcade", undefined, "idle");
  function_e843475e("MPSpecialistHUBTags");
  lui_camera::function_55d56772({
    #var_dcfaf6c7: 0.42
  }, "PressStart", #"scorestreaks", "PressStart", #"loadout_room");
  lui_camera::function_55d56772({
    #var_dcfaf6c7: 0.42
  }, "PressStart", #"accessories", "PressStart", #"loadout_room");
  lui_camera::function_55d56772({
    #var_dcfaf6c7: 0.42
  }, "PressStart", #"accessories", "PressStart", #"zmskills");
  lui_camera::function_55d56772({
    #var_dcfaf6c7: 0.42
  }, "PressStart", #"zmskills", "PressStart", #"loadout_room");
  lui_camera::function_55d56772({
    #var_dcfaf6c7: 0.42
  }, "PersonalizeCharacter", undefined, "CharacterSelectionMenu", undefined);
  lui_camera::function_55d56772({
    #var_dcfaf6c7: 0
  }, "OperatorMissionsOverview", undefined, "PersonalizeCharacter", undefined);
  lui_camera::function_55d56772({
    #var_dcfaf6c7: 0
  }, "CharacterSelection_OperatorPreview", undefined, "PersonalizeCharacter", undefined);
  lui_camera::function_55d56772({
    #var_dcfaf6c7: 0
  }, "PressStart", #"private_lobby_pose", "PressStart", #"loadout_room");
  lui_camera::function_55d56772({
    #var_dcfaf6c7: 0
  }, "PressStart", #"lobby_pose", "PressStart", #"loadout_room");
  lui_camera::function_55d56772({
    #var_dcfaf6c7: 0
  }, "PressStart", #"cdl_hub", "PressStart", #"loadout_room");
  lui_camera::function_55d56772({
    #var_dcfaf6c7: 0
  }, "PressStart", #"character_room", "PressStart", #"loadout_room");
  lui_camera::function_55d56772({
    #var_dcfaf6c7: 0
  }, "PressStart", #"hash_3262189f972fcd0e", "PressStart", #"loadout_room");
  lui_camera::function_55d56772({
    #var_dcfaf6c7: 0
  }, "PressStart", #"hash_56527b57d58c2c6a", "PressStart", #"loadout_room");
}

function function_3552e8e2(str_asset, str_type = "xmodel") {
  if(!isDefined(level.var_9a5dfa7e)) {
    level.var_9a5dfa7e = [];
  }

  var_4a49b97b = {
    #str_asset: str_asset, #str_type: str_type
  };

  if(!isDefined(level.var_9a5dfa7e)) {
    level.var_9a5dfa7e = [];
  } else if(!isarray(level.var_9a5dfa7e)) {
    level.var_9a5dfa7e = array(level.var_9a5dfa7e);
  }

  if(!isinarray(level.var_9a5dfa7e, var_4a49b97b)) {
    level.var_9a5dfa7e[level.var_9a5dfa7e.size] = var_4a49b97b;
  }
}

function function_aba20851(b_force_stream = 1) {
  if(isarray(level.var_9a5dfa7e)) {
    foreach(var_ff94d594 in level.var_9a5dfa7e) {
      if(isDefined(var_ff94d594.str_asset) && isDefined(var_ff94d594.str_type)) {
        switch (var_ff94d594.str_type) {
          case # "xmodel":
            if(b_force_stream) {
              func = &forcestreamxmodel;
            } else {
              func = &stopforcestreamingxmodel;
            }

            break;
          case # "material":
            if(b_force_stream) {
              func = &forcestreammaterial;
            } else {
              func = &stopforcestreamingmaterial;
            }

            break;
          case # "bundle":
            if(b_force_stream) {
              func = &forcestreambundle;
            } else {
              func = &function_66b6e720;
            }

            break;
          case # "fx":
            if(b_force_stream) {
              func = &function_3385d776;
            } else {
              func = &function_c22a1ca2;
            }

            break;
        }

        if(isDefined(func)) {
          [[func]](var_ff94d594.str_asset);
        }
      }
    }
  }
}

function function_65f1afd1(localclientnum, a_ents) {
  function_aba20851(1);

  if(getdvarint(#"hash_7f0099222a51b5f6", 7) == 7) {
    if(!isDefined(level.var_1c6b904f)) {
      level.var_1c6b904f = a_ents[#"s7_lobby_geo_1"];
    }

    if(!isDefined(level.var_9c4a1006)) {
      level.var_9c4a1006 = a_ents[#"s7_lobby_geo_2"];
    }

    function_4b3b4c30(localclientnum);
    function_3ee9a9d8(a_ents[#"televisions"]);
    function_3ee9a9d8(a_ents[#"mall_chunks"]);
    function_3ee9a9d8(a_ents[#"awning"]);
    function_3ee9a9d8(a_ents[#"red_door"]);
  } else if(getdvarint(#"hash_7f0099222a51b5f6", 7) == 6) {
    if(!isDefined(level.var_1c6b904f)) {
      level.var_1c6b904f = a_ents[#"s6_lobby_geo_1"];
    }

    if(!isDefined(level.var_9c4a1006)) {
      level.var_9c4a1006 = a_ents[#"s6_lobby_geo_2"];
    }

    function_4b3b4c30(localclientnum);
    function_3ee9a9d8(a_ents[#"zombie_arms_left_1"]);
    function_3ee9a9d8(a_ents[#"zombie_arms_left_2"]);
    function_3ee9a9d8(a_ents[#"zombie_arms_left_3"]);
    function_3ee9a9d8(a_ents[#"zombie_arms_left_4"]);
    function_3ee9a9d8(a_ents[#"zombie_arms_left_5"]);
    function_3ee9a9d8(a_ents[#"zombie_arms_right_1"]);
    function_3ee9a9d8(a_ents[#"zombie_arms_right_2"]);
    function_3ee9a9d8(a_ents[#"zombie_arms_right_3"]);
    function_3ee9a9d8(a_ents[#"zombie_arms_right_4"]);
    function_3ee9a9d8(a_ents[#"zombie_arms_right_5"]);
    function_d45f8810(a_ents[#"pumpkins_01"], getdvarint(#"hash_499e959d9b7fbd41", 0) || getdvarint(#"hash_735ace6b22542a65", 0));
    function_d45f8810(a_ents[#"pumpkins_02"], getdvarint(#"hash_499e959d9b7fbd41", 0) || getdvarint(#"hash_735ace6b22542a65", 0));

    if(self.scriptbundlename === # "scene_frontend_t9_lobby_player1_s6_geo_camera") {}
  } else if(getdvarint(#"hash_7f0099222a51b5f6", 7) == 5) {
    if(!isDefined(level.var_1c6b904f)) {
      level.var_1c6b904f = a_ents[#"s5_lobby_geo_1"];
    }

    if(!isDefined(level.var_9c4a1006)) {
      level.var_9c4a1006 = a_ents[#"s5_lobby_geo_2"];
    }

    function_3ee9a9d8(a_ents[#"disciple"], #"c_t9_zmb_son_of_orda_head1");
    function_4b3b4c30(localclientnum);

    if(self.scriptbundlename === # "hash_6d750c42af02bd6d") {}
  } else if(getdvarint(#"hash_7f0099222a51b5f6", 7) == 4) {
    if(!isDefined(level.var_1c6b904f)) {
      level.var_1c6b904f = a_ents[#"s4_lobby_geo_1"];
    }

    if(!isDefined(level.var_9c4a1006)) {
      level.var_9c4a1006 = a_ents[#"s4_lobby_geo_2"];
    }

    function_3ee9a9d8(a_ents[#"orda"]);
    function_4b3b4c30(localclientnum);

    if(self.scriptbundlename === # "hash_190740d0e91e0fe4") {
      toggle_postfx(localclientnum, 1, #"hash_4aafa47313fe4242");
    }
  } else if(getdvarint(#"hash_7f0099222a51b5f6", 7) == 3) {
    if(!isDefined(level.var_1c6b904f)) {
      level.var_1c6b904f = a_ents[#"s3_lobby_geo_1"];
    }

    if(!isDefined(level.var_9c4a1006)) {
      level.var_9c4a1006 = a_ents[#"s3_lobby_geo_2"];
    }

    if(self.scriptbundlename === # "hash_9038a1b76b82cfb") {
      toggle_postfx(localclientnum, 1, #"hash_4739926f2710962b");
    }

    function_3ee9a9d8(a_ents[#"hash_741806a33dd8be51"]);
    function_3ee9a9d8(a_ents[#"hash_741803a33dd8b938"]);
    function_3ee9a9d8(a_ents[#"hash_14c9a51e2ee326af"]);
    function_3ee9a9d8(a_ents[#"hash_14c9a61e2ee32862"]);
    function_4b3b4c30(localclientnum);
  }

  level.var_1c6b904f setdedicatedshadow(0);
  level.var_9c4a1006 setdedicatedshadow(0);
}

function function_d45f8810(ent, b_enabled = 0, var_65c68a47) {
  if(isDefined(ent)) {
    if(!isDefined(level.var_4a6b9623)) {
      level.var_4a6b9623 = [];
    } else if(!isarray(level.var_4a6b9623)) {
      level.var_4a6b9623 = array(level.var_4a6b9623);
    }

    if(!isinarray(level.var_4a6b9623, ent)) {
      level.var_4a6b9623[level.var_4a6b9623.size] = ent;
    }

    arrayremovevalue(level.var_4a6b9623, undefined);

    if(!isDefined(var_65c68a47)) {
      var_65c68a47 = [];
    } else if(!isarray(var_65c68a47)) {
      var_65c68a47 = array(var_65c68a47);
    }

    ent.var_463f8196 = 1;
    ent.var_d4acfe11 = 1;

    if(b_enabled) {
      foreach(var_a4d3924f in var_65c68a47) {
        forcestreamxmodel(var_a4d3924f);
      }

      ent show();
      return;
    }

    foreach(var_a4d3924f in var_65c68a47) {
      stopforcestreamingxmodel(var_a4d3924f);
    }

    ent hide();
  }
}

function function_3ee9a9d8(ent, var_65c68a47) {
  if(isDefined(ent)) {
    if(!isDefined(level.var_ec513608)) {
      level.var_ec513608 = [];
    } else if(!isarray(level.var_ec513608)) {
      level.var_ec513608 = array(level.var_ec513608);
    }

    if(!isinarray(level.var_ec513608, ent)) {
      level.var_ec513608[level.var_ec513608.size] = ent;
    }

    arrayremovevalue(level.var_ec513608, undefined);

    if(!isDefined(var_65c68a47)) {
      var_65c68a47 = [];
    } else if(!isarray(var_65c68a47)) {
      var_65c68a47 = array(var_65c68a47);
    }

    ent.var_463f8196 = 1;
    ent.var_d4acfe11 = 1;

    if(sessionmodeiszombiesgame()) {
      foreach(var_a4d3924f in var_65c68a47) {
        forcestreamxmodel(var_a4d3924f);
      }

      ent show();
      return;
    }

    foreach(var_a4d3924f in var_65c68a47) {
      stopforcestreamingxmodel(var_a4d3924f);
    }

    ent hide();
  }
}

function function_5e95a81(localclientnum) {
  if(getdvarint(#"hash_499e959d9b7fbd41", 0) || getdvarint(#"hash_735ace6b22542a65", 0)) {
    if(isDefined(level.var_1c6b904f) && !isDefined(level.var_1c6b904f.var_d4daeb9)) {
      level.var_1c6b904f.var_d4daeb9 = util::spawn_model(localclientnum, #"hash_d1ed7eaf0e2163", level.var_1c6b904f.origin, level.var_1c6b904f.angles);
      level.var_1c6b904f.var_d4daeb9 linkto(level.var_1c6b904f, "tag_origin");
    }

    if(isDefined(level.var_9c4a1006) && !isDefined(level.var_9c4a1006.var_d4daeb9)) {
      level.var_9c4a1006.var_d4daeb9 = util::spawn_model(localclientnum, #"hash_3de5815f15819820", level.var_9c4a1006.origin, level.var_9c4a1006.angles);
      level.var_9c4a1006.var_d4daeb9 linkto(level.var_9c4a1006, "tag_origin");
    }
  } else {
    if(isarray(level.var_1c6b904f.var_d4daeb9.var_e7018237)) {
      foreach(n_fx_id in level.var_1c6b904f.var_d4daeb9.var_e7018237) {
        killfx(localclientnum, n_fx_id);
      }

      level.var_1c6b904f.var_d4daeb9.var_e7018237 = undefined;
    }

    if(isarray(level.var_9c4a1006.var_d4daeb9.var_e7018237)) {
      foreach(n_fx_id in level.var_9c4a1006.var_d4daeb9.var_e7018237) {
        killfx(localclientnum, n_fx_id);
      }

      level.var_9c4a1006.var_d4daeb9.var_e7018237 = undefined;
    }

    if(isDefined(level.var_1c6b904f.var_d4daeb9)) {
      level.var_1c6b904f.var_d4daeb9 delete();
    }

    if(isDefined(level.var_9c4a1006.var_d4daeb9)) {
      level.var_9c4a1006.var_d4daeb9 delete();
    }
  }

  if(isarray(level.var_4a6b9623)) {
    foreach(var_b781bc3c in level.var_4a6b9623) {
      function_d45f8810(var_b781bc3c, getdvarint(#"hash_499e959d9b7fbd41", 0) || getdvarint(#"hash_735ace6b22542a65", 0));
    }
  }
}

function function_4b3b4c30(localclientnum) {
  if(getdvarint(#"hash_7f0099222a51b5f6", 7) == 7) {
    if(sessionmodeiszombiesgame()) {
      if(isDefined(level.var_1c6b904f) && !isDefined(level.var_1c6b904f.var_be28f14c)) {
        level.var_1c6b904f.var_be28f14c = util::spawn_model(localclientnum, #"hash_6f45aa6edc65edb4", level.var_1c6b904f.origin, level.var_1c6b904f.angles);
        level.var_1c6b904f.var_be28f14c linkto(level.var_1c6b904f, "tag_origin");
        level.var_1c6b904f.var_be28f14c.var_e7018237 = playtagfxset(localclientnum, #"hash_678334b985a04f1e", level.var_1c6b904f.var_be28f14c);
      }

      if(isDefined(level.var_9c4a1006) && !isDefined(level.var_9c4a1006.var_be28f14c)) {
        level.var_9c4a1006.var_be28f14c = util::spawn_model(localclientnum, #"hash_1810a263918b9beb", level.var_9c4a1006.origin, level.var_9c4a1006.angles);
        level.var_9c4a1006.var_be28f14c linkto(level.var_9c4a1006, "tag_origin");
        level.var_9c4a1006.var_be28f14c.var_e7018237 = playtagfxset(localclientnum, #"hash_678333b985a04d6b", level.var_9c4a1006.var_be28f14c);
      }

      if(isDefined(level.var_9c4a1006.var_1d32a5f2)) {
        level.var_9c4a1006.var_1d32a5f2 delete();
      }
    } else {
      if(isarray(level.var_1c6b904f.var_be28f14c.var_e7018237)) {
        foreach(n_fx_id in level.var_1c6b904f.var_be28f14c.var_e7018237) {
          killfx(localclientnum, n_fx_id);
        }

        level.var_1c6b904f.var_be28f14c.var_e7018237 = undefined;
      }

      if(isarray(level.var_9c4a1006.var_be28f14c.var_e7018237)) {
        foreach(n_fx_id in level.var_9c4a1006.var_be28f14c.var_e7018237) {
          killfx(localclientnum, n_fx_id);
        }

        level.var_9c4a1006.var_be28f14c.var_e7018237 = undefined;
      }

      if(isDefined(level.var_1c6b904f.var_be28f14c)) {
        level.var_1c6b904f.var_be28f14c delete();
      }

      if(isDefined(level.var_9c4a1006.var_be28f14c)) {
        level.var_9c4a1006.var_be28f14c delete();
      }

      if(sessionmodeismultiplayergame() && isDefined(level.var_9c4a1006) && !isDefined(level.var_9c4a1006.var_1d32a5f2)) {
        level.var_9c4a1006.var_1d32a5f2 = util::spawn_model(localclientnum, #"hash_5443288651755161", level.var_9c4a1006.origin, level.var_9c4a1006.angles);
        level.var_9c4a1006.var_1d32a5f2 linkto(level.var_9c4a1006, "tag_origin");
      }
    }

    return;
  }

  if(getdvarint(#"hash_7f0099222a51b5f6", 7) == 6) {
    if(sessionmodeiszombiesgame()) {
      if(isDefined(level.var_1c6b904f) && !isDefined(level.var_1c6b904f.var_be28f14c)) {
        level.var_1c6b904f.var_be28f14c = util::spawn_model(localclientnum, #"hash_3fa91dff78334faf", level.var_1c6b904f.origin, level.var_1c6b904f.angles);
        level.var_1c6b904f.var_be28f14c linkto(level.var_1c6b904f, "tag_origin");
        level.var_1c6b904f.var_be28f14c.var_e7018237 = playtagfxset(localclientnum, #"hash_5aff87d3d04e83b9", level.var_1c6b904f.var_be28f14c);
      }

      if(isDefined(level.var_9c4a1006) && !isDefined(level.var_9c4a1006.var_be28f14c)) {
        level.var_9c4a1006.var_be28f14c = util::spawn_model(localclientnum, #"hash_1754e60714b1cf58", level.var_9c4a1006.origin, level.var_9c4a1006.angles);
        level.var_9c4a1006.var_be28f14c linkto(level.var_9c4a1006, "tag_origin");
        level.var_9c4a1006.var_be28f14c.var_e7018237 = playtagfxset(localclientnum, #"hash_5aff84d3d04e7ea0", level.var_9c4a1006.var_be28f14c);
      }
    } else {
      if(isarray(level.var_1c6b904f.var_be28f14c.var_e7018237)) {
        foreach(n_fx_id in level.var_1c6b904f.var_be28f14c.var_e7018237) {
          killfx(localclientnum, n_fx_id);
        }

        level.var_1c6b904f.var_be28f14c.var_e7018237 = undefined;
      }

      if(isarray(level.var_9c4a1006.var_be28f14c.var_e7018237)) {
        foreach(n_fx_id in level.var_9c4a1006.var_be28f14c.var_e7018237) {
          killfx(localclientnum, n_fx_id);
        }

        level.var_9c4a1006.var_be28f14c.var_e7018237 = undefined;
      }

      if(isDefined(level.var_1c6b904f.var_be28f14c)) {
        level.var_1c6b904f.var_be28f14c delete();
      }

      if(isDefined(level.var_9c4a1006.var_be28f14c)) {
        level.var_9c4a1006.var_be28f14c delete();
      }
    }

    return;
  }

  if(getdvarint(#"hash_7f0099222a51b5f6", 7) == 5) {
    if(sessionmodeiszombiesgame()) {
      if(isDefined(level.var_1c6b904f) && !isDefined(level.var_1c6b904f.var_be28f14c)) {
        level.var_1c6b904f.var_be28f14c = util::spawn_model(localclientnum, #"hash_4e586d38370e5f5d", level.var_1c6b904f.origin, level.var_1c6b904f.angles);
        level.var_1c6b904f.var_be28f14c linkto(level.var_1c6b904f, "tag_origin");
        level.var_1c6b904f.var_be28f14c.var_e7018237 = playtagfxset(localclientnum, #"hash_f06dd77da1d080", level.var_1c6b904f.var_be28f14c);
      }

      if(isDefined(level.var_9c4a1006) && !isDefined(level.var_9c4a1006.var_be28f14c)) {
        level.var_9c4a1006.var_be28f14c = util::spawn_model(localclientnum, #"hash_4ec6050c32be75de", level.var_9c4a1006.origin, level.var_9c4a1006.angles);
        level.var_9c4a1006.var_be28f14c linkto(level.var_9c4a1006, "tag_origin");
        level.var_9c4a1006.var_be28f14c.var_e7018237 = playtagfxset(localclientnum, #"hash_f070d77da1d599", level.var_9c4a1006.var_be28f14c);
      }
    } else {
      if(isarray(level.var_1c6b904f.var_be28f14c.var_e7018237)) {
        foreach(n_fx_id in level.var_1c6b904f.var_be28f14c.var_e7018237) {
          killfx(localclientnum, n_fx_id);
        }

        level.var_1c6b904f.var_be28f14c.var_e7018237 = undefined;
      }

      if(isarray(level.var_9c4a1006.var_be28f14c.var_e7018237)) {
        foreach(n_fx_id in level.var_9c4a1006.var_be28f14c.var_e7018237) {
          killfx(localclientnum, n_fx_id);
        }

        level.var_9c4a1006.var_be28f14c.var_e7018237 = undefined;
      }

      if(isDefined(level.var_1c6b904f.var_be28f14c)) {
        level.var_1c6b904f.var_be28f14c delete();
      }

      if(isDefined(level.var_9c4a1006.var_be28f14c)) {
        level.var_9c4a1006.var_be28f14c delete();
      }
    }

    return;
  }

  if(getdvarint(#"hash_7f0099222a51b5f6", 7) == 4) {
    if(sessionmodeiszombiesgame()) {
      if(isDefined(level.var_1c6b904f) && !isDefined(level.var_1c6b904f.var_be28f14c)) {
        level.var_1c6b904f.var_be28f14c = util::spawn_model(localclientnum, #"hash_17d6e4b5165b1ee1", level.var_1c6b904f.origin, level.var_1c6b904f.angles);
        level.var_1c6b904f.var_be28f14c linkto(level.var_1c6b904f, "tag_origin");
        level.var_1c6b904f.var_be28f14c.var_e7018237 = playtagfxset(localclientnum, #"hash_4c8789e988ec6a4a", level.var_1c6b904f.var_be28f14c);
      }

      if(isDefined(level.var_9c4a1006) && !isDefined(level.var_9c4a1006.var_be28f14c)) {
        level.var_9c4a1006.var_be28f14c = util::spawn_model(localclientnum, #"hash_3c6252fbb52536d5", level.var_9c4a1006.origin, level.var_9c4a1006.angles);
        level.var_9c4a1006.var_be28f14c linkto(level.var_9c4a1006, "tag_origin");
        level.var_9c4a1006.var_be28f14c.var_e7018237 = playtagfxset(localclientnum, #"hash_6382ce6cbe4196b6", level.var_9c4a1006.var_be28f14c);
      }
    } else {
      if(isarray(level.var_1c6b904f.var_be28f14c.var_e7018237)) {
        foreach(n_fx_id in level.var_1c6b904f.var_be28f14c.var_e7018237) {
          killfx(localclientnum, n_fx_id);
        }

        level.var_1c6b904f.var_be28f14c.var_e7018237 = undefined;
      }

      if(isarray(level.var_9c4a1006.var_be28f14c.var_e7018237)) {
        foreach(n_fx_id in level.var_9c4a1006.var_be28f14c.var_e7018237) {
          killfx(localclientnum, n_fx_id);
        }

        level.var_9c4a1006.var_be28f14c.var_e7018237 = undefined;
      }

      if(isDefined(level.var_1c6b904f.var_be28f14c)) {
        level.var_1c6b904f.var_be28f14c delete();
      }

      if(isDefined(level.var_9c4a1006.var_be28f14c)) {
        level.var_9c4a1006.var_be28f14c delete();
      }
    }

    return;
  }

  if(getdvarint(#"hash_7f0099222a51b5f6", 7) == 3) {
    if(sessionmodeiszombiesgame()) {
      if(isDefined(level.var_1c6b904f) && !isDefined(level.var_1c6b904f.var_be28f14c)) {
        level.var_1c6b904f.var_be28f14c = util::spawn_model(localclientnum, #"hash_2a3afeedbb52bdf", level.var_1c6b904f.origin, level.var_1c6b904f.angles);
        level.var_1c6b904f.var_be28f14c linkto(level.var_1c6b904f, "tag_origin");
      }

      if(isDefined(level.var_9c4a1006) && !isDefined(level.var_9c4a1006.var_be28f14c)) {
        level.var_9c4a1006.var_be28f14c = util::spawn_model(localclientnum, #"hash_2a3afeedbb52bdf", level.var_9c4a1006.origin, level.var_9c4a1006.angles);
        level.var_9c4a1006.var_be28f14c linkto(level.var_9c4a1006, "tag_origin");
      }

      return;
    }

    if(isDefined(level.var_1c6b904f.var_be28f14c)) {
      level.var_1c6b904f.var_be28f14c delete();
    }

    if(isDefined(level.var_9c4a1006.var_be28f14c)) {
      level.var_9c4a1006.var_be28f14c delete();
    }
  }
}

function function_ee181cbd() {
  self notify("<dev string:x38>");
  self endon("<dev string:x38>");
  self endon(#"death");

  while(true) {
    if(getdvarint(#"scr_show_shot_info_for_igcs", 0)) {
      circle(self.origin, 10, (1, 0, 0));
    }

    waitframe(1);
  }
}

function blackscreen_watcher() {
  blackscreenuimodel = getuimodel(function_5f72e972(#"director_global"), "hideWorldForStreamer");
  setuimodelvalue(blackscreenuimodel, 1);

  while(true) {
    waitresult = level waittill(#"streamer_change");
    var_d0b01271 = waitresult.var_d0b01271;
    setuimodelvalue(blackscreenuimodel, 1);
    wait 0.1;

    while(true) {
      charready = 1;

      if(isDefined(var_d0b01271)) {
        charready = [[var_d0b01271]] - > is_streamed();
      }

      sceneready = getstreamerrequestprogress(0) >= 100;

      if(charready && sceneready) {
        break;
      }

      wait 0.1;
    }

    setuimodelvalue(blackscreenuimodel, 0);
  }
}

function streamer_change(hint, var_d0b01271) {
  if(isDefined(hint)) {
    setstreamerrequest(0, hint);
  } else {
    clearstreamerrequest(0);
  }

  level notify(#"streamer_change", {
    #var_d0b01271: var_d0b01271
  });
}

function handle_inspect_player(localclientnum, menu_name) {
  level endon(#"disconnect");
  level endon(menu_name + "_closed");
  level thread scene::play(#"scene_frontend_t9_lobby_inspection_camera");
  force_update = 1;
  var_206eea38 = undefined;

  while(true) {
    waitresult = level waittill(#"inspect_player", #"lobby_change");
    var_206eea38 = isDefined(waitresult.xuid) ? waitresult.xuid : var_206eea38;

    if(isDefined(var_206eea38)) {
      level childthread update_inspection_character(localclientnum, var_206eea38, menu_name, force_update);
      force_update = 0;
    }

    waitframe(1);
  }
}

function function_4ff9b4cb(menu_name, localclientnum) {
  level scene::stop("scene_frontend_t9_lobby_inspection");
  level scene::stop("scene_frontend_t9_lobby_inspection_camera");
}

function update_inspection_character(localclientnum, var_41c3f35b, menu_name, force_update) {
  self notify("6ceba66ebb1d734b");
  self endon("6ceba66ebb1d734b");
  level scene::stop("scene_frontend_t9_lobby_inspection");
  var_d0b01271 = lui_camera::function_daadc836(menu_name, localclientnum);
  xuid = util::function_48e57e36(var_41c3f35b);
  var_23904c1d = getcharactercustomizationforxuid(localclientnum, xuid);

  for(showcase_weapon = function_8d53d5b6(localclientnum, undefined, xuid); !isDefined(var_23904c1d) || !isDefined(showcase_weapon); showcase_weapon = function_8d53d5b6(localclientnum, undefined, xuid)) {
    wait 1;
    var_23904c1d = getcharactercustomizationforxuid(localclientnum, xuid);
  }

  var_136f48d7 = [[var_d0b01271]] - > function_8567daf2();

  if(force_update || character_customization::function_aa5382ed([[var_d0b01271]] - > function_e599283f(), var_23904c1d) || function_6677a717(var_136f48d7, showcase_weapon)) {
    [[var_d0b01271]] - > function_15a8906a(var_23904c1d);
    [[var_d0b01271]] - > function_1ec9448d(0);
    [[var_d0b01271]] - > function_c4baf89b(showcase_weapon);
    [[var_d0b01271]] - > set_xuid(xuid);
    params = {
      #var_401d9a1: 1, #var_c76f3e47: 1, #scene: # "scene_frontend_t9_lobby_inspection", #var_a68ab9c2: "idle", #activeweapon: showcase_weapon.weapon, #var_b8f20727: showcase_weapon.renderoptionsweapon, #var_452aa9c0: showcase_weapon.var_fd90b0bb, #var_a34c858c: 1, #scene_target: level, #var_b1e821c5: {
        #blend: 0
      }
    };
    level notify(#"hash_cde1d5b24eb4e07");
    [[var_d0b01271]] - > update(params);
    function_424d091c(var_d0b01271);
    var_cd34be2e = {
      #str_scene: params.scene, #var_c76d5a0b: "turn_cw_intro", #var_e982dc6b: "turn_ccw_idle", #var_3480dd47: "turn_ccw_intro", #var_1aa99c8b: "turn_ccw_idle"};
    level thread character_customization::rotation_thread_spawner(localclientnum, var_d0b01271, ["end_character_rotating" + localclientnum, #"hash_cde1d5b24eb4e07"], var_cd34be2e);
  }
}

function entityspawned(localclientnum) {}

function function_90646a7f(localclientnum) {
  while(true) {
    ct_cmd = getdvarint(#"hash_52d9845c30e27ace", 0);

    if(ct_cmd == 0) {
      wait 0.25;
      continue;
    }

    roommodel = getuimodel(function_5f72e972(#"lobby_root"), "<dev string:x4b>");
    room = getuimodelvalue(roommodel);
    origin = getcamposbylocalclientnum(localclientnum);
    angles = getcamanglesbylocalclientnum(localclientnum);
    sendmenuresponse(localclientnum, #"spawn_noclip", int(origin[0]) + "<dev string:x53>" + int(origin[1]) + "<dev string:x53>" + int(origin[2]) + "<dev string:x53>" + int(angles[0]) + "<dev string:x53>" + int(angles[1]) + "<dev string:x53>" + int(angles[2]), 1);
    setDvar(#"hash_52d9845c30e27ace", 0);
  }
}

function function_da10fc8f(localclientnum, imagepath) {
  var_38b900c2 = getent(localclientnum, "<dev string:x58>", "<dev string:x70>");
  var_51a0f339 = getent(localclientnum, "<dev string:x7e>", "<dev string:x70>");
  var_38b900c2 show();
  var_51a0f339 hide();
  function_45180840(localclientnum);

  do {
    waitframe(1);
  }
  while(function_6911e8d(localclientnum));

  var_38b900c2 hide();
  var_51a0f339 show();
  waitframe(1);
  function_c6df7fed(localclientnum);

  do {
    waitframe(1);
  }
  while(function_6911e8d(localclientnum));

  function_84469b54(imagepath);
  var_38b900c2 show();
  var_51a0f339 hide();
  waitframe(1);
}

function function_5d6480a0(localclientnum, weapon, weapon_model, weapon_name, var_2d8a24a3, var_f879230e) {
  if(ishash(var_2d8a24a3.name)) {
    camo_index = var_2d8a24a3.item_index == 0 ? 0 : function_8b51d9d1(var_2d8a24a3.name);
    var_9ce34e01 = function_9e72a96(var_2d8a24a3.name);
  } else {
    camo_index = var_2d8a24a3.item_index == 0 ? 0 : function_8b51d9d1(hash(var_2d8a24a3.name));
    var_9ce34e01 = var_2d8a24a3.name;
  }

  if(isDefined(camo_index)) {
    activecamoinfo = activecamo::function_13e12ab1(camo_index);

    if(isDefined(activecamoinfo) && activecamoinfo.stages.size > 1) {
      var_3594168e = activecamoinfo.stages[2];

      if(!is_true(var_3594168e.disabled)) {
        camo_index = function_8b51d9d1(var_3594168e.camooption);
        var_9ce34e01 = function_9e72a96(var_3594168e.camooption);
      } else {
        var_3594168e = undefined;
      }
    }

    if(isDefined(level.var_43aac701[localclientnum])) {
      weapon_model stoprenderoverridebundle(level.var_43aac701[localclientnum]);
      level.var_43aac701[localclientnum] = undefined;
    }

    render_options = function_6eff28b5(localclientnum, camo_index, 0, 0);
    weapon_model useweaponmodel(weapon, undefined, render_options, var_f879230e);

    if(isDefined(var_3594168e)) {
      activecamo::function_6c9e0e1a(localclientnum, weapon_model, var_3594168e, level.var_43aac701);
    }

    iteration = 0;
    max_iterations = getdvarint(#"hash_16a421138c7e03f8", -1);

    do {
      wait 0.5;
      iteration++;
    }
    while((!weapon_model isstreamed(8, 1) || !weapon_model function_e56f5549(1)) && (max_iterations == -1 || iteration < max_iterations));

    wait 0.1;
    function_da10fc8f(localclientnum, "<dev string:x96>" + weapon_name + "<dev string:xa9>" + weapon_name + "<dev string:xae>" + var_9ce34e01 + "<dev string:xb3>");
  }
}

function function_f2c538de(localclientnum, menu_name, state) {
  self notify("<dev string:xc0>");
  self endon("<dev string:xc0>");
  args = strtok(state, "<dev string:xd4>");
  weapon_name = args[0];
  camo = int(args[1]);
  var_c58c03de = int(args[2]);
  filter = args[3];
  type = args[4];
  function_25485718();
  var_38b900c2 = getent(menu_name, "<dev string:x58>", "<dev string:x70>");
  var_51a0f339 = getent(menu_name, "<dev string:x7e>", "<dev string:x70>");
  var_38b900c2 show();
  var_51a0f339 hide();
  weapon = getweapon(weapon_name);
  target = struct::get(#"weapon_icon_staging");
  weapon_model = spawn(menu_name, target.origin, "<dev string:xd9>");
  weapon_model.targetname = "<dev string:xe9>";
  weapon_model.angles = target.angles;
  weapon_model sethighdetail();
  weapon_model useweaponmodel(weapon);
  s_info = customclass::function_3bff05ba(weapon, #"primary");
  weapon_model setscale(s_info.scale);

  if(type === "<dev string:x100>") {
    shot = function_e2703c27(weapon);

    if(!scene::function_9730988a(#"scene_frontend_weapon_camo_render", shot)) {
      shot = undefined;
    }
  }

  if(!isDefined(shot)) {
    shot = "<dev string:x10f>";
  }

  level thread scene::play(#"scene_frontend_weapon_camo_render", shot);

  if(camo != -2) {
    options = function_ea647602("<dev string:x121>");

    if(camo == -1) {
      start_index = 0;
      end_index = options.size - 1;
    } else {
      start_index = camo;
      end_index = camo;
    }

    for(i = start_index; i <= end_index; i++) {
      var_2d8a24a3 = options[i];

      if(filter != "<dev string:x129>") {
        category = function_57411076(function_9e72a96(var_2d8a24a3.name));

        if(filter == "<dev string:x131>") {
          if(category != "<dev string:x140>" && category != "<dev string:x148>" && category != "<dev string:x150>") {
            continue;
          }
        } else if(category != filter) {
          continue;
        }
      }

      function_5d6480a0(menu_name, weapon, weapon_model, weapon_name, var_2d8a24a3, 0);
    }
  }

  if(var_c58c03de != -2) {
    if(var_c58c03de == -1) {
      start_index = 0;
      end_index = weapon.blueprintcount;
    } else {
      start_index = var_c58c03de;
      end_index = var_c58c03de + 1;
    }

    for(i = start_index; i < end_index; i++) {
      var_d68c33d0 = function_f62a996b(weapon_name, i + 1);
      function_5d6480a0(menu_name, var_d68c33d0.weapon, weapon_model, weapon_name, {
        #item_index: 0, #name: "<dev string:x158>" + i
      }, var_d68c33d0.var_fd90b0bb);
    }
  }

  level thread scene::stop(#"scene_frontend_weapon_camo_render");
  level notify("<dev string:x166>" + menu_name, {
    #menu: "<dev string:x175>", #status: "<dev string:x188>"});
  weapon_model delete();
  setDvar(#"weap_render", "<dev string:x192>");
  function_59013397();
}

function function_d583ca36(weapon) {
  return weapon.inventorytype == "<dev string:x196>";
}

function function_db3c4c69(localclientnum) {
  lui_camera::function_969a2881("<dev string:x175>", &function_f2c538de, 1, undefined, undefined, 0);
  target = struct::get(#"weapon_icon_staging");
  assert(isDefined(target));
  level.var_43aac701 = [];
  var_663588d = "<dev string:x1a1>";
  root_weapon = var_663588d + "<dev string:x1bc>";
  a_weapons = enumerateweapons("<dev string:x1d0>");

  if(!isDefined(a_weapons)) {
    a_weapons = [];
  }

  a_weapons = array::filter(a_weapons, 1, &function_d583ca36);

  foreach(weapon in a_weapons) {
    name = getweaponname(weapon);
    var_ee63b362 = root_weapon + "<dev string:xa9>" + name;
    adddebugcommand(localclientnum, "<dev string:x1da>" + var_ee63b362 + "<dev string:x1ea>" + "<dev string:x1f5>" + "<dev string:xd4>" + name + "<dev string:x209>");
  }

  setDvar(#"hash_1311d7636a782655", "<dev string:x192>");
  setDvar(#"weap_render", "<dev string:x192>");
  var_c11ba901 = ["<dev string:x131>", "<dev string:x140>", "<dev string:x148>", "<dev string:x150>", "<dev string:x20f>", "<dev string:x219>", "<dev string:x225>"];
  var_ae05dc1b = ["<dev string:x22e>", "<dev string:x100>"];
  weapon_name = "<dev string:x192>";
  var_f7a528f2 = "<dev string:x192>";

  while(true) {
    wait 0.1;

    if(getdvarstring(#"hash_1311d7636a782655", weapon_name) != weapon_name) {
      weapon_name = getdvarstring(#"hash_1311d7636a782655");

      if(weapon_name != "<dev string:x192>") {
        foreach(weapon in a_weapons) {
          name = getweaponname(weapon);

          if(name != weapon_name) {
            continue;
          }

          var_c001baa1 = var_663588d + "<dev string:xa9>" + name;
          adddebugcommand(localclientnum, "<dev string:x1da>" + var_c001baa1 + "<dev string:x239>" + "<dev string:x1ea>" + "<dev string:x243>" + "<dev string:xd4>" + name + "<dev string:xd4>" + -1 + "<dev string:xd4>" + -1 + "<dev string:xd4>" + "<dev string:x129>" + "<dev string:x209>");

          for(i = 0; i < var_c11ba901.size; i++) {
            type = var_c11ba901[i];
            adddebugcommand(localclientnum, "<dev string:x1da>" + var_c001baa1 + "<dev string:xa9>" + type + "<dev string:x252>" + 2 + i + "<dev string:x1ea>" + "<dev string:x243>" + "<dev string:xd4>" + name + "<dev string:xd4>" + -1 + "<dev string:xd4>" + -1 + "<dev string:xd4>" + type + "<dev string:x209>");
          }

          options = function_ea647602("<dev string:x121>");

          foreach(i, option in options) {
            adddebugcommand(localclientnum, "<dev string:x1da>" + var_c001baa1 + "<dev string:xa9>" + function_9e72a96(option.name) + "<dev string:x1ea>" + "<dev string:x243>" + "<dev string:xd4>" + name + "<dev string:xd4>" + i + "<dev string:xd4>" + -2 + "<dev string:xd4>" + "<dev string:x129>" + "<dev string:x209>");
          }

          for(i = 0; i < weapon.blueprintcount; i++) {
            foreach(_, type in var_ae05dc1b) {
              adddebugcommand(localclientnum, "<dev string:x1da>" + var_c001baa1 + "<dev string:x257>" + i + "<dev string:xa9>" + type + "<dev string:x1ea>" + "<dev string:x243>" + "<dev string:xd4>" + name + "<dev string:xd4>" + -2 + "<dev string:xd4>" + i + "<dev string:xd4>" + "<dev string:x129>" + "<dev string:xd4>" + type + "<dev string:x209>");
            }
          }

          foreach(type in var_ae05dc1b) {
            adddebugcommand(localclientnum, "<dev string:x1da>" + var_c001baa1 + "<dev string:x266>" + type + "<dev string:x1ea>" + "<dev string:x243>" + "<dev string:xd4>" + name + "<dev string:xd4>" + -2 + "<dev string:xd4>" + -1 + "<dev string:xd4>" + "<dev string:x129>" + "<dev string:xd4>" + type + "<dev string:x209>");
          }
        }
      }
    }

    if(getdvarstring(#"weap_render", var_f7a528f2) != var_f7a528f2) {
      var_f7a528f2 = getdvarstring(#"weap_render");

      if(var_f7a528f2 != "<dev string:x192>") {
        level notify("<dev string:x166>" + localclientnum, {
          #menu: "<dev string:x175>", #status: "<dev string:x27a>", #state: var_f7a528f2
        });
      }
    }
  }
}

function function_6677a717(a, b) {
  return a.weapon !== b.weapon || a.renderoptionsweapon !== b.renderoptionsweapon || a.var_fd90b0bb !== b.var_fd90b0bb;
}

function function_8d53d5b6(localclientnum, var_302876c9, xuid) {
  var_cd31cd6a = getdvarstring(#"hash_575aeb603638c901", "<dev string:x192>");

  if(var_cd31cd6a != "<dev string:x192>") {
    return {
      #weapon: getweapon(var_cd31cd6a)
    };
  }

  if(getdvarint(#"hash_181f432c0c22483d", 0)) {
    var_302876c9 = 0;
  }

  if(var_302876c9 === 0) {
    var_bba3d6af = function_a699aed5(localclientnum);
  } else {
    if(!isDefined(xuid)) {
      character = level.var_6f1da91a[function_f701ad2a()][var_302876c9].character;

      if(isDefined(character)) {
        xuid = [[character]] - > function_25725c05();
      }
    }

    if(isDefined(xuid)) {
      if(function_b24ced2b(xuid)) {
        var_bba3d6af = function_a699aed5(localclientnum);
      } else {
        var_bba3d6af = function_a1c1426a(localclientnum, xuid);
      }
    }
  }

  if(isDefined(var_bba3d6af.weapon) && var_bba3d6af.weapon !== level.weaponnone) {
    return var_bba3d6af;
  }

  return {
    #weapon: getweapon(#"ar_accurate_t9")
  };
}

function function_8567daf2(localclientnum, var_302876c9, xuid) {
  weapon_data = function_8d53d5b6(localclientnum, var_302876c9, xuid);
  return weapon_data.weapon;
}

function function_1fa47915(localclientnum, var_302876c9, xuid) {
  weapon_data = function_8d53d5b6(localclientnum, var_302876c9, xuid);
  return weapon_data.renderoptionsweapon;
}

function function_41f5d26d(localclientnum, var_302876c9, xuid) {
  weapon_data = function_8d53d5b6(localclientnum, var_302876c9, xuid);
  return weapon_data.var_fd90b0bb;
}

function private function_7a14ff49(localclientnum, var_302876c9) {
  if(!isDefined(var_302876c9) || var_302876c9 == 0) {
    if(lui_camera::is_current_menu(localclientnum, "LobbyInspection")) {
      return lui_camera::function_daadc836("LobbyInspection", localclientnum);
    }

    return level.var_1c43dd3e;
  }

  return level.var_6f1da91a[function_f701ad2a()][var_302876c9].character;
}

function function_d47a6728(localclientnum, var_302876c9) {
  character = function_7a14ff49(localclientnum, var_302876c9);

  if(!isDefined(character) || !isclass(character)) {
    return (randomint(2) < 0 ? "male" : "female");
  }

  n_character_index = [[character]] - > get_character_index();
  var_3b97696d = getherogender(n_character_index, 1);
  return var_3b97696d;
}

function function_c91a9fae(localclientnum, var_302876c9) {
  return function_7a14ff49(localclientnum, var_302876c9);
}

function function_65d7f2a7(localclientnum) {
  target_name = "player_start";
  var_50896672 = getent(localclientnum, target_name, "targetname");

  if(!isDefined(var_50896672)) {
    var_50896672 = util::spawn_model(localclientnum, "tag_origin");
    var_50896672.targetname = target_name;
  }

  var_50896672 useanimtree("all_player");
  level.var_1c43dd3e = character_customization::function_dd295310(var_50896672, localclientnum, 0);
  function_aba0885b(localclientnum);
}

function localclientconnect(localclientnum) {
  println("<dev string:x284>" + localclientnum);
  setexposureinstantsnap(localclientnum, 1);
  var_acd4d941 = util::spawn_model(localclientnum, "tag_origin", (0, 0, 0), (0, 0, 0));
  var_acd4d941.targetname = "__masked_char";
  var_22f20461 = character_customization::function_dd295310(var_acd4d941, localclientnum, 0);
  [[var_22f20461]] - > function_1ec9448d(1);
  [[var_22f20461]] - > update();
  function_65d7f2a7(localclientnum);
  level thread function_f00ff0c7(localclientnum);
  level thread function_45827126();

  if(isDefined(level.charactercustomizationsetup)) {
    [[level.charactercustomizationsetup]](localclientnum);
  }

  if(isDefined(level.weaponcustomizationiconsetup)) {
    [[level.weaponcustomizationiconsetup]](localclientnum);
  }

  callback::callback(#"on_localclient_connect", localclientnum);
  customclass::localclientconnect(localclientnum);
  roommodel = getuimodel(function_5f72e972(#"lobby_root"), "room");
  room = getuimodelvalue(roommodel);
  postfx::setfrontendstreamingoverlay(localclientnum, "frontend", 1);
  toggle_postfx(localclientnum, 1, #"pstfx_frontend");
  function_6eb0ef36(localclientnum);
  level.frontendclientconnected = 1;
  level notify("menu_change" + localclientnum, {
    #menu: "PressStart", #status: "opened", #state: room
  });

  level thread function_db3c4c69(localclientnum);
  level thread function_90646a7f(localclientnum);
}

function function_6eb0ef36(localclientnum) {
  if(getdvarint(#"hash_7f0099222a51b5f6", 7) == 7) {
    var_8d3beb7f = getent(localclientnum, "s6_lobby_geo_1", "targetname");
    model2 = getent(localclientnum, "s6_lobby_geo_2", "targetname");
    var_c0afd266 = getent(localclientnum, "s5_lobby_geo_1", "targetname");
    var_664e1da4 = getent(localclientnum, "s5_lobby_geo_2", "targetname");
    var_52f5f6f0 = getent(localclientnum, "s4_lobby_geo_1", "targetname");
    var_79d8c4b9 = getent(localclientnum, "s4_lobby_geo_2", "targetname");
    var_686a21dc = getent(localclientnum, "s3_lobby_geo_1", "targetname");
    var_d218f564 = getent(localclientnum, "s3_lobby_geo_2", "targetname");

    if(isDefined(var_8d3beb7f)) {
      var_8d3beb7f delete();
    }

    if(isDefined(model2)) {
      model2 delete();
    }

    if(isDefined(var_c0afd266)) {
      var_c0afd266 delete();
    }

    if(isDefined(var_664e1da4)) {
      var_664e1da4 delete();
    }

    if(isDefined(var_52f5f6f0)) {
      var_52f5f6f0 delete();
    }

    if(isDefined(var_79d8c4b9)) {
      var_79d8c4b9 delete();
    }

    if(isDefined(var_686a21dc)) {
      var_686a21dc delete();
    }

    if(isDefined(var_d218f564)) {
      var_d218f564 delete();
    }

    foreach(var_389010d4 in level.var_cf0ec8f9) {
      hidestaticmodel(var_389010d4);
    }

    return;
  }

  if(getdvarint(#"hash_7f0099222a51b5f6", 7) == 6) {
    var_8d3beb7f = getent(localclientnum, "s7_lobby_geo_1", "targetname");
    model2 = getent(localclientnum, "s7_lobby_geo_2", "targetname");
    var_c0afd266 = getent(localclientnum, "s5_lobby_geo_1", "targetname");
    var_664e1da4 = getent(localclientnum, "s5_lobby_geo_2", "targetname");
    var_52f5f6f0 = getent(localclientnum, "s4_lobby_geo_1", "targetname");
    var_79d8c4b9 = getent(localclientnum, "s4_lobby_geo_2", "targetname");
    var_686a21dc = getent(localclientnum, "s3_lobby_geo_1", "targetname");
    var_d218f564 = getent(localclientnum, "s3_lobby_geo_2", "targetname");

    if(isDefined(var_8d3beb7f)) {
      var_8d3beb7f delete();
    }

    if(isDefined(model2)) {
      model2 delete();
    }

    if(isDefined(var_c0afd266)) {
      var_c0afd266 delete();
    }

    if(isDefined(var_664e1da4)) {
      var_664e1da4 delete();
    }

    if(isDefined(var_52f5f6f0)) {
      var_52f5f6f0 delete();
    }

    if(isDefined(var_79d8c4b9)) {
      var_79d8c4b9 delete();
    }

    if(isDefined(var_686a21dc)) {
      var_686a21dc delete();
    }

    if(isDefined(var_d218f564)) {
      var_d218f564 delete();
    }

    foreach(var_389010d4 in level.var_cf0ec8f9) {
      hidestaticmodel(var_389010d4);
    }

    return;
  }

  if(getdvarint(#"hash_7f0099222a51b5f6", 7) == 5) {
    var_8d3beb7f = getent(localclientnum, "s7_lobby_geo_1", "targetname");
    model2 = getent(localclientnum, "s7_lobby_geo_2", "targetname");
    var_c0afd266 = getent(localclientnum, "s6_lobby_geo_1", "targetname");
    var_664e1da4 = getent(localclientnum, "s6_lobby_geo_2", "targetname");
    var_52f5f6f0 = getent(localclientnum, "s4_lobby_geo_1", "targetname");
    var_79d8c4b9 = getent(localclientnum, "s4_lobby_geo_2", "targetname");
    var_686a21dc = getent(localclientnum, "s3_lobby_geo_1", "targetname");
    var_d218f564 = getent(localclientnum, "s3_lobby_geo_2", "targetname");

    if(isDefined(var_8d3beb7f)) {
      var_8d3beb7f delete();
    }

    if(isDefined(model2)) {
      model2 delete();
    }

    if(isDefined(var_c0afd266)) {
      var_c0afd266 delete();
    }

    if(isDefined(var_664e1da4)) {
      var_664e1da4 delete();
    }

    if(isDefined(var_52f5f6f0)) {
      var_52f5f6f0 delete();
    }

    if(isDefined(var_79d8c4b9)) {
      var_79d8c4b9 delete();
    }

    if(isDefined(var_686a21dc)) {
      var_686a21dc delete();
    }

    if(isDefined(var_d218f564)) {
      var_d218f564 delete();
    }

    foreach(var_389010d4 in level.var_cf0ec8f9) {
      hidestaticmodel(var_389010d4);
    }

    return;
  }

  if(getdvarint(#"hash_7f0099222a51b5f6", 7) == 4) {
    var_8d3beb7f = getent(localclientnum, "s7_lobby_geo_1", "targetname");
    model2 = getent(localclientnum, "s7_lobby_geo_2", "targetname");
    var_c0afd266 = getent(localclientnum, "s6_lobby_geo_1", "targetname");
    var_664e1da4 = getent(localclientnum, "s6_lobby_geo_2", "targetname");
    var_52f5f6f0 = getent(localclientnum, "s5_lobby_geo_1", "targetname");
    var_79d8c4b9 = getent(localclientnum, "s5_lobby_geo_2", "targetname");
    var_686a21dc = getent(localclientnum, "s3_lobby_geo_1", "targetname");
    var_d218f564 = getent(localclientnum, "s3_lobby_geo_2", "targetname");

    if(isDefined(var_8d3beb7f)) {
      var_8d3beb7f delete();
    }

    if(isDefined(model2)) {
      model2 delete();
    }

    if(isDefined(var_c0afd266)) {
      var_c0afd266 delete();
    }

    if(isDefined(var_664e1da4)) {
      var_664e1da4 delete();
    }

    if(isDefined(var_52f5f6f0)) {
      var_52f5f6f0 delete();
    }

    if(isDefined(var_79d8c4b9)) {
      var_79d8c4b9 delete();
    }

    if(isDefined(var_686a21dc)) {
      var_686a21dc delete();
    }

    if(isDefined(var_d218f564)) {
      var_d218f564 delete();
    }

    foreach(var_389010d4 in level.var_cf0ec8f9) {
      hidestaticmodel(var_389010d4);
    }

    return;
  }

  if(getdvarint(#"hash_7f0099222a51b5f6", 7) == 3) {
    var_8d3beb7f = getent(localclientnum, "s7_lobby_geo_1", "targetname");
    model2 = getent(localclientnum, "s7_lobby_geo_2", "targetname");
    var_c0afd266 = getent(localclientnum, "s6_lobby_geo_1", "targetname");
    var_664e1da4 = getent(localclientnum, "s6_lobby_geo_2", "targetname");
    var_52f5f6f0 = getent(localclientnum, "s5_lobby_geo_1", "targetname");
    var_79d8c4b9 = getent(localclientnum, "s5_lobby_geo_2", "targetname");
    var_686a21dc = getent(localclientnum, "s4_lobby_geo_1", "targetname");
    var_d218f564 = getent(localclientnum, "s4_lobby_geo_2", "targetname");

    if(isDefined(var_8d3beb7f)) {
      var_8d3beb7f delete();
    }

    if(isDefined(model2)) {
      model2 delete();
    }

    if(isDefined(var_c0afd266)) {
      var_c0afd266 delete();
    }

    if(isDefined(var_664e1da4)) {
      var_664e1da4 delete();
    }

    if(isDefined(var_52f5f6f0)) {
      var_52f5f6f0 delete();
    }

    if(isDefined(var_79d8c4b9)) {
      var_79d8c4b9 delete();
    }

    if(isDefined(var_686a21dc)) {
      var_686a21dc delete();
    }

    if(isDefined(var_d218f564)) {
      var_d218f564 delete();
    }

    foreach(var_389010d4 in level.var_cf0ec8f9) {
      unhidestaticmodel(var_389010d4);
    }

    return;
  }

  var_8d3beb7f = getent(localclientnum, "s7_lobby_geo_1", "targetname");
  model2 = getent(localclientnum, "s7_lobby_geo_2", "targetname");
  var_c0afd266 = getent(localclientnum, "s6_lobby_geo_1", "targetname");
  var_664e1da4 = getent(localclientnum, "s6_lobby_geo_2", "targetname");
  var_52f5f6f0 = getent(localclientnum, "s5_lobby_geo_1", "targetname");
  var_79d8c4b9 = getent(localclientnum, "s5_lobby_geo_2", "targetname");
  var_686a21dc = getent(localclientnum, "s3_lobby_geo_1", "targetname");
  var_d218f564 = getent(localclientnum, "s3_lobby_geo_2", "targetname");
  var_bf6a5007 = getent(localclientnum, "s4_lobby_geo_1", "targetname");
  var_178e55af = getent(localclientnum, "s4_lobby_geo_2", "targetname");

  if(isDefined(var_8d3beb7f)) {
    var_8d3beb7f delete();
  }

  if(isDefined(model2)) {
    model2 delete();
  }

  if(isDefined(var_c0afd266)) {
    var_c0afd266 delete();
  }

  if(isDefined(var_664e1da4)) {
    var_664e1da4 delete();
  }

  if(isDefined(var_52f5f6f0)) {
    var_52f5f6f0 delete();
  }

  if(isDefined(var_79d8c4b9)) {
    var_79d8c4b9 delete();
  }

  if(isDefined(var_686a21dc)) {
    var_686a21dc delete();
  }

  if(isDefined(var_d218f564)) {
    var_d218f564 delete();
  }

  if(isDefined(var_bf6a5007)) {
    var_bf6a5007 delete();
  }

  if(isDefined(var_178e55af)) {
    var_178e55af delete();
  }

  foreach(var_389010d4 in level.var_cf0ec8f9) {
    hidestaticmodel(var_389010d4);
  }
}

function onprecachegametype() {}

function onstartgametype() {}

function function_175db490(localclientnum, var_d0b01271, waitresult, params) {
  fields = [[var_d0b01271]] - > function_e8b0acef();

  if(isDefined(fields)) {
    params.var_401d9a1 = 1;
    params.var_c76f3e47 = 1;
    var_7d79c1a5 = [[var_d0b01271]] - > function_782bdd96();

    if(isDefined(var_7d79c1a5)) {
      params.scene = var_7d79c1a5;
    } else {
      params.scene = function_2ca65924(var_d0b01271);
    }

    if(waitresult.event_name === "loadRandomCharacter") {
      [[var_d0b01271]] - > function_d72d0c2d(1);
      params.var_90d2372c = 1;
    } else {
      [[var_d0b01271]] - > function_d72d0c2d(0);
    }

    if(var_d0b01271 character_customization::function_f40eb809()) {
      function_286efebf(localclientnum, var_d0b01271, params);
    } else {
      var_814ef009 = [[var_d0b01271]] - > function_1f70adfe();

      if(isDefined(var_814ef009)) {
        params.var_a68ab9c2 = var_814ef009;

        if(var_814ef009 == "turn_cw_idle" || var_814ef009 == "turn_ccw_idle") {
          model = [[var_d0b01271]] - > function_217b10ed();
          params.scene_target = {
            #origin: model.origin, #angles: model.angles
          };
          params.var_b1e821c5 = {
            #blend: 0
          };
        }
      } else {
        params.var_a68ab9c2 = "change_skin_idle";
        params.scene_target = level;
      }
    }

    if(is_true(level.var_71922dc8)) {
      params.activeweapon = level.var_1b17418f;
      params.var_b8f20727 = level.var_6cbc1adc;
      params.var_452aa9c0 = level.var_52dc8db9;
    } else {
      params.activeweapon = function_8567daf2(localclientnum, undefined, [[var_d0b01271]] - > function_25725c05());
      params.var_b8f20727 = function_1fa47915(localclientnum, undefined, [[var_d0b01271]] - > function_25725c05());
      params.var_452aa9c0 = function_41f5d26d(localclientnum, undefined, [[var_d0b01271]] - > function_25725c05());
    }

    params.var_a34c858c = 1;
    params.var_f5332569 = [[var_d0b01271]] - > function_98d70bef();
  }
}

function function_286efebf(localclientnum, var_d0b01271, params) {
  if(!isDefined(params.scene)) {
    params = spawnStruct();
    var_7d79c1a5 = [[var_d0b01271]] - > function_782bdd96();

    if(isDefined(var_7d79c1a5)) {
      params.scene = var_7d79c1a5;
    } else if(lui_camera::is_current_menu(localclientnum, "LobbyInspection")) {
      params.scene = # "scene_frontend_t9_lobby_inspection";
    } else {
      params.scene = function_2ca65924(var_d0b01271);
    }
  }

  model = [[var_d0b01271]] - > function_217b10ed();
  s_align = {
    #origin: isDefined(var_d0b01271.var_ae32b908) ? var_d0b01271.var_ae32b908 : model.origin, #angles: isDefined(var_d0b01271.var_aba63ea) ? var_d0b01271.var_aba63ea : model.angles
  };

  if(var_d0b01271._target_name === # "inspection_character") {
    var_dd5c339d = 0;
  } else {
    var_dd5c339d = 1;
  }

  params.var_401d9a1 = 1;
  params.var_c76f3e47 = var_dd5c339d;
  params.var_a34c858c = 1;
  params.scene_target = s_align;
  params.var_bfbc1f4f = 1;

  if(is_true(level.var_71922dc8)) {
    params.activeweapon = level.var_1b17418f;
    params.var_b8f20727 = level.var_6cbc1adc;
    params.var_452aa9c0 = level.var_52dc8db9;
  } else {
    params.activeweapon = function_8567daf2(localclientnum, undefined, [[var_d0b01271]] - > function_25725c05());
    params.var_b8f20727 = function_1fa47915(localclientnum, undefined, [[var_d0b01271]] - > function_25725c05());
    params.var_452aa9c0 = function_41f5d26d(localclientnum, undefined, [[var_d0b01271]] - > function_25725c05());
  }

  params.var_74741b75 = var_d0b01271.var_c492e538;

  if(params.var_74741b75 === "turn_cw_intro") {
    params.var_a68ab9c2 = "turn_cw_idle";
  } else {
    params.var_a68ab9c2 = "turn_ccw_idle";
  }

  if([[var_d0b01271]] - > function_6b9e9618()) {
    params.var_90d2372c = 1;
  }

  var_b1e821c5 = {
    #blend: 0, #var_9e6d8a3d: 0.5
  };
  params.var_b1e821c5 = var_b1e821c5;
  return params;
}

function function_5eb72c78(localclientnum, menu_data, var_80c09ee8) {
  level endon(menu_data.menu_name + "_closed");

  if(var_80c09ee8.menu_name === # "personalizecharacter" || var_80c09ee8.menu_name === # "characterselection_operatorpreview") {
    var_b9c520c2 = 0;
  } else {
    var_b9c520c2 = 1;
  }

  level childthread function_c5aa56cd(localclientnum, var_b9c520c2);
}

function function_763f40c4(localclientnum, menu_name, state) {
  level endon(menu_name + "_closed");

  if(menu_name === # "operatormissionsoverview" || menu_name === # "characterselection_operatorpreview" || state === # "hash_be671ade60002b") {
    str_scene = # "scene_frontend_t9_operator_inspect";
    var_a68ab9c2 = "inspect_idle";
    toggle_postfx(localclientnum, 0, #"pstfx_frontend");
  } else {
    str_scene = function_2ca65924(level.var_1c43dd3e);
    var_a68ab9c2 = "change_skin_idle";
    toggle_postfx(localclientnum, 1, #"pstfx_frontend");
  }

  if(!isDefined(state) || state == # "hash_be671ade60002b") {
    params = {
      #scene: str_scene, #var_74741b75: undefined, #var_a68ab9c2: var_a68ab9c2, #var_a34c858c: 1, #activeweapon: function_8567daf2(localclientnum, undefined, [[level.var_1c43dd3e]] - > function_25725c05()), #var_b8f20727: function_1fa47915(localclientnum, undefined, [[level.var_1c43dd3e]] - > function_25725c05()), #var_452aa9c0: function_41f5d26d(localclientnum, undefined, [[level.var_1c43dd3e]] - > function_25725c05()), #var_dcfaf6c7: 0
    };
    [[level.var_1c43dd3e]] - > update(params);
    var_cd34be2e = {
      #str_scene: params.scene, #var_c76d5a0b: "turn_cw_intro", #var_e982dc6b: "turn_ccw_idle", #var_3480dd47: "turn_ccw_intro", #var_1aa99c8b: "turn_ccw_idle"};
    level thread character_customization::rotation_thread_spawner(localclientnum, level.var_1c43dd3e, ["end_character_rotating" + localclientnum, menu_name + "_closed"], var_cd34be2e);
    level childthread character_customization::updateeventthread(localclientnum, level.var_1c43dd3e, "updateSpecialistCustomization", &function_175db490);
  }
}

function function_424d091c(var_d0b01271) {
  do {
    waitframe(1);
  }
  while(![[var_d0b01271]] - > function_ea4ac9f8() || ![[var_d0b01271]] - > is_visible());

  wait 0.1;
}

function function_2ca65924(var_d0b01271) {
  return function_4b2dd0a6([[var_d0b01271]] - > get_character_mode(), [[var_d0b01271]] - > get_character_index());
}

function function_4b2dd0a6(mode, index) {
  fields = getcharacterfields(index, mode);

  if(isDefined(fields.var_bb70c379) && scene::function_9730988a(fields.var_bb70c379, "select_intro") && scene::function_9730988a(fields.var_bb70c379, "select_idle")) {
    var_dde940e7 = fields.var_bb70c379;
  } else {
    var_dde940e7 = # "scene_frontend_t9_character";
  }

  return var_dde940e7;
}

function function_84ba276(localclientnum, character_index, var_90d2372c, var_7114bc8c = 0) {
  self notify("416521263ed75f4c");
  self endon("416521263ed75f4c");
  level endon(#"hash_cf870c6cd8a0798");
  level flag::set("waiting_for_character_change");

  if(!var_7114bc8c) {
    wait getdvarfloat(#"hash_720d4385f4e050c2", 0.5);
  }

  level flag::clear("waiting_for_character_change");
  var_dd102759 = character_customization::function_7474681d(localclientnum, 1, character_index);

  if(isDefined(var_dd102759) || is_true(var_90d2372c)) {
    level thread function_90cad834(localclientnum, 0, var_dd102759, undefined, var_90d2372c);
  }
}

function function_c5aa56cd(localclientnum, var_b9c520c2 = 0) {
  self notify("5bdd3a0d4b30fb77");
  self endon("5bdd3a0d4b30fb77");
  toggle_postfx(localclientnum, 1, #"pstfx_frontend");

  if(!var_b9c520c2) {
    function_90cad834(localclientnum, 0, undefined, undefined, [[level.var_1c43dd3e]] - > function_1d4afc32());
  }

  for(var_7114bc8c = 1; true; var_7114bc8c = 0) {
    var_bec52aca = level waittill(#"hash_cf870c6cd8a0798");
    character_index = var_bec52aca.character_index;

    if(isDefined(var_bec52aca.var_90d2372c) && !var_bec52aca.var_90d2372c && [[level.var_1c43dd3e]] - > function_6b9e9618()) {
      [[level.var_1c43dd3e]] - > function_d72d0c2d(0);
      var_1dfa126c = 1;
    }

    if(isDefined(character_index)) {
      if(isDefined(level.var_1c43dd3e) && ([[level.var_1c43dd3e]] - > get_character_index() != character_index || var_bec52aca.var_90d2372c || is_true(var_1dfa126c))) {
        if(var_bec52aca.var_90d2372c && ![[level.var_1c43dd3e]] - > function_6b9e9618()) {
          [[level.var_1c43dd3e]] - > function_d72d0c2d(1);
        } else if(!var_bec52aca.var_90d2372c && [[level.var_1c43dd3e]] - > function_6b9e9618()) {
          [[level.var_1c43dd3e]] - > function_d72d0c2d(0);
        } else if(level flag::get("selected_operator")) {
          level flag::clear("selected_operator");
          continue;
        }

        level.var_45cf7171 = character_index;
        level thread function_84ba276(localclientnum, level.var_45cf7171, var_bec52aca.var_90d2372c, var_7114bc8c);
        var_7114bc8c = undefined;
      } else {
        level.var_45cf7171 = undefined;
      }

      continue;
    }

    level.var_45cf7171 = undefined;
  }
}

function function_b0442428(var_ce754e62, var_3f0e790b) {
  if(isDefined(var_ce754e62) && isDefined(var_ce754e62[var_3f0e790b])) {
    foreach(object in var_ce754e62[var_3f0e790b]) {
      var_2d0192e5 = [[object.character]] - > function_82e05d64();

      if(isDefined(var_2d0192e5) && isDefined(var_2d0192e5.entnummodel) && isDefined([[object.character]] - > function_217b10ed())) {
        setuimodelvalue(var_2d0192e5.entnummodel, [[object.character]] - > function_47cb6b19());
      }
    }
  }
}

function function_f5eca51d(var_ce754e62, var_3f0e790b) {
  if(isDefined(var_ce754e62) && isDefined(var_ce754e62[var_3f0e790b])) {
    foreach(object in var_ce754e62[var_3f0e790b]) {
      var_2d0192e5 = [[object.character]] - > function_82e05d64();

      if(isDefined(var_2d0192e5) && isDefined(var_2d0192e5.entnummodel)) {
        setuimodelvalue(var_2d0192e5.entnummodel, -1);
      }
    }
  }
}

function function_e1f85a64(ccobject, index, var_3f0e790b) {
  lobbyclientmodel = function_5f72e972(#"lobby_clients");
  var_c4caf9dd = getuimodel(lobbyclientmodel, string(index + 1));

  if(!isDefined(var_c4caf9dd)) {
    return;
  }

  [[ccobject]] - > function_82e05d64().entnummodel = createuimodel(var_c4caf9dd, "entNum");
  [[ccobject]] - > function_82e05d64().var_3f0e790b = var_3f0e790b;
  [[ccobject]] - > function_184a4d2e(&function_8be87802);
  entnum = getuimodelvalue([[ccobject]] - > function_82e05d64().entnummodel);

  if(!isDefined(entnum)) {
    setuimodelvalue([[ccobject]] - > function_82e05d64().entnummodel, [[ccobject]] - > function_47cb6b19());
  }

  [[ccobject]] - > function_82e05d64().visible_model = getuimodel(var_c4caf9dd, "visible");
  setuimodelvalue([[ccobject]] - > function_82e05d64().visible_model, [[ccobject]] - > function_ea4ac9f8() && [[ccobject]] - > is_visible());
  var_2097336a = createuimodel(var_c4caf9dd, "sprayGestureIndex");
  [[ccobject]] - > function_82e05d64().var_5da50127 = var_2097336a;
  setuimodelvalue(var_2097336a, isDefined(getuimodelvalue(var_2097336a)) ? getuimodelvalue(var_2097336a) : -1);
}

function function_f00765ad(localclientnum, xuid, ccobject, index, var_3f0e790b, var_2451e8ac) {
  ccobject notify("61c9dff756d06433");
  ccobject endon("61c9dff756d06433");
  level endon(#"lobby_change", #"disconnect");
  iterations = 0;
  var_a65df30 = [[ccobject]] - > function_e599283f();
  current_index = [[ccobject]] - > get_character_index();
  var_23904c1d = getcharactercustomizationforxuid(localclientnum, xuid);

  while(!isDefined(var_23904c1d) && iterations < 15) {
    wait 1;
    var_23904c1d = getcharactercustomizationforxuid(localclientnum, xuid);
    iterations++;
  }

  [[ccobject]] - > show_model();
  [[ccobject]] - > set_xuid(xuid);
  [[ccobject]] - > set_character_mode(1);
  var_136f48d7 = [[ccobject]] - > function_8567daf2();
  var_162c8192 = [[ccobject]] - > function_5ccc06e3();
  showcase_weapon = function_8d53d5b6(localclientnum, index, xuid);
  [[ccobject]] - > function_c4baf89b(showcase_weapon);
  var_9b54b3db = function_aa09bdbb(xuid);

  if(!isDefined(var_23904c1d) || var_23904c1d.charactermode != currentsessionmode() || !function_b9f8bbd9(var_23904c1d.charactertype, var_23904c1d.charactermode)) {
    var_23904c1d = undefined;
    character_index = function_e3efec59(localclientnum, xuid, 1, var_3f0e790b, undefined);

    if(isDefined(character_index)) {
      [[ccobject]] - > set_character_index(character_index);
    }
  }

  if(isDefined(var_23904c1d)) {
    if(is_true([[ccobject]] - > function_82e05d64().var_b5229bb9) || character_customization::function_aa5382ed(var_23904c1d, var_a65df30, 0) || function_6677a717(var_136f48d7, showcase_weapon) || var_162c8192 !== var_9b54b3db || function_b24ced2b(xuid)) {
      [[ccobject]] - > function_82e05d64().var_b5229bb9 = 0;
      function_c033e4cc(localclientnum, var_2451e8ac, ccobject, index, var_23904c1d, xuid);
    }
  } else {
    [[ccobject]] - > set_character_index(character_index);
    [[ccobject]] - > function_22039feb();
    function_c033e4cc(localclientnum, var_2451e8ac, ccobject, index, undefined, xuid);
  }

  function_e1f85a64(ccobject, index, var_3f0e790b);
}

function function_c033e4cc(localclientnum, var_2451e8ac, ccobject, index, var_7f395102, xuid) {
  if(isDefined(var_2451e8ac)) {
    switch (var_2451e8ac) {
      case # "character_change":
        if(lui_camera::is_current_menu(localclientnum, "PressStart")) {
          level thread function_90cad834(localclientnum, 0, var_7f395102);
        }

        break;
      case # "lobby_intro":
        if(isDefined(var_7f395102)) {
          [[ccobject]] - > function_15a8906a(var_7f395102);
        }

        level thread function_c47e078a(1, index, ccobject, localclientnum, xuid);
        break;
      case # "lobby_idle":
      default:
        if(isDefined(var_7f395102)) {
          [[ccobject]] - > function_15a8906a(var_7f395102);
        }

        level thread function_c47e078a(0, index, ccobject, localclientnum, xuid);
        break;
    }

    return;
  }

  params = {
    #var_c76f3e47: 1, #var_401d9a1: 1
  };
  [[ccobject]] - > update(params);
}

function function_7c77108d(localclientnum, &var_13ef9467, var_63aea26e) {
  for(i = 0; true; i++) {
    target = struct::get(var_63aea26e + i);

    if(!isDefined(target)) {
      break;
    }

    charactermodel = util::spawn_model(localclientnum, "tag_origin", target.origin, target.angles);
    charactermodel.targetname = var_63aea26e + "character_" + i;

    if(is_true(level.var_633071d0) && i == 0 && isclass(level.var_1c43dd3e)) {
      var_a4fe2697 = level.var_1c43dd3e;
    } else {
      var_a4fe2697 = character_customization::function_dd295310(charactermodel, localclientnum, 0);
    }

    var_ac2e02ac = {
      #target: target, #character: var_a4fe2697, #scene_name: undefined
    };

    if(!isDefined(var_13ef9467)) {
      var_13ef9467 = [];
    } else if(!isarray(var_13ef9467)) {
      var_13ef9467 = array(var_13ef9467);
    }

    var_13ef9467[var_13ef9467.size] = var_ac2e02ac;
  }

  return i;
}

function function_8be87802(localclientnum, character) {
  var_2d0192e5 = [[character]] - > function_82e05d64();

  if(!(isDefined(var_2d0192e5) && isDefined(var_2d0192e5.entnummodel))) {
    return;
  }

  var_c2ab6c5b = function_f701ad2a();

  if(var_2d0192e5.var_3f0e790b === var_c2ab6c5b) {
    setuimodelvalue(var_2d0192e5.entnummodel, [[character]] - > function_47cb6b19());
  }

  if(isDefined(var_2d0192e5.var_3f0e790b) && isDefined(var_c2ab6c5b) && var_2d0192e5.var_3f0e790b != var_c2ab6c5b) {
    character_customization::function_bee62aa1(character);
  }

  setuimodelvalue(var_2d0192e5.visible_model, [[character]] - > function_ea4ac9f8() && [[character]] - > is_visible());
}

function function_45827126() {
  level endon(#"disconnect");

  while(true) {
    waitresult = level waittill(#"hash_6f2435126950e914");

    if(waitresult.var_90d2372c && ![[level.var_1c43dd3e]] - > function_1d4afc32()) {
      [[level.var_1c43dd3e]] - > function_4a209fe9(1);
      var_5405cbdb = 1;
    } else if(!waitresult.var_90d2372c && [[level.var_1c43dd3e]] - > function_1d4afc32()) {
      [[level.var_1c43dd3e]] - > function_4a209fe9(0);
      var_5405cbdb = 1;
    }

    if(level.var_f7aea3ff != waitresult.characterindex || is_true(var_5405cbdb)) {
      var_5405cbdb = 0;
      level.var_f7aea3ff = waitresult.characterindex;

      if(!waitresult.var_90d2372c) {
        battlechatter::function_ad01601e(waitresult.localclientnum, waitresult.characterindex);
      }

      level thread flag::set_for_time(1, "selected_operator");
      level notify(#"hash_cf870c6cd8a0798");

      if(!waitresult.var_90d2372c) {
        var_4f8e8422 = character_customization::function_7474681d(waitresult.localclientnum, 1, waitresult.characterindex);
      }

      level thread function_90cad834(waitresult.localclientnum, 0, var_4f8e8422, 1, waitresult.var_90d2372c);
    }
  }
}

function function_5f165f36() {
  if(getdvarint(#"hash_7f0099222a51b5f6", 7) == 7) {
    var_7d79d4fb = (-39594, -2550, -1521);
  } else if(getdvarint(#"hash_7f0099222a51b5f6", 7) == 6) {
    var_7d79d4fb = (-29186, 9387, 778);
  } else if(getdvarint(#"hash_7f0099222a51b5f6", 7) == 5) {
    var_7d79d4fb = (-17183.9, 9522.44, -331.63);
  } else if(getdvarint(#"hash_7f0099222a51b5f6", 7) == 4) {
    var_7d79d4fb = (-13689, -4614, 37);
  } else if(getdvarint(#"hash_7f0099222a51b5f6", 7) == 3) {
    var_7d79d4fb = (-8269, -4678, 991);
  } else {
    var_7d79d4fb = (-98, -672, 797);
  }

  return var_7d79d4fb;
}

function function_f00ff0c7(localclientnum) {
  level endon(#"disconnect");
  var_11302f48 = function_5f72e972(#"hash_5573c0775fbf1bb1");
  level.var_6f1da91a = [[], [], [], []];
  var_6aeec2ad = getdvarstring(#"hash_52abdac1a234fa29", "");
  var_c7581878 = function_7c77108d(localclientnum, level.var_6f1da91a[0], "lobby_player" + var_6aeec2ad + "_");
  var_c7581878 = max(function_7c77108d(localclientnum, level.var_6f1da91a[1], "lobby_player" + var_6aeec2ad + "_"), var_c7581878);
  var_c7581878 = max(function_7c77108d(localclientnum, level.var_6f1da91a[2], "lobby_player" + var_6aeec2ad + "_"), var_c7581878);
  var_c7581878 = max(function_7c77108d(localclientnum, level.var_6f1da91a[3], "lobby_player" + var_6aeec2ad + "_"), var_c7581878);
  level.var_90fa1c3e = var_c7581878;
  var_68a9a63c = [];

  for(var_a23d0a8c = 1; true; var_a23d0a8c = 0) {
    var_6b002e4d = var_68a9a63c.size;
    waitresult = level waittill(#"lobby_change");
    function_63a85bfb(localclientnum);
    level thread function_d0597c2(localclientnum, var_a23d0a8c);
    var_7d79d4fb = (0, 0, 0);

    switch (currentsessionmode()) {
      case 2:
        var_7d79d4fb = (6234, 240, 814);
        break;
      case 0:
      case 1:
      default:
        var_7d79d4fb = function_5f165f36();
        break;
    }

    setDvar(#"hash_4a394f3fa0b6bca2", var_7d79d4fb);
    var_ca8c236b = undefined;

    if(level.lastlobbystate === # "matchmaking" || level.lastlobbystate === # "zm_online" || level.lastlobbystate === # "lobby_pose") {
      var_68a9a63c = function_77ccb73(1);
      var_5924f8b2 = function_664bca26(localclientnum, 1, 0);

      foreach(xuid in var_5924f8b2) {
        if(!array::contains(var_68a9a63c, xuid)) {
          array::add(var_68a9a63c, xuid);
        }
      }

      if(is_true(getgametypesetting(#"hash_5462586bdce0346e"))) {
        var_ca8c236b = min(getgametypesetting(#"hash_3a4691a853585241"), var_68a9a63c.size);
      }
    } else {
      var_68a9a63c = function_77ccb73(1);
    }

    var_3d095a85 = var_68a9a63c.size;

    if(is_true(waitresult.var_a3325423) || is_true(waitresult.var_2c5ad26b)) {
      for(i = 0; i < var_c7581878; i++) {
        if(isDefined(level.var_45cf7171) && i == 0) {
          continue;
        }

        if(i < (isDefined(var_ca8c236b) ? var_ca8c236b : var_68a9a63c.size)) {
          setuimodelvalue(getuimodel(var_11302f48, string(i)), var_68a9a63c[i]);

          foreach(var_3f0e790b, character_array in level.var_6f1da91a) {
            var_7d4d74d3 = i > character_array.size ? undefined : character_array[i];

            if(isDefined(var_7d4d74d3)) {
              if(level.lastlobbystate === # "mode_select" || level.lastlobbystate === # "directorselect" || level.lastlobbystate === # "room1" || level.lastlobbystate === # "room2") {
                continue;
              }

              if(i == 0 && (lui_camera::is_current_menu(localclientnum, "PressStart", #"loadout_room") || lui_camera::is_current_menu(localclientnum, "PressStart", #"armory") || lui_camera::is_current_menu(localclientnum, "PressStart", #"hash_3262189f972fcd0e") || lui_camera::is_current_menu(localclientnum, "OperatorMissionsOverview"))) {
                continue;
              }

              if(i == 0 && function_7dd48d78(localclientnum)) {
                var_2451e8ac = # "character_change";
              } else if(function_50806385(i) && is_true(waitresult.var_a3325423) && var_3d095a85 > var_6b002e4d && i >= var_6b002e4d) {
                var_2451e8ac = # "lobby_intro";
              } else if(function_50806385(i)) {
                var_2451e8ac = # "lobby_idle";
              } else {
                var_2451e8ac = # "lobby_idle";
              }

              var_7d4d74d3.target thread function_f00765ad(localclientnum, var_68a9a63c[i], var_7d4d74d3.character, i, var_3f0e790b, var_2451e8ac);
            }
          }

          continue;
        }

        foreach(var_3f0e790b, character_array in level.var_6f1da91a) {
          var_7d4d74d3 = i > character_array.size ? undefined : character_array[i];

          if(isclass(var_7d4d74d3.character) && isDefined([[var_7d4d74d3.character]] - > function_217b10ed())) {
            [[var_7d4d74d3.character]] - > hide_model();
          }
        }
      }

      forcenotifyuimodel(var_11302f48);
    }

    character_array = level.var_6f1da91a[function_f701ad2a()];

    if(isDefined(character_array)) {
      for(i = 0; i < var_c7581878; i++) {
        if(i < (isDefined(var_ca8c236b) ? var_ca8c236b : var_68a9a63c.size)) {
          var_7d4d74d3 = i > character_array.size ? undefined : character_array[i];

          if(isDefined(var_7d4d74d3) && (function_34fbc01b() || function_4fd0d58e())) {
            function_8be87802(localclientnum, var_7d4d74d3.character);
          }
        }
      }
    }
  }
}

function function_7dd48d78(localclientnum) {
  if(lui_camera::is_current_menu(localclientnum, #"personalizecharacter") || lui_camera::is_current_menu(localclientnum, #"characterselection_operatorpreview") || lui_camera::is_current_menu(localclientnum, #"characterselectionmenu") || lui_camera::is_current_menu(localclientnum, "PressStart", #"character_room") || lui_camera::is_current_menu(localclientnum, #"hash_6d7490313f58cc98") || lui_camera::is_current_menu(localclientnum, #"hash_362dbface51182d1")) {
    return true;
  }

  return false;
}

function function_50806385(n_index) {
  if((level.lastlobbystate === # "loadout_room" || level.lastlobbystate === # "character_room" || level.lastlobbystate === # "armory") && n_index != 0 || level.lastlobbystate === # "lobby_pose" || level.lastlobbystate === # "cdl_hub" || level.lastlobbystate === # "private_lobby_pose") {
    return true;
  }

  return false;
}

function function_34fbc01b() {
  if(level.lastlobbystate === # "lobby_pose" || level.lastlobbystate === # "private_lobby_pose" || level.lastlobbystate === # "character_room" || level.lastlobbystate === # "armory" || level.lastlobbystate === # "loadout_room") {
    return true;
  }

  return false;
}

function function_4fd0d58e() {
  if(level.lastlobbystate === # "cdl_hub" || level.lastlobbystate === # "character_room" || level.lastlobbystate === # "armory" || level.lastlobbystate === # "loadout_room") {
    return true;
  }

  return false;
}

function function_b1b8f767(localclientnum, play) {
  if(play) {
    function_b0442428(level.var_6f1da91a, 0);
    var_bf321a0c = !isDefined(level.lastlobbystate) || level.lastlobbystate == "room2" || level.lastlobbystate == "mode_select";
    var_f647c5b2 = var_bf321a0c ? "intro" : undefined;
    function_aba0885b(localclientnum);
    level notify(#"hash_46855140938f532c");

    if(!var_bf321a0c) {
      function_ade16f90(localclientnum);
    }

    function_645ebdaf();
    function_c47e078a(var_bf321a0c, 0, undefined, localclientnum);
    var_9032876b = function_7104551f(localclientnum);

    if(!(getdvarint(#"hash_7f0099222a51b5f6", 7) == 3) && !(getdvarint(#"hash_7f0099222a51b5f6", 7) == 4) && !(getdvarint(#"hash_7f0099222a51b5f6", 7) == 5) && !(getdvarint(#"hash_7f0099222a51b5f6", 7) == 6) && !(getdvarint(#"hash_7f0099222a51b5f6", 7) == 7) && var_9032876b == 1) {
      level thread function_c336d245(localclientnum);
    }

    return;
  }

  if(!play) {
    function_f5eca51d(level.var_6f1da91a, 0);
    [[level.var_1c43dd3e]] - > show_model();
  }
}

function function_ade16f90(localclientnum) {
  var_3d095a85 = function_7104551f(localclientnum);

  if(!(!(getdvarint(#"hash_7f0099222a51b5f6", 7) == 3) && !(getdvarint(#"hash_7f0099222a51b5f6", 7) == 4) && !(getdvarint(#"hash_7f0099222a51b5f6", 7) == 5) && !(getdvarint(#"hash_7f0099222a51b5f6", 7) == 6) && !(getdvarint(#"hash_7f0099222a51b5f6", 7) == 7))) {
    function_645ebdaf();
    return;
  }

  if(var_3d095a85 == 1) {
    level thread scene::play(#"scene_frontend_t9_lobby_player1_initial", "idle");
    return;
  }

  level thread scene::play(#"scene_frontend_t9_lobby_player1", "idle");
}

function function_7104551f(localclientnum) {
  var_68a9a63c = [];

  if(level.lastlobbystate === # "matchmaking" || level.lastlobbystate === # "zm_online" || level.lastlobbystate === # "lobby_pose") {
    var_68a9a63c = function_664bca26(localclientnum, 1, 0);
  } else {
    var_68a9a63c = function_77ccb73(1);
  }

  return var_68a9a63c.size;
}

function function_c336d245(localclientnum) {
  self notify("16be33477320f66e");
  self endon("16be33477320f66e");

  while(true) {
    s_waitresult = level waittill(#"lobby_change");
    var_9032876b = function_7104551f(localclientnum);

    if(is_true(s_waitresult.var_a3325423) && var_9032876b >= 2) {
      if(function_50806385(0)) {
        if(level scene::is_playing(#"scene_frontend_t9_lobby_player1_initial", "intro")) {
          level.var_1c43dd3e.var_72e4ebb3 = "scene_frontend_t9_lobby_player1";
          level.var_1c43dd3e.var_31ccd6da = "xanim_only_idle";
        }

        level scene::play(#"scene_frontend_t9_lobby_player1_initial", "xcam_only_intro");
      }

      if(function_50806385(0)) {
        level thread scene::play(#"scene_frontend_t9_lobby_player1_initial", "xcam_only_idle");
      }

      return;
    }
  }
}

function function_c47e078a(var_bf321a0c, var_302876c9 = 1, character, localclientnum, xuid) {
  level notify(#"hash_250179ae4bc30aef" + character);
  level endon(#"hash_250179ae4bc30aef" + character, #"hash_9a862f4c6d59905");
  var_dd5c339d = 1;

  if(!isDefined(localclientnum)) {
    if(character == 0) {
      localclientnum = level.var_1c43dd3e;
      var_16be1107 = function_2ca65924(localclientnum);
      level scene::cancel(#"scene_frontend_t9_character");
      level scene::cancel(var_16be1107);
      level scene::cancel(#"scene_frontend_t9_character_customization_camera");
      level scene::cancel(#"scene_frontend_t9_cac_overview");
      n_character_index = getequippedheroindex(xuid, 1);

      if(n_character_index != [[localclientnum]] - > get_character_index()) {
        var_7f395102 = character_customization::function_7474681d(xuid, 1, n_character_index);
        [[localclientnum]] - > function_15a8906a(var_7f395102);
      }
    } else {
      localclientnum = level.var_6f1da91a[function_f701ad2a()][character].character;
    }
  }

  if(lui_camera::is_current_menu(xuid, "PressStart")) {
    str_scene = function_cfb00e7d(character, xuid, localclientnum);

    if(!(!(getdvarint(#"hash_7f0099222a51b5f6", 7) == 3) && !(getdvarint(#"hash_7f0099222a51b5f6", 7) == 4) && !(getdvarint(#"hash_7f0099222a51b5f6", 7) == 5) && !(getdvarint(#"hash_7f0099222a51b5f6", 7) == 6) && !(getdvarint(#"hash_7f0099222a51b5f6", 7) == 7))) {
      if(sessionmodeiscampaigngame()) {
        return;
      }

      if(character == 0 && !isDefined([[localclientnum]] - > function_25725c05())) {
        [[localclientnum]] - > set_xuid(function_9bed6a71(xuid));
      }

      a_str_shots = scene::get_all_shot_names(str_scene);
      var_559c5c3e = array::random(a_str_shots);
      var_66125429 = 1;
    } else {
      a_str_shots = scene::get_all_shot_names(str_scene);
      var_78651d54 = [];
      var_fc395698 = [];

      foreach(str_shot in a_str_shots) {
        if(strstartswith(tolower(str_shot), "intro")) {
          if(!isDefined(var_78651d54)) {
            var_78651d54 = [];
          } else if(!isarray(var_78651d54)) {
            var_78651d54 = array(var_78651d54);
          }

          var_78651d54[var_78651d54.size] = str_shot;
        }

        if(strstartswith(tolower(str_shot), "idle")) {
          if(!isDefined(var_fc395698)) {
            var_fc395698 = [];
          } else if(!isarray(var_fc395698)) {
            var_fc395698 = array(var_fc395698);
          }

          var_fc395698[var_fc395698.size] = str_shot;
        }
      }

      if(var_302876c9) {
        var_f647c5b2 = array::random(var_78651d54);
        var_559c5c3e = strreplace(var_f647c5b2, "intro", "idle");
        assert(isinarray(var_fc395698, var_559c5c3e), "<dev string:x2b4>" + var_559c5c3e + "<dev string:x2dc>" + function_9e72a96(str_scene) + "<dev string:x2e4>" + var_f647c5b2);

        if(!isinarray(var_fc395698, var_559c5c3e)) {
          var_559c5c3e = array::random(var_fc395698);
        }

        if(character == 0) {
          var_dd5c339d = 0;
        }
      } else {
        var_559c5c3e = array::random(var_fc395698);
      }
    }

    if(!var_302876c9 && level scene::is_playing(str_scene, var_559c5c3e)) {
      var_b8f75d74 = [[localclientnum]] - > function_98d70bef();
    }
  } else {
    [[localclientnum]] - > function_82e05d64().var_b5229bb9 = 1;
  }

  weapon = [[localclientnum]] - > function_8567daf2().weapon;
  var_5b38793b = [[localclientnum]] - > function_8567daf2().renderoptionsweapon;
  var_f7332085 = [[localclientnum]] - > function_8567daf2().var_fd90b0bb;
  params = {
    #var_c76f3e47: var_dd5c339d, #var_401d9a1: 1, #scene: str_scene, #var_74741b75: var_f647c5b2, #var_a68ab9c2: var_559c5c3e, #var_a34c858c: 1, #var_f5332569: var_b8f75d74, #activeweapon: weapon, #var_b8f20727: var_5b38793b, #var_452aa9c0: var_f7332085, #var_66125429: var_66125429, #var_6fe1d7c5: 1
  };
  [[localclientnum]] - > update(params);
}

function function_133f8280(character, var_a0639b8c, n_position) {
  if(isDefined(character)) {
    if(var_a0639b8c === 3 && n_position === 1) {
      str_scene = [[character]] - > function_e8b0acef().var_5b3fce56;

      if(isDefined(str_scene)) {
        return str_scene;
      }
    }

    var_1a01e470 = [[character]] - > function_e8b0acef().var_a17efe7f;

    if(isarray(var_1a01e470) && var_1a01e470.size) {
      foreach(var_db400b6e in var_1a01e470) {
        if(var_db400b6e.var_8f572ed6 === var_a0639b8c && var_db400b6e.var_d603db03 === n_position && isDefined(var_db400b6e.var_bd2f2ca3)) {
          return var_db400b6e.var_bd2f2ca3;
        }
      }
    }
  }
}

function function_cfb00e7d(n_index, localclientnum, character) {
  assert(isDefined(n_index), "<dev string:x2f9>");

  if(getdvarint(#"hash_7f0099222a51b5f6", 7) == 7) {
    str_scene = function_133f8280(character, 7, n_index + 1);

    if(isDefined(str_scene)) {
      return str_scene;
    }

    switch (n_index) {
      case 0:
        str_scene = # "scene_frontend_t9_lobby_player1_s7";
        break;
      case 1:
        str_scene = # "scene_frontend_t9_lobby_player2_s7";
        break;
      case 2:
        str_scene = # "scene_frontend_t9_lobby_player3_s7";
        break;
      case 3:
        str_scene = # "scene_frontend_t9_lobby_player4_s7";
        break;
      case 4:
        str_scene = # "scene_frontend_t9_lobby_player5_s7";
        break;
      case 5:
        str_scene = # "scene_frontend_t9_lobby_player6_s7";
        break;
      default:
        assertmsg("<dev string:x317>" + n_index);
        break;
    }
  } else if(getdvarint(#"hash_7f0099222a51b5f6", 7) == 6) {
    str_scene = function_133f8280(character, 6, n_index + 1);

    if(isDefined(str_scene)) {
      return str_scene;
    }

    switch (n_index) {
      case 0:
        str_scene = # "scene_frontend_t9_lobby_player1_s6";
        break;
      case 1:
        str_scene = # "scene_frontend_t9_lobby_player2_s6";
        break;
      case 2:
        str_scene = # "scene_frontend_t9_lobby_player3_s6";
        break;
      case 3:
        str_scene = # "scene_frontend_t9_lobby_player4_s6";
        break;
      case 4:
        str_scene = # "scene_frontend_t9_lobby_player5_s6";
        break;
      case 5:
        str_scene = # "scene_frontend_t9_lobby_player6_s6";
        break;
      default:
        assertmsg("<dev string:x317>" + n_index);
        break;
    }
  } else if(getdvarint(#"hash_7f0099222a51b5f6", 7) == 5) {
    str_scene = function_133f8280(character, 5, n_index + 1);

    if(isDefined(str_scene)) {
      return str_scene;
    }

    switch (n_index) {
      case 0:
        str_scene = # "hash_70d524127d612757";
        break;
      case 1:
        str_scene = # "hash_4695940c1d7a1e80";
        break;
      case 2:
        str_scene = # "hash_6d2fe8047f841b3d";
        break;
      case 3:
        str_scene = # "hash_2434183c3811b8d6";
        break;
      case 4:
        str_scene = # "hash_7673a435d530eedb";
        break;
      case 5:
        str_scene = # "hash_1f53242a8a682d34";
        break;
      default:
        assertmsg("<dev string:x317>" + n_index);
        break;
    }
  } else if(getdvarint(#"hash_7f0099222a51b5f6", 7) == 4) {
    str_scene = function_133f8280(character, 4, n_index + 1);

    if(isDefined(str_scene)) {
      return str_scene;
    }

    switch (n_index) {
      case 0:
        str_scene = # "hash_70d523127d6125a4";
        break;
      case 1:
        str_scene = # "hash_4695950c1d7a2033";
        break;
      case 2:
        str_scene = # "hash_6d2fe7047f84198a";
        break;
      case 3:
        str_scene = # "hash_2434193c3811ba89";
        break;
      case 4:
        str_scene = # "hash_7673a335d530ed28";
        break;
      case 5:
        str_scene = # "hash_1f53252a8a682ee7";
        break;
      default:
        assertmsg("<dev string:x317>" + n_index);
        break;
    }
  } else if(getdvarint(#"hash_7f0099222a51b5f6", 7) == 3) {
    str_scene = function_133f8280(character, 3, n_index + 1);

    if(isDefined(str_scene)) {
      return str_scene;
    }

    switch (n_index) {
      case 0:
        str_scene = # "hash_70d522127d6123f1";
        break;
      case 1:
        str_scene = # "hash_46959a0c1d7a28b2";
        break;
      case 2:
        str_scene = # "hash_6d2fe2047f84110b";
        break;
      case 3:
        str_scene = # "hash_24341a3c3811bc3c";
        break;
      case 4:
        str_scene = # "hash_7673aa35d530f90d";
        break;
      case 5:
        str_scene = # "hash_1f53222a8a6829ce";
        break;
      default:
        assertmsg("<dev string:x317>" + n_index);
        break;
    }
  } else {
    var_3d095a85 = function_7104551f(localclientnum);

    switch (n_index) {
      case 0:
        if(var_3d095a85 == 1) {
          str_scene = # "scene_frontend_t9_lobby_player1_initial";
        } else {
          str_scene = # "scene_frontend_t9_lobby_player1";
        }

        break;
      case 1:
        str_scene = # "scene_frontend_t9_lobby_player5";
        break;
      case 2:
        str_scene = # "scene_frontend_t9_lobby_player6";
        break;
      case 3:
        str_scene = # "scene_frontend_t9_lobby_player3";
        break;
      case 4:
        str_scene = # "scene_frontend_t9_lobby_player2";
        break;
      case 5:
        str_scene = # "scene_frontend_t9_lobby_player4";
        break;
      default:
        assertmsg("<dev string:x317>" + n_index);
        break;
    }
  }

  return str_scene;
}

function toggle_postfx(localclientnum, on_off, postfx) {
  player = function_5c10bd79(localclientnum);

  if(on_off && !player postfx::function_556665f2(postfx)) {
    player codeplaypostfxbundle(postfx);
    return;
  }

  if(!on_off && player postfx::function_556665f2(postfx)) {
    player codestoppostfxbundle(postfx);
  }
}

function lobby_main(localclientnum, menu_name, state) {
  level endon(menu_name + "_closed");
  level thread function_49efdec6(localclientnum, menu_name, state);

  if(state == # "room1" || state == # "room2") {
    level function_4431001a(localclientnum, "start", menu_name);
  } else if(state == # "mode_select" || state == # "directorselect") {
    level function_4431001a(localclientnum, "main", menu_name);
  } else {
    level function_4431001a(localclientnum);
  }

  if(state == # "matchmaking" && level.lastlobbystate !== # "matchmaking") {
    level notify(#"lobby_change", {
      #var_a3325423: 1
    });
  } else if(state == # "lobby_pose" || state == # "private_lobby_pose" || state == # "cdl_hub") {
    if(!sessionmodeiscampaigngame()) {
      level notify(#"lobby_change", {
        #var_a3325423: 1
      });
      function_b1b8f767(localclientnum, 1);

      if(getdvarint(#"hash_499e959d9b7fbd41", 0) || getdvarint(#"hash_735ace6b22542a65", 0)) {
        function_422ea367(localclientnum);
      }
    } else {
      level notify(#"lobby_change");
    }
  } else if(state == # "character_room") {
    function_f02beec9(localclientnum);
    level childthread function_c5aa56cd(localclientnum);
  } else if(state == # "inspect_specialist" && level.lastlobbystate !== # "inspect_specialist") {
    waitframe(1);
    var_aa16ae79 = getuimodel(function_1df4c3b0(localclientnum, #"hash_3e045efc97005502"), "ChosenSpecialistID");

    for(character_index = getuimodelvalue(var_aa16ae79); !isDefined(character_index) || character_index == 0; character_index = getuimodelvalue(var_aa16ae79)) {
      wait 0.1;
    }

    level notify("menu_change" + localclientnum, {
      #menu: "directorTraining", #status: "opened", #state: character_index, #mode: 1
    });
  } else if(state == # "cp_story") {
    level notify(#"hash_6b50f726c9f6f9f");

    if(isDefined(level.var_1c43dd3e)) {
      [[level.var_1c43dd3e]] - > function_39a68bf2();
    }
  } else {
    function_f02beec9(localclientnum);
  }

  if(!isDefined(state) || state != # "room1") {
    setallcontrollerslightbarcolor();
    level notify(#"end_controller_pulse");
  }

  level.lastlobbystate = state;
  level thread function_97b4eb2c(localclientnum, menu_name, state);
}

function function_645ebdaf() {
  if(getdvarint(#"hash_7f0099222a51b5f6", 7) == 7) {
    str_scene = # "scene_frontend_t9_lobby_player1_s7_geo_camera";
  } else if(getdvarint(#"hash_7f0099222a51b5f6", 7) == 6) {
    str_scene = # "scene_frontend_t9_lobby_player1_s6_geo_camera";
  } else if(getdvarint(#"hash_7f0099222a51b5f6", 7) == 5) {
    str_scene = # "hash_6d750c42af02bd6d";
  } else if(getdvarint(#"hash_7f0099222a51b5f6", 7) == 4) {
    str_scene = # "hash_190740d0e91e0fe4";
  } else if(getdvarint(#"hash_7f0099222a51b5f6", 7) == 3) {
    str_scene = # "hash_9038a1b76b82cfb";
  }

  if(isDefined(str_scene)) {
    if(!scene::is_playing(str_scene)) {
      n_start_time = randomfloatrange(0, 1);
      level thread scene::play_from_time(str_scene, undefined, undefined, n_start_time);
    }
  }
}

function function_f02beec9(localclientnum = 0) {
  if(getdvarint(#"hash_7f0099222a51b5f6", 7) == 7) {
    str_scene = # "scene_frontend_t9_lobby_player1_s7_geo_camera";
  } else if(getdvarint(#"hash_7f0099222a51b5f6", 7) == 6) {
    str_scene = # "scene_frontend_t9_lobby_player1_s6_geo_camera";
  } else if(getdvarint(#"hash_7f0099222a51b5f6", 7) == 5) {
    str_scene = # "hash_6d750c42af02bd6d";
  } else if(getdvarint(#"hash_7f0099222a51b5f6", 7) == 4) {
    str_scene = # "hash_190740d0e91e0fe4";
    toggle_postfx(localclientnum, 0, #"hash_4aafa47313fe4242");
  } else if(getdvarint(#"hash_7f0099222a51b5f6", 7) == 3) {
    str_scene = # "hash_9038a1b76b82cfb";
    toggle_postfx(localclientnum, 0, #"hash_4739926f2710962b");
  }

  if(isDefined(str_scene)) {
    level scene::cancel(str_scene, undefined, undefined, 1);
  }

  function_aba20851(0);
}

function function_f2fffb6f(local_client_num, var_a8080f41) {
  if(isDefined(level.var_1c43dd3e)) {
    [[level.var_1c43dd3e]] - > function_39a68bf2();
  }

  function_f02beec9(var_a8080f41);
}

function function_63a85bfb(localclientnum) {
  if(!isDefined(level.var_1938999e)) {
    level.var_1938999e = getEntArray(localclientnum, "script_models_zm_lobby", "targetname");
  }

  function_5e95a81(localclientnum);

  if(sessionmodeiszombiesgame() && level.var_1914c663 !== # "zm") {
    if(isarray(level.var_ec513608)) {
      foreach(var_d412c7fc in level.var_ec513608) {
        function_3ee9a9d8(var_d412c7fc);
      }
    }

    function_4b3b4c30(localclientnum);

    foreach(var_201e3ba3 in level.var_d508403d) {
      unhidevolumedecal(var_201e3ba3);
    }

    foreach(var_e9a37674 in level.var_8a620c67) {
      unhidestaticmodel(var_e9a37674);
    }

    foreach(var_9da4ca8e in level.var_1938999e) {
      var_9da4ca8e show();

      if(isDefined(var_9da4ca8e.renderoverridebundle) && !var_9da4ca8e function_d2503806(var_9da4ca8e.renderoverridebundle)) {
        var_9da4ca8e playrenderoverridebundle(var_9da4ca8e.renderoverridebundle);
      }
    }

    foreach(var_5661a499 in level.var_1a55d2dd) {
      hidevolumedecal(var_5661a499);
    }

    foreach(var_c00eda0d in level.var_fec4a8fd) {
      hidestaticmodel(var_c00eda0d);
    }

    level.var_1914c663 = # "zm";
    return;
  }

  if(!sessionmodeiszombiesgame() && level.var_1914c663 !== # "default") {
    if(isarray(level.var_ec513608)) {
      foreach(var_d412c7fc in level.var_ec513608) {
        function_3ee9a9d8(var_d412c7fc);
      }
    }

    function_4b3b4c30(localclientnum);

    foreach(var_201e3ba3 in level.var_d508403d) {
      hidevolumedecal(var_201e3ba3);
    }

    foreach(var_e9a37674 in level.var_8a620c67) {
      hidestaticmodel(var_e9a37674);
    }

    foreach(var_9da4ca8e in level.var_1938999e) {
      if(isDefined(var_9da4ca8e.renderoverridebundle) && var_9da4ca8e function_d2503806(var_9da4ca8e.renderoverridebundle)) {
        var_9da4ca8e stoprenderoverridebundle(var_9da4ca8e.renderoverridebundle);
      }

      var_9da4ca8e hide();
    }

    foreach(var_5661a499 in level.var_1a55d2dd) {
      unhidevolumedecal(var_5661a499);
    }

    foreach(var_c00eda0d in level.var_fec4a8fd) {
      unhidestaticmodel(var_c00eda0d);
    }

    level.var_1914c663 = # "default";
  }
}

function function_d0597c2(localclientnum, var_a23d0a8c = 0) {
  if(var_a23d0a8c) {
    waitframe(1);
  }

  if(sessionmodeiszombiesgame() && level.var_80333dbc !== # "zm") {
    function_7070281c(localclientnum, 1);
    exploder::exploder(#"hash_5368b6f5ddf6c271");
    function_422ea367(localclientnum);

    if(getdvarint(#"hash_7f0099222a51b5f6", 7) == 7) {
      exploder::exploder(#"hash_4ccbf2f18856f18c");
    }

    level.var_80333dbc = # "zm";
  } else if(!sessionmodeiszombiesgame() && level.var_80333dbc !== # "default") {
    function_7070281c(localclientnum, 0);
    exploder::stop_exploder(#"hash_5368b6f5ddf6c271");
    function_422ea367(localclientnum);

    if(getdvarint(#"hash_7f0099222a51b5f6", 7) == 7) {
      exploder::stop_exploder(#"hash_4ccbf2f18856f18c");
    }

    level.var_80333dbc = # "default";
  }

  if(getdvarint(#"hash_7f0099222a51b5f6", 7) == 6) {
    if((getdvarint(#"hash_499e959d9b7fbd41", 0) || getdvarint(#"hash_735ace6b22542a65", 0)) && (sessionmodeismultiplayergame() || sessionmodeiswarzonegame())) {
      util::function_8d617b62(undefined, 7.3);
      return;
    }

    util::function_5ff170ee();
  }
}

function function_422ea367(localclientnum) {
  if(getdvarint(#"hash_7f0099222a51b5f6", 7) == 7) {
    if(sessionmodeiszombiesgame()) {
      var_2cab862a = # "hash_488635f2d10abd0c";
      var_73d99491 = # "hash_488638f2d10ac225";
    } else {
      var_2cab862a = # "hash_325a0acb91cb224d";
      var_73d99491 = # "hash_325a07cb91cb1d34";
    }

    if(!isDefined(level.var_1c6b904f)) {
      level.var_1c6b904f = getent(localclientnum, "s7_lobby_geo_1", "targetname");
    }

    if(!isDefined(level.var_9c4a1006)) {
      level.var_9c4a1006 = getent(localclientnum, "s7_lobby_geo_2", "targetname");
    }

    if(isDefined(level.var_1c6b904f)) {
      if(isDefined(level.var_1c6b904f.var_5c5f653d)) {
        killfx(localclientnum, level.var_1c6b904f.var_5c5f653d);
      }

      level.var_1c6b904f.var_5c5f653d = util::playFXOnTag(localclientnum, var_2cab862a, level.var_1c6b904f, "tag_origin");
    }

    if(isDefined(level.var_9c4a1006)) {
      if(isDefined(level.var_9c4a1006.var_5c5f653d)) {
        killfx(localclientnum, level.var_9c4a1006.var_5c5f653d);
      }

      level.var_9c4a1006.var_5c5f653d = util::playFXOnTag(localclientnum, var_73d99491, level.var_9c4a1006, "tag_origin");
    }

    return;
  }

  if(getdvarint(#"hash_7f0099222a51b5f6", 7) == 6) {
    if(sessionmodeiszombiesgame()) {
      var_2cab862a = # "hash_194e519463f43e2b";
      var_73d99491 = # "hash_194e529463f43fde";
    } else {
      var_2cab862a = # "hash_768ae6352b172f3e";
      var_73d99491 = # "hash_768ae5352b172d8b";
    }

    if(getdvarint(#"hash_499e959d9b7fbd41", 0) || getdvarint(#"hash_735ace6b22542a65", 0)) {
      var_dbc6cf46 = # "hash_66d32feda402ead6";
      var_228bdcd3 = # "hash_66d32eeda402e923";
      setpbgactivebank(localclientnum, 2);
      function_be93487f(localclientnum, 2, 0, 1, 0, 0);
      setexposureactivebank(localclientnum, 2);
    } else {
      setpbgactivebank(localclientnum, 1);
      function_be93487f(localclientnum, 1, 1, 0, 0, 0);
      setexposureactivebank(localclientnum, 1);
    }

    if(!isDefined(level.var_1c6b904f)) {
      level.var_1c6b904f = getent(localclientnum, "s6_lobby_geo_1", "targetname");
    }

    if(!isDefined(level.var_9c4a1006)) {
      level.var_9c4a1006 = getent(localclientnum, "s6_lobby_geo_2", "targetname");
    }

    if(isDefined(level.var_1c6b904f)) {
      if(isDefined(level.var_1c6b904f.var_5c5f653d)) {
        killfx(localclientnum, level.var_1c6b904f.var_5c5f653d);
      }

      level.var_1c6b904f.var_5c5f653d = util::playFXOnTag(localclientnum, var_2cab862a, level.var_1c6b904f, "tag_origin");

      if(isDefined(level.var_1c6b904f.var_99066f34)) {
        killfx(localclientnum, level.var_1c6b904f.var_99066f34);
      }

      if(isDefined(var_dbc6cf46)) {
        level.var_1c6b904f.var_99066f34 = util::playFXOnTag(localclientnum, var_dbc6cf46, level.var_1c6b904f, "tag_origin");
      }
    }

    if(isDefined(level.var_9c4a1006)) {
      if(isDefined(level.var_9c4a1006.var_5c5f653d)) {
        killfx(localclientnum, level.var_9c4a1006.var_5c5f653d);
      }

      level.var_9c4a1006.var_5c5f653d = util::playFXOnTag(localclientnum, var_73d99491, level.var_9c4a1006, "tag_origin");

      if(isDefined(level.var_9c4a1006.var_99066f34)) {
        killfx(localclientnum, level.var_9c4a1006.var_99066f34);
      }

      if(isDefined(var_228bdcd3)) {
        level.var_9c4a1006.var_99066f34 = util::playFXOnTag(localclientnum, var_228bdcd3, level.var_9c4a1006, "tag_origin");
      }
    }

    return;
  }

  if(getdvarint(#"hash_7f0099222a51b5f6", 7) == 5) {
    if(sessionmodeiszombiesgame()) {
      var_2cab862a = # "hash_62c4c7a96f0b37ee";
      var_73d99491 = # "hash_62c4c6a96f0b363b";
    } else {
      var_2cab862a = # "hash_5b2792e0ab43eb5b";
      var_73d99491 = # "hash_5b2793e0ab43ed0e";
    }

    if(!isDefined(level.var_1c6b904f)) {
      level.var_1c6b904f = getent(localclientnum, "s5_lobby_geo_1", "targetname");
    }

    if(!isDefined(level.var_9c4a1006)) {
      level.var_9c4a1006 = getent(localclientnum, "s5_lobby_geo_2", "targetname");
    }

    if(isDefined(level.var_1c6b904f)) {
      if(isDefined(level.var_1c6b904f.var_5c5f653d)) {
        killfx(localclientnum, level.var_1c6b904f.var_5c5f653d);
      }

      level.var_1c6b904f.var_5c5f653d = util::playFXOnTag(localclientnum, var_2cab862a, level.var_1c6b904f, "tag_origin");
    }

    if(isDefined(level.var_9c4a1006)) {
      if(isDefined(level.var_9c4a1006.var_5c5f653d)) {
        killfx(localclientnum, level.var_9c4a1006.var_5c5f653d);
      }

      level.var_9c4a1006.var_5c5f653d = util::playFXOnTag(localclientnum, var_73d99491, level.var_9c4a1006, "tag_origin");
    }

    return;
  }

  if(getdvarint(#"hash_7f0099222a51b5f6", 7) == 4) {
    if(sessionmodeiszombiesgame()) {
      var_2cab862a = # "hash_606ed5e362232c35";
      var_73d99491 = # "hash_606ed2e36223271c";
    }

    if(!isDefined(level.var_1c6b904f)) {
      level.var_1c6b904f = getent(localclientnum, "s4_lobby_geo_1", "targetname");
    }

    if(!isDefined(level.var_9c4a1006)) {
      level.var_9c4a1006 = getent(localclientnum, "s4_lobby_geo_2", "targetname");
    }

    if(isDefined(level.var_1c6b904f)) {
      if(isDefined(level.var_1c6b904f.var_5c5f653d)) {
        killfx(localclientnum, level.var_1c6b904f.var_5c5f653d);
      }

      if(isDefined(var_2cab862a)) {
        level.var_1c6b904f.var_5c5f653d = util::playFXOnTag(localclientnum, var_2cab862a, level.var_1c6b904f, "tag_origin");
      }
    }

    if(isDefined(level.var_9c4a1006)) {
      if(isDefined(level.var_9c4a1006.var_5c5f653d)) {
        killfx(localclientnum, level.var_9c4a1006.var_5c5f653d);
      }

      if(isDefined(var_73d99491)) {
        level.var_9c4a1006.var_5c5f653d = util::playFXOnTag(localclientnum, var_73d99491, level.var_9c4a1006, "tag_origin");
      }
    }

    return;
  }

  if(getdvarint(#"hash_7f0099222a51b5f6", 7) == 3) {
    if(sessionmodeiszombiesgame()) {
      var_2cab862a = # "hash_6d064c5cb19f70e8";
      var_73d99491 = # "hash_6d064f5cb19f7601";
    } else {
      var_2cab862a = # "hash_62d5cf5c2851dfb9";
      var_73d99491 = # "hash_62d5cc5c2851daa0";
    }

    if(!isDefined(level.var_1c6b904f)) {
      level.var_1c6b904f = getent(localclientnum, "s3_lobby_geo_1", "targetname");
    }

    if(!isDefined(level.var_9c4a1006)) {
      level.var_9c4a1006 = getent(localclientnum, "s3_lobby_geo_2", "targetname");
    }

    if(isDefined(level.var_1c6b904f)) {
      if(isDefined(level.var_1c6b904f.var_5c5f653d)) {
        killfx(localclientnum, level.var_1c6b904f.var_5c5f653d);
      }

      level.var_1c6b904f.var_5c5f653d = util::playFXOnTag(localclientnum, var_2cab862a, level.var_1c6b904f, "tag_origin");
    }

    if(isDefined(level.var_9c4a1006)) {
      if(isDefined(level.var_9c4a1006.var_5c5f653d)) {
        killfx(localclientnum, level.var_9c4a1006.var_5c5f653d);
      }

      level.var_9c4a1006.var_5c5f653d = util::playFXOnTag(localclientnum, var_73d99491, level.var_9c4a1006, "tag_origin");
    }
  }
}

function function_f701ad2a() {
  if(sessionmodeiswarzonegame()) {
    return 3;
  }

  if(sessionmodeiszombiesgame()) {
    return 2;
  }

  if(function_34fbc01b()) {
    return 0;
  } else if(function_4fd0d58e()) {
    return 1;
  }

  return -1;
}

function function_79ac87ac(clientnum) {
  var_f33f3800 = self function_a5248552();

  if(isarray(level.var_6f1da91a) && var_f33f3800.size > 0) {
    var_91389554 = function_f701ad2a();

    if(!isDefined(var_91389554) || var_91389554 < 0) {
      var_91389554 = 0;
    }

    var_b2694f96 = level.var_6f1da91a[var_91389554];

    if(isDefined(self._s.var_1b22ecf4)) {
      var_302876c9 = int(self._s.var_1b22ecf4);
      var_bf735535 = var_b2694f96[var_302876c9];

      if(isDefined(var_bf735535)) {
        self._e_array[clientnum] = [[var_bf735535.character]] - > function_217b10ed();
      }

      if(var_302876c9 != 0) {
        self.var_8bba7189 = 1;
      }

      return;
    }

    foreach(var_c1468bbf, s_obj in var_f33f3800) {
      var_bf735535 = var_b2694f96[var_c1468bbf];

      if(!isDefined(var_bf735535)) {
        continue;
      }

      if(self == s_obj) {
        self._e_array[clientnum] = [[var_bf735535.character]] - > function_217b10ed();

        if(var_c1468bbf != 0) {
          self.var_8bba7189 = 1;
        }

        break;
      }
    }
  }
}

function function_a5248552() {
  var_f33f3800 = [];

  foreach(s_obj in self._o_scene._a_objects) {
    if(s_obj._s.type === # "player") {
      if(!isDefined(var_f33f3800)) {
        var_f33f3800 = [];
      } else if(!isarray(var_f33f3800)) {
        var_f33f3800 = array(var_f33f3800);
      }

      var_f33f3800[var_f33f3800.size] = s_obj;
    }
  }

  return var_f33f3800;
}

function function_97b4eb2c(localclientnum, var_2a4208a4, str_state = # "lobby_pose") {
  self notify("6f60900b6a68c80c");
  self endon("6f60900b6a68c80c");
  level endon(#"disconnect");

  switch (str_state) {
    case # "mode_select":
    case # "directorselect":
      return;
    case # "private_lobby_pose":
    case # "cdl_hub":
    case # "lobby_pose":
    default:
      if(!(getdvarint(#"hash_7f0099222a51b5f6", 7) == 3) && !(getdvarint(#"hash_7f0099222a51b5f6", 7) == 4) && !(getdvarint(#"hash_7f0099222a51b5f6", 7) == 5) && !(getdvarint(#"hash_7f0099222a51b5f6", 7) == 6) && !(getdvarint(#"hash_7f0099222a51b5f6", 7) == 7)) {
        str_rumble = # "hash_795b2f3495784147";
        var_58b22097 = 2;
        var_685248c4 = 7;
        n_delay_min = 45;
        n_delay_max = 60;
        str_fxanim = # "p9_fxanim_mp_frontend_plane_station_lobby_bundle";
        var_df4e70cd = "";
        break;
      } else {
        return;
      }
    case # "loadout_room":
      str_rumble = # "hash_4830baac0547b450";
      var_58b22097 = 15;
      var_685248c4 = 20;
      n_delay_min = 120;
      n_delay_max = 180;
      str_fxanim = # "p9_fxanim_mp_frontend_plane_station_guns_bundle";
      var_df4e70cd = # "hash_20e4410e7a619aab";
      break;
    case # "character_room":
      str_rumble = # "hash_4a7c098220c7b9be";
      var_58b22097 = 10;
      var_685248c4 = 15;
      n_delay_min = 60;
      n_delay_max = 75;
      str_fxanim = # "p9_fxanim_mp_frontend_plane_station_character_bundle";
      var_df4e70cd = # "hash_4332c2e140d253";
      break;
  }

  v_source = struct::get(str_fxanim, "scriptbundlename").origin;
  b_first_time = 1;

  while(true) {
    if(b_first_time) {
      n_timeout = randomfloatrange(var_58b22097, var_685248c4);
      level scene::stop(str_fxanim);
    } else {
      n_timeout = randomfloatrange(n_delay_min, n_delay_max);
    }

    wait n_timeout;
    b_first_time = 0;
    playSound(var_2a4208a4, var_df4e70cd, (0, 0, 0));
    playrumbleonposition(var_2a4208a4, str_rumble, v_source);
    level thread scene::play(str_fxanim);
  }
}

function function_24ae4ffb() {
  forceambientroom("");
  setsoundcontext("frontend", "active");
  audio::function_d3790fe();
  function_5ea2c6e3("ui_frontend_mute_movies");
  audio::function_a022576e();
}

function function_4ff471c2() {
  level endon(#"disconnect");

  while(true) {
    wait randomintrange(7, 20);

    if(math::cointoss()) {
      n_amount = randomfloatrange(0, 1);
      var_fd343efd = randomintrange(4, 11);
      function_5ea2c6e3("amb_frontend_planerattle_flux", var_fd343efd, n_amount);
    }

    if(math::cointoss()) {
      n_amount = randomfloatrange(0, 1);
      var_fd343efd = randomintrange(4, 11);
      function_5ea2c6e3("amb_frontend_planedrone_flux", var_fd343efd, n_amount);
    }
  }
}

function function_49efdec6(localclientnum, menu_name, str_state) {
  self notify("65dc9296f75a6659");
  self endon("65dc9296f75a6659");
  level endon(#"disconnect");

  if(!is_true(level.var_bc580f2)) {
    level function_2524bdd7();
    level.var_bc580f2 = 1;
  }

  var_4e9b78d2 = 0;
  session_mode = currentsessionmode();

  if(session_mode === 0) {
    var_4e9b78d2 = 1;
  } else {
    function_672403ca("amb_frontend_zmb", 0.25, 1);
  }

  switch (str_state) {
    case # "room2":
    case # "room1":
    case # "mode_select":
    case # "directorselect":
    default:
      function_672403ca("amb_frontend_armory", 0.25, 1);
      function_672403ca("amb_frontend_lobby", 0.25, 1);
      function_672403ca("amb_frontend_mtx", 0.25, 1);

      if(var_4e9b78d2) {
        function_672403ca("amb_frontend_zmb", 0.25, 1);
      }

      if(getdvarint(#"hash_7f0099222a51b5f6", 7) == 5) {
        level thread function_5bf9aa8e();
      }

      if(getdvarint(#"hash_499e959d9b7fbd41", 0) || getdvarint(#"hash_735ace6b22542a65", 0)) {
        level thread function_74553225();
      }

      break;
    case # "armory":
    case # "medium_vol":
    case # "scorestreaks":
    case # "zmskills":
    case # "character_room":
    case # "loadout_room":
    case # "accessories":
      function_672403ca("amb_frontend_armory", 0.25, 0);
      function_672403ca("amb_frontend_lobby", 0.25, 1);
      function_672403ca("amb_frontend_mtx", 0.25, 1);

      if(var_4e9b78d2) {
        function_672403ca("amb_frontend_zmb", 0.25, 1);
      }

      if(getdvarint(#"hash_7f0099222a51b5f6", 7) == 5) {
        level thread function_5bf9aa8e();
      }

      if(getdvarint(#"hash_499e959d9b7fbd41", 0) || getdvarint(#"hash_735ace6b22542a65", 0)) {
        level thread function_74553225();
      }

      break;
    case # "private_lobby_pose":
    case # "cdl_hub":
    case # "lobby_pose":
      function_672403ca("amb_frontend_armory", 0.25, 1);
      function_672403ca("amb_frontend_lobby", 0.25, 0);
      function_672403ca("amb_frontend_mtx", 0.25, 1);

      if(var_4e9b78d2) {
        function_672403ca("amb_frontend_zmb", 0.25, 0);
      }

      if(getdvarint(#"hash_7f0099222a51b5f6", 7) == 5) {
        level thread function_2a0a1f1a();
      }

      if(getdvarint(#"hash_499e959d9b7fbd41", 0) || getdvarint(#"hash_735ace6b22542a65", 0)) {
        level thread function_9b7d8cf8(menu_name);
      }

      break;
    case # "cp_story":
    case # "cp_evidence":
    case # "hash_3262189f972fcd0e":
    case # "hash_56527b57d58c2c6a":
      function_672403ca("amb_frontend_armory", 0.25, 1);
      function_672403ca("amb_frontend_lobby", 0.25, 1);
      function_672403ca("amb_frontend_mtx", 0.25, 0);

      if(var_4e9b78d2) {
        function_672403ca("amb_frontend_zmb", 0.25, 1);
      }

      if(getdvarint(#"hash_7f0099222a51b5f6", 7) == 5) {
        level thread function_5bf9aa8e();
      }

      if(getdvarint(#"hash_499e959d9b7fbd41", 0) || getdvarint(#"hash_735ace6b22542a65", 0)) {
        level thread function_74553225();
      }

      break;
  }
}

function function_2524bdd7() {
  audio::playloopat(#"hash_43dce4b6881f080e", (0, 0, 0));
  audio::playloopat(#"hash_94ef5cfc161174c", (1, 1, 1));
  audio::playloopat(#"hash_6f0c673b09011cbf", (2, 2, 2));
  audio::playloopat(#"hash_2a68070c66c3b1c6", (3, 3, 3));
  audio::playloopat(#"hash_9160acfc13175b4", (4, 4, 4));
  audio::playloopat(#"hash_55236c15e2bc2f16", (5, 5, 5));
  audio::playloopat(#"hash_5cef4cfaac8c6a7c", (6, 6, 6));
  function_5ea2c6e3("amb_frontend_drone", 0.5, 0);
  function_5ea2c6e3("amb_frontend_armory", 0.5, 1);
  function_5ea2c6e3("amb_frontend_lobby", 0.5, 1);
  function_5ea2c6e3("amb_frontend_mtx", 0.5, 1);
  function_5ea2c6e3("amb_frontend_zmb", 0.5, 1);
  function_5ea2c6e3("amb_frontend_lobby_numers_high", 0.5, 1);
  function_5ea2c6e3("amb_frontend_lobby_numers_low", 0.5, 1);
}

function function_2a0a1f1a() {
  self notify("68fd8d7b0fa89fab");
  self endon("68fd8d7b0fa89fab");
  level endon(#"disconnect");
  level endon(#"hash_4c0ff2c93d3292eb");
  var_ac0c1ab5 = 0;
  var_4e3a3f7d = 0.8;
  var_a4d9975b = 1;
  var_58d3d289 = 6;
  str_prefix = "amb_frontend_lobby_numers_";

  while(true) {
    str_suffix = "high";

    if(math::cointoss()) {
      str_suffix = "low";
    }

    var_f9d98743 = randomfloatrange(var_ac0c1ab5, var_4e3a3f7d);
    var_fd343efd = randomfloatrange(var_a4d9975b, var_58d3d289);
    function_672403ca(str_prefix + str_suffix, var_fd343efd, var_f9d98743);
    wait var_fd343efd;
  }
}

function function_5bf9aa8e() {
  self notify("4f916316ec4aec5e");
  self endon("4f916316ec4aec5e");
  level endon(#"disconnect");
  level notify(#"hash_4c0ff2c93d3292eb");
  function_672403ca("amb_frontend_lobby_numers_high", 0.5, 1);
  function_672403ca("amb_frontend_lobby_numers_low", 0.5, 1);
}

function function_9b7d8cf8(localclientnum) {
  self notify("a1e96bfc63ef883");
  self endon("a1e96bfc63ef883");
  level endon(#"disconnect");
  level endon(#"hash_6d06f88e8d5ec88a");
  n_wait_min = 8;
  n_wait_max = 25;

  while(true) {
    wait randomintrange(n_wait_min, n_wait_max + 1);
    playSound(localclientnum, #"hash_7621a4e2fbef69c0", (0, 0, 0));
  }
}

function function_74553225() {
  self notify("6bde9ba57af14256");
  self endon("6bde9ba57af14256");
  level endon(#"disconnect");
  level notify(#"hash_6d06f88e8d5ec88a");
}

function function_b8a526ac(var_f9d98743 = 0, var_ac30bc43) {
  audioent = level.var_96d63e5f;
  var_cd20722b = audioent.var_2788b16c;

  foreach(id in var_ac30bc43) {
    setsoundvolume(var_cd20722b[id], var_f9d98743);
  }
}

function function_74e1ca20(str_notify) {
  if(level.lastlobbystate === # "character_room" && str_notify === # "hash_248ca22abc6b78ed" && isDefined(level.var_debe8147)) {
    [[level.var_1c43dd3e]] - > function_15a8906a(level.var_debe8147);
    level.var_debe8147 = undefined;
  }
}

function function_90cad834(localclientnum, var_3449052c = 0, var_7f395102, var_e6db60fc = 0, var_90d2372c = 0) {
  level notify(#"hash_53d7a69385304e8");
  level notify(#"end_character_rotating" + localclientnum);
  level endoncallback(&function_74e1ca20, #"hash_53d7a69385304e8", #"hash_248ca22abc6b78ed", #"disconnect");
  xuid = [[level.var_1c43dd3e]] - > function_25725c05();
  var_136f48d7 = [[level.var_1c43dd3e]] - > function_8567daf2();
  showcase_weapon = function_8d53d5b6(localclientnum, undefined, xuid);

  if(function_6677a717(showcase_weapon, var_136f48d7)) {
    [[level.var_1c43dd3e]] - > function_c4baf89b(showcase_weapon);
  }

  weapon = showcase_weapon.weapon;
  var_5b38793b = showcase_weapon.renderoptionsweapon;
  var_f7332085 = showcase_weapon.var_fd90b0bb;
  var_b1e821c5 = spawnStruct();

  if(isDefined(var_7f395102)) {
    var_16be1107 = function_4b2dd0a6(var_7f395102.charactermode, var_7f395102.charactertype);
  } else {
    var_16be1107 = function_2ca65924(level.var_1c43dd3e);
  }

  if(var_3449052c) {
    if(isDefined(level.var_debe8147)) {
      var_b8f75d74 = [[level.var_1c43dd3e]] - > function_98d70bef();
    }

    level.var_debe8147 = var_7f395102;
    params = {
      #var_a34c858c: 1, #scene: var_16be1107, #var_74741b75: "select_outro", #var_99a89f83: 1, #var_f5332569: var_b8f75d74, #activeweapon: weapon, #var_b8f20727: var_5b38793b, #var_452aa9c0: var_f7332085
    };
    [[level.var_1c43dd3e]] - > update(params);
    var_c74251a4 = scene::function_8582657c(var_16be1107, "select_outro");

    if(isDefined(var_b8f75d74)) {
      n_wait_time = var_c74251a4 - var_b8f75d74 * var_c74251a4;
      wait n_wait_time;
    } else {
      wait var_c74251a4;
    }

    if(isDefined(var_7f395102)) {
      [[level.var_1c43dd3e]] - > function_15a8906a(var_7f395102);
    }
  } else if(isDefined(var_7f395102) && var_7f395102.charactertype !== -1000) {
    [[level.var_1c43dd3e]] - > function_15a8906a(var_7f395102);
  }

  level.var_debe8147 = undefined;

  if(var_e6db60fc) {
    var_f647c5b2 = "select_intro";

    if(!level flag::get("waiting_for_character_change") && [[level.var_1c43dd3e]] - > function_ea4ac9f8() && [[level.var_1c43dd3e]] - > is_visible()) {
      var_b1e821c5.blend = 0.5;
      var_b1e821c5.var_dcfaf6c7 = 0.5;
    } else {
      var_b1e821c5.blend = 0;
      var_b1e821c5.var_9e6d8a3d = 0.5;
      var_b1e821c5.var_dcfaf6c7 = 0.5;
    }
  } else {
    var_b8f75d74 = [[level.var_1c43dd3e]] - > function_98d70bef();
    var_b1e821c5.blend = 0;
    var_b1e821c5.var_dcfaf6c7 = 0.5;
  }

  params = {
    #var_a34c858c: 1, #var_c76f3e47: 1, #var_401d9a1: 1, #var_f5332569: var_b8f75d74, #var_b1e821c5: var_b1e821c5, #scene: var_16be1107, #var_74741b75: var_f647c5b2, #var_a68ab9c2: "select_idle", #var_99a89f83: 1, #activeweapon: weapon, #var_b8f20727: var_5b38793b, #var_452aa9c0: var_f7332085, #var_90d2372c: var_90d2372c
  };
  [[level.var_1c43dd3e]] - > update(params);
  level flag::clear("waiting_for_character_change");
}

function function_92136eb2(localclientnum, menu_name, str_scene, var_f647c5b2, var_559c5c3e, var_77e970fa = 1, var_dd5c339d = 1) {
  level notify(#"hash_6b50f726c9f6f9f");
  level endon(#"hash_6b50f726c9f6f9f", #"disconnect");

  if(isDefined(menu_name)) {
    level endon(menu_name + "_closed");
  }

  var_1dfa126c = 1;

  while(true) {
    player_data = function_25f808c9(localclientnum, 1);

    if(!isDefined(player_data)) {
      player_data = character_customization::function_3f5625f1(1, 2);
    }

    var_c0a8925e = player_data.charactertype;

    if(isDefined(var_c0a8925e) && (var_c0a8925e !== level.var_f7aea3ff || var_1dfa126c)) {
      var_1dfa126c = 0;
      localxuid = function_9bed6a71(localclientnum);
      [[level.var_1c43dd3e]] - > function_15a8906a(player_data);
      var_bfab3c58 = function_8d53d5b6(localclientnum, undefined, localxuid);
      [[level.var_1c43dd3e]] - > function_c4baf89b(var_bfab3c58);
      params = {
        #var_a34c858c: 1, #var_401d9a1: var_77e970fa, #var_c76f3e47: var_dd5c339d, #scene: str_scene, #var_74741b75: var_f647c5b2, #var_a68ab9c2: var_559c5c3e, #activeweapon: var_bfab3c58.weapon, #var_b8f20727: var_bfab3c58.renderoptionsweapon, #var_452aa9c0: var_bfab3c58.var_fd90b0bb
      };
      [[level.var_1c43dd3e]] - > update(params);
      level.var_f7aea3ff = var_c0a8925e;
    }

    wait 0.1;
  }
}

function function_aba0885b(localclientnum) {
  player_data = function_25f808c9(localclientnum, 1);

  if(!isDefined(player_data)) {
    player_data = character_customization::function_3f5625f1(1, 2);
  }

  var_c0a8925e = player_data.charactertype;

  if(isDefined(var_c0a8925e) && var_c0a8925e !== level.var_f7aea3ff) {
    [[level.var_1c43dd3e]] - > function_15a8906a(player_data);
    level.var_f7aea3ff = var_c0a8925e;
  }
}

function function_4431001a(localclientnum, scene_shot, menu_name) {
  var_d909a5b5 = function_43a2bce();

  if(isDefined(scene_shot)) {
    level childthread function_92136eb2(localclientnum, menu_name, var_d909a5b5, undefined, scene_shot);
    return;
  }

  level notify(#"hash_6b50f726c9f6f9f");
  level scene::cancel(var_d909a5b5);
}