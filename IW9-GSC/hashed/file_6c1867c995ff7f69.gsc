/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_6c1867c995ff7f69.gsc
***********************************************/

_id_0259406F795183FF() {}

_id_6BDD824A574AE2AB(_id_5D184D82B16C3A51, _id_7D6DBD1D06DE3FFC) {
  if(!isDefined(self._id_821252F0EBAE8EB9))
    self._id_821252F0EBAE8EB9 = spawnStruct();

  self._id_821252F0EBAE8EB9._id_5D184D82B16C3A51 = _id_5D184D82B16C3A51;
  self._id_821252F0EBAE8EB9._id_7D6DBD1D06DE3FFC = _id_7D6DBD1D06DE3FFC;
  scripts\asm\asm::asm_setstate("dismember");
}

_id_0670F69C1477FE88() {
  if(isDefined(self._id_821252F0EBAE8EB9)) {
    self._id_821252F0EBAE8EB9._id_5D184D82B16C3A51 = undefined;
    self._id_821252F0EBAE8EB9._id_7D6DBD1D06DE3FFC = undefined;
    self._id_821252F0EBAE8EB9 = undefined;
  }
}

_id_FD57481F300CDD94() {
  if(self._id_821252F0EBAE8EB9._id_5D184D82B16C3A51 == 1)
    return 1;

  return 0;
}

_id_318BD5538CA7A161() {
  if(self._id_821252F0EBAE8EB9._id_5D184D82B16C3A51 == 2)
    return 1;

  return 0;
}

_id_9B13151FA2FE652E() {
  if(self._id_821252F0EBAE8EB9._id_5D184D82B16C3A51 == 4)
    return 1;

  return 0;
}

_id_EDC6E054167F1BE3() {
  if(self._id_821252F0EBAE8EB9._id_5D184D82B16C3A51 == 8)
    return 1;

  return 0;
}

_id_EEDCCF7E101FC75E() {
  if(self._id_821252F0EBAE8EB9._id_5D184D82B16C3A51 == 12)
    return 1;

  return 0;
}

_id_F108D485B5F2B11B() {
  if(!isDefined(self._id_821252F0EBAE8EB9))
    return 0;

  return 1;
}

_id_B35C271C0522C792() {
  return self._id_821252F0EBAE8EB9._id_7D6DBD1D06DE3FFC;
}

_id_BF9BCCF77774E97F(movetype) {
  if(!scripts\asm\asm_bb::bb_moverequested())
    return 0;

  return scripts\asm\asm_bb::bb_movetyperequested(movetype);
}

_id_A2F24827E0F48FB2(asmname, statename, params) {
  self endon(statename + "_finished");
  self endon("death");
  self endon("terminate_ai_threads");
  animindex = scripts\asm\asm_mp::asm_getanimindex(asmname, statename);
  _id_AF8F2875D40DB60F(statename, animindex);
  _id_0670F69C1477FE88();
}

_id_AF8F2875D40DB60F(statename, animindex) {
  self endon(statename + "_finished");
  self endon("death");
  self endon("terminate_ai_threads");
  scripts\mp\agents\scriptedagents::playanimnatrateuntilnotetrack_safe(statename, animindex, self._id_0DA951E8204605E7, "end");
}

_id_A24DFF1AB397A8C7() {
  if(!isDefined(self._id_E4CC6D9942333B6F))
    return 0;

  _id_6FDF0163E9BC1DB7 = self._id_E4CC6D9942333B6F & 1;
  return _id_6FDF0163E9BC1DB7 != 0;
}

_id_70F96AD5BD833DBC() {
  if(!isDefined(self._id_E4CC6D9942333B6F))
    return 0;

  _id_50BE03284E4758EC = self._id_E4CC6D9942333B6F & 2;
  return _id_50BE03284E4758EC != 0;
}