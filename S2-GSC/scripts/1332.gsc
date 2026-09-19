/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1332.gsc
**************************************/

init() {
  self._id_4B91 = 0;
  level._id_83C8 = 6.0;
  level._id_83C9 = 0.05;
  level._id_83C7 = 1.25;
  level._id_83CA = 4;
}

_id_3662() {
  maps\mp\_utility::giveperk("specialty_finalstand");
  self._id_4B91 = 1;
  self notify("self_revive");
}

_id_2F9E() {
  maps\mp\_utility::_id_0735("specialty_finalstand");
  self._id_4B91 = 0;
  self waittill("revive");
  self._id_98E2 = undefined;
}