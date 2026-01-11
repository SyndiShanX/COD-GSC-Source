/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2764.gsc
***************************************/

main() {
  if(isDefined(level.func_1307)) {
    return;
  }
  level.func = [];
  level.func_1307 = 1;
  level.createfx_enabled = getdvar("createfx") != "";
  level.players_waiting_for_callback = [];
  scripts\engine\utility::struct_class_init();
  scripts\mp\utility\game::initgameflags();
  scripts\mp\utility\game::initlevelflags();
  thread scripts\mp\playerlogic::queueconnectednotify();
  level.generic_index = 0;
  level.flag_struct = spawnStruct();
  level.flag_struct scripts\engine\flags::assign_unique_id();

  if(!isDefined(level.flag)) {
    level.flag = [];
    level.flags_lock = [];
  }

  level.func_499A = scripts\mp\hud_util::createfontstring;
  level.func_91B0 = scripts\mp\hud_util::setpoint;
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

  for(var_01 = 0; var_01 < var_0.size; var_1++) {
    var_0[var_01] thread lanterns();
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

  for(var_02 = 0; var_02 < 7; var_2++) {
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

    for(var_01 = 0; var_01 < var_4.size; var_1++) {
      if(isDefined(var_4[var_01].script_prefab_exploder)) {
        var_4[var_01].targetname = var_4[var_01].script_prefab_exploder;
      }

      if(isDefined(var_4[var_01].targetname)) {
        level thread exploder_load(var_4[var_01]);
      }

      if(var_03 == "trigger_multiple_arbitrary_up") {
        var_05 = var_4[var_01];
        var_05 _meth_84C0(1);

        if(isDefined(var_5.target)) {
          var_06 = getent(var_5.target, "targetname");
          var_05 getrankxp();
          var_05 linkto(var_06);
        }
      }
    }
  }

  thread scripts\mp\animatedmodels::main();
  level.func["damagefeedback"] = ::scripts\mp\damagefeedback::updatedamagefeedback;
  level.func["setTeamHeadIcon"] = ::scripts\mp\entityheadicons::setteamheadicon;
  level.func_A879 = ::laseron;
  level.func_A877 = ::laseroff;
  level.func_4537 = ::connectpaths;
  level.func_563A = ::disconnectpaths;
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
  level.func_AD86 = "vehicle_aas_72x_killstreak";
}

exploder_load(var_00) {
  level endon("killexplodertridgers" + var_0.targetname);
  var_00 waittill("trigger");

  if(isDefined(var_0.script_chance) && randomfloat(1) > var_0.script_chance) {
    if(isDefined(var_0.script_delay)) {
      wait(var_0.script_delay);
    } else {
      wait 4;
    }

    level thread exploder_load(var_00);
    return;
  }

  scripts\engine\utility::exploder(var_0.targetname);
  level notify("killexplodertridgers" + var_0.targetname);
}

setupexploders() {
  var_00 = getEntArray("script_brushmodel", "classname");
  var_01 = getEntArray("script_model", "classname");

  for(var_02 = 0; var_02 < var_1.size; var_2++) {
    var_0[var_0.size] = var_1[var_02];
  }

  for(var_02 = 0; var_02 < var_0.size; var_2++) {
    if(isDefined(var_0[var_02].script_prefab_exploder)) {
      var_0[var_02].targetname = var_0[var_02].script_prefab_exploder;
    }

    if(isDefined(var_0[var_02].targetname)) {
      if(var_0[var_02].model == "fx" && (!isDefined(var_0[var_02].targetname) || var_0[var_02].targetname != "exploderchunk")) {
        var_0[var_02] hide();
        continue;
      }

      if(isDefined(var_0[var_02].targetname) && var_0[var_02].targetname == "exploder") {
        var_0[var_02] hide();
        var_0[var_02] notsolid();
        continue;
      }

      if(isDefined(var_0[var_02].targetname) && var_0[var_02].targetname == "exploderchunk") {
        var_0[var_02] hide();
        var_0[var_02] notsolid();
      }
    }
  }

  var_03 = [];
  var_04 = getEntArray("script_brushmodel", "classname");

  for(var_02 = 0; var_02 < var_4.size; var_2++) {
    if(isDefined(var_4[var_02].script_prefab_exploder)) {
      var_4[var_02].targetname = var_4[var_02].script_prefab_exploder;
    }

    if(isDefined(var_4[var_02].targetname)) {
      var_3[var_3.size] = var_4[var_02];
    }
  }

  var_04 = getEntArray("script_model", "classname");

  for(var_02 = 0; var_02 < var_4.size; var_2++) {
    if(isDefined(var_4[var_02].script_prefab_exploder)) {
      var_4[var_02].targetname = var_4[var_02].script_prefab_exploder;
    }

    if(isDefined(var_4[var_02].targetname)) {
      var_3[var_3.size] = var_4[var_02];
    }
  }

  var_04 = getEntArray("item_health", "classname");

  for(var_02 = 0; var_02 < var_4.size; var_2++) {
    if(isDefined(var_4[var_02].script_prefab_exploder)) {
      var_4[var_02].targetname = var_4[var_02].script_prefab_exploder;
    }

    if(isDefined(var_4[var_02].targetname)) {
      var_3[var_3.size] = var_4[var_02];
    }
  }

  if(!isDefined(level.createfxent)) {
    level.createfxent = [];
  }

  var_05 = [];
  var_5["exploderchunk visible"] = 1;
  var_5["exploderchunk"] = 1;
  var_5["exploder"] = 1;

  for(var_02 = 0; var_02 < var_3.size; var_2++) {
    var_06 = var_3[var_02];
    var_07 = scripts\engine\utility::createexploder(var_6.script_fxid);
    var_7.v = [];
    var_7.v["origin"] = var_6.origin;
    var_7.v["angles"] = var_6.angles;
    var_7.v["delay"] = var_6.script_delay;
    var_7.v["firefx"] = var_6.script_firefx;
    var_7.v["firefxdelay"] = var_6.script_firefxdelay;
    var_7.v["firefxsound"] = var_6.script_firefxsound;
    var_7.v["firefxtimeout"] = var_6.func_ED96;
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

    if(!isDefined(var_6.script_fxid)) {
      var_7.v["fxid"] = "No FX";
    } else {
      var_7.v["fxid"] = var_6.script_fxid;
    }

    var_7.v["exploder"] = var_6.targetname;

    if(!isDefined(var_7.v["delay"])) {
      var_7.v["delay"] = 0;
    }

    if(isDefined(var_6.target)) {
      var_08 = getent(var_7.v["target"], "targetname").origin;
      var_7.v["angles"] = vectortoangles(var_08 - var_7.v["origin"]);
    }

    if(var_6.classname == "script_brushmodel" || isDefined(var_6.model)) {
      var_7.model = var_06;
      var_7.model.disconnect_paths = var_6.script_disconnectpaths;
    }

    if(isDefined(var_6.targetname) && isDefined(var_5[var_6.targetname])) {
      var_7.v["exploder_type"] = var_6.targetname;
    } else {
      var_7.v["exploder_type"] = "normal";
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
    var_03 = var_2.origin + (0, 0, 5);
    var_04 = var_2.origin + (0, 0, 128);
    var_05 = bulletTrace(var_03, var_04, 0, var_02);
    var_2.killcament = spawn("script_model", var_5["position"]);
    var_2.killcament.targetname = "killCamEnt_destructible_vehicle";
    var_2.killcament setscriptmoverkillcam("explosive");
    var_02 thread deletedestructiblekillcament();
  }

  var_07 = getEntArray("scriptable_destructible_barrel", "targetname");

  foreach(var_02 in var_07) {
    var_03 = var_2.origin + (0, 0, 5);
    var_04 = var_2.origin + (0, 0, 128);
    var_05 = bulletTrace(var_03, var_04, 0, var_02);
    var_2.killcament = spawn("script_model", var_5["position"]);
    var_2.killcament.targetname = "killCamEnt_explodable_barrel";
    var_2.killcament setscriptmoverkillcam("explosive");
    var_02 thread deletedestructiblekillcament();
  }
}

deletedestructiblekillcament() {
  level endon("game_ended");
  var_00 = self.killcament;
  var_00 endon("death");
  self waittill("death");
  wait 10;

  if(isDefined(var_00)) {
    var_00 delete();
  }
}