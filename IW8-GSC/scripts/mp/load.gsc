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
  var0 = getEntArray("lantern_glowFX_origin", "targetname");

  for(var1 = 0; var1 < var0.size; var1++) {
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

  for(var2 = 0; var2 < 7; var2++) {
    switch (var2) {
      case 0:
        var3 = "trigger_multiple";
        break;
      case 1:
        var3 = "trigger_once";
        break;
      case 2:
        var3 = "trigger_use";
        break;
      case 3:
        var3 = "trigger_radius";
        break;
      case 4:
        var3 = "trigger_lookat";
        break;
      case 5:
        var3 = "trigger_multiple_arbitrary_up";
        break;
      default:
        var3 = "trigger_damage";
        break;
    }

    var4 = getEntArray(var3, "classname");

    for(var1 = 0; var1 < var4.size; var1++) {
      if(isDefined(var4[var1].script_prefab_exploder)) {
        var4[var1].script_exploder = var4[var1].script_prefab_exploder;
      }

      if(isDefined(var4[var1].script_exploder)) {
        thread exploder_load(level);
      }

      if(var3 == "trigger_multiple_arbitrary_up") {
        var5 = var4[var1];
        var5 setworlduptrigger(1);

        if(isDefined(var5.target)) {
          var6 = getEnt(var5.target, "targetname");
          var5 enablelinkTo();
          var5 linkTo(var6);
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

function exploder_load(var0) {
  level endon("killexplodertridgers" + var0.script_exploder);
  var0 waittill("trigger");

  if(isDefined(var0.script_chance) && randomfloat(1) > var0.script_chance) {
    if(isDefined(var0.script_delay)) {
      wait var0.script_delay;
    } else {
      wait 4;
    }

    thread exploder_load(level);
    return;
  }

  scripts\engine\utility::exploder(var0.script_exploder);
  level notify("killexplodertridgers" + var0.script_exploder);
}

function lanterns() {
  if(!isDefined(level._effect["lantern_light"])) {
    level._effect["lantern_light"] = loadfx("vfx/props/glow_latern");
  }

  scripts\common\fx::loopfx("lantern_light", self.origin, 0.3, self.origin + (0, 0, 1));
}

function setupdestructiblekillcaments() {
  var0 = getEntArray("scriptable_destructible_vehicle", "targetname");

  foreach(var2 in var0) {
    var3 = var2.origin + (0, 0, 5);
    var4 = var2.origin + (0, 0, 128);
    var5 = scripts\engine\trace::_bullet_trace(var3, var4, 0, var2);
    var2.killcament = spawn("script_model", var5["position"]);
    var2.killcament.targetname = "killCamEnt_destructible_vehicle";
    var2.killcament setscriptmoverkillcam("explosive");
    thread deletedestructiblekillcament();
  }

  var7 = getEntArray("scriptable_destructible_barrel", "targetname");

  foreach(var2 in var7) {
    var3 = var2.origin + (0, 0, 5);
    var4 = var2.origin + (0, 0, 128);
    var5 = scripts\engine\trace::_bullet_trace(var3, var4, 0, var2);
    var2.killcament = spawn("script_model", var5["position"]);
    var2.killcament.targetname = "killCamEnt_explodable_barrel";
    var2.killcament setscriptmoverkillcam("explosive");
    thread deletedestructiblekillcament();
  }
}

function deletedestructiblekillcament() {
  level endon("game_ended");
  var0 = self.killcament;
  var0 endon("death");
  self waittill("death");
  wait 10;

  if(isDefined(var0)) {
    var0 delete();
    return;
  }
}

function filterstructs(var0) {
  if(scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_iscodevehicletest() && scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_iscodevehicletestlevel()) {
    if(var0 scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_isvehiclespawnStruct()) {
      return true;
    }
  }

  if(isDefined(var0.script_gameobjectname)) {
    var1 = var0.script_gameobjectname;
    var2 = 0;

    if(getsubstr(var1, 0, 1) == "!") {
      var1 = getsubstr(var1, 1);
      var2 = 1;
    }

    if(var2) {
      if(scripts\mp\utility\game::testgamemodestringlist(var0.script_gameobjectname, scripts\mp\utility\game::getgametype())) {
        return false;
      }
    } else if(!scripts\mp\utility\game::testgamemodestringlist(var0.script_gameobjectname, scripts\mp\utility\game::getgametype())) {
      if(scripts\mp\utility\game::getgametype() == "brtdm") {
        if(var0 scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_isvehiclespawnStruct()) {
          return true;
        }
      } else if(istrue(level.unset_relic_lfo)) {
        if(var0.script_gameobjectname == "arm") {
          return true;
        }
      }

      return false;
    }
  }

  var3 = var0.script_noteworthy;

  if(isDefined(var3)) {
    if(level.ref_11ad3 == 1) {
      if(var3 == "10v10") {
        return true;
      } else if(var3 == "6v6") {
        return false;
      }
    } else if(var3 == "6v6") {
      return true;
    } else if(var3 == "10v10") {
      return false;
    }
  }

  return true;
}