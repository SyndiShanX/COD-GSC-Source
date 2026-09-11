/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\load.gsc
***********************************************/

function main() {
  if(isDefined(level._loadstarted)) {
    return;
  }

  level.func = [];
  level._loadstarted = 1;
  level.createfx_enabled = getDvar("LSTTOTKPNP") != "";
  level.players_waiting_for_callback = [];
  level.struct_filter = &filterstructs;
  scripts\engine\utility::init_struct_class();
  scripts\mp\flags::initgameflags();
  scripts\mp\flags::initlevelflags();
  thread scripts\mp\playerlogic::queueconnectednotify();
  scripts\mp\flags::levelflaginit("scriptables_ready", 0);
  scripts\mp\scriptable::scriptable_mpglobalcallback();
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

  if(!isDefined(level.func)) {
    level.func = [];
  }

  level.func["precacheMpAnim"] = &precachempanim;
  level.func["scriptModelPlayAnim"] = &scriptmodelplayanim;
  level.func["scriptModelClearAnim"] = &scriptmodelclearanim;

  if(!level.createfx_enabled) {
    thread scripts\mp\minefields::minefields();
    thread scripts\mp\movers::init();
    thread scripts\mp\destructables::init();
    thread scripts\common\elevator::init();
    level notify("interactive_start");
  }

  game["thermal_vision"] = "thermal_mp";
  visionsetnaked("", 0);
  scripts\mp\utility\player::init_visionsetnight();
  visionsetmissilecam("missilecam");
  visionsetthermal(game["thermal_vision"]);
  visionsetpain(scripts\engine\utility::ter_op(scripts\cp_mp\utility\game_utility::isnightmap(), "pain_mp_night", "pain_mp"), 0);
  var_0 = getEntArray("lantern_glowFX_origin", "targetname");

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    thread lanterns();
  }

  scripts\mp\audio::init_audio();
  scripts\mp\art::main();
  thread scripts\common\fx::initfx();
  scripts\common\exploder::setupexploders();
  scripts\mp\anim::init();

  if(level.createfx_enabled) {
    scripts\mp\spawnlogic::setmapcenterfordev();
    scripts\mp\createfx::createfx();
  }

  if(getDvar("LLQQOPKTKM") == "1") {
    scripts\mp\dev::reflectionprobe_hide_hp();
    scripts\mp\dev::reflectionprobe_hide_front();
    scripts\mp\spawnlogic::setmapcenterfordev();
    scripts\mp\global_fx::main();
    level waittill("eternity");
  }

  thread scripts\mp\global_fx::main();

  for(var_2 = 0; var_2 < 7; var_2++) {
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
      case 5:
        var_3 = "trigger_multiple_arbitrary_up";
        break;
      default:
        var_3 = "trigger_damage";
        break;
    }

    var_4 = getEntArray(var_3, "classname");

    for(var_1 = 0; var_1 < var_4.size; var_1++) {
      if(isDefined(var_4[var_1].script_prefab_exploder)) {
        var_4[var_1].script_exploder = var_4[var_1].script_prefab_exploder;
      }

      if(isDefined(var_4[var_1].script_exploder)) {
        thread exploder_load(level);
      }

      if(var_3 == "trigger_multiple_arbitrary_up") {
        var_5 = var_4[var_1];
        var_5 setworlduptrigger(1);

        if(isDefined(var_5.target)) {
          var_6 = getEnt(var_5.target, "targetname");
          var_5 enablelinkTo();
          var_5 linkTo(var_6);
        }
      }
    }
  }

  thread scripts\mp\animatedmodels::main();
  level.func["damagefeedback"] = &scripts\mp\damagefeedback::updatedamagefeedback;
  level.laseron_func = &laseron;
  level.laseroff_func = &laseroff;
  level.connectpathsfunction = &connectpaths;
  level.disconnectpathsfunction = &disconnectpaths;
  level.fnbuildweapon = &scripts\mp\class::buildweapon;
  level.fngetweaponrootname = &scripts\mp\utility\weapon::getweaponrootname;
  setDvar("ui_showInfo", 1);
  setDvar("ui_showMinimap", 1);
  setupdestructiblekillcaments();
  level.fauxvehiclecount = 0;
  level thread scripts\engine\scriptable_door::system_init();
  scripts\common\utility::ref_13629();
}

function exploder_load(var_0) {
  level endon("killexplodertridgers" + var_0.script_exploder);
  var_0 waittill("trigger");

  if(isDefined(var_0.script_chance) && randomfloat(1) > var_0.script_chance) {
    if(isDefined(var_0.script_delay)) {
      wait var_0.script_delay;
    } else {
      wait 4;
    }

    thread exploder_load(level);
    return;
  }

  scripts\engine\utility::exploder(var_0.script_exploder);
  level notify("killexplodertridgers" + var_0.script_exploder);
}

function lanterns() {
  if(!isDefined(level._effect["lantern_light"])) {
    level._effect["lantern_light"] = loadfx("vfx/props/glow_latern");
  }

  scripts\common\fx::loopfx("lantern_light", self.origin, 0.3, self.origin + (0, 0, 1));
}

function setupdestructiblekillcaments() {
  var_0 = getEntArray("scriptable_destructible_vehicle", "targetname");

  foreach(var_2 in var_0) {
    var_3 = var_2.origin + (0, 0, 5);
    var_4 = var_2.origin + (0, 0, 128);
    var_5 = scripts\engine\trace::_bullet_trace(var_3, var_4, 0, var_2);
    var_2.killcament = spawn("script_model", var_5["position"]);
    var_2.killcament.targetname = "killCamEnt_destructible_vehicle";
    var_2.killcament setscriptmoverkillcam("explosive");
    thread deletedestructiblekillcament();
  }

  var_7 = getEntArray("scriptable_destructible_barrel", "targetname");

  foreach(var_2 in var_7) {
    var_3 = var_2.origin + (0, 0, 5);
    var_4 = var_2.origin + (0, 0, 128);
    var_5 = scripts\engine\trace::_bullet_trace(var_3, var_4, 0, var_2);
    var_2.killcament = spawn("script_model", var_5["position"]);
    var_2.killcament.targetname = "killCamEnt_explodable_barrel";
    var_2.killcament setscriptmoverkillcam("explosive");
    thread deletedestructiblekillcament();
  }
}

function deletedestructiblekillcament() {
  level endon("game_ended");
  var_0 = self.killcament;
  var_0 endon("death");
  self waittill("death");
  wait 10;

  if(isDefined(var_0)) {
    var_0 delete();
    return;
  }
}

function filterstructs(var_0) {
  if(scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_iscodevehicletest() && scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_iscodevehicletestlevel()) {
    if(var_0 scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_isvehiclespawnStruct()) {
      return true;
    }
  }

  if(isDefined(var_0.script_gameobjectname)) {
    var_1 = var_0.script_gameobjectname;
    var_2 = 0;

    if(getsubstr(var_1, 0, 1) == "!") {
      var_1 = getsubstr(var_1, 1);
      var_2 = 1;
    }

    if(var_2) {
      if(scripts\mp\utility\game::testgamemodestringlist(var_0.script_gameobjectname, scripts\mp\utility\game::getgametype())) {
        return false;
      }
    } else if(!scripts\mp\utility\game::testgamemodestringlist(var_0.script_gameobjectname, scripts\mp\utility\game::getgametype())) {
      if(scripts\mp\utility\game::getgametype() == "brtdm") {
        if(var_0 scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_isvehiclespawnStruct()) {
          return true;
        }
      } else if(istrue(level.unset_relic_lfo)) {
        if(var_0.script_gameobjectname == "arm") {
          return true;
        }
      }

      return false;
    }
  }

  var_3 = var_0.script_noteworthy;

  if(isDefined(var_3)) {
    if(level.ref_11ad3 == 1) {
      if(var_3 == "10v10") {
        return true;
      } else if(var_3 == "6v6") {
        return false;
      }
    } else if(var_3 == "6v6") {
      return true;
    } else if(var_3 == "10v10") {
      return false;
    }
  }

  return true;
}