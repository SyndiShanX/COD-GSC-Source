/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_8dcb71820aef7f1.gsc
***********************************************/

main() {
  _id_253C4080C47F6AF6::main();
  _id_4294D267286BE9F2::main();
  _id_7CD8F606F15F4188::main();
  scripts\mp\load::main();
  level.outofboundstriggers = getEntArray("OutOfBounds", "targetname");
  scripts\mp\compass::setupminimap("compass_map_mp_m_king", "codcaster_compass_map_mp_m_king");
  scripts\cp_mp\utility\game_utility::registersmallmap();
  scripts\cp_mp\utility\game_utility::registerarenamap();
  level.requiresminstartspawns = 0;
  setDvar("r_umbraMinObjectContribution", 8);
  setDvar("dvar_E5F30226445F4B37", 15);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "desert";
  game["axis_outfit"] = "desert";
  thread patchfix();
  thread _id_6E3CCE6A02667476();
}

patchfix() {
  _id_21D7CD156CAFE874 = spawn("script_model", (0, 0, 8));
  _id_21D7CD156CAFE874 setModel("mp_m_king_shotblocker");
  _id_21D7CD156CAFE874.angles = (0, 180, 0);
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