/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1326.gsc
**************************************/

init() {
  level.adrenalineshotmovespeedscale = 1.1;
  level._id_0A0A = 100;
  level._id_0A0B = 1.5;
  level._id_0A0C = 13.33;
  level._id_0A07 = 1.0;
  self._id_4B50 = 0;
}

_id_3662() {
  maps\mp\_utility::_id_870F(level._id_0A0A);
  self._id_7AD7 = level._id_0A0A;
  self._id_98E1 = level._id_0A0B;
  self._id_98E2 = level._id_0A0C;
  self._id_4B50 = 1;
  _id_0513::_id_A13B();
}

_id_2F9E() {
  maps\mp\_utility::_id_870F(0);
  self._id_7AD7 = 0;
  self._id_98E1 = undefined;
  self._id_98E2 = undefined;
  self._id_4B50 = 0;
  _id_0513::_id_A13B();
}