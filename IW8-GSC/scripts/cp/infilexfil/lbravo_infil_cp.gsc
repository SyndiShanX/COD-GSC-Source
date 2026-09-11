/*****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\infilexfil\lbravo_infil_cp.gsc
*****************************************************/

function lbravo_init(var0) {
  initanims(var0);
  var1 = [];
  GscBinSkip0(0x2e, 0, [0, 1]);
}

function lbravo_spawn(var0, var1, var2) {
  var3 = scripts\engine\utility::getStruct(var1, "targetname");
  var4 = spawn("script_origin", var3.origin);
  var4.angles = var3.angles;
  var4.scene_node = var3;

  if(isDefined(var3.target)) {
    var4.path = scripts\engine\utility::getStruct("lbravoAlphaAdvancedPath", "targetname");
  }

  thread infilthink(var4, var0);
  level.infil_struct = var4;
  return var4;
}

function lbravo_get_length(var0) {
  if(isDefined(self.path)) {
    var1 = parsepathlength();
    var1 += getanimlength(level.scr_anim["slot_0"]["lbravo_infil_" + var0 + "_loop_exit"]);
    var1 += getanimlength(level.scr_anim["slot_0"]["lbravo_infil_" + var0 + "_exit"]);
    return var1;
  }

  var2 = getanimlength(level.scr_anim["slot_0"]["lbravo_infil_" + var1]);
  var2 += getanimlength(level.scr_anim["slot_0"]["lbravo_infil_" + var1 + "_exit"]);
  return var2;
}

function player_lbravo_infil_think(var0, var1) {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self endon("player_free_spot");
  self endon("joined_team");
  scripts\cp\cp_outofbounds::enableoobimmunity(self);

  if(isPlayer(self)) {
    self setclienttriggeraudiozone("lbravo_infil_intro", 1);
  }

  thread player_infil_end(var0);
  thread scripts\cp\cp_infilexfil::infil_player_rig("slot_" + var1, "viewhands_base_iw8");
  self.player_rig.weapon_state_func = &scripts\cp\cp_infilexfil::handleweaponstatenotetrackcp;
  self.player_rig linkTo(var0.linktoent, "origin_animate_jnt", (0, 0, 0), (0, 0, 0));
  self predictstreampos(var0.linktoent.origin);
  self lerpfovbypreset("80_instant");
  self setdemeanorviewmodel("safe", "iw8_ges_demeanor_safe_heli");
  thread scripts\cp\cp_infilexfil::infil_scene_fade_in(0, 0.55, "fade_up");
  thread player_van_disconnect();
  scripts\engine\utility::waittill_any_ents(level, "start_scene", var0, "start_scene");

  if(isDefined(self.team) && self.team != "spectator") {
    self setsoundsubmix("iw8_cp_intro_outro");
    self setplayermusicstate("cp_lbravo_infil");
  }

  self.is_doing_infil = 1;
  self notify("open_loadout_menu");
  self notify("fade_up");
  self setcinematicmotionoverride("disabled");

  if(isDefined(var0.path)) {
    thread playerthinkpath(var0, var1);
  } else {
    thread playerthinkanim(var0, var1);
  }

  self lerpfovbypreset("default");
}

function playerthinkpath(var0, var1) {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self endon("player_free_spot");
  self endon("joined_team");

  if(var1 == 0) {
    self lerpviewangleclamp(1, 0.25, 0.25, 10, 45, 45, 30);
  } else if(var1 == 1) {
    self lerpviewangleclamp(1, 0.25, 0.25, 45, 10, 45, 30);
  } else {
    self lerpviewangleclamp(1, 0.25, 0.25, 45, 45, 45, 30);
  }

  rideloop(var0);
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
  var0 notify("prematch_over");
  level notify("prematch_over");
}

function rideloop(var0) {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self endon("player_free_spot");
  self endon("joined_team");
  var0.linktoent endon("unload");

  for(;;) {
    var0.linktoent thread scripts\cp\cp_anim::anim_player_solo(self, self.player_rig, "lbravo_infil_" + var0.subtype + "_loop", "origin_animate_jnt");
    wait 10;
  }
}

function playerthinkanim(var0, var1) {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self endon("player_free_spot");
  self endon("joined_team");
  self lerpviewangleclamp(1, 0.25, 0.25, 30, 30, 30, 30);
  var0.linktoent scripts\cp\cp_anim::anim_player_solo(self, self.player_rig, "lbravo_infil_" + var0.subtype, "origin_animate_jnt");
  self lerpviewangleclamp(1, 0.25, 0.25, 0, 0, 0, 0);
  self.player_rig unlink();
  self setdemeanorviewmodel("normal");
  self stopviewmodelanim();
  scripts\cp\cp_infilexfil::takegunlesscp();
  self clearsoundsubmix("iw8_cp_intro_outro");
  var0 notify("prematch_over");
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

function player_infil_end(var0) {
  self endon("disconnect");
  scripts\engine\utility::waittill_any_ents(level, "prematch_over", var0, "prematch_over");
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

function infilthink(var0, var1) {
  level endon("game_ended");

  foreach(var3 in getEntArray("infil_delete", "script_noteworthy")) {
    var3 delete();
  }

  thread vehiclethink(var0, self.scene_node, var1);
  thread actorthink(var0, self.scene_node, var1);
  scripts\engine\utility::waittill_any_ents(level, "infil_started", self, "infil_started");
  setDvar("TLMMOPMSK", 1);
  level notify("start_scene");
  self notify("start_scene");
  var5 = lbravo_get_length(var1);
  wait var5;
  scripts\engine\utility::waittill_any_ents(level, "prematch_over", self, "prematch_over");
  setDvar("TLMMOPMSK", 0);

  while(isDefined(self.linktoent) || isDefined(self.actors)) {
    waitframe();
  }

  self delete();
}

function vehiclethink(var0, var1, var2, var3) {
  level endon("game_ended");
  self.linktoent = spawninfilvehicle(var1, var0, var2);

  if(isDefined(self.path)) {
    thread vehiclethinkpath(var0, var1, var2, var3);
    return;
  }

  thread vehiclethinkanim(var0, var1, var2, var3);
}

function vehiclethinkanim(var0, var1, var2, var3) {
  scripts\common\anim::anim_first_frame_solo(self.linktoent, "lbravo_infil_" + var2);
  scripts\engine\utility::waittill_any_ents(level, "infil_started", self, "infil_started");
  thread scripts\common\anim::anim_single_solo(self.linktoent, "lbravo_infil_" + var2);
  var4 = getanimlength(level.scr_anim[self.linktoent.animname]["lbravo_infil_" + var2]);
  wait var4;
  self.linktoent delete();
  self.linktoent = undefined;
}

function spawninfilvehicle(var0, var1, var2) {
  var3 = var0.origin;
  var4 = var0.angles;

  if(isDefined(self.path)) {
    var3 = self.path.origin;
    var4 = self.path.angles;
  }

  var5 = spawnVehicle("veh8_mil_air_lbravo_personnel_cp", var2, "lbravo_infil_cp", var3, var4);
  var5 setvehicleteam(var1);
  var5.animname = "lbravo";
  var5 setCanDamage(0);
  var5 setscriptablepartstate("engine", "on", 0);
  var5.infil = self;

  if(isDefined(level.ref_1356f)) {
    level thread[[level.ref_1356f]](var5);
  }

  return var5;
}

function actorthink(var0, var1, var2, var3) {
  level endon("game_ended");
  self.actors = thread spawnactors(var0, var2, var3);
  self.actors[0].anim_playsound_func = &commander_play_sound_func;
  self.linktoent scripts\common\anim::anim_first_frame(self.actors, "lbravo_infil_" + var2, "origin_animate_jnt");
  scripts\mp\utility\infilexfil::hideactors();
  scripts\engine\utility::waittill_any_ents(level, "infil_started", self, "infil_started");
  scripts\mp\utility\infilexfil::showactors();

  if(isDefined(self.path)) {
    actorthinkpath(var0, var1, var2, var3);
    return;
  }

  actorthinkanim(var0, var1, var2, var3);
}

function actorthinkpath(var0, var1, var2, var3) {
  if(isDefined(level.watchfraggrenadeexplode)) {
    level thread[[level.watchfraggrenadeexplode]](self);
    return;
  }

  autoassignfirstquest(self);
}

function autoassignfirstquest(var0) {
  thread actorloopthink(var0);
  thread actorloopthink(var0);
}

function actorloopthink(var0) {
  actorloop(var0);
  self.linktoent scripts\common\anim::anim_single_solo(var0, "lbravo_infil_" + self.subtype + "_loop_exit", "origin_animate_jnt");
}

function actorloop(var0) {
  self.linktoent endon("unload");

  for(;;) {
    self.linktoent scripts\common\anim::anim_single_solo(var0, "lbravo_infil_" + self.subtype + "_loop", "origin_animate_jnt");
  }
}

function actorthinkanim(var0, var1, var2, var3) {
  self.linktoent thread scripts\common\anim::anim_single(self.actors, "lbravo_infil_" + var2, "origin_animate_jnt");
  var4 = getanimlength(level.scr_anim["pilot"]["lbravo_infil_" + var2]);
  wait var4;

  foreach(var6 in self.actors) {
    var6 delete();
  }

  self.actors = undefined;
}

function spawnactors(var0, var1, var2) {
  var3 = [];
  GscBinSkip0(0x2e, var3.size, spawn_anim_model(self.linktoent, "pilot", "origin_animate_jnt", "allied_pilot_fullbody_1"));
}

function spawn_anim_model(var0, var1, var2, var3, var4) {
  var5 = spawn("script_model", (0, 0, 0));
  var5 setModel(var2);

  if(isDefined(var3)) {
    var6 = spawn("script_model", (0, 0, 0));
    var6 setModel(var3);
    var6 linkTo(var5, "j_spine4", (0, 0, 0), (0, 0, 0));
    var5.head = var6;
    var5 thread scripts\engine\utility::delete_on_death(var6);
  }

  if(isDefined(var4)) {
    var7 = spawn("script_model", (0, 0, 0));
    var7 setModel(var4);
    var7 linkTo(var5, "j_gun", (0, 0, 0), (0, 0, 0));
    var5 thread scripts\engine\utility::delete_on_death(var7);
    var5.weapon = var7;
  }

  var5.animname = var0;
  var5 scripts\common\anim::setanimtree();

  if(isDefined(var1)) {
    thread scripts\engine\utility::delete_on_death(var5);
    var5 linkTo(self, var1, (0, 0, 0), (0, 0, 0));
  }

  return var5;
}

function initanims(var0) {
  script_model_alpha_anims(var0);
  vehicles_alpha_anims(var0);
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

function script_model_alpha_anims(var0) {
  switch (var0) {
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

function vehicles_alpha_anims(var0) {
  switch (var0) {
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

function commander_play_sound_func(var0, var1, var2) {
  foreach(var4 in self.infil.players) {
    self playsoundtoplayer(var0, var4);
  }
}

function vehiclethinkpath(var0, var1, var2, var3) {
  level waittill("infil_started");
  self.linktoent endon("death");
  self.linktoent.unload_hover_offset = 116;
  self.linktoent.unload_time = 3.5;
  vehicle_paths_helicopter(self.linktoent, self.path);
  thread gopath(self.linktoent);
}

function vehiclefollowpath(var0) {
  self endon("death");
  self endon("stop_follow_path");
  self startpath(var0);

  for(var1 = scripts\engine\utility::getStruct(var0.target, "targetname"); isDefined(var1); var1 = scripts\engine\utility::getStruct(var1.target, "targetname")) {
    var1 waittill("trigger");

    if(!isDefined(var1.target)) {
      break;
    }
  }

  self vehicle_setspeedimmediate(0, 30, 30);

  for(var2 = self vehicle_getspeed(); var2 > 1; var2 = self vehicle_getspeed()) {
    wait 0.1;
  }
}

function gopath(var0) {
  if(!isDefined(var0)) {
    var0 = self;
  }

  var0 endon("death");

  if(isDefined(var0.hasstarted)) {
    return;
  } else {
    var0.hasstarted = 1;
  }

  var0 scripts\engine\utility::script_delay();
  var0 notify("start_vehiclepath");
  var0 notify("start_dynamicpath");
}

function vehicle_paths_helicopter(var0, var1, var2) {
  self notify("newpath");
  self endon("newpath");
  self endon("death");

  if(!isDefined(var1)) {
    var1 = 0;
  }

  if(isDefined(var0)) {
    self.attachedpath = var0;
  }

  var3 = self.attachedpath;
  self.currentnode = self.attachedpath;

  if(!isDefined(var3)) {
    return;
  }

  var4 = var3;

  if(var1) {
    self waittill("start_dynamicpath");
  }

  if(isDefined(var2)) {
    var5 = spawnStruct();
    var5.origin = (self.origin[0], self.origin[1], self.origin[2] + var2);
    heli_wait_node(var5, undefined);
  }

  var6 = undefined;
  var7 = var3;
  var8 = get_path_getfunc(var3);

  while(isDefined(var7)) {
    if(isDefined(var7.script_linkto)) {
      set_lookat_from_dest(var7);
    }

    heli_wait_node(var7, var6, var2);

    if(!isDefined(self)) {
      return;
    }

    self.currentnode = var7;
    var7 notify("trigger", self);

    if(isDefined(var7.script_delete)) {
      self delete();
      return;
    }

    if(isDefined(var7.script_helimove)) {
      self setyawspeedbyname(var7.script_helimove);

      if(var7.script_helimove == "faster") {
        self setmaxpitchroll(25, 50);
      }
    }

    if(!isDefined(self)) {
      return;
    }

    if(isDefined(var7.script_team)) {
      self.script_team = var7.script_team;
    }

    if(isDefined(var7.script_unload)) {
      self notify("unload");
      scripts\engine\utility::waittill_notify_or_timeout("unloaded", self.unload_time);
      level notify("players_unloaded_from_infil");
    }

    if(self vehicle_isphysveh()) {
      if(isDefined(var7.script_pathtype)) {
        self.veh_pathtype = var7.script_pathtype;
      }
    }

    if(isDefined(var7.script_flag_wait)) {
      scripts\engine\utility::flag_wait(var7.script_flag_wait);

      if(isDefined(var7.script_delay_post)) {
        wait var7.script_delay_post;
      }

      self notify("delay_passed");
    }

    if(isDefined(self.set_lookat_point)) {
      self.set_lookat_point = undefined;
      self clearlookatent();
    }

    var6 = var7;

    if(!isDefined(var7.target)) {
      break;
    }

    var7 = [[var8]](var7.target);

    if(!isDefined(var7)) {
      var7 = var6;
      break;
    }
  }

  self notify("reached_dynamic_path_end");

  if(isDefined(self.script_vehicle_selfremove)) {
    self delete();
    return;
  }
}

function heli_wait_node(var0, var1, var2) {
  self endon("newpath");

  if(isDefined(var0.script_unload) || isDefined(var0.script_land)) {
    var3 = 0;

    if(isDefined(var0.script_land)) {
      scripts\engine\utility::ent_flag_set("landed");

      if(isDefined(self.unload_land_offset)) {
        var3 = self.unload_land_offset;
      }
    } else if(isDefined(var0.script_unload) && isDefined(self.unload_hover_offset)) {
      var3 = self.unload_hover_offset;
    } else if(isDefined(var0.script_unload) && isDefined(self.unload_hover_offset_max)) {
      var4 = scripts\common\utility::groundpos(var0.origin);
      var3 = var0.origin[2] - var4[2];

      if(var3 >= self.unload_hover_offset_max) {
        var3 = self.unload_hover_offset_max;
      } else if(isDefined(self.unload_hover_land_height) && var3 < self.unload_hover_land_height) {
        var3 = self.unload_hover_land_height;
      }
    }

    var0.radius = 2;

    if(isDefined(var0.ground_pos)) {
      var0.origin = var0.ground_pos + (0, 0, var3);
    } else {
      var5 = scripts\common\utility::groundpos(var0.origin) + (0, 0, var3);

      if(var5[2] > var0.origin[2] - 2000) {
        var0.origin = scripts\common\utility::groundpos(var0.origin) + (0, 0, var3);
      }
    }

    self sethoverparams(0, 0, 0);
  }

  if(isDefined(var1)) {
    var6 = var1.script_airresistance;
    var7 = var1.speed;
    var8 = var1.script_accel;
    var9 = var1.script_decel;
  } else {
    var6 = undefined;
    var7 = undefined;
    var8 = undefined;
    var9 = undefined;
  }

  var10 = isDefined(var7.script_stopnode) && var7.script_stopnode;
  var11 = isDefined(var7.script_unload);
  var12 = isDefined(var7.script_flag_wait) && !scripts\engine\utility::flag(var7.script_flag_wait);
  var13 = !isDefined(var7.target);
  var14 = isDefined(var7.script_delay);

  if(isDefined(var7.angles)) {
    var15 = var7.angles[1];
  } else {
    var15 = 0;
  }

  if(self.health <= 0) {
    return;
  }

  var16 = var8.origin;

  if(isDefined(var6)) {
    var16 = (var16[0], var16[1], var16[2] + var6);
  }

  if(isDefined(self.heliheightoverride)) {
    var16 = (var16[0], var16[1], self.heliheightoverride);
  }

  self vehicle_helisetai(var16, var8, var9, var10, var8.script_goalyaw, var8.script_anglevehicle, var15, var7, var15, var11, var12, var13, var14);

  if(isDefined(var8.radius)) {
    self setneargoalnotifydist(var8.radius);
    scripts\engine\utility::ref_143a5("near_goal", "goal");
  } else {
    self waittill("goal");
  }

  if(isDefined(var8.script_flag_set)) {
    level notify(var8.script_flag_set);
  }

  if(isDefined(var8.script_firelink)) {
    if(isDefined(level.helicopter_firelinkfunk)) {}

    GscBinSkip1(0x74, level.helicopter_firelinkfunk, var8);
  }

  var8 scripts\engine\utility::script_delay();

  if(isDefined(self.path_gobbler)) {
    scripts\engine\utility::deletestruct_ref(var8);
  }

  self notify("continuepath");
}

function get_path_getfunc(var0) {
  var1 = &get_from_vehicle_node;

  if(isDefined(var0.target)) {
    if(isDefined(get_from_entity(var0.target))) {
      var1 = &get_from_entity;
    }

    if(isDefined(get_from_spawnStruct(var0.target))) {
      var1 = &get_from_spawnstruct;
    }
  }

  return var1;
}

function get_from_vehicle_node(var0) {
  return getvehiclenode(var0, "targetname");
}

function get_from_spawnStruct(var0) {
  return scripts\engine\utility::getStruct(var0, "targetname");
}

function get_from_entity(var0) {
  var1 = getEntArray(var0, "targetname");

  if(isDefined(var1) && var1.size > 0) {
    return var1[randomint(var1.size)];
  }

  return undefined;
}

function set_lookat_from_dest(var0) {
  var1 = getEnt(var0.script_linkto, "script_linkname");

  if(!isDefined(var1)) {
    return;
  }

  self setlookatent(var1);
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
  var0 = self.path;
  var1 = var0.speed;

  for(;;) {
    if(isDefined(var0.script_unload)) {
      break;
    }

    if(!isDefined(var0.target)) {
      break;
    }

    var2 = scripts\engine\utility::getStruct(var0.target, "targetname");

    if(!isDefined(var2)) {
      break;
    }

    var3 = distance(var0.origin, var2.origin);

    if(isDefined(var0.speed)) {
      var1 = var0.speed;
    }

    var4 = 17.6;
    self.pathduration += var3 * 1.8 / var1 * var4;
    var0 = var2;
  }

  return self.pathduration;
}