/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2028.gsc
*************************************************/

main() {
  if(isDefined(level._id_0C53)) {
    return;
  }
  level._id_6016 = [];
  level._id_0C53 = 1;
  level._id_3FD9 = getDvar("#x3ae2cde154e196de") != "";
  level._id_B786 = [];
  level._id_EA71 = ::_id_5A57;
  scripts\engine\utility::_id_80CB();
  _id_07D1::_id_819E();
  _id_07D1::_id_820E();
  thread scripts\mp\playerlogic::_id_BECC();
  _id_07D1::_id_9353("scriptables_ready", 0);
  _id_0810::_id_CF0B();
  level._id_629E = 0;
  level._id_5C1F = spawnStruct();
  level._id_5C1F _id_079E::_id_1D10();

  if(!isDefined(level._id_5C00)) {
    level._id_5C00 = [];
    level._id_5C45 = [];
  }

  level._id_3FB0 = scripts\mp\hud_util::createfontstring;
  level._id_7B93 = scripts\mp\hud_util::setpoint;

  if(!isDefined(level._id_F8D5)) {
    thread scripts\mp\tweakables::init();
  }

  if(!isDefined(level._id_6016)) {
    level._id_6016 = [];
  }

  level._id_6016["precacheMpAnim"] = ::_func_01AF;
  level._id_6016["scriptModelPlayAnim"] = ::_meth_82CB;
  level._id_6016["scriptModelClearAnim"] = ::_meth_82CA;

  if(!level._id_3FD9) {
    thread _id_07F3::_id_9EDE();
    thread scripts\mp\movers::init();
    thread _id_07C6::init();
    thread _id_06D3::init();
    level notify("interactive_start");
  }

  game["thermal_vision"] = "thermal_mp";
  visionsetnaked("", 0);
  scripts\mp\utility\player::_id_8108();
  visionsetmissilecam("missilecam");
  visionsetthermal(game["thermal_vision"]);
  visionsetpain(scripts\engine\utility::ter_op(scripts\cp_mp\utility\game_utility::isnightmap(), "pain_mp_night", "pain_mp"), 0);
  var_0 = getEntArray("lantern_glowFX_origin", "targetname");

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    var_0[var_1] thread _id_8EB3();
  }

  _id_07B0::_id_7EF6();
  scripts\mp\art::main();
  thread _id_06D6::_id_819D();
  _id_06D4::_id_D86A();
  _id_07AA::init();

  if(level._id_3FD9) {
    _id_0817::_id_D5ED();
    _id_07C2::_id_3FD1();
  }

  if(getDvar("#x3a8fb0620196c6263") == "1") {
    _id_07C9::_id_C19A();
    _id_07C9::_id_C199();
    _id_0817::_id_D5ED();
    _id_07D9::main();
    level waittill("eternity");
  }

  thread _id_07D9::main();

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
      if(isDefined(var_4[var_1]._id_CE28)) {
        var_4[var_1]._id_0397 = var_4[var_1]._id_CE28;
      }

      if(isDefined(var_4[var_1]._id_0397)) {
        level thread _id_57C4(var_4[var_1]);
      }

      if(var_3 == "trigger_multiple_arbitrary_up") {
        var_5 = var_4[var_1];
        var_5 _meth_84E8(1);

        if(isDefined(var_5.target)) {
          var_6 = getent(var_5.target, "targetname");
          var_5 _meth_80DB();
          var_5 linkto(var_6);
        }
      }
    }
  }

  thread _id_07AB::main();
  level._id_6016["damagefeedback"] = _id_07C4::_id_FC47;
  level._id_8F02 = ::_meth_8203;
  level._id_8F01 = ::_meth_8202;
  level._id_3B85 = ::_meth_8093;
  level._id_4B18 = ::_meth_80B5;
  level._id_5D69 = scripts\mp\class::buildweapon;
  level._id_5D91 = scripts\mp\utility\weapon::getweaponrootname;
  setDvar("#x34c469068b0b444ae", 1);
  setDvar("#x32e12905a139aa445", 1);
  _id_D861();
  level._id_59E1 = 0;
  level thread _id_07A2::_id_EC4C();
  level thread _id_0828::init();
  level thread scripts\mp\s4_elf_poi::init();
  scripts\common\utility::_id_E28D();
  _id_09E9::_id_7B3F();
  thread _id_06D5::init();
  thread scripts\common\base_infil_prompts::init_base_infil_prompts();
  thread scripts\common\base_warnings::init_base_warnings();
  thread scripts\common\infil_ftue::init_infil_ftue();

  if(getdvarint("#x3965a86c0b17996d3") == 1 && !scripts\mp\utility\game::isanymlgmatch()) {
    var_7 = scripts\mp\agents\krampus\think::getkrampusspawnchance();
    var_8 = randomint(100);

    if(var_8 < var_7) {
      thread scripts\mp\agents\krampus\think::main();
    }
  }
}

_id_57C4(var_0) {
  level endon("killexplodertridgers" + var_0._id_0397);
  var_0 waittill("trigger");

  if(isDefined(var_0._id_CCD7) && randomfloat(1) > var_0._id_CCD7) {
    if(isDefined(var_0._id_0393)) {
      wait(var_0._id_0393);
    } else {
      wait 4;
    }

    level thread _id_57C4(var_0);
    return;
  }

  scripts\engine\utility::_id_57BA(var_0._id_0397);
  level notify("killexplodertridgers" + var_0._id_0397);
}

_id_8EB3() {
  if(!isDefined(level._effect["lantern_light"])) {
    level._effect["lantern_light"] = loadfx("vfx/props/glow_latern");
  }

  _id_06D6::_id_9836("lantern_light", self.origin, 0.3, self.origin + (0, 0, 1));
}

_id_D861() {
  var_0 = getEntArray("scriptable_destructible_vehicle", "targetname");

  foreach(var_2 in var_0) {
    var_3 = var_2.origin + (0, 0, 5);
    var_4 = var_2.origin + (0, 0, 128);
    var_5 = scripts\engine\trace::_bullet_trace(var_3, var_4, 0, var_2);
    var_2.killcament = spawn("script_model", var_5["position"]);
    var_2.killcament._id_0481 = "killCamEnt_destructible_vehicle";
    var_2.killcament _meth_8375("explosive");
    var_2 thread _id_4764();
  }

  var_7 = getEntArray("scriptable_destructible_barrel", "targetname");

  foreach(var_2 in var_7) {
    var_3 = var_2.origin + (0, 0, 5);
    var_4 = var_2.origin + (0, 0, 128);
    var_5 = scripts\engine\trace::_bullet_trace(var_3, var_4, 0, var_2);
    var_2.killcament = spawn("script_model", var_5["position"]);
    var_2.killcament._id_0481 = "killCamEnt_explodable_barrel";
    var_2.killcament _meth_8375("explosive");
    var_2 thread _id_4764();
  }
}

_id_4764() {
  level endon("game_ended");
  var_0 = self.killcament;
  var_0 endon("death");
  self waittill("death");
  wait 10;

  if(isDefined(var_0)) {
    var_0 delete();
  }
}

_id_5A57(var_0) {
  if(scripts\cp_mp\vehicles\vehicle_spawn::_id_1027C() && scripts\cp_mp\vehicles\vehicle_spawn::_id_1027D()) {
    if(var_0 scripts\cp_mp\vehicles\vehicle_spawn::_id_1027E()) {
      return 1;
    }
  }

  if(isDefined(var_0._id_CD69)) {
    var_1 = var_0._id_CD69;
    var_2 = 0;

    if(_func_00D6(var_1, 0, 1) == "!") {
      var_1 = _func_00D6(var_1, 1);
      var_2 = 1;
    }

    if(var_2) {
      if(scripts\mp\utility\game::_id_F0D8(var_0._id_CD69, scripts\mp\utility\game::getgametype())) {
        return 0;
      }
    } else if(!scripts\mp\utility\game::_id_F0D8(var_0._id_CD69, scripts\mp\utility\game::getgametype()))
      return 0;
  }

  return 1;
}