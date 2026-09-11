/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\infilexfil\mi8_infil.gsc
***********************************************/

function mi8_init(var0) {
  var1 = [];
  GscBinSkip0(0x2e, 0, [11, 10]);
}

function mi8_spawn(var0, var1, var2, var3) {
  var4 = scripts\engine\utility::getStruct(var1, "targetname");
  var5 = scripts\cp_mp\utility\game_utility::getmapname();

  if(var5 == "mp_riverside_gw") {
    if(var0 == "allies") {
      if(distance2dsquared(var4.origin, (-8540.17, 31520.1, -487.5)) < 100) {
        var2 = "bravo";
        var3 = "bravo";
      }
    } else if(distance2dsquared(var4.origin, (7145.82, 23997.2, -34)) < 100) {
      var2 = "bravo";
      var3 = "bravo";
    }
  }

  initanims(var2, var0, var3);
  ref_12802(var4, var0, var2, var3);
  var6 = spawn("script_origin", var4.origin);
  var6.angles = var4.angles;
  var6.scene_node = var4;
  var6.subtype = var2;
  var6.ref_1214c = var3;
  thread infilthink(var6, var0);
  return var6;
}

function ref_12896(var0, var1, var2) {
  var3 = var0.scene_node.origin;
  var4 = var0.scene_node.angles;

  for(;;) {
    thread scripts\cp_mp\utility\debug_utility::drawangles(var3, var4, level.framedurationseconds, 1);
    waitframe();
  }
}

function ref_12802(var0, var1, var2, var3) {
  var4 = scripts\cp_mp\utility\game_utility::getmapname();

  switch (var4) {
    case "mp_downtown_gw":
      switch (var3) {
        case "alpha":
          if(var1 == "axis") {
            var0.angles += (0, 8, 0);
          } else {
            var0.angles += (0, 23, 0);
            var0.origin += anglesToForward(var0.angles) * 100;
          }

          break;
        case "alpha1":
          if(var1 == "axis") {
            var0.angles += (0, -8, 0);
          } else {
            var0.angles += (0, -3, 0);
          }

          break;
        case "alpha2":
          if(var1 == "axis") {
            var0.angles += (0, -3, 0);
            var0.origin += anglesToForward(var0.angles) * 200;
          } else {
            var0.angles += (0, 12, 0);
          }

          break;
      }

      break;
    case "mp_farms2_gw":
      switch (var3) {
        case "bravo":
          if(var1 == "allies") {
            var0.origin -= (0, 0, 86);
          }

          break;
      }
    case "mp_promenade_gw":
      switch (var3) {
        case "alpha":
          if(var1 == "allies") {
            var0.angles -= (0, 30, 0);
          }

          break;
      }

      break;
  }
}

function mi8_get_length(var0) {
  var1 = getanimlength(level.scr_anim["slot_0"]["mi8_infil"]);
  return var1;
}

function player_mi8_infil_think(var0, var1) {
  self endon("player_free_spot");
  thread infil_radio_idle(var0);
  thread player_infil_end();
  var2 = var0.origin;
  var3 = var0.angles;
  thread scripts\mp\utility\infilexfil::infil_player_rig_updated("slot_" + var1, var2, var3);
  self setdemeanorviewmodel("safe", "iw8_ges_demeanor_safe_heli");
  self lerpfovbypreset("80_instant");
  self lerpfovscalefactor(0, 0);
  self.player_rig linkTo(var0);
  var0 scripts\common\anim::anim_first_frame_solo(self.player_rig, "mi8_infil");
  thread scripts\mp\infilexfil\infilexfil::infil_scene_fade_in(0, 0.55);
  thread player_disconnect();
  scripts\mp\flags::gameflagwait("infil_started");

  if(isDefined(self.team) && self.team != "spectator") {
    var4 = [];
    GscBinSkip0(0x2e, var4.size, "mp_infil_mix_normal");
  }

  if(isDefined(self.animname) && !isai(self)) {
    var8 = "scn_infil_mindia_plr_1";

    switch (self.animname) {
      case "slot_0":
        var8 = "scn_infil_mindia_plr_1";
        break;
      case "slot_1":
        var8 = "scn_infil_mindia_plr_2";
        break;
      case "slot_2":
        var8 = "scn_infil_mindia_plr_3";
        break;
      case "slot_3":
        var8 = "scn_infil_mindia_plr_4";
        break;
      case "slot_4":
        var8 = "scn_infil_mindia_plr_5";
        break;
      case "slot_5":
        var8 = "scn_infil_mindia_plr_6";
        break;
      case "slot_6":
        var8 = "scn_infil_mindia_plr_1";
        break;
      case "slot_7":
        var8 = "scn_infil_mindia_plr_2";
        break;
      case "slot_8":
        var8 = "scn_infil_mindia_plr_3";
        break;
      case "slot_9":
        var8 = "scn_infil_mindia_plr_4";
        break;
      case "slot_10":
        var8 = "scn_infil_mindia_plr_5";
        break;
      case "slot_11":
        var8 = "scn_infil_mindia_plr_6";
        break;
      default:
        var8 = "scn_infil_mindia_plr_1";
        break;
    }

    self playlocalsound(var8);
    self playlocalsound("scn_infil_mindia_heli_int_lr");
  }

  self setcinematicmotionoverride("disabled");
  self lerpviewangleclamp(1, 0.25, 0.25, 60, 60, 30, 30);
  thread clear_infil_ambient_zone();
  var1 scripts\mp\anim::anim_player_solo(self, self.player_rig, "mi8_infil");

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

function infil_radio_idle(var0) {
  if(isPlayer(self)) {
    self setclienttriggeraudiozonepartialwithfade("mindia_preinfil_mix", 0.05, "mix");
    wait 0.5;

    if(!isDefined(self)) {
      return;
    }

    self playlocalsound("scn_infil_mindia_heli_prestart");
    var1 = spawn("script_origin", (0, 0, 0));
    var1 showonlytoplayer(self);

    if(isDefined(self.team)) {
      var2 = scripts\mp\utility\teams::getteamvoiceinfix(self.team);
      var3 = "dx_mpo_" + var2 + "op_drone_deathchatter";
    } else {
      var3 = "dx_mpo_usop_drone_deathchatter";
    }

    if(soundexists(var3)) {
      var3 playLoopSound(var3);
    } else {
      var3 playLoopSound("dx_mpo_usop_drone_deathchatter");
    }

    scripts\mp\flags::gameflagwait("infil_started");
    wait 1;

    if(isDefined(self)) {
      self stoplocalsound("scn_infil_mindia_heli_prestart");
    }

    wait 1;
    var3 stoploopsound(var3);
    var3 delete();
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

function spawnactors(var0, var1, var2) {
  if(!isDefined(self.actors)) {
    self.actors = [];
  }

  var3 = getcommanderassets(var0);
  self.actors[self.actors.size] = spawn_anim_model(self.linktoent, "commander", "tag_origin", var3.body, var3.head);
  self.actors[self.actors.size] = spawn_anim_model(self.linktoent, "driver", "tag_origin", var3.body, var3.head);

  foreach(var5 in self.actors) {
    var5.infil = self;
  }

  self.actors[0].anim_playsound_func = &commander_play_sound_func;
  self.actors[1].anim_playsound_func = &driver_play_sound_func;
}

function blima_chief_play_sound_func(var0, var1, var2) {
  foreach(var4 in self.blima.players) {
    var4 playsoundtoplayer(var0, var4);
  }
}

function infilthink(var0, var1) {
  var2 = getdvarfloat("NMORQOTSK", 0.2);

  foreach(var4 in getEntArray("infil_delete", "script_noteworthy")) {
    var4 delete();
  }

  thread vehiclethink(var0, self.scene_node, var1);
  scripts\mp\flags::gameflagwait("infil_started");
  setDvar("TLMMOPMSK", 1);
  setDvar("NMORQOTSK", 1);
  level notify("start_scene");
  level waittill("prematch_over");
  setDvar("TLMMOPMSK", 0);
  setDvar("NMORQOTSK", var2);

  while(isDefined(self.linktoent) || isDefined(self.actors)) {
    waitframe();
  }

  level.stop_station_closed_vo--;
  self delete();
}

function vehiclethink(var0, var1, var2, var3) {
  self.linktoent = spawninfilvehicle(var1, var0, var2);

  if(self.ref_1214c != self.subtype && (getDvar("mapname") == "mp_downtown_gw" || getDvar("mapname") == "mp_port2_gw")) {
    var2 = self.ref_1214c;
  }

  scripts\common\anim::anim_first_frame_solo(self.linktoent, "mi8_infil_" + var2 + "_" + var0);
  scripts\mp\flags::gameflagwait("infil_started");
  self.linktoent setscriptablepartstate("engine", "on", 0);
  self.linktoent setscriptablepartstate("blinking_light", "red", 0);
  self.linktoent setscriptablepartstate("infil_lights", "on", 0);
  thread ref_11bf2();
  thread scripts\common\anim::anim_single_solo(self.linktoent, "mi8_infil_" + var2 + "_" + var0);
  var4 = getanimlength(level.scr_anim["mi8"]["mi8_infil_" + var2 + "_" + var0]);
  wait var4;
  self.linktoent delete();
  self.linktoent = undefined;
}

function ref_11bf2() {
  self playsoundonmovingent("scn_infil_mindia_heli_ext");
}

function van_infil_sfx_npc1(var0) {
  var0 playsoundonmovingent("scn_infil_hackney_van_npc3");
}

function van_infil_sfx_npc2(var0) {
  var0 playsoundonmovingent("scn_infil_hackney_van_npc2");
}

function van_infil_sfx_npc3(var0) {
  var0 playsoundonmovingent("scn_infil_hackney_van_npc1");
}

function van_infil_sfx_npc4(var0) {
  var0 playsoundonmovingent("scn_infil_hackney_van_npc6");
}

function van_infil_sfx_npc5(var0) {
  var0 playsoundonmovingent("scn_infil_hackney_van_npc5");
}

function van_infil_sfx_npc6(var0) {
  var0 playsoundonmovingent("scn_infil_hackney_van_npc4");
}

function actorthink(var0, var1, var2, var3) {
  thread spawnactors(var0, var2, var3);
  self.linktoent scripts\common\anim::anim_first_frame(self.actors, "mi8_infil_" + var2, "tag_origin");
  scripts\mp\flags::gameflagwait("infil_started");
  self.linktoent thread scripts\common\anim::anim_single(self.actors, "mi8_infil_" + var2, "tag_origin");
  self.actors[0].head scriptmodelplayanim(level.scr_anim[self.actors[0].animname]["mi8_infil_" + var2]);
  var4 = getanimlength(level.scr_anim["commander"]["mi8_infil_" + var2]);
  wait var4;

  foreach(var6 in self.actors) {
    var6 delete();
  }

  self.actors = undefined;
}

function spawn_anim_model(var0, var1, var2, var3, var4) {
  var5 = 1;

  if(scripts\engine\utility::cointoss()) {
    var5 = 0;
  }

  if(var2 == "random") {
    if(var5) {
      var6 = randomint(3);

      if(var6 == 0) {
        var2 = "c_civ_pic_male_2_brown";
      } else if(var6 == 1) {
        var2 = "body_opforce_london_civ_1_1";
      } else if(var6 == 2) {
        var2 = "civ_london_male_2_5";
      }
    } else if(scripts\engine\utility::cointoss()) {
      var2 = "civ_london_female_1_4";
    } else {
      var2 = "c_civ_pic_female_5_6";
    }
  }

  var7 = spawn("script_model", (0, 0, 0));
  var7 setModel(var2);

  if(isDefined(var3)) {
    if(var3 == "random") {
      if(var5) {
        if(scripts\engine\utility::cointoss()) {
          var3 = "head_bg_var_head_bg_male_09_head_sc_male_14";
        } else {
          var3 = "head_bg_var_head_male_bc_01_head_hero_gator";
        }
      } else if(scripts\engine\utility::cointoss()) {
        var3 = "head_bg_var_head_female_bc_01_head_sc_female_10";
      } else {
        var3 = "head_bg_var_head_sc_female_04_head_female_bc_02";
      }
    }

    var8 = spawn("script_model", (0, 0, 0));
    var8 setModel(var3);
    var8 linkTo(var7, "j_spine4", (0, 0, 0), (0, 0, 0));
    var7.head = var8;
    var7 thread scripts\engine\utility::delete_on_death(var8);
  }

  if(isDefined(var4)) {
    var9 = spawn("script_model", (0, 0, 0));
    var9 setModel(var4);
    var9 linkTo(var7, "j_gun", (0, 0, 0), (0, 0, 0));
    var7 thread scripts\engine\utility::delete_on_death(var9);
    var7.weapon = var9;
  }

  var7.animname = var0;
  var7 scripts\common\anim::setanimtree();

  if(isDefined(var1)) {
    thread scripts\engine\utility::delete_on_death(var7);
    var7 linkTo(self, var1, (0, 0, 0), (0, 0, 0));
  }

  return var7;
}

function initanims(var0, var1, var2) {
  script_model_alpha_anims(var0);
  vehicles_alpha_anims(var0, var1, var2);
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

function script_model_alpha_anims(var0) {
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

function vehicles_alpha_anims(var0, var1, var2) {
  var3 = getDvar("mapname");

  if(isDefined(var2) && var0 != var2 && (var3 == "mp_downtown_gw" || var3 == "mp_port2_gw")) {
    switch (var2) {
      case "alpha1":
        if(var1 == "axis") {
          if(var3 == "mp_downtown_gw") {
            level.scr_anim["mi8"]["mi8_infil_" + var2 + "_" + var1] = % mp_infil_mi8_a1_heli_downtown_east;
          }

          if(var3 == "mp_port2_gw") {
            level.scr_anim["mi8"]["mi8_infil_" + var2 + "_" + var1] = $mp_infil_mi8_a1_heli_port_east;
          }
        } else {
          if(var3 == "mp_downtown_gw") {
            level.scr_anim["mi8"]["mi8_infil_" + var2 + "_" + var1] = % mp_infil_mi8_a1_heli_downtown_west;
          }

          if(var3 == "mp_port2_gw") {
            level.scr_anim["mi8"]["mi8_infil_" + var2 + "_" + var1] = % mp_infil_mi8_a1_heli_port_west;
          }
        }

        break;
      case "alpha2":
        if(var1 == "axis") {
          level.scr_anim["mi8"]["mi8_infil_" + var2 + "_" + var1] = % mp_infil_mi8_a2_heli_downtown_east;
        } else {
          level.scr_anim["mi8"]["mi8_infil_" + var2 + "_" + var1] = % mp_infil_mi8_a2_heli_downtown_west;
        }

        break;
    }

    return;
  }

  switch (var0) {
    case "alpha":
      level.scr_animtree["mi8"] = #animtree;

      switch (getDvar("mapname")) {
        case "mp_downtown_gw":
          if(var1 == "axis") {
            level.scr_anim["mi8"]["mi8_infil_" + var0 + "_" + var1] = % mp_infil_mi8_a_heli_downtown_east;
          } else {
            level.scr_anim["mi8"]["mi8_infil_" + var0 + "_" + var1] = % mp_infil_mi8_a_heli_downtown_west;
          }

          break;
        case "mp_farms2_gw":
        case "mp_quarry2":
          if(var1 == "axis") {
            level.scr_anim["mi8"]["mi8_infil_" + var0 + "_" + var1] = % mp_infil_mi8_a_heli_quarry_east;
          } else {
            level.scr_anim["mi8"]["mi8_infil_" + var0 + "_" + var1] = % mp_infil_mi8_a_heli_quarry_east;
          }

          break;
        case "mp_port2_gw":
          if(var1 == "axis") {
            level.scr_anim["mi8"]["mi8_infil_" + var0 + "_" + var1] = % mp_infil_mi8_a_heli_port_east;
          } else {
            level.scr_anim["mi8"]["mi8_infil_" + var0 + "_" + var1] = % mp_infil_mi8_a_heli_port_west;
          }

          break;
        case "mp_riverside_gw":
          if(var1 == "axis") {
            level.scr_anim["mi8"]["mi8_infil_" + var0 + "_" + var1] = % mp_infil_mi8_a_heli_riverside_allegiance;
          } else {
            level.scr_anim["mi8"]["mi8_infil_" + var0 + "_" + var1] = % mp_infil_mi8_a_heli_riverside_coalition;
          }

          break;
        default:
          level.scr_anim["mi8"]["mi8_infil_" + var0 + "_" + var1] = % mp_infil_mi8_heli;
          break;
      }

      break;
    case "bravo":
      level.scr_animtree["mi8"] = #animtree;

      switch (getDvar("mapname")) {
        case "mp_farms2_gw":
        case "mp_quarry2":
          if(var1 == "axis") {
            level.scr_anim["mi8"]["mi8_infil_" + var0 + "_" + var1] = % mp_infil_mi8_b_heli_quarry_east;
          } else {
            level.scr_anim["mi8"]["mi8_infil_" + var0 + "_" + var1] = % mp_infil_mi8_b_heli_quarry_east;
          }

          break;
        case "mp_port2_gw":
          if(var1 == "axis") {
            level.scr_anim["mi8"]["mi8_infil_" + var0 + "_" + var1] = % mp_infil_mi8_b_heli_port_east;
          } else {
            level.scr_anim["mi8"]["mi8_infil_" + var0 + "_" + var1] = % mp_infil_mi8_b_heli_port_west;
          }

          break;
        case "mp_riverside_gw":
          if(var1 == "axis") {
            level.scr_anim["mi8"]["mi8_infil_" + var0 + "_" + var1] = % mp_infil_mi8_b_heli_riverside_allegiance;
          } else {
            level.scr_anim["mi8"]["mi8_infil_" + var0 + "_" + var1] = % mp_infil_mi8_b_heli_riverside_coalition;
          }

          break;
        default:
          level.scr_anim["mi8"]["mi8_infil_" + var0 + "_" + var1] = % mp_infil_mi8_heli;
          break;
      }

      break;
    default:
      level.scr_anim["mi8"]["mi8_infil_" + var0] = % mp_infil_mi8_heli;
      break;
  }
}

function spawninfilvehicle(var0, var1, var2) {
  var3 = var0.origin;
  var4 = var0.angles;
  var5 = "veh8_mil_air_mindia8_infil_x";

  if(var1 == "allies") {
    var5 = "veh8_mil_air_mindia8_west_infil_x";
  }

  var6 = spawnVehicle(var5, var2, "mi8_infil_mp", var3, var4);
  var6 setvehicleteam(var1);
  var6.animname = "mi8";
  var6 setCanDamage(0);
  var6 notsolid();
  var6.infil = self;
  return var6;
}

function commander_play_sound_func(var0, var1, var2) {
  foreach(var4 in self.infil.players) {
    self playsoundtoplayer(var0, var4);
  }
}

function driver_play_sound_func(var0, var1, var2) {
  foreach(var4 in self.infil.players) {
    self playsoundtoplayer(var0, var4);
  }
}

function getcommanderassets(var0) {
  var1 = spawnStruct();
  var1.body = "body_mp_eastern_fireteam_east_sg_no_sling";
  var1.head = "head_mp_eastern_fireteam_east_ar_4";
  return var1;
}

function customground(var0) {
  scripts\mp\utility\infilexfil::cam_shake_off(var0);

  if(!isDefined(var0)) {
    return;
  }

  if(isDefined(var0.player)) {
    var1 = var0.player;
    return;
  }

  var1 = var1;
}

function ref_11c9e(var0, var1, var2) {
  switch (level.mapname) {
    case "mp_quarry2":
      switch (var1) {
        case "allies":
          switch (var2) {
            case "alpha":
              break;
            case "bravo":
              var0.origin += anglesToForward(var0.angles) * 200;
              break;
          }

          break;
        case "axis":
          switch (var2) {
            case "alpha":
              break;
            case "bravo":
              var0.origin += anglestoup(var0.angles) * 281.907;
              break;
          }

          break;
      }

      break;
  }
}