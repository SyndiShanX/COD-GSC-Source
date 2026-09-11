/**********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\infilexfil\rappel_hackney_infil.gsc
**********************************************************/

function rappel_hackney_init(var_0) {
  initanims(var_0);
  var_1 = [];
  GscBinSkip0(0x2e, 0, [0, 1]);
}

function rappel_hackney_spawn(var_0, var_1, var_2, var_3) {
  var_4 = scripts\engine\utility::getStruct(var_1, "targetname");
  var_5 = spawn("script_origin", var_4.origin);
  var_5.angles = var_4.angles;
  var_5.scene_node = var_4;
  thread infilthink(var_5, var_0);
  return var_5;
}

function rappel_hackney_get_length(var_0) {
  var_1 = getanimlength(level.scr_anim["slot_0"]["rappel_hackney_infil_" + var_0]);
  return var_1;
}

function player_rappel_hackney_infil_think(var_0, var_1) {
  self endon("player_free_spot");

  if(isPlayer(self)) {
    self setclienttriggeraudiozone("hackney_infil_heli_intro", 1);
  }

  applymapvisionset();
  thread scripts\mp\infilexfil\infilexfil::infil_scene_fade_in(0, 0.55);
  thread player_infil_end();
  thread heli_infil_radio_idle();
  var_2 = var_0.linktoent gettagorigin("origin_animate_jnt");
  var_3 = var_0.linktoent gettagangles("origin_animate_jnt");
  thread scripts\mp\utility\infilexfil::infil_player_rig_updated("slot_" + var_1, var_2, var_3);
  self.player_rig linkTo(var_0.linktoent, "origin_animate_jnt", (0, 0, 0), (0, 0, 0));
  var_0.linktoent scripts\common\anim::anim_first_frame_solo(self.player_rig, "rappel_hackney_infil_" + var_0.subtype);
  thread player_rappel_disconnect();
  self.manualoverridewindmaterial = 1;
  self setscriptablepartstate("wind", "100", 0);
  self setdemeanorviewmodel("safe", "iw8_ges_demeanor_safe_heli");
  scripts\mp\flags::gameflagwait("infil_started");
  self lerpfovscalefactor(0, 0);

  if(var_1 == 0) {
    self lerpfovbypreset("80_instant");
  }

  if(isDefined(self.team) && self.team != "spectator") {
    var_4 = [];
    GscBinSkip0(0x2e, var_4.size, "mp_infil_mix_musicheavy");
  }

  if(isDefined(self.animname) && isPlayer(self)) {
    var_8 = "scn_infil_hackney_heli_plr1";

    if(isDefined(var_1.subtype)) {
      if(var_1.subtype == "alpha") {
        switch (self.animname) {
          case "slot_0":
            var_8 = "scn_infil_hackney_heli_plr1";
            break;
          case "slot_1":
            var_8 = "scn_infil_hackney_heli_plr2";
            break;
          case "slot_2":
            var_8 = "scn_infil_hackney_heli_plr3";
            break;
          default:
            var_8 = "scn_infil_hackney_heli_plr1";
            break;
        }
      } else {
        switch (self.animname) {
          case "slot_0":
            var_8 = "scn_infil_hackney_heli_plr4";
            break;
          case "slot_1":
            var_8 = "scn_infil_hackney_heli_plr5";
            break;
          case "slot_2":
            var_8 = "scn_infil_hackney_heli_plr6";
            break;
          default:
            var_8 = "scn_infil_hackney_heli_plr4";
            break;
        }
      }
    }

    self setclienttriggeraudiozone("hackney_infil_heli", 2);
    self playlocalsound(var_8);
  }

  self setcinematicmotionoverride("disabled");
  thread player_normal_think(var_1);
}

function player_normal_think(var_0) {
  self endon("player_free_spot");
  self lerpviewangleclamp(1, 0.25, 0.25, 30, 30, 30, 10);
  var_0.linktoent scripts\mp\anim::anim_player_solo(self, self.player_rig, "rappel_hackney_infil_" + var_0.subtype);

  if(isDefined(self.player_rig) && self.player_rig islinked()) {
    self.player_rig unlink();
  }

  if(self isnightvisionon()) {
    self visionsetnakedforplayer("", 0.75);
  }

  self setdemeanorviewmodel("normal");
  self clearcinematicmotionoverride();
  self disablephysicaldepthoffieldscripting();
  self setscriptablepartstate("wind", "0", 0);
  self.manualoverridewindmaterial = 0;
}

function clear_infil_ambient_zone() {
  self endon("death_or_disconnect");
  wait 1;
  self clearallsoundsubmixes();
  self clearclienttriggeraudiozone(2);
}

function heli_infil_radio_idle() {
  if(isPlayer(self)) {
    var_0 = spawn("script_origin", (0, 0, 0));
    var_0 showonlytoplayer(self);

    if(isDefined(self.team)) {
      var_1 = scripts\mp\utility\teams::getteamvoiceinfix(self.team);
      var_2 = "dx_mpo_" + var_1 + "op_drone_deathchatter";
    } else {
      var_2 = "dx_mpo_usop_drone_deathchatter";
    }

    if(soundexists(var_2)) {
      var_2 playLoopSound(var_2);
    } else {
      var_2 playLoopSound("dx_mpo_usop_drone_deathchatter");
    }

    scripts\mp\flags::gameflagwait("infil_started");
    wait 2;
    var_2 stoploopsound(var_2);
    var_2 delete();
    return;
  }
}

function player_interactive_think(var_0) {
  self endon("player_free_spot");
  self.player_rig linkTo(var_0.linktoent, "origin_animate_jnt", (0, 0, 0), (0, 0, 0));
  self lerpviewangleclamp(1, 0.25, 0.25, 80, 80, 30, 70);
  var_0 scripts\mp\anim::anim_player_solo(self, self.player_rig, "rappel_hackney_infil_" + var_0.subtype + "_interactive_intro");
  thread combat_start();
  wait 15;
  thread combat_end();

  if(!isai(self)) {
    scripts\mp\utility\infilexfil::givegunless();
  }

  self lerpviewangleclamp(1, 0.25, 0.25, 0, 0, 0, 0);
  var_0.linktoent scripts\mp\anim::anim_player_solo(self, self.player_rig, "rappel_hackney_infil_" + var_0.subtype + "_interactive_exit");

  if(isDefined(self.player_rig) && self.player_rig islinked()) {
    self.player_rig unlink();
  }

  if(self isnightvisionon()) {
    self visionsetnakedforplayer("", 0.75);
  }

  self setdemeanorviewmodel("normal");
  self clearcinematicmotionoverride();
}

function player_infil_end() {
  self endon("disconnect");
  level waittill("prematch_over");
  self notify("remove_rig");
  self clearallsoundsubmixes();
  self clearclienttriggeraudiozone(1);
  scripts\mp\utility\player::setdof_default();
}

function player_rappel_disconnect() {
  level endon("prematch_over");
  self waittill("death_or_disconnect");

  if(isDefined(self)) {
    self visionsetnakedforplayer("");
    self clearallsoundsubmixes();
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
  self.actors[self.actors.size] = spawn_anim_model(self.linktoent, "commander", "origin_animate_jnt", var_3.body, var_3.head);
  self.actors[self.actors.size] = spawn_anim_model(self.linktoent, "pilot", "origin_animate_jnt", "body_pilot_helicopter_british", "head_pilot_helicopter_british");
  self.actors[self.actors.size] = spawn_anim_model(self.linktoent, "copilot", "origin_animate_jnt", "body_pilot_helicopter_british", "head_mp_helicopter_crew");

  foreach(var_5 in self.actors) {
    var_5.infil = self;
  }

  scripts\mp\flags::gameflagwait("infil_started");
  self.actors[0].anim_playsound_func = &blima_commander_play_sound_func;
}

function infilthink(var_0, var_1) {
  var_2 = getdvarfloat("NMORQOTSK", 0.2);

  foreach(var_4 in getEntArray("infil_delete", "script_noteworthy")) {
    var_4 delete();
  }

  thread helithink(var_0, self.scene_node, var_1);
  thread actorthink(var_0, self.scene_node, var_1);
  scripts\mp\flags::gameflagwait("infil_started");
  setDvar("TLMMOPMSK", 1);
  setDvar("NMORQOTSK", 1);

  if(level.prematchperiodend > self.infillength) {
    wait level.prematchperiodend - self.infillength;
  }

  level waittill("prematch_over");
  setDvar("TLMMOPMSK", 0);
  setDvar("NMORQOTSK", var_2);
}

function helithink(var_0, var_1, var_2) {
  spawnheli(var_1, var_0, var_2);
  scripts\common\anim::anim_first_frame_solo(self.linktoent, "rappel_hackney_infil_" + var_2);
  scripts\mp\flags::gameflagwait("infil_started");
  self.linktoent setscriptablepartstate("engine", "on", 0);
  self.linktoent setscriptablepartstate("running_lights", "on", 0);
  self.linktoent setscriptablepartstate("infil_lights", "on", 0);
  thread heli_normal_think(var_0, var_1, var_2);
  thread heli_interior_sfx(var_2);
}

function heli_interior_sfx(var_0) {
  var_1 = spawn("script_model", self.linktoent.origin);
  var_2 = spawn("script_model", self.linktoent.origin);
  var_2 linkTo(self.linktoent, "tag_light_cockpit01");
  wait 0.1;

  if(var_0 == "alpha") {
    self.linktoent playsoundonmovingent("scn_mp_hackney_heli1_lr");
    var_1 linkTo(self.linktoent, "j_tied_cable_02");
    wait 0.1;
    var_1 playsoundonmovingent("scn_infil_hackney_heli1_ceiling_rattles");
    var_2 playsoundonmovingent("scn_infil_hackney_heli1_cockpit_rattles");
  } else {
    self.linktoent playsoundonmovingent("scn_mp_hackney_heli2_lr");
    var_1 linkTo(self.linktoent, "j_ceiling_cable_02");
    wait 0.1;
    var_1 playsoundonmovingent("scn_infil_hackney_heli2_ceiling_rattles");
    var_2 playsoundonmovingent("scn_infil_hackney_heli2_cockpit_rattles");
  }

  level waittill("prematch_over");
  var_1 delete();
  var_2 delete();
}

function heli_interactive_think(var_0, var_1, var_2) {
  thread scripts\common\anim::anim_single_solo(self.linktoent, "rappel_hackney_infil_" + var_2 + "_interactive");
  wait level.interactivecombatduration - 15;
  thread ropethink(var_2);
  wait 15;
  cleanup();
}

function heli_normal_think(var_0, var_1, var_2) {
  thread ropethink(var_2);

  if(isDefined(self.path)) {
    thread scripts\common\anim::anim_single_solo(self.linktoent, "rappel_hackney_infil_" + var_2);
    vehiclethinkpath(var_0, var_1, var_2);
  } else {
    thread scripts\common\anim::anim_single_solo(self.linktoent, "rappel_hackney_infil_" + var_2);
    var_3 = getanimlength(level.scr_anim[self.linktoent.animname]["rappel_hackney_infil_" + var_2]);
    wait var_3;
  }

  cleanup();
}

function ropethink(var_0) {
  self.linktoent thread scripts\common\anim::anim_single_solo(self.linktoent.rope, "rappel_hackney_infil_" + var_0, "origin_animate_jnt");
  var_1 = getanimlength(level.scr_anim[self.linktoent.rope.animname]["rappel_hackney_infil_" + var_0]);
  wait var_1;
  self.linktoent.rope unlink();
  thread scripts\common\anim::anim_single_solo(self.linktoent.rope, "rappel_hackney_infil_" + var_0 + "_fall");
}

function ref_13293(var_0) {
  var_0 playsoundonmovingent("scn_infil_hackney_heli1_rope");
}

function ref_13294(var_0) {
  var_0 playsoundonmovingent("scn_infil_hackney_heli2_rope");
}

function actorthink(var_0, var_1, var_2, var_3) {
  thread spawnactors(var_0, var_2, var_3);
  actor_normal_think(var_0, var_1, var_2);
}

function actor_interactive_think(var_0, var_1, var_2) {
  self.linktoent scripts\common\anim::anim_first_frame(self.actors, "rappel_hackney_infil_" + var_2 + "_interactive", "origin_animate_jnt");
  scripts\mp\utility\infilexfil::hideactors();
  level waittill("infil_started");
  scripts\mp\utility\infilexfil::showactors();
  self.linktoent thread scripts\common\anim::anim_single(self.actors, "rappel_hackney_infil_" + var_2 + "_interactive", "origin_animate_jnt");
  self.actors[0].head scriptmodelplayanim(level.scr_anim[self.actors[0].animname]["rappel_hackney_infil_" + var_2 + "_interactive"]);
}

function actor_normal_think(var_0, var_1, var_2) {
  self.linktoent scripts\common\anim::anim_first_frame(self.actors, "rappel_hackney_infil_" + var_2, "origin_animate_jnt");
  scripts\mp\utility\infilexfil::hideactors();
  scripts\mp\flags::gameflagwait("infil_started");
  scripts\mp\utility\infilexfil::showactors();
  self.linktoent thread scripts\common\anim::anim_single(self.actors, "rappel_hackney_infil_" + var_2, "origin_animate_jnt");
  self.actors[0].head scriptmodelplayanim(level.scr_anim[self.actors[0].animname]["rappel_hackney_infil_" + var_2]);
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

  if(!isDefined(level.scr_notetrack) || !isDefined(level.scr_notetrack["commander"])) {
    scripts\common\anim::addnotetrack_customfunction("commander", "door_slam", &blima_door_slam);
    scripts\common\anim::addnotetrack_customfunction("commander", "shake_low", &blima_cam_shake_low);
    scripts\common\anim::addnotetrack_customfunction("commander", "shake_bump", &blima_cam_shake_bump);
    scripts\common\anim::addnotetrack_customfunction("commander", "door_open_sfx", &heli_door_open_sfx);
    scripts\common\anim::addnotetrack_customfunction("commander", "sfx_infil_hackney_heli_commander", &heli_commander_sfx);
    scripts\common\anim::addnotetrack_customfunction("commander", "scn_infil_hackney_heli1_rope", &ref_13293);
    scripts\common\anim::addnotetrack_customfunction("commander", "scn_infil_hackney_heli2_rope", &ref_13294);
  }

  switch (var_0) {
    case "alpha":
      scripts\common\anim::addnotetrack_customfunction("slot_0", "player_lock_look_1_second", &scripts\mp\utility\infilexfil::player_lock_look_1_second, "rappel_hackney_infil_alpha");
      scripts\common\anim::addnotetrack_customfunction("slot_0", "outside_heli", &outsideheli, "rappel_hackney_infil_alpha");
      scripts\common\anim::addnotetrack_customfunction("slot_0", "rumble_rope", &blima_rumble_rope, "rappel_hackney_infil_alpha");
      scripts\common\anim::addnotetrack_customfunction("slot_0", "rumble_ground", &blima_rumble_ground, "rappel_hackney_infil_alpha");
      scripts\common\anim::addnotetrack_customfunction("slot_0", "free_look", &scripts\mp\utility\infilexfil::player_free_look, "rappel_hackney_infil_alpha");
      scripts\common\anim::addnotetrack_customfunction("slot_0", "fov_63_2", &scripts\mp\utility\infilexfil::player_fov_default_2, "rappel_hackney_infil_alpha");
      scripts\common\anim::addnotetrack_customfunction("slot_0", "equip_nvg", &scripts\mp\utility\infilexfil::player_equip_nvg, "rappel_hackney_infil_alpha");
      scripts\common\anim::addnotetrack_customfunction("slot_1", "player_lock_look_1_second", &scripts\mp\utility\infilexfil::player_lock_look_1_second, "rappel_hackney_infil_alpha");
      scripts\common\anim::addnotetrack_customfunction("slot_1", "outside_heli", &outsideheli, "rappel_hackney_infil_alpha");
      scripts\common\anim::addnotetrack_customfunction("slot_1", "rumble_rope", &blima_rumble_rope, "rappel_hackney_infil_alpha");
      scripts\common\anim::addnotetrack_customfunction("slot_1", "rumble_ground", &blima_rumble_ground, "rappel_hackney_infil_alpha");
      scripts\common\anim::addnotetrack_customfunction("slot_1", "free_look", &scripts\mp\utility\infilexfil::player_free_look, "rappel_hackney_infil_alpha");
      scripts\common\anim::addnotetrack_customfunction("slot_1", "fov_63_2", &scripts\mp\utility\infilexfil::player_fov_default_2, "rappel_hackney_infil_alpha");
      scripts\common\anim::addnotetrack_customfunction("slot_1", "equip_nvg", &scripts\mp\utility\infilexfil::player_equip_nvg, "rappel_hackney_infil_alpha");
      scripts\common\anim::addnotetrack_customfunction("slot_2", "player_lock_look_1_second", &scripts\mp\utility\infilexfil::player_lock_look_1_second, "rappel_hackney_infil_alpha");
      scripts\common\anim::addnotetrack_customfunction("slot_2", "outside_heli", &outsideheli, "rappel_hackney_infil_alpha");
      scripts\common\anim::addnotetrack_customfunction("slot_2", "rumble_rope", &blima_rumble_rope, "rappel_hackney_infil_alpha");
      scripts\common\anim::addnotetrack_customfunction("slot_2", "rumble_ground", &blima_rumble_ground, "rappel_hackney_infil_alpha");
      scripts\common\anim::addnotetrack_customfunction("slot_2", "free_look", &scripts\mp\utility\infilexfil::player_free_look, "rappel_hackney_infil_alpha");
      scripts\common\anim::addnotetrack_customfunction("slot_2", "fov_63_2", &scripts\mp\utility\infilexfil::player_fov_default_2, "rappel_hackney_infil_alpha");
      scripts\common\anim::addnotetrack_customfunction("slot_2", "equip_nvg", &scripts\mp\utility\infilexfil::player_equip_nvg, "rappel_hackney_infil_alpha");
      break;
    case "bravo":
      scripts\common\anim::addnotetrack_customfunction("slot_0", "player_lock_look_1_second", &scripts\mp\utility\infilexfil::player_lock_look_1_second, "rappel_hackney_infil_bravo");
      scripts\common\anim::addnotetrack_customfunction("slot_0", "outside_heli", &outsideheli, "rappel_hackney_infil_bravo");
      scripts\common\anim::addnotetrack_customfunction("slot_0", "rumble_rope", &blima_rumble_rope, "rappel_hackney_infil_bravo");
      scripts\common\anim::addnotetrack_customfunction("slot_0", "rumble_ground", &blima_rumble_ground, "rappel_hackney_infil_bravo");
      scripts\common\anim::addnotetrack_customfunction("slot_0", "free_look", &scripts\mp\utility\infilexfil::player_free_look, "rappel_hackney_infil_bravo");
      scripts\common\anim::addnotetrack_customfunction("slot_0", "fov_63_2", &scripts\mp\utility\infilexfil::player_fov_default_2, "rappel_hackney_infil_bravo");
      scripts\common\anim::addnotetrack_customfunction("slot_0", "equip_nvg", &scripts\mp\utility\infilexfil::player_equip_nvg, "rappel_hackney_infil_bravo");
      scripts\common\anim::addnotetrack_customfunction("slot_1", "player_lock_look_1_second", &scripts\mp\utility\infilexfil::player_lock_look_1_second, "rappel_hackney_infil_bravo");
      scripts\common\anim::addnotetrack_customfunction("slot_1", "outside_heli", &outsideheli, "rappel_hackney_infil_bravo");
      scripts\common\anim::addnotetrack_customfunction("slot_1", "rumble_rope", &blima_rumble_rope, "rappel_hackney_infil_bravo");
      scripts\common\anim::addnotetrack_customfunction("slot_1", "rumble_ground", &blima_rumble_ground, "rappel_hackney_infil_bravo");
      scripts\common\anim::addnotetrack_customfunction("slot_1", "free_look", &scripts\mp\utility\infilexfil::player_free_look, "rappel_hackney_infil_bravo");
      scripts\common\anim::addnotetrack_customfunction("slot_1", "fov_63_2", &scripts\mp\utility\infilexfil::player_fov_default_2, "rappel_hackney_infil_bravo");
      scripts\common\anim::addnotetrack_customfunction("slot_1", "equip_nvg", &scripts\mp\utility\infilexfil::player_equip_nvg, "rappel_hackney_infil_bravo");
      scripts\common\anim::addnotetrack_customfunction("slot_2", "player_lock_look_1_second", &scripts\mp\utility\infilexfil::player_lock_look_1_second, "rappel_hackney_infil_bravo");
      scripts\common\anim::addnotetrack_customfunction("slot_2", "outside_heli", &outsideheli, "rappel_hackney_infil_bravo");
      scripts\common\anim::addnotetrack_customfunction("slot_2", "rumble_rope", &blima_rumble_rope, "rappel_hackney_infil_bravo");
      scripts\common\anim::addnotetrack_customfunction("slot_2", "rumble_ground", &blima_rumble_ground, "rappel_hackney_infil_bravo");
      scripts\common\anim::addnotetrack_customfunction("slot_2", "free_look", &scripts\mp\utility\infilexfil::player_free_look, "rappel_hackney_infil_bravo");
      scripts\common\anim::addnotetrack_customfunction("slot_2", "fov_63_2", &scripts\mp\utility\infilexfil::player_fov_default_2, "rappel_hackney_infil_bravo");
      scripts\common\anim::addnotetrack_customfunction("slot_2", "equip_nvg", &scripts\mp\utility\infilexfil::player_equip_nvg, "rappel_hackney_infil_bravo");
      break;
  }
}

#using_animtree("");

function script_model_alpha_anims(var_0) {
  switch (var_0) {
    case "alpha":
      level.scr_animtree["pilot"] = #animtree;
      level.scr_anim["pilot"]["rappel_hackney_infil_alpha"] = $mp_faridah_infill_bird_a_pilot_idle;
      level.scr_animname["pilot"]["rappel_hackney_infil_alpha"] = "mp_faridah_infill_bird_a_pilot_idle";
      level.scr_anim["pilot"]["rappel_hackney_infil_alpha_interactive"] = % mp_faridah_infill_bird_a_pilot_idle;
      level.scr_animname["pilot"]["rappel_hackney_infil_alpha_interactive"] = "mp_faridah_infill_bird_a_pilot_idle";
      level.scr_animtree["copilot"] = #animtree;
      level.scr_anim["copilot"]["rappel_hackney_infil_alpha"] = % mp_faridah_infill_bird_a_copilot_idle;
      level.scr_animname["copilot"]["rappel_hackney_infil_alpha"] = "mp_faridah_infill_bird_a_copilot_idle";
      level.scr_anim["copilot"]["rappel_hackney_infil_alpha_interactive"] = % mp_faridah_infill_bird_a_copilot_idle;
      level.scr_animname["copilot"]["rappel_hackney_infil_alpha_interactive"] = "mp_faridah_infill_bird_a_copilot_idle";
      level.scr_animtree["commander"] = #animtree;
      level.scr_anim["commander"]["rappel_hackney_infil_alpha"] = % mp_infil_blima_chief;
      level.scr_animname["commander"]["rappel_hackney_infil_alpha"] = "mp_infil_blima_chief";
      level.scr_anim["commander"]["rappel_hackney_infil_alpha_interactive"] = % mp_infil_act_blima_chief;
      level.scr_animname["commander"]["rappel_hackney_infil_alpha_interactive"] = "mp_infil_act_blima_chief";
      level.scr_animtree["rope"] = #animtree;
      level.scr_anim["rope"]["rappel_hackney_infil_alpha"] = % equipment_fast_rope_wm_01_infil_heli_l;
      level.scr_animname["rope"]["rappel_hackney_infil_alpha"] = "equipment_fast_rope_wm_01_infil_heli_l";
      level.scr_anim["rope"]["rappel_hackney_infil_alpha_fall"] = % equipment_fast_rope_wm_01_infil_heli_l_fall;
      level.scr_animname["rope"]["rappel_hackney_infil_alpha_fall"] = "equipment_fast_rope_wm_01_infil_heli_l_fall";
      level.scr_animtree["slot_0"] = #animtree;
      level.scr_anim["slot_0"]["rappel_hackney_infil_alpha"] = % mp_infil_blima_guy01;
      level.scr_animname["slot_0"]["rappel_hackney_infil_alpha"] = "mp_infil_blima_guy01";
      level.scr_eventanim["slot_0"]["rappel_hackney_infil_alpha"] = "infil_rappel_hackney_alpha_ally_1";
      scripts\common\anim::addnotetrack_customfunction("slot_0", "scn_infil_hackney_heli_npc1", &ref_12eee);
      level.scr_animtree["slot_1"] = #animtree;
      level.scr_anim["slot_1"]["rappel_hackney_infil_alpha"] = % mp_infil_blima_guy02;
      level.scr_animname["slot_1"]["rappel_hackney_infil_alpha"] = "mp_infil_blima_guy02";
      level.scr_eventanim["slot_1"]["rappel_hackney_infil_alpha"] = "infil_rappel_hackney_alpha_ally_2";
      scripts\common\anim::addnotetrack_customfunction("slot_1", "scn_infil_hackney_heli_npc2", &ref_12eef);
      level.scr_animtree["slot_2"] = #animtree;
      level.scr_anim["slot_2"]["rappel_hackney_infil_alpha"] = % mp_infil_blima_guy03;
      level.scr_animname["slot_2"]["rappel_hackney_infil_alpha"] = "mp_infil_blima_guy03";
      level.scr_eventanim["slot_2"]["rappel_hackney_infil_alpha"] = "infil_rappel_hackney_alpha_ally_3";
      scripts\common\anim::addnotetrack_customfunction("slot_2", "scn_infil_hackney_heli_npc3", &ref_12ef0);
      break;
    case "bravo":
      level.scr_animtree["pilot"] = #animtree;
      level.scr_anim["pilot"]["rappel_hackney_infil_bravo"] = % mp_faridah_infill_bird_a_pilot_idle;
      level.scr_animname["pilot"]["rappel_hackney_infil_bravo"] = "mp_faridah_infill_bird_a_pilot_idle";
      level.scr_anim["pilot"]["rappel_hackney_infil_bravo_interactive"] = % mp_faridah_infill_bird_a_pilot_idle;
      level.scr_animname["pilot"]["rappel_hackney_infil_bravo_interactive"] = "mp_faridah_infill_bird_a_pilot_idle";
      level.scr_animtree["copilot"] = #animtree;
      level.scr_anim["copilot"]["rappel_hackney_infil_bravo"] = % mp_faridah_infill_bird_a_copilot_idle;
      level.scr_animname["copilot"]["rappel_hackney_infil_bravo"] = "mp_faridah_infill_bird_a_copilot_idle";
      level.scr_anim["copilot"]["rappel_hackney_infil_bravo_interactive"] = % mp_faridah_infill_bird_a_copilot_idle;
      level.scr_animname["copilot"]["rappel_hackney_infil_bravo_interactive"] = "mp_faridah_infill_bird_a_copilot_idle";
      level.scr_animtree["commander"] = #animtree;
      level.scr_anim["commander"]["rappel_hackney_infil_bravo"] = % mp_infil_blima_r_chief;
      level.scr_animname["commander"]["rappel_hackney_infil_bravo"] = "mp_infil_blima_r_chief";
      level.scr_anim["commander"]["rappel_hackney_infil_bravo_interactive"] = % mp_infil_act_blima_b_chief;
      level.scr_animname["commander"]["rappel_hackney_infil_bravo_interactive"] = "mp_infil_act_blima_b_chief";
      level.scr_animtree["rope"] = #animtree;
      level.scr_anim["rope"]["rappel_hackney_infil_bravo"] = % equipment_fast_rope_wm_01_infil_heli_r;
      level.scr_animname["rope"]["rappel_hackney_infil_bravo"] = "equipment_fast_rope_wm_01_infil_heli_r";
      level.scr_anim["rope"]["rappel_hackney_infil_bravo_fall"] = % equipment_fast_rope_wm_01_infil_heli_r_fall;
      level.scr_animname["rope"]["rappel_hackney_infil_bravo_fall"] = "equipment_fast_rope_wm_01_infil_heli_r_fall";
      level.scr_animtree["slot_0"] = #animtree;
      level.scr_anim["slot_0"]["rappel_hackney_infil_bravo"] = % mp_infil_blima_r_guy01;
      level.scr_animname["slot_0"]["rappel_hackney_infil_bravo"] = "mp_infil_blima_r_guy01";
      level.scr_eventanim["slot_0"]["rappel_hackney_infil_bravo"] = "infil_rappel_hackney_bravo_ally_1";
      scripts\common\anim::addnotetrack_customfunction("slot_0", "scn_infil_hackney_heli_npc4", &ref_12ef1);
      level.scr_animtree["slot_1"] = #animtree;
      level.scr_anim["slot_1"]["rappel_hackney_infil_bravo"] = % mp_infil_blima_r_guy02;
      level.scr_animname["slot_1"]["rappel_hackney_infil_bravo"] = "mp_infil_blima_r_guy02";
      level.scr_eventanim["slot_1"]["rappel_hackney_infil_bravo"] = "infil_rappel_hackney_bravo_ally_2";
      scripts\common\anim::addnotetrack_customfunction("slot_1", "scn_infil_hackney_heli_npc5", &ref_12ef2);
      level.scr_animtree["slot_2"] = #animtree;
      level.scr_anim["slot_2"]["rappel_hackney_infil_bravo"] = % mp_infil_blima_r_guy03;
      level.scr_animname["slot_2"]["rappel_hackney_infil_bravo"] = "mp_infil_blima_r_guy03";
      level.scr_eventanim["slot_2"]["rappel_hackney_infil_bravo"] = "infil_rappel_hackney_bravo_ally_3";
      scripts\common\anim::addnotetrack_customfunction("slot_2", "scn_infil_hackney_heli_npc6", &ref_12ef3);
      break;
  }
}

function vehicles_alpha_anims(var_0) {
  switch (var_0) {
    case "alpha":
      level.scr_animtree["blima"] = #animtree;

      switch (getDvar("mapname")) {
        case "mp_spear":
        case "mp_spear_pm":
          level.scr_anim["blima"]["rappel_hackney_infil_alpha"] = $mp_infil_blima_heli_mpspear_alpha;
          break;
        case "mp_cave_am":
        case "mp_cave":
          level.scr_anim["blima"]["rappel_hackney_infil_alpha"] = % mp_infil_blima_heli_mpcave_alpha;
          break;
        case "mp_crash2":
          level.scr_anim["blima"]["rappel_hackney_infil_alpha"] = % mp_infil_blima_heli_mpcrash_alpha;
          break;
        case "mp_aniyah_tac":
          level.scr_anim["blima"]["rappel_hackney_infil_alpha"] = % mp_infil_blima_heli_mpaniyah_tactical_alpha;
          break;
        case "mp_oilrig":
        case "mp_malyshev":
          level.scr_anim["blima"]["rappel_hackney_infil_alpha"] = % mp_infil_blima_heli_mp_oilrig_alpha;
          break;
        case "mp_harbor":
          level.scr_anim["blima"]["rappel_hackney_infil_alpha"] = % mp_infil_blima_heli_mpharbor_alpha;
          break;
        case "mp_herat":
          level.scr_anim["blima"]["rappel_hackney_infil_alpha"] = % mp_infil_blima_heli_mp_herat_alpha;
          break;
        default:
          level.scr_anim["blima"]["rappel_hackney_infil_alpha"] = % mp_infil_blima_heli;
          break;
      }

      level.scr_anim["blima"]["rappel_hackney_infil_alpha_interactive"] = % mp_infil_act_blima_heli;
      break;
    case "bravo":
      level.scr_animtree["blima"] = #animtree;

      switch (getDvar("mapname")) {
        case "mp_spear":
        case "mp_spear_pm":
          level.scr_anim["blima"]["rappel_hackney_infil_bravo"] = % mp_infil_blima_heli_mpspear_bravo;
          break;
        case "mp_cave_am":
        case "mp_cave":
          level.scr_anim["blima"]["rappel_hackney_infil_bravo"] = % mp_infil_blima_heli_mpcave_bravo;
          break;
        case "mp_crash2":
          level.scr_anim["blima"]["rappel_hackney_infil_bravo"] = % mp_infil_blima_heli_mpcrash_bravo;
          break;
        case "mp_aniyah_tac":
          level.scr_anim["blima"]["rappel_hackney_infil_bravo"] = % mp_infil_blima_heli_mpaniyah_tactical_bravo;
          break;
        case "mp_oilrig":
        case "mp_malyshev":
          level.scr_anim["blima"]["rappel_hackney_infil_bravo"] = % mp_infil_blima_heli_mp_oilrig_bravo;
          break;
        case "mp_harbor":
          level.scr_anim["blima"]["rappel_hackney_infil_bravo"] = % mp_infil_blima_heli_mpharbor_bravo;
          break;
        case "mp_herat":
          level.scr_anim["blima"]["rappel_hackney_infil_bravo"] = % mp_infil_blima_heli_mp_herat_bravo;
          break;
        default:
          level.scr_anim["blima"]["rappel_hackney_infil_bravo"] = % mp_infil_blima_r_heli;
          break;
      }

      level.scr_anim["blima"]["rappel_hackney_infil_bravo_interactive"] = % mp_infil_act_blima_b_heli;
      break;
  }
}

function spawnheli(var_0, var_1, var_2) {
  var_3 = "blima_desert_day_infil_mp";

  if(level.mapname == "mp_hackney_yard") {
    var_3 = "blima_hackney_infil_mp";
  }

  var_4 = spawnVehicle("veh8_mil_air_blima_infils", var_2, var_3, var_0.origin, var_0.angles);
  var_4 setvehicleteam(var_1);
  var_4 setCanDamage(0);
  var_4.animname = "blima";
  self.linktoent = var_4;
  var_4.infil = self;
  self.linktoent.rope = spawn_anim_model(self.linktoent, "rope", "origin_animate_jnt", "equipment_fast_rope_wm_01_infil_heli_l");
  self.linktoent.rope scripts\common\anim::anim_first_frame_solo(self.linktoent.rope, "rappel_hackney_infil_" + var_2);
  return var_4;
}

function helifollowpath(var_0) {
  if(!isDefined(var_0)) {
    return;
  }

  var_1 = scripts\engine\utility::getStruct(var_0, "targetname");

  if(!isDefined(var_1)) {
    return;
  }

  var_2 = scripts\engine\utility::getStruct(var_1.target, "targetname");
  self.speed = 500;
  self.accel = 175;
  self.combatmode = "guard_location";
  self notify(self.combatmode);

  while(isDefined(var_1.target)) {
    thread scripts\mp\killstreaks\jackal::guardpositionescort(var_2.origin, undefined, 800);

    for(;;) {
      var_3 = distance(self.origin, var_2.origin);

      if(var_3 < 2000) {
        break;
      }

      waitframe();
    }

    self notify("leaving");

    if(!isDefined(var_2.target)) {
      break;
    }

    var_1 = var_2;
    var_2 = scripts\engine\utility::getStruct(var_1.target, "targetname");
  }
}

function cleanup() {
  foreach(var_1 in self.actors) {
    var_1 delete();
  }

  self.linktoent.rope delete();
  self.linktoent delete();
  level.stop_station_closed_vo--;
  self delete();
}

function spawn_infil_axis_ai(var_0, var_1, var_2, var_3) {
  level.gameskill = 0;
  var_4 = scripts\mp\mp_agent::spawnnewagent("soldier_agent", "axis", var_1, var_2, scripts\engine\utility::ter_op(isDefined(var_3), var_3, "iw8_ar_mike4_mp"));

  if(!isDefined(var_4)) {
    return undefined;
  }

  var_4.desiredmovetype = "combat";
  var_4 clearpath();
  var_4.goalradius = 999;
  var_4.fixednode = 0;
  var_4 scripts\mp\agents\agent_common::set_agent_health(50);
  return var_4;
}

function spawninteractiveinfilai() {
  thread alphaai();
  thread bravoai();
}

function alphaai() {
  level endon("interactive_infil_complete");
  level endon("prematch_over");
  level endon("infil_done");
  level.alphaagents = [];
  var_0 = scripts\engine\utility::getStructArray("ai_alpha_start", "targetname");
  var_1 = scripts\engine\utility::getStructArray("ai_alpha_respawn", "targetname");

  foreach(var_5, var_3 in var_0) {
    var_4 = spawn_infil_axis_ai("alpha", var_3.origin, var_3.angles);

    if(isDefined(var_4)) {
      thread alpha_ai_array_handler(level);
    }
  }

  for(;;) {
    if(level.alphaagents.size < 5) {
      var_6 = randomint(var_1.size);

      if(randomint(100) > 75) {
        var_7 = "iw8_la_rpapa7_mp";
      } else {
        var_7 = undefined;
      }

      var_5 = spawn_infil_axis_ai("alpha", var_2[var_7].origin, var_2[var_7].angles, var_7);

      if(isDefined(var_5)) {
        thread alpha_ai_array_handler(level, var_5);
      }
    }

    waitframe();
  }
}

function alpha_ai_array_handler(var_0, var_1) {
  level.alphaagents = scripts\engine\utility::array_add(level.alphaagents, var_0);
  var_2 = scripts\mp\utility\outline::outlineenableforteam(var_0, "allies", scripts\engine\utility::ter_op(isDefined(var_1), "outline_depth_red", "outline_depth_orange"), "level_script");
  var_0 waittill("death");
  scripts\mp\utility\outline::outlinedisable(var_2, var_0);
  level.alphaagents = scripts\engine\utility::array_remove(level.alphaagents, var_0);
}

function bravoai() {
  level endon("interactive_infil_complete");
  level endon("prematch_over");
  level endon("infil_done");
  level.bravoagents = [];
  var_0 = scripts\engine\utility::getStructArray("ai_bravo_start", "targetname");
  var_1 = scripts\engine\utility::getStructArray("ai_bravo_respawn", "targetname");

  foreach(var_5, var_3 in var_0) {
    var_4 = spawn_infil_axis_ai("bravo", var_3.origin, var_3.angles);

    if(isDefined(var_4)) {
      thread bravo_ai_array_handler(level);
    }
  }

  for(;;) {
    if(level.bravoagents.size < 5) {
      var_6 = randomint(var_1.size);

      if(randomint(100) > 75) {
        var_7 = "iw8_la_rpapa7_mp";
      } else {
        var_7 = undefined;
      }

      var_5 = spawn_infil_axis_ai("bravo", var_2[var_7].origin, var_2[var_7].angles, var_7);

      if(isDefined(var_5)) {
        thread bravo_ai_array_handler(level, var_5);
      }
    }

    waitframe();
  }
}

function bravo_ai_array_handler(var_0, var_1) {
  level.bravoagents = scripts\engine\utility::array_add(level.bravoagents, var_0);
  var_2 = scripts\mp\utility\outline::outlineenableforteam(var_0, "allies", scripts\engine\utility::ter_op(isDefined(var_1), "outline_depth_red", "outline_depth_orange"), "level_script");
  var_0 waittill("death");
  scripts\mp\utility\outline::outlinedisable(var_2, var_0);
  level.bravoagents = scripts\engine\utility::array_remove(level.bravoagents, var_0);
}

function cleanupinteractiveinfilai() {
  var_0 = getanimlength(level.scr_anim["slot_0"]["rappel_hackney_infil_alpha_interactive_intro"]);
  var_0 += 15;
  wait var_0;

  foreach(var_2 in level.alphaagents) {
    if(isalive(var_2)) {
      var_2 kill();
    }
  }

  foreach(var_2 in level.bravoagents) {
    if(isalive(var_2)) {
      var_2 kill();
    }
  }
}

function agent_handledamagefeedback(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  if(isDefined(var_1) && var_1.team != "axis") {
    var_1 scripts\mp\damagefeedback::updatedamagefeedback("", var_2 >= self.health);

    if(var_2 >= self.health) {
      if(!isDefined(var_1.infilscore)) {
        var_1.infilscore = 1;
      } else {
        var_1.infilscore++;
      }

      if(var_1.infilscore > level.highestinfilscore) {
        updatehighinfilscore(level, var_1);
        return;
      }

      return;
    }

    return;
  }
}

function blima_door_slam(var_0) {
  foreach(var_2 in var_0.infil.players) {
    var_2 earthquakeforplayer(randomfloatrange(0.135, 0.15), 2, self.origin, 8000);
    var_2 playrumbleonpositionforclient("ground_pound_land", var_2.origin);
  }
}

function blima_cam_shake_low(var_0) {
  foreach(var_2 in var_0.infil.players) {
    var_2 scripts\mp\utility\infilexfil::updateshakeonplayer(0.06, 0.075, 2, var_2.origin, 8000, "mig_rumble", 0.05, 0.1);
  }
}

function blima_cam_shake_bump(var_0) {
  foreach(var_2 in var_0.infil.players) {
    var_2 scripts\mp\utility\infilexfil::updateshakeonplayer(0.145, 0.16, 2, var_2.origin, 8000, "pistol_fire", 0.05, 0.15);
  }
}

function heli_door_open_sfx(var_0) {
  if(var_0.infil.subtype == "alpha") {
    var_1 = spawn("script_origin", var_0.infil.linktoent.origin);
    var_1 linkTo(var_0.infil.linktoent, "side_door_l_jnt");
    var_1 playSound("scn_infil_hackney_heli1_door_open");
    wait 3;
    var_1 delete();
    return;
  }

  var_1 = spawn("script_origin", var_1.infil.linktoent.origin);
  var_1 linkTo(var_1.infil.linktoent, "side_door_r_jnt");
  var_1 playSound("scn_infil_hackney_heli2_door_open");
  wait 3;
  var_1 delete();
}

function heli_commander_sfx(var_0) {
  if(var_0.infil.subtype == "alpha") {
    var_0 playsoundonmovingent("scn_infil_hackney_heli1_commander");
    return;
  }

  var_0 playsoundonmovingent("scn_infil_hackney_heli2_commander");
}

function ref_12eee(var_0) {
  var_0 playsoundonmovingent("scn_infil_hackney_heli_npc1");
}

function ref_12eef(var_0) {
  var_0 playsoundonmovingent("scn_infil_hackney_heli_npc2");
}

function ref_12ef0(var_0) {
  var_0 playsoundonmovingent("scn_infil_hackney_heli_npc3");
}

function ref_12ef1(var_0) {
  var_0 playsoundonmovingent("scn_infil_hackney_heli_npc4");
}

function ref_12ef2(var_0) {
  var_0 playsoundonmovingent("scn_infil_hackney_heli_npc5");
}

function ref_12ef3(var_0) {
  var_0 playsoundonmovingent("scn_infil_hackney_heli_npc6");
}

function blima_rumble_rope(var_0) {
  level endon("prematch_over");
  level endon("infil_done");
  var_1 = var_0.player;
  var_1 notify("stop_cam_shake");
  var_1 endon("stop_cam_shake");
  var_1 endon("death_or_disconnect");

  for(;;) {
    var_1 playrumbleonpositionforclient("pistol_fire", var_1.origin);
    wait randomfloatrange(0.05, 0.15);
  }
}

function blima_rumble_ground(var_0) {
  var_1 = var_0.player;
  var_1 notify("stop_cam_shake");
  var_1 playRumbleOnEntity("ground_pound_land");
  var_1 lerpfovscalefactor(1, 0.5);
}

function combat_start() {
  self notify("stop_cam_shake");
  self endon("stop_cam_shake");
  self.interactivecombat = 1;
  scripts\common\utility::allow_fire(1);
  scripts\common\utility::allow_ads(1);
  scripts\common\utility::allow_reload(1);
  self setdemeanorviewmodel("normal");
  self lerpfovbypreset("default_2seconds");

  for(;;) {
    self playrumbleonpositionforclient("mig_rumble", self.origin);
    wait randomfloatrange(0.15, 0.5);
  }
}

function combat_end() {
  self notify("stop_cam_shake");
  self.interactivecombat = 0;
  scripts\mp\utility\infilexfil::updateshakeonplayer(0.06, 0.075, 2, self.origin, 8000, "mig_rumble", 0.05, 0.1);
  scripts\common\utility::allow_fire(0);
  scripts\common\utility::allow_ads(0);
  scripts\common\utility::allow_reload(0);
  scripts\mp\utility\weapon::setrecoilscale();
}

function blima_commander_play_sound_func(var_0, var_1, var_2) {
  foreach(var_4 in self.infil.players) {
    var_4 playsoundtoplayer(var_0, var_4);
  }
}

function vehiclethinkpath(var_0, var_1, var_2) {
  scripts\mp\flags::gameflagwait("infil_started");
  self.linktoent setscriptablepartstate("engine", "on", 0);
  self.linktoent.unload_hover_offset = 300;
  self.linktoent.unload_time = 10;
  self.linktoent thread scripts\mp\infilexfil\infilexfil::vehicle_paths_helicopter(self.path);
  thread scripts\mp\infilexfil\infilexfil::heli_path(self.linktoent);
  self.linktoent waittill("reached_dynamic_path_end");
  self.linktoent delete();
  self.linktoent = undefined;
}

function giveinteractiveinfilweapon() {
  var_0 = getcompleteweaponname("iw8_lm_kilo121infil_mp", ["acog_west01"]);
  scripts\cp_mp\utility\inventory_utility::_giveweapon(var_0, undefined, undefined, 1);
  scripts\common\utility::allow_weapon_switch(1);
  var_1 = scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(var_0, 0);

  if(var_1) {
    self.infilweapon = var_0;
    scripts\common\utility::allow_weapon_switch(0);
    scripts\mp\utility\weapon::setrecoilscale(0, 50);
  } else {
    scripts\cp_mp\utility\inventory_utility::_takeweapon(var_0);
    scripts\cp_mp\utility\inventory_utility::forcevalidweapon();
  }

  return var_1;
}

function updatehighinfilscore(var_0) {
  level.highestinfilname = var_0.name;
  level.highestinfilscore = var_0.infilscore;

  foreach(var_2 in level.players) {
    if(var_2.team == "allies") {
      var_2 iprintlnbold(level.highestinfilname + " is in the lead with" + level.highestinfilscore + " kills");
    }
  }
}

function announceinfilwinner() {
  level waittill("interactive_infil_complete");

  if(!isDefined(level.highestinfilname)) {
    return;
  }

  foreach(var_1 in level.players) {
    if(var_1.team == "allies") {
      var_1 iprintlnbold(level.highestinfilname + " won with" + level.highestinfilscore + " kills");
    }
  }
}

function dummychopper() {
  var_0 = (1325, -1200, 30);
  var_1 = (0, 90, 0);
  var_2 = spawnVehicle("veh8_mil_air_blima", "alpha", "blima_hackney_infil_mp", var_0, var_1);
  var_2 setvehicleteam("allies");
  var_2 setCanDamage(0);
  var_2.animname = "blima";
  var_2 setscriptablepartstate("engine", "on", 0);
  var_3 = spawn("script_model", var_2.origin);
  var_3.angles = var_2.angles;
  var_3 setModel("cop_marker_scriptable");
  var_3 setscriptablepartstate("marker", "heliLight");
  var_3 linkTo(var_2, "tag_origin", (0, 0, -60), (-90, 0, 0));
  var_2 thread scripts\common\anim::anim_single_solo(var_2, "rappel_hackney_infil_alpha");
  var_4 = (525, -1460, 30);
  var_5 = (0, 180, 0);
  var_6 = spawnVehicle("veh8_mil_air_blima", "bravo", "blima_hackney_infil_mp", var_4, var_5);
  var_6 setvehicleteam("allies");
  var_6 setCanDamage(0);
  var_6.animname = "blima";
  var_6 setscriptablepartstate("engine", "on", 0);
  var_3 = spawn("script_model", var_6.origin);
  var_3.angles = var_6.angles;
  var_3 setModel("cop_marker_scriptable");
  var_3 setscriptablepartstate("marker", "heliLight");
  var_3 linkTo(var_6, "tag_origin", (0, 0, -60), (-90, 0, 0));
  var_6 thread scripts\common\anim::anim_single_solo(var_6, "rappel_hackney_infil_bravo");
}

function applymapvisionset() {
  switch (level.mapname) {
    case "mp_spear_pm":
      self visionsetnakedforplayer("infil_spear_pm", 0);
      break;
    default:
      return;
  }
}

function removemapvisionset() {
  self endon("player_free_spot");
  wait 1.5;
  self visionsetnakedforplayer("", 1);
}

function getcommanderassets(var_0) {
  var_1 = spawnStruct();

  if(var_0 == "axis") {
    var_1.body = "body_russian_helicopter_pilot";
    var_1.head = "head_russian_helicopter_pilot_opaque";
  } else {
    var_1.body = "body_mp_helicopter_crew";
    var_1.head = "head_mp_helicopter_crew";
  }

  return var_1;
}

function outsideheli(var_0) {
  if(!isDefined(var_0)) {
    return;
  }

  if(isDefined(var_0.player)) {
    var_1 = var_0.player;
  } else {
    var_1 = var_1;
  }

  thread clear_infil_ambient_zone();
  thread removemapvisionset();
}