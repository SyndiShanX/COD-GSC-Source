/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_22e77efec20671a3.gsc
***********************************************/

main() {
  _id_7ADDD92855B1A362::main();
  _id_2B6319138B099D10::main();
  _id_7C13A324B0BF1A2E::main();
  scripts\mp\load::main();
  level.outofboundstriggers = getEntArray("OutOfBounds", "targetname");
  scripts\mp\compass::setupminimap("compass_map_mp_m_fight");
  scripts\cp_mp\utility\game_utility::registersmallmap();
  scripts\cp_mp\utility\game_utility::registerarenamap();
  level.requiresminstartspawns = 0;
  setDvar("r_umbraMinObjectContribution", 8);
  setDvar("dvar_E5F30226445F4B37", 15);
  level._id_0A5464F8C55D0857 = spawnStruct();
  level._id_0A5464F8C55D0857.enabled = getdvarint("dvar_BDA2831BA547919D", 1);
  level._id_0A5464F8C55D0857._id_C2860AC9BF1552F1 = getdvarfloat("dvar_BFF9BD20FD09593C", 2.24);
  level._id_0A5464F8C55D0857.timeout = getdvarfloat("dvar_0FFF9CAE16AC4C27", 30);
  level._id_0A5464F8C55D0857._id_B2892FF2F33B4FB6 = getdvarint("dvar_4E0AB8781F70B8CD", 30);
  level._id_0A5464F8C55D0857._id_3B72D2F29AD349E6 = getdvarint("dvar_ACBA8579216A6FAD", 1);
  level._id_0A5464F8C55D0857._id_83CAA1F2CFC89661 = getdvarint("dvar_D716FE79400AC7AA", 1);
  level._id_0A5464F8C55D0857._id_A0F2F446F54C692E = getdvarint("dvar_6E971A9D3EC6DBC5", 0);
  level._id_0A5464F8C55D0857._id_FA3D9843491A78AB = getdvarint("dvar_D66262074A4892A8", 1);
  level._id_0A5464F8C55D0857._id_5ED47EE04969D752 = getdvarint("dvar_5CDD68327AFB4DB7", 1);
  level._id_0A5464F8C55D0857.cooldown = getdvarfloat("dvar_A0946555FFBBCB25", 20);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  thread _id_9AF23C91833EDA6D();
  thread _id_6E3CCE6A02667476();

  if(istrue(level._id_0A5464F8C55D0857.enabled))
    thread _id_1181EE13D09794EF::_id_42370792FB04B498();
}

_id_9AF23C91833EDA6D() {
  while(!isDefined(level.teambased))
    waitframe();

  if(!level.teambased)
    level.disableteamstartspawns = 1;
}

_id_6E3CCE6A02667476() {
  level endon("game_ended");

  for(;;) {
    level waittill("connected", player);
    _id_DA7C9335E454C032(player);
    player thread _id_5B2361E97848CABD();
  }
}

_id_DA7C9335E454C032(player) {
  if(getdvarint("camera_thirdPerson") == 1 || istrue(level._id_DC65C33DFDD9EFE8))
    setDvar("dvar_31F818870138CD26", 1);
}

_id_5B2361E97848CABD() {
  self endon("disconnect");
  level waittill("game_ended");
  setDvar("dvar_31F818870138CD26", 0);
}