/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_13ffccf97a3e3294.gsc
***********************************************/

register_objectives() {
  scripts\cp\cp_objectives::registerobjective("boss1_silo", ::default_init, _id_292D66D2E5A9D7DD::_id_185D82A83A8485D6, ::_id_7A75150EDB163514, ::_id_A732A4F1B84650EB);
  scripts\cp\cp_objectives::registerobjective("boss1_silo_end", ::default_init, _id_292D66D2E5A9D7DD::_id_3CAB251A752FBE38, ::_id_7A75150EDB163514, ::_id_A732A4F1B84650EB);
  scripts\cp\cp_objectives::registerobjective("boss1_fil", ::default_init, _id_63325153465F8869::_id_AB6A36F0CB210A12, ::_id_7A75150EDB163514, ::_id_A732A4F1B84650EB);
  scripts\cp\cp_objectives::registerobjective("boss1_fil_end", ::default_init, _id_63325153465F8869::_id_92CA8A9FEFF16CC4, ::_id_7A75150EDB163514, ::_id_A732A4F1B84650EB);
  scripts\cp\cp_objectives::registerobjective("boss1_fil_vent", ::default_init, _id_63325153465F8869::_id_6C8CBF370BE19AD0, ::_id_7A75150EDB163514, ::_id_A732A4F1B84650EB);
  scripts\cp\cp_objectives::registerobjective("boss1_p0", ::_id_D8596A9D899F6DB0, _id_6E32188470E934C0::_id_99D88F8F3450C7D3, ::_id_7A75150EDB163514, ::_id_A732A4F1B84650EB);
  scripts\cp\cp_objectives::registerobjective("boss1_p1", ::_id_D8596A9D899F6DB0, _id_031C9179F5060A17::_id_99D88E8F3450C5A0, ::_id_7A75150EDB163514, ::_id_A732A4F1B84650EB);
  scripts\cp\cp_objectives::registerobjective("boss1_p2", ::_id_D8596A9D899F6DB0, _id_5D0FD18631CB8A6A::_id_99D8918F3450CC39, ::_id_7A75150EDB163514, ::_id_A732A4F1B84650EB);
  scripts\cp\cp_objectives::registerobjective("boss1_p3", ::_id_D8596A9D899F6DB0, _id_468E1C93B8555C59::_id_99D8908F3450CA06, ::_id_7A75150EDB163514, ::_id_A732A4F1B84650EB);
}

_id_D8596A9D899F6DB0(objectivestruct) {
  _id_323248A3057C390F::_id_2D7992159C9B6DEF();
  _id_2C20A33CD30EEE5F::_id_59AE7C32A14BDA75();
  _id_6E32188470E934C0::_id_82CD563E25B04A17();
  _id_382959D7794736CC::_id_7C64BFFF3489F163();
  _id_382959D7794736CC::_id_EB03E98032508EDD();
}

_id_1C8DACB6A9CB95EB(objectivestruct) {}

default_init(objectivestruct) {}

_id_7A75150EDB163514(objectivestruct) {}

_id_A732A4F1B84650EB(objectivestruct) {}

_id_3035F25739C2DE36() {
  thread _id_63325153465F8869::_id_E2F7A251F300090B();
  scripts\engine\utility::flag_set("fil_exit_granted");
  level waittill("b1fildone");
  spawners = scripts\engine\utility::getStructArray("fil_exit_spawners", "targetname");
  ai = scripts\cp\cp_spawning_util::_id_81B8EDC3CB076FDA(spawners, 1);
  shield = undefined;
  squad = [];
  wait 0.1;

  foreach(guy in ai) {
    if(issubstr(guy.spawnpoint.script_noteworthy, "riotshield")) {
      shield = guy;
      continue;
    }

    squad[squad.size] = guy;
  }

  _id_382959D7794736CC::_id_E02EBB3647F59943(shield, squad);
}

_id_DB5A627EF4F05C84() {
  level.default_player_spawns = "b1_preintro_playerstart";
  scripts\engine\utility::flag_wait("silo_ready");
  scripts\cp\cp_spawning_util::_id_5EBBD91D2F142DBC();
  scripts\cp\cp_objectives::run_objective("boss1_silo");
}

_id_7D4126296031DE02() {
  level.default_player_spawns = "b1_silo_checkpoint_playerstart";
  scripts\engine\utility::flag_wait("silo_ready");
  scripts\cp\cp_spawning_util::_id_5EBBD91D2F142DBC();
  waitframe();
  _id_ECBE7C4CE50FD655 = getEntArray("intro_trigger", "script_noteworthy");

  foreach(trigger in _id_ECBE7C4CE50FD655) {
    if(isDefined(trigger))
      trigger delete();
  }

  scripts\cp\cp_objectives::run_objective("boss1_silo");
}

_id_3A2450AF7E20A08C() {
  level.default_player_spawns = "b1_silo_2nd_stop_playerstart";
  scripts\engine\utility::flag_wait("silo_ready");
  scripts\cp\cp_spawning_util::_id_5EBBD91D2F142DBC();
  _id_1DD61007981AA444();
}

_id_14FCE377A543D48D() {
  level.default_player_spawns = "b1_silo_2nd_power_playerstart";
  scripts\engine\utility::flag_wait("silo_ready");
  scripts\cp\cp_spawning_util::_id_5EBBD91D2F142DBC();
  _id_98A458C5D2003355();
}

_id_ED342BB672D2B406() {
  level.default_player_spawns = "b1_silo_end_playerstart";
  scripts\engine\utility::flag_wait("silo_ready");
  scripts\cp\cp_spawning_util::_id_5EBBD91D2F142DBC();
  scripts\cp\cp_objectives::run_objective("boss1_silo_end");
}

_id_065CD87C519857A8() {
  level.default_player_spawns = "fil_playerstart";
  scripts\engine\utility::flag_wait("fil_ready");
  scripts\cp\cp_spawning_util::_id_5EBBD91D2F142DBC();
  thread _id_63325153465F8869::_id_68D137712CA50204("off");
  _id_E2FCC8B73FAACA90();
}

_id_9687F16772093008() {
  level.default_player_spawns = "b1_fil_power_players";
  scripts\engine\utility::flag_wait("fil_ready");
  scripts\cp\cp_spawning_util::_id_5EBBD91D2F142DBC();
  thread _id_63325153465F8869::_id_68D137712CA50204("on");
  _id_D6B82742B27A9B1E();
}

_id_9F0486282F27E5FA() {
  level.default_player_spawns = "b1_fil_end_players";
  scripts\engine\utility::flag_wait("fil_ready");
  scripts\cp\cp_spawning_util::_id_5EBBD91D2F142DBC();
  thread _id_63325153465F8869::_id_68D137712CA50204("on");
  _id_A9BC61A62EEDEB42();
}

_id_C4ACB631CECF956E() {
  level.default_player_spawns = "b1_fil_vent_players";
  scripts\engine\utility::flag_wait("fil_ready");
  scripts\cp\cp_spawning_util::_id_5EBBD91D2F142DBC();
  _id_8156A44154FE2406();
}

_id_A7CD25832CBE97B9() {
  level.default_player_spawns = "b1_p0_playerstart";
  scripts\engine\utility::flag_wait("subarea_ready");

  if(getdvarint("dvar_F0F10B52A800D290", 0) > 0)
    _id_36C7891014DB2455();

  scripts\cp\cp_spawning_util::_id_5EBBD91D2F142DBC();
  _id_D8596A9D899F6DB0();
  thread scripts\cp\cp_objectives::run_objective("boss1_p0");
}

_id_A7CD24832CBE9586() {
  level.default_player_spawns = "b1_p1_playerstart";
  scripts\engine\utility::flag_wait("subarea_ready");
  level._id_18525BF7CFF43F59 = 1;
  _id_36C7891014DB2455();
  scripts\cp\cp_spawning_util::_id_5EBBD91D2F142DBC();
  _id_D8596A9D899F6DB0();
  level thread _id_031C9179F5060A17::_id_B00C1AA0FF8EA651();
  _id_CEA25F77EA05F41E();
}

_id_A7CD23832CBE9353() {
  level.default_player_spawns = "b1_p2_playerstart";
  scripts\engine\utility::flag_wait("subarea_ready");
  level._id_18525BF7CFF43F59 = 1;
  _id_36C7891014DB2455();
  scripts\cp\cp_spawning_util::_id_5EBBD91D2F142DBC();
  _id_D8596A9D899F6DB0();
  _func_AC735EEE7BC507F6(126);
  _id_CEA25E77EA05F1EB();
}

_id_A7CD22832CBE9120() {
  level.default_player_spawns = "p3_playerstart";
  scripts\engine\utility::flag_wait("subarea_ready");
  level._id_18525BF7CFF43F59 = 1;
  _id_36C7891014DB2455();
  scripts\cp\cp_spawning_util::_id_5EBBD91D2F142DBC();
  _id_D8596A9D899F6DB0();
  _func_AC735EEE7BC507F6(126);
  _id_CEA25D77EA05EFB8();
}

_id_36C7891014DB2455() {
  trig = getEnt("p0_trigger_spawner", "targetname");

  if(isDefined(trig))
    trig delete();
}

_id_1DD61007981AA444() {
  scripts\engine\utility::flag_wait("player_spawned_with_loadout");
  scripts\engine\utility::flag_set("goto_silo_2nd_stop");
  scripts\cp\cp_objectives::run_objective("boss1_silo");
}

_id_98A458C5D2003355() {
  scripts\engine\utility::flag_wait("player_spawned_with_loadout");
  scripts\engine\utility::flag_set("goto_silo_2nd_power");
  scripts\cp\cp_objectives::run_objective("boss1_silo");
}

_id_E2FCC8B73FAACA90() {
  scripts\engine\utility::flag_wait("player_spawned_with_loadout");
  thread _id_63325153465F8869::_id_CB0BF566D166218B();
  scripts\cp\cp_objectives::run_objective("boss1_fil");
}

_id_D6B82742B27A9B1E() {
  scripts\engine\utility::flag_wait("player_spawned_with_loadout");

  if(!scripts\engine\utility::flag_exist("goto_fil_power")) {
    scripts\engine\utility::flag_init("goto_fil_power");
    scripts\engine\utility::flag_set("goto_fil_power");
  }

  scripts\cp\cp_objectives::run_objective("boss1_fil");
}

_id_A9BC61A62EEDEB42() {
  scripts\engine\utility::flag_wait("player_spawned_with_loadout");
  scripts\cp\cp_objectives::run_objective("boss1_fil_end");
}

_id_8156A44154FE2406() {
  scripts\engine\utility::flag_wait("player_spawned_with_loadout");
  scripts\cp\cp_objectives::run_objective("boss1_fil_vent");
}

_id_CEA25F77EA05F41E() {
  scripts\engine\utility::flag_wait("player_spawned_with_loadout");
  _id_382959D7794736CC::_id_E458190349EE6968();
  _id_60008A9093C7A9B5::_id_7624BFD29CC1CB18();
  level thread _id_60008A9093C7A9B5::_id_9087E9EF731F305C();
  level._id_E2958F412A7425C0 = _id_382959D7794736CC::_id_C9A7AC016440B3C0();
  _id_594132FAB60AA90D::_id_246582E2CB860BCD();
  thread _id_382959D7794736CC::_id_5BFBD6454C40219F();
  scripts\engine\utility::flag_set("bay_flooded");
  scripts\engine\utility::flag_set("p0_finished");
  scripts\cp\cp_objectives::run_objective("boss1_p1");
}

_id_9580ECCE8D201C4F() {}

_id_CEA25E77EA05F1EB() {
  scripts\engine\utility::flag_wait("player_spawned_with_loadout");
  _id_382959D7794736CC::_id_E458190349EE6968();
  _id_63BA37D826ED10D6 = getEntArray("spawn_door_monitor", "targetname");
  scripts\engine\utility::array_thread(_id_63BA37D826ED10D6, _id_382959D7794736CC::_id_E8BA0B0361B31FDC);
  _id_60008A9093C7A9B5::_id_7624BFD29CC1CB18();
  level thread _id_60008A9093C7A9B5::_id_9087E9EF731F305C();
  level._id_E2958F412A7425C0 = _id_382959D7794736CC::_id_C9A7AC016440B3C0();
  thread _id_382959D7794736CC::_id_5BFBD6454C40219F();
  scripts\engine\utility::flag_set("bay_flooded");
  scripts\engine\utility::flag_set("p0_finished");
  scripts\engine\utility::flag_clear("pump1_pressed");
  scripts\engine\utility::flag_clear("pump2_pressed");
  scripts\engine\utility::flag_clear("spawning_reinforcements");
  _id_29B359C42D27501C = getEntArray("left_needle_indicator", "targetname");
  _id_29B30FC42D26AD5E = getEntArray("right_needle_indicator", "targetname");
  lights = scripts\engine\utility::array_combine(_id_29B359C42D27501C, _id_29B30FC42D26AD5E);

  foreach(light in lights)
  light setModel("electronics_elevator_security_lock_console_a_green_light_on");

  scripts\engine\utility::flag_set("p1_finished");
  scripts\cp\cp_objectives::run_objective("boss1_p2");
}

_id_CEA25D77EA05EFB8() {
  scripts\engine\utility::flag_wait("player_spawned_with_loadout");
  _id_382959D7794736CC::_id_E458190349EE6968();
  _id_63BA37D826ED10D6 = getEntArray("spawn_door_monitor", "targetname");
  scripts\engine\utility::array_thread(_id_63BA37D826ED10D6, _id_382959D7794736CC::_id_E8BA0B0361B31FDC);
  _id_60008A9093C7A9B5::_id_7624BFD29CC1CB18();
  level thread _id_60008A9093C7A9B5::_id_9087E9EF731F305C();
  level._id_E2958F412A7425C0 = _id_382959D7794736CC::_id_C9A7AC016440B3C0();
  thread _id_382959D7794736CC::_id_5BFBD6454C40219F();
  scripts\engine\utility::flag_set("bay_flooded");
  scripts\engine\utility::flag_set("p0_finished");
  scripts\engine\utility::flag_clear("spawning_reinforcements");
  scripts\engine\utility::flag_set("p1_finished");
  scripts\engine\utility::flag_set("manualoverride");
  scripts\engine\utility::flag_set("explosivespickedup");
  scripts\engine\utility::flag_set("p2_finished");
  thread scripts\cp\cp_objectives::run_objective("boss1_p3");
}

_id_D686CFE6F2435D1F(_id_BEAF0054EE3EBF70, _id_365A0918B795C6EC) {
  level endon("game_ended");
  self endon("death");
  self endon("stop_boss_behavior");
  self.ignoreall = 1;
  self allowedstances("stand");
  self.combatmode = "no_cover";
  self.sprint = 1;
  scripts\common\utility::demeanor_override("sprint");
  level endon(_id_365A0918B795C6EC);

  if(_id_BEAF0054EE3EBF70 == "flood_bay") {
    self.goalradius = 8;
    _id_0C3EA9B1A20FF199 = scripts\engine\utility::getStruct("boss_attack_drone", "targetname");
    self setgoalpos(_id_0C3EA9B1A20FF199.origin);
    self forceteleport(_id_0C3EA9B1A20FF199.origin, _id_0C3EA9B1A20FF199.angles);
    self waittill("goal");
    return;
  } else if(_id_BEAF0054EE3EBF70 == "raise_water") {
    _id_961758FA37D226ED = scripts\engine\utility::getStructArray("boss_observe", "targetname");
    _id_FDC11BA76911059E = scripts\engine\utility::get_array_of_closest(self.origin, _id_961758FA37D226ED, undefined, 2);
    _id_0C3EA9B1A20FF199 = scripts\engine\utility::random(_id_FDC11BA76911059E);
    self.goalradius = 16;
    self setgoalpos(_id_0C3EA9B1A20FF199.origin);
    self waittill("goal");
    self forceteleport(_id_0C3EA9B1A20FF199.origin, _id_0C3EA9B1A20FF199.angles);
    wait 30;
  } else if(_id_BEAF0054EE3EBF70 == "reach_catwalks")
    wait 30;

  self clearbtgoal(0);
  self setgoalpos(self.origin);
  _id_5A9E083A522CD2AE = undefined;
  _id_D2489B37BC7EDC92 = undefined;

  for(;;) {
    _id_E4CDDEB258C9D6C4 = scripts\engine\utility::cointoss();

    if(isDefined(_id_5A9E083A522CD2AE)) {
      _id_E4CDDEB258C9D6C4 = _id_5A9E083A522CD2AE;
      _id_5A9E083A522CD2AE = undefined;
      _id_D2489B37BC7EDC92 = undefined;
    }

    if(isDefined(_id_D2489B37BC7EDC92) && _id_D2489B37BC7EDC92 == _id_E4CDDEB258C9D6C4)
      _id_5A9E083A522CD2AE = !_id_E4CDDEB258C9D6C4;

    _id_D2489B37BC7EDC92 = _id_E4CDDEB258C9D6C4;

    if(getdvarint("dvar_5F6F711630EB043E", 0) > 0)
      _id_F00DBDF6879D453E = _id_E4CDDEB258C9D6C4;

    if(_id_E4CDDEB258C9D6C4) {
      level notify("boss_started_new_attack");
      _id_2C20A33CD30EEE5F::_id_C01ABBA465C912C6("subpen");
    } else {
      level notify("boss_started_new_attack");

      if(_id_BEAF0054EE3EBF70 == "reach_catwalks")
        _id_323248A3057C390F::_id_401DA6FCA69E6822("subpen2");
      else
        _id_323248A3057C390F::_id_401DA6FCA69E6822("subpen");
    }

    _id_E72DF84284082E47 = gettime() + randomfloatrange(60, 85) * 1000;

    while(gettime() < _id_E72DF84284082E47)
      wait 0.1;
  }
}

_id_B3B81B456865689E() {
  triggers = getEntArray("intro_trigger", "script_noteworthy");

  foreach(trigger in triggers)
  trigger scripts\engine\utility::trigger_off();
}

_id_366AA8B098553BA0(_id_1730C8D8475566CD, _id_FB1DEF007972B25A, reviveent) {
  _id_9DDF8D4378FCEB16 = scripts\engine\utility::getStructArray("static_death_cam", "script_noteworthy");
  _id_F42869166D50FBE9 = scripts\cp\cp_checkpoint::_id_9EED75023A958C18();

  if(!isDefined(_id_F42869166D50FBE9) || _id_F42869166D50FBE9 == "")
    _id_F42869166D50FBE9 = getDvar("start");

  _id_5C72B818B0325D8C = undefined;

  if(isDefined(_id_F42869166D50FBE9)) {
    switch (_id_F42869166D50FBE9) {
      case "boss1_silo_2nd_stop":
      case "boss1_silo_power":
      case "boss1_silo_end":
      case "silo_end":
      case "silo_2nd_stop":
      case "silo_power":
      case "silo":
        _id_5C72B818B0325D8C = _id_E0CF5BA976B37016(_id_9DDF8D4378FCEB16, "silo");
        break;
      case "boss1_fil_p":
      case "boss1_fil":
      case "boss1_fil_end":
      case "floor_is_lava_end":
      case "floor_is_lava_power":
      case "floor_is_lava":
        _id_5C72B818B0325D8C = _id_E0CF5BA976B37016(_id_9DDF8D4378FCEB16, "FIL");
        break;
      case "subpen_saw_door":
      case "b1_p3":
      case "b1_p2":
      case "b1_p1":
      case "b1_p0":
      case "subpen_reach_catwalks":
      case "subpen_raise_water_2":
      case "subpen_raise_water_1":
        _id_5C72B818B0325D8C = _id_E0CF5BA976B37016(_id_9DDF8D4378FCEB16, "sub_bay");
        break;
      default:
        _id_5C72B818B0325D8C = scripts\engine\utility::getclosest(_id_1730C8D8475566CD.origin, _id_9DDF8D4378FCEB16);
        break;
    }
  } else
    _id_5C72B818B0325D8C = scripts\engine\utility::getclosest(_id_1730C8D8475566CD.origin, _id_9DDF8D4378FCEB16);

  startpos = _id_5C72B818B0325D8C.origin;
  mover = spawn("script_model", startpos);
  mover setModel("tag_origin");
  mover.angles = _id_5C72B818B0325D8C.angles;
  mover thread _id_0AFB7E332AEE4BF2::cleanuplaststandent(_id_1730C8D8475566CD);
  _id_1730C8D8475566CD cameralinkTo(mover, "tag_origin");
  wait 2;
  mover delete();
}

_id_E0CF5BA976B37016(_id_A260750D2D3EB8B6, _id_838DCE3ED0A1A11C) {
  foreach(cam in _id_A260750D2D3EB8B6) {
    if(isDefined(cam.targetname) && cam.targetname == _id_838DCE3ED0A1A11C)
      return cam;
  }

  return undefined;
}