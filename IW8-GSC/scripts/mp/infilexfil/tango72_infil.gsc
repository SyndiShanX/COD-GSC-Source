/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\infilexfil\tango72_infil.gsc
***************************************************/

function tango72_init(var_0) {
  initanims(var_0);
  var_1 = [];
  GscBinSkip0(0x2e, 0, [2, 3]);
}

function tango72_spawn(var_0, var_1, var_2, var_3) {
  var_4 = scripts\engine\utility::getStruct(var_1, "targetname");
  var_5 = spawn("script_origin", var_4.origin);
  var_5.angles = var_4.angles;
  var_5.scene_node = var_4;

  if(var_2 == "alpha") {
    var_5.origin += (0, 0, 10);
  }

  thread infilthink(var_5, var_0);
  return var_5;
}

function tango72_get_length(var_0) {
  var_1 = getanimlength(level.scr_anim["slot_0"]["tango72_infil_" + var_0 + "_intro"]);
  var_1 += getanimlength(level.scr_anim["slot_0"]["tango72_infil_" + var_0 + "_exit"]);
  return var_1;
}

function player_tango72_infil_think(var_0, var_1) {
  self endon("player_free_spot");
  thread ref_13a3c(var_0);
  thread player_infil_end();
  var_2 = var_0.linktoent gettagorigin("body_animate_jnt");
  var_3 = var_0.linktoent gettagangles("body_animate_jnt");
  thread scripts\mp\utility\infilexfil::infil_player_rig_updated("slot_" + var_1, var_2, var_3);
  self.player_rig linkTo(var_0.linktoent, "body_animate_jnt", (0, 0, 0), (0, 0, 0));

  if(!isai(self)) {
    if(var_1 != 5) {
      self.player_rig scripts\mp\utility\infilexfil::handleweaponstatenotetrack("drop");
    }

    self lerpviewangleclamp(1, 0.25, 0.25, 10, 20, 40, 10);
  }

  self setdemeanorviewmodel("safe", "iw8_ges_demeanor_safe_van");
  self.player_rig.weapon_state_func = &scripts\mp\utility\infilexfil::handleweaponstatenotetrack;
  thread scripts\mp\infilexfil\infilexfil::infil_scene_fade_in(0, 0.55);
  thread player_van_disconnect();
  level waittill("start_scene");

  if(isDefined(self.team) && self.team != "spectator") {
    var_4 = [];
    GscBinSkip0(0x2e, var_4.size, "mp_infil_mix_musicheavy");
  }

  if(isDefined(self.animname) && !isai(self)) {
    var_8 = "scn_infil_tango_plr_0";

    if(isDefined(var_1.subtype)) {
      if(var_1.subtype == "alpha") {
        switch (self.animname) {
          case "slot_0":
            var_8 = "scn_infil_tango_plr_0";
            break;
          case "slot_1":
            var_8 = "scn_infil_tango_plr_3";
            break;
          case "slot_2":
            var_8 = "scn_infil_tango_plr_1";
            break;
          case "slot_3":
            var_8 = "scn_infil_tango_plr_4";
            break;
          case "slot_4":
            var_8 = "scn_infil_tango_plr_2";
            break;
          case "slot_5":
            var_8 = "scn_infil_tango_plr_5";
            break;
          default:
            var_8 = "scn_infil_tango_plr_0";
            break;
        }
      } else {
        switch (self.animname) {
          case "slot_0":
            var_8 = "scn_infil_tango_plr_3";
            break;
          case "slot_1":
            var_8 = "scn_infil_tango_plr_0";
            break;
          case "slot_2":
            var_8 = "scn_infil_tango_plr_1";
            break;
          case "slot_3":
            var_8 = "scn_infil_tango_plr_4";
            break;
          case "slot_4":
            var_8 = "scn_infil_tango_plr_2";
            break;
          case "slot_5":
            var_8 = "scn_infil_tango_plr_5";
            break;
          default:
            var_8 = "scn_infil_tango_plr_0";
            break;
        }
      }
    }

    self playlocalsound(var_8);

    if(var_1.subtype == "alpha") {
      self playlocalsound("scn_infil_tango_tank_right_plr");
    } else {
      self playlocalsound("scn_infil_tango_tank_left_plr");
    }
  }

  self setcinematicmotionoverride("disabled");
  self lerpfovscalefactor(0, 0);
  var_1.linktoent scripts\mp\anim::anim_player_solo(self, self.player_rig, "tango72_infil_" + var_1.subtype + "_intro", "body_animate_jnt");

  if(isDefined(level.scr_viewmodelanim[self.animname]) && isDefined(level.scr_viewmodelanim[self.animname]["tango72_infil_" + var_1.subtype + "_intro"])) {
    setDvar("depthSortViewmodel", 0);
  }

  self lerpviewangleclamp(1, 0.25, 0.25, 0, 0, 0, 0);
  thread clear_infil_ambient_zone();
  self lerpfovscalefactor(1, 0.75);
  var_1.linktoent scripts\mp\anim::anim_player_solo(self, self.player_rig, "tango72_infil_" + var_1.subtype + "_exit", "body_animate_jnt");

  if(isDefined(self.player_rig) && self.player_rig islinked()) {
    self.player_rig unlink();
  }

  self visionsetnakedforplayer("", 0.75);
  self setdemeanorviewmodel("normal");
  self clearcinematicmotionoverride();
}

function clear_infil_ambient_zone() {
  self endon("death_or_disconnect");
  wait 3;
  self clearclienttriggeraudiozone(2);
  self clearallsoundsubmixes();
}

function player_infil_end() {
  self endon("disconnect");
  level waittill("prematch_over");
  self notify("remove_rig");
  self clearclienttriggeraudiozone(1);
  scripts\mp\utility\player::setdof_default();
  setDvar("depthSortViewmodel", 0);
}

function ref_13a3c(var_0) {
  self endon("death_or_disconnect");

  if(isPlayer(self)) {
    self setclienttriggeraudiozonepartialwithfade("tango72_infil_mix", 0.05, "mix");
    wait 0.5;
    self playlocalsound("scn_infil_tango_tank_prestart");
    level waittill("infil_started");
    wait 1;
    self stoplocalsound("scn_infil_tango_tank_prestart");
    return;
  }
}

function player_van_disconnect() {
  level endon("prematch_over");
  self waittill("death_or_disconnect");

  if(isDefined(self)) {
    self visionsetnakedforplayer("");
    self clearclienttriggeraudiozone(0);
    self lerpfovbypreset("default");
    self setviewmodeldepthoffield(0, 0, 18);
    scripts\mp\utility\player::setdof_default();
    return;
  }
}

function spawnactors(var_0, var_1, var_2) {
  if(!isDefined(self.actors)) {
    self.actors = [];
  }

  self.actors[self.actors.size] = spawn_anim_model(self.linktoent, "commander", "body_animate_jnt", "body_al_qatala_1_ar", "head_sc_finkelstein");
  self.crushcar = spawn_anim_model("crushCar", undefined, "veh8_civ_lnd_walfa_crushable");

  foreach(var_4 in self.actors) {
    var_4.infil = self;
  }

  self.actors[0].anim_playsound_func = &commander_play_sound_func;
}

function infilthink(var_0, var_1) {
  foreach(var_3 in getEntArray("infil_delete", "script_noteworthy")) {
    var_3 delete();
  }

  thread vehiclethink(var_0, self.scene_node, var_1);
  thread actorthink(var_0, self.scene_node, var_1);
  level waittill("infil_started");
  setDvar("r_spotLightEntityShadows", 1);
  level notify("start_scene");
  level waittill("prematch_over");
  setDvar("r_spotLightEntityShadows", 0);

  while(isDefined(self.actors)) {
    waitframe();
  }

  level.stop_station_closed_vo--;
  self delete();
}

function vehiclethink(var_0, var_1, var_2, var_3) {
  var_4 = spawntango72(var_1, var_0, var_2);

  if(!isDefined(self.path)) {
    scripts\common\anim::anim_first_frame_solo(var_4, "tango72_infil_" + var_2 + "_intro");
  }

  var_4 vehicle_turnengineoff();
  level waittill("infil_started");
  var_4 setscriptablepartstate("treadsFX", "neutral");
  var_4 setscriptablepartstate("exhaustFX", "neutral");

  if(scripts\cp_mp\utility\game_utility::isnightmap()) {
    var_4 setscriptablepartstate("night_lights", "on");
  }

  if(isDefined(self.path)) {
    thread vehiclefollowpath(self.linktoent);
  } else {
    thread scripts\common\anim::anim_single_solo(var_4, "tango72_infil_" + var_2 + "_intro");
  }

  var_4 thread scripts\common\anim::anim_single_solo(var_4.turret, "tango72_infil_" + var_2 + "_intro", "tag_turret");

  if(var_2 == "alpha") {
    var_4 playsoundonmovingent("scn_infil_tango_tank_right");
  } else {
    var_4 playsoundonmovingent("scn_infil_tango_tank_left");
  }

  level waittill("prematch_over");
  var_5 = getEnt("t72_spawned_clip", "targetname");

  if(isDefined(var_5)) {
    var_6 = spawn("script_model", var_4.origin);
    var_6.angles = var_4.angles;
    var_6 clonebrushmodeltoscriptmodel(var_5);
    var_6 disconnectPaths();
  }

  var_4 vehphys_deactivate();
  var_4 makecorpse();
  game["infil"]["types"][self.type][var_2]["persistentVehicle"] = &spawnpersistentvehicle;
  game["infil"]["types"][self.type][var_2]["vehicleOrg"] = self.linktoent.origin;
  game["infil"]["types"][self.type][var_2]["vehicleAng"] = self.linktoent.angles;
}

function spawnpersistentvehicle(var_0, var_1) {
  var_2 = game["infil"]["types"][var_0][var_1]["vehicleOrg"];
  var_3 = game["infil"]["types"][var_0][var_1]["vehicleAng"];
  var_4 = spawnVehicle("veh8_mil_lnd_tango72_scan_havok_treads", "armoredtruck", "veh_tango72_mp", var_2, var_3);
  var_4 vehphys_forcekeyframedmotion();
  var_4.animname = "tango72";
  var_5 = spawn("script_model", var_2);
  var_5.angles = var_3;
  var_5 setModel("veh8_mil_lnd_tango72_scan_turret");
  var_5 linkTo(var_4, "tag_turret", (0, 0, 0), (0, 0, 0));
  var_4.turret = var_5;
  var_4.turret.animname = "tango72_turret";
  var_4.turret scripts\common\anim::setanimtree();
  var_4 vehphys_deactivate();
  var_4 makecorpse();
  var_6 = getEnt("t72_spawned_clip", "targetname");

  if(isDefined(var_6)) {
    var_7 = spawn("script_model", var_2);
    var_7.angles = var_3;
    var_7 clonebrushmodeltoscriptmodel(var_6);
    var_7 disconnectPaths();
    return;
  }
}

function vehiclefollowpath(var_0) {
  self endon("death");
  self endon("stop_follow_path");
  self startpath(var_0);

  for(var_1 = getvehiclenode(var_0.target, "targetname"); isDefined(var_1); var_1 = getvehiclenode(var_1.target, "targetname")) {
    var_1 waittill("trigger");

    if(isDefined(var_1.script_unload)) {
      self vehicle_setspeedimmediate(0, 30, 30);

      for(var_2 = self vehicle_getspeed(); var_2 > 1; var_2 = self vehicle_getspeed()) {
        wait 0.1;
      }

      self notify("unload_guys");

      while(self.riders.size > 0) {
        wait 0.1;
      }

      if(isDefined(var_1.target)) {
        self resumespeed(10);
      }
    }

    if(!isDefined(var_1.target)) {
      break;
    }
  }

  self vehicle_setspeedimmediate(0, 30, 30);

  for(var_2 = self vehicle_getspeed(); var_2 > 1; var_2 = self vehicle_getspeed()) {
    wait 0.1;
  }
}

function actorthink(var_0, var_1, var_2, var_3) {
  self.crushcar = spawn_anim_model("crushCar", undefined, "veh8_civ_lnd_walfa_crushable");
  scripts\common\anim::anim_first_frame_solo(self.crushcar, "tango72_infil_" + var_2);
  scripts\mp\utility\infilexfil::hideactors();
  level waittill("infil_started");
  scripts\mp\utility\infilexfil::showactors();
  scripts\common\anim::anim_single_solo(self.crushcar, "tango72_infil_" + var_2);

  if(isDefined(self.crushcar)) {
    self.crushcar delete();
    self.crushcar = undefined;
    return;
  }
}

function spawn_anim_model(var_0, var_1, var_2, var_3, var_4) {
  var_5 = 1;

  if(scripts\engine\utility::cointoss()) {
    var_5 = 0;
  }

  if(var_2 == "random") {
    if(var_5) {
      var_6 = randomint(3);

      if(var_6 == 0) {
        var_2 = "c_civ_pic_male_2_brown";
      } else if(var_6 == 1) {
        var_2 = "body_opforce_london_civ_1_1";
      } else if(var_6 == 2) {
        var_2 = "civ_london_male_2_5";
      }
    } else if(scripts\engine\utility::cointoss()) {
      var_2 = "civ_london_female_1_4";
    } else {
      var_2 = "c_civ_pic_female_5_6";
    }
  }

  var_7 = spawn("script_model", (0, 0, 0));
  var_7 setModel(var_2);

  if(isDefined(var_3)) {
    if(var_3 == "random") {
      if(var_5) {
        if(scripts\engine\utility::cointoss()) {
          var_3 = "head_bg_var_head_bg_male_09_head_sc_male_14";
        } else {
          var_3 = "head_bg_var_head_male_bc_01_head_hero_gator";
        }
      } else if(scripts\engine\utility::cointoss()) {
        var_3 = "head_bg_var_head_female_bc_01_head_sc_female_10";
      } else {
        var_3 = "head_bg_var_head_sc_female_04_head_female_bc_02";
      }
    }

    var_8 = spawn("script_model", (0, 0, 0));
    var_8 setModel(var_3);
    var_8 linkTo(var_7, "j_spine4", (0, 0, 0), (0, 0, 0));
    var_7.head = var_8;
    var_7 thread scripts\engine\utility::delete_on_death(var_8);
  }

  if(isDefined(var_4)) {
    var_9 = spawn("script_model", (0, 0, 0));
    var_9 setModel(var_4);
    var_9 linkTo(var_7, "j_gun", (0, 0, 0), (0, 0, 0));
    var_7 thread scripts\engine\utility::delete_on_death(var_9);
    var_7.weapon = var_9;
  }

  var_7.animname = var_0;
  var_7 scripts\common\anim::setanimtree();

  if(isDefined(var_1)) {
    thread scripts\engine\utility::delete_on_death(var_7);
    var_7 linkTo(self, var_1, (0, 0, 0), (0, 0, 0));
  }

  return var_7;
}

function initanims(var_0) {
  script_model_alpha_anims(var_0);
  vehicles_alpha_anims(var_0);

  switch (var_0) {
    case "alpha":
      scripts\common\anim::addnotetrack_customfunction("commander", "treads_heavy", &treadsheavy, "tango72_infil_alpha");
      scripts\common\anim::addnotetrack_customfunction("commander", "treads_normal", &treadsnormal, "tango72_infil_alpha");
      scripts\common\anim::addnotetrack_customfunction("commander", "treads_neutral", &treadsneutral, "tango72_infil_alpha");
      scripts\common\anim::addnotetrack_customfunction("crushCar", "crush", &crushcar, "tango72_infil_alpha");
      scripts\common\anim::addnotetrack_customfunction("slot_0", "free_look", &scripts\mp\utility\infilexfil::player_free_look, "tango72_infil_alpha_exit");
      scripts\common\anim::addnotetrack_customfunction("slot_1", "free_look", &scripts\mp\utility\infilexfil::player_free_look, "tango72_infil_alpha_exit");
      scripts\common\anim::addnotetrack_customfunction("slot_2", "free_look", &scripts\mp\utility\infilexfil::player_free_look, "tango72_infil_alpha_exit");
      scripts\common\anim::addnotetrack_customfunction("slot_3", "free_look", &scripts\mp\utility\infilexfil::player_free_look, "tango72_infil_alpha_exit");
      scripts\common\anim::addnotetrack_customfunction("slot_4", "free_look", &scripts\mp\utility\infilexfil::player_free_look, "tango72_infil_alpha_exit");
      scripts\common\anim::addnotetrack_customfunction("slot_5", "free_look", &scripts\mp\utility\infilexfil::player_free_look, "tango72_infil_alpha_exit");
      scripts\common\anim::addnotetrack_customfunction("slot_0", "shake_running", &scripts\mp\utility\infilexfil::cam_shake_low, "tango72_infil_alpha_intro");
      scripts\common\anim::addnotetrack_customfunction("slot_1", "shake_running", &scripts\mp\utility\infilexfil::cam_shake_low, "tango72_infil_alpha_intro");
      scripts\common\anim::addnotetrack_customfunction("slot_2", "shake_running", &scripts\mp\utility\infilexfil::cam_shake_low, "tango72_infil_alpha_intro");
      scripts\common\anim::addnotetrack_customfunction("slot_3", "shake_running", &scripts\mp\utility\infilexfil::cam_shake_low, "tango72_infil_alpha_intro");
      scripts\common\anim::addnotetrack_customfunction("slot_4", "shake_running", &scripts\mp\utility\infilexfil::cam_shake_low, "tango72_infil_alpha_intro");
      scripts\common\anim::addnotetrack_customfunction("slot_5", "shake_running", &scripts\mp\utility\infilexfil::cam_shake_low, "tango72_infil_alpha_intro");
      scripts\common\anim::addnotetrack_customfunction("slot_0", "shake_crush", &cam_shake_crush, "tango72_infil_alpha_intro");
      scripts\common\anim::addnotetrack_customfunction("slot_1", "shake_crush", &cam_shake_crush, "tango72_infil_alpha_intro");
      scripts\common\anim::addnotetrack_customfunction("slot_2", "shake_crush", &cam_shake_crush, "tango72_infil_alpha_intro");
      scripts\common\anim::addnotetrack_customfunction("slot_3", "shake_crush", &cam_shake_crush, "tango72_infil_alpha_intro");
      scripts\common\anim::addnotetrack_customfunction("slot_4", "shake_crush", &cam_shake_crush, "tango72_infil_alpha_intro");
      scripts\common\anim::addnotetrack_customfunction("slot_5", "shake_crush", &cam_shake_crush, "tango72_infil_alpha_intro");
      scripts\common\anim::addnotetrack_customfunction("slot_0", "shake_off", &scripts\mp\utility\infilexfil::cam_shake_off, "tango72_infil_alpha_exit");
      scripts\common\anim::addnotetrack_customfunction("slot_1", "shake_off", &scripts\mp\utility\infilexfil::cam_shake_off, "tango72_infil_alpha_exit");
      scripts\common\anim::addnotetrack_customfunction("slot_2", "shake_off", &scripts\mp\utility\infilexfil::cam_shake_off, "tango72_infil_alpha_exit");
      scripts\common\anim::addnotetrack_customfunction("slot_3", "shake_off", &scripts\mp\utility\infilexfil::cam_shake_off, "tango72_infil_alpha_exit");
      scripts\common\anim::addnotetrack_customfunction("slot_4", "shake_off", &scripts\mp\utility\infilexfil::cam_shake_off, "tango72_infil_alpha_exit");
      scripts\common\anim::addnotetrack_customfunction("slot_5", "shake_off", &scripts\mp\utility\infilexfil::cam_shake_off, "tango72_infil_alpha_exit");
      scripts\common\anim::addnotetrack_customfunction("slot_0", "shake_ground", &cam_shake_ground, "tango72_infil_alpha_exit");
      scripts\common\anim::addnotetrack_customfunction("slot_1", "shake_ground", &cam_shake_ground, "tango72_infil_alpha_exit");
      scripts\common\anim::addnotetrack_customfunction("slot_2", "shake_ground", &cam_shake_ground, "tango72_infil_alpha_exit");
      scripts\common\anim::addnotetrack_customfunction("slot_3", "shake_ground", &cam_shake_ground, "tango72_infil_alpha_exit");
      scripts\common\anim::addnotetrack_customfunction("slot_4", "shake_ground", &cam_shake_ground, "tango72_infil_alpha_exit");
      scripts\common\anim::addnotetrack_customfunction("slot_5", "shake_ground", &cam_shake_ground, "tango72_infil_alpha_exit");
      scripts\common\anim::addnotetrack_customfunction("slot_0", "player_lock_look_1_second", &scripts\mp\utility\infilexfil::player_lock_look_1_second, "tango72_infil_alpha_intro");
      scripts\common\anim::addnotetrack_customfunction("slot_1", "player_lock_look_1_second", &scripts\mp\utility\infilexfil::player_lock_look_1_second, "tango72_infil_alpha_intro");
      scripts\common\anim::addnotetrack_customfunction("slot_2", "player_lock_look_1_second", &scripts\mp\utility\infilexfil::player_lock_look_1_second, "tango72_infil_alpha_intro");
      scripts\common\anim::addnotetrack_customfunction("slot_3", "player_lock_look_1_second", &scripts\mp\utility\infilexfil::player_lock_look_1_second, "tango72_infil_alpha_intro");
      scripts\common\anim::addnotetrack_customfunction("slot_4", "player_lock_look_1_second", &scripts\mp\utility\infilexfil::player_lock_look_1_second, "tango72_infil_alpha_intro");
      scripts\common\anim::addnotetrack_customfunction("slot_5", "player_lock_look_1_second", &scripts\mp\utility\infilexfil::player_lock_look_1_second, "tango72_infil_alpha_intro");
      scripts\common\anim::addnotetrack_customfunction("slot_0", "scn_infil_tango_npc_0", &ref_12ef4, "tango72_infil_alpha_exit");
      scripts\common\anim::addnotetrack_customfunction("slot_1", "scn_infil_tango_npc_3", &ref_12ef7, "tango72_infil_alpha_exit");
      scripts\common\anim::addnotetrack_customfunction("slot_2", "scn_infil_tango_npc_1", &ref_12ef5, "tango72_infil_alpha_exit");
      scripts\common\anim::addnotetrack_customfunction("slot_3", "scn_infil_tango_npc_4", &ref_12ef8, "tango72_infil_alpha_exit");
      scripts\common\anim::addnotetrack_customfunction("slot_4", "scn_infil_tango_npc_2", &ref_12ef6, "tango72_infil_alpha_exit");
      scripts\common\anim::addnotetrack_customfunction("slot_5", "scn_infil_tango_npc_5", &ref_12ef9, "tango72_infil_alpha_exit");
      break;
    case "bravo":
      scripts\common\anim::addnotetrack_customfunction("commander", "treads_heavy", &treadsheavy, "tango72_infil_bravo");
      scripts\common\anim::addnotetrack_customfunction("commander", "treads_normal", &treadsnormal, "tango72_infil_bravo");
      scripts\common\anim::addnotetrack_customfunction("commander", "treads_neutral", &treadsneutral, "tango72_infil_bravo");
      scripts\common\anim::addnotetrack_customfunction("crushCar", "crush", &crushcar, "tango72_infil_bravo");
      scripts\common\anim::addnotetrack_customfunction("slot_0", "free_look", &scripts\mp\utility\infilexfil::player_free_look, "tango72_infil_bravo_exit");
      scripts\common\anim::addnotetrack_customfunction("slot_1", "free_look", &scripts\mp\utility\infilexfil::player_free_look, "tango72_infil_bravo_exit");
      scripts\common\anim::addnotetrack_customfunction("slot_2", "free_look", &scripts\mp\utility\infilexfil::player_free_look, "tango72_infil_bravo_exit");
      scripts\common\anim::addnotetrack_customfunction("slot_3", "free_look", &scripts\mp\utility\infilexfil::player_free_look, "tango72_infil_bravo_exit");
      scripts\common\anim::addnotetrack_customfunction("slot_4", "free_look", &scripts\mp\utility\infilexfil::player_free_look, "tango72_infil_bravo_exit");
      scripts\common\anim::addnotetrack_customfunction("slot_5", "free_look", &scripts\mp\utility\infilexfil::player_free_look, "tango72_infil_bravo_exit");
      scripts\common\anim::addnotetrack_customfunction("slot_0", "shake_running", &scripts\mp\utility\infilexfil::cam_shake_low, "tango72_infil_bravo_intro");
      scripts\common\anim::addnotetrack_customfunction("slot_1", "shake_running", &scripts\mp\utility\infilexfil::cam_shake_low, "tango72_infil_bravo_intro");
      scripts\common\anim::addnotetrack_customfunction("slot_2", "shake_running", &scripts\mp\utility\infilexfil::cam_shake_low, "tango72_infil_bravo_intro");
      scripts\common\anim::addnotetrack_customfunction("slot_3", "shake_running", &scripts\mp\utility\infilexfil::cam_shake_low, "tango72_infil_bravo_intro");
      scripts\common\anim::addnotetrack_customfunction("slot_4", "shake_running", &scripts\mp\utility\infilexfil::cam_shake_low, "tango72_infil_bravo_intro");
      scripts\common\anim::addnotetrack_customfunction("slot_5", "shake_running", &scripts\mp\utility\infilexfil::cam_shake_low, "tango72_infil_bravo_intro");
      scripts\common\anim::addnotetrack_customfunction("slot_0", "shake_crush", &cam_shake_crush, "tango72_infil_bravo_intro");
      scripts\common\anim::addnotetrack_customfunction("slot_1", "shake_crush", &cam_shake_crush, "tango72_infil_bravo_intro");
      scripts\common\anim::addnotetrack_customfunction("slot_2", "shake_crush", &cam_shake_crush, "tango72_infil_bravo_intro");
      scripts\common\anim::addnotetrack_customfunction("slot_3", "shake_crush", &cam_shake_crush, "tango72_infil_bravo_intro");
      scripts\common\anim::addnotetrack_customfunction("slot_4", "shake_crush", &cam_shake_crush, "tango72_infil_bravo_intro");
      scripts\common\anim::addnotetrack_customfunction("slot_5", "shake_crush", &cam_shake_crush, "tango72_infil_bravo_intro");
      scripts\common\anim::addnotetrack_customfunction("slot_0", "shake_off", &scripts\mp\utility\infilexfil::cam_shake_off, "tango72_infil_bravo_exit");
      scripts\common\anim::addnotetrack_customfunction("slot_1", "shake_off", &scripts\mp\utility\infilexfil::cam_shake_off, "tango72_infil_bravo_exit");
      scripts\common\anim::addnotetrack_customfunction("slot_2", "shake_off", &scripts\mp\utility\infilexfil::cam_shake_off, "tango72_infil_bravo_exit");
      scripts\common\anim::addnotetrack_customfunction("slot_3", "shake_off", &scripts\mp\utility\infilexfil::cam_shake_off, "tango72_infil_bravo_exit");
      scripts\common\anim::addnotetrack_customfunction("slot_4", "shake_off", &scripts\mp\utility\infilexfil::cam_shake_off, "tango72_infil_bravo_exit");
      scripts\common\anim::addnotetrack_customfunction("slot_5", "shake_off", &scripts\mp\utility\infilexfil::cam_shake_off, "tango72_infil_bravo_exit");
      scripts\common\anim::addnotetrack_customfunction("slot_0", "shake_ground", &cam_shake_ground, "tango72_infil_bravo_exit");
      scripts\common\anim::addnotetrack_customfunction("slot_1", "shake_ground", &cam_shake_ground, "tango72_infil_bravo_exit");
      scripts\common\anim::addnotetrack_customfunction("slot_2", "shake_ground", &cam_shake_ground, "tango72_infil_bravo_exit");
      scripts\common\anim::addnotetrack_customfunction("slot_3", "shake_ground", &cam_shake_ground, "tango72_infil_bravo_exit");
      scripts\common\anim::addnotetrack_customfunction("slot_4", "shake_ground", &cam_shake_ground, "tango72_infil_bravo_exit");
      scripts\common\anim::addnotetrack_customfunction("slot_5", "shake_ground", &cam_shake_ground, "tango72_infil_bravo_exit");
      scripts\common\anim::addnotetrack_customfunction("slot_0", "player_lock_look_1_second", &scripts\mp\utility\infilexfil::player_lock_look_1_second, "tango72_infil_bravo_intro");
      scripts\common\anim::addnotetrack_customfunction("slot_1", "player_lock_look_1_second", &scripts\mp\utility\infilexfil::player_lock_look_1_second, "tango72_infil_bravo_intro");
      scripts\common\anim::addnotetrack_customfunction("slot_2", "player_lock_look_1_second", &scripts\mp\utility\infilexfil::player_lock_look_1_second, "tango72_infil_bravo_intro");
      scripts\common\anim::addnotetrack_customfunction("slot_3", "player_lock_look_1_second", &scripts\mp\utility\infilexfil::player_lock_look_1_second, "tango72_infil_bravo_intro");
      scripts\common\anim::addnotetrack_customfunction("slot_4", "player_lock_look_1_second", &scripts\mp\utility\infilexfil::player_lock_look_1_second, "tango72_infil_bravo_intro");
      scripts\common\anim::addnotetrack_customfunction("slot_5", "player_lock_look_1_second", &scripts\mp\utility\infilexfil::player_lock_look_1_second, "tango72_infil_bravo_intro");
      scripts\common\anim::addnotetrack_customfunction("slot_0", "scn_infil_tango_npc_3", &ref_12ef7, "tango72_infil_bravo_exit");
      scripts\common\anim::addnotetrack_customfunction("slot_1", "scn_infil_tango_npc_0", &ref_12ef4, "tango72_infil_bravo_exit");
      scripts\common\anim::addnotetrack_customfunction("slot_2", "scn_infil_tango_npc_1", &ref_12ef5, "tango72_infil_bravo_exit");
      scripts\common\anim::addnotetrack_customfunction("slot_3", "scn_infil_tango_npc_4", &ref_12ef8, "tango72_infil_bravo_exit");
      scripts\common\anim::addnotetrack_customfunction("slot_4", "scn_infil_tango_npc_2", &ref_12ef6, "tango72_infil_bravo_exit");
      scripts\common\anim::addnotetrack_customfunction("slot_5", "scn_infil_tango_npc_5", &ref_12ef9, "tango72_infil_bravo_exit");
      break;
  }
}

#using_animtree("");

function script_model_alpha_anims(var_0) {
  switch (var_0) {
    case "alpha":
      level.scr_animtree["crushCar"] = #animtree;
      level.scr_anim["crushCar"]["tango72_infil_alpha"] = $mp_infil_tango72_a_carcrush_intro;
      level.scr_animname["crushCar"]["tango72_infil_alpha"] = "mp_infil_tango72_a_carcrush_intro";
      level.scr_animtree["tango72_turret"] = #animtree;
      level.scr_anim["tango72_turret"]["tango72_infil_alpha_intro"] = % mp_infil_tango72_a_turret_intro;
      level.scr_animname["tango72_turret"]["tango72_infil_alpha_intro"] = "mp_infil_tango72_a_turret_intro";
      level.scr_animtree["slot_0"] = #animtree;
      level.scr_anim["slot_0"]["tango72_infil_alpha_intro"] = % mp_infil_tango72_a_guy1_intro_wm;
      level.scr_animname["slot_0"]["tango72_infil_alpha_intro"] = "mp_infil_tango72_a_guy1_intro_wm";
      level.scr_eventanim["slot_0"]["tango72_infil_alpha_intro"] = "infil_tango72_intro_a_1";
      level.scr_anim["slot_0"]["tango72_infil_alpha_exit"] = % mp_infil_tango72_a_guy1_exit_wm;
      level.scr_animname["slot_0"]["tango72_infil_alpha_exit"] = "mp_infil_tango72_a_guy1_exit_wm";
      level.scr_eventanim["slot_0"]["tango72_infil_alpha_exit"] = "infil_tango72_exit_a_1";
      level.scr_animtree["slot_1"] = #animtree;
      level.scr_anim["slot_1"]["tango72_infil_alpha_intro"] = % mp_infil_tango72_a_guy2_intro_wm;
      level.scr_animname["slot_1"]["tango72_infil_alpha_intro"] = "mp_infil_tango72_a_guy2_intro_wm";
      level.scr_eventanim["slot_1"]["tango72_infil_alpha_intro"] = "infil_tango72_intro_a_2";
      level.scr_anim["slot_1"]["tango72_infil_alpha_exit"] = % mp_infil_tango72_a_guy2_exit_wm;
      level.scr_animname["slot_1"]["tango72_infil_alpha_exit"] = "mp_infil_tango72_a_guy2_exit_wm";
      level.scr_eventanim["slot_1"]["tango72_infil_alpha_exit"] = "infil_tango72_exit_a_2";
      level.scr_animtree["slot_2"] = #animtree;
      level.scr_anim["slot_2"]["tango72_infil_alpha_intro"] = % mp_infil_tango72_a_guy3_intro_wm;
      level.scr_animname["slot_2"]["tango72_infil_alpha_intro"] = "mp_infil_tango72_a_guy3_intro_wm";
      level.scr_eventanim["slot_2"]["tango72_infil_alpha_intro"] = "infil_tango72_intro_a_3";
      level.scr_anim["slot_2"]["tango72_infil_alpha_exit"] = % mp_infil_tango72_a_guy3_exit_wm;
      level.scr_animname["slot_2"]["tango72_infil_alpha_exit"] = "mp_infil_tango72_a_guy3_exit_wm";
      level.scr_eventanim["slot_2"]["tango72_infil_alpha_exit"] = "infil_tango72_exit_a_3";
      level.scr_animtree["slot_3"] = #animtree;
      level.scr_anim["slot_3"]["tango72_infil_alpha_intro"] = % mp_infil_tango72_a_guy4_intro_wm;
      level.scr_animname["slot_3"]["tango72_infil_alpha_intro"] = "mp_infil_tango72_a_guy4_intro_wm";
      level.scr_eventanim["slot_3"]["tango72_infil_alpha_intro"] = "infil_tango72_intro_a_4";
      level.scr_anim["slot_3"]["tango72_infil_alpha_exit"] = % mp_infil_tango72_a_guy4_exit_wm;
      level.scr_animname["slot_3"]["tango72_infil_alpha_exit"] = "mp_infil_tango72_a_guy4_exit_wm";
      level.scr_eventanim["slot_3"]["tango72_infil_alpha_exit"] = "infil_tango72_exit_a_4";
      level.scr_animtree["slot_4"] = #animtree;
      level.scr_anim["slot_4"]["tango72_infil_alpha_intro"] = % mp_infil_tango72_a_guy5_intro_wm;
      level.scr_animname["slot_4"]["tango72_infil_alpha_intro"] = "mp_infil_tango72_a_guy5_intro_wm";
      level.scr_eventanim["slot_4"]["tango72_infil_alpha_intro"] = "infil_tango72_intro_a_5";
      level.scr_anim["slot_4"]["tango72_infil_alpha_exit"] = % mp_infil_tango72_a_guy5_exit_wm;
      level.scr_animname["slot_4"]["tango72_infil_alpha_exit"] = "mp_infil_tango72_a_guy5_exit_wm";
      level.scr_eventanim["slot_4"]["tango72_infil_alpha_exit"] = "infil_tango72_exit_a_5";
      level.scr_animtree["slot_5"] = #animtree;
      level.scr_anim["slot_5"]["tango72_infil_alpha_intro"] = % mp_infil_tango72_a_guy6_intro_wm;
      level.scr_animname["slot_5"]["tango72_infil_alpha_intro"] = "mp_infil_tango72_a_guy6_intro_wm";
      level.scr_eventanim["slot_5"]["tango72_infil_alpha_intro"] = "infil_tango72_intro_a_6";
      level.scr_anim["slot_5"]["tango72_infil_alpha_exit"] = % mp_infil_tango72_a_guy6_exit_wm;
      level.scr_animname["slot_5"]["tango72_infil_alpha_exit"] = "mp_infil_tango72_a_guy6_exit_wm";
      level.scr_eventanim["slot_5"]["tango72_infil_alpha_exit"] = "infil_tango72_exit_a_6";
      break;
    case "bravo":
      level.scr_animtree["crushCar"] = #animtree;
      level.scr_anim["crushCar"]["tango72_infil_bravo"] = % mp_infil_tango72_b_carcrush_intro;
      level.scr_animname["crushCar"]["tango72_infil_bravo"] = "mp_infil_tango72_b_carcrush_intro";
      level.scr_animtree["tango72_turret"] = #animtree;
      level.scr_anim["tango72_turret"]["tango72_infil_bravo_intro"] = % mp_infil_tango72_b_turret_intro;
      level.scr_animname["tango72_turret"]["tango72_infil_bravo_intro"] = "mp_infil_tango72_b_turret_intro";
      level.scr_animtree["slot_0"] = #animtree;
      level.scr_anim["slot_0"]["tango72_infil_bravo_intro"] = % mp_infil_tango72_b_guy1_intro_wm;
      level.scr_animname["slot_0"]["tango72_infil_bravo_intro"] = "mp_infil_tango72_b_guy1_intro_wm";
      level.scr_eventanim["slot_0"]["tango72_infil_bravo_intro"] = "infil_tango72_intro_b_1";
      level.scr_anim["slot_0"]["tango72_infil_bravo_exit"] = % mp_infil_tango72_b_guy1_exit_wm;
      level.scr_animname["slot_0"]["tango72_infil_bravo_exit"] = "mp_infil_tango72_b_guy1_exit_wm";
      level.scr_eventanim["slot_0"]["tango72_infil_bravo_exit"] = "infil_tango72_exit_b_1";
      level.scr_animtree["slot_1"] = #animtree;
      level.scr_anim["slot_1"]["tango72_infil_bravo_intro"] = % mp_infil_tango72_b_guy2_intro_wm;
      level.scr_animname["slot_1"]["tango72_infil_bravo_intro"] = "mp_infil_tango72_b_guy2_intro_wm";
      level.scr_eventanim["slot_1"]["tango72_infil_bravo_intro"] = "infil_tango72_intro_b_2";
      level.scr_anim["slot_1"]["tango72_infil_bravo_exit"] = % mp_infil_tango72_b_guy2_exit_wm;
      level.scr_animname["slot_1"]["tango72_infil_bravo_exit"] = "mp_infil_tango72_b_guy2_exit_wm";
      level.scr_eventanim["slot_1"]["tango72_infil_bravo_exit"] = "infil_tango72_exit_b_2";
      level.scr_animtree["slot_2"] = #animtree;
      level.scr_anim["slot_2"]["tango72_infil_bravo_intro"] = % mp_infil_tango72_b_guy3_intro_wm;
      level.scr_animname["slot_2"]["tango72_infil_bravo_intro"] = "mp_infil_tango72_b_guy3_intro_wm";
      level.scr_eventanim["slot_2"]["tango72_infil_bravo_intro"] = "infil_tango72_intro_b_3";
      level.scr_anim["slot_2"]["tango72_infil_bravo_exit"] = % mp_infil_tango72_b_guy3_exit_wm;
      level.scr_animname["slot_2"]["tango72_infil_bravo_exit"] = "mp_infil_tango72_b_guy3_exit_wm";
      level.scr_eventanim["slot_2"]["tango72_infil_bravo_exit"] = "infil_tango72_exit_b_3";
      level.scr_animtree["slot_3"] = #animtree;
      level.scr_anim["slot_3"]["tango72_infil_bravo_intro"] = % mp_infil_tango72_b_guy4_intro_wm;
      level.scr_animname["slot_3"]["tango72_infil_bravo_intro"] = "mp_infil_tango72_b_guy4_intro_wm";
      level.scr_eventanim["slot_3"]["tango72_infil_bravo_intro"] = "infil_tango72_intro_b_4";
      level.scr_anim["slot_3"]["tango72_infil_bravo_exit"] = % mp_infil_tango72_b_guy4_exit_wm;
      level.scr_animname["slot_3"]["tango72_infil_bravo_exit"] = "mp_infil_tango72_b_guy4_exit_wm";
      level.scr_eventanim["slot_3"]["tango72_infil_bravo_exit"] = "infil_tango72_exit_b_4";
      level.scr_animtree["slot_4"] = #animtree;
      level.scr_anim["slot_4"]["tango72_infil_bravo_intro"] = % mp_infil_tango72_b_guy5_intro_wm;
      level.scr_animname["slot_4"]["tango72_infil_bravo_intro"] = "mp_infil_tango72_b_guy5_intro_wm";
      level.scr_eventanim["slot_4"]["tango72_infil_bravo_intro"] = "infil_tango72_intro_b_5";
      level.scr_anim["slot_4"]["tango72_infil_bravo_exit"] = % mp_infil_tango72_b_guy5_exit_wm;
      level.scr_animname["slot_4"]["tango72_infil_bravo_exit"] = "mp_infil_tango72_b_guy5_exit_wm";
      level.scr_eventanim["slot_4"]["tango72_infil_bravo_exit"] = "infil_tango72_exit_b_5";
      level.scr_animtree["slot_5"] = #animtree;
      level.scr_anim["slot_5"]["tango72_infil_bravo_intro"] = % mp_infil_tango72_b_guy6_intro_wm;
      level.scr_animname["slot_5"]["tango72_infil_bravo_intro"] = "mp_infil_tango72_b_guy6_intro_wm";
      level.scr_eventanim["slot_5"]["tango72_infil_bravo_intro"] = "infil_tango72_intro_b_6";
      level.scr_anim["slot_5"]["tango72_infil_bravo_exit"] = % mp_infil_tango72_b_guy6_exit_wm;
      level.scr_animname["slot_5"]["tango72_infil_bravo_exit"] = "mp_infil_tango72_b_guy6_exit_wm";
      level.scr_eventanim["slot_5"]["tango72_infil_bravo_exit"] = "infil_tango72_exit_b_6";
      break;
  }
}

function vehicles_alpha_anims(var_0) {
  switch (var_0) {
    case "alpha":
      level.scr_animtree["tango72"] = #animtree;
      level.scr_anim["tango72"]["tango72_infil_alpha_intro"] = $mp_infil_tango72_a_veh_intro;
      break;
    case "bravo":
      level.scr_animtree["tango72"] = #animtree;
      level.scr_anim["tango72"]["tango72_infil_bravo_intro"] = % mp_infil_tango72_b_veh_intro;
      break;
  }
}

function spawntango72(var_0, var_1, var_2) {
  var_3 = var_0.origin;
  var_4 = var_0.angles;

  if(isDefined(self.path)) {
    var_3 = self.path.origin;
    var_4 = self.path.angles;
  }

  var_5 = spawnVehicle("veh8_mil_lnd_tango72_scan_havok_treads", "armoredtruck", "veh_tango72_mp", var_3, var_4);
  var_5 setvehicleteam(var_1);
  var_5 vehphys_forcekeyframedmotion();
  var_5.animname = "tango72";
  var_6 = spawn("script_model", var_0.origin);
  var_6.angles = var_0.angles;
  var_6 setModel("veh8_mil_lnd_tango72_scan_turret");
  var_6 linkTo(var_5, "tag_turret", (0, 0, 0), (0, 0, 0));
  var_5.turret = var_6;
  var_5.turret.animname = "tango72_turret";
  var_5.turret scripts\common\anim::setanimtree();
  self.linktoent = var_5;
  var_5.infil = self;
  var_5 setCanDamage(0);
  return var_5;
}

function commander_play_sound_func(var_0, var_1, var_2) {
  foreach(var_4 in self.infil.players) {
    self playsoundtoplayer(var_0, var_4);
  }
}

function treadsheavy(var_0) {
  var_1 = var_0.infil.linktoent;
  var_1 setscriptablepartstate("treadsFX", "heavy");
  var_1 setscriptablepartstate("exhaustFX", "active");
}

function treadsnormal(var_0) {
  var_1 = var_0.infil.linktoent;
  var_1 setscriptablepartstate("treadsFX", "normal");
  var_1 setscriptablepartstate("exhaustFX", "active");
}

function treadsneutral(var_0) {
  var_1 = var_0.infil.linktoent;
  var_1 setscriptablepartstate("treadsFX", "neutral");
  var_1 setscriptablepartstate("exhaustFX", "neutral");

  if(scripts\cp_mp\utility\game_utility::isnightmap()) {
    var_1 setscriptablepartstate("night_lights", "off");
    return;
  }
}

function cam_shake_crush(var_0) {
  var_1 = var_0.player;
  var_1 scripts\mp\utility\infilexfil::updateshakeonplayer(0.145, 0.16, 2, var_1.origin, 8000, "pistol_fire", 0.05, 0.15);
}

function cam_shake_ground(var_0) {
  var_1 = var_0.player;
  var_1 notify("stop_cam_shake");
  var_1 playrumbleonpositionforclient("ground_pound_land", var_1.origin);
}

function crushcar(var_0) {
  if(isDefined(var_0._lastanime) && var_0._lastanime == "tango72_infil_bravo") {
    var_0 playSound("scn_infil_tango_car_crush_left");
  } else {
    var_0 playSound("scn_infil_tango_car_crush_right");
  }

  var_0 setscriptablepartstate("car", "crush", 0);
}

function ref_12ef4(var_0) {
  var_0 playsoundonmovingent("scn_infil_tango_npc_0");
}

function ref_12ef5(var_0) {
  var_0 playsoundonmovingent("scn_infil_tango_npc_1");
}

function ref_12ef6(var_0) {
  var_0 playsoundonmovingent("scn_infil_tango_npc_2");
}

function ref_12ef7(var_0) {
  var_0 playsoundonmovingent("scn_infil_tango_npc_3");
}

function ref_12ef8(var_0) {
  var_0 playsoundonmovingent("scn_infil_tango_npc_4");
}

function ref_12ef9(var_0) {
  var_0 playsoundonmovingent("scn_infil_tango_npc_5");
}