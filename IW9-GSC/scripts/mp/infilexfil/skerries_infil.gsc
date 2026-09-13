/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\infilexfil\skerries_infil.gsc
****************************************************/

_id_57334412D2328B04(subtype) {
  _id_7AB5B649FA408138::_id_0F1AED36AB4598EA("skerries_infil");
  initanims(subtype);
  _id_453E4FC2C649FEA4 = [];
  _id_453E4FC2C649FEA4[0] = [0];
  _id_453E4FC2C649FEA4[1] = [1];
  _id_453E4FC2C649FEA4[2] = [2, 3, 4, 5];
  thread scripts\mp\infilexfil\infilexfil::infil_add("infil_skerries", subtype, 6, 4, _id_453E4FC2C649FEA4, ::_id_7F2872EE68C3495D, ::_id_379F2F7E6AF4A8FF, ::_id_72DA1A47FA80F9C3);
}

_id_7F2872EE68C3495D(team, target, subtype, originalsubtype) {
  scene_node = scripts\engine\utility::getStruct(target, "targetname");
  infil = spawn("script_origin", scene_node.origin);
  infil.angles = scene_node.angles;
  infil.scene_node = scene_node;
  infil._id_02B6024D99DE136E = loadfx("vfx/iw9/infil/vfx_rhib_infil_splashes.vfx");
  infil thread infilthink(team, subtype);
  return infil;
}

_id_379F2F7E6AF4A8FF(subtype) {
  animlength = getanimlength(level.scr_anim["slot_0"]["skerries_infil"]);
  return animlength;
}

_id_72DA1A47FA80F9C3(infil, _id_E4B9CD561C7C0DE6) {
  self endon("player_free_spot");
  thread player_infil_end();

  if(isPlayer(self))
    self setclienttriggeraudiozone("skerries_preinfil_mix", 1);

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
    self setclienttriggeraudiozone("iw9_gen_infil_mix", 2);

  self lerpfovbypreset("80_instant");
  self setcinematicmotionoverride("disabled");
  self lerpviewangleclamp(1, 0.25, 0.25, 30, 30, 30, 5);
  thread scripts\mp\infilexfil\infilexfil::_id_D41CBA513A03D958(1.0);
  infil.linktoent scripts\mp\anim::anim_player_solo(self, self.player_rig, "skerries_infil", "tag_origin_animate");
  thread scripts\mp\class::unblockclasschange();

  if(isDefined(level.scr_viewmodelanim[self.animname]) && isDefined(level.scr_viewmodelanim[self.animname]["skerries_infil_" + infil.subtype + "_intro"]))
    setDvar("depthSortViewmodel", 0);

  thread clear_infil_ambient_zone();

  if(isDefined(self.player_rig) && self.player_rig islinked())
    self.player_rig unlink();

  self visionsetnakedforplayer("", 0.75);
  self setdemeanorviewmodel("normal");
  self clearcinematicmotionoverride();
  self disablephysicaldepthoffieldscripting();
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

infilthink(team, _id_CA85A0DE365C6A63) {
  foreach(ent in getEntArray("infil_delete", "script_noteworthy"))
  ent delete();

  thread vehiclethink(team, self.scene_node, _id_CA85A0DE365C6A63);
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
  _id_C7CE9B511C6C1A72 = _id_7DE6CD57148AC2EA(scene_node, team, _id_CA85A0DE365C6A63, "skerries_a");
  self.linktoent vehicle_turnengineoff();

  if(!isDefined(self.path))
    scripts\common\anim::anim_first_frame_solo(_id_C7CE9B511C6C1A72, "skerries_infil");

  _id_C7CE9B511C6C1A72 thread _id_CD31140F6D535F7A();
  level waittill("infil_started");

  if(isDefined(self._id_02B6024D99DE136E))
    playFXOnTag(self._id_02B6024D99DE136E, _id_C7CE9B511C6C1A72, "tag_origin_animate");

  _func_A5361511D072CEFE(0.2);
  thread scripts\common\anim::anim_single_solo(_id_C7CE9B511C6C1A72, "skerries_infil");
  level waittill("prematch_over");
  _func_A5361511D072CEFE(1.0);
  _id_C7CE9B511C6C1A72 delete();
  thread _id_12A422489D86CE46();
}

_id_12A422489D86CE46() {
  wait 5;
  _id_7AB5B649FA408138::_id_F4E0FF5CB899686D("skerries_infil");
}

_id_CD31140F6D535F7A() {
  _id_11526F551A19AE61 = spawn("script_model", (0, 0, 0));
  _id_11526F551A19AE61 linkTo(self, "tag_origin", (50, 0, -50), (0, 0, 0));
  _id_B9A7F8F584C2A5A0 = spawn("script_model", (0, 0, 0));
  _id_B9A7F8F584C2A5A0 linkTo(self, "tag_origin", (-75, 0, 0), (0, 0, 0));
  level waittill("infil_started");
  _id_11526F551A19AE61 playsoundonmovingent("scn_infil_skerries_surface_front");
  _id_B9A7F8F584C2A5A0 playsoundonmovingent("scn_infil_skerries_surface_rear");
  _id_928FD2C2DFB8DAC8 = 6.5;
  wait(_id_928FD2C2DFB8DAC8);
  _id_11526F551A19AE61 playsoundonmovingent("scn_infil_skerries_impact_front");
  level waittill("prematch_over");
  _id_11526F551A19AE61 delete();
  _id_B9A7F8F584C2A5A0 delete();
}

_id_C87B4BDC24873E1A(guy) {
  if(!isDefined(guy._id_8655D6F4C9340DB1))
    guy playsoundonmovingent("scn_infil_skerries_npc1");

  guy._id_8655D6F4C9340DB1 = 1;
}

_id_C87B4ADC24873BE7(guy) {
  if(!isDefined(guy._id_8655D6F4C9340DB1))
    guy playsoundonmovingent("scn_infil_skerries_npc2");

  guy._id_8655D6F4C9340DB1 = 1;
}

_id_C87B49DC248739B4(guy) {
  if(!isDefined(guy._id_8655D6F4C9340DB1))
    guy playsoundonmovingent("scn_infil_skerries_npc3");

  guy._id_8655D6F4C9340DB1 = 1;
}

_id_C87B48DC24873781(guy) {
  if(!isDefined(guy._id_8655D6F4C9340DB1))
    guy playsoundonmovingent("scn_infil_skerries_npc4");

  guy._id_8655D6F4C9340DB1 = 1;
}

_id_C87B47DC2487354E(guy) {
  if(!isDefined(guy._id_8655D6F4C9340DB1))
    guy playsoundonmovingent("scn_infil_skerries_npc5");

  guy._id_8655D6F4C9340DB1 = 1;
}

_id_C87B4CDC2487404D(guy) {
  if(!isDefined(guy._id_8655D6F4C9340DB1))
    guy playsoundonmovingent("scn_infil_skerries_npc0");

  guy._id_8655D6F4C9340DB1 = 1;
}

initanims(subtype) {
  script_model_anims(subtype);
  _id_068AAB9F69431CE1(subtype);
  scripts\common\anim::addnotetrack_customfunction("slot_0", "scn_infil_skerries_npc0", ::_id_C87B4CDC2487404D);
  scripts\common\anim::addnotetrack_customfunction("slot_1", "scn_infil_skerries_npc1", ::_id_C87B4BDC24873E1A);
  scripts\common\anim::addnotetrack_customfunction("slot_2", "scn_infil_skerries_npc2", ::_id_C87B4ADC24873BE7);
  scripts\common\anim::addnotetrack_customfunction("slot_3", "scn_infil_skerries_npc3", ::_id_C87B49DC248739B4);
  scripts\common\anim::addnotetrack_customfunction("slot_4", "scn_infil_skerries_npc4", ::_id_C87B48DC24873781);
  scripts\common\anim::addnotetrack_customfunction("slot_5", "scn_infil_skerries_npc5", ::_id_C87B47DC2487354E);
}

#using_animtree("script_model");

script_model_anims(subtype) {
  switch (subtype) {
    case "alpha":
      level.scr_animtree["slot_0"] = #animtree;
      level.scr_anim["slot_0"]["skerries_infil"] = % iw9_mp_infil_rhib_seat_01;
      level.scr_animname["slot_0"]["skerries_infil"] = "iw9_mp_infil_rhib_seat_01";
      level.scr_eventanim["slot_0"]["skerries_infil"] = "infil_skerries_seat_1";
      level.scr_animtree["slot_1"] = #animtree;
      level.scr_anim["slot_1"]["skerries_infil"] = % iw9_mp_infil_rhib_seat_02;
      level.scr_animname["slot_1"]["skerries_infil"] = "iw9_mp_infil_rhib_seat_02";
      level.scr_eventanim["slot_1"]["skerries_infil"] = "infil_skerries_seat_2";
      level.scr_animtree["slot_2"] = #animtree;
      level.scr_anim["slot_2"]["skerries_infil"] = % iw9_mp_infil_rhib_seat_03;
      level.scr_animname["slot_2"]["skerries_infil"] = "iw9_mp_infil_rhib_seat_03";
      level.scr_eventanim["slot_2"]["skerries_infil"] = "infil_skerries_seat_3";
      level.scr_animtree["slot_3"] = #animtree;
      level.scr_anim["slot_3"]["skerries_infil"] = % iw9_mp_infil_rhib_seat_04;
      level.scr_animname["slot_3"]["skerries_infil"] = "iw9_mp_infil_rhib_seat_04";
      level.scr_eventanim["slot_3"]["skerries_infil"] = "infil_skerries_seat_4";
      level.scr_animtree["slot_4"] = #animtree;
      level.scr_anim["slot_4"]["skerries_infil"] = % iw9_mp_infil_rhib_seat_05;
      level.scr_animname["slot_4"]["skerries_infil"] = "iw9_mp_infil_rhib_seat_05";
      level.scr_eventanim["slot_4"]["skerries_infil"] = "infil_skerries_seat_5";
      level.scr_animtree["slot_5"] = #animtree;
      level.scr_anim["slot_5"]["skerries_infil"] = % iw9_mp_infil_rhib_seat_06;
      level.scr_animname["slot_5"]["skerries_infil"] = "iw9_mp_infil_rhib_seat_06";
      level.scr_eventanim["slot_5"]["skerries_infil"] = "infil_skerries_seat_6";
      level.scr_animtree["slot_6"] = #animtree;
      level.scr_anim["slot_6"]["skerries_infil"] = % iw9_mp_infil_rhib_seat_07;
      level.scr_animname["slot_6"]["skerries_infil"] = "iw9_mp_infil_rhib_seat_07";
      level.scr_eventanim["slot_6"]["skerries_infil"] = "infil_skerries_seat_7";
      level.scr_animtree["slot_7"] = #animtree;
      level.scr_anim["slot_7"]["skerries_infil"] = % iw9_mp_infil_rhib_seat_08;
      level.scr_animname["slot_7"]["skerries_infil"] = "iw9_mp_infil_rhib_seat_08";
      level.scr_eventanim["slot_7"]["skerries_infil"] = "infil_skerries_seat_8";
      level.scr_animtree["slot_8"] = #animtree;
      level.scr_anim["slot_8"]["skerries_infil"] = % iw9_mp_infil_rhib_seat_09;
      level.scr_animname["slot_8"]["skerries_infil"] = "iw9_mp_infil_rhib_seat_09";
      level.scr_eventanim["slot_8"]["skerries_infil"] = "infil_skerries_seat_9";
      level.scr_animtree["slot_9"] = #animtree;
      level.scr_anim["slot_9"]["skerries_infil"] = % iw9_mp_infil_rhib_seat_10;
      level.scr_animname["slot_9"]["skerries_infil"] = "iw9_mp_infil_rhib_seat_10";
      level.scr_eventanim["slot_9"]["skerries_infil"] = "infil_skerries_seat_10";
      level.scr_animtree["slot_10"] = #animtree;
      level.scr_anim["slot_10"]["skerries_infil"] = % iw9_mp_infil_rhib_seat_11;
      level.scr_animname["slot_10"]["skerries_infil"] = "iw9_mp_infil_rhib_seat_11";
      level.scr_eventanim["slot_10"]["skerries_infil"] = "infil_skerries_seat_11";
    case "bravo":
      level.scr_animtree["slot_0"] = #animtree;
      level.scr_anim["slot_0"]["skerries_infil"] = % iw9_mp_infil_rhib_seat_01;
      level.scr_animname["slot_0"]["skerries_infil"] = "iw9_mp_infil_rhib_seat_01";
      level.scr_eventanim["slot_0"]["skerries_infil"] = "infil_skerries_seat_1";
      level.scr_animtree["slot_1"] = #animtree;
      level.scr_anim["slot_1"]["skerries_infil"] = % iw9_mp_infil_rhib_seat_02;
      level.scr_animname["slot_1"]["skerries_infil"] = "iw9_mp_infil_rhib_seat_02";
      level.scr_eventanim["slot_1"]["skerries_infil"] = "infil_skerries_seat_2";
      level.scr_animtree["slot_2"] = #animtree;
      level.scr_anim["slot_2"]["skerries_infil"] = % iw9_mp_infil_rhib_seat_03;
      level.scr_animname["slot_2"]["skerries_infil"] = "iw9_mp_infil_rhib_seat_03";
      level.scr_eventanim["slot_2"]["skerries_infil"] = "infil_skerries_seat_3";
      level.scr_animtree["slot_3"] = #animtree;
      level.scr_anim["slot_3"]["skerries_infil"] = % iw9_mp_infil_rhib_seat_04;
      level.scr_animname["slot_3"]["skerries_infil"] = "iw9_mp_infil_rhib_seat_04";
      level.scr_eventanim["slot_3"]["skerries_infil"] = "infil_skerries_seat_4";
      level.scr_animtree["slot_4"] = #animtree;
      level.scr_anim["slot_4"]["skerries_infil"] = % iw9_mp_infil_rhib_seat_05;
      level.scr_animname["slot_4"]["skerries_infil"] = "iw9_mp_infil_rhib_seat_05";
      level.scr_eventanim["slot_4"]["skerries_infil"] = "infil_skerries_seat_5";
      level.scr_animtree["slot_5"] = #animtree;
      level.scr_anim["slot_5"]["skerries_infil"] = % iw9_mp_infil_rhib_seat_06;
      level.scr_animname["slot_5"]["skerries_infil"] = "iw9_mp_infil_rhib_seat_06";
      level.scr_eventanim["slot_5"]["skerries_infil"] = "infil_skerries_seat_6";
      level.scr_animtree["slot_6"] = #animtree;
      level.scr_anim["slot_6"]["skerries_infil"] = % iw9_mp_infil_rhib_seat_07;
      level.scr_animname["slot_6"]["skerries_infil"] = "iw9_mp_infil_rhib_seat_07";
      level.scr_eventanim["slot_6"]["skerries_infil"] = "infil_skerries_seat_7";
      level.scr_animtree["slot_7"] = #animtree;
      level.scr_anim["slot_7"]["skerries_infil"] = % iw9_mp_infil_rhib_seat_08;
      level.scr_animname["slot_7"]["skerries_infil"] = "iw9_mp_infil_rhib_seat_08";
      level.scr_eventanim["slot_7"]["skerries_infil"] = "infil_skerries_seat_8";
      level.scr_animtree["slot_8"] = #animtree;
      level.scr_anim["slot_8"]["skerries_infil"] = % iw9_mp_infil_rhib_seat_09;
      level.scr_animname["slot_8"]["skerries_infil"] = "iw9_mp_infil_rhib_seat_09";
      level.scr_eventanim["slot_8"]["skerries_infil"] = "infil_skerries_seat_9";
      level.scr_animtree["slot_9"] = #animtree;
      level.scr_anim["slot_9"]["skerries_infil"] = % iw9_mp_infil_rhib_seat_10;
      level.scr_animname["slot_9"]["skerries_infil"] = "iw9_mp_infil_rhib_seat_10";
      level.scr_eventanim["slot_9"]["skerries_infil"] = "infil_skerries_seat_10";
      level.scr_animtree["slot_10"] = #animtree;
      level.scr_anim["slot_10"]["skerries_infil"] = % iw9_mp_infil_rhib_seat_11;
      level.scr_animname["slot_10"]["skerries_infil"] = "iw9_mp_infil_rhib_seat_11";
      level.scr_eventanim["slot_10"]["skerries_infil"] = "infil_skerries_seat_11";
      break;
  }
}

#using_animtree("mp_vehicles_always_loaded");

_id_068AAB9F69431CE1(subtype) {
  switch (subtype) {
    case "alpha":
      level.scr_animtree["skerries_a"] = #animtree;
      level.scr_anim["skerries_a"]["skerries_infil"] = % iw9_mp_infil_rhib_a;
      break;
    case "bravo":
      level.scr_animtree["skerries_a"] = #animtree;
      level.scr_anim["skerries_a"]["skerries_infil"] = % iw9_mp_infil_rhib_a;
      break;
  }
}

_id_7DE6CD57148AC2EA(scene_node, team, _id_CA85A0DE365C6A63, animname) {
  spawnpos = scene_node.origin;
  _id_B7850001037AA074 = scene_node.angles;

  if(isDefined(self.path)) {
    spawnpos = self.path.origin;
    _id_B7850001037AA074 = self.path.angles;
  }

  vehicle = spawnVehicle("veh9_mil_sea_rhib", _id_CA85A0DE365C6A63, "veh9_rhib_physics", spawnpos, _id_B7850001037AA074);
  vehicle setvehicleteam(team);
  vehicle vehphys_forcekeyframedmotion();
  vehicle vehicleshowonminimap(0);
  vehicle.animname = animname;
  self.linktoent = vehicle;
  vehicle.infil = self;
  return vehicle;
}