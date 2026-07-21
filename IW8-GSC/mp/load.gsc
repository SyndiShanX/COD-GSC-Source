/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\load.gsc
***********************************************/

main() {
  if(isDefined(level._loadstarted)) {
    return;
  }
  level.func = [];
  level._loadstarted = 1;
  level.createfx_enabled = getDvar("_encstr_A7A10BE87FB447783F6F314482") != "_encstr_B40101";
  level.players_waiting_for_callback = [];
  level.struct_filter = ::filterstructs;
  scripts\engine\utility::init_struct_class();
  scripts\mp\flags::initgameflags();
  scripts\mp\flags::initlevelflags();
  thread scripts\mp\playerlogic::queueconnectednotify();
  scripts\mp\flags::levelflaginit("_encstr_ABEC127358A564FBBB9F4A4CA5637F6A23D08A2B", 0);
  scripts\mp\scriptable::scriptable_mpglobalcallback();
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

  if(!isDefined(level.func))
    level.func = [];

  level.func["_encstr_B67F0FABE31D3FEEA011AD9D39E9755FB1"] = ::precachempanim;
  level.func["_encstr_848A141BAFF834B34DD472CA39A9EBADC823A19ED378"] = ::scriptmodelplayanim;
  level.func["_encstr_9B9B15B307509C0BF57C2AA241C10F1530EB4A09852025"] = ::scriptmodelclearanim;

  if(!level.createfx_enabled) {
    thread scripts\mp\minefields::minefields();
    thread scripts\mp\movers::init();
    thread scripts\mp\destructables::init();
    thread scripts\common\elevator::init();
    level notify("_encstr_8AA312D06574283E1A9FF1F3F36290D02C3E3B0B");
  }

  game["_encstr_8E4A0FA5C837EB73F67241705A0A33ED43"] = "_encstr_AD830B4786ACC96B0B8DF55BE0";
  visionsetnaked("_encstr_B40101", 0);
  scripts\mp\utility\player::init_visionsetnight();
  visionsetmissilecam("_encstr_A3DD0BD6B46EE6D2C6CA6C2CD6");
  visionsetthermal(game["_encstr_8E4A0FA5C837EB73F67241705A0A33ED43"]);
  visionsetpain(scripts\engine\utility::ter_op(scripts\cp_mp\utility\game_utility::isnightmap(), "_encstr_A2220E0B57101A7187E131FDDADFAB8B", "_encstr_9B0E08E058D2B9D7B538"), 0);
  var_0 = getEntArray("_encstr_8F4516F2BEB5839BDED6480F35508FED39D9A21D890C3C20", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  for(var_1 = 0; var_1 < var_0.size; var_1++)
    var_0[var_1] thread lanterns();

  scripts\mp\audio::init_audio();
  scripts\mp\art::main();
  thread scripts\common\fx::initfx();
  scripts\common\exploder::setupexploders();
  scripts\mp\anim::init();

  if(level.createfx_enabled) {
    scripts\mp\spawnlogic::setmapcenterfordev();
    scripts\mp\createfx::createfx();
  }

  if(getDvar("_encstr_8F7A0BD1E5E15304B8CF7989FF") == "_encstr_A34C02BB") {
    scripts\mp\dev::reflectionprobe_hide_hp();
    scripts\mp\dev::reflectionprobe_hide_front();
    scripts\mp\spawnlogic::setmapcenterfordev();
    scripts\mp\global_fx::main();
    level waittill("_encstr_9140093575E183DD9398A3");
  }

  thread scripts\mp\global_fx::main();

  for(var_2 = 0; var_2 < 7; var_2++) {
    switch (var_2) {
      case 0:
        var_3 = "_encstr_A70911F16A4C28BC9F231658BB53ED80A2DC6B";
        break;
      case 1:
        var_3 = "_encstr_B1F70D1B2D73B2A790FB797D5088ED";
        break;
      case 2:
        var_3 = "_encstr_AFF60C939B634707C80DAF8DE720";
        break;
      case 3:
        var_3 = "_encstr_956B0F193B6244C0659AE65B464C78857B";
        break;
      case 4:
        var_3 = "_encstr_B4E70FD303A4CF8F19BB6FA985B0AFB6DB";
        break;
      case 5:
        var_3 = "_encstr_8AE91ED139D2ECD995277DB5EAB13A961C36AC7DC29C894BD1C985E4BCAFBA38";
        break;
      default:
        var_3 = "_encstr_A68E0FE89CB4ECCEACE4EB190BB52CB3B2";
        break;
    }

    var_4 = getEntArray(var_3, "_encstr_AC110A7F14873B5B3D073009");

    for(var_1 = 0; var_1 < var_4.size; var_1++) {
      if(isDefined(var_4[var_1].script_prefab_exploder))
        var_4[var_1].script_exploder = var_4[var_1].script_prefab_exploder;

      if(isDefined(var_4[var_1].script_exploder))
        level thread exploder_load(var_4[var_1]);

      if(var_3 == "_encstr_8AE91ED139D2ECD995277DB5EAB13A961C36AC7DC29C894BD1C985E4BCAFBA38") {
        var_5 = var_4[var_1];
        var_5 setworlduptrigger(1);

        if(isDefined(var_5.target)) {
          var_6 = getEnt(var_5.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
          var_5 enablelinkTo();
          var_5 linkTo(var_6);
        }
      }
    }
  }

  thread scripts\mp\animatedmodels::main();
  level.func["_encstr_B2A90FEFEBD383378B83E16D80DD217880"] = scripts\mp\damagefeedback::updatedamagefeedback;
  level.laseron_func = ::laseron;
  level.laseroff_func = ::laseroff;
  level.connectpathsfunction = ::connectpaths;
  level.disconnectpathsfunction = ::disconnectpaths;
  level.fnbuildweapon = scripts\mp\class::buildweapon;
  level.fngetweaponrootname = scripts\mp\utility\weapon::getweaponrootname;
  setDvar("_encstr_A9280C3308DE1668F78B94FBD607", 1);
  setDvar("_encstr_A3850F53A45F9833FACF83F393A2894028", 1);
  setupdestructiblekillcaments();
  level.fauxvehiclecount = 0;
  level thread scripts\engine\scriptable_door::system_init();
  scripts\common\utility::_id_13629();
}

exploder_load(var_0) {
  level endon("_encstr_A52E1530D025BD154BEF787201EFEBED9DC0687C2B5372" + var_0.script_exploder);
  var_0 waittill("_encstr_8F5C086405E70FBA4B4A");

  if(isDefined(var_0.script_chance) && randomfloat(1) > var_0.script_chance) {
    if(isDefined(var_0.script_delay))
      wait(var_0.script_delay);
    else
      wait 4;

    level thread exploder_load(var_0);
    return;
  }

  scripts\engine\utility::exploder(var_0.script_exploder);
  level notify("_encstr_A52E1530D025BD154BEF787201EFEBED9DC0687C2B5372" + var_0.script_exploder);
}

lanterns() {
  if(!isDefined(level._effect["_encstr_AF560ED9616558453B0A0E5042578B10"]))
    level._effect["_encstr_AF560ED9616558453B0A0E5042578B10"] = loadfx("_encstr_977A167E7AA0559BB29780F8D0F993787F19108F5359856A");

  scripts\common\fx::loopfx("_encstr_AF560ED9616558453B0A0E5042578B10", self.origin, 0.3, self.origin + (0, 0, 1));
}

setupdestructiblekillcaments() {
  var_0 = getEntArray("_encstr_914220DFDFBB0343F5918AB953E7C3D347F5EAEBB0EB038D727DA704B0DB5316247A", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_2 in var_0) {
    var_3 = var_2.origin + (0, 0, 5);
    var_4 = var_2.origin + (0, 0, 128);
    var_5 = scripts\engine\trace::_bullet_trace(var_3, var_4, 0, var_2);
    var_2.killcament = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_5["_encstr_BD260953AA97E3F014279D"]);
    var_2.killcament.targetname = "_encstr_85CD209770B02C708BF907C55DCF3AEDFBA37B17C86B912AF98599FBCD4922B36020";
    var_2.killcament setscriptmoverkillcam("_encstr_AB440A3180D0C0109B17550B");
    var_2 thread deletedestructiblekillcament();
  }

  var_7 = getEntArray("_encstr_A29A1FCB508E514BBB01224A3A69FB1F13099ADBAFCBA05A933FB910C8C3754A59", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_2 in var_7) {
    var_3 = var_2.origin + (0, 0, 5);
    var_4 = var_2.origin + (0, 0, 128);
    var_5 = scripts\engine\trace::_bullet_trace(var_3, var_4, 0, var_2);
    var_2.killcament = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_5["_encstr_BD260953AA97E3F014279D"]);
    var_2.killcament.targetname = "_encstr_A6761DEA09D3E8EF36A251F0CB416BA27BA460D5998390FB917A781883E701";
    var_2.killcament setscriptmoverkillcam("_encstr_AB440A3180D0C0109B17550B");
    var_2 thread deletedestructiblekillcament();
  }
}

deletedestructiblekillcament() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 = self.killcament;
  var_0 endon("_encstr_AD75063D571AE108");
  self waittill("_encstr_AD75063D571AE108");
  wait 10;

  if(isDefined(var_0))
    var_0 delete();
}

filterstructs(var_0) {
  if(scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_iscodevehicletest() && scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_iscodevehicletestlevel()) {
    if(var_0 scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_isvehiclespawnStruct())
      return 1;
  }

  if(isDefined(var_0.script_gameobjectname)) {
    var_1 = var_0.script_gameobjectname;
    var_2 = 0;

    if(getsubstr(var_1, 0, 1) == "_encstr_AD4C0212") {
      var_1 = getsubstr(var_1, 1);
      var_2 = 1;
    }

    if(var_2) {
      if(scripts\mp\utility\game::testgamemodestringlist(var_0.script_gameobjectname, scripts\mp\utility\game::getgametype()))
        return 0;
    } else if(!scripts\mp\utility\game::testgamemodestringlist(var_0.script_gameobjectname, scripts\mp\utility\game::getgametype())) {
      if(scripts\mp\utility\game::getgametype() == "_encstr_931D068662634370") {
        if(var_0 scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_isvehiclespawnStruct())
          return 1;
      } else if(istrue(level.unset_relic_lfo)) {
        if(var_0.script_gameobjectname == "_encstr_B81904B04E6B")
          return 1;
      }

      return 0;
    }
  }

  var_3 = var_0.script_noteworthy;

  if(isDefined(var_3)) {
    if(level._id_11AD3 == 1) {
      if(var_3 == "_encstr_B27706C1CF833659")
        return 1;
      else if(var_3 == "_encstr_8A1804CF18C5")
        return 0;
    } else if(var_3 == "_encstr_8A1804CF18C5")
      return 1;
    else if(var_3 == "_encstr_B27706C1CF833659")
      return 0;
  }

  return 1;
}