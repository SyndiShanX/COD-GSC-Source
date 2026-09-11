/**********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\infilexfil\rappel_hackney_infil.gsc
**********************************************************/

function rappel_hackney_init(var0) {
  initanims(var0);
  var1 = [];
  GscBinSkip0(0x2e, 0, [0, 1]);
}

function rappel_hackney_spawn(var0, var1, var2, var3) {
  var4 = scripts\engine\utility::getStruct(var1, "targetname");
  var5 = spawn("script_origin", var4.origin);
  var5.angles = var4.angles;
  var5.scene_node = var4;
  thread infilthink(var5, var0);
  return var5;
}

function rappel_hackney_get_length(var0) {
  var1 = getanimlength(level.scr_anim["slot_0"]["rappel_hackney_infil_" + var0]);
  return var1;
}

function player_rappel_hackney_infil_think(var0, var1) {
  self endon("player_free_spot");

  if(isPlayer(self)) {
    self setclienttriggeraudiozone("hackney_infil_heli_intro", 1);
  }

  applymapvisionset();
  thread scripts\mp\infilexfil\infilexfil::infil_scene_fade_in(0, 0.55);
  thread player_infil_end();
  thread heli_infil_radio_idle();
  var2 = var0.linktoent gettagorigin("origin_animate_jnt");
  var3 = var0.linktoent gettagangles("origin_animate_jnt");
  thread scripts\mp\utility\infilexfil::infil_player_rig_updated("slot_" + var1, var2, var3);
  self.player_rig linkTo(var0.linktoent, "origin_animate_jnt", (0, 0, 0), (0, 0, 0));
  var0.linktoent scripts\common\anim::anim_first_frame_solo(self.player_rig, "rappel_hackney_infil_" + var0.subtype);
  thread player_rappel_disconnect();
  self.manualoverridewindmaterial = 1;
  self setscriptablepartstate("wind", "100", 0);
  self setdemeanorviewmodel("safe", "iw8_ges_demeanor_safe_heli");
  scripts\mp\flags::gameflagwait("infil_started");
  self lerpfovscalefactor(0, 0);

  if(var1 == 0) {
    self lerpfovbypreset("80_instant");
  }

  if(isDefined(self.team) && self.team != "spectator") {
    var4 = [];
    GscBinSkip0(0x2e, var4.size, "mp_infil_mix_musicheavy");
  }

  if(isDefined(self.animname) && isPlayer(self)) {
    var8 = "scn_infil_hackney_heli_plr1";

    if(isDefined(var1.subtype)) {
      if(var1.subtype == "alpha") {
        switch (self.animname) {
          case "slot_0":
            var8 = "scn_infil_hackney_heli_plr1";
            break;
          case "slot_1":
            var8 = "scn_infil_hackney_heli_plr2";
            break;
          case "slot_2":
            var8 = "scn_infil_hackney_heli_plr3";
            break;
          default:
            var8 = "scn_infil_hackney_heli_plr1";
            break;
        }
      } else {
        switch (self.animname) {
          case "slot_0":
            var8 = "scn_infil_hackney_heli_plr4";
            break;
          case "slot_1":
            var8 = "scn_infil_hackney_heli_plr5";
            break;
          case "slot_2":
            var8 = "scn_infil_hackney_heli_plr6";
            break;
          default:
            var8 = "scn_infil_hackney_heli_plr4";
            break;
        }
      }
    }

    self setclienttriggeraudiozone("hackney_infil_heli", 2);
    self playlocalsound(var8);
  }

  self setcinematicmotionoverride("disabled");
  thread player_normal_think(var1);
}

function player_normal_think(var0) {
  self endon("player_free_spot");
  self lerpviewangleclamp(1, 0.25, 0.25, 30, 30, 30, 10);
  var0.linktoent scripts\mp\anim::anim_player_solo(self, self.player_rig, "rappel_hackney_infil_" + var0.subtype);

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
    var0 = spawn("script_origin", (0, 0, 0));
    var0 showonlytoplayer(self);

    if(isDefined(self.team)) {
      var1 = scripts\mp\utility\teams::getteamvoiceinfix(self.team);
      var2 = "dx_mpo_" + var1 + "op_drone_deathchatter";
    } else {
      var2 = "dx_mpo_usop_drone_deathchatter";
    }

    if(soundexists(var2)) {
      var2 playLoopSound(var2);
    } else {
      var2 playLoopSound("dx_mpo_usop_drone_deathchatter");
    }

    scripts\mp\flags::gameflagwait("infil_started");
    wait 2;
    var2 stoploopsound(var2);
    var2 delete();
    return;
  }
}

function player_interactive_think(var0) {
  self endon("player_free_spot");
  self.player_rig linkTo(var0.linktoent, "origin_animate_jnt", (0, 0, 0), (0, 0, 0));
  self lerpviewangleclamp(1, 0.25, 0.25, 80, 80, 30, 70);
  var0 scripts\mp\anim::anim_player_solo(self, self.player_rig, "rappel_hackney_infil_" + var0.subtype + "_interactive_intro");
  thread combat_start();
  wait 15;
  thread combat_end();

  if(!isai(self)) {
    scripts\mp\utility\infilexfil::givegunless();
  }

  self lerpviewangleclamp(1, 0.25, 0.25, 0, 0, 0, 0);
  var0.linktoent scripts\mp\anim::anim_player_solo(self, self.player_rig, "rappel_hackney_infil_" + var0.subtype + "_interactive_exit");

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

function spawnactors(var0, var1, var2) {
  if(!isDefined(self.actors)) {
    self.actors = [];
  }

  var3 = getcommanderassets(var0);
  self.actors[self.actors.size] = spawn_anim_model(self.linktoent, "commander", "origin_animate_jnt", var3.body, var3.head);
  self.actors[self.actors.size] = spawn_anim_model(self.linktoent, "pilot", "origin_animate_jnt", "body_pilot_helicopter_british", "head_pilot_helicopter_british");
  self.actors[self.actors.size] = spawn_anim_model(self.linktoent, "copilot", "origin_animate_jnt", "body_pilot_helicopter_british", "head_mp_helicopter_crew");

  foreach(var5 in self.actors) {
    var5.infil = self;
  }

  scripts\mp\flags::gameflagwait("infil_started");
  self.actors[0].anim_playsound_func = &blima_commander_play_sound_func;
}

function infilthink(var0, var1) {
  var2 = getdvarfloat("NMORQOTSK", 0.2);

  foreach(var4 in getEntArray("infil_delete", "script_noteworthy")) {
    var4 delete();
  }

  thread helithink(var0, self.scene_node, var1);
  thread actorthink(var0, self.scene_node, var1);
  scripts\mp\flags::gameflagwait("infil_started");
  setDvar("TLMMOPMSK", 1);
  setDvar("NMORQOTSK", 1);

  if(level.prematchperiodend > self.infillength) {
    wait level.prematchperiodend - self.infillength;
  }

  level waittill("prematch_over");
  setDvar("TLMMOPMSK", 0);
  setDvar("NMORQOTSK", var2);
}

function helithink(var0, var1, var2) {
  spawnheli(var1, var0, var2);
  scripts\common\anim::anim_first_frame_solo(self.linktoent, "rappel_hackney_infil_" + var2);
  scripts\mp\flags::gameflagwait("infil_started");
  self.linktoent setscriptablepartstate("engine", "on", 0);
  self.linktoent setscriptablepartstate("running_lights", "on", 0);
  self.linktoent setscriptablepartstate("infil_lights", "on", 0);
  thread heli_normal_think(var0, var1, var2);
  thread heli_interior_sfx(var2);
}

function heli_interior_sfx(var0) {
  var1 = spawn("script_model", self.linktoent.origin);
  var2 = spawn("script_model", self.linktoent.origin);
  var2 linkTo(self.linktoent, "tag_light_cockpit01");
  wait 0.1;

  if(var0 == "alpha") {
    self.linktoent playsoundonmovingent("scn_mp_hackney_heli1_lr");
    var1 linkTo(self.linktoent, "j_tied_cable_02");
    wait 0.1;
    var1 playsoundonmovingent("scn_infil_hackney_heli1_ceiling_rattles");
    var2 playsoundonmovingent("scn_infil_hackney_heli1_cockpit_rattles");
  } else {
    self.linktoent playsoundonmovingent("scn_mp_hackney_heli2_lr");
    var1 linkTo(self.linktoent, "j_ceiling_cable_02");
    wait 0.1;
    var1 playsoundonmovingent("scn_infil_hackney_heli2_ceiling_rattles");
    var2 playsoundonmovingent("scn_infil_hackney_heli2_cockpit_rattles");
  }

  level waittill("prematch_over");
  var1 delete();
  var2 delete();
}

function heli_interactive_think(var0, var1, var2) {
  thread scripts\common\anim::anim_single_solo(self.linktoent, "rappel_hackney_infil_" + var2 + "_interactive");
  wait level.interactivecombatduration - 15;
  thread ropethink(var2);
  wait 15;
  cleanup();
}

function heli_normal_think(var0, var1, var2) {
  thread ropethink(var2);

  if(isDefined(self.path)) {
    thread scripts\common\anim::anim_single_solo(self.linktoent, "rappel_hackney_infil_" + var2);
    vehiclethinkpath(var0, var1, var2);
  } else {
    thread scripts\common\anim::anim_single_solo(self.linktoent, "rappel_hackney_infil_" + var2);
    var3 = getanimlength(level.scr_anim[self.linktoent.animname]["rappel_hackney_infil_" + var2]);
    wait var3;
  }

  cleanup();
}

function ropethink(var0) {
  self.linktoent thread scripts\common\anim::anim_single_solo(self.linktoent.rope, "rappel_hackney_infil_" + var0, "origin_animate_jnt");
  var1 = getanimlength(level.scr_anim[self.linktoent.rope.animname]["rappel_hackney_infil_" + var0]);
  wait var1;
  self.linktoent.rope unlink();
  thread scripts\common\anim::anim_single_solo(self.linktoent.rope, "rappel_hackney_infil_" + var0 + "_fall");
}

function ref_13293(var0) {
  var0 playsoundonmovingent("scn_infil_hackney_heli1_rope");
}

function ref_13294(var0) {
  var0 playsoundonmovingent("scn_infil_hackney_heli2_rope");
}

function actorthink(var0, var1, var2, var3) {
  thread spawnactors(var0, var2, var3);
  actor_normal_think(var0, var1, var2);
}

function actor_interactive_think(var0, var1, var2) {
  self.linktoent scripts\common\anim::anim_first_frame(self.actors, "rappel_hackney_infil_" + var2 + "_interactive", "origin_animate_jnt");
  scripts\mp\utility\infilexfil::hideactors();
  level waittill("infil_started");
  scripts\mp\utility\infilexfil::showactors();
  self.linktoent thread scripts\common\anim::anim_single(self.actors, "rappel_hackney_infil_" + var2 + "_interactive", "origin_animate_jnt");
  self.actors[0].head scriptmodelplayanim(level.scr_anim[self.actors[0].animname]["rappel_hackney_infil_" + var2 + "_interactive"]);
}

function actor_normal_think(var0, var1, var2) {
  self.linktoent scripts\common\anim::anim_first_frame(self.actors, "rappel_hackney_infil_" + var2, "origin_animate_jnt");
  scripts\mp\utility\infilexfil::hideactors();
  scripts\mp\flags::gameflagwait("infil_started");
  scripts\mp\utility\infilexfil::showactors();
  self.linktoent thread scripts\common\anim::anim_single(self.actors, "rappel_hackney_infil_" + var2, "origin_animate_jnt");
  self.actors[0].head scriptmodelplayanim(level.scr_anim[self.actors[0].animname]["rappel_hackney_infil_" + var2]);
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

function initanims(var0) {
  script_model_alpha_anims(var0);
  vehicles_alpha_anims(var0);

  if(!isDefined(level.scr_notetrack) || !isDefined(level.scr_notetrack["commander"])) {
    scripts\common\anim::addnotetrack_customfunction("commander", "door_slam", &blima_door_slam);
    scripts\common\anim::addnotetrack_customfunction("commander", "shake_low", &blima_cam_shake_low);
    scripts\common\anim::addnotetrack_customfunction("commander", "shake_bump", &blima_cam_shake_bump);
    scripts\common\anim::addnotetrack_customfunction("commander", "door_open_sfx", &heli_door_open_sfx);
    scripts\common\anim::addnotetrack_customfunction("commander", "sfx_infil_hackney_heli_commander", &heli_commander_sfx);
    scripts\common\anim::addnotetrack_customfunction("commander", "scn_infil_hackney_heli1_rope", &ref_13293);
    scripts\common\anim::addnotetrack_customfunction("commander", "scn_infil_hackney_heli2_rope", &ref_13294);
  }

  switch (var0) {
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

function script_model_alpha_anims(var0) {
  switch (var0) {
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

function vehicles_alpha_anims(var0) {
  switch (var0) {
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

function spawnheli(var0, var1, var2) {
  var3 = "blima_desert_day_infil_mp";

  if(level.mapname == "mp_hackney_yard") {
    var3 = "blima_hackney_infil_mp";
  }

  var4 = spawnVehicle("veh8_mil_air_blima_infils", var2, var3, var0.origin, var0.angles);
  var4 setvehicleteam(var1);
  var4 setCanDamage(0);
  var4.animname = "blima";
  self.linktoent = var4;
  var4.infil = self;
  self.linktoent.rope = spawn_anim_model(self.linktoent, "rope", "origin_animate_jnt", "equipment_fast_rope_wm_01_infil_heli_l");
  self.linktoent.rope scripts\common\anim::anim_first_frame_solo(self.linktoent.rope, "rappel_hackney_infil_" + var2);
  return var4;
}

function helifollowpath(var0) {
  if(!isDefined(var0)) {
    return;
  }

  var1 = scripts\engine\utility::getStruct(var0, "targetname");

  if(!isDefined(var1)) {
    return;
  }

  var2 = scripts\engine\utility::getStruct(var1.target, "targetname");
  self.speed = 500;
  self.accel = 175;
  self.combatmode = "guard_location";
  self notify(self.combatmode);

  while(isDefined(var1.target)) {
    thread scripts\mp\killstreaks\jackal::guardpositionescort(var2.origin, undefined, 800);

    for(;;) {
      var3 = distance(self.origin, var2.origin);

      if(var3 < 2000) {
        break;
      }

      waitframe();
    }

    self notify("leaving");

    if(!isDefined(var2.target)) {
      break;
    }

    var1 = var2;
    var2 = scripts\engine\utility::getStruct(var1.target, "targetname");
  }
}

function cleanup() {
  foreach(var1 in self.actors) {
    var1 delete();
  }

  self.linktoent.rope delete();
  self.linktoent delete();
  level.stop_station_closed_vo--;
  self delete();
}

function spawn_infil_axis_ai(var0, var1, var2, var3) {
  level.gameskill = 0;
  var4 = scripts\mp\mp_agent::spawnnewagent("soldier_agent", "axis", var1, var2, scripts\engine\utility::ter_op(isDefined(var3), var3, "iw8_ar_mike4_mp"));

  if(!isDefined(var4)) {
    return undefined;
  }

  var4.desiredmovetype = "combat";
  var4 clearpath();
  var4.goalradius = 999;
  var4.fixednode = 0;
  var4 scripts\mp\agents\agent_common::set_agent_health(50);
  return var4;
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
  var0 = scripts\engine\utility::getStructArray("ai_alpha_start", "targetname");
  var1 = scripts\engine\utility::getStructArray("ai_alpha_respawn", "targetname");

  foreach(var5, var3 in var0) {
    var4 = spawn_infil_axis_ai("alpha", var3.origin, var3.angles);

    if(isDefined(var4)) {
      thread alpha_ai_array_handler(level);
    }
  }

  for(;;) {
    if(level.alphaagents.size < 5) {
      var6 = randomint(var1.size);

      if(randomint(100) > 75) {
        var7 = "iw8_la_rpapa7_mp";
      } else {
        var7 = undefined;
      }

      var5 = spawn_infil_axis_ai("alpha", var2[var7].origin, var2[var7].angles, var7);

      if(isDefined(var5)) {
        thread alpha_ai_array_handler(level, var5);
      }
    }

    waitframe();
  }
}

function alpha_ai_array_handler(var0, var1) {
  level.alphaagents = scripts\engine\utility::array_add(level.alphaagents, var0);
  var2 = scripts\mp\utility\outline::outlineenableforteam(var0, "allies", scripts\engine\utility::ter_op(isDefined(var1), "outline_depth_red", "outline_depth_orange"), "level_script");
  var0 waittill("death");
  scripts\mp\utility\outline::outlinedisable(var2, var0);
  level.alphaagents = scripts\engine\utility::array_remove(level.alphaagents, var0);
}

function bravoai() {
  level endon("interactive_infil_complete");
  level endon("prematch_over");
  level endon("infil_done");
  level.bravoagents = [];
  var0 = scripts\engine\utility::getStructArray("ai_bravo_start", "targetname");
  var1 = scripts\engine\utility::getStructArray("ai_bravo_respawn", "targetname");

  foreach(var5, var3 in var0) {
    var4 = spawn_infil_axis_ai("bravo", var3.origin, var3.angles);

    if(isDefined(var4)) {
      thread bravo_ai_array_handler(level);
    }
  }

  for(;;) {
    if(level.bravoagents.size < 5) {
      var6 = randomint(var1.size);

      if(randomint(100) > 75) {
        var7 = "iw8_la_rpapa7_mp";
      } else {
        var7 = undefined;
      }

      var5 = spawn_infil_axis_ai("bravo", var2[var7].origin, var2[var7].angles, var7);

      if(isDefined(var5)) {
        thread bravo_ai_array_handler(level, var5);
      }
    }

    waitframe();
  }
}

function bravo_ai_array_handler(var0, var1) {
  level.bravoagents = scripts\engine\utility::array_add(level.bravoagents, var0);
  var2 = scripts\mp\utility\outline::outlineenableforteam(var0, "allies", scripts\engine\utility::ter_op(isDefined(var1), "outline_depth_red", "outline_depth_orange"), "level_script");
  var0 waittill("death");
  scripts\mp\utility\outline::outlinedisable(var2, var0);
  level.bravoagents = scripts\engine\utility::array_remove(level.bravoagents, var0);
}

function cleanupinteractiveinfilai() {
  var0 = getanimlength(level.scr_anim["slot_0"]["rappel_hackney_infil_alpha_interactive_intro"]);
  var0 += 15;
  wait var0;

  foreach(var2 in level.alphaagents) {
    if(isalive(var2)) {
      var2 kill();
    }
  }

  foreach(var2 in level.bravoagents) {
    if(isalive(var2)) {
      var2 kill();
    }
  }
}

function agent_handledamagefeedback(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11) {
  if(isDefined(var1) && var1.team != "axis") {
    var1 scripts\mp\damagefeedback::updatedamagefeedback("", var2 >= self.health);

    if(var2 >= self.health) {
      if(!isDefined(var1.infilscore)) {
        var1.infilscore = 1;
      } else {
        var1.infilscore++;
      }

      if(var1.infilscore > level.highestinfilscore) {
        updatehighinfilscore(level, var1);
        return;
      }

      return;
    }

    return;
  }
}

function blima_door_slam(var0) {
  foreach(var2 in var0.infil.players) {
    var2 earthquakeforplayer(randomfloatrange(0.135, 0.15), 2, self.origin, 8000);
    var2 playrumbleonpositionforclient("ground_pound_land", var2.origin);
  }
}

function blima_cam_shake_low(var0) {
  foreach(var2 in var0.infil.players) {
    var2 scripts\mp\utility\infilexfil::updateshakeonplayer(0.06, 0.075, 2, var2.origin, 8000, "mig_rumble", 0.05, 0.1);
  }
}

function blima_cam_shake_bump(var0) {
  foreach(var2 in var0.infil.players) {
    var2 scripts\mp\utility\infilexfil::updateshakeonplayer(0.145, 0.16, 2, var2.origin, 8000, "pistol_fire", 0.05, 0.15);
  }
}

function heli_door_open_sfx(var0) {
  if(var0.infil.subtype == "alpha") {
    var1 = spawn("script_origin", var0.infil.linktoent.origin);
    var1 linkTo(var0.infil.linktoent, "side_door_l_jnt");
    var1 playSound("scn_infil_hackney_heli1_door_open");
    wait 3;
    var1 delete();
    return;
  }

  var1 = spawn("script_origin", var1.infil.linktoent.origin);
  var1 linkTo(var1.infil.linktoent, "side_door_r_jnt");
  var1 playSound("scn_infil_hackney_heli2_door_open");
  wait 3;
  var1 delete();
}

function heli_commander_sfx(var0) {
  if(var0.infil.subtype == "alpha") {
    var0 playsoundonmovingent("scn_infil_hackney_heli1_commander");
    return;
  }

  var0 playsoundonmovingent("scn_infil_hackney_heli2_commander");
}

function ref_12eee(var0) {
  var0 playsoundonmovingent("scn_infil_hackney_heli_npc1");
}

function ref_12eef(var0) {
  var0 playsoundonmovingent("scn_infil_hackney_heli_npc2");
}

function ref_12ef0(var0) {
  var0 playsoundonmovingent("scn_infil_hackney_heli_npc3");
}

function ref_12ef1(var0) {
  var0 playsoundonmovingent("scn_infil_hackney_heli_npc4");
}

function ref_12ef2(var0) {
  var0 playsoundonmovingent("scn_infil_hackney_heli_npc5");
}

function ref_12ef3(var0) {
  var0 playsoundonmovingent("scn_infil_hackney_heli_npc6");
}

function blima_rumble_rope(var0) {
  level endon("prematch_over");
  level endon("infil_done");
  var1 = var0.player;
  var1 notify("stop_cam_shake");
  var1 endon("stop_cam_shake");
  var1 endon("death_or_disconnect");

  for(;;) {
    var1 playrumbleonpositionforclient("pistol_fire", var1.origin);
    wait randomfloatrange(0.05, 0.15);
  }
}

function blima_rumble_ground(var0) {
  var1 = var0.player;
  var1 notify("stop_cam_shake");
  var1 playRumbleOnEntity("ground_pound_land");
  var1 lerpfovscalefactor(1, 0.5);
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

function blima_commander_play_sound_func(var0, var1, var2) {
  foreach(var4 in self.infil.players) {
    var4 playsoundtoplayer(var0, var4);
  }
}

function vehiclethinkpath(var0, var1, var2) {
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
  var0 = getcompleteweaponname("iw8_lm_kilo121infil_mp", ["acog_west01"]);
  scripts\cp_mp\utility\inventory_utility::_giveweapon(var0, undefined, undefined, 1);
  scripts\common\utility::allow_weapon_switch(1);
  var1 = scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(var0, 0);

  if(var1) {
    self.infilweapon = var0;
    scripts\common\utility::allow_weapon_switch(0);
    scripts\mp\utility\weapon::setrecoilscale(0, 50);
  } else {
    scripts\cp_mp\utility\inventory_utility::_takeweapon(var0);
    scripts\cp_mp\utility\inventory_utility::forcevalidweapon();
  }

  return var1;
}

function updatehighinfilscore(var0) {
  level.highestinfilname = var0.name;
  level.highestinfilscore = var0.infilscore;

  foreach(var2 in level.players) {
    if(var2.team == "allies") {
      var2 iprintlnbold(level.highestinfilname + " is in the lead with" + level.highestinfilscore + " kills");
    }
  }
}

function announceinfilwinner() {
  level waittill("interactive_infil_complete");

  if(!isDefined(level.highestinfilname)) {
    return;
  }

  foreach(var1 in level.players) {
    if(var1.team == "allies") {
      var1 iprintlnbold(level.highestinfilname + " won with" + level.highestinfilscore + " kills");
    }
  }
}

function dummychopper() {
  var0 = (1325, -1200, 30);
  var1 = (0, 90, 0);
  var2 = spawnVehicle("veh8_mil_air_blima", "alpha", "blima_hackney_infil_mp", var0, var1);
  var2 setvehicleteam("allies");
  var2 setCanDamage(0);
  var2.animname = "blima";
  var2 setscriptablepartstate("engine", "on", 0);
  var3 = spawn("script_model", var2.origin);
  var3.angles = var2.angles;
  var3 setModel("cop_marker_scriptable");
  var3 setscriptablepartstate("marker", "heliLight");
  var3 linkTo(var2, "tag_origin", (0, 0, -60), (-90, 0, 0));
  var2 thread scripts\common\anim::anim_single_solo(var2, "rappel_hackney_infil_alpha");
  var4 = (525, -1460, 30);
  var5 = (0, 180, 0);
  var6 = spawnVehicle("veh8_mil_air_blima", "bravo", "blima_hackney_infil_mp", var4, var5);
  var6 setvehicleteam("allies");
  var6 setCanDamage(0);
  var6.animname = "blima";
  var6 setscriptablepartstate("engine", "on", 0);
  var3 = spawn("script_model", var6.origin);
  var3.angles = var6.angles;
  var3 setModel("cop_marker_scriptable");
  var3 setscriptablepartstate("marker", "heliLight");
  var3 linkTo(var6, "tag_origin", (0, 0, -60), (-90, 0, 0));
  var6 thread scripts\common\anim::anim_single_solo(var6, "rappel_hackney_infil_bravo");
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

function getcommanderassets(var0) {
  var1 = spawnStruct();

  if(var0 == "axis") {
    var1.body = "body_russian_helicopter_pilot";
    var1.head = "head_russian_helicopter_pilot_opaque";
  } else {
    var1.body = "body_mp_helicopter_crew";
    var1.head = "head_mp_helicopter_crew";
  }

  return var1;
}

function outsideheli(var0) {
  if(!isDefined(var0)) {
    return;
  }

  if(isDefined(var0.player)) {
    var1 = var0.player;
  } else {
    var1 = var1;
  }

  thread clear_infil_ambient_zone();
  thread removemapvisionset();
}