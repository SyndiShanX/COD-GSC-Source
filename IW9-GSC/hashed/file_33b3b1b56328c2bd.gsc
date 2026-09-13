/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_33b3b1b56328c2bd.gsc
***********************************************/

_id_E41E45600B03085A(asmname, statename, params) {
  self endon(statename + "_finished");
  meleeanim = scripts\asm\asm::asm_getanim(asmname, statename);
  self aisetanim(statename, meleeanim, 1.0);
  scripts\asm\asm::asm_donotetrackswithinterceptor(asmname, statename, ::_id_9CE8D4CF1BADBACD);
}

_id_9CE8D4CF1BADBACD(statename, _id_A234A65C378F3289, _id_314A4FBCE09143E7) {
  if(_id_A234A65C378F3289 == "fire") {
    target = self._id_6EA17FD821A76B9F;
    _id_034AA97BBCE2BDE0 = vectorNormalize(target.origin - self.origin);
    scripts\asm\soldier\melee::_id_E157C0CE32F71CBE(target, 0, _id_034AA97BBCE2BDE0);
    return 1;
  }
}

_id_A775E621341BBE90(asmname, statename, _id_F2B19B25D457C2A6, params) {
  if(distance2dsquared(self.origin, self._id_6EA17FD821A76B9F.origin) < 6400)
    return 1;

  return 0;
}