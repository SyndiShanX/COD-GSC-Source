/*****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\infilexfil\lbravo_infil_cp.gsc
*****************************************************/

lbravo_init(subtype) {
  initanims(subtype);
  _id_453E4FC2C649FEA4 = [];
  _id_453E4FC2C649FEA4[0] = [0, 1];
  _id_453E4FC2C649FEA4[1] = [4, 5];
  _id_453E4FC2C649FEA4[2] = [2];
  _id_453E4FC2C649FEA4[3] = [3];
  scripts\cp\infilexfil\infilexfil::infil_add("infil_lbravo", subtype, 6, 4, _id_453E4FC2C649FEA4, ::lbravo_spawn, ::lbravo_get_length, ::player_lbravo_infil_think);
}

lbravo_spawn(team, target, subtype) {
  scene_node = scripts\engine\utility::getStruct(target, "targetname");
  infil = spawn("script_origin", scene_node.origin);
  infil.angles = scene_node.angles;
  infil.scene_node = scene_node;
  infil.subtype = subtype;
  infil.allow_fire = 0;

  if(getdvarint("dvar_34AF8CA56A01ED17", 0) > 0)
    infil.allow_fire = getdvarint("dvar_34AF8CA56A01ED17");

  if(isDefined(scene_node.target))
    infil.path = scripts\engine\utility::getStruct("lbravoAlphaAdvancedPath", "targetname");

  if(isDefined(scene_node.script_label))
    infil._id_07B02A0C55EEDDF9 = scripts\engine\utility::getStruct(scene_node.script_label, "targetname");

  infil thread infilthink(team, subtype);
  level.infil_struct = infil;
  return infil;
}

lbravo_get_length(subtype) {
  if(isDefined(self.path)) {
    duration = parsepathlength();
    duration = duration + getanimlength(level.scr_anim["slot_0"]["lbravo_infil_" + subtype + "_loop_exit"]);
    duration = duration + getanimlength(level.scr_anim["slot_0"]["lbravo_infil_" + subtype + "_exit"]);
    return duration;
  } else {
    animlength = getanimlength(level.scr_anim["slot_0"]["lbravo_infil_" + subtype]);
    animlength = animlength + getanimlength(level.scr_anim["slot_0"]["lbravo_infil_" + subtype + "_exit"]);
    return animlength;
  }
}

player_lbravo_infil_think(infil, _id_E4B9CD561C7C0DE6) {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self endon("player_free_spot");
  self endon("joined_team");
  scripts\cp\cp_outofbounds::enableoobimmunity(self);

  if(getdvarint("dvar_00A7F868995FC7D3", -1) >= 0)
    _id_E4B9CD561C7C0DE6 = getdvarint("dvar_00A7F868995FC7D3", -1);

  if(isPlayer(self)) {
    self setclienttriggeraudiozone("cp_obsv_heli_infil", 1);
    scripts\cp\utility::allow_player_ignore_me(1);
  }

  thread player_infil_end(infil);

  if(istrue(infil.allow_fire)) {
    _id_9AC797B3576E56BA = level.scr_anim[infil.linktoent.animname]["lbravo_infil_" + infil.subtype];
    _id_4A5E5C0F661EE5E2 = getstartorigin(infil.linktoent.origin, infil.linktoent.angles, _id_9AC797B3576E56BA);
    _id_70A3110EC679BBC8 = getstartangles(infil.linktoent.origin, infil.linktoent.angles, _id_9AC797B3576E56BA);
    _id_4A5E5C0F661EE5E2 = _id_4A5E5C0F661EE5E2 - infil.linktoent.origin;
    _id_D95A174B2292916D = (0, 0, 0);
    _id_A2259B9F41F55197 = (0, 0, 0);

    switch (_id_E4B9CD561C7C0DE6) {
      case 0:
        _id_D95A174B2292916D = (47, 60, -106);
        _id_A2259B9F41F55197 = (10, 90, 0);
        break;
      case 1:
        _id_D95A174B2292916D = (47, -60, -106);
        _id_A2259B9F41F55197 = (10, 90, 0);
        break;
    }

    _id_77E029A941C20B53 = scripts\engine\utility::spawn_tag_origin(_id_4A5E5C0F661EE5E2, _id_70A3110EC679BBC8);
    _id_77E029A941C20B53 linkTo(infil.linktoent, "tag_origin_animate", _id_4A5E5C0F661EE5E2 + _id_D95A174B2292916D, _id_70A3110EC679BBC8 + _id_A2259B9F41F55197);
    self playerlinkTo(_id_77E029A941C20B53, "tag_origin", 1.0, 180, 180, 90, 90);
    self setdemeanorviewmodel("normal");
    self[[level.prematchallowfunc]](0);
  } else {
    thread scripts\cp\cp_infilexfil::infil_player_rig("slot_" + _id_E4B9CD561C7C0DE6, "viewhands_base_iw8");
    self.player_rig.weapon_state_func = scripts\cp\cp_infilexfil::handleweaponstatenotetrackcp;
    self.player_rig linkTo(infil.linktoent, "tag_origin_animate", (0, 0, 0), (0, 0, 0));
    self setdemeanorviewmodel("safe", "iw8_ges_demeanor_safe_heli");
  }

  self._id_3A44C5BC4019F640 = infil.linktoent.origin;
  self _meth_B88C89BB7CD1AB8E(infil.linktoent.origin);
  self lerpfovbypreset("80_instant");
  self lerpfovscalefactor(0.0, 0.0);
  thread scripts\cp\cp_infilexfil::infil_scene_fade_in(0.0, 1.55, "fade_up");
  thread player_van_disconnect();

  if(!scripts\cp\utility::gameflag("infil_started"))
    scripts\engine\utility::waittill_any_ents(level, "start_scene", infil, "start_scene");
  else
    wait 0.05;

  if(isDefined(self.team) && self.team != "spectator")
    self setsoundsubmix("iw9_cp_obsv_infil_heli");

  self.is_doing_infil = 1;

  if(!istrue(level._id_85AF047F9154DC4C))
    self notify("open_loadout_menu");

  self notify("fade_up");
  self setcinematicmotionoverride("disabled");

  if(isDefined(infil.path))
    thread playerthinkpath(infil, _id_E4B9CD561C7C0DE6);
  else
    thread playerthinkanim(infil, _id_E4B9CD561C7C0DE6);

  self lerpfovbypreset("default");
  _id_116171939929AF39::_id_DB31AE430D191461(1);
}

playerthinkpath(infil, _id_E4B9CD561C7C0DE6) {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self endon("player_free_spot");
  self endon("joined_team");

  if(_id_E4B9CD561C7C0DE6 == 0) {
    if(istrue(infil.allow_fire))
      self lerpviewangleclamp(1, 0.25, 0.25, 15, 100, 45, 30);
    else
      self lerpviewangleclamp(1, 0.25, 0.25, 10, 45, 45, 30);
  } else if(_id_E4B9CD561C7C0DE6 == 1) {
    if(istrue(infil.allow_fire))
      self lerpviewangleclamp(1, 0.25, 0.25, 100, 15, 45, 30);
    else
      self lerpviewangleclamp(1, 0.25, 0.25, 45, 10, 45, 30);
  } else
    self lerpviewangleclamp(1, 0.25, 0.25, 45, 45, 45, 30);

  rideloop(infil);

  if(self islinked()) {
    self lerpviewangleclamp(1, 0.25, 0.25, 0, 0, 0, 0);
    self lerpfovbypreset("default_2seconds");
    self lerpfovscalefactor(1, 2);
  }

  self stopanimscriptsceneevent();
  self setcinematicmotionoverride("iw9_playermotion");

  if(isDefined(self.player_rig))
    self.player_rig unlink();

  if(isDefined(self._id_3A44C5BC4019F640)) {
    self clearpredictedstreampos();
    self._id_3A44C5BC4019F640 = undefined;
  }

  if(istrue(infil.allow_fire) && self islinked()) {
    self[[level.prematchallowfunc]](1);
    self _meth_AF4B9B0F0E7C6C42(1);
  }

  self.is_doing_infil = undefined;
  self notify("player_finished_infil");
  scripts\cp\cp_outofbounds::disableoobimmunity(self);
  self setdemeanorviewmodel("normal");
  self stopviewmodelanim();
  scripts\cp\cp_infilexfil::takegunlesscp();
  self setstance("stand");
  _id_116171939929AF39::_id_DB31AE430D191461(0);
  self clearsoundsubmix("iw9_cp_obsv_infil_heli");
  infil notify("prematch_over");
  level notify("prematch_over");
  scripts\engine\utility::flag_set("infil_over");
}

rideloop(infil) {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self endon("player_free_spot");
  self endon("joined_team");
  infil.linktoent endon("unload");

  if(istrue(infil.allow_fire)) {
    for(;;)
      wait 60.0;
  } else {
    for(;;)
      infil.linktoent scripts\cp\cp_anim::anim_player_solo(self, self.player_rig, "lbravo_infil_" + infil.subtype + "_loop", "tag_origin_animate");
  }
}

playerthinkanim(infil, _id_E4B9CD561C7C0DE6) {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self endon("player_free_spot");
  self endon("joined_team");

  if(istrue(infil.allow_fire)) {
    self lerpviewangleclamp(1, 0.25, 0.25, 90, 90, 90, 90);
    infil.linktoent waittill("unload");
    self[[level.prematchallowfunc]](1);
  } else {
    self lerpviewangleclamp(1, 0.25, 0.25, 30, 30, 30, 30);
    infil.linktoent scripts\cp\cp_anim::anim_player_solo(self, self.player_rig, "lbravo_infil_" + infil.subtype, "tag_origin_animate");
  }

  self lerpviewangleclamp(1, 0.25, 0.25, 0, 0, 0, 0);
  self.player_rig unlink();
  self setdemeanorviewmodel("normal");
  self stopviewmodelanim();
  scripts\cp\cp_infilexfil::takegunlesscp();
  self clearsoundsubmix("iw9_cp_obsv_infil_heli");
  infil notify("prematch_over");
  level notify("prematch_over");
  scripts\engine\utility::flag_set("infil_over");
  thread scriptswitchweaponhack();
  thread clear_infil_ambient_zone();
  self visionsetnakedforplayer("", 0.75);
  self setdemeanorviewmodel("normal");
  self clearcinematicmotionoverride();
}

scriptswitchweaponhack() {
  waitframe();
  self notify("complete_late_infil_allows");
}

clear_infil_ambient_zone() {
  wait 1;
  self clearclienttriggeraudiozone(2);
}

player_infil_end(infil) {
  self endon("disconnect");
  scripts\engine\utility::waittill_any_ents(level, "prematch_over", infil, "prematch_over");
  self notify("remove_rig");
  self clearclienttriggeraudiozone(1.0);
  scripts\cp\utility::allow_player_ignore_me(0);
  scripts\cp\utility\player::setdof_default();
}

player_van_disconnect() {
  level endon("prematch_over");
  scripts\engine\utility::waittill_either("death", "disconnect");

  if(isDefined(self)) {
    self visionsetnakedforplayer("");
    self clearclienttriggeraudiozone(0.0);
    self lerpfovbypreset("default");
    self lerpfovscalefactor(1.0, 0.0);
    self setviewmodeldepthoffield(0, 0, 18);
    scripts\cp\utility\player::setdof_default();
  }
}

infilthink(team, _id_CA85A0DE365C6A63) {
  level endon("game_ended");

  foreach(ent in getEntArray("infil_delete", "script_noteworthy"))
  ent delete();

  thread vehiclethink(team, self.scene_node, _id_CA85A0DE365C6A63);
  thread actorthink(team, self.scene_node, _id_CA85A0DE365C6A63);
  scripts\engine\utility::waittill_any_ents(level, "infil_started", self, "infil_started");
  setDvar("r_spotLightEntityShadows", 1);
  level notify("start_scene");
  self notify("start_scene");
  duration = lbravo_get_length(_id_CA85A0DE365C6A63);
  wait(duration);
  scripts\engine\utility::waittill_any_ents(level, "prematch_over", self, "prematch_over");
  setDvar("r_spotLightEntityShadows", 0);

  while(isDefined(self.linktoent) || isDefined(self.actors))
    waitframe();

  self delete();
}

vehiclethink(team, scene_node, _id_CA85A0DE365C6A63, _id_16E334D22D37BE73) {
  level endon("game_ended");
  self.linktoent = spawninfilvehicle(scene_node, team, _id_CA85A0DE365C6A63);

  if(isDefined(self.path))
    thread vehiclethinkpath(team, scene_node, _id_CA85A0DE365C6A63, _id_16E334D22D37BE73);
  else
    thread vehiclethinkanim(team, scene_node, _id_CA85A0DE365C6A63, _id_16E334D22D37BE73);
}

vehiclethinkanim(team, scene_node, _id_CA85A0DE365C6A63, _id_16E334D22D37BE73) {
  scripts\common\anim::anim_first_frame_solo(self.linktoent, "lbravo_infil_" + _id_CA85A0DE365C6A63);
  scripts\engine\utility::waittill_any_ents(level, "infil_started", self, "infil_started");
  thread scripts\common\anim::anim_single_solo(self.linktoent, "lbravo_infil_" + _id_CA85A0DE365C6A63);
  duration = getanimlength(level.scr_anim[self.linktoent.animname]["lbravo_infil_" + _id_CA85A0DE365C6A63]);
  wait(duration);
  self.linktoent delete();
  self.linktoent = undefined;
}

spawninfilvehicle(scene_node, team, _id_CA85A0DE365C6A63) {
  spawnpos = scene_node.origin;
  _id_B7850001037AA074 = scene_node.angles;

  if(isDefined(self.path)) {
    spawnpos = self.path.origin;
    _id_B7850001037AA074 = self.path.angles;
  }

  spawnpoint = spawnStruct();
  spawnpoint.origin = spawnpos;
  spawnpoint.angles = _id_B7850001037AA074;
  spawnpoint.vehicletype = "veh9_mil_air_heli_medium_physics_mp";
  vehicle = scripts\cp_mp\vehicles\vehicle::vehicle_spawn("little_bird", spawnpoint);
  vehicle _meth_247AD6A91F6A4FFE(1);
  scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_makeunusable(vehicle);
  vehicle.spawnpoint = spawnpoint;
  vehicle setvehicleteam(team);
  vehicle.animname = "lbravo";
  vehicle setCanDamage(0);
  vehicle setscriptablepartstate("engine", "on", 0);
  vehicle.infil = self;
  vehicle scripts\engine\utility::ent_flag_init("unloaded");
  vehicle scripts\engine\utility::ent_flag_init("loaded");
  vehicle.riders = [];

  if(isDefined(level.spawn_infil_lbravo))
    level thread[[level.spawn_infil_lbravo]](vehicle);

  return vehicle;
}

actorthink(team, scene_node, _id_CA85A0DE365C6A63, _id_16E334D22D37BE73) {
  level endon("game_ended");
  self.actors = spawnactors(team, _id_CA85A0DE365C6A63, _id_16E334D22D37BE73);
  self.actors[0].anim_playsound_func = ::commander_play_sound_func;

  if(isDefined(self.linktoent._id_01592C4B325FFFF4)) {
    self.linktoent._id_01592C4B325FFFF4 scripts\common\anim::anim_first_frame([self.actors[0]], "lbravo_infil_" + _id_CA85A0DE365C6A63, self.actors[0]._id_1FEF77784CB19C0B);
    self.linktoent._id_01592C4B325FFFF4 scripts\common\anim::anim_first_frame([self.actors[1]], "lbravo_infil_" + _id_CA85A0DE365C6A63, self.actors[1]._id_1FEF77784CB19C0B);
  } else
    logprint("**Warning: Pilot anim not loaded for infil.");

  scripts\mp\utility\infilexfil::hideactors();
  scripts\engine\utility::waittill_any_ents(level, "infil_started", self, "infil_started");
  scripts\mp\utility\infilexfil::showactors();

  if(isDefined(self.path))
    actorthinkpath(team, scene_node, _id_CA85A0DE365C6A63, _id_16E334D22D37BE73);
  else
    actorthinkanim(team, scene_node, _id_CA85A0DE365C6A63, _id_16E334D22D37BE73);
}

actorthinkpath(team, scene_node, _id_CA85A0DE365C6A63, _id_16E334D22D37BE73) {
  if(isDefined(level.lbravo_actorthinkpath))
    level thread[[level.lbravo_actorthinkpath]](self);
  else
    actorthinkpath_default(self);
}

actorthinkpath_default(infil) {
  infil thread actorloopthink(infil.actors[0]);
  infil thread actorloopthink(infil.actors[1]);
}

actorloopthink(actor) {
  actorloop(actor);
  self.linktoent._id_01592C4B325FFFF4 scripts\common\anim::anim_single_solo(actor, "lbravo_infil_" + self.subtype + "_loop_exit", actor._id_1FEF77784CB19C0B);
}

actorloop(actor) {
  self.linktoent endon("unload");

  for(;;) {
    self.linktoent._id_01592C4B325FFFF4 scripts\common\anim::anim_single_solo(actor, "lbravo_infil_" + self.subtype + "_loop", actor._id_1FEF77784CB19C0B);
    wait 0.05;
  }
}

actorthinkanim(team, scene_node, _id_CA85A0DE365C6A63, _id_16E334D22D37BE73) {
  self.linktoent thread scripts\common\anim::anim_single(self.actors, "lbravo_infil_" + _id_CA85A0DE365C6A63, "tag_origin_animate");
  duration = getanimlength(level.scr_anim["pilot"]["lbravo_infil_" + _id_CA85A0DE365C6A63]);
  wait(duration);

  foreach(actor in self.actors)
  actor delete();

  self.actors = undefined;
}

spawnactors(team, _id_CA85A0DE365C6A63, _id_16E334D22D37BE73) {
  actors = [];
  _id_5E4FB41F759AB359 = self.linktoent gettagorigin("tag_pilot1") + rotatevector((-28, -15, 62), self.linktoent.angles);
  _id_A762931B3F542116 = self.linktoent gettagorigin("tag_pilot2") + rotatevector((-28, 15, 62), self.linktoent.angles);
  self.linktoent._id_01592C4B325FFFF4 = scripts\engine\utility::spawn_tag_origin(_id_5E4FB41F759AB359, self.linktoent.angles);
  self.linktoent._id_01592C4B325FFFF4 linkTo(self.linktoent);
  self.linktoent._id_01592F4B3260068D = scripts\engine\utility::spawn_tag_origin(_id_A762931B3F542116, self.linktoent.angles);
  self.linktoent._id_01592F4B3260068D linkTo(self.linktoent);
  actors[actors.size] = self.linktoent._id_01592C4B325FFFF4 spawn_anim_model("pilot", "tag_origin", "allied_pilot_fullbody_1");
  actors[actors.size] = self.linktoent._id_01592F4B3260068D spawn_anim_model("copilot", "tag_origin", "allied_pilot_fullbody_2");

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
    guy._id_1FEF77784CB19C0B = _id_0609C1B125A13456;
  }

  return guy;
}

initanims(subtype) {
  script_model_alpha_anims(subtype);
  vehicles_alpha_anims(subtype);
  scripts\common\anim::addnotetrack_customfunction("slot_0", "free_look", scripts\mp\utility\infilexfil::player_free_look, "lbravo_infil_alpha_exit");
  scripts\common\anim::addnotetrack_customfunction("slot_1", "free_look", scripts\mp\utility\infilexfil::player_free_look, "lbravo_infil_alpha_exit");
  scripts\common\anim::addnotetrack_customfunction("slot_2", "free_look", scripts\mp\utility\infilexfil::player_free_look, "lbravo_infil_alpha_exit");
  scripts\common\anim::addnotetrack_customfunction("slot_3", "free_look", scripts\mp\utility\infilexfil::player_free_look, "lbravo_infil_alpha_exit");
  scripts\common\anim::addnotetrack_customfunction("slot_4", "free_look", scripts\mp\utility\infilexfil::player_free_look, "lbravo_infil_alpha_exit");
  scripts\common\anim::addnotetrack_customfunction("slot_5", "free_look", scripts\mp\utility\infilexfil::player_free_look, "lbravo_infil_alpha_exit");
  scripts\common\anim::addnotetrack_customfunction("slot_0", "free_look", scripts\mp\utility\infilexfil::player_free_look, "lbravo_infil_bravo_exit");
  scripts\common\anim::addnotetrack_customfunction("slot_1", "free_look", scripts\mp\utility\infilexfil::player_free_look, "lbravo_infil_bravo_exit");
  scripts\common\anim::addnotetrack_customfunction("slot_2", "free_look", scripts\mp\utility\infilexfil::player_free_look, "lbravo_infil_bravo_exit");
  scripts\common\anim::addnotetrack_customfunction("slot_3", "free_look", scripts\mp\utility\infilexfil::player_free_look, "lbravo_infil_bravo_exit");
  scripts\common\anim::addnotetrack_customfunction("slot_4", "free_look", scripts\mp\utility\infilexfil::player_free_look, "lbravo_infil_bravo_exit");
  scripts\common\anim::addnotetrack_customfunction("slot_5", "free_look", scripts\mp\utility\infilexfil::player_free_look, "lbravo_infil_bravo_exit");
  scripts\common\anim::addnotetrack_customfunction("slot_0", "fov_80_instant", scripts\mp\utility\infilexfil::player_fov_80_instant);
  scripts\common\anim::addnotetrack_customfunction("slot_1", "fov_80_instant", scripts\mp\utility\infilexfil::player_fov_80_instant);
  scripts\common\anim::addnotetrack_customfunction("slot_2", "fov_80_instant", scripts\mp\utility\infilexfil::player_fov_80_instant);
  scripts\common\anim::addnotetrack_customfunction("slot_3", "fov_80_instant", scripts\mp\utility\infilexfil::player_fov_80_instant);
  scripts\common\anim::addnotetrack_customfunction("slot_4", "fov_80_instant", scripts\mp\utility\infilexfil::player_fov_80_instant);
  scripts\common\anim::addnotetrack_customfunction("slot_5", "fov_80_instant", scripts\mp\utility\infilexfil::player_fov_80_instant);
  scripts\common\anim::addnotetrack_customfunction("slot_0", "fov_63_2", scripts\mp\utility\infilexfil::player_fov_default_2);
  scripts\common\anim::addnotetrack_customfunction("slot_1", "fov_63_2", scripts\mp\utility\infilexfil::player_fov_default_2);
  scripts\common\anim::addnotetrack_customfunction("slot_2", "fov_63_2", scripts\mp\utility\infilexfil::player_fov_default_2);
  scripts\common\anim::addnotetrack_customfunction("slot_3", "fov_63_2", scripts\mp\utility\infilexfil::player_fov_default_2);
  scripts\common\anim::addnotetrack_customfunction("slot_4", "fov_63_2", scripts\mp\utility\infilexfil::player_fov_default_2);
  scripts\common\anim::addnotetrack_customfunction("slot_5", "fov_63_2", scripts\mp\utility\infilexfil::player_fov_default_2);
  scripts\common\anim::addnotetrack_customfunction("slot_0", "shake_on", scripts\mp\utility\infilexfil::cam_shake_low, "lbravo_infil_alpha");
  scripts\common\anim::addnotetrack_customfunction("slot_1", "shake_on", scripts\mp\utility\infilexfil::cam_shake_low, "lbravo_infil_alpha");
  scripts\common\anim::addnotetrack_customfunction("slot_2", "shake_on", scripts\mp\utility\infilexfil::cam_shake_low, "lbravo_infil_alpha");
  scripts\common\anim::addnotetrack_customfunction("slot_3", "shake_on", scripts\mp\utility\infilexfil::cam_shake_low, "lbravo_infil_alpha");
  scripts\common\anim::addnotetrack_customfunction("slot_4", "shake_on", scripts\mp\utility\infilexfil::cam_shake_low, "lbravo_infil_alpha");
  scripts\common\anim::addnotetrack_customfunction("slot_5", "shake_on", scripts\mp\utility\infilexfil::cam_shake_low, "lbravo_infil_alpha");
  scripts\common\anim::addnotetrack_customfunction("slot_0", "shake_on", scripts\mp\utility\infilexfil::cam_shake_low, "lbravo_infil_bravo");
  scripts\common\anim::addnotetrack_customfunction("slot_1", "shake_on", scripts\mp\utility\infilexfil::cam_shake_low, "lbravo_infil_bravo");
  scripts\common\anim::addnotetrack_customfunction("slot_2", "shake_on", scripts\mp\utility\infilexfil::cam_shake_low, "lbravo_infil_bravo");
  scripts\common\anim::addnotetrack_customfunction("slot_3", "shake_on", scripts\mp\utility\infilexfil::cam_shake_low, "lbravo_infil_bravo");
  scripts\common\anim::addnotetrack_customfunction("slot_4", "shake_on", scripts\mp\utility\infilexfil::cam_shake_low, "lbravo_infil_bravo");
  scripts\common\anim::addnotetrack_customfunction("slot_5", "shake_on", scripts\mp\utility\infilexfil::cam_shake_low, "lbravo_infil_bravo");
  scripts\common\anim::addnotetrack_customfunction("slot_0", "shake_off", scripts\mp\utility\infilexfil::cam_shake_off, "lbravo_infil_alpha_exit");
  scripts\common\anim::addnotetrack_customfunction("slot_1", "shake_off", scripts\mp\utility\infilexfil::cam_shake_off, "lbravo_infil_alpha_exit");
  scripts\common\anim::addnotetrack_customfunction("slot_2", "shake_off", scripts\mp\utility\infilexfil::cam_shake_off, "lbravo_infil_alpha_exit");
  scripts\common\anim::addnotetrack_customfunction("slot_3", "shake_off", scripts\mp\utility\infilexfil::cam_shake_off, "lbravo_infil_alpha_exit");
  scripts\common\anim::addnotetrack_customfunction("slot_4", "shake_off", scripts\mp\utility\infilexfil::cam_shake_off, "lbravo_infil_alpha_exit");
  scripts\common\anim::addnotetrack_customfunction("slot_5", "shake_off", scripts\mp\utility\infilexfil::cam_shake_off, "lbravo_infil_alpha_exit");
  scripts\common\anim::addnotetrack_customfunction("slot_0", "shake_off", scripts\mp\utility\infilexfil::cam_shake_off, "lbravo_infil_bravo_exit");
  scripts\common\anim::addnotetrack_customfunction("slot_1", "shake_off", scripts\mp\utility\infilexfil::cam_shake_off, "lbravo_infil_bravo_exit");
  scripts\common\anim::addnotetrack_customfunction("slot_2", "shake_off", scripts\mp\utility\infilexfil::cam_shake_off, "lbravo_infil_bravo_exit");
  scripts\common\anim::addnotetrack_customfunction("slot_3", "shake_off", scripts\mp\utility\infilexfil::cam_shake_off, "lbravo_infil_bravo_exit");
  scripts\common\anim::addnotetrack_customfunction("slot_4", "shake_off", scripts\mp\utility\infilexfil::cam_shake_off, "lbravo_infil_bravo_exit");
  scripts\common\anim::addnotetrack_customfunction("slot_5", "shake_off", scripts\mp\utility\infilexfil::cam_shake_off, "lbravo_infil_bravo_exit");
}

#using_animtree("script_model");

script_model_alpha_anims(subtype) {
  switch (subtype) {
    case "alpha":
      level.scr_animtree["pilot"] = #animtree;
      level.scr_anim["pilot"]["lbravo_infil_alpha"] = % mp_infil_lbravo_a_pilot;
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

#using_animtree("mp_vehicles_always_loaded");

vehicles_alpha_anims(subtype) {
  switch (subtype) {
    case "alpha":
      level.scr_animtree["lbravo"] = #animtree;
      level.scr_anim["lbravo"]["lbravo_infil_alpha"] = % mp_infil_lbravo_a_heli;
      break;
    case "bravo":
      level.scr_animtree["lbravo"] = #animtree;

      switch (getDvar("g_mapname")) {
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

commander_play_sound_func(alias, _id_EA3E3B2121E6713A, _id_9A0AFE8FF3D2508F) {
  foreach(player in self.infil.players)
  self playsoundtoplayer(alias, player);
}

vehiclethinkpath(team, scene_node, _id_CA85A0DE365C6A63, _id_16E334D22D37BE73) {
  level waittill("infil_started");
  self.linktoent endon("death");
  self.linktoent.unload_hover_offset = 130;
  self.linktoent.unload_time = 3.5;
  self.linktoent vehicle_teleport(self.linktoent.spawnpoint.origin, self.linktoent.spawnpoint.angles);
  self.linktoent scripts\common\vehicle_paths::vehicle_paths_helicopter(self.path);
  self.linktoent thread _id_EB5AAE60EB60077D(self.linktoent.origin);
  self.linktoent notify("unload");

  if(isDefined(self.linktoent.unload_time))
    wait(self.linktoent.unload_time);

  level notify("players_unloaded_from_infil");

  if(isDefined(self._id_07B02A0C55EEDDF9)) {
    maxdist = 122500;

    while(scripts\cp\utility::any_player_nearby(self.linktoent.origin, maxdist))
      wait 0.1;

    self.linktoent thread scripts\common\vehicle_paths::vehicle_paths_helicopter(self._id_07B02A0C55EEDDF9);
    self.linktoent thread _id_AB9DF6C53FE81FD9();
    self.linktoent.script_vehicle_selfremove = 1;
    self.linktoent notify("vehicle_exfil_start");
    level notify("infil_exfil_start", self.linktoent);

    if(soundexists("cp_observatory_infil_chopper_takeoff"))
      level.infil_struct.linktoent playsoundonmovingent("cp_observatory_infil_chopper_takeoff");
  }
}

_id_AB9DF6C53FE81FD9() {
  level endon("game_ended");
  self waittill("reached_dynamic_path_end");

  if(!isDefined(self.infil.actors)) {
    return;
  }
  foreach(actor in self.infil.actors)
  actor delete();
}

_id_EB5AAE60EB60077D(origin) {
  _id_65C0C475C179EA29 = createnavbadplacebybounds(origin, (80, 80, 350), (0, 0, 0));
  scripts\engine\utility::waittill_any_2("vehicle_exfil_start", "death");
  wait 2;
  destroynavobstacle(_id_65C0C475C179EA29);
}

parsepathlength() {
  if(!isDefined(self.path))
    return 0.0;

  if(isDefined(self.pathduration))
    return self.pathduration;

  self.pathduration = 0.0;
  node = self.path;
  speed = node.speed;

  for(;;) {
    if(isDefined(node.script_unload)) {
      break;
    }

    if(!isDefined(node.target)) {
      break;
    }

    next = scripts\engine\utility::getStruct(node.target, "targetname");

    if(!isDefined(next)) {
      break;
    }

    _id_9EB9E52B1DCD019D = distance(node.origin, next.origin);

    if(isDefined(node.speed))
      speed = node.speed;
    else
      speed = 30;

    _id_965BC0EEC4F74BB1 = 17.6;
    self.pathduration = self.pathduration + _id_9EB9E52B1DCD019D * 1.8 / (speed * _id_965BC0EEC4F74BB1);
    node = next;
  }

  return self.pathduration;
}