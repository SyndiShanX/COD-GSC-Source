/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\infilexfil\mi8_infil.gsc
***********************************************/

function mi8_init(var_0) {
  var_1 = [];
  GscBinSkip0(0x2e, 0, [11, 10]);
}

function mi8_spawn(var_0, var_1, var_2, var_3) {
  var_4 = scripts\engine\utility::getStruct(var_1, "targetname");
  var_5 = scripts\cp_mp\utility\game_utility::getmapname();

  if(var_5 == "mp_riverside_gw") {
    if(var_0 == "allies") {
      if(distance2dsquared(var_4.origin, (-8540.17, 31520.1, -487.5)) < 100) {
        var_2 = "bravo";
        var_3 = "bravo";
      }
    } else if(distance2dsquared(var_4.origin, (7145.82, 23997.2, -34)) < 100) {
      var_2 = "bravo";
      var_3 = "bravo";
    }
  }

  initanims(var_2, var_0, var_3);
  ref_12802(var_4, var_0, var_2, var_3);
  var_6 = spawn("script_origin", var_4.origin);
  var_6.angles = var_4.angles;
  var_6.scene_node = var_4;
  var_6.subtype = var_2;
  var_6.ref_1214c = var_3;
  thread infilthink(var_6, var_0);
  return var_6;
}

function ref_12896(var_0, var_1, var_2) {
  var_3 = var_0.scene_node.origin;
  var_4 = var_0.scene_node.angles;

  for(;;) {
    thread scripts\cp_mp\utility\debug_utility::drawangles(var_3, var_4, level.framedurationseconds, 1);
    waitframe();
  }
}

function ref_12802(var_0, var_1, var_2, var_3) {
  var_4 = scripts\cp_mp\utility\game_utility::getmapname();

  switch (var_4) {
    case "mp_downtown_gw":
      switch (var_3) {
        case "alpha":
          if(var_1 == "axis") {
            var_0.angles += (0, 8, 0);
          } else {
            var_0.angles += (0, 23, 0);
            var_0.origin += anglesToForward(var_0.angles) * 100;
          }

          break;
        case "alpha1":
          if(var_1 == "axis") {
            var_0.angles += (0, -8, 0);
          } else {
            var_0.angles += (0, -3, 0);
          }

          break;
        case "alpha2":
          if(var_1 == "axis") {
            var_0.angles += (0, -3, 0);
            var_0.origin += anglesToForward(var_0.angles) * 200;
          } else {
            var_0.angles += (0, 12, 0);
          }

          break;
      }

      break;
    case "mp_farms2_gw":
      switch (var_3) {
        case "bravo":
          if(var_1 == "allies") {
            var_0.origin -= (0, 0, 86);
          }

          break;
      }
    case "mp_promenade_gw":
      switch (var_3) {
        case "alpha":
          if(var_1 == "allies") {
            var_0.angles -= (0, 30, 0);
          }

          break;
      }

      break;
  }
}

function mi8_get_length(var_0) {
  var_1 = getanimlength(level.scr_anim["slot_0"]["mi8_infil"]);
  return var_1;
}

function player_mi8_infil_think(var_0, var_1) {
  self endon("player_free_spot");
  thread infil_radio_idle(var_0);
  thread player_infil_end();
  var_2 = var_0.origin;
  var_3 = var_0.angles;
  thread scripts\mp\utility\infilexfil::infil_player_rig_updated("slot_" + var_1, var_2, var_3);
  self setdemeanorviewmodel("safe", "iw8_ges_demeanor_safe_heli");
  self lerpfovbypreset("80_instant");
  self lerpfovscalefactor(0, 0);
  self.player_rig linkTo(var_0);
  var_0 scripts\common\anim::anim_first_frame_solo(self.player_rig, "mi8_infil");
  thread scripts\mp\infilexfil\infilexfil::infil_scene_fade_in(0, 0.55);
  thread player_disconnect();
  scripts\mp\flags::gameflagwait("infil_started");

  if(isDefined(self.team) && self.team != "spectator") {
    var_4 = [];
    GscBinSkip0(0x2e, var_4.size, "mp_infil_mix_normal");
  }

  if(isDefined(self.animname) && !isai(self)) {
    var_8 = "scn_infil_mindia_plr_1";

    switch (self.animname) {
      case "slot_0":
        var_8 = "scn_infil_mindia_plr_1";
        break;
      case "slot_1":
        var_8 = "scn_infil_mindia_plr_2";
        break;
      case "slot_2":
        var_8 = "scn_infil_mindia_plr_3";
        break;
      case "slot_3":
        var_8 = "scn_infil_mindia_plr_4";
        break;
      case "slot_4":
        var_8 = "scn_infil_mindia_plr_5";
        break;
      case "slot_5":
        var_8 = "scn_infil_mindia_plr_6";
        break;
      case "slot_6":
        var_8 = "scn_infil_mindia_plr_1";
        break;
      case "slot_7":
        var_8 = "scn_infil_mindia_plr_2";
        break;
      case "slot_8":
        var_8 = "scn_infil_mindia_plr_3";
        break;
      case "slot_9":
        var_8 = "scn_infil_mindia_plr_4";
        break;
      case "slot_10":
        var_8 = "scn_infil_mindia_plr_5";
        break;
      case "slot_11":
        var_8 = "scn_infil_mindia_plr_6";
        break;
      default:
        var_8 = "scn_infil_mindia_plr_1";
        break;
    }

    self playlocalsound(var_8);
    self playlocalsound("scn_infil_mindia_heli_int_lr");
  }

  self setcinematicmotionoverride("disabled");
  self lerpviewangleclamp(1, 0.25, 0.25, 60, 60, 30, 30);
  thread clear_infil_ambient_zone();
  var_1 scripts\mp\anim::anim_player_solo(self, self.player_rig, "mi8_infil");

  if(isDefined(self.player_rig) && self.player_rig islinked()) {
    self.player_rig unlink();
  }

  self lerpfovscalefactor(1, 2);
  self visionsetnakedforplayer("", 0.75);
  self setdemeanorviewmodel("normal");
  self clearcinematicmotionoverride();
  self disablephysicaldepthoffieldscripting();
}

function clear_infil_ambient_zone() {
  self endon("death_or_disconnect");
  wait 4;
  self setclienttriggeraudiozonepartialwithfade("mindia_infil_mix", 4, "mix");
  wait 4;
  self clearallsoundsubmixes();
  self clearclienttriggeraudiozone(2);
}

function player_infil_end() {
  self endon("disconnect");
  level waittill("prematch_over");
  self notify("remove_rig");
  self clearclienttriggeraudiozone(1);
  scripts\mp\utility\player::setdof_default();
}

function infil_radio_idle(var_0) {
  if(isPlayer(self)) {
    self setclienttriggeraudiozonepartialwithfade("mindia_preinfil_mix", 0.05, "mix");
    wait 0.5;

    if(!isDefined(self)) {
      return;
    }

    self playlocalsound("scn_infil_mindia_heli_prestart");
    var_1 = spawn("script_origin", (0, 0, 0));
    var_1 showonlytoplayer(self);

    if(isDefined(self.team)) {
      var_2 = scripts\mp\utility\teams::getteamvoiceinfix(self.team);
      var_3 = "dx_mpo_" + var_2 + "op_drone_deathchatter";
    } else {
      var_3 = "dx_mpo_usop_drone_deathchatter";
    }

    if(soundexists(var_3)) {
      var_3 playLoopSound(var_3);
    } else {
      var_3 playLoopSound("dx_mpo_usop_drone_deathchatter");
    }

    scripts\mp\flags::gameflagwait("infil_started");
    wait 1;

    if(isDefined(self)) {
      self stoplocalsound("scn_infil_mindia_heli_prestart");
    }

    wait 1;
    var_3 stoploopsound(var_3);
    var_3 delete();
    return;
  }
}

function player_disconnect() {
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

  var_3 = getcommanderassets(var_0);
  self.actors[self.actors.size] = spawn_anim_model(self.linktoent, "commander", "tag_origin", var_3.body, var_3.head);
  self.actors[self.actors.size] = spawn_anim_model(self.linktoent, "driver", "tag_origin", var_3.body, var_3.head);

  foreach(var_5 in self.actors) {
    var_5.infil = self;
  }

  self.actors[0].anim_playsound_func = &commander_play_sound_func;
  self.actors[1].anim_playsound_func = &driver_play_sound_func;
}

function blima_chief_play_sound_func(var_0, var_1, var_2) {
  foreach(var_4 in self.blima.players) {
    var_4 playsoundtoplayer(var_0, var_4);
  }
}

function infilthink(var_0, var_1) {
  var_2 = getdvarfloat("r_mbVelocityScale", 0.2);

  foreach(var_4 in getEntArray("infil_delete", "script_noteworthy")) {
    var_4 delete();
  }

  thread vehiclethink(var_0, self.scene_node, var_1);
  scripts\mp\flags::gameflagwait("infil_started");
  setDvar("r_spotLightEntityShadows", 1);
  setDvar("r_mbVelocityScale", 1);
  level notify("start_scene");
  level waittill("prematch_over");
  setDvar("r_spotLightEntityShadows", 0);
  setDvar("r_mbVelocityScale", var_2);

  while(isDefined(self.linktoent) || isDefined(self.actors)) {
    waitframe();
  }

  level.stop_station_closed_vo--;
  self delete();
}

function vehiclethink(var_0, var_1, var_2, var_3) {
  self.linktoent = spawninfilvehicle(var_1, var_0, var_2);

  if(self.ref_1214c != self.subtype && (getDvar("mapname") == "mp_downtown_gw" || getDvar("mapname") == "mp_port2_gw")) {
    var_2 = self.ref_1214c;
  }

  scripts\common\anim::anim_first_frame_solo(self.linktoent, "mi8_infil_" + var_2 + "_" + var_0);
  scripts\mp\flags::gameflagwait("infil_started");
  self.linktoent setscriptablepartstate("engine", "on", 0);
  self.linktoent setscriptablepartstate("blinking_light", "red", 0);
  self.linktoent setscriptablepartstate("infil_lights", "on", 0);
  thread ref_11bf2();
  thread scripts\common\anim::anim_single_solo(self.linktoent, "mi8_infil_" + var_2 + "_" + var_0);
  var_4 = getanimlength(level.scr_anim["mi8"]["mi8_infil_" + var_2 + "_" + var_0]);
  wait var_4;
  self.linktoent delete();
  self.linktoent = undefined;
}

function ref_11bf2() {
  self playsoundonmovingent("scn_infil_mindia_heli_ext");
}

function van_infil_sfx_npc1(var_0) {
  var_0 playsoundonmovingent("scn_infil_hackney_van_npc3");
}

function van_infil_sfx_npc2(var_0) {
  var_0 playsoundonmovingent("scn_infil_hackney_van_npc2");
}

function van_infil_sfx_npc3(var_0) {
  var_0 playsoundonmovingent("scn_infil_hackney_van_npc1");
}

function van_infil_sfx_npc4(var_0) {
  var_0 playsoundonmovingent("scn_infil_hackney_van_npc6");
}

function van_infil_sfx_npc5(var_0) {
  var_0 playsoundonmovingent("scn_infil_hackney_van_npc5");
}

function van_infil_sfx_npc6(var_0) {
  var_0 playsoundonmovingent("scn_infil_hackney_van_npc4");
}

function actorthink(var_0, var_1, var_2, var_3) {
  thread spawnactors(var_0, var_2, var_3);
  self.linktoent scripts\common\anim::anim_first_frame(self.actors, "mi8_infil_" + var_2, "tag_origin");
  scripts\mp\flags::gameflagwait("infil_started");
  self.linktoent thread scripts\common\anim::anim_single(self.actors, "mi8_infil_" + var_2, "tag_origin");
  self.actors[0].head scriptmodelplayanim(level.scr_anim[self.actors[0].animname]["mi8_infil_" + var_2]);
  var_4 = getanimlength(level.scr_anim["commander"]["mi8_infil_" + var_2]);
  wait var_4;

  foreach(var_6 in self.actors) {
    var_6 delete();
  }

  self.actors = undefined;
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

function initanims(var_0, var_1, var_2) {
  script_model_alpha_anims(var_0);
  vehicles_alpha_anims(var_0, var_1, var_2);
  scripts\common\anim::addnotetrack_customfunction("slot_0", "fov_63_2", &scripts\mp\utility\infilexfil::player_fov_default_2);
  scripts\common\anim::addnotetrack_customfunction("slot_1", "fov_63_2", &scripts\mp\utility\infilexfil::player_fov_default_2);
  scripts\common\anim::addnotetrack_customfunction("slot_2", "fov_63_2", &scripts\mp\utility\infilexfil::player_fov_default_2);
  scripts\common\anim::addnotetrack_customfunction("slot_3", "fov_63_2", &scripts\mp\utility\infilexfil::player_fov_default_2);
  scripts\common\anim::addnotetrack_customfunction("slot_4", "fov_63_2", &scripts\mp\utility\infilexfil::player_fov_default_2);
  scripts\common\anim::addnotetrack_customfunction("slot_5", "fov_63_2", &scripts\mp\utility\infilexfil::player_fov_default_2);
  scripts\common\anim::addnotetrack_customfunction("slot_6", "fov_63_2", &scripts\mp\utility\infilexfil::player_fov_default_2);
  scripts\common\anim::addnotetrack_customfunction("slot_7", "fov_63_2", &scripts\mp\utility\infilexfil::player_fov_default_2);
  scripts\common\anim::addnotetrack_customfunction("slot_8", "fov_63_2", &scripts\mp\utility\infilexfil::player_fov_default_2);
  scripts\common\anim::addnotetrack_customfunction("slot_9", "fov_63_2", &scripts\mp\utility\infilexfil::player_fov_default_2);
  scripts\common\anim::addnotetrack_customfunction("slot_10", "fov_63_2", &scripts\mp\utility\infilexfil::player_fov_default_2);
  scripts\common\anim::addnotetrack_customfunction("slot_11", "fov_63_2", &scripts\mp\utility\infilexfil::player_fov_default_2);
  scripts\common\anim::addnotetrack_customfunction("slot_0", "shake_running", &scripts\mp\utility\infilexfil::cam_shake_running, "mi8_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_1", "shake_running", &scripts\mp\utility\infilexfil::cam_shake_running, "mi8_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_2", "shake_running", &scripts\mp\utility\infilexfil::cam_shake_running, "mi8_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_3", "shake_running", &scripts\mp\utility\infilexfil::cam_shake_running, "mi8_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_4", "shake_running", &scripts\mp\utility\infilexfil::cam_shake_running, "mi8_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_5", "shake_running", &scripts\mp\utility\infilexfil::cam_shake_running, "mi8_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_6", "shake_running", &scripts\mp\utility\infilexfil::cam_shake_running, "mi8_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_7", "shake_running", &scripts\mp\utility\infilexfil::cam_shake_running, "mi8_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_8", "shake_running", &scripts\mp\utility\infilexfil::cam_shake_running, "mi8_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_9", "shake_running", &scripts\mp\utility\infilexfil::cam_shake_running, "mi8_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_10", "shake_running", &scripts\mp\utility\infilexfil::cam_shake_running, "mi8_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_11", "shake_running", &scripts\mp\utility\infilexfil::cam_shake_running, "mi8_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_0", "shake_off", &customground, "mi8_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_1", "shake_off", &customground, "mi8_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_2", "shake_off", &customground, "mi8_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_3", "shake_off", &customground, "mi8_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_4", "shake_off", &customground, "mi8_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_5", "shake_off", &customground, "mi8_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_6", "shake_off", &customground, "mi8_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_7", "shake_off", &customground, "mi8_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_8", "shake_off", &customground, "mi8_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_9", "shake_off", &customground, "mi8_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_10", "shake_off", &customground, "mi8_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_11", "shake_off", &customground, "mi8_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_0", "equip_nvg", &scripts\mp\utility\infilexfil::player_equip_nvg, "mi8_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_1", "equip_nvg", &scripts\mp\utility\infilexfil::player_equip_nvg, "mi8_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_2", "equip_nvg", &scripts\mp\utility\infilexfil::player_equip_nvg, "mi8_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_3", "equip_nvg", &scripts\mp\utility\infilexfil::player_equip_nvg, "mi8_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_4", "equip_nvg", &scripts\mp\utility\infilexfil::player_equip_nvg, "mi8_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_5", "equip_nvg", &scripts\mp\utility\infilexfil::player_equip_nvg, "mi8_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_6", "equip_nvg", &scripts\mp\utility\infilexfil::player_equip_nvg, "mi8_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_7", "equip_nvg", &scripts\mp\utility\infilexfil::player_equip_nvg, "mi8_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_8", "equip_nvg", &scripts\mp\utility\infilexfil::player_equip_nvg, "mi8_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_9", "equip_nvg", &scripts\mp\utility\infilexfil::player_equip_nvg, "mi8_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_10", "equip_nvg", &scripts\mp\utility\infilexfil::player_equip_nvg, "mi8_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_11", "equip_nvg", &scripts\mp\utility\infilexfil::player_equip_nvg, "mi8_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_0", "player_lock_look_1_second", &scripts\mp\utility\infilexfil::player_lock_look_1_second, "mi8_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_1", "player_lock_look_1_second", &scripts\mp\utility\infilexfil::player_lock_look_1_second, "mi8_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_2", "player_lock_look_1_second", &scripts\mp\utility\infilexfil::player_lock_look_1_second, "mi8_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_3", "player_lock_look_1_second", &scripts\mp\utility\infilexfil::player_lock_look_1_second, "mi8_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_4", "player_lock_look_1_second", &scripts\mp\utility\infilexfil::player_lock_look_1_second, "mi8_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_5", "player_lock_look_1_second", &scripts\mp\utility\infilexfil::player_lock_look_1_second, "mi8_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_6", "player_lock_look_1_second", &scripts\mp\utility\infilexfil::player_lock_look_1_second, "mi8_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_7", "player_lock_look_1_second", &scripts\mp\utility\infilexfil::player_lock_look_1_second, "mi8_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_8", "player_lock_look_1_second", &scripts\mp\utility\infilexfil::player_lock_look_1_second, "mi8_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_9", "player_lock_look_1_second", &scripts\mp\utility\infilexfil::player_lock_look_1_second, "mi8_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_10", "player_lock_look_1_second", &scripts\mp\utility\infilexfil::player_lock_look_1_second, "mi8_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_11", "player_lock_look_1_second", &scripts\mp\utility\infilexfil::player_lock_look_1_second, "mi8_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_0", "free_look", &scripts\mp\utility\infilexfil::player_free_look, "mi8_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_1", "free_look", &scripts\mp\utility\infilexfil::player_free_look, "mi8_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_2", "free_look", &scripts\mp\utility\infilexfil::player_free_look, "mi8_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_3", "free_look", &scripts\mp\utility\infilexfil::player_free_look, "mi8_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_4", "free_look", &scripts\mp\utility\infilexfil::player_free_look, "mi8_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_5", "free_look", &scripts\mp\utility\infilexfil::player_free_look, "mi8_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_6", "free_look", &scripts\mp\utility\infilexfil::player_free_look, "mi8_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_7", "free_look", &scripts\mp\utility\infilexfil::player_free_look, "mi8_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_8", "free_look", &scripts\mp\utility\infilexfil::player_free_look, "mi8_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_9", "free_look", &scripts\mp\utility\infilexfil::player_free_look, "mi8_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_10", "free_look", &scripts\mp\utility\infilexfil::player_free_look, "mi8_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_11", "free_look", &scripts\mp\utility\infilexfil::player_free_look, "mi8_infil");
}

#using_animtree("");

function script_model_alpha_anims(var_0) {
  level.scr_animtree["slot_0"] = #animtree;
  level.scr_anim["slot_0"]["mi8_infil"] = $mp_infil_mi8_guyl_01;
  level.scr_animname["slot_0"]["mi8_infil"] = "mp_infil_mi8_guyL_01";
  level.scr_eventanim["slot_0"]["mi8_infil"] = "infil_mi8_left_1";
  level.scr_animtree["slot_1"] = #animtree;
  level.scr_anim["slot_1"]["mi8_infil"] = % mp_infil_mi8_guyl_02;
  level.scr_animname["slot_1"]["mi8_infil"] = "mp_infil_mi8_guyL_02";
  level.scr_eventanim["slot_1"]["mi8_infil"] = "infil_mi8_left_2";
  level.scr_animtree["slot_2"] = #animtree;
  level.scr_anim["slot_2"]["mi8_infil"] = % mp_infil_mi8_guyl_03;
  level.scr_animname["slot_2"]["mi8_infil"] = "mp_infil_mi8_guyL_03";
  level.scr_eventanim["slot_2"]["mi8_infil"] = "infil_mi8_left_3";
  level.scr_animtree["slot_3"] = #animtree;
  level.scr_anim["slot_3"]["mi8_infil"] = % mp_infil_mi8_guyl_04;
  level.scr_animname["slot_3"]["mi8_infil"] = "mp_infil_mi8_guyL_04";
  level.scr_eventanim["slot_3"]["mi8_infil"] = "infil_mi8_left_4";
  level.scr_animtree["slot_4"] = #animtree;
  level.scr_anim["slot_4"]["mi8_infil"] = % mp_infil_mi8_guyl_05;
  level.scr_animname["slot_4"]["mi8_infil"] = "mp_infil_mi8_guyL_05";
  level.scr_eventanim["slot_4"]["mi8_infil"] = "infil_mi8_left_5";
  level.scr_animtree["slot_5"] = #animtree;
  level.scr_anim["slot_5"]["mi8_infil"] = % mp_infil_mi8_guyl_06;
  level.scr_animname["slot_5"]["mi8_infil"] = "mp_infil_mi8_guyL_06";
  level.scr_eventanim["slot_5"]["mi8_infil"] = "infil_mi8_left_6";
  level.scr_animtree["slot_6"] = #animtree;
  level.scr_anim["slot_6"]["mi8_infil"] = % mp_infil_mi8_guyr_01;
  level.scr_animname["slot_6"]["mi8_infil"] = "mp_infil_mi8_guyR_01";
  level.scr_eventanim["slot_6"]["mi8_infil"] = "infil_mi8_right_1";
  level.scr_animtree["slot_7"] = #animtree;
  level.scr_anim["slot_7"]["mi8_infil"] = % mp_infil_mi8_guyr_02;
  level.scr_animname["slot_7"]["mi8_infil"] = "mp_infil_mi8_guyR_02";
  level.scr_eventanim["slot_7"]["mi8_infil"] = "infil_mi8_right_2";
  level.scr_animtree["slot_8"] = #animtree;
  level.scr_anim["slot_8"]["mi8_infil"] = % mp_infil_mi8_guyr_03;
  level.scr_animname["slot_8"]["mi8_infil"] = "mp_infil_mi8_guyR_03";
  level.scr_eventanim["slot_8"]["mi8_infil"] = "infil_mi8_right_3";
  level.scr_animtree["slot_9"] = #animtree;
  level.scr_anim["slot_9"]["mi8_infil"] = % mp_infil_mi8_guyr_04;
  level.scr_animname["slot_9"]["mi8_infil"] = "mp_infil_mi8_guyR_04";
  level.scr_eventanim["slot_9"]["mi8_infil"] = "infil_mi8_right_4";
  level.scr_animtree["slot_10"] = #animtree;
  level.scr_anim["slot_10"]["mi8_infil"] = % mp_infil_mi8_guyr_05;
  level.scr_animname["slot_10"]["mi8_infil"] = "mp_infil_mi8_guyR_05";
  level.scr_eventanim["slot_10"]["mi8_infil"] = "infil_mi8_right_5";
  level.scr_animtree["slot_11"] = #animtree;
  level.scr_anim["slot_11"]["mi8_infil"] = % mp_infil_mi8_guyr_06;
  level.scr_animname["slot_11"]["mi8_infil"] = "mp_infil_mi8_guyR_06";
  level.scr_eventanim["slot_11"]["mi8_infil"] = "infil_mi8_right_6";
}

function vehicles_alpha_anims(var_0, var_1, var_2) {
  var_3 = getDvar("mapname");

  if(isDefined(var_2) && var_0 != var_2 && (var_3 == "mp_downtown_gw" || var_3 == "mp_port2_gw")) {
    switch (var_2) {
      case "alpha1":
        if(var_1 == "axis") {
          if(var_3 == "mp_downtown_gw") {
            level.scr_anim["mi8"]["mi8_infil_" + var_2 + "_" + var_1] = % mp_infil_mi8_a1_heli_downtown_east;
          }

          if(var_3 == "mp_port2_gw") {
            level.scr_anim["mi8"]["mi8_infil_" + var_2 + "_" + var_1] = $mp_infil_mi8_a1_heli_port_east;
          }
        } else {
          if(var_3 == "mp_downtown_gw") {
            level.scr_anim["mi8"]["mi8_infil_" + var_2 + "_" + var_1] = % mp_infil_mi8_a1_heli_downtown_west;
          }

          if(var_3 == "mp_port2_gw") {
            level.scr_anim["mi8"]["mi8_infil_" + var_2 + "_" + var_1] = % mp_infil_mi8_a1_heli_port_west;
          }
        }

        break;
      case "alpha2":
        if(var_1 == "axis") {
          level.scr_anim["mi8"]["mi8_infil_" + var_2 + "_" + var_1] = % mp_infil_mi8_a2_heli_downtown_east;
        } else {
          level.scr_anim["mi8"]["mi8_infil_" + var_2 + "_" + var_1] = % mp_infil_mi8_a2_heli_downtown_west;
        }

        break;
    }

    return;
  }

  switch (var_0) {
    case "alpha":
      level.scr_animtree["mi8"] = #animtree;

      switch (getDvar("mapname")) {
        case "mp_downtown_gw":
          if(var_1 == "axis") {
            level.scr_anim["mi8"]["mi8_infil_" + var_0 + "_" + var_1] = % mp_infil_mi8_a_heli_downtown_east;
          } else {
            level.scr_anim["mi8"]["mi8_infil_" + var_0 + "_" + var_1] = % mp_infil_mi8_a_heli_downtown_west;
          }

          break;
        case "mp_farms2_gw":
        case "mp_quarry2":
          if(var_1 == "axis") {
            level.scr_anim["mi8"]["mi8_infil_" + var_0 + "_" + var_1] = % mp_infil_mi8_a_heli_quarry_east;
          } else {
            level.scr_anim["mi8"]["mi8_infil_" + var_0 + "_" + var_1] = % mp_infil_mi8_a_heli_quarry_east;
          }

          break;
        case "mp_port2_gw":
          if(var_1 == "axis") {
            level.scr_anim["mi8"]["mi8_infil_" + var_0 + "_" + var_1] = % mp_infil_mi8_a_heli_port_east;
          } else {
            level.scr_anim["mi8"]["mi8_infil_" + var_0 + "_" + var_1] = % mp_infil_mi8_a_heli_port_west;
          }

          break;
        case "mp_riverside_gw":
          if(var_1 == "axis") {
            level.scr_anim["mi8"]["mi8_infil_" + var_0 + "_" + var_1] = % mp_infil_mi8_a_heli_riverside_allegiance;
          } else {
            level.scr_anim["mi8"]["mi8_infil_" + var_0 + "_" + var_1] = % mp_infil_mi8_a_heli_riverside_coalition;
          }

          break;
        default:
          level.scr_anim["mi8"]["mi8_infil_" + var_0 + "_" + var_1] = % mp_infil_mi8_heli;
          break;
      }

      break;
    case "bravo":
      level.scr_animtree["mi8"] = #animtree;

      switch (getDvar("mapname")) {
        case "mp_farms2_gw":
        case "mp_quarry2":
          if(var_1 == "axis") {
            level.scr_anim["mi8"]["mi8_infil_" + var_0 + "_" + var_1] = % mp_infil_mi8_b_heli_quarry_east;
          } else {
            level.scr_anim["mi8"]["mi8_infil_" + var_0 + "_" + var_1] = % mp_infil_mi8_b_heli_quarry_east;
          }

          break;
        case "mp_port2_gw":
          if(var_1 == "axis") {
            level.scr_anim["mi8"]["mi8_infil_" + var_0 + "_" + var_1] = % mp_infil_mi8_b_heli_port_east;
          } else {
            level.scr_anim["mi8"]["mi8_infil_" + var_0 + "_" + var_1] = % mp_infil_mi8_b_heli_port_west;
          }

          break;
        case "mp_riverside_gw":
          if(var_1 == "axis") {
            level.scr_anim["mi8"]["mi8_infil_" + var_0 + "_" + var_1] = % mp_infil_mi8_b_heli_riverside_allegiance;
          } else {
            level.scr_anim["mi8"]["mi8_infil_" + var_0 + "_" + var_1] = % mp_infil_mi8_b_heli_riverside_coalition;
          }

          break;
        default:
          level.scr_anim["mi8"]["mi8_infil_" + var_0 + "_" + var_1] = % mp_infil_mi8_heli;
          break;
      }

      break;
    default:
      level.scr_anim["mi8"]["mi8_infil_" + var_0] = % mp_infil_mi8_heli;
      break;
  }
}

function spawninfilvehicle(var_0, var_1, var_2) {
  var_3 = var_0.origin;
  var_4 = var_0.angles;
  var_5 = "veh8_mil_air_mindia8_infil_x";

  if(var_1 == "allies") {
    var_5 = "veh8_mil_air_mindia8_west_infil_x";
  }

  var_6 = spawnVehicle(var_5, var_2, "mi8_infil_mp", var_3, var_4);
  var_6 setvehicleteam(var_1);
  var_6.animname = "mi8";
  var_6 setCanDamage(0);
  var_6 notsolid();
  var_6.infil = self;
  return var_6;
}

function commander_play_sound_func(var_0, var_1, var_2) {
  foreach(var_4 in self.infil.players) {
    self playsoundtoplayer(var_0, var_4);
  }
}

function driver_play_sound_func(var_0, var_1, var_2) {
  foreach(var_4 in self.infil.players) {
    self playsoundtoplayer(var_0, var_4);
  }
}

function getcommanderassets(var_0) {
  var_1 = spawnStruct();
  var_1.body = "body_mp_eastern_fireteam_east_sg_no_sling";
  var_1.head = "head_mp_eastern_fireteam_east_ar_4";
  return var_1;
}

function customground(var_0) {
  scripts\mp\utility\infilexfil::cam_shake_off(var_0);

  if(!isDefined(var_0)) {
    return;
  }

  if(isDefined(var_0.player)) {
    var_1 = var_0.player;
    return;
  }

  var_1 = var_1;
}

function ref_11c9e(var_0, var_1, var_2) {
  switch (level.mapname) {
    case "mp_quarry2":
      switch (var_1) {
        case "allies":
          switch (var_2) {
            case "alpha":
              break;
            case "bravo":
              var_0.origin += anglesToForward(var_0.angles) * 200;
              break;
          }

          break;
        case "axis":
          switch (var_2) {
            case "alpha":
              break;
            case "bravo":
              var_0.origin += anglestoup(var_0.angles) * 281.907;
              break;
          }

          break;
      }

      break;
  }
}