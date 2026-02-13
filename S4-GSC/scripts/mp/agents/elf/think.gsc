/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\agents\elf\think.gsc
*************************************************/

main() {}

init() {
  self._id_189F = spawnStruct();
  self._id_189F._id_AAC4 = [];
  self._id_189F._id_AAC4["idle"] = _id_0AFD::main;
  self._id_189F._id_AAC4["move"] = _id_0AFF::main;
  self._id_189F._id_AAC4["traverse"] = _id_0B01::main;
  self._id_189F._id_AAC4["melee"] = _id_0AFE::main;
  self._id_189F._id_AADC = [];
  self._id_189F._id_AADC["idle"] = _id_0AFD::_id_0191;
  self._id_189F._id_AADC["move"] = _id_0AFF::_id_0191;
  self._id_189F._id_AADC["melee"] = _id_0AFE::_id_0191;
  self._id_189F._id_AADC["traverse"] = _id_0B01::_id_0191;
  self._id_13E7 = "idle";
  self._id_0359 = 15;
  self.height = 40;
  thread movetoplayer();
}

movetoplayer() {
  for(;;) {
    self _meth_8326(self.origin + (randomint(128) - 64, randomint(128) - 64, 0));
    wait 5;
  }
}

_id_F108() {
  self endon("death");
  level endon("game_ended");
}