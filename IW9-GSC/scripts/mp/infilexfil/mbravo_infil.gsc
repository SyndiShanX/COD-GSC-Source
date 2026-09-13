/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\infilexfil\mbravo_infil.gsc
**************************************************/

_id_A8BCA89F5F67BF2B(subtype) {
  _id_7AB5B649FA408138::_id_0F1AED36AB4598EA("mbravo_infil");
  _id_453E4FC2C649FEA4 = [];
  _id_453E4FC2C649FEA4[0] = [0, 1];
  _id_453E4FC2C649FEA4[1] = [2, 3];
  _id_453E4FC2C649FEA4[2] = [4];
  _id_453E4FC2C649FEA4[3] = [5];
  thread scripts\mp\infilexfil\infilexfil::infil_add("infil_mbravo", subtype, 6, 4, _id_453E4FC2C649FEA4, ::_id_52416EA77B3B3E80, ::_id_0FBECFCA322B890C, ::_id_740AB38C4E4A258A);
}

_id_52416EA77B3B3E80(team, target, subtype, originalsubtype) {
  initanims(subtype, team, originalsubtype);
  scene_node = scripts\engine\utility::getStruct(target, "targetname");
  postlaunchscenenodecorrection(scene_node, team, subtype, originalsubtype);
  infil = spawn("script_origin", scene_node.origin);

  if(isDefined(scene_node.target))
    infil.path = scene_node;

  if(!isDefined(scene_node.angles))
    scene_node.angles = (0, 0, 0);

  infil.angles = scene_node.angles;
  infil.scene_node = scene_node;
  infil.subtype = subtype;
  infil.originalsubtype = originalsubtype;
  infil thread infilthink(team, originalsubtype);

  if((scripts\mp\utility\game::getgametype() == "arm" || scripts\mp\utility\game::getgametype() == "conflict") && isDefined(scene_node.target))
    level.teamdata[team]["captureLocation_Next"] = scene_node.target;

  return infil;
}

printdata(infil, subtype, originalsubtype) {
  org = infil.scene_node.origin;
  _id_8BC14603A27FA3E7 = infil.scene_node.angles;

  for(;;) {
    thread scripts\cp_mp\utility\debug_utility::drawangles(org, _id_8BC14603A27FA3E7, level.framedurationseconds, 1.0);
    waitframe();
  }
}

_id_0FBECFCA322B890C(subtype) {
  animlength = getanimlength(level.scr_anim["slot_0"]["mbravo_infil" + subtype + "_intro"]);
  animlength = animlength + getanimlength(level.scr_anim["slot_0"]["mbravo_infil" + subtype + "_exit"]);
  return animlength;
}

_id_740AB38C4E4A258A(infil, _id_E4B9CD561C7C0DE6) {
  self endon("death_or_disconnect");
  self endon("player_free_spot");
  self endon("joined_team");

  if(isPlayer(self))
    self setclienttriggeraudiozone("mbravo_preinfil_mix", 1);

  thread _id_827C68636856CF78();
  thread player_infil_end(infil);
  spawnpos = infil.linktoent gettagorigin("tag_origin_animate");
  _id_B7850001037AA074 = infil.linktoent gettagangles("tag_origin_animate");
  thread scripts\mp\utility\infilexfil::infil_player_rig_updated("slot_" + _id_E4B9CD561C7C0DE6, spawnpos, _id_B7850001037AA074);
  self.player_rig linkTo(infil.linktoent, "tag_origin_animate", (0, 0, 0), (0, 0, 0));

  if(self islinked()) {
    if(_id_E4B9CD561C7C0DE6 < 4)
      self lerpfovbypreset("80_instant");
  }

  self lerpfovscalefactor(0, 0);
  self visionsetnakedforplayer("mp_core_infil", 0.0);
  self.manualoverridewindmaterial = 1;
  self setscriptablepartstate("wind", "100", 0);
  self setdemeanorviewmodel("safe", "iw8_ges_demeanor_safe_heli");
  thread player_van_disconnect();
  thread cinematiccameratimeline(infil);
  scripts\mp\flags::gameflagwait("infil_started");

  if(scripts\cp_mp\utility\game_utility::_id_D2D2B803A7B741A4())
    self nightvisionviewon();

  thread scripts\mp\music_and_dialog::_id_03AA69E0E6827CE5();

  if(isDefined(self.animname) && !isai(self))
    thread _id_FFDF6C99DE481354();

  self setcinematicmotionoverride("disabled");
  thread playerthinkanim(infil, _id_E4B9CD561C7C0DE6);
  level waittill("prematch_over");
  self setscriptablepartstate("wind", "0", 0);
  self.manualoverridewindmaterial = 0;
  self clearcinematicmotionoverride();
  self disablephysicaldepthoffieldscripting();
}

_id_FFDF6C99DE481354() {
  self endon("disconnect");
  soundalias = "scn_infil_mbravo_heli_plr1";
  waittime = 11.25;

  switch (self.animname) {
    case "slot_0":
      soundalias = "scn_infil_mbravo_heli_plr1";
      waittime = 11.25;
      break;
    case "slot_1":
      soundalias = "scn_infil_mbravo_heli_plr2";
      waittime = 11.7;
      break;
    case "slot_2":
      soundalias = "scn_infil_mbravo_heli_plr3";
      waittime = 11.9;
      break;
    case "slot_3":
      soundalias = "scn_infil_mbravo_heli_plr4";
      waittime = 11.3;
      break;
    case "slot_4":
      soundalias = "scn_infil_mbravo_heli_plr5";
      waittime = 11.7;
      break;
    case "slot_5":
      soundalias = "scn_infil_mbravo_heli_plr6";
      waittime = 11.7;
      break;
    default:
      soundalias = "scn_infil_mbravo_heli_plr1";
      waittime = 11.25;
      break;
  }

  self setclienttriggeraudiozone("iw9_gen_infil_mix", 2);
  self playlocalsound("scn_infil_mbravo_heli_wind");
  wait(waittime);

  if(isDefined(self) && soundexists(soundalias))
    self playlocalsound(soundalias);
}

playerthinkanim(infil, _id_E4B9CD561C7C0DE6) {
  self endon("death_or_disconnect");
  self endon("player_free_spot");
  self endon("joined_team");
  _id_CA85A0DE365C6A63 = infil.subtype;

  if(getDvar("g_mapname") == "mp_downtown_gw") {
    if(self.team == "allies" && (infil.originalsubtype == "alpha1" || infil.originalsubtype == "alpha2"))
      _id_CA85A0DE365C6A63 = "bravo";

    if(self.team == "axis" && infil.originalsubtype == "bravo")
      _id_CA85A0DE365C6A63 = "alpha";
  }

  if(self islinked()) {
    if(_id_E4B9CD561C7C0DE6 == 0 || _id_E4B9CD561C7C0DE6 == 2 || _id_E4B9CD561C7C0DE6 == 4)
      self lerpviewangleclamp(1, 0.25, 0.25, 15, 45, 45, 25);
    else
      self lerpviewangleclamp(1, 0.25, 0.25, 45, 15, 45, 25);
  }

  thread scripts\mp\infilexfil\infilexfil::_id_D41CBA513A03D958(7.0);
  infil.linktoent scripts\mp\anim::anim_player_solo(self, self.player_rig, "mbravo_infil" + infil.originalsubtype + "_intro", "tag_origin_animate");
  self lerpfovscalefactor(1, 2);
  self.player_rig unlink();
  infil scripts\mp\anim::anim_player_solo(self, self.player_rig, "mbravo_infil" + infil.originalsubtype + "_exit");
  thread scripts\mp\class::unblockclasschange();
  thread scriptswitchweaponhack();
  thread clear_infil_ambient_zone();
  self visionsetnakedforplayer("", 0.75);
  self setdemeanorviewmodel("normal");
}

scriptswitchweaponhack() {
  waitframe();
  self notify("complete_late_infil_allows");
}

clear_infil_ambient_zone() {
  self endon("death_or_disconnect");
  wait 1;

  if(isDefined(self._id_5B097BDE4417D7AD))
    self clearsoundsubmix(self._id_5B097BDE4417D7AD, 2);

  self clearclienttriggeraudiozone(2);
}

_id_54281F5154E5E8DE(guy) {
  if(!isDefined(guy._id_8655D6F4C9340DB1))
    guy playsoundonmovingent("scn_infil_mbravo_heli_npc1");

  guy._id_8655D6F4C9340DB1 = 1;
}

_id_54281E5154E5E6AB(guy) {
  if(!isDefined(guy._id_8655D6F4C9340DB1))
    guy playsoundonmovingent("scn_infil_mbravo_heli_npc2");

  guy._id_8655D6F4C9340DB1 = 1;
}

_id_54281D5154E5E478(guy) {
  if(!isDefined(guy._id_8655D6F4C9340DB1))
    guy playsoundonmovingent("scn_infil_mbravo_heli_npc3");

  guy._id_8655D6F4C9340DB1 = 1;
}

_id_5428245154E5F3DD(guy) {
  if(!isDefined(guy._id_8655D6F4C9340DB1))
    guy playsoundonmovingent("scn_infil_mbravo_heli_npc4");

  guy._id_8655D6F4C9340DB1 = 1;
}

_id_5428235154E5F1AA(guy) {
  if(!isDefined(guy._id_8655D6F4C9340DB1))
    guy playsoundonmovingent("scn_infil_mbravo_heli_npc5");

  guy._id_8655D6F4C9340DB1 = 1;
}

_id_5428225154E5EF77(guy) {
  if(!isDefined(guy._id_8655D6F4C9340DB1))
    guy playsoundonmovingent("scn_infil_mbravo_heli_npc6");

  guy._id_8655D6F4C9340DB1 = 1;
}

_id_827C68636856CF78() {
  if(isPlayer(self)) {
    _id_E014D2BCF2D12FAC = spawn("script_origin", (0, 0, 0));
    _id_E014D2BCF2D12FAC showonlytoplayer(self);
    _id_178E779DC4E512AD = spawn("script_origin", (0, 0, 0));
    _id_178E779DC4E512AD showonlytoplayer(self);
    _id_E014D2BCF2D12FAC playLoopSound("dx_mpo_ukop_radio_chatter");
    _id_178E779DC4E512AD playLoopSound("amb_infil_mbravo_heli");
    scripts\mp\flags::gameflagwait("infil_started");
    wait 2;
    _id_E014D2BCF2D12FAC stoploopsound("dx_mpo_ukop_radio_chatter");
    _id_178E779DC4E512AD stoploopsound("amb_infil_mbravo_heli");
    _id_E014D2BCF2D12FAC delete();
    _id_178E779DC4E512AD delete();
  }
}

player_infil_end(infil) {
  self endon("disconnect");
  scripts\engine\utility::waittill_any_ents(level, "prematch_over", infil, "prematch_over");
  self notify("remove_rig");
  self clearclienttriggeraudiozone(1.0);
  self lerpfovbypreset("default_2seconds");
  scripts\mp\utility\player::setdof_default();
}

player_van_disconnect() {
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
  _id_E026A614F7467557 = getdvarfloat("r_mbVelocityScale", 0.2);

  foreach(ent in getEntArray("infil_delete", "script_noteworthy"))
  ent delete();

  thread vehiclethink(team, self.scene_node, _id_CA85A0DE365C6A63);
  thread actorthink(team, self.scene_node, _id_CA85A0DE365C6A63);
  scripts\mp\flags::gameflagwait("infil_started");
  setDvar("r_spotLightEntityShadows", 1);
  setDvar("r_mbVelocityScale", 1.0);
  level notify("start_scene");
  self notify("start_scene");
  scripts\engine\utility::waittill_any_ents(level, "prematch_over", self, "prematch_over");
  setDvar("r_spotLightEntityShadows", 0);
  setDvar("r_mbVelocityScale", _id_E026A614F7467557);

  while(isDefined(self.linktoent) || isDefined(self.actors))
    waitframe();

  level.infilsactive--;
  self delete();
}

vehiclethink(team, scene_node, _id_CA85A0DE365C6A63, _id_16E334D22D37BE73) {
  self.linktoent = spawninfilvehicle(scene_node, team, _id_CA85A0DE365C6A63);
  thread vehiclethinkanim(team, scene_node, _id_CA85A0DE365C6A63, _id_16E334D22D37BE73);
  thread heli_interior_sfx(_id_CA85A0DE365C6A63);
  level waittill("prematch_over");
  wait 3.0;

  if(!isDefined(self) || !isDefined(self.linktoent)) {
    return;
  }
  self.linktoent solid();
}

vehiclethinkanim(team, scene_node, _id_CA85A0DE365C6A63, _id_16E334D22D37BE73) {
  if(self.originalsubtype != self.subtype && getDvar("g_mapname") == "mp_downtown_gw")
    _id_CA85A0DE365C6A63 = self.originalsubtype;

  if(team == "allies" && (self.originalsubtype == "alpha" || self.originalsubtype == "alpha2") && getDvar("mapname") == "mp_boneyard_gw")
    _id_CA85A0DE365C6A63 = self.originalsubtype;

  scripts\common\anim::anim_first_frame_solo(self.linktoent, "mbravo_infil" + _id_CA85A0DE365C6A63);
  scripts\mp\flags::gameflagwait("infil_started");
  self.linktoent vehicle_turnengineoff();
  self.linktoent setscriptablepartstate("engine", "on", 0);
  self.linktoent setscriptablepartstate("infil_lights", "on", 0);
  thread scripts\common\anim::anim_single_solo(self.linktoent, "mbravo_infil" + _id_CA85A0DE365C6A63);

  if(isDefined(self.path)) {
    duration = getanimlength(level.scr_anim["slot_0"]["mbravo_infil" + _id_CA85A0DE365C6A63 + "_intro"]);
    wait(duration);
    self.linktoent stopanimScripted();

    if(self.linktoent vehicle_isphysveh())
      self.linktoent vehphys_setdefaultmotion();

    startstruct = spawnStruct();
    startstruct.origin = self.linktoent.origin;
    startstruct.angles = self.linktoent.angles;
    startstruct.radius = 500;
    startstruct.speed = 30;
    startstruct.target = self.path.target;
    self.linktoent scripts\common\vehicle_paths::vehicle_paths_helicopter(startstruct);
  } else {
    duration = getanimlength(level.scr_anim[self.linktoent.animname]["mbravo_infil" + _id_CA85A0DE365C6A63]);
    wait(duration);
  }

  if(isDefined(self.linktoent)) {
    self.linktoent delete();
    self.linktoent = undefined;
  }

  thread _id_5AE55D7EB7946799();
}

spawninfilvehicle(scene_node, team, _id_CA85A0DE365C6A63) {
  spawnpos = scene_node.origin;
  _id_B7850001037AA074 = scene_node.angles;

  if(team == "allies")
    model = "veh9_mil_air_heli_medium_personnel";
  else
    model = "veh9_mil_air_heli_medium_personnel";

  _id_AB5CD311F5DC80A6 = "veh9_mil_air_heli_medium_mp";
  _id_E29C89AE4C29E698 = getdvarint("dvar_8D5AA772209C7806", 0);

  if(_id_E29C89AE4C29E698 > 0)
    _id_AB5CD311F5DC80A6 = "veh9_mil_air_heli_medium_physics_mp";

  vehicle = spawnVehicle(model, _id_CA85A0DE365C6A63, _id_AB5CD311F5DC80A6, spawnpos, _id_B7850001037AA074);
  vehicle setvehicleteam(team);
  vehicle.animname = "mbravo";
  vehicle setCanDamage(0);

  if(vehicle vehicle_isphysveh()) {
    vehicle _meth_247AD6A91F6A4FFE(1);
    vehicle vehphys_forcekeyframedmotion();
  } else
    vehicle notsolid();

  vehicle hidepart("tag_main_rotor_blade_01");
  vehicle hidepart("tag_main_rotor_blade_02");
  vehicle hidepart("tag_main_rotor_blade_03");
  vehicle hidepart("tag_main_rotor_blade_04");
  vehicle hidepart("tag_tail_rotor_blade_01");
  vehicle hidepart("tag_tail_rotor_blade_02");
  vehicle.infil = self;
  vehicle vehicle_turnengineoff();
  return vehicle;
}

actorthink(team, scene_node, _id_CA85A0DE365C6A63, _id_16E334D22D37BE73) {
  self.actors = thread spawnactors(team, _id_CA85A0DE365C6A63, _id_16E334D22D37BE73);
  self.actors[0].anim_playsound_func = ::commander_play_sound_func;
  self.linktoent scripts\common\anim::anim_first_frame(self.actors, "mbravo_infil" + _id_CA85A0DE365C6A63, "tag_origin_animate");
  scripts\mp\utility\infilexfil::hideactors();
  scripts\mp\flags::gameflagwait("infil_started");
  scripts\mp\utility\infilexfil::showactors();
  actorthinkanim(team, scene_node, _id_CA85A0DE365C6A63, _id_16E334D22D37BE73);
}

actorthinkanim(team, scene_node, _id_CA85A0DE365C6A63, _id_16E334D22D37BE73) {
  self.linktoent thread scripts\common\anim::anim_single(self.actors, "mbravo_infil" + _id_CA85A0DE365C6A63, "tag_origin_animate");
  duration = getanimlength(level.scr_anim["pilot"]["mbravo_infil" + _id_CA85A0DE365C6A63]);
  wait(duration);

  foreach(actor in self.actors) {
    if(isDefined(actor))
      actor delete();
  }

  self.actors = undefined;
}

spawnactors(team, _id_CA85A0DE365C6A63, _id_16E334D22D37BE73) {
  actors = [];

  switch (team) {
    case "axis":
      actors[actors.size] = self.linktoent spawn_anim_model("pilot", "tag_origin_animate", "body_russian_helicopter_pilot", "head_russian_helicopter_pilot_opaque");
      actors[actors.size] = self.linktoent spawn_anim_model("copilot", "tag_origin_animate", "body_russian_helicopter_pilot", "head_mp_helicopter_crew");
      break;
    case "allies":
      actors[actors.size] = self.linktoent spawn_anim_model("pilot", "tag_origin_animate", "body_pilot_helicopter_british", "head_pilot_helicopter_british");
      actors[actors.size] = self.linktoent spawn_anim_model("copilot", "tag_origin_animate", "body_pilot_helicopter_british", "head_mp_helicopter_crew");
      break;
    default:
      actors[actors.size] = self.linktoent spawn_anim_model("pilot", "tag_origin_animate", "body_russian_helicopter_pilot", "head_russian_helicopter_pilot_opaque");
      actors[actors.size] = self.linktoent spawn_anim_model("copilot", "tag_origin_animate", "body_russian_helicopter_pilot", "head_mp_helicopter_crew");
      break;
  }

  foreach(actor in actors)
  actor.infil = self;

  return actors;
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

  return guy;
}

initanims(subtype, team, originalsubtype) {
  if(issubstr(originalsubtype, "alt")) {
    _id_ADEA51195E19842D(originalsubtype);
    _id_1E9ED96027E5D5DD(subtype, team, originalsubtype);
  } else {
    _id_7477F93E18524711(subtype);
    _id_83D11C9EC4313021(subtype, team, originalsubtype);
  }

  scripts\common\anim::addnotetrack_customfunction("slot_0", "free_look", scripts\mp\utility\infilexfil::player_free_look);
  scripts\common\anim::addnotetrack_customfunction("slot_1", "free_look", scripts\mp\utility\infilexfil::player_free_look);
  scripts\common\anim::addnotetrack_customfunction("slot_2", "free_look", scripts\mp\utility\infilexfil::player_free_look);
  scripts\common\anim::addnotetrack_customfunction("slot_3", "free_look", scripts\mp\utility\infilexfil::player_free_look);
  scripts\common\anim::addnotetrack_customfunction("slot_4", "free_look", scripts\mp\utility\infilexfil::player_free_look);
  scripts\common\anim::addnotetrack_customfunction("slot_5", "free_look", scripts\mp\utility\infilexfil::player_free_look);
  scripts\common\anim::addnotetrack_customfunction("slot_0", "fov_63_2", scripts\mp\utility\infilexfil::player_fov_default_2);
  scripts\common\anim::addnotetrack_customfunction("slot_1", "fov_63_2", scripts\mp\utility\infilexfil::player_fov_default_2);
  scripts\common\anim::addnotetrack_customfunction("slot_2", "fov_63_2", scripts\mp\utility\infilexfil::player_fov_default_2);
  scripts\common\anim::addnotetrack_customfunction("slot_3", "fov_63_2", scripts\mp\utility\infilexfil::player_fov_default_2);
  scripts\common\anim::addnotetrack_customfunction("slot_4", "fov_63_2", scripts\mp\utility\infilexfil::player_fov_default_2);
  scripts\common\anim::addnotetrack_customfunction("slot_5", "fov_63_2", scripts\mp\utility\infilexfil::player_fov_default_2);
  scripts\common\anim::addnotetrack_customfunction("slot_0", "scn_infil_mbravo_heli_npc1", ::_id_54281F5154E5E8DE);
  scripts\common\anim::addnotetrack_customfunction("slot_1", "scn_infil_mbravo_heli_npc2", ::_id_54281E5154E5E6AB);
  scripts\common\anim::addnotetrack_customfunction("slot_2", "scn_infil_mbravo_heli_npc3", ::_id_54281D5154E5E478);
  scripts\common\anim::addnotetrack_customfunction("slot_3", "scn_infil_mbravo_heli_npc4", ::_id_5428245154E5F3DD);
  scripts\common\anim::addnotetrack_customfunction("slot_4", "scn_infil_mbravo_heli_npc5", ::_id_5428235154E5F1AA);
  scripts\common\anim::addnotetrack_customfunction("slot_5", "scn_infil_mbravo_heli_npc6", ::_id_5428225154E5EF77);
}

#using_animtree("script_model");

_id_ADEA51195E19842D(subtype) {
  mapname = scripts\cp_mp\utility\game_utility::getmapname();

  switch (mapname) {
    default:
      level.scr_animtree["slot_0"] = #animtree;
      level.scr_anim["slot_0"]["mbravo_infil" + subtype + "_intro"] = % iw9_mp_infil_mbravo_seat_1_intro;
      level.scr_animname["slot_0"]["mbravo_infil" + subtype + "_intro"] = "iw9_mp_infil_mbravo_seat_1_intro";
      level.scr_eventanim["slot_0"]["mbravo_infil" + subtype + "_intro"] = "infil_mbravo_intro_1";
      level.scr_animtree["slot_0"] = #animtree;
      level.scr_anim["slot_0"]["mbravo_infil" + subtype + "_exit"] = % iw9_mp_infil_mbravo_seat_1_exit;
      level.scr_animname["slot_0"]["mbravo_infil" + subtype + "_exit"] = "iw9_mp_infil_mbravo_seat_1_exit";
      level.scr_eventanim["slot_0"]["mbravo_infil" + subtype + "_exit"] = "infil_mbravo_exit_1";
      level.scr_animtree["slot_1"] = #animtree;
      level.scr_anim["slot_1"]["mbravo_infil" + subtype + "_intro"] = % iw9_mp_infil_mbravo_seat_2_intro;
      level.scr_animname["slot_1"]["mbravo_infil" + subtype + "_intro"] = "iw9_mp_infil_mbravo_seat_2_intro";
      level.scr_eventanim["slot_1"]["mbravo_infil" + subtype + "_intro"] = "infil_mbravo_intro_2";
      level.scr_animtree["slot_1"] = #animtree;
      level.scr_anim["slot_1"]["mbravo_infil" + subtype + "_exit"] = % iw9_mp_infil_mbravo_seat_2_exit;
      level.scr_animname["slot_1"]["mbravo_infil" + subtype + "_exit"] = "iw9_mp_infil_mbravo_seat_2_exit";
      level.scr_eventanim["slot_1"]["mbravo_infil" + subtype + "_exit"] = "infil_mbravo_exit_2";
      level.scr_animtree["slot_2"] = #animtree;
      level.scr_anim["slot_2"]["mbravo_infil" + subtype + "_intro"] = % iw9_mp_infil_mbravo_seat_3_intro;
      level.scr_animname["slot_2"]["mbravo_infil" + subtype + "_intro"] = "iw9_mp_infil_mbravo_seat_3_intro";
      level.scr_eventanim["slot_2"]["mbravo_infil" + subtype + "_intro"] = "infil_mbravo_intro_3";
      level.scr_animtree["slot_2"] = #animtree;
      level.scr_anim["slot_2"]["mbravo_infil" + subtype + "_exit"] = % iw9_mp_infil_mbravo_seat_3_exit;
      level.scr_animname["slot_2"]["mbravo_infil" + subtype + "_exit"] = "iw9_mp_infil_mbravo_seat_3_exit";
      level.scr_eventanim["slot_2"]["mbravo_infil" + subtype + "_exit"] = "infil_mbravo_exit_3";
      level.scr_animtree["slot_3"] = #animtree;
      level.scr_anim["slot_3"]["mbravo_infil" + subtype + "_intro"] = % iw9_mp_infil_mbravo_seat_4_intro;
      level.scr_animname["slot_3"]["mbravo_infil" + subtype + "_intro"] = "iw9_mp_infil_mbravo_seat_4_intro";
      level.scr_eventanim["slot_3"]["mbravo_infil" + subtype + "_intro"] = "infil_mbravo_intro_4";
      level.scr_animtree["slot_3"] = #animtree;
      level.scr_anim["slot_3"]["mbravo_infil" + subtype + "_exit"] = % iw9_mp_infil_mbravo_seat_4_exit;
      level.scr_animname["slot_3"]["mbravo_infil" + subtype + "_exit"] = "iw9_mp_infil_mbravo_seat_4_exit";
      level.scr_eventanim["slot_3"]["mbravo_infil" + subtype + "_exit"] = "infil_mbravo_exit_4";
      level.scr_animtree["slot_4"] = #animtree;
      level.scr_anim["slot_4"]["mbravo_infil" + subtype + "_intro"] = % iw9_mp_infil_mbravo_seat_5_intro;
      level.scr_animname["slot_4"]["mbravo_infil" + subtype + "_intro"] = "iw9_mp_infil_mbravo_seat_5_intro";
      level.scr_eventanim["slot_4"]["mbravo_infil" + subtype + "_intro"] = "infil_mbravo_intro_5";
      level.scr_animtree["slot_4"] = #animtree;
      level.scr_anim["slot_4"]["mbravo_infil" + subtype + "_exit"] = % iw9_mp_infil_mbravo_seat_5_exit;
      level.scr_animname["slot_4"]["mbravo_infil" + subtype + "_exit"] = "iw9_mp_infil_mbravo_seat_5_exit";
      level.scr_eventanim["slot_4"]["mbravo_infil" + subtype + "_exit"] = "infil_mbravo_exit_5";
      level.scr_animtree["slot_5"] = #animtree;
      level.scr_anim["slot_5"]["mbravo_infil" + subtype + "_intro"] = % iw9_mp_infil_mbravo_seat_6_intro;
      level.scr_animname["slot_5"]["mbravo_infil" + subtype + "_intro"] = "iw9_mp_infil_mbravo_seat_6_intro";
      level.scr_eventanim["slot_5"]["mbravo_infil" + subtype + "_intro"] = "infil_mbravo_intro_6";
      level.scr_animtree["slot_5"] = #animtree;
      level.scr_anim["slot_5"]["mbravo_infil" + subtype + "_exit"] = % iw9_mp_infil_mbravo_seat_6_exit;
      level.scr_animname["slot_5"]["mbravo_infil" + subtype + "_exit"] = "iw9_mp_infil_mbravo_seat_6_exit";
      level.scr_eventanim["slot_5"]["mbravo_infil" + subtype + "_exit"] = "infil_mbravo_exit_6";
      level.scr_animtree["pilot"] = #animtree;
      level.scr_anim["pilot"]["mbravo_infil" + subtype] = % iw9_mp_infil_mbravo_pilot;
      level.scr_animname["pilot"]["mbravo_infil" + subtype] = "iw9_mp_infil_mbravo_pilot";
      level.scr_animtree["copilot"] = #animtree;
      level.scr_anim["copilot"]["mbravo_infil" + subtype] = % iw9_mp_infil_mbravo_copilot;
      level.scr_animname["copilot"]["mbravo_infil" + subtype] = "iw9_mp_infil_mbravo_copilot";
      break;
  }
}

_id_7477F93E18524711(subtype) {
  mapname = scripts\cp_mp\utility\game_utility::getmapname();

  switch (mapname) {
    default:
      level.scr_animtree["slot_0"] = #animtree;
      level.scr_anim["slot_0"]["mbravo_infil" + subtype + "_intro"] = % iw9_mp_infil_mbravo_seat_1_intro;
      level.scr_animname["slot_0"]["mbravo_infil" + subtype + "_intro"] = "iw9_mp_infil_mbravo_seat_1_intro";
      level.scr_eventanim["slot_0"]["mbravo_infil" + subtype + "_intro"] = "infil_mbravo_intro_1";
      level.scr_animtree["slot_0"] = #animtree;
      level.scr_anim["slot_0"]["mbravo_infil" + subtype + "_exit"] = % iw9_mp_infil_mbravo_seat_1_exit;
      level.scr_animname["slot_0"]["mbravo_infil" + subtype + "_exit"] = "iw9_mp_infil_mbravo_seat_1_exit";
      level.scr_eventanim["slot_0"]["mbravo_infil" + subtype + "_exit"] = "infil_mbravo_exit_1";
      level.scr_animtree["slot_1"] = #animtree;
      level.scr_anim["slot_1"]["mbravo_infil" + subtype + "_intro"] = % iw9_mp_infil_mbravo_seat_2_intro;
      level.scr_animname["slot_1"]["mbravo_infil" + subtype + "_intro"] = "iw9_mp_infil_mbravo_seat_2_intro";
      level.scr_eventanim["slot_1"]["mbravo_infil" + subtype + "_intro"] = "infil_mbravo_intro_2";
      level.scr_animtree["slot_1"] = #animtree;
      level.scr_anim["slot_1"]["mbravo_infil" + subtype + "_exit"] = % iw9_mp_infil_mbravo_seat_2_exit;
      level.scr_animname["slot_1"]["mbravo_infil" + subtype + "_exit"] = "iw9_mp_infil_mbravo_seat_2_exit";
      level.scr_eventanim["slot_1"]["mbravo_infil" + subtype + "_exit"] = "infil_mbravo_exit_2";
      level.scr_animtree["slot_2"] = #animtree;
      level.scr_anim["slot_2"]["mbravo_infil" + subtype + "_intro"] = % iw9_mp_infil_mbravo_seat_3_intro;
      level.scr_animname["slot_2"]["mbravo_infil" + subtype + "_intro"] = "iw9_mp_infil_mbravo_seat_3_intro";
      level.scr_eventanim["slot_2"]["mbravo_infil" + subtype + "_intro"] = "infil_mbravo_intro_3";
      level.scr_animtree["slot_2"] = #animtree;
      level.scr_anim["slot_2"]["mbravo_infil" + subtype + "_exit"] = % iw9_mp_infil_mbravo_seat_3_exit;
      level.scr_animname["slot_2"]["mbravo_infil" + subtype + "_exit"] = "iw9_mp_infil_mbravo_seat_3_exit";
      level.scr_eventanim["slot_2"]["mbravo_infil" + subtype + "_exit"] = "infil_mbravo_exit_3";
      level.scr_animtree["slot_3"] = #animtree;
      level.scr_anim["slot_3"]["mbravo_infil" + subtype + "_intro"] = % iw9_mp_infil_mbravo_seat_4_intro;
      level.scr_animname["slot_3"]["mbravo_infil" + subtype + "_intro"] = "iw9_mp_infil_mbravo_seat_4_intro";
      level.scr_eventanim["slot_3"]["mbravo_infil" + subtype + "_intro"] = "infil_mbravo_intro_4";
      level.scr_animtree["slot_3"] = #animtree;
      level.scr_anim["slot_3"]["mbravo_infil" + subtype + "_exit"] = % iw9_mp_infil_mbravo_seat_4_exit;
      level.scr_animname["slot_3"]["mbravo_infil" + subtype + "_exit"] = "iw9_mp_infil_mbravo_seat_4_exit";
      level.scr_eventanim["slot_3"]["mbravo_infil" + subtype + "_exit"] = "infil_mbravo_exit_4";
      level.scr_animtree["slot_4"] = #animtree;
      level.scr_anim["slot_4"]["mbravo_infil" + subtype + "_intro"] = % iw9_mp_infil_mbravo_seat_5_intro;
      level.scr_animname["slot_4"]["mbravo_infil" + subtype + "_intro"] = "iw9_mp_infil_mbravo_seat_5_intro";
      level.scr_eventanim["slot_4"]["mbravo_infil" + subtype + "_intro"] = "infil_mbravo_intro_5";
      level.scr_animtree["slot_4"] = #animtree;
      level.scr_anim["slot_4"]["mbravo_infil" + subtype + "_exit"] = % iw9_mp_infil_mbravo_seat_5_exit;
      level.scr_animname["slot_4"]["mbravo_infil" + subtype + "_exit"] = "iw9_mp_infil_mbravo_seat_5_exit";
      level.scr_eventanim["slot_4"]["mbravo_infil" + subtype + "_exit"] = "infil_mbravo_exit_5";
      level.scr_animtree["slot_5"] = #animtree;
      level.scr_anim["slot_5"]["mbravo_infil" + subtype + "_intro"] = % iw9_mp_infil_mbravo_seat_6_intro;
      level.scr_animname["slot_5"]["mbravo_infil" + subtype + "_intro"] = "iw9_mp_infil_mbravo_seat_6_intro";
      level.scr_eventanim["slot_5"]["mbravo_infil" + subtype + "_intro"] = "infil_mbravo_intro_6";
      level.scr_animtree["slot_5"] = #animtree;
      level.scr_anim["slot_5"]["mbravo_infil" + subtype + "_exit"] = % iw9_mp_infil_mbravo_seat_6_exit;
      level.scr_animname["slot_5"]["mbravo_infil" + subtype + "_exit"] = "iw9_mp_infil_mbravo_seat_6_exit";
      level.scr_eventanim["slot_5"]["mbravo_infil" + subtype + "_exit"] = "infil_mbravo_exit_6";
      level.scr_animtree["pilot"] = #animtree;
      level.scr_anim["pilot"]["mbravo_infil" + subtype] = % iw9_mp_infil_mbravo_pilot;
      level.scr_animname["pilot"]["mbravo_infil" + subtype] = "iw9_mp_infil_mbravo_pilot";
      level.scr_animtree["copilot"] = #animtree;
      level.scr_anim["copilot"]["mbravo_infil" + subtype] = % iw9_mp_infil_mbravo_copilot;
      level.scr_animname["copilot"]["mbravo_infil" + subtype] = "iw9_mp_infil_mbravo_copilot";
      break;
  }
}

#using_animtree("mp_vehicles_always_loaded");

_id_1E9ED96027E5D5DD(subtype, team, originalsubtype) {
  mapname = scripts\cp_mp\utility\game_utility::getmapname();

  switch (mapname) {
    default:
      level.scr_anim["mbravo"]["mbravo_infil" + originalsubtype] = % iw9_mp_infil_mbravo_alt_heli;
      break;
  }
}

_id_83D11C9EC4313021(subtype, team, originalsubtype) {
  mapname = scripts\cp_mp\utility\game_utility::getmapname();

  switch (mapname) {
    case "mp_swap_meet":
      level.scr_anim["mbravo"]["mbravo_infil" + originalsubtype] = % iw9_mp_infil_mbravo_swapmeet_heli;
      break;
    case "mp_luxury":
      level.scr_anim["mbravo"]["mbravo_infil" + originalsubtype] = % iw9_mp_infil_mbravo_luxury_heli;
      break;
    case "mp_catedral":
      level.scr_anim["mbravo"]["mbravo_infil" + originalsubtype] = % iw9_mp_infil_mbravo_catedral_heli;
      break;
    default:
      level.scr_anim["mbravo"]["mbravo_infil" + originalsubtype] = % iw9_mp_infil_mbravo_heli;
      break;
  }
}

commander_play_sound_func(alias, _id_EA3E3B2121E6713A, _id_9A0AFE8FF3D2508F) {
  foreach(player in self.infil.players) {
    if(soundexists(alias))
      self playsoundtoplayer(alias, player);
  }
}

heli_interior_sfx(_id_CA85A0DE365C6A63) {
  scripts\mp\flags::gameflagwait("infil_started");

  if(_id_CA85A0DE365C6A63 == "alpha") {
    if(soundexists("scn_infil_mbravo_heli1_lr")) {
      self.linktoent playsoundonmovingent("scn_infil_mbravo_heli1_lr");
      self.linktoent playsoundonmovingent("scn_infil_mbravo_heli1_feet");
    }
  } else if(soundexists("scn_infil_mbravo_heli2_lr")) {
    self.linktoent playsoundonmovingent("scn_infil_mbravo_heli2_lr");
    self.linktoent playsoundonmovingent("scn_infil_mbravo_heli2_feet");
  }

  level waittill("prematch_over");
}

deleteoninfilcomplete() {
  level waittill("prematch_over");

  if(!isDefined(self)) {
    return;
  }
  if(istrue(self.isbonus) && !isai(self))
    self setscriptablepartstate("base", "hide");
  else if(isalive(self))
    self suicide();
}

_id_5AE55D7EB7946799() {
  wait 5;
  _id_7AB5B649FA408138::_id_F4E0FF5CB899686D("mbravo_infil");
}

cinematiccameratimeline(infil) {
  self endon("death_or_disconnect");
  self endon("player_free_spot");
  self endon("joined_team");
  scripts\mp\flags::gameflagwait("infil_started");

  switch (level.mapname) {
    case "mp_runner":
    case "mp_runner_pm":
      wait 2.15;
      thread scripts\mp\utility\infilexfil::set_cinematicmotionomnvarovertime(0.0, 1.0, 0.75);
      wait 0.75;
      thread scripts\mp\utility\infilexfil::set_cinematicmotionomnvarovertime(1.0, 0.0, 0.75);
      break;
  }
}

postlaunchscenenodecorrection(scene_node, team, subtype, originalsubtype) {
  mapname = scripts\cp_mp\utility\game_utility::getmapname();

  switch (mapname) {
    case "mp_fishtown_gw":
      if(scripts\mp\utility\game::getgametype() == "arm" && team == "axis" && originalsubtype == "alpha") {
        scene_node.origin = scene_node.origin + anglestoright(scene_node.angles) * 50;
        scene_node.origin = (scene_node.origin[0], scene_node.origin[1], 174);
      }

      break;
    case "mp_wartorn_gw":
      if(scripts\mp\utility\game::getgametype() == "gwtdm") {
        if(team == "axis") {} else {}
      } else if(scripts\mp\utility\game::getgametype() == "arm") {
        if(team == "axis")
          scene_node.origin = scene_node.origin - (0, 0, 22.5);
        else
          scene_node.origin = scene_node.origin - (0, 380, -25);
      }

      break;
    case "mp_swap_meet":
      if(team == "axis")
        scene_node.origin = scene_node.origin + (10, 25, 0);

      break;
  }
}