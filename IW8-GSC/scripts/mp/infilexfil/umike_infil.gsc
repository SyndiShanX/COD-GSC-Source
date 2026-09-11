/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\infilexfil\umike_infil.gsc
*************************************************/

function umike_init(var_0) {
  initanims(var_0);
  var_1 = [];
  GscBinSkip0(0x2e, 0, [0, 1, 2, 3, 4, 5]);
}

function umike_spawn(var_0, var_1, var_2, var_3) {
  var_4 = scripts\engine\utility::getStruct(var_1, "targetname");
  var_5 = spawn("script_origin", var_4.origin);
  var_5.angles = var_4.angles;
  var_5.scene_node = var_4;

  if(isDefined(var_4.target)) {
    var_5.path = getvehiclenode(var_4.target, "targetname");
  }

  thread infilthink(var_5, var_0);
  return var_5;
}

function umike_get_length(var_0) {
  var_1 = getanimlength(level.scr_anim["slot_0"]["umike_infil_" + var_0]);
  var_1 += getanimlength(level.scr_anim["slot_0"]["umike_infil_" + var_0 + "_exit"]);
  return var_1;
}

function player_umike_infil_think(var_0, var_1) {
  self endon("player_free_spot");

  if(isPlayer(self)) {
    self setsoundsubmix("mp_infil_umike", 0);
  }

  thread player_infil_end();
  var_2 = var_0.linktoent gettagorigin("tag_body_animate");
  var_3 = var_0.linktoent gettagangles("tag_body_animate");
  thread scripts\mp\utility\infilexfil::infil_player_rig_updated("slot_" + var_1, var_2, var_3);
  self.player_rig.weapon_state_func = &scripts\mp\utility\infilexfil::handleweaponstatenotetrack;
  self.player_rig linkTo(var_0.linktoent, "tag_body_animate", (0, 0, 0), (0, 0, 0));

  if(istrue(level.interactiveinfil) && !isai(self)) {
    giveinteractiveinfilweapon();
  } else {
    self setdemeanorviewmodel("safe", "iw8_ges_demeanor_safe_van");
  }

  thread scripts\mp\infilexfil\infilexfil::infil_scene_fade_in(0, 0.55);
  thread player_van_disconnect();
  self.manualoverridewindmaterial = 1;
  self setscriptablepartstate("wind", "40", 0);
  level waittill("start_scene");
  self clearsoundsubmix("mp_infil_umike", 2);

  if(isDefined(self.team) && self.team != "spectator") {
    var_4 = [];
    GscBinSkip0(0x2e, var_4.size, "mp_infil_mix_musicheavy");
  }

  if(istrue(level.interactiveinfil) && !isai(self)) {
    thread allowinteractivecombat();
  }

  self setcinematicmotionoverride("disabled");
  self lerpviewangleclamp(1, 0.25, 0.25, 120, 120, 60, 10);
  var_1.linktoent scripts\mp\anim::anim_player_solo(self, self.player_rig, "umike_infil_" + var_1.subtype, "tag_body_animate");
  var_1.linktoent scripts\mp\anim::anim_player_solo(self, self.player_rig, "umike_infil_" + var_1.subtype + "_exit", "tag_body_animate");
  thread clear_infil_ambient_zone();

  if(isDefined(self.player_rig) && self.player_rig islinked()) {
    self.player_rig unlink();
  }

  self visionsetnakedforplayer("", 0.75);
  self setdemeanorviewmodel("normal");
  self clearcinematicmotionoverride();
  self disablephysicaldepthoffieldscripting();
  self.manualoverridewindmaterial = 0;
}

function clear_infil_ambient_zone() {
  self endon("death_or_disconnect");
  wait 1;
  self clearallsoundsubmixes();
  self clearclienttriggeraudiozone(2);
}

function player_infil_end() {
  self endon("disconnect");
  level waittill("prematch_over");
  self notify("remove_rig");
  self clearallsoundsubmixes();
  self clearclienttriggeraudiozone(1);
  scripts\mp\utility\player::setdof_default();
}

function player_van_disconnect() {
  level endon("prematch_over");
  self waittill("death_or_disconnect");

  if(isDefined(self)) {
    self visionsetnakedforplayer("");
    self clearallsoundsubmixes();
    self clearclienttriggeraudiozone(0);
    self lerpfovbypreset("default");
    self setviewmodeldepthoffield(0, 0, 18);
    scripts\mp\utility\player::setdof_default();
    return;
  }
}

function infilthink(var_0, var_1) {
  var_2 = getdvarfloat("NMORQOTSK", 0.2);

  foreach(var_4 in getEntArray("infil_delete", "script_noteworthy")) {
    var_4 delete();
  }

  thread vehiclethink(var_0, self.scene_node, var_1);
  thread actorthink(var_0, self.scene_node, var_1);
  level waittill("infil_started");
  setDvar("TLMMOPMSK", 1);
  setDvar("NMORQOTSK", 1);
  level notify("start_scene");

  if(istrue(level.interactiveinfil)) {
    thread interactiveinfilthink(level);
  }

  level waittill("prematch_over");
  waitframe();
  setDvar("TLMMOPMSK", 0);
  setDvar("NMORQOTSK", var_2);

  while(isDefined(self.actors)) {
    waitframe();
  }

  if(isDefined(self.cleanupents)) {
    foreach(var_4 in self.cleanupents) {
      var_4 delete();
    }
  }

  level.stop_station_closed_vo--;
  self delete();
}

function vehiclethink(var_0, var_1, var_2, var_3) {
  self.linktoent = spawninfilvehicle(var_1, var_0, var_2);

  if(isDefined(self.path)) {
    thread vehiclethinkpath(var_0, var_1, var_2, var_3);
  } else {
    thread vehiclethinkmodel(var_0, var_1, var_2, var_3);
  }

  level waittill("prematch_over");
  var_4 = getEnt("umike_clip", "targetname");

  if(isDefined(var_4)) {
    var_5 = spawn("script_model", self.linktoent.origin);
    var_5.angles = self.linktoent.angles;
    var_5 clonebrushmodeltoscriptmodel(var_4);
    var_5 disconnectPaths();
  }

  if(istrue(self.linktoent.shouldfree)) {
    self.linktoent makecorpse();
  }

  game["infil"]["types"][self.type][var_2]["persistentVehicle"] = &spawnpersistentvehicle;
  game["infil"]["types"][self.type][var_2]["vehicleOrg"] = self.linktoent.origin;
  game["infil"]["types"][self.type][var_2]["vehicleAng"] = self.linktoent.angles;
}

function spawnpersistentvehicle(var_0, var_1) {
  var_2 = game["infil"]["types"][var_0][var_1]["vehicleOrg"];
  var_3 = game["infil"]["types"][var_0][var_1]["vehicleAng"];
  var_4 = spawnVehicle("veh8_mil_lnd_umike_infil", "umike", "umike", var_2, var_3);
  var_4.animname = "umikeVeh";
  var_4 vehicle_turnengineoff();
  var_5 = getEnt("umike_clip", "targetname");

  if(isDefined(var_5)) {
    var_6 = spawn("script_model", var_2);
    var_6.angles = var_3;
    var_6 clonebrushmodeltoscriptmodel(var_5);
    return;
  }
}

function vehiclethinkpath(var_0, var_1, var_2, var_3) {
  level waittill("infil_started");
  thread vehiclefollowpath(self.linktoent);
  thread scripts\common\anim::anim_single_solo(self.linktoent, "umike_infil_" + var_2 + "_path");
  thread play_tailgate_sfx();
  self.linktoent setscriptablepartstate("dustFX", "normal");
  self.linktoent setscriptablepartstate("exhaustFX", "active");
  self.linktoent setscriptablepartstate("lights_controller", "on");
  self.linktoent setscriptablepartstate("infil_lights", "on");
  level waittill("prematch_over");
  self.linktoent setscriptablepartstate("dustFX", "neutral");
  self.linktoent setscriptablepartstate("exhaustFX", "neutral");
  self.linktoent setscriptablepartstate("lights_controller", "off");
  self.linktoent setscriptablepartstate("infil_lights", "off");

  if(isDefined(self.linktoent.clip)) {
    self.linktoent.clip show();
    self.linktoent.clip.angles = self.linktoent.angles;
    self.linktoent.clip.origin = self.linktoent.origin;
    self.linktoent.clip disconnectPaths();
    return;
  }
}

function vehiclethinkmodel(var_0, var_1, var_2, var_3) {
  scripts\common\anim::anim_first_frame_solo(self.linktoent, "umike_infil_" + var_2);
  level waittill("infil_started");
  thread scripts\common\anim::anim_single_solo(self.linktoent, "umike_infil_" + var_2);
  thread play_tailgate_sfx();
  self.linktoent setscriptablepartstate("dustFX", "normal");
  self.linktoent setscriptablepartstate("exhaustFX", "active");
  self.linktoent setscriptablepartstate("lights_controller", "on");
  self.linktoent setscriptablepartstate("infil_lights", "on");
  level waittill("prematch_over");
  self.linktoent setscriptablepartstate("dustFX", "neutral");
  self.linktoent setscriptablepartstate("exhaustFX", "neutral");
  self.linktoent setscriptablepartstate("lights_controller", "off");
  self.linktoent setscriptablepartstate("infil_lights", "off");

  if(isDefined(self.linktoent.clip)) {
    self.linktoent.clip show();
    self.linktoent.clip.angles = self.linktoent.angles;
    self.linktoent.clip.origin = self.linktoent.origin;
    self.linktoent.clip disconnectPaths();
    return;
  }
}

function play_tailgate_sfx() {
  var_0 = self gettagorigin("tag_exhaust");
  var_1 = spawn("script_model", var_0);
  var_1 linkTo(self, "tag_exhaust");
  wait 6.5;
  var_1 playsoundonmovingent("mp_infil_umike_exit_tailgate");
  wait 20;
  var_1 delete();
}

function flapsthink(var_0, var_1, var_2, var_3) {
  self.linktoent scripts\common\anim::anim_first_frame_solo(self.linktoent.flaps, "umike_infil_" + var_2, "tag_body_animate");
  level waittill("infil_started");
  self.linktoent thread scripts\common\anim::anim_single_solo(self.linktoent.flaps, "umike_infil_" + var_2, "tag_body_animate");
}

function spawninfilvehicle(var_0, var_1, var_2) {
  if(isDefined(self.path)) {
    var_3 = self.path.origin;
    var_4 = self.path.angles;
    var_5 = spawnVehicle(scripts\engine\utility::ter_op(var_1 == "allies", "veh8_mil_lnd_umike_allied_infil", "veh8_mil_lnd_umike_infil"), "umike", "umike", var_3, var_4);
    var_5.animname = "umikeVeh";
    var_5.shouldfree = 1;
  } else {
    var_5 = spawn("script_model", var_1.origin);
    var_5.angles = var_1.angles;
    var_5 setModel("veh8_mil_lnd_umike_infil");
    var_5.animname = "umike";
    var_5 scripts\common\anim::setanimtree();
  }

  var_5.infil = self;
  var_5 setCanDamage(0);
  thread vehicleplaysounds();
  return var_5;
}

function vehicleplaysounds() {
  var_0 = self;
  var_0 vehicle_turnengineoff();
  var_1 = var_0 gettagorigin("tag_light_front_left");
  var_2 = spawn("script_model", var_1);
  var_2 linkTo(var_0, "tag_light_front_left");
  var_3 = var_0 gettagorigin("tag_exhaust");
  var_4 = spawn("script_model", var_3);
  var_4 linkTo(var_0, "tag_exhaust");
  var_2 playLoopSound("mp_infil_umike_engine_front_lp");
  var_4 playLoopSound("mp_infil_umike_engine_rear_lp");
  level waittill("infil_started");
  wait 2.5;
  var_2 playsoundonmovingent("mp_infil_umike_engine_stop_front");
  var_4 playsoundonmovingent("mp_infil_umike_engine_stop_rear");
  wait 1;
  var_2 stoploopsound();
  var_4 stoploopsound();
  wait 2;
  level waittill("prematch_over");
  wait 5;
  var_2 delete();
  var_4 delete();
}

function vehiclefollowpath(var_0) {
  self endon("death");
  self endon("stop_follow_path");
  self startpath(var_0);

  for(var_1 = getvehiclenode(var_0.target, "targetname"); isDefined(var_1); var_1 = getvehiclenode(var_1.target, "targetname")) {
    var_1 waittill("trigger");

    if(isDefined(var_1.script_unload)) {
      self vehicle_setspeedimmediate(0, 30, 30);

      for(var_2 = self vehicle_getspeed(); var_2 > 1; var_2 = self vehicle_getspeed()) {
        wait 0.1;
      }

      self notify("unload_guys");

      while(self.riders.size > 0) {
        wait 0.1;
      }

      if(isDefined(var_1.target)) {
        self resumespeed(10);
      }
    }

    if(!isDefined(var_1.target)) {
      break;
    }
  }

  self vehicle_setspeedimmediate(0, 30, 30);

  for(var_2 = self vehicle_getspeed(); var_2 > 1; var_2 = self vehicle_getspeed()) {
    wait 0.1;
  }
}

function actorthink(var_0, var_1, var_2, var_3) {
  thread spawnactors(var_0, var_2, var_3);
  self.linktoent scripts\common\anim::anim_first_frame(self.actors, "umike_infil_" + var_2, "tag_body_animate");
  level waittill("infil_started");
  self.linktoent thread scripts\common\anim::anim_single(self.actors, "umike_infil_" + var_2, "tag_body_animate");
  self.actors[0].head scriptmodelplayanim(level.scr_anim[self.actors[0].animname]["umike_infil_" + var_2]);
  level waittill("prematch_over");

  foreach(var_5 in self.actors) {
    if(isDefined(var_5)) {
      var_5 delete();
    }
  }

  self.actors = undefined;
}

function spawnactors(var_0, var_1, var_2) {
  if(!isDefined(self.actors)) {
    self.actors = [];
  }

  var_3 = getdriverassets(var_0);
  self.actors[self.actors.size] = spawn_anim_model(self.linktoent, "driver", "tag_body_animate", var_3.body, var_3.head);

  foreach(var_5 in self.actors) {
    var_5.infil = self;
  }
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

  switch (var_0) {
    case "alpha":
      scripts\common\anim::addnotetrack_customfunction("slot_0", "80_instant", &scripts\mp\utility\infilexfil::player_fov_80_instant, "umike_infil_alpha");
      scripts\common\anim::addnotetrack_customfunction("slot_1", "80_instant", &scripts\mp\utility\infilexfil::player_fov_80_instant, "umike_infil_alpha");
      scripts\common\anim::addnotetrack_customfunction("slot_2", "80_instant", &scripts\mp\utility\infilexfil::player_fov_80_instant, "umike_infil_alpha");
      scripts\common\anim::addnotetrack_customfunction("slot_3", "80_instant", &scripts\mp\utility\infilexfil::player_fov_80_instant, "umike_infil_alpha");
      scripts\common\anim::addnotetrack_customfunction("slot_4", "80_instant", &scripts\mp\utility\infilexfil::player_fov_80_instant, "umike_infil_alpha");
      scripts\common\anim::addnotetrack_customfunction("slot_5", "80_instant", &scripts\mp\utility\infilexfil::player_fov_80_instant, "umike_infil_alpha");
      scripts\common\anim::addnotetrack_customfunction("slot_0", "fov_63_2", &scripts\mp\utility\infilexfil::player_fov_default_2, "umike_infil_alpha_exit");
      scripts\common\anim::addnotetrack_customfunction("slot_1", "fov_63_2", &scripts\mp\utility\infilexfil::player_fov_default_2, "umike_infil_alpha_exit");
      scripts\common\anim::addnotetrack_customfunction("slot_2", "fov_63_2", &scripts\mp\utility\infilexfil::player_fov_default_2, "umike_infil_alpha_exit");
      scripts\common\anim::addnotetrack_customfunction("slot_3", "fov_63_2", &scripts\mp\utility\infilexfil::player_fov_default_2, "umike_infil_alpha_exit");
      scripts\common\anim::addnotetrack_customfunction("slot_4", "fov_63_2", &scripts\mp\utility\infilexfil::player_fov_default_2, "umike_infil_alpha_exit");
      scripts\common\anim::addnotetrack_customfunction("slot_5", "fov_63_2", &scripts\mp\utility\infilexfil::player_fov_default_2, "umike_infil_alpha_exit");
      scripts\common\anim::addnotetrack_customfunction("slot_0", "player_lock_look_1_second", &scripts\mp\utility\infilexfil::player_lock_look_1_second, "umike_infil_alpha");
      scripts\common\anim::addnotetrack_customfunction("slot_1", "player_lock_look_1_second", &scripts\mp\utility\infilexfil::player_lock_look_1_second, "umike_infil_alpha");
      scripts\common\anim::addnotetrack_customfunction("slot_2", "player_lock_look_1_second", &scripts\mp\utility\infilexfil::player_lock_look_1_second, "umike_infil_alpha");
      scripts\common\anim::addnotetrack_customfunction("slot_3", "player_lock_look_1_second", &scripts\mp\utility\infilexfil::player_lock_look_1_second, "umike_infil_alpha");
      scripts\common\anim::addnotetrack_customfunction("slot_4", "player_lock_look_1_second", &scripts\mp\utility\infilexfil::player_lock_look_1_second, "umike_infil_alpha");
      scripts\common\anim::addnotetrack_customfunction("slot_5", "player_lock_look_1_second", &scripts\mp\utility\infilexfil::player_lock_look_1_second, "umike_infil_alpha");
      scripts\common\anim::addnotetrack_customfunction("slot_0", "player_lock_look_2_second", &scripts\mp\utility\infilexfil::player_lock_look_2_second, "umike_infil_alpha");
      scripts\common\anim::addnotetrack_customfunction("slot_1", "player_lock_look_2_second", &scripts\mp\utility\infilexfil::player_lock_look_2_second, "umike_infil_alpha");
      scripts\common\anim::addnotetrack_customfunction("slot_2", "player_lock_look_2_second", &scripts\mp\utility\infilexfil::player_lock_look_2_second, "umike_infil_alpha");
      scripts\common\anim::addnotetrack_customfunction("slot_3", "player_lock_look_2_second", &scripts\mp\utility\infilexfil::player_lock_look_2_second, "umike_infil_alpha");
      scripts\common\anim::addnotetrack_customfunction("slot_4", "player_lock_look_2_second", &scripts\mp\utility\infilexfil::player_lock_look_2_second, "umike_infil_alpha");
      scripts\common\anim::addnotetrack_customfunction("slot_5", "player_lock_look_2_second", &scripts\mp\utility\infilexfil::player_lock_look_2_second, "umike_infil_alpha");
      scripts\common\anim::addnotetrack_customfunction("slot_0", "free_look", &scripts\mp\utility\infilexfil::player_free_look, "umike_infil_alpha_exit");
      scripts\common\anim::addnotetrack_customfunction("slot_1", "free_look", &scripts\mp\utility\infilexfil::player_free_look, "umike_infil_alpha_exit");
      scripts\common\anim::addnotetrack_customfunction("slot_2", "free_look", &scripts\mp\utility\infilexfil::player_free_look, "umike_infil_alpha_exit");
      scripts\common\anim::addnotetrack_customfunction("slot_3", "free_look", &scripts\mp\utility\infilexfil::player_free_look, "umike_infil_alpha_exit");
      scripts\common\anim::addnotetrack_customfunction("slot_4", "free_look", &scripts\mp\utility\infilexfil::player_free_look, "umike_infil_alpha_exit");
      scripts\common\anim::addnotetrack_customfunction("slot_5", "free_look", &scripts\mp\utility\infilexfil::player_free_look, "umike_infil_alpha_exit");
      scripts\common\anim::addnotetrack_customfunction("slot_0", "shake_on", &scripts\mp\utility\infilexfil::cam_shake_low, "umike_infil_alpha");
      scripts\common\anim::addnotetrack_customfunction("slot_1", "shake_on", &scripts\mp\utility\infilexfil::cam_shake_low, "umike_infil_alpha");
      scripts\common\anim::addnotetrack_customfunction("slot_2", "shake_on", &scripts\mp\utility\infilexfil::cam_shake_low, "umike_infil_alpha");
      scripts\common\anim::addnotetrack_customfunction("slot_3", "shake_on", &scripts\mp\utility\infilexfil::cam_shake_low, "umike_infil_alpha");
      scripts\common\anim::addnotetrack_customfunction("slot_4", "shake_on", &scripts\mp\utility\infilexfil::cam_shake_low, "umike_infil_alpha");
      scripts\common\anim::addnotetrack_customfunction("slot_5", "shake_on", &scripts\mp\utility\infilexfil::cam_shake_low, "umike_infil_alpha");
      scripts\common\anim::addnotetrack_customfunction("slot_0", "shake_off", &umike_cam_shake_ground, "umike_infil_alpha_exit");
      scripts\common\anim::addnotetrack_customfunction("slot_1", "shake_off", &umike_cam_shake_ground, "umike_infil_alpha_exit");
      scripts\common\anim::addnotetrack_customfunction("slot_2", "shake_off", &umike_cam_shake_ground, "umike_infil_alpha_exit");
      scripts\common\anim::addnotetrack_customfunction("slot_3", "shake_off", &umike_cam_shake_ground, "umike_infil_alpha_exit");
      scripts\common\anim::addnotetrack_customfunction("slot_4", "shake_off", &umike_cam_shake_ground, "umike_infil_alpha_exit");
      scripts\common\anim::addnotetrack_customfunction("slot_5", "shake_off", &umike_cam_shake_ground, "umike_infil_alpha_exit");
      scripts\common\anim::addnotetrack_customfunction("slot_0", "equip_nvg", &scripts\mp\utility\infilexfil::player_equip_nvg, "umike_infil_alpha");
      scripts\common\anim::addnotetrack_customfunction("slot_1", "equip_nvg", &scripts\mp\utility\infilexfil::player_equip_nvg, "umike_infil_alpha");
      scripts\common\anim::addnotetrack_customfunction("slot_2", "equip_nvg", &scripts\mp\utility\infilexfil::player_equip_nvg, "umike_infil_alpha");
      scripts\common\anim::addnotetrack_customfunction("slot_3", "equip_nvg", &scripts\mp\utility\infilexfil::player_equip_nvg, "umike_infil_alpha");
      scripts\common\anim::addnotetrack_customfunction("slot_4", "equip_nvg", &scripts\mp\utility\infilexfil::player_equip_nvg, "umike_infil_alpha");
      scripts\common\anim::addnotetrack_customfunction("slot_5", "equip_nvg", &scripts\mp\utility\infilexfil::player_equip_nvg, "umike_infil_alpha");
      scripts\common\anim::addnotetrack_customfunction("slot_0", "reduce_wind", &reducewind, "umike_infil_alpha");
      scripts\common\anim::addnotetrack_customfunction("slot_1", "reduce_wind", &reducewind, "umike_infil_alpha");
      scripts\common\anim::addnotetrack_customfunction("slot_2", "reduce_wind", &reducewind, "umike_infil_alpha");
      scripts\common\anim::addnotetrack_customfunction("slot_3", "reduce_wind", &reducewind, "umike_infil_alpha");
      scripts\common\anim::addnotetrack_customfunction("slot_4", "reduce_wind", &reducewind, "umike_infil_alpha");
      scripts\common\anim::addnotetrack_customfunction("slot_5", "reduce_wind", &reducewind, "umike_infil_alpha");
      scripts\common\anim::addnotetrack_customfunction("slot_0", "mp_infil_umike_exit_jump_land", &mp_infil_umike_exit_jump_land_sfx, "umike_infil_alpha_exit");
      scripts\common\anim::addnotetrack_customfunction("slot_1", "mp_infil_umike_exit_jump_land", &mp_infil_umike_exit_jump_land_sfx, "umike_infil_alpha_exit");
      scripts\common\anim::addnotetrack_customfunction("slot_2", "mp_infil_umike_exit_jump_land", &mp_infil_umike_exit_jump_land_sfx, "umike_infil_alpha_exit");
      scripts\common\anim::addnotetrack_customfunction("slot_3", "mp_infil_umike_exit_jump_land", &mp_infil_umike_exit_jump_land_sfx, "umike_infil_alpha_exit");
      scripts\common\anim::addnotetrack_customfunction("slot_4", "mp_infil_umike_exit_jump_land", &mp_infil_umike_exit_jump_land_sfx, "umike_infil_alpha_exit");
      scripts\common\anim::addnotetrack_customfunction("slot_5", "mp_infil_umike_exit_jump_land", &mp_infil_umike_exit_jump_land_sfx, "umike_infil_alpha_exit");
      scripts\common\anim::addnotetrack_customfunction("slot_0", "mp_infil_umike_exit_npc_step", &mp_infil_umike_exit_npc_step_sfx, "umike_infil_alpha_exit");
      scripts\common\anim::addnotetrack_customfunction("slot_1", "mp_infil_umike_exit_npc_step", &mp_infil_umike_exit_npc_step_sfx, "umike_infil_alpha_exit");
      scripts\common\anim::addnotetrack_customfunction("slot_2", "mp_infil_umike_exit_npc_step", &mp_infil_umike_exit_npc_step_sfx, "umike_infil_alpha_exit");
      scripts\common\anim::addnotetrack_customfunction("slot_3", "mp_infil_umike_exit_npc_step", &mp_infil_umike_exit_npc_step_sfx, "umike_infil_alpha_exit");
      scripts\common\anim::addnotetrack_customfunction("slot_4", "mp_infil_umike_exit_npc_step", &mp_infil_umike_exit_npc_step_sfx, "umike_infil_alpha_exit");
      scripts\common\anim::addnotetrack_customfunction("slot_5", "mp_infil_umike_exit_npc_step", &mp_infil_umike_exit_npc_step_sfx, "umike_infil_alpha_exit");
      scripts\common\anim::addnotetrack_customfunction("slot_0", "mp_infil_umike_exit_suspension_creak", &mp_infil_umike_exit_suspension_creak, "umike_infil_alpha_exit");
      scripts\common\anim::addnotetrack_customfunction("slot_1", "mp_infil_umike_exit_suspension_creak", &mp_infil_umike_exit_suspension_creak, "umike_infil_alpha_exit");
      scripts\common\anim::addnotetrack_customfunction("slot_2", "mp_infil_umike_exit_suspension_creak", &mp_infil_umike_exit_suspension_creak, "umike_infil_alpha_exit");
      scripts\common\anim::addnotetrack_customfunction("slot_3", "mp_infil_umike_exit_suspension_creak", &mp_infil_umike_exit_suspension_creak, "umike_infil_alpha_exit");
      scripts\common\anim::addnotetrack_customfunction("slot_4", "mp_infil_umike_exit_suspension_creak", &mp_infil_umike_exit_suspension_creak, "umike_infil_alpha_exit");
      scripts\common\anim::addnotetrack_customfunction("slot_5", "mp_infil_umike_exit_suspension_creak", &mp_infil_umike_exit_suspension_creak, "umike_infil_alpha_exit");
      break;
    case "bravo":
      scripts\common\anim::addnotetrack_customfunction("slot_0", "80_instant", &scripts\mp\utility\infilexfil::player_fov_80_instant, "umike_infil_bravo");
      scripts\common\anim::addnotetrack_customfunction("slot_1", "80_instant", &scripts\mp\utility\infilexfil::player_fov_80_instant, "umike_infil_bravo");
      scripts\common\anim::addnotetrack_customfunction("slot_2", "80_instant", &scripts\mp\utility\infilexfil::player_fov_80_instant, "umike_infil_bravo");
      scripts\common\anim::addnotetrack_customfunction("slot_3", "80_instant", &scripts\mp\utility\infilexfil::player_fov_80_instant, "umike_infil_bravo");
      scripts\common\anim::addnotetrack_customfunction("slot_4", "80_instant", &scripts\mp\utility\infilexfil::player_fov_80_instant, "umike_infil_bravo");
      scripts\common\anim::addnotetrack_customfunction("slot_5", "80_instant", &scripts\mp\utility\infilexfil::player_fov_80_instant, "umike_infil_bravo");
      scripts\common\anim::addnotetrack_customfunction("slot_0", "fov_63_2", &scripts\mp\utility\infilexfil::player_fov_default_2, "umike_infil_bravo_exit");
      scripts\common\anim::addnotetrack_customfunction("slot_1", "fov_63_2", &scripts\mp\utility\infilexfil::player_fov_default_2, "umike_infil_bravo_exit");
      scripts\common\anim::addnotetrack_customfunction("slot_2", "fov_63_2", &scripts\mp\utility\infilexfil::player_fov_default_2, "umike_infil_bravo_exit");
      scripts\common\anim::addnotetrack_customfunction("slot_3", "fov_63_2", &scripts\mp\utility\infilexfil::player_fov_default_2, "umike_infil_bravo_exit");
      scripts\common\anim::addnotetrack_customfunction("slot_4", "fov_63_2", &scripts\mp\utility\infilexfil::player_fov_default_2, "umike_infil_bravo_exit");
      scripts\common\anim::addnotetrack_customfunction("slot_5", "fov_63_2", &scripts\mp\utility\infilexfil::player_fov_default_2, "umike_infil_bravo_exit");
      scripts\common\anim::addnotetrack_customfunction("slot_0", "player_lock_look_1_second", &scripts\mp\utility\infilexfil::player_lock_look_1_second, "umike_infil_bravo");
      scripts\common\anim::addnotetrack_customfunction("slot_1", "player_lock_look_1_second", &scripts\mp\utility\infilexfil::player_lock_look_1_second, "umike_infil_bravo");
      scripts\common\anim::addnotetrack_customfunction("slot_2", "player_lock_look_1_second", &scripts\mp\utility\infilexfil::player_lock_look_1_second, "umike_infil_bravo");
      scripts\common\anim::addnotetrack_customfunction("slot_3", "player_lock_look_1_second", &scripts\mp\utility\infilexfil::player_lock_look_1_second, "umike_infil_bravo");
      scripts\common\anim::addnotetrack_customfunction("slot_4", "player_lock_look_1_second", &scripts\mp\utility\infilexfil::player_lock_look_1_second, "umike_infil_bravo");
      scripts\common\anim::addnotetrack_customfunction("slot_5", "player_lock_look_1_second", &scripts\mp\utility\infilexfil::player_lock_look_1_second, "umike_infil_bravo");
      scripts\common\anim::addnotetrack_customfunction("slot_0", "player_lock_look_2_second", &scripts\mp\utility\infilexfil::player_lock_look_2_second, "umike_infil_bravo");
      scripts\common\anim::addnotetrack_customfunction("slot_1", "player_lock_look_2_second", &scripts\mp\utility\infilexfil::player_lock_look_2_second, "umike_infil_bravo");
      scripts\common\anim::addnotetrack_customfunction("slot_2", "player_lock_look_2_second", &scripts\mp\utility\infilexfil::player_lock_look_2_second, "umike_infil_bravo");
      scripts\common\anim::addnotetrack_customfunction("slot_3", "player_lock_look_2_second", &scripts\mp\utility\infilexfil::player_lock_look_2_second, "umike_infil_bravo");
      scripts\common\anim::addnotetrack_customfunction("slot_4", "player_lock_look_2_second", &scripts\mp\utility\infilexfil::player_lock_look_2_second, "umike_infil_bravo");
      scripts\common\anim::addnotetrack_customfunction("slot_5", "player_lock_look_2_second", &scripts\mp\utility\infilexfil::player_lock_look_2_second, "umike_infil_bravo");
      scripts\common\anim::addnotetrack_customfunction("slot_0", "free_look", &scripts\mp\utility\infilexfil::player_free_look, "umike_infil_bravo_exit");
      scripts\common\anim::addnotetrack_customfunction("slot_1", "free_look", &scripts\mp\utility\infilexfil::player_free_look, "umike_infil_bravo_exit");
      scripts\common\anim::addnotetrack_customfunction("slot_2", "free_look", &scripts\mp\utility\infilexfil::player_free_look, "umike_infil_bravo_exit");
      scripts\common\anim::addnotetrack_customfunction("slot_3", "free_look", &scripts\mp\utility\infilexfil::player_free_look, "umike_infil_bravo_exit");
      scripts\common\anim::addnotetrack_customfunction("slot_4", "free_look", &scripts\mp\utility\infilexfil::player_free_look, "umike_infil_bravo_exit");
      scripts\common\anim::addnotetrack_customfunction("slot_5", "free_look", &scripts\mp\utility\infilexfil::player_free_look, "umike_infil_bravo_exit");
      scripts\common\anim::addnotetrack_customfunction("slot_0", "shake_on", &scripts\mp\utility\infilexfil::cam_shake_running, "umike_infil_bravo");
      scripts\common\anim::addnotetrack_customfunction("slot_1", "shake_on", &scripts\mp\utility\infilexfil::cam_shake_running, "umike_infil_bravo");
      scripts\common\anim::addnotetrack_customfunction("slot_2", "shake_on", &scripts\mp\utility\infilexfil::cam_shake_running, "umike_infil_bravo");
      scripts\common\anim::addnotetrack_customfunction("slot_3", "shake_on", &scripts\mp\utility\infilexfil::cam_shake_running, "umike_infil_bravo");
      scripts\common\anim::addnotetrack_customfunction("slot_4", "shake_on", &scripts\mp\utility\infilexfil::cam_shake_running, "umike_infil_bravo");
      scripts\common\anim::addnotetrack_customfunction("slot_5", "shake_on", &scripts\mp\utility\infilexfil::cam_shake_running, "umike_infil_bravo");
      scripts\common\anim::addnotetrack_customfunction("slot_0", "shake_off", &umike_cam_shake_ground, "umike_infil_bravo_exit");
      scripts\common\anim::addnotetrack_customfunction("slot_1", "shake_off", &umike_cam_shake_ground, "umike_infil_bravo_exit");
      scripts\common\anim::addnotetrack_customfunction("slot_2", "shake_off", &umike_cam_shake_ground, "umike_infil_bravo_exit");
      scripts\common\anim::addnotetrack_customfunction("slot_3", "shake_off", &umike_cam_shake_ground, "umike_infil_bravo_exit");
      scripts\common\anim::addnotetrack_customfunction("slot_4", "shake_off", &umike_cam_shake_ground, "umike_infil_bravo_exit");
      scripts\common\anim::addnotetrack_customfunction("slot_5", "shake_off", &umike_cam_shake_ground, "umike_infil_bravo_exit");
      scripts\common\anim::addnotetrack_customfunction("slot_0", "equip_nvg", &scripts\mp\utility\infilexfil::player_equip_nvg, "umike_infil_bravo");
      scripts\common\anim::addnotetrack_customfunction("slot_1", "equip_nvg", &scripts\mp\utility\infilexfil::player_equip_nvg, "umike_infil_bravo");
      scripts\common\anim::addnotetrack_customfunction("slot_2", "equip_nvg", &scripts\mp\utility\infilexfil::player_equip_nvg, "umike_infil_bravo");
      scripts\common\anim::addnotetrack_customfunction("slot_3", "equip_nvg", &scripts\mp\utility\infilexfil::player_equip_nvg, "umike_infil_bravo");
      scripts\common\anim::addnotetrack_customfunction("slot_4", "equip_nvg", &scripts\mp\utility\infilexfil::player_equip_nvg, "umike_infil_bravo");
      scripts\common\anim::addnotetrack_customfunction("slot_5", "equip_nvg", &scripts\mp\utility\infilexfil::player_equip_nvg, "umike_infil_bravo");
      scripts\common\anim::addnotetrack_customfunction("slot_0", "reduce_wind", &reducewind, "umike_infil_bravo");
      scripts\common\anim::addnotetrack_customfunction("slot_1", "reduce_wind", &reducewind, "umike_infil_bravo");
      scripts\common\anim::addnotetrack_customfunction("slot_2", "reduce_wind", &reducewind, "umike_infil_bravo");
      scripts\common\anim::addnotetrack_customfunction("slot_3", "reduce_wind", &reducewind, "umike_infil_bravo");
      scripts\common\anim::addnotetrack_customfunction("slot_4", "reduce_wind", &reducewind, "umike_infil_bravo");
      scripts\common\anim::addnotetrack_customfunction("slot_5", "reduce_wind", &reducewind, "umike_infil_bravo");
      scripts\common\anim::addnotetrack_customfunction("slot_0", "mp_infil_umike_exit_jump_land", &mp_infil_umike_exit_jump_land_sfx, "umike_infil_bravo_exit");
      scripts\common\anim::addnotetrack_customfunction("slot_1", "mp_infil_umike_exit_jump_land", &mp_infil_umike_exit_jump_land_sfx, "umike_infil_bravo_exit");
      scripts\common\anim::addnotetrack_customfunction("slot_2", "mp_infil_umike_exit_jump_land", &mp_infil_umike_exit_jump_land_sfx, "umike_infil_bravo_exit");
      scripts\common\anim::addnotetrack_customfunction("slot_3", "mp_infil_umike_exit_jump_land", &mp_infil_umike_exit_jump_land_sfx, "umike_infil_bravo_exit");
      scripts\common\anim::addnotetrack_customfunction("slot_4", "mp_infil_umike_exit_jump_land", &mp_infil_umike_exit_jump_land_sfx, "umike_infil_bravo_exit");
      scripts\common\anim::addnotetrack_customfunction("slot_5", "mp_infil_umike_exit_jump_land", &mp_infil_umike_exit_jump_land_sfx, "umike_infil_bravo_exit");
      scripts\common\anim::addnotetrack_customfunction("slot_0", "mp_infil_umike_exit_npc_step", &mp_infil_umike_exit_npc_step_sfx, "umike_infil_bravo_exit");
      scripts\common\anim::addnotetrack_customfunction("slot_1", "mp_infil_umike_exit_npc_step", &mp_infil_umike_exit_npc_step_sfx, "umike_infil_bravo_exit");
      scripts\common\anim::addnotetrack_customfunction("slot_2", "mp_infil_umike_exit_npc_step", &mp_infil_umike_exit_npc_step_sfx, "umike_infil_bravo_exit");
      scripts\common\anim::addnotetrack_customfunction("slot_3", "mp_infil_umike_exit_npc_step", &mp_infil_umike_exit_npc_step_sfx, "umike_infil_bravo_exit");
      scripts\common\anim::addnotetrack_customfunction("slot_4", "mp_infil_umike_exit_npc_step", &mp_infil_umike_exit_npc_step_sfx, "umike_infil_bravo_exit");
      scripts\common\anim::addnotetrack_customfunction("slot_5", "mp_infil_umike_exit_npc_step", &mp_infil_umike_exit_npc_step_sfx, "umike_infil_bravo_exit");
      scripts\common\anim::addnotetrack_customfunction("slot_0", "mp_infil_umike_exit_suspension_creak", &mp_infil_umike_exit_suspension_creak, "umike_infil_alpha_exit");
      scripts\common\anim::addnotetrack_customfunction("slot_1", "mp_infil_umike_exit_suspension_creak", &mp_infil_umike_exit_suspension_creak, "umike_infil_alpha_exit");
      scripts\common\anim::addnotetrack_customfunction("slot_2", "mp_infil_umike_exit_suspension_creak", &mp_infil_umike_exit_suspension_creak, "umike_infil_alpha_exit");
      scripts\common\anim::addnotetrack_customfunction("slot_3", "mp_infil_umike_exit_suspension_creak", &mp_infil_umike_exit_suspension_creak, "umike_infil_alpha_exit");
      scripts\common\anim::addnotetrack_customfunction("slot_4", "mp_infil_umike_exit_suspension_creak", &mp_infil_umike_exit_suspension_creak, "umike_infil_alpha_exit");
      scripts\common\anim::addnotetrack_customfunction("slot_5", "mp_infil_umike_exit_suspension_creak", &mp_infil_umike_exit_suspension_creak, "umike_infil_alpha_exit");
      break;
  }
}

#using_animtree("");

function script_model_alpha_anims(var_0) {
  switch (var_0) {
    case "alpha":
      level.scr_animtree["driver"] = #animtree;
      level.scr_anim["driver"]["umike_infil_alpha"] = $mp_infil_umike_driver;
      level.scr_animname["driver"]["umike_infil_alpha"] = "mp_infil_umike_driver";
      level.scr_animtree["umike"] = #animtree;
      level.scr_anim["umike"]["umike_infil_alpha"] = % mp_infil_umike_vehicle;
      level.scr_animname["umike"]["umike_infil_alpha"] = "mp_infil_umike_vehicle";
      level.scr_animtree["slot_0"] = #animtree;
      level.scr_anim["slot_0"]["umike_infil_alpha"] = % mp_infil_umike_guy0_wm;
      level.scr_animname["slot_0"]["umike_infil_alpha"] = "mp_infil_umike_guy0_wm";
      level.scr_eventanim["slot_0"]["umike_infil_alpha"] = "infil_umike_1";
      level.scr_animtree["slot_0"] = #animtree;
      level.scr_anim["slot_0"]["umike_infil_alpha_exit"] = % mp_infil_umike_guy0_exit_wm;
      level.scr_animname["slot_0"]["umike_infil_alpha_exit"] = "mp_infil_umike_guy0_exit_wm";
      level.scr_eventanim["slot_0"]["umike_infil_alpha_exit"] = "infil_umike_exit_1";
      level.scr_animtree["slot_1"] = #animtree;
      level.scr_anim["slot_1"]["umike_infil_alpha"] = % mp_infil_umike_guy1_wm;
      level.scr_animname["slot_1"]["umike_infil_alpha"] = "mp_infil_umike_guy1_wm";
      level.scr_eventanim["slot_1"]["umike_infil_alpha"] = "infil_umike_2";
      level.scr_animtree["slot_1"] = #animtree;
      level.scr_anim["slot_1"]["umike_infil_alpha_exit"] = % mp_infil_umike_guy1_exit_wm;
      level.scr_animname["slot_1"]["umike_infil_alpha_exit"] = "mp_infil_umike_guy1_exit_wm";
      level.scr_eventanim["slot_1"]["umike_infil_alpha_exit"] = "infil_umike_exit_2";
      level.scr_animtree["slot_2"] = #animtree;
      level.scr_anim["slot_2"]["umike_infil_alpha"] = % mp_infil_umike_guy2_wm;
      level.scr_animname["slot_2"]["umike_infil_alpha"] = "mp_infil_umike_guy2_wm";
      level.scr_eventanim["slot_2"]["umike_infil_alpha"] = "infil_umike_3";
      level.scr_animtree["slot_2"] = #animtree;
      level.scr_anim["slot_2"]["umike_infil_alpha_exit"] = % mp_infil_umike_guy2_exit_wm;
      level.scr_animname["slot_2"]["umike_infil_alpha_exit"] = "mp_infil_umike_guy2_exit_wm";
      level.scr_eventanim["slot_2"]["umike_infil_alpha_exit"] = "infil_umike_exit_3";
      level.scr_animtree["slot_3"] = #animtree;
      level.scr_anim["slot_3"]["umike_infil_alpha"] = % mp_infil_umike_guy3_wm;
      level.scr_animname["slot_3"]["umike_infil_alpha"] = "mp_infil_umike_guy3_wm";
      level.scr_eventanim["slot_3"]["umike_infil_alpha"] = "infil_umike_4";
      level.scr_animtree["slot_3"] = #animtree;
      level.scr_anim["slot_3"]["umike_infil_alpha_exit"] = % mp_infil_umike_guy3_exit_wm;
      level.scr_animname["slot_3"]["umike_infil_alpha_exit"] = "mp_infil_umike_guy3_exit_wm";
      level.scr_eventanim["slot_3"]["umike_infil_alpha_exit"] = "infil_umike_exit_4";
      level.scr_animtree["slot_4"] = #animtree;
      level.scr_anim["slot_4"]["umike_infil_alpha"] = % mp_infil_umike_guy4_wm;
      level.scr_animname["slot_4"]["umike_infil_alpha"] = "mp_infil_umike_guy4_wm";
      level.scr_eventanim["slot_4"]["umike_infil_alpha"] = "infil_umike_5";
      level.scr_animtree["slot_4"] = #animtree;
      level.scr_anim["slot_4"]["umike_infil_alpha_exit"] = % mp_infil_umike_guy4_exit_wm;
      level.scr_animname["slot_4"]["umike_infil_alpha_exit"] = "mp_infil_umike_guy4_exit_wm";
      level.scr_eventanim["slot_4"]["umike_infil_alpha_exit"] = "infil_umike_exit_5";
      level.scr_animtree["slot_5"] = #animtree;
      level.scr_anim["slot_5"]["umike_infil_alpha"] = % mp_infil_umike_guy5_wm;
      level.scr_animname["slot_5"]["umike_infil_alpha"] = "mp_infil_umike_guy5_wm";
      level.scr_eventanim["slot_5"]["umike_infil_alpha"] = "infil_umike_6";
      level.scr_animtree["slot_5"] = #animtree;
      level.scr_anim["slot_5"]["umike_infil_alpha_exit"] = % mp_infil_umike_guy5_exit_wm;
      level.scr_animname["slot_5"]["umike_infil_alpha_exit"] = "mp_infil_umike_guy5_exit_wm";
      level.scr_eventanim["slot_5"]["umike_infil_alpha_exit"] = "infil_umike_exit_6";
      break;
    case "bravo":
      level.scr_animtree["driver"] = #animtree;
      level.scr_anim["driver"]["umike_infil_bravo"] = % mp_infil_umike_driver;
      level.scr_animname["driver"]["umike_infil_bravo"] = "mp_infil_umike_driver";
      level.scr_animtree["umike"] = #animtree;
      level.scr_anim["umike"]["umike_infil_bravo"] = % mp_infil_umike_vehicle;
      level.scr_animname["umike"]["umike_infil_bravo"] = "mp_infil_umike_vehicle";
      level.scr_animtree["slot_0"] = #animtree;
      level.scr_anim["slot_0"]["umike_infil_bravo"] = % mp_infil_umike_guy0_wm;
      level.scr_animname["slot_0"]["umike_infil_bravo"] = "mp_infil_umike_guy0_wm";
      level.scr_eventanim["slot_0"]["umike_infil_bravo"] = "infil_umike_1";
      level.scr_animtree["slot_0"] = #animtree;
      level.scr_anim["slot_0"]["umike_infil_bravo_exit"] = % mp_infil_umike_guy0_exit_wm;
      level.scr_animname["slot_0"]["umike_infil_bravo_exit"] = "mp_infil_umike_guy0_exit_wm";
      level.scr_eventanim["slot_0"]["umike_infil_bravo_exit"] = "infil_umike_exit_1";
      level.scr_animtree["slot_1"] = #animtree;
      level.scr_anim["slot_1"]["umike_infil_bravo"] = % mp_infil_umike_guy1_wm;
      level.scr_animname["slot_1"]["umike_infil_bravo"] = "mp_infil_umike_guy1_wm";
      level.scr_eventanim["slot_1"]["umike_infil_bravo"] = "infil_umike_2";
      level.scr_animtree["slot_1"] = #animtree;
      level.scr_anim["slot_1"]["umike_infil_bravo_exit"] = % mp_infil_umike_guy1_exit_wm;
      level.scr_animname["slot_1"]["umike_infil_bravo_exit"] = "mp_infil_umike_guy1_exit_wm";
      level.scr_eventanim["slot_1"]["umike_infil_bravo_exit"] = "infil_umike_exit_2";
      level.scr_animtree["slot_2"] = #animtree;
      level.scr_anim["slot_2"]["umike_infil_bravo"] = % mp_infil_umike_guy2_wm;
      level.scr_animname["slot_2"]["umike_infil_bravo"] = "mp_infil_umike_guy2_wm";
      level.scr_eventanim["slot_2"]["umike_infil_bravo"] = "infil_umike_3";
      level.scr_animtree["slot_2"] = #animtree;
      level.scr_anim["slot_2"]["umike_infil_bravo_exit"] = % mp_infil_umike_guy2_exit_wm;
      level.scr_animname["slot_2"]["umike_infil_bravo_exit"] = "mp_infil_umike_guy2_exit_wm";
      level.scr_eventanim["slot_2"]["umike_infil_bravo_exit"] = "infil_umike_exit_3";
      level.scr_animtree["slot_3"] = #animtree;
      level.scr_anim["slot_3"]["umike_infil_bravo"] = % mp_infil_umike_guy3_wm;
      level.scr_animname["slot_3"]["umike_infil_bravo"] = "mp_infil_umike_guy3_wm";
      level.scr_eventanim["slot_3"]["umike_infil_bravo"] = "infil_umike_4";
      level.scr_animtree["slot_3"] = #animtree;
      level.scr_anim["slot_3"]["umike_infil_bravo_exit"] = % mp_infil_umike_guy3_exit_wm;
      level.scr_animname["slot_3"]["umike_infil_bravo_exit"] = "mp_infil_umike_guy3_exit_wm";
      level.scr_eventanim["slot_3"]["umike_infil_bravo_exit"] = "infil_umike_exit_4";
      level.scr_animtree["slot_4"] = #animtree;
      level.scr_anim["slot_4"]["umike_infil_bravo"] = % mp_infil_umike_guy4_wm;
      level.scr_animname["slot_4"]["umike_infil_bravo"] = "mp_infil_umike_guy4_wm";
      level.scr_eventanim["slot_4"]["umike_infil_bravo"] = "infil_umike_5";
      level.scr_animtree["slot_4"] = #animtree;
      level.scr_anim["slot_4"]["umike_infil_bravo_exit"] = % mp_infil_umike_guy4_exit_wm;
      level.scr_animname["slot_4"]["umike_infil_bravo_exit"] = "mp_infil_umike_guy4_exit_wm";
      level.scr_eventanim["slot_4"]["umike_infil_bravo_exit"] = "infil_umike_exit_5";
      level.scr_animtree["slot_5"] = #animtree;
      level.scr_anim["slot_5"]["umike_infil_bravo"] = % mp_infil_umike_guy5_wm;
      level.scr_animname["slot_5"]["umike_infil_bravo"] = "mp_infil_umike_guy5_wm";
      level.scr_eventanim["slot_5"]["umike_infil_bravo"] = "infil_umike_6";
      level.scr_animtree["slot_5"] = #animtree;
      level.scr_anim["slot_5"]["umike_infil_bravo_exit"] = % mp_infil_umike_guy5_exit_wm;
      level.scr_animname["slot_5"]["umike_infil_bravo_exit"] = "mp_infil_umike_guy5_exit_wm";
      level.scr_eventanim["slot_5"]["umike_infil_bravo_exit"] = "infil_umike_exit_6";
      break;
  }
}

function vehicles_alpha_anims(var_0) {
  switch (var_0) {
    case "alpha":
      level.scr_animtree["umikeVeh"] = #animtree;
      level.scr_anim["umikeVeh"]["umike_infil_alpha_path"] = $mp_infil_umike_vehicle_tailgate;
      break;
    case "bravo":
      level.scr_animtree["umikeVeh"] = #animtree;
      level.scr_anim["umikeVeh"]["umike_infil_bravo_path"] = % mp_infil_umike_vehicle_tailgate;
      break;
  }
}

function commander_play_sound_func(var_0, var_1, var_2) {
  foreach(var_4 in self.infil.players) {
    self playsoundtoplayer(var_0, var_4);
  }
}

function mp_infil_umike_exit_jump_land_sfx(var_0) {
  var_0 playsoundonmovingent("mp_infil_umike_exit_jump_land");
}

function mp_infil_umike_exit_npc_step_sfx(var_0) {
  if(isPlayer(var_0)) {
    var_0 playlocalsound("mp_infil_umike_exit_plr_step");
    return;
  }

  var_0 playsoundonmovingent("mp_infil_umike_exit_npc_step");
}

function mp_infil_umike_exit_suspension_creak(var_0) {
  if(isDefined(var_0.animname)) {
    var_1 = "mp_infil_umike_exit_suspension_creak_" + var_0.animname;
  } else {
    var_1 = "mp_infil_umike_exit_suspension_creak_slot_0";
  }

  var_1 playsoundonmovingent(var_1);
}

function umike_cam_shake_ground(var_0) {
  var_1 = var_0.player;
  var_1 notify("stop_cam_shake");
  var_1 playrumbleonpositionforclient("ground_pound_land", var_1.origin);
  var_1 setscriptablepartstate("wind", "0", 0);
}

function giveinteractiveinfilweapon() {
  var_0 = getcompleteweaponname("iw8_sn_alpha50infil_mp", ["rec_alpha50", "front_alpha50", "back_alpha50", "mag_alpha50", "acog_alpha50", "gunperk_adsup"]);
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
  self endon("player_free_spot");
  thread ineractivecombatmessaging();
  wait level.interactiveinfilstart;
  self.interactivecombat = 1;
  scripts\common\utility::allow_fire(1);
  scripts\common\utility::allow_ads(1);
  scripts\common\utility::allow_reload(1);
  self setdemeanorviewmodel("normal");
  self lerpfovbypreset("default_2seconds");
  wait level.interactiveinfilwindow;
  self.interactivecombat = 0;
  scripts\common\utility::allow_fire(0);
  scripts\common\utility::allow_ads(0);
  scripts\common\utility::allow_reload(0);
  scripts\mp\utility\weapon::setrecoilscale();
  self setdemeanorviewmodel("safe", "ges_demeanor_safe_heli");
}

function ineractivecombatmessaging() {
  self endon("player_free_spot");
  wait 0.25;
  self iprintlnbold("Enemy scouts spotted!");
  wait 1.25;

  switch (self.animname) {
    case "slot_0":
      self iprintlnbold("Near the river! Behind us!");
      break;
    case "slot_1":
      self iprintlnbold("Near the trees! Behind us!");
      break;
    default:
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

  foreach(var_2 in level.infiltargets["axis"]) {
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

  if(istrue(self.isbonus)) {
    self setscriptablepartstate("base", "hide");
    return;
  }

  self suicide();
}

function getcommanderassets(var_0) {
  var_1 = spawnStruct();
  var_1.body = "body_mp_helicopter_crew";
  var_1.head = "head_mp_helicopter_crew";

  switch (level.mapname) {
    case "mp_raid":
      if(var_0 == "allies") {
        var_1.body = "body_hero_price_woodland";
        var_1.head = "head_sc_m_green";
      } else {
        var_1.body = "body_spetsnaz_cqc";
        var_1.head = "head_sc_m_androsov";
      }

      break;
    case "mp_cave_am":
    case "mp_cave":
      if(var_0 == "allies") {
        var_1.body = "body_usmc_basic_ar_4";
        var_1.head = "head_sc_m_valladares";
      } else {
        var_1.body = "body_al_qatala_desert_06";
        var_1.head = "head_sc_m_alai";
      }

      break;
  }

  return var_1;
}

function getdriverassets(var_0) {
  var_1 = spawnStruct();
  var_1.body = "body_mp_western_fireteam_west_smg_1_1";
  var_1.head = "head_mp_western_fireteam_west_smg_2_1";

  switch (level.mapname) {
    default:
      if(var_0 == "allies") {
        var_1.body = "body_mp_western_fireteam_west_smg_1_1";
        var_1.head = "head_mp_western_fireteam_west_smg_2_1";
      } else {
        var_1.body = "body_mp_eastern_fireteam_east_sg_no_sling";
        var_1.head = "head_me_eastern_fireteam_east_smg_3";
      }

      break;
  }

  return var_1;
}

function reducewind(var_0) {
  var_1 = var_0.player;
  var_1 setscriptablepartstate("wind", "10", 0);
}