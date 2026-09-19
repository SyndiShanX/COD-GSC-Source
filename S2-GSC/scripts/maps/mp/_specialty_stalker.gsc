/**************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\_specialty_stalker.gsc
**************************************************/

_id_93B0() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  self._id_4B45 = 0;

  for(;;) {
    if(!self._id_4B45) {
      if(self _meth_82AA("specialty_stalker", 1))
        self unsetperk("specialty_stalker", 1);

      waitframe();
      continue;
    }

    if(!self _meth_82AA("specialty_stalker", 1))
      self setperk("specialty_stalker", 1, 0);

    waitframe();
  }
}