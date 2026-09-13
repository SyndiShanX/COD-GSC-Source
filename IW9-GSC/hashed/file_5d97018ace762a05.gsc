/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_5d97018ace762a05.gsc
***********************************************/

main() {
  _id_2F5980AE2AA5ED78::main();
  _id_6AF9D8FCF2ABF37E::main();
  _id_0A5AD12775B6C704::main();
  _id_60DB8D4D6C0719A2();
  scripts\mp\load::main();
  scripts\common\create_script_utility::initialize_create_script();
  level thread _id_5BAFF8A4F0A3E39D::main();

  switch (scripts\mp\utility\game::getgametype()) {
    case "bigctf":
      level thread _id_00D988E800EF35DA::main();
      _id_39A8B103D9252A73::_id_60DB244685153D79();
      break;
    case "sd":
    case "rescue":
    case "cyber":
      scripts\mp\utility\dialog::_id_7991789FBDEF687E();
      level thread _id_4E7F395C540DEACE::main();
      scripts\mp\spawnlogic::_id_9A3BEF3FFEF9C904(1);
      break;
  }

  scripts\cp_mp\utility\game_utility::registerlargemap();
  scripts\cp_mp\utility\game_utility::_id_5B9E95ACD14775A5();

  if(scripts\mp\utility\game::_id_A7CAA13EBE4C4BA5() || scripts\mp\utility\game::isgroundwarcoremode()) {
    if(!isDefined(scripts\cp_mp\utility\game_utility::getlocaleid())) {
      switch (scripts\mp\utility\game::getgametype()) {
        case "gwtdm":
          setDvar("scr_localeID", 52);
          break;
        case "sd":
        case "rescue":
        case "cyber":
          setDvar("scr_localeID", 121);
          break;
        default:
          setDvar("scr_localeID", 21);
          break;
      }
    }

    _id_3BA4F32E41F63B36::arm_initoutofbounds();
  } else {
    level.outofboundstriggers = getEntArray("OutOfBounds", "targetname");
    level.kill_border_triggers = getEntArray("kill_border_trigger", "targetname");
  }

  level._id_057B13482577DD10 = _func_F159C10D5CF8F0B4("dcover_invalid_noent", "targetname");
  setDvar("dvar_9365C7A237EDAA2F", 1);
  level.parachutecancutautodeploy = 1;
  level.parachutecancutparachute = 1;
  level.music_style = "middle_east";
  level.outofboundstriggers = getEntArray("OutOfBounds", "targetname");
  scripts\mp\compass::setupminimap("compass_map_mp_oilfield_gw");
  setDvar("r_umbraMinObjectContribution", 8);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  level thread _id_3ECA73E9C6F34C08();
  level.modifiedspawnpoints["-21434 27198 -242"]["mp_tdm_spawn"]["removeradius"] = 64;
  level thread _id_33579A8CECD8FC41();
  level thread _id_C601C0BC695FBF82();
  thread _id_B2F8F087CEB71FEA();
}

_id_B2F8F087CEB71FEA() {
  if(scripts\mp\utility\game::getgametype() == "infect") {
    _id_45A286C0ECEEA8B4 = spawn("script_model", (-28129, 22498.2, -28));
    _id_45A286C0ECEEA8B4.angles = (0, 106, 0);
    _id_45A286C0ECEEA8B4 setModel("watertank_ladder_cover");
    _id_45A289C0ECEEAF4D = spawn("script_model", (-17395.8, 17432.2, -304));
    _id_45A289C0ECEEAF4D.angles = (0, 61, 0);
    _id_45A289C0ECEEAF4D setModel("watertank_ladder_cover");
    collision = getEntArray("tactical_cover_col", "targetname");
    _id_EC59D9EA59E2C00D = spawn("script_model", _id_45A286C0ECEEA8B4.origin + (0, 0, 24));
    _id_EC59D9EA59E2C00D dontinterpolate();
    _id_EC59D9EA59E2C00D.angles = (0, 16, 0);
    _id_EC59D9EA59E2C00D clonebrushmodeltoscriptmodel(collision[0]);
    _id_EC59D6EA59E2B974 = spawn("script_model", _id_EC59D9EA59E2C00D.origin + (0, 0, 48));
    _id_EC59D6EA59E2B974 dontinterpolate();
    _id_EC59D6EA59E2B974.angles = (0, 16, 0);
    _id_EC59D6EA59E2B974 clonebrushmodeltoscriptmodel(collision[0]);
    _id_EC59D7EA59E2BBA7 = spawn("script_model", _id_EC59D6EA59E2B974.origin + (0, 0, 48));
    _id_EC59D7EA59E2BBA7 dontinterpolate();
    _id_EC59D7EA59E2BBA7.angles = (0, 16, 0);
    _id_EC59D7EA59E2BBA7 clonebrushmodeltoscriptmodel(collision[0]);
    _id_EC59D4EA59E2B50E = spawn("script_model", _id_EC59D7EA59E2BBA7.origin + (0, 0, 48));
    _id_EC59D4EA59E2B50E dontinterpolate();
    _id_EC59D4EA59E2B50E.angles = (0, 16, 0);
    _id_EC59D4EA59E2B50E clonebrushmodeltoscriptmodel(collision[0]);
    _id_EC59D5EA59E2B741 = spawn("script_model", _id_45A289C0ECEEAF4D.origin + (0, 0, 24));
    _id_EC59D5EA59E2B741 dontinterpolate();
    _id_EC59D5EA59E2B741.angles = (0, 151, 0);
    _id_EC59D5EA59E2B741 clonebrushmodeltoscriptmodel(collision[0]);
    _id_EC59D2EA59E2B0A8 = spawn("script_model", _id_EC59D5EA59E2B741.origin + (0, 0, 48));
    _id_EC59D2EA59E2B0A8 dontinterpolate();
    _id_EC59D2EA59E2B0A8.angles = (0, 151, 0);
    _id_EC59D2EA59E2B0A8 clonebrushmodeltoscriptmodel(collision[0]);
    _id_EC59D3EA59E2B2DB = spawn("script_model", _id_EC59D2EA59E2B0A8.origin + (0, 0, 48));
    _id_EC59D3EA59E2B2DB dontinterpolate();
    _id_EC59D3EA59E2B2DB.angles = (0, 151, 0);
    _id_EC59D3EA59E2B2DB clonebrushmodeltoscriptmodel(collision[0]);
    _id_EC59D0EA59E2AC42 = spawn("script_model", _id_EC59D3EA59E2B2DB.origin + (0, 0, 48));
    _id_EC59D0EA59E2AC42 dontinterpolate();
    _id_EC59D0EA59E2AC42.angles = (0, 151, 0);
    _id_EC59D0EA59E2AC42 clonebrushmodeltoscriptmodel(collision[0]);
  }
}

_id_C601C0BC695FBF82() {
  org = (-25148, 20496, -228);
  _id_CB920E03144E9344 = 40;
  nodes = getnodesinradius(org, _id_CB920E03144E9344, 0, 64);

  foreach(node in nodes) {
    if(node.type == "Begin")
      destroynavlink(node);
  }
}

_id_33579A8CECD8FC41() {
  scripts\mp\equipment\tactical_cover::_id_D147E0986E29DD8D((-26996, 26596, -244), 46, 96);
  scripts\mp\equipment\tactical_cover::_id_D147E0986E29DD8D((-27012, 26656, -244), 46, 96);
  scripts\mp\equipment\tactical_cover::_id_D147E0986E29DD8D((-27030, 26720, -244), 46, 96);
  scripts\mp\equipment\tactical_cover::_id_D147E0986E29DD8D((-27046, 26780, -244), 46, 96);
  scripts\mp\equipment\tactical_cover::_id_D147E0986E29DD8D((-27220, 26538, -244), 46, 96);
  scripts\mp\equipment\tactical_cover::_id_D147E0986E29DD8D((-27238, 26598, -244), 46, 96);
  scripts\mp\equipment\tactical_cover::_id_D147E0986E29DD8D((-27256, 26662, -244), 46, 96);
  scripts\mp\equipment\tactical_cover::_id_D147E0986E29DD8D((-27272, 26722, -244), 46, 96);
}

_id_60DB8D4D6C0719A2() {
  hurttriggers = getEntArray("trigger_hurt", "classname");

  foreach(trig in hurttriggers) {
    if(isDefined(trig.dmg) && trig.dmg == 5 && isDefined(trig.origin) && trig.origin == (-22686, 24488, 21)) {
      trig.dmg = 20;
      trig thread _id_ADBA4585CF5ABB91();
    }
  }
}

_id_ADBA4585CF5ABB91() {
  interval = 1;
  _id_6F23DE6F51723774 = self.origin;

  for(;;) {
    self waittill("trigger");
    self triggerdisable();
    wait(interval);
    self triggerenable();
  }
}

_id_3ECA73E9C6F34C08() {
  wait 1;
  _id_C781A53C795D5330 = scripts\engine\utility::getStructArray("node_delete_struct", "script_noteworthy");

  if(isDefined(_id_C781A53C795D5330) && _id_C781A53C795D5330.size > 0) {
    foreach(struct in _id_C781A53C795D5330) {
      org = struct.origin;
      _id_CB920E03144E9344 = 128;

      if(isDefined(struct.radius))
        _id_CB920E03144E9344 = struct.radius;

      nodes = getnodesinradius(org, _id_CB920E03144E9344, 0, 64, "Cover");

      foreach(_id_0386C209C4BE9E91 in nodes)
      _id_0386C209C4BE9E91 _meth_547AAB3C2787AC87();
    }
  }
}