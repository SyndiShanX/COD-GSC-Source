/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_4ba702e5e4bcad65.gsc
***********************************************/

main() {
  _id_52B9ADB013609461::main();
  _id_1CC2577548245112::main();
  _id_448A822C8F21649E::main();
  _id_37F0AAF6393E9C24::main();
  scripts\mp\load::main();
  scripts\common\create_script_utility::initialize_create_script();
  level thread _id_4A53C09F957A55AF::main();

  switch (scripts\mp\utility\game::getgametype()) {
    case "bigctf":
      level thread _id_4906C0D2D46F4FEC::main();
      _id_39A8B103D9252A73::_id_60DB244685153D79();
      break;
    case "sd":
    case "rescue":
    case "cyber":
      scripts\mp\utility\dialog::_id_7991789FBDEF687E();
      level thread _id_02C3E92862F3A558::main();
      scripts\mp\spawnlogic::_id_9A3BEF3FFEF9C904(1);
      break;
  }

  level.outofboundstriggers = getEntArray("OutOfBounds", "targetname");
  scripts\cp_mp\utility\game_utility::registerlargemap();
  scripts\cp_mp\utility\game_utility::_id_5B9E95ACD14775A5();

  if(scripts\mp\utility\game::_id_A7CAA13EBE4C4BA5() || scripts\mp\utility\game::isgroundwarcoremode()) {
    if(!isDefined(scripts\cp_mp\utility\game_utility::getlocaleid())) {
      switch (scripts\mp\utility\game::getgametype()) {
        case "gwtdm":
          setDvar("scr_localeID", 12);
          break;
        case "sd":
        case "rescue":
        case "cyber":
          setDvar("scr_localeID", 111);
          break;
        default:
          setDvar("scr_localeID", 11);
          break;
      }
    }

    _id_3BA4F32E41F63B36::arm_initoutofbounds();
  } else {
    level.outofboundstriggers = getEntArray("OutOfBounds", "targetname");
    level.kill_border_triggers = getEntArray("kill_border_trigger", "targetname");
  }

  scripts\mp\compass::setupminimap("compass_map_mp_dogtown_gw");
  setDvar("r_umbraMinObjectContribution", 8);
  setDvar("r_usePrebuiltSunShadow", 0);
  setDvar("dvar_9365C7A237EDAA2F", 1);
  level.parachutecancutautodeploy = 1;
  level.parachutecancutparachute = 1;
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";

  if(scripts\mp\utility\game::getgametype() == "arm" || scripts\mp\utility\game::getgametype() == "gwtdm") {
    level thread _id_06AD4F9E2F4C6105::init();
    level thread _id_A18E0DB907847C09();
  }
}

_id_A18E0DB907847C09() {
  setDvar("dvar_ED4A71E34E488E86", 1);
  train_car_model = getEnt("train_car_model_26", "script_noteworthy");
  _id_A2DF5D611A749AC6 = scripts\engine\utility::getStructArray("train_car_26_loot", "script_noteworthy");

  foreach(struct in _id_A2DF5D611A749AC6) {
    if(struct.targetname == "military_ammo_restock_noent") {
      _id_4F119778A42AB86A = spawn("script_model", struct.origin);
      _id_4F119778A42AB86A setModel("military_ammo_restock_location");
      _id_4F119778A42AB86A.angles = (0, 90, 0);
      _id_4F119778A42AB86A linkTo(train_car_model);
      break;
    }
  }

  scripts\mp\flags::_id_1240434F4201AC9D("prematch_done");
  level notify("br_prematchEnded");
}