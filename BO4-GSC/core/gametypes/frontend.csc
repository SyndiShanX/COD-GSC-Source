/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core\gametypes\frontend.csc
***********************************************/

#include script_7ca3324ffa5389e4;
#include scripts\core\gametypes\frontend_blackmarket;
#include scripts\core\gametypes\frontend_draft;
#include scripts\core_common\activecamo_shared;
#include scripts\core_common\animation_shared;
#include scripts\core_common\array_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\character_customization;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\custom_class;
#include scripts\core_common\exploder_shared;
#include scripts\core_common\lui_shared;
#include scripts\core_common\math_shared;
#include scripts\core_common\postfx_shared;
#include scripts\core_common\scene_shared;
#include scripts\core_common\struct;
#include scripts\core_common\util_shared;
#include scripts\core_common\weapon_customization_icon;
#include scripts\mp_common\devgui;

#namespace frontend;

function_9bfe9255(var_f75a02ea, mode) {
  var_a2865de6 = getplayerroletemplatecount(mode);

  for(i = 0; i < var_a2865de6; i++) {
    var_eb49090f = function_b14806c6(i, mode);

    if(isDefined(var_eb49090f) && var_eb49090f == var_f75a02ea) {
      return i;
    }
  }
}

function_b7d4bfd9(var_4fa755f8, var_3f0e790b = 0) {
  if(!isDefined(var_4fa755f8)) {
    return undefined;
  }

  switch (var_3f0e790b) {
    case 1:
      return var_4fa755f8.arenalobbyscenes;
    case 0:
    default:
      return var_4fa755f8.lobbyscenes;
  }
}

function_b9f8bbd9(character_index, session_mode) {
  if(session_mode == 4) {
    return false;
  }

  if(!function_f4bf7e3f(character_index, session_mode)) {
    return false;
  }

  fields = getcharacterfields(character_index, session_mode);

  if(!isDefined(fields)) {
    return false;
  }

  scenes = function_b7d4bfd9(fields, session_mode);

  if(!isDefined(scenes) || scenes.size == 0) {
    return false;
  }

  return true;
}

function_8d1cae0b(character_index, session_mode) {
  if(!function_b9f8bbd9(character_index, session_mode)) {
    return false;
  }

  if(session_mode == 3) {
    fields = getplayerrolefields(character_index, session_mode);
    return (isDefined(fields.isdefaultcharacter) && fields.isdefaultcharacter);
  }

  characterfields = getcharacterfields(character_index, session_mode);

  if(isDefined(characterfields.requireddvar) && !getdvarint(characterfields.requireddvar, 0)) {
    return false;
  }

  return true;
}

function_e3efec59(xuid, session_mode) {
  if(!isDefined(level.var_dd1c817)) {
    level.var_dd1c817 = [];
  }

  if(!isDefined(level.var_dd1c817[session_mode])) {
    level.var_dd1c817[session_mode] = [];
  }

  character_index = undefined;

  if(function_89e574c(xuid) && isDefined(level.var_be02eda3) && level.var_e362b5d9[level.var_be02eda3].mode == session_mode && function_b9f8bbd9(level.var_e362b5d9[level.var_be02eda3].role_index, session_mode)) {
    character_index = level.var_e362b5d9[level.var_be02eda3].role_index;
  } else if(isDefined(level.var_dd1c817[session_mode][xuid])) {
    character_index = level.var_dd1c817[session_mode][xuid];
  } else {
    var_a2865de6 = getplayerroletemplatecount(session_mode);
    attempts = 0;

    while(true) {
      character_index = randomint(var_a2865de6);

      if(function_8d1cae0b(character_index, session_mode)) {
        break;
      }

      attempts++;

      if(attempts > 3) {
        character_index = undefined;

        for(ci = 0; ci < var_a2865de6; ci++) {
          if(function_8d1cae0b(ci, session_mode)) {
            character_index = ci;
            break;
          }
        }

        break;
      }
    }
  }

  level.var_dd1c817[session_mode][xuid] = character_index;
  return level.var_dd1c817[session_mode][xuid];
}

function_3a965fac(scene_name, prt, mode, fields) {
  var_8b15a963 = function_9bfe9255(prt, mode);

  if(isDefined(var_8b15a963)) {
    canselect = !(isDefined(fields.var_819846c7) && fields.var_819846c7);
    var_7accf7bb = {
      #scene: scene_name, 
      #prt: prt, 
      #canselect: canselect, 
      #dvar: fields.requireddvar, 
      #role_index: var_8b15a963, 
      #list_index: level.var_e362b5d9.size, 
      #mode: mode, 
      #fields: fields, 
      #isdefault: isDefined(fields.var_c6376b99) && fields.var_c6376b99
    };

    if(!isDefined(level.var_e362b5d9)) {
      level.var_e362b5d9 = [];
    } else if(!isarray(level.var_e362b5d9)) {
      level.var_e362b5d9 = array(level.var_e362b5d9);
    }

    level.var_e362b5d9[level.var_e362b5d9.size] = var_7accf7bb;

    if(mode == 1) {
      scene_shots = scene::get_all_shot_names(scene_name, undefined, 1);

      foreach(shot in scene_shots) {
        scene::add_scene_func(scene_name, &function_ebc650f4, shot, scene_name, shot);
      }
    }
  }
}

function_89c6128e(mode) {
  for(index = 0; index < getplayerroletemplatecount(mode); index++) {
    fields = getcharacterfields(index, mode);

    if(isDefined(fields) && isDefined(fields.var_4c65efc8)) {
      scene_def = struct::get_script_bundle("scene", fields.var_4c65efc8);

      if(isDefined(scene_def)) {
        prtname = function_b14806c6(index, mode);

        prtname = function_9e72a96(prtname);

        function_3a965fac(fields.var_4c65efc8, prtname, mode, fields);
      }
    }
  }
}

event_handler[gametype_init] main(eventstruct) {
  draft::init();
  level.callbackentityspawned = &entityspawned;
  level.callbacklocalclientconnect = &localclientconnect;
  level.orbis = getdvarstring(#"orbisgame") == "true";
  level.durango = getdvarstring(#"durangogame") == "true";
  customclass::init();
  level.var_e362b5d9 = array();
  function_89c6128e(1);
  function_89c6128e(0);
  function_89c6128e(3);
  level thread blackscreen_watcher();
  setstreamerrequest(1, "core_frontend");
}

function_e843475e(localclientnum, menuname) {
  lui::createcameramenu(menuname, localclientnum, #"tag_align_frontend_background", #"ui_scene_cam_background");
  lui::function_9d7ab167(menuname, localclientnum, 3, #"wz_inspection_struct", #"hash_191c3f4fc94449f1");
}

setupclientmenus(localclientnum) {
  lui::initmenudata(localclientnum);
  lui::createcustomcameramenu("Main", localclientnum, &lobby_main, 1, undefined, &function_58994f4a);
  lui::createcustomcameramenu("LobbyInspection", localclientnum, &handle_inspect_player, 0, &start_character_rotating_any, &end_character_rotating_any);
  lui::linktocustomcharacter("LobbyInspection", localclientnum, "inspection_character", 0);
  lui::createcustomcameramenu("SinglePlayerInspection", localclientnum, &handle_inspect_player, 0, &start_character_rotating_any, &end_character_rotating_any);
  lui::linktocustomcharacter("SinglePlayerInspection", localclientnum, "inspection_character", 0);
  lui::createcustomcameramenu("ChooseTaunts", localclientnum, &choose_taunts_camera_watch, 0);
  lui::linktocustomcharacter("ChooseTaunts", localclientnum, "character_customization");
  lui::createcameramenu("ChooseFaction", localclientnum, #"spawn_char_custom", #"ui_cam_character_customization", "cam_helmet", undefined, undefined, undefined, 1000);
  lui::createcustomcameramenu("Paintshop", localclientnum, undefined, 0, undefined, undefined);
  lui::createcustomcameramenu("PaintjobWeaponSelect", localclientnum, undefined, 0, undefined, undefined);
  lui::createcustomcameramenu("Gunsmith", localclientnum, undefined, 0, undefined, undefined);
  lui::createcustomcameramenu("MyShowcase", localclientnum, undefined, 0, undefined, undefined);
  lui::createcustomcameramenu("Community", localclientnum, undefined, 0, undefined, undefined);
  lui::createcustomcameramenu("MyShowcase_Paintjobs", localclientnum, undefined, 0, undefined, undefined);
  lui::createcustomcameramenu("MyShowcase_Variants", localclientnum, undefined, 0, undefined, undefined);
  lui::createcustomcameramenu("MyShowcase_Emblems", localclientnum, undefined, 0, undefined, undefined);
  lui::createcustomcameramenu("MyShowcase_CategorySelector", localclientnum, undefined, 0, undefined, undefined);
  lui::createcustomcameramenu("GroupHeadquarters", localclientnum, undefined, 0, undefined, undefined);
  lui::createcustomcameramenu("MediaManager", localclientnum, undefined, 0, undefined, undefined);
  lui::createcameramenu("WeaponBuildKits", localclientnum, #"zm_weapon_position", #"ui_cam_cac_specialist", "cam_specialist", undefined, undefined, undefined);
  lui::createcameramenu("CombatRecordWeaponsZM", localclientnum, #"zm_weapon_position", #"ui_cam_cac_specialist", "cam_specialist", undefined, undefined, undefined);
  lui::createcameramenu("BubblegumBuffs", localclientnum, #"loadout_camera", #"c_fe_zm_megachew_vign_camera_2", "c_fe_zm_megachew_vign_camera_2", undefined, undefined, undefined);
  lui::createcameramenu("BubblegumPacks", localclientnum, #"loadout_camera", #"c_fe_zm_megachew_vign_camera_2", "c_fe_zm_megachew_vign_camera_2");
  lui::createcustomcameramenu("BubblegumPackEdit", localclientnum, undefined, undefined, undefined, undefined);
  lui::createcustomcameramenu("BubblegumBuffSelect", localclientnum, undefined, undefined, undefined, undefined);
  lui::createcustomcameramenu("CombatRecordBubblegumBuffs", localclientnum, undefined, undefined, undefined, undefined);
  lui::createcameramenu("MegaChewFactory", localclientnum, #"zm_gum_position", #"c_fe_zm_megachew_vign_camera", "default", undefined, undefined, undefined);
  lui::createcustomcameramenu("Pregame_Main", localclientnum, &lobby_main, 1);
  lui::createcustomcameramenu("CombatRecordWeapons", localclientnum, undefined, 0, undefined, undefined);
  lui::createcustomcameramenu("CombatRecordEquipment", localclientnum, undefined, 0, undefined, undefined);
  lui::createcustomcameramenu("CombatRecordCybercore", localclientnum, undefined, 0, undefined, undefined);
  lui::createcustomcameramenu("CombatRecordCollectibles", localclientnum, undefined, 0, undefined, undefined);
  lui::createcameramenu("CombatRecordSpecialists", localclientnum, #"spawn_char_cac_choose", #"ui_cam_cac_specialist", "cam_specialist", undefined, &open_choose_class, &close_choose_class);
  lui::linktocustomcharacter("CombatRecordSpecialists", localclientnum, "character_customization");
  lui::createcameramenu("MPCustomizeClassMenu", localclientnum, #"cac_specialist_angle", #"ui_cam_loadout_character", "");
  lui::createcustomcameramenu("AAR_T8_MP", localclientnum, &function_73b8462a, 1, undefined, &function_48fb04a7);
  lui::linktocustomcharacter("AAR_T8_MP", localclientnum, "aar_character");
  lui::createcustomcameramenu("AAR_T8_ZM", localclientnum, &function_73b8462a, 1, undefined, &function_48fb04a7);
  lui::linktocustomcharacter("AAR_T8_ZM", localclientnum, "aar_character");
  lui::createcustomcameramenu("AAR_T8_WZ", localclientnum, &function_73b8462a, 1, undefined, &function_48fb04a7);
  lui::linktocustomcharacter("AAR_T8_WZ", localclientnum, "aar_character");
  lui::createcustomcameramenu("AAR_T8_ARENA", localclientnum, &function_73b8462a, 1, undefined, &function_48fb04a7);
  lui::linktocustomcharacter("AAR_T8_ARENA", localclientnum, "aar_character");
  lui::createcustomcameramenu("AARMissionRewardOverlay", localclientnum, &function_f8cec907, 1, undefined, &end_character_rotating);
  lui::linktocustomcharacter("AARMissionRewardOverlay", localclientnum, "specialist_customization");
  function_e843475e(localclientnum, "Social_Main");
  function_e843475e(localclientnum, "SupportSelection");
  function_e843475e(localclientnum, "DirectorPersonalizeCharacterMP");
  function_e843475e(localclientnum, "MPSpecialistHUB");
  function_e843475e(localclientnum, "MPSpecialistHUBWeapons");
  function_e843475e(localclientnum, "EmblemSelect");
  function_e843475e(localclientnum, "EmblemChooseIcon");
  function_e843475e(localclientnum, "EmblemEditor");
  function_e843475e(localclientnum, "Store");
  function_e843475e(localclientnum, "Store_DLC");
  function_e843475e(localclientnum, "DirectorFindGame");
  function_e843475e(localclientnum, "ZMPersonalizeCharacterMain");
  function_e843475e(localclientnum, "WZPersonalizeCharacterMain");
  lui::createcustomcameramenu("MPSpecialistHUBInspect", localclientnum, &function_25b060af, 1, &start_character_rotating, &end_character_rotating);
  lui::linktocustomcharacter("MPSpecialistHUBInspect", localclientnum, "specialist_customization");
  lui::createcustomcameramenu("directorTraining", localclientnum, &function_25b060af, 1, &start_character_rotating, &end_character_rotating);
  lui::linktocustomcharacter("directorTraining", localclientnum, "specialist_customization");
  lui::createcustomcameramenu("PersonalizeCharacter", localclientnum, &function_6657c529, 1, &start_character_rotating, array(&end_character_rotating, &function_a72640b3));
  lui::linktocustomcharacter("PersonalizeCharacter", localclientnum, "specialist_customization");
  lui::createcustomcameramenu("ZMPersonalizeCharacter", localclientnum, &function_d8402f0c, 1, &start_character_rotating, &end_character_rotating);
  lui::linktocustomcharacter("ZMPersonalizeCharacter", localclientnum, "specialist_customization");
  lui::createcustomcameramenu("MPSpecialistHUBGestures", localclientnum, &function_9602c423, 1, &start_character_rotating, &end_character_rotating);
  lui::linktocustomcharacter("MPSpecialistHUBGestures", localclientnum, "specialist_customization");
  function_e843475e(localclientnum, "MPSpecialistHUBTags");
  lui::createcustomcameramenu("MPSpecialistHUBPreviewMoment", localclientnum, &function_3dde055b, 0, undefined, &function_c4db2740);
  lui::linktocustomcharacter("MPSpecialistHUBPreviewMoment", localclientnum, "specialist_customization");
  lui::createcustomcameramenu("ItemShopDetails", localclientnum, &function_837446a8, 1, array(&function_98088878), array(&end_character_rotating, &function_7142469f));
  lui::linktocustomcharacter("ItemShopDetails", localclientnum, "specialist_customization");
  lui::createcustomcameramenu("ItemShopDetailsSunset", localclientnum, &function_837446a8, 1, array(&function_98088878), array(&end_character_rotating, &function_7142469f));
  lui::linktocustomcharacter("ItemShopDetailsSunset", localclientnum, "specialist_customization");
  lui::createcustomcameramenu("QuarterMasterMenu", localclientnum, &function_837446a8, 1, array(&function_98088878, &blackmarket::function_78a5c895), array(&end_character_rotating, &function_7142469f, &blackmarket::function_c46c0287));
  lui::linktocustomcharacter("QuarterMasterMenu", localclientnum, "specialist_customization");
  lui::createcustomcameramenu("ContractDetails", localclientnum, &function_837446a8, 1, array(&function_98088878), array(&end_character_rotating, &function_7142469f));
  lui::linktocustomcharacter("ContractDetails", localclientnum, "specialist_customization");
  lui::createcustomcameramenu("ContractDetailsSunset", localclientnum, &function_837446a8, 1, array(&function_98088878), array(&end_character_rotating, &function_7142469f));
  lui::linktocustomcharacter("ContractDetailsSunset", localclientnum, "specialist_customization");
  lui::createcustomcameramenu("BlackMarketBountyDetails", localclientnum, &function_837446a8, 1, array(&function_98088878), array(&end_character_rotating, &function_7142469f));
  lui::linktocustomcharacter("BlackMarketBountyDetails", localclientnum, "specialist_customization");
  lui::createcustomcameramenu("PersonalizeDefaultWZCharacter", localclientnum, &function_36962bc4, 1, &start_character_rotating, &end_character_rotating);
  lui::linktocustomcharacter("PersonalizeDefaultWZCharacter", localclientnum, "specialist_customization");
  lui::createcustomcameramenu("WZPersonalizeCharacterInspect", localclientnum, &function_8ad37038, 1, &start_character_rotating, &end_character_rotating);
  lui::linktocustomcharacter("WZPersonalizeCharacterInspect", localclientnum, "specialist_customization");
  lui::createcustomcameramenu("WZPersonalizeCharacter", localclientnum, &wz_personalize_character, 1, &start_character_rotating, &end_character_rotating);
  lui::linktocustomcharacter("WZPersonalizeCharacter", localclientnum, "specialist_customization");
  lui::createcustomcameramenu("WeaponBribeSelection", localclientnum, &function_837446a8, 1, array(&function_98088878), array(&end_character_rotating, &function_7142469f));
  lui::linktocustomcharacter("WeaponBribeSelection", localclientnum, "specialist_customization");
  lui::createcustomcameramenu("WZJumpKitSelector", localclientnum, &function_bc98f036);
  lui::createcustomcameramenu("DirectorChangeCharacter", localclientnum, &function_d252281d, 0, undefined, undefined);
  lui::createcustomcameramenu("WeaponDeathFxSelect", localclientnum, &function_ac9a8cf, 0, &start_character_rotating, array(&function_5e7dcbed, &end_character_rotating));
  lui::linktocustomcharacter("WeaponDeathFxSelect", localclientnum, "specialist_customization");
  var_eeef11ce = "scene_frontend_t8_zombies";
  scene::add_scene_func(var_eeef11ce, &function_2f93d681, "init");
  scene::add_scene_func(var_eeef11ce, &function_1bff2e73, "stop");
  var_5ef5aa96 = "scene_frontend_arena_team";
  scene::add_scene_func(var_5ef5aa96, &function_fad4ce33, "init");
  scene::add_scene_func(var_5ef5aa96, &function_c5cbf7d6, "stop");
  var_a2999da1 = scene::get_all_shot_names(var_eeef11ce, undefined, 1);

  foreach(shot in var_a2999da1) {
    scene::add_scene_func(var_eeef11ce, &function_12f56a9, shot);
  }
}

blackscreen_watcher() {
  blackscreenuimodel = createuimodel(getglobaluimodel(), "hideWorldForStreamer");
  setuimodelvalue(blackscreenuimodel, 1);

  while(true) {
    waitresult = level waittill(#"streamer_change");
    var_d0b01271 = waitresult.var_d0b01271;
    setuimodelvalue(blackscreenuimodel, 1);
    wait 0.1;

    while(true) {
      charready = 1;

      if(isDefined(var_d0b01271)) {
        charready = [
          [var_d0b01271]
        ] - > is_streamed();
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

streamer_change(hint, var_d0b01271) {
  if(isDefined(hint)) {
    setstreamerrequest(0, hint);
  } else {
    clearstreamerrequest(0);
  }

  level notify(#"streamer_change", {
    #var_d0b01271: var_d0b01271
  });
}

handle_inspect_player(localclientnum, menu_name) {
  level endon(#"disconnect");
  level endon(menu_name + "_closed");
  level thread scene::play("scene_frontend_inspection_camera", "inspection_full");
  level thread function_b885d47c(menu_name, localclientnum);
  level thread function_37304ace(localclientnum, menu_name);

  while(true) {
    waitresult = level waittill(#"inspect_player");
    assert(isDefined(waitresult.xuid));
    level childthread update_inspection_character(localclientnum, waitresult.xuid, menu_name);
  }
}

function_b885d47c(menu_name, localclientnum) {
  level waittill(menu_name + "_closed");
  level thread scene::stop("scene_frontend_inspection_camera");
  level.var_44011752 hide();
}

update_inspection_character(localclientnum, xuid, menu_name) {
  self notify("adfb62bb15c5d46");
  self endon("adfb62bb15c5d46");
  var_d0b01271 = lui::getcharacterdataformenu(menu_name, localclientnum);
  var_a708693a = isDefined(level.draftcharacters) && level.draftcharacters.size > 0;

  if(var_a708693a) {
    foreach(character in level.draftcharacters) {
      info = [
        [character]
      ] - > function_82e05d64();

      if(isDefined(info) && util::function_48e57e36(xuid) == info.xuid) {
        var_23904c1d = [
          [character]
        ] - > function_e599283f();
      }
    }
  }

  if(!isDefined(var_23904c1d)) {
    var_23904c1d = getcharactercustomizationforxuid(localclientnum, xuid);
  }

  if(!isDefined(var_23904c1d)) {
    [[var_d0b01271]] - > function_1ec9448d(1);
    [[var_d0b01271]] - > function_27945cb8(1);
    params = {
      #anim_name: [
        [var_d0b01271]
      ] - > function_8144231c()
    };
    [[var_d0b01271]] - > update(params);

    for(iterations = 0; !isDefined(var_23904c1d) && iterations < 15; iterations++) {
      wait 1;
      var_23904c1d = getcharactercustomizationforxuid(localclientnum, xuid);
    }

    [[var_d0b01271]] - > function_1ec9448d(0);
    [[var_d0b01271]] - > function_27945cb8(0);
  }

  session_mode = currentsessionmode();

  if(!isDefined(var_23904c1d) || !var_a708693a && !function_8d1cae0b(var_23904c1d.charactertype, var_23904c1d.charactermode) || session_mode != 4 && var_23904c1d.charactermode != session_mode) {
    if(session_mode == 4 || session_mode == 2) {
      session_mode = 1;

      if(getplayerroletemplatecount(session_mode) == 0) {
        session_mode = 3;
      }

      if(getplayerroletemplatecount(session_mode) == 0) {
        session_mode = 0;
      }
    }

    character_index = function_e3efec59(xuid, session_mode);

    if(isDefined(character_index)) {
      level.var_dd1c817[xuid] = character_index;
      var_23904c1d = character_customization::function_3f5625f1(session_mode, character_index);
      fields = getcharacterfields(character_index, session_mode);
    }
  } else {
    fields = getcharacterfields(var_23904c1d.charactertype, var_23904c1d.charactermode);
  }

  var_8e0277a = undefined;

  if(isDefined(fields)) {
    var_8e0277a = fields.var_2081b2ed;
  }

  if(isDefined(var_8e0277a) && character_customization::function_aa5382ed([[var_d0b01271]] - > function_e599283f(), var_23904c1d)) {
    [[var_d0b01271]] - > function_1ec9448d(0);
    params = {
      #var_401d9a1: 1, 
      #var_c76f3e47: 1, 
      #scene: var_8e0277a
    };
    [[var_d0b01271]] - > function_15a8906a(var_23904c1d);
    [[var_d0b01271]] - > update(params);
  }
}

function_37304ace(localclientnum, menu_name) {
  level endon(#"disconnect");
  level endon(menu_name + "_closed");

  while(true) {
    waitresult = level waittill(#"hash_6d381d5ecca233c6");

    if(isDefined(waitresult.clear_weapon) && waitresult.clear_weapon) {
      level.var_44011752 hide();
      level thread scene::stop(#"scene_frontend_inspection_weapon");
      continue;
    }

    assert(isDefined(waitresult.weapon));
    assert(isDefined(waitresult.attachments));
    assert(isDefined(waitresult.camoindex));
    assert(isDefined(waitresult.paintjobslot));
    assert(isDefined(waitresult.weaponmodelslot));
    level childthread function_daa3f7d0(localclientnum, waitresult, 1);
  }
}

function_daa3f7d0(localclientnum, weaponinfo, should_update_weapon_options = 1) {
  newweaponstring = weaponinfo.weapon;
  var_f020955 = weaponinfo.attachments;
  current_weapon = getweapon(newweaponstring, strtok(var_f020955, "+"));

  if(isDefined(current_weapon) && isDefined(level.var_44011752)) {
    if(level scene::is_playing(#"scene_frontend_inspection_weapon")) {
      level.var_44011752 show();
      level thread scene::stop(#"scene_frontend_inspection_weapon");
    }

    wait 0.1;
    info = function_f2f10929(current_weapon);
    render_options = function_140a6212(weaponinfo.camoindex, 0, weaponinfo.weaponmodelslot, 0, 0, 0);
    level.var_44011752 useweaponmodel(current_weapon, undefined, render_options);
    level.var_44011752 setscale(info.scale);
    level.var_44011752.targetname = "customized_inspection_weapon";
    level.var_44011752 useanimtree("generic");
    position = struct::get(#"tag_align_inspection_weapon1");
    origin = position.origin + info.offset;
    angles = position.angles + info.angles;
    level.var_44011752 thread animation::play(#"hash_3689442490c2e5dd", origin, angles);
    level thread scene::play(#"scene_frontend_inspection_weapon", "inspection_weapon_full");
    level.var_44011752 show();
  }
}

entityspawned(localclientnum) {}

function_c9f8c5e9(localclientnum) {
  var_663588d = "<dev string:x38>";
  var_408e7d77 = -1;

  foreach(i, scene in level.var_e362b5d9) {
    var_2b58d8c0 = "<dev string:x4b>";

    switch (scene.mode) {
      case 2:
        var_2b58d8c0 = "<dev string:x4e>";
        break;
      case 1:
        var_2b58d8c0 = "<dev string:x54>";
        break;
      case 3:
        var_2b58d8c0 = "<dev string:x5a>";
        break;
      case 0:
        var_2b58d8c0 = "<dev string:x60>";
        break;
    }

    var_34415027 = var_663588d + var_2b58d8c0 + scene.prt;
    adddebugcommand(localclientnum, "<dev string:x66>" + var_34415027 + "<dev string:x75>" + i + "<dev string:x9a>");
  }

  while(true) {
    wait 0.1;
    var_879980c4 = getdvarint(#"hash_563d2a49168a665c", -1);

    if(var_879980c4 != var_408e7d77) {
      var_f44acc91 = level.var_e362b5d9[var_879980c4];
      var_d53ddee1 = function_25f808c9(localclientnum, var_f44acc91.mode, var_f44acc91.role_index);

      if(!isDefined(var_d53ddee1)) {
        var_d53ddee1 = character_customization::function_3f5625f1(var_f44acc91.mode, var_f44acc91.role_index);
      }

      level thread function_a71254a9(localclientnum, 1, var_d53ddee1, 0, undefined, 0, var_f44acc91.scene);
      var_408e7d77 = var_879980c4;

      if(level.var_e362b5d9[var_879980c4].scene == #"scene_frontend_zm_elixir_lab" && isDefined(level.var_1a2c5c75)) {
        level thread[[level.var_1a2c5c75]](localclientnum);
        continue;
      }

      level notify(#"hash_79bbc4f96a28b094");
    }
  }
}

function_da10fc8f(localclientnum, imagepath) {
  var_38b900c2 = getent(localclientnum, "<dev string:x9f>", "<dev string:xb6>");
  var_51a0f339 = getent(localclientnum, "<dev string:xc3>", "<dev string:xb6>");
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

function_93ccf33d(var_62d90151, entrytype, &var_37451b86, &var_7f0244ba) {
  foreach(i, item in var_62d90151) {
    entry = {
      #index: i, 
      #type: entrytype, 
      #item: item
    };

    if(isDefined(var_37451b86[item.name])) {
      if(!isDefined(var_37451b86[item.name].options[entrytype])) {
        var_37451b86[item.name].options[entrytype] = [];
      } else if(!isarray(var_37451b86[item.name].options[entrytype])) {
        var_37451b86[item.name].options[entrytype] = array(var_37451b86[item.name].options[entrytype]);
      }

      var_37451b86[item.name].options[entrytype][var_37451b86[item.name].options[entrytype].size] = entry;
      continue;
    }

    if(i != 0) {
      if(!isDefined(var_7f0244ba)) {
        var_7f0244ba = [];
      } else if(!isarray(var_7f0244ba)) {
        var_7f0244ba = array(var_7f0244ba);
      }

      var_7f0244ba[var_7f0244ba.size] = entry;
    }
  }
}

function_23bc6f08(localclientnum, var_d0b01271, itemtype, item_data, mode, character_index, var_b34f01f0) {
  if(item_data.lootid == #"") {
    return;
  }

  switch (itemtype) {
    case 1:
      return;
    case 2:
      shot_name = "<dev string:xda>";
      break;
    case 3:
      shot_name = "<dev string:xe1>";
      break;
    case 7:
      shot_name = "<dev string:xec>";
      break;
    case 6:
      shot_name = "<dev string:xf7>";
      break;
    case 0:
      shot_name = "<dev string:xff>";
      break;
    case 4:
      shot_name = "<dev string:x106>";
      break;
    default:
      shot_name = "<dev string:x10d>";
      break;
  }

  scene_name = #"scene_frontend_character_male_render";

  if(#"female" == getherogender(character_index, mode)) {
    scene_name = #"scene_frontend_character_female_render";
  }

  [[var_d0b01271]] - > update({
    #var_c76f3e47: 1, 
    #var_5bd51249: 8, 
    #var_13fb1841: 4, 
    #scene: scene_name, 
    #scene_shot: shot_name
  });

  do {
    wait 0.5;
  }
  while(![[var_d0b01271]] - > function_ea4ac9f8());

  var_f75a02ea = function_9e72a96(function_b14806c6(character_index, mode));

  if(var_b34f01f0) {
    shot_name = "<dev string:x118>" + var_f75a02ea + "<dev string:x12a>" + function_9e72a96(item_data.lootid) + "<dev string:x12e>";
  } else {
    shot_name = "<dev string:x118>" + var_f75a02ea + "<dev string:x12a>" + function_9e72a96(item_data.lootid) + "<dev string:x148>";
  }

  function_da10fc8f(localclientnum, shot_name);
}

function_2351cba1(itemtype, mode) {
  switch (itemtype) {
    case 1:
      return 0;
    case 0:
    case 2:
    case 3:
    case 4:
    case 5:
    case 6:
      return (mode != 1);
  }

  return 1;
}

function_4920c25a(localclientnum, menu_name, state) {
  self notify("<dev string:x154>");
  self endon("<dev string:x154>");
  function_25485718();
  var_38b900c2 = getent(localclientnum, "<dev string:x9f>", "<dev string:xb6>");
  var_51a0f339 = getent(localclientnum, "<dev string:xc3>", "<dev string:xb6>");
  var_38b900c2 show();
  var_51a0f339 hide();
  args = strtok(state, "<dev string:x167>");
  mode = int(args[0]);
  character_index = int(args[1]);
  outfit_index = int(args[2]);
  var_7823b8b1 = int(args[3]);
  var_d0b01271 = lui::getcharacterdataformenu(menu_name, localclientnum);
  [[var_d0b01271]] - > set_character_mode(mode);
  [[var_d0b01271]] - > set_character_index(character_index);
  [[var_d0b01271]] - > function_22039feb();
  outfitcount = function_d299ef16(character_index, mode);
  var_f750af1d = outfit_index == -1 ? 0 : outfit_index;
  var_f58d84ac = outfit_index == -1 ? outfitcount - 1 : outfit_index;

  for(outfitindex = var_f750af1d; outfitindex <= var_f58d84ac; outfitindex++) {
    var_9cf37283 = function_d7c3cf6c(character_index, outfitindex, mode);
    [[var_d0b01271]] - > set_character_outfit(outfitindex);
    [[var_d0b01271]] - > function_158505aa(outfitindex);

    if(mode == 1 && (var_7823b8b1 == -1 || var_7823b8b1 == 8)) {
      foreach(preset in var_9cf37283.presets) {
        if(preset.isvalid && preset.lootid != #"") {
          [
            [var_d0b01271]
          ] - > function_95779b72();

          foreach(type, option in preset.parts) {
            [
              [var_d0b01271]
            ] - > set_character_outfit_item(option, type);
          }

          function_23bc6f08(localclientnum, var_d0b01271, 8, preset, mode, character_index, 0);

          foreach(option, war_paint in var_9cf37283.options[7]) {
            if(war_paint.name == preset.name) {
              [
                [var_d0b01271]
              ] - > set_character_outfit_item(option, 7);
              break;
            }
          }

          foreach(option, war_paint in var_9cf37283.options[1]) {
            if(war_paint.name == preset.name) {
              [
                [var_d0b01271]
              ] - > set_character_outfit_item(option, 7);
              break;
            }
          }

          function_23bc6f08(localclientnum, var_d0b01271, 8, preset, mode, character_index, 1);
        }
      }
    }

    foreach(type, options in var_9cf37283.options) {
      if(function_2351cba1(type, mode) && (var_7823b8b1 == -1 || var_7823b8b1 == type)) {
        [
          [var_d0b01271]
        ] - > set_character_outfit(outfitindex);
        [
          [var_d0b01271]
        ] - > function_158505aa(outfitindex);

        foreach(i, option in options) {
          [
            [var_d0b01271]
          ] - > function_95779b72();
          [
            [var_d0b01271]
          ] - > set_character_outfit_item(i, type);

          if(type == 7 && mode == 1) {
            var_47e7e198 = undefined;

            foreach(j, palette in var_9cf37283.options[5]) {
              if(palette.name == option.name) {
                var_47e7e198 = j;
                break;
              }
            }

            if(isDefined(var_47e7e198)) {
              [
                [var_d0b01271]
              ] - > set_character_outfit(outfitindex);
              [
                [var_d0b01271]
              ] - > set_character_outfit_item(var_47e7e198, 5);
            } else {
              [
                [var_d0b01271]
              ] - > set_character_outfit(0);
            }
          }

          function_23bc6f08(localclientnum, var_d0b01271, type, option, mode, character_index, 0);
        }
      }
    }
  }

  [[var_d0b01271]] - > function_39a68bf2();
  level notify("<dev string:x16b>" + localclientnum, {
    #menu: "<dev string:x179>", 
    #status: "<dev string:x18e>"
  });
  setdvar(#"char_render", "<dev string:x4b>");
  function_59013397();
}

function_92087f1b(localclientnum) {
  if(getdvarint(#"hash_af3e02adb15e8ec", 0) > 0) {
    level thread function_fb399a61(localclientnum);
    return;
  }

  util::add_devgui(localclientnum, "<dev string:x197>" + "<dev string:x1ae>", "<dev string:x1c0>");
  level thread function_622b5dc0(localclientnum);
}

function_622b5dc0(localclientnum) {
  level endon(#"game_ended");

  while(true) {
    if(getdvarint(#"hash_af3e02adb15e8ec", 0) > 0) {
      util::remove_devgui(localclientnum, "<dev string:x197>" + "<dev string:x1ae>");
      level thread function_fb399a61(localclientnum);
      return;
    }

    wait 1;
  }
}

function_fb399a61(localclientnum) {
  lui::createcustomcameramenu("<dev string:x179>", localclientnum, &function_4920c25a, 1, undefined, undefined, 0);
  lui::linktocustomcharacter("<dev string:x179>", localclientnum, "<dev string:x1e9>");
  target = struct::get(#"character_staging_extracam1");
  assert(isDefined(target));
  var_663588d = "<dev string:x197>";
  var_f4b452be = [1: "<dev string:x20b>", 3: "<dev string:x210>", 0: "<dev string:x215>"];
  var_8d6e963c = ["<dev string:xff>", 2: "<dev string:x21a>", 3: "<dev string:x222>", 4: "<dev string:x106>", 5: "<dev string:x22f>", 6: "<dev string:x23a>", 7: "<dev string:x243>"];

  foreach(mode, display_name in var_f4b452be) {
    var_82414930 = var_663588d + display_name + "<dev string:x12a>";

    for(index = 0; index < getplayerroletemplatecount(mode); index++) {
      var_f75a02ea = function_9e72a96(function_b14806c6(index, mode));
      var_11f96a92 = var_82414930 + var_f75a02ea + "<dev string:x12a>";
      adddebugcommand(localclientnum, "<dev string:x66>" + var_11f96a92 + "<dev string:x250>" + "<dev string:x256>" + "<dev string:x25b>" + "<dev string:x263>" + "<dev string:x167>" + mode + "<dev string:x167>" + index + "<dev string:x167>" + -1 + "<dev string:x167>" + -1 + "<dev string:x271>" + "<dev string:x275>");
      outfitcount = function_d299ef16(index, mode);

      for(outfitindex = 0; outfitindex < outfitcount; outfitindex++) {
        var_9cf37283 = function_d7c3cf6c(index, outfitindex, mode);

        if(var_9cf37283.valid) {
          var_b614b3ba = var_11f96a92 + function_9e72a96(var_9cf37283.namehash) + "<dev string:x12a>";
          adddebugcommand(localclientnum, "<dev string:x66>" + var_b614b3ba + "<dev string:x250>" + "<dev string:x256>" + "<dev string:x25b>" + "<dev string:x263>" + "<dev string:x167>" + mode + "<dev string:x167>" + index + "<dev string:x167>" + outfitindex + "<dev string:x167>" + -1 + "<dev string:x271>" + "<dev string:x275>");

          if(mode == 1) {
            adddebugcommand(localclientnum, "<dev string:x66>" + var_b614b3ba + "<dev string:x279>" + "<dev string:x256>" + "<dev string:x25b>" + "<dev string:x263>" + "<dev string:x167>" + mode + "<dev string:x167>" + index + "<dev string:x167>" + outfitindex + "<dev string:x167>" + 8 + "<dev string:x271>" + "<dev string:x275>");
          }

          foreach(type, name in var_8d6e963c) {
            if(function_2351cba1(type, mode)) {
              adddebugcommand(localclientnum, "<dev string:x66>" + var_b614b3ba + name + "<dev string:x256>" + "<dev string:x25b>" + "<dev string:x263>" + "<dev string:x167>" + mode + "<dev string:x167>" + index + "<dev string:x167>" + outfitindex + "<dev string:x167>" + type + "<dev string:x271>" + "<dev string:x275>");
            }
          }

          waitframe(1);
        }
      }
    }
  }

  setdvar(#"char_render", "<dev string:x4b>");
  var_f7a528f2 = "<dev string:x4b>";

  while(true) {
    wait 0.1;

    if(getdvarstring(#"char_render", var_f7a528f2) != var_f7a528f2) {
      var_f7a528f2 = getdvarstring(#"char_render");

      if(var_f7a528f2 != "<dev string:x4b>") {
        level notify("<dev string:x16b>" + localclientnum, {
          #menu: "<dev string:x179>", 
          #status: "<dev string:x283>", 
          #state: var_f7a528f2
        });
      }
    }
  }
}

function_5d6480a0(localclientnum, weapon, weapon_model, weapon_name, var_2d8a24a3, var_e30bf49f) {
  if(!isDefined(var_e30bf49f)) {
    var_e30bf49f = 0;
  }

  camo_index = var_2d8a24a3.item_index == 0 ? 0 : function_8b51d9d1(hash(var_2d8a24a3.name));
  var_9ce34e01 = var_2d8a24a3.name;

  if(isDefined(camo_index)) {
    activecamoinfo = activecamo::function_ae141bf2(camo_index);

    if(isDefined(activecamoinfo) && activecamoinfo.stages.size > 1) {
      var_3594168e = activecamoinfo.stages[2];

      if(!(isDefined(var_3594168e.disabled) && var_3594168e.disabled)) {
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

    render_options = function_140a6212(camo_index, 0, var_e30bf49f, 0, 0, 0);
    weapon_model useweaponmodel(weapon, undefined, render_options);

    if(isDefined(var_3594168e)) {
      activecamo::function_374e37a0(localclientnum, weapon_model, var_3594168e, level.var_43aac701);
    }

    iteration = 0;

    do {
      wait 0.5;
      iteration++;
    }
    while(!weapon_model isstreamed(8, 4) && iteration < 1);

    wait 2;
    function_da10fc8f(localclientnum, "<dev string:x28c>" + weapon_name + "<dev string:x12a>" + weapon_name + "<dev string:x29e>" + var_9ce34e01 + "<dev string:x148>");
  }
}

function_f2c538de(localclientnum, menu_name, state) {
  self notify("<dev string:x2a2>");
  self endon("<dev string:x2a2>");
  args = strtok(state, "<dev string:x167>");
  weapon_name = args[0];
  camo = int(args[1]);
  var_c58c03de = int(args[2]);
  filter = args[3];
  function_25485718();
  var_38b900c2 = getent(localclientnum, "<dev string:x9f>", "<dev string:xb6>");
  var_51a0f339 = getent(localclientnum, "<dev string:xc3>", "<dev string:xb6>");
  var_38b900c2 show();
  var_51a0f339 hide();
  weapon = getweapon(weapon_name);
  target = struct::get(#"weapon_icon_staging");
  weapon_model = spawn(localclientnum, target.origin, "<dev string:x2b4>");
  weapon_model.targetname = "<dev string:x2c3>";
  weapon_model.angles = target.angles;
  weapon_model sethighdetail();
  weapon_model useweaponmodel(weapon);
  weapon_model setscale(function_8d32e28(weapon));
  level thread scene::play(#"scene_frontend_weapon_camo_render");

  if(camo != -2) {
    options = function_ea647602("<dev string:x2d9>");

    if(camo == -1) {
      start_index = 0;
      end_index = options.size - 1;
    } else {
      start_index = camo;
      end_index = camo;
    }

    for(i = start_index; i <= end_index; i++) {
      var_2d8a24a3 = options[i];

      if(filter != "<dev string:x2e0>") {
        category = function_57411076(var_2d8a24a3.name);

        if(filter == "<dev string:x2e7>") {
          if(category != "<dev string:x2f5>" && category != "<dev string:x2fc>" && category != "<dev string:x303>") {
            continue;
          }
        } else if(category != filter) {
          continue;
        }
      }

      function_5d6480a0(localclientnum, weapon, weapon_model, weapon_name, var_2d8a24a3, 0);
    }
  }

  if(var_c58c03de != 0) {
    if(var_c58c03de == -1) {
      start_index = 1;
      end_index = weapon.var_5b73038c;
    } else {
      start_index = var_c58c03de;
      end_index = var_c58c03de;
    }

    for(i = start_index; i <= end_index; i++) {
      function_5d6480a0(localclientnum, weapon, weapon_model, weapon_name, {
        #item_index: 0, 
        #name: "<dev string:x30a>" + i
      }, i);
    }
  }

  level thread scene::stop(#"scene_frontend_weapon_camo_render");
  level notify("<dev string:x16b>" + localclientnum, {
    #menu: "<dev string:x317>", 
    #status: "<dev string:x18e>"
  });
  weapon_model delete();
  setdvar(#"weap_render", "<dev string:x4b>");
  function_59013397();
}

function_d583ca36(weapon) {
  return weapon.inventorytype == "<dev string:x329>";
}

function_db3c4c69(localclientnum) {
  lui::createcustomcameramenu("<dev string:x317>", localclientnum, &function_f2c538de, 1, undefined, undefined, 0);
  target = struct::get(#"weapon_icon_staging");
  assert(isDefined(target));
  level.var_43aac701 = [];
  var_663588d = "<dev string:x333>";
  root_weapon = var_663588d + "<dev string:x34d>";
  a_weapons = enumerateweapons("<dev string:x360>");

  if(!isDefined(a_weapons)) {
    a_weapons = [];
  }

  a_weapons = array::filter(a_weapons, 1, &function_d583ca36);

  foreach(weapon in a_weapons) {
    name = getweaponname(weapon);
    var_ee63b362 = root_weapon + "<dev string:x12a>" + name;
    adddebugcommand(localclientnum, "<dev string:x66>" + var_ee63b362 + "<dev string:x369>" + "<dev string:x373>" + "<dev string:x167>" + name + "<dev string:x9a>");
  }

  setdvar(#"hash_1311d7636a782655", "<dev string:x4b>");
  setdvar(#"weap_render", "<dev string:x4b>");
  var_c11ba901 = array("<dev string:x2e7>", "<dev string:x2f5>", "<dev string:x2fc>", "<dev string:x303>", "<dev string:x386>", "<dev string:x38f>", "<dev string:x39a>");
  weapon_name = "<dev string:x4b>";
  var_f7a528f2 = "<dev string:x4b>";

  while(true) {
    wait 0.1;

    if(getdvarstring(#"hash_1311d7636a782655", weapon_name) != weapon_name) {
      weapon_name = getdvarstring(#"hash_1311d7636a782655");

      if(weapon_name != "<dev string:x4b>") {
        foreach(weapon in a_weapons) {
          name = getweaponname(weapon);

          if(name != weapon_name) {
            continue;
          }

          var_c001baa1 = var_663588d + "<dev string:x12a>" + name;
          adddebugcommand(localclientnum, "<dev string:x66>" + var_c001baa1 + "<dev string:x3a2>" + "<dev string:x369>" + "<dev string:x3ab>" + "<dev string:x167>" + name + "<dev string:x167>" + -1 + "<dev string:x167>" + -1 + "<dev string:x167>" + "<dev string:x2e0>" + "<dev string:x9a>");

          for(i = 0; i < var_c11ba901.size; i++) {
            type = var_c11ba901[i];
            adddebugcommand(localclientnum, "<dev string:x66>" + var_c001baa1 + "<dev string:x12a>" + type + "<dev string:x3b9>" + 2 + i + "<dev string:x369>" + "<dev string:x3ab>" + "<dev string:x167>" + name + "<dev string:x167>" + -1 + "<dev string:x167>" + -1 + "<dev string:x167>" + type + "<dev string:x9a>");
          }

          options = function_ea647602("<dev string:x2d9>");

          foreach(i, option in options) {
            adddebugcommand(localclientnum, "<dev string:x66>" + var_c001baa1 + "<dev string:x12a>" + option.name + "<dev string:x369>" + "<dev string:x3ab>" + "<dev string:x167>" + name + "<dev string:x167>" + i + "<dev string:x167>" + 0 + "<dev string:x167>" + "<dev string:x2e0>" + "<dev string:x9a>");
          }

          for(i = 1; i < weapon.var_5b73038c; i++) {
            adddebugcommand(localclientnum, "<dev string:x66>" + var_c001baa1 + "<dev string:x3bd>" + i + "<dev string:x369>" + "<dev string:x3ab>" + "<dev string:x167>" + name + "<dev string:x167>" + -2 + "<dev string:x167>" + i + "<dev string:x167>" + "<dev string:x2e0>" + "<dev string:x9a>");
          }
        }
      }
    }

    if(getdvarstring(#"weap_render", var_f7a528f2) != var_f7a528f2) {
      var_f7a528f2 = getdvarstring(#"weap_render");

      if(var_f7a528f2 != "<dev string:x4b>") {
        level notify("<dev string:x16b>" + localclientnum, {
          #menu: "<dev string:x317>", 
          #status: "<dev string:x283>", 
          #state: var_f7a528f2
        });
      }
    }
  }
}

function_3d29f330(localclientnum) {
  util::add_devgui(localclientnum, "<dev string:x3cb>" + "<dev string:x1ae>", "<dev string:x3df>");

  while(getdvarint(#"hash_2a806885aa30e65b", 0) == 0) {
    wait 1;
  }

  util::remove_devgui(localclientnum, "<dev string:x3cb>" + "<dev string:x1ae>");
  function_ea9a5e69(localclientnum);
}

function_671eb8fa() {
  return [1: "<dev string:x406>"];
}

function_ea9a5e69(localclientnum) {
  lui::createcustomcameramenu("<dev string:x40e>", localclientnum, &t10_lasers_mixlaser2_sn_droger, 1, undefined, undefined, 0);
  var_2067e07 = function_671eb8fa();
  adddebugcommand(localclientnum, "<dev string:x66>" + "<dev string:x3cb>" + "<dev string:x421>" + "<dev string:x42e>" + "<dev string:x167>" + -1 + "<dev string:x167>" + -1 + "<dev string:x9a>");

  foreach(type, name in var_2067e07) {
    adddebugcommand(localclientnum, "<dev string:x66>" + "<dev string:x3cb>" + name + "<dev string:x369>" + "<dev string:x42e>" + "<dev string:x167>" + -1 + "<dev string:x167>" + type + "<dev string:x9a>");
  }

  assert(isDefined(getent(localclientnum, "<dev string:x43f>", "<dev string:xb6>")));
  assert(isDefined(struct::get(#"fx_trail_start")));
  assert(isDefined(struct::get(#"fx_trail_end")));
  jumpkits = namespace_eb06e24d::get_jumpkits();

  foreach(i, jumpkit in jumpkits) {
    name = function_9e72a96(jumpkit);
    markswarzone = "<dev string:x3cb>" + name + "<dev string:x12a>";
    adddebugcommand(localclientnum, "<dev string:x66>" + markswarzone + "<dev string:x250>" + "<dev string:x369>" + "<dev string:x42e>" + "<dev string:x167>" + i + "<dev string:x167>" + -1 + "<dev string:x9a>");

    foreach(type, name in var_2067e07) {
      adddebugcommand(localclientnum, "<dev string:x66>" + markswarzone + name + "<dev string:x369>" + "<dev string:x42e>" + "<dev string:x167>" + i + "<dev string:x167>" + type + "<dev string:x9a>");
    }

    waitframe(1);
  }

  setdvar(#"hash_4243dd01393aa940", "<dev string:x4b>");
  var_f7a528f2 = "<dev string:x4b>";

  while(true) {
    wait 0.1;

    if(getdvarstring(#"hash_4243dd01393aa940", var_f7a528f2) != var_f7a528f2) {
      var_f7a528f2 = getdvarstring(#"hash_4243dd01393aa940");

      if(var_f7a528f2 != "<dev string:x4b>") {
        level notify("<dev string:x16b>" + localclientnum, {
          #menu: "<dev string:x40e>", 
          #status: "<dev string:x283>", 
          #state: var_f7a528f2
        });
      }
    }
  }
}

t10_lasers_mixlaser2_sn_droger(localclientnum, menu_name, state) {
  self notify("<dev string:x44f>");
  self endon("<dev string:x44f>");
  args = strtok(state, "<dev string:x167>");
  jumpkit = int(args[0]);
  type = int(args[1]);
  function_25485718();
  var_38b900c2 = getent(localclientnum, "<dev string:x9f>", "<dev string:xb6>");
  var_51a0f339 = getent(localclientnum, "<dev string:xc3>", "<dev string:xb6>");
  var_38b900c2 show();
  var_51a0f339 hide();

  if(jumpkit == -1) {
    var_d4e4e3a8 = 0;
    var_dcb0ef67 = namespace_eb06e24d::function_3045dd71() - 1;
  } else {
    var_d4e4e3a8 = jumpkit;
    var_dcb0ef67 = jumpkit;
  }

  types = function_671eb8fa();

  if(type != -1) {
    type_data = types[type];
    types = [];
    types[type] = type_data;
  }

  var_351da865 = getent(localclientnum, "<dev string:x43f>", "<dev string:xb6>");
  fx_start = struct::get(#"fx_trail_start");
  fx_end = struct::get(#"fx_trail_end");

  foreach(type, type_name in types) {
    switch (type) {
      case 1:
        level thread scene::play(#"scene_frontend_fxtrail_render");
        break;
      default:
        continue;
    }

    for(i = var_d4e4e3a8; i <= var_dcb0ef67; i++) {
      kit_name = namespace_eb06e24d::get_jumpkits()[i];

      switch (type) {
        case 1:
          trail = namespace_eb06e24d::function_6452f9c5(i);

          if(!isDefined(trail) || !isDefined(trail.body_trail)) {
            continue;
          }

          var_351da865.origin = fx_start.origin;
          handle = util::playFXOnTag(localclientnum, trail.body_trail, var_351da865, "<dev string:x462>");

          if(!isDefined(handle)) {
            continue;
          }

          direction = fx_end.origin - fx_start.origin;
          step_size = direction / getdvarint(#"hash_522e5987825dd16e", 100);

          for(var_d7f46807 = 0; var_d7f46807 <= getdvarint(#"hash_522e5987825dd16e", 100); var_d7f46807++) {
            waitframe(1);
            var_351da865.origin += step_size;
          }

          function_da10fc8f(localclientnum, "<dev string:x46f>" + function_9e72a96(kit_name) + "<dev string:x12a>" + function_9e72a96(trail.name) + "<dev string:x482>");
          killfx(localclientnum, handle);
          break;
        default:
          continue;
      }

      waitframe(1);
    }

    switch (type) {
      case 1:
        level thread scene::stop(#"scene_frontend_fxtrail_render");
      default:
        break;
    }
  }

  level notify("<dev string:x16b>" + localclientnum, {
    #menu: "<dev string:x40e>", 
    #status: "<dev string:x18e>"
  });
  setdvar(#"hash_4243dd01393aa940", "<dev string:x4b>");
  function_59013397();
}

function_70e963be(entry, localclientnum) {
  if(entry.mode == 3 && isDefined(localclientnum)) {
    customization = function_25f808c9(localclientnum, entry.mode, entry.role_index);

    if(isDefined(customization) && isDefined(customization.locked) && customization.locked) {
      return 0;
    }
  }

  if(isDefined(entry.dvar) && !getdvarint(entry.dvar, 0)) {
    return 0;
  }

  return entry.canselect;
}

function_3dc16db1(mode, index) {
  foreach(var_dea538a3 in level.var_e362b5d9) {
    if(var_dea538a3.mode == mode && var_dea538a3.role_index == index) {
      return var_dea538a3.list_index;
    }
  }
}

function_4a6953b8() {
  selectable = array::filter(level.var_e362b5d9, 0, &function_70e963be);

  foreach(var_dea538a3 in selectable) {
    if(var_dea538a3.mode == 0) {
      return var_dea538a3.list_index;
    }
  }
}

function_31a3348c(session_mode) {
  selectable = array::filter(level.var_e362b5d9, 0, &function_70e963be);
  var_e362b5d9 = [];

  foreach(var_dea538a3 in selectable) {
    if(var_dea538a3.mode == session_mode) {
      var_e362b5d9[var_e362b5d9.size] = var_dea538a3.list_index;
    }
  }

  if(var_e362b5d9.size > 0) {
    return array::random(var_e362b5d9);
  }
}

function_deed1dbf(localclientnum) {
  var_b4a66a1f = util::spawn_model(localclientnum, "tag_origin", (0, 0, 0), (0, 0, 0));
  var_b4a66a1f.targetname = "frozen_moment_character";
  level.frozen_moment_character = character_customization::function_dd295310(var_b4a66a1f, localclientnum, 1);
  var_e7eccf53 = util::spawn_model(localclientnum, "tag_origin", (0, 0, 0), (0, 0, 0));
  var_e7eccf53.targetname = "cycle_frozen_moment_char_current";
  level.cycle_frozen_moment_char_current = character_customization::function_dd295310(var_e7eccf53, localclientnum, 1);
  var_354d3ff2 = util::spawn_model(localclientnum, "tag_origin", (0, 0, 0), (0, 0, 0));
  var_354d3ff2.targetname = "cycle_frozen_moment_char_next";
  level.cycle_frozen_moment_char_next = character_customization::function_dd295310(var_354d3ff2, localclientnum, 1);
  attempts = 0;
  limit = 20;

  do {
    wait 1;
    var_ca56648b = function_3d72f7e7(localclientnum);
    attempts += 1;
  }
  while(var_ca56648b == 0 && attempts < limit);

  selectable = array::filter(level.var_e362b5d9, 0, &function_70e963be, localclientnum);

  if(selectable.size == 0) {
    println("<dev string:x489>");
    selectable = level.var_e362b5d9;
  }

  if(var_ca56648b == 1) {
    foreach(entry in selectable) {
      if(entry.isdefault) {
        var_d6895424 = entry;
        break;
      }
    }
  }

  if(!isDefined(var_d6895424)) {
    scenes = [];

    foreach(moment in selectable) {
      if(!isDefined(scenes[moment.scene])) {
        scenes[moment.scene] = [];
      } else if(!isarray(scenes[moment.scene])) {
        scenes[moment.scene] = array(scenes[moment.scene]);
      }

      if(!isinarray(scenes[moment.scene], moment)) {
        scenes[moment.scene][scenes[moment.scene].size] = moment;
      }
    }

    var_d6895424 = array::random(array::random(scenes));
  }

  override_scene = getdvarint(#"hash_563d2a49168a665c", -1);

  if(override_scene >= 0 && override_scene < level.var_e362b5d9.size) {
    var_d6895424 = level.var_e362b5d9[override_scene];
  }

  level.var_be02eda3 = var_d6895424.list_index;
  level.var_7208b551 = var_d6895424.scene;

  level thread function_c9f8c5e9(localclientnum);

  forcestreambundle(level.var_7208b551, 8, 4);
}

function_becded4f(localclientnum) {
  level.var_44011752 = util::spawn_model(localclientnum, #"wpn_t8_ar_accurate_prop_animate", (0, 0, 0), (0, 0, 0));
  level.var_44011752.targetname = "customized_inspection_weapon";
  level.var_44011752 hide();
}

function_a588eb2e(localclientnum) {
  var_e6977977 = util::spawn_model(localclientnum, #"wpn_t8_ar_accurate_prop_animate", (0, 0, 0), (0, 0, 0));
  var_e6977977.targetname = "quartermaster_weapon";
  var_e6977977 hide();
  var_e6977977 sethighdetail(1, 1);
  level.var_324c3190 = [];
}

localclientconnect(localclientnum) {
  println("<dev string:x4df>" + localclientnum);
  var_acd4d941 = util::spawn_model(localclientnum, "tag_origin", (0, 0, 0), (0, 0, 0));
  var_acd4d941.targetname = "__masked_char";
  var_22f20461 = character_customization::function_dd295310(var_acd4d941, localclientnum, 0);
  [[var_22f20461]] - > function_1ec9448d(1);
  [[var_22f20461]] - > update();
  level.specialist_customization = function_f2e7abdc(localclientnum, "updateSpecialistCustomization");
  level thread scene::play(#"scene_frontend_inspection_weapon", "inspection_weapon_full");
  function_becded4f(localclientnum);
  function_a588eb2e(localclientnum);
  setupclientmenus(localclientnum);
  level thread function_f00ff0c7(localclientnum);
  level thread function_deed1dbf(localclientnum);

  if(isDefined(level.charactercustomizationsetup)) {
    [[level.charactercustomizationsetup]](localclientnum);
  }

  if(isDefined(level.weaponcustomizationiconsetup)) {
    [[level.weaponcustomizationiconsetup]](localclientnum);
  }

  callback::callback(#"on_localclient_connect", localclientnum);
  customclass::localclientconnect(localclientnum);
  customclass::hide_paintshop_bg(localclientnum);
  globalmodel = getglobaluimodel();
  roommodel = createuimodel(globalmodel, "lobbyRoot.room");
  room = getuimodelvalue(roommodel);
  postfx::setfrontendstreamingoverlay(localclientnum, "frontend", 1);
  level.frontendclientconnected = 1;
  level notify("menu_change" + localclientnum, {
    #menu: "Main", 
    #status: "opened", 
    #state: room
  });

  level function_92087f1b(localclientnum);
  level thread function_db3c4c69(localclientnum);
  level thread function_3d29f330(localclientnum);
}

onprecachegametype() {}

onstartgametype() {}

open_choose_class(localclientnum, menu_data) {
  level thread character_customization::rotation_thread_spawner(localclientnum, menu_data.custom_character, "choose_class_closed" + localclientnum);
}

close_choose_class(localclientnum, menu_data) {
  enablefrontendlockedweaponoverlay(localclientnum, 0);
  enablefrontendtokenlockedweaponoverlay(localclientnum, 0);
  level notify("choose_class_closed" + localclientnum);
}

function_d3cd6cf7(localclientnum, var_d0b01271, waitresult, params) {
  fields = [[var_d0b01271]] - > function_e8b0acef();

  if(isDefined(fields)) {
    params.scene = fields.hubscene;
    params.var_401d9a1 = 1;
    params.var_c76f3e47 = 1;
    params.var_d8cb38a9 = 1;

    if(lui::is_current_menu(localclientnum, "ItemShopDetails") || lui::is_current_menu(localclientnum, "ItemShopDetailsSunset") || lui::is_current_menu(localclientnum, "QuarterMasterMenu") || lui::is_current_menu(localclientnum, "ContractDetails") || lui::is_current_menu(localclientnum, "ContractDetailsSunset") || lui::is_current_menu(localclientnum, "BlackMarketBountyDetails") || lui::is_current_menu(localclientnum, "WeaponBribeSelection")) {
      params.scene_target = struct::get(#"tag_align_quartermaster");
      params.anim_name = [
        [var_d0b01271]
      ] - > function_8144231c();
      params.align_struct = struct::get(#"tag_align_quartermaster_character");
      params.scene = undefined;
      return;
    }

    if(lui::is_current_menu(localclientnum, "PersonalizeDefaultWZCharacter") || lui::is_current_menu(localclientnum, "WZPersonalizeCharacter")) {
      params.scene = fields.var_bb70c379;
      params.scene_target = struct::get(#"cac_specialist");
      return;
    }

    if(lui::is_current_menu(localclientnum, "PersonalizeCharacter") || lui::is_current_menu(localclientnum, "WZPersonalizeCharacterInspect")) {
      params.scene_target = struct::get(#"cac_specialist");
      params.scene = fields.var_bb70c379;
      params.var_f5332569 = [
        [var_d0b01271]
      ] - > function_98d70bef();
      return;
    }

    if(lui::is_current_menu(localclientnum, "ZMPersonalizeCharacter")) {
      params.scene_target = struct::get(#"cac_specialist");
      params.scene = fields.var_bb70c379;
      return;
    }

    if(lui::is_current_menu(localclientnum, "AARMissionRewardOverlay", waitresult.character_index)) {
      params.scene = fields.var_be6ea125;
      params.scene_target = struct::get(#"wz_unlock_struct");
      return;
    }

    if(lui::is_current_menu(localclientnum, "MPSpecialistHUBGestures")) {
      params.anim_name = [
        [var_d0b01271]
      ] - > function_8144231c();
      params.align_struct = struct::get(#"cac_specialist");
      params.scene = undefined;
      return;
    }

    if(lui::is_current_menu(localclientnum, "WeaponDeathFxSelect")) {
      params.anim_name = [
        [var_d0b01271]
      ] - > function_8144231c();
      params.align_struct = struct::get(#"cac_specialist");
      params.scene = undefined;
      return;
    }

    params.scene_target = struct::get(#"cac_specialist");
  }
}

function_f2e7abdc(localclientnum, notifyname) {
  var_20e9ec07 = struct::get(#"cac_specialist");

  if(isDefined(var_20e9ec07)) {
    specialistmodel = util::spawn_model(localclientnum, "tag_origin", var_20e9ec07.origin, var_20e9ec07.angles);
    specialistmodel.targetname = "specialist_customization";
    var_f3b86f32 = character_customization::function_dd295310(specialistmodel, localclientnum, 0);
    [[var_f3b86f32]] - > set_character_mode(1);
    level thread character_customization::updateeventthread(localclientnum, var_f3b86f32, notifyname, &function_d3cd6cf7);
    return var_f3b86f32;
  }

  return undefined;
}

open_character_menu(localclientnum, menu_data) {
  character_ent = getent(localclientnum, menu_data.target_name, "targetname");

  if(isDefined(character_ent)) {
    character_ent show();
  }
}

close_character_menu(localclientnum, menu_data) {
  character_ent = getent(localclientnum, menu_data.target_name, "targetname");

  if(isDefined(character_ent)) {
    character_ent hide();
  }
}

start_character_rotating_any(localclientnum, menu_data) {
  maxlocalclient = getmaxlocalclients();

  while(localclientnum < maxlocalclient) {
    start_character_rotating(localclientnum, menu_data);
    localclientnum++;
  }
}

end_character_rotating_any(localclientnum, menu_data) {
  maxlocalclient = getmaxlocalclients();

  while(localclientnum < maxlocalclient) {
    end_character_rotating(localclientnum, menu_data);
    localclientnum++;
  }
}

start_character_rotating(localclientnum, menu_data) {
  level thread character_customization::rotation_thread_spawner(localclientnum, menu_data.custom_character, "end_character_rotating" + localclientnum);
}

end_character_rotating(localclientnum, menu_data) {
  level notify("end_character_rotating" + localclientnum);
}

open_choose_head_menu(localclientnum, menu_data) {
  [[menu_data.custom_character]] - > set_show_helmets(0);
  [[menu_data.custom_character]] - > function_79f89fb6(1);
  [[menu_data.custom_character]] - > set_character_mode(2);
  [[menu_data.custom_character]] - > function_225b6e07();
  [[menu_data.custom_character]] - > function_77e3be08();
  [[menu_data.custom_character]] - > update();
  start_character_rotating(localclientnum, menu_data);
  level notify(#"begin_personalizing_hero");
}

close_choose_head_menu(localclientnum, menu_data) {
  if(!isDefined(menu_data.custom_character.charactermode) || menu_data.custom_character.charactermode == 4) {
    menu_data.custom_character.charactermode = currentsessionmode();
  }

  [[menu_data.custom_character]] - > set_show_helmets(1);
  [[menu_data.custom_character]] - > function_79f89fb6(0);
  end_character_rotating(localclientnum, menu_data);
  level notify(#"done_personalizing_hero");
}

personalize_characters_watch(localclientnum, menu_name) {
  level endon(#"disconnect");
  level endon(menu_name + "_closed");
  s_cam = struct::get(#"personalizehero_camera", "targetname");
  assert(isDefined(s_cam));

  for(animtime = 0; true; animtime = 300) {
    waitresult = level waittill("camera_change" + localclientnum);
    pose = waitresult.pose;

    if(pose === "exploring") {
      playmaincamxcam(localclientnum, #"ui_cam_character_customization", animtime, "cam_preview", "", s_cam.origin, s_cam.angles);
      continue;
    }

    if(pose === "inspecting_helmet") {
      playmaincamxcam(localclientnum, #"ui_cam_character_customization", animtime, "cam_helmet", "", s_cam.origin, s_cam.angles);
      continue;
    }

    if(pose === "inspecting_body") {
      playmaincamxcam(localclientnum, #"ui_cam_character_customization", animtime, "cam_select", "", s_cam.origin, s_cam.angles);
    }
  }
}

function_d9a44ae1(localclientnum, menu_name) {
  level endon(#"disconnect");
  level endon(menu_name + "_closed");
  s_cam = struct::get(#"spawn_char_custom", "targetname");
  assert(isDefined(s_cam));
  playmaincamxcam(localclientnum, #"ui_cam_character_customization", 0, "cam_helmet", "", s_cam.origin, s_cam.angles);

  while(true) {
    waitresult = level waittill("choose_face_camera_change" + localclientnum);
    region = waitresult.param1;

    if(region === "face") {
      playmaincamxcam(localclientnum, #"ui_cam_character_customization", 300, "cam_helmet", "", s_cam.origin, s_cam.angles);
      continue;
    }

    if(region === "eyes") {
      playmaincamxcam(localclientnum, #"ui_cam_character_customization", 300, "cam_eyes", "", s_cam.origin, s_cam.angles);
      continue;
    }

    if(region === "ears") {
      playmaincamxcam(localclientnum, #"ui_cam_character_customization", 300, "cam_ears", "", s_cam.origin, s_cam.angles);
      continue;
    }

    if(region === "nose") {
      playmaincamxcam(localclientnum, #"ui_cam_character_customization", 300, "cam_nose", "", s_cam.origin, s_cam.angles);
      continue;
    }

    if(region === "mouth") {
      playmaincamxcam(localclientnum, #"ui_cam_character_customization", 300, "cam_mouth", "", s_cam.origin, s_cam.angles);
    }
  }
}

choose_taunts_camera_watch(localclientnum, menu_name) {
  s_cam = struct::get(#"personalizehero_camera", "targetname");
  assert(isDefined(s_cam));
  playmaincamxcam(localclientnum, #"ui_cam_character_customization", 300, "cam_topscorers", "", s_cam.origin, s_cam.angles);
  var_d0b01271 = lui::getcharacterdataformenu(menu_name, localclientnum);
  [[var_d0b01271]] - > function_4240a39a(1, (0, 112, 0));
  level waittill(menu_name + "_closed");
  params = {
    #anim_name: [[var_d0b01271]] - > function_8144231c()
  };
  [[var_d0b01271]] - > update(params);
  [[var_d0b01271]] - > function_4240a39a(0, undefined);
  playmaincamxcam(localclientnum, #"ui_cam_character_customization", 300, "cam_preview", "", s_cam.origin, s_cam.angles);
  wait 3;
}

function_b0442428(var_ce754e62, var_3f0e790b) {
  if(isDefined(var_ce754e62) && isDefined(var_ce754e62[var_3f0e790b])) {
    foreach(object in var_ce754e62[var_3f0e790b]) {
      var_2d0192e5 = [
        [object.character]
      ] - > function_82e05d64();

      if(isDefined(var_2d0192e5) && isDefined(var_2d0192e5.entnummodel)) {
        setuimodelvalue(var_2d0192e5.entnummodel, [
          [object.character]
        ] - > function_47cb6b19());
      }
    }
  }
}

function_f5eca51d(var_ce754e62, var_3f0e790b) {
  if(isDefined(var_ce754e62) && isDefined(var_ce754e62[var_3f0e790b])) {
    foreach(object in var_ce754e62[var_3f0e790b]) {
      var_2d0192e5 = [
        [object.character]
      ] - > function_82e05d64();

      if(isDefined(var_2d0192e5) && isDefined(var_2d0192e5.entnummodel)) {
        setuimodelvalue(var_2d0192e5.entnummodel, -1);
      }
    }
  }
}

function_eb297e19(var_23904c1d) {
  level.var_ff851224 = var_23904c1d;
  var_6d8e8e31 = function_3dc16db1(var_23904c1d.charactermode, var_23904c1d.charactertype);

  if(isDefined(var_6d8e8e31)) {
    var_53511779 = level.var_e362b5d9[var_6d8e8e31].scene;

    if(isDefined(level.var_c37ccfec) && level.var_c37ccfec != var_53511779) {
      function_66b6e720(level.var_c37ccfec);
    } else {
      forcestreambundle(var_53511779, 1, 1);
    }

    level.var_c37ccfec = var_53511779;
  }
}

function_f00765ad(localclientnum, xuid, ccobject, index, var_3f0e790b) {
  level endon(#"lobby_change");
  session_mode = 1;
  force_update = 0;
  iterations = 0;
  var_a65df30 = [[ccobject]] - > function_e599283f();
  current_index = [[ccobject]] - > get_character_index();
  [[ccobject]] - > show_model();
  [[ccobject]] - > set_xuid(xuid);
  [[ccobject]] - > set_character_mode(session_mode);
  var_23904c1d = getcharactercustomizationforxuid(localclientnum, xuid);

  while(!isDefined(var_23904c1d) && iterations < 15) {
    wait 1;
    var_23904c1d = getcharactercustomizationforxuid(localclientnum, xuid);
    iterations++;
  }

  if(isDefined(var_23904c1d) && var_23904c1d.charactermode == currentsessionmode() && function_b9f8bbd9(var_23904c1d.charactertype, var_23904c1d.charactermode)) {
    var_4865db3b = var_23904c1d.charactertype;
    fields = getcharacterfields(var_23904c1d.charactertype, var_23904c1d.charactermode);
  } else {
    var_23904c1d = undefined;
    var_4865db3b = function_e3efec59(xuid, session_mode);
    character_index = var_4865db3b;
    [[ccobject]] - > set_character_index(character_index);

    if(isDefined(character_index)) {
      fields = getcharacterfields(character_index, session_mode);
    }
  }

  var_8e0277a = undefined;

  if(isDefined(fields)) {
    scenes = function_b7d4bfd9(fields, var_3f0e790b);

    if(isDefined(scenes)) {
      var_8e0277a = scenes[index % scenes.size].scene;
    }
  }

  if(isDefined(var_8e0277a)) {
    params = {
      #scene: var_8e0277a, 
      #scene_target: self, 
      #var_a34c858c: 1, 
      #var_c76f3e47: 1, 
      #var_401d9a1: 1
    };

    if(isDefined(var_23904c1d)) {
      if(function_89e574c(xuid)) {
        function_eb297e19(var_23904c1d);
      }

      if(character_customization::function_aa5382ed(var_23904c1d, var_a65df30, 0)) {
        [
          [ccobject]
        ] - > function_15a8906a(var_23904c1d);
        [
          [ccobject]
        ] - > update(params);
      }
    } else {
      [
        [ccobject]
      ] - > set_character_index(character_index);
      [
        [ccobject]
      ] - > function_22039feb();
    }
  }

  if(!isDefined(var_23904c1d) && current_index != var_4865db3b) {
    var_7f40501d = undefined;
    var_44cf5e5b = getcharacterfields(var_4865db3b, session_mode);

    if(isDefined(var_44cf5e5b)) {
      default_scenes = function_b7d4bfd9(var_44cf5e5b, var_3f0e790b);

      if(isDefined(default_scenes)) {
        var_7f40501d = default_scenes[index % default_scenes.size].scene;
      }
    }

    if(isDefined(var_7f40501d)) {
      var_cb498604 = {
        #scene: var_7f40501d, 
        #scene_target: self, 
        #var_a34c858c: 1, 
        #var_c76f3e47: 1, 
        #var_401d9a1: 1
      };
    } else {
      var_cb498604 = {
        #anim_name: [
          [ccobject]
        ] - > function_8144231c()
      };
    }

    force_update = 1;
    [[ccobject]] - > update(var_cb498604);

    if(function_89e574c(xuid)) {
      function_eb297e19([
        [ccobject]
      ] - > function_e599283f());
    }
  }

  draft::function_e1f85a64(ccobject, index, var_3f0e790b);
}

function_7c77108d(localclientnum, &var_13ef9467, var_63aea26e) {
  for(i = 0; true; i++) {
    target = struct::get(var_63aea26e + i);

    if(!isDefined(target)) {
      break;
    }

    charactermodel = util::spawn_model(localclientnum, "tag_origin", target.origin, target.angles);
    charactermodel.targetname = var_63aea26e + "character_" + i;
    var_a4fe2697 = character_customization::function_dd295310(charactermodel, localclientnum, 0);
    var_ac2e02ac = {
      #target: target, 
      #character: var_a4fe2697, 
      #scene_name: undefined
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

function_4fc36b1a(localclientnum, xuid) {
  if(!isDefined(level.var_4c6f850d)) {
    level.var_4c6f850d = [];
  }

  var_d53ddee1 = function_f03f5d4e(localclientnum, xuid, 1);

  if(isDefined(var_d53ddee1)) {
    if(character_customization::function_aa5382ed(var_d53ddee1, level.var_4c6f850d[xuid], 0)) {
      if(function_9bed6a71(localclientnum, 1) == xuid && isDefined(level.var_47863282) && xuid == level.var_47863282 && !(isDefined(level.var_c8fac6ea) && level scene::is_playing(level.var_c8fac6ea))) {
        function_a71254a9(localclientnum, 0, undefined, 1);
        [
          [level.cycle_frozen_moment_char_current]
        ] - > function_39a68bf2();
        stopmaincamxcam(localclientnum);
        function_e56abdb(localclientnum, 1);
      }
    }

    level.var_4c6f850d[xuid] = var_d53ddee1;
  }
}

function_ce0c92c1(localclientnum, var_dde5862c) {
  if(isDefined(var_dde5862c)) {
    level.var_e8250c7b = var_dde5862c;

    if(isDefined(level.var_4c6f850d)) {
      var_19b413e2 = level.var_4c6f850d;
      var_375e4c88 = [];
      var_8632c0a1 = [];

      foreach(xuid, data in var_19b413e2) {
        if(array::contains(var_dde5862c, xuid)) {
          var_375e4c88[xuid] = data;
        }
      }

      level.var_4c6f850d = var_375e4c88;
    }

    if(isDefined(level.var_4c6f850d)) {
      if(isDefined(level.var_47863282) && !array::contains(getarraykeys(level.var_4c6f850d), level.var_47863282)) {
        level.var_37fcc91f = undefined;

        if([
            [level.cycle_frozen_moment_char_next]
          ] - > function_ea4ac9f8()) {
          level notify(#"hash_5661859119127749");
        } else {
          level notify(#"hash_4cfb73b5657634d1");
          function_a71254a9(localclientnum, 0, undefined, 1);
          [
            [level.cycle_frozen_moment_char_current]
          ] - > function_39a68bf2();
          stopmaincamxcam(localclientnum);
          level.var_494e824d = 0;
          function_6e9fbb54(localclientnum);
        }
      }

      if(isDefined(level.var_202758dc) && !array::contains(getarraykeys(level.var_4c6f850d), level.var_202758dc)) {
        level.var_37fcc91f = undefined;
        level.var_3cea0f38 = 0;
        level notify(#"hash_1ac908ea1013c378");
        [
          [level.cycle_frozen_moment_char_next]
        ] - > function_39a68bf2();
        function_6e9fbb54(localclientnum, function_9bed6a71(localclientnum, 1));
      }
    }
  }
}

function_79b4e640(localclientnum) {
  self notify("514e2d4456d495c3");
  self endon("514e2d4456d495c3");
  level endon(#"hash_73b4088ba8bf09ca");
  level endon(#"hash_4cfb73b5657634d1");

  while(true) {
    level waittill(#"hash_5661859119127749");

    if(isDefined(level.var_202758dc) && isDefined(level.var_723bf922)) {
      function_a71254a9(localclientnum, 0, undefined, 1);
      var_2c72511b = [
        [level.cycle_frozen_moment_char_current]
      ] - > get_character_index();
      var_f5bfdfe7 = [
        [level.cycle_frozen_moment_char_next]
      ] - > get_character_index();
      temp = level.cycle_frozen_moment_char_current;
      level.cycle_frozen_moment_char_current = level.cycle_frozen_moment_char_next;
      level.cycle_frozen_moment_char_next = temp;
      [
        [level.cycle_frozen_moment_char_next]
      ] - > function_39a68bf2();
      stopmaincamxcam(localclientnum);
      level.var_47863282 = level.var_202758dc;
      level.var_3cea0f38 = 0;

      if(isDefined(level.var_4c6f850d) && isDefined(level.var_4c6f850d[level.var_47863282])) {
        scene_shots = scene::get_all_shot_names(level.var_723bf922, undefined, 1);
        scene_shot = array::random(scene_shots);
        function_a71254a9(localclientnum, 1, level.var_4c6f850d[level.var_47863282], 0, scene_shot, var_2c72511b == var_f5bfdfe7);
      } else {
        level.var_494e824d = 0;
      }

      function_6e9fbb54(localclientnum);
    }
  }
}

function_6e9fbb54(localclientnum, var_baeecec7 = undefined) {
  level endon(#"hash_73b4088ba8bf09ca");
  level endon(#"hash_1ac908ea1013c378");

  if(!(isDefined(level.var_494e824d) && level.var_494e824d) && isDefined(level.var_4c6f850d) && level.var_4c6f850d.size > 0 && lui::is_current_menu(localclientnum, "Main", "matchmaking")) {
    level.var_47863282 = function_9bed6a71(localclientnum, 1);

    if(!isDefined(level.var_4c6f850d[level.var_47863282])) {
      return;
    }

    level.var_494e824d = 1;
    fbc = getuimodel(getglobaluimodel(), "lobbyRoot.fullscreenBlackCount");
    setuimodelvalue(fbc, 1);
    character_index = level.var_4c6f850d[level.var_47863282].charactertype;
    var_6d8e8e31 = function_3dc16db1(1, character_index);
    var_53511779 = level.var_e362b5d9[var_6d8e8e31].scene;
    forcestreambundle(var_53511779);
    params = {
      #var_c76f3e47: 1, 
      #var_d8cb38a9: 1, 
      #var_8d3b5f69: 1
    };
    [[level.cycle_frozen_moment_char_current]] - > function_15a8906a(level.var_4c6f850d[level.var_47863282]);
    [[level.cycle_frozen_moment_char_current]] - > update(params);

    while(![
        [level.cycle_frozen_moment_char_current]
      ] - > function_ea4ac9f8()) {
      wait 0.1;
    }

    if(isDefined(level.var_4c6f850d) && isDefined(level.var_4c6f850d[level.var_47863282])) {
      level.var_37fcc91f = "play";
      function_a71254a9(localclientnum, 1, level.var_4c6f850d[level.var_47863282]);
      level thread function_79b4e640(localclientnum);
    } else {
      level.var_494e824d = 1;
      level.var_47863282 = undefined;
      return;
    }
  }

  if(!(isDefined(level.var_3cea0f38) && level.var_3cea0f38) && isDefined(level.var_4c6f850d) && level.var_4c6f850d.size > 1 && level.var_e8250c7b.size > 1) {
    level.var_3cea0f38 = 1;

    while(![
        [level.cycle_frozen_moment_char_current]
      ] - > function_ea4ac9f8()) {
      wait 0.1;
    }

    if(isDefined(var_baeecec7)) {
      level.var_202758dc = var_baeecec7;
    } else {
      var_e8250c7b = level.var_e8250c7b;
      var_b08af46e = [];
      var_b08af46e[0] = level.var_47863282;
      var_e8250c7b = array::exclude(var_e8250c7b, var_b08af46e);

      do {
        if(var_e8250c7b.size == 0) {
          break;
        }

        level.var_202758dc = array::random(var_e8250c7b);
        var_b08af46e[0] = level.var_202758dc;
        var_e8250c7b = array::exclude(var_e8250c7b, var_b08af46e);
      }
      while(!isDefined(level.var_4c6f850d[level.var_202758dc]));
    }

    if(isDefined(level.var_202758dc) && isDefined(level.var_4c6f850d[level.var_202758dc])) {
      character_index = level.var_4c6f850d[level.var_202758dc].charactertype;
      var_6d8e8e31 = function_3dc16db1(1, character_index);
      next_scene = level.var_e362b5d9[var_6d8e8e31].scene;

      if(isDefined(level.var_723bf922)) {
        if(level.var_723bf922 != next_scene) {
          function_66b6e720(level.var_723bf922);
        }
      }

      level.var_723bf922 = next_scene;

      while(isDefined(level.var_723bf922) && !forcestreambundle(level.var_723bf922)) {
        wait 0.1;
      }

      if(isDefined(level.var_723bf922)) {
        params = {
          #var_c76f3e47: 1, 
          #var_d8cb38a9: 1, 
          #var_8d3b5f69: 1
        };
        [
          [level.cycle_frozen_moment_char_next]
        ] - > function_15a8906a(level.var_4c6f850d[level.var_202758dc]);
        [
          [level.cycle_frozen_moment_char_next]
        ] - > update(params);
      }

      return;
    }

    level.var_3cea0f38 = 0;
  }
}

function_f00ff0c7(localclientnum) {
  level endon(#"disconnect");
  var_11302f48 = createuimodel(getglobaluimodel(), "LobbyClientPose");
  level.var_6f1da91a = [[], 
    []];
  var_6aeec2ad = getdvarstring(#"hash_52abdac1a234fa29", "");
  var_c7581878 = function_7c77108d(localclientnum, level.var_6f1da91a[0], "lobby_player" + var_6aeec2ad + "_");
  var_c7581878 = max(function_7c77108d(localclientnum, level.var_6f1da91a[1], "arena_player_"), var_c7581878);
  level.var_90fa1c3e = var_c7581878;

  while(true) {
    waitresult = level waittill(#"lobby_change");

    if(level.lastlobbystate === "matchmaking" || level.lastlobbystate === "zm_online" || level.lastlobbystate === #"lobby_pose") {
      var_68a9a63c = function_664bca26(localclientnum, 1, 0, 1);
    } else {
      var_68a9a63c = function_77ccb73(1, 1);
    }

    if(isDefined(waitresult.var_a3325423) && waitresult.var_a3325423 || isDefined(waitresult.var_2c5ad26b) && waitresult.var_2c5ad26b) {
      for(i = 0; i < var_c7581878; i++) {
        if(i < var_68a9a63c.size) {
          setuimodelvalue(createuimodel(var_11302f48, i), var_68a9a63c[i]);

          foreach(var_3f0e790b, character_array in level.var_6f1da91a) {
            var_7d4d74d3 = i > character_array.size ? undefined : character_array[i];

            if(isDefined(var_7d4d74d3) && (level.lastlobbystate === #"lobby_pose" || level.lastlobbystate === #"arena_pose" || level.lastlobbystate === #"private_lobby_pose")) {
              var_7d4d74d3.target thread function_f00765ad(localclientnum, var_68a9a63c[i], var_7d4d74d3.character, i, var_3f0e790b);
              continue;
            }

            if(level.lastlobbystate === "matchmaking" && !(isDefined(level.var_e76e961f) && level.var_e76e961f)) {
              function_4fc36b1a(localclientnum, var_68a9a63c[i]);
              continue;
            }

            if(isDefined(var_7d4d74d3)) {
              var_7d4d74d3.character draft::cancel_spray();
              var_7d4d74d3.character notify(#"cancel_gesture");
              character_customization::function_bee62aa1(var_7d4d74d3.character);
            }
          }

          continue;
        }

        foreach(var_3f0e790b, character_array in level.var_6f1da91a) {
          var_7d4d74d3 = i > character_array.size ? undefined : character_array[i];

          if(isDefined(var_7d4d74d3)) {
            [
              [var_7d4d74d3.character]
            ] - > hide_model();
            var_7d4d74d3.character draft::cancel_spray();
            var_7d4d74d3.character notify(#"cancel_gesture");
            character_customization::function_bee62aa1(var_7d4d74d3.character);
          }
        }
      }

      forcenotifyuimodel(var_11302f48);

      if(level.lastlobbystate === "matchmaking" && !(isDefined(level.var_e76e961f) && level.var_e76e961f)) {
        function_ce0c92c1(localclientnum, var_68a9a63c);

        if(!(isDefined(level.var_494e824d) && level.var_494e824d) || !(isDefined(level.var_3cea0f38) && level.var_3cea0f38)) {
          level thread function_6e9fbb54(localclientnum);
        }
      }
    }

    character_array = level.var_6f1da91a[draft::function_f701ad2a()];

    if(isDefined(character_array)) {
      for(i = 0; i < var_c7581878; i++) {
        if(i < var_68a9a63c.size) {
          var_7d4d74d3 = i > character_array.size ? undefined : character_array[i];

          if(isDefined(var_7d4d74d3) && (level.lastlobbystate === #"lobby_pose" || level.lastlobbystate === #"arena_pose" || level.lastlobbystate === #"private_lobby_pose")) {
            draft::function_8be87802(localclientnum, var_7d4d74d3.character);
          }
        }
      }
    }
  }
}

function_b1b8f767(localclientnum, play) {
  var_6aeec2ad = getdvarstring(#"hash_52abdac1a234fa29", "");
  var_bfe5e572 = struct::get(#"lobby_align_tag" + var_6aeec2ad);

  if(isDefined(var_bfe5e572)) {
    if(play) {
      var_bfe5e572.var_e8b5aff5 = 1;
      function_b0442428(level.var_6f1da91a, 0);
      var_bfe5e572 thread scene::play("scene_frontend_lobby_team" + var_6aeec2ad);
      return;
    }

    if(!play && isDefined(var_bfe5e572.var_e8b5aff5) && var_bfe5e572.var_e8b5aff5) {
      var_bfe5e572.var_e8b5aff5 = 0;
      function_f5eca51d(level.var_6f1da91a, 0);
      var_bfe5e572 thread scene::stop("scene_frontend_lobby_team" + var_6aeec2ad, 1);
    }
  }
}

function_db9d479f(localclientnum, play) {
  var_bfe5e572 = struct::get(#"arena_align_tag");

  if(isDefined(var_bfe5e572)) {
    if(play) {
      var_bfe5e572.var_e8b5aff5 = 1;
      function_b0442428(level.var_6f1da91a, 1);
      var_bfe5e572 thread scene::play("scene_frontend_arena_team");
      return;
    }

    if(!play && isDefined(var_bfe5e572.var_e8b5aff5) && var_bfe5e572.var_e8b5aff5) {
      var_bfe5e572.var_e8b5aff5 = 0;
      function_f5eca51d(level.var_6f1da91a, 1);
      var_bfe5e572 thread scene::stop("scene_frontend_arena_team", 1);
    }
  }
}

toggle_postfx(localclientnum, on_off, postfx) {
  player = function_5c10bd79(localclientnum);

  if(on_off && !player postfx::function_556665f2(postfx)) {
    player postfx::playpostfxbundle(postfx);
    return;
  }

  if(!on_off && player postfx::function_556665f2(postfx)) {
    player postfx::stoppostfxbundle(postfx);
  }
}

function_ae99571d(localclientnum) {
  while(!isDefined(level.var_7208b551)) {
    wait 0.1;
  }

  var_f44acc91 = level.var_e362b5d9[level.var_be02eda3];
  var_d53ddee1 = function_25f808c9(localclientnum, var_f44acc91.mode, var_f44acc91.role_index);

  if(!isDefined(var_d53ddee1)) {
    var_d53ddee1 = character_customization::function_3f5625f1(var_f44acc91.mode, var_f44acc91.role_index);
  }

  return var_d53ddee1;
}

function_f03f5d4e(localclientnum, xuid, session_mode) {
  var_d53ddee1 = getcharactercustomizationforxuid(localclientnum, xuid);

  if(isDefined(var_d53ddee1)) {
    character_index = var_d53ddee1.charactertype;

    if(!function_b9f8bbd9(character_index, session_mode)) {
      var_d53ddee1 = undefined;
    }
  }

  if(!isDefined(var_d53ddee1)) {
    character_index = function_e3efec59(xuid, session_mode);
  }

  var_6d8e8e31 = function_3dc16db1(session_mode, character_index);

  if(isDefined(var_6d8e8e31)) {
    var_f44acc91 = level.var_e362b5d9[var_6d8e8e31];

    if(!isDefined(var_d53ddee1)) {
      var_d53ddee1 = character_customization::function_3f5625f1(var_f44acc91.mode, var_f44acc91.role_index);
    }

    return var_d53ddee1;
  }
}

lobby_main(localclientnum, menu_name, state) {
  level endon(menu_name + "_closed");
  setpbgactivebank(localclientnum, 1);

  if(isDefined(level.lastlobbystate) && state !== level.lastlobbystate) {
    if(level.lastlobbystate === #"lobby_pose" || level.lastlobbystate === #"private_lobby_pose") {
      function_b1b8f767(localclientnum, 0);
    } else if(level.lastlobbystate === #"arena_pose") {
      function_db9d479f(localclientnum, 0);
    } else if(level.lastlobbystate === "warzone" || level.lastlobbystate === "zm_online" || level.lastlobbystate === "zm_custom") {
      level notify(#"positiondraft_close", {
        #localclientnum: localclientnum, 
        #var_b69dc9af: 1
      });
      level waittill(#"hash_21c79522aa982cdd");
    } else if(level.lastlobbystate === "inspect_specialist") {
      level notify("menu_change" + localclientnum, {
        #menu: "directorTraining", 
        #status: "closed", 
        #state: undefined, 
        #mode: 1
      });
    } else if(level.lastlobbystate === "matchmaking") {
      level.var_47863282 = function_9bed6a71(localclientnum, 1);
      level.var_202758dc = undefined;
      level.var_4c6f850d = undefined;
      level.var_723bf922 = undefined;
      function_e56abdb(localclientnum);
    }
  }

  camera_ent = struct::get(#"tag_align_frozen");
  var_fce147fa = 1;
  var_1c5551d6 = 0;
  var_d43870a7 = undefined;
  lut_index = 3;

  if(isDefined(camera_ent)) {
    var_d53ddee1 = undefined;

    if(!isDefined(state) || state == "room2") {
      lut_index = 2;
      var_d53ddee1 = function_ae99571d(localclientnum);

      update_room2_devgui(localclientnum);

    } else if(state == "room1") {
      setallcontrollerslightbarcolor((1, 0.4, 0));
      level thread pulse_controller_color();

      if(isDefined(level.var_ff851224)) {
        var_d53ddee1 = level.var_ff851224;
      } else if(isDefined(level.var_4e236556)) {
        var_d53ddee1 = level.var_4e236556;
      } else {
        var_d53ddee1 = function_ae99571d(localclientnum);
      }
    } else if(state == "room3") {
      var_d53ddee1 = function_ae99571d(localclientnum);
    } else if(state == "matchmaking") {
      if(isDefined(level.var_e76e961f) && level.var_e76e961f) {
        var_b19ae154 = function_9bed6a71(localclientnum, 1);

        if(isDefined(var_b19ae154)) {
          var_d53ddee1 = function_f03f5d4e(localclientnum, var_b19ae154, 1);
        }

        if(!isDefined(var_d53ddee1)) {
          var_6d8e8e31 = function_31a3348c(1);
          var_f44acc91 = level.var_e362b5d9[var_6d8e8e31];
          var_d53ddee1 = character_customization::function_7474681d(localclientnum, var_f44acc91.mode, var_f44acc91.role_index);
        }
      } else if(level.lastlobbystate !== state) {
        var_b0c618aa = 1;
      } else {
        if(!(isDefined(level.var_494e824d) && level.var_494e824d) || !(isDefined(level.var_3cea0f38) && level.var_3cea0f38)) {
          level thread function_6e9fbb54(localclientnum);
        }

        var_fce147fa = 0;
      }
    } else if(state == #"lobby_pose" || state == #"private_lobby_pose") {
      level notify(#"lobby_change", {
        #var_a3325423: 1
      });
      function_b1b8f767(localclientnum, 1);
    } else if(state == #"arena_pose") {
      level notify(#"lobby_change", {
        #var_a3325423: 1
      });
      function_db9d479f(localclientnum, 1);
    } else if(state == "warzone") {
      if(!(isDefined(level.draftactive) && level.draftactive)) {
        level notify(#"positiondraft_open", {
          #localclientnum: localclientnum
        });
      } else if(!(isDefined(level.var_e6802f10) && level.var_e6802f10)) {
        level notify(#"hash_8946580b1303e30", {
          #localclientnum: localclientnum
        });
      }
    } else if(state == "zombie") {
      level.var_ff851224 = undefined;
      var_f44acc91 = level.var_e362b5d9[function_4a6953b8()];
      var_d43870a7 = var_f44acc91.scene;

      if(!forcestreambundle(var_d43870a7, 8, 4)) {
        stopmaincamxcam(localclientnum);
      }

      if(isDefined(level.var_8013e6bd) && level.var_8013e6bd != var_d43870a7) {
        function_a71254a9(localclientnum, 0, undefined, 1);
      }

      level.var_8013e6bd = undefined;
      var_d53ddee1 = character_customization::function_7474681d(localclientnum, var_f44acc91.mode, var_f44acc91.role_index);
    } else if(state == "zm_online" || state == "zm_custom") {
      level.var_ff851224 = undefined;

      if(!(isDefined(level.draftactive) && level.draftactive)) {
        level notify(#"positiondraft_open", {
          #localclientnum: localclientnum
        });
      } else {
        level notify(#"hash_8946580b1303e30", {
          #localclientnum: localclientnum
        });
      }
    } else if(state == "mode_select") {
      if(isDefined(level.var_ff851224)) {
        var_d53ddee1 = level.var_ff851224;
      } else if(isDefined(level.var_4e236556)) {
        var_d53ddee1 = level.var_4e236556;
      } else {
        while(!isDefined(level.var_7208b551)) {
          wait 0.1;
        }

        var_f44acc91 = level.var_e362b5d9[level.var_be02eda3];
        var_d53ddee1 = character_customization::function_7474681d(localclientnum, var_f44acc91.mode, var_f44acc91.role_index);
      }
    } else if(state == "inspect_specialist" && level.lastlobbystate !== "inspect_specialist") {
      waitframe(1);
      controllermodel = getuimodelforcontroller(localclientnum);
      var_aa16ae79 = getuimodel(controllermodel, "SpecialistHeadquarters.ChosenSpecialistID");

      for(character_index = getuimodelvalue(var_aa16ae79); !isDefined(character_index) || character_index == 0; character_index = getuimodelvalue(var_aa16ae79)) {
        wait 0.1;
      }

      level notify("menu_change" + localclientnum, {
        #menu: "directorTraining", 
        #status: "opened", 
        #state: character_index, 
        #mode: 1
      });
    } else if(state == "inspect_specialist" && level.lastlobbystate === "inspect_specialist") {
      var_fce147fa = 0;
    } else {
      var_d53ddee1 = function_ae99571d(localclientnum);
    }

    if(var_fce147fa) {
      var_51dd69a5 = isDefined(var_d53ddee1);
      level thread function_a71254a9(localclientnum, var_51dd69a5, var_d53ddee1, var_1c5551d6, undefined, 0, var_d43870a7);
      toggle_postfx(localclientnum, var_51dd69a5, #"hash_50a4ae6595f15cb0");
      toggle_postfx(localclientnum, !var_51dd69a5, #"hash_e1c80e52b24b46b");
    }
  }

  if(!isDefined(state) || state != "room1") {
    setallcontrollerslightbarcolor();
    level notify(#"end_controller_pulse");
  }

  level.lastlobbystate = state;

  if(isDefined(var_b0c618aa) && var_b0c618aa) {
    level notify(#"lobby_change", {
      #var_a3325423: 1
    });
  }
}

function_58994f4a(localclientnum, menu_data) {
  level thread function_a71254a9(localclientnum, 0);
  function_e56abdb(localclientnum);
  toggle_postfx(localclientnum, 0, #"hash_50a4ae6595f15cb0");
  toggle_postfx(localclientnum, 0, #"hash_e1c80e52b24b46b");
}

update_room2_devgui(localclientnum) {
  level thread mp_devgui::remove_mp_contracts_devgui(localclientnum);
}

update_mp_lobby_room_devgui(localclientnum, state) {
  if(state == "<dev string:x50e>" || state == "<dev string:x51a>") {
    level thread mp_devgui::create_mp_contracts_devgui(localclientnum);
    return;
  }

  level mp_devgui::remove_mp_contracts_devgui(localclientnum);
}

pulse_controller_color() {
  level endon(#"end_controller_pulse");
  delta_t = -0.01;
  t = 1;

  while(true) {
    setallcontrollerslightbarcolor((1 * t, 0.2 * t, 0));
    t += delta_t;

    if(t < 0.2 || t > 0.99) {
      delta_t *= -1;
    }

    waitframe(1);
  }
}

private function_70733b8c(session_mode, character_index) {
  foreach(var_dea538a3 in level.var_e362b5d9) {
    if(var_dea538a3.role_index == character_index && var_dea538a3.mode == session_mode) {
      return var_dea538a3;
    }
  }
}

function_a71254a9(localclientnum, play, player_data, var_1c5551d6 = 0, scene_shot = undefined, var_ddc01a5 = 0, override_scene = undefined) {
  self notify("6b72393916eafd89");
  self endon("6b72393916eafd89");
  assert(!play || isDefined(player_data));

  if(play && (!isDefined(level.var_8013e6bd) || character_customization::function_aa5382ed(level.var_4e236556, player_data))) {
    while(!isDefined(level.var_7208b551)) {
      wait 0.1;
    }

    if(isDefined(override_scene)) {
      var_53511779 = override_scene;
    } else if(isDefined(player_data)) {
      var_6d8e8e31 = function_3dc16db1(player_data.charactermode, player_data.charactertype);

      if(isDefined(var_6d8e8e31)) {
        var_53511779 = level.var_e362b5d9[var_6d8e8e31].scene;
      }
    }

    if(isDefined(var_53511779)) {
      if(isDefined(level.var_8013e6bd) && level.var_8013e6bd !== var_53511779) {
        stopmaincamxcam(localclientnum);
      }

      if(!(isDefined(level.lastlobbystate) && level.lastlobbystate == "matchmaking")) {
        fbc = getuimodel(getglobaluimodel(), "lobbyRoot.fullscreenBlackCount");
        setuimodelvalue(fbc, 1);
      }

      if(isDefined(scene_shot)) {
        var_e9a3b264 = scene::get_all_shot_names(var_53511779, undefined, 0);

        if(!isDefined(var_e9a3b264) || var_e9a3b264.size == 0 || !array::contains(var_e9a3b264, scene_shot)) {
          scene_shot = undefined;
        }
      }

      [
        [level.frozen_moment_character]
      ] - > function_15a8906a(player_data);
      params = {
        #scene: var_53511779, 
        #var_c76f3e47: 1, 
        #var_d8cb38a9: 1, 
        #var_8d3b5f69: 1, 
        #scene_shot: scene_shot
      };
      [
        [level.frozen_moment_character]
      ] - > update(params);
      character_index = [
        [level.frozen_moment_character]
      ] - > get_character_index();
      character_mode = [
        [level.frozen_moment_character]
      ] - > get_character_mode();
      var_6d8e8e31 = isDefined(function_3dc16db1(character_mode, character_index)) ? function_3dc16db1(character_mode, character_index) : 0;
      level.var_8013e6bd = var_53511779;
      level.var_4e236556 = player_data;
      function_cdbcba12(localclientnum, isDefined(level.var_e362b5d9[var_6d8e8e31].fields.var_5c403974) ? level.var_e362b5d9[var_6d8e8e31].fields.var_5c403974 : 0, 1);

      if(!var_ddc01a5) {
        function_66b6e720(level.var_8013e6bd);
      }
    }

    return;
  }

  if(!play && isDefined(level.var_8013e6bd)) {
    [[level.frozen_moment_character]] - > function_39a68bf2();
    fbc = getuimodel(getglobaluimodel(), "lobbyRoot.fullscreenBlackCount");

    if(var_1c5551d6) {
      setuimodelvalue(fbc, 1);
    } else {
      setuimodelvalue(fbc, 0);
    }

    level.var_8013e6bd = undefined;
    level.var_4e236556 = undefined;
    function_cdbcba12(localclientnum, 0, 1);
  }
}

function_e56abdb(localclientnum, var_d50f88e0 = 0) {
  if(isDefined(level.var_494e824d) && level.var_494e824d) {
    [[level.cycle_frozen_moment_char_current]] - > function_39a68bf2();
    [[level.cycle_frozen_moment_char_next]] - > function_39a68bf2();
    fbc = getuimodel(getglobaluimodel(), "lobbyRoot.fullscreenBlackCount");

    if(var_d50f88e0) {
      setuimodelvalue(fbc, 1);
    } else {
      setuimodelvalue(fbc, 0);
    }

    function_cdbcba12(localclientnum, 0, 1);
    level.var_494e824d = 0;
    level.var_3cea0f38 = 0;
    level notify(#"hash_73b4088ba8bf09ca");
  }
}

function_9602c423(localclientnum, menu_name, state) {
  var_d0b01271 = lui::getcharacterdataformenu(menu_name, localclientnum);
  [[var_d0b01271]] - > show_model();
  camera_ent = struct::get(#"cac_specialist_angle");
  playmaincamxcam(localclientnum, #"ui_cam_character_gesture", 0, "", "", camera_ent.origin, camera_ent.angles);

  if(isDefined(state)) {
    [[var_d0b01271]] - > set_character_index(state);
    level notify("updateSpecialistCustomization" + localclientnum, {
      #event_name: "changeHero", 
      #character_index: state, 
      #mode: currentsessionmode()
    });
  }
}

function_25b060af(localclientnum, menu_name, state) {
  var_d0b01271 = lui::getcharacterdataformenu(menu_name, localclientnum);
  [[var_d0b01271]] - > show_model();
  camera_ent = struct::get(#"cac_specialist_angle");
  playmaincamxcam(localclientnum, #"ui_cam_loadout_character", 0, "", "", camera_ent.origin, camera_ent.angles);

  if(isDefined(state)) {
    [[var_d0b01271]] - > set_character_index(state);
    level notify("updateSpecialistCustomization" + localclientnum, {
      #event_name: "changeHero", 
      #character_index: state, 
      #mode: 1
    });
  }
}

function_f8cec907(localclientnum, menu_name, state) {
  var_d0b01271 = lui::getcharacterdataformenu(menu_name, localclientnum);
  [[var_d0b01271]] - > show_model();
  camera_ent = struct::get(#"wz_unlock_struct");
  playmaincamxcam(localclientnum, #"ui_scene_cam_wz_unlock", 0, "", "", camera_ent.origin, camera_ent.angles);

  if(isDefined(state)) {
    args = strtok(state, ";");
    char_index = int(isDefined(args[0]) ? args[0] : 0);
    outfit_index = int(isDefined(args[1]) ? args[1] : 0);
    [[var_d0b01271]] - > set_character_mode(3);
    [[var_d0b01271]] - > set_character_index(char_index);
    level notify("updateSpecialistCustomization" + localclientnum, {
      #event_name: "changeOutfit", 
      #outfit_index: outfit_index
    });
  }
}

function_a72640b3(localclientnum, menu_data) {
  level.var_8b9b6862 = undefined;
}

function_6657c529(localclientnum, menu_name, state) {
  var_d0b01271 = lui::getcharacterdataformenu(menu_name, localclientnum);
  [[var_d0b01271]] - > show_model();
  camera_ent = struct::get(#"cac_specialist_angle");
  lerp_time = isDefined(level.var_8b9b6862) ? 300 : 0;
  level.var_8b9b6862 = state;

  if(state === "face") {
    playmaincamxcam(localclientnum, #"ui_cam_character_customization_head", lerp_time, "", "", camera_ent.origin, camera_ent.angles);
    return;
  }

  playmaincamxcam(localclientnum, #"ui_cam_character_customization_3d", lerp_time, "", "", camera_ent.origin, camera_ent.angles);
}

function_d8402f0c(localclientnum, menu_name, state) {
  var_d0b01271 = lui::getcharacterdataformenu(menu_name, localclientnum);

  if(isDefined(state)) {
    [[var_d0b01271]] - > set_character_index(state);
    level notify("updateSpecialistCustomization" + localclientnum, {
      #event_name: "changeHero", 
      #character_index: state, 
      #mode: 0
    });
  }

  [[var_d0b01271]] - > show_model();
  camera_ent = struct::get(#"cac_specialist_angle");
  playmaincamxcam(localclientnum, #"ui_cam_character_customization_3d", 0, "", "", camera_ent.origin, camera_ent.angles);
}

wz_personalize_character(localclientnum, menu_name, state) {
  var_d0b01271 = lui::getcharacterdataformenu(menu_name, localclientnum);
  [[var_d0b01271]] - > show_model();
  camera_ent = struct::get(#"cac_specialist_angle");
  playmaincamxcam(localclientnum, #"ui_cam_character_customization_3d", 0, "", "", camera_ent.origin, camera_ent.angles);
}

function_a8095769(localclientnum, menu_name) {
  var_d0b01271 = lui::getcharacterdataformenu(menu_name, localclientnum);
  [[var_d0b01271]] - > show_model();
  camera_ent = struct::get(#"tag_align_quartermaster");
  playmaincamxcam(localclientnum, #"ui_cam_store_camera", 0, "", "", camera_ent.origin, camera_ent.angles);
}

function_7142469f(localclientnum, menu_data) {
  level notify(#"blackmarket_closed");
  level thread scene::stop(level.var_d29ac799, 1);
  level.var_d29ac799 = undefined;

  if(isDefined(level.var_c7cd91f5)) {
    stopradiantexploder(localclientnum, level.var_c7cd91f5);
    level.var_c7cd91f5 = undefined;
  }

  season = getdvarstring(#"mtx_seasonal_exploder");
  stopradiantexploder(localclientnum, "fxexp_mtx_ambient" + season);
}

function_3e7aaaea(localclientnum, weapon_model, waitresult) {
  self notify("360f824f6d7c11d5");
  self endon("360f824f6d7c11d5");
  level endon(#"qmweaponupdate");
  var_9d7ee952 = getdvarint(#"hash_41ef264ae8370dc7", 5);
  activecamoinfo = activecamo::function_ae141bf2(waitresult.activecamoindex);

  if(isDefined(activecamoinfo) && activecamoinfo.stages.size > 1) {
    for(stage = 0; true; stage = (stage + 1) % activecamoinfo.stages.size) {
      if(isDefined(level.var_324c3190[localclientnum])) {
        weapon_model stoprenderoverridebundle(level.var_324c3190[localclientnum]);
        level.var_324c3190[localclientnum] = undefined;
      }

      var_3594168e = activecamoinfo.stages[stage];

      if(!isDefined(var_3594168e.disabled) || var_3594168e.disabled == 0) {
        stagecamoindex = function_8b51d9d1(var_3594168e.camooption);
        render_options = function_140a6212(stagecamoindex, 0, waitresult.model_idx, 0, 0, 0);
        weapon = getweapon(waitresult.weapon_ref);
        var_2d45743e = function_2a6e79cf(weapon);
        weapon_model useweaponmodel(weapon, undefined, render_options);
        weapon_model setscale(var_2d45743e.scale);
        activecamo::function_374e37a0(localclientnum, weapon_model, var_3594168e, level.var_324c3190);
        wait var_9d7ee952;
      }
    }
  }
}

function_98088878(localclientnum, menu_data) {
  level endon(menu_data.menu_name + "_closed");
  season = getdvarstring(#"mtx_seasonal_exploder");
  playradiantexploder(localclientnum, "fxexp_mtx_ambient" + season);
  weapon_model = getent(localclientnum, "quartermaster_weapon", "targetname");
  var_7ef44086 = struct::get("tag_align_quartermaster_weapon");

  while(true) {
    waitresult = level waittill(#"qmweaponupdate");

    if(isDefined(level.var_324c3190[localclientnum])) {
      weapon_model stoprenderoverridebundle(level.var_324c3190[localclientnum]);
      level.var_324c3190[localclientnum] = undefined;
    }

    camoindex = 0;

    if(isDefined(waitresult.camoindex)) {
      camoindex = waitresult.camoindex;
    }

    render_options = function_140a6212(camoindex, 0, waitresult.model_idx, 0, 0, 0);
    weapon = getweapon(waitresult.weapon_ref);
    var_2d45743e = function_2a6e79cf(weapon);
    weapon_model useweaponmodel(weapon, undefined, render_options);
    weapon_model setscale(var_2d45743e.scale);
    weapon_model.origin = var_7ef44086.origin + var_2d45743e.offset;
    weapon_model.angles = var_7ef44086.angles;

    if(isDefined(waitresult.activecamoindex)) {
      childthread function_3e7aaaea(localclientnum, weapon_model, waitresult);
    }
  }
}

function_837446a8(localclientnum, menu_name, state) {
  var_d0b01271 = lui::getcharacterdataformenu(menu_name, localclientnum);
  weapon_model = getent(localclientnum, "quartermaster_weapon", "targetname");
  level notify("end_character_rotating" + localclientnum);

  switch (state) {
    case #"character":
    case #"gesture":
      [
        [var_d0b01271]
      ] - > function_4240a39a(1, (0, 90, 0));
      level thread character_customization::rotation_thread_spawner(localclientnum, var_d0b01271, "end_character_rotating" + localclientnum);
      [
        [var_d0b01271]
      ] - > function_4240a39a(0);
      [
        [var_d0b01271]
      ] - > show_model();
      weapon_model hide();
      scene = #"scene_frontend_quartermaster_character";
      break;
    case #"character_full":
      [
        [var_d0b01271]
      ] - > function_4240a39a(1, (0, 90, 0));
      level thread character_customization::rotation_thread_spawner(localclientnum, var_d0b01271, "end_character_rotating" + localclientnum);
      [
        [var_d0b01271]
      ] - > function_4240a39a(0);
      [
        [var_d0b01271]
      ] - > show_model();
      weapon_model hide();
      scene = #"scene_frontend_quartermaster_character_full";
      break;
    case #"character_face":
      [
        [var_d0b01271]
      ] - > function_4240a39a(1, (0, 90, 0));
      level thread character_customization::rotation_thread_spawner(localclientnum, var_d0b01271, "end_character_rotating" + localclientnum);
      [
        [var_d0b01271]
      ] - > function_4240a39a(0);
      [
        [var_d0b01271]
      ] - > show_model();
      weapon_model hide();
      scene = #"scene_frontend_quartermaster_character_face";
      break;
    case #"weapon":
      [
        [var_d0b01271]
      ] - > hide_model();
      weapon_model show();
      scene = #"scene_frontend_quartermaster_weapon";
      break;
    case #"crate":
      [
        [var_d0b01271]
      ] - > hide_model();
      weapon_model hide();
      season = getdvarstring(#"mtx_seasonal_exploder");
      scene = #"scene_frontend_quartermaster_crate" + season;
      exploder = "fxexp_mtx_crate" + season;
      break;
    default:
      [
        [var_d0b01271]
      ] - > hide_model();
      weapon_model hide();
      scene = #"scene_frontend_quartermaster";
      break;
  }

  if(level.var_c7cd91f5 !== exploder) {
    if(isDefined(level.var_c7cd91f5)) {
      stopradiantexploder(localclientnum, level.var_c7cd91f5);
    }

    if(isDefined(exploder)) {
      playradiantexploder(localclientnum, exploder);
    }

    level.var_c7cd91f5 = exploder;
  }

  if(level.var_d29ac799 !== scene) {
    if(isDefined(level.var_d29ac799)) {
      level scene::stop(level.var_d29ac799, 1);
    }

    level.var_d29ac799 = scene;
    level thread scene::play(level.var_d29ac799);
  }
}

function_d252281d(localclientnum, menu_data) {
  draft::function_532dfc0b(localclientnum, 0, 1);
}

function_36962bc4(localclientnum, menu_name, state) {
  self notify("1e968675840551ec");
  self endon("1e968675840551ec");
  var_d0b01271 = lui::getcharacterdataformenu(menu_name, localclientnum);
  [[var_d0b01271]] - > show_model();
  camera_ent = struct::get(#"cac_specialist_angle");
  playmaincamxcam(localclientnum, #"ui_cam_character_customization_3d", 0, "", "", camera_ent.origin, camera_ent.angles);
}

function_8ad37038(localclientnum, menu_name, state) {
  self notify("39be01a84c2a84b");
  self endon("39be01a84c2a84b");
  var_d0b01271 = lui::getcharacterdataformenu(menu_name, localclientnum);

  if(isDefined(state)) {
    [[var_d0b01271]] - > set_character_index(state);
    level notify("updateSpecialistCustomization" + localclientnum, {
      #event_name: "changeHero", 
      #character_index: state, 
      #mode: 3
    });
  }

  [[var_d0b01271]] - > show_model();
  camera_ent = struct::get(#"cac_specialist_angle");
  playmaincamxcam(localclientnum, #"ui_cam_loadout_character", 0, "", "", camera_ent.origin, camera_ent.angles);
}

function_bc98f036(localclientnum, menu_name, state) {
  camera_ent = struct::get(#"cac_specialist_angle");
  playmaincamxcam(localclientnum, #"ui_cam_character_customization_3d", 0, "", "", camera_ent.origin, camera_ent.angles);
}

function_5e7dcbed(localclientnum, menu_data) {
  [[menu_data.custom_character]] - > function_1ec9448d(0);
}

function_ac9a8cf(localclientnum, menu_name, state) {
  camera_ent = struct::get(#"cac_specialist_angle");
  playmaincamxcam(localclientnum, #"ui_cam_character_customization_3d", 0, "", "", camera_ent.origin, camera_ent.angles);
  var_d0b01271 = lui::getcharacterdataformenu(menu_name, localclientnum);
  level thread function_914198cd(localclientnum, var_d0b01271, menu_name);
}

function_914198cd(localclientnum, var_d0b01271, menu_name) {
  level endon(#"disconnect");
  level endon(menu_name + "_closed");

  while(true) {
    waitresult = level waittill("deathfx_update_" + localclientnum);

    switch (waitresult.event_name) {
      case #"updatecharacter":
        var_d0b01271 function_79c881da(localclientnum, waitresult.mode);
        break;
      case #"previewdeathfx":
        var_d0b01271 notify(#"cancel_deathfx");
        var_d0b01271 thread function_317ab257(localclientnum, menu_name, waitresult.deathfxindex);
        break;
      case #"stopdeathfx":
        var_d0b01271 function_ca43d336(localclientnum);
        break;
    }
  }
}

function_79c881da(localclientnum, mode) {
  [[self]] - > set_character_index(1);
  [[self]] - > function_22039feb();
  [[self]] - > function_1ec9448d(1);

  if(isDefined(mode)) {
    [[self]] - > set_character_mode(mode);
  }

  [[self]] - > show_model();
  params = {};
  function_d3cd6cf7(localclientnum, self, {}, params);
  [[self]] - > update(params);
}

function_317ab257(localclientnum, menu_name, var_83a11058) {
  self notify("5befa1e0f1c95e1e");
  self endon("5befa1e0f1c95e1e");
  level endon(#"disconnect");
  level endon(menu_name + "_closed");
  self endon(#"cancel_deathfx");
  var_cc8a3490 = #"hash_521de69029125f63";
  var_7d89d45 = #"hash_33ffd8c85b4da392";
  var_e04a6c21 = #"hash_4c04b62047703a60";

  if(![[self]] - > function_ea4ac9f8()) {
    return;
  }

  var_2ae2bfde = function_b52a94ae(var_83a11058);

  if(isDefined(var_2ae2bfde)) {
    var_cc8a3490 = isDefined(var_2ae2bfde.var_cc8a3490) ? var_2ae2bfde.var_cc8a3490 : #"hash_521de69029125f63";
    var_7d89d45 = isDefined(var_2ae2bfde.var_7d89d45) ? var_2ae2bfde.var_7d89d45 : #"hash_521de69029125f63";
    var_e04a6c21 = isDefined(var_2ae2bfde.var_e04a6c21) ? var_2ae2bfde.var_e04a6c21 : #"hash_4c04b62047703a60";
  }

  self function_ca43d336(localclientnum);
  v_default = (0, 0, 0);
  v_forward = (90, 0, 0);
  character_model = [[self]] - > function_217b10ed();

  if(isDefined(character_model)) {
    var_5f26f63 = character_model gettagangles("j_spine4");
    body_origin = character_model gettagorigin("j_spine4");

    if(isDefined(var_5f26f63) && isDefined(body_origin)) {
      var_5f26f63 += v_forward;
      body_origin += anglesToForward((0, var_5f26f63[1], 0));
      [
        [self]
      ] - > function_82e05d64().var_d35ebd8e = playFX(localclientnum, var_cc8a3490, body_origin, anglesToForward(var_5f26f63), anglestoup(var_5f26f63));
      wait 0.3;
    }
  }

  character_model = [[self]] - > function_217b10ed();

  if(isDefined(character_model)) {
    var_bee5328d = character_model gettagangles("j_neck");
    var_78a78382 = character_model gettagorigin("j_neck");

    if(isDefined(var_bee5328d) && isDefined(var_78a78382)) {
      var_bee5328d += v_forward;
      var_78a78382 += anglesToForward((0, var_bee5328d[1], 0));
      [
        [self]
      ] - > function_82e05d64().var_bef648d0 = playFX(localclientnum, var_7d89d45, var_78a78382, anglesToForward(var_bee5328d), anglestoup(var_bee5328d));
      wait 0.5;
    }
  }

  character_model = [[self]] - > function_217b10ed();

  if(isDefined(character_model)) {
    var_7110530b = character_model gettagangles("j_head");
    var_ad65ea66 = character_model gettagorigin("j_head");

    if(isDefined(var_7110530b) && isDefined(var_ad65ea66)) {
      var_7110530b += v_forward;
      var_ad65ea66 += anglesToForward((0, var_7110530b[1], 0));
      [
        [self]
      ] - > function_82e05d64().var_21cb8ea6 = playFX(localclientnum, var_e04a6c21, var_ad65ea66, anglesToForward(var_7110530b), anglestoup(var_7110530b));
    }
  }
}

function_ca43d336(localclientnum) {
  if(isDefined([[self]] - > function_82e05d64().var_d35ebd8e)) {
    killfx(localclientnum, [[self]] - > function_82e05d64().var_d35ebd8e);
    [[self]] - > function_82e05d64().var_d35ebd8e = undefined;
  }

  if(isDefined([[self]] - > function_82e05d64().var_bef648d0)) {
    killfx(localclientnum, [[self]] - > function_82e05d64().var_bef648d0);
    [[self]] - > function_82e05d64().var_bef648d0 = undefined;
  }

  if(isDefined([[self]] - > function_82e05d64().var_21cb8ea6)) {
    killfx(localclientnum, [[self]] - > function_82e05d64().var_21cb8ea6);
    [[self]] - > function_82e05d64().var_21cb8ea6 = undefined;
  }
}

function_73b8462a(localclientnum, menu_name, state) {
  var_d0b01271 = lui::getcharacterdataformenu(menu_name, localclientnum);

  if(state === "character") {
    [[var_d0b01271]] - > show_model();
  } else {
    [[var_d0b01271]] - > hide_model();
  }

  session_mode = currentsessionmode();

  if(session_mode == 4) {
    return;
  }

  characterindexmodel = createuimodel(getuimodelforcontroller(localclientnum), "AAR.characterIndex");
  character_index = getuimodelvalue(characterindexmodel);
  var_a2865de6 = getplayerroletemplatecount(session_mode);
  attempts = 0;

  while(true) {
    if(!isDefined(character_index)) {
      character_index = 0;
    }

    if(function_f4bf7e3f(character_index, session_mode)) {
      break;
    }

    attempts++;

    if(attempts > 3) {
      character_index = undefined;

      for(ci = 0; ci < var_a2865de6; ci++) {
        if(function_f4bf7e3f(ci, session_mode)) {
          character_index = ci;
          break;
        }
      }

      break;
    }
  }

  assert(character_index);
  fields = getcharacterfields(character_index, session_mode);

  if(isDefined(fields) && isDefined(fields.aarscene)) {
    level.var_c8fac6ea = fields.aarscene;
  } else if(currentsessionmode() == 0) {
    level.var_c8fac6ea = "scene_frontend_aar_zm";
  } else if(currentsessionmode() == 3) {
    level.var_c8fac6ea = "scene_frontend_aar_wz";
  } else if(util::is_arena_lobby()) {
    level.var_c8fac6ea = "scene_frontend_aar_arena";
  } else {
    level.var_c8fac6ea = "scene_frontend_aar";
  }

  if(!level scene::is_playing(level.var_c8fac6ea)) {
    [[var_d0b01271]] - > set_character_mode(session_mode);
    [[var_d0b01271]] - > set_character_index(character_index);
    [[var_d0b01271]] - > function_77e3be08();
    [[var_d0b01271]] - > update(undefined);
    level thread scene::play(level.var_c8fac6ea);
  }
}

function_48fb04a7(localclientnum, menu_name) {
  if(isDefined(level.var_c8fac6ea)) {
    level thread scene::stop(level.var_c8fac6ea);
    level.var_c8fac6ea = undefined;
  }
}

function_2f93d681(localclientnum, entities) {
  foreach(ent in entities) {
    if(isDefined(ent) && isDefined(ent.model)) {
      ent playrenderoverridebundle(#"rob_zm_eyes_red");
    }
  }
}

function_12f56a9(localclientnum, entities) {
  lut_index = randomintrange(7, 10);
  setlutscriptindex(localclientnum, lut_index, 1);
}

function_1bff2e73(localclientnum, entities) {
  setlutscriptindex(localclientnum, 0, 0);
}

function_3dde055b(localclientnum, new_menu) {
  var_d0b01271 = lui::getcharacterdataformenu("MPSpecialistHUBPreviewMoment", localclientnum);
  function_a71254a9(localclientnum, 1, [[var_d0b01271]] - > function_e599283f());
}

function_c4db2740(localclientnum, prev_menu) {
  function_a71254a9(localclientnum, 0, undefined);
}

function_ebc650f4(localclientnum, entities, var_dea538a3, scene_shot) {
  if(isDefined(level.var_494e824d) && level.var_494e824d) {
    if([
        [level.cycle_frozen_moment_char_next]
      ] - > function_ea4ac9f8()) {
      if(!isDefined(level.var_37fcc91f)) {
        level.var_37fcc91f = scene_shot;
      } else if(level.var_37fcc91f != scene_shot) {
        level.var_37fcc91f = undefined;
        level notify(#"hash_5661859119127749");
      }

      return;
    }

    if(!isDefined(level.var_202758dc)) {
      function_6e9fbb54(localclientnum);
    }
  }
}

function_fad4ce33(localclientnum, entities) {
  setlutscriptindex(localclientnum, 5, 1);
}

function_c5cbf7d6(localclientnum, entities) {
  setlutscriptindex(localclientnum, 0, 0);
}