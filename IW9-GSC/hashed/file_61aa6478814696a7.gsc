/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_61aa6478814696a7.gsc
***********************************************/

main() {
  _id_5A1FC06D3A43414F::main();
  _id_783A3D78E874667A::main();
  _id_1743BEBD3419635C::main();
  _id_72F403E19419306A::main();
  scripts\mp\load::main();
  scripts\cp_mp\utility\game_utility::registerlargemap();
  scripts\cp_mp\utility\game_utility::_id_5B9E95ACD14775A5();
  scripts\common\create_script_utility::initialize_create_script();
  level thread _id_04BB6398B71EA402::main();
  level thread _id_12E344CB72621823::main();

  switch (scripts\mp\utility\game::getgametype()) {
    case "bigctf":
      level thread _id_39B7AA7E4553E475::main();
      _id_39A8B103D9252A73::_id_60DB244685153D79();
      break;
    case "sd":
    case "rescue":
    case "cyber":
      scripts\mp\utility\dialog::_id_7991789FBDEF687E();
      level thread _id_495F217096508775::main();
      scripts\mp\spawnlogic::_id_9A3BEF3FFEF9C904(1);
      break;
  }

  if(scripts\mp\utility\game::_id_A7CAA13EBE4C4BA5() || scripts\mp\utility\game::isgroundwarcoremode()) {
    if(!isDefined(scripts\cp_mp\utility\game_utility::getlocaleid())) {
      switch (scripts\mp\utility\game::getgametype()) {
        case "gwtdm":
          setDvar("scr_localeID", 88);
          break;
        case "sd":
        case "rescue":
        case "cyber":
          setDvar("scr_localeID", 122);
          break;
        default:
          setDvar("scr_localeID", 22);
          break;
      }
    }

    _id_3BA4F32E41F63B36::arm_initoutofbounds();
  } else {
    level.outofboundstriggers = getEntArray("OutOfBounds", "targetname");
    level.kill_border_triggers = getEntArray("kill_border_trigger", "targetname");
  }

  setDvar("dvar_9365C7A237EDAA2F", 1);
  level.parachutecancutautodeploy = 1;
  level.parachutecancutparachute = 1;
  level.music_style = "middle_east";
  level.outofboundstriggers = getEntArray("OutOfBounds", "targetname");
  scripts\mp\compass::setupminimap("compass_map_mp_regional_gw");
  setDvar("r_umbraMinObjectContribution", 8);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  level thread _id_5F903436642211AF::_id_D8DE1E0BC05F3B3A();
  level._id_624C83B532EFCE04 = 0;
}