/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_29b1b663f9b50d05.gsc
***********************************************/

main() {
  _id_358A96F6175CECC1::main();
  _id_79EFBD5FAF9800B2::main();
  _id_66F420400FE7947E::main();
  _id_46FAC2E4A783A004::main();
  scripts\mp\load::main();
  level.outofboundstriggers = getEntArray("OutOfBounds", "targetname");
  level.kill_border_triggers = getEntArray("kill_border_trigger", "targetname");
  scripts\mp\compass::setupminimap("compass_map_mp_grandprix_pm_2");
  _id_1311C5C284DD1537::_id_57D6A393B90824DC(300);
  setDvar("r_umbraMinObjectContribution", 8);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  level _id_3C37E8E4377AA2B3();
  thread scripts\mp\animation_suite::animationsuite();

  if(getdvarint("dvar_8610CCD25560C117") == 0) {
    thread _id_22D068CE810E9E17();
    thread _id_1369FBF85A2DE7BD();
    thread play_movie("mp_grandprix_pm_screens");
    thread setup_vista_driving_boats();
    thread audio_panodes();
  }

  level._id_B6E3760A75368EFC = ::_id_39C509138C3A65DB;
  level._id_D39AA4B67CEFA0D6 = "sfx_grandprix_car_kill_cam";
  level._id_E583F93D55F32680 = 0;
  level._id_1C6C30ED2A88578B = 0;
  level._id_1C4946ED2A624035 = 6;
  _id_4607C63644347235();
  _id_D7517C880A88D114();
}

_id_4607C63644347235() {
  _id_20ED61B3A7E08776 = getEntArray("prix_sign_bink", "targetname");

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_20ED61B3A7E08776.size; _id_AC0E594AC96AA3A8++)
    _id_20ED61B3A7E08776[_id_AC0E594AC96AA3A8] hide();
}

_id_1682CF22619A5E55() {
  level waittill("infil_setup_complete");
  _id_6120DF12544987E8 = getEnt("static_infil_van", "targetname");

  if(scripts\mp\flags::gameflag("infil_will_run") && isDefined(_id_6120DF12544987E8))
    _id_6120DF12544987E8 hide();
}

play_movie(bink) {
  if(getdvarint("r_reflectionprobegenerate") == 1) {
    return;
  }
  for(;;) {
    _func_CE942237D1ECA7D8(bink);
    wait 30;
  }
}

#using_animtree("script_model");

_id_22D068CE810E9E17() {
  level.scr_animtree["race_car"] = #animtree;
  level.scr_anim["race_car"]["mp_grandprix_racecar_anim_01"] = % iw9_mp_prop_grandprix_car_01;
  level.scr_animname["race_car"]["mp_grandprix_racecar_anim_01"] = "iw9_mp_prop_grandprix_car_01";
  level.scr_anim["race_car"]["mp_grandprix_racecar_anim_02"] = % iw9_mp_prop_grandprix_car_02;
  level.scr_animname["race_car"]["mp_grandprix_racecar_anim_02"] = "iw9_mp_prop_grandprix_car_02";
  level.scr_anim["race_car"]["mp_grandprix_racecar_anim_03"] = % iw9_mp_prop_grandprix_car_03;
  level.scr_animname["race_car"]["mp_grandprix_racecar_anim_03"] = "iw9_mp_prop_grandprix_car_03";
  level.scr_anim["race_car"]["mp_grandprix_racecar_anim_04"] = % iw9_mp_prop_grandprix_car_04;
  level.scr_animname["race_car"]["mp_grandprix_racecar_anim_04"] = "iw9_mp_prop_grandprix_car_04";
  level.scr_anim["race_car"]["mp_grandprix_racecar_anim_05"] = % iw9_mp_prop_grandprix_car_05;
  level.scr_animname["race_car"]["mp_grandprix_racecar_anim_05"] = "iw9_mp_prop_grandprix_car_05";
  level.scr_anim["race_car"]["mp_grandprix_racecar_anim_06"] = % iw9_mp_prop_grandprix_car_06;
  level.scr_animname["race_car"]["mp_grandprix_racecar_anim_06"] = "iw9_mp_prop_grandprix_car_06";
  level.scr_animtree["driver"] = #animtree;
  level.scr_anim["driver"]["mp_grandprix_racecar_anim_01"] = % iw9_mp_f1_car_driver;
  level.scr_animname["driver"]["mp_grandprix_racecar_anim_01"] = "iw9_mp_f1_car_driver";
  level.scr_anim["driver"]["mp_grandprix_racecar_anim_02"] = % iw9_mp_f1_car_driver;
  level.scr_animname["driver"]["mp_grandprix_racecar_anim_02"] = "iw9_mp_f1_car_driver";
  level.scr_anim["driver"]["mp_grandprix_racecar_anim_03"] = % iw9_mp_f1_car_driver;
  level.scr_animname["driver"]["mp_grandprix_racecar_anim_03"] = "iw9_mp_f1_car_driver";
  level.scr_anim["driver"]["mp_grandprix_racecar_anim_04"] = % iw9_mp_f1_car_driver;
  level.scr_animname["driver"]["mp_grandprix_racecar_anim_04"] = "iw9_mp_f1_car_driver";
  level.scr_anim["driver"]["mp_grandprix_racecar_anim_05"] = % iw9_mp_f1_car_driver;
  level.scr_animname["driver"]["mp_grandprix_racecar_anim_05"] = "iw9_mp_f1_car_driver";
  level.scr_anim["driver"]["mp_grandprix_racecar_anim_06"] = % iw9_mp_f1_car_driver;
  level.scr_animname["driver"]["mp_grandprix_racecar_anim_06"] = "iw9_mp_f1_car_driver";
  scripts\common\anim::addnotetrack_customfunction("race_car", "rumble_ground", ::_id_AE7105A022F1E8B6, "mp_grandprix_racecar_anim_01");
  scripts\common\anim::addnotetrack_customfunction("race_car", "rumble_ground_light", ::_id_F9D9EFC3970116B5, "mp_grandprix_racecar_anim_01");
  scripts\common\anim::addnotetrack_customfunction("race_car", "rumble_ground_medium", ::_id_039F4A49D854DCB4, "mp_grandprix_racecar_anim_01");
  scripts\common\anim::addnotetrack_customfunction("race_car", "rumble_ground", ::_id_AE7105A022F1E8B6, "mp_grandprix_racecar_anim_02");
  scripts\common\anim::addnotetrack_customfunction("race_car", "rumble_ground_light", ::_id_F9D9EFC3970116B5, "mp_grandprix_racecar_anim_02");
  scripts\common\anim::addnotetrack_customfunction("race_car", "rumble_ground_medium", ::_id_039F4A49D854DCB4, "mp_grandprix_racecar_anim_02");
  scripts\common\anim::addnotetrack_customfunction("race_car", "rumble_ground", ::_id_AE7105A022F1E8B6, "mp_grandprix_racecar_anim_03");
  scripts\common\anim::addnotetrack_customfunction("race_car", "rumble_ground_light", ::_id_F9D9EFC3970116B5, "mp_grandprix_racecar_anim_03");
  scripts\common\anim::addnotetrack_customfunction("race_car", "rumble_ground_medium", ::_id_039F4A49D854DCB4, "mp_grandprix_racecar_anim_03");
  scripts\common\anim::addnotetrack_customfunction("race_car", "rumble_ground", ::_id_AE7105A022F1E8B6, "mp_grandprix_racecar_anim_04");
  scripts\common\anim::addnotetrack_customfunction("race_car", "rumble_ground_light", ::_id_F9D9EFC3970116B5, "mp_grandprix_racecar_anim_04");
  scripts\common\anim::addnotetrack_customfunction("race_car", "rumble_ground_medium", ::_id_039F4A49D854DCB4, "mp_grandprix_racecar_anim_04");
  scripts\common\anim::addnotetrack_customfunction("race_car", "rumble_ground", ::_id_AE7105A022F1E8B6, "mp_grandprix_racecar_anim_05");
  scripts\common\anim::addnotetrack_customfunction("race_car", "rumble_ground_light", ::_id_F9D9EFC3970116B5, "mp_grandprix_racecar_anim_05");
  scripts\common\anim::addnotetrack_customfunction("race_car", "rumble_ground_medium", ::_id_039F4A49D854DCB4, "mp_grandprix_racecar_anim_05");
  scripts\common\anim::addnotetrack_customfunction("race_car", "rumble_ground", ::_id_AE7105A022F1E8B6, "mp_grandprix_racecar_anim_06");
  scripts\common\anim::addnotetrack_customfunction("race_car", "rumble_ground_light", ::_id_F9D9EFC3970116B5, "mp_grandprix_racecar_anim_06");
  scripts\common\anim::addnotetrack_customfunction("race_car", "rumble_ground_medium", ::_id_039F4A49D854DCB4, "mp_grandprix_racecar_anim_06");
}

_id_1369FBF85A2DE7BD() {
  wait 5;
  setdvarifuninitialized("dvar_9A27EF3D3730A41C", 0.0);
  setdvarifuninitialized("dvar_9A27F03D3730A64F", 1.0);
  setdvarifuninitialized("dvar_9A27ED3D37309FB6", 0.0);
  setdvarifuninitialized("dvar_9A27EE3D3730A1E9", 0.0);
  setdvarifuninitialized("dvar_9A27EB3D37309B50", 0.0);
  level._id_78EAAD6C11CF5AC3 = getEntArray("race_car", "targetname");
  _id_CB8B2044F93C5C3C = 1;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level._id_78EAAD6C11CF5AC3.size; _id_AC0E594AC96AA3A8++) {
    car = level._id_78EAAD6C11CF5AC3[_id_AC0E594AC96AA3A8];
    car.models = getEntArray(car.script_label, "targetname");

    foreach(_id_872FE47787E8589A in car.models)
    _id_872FE47787E8589A linkTo(car);

    car.models[0]._id_ACB55A437C3145C0 = getEnt(car.script_noteworthy, "targetname");
    car.models[0]._id_ACB55A437C3145C0 enablelinkTo();
    car.models[0]._id_ACB55A437C3145C0 linkTo(car.models[0], "tag_origin", (0, -10, -15), (0, 0, 0));
    car.models[0]._id_ACB55A437C3145C0._id_26FB072855FD4772 = 1;
    car.models[0]._id_ACB55A437C3145C0._id_0FDA11F45E9C5542 = car.models[0];
    car.models[0]._id_ACB55A437C3145C0.objweapon = makeweaponfromstring("iw9_racecar_mp");
    car.models[0].guid = "race_car";
    car.models[0] playLoopSound("sfx_grandprix_car_tires");
    car.origin = (1144, 168, 0);
    car.models[0].origin = car.origin;
    car.num = _id_CB8B2044F93C5C3C;
    _id_CB8B2044F93C5C3C++;
    car.models[0] thread _id_222613941733A387();
    driver = _id_A4862756AD873B3D(car.models[0].targetname);
    car.models[0].driver = car.models[0] spawn_anim_model("driver", "TAG_BODY_ANIMATE", driver);
    car.models[0].driver thread _id_E6E40836892A4992();
    car.models[0] thread setupkillcament();
    car.models[0] thread _id_29E181F3B6D3F79B(car);
  }

  level thread _id_D77EA4EAC011B443();
}

_id_D7517C880A88D114() {
  createnavobstaclebybounds((-1819, 2655, 90), (2, 18, 90), (0, 0, 0));
  createnavobstaclebybounds((-1681, 2655, 90), (2, 18, 90), (0, 0, 0));
  createnavobstaclebybounds((-1819, 2200, 90), (2, 18, 90), (0, 0, 0));
  createnavobstaclebybounds((-1681, 2200, 90), (2, 18, 90), (0, 0, 0));
  createnavobstaclebybounds((-2010, 2646, 80), (18, 2, 79), (0, 0, 0));
  createnavobstaclebybounds((-2010, 2217, 80), (18, 2, 79), (0, 0, 0));
  createnavobstaclebybounds((-2015, 1483, 80), (18, 2, 79), (0, 0, 0));
  createnavobstaclebybounds((-2015, 1213, 80), (18, 2, 79), (0, 0, 0));
}

_id_A4862756AD873B3D(_id_75FFED1210F37C40) {
  switch (_id_75FFED1210F37C40) {
    case "car_models_01":
      return "body_civ_driver_hancock_1_1";
    case "car_models_02":
      return "body_civ_driver_rohan_oil_1_1";
    case "car_models_03":
      return "body_civ_driver_nejera_1_1";
    case "car_models_04":
      return "body_civ_driver_hong_energy_1_1";
    case "car_models_05":
      return "body_civ_driver_cyclosa_1_1";
    case "car_models_06":
      return "body_civ_driver_rohan_oil_1_2";
    default:
      return "body_civ_driver_hancock_1_1";
  }
}

spawn_anim_model(animname, _id_0609C1B125A13456, body, head, weapon) {
  _id_C920DC0E8DFA0EF4 = 1;

  if(scripts\engine\utility::cointoss())
    _id_C920DC0E8DFA0EF4 = 0;

  guy = spawn("script_model", (0, 0, 0));
  guy setModel(body);
  guy.animname = animname;
  guy scripts\common\anim::setanimtree();

  if(isDefined(_id_0609C1B125A13456))
    guy linkTo(self, _id_0609C1B125A13456, (0, 0, 0), (0, 0, 0));

  return guy;
}

_id_222613941733A387() {
  self.animname = "race_car";
  self useanimtree(level.scr_animtree["race_car"]);
  self forcenetfieldhighlod(1);
  self setmoveroptimized(1);
  self setmoverantilagged(1);
  self markkeyframedmover();
  thread _id_DC5946B409CBE7BC();
  thread _id_79148C48A2AD61C1();
  thread _id_FF213D6711860E73();
}

_id_E6E40836892A4992() {
  self.animname = "driver";
  self useanimtree(level.scr_animtree["driver"]);
  self forcenetfieldhighlod(1);
  self setmoveroptimized(1);
  self setmoverantilagged(1);
  self markkeyframedmover();
}

_id_D77EA4EAC011B443() {
  wait 1;
  level notify("endRaceCarsAnim");
  level endon("endRaceCarsAnim");
  animlength = getanimlength(level.scr_anim["race_car"]["mp_grandprix_racecar_anim_01"]);
  waittime = animlength + 1;

  for(;;) {
    level thread _id_CE9FF82618A76813(waittime);
    level._id_E583F93D55F32680 = 0;

    if(isDefined(level._id_1C4946ED2A624035) && isDefined(level._id_1C6C30ED2A88578B))
      level._id_E583F93D55F32680 = randomintrange(level._id_1C6C30ED2A88578B, level._id_1C4946ED2A624035);

    foreach(car in level._id_78EAAD6C11CF5AC3) {
      _id_1193748B3FE9D956 = scripts\engine\utility::string(car.num);
      car thread scripts\common\anim::anim_single_solo(car.models[0], "mp_grandprix_racecar_anim_0" + _id_1193748B3FE9D956);
      car.models[0] thread scripts\common\anim::anim_single_solo(car.models[0].driver, "mp_grandprix_racecar_anim_0" + _id_1193748B3FE9D956, "TAG_BODY_ANIMATE");

      if(isDefined(car._id_93FE105A9275BD0F))
        car._id_93FE105A9275BD0F notify("link_sfx");

      wait(getdvarfloat(_func_2EF675C13CA1C4AF("dvar_960B89FEBE9EC746", _id_1193748B3FE9D956), 0.0));
    }

    level scripts\engine\utility::waittill_any_timeout_1(waittime, "carFinishedLap");
    wait(level._id_E583F93D55F32680);
  }
}

_id_29E181F3B6D3F79B(car) {
  wait 1;
  _id_57EEFE0CA5DB9070 = "sfx_grandprix_car_";
  animlength = getanimlength(level.scr_anim["race_car"]["mp_grandprix_racecar_anim_01"]);
  waittime = animlength + 1;
  _id_DFE13DCCD8F66A73 = 0;
  wait(waittime - 1.3);

  for(;;) {
    if(soundexists(_id_57EEFE0CA5DB9070 + car.num)) {
      level._id_DFE13DCCD8F66A73 = _id_DFE13DCCD8F66A73 % 2;
      _id_DFE13DCCD8F66A73++;
      _id_A6AFEA87679E66D7 = (-12223, -2985, 58);

      if(!isDefined(car._id_CC286AB0B719069B)) {
        car._id_CC286AB0B719069B = spawn("script_model", _id_A6AFEA87679E66D7);
        car._id_CC286BB0B71908CE = spawn("script_model", _id_A6AFEA87679E66D7);
      }

      if(_id_DFE13DCCD8F66A73 > 0)
        car._id_93FE105A9275BD0F = car._id_CC286AB0B719069B;
      else
        car._id_93FE105A9275BD0F = car._id_CC286BB0B71908CE;

      car._id_93FE105A9275BD0F moveTo(_id_A6AFEA87679E66D7, 0.1);
      car._id_93FE105A9275BD0F playsoundonmovingent(_id_57EEFE0CA5DB9070 + car.num);
      car._id_93FE105A9275BD0F waittill("link_sfx");
      wait 0.4;
      car._id_93FE105A9275BD0F moveTo(self.origin, 0.05);
      car._id_93FE105A9275BD0F linkTo(self);
      wait(waittime + level._id_E583F93D55F32680 - 2);
      car._id_93FE105A9275BD0F unlink();
      car._id_93FE105A9275BD0F moveTo((-3554.84, 7727.81, 29.056), 0.1);
    }

    wait 0.1;
  }
}

_id_CE9FF82618A76813(waittime) {
  wait(waittime + 1);
  waitframe();
  level notify("carFinishedLap");
}

_id_AE7105A022F1E8B6(_id_0FDA11F45E9C5542) {
  _id_78122E18403A8DC4 = scripts\common\utility::playersincylinder(_id_0FDA11F45E9C5542.origin, 165, undefined);

  foreach(player in _id_78122E18403A8DC4) {
    player earthquakeforplayer(0.2, 1, player.origin, 165);
    player setclientomnvar("ui_hud_shake", 1);
    player playrumbleonpositionforclient("artillery_rumble", player.origin);
  }
}

_id_039F4A49D854DCB4(_id_0FDA11F45E9C5542) {
  _id_78122E18403A8DC4 = scripts\common\utility::playersincylinder(_id_0FDA11F45E9C5542.origin, 200, undefined);

  foreach(player in _id_78122E18403A8DC4) {
    player earthquakeforplayer(0.2, 1, player.origin, 200);
    player setclientomnvar("ui_hud_shake", 1);
    player playrumbleonpositionforclient("artillery_rumble_light", player.origin);
  }
}

_id_F9D9EFC3970116B5(_id_0FDA11F45E9C5542) {
  _id_78122E18403A8DC4 = scripts\common\utility::playersincylinder(_id_0FDA11F45E9C5542.origin, 500, undefined);

  foreach(player in _id_78122E18403A8DC4) {
    player earthquakeforplayer(0.15, 1, player.origin, 500);
    player setclientomnvar("ui_hud_shake", 1);
    player playrumbleonpositionforclient("artillery_rumble_light", player.origin);
  }
}

audio_panodes() {
  level endon("game_ended");
  level waittill("connected", player);
  _id_FE66ECF180EC2613 = 35.0;
  _id_3DAFA337A7EED569 = 50.0;
  _id_2B4B28F7AE75B76A = spawn("script_origin", (0, 0, 0));
  _func_5A8DBA516863782A("grandprix_pa");
  wait 5;

  for(;;) {
    _id_2B4B28F7AE75B76A playSound("dx_mp_grpx_annc_paan_theracehasbeencancel");
    wait(randomfloatrange(_id_FE66ECF180EC2613, _id_3DAFA337A7EED569));
  }
}

_id_79148C48A2AD61C1() {
  level endon("game_ended");
  _id_0FDA11F45E9C5542 = self;
  _id_3ACEA7EDC0CFF4E9 = _id_0FDA11F45E9C5542 getentitynumber();
  _id_27B0EEA8C969D034 = 65;

  if(getdvarfloat("dvar_126B89249D651B7B", 65) != 65)
    _id_27B0EEA8C969D034 = getdvarfloat("dvar_126B89249D651B7B", 65);

  _id_FA8D5F684B034B30 = physics_createcontents(["physicscontents_item"]);
  _id_B65B7AEAB526E1AC = (_id_27B0EEA8C969D034, _id_27B0EEA8C969D034, 65);
  _id_646389193279E8EC = [_id_0FDA11F45E9C5542];

  for(;;) {
    _id_863C619037F3AC74 = _id_0FDA11F45E9C5542.origin + rotatevector((25, 0, -25), _id_0FDA11F45E9C5542.angles);
    _id_80745CF3E2877DF5 = _id_863C619037F3AC74 - _id_B65B7AEAB526E1AC;
    _id_809746F3E2AD954B = _id_863C619037F3AC74 + _id_B65B7AEAB526E1AC;
    _id_0C857EED1363BA9D = physics_aabbbroadphasequery(_id_80745CF3E2877DF5, _id_809746F3E2AD954B, _id_FA8D5F684B034B30, _id_646389193279E8EC);

    foreach(ent in _id_0C857EED1363BA9D) {
      if(isDefined(ent.code_classname) && ent.code_classname == "worldspawn")
        _id_0C857EED1363BA9D = scripts\engine\utility::array_remove(_id_0C857EED1363BA9D, ent);
    }

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_0C857EED1363BA9D.size; _id_AC0E594AC96AA3A8++) {
      _id_424A9176DF4DF0F4 = _id_0C857EED1363BA9D[_id_AC0E594AC96AA3A8];

      if(istrue(_id_424A9176DF4DF0F4.markedfordelete)) {
        continue;
      }
      if(isDefined(_id_424A9176DF4DF0F4._id_277487E709EA8386) && isDefined(_id_424A9176DF4DF0F4._id_277487E709EA8386.size)) {
        if(_id_424A9176DF4DF0F4._id_277487E709EA8386.size > 0) {
          if(isDefined(_id_424A9176DF4DF0F4._id_277487E709EA8386[_id_3ACEA7EDC0CFF4E9]))
            continue;
        }
      }

      if(isDefined(_id_424A9176DF4DF0F4.equipmentref) && _id_424A9176DF4DF0F4.equipmentref == "equip_tac_cover") {
        if(!_id_424A9176DF4DF0F4 istouching(_id_0FDA11F45E9C5542) && !_id_424A9176DF4DF0F4 istouching(_id_0FDA11F45E9C5542._id_ACB55A437C3145C0)) {
          continue;
        }
        _id_424A9176DF4DF0F4 scripts\mp\equipment\tactical_cover::tac_cover_destroy(undefined, 0);
        _id_424A9176DF4DF0F4.markedfordelete = 1;
        continue;
      }

      if(isDefined(_id_424A9176DF4DF0F4.cratetype) && (_id_424A9176DF4DF0F4.cratetype == "killstreak" || _id_424A9176DF4DF0F4.cratetype == "juggernaut")) {
        _id_424A9176DF4DF0F4 scripts\cp_mp\killstreaks\airdrop::destroycrate();
        _id_424A9176DF4DF0F4.markedfordelete = 1;
      }

      if(!_id_424A9176DF4DF0F4 istouching(_id_0FDA11F45E9C5542) && !_id_424A9176DF4DF0F4 istouching(_id_0FDA11F45E9C5542._id_ACB55A437C3145C0)) {
        continue;
      }
      if(isDefined(_id_424A9176DF4DF0F4.cratetype) && (_id_424A9176DF4DF0F4.cratetype == "killstreak" || _id_424A9176DF4DF0F4.cratetype == "juggernaut")) {
        _id_7C32EC07E4129BE9(_id_424A9176DF4DF0F4, _id_0FDA11F45E9C5542, _id_863C619037F3AC74);
        continue;
      }

      if(scripts\mp\utility\entity::isturret(_id_424A9176DF4DF0F4)) {
        if(istrue(_id_424A9176DF4DF0F4.isshuttingdown)) {
          continue;
        }
        _id_424A9176DF4DF0F4 notify("kill_turret", 1);
        _id_424A9176DF4DF0F4.markedfordelete = 1;
        continue;
      }
    }

    waitframe();
  }
}

_id_CB14F1C7AD456A44(_id_424A9176DF4DF0F4) {
  if(!isDefined(_id_424A9176DF4DF0F4.weapon_name))
    return 0;

  _id_5511188BEDE8E67A = 0;

  switch (_id_424A9176DF4DF0F4.weapon_name) {
    case "blastshield_box_mp":
    case "support_box_mp":
    case "armor_box_mp":
      _id_5511188BEDE8E67A = 1;
      break;
  }

  if(_id_5511188BEDE8E67A)
    return 1;

  return 0;
}

item_collision_ignorefutureevent(_id_4740EADAE93E17E7, _id_0FDA11F45E9C5542, duration) {
  if(!isDefined(_id_4740EADAE93E17E7._id_277487E709EA8386))
    _id_4740EADAE93E17E7._id_277487E709EA8386 = [];

  _id_BB5C27AB2AE871CF = _id_0FDA11F45E9C5542 getentitynumber();
  _id_4740EADAE93E17E7._id_277487E709EA8386[_id_BB5C27AB2AE871CF] = _id_0FDA11F45E9C5542;
  wait(duration);

  if(isDefined(_id_4740EADAE93E17E7) && isDefined(_id_4740EADAE93E17E7._id_277487E709EA8386))
    _id_4740EADAE93E17E7._id_277487E709EA8386[_id_BB5C27AB2AE871CF] = undefined;

  if(isDefined(_id_4740EADAE93E17E7) && isDefined(_id_4740EADAE93E17E7._id_277487E709EA8386) && _id_4740EADAE93E17E7._id_277487E709EA8386.size == 0)
    _id_4740EADAE93E17E7._id_277487E709EA8386 = undefined;
}

_id_7C32EC07E4129BE9(_id_424A9176DF4DF0F4, _id_0FDA11F45E9C5542, _id_863C619037F3AC74) {
  _id_424A9176DF4DF0F4 scripts\cp_mp\killstreaks\airdrop::destroycrate();
  _id_424A9176DF4DF0F4.markedfordelete = 1;
}

_id_FF213D6711860E73() {
  level endon("game_ended");

  if(!isDefined(level.mines))
    level.mines = [];

  _id_0FDA11F45E9C5542 = self;
  _id_3ACEA7EDC0CFF4E9 = _id_0FDA11F45E9C5542 getentitynumber();
  _id_27B0EEA8C969D034 = 150;

  if(getdvarfloat("dvar_126B89249D651B7B", 65) != 65)
    _id_27B0EEA8C969D034 = getdvarfloat("dvar_126B89249D651B7B", 65);

  maxdist = _id_27B0EEA8C969D034 - 25;
  _id_CDC5DD6C28C9709D = maxdist * maxdist;

  for(;;) {
    _id_4EABE431328AB40F = level.mines;

    if(_id_4EABE431328AB40F.size > 0) {
      _id_863C619037F3AC74 = _id_0FDA11F45E9C5542.origin + rotatevector((375, 0, -100), _id_0FDA11F45E9C5542.angles);

      foreach(mine in _id_4EABE431328AB40F) {
        if(!isDefined(mine)) {
          continue;
        }
        if(istrue(mine.markedfordelete)) {
          continue;
        }
        if(distance2dsquared(mine.origin, _id_863C619037F3AC74) > _id_CDC5DD6C28C9709D) {
          continue;
        }
        if(distancesquared(mine.origin, _id_863C619037F3AC74) > _id_CDC5DD6C28C9709D) {
          continue;
        }
        if(isDefined(mine.weapon_name)) {
          if(mine.weapon_name == "trophy_mp") {
            mine scripts\mp\equipment\trophy_system::sweeptrophy();
            mine.markedfordelete = 1;
            continue;
          }

          if(mine.weapon_name == "claymore_mp") {
            mine scripts\mp\equipment\claymore::sweepclaymore();
            mine.markedfordelete = 1;
            continue;
          }

          if(mine.weapon_name == "at_mine_mp") {
            mine scripts\mp\equipment\at_mine::at_mine_destroy();
            mine.markedfordelete = 1;
            continue;
          }

          if(mine.weapon_name == "tac_insert_trigger") {
            mine scripts\mp\equipment\tac_insert::deletetacinsert();
            mine.markedfordelete = 1;
            continue;
          }

          if(mine.weapon_name == "armor_box_mp" || mine.weapon_name == "blastshield_box_mp") {
            mine thread scripts\mp\equipment\support_box::supportbox_destroy();
            mine.markedfordelete = 1;
            continue;
          }

          if(mine.weapon_name == "support_box_mp") {
            mine thread scripts\mp\equipment\support_box::supportbox_destroy();
            mine.markedfordelete = 1;
          }
        }
      }
    }

    waitframe();
  }
}

_id_DC5946B409CBE7BC() {
  level endon("game_ended");
  self endon("death");
  self.velocity = (0, 0, 0);

  for(;;) {
    self.lastorigin = self.origin;
    wait 0.05;
    self.velocity = (self.origin - self.lastorigin) / 0.05;
  }
}

_id_39C509138C3A65DB(_id_4C9DB30E60A87779, victim) {
  _id_4C9DB30E60A87779._id_0FDA11F45E9C5542.owner = victim;
  _id_4C9DB30E60A87779.owner = victim;
  return victim;
}

setupkillcament() {
  setdvarifuninitialized("dvar_1A5E4AF153D0E5BB", 5);
  waitframe();
  _id_F69BA77714DAC6C2 = self.origin;
  _id_349802E026879951 = anglesToForward(self.angles);
  _id_5474CE5E528E0C16 = self.origin + _id_349802E026879951 * 100;

  if(getdvarint("dvar_1A5E4AF153D0E5BB", 1) == 1) {
    self._id_ACB55A437C3145C0.killcament = self;
    self._id_ACB55A437C3145C0.killcamentnum = self._id_ACB55A437C3145C0.killcament getentitynumber();
  } else if(getdvarint("dvar_1A5E4AF153D0E5BB", 1) == 2 || getdvarint("dvar_1A5E4AF153D0E5BB", 1) == 3) {
    if(getdvarint("dvar_1A5E4AF153D0E5BB", 1) == 2)
      _id_D1011739F3783B83 = (1422.37, -894.271, 0.0170574);
    else
      _id_D1011739F3783B83 = (2415.92, -6.72316, 401.567);

    killcament = spawn("script_model", _id_D1011739F3783B83);
    killcament setModel("script_model");
    killcament setscriptmoverkillcam("explosive");
    self._id_ACB55A437C3145C0.killcament = killcament;
  } else if(getdvarint("dvar_1A5E4AF153D0E5BB", 1) == 4)
    _id_158A4EDDF949CE45(60, -500, 50);
  else if(getdvarint("dvar_1A5E4AF153D0E5BB", 1) == 5)
    _id_158A4EDDF949CE45(0, -50, 15);
  else {
    _id_7F256D9F9CD2E337 = spawn("script_model", _id_5474CE5E528E0C16);
    _id_7F256D9F9CD2E337 setModel("script_model");
    _id_7F256D9F9CD2E337 setscriptmoverkillcam("missile");
    _id_7F256D9F9CD2E337 linkTo(self, "tag_origin");
    _id_7F256D9F9CD2E337 fixlinktointerpolationbug(1);
    self._id_ACB55A437C3145C0.killcament = _id_7F256D9F9CD2E337;
    self._id_ACB55A437C3145C0.killcamentnum = _id_7F256D9F9CD2E337 getentitynumber();
    self._id_ACB55A437C3145C0._id_7F256D9F9CD2E337 = self._id_ACB55A437C3145C0.killcament;
  }
}

_id_158A4EDDF949CE45(_id_76044267DB696016, _id_0F3C1B7C658B5AE1, zoffset) {
  _id_349802E026879951 = anglesToForward(self.angles);
  _id_C875B0EE9F8E5F56 = anglestoright(self.angles);
  _id_5474CE5E528E0C16 = self.origin + _id_C875B0EE9F8E5F56 * _id_76044267DB696016 + _id_349802E026879951 * _id_0F3C1B7C658B5AE1 + (0, 0, zoffset);
  killcament = spawn("script_model", _id_5474CE5E528E0C16);
  killcament setModel("script_model");
  killcament setscriptmoverkillcam("missile");
  killcament linkTo(self, "tag_origin");
  killcament fixlinktointerpolationbug(1);
  self._id_ACB55A437C3145C0.killcament = killcament;
  self._id_ACB55A437C3145C0.killcamentnum = self._id_ACB55A437C3145C0.killcament getentitynumber();
}

setup_vista_driving_boats() {
  wait 10.0;
  _id_C7CEA9511C6C393C = getEntArray("boat_vista", "targetname");
  _id_ADDB99B6C5EDC5B2 = 0.0125;
  _id_530A640121D04623 = 0.0166667;
  wait 2.0;

  foreach(_id_E2E4A2412ACAFDA7 in _id_C7CEA9511C6C393C) {
    _id_E2E4A2412ACAFDA7.boatfx = scripts\engine\utility::spawn_tag_origin();
    _id_E2E4A2412ACAFDA7.boatfx.origin = _id_E2E4A2412ACAFDA7.origin;
    _id_E2E4A2412ACAFDA7.boatfx.angles = _id_E2E4A2412ACAFDA7.angles;
    _id_E2E4A2412ACAFDA7.boatfx.targetname = "boatFX";
    _id_E2E4A2412ACAFDA7.boatfx show();
    _id_E2E4A2412ACAFDA7.boatfx linkTo(_id_E2E4A2412ACAFDA7);
    wait 0.1;
    thread vista_boat_drive(_id_E2E4A2412ACAFDA7, _id_ADDB99B6C5EDC5B2);
    playFXOnTag(level._effect["vfx_grandprix_boat_wake_01"], _id_E2E4A2412ACAFDA7.boatfx, "tag_origin");
  }
}

vista_boat_drive(_id_E2E4A2412ACAFDA7, _id_ADDB99B6C5EDC5B2) {
  _id_911BD5285719F926 = scripts\engine\utility::getStruct(_id_E2E4A2412ACAFDA7.target, "targetname");

  for(;;) {
    _id_44001B6C616AEE17 = abs(distance(_id_E2E4A2412ACAFDA7.origin, _id_911BD5285719F926.origin) * _id_ADDB99B6C5EDC5B2);
    _id_E2E4A2412ACAFDA7 moveTo(_id_911BD5285719F926.origin, _id_44001B6C616AEE17, 0, 0);
    _id_E2E4A2412ACAFDA7 rotateTo(_id_911BD5285719F926.angles, _id_44001B6C616AEE17, 0, 0);
    _id_911BD5285719F926 = scripts\engine\utility::getStruct(_id_911BD5285719F926.target, "targetname");
    wait(_id_44001B6C616AEE17);
  }
}

_id_3C37E8E4377AA2B3() {
  scripts\mp\equipment\tactical_cover::_id_C5D3D6E10BD8C8AB((-806, 630, 0), 1);
  scripts\mp\equipment\tactical_cover::_id_C5D3D6E10BD8C8AB((-806, 366, 0), 1);
}