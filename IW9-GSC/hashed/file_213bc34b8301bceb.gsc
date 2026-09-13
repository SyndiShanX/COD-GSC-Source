/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_213bc34b8301bceb.gsc
***********************************************/

playanim_flashed(asmname, statename, params) {
  self endon(statename + "_finished");
  playanim_flashed_internal(asmname, statename);
  thread playanim_monitorflashrestart(asmname, statename);
  scripts\asm\asm::asm_donotetracks(asmname, statename);
}

playanim_flashed_internal(asmname, statename) {
  _id_C22C902BF03BD098 = scripts\asm\asm::asm_getanim(asmname, statename);
  rate = 1;

  if(isDefined(self.flashendtime)) {
    _id_1EA801324C12E83D = self.flashendtime - gettime();
    xanim = scripts\asm\asm::asm_getxanim(statename, _id_C22C902BF03BD098);
    animlength = getanimlength(xanim) * 1000;

    if(_id_1EA801324C12E83D > 0)
      rate = animlength / _id_1EA801324C12E83D;

    rate = rate + randomfloatrange(-0.2, 0.2);
    rate = clamp(rate, 0.2, 1.65);
  }

  self aisetanim(statename, _id_C22C902BF03BD098, rate);
}

playanim_monitorflashrestart(asmname, statename) {
  self endon(statename + "_finished");
  _id_B2A1F003A8F9E6D2 = self.flashendtime;

  while(isDefined(self.flashendtime)) {
    if(_id_B2A1F003A8F9E6D2 != self.flashendtime) {
      _id_B2A1F003A8F9E6D2 = self.flashendtime;
      playanim_flashed_internal(asmname, statename);
    }

    waitframe();
  }
}

cleanupflashanim(asmname, statename, params) {
  self notify("killanimscript");
  scripts\common\utility::flashbangstop();
}

_id_6DE4688D752DFA75(asmname, statename, _id_F2B19B25D457C2A6, params) {
  return getdvarint("dvar_3A2B15C19281B591", 1) == 1;
}