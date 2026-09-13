/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\infilexfil\lbravo_infil.gsc
**************************************************/

lbravo_init(subtype) {
  _id_453E4FC2C649FEA4 = [];
  _id_453E4FC2C649FEA4[0] = [0, 1];
  _id_453E4FC2C649FEA4[1] = [2, 3];
  _id_453E4FC2C649FEA4[2] = [4];
  _id_453E4FC2C649FEA4[3] = [5];
  thread scripts\mp\infilexfil\infilexfil::infil_add("infil_lbravo", subtype, 6, 4, _id_453E4FC2C649FEA4, ::lbravo_spawn, ::lbravo_get_length, ::player_lbravo_infil_think);
}

lbravo_spawn(team, target, subtype, originalsubtype) {
  initanims(subtype, team, originalsubtype);
  scene_node = scripts\engine\utility::getStruct(target, "targetname");
  postlaunchscenenodecorrection(scene_node, team, subtype, originalsubtype);
  infil = spawn("script_origin", scene_node.origin);

  if(!isDefined(scene_node.angles))
    scene_node.angles = (0, 0, 0);

  infil.angles = scene_node.angles;
  infil.scene_node = scene_node;
  infil.subtype = subtype;
  infil.originalsubtype = originalsubtype;
  infil thread infilthink(team, subtype);

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

postlaunchscenenodecorrection(scene_node, team, subtype, originalsubtype) {
  mapname = scripts\cp_mp\utility\game_utility::getmapname();

  switch (mapname) {
    case "mp_quarry2":
      switch (originalsubtype) {
        case "alpha2":
          if(team == "allies")
            scene_node.origin = scene_node.origin + anglesToForward(scene_node.angles) * 100;

          break;
        case "bravo2":
          if(team == "allies") {
            scene_node.origin = scene_node.origin + anglesToForward(scene_node.angles) * -50;
            scene_node.origin = scene_node.origin + anglestoright(scene_node.angles) * -10;
          }

          break;
      }

      break;
    case "mp_aniyah":
      if(team == "axis" && subtype == "bravo") {
        scene_node.origin = (8296.4, 786.17, 286);
        scene_node.angles = (0, 210, 0);
      }

      if(team == "allies") {
        switch (level.gametype) {
          case "koth":
          case "hq":
          case "grnd":
          case "dd":
          case "sr":
          case "sd":
          case "cyber":
            scene_node.angles = (scene_node.angles[0], 344, scene_node.angles[2]);
            break;
        }
      }

      break;
  }
}

lbravo_get_length(subtype) {
  if(issubstr(subtype, "alpha"))
    subtype = "alpha";

  if(issubstr(subtype, "bravo"))
    subtype = "bravo";

  if(isDefined(self.path)) {
    duration = scripts\mp\infilexfil\infilexfil::parsehelipathlength();
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
  self endon("death_or_disconnect");
  self endon("player_free_spot");
  self endon("joined_team");

  if(isPlayer(self))
    self setclienttriggeraudiozone("lbravo_infil_intro", 1);

  thread lbravo_infil_radio_idle();
  thread player_infil_end(infil);
  spawnpos = infil.linktoent gettagorigin("origin_animate_jnt");
  _id_B7850001037AA074 = infil.linktoent gettagangles("origin_animate_jnt");
  thread scripts\mp\utility\infilexfil::infil_player_rig_updated("slot_" + _id_E4B9CD561C7C0DE6, spawnpos, _id_B7850001037AA074);
  self.player_rig linkTo(infil.linktoent, "origin_animate_jnt", (0, 0, 0), (0, 0, 0));
  self lerpfovbypreset("80_instant");
  self lerpfovscalefactor(0, 0);
  self.manualoverridewindmaterial = 1;
  self setscriptablepartstate("wind", "100", 0);
  _id_6059A26F4DAAF0C6 = _id_E4B9CD561C7C0DE6 == 0 || _id_E4B9CD561C7C0DE6 == 1;

  if(istrue(level.interactiveinfil) && !isai(self) && _id_6059A26F4DAAF0C6)
    giveinteractiveinfilweapon();
  else
    self setdemeanorviewmodel("safe", "iw8_ges_demeanor_safe_heli");

  thread player_van_disconnect();
  thread cinematiccameratimeline(infil);
  scripts\mp\flags::gameflagwait("infil_started");

  if(scripts\cp_mp\utility\game_utility::isnightmap())
    self nightvisionviewon();

  thread scripts\mp\music_and_dialog::_id_03AA69E0E6827CE5();

  if(isDefined(self.animname) && isPlayer(self)) {
    soundalias = "scn_infil_lbravo_heli_plr1";

    if(isDefined(infil.subtype)) {
      if(infil.subtype == "alpha") {
        switch (self.animname) {
          case "slot_0":
            soundalias = "scn_infil_lbravo_heli_plr1";
            break;
          case "slot_1":
            soundalias = "scn_infil_lbravo_heli_plr2";
            break;
          case "slot_2":
            soundalias = "scn_infil_lbravo_heli_plr3";
            break;
          case "slot_3":
            soundalias = "scn_infil_lbravo_heli_plr4";
            break;
          case "slot_4":
            soundalias = "scn_infil_lbravo_heli_plr5";
            break;
          case "slot_5":
            soundalias = "scn_infil_lbravo_heli_plr6";
            break;
          default:
            soundalias = "scn_infil_lbravo_heli_plr1";
            break;
        }
      } else {
        switch (self.animname) {
          case "slot_0":
            soundalias = "scn_infil_lbravo_bravo_heli_plr1";
            break;
          case "slot_1":
            soundalias = "scn_infil_lbravo_bravo_heli_plr2";
            break;
          case "slot_2":
            soundalias = "scn_infil_lbravo_bravo_heli_plr3";
            break;
          case "slot_3":
            soundalias = "scn_infil_lbravo_bravo_heli_plr4";
            break;
          case "slot_4":
            soundalias = "scn_infil_lbravo_bravo_heli_plr5";
            break;
          case "slot_5":
            soundalias = "scn_infil_lbravo_bravo_heli_plr6";
            break;
          default:
            soundalias = "scn_infil_lbravo_bravo_heli_plr1";
            break;
        }
      }
    }

    self setclienttriggeraudiozone("lbravo_infil", 2);
    self playlocalsound(soundalias);
  }

  self setcinematicmotionoverride("player_heli_ride");

  if(istrue(level.interactiveinfil) && !isai(self) && _id_6059A26F4DAAF0C6)
    thread allowinteractivecombat();

  if(isDefined(infil.path))
    thread playerthinkpath(infil, _id_E4B9CD561C7C0DE6);
  else
    thread playerthinkanim(infil, _id_E4B9CD561C7C0DE6);

  level waittill("prematch_over");
  self setcinematicmotionoverride("iw9_playermotion");
  self setscriptablepartstate("wind", "0", 0);
  self.manualoverridewindmaterial = 0;
}

playerthinkpath(infil, _id_E4B9CD561C7C0DE6) {
  self endon("death_or_disconnect");
  self endon("player_free_spot");
  self endon("joined_team");

  if(_id_E4B9CD561C7C0DE6 == 0)
    self lerpviewangleclamp(1, 0.25, 0.25, 10, 45, 45, 45);
  else if(_id_E4B9CD561C7C0DE6 == 1)
    self lerpviewangleclamp(1, 0.25, 0.25, 45, 10, 45, 45);
  else
    self lerpviewangleclamp(1, 0.25, 0.25, 45, 45, 45, 45);

  rideloop(infil);
  self lerpviewangleclamp(1, 0.25, 0.25, 0, 0, 0, 0);
  self lerpfovbypreset("default_2seconds");
  self lerpfovscalefactor(1, 2);
  self stopanimscriptsceneevent();
  infil.linktoent scripts\mp\anim::anim_player_solo(self, self.player_rig, "lbravo_infil_" + infil.subtype + "_loop_exit", "origin_animate_jnt");
  self setcinematicmotionoverride("iw9_playermotion");
  self.player_rig unlink();
  infil scripts\mp\anim::anim_player_solo(self, self.player_rig, "lbravo_infil_" + infil.subtype + "_exit");
}

rideloop(infil) {
  self endon("death_or_disconnect");
  self endon("player_free_spot");
  self endon("joined_team");
  infil.linktoent endon("unload");

  for(;;)
    infil.linktoent scripts\mp\anim::anim_player_solo(self, self.player_rig, "lbravo_infil_" + infil.subtype + "_loop", "origin_animate_jnt");
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

  if(_id_E4B9CD561C7C0DE6 == 0)
    self lerpviewangleclamp(1, 0.25, 0.25, 10, 45, 45, 45);
  else if(_id_E4B9CD561C7C0DE6 == 1)
    self lerpviewangleclamp(1, 0.25, 0.25, 45, 10, 45, 45);
  else
    self lerpviewangleclamp(1, 0.25, 0.25, 45, 45, 45, 45);

  infil.linktoent scripts\mp\anim::anim_player_solo(self, self.player_rig, "lbravo_infil_intro", "origin_animate_jnt");

  if(self islinked())
    self lerpviewangleclamp(1, 0.25, 0.25, 0, 0, 0, 0);

  self lerpfovscalefactor(1, 2);
  self.player_rig unlink();
  infil scripts\mp\anim::anim_player_solo(self, self.player_rig, "lbravo_infil_exit");
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

  if(isDefined(self)) {
    if(isDefined(self._id_5B097BDE4417D7AD))
      self clearsoundsubmix(self._id_5B097BDE4417D7AD, 2);

    self clearclienttriggeraudiozone(2);
  }
}

lbravo_infil_radio_idle() {
  if(isPlayer(self)) {
    _id_E014D2BCF2D12FAC = spawn("script_origin", (0, 0, 0));
    _id_E014D2BCF2D12FAC showonlytoplayer(self);
    _id_E014D2BCF2D12FAC playLoopSound("dx_mpo_ukop_radio_chatter");
    scripts\mp\flags::gameflagwait("infil_started");
    wait 2;
    _id_E014D2BCF2D12FAC stoploopsound("dx_mpo_ukop_radio_chatter");
    _id_E014D2BCF2D12FAC delete();
  }
}

player_infil_end(infil) {
  self endon("disconnect");
  scripts\engine\utility::waittill_any_ents(level, "prematch_over", infil, "prematch_over");
  self notify("remove_rig");
  self clearclienttriggeraudiozone(1.0);
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

  if(issubstr(_id_CA85A0DE365C6A63, "alpha"))
    _id_CA85A0DE365C6A63 = "alpha";

  if(issubstr(_id_CA85A0DE365C6A63, "bravo"))
    _id_CA85A0DE365C6A63 = "bravo";

  thread vehiclethink(team, self.scene_node, _id_CA85A0DE365C6A63);
  thread actorthink(team, self.scene_node, _id_CA85A0DE365C6A63);
  scripts\mp\flags::gameflagwait("infil_started");
  setDvar("r_spotLightEntityShadows", 1);
  setDvar("r_mbVelocityScale", 1.0);
  level notify("start_scene");
  self notify("start_scene");

  if(istrue(level.interactiveinfil))
    level thread interactiveinfilthink(team);

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

  if(isDefined(self.path))
    thread vehiclethinkpath(team, scene_node, _id_CA85A0DE365C6A63, _id_16E334D22D37BE73);
  else
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

  scripts\common\anim::anim_first_frame_solo(self.linktoent, "lbravo_infil");
  scripts\mp\flags::gameflagwait("infil_started");
  self.linktoent setscriptablepartstate("engine", "on", 0);
  self.linktoent setscriptablepartstate("infil_lights", "on", 0);
  thread scripts\common\anim::anim_single_solo(self.linktoent, "lbravo_infil");
  duration = getanimlength(level.scr_anim[self.linktoent.animname]["lbravo_infil"]);
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

  if(team == "allies")
    model = "veh8_mil_air_lbravo_personnel";
  else
    model = "veh8_mil_air_lbravo_personnel_east";

  vehicle = spawnVehicle(model, _id_CA85A0DE365C6A63, "lbravo_infil_mp", spawnpos, _id_B7850001037AA074);
  vehicle setvehicleteam(team);
  vehicle.animname = "lbravo";
  vehicle setCanDamage(0);
  vehicle notsolid();
  vehicle.infil = self;
  clip = getEnt("lbravo_clip", "targetname");

  if(isDefined(clip)) {
    _id_5F83B6E30BB8AE0C = spawn("script_model", vehicle.origin);
    _id_5F83B6E30BB8AE0C.angles = vehicle.angles;
    _id_5F83B6E30BB8AE0C clonebrushmodeltoscriptmodel(clip);
    _id_5F83B6E30BB8AE0C linkTo(vehicle);
  }

  return vehicle;
}

actorthink(team, scene_node, _id_CA85A0DE365C6A63, _id_16E334D22D37BE73) {
  self.actors = thread spawnactors(team, _id_CA85A0DE365C6A63, _id_16E334D22D37BE73);
  self.actors[0].anim_playsound_func = ::commander_play_sound_func;
  self.linktoent scripts\common\anim::anim_first_frame(self.actors, "lbravo_infil_" + _id_CA85A0DE365C6A63, "origin_animate_jnt");
  scripts\mp\utility\infilexfil::hideactors();
  scripts\mp\flags::gameflagwait("infil_started");
  scripts\mp\utility\infilexfil::showactors();

  if(isDefined(self.path))
    actorthinkpath(team, scene_node, _id_CA85A0DE365C6A63, _id_16E334D22D37BE73);
  else
    actorthinkanim(team, scene_node, _id_CA85A0DE365C6A63, _id_16E334D22D37BE73);
}

actorthinkpath(team, scene_node, _id_CA85A0DE365C6A63, _id_16E334D22D37BE73) {
  thread actorloopthink(self.actors[0]);
  thread actorloopthink(self.actors[1]);
}

actorloopthink(actor) {
  actorloop(actor);
}

actorloop(actor) {
  actor endon("death");
  self.linktoent endon("reached_dynamic_path_end");

  for(;;)
    self.linktoent scripts\common\anim::anim_single_solo(actor, "lbravo_infil_" + self.subtype + "_loop", "origin_animate_jnt");
}

actorthinkanim(team, scene_node, _id_CA85A0DE365C6A63, _id_16E334D22D37BE73) {
  self.linktoent thread scripts\common\anim::anim_single(self.actors, "lbravo_infil_" + _id_CA85A0DE365C6A63, "origin_animate_jnt");
  duration = getanimlength(level.scr_anim["pilot"]["lbravo_infil_" + _id_CA85A0DE365C6A63]);
  wait(duration);

  foreach(actor in self.actors) {
    if(isDefined(actor))
      actor delete();
  }

  self.actors = undefined;
}

spawnactors(team, _id_CA85A0DE365C6A63, _id_16E334D22D37BE73) {
  actors = [];
  actors[actors.size] = self.linktoent spawn_anim_model("pilot", "origin_animate_jnt", "body_pilot_helicopter_british", "head_pilot_helicopter_british");
  actors[actors.size] = self.linktoent spawn_anim_model("copilot", "origin_animate_jnt", "body_pilot_helicopter_british", "head_mp_helicopter_crew");

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
  script_model_alpha_anims(subtype);
  vehicles_alpha_anims(subtype, team, originalsubtype);
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
  scripts\common\anim::addnotetrack_customfunction("slot_0", "80_instant", scripts\mp\utility\infilexfil::player_fov_80_instant, "lbravo_infil_alpha");
  scripts\common\anim::addnotetrack_customfunction("slot_1", "80_instant", scripts\mp\utility\infilexfil::player_fov_80_instant, "lbravo_infil_alpha");
  scripts\common\anim::addnotetrack_customfunction("slot_2", "80_instant", scripts\mp\utility\infilexfil::player_fov_80_instant, "lbravo_infil_alpha");
  scripts\common\anim::addnotetrack_customfunction("slot_3", "80_instant", scripts\mp\utility\infilexfil::player_fov_80_instant, "lbravo_infil_alpha");
  scripts\common\anim::addnotetrack_customfunction("slot_4", "80_instant", scripts\mp\utility\infilexfil::player_fov_80_instant, "lbravo_infil_alpha");
  scripts\common\anim::addnotetrack_customfunction("slot_5", "80_instant", scripts\mp\utility\infilexfil::player_fov_80_instant, "lbravo_infil_alpha");
  scripts\common\anim::addnotetrack_customfunction("slot_0", "80_instant", scripts\mp\utility\infilexfil::player_fov_80_instant, "lbravo_infil_bravo");
  scripts\common\anim::addnotetrack_customfunction("slot_1", "80_instant", scripts\mp\utility\infilexfil::player_fov_80_instant, "lbravo_infil_bravo");
  scripts\common\anim::addnotetrack_customfunction("slot_2", "80_instant", scripts\mp\utility\infilexfil::player_fov_80_instant, "lbravo_infil_bravo");
  scripts\common\anim::addnotetrack_customfunction("slot_3", "80_instant", scripts\mp\utility\infilexfil::player_fov_80_instant, "lbravo_infil_bravo");
  scripts\common\anim::addnotetrack_customfunction("slot_4", "80_instant", scripts\mp\utility\infilexfil::player_fov_80_instant, "lbravo_infil_bravo");
  scripts\common\anim::addnotetrack_customfunction("slot_5", "80_instant", scripts\mp\utility\infilexfil::player_fov_80_instant, "lbravo_infil_bravo");
  scripts\common\anim::addnotetrack_customfunction("slot_0", "fov_63_2", scripts\mp\utility\infilexfil::player_fov_default_1, "lbravo_infil_alpha");
  scripts\common\anim::addnotetrack_customfunction("slot_1", "fov_63_2", scripts\mp\utility\infilexfil::player_fov_default_1, "lbravo_infil_alpha");
  scripts\common\anim::addnotetrack_customfunction("slot_2", "fov_63_2", scripts\mp\utility\infilexfil::player_fov_default_1, "lbravo_infil_alpha");
  scripts\common\anim::addnotetrack_customfunction("slot_3", "fov_63_2", scripts\mp\utility\infilexfil::player_fov_default_1, "lbravo_infil_alpha");
  scripts\common\anim::addnotetrack_customfunction("slot_4", "fov_63_2", scripts\mp\utility\infilexfil::player_fov_default_1, "lbravo_infil_alpha");
  scripts\common\anim::addnotetrack_customfunction("slot_5", "fov_63_2", scripts\mp\utility\infilexfil::player_fov_default_1, "lbravo_infil_alpha");
  scripts\common\anim::addnotetrack_customfunction("slot_0", "fov_63_2", scripts\mp\utility\infilexfil::player_fov_default_1, "lbravo_infil_bravo");
  scripts\common\anim::addnotetrack_customfunction("slot_1", "fov_63_2", scripts\mp\utility\infilexfil::player_fov_default_1, "lbravo_infil_bravo");
  scripts\common\anim::addnotetrack_customfunction("slot_2", "fov_63_2", scripts\mp\utility\infilexfil::player_fov_default_1, "lbravo_infil_bravo");
  scripts\common\anim::addnotetrack_customfunction("slot_3", "fov_63_2", scripts\mp\utility\infilexfil::player_fov_default_1, "lbravo_infil_bravo");
  scripts\common\anim::addnotetrack_customfunction("slot_4", "fov_63_2", scripts\mp\utility\infilexfil::player_fov_default_1, "lbravo_infil_bravo");
  scripts\common\anim::addnotetrack_customfunction("slot_5", "fov_63_2", scripts\mp\utility\infilexfil::player_fov_default_1, "lbravo_infil_bravo");
  scripts\common\anim::addnotetrack_customfunction("slot_0", "shake_on", scripts\mp\utility\infilexfil::rumble_low, "lbravo_infil_alpha");
  scripts\common\anim::addnotetrack_customfunction("slot_1", "shake_on", scripts\mp\utility\infilexfil::rumble_low, "lbravo_infil_alpha");
  scripts\common\anim::addnotetrack_customfunction("slot_2", "shake_on", scripts\mp\utility\infilexfil::rumble_low, "lbravo_infil_alpha");
  scripts\common\anim::addnotetrack_customfunction("slot_3", "shake_on", scripts\mp\utility\infilexfil::rumble_low, "lbravo_infil_alpha");
  scripts\common\anim::addnotetrack_customfunction("slot_4", "shake_on", scripts\mp\utility\infilexfil::rumble_low, "lbravo_infil_alpha");
  scripts\common\anim::addnotetrack_customfunction("slot_5", "shake_on", scripts\mp\utility\infilexfil::rumble_low, "lbravo_infil_alpha");
  scripts\common\anim::addnotetrack_customfunction("slot_0", "shake_on", scripts\mp\utility\infilexfil::rumble_low, "lbravo_infil_bravo");
  scripts\common\anim::addnotetrack_customfunction("slot_1", "shake_on", scripts\mp\utility\infilexfil::rumble_low, "lbravo_infil_bravo");
  scripts\common\anim::addnotetrack_customfunction("slot_2", "shake_on", scripts\mp\utility\infilexfil::rumble_low, "lbravo_infil_bravo");
  scripts\common\anim::addnotetrack_customfunction("slot_3", "shake_on", scripts\mp\utility\infilexfil::rumble_low, "lbravo_infil_bravo");
  scripts\common\anim::addnotetrack_customfunction("slot_4", "shake_on", scripts\mp\utility\infilexfil::rumble_low, "lbravo_infil_bravo");
  scripts\common\anim::addnotetrack_customfunction("slot_5", "shake_on", scripts\mp\utility\infilexfil::rumble_low, "lbravo_infil_bravo");
  scripts\common\anim::addnotetrack_customfunction("slot_0", "shake_off", ::customground, "lbravo_infil_alpha_exit");
  scripts\common\anim::addnotetrack_customfunction("slot_1", "shake_off", ::customground, "lbravo_infil_alpha_exit");
  scripts\common\anim::addnotetrack_customfunction("slot_2", "shake_off", ::customground, "lbravo_infil_alpha_exit");
  scripts\common\anim::addnotetrack_customfunction("slot_3", "shake_off", ::customground, "lbravo_infil_alpha_exit");
  scripts\common\anim::addnotetrack_customfunction("slot_4", "shake_off", ::customground, "lbravo_infil_alpha_exit");
  scripts\common\anim::addnotetrack_customfunction("slot_5", "shake_off", ::customground, "lbravo_infil_alpha_exit");
  scripts\common\anim::addnotetrack_customfunction("slot_0", "shake_off", ::customground, "lbravo_infil_bravo_exit");
  scripts\common\anim::addnotetrack_customfunction("slot_1", "shake_off", ::customground, "lbravo_infil_bravo_exit");
  scripts\common\anim::addnotetrack_customfunction("slot_2", "shake_off", ::customground, "lbravo_infil_bravo_exit");
  scripts\common\anim::addnotetrack_customfunction("slot_3", "shake_off", ::customground, "lbravo_infil_bravo_exit");
  scripts\common\anim::addnotetrack_customfunction("slot_4", "shake_off", ::customground, "lbravo_infil_bravo_exit");
  scripts\common\anim::addnotetrack_customfunction("slot_5", "shake_off", ::customground, "lbravo_infil_bravo_exit");
}

#using_animtree("script_model");

script_model_alpha_anims(subtype) {
  level.scr_animtree["slot_0"] = #animtree;
  level.scr_anim["slot_0"]["lbravo_infil_intro"] = % iw9_mp_infil_lbravo_seat_1_intro;
  level.scr_animname["slot_0"]["lbravo_infil_intro"] = "iw9_mp_infil_lbravo_seat_1_intro";
  level.scr_eventanim["slot_0"]["lbravo_infil_intro"] = "infil_lbravo_intro_1";
  level.scr_animtree["slot_0"] = #animtree;
  level.scr_anim["slot_0"]["lbravo_infil_exit"] = % iw9_mp_infil_lbravo_seat_1_exit;
  level.scr_animname["slot_0"]["lbravo_infil_exit"] = "iw9_mp_infil_lbravo_seat_1_exit";
  level.scr_eventanim["slot_0"]["lbravo_infil_exit"] = "infil_lbravo_exit_1";
  level.scr_animtree["slot_1"] = #animtree;
  level.scr_anim["slot_1"]["lbravo_infil_intro"] = % iw9_mp_infil_lbravo_seat_2_intro;
  level.scr_animname["slot_1"]["lbravo_infil_intro"] = "iw9_mp_infil_lbravo_seat_2_intro";
  level.scr_eventanim["slot_1"]["lbravo_infil_intro"] = "infil_lbravo_intro_2";
  level.scr_animtree["slot_1"] = #animtree;
  level.scr_anim["slot_1"]["lbravo_infil_exit"] = % iw9_mp_infil_lbravo_seat_2_exit;
  level.scr_animname["slot_1"]["lbravo_infil_exit"] = "iw9_mp_infil_lbravo_seat_2_exit";
  level.scr_eventanim["slot_1"]["lbravo_infil_exit"] = "infil_lbravo_exit_2";
  level.scr_animtree["slot_2"] = #animtree;
  level.scr_anim["slot_2"]["lbravo_infil_intro"] = % iw9_mp_infil_lbravo_seat_3_intro;
  level.scr_animname["slot_2"]["lbravo_infil_intro"] = "iw9_mp_infil_lbravo_seat_3_intro";
  level.scr_eventanim["slot_2"]["lbravo_infil_intro"] = "infil_lbravo_intro_3";
  level.scr_animtree["slot_2"] = #animtree;
  level.scr_anim["slot_2"]["lbravo_infil_exit"] = % iw9_mp_infil_lbravo_seat_3_exit;
  level.scr_animname["slot_2"]["lbravo_infil_exit"] = "iw9_mp_infil_lbravo_seat_3_exit";
  level.scr_eventanim["slot_2"]["lbravo_infil_exit"] = "infil_lbravo_exit_3";
  level.scr_animtree["slot_3"] = #animtree;
  level.scr_anim["slot_3"]["lbravo_infil_intro"] = % iw9_mp_infil_lbravo_seat_4_intro;
  level.scr_animname["slot_3"]["lbravo_infil_intro"] = "iw9_mp_infil_lbravo_seat_4_intro";
  level.scr_eventanim["slot_3"]["lbravo_infil_intro"] = "infil_lbravo_intro_4";
  level.scr_animtree["slot_3"] = #animtree;
  level.scr_anim["slot_3"]["lbravo_infil_exit"] = % iw9_mp_infil_lbravo_seat_4_exit;
  level.scr_animname["slot_3"]["lbravo_infil_exit"] = "iw9_mp_infil_lbravo_seat_4_exit";
  level.scr_eventanim["slot_3"]["lbravo_infil_exit"] = "infil_lbravo_exit_4";
  level.scr_animtree["slot_4"] = #animtree;
  level.scr_anim["slot_4"]["lbravo_infil_intro"] = % iw9_mp_infil_lbravo_seat_5_intro;
  level.scr_animname["slot_4"]["lbravo_infil_intro"] = "iw9_mp_infil_lbravo_seat_5_intro";
  level.scr_eventanim["slot_4"]["lbravo_infil_intro"] = "infil_lbravo_intro_5";
  level.scr_animtree["slot_4"] = #animtree;
  level.scr_anim["slot_4"]["lbravo_infil_exit"] = % iw9_mp_infil_lbravo_seat_5_exit;
  level.scr_animname["slot_4"]["lbravo_infil_exit"] = "iw9_mp_infil_lbravo_seat_5_exit";
  level.scr_eventanim["slot_4"]["lbravo_infil_exit"] = "infil_lbravo_exit_5";
  level.scr_animtree["slot_5"] = #animtree;
  level.scr_anim["slot_5"]["lbravo_infil_intro"] = % iw9_mp_infil_lbravo_seat_6_intro;
  level.scr_animname["slot_5"]["lbravo_infil_intro"] = "iw9_mp_infil_lbravo_seat_6_intro";
  level.scr_eventanim["slot_5"]["lbravo_infil_intro"] = "infil_lbravo_intro_6";
  level.scr_animtree["slot_5"] = #animtree;
  level.scr_anim["slot_5"]["lbravo_infil_exit"] = % iw9_mp_infil_lbravo_seat_6_exit;
  level.scr_animname["slot_5"]["lbravo_infil_exit"] = "iw9_mp_infil_lbravo_seat_6_exit";
  level.scr_eventanim["slot_5"]["lbravo_infil_exit"] = "infil_lbravo_exit_6";

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
      level.scr_anim["slot_0"]["lbravo_infil_alpha_exit"] = % mp_infil_lbravo_a_guy1_exit_wm;
      level.scr_animname["slot_0"]["lbravo_infil_alpha_exit"] = "mp_infil_lbravo_a_guy1_exit_wm";
      level.scr_eventanim["slot_0"]["lbravo_infil_alpha_exit"] = "infil_lbravo_a_exit_1";
      level.scr_anim["slot_0"]["lbravo_infil_alpha_loop"] = % mp_infil_lbravo_a_guy1_loop_wm;
      level.scr_animname["slot_0"]["lbravo_infil_alpha_loop"] = "mp_infil_lbravo_a_guy1_loop_wm";
      level.scr_eventanim["slot_0"]["lbravo_infil_alpha_loop"] = "infil_lbravo_a_loop_1";
      level.scr_anim["slot_0"]["lbravo_infil_alpha_loop_exit"] = % mp_infil_lbravo_a_guy1_loop_exit_wm;
      level.scr_animname["slot_0"]["lbravo_infil_alpha_loop_exit"] = "mp_infil_lbravo_a_guy1_loop_exit_wm";
      level.scr_eventanim["slot_0"]["lbravo_infil_alpha_loop_exit"] = "infil_lbravo_a_loop_exit_1";
      level.scr_animtree["slot_1"] = #animtree;
      level.scr_anim["slot_1"]["lbravo_infil_alpha"] = % mp_infil_lbravo_a_guy2_wm;
      level.scr_animname["slot_1"]["lbravo_infil_alpha"] = "mp_infil_lbravo_a_guy2_wm";
      level.scr_eventanim["slot_1"]["lbravo_infil_alpha"] = "infil_lbravo_a_2";
      level.scr_anim["slot_1"]["lbravo_infil_alpha_exit"] = % mp_infil_lbravo_a_guy2_exit_wm;
      level.scr_animname["slot_1"]["lbravo_infil_alpha_exit"] = "mp_infil_lbravo_a_guy2_exit_wm";
      level.scr_eventanim["slot_1"]["lbravo_infil_alpha_exit"] = "infil_lbravo_a_exit_2";
      level.scr_anim["slot_1"]["lbravo_infil_alpha_loop"] = % mp_infil_lbravo_a_guy2_loop_wm;
      level.scr_animname["slot_1"]["lbravo_infil_alpha_loop"] = "mp_infil_lbravo_a_guy2_loop_wm";
      level.scr_eventanim["slot_1"]["lbravo_infil_alpha_loop"] = "infil_lbravo_a_loop_2";
      level.scr_anim["slot_1"]["lbravo_infil_alpha_loop_exit"] = % mp_infil_lbravo_a_guy2_loop_exit_wm;
      level.scr_animname["slot_1"]["lbravo_infil_alpha_loop_exit"] = "mp_infil_lbravo_a_guy2_loop_exit_wm";
      level.scr_eventanim["slot_1"]["lbravo_infil_alpha_loop_exit"] = "infil_lbravo_a_loop_exit_2";
      level.scr_animtree["slot_2"] = #animtree;
      level.scr_anim["slot_2"]["lbravo_infil_alpha"] = % mp_infil_lbravo_a_guy3_wm;
      level.scr_animname["slot_2"]["lbravo_infil_alpha"] = "mp_infil_lbravo_a_guy3_wm";
      level.scr_eventanim["slot_2"]["lbravo_infil_alpha"] = "infil_lbravo_a_3";
      level.scr_anim["slot_2"]["lbravo_infil_alpha_exit"] = % mp_infil_lbravo_a_guy3_exit_wm;
      level.scr_animname["slot_2"]["lbravo_infil_alpha_exit"] = "mp_infil_lbravo_a_guy3_exit_wm";
      level.scr_eventanim["slot_2"]["lbravo_infil_alpha_exit"] = "infil_lbravo_a_exit_3";
      level.scr_anim["slot_2"]["lbravo_infil_alpha_loop"] = % mp_infil_lbravo_a_guy3_loop_wm;
      level.scr_animname["slot_2"]["lbravo_infil_alpha_loop"] = "mp_infil_lbravo_a_guy3_loop_wm";
      level.scr_eventanim["slot_2"]["lbravo_infil_alpha_loop"] = "infil_lbravo_a_loop_3";
      level.scr_anim["slot_2"]["lbravo_infil_alpha_loop_exit"] = % mp_infil_lbravo_a_guy3_loop_exit_wm;
      level.scr_animname["slot_2"]["lbravo_infil_alpha_loop_exit"] = "mp_infil_lbravo_a_guy3_loop_exit_wm";
      level.scr_eventanim["slot_2"]["lbravo_infil_alpha_loop_exit"] = "infil_lbravo_a_loop_exit_3";
      level.scr_animtree["slot_3"] = #animtree;
      level.scr_anim["slot_3"]["lbravo_infil_alpha"] = % mp_infil_lbravo_a_guy4_wm;
      level.scr_animname["slot_3"]["lbravo_infil_alpha"] = "mp_infil_lbravo_a_guy4_wm";
      level.scr_eventanim["slot_3"]["lbravo_infil_alpha"] = "infil_lbravo_a_4";
      level.scr_anim["slot_3"]["lbravo_infil_alpha_exit"] = % mp_infil_lbravo_a_guy4_exit_wm;
      level.scr_animname["slot_3"]["lbravo_infil_alpha_exit"] = "mp_infil_lbravo_a_guy4_exit_wm";
      level.scr_eventanim["slot_3"]["lbravo_infil_alpha_exit"] = "infil_lbravo_a_exit_4";
      level.scr_anim["slot_3"]["lbravo_infil_alpha_loop"] = % mp_infil_lbravo_a_guy4_loop_wm;
      level.scr_animname["slot_3"]["lbravo_infil_alpha_loop"] = "mp_infil_lbravo_a_guy4_loop_wm";
      level.scr_eventanim["slot_3"]["lbravo_infil_alpha_loop"] = "infil_lbravo_a_loop_4";
      level.scr_anim["slot_3"]["lbravo_infil_alpha_loop_exit"] = % mp_infil_lbravo_a_guy4_loop_exit_wm;
      level.scr_animname["slot_3"]["lbravo_infil_alpha_loop_exit"] = "mp_infil_lbravo_a_guy4_loop_exit_wm";
      level.scr_eventanim["slot_3"]["lbravo_infil_alpha_loop_exit"] = "infil_lbravo_a_loop_exit_4";
      level.scr_animtree["slot_4"] = #animtree;
      level.scr_anim["slot_4"]["lbravo_infil_alpha"] = % mp_infil_lbravo_a_guy5_wm;
      level.scr_animname["slot_4"]["lbravo_infil_alpha"] = "mp_infil_lbravo_a_guy5_wm";
      level.scr_eventanim["slot_4"]["lbravo_infil_alpha"] = "infil_lbravo_a_5";
      level.scr_anim["slot_4"]["lbravo_infil_alpha_exit"] = % mp_infil_lbravo_a_guy5_exit_wm;
      level.scr_animname["slot_4"]["lbravo_infil_alpha_exit"] = "mp_infil_lbravo_a_guy5_exit_wm";
      level.scr_eventanim["slot_4"]["lbravo_infil_alpha_exit"] = "infil_lbravo_a_exit_5";
      level.scr_anim["slot_4"]["lbravo_infil_alpha_loop"] = % mp_infil_lbravo_a_guy5_loop_wm;
      level.scr_animname["slot_4"]["lbravo_infil_alpha_loop"] = "mp_infil_lbravo_a_guy5_loop_wm";
      level.scr_eventanim["slot_4"]["lbravo_infil_alpha_loop"] = "infil_lbravo_a_loop_5";
      level.scr_anim["slot_4"]["lbravo_infil_alpha_loop_exit"] = % mp_infil_lbravo_a_guy5_loop_exit_wm;
      level.scr_animname["slot_4"]["lbravo_infil_alpha_loop_exit"] = "mp_infil_lbravo_a_guy5_loop_exit_wm";
      level.scr_eventanim["slot_4"]["lbravo_infil_alpha_loop_exit"] = "infil_lbravo_a_loop_exit_5";
      level.scr_animtree["slot_5"] = #animtree;
      level.scr_anim["slot_5"]["lbravo_infil_alpha"] = % mp_infil_lbravo_a_guy6_wm;
      level.scr_animname["slot_5"]["lbravo_infil_alpha"] = "mp_infil_lbravo_a_guy6_wm";
      level.scr_eventanim["slot_5"]["lbravo_infil_alpha"] = "infil_lbravo_a_6";
      level.scr_anim["slot_5"]["lbravo_infil_alpha_exit"] = % mp_infil_lbravo_a_guy6_exit_wm;
      level.scr_animname["slot_5"]["lbravo_infil_alpha_exit"] = "mp_infil_lbravo_a_guy6_exit_wm";
      level.scr_eventanim["slot_5"]["lbravo_infil_alpha_exit"] = "infil_lbravo_a_exit_6";
      level.scr_anim["slot_5"]["lbravo_infil_alpha_loop"] = % mp_infil_lbravo_a_guy6_loop_wm;
      level.scr_animname["slot_5"]["lbravo_infil_alpha_loop"] = "mp_infil_lbravo_a_guy6_loop_wm";
      level.scr_eventanim["slot_5"]["lbravo_infil_alpha_loop"] = "infil_lbravo_a_loop_6";
      level.scr_anim["slot_5"]["lbravo_infil_alpha_loop_exit"] = % mp_infil_lbravo_a_guy6_loop_exit_wm;
      level.scr_animname["slot_5"]["lbravo_infil_alpha_loop_exit"] = "mp_infil_lbravo_a_guy6_loop_exit_wm";
      level.scr_eventanim["slot_5"]["lbravo_infil_alpha_loop_exit"] = "infil_lbravo_a_loop_exit_6";
      break;
    case "bravo":
      level.scr_animtree["pilot"] = #animtree;
      level.scr_anim["pilot"]["lbravo_infil_bravo"] = % mp_infil_lbravo_b_pilot;
      level.scr_animname["pilot"]["lbravo_infil_bravo"] = "mp_infil_lbravo_b_pilot";
      level.scr_animtree["pilot"] = #animtree;
      level.scr_anim["pilot"]["lbravo_infil_bravo_loop"] = % mp_infil_lbravo_a_pilot_loop;
      level.scr_animname["pilot"]["lbravo_infil_bravo_loop"] = "mp_infil_lbravo_a_pilot_loop";
      level.scr_animtree["pilot"] = #animtree;
      level.scr_anim["pilot"]["lbravo_infil_bravo_loop_exit"] = % mp_infil_lbravo_a_pilot_loop_exit;
      level.scr_animname["pilot"]["lbravo_infil_bravo_loop_exit"] = "mp_infil_lbravo_a_pilot_loop_exit";
      level.scr_animtree["copilot"] = #animtree;
      level.scr_anim["copilot"]["lbravo_infil_bravo"] = % mp_infil_lbravo_b_copilot;
      level.scr_animname["copilot"]["lbravo_infil_bravo"] = "mp_infil_lbravo_b_copilot";
      level.scr_animtree["copilot"] = #animtree;
      level.scr_anim["copilot"]["lbravo_infil_bravo_loop"] = % mp_infil_lbravo_a_copilot_loop;
      level.scr_animname["copilot"]["lbravo_infil_bravo_loop"] = "mp_infil_lbravo_a_copilot_loop";
      level.scr_animtree["copilot"] = #animtree;
      level.scr_anim["copilot"]["lbravo_infil_bravo_loop_exit"] = % mp_infil_lbravo_a_copilot_loop_exit;
      level.scr_animname["copilot"]["lbravo_infil_bravo_loop_exit"] = "mp_infil_lbravo_a_copilot_loop_exit";
      level.scr_animtree["slot_0"] = #animtree;
      level.scr_anim["slot_0"]["lbravo_infil_bravo"] = % mp_infil_lbravo_b_guy1_wm;
      level.scr_animname["slot_0"]["lbravo_infil_bravo"] = "mp_infil_lbravo_b_guy1_wm";
      level.scr_eventanim["slot_0"]["lbravo_infil_bravo"] = "infil_lbravo_b_1";
      level.scr_anim["slot_0"]["lbravo_infil_bravo_exit"] = % mp_infil_lbravo_b_guy1_exit_wm;
      level.scr_animname["slot_0"]["lbravo_infil_bravo_exit"] = "mp_infil_lbravo_b_guy1_exit_wm";
      level.scr_eventanim["slot_0"]["lbravo_infil_bravo_exit"] = "infil_lbravo_b_exit_1";
      level.scr_anim["slot_0"]["lbravo_infil_bravo_loop"] = % mp_infil_lbravo_a_guy1_loop_wm;
      level.scr_animname["slot_0"]["lbravo_infil_bravo_loop"] = "mp_infil_lbravo_a_guy1_loop_wm";
      level.scr_eventanim["slot_0"]["lbravo_infil_bravo_loop"] = "infil_lbravo_a_loop_1";
      level.scr_anim["slot_0"]["lbravo_infil_bravo_loop_exit"] = % mp_infil_lbravo_a_guy1_loop_exit_wm;
      level.scr_animname["slot_0"]["lbravo_infil_bravo_loop_exit"] = "mp_infil_lbravo_a_guy1_loop_exit_wm";
      level.scr_eventanim["slot_0"]["lbravo_infil_bravo_loop_exit"] = "infil_lbravo_a_loop_exit_1";
      level.scr_animtree["slot_1"] = #animtree;
      level.scr_anim["slot_1"]["lbravo_infil_bravo"] = % mp_infil_lbravo_b_guy2_wm;
      level.scr_animname["slot_1"]["lbravo_infil_bravo"] = "mp_infil_lbravo_b_guy2_wm";
      level.scr_eventanim["slot_1"]["lbravo_infil_bravo"] = "infil_lbravo_b_2";
      level.scr_anim["slot_1"]["lbravo_infil_bravo_exit"] = % mp_infil_lbravo_b_guy2_exit_wm;
      level.scr_animname["slot_1"]["lbravo_infil_bravo_exit"] = "mp_infil_lbravo_b_guy2_exit_wm";
      level.scr_eventanim["slot_1"]["lbravo_infil_bravo_exit"] = "infil_lbravo_b_exit_2";
      level.scr_anim["slot_1"]["lbravo_infil_bravo_loop"] = % mp_infil_lbravo_a_guy2_loop_wm;
      level.scr_animname["slot_1"]["lbravo_infil_bravo_loop"] = "mp_infil_lbravo_a_guy2_loop_wm";
      level.scr_eventanim["slot_1"]["lbravo_infil_bravo_loop"] = "infil_lbravo_a_loop_2";
      level.scr_anim["slot_1"]["lbravo_infil_bravo_loop_exit"] = % mp_infil_lbravo_a_guy2_loop_exit_wm;
      level.scr_animname["slot_1"]["lbravo_infil_bravo_loop_exit"] = "mp_infil_lbravo_a_guy2_loop_exit_wm";
      level.scr_eventanim["slot_1"]["lbravo_infil_bravo_loop_exit"] = "infil_lbravo_a_loop_exit_2";
      level.scr_animtree["slot_2"] = #animtree;
      level.scr_anim["slot_2"]["lbravo_infil_bravo"] = % mp_infil_lbravo_b_guy3_wm;
      level.scr_animname["slot_2"]["lbravo_infil_bravo"] = "mp_infil_lbravo_b_guy3_wm";
      level.scr_eventanim["slot_2"]["lbravo_infil_bravo"] = "infil_lbravo_b_3";
      level.scr_anim["slot_2"]["lbravo_infil_bravo_exit"] = % mp_infil_lbravo_b_guy3_exit_wm;
      level.scr_animname["slot_2"]["lbravo_infil_bravo_exit"] = "mp_infil_lbravo_b_guy3_exit_wm";
      level.scr_eventanim["slot_2"]["lbravo_infil_bravo_exit"] = "infil_lbravo_b_exit_3";
      level.scr_anim["slot_2"]["lbravo_infil_bravo_loop"] = % mp_infil_lbravo_a_guy3_loop_wm;
      level.scr_animname["slot_2"]["lbravo_infil_bravo_loop"] = "mp_infil_lbravo_a_guy3_loop_wm";
      level.scr_eventanim["slot_2"]["lbravo_infil_bravo_loop"] = "infil_lbravo_a_loop_3";
      level.scr_anim["slot_2"]["lbravo_infil_bravo_loop_exit"] = % mp_infil_lbravo_a_guy3_loop_exit_wm;
      level.scr_animname["slot_2"]["lbravo_infil_bravo_loop_exit"] = "mp_infil_lbravo_a_guy3_loop_exit_wm";
      level.scr_eventanim["slot_2"]["lbravo_infil_bravo_loop_exit"] = "infil_lbravo_a_loop_exit_3";
      level.scr_animtree["slot_3"] = #animtree;
      level.scr_anim["slot_3"]["lbravo_infil_bravo"] = % mp_infil_lbravo_b_guy4_wm;
      level.scr_animname["slot_3"]["lbravo_infil_bravo"] = "mp_infil_lbravo_b_guy4_wm";
      level.scr_eventanim["slot_3"]["lbravo_infil_bravo"] = "infil_lbravo_b_4";
      level.scr_anim["slot_3"]["lbravo_infil_bravo_exit"] = % mp_infil_lbravo_b_guy4_exit_wm;
      level.scr_animname["slot_3"]["lbravo_infil_bravo_exit"] = "mp_infil_lbravo_b_guy4_exit_wm";
      level.scr_eventanim["slot_3"]["lbravo_infil_bravo_exit"] = "infil_lbravo_b_exit_4";
      level.scr_anim["slot_3"]["lbravo_infil_bravo_loop"] = % mp_infil_lbravo_a_guy4_loop_wm;
      level.scr_animname["slot_3"]["lbravo_infil_bravo_loop"] = "mp_infil_lbravo_a_guy4_loop_wm";
      level.scr_eventanim["slot_3"]["lbravo_infil_bravo_loop"] = "infil_lbravo_a_loop_4";
      level.scr_anim["slot_3"]["lbravo_infil_bravo_loop_exit"] = % mp_infil_lbravo_a_guy4_loop_exit_wm;
      level.scr_animname["slot_3"]["lbravo_infil_bravo_loop_exit"] = "mp_infil_lbravo_a_guy4_loop_exit_wm";
      level.scr_eventanim["slot_3"]["lbravo_infil_bravo_loop_exit"] = "infil_lbravo_a_loop_exit_4";
      level.scr_animtree["slot_4"] = #animtree;
      level.scr_anim["slot_4"]["lbravo_infil_bravo"] = % mp_infil_lbravo_b_guy5_wm;
      level.scr_animname["slot_4"]["lbravo_infil_bravo"] = "mp_infil_lbravo_b_guy5_wm";
      level.scr_eventanim["slot_4"]["lbravo_infil_bravo"] = "infil_lbravo_b_5";
      level.scr_anim["slot_4"]["lbravo_infil_bravo_exit"] = % mp_infil_lbravo_b_guy5_exit_wm;
      level.scr_animname["slot_4"]["lbravo_infil_bravo_exit"] = "mp_infil_lbravo_b_guy5_exit_wm";
      level.scr_eventanim["slot_4"]["lbravo_infil_bravo_exit"] = "infil_lbravo_b_exit_5";
      level.scr_anim["slot_4"]["lbravo_infil_bravo_loop"] = % mp_infil_lbravo_a_guy5_loop_wm;
      level.scr_animname["slot_4"]["lbravo_infil_bravo_loop"] = "mp_infil_lbravo_a_guy5_loop_wm";
      level.scr_eventanim["slot_4"]["lbravo_infil_bravo_loop"] = "infil_lbravo_a_loop_5";
      level.scr_anim["slot_4"]["lbravo_infil_bravo_loop_exit"] = % mp_infil_lbravo_a_guy5_loop_exit_wm;
      level.scr_animname["slot_4"]["lbravo_infil_bravo_loop_exit"] = "mp_infil_lbravo_a_guy5_loop_exit_wm";
      level.scr_eventanim["slot_4"]["lbravo_infil_bravo_loop_exit"] = "infil_lbravo_a_loop_exit_5";
      level.scr_animtree["slot_5"] = #animtree;
      level.scr_anim["slot_5"]["lbravo_infil_bravo"] = % mp_infil_lbravo_b_guy6_wm;
      level.scr_animname["slot_5"]["lbravo_infil_bravo"] = "mp_infil_lbravo_b_guy6_wm";
      level.scr_eventanim["slot_5"]["lbravo_infil_bravo"] = "infil_lbravo_b_6";
      level.scr_anim["slot_5"]["lbravo_infil_bravo_exit"] = % mp_infil_lbravo_b_guy6_exit_wm;
      level.scr_animname["slot_5"]["lbravo_infil_bravo_exit"] = "mp_infil_lbravo_b_guy6_exit_wm";
      level.scr_eventanim["slot_5"]["lbravo_infil_bravo_exit"] = "infil_lbravo_b_exit_6";
      level.scr_anim["slot_5"]["lbravo_infil_bravo_loop"] = % mp_infil_lbravo_a_guy6_loop_wm;
      level.scr_animname["slot_5"]["lbravo_infil_bravo_loop"] = "mp_infil_lbravo_a_guy6_loop_wm";
      level.scr_eventanim["slot_5"]["lbravo_infil_bravo_loop"] = "infil_lbravo_a_loop_6";
      level.scr_anim["slot_5"]["lbravo_infil_bravo_loop_exit"] = % mp_infil_lbravo_a_guy6_loop_exit_wm;
      level.scr_animname["slot_5"]["lbravo_infil_bravo_loop_exit"] = "mp_infil_lbravo_a_guy6_loop_exit_wm";
      level.scr_eventanim["slot_5"]["lbravo_infil_bravo_loop_exit"] = "infil_lbravo_a_loop_exit_6";
      break;
    default:
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

vehicles_alpha_anims(subtype, team, originalsubtype) {
  level.scr_anim["lbravo"]["lbravo_infil"] = % iw9_mp_infil_lbravo_heli;

  if(isDefined(originalsubtype) && subtype != originalsubtype && getDvar("g_mapname") == "mp_downtown_gw") {
    switch (originalsubtype) {
      case "alpha1":
        if(team == "axis")
          level.scr_anim["lbravo"]["lbravo_infil_" + originalsubtype + "_" + team] = % mp_infil_lbravo_a_heli_downtown_east;
        else
          level.scr_anim["lbravo"]["lbravo_infil_" + originalsubtype + "_" + team] = % mp_infil_lbravo_b2_heli_downtown_west;

        break;
      case "alpha2":
        if(team == "axis")
          level.scr_anim["lbravo"]["lbravo_infil_" + originalsubtype + "_" + team] = % mp_infil_lbravo_a_heli_downtown_east;
        else
          level.scr_anim["lbravo"]["lbravo_infil_" + originalsubtype + "_" + team] = % mp_infil_lbravo_b1_heli_downtown_west;

        break;
      case "bravo1":
        if(team == "axis")
          level.scr_anim["lbravo"]["lbravo_infil_" + originalsubtype + "_" + team] = % mp_infil_lbravo_b2_heli_downtown_east;
        else
          level.scr_anim["lbravo"]["lbravo_infil_" + originalsubtype + "_" + team] = % mp_infil_lbravo_b1_heli_downtown_west;

        break;
      case "bravo2":
        if(team == "axis")
          level.scr_anim["lbravo"]["lbravo_infil_" + originalsubtype + "_" + team] = % mp_infil_lbravo_b1_heli_downtown_east;
        else
          level.scr_anim["lbravo"]["lbravo_infil_" + originalsubtype + "_" + team] = % mp_infil_lbravo_b2_heli_downtown_west;

        break;
    }
  } else {
    switch (subtype) {
      case "alpha":
        level.scr_animtree["lbravo"] = #animtree;

        switch (getDvar("g_mapname")) {
          case "mp_farms2_gw":
            if(team == "axis")
              level.scr_anim["lbravo"]["lbravo_infil_alpha_" + team] = % mp_infil_lbravo_a_heli_farm_gw_east;
            else
              level.scr_anim["lbravo"]["lbravo_infil_alpha_" + team] = % mp_infil_lbravo_a_heli_farm_gw_west;

            break;
          case "mp_downtown_gw":
            if(team == "axis")
              level.scr_anim["lbravo"]["lbravo_infil_alpha_" + team] = % mp_infil_lbravo_a_heli_downtown_east;
            else
              level.scr_anim["lbravo"]["lbravo_infil_alpha_" + team] = % mp_infil_lbravo_a_heli_downtown_west;

            break;
          case "mp_quarry2":
            if(team == "axis")
              level.scr_anim["lbravo"]["lbravo_infil_alpha_" + team] = % mp_infil_lbravo_a_heli_quarry_east;
            else
              level.scr_anim["lbravo"]["lbravo_infil_alpha_" + team] = % mp_infil_lbravo_a_heli_quarry_west;

            break;
          case "mp_deadzone":
            if(team == "axis")
              level.scr_anim["lbravo"]["lbravo_infil_alpha_" + team] = % mp_infil_lbravo_a_heli_aniyah_gw_east;
            else
              level.scr_anim["lbravo"]["lbravo_infil_alpha_" + team] = % mp_infil_lbravo_a_heli_deadzone_west;

            break;
          case "mp_raid":
            level.scr_anim["lbravo"]["lbravo_infil_alpha_" + team] = % mp_infil_lbravo_a_heli_raid;
            break;
          case "mp_petrograd":
            level.scr_anim["lbravo"]["lbravo_infil_alpha_" + team] = % mp_infil_lbravo_a_heli_petrograd;
            break;
          case "mp_piccadilly":
            level.scr_anim["lbravo"]["lbravo_infil_alpha_" + team] = % mp_infil_lbravo_a_heli_piccadilly;
            break;
          case "mp_aniyah":
            if(team == "axis") {
              switch (level.gametype) {
                case "koth":
                case "hq":
                case "grnd":
                case "dd":
                case "sr":
                case "sd":
                case "cyber":
                  level.scr_anim["lbravo"]["lbravo_infil_alpha_" + team] = % mp_infil_lbravo_a_heli;
                  break;
                default:
                  level.scr_anim["lbravo"]["lbravo_infil_alpha_" + team] = % mp_infil_lbravo_a_heli_aniyah_gw_east;
                  break;
              }
            } else
              level.scr_anim["lbravo"]["lbravo_infil_alpha_" + team] = % mp_infil_lbravo_a_heli_aniyah_hq;

            break;
          case "mp_aniyah_tac":
            level.scr_anim["lbravo"]["lbravo_infil_alpha_" + team] = % mp_infil_lbravo_a_heli_aniyah_tactical;
            break;
          case "mp_emporium":
            if(team == "axis")
              level.scr_anim["lbravo"]["lbravo_infil_alpha_" + team] = % mp_infil_lbravo_a_heli_emporium_east;
            else
              level.scr_anim["lbravo"]["lbravo_infil_alpha_" + team] = % mp_infil_lbravo_a_heli_emporium_west;

            break;
          case "mp_backlot2":
          case "mp_village2":
            level.scr_anim["lbravo"]["lbravo_infil_alpha_" + team] = % mp_infil_lbravo_a_heli_backlot;
            break;
          case "mp_boneyard_gw":
            if(team == "allies" && originalsubtype == "alpha" || originalsubtype == "alpha2")
              level.scr_anim["lbravo"]["lbravo_infil_" + originalsubtype + "_" + team] = % mp_infil_lbravo_a_heli_petrograd;
            else
              level.scr_anim["lbravo"]["lbravo_infil_alpha_" + team] = % mp_infil_lbravo_a_heli;

            break;
          case "mp_promenade_gw":
            if(team == "axis" && originalsubtype == "alpha")
              level.scr_anim["lbravo"]["lbravo_infil_" + originalsubtype + "_" + team] = % mp_infil_lbravo_a_heli_aniyah_tactical;
            else
              level.scr_anim["lbravo"]["lbravo_infil_alpha_" + team] = % mp_infil_lbravo_a_heli;

            break;
          case "mp_oilrig":
            level.scr_anim["lbravo"]["lbravo_infil_alpha_" + team] = % mp_infil_lbravo_a_heli_oilrig_coalition;
            break;
          case "mp_garden":
            level.scr_anim["lbravo"]["lbravo_infil_alpha_" + team] = % mp_infil_lbravo_a_heli_garden;
            break;
          case "mp_harbor":
            level.scr_anim["lbravo"]["lbravo_infil_alpha_" + team] = % mp_infil_lbravo_a_heli_harbor;
            break;
          default:
            level.scr_anim["lbravo"]["lbravo_infil_alpha_" + team] = % mp_infil_lbravo_a_heli;
            break;
        }

        break;
      case "bravo":
        level.scr_animtree["lbravo"] = #animtree;

        switch (getDvar("g_mapname")) {
          case "mp_farms2_gw":
            if(team == "axis")
              level.scr_anim["lbravo"]["lbravo_infil_bravo_" + team] = % mp_infil_lbravo_b_heli_farm_gw_east;
            else
              level.scr_anim["lbravo"]["lbravo_infil_bravo_" + team] = % mp_infil_lbravo_b_heli_farm_gw_west;

            break;
          case "mp_downtown_gw":
            if(team == "axis")
              level.scr_anim["lbravo"]["lbravo_infil_bravo_" + team] = % mp_infil_lbravo_a_heli_downtown_east;
            else
              level.scr_anim["lbravo"]["lbravo_infil_bravo_" + team] = % mp_infil_lbravo_a_heli_downtown_west;

            break;
          case "mp_quarry2":
            if(team == "axis")
              level.scr_anim["lbravo"]["lbravo_infil_bravo_" + team] = % mp_infil_lbravo_b_heli_quarry_east;
            else
              level.scr_anim["lbravo"]["lbravo_infil_bravo_" + team] = % mp_infil_lbravo_b_heli_quarry_west;

            break;
          case "mp_deadzone":
            if(team == "axis")
              level.scr_anim["lbravo"]["lbravo_infil_bravo_" + team] = % mp_infil_lbravo_b_heli_aniyah_gw_east;
            else
              level.scr_anim["lbravo"]["lbravo_infil_bravo_" + team] = % mp_infil_lbravo_b_heli_deadzone_west;

            break;
          case "mp_runner":
          case "mp_runner_pm":
            level.scr_anim["lbravo"]["lbravo_infil_bravo_" + team] = % mp_infil_lbravo_b_heli_runner;
            break;
          case "mp_raid":
            level.scr_anim["lbravo"]["lbravo_infil_bravo_" + team] = % mp_infil_lbravo_b_heli_raid;
            break;
          case "mp_aniyah":
            if(team == "axis") {
              switch (level.gametype) {
                case "koth":
                case "hq":
                case "grnd":
                case "dd":
                case "sr":
                case "sd":
                case "cyber":
                  level.scr_anim["lbravo"]["lbravo_infil_bravo_" + team] = % mp_infil_lbravo_b_heli;
                  break;
                default:
                  level.scr_anim["lbravo"]["lbravo_infil_bravo_" + team] = % mp_infil_lbravo_b_heli_aniyah_gw_east;
                  break;
              }
            } else
              level.scr_anim["lbravo"]["lbravo_infil_bravo_" + team] = % mp_infil_lbravo_b_heli_aniyah_hq;

            break;
          case "mp_aniyah_tac":
            level.scr_anim["lbravo"]["lbravo_infil_bravo_" + team] = % mp_infil_lbravo_a_heli_aniyah_tactical;
            break;
          case "mp_oilrig":
            level.scr_anim["lbravo"]["lbravo_infil_bravo_" + team] = % mp_infil_lbravo_b_heli_oilrig_coalition;
            break;
          default:
            level.scr_anim["lbravo"]["lbravo_infil_bravo_" + team] = % mp_infil_lbravo_b_heli;
            break;
        }

        break;
      default:
        level.scr_anim["lbravo"]["lbravo_infil_bravo_" + team] = % mp_infil_lbravo_b_heli;
        break;
    }
  }
}

commander_play_sound_func(alias, _id_EA3E3B2121E6713A, _id_9A0AFE8FF3D2508F) {
  foreach(player in self.infil.players) {
    if(soundexists(alias))
      self playsoundtoplayer(alias, player);
  }
}

vehiclethinkpath(team, scene_node, _id_CA85A0DE365C6A63, _id_16E334D22D37BE73) {
  scripts\mp\flags::gameflagwait("infil_started");
  self.linktoent setscriptablepartstate("engine", "on", 0);
  self.linktoent.unload_hover_offset = 116;
  self.linktoent.unload_time = 3.5;
  self.linktoent thread scripts\mp\infilexfil\infilexfil::vehicle_paths_helicopter(self.path);
  thread scripts\mp\infilexfil\infilexfil::heli_path(self.linktoent);
  self.linktoent waittill("reached_dynamic_path_end");
  self.linktoent delete();
  self.linktoent = undefined;
}

heli_interior_sfx(_id_CA85A0DE365C6A63) {
  scripts\mp\flags::gameflagwait("infil_started");

  if(_id_CA85A0DE365C6A63 == "alpha") {
    if(soundexists("scn_infil_lbravo_heli1_lr")) {
      self.linktoent playsoundonmovingent("scn_infil_lbravo_heli1_lr");
      self.linktoent playsoundonmovingent("scn_infil_lbravo_heli1_feet");
    }
  } else if(soundexists("scn_infil_lbravo_heli1_lr")) {
    self.linktoent playsoundonmovingent("scn_infil_lbravo_heli2_lr");
    self.linktoent playsoundonmovingent("scn_infil_lbravo_heli2_feet");
  }

  level waittill("prematch_over");
}

giveinteractiveinfilweapon() {
  weapon = makeweapon("iw8_sn_alpha50_mp", ["rec_alpha50", "front_alpha50", "back_alpha50", "mag_alpha50", "acog_alpha50_light", "mod_infil_alpha50"]);
  scripts\cp_mp\utility\inventory_utility::_giveweapon(weapon, undefined, undefined, 1);
  _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("infil_weapon");
  success = scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(weapon, 0);

  if(success) {
    self.infilweapon = weapon;
    _id_3B64EB40368C1450::set("infil_weapon", "weapon_switch", 0);
    scripts\mp\utility\weapon::setrecoilscale(0.0, 50);
  } else {
    scripts\cp_mp\utility\inventory_utility::_takeweapon(weapon);
    scripts\cp_mp\utility\inventory_utility::forcevalidweapon();
  }

  return success;
}

allowinteractivecombat(_id_5D0716264ABD2B2D) {
  self endon("death_or_disconnect");
  self endon("player_free_spot");
  self endon("joined_team");
  thread interactivecombatmessaging();
  wait(level.interactiveinfilstart);
  self.interactivecombat = 1;
  _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("interactive_combat");
  self setdemeanorviewmodel("normal");
  self lerpfovbypreset("default_2seconds");
  self.infil waittill("event_shootingWindow_closed");
  self.interactivecombat = 0;
  _id_3B64EB40368C1450::set("interactive_combat", "fire", 0);
  _id_3B64EB40368C1450::set("interactive_combat", "ads", 0);
  _id_3B64EB40368C1450::set("interactive_combat", "reload", 0);
  scripts\mp\utility\weapon::setrecoilscale();
  self setdemeanorviewmodel("safe", "iw8_ges_demeanor_safe_heli");
}

interactivecombatmessaging() {
  self endon("death_or_disconnect");
  self endon("player_free_spot");
  self endon("joined_team");
  self.infil waittill("event_intro");
  self iprintlnbold("Enemies spotted! LZ is hot!");
  wait 3.25;
  line = getinteractiveinfilline(self.animname, level.mapname);
  self iprintlnbold(line);
  self.infil waittill("event_shootingWindow_open");
  self iprintlnbold("Targets Marked! Take them out!");
}

getinteractiveinfilline(slot, _id_0D4C90180F6E4B32) {
  switch (_id_0D4C90180F6E4B32) {
    case "mp_raid":
    case "mp_deadzone":
    case "mp_euphrates":
      if(slot == "slot_0" || slot == "slot_1")
        return "On the Rooftop! I'm swinging around for a shot!";
    case "mp_runner":
      if(slot == "slot_0" || slot == "slot_1")
        return "On the Rooftop! Dead Ahead!";

      if(slot == "slot_3" || slot == "slot_5")
        return "In the pit! On the right!";
  }

  wait 1.25;
  self iprintlnbold("Targets Marked! Take them out!");
}

interactiveinfilthink(team) {
  level thread manageinteractivecombattargets(team);
}

manageinteractivecombattargets(team) {
  while(!isDefined(level.infiltargets))
    waitframe();

  foreach(target in level.infiltargets["allies"]) {
    target thread targetdamagethink(team);
    target thread deleteoninfilcomplete();
  }
}

targetdamagethink(team) {
  level endon("prematch_over");

  if(istrue(self.isbonus))
    self.health = 220;
  else
    self.health = 100;

  wait(level.interactiveinfilstart);
  outlineid = scripts\mp\utility\outline::outlineenableforteam(self, team, scripts\engine\utility::ter_op(istrue(self.isbonus), "outline_depth_red", "outline_depth_orange"), "level_script");

  for(;;) {
    self waittill("damage", damage, attacker, direction_vec, point, type, modelname, tagname, partname, idflags, weapon);

    if(damage >= self.health) {
      scripts\mp\utility\outline::outlinedisable(outlineid, self);

      if(istrue(self.isbonus)) {
        attacker thread scripts\mp\rank::giverankxp("stat_5B683EC651FDDD19", 1000);
        attacker thread scripts\mp\rank::scoreeventpopup("stat_5B683EC651FDDD19");
      }

      break;
    }
  }
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

customground(guy) {
  scripts\mp\utility\infilexfil::cam_shake_off(guy);

  if(!isDefined(guy)) {
    return;
  }
  if(isDefined(guy.player))
    player = guy.player;
  else
    player = guy;
}