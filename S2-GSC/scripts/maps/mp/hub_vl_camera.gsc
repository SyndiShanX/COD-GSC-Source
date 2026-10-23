/*********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\hub_vl_camera.gsc
*********************************************/

_id_05E0(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {}

delayed_luinotifyserver(var_0, var_1, var_2) {
  wait(var_0);
  self notify("luinotifyserver", var_1, var_2);
}

_id_87B1() {
  var_0 = common_scripts\utility::getstructarray("player_pos", "targetname");

  foreach(var_5, var_2 in var_0) {
    var_3 = common_scripts\utility::getstruct(var_2.target, "targetname");
    var_4 = common_scripts\utility::getstruct(var_3.target, "targetname");
  }

  var_6 = _getEnt("cao_spawnpoint", "targetname");
  var_7 = spawnStruct();
  var_7._id_9839 = 40;
  var_7._id_15F7 = 0.25;
  var_7._id_9935 = var_7._id_15F7;
  var_7._id_084C = 0.01;
  var_7._id_2D5F = 0;
  var_7._id_15F6 = 0.5;
  var_7._id_0DD6 = 0.01;
  var_7._id_9934 = var_7._id_15F6;
  var_7._id_2A2C = 0;
  var_7._id_6090 = 60;
  var_7._id_621D = 60;
  var_7._id_6091 = 120;
  var_7._id_0DCF = 0;
  var_7.dist = 120;
  var_7.dof_time = 12;
  var_7._id_399C = -10;
  var_7.caotolobbyframedelay = 3;
  var_7.caotolobbyframetimer = 0;
  var_7.gamelobbygroup_camoffset_angle_ratio = 0.0;
  var_7._id_3FBF = 45;
  var_7._id_3FC2 = 50;
  var_7._id_3FBC = 6;
  var_7._id_3FBD = 6;
  var_7.gamelobbygroup_camera_upclosez = 513;
  var_7.gamelobbygroup_camera_normalz = 40;
  var_7.gamelobbygroup_camera_crouchz = 483;
  var_7.gamelobbygroup_camera_hunchz = 502;
  var_7.gamelobbygroup_camera_closedistance = 71.5;
  var_7._id_3FB9 = 150;
  var_7._id_3FB3 = 96.8;
  var_7._id_3FB6 = 96.8;
  var_7._id_3FB4 = 490;
  var_7._id_3FB7 = 504.5;
  var_7._id_3FBA = 509.5;
  var_7._id_3FC1 = 0.95;
  var_7._id_1DFD = 0.0;
  var_7._id_1DFC = 7;
  var_7._id_1E17 = 13;
  var_7._id_1DF9 = 0;
  var_7._id_1DFA = 0;
  var_7._id_1EBB = 0.1;
  var_7._id_1E14 = 0.2;
  var_7._id_1E00 = 0;
  var_7._id_1DFB = 17;
  var_7._id_1E16 = 14.5;
  var_7._id_1DFF = 69;
  var_7._id_1E19 = 8;
  var_7._id_1E1B = 0;
  var_7._id_1E1C = 0;
  var_7._id_1E1D = 0;
  var_7._id_1E1E = 0;
  var_7.cacweapondelaytime = 0.35;
  var_7.cacweaponanimdelaytime = 0.1;
  var_7.cacweaponattachdelaytime = 0.05;
  var_7.gamelobby_movespeed = 150;
  var_7._id_3FAF = 0.2;
  var_7._id_3FAE = 45;
  var_7._id_3FB1 = 55;
  var_7._id_3FAB = 16;
  var_7._id_3FAD = 24;
  var_7._id_3FAC = 0.5;
  var_7.goal = "avatar";
  var_7._id_3FA7 = 0.005;
  var_7._id_3FA9 = 0;
  var_7._id_3FA8 = 64;
  var_7._id_3FAA = 0;
  var_7.tgt_camoffset_ratio = var_7._id_1EBE;
  var_7.cur_camoffset_ratio = var_7.tgt_camoffset_ratio;
  var_7._id_1DFE = 0;
  var_7._id_1E18 = (-0.02, 0, -0.08);
  var_7._id_1E1A = (0.05, 0, -0.06);
  var_7.camoffset_ratio_maxspeed = 0.25;
  var_7._id_1F0A = 10;
  var_7._id_64C8 = 150;
  var_7._id_0DE1 = 800;
  var_7._id_768F = 0;
  var_8 = self getunnormalizedcameramovement();
  var_7._id_6A69 = var_8[0];
  var_7._id_6A6A = var_8[1];
  var_7.zoom = 0.5;
  var_7._id_7EE0 = 0.5;
  var_7.framedelay = 0;
  var_7.pre_lobby_framedelay = 4;
  var_7._id_2CC8 = 0;
  var_7._id_3174 = 0;
  var_7._id_3173 = 0;
  var_7._id_316C = 159.8;
  var_7._id_316B = 205.59;
  var_7._id_3172 = 7.5;
  var_7._id_316A = 2;
  var_7.origin_offset = (0, 0, 40);
  var_7.prelobby_movespeed = 300;
  var_7._id_768E = 10;
  var_7._id_768D = 42;
  var_7._id_768B = 40;
  var_7._id_7689 = 200;
  var_7._id_7687 = 0;
  var_7._id_7688 = 20;
  var_7._id_7686 = 0.325;
  var_7.prelobby_ratio_zoom = 0.2;
  var_7._id_1EBC = -0.1;
  var_7._id_1EBE = 0.19;
  var_7._id_1EBF = -1;
  var_7.ch_cyl_zoff_far = 36;
  var_7.ch_cyl_zoff_near = 42;
  var_7._id_9C7B = 0;
  var_7.cao_targetzoff_zoom = 10;
  var_7.cao_targetzoff = 31;
  var_7.cao_neardist = 40;
  var_7.cao_fardist = 200;
  var_7.cao_camerazoff = 0;
  var_7.cao_camerazoff_zoom = 20;
  var_7.cao_camera_ratio = 0.77;
  var_7._id_1F9E = 0.2;
  var_7.cao_camoffset_ratio = 0.25;
  var_9 = getdvarint("virtualLobbyMode", 0);

  if(var_9 == 0) {
    var_7.mode = "game_lobby";
    start_prelobby_anims();
  } else {
    var_7.mode = "transition";
    var_7.tgt_camoffset_ratio = var_7._id_1EBC;
    var_7.cur_camoffset_ratio = var_7.tgt_camoffset_ratio;
    start_lobby_anims();

    if(getdvarint("5666", 0) == 0) {
      setDvar("5666", "1");
    }

    if(var_9 == 2) {
      thread delayed_luinotifyserver(0.1, "cac", 0);
    } else if(var_9 == 3) {
      thread delayed_luinotifyserver(0.1, "cao", 0);
    }
  }

  var_7.newmode = var_7.mode;
  self.camparams = var_7;
}

update_camera_params_ratio(var_0) {
  if(isDefined(self.cut)) {
    var_0.cur_camoffset_ratio = var_0.tgt_camoffset_ratio;
  } else {
    var_1 = var_0.tgt_camoffset_ratio - var_0.cur_camoffset_ratio;

    if(var_1 < -1 * var_0.camoffset_ratio_maxspeed) {
      var_1 = -1 * var_0.camoffset_ratio_maxspeed;
    } else if(var_1 > var_0.camoffset_ratio_maxspeed) {
      var_1 = var_0.camoffset_ratio_maxspeed;
    }

    var_0.cur_camoffset_ratio = var_0.cur_camoffset_ratio + var_1;
  }
}

_id_4697(var_0) {
  var_1 = common_scripts\utility::getstructarray("player_pos", "targetname");
  var_2 = undefined;

  foreach(var_2 in var_1) {
    if(var_2._id_0165 == "" + var_0) {
      break;
    }
  }

  if(!isDefined(var_2)) {
    var_2 = var_1[0];
  }

  self.avatar_spawnpoint = var_2;
  return var_2;
}

vlobby_lighting_setup() {
  var_0 = self;

  if(isDefined(level.vl_lighting_setup)) {
    var_0[[level.vl_lighting_setup]]();
  } else {
    var_0 enablephysicaldepthoffieldscripting();
    var_0 setphysicaldepthoffield(0.613159, 89.8318, var_0.camparams.dof_time, var_0.camparams.dof_time);
  }
}

set_avatar_dof() {
  var_0 = self;

  if(isDefined(var_0.camparams.goal)) {
    if(var_0.camparams.goal == "moving" || var_0.camparams.goal == "finding_new_position" || level.vlavatars[self.vl_focus] != level.vlavatars[self.old_vl_focus]) {
      return;
    }
  }

  if(isDefined(var_0.camparams.camera.cut) && var_0.camparams.camera.cut == 1) {
    return;
  }
  if(isDefined(var_0.camparams.camera.goal_location)) {
    var_1 = var_0.camparams.camera.goal_location;
  } else {
    var_2 = level.vlavatars[self.old_vl_focus];
    var_3 = var_2 gettagorigin("TAG_STOWED_BACK");
    var_4 = _distance2d(var_3, var_2.avatar_spawnpoint.origin);
    var_5 = var_2.avatar_spawnpoint.origin + anglesToForward(var_2.avatar_spawnpoint.angles) * var_4;
    var_1 = (var_5[0], var_5[1], var_3[2]);
  }

  var_6 = checkcamposition(var_0.camparams.camera, var_1, 1.5);

  if(var_6 == 1) {
    var_7 = var_1;
  } else {
    var_7 = var_0.camparams.camera.origin;
  }
}

vlobby_dof_based_on_focus(var_0) {
  if(var_0 <= 0.0) {
    return;
  }
  var_1 = self;
  var_2 = var_1.camparams.dof_time;

  if(isDefined(level.vl_dof_based_on_focus)) {
    var_1[[level.vl_dof_based_on_focus]](var_0);
  } else {
    var_3 = var_0;
    var_1 = self;
    var_4 = 0.025;
    var_5 = 0.65;
    var_6 = 0.613159;
    var_7 = 94.9504;
    var_8 = (var_7 - var_3) * var_4;
    var_9 = var_6 + var_8 + var_8 * var_5;

    if(var_9 < 0.125) {
      var_9 = 0.125;
    } else if(var_9 > 128) {
      var_9 = 128;
    }

    var_1 setphysicaldepthoffield(var_9, var_3, var_1.camparams.dof_time, var_1.camparams.dof_time * 2);
  }
}

vlobby_handle_mode_change(var_0, var_1, var_2) {
  var_3 = self;

  if(isDefined(level.vl_handle_mode_change)) {
    var_3[[level.vl_handle_mode_change]](var_0, var_1, var_2);
  } else {
    if(var_0 == "cac") {
      var_3 setdefaultpostfx();
    } else if(var_0 == "cao") {}

    if(var_1 == "cac") {
      var_3 visionsetnakedforplayer("mp_hub_allies", 0);
    } else if(var_1 == "cao") {
      var_3 setphysicaldepthoffield(3.99, 119.339, var_3.camparams.dof_time, var_3.camparams.dof_time);
    } else if(var_1 == "clanprofile") {
      var_3 setdefaultdof();
    } else if(var_1 == "prelobby") {
      var_3 setdefaultpostfx();
    } else {
      if(var_0 == "prelobby_members") {
        return;
      }
      if(var_0 == "prelobby_loadout") {
        return;
      }
      if(var_0 == "prelobby_loot") {
        return;
      }
      if(var_1 == "game_lobby") {
        var_3 setdefaultpostfx();
      } else {
        if(var_0 == "startmenu") {
          return;
        }
        if(var_0 == "transition") {
          return;
        }
        return;
        return;
        return;
        return;
      }
    }
  }
}

setdefaultpostfx() {
  var_0 = self;
  var_0 visionsetnakedforplayer("mp_hub_allies_vlobby", 0);
}

setdefaultdof() {
  var_0 = self;
  var_0 setphysicaldepthoffield(0.613159, 89.8318, var_0.camparams.dof_time, var_0.camparams.dof_time);
}

fixlocalfocus() {
  if(!isDefined(level.vlavatars[self.vl_focus])) {
    foreach(var_2, var_1 in level.vlavatars) {
      self.vl_focus = var_2;
      break;
    }
  }
}

_id_6BA9() {
  level._id_0A41["player"]["on_killed"] = maps\mp\hub_vl_base::on_agent_player_killed;
  thread vlobby_player();
  thread monitor_member_focus_change();

  for(var_0 = undefined; !isDefined(var_0) || !isDefined(self._id_01D6); var_0 = level.xuid2ownerid[self._id_01D6]) {
    waitframe();
  }

  thread monitor_create_an_operator(var_0);
  thread monitor_create_a_class(var_0);
  thread monitor_clans();
  thread maps\mp\hub_vl_base::_id_636A(self);
}

vlobby_player() {
  self endon("disconnect");

  while(!isDefined(self.botclearscriptenemy)) {
    waitframe();
  }

  var_0 = self;
  var_0._id_00C7 = 0;
  var_0 setclientomnvar("ui_vlobby_round_state", 0);
  var_0 setclientomnvar("ui_vlobby_round_timer", 0);
  var_0 grab_players_classes();
  var_1 = var_0.origin;
  var_2 = var_0.angles;
  var_3 = var_1 - (0, 0, 30);
  var_0 _id_87B1();
  var_4 = anglesToForward(var_0.angles);
  var_5 = anglestoright(var_0.angles);
  var_6 = var_4;
  var_7 = _getgroundposition(var_1, 20, 512, 120);
  var_8 = var_0 getxuid();
  var_9 = var_8 == "";
  var_10 = undefined;
  level.needlocalmemberid = 1;
  var_11 = "none";
  var_12 = "none";
  var_13 = "none";
  var_14 = var_0.loadouts["customClasses"][0];
  var_15 = var_14["division"];

  if(isDefined(var_14["primaryWeaponStruct"]) && isDefined(var_14["primaryWeaponStruct"].guid) && var_14["primaryWeaponStruct"].guid != 0) {
    var_16 = var_14["primaryWeaponStruct"];
    var_17 = var_14["primaryAttachmentsGUID"][0];
    var_18 = var_14["primaryAttachmentsGUID"][1];
    var_19 = var_14["primaryAttachmentsGUID"][2];
    var_20 = var_14["primaryAttachmentsGUID"][3];
    var_21 = var_14["primaryAttachmentsGUID"][4];
    var_22 = var_14["primaryAttachmentsGUID"][5];
    var_23 = var_14["primaryCamoGUID"];
    var_24 = var_14["primaryReticleGUID"];
    var_25 = var_14["primaryCustomization"];
    var_26 = maps\mp\_utility::_id_4737(var_16);
    var_11 = maps\mp\gametypes\_class::buildweaponname(var_26, var_17, var_18, var_19, var_20, var_21, var_22, maps\mp\_utility::_id_472D(var_16), var_23, var_24, var_25);
  } else if(isDefined(var_14["secondaryWeaponStruct"]) && isDefined(var_14["secondaryWeaponStruct"].guid) && var_14["secondaryWeaponStruct"].guid != 0) {
    var_27 = var_14["secondaryWeaponStruct"];
    var_17 = var_14["secondaryAttachmentsGUID"][0];
    var_18 = var_14["secondaryAttachmentsGUID"][1];
    var_19 = var_14["secondaryAttachmentsGUID"][2];
    var_20 = var_14["secondaryAttachmentsGUID"][3];
    var_21 = var_14["secondaryAttachmentsGUID"][4];
    var_22 = var_14["secondaryAttachmentsGUID"][5];
    var_23 = var_14["secondaryCamoGUID"];
    var_24 = var_14["secondaryReticleGUID"];
    var_25 = var_14["secondaryCustomization"];
    var_26 = maps\mp\_utility::_id_4737(var_27);
    var_12 = maps\mp\gametypes\_class::buildweaponname(var_26, var_17, var_18, var_19, var_20, var_21, var_22, maps\mp\_utility::_id_472D(var_27), var_23, var_24, var_25);
  } else if(isDefined(var_14["meleeWeaponStruct"]) && isDefined(var_14["meleeWeaponStruct"].guid) && var_14["meleeWeaponStruct"].guid != 0) {
    var_28 = var_14["meleeWeaponStruct"];
    var_29 = maps\mp\_utility::_id_4737(var_28);
  }

  var_30 = _getEnt("cao_spawnpoint", "targetname");
  var_31 = 0;

  if(!var_9) {
    maps\mp\hub_vl_base::vlprintln("adding xuid " + var_8 + "from vlobby_player");
    var_31 = maps\mp\hub_vl_base::_id_0902(var_8);
    getspawnpoint(0);
    var_0 _id_8F7D(var_0.avatar_spawnpoint, var_15, var_11, var_12, var_13, var_0.loadoutequipment, var_0.loadoutoffhand, var_0.perks, var_0.setnameplatematerial, var_0.name, var_31, 0);

    if(!level._id_A1FE) {
      _setentplayerxuidforemblem(level.vlavatars[var_31], var_8);
    }

    thread setvirtuallobbypresentable();
  } else
    level.needtopresent = 1;

  setDvar("1999", level.xuid2ownerid.size);
  var_0._id_1FA3 = var_30;
  var_0._id_1F9D = var_11;

  if(isDefined(level._id_A1DB)) {
    var_0.clan_agents = [];
    var_32 = [0, 1, 4];

    for(var_33 = 0; var_33 < 3; var_33++) {
      var_34 = getspawnpoint(var_32[var_33]);
      var_0.clan_agents[var_33] = var_0 _id_8F7D(var_34, var_15, var_11, var_12, var_13, var_0.loadoutequipment, var_0.loadoutoffhand, var_0.perks, var_0.setnameplatematerial, var_0.name, 0, 0, 1);
      hide_avatar(var_0.clan_agents[var_33]);
    }
  }

  var_0.vl_focus = var_31;
  var_0.vl_cao_focus = undefined;
  var_0 thread monitor_class_select_or_weapon_change(var_31);

  if(!var_9) {
    var_10 = level.vlavatars[var_0.vl_focus];
    var_10.membertimeout = gettime();
    var_10.currentselectedclass = var_0.currentselectedclass;
    var_10.player = var_0;
    var_10.setnameplatematerial = var_10.costume;
  }

  thread monitor_debug_addfakemembers(var_0, var_0.camparams);
  var_35 = common_scripts\utility::getstruct("camera_pos", "targetname");
  var_36 = var_35.origin;
  var_37 = var_35.angles;
  var_38 = var_0.avatar_spawnpoint.origin - var_36;
  var_38 = vectorNormalize(var_38);
  var_39 = spawn("script_model", var_36);
  var_39.angles = var_37;
  var_39 setModel("tag_player");
  var_39.targetname = "vlcamera";
  var_39._id_92F0 = var_36;
  var_39._id_92B8 = var_37;
  var_39.setmovingplatformplayerturnrate = (0, 0, 0);
  var_39._id_1E91 = 0;
  var_39._id_4B88 = 1;
  var_39._id_1E98 = 1;
  var_39.cut = 1;
  var_39._id_3FE2 = 0;
  var_39.finished = 1;
  var_39.goal_location = var_36;
  storecameratargets(var_39);
  var_40 = 400;
  var_0.camera = var_39;
  var_39.player = var_0;
  var_0.hastouchedstick = 0;
  var_41 = (0, 90, 0);
  var_39._id_64ED = "starting";
  var_0.in_firingrange = 0;
  var_0 allowfire(0);
  var_0 maps\mp\hub_vl_base::prep_for_controls(var_0.spawned_avatar, var_0.spawned_avatar.spawn_angles);

  if(isDefined(level._id_A1DB)) {
    var_0 maps\mp\hub_vl_base::prep_for_controls(var_0.clan_agents[0], var_0.clan_agents[0].spawn_angles);
    var_0 maps\mp\hub_vl_base::prep_for_controls(var_0.clan_agents[1], var_0.clan_agents[1].spawn_angles);
    var_0 maps\mp\hub_vl_base::prep_for_controls(var_0.clan_agents[2], var_0.clan_agents[2].spawn_angles);
  }

  var_42 = var_0.camparams;
  var_42.camera = var_39;
  init_path_constants(var_39);
  var_43 = 300;
  var_0.old_vl_focus = var_0.vl_focus;
  var_40 = 1000;
  var_44 = anglesToForward(var_39.angles);
  var_45 = undefined;
  var_46 = undefined;
  var_47 = undefined;
  var_48 = undefined;
  var_0.camparams.framedelay = var_0.camparams.pre_lobby_framedelay;
  thread monitor_player_removed();
  thread monitor_vl_mode_change(var_42);
  var_49 = 0;
  var_50 = 0;
  self setclientomnvar("char_scene_state", 3);
  var_0 notify("fade_in");

  for(;;) {
    if(!var_0._id_537A) {
      var_0 waittill("virtualLobbyActive");
      var_0._id_8068 = var_0 getplayerangles();
      var_0.spawned_avatar.angles = var_0.spawned_avatar.spawn_angles;
      _id_05E0(var_0 getentitynumber(), var_0.spawned_avatar._id_20F1, "angles", var_0.spawned_avatar.angles);
      var_0 maps\mp\hub_vl_base::prep_for_controls(var_0.spawned_avatar, var_0.spawned_avatar.spawn_angles);
      var_0 setclientomnvar("char_scene_state", 3);
    }

    maps\mp\hub_vl_base::avatar_after_spawn();

    if(level.vlavatars.size == 0) {
      if(var_42.mode == "game_lobby" || var_42.mode == "prelobby_loot") {
        var_0 _id_2D00();

        if(isDefined(level._id_A1DB)) {
          for(var_33 = 0; var_33 < 3; var_33++) {
            hide_avatar(var_0.clan_agents[var_33]);
          }
        }

        var_39.cut = 1;
        var_0.avatar_spawnpoint = getspawnpoint(0);
        lobby_update_group_new(var_39, undefined, var_42, var_0.avatar_spawnpoint);
        vlobby_vegnette(0, "ac130_overlay_pip_vignette_vlobby");
      }

      waitframe();
      continue;
    }

    if(var_50) {
      var_50 = 0;
      var_0 thread debug_pathing();
    }

    if(getdvarint("scr_vl_debugfly") > 0) {
      if(!var_49) {
        var_49 = 1;
        setDvar("5718", "0");
        level.debug_fly = undefined;
        var_0 allowfire(1);
      }

      var_0 debug_fly(var_39);
    } else if(var_49) {
      setDvar("5718", "1");
      var_49 = 0;
      var_39.origin = var_39._id_92F0;
      var_39.angles = var_39._id_92B8;
      var_0 allowfire(0);
    }

    if(!var_0.in_firingrange) {
      if(var_0.vl_focus != var_0.old_vl_focus) {
        var_0 maps\mp\hub_vl_base::prep_for_controls(level.vlavatars[var_0.vl_focus], level.vlavatars[var_0.vl_focus].angles);

        if(var_42.mode != "game_lobby") {
          var_42.newmode = "transition";
        }

        var_0.old_vl_focus = var_0.vl_focus;
        var_42._id_9C7B = 1;
      }

      if(isDefined(var_0.vl_cao_focus) || isDefined(var_0._id_77A2)) {
        if(!isDefined(var_0.vl_cao_focus)) {
          var_42.newmode = var_42.pushmode;
          var_0._id_77A2 = undefined;
        } else if(!isDefined(var_0._id_77A2)) {
          var_42.newmode = "cao";
          var_42.pushmode = var_42.mode;
          var_0._id_77A2 = var_0.vl_cao_focus;
        } else if(var_0.vl_cao_focus != var_0._id_77A2)
          var_0._id_77A2 = var_0.vl_cao_focus;
      }

      if(isDefined(var_0.cac) || isDefined(var_0._id_77A0)) {
        if(!isDefined(var_0.cac)) {
          var_42.newmode = var_42.pushmode;
          var_0._id_77A0 = undefined;
          var_0._id_77A1 = "none";
        } else if(!isDefined(var_0._id_77A0)) {
          var_42.newmode = "cac";
          var_42.pushmode = var_42.mode;
          var_0._id_77A0 = var_0.cac;
        }
      }

      if(isDefined(var_0.vl_clanprofile_focus) || isDefined(var_0._id_77A3)) {
        if(!isDefined(var_0.vl_clanprofile_focus)) {
          var_42.newmode = var_42.pushmode;
          var_0._id_77A3 = undefined;
        } else if(!isDefined(var_0._id_77A3)) {
          var_42.newmode = "clanprofile";
          var_42.pushmode = var_42.mode;
          var_0._id_77A3 = var_0.vl_clanprofile_focus;
        } else if(var_0.vl_clanprofile_focus != var_0._id_77A3) {
          var_0._id_77A3 = var_0.vl_clanprofile_focus;

          if(isDefined(level._id_A1DB)) {
            var_0 maps\mp\hub_vl_base::prep_for_controls(var_0.clan_agents[var_0.vl_clanprofile_focus], var_0.clan_agents[var_0.vl_clanprofile_focus].angles);
          }
        }
      }

      if(level.vlavatars.size == 0) {
        continue;
      }
      var_0 fixlocalfocus();
      var_10 = level.vlavatars[var_0.vl_focus];

      if(var_42.newmode != var_42.mode) {
        var_0 vlobby_handle_mode_change(var_42.mode, var_42.newmode, var_42);

        if(var_42.newmode == "cac") {
          var_0 _id_2D00();

          if(isDefined(level._id_A1DB)) {
            for(var_33 = 0; var_33 < 3; var_33++) {
              hide_avatar(var_0.clan_agents[var_33]);
            }
          }

          var_0.hastouchedstick = 0;
          var_42.mode = var_42.newmode;
          var_42.tgt_camoffset_ratio = var_42._id_1DFD;
          var_10 = level.vlavatars[var_0.vl_focus];
          hide_avatar(var_10);
          var_0 maps\mp\hub_vl_base::prep_for_controls(var_10, var_10.angles);
        } else if(var_42.mode == "cac") {
          var_10 = level.vlavatars[var_0.vl_focus];
          show_avatar(var_10);
          var_0.hastouchedstick = 0;
        }

        if(var_42.newmode == "cao") {
          var_51 = level.vlavatars[var_0.vl_focus];
          var_0.costume = var_51.costume;
          var_52 = var_0 _id_0510::playercostume();

          if(!isDefined(var_51._id_5097) || !var_51._id_5097) {
            if(level._id_A1FE) {
              _id_05E0(var_0 getentitynumber(), var_51._id_20F1, "costume", var_51.costume[0], var_51.costume[1], var_51.costume[2], var_51.costume[3], var_51.costume[4], var_51.costume[5]);
            } else {
              var_51 set_grenadeammo(var_51.costume, "free");
            }
          }

          var_0 _id_2785();
          var_53 = var_0.cao_agent;
          vl_avatar_costume(var_53, var_51.costume);

          if(!isDefined(var_53._id_5097) || !var_53._id_5097) {
            if(level._id_A1FE) {
              _id_05E0(var_0 getentitynumber(), var_53._id_20F1, "costume", var_51.costume[0], var_51.costume[1], var_51.costume[2], var_51.costume[3], var_51.costume[4], var_51.costume[5]);
            } else {
              var_53 set_grenadeammo(var_53.costume, "free");
            }
          }

          foreach(var_8, var_55 in level.xuid2ownerid) {
            if(var_55 == var_0.vl_focus) {
              if(!level._id_A1FE) {
                if(isDefined(level.cao_xuid) && level.cao_xuid != var_8) {
                  _setentplayerxuidforemblem(var_53, level.cao_xuid, 1);
                }

                _setentplayerxuidforemblem(var_53, var_8);
              }

              level.cao_xuid = var_8;
              break;
            }
          }

          if(!level._id_A1FE) {
            var_0.cao_agent showtoplayer(var_0);
          }

          var_0.cao_agent.angles = var_0.cao_agent.spawn_angles;
          _id_05E0(var_0 getentitynumber(), var_0.cao_agent._id_20F1, "angles", var_0.cao_agent.angles);

          if(isDefined(level._id_A1DB)) {
            for(var_33 = 0; var_33 < 3; var_33++) {
              hide_avatar(var_0.clan_agents[var_33]);
            }
          }

          var_10 = var_0.cao_agent;
          var_0 maps\mp\hub_vl_base::prep_for_controls(var_0.cao_agent, var_0.cao_agent.angles);
          start_cao_anims();
          var_42.mode = var_42.newmode;
          var_39.cut = 1;
        } else if(var_42.newmode == "clanprofile") {
          var_0 _id_2D00();
          hide_avatars();

          if(isDefined(level._id_A1DB)) {
            for(var_33 = 0; var_33 < 3; var_33++) {
              var_0.clan_agents[var_33].angles = var_0.clan_agents[var_33].spawn_angles;
              _id_05E0(var_0 getentitynumber(), var_0.clan_agents[var_33]._id_20F1, "angles", var_0.clan_agents[var_33].angles);
              var_0 maps\mp\hub_vl_base::prep_for_controls(var_0.clan_agents[var_33], var_0.clan_agents[var_33].angles);
            }

            var_10 = var_0.clan_agents[0];
          }

          var_42.mode = var_42.newmode;
          var_0 setOrigin(var_10.origin);
        } else if(var_42.newmode == "prelobby_loot")
          var_39.cut = 1;
        else if(var_42.newmode == "transition") {
          var_42.newmode = "game_lobby";
        }

        if(var_42.newmode == "game_lobby") {
          var_0 fixlocalfocus();
          var_56 = var_31;

          if(var_42.mode == "cao" || var_42.mode == "cac" || var_42.mode == "clanprofile") {
            var_39.finished = 1;

            if(isDefined(var_0.vl_cao_focus)) {
              var_56 = var_0.vl_cao_focus;
            } else if(isDefined(var_0.vl_clanprofile_focus)) {
              var_56 = getfocusfromcontroller(var_0.vl_clanprofile_focus);
            }
          }

          if(isDefined(level.vlavatars) && isDefined(var_0.old_vl_focus) && isDefined(level.vlavatars[var_0.old_vl_focus])) {
            var_0 maps\mp\hub_vl_base::prep_for_controls(level.vlavatars[var_0.old_vl_focus], level.vlavatars[var_0.old_vl_focus].angles);
          }

          var_42.goal = "waiting";

          if(var_42.mode != "cac") {
            show_avatars();
          }

          var_0.vl_focus = var_56;
          var_0.old_vl_focus = var_56;
          var_10 = level.vlavatars[var_0.vl_focus];

          if(var_42.mode != "cac") {
            var_39.cut = 1;
          } else if(var_42.mode == "cac" && isDefined(var_39.avatar_spawnpoint) && var_39.avatar_spawnpoint != var_10.avatar_spawnpoint) {
            var_39.cut = 1;
          }

          start_lobby_anims();
          var_39.last_avatar_position = var_10.avatar_spawnpoint;
          var_39.avatar_spawnpoint = var_10.avatar_spawnpoint;
          var_0 maps\mp\hub_vl_base::prep_for_controls(var_10, var_10.angles);
          var_39._id_64ED = "starting";
        }

        var_42.mode = var_42.newmode;
      }

      if(var_42.mode == "startmenu") {
        start_menu_update(var_39, var_42);
      } else if(var_42.mode == "cao") {
        var_0 _id_2785();
        var_10 = var_0.cao_agent;
        cao_update(var_39, var_10, var_42);
      } else if(var_42.mode == "clanprofile") {
        if(isDefined(level._id_A1DB)) {
          var_10 = var_0.clan_agents[var_0.vl_clanprofile_focus];
          clan_profile_update(var_39, var_10, var_42);
        }
      } else if(var_42.mode == "cac")
        lobby_update_group_new(var_39, level.vlavatars[var_0.vl_focus], var_42, var_0.avatar_spawnpoint);
      else if(var_42.mode == "transition") {
        var_42.newmode = "game_lobby";
      } else if(var_42.caotolobbyframetimer <= 0) {
        var_0 _id_2D00();

        if(isDefined(level._id_A1DB)) {
          for(var_33 = 0; var_33 < 3; var_33++) {
            hide_avatar(var_0.clan_agents[var_33]);
          }
        }

        lobby_update_group_new(var_39, var_10, var_42, var_0.avatar_spawnpoint);
        vlobby_vegnette(0, "ac130_overlay_pip_vignette_vlobby");
      } else
        var_42.caotolobbyframetimer = var_42.caotolobbyframetimer - 1;
    }

    if(var_0.in_firingrange) {
      var_0 visionsetnakedforplayer("mp_vlobby_room_fr", 0);
    }

    waitframe();
  }
}

tablelookupweaponoffsets(var_0, var_1, var_2) {
  var_3 = _float(tablelookup("mp/vlobby_cac_offsets.csv", var_1, var_0, var_2));

  if(!isDefined(var_3)) {
    var_3 = 0;
  }

  return var_3;
}

storecameratargets(var_0) {
  var_1 = common_scripts\utility::getstructarray("player_pos", "targetname");
  var_0.camerhelperarray = [];

  foreach(var_3 in var_1) {
    var_0.camerhelperarray[var_0.camerhelperarray.size] = var_3;
  }

  foreach(var_3 in var_1) {
    var_6 = common_scripts\utility::getstruct(var_3.target, "targetname");

    if(var_6._id_0165 == "camera_target") {
      var_3.camera_lookat = var_6;
    }

    var_7 = common_scripts\utility::getstruct(var_6.target, "targetname");

    if(var_7._id_0165 == "camera") {
      var_3.camera_helper = var_7;
      var_7.camera_goal = var_3;
      var_7.camera_lookat = var_3.camera_lookat;
    }

    if(var_3._id_0165 == "0") {
      self.camparams.last_camera_helper = var_3.camera_helper;
    }

    var_8 = int(var_3._id_0165);
    var_0.camerhelperarray[var_8] = var_3;
  }
}

calc_target_dir(var_0, var_1, var_2) {
  var_3 = var_1 - var_0;
  var_4 = _length2d(var_3);
  var_5 = var_4 / _sqrt(1 + var_2.cur_camoffset_ratio * var_2.cur_camoffset_ratio);
  var_6 = var_3[0] - var_2.cur_camoffset_ratio * var_3[1];
  var_7 = var_2.cur_camoffset_ratio * var_3[0] + var_3[1];
  var_8 = var_5 * vectorNormalize((var_6, var_7, 0));
  var_8 = var_8 + (0, 0, var_3[2]);
  return var_8;
}

hacky_get_delta_xrot(var_0, var_1) {
  var_2 = var_1 - var_0._id_6A69;

  if(var_2 < -180) {
    var_2 = 360 + var_2;
  } else if(var_2 > 180) {
    var_2 = 360 - var_2;
  }

  var_0._id_6A69 = var_1;
  return var_2;
}

hacky_get_delta_yrot(var_0, var_1) {
  var_2 = var_1 - var_0._id_6A6A;

  if(var_2 < -180) {
    var_2 = -1;
  } else if(var_2 > 180) {
    var_2 = 1;
  } else {
    var_2 = 0;
  }

  var_0._id_6A6A = var_1;
  return var_2;
}

cammove(var_0, var_1, var_2, var_3) {
  if(isDefined(self.cut)) {
    self.origin = var_0;
  } else {
    self moveTo(var_0, var_1, var_2, var_3);
  }
}

camrotate(var_0, var_1, var_2, var_3) {
  if(isDefined(self.cut)) {
    self.angles = var_0;
  } else {
    self rotateTo(var_0, var_1, var_2, var_3);
  }
}

rotateavatartagcamera(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_2 = spawnStruct();
    var_2.camera_tag_origin = (-70.8, -691.3, 502.2);
    var_2.camera_tag_angles = (0, 87, 0);
    return var_2;
  }

  var_3 = var_0 gettagorigin("TAG_STOWED_BACK");
  var_4 = var_0 gettagangles("TAG_STOWED_BACK");
  var_5 = var_0.spawn_angles[1] - var_0.angles[1];
  var_6 = (0, 0, 1);
  var_7 = var_3 - var_0.origin;
  var_8 = _rotatepointaroundvector(var_6, var_7, var_5);
  var_9 = var_0.origin + var_8;
  var_0.camera_tag_origin = var_9;
  var_0.camera_tag_angles = (var_4[0], _angleclamp(var_4[1] + var_5), var_4[2]);
  var_2 = spawnStruct();
  var_2.camera_tag_origin = var_0.camera_tag_origin;
  var_2.camera_tag_angles = var_0.camera_tag_angles;
  return var_2;
}

checkcamposition(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = 2;
  }

  var_3 = distance(var_1, var_0.origin);

  if(var_3 >= var_2) {
    return 1;
  } else {
    return 0;
  }
}

lobby_update_group_new(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_1)) {
    var_2.framedelay = var_2.pre_lobby_framedelay;
    var_4 = var_0._id_92B8;

    if(isDefined(var_3)) {
      var_4 = (0, var_3.angles[1] + 180, 0);
    }

    var_5 = var_0._id_92F0;
    var_6 = distance(var_0.origin, var_5);
    var_7 = var_6 / var_2.prelobby_movespeed;

    if(var_7 < 0.1) {
      var_7 = 0.1;
    }

    var_0 cammove(var_5, var_7, var_7 * 0.5, var_7 * 0.5);
    var_0 camrotate(var_4, var_7, var_7 * 0.5, var_7 * 0.5);
  } else {
    if(var_2.framedelay == var_2.pre_lobby_framedelay) {
      maps\mp\hub_vl_base::prep_for_controls(var_1, var_1.angles);
    }

    var_4 = (0, 87, 0);

    if(isDefined(var_1.avatar_spawnpoint)) {
      var_4 = (0, var_1.avatar_spawnpoint.angles[1] + 180, 0);
    }

    if(level._id_A1FE) {
      var_8 = var_1.origin;
    } else {
      var_8 = var_1 gettagorigin("TAG_STOWED_BACK");
    }

    if(!isDefined(var_1.camera_state)) {
      var_1.camera_state = "stand";
    }

    if(var_1.camera_state == "crouch") {
      var_9 = var_1.avatar_spawnpoint.origin + anglesToForward(var_1.avatar_spawnpoint.angles) * var_2._id_3FB3;
      var_10 = (var_9[0], var_9[1], var_9[2] + var_2.gamelobbygroup_camera_crouchz);
    } else if(var_1.camera_state == "hunch") {
      var_9 = var_1.avatar_spawnpoint.origin + anglesToForward(var_1.avatar_spawnpoint.angles) * var_2._id_3FB6;
      var_10 = (var_9[0], var_9[1], var_9[2] + var_2.gamelobbygroup_camera_hunchz);
    } else if(var_1.camera_state == "stand") {
      var_9 = var_1.avatar_spawnpoint.origin + anglesToForward(var_1.avatar_spawnpoint.angles) * var_2._id_3FB9;
      var_10 = (var_9[0], var_9[1], var_9[2] + var_2.gamelobbygroup_camera_normalz);
    } else if(var_1.camera_state == "zoom_high") {
      var_9 = var_1.avatar_spawnpoint.origin + anglesToForward(var_1.avatar_spawnpoint.angles) * var_2.gamelobbygroup_camera_closedistance;
      var_10 = (var_9[0], var_9[1], var_9[2] + var_2.gamelobbygroup_camera_upclosez);
    } else {
      var_9 = var_1.avatar_spawnpoint.origin + anglesToForward(var_1.avatar_spawnpoint.angles) * var_2._id_3FB9;
      var_10 = (var_9[0], var_9[1], var_9[2] + var_2.gamelobbygroup_camera_normalz);
    }

    if(getdvarint("scr_vl_camera_test") != 0) {
      var_11 = _distance2d(var_1.avatar_spawnpoint.origin, var_1.avatar_spawnpoint.camera_helper.origin);

      if(var_11 < var_2._id_3FB9) {
        var_11 = var_2._id_3FB9;
      }

      var_12 = var_8[2] - var_2.gamelobbygroup_camera_normalz;
      var_13 = _atan(var_12 / var_2._id_3FB9);
      var_14 = _tan(var_13) * var_2._id_3FB9;
      var_15 = _tan(var_13) * var_11;
      var_16 = var_8[2] - var_15;
      var_9 = var_1.avatar_spawnpoint.origin + anglesToForward(var_1.avatar_spawnpoint.angles) * var_11;
      var_10 = (var_9[0], var_9[1], var_16);
    }

    var_0.goal_location = var_10;
    var_17 = 0;

    if(var_2.framedelay == 0) {
      var_17 = checkcamposition(var_0, var_10, 1.5);
    }

    var_2.cur_camoffset_ratio = var_2.gamelobbygroup_camoffset_angle_ratio;
    var_2.tgt_camoffset_ratio = var_2.gamelobbygroup_camoffset_angle_ratio;
    var_0 update_camera_params_ratio(var_2);
    var_18 = 0;
    var_19 = 0;
    var_6 = distance(var_0.origin, var_10);
    var_7 = var_6 / var_2.gamelobby_movespeed;

    if(var_7 < 0.1) {
      var_7 = 0.1;
    }

    var_20 = var_6 / (var_2.gamelobby_movespeed * var_2._id_3FC1);

    if(var_20 < 0.1) {
      var_20 = 0.1;
    }

    var_21 = 1;
    var_22 = getdvarint("virtualLobbyMode", 0);

    if(var_22 != 2 && var_22 != 4 && var_22 != 3) {
      if(isDefined(var_1.player) && var_1.player == self) {
        maps\mp\hub_vl_base::rightstickrotateavatar(var_1, 0.5);
      }
    } else if(var_22 == 4 || var_22 == 3) {
      maps\mp\hub_vl_base::prep_for_controls(var_1, var_1.angles);
      var_0.cut = 1;
    } else if(var_22 == 2)
      maps\mp\hub_vl_base::prep_for_controls(var_1, var_1.angles);

    if(var_2.framedelay > 0) {
      var_2.framedelay = var_2.framedelay - 1;
    }

    if(isDefined(var_1.avatar_spawnpoint) && isDefined(var_0.avatar_spawnpoint) && var_1.avatar_spawnpoint != var_0.avatar_spawnpoint) {
      var_0.lastavatarpositionent = var_0.avatar_spawnpoint;
      var_0.avatar_spawnpoint = var_1.avatar_spawnpoint;
      var_2.goal = "finding_new_position";
      var_17 = 1;
      var_0.finished = 0;
    } else if(var_17 == 1)
      var_2.goal = "moving";

    if(var_2.goal == "waiting") {
      if(var_17 == 1) {
        var_2.goal = "moving";
        var_0.finished = 1;
      }

      var_0.last_avatar_position = var_1.avatar_spawnpoint;
    }

    if(var_2.goal == "finding_new_position") {
      if(var_17 == 1) {
        var_0.lastavatarpositionent = var_0.avatar_spawnpoint;
        var_0.avatar_spawnpoint = var_1.avatar_spawnpoint;
        var_0.obstacles = [];
        var_23 = 16;

        foreach(var_25 in level.vlavatars) {
          var_26 = [];
          var_26["center"] = var_25.avatar_spawnpoint.origin;
          var_26["radius"] = var_23;
          var_0.obstacles[var_0.obstacles.size] = var_26;
        }

        build_path_info(var_0, var_2, var_0.origin, var_10, var_4);
        var_0.fparams = calc_f_from_avatar(var_1);
        var_0.target_from_avatar = get_target_from_avatar(var_1);
        var_2.goal = "moving";
      }

      var_2.goal = "moving";
    }

    if(var_2.goal == "moving") {
      if(var_2.framedelay <= 0) {
        var_2.framedelay = 0;

        if(var_0.finished == 0) {
          if(isDefined(var_0.cut)) {
            var_0 cammove(var_10, var_7, var_18, var_19);
            var_0 camrotate(var_4, var_21, var_21 * 0.5, var_21 * 0.5);
            var_0.finished = 1;
          } else
            var_0.finished = update_camera_on_path(var_0, var_2);
        }

        if(var_0.finished) {
          var_0 cammove(var_10, var_20, var_20 * 0.5, var_20 * 0.5);
          var_0 camrotate(var_4, var_20, var_20 * 0.5, var_20 * 0.5);
          var_2.goal = "waiting";
        }
      }
    }

    set_avatar_dof();
  }

  if(isDefined(var_0.cut)) {
    if(isDefined(var_0.goal_location)) {
      var_0.origin = var_0.goal_location;
      var_0.angles = var_4;
    }

    var_0 dontinterpolate();
    var_0.cut = undefined;
  }

  if(getdvarint("5666", 0) == 0) {
    wait 1.0;
    setDvar("5666", "1");
    thread setvirtuallobbypresentable();
  }
}

setvirtuallobbypresentable() {
  level notify("cancel_vlp");
  level endon("cancel_vlp");

  if(level.vlavatars.size > 0 && isDefined(level.vlavatars[0]) && isDefined(level.vlavatars[0].primaryweapon) && isweaponloaded(level.vlavatars[0].primaryweapon)) {
    level.needtopresent = undefined;
    wait 0.5;
    setDvar("3965", "1");
  } else
    level.needtopresent = 1;
}

resetvirtuallobbypresentable() {
  level notify("cancel_vlp");
  level endon("cancel_vlp");
  level.needtopresent = undefined;
  wait 0.25;
  setDvar("3965", "0");
}

getmodifiedrotationangle(var_0, var_1, var_2) {
  if(_abs(var_1 - var_0.rotation_total) > 100) {
    if(var_1 >= 270) {
      var_0._id_09F8 = var_0._id_09F8 + -360 * var_2;

      if(var_0._id_09F8 == -360) {
        var_0._id_09F8 = 0;
      }
    }

    if(var_1 <= 100) {
      var_0._id_09F8 = var_0._id_09F8 + 360 * var_2;

      if(var_0._id_09F8 == 360) {
        var_0._id_09F8 = 0;
      }
    }
  }

  var_0.rotation_total = var_1;
  var_3 = var_1 * var_2 + var_0._id_09F8;
  return var_3;
}

cao_update(var_0, var_1, var_2) {
  maps\mp\hub_vl_base::rightstickrotateavatar(var_1, 0.5);
  var_2.caotolobbyframetimer = var_2.caotolobbyframedelay;
  var_3 = var_1.origin + (0, 0, -20) + anglesToForward(var_1.spawn_angles) * 120;
  var_2.zoom = var_2.cao_camera_ratio;
  var_2.dist = var_2.cao_neardist + (var_2.cao_fardist - var_2.cao_neardist) * var_2.zoom;
  var_4 = var_2.cao_camerazoff + var_2.cao_camerazoff_zoom * var_2.zoom;
  var_5 = var_2.cao_targetzoff + var_2.cao_targetzoff_zoom * (1 - var_2.zoom);
  var_2.tgt_camoffset_ratio = var_2.cao_camoffset_ratio + var_2.prelobby_ratio_zoom * (var_2.zoom - 1);
  var_0 update_camera_params_ratio(var_2);
  var_6 = var_2.ch_cyl_zoff_near + (var_2.ch_cyl_zoff_far - var_2.ch_cyl_zoff_near) * var_2.zoom;
  var_7 = var_1.origin + (0, 0, var_5);
  var_8 = var_7 - (var_3 + var_2.origin_offset);
  var_8 = var_2.dist * vectorNormalize(var_8);
  var_8 = (var_8[0], var_8[1], -1 * var_4);
  var_8 = var_2.dist * vectorNormalize(var_8);
  var_9 = var_7 - var_8;

  if(isDefined(self.caoavatarposoffset)) {
    var_7 = var_7 + self.caoavatarposoffset;
    var_9 = var_9 + self.caoavatarposoffset;
  }

  var_10 = -1 * var_8;
  var_11 = vectortoangles(var_10);
  var_2._id_0DCF = var_11[1] - var_1._id_92B8[1];
  var_12 = distance(var_0.origin, var_9);
  var_13 = var_12 / var_2.prelobby_movespeed;

  if(var_13 < 0.1) {
    var_13 = 0.1;
  }

  var_0 cammove(var_9, var_13, var_13 * 0.5, var_13 * 0.5);
  var_14 = calc_target_dir(var_9, var_7, var_2);
  var_15 = vectortoangles(var_14);
  var_0 camrotate(var_15, var_13, var_13 * 0.5, var_13 * 0.5);

  if(isDefined(var_0.cut)) {
    var_0 dontinterpolate();
    var_0.cut = undefined;
  }
}

start_menu_update(var_0, var_1) {}

clan_profile_update(var_0, var_1, var_2) {
  var_3 = (0, 87, 0);

  if(isDefined(var_1.avatar_spawnpoint)) {
    var_3 = (0, var_1.avatar_spawnpoint.angles[1] + 180, 0);
  }

  var_0 update_camera_params_ratio(var_2);
  var_4 = (14, 0, 0);
  var_5 = var_1.origin + var_4 + anglesToForward(var_1.avatar_spawnpoint.angles) * 110;
  var_6 = (var_5[0], var_5[1], var_2.gamelobbygroup_camera_normalz);
  var_0.goal_location = var_6;
  var_7 = distance(var_0.origin, var_6);
  var_8 = max(var_7 / var_2.gamelobby_movespeed, 0.1);
  var_9 = 0.2;
  var_0 cammove(var_6, var_8, 0, 0);
  var_0 camrotate(var_3, var_9, 0, 0);
  maps\mp\hub_vl_base::rightstickrotateavatar(var_1, 0.5);
}

monitor_vl_mode_change(var_0) {
  self endon("disconnect");

  for(;;) {
    var_1 = getdvarint("virtualLobbyMode", 0);

    if(var_0.mode != "cao" && var_0.mode != "cac") {
      if(var_0.mode != "prelobby" && var_1 == 0) {
        var_0.newmode = "game_lobby";
      }

      if(issubstr(var_0.mode, "prelobby") && var_1 == 1) {
        var_0.newmode = "game_lobby";
      }
    }

    waitframe();
  }
}

findpositionnum() {
  var_0 = self._id_0165;
  var_0 = int(var_0);
  return var_0;
}

monitor_player_removed() {}

wait_load_costume_show(var_0) {
  var_1 = isDefined(self.cac);
  var_2 = getdvarint("664") && var_0.ownerid != 0;

  if(!var_1 && !var_2) {
    show_avatar(var_0);
  }
}

wait_load_costume_timeout(var_0, var_1) {
  self endon("disconnect");
  var_1 endon("wait_load_costume");
  var_1 endon("death");
  wait(var_0);
  wait_load_costume_show(var_1);
  var_1 notify("wait_load_costume");
}

wait_load_costume(var_0, var_1) {
  self endon("disconnect");
  var_0 notify("wait_load_costume");
  var_0 endon("wait_load_costume");
  var_0 endon("death");

  if(!isDefined(var_1)) {
    var_1 = 1;
  }

  hide_avatar(var_0);
  thread wait_load_costume_timeout(5.0, var_0);

  for(var_2 = self loadcostumemodels(var_0.costume, var_0.team); !var_2; var_2 = self loadcostumemodels(var_0.costume, var_0.team)) {
    wait 0.1;
  }

  if(var_1) {
    wait_load_costume_show(var_0);
  }

  var_0 notify("wait_load_costume");
}

_id_8F7D(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13) {
  if(!isDefined(var_11)) {
    var_11 = 0;
  }

  if(!isDefined(var_12)) {
    var_12 = 0;
  }

  var_14 = !var_12;
  var_15 = "spectator";
  var_16 = "none";
  var_17 = maps\mp\hub_vl_base::_id_0C0E();
  var_18 = "avatar";
  var_19 = var_10;

  if(var_11) {
    var_18 = "cao_agent";
    var_19 = var_19 | 32768;
  }

  if(var_12) {
    var_18 = "clan_agent";
    var_19 = var_19 | 16384;
  }

  var_17.targetname = var_18;

  for(var_20 = 0; var_20 < 48; var_20++) {
    var_17._id_A561[var_20] = 0;
  }

  var_0.spawned_avatar = var_17;
  var_17.avatar_spawnpoint = var_0;
  var_17.costume = var_8;
  var_17._id_08D2 = 0;
  var_17.rotation_offset = 0;

  if(var_11) {
    var_21 = var_17.avatar_spawnpoint.origin;
  } else {
    var_21 = _getgroundposition(var_17.avatar_spawnpoint.origin, 20, 512, 60);
  }

  var_17.spawn_angles = (var_0.angles[0], var_0.angles[1] + var_17.rotation_offset, var_0.angles[2]);
  var_17.angles = var_17.spawn_angles;

  if(!var_12 && !level._id_A1FE) {
    var_17 show();
  }

  var_17.ownerid = var_10;
  var_17.origin = var_21;
  var_17.angles = var_17.spawn_angles;
  var_17._id_92B8 = var_17.spawn_angles;
  var_17.storedangley = var_17.angles[1];
  var_17.mouserot = 0;
  var_17.storedrightsticky = 0;
  var_17.rotation_total = 0;
  var_17._id_09F8 = 0;
  var_17._id_1E9B = 1;
  var_17.player = self;

  if(!isDefined(var_13) || !var_13) {
    var_22 = var_17.avatar_spawnpoint.origin + (0, 0, -11);
    var_17._id_20F1 = var_19;
    _id_05E0(self getentitynumber(), var_19, "create", var_22);
    _id_05E0(self getentitynumber(), var_19, "angles", var_17.angles);

    if(isDefined(self)) {
      var_17._id_A561[self.clientid] = 1;
    }
  }

  var_17.camera_tag_origin = (0, 0, 0);
  var_17.camera_tag_angles = (0, 0, 0);

  if(!isDefined(self.spawned_avatar)) {
    self.spawned_avatar = var_17;
  }

  if(var_11 == 1) {
    var_17._id_5541 = 1;
    var_2 = undefined;
    var_17.primaryweapon = undefined;
    var_17 use_animstate("cao_01", 1, "lobby_idle");
  } else if(var_12 == 1) {
    var_2 = undefined;
    var_17.primaryweapon = undefined;
    var_17 use_animstate("cao_01", 1, "lobby_idle");
  } else {
    level.vlavatars[var_10] = var_17;
    var_23 = var_17 getanimdata(var_2);
    var_17 use_animstate(var_23._id_0BB4, 1, var_23._id_0EE8);
    var_17 thread checkweapchange(var_2, var_3, var_4, self);
  }

  vl_avatar_loadout(self, var_10, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_17);
  thread wait_load_costume(var_17, var_14);

  if(getdvarint("664") && var_10 != 0 || var_12) {
    hide_avatar(var_17);
  } else {
    show_avatar(var_17);
  }

  return var_17;
}

checkweapchange(var_0, var_1, var_2, var_3) {
  var_3 endon("disconnect");
  self endon("death");
  self endon("free_avatar");
  self._id_9428 = "m1garand_mp";

  if(!isDefined(var_0) && var_0 != "none") {
    self._id_9428 = var_0;
  } else if(isDefined(var_1) && var_1 != "none") {
    self._id_9428 = var_1;
  } else if(isDefined(var_2) && var_2 != "none") {
    self._id_9428 = var_2;
  }

  var_4 = undefined;

  for(;;) {
    if(!isDefined(self.primaryweaponent)) {
      waitframe();
      continue;
    }

    if(isDefined(self) && isDefined(self.primaryweapon) && self.primaryweapon != "none") {
      var_5 = strtok(self.primaryweapon, "+");
      var_4 = var_5[0];
    }

    var_6 = self._id_0EEC;
    var_7 = level._id_0EE9["lobby_idle"]["cao_01"];
    var_8 = getanimdata(var_4);
    var_9 = var_7;

    if(isDefined(level._id_0EE9[var_8._id_0EE8]) && isDefined(level._id_0EE9[var_8._id_0EE8][var_8._id_0BB4])) {
      var_9 = level._id_0EE9[var_8._id_0EE8][var_8._id_0BB4];
    }

    if(isDefined(var_3.camparams.mode)) {
      if(var_3.camparams.newmode != "cao" && var_3.camparams.mode != "cao") {
        if(isDefined(self) && isDefined(var_4) && self.primaryweapon != "none") {
          var_12 = isweaponloaded(self.primaryweapon);
          var_13 = self._id_9428 != self.primaryweapon;
          var_14 = var_13 || var_6 != var_9;
          var_15 = self._id_9428 != "none" && _getweaponbasename(self._id_9428) != _getweaponbasename(self.primaryweapon);

          if(_weapontype(self.primaryweapon) == "melee") {
            hide_avatar_primary_weapon(self);
            hide_avatar_akimbo_weapon(self);
          } else if(var_14) {
            if(var_12) {
              if(var_15) {
                hide_avatar_primary_weapon(self);
                hide_avatar_akimbo_weapon(self);
                thread attachweapondelayed(self, var_3);
                thread showprimarydelayed(self, var_3);
              }

              if(level._id_A1FE) {
                _id_05E0(var_3 getentitynumber(), self._id_20F1, "prim_weapon", self.primaryweapon);
              } else {
                self.primaryweaponent setpickupweapon(self.primaryweapon);
              }

              if(issubstr(self.primaryweapon, "akimbo")) {
                if(var_15) {
                  _id_A58A(var_3, self);
                }
              } else
                _id_A593(var_3._id_01D6, self);

              self._id_9428 = self.primaryweapon;
              var_8 = getanimdata(var_4);
              self.camera_state = var_8.camera_state;
              thread _id_0EB2(var_8._id_0BB4, var_8._id_0EE8, var_3);
            }
          }
        }
      }
    }

    wait 0.5;
  }
}

isweaponloaded(var_0) {
  var_1 = 0;

  if(level.players.size > 0) {
    var_1 = level.players[0] worldweaponsloaded(var_0);

    if(!var_1) {
      level.players[0] loadweapons(var_0);
    }
  }

  return var_1;
}

attachweapondelayed(var_0, var_1) {
  wait(var_1.camparams.cacweaponattachdelaytime);
  attachprimaryweapon(var_0);
}

_id_0EB2(var_0, var_1, var_2) {
  wait(var_2.camparams.cacweaponanimdelaytime);
  use_animstate(var_0, undefined, var_1);
}

getanimdata(var_0) {
  var_0 = maps\mp\_utility::_id_4431(var_0);
  var_1 = spawnStruct();
  var_1._id_0BB4 = var_0;

  if(isDefined(var_0) && var_0 != "" && var_0 != "none") {
    var_1._id_0EE8 = tablelookup("mp/vlobby_cac_offsets.csv", 0, var_0, 5);
    var_1.camera_state = tablelookup("mp/vlobby_cac_offsets.csv", 0, var_0, 6);

    if(isDefined(var_1.camera_state)) {
      if(var_1.camera_state == "") {
        self.camera_state = "stand";
      } else {
        self.camera_state = var_1.camera_state;
      }
    }
  }

  if(!isDefined(var_1._id_0EE8) || var_1._id_0EE8 == "") {
    var_1._id_0EE8 = "lobby_idle";
    var_1._id_0BB4 = "cao_01";
    var_1.camera_state = "stand";
  }

  if(!isDefined(var_1.camera_state)) {
    var_1.camera_state = "stand";
  }

  if(!isDefined(self.camera_state)) {
    self.camera_state = var_1.camera_state;
  }

  return var_1;
}

_id_A593(var_0, var_1) {
  if(isDefined(var_1._id_0BA9)) {
    if(level._id_A1FE) {
      _id_05E0(var_1.player getentitynumber(), var_1._id_20F1, "sec_weapon", "");
    } else {
      _setentplayerxuidforemblem(var_1._id_0BA9, var_0, 1);
      var_1._id_0BA9 delete();
      var_1._id_0BA9 = undefined;
    }
  }
}

_id_A58A(var_0, var_1) {
  if(issubstr(var_1.primaryweaponent.primaryweapon, "akimbo")) {
    if(!isDefined(var_1._id_0BA9)) {
      if(level._id_A1FE) {
        var_2 = spawnStruct();
      } else {
        var_2 = spawn("weapon_" + var_1.primaryweapon, (0, 0, 0));
        var_3 = get_xuid_for_avatar(var_1);
        _setentplayerxuidforemblem(var_2, var_3);
      }

      var_1._id_0BA9 = var_2;
      var_2.primaryweapon = var_1.primaryweapon;
    } else if(var_1._id_0BA9.primaryweapon != var_1.primaryweapon)
      var_1._id_0BA9.primaryweapon = var_1.primaryweapon;

    if(!level._id_A1FE) {
      var_1._id_0BA9 setpickupweapon(var_1.primaryweapon);
      var_4 = "tag_weapon_left";

      if(issubstr(var_1._id_0BA9.primaryweapon, "combatknife")) {
        var_4 = "tag_inhand";
      }

      if(issubstr(var_1._id_0BA9.primaryweapon, "riotshield")) {
        var_4 = "tag_weapon_left";
      }

      var_1._id_0BA9 unlink();
      var_1._id_0BA9.origin = var_1 gettagorigin(var_4);
      var_1._id_0BA9.angles = var_1 gettagangles(var_4);
      var_1._id_0BA9 hide();
      var_1._id_0BA9 showtoplayer(var_0);
      var_1._id_0BA9 linktosynchronizedparent(var_1, var_4);
      var_1._id_0BA9 setowneroriginal(var_0);
    } else
      _id_05E0(var_0 getentitynumber(), var_1._id_20F1, "sec_weapon", var_1._id_0BA9.primaryweapon);

    if(issubstr(var_1.primaryweaponent.primaryweapon, "akimbo")) {
      thread showakimbodelayed(var_1, var_0);
    } else if(!isDefined(var_1._id_9428)) {
      if(!level._id_A1FE) {
        var_1._id_0BA9 hide();
        var_1._id_0BA9 hideallparts();
      }
    }
  }
}

vl_give_weapons(var_0, var_1) {
  if(!isDefined(var_1.primaryweapon)) {
    return;
  }
  if(!isDefined(var_1._id_0E93)) {
    return;
  }
  if(var_1.primaryweapon != "none") {
    if(!isDefined(var_1.primaryweaponent)) {
      if(level._id_A1FE) {
        var_2 = spawnStruct();
      } else {
        var_2 = spawn("weapon_" + var_1.primaryweapon, (0, 0, 0));
        var_3 = get_xuid_for_avatar(var_1);
        _setentplayerxuidforemblem(var_2, var_3);
      }

      var_2.targetname = "avatar_weapon";
      var_1.primaryweaponent = var_2;
      var_2.primaryweapon = var_1.primaryweapon;

      if(!level._id_A1FE) {
        var_1.primaryweaponent hide();
        var_1.primaryweaponent showtoplayer(var_0);
        var_1.primaryweaponent setpickupweapon(var_1.primaryweapon);
      }

      attachprimaryweapon(var_1);
    } else if(var_1.primaryweaponent.primaryweapon != var_1.primaryweapon)
      var_1.primaryweaponent.primaryweapon = var_1.primaryweapon;
  } else {}
}

attachprimaryweapon(var_0) {
  var_1 = undefined;

  if(isDefined(var_0.player)) {
    var_1 = var_0.player;
  }

  var_2 = "tag_weapon_right";

  if(issubstr(var_0.primaryweaponent.primaryweapon, "combatknife")) {
    var_2 = "tag_inhand";
  }

  if(issubstr(var_0.primaryweaponent.primaryweapon, "riotshield")) {
    var_2 = "tag_weapon_left";
  }

  if(level._id_A1FE) {
    _id_05E0(var_1 getentitynumber(), var_0._id_20F1, "prim_weapon", var_0.primaryweapon);
  } else {
    var_0.primaryweaponent unlink();
    var_0.primaryweaponent.origin = var_0 gettagorigin(var_2);
    var_0.primaryweaponent.angles = var_0 gettagangles(var_2);
    var_0.primaryweaponent linktosynchronizedparent(var_0, var_2);
    var_0.primaryweaponent setowneroriginal(var_1);
  }
}

showakimbodelayed(var_0, var_1) {
  var_0 endon("death");
  var_0.primaryweaponent endon("death");
  var_0 endon("hide_akimbo_weapon");
  wait(var_1.camparams.cacweapondelaytime);

  if(var_1.camparams.newmode != "cao" && var_1.camparams.mode != "cao") {
    if(issubstr(var_0.primaryweaponent.primaryweapon, "akimbo")) {
      if(!level._id_A1FE) {
        var_0._id_0BA9 showtoplayer(var_1);
      }
    }
  }
}

showprimarydelayed(var_0, var_1) {
  var_0 endon("death");
  var_0.primaryweaponent endon("death");
  var_0 endon("hide_primary_weapon");
  wait(var_1.camparams.cacweapondelaytime);
  var_2 = getdvarint("664") && var_0.ownerid != 0;

  if(var_1.camparams.newmode != "cao" && var_1.camparams.mode != "cao" && !var_2) {
    if(!level._id_A1FE) {
      var_0.primaryweaponent showtoplayer(var_1);
    }
  }
}

vl_avatar_costume(var_0, var_1, var_2) {
  if(isDefined(var_1)) {
    var_0.costume = var_1;
  }

  var_3 = "free";

  if(isDefined(var_0.previewcostume)) {
    if((var_0.previewcostume & 1) == 0) {
      var_3 = "allies";
    }

    if((var_0.previewcostume & 1) == 1) {
      var_3 = "axis";
    }
  }

  if(!isDefined(var_0.costume) || !_id_0510::validcostume(var_0.costume, var_3)) {
    if(isDefined(var_0.setnameplatematerial) && _id_0510::validcostume(var_0.setnameplatematerial, var_3)) {
      var_0.costume = var_0.setnameplatematerial;
    } else {
      var_0.costume = _id_0510::getdefaultcostume();
      var_0.setnameplatematerial = var_0.costume;
    }
  }

  if(isDefined(var_2) && var_2) {
    self.costume = var_0.costume;
    var_4 = _id_0510::playercostume();

    if(!isDefined(var_0._id_5097) || !var_0._id_5097) {
      if(level._id_A1FE) {
        _id_05E0(var_0.player getentitynumber(), var_0._id_20F1, "costume", var_0.costume[0], var_0.costume[1], var_0.costume[2], var_0.costume[3], var_0.costume[4], var_0.costume[5]);
      } else {
        var_0 set_grenadeammo(var_0.costume, "free");
      }
    }

    if(isDefined(self.cao_agent)) {
      var_5 = self.cao_agent;
      vl_avatar_costume(var_5, var_0.costume);

      if(!isDefined(var_5._id_5097) || !var_5._id_5097) {
        if(level._id_A1FE) {
          _id_05E0(var_5.player getentitynumber(), var_5._id_20F1, "costume", var_0.costume[0], var_0.costume[1], var_0.costume[2], var_0.costume[3], var_0.costume[4], var_0.costume[5]);
          return;
        }

        var_5 set_grenadeammo(var_5.costume, "free");
        return;
        return;
      }

      return;
    }
  } else if(!isDefined(var_0._id_5097) || !var_0._id_5097) {
    if(level._id_A1FE) {
      _id_05E0(var_0.player getentitynumber(), var_0._id_20F1, "costume", var_0.costume[0], var_0.costume[1], var_0.costume[2], var_0.costume[3], var_0.costume[4], var_0.costume[5]);
    } else {
      var_0 set_grenadeammo(var_0.costume, "free");
    }
  }
}

vl_avatar_loadout(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  if(!isDefined(var_10)) {
    var_10 = level.vlavatars[var_1];
  }

  var_11 = 0;

  if(isDefined(var_10.loadout) && var_10.loadout._id_012F >= 0) {
    var_11 = 1;
  }

  vl_avatar_costume(var_10, var_9);

  if(var_11 && isDefined(var_0)) {
    if(level._id_A1FE) {
      _id_05E0(var_0 getentitynumber(), var_10._id_20F1, "costume", var_10.costume[0], var_10.costume[1], var_10.costume[2], var_10.costume[3], var_10.costume[4], var_10.costume[5]);
    }

    var_0 set_grenadeammo(var_10.costume);
  }

  var_13 = "m1garand_mp";

  if(!isDefined(var_3)) {
    var_13 = undefined;
  } else if(var_3 != "none") {
    var_13 = var_3;
  } else if(isDefined(var_4) && var_4 != "none") {
    var_13 = var_4;
  } else if(isDefined(var_5) && var_5 != "none") {
    var_13 = var_5;
  }

  var_10._id_0079 = var_2;
  var_10.primaryweapon = var_13;
  var_10._id_01A0 = var_7;
  var_10._id_00ED = var_6;
  var_10.perks = var_8;
  vl_give_weapons(var_0, var_10);
}

monitor_class_select_or_weapon_change(var_0) {
  self endon("disconnect");

  for(;;) {
    self waittill("luinotifyserver", var_1, var_2);

    if((var_1 == "classpreview" || var_1 == "classpreview_postcopy") && isDefined(var_2)) {
      if(var_2 >= 0) {
        var_3 = var_2 & 15;
        var_4 = int(var_2 / 16);
        maps\mp\hub_vl_base::vlprint("classpreview " + var_1 + " controller=" + var_3 + "class=" + var_4 + " owner " + var_0);

        if(var_4 > 0) {
          self.cac = 1;
          self.currentselectedclass = var_4 - 1;
        }

        var_5 = var_1 == "classpreview_postcopy";
        var_6 = level.vlavatars[var_0];

        if(isDefined(var_6)) {
          self.vl_focus = var_0;
          virtual_lobby_set_class(var_0, "lobby" + (self.currentselectedclass + 1), !var_5);
          self.cac_weapon = var_6.primaryweapon;
        }

        level.forceavatarrefresh = var_5;
        continue;
      }

      self.cac = undefined;
    }
  }
}

monitor_cac_set_weapon(var_0, var_1) {
  var_2 = "";

  if(var_1 != "current" && var_1 != "none" && var_2 == "") {
    var_3 = tablelookup("mp/statstable.csv", 2, var_1, 9);

    if(var_3 == "") {
      var_3 = 0;
    }

    var_4 = maps\mp\gametypes\_class::buildweaponname(var_1, var_3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
  } else if(var_1 == "none")
    var_4 = "none";
  else {
    var_5 = level.vlavatars[var_0];
    var_4 = var_5.primaryweapon;
  }

  self.cac_weapon = var_4;
}

has_suffix(var_0, var_1) {
  if(var_0.size >= var_1.size) {
    if(getsubstr(var_0, var_0.size - var_1.size, var_0.size) == var_1) {
      return 1;
    }
  }

  return 0;
}

monitor_create_a_class(var_0) {
  self endon("disconnect");
  var_1 = [];

  while(!isDefined(self.camparams)) {
    self waittill("luinotifyserver", var_2, var_3);

    if(isDefined(var_3)) {
      var_1[var_1.size] = [var_2, var_3];
      continue;
    }

    var_1[var_1.size] = [var_2];
  }

  for(;;) {
    if(var_1.size > 0) {
      var_4 = var_1[0];
      var_5 = [];

      for(var_6 = 1; var_6 < var_1.size; var_6++) {
        var_5[var_5.size] = var_1[var_6];
      }

      var_1 = var_5;
      var_2 = var_4[0];

      if(var_4.size > 1) {
        var_3 = var_4[1];
      } else {
        var_3 = undefined;
      }
    } else
      self waittill("luinotifyserver", var_2, var_3);

    if(var_2 == "cac" && isDefined(var_3)) {
      if(var_3 == 0) {
        self.cac = undefined;
      } else {
        self.cac = 1;
      }

      self.vl_cao_focus = undefined;
      continue;
    }

    if(var_2 == "weapon_highlighted" && isDefined(var_3)) {
      if(issubstr(var_3, "stream:")) {
        var_7 = strtok(var_3, ":");

        if(var_7.size > 1) {
          var_8 = var_7[var_7.size - 1];

          if(!has_suffix(var_8, "_mp")) {
            var_8 = var_8 + "_mp";
          }

          maps\mp\hub_vl_base::vlprintln("weapon_stream: " + var_8);
          var_9 = [var_8];
          self loadweapons(var_9);
        }

        monitor_cac_set_weapon(var_0, "none");
      } else {
        maps\mp\hub_vl_base::vlprintln("weapon_highlighted" + var_3);
        monitor_cac_set_weapon(var_0, var_3);
      }

      continue;
    }

    if(var_2 == "lootscreen_weapon_highlighted" && isDefined(var_3)) {
      if(var_3 == "none") {
        self.cac = undefined;
      } else if(var_3 == "reset") {
        self.cac = 1;
      } else {
        self.cac = 1;
      }

      self.vl_cao_focus = undefined;
      continue;
    }

    var_10 = 0;

    if(var_2 == "preview_attach1") {
      var_10 = 1;
    } else if(var_2 == "preview_attach2") {
      var_10 = 2;
    } else if(var_2 == "preview_attach3") {
      var_10 = 3;
    }

    if(var_10 > 0 && isDefined(var_3)) {
      var_11 = level.vlavatars[var_0];
      var_12 = var_11.loadout;
      var_13 = var_12._id_013B;
      var_14 = tablelookup("mp/attachmenttable.csv", 0, var_12._id_013C, 3);
      var_15 = tablelookup("mp/attachmenttable.csv", 0, var_12._id_013D, 3);
      var_16 = tablelookup("mp/attachmenttable.csv", 0, var_12._id_013E, 3);
      var_17 = tablelookup("mp/attachmenttable.csv", 0, var_12._id_013F, 3);
      var_18 = tablelookup("mp/attachmenttable.csv", 0, var_12._id_0140, 3);
      var_19 = tablelookup("mp/attachmenttable.csv", 0, var_12._id_0141, 3);
      var_20 = var_12._id_0142;

      if(var_3 != "current") {
        if(var_10 == 1) {
          var_14 = var_3;
        } else if(var_10 == 2) {
          var_15 = var_3;
        } else if(var_10 == 3) {
          var_16 = var_3;
        } else if(var_10 == 4) {
          var_17 = var_3;
        } else if(var_10 == 5) {
          var_18 = var_3;
        } else if(var_10 == 6) {
          var_19 = var_3;
        }
      }

      self.cac_weapon = maps\mp\gametypes\_class::buildweaponname(maps\mp\_utility::_id_452B(var_13), var_14, var_15, var_16, var_17, var_18, var_19, maps\mp\_utility::_id_472C(var_13), var_20, 0, 0);
    }
  }
}

getfocusfromcontroller(var_0) {
  foreach(var_3, var_2 in level.vlavatars) {
    if(isDefined(var_2.loadout) && isDefined(var_2.loadout._id_012F) && var_2.loadout._id_012F == var_0) {
      return var_3;
    }
  }

  maps\mp\hub_vl_base::vlprintln("unable to find avatar for controller " + var_0);
  return -1;
}

virtual_lobby_set_class(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(self.pers["class"]) && self.pers["class"] == var_1 && (!isDefined(var_3) || !var_3)) {
    return;
  }
  self.pers["class"] = var_1;
  self.class = var_1;
  maps\mp\gametypes\_class::setclass(self.pers["class"]);
  self.tag_stowed_back = undefined;
  self.tag_stowed_hip = undefined;
  maps\mp\gametypes\_class::giveandapplyloadout(self.pers["team"], self.pers["class"]);

  if(var_2) {
    vl_avatar_loadout(self, var_0, self.primaryweapon, self.botclearscriptenemy, self._id_60FA, self.loadoutequipment, self.loadoutoffhand, self.perks, self.costume);

    if(isDefined(self.cao_agent)) {
      vl_avatar_loadout(self, var_0, undefined, self.botclearscriptenemy, self._id_60FA, self.loadoutequipment, self.loadoutoffhand, self.perks, self.costume, self.cao_agent);
    }
  }
}

grab_players_classes() {
  var_0 = ["privateMatchCustomClasses", "customClasses"];
  var_1 = [10, 20];
  var_2 = 0;
  self.loadouts = [];
  self.currentselectedclass = 0;

  foreach(var_4 in var_0) {
    level.forcecustomclassloc = var_4;
    self.loadouts[var_4] = [];
    var_5 = var_1[var_2];
    var_2++;

    for(var_6 = 0; var_6 < var_5; var_6++) {
      self.loadouts[var_4][var_6] = _id_04E0::_id_4834(var_4, var_6);
    }
  }

  level.forcecustomclassloc = undefined;
}

_id_A0AD(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14, var_15, var_16, var_17, var_18, var_19, var_20, var_21, var_22, var_23, var_24, var_25, var_26, var_27, var_28, var_29, var_30, var_31, var_32) {
  var_33 = int(self.currentselectedclass);
  var_34 = maps\mp\_utility::cac_getcustomclassloc();
  self.loadouts[var_34][var_33]["division"] = var_0;
  self.loadouts[var_34][var_33]["primaryWeaponStruct"] = maps\mp\_utility::_id_473C(var_1, 0);
  self.loadouts[var_34][var_33]["primaryAttachmentsGUID"][0] = var_2;
  self.loadouts[var_34][var_33]["primaryAttachmentsGUID"][1] = var_3;
  self.loadouts[var_34][var_33]["primaryAttachmentsGUID"][2] = var_4;
  self.loadouts[var_34][var_33]["primaryAttachmentsGUID"][3] = var_5;
  self.loadouts[var_34][var_33]["primaryAttachmentsGUID"][4] = var_6;
  self.loadouts[var_34][var_33]["primaryAttachmentsGUID"][5] = var_7;
  self.loadouts[var_34][var_33]["primaryCamoGUID"] = var_8;
  self.loadouts[var_34][var_33]["primaryReticleGUID"] = var_9;
  self.loadouts[var_34][var_33]["primaryCustomization"] = var_31;
  self.loadouts[var_34][var_33]["secondaryWeaponStruct"] = maps\mp\_utility::_id_473C(var_10, 0);
  self.loadouts[var_34][var_33]["secondaryAttachmentsGUID"][0] = var_11;
  self.loadouts[var_34][var_33]["secondaryAttachmentsGUID"][1] = var_12;
  self.loadouts[var_34][var_33]["secondaryAttachmentsGUID"][2] = var_13;
  self.loadouts[var_34][var_33]["secondaryAttachmentsGUID"][3] = var_14;
  self.loadouts[var_34][var_33]["secondaryAttachmentsGUID"][4] = var_15;
  self.loadouts[var_34][var_33]["secondaryAttachmentsGUID"][5] = var_16;
  self.loadouts[var_34][var_33]["secondaryCamoGUID"] = var_17;
  self.loadouts[var_34][var_33]["secondaryReticleGUID"] = var_18;
  self.loadouts[var_34][var_33]["secondaryCustomization"] = var_32;
  self.loadouts[var_34][var_33]["meleeWeaponStruct"] = maps\mp\_utility::_id_473C(var_19, 0);
  self.loadouts[var_34][var_33]["equipmentStruct"] = maps\mp\_utility::_id_44CE(var_20, 0);
  self.loadouts[var_34][var_33]["lethalGUID"] = var_20;
  self.loadouts[var_34][var_33]["offhandStruct"] = maps\mp\_utility::_id_44CE(var_21, 0);
  self.loadouts[var_34][var_33]["tacticalGUID"] = var_21;
  self.loadouts[var_34][var_33]["perkGUID0"] = var_22;
  self.loadouts[var_34][var_33]["perkGUID1"] = var_23;
  self.loadouts[var_34][var_33]["perkGUID2"] = var_24;
  self.loadouts[var_34][var_33]["perkGUID3"] = var_25;
  self.loadouts[var_34][var_33]["perkGUID4"] = var_26;
  self.loadouts[var_34][var_33]["perkGUID5"] = var_27;
  self.loadouts[var_34][var_33]["perkGUID6"] = var_28;
  self.loadouts[var_34][var_33]["perkGUID7"] = var_29;
  self.loadouts[var_34][var_33]["perkGUID8"] = var_30;
}

loadout_changed(var_0, var_1) {
  if(!isDefined(var_0)) {
    return 1;
  }

  if(var_0._id_013B != var_1._id_013B) {
    return 1;
  }

  if(var_0._id_013C != var_1._id_013C) {
    return 1;
  }

  if(var_0._id_013D != var_1._id_013D) {
    return 1;
  }

  if(var_0._id_013E != var_1._id_013E) {
    return 1;
  }

  if(var_0._id_013F != var_1._id_013F) {
    return 1;
  }

  if(var_0._id_0140 != var_1._id_0140) {
    return 1;
  }

  if(var_0._id_0141 != var_1._id_0141) {
    return 1;
  }

  if(var_0._id_0142 != var_1._id_0142) {
    return 1;
  }

  if(var_0._id_0143 != var_1._id_0143) {
    return 1;
  }

  if(var_0._id_016E != var_1._id_016E) {
    return 1;
  }

  if(var_0._id_0170 != var_1._id_0170) {
    return 1;
  }

  if(var_0._id_0171 != var_1._id_0171) {
    return 1;
  }

  if(var_0._id_0172 != var_1._id_0172) {
    return 1;
  }

  if(var_0.disableforcethirdpersonwhenfollowing != var_1.disableforcethirdpersonwhenfollowing) {
    return 1;
  }

  if(var_0._id_8351 != var_1._id_8351) {
    return 1;
  }

  if(var_0._id_8352 != var_1._id_8352) {
    return 1;
  }

  if(var_0._id_0173 != var_1._id_0173) {
    return 1;
  }

  if(var_0._id_0174 != var_1._id_0174) {
    return 1;
  }

  if(var_0._id_01A0 != var_1._id_01A0) {
    return 1;
  }

  if(var_0._id_00ED != var_1._id_00ED) {
    return 1;
  }

  return 0;
}

costume_changed(var_0, var_1, var_2) {
  if(!isDefined(var_0)) {
    if(!isDefined(var_1)) {
      return 0;
    }

    return 1;
  }

  if(var_0.size != var_1.size) {
    return 1;
  }

  if(!_id_0510::validcostume(var_1, var_2)) {
    return 0;
  }

  for(var_3 = 0; var_3 < var_1.size; var_3++) {
    if(var_1[var_3] < 0) {
      return 0;
    }

    if(var_0[var_3] != var_1[var_3]) {
      return 1;
    }
  }

  return 0;
}

setdefaultcostumeifneeded(var_0) {
  if(var_0[level.costumecat2idx["head"]] == 0) {
    var_0[level.costumecat2idx["head"]] = 1;
  }

  if(!var_0[level.costumecat2idx["shirt"]]) {
    var_0[level.costumecat2idx["shirt"]] = 1;
  }

  if(!var_0[level.costumecat2idx["pants"]]) {
    var_0[level.costumecat2idx["pants"]] = 1;
  }

  if(!var_0[level.costumecat2idx["gear"]]) {
    var_0[level.costumecat2idx["gear"]] = 1;
  }

  return var_0;
}

_id_3B94(var_0) {
  var_1 = undefined;

  foreach(var_3 in level.players) {
    if(var_3._id_01D6 == var_0) {
      var_1 = var_3;
      break;
    }
  }

  return var_1;
}

monitor_member_class_changes() {
  level.mccqueue = [];
  var_0 = maps\mp\_utility::_id_4604();

  for(;;) {
    while(!isDefined(level.players) || level.players.size == 0) {
      waitframe();
    }

    while(isDefined(level.players) && level.players.size > 0) {
      var_1 = [];
      var_2 = [];
      var_3 = 0;
      var_4 = 0;
      var_5 = 0;

      foreach(var_7 in level.mccqueue) {
        var_8 = var_7._id_0079;
        var_9 = var_7._id_013B;
        var_10[0] = maps\mp\_utility::_id_452A(tablelookup("mp/attachmenttable.csv", 0, var_7._id_013C, 3));
        var_10[1] = maps\mp\_utility::_id_452A(tablelookup("mp/attachmenttable.csv", 0, var_7._id_013D, 3));
        var_10[2] = maps\mp\_utility::_id_452A(tablelookup("mp/attachmenttable.csv", 0, var_7._id_013E, 3));
        var_10[3] = maps\mp\_utility::_id_452A(tablelookup("mp/attachmenttable.csv", 0, var_7._id_013F, 3));
        var_10[4] = maps\mp\_utility::_id_452A(tablelookup("mp/attachmenttable.csv", 0, var_7._id_0140, 3));
        var_10[5] = maps\mp\_utility::_id_452A(tablelookup("mp/attachmenttable.csv", 0, var_7._id_0141, 3));
        var_11 = var_7._id_0144;
        var_12 = maps\mp\_utility::_id_452A(tablelookup("mp/camoTable.csv", 0, var_7._id_0142, 1));
        var_13 = maps\mp\_utility::_id_452A(tablelookup("mp/camoTable.csv", 0, var_7._id_0143, 1));
        var_14 = maps\mp\_utility::_id_452A(tablelookup("mp/reticleTable.csv", 0, var_7._id_0145, 1));
        var_15 = var_7._id_016E;
        var_16[0] = maps\mp\_utility::_id_452A(tablelookup("mp/attachmenttable.csv", 0, var_7._id_0170, 3));
        var_16[1] = maps\mp\_utility::_id_452A(tablelookup("mp/attachmenttable.csv", 0, var_7._id_0171, 3));
        var_16[2] = maps\mp\_utility::_id_452A(tablelookup("mp/attachmenttable.csv", 0, var_7._id_0172, 3));
        var_16[3] = 0;
        var_16[4] = 0;
        var_16[5] = 0;
        var_17 = var_7._id_0176;
        var_18 = maps\mp\_utility::_id_452A(tablelookup("mp/camoTable.csv", 0, var_7._id_0173, 1));
        var_19 = maps\mp\_utility::_id_452A(tablelookup("mp/camoTable.csv", 0, var_7._id_0174, 1));
        var_20 = maps\mp\_utility::_id_452A(tablelookup("mp/reticleTable.csv", 0, var_7._id_0177, 1));
        var_21 = var_7._id_0101;
        var_22 = maps\mp\_utility::_id_452A(tablelookup(var_0, 0, var_7._id_00ED, 1));
        var_23 = maps\mp\_utility::_id_452A(tablelookup(var_0, 0, var_7._id_01A0, 1));
        var_24[0] = maps\mp\_utility::_id_452A(tablelookup(var_0, 0, var_7._id_0123, 1));
        var_24[1] = maps\mp\_utility::_id_452A(tablelookup(var_0, 0, var_7._id_0124, 1));
        var_24[2] = maps\mp\_utility::_id_452A(tablelookup(var_0, 0, var_7._id_0125, 1));
        var_24[3] = maps\mp\_utility::_id_452A(tablelookup(var_0, 0, var_7._id_0126, 1));
        var_24[4] = maps\mp\_utility::_id_452A(tablelookup(var_0, 0, var_7._id_0127, 1));
        var_24[5] = maps\mp\_utility::_id_452A(tablelookup(var_0, 0, var_7._id_0128, 1));
        var_24[6] = maps\mp\_utility::_id_452A(tablelookup(var_0, 0, var_7._id_0129, 1));
        var_24[7] = maps\mp\_utility::_id_452A(tablelookup(var_0, 0, var_7._id_012A, 1));
        var_24[8] = maps\mp\_utility::_id_452A(tablelookup(var_0, 0, var_7._id_012B, 1));
        var_25 = 1;

        if(!maps\mp\gametypes\_class::isvalidprimary(var_9, var_25) && !maps\mp\gametypes\_class::isvalidsecondary(var_15, var_25)) {
          var_9 = maps\mp\gametypes\_class::table_getweapon(level.classtablename, 10, 0);

          for(var_26 = 0; var_26 < 6; var_26++) {
            var_10[var_26] = 0;
          }
        }

        if(!maps\mp\gametypes\_class::isvalidsecondary(var_15, var_25)) {
          var_15 = maps\mp\gametypes\_class::table_getweapon(level.classtablename, 10, 1);

          for(var_26 = 0; var_26 < 6; var_26++) {
            var_16[var_26] = 0;
          }
        }

        var_27 = maps\mp\gametypes\_class::buildweaponname(maps\mp\_utility::_id_452B(var_9), var_10[0], var_10[1], var_10[2], var_10[3], var_10[4], var_10[5], maps\mp\_utility::_id_472C(var_9), var_12, var_14, var_11);
        var_28 = maps\mp\gametypes\_class::buildweaponname(maps\mp\_utility::_id_452B(var_15), var_16[0], var_16[1], var_16[2], var_16[3], var_16[4], var_16[5], maps\mp\_utility::_id_472C(var_15), var_18, var_20, var_17);
        var_29 = maps\mp\_utility::_id_452B(var_21);
        var_30 = [];
        var_30[level.costumecat2idx["shirt"]] = var_7._id_017F;
        var_30[level.costumecat2idx["head"]] = var_7._id_00B9;
        var_30[level.costumecat2idx["pants"]] = var_7._id_011A;
        var_30[level.costumecat2idx["eyewear"]] = var_7._id_0091;
        var_30[level.costumecat2idx["hat"]] = var_7._id_00B8;
        var_30[level.costumecat2idx["gear"]] = var_7._id_00A8;
        var_31 = [];

        if(!isDefined(level.xuid2ownerid[var_7._id_01D6]) && maps\mp\hub_vl_base::_id_0BC6()) {
          maps\mp\hub_vl_base::reuse_avatar(var_7._id_01D6);
        }

        var_32 = _id_3B94(var_7._id_01D6);

        if(isDefined(var_32) && var_7._id_011C != 0) {
          var_2[var_4] = var_32;
          var_4++;
        } else if(!isDefined(var_32)) {}

        if(!isDefined(level.xuid2ownerid[var_7._id_01D6])) {
          if(var_7._id_011C != 0) {
            var_33 = maps\mp\hub_vl_base::_id_0902(var_7._id_01D6);
            maps\mp\hub_vl_base::vlprint("PartyMemberClassChange " + var_7._id_01D6 + " : " + var_27 + "," + var_28 + "," + var_22 + "," + var_23 + "\n");
            setDvar("1999", level.xuid2ownerid.size);
            var_34 = getspawnpoint(var_33);

            if(isDefined(var_32)) {
              var_1[var_3] = var_32 _id_8F7D(var_34, var_8, var_27, var_28, var_29, var_22, var_23, var_31, var_30, var_7.name, var_33, 0, 0, 0);
            } else {
              var_1[var_3] = _id_8F7D(var_34, var_8, var_27, var_28, var_29, var_22, var_23, var_31, var_30, var_7.name, var_33, 0, 0, 0);
            }

            var_3++;
            maps\mp\hub_vl_base::avatar_after_spawn(var_33);
            _setentplayerxuidforemblem(level.vlavatars[var_33], var_7._id_01D6);
            level.vlavatars[var_33].loadout = var_7;
            level.vlavatars[var_33].membertimeout = gettime() + 4000;
            var_35 = _getEnt("cao_spawnpoint", "targetname");
            var_32._id_1FA3 = var_35;
            var_32._id_1F9D = var_27;

            if(isDefined(level.vl_clanprofile_focus)) {
              hide_avatar(level.vlavatars[var_33]);
            }
          }
        } else {
          var_33 = level.xuid2ownerid[var_7._id_01D6];
          var_36 = level.vlavatars[var_33];

          if(var_7._id_011C != 0) {
            var_1[var_3] = var_36;
            var_3++;
          }

          if(var_7._id_012F >= 0) {
            foreach(var_38 in level.players) {
              if(var_38.vl_focus == var_33) {
                var_38 _id_A0AD(var_8, var_9, var_10[0], var_10[1], var_10[2], var_10[3], var_10[4], var_10[5], var_12, var_14, var_15, var_16[0], var_16[1], var_16[2], var_16[3], var_16[4], var_16[5], var_18, var_20, var_21, var_22, var_23, var_24[0], var_24[1], var_24[2], var_24[3], var_24[4], var_24[5], var_24[6], var_24[7], var_24[8], var_11, var_17);
              }
            }

            if(isDefined(var_36.previewcostume)) {
              if(isDefined(var_36.costumes) && isDefined(var_36.costumes[var_36.previewcostume])) {
                var_30 = var_36.costumes[var_36.previewcostume];
              } else {
                var_30 = level.players[0] maps\mp\gametypes\_class::cao_getcostumebyindex(var_36.previewcostume);
              }

              var_30 = setdefaultcostumeifneeded(var_30);

              if(!isDefined(var_36.costumes)) {
                var_36.costumes = [];
              }

              var_36.costumes[var_36.previewcostume] = var_30;

              if(var_36.previewgearcategory != "none") {
                var_40 = level.costumecat2idx[var_36.previewgearcategory];
                var_30[var_40] = var_36.previewgearid;
              }
            }
          }

          var_41 = "free";

          if(isDefined(var_36.previewcostume)) {
            if((var_36.previewcostume & 1) == 0) {
              var_41 = "allies";
            }

            if((var_36.previewcostume & 1) == 1) {
              var_41 = "axis";
            }

            var_30 = _func_282(var_30, var_41);
          }

          if(loadout_changed(var_36.loadout, var_7) || costume_changed(var_36.costume, var_30, var_41) || isDefined(level.forceavatarrefresh) && level.forceavatarrefresh) {
            var_5 = 1;
            maps\mp\hub_vl_base::vlprint("Updating xuid " + var_7._id_01D6 + " with ownerId=" + var_33 + "\n");
            maps\mp\hub_vl_base::vlprint("PartyMemberClassChange " + var_7._id_01D6 + " : " + var_27 + "," + var_28 + "," + var_22 + "," + var_23 + "\n");

            if(isDefined(var_36.player)) {
              var_36.player.costume = var_30;
            }

            vl_avatar_loadout(var_36.player, var_33, var_27, var_28, var_29, var_22, var_23, var_31, var_30);

            if(var_7._id_012F >= 0 && isDefined(var_36.player.cao_agent)) {
              vl_avatar_loadout(var_36.player, var_33, undefined, var_28, "none", var_22, var_23, var_31, var_30, var_36.player.cao_agent);
            }

            var_36.loadout = var_7;
            level.forceavatarrefresh = 0;
          }
        }

        if(var_7._id_011C != 0) {
          var_3++;
        }
      }

      _id_13B9(var_1, var_2, var_5);
      level.mccqueue = [];
      maps\mp\hub_vl_base::update_avatars();
      waitframe();
    }
  }
}

_id_13B9(var_0, var_1, var_2) {
  var_3 = 0;

  foreach(var_5 in var_0) {
    var_5 _id_4697(var_3);
    var_6 = _getgroundposition(var_5.avatar_spawnpoint.origin, 20, 512, 60);
    var_7 = distance(var_6, var_5.origin) >= 0.1;
    var_5.origin = var_6;
    hide_avatar(var_5);

    if(isDefined(var_5._id_20F1)) {
      var_8 = var_5._id_20F1;
    } else {
      var_8 = var_3 + 1;
      var_5._id_20F1 = var_8;
    }

    foreach(var_10 in var_1) {
      if(var_5._id_A561[var_10.clientid] == 0) {
        var_11 = var_10 getentitynumber();
        _id_05E0(var_10 getentitynumber(), var_8, "create", var_5.origin);
        _id_05E0(var_10 getentitynumber(), var_8, "angles", var_5.angles);
        _id_05E0(var_10 getentitynumber(), var_8, "costume", var_5.costume[0], var_5.costume[1], var_5.costume[2], var_5.costume[3], var_5.costume[4], var_5.costume[5]);

        if(isDefined(var_5._id_0EEC)) {
          _id_05E0(var_10 getentitynumber(), var_8, "anim", var_5._id_0EEC);
        }

        var_5._id_A561[var_10.clientid] = 1;
      } else if(var_2)
        _id_05E0(var_10 getentitynumber(), var_8, "costume", var_5.costume[0], var_5.costume[1], var_5.costume[2], var_5.costume[3], var_5.costume[4], var_5.costume[5]);

      if(var_7) {
        _id_05E0(var_10 getentitynumber(), var_8, "pos", var_5.origin);
      }
    }

    show_avatar(var_5);
    var_3++;
  }
}

override_member_loadout_for_practice_round(var_0) {
  if(!isDefined(level.practice_round_costume)) {
    level.practice_round_max_costumes = _tablegetcolumncount(level.practiceroundcostumetablename) - 1;
    level.practice_round_costume = randomint(level.practice_round_max_costumes);
  }

  if(!isDefined(level.practice_round_class)) {
    var_1 = _tablegetcolumncount(level.practiceroundclasstablename) - 1;
    level.practice_round_class = randomint(var_1);
  }

  var_4 = var_0;
  var_5 = _getcostumefromtable(level.practiceroundcostumetablename, level.practice_round_costume + 1);
  var_4._id_017F = var_5[level.costumecat2idx["shirt"]];
  var_4._id_00B9 = var_5[level.costumecat2idx["head"]];
  var_4._id_011A = var_5[level.costumecat2idx["pants"]];
  var_4._id_0091 = var_5[level.costumecat2idx["eyewear"]];
  var_4._id_00B8 = var_5[level.costumecat2idx["hat"]];
  var_4._id_00A8 = var_5[level.costumecat2idx["gear"]];
  var_6 = level.practice_round_class;
  var_7 = var_6 + 1;
  var_8 = tablelookup(level.practiceroundclasstablename, 0, "loadoutPrimaryAttachment", var_7);
  var_9 = tablelookup(level.practiceroundclasstablename, 0, "loadoutPrimaryAttachment2", var_7);
  var_10 = tablelookup(level.practiceroundclasstablename, 0, "loadoutPrimaryAttachment3", var_7);
  var_11 = tablelookup(level.practiceroundclasstablename, 0, "loadoutPrimaryAttachment4", var_7);
  var_12 = tablelookup(level.practiceroundclasstablename, 0, "loadoutPrimaryAttachment5", var_7);
  var_13 = tablelookup(level.practiceroundclasstablename, 0, "loadoutPrimaryAttachment6", var_7);
  var_4._id_7709 = maps\mp\_utility::_id_473C(maps\mp\gametypes\_class::table_getweapon(level.practiceroundclasstablename, var_7, 0), 0);
  var_4._id_013C = int(tablelookup("mp/attachmenttable.csv", 3, var_8, 0));
  var_4._id_013D = int(tablelookup("mp/attachmenttable.csv", 3, var_9, 0));
  var_4._id_013E = int(tablelookup("mp/attachmenttable.csv", 3, var_10, 0));
  var_4._id_013F = int(tablelookup("mp/attachmenttable.csv", 3, var_11, 0));
  var_4._id_0140 = int(tablelookup("mp/attachmenttable.csv", 3, var_12, 0));
  var_4._id_0141 = int(tablelookup("mp/attachmenttable.csv", 3, var_13, 0));
  var_4._id_76F5 = maps\mp\gametypes\_class::table_getweaponcamo(level.practiceroundclasstablename, var_7, 0);
  var_4._id_7700 = maps\mp\gametypes\_class::table_getweaponreticle(level.practiceroundclasstablename, var_7, 0);
  var_14 = tablelookup(level.practiceroundclasstablename, 0, "loadoutSecondaryAttachment", var_7);
  var_15 = tablelookup(level.practiceroundclasstablename, 0, "loadoutSecondaryAttachment2", var_7);
  var_16 = tablelookup(level.practiceroundclasstablename, 0, "loadoutSecondaryAttachment3", var_7);
  var_17 = tablelookup(level.practiceroundclasstablename, 0, "loadoutSecondaryAttachment4", var_7);
  var_18 = tablelookup(level.practiceroundclasstablename, 0, "loadoutSecondaryAttachment5", var_7);
  var_19 = tablelookup(level.practiceroundclasstablename, 0, "loadoutSecondaryAttachment6", var_7);
  var_4.botgetscriptgoalradius = maps\mp\_utility::_id_473C(maps\mp\gametypes\_class::table_getweapon(level.practiceroundclasstablename, var_7, 1), 0);
  var_4._id_0170 = int(tablelookup("mp/attachmenttable.csv", 3, var_14, 0));
  var_4._id_0171 = int(tablelookup("mp/attachmenttable.csv", 3, var_15, 0));
  var_4._id_0172 = int(tablelookup("mp/attachmenttable.csv", 3, var_16, 0));
  var_4.disableforcethirdpersonwhenfollowing = int(tablelookup("mp/attachmenttable.csv", 3, var_17, 0));
  var_4._id_8351 = int(tablelookup("mp/attachmenttable.csv", 3, var_18, 0));
  var_4._id_8352 = int(tablelookup("mp/attachmenttable.csv", 3, var_19, 0));
  var_4.botsetscriptmove = maps\mp\gametypes\_class::table_getweaponcamo(level.practiceroundclasstablename, var_7, 1);
  var_4.botsetscriptenemy = maps\mp\gametypes\_class::table_getweaponreticle(level.practiceroundclasstablename, var_7, 1);
  return var_4;
}

_id_0953(var_0) {
  if(getdvarint("664")) {
    var_0 = override_member_loadout_for_practice_round(var_0);
  }

  for(var_1 = 0; var_1 < level.mccqueue.size; var_1++) {
    if(level.mccqueue[var_1]._id_01D6 == var_0._id_01D6) {
      level.mccqueue[var_1] = var_0;
      var_0 = undefined;
      break;
    }
  }

  if(isDefined(var_0)) {
    level.mccqueue[level.mccqueue.size] = var_0;
  }
}

party_members(var_0) {
  if(!isDefined(level.xuid2ownerid)) {
    return;
  }
  foreach(var_2 in var_0) {
    var_3 = var_2._id_01D6;
    var_4 = level.xuid2ownerid[var_3];

    if(isDefined(var_4)) {
      var_5 = level.vlavatars[var_4];

      if(isDefined(var_5)) {
        var_5.membertimeout = gettime() + 2000;
        var_5.memberhastimedout = undefined;
      }
    }

    if(var_2._id_013B >= 0) {
      _id_0953(var_2);
    }
  }
}

monitor_member_timeouts() {
  for(;;) {
    var_0 = getdvarint("splitscreen", 0);
    var_1 = _isonlinegame();
    var_2 = _issystemlink();

    foreach(var_5, var_4 in level.vlavatars) {
      if(maps\mp\hub_vl_base::avatar_scheduled_for_removal(var_5)) {
        continue;
      }
      if(var_4.membertimeout >= 0) {
        if(var_4.membertimeout < gettime()) {
          if(var_5 == 0 && !isDefined(var_4.memberhastimedout)) {
            var_4.membertimeout = gettime() + 2000;
            var_4.memberhastimedout = 1;
            continue;
          }

          maps\mp\hub_vl_base::vlprint("Schedule removal of ownerId " + var_5 + " from timeout\n");
          maps\mp\hub_vl_base::springcamdisabled(var_5);
        }
      }
    }

    waitframe();
  }
}

get_e3_costume(var_0) {
  var_1 = "mp/E3CostumeTable.csv";
  var_2 = [];

  for(var_3 = 0; var_3 < level.costumecat2idx.size; var_3++) {
    var_2[var_3] = int(_tablelookupbyrow(var_1, var_3 + 1, var_0 + 1));
  }

  return var_2;
}

monitor_debug_addfakemembers(var_0, var_1) {}

monitor_member_focus_change() {
  self endon("disconnect");

  for(;;) {
    self waittill("luinotifyserver", var_0, var_1);

    if(var_0 == "member_select") {
      self.vl_focus = level.xuid2ownerid[var_1];

      if(!isDefined(self.vl_focus)) {
        maps\mp\hub_vl_base::vlprint("vl_focus undefined, setting to 0\n");
        self.vl_focus = 0;
      }

      maps\mp\hub_vl_base::vlprint("selected member " + var_1 + " ownerId=" + self.vl_focus + "\n");
    }

    if(var_0 == "vlpresentable") {
      maps\mp\hub_vl_base::vlprint("in main menu\n");
      thread setvirtuallobbypresentable();
    }

    if(var_0 == "leave_lobby") {
      maps\mp\hub_vl_base::vlprint("leave_lobby xuid=" + var_1 + "\n");

      if(var_1 == "0") {
        foreach(var_1, var_3 in level.xuid2ownerid) {
          maps\mp\hub_vl_base::vlprint("Schedule removal of ownerId " + var_3 + "\n");
          maps\mp\hub_vl_base::springcamdisabled(var_3, 0.25);
        }
      } else {
        var_3 = level.xuid2ownerid[var_1];

        if(isDefined(var_3)) {
          maps\mp\hub_vl_base::vlprint("Schedule removal of ownerId " + var_3 + "\n");
          maps\mp\hub_vl_base::springcamdisabled(var_3, 0.25);
        }
      }

      thread resetvirtuallobbypresentable();
    }
  }
}

monitor_cao_set_cao_focus(var_0, var_1) {
  if(var_0 < 0) {
    self.vl_cao_focus = undefined;
  } else {
    self.vl_cao_focus = var_1;
  }
}

cao_set_costumes_from_lua(var_0, var_1) {
  maps\mp\hub_vl_base::vlprintln("Cao set costumes from lua:" + var_0);
  var_2 = strtok(var_0, "#");

  foreach(var_4 in var_2) {
    var_5 = strtok(var_4, "|");

    if(var_5.size > 0) {
      var_6 = level.vlavatars[var_1];

      if(isDefined(var_6)) {
        var_6._id_08D2 = int(var_5[1]);

        for(var_7 = 2; var_7 < var_5.size; var_7++) {
          var_8 = strtok(var_5[var_7], ",");
          var_9 = [];

          for(var_10 = 1; var_10 < var_8.size; var_10++) {
            var_9[var_9.size] = int(var_8[var_10]);
          }

          if(!isDefined(var_6.costumes)) {
            var_6.costumes = [];
          }

          var_6.costumes[int(var_8[0])] = var_9;
        }
      }
    }
  }
}

monitor_cao_set_costume_preview(var_0, var_1) {
  var_2 = strtok(var_0, ":");
  var_3 = int(var_2[0]);
  var_4 = strtok(var_2[1], ",");
  var_5 = level.vlavatars[var_1];

  if(isDefined(var_5)) {
    var_5.previewcostume = int(var_4[0]);
    var_5.previewgearcategory = var_4[1];
    var_5.previewgearid = int(var_4[2]);
  }

  return var_5;
}

monitor_create_an_operator(var_0) {
  self endon("disconnect");

  for(;;) {
    self waittill("luinotifyserver", var_1, var_2);

    if(var_1 == "cao") {
      monitor_cao_set_cao_focus(var_2, var_0);
      self.caoavatarposoffset = undefined;
      var_3 = level.vlavatars[var_0];

      if(var_2 < 0 && isDefined(var_3)) {
        var_3.previewgearcategory = undefined;
        var_3.previewgearid = undefined;
        var_3.previewcostume = undefined;

        if(isDefined(var_3.costumes)) {
          vl_avatar_costume(var_3, var_3.costumes[var_3._id_08D2], 1);
        }
      }

      continue;
    }

    if(var_1 == "lootscreen_gear_highlighted") {
      self.cac = undefined;
      monitor_cao_set_cao_focus(var_2, var_0);

      if(isDefined(self.vl_cao_focus)) {
        self.caoavatarposoffset = (56, 0, 5);
      } else {
        self.caoavatarposoffset = undefined;
      }

      self.camparams.pushmode = "prelobby_loot";
      continue;
    }

    if(var_1 == "costumes") {
      cao_set_costumes_from_lua(var_2, var_0);
      continue;
    }

    if(var_1 == "costume_preview") {
      monitor_cao_set_costume_preview(var_2, var_0);
      continue;
    }

    if(var_1 == "costume_apply") {
      var_3 = monitor_cao_set_costume_preview(var_2, var_0);

      if(isDefined(var_3)) {
        var_4 = level.costumecat2idx[var_3.previewgearcategory];

        if(isDefined(var_3.costumes) && isDefined(var_3.costumes[var_3.previewcostume])) {
          var_3.costumes[var_3.previewcostume][var_4] = var_3.previewgearid;

          if(var_3.previewcostume == var_3._id_08D2) {
            if(level._id_A1FE) {
              _id_05E0(var_3.player getentitynumber(), var_3._id_20F1, "costume", var_3.costumes[var_3.previewcostume][0], var_3.costumes[var_3.previewcostume][1], var_3.costumes[var_3.previewcostume][2], var_3.costumes[var_3.previewcostume][3], var_3.costumes[var_3.previewcostume][4], var_3.costumes[var_3.previewcostume][5]);
            } else {
              var_3 set_grenadeammo(var_3.costumes[var_3.previewcostume]);
            }
          }
        }
      }

      continue;
    }

    if(var_1 == "hub_findgame") {
      var_3 = level.vlavatars[var_0];

      if(isDefined(var_3)) {
        if(var_2 == 1) {
          hide_avatar(var_3);
        } else {
          show_avatar(var_3);
        }
      }
    }
  }
}

clans_set_highlight_gear_from_lua(var_0) {
  setDvar("3784", 0);

  if(isDefined(level._id_A1DB)) {
    var_1 = strtok(var_0, "#");

    foreach(var_3 in var_1) {
      var_4 = strtok(var_3, "|");

      if(var_4.size > 0) {
        var_5 = int(var_4[0]);
        var_6 = level.players[0].clan_agents[var_5];

        if(isDefined(var_6)) {
          var_6._id_08D2 = 0;
          var_6.isvalidhighlight = int(var_4[1]) > 0;

          for(var_7 = 2; var_7 < var_4.size; var_7++) {
            var_8 = strtok(var_4[var_7], ",");
            var_9 = [];

            for(var_10 = 1; var_10 < var_8.size; var_10++) {
              var_9[var_9.size] = int(var_8[var_10]);
            }

            if(!isDefined(var_6.costumes)) {
              var_6.costumes = [];
            }

            var_6.costumes[int(var_8[0])] = var_9;
            vl_avatar_costume(var_6, var_9, 1);

            if(var_6.isvalidhighlight) {
              wait_load_costume(var_6);
              continue;
            }

            hide_avatar(var_6);
          }
        }
      }
    }
  }

  setDvar("3784", 1);
}

monitor_clans() {
  self endon("disconnect");

  for(;;) {
    self waittill("luinotifyserver", var_0, var_1);

    if(var_0 == "clanprofile") {
      maps\mp\hub_vl_base::vlprint("Using clan profile VL settings\n");

      if(var_1 < 0) {
        self.vl_clanprofile_focus = undefined;
      } else {
        self.vl_clanprofile_focus = var_1;
      }

      continue;
    }

    if(var_0 == "clan_highlight_data") {
      maps\mp\hub_vl_base::vlprint("Handling clan highlight information\n");
      clans_set_highlight_gear_from_lua(var_1);
    }
  }
}

hide_avatar(var_0) {
  for(var_1 = 0; var_1 < 48; var_1++) {
    var_2 = level.players[var_1];

    if(!isDefined(var_2)) {
      continue;
    }
    _id_05E0(var_2 getentitynumber(), var_0._id_20F1, "show", 0);
  }

  if(!level._id_A1FE) {
    var_0 hide();
  }

  hide_avatar_weapons(var_0);
}

show_avatar(var_0) {
  for(var_1 = 0; var_1 < 48; var_1++) {
    if(var_0._id_A561[var_1]) {
      var_2 = level.players[var_1];

      if(!isDefined(var_2)) {
        var_0._id_A561[var_1] = 0;
        continue;
      }

      if(level._id_A1FE) {
        _id_05E0(var_2 getentitynumber(), var_0._id_20F1, "show", 1);
      } else {
        var_0 showtoplayer(var_2);

        if(isDefined(var_0.primaryweaponent)) {
          var_0.primaryweaponent showtoplayer(var_2);
        }

        if(isDefined(var_0.botsetattacker)) {
          var_0.botsetattacker showtoplayer(var_2);
        }
      }

      if(isDefined(var_0.primaryweapon) && issubstr(var_0.primaryweapon, "akimbo")) {
        _id_A58A(var_2, var_0);
      }
    }
  }
}

hide_avatar_primary_weapon(var_0) {
  if(isDefined(var_0.primaryweaponent)) {
    var_0 notify("hide_primary_weapon");

    if(!level._id_A1FE) {
      var_0.primaryweaponent hide();
      var_0.primaryweaponent hideallparts();
    }
  }
}

hide_avatar_secondary_weapon(var_0) {
  if(isDefined(var_0.botsetattacker)) {
    var_0 notify("hide_secondary_weapon");

    if(!level._id_A1FE) {
      var_0.botsetattacker hide();
      var_0.botsetattacker hideallparts();
    }
  }
}

hide_avatar_akimbo_weapon(var_0) {
  if(isDefined(var_0._id_0BA9)) {
    var_0 notify("hide_akimbo_weapon");

    if(!level._id_A1FE) {
      var_0._id_0BA9 hide();
      var_0._id_0BA9 hideallparts();
    }
  }
}

hide_avatar_weapons(var_0) {
  hide_avatar_primary_weapon(var_0);
  hide_avatar_secondary_weapon(var_0);
  hide_avatar_akimbo_weapon(var_0);
}

hide_avatars() {
  foreach(var_1 in level.vlavatars) {
    hide_avatar(var_1);
  }
}

show_avatars() {
  foreach(var_1 in level.vlavatars) {
    show_avatar(var_1);
  }
}

get_xuid_for_avatar(var_0) {
  foreach(var_3, var_2 in level.xuid2ownerid) {
    if(isDefined(level.vlavatars[var_2]) && level.vlavatars[var_2] == var_0) {
      return var_3;
    }
  }

  return "";
}

remove_avatar(var_0) {
  var_1 = -1;

  foreach(var_3, var_1 in level.xuid2ownerid) {
    if(var_1 == var_0) {
      break;
    }
  }

  maps\mp\hub_vl_base::vlprint("Removing xuid " + var_3 + " for ownerId " + var_0 + "\n");
  _setentplayerxuidforemblem(level.vlavatars[var_0], var_3, 1);
  level.xuid2ownerid[var_3] = undefined;
  level.avatarinfo[var_0].timetodelete = 0;
  level.avatarinfo[var_0].avatar = undefined;
  setDvar("1999", level.xuid2ownerid.size);
  var_4 = level.vlavatars[var_0];
  level.vlavatars[var_0] = undefined;
  hide_avatar(var_4);
  var_4 hideallparts();

  if(isDefined(var_4.avatar_spawnpoint.spawned_avatar)) {
    var_4.avatar_spawnpoint.spawned_avatar = undefined;
  }

  if(isDefined(var_4.primaryweaponent)) {
    if(!level._id_A1FE) {
      _setentplayerxuidforemblem(var_4.primaryweaponent, var_3, 1);
      var_4.primaryweaponent delete();
    }

    var_4.primaryweaponent = undefined;
  }

  if(isDefined(var_4.botsetattacker)) {
    if(!level._id_A1FE) {
      _setentplayerxuidforemblem(var_4.botsetattacker, var_3, 1);
      var_4.botsetattacker delete();
    }

    var_4.botsetattacker = undefined;
  }

  if(isDefined(var_4._id_0BA9)) {
    _id_A593(var_3, var_4);
  }

  var_4.primaryweapon = undefined;
  var_4._id_9428 = undefined;
  maps\mp\hub_vl_base::_id_3E76(var_4);

  foreach(var_6 in level.players) {
    if(var_6.vl_focus == var_0) {
      var_6.vl_focus = 0;
    }
  }
}

_id_8774() {
  level._id_0EE9 = [];
  var_0 = [];
  var_0["cao_01"] = "pb_cao_pose_01";
  var_0[0] = var_0["cao_01"];
  var_0["selfie_01"] = "pb_selfie_pose_01";
  var_0[1] = var_0["selfie_01"];
  var_0["operator_a"] = "pb_lobby_operator_pose_a";
  var_0[7] = var_0["operator_a"];
  var_0["operator_b"] = "pb_lobby_operator_pose_b";
  var_0[8] = var_0["operator_b"];
  var_0["operator_c"] = "pb_lobby_operator_pose_c";
  var_0[9] = var_0["operator_c"];
  var_0["operator_d"] = "pb_lobby_operator_pose_d";
  var_0[10] = var_0["operator_d"];
  var_0["operator_e"] = "pb_lobby_operator_pose_e";
  var_0[11] = var_0["operator_e"];
  var_0["assault_checkgun"] = "pb_lobby_assault_checkgun";
  var_0[12] = var_0["assault_checkgun"];
  var_0["assault_face"] = "pb_lobby_assault_face";
  var_0[13] = var_0["assault_face"];
  var_0["assault_gear"] = "pb_lobby_assault_gear";
  var_0[14] = var_0["assault_gear"];
  var_0["assault_gloves"] = "pb_lobby_assault_gloves";
  var_0[15] = var_0["assault_gloves"];
  var_0["assault_idle"] = "pb_lobby_assault_idle";
  var_0[16] = var_0["assault_idle"];
  var_0["assault_shoes"] = "pb_lobby_assault_shoes";
  var_0[17] = var_0["assault_shoes"];
  level._id_0EE9["lobby_idle"] = var_0;

  for(var_1 = 0; var_1 < 18; var_1++) {
    _precachempanim(var_0[var_1]);
  }
}

use_animstate(var_0, var_1, var_2) {
  var_3 = _randomfloatrange(0.85, 1.15);
  var_4 = 0;

  if(!isDefined(self._id_0E93)) {
    var_4 = 1;
    self.angles = self.spawn_angles;
  }

  if(!isDefined(var_2)) {
    var_2 = "lobby_idle";
    var_0 = "assault_pose_06";
  }

  self._id_0E93 = var_0;
  self._id_0EE8 = var_2;
  var_5 = level._id_0EE9[var_2][var_0];
  self._id_0EEC = var_5;

  if(isDefined(self.player)) {
    _id_05E0(self.player getentitynumber(), self._id_20F1, "anim", var_5);
  }

  if(!level._id_A1FE) {
    self scriptmodelplayanim(var_5);
  }

  if(!isDefined(var_1) || !var_1) {
    self._id_0E93 = var_0;

    if(var_4) {
      vl_give_weapons(self);
    }
  }
}

start_anim(var_0) {
  if(isDefined(var_0.camparams) && isDefined(var_0.camparams.mode)) {
    switch (var_0.camparams.mode) {
      case "prelobby_loot":
      case "prelobby":
        var_1 = 0;

        if(isDefined(level.vlavatars)) {
          foreach(var_3 in level.vlavatars) {
            if(!isDefined(var_3._id_0E93)) {
              var_4 = var_3.avatar_spawnpoint findpositionnum();

              if(isDefined(self.ownerid) && self.ownerid == 0) {
                var_1 = 8;
              } else if(var_4 < level.num_lobby_idles) {
                var_1 = var_4;
              } else {
                var_1++;

                if(var_1 >= level.num_lobby_idles) {
                  var_1 = 0;
                }
              }

              var_5 = "lobby_idle";
              use_animstate(var_1, undefined, var_5);
            }
          }
        }

        break;
      case "transition":
      case "game_lobby":
      case "cac":
        var_1 = 0;

        if(isDefined(level.vlavatars)) {
          foreach(var_3 in level.vlavatars) {
            if(!isDefined(var_3._id_0E93)) {
              var_4 = var_3.avatar_spawnpoint findpositionnum();

              if(isDefined(self.ownerid) && self.ownerid == 0) {
                var_1 = 8;
              } else if(var_4 < level.num_lobby_idles) {
                var_1 = var_4;
              } else {
                var_1++;

                if(var_1 >= level.num_lobby_idles) {
                  var_1 = 0;
                }
              }

              var_5 = "lobby_idle";
              use_animstate(var_1, undefined, var_5);
            }
          }
        }

        break;
      case "clanprofile":
      case "cao":
        if(!isDefined(self._id_0E93)) {
          if(isDefined(self.ownerid) && self.ownerid == 0) {
            var_1 = 8;
          } else {
            var_1 = _randomintrange(0, level.num_lobby_idles - 1);
          }

          var_5 = "lobby_idle";
          use_animstate(var_1, undefined, var_5);
        }

        break;
      default:
        if(!isDefined(self._id_0E93)) {
          if(isDefined(self.ownerid) && self.ownerid == 0) {
            var_1 = 8;
          } else {
            var_1 = _randomintrange(0, level.num_lobby_idles - 1);
          }

          var_5 = "lobby_idle";
          use_animstate(var_1, undefined, var_5);
        }

        break;
    }
  }
}

start_prelobby_anims() {
  if(!isDefined(level.vlavatars)) {
    return;
  }
  foreach(var_1 in level.vlavatars) {
    if(!isDefined(var_1._id_0E93) || !isDefined(var_1._id_0EE8)) {
      var_2 = var_1 getanimdata(var_1.primaryweapon);
      var_1 use_animstate(var_2._id_0BB4, undefined, var_2._id_0EE8);
    }
  }
}

start_lobby_anims() {
  if(!isDefined(level.vlavatars)) {
    return;
  }
  foreach(var_1 in level.vlavatars) {
    if(!isDefined(var_1._id_0E93) || !isDefined(var_1._id_0EE8)) {
      var_2 = var_1 getanimdata(var_1.primaryweapon);
      var_1 use_animstate(var_2._id_0BB4, undefined, var_2._id_0EE8);
    }
  }
}

start_cao_anims() {
  if(!isDefined(level.vlavatars)) {
    return;
  }
  foreach(var_1 in level.vlavatars) {
    if(!isDefined(var_1._id_0E93) || !isDefined(var_1._id_0EE8)) {
      var_2 = var_1 getanimdata(var_1.primaryweapon);
      var_1 use_animstate(var_2._id_0BB4, undefined, var_2._id_0EE8);
    }
  }
}

find_best_cam_path(var_0, var_1, var_2) {
  var_3 = [];
  var_3[0] = var_0;
  var_3[1] = var_1;
  var_4 = 20;

  for(var_5 = 1; var_5 && var_4 > 0; var_3 = var_6) {
    var_4--;
    var_5 = 0;
    var_6 = [];
    var_6[var_6.size] = var_3[0];
    var_7 = 0;
    var_8 = 0;

    for(var_9 = 0; var_9 < var_3.size - 1 && !var_7; var_9++) {
      var_10 = 1;
      var_11 = var_3[var_9];
      var_12 = var_3[var_9 + 1];

      while(var_10) {
        var_10 = 0;
        var_13 = undefined;
        var_14 = undefined;

        foreach(var_16 in var_2) {
          var_17 = trace2d(var_11, var_12, var_16);

          if(var_17["intersect"]) {
            if(_distance2d(var_6[var_6.size - 1], var_17["closestpoint"]) > 0.1 && _distance2d(var_12, var_17["closestpoint"]) > 0.1) {
              var_10 = 1;

              if(!isDefined(var_14) || var_14["radratio"] > var_17["radratio"]) {
                var_13 = var_16;
                var_14 = var_17;
              }
            }
          }
        }

        if(var_10) {
          var_5 = 1;

          if(_length2d(var_11, var_13["center"]) < var_13["radius"]) {
            var_11 = move_outside_circle(var_11, var_13);
            var_6[var_6.size - 1] = var_11;
            var_10 = 0;
            var_7 = 1;
            var_8 = var_9 + 1;
          } else if(_length2d(var_12, var_13["center"]) < var_13["radius"]) {
            var_12 = move_outside_circle(var_12, var_13);
            var_6[var_6.size] = var_12;
            var_10 = 0;
            var_7 = 1;
            var_8 = var_9 + 2;
          } else {
            var_6[var_6.size] = var_14["closestpoint"];
            var_6[var_6.size] = var_12;
            var_10 = 0;
          }

          continue;
        }

        var_6[var_6.size] = var_12;
      }
    }

    if(var_7) {
      for(var_9 = var_8; var_9 < var_3.size; var_9++) {
        var_6[var_6.size] = var_3[var_9];
      }
    }
  }

  return var_3;
}

move_outside_circle(var_0, var_1) {
  var_2 = var_1["center"];
  var_3 = var_1["radius"];
  var_4 = vectorNormalize((var_0[0] - var_2[0], var_0[1] - var_2[1], 0));
  var_0 = (var_2[0] + var_3 * var_4[0], var_2[1] + var_3 * var_4[1], var_0[2]);
  return var_0;
}

trace2d(var_0, var_1, var_2) {
  var_3 = 5;
  var_4 = var_2["center"];
  var_5 = var_2["radius"];
  var_6 = var_5 + var_3;
  var_7 = (var_1[0] - var_0[0], var_1[1] - var_0[1], 0);
  var_8 = vectorNormalize(var_7);
  var_9 = _length2d(var_7);
  var_10 = (var_4[0] - var_0[0], var_4[1] - var_0[1], 0);
  var_11 = vectordot(var_8, var_10);

  if(var_11 < 0) {
    var_11 = 0.0;
  } else if(var_11 > var_9) {
    var_11 = var_9;
  }

  var_12 = (var_0[0] + var_11 * var_8[0], var_0[1] + var_11 * var_8[1], 0);
  var_13 = var_11 / var_9;
  var_14 = (var_12[0] - var_4[0], var_12[1] - var_4[1], 0);
  var_9 = _length2d(var_14);
  var_15 = 0;
  var_16 = 1.0;

  if(var_9 < var_5) {
    var_15 = 1;
    var_14 = vectorNormalize(var_14);
    var_12 = (var_4[0] + var_6 * var_14[0], var_4[1] + var_6 * var_14[1], var_0[2] + var_13 * (var_1[2] - var_0[2]));
    var_16 = var_9 / var_5;
  }

  var_17 = [];
  var_17["intersect"] = var_15;
  var_17["fraction"] = var_13;
  var_17["closestpoint"] = var_12;
  var_17["radratio"] = var_16;
  return var_17;
}

calc_new_pos(var_0, var_1, var_2) {
  var_3 = distance(var_0, var_2);

  if(var_3 > var_1) {
    var_4 = vectorNormalize(var_2 - var_0);
    var_2 = var_0 + var_1 * var_4;
  }

  return var_2;
}

lookahead_path(var_0, var_1, var_2, var_3, var_4) {
  var_5 = var_4[var_0];

  if(var_0 + 1 >= var_4.size) {
    return [var_0, calc_new_pos(var_1, var_2, var_4[var_0])];
  }

  var_6 = var_4[var_0 + 1];
  var_7 = distance(var_5, var_6);
  var_8 = vectorNormalize(var_6 - var_5);
  var_9 = vectordot(var_8, var_1 - var_5);

  if(var_9 < 0) {
    var_9 = 0;
  }

  if(var_9 > var_7) {
    var_9 = var_7;
  }

  var_10 = var_5 + var_9 * var_8;
  var_11 = var_3;
  var_12 = var_7 - var_9;
  var_13 = var_4[var_4.size - 1];

  while(var_11 > 0) {
    if(var_12 > var_11) {
      var_13 = var_10 + var_11 * var_8;
      var_11 = 0;
      continue;
    }

    if(var_0 + 1 >= var_4.size) {
      var_13 = var_4[var_0];
      var_11 = 0;
    }

    var_11 = var_11 - var_12;
    var_0++;
    var_10 = var_4[var_0];
  }

  return [var_0, calc_new_pos(var_1, var_2, var_13)];
}

init_path_traversal(var_0) {
  var_0.distanceonpath = 0;
  var_0.pathidx = 0;
  var_0.distonpathsegment = 0;
  var_0.pathspeed = 0;
  var_1 = var_0.pathinfo_len / var_0.path_idealtime;

  if(var_1 < var_0.path_minspeed) {
    var_1 = var_0.path_minspeed;
  }

  if(var_1 > var_0.path_maxspeed) {
    var_1 = var_0.path_maxspeed;
  }

  var_0.pathaccel = 0.05 * var_1 / var_0.path_accel_time;
  var_0.pathdeccel = 0.05 * var_1 / var_0.path_deccel_time;
  var_0.pathtgtspeed = var_1;
  var_0.pathaccelmode = 1;
  var_0.pathinfo_t = 0;
  var_0.pathinfo_totalt = var_0.path_idealtime;
  var_2 = var_0.path_deccel_time / 0.05;
  var_3 = 0;
  var_4 = var_1;

  for(var_5 = 0; var_5 < var_2; var_5++) {
    var_4 = var_4 - var_0.pathdeccel;

    if(var_4 < var_0.path_mindeccelspeed) {
      var_4 = var_0.path_mindeccelspeed;
    }

    var_3 = var_3 + var_4;
  }

  var_0.pathstartdecceldist = var_0.pathinfo_len - var_3;
  var_0.pitch = var_0.pathinfo_startpitch;
}

update_path_speed(var_0) {
  if(var_0.distanceonpath < var_0.pathstartdecceldist) {
    var_0.pathspeed = var_0.pathspeed + var_0.pathaccel;

    if(var_0.pathspeed > var_0.pathtgtspeed) {
      var_0.pathspeed = var_0.pathtgtspeed;
    }
  } else {
    var_0.pathspeed = var_0.pathspeed - var_0.pathdeccel;

    if(var_0.pathspeed < var_0.path_mindeccelspeed) {
      var_0.pathspeed = var_0.path_mindeccelspeed;
    }
  }
}

init_path_constants(var_0) {
  var_0.path_maxspeed = 15.0;
  var_0.path_minspeed = 1.8;
  var_0.path_mindeccelspeed = 0.3;
  var_0.path_idealtime = 0.5;
  var_0.path_accel_time = 0.15 * var_0.path_idealtime;
  var_0.path_deccel_time = 0.15 * var_0.path_idealtime;
  var_0.pathmaxrotz = 4.5;
  var_0.pathmaxrotx = 4.5;
}

build_path_info(var_0, var_1, var_2, var_3, var_4) {
  var_5 = find_best_cam_path(var_0.origin, var_3, var_0.obstacles);
  var_0.path = var_5;
  var_6 = 0;

  foreach(var_9, var_8 in var_0.path) {
    if(var_9 > 0) {
      var_6 = var_6 + distance(var_0.path[var_9], var_0.path[var_9 - 1]);
    }
  }

  var_0.pathinfo_t = 0;
  var_0.pathinfo_totalt = var_0.path_idealtime;
  var_0.pathinfo_len = var_6;
  var_0.pathinfo_startaim = anglesToForward(var_0.angles);
  var_0.pathinfo_endaim = anglesToForward(var_4);
  var_0.pathinfo_startpitch = _angleclamp180(var_0.angles[0]);
  var_0.pathinfo_curstartpitch = var_0.pathinfo_startpitch;
  var_0.pathinfo_endpitch = _angleclamp180(var_4[0]);
  var_0.pathinfo_startyaw = _angleclamp180(var_0.angles[1]);
  var_0.pathinfo_endyaw = _angleclamp180(var_4[1]);
  var_0.pathinfo_start_loc = var_2;
  var_0.pathinfo_end_loc = var_3;
  var_0.pathinfo_velocity = (0, 0, 0);
  var_10 = vectorNormalize(var_0.pathinfo_end_loc - var_0.pathinfo_start_loc);
  var_11 = vectordot(var_10, var_0.pathinfo_startaim);
  var_12 = vectordot(var_10, var_0.pathinfo_endaim);
  var_13 = 0;

  if(var_12 < -0.707 && var_11 < -0.707) {
    var_13 = 1;
  }

  var_0.pathinfo_mode = var_13;
  init_path_traversal(var_0);
}

findnewtargetpos(var_0, var_1, var_2) {
  var_3 = anglesToForward(var_0);
  var_4 = var_2 - var_1;
  var_5 = vectordot(var_4, var_3);
  var_6 = var_1 + var_3 * var_5;
  return var_6;
}

sigmoid(var_0, var_1) {
  var_2 = -0.5;
  var_0 = var_0 + var_2;
  var_0 = var_0 * (2 * var_1);
  var_3 = _sqrt(1 + var_1 * var_1) / (2 * var_1);
  var_4 = 0.5;
  var_5 = var_3 * (var_0 / _sqrt(1 + var_0 * var_0)) + var_4;
  return var_5;
}

lerp_towards_desiredangle(var_0, var_1) {
  var_2 = _angleclamp180(var_1[0]);
  var_3 = _angleclamp180(var_0.angles[0]);
  var_4 = _angleclamp180(var_1[1] - var_0.angles[1]);
  var_5 = _angleclamp180(var_2 - var_3);

  if(var_4 < -1 * var_0.pathmaxrotz) {
    var_4 = -1 * var_0.pathmaxrotz;
  }

  if(var_4 > var_0.pathmaxrotz) {
    var_4 = var_0.pathmaxrotz;
  }

  if(var_5 < -1 * var_0.pathmaxrotx) {
    var_5 = -1 * var_0.pathmaxrotx;
  }

  if(var_5 > var_0.pathmaxrotx) {
    var_5 = var_0.pathmaxrotx;
  }

  var_6 = (var_5, var_4, 0);
  var_0.angles = var_0.angles + var_6;

  if(_abs(var_5) < 0.1 && _abs(var_4) < 0.1) {
    return 1;
  } else {
    return 0;
  }
}

update_camera_angles_on_path(var_0, var_1) {
  var_2 = var_0.pathinfo_t / var_0.pathinfo_totalt;
  var_2 = sigmoid(var_2, 2);
  var_3 = var_0.angles;
  var_4 = var_2 * (var_0.pathinfo_endpitch - var_0.pathinfo_startpitch) + var_0.pathinfo_startpitch;
  var_5 = var_0.pathinfo_startyaw + var_2 * (var_0.pathinfo_endyaw - var_0.pathinfo_startyaw);
  var_6 = var_0.angles[1] + _angleclamp180(var_5 - var_0.angles[1]);
  var_3 = (var_4, var_6, var_3[2]);
  return lerp_towards_desiredangle(var_0, var_3);
}

update_camera_position_on_path(var_0) {
  var_1 = var_0.pathinfo_t / var_0.pathinfo_totalt;
  var_1 = sigmoid(var_1, 2);
  var_2 = var_1 * var_0.pathinfo_len;
  var_0.pathidx = 0;
  var_0.distonpathsegment = 0;
  var_0.distanceonpath = 0;

  while(var_2 > 0) {
    var_3 = distance(var_0.path[var_0.pathidx], var_0.path[var_0.pathidx + 1]);
    var_4 = var_3 - var_0.distonpathsegment;

    if(var_4 > var_2) {
      var_0.distonpathsegment = var_0.distonpathsegment + var_2;
      var_5 = var_0.path[var_0.pathidx] + var_0.distonpathsegment * vectorNormalize(var_0.path[var_0.pathidx + 1] - var_0.path[var_0.pathidx]);
      var_0.pathinfo_velocity = var_5 - var_0.origin;
      var_0.origin = var_5;
      var_0.distanceonpath = var_0.distanceonpath + var_2;
      var_2 = 0;
      continue;
    }

    var_2 = var_2 - var_4;
    var_0.pathidx++;

    if(var_0.pathidx >= var_0.path.size - 1) {
      if(var_0.pathidx < var_0.path.size) {
        var_5 = var_0.path[var_0.pathidx];
      } else {
        var_5 = var_0.path[var_0.path.size - 1];
      }

      var_0.pathinfo_velocity = var_5 - var_0.origin;
      var_0.origin = var_5;
      var_0.distanceonpath = var_0.pathinfo_len;
      var_2 = 0;
      continue;
    }

    var_0.distanceonpath = var_0.distanceonpath + var_4;
    var_0.distonpathsegment = 0;
  }
}

update_camera_on_path(var_0, var_1) {
  var_2 = 0;
  var_0.pathinfo_t = var_0.pathinfo_t + 0.05;

  if(var_0.pathinfo_t >= var_0.pathinfo_totalt) {
    var_0.pathinfo_t = var_0.pathinfo_totalt;
    var_2 = 1;
    var_0.pathinfo_velocity = (0, 0, 0);
  }

  update_camera_position_on_path(var_0);
  update_camera_angles_on_path(var_0, var_1);
  return var_2;
}

get_target_from_avatar(var_0) {
  var_1 = "j_neck";
  var_2 = var_0 gettagorigin(var_1);
  return var_2;
}

calc_f_from_avatar(var_0) {
  var_1 = rotateavatartagcamera(var_0);
  var_2 = var_1.camera_tag_origin;
  var_3 = var_1.camera_tag_angles;
  var_4 = get_target_from_avatar(var_0);
  var_5 = var_2;
  var_6 = var_2 + anglesToForward(var_3) * 64;
  return calc_f(var_5, var_6, var_4);
}

calc_f_from_avatar_spawnpoint(var_0) {
  var_1 = var_0.origin;
  var_2 = var_0.camera_helper.origin;
  var_3 = var_0.camera_lookat.origin;
  return calc_f(var_2, var_3, var_1);
}

calc_f(var_0, var_1, var_2) {
  var_3 = var_1;
  var_4 = var_0;
  var_5 = var_2;
  var_6 = [];
  var_7 = vectorNormalize(_vectorcross(var_3 - var_4, (0, 0, 1)));
  var_8 = vectorNormalize(_vectorcross(var_7, var_3 - var_4));
  var_9 = var_5 - var_4;
  var_10 = var_5 - vectordot(var_8, var_9) * var_8;
  var_11 = var_5 - vectordot(var_7, var_9) * var_7;
  var_12 = distance(var_10, var_3);
  var_13 = distance(var_10, var_4);
  var_14 = var_12 / var_13;
  var_15 = 1;

  if(vectordot(var_9, var_7) < 0) {
    var_15 = -1;
  }

  var_6["fx"] = var_14;
  var_6["sx"] = var_15;
  var_16 = distance(var_11, var_3);
  var_17 = distance(var_11, var_4);
  var_18 = var_16 / var_17;
  var_19 = 1;

  if(vectordot(var_9, var_8) < 0) {
    var_19 = -1;
  }

  var_6["fz"] = var_18;
  var_6["sz"] = var_19;
  return var_6;
}

calc_f_fromscreen(var_0, var_1) {
  var_2 = getdvarfloat("cg_fov", 45) * getdvarfloat("3078", 1.0);
  var_3 = 1.0;
  var_4 = _tan(var_2);
  var_5 = [];
  var_6 = var_4 * _abs(var_0);
  var_7 = 1;

  if(var_0 < 0) {
    var_7 = -1;
  }

  var_8 = var_6 / _sqrt(1 - var_6 * var_6);
  var_5["sx"] = var_7;
  var_5["fx"] = var_8;
  var_9 = var_3 * var_4 * _abs(var_1);
  var_10 = 1;

  if(var_1 < 0) {
    var_10 = -1;
  }

  var_11 = var_9 / _sqrt(1 - var_9 * var_9);
  var_5["sz"] = var_10;
  var_5["fz"] = var_11;
  return var_5;
}

calc_cam_lookat(var_0, var_1, var_2) {
  var_3 = var_1;
  var_4 = var_2;
  var_5 = var_4 - var_3;
  var_6 = vectorNormalize(_vectorcross(var_5, (0, 0, 1)));
  var_7 = vectorNormalize(_vectorcross(var_6, var_5));
  var_8 = var_5 - vectordot(var_5, var_7) * var_7;
  var_9 = length(var_8);
  var_10 = var_0["fx"];
  var_11 = var_0["sx"];
  var_12 = var_9 * var_10;
  var_9 = var_9 * var_10 * var_10;
  var_13 = var_9 * var_10 * _sqrt(1 - var_10 * var_10);
  var_14 = var_9 * var_8 + var_13 * var_6;
  var_15 = var_5 - vectordot(var_5, var_6) * var_6;
  var_16 = length(var_15);
  var_17 = var_0["fz"];
  var_18 = var_0["sz"];
  var_19 = var_16 * var_17;
  var_16 = var_16 * var_17 * var_17;
  var_20 = var_16 * var_17 * _sqrt(1 - var_17 * var_17);
  var_21 = var_16 * var_15 + var_20 * var_7;
  var_22 = var_4 + var_11 * var_14 + var_18 * var_21;
  return var_22;
}

debug_draw_path(var_0) {
  var_1 = (1, 1, 1);
  var_2 = var_0[0];
  var_3 = var_2;
  var_4 = 0;
  var_5 = 10;
  var_6 = 30;

  if(level.use_lookahead) {
    for(;;) {
      var_7 = lookahead_path(var_4, var_2, var_5, var_6, var_0);
      var_4 = var_7[0];
      var_3 = var_7[1];

      if(distance(var_2, var_3) < 0.1) {
        break;
      }

      var_2 = var_3;

      if(var_4 >= var_0.size) {
        break;
      }
    }
  } else {
    for(var_8 = 0; var_8 < var_0.size - 1; var_8++) {}
  }
}

debug_draw_obstacles(var_0) {
  var_1 = (1, 0.5, 0);

  foreach(var_3 in var_0) {
    var_4 = var_3["center"];
    var_5 = var_3["radius"];
  }
}

debug_draw_aim(var_0) {
  var_1 = 1;
  var_2 = var_1;
  var_3 = 36;
  init_path_traversal(var_0);
  var_0.target_from_avatar = get_target_from_avatar(var_0.targetavatar);

  while(!update_camera_on_path(var_0)) {
    var_4 = var_0.target_from_avatar;
    var_5 = calc_cam_lookat(var_0.fparams, var_0.origin, var_4);
    var_2--;

    if(var_2 <= 0) {
      var_2 = var_1;
    }
  }

  var_0.angles = (_angleclamp180(var_0.angles[0]), _angleclamp180(var_0.angles[1]), _angleclamp180(var_0.angles[2]));
  var_0 dontinterpolate();
}

test_pathing(var_0, var_1, var_2, var_3) {
  level notify("stop_test_pathing");
  level endon("stop_test_pathing");
  var_4 = common_scripts\utility::getstructarray("player_pos", "targetname");
  var_5 = var_2.spawned_avatar;
  var_6 = rotateavatartagcamera(var_5);
  var_7 = var_6.camera_tag_origin;
  var_8 = var_6.camera_tag_angles;
  var_9 = var_7;
  var_10 = var_8;
  var_11 = var_0.origin;
  var_12 = var_11 + anglesToForward(var_0.angles) * 64;
  var_13 = var_9 + anglesToForward(var_10) * 64;
  var_0.origin = var_11;
  var_0.angles = var_10;
  var_0.obstacles = var_3;
  init_path_constants(var_0);
  build_path_info(var_0, undefined, var_0.origin, var_9, var_10);
  var_0.fparams = calc_f_from_avatar(var_5);
  var_0.targetavatar = var_5;

  for(;;) {
    var_0.origin = var_11;
    var_0.angles = var_10;
    debug_draw_path(var_0.path);
    debug_draw_obstacles(var_0.obstacles);
    debug_draw_aim(var_0);
    waitframe();
  }
}

debug_pathing() {
  var_0 = 0;
  var_1 = common_scripts\utility::getstructarray("player_pos", "targetname");

  foreach(var_3 in var_1) {
    var_4 = common_scripts\utility::getstruct(var_3.target, "targetname");

    if(var_4._id_0165 == "camera_target") {
      var_3.camera_lookat = var_4;
    }

    var_5 = common_scripts\utility::getstruct(var_4.target, "targetname");

    if(var_5._id_0165 == "camera") {
      var_3.camera_helper = var_5;
      var_5.camera_goal = var_3;
      var_5.camera_lookat = var_3.camera_lookat;
    }
  }

  var_7 = spawn("script_model", (0, 0, 0));
  var_7 setModel("tag_player");
  var_7.targetname = "fakecamera";
  level.use_lookahead = 0;
  var_8 = 0;
  var_9 = 1;
  var_10 = "111111111111111111";
  var_11 = 16;

  for(;;) {
    if(self fragButtonPressed()) {
      while(self fragButtonPressed()) {
        waitframe();
      }

      var_9++;

      if(var_9 >= 48) {
        var_9 = 0;
      }

      if(var_9 == var_8) {
        var_9++;

        if(var_9 >= 48) {
          var_9 = 0;
        }
      }

      var_0 = 1;
    }

    if(self secondaryoffhandbuttonPressed()) {
      while(self secondaryoffhandbuttonPressed()) {
        waitframe();
      }

      var_8++;

      if(var_8 >= 48) {
        var_8 = 0;
      }

      if(var_9 == var_8) {
        var_8++;

        if(var_8 >= 48) {
          var_8 = 0;
        }
      }

      var_0 = 1;
    }

    if(var_0) {
      var_0 = 0;
      var_12 = [];
      var_13 = undefined;
      var_14 = undefined;

      foreach(var_18, var_16 in var_1) {
        if(getsubstr(var_10, var_18, var_18 + 1) == "0") {
          continue;
        }
        var_17 = [];
        var_17["center"] = var_16.origin;
        var_17["radius"] = var_11;
        var_12[var_12.size] = var_17;

        if(var_16._id_0165 == "" + var_8) {
          var_13 = var_16;
        }

        if(var_16._id_0165 == "" + var_9) {
          var_14 = var_16;
        }
      }

      thread test_pathing(var_7, var_13, var_14, var_12);
    }

    wait 0.2;
  }
}

debug_fly(var_0) {
  level.debug_fly = 1;
  var_1 = 30;
  var_2 = 10;
  var_3 = 10;
  var_4 = self getunnormalizedcameramovement();
  var_5 = self getnormalizedmovement();
  var_6 = anglesToForward(var_4);
  var_7 = anglestoup(var_4);
  var_8 = anglestoright(var_4);
  var_9 = 0;

  if(self adsButtonPressed()) {
    var_9 = -1;
  } else if(self attackButtonPressed()) {
    var_9 = 1;
  }

  if(self secondaryoffhandbuttonPressed()) {
    var_1 = var_1 * 0.1;
    var_2 = var_2 * 0.1;
    var_3 = var_3 * 0.1;
  }

  var_0.angles = var_4;
  var_0.origin = var_0.origin + var_5[0] * var_1 * var_6 + var_5[1] * var_2 * var_8 + var_9 * var_3 * var_7;
}

vlobby_vegnette(var_0, var_1) {
  if(!isDefined(self._id_A4B5)) {
    self._id_A4B5 = _newclienthudelem(self);
    self._id_A4B5.x = 0;
    self._id_A4B5.y = 0;
    self._id_A4B5 setshader(var_1, 640, 480);
    self._id_A4B5.alignx = "left";
    self._id_A4B5.aligny = "top";
    self._id_A4B5._id_00C6 = "fullscreen";
    self._id_A4B5._id_01CA = "fullscreen";
    self._id_A4B5.alpha = var_0;
  }

  if(isDefined(self._id_A4B5) && self._id_A4B5.alpha > 0 && var_0 == 0) {
    self._id_A4B5 setshader(var_1, 640, 480);
    self._id_A4B5.alpha = 0;
  }

  if(isDefined(self._id_A4B5) && self._id_A4B5.alpha < 1 && var_0 == 1) {
    self._id_A4B5 setshader(var_1, 640, 480);
    self._id_A4B5.alpha = 1;
  }
}

getspawnpoint(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 0;

    for(var_1 = 0; var_1 < level.players.size; var_1++) {
      if(level.players[var_1] == self) {
        var_0 = var_1;
        break;
      }
    }
  }

  var_2 = common_scripts\utility::getstructarray("player_pos", "targetname");
  var_3 = undefined;

  foreach(var_3 in var_2) {
    if(var_3._id_0165 == "" + var_0) {
      break;
    }
  }

  if(!isDefined(var_3)) {
    var_3 = var_2[0];
  }

  self.avatar_spawnpoint = var_3;
  return var_3;
}

_id_2785() {
  var_0 = self;

  if(isDefined(var_0.cao_agent)) {
    return;
  }
  var_1 = var_0 getxuid();
  var_0.cao_agent = var_0 _id_8F7D(var_0._id_1FA3, var_0._id_0079, var_0._id_1F9D, var_0.botclearscriptenemy, "none", var_0.loadoutequipment, var_0.loadoutoffhand, var_0.perks, var_0.setnameplatematerial, var_0.name, 0, 1);

  if(!level._id_A1FE) {
    _setentplayerxuidforemblem(var_0.cao_agent, var_1);
  }

  var_0 maps\mp\hub_vl_base::prep_for_controls(var_0.cao_agent, var_0.cao_agent.spawn_angles);
}

_id_2D00() {
  var_0 = self;

  if(!isDefined(var_0.cao_agent)) {
    return;
  }
  maps\mp\hub_vl_base::_id_3E76(var_0.cao_agent);
  var_0.cao_agent = undefined;
}