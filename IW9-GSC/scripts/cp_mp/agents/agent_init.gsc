/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\agents\agent_init.gsc
***********************************************/

agent_init() {
  if(isDefined(anim.notfirsttime)) {
    return;
  }
  anim.notfirsttime = 1;
  _id_3433EE6B63C7E243::initanimvars();
  scripts\asm\asm_mp::_id_A2B8F8B0891EE7FE();
  _id_3433EE6B63C7E243::initmeleecharges();
  _id_3433EE6B63C7E243::initwindowtraverse();
  _id_3433EE6B63C7E243::setuprandomtable();
  _id_3433EE6B63C7E243::init_squadmanager();
  setupgrenades();
  initanimcallbacks();
  initstealthfuncsmp();
  _id_4ADE3AE5C138C8B3::initlevelface();
  _id_6FBA7DF440C493C4::vehicleaniminit();
}

setupgrenades() {
  _func_B4EBE6632D7E8EFE(undefined, "lethal", randomintrange(0, 20000));
  _func_B4EBE6632D7E8EFE(undefined, "tactical", randomintrange(0, 20000));
}

initanimcallbacks() {
  if(!isDefined(anim.callbacks))
    anim.callbacks = [];

  anim.callbacks["PlaySoundAtViewHeight"] = ::play_sound_at_viewheightmp;
}

play_sound_at_viewheightmp(aliasname, _id_B1A4E9FA39B3858A, _id_A68ADBD3EEFE9282) {
  if(!isDefined(aliasname)) {
    return;
  }
  if(!soundexists(aliasname)) {
    return;
  }
  self playSound(aliasname, undefined, self);

  if(isDefined(_id_B1A4E9FA39B3858A)) {
    wait(lookupsoundlength(aliasname) / 1000);
    self notify(_id_B1A4E9FA39B3858A);
  }
}

initstealthfuncsmp() {
  level.stealthinit = ::initstealthmp;
}

getcorpsearraymp() {
  return [];
}

setcorpseremovetimerfuncmp() {}

initstealthmp() {
  level.fngetcorpsearrayfunc = ::getcorpsearraymp;
  level.fnsetcorpseremovetimerfunc = ::setcorpseremovetimerfuncmp;
}