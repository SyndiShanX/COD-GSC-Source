/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\asm\soldier\mp\script_funcs.gsc
***************************************************/

forwardpushevent(asmname, statename, _id_F2B19B25D457C2A6, params) {
  _id_F449E4F8397F13E7 = scripts\asm\asm::asm_geteventdata(asmname, "player_pushed");
  scripts\asm\asm::asm_fireephemeralevent("player_pushed", "player_pushed", _id_F449E4F8397F13E7);
}

playanim_pushed(asmname, statename, params) {
  _id_93A2C35BC9547955 = scripts\asm\asm::asm_getanim(asmname, statename);
  _id_F449E4F8397F13E7 = scripts\asm\asm::asm_getephemeraleventdata("player_pushed", "player_pushed");

  if(isDefined(_id_F449E4F8397F13E7)) {
    _id_D4C3D11EC9988C73 = vectortoyaw(-1 * _id_F449E4F8397F13E7);
    self orientmode("face angle", _id_D4C3D11EC9988C73);
  }

  scripts\asm\shared\utility::playanim(asmname, statename, params);
}

playmovestrafeloop(asmname, statename, params) {
  initmovestrafeloop(asmname, statename, params);
  movestrafeloop(asmname, statename);
}

initmovestrafeloop(asmname, statename, params) {}

movestrafeloop(asmname, statename) {
  self endon(statename + "_finished");
  _id_716305D827F02E47 = scripts\asm\asm::asm_lookupanimfromalias(statename, "f");
  _id_0233122D71B43D5D = scripts\asm\asm::asm_lookupanimfromalias(statename, "l");
  _id_C27A909E04161CCB = scripts\asm\asm::asm_lookupanimfromalias(statename, "r");
  _id_B5DE2F493F49BDFB = scripts\asm\asm::asm_lookupanimfromalias(statename, "b");
  lastanim = -1;
  _id_3B56F1EFA6CF1BB8 = -1;

  for(;;) {
    _id_37EE045145512FBD = _id_2B79931B08683E0A::quadrantanimweights(self getmotionangle());

    if(_id_37EE045145512FBD["back"] == 1.0)
      _id_3B56F1EFA6CF1BB8 = _id_B5DE2F493F49BDFB;
    else if(_id_37EE045145512FBD["left"] == 1.0)
      _id_3B56F1EFA6CF1BB8 = _id_0233122D71B43D5D;
    else if(_id_37EE045145512FBD["right"] == 1.0)
      _id_3B56F1EFA6CF1BB8 = _id_C27A909E04161CCB;
    else
      _id_3B56F1EFA6CF1BB8 = _id_716305D827F02E47;

    if(_id_3B56F1EFA6CF1BB8 != lastanim)
      self aisetanim(statename, _id_3B56F1EFA6CF1BB8);

    lastanim = _id_3B56F1EFA6CF1BB8;
    wait 0.25;
  }
}

playmeleeanim_seekerattack_victim(asmname, statename, params) {}

playmeleeanim_c6freed(asmname, statename, params) {}