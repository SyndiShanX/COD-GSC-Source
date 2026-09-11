/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\infilexfil\vindia_infil.gsc
**************************************************/

function vindia_init(var0) {
  initanims(var0);
  var1 = [];
  GscBinSkip0(0x2e, 0, [0]);
}

function vindia_spawn(var0, var1, var2, var3) {
  var4 = scripts\engine\utility::getStruct(var1, "targetname");
  var5 = spawn("script_origin", var4.origin);
  var5.angles = var4.angles;
  var5.scene_node = var4;
  thread infilthink(var5, var0);
  return var5;
}

function vindia_get_length(var0) {
  var1 = getanimlength(level.scr_anim["slot_0"]["vindia_infil_intro"]);
  var1 += getanimlength(level.scr_anim["slot_0"]["vindia_infil_exit"]);
  return var1;
}

function player_vindia_infil_think(var0, var1) {
  self endon("player_free_spot");
  thread player_infil_end();
  thread scripts\mp\infilexfil\infilexfil::infil_player_rig("slot_" + var1, "viewhands_base_iw8");
  self.player_rig.weapon_state_func = &scripts\mp\utility\infilexfil::handleweaponstatenotetrack;
  thread scripts\mp\infilexfil\infilexfil::infil_scene_fade_in(0, 0.55);
  thread player_van_disconnect();
  level waittill("start_scene");
  self setcinematicmotionoverride("disabled");
  self.player_rig linkTo(var0.linktoent, "tag_body_animate", (0, 0, 0), (0, 0, 0));
  self setdemeanorviewmodel("safe", "iw8_ges_demeanor_safe_van");
  self lerpviewangleclamp(1, 0.25, 0.25, 60, 60, 30, 30);
  var0.linktoent scripts\mp\anim::anim_player_solo(self, self.player_rig, "vindia_infil_intro", "tag_body_animate");
  self lerpviewangleclamp(1, 0.25, 0.25, 0, 0, 0, 0);
  thread clear_infil_ambient_zone();
  level notify("depthSortViewmodel_true");
  var0.linktoent scripts\mp\anim::anim_player_solo(self, self.player_rig, "vindia_infil_exit", "tag_body_animate");

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

function van_infil_radio_idle(var0) {
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

function spawnactors(var0, var1, var2) {
  if(!isDefined(self.actors)) {
    self.actors = [];
  }

  self.commander = spawn_anim_model(self.linktoent, "commander", "tag_turret", "body_al_qatala_1_ar", "head_sc_finkelstein");
  self.commander.infil = self;
  self.actors[self.actors.size] = spawn_anim_model(self.linktoent, "driver", "tag_body_animate", "body_al_qatala_1_ar", "head_sc_finkelstein");

  foreach(var4 in self.actors) {
    var4.infil = self;
  }

  self.commander.anim_playsound_func = &commander_play_sound_func;
  self.actors[0].anim_playsound_func = &driver_play_sound_func;
}

function infilthink(var0, var1) {
  foreach(var3 in getEntArray("infil_delete", "script_noteworthy")) {
    var3 delete();
  }

  thread vehiclethink(var0, self.scene_node, var1);
  thread actorthink(var0, self.scene_node, var1);
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

function vehiclethink(var0, var1, var2, var3) {
  var4 = spawninfilvehicle(var1, var0, var2);
  scripts\common\anim::anim_first_frame_solo(var4, "vindia_infil_intro");
  level waittill("infil_started");
  var4.interiorlights[0] setscriptablepartstate("marker", "vanLight");
  scripts\common\anim::anim_single_solo(var4, "vindia_infil_intro");
  scripts\common\anim::anim_single_solo(var4, "vindia_infil_outro_leftrightreardoor");

  foreach(var6 in var4.interiorlights) {
    var6 delete();
  }

  level waittill("prematch_over");
  game["infil"]["types"][self.type][var2]["persistentVehicle"] = &spawnpersistentvehicle;
  game["infil"]["types"][self.type][var2]["vehicleOrg"] = self.linktoent.origin;
  game["infil"]["types"][self.type][var2]["vehicleAng"] = self.linktoent.angles;
}

function spawnpersistentvehicle(var0, var1) {
  var2 = game["infil"]["types"][var0][var1]["vehicleOrg"];
  var3 = game["infil"]["types"][var0][var1]["vehicleAng"];
  var4 = spawn("script_model", var2);
  var4.angles = var3;
  var4 setModel("veh8_mil_lnd_vindia_a1");
  var4.animname = "vindia";
  var4 scripts\common\anim::setanimtree();
  var5 = spawn("script_model", var2);
  var5.angles = var3;
  var5 setModel("veh8_mil_lnd_vindia_a1_turret");
  var5 linkTo(var4, "tag_turret", (0, 0, 0), (0, 0, 0));
  var4.turret = var5;
}

function van_interior_sfx(var0) {
  var1 = spawn("script_model", self.linktoent.origin);
  var1 linkTo(self.linktoent, "tag_trunk_hint_outside");
  var2 = spawn("script_model", self.linktoent.origin);
  var2 linkTo(self.linktoent, "tag_hood");
  wait 0.1;
  var1 playsoundonmovingent("scn_infil_hackney_van_int_rear");
  var2 playsoundonmovingent("scn_infil_hackney_van_int_front");
  wait 7.75;
  var1 playsoundonmovingent("scn_infil_hackney_van_door_open");
  wait 8;
  var1 playsoundonmovingent("scn_infil_hackney_van_door_close");
  level waittill("prematch_over");
  var2 delete();
  var1 delete();
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
  var4 = getanimlength(level.scr_anim["commander"]["vindia_infil"]);
  wait var4;
  self.commander delete();
  self.commander = undefined;

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

function initanims(var0) {
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

function spawninfilvehicle(var0, var1, var2) {
  var3 = spawn("script_model", var0.origin);
  var3.angles = var0.angles;
  var3 setModel("veh8_mil_lnd_vindia_a1");
  var3.animname = "vindia";
  var3 scripts\common\anim::setanimtree();
  var3 setCanDamage(0);
  var4 = spawn("script_model", var0.origin);
  var4.angles = var0.angles;
  var4 setModel("veh8_mil_lnd_vindia_a1_turret");
  var4 linkTo(var3, "tag_turret", (0, 0, 0), (0, 0, 0));
  var3.turret = var4;
  self.linktoent = var3;
  var3.infil = self;
  var5 = [];
  var6 = spawn("script_model", var3.origin);
  var6.angles = var3.angles;
  var6 setModel("cop_marker_scriptable");
  var6 linkTo(var3, "tag_body_animate", (-60, 0, 32), (-90, 0, 0));
  var5 = var6;
  var3.interiorlights = var5;
  return var3;
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