/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_7ffe557d0b97b07b.gsc
***********************************************/

_id_27DC36DCD7896FCB(subtype) {
  initanims(subtype);
  _id_453E4FC2C649FEA4 = [];
  _id_453E4FC2C649FEA4[0] = [3];
  _id_453E4FC2C649FEA4[1] = [0];
  _id_453E4FC2C649FEA4[2] = [4];
  _id_453E4FC2C649FEA4[3] = [2, 1];
  _id_453E4FC2C649FEA4[4] = [5];
  thread scripts\mp\infilexfil\infilexfil::infil_add("infil_crossing_civ", subtype, 6, 4, _id_453E4FC2C649FEA4, ::_id_797FB745C0E310A0, ::_id_E5A5A1EBA031FBEC, ::_id_68DA98D20DAD9F3A);
}

_id_797FB745C0E310A0(team, target, subtype, originalsubtype) {
  scene_node = scripts\engine\utility::getStruct(target, "targetname");
  infil = spawn("script_origin", scene_node.origin);

  if(!isDefined(scene_node.angles))
    scene_node.angles = (0, 0, 0);

  infil.angles = scene_node.angles;
  infil.scene_node = scene_node;
  infil thread infilthink(team, subtype);
  return infil;
}

_id_E5A5A1EBA031FBEC(subtype) {
  animlength = getanimlength(level.scr_anim["slot_0"]["crossing_civ_infil"]);
  return animlength;
}

_id_68DA98D20DAD9F3A(infil, _id_E4B9CD561C7C0DE6) {
  self endon("player_free_spot");

  if(isPlayer(self))
    self setclienttriggeraudiozone("crossing_preinfil_mix", 1);

  thread player_infil_end();
  linktoent = scripts\engine\utility::ter_op(_id_E4B9CD561C7C0DE6 >= 3, infil._id_52CB2624A2C0E0F5, infil._id_52CB2324A2C0DA5C);
  spawnpos = linktoent gettagorigin("tag_origin_animate");
  _id_B7850001037AA074 = linktoent gettagangles("tag_origin_animate");
  thread scripts\mp\utility\infilexfil::infil_player_rig_updated("slot_" + _id_E4B9CD561C7C0DE6, spawnpos, _id_B7850001037AA074);
  self.player_rig linkTo(linktoent, "tag_origin_animate");
  self setdemeanorviewmodel("safe", "iw8_ges_demeanor_safe_van");
  self visionsetnakedforplayer("mp_core_infil", 0.0);
  self.player_rig.weapon_state_func = scripts\mp\utility\infilexfil::handleweaponstatenotetrack;
  thread player_disconnect();
  level waittill("start_scene");
  self setcinematicmotionoverride("disabled");

  if(isDefined(self.animname) && !isai(self)) {
    self setclienttriggeraudiozone("iw9_gen_infil_mix", 2);

    if(soundexists("amb_infil_crossing_lr"))
      self playlocalsound("amb_infil_crossing_lr");
  }

  thread scripts\mp\infilexfil\infilexfil::_id_D41CBA513A03D958(1.0);
  linktoent scripts\mp\anim::anim_player_solo(self, self.player_rig, "crossing_civ_infil", "tag_origin_animate");
  thread scripts\mp\class::unblockclasschange();
  self lerpviewangleclamp(1, 0.25, 0.25, 0, 0, 0, 0);
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
  _id_52CB2324A2C0DA5C = _id_D5A0E84B4C3F6141(scene_node, team, _id_CA85A0DE365C6A63, "veh9_civ_lnd_sedan_hatchback_1985", "crossing_civ_sedan", "veh9_sedan_hatchback_1985_physics_mp");
  _id_52CB2624A2C0E0F5 = _id_D5A0E84B4C3F6141(scene_node, team, _id_CA85A0DE365C6A63, "veh9_civ_lnd_minivan_1993", "crossing_civ_minivan", "veh9_minivan_1993_physics_mp");
  _id_52CB2324A2C0DA5C hidepart("TAG_WINDSHIELD_FRONT_WEB");
  _id_52CB2624A2C0E0F5 hidepart("TAG_WINDSHIELD_FRONT_WEB");
  self._id_52CB2324A2C0DA5C = _id_52CB2324A2C0DA5C;
  self._id_52CB2624A2C0E0F5 = _id_52CB2624A2C0E0F5;
  _id_52CB2324A2C0DA5C thread _id_0114189962E5C218();
  _id_52CB2624A2C0E0F5 thread _id_EFB1F0D3F04F5895();
  level waittill("infil_started");
  _id_52CB2324A2C0DA5C playsoundonmovingent("scn_infil_crossing_hatchback_engine");
  _id_52CB2324A2C0DA5C playsoundonmovingent("scn_infil_crossing_horn_2");
  _id_52CB2624A2C0E0F5 playsoundonmovingent("scn_infil_crossing_van_engine");
  _id_52CB2624A2C0E0F5 playsoundonmovingent("scn_infil_crossing_horn");
  thread scripts\common\anim::anim_single_solo(_id_52CB2324A2C0DA5C, "crossing_civ_infil");
  thread scripts\common\anim::anim_single_solo(_id_52CB2624A2C0E0F5, "crossing_civ_infil");
  thread _id_70A8A2AAE30F4847(scene_node, _id_52CB2324A2C0DA5C, "crossing_civ_sedan", "crossing_civ_infil", "veh9_civ_lnd_sedan_hatchback_1985", 0);
  thread _id_70A8A2AAE30F4847(scene_node, _id_52CB2624A2C0E0F5, "crossing_civ_minivan", "crossing_civ_infil", "veh9_civ_lnd_minivan_1993", 0);
  level waittill("prematch_over");
}

_id_0114189962E5C218() {
  _id_E014D2BCF2D12FAC = spawn("script_origin", self.origin);
  _id_E014D2BCF2D12FAC linkTo(self, "tag_windshield_front");
  _id_E014D2BCF2D12FAC playLoopSound("emt_mus_141_full_banda_car_lp");
}

_id_EFB1F0D3F04F5895() {
  _id_E014D2BCF2D12FAC = spawn("script_origin", self.origin);
  _id_E014D2BCF2D12FAC linkTo(self, "tag_windshield_front");
  _id_E014D2BCF2D12FAC playLoopSound("emt_mus_141_full_banda_car_lp");
  level waittill("prematch_over");
  _id_E014D2BCF2D12FAC stoploopsound();
  _id_E014D2BCF2D12FAC delete();
}

actorthink(team, scene_node, _id_CA85A0DE365C6A63, _id_16E334D22D37BE73) {
  thread _id_D7FEF246B7636B4D(scene_node, "veh9_civ_lnd_sedan_hatchback_1985", "civ_vehicle_1", 1);
  thread _id_D7FEF246B7636B4D(scene_node, "veh9_civ_lnd_coupe_1985", "civ_vehicle_2", 0);
  thread _id_01FE5786BB2EAD05(scene_node, "body_civ_mexico_male_2_1", "head_sc_m_bruce", "civ_1");
  thread _id_01FE5786BB2EAD05(scene_node, "body_civ_mexico_male_5_1", "head_sc_m_allen_hat", "civ_2");
  thread _id_01FE5786BB2EAD05(scene_node, "body_civ_mexico_male_7_1", "head_sc_m_bruce", "civ_3");
  thread _id_01FE5786BB2EAD05(scene_node, "body_civ_mexico_female_12_1", "head_sc_f_senat", "civ_4");
  thread _id_01FE5786BB2EAD05(scene_node, "body_civ_mexico_male_9_1", "head_sc_m_cueto", "civ_5");
  thread _id_01FE5786BB2EAD05(scene_node, "body_civ_mexico_female_9_1", "head_sc_f_eghbali_civ", "civ_6");
  thread _id_01FE5786BB2EAD05(scene_node, "body_civ_mexico_male_11_1", "head_sc_m_cueto", "civ_7");
  thread _id_01FE5786BB2EAD05(scene_node, "body_civ_mexico_male_12_1", "head_sc_m_allen_hat", "civ_8");
  thread _id_01FE5786BB2EAD05(scene_node, "body_civ_mexico_male_3_1", "head_sc_m_cueto", "civ_9");
}

initanims(subtype) {
  script_model_anims(subtype);
  _id_068AAB9F69431CE1(subtype);
  scripts\common\anim::addnotetrack_customfunction("slot_0", "scn_infil_crossing_civ_npc0a", ::_id_D480E95DD6D8DBD5);
  scripts\common\anim::addnotetrack_customfunction("slot_0", "scn_infil_crossing_civ_npc0b", ::_id_D480E65DD6D8D53C);
  scripts\common\anim::addnotetrack_customfunction("slot_0", "scn_infil_crossing_civ_npc1a", ::_id_D484CD5DD6DC9418);
  scripts\common\anim::addnotetrack_customfunction("slot_0", "scn_infil_crossing_civ_npc1b", ::_id_D484D05DD6DC9AB1);
  scripts\common\anim::addnotetrack_customfunction("slot_0", "scn_infil_crossing_civ_npc2a", ::_id_D477DD5DD6CEA2C3);
  scripts\common\anim::addnotetrack_customfunction("slot_0", "scn_infil_crossing_civ_npc2b", ::_id_D477DE5DD6CEA4F6);
  scripts\common\anim::addnotetrack_customfunction("slot_3", "scn_infil_crossing_civ_npc3", ::_id_69CC69E38527EF83);
  scripts\common\anim::addnotetrack_customfunction("slot_4", "scn_infil_crossing_civ_npc4", ::_id_69CC6EE38527FA82);
  scripts\common\anim::addnotetrack_customfunction("slot_5", "scn_infil_crossing_civ_npc5", ::_id_69CC6FE38527FCB5);
}

_id_D480E95DD6D8DBD5(guy) {
  if(!isDefined(guy._id_8655D6F4C9340DB1))
    guy playsoundonmovingent("scn_infil_crossing_civ_npc0a");

  guy._id_8655D6F4C9340DB1 = 1;
}

_id_D480E65DD6D8D53C(guy) {
  if(!isDefined(guy._id_A2D53F567D79B719))
    guy playsoundonmovingent("scn_infil_crossing_civ_npc0b");

  guy._id_A2D53F567D79B719 = 1;
}

_id_D484CD5DD6DC9418(guy) {
  if(!isDefined(guy._id_8655D6F4C9340DB1))
    guy playsoundonmovingent("scn_infil_crossing_civ_npc1a");

  guy._id_8655D6F4C9340DB1 = 1;
}

_id_D484D05DD6DC9AB1(guy) {
  if(!isDefined(guy._id_A2D53F567D79B719))
    guy playsoundonmovingent("scn_infil_crossing_civ_npc1b");

  guy._id_A2D53F567D79B719 = 1;
}

_id_D477DD5DD6CEA2C3(guy) {
  if(!isDefined(guy._id_8655D6F4C9340DB1))
    guy playsoundonmovingent("scn_infil_crossing_civ_npc2a");

  guy._id_8655D6F4C9340DB1 = 1;
}

_id_D477DE5DD6CEA4F6(guy) {
  if(!isDefined(guy._id_A2D53F567D79B719))
    guy playsoundonmovingent("scn_infil_crossing_civ_npc2b");

  guy._id_A2D53F567D79B719 = 1;
}

_id_69CC69E38527EF83(guy) {
  if(!isDefined(guy._id_8655D6F4C9340DB1))
    guy playsoundonmovingent("scn_infil_crossing_civ_npc3");

  guy._id_8655D6F4C9340DB1 = 1;
}

_id_69CC6EE38527FA82(guy) {
  if(!isDefined(guy._id_8655D6F4C9340DB1))
    guy playsoundonmovingent("scn_infil_crossing_civ_npc4");

  guy._id_8655D6F4C9340DB1 = 1;
}

_id_69CC6FE38527FCB5(guy) {
  if(!isDefined(guy._id_8655D6F4C9340DB1))
    guy playsoundonmovingent("scn_infil_crossing_civ_npc5");

  guy._id_8655D6F4C9340DB1 = 1;
}

#using_animtree("script_model");

script_model_anims(subtype) {
  switch (subtype) {
    case "bravo":
    case "alpha":
      level.scr_animtree["slot_0"] = #animtree;
      level.scr_anim["slot_0"]["crossing_civ_infil"] = % iw9_mp_infil_civ_vehicule_seat_0;
      level.scr_animname["slot_0"]["crossing_civ_infil"] = "iw9_mp_infil_civ_vehicule_seat_0";
      level.scr_eventanim["slot_0"]["crossing_civ_infil"] = "infil_crossing_civ_seat_0";
      level.scr_animtree["slot_1"] = #animtree;
      level.scr_anim["slot_1"]["crossing_civ_infil"] = % iw9_mp_infil_civ_vehicule_seat_1;
      level.scr_animname["slot_1"]["crossing_civ_infil"] = "iw9_mp_infil_civ_vehicule_seat_1";
      level.scr_eventanim["slot_1"]["crossing_civ_infil"] = "infil_crossing_civ_seat_1";
      level.scr_animtree["slot_2"] = #animtree;
      level.scr_anim["slot_2"]["crossing_civ_infil"] = % iw9_mp_infil_civ_vehicule_seat_2;
      level.scr_animname["slot_2"]["crossing_civ_infil"] = "iw9_mp_infil_civ_vehicule_seat_2";
      level.scr_eventanim["slot_2"]["crossing_civ_infil"] = "infil_crossing_civ_seat_2";
      level.scr_animtree["slot_3"] = #animtree;
      level.scr_anim["slot_3"]["crossing_civ_infil"] = % iw9_mp_infil_civ_vehicule_seat_3;
      level.scr_animname["slot_3"]["crossing_civ_infil"] = "iw9_mp_infil_civ_vehicule_seat_3";
      level.scr_eventanim["slot_3"]["crossing_civ_infil"] = "infil_crossing_civ_seat_3";
      level.scr_animtree["slot_4"] = #animtree;
      level.scr_anim["slot_4"]["crossing_civ_infil"] = % iw9_mp_infil_civ_vehicule_seat_4;
      level.scr_animname["slot_4"]["crossing_civ_infil"] = "iw9_mp_infil_civ_vehicule_seat_4";
      level.scr_eventanim["slot_4"]["crossing_civ_infil"] = "infil_crossing_civ_seat_4";
      level.scr_animtree["slot_5"] = #animtree;
      level.scr_anim["slot_5"]["crossing_civ_infil"] = % iw9_mp_infil_civ_vehicule_seat_5;
      level.scr_animname["slot_5"]["crossing_civ_infil"] = "iw9_mp_infil_civ_vehicule_seat_5";
      level.scr_eventanim["slot_5"]["crossing_civ_infil"] = "infil_crossing_civ_seat_5";
      level.scr_animtree["civ_1"] = #animtree;
      level.scr_anim["civ_1"]["crossing_civ_infil"] = % iw9_mp_infil_civ_vehicule_civilian_1_crossing;
      level.scr_animname["civ_1"]["crossing_civ_infil"] = "iw9_mp_infil_civ_vehicule_civilian_1_crossing";
      level.scr_eventanim["civ_1"]["crossing_civ_infil"] = "infil_crossing_civ_1";
      level.scr_animtree["civ_2"] = #animtree;
      level.scr_anim["civ_2"]["crossing_civ_infil"] = % iw9_mp_infil_civ_vehicule_civilian_2_crossing;
      level.scr_animname["civ_2"]["crossing_civ_infil"] = "iw9_mp_infil_civ_vehicule_civilian_2_crossing";
      level.scr_eventanim["civ_2"]["crossing_civ_infil"] = "infil_crossing_civ_2";
      level.scr_animtree["civ_3"] = #animtree;
      level.scr_anim["civ_3"]["crossing_civ_infil"] = % iw9_mp_infil_civ_vehicule_civilian_3_crossing;
      level.scr_animname["civ_3"]["crossing_civ_infil"] = "iw9_mp_infil_civ_vehicule_civilian_3_crossing";
      level.scr_eventanim["civ_3"]["crossing_civ_infil"] = "infil_crossing_civ_3";
      level.scr_animtree["civ_4"] = #animtree;
      level.scr_anim["civ_4"]["crossing_civ_infil"] = % iw9_mp_infil_civ_vehicule_civilian_4_crossing;
      level.scr_animname["civ_4"]["crossing_civ_infil"] = "iw9_mp_infil_civ_vehicule_civilian_4_crossing";
      level.scr_eventanim["civ_4"]["crossing_civ_infil"] = "infil_crossing_civ_4";
      level.scr_animtree["civ_5"] = #animtree;
      level.scr_anim["civ_5"]["crossing_civ_infil"] = % iw9_mp_infil_civ_vehicule_civilian_5_crossing;
      level.scr_animname["civ_5"]["crossing_civ_infil"] = "iw9_mp_infil_civ_vehicule_civilian_5_crossing";
      level.scr_eventanim["civ_5"]["crossing_civ_infil"] = "infil_crossing_civ_5";
      level.scr_animtree["civ_6"] = #animtree;
      level.scr_anim["civ_6"]["crossing_civ_infil"] = % iw9_mp_infil_civ_vehicule_civilian_6_crossing;
      level.scr_animname["civ_6"]["crossing_civ_infil"] = "iw9_mp_infil_civ_vehicule_civilian_6_crossing";
      level.scr_eventanim["civ_6"]["crossing_civ_infil"] = "infil_crossing_civ_6";
      level.scr_animtree["civ_7"] = #animtree;
      level.scr_anim["civ_7"]["crossing_civ_infil"] = % iw9_mp_infil_civ_vehicule_civilian_7_crossing;
      level.scr_animname["civ_7"]["crossing_civ_infil"] = "iw9_mp_infil_civ_vehicule_civilian_7_crossing";
      level.scr_eventanim["civ_7"]["crossing_civ_infil"] = "infil_crossing_civ_7";
      level.scr_animtree["civ_8"] = #animtree;
      level.scr_anim["civ_8"]["crossing_civ_infil"] = % iw9_mp_infil_civ_vehicule_civilian_8_crossing;
      level.scr_animname["civ_8"]["crossing_civ_infil"] = "iw9_mp_infil_civ_vehicule_civilian_8_crossing";
      level.scr_eventanim["civ_8"]["crossing_civ_infil"] = "infil_crossing_civ_8";
      level.scr_animtree["civ_9"] = #animtree;
      level.scr_anim["civ_9"]["crossing_civ_infil"] = % iw9_mp_infil_civ_vehicule_civilian_9_crossing;
      level.scr_animname["civ_9"]["crossing_civ_infil"] = "iw9_mp_infil_civ_vehicule_civilian_9_crossing";
      level.scr_eventanim["civ_9"]["crossing_civ_infil"] = "infil_crossing_civ_9";
      level.scr_animtree["civ_vehicle_1"] = #animtree;
      level.scr_anim["civ_vehicle_1"]["crossing_civ_infil"] = % iw9_mp_infil_civ_vehicule_civilian_car01_crossing;
      level.scr_animname["civ_vehicle_1"]["crossing_civ_infil"] = "iw9_mp_infil_civ_vehicule_civilian_car01_crossing";
      level.scr_animtree["civ_vehicle_2"] = #animtree;
      level.scr_anim["civ_vehicle_2"]["crossing_civ_infil"] = % iw9_mp_infil_civ_vehicule_civilian_car02_crossing;
      level.scr_animname["civ_vehicle_2"]["crossing_civ_infil"] = "iw9_mp_infil_civ_vehicule_civilian_car02_crossing";
      break;
  }
}

#using_animtree("mp_vehicles_always_loaded");

_id_068AAB9F69431CE1(subtype) {
  switch (subtype) {
    case "bravo":
    case "alpha":
      level.scr_animtree["crossing_civ_sedan"] = #animtree;
      level.scr_anim["crossing_civ_sedan"]["crossing_civ_infil"] = % iw9_mp_infil_civ_vehicule_sedan1985_crossing;
      level.scr_animtree["crossing_civ_minivan"] = #animtree;
      level.scr_anim["crossing_civ_minivan"]["crossing_civ_infil"] = % iw9_mp_infil_civ_vehicule_minivan1993_crossing;
      break;
  }
}

_id_D5A0E84B4C3F6141(scene_node, team, _id_CA85A0DE365C6A63, model, animname, vehicle) {
  spawnpos = scene_node.origin;
  _id_B7850001037AA074 = scene_node.angles;

  if(isDefined(self.path)) {
    spawnpos = self.path.origin;
    _id_B7850001037AA074 = self.path.angles;
  }

  vehicle = spawnVehicle(model, animname, vehicle, spawnpos, _id_B7850001037AA074);
  vehicle setvehicleteam(team);
  vehicle vehphys_forcekeyframedmotion();
  vehicle vehicleshowonminimap(0);
  vehicle.animname = animname;
  self.linktoent = vehicle;
  vehicle.infil = self;
  return vehicle;
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
  return guy;
}

_id_01FE5786BB2EAD05(scene_node, _id_D006AC472F253163, _id_3468A2B34119EEE1, animname) {
  actor = self.linktoent spawn_anim_model(animname, scene_node, _id_D006AC472F253163, _id_3468A2B34119EEE1);
  actor.infil = self;
  level waittill("infil_started");

  if(isDefined(actor.head))
    actor.head scriptmodelplayanim(level.scr_anim[actor.animname]["crossing_civ_infil"]);

  scripts\common\anim::anim_single_solo(actor, "crossing_civ_infil");
  actor delete();
}

_id_D7FEF246B7636B4D(scene_node, model, animname, number) {
  spawnpos = scene_node.origin;
  _id_B7850001037AA074 = scene_node.angles;
  actor = spawn("script_model", scene_node.origin);
  actor setModel(model);
  actor.animname = animname;
  actor scripts\common\anim::setanimtree();
  actor.infil = self;
  level waittill("infil_started");
  thread scripts\common\anim::anim_single_solo(actor, "crossing_civ_infil");
  _id_70A8A2AAE30F4847(scene_node, actor, animname, "crossing_civ_infil", model, number);
  level waittill("prematch_over");
}

_id_70A8A2AAE30F4847(scene_node, vehicle, animname, _id_643BCFEC059B4AE2, vehiclename, number) {
  _id_1F8ECC46988CA358 = 0;
  _id_02280DF582DD843C = getEntArray(scene_node.target, "targetname");
  _id_54B174A893636475 = scene_node.origin;
  _id_9CA1B8FD292FEFFA = scene_node.angles;
  _id_19B99157406B12A1 = undefined;

  if(!isDefined(_id_02280DF582DD843C)) {
    return;
  }
  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_02280DF582DD843C.size; _id_AC0E594AC96AA3A8++) {
    if(isDefined(_id_02280DF582DD843C[_id_AC0E594AC96AA3A8])) {
      if(_id_02280DF582DD843C[_id_AC0E594AC96AA3A8].script_noteworthy == vehiclename) {
        if(number == 0) {
          _id_19B99157406B12A1 = _id_02280DF582DD843C[_id_AC0E594AC96AA3A8];
          _id_1F8ECC46988CA358 = 1;
          break;
        } else
          number--;
      }
    }
  }

  if(!isDefined(_id_19B99157406B12A1) || _id_1F8ECC46988CA358 == 0) {
    return;
  }
  waittime = getanimlength(level.scr_anim[animname][_id_643BCFEC059B4AE2]);
  _id_19B99157406B12A1.canmove = 1;
  _id_19B99157406B12A1 setscriptablepartstate("visibility", "hide");
  wait(waittime);
  vehicle delete();
  _id_19B99157406B12A1 setscriptablepartstate("visibility", "show");
}