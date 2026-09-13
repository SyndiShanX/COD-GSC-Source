/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_7c2660c65d44bc1d.gsc
***********************************************/

main() {
  _id_34FE671DEBCA9689::main();
  _id_75265E274F43109C::main();
  _id_73248BA332E70EC6::main();
  _id_1C51953A2443BCEC::main();
  scripts\mp\load::main();
  scripts\cp_mp\utility\game_utility::_id_5B9E95ACD14775A5();
  level.outofboundstriggers = getEntArray("OutOfBounds", "targetname");
  level.kill_border_triggers = getEntArray("kill_border_trigger", "targetname");
  scripts\mp\compass::setupminimap("compass_map_mp_wartorn");
  setDvar("r_umbraMinObjectContribution", 8);
  setDvar("sm_sunSampleSizeNear", 2);

  if(scripts\mp\utility\game::getgametype() == "rescue")
    setDvar("scr_game_infilSkip", 1);

  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  level.music_style = "middle_east";
  level thread _id_3C37E8E4377AA2B3();
  level thread _id_AAC9DA13F75474C9();
  level thread _id_2CBF252205FA2C0F();
  level thread _id_2EB966C3B80D2DDE();
  level._id_6E31FB115404C96D = ::_id_273F1D81D554DB20;
}

_id_3C37E8E4377AA2B3() {
  scripts\mp\equipment\tactical_cover::_id_C5D3D6E10BD8C8AB((-7843, 43288, 270), 0);
  scripts\mp\equipment\tactical_cover::_id_C5D3D6E10BD8C8AB((-8426, 43463, 295), 0);
  scripts\mp\equipment\tactical_cover::_id_C5D3D6E10BD8C8AB((-8142, 44086, 276), 0);
  scripts\mp\equipment\tactical_cover::_id_C5D3D6E10BD8C8AB((-8203, 43854, 266.286), 0);
  scripts\mp\equipment\tactical_cover::_id_C5D3D6E10BD8C8AB((-8807, 41855, 257.841), 0);
  scripts\mp\equipment\tactical_cover::_id_C5D3D6E10BD8C8AB((-9341, 41680, 260.194), 0);
  scripts\mp\equipment\tactical_cover::_id_C5D3D6E10BD8C8AB((-10037, 41594, 238.635), 0);
  scripts\mp\equipment\tactical_cover::_id_C5D3D6E10BD8C8AB((-9800, 42982, 234.175), 0);
  scripts\mp\equipment\tactical_cover::_id_C5D3D6E10BD8C8AB((-8987, 41784, 257.841), 0);
}

_id_AAC9DA13F75474C9() {
  _id_9CF17C0C6D556300 = undefined;
  _id_B5C312542B7C2AC8 = scripts\engine\utility::getStructArray("infil_mbravo", "script_noteworthy");

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_B5C312542B7C2AC8.size; _id_AC0E594AC96AA3A8++) {
    if(isDefined(_id_B5C312542B7C2AC8[_id_AC0E594AC96AA3A8].target) && issubstr(_id_B5C312542B7C2AC8[_id_AC0E594AC96AA3A8].target, "auto3135"))
      _id_9CF17C0C6D556300 = scripts\engine\utility::getStruct(_id_B5C312542B7C2AC8[_id_AC0E594AC96AA3A8].target, "targetname");
  }

  if(isDefined(_id_9CF17C0C6D556300))
    _id_9CF17C0C6D556300.origin = (-7058.91, 41970.4, 197.97);
}

_id_2CBF252205FA2C0F() {
  trigger_radius = spawn("trigger_radius", (-8224, 43264, 1024), 0, 4096, 1024);
  level.outofboundstriggers = scripts\engine\utility::array_add(level.outofboundstriggers, trigger_radius);
}

_id_273F1D81D554DB20() {
  _id_183BA55FED386936::_id_6E31FB115404C96D("a", (-7712, 44435, 244.401));
  _id_183BA55FED386936::_id_6E31FB115404C96D("b", (-9246, 41841, 249.173));
}

_id_2EB966C3B80D2DDE() {
  _id_322632ABECAA3FCC = spawn("trigger_radius", (-8684, 43062, 264), 0, 16, 80);
  _id_322632ABECAA3FCC.targetname = "tacCameraInvalid";
}