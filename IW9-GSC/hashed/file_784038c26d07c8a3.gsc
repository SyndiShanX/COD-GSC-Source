/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_784038c26d07c8a3.gsc
***********************************************/

main() {
  _id_6206B59B7421726B::main();
  _id_054C8C14BD48C282::main();
  _id_77FFA6039A40BA10::main();
  _id_0A1CB31801728F2E::main();
  scripts\mp\load::main();
  scripts\common\create_script_utility::initialize_create_script();

  switch (scripts\mp\utility\game::getgametype()) {
    case "bigctf":
      level thread _id_775756B08FD14B31::main();
      _id_39A8B103D9252A73::_id_60DB244685153D79();
      break;
    case "sd":
    case "rescue":
    case "cyber":
      if(getdvarint("dvar_293BBB2D107DE147", 0) == 1)
        scripts\cp_mp\utility\game_utility::_id_67C053F33E4F21A1();

      scripts\mp\utility\dialog::_id_7991789FBDEF687E();
      level thread _id_5977B832740348A9::main();
      scripts\mp\spawnlogic::_id_9A3BEF3FFEF9C904(1);
      level thread _id_4C2E7CCD042D56AD();
      break;
    case "gwtdm":
      level thread _id_740396A1DC93A76D::main();
      level thread _id_0E859AF1B0F46346::main();
      break;
  }

  level.outofboundstriggers = getEntArray("OutOfBounds", "targetname");
  scripts\cp_mp\utility\game_utility::registerlargemap();
  scripts\cp_mp\utility\game_utility::_id_5B9E95ACD14775A5();

  if(scripts\mp\utility\game::_id_A7CAA13EBE4C4BA5() || scripts\mp\utility\game::isgroundwarcoremode()) {
    if(!isDefined(scripts\cp_mp\utility\game_utility::getlocaleid())) {
      switch (scripts\mp\utility\game::getgametype()) {
        case "gwtdm":
          setDvar("scr_localeID", 51);
          _id_C94ED2A2C9E9EAA5();
          break;
        case "sd":
        case "rescue":
        case "cyber":
          setDvar("scr_localeID", 150);
          break;
        default:
          setDvar("scr_localeID", 50);
          break;
      }
    }

    _id_3BA4F32E41F63B36::arm_initoutofbounds();
  } else {
    level.outofboundstriggers = getEntArray("OutOfBounds", "targetname");
    level.kill_border_triggers = getEntArray("kill_border_trigger", "targetname");
  }

  scripts\mp\compass::setupminimap("compass_map_mp_sira_gw");
  setDvar("r_umbraMinObjectContribution", 8);
  setDvar("fd_helicopter_altitude_limiter", 4500);
  setDvar("dvar_9365C7A237EDAA2F", 1);
  level.parachutecancutautodeploy = 1;
  level.parachutecancutparachute = 1;
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  level.music_style = "middle_east";
  level._id_56BCDC219D432F80["axis"] = 29;
  level._id_56BCDC219D432F80["allies"] = 25;
  level.modifiedspawnpoints["-32010 -21654"]["mp_tdm_spawn"]["remove"] = 1;
  level.modifiedspawnpoints["-25529 -23952"]["mp_tdm_spawn"]["remove"] = 1;
  level.modifiedspawnpoints["-38481 -20702"]["mp_tdm_spawn"]["remove"] = 1;

  switch (scripts\mp\utility\game::getgametype()) {
    case "conflict":
    case "arm":
    case "bigctf":
      _id_E430C168F5F4143E();
      break;
  }

  level _id_3C37E8E4377AA2B3();
  level thread _id_5F903436642211AF::_id_D8DE1E0BC05F3B3A();
  level._id_F0872E42DAF6D4D5 = getclosestpointonnavmesh((-33793, -23178, -1606));
}

_id_E430C168F5F4143E() {
  _id_27C2DB69A21775A0::_id_4925AD96CEF8DEF1("veh9_palfa", (-38902, -27026, 532), (-39319, -27168, 650), (0, 23, 0));
  _id_27C2DB69A21775A0::_id_4925AD96CEF8DEF1("veh9_cougar", (-38949, -23228, 358), (-39985, -22859, 380), (0, 328, 0));
  _id_27C2DB69A21775A0::_id_4925AD96CEF8DEF1("veh9_palfa", (-29922, -17572, 582), (-29922, -17572, 650), (0, 200, 0));
  _id_27C2DB69A21775A0::_id_4925AD96CEF8DEF1("veh9_cougar", (-29894, -21470, 262), (-28960, -22281, 420), (0, 181, 0));
}

_id_C94ED2A2C9E9EAA5() {
  createnavobstaclebybounds((-34947, -21046, 318), (50, 50, 50), (0, 0, 0));
}

_id_3C37E8E4377AA2B3() {
  scripts\mp\equipment\tactical_cover::_id_C5D3D6E10BD8C8AB((-36445.5, -25729.4, 309), 1);
}

_id_4C2E7CCD042D56AD() {
  _id_1E15CC204F179CEC = spawn("script_model", (-25574, -21348, 568));
  _id_1E15CC204F179CEC.angles = (0, 0, 0);
  _id_1E15CC204F179CEC clonebrushmodeltoscriptmodel(getEnt("care_package_col", "targetname"), 1);
}