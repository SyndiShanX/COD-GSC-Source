/*****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\_fastheal.gsc
*****************************************/

_id_A908() {
  self endon("spawned_player");
  self endon("disconnect");
  self endon("death");
  self endon("faux_spawn");

  if(!isDefined(level._id_3A58)) {
    _id_3A57();
  }

  for(;;) {
    self waittill("grenade_fire", var_0, var_1);

    if(var_1 == "fast_heal_mp") {
      if(!isalive(self)) {
        var_0 delete();
        return;
      }

      thread _id_9E29();
    }
  }
}

_id_3A57() {
  self._id_3A58 = spawnStruct();
}

_id_9E29() {
  if(!isDefined(self._id_3A58)) {
    _id_3A57();
  }

  _id_7D5D();
  thread _id_92CC();
  thread _id_63BF();
  return 1;
}

_id_92CC() {
  self endon("ClearFastHeal");
  self endon("death");
  self playlocalsound("earn_superbonus");
  self._id_56E9 = 1;
  self._id_50A0 = 1;
  self._id_98E1 = 1.5;
  self._id_98E2 = 13.33;
  self notify("damage");
  wait 10;
  self._id_98E1 = undefined;
  self._id_98E2 = undefined;
  self._id_56E9 = 0;

  if(isDefined(self._id_3A58._id_6CA4)) {
    self._id_3A58._id_6CA4 destroy();
  }

  self notify("EndFastHeal");
}

_id_7D5D() {
  if(isDefined(self._id_56E9) && self._id_56E9 == 1) {
    if(isDefined(self._id_3A58._id_6CA4)) {
      self._id_3A58._id_6CA4 destroy();
    }

    self._id_98E1 = undefined;
    self._id_98E2 = undefined;
    self notify("ClearFastHeal");
  }
}

_id_63BF() {
  self endon("EndFastHeal");
  self waittill("death");
  self._id_98E1 = undefined;
  self._id_98E2 = undefined;
  self._id_56E9 = 0;

  if(isDefined(self._id_3A58._id_6CA4)) {
    self._id_3A58._id_6CA4 destroy();
  }
}

_id_7723() {
  self endon("EndFastHeal");
  self endon("death");

  for(;;) {
    _iprintlnbold(self.health);
    wait 1;
  }
}