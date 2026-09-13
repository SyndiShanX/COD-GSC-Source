/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_520e8a2a8b1b3491.gsc
***********************************************/

main() {
  _id_7571756EDDA23062::main();
  _id_288959535BF9F252::main();
  _id_2E1B127CE454C368::main();
  scripts\mp\load::main();
  scripts\cp_mp\utility\game_utility::registerlargemap();
  scripts\common\create_script_utility::initialize_create_script();
  level thread _id_247580D18347C66C::main();
  level thread _id_17B9F604781B4948::main();

  switch (scripts\mp\utility\game::getgametype()) {
    case "bigctf":
      level thread _id_212B9029D591A887::main();
      _id_39A8B103D9252A73::_id_60DB244685153D79();
      break;
    case "sd":
    case "rescue":
    case "cyber":
      scripts\mp\utility\dialog::_id_7991789FBDEF687E();
      setdvarifuninitialized("dvar_AD6E2FED4A549F49", 1);
      level thread _id_364A4560F9F0E027::main();
      scripts\mp\spawnlogic::_id_9A3BEF3FFEF9C904(1);
      break;
  }

  thread _id_B2F8F087CEB71FEA();

  if(scripts\mp\utility\game::_id_A7CAA13EBE4C4BA5() || scripts\mp\utility\game::isgroundwarcoremode()) {
    if(!isDefined(scripts\cp_mp\utility\game_utility::getlocaleid())) {
      switch (scripts\mp\utility\game::getgametype()) {
        case "gwtdm":
          setDvar("scr_localeID", 41);
          break;
        case "sd":
        case "rescue":
        case "cyber":
          setDvar("scr_localeID", 140);
          break;
        default:
          setDvar("scr_localeID", 40);
          break;
      }
    }

    _id_3BA4F32E41F63B36::arm_initoutofbounds();
  } else {
    level.outofboundstriggers = getEntArray("OutOfBounds", "targetname");
    level.kill_border_triggers = getEntArray("kill_border_trigger", "targetname");
  }

  scripts\mp\compass::setupminimap("compass_map_mp_historic_gw2");
  setDvar("r_umbraMinObjectContribution", 8);
  setDvar("fd_helicopter_altitude_limiter", 7200);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  level.music_style = "mexico";

  switch (scripts\mp\utility\game::getgametype()) {
    case "arm":
      _id_E430C168F5F4143E();
      break;
  }

  level._id_F0872E42DAF6D4D5 = getclosestpointonnavmesh((29675, -29314, 1071));
}

_id_E430C168F5F4143E() {
  _id_27C2DB69A21775A0::_id_87328480BCCC7550([undefined, ["light_tank", (28888, -24679.8, 3180), (0, 210, 0), "axis"], undefined, ["light_tank", (26378, -32481.1, 3140), (0, 49, 0), "allies"], undefined]);
}

_id_B2F8F087CEB71FEA() {
  _id_45428B56EF07EA91 = spawn("script_model", (33783, -32027, 3182));
  _id_45428B56EF07EA91 setModel("hardware_plywood_painted_white_01_48");
  _id_45428B56EF07EA91.angles = (0, 320.55, 0);
  _id_AF5DF9A502E8811A = spawn("script_model", (34417, -34585, 3301));
  _id_AF5DF9A502E8811A setModel("mout_railing_wood_32_solid_painted");
  _id_AF5DF9A502E8811A.angles = (0, 230, -90);
  _id_70F1AB88B4C446AF = spawn("script_model", (34323, -34761, 3301));
  _id_70F1AB88B4C446AF setModel("mout_railing_wood_32_solid_painted");
  _id_70F1AB88B4C446AF.angles = (0, 50, -90);
  _id_9964A913AA94CF90 = spawn("script_model", (30746.5, -24223.5, 3283));
  _id_9964A913AA94CF90 setModel("hardware_plywood_painted_white_01_48");
  _id_9964A913AA94CF90.angles = (90, 0, 60);
  _id_CBC7EAFF04EB54D5 = spawn("script_model", (30758.5, -24246.5, 3283));
  _id_CBC7EAFF04EB54D5 setModel("hardware_plywood_painted_white_01_48");
  _id_CBC7EAFF04EB54D5.angles = (90, 0, 60);
  _id_51D3A9451C22C04E = spawn("script_model", (27397, -24631, 3264));
  _id_51D3A9451C22C04E setModel("building_horse_stall_wood_beam_01");
  _id_51D3A9451C22C04E.angles = (0, 30, 0);
  _id_10688B3021ACC893 = spawn("script_model", (34258, -34850, 3104));
  _id_10688B3021ACC893 setModel("building_horse_stall_wood_beam_01");
  _id_10688B3021ACC893.angles = (0, 318, 0);
  _id_5514BA2EB35CC4D4 = spawn("script_model", (28024, -33062.5, 3250));
  _id_5514BA2EB35CC4D4 setModel("building_horse_stall_wood_beam_01");
  _id_5514BA2EB35CC4D4.angles = (0, 8, 180);
  _id_86EAEC1A0D17D509 = spawn("script_model", (28009, -33100, 3132));
  _id_86EAEC1A0D17D509 setModel("mout_railing_wood_32_solid_painted");
  _id_86EAEC1A0D17D509.angles = (0, 190, 0);
  _id_E455BDC55F617019 = spawn("script_model", (24711, -29823.5, 3138));
  _id_E455BDC55F617019 setModel("building_horse_stall_wood_beam_01");
  _id_E455BDC55F617019.angles = (0, 29, 0);
  _id_968F4BE2024FAE24 = spawn("script_model", (24805, -29769.5, 3138));
  _id_968F4BE2024FAE24 setModel("building_horse_stall_wood_beam_01");
  _id_968F4BE2024FAE24.angles = (0, 37, 0);
  _id_0F78FDF72484F3B7 = spawn("script_model", (26342, -33138, 3592));
  _id_0F78FDF72484F3B7 setModel("furniture_modern_table_01");
  _id_0F78FDF72484F3B7.angles = (0, 0, 0);
}