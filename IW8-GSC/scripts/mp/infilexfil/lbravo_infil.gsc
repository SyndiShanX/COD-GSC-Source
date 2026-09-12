/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\infilexfil\lbravo_infil.gsc
**************************************************/

function lbravo_init(var_0) {
  var_1 = [];
  GscBinSkip0(0x2e, 0, [0, 1]);
}

function lbravo_spawn(var_0, var_1, var_2, var_3) {
  initanims(var_2, var_0, var_3);
  var_4 = scripts\engine\utility::getStruct(var_1, "targetname");
  ref_12802(var_4, var_0, var_2, var_3);
  var_5 = spawn("script_origin", var_4.origin);

  if(!isDefined(var_4.angles)) {
    var_4.angles = (0, 0, 0);
  }

  var_5.angles = var_4.angles;
  var_5.scene_node = var_4;
  var_5.subtype = var_2;
  var_5.ref_1214c = var_3;
  thread infilthink(var_5, var_0);

  if(scripts\mp\utility\game::getgametype() == "arm" && isDefined(var_4.target)) {
    level.teamdata[var_0]["captureLocation_Next"] = var_4.target;
  }

  return var_5;
}

function ref_12896(var_0, var_1, var_2) {
  var_3 = var_0.scene_node.origin;
  var_4 = var_0.scene_node.angles;

  for(;;) {
    thread scripts\cp_mp\utility\debug_utility::drawangles(var_3, var_4, level.framedurationseconds, 1);
    waitframe();
  }
}

function ref_12802(var_0, var_1, var_2, var_3) {
  var_4 = scripts\cp_mp\utility\game_utility::getmapname();

  switch (var_4) {
    case "mp_quarry2":
      switch (var_3) {
        case "alpha2":
          if(var_1 == "allies") {
            var_0.origin += anglesToForward(var_0.angles) * 100;
          }

          break;
        case "bravo2":
          if(var_1 == "allies") {
            var_0.origin += anglesToForward(var_0.angles) * -50;
            var_0.origin += anglestoright(var_0.angles) * -10;
          }

          break;
      }

      break;
    case "mp_aniyah":
      if(var_1 == "axis" && var_2 == "bravo") {
        var_0.origin = (8296.4, 786.17, 286);
        var_0.angles = (0, 210, 0);
      }

      if(var_1 == "allies") {
        switch (level.gametype) {
          case "koth":
          case "hq":
          case "grnd":
          case "dd":
          case "cyber":
          case "sd":
          case "sr":
            var_0.angles = (var_0.angles[0], 344, var_0.angles[2]);
            break;
        }
      }

      break;
  }
}

function lbravo_get_length(var_0) {
  if(issubstr(var_0, "alpha")) {
    var_0 = "alpha";
  }

  if(issubstr(var_0, "bravo")) {
    var_0 = "bravo";
  }

  if(isDefined(self.path)) {
    var_1 = scripts\mp\infilexfil\infilexfil::parsehelipathlength();
    var_1 += getanimlength(level.scr_anim["slot_0"]["lbravo_infil_" + var_0 + "_loop_exit"]);
    var_1 += getanimlength(level.scr_anim["slot_0"]["lbravo_infil_" + var_0 + "_exit"]);
    return var_1;
  }

  var_2 = getanimlength(level.scr_anim["slot_0"]["lbravo_infil_" + var_1]);
  var_2 += getanimlength(level.scr_anim["slot_0"]["lbravo_infil_" + var_1 + "_exit"]);
  return var_2;
}

function player_lbravo_infil_think(var_0, var_1) {
  self endon("death_or_disconnect");
  self endon("player_free_spot");
  self endon("joined_team");

  if(isPlayer(self)) {
    self setclienttriggeraudiozone("lbravo_infil_intro", 1);
  }

  thread lbravo_infil_radio_idle();
  thread player_infil_end(var_0);
  var_2 = var_0.linktoent gettagorigin("origin_animate_jnt");
  var_3 = var_0.linktoent gettagangles("origin_animate_jnt");
  thread scripts\mp\utility\infilexfil::infil_player_rig_updated("slot_" + var_1, var_2, var_3);
  self.player_rig linkTo(var_0.linktoent, "origin_animate_jnt", (0, 0, 0), (0, 0, 0));
  self lerpfovbypreset("80_instant");
  self lerpfovscalefactor(0, 0);
  self.manualoverridewindmaterial = 1;
  self setscriptablepartstate("wind", "100", 0);
  var_4 = var_1 == 0 || var_1 == 1;

  if(istrue(level.interactiveinfil) && !isai(self) && var_4) {
    giveinteractiveinfilweapon();
  } else {
    self setdemeanorviewmodel("safe", "iw8_ges_demeanor_safe_heli");
  }

  thread scripts\mp\infilexfil\infilexfil::infil_scene_fade_in(0, 0.55);
  thread player_van_disconnect();
  thread cinematiccameratimeline(var_0);
  scripts\mp\flags::gameflagwait("infil_started");

  if(scripts\cp_mp\utility\game_utility::isnightmap()) {
    self nightvisionviewon();
  }

  if(isDefined(self.team) && self.team != "spectator") {
    var_5 = [];
    GscBinSkip0(0x2e, var_5.size, "mp_infil_mix_musicheavy");
  }

  if(isDefined(self.animname) && isPlayer(self)) {
    var_9 = "scn_infil_lbravo_heli_plr1";

    if(isDefined(var_1.subtype)) {
      if(var_1.subtype == "alpha") {
        switch (self.animname) {
          case "slot_0":
            var_9 = "scn_infil_lbravo_heli_plr1";
            break;
          case "slot_1":
            var_9 = "scn_infil_lbravo_heli_plr2";
            break;
          case "slot_2":
            var_9 = "scn_infil_lbravo_heli_plr3";
            break;
          case "slot_3":
            var_9 = "scn_infil_lbravo_heli_plr4";
            break;
          case "slot_4":
            var_9 = "scn_infil_lbravo_heli_plr5";
            break;
          case "slot_5":
            var_9 = "scn_infil_lbravo_heli_plr6";
            break;
          default:
            var_9 = "scn_infil_lbravo_heli_plr1";
            break;
        }
      } else {
        switch (self.animname) {
          case "slot_0":
            var_9 = "scn_infil_lbravo_bravo_heli_plr1";
            break;
          case "slot_1":
            var_9 = "scn_infil_lbravo_bravo_heli_plr2";
            break;
          case "slot_2":
            var_9 = "scn_infil_lbravo_bravo_heli_plr3";
            break;
          case "slot_3":
            var_9 = "scn_infil_lbravo_bravo_heli_plr4";
            break;
          case "slot_4":
            var_9 = "scn_infil_lbravo_bravo_heli_plr5";
            break;
          case "slot_5":
            var_9 = "scn_infil_lbravo_bravo_heli_plr6";
            break;
          default:
            var_9 = "scn_infil_lbravo_bravo_heli_plr1";
            break;
        }
      }
    }

    self setclienttriggeraudiozone("lbravo_infil", 2);
    self playlocalsound(var_9);
  }

  self setcinematicmotionoverride("player_heli_ride");

  if(istrue(level.interactiveinfil) && !isai(self) && var_5) {
    thread allowinteractivecombat();
  }

  if(isDefined(var_1.path)) {
    thread playerthinkpath(var_1, var_2);
  } else {
    thread playerthinkanim(var_1, var_2);
  }

  level waittill("prematch_over");
  self setcinematicmotionoverride("iw8_playermotion_mp");
  self setscriptablepartstate("wind", "0", 0);
  self.manualoverridewindmaterial = 0;
}

function playerthinkpath(var_0, var_1) {
  self endon("death_or_disconnect");
  self endon("player_free_spot");
  self endon("joined_team");

  if(var_1 == 0) {
    self lerpviewangleclamp(1, 0.25, 0.25, 10, 45, 45, 45);
  } else if(var_1 == 1) {
    self lerpviewangleclamp(1, 0.25, 0.25, 45, 10, 45, 45);
  } else {
    self lerpviewangleclamp(1, 0.25, 0.25, 45, 45, 45, 45);
  }

  rideloop(var_0);
  self lerpviewangleclamp(1, 0.25, 0.25, 0, 0, 0, 0);
  self lerpfovbypreset("default_2seconds");
  self lerpfovscalefactor(1, 2);
  self stopanimscriptsceneevent();
  var_0.linktoent scripts\mp\anim::anim_player_solo(self, self.player_rig, "lbravo_infil_" + var_0.subtype + "_loop_exit", "origin_animate_jnt");
  self setcinematicmotionoverride("iw8_playermotion_mp");
  self.player_rig unlink();
  var_0 scripts\mp\anim::anim_player_solo(self, self.player_rig, "lbravo_infil_" + var_0.subtype + "_exit");
}

function rideloop(var_0) {
  self endon("death_or_disconnect");
  self endon("player_free_spot");
  self endon("joined_team");
  var_0.linktoent endon("unload");

  for(;;) {
    var_0.linktoent scripts\mp\anim::anim_player_solo(self, self.player_rig, "lbravo_infil_" + var_0.subtype + "_loop", "origin_animate_jnt");
  }
}

function playerthinkanim(var_0, var_1) {
  self endon("death_or_disconnect");
  self endon("player_free_spot");
  self endon("joined_team");
  var_2 = var_0.subtype;

  if(getDvar("mapname") == "mp_downtown_gw") {
    if(self.team == "allies" && (var_0.ref_1214c == "alpha1" || var_0.ref_1214c == "alpha2")) {
      var_2 = "bravo";
    }

    if(self.team == "axis" && var_0.ref_1214c == "bravo") {
      var_2 = "alpha";
    }
  }

  if(var_1 == 0) {
    self lerpviewangleclamp(1, 0.25, 0.25, 10, 45, 45, 45);
  } else if(var_1 == 1) {
    self lerpviewangleclamp(1, 0.25, 0.25, 45, 10, 45, 45);
  } else {
    self lerpviewangleclamp(1, 0.25, 0.25, 45, 45, 45, 45);
  }

  var_0.linktoent scripts\mp\anim::anim_player_solo(self, self.player_rig, "lbravo_infil_" + var_2, "origin_animate_jnt");

  if(self islinked()) {
    self lerpviewangleclamp(1, 0.25, 0.25, 0, 0, 0, 0);
  }

  self.player_rig unlink();
  self lerpfovscalefactor(1, 2);
  var_0 scripts\mp\anim::anim_player_solo(self, self.player_rig, "lbravo_infil_" + var_2 + "_exit");
  thread scriptswitchweaponhack();
  thread clear_infil_ambient_zone();
  self visionsetnakedforplayer("", 0.75);
  self setdemeanorviewmodel("normal");
}

function scriptswitchweaponhack() {
  waitframe();
  self notify("complete_late_infil_allows");
}

function clear_infil_ambient_zone() {
  wait 1;
  self clearallsoundsubmixes();
  self clearclienttriggeraudiozone(2);
}

function lbravo_infil_radio_idle() {
  if(isPlayer(self)) {
    var_0 = spawn("script_origin", (0, 0, 0));
    var_0 showonlytoplayer(self);

    if(isDefined(self.team)) {
      var_1 = scripts\mp\utility\teams::getteamvoiceinfix(self.team);
      var_2 = "dx_mpo_" + var_1 + "op_drone_deathchatter";
    } else {
      var_2 = "dx_mpo_usop_drone_deathchatter";
    }

    if(soundexists(var_2)) {
      var_2 playLoopSound(var_2);
    } else {
      var_2 playLoopSound("dx_mpo_usop_drone_deathchatter");
    }

    scripts\mp\flags::gameflagwait("infil_started");
    wait 2;
    var_2 stoploopsound(var_2);
    var_2 delete();
    return;
  }
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

function infilthink(var_0, var_1) {
  var_2 = getdvarfloat("r_mbVelocityScale", 0.2);

  foreach(var_4 in getEntArray("infil_delete", "script_noteworthy")) {
    var_4 delete();
  }

  if(issubstr(var_1, "alpha")) {
    var_1 = "alpha";
  }

  if(issubstr(var_1, "bravo")) {
    var_1 = "bravo";
  }

  thread vehiclethink(var_0, self.scene_node, var_1);
  thread actorthink(var_0, self.scene_node, var_1);
  scripts\mp\flags::gameflagwait("infil_started");
  setDvar("r_spotLightEntityShadows", 1);
  setDvar("r_mbVelocityScale", 1);
  level notify("start_scene");
  self notify("start_scene");

  if(istrue(level.interactiveinfil)) {
    thread interactiveinfilthink(level);
  }

  scripts\engine\utility::waittill_any_ents(level, "prematch_over", self, "prematch_over");
  setDvar("r_spotLightEntityShadows", 0);
  setDvar("r_mbVelocityScale", var_2);

  while(isDefined(self.linktoent) || isDefined(self.actors)) {
    waitframe();
  }

  level.stop_station_closed_vo--;
  self delete();
}

function vehiclethink(var_0, var_1, var_2, var_3) {
  self.linktoent = spawninfilvehicle(var_1, var_0, var_2);

  if(isDefined(self.path)) {
    thread vehiclethinkpath(var_0, var_1, var_2, var_3);
  } else {
    thread vehiclethinkanim(var_0, var_1, var_2, var_3);
  }

  thread heli_interior_sfx(var_2);
  level waittill("prematch_over");
  wait 3;
  self.linktoent solid();
}

function vehiclethinkanim(var_0, var_1, var_2, var_3) {
  if(self.ref_1214c != self.subtype && getDvar("mapname") == "mp_downtown_gw") {
    var_2 = self.ref_1214c;
  }

  if(var_0 == "allies" && (self.ref_1214c == "alpha" || self.ref_1214c == "alpha2") && getDvar("mapname") == "mp_boneyard_gw") {
    var_2 = self.ref_1214c;
  }

  scripts\common\anim::anim_first_frame_solo(self.linktoent, "lbravo_infil_" + var_2 + "_" + var_0);
  scripts\mp\flags::gameflagwait("infil_started");
  self.linktoent setscriptablepartstate("engine", "on", 0);
  self.linktoent setscriptablepartstate("infil_lights", "on", 0);
  thread scripts\common\anim::anim_single_solo(self.linktoent, "lbravo_infil_" + var_2 + "_" + var_0);
  var_4 = getanimlength(level.scr_anim[self.linktoent.animname]["lbravo_infil_" + var_2 + "_" + var_0]);
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

  if(var_1 == "allies") {
    var_5 = "veh8_mil_air_lbravo_personnel";
  } else {
    var_5 = "veh8_mil_air_lbravo_personnel_east";
  }

  var_6 = spawnVehicle(var_5, var_3, "lbravo_infil_mp", var_4, var_5);
  var_6 setvehicleteam(var_2);
  var_6.animname = "lbravo";
  var_6 setCanDamage(0);
  var_6 notsolid();
  var_6.infil = self;
  var_7 = getEnt("lbravo_clip", "targetname");

  if(isDefined(var_7)) {
    var_8 = spawn("script_model", var_6.origin);
    var_8.angles = var_6.angles;
    var_8 clonebrushmodeltoscriptmodel(var_7);
    var_8 linkTo(var_6);
  }

  return var_6;
}

function actorthink(var_0, var_1, var_2, var_3) {
  self.actors = thread spawnactors(var_0, var_2, var_3);
  self.actors[0].anim_playsound_func = &commander_play_sound_func;
  self.linktoent scripts\common\anim::anim_first_frame(self.actors, "lbravo_infil_" + var_2, "origin_animate_jnt");
  scripts\mp\utility\infilexfil::hideactors();
  scripts\mp\flags::gameflagwait("infil_started");
  scripts\mp\utility\infilexfil::showactors();

  if(isDefined(self.path)) {
    actorthinkpath(var_0, var_1, var_2, var_3);
    return;
  }

  actorthinkanim(var_0, var_1, var_2, var_3);
}

function actorthinkpath(var_0, var_1, var_2, var_3) {
  thread actorloopthink(self.actors[0]);
  thread actorloopthink(self.actors[1]);
}

function actorloopthink(var_0) {
  actorloop(var_0);
}

function actorloop(var_0) {
  var_0 endon("death");
  self.linktoent endon("reached_dynamic_path_end");

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
  GscBinSkip0(0x2e, var_3.size, spawn_anim_model(self.linktoent, "pilot", "origin_animate_jnt", "body_pilot_helicopter_british", "head_pilot_helicopter_british"));
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

function initanims(var_0, var_1, var_2) {
  script_model_alpha_anims(var_0);
  vehicles_alpha_anims(var_0, var_1, var_2);
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
  scripts\common\anim::addnotetrack_customfunction("slot_0", "80_instant", &scripts\mp\utility\infilexfil::player_fov_80_instant, "lbravo_infil_alpha");
  scripts\common\anim::addnotetrack_customfunction("slot_1", "80_instant", &scripts\mp\utility\infilexfil::player_fov_80_instant, "lbravo_infil_alpha");
  scripts\common\anim::addnotetrack_customfunction("slot_2", "80_instant", &scripts\mp\utility\infilexfil::player_fov_80_instant, "lbravo_infil_alpha");
  scripts\common\anim::addnotetrack_customfunction("slot_3", "80_instant", &scripts\mp\utility\infilexfil::player_fov_80_instant, "lbravo_infil_alpha");
  scripts\common\anim::addnotetrack_customfunction("slot_4", "80_instant", &scripts\mp\utility\infilexfil::player_fov_80_instant, "lbravo_infil_alpha");
  scripts\common\anim::addnotetrack_customfunction("slot_5", "80_instant", &scripts\mp\utility\infilexfil::player_fov_80_instant, "lbravo_infil_alpha");
  scripts\common\anim::addnotetrack_customfunction("slot_0", "80_instant", &scripts\mp\utility\infilexfil::player_fov_80_instant, "lbravo_infil_bravo");
  scripts\common\anim::addnotetrack_customfunction("slot_1", "80_instant", &scripts\mp\utility\infilexfil::player_fov_80_instant, "lbravo_infil_bravo");
  scripts\common\anim::addnotetrack_customfunction("slot_2", "80_instant", &scripts\mp\utility\infilexfil::player_fov_80_instant, "lbravo_infil_bravo");
  scripts\common\anim::addnotetrack_customfunction("slot_3", "80_instant", &scripts\mp\utility\infilexfil::player_fov_80_instant, "lbravo_infil_bravo");
  scripts\common\anim::addnotetrack_customfunction("slot_4", "80_instant", &scripts\mp\utility\infilexfil::player_fov_80_instant, "lbravo_infil_bravo");
  scripts\common\anim::addnotetrack_customfunction("slot_5", "80_instant", &scripts\mp\utility\infilexfil::player_fov_80_instant, "lbravo_infil_bravo");
  scripts\common\anim::addnotetrack_customfunction("slot_0", "fov_63_2", &scripts\mp\utility\infilexfil::ref_12497, "lbravo_infil_alpha");
  scripts\common\anim::addnotetrack_customfunction("slot_1", "fov_63_2", &scripts\mp\utility\infilexfil::ref_12497, "lbravo_infil_alpha");
  scripts\common\anim::addnotetrack_customfunction("slot_2", "fov_63_2", &scripts\mp\utility\infilexfil::ref_12497, "lbravo_infil_alpha");
  scripts\common\anim::addnotetrack_customfunction("slot_3", "fov_63_2", &scripts\mp\utility\infilexfil::ref_12497, "lbravo_infil_alpha");
  scripts\common\anim::addnotetrack_customfunction("slot_4", "fov_63_2", &scripts\mp\utility\infilexfil::ref_12497, "lbravo_infil_alpha");
  scripts\common\anim::addnotetrack_customfunction("slot_5", "fov_63_2", &scripts\mp\utility\infilexfil::ref_12497, "lbravo_infil_alpha");
  scripts\common\anim::addnotetrack_customfunction("slot_0", "fov_63_2", &scripts\mp\utility\infilexfil::ref_12497, "lbravo_infil_bravo");
  scripts\common\anim::addnotetrack_customfunction("slot_1", "fov_63_2", &scripts\mp\utility\infilexfil::ref_12497, "lbravo_infil_bravo");
  scripts\common\anim::addnotetrack_customfunction("slot_2", "fov_63_2", &scripts\mp\utility\infilexfil::ref_12497, "lbravo_infil_bravo");
  scripts\common\anim::addnotetrack_customfunction("slot_3", "fov_63_2", &scripts\mp\utility\infilexfil::ref_12497, "lbravo_infil_bravo");
  scripts\common\anim::addnotetrack_customfunction("slot_4", "fov_63_2", &scripts\mp\utility\infilexfil::ref_12497, "lbravo_infil_bravo");
  scripts\common\anim::addnotetrack_customfunction("slot_5", "fov_63_2", &scripts\mp\utility\infilexfil::ref_12497, "lbravo_infil_bravo");
  scripts\common\anim::addnotetrack_customfunction("slot_0", "shake_on", &scripts\mp\utility\infilexfil::rumble_low, "lbravo_infil_alpha");
  scripts\common\anim::addnotetrack_customfunction("slot_1", "shake_on", &scripts\mp\utility\infilexfil::rumble_low, "lbravo_infil_alpha");
  scripts\common\anim::addnotetrack_customfunction("slot_2", "shake_on", &scripts\mp\utility\infilexfil::rumble_low, "lbravo_infil_alpha");
  scripts\common\anim::addnotetrack_customfunction("slot_3", "shake_on", &scripts\mp\utility\infilexfil::rumble_low, "lbravo_infil_alpha");
  scripts\common\anim::addnotetrack_customfunction("slot_4", "shake_on", &scripts\mp\utility\infilexfil::rumble_low, "lbravo_infil_alpha");
  scripts\common\anim::addnotetrack_customfunction("slot_5", "shake_on", &scripts\mp\utility\infilexfil::rumble_low, "lbravo_infil_alpha");
  scripts\common\anim::addnotetrack_customfunction("slot_0", "shake_on", &scripts\mp\utility\infilexfil::rumble_low, "lbravo_infil_bravo");
  scripts\common\anim::addnotetrack_customfunction("slot_1", "shake_on", &scripts\mp\utility\infilexfil::rumble_low, "lbravo_infil_bravo");
  scripts\common\anim::addnotetrack_customfunction("slot_2", "shake_on", &scripts\mp\utility\infilexfil::rumble_low, "lbravo_infil_bravo");
  scripts\common\anim::addnotetrack_customfunction("slot_3", "shake_on", &scripts\mp\utility\infilexfil::rumble_low, "lbravo_infil_bravo");
  scripts\common\anim::addnotetrack_customfunction("slot_4", "shake_on", &scripts\mp\utility\infilexfil::rumble_low, "lbravo_infil_bravo");
  scripts\common\anim::addnotetrack_customfunction("slot_5", "shake_on", &scripts\mp\utility\infilexfil::rumble_low, "lbravo_infil_bravo");
  scripts\common\anim::addnotetrack_customfunction("slot_0", "shake_off", &customground, "lbravo_infil_alpha_exit");
  scripts\common\anim::addnotetrack_customfunction("slot_1", "shake_off", &customground, "lbravo_infil_alpha_exit");
  scripts\common\anim::addnotetrack_customfunction("slot_2", "shake_off", &customground, "lbravo_infil_alpha_exit");
  scripts\common\anim::addnotetrack_customfunction("slot_3", "shake_off", &customground, "lbravo_infil_alpha_exit");
  scripts\common\anim::addnotetrack_customfunction("slot_4", "shake_off", &customground, "lbravo_infil_alpha_exit");
  scripts\common\anim::addnotetrack_customfunction("slot_5", "shake_off", &customground, "lbravo_infil_alpha_exit");
  scripts\common\anim::addnotetrack_customfunction("slot_0", "shake_off", &customground, "lbravo_infil_bravo_exit");
  scripts\common\anim::addnotetrack_customfunction("slot_1", "shake_off", &customground, "lbravo_infil_bravo_exit");
  scripts\common\anim::addnotetrack_customfunction("slot_2", "shake_off", &customground, "lbravo_infil_bravo_exit");
  scripts\common\anim::addnotetrack_customfunction("slot_3", "shake_off", &customground, "lbravo_infil_bravo_exit");
  scripts\common\anim::addnotetrack_customfunction("slot_4", "shake_off", &customground, "lbravo_infil_bravo_exit");
  scripts\common\anim::addnotetrack_customfunction("slot_5", "shake_off", &customground, "lbravo_infil_bravo_exit");
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

function vehicles_alpha_anims(var_0, var_1, var_2) {
  if(isDefined(var_2) && var_0 != var_2 && getDvar("mapname") == "mp_downtown_gw") {
    switch (var_2) {
      case "alpha1":
        if(var_1 == "axis") {
          level.scr_anim["lbravo"]["lbravo_infil_" + var_2 + "_" + var_1] = % mp_infil_lbravo_a_heli_downtown_east;
        } else {
          level.scr_anim["lbravo"]["lbravo_infil_" + var_2 + "_" + var_1] = $mp_infil_lbravo_b2_heli_downtown_west;
        }

        break;
      case "alpha2":
        if(var_1 == "axis") {
          level.scr_anim["lbravo"]["lbravo_infil_" + var_2 + "_" + var_1] = % mp_infil_lbravo_a_heli_downtown_east;
        } else {
          level.scr_anim["lbravo"]["lbravo_infil_" + var_2 + "_" + var_1] = % mp_infil_lbravo_b1_heli_downtown_west;
        }

        break;
      case "bravo1":
        if(var_1 == "axis") {
          level.scr_anim["lbravo"]["lbravo_infil_" + var_2 + "_" + var_1] = % mp_infil_lbravo_b2_heli_downtown_east;
        } else {
          level.scr_anim["lbravo"]["lbravo_infil_" + var_2 + "_" + var_1] = % mp_infil_lbravo_b1_heli_downtown_west;
        }

        break;
      case "bravo2":
        if(var_1 == "axis") {
          level.scr_anim["lbravo"]["lbravo_infil_" + var_2 + "_" + var_1] = % mp_infil_lbravo_b1_heli_downtown_east;
        } else {
          level.scr_anim["lbravo"]["lbravo_infil_" + var_2 + "_" + var_1] = % mp_infil_lbravo_b2_heli_downtown_west;
        }

        break;
    }

    return;
  }

  switch (var_0) {
    case "alpha":
      level.scr_animtree["lbravo"] = #animtree;

      switch (getDvar("mapname")) {
        case "mp_farms2_gw":
          if(var_1 == "axis") {
            level.scr_anim["lbravo"]["lbravo_infil_alpha_" + var_1] = % mp_infil_lbravo_a_heli_farm_gw_east;
          } else {
            level.scr_anim["lbravo"]["lbravo_infil_alpha_" + var_1] = % mp_infil_lbravo_a_heli_farm_gw_west;
          }

          break;
        case "mp_downtown_gw":
          if(var_1 == "axis") {
            level.scr_anim["lbravo"]["lbravo_infil_alpha_" + var_1] = % mp_infil_lbravo_a_heli_downtown_east;
          } else {
            level.scr_anim["lbravo"]["lbravo_infil_alpha_" + var_1] = % mp_infil_lbravo_a_heli_downtown_west;
          }

          break;
        case "mp_quarry2":
          if(var_1 == "axis") {
            level.scr_anim["lbravo"]["lbravo_infil_alpha_" + var_1] = % mp_infil_lbravo_a_heli_quarry_east;
          } else {
            level.scr_anim["lbravo"]["lbravo_infil_alpha_" + var_1] = % mp_infil_lbravo_a_heli_quarry_west;
          }

          break;
        case "mp_deadzone":
          if(var_1 == "axis") {
            level.scr_anim["lbravo"]["lbravo_infil_alpha_" + var_1] = % mp_infil_lbravo_a_heli_aniyah_gw_east;
          } else {
            level.scr_anim["lbravo"]["lbravo_infil_alpha_" + var_1] = % mp_infil_lbravo_a_heli_deadzone_west;
          }

          break;
        case "mp_raid":
          level.scr_anim["lbravo"]["lbravo_infil_alpha_" + var_1] = % mp_infil_lbravo_a_heli_raid;
          break;
        case "mp_petrograd":
          level.scr_anim["lbravo"]["lbravo_infil_alpha_" + var_1] = % mp_infil_lbravo_a_heli_petrograd;
          break;
        case "mp_piccadilly":
          level.scr_anim["lbravo"]["lbravo_infil_alpha_" + var_1] = % mp_infil_lbravo_a_heli_piccadilly;
          break;
        case "mp_aniyah":
          if(var_1 == "axis") {
            switch (level.gametype) {
              case "koth":
              case "hq":
              case "grnd":
              case "dd":
              case "cyber":
              case "sd":
              case "sr":
                level.scr_anim["lbravo"]["lbravo_infil_alpha_" + var_1] = % mp_infil_lbravo_a_heli;
                break;
              default:
                level.scr_anim["lbravo"]["lbravo_infil_alpha_" + var_1] = % mp_infil_lbravo_a_heli_aniyah_gw_east;
                break;
            }
          } else {
            level.scr_anim["lbravo"]["lbravo_infil_alpha_" + var_1] = % mp_infil_lbravo_a_heli_aniyah_hq;
          }

          break;
        case "mp_aniyah_tac":
          level.scr_anim["lbravo"]["lbravo_infil_alpha_" + var_1] = % mp_infil_lbravo_a_heli_aniyah_tactical;
          break;
        case "mp_emporium":
          if(var_1 == "axis") {
            level.scr_anim["lbravo"]["lbravo_infil_alpha_" + var_1] = % mp_infil_lbravo_a_heli_emporium_east;
          } else {
            level.scr_anim["lbravo"]["lbravo_infil_alpha_" + var_1] = % mp_infil_lbravo_a_heli_emporium_west;
          }

          break;
        case "mp_backlot2":
        case "mp_village2":
          level.scr_anim["lbravo"]["lbravo_infil_alpha_" + var_1] = % mp_infil_lbravo_a_heli_backlot;
          break;
        case "mp_boneyard_gw":
          if(var_1 == "allies" && var_2 == "alpha" || var_2 == "alpha2") {
            level.scr_anim["lbravo"]["lbravo_infil_" + var_2 + "_" + var_1] = % mp_infil_lbravo_a_heli_petrograd;
          } else {
            level.scr_anim["lbravo"]["lbravo_infil_alpha_" + var_1] = % mp_infil_lbravo_a_heli;
          }

          break;
        case "mp_promenade_gw":
          if(var_1 == "axis" && var_2 == "alpha") {
            level.scr_anim["lbravo"]["lbravo_infil_" + var_2 + "_" + var_1] = % mp_infil_lbravo_a_heli_aniyah_tactical;
          } else {
            level.scr_anim["lbravo"]["lbravo_infil_alpha_" + var_1] = % mp_infil_lbravo_a_heli;
          }

          break;
        case "mp_oilrig":
          level.scr_anim["lbravo"]["lbravo_infil_alpha_" + var_1] = % mp_infil_lbravo_a_heli_oilrig_coalition;
          break;
        case "mp_garden":
          level.scr_anim["lbravo"]["lbravo_infil_alpha_" + var_1] = % mp_infil_lbravo_a_heli_garden;
          break;
        case "mp_harbor":
          level.scr_anim["lbravo"]["lbravo_infil_alpha_" + var_1] = % mp_infil_lbravo_a_heli_harbor;
          break;
        case "mp_riverside_gw":
          if(var_1 == "axis") {
            level.scr_anim["lbravo"]["lbravo_infil_alpha_" + var_1] = % mp_infil_lbravo_a_heli_riverside_allegiance;
          } else {
            level.scr_anim["lbravo"]["lbravo_infil_alpha_" + var_1] = % mp_infil_lbravo_a_heli_riverside_coalition;
          }

          break;
        default:
          level.scr_anim["lbravo"]["lbravo_infil_alpha_" + var_1] = % mp_infil_lbravo_a_heli;
          break;
      }

      break;
    case "bravo":
      level.scr_animtree["lbravo"] = #animtree;

      switch (getDvar("mapname")) {
        case "mp_farms2_gw":
          if(var_1 == "axis") {
            level.scr_anim["lbravo"]["lbravo_infil_bravo_" + var_1] = % mp_infil_lbravo_b_heli_farm_gw_east;
          } else {
            level.scr_anim["lbravo"]["lbravo_infil_bravo_" + var_1] = % mp_infil_lbravo_b_heli_farm_gw_west;
          }

          break;
        case "mp_downtown_gw":
          if(var_1 == "axis") {
            level.scr_anim["lbravo"]["lbravo_infil_bravo_" + var_1] = % mp_infil_lbravo_a_heli_downtown_east;
          } else {
            level.scr_anim["lbravo"]["lbravo_infil_bravo_" + var_1] = % mp_infil_lbravo_a_heli_downtown_west;
          }

          break;
        case "mp_quarry2":
          if(var_1 == "axis") {
            level.scr_anim["lbravo"]["lbravo_infil_bravo_" + var_1] = % mp_infil_lbravo_b_heli_quarry_east;
          } else {
            level.scr_anim["lbravo"]["lbravo_infil_bravo_" + var_1] = % mp_infil_lbravo_b_heli_quarry_west;
          }

          break;
        case "mp_deadzone":
          if(var_1 == "axis") {
            level.scr_anim["lbravo"]["lbravo_infil_bravo_" + var_1] = % mp_infil_lbravo_b_heli_aniyah_gw_east;
          } else {
            level.scr_anim["lbravo"]["lbravo_infil_bravo_" + var_1] = % mp_infil_lbravo_b_heli_deadzone_west;
          }

          break;
        case "mp_runner":
        case "mp_runner_pm":
          level.scr_anim["lbravo"]["lbravo_infil_bravo_" + var_1] = % mp_infil_lbravo_b_heli_runner;
          break;
        case "mp_raid":
          level.scr_anim["lbravo"]["lbravo_infil_bravo_" + var_1] = % mp_infil_lbravo_b_heli_raid;
          break;
        case "mp_aniyah":
          if(var_1 == "axis") {
            switch (level.gametype) {
              case "koth":
              case "hq":
              case "grnd":
              case "dd":
              case "cyber":
              case "sd":
              case "sr":
                level.scr_anim["lbravo"]["lbravo_infil_bravo_" + var_1] = % mp_infil_lbravo_b_heli;
                break;
              default:
                level.scr_anim["lbravo"]["lbravo_infil_bravo_" + var_1] = % mp_infil_lbravo_b_heli_aniyah_gw_east;
                break;
            }
          } else {
            level.scr_anim["lbravo"]["lbravo_infil_bravo_" + var_1] = % mp_infil_lbravo_b_heli_aniyah_hq;
          }

          break;
        case "mp_aniyah_tac":
          level.scr_anim["lbravo"]["lbravo_infil_bravo_" + var_1] = % mp_infil_lbravo_a_heli_aniyah_tactical;
          break;
        case "mp_oilrig":
          level.scr_anim["lbravo"]["lbravo_infil_bravo_" + var_1] = % mp_infil_lbravo_b_heli_oilrig_coalition;
          break;
        case "mp_riverside_gw":
          if(var_1 == "axis") {
            level.scr_anim["lbravo"]["lbravo_infil_bravo_" + var_1] = % mp_infil_lbravo_b_heli_riverside_allegiance;
          } else {
            level.scr_anim["lbravo"]["lbravo_infil_bravo_" + var_1] = % mp_infil_lbravo_b_heli_riverside_coalition;
          }

          break;
        default:
          level.scr_anim["lbravo"]["lbravo_infil_bravo_" + var_1] = % mp_infil_lbravo_b_heli;
          break;
      }

      break;
    default:
      level.scr_anim["lbravo"]["lbravo_infil_bravo_" + var_1] = % mp_infil_lbravo_b_heli;
      break;
  }
}

function commander_play_sound_func(var_0, var_1, var_2) {
  foreach(var_4 in self.infil.players) {
    self playsoundtoplayer(var_0, var_4);
  }
}

function vehiclethinkpath(var_0, var_1, var_2, var_3) {
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

function heli_interior_sfx(var_0) {
  scripts\mp\flags::gameflagwait("infil_started");

  if(var_0 == "alpha") {
    self.linktoent playsoundonmovingent("scn_infil_lbravo_heli1_lr");
    self.linktoent playsoundonmovingent("scn_infil_lbravo_heli1_feet");
  } else {
    self.linktoent playsoundonmovingent("scn_infil_lbravo_heli2_lr");
    self.linktoent playsoundonmovingent("scn_infil_lbravo_heli2_feet");
  }

  level waittill("prematch_over");
}

function giveinteractiveinfilweapon() {
  var_0 = getcompleteweaponname("iw8_sn_alpha50_mp", ["rec_alpha50", "front_alpha50", "back_alpha50", "mag_alpha50", "acog_alpha50_light", "mod_infil_alpha50"]);
  scripts\cp_mp\utility\inventory_utility::_giveweapon(var_0, undefined, undefined, 1);
  scripts\common\utility::allow_weapon_switch(1);
  var_1 = scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(var_0, 0);

  if(var_1) {
    self.infilweapon = var_0;
    scripts\common\utility::allow_weapon_switch(0);
    scripts\mp\utility\weapon::setrecoilscale(0, 50);
  } else {
    scripts\cp_mp\utility\inventory_utility::_takeweapon(var_0);
    scripts\cp_mp\utility\inventory_utility::forcevalidweapon();
  }

  return var_1;
}

function allowinteractivecombat(var_0) {
  self endon("death_or_disconnect");
  self endon("player_free_spot");
  self endon("joined_team");
  thread interactivecombatmessaging();
  wait level.interactiveinfilstart;
  self.interactivecombat = 1;
  scripts\common\utility::allow_fire(1);
  scripts\common\utility::allow_ads(1);
  scripts\common\utility::allow_reload(1);
  self setdemeanorviewmodel("normal");
  self lerpfovbypreset("default_2seconds");
  self.infil waittill("event_shootingWindow_closed");
  self.interactivecombat = 0;
  scripts\common\utility::allow_fire(0);
  scripts\common\utility::allow_ads(0);
  scripts\common\utility::allow_reload(0);
  scripts\mp\utility\weapon::setrecoilscale();
  self setdemeanorviewmodel("safe", "iw8_ges_demeanor_safe_heli");
}

function interactivecombatmessaging() {
  self endon("death_or_disconnect");
  self endon("player_free_spot");
  self endon("joined_team");
  self.infil waittill("event_intro");
  self iprintlnbold("Enemies spotted! LZ is hot!");
  wait 3.25;
  var_0 = getinteractiveinfilline(self.animname, level.mapname);
  self iprintlnbold(var_0);
  self.infil waittill("event_shootingWindow_open");
  self iprintlnbold("Targets Marked! Take them out!");
}

function getinteractiveinfilline(var_0, var_1) {
  switch (var_1) {
    case "mp_raid":
    case "mp_euphrates":
    case "mp_deadzone":
      if(var_0 == "slot_0" || var_0 == "slot_1") {
        return "On the Rooftop! I'm swinging around for a shot!";
      }
    case "mp_runner":
      if(var_0 == "slot_0" || var_0 == "slot_1") {
        return "On the Rooftop! Dead Ahead!";
      }

      if(var_0 == "slot_3" || var_0 == "slot_5") {
        return "In the pit! On the right!";
      }

      break;
  }

  wait 1.25;
  self iprintlnbold("Targets Marked! Take them out!");
}

function interactiveinfilthink(var_0) {
  thread manageinteractivecombattargets(level);
}

function manageinteractivecombattargets(var_0) {
  while(!isDefined(level.infiltargets)) {
    waitframe();
  }

  foreach(var_2 in level.infiltargets["allies"]) {
    thread targetdamagethink(var_2);
    thread deleteoninfilcomplete();
  }
}

function targetdamagethink(var_0) {
  level endon("prematch_over");

  if(istrue(self.isbonus)) {
    self.health = 220;
  } else {
    self.health = 100;
  }

  wait level.interactiveinfilstart;
  var_1 = scripts\mp\utility\outline::outlineenableforteam(self, var_0, scripts\engine\utility::ter_op(istrue(self.isbonus), "outline_depth_red", "outline_depth_orange"), "level_script");

  for(;;) {
    self waittill("damage", var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);

    if(var_2 >= self.health) {
      scripts\mp\utility\outline::outlinedisable(var_1, self);

      if(istrue(self.isbonus)) {
        var_3 thread scripts\mp\rank::giverankxp("infil_bonus", 1000);
        var_3 thread scripts\mp\rank::scoreeventpopup("infil_bonus");
      }

      break;
    }
  }
}

function deleteoninfilcomplete() {
  level waittill("prematch_over");

  if(!isDefined(self)) {
    return;
  }

  if(istrue(self.isbonus) && !isai(self)) {
    self setscriptablepartstate("base", "hide");
    return;
  }

  if(isalive(self)) {
    self suicide();
    return;
  }
}

function cinematiccameratimeline(var_0) {
  self endon("death_or_disconnect");
  self endon("player_free_spot");
  self endon("joined_team");
  scripts\mp\flags::gameflagwait("infil_started");

  switch (level.mapname) {
    case "mp_runner":
    case "mp_runner_pm":
      wait 2.15;
      thread scripts\mp\utility\infilexfil::set_cinematicmotionomnvarovertime(0, 1, 0.75);
      wait 0.75;
      thread scripts\mp\utility\infilexfil::set_cinematicmotionomnvarovertime(1, 0, 0.75);
      break;
  }
}

function customground(var_0) {
  scripts\mp\utility\infilexfil::cam_shake_off(var_0);

  if(!isDefined(var_0)) {
    return;
  }

  if(isDefined(var_0.player)) {
    var_1 = var_0.player;
    return;
  }

  var_1 = var_1;
}