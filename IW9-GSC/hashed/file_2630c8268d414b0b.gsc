/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_2630c8268d414b0b.gsc
***********************************************/

main() {
  _id_0CD6AD30BB55F2F2::main();
  _id_2C6DE8258BA0B8E8::main();
  _id_241E9F8AC66BED06::main();
  scripts\mp\load::main();
  scripts\common\create_script_utility::initialize_create_script();

  switch (scripts\mp\utility\game::getgametype()) {
    case "bigctf":
      level thread _id_5E7A58246E82CE2F::main();
      _id_39A8B103D9252A73::_id_60DB244685153D79();
      break;
    case "sd":
    case "rescue":
    case "cyber":
      scripts\mp\utility\dialog::_id_7991789FBDEF687E();
      level thread _id_7A52CC21A6087AEF::main();
      scripts\mp\spawnlogic::_id_9A3BEF3FFEF9C904(1);
      break;
    case "gwtdm":
      level thread _id_01DC07E8721B19C4::main();
      break;
  }

  scripts\cp_mp\utility\game_utility::registerlargemap();
  scripts\cp_mp\utility\game_utility::_id_5B9E95ACD14775A5();

  if(scripts\mp\utility\game::_id_A7CAA13EBE4C4BA5() || scripts\mp\utility\game::isgroundwarcoremode()) {
    if(!isDefined(scripts\cp_mp\utility\game_utility::getlocaleid())) {
      switch (scripts\mp\utility\game::getgametype()) {
        case "gwtdm":
          setDvar("scr_localeID", 55);
          break;
        case "sd":
        case "rescue":
        case "cyber":
          setDvar("scr_localeID", 129);
          break;
        default:
          setDvar("scr_localeID", 29);
          break;
      }
    }

    _id_3BA4F32E41F63B36::arm_initoutofbounds();
  } else {
    level.outofboundstriggers = getEntArray("OutOfBounds", "targetname");
    level.kill_border_triggers = getEntArray("kill_border_trigger", "targetname");
  }

  enablegroundwarspawnlogic(400, 1200);
  scripts\mp\compass::setupminimap("compass_map_mp_forsaken_gw");
  setDvar("r_umbraMinObjectContribution", 8);
  setDvar("r_usePrebuiltSunShadow", 0);
  setDvar("dvar_9365C7A237EDAA2F", 1);
  level.parachutecancutautodeploy = 1;
  level.parachutecancutparachute = 1;
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
}