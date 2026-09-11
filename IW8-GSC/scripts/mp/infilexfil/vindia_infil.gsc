/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\infilexfil\vindia_infil.gsc
**************************************************/

function vindia_init(var_0) {
  initanims(var_0);
  var_1 = [];
  GscBinSkip0(0x2e, 0, [0]);
}

function vindia_spawn(var_0, var_1, var_2, var_3) {
  var_4 = scripts\engine\utility::getStruct(var_1, "targetname");
  var_5 = spawn("script_origin", var_4.origin);
  var_5.angles = var_4.angles;
  var_5.scene_node = var_4;
  thread infilthink(var_5, var_0);
  return var_5;
}

function vindia_get_length(var_0) {
  var_1 = getanimlength(level.scr_anim["slot_0"]["vindia_infil_intro"]);
  var_1 += getanimlength(level.scr_anim["slot_0"]["vindia_infil_exit"]);
  return var_1;
}

function player_vindia_infil_think(var_0, var_1) {
  self endon("player_free_spot");
  thread player_infil_end();
  thread scripts\mp\infilexfil\infilexfil::infil_player_rig("slot_" + var_1, "viewhands_base_iw8");
  self.player_rig.weapon_state_func = &scripts\mp\utility\infilexfil::handleweaponstatenotetrack;
  thread scripts\mp\infilexfil\infilexfil::infil_scene_fade_in(0, 0.55);
  thread player_van_disconnect();
  level waittill("start_scene");
  self setcinematicmotionoverride("disabled");
  self.player_rig linkTo(var_0.linktoent, "tag_body_animate", (0, 0, 0), (0, 0, 0));
  self setdemeanorviewmodel("safe", "iw8_ges_demeanor_safe_van");
  self lerpviewangleclamp(1, 0.25, 0.25, 60, 60, 30, 30);
  var_0.linktoent scripts\mp\anim::anim_player_solo(self, self.player_rig, "vindia_infil_intro", "tag_body_animate");
  self lerpviewangleclamp(1, 0.25, 0.25, 0, 0, 0, 0);
  thread clear_infil_ambient_zone();
  level notify("depthSortViewmodel_true");
  var_0.linktoent scripts\mp\anim::anim_player_solo(self, self.player_rig, "vindia_infil_exit", "tag_body_animate");

  if(isDefined(self.player_rig) && self.player_rig islinked()) {
    self.player_rig unlink();
  }

  self visionsetnakedforplayer("", 0.75);
  self setdemeanorviewmodel("normal");
  self clearcinematicmotionoverride();
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
  self endon("death_or_disconnect");

  if(isPlayer(self)) {
    self setclienttriggeraudiozone("hackney_infil_van_intro", 1);
    wait 0.5;
    self playlocalsound("infilintro_wolf_radio_loop");
    level waittill("infil_started");
    wait 4;
    self stoplocalsound("infilintro_wolf_radio_loop");
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

  self.commander = spawn_anim_model(self.linktoent, "commander", "tag_turret", "body_al_qatala_1_ar", "head_sc_finkelstein");
  self.commander.infil = self;
  self.actors[self.actors.size] = spawn_anim_model(self.linktoent, "driver", "tag_body_animate", "body_al_qatala_1_ar", "head_sc_finkelstein");

  foreach(var_4 in self.actors) {
    var_4.infil = self;
  }

  self.commander.anim_playsound_func = &commander_play_sound_func;
  self.actors[0].anim_playsound_func = &driver_play_sound_func;
}

function infilthink(var_0, var_1) {
  foreach(var_3 in getEntArray("infil_delete", "script_noteworthy")) {
    var_3 delete();
  }

  thread vehiclethink(var_0, self.scene_node, var_1);
  thread actorthink(var_0, self.scene_node, var_1);
  level waittill("infil_started");
  setDvar("TLMMOPMSK", 1);
  level notify("start_scene");
  level waittill("depthSortViewmodel_true");
  setDvar("NMLOKNMRSK", 1);
  level waittill("prematch_over");
  setDvar("TLMMOPMSK", 0);
  setDvar("NMLOKNMRSK", 0);

  while(isDefined(self.commander) || isDefined(self.actors)) {
    waitframe();
  }

  level.stop_station_closed_vo--;
  self delete();
}

function vehiclethink(var_0, var_1, var_2, var_3) {
  var_4 = spawninfilvehicle(var_1, var_0, var_2);
  scripts\common\anim::anim_first_frame_solo(var_4, "vindia_infil_intro");
  level waittill("infil_started");
  var_4.interiorlights[0] setscriptablepartstate("marker", "vanLight");
  scripts\common\anim::anim_single_solo(var_4, "vindia_infil_intro");
  scripts\common\anim::anim_single_solo(var_4, "vindia_infil_outro_leftrightreardoor");

  foreach(var_6 in var_4.interiorlights) {
    var_6 delete();
  }

  level waittill("prematch_over");
  game["infil"]["types"][self.type][var_2]["persistentVehicle"] = &spawnpersistentvehicle;
  game["infil"]["types"][self.type][var_2]["vehicleOrg"] = self.linktoent.origin;
  game["infil"]["types"][self.type][var_2]["vehicleAng"] = self.linktoent.angles;
}

function spawnpersistentvehicle(var_0, var_1) {
  var_2 = game["infil"]["types"][var_0][var_1]["vehicleOrg"];
  var_3 = game["infil"]["types"][var_0][var_1]["vehicleAng"];
  var_4 = spawn("script_model", var_2);
  var_4.angles = var_3;
  var_4 setModel("veh8_mil_lnd_vindia_a1");
  var_4.animname = "vindia";
  var_4 scripts\common\anim::setanimtree();
  var_5 = spawn("script_model", var_2);
  var_5.angles = var_3;
  var_5 setModel("veh8_mil_lnd_vindia_a1_turret");
  var_5 linkTo(var_4, "tag_turret", (0, 0, 0), (0, 0, 0));
  var_4.turret = var_5;
}

function van_interior_sfx(var_0) {
  var_1 = spawn("script_model", self.linktoent.origin);
  var_1 linkTo(self.linktoent, "tag_trunk_hint_outside");
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

function actorthink(var_0, var_1, var_2, var_3) {
  thread spawnactors(var_0, var_2, var_3);
  self.linktoent scripts\common\anim::anim_first_frame_solo(self.commander, "vindia_infil", "tag_turret");
  self.linktoent scripts\common\anim::anim_first_frame(self.actors, "vindia_infil", "tag_body_animate");
  self.commander hide();
  scripts\mp\utility\infilexfil::hideactors();
  level waittill("infil_started");
  self.commander show();
  scripts\mp\utility\infilexfil::showactors();
  self.linktoent thread scripts\common\anim::anim_single_solo(self.commander, "vindia_infil", "tag_turret");
  self.commander.head scriptmodelplayanim(level.scr_anim[self.commander.animname]["vindia_infil"]);
  self.linktoent thread scripts\common\anim::anim_single(self.actors, "vindia_infil", "tag_body_animate");
  var_4 = getanimlength(level.scr_anim["commander"]["vindia_infil"]);
  wait var_4;
  self.commander delete();
  self.commander = undefined;

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
  scripts\common\anim::addnotetrack_customfunction("slot_0", "player_lock_look_1_second", &scripts\mp\utility\infilexfil::player_lock_look_1_second, "vindia_infil_intro");
  scripts\common\anim::addnotetrack_customfunction("slot_1", "player_lock_look_1_second", &scripts\mp\utility\infilexfil::player_lock_look_1_second, "vindia_infil_intro");
  scripts\common\anim::addnotetrack_customfunction("slot_2", "player_lock_look_1_second", &scripts\mp\utility\infilexfil::player_lock_look_1_second, "vindia_infil_intro");
  scripts\common\anim::addnotetrack_customfunction("slot_3", "player_lock_look_1_second", &scripts\mp\utility\infilexfil::player_lock_look_1_second, "vindia_infil_intro");
  scripts\common\anim::addnotetrack_customfunction("slot_4", "player_lock_look_1_second", &scripts\mp\utility\infilexfil::player_lock_look_1_second, "vindia_infil_intro");
  scripts\common\anim::addnotetrack_customfunction("slot_5", "player_lock_look_1_second", &scripts\mp\utility\infilexfil::player_lock_look_1_second, "vindia_infil_intro");
  scripts\common\anim::addnotetrack_customfunction("slot_0", "free_look", &scripts\mp\utility\infilexfil::player_free_look, "vindia_infil_exit");
  scripts\common\anim::addnotetrack_customfunction("slot_1", "free_look", &scripts\mp\utility\infilexfil::player_free_look, "vindia_infil_exit");
  scripts\common\anim::addnotetrack_customfunction("slot_2", "free_look", &scripts\mp\utility\infilexfil::player_free_look, "vindia_infil_exit");
  scripts\common\anim::addnotetrack_customfunction("slot_3", "free_look", &scripts\mp\utility\infilexfil::player_free_look, "vindia_infil_exit");
  scripts\common\anim::addnotetrack_customfunction("slot_4", "free_look", &scripts\mp\utility\infilexfil::player_free_look, "vindia_infil_exit");
  scripts\common\anim::addnotetrack_customfunction("slot_5", "free_look", &scripts\mp\utility\infilexfil::player_free_look, "vindia_infil_exit");
}

#using_animtree("");

function script_model_alpha_anims() {
  level.scr_animtree["driver"] = #animtree;
  level.scr_anim["driver"]["vindia_infil"] = $mp_infil_vindia_driver;
  level.scr_animname["driver"]["vindia_infil"] = "mp_infil_vindia_driver";
  level.scr_animtree["commander"] = #animtree;
  level.scr_anim["commander"]["vindia_infil"] = % mp_infil_vindia_chief;
  level.scr_animname["commander"]["vindia_infil"] = "mp_infil_vindia_chief";
  level.scr_animtree["vindia"] = #animtree;
  level.scr_anim["vindia"]["vindia_infil_intro"] = % mp_infil_vindia_veh_intro;
  level.scr_animname["vindia"]["vindia_infil_intro"] = "mp_infil_vindia_veh_intro";
  level.scr_anim["vindia"]["vindia_infil_outro_leftrightreardoor"] = % mp_infil_vindia_veh_outro_leftrightreardoor;
  level.scr_animname["vindia"]["vindia_infil_outro_leftrightreardoor"] = "mp_infil_vindia_veh_outro_leftrightreardoor";
  level.scr_anim["vindia"]["vindia_infil_outro_leftreardoor"] = % mp_infil_vindia_veh_outro_leftreardoor;
  level.scr_animname["vindia"]["vindia_infil_outro_leftreardoor"] = "mp_infil_vindia_veh_outro_leftreardoor";
  level.scr_anim["vindia"]["vindia_infil_outro_reardoor"] = % mp_infil_vindia_veh_outro_reardoor;
  level.scr_animname["vindia"]["vindia_infil_outro_reardoor"] = "mp_infil_vindia_veh_outro_reardoor";
  level.scr_animtree["slot_0"] = #animtree;
  level.scr_anim["slot_0"]["vindia_infil_intro"] = % mp_infil_vindia_guy1_intro_wm;
  level.scr_animname["slot_0"]["vindia_infil_intro"] = "mp_infil_vindia_guy1_intro_wm";
  level.scr_eventanim["slot_0"]["vindia_infil_intro"] = "infil_vindia_intro_1";
  level.scr_anim["slot_0"]["vindia_infil_exit"] = % mp_infil_vindia_guy1_exit_wm;
  level.scr_animname["slot_0"]["vindia_infil_exit"] = "mp_infil_vindia_guy1_exit_wm";
  level.scr_eventanim["slot_0"]["vindia_infil_exit"] = "infil_vindia_exit_1";
  level.scr_viewmodelanim["slot_0"]["vindia_infil_exit"] = "mp_infil_vindia_guy1_exit_vm";
  level.scr_animtree["slot_1"] = #animtree;
  level.scr_anim["slot_1"]["vindia_infil_intro"] = % mp_infil_vindia_guy2_intro_wm;
  level.scr_animname["slot_1"]["vindia_infil_intro"] = "mp_infil_vindia_guy2_intro_wm";
  level.scr_eventanim["slot_1"]["vindia_infil_intro"] = "infil_vindia_intro_2";
  level.scr_anim["slot_1"]["vindia_infil_exit"] = % mp_infil_vindia_guy2_exit_wm;
  level.scr_animname["slot_1"]["vindia_infil_exit"] = "mp_infil_vindia_guy2_exit_wm";
  level.scr_eventanim["slot_1"]["vindia_infil_exit"] = "infil_vindia_exit_2";
  level.scr_animtree["slot_2"] = #animtree;
  level.scr_anim["slot_2"]["vindia_infil_intro"] = % mp_infil_vindia_guy3_intro_wm;
  level.scr_animname["slot_2"]["vindia_infil_intro"] = "mp_infil_vindia_guy3_intro_wm";
  level.scr_eventanim["slot_2"]["vindia_infil_intro"] = "infil_vindia_intro_3";
  level.scr_anim["slot_2"]["vindia_infil_exit"] = % mp_infil_vindia_guy3_exit_wm;
  level.scr_animname["slot_2"]["vindia_infil_exit"] = "mp_infil_vindia_guy3_exit_wm";
  level.scr_eventanim["slot_2"]["vindia_infil_exit"] = "infil_vindia_exit_3";
  level.scr_animtree["slot_3"] = #animtree;
  level.scr_anim["slot_3"]["vindia_infil_intro"] = % mp_infil_vindia_guy4_intro_wm;
  level.scr_animname["slot_3"]["vindia_infil_intro"] = "mp_infil_vindia_guy4_intro_wm";
  level.scr_eventanim["slot_3"]["vindia_infil_intro"] = "infil_vindia_intro_4";
  level.scr_anim["slot_3"]["vindia_infil_exit"] = % mp_infil_vindia_guy4_exit_wm;
  level.scr_animname["slot_3"]["vindia_infil_exit"] = "mp_infil_vindia_guy4_exit_wm";
  level.scr_eventanim["slot_3"]["vindia_infil_exit"] = "infil_vindia_exit_4";
  level.scr_animtree["slot_4"] = #animtree;
  level.scr_anim["slot_4"]["vindia_infil_intro"] = % mp_infil_vindia_guy5_intro_wm;
  level.scr_animname["slot_4"]["vindia_infil_intro"] = "mp_infil_vindia_guy5_intro_wm";
  level.scr_eventanim["slot_4"]["vindia_infil_intro"] = "infil_vindia_intro_5";
  level.scr_anim["slot_4"]["vindia_infil_exit"] = % mp_infil_vindia_guy5_exit_wm;
  level.scr_animname["slot_4"]["vindia_infil_exit"] = "mp_infil_vindia_guy5_exit_wm";
  level.scr_eventanim["slot_4"]["vindia_infil_exit"] = "infil_vindia_exit_5";
  level.scr_viewmodelanim["slot_4"]["vindia_infil_exit"] = "mp_infil_vindia_guy5_exit_vm";
  level.scr_animtree["slot_5"] = #animtree;
  level.scr_anim["slot_5"]["vindia_infil_intro"] = % mp_infil_vindia_guy6_intro_wm;
  level.scr_animname["slot_5"]["vindia_infil_intro"] = "mp_infil_vindia_guy6_intro_wm";
  level.scr_eventanim["slot_5"]["vindia_infil_intro"] = "infil_vindia_intro_6";
  level.scr_anim["slot_5"]["vindia_infil_exit"] = % mp_infil_vindia_guy6_exit_wm;
  level.scr_animname["slot_5"]["vindia_infil_exit"] = "mp_infil_vindia_guy6_exit_wm";
  level.scr_eventanim["slot_5"]["vindia_infil_exit"] = "infil_vindia_exit_6";
  level.scr_viewmodelanim["slot_5"]["vindia_infil_exit"] = "mp_infil_vindia_guy6_exit_vm";
}

function vehicles_alpha_anims() {}

function spawninfilvehicle(var_0, var_1, var_2) {
  var_3 = spawn("script_model", var_0.origin);
  var_3.angles = var_0.angles;
  var_3 setModel("veh8_mil_lnd_vindia_a1");
  var_3.animname = "vindia";
  var_3 scripts\common\anim::setanimtree();
  var_3 setCanDamage(0);
  var_4 = spawn("script_model", var_0.origin);
  var_4.angles = var_0.angles;
  var_4 setModel("veh8_mil_lnd_vindia_a1_turret");
  var_4 linkTo(var_3, "tag_turret", (0, 0, 0), (0, 0, 0));
  var_3.turret = var_4;
  self.linktoent = var_3;
  var_3.infil = self;
  var_5 = [];
  var_6 = spawn("script_model", var_3.origin);
  var_6.angles = var_3.angles;
  var_6 setModel("cop_marker_scriptable");
  var_6 linkTo(var_3, "tag_body_animate", (-60, 0, 32), (-90, 0, 0));
  var_5 = var_6;
  var_3.interiorlights = var_5;
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