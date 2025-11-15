/*******************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\load.gsc
*******************************/

main() {
  if(isDefined(level.var_1307)) {
    return;
  }

  level.func = [];
  level.var_1307 = 1;
  level.createfx_enabled = getdvar("createfx") != "";
  level.players_waiting_for_callback = [];
  scripts\engine\utility::struct_class_init();
  scripts\mp\utility::initgameflags();
  scripts\mp\utility::initlevelflags();
  thread scripts\mp\playerlogic::queueconnectednotify();
  level.generic_index = 0;
  level.flag_struct = spawnStruct();
  level.flag_struct scripts\common\flags::assign_unique_id();
  if(!isDefined(level.flag)) {
    level.flag = [];
    level.flags_lock = [];
  }

  level.var_499A = ::scripts\mp\hud_util::createfontstring;
  level.var_91B0 = ::scripts\mp\hud_util::setpoint;
  thread scripts\mp\tweakables::init();
  if(!isDefined(level.func)) {
    level.func = [];
  }

  level.func["precacheMpAnim"] = ::precachempanim;
  level.func["scriptModelPlayAnim"] = ::scriptmodelplayanim;
  level.func["scriptModelClearAnim"] = ::scriptmodelclearanim;
  if(!level.createfx_enabled) {
    thread scripts\mp\minefields::minefields();
    thread scripts\mp\shutter::main();
    thread scripts\mp\movers::init();
    thread scripts\mp\destructables::init();
    thread scripts\common\elevator::init();
    level notify("interactive_start");
  }

  game["thermal_vision"] = "thermal_mp";
  visionsetnaked("", 0);
  visionsetnight("default_night_mp");
  visionsetmissilecam("missilecam");
  visionsetthermal(game["thermal_vision"]);
  visionsetpain("", 0);
  var_00 = getEntArray("lantern_glowFX_origin", "targetname");
  for(var_01 = 0; var_01 < var_00.size; var_01++) {
    var_00[var_01] thread lanterns();
  }

  scripts\mp\audio::init_audio();
  scripts\mp\art::main();
  setupexploders();
  thread scripts\common\fx::initfx();
  if(level.createfx_enabled) {
    scripts\mp\spawnlogic::setmapcenterfordev();
    scripts\mp\createfx::createfx();
  }

  if(getdvar("r_reflectionProbeGenerate") == "1") {
    scripts\mp\dev::reflectionprobe_hide_hp();
    scripts\mp\dev::reflectionprobe_hide_front();
    scripts\mp\spawnlogic::setmapcenterfordev();
    scripts\mp\global_fx::main();
    level waittill("eternity");
  }

  thread scripts\mp\global_fx::main();
  for(var_02 = 0; var_02 < 7; var_02++) {
    switch (var_02) {
      case 0:
        var_03 = "trigger_multiple";
        break;

      case 1:
        var_03 = "trigger_once";
        break;

      case 2:
        var_03 = "trigger_use";
        break;

      case 3:
        var_03 = "trigger_radius";
        break;

      case 4:
        var_03 = "trigger_lookat";
        break;

      case 5:
        var_03 = "trigger_multiple_arbitrary_up";
        break;

      default:
        var_03 = "trigger_damage";
        break;
    }

    var_04 = getEntArray(var_03, "classname");
    for(var_01 = 0; var_01 < var_04.size; var_01++) {
      if(isDefined(var_04[var_01].script_prefab_exploder)) {
        var_04[var_01].script_exploder = var_04[var_01].script_prefab_exploder;
      }

      if(isDefined(var_04[var_01].script_exploder)) {
        level thread exploder_load(var_04[var_01]);
      }

      if(var_03 == "trigger_multiple_arbitrary_up") {
        var_05 = var_04[var_01];
        var_05 _meth_84C0(1);
        if(isDefined(var_05.target)) {
          var_06 = getent(var_05.target, "targetname");
          var_05 enablelinkto();
          var_05 linkto(var_06);
        }
      }
    }
  }

  thread scripts\mp\animatedmodels::main();
  level.func["damagefeedback"] = ::scripts\mp\damagefeedback::updatedamagefeedback;
  level.func["setTeamHeadIcon"] = ::scripts\mp\entityheadicons::setteamheadicon;
  level.var_A879 = ::laseron;
  level.var_A877 = ::laseroff;
  level.var_4537 = ::connectpaths;
  level.var_563A = ::disconnectpaths;
  setdvar("sm_sunShadowScale", 1);
  setdvar("sm_spotLightScoreModelScale", 0);
  setdvar("r_specularcolorscale", 1);
  setdvar("r_diffusecolorscale", 1);
  setdvar("r_lightGridEnableTweaks", 0);
  setdvar("r_lightGridIntensity", 1);
  setdvar("r_lightGridContrast", 0);
  setdvar("ui_showInfo", 1);
  setdvar("ui_showMinimap", 1);
  setupdamagetriggers();
  precacheitem("bomb_site_mp");
  level.fauxvehiclecount = 0;
  level.var_AD86 = "vehicle_aas_72x_killstreak";
}

exploder_load(param_00) {
  level endon("killexplodertridgers" + param_00.script_exploder);
  param_00 waittill("trigger");
  if(isDefined(param_00.script_chance) && randomfloat(1) > param_00.script_chance) {
    if(isDefined(param_00.script_delay)) {
      wait(param_00.script_delay);
    } else {
      wait(4);
    }

    level thread exploder_load(param_00);
    return;
  }

  scripts\engine\utility::exploder(param_00.script_exploder);
  level notify("killexplodertridgers" + param_00.script_exploder);
}

setupexploders() {
  var_00 = getEntArray("script_brushmodel", "classname");
  var_01 = getEntArray("script_model", "classname");
  for(var_02 = 0; var_02 < var_01.size; var_02++) {
    var_00[var_00.size] = var_01[var_02];
  }

  for(var_02 = 0; var_02 < var_00.size; var_02++) {
    if(isDefined(var_00[var_02].script_prefab_exploder)) {
      var_00[var_02].script_exploder = var_00[var_02].script_prefab_exploder;
    }

    if(isDefined(var_00[var_02].script_exploder)) {
      if(var_00[var_02].model == "fx" && !isDefined(var_00[var_02].var_336) || var_00[var_02].var_336 != "exploderchunk") {
        var_00[var_02] hide();
        continue;
      }

      if(isDefined(var_00[var_02].var_336) && var_00[var_02].var_336 == "exploder") {
        var_00[var_02] hide();
        var_00[var_02] notsolid();
        continue;
      }

      if(isDefined(var_00[var_02].var_336) && var_00[var_02].var_336 == "exploderchunk") {
        var_00[var_02] hide();
        var_00[var_02] notsolid();
      }
    }
  }

  var_03 = [];
  var_04 = getEntArray("script_brushmodel", "classname");
  for(var_02 = 0; var_02 < var_04.size; var_02++) {
    if(isDefined(var_04[var_02].script_prefab_exploder)) {
      var_04[var_02].script_exploder = var_04[var_02].script_prefab_exploder;
    }

    if(isDefined(var_04[var_02].script_exploder)) {
      var_03[var_03.size] = var_04[var_02];
    }
  }

  var_04 = getEntArray("script_model", "classname");
  for(var_02 = 0; var_02 < var_04.size; var_02++) {
    if(isDefined(var_04[var_02].script_prefab_exploder)) {
      var_04[var_02].script_exploder = var_04[var_02].script_prefab_exploder;
    }

    if(isDefined(var_04[var_02].script_exploder)) {
      var_03[var_03.size] = var_04[var_02];
    }
  }

  var_04 = getEntArray("item_health", "classname");
  for(var_02 = 0; var_02 < var_04.size; var_02++) {
    if(isDefined(var_04[var_02].script_prefab_exploder)) {
      var_04[var_02].script_exploder = var_04[var_02].script_prefab_exploder;
    }

    if(isDefined(var_04[var_02].script_exploder)) {
      var_03[var_03.size] = var_04[var_02];
    }
  }

  if(!isDefined(level.createfxent)) {
    level.createfxent = [];
  }

  var_05 = [];
  var_05["exploderchunk visible"] = 1;
  var_05["exploderchunk"] = 1;
  var_05["exploder"] = 1;
  for(var_02 = 0; var_02 < var_03.size; var_02++) {
    var_06 = var_03[var_02];
    var_07 = scripts\engine\utility::createexploder(var_06.script_fxid);
    var_07.v = [];
    var_07.v["origin"] = var_06.origin;
    var_07.v["angles"] = var_06.angles;
    var_07.v["delay"] = var_06.script_delay;
    var_07.v["firefx"] = var_06.script_firefx;
    var_07.v["firefxdelay"] = var_06.script_firefxdelay;
    var_07.v["firefxsound"] = var_06.script_firefxsound;
    var_07.v["firefxtimeout"] = var_06.var_ED96;
    var_07.v["earthquake"] = var_06.script_earthquake;
    var_07.v["damage"] = var_06.script_damage;
    var_07.v["damage_radius"] = var_06.script_radius;
    var_07.v["soundalias"] = var_06.script_soundalias;
    var_07.v["repeat"] = var_06.script_repeat;
    var_07.v["delay_min"] = var_06.script_delay_min;
    var_07.v["delay_max"] = var_06.script_delay_max;
    var_07.v["target"] = var_06.target;
    var_07.v["ender"] = var_06.script_ender;
    var_07.v["type"] = "exploder";
    if(!isDefined(var_06.script_fxid)) {
      var_07.v["fxid"] = "No FX";
    } else {
      var_07.v["fxid"] = var_06.script_fxid;
    }

    var_07.v["exploder"] = var_06.script_exploder;
    if(!isDefined(var_07.v["delay"])) {
      var_07.v["delay"] = 0;
    }

    if(isDefined(var_06.target)) {
      var_08 = getent(var_07.v["target"], "targetname").origin;
      var_07.v["angles"] = vectortoangles(var_08 - var_07.v["origin"]);
    }

    if(var_06.classname == "script_brushmodel" || isDefined(var_06.model)) {
      var_07.model = var_06;
      var_07.model.disconnect_paths = var_06.script_disconnectpaths;
    }

    if(isDefined(var_06.var_336) && isDefined(var_05[var_06.var_336])) {
      var_07.v["exploder_type"] = var_06.var_336;
    } else {
      var_07.v["exploder_type"] = "normal";
    }

    var_07 scripts\common\createfx::post_entity_creation_function();
  }
}

lanterns() {
  if(!isDefined(level._effect["lantern_light"])) {
    level._effect["lantern_light"] = loadfx("vfx\props\glow_latern");
  }

  scripts\common\fx::loopfx("lantern_light", self.origin, 0.3, self.origin + (0, 0, 1));
}

setupdamagetriggers() {
  var_00 = getEntArray("scriptable_destructible_vehicle", "targetname");
  foreach(var_02 in var_00) {
    var_03 = var_02.origin + (0, 0, 5);
    var_04 = var_02.origin + (0, 0, 128);
    var_05 = bulletTrace(var_03, var_04, 0, var_02);
    var_02.killcament = spawn("script_model", var_05["position"]);
    var_02.killcament.var_336 = "killCamEnt_destructible_vehicle";
    var_02.killcament setscriptmoverkillcam("explosive");
    var_02 thread deletedestructiblekillcament();
  }

  var_07 = getEntArray("scriptable_destructible_barrel", "targetname");
  foreach(var_02 in var_07) {
    var_03 = var_02.origin + (0, 0, 5);
    var_04 = var_02.origin + (0, 0, 128);
    var_05 = bulletTrace(var_03, var_04, 0, var_02);
    var_02.killcament = spawn("script_model", var_05["position"]);
    var_02.killcament.var_336 = "killCamEnt_explodable_barrel";
    var_02.killcament setscriptmoverkillcam("explosive");
    var_02 thread deletedestructiblekillcament();
  }
}

deletedestructiblekillcament() {
  level endon("game_ended");
  var_00 = self.killcament;
  var_00 endon("death");
  self waittill("death");
  wait(10);
  if(isDefined(var_00)) {
    var_00 delete();
  }
}