/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\_load.gsc
**************************************/

main() {
  if(isDefined(level._id_0674)) {
    return;
  }
  level._id_0674 = 1;
  level.virtuallobbyactive = getdvarint("4017", 0);
  level._id_6508 = issubstr(maps\mp\_utility::getmapname(), "mp_hub_");
  level._id_53C7 = level.gametype == "scorestreak_training";
  level._id_53C6 = maps\mp\_utility::getmapname() == "mp_scorestreak_training";
  maps\mp\_utility::set_console_status();
  level.createfx_enabled = getDvar("createfx") != "";
  common_scripts\utility::_id_947B();
  maps\mp\_utility::initgameflags();
  maps\mp\_utility::initlevelflags();
  level.generic_index = 0;
  level.flag_struct = spawnStruct();
  level.flag_struct common_scripts\utility::assign_unique_id();

  if(!isDefined(level.flag)) {
    level.flag = [];
    level.flags_lock = [];
  }

  level.requiredmapaspectratio = getdvarfloat("scr_RequiredMapAspectratio", 1);
  level.createclientfontstring_func = maps\mp\gametypes\_hud_util::createfontstring;
  level.hudsetpoint_func = maps\mp\gametypes\_hud_util::setpoint;
  level.leaderdialogonplayer_func = maps\mp\_utility::leaderdialogonplayer;
  thread _id_0511::init();

  if(!isDefined(level.func)) {
    level.func = [];
  }

  level.func["precacheMpAnim"] = ::_precachempanim;
  level.func["scriptModelPlayAnim"] = ::scriptmodelplayanim;
  level.func["scriptModelClearAnim"] = ::scriptmodelclearanim;

  if(!level.createfx_enabled) {
    thread _id_0488::init();
    thread _id_048C::main();
    thread _id_0476::init();
    thread _id_0288::init();
    thread _id_0478::init();
    thread _id_0286::init();
  }

  game["thermal_vision"] = "default";
  _visionsetnaked("", 0);
  _visionsetnight("default_night_mp");
  _visionsetthermal(game["thermal_vision"]);

  if(isDefined(level.iszombiegame) && level.iszombiegame) {
    _visionsetpain("near_death_hdr_zm", 0);
  } else {
    _visionsetmissilecam("orbital_strike");
    _visionsetpain("near_death_hdr", 0);
  }

  var_0 = getEntArray("lantern_glowFX_origin", "targetname");

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    var_0[var_1] thread lanterns();
  }

  _id_0378::_id_8D89();
  _id_046C::init_audio();
  _id_046B::main();
  setupexploders();
  thread common_scripts\_fx::initfx();

  if(level.createfx_enabled) {
    _id_050D::setmapcenterfordev();
    _id_0473::createfx();
  }

  if(getDvar("r_reflectionProbeGenerate") == "1") {
    deleteduringreflectionprobegeneration();
    _id_050D::setmapcenterfordev();
    _id_0480::main();
    level waittill("eternity");
  }

  thread _id_0480::main();

  for(var_2 = 0; var_2 < 6; var_2++) {
    switch (var_2) {
      case 0:
        var_3 = "trigger_multiple";
        break;
      case 1:
        var_3 = "trigger_once";
        break;
      case 2:
        var_3 = "trigger_use";
        break;
      case 3:
        var_3 = "trigger_radius";
        break;
      case 4:
        var_3 = "trigger_lookat";
        break;
      default:
        var_3 = "trigger_damage";
        break;
    }

    var_4 = getEntArray(var_3, "classname");

    for(var_1 = 0; var_1 < var_4.size; var_1++) {
      if(isDefined(var_4[var_1].physicslaunchserver)) {
        var_4[var_1].setdepthoffield = var_4[var_1].physicslaunchserver;
      }

      if(isDefined(var_4[var_1].setdepthoffield)) {
        level thread exploder_load(var_4[var_1]);
      }
    }
  }

  var_5 = getEntArray("trigger_hurt", "classname");

  foreach(var_7 in var_5) {
    var_7 thread hurtplayersthink();
  }

  level._id_6246 = getEntArray("trigger_multiple_missile_dud", "classname");
  thread _id_0469::main();
  _id_527B();
  level.func["damagefeedback"] = _id_04C7::updatedamagefeedback;
  level.func["setTeamHeadIcon"] = _id_0479::setteamheadicon;
  level.laseron_func = ::laseron;
  level.laseroff_func = ::laseroff;
  level.connectpathsfunction = ::connectpaths;
  level.disconnectpathsfunction = ::disconnectpaths;
  disablephysicaldepthoffieldscripting();
  _id_8A15();
  level.fauxvehiclecount = 0;
  setDvar("bot_FlightDynamicsModeEnabled", 0);
  load_costume_indices();
}

set_turret_hand_ik(var_0, var_1, var_2) {
  level endon("game_ended");
  var_0 endon("disconnect");
  self endon("quit_hand_ik");
  wait 0.5;

  if(isDefined(var_0) && _func_389(var_0)) {
    if(var_1) {
      var_0 _meth_8572(self, "TAG_IK_LOC_LE");
    }

    if(var_2) {
      var_0 _meth_8574(self, "TAG_IK_LOC_RI");
    }

    self.prevowner = var_0;
  }
}

_id_A8E7() {
  level endon("game_ended");
  var_0 = self gettagindex("TAG_IK_LOC_LE") != -1;
  var_1 = self gettagindex("TAG_IK_LOC_RI") != -1;

  if(!var_0 && !var_1) {
    return;
  }
  self.prevowner = undefined;

  for(;;) {
    self waittill("turretownerchange", var_2);
    self notify("quit_hand_ik");

    if(isDefined(self.prevowner) && _func_389(self.prevowner)) {
      self.prevowner _meth_8573();
      self.prevowner set_rumble_intensity();
    }

    self.prevowner = undefined;

    if(isDefined(var_2) && _func_389(var_2)) {
      thread set_turret_hand_ik(var_2, var_0, var_1);
    }
  }
}

_id_527B() {
  var_0 = getEntArray("misc_turret", "classname");

  foreach(var_2 in var_0) {
    var_2 thread _id_A8E7();
  }
}

disablephysicaldepthoffieldscripting() {
  setDvar("sm_spotLightScoreModelScale", 0.1);
  setDvar("sm_spotShadowFadeTime", 0.2);
  setDvar("5800", 0);
  setDvar("1963", 0);
  setDvar("r_lightGridEnableTweaks", 0);
  setDvar("r_lightGridIntensity", 1);
  setDvar("r_lightGridContrast", 0);
  setDvar("r_uiBlurDstMode", 0);
  setDvar("r_blurdstGaussianBlurRadius", 1);
  setDvar("r_gpuTriangleDepthFiltering", 1);
}

exploder_load(var_0) {
  level endon("killexplodertridgers" + var_0.setdepthoffield);
  var_0 waittill("trigger");

  if(isDefined(var_0.isindoor) && _randomfloat(1) > var_0.isindoor) {
    if(isDefined(var_0.script_delay)) {
      wait(var_0.script_delay);
    } else {
      wait 4;
    }

    level thread exploder_load(var_0);
    return;
  }

  common_scripts\_exploder::exploder(var_0.setdepthoffield);
  level notify("killexplodertridgers" + var_0.setdepthoffield);
}

setupexploders() {
  var_0 = getEntArray("script_brushmodel", "classname");
  var_1 = getEntArray("script_model", "classname");

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    var_0[var_0.size] = var_1[var_2];
  }

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    if(isDefined(var_0[var_2].physicslaunchserver)) {
      var_0[var_2].setdepthoffield = var_0[var_2].physicslaunchserver;
    }

    if(isDefined(var_0[var_2].setdepthoffield)) {
      if(var_0[var_2].model == "fx" && (!isDefined(var_0[var_2].targetname) || var_0[var_2].targetname != "exploderchunk")) {
        var_0[var_2] hide();
        continue;
      }

      if(isDefined(var_0[var_2].targetname) && var_0[var_2].targetname == "exploder") {
        var_0[var_2] hide();
        var_0[var_2] notsolid();
        continue;
      }

      if(isDefined(var_0[var_2].targetname) && var_0[var_2].targetname == "exploderchunk") {
        var_0[var_2] hide();
        var_0[var_2] notsolid();
      }
    }
  }

  var_3 = [];
  var_4 = getEntArray("script_brushmodel", "classname");

  for(var_2 = 0; var_2 < var_4.size; var_2++) {
    if(isDefined(var_4[var_2].physicslaunchserver)) {
      var_4[var_2].setdepthoffield = var_4[var_2].physicslaunchserver;
    }

    if(isDefined(var_4[var_2].setdepthoffield)) {
      var_3[var_3.size] = var_4[var_2];
    }
  }

  var_4 = getEntArray("script_model", "classname");

  for(var_2 = 0; var_2 < var_4.size; var_2++) {
    if(isDefined(var_4[var_2].physicslaunchserver)) {
      var_4[var_2].setdepthoffield = var_4[var_2].physicslaunchserver;
    }

    if(isDefined(var_4[var_2].setdepthoffield)) {
      var_3[var_3.size] = var_4[var_2];
    }
  }

  var_4 = getEntArray("item_health", "classname");

  for(var_2 = 0; var_2 < var_4.size; var_2++) {
    if(isDefined(var_4[var_2].physicslaunchserver)) {
      var_4[var_2].setdepthoffield = var_4[var_2].physicslaunchserver;
    }

    if(isDefined(var_4[var_2].setdepthoffield)) {
      var_3[var_3.size] = var_4[var_2];
    }
  }

  if(!isDefined(level.createfxent)) {
    level.createfxent = [];
  }

  var_5 = [];
  var_5["exploderchunk visible"] = 1;
  var_5["exploderchunk"] = 1;
  var_5["exploder"] = 1;

  for(var_2 = 0; var_2 < var_3.size; var_2++) {
    var_6 = var_3[var_2];
    var_7 = common_scripts\utility::createexploder(var_6.script_fxid);
    var_7.v = [];
    var_7.v["origin"] = var_6.origin;
    var_7.v["angles"] = var_6.angles;
    var_7.v["delay"] = var_6.script_delay;
    var_7.v["firefx"] = var_6.getturret;
    var_7.v["firefxdelay"] = var_6.getgroundenttype;
    var_7.v["firefxsound"] = var_6.animcustom;
    var_7.v["firefxtimeout"] = var_6.isinscriptedstate;
    var_7.v["earthquake"] = var_6.script_earthquake;
    var_7.v["damage"] = var_6.setanim;
    var_7.v["damage_radius"] = var_6.scriptmodelplayanim;
    var_7.v["soundalias"] = var_6.vehicle_getsteering;
    var_7.v["repeat"] = var_6.scriptmodelplayanimdeltamotion;
    var_7.v["delay_min"] = var_6.script_delay_min;
    var_7.v["delay_max"] = var_6.setbottomarc;
    var_7.v["target"] = var_6.target;
    var_7.v["ender"] = var_6.itemweaponsetammo;
    var_7.v["type"] = "exploder";

    if(isDefined(var_6.model)) {
      var_7.v["radiant"] = 1;
    }

    if(!isDefined(var_6.script_fxid)) {
      var_7.v["fxid"] = "No FX";
    } else {
      var_7.v["fxid"] = var_6.script_fxid;
    }

    var_7.v["exploder"] = var_6.setdepthoffield;

    if(!isDefined(var_7.v["delay"])) {
      var_7.v["delay"] = 0;
    }

    if(isDefined(var_6.target)) {
      var_8 = getEntArray(var_7.v["target"], "targetname")[0];

      if(isDefined(var_8)) {
        var_9 = var_8.origin;
        var_7.v["angles"] = vectortoangles(var_9 - var_7.v["origin"]);
      } else {
        var_8 = common_scripts\utility::get_target_ent(var_7.v["target"]);

        if(isDefined(var_8)) {
          var_9 = var_8.origin;
          var_7.v["angles"] = vectortoangles(var_9 - var_7.v["origin"]);
        }
      }
    }

    if(var_6.classname == "script_brushmodel" || isDefined(var_6.model)) {
      var_7.model = var_6;
      var_7.model.disconnect_paths = var_6.clearpotentialthreat;
    }

    if(isDefined(var_6.targetname) && isDefined(var_5[var_6.targetname])) {
      var_7.v["exploder_type"] = var_6.targetname;
    } else {
      var_7.v["exploder_type"] = "normal";
    }

    var_7 common_scripts\_createfx::post_entity_creation_function();
  }
}

lanterns() {
  common_scripts\_fx::loopfx("lantern_light", self.origin, 0.3, self.origin + (0, 0, 1));
}

hurtplayersthink() {
  level endon("game_ended");
  wait(_randomfloat(1.0));

  for(;;) {
    foreach(var_1 in level.players) {
      if(var_1 istouching(self) && maps\mp\_utility::isreallyalive(var_1)) {
        var_1 maps\mp\_utility::_suicide();
      }
    }

    wait 0.5;
  }
}

_id_8A15() {
  var_0 = getEntArray("destructible_vehicle", "targetname");

  foreach(var_2 in var_0) {
    switch (getDvar("mapname")) {
      case "mp_interchange":
        if(var_2.origin[2] > 150.0) {
          continue;
        }
        break;
    }

    var_3 = var_2.origin + (0, 0, 5);
    var_4 = var_2.origin + (0, 0, 128);
    var_5 = bulletTrace(var_3, var_4, 0, var_2);
    var_2.killcament = spawn("script_model", var_5["position"]);
    var_2.killcament.targetname = "killCamEnt_destructible_vehicle";
    var_2.killcament setscriptmoverkillcam("explosive");
    var_2 thread deletedestructiblekillcament();
  }

  var_7 = getEntArray("destructible_toy", "targetname");

  foreach(var_2 in var_7) {
    var_3 = var_2.origin + (0, 0, 5);
    var_4 = var_2.origin + (0, 0, 128);
    var_5 = bulletTrace(var_3, var_4, 0, var_2);
    var_2.killcament = spawn("script_model", var_5["position"]);
    var_2.killcament.targetname = "killCamEnt_destructible_toy";
    var_2.killcament setscriptmoverkillcam("explosive");
    var_2 thread deletedestructiblekillcament();
  }

  var_10 = getEntArray("explodable_barrel", "targetname");

  foreach(var_2 in var_10) {
    var_3 = var_2.origin + (0, 0, 5);
    var_4 = var_2.origin + (0, 0, 128);
    var_5 = bulletTrace(var_3, var_4, 0, var_2);
    var_2.killcament = spawn("script_model", var_5["position"]);
    var_2.killcament.targetname = "killCamEnt_explodable_barrel";
    var_2.killcament setscriptmoverkillcam("explosive");
    var_2 thread deletedestructiblekillcament();
  }
}

deletedestructiblekillcament() {
  level endon("game_ended");
  var_0 = self.killcament;
  var_0 endon("death");
  self waittill("death");
  wait 10;

  if(isDefined(var_0)) {
    var_0 delete();
  }
}

deleteduringreflectionprobegeneration() {
  var_0 = getEntArray("hp_zone_center", "targetname");

  foreach(var_2 in var_0) {
    if(isDefined(var_2.target)) {
      var_3 = getEntArray(var_2.target, "targetname");

      foreach(var_5 in var_3) {
        var_5 delete();
      }
    }
  }

  var_8 = getEntArray("orbital_bad_spawn_overlay", "targetname");

  foreach(var_10 in var_8) {
    var_10 delete();
  }
}

load_costume_indices() {
  if(isDefined(level.costumecategories)) {
    return;
  }
  level.costumecategories = ["shirt", "head", "pants", "gear", "hat", "eyewear"];
  level.costumecat2idx = [];

  for(var_0 = 0; var_0 < level.costumecategories.size; var_0++) {
    var_1 = level.costumecategories[var_0];
    level.costumecat2idx[var_1] = var_0;
  }

  level.costumetypehexids = [];
  level.costumetypehexids["shirt"] = "0x62";
  level.costumetypehexids["head"] = "0x63";
  level.costumetypehexids["pants"] = "0x64";
  level.costumetypehexids["gear"] = "0x67";
  level.costumetypehexids["hat"] = "0x66";
  level.costumetypehexids["eyewear"] = "0x6c";
}