/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\mp\_load.gsc
********************************/

main() {
  if(isdefined(level._loadstarted)) {
    return;
  }
  level._loadstarted = 1;
  level.virtuallobbyactive = getdvarint("virtualLobbyActive", 0);
  maps\mp\_utility::set_console_status();
  level.createfx_enabled = getdvar("createfx") != "";
  common_scripts\utility::struct_class_init();
  maps\mp\_utility::initgameflags();
  maps\mp\_utility::initlevelflags();
  maps\mp\_utility::initglobals();
  level.generic_index = 0;
  level.flag_struct = spawnstruct();
  level.flag_struct common_scripts\utility::assign_unique_id();

  if(!isdefined(level.flag)) {
    level.flag = [];
    level.flags_lock = [];
  }

  level.requiredmapaspectratio = getdvarfloat("scr_RequiredMapAspectratio", 1);
  level.createclientfontstring_func = maps\mp\gametypes\_hud_util::createfontstring;
  level.hudsetpoint_func = maps\mp\gametypes\_hud_util::setpoint;
  level.leaderdialogonplayer_func = maps\mp\_utility::leaderdialogonplayer;
  thread maps\mp\gametypes\_tweakables::init();

  if(!isdefined(level.func))
    level.func = [];

  level.func["precacheMpAnim"] = ::precachempanim;
  level.func["scriptModelPlayAnim"] = ::scriptmodelplayanim;
  level.func["scriptModelClearAnim"] = ::scriptmodelclearanim;

  if(!level.createfx_enabled) {
    thread maps\mp\_movers::init();
    thread maps\mp\_shutter::main();
    thread maps\mp\_destructables::init();
    thread common_scripts\_elevator::init();
  }

  game["thermal_vision"] = "default";
  visionsetnaked("", 0);
  visionsetnight("default_night_mp");
  visionsetthermal(game["thermal_vision"]);
  visionsetpain("near_death_mp", 0);
  var_0 = getentarray("lantern_glowFX_origin", "targetname");

  for (var_1 = 0; var_1 < var_0.size; var_1++)
    var_0[var_1] thread lanterns();

  maps\mp\_audio::init_audio();
  maps\mp\_art::main();
  setupexploders();
  thread common_scripts\_fx::initfx();

  if(level.createfx_enabled) {
    maps\mp\gametypes\_spawnlogic::setmapcenterfordev();
    maps\mp\_createfx::createfx();
  }

  if(getdvar("r_reflectionProbeGenerate") == "1") {
    deleteduringreflectionprobegeneration();
    maps\mp\gametypes\_spawnlogic::setmapcenterfordev();
    maps\mp\_global_fx::main();
    level waittill("eternity");
  }

  thread maps\mp\_global_fx::main();

  for (var_2 = 0; var_2 < 6; var_2++) {
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

    var_4 = getentarray(var_3, "classname");

    for (var_1 = 0; var_1 < var_4.size; var_1++) {
      if(isdefined(var_4[var_1].script_prefab_exploder))
        var_4[var_1].script_exploder = var_4[var_1].script_prefab_exploder;

      if(isdefined(var_4[var_1].script_exploder))
        level thread exploder_load(var_4[var_1]);
    }
  }

  var_5 = getentarray("trigger_hurt", "classname");

  foreach(var_7 in var_5)
  var_7 thread hurtplayersthink();

  level.func["damagefeedback"] = maps\mp\gametypes\_damagefeedback::updatedamagefeedback;
  level.func["setTeamHeadIcon"] = maps\mp\_entityheadicons::setteamheadicon;
  level.laseron_func = ::laseron;
  level.laseroff_func = ::laseroff;
  level.connectpathsfunction = ::connectpaths;
  level.disconnectpathsfunction = ::disconnectpaths;
  setdvar("sm_spotLightScoreModelScale", 0.1);
  setdvar("sm_spotShadowFadeTime", 1.0);
  setdvar("r_specularcolorscale", 2.5);
  setdvar("r_diffusecolorscale", 1);
  setdvar("r_lightGridEnableTweaks", 0);
  setdvar("r_lightGridIntensity", 1);
  setdvar("r_lightGridContrast", 0);
  setdvar("r_dof_physical_enable", 1);
  setdvar("r_volumeLightScatter", 0);
  setdvar("r_uiblurdstmode", 0);
  setdvar("r_blurdstgaussianblurradius", 1);
  setdvar("r_dof_physical_bokehEnable", 0);

  if(level.nextgen)
    setdvar("sm_polygonOffsetPreset", 0);

  setupdestructiblekillcaments();
  watchfordestructiblevehicles();

  if(level.virtuallobbyactive == 0 && !(isdefined(level.iszombiegame) && level.iszombiegame))
    precacheitem("bomb_site_mp");

  level.fauxvehiclecount = 0;
  load_costume_indices();
}

exploder_load(var_0) {
  level endon("killexplodertridgers" + var_0.script_exploder);
  var_0 waittill("trigger");

  if(isdefined(var_0.script_chance) && randomfloat(1) > var_0.script_chance) {
    if(isdefined(var_0.script_delay))
      wait(var_0.script_delay);
    else
      wait 4;

    level thread exploder_load(var_0);
    return;
  }

  common_scripts\_exploder::exploder(var_0.script_exploder);
  level notify("killexplodertridgers" + var_0.script_exploder);
}

setupexploders() {
  var_0 = getentarray("script_brushmodel", "classname");
  var_1 = getentarray("script_model", "classname");

  for (var_2 = 0; var_2 < var_1.size; var_2++)
    var_0[var_0.size] = var_1[var_2];

  for (var_2 = 0; var_2 < var_0.size; var_2++) {
    if(isdefined(var_0[var_2].script_prefab_exploder))
      var_0[var_2].script_exploder = var_0[var_2].script_prefab_exploder;

    if(isdefined(var_0[var_2].script_exploder)) {
      if(var_0[var_2].model == "fx" && (!isdefined(var_0[var_2].targetname) || var_0[var_2].targetname != "exploderchunk")) {
        var_0[var_2] hide();
        continue;
      }

      if(isdefined(var_0[var_2].targetname) && var_0[var_2].targetname == "exploder") {
        var_0[var_2] hide();
        var_0[var_2] notsolid();
        continue;
      }

      if(isdefined(var_0[var_2].targetname) && var_0[var_2].targetname == "exploderchunk") {
        var_0[var_2] hide();
        var_0[var_2] notsolid();
      }
    }
  }

  var_3 = [];
  var_4 = getentarray("script_brushmodel", "classname");

  for (var_2 = 0; var_2 < var_4.size; var_2++) {
    if(isdefined(var_4[var_2].script_prefab_exploder))
      var_4[var_2].script_exploder = var_4[var_2].script_prefab_exploder;

    if(isdefined(var_4[var_2].script_exploder))
      var_3[var_3.size] = var_4[var_2];
  }

  var_4 = getentarray("script_model", "classname");

  for (var_2 = 0; var_2 < var_4.size; var_2++) {
    if(isdefined(var_4[var_2].script_prefab_exploder))
      var_4[var_2].script_exploder = var_4[var_2].script_prefab_exploder;

    if(isdefined(var_4[var_2].script_exploder))
      var_3[var_3.size] = var_4[var_2];
  }

  var_4 = getentarray("item_health", "classname");

  for (var_2 = 0; var_2 < var_4.size; var_2++) {
    if(isdefined(var_4[var_2].script_prefab_exploder))
      var_4[var_2].script_exploder = var_4[var_2].script_prefab_exploder;

    if(isdefined(var_4[var_2].script_exploder))
      var_3[var_3.size] = var_4[var_2];
  }

  if(!isdefined(level.createfxent))
    level.createfxent = [];

  var_5 = [];
  var_5["exploderchunk visible"] = 1;
  var_5["exploderchunk"] = 1;
  var_5["exploder"] = 1;

  for (var_2 = 0; var_2 < var_3.size; var_2++) {
    var_6 = var_3[var_2];
    var_7 = common_scripts\utility::createexploder(var_6.script_fxid);
    var_7.v = [];
    var_7.v["origin"] = var_6.origin;
    var_7.v["angles"] = var_6.angles;
    var_7.v["delay"] = var_6.script_delay;
    var_7.v["firefx"] = var_6.script_firefx;
    var_7.v["firefxdelay"] = var_6.script_firefxdelay;
    var_7.v["firefxsound"] = var_6.script_firefxsound;
    var_7.v["firefxtimeout"] = var_6.script_firefxtimeout;
    var_7.v["earthquake"] = var_6.script_earthquake;
    var_7.v["damage"] = var_6.script_damage;
    var_7.v["damage_radius"] = var_6.script_radius;
    var_7.v["soundalias"] = var_6.script_soundalias;
    var_7.v["repeat"] = var_6.script_repeat;
    var_7.v["delay_min"] = var_6.script_delay_min;
    var_7.v["delay_max"] = var_6.script_delay_max;
    var_7.v["target"] = var_6.target;
    var_7.v["ender"] = var_6.script_ender;
    var_7.v["type"] = "exploder";

    if(!isdefined(var_6.script_fxid))
      var_7.v["fxid"] = "No FX";
    else
      var_7.v["fxid"] = var_6.script_fxid;

    var_7.v["exploder"] = var_6.script_exploder;

    if(!isdefined(var_7.v["delay"]))
      var_7.v["delay"] = 0;

    if(isdefined(var_6.target)) {
      var_8 = getentarray(var_7.v["target"], "targetname")[0];

      if(isdefined(var_8)) {
        var_9 = var_8.origin;
        var_7.v["angles"] = vectortoangles(var_9 - var_7.v["origin"]);
      } else {
        var_8 = common_scripts\utility::get_target_ent(var_7.v["target"]);

        if(isdefined(var_8)) {
          var_9 = var_8.origin;
          var_7.v["angles"] = vectortoangles(var_9 - var_7.v["origin"]);
        }
      }
    }

    if(var_6.classname == "script_brushmodel" || isdefined(var_6.model)) {
      var_7.model = var_6;
      var_7.model.disconnect_paths = var_6.script_disconnectpaths;
    }

    if(isdefined(var_6.targetname) && isdefined(var_5[var_6.targetname]))
      var_7.v["exploder_type"] = var_6.targetname;
    else
      var_7.v["exploder_type"] = "normal";

    var_7 common_scripts\_createfx::post_entity_creation_function();
  }
}

lanterns() {
  common_scripts\_fx::loopfx("lantern_light", self.origin, 0.3, self.origin + (0, 0, 1));
}

hurtplayersthink() {
  level endon("game_ended");
  wait(randomfloat(1.0));

  for (;;) {
    foreach(var_1 in level.players) {
      if(var_1 istouching(self) && maps\mp\_utility::isreallyalive(var_1))
        var_1 maps\mp\_utility::_suicide();
    }

    wait 0.5;
  }
}

setupdestructiblekillcaments() {
  var_0 = getentarray("destructible_vehicle", "targetname");

  foreach(var_2 in var_0) {
    switch (getdvar("mapname")) {
      case "mp_interchange":
        if(var_2.origin[2] > 150.0) {
          continue;
        }
        break;
    }

    var_3 = var_2.origin + (0, 0, 5);
    var_4 = var_2.origin + (0, 0, 128);
    var_5 = bullettrace(var_3, var_4, 0, var_2);
    var_2.killcament = spawn("script_model", var_5["position"]);
    var_2.killcament.targetname = "killCamEnt_destructible_vehicle";
    var_2.killcament setscriptmoverkillcam("explosive");
    var_2 thread deletedestructiblekillcament();
  }

  var_7 = getentarray("destructible_toy", "targetname");

  foreach(var_2 in var_7) {
    var_3 = var_2.origin + (0, 0, 5);
    var_4 = var_2.origin + (0, 0, 128);
    var_5 = bullettrace(var_3, var_4, 0, var_2);
    var_2.killcament = spawn("script_model", var_5["position"]);
    var_2.killcament.targetname = "killCamEnt_destructible_toy";
    var_2.killcament setscriptmoverkillcam("explosive");
    var_2 thread deletedestructiblekillcament();
  }

  var_10 = getentarray("explodable_barrel", "targetname");

  foreach(var_2 in var_10) {
    var_3 = var_2.origin + (0, 0, 5);
    var_4 = var_2.origin + (0, 0, 128);
    var_5 = bullettrace(var_3, var_4, 0, var_2);
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

  if(isdefined(var_0))
    var_0 delete();
}

watchfordestructiblevehicles() {
  var_0 = getscriptablearray();

  foreach(var_2 in var_0) {
    var_3 = var_2 getscriptabletypeforentity();

    if(issubstr(var_3, "destpv_"))
      var_2 thread destructiblevehiclewatch();
  }
}

destructiblevehiclewatch() {
  self endon("death");
  self waittill("explode", var_0);

  if(isdefined(var_0) && var_0 != self)
    var_0 notify("destroyed_car");
}

deleteduringreflectionprobegeneration() {
  var_0 = getentarray("boost_jump_border", "targetname");

  foreach(var_2 in var_0)
  var_2 delete();

  var_0 = getentarray("mp_recovery_signage", "targetname");

  foreach(var_2 in var_0)
  var_2 delete();

  var_6 = getentarray("horde_dome", "targetname");

  foreach(var_8 in var_6)
  var_8 delete();

  var_10 = getentarray("hp_zone_center", "targetname");

  foreach(var_12 in var_10) {
    if(isdefined(var_12.target)) {
      var_0 = getentarray(var_12.target, "targetname");

      foreach(var_2 in var_0)
      var_2 delete();
    }
  }

  var_16 = getentarray("orbital_bad_spawn_overlay", "targetname");

  foreach(var_18 in var_16)
  var_18 delete();
}

load_costume_indices() {
  if(isdefined(level.costumecategories)) {
    return;
  }
  level.costumecategories = ["gender", "shirt", "head", "gloves"];
  level.costumecat2idx = [];

  for (var_0 = 0; var_0 < level.costumecategories.size; var_0++) {
    var_1 = level.costumecategories[var_0];
    level.costumecat2idx[var_1] = var_0;
  }
}