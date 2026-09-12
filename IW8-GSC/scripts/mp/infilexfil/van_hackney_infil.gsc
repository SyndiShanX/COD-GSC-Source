/*******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\infilexfil\van_hackney_infil.gsc
*******************************************************/

function van_hackney_init(var_0) {
  scripts\cp_mp\utility\script_utility::registersharedfunc("infil", "spawnPersistentVan", &spawnpersistentvehicle);
  initanims(var_0);
  var_1 = [];
  GscBinSkip0(0x2e, 0, [5, 4]);
}

function van_hackney_spawn(var_0, var_1, var_2, var_3) {
  var_4 = scripts\engine\utility::getStruct(var_1, "targetname");
  ref_12802(var_4, var_0, var_2, var_3);
  var_5 = spawn("script_origin", var_4.origin);
  var_5.angles = var_4.angles;
  var_5.scene_node = var_4;
  thread infilthink(var_5, var_0);
  return var_5;
}

function ref_12802(var_0, var_1, var_2, var_3) {
  var_4 = scripts\cp_mp\utility\game_utility::getmapname();

  switch (var_4) {
    case "mp_crash2":
      var_0.origin += anglesToForward(var_0.angles) * -50;
      var_5 = getentarrayinradius("script_brushmodel", "classname", (1250, -2150, 75), 300);

      if(isDefined(var_5)) {
        var_5[0].origin += anglesToForward(var_0.angles) * -50;
      }

      break;
  }
}

function van_hackney_get_length(var_0) {
  var_1 = 0;

  if(istrue(level.interactiveinfil)) {
    var_1 = level.interactivecombatduration;
  } else {
    var_1 = getanimlength(level.scr_anim["slot_0"]["van_hackney_infil_" + var_0]);
  }

  return var_1;
}

function player_van_hackney_infil_think(var_0, var_1) {
  self endon("player_free_spot");
  thread van_infil_radio_idle(var_0);
  thread player_infil_end();
  var_2 = var_0.linktoent gettagorigin("tag_origin");
  var_3 = var_0.linktoent gettagangles("tag_origin");
  thread scripts\mp\utility\infilexfil::infil_player_rig_updated("slot_" + var_1, var_2, var_3);
  self setdemeanorviewmodel("safe", "iw8_ges_demeanor_safe_van");
  self.player_rig.weapon_state_func = &scripts\mp\utility\infilexfil::handleweaponstatenotetrack;

  if(var_1 == 0) {
    self lerpfovbypreset("80_instant");
  }

  self.player_rig linkTo(var_0.linktoent, "tag_origin", (0, 0, 0), (0, 0, 0));
  var_0.linktoent scripts\common\anim::anim_first_frame_solo(self.player_rig, "van_hackney_infil_" + var_0.subtype);
  thread scripts\mp\infilexfil\infilexfil::infil_scene_fade_in(0, 0.55);
  thread player_van_disconnect();
  scripts\mp\flags::gameflagwait("infil_started");

  if(isDefined(self.team) && self.team != "spectator") {
    var_4 = [];
    GscBinSkip0(0x2e, var_4.size, "mp_infil_mix_musicheavy");
  }

  if(isPlayer(self)) {
    self setclienttriggeraudiozone("hackney_infil_van", 0.1);
    self playlocalsound("scn_mp_hackney_van_lr");
  }

  if(isDefined(self.animname) && isPlayer(self)) {
    var_8 = "scn_infil_hackney_van_plr1";

    if(isDefined(var_1.subtype)) {
      if(var_1.subtype == "alpha") {
        switch (self.animname) {
          case "slot_0":
            var_8 = "scn_infil_hackney_van_plr3";
            break;
          case "slot_1":
            var_8 = "scn_infil_hackney_van_plr2";
            break;
          case "slot_2":
            var_8 = "scn_infil_hackney_van_plr1";
            break;
          case "slot_3":
            var_8 = "scn_infil_hackney_van_plr6";
            break;
          case "slot_4":
            var_8 = "scn_infil_hackney_van_plr5";
            break;
          case "slot_5":
            var_8 = "scn_infil_hackney_van_plr4";
            break;
          default:
            var_8 = "scn_infil_hackney_van_plr3";
            break;
        }
      } else {
        switch (self.animname) {
          case "slot_0":
            var_8 = "scn_infil_hackney_van_plr3";
            break;
          case "slot_1":
            var_8 = "scn_infil_hackney_van_plr2";
            break;
          case "slot_2":
            var_8 = "scn_infil_hackney_van_plr1";
            break;
          case "slot_3":
            var_8 = "scn_infil_hackney_van_plr6";
            break;
          case "slot_4":
            var_8 = "scn_infil_hackney_van_plr5";
            break;
          case "slot_5":
            var_8 = "scn_infil_hackney_van_plr4";
            break;
          default:
            var_8 = "scn_infil_hackney_van_plr3";
            break;
        }
      }
    }

    self playlocalsound(var_8);
  }

  self setcinematicmotionoverride("disabled");
  self lerpviewangleclamp(1, 0.25, 0.25, 60, 60, 30, 30);
  var_1.linktoent scripts\mp\anim::anim_player_solo(self, self.player_rig, "van_hackney_infil_" + var_1.subtype, "tag_origin");
  thread clear_infil_ambient_zone();

  if(isDefined(self.player_rig) && self.player_rig islinked()) {
    self.player_rig unlink();
  }

  self visionsetnakedforplayer("", 0.75);
  self setdemeanorviewmodel("normal");
  self clearcinematicmotionoverride();
  self disablephysicaldepthoffieldscripting();
}

function clear_infil_ambient_zone() {
  self endon("death_or_disconnect");
  wait 1;
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

function van_infil_radio_idle(var_0) {
  if(isPlayer(self)) {
    self setclienttriggeraudiozone("hackney_infil_van_intro", 1);
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
    wait 4;
    var_3 stoploopsound(var_3);
    var_3 delete();
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

  var_3 = getcommanderassets(var_0);
  self.actors[self.actors.size] = spawn_anim_model(self.linktoent, "commander", "tag_origin", var_3.body, var_3.head);
  self.actors[self.actors.size] = spawn_anim_model(self.linktoent, "driver", "tag_origin", var_3.body, var_3.head);

  foreach(var_5 in self.actors) {
    var_5.infil = self;
  }

  self.actors[0].anim_playsound_func = &commander_play_sound_func;
  self.actors[1].anim_playsound_func = &driver_play_sound_func;

  if(var_0 == "allies") {
    self.actors[0] hidepart("j_sling_pivot");
    return;
  }
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
  thread actorthink(var_0, self.scene_node, var_1);
  scripts\mp\flags::gameflagwait("infil_started");
  var_6 = getEntArray("infil_opforce_gate", "targetname");

  foreach(var_4 in var_6) {
    var_4 hide();
  }

  setDvar("r_spotLightEntityShadows", 1);
  setDvar("r_mbVelocityScale", 1);
  level notify("start_scene");
  level waittill("prematch_over");

  foreach(var_4 in var_6) {
    var_4 show();
  }

  setDvar("r_spotLightEntityShadows", 0);
  setDvar("r_mbVelocityScale", var_2);
  var_11 = getEntArray("van_hackney_infil_alpha_probe", "targetname");
  var_12 = getEntArray("van_probe", "script_noteworthy");
  var_13 = getEntArray("van_probe_fallback", "script_noteworthy");
  var_14 = scripts\engine\utility::array_combine(var_11, var_12, var_13);

  if(isDefined(var_14) && var_14.size > 0) {
    foreach(var_16 in var_14) {
      var_16 hide();
    }
  }

  while(isDefined(self.actors)) {
    waitframe();
  }

  level.stop_station_closed_vo--;
  self delete();
}

function vehiclethink(var_0, var_1, var_2, var_3) {
  var_4 = spawnvan(var_1, var_0, var_2);
  scripts\common\anim::anim_first_frame_solo(var_4, "van_hackney_infil_" + var_2);
  scripts\mp\flags::gameflagwait("infil_started");
  var_5 = getEnt("palfa_clip", "targetname");

  if(isDefined(var_5)) {
    var_6 = spawn("script_model", var_4.origin);
    var_6.angles = var_4.angles;
    var_6 clonebrushmodeltoscriptmodel(var_5);
  }

  var_4 setscriptablepartstate("infil_lights", "on", 0);
  var_4 setscriptablepartstate("exhaust", "on", 0);
  thread van_interior_sfx(var_2);
  scripts\common\anim::anim_single_solo(var_4, "van_hackney_infil_" + var_2 + "_intro");
  scripts\common\anim::anim_single_solo(var_4, "van_hackney_infil_" + var_2);
  scripts\common\anim::anim_single_solo(var_4, "van_hackney_infil_" + var_2 + "_exit");
  var_4 setscriptablepartstate("infil_lights", "off", 0);
  var_4 setscriptablepartstate("exhaust", "off", 0);
  game["infil"]["types"][self.type][var_2]["persistentVehicle"] = &spawnpersistentvehicle;
  game["infil"]["types"][self.type][var_2]["vehicleOrg"] = self.linktoent.origin;
  game["infil"]["types"][self.type][var_2]["vehicleAng"] = self.linktoent.angles;
}

function spawnpersistentvehicle(var_0, var_1) {
  var_2 = game["infil"]["types"][var_0][var_1]["vehicleOrg"];
  var_3 = game["infil"]["types"][var_0][var_1]["vehicleAng"];
  var_4 = spawn("script_model", var_2);
  var_4.angles = var_3;
  var_5 = "veh8_civ_lnd_palfa_rhd_wet_infil";

  if(scripts\cp_mp\utility\game_utility::getmapname() == "mp_spear" || scripts\cp_mp\utility\game_utility::getmapname() == "mp_spear_pm" || scripts\cp_mp\utility\game_utility::getmapname() == "mp_crash2") {
    var_5 = "veh8_civ_lnd_palfa_rhd_infil";
  }

  var_4 setModel(var_5);
  var_4.animname = "van";
  var_4 scripts\common\anim::setanimtree();
  var_6 = getEnt("palfa_clip", "targetname");

  if(isDefined(var_6)) {
    var_7 = spawn("script_model", var_2);
    var_7.angles = var_3;
    var_7 clonebrushmodeltoscriptmodel(var_6);
    return;
  }
}

function van_interior_sfx(var_0) {
  var_1 = spawn("script_model", self.linktoent.origin);
  var_1 linkTo(self.linktoent, "tag_door_back_left");
  var_2 = spawn("script_model", self.linktoent.origin);
  var_2 linkTo(self.linktoent, "tag_hood");
  wait 0.1;
  var_1 playsoundonmovingent("scn_infil_hackney_van_int_rear");
  var_2 playsoundonmovingent("scn_infil_hackney_van_int_front");
  wait 7.75;
  var_1 playsoundonmovingent("scn_infil_hackney_van_door_open");
  wait 8;
  var_1 playsoundonmovingent("scn_infil_hackney_van_door_close");
  level waittill("prematch_over");
  var_2 delete();
  var_1 delete();
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

function ref_140e5(var_0) {
  var_0 playsoundonmovingent("scn_infil_hackney_van_commander");
}

function actorthink(var_0, var_1, var_2, var_3) {
  thread spawnactors(var_0, var_2, var_3);
  self.linktoent scripts\common\anim::anim_first_frame(self.actors, "van_hackney_infil_" + var_2, "tag_origin");
  scripts\mp\flags::gameflagwait("infil_started");
  self.linktoent thread scripts\common\anim::anim_single(self.actors, "van_hackney_infil_" + var_2, "tag_origin");
  self.actors[0].head scriptmodelplayanim(level.scr_anim[self.actors[0].animname]["van_hackney_infil_" + var_2]);
  var_4 = getanimlength(level.scr_anim["commander"]["van_hackney_infil_" + var_2]);
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

function initanims(var_0) {
  script_model_alpha_anims();
  vehicles_alpha_anims();
  scripts\common\anim::addnotetrack_customfunction("slot_0", "fov_63_2", &scripts\mp\utility\infilexfil::player_fov_default_2);
  scripts\common\anim::addnotetrack_customfunction("slot_0", "shake_running", &scripts\mp\utility\infilexfil::cam_shake_running, "van_hackney_infil_alpha");
  scripts\common\anim::addnotetrack_customfunction("slot_1", "shake_running", &scripts\mp\utility\infilexfil::cam_shake_running, "van_hackney_infil_alpha");
  scripts\common\anim::addnotetrack_customfunction("slot_2", "shake_running", &scripts\mp\utility\infilexfil::cam_shake_running, "van_hackney_infil_alpha");
  scripts\common\anim::addnotetrack_customfunction("slot_3", "shake_running", &scripts\mp\utility\infilexfil::cam_shake_running, "van_hackney_infil_alpha");
  scripts\common\anim::addnotetrack_customfunction("slot_4", "shake_running", &scripts\mp\utility\infilexfil::cam_shake_running, "van_hackney_infil_alpha");
  scripts\common\anim::addnotetrack_customfunction("slot_5", "shake_running", &scripts\mp\utility\infilexfil::cam_shake_running, "van_hackney_infil_alpha");
  scripts\common\anim::addnotetrack_customfunction("slot_0", "equip_nvg", &scripts\mp\utility\infilexfil::player_equip_nvg, "van_hackney_infil_alpha");
  scripts\common\anim::addnotetrack_customfunction("slot_1", "equip_nvg", &scripts\mp\utility\infilexfil::player_equip_nvg, "van_hackney_infil_alpha");
  scripts\common\anim::addnotetrack_customfunction("slot_2", "equip_nvg", &scripts\mp\utility\infilexfil::player_equip_nvg, "van_hackney_infil_alpha");
  scripts\common\anim::addnotetrack_customfunction("slot_3", "equip_nvg", &scripts\mp\utility\infilexfil::player_equip_nvg, "van_hackney_infil_alpha");
  scripts\common\anim::addnotetrack_customfunction("slot_4", "equip_nvg", &scripts\mp\utility\infilexfil::player_equip_nvg, "van_hackney_infil_alpha");
  scripts\common\anim::addnotetrack_customfunction("slot_5", "equip_nvg", &scripts\mp\utility\infilexfil::player_equip_nvg, "van_hackney_infil_alpha");
  scripts\common\anim::addnotetrack_customfunction("slot_0", "shake_parked", &scripts\mp\utility\infilexfil::cam_shake_parked, "van_hackney_infil_alpha");
  scripts\common\anim::addnotetrack_customfunction("slot_1", "shake_parked", &scripts\mp\utility\infilexfil::cam_shake_parked, "van_hackney_infil_alpha");
  scripts\common\anim::addnotetrack_customfunction("slot_2", "shake_parked", &scripts\mp\utility\infilexfil::cam_shake_parked, "van_hackney_infil_alpha");
  scripts\common\anim::addnotetrack_customfunction("slot_3", "shake_parked", &scripts\mp\utility\infilexfil::cam_shake_parked, "van_hackney_infil_alpha");
  scripts\common\anim::addnotetrack_customfunction("slot_4", "shake_parked", &scripts\mp\utility\infilexfil::cam_shake_parked, "van_hackney_infil_alpha");
  scripts\common\anim::addnotetrack_customfunction("slot_5", "shake_parked", &scripts\mp\utility\infilexfil::cam_shake_parked, "van_hackney_infil_alpha");
  scripts\common\anim::addnotetrack_customfunction("slot_0", "shake_off", &customground, "van_hackney_infil_alpha");
  scripts\common\anim::addnotetrack_customfunction("slot_1", "shake_off", &customground, "van_hackney_infil_alpha");
  scripts\common\anim::addnotetrack_customfunction("slot_2", "shake_off", &customground, "van_hackney_infil_alpha");
  scripts\common\anim::addnotetrack_customfunction("slot_3", "shake_off", &customground, "van_hackney_infil_alpha");
  scripts\common\anim::addnotetrack_customfunction("slot_4", "shake_off", &customground, "van_hackney_infil_alpha");
  scripts\common\anim::addnotetrack_customfunction("slot_5", "shake_off", &customground, "van_hackney_infil_alpha");
  scripts\common\anim::addnotetrack_customfunction("slot_0", "free_look", &scripts\mp\utility\infilexfil::player_free_look, "van_hackney_infil_alpha");
  scripts\common\anim::addnotetrack_customfunction("slot_1", "free_look", &scripts\mp\utility\infilexfil::player_free_look, "van_hackney_infil_alpha");
  scripts\common\anim::addnotetrack_customfunction("slot_2", "free_look", &scripts\mp\utility\infilexfil::player_free_look, "van_hackney_infil_alpha");
  scripts\common\anim::addnotetrack_customfunction("slot_3", "free_look", &scripts\mp\utility\infilexfil::player_free_look, "van_hackney_infil_alpha");
  scripts\common\anim::addnotetrack_customfunction("slot_4", "free_look", &scripts\mp\utility\infilexfil::player_free_look, "van_hackney_infil_alpha");
  scripts\common\anim::addnotetrack_customfunction("slot_5", "free_look", &scripts\mp\utility\infilexfil::player_free_look, "van_hackney_infil_alpha");
  scripts\common\anim::addnotetrack_customfunction("slot_0", "van_infil_sfx_npc1", &van_infil_sfx_npc1);
  scripts\common\anim::addnotetrack_customfunction("slot_1", "van_infil_sfx_npc2", &van_infil_sfx_npc2);
  scripts\common\anim::addnotetrack_customfunction("slot_2", "van_infil_sfx_npc3", &van_infil_sfx_npc3);
  scripts\common\anim::addnotetrack_customfunction("slot_3", "van_infil_sfx_npc4", &van_infil_sfx_npc4);
  scripts\common\anim::addnotetrack_customfunction("slot_4", "van_infil_sfx_npc5", &van_infil_sfx_npc5);
  scripts\common\anim::addnotetrack_customfunction("slot_5", "van_infil_sfx_npc6", &van_infil_sfx_npc6);
  scripts\common\anim::addnotetrack_customfunction("slot_0", "player_lock_look_1_second", &scripts\mp\utility\infilexfil::player_lock_look_1_second, "van_hackney_infil_alpha");
  scripts\common\anim::addnotetrack_customfunction("slot_1", "player_lock_look_1_second", &scripts\mp\utility\infilexfil::player_lock_look_1_second, "van_hackney_infil_alpha");
  scripts\common\anim::addnotetrack_customfunction("slot_2", "player_lock_look_1_second", &scripts\mp\utility\infilexfil::player_lock_look_1_second, "van_hackney_infil_alpha");
  scripts\common\anim::addnotetrack_customfunction("slot_3", "player_lock_look_1_second", &scripts\mp\utility\infilexfil::player_lock_look_1_second, "van_hackney_infil_alpha");
  scripts\common\anim::addnotetrack_customfunction("slot_4", "player_lock_look_1_second", &scripts\mp\utility\infilexfil::player_lock_look_1_second, "van_hackney_infil_alpha");
  scripts\common\anim::addnotetrack_customfunction("slot_5", "player_lock_look_1_second", &scripts\mp\utility\infilexfil::player_lock_look_1_second, "van_hackney_infil_alpha");
}

#using_animtree("");

function script_model_alpha_anims() {
  level.scr_animtree["driver"] = #animtree;
  level.scr_anim["driver"]["van_hackney_infil_alpha"] = $infil_opforce_van_driver;
  level.scr_animname["driver"]["van_hackney_infil_alpha"] = "infil_opforce_van_driver";
  level.scr_animtree["commander"] = #animtree;
  level.scr_anim["commander"]["van_hackney_infil_alpha"] = % infil_opforce_van_chief;
  level.scr_animname["commander"]["van_hackney_infil_alpha"] = "infil_opforce_van_chief";
  scripts\common\anim::addnotetrack_customfunction("commander", "sfx_infil_hackney_van_commander", &ref_140e5);
  level.scr_animtree["van"] = #animtree;

  switch (getDvar("mapname")) {
    case "mp_spear":
      level.scr_anim["van"]["van_hackney_infil_alpha_intro"] = % mp_infil_van_veh_intro_spear;
      level.scr_animname["van"]["van_hackney_infil_alpha_intro"] = "mp_infil_van_veh_intro_spear";
      break;
    case "mp_crash2":
      level.scr_anim["van"]["van_hackney_infil_alpha_intro"] = % infil_opforce_van_hackney_enter_van_mpcrash;
      level.scr_animname["van"]["van_hackney_infil_alpha_intro"] = "infil_opforce_van_hackney_enter_van_mpcrash";
      break;
    default:
      level.scr_anim["van"]["van_hackney_infil_alpha_intro"] = % infil_opforce_van_hackney_enter_van;
      level.scr_animname["van"]["van_hackney_infil_alpha_intro"] = "infil_opforce_van_hackney_enter_van";
      break;
  }

  level.scr_anim["van"]["van_hackney_infil_alpha"] = % infil_opforce_van_van;
  level.scr_animname["van"]["van_hackney_infil_alpha"] = "infil_opforce_van_van";
  level.scr_anim["van"]["van_hackney_infil_alpha_exit"] = % infil_opforce_van_hackney_exit_van;
  level.scr_animname["van"]["van_hackney_infil_alpha_exit"] = "infil_opforce_van_hackney_exit_van";
  level.scr_animtree["slot_0"] = #animtree;
  level.scr_anim["slot_0"]["van_hackney_infil_alpha"] = % infil_opforce_van_1;
  level.scr_animname["slot_0"]["van_hackney_infil_alpha"] = "infil_opforce_van_1";
  level.scr_eventanim["slot_0"]["van_hackney_infil_alpha"] = "infil_van_hackney_alpha_1";
  level.scr_animtree["slot_1"] = #animtree;
  level.scr_anim["slot_1"]["van_hackney_infil_alpha"] = % infil_opforce_van_2;
  level.scr_animname["slot_1"]["van_hackney_infil_alpha"] = "infil_opforce_van_2";
  level.scr_eventanim["slot_1"]["van_hackney_infil_alpha"] = "infil_van_hackney_alpha_2";
  level.scr_animtree["slot_2"] = #animtree;
  level.scr_anim["slot_2"]["van_hackney_infil_alpha"] = % infil_opforce_van_3;
  level.scr_animname["slot_2"]["van_hackney_infil_alpha"] = "infil_opforce_van_3";
  level.scr_eventanim["slot_2"]["van_hackney_infil_alpha"] = "infil_van_hackney_alpha_3";
  level.scr_animtree["slot_3"] = #animtree;
  level.scr_anim["slot_3"]["van_hackney_infil_alpha"] = % infil_opforce_van_4;
  level.scr_animname["slot_3"]["van_hackney_infil_alpha"] = "infil_opforce_van_4";
  level.scr_eventanim["slot_3"]["van_hackney_infil_alpha"] = "infil_van_hackney_alpha_4";
  level.scr_animtree["slot_4"] = #animtree;
  level.scr_anim["slot_4"]["van_hackney_infil_alpha"] = % infil_opforce_van_5;
  level.scr_animname["slot_4"]["van_hackney_infil_alpha"] = "infil_opforce_van_5";
  level.scr_eventanim["slot_4"]["van_hackney_infil_alpha"] = "infil_van_hackney_alpha_5";
  level.scr_animtree["slot_5"] = #animtree;
  level.scr_anim["slot_5"]["van_hackney_infil_alpha"] = % infil_opforce_van_6;
  level.scr_animname["slot_5"]["van_hackney_infil_alpha"] = "infil_opforce_van_6";
  level.scr_eventanim["slot_5"]["van_hackney_infil_alpha"] = "infil_van_hackney_alpha_6";
}

function vehicles_alpha_anims() {}

function spawnvan(var_0, var_1, var_2) {
  var_3 = spawn("script_model", var_0.origin);
  var_3.angles = var_0.angles;
  var_4 = "veh8_civ_lnd_palfa_rhd_wet_infil";

  if(scripts\cp_mp\utility\game_utility::getmapname() == "mp_spear" || scripts\cp_mp\utility\game_utility::getmapname() == "mp_spear_pm") {
    var_4 = "veh8_civ_lnd_palfa_rhd_infil";
  }

  var_3 setModel(var_4);
  var_3.animname = "van";
  var_3 scripts\common\anim::setanimtree();
  var_3 setCanDamage(0);
  self.linktoent = var_3;
  var_3.infil = self;
  var_5 = getEntArray("van_hackney_infil_alpha_probe", "targetname");
  var_6 = getEntArray("van_probe", "script_noteworthy");
  var_7 = getEntArray("van_probe_fallback", "script_noteworthy");
  var_8 = scripts\engine\utility::array_combine(var_5, var_6, var_7);
  var_9 = undefined;

  foreach(var_11 in var_8) {
    if(isDefined(var_11.ref_140e3)) {
      continue;
    }

    var_9 = var_11;
    break;
  }

  if(isDefined(var_9)) {
    var_3.probe = var_9;
    var_9.ref_140e3 = var_3;
    var_3.probe.origin = var_3.origin;
    var_3.probe linkTo(var_3, "tag_origin", (-42, 0, 56.5), (0, 0, 0));

    switch (level.mapname) {
      case "mp_spear":
      case "mp_piccadilly":
      case "mp_hackney_am":
      case "mp_crash2":
      case "mp_spear_pm":
      case "mp_hackney_yard":
        var_3.probe hide();
        break;
    }
  }

  return var_3;
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

  if(var_0 == "axis") {
    var_1.body = "body_mp_eastern_fireteam_east_sg_no_sling";
    var_1.head = "head_mp_eastern_fireteam_east_ar_4";
  } else {
    var_1.body = "body_mp_western_fireteam_west_smg_1_1";
    var_1.head = "head_mp_western_fireteam_west_smg_2_1";
  }

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