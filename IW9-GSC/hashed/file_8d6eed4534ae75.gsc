/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_8d6eed4534ae75.gsc
***********************************************/

main() {
  _id_7D81AB2C32B292D8::main();
  _id_0E7E3F2DE9A6CECE::main();
  _id_5CB28C3B0110ED14::main();
  scripts\mp\load::main();
  scripts\cp_mp\utility\game_utility::registerlargemap();
  scripts\cp_mp\utility\game_utility::_id_5B9E95ACD14775A5();
  scripts\common\create_script_utility::initialize_create_script();
  level thread _id_71AE3D0C11FE6E8B::main();
  level thread _id_35949D3972BE97DF::main();

  switch (scripts\mp\utility\game::getgametype()) {
    case "bigctf":
      level thread _id_09285E51407085B0::main();
      _id_39A8B103D9252A73::_id_60DB244685153D79();
      break;
    case "sd":
    case "rescue":
    case "cyber":
      scripts\mp\utility\dialog::_id_7991789FBDEF687E();
      level thread _id_743A16B8D6EBC974::main();
      scripts\mp\spawnlogic::_id_9A3BEF3FFEF9C904(1);
      break;
  }

  if(scripts\mp\utility\game::_id_A7CAA13EBE4C4BA5() || scripts\mp\utility\game::isgroundwarcoremode()) {
    if(!isDefined(scripts\cp_mp\utility\game_utility::getlocaleid())) {
      switch (scripts\mp\utility\game::getgametype()) {
        case "gwtdm":
          setDvar("scr_localeID", 34);
          break;
        case "sd":
        case "rescue":
        case "cyber":
          setDvar("scr_localeID", 128);
          break;
        default:
          setDvar("scr_localeID", 28);
          break;
      }
    }

    _id_3BA4F32E41F63B36::arm_initoutofbounds();
  } else {
    level.outofboundstriggers = getEntArray("OutOfBounds", "targetname");
    level.kill_border_triggers = getEntArray("kill_border_trigger", "targetname");
  }

  enablegroundwarspawnlogic(400, 1200);
  scripts\mp\compass::setupminimap("compass_map_mp_fishtown_gw");
  setDvar("r_umbraMinObjectContribution", 8);
  setDvar("r_usePrebuiltSunShadow", 0);
  setDvar("fd_helicopter_altitude_limiter", 4500);
  setDvar("dvar_9365C7A237EDAA2F", 1);
  level.parachutecancutautodeploy = 1;
  level.parachutecancutparachute = 1;
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  level.music_style = "middle_east";
  level._id_56BCDC219D432F80["axis"] = 15;
  level._id_56BCDC219D432F80["allies"] = 15;
  level thread _id_B5C9828FD2836DE6();
  level.modifiedspawnpoints["-6658 -47745"]["mp_tdm_spawn"]["remove"] = 1;

  switch (scripts\mp\utility\game::getgametype()) {
    case "arm":
      _id_E430C168F5F4143E();
      break;
  }

  level._id_F0872E42DAF6D4D5 = getclosestpointonnavmesh((-10037, -35633, -1501));
  thread _id_B2F8F087CEB71FEA();
}

_id_B2F8F087CEB71FEA() {
  if(scripts\mp\utility\game::getgametype() == "infect") {
    _id_45A286C0ECEEA8B4 = spawn("script_model", (14662.5, -36789, 985));
    _id_45A286C0ECEEA8B4.angles = (0, 264, 0);
    _id_45A286C0ECEEA8B4 setModel("watertank_ladder_cover");
    _id_45A289C0ECEEAF4D = spawn("script_model", (-2359.1, -36209.8, 679));
    _id_45A289C0ECEEAF4D.angles = (0, 210, 0);
    _id_45A289C0ECEEAF4D setModel("watertank_ladder_cover");
    collision = getEntArray("tactical_cover_col", "targetname");
    _id_EC59D9EA59E2C00D = spawn("script_model", _id_45A286C0ECEEA8B4.origin + (0, 0, 24));
    _id_EC59D9EA59E2C00D dontinterpolate();
    _id_EC59D9EA59E2C00D.angles = (0, 174, 0);
    _id_EC59D9EA59E2C00D clonebrushmodeltoscriptmodel(collision[0]);
    _id_EC59D6EA59E2B974 = spawn("script_model", _id_EC59D9EA59E2C00D.origin + (0, 0, 48));
    _id_EC59D6EA59E2B974 dontinterpolate();
    _id_EC59D6EA59E2B974.angles = (0, 174, 0);
    _id_EC59D6EA59E2B974 clonebrushmodeltoscriptmodel(collision[0]);
    _id_EC59D7EA59E2BBA7 = spawn("script_model", _id_EC59D6EA59E2B974.origin + (0, 0, 48));
    _id_EC59D7EA59E2BBA7 dontinterpolate();
    _id_EC59D7EA59E2BBA7.angles = (0, 174, 0);
    _id_EC59D7EA59E2BBA7 clonebrushmodeltoscriptmodel(collision[0]);
    _id_EC59D4EA59E2B50E = spawn("script_model", _id_EC59D7EA59E2BBA7.origin + (0, 0, 48));
    _id_EC59D4EA59E2B50E dontinterpolate();
    _id_EC59D4EA59E2B50E.angles = (0, 174, 0);
    _id_EC59D4EA59E2B50E clonebrushmodeltoscriptmodel(collision[0]);
    _id_EC59D5EA59E2B741 = spawn("script_model", _id_45A289C0ECEEAF4D.origin + (0, 0, -48));
    _id_EC59D5EA59E2B741 dontinterpolate();
    _id_EC59D5EA59E2B741.angles = (0, 120, 0);
    _id_EC59D5EA59E2B741 clonebrushmodeltoscriptmodel(collision[0]);
    _id_EC59D2EA59E2B0A8 = spawn("script_model", _id_EC59D5EA59E2B741.origin + (0, 0, 48));
    _id_EC59D2EA59E2B0A8 dontinterpolate();
    _id_EC59D2EA59E2B0A8.angles = (0, 120, 0);
    _id_EC59D2EA59E2B0A8 clonebrushmodeltoscriptmodel(collision[0]);
    _id_EC59D3EA59E2B2DB = spawn("script_model", _id_EC59D2EA59E2B0A8.origin + (0, 0, 48));
    _id_EC59D3EA59E2B2DB dontinterpolate();
    _id_EC59D3EA59E2B2DB.angles = (0, 120, 0);
    _id_EC59D3EA59E2B2DB clonebrushmodeltoscriptmodel(collision[0]);
    _id_EC59D0EA59E2AC42 = spawn("script_model", _id_EC59D3EA59E2B2DB.origin + (0, 0, 48));
    _id_EC59D0EA59E2AC42 dontinterpolate();
    _id_EC59D0EA59E2AC42.angles = (0, 120, 0);
    _id_EC59D0EA59E2AC42 clonebrushmodeltoscriptmodel(collision[0]);
  }
}

_id_E430C168F5F4143E() {
  _id_41178CE78CC432F9 = [];
  _id_41178CE78CC432F9[0] = [(-6644.62, -49603.8, 135.037), (0, 288, 0)];
  _id_41178CE78CC432F9[1] = [(-6067.99, -49211.5, 135.037), (0, 303, 0)];
  _id_41178CE78CC432F9[2] = [(2903.73, -51790.6, 168.786), (0, 48, 0)];
  _id_41178CE78CC432F9[3] = [(1859.62, -48499.3, 135.377), (0, 48, 0)];
  _id_41178CE78CC432F9[4] = [(-93.6514, -46354.7, 135.377), (0, 78, 0)];
  _id_41178CE78CC432F9[5] = [(-98.3477, -43581.3, 135.377), (0, 258, 0)];
  _id_41178CE78CC432F9[6] = [(6898.65, -44798.2, 111.377), (0, 183, 0)];
  _id_41178CE78CC432F9[7] = [(6746.71, -46894.3, 127.377), (0, 183, 0)];
  _id_5102B41EF5AB6D7E::main();
  scripts\cp_mp\vehicles\vehicle::_id_66AB4FB2175555E1("veh9_pwc");
  targetname = scripts\cp_mp\vehicles\vehicle_spawn::_id_348B69EC4082CEBA("veh9_pwc");
  vehicletype = scripts\cp_mp\vehicles\vehicle_spawn::_id_8FB5B3DA3AD4D628("veh9_pwc");

  foreach(array in _id_41178CE78CC432F9)
  scripts\cp_mp\vehicles\vehicle_spawn::_id_9F3EE4972DEC5B57("veh9_pwc", array[0], array[1], targetname, vehicletype, level.localeid);

  _id_27C2DB69A21775A0::_id_4925AD96CEF8DEF1("little_bird", (-14385, -47364, 319), (-10738, -47272, 800), (0, 18, 0));
  _id_27C2DB69A21775A0::_id_4925AD96CEF8DEF1("veh9_patrol_boat", (-14293, -48541, 128), (-14508, -48469, 128), (0, 287, 0));
  _id_27C2DB69A21775A0::_id_4925AD96CEF8DEF1("veh9_patrol_boat", (-13162, -49315, 128), (-15107, -49422, 128), (0, 337, 0));
  _id_27C2DB69A21775A0::_id_4925AD96CEF8DEF1("veh9_cougar", (-13669, -47615, 194), (-13913, -46690, 242), (0, 40, 0));
  _id_27C2DB69A21775A0::_id_4925AD96CEF8DEF1("light_tank", (-12938, -47738, 211), (-14022, -47624, 300), (0, 352, 0));
  _id_27C2DB69A21775A0::_id_4925AD96CEF8DEF1("veh9_apc_8x8", (-13318, -48077, 259), (-15011, -47548, 300), (0, 24, 0));
  _id_27C2DB69A21775A0::_id_4925AD96CEF8DEF1("veh9_utv", (-12384, -48392, 224), (-13317, -45875, 280), (0, 25, 0));
  _id_27C2DB69A21775A0::_id_4925AD96CEF8DEF1("little_bird", (13220, -35033, 973), (10512, -36610, 970), (0, 165, 0));
  _id_27C2DB69A21775A0::_id_4925AD96CEF8DEF1("veh9_cougar", (13630, -36556, 782), (12042, -37926, 680), (0, 143, 0));
  _id_27C2DB69A21775A0::_id_4925AD96CEF8DEF1("veh9_jltv_mg", (12512, -35371, 887), (11880, -38861, 675), (0, 324, 0));
  _id_27C2DB69A21775A0::_id_4925AD96CEF8DEF1("veh9_jltv_mg", (12948, -35923, 829), (10738, -35416, 804), (0, 183, 0));
  _id_27C2DB69A21775A0::_id_4925AD96CEF8DEF1("veh9_apc_8x8", (12830, -35644, 839), (13644, -37302, 917), (0, 142, 0));
  _id_27C2DB69A21775A0::_id_4925AD96CEF8DEF1("veh9_utv", (13197, -35575, 853), (11021, -37900, 600), (0, 150, 0));
  _id_27C2DB69A21775A0::_id_4925AD96CEF8DEF1("veh9_utv", (12400, -35188, 864), (11193, -37385, 669), (0, 188, 0));
  _id_27C2DB69A21775A0::_id_4925AD96CEF8DEF1("light_tank", (13228, -36232, 757), (12402, -36057, 819), (0, 238, 0));
  _id_27C2DB69A21775A0::_id_87328480BCCC7550([undefined, ["light_tank", (-848, -51072, 175.563), (0, 90, 0), "axis"], ["veh9_cougar", (-2872, -37416, 517.353), (0, 315, 0)], ["light_tank", (8576, -46336, 160), (0, 90, 0), "allies"], undefined]);
}

_id_B5C9828FD2836DE6() {
  level endon("game_ended");
  level waittill("connected", player);
  _id_2B4B28F7AE75B76A = spawn("script_origin", (0, 0, 0));
  _func_5A8DBA516863782A("pa_node_fishtown_tower");

  for(;;) {
    wait(randomfloatrange(8, 12));
    _id_2B4B28F7AE75B76A playSound("emt_dx_fish_paan_ldsp");
  }
}