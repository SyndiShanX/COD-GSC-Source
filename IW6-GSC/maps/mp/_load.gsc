/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\_load.gsc
*****************************************************/

#include common_scripts\utility;
#include common_scripts\_fx;
#include maps\mp\_utility;

main() {
  if(isDefined(level._loadStarted)) {
    return;
  }
  level._loadStarted = true;

  level.createFX_enabled = (getdvar("createfx") != "");

  struct_class_init();

  initGameFlags();
  initLevelFlags();
  initGlobals();

  level.generic_index = 0;

  level.flag_struct = spawnStruct();
  level.flag_struct assign_unique_id();
  if(!isDefined(level.flag)) {
    level.flag = [];
    level.flags_lock = [];
  }

  level.requiredMapAspectRatio = getDvarFloat("scr_RequiredMapAspectratio", 1);
  level.createClientFontString_func = maps\mp\gametypes\_hud_util::createFontString;
  level.HUDsetPoint_func = maps\mp\gametypes\_hud_util::setPoint;
  level.leaderDialogOnPlayer_func = maps\mp\_utility::leaderDialogOnPlayer;

  thread maps\mp\gametypes\_tweakables::init();

  if(!isDefined(level.func)) {
    level.func = [];
  }
  level.func["precacheMpAnim"] = ::precacheMpAnim;
  level.func["scriptModelPlayAnim"] = ::scriptModelPlayAnim;
  level.func["scriptModelClearAnim"] = ::scriptModelClearAnim;

  if(!level.createFX_enabled) {
    thread maps\mp\_minefields::minefields();
    thread maps\mp\_radiation::radiation();
    thread maps\mp\_shutter::main();
    thread maps\mp\_movers::init();
    thread maps\mp\_destructables::init();
    thread common_scripts\_elevator::init();
    thread common_scripts\_dynamic_world::init();
    thread common_scripts\_destructible::init();
    level notify("interactive_start");
  }

  game["thermal_vision"] = "thermal_mp";

  VisionSetNaked("", 0);
  VisionSetNight("default_night_mp");
  VisionSetMissilecam("missilecam");
  VisionSetThermal(game["thermal_vision"]);
  VisionSetPain("", 0);

  lanterns = getEntArray("lantern_glowFX_origin", "targetname");
  for(i = 0; i < lanterns.size; i++) {
    lanterns[i] thread lanterns();
  }

  maps\mp\_audio::init_audio();
  maps\mp\_art::main();

  thread common_scripts\_painter::main("painter_mp");

  setupExploders();

  thread common_scripts\_fx::initFX();
  if(level.createFX_enabled) {
    maps\mp\gametypes\_spawnlogic::setMapCenterForDev();
    maps\mp\_createfx::createfx();
  }

  if(getdvar("r_reflectionProbeGenerate") == "1") {
    maps\mp\gametypes\_spawnlogic::setMapCenterForDev();
    maps\mp\_global_fx::main();
    level waittill("eternity");
  }

  thread maps\mp\_global_fx::main();

  for(p = 0; p < 6; p++) {
    switch (p) {
      case 0:
        triggertype = "trigger_multiple";
        break;

      case 1:
        triggertype = "trigger_once";
        break;

      case 2:
        triggertype = "trigger_use";
        break;

      case 3:
        triggertype = "trigger_radius";
        break;

      case 4:
        triggertype = "trigger_lookat";
        break;

      default:
        assert(p == 5);
        triggertype = "trigger_damage";
        break;
    }

    triggers = getEntArray(triggertype, "classname");

    for(i = 0; i < triggers.size; i++) {
      if(isDefined(triggers[i].script_prefab_exploder)) {
        triggers[i].script_exploder = triggers[i].script_prefab_exploder;
      }

      if(isDefined(triggers[i].script_exploder)) {
        level thread maps\mp\_load::exploder_load(triggers[i]);
      }
    }
  }

  thread maps\mp\_animatedmodels::main();

  level.func["damagefeedback"] = maps\mp\gametypes\_damagefeedback::updateDamageFeedback;
  level.func["setTeamHeadIcon"] = maps\mp\_entityheadicons::setTeamHeadIcon;
  level.laserOn_func = ::laserOn;
  level.laserOff_func = ::laserOff;

  level.connectPathsFunction = ::connectPaths;
  level.disconnectPathsFunction = ::disconnectPaths;

  setDvar("sm_sunShadowScale", 1);
  setDvar("sm_spotLightScoreModelScale", 0);
  setDvar("r_specularcolorscale", 2.5);
  setDvar("r_diffusecolorscale", 1);
  setDvar("r_lightGridEnableTweaks", 0);
  setDvar("r_lightGridIntensity", 1);
  setDvar("r_lightGridContrast", 0);

  SetDvar("ui_showInfo", 1);
  SetDvar("ui_showMinimap", 1);

  setupDestructibleKillCamEnts();

  PreCacheItem("bomb_site_mp");

  if(!level.console) {
    level.furFX = loadfx("vfx/apex/nv_dog_a");
    level.wolfFurFX = [];
    level.wolfFurFX[0] = loadfx("vfx/apex/nv_wolf_b");
    level.wolfFurFX[1] = loadfx("vfx/apex/nv_wolf_c");
  }

  level.fauxVehicleCount = 0;
  level.littlebird_model = "vehicle_aas_72x_killstreak";

  level thread reInitializeDevDvarsOnMigration();
}

exploder_load(trigger) {
  level endon("killexplodertridgers" + trigger.script_exploder);
  trigger waittill("trigger");
  if(isDefined(trigger.script_chance) && randomfloat(1) > trigger.script_chance) {
    if(isDefined(trigger.script_delay)) {
      wait trigger.script_delay;
    }
    else {
      wait 4;
    }
    level thread exploder_load(trigger);
    return;
  }
  exploder(trigger.script_exploder);
  level notify("killexplodertridgers" + trigger.script_exploder);
}

setupExploders() {
  ents = getEntArray("script_brushmodel", "classname");
  smodels = getEntArray("script_model", "classname");
  for(i = 0; i < smodels.size; i++) {
    ents[ents.size] = smodels[i];
  }

  for(i = 0; i < ents.size; i++) {
    if(isDefined(ents[i].script_prefab_exploder)) {
      ents[i].script_exploder = ents[i].script_prefab_exploder;
    }

    if(isDefined(ents[i].script_exploder)) {
      if((ents[i].model == "fx") && ((!isDefined(ents[i].targetname)) || (ents[i].targetname != "exploderchunk"))) {
        ents[i] hide();
      }
      else if((isDefined(ents[i].targetname)) && (ents[i].targetname == "exploder")) {
        ents[i] hide();
        ents[i] notsolid();

      } else if((isDefined(ents[i].targetname)) && (ents[i].targetname == "exploderchunk")) {
        ents[i] hide();
        ents[i] notsolid();

      }
    }
  }

  script_exploders = [];

  potentialExploders = getEntArray("script_brushmodel", "classname");
  for(i = 0; i < potentialExploders.size; i++) {
    if(isDefined(potentialExploders[i].script_prefab_exploder)) {
      potentialExploders[i].script_exploder = potentialExploders[i].script_prefab_exploder;
    }

    if(isDefined(potentialExploders[i].script_exploder)) {
      script_exploders[script_exploders.size] = potentialExploders[i];
    }
  }

  potentialExploders = getEntArray("script_model", "classname");
  for(i = 0; i < potentialExploders.size; i++) {
    if(isDefined(potentialExploders[i].script_prefab_exploder)) {
      potentialExploders[i].script_exploder = potentialExploders[i].script_prefab_exploder;
    }

    if(isDefined(potentialExploders[i].script_exploder)) {
      script_exploders[script_exploders.size] = potentialExploders[i];
    }
  }

  potentialExploders = getEntArray("item_health", "classname");
  for(i = 0; i < potentialExploders.size; i++) {
    if(isDefined(potentialExploders[i].script_prefab_exploder)) {
      potentialExploders[i].script_exploder = potentialExploders[i].script_prefab_exploder;
    }

    if(isDefined(potentialExploders[i].script_exploder)) {
      script_exploders[script_exploders.size] = potentialExploders[i];
    }
  }

  if(!isDefined(level.createFXent)) {
    level.createFXent = [];
  }

  acceptableTargetnames = [];
  acceptableTargetnames["exploderchunk visible"] = true;
  acceptableTargetnames["exploderchunk"] = true;
  acceptableTargetnames["exploder"] = true;

  for(i = 0; i < script_exploders.size; i++) {
    exploder = script_exploders[i];
    ent = createExploder(exploder.script_fxid);
    ent.v = [];
    ent.v["origin"] = exploder.origin;
    ent.v["angles"] = exploder.angles;
    ent.v["delay"] = exploder.script_delay;
    ent.v["firefx"] = exploder.script_firefx;
    ent.v["firefxdelay"] = exploder.script_firefxdelay;
    ent.v["firefxsound"] = exploder.script_firefxsound;
    ent.v["firefxtimeout"] = exploder.script_firefxtimeout;
    ent.v["earthquake"] = exploder.script_earthquake;
    ent.v["damage"] = exploder.script_damage;
    ent.v["damage_radius"] = exploder.script_radius;
    ent.v["soundalias"] = exploder.script_soundalias;
    ent.v["repeat"] = exploder.script_repeat;
    ent.v["delay_min"] = exploder.script_delay_min;
    ent.v["delay_max"] = exploder.script_delay_max;
    ent.v["target"] = exploder.target;
    ent.v["ender"] = exploder.script_ender;
    ent.v["type"] = "exploder";

    if(!isDefined(exploder.script_fxid)) {
      ent.v["fxid"] = "No FX";
    }
    else {
      ent.v["fxid"] = exploder.script_fxid;
    }
    ent.v["exploder"] = exploder.script_exploder;
    assertEx(isDefined(exploder.script_exploder), "Exploder at origin " + exploder.origin + " has no script_exploder");

    if(!isDefined(ent.v["delay"])) {
      ent.v["delay"] = 0;
    }

    if(isDefined(exploder.target)) {
      org = getent(ent.v["target"], "targetname").origin;
      ent.v["angles"] = vectortoangles(org - ent.v["origin"]);

    }

    if(exploder.classname == "script_brushmodel" || isDefined(exploder.model)) {
      ent.model = exploder;
      ent.model.disconnect_paths = exploder.script_disconnectpaths;
    }

    if(isDefined(exploder.targetname) && isDefined(acceptableTargetnames[exploder.targetname])) {
      ent.v["exploder_type"] = exploder.targetname;
    }
    else {
      ent.v["exploder_type"] = "normal";
    }

    ent common_scripts\_createfx::post_entity_creation_function();
  }
}

lanterns() {
  if(!isDefined(level._effect["lantern_light"])) {
    level._effect["lantern_light"] = loadfx("fx/props/glow_latern");
  }

  loopfx("lantern_light", self.origin, 0.3, self.origin + (0, 0, 1));
}

setupDestructibleKillCamEnts() {
  destructible_vehicles = getEntArray("scriptable_destructible_vehicle", "targetname");
  foreach(dest in destructible_vehicles) {
    bulletStart = dest.origin + (0, 0, 5);
    bulletEnd = (dest.origin + (0, 0, 128));
    result = bulletTrace(bulletStart, bulletEnd, false, dest);
    dest.killCamEnt = spawn("script_model", result["position"]);
    dest.killCamEnt.targetname = "killCamEnt_destructible_vehicle";
    dest.killCamEnt SetScriptMoverKillCam("explosive");
    dest thread deleteDestructibleKillCamEnt();
  }

  explodable_barrels = getEntArray("scriptable_destructible_barrel", "targetname");
  foreach(dest in explodable_barrels) {
    bulletStart = dest.origin + (0, 0, 5);
    bulletEnd = (dest.origin + (0, 0, 128));
    result = bulletTrace(bulletStart, bulletEnd, false, dest);
    dest.killCamEnt = spawn("script_model", result["position"]);
    dest.killCamEnt.targetname = "killCamEnt_explodable_barrel";
    dest.killCamEnt SetScriptMoverKillCam("explosive");
    dest thread deleteDestructibleKillCamEnt();
  }

}

deleteDestructibleKillCamEnt() {
  level endon("game_ended");

  killCamEnt = self.killCamEnt;
  killCamEnt endon("death");

  self waittill("death");

  wait(10);
  if(isDefined(killCamEnt)) {
    killCamEnt delete();
  }
}