/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_40cc4fcf4cd926a9.gsc
***********************************************/

main() {
  _id_2523EE42C68A2B85::main();
  _id_3B11DFB0FB35F90E::main();
  _id_63E4973D6B4FB2BA::main();
  _id_570A2A0F709689D0::main();
  scripts\mp\load::main();
  scripts\common\create_script_utility::initialize_create_script();
  level thread _id_75E4E24DC29A115D::main();

  switch (scripts\mp\utility\game::getgametype()) {
    case "bigctf":
      level thread _id_745B4E909C8E4C9A::main();
      _id_39A8B103D9252A73::_id_60DB244685153D79();
      break;
    case "sd":
    case "rescue":
    case "cyber":
      scripts\mp\utility\dialog::_id_7991789FBDEF687E();
      level thread _id_20CBAFCE58006C8E::main();
      scripts\mp\spawnlogic::_id_9A3BEF3FFEF9C904(1);
      scripts\mp\ammorestock::_id_B122437A5AC7F9F9((-1953, -12291, 4823), 96);
      break;
  }

  level.outofboundstriggers = getEntArray("OutOfBounds", "targetname");
  scripts\cp_mp\utility\game_utility::registerlargemap();
  scripts\cp_mp\utility\game_utility::_id_5B9E95ACD14775A5();
  level thread _id_02CBC5B0981723C6::main();

  if(scripts\mp\utility\game::_id_A7CAA13EBE4C4BA5() || scripts\mp\utility\game::isgroundwarcoremode()) {
    if(!isDefined(scripts\cp_mp\utility\game_utility::getlocaleid())) {
      switch (scripts\mp\utility\game::getgametype()) {
        case "gwtdm":
          setDvar("scr_localeID", 25);
          break;
        case "sd":
        case "rescue":
        case "cyber":
          setDvar("scr_localeID", 124);
          break;
        default:
          setDvar("scr_localeID", 24);
          break;
      }
    }

    _id_3BA4F32E41F63B36::arm_initoutofbounds();
  } else {
    level.outofboundstriggers = getEntArray("OutOfBounds", "targetname");
    level.kill_border_triggers = getEntArray("kill_border_trigger", "targetname");
  }

  scripts\mp\compass::setupminimap("compass_map_mp_observe_gw");
  setDvar("r_umbraMinObjectContribution", 8);
  setDvar("sm_sunSampleSizeNear", 2);
  setDvar("r_vertexDeformCutOffDist", 5000);
  setDvar("fd_helicopter_altitude_limiter", 8200);
  setDvar("dvar_9365C7A237EDAA2F", 1);
  level.parachutecancutautodeploy = 1;
  level.parachutecancutparachute = 1;
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  level _id_274CD16D0AF35466();
  thread _id_B2F8F087CEB71FEA();
  scripts\mp\equipment\tactical_cover::_id_D147E0986E29DD8D((-2711, -14313, 4796), 80, 110);
}

_id_274CD16D0AF35466() {
  level.modifiedspawnpoints["-4170 -17788 4535"]["mp_gw_spawn_allies_start"]["removeradius"] = 512;
}

_id_B2F8F087CEB71FEA() {
  _id_45428B56EF07EA91 = spawn("script_model", (-3179.1, -13785.4, 4784));
  _id_45428B56EF07EA91 setModel("ch_crate24x32_simple");
  _id_45428B56EF07EA91.angles = (0, 0, 0);
  _id_45428B56EF07EA91 = spawn("script_model", (-3176.1, -13747.4, 4784));
  _id_45428B56EF07EA91 setModel("ch_crate24x32_simple");
  _id_45428B56EF07EA91.angles = (0, 175, 0);
  _id_45428B56EF07EA91 = spawn("script_model", (-3176.1, -13747.4, 4808));
  _id_45428B56EF07EA91 setModel("ch_crate24x32_simple");
  _id_45428B56EF07EA91.angles = (0, 95, 0);
  _id_1E15CC204F179CEC = spawn("script_model", (-749.5, -12857.7, 4931));
  _id_1E15CC204F179CEC.angles = (0, 330, 0);
  _id_1E15CC204F179CEC clonebrushmodeltoscriptmodel(getEnt("mantle64", "targetname"), 1);
  _id_1E15CF204F17A385 = spawn("script_model", (-4340.93, -17737.6, 4583));
  _id_1E15CF204F17A385.angles = (0, 270, 0);
  _id_1E15CF204F17A385 clonebrushmodeltoscriptmodel(getEnt("mantle256", "targetname"), 1);
  _id_1E15CE204F17A152 = spawn("script_model", (-4340.93, -17479.6, 4583));
  _id_1E15CE204F17A152.angles = (0, 270, 0);
  _id_1E15CE204F17A152 clonebrushmodeltoscriptmodel(getEnt("mantle256", "targetname"), 1);
  _id_1E15C9204F179653 = spawn("script_model", (-4340.93, -17272.6, 4583));
  _id_1E15C9204F179653.angles = (0, 270, 0);
  _id_1E15C9204F179653 clonebrushmodeltoscriptmodel(getEnt("mantle256", "targetname"), 1);
  createnavobstaclebybounds((-3752, -18992, 4648), (208, 176, 184), (0, 0, 0));

  if(scripts\mp\utility\game::getgametype() == "infect") {
    _id_B9C76F6C1BB4084D = spawn("script_model", (-3872, -11347, 4909));
    _id_B9C76F6C1BB4084D.angles = (0, 150, 0);
    _id_B9C76F6C1BB4084D setModel("watertank_ladder_cover");
    collision = getEntArray("tactical_cover_col", "targetname");
    _id_EC59D9EA59E2C00D = spawn("script_model", _id_B9C76F6C1BB4084D.origin + (0, 0, 24));
    _id_EC59D9EA59E2C00D dontinterpolate();
    _id_EC59D9EA59E2C00D.angles = (0, 60, 0);
    _id_EC59D9EA59E2C00D clonebrushmodeltoscriptmodel(collision[0]);
    _id_EC59D6EA59E2B974 = spawn("script_model", _id_EC59D9EA59E2C00D.origin + (0, 0, 48));
    _id_EC59D6EA59E2B974 dontinterpolate();
    _id_EC59D6EA59E2B974.angles = (0, 60, 0);
    _id_EC59D6EA59E2B974 clonebrushmodeltoscriptmodel(collision[0]);
    _id_EC59D7EA59E2BBA7 = spawn("script_model", _id_EC59D6EA59E2B974.origin + (0, 0, 48));
    _id_EC59D7EA59E2BBA7 dontinterpolate();
    _id_EC59D7EA59E2BBA7.angles = (0, 60, 0);
    _id_EC59D7EA59E2BBA7 clonebrushmodeltoscriptmodel(collision[0]);
    _id_EC59D4EA59E2B50E = spawn("script_model", _id_EC59D7EA59E2BBA7.origin + (0, 0, 48));
    _id_EC59D4EA59E2B50E dontinterpolate();
    _id_EC59D4EA59E2B50E.angles = (0, 60, 0);
    _id_EC59D4EA59E2B50E clonebrushmodeltoscriptmodel(collision[0]);
    level._id_2054BB1CC6580CE4 = [];
    level._id_2054BB1CC6580CE4[level._id_2054BB1CC6580CE4.size] = spawn("trigger_radius", (-3072, -21248, 4000), 0, 800, 3000);
    level._id_2054BB1CC6580CE4[level._id_2054BB1CC6580CE4.size] = spawn("trigger_radius", (-5130, -17404, 4000), 0, 600, 3000);
    level._id_2054BB1CC6580CE4[level._id_2054BB1CC6580CE4.size] = spawn("trigger_radius", (-1632, -15688, 4000), 0, 600, 3000);
    level._id_2054BB1CC6580CE4[level._id_2054BB1CC6580CE4.size] = spawn("trigger_radius", (-1676, -11692, 4000), 0, 600, 3000);
    level._id_2054BB1CC6580CE4[level._id_2054BB1CC6580CE4.size] = spawn("trigger_radius", (2056, -9856, 4000), 0, 600, 3000);
    level._id_2054BB1CC6580CE4[level._id_2054BB1CC6580CE4.size] = spawn("trigger_radius", (-3875, -11326, 4000), 0, 200, 6000);
  }
}