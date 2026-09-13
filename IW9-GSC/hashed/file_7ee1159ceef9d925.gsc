/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_7ee1159ceef9d925.gsc
***********************************************/

main() {
  _id_7E26577F470B1512::main();
  _id_5DB2E9B8D63C085E::main();
  _id_69B14D5C5AFBC1E4::main();
  scripts\mp\load::main();
  scripts\cp_mp\utility\game_utility::registerlargemap();
  scripts\common\create_script_utility::initialize_create_script();
  level thread _id_33ECB95EF8F2CFF2::main();
  level thread _id_1B64AB35A2E7EA1F::main();
  level thread _id_779D4C128FE182A8::main();

  switch (scripts\mp\utility\game::getgametype()) {
    case "bigctf":
      level thread _id_04BB425292FA665B::main();
      _id_39A8B103D9252A73::_id_60DB244685153D79();
      break;
    case "sd":
    case "rescue":
    case "cyber":
      scripts\mp\utility\dialog::_id_7991789FBDEF687E();
      level thread _id_64A639FAEFA63BC3::main();
      scripts\mp\spawnlogic::_id_9A3BEF3FFEF9C904(1);
      break;
  }

  if(scripts\mp\utility\game::_id_A7CAA13EBE4C4BA5() || scripts\mp\utility\game::isgroundwarcoremode()) {
    if(!isDefined(scripts\cp_mp\utility\game_utility::getlocaleid())) {
      switch (scripts\mp\utility\game::getgametype()) {
        case "gwtdm":
          setDvar("scr_localeID", 26);
          break;
        case "sd":
        case "rescue":
        case "cyber":
          setDvar("scr_localeID", 127);
          break;
        default:
          setDvar("scr_localeID", 27);
          break;
      }
    }

    _id_3BA4F32E41F63B36::arm_initoutofbounds();
  } else {
    level.outofboundstriggers = getEntArray("OutOfBounds", "targetname");
    level.kill_border_triggers = getEntArray("kill_border_trigger", "targetname");
  }

  scripts\mp\compass::setupminimap("compass_map_mp_wartorn_gw");
  setDvar("r_umbraMinObjectContribution", 8);
  setDvar("r_usePrebuiltSunShadow", 0);
  setDvar("fd_helicopter_altitude_limiter", 4500);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  level.music_style = "middle_east";
  level._id_56BCDC219D432F80["axis"] = 15;
  level._id_56BCDC219D432F80["allies"] = 15;

  if(istrue(level._id_289DF80E1DED586F))
    _id_48814951E916AF89::_id_C8393014DD7F8AB6();

  level.adjustshipmentspawns = 1;
  level thread adjustactivespawnlogic();
  level _id_274CD16D0AF35466();

  switch (scripts\mp\utility\game::getgametype()) {
    case "arm":
      _id_E430C168F5F4143E();
      break;
  }
}

_id_E430C168F5F4143E() {
  _id_27C2DB69A21775A0::_id_87328480BCCC7550([undefined, ["light_tank", (-16637.2, 37952.6, 270.108), (0, 0, 0), "axis"], ["veh9_cougar", (-6188, 41850, 192), (0, 164, 0)], undefined, ["light_tank", (-14987.4, 47094.1, 208.858), (0, 262, 0), "allies"]]);
}

adjustactivespawnlogic() {
  wait 1;
  scripts\mp\spawnlogic::setactivespawnlogic("Shipment", "Crit_Default");
}

_id_274CD16D0AF35466() {
  level.modifiedspawnpoints["-8577 45491"]["mp_tdm_spawn"]["remove"] = 1;
  level.modifiedspawnpoints["-2970 45626"]["mp_tdm_spawn"]["removeradius"] = 128;
}