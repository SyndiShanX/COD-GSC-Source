/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1334.gsc
**************************************/

init() {
  self._id_4BA2 = 0;
}

_id_3662() {
  maps\mp\_utility::giveperk("specialty_personaluav");
  maps\mp\_utility::giveperk("specialty_spygame");
  maps\mp\_utility::giveperk("specialty_coldblooded");
  maps\mp\_utility::giveperk("specialty_heartbreaker");
  maps\mp\_utility::giveperk("specialty_undercover");
  self._id_267E = maps\mp\gametypes\_class::_id_1F95(1);
  maps\mp\gametypes\_class::_id_21B9();
  _id_0510::_id_73CA();
  self._id_4BA2 = 1;
}

_id_2F9E() {
  maps\mp\_utility::_id_0735("specialty_coldblooded");
  maps\mp\_utility::_id_0735("specialty_spygame");
  maps\mp\_utility::_id_0735("specialty_heartbreaker");
  maps\mp\_utility::_id_0735("specialty_personaluav");
  maps\mp\_utility::_id_0735("specialty_undercover");
  self._id_267E = maps\mp\gametypes\_class::_id_1F95(1);
  maps\mp\gametypes\_class::_id_21B9();
  _id_0510::_id_73CA();
  self._id_4BA2 = 0;
}