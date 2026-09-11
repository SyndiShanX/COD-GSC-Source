/*****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\infilexfil\lbravo_infil_cp.gsc
*****************************************************/

function lbravo_init(var_0) {
  initanims(var_0);
  var_1 = [];
  GscBinSkip0(0x2e, 0, [0, 1]);
}

function lbravo_spawn(var_0, var_1, var_2) {
  var_3 = scripts\engine\utility::getStruct(var_1, "targetname");
  var_4 = spawn("script_origin", var_3.origin);
  var_4.angles = var_3.angles;
  var_4.scene_node = var_3;

  if(isDefined(var_3.target)) {
    var_4.path = scripts\engine\utility::getStruct("lbravoAlphaAdvancedPath", "targetname");
  }

  thread infilthink(var_4, var_0);
  level.infil_struct = var_4;
  return var_4;
}

function lbravo_get_length(var_0) {
  if(isDefined(self.path)) {
    var_1 = parsepathlength();
    var_1 += getanimlength(level.scr_anim["slot_0"]["lbravo_infil_" + var_0 + "_loop_exit"]);
    var_1 += getanimlength(level.scr_anim["slot_0"]["lbravo_infil_" + var_0 + "_exit"]);
    return var_1;
  }

  var_2 = getanimlength(level.scr_anim["slot_0"]["lbravo_infil_" + var_1]);
  var_2 += getanimlength(level.scr_anim["slot_0"]["lbravo_infil_" + var_1 + "_exit"]);
  return var_2;
}

function player_lbravo_infil_think(var_0, var_1) {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self endon("player_free_spot");
  self endon("joined_team");
  scripts\cp\cp_outofbounds::enableoobimmunity(self);

  if(isPlayer(self)) {
    self setclienttriggeraudiozone("lbravo_infil_intro", 1);
  }

  thread player_infil_end(var_0);
  thread scripts\cp\cp_infilexfil::infil_player_rig("slot_" + var_1, "viewhands_base_iw8");
  self.player_rig.weapon_state_func = &scripts\cp\cp_infilexfil::handleweaponstatenotetrackcp;
  self.player_rig linkTo(var_0.linktoent, "origin_animate_jnt", (0, 0, 0), (0, 0, 0));
  self predictstreampos(var_0.linktoent.origin);
  self lerpfovbypreset("80_instant");
  self setdemeanorviewmodel("safe", "iw8_ges_demeanor_safe_heli");
  thread scripts\cp\cp_infilexfil::infil_scene_fade_in(0, 0.55, "fade_up");
  thread player_van_disconnect();
  scripts\engine\utility::waittill_any_ents(level, "start_scene", var_0, "start_scene");

  if(isDefined(self.team) && self.team != "spectator") {
    self setsoundsubmix("iw8_cp_intro_outro");
    self setplayermusicstate("cp_lbravo_infil");
  }

  self.is_doing_infil = 1;
  self notify("open_loadout_menu");
  self notify("fade_up");
  self setcinematicmotionoverride("disabled");

  if(isDefined(var_0.path)) {
    thread playerthinkpath(var_0, var_1);
  } else {
    thread playerthinkanim(var_0, var_1);
  }

  self lerpfovbypreset("default");
}

function playerthinkpath(var_0, var_1) {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self endon("player_free_spot");
  self endon("joined_team");

  if(var_1 == 0) {
    self lerpviewangleclamp(1, 0.25, 0.25, 10, 45, 45, 30);
  } else if(var_1 == 1) {
    self lerpviewangleclamp(1, 0.25, 0.25, 45, 10, 45, 30);
  } else {
    self lerpviewangleclamp(1, 0.25, 0.25, 45, 45, 45, 30);
  }

  rideloop(var_0);
  self lerpviewangleclamp(1, 0.25, 0.25, 0, 0, 0, 0);
  self lerpfovbypreset("default_2seconds");
  self lerpfovscalefactor(1, 2);
  self stopanimscriptsceneevent();
  self setcinematicmotionoverride("iw8_playermotion_mp");
  self.player_rig unlink();
  self.is_doing_infil = undefined;
  self notify("player_finished_infil");
  scripts\cp\cp_outofbounds::disableoobimmunity(self);
  self setdemeanorviewmodel("normal");
  self stopviewmodelanim();
  scripts\cp\cp_infilexfil::takegunlesscp();
  self clearsoundsubmix("iw8_cp_intro_outro");
  var_0 notify("prematch_over");
  level notify("prematch_over");
}

function rideloop(var_0) {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self endon("player_free_spot");
  self endon("joined_team");
  var_0.linktoent endon("unload");

  for(;;) {
    var_0.linktoent thread scripts\cp\cp_anim::anim_player_solo(self, self.player_rig, "lbravo_infil_" + var_0.subtype + "_loop", "origin_animate_jnt");
    wait 10;
  }
}

function playerthinkanim(var_0, var_1) {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self endon("player_free_spot");
  self endon("joined_team");
  self lerpviewangleclamp(1, 0.25, 0.25, 30, 30, 30, 30);
  var_0.linktoent scripts\cp\cp_anim::anim_player_solo(self, self.player_rig, "lbravo_infil_" + var_0.subtype, "origin_animate_jnt");
  self lerpviewangleclamp(1, 0.25, 0.25, 0, 0, 0, 0);
  self.player_rig unlink();
  self setdemeanorviewmodel("normal");
  self stopviewmodelanim();
  scripts\cp\cp_infilexfil::takegunlesscp();
  self clearsoundsubmix("iw8_cp_intro_outro");
  var_0 notify("prematch_over");
  level notify("prematch_over");
  thread scriptswitchweaponhack();
  thread clear_infil_ambient_zone();
  self visionsetnakedforplayer("", 0.75);
  self setdemeanorviewmodel("normal");
  self clearcinematicmotionoverride();
}

function scriptswitchweaponhack() {
  waitframe();
  self notify("complete_late_infil_allows");
}

function clear_infil_ambient_zone() {
  wait 1;
  self clearclienttriggeraudiozone(2);
}

function player_infil_end(var_0) {
  self endon("disconnect");
  scripts\engine\utility::waittill_any_ents(level, "prematch_over", var_0, "prematch_over");
  self notify("remove_rig");
  self clearclienttriggeraudiozone(1);
  scripts\mp\utility\player::setdof_default();
}

function player_van_disconnect() {
  level endon("prematch_over");
  scripts\engine\utility::waittill_either("death", "disconnect");

  if(isDefined(self)) {
    self visionsetnakedforplayer("");
    self clearclienttriggeraudiozone(0);
    self lerpfovbypreset("default");
    self setviewmodeldepthoffield(0, 0, 18);
    scripts\mp\utility\player::setdof_default();
    return;
  }
}

function infilthink(var_0, var_1) {
  level endon("game_ended");

  foreach(var_3 in getEntArray("infil_delete", "script_noteworthy")) {
    var_3 delete();
  }

  thread vehiclethink(var_0, self.scene_node, var_1);
  thread actorthink(var_0, self.scene_node, var_1);
  scripts\engine\utility::waittill_any_ents(level, "infil_started", self, "infil_started");
  setDvar("TLMMOPMSK", 1);
  level notify("start_scene");
  self notify("start_scene");
  var_5 = lbravo_get_length(var_1);
  wait var_5;
  scripts\engine\utility::waittill_any_ents(level, "prematch_over", self, "prematch_over");
  setDvar("TLMMOPMSK", 0);

  while(isDefined(self.linktoent) || isDefined(self.actors)) {
    waitframe();
  }

  self delete();
}

function vehiclethink(var_0, var_1, var_2, var_3) {
  level endon("game_ended");
  self.linktoent = spawninfilvehicle(var_1, var_0, var_2);

  if(isDefined(self.path)) {
    thread vehiclethinkpath(var_0, var_1, var_2, var_3);
    return;
  }

  thread vehiclethinkanim(var_0, var_1, var_2, var_3);
}

function vehiclethinkanim(var_0, var_1, var_2, var_3) {
  scripts\common\anim::anim_first_frame_solo(self.linktoent, "lbravo_infil_" + var_2);
  scripts\engine\utility::waittill_any_ents(level, "infil_started", self, "infil_started");
  thread scripts\common\anim::anim_single_solo(self.linktoent, "lbravo_infil_" + var_2);
  var_4 = getanimlength(level.scr_anim[self.linktoent.animname]["lbravo_infil_" + var_2]);
  wait var_4;
  self.linktoent delete();
  self.linktoent = undefined;
}

function spawninfilvehicle(var_0, var_1, var_2) {
  var_3 = var_0.origin;
  var_4 = var_0.angles;

  if(isDefined(self.path)) {
    var_3 = self.path.origin;
    var_4 = self.path.angles;
  }

  var_5 = spawnVehicle("veh8_mil_air_lbravo_personnel_cp", var_2, "lbravo_infil_cp", var_3, var_4);
  var_5 setvehicleteam(var_1);
  var_5.animname = "lbravo";
  var_5 setCanDamage(0);
  var_5 setscriptablepartstate("engine", "on", 0);
  var_5.infil = self;

  if(isDefined(level.ref_1356f)) {
    level thread[[level.ref_1356f]](var_5);
  }

  return var_5;
}

function actorthink(var_0, var_1, var_2, var_3) {
  level endon("game_ended");
  self.actors = thread spawnactors(var_0, var_2, var_3);
  self.actors[0].anim_playsound_func = &commander_play_sound_func;
  self.linktoent scripts\common\anim::anim_first_frame(self.actors, "lbravo_infil_" + var_2, "origin_animate_jnt");
  scripts\mp\utility\infilexfil::hideactors();
  scripts\engine\utility::waittill_any_ents(level, "infil_started", self, "infil_started");
  scripts\mp\utility\infilexfil::showactors();

  if(isDefined(self.path)) {
    actorthinkpath(var_0, var_1, var_2, var_3);
    return;
  }

  actorthinkanim(var_0, var_1, var_2, var_3);
}

function actorthinkpath(var_0, var_1, var_2, var_3) {
  if(isDefined(level.watchfraggrenadeexplode)) {
    level thread[[level.watchfraggrenadeexplode]](self);
    return;
  }

  autoassignfirstquest(self);
}

function autoassignfirstquest(var_0) {
  thread actorloopthink(var_0);
  thread actorloopthink(var_0);
}

function actorloopthink(var_0) {
  actorloop(var_0);
  self.linktoent scripts\common\anim::anim_single_solo(var_0, "lbravo_infil_" + self.subtype + "_loop_exit", "origin_animate_jnt");
}

function actorloop(var_0) {
  self.linktoent endon("unload");

  for(;;) {
    self.linktoent scripts\common\anim::anim_single_solo(var_0, "lbravo_infil_" + self.subtype + "_loop", "origin_animate_jnt");
  }
}

function actorthinkanim(var_0, var_1, var_2, var_3) {
  self.linktoent thread scripts\common\anim::anim_single(self.actors, "lbravo_infil_" + var_2, "origin_animate_jnt");
  var_4 = getanimlength(level.scr_anim["pilot"]["lbravo_infil_" + var_2]);
  wait var_4;

  foreach(var_6 in self.actors) {
    var_6 delete();
  }

  self.actors = undefined;
}

function spawnactors(var_0, var_1, var_2) {
  var_3 = [];
  GscBinSkip0(0x2e, var_3.size, spawn_anim_model(self.linktoent, "pilot", "origin_animate_jnt", "allied_pilot_fullbody_1"));
}

function spawn_anim_model(var_0, var_1, var_2, var_3, var_4) {
  var_5 = spawn("script_model", (0, 0, 0));
  var_5 setModel(var_2);

  if(isDefined(var_3)) {
    var_6 = spawn("script_model", (0, 0, 0));
    var_6 setModel(var_3);
    var_6 linkTo(var_5, "j_spine4", (0, 0, 0), (0, 0, 0));
    var_5.head = var_6;
    var_5 thread scripts\engine\utility::delete_on_death(var_6);
  }

  if(isDefined(var_4)) {
    var_7 = spawn("script_model", (0, 0, 0));
    var_7 setModel(var_4);
    var_7 linkTo(var_5, "j_gun", (0, 0, 0), (0, 0, 0));
    var_5 thread scripts\engine\utility::delete_on_death(var_7);
    var_5.weapon = var_7;
  }

  var_5.animname = var_0;
  var_5 scripts\common\anim::setanimtree();

  if(isDefined(var_1)) {
    thread scripts\engine\utility::delete_on_death(var_5);
    var_5 linkTo(self, var_1, (0, 0, 0), (0, 0, 0));
  }

  return var_5;
}

function initanims(var_0) {
  script_model_alpha_anims(var_0);
  vehicles_alpha_anims(var_0);
  scripts\common\anim::addnotetrack_customfunction("slot_0", "free_look", &scripts\mp\utility\infilexfil::player_free_look, "lbravo_infil_alpha_exit");
  scripts\common\anim::addnotetrack_customfunction("slot_1", "free_look", &scripts\mp\utility\infilexfil::player_free_look, "lbravo_infil_alpha_exit");
  scripts\common\anim::addnotetrack_customfunction("slot_2", "free_look", &scripts\mp\utility\infilexfil::player_free_look, "lbravo_infil_alpha_exit");
  scripts\common\anim::addnotetrack_customfunction("slot_3", "free_look", &scripts\mp\utility\infilexfil::player_free_look, "lbravo_infil_alpha_exit");
  scripts\common\anim::addnotetrack_customfunction("slot_4", "free_look", &scripts\mp\utility\infilexfil::player_free_look, "lbravo_infil_alpha_exit");
  scripts\common\anim::addnotetrack_customfunction("slot_5", "free_look", &scripts\mp\utility\infilexfil::player_free_look, "lbravo_infil_alpha_exit");
  scripts\common\anim::addnotetrack_customfunction("slot_0", "free_look", &scripts\mp\utility\infilexfil::player_free_look, "lbravo_infil_bravo_exit");
  scripts\common\anim::addnotetrack_customfunction("slot_1", "free_look", &scripts\mp\utility\infilexfil::player_free_look, "lbravo_infil_bravo_exit");
  scripts\common\anim::addnotetrack_customfunction("slot_2", "free_look", &scripts\mp\utility\infilexfil::player_free_look, "lbravo_infil_bravo_exit");
  scripts\common\anim::addnotetrack_customfunction("slot_3", "free_look", &scripts\mp\utility\infilexfil::player_free_look, "lbravo_infil_bravo_exit");
  scripts\common\anim::addnotetrack_customfunction("slot_4", "free_look", &scripts\mp\utility\infilexfil::player_free_look, "lbravo_infil_bravo_exit");
  scripts\common\anim::addnotetrack_customfunction("slot_5", "free_look", &scripts\mp\utility\infilexfil::player_free_look, "lbravo_infil_bravo_exit");
  scripts\common\anim::addnotetrack_customfunction("slot_0", "fov_80_instant", &scripts\mp\utility\infilexfil::player_fov_80_instant);
  scripts\common\anim::addnotetrack_customfunction("slot_1", "fov_80_instant", &scripts\mp\utility\infilexfil::player_fov_80_instant);
  scripts\common\anim::addnotetrack_customfunction("slot_2", "fov_80_instant", &scripts\mp\utility\infilexfil::player_fov_80_instant);
  scripts\common\anim::addnotetrack_customfunction("slot_3", "fov_80_instant", &scripts\mp\utility\infilexfil::player_fov_80_instant);
  scripts\common\anim::addnotetrack_customfunction("slot_4", "fov_80_instant", &scripts\mp\utility\infilexfil::player_fov_80_instant);
  scripts\common\anim::addnotetrack_customfunction("slot_5", "fov_80_instant", &scripts\mp\utility\infilexfil::player_fov_80_instant);
  scripts\common\anim::addnotetrack_customfunction("slot_0", "fov_63_2", &scripts\mp\utility\infilexfil::player_fov_default_2);
  scripts\common\anim::addnotetrack_customfunction("slot_1", "fov_63_2", &scripts\mp\utility\infilexfil::player_fov_default_2);
  scripts\common\anim::addnotetrack_customfunction("slot_2", "fov_63_2", &scripts\mp\utility\infilexfil::player_fov_default_2);
  scripts\common\anim::addnotetrack_customfunction("slot_3", "fov_63_2", &scripts\mp\utility\infilexfil::player_fov_default_2);
  scripts\common\anim::addnotetrack_customfunction("slot_4", "fov_63_2", &scripts\mp\utility\infilexfil::player_fov_default_2);
  scripts\common\anim::addnotetrack_customfunction("slot_5", "fov_63_2", &scripts\mp\utility\infilexfil::player_fov_default_2);
  scripts\common\anim::addnotetrack_customfunction("slot_0", "shake_on", &scripts\mp\utility\infilexfil::cam_shake_low, "lbravo_infil_alpha");
  scripts\common\anim::addnotetrack_customfunction("slot_1", "shake_on", &scripts\mp\utility\infilexfil::cam_shake_low, "lbravo_infil_alpha");
  scripts\common\anim::addnotetrack_customfunction("slot_2", "shake_on", &scripts\mp\utility\infilexfil::cam_shake_low, "lbravo_infil_alpha");
  scripts\common\anim::addnotetrack_customfunction("slot_3", "shake_on", &scripts\mp\utility\infilexfil::cam_shake_low, "lbravo_infil_alpha");
  scripts\common\anim::addnotetrack_customfunction("slot_4", "shake_on", &scripts\mp\utility\infilexfil::cam_shake_low, "lbravo_infil_alpha");
  scripts\common\anim::addnotetrack_customfunction("slot_5", "shake_on", &scripts\mp\utility\infilexfil::cam_shake_low, "lbravo_infil_alpha");
  scripts\common\anim::addnotetrack_customfunction("slot_0", "shake_on", &scripts\mp\utility\infilexfil::cam_shake_low, "lbravo_infil_bravo");
  scripts\common\anim::addnotetrack_customfunction("slot_1", "shake_on", &scripts\mp\utility\infilexfil::cam_shake_low, "lbravo_infil_bravo");
  scripts\common\anim::addnotetrack_customfunction("slot_2", "shake_on", &scripts\mp\utility\infilexfil::cam_shake_low, "lbravo_infil_bravo");
  scripts\common\anim::addnotetrack_customfunction("slot_3", "shake_on", &scripts\mp\utility\infilexfil::cam_shake_low, "lbravo_infil_bravo");
  scripts\common\anim::addnotetrack_customfunction("slot_4", "shake_on", &scripts\mp\utility\infilexfil::cam_shake_low, "lbravo_infil_bravo");
  scripts\common\anim::addnotetrack_customfunction("slot_5", "shake_on", &scripts\mp\utility\infilexfil::cam_shake_low, "lbravo_infil_bravo");
  scripts\common\anim::addnotetrack_customfunction("slot_0", "shake_off", &scripts\mp\utility\infilexfil::cam_shake_off, "lbravo_infil_alpha_exit");
  scripts\common\anim::addnotetrack_customfunction("slot_1", "shake_off", &scripts\mp\utility\infilexfil::cam_shake_off, "lbravo_infil_alpha_exit");
  scripts\common\anim::addnotetrack_customfunction("slot_2", "shake_off", &scripts\mp\utility\infilexfil::cam_shake_off, "lbravo_infil_alpha_exit");
  scripts\common\anim::addnotetrack_customfunction("slot_3", "shake_off", &scripts\mp\utility\infilexfil::cam_shake_off, "lbravo_infil_alpha_exit");
  scripts\common\anim::addnotetrack_customfunction("slot_4", "shake_off", &scripts\mp\utility\infilexfil::cam_shake_off, "lbravo_infil_alpha_exit");
  scripts\common\anim::addnotetrack_customfunction("slot_5", "shake_off", &scripts\mp\utility\infilexfil::cam_shake_off, "lbravo_infil_alpha_exit");
  scripts\common\anim::addnotetrack_customfunction("slot_0", "shake_off", &scripts\mp\utility\infilexfil::cam_shake_off, "lbravo_infil_bravo_exit");
  scripts\common\anim::addnotetrack_customfunction("slot_1", "shake_off", &scripts\mp\utility\infilexfil::cam_shake_off, "lbravo_infil_bravo_exit");
  scripts\common\anim::addnotetrack_customfunction("slot_2", "shake_off", &scripts\mp\utility\infilexfil::cam_shake_off, "lbravo_infil_bravo_exit");
  scripts\common\anim::addnotetrack_customfunction("slot_3", "shake_off", &scripts\mp\utility\infilexfil::cam_shake_off, "lbravo_infil_bravo_exit");
  scripts\common\anim::addnotetrack_customfunction("slot_4", "shake_off", &scripts\mp\utility\infilexfil::cam_shake_off, "lbravo_infil_bravo_exit");
  scripts\common\anim::addnotetrack_customfunction("slot_5", "shake_off", &scripts\mp\utility\infilexfil::cam_shake_off, "lbravo_infil_bravo_exit");
}

#using_animtree("");

function script_model_alpha_anims(var_0) {
  switch (var_0) {
    case "alpha":
      level.scr_animtree["pilot"] = #animtree;
      level.scr_anim["pilot"]["lbravo_infil_alpha"] = $mp_infil_lbravo_a_pilot;
      level.scr_animname["pilot"]["lbravo_infil_alpha"] = "mp_infil_lbravo_a_pilot";
      level.scr_animtree["pilot"] = #animtree;
      level.scr_anim["pilot"]["lbravo_infil_alpha_loop"] = % mp_infil_lbravo_a_pilot_loop;
      level.scr_animname["pilot"]["lbravo_infil_alpha_loop"] = "mp_infil_lbravo_a_pilot_loop";
      level.scr_animtree["pilot"] = #animtree;
      level.scr_anim["pilot"]["lbravo_infil_alpha_loop_exit"] = % mp_infil_lbravo_a_pilot_loop_exit;
      level.scr_animname["pilot"]["lbravo_infil_alpha_loop_exit"] = "mp_infil_lbravo_a_pilot_loop_exit";
      level.scr_animtree["copilot"] = #animtree;
      level.scr_anim["copilot"]["lbravo_infil_alpha"] = % mp_infil_lbravo_a_copilot;
      level.scr_animname["copilot"]["lbravo_infil_alpha"] = "mp_infil_lbravo_a_copilot";
      level.scr_animtree["copilot"] = #animtree;
      level.scr_anim["copilot"]["lbravo_infil_alpha_loop"] = % mp_infil_lbravo_a_copilot_loop;
      level.scr_animname["copilot"]["lbravo_infil_alpha_loop"] = "mp_infil_lbravo_a_copilot_loop";
      level.scr_animtree["copilot"] = #animtree;
      level.scr_anim["copilot"]["lbravo_infil_alpha_loop_exit"] = % mp_infil_lbravo_a_copilot_loop_exit;
      level.scr_animname["copilot"]["lbravo_infil_alpha_loop_exit"] = "mp_infil_lbravo_a_copilot_loop_exit";
      level.scr_animtree["slot_0"] = #animtree;
      level.scr_anim["slot_0"]["lbravo_infil_alpha"] = % mp_infil_lbravo_a_guy1_wm;
      level.scr_animname["slot_0"]["lbravo_infil_alpha"] = "mp_infil_lbravo_a_guy1_wm";
      level.scr_eventanim["slot_0"]["lbravo_infil_alpha"] = "infil_lbravo_a_1";
      level.scr_anim["slot_0"]["lbravo_infil_alpha_exit"] = % mp_infil_lbravo_b_guy1_exit_wm;
      level.scr_animname["slot_0"]["lbravo_infil_alpha_exit"] = "mp_infil_lbravo_b_guy1_exit_wm";
      level.scr_eventanim["slot_0"]["lbravo_infil_alpha_exit"] = "infil_lbravo_b_exit_1";
      level.scr_anim["slot_0"]["lbravo_infil_alpha_loop"] = % mp_infil_lbravo_b_guy1_wm;
      level.scr_animname["slot_0"]["lbravo_infil_alpha_loop"] = "mp_infil_lbravo_b_guy1_wm";
      level.scr_eventanim["slot_0"]["lbravo_infil_alpha_loop"] = "infil_lbravo_b_1";
      level.scr_anim["slot_0"]["lbravo_infil_alpha_loop_exit"] = % mp_infil_lbravo_a_guy1_loop_exit_wm;
      level.scr_animname["slot_0"]["lbravo_infil_alpha_loop_exit"] = "mp_infil_lbravo_a_guy1_loop_exit_wm";
      level.scr_eventanim["slot_0"]["lbravo_infil_alpha_loop_exit"] = "infil_lbravo_a_loop_exit_1";
      level.scr_animtree["slot_1"] = #animtree;
      level.scr_anim["slot_1"]["lbravo_infil_alpha"] = % mp_infil_lbravo_a_guy2_wm;
      level.scr_animname["slot_1"]["lbravo_infil_alpha"] = "mp_infil_lbravo_a_guy2_wm";
      level.scr_eventanim["slot_1"]["lbravo_infil_alpha"] = "infil_lbravo_a_2";
      level.scr_anim["slot_1"]["lbravo_infil_alpha_exit"] = % mp_infil_lbravo_b_guy2_exit_wm;
      level.scr_animname["slot_1"]["lbravo_infil_alpha_exit"] = "mp_infil_lbravo_b_guy2_exit_wm";
      level.scr_eventanim["slot_1"]["lbravo_infil_alpha_exit"] = "infil_lbravo_b_exit_2";
      level.scr_anim["slot_1"]["lbravo_infil_alpha_loop"] = % mp_infil_lbravo_b_guy2_wm;
      level.scr_animname["slot_1"]["lbravo_infil_alpha_loop"] = "mp_infil_lbravo_b_guy2_wm";
      level.scr_eventanim["slot_1"]["lbravo_infil_alpha_loop"] = "infil_lbravo_b_2";
      level.scr_anim["slot_1"]["lbravo_infil_alpha_loop_exit"] = % mp_infil_lbravo_a_guy2_loop_exit_wm;
      level.scr_animname["slot_1"]["lbravo_infil_alpha_loop_exit"] = "mp_infil_lbravo_a_guy2_loop_exit_wm";
      level.scr_eventanim["slot_1"]["lbravo_infil_alpha_loop_exit"] = "infil_lbravo_a_loop_exit_2";
      level.scr_animtree["slot_2"] = #animtree;
      level.scr_anim["slot_2"]["lbravo_infil_alpha"] = % mp_infil_lbravo_a_guy3_wm;
      level.scr_animname["slot_2"]["lbravo_infil_alpha"] = "mp_infil_lbravo_a_guy3_wm";
      level.scr_eventanim["slot_2"]["lbravo_infil_alpha"] = "infil_lbravo_a_3";
      level.scr_anim["slot_2"]["lbravo_infil_alpha_exit"] = % mp_infil_lbravo_b_guy3_exit_wm;
      level.scr_animname["slot_2"]["lbravo_infil_alpha_exit"] = "mp_infil_lbravo_b_guy3_exit_wm";
      level.scr_eventanim["slot_2"]["lbravo_infil_alpha_exit"] = "infil_lbravo_b_exit_3";
      level.scr_anim["slot_2"]["lbravo_infil_alpha_loop"] = % mp_infil_lbravo_b_guy3_wm;
      level.scr_animname["slot_2"]["lbravo_infil_alpha_loop"] = "mp_infil_lbravo_b_guy3_wm";
      level.scr_eventanim["slot_2"]["lbravo_infil_alpha_loop"] = "infil_lbravo_b_3";
      level.scr_anim["slot_2"]["lbravo_infil_alpha_loop_exit"] = % mp_infil_lbravo_a_guy3_loop_exit_wm;
      level.scr_animname["slot_2"]["lbravo_infil_alpha_loop_exit"] = "mp_infil_lbravo_a_guy3_loop_exit_wm";
      level.scr_eventanim["slot_2"]["lbravo_infil_alpha_loop_exit"] = "infil_lbravo_a_loop_exit_3";
      level.scr_animtree["slot_3"] = #animtree;
      level.scr_anim["slot_3"]["lbravo_infil_alpha"] = % mp_infil_lbravo_a_guy4_wm;
      level.scr_animname["slot_3"]["lbravo_infil_alpha"] = "mp_infil_lbravo_a_guy4_wm";
      level.scr_eventanim["slot_3"]["lbravo_infil_alpha"] = "infil_lbravo_a_4";
      level.scr_anim["slot_3"]["lbravo_infil_alpha_exit"] = % mp_infil_lbravo_b_guy4_exit_wm;
      level.scr_animname["slot_3"]["lbravo_infil_alpha_exit"] = "mp_infil_lbravo_b_guy4_exit_wm";
      level.scr_eventanim["slot_3"]["lbravo_infil_alpha_exit"] = "infil_lbravo_b_exit_4";
      level.scr_anim["slot_3"]["lbravo_infil_alpha_loop"] = % mp_infil_lbravo_b_guy4_wm;
      level.scr_animname["slot_3"]["lbravo_infil_alpha_loop"] = "mp_infil_lbravo_b_guy4_wm";
      level.scr_eventanim["slot_3"]["lbravo_infil_alpha_loop"] = "infil_lbravo_b_4";
      level.scr_anim["slot_3"]["lbravo_infil_alpha_loop_exit"] = % mp_infil_lbravo_a_guy4_loop_exit_wm;
      level.scr_animname["slot_3"]["lbravo_infil_alpha_loop_exit"] = "mp_infil_lbravo_a_guy4_loop_exit_wm";
      level.scr_eventanim["slot_3"]["lbravo_infil_alpha_loop_exit"] = "infil_lbravo_a_loop_exit_4";
      level.scr_animtree["slot_4"] = #animtree;
      level.scr_anim["slot_4"]["lbravo_infil_alpha"] = % mp_infil_lbravo_a_guy5_wm;
      level.scr_animname["slot_4"]["lbravo_infil_alpha"] = "mp_infil_lbravo_a_guy5_wm";
      level.scr_eventanim["slot_4"]["lbravo_infil_alpha"] = "infil_lbravo_a_5";
      level.scr_anim["slot_4"]["lbravo_infil_alpha_exit"] = % mp_infil_lbravo_b_guy5_exit_wm;
      level.scr_animname["slot_4"]["lbravo_infil_alpha_exit"] = "mp_infil_lbravo_b_guy5_exit_wm";
      level.scr_eventanim["slot_4"]["lbravo_infil_alpha_exit"] = "infil_lbravo_b_exit_5";
      level.scr_anim["slot_4"]["lbravo_infil_alpha_loop"] = % mp_infil_lbravo_b_guy5_wm;
      level.scr_animname["slot_4"]["lbravo_infil_alpha_loop"] = "mp_infil_lbravo_b_guy5_wm";
      level.scr_eventanim["slot_4"]["lbravo_infil_alpha_loop"] = "infil_lbravo_b_5";
      level.scr_anim["slot_4"]["lbravo_infil_alpha_loop_exit"] = % mp_infil_lbravo_a_guy5_loop_exit_wm;
      level.scr_animname["slot_4"]["lbravo_infil_alpha_loop_exit"] = "mp_infil_lbravo_a_guy5_loop_exit_wm";
      level.scr_eventanim["slot_4"]["lbravo_infil_alpha_loop_exit"] = "infil_lbravo_a_loop_exit_5";
      level.scr_animtree["slot_5"] = #animtree;
      level.scr_anim["slot_5"]["lbravo_infil_alpha"] = % mp_infil_lbravo_a_guy6_wm;
      level.scr_animname["slot_5"]["lbravo_infil_alpha"] = "mp_infil_lbravo_a_guy6_wm";
      level.scr_eventanim["slot_5"]["lbravo_infil_alpha"] = "infil_lbravo_a_6";
      level.scr_anim["slot_5"]["lbravo_infil_alpha_exit"] = % mp_infil_lbravo_b_guy6_exit_wm;
      level.scr_animname["slot_5"]["lbravo_infil_alpha_exit"] = "mp_infil_lbravo_b_guy6_exit_wm";
      level.scr_eventanim["slot_5"]["lbravo_infil_alpha_exit"] = "infil_lbravo_b_exit_6";
      level.scr_anim["slot_5"]["lbravo_infil_alpha_loop"] = % mp_infil_lbravo_b_guy6_wm;
      level.scr_animname["slot_5"]["lbravo_infil_alpha_loop"] = "mp_infil_lbravo_b_guy6_wm";
      level.scr_eventanim["slot_5"]["lbravo_infil_alpha_loop"] = "infil_lbravo_b_6";
      level.scr_anim["slot_5"]["lbravo_infil_alpha_loop_exit"] = % mp_infil_lbravo_a_guy6_loop_exit_wm;
      level.scr_animname["slot_5"]["lbravo_infil_alpha_loop_exit"] = "mp_infil_lbravo_a_guy6_loop_exit_wm";
      level.scr_eventanim["slot_5"]["lbravo_infil_alpha_loop_exit"] = "infil_lbravo_a_loop_exit_6";
      break;
    case "bravo":
      level.scr_animtree["pilot"] = #animtree;
      level.scr_anim["pilot"]["lbravo_infil_bravo"] = % mp_infil_lbravo_b_pilot;
      level.scr_animname["pilot"]["lbravo_infil_bravo"] = "mp_infil_lbravo_b_pilot";
      level.scr_animtree["copilot"] = #animtree;
      level.scr_anim["copilot"]["lbravo_infil_bravo"] = % mp_infil_lbravo_b_copilot;
      level.scr_animname["copilot"]["lbravo_infil_bravo"] = "mp_infil_lbravo_b_copilot";
      level.scr_animtree["slot_0"] = #animtree;
      level.scr_anim["slot_0"]["lbravo_infil_bravo"] = % mp_infil_lbravo_b_guy1_wm;
      level.scr_animname["slot_0"]["lbravo_infil_bravo"] = "mp_infil_lbravo_b_guy1_wm";
      level.scr_eventanim["slot_0"]["lbravo_infil_bravo"] = "infil_lbravo_b_1";
      level.scr_anim["slot_0"]["lbravo_infil_bravo_exit"] = % mp_infil_lbravo_b_guy1_exit_wm;
      level.scr_animname["slot_0"]["lbravo_infil_bravo_exit"] = "mp_infil_lbravo_b_guy1_exit_wm";
      level.scr_eventanim["slot_0"]["lbravo_infil_bravo_exit"] = "infil_lbravo_b_exit_1";
      level.scr_animtree["slot_1"] = #animtree;
      level.scr_anim["slot_1"]["lbravo_infil_bravo"] = % mp_infil_lbravo_b_guy2_wm;
      level.scr_animname["slot_1"]["lbravo_infil_bravo"] = "mp_infil_lbravo_b_guy2_wm";
      level.scr_eventanim["slot_1"]["lbravo_infil_bravo"] = "infil_lbravo_b_2";
      level.scr_anim["slot_1"]["lbravo_infil_bravo_exit"] = % mp_infil_lbravo_b_guy2_exit_wm;
      level.scr_animname["slot_1"]["lbravo_infil_bravo_exit"] = "mp_infil_lbravo_b_guy2_exit_wm";
      level.scr_eventanim["slot_1"]["lbravo_infil_bravo_exit"] = "infil_lbravo_b_exit_2";
      level.scr_animtree["slot_2"] = #animtree;
      level.scr_anim["slot_2"]["lbravo_infil_bravo"] = % mp_infil_lbravo_b_guy3_wm;
      level.scr_animname["slot_2"]["lbravo_infil_bravo"] = "mp_infil_lbravo_b_guy3_wm";
      level.scr_eventanim["slot_2"]["lbravo_infil_bravo"] = "infil_lbravo_b_3";
      level.scr_anim["slot_2"]["lbravo_infil_bravo_exit"] = % mp_infil_lbravo_b_guy3_exit_wm;
      level.scr_animname["slot_2"]["lbravo_infil_bravo_exit"] = "mp_infil_lbravo_b_guy3_exit_wm";
      level.scr_eventanim["slot_2"]["lbravo_infil_bravo_exit"] = "infil_lbravo_b_exit_3";
      level.scr_animtree["slot_3"] = #animtree;
      level.scr_anim["slot_3"]["lbravo_infil_bravo"] = % mp_infil_lbravo_b_guy4_wm;
      level.scr_animname["slot_3"]["lbravo_infil_bravo"] = "mp_infil_lbravo_b_guy4_wm";
      level.scr_eventanim["slot_3"]["lbravo_infil_bravo"] = "infil_lbravo_b_4";
      level.scr_anim["slot_3"]["lbravo_infil_bravo_exit"] = % mp_infil_lbravo_b_guy4_exit_wm;
      level.scr_animname["slot_3"]["lbravo_infil_bravo_exit"] = "mp_infil_lbravo_b_guy4_exit_wm";
      level.scr_eventanim["slot_3"]["lbravo_infil_bravo_exit"] = "infil_lbravo_b_exit_4";
      level.scr_animtree["slot_4"] = #animtree;
      level.scr_anim["slot_4"]["lbravo_infil_bravo"] = % mp_infil_lbravo_b_guy5_wm;
      level.scr_animname["slot_4"]["lbravo_infil_bravo"] = "mp_infil_lbravo_b_guy5_wm";
      level.scr_eventanim["slot_4"]["lbravo_infil_bravo"] = "infil_lbravo_b_5";
      level.scr_anim["slot_4"]["lbravo_infil_bravo_exit"] = % mp_infil_lbravo_b_guy5_exit_wm;
      level.scr_animname["slot_4"]["lbravo_infil_bravo_exit"] = "mp_infil_lbravo_b_guy5_exit_wm";
      level.scr_eventanim["slot_4"]["lbravo_infil_bravo_exit"] = "infil_lbravo_b_exit_5";
      level.scr_animtree["slot_5"] = #animtree;
      level.scr_anim["slot_5"]["lbravo_infil_bravo"] = % mp_infil_lbravo_b_guy6_wm;
      level.scr_animname["slot_5"]["lbravo_infil_bravo"] = "mp_infil_lbravo_b_guy6_wm";
      level.scr_eventanim["slot_5"]["lbravo_infil_bravo"] = "infil_lbravo_b_6";
      level.scr_anim["slot_5"]["lbravo_infil_bravo_exit"] = % mp_infil_lbravo_b_guy6_exit_wm;
      level.scr_animname["slot_5"]["lbravo_infil_bravo_exit"] = "mp_infil_lbravo_b_guy6_exit_wm";
      level.scr_eventanim["slot_5"]["lbravo_infil_bravo_exit"] = "infil_lbravo_b_exit_6";
      break;
  }
}

function vehicles_alpha_anims(var_0) {
  switch (var_0) {
    case "alpha":
      level.scr_animtree["lbravo"] = #animtree;
      level.scr_anim["lbravo"]["lbravo_infil_alpha"] = $mp_infil_lbravo_a_heli;
      break;
    case "bravo":
      level.scr_animtree["lbravo"] = #animtree;

      switch (getDvar("mapname")) {
        case "mp_runner":
          level.scr_anim["lbravo"]["lbravo_infil_bravo"] = % mp_infil_lbravo_b_heli_runner;
          break;
        default:
          level.scr_anim["lbravo"]["lbravo_infil_bravo"] = % mp_infil_lbravo_b_heli;
          break;
      }

      break;
  }
}

function commander_play_sound_func(var_0, var_1, var_2) {
  foreach(var_4 in self.infil.players) {
    self playsoundtoplayer(var_0, var_4);
  }
}

function vehiclethinkpath(var_0, var_1, var_2, var_3) {
  level waittill("infil_started");
  self.linktoent endon("death");
  self.linktoent.unload_hover_offset = 116;
  self.linktoent.unload_time = 3.5;
  vehicle_paths_helicopter(self.linktoent, self.path);
  thread gopath(self.linktoent);
}

function vehiclefollowpath(var_0) {
  self endon("death");
  self endon("stop_follow_path");
  self startpath(var_0);

  for(var_1 = scripts\engine\utility::getStruct(var_0.target, "targetname"); isDefined(var_1); var_1 = scripts\engine\utility::getStruct(var_1.target, "targetname")) {
    var_1 waittill("trigger");

    if(!isDefined(var_1.target)) {
      break;
    }
  }

  self vehicle_setspeedimmediate(0, 30, 30);

  for(var_2 = self vehicle_getspeed(); var_2 > 1; var_2 = self vehicle_getspeed()) {
    wait 0.1;
  }
}

function gopath(var_0) {
  if(!isDefined(var_0)) {
    var_0 = self;
  }

  var_0 endon("death");

  if(isDefined(var_0.hasstarted)) {
    return;
  } else {
    var_0.hasstarted = 1;
  }

  var_0 scripts\engine\utility::script_delay();
  var_0 notify("start_vehiclepath");
  var_0 notify("start_dynamicpath");
}

function vehicle_paths_helicopter(var_0, var_1, var_2) {
  self notify("newpath");
  self endon("newpath");
  self endon("death");

  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  if(isDefined(var_0)) {
    self.attachedpath = var_0;
  }

  var_3 = self.attachedpath;
  self.currentnode = self.attachedpath;

  if(!isDefined(var_3)) {
    return;
  }

  var_4 = var_3;

  if(var_1) {
    self waittill("start_dynamicpath");
  }

  if(isDefined(var_2)) {
    var_5 = spawnStruct();
    var_5.origin = (self.origin[0], self.origin[1], self.origin[2] + var_2);
    heli_wait_node(var_5, undefined);
  }

  var_6 = undefined;
  var_7 = var_3;
  var_8 = get_path_getfunc(var_3);

  while(isDefined(var_7)) {
    if(isDefined(var_7.script_linkto)) {
      set_lookat_from_dest(var_7);
    }

    heli_wait_node(var_7, var_6, var_2);

    if(!isDefined(self)) {
      return;
    }

    self.currentnode = var_7;
    var_7 notify("trigger", self);

    if(isDefined(var_7.script_delete)) {
      self delete();
      return;
    }

    if(isDefined(var_7.script_helimove)) {
      self setyawspeedbyname(var_7.script_helimove);

      if(var_7.script_helimove == "faster") {
        self setmaxpitchroll(25, 50);
      }
    }

    if(!isDefined(self)) {
      return;
    }

    if(isDefined(var_7.script_team)) {
      self.script_team = var_7.script_team;
    }

    if(isDefined(var_7.script_unload)) {
      self notify("unload");
      scripts\engine\utility::waittill_notify_or_timeout("unloaded", self.unload_time);
      level notify("players_unloaded_from_infil");
    }

    if(self vehicle_isphysveh()) {
      if(isDefined(var_7.script_pathtype)) {
        self.veh_pathtype = var_7.script_pathtype;
      }
    }

    if(isDefined(var_7.script_flag_wait)) {
      scripts\engine\utility::flag_wait(var_7.script_flag_wait);

      if(isDefined(var_7.script_delay_post)) {
        wait var_7.script_delay_post;
      }

      self notify("delay_passed");
    }

    if(isDefined(self.set_lookat_point)) {
      self.set_lookat_point = undefined;
      self clearlookatent();
    }

    var_6 = var_7;

    if(!isDefined(var_7.target)) {
      break;
    }

    var_7 = [[var_8]](var_7.target);

    if(!isDefined(var_7)) {
      var_7 = var_6;
      break;
    }
  }

  self notify("reached_dynamic_path_end");

  if(isDefined(self.script_vehicle_selfremove)) {
    self delete();
    return;
  }
}

function heli_wait_node(var_0, var_1, var_2) {
  self endon("newpath");

  if(isDefined(var_0.script_unload) || isDefined(var_0.script_land)) {
    var_3 = 0;

    if(isDefined(var_0.script_land)) {
      scripts\engine\utility::ent_flag_set("landed");

      if(isDefined(self.unload_land_offset)) {
        var_3 = self.unload_land_offset;
      }
    } else if(isDefined(var_0.script_unload) && isDefined(self.unload_hover_offset)) {
      var_3 = self.unload_hover_offset;
    } else if(isDefined(var_0.script_unload) && isDefined(self.unload_hover_offset_max)) {
      var_4 = scripts\common\utility::groundpos(var_0.origin);
      var_3 = var_0.origin[2] - var_4[2];

      if(var_3 >= self.unload_hover_offset_max) {
        var_3 = self.unload_hover_offset_max;
      } else if(isDefined(self.unload_hover_land_height) && var_3 < self.unload_hover_land_height) {
        var_3 = self.unload_hover_land_height;
      }
    }

    var_0.radius = 2;

    if(isDefined(var_0.ground_pos)) {
      var_0.origin = var_0.ground_pos + (0, 0, var_3);
    } else {
      var_5 = scripts\common\utility::groundpos(var_0.origin) + (0, 0, var_3);

      if(var_5[2] > var_0.origin[2] - 2000) {
        var_0.origin = scripts\common\utility::groundpos(var_0.origin) + (0, 0, var_3);
      }
    }

    self sethoverparams(0, 0, 0);
  }

  if(isDefined(var_1)) {
    var_6 = var_1.script_airresistance;
    var_7 = var_1.speed;
    var_8 = var_1.script_accel;
    var_9 = var_1.script_decel;
  } else {
    var_6 = undefined;
    var_7 = undefined;
    var_8 = undefined;
    var_9 = undefined;
  }

  var_10 = isDefined(var_7.script_stopnode) && var_7.script_stopnode;
  var_11 = isDefined(var_7.script_unload);
  var_12 = isDefined(var_7.script_flag_wait) && !scripts\engine\utility::flag(var_7.script_flag_wait);
  var_13 = !isDefined(var_7.target);
  var_14 = isDefined(var_7.script_delay);

  if(isDefined(var_7.angles)) {
    var_15 = var_7.angles[1];
  } else {
    var_15 = 0;
  }

  if(self.health <= 0) {
    return;
  }

  var_16 = var_8.origin;

  if(isDefined(var_6)) {
    var_16 = (var_16[0], var_16[1], var_16[2] + var_6);
  }

  if(isDefined(self.heliheightoverride)) {
    var_16 = (var_16[0], var_16[1], self.heliheightoverride);
  }

  self vehicle_helisetai(var_16, var_8, var_9, var_10, var_8.script_goalyaw, var_8.script_anglevehicle, var_15, var_7, var_15, var_11, var_12, var_13, var_14);

  if(isDefined(var_8.radius)) {
    self setneargoalnotifydist(var_8.radius);
    scripts\engine\utility::ref_143a5("near_goal", "goal");
  } else {
    self waittill("goal");
  }

  if(isDefined(var_8.script_flag_set)) {
    level notify(var_8.script_flag_set);
  }

  if(isDefined(var_8.script_firelink)) {
    if(isDefined(level.helicopter_firelinkfunk)) {}

    GscBinSkip1(0x74, level.helicopter_firelinkfunk, var_8);
  }

  var_8 scripts\engine\utility::script_delay();

  if(isDefined(self.path_gobbler)) {
    scripts\engine\utility::deletestruct_ref(var_8);
  }

  self notify("continuepath");
}

function get_path_getfunc(var_0) {
  var_1 = &get_from_vehicle_node;

  if(isDefined(var_0.target)) {
    if(isDefined(get_from_entity(var_0.target))) {
      var_1 = &get_from_entity;
    }

    if(isDefined(get_from_spawnStruct(var_0.target))) {
      var_1 = &get_from_spawnstruct;
    }
  }

  return var_1;
}

function get_from_vehicle_node(var_0) {
  return getvehiclenode(var_0, "targetname");
}

function get_from_spawnStruct(var_0) {
  return scripts\engine\utility::getStruct(var_0, "targetname");
}

function get_from_entity(var_0) {
  var_1 = getEntArray(var_0, "targetname");

  if(isDefined(var_1) && var_1.size > 0) {
    return var_1[randomint(var_1.size)];
  }

  return undefined;
}

function set_lookat_from_dest(var_0) {
  var_1 = getEnt(var_0.script_linkto, "script_linkname");

  if(!isDefined(var_1)) {
    return;
  }

  self setlookatent(var_1);
  self.set_lookat_point = 1;
}

function parsepathlength() {
  if(!isDefined(self.path)) {
    return 0;
  }

  if(isDefined(self.pathduration)) {
    return self.pathduration;
  }

  self.pathduration = 0;
  var_0 = self.path;
  var_1 = var_0.speed;

  for(;;) {
    if(isDefined(var_0.script_unload)) {
      break;
    }

    if(!isDefined(var_0.target)) {
      break;
    }

    var_2 = scripts\engine\utility::getStruct(var_0.target, "targetname");

    if(!isDefined(var_2)) {
      break;
    }

    var_3 = distance(var_0.origin, var_2.origin);

    if(isDefined(var_0.speed)) {
      var_1 = var_0.speed;
    }

    var_4 = 17.6;
    self.pathduration += var_3 * 1.8 / var_1 * var_4;
    var_0 = var_2;
  }

  return self.pathduration;
}