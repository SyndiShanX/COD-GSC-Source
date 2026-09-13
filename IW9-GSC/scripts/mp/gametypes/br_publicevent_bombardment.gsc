/***************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_publicevent_bombardment.gsc
***************************************************************/

init() {
  weight = getdvarfloat("dvar_B6558EAAEA5CA34A", 0);
  _id_337BD370F7C5E6F9::registerpublicevent(5, ::validatefunc, weight, ::waitfunc, ::activatefunc);
}

validatefunc() {
  return 0;
}

waitfunc() {
  level endon("cancel_public_event");
}

activatefunc() {}