/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\load.gsc
***********************************************/

main() {
  if(isDefined(level._loadstarted)) {
    return;
  }
  level._loadstarted = 1;
  level.createfx_enabled = getDvar("createfx") != "";
  level.players_waiting_for_callback = [];
  level.struct_filter = ::filterstructs;
  scripts\engine\utility::init_struct_class();
  scripts\mp\flags::initgameflags();
  scripts\mp\flags::initlevelflags();
  thread scripts\mp\playerlogic::queueconnectednotify();
  scripts\mp\flags::levelflaginit("scriptables_ready", 0);
  scripts\mp\scriptable::scriptable_mpglobalcallback();
  scripts\code\ai::_id_87DC2DB63D1CFE13();
  level.generic_index = 0;
  level.flag_struct = spawnStruct();
  level.flag_struct scripts\engine\flags::assign_unique_id();

  if(!isDefined(level.flag)) {
    level.flag = [];
    level.flags_lock = [];
  }

  level.createclientfontstring_func = scripts\mp\hud_util::createfontstring;
  level.hudsetpoint_func = scripts\mp\hud_util::setpoint;

  if(!isDefined(level.tweakablesinitialized))
    thread scripts\mp\tweakables::init();

  scripts\engine\utility::create_func_ref("precacheMpAnim", ::precachempanim);
  scripts\engine\utility::create_func_ref("scriptModelPlayAnim", ::scriptmodelplayanim);
  scripts\engine\utility::create_func_ref("scriptModelClearAnim", ::scriptmodelclearanim);

  if(!level.createfx_enabled) {
    thread scripts\mp\minefields::minefields();
    thread scripts\mp\movers::init();
    thread scripts\mp\destructables::init();
    thread scripts\common\elevator::init();
    level notify("interactive_start");
  }

  game["thermal_vision"] = "thermal_mp";

  if(isDefined(level._id_161B9DD94239B201))
    _id_FC830F0B87465435 = level._id_161B9DD94239B201;
  else
    _id_FC830F0B87465435 = "death";

  visionsetnaked("", 0);
  scripts\mp\utility\player::init_visionsetnight();
  visionsetmissilecam("missilecam");
  visionsetthermal(game["thermal_vision"]);
  visionsetpain("damage_deathsdoor");
  _func_DCCECA58C71CEB5F(_id_FC830F0B87465435);
  _func_AF2D9A459EBD113D("damage_radial");
  _func_347F34CAC350B5DD("damage_severe");
  _func_C838F02B25DA3712("whizby");
  lanterns = getEntArray("lantern_glowFX_origin", "targetname");

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < lanterns.size; _id_AC0E594AC96AA3A8++)
    lanterns[_id_AC0E594AC96AA3A8] thread lanterns();

  scripts\mp\audio::init_audio();
  scripts\mp\art::main();
  level thread _id_0448EF4D9E70CE5E::main();
  level thread _id_61EB50466A589DEC::main();
  _id_6BFE39BD5C12F84A::main(_id_17FF8FA860EC88DC::_id_764239E6A246C46A);
  thread scripts\common\fx::initfx();
  scripts\common\exploder::setupexploders();
  scripts\mp\anim::init();

  if(level.createfx_enabled) {
    scripts\mp\spawnlogic::setmapcenterfordev();
    scripts\mp\createfx::createfx();
  }

  if(getDvar("r_reflectionprobegenerate") == "1") {
    scripts\mp\dev::reflectionprobe_hide_hp();
    scripts\mp\dev::reflectionprobe_hide_front();
    scripts\mp\spawnlogic::setmapcenterfordev();
    level waittill("eternity");
  }

  level thread scripts\mp\destructible::rockable_cars_init();

  for(_id_AC0E424AC96A7113 = 0; _id_AC0E424AC96A7113 < 7; _id_AC0E424AC96A7113++) {
    switch (_id_AC0E424AC96A7113) {
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
        triggertype = "trigger_damage";
        break;
    }

    triggers = getEntArray(triggertype, "classname");

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < triggers.size; _id_AC0E594AC96AA3A8++) {
      if(isDefined(triggers[_id_AC0E594AC96AA3A8].script_prefab_exploder))
        triggers[_id_AC0E594AC96AA3A8].script_exploder = triggers[_id_AC0E594AC96AA3A8].script_prefab_exploder;

      if(isDefined(triggers[_id_AC0E594AC96AA3A8].script_exploder))
        level thread exploder_load(triggers[_id_AC0E594AC96AA3A8]);

      if(triggertype == "trigger_multiple_arbitrary_up") {
        trigger = triggers[_id_AC0E594AC96AA3A8];
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
  _id_72A196B6C7DF2F38::_id_2AFB8E0809C2E65D();
  _id_2A5EB57416D4798E::_id_683AEFB412AF1596();
  scripts\engine\utility::create_func_ref("damagefeedback", _id_5762AC2F22202BA2::updatedamagefeedback);
  level.laseron_func = ::laseron;
  level.laseroff_func = ::laseroff;
  level.connectpathsfunction = ::connectpaths;
  level.disconnectpathsfunction = ::disconnectpaths;
  level.fnbuildweapon = _id_2669878CF5A1B6BC::buildweapon;
  level.fngetweaponrootname = _id_2669878CF5A1B6BC::getweaponrootname;
  setDvar("ui_showInfo", 1);
  setDvar("ui_showMinimap", 1);
  level thread setupdestructiblekillcaments();
  level.fauxvehiclecount = 0;
  level thread scripts\engine\scriptable_door::system_init();
  level thread _id_0F430E9B819C8833::main();
  level thread scripts\unittest\unittest::main();

  if(getdvarint("dvar_9CFA0598B68BF44E", 0))
    _id_3214E6FCDCE468A7::_id_FFC20A0CD9408D3E();

  scripts\common\utility::spawncorpsehider();

  if(scripts\cp_mp\utility\game_utility::_id_2D79A7A3B91C4C3E())
    level thread _id_3F30C82464AC941E::_id_AC4F59436445EE89();
  else if(scripts\cp_mp\utility\game_utility::_id_FA7BFCC1D68B7B73())
    level _id_3F30C82464AC941E::_id_C6E730535C85608B();

  _id_1BD447994BB080F3::init();
}

exploder_load(trigger) {
  level endon("killexplodertridgers" + trigger.script_exploder);
  trigger waittill("trigger");

  if(isDefined(trigger.script_chance) && randomfloat(1) > trigger.script_chance) {
    if(isDefined(trigger.script_delay))
      wait(trigger.script_delay);
    else
      wait 4;

    level thread exploder_load(trigger);
    return;
  }

  scripts\engine\utility::exploder(trigger.script_exploder);
  level notify("killexplodertridgers" + trigger.script_exploder);
}

lanterns() {
  if(!isDefined(level._effect["lantern_light"]))
    level._effect["lantern_light"] = loadfx("vfx/props/glow_latern");

  scripts\common\fx::loopfx("lantern_light", self.origin, 0.3, self.origin + (0, 0, 1));
}

setupdestructiblekillcaments() {
  foreach(_id_815D30728A6EF9D9 in getEntArray("scriptable_destructible_barrel", "targetname")) {
    _id_B44CEFCF38B5DA97 = _id_815D30728A6EF9D9.origin + (0, 0, 5);
    _id_DFDBE7C0C9DCA192 = _id_815D30728A6EF9D9.origin + (0, 0, 128);
    result = scripts\engine\trace::_bullet_trace(_id_B44CEFCF38B5DA97, _id_DFDBE7C0C9DCA192, 0, _id_815D30728A6EF9D9);
    _id_815D30728A6EF9D9.killcament = spawn("script_model", result["position"]);
    _id_815D30728A6EF9D9.killcament.targetname = "killCamEnt_explodable_barrel";
    _id_815D30728A6EF9D9.killcament setscriptmoverkillcam("explosive");
    _id_815D30728A6EF9D9 thread deletedestructiblekillcament();
  }

  foreach(_id_815D30728A6EF9D9 in getEntArray("scriptable_accessory_fire_extinguisher", "classname")) {
    _id_B44CEFCF38B5DA97 = _id_815D30728A6EF9D9.origin + (0, 0, 5);
    _id_DFDBE7C0C9DCA192 = _id_815D30728A6EF9D9.origin + (0, 0, 128);
    result = scripts\engine\trace::_bullet_trace(_id_B44CEFCF38B5DA97, _id_DFDBE7C0C9DCA192, 0, _id_815D30728A6EF9D9);
    _id_815D30728A6EF9D9 setscriptmoverkillcam("offset explosive", int(result["position"] - _id_815D30728A6EF9D9.origin[2]), 0);
  }

  scripts\engine\utility::flag_wait("rockable_cars_init");

  foreach(car in level.rockablecars.cars) {
    _id_B44CEFCF38B5DA97 = car.origin + (0, 0, 5);
    _id_DFDBE7C0C9DCA192 = car.origin + (0, 0, 128);
    result = scripts\engine\trace::_bullet_trace(_id_B44CEFCF38B5DA97, _id_DFDBE7C0C9DCA192, 0, car);
    car setscriptmoverkillcam("offset explosive", int(result["position"] - car.origin[2]), 0);
  }

  waitframe();

  foreach(car in level.rockablecars.cars)
  car willneverchange();
}

deletedestructiblekillcament() {
  level endon("game_ended");
  killcament = self.killcament;
  killcament endon("death");
  self waittill("death");
  wait 10;

  if(isDefined(killcament))
    killcament delete();
}

filterstructs(struct) {
  if(isDefined(struct.script_gameobjectname)) {
    _id_E1401866FBD7F113 = struct.script_gameobjectname;
    _id_E88E346FEAB6A5E9 = 0;

    if(getsubstr(_id_E1401866FBD7F113, 0, 1) == "!") {
      _id_E1401866FBD7F113 = getsubstr(_id_E1401866FBD7F113, 1);
      _id_E88E346FEAB6A5E9 = 1;
    }

    if(_id_E88E346FEAB6A5E9) {
      if(scripts\mp\utility\game::testgamemodestringlist(struct.script_gameobjectname, scripts\mp\utility\game::getgametype()))
        return 0;
    } else if(!scripts\mp\utility\game::testgamemodestringlist(struct.script_gameobjectname, scripts\mp\utility\game::getgametype())) {
      if(scripts\mp\utility\game::getgametype() == "brtdm" || scripts\mp\utility\game::getgametype() == "brtdm_mgl") {
        if(struct scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_isvehiclespawnStruct())
          return 1;
      } else if(istrue(level.isgroundwarsiege) || istrue(level._id_904F766B5267E332) || istrue(level._id_39A48A5896D2B3E8) || istrue(level._id_A0F41EC8E5268D15)) {
        if(issubstr(struct.script_gameobjectname, "arm"))
          return 1;
      }

      return 0;
    }
  }

  return 1;
}