/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_44f74127a05cfeb5.gsc
***********************************************/

main() {
  _id_4F78707E1B9AA92A::main();
  _id_3C6720B4E2DAD70E::main();
  _id_46A3416E02140B54::main();
  scripts\mp\load::main();
  scripts\common\create_script_utility::initialize_create_script();
  level thread _id_39B9C1228BCFF40F::main();

  switch (scripts\mp\utility\game::getgametype()) {
    case "bigctf":
      level thread _id_66229835711E23CC::main();
      _id_39A8B103D9252A73::_id_60DB244685153D79();
      break;
    case "sd":
    case "rescue":
      level._id_D27F667E6320D465 = _id_CB3DF2A869EA3CF0();
    case "cyber":
      scripts\mp\utility\dialog::_id_7991789FBDEF687E();
      level thread _id_1849AB4CE4F722F8::main();
      scripts\mp\spawnlogic::_id_9A3BEF3FFEF9C904(1);
      break;
    case "infect":
      _id_074922A76F9FD2DE = spawn("trigger_radius", (-31850, -2850, 2400), 0, 4500, 1400);
      _id_074922A76F9FD2DE.targetname = "OutOfBounds";
      _id_074922A76F9FD2DE._id_0456768C2E700260 = 1;
      _id_074921A76F9FD0AB = spawn("trigger_radius", (-25600, 1350, 2350), 0, 1900, 500);
      _id_074921A76F9FD0AB.targetname = "OutOfBounds";
      _id_074921A76F9FD0AB._id_0456768C2E700260 = 1;
      break;
  }

  scripts\cp_mp\utility\game_utility::registerlargemap();
  scripts\cp_mp\utility\game_utility::_id_5B9E95ACD14775A5();

  if(scripts\mp\utility\game::_id_A7CAA13EBE4C4BA5() || scripts\mp\utility\game::isgroundwarcoremode()) {
    if(!isDefined(scripts\cp_mp\utility\game_utility::getlocaleid())) {
      switch (scripts\mp\utility\game::getgametype()) {
        case "gwtdm":
          setDvar("scr_localeID", 31);
          break;
        case "cyber":
        case "sd":
        case "rescue":
          setDvar("scr_localeID", 130);
          break;
        default:
          setDvar("scr_localeID", 30);
          break;
      }
    }

    _id_3BA4F32E41F63B36::arm_initoutofbounds();
  } else {
    level.outofboundstriggers = getEntArray("OutOfBounds", "targetname");
    level.kill_border_triggers = getEntArray("kill_border_trigger", "targetname");
  }

  level.outofboundstriggers = getEntArray("OutOfBounds", "targetname");
  scripts\mp\compass::setupminimap("compass_map_mp_caves_gw");
  setDvar("r_umbraMinObjectContribution", 8);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  level._id_EE41A5AAF764C9CC = 1;
  thread _id_B2F8F087CEB71FEA();
}

_id_CB3DF2A869EA3CF0() {
  struct = spawnStruct();
  struct._id_8E9196B67A6D5933 = "sd_bomb_spawn_mod";
  struct._id_0B6C7DDACAF25D01 = "sd_bombzone_a_mod";
  struct._id_0B6C7ADACAF25668 = "sd_bombzone_b_mod";
  struct._id_8680EA7B41BDF4DC = "sd_allied_spawn_mod";
  struct._id_388ABE281AFCD6F6 = "sd_axis_spawn_mod";
  struct._id_4CB3562E52DD45B8 = "hr_extraction_zone_mod";
  struct._id_7FDCF3BD51650CF2 = "hostage_a_mod";
  struct._id_7FDCF2BD51650ABF = "hostage_b_mod";
  struct._id_A1DEE46F5965DAFB = "hr_allied_spawn_mod";
  struct._id_199B24846B757EBD = "hr_axis_spawn_mod";
  return struct;
}

_id_B2F8F087CEB71FEA() {
  _id_45428B56EF07EA91 = spawn("script_model", (-30294, 104, 2112));
  _id_45428B56EF07EA91 setModel("building_support_wood_beam_05_re_size");
}