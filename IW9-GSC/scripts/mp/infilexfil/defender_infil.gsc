/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\infilexfil\defender_infil.gsc
****************************************************/

_id_8EABDC149E284B8D(subtype) {
  _id_7AB5B649FA408138::_id_0F1AED36AB4598EA("defender_infil");
  initanims(subtype);
  _id_453E4FC2C649FEA4 = [];
  _id_453E4FC2C649FEA4[0] = [0];
  _id_453E4FC2C649FEA4[1] = [1];
  _id_453E4FC2C649FEA4[2] = [2, 3, 4, 5];
  thread scripts\mp\infilexfil\infilexfil::infil_add("infil_defender", subtype, 6, 4, _id_453E4FC2C649FEA4, ::_id_AEF1EF5D40BA8216, ::_id_F17139F61F2DF6F2, ::_id_5A3E8CBAFF52F088);
}

_id_AEF1EF5D40BA8216(team, target, subtype, originalsubtype) {
  scene_node = scripts\engine\utility::getStruct(target, "targetname");
  infil = spawn("script_origin", scene_node.origin);
  infil.angles = scene_node.angles;
  infil.scene_node = scene_node;
  infil thread infilthink(team, subtype);
  return infil;
}

_id_F17139F61F2DF6F2(subtype) {
  animlength = getanimlength(level.scr_anim["slot_0"]["defender_infil"]);
  return animlength;
}

_id_5A3E8CBAFF52F088(infil, _id_E4B9CD561C7C0DE6) {
  self endon("player_free_spot");

  if(isPlayer(self))
    self setclienttriggeraudiozone("defender_preinfil_mix", 1);

  thread infil_radio_idle(infil);
  thread player_infil_end();
  spawnpos = infil.linktoent gettagorigin("tag_origin_animate");
  _id_B7850001037AA074 = infil.linktoent gettagangles("tag_origin_animate");
  thread scripts\mp\utility\infilexfil::infil_player_rig_updated("slot_" + _id_E4B9CD561C7C0DE6, spawnpos, _id_B7850001037AA074);
  self.player_rig linkTo(infil.linktoent, "tag_origin_animate");
  self setdemeanorviewmodel("safe", "iw8_ges_demeanor_safe_van");
  self visionsetnakedforplayer("mp_core_infil", 0.0);
  self.player_rig.weapon_state_func = scripts\mp\utility\infilexfil::handleweaponstatenotetrack;
  thread player_disconnect();
  thread scripts\mp\infilexfil\infilexfil::_id_D41CBA513A03D958(0);
  level waittill("start_scene");
  self setcinematicmotionoverride("disabled");
  thread scripts\mp\music_and_dialog::_id_03AA69E0E6827CE5();

  if(isDefined(self.animname) && !isai(self)) {
    self setclienttriggeraudiozone("iw9_gen_infil_mix", 2);

    if(soundexists("amb_infil_defender_lr"))
      self playlocalsound("amb_infil_defender_lr");

    if(soundexists("amb_infil_defender_tires_davos"))
      self playlocalsound("amb_infil_defender_tires_davos");
  }

  self lerpfovscalefactor(0, 0);

  if(isDefined(level.scr_viewmodelanim[self.animname]) && isDefined(level.scr_viewmodelanim[self.animname]["defender_infil_" + infil.subtype + "_intro"]))
    setDvar("depthSortViewmodel", 0);

  self lerpviewangleclamp(1, 0.25, 0.25, 0, 0, 0, 0);
  infil.linktoent scripts\mp\anim::anim_player_solo(self, self.player_rig, "defender_infil", "tag_origin_animate");
  thread clear_infil_ambient_zone();
  thread scripts\mp\class::unblockclasschange();
  self lerpfovscalefactor(1, 0.75);

  if(isDefined(self.player_rig) && self.player_rig islinked())
    self.player_rig unlink();

  self visionsetnakedforplayer("", 0.75);
  self setdemeanorviewmodel("normal");
  thread _id_EDE4ACBF2FE2651B();
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
  self lerpfovbypreset("default_2seconds");
  self clearclienttriggeraudiozone(1.0);
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
  _id_EE2753C1176F5C7E = _id_90A059C97E2970B7(scene_node, team, _id_CA85A0DE365C6A63);
  _id_EE2753C1176F5C7E vehicle_turnengineoff();

  if(!isDefined(self.path))
    scripts\common\anim::anim_first_frame_solo(_id_EE2753C1176F5C7E, "defender_infil");

  level waittill("infil_started");
  _id_EE2753C1176F5C7E playsoundonmovingent("scn_infil_defender_ext_lr");
  thread scripts\common\anim::anim_single_solo(_id_EE2753C1176F5C7E, "defender_infil");
  scripts\mp\infilexfil\infilexfil::_id_4DCA5340DFD36C76(scene_node, _id_EE2753C1176F5C7E, getanimlength(level.scr_anim["defender"]["defender_infil"]), "defender", "defender_infil");
  level waittill("prematch_over");
}

initanims(subtype) {
  _id_487431CF3B99E0B8(subtype);
  _id_07B7D0C2DB72B128(subtype);
  scripts\common\anim::addnotetrack_customfunction("slot_0", "free_look", scripts\mp\utility\infilexfil::player_free_look, "defender_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_1", "free_look", scripts\mp\utility\infilexfil::player_free_look, "defender_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_2", "free_look", scripts\mp\utility\infilexfil::player_free_look, "defender_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_3", "free_look", scripts\mp\utility\infilexfil::player_free_look, "defender_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_4", "free_look", scripts\mp\utility\infilexfil::player_free_look, "defender_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_5", "free_look", scripts\mp\utility\infilexfil::player_free_look, "defender_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_0", "shake_on", scripts\mp\utility\infilexfil::rumble_low, "defender_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_1", "shake_on", scripts\mp\utility\infilexfil::rumble_low, "defender_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_2", "shake_on", scripts\mp\utility\infilexfil::rumble_low, "defender_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_3", "shake_on", scripts\mp\utility\infilexfil::rumble_low, "defender_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_4", "shake_on", scripts\mp\utility\infilexfil::rumble_low, "defender_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_5", "shake_on", scripts\mp\utility\infilexfil::rumble_low, "defender_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_0", "shake_running", scripts\mp\utility\infilexfil::cam_shake_running, "defender_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_1", "shake_running", scripts\mp\utility\infilexfil::cam_shake_running, "defender_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_2", "shake_running", scripts\mp\utility\infilexfil::cam_shake_running, "defender_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_3", "shake_running", scripts\mp\utility\infilexfil::cam_shake_running, "defender_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_4", "shake_running", scripts\mp\utility\infilexfil::cam_shake_running, "defender_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_5", "shake_running", scripts\mp\utility\infilexfil::cam_shake_running, "defender_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_0", "fov_63_2", scripts\mp\utility\infilexfil::player_fov_default_1, "defender_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_1", "fov_63_2", scripts\mp\utility\infilexfil::player_fov_default_1, "defender_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_2", "fov_63_2", scripts\mp\utility\infilexfil::player_fov_default_1, "defender_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_3", "fov_63_2", scripts\mp\utility\infilexfil::player_fov_default_1, "defender_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_4", "fov_63_2", scripts\mp\utility\infilexfil::player_fov_default_1, "defender_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_5", "fov_63_2", scripts\mp\utility\infilexfil::player_fov_default_1, "defender_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_0", "scn_infil_defender_npc1", ::_id_442DA4B15F827F5B, "defender_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_0", "scn_infil_defender_door", ::_id_9C45FD3A1B6FAF21, "defender_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_1", "scn_infil_defender_npc2", ::_id_442DA5B15F82818E, "defender_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_2", "scn_infil_defender_npc3", ::_id_442DA6B15F8283C1, "defender_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_3", "scn_infil_defender_npc4", ::_id_442DA7B15F8285F4, "defender_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_4", "scn_infil_defender_npc5", ::_id_442DA8B15F828827, "defender_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_5", "scn_infil_defender_npc6", ::_id_442DA9B15F828A5A, "defender_infil");
}

#using_animtree("script_model");

_id_487431CF3B99E0B8(subtype) {
  mapname = scripts\cp_mp\utility\game_utility::getmapname();

  switch (mapname) {
    case "mp_davos":
      level.scr_animtree["slot_0"] = #animtree;
      level.scr_anim["slot_0"]["defender_infil"] = % iw9_mp_infil_defender_seat_0_davos;
      level.scr_animname["slot_0"]["defender_infil"] = "iw9_mp_infil_defender_seat_0_davos";
      level.scr_eventanim["slot_0"]["defender_infil"] = "infil_defender_seat_0_davos";
      level.scr_animtree["slot_1"] = #animtree;
      level.scr_anim["slot_1"]["defender_infil"] = % iw9_mp_infil_defender_seat_1_davos;
      level.scr_animname["slot_1"]["defender_infil"] = "iw9_mp_infil_defender_seat_1_davos";
      level.scr_eventanim["slot_1"]["defender_infil"] = "infil_defender_seat_1_davos";
      level.scr_animtree["slot_2"] = #animtree;
      level.scr_anim["slot_2"]["defender_infil"] = % iw9_mp_infil_defender_seat_2_davos;
      level.scr_animname["slot_2"]["defender_infil"] = "iw9_mp_infil_defender_seat_2_davos";
      level.scr_eventanim["slot_2"]["defender_infil"] = "infil_defender_seat_2_davos";
      level.scr_animtree["slot_3"] = #animtree;
      level.scr_anim["slot_3"]["defender_infil"] = % iw9_mp_infil_defender_seat_3_davos;
      level.scr_animname["slot_3"]["defender_infil"] = "iw9_mp_infil_defender_seat_3_davos";
      level.scr_eventanim["slot_3"]["defender_infil"] = "infil_defender_seat_3_davos";
      level.scr_animtree["slot_4"] = #animtree;
      level.scr_anim["slot_4"]["defender_infil"] = % iw9_mp_infil_defender_seat_4_davos;
      level.scr_animname["slot_4"]["defender_infil"] = "iw9_mp_infil_defender_seat_4_davos";
      level.scr_eventanim["slot_4"]["defender_infil"] = "infil_defender_seat_4_davos";
      level.scr_animtree["slot_5"] = #animtree;
      level.scr_anim["slot_5"]["defender_infil"] = % iw9_mp_infil_defender_seat_5_davos;
      level.scr_animname["slot_5"]["defender_infil"] = "iw9_mp_infil_defender_seat_5_davos";
      level.scr_eventanim["slot_5"]["defender_infil"] = "infil_defender_seat_5_davos";
      break;
    default:
      level.scr_animtree["slot_0"] = #animtree;
      level.scr_anim["slot_0"]["defender_infil"] = % iw9_mp_infil_defender_seat_0;
      level.scr_animname["slot_0"]["defender_infil"] = "iw9_mp_infil_defender_seat_0";
      level.scr_eventanim["slot_0"]["defender_infil"] = "infil_defender_seat_0";
      level.scr_animtree["slot_1"] = #animtree;
      level.scr_anim["slot_1"]["defender_infil"] = % iw9_mp_infil_defender_seat_1;
      level.scr_animname["slot_1"]["defender_infil"] = "iw9_mp_infil_defender_seat_1";
      level.scr_eventanim["slot_1"]["defender_infil"] = "infil_defender_seat_1";
      level.scr_animtree["slot_2"] = #animtree;
      level.scr_anim["slot_2"]["defender_infil"] = % iw9_mp_infil_defender_seat_2;
      level.scr_animname["slot_2"]["defender_infil"] = "iw9_mp_infil_defender_seat_2";
      level.scr_eventanim["slot_2"]["defender_infil"] = "infil_defender_seat_2";
      level.scr_animtree["slot_3"] = #animtree;
      level.scr_anim["slot_3"]["defender_infil"] = % iw9_mp_infil_defender_seat_3;
      level.scr_animname["slot_3"]["defender_infil"] = "iw9_mp_infil_defender_seat_3";
      level.scr_eventanim["slot_3"]["defender_infil"] = "infil_defender_seat_3";
      level.scr_animtree["slot_4"] = #animtree;
      level.scr_anim["slot_4"]["defender_infil"] = % iw9_mp_infil_defender_seat_4;
      level.scr_animname["slot_4"]["defender_infil"] = "iw9_mp_infil_defender_seat_4";
      level.scr_eventanim["slot_4"]["defender_infil"] = "infil_defender_seat_4";
      level.scr_animtree["slot_5"] = #animtree;
      level.scr_anim["slot_5"]["defender_infil"] = % iw9_mp_infil_defender_seat_5;
      level.scr_animname["slot_5"]["defender_infil"] = "iw9_mp_infil_defender_seat_5";
      level.scr_eventanim["slot_5"]["defender_infil"] = "infil_defender_seat_5";
      break;
  }
}

#using_animtree("mp_vehicles_always_loaded");

_id_07B7D0C2DB72B128(subtype) {
  mapname = scripts\cp_mp\utility\game_utility::getmapname();

  switch (mapname) {
    case "mp_davos":
      level.scr_anim["defender"]["defender_infil"] = % iw9_mp_infil_defender_vehicle_davos;
      break;
    default:
      level.scr_anim["defender"]["defender_infil"] = % iw9_mp_infil_defender_vehicle_museum;
      break;
  }
}

_id_90A059C97E2970B7(scene_node, team, _id_CA85A0DE365C6A63) {
  spawnpos = scene_node.origin;
  _id_B7850001037AA074 = scene_node.angles;

  if(isDefined(self.path)) {
    spawnpos = self.path.origin;
    _id_B7850001037AA074 = self.path.angles;
  }

  vehicle = spawnVehicle("veh9_civ_lnd_suv_overland_2016_cage", "defender_infil_suv", "veh9_suv_overland_2016_cage_physics_sp", spawnpos, _id_B7850001037AA074);
  vehicle setvehicleteam(team);
  vehicle vehphys_forcekeyframedmotion();
  vehicle vehicleshowonminimap(0);
  vehicle hidepart("TAG_WINDSHIELD_FRONT_WEB");
  vehicle.animname = "defender";
  self.linktoent = vehicle;
  vehicle.infil = self;
  return vehicle;
}

_id_442DA4B15F827F5B(guy) {
  if(!isDefined(guy._id_8655D6F4C9340DB1))
    guy playsoundonmovingent("scn_infil_defender_npc1");

  guy._id_8655D6F4C9340DB1 = 1;
}

_id_442DA5B15F82818E(guy) {
  if(!isDefined(guy._id_8655D6F4C9340DB1))
    guy playsoundonmovingent("scn_infil_defender_npc2");

  guy._id_8655D6F4C9340DB1 = 1;
}

_id_442DA6B15F8283C1(guy) {
  if(!isDefined(guy._id_8655D6F4C9340DB1))
    guy playsoundonmovingent("scn_infil_defender_npc3");

  guy._id_8655D6F4C9340DB1 = 1;
}

_id_442DA7B15F8285F4(guy) {
  if(!isDefined(guy._id_8655D6F4C9340DB1))
    guy playsoundonmovingent("scn_infil_defender_npc4");

  guy._id_8655D6F4C9340DB1 = 1;
}

_id_442DA8B15F828827(guy) {
  if(!isDefined(guy._id_8655D6F4C9340DB1))
    guy playsoundonmovingent("scn_infil_defender_npc5");

  guy._id_8655D6F4C9340DB1 = 1;
}

_id_442DA9B15F828A5A(guy) {
  if(!isDefined(guy._id_8655D6F4C9340DB1))
    guy playsoundonmovingent("scn_infil_defender_npc6");

  guy._id_8655D6F4C9340DB1 = 1;
}

_id_9C45FD3A1B6FAF21(guy) {
  if(!isDefined(guy._id_EB404F8FE4E857A5))
    guy playsoundonmovingent("scn_infil_defender_door");

  guy._id_EB404F8FE4E857A5 = 1;
}

infil_radio_idle(infil) {
  if(isPlayer(self)) {
    if(!isDefined(self)) {
      return;
    }
    _id_E014D2BCF2D12FAC = spawn("script_origin", (0, 0, 0));
    _id_E014D2BCF2D12FAC showonlytoplayer(self);
    _id_E014D2BCF2D12FAC playLoopSound("dx_mpo_ukop_radio_chatter");
    _id_E014D2BCF2D12FAC playLoopSound("amb_infil_defender_pre");
    scripts\mp\flags::gameflagwait("infil_started");
    wait 1;
    _id_E014D2BCF2D12FAC stoploopsound("dx_mpo_ukop_radio_chatter");
    _id_E014D2BCF2D12FAC stoploopsound("amb_infil_defender_pre");
    _id_E014D2BCF2D12FAC delete();
  }
}

_id_EDE4ACBF2FE2651B() {
  wait 5;
  _id_7AB5B649FA408138::_id_F4E0FF5CB899686D("defender_infil");
}