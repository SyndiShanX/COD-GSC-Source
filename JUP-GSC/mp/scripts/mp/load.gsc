/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\load.gsc
***********************************************/

#using script_17ff8fa860ec88dc;
#using script_32c2f4a699e57e1e;
#using script_448ef4d9e70ce5e;
#using script_451b7dcebbe53055;
#using script_56dcb79837d451ee;
#using script_61eb50466a589dec;
#using script_75a6c5ecea5929ae;
#using scripts\code\ai;
#using scripts\common\ae_utility;
#using scripts\common\callbacks;
#using scripts\common\create_cover_nodes;
#using scripts\common\damage_tuning;
#using scripts\common\devgui;
#using scripts\common\exploder;
#using scripts\common\fx;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\visibility_mode;
#using scripts\cp_mp\damagefeedback;
#using scripts\cp_mp\utility\debug_utility;
#using scripts\cp_mp\vehicles\vehicle_spawn;
#using scripts\cp_mp\weapon;
#using scripts\engine\flags;
#using scripts\engine\scriptable_door;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\anim;
#using scripts\mp\animatedmodels;
#using scripts\mp\art;
#using scripts\mp\audio;
#using scripts\mp\createfx;
#using scripts\mp\destructables;
#using scripts\mp\destructible;
#using scripts\mp\dev;
#using scripts\mp\flags;
#using scripts\mp\gametypes\escort_horde;
#using scripts\mp\hud_util;
#using scripts\mp\load;
#using scripts\mp\minefields;
#using scripts\mp\movers;
#using scripts\mp\playerlogic;
#using scripts\mp\rat_mp;
#using scripts\mp\scriptable;
#using scripts\mp\spawnlogic;
#using scripts\mp\tweakables;
#using scripts\mp\utility\dvars;
#using scripts\mp\utility\game;
#using scripts\mp\utility\player;
#namespace load;

function main() {
  if(isDefined(level._loadstarted)) {
    return;
  }

  level._loadstarted = 1;
  level.createfx_enabled = getDvar(@ "createfx") != "";
  level.players_waiting_for_callback = [];

  if(!isDefined(level.struct_filter)) {
    level.struct_filter = &filterstructs;
  }

  init_struct_class();
  scripts\mp\flags::initgameflags();
  scripts\mp\flags::initlevelflags();
  scripts\common\damage_tuning::init();
  thread scripts\mp\playerlogic::queueconnectednotify();
  thread scripts\mp\playerlogic::function_556c01754f79330f();
  scripts\mp\flags::levelflaginit("scriptables_ready", 0);
  scripts\mp\scriptable::scriptable_mpglobalcallback();
  scripts\code\ai::function_87dc2db63d1cfe13();
  scripts\common\ae_utility::init();
  level.generic_index = 0;
  level.flag_struct = spawnStruct();
  level.flag_struct scripts\engine\flags::assign_unique_id();

  if(!isDefined(level.flag)) {
    level.flag = [];
    level.flags_lock = [];
  }

  level.createclientfontstring_func = &scripts\mp\hud_util::createfontstring;
  level.hudsetpoint_func = &scripts\mp\hud_util::setpoint;

  if(!isDefined(level.tweakablesinitialized)) {
    thread scripts\mp\tweakables::init();
  }

  create_func_ref("precacheMpAnim", &precachempanim);
  create_func_ref("scriptModelPlayAnim", &scriptmodelplayanim);
  create_func_ref("scriptModelClearAnim", &scriptmodelclearanim);

  if(!level.createfx_enabled) {
    thread scripts\mp\minefields::minefields();
    thread scripts\mp\movers::init();
    thread scripts\mp\destructables::init();
    level notify("interactive_start");
  }

  game["thermal_vision"] = "thermal_mp";

  if(!isDefined(level.gamemodebundle)) {
    level.gamemodebundle = spawnStruct();
  }

  if(isDefined(level.var_161b9dd94239b201)) {
    deathvision = level.var_161b9dd94239b201;
  } else {
    deathvision = isDefined(level.gamemodebundle.visionset_death) ? level.gamemodebundle.visionset_death : "death";
  }

  visionsetnaked("", 0);
  scripts\mp\utility\player::init_visionsetnight();
  visionsetmissilecam("missilecam");
  visionsetthermal(game["thermal_vision"]);
  visionsetpain(isDefined(level.gamemodebundle.visionset_pain) ? level.gamemodebundle.visionset_pain : "damage_deathsdoor");
  visionsetdeath(deathvision);
  function_af2d9a459ebd113d(isDefined(level.gamemodebundle.var_813a06af0c271672) ? level.gamemodebundle.var_813a06af0c271672 : "damage_radial");
  function_347f34cac350b5dd(isDefined(level.gamemodebundle.var_96467afb3300bf50) ? level.gamemodebundle.var_96467afb3300bf50 : "damage_severe");
  visionsetwhizby("whizby");
  lanterns = getEntArray("lantern_glowFX_origin", "targetname");

  for(i = 0; i < lanterns.size; i++) {
    lanterns[i] thread lanterns();
  }

  scripts\mp\audio::init_audio();
  scripts\mp\art::main();
  level thread namespace_bed52b18307bf1e0::main();
  level thread namespace_46454e0fdfc84088::main();
  scripts\common\visibility_mode::main(&namespace_93121fa16281c01c::function_764239e6a246c46a);
  thread scripts\common\fx::initfx();
  scripts\common\exploder::setupexploders();
  scripts\mp\anim::init();

  if(level.createfx_enabled) {
    scripts\mp\spawnlogic::setmapcenterfordev();
    scripts\mp\createfx::createfx();
  }

  level thread scripts\common\create_cover_nodes::create_cover_node_init();

  if(getDvar(@ "hash_e6afce2cf5cf7515") == "1") {
    scripts\mp\dev::reflectionprobe_hide_hp();
    scripts\mp\dev::reflectionprobe_hide_front();
    scripts\mp\spawnlogic::setmapcenterfordev();
    level waittill("eternity");
  }

  level thread scripts\mp\destructible::rockable_cars_init();
  level thread scripts\mp\destructible::function_aaab78a3cf337331();

  for(p = 0; p < 7; p++) {
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
      case 5:
        triggertype = "trigger_multiple_arbitrary_up";
        break;
      default:
        assert(p == 6);
        triggertype = "trigger_damage";
        break;
    }

    triggers = getEntArray(triggertype, "classname");

    for(i = 0; i < triggers.size; i++) {
      if(isDefined(triggers[i].script_prefab_exploder)) {
        triggers[i].script_exploder = triggers[i].script_prefab_exploder;
      }

      if(isDefined(triggers[i].script_exploder)) {
        level thread scripts\mp\load::exploder_load(triggers[i]);
      }

      if(triggertype == "trigger_multiple_arbitrary_up") {
        trigger = triggers[i];
        trigger setworlduptrigger(1);

        if(isDefined(trigger.target)) {
          parent = getEnt(trigger.target, "targetname");
          trigger enablelinkTo();
          trigger linkTo(parent);
        }
      }
    }
  }

  thread scripts\mp\animatedmodels::main();

  namespace_d4b0db6f425eeb40::function_684874396c3776b3();
  scripts\common\devgui::init_devgui();
  level thread scripts\cp_mp\utility\debug_utility::function_bb5850f548a9d261();

  create_func_ref("damagefeedback", &scripts\cp_mp\damagefeedback::updatedamagefeedback);
  level.laseron_func = &laseron;
  level.laseroff_func = &laseroff;
  level.connectpathsfunction = &connectpaths;
  level.disconnectpathsfunction = &disconnectpaths;
  level.fnbuildweapon = &scripts\cp_mp\weapon::buildweapon;
  level.fngetweaponrootname = &scripts\cp_mp\weapon::getweaponrootname;
  setDvar(@ "hash_b3298e0bfb0e29bc", 1);
  setDvar(@ "hash_6aed1079deb9c76f", 1);
  level thread setupdestructiblekillcaments();
  level.fauxvehiclecount = 0;
  level thread scripts\engine\scriptable_door::system_init();

  level thread scripts\mp\utility\dvars::reinitializedevdvarsonmigration();

  utility::spawncorpsehider();
  scripts\mp\rat_mp::init();
  utility::fixplacedweapons();

  if(getdvarint(@ "hash_4b664c074a868ac5", 0) != 0) {
    level thread namespace_dfe80adf32f5c14a::function_a7874c90845471f3();
  }

  if(function_4ef12b6ed882dc9b()) {
    level thread namespace_a0ec72d04b7f766b::function_fdcb8b9791123648();
  }

  if(function_7dc15b2c8dcd2ee7()) {
    level thread namespace_bd8dd5dc71a74700::function_17a8b3a21e25bce4();
  }

  if(function_f24e99a2f548d0b8() && getdvarint(@ "hash_79900699601c9314", 1)) {
    level scripts\common\callbacks::add("player_spawned", &function_5727ac40e6ef5456);
  }

  if(ismutationgamemode()) {
    level thread scripts\mp\gametypes\escort_horde::function_3885e1d74c6f11eb();
  }
}

function function_5727ac40e6ef5456(params) {
  val::set("snipersOnly", "melee", 0);
}

function exploder_load(trigger) {
  level endon("killexplodertridgers" + trigger.script_exploder);
  trigger waittill("trigger");

  if(isDefined(trigger.script_chance) && randomfloat(1) > trigger.script_chance) {
    if(isDefined(trigger.script_delay)) {
      wait trigger.script_delay;
    } else {
      wait 4;
    }

    level thread exploder_load(trigger);
    return;
  }

  exploder(trigger.script_exploder);
  level notify("killexplodertridgers" + trigger.script_exploder);
}

function lanterns() {
  if(!isDefined(level._effect["lantern_light"])) {
    level._effect["lantern_light"] = loadfx("vfx/props/glow_latern");
  }

  loopfx("lantern_light", self.origin, 0.3, self.origin + (0, 0, 1));
}

function setupdestructiblekillcaments() {
  foreach(dest in getEntArray("scriptable_destructible_barrel", "targetname")) {
    bulletstart = dest.origin + (0, 0, 5);
    bulletend = dest.origin + (0, 0, 128);
    result = scripts\engine\trace::_bullet_trace(bulletstart, bulletend, 0, dest);
    dest.killcament = spawn("script_model", result["position"]);
    dest.killcament.targetname = "killCamEnt_explodable_barrel";
    dest.killcament setscriptmoverkillcam("explosive");
    dest thread deletedestructiblekillcament();
  }

  foreach(dest in getEntArray("scriptable_accessory_fire_extinguisher", "classname")) {
    bulletstart = dest.origin + (0, 0, 5);
    bulletend = dest.origin + (0, 0, 128);
    result = scripts\engine\trace::_bullet_trace(bulletstart, bulletend, 0, dest);
    dest setscriptmoverkillcam("offset explosive", int((result["position"] - dest.origin)[2]), 0);
  }

  flag_wait("rockable_cars_init");

  foreach(car in level.rockablecars.cars) {
    bulletstart = car.origin + (0, 0, 5);
    bulletend = car.origin + (0, 0, 128);
    result = scripts\engine\trace::_bullet_trace(bulletstart, bulletend, 0, car);
    car setscriptmoverkillcam("offset explosive", int((result["position"] - car.origin)[2]), 0);
  }

  waitframe();

  foreach(car in level.rockablecars.cars) {
    car willneverchange();
  }
}

function deletedestructiblekillcament() {
  level endon("game_ended");
  killcament = self.killcament;
  killcament endon("death");
  self waittill("death");
  wait 10;

  if(isDefined(killcament)) {
    killcament delete();
  }
}

function filterstructs(struct) {
  if(isDefined(struct.script_gameobjectname)) {
    var_e1401866fbd7f113 = struct.script_gameobjectname;
    invertlogic = 0;

    if(getsubstr(var_e1401866fbd7f113, 0, 1) == "!") {
      var_e1401866fbd7f113 = getsubstr(var_e1401866fbd7f113, 1);
      invertlogic = 1;
    }

    if(invertlogic) {
      if(testgamemodestringlist(struct.script_gameobjectname, getgametype())) {
        return false;
      }
    } else if(!testgamemodestringlist(struct.script_gameobjectname, getgametype())) {
      if(getgametype() == "brtdm" || getgametype() == "brtdm_mgl") {
        if(struct scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_isvehiclespawnStruct()) {
          return true;
        }
      } else if(istrue(level.isgroundwarsiege) || istrue(level.var_904f766b5267e332) || istrue(level.var_39a48a5896d2b3e8) || istrue(level.var_a0f41ec8e5268d15)) {
        if(issubstr(struct.script_gameobjectname, "arm")) {
          return true;
        }
      }

      return false;
    }
  }

  return true;
}