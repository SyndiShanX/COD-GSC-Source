/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\infilexfil\van_infil.gsc
***********************************************/

van_init(subtype) {
  _id_7AB5B649FA408138::_id_0F1AED36AB4598EA("van_infil");
  initanims(subtype);
  _id_453E4FC2C649FEA4 = [];
  _id_453E4FC2C649FEA4[0] = [0];
  _id_453E4FC2C649FEA4[1] = [1];
  _id_453E4FC2C649FEA4[2] = [2, 3, 4, 5];
  thread scripts\mp\infilexfil\infilexfil::infil_add("infil_van", subtype, 6, 4, _id_453E4FC2C649FEA4, ::_id_11AB2A30C47F0B5E, ::_id_91F416A3ECE2EF9A, ::_id_F67856E4FBB899A0);
}

_id_11AB2A30C47F0B5E(team, target, subtype, originalsubtype) {
  scene_node = scripts\engine\utility::getStruct(target, "targetname");
  infil = spawn("script_origin", scene_node.origin);
  infil.angles = scene_node.angles;
  infil.scene_node = scene_node;
  infil thread infilthink(team, subtype);
  return infil;
}

_id_91F416A3ECE2EF9A(subtype) {
  animlength = getanimlength(level.scr_anim["slot_0"]["van_infil"]);
  return animlength;
}

_id_F67856E4FBB899A0(infil, _id_E4B9CD561C7C0DE6) {
  self endon("player_free_spot");
  thread player_infil_end();

  if(isPlayer(self))
    self setclienttriggeraudiozone("van_preinfil_mix", 1);

  thread infil_radio_idle(infil);
  spawnpos = infil.linktoent gettagorigin("tag_origin_animate");
  _id_B7850001037AA074 = infil.linktoent gettagangles("tag_origin_animate");
  thread scripts\mp\utility\infilexfil::infil_player_rig_updated("slot_" + _id_E4B9CD561C7C0DE6, spawnpos, _id_B7850001037AA074);
  self.player_rig linkTo(infil.linktoent, "tag_origin_animate");
  self setdemeanorviewmodel("safe", "iw8_ges_demeanor_safe_van");
  self visionsetnakedforplayer("mp_core_infil", 0.0);
  self.player_rig.weapon_state_func = scripts\mp\utility\infilexfil::handleweaponstatenotetrack;
  thread player_disconnect();
  level waittill("start_scene");
  thread scripts\mp\music_and_dialog::_id_03AA69E0E6827CE5();

  if(isDefined(self.animname) && !isai(self))
    thread _id_ACB0A5EF09F5F702();

  self setcinematicmotionoverride("disabled");
  self lerpviewangleclamp(1, 0.25, 0.25, 15, 15, 30, 5);
  thread scripts\mp\infilexfil\infilexfil::_id_D41CBA513A03D958(0.5);
  infil.linktoent scripts\mp\anim::anim_player_solo(self, self.player_rig, "van_infil", "tag_origin_animate");
  thread scripts\mp\class::unblockclasschange();

  if(isDefined(level.scr_viewmodelanim[self.animname]) && isDefined(level.scr_viewmodelanim[self.animname]["van_infil_" + infil.subtype + "_intro"]))
    setDvar("depthSortViewmodel", 0);

  thread clear_infil_ambient_zone();

  if(isDefined(self.player_rig) && self.player_rig islinked())
    self.player_rig unlink();

  self visionsetnakedforplayer("", 0.75);
  self setdemeanorviewmodel("normal");
  self clearcinematicmotionoverride();
  self disablephysicaldepthoffieldscripting();
}

_id_ACB0A5EF09F5F702() {
  soundalias = "scn_infil_van_plr1";
  waittime = 4.9;

  switch (self.animname) {
    case "slot_0":
      soundalias = "scn_infil_van_plr1";
      waittime = 4.9;
      break;
    case "slot_1":
      soundalias = "scn_infil_van_plr2";
      waittime = 2.1;
      break;
    case "slot_2":
      soundalias = "scn_infil_van_plr3";
      waittime = 8.3;
      break;
    case "slot_3":
      soundalias = "scn_infil_van_plr4";
      waittime = 9.5;
      break;
    case "slot_4":
      soundalias = "scn_infil_van_plr5";
      waittime = 9.5;
      break;
    case "slot_5":
      soundalias = "scn_infil_van_plr6";
      waittime = 3.0;
      break;
    default:
      soundalias = "scn_infil_van_plr1";
      waittime = 4.9;
      break;
  }

  self setclienttriggeraudiozone("iw9_gen_infil_mix", 2);
  wait(waittime);

  if(soundexists(soundalias))
    self playlocalsound(soundalias);
}

clear_infil_ambient_zone() {
  self endon("death_or_disconnect");
  wait 3;
  self clearclienttriggeraudiozone(2);
  self clearallsoundsubmixes();
}

player_infil_end() {
  self endon("disconnect");
  level waittill("prematch_over");
  self notify("remove_rig");
  self clearclienttriggeraudiozone(1.0);
  self lerpfovbypreset("default_2seconds");
  self lerpfovscalefactor(1, 2);
  scripts\mp\utility\player::setdof_default();
  setDvar("depthSortViewmodel", 0);
}

player_disconnect() {
  level endon("prematch_over");
  self waittill("death_or_disconnect");

  if(isDefined(self)) {
    self visionsetnakedforplayer("");
    self clearclienttriggeraudiozone(0.0);
    self lerpfovbypreset("default");
    self setviewmodeldepthoffield(0, 0, 18);
    scripts\mp\utility\player::setdof_default();
  }
}

actorthink(team, scene_node, _id_CA85A0DE365C6A63, _id_16E334D22D37BE73) {
  thread spawnactors(team, _id_CA85A0DE365C6A63, _id_16E334D22D37BE73);
  self.linktoent scripts\common\anim::anim_first_frame(self.actors, "van_infil", "tag_origin_animate");
  scripts\mp\flags::gameflagwait("infil_started");
  self.linktoent thread scripts\common\anim::anim_single(self.actors, "van_infil", "tag_origin_animate");
  self.actors[0].head scriptmodelplayanim(level.scr_anim[self.actors[0].animname]["van_infil"]);
  self.actors[1].head scriptmodelplayanim(level.scr_anim[self.actors[1].animname]["van_infil"]);
  duration = getanimlength(level.scr_anim["chief"]["van_infil"]);
  wait(duration);

  foreach(actor in self.actors) {
    if(isDefined(actor))
      actor delete();
  }

  self.actors = undefined;
}

spawnactors(team, _id_CA85A0DE365C6A63, _id_16E334D22D37BE73) {
  if(!isDefined(self.actors))
    self.actors = [];

  switch (team) {
    case "axis":
      self.actors[self.actors.size] = self.linktoent spawn_anim_model("driver", "tag_origin_animate", "body_mp_milsim_east_iw9_1_1", "head_mp_milsim_east_iw9_1_1");
      self.actors[self.actors.size] = self.linktoent spawn_anim_model("chief", "tag_origin_animate", "body_mp_milsim_east_iw9_1_1", "head_mp_milsim_east_iw9_1_1");
      break;
    case "allies":
      self.actors[self.actors.size] = self.linktoent spawn_anim_model("driver", "tag_origin_animate", "body_mp_milsim_west_iw9_1_1", "head_mp_milsim_west_iw9_1_1");
      self.actors[self.actors.size] = self.linktoent spawn_anim_model("chief", "tag_origin_animate", "body_mp_milsim_west_iw9_1_1", "head_mp_milsim_west_iw9_1_1");
      break;
    default:
      self.actors[self.actors.size] = self.linktoent spawn_anim_model("driver", "tag_origin_animate", "body_mp_milsim_east_iw9_1_1", "head_mp_milsim_east_iw9_1_1");
      self.actors[self.actors.size] = self.linktoent spawn_anim_model("chief", "tag_origin_animate", "body_mp_milsim_east_iw9_1_1", "head_mp_milsim_east_iw9_1_1");
      break;
  }

  foreach(actor in self.actors)
  actor.infil = self;
}

spawn_anim_model(animname, _id_0609C1B125A13456, body, head, weapon) {
  guy = spawn("script_model", (0, 0, 0));
  guy setModel(body);

  if(isDefined(head)) {
    _id_F4246828592F1C0F = spawn("script_model", (0, 0, 0));
    _id_F4246828592F1C0F setModel(head);
    _id_F4246828592F1C0F linkTo(guy, "j_spine4", (0, 0, 0), (0, 0, 0));
    guy.head = _id_F4246828592F1C0F;
    guy thread scripts\engine\utility::delete_on_death(_id_F4246828592F1C0F);
  }

  if(isDefined(weapon)) {
    _id_E71CCB5E6023BCDD = spawn("script_model", (0, 0, 0));
    _id_E71CCB5E6023BCDD setModel(weapon);
    _id_E71CCB5E6023BCDD linkTo(guy, "j_gun", (0, 0, 0), (0, 0, 0));
    guy thread scripts\engine\utility::delete_on_death(_id_E71CCB5E6023BCDD);
    guy.weapon = _id_E71CCB5E6023BCDD;
  }

  guy.animname = animname;
  guy scripts\common\anim::setanimtree();

  if(isDefined(_id_0609C1B125A13456)) {
    thread scripts\engine\utility::delete_on_death(guy);
    guy linkTo(self, _id_0609C1B125A13456, (0, 0, 0), (0, 0, 0));
  }

  if(animname == "chief")
    guy hidepart("j_sling_pivot");

  return guy;
}

infilthink(team, _id_CA85A0DE365C6A63) {
  foreach(ent in getEntArray("infil_delete", "script_noteworthy"))
  ent delete();

  thread vehiclethink(team, self.scene_node, _id_CA85A0DE365C6A63);
  thread actorthink(team, self.scene_node, _id_CA85A0DE365C6A63);
  level waittill("infil_started");
  setDvar("r_spotLightEntityShadows", 1);
  level notify("start_scene");
  level waittill("prematch_over");
  setDvar("r_spotLightEntityShadows", 0);

  while(isDefined(self.actors))
    waitframe();

  level.infilsactive--;
  self delete();
}

vehiclethink(team, scene_node, _id_CA85A0DE365C6A63, _id_16E334D22D37BE73) {
  van = spawnvan(scene_node, team, _id_CA85A0DE365C6A63);
  self._id_ADDD3217BC59A7B8 = _id_BBFDAED21B5CDDBB(_id_CA85A0DE365C6A63);

  if(!isDefined(self.path))
    scripts\common\anim::anim_first_frame_solo(van, "van_infil");

  van vehicle_turnengineoff();
  van thread _id_E3E8566B27B746CB();
  level waittill("infil_started");
  self.linktoent _id_FFA1124C73DA1AB3(self._id_ADDD3217BC59A7B8);
  thread scripts\common\anim::anim_single_solo(van, "van_infil");
  scripts\mp\infilexfil\infilexfil::_id_4DCA5340DFD36C76(scene_node, van, getanimlength(level.scr_anim["chief"]["van_infil"]), "van", "van_infil");
  level waittill("prematch_over");
  level thread _id_E85C746A9EAA79F3();
}

_id_E85C746A9EAA79F3() {
  wait 5;
  _id_7AB5B649FA408138::_id_F4E0FF5CB899686D("van_infil");
}

_id_E3E8566B27B746CB() {
  _id_86E566189D013726 = spawn("script_model", self gettagorigin("tag_hood"));
  _id_86E566189D013726 linkTo(self, "tag_hood");
  _id_2A4B36BF48CBB639 = spawn("script_model", self gettagorigin("tag_window_rear_left"));
  _id_2A4B36BF48CBB639 linkTo(self, "tag_window_rear_left");
  level waittill("infil_started");
  _id_86E566189D013726 playsoundonmovingent("scn_infil_van_driving_front");
  _id_2A4B36BF48CBB639 playsoundonmovingent("scn_infil_van_driving_rear");
  level waittill("prematch_over");
  _id_86E566189D013726 delete();
  _id_2A4B36BF48CBB639 delete();
}

initanims(subtype) {
  _id_487431CF3B99E0B8(subtype);
  _id_07B7D0C2DB72B128(subtype);
  scripts\common\anim::addnotetrack_customfunction("slot_0", "fov_63_2", scripts\mp\utility\infilexfil::player_fov_default_2);
  scripts\common\anim::addnotetrack_customfunction("slot_1", "fov_63_2", scripts\mp\utility\infilexfil::player_fov_default_2);
  scripts\common\anim::addnotetrack_customfunction("slot_2", "fov_63_2", scripts\mp\utility\infilexfil::player_fov_default_2);
  scripts\common\anim::addnotetrack_customfunction("slot_3", "fov_63_2", scripts\mp\utility\infilexfil::player_fov_default_2);
  scripts\common\anim::addnotetrack_customfunction("slot_4", "fov_63_2", scripts\mp\utility\infilexfil::player_fov_default_2);
  scripts\common\anim::addnotetrack_customfunction("slot_5", "fov_63_2", scripts\mp\utility\infilexfil::player_fov_default_2);
  scripts\common\anim::addnotetrack_customfunction("slot_0", "free_look", scripts\mp\utility\infilexfil::player_free_look, "van_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_1", "free_look", scripts\mp\utility\infilexfil::player_free_look, "van_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_2", "free_look", scripts\mp\utility\infilexfil::player_free_look, "van_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_3", "free_look", scripts\mp\utility\infilexfil::player_free_look, "van_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_4", "free_look", scripts\mp\utility\infilexfil::player_free_look, "van_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_5", "free_look", scripts\mp\utility\infilexfil::player_free_look, "van_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_0", "shake_on", scripts\mp\utility\infilexfil::rumble_low, "van_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_1", "shake_on", scripts\mp\utility\infilexfil::rumble_low, "van_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_2", "shake_on", scripts\mp\utility\infilexfil::rumble_low, "van_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_3", "shake_on", scripts\mp\utility\infilexfil::rumble_low, "van_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_4", "shake_on", scripts\mp\utility\infilexfil::rumble_low, "van_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_5", "shake_on", scripts\mp\utility\infilexfil::rumble_low, "van_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_0", "shake_running", scripts\mp\utility\infilexfil::cam_shake_running, "van_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_1", "shake_running", scripts\mp\utility\infilexfil::cam_shake_running, "van_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_2", "shake_running", scripts\mp\utility\infilexfil::cam_shake_running, "van_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_3", "shake_running", scripts\mp\utility\infilexfil::cam_shake_running, "van_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_4", "shake_running", scripts\mp\utility\infilexfil::cam_shake_running, "van_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_5", "shake_running", scripts\mp\utility\infilexfil::cam_shake_running, "van_infil");
  scripts\common\anim::addnotetrack_customfunction("chief", "van_chief_sfx", ::_id_A0F56B3EC08B2E78, "van_infil");
  scripts\common\anim::addnotetrack_customfunction("chief", "van_door_sfx", ::_id_B81E9C558F4DE6CB, "van_infil");
  scripts\common\anim::addnotetrack_customfunction("chief", "van_close_sfx", ::_id_18B3E1AE919D6F5D, "van_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_0", "scn_infil_van_npc1", ::_id_AAF7FE816CCDF1B3, "van_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_1", "scn_infil_van_npc2", ::_id_AAF7FF816CCDF3E6, "van_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_2", "scn_infil_van_npc3", ::_id_AAF800816CCDF619, "van_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_3", "scn_infil_van_npc4", ::_id_AAF801816CCDF84C, "van_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_4", "scn_infil_van_npc5", ::_id_AAF802816CCDFA7F, "van_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_5", "scn_infil_van_npc6", ::_id_AAF803816CCDFCB2, "van_infil");
}

#using_animtree("script_model");

script_model_anims(subtype) {
  switch (subtype) {
    case "alpha":
    case "bravo":
      level.scr_animtree["slot_0"] = #animtree;
      level.scr_anim["slot_0"]["van_infil"] = % iw9_mp_infil_van_seat_0;
      level.scr_animname["slot_0"]["van_infil"] = "iw9_mp_infil_van_seat_0";
      level.scr_eventanim["slot_0"]["van_infil"] = "infil_van_seat_0";
      level.scr_animtree["slot_1"] = #animtree;
      level.scr_anim["slot_1"]["van_infil"] = % iw9_mp_infil_van_seat_1;
      level.scr_animname["slot_1"]["van_infil"] = "iw9_mp_infil_van_seat_1";
      level.scr_eventanim["slot_1"]["van_infil"] = "infil_van_seat_1";
      level.scr_animtree["slot_2"] = #animtree;
      level.scr_anim["slot_2"]["van_infil"] = % iw9_mp_infil_van_seat_2;
      level.scr_animname["slot_2"]["van_infil"] = "iw9_mp_infil_van_seat_2";
      level.scr_eventanim["slot_2"]["van_infil"] = "infil_van_seat_2";
      level.scr_animtree["slot_3"] = #animtree;
      level.scr_anim["slot_3"]["van_infil"] = % iw9_mp_infil_van_seat_3;
      level.scr_animname["slot_3"]["van_infil"] = "iw9_mp_infil_van_seat_3";
      level.scr_eventanim["slot_3"]["van_infil"] = "infil_van_seat_3";
      level.scr_animtree["slot_4"] = #animtree;
      level.scr_anim["slot_4"]["van_infil"] = % iw9_mp_infil_van_seat_4;
      level.scr_animname["slot_4"]["van_infil"] = "iw9_mp_infil_van_seat_4";
      level.scr_eventanim["slot_4"]["van_infil"] = "infil_van_seat_4";
      level.scr_animtree["slot_5"] = #animtree;
      level.scr_anim["slot_5"]["van_infil"] = % iw9_mp_infil_van_seat_5;
      level.scr_animname["slot_5"]["van_infil"] = "iw9_mp_infil_van_seat_5";
      level.scr_eventanim["slot_5"]["van_infil"] = "infil_van_seat_5";
      level.scr_animtree["chief"] = #animtree;
      level.scr_anim["chief"]["van_infil"] = % iw9_mp_infil_van_chief;
      level.scr_animname["chief"]["van_infil"] = "iw9_mp_infil_van_chief";
      level.scr_eventanim["chief"]["van_infil"] = "infil_van_chief";
      level.scr_animtree["driver"] = #animtree;
      level.scr_anim["driver"]["van_infil"] = % iw9_mp_infil_van_driver;
      level.scr_animname["driver"]["van_infil"] = "iw9_mp_infil_van_driver";
      level.scr_eventanim["driver"]["van_infil"] = "infil_van_driver";
      break;
  }
}

_id_487431CF3B99E0B8(subtype) {
  mapname = scripts\cp_mp\utility\game_utility::getmapname();

  switch (mapname) {
    case "mp_fort":
      level.scr_animtree["slot_0"] = #animtree;
      level.scr_anim["slot_0"]["van_infil"] = % iw9_mp_infil_van_fort_seat_0;
      level.scr_animname["slot_0"]["van_infil"] = "iw9_mp_infil_van_fort_seat_0";
      level.scr_eventanim["slot_0"]["van_infil"] = "infil_van_fort_seat_0";
      level.scr_animtree["slot_1"] = #animtree;
      level.scr_anim["slot_1"]["van_infil"] = % iw9_mp_infil_van_fort_seat_1;
      level.scr_animname["slot_1"]["van_infil"] = "iw9_mp_infil_van_fort_seat_1";
      level.scr_eventanim["slot_1"]["van_infil"] = "infil_van_fort_seat_1";
      level.scr_animtree["slot_2"] = #animtree;
      level.scr_anim["slot_2"]["van_infil"] = % iw9_mp_infil_van_fort_seat_2;
      level.scr_animname["slot_2"]["van_infil"] = "iw9_mp_infil_van_fort_seat_2";
      level.scr_eventanim["slot_2"]["van_infil"] = "infil_van_fort_seat_2";
      level.scr_animtree["slot_3"] = #animtree;
      level.scr_anim["slot_3"]["van_infil"] = % iw9_mp_infil_van_fort_seat_3;
      level.scr_animname["slot_3"]["van_infil"] = "iw9_mp_infil_van_fort_seat_3";
      level.scr_eventanim["slot_3"]["van_infil"] = "infil_van_fort_seat_3";
      level.scr_animtree["slot_4"] = #animtree;
      level.scr_anim["slot_4"]["van_infil"] = % iw9_mp_infil_van_fort_seat_4;
      level.scr_animname["slot_4"]["van_infil"] = "iw9_mp_infil_van_fort_seat_4";
      level.scr_eventanim["slot_4"]["van_infil"] = "infil_van_fort_seat_4";
      level.scr_animtree["slot_5"] = #animtree;
      level.scr_anim["slot_5"]["van_infil"] = % iw9_mp_infil_van_fort_seat_5;
      level.scr_animname["slot_5"]["van_infil"] = "iw9_mp_infil_van_fort_seat_5";
      level.scr_eventanim["slot_5"]["van_infil"] = "infil_van_fort_seat_5";
      level.scr_animtree["chief"] = #animtree;
      level.scr_anim["chief"]["van_infil"] = % iw9_mp_infil_van_fort_chief;
      level.scr_animname["chief"]["van_infil"] = "iw9_mp_infil_van_fort_chief";
      level.scr_eventanim["chief"]["van_infil"] = "infil_van_fort_chief";
      level.scr_animtree["driver"] = #animtree;
      level.scr_anim["driver"]["van_infil"] = % iw9_mp_infil_van_driver;
      level.scr_animname["driver"]["van_infil"] = "iw9_mp_infil_van_driver";
      level.scr_eventanim["driver"]["van_infil"] = "infil_van_driver";
      break;
    default:
      level.scr_animtree["slot_0"] = #animtree;
      level.scr_anim["slot_0"]["van_infil"] = % iw9_mp_infil_van_seat_0;
      level.scr_animname["slot_0"]["van_infil"] = "iw9_mp_infil_van_seat_0";
      level.scr_eventanim["slot_0"]["van_infil"] = "infil_van_seat_0";
      level.scr_animtree["slot_1"] = #animtree;
      level.scr_anim["slot_1"]["van_infil"] = % iw9_mp_infil_van_seat_1;
      level.scr_animname["slot_1"]["van_infil"] = "iw9_mp_infil_van_seat_1";
      level.scr_eventanim["slot_1"]["van_infil"] = "infil_van_seat_1";
      level.scr_animtree["slot_2"] = #animtree;
      level.scr_anim["slot_2"]["van_infil"] = % iw9_mp_infil_van_seat_2;
      level.scr_animname["slot_2"]["van_infil"] = "iw9_mp_infil_van_seat_2";
      level.scr_eventanim["slot_2"]["van_infil"] = "infil_van_seat_2";
      level.scr_animtree["slot_3"] = #animtree;
      level.scr_anim["slot_3"]["van_infil"] = % iw9_mp_infil_van_seat_3;
      level.scr_animname["slot_3"]["van_infil"] = "iw9_mp_infil_van_seat_3";
      level.scr_eventanim["slot_3"]["van_infil"] = "infil_van_seat_3";
      level.scr_animtree["slot_4"] = #animtree;
      level.scr_anim["slot_4"]["van_infil"] = % iw9_mp_infil_van_seat_4;
      level.scr_animname["slot_4"]["van_infil"] = "iw9_mp_infil_van_seat_4";
      level.scr_eventanim["slot_4"]["van_infil"] = "infil_van_seat_4";
      level.scr_animtree["slot_5"] = #animtree;
      level.scr_anim["slot_5"]["van_infil"] = % iw9_mp_infil_van_seat_5;
      level.scr_animname["slot_5"]["van_infil"] = "iw9_mp_infil_van_seat_5";
      level.scr_eventanim["slot_5"]["van_infil"] = "infil_van_seat_5";
      level.scr_animtree["chief"] = #animtree;
      level.scr_anim["chief"]["van_infil"] = % iw9_mp_infil_van_chief;
      level.scr_animname["chief"]["van_infil"] = "iw9_mp_infil_van_chief";
      level.scr_eventanim["chief"]["van_infil"] = "infil_van_chief";
      level.scr_animtree["driver"] = #animtree;
      level.scr_anim["driver"]["van_infil"] = % iw9_mp_infil_van_driver;
      level.scr_animname["driver"]["van_infil"] = "iw9_mp_infil_van_driver";
      level.scr_eventanim["driver"]["van_infil"] = "infil_van_driver";
      break;
  }
}

_id_A0F56B3EC08B2E78(guy) {
  guy playsoundonmovingent("scn_infil_van_chief");
}

_id_B81E9C558F4DE6CB(guy) {
  guy playsoundonmovingent("scn_infil_van_door");
}

_id_18B3E1AE919D6F5D(guy) {
  guy playsoundonmovingent("scn_infil_van_door_close");
}

#using_animtree("mp_vehicles_always_loaded");

_id_068AAB9F69431CE1(subtype) {
  switch (subtype) {
    case "alpha":
      level.scr_animtree["van"] = #animtree;
      level.scr_anim["van"]["van_infil"] = % iw9_mp_infil_van_vehicule_grandprix;
      break;
    case "bravo":
      level.scr_animtree["van"] = #animtree;
      level.scr_anim["van"]["van_infil"] = % iw9_mp_infil_van_vehicule_grandprix;
      break;
  }
}

_id_07B7D0C2DB72B128(subtype) {
  mapname = scripts\cp_mp\utility\game_utility::getmapname();

  switch (mapname) {
    case "mp_fort":
      level.scr_anim["van"]["van_infil"] = % iw9_mp_infil_van_vehicle_fort;
      break;
    case "mp_narcos":
      level.scr_anim["van"]["van_infil"] = % iw9_mp_infil_van_vehicle_narcos;
      break;
    default:
      level.scr_anim["van"]["van_infil"] = % iw9_mp_infil_van_vehicule_grandprix;
      break;
  }
}

spawnvan(scene_node, team, _id_CA85A0DE365C6A63) {
  spawnpos = scene_node.origin;
  _id_B7850001037AA074 = scene_node.angles;

  if(isDefined(self.path)) {
    spawnpos = self.path.origin;
    _id_B7850001037AA074 = self.path.angles;
  }

  vehicle = spawnVehicle("veh9_civ_lnd_van_cargo_windows_infil", _id_CA85A0DE365C6A63, "veh9_civ_lnd_van_cargo_physics_mp", spawnpos, _id_B7850001037AA074);
  vehicle setvehicleteam(team);
  vehicle vehphys_forcekeyframedmotion();
  vehicle.animname = "van";
  self.linktoent = vehicle;
  vehicle.infil = self;
  return vehicle;
}

_id_BBFDAED21B5CDDBB(subtype) {
  _id_ADDD3217BC59A7B8 = spawnStruct();
  _id_5E0676140EECDF2D = "van_" + subtype + "_probe";
  _id_4AE45078DF12C7A7 = "van_" + subtype + "_light";
  probe = getEnt(_id_5E0676140EECDF2D, "script_noteworthy");
  lights = getEntArray(_id_4AE45078DF12C7A7, "targetname");

  if(!isDefined(probe))
    return undefined;

  foreach(_id_AC0E5E4AC96AAEA7 in lights) {
    if(!isDefined(_id_AC0E5E4AC96AAEA7))
      return undefined;
  }

  _id_ADDD3217BC59A7B8.probe = probe;
  _id_ADDD3217BC59A7B8.lights = lights;
  _id_89A2405953B84136(_id_ADDD3217BC59A7B8, 1);
  return _id_ADDD3217BC59A7B8;
}

_id_FFA1124C73DA1AB3(_id_ADDD3217BC59A7B8) {
  if(!isDefined(_id_ADDD3217BC59A7B8)) {
    return;
  }
  _id_ADDD3217BC59A7B8.probe show();
  _id_ADDD3217BC59A7B8.probe linkTo(self, "tag_origin", (0, 0, 0), (0, 0, 0));

  foreach(_id_AC0E5E4AC96AAEA7 in _id_ADDD3217BC59A7B8.lights) {
    if(isDefined(_id_AC0E5E4AC96AAEA7.original_intensity))
      _id_AC0E5E4AC96AAEA7 setlightintensity(_id_AC0E5E4AC96AAEA7.original_intensity);

    _id_AC0E5E4AC96AAEA7 linkTo(self);
  }
}

_id_89A2405953B84136(_id_ADDD3217BC59A7B8, _id_AC17789997E5B858) {
  if(!isDefined(_id_ADDD3217BC59A7B8)) {
    return;
  }
  _id_ADDD3217BC59A7B8.probe hide();

  foreach(_id_AC0E5E4AC96AAEA7 in _id_ADDD3217BC59A7B8.lights) {
    if(_id_AC17789997E5B858)
      _id_AC0E5E4AC96AAEA7.original_intensity = _id_AC0E5E4AC96AAEA7 getlightintensity();

    _id_AC0E5E4AC96AAEA7 setlightintensity(0.0);
  }
}

_id_AAF7FE816CCDF1B3(guy) {
  if(!isDefined(guy._id_8655D6F4C9340DB1))
    guy playsoundonmovingent("scn_infil_van_npc1");

  guy._id_8655D6F4C9340DB1 = 1;
}

_id_AAF7FF816CCDF3E6(guy) {
  if(!isDefined(guy._id_8655D6F4C9340DB1))
    guy playsoundonmovingent("scn_infil_van_npc2");

  guy._id_8655D6F4C9340DB1 = 1;
}

_id_AAF800816CCDF619(guy) {
  if(!isDefined(guy._id_8655D6F4C9340DB1))
    guy playsoundonmovingent("scn_infil_van_npc3");

  guy._id_8655D6F4C9340DB1 = 1;
}

_id_AAF801816CCDF84C(guy) {
  if(!isDefined(guy._id_8655D6F4C9340DB1))
    guy playsoundonmovingent("scn_infil_van_npc4");

  guy._id_8655D6F4C9340DB1 = 1;
}

_id_AAF802816CCDFA7F(guy) {
  if(!isDefined(guy._id_8655D6F4C9340DB1))
    guy playsoundonmovingent("scn_infil_van_npc5");

  guy._id_8655D6F4C9340DB1 = 1;
}

_id_AAF803816CCDFCB2(guy) {
  if(!isDefined(guy._id_8655D6F4C9340DB1))
    guy playsoundonmovingent("scn_infil_van_npc6");

  guy._id_8655D6F4C9340DB1 = 1;
}

infil_radio_idle(infil) {
  if(isPlayer(self)) {
    if(!isDefined(self)) {
      return;
    }
    _id_E014D2BCF2D12FAC = spawn("script_origin", (0, 0, 0));
    _id_E014D2BCF2D12FAC showonlytoplayer(self);
    _id_E014D2BCF2D12FAC playLoopSound("dx_mpo_ukop_radio_chatter");
    _id_E014D2BCF2D12FAC playLoopSound("amb_infil_van");
    scripts\mp\flags::gameflagwait("infil_started");
    wait 1;
    _id_E014D2BCF2D12FAC stoploopsound("dx_mpo_ukop_radio_chatter");
    _id_E014D2BCF2D12FAC stoploopsound("amb_infil_van");
    _id_E014D2BCF2D12FAC delete();
  }
}