/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\utility\trigger.gsc
***********************************************/

triggerutilityinit() {
  _id_559B1C2DC581F10C = getEntArray("trigger_multiple_mp_enterexit", "classname");

  foreach(trigger in _id_559B1C2DC581F10C)
  makeenterexittrigger(trigger);
}

makeenterexittrigger(trigger, _id_DD47832CD570074B, _id_BE3314F77FEF5D6B, _id_1FA4E076ABA70AB9, _id_0768B0479668F27B, _id_7DE0EFBF334063A9) {
  trigger thread triggerenterthink(_id_DD47832CD570074B, _id_BE3314F77FEF5D6B, _id_1FA4E076ABA70AB9, _id_0768B0479668F27B, _id_7DE0EFBF334063A9);
}

triggerenterthink(_id_DD47832CD570074B, _id_BE3314F77FEF5D6B, _id_1FA4E076ABA70AB9, _id_0768B0479668F27B, _id_7DE0EFBF334063A9) {
  level endon("game_ended");
  self endon("death");
  self.triggerenterents = [];
  self.triggerinsidetimes = [];
  thread triggerexitthink(_id_BE3314F77FEF5D6B, _id_0768B0479668F27B);

  for(;;) {
    self waittill("trigger", _id_2D9552508615D396);

    if(isDefined(_id_7DE0EFBF334063A9) && [[_id_7DE0EFBF334063A9]](_id_2D9552508615D396, self)) {
      continue;
    }
    _id_6B6F0D5308B1CEAB = _id_2D9552508615D396 getentitynumber();

    if(!isDefined(self.triggerenterents[_id_6B6F0D5308B1CEAB])) {
      self notify("trigger_enter", _id_2D9552508615D396);

      if(isDefined(_id_DD47832CD570074B))
        _id_2D9552508615D396 thread[[_id_DD47832CD570074B]](_id_2D9552508615D396, self);

      if(isDefined(_id_1FA4E076ABA70AB9))
        _id_2D9552508615D396 notify(_id_1FA4E076ABA70AB9, self);

      self.triggerenterents[_id_6B6F0D5308B1CEAB] = _id_2D9552508615D396;
      self.triggerinsidetimes[_id_6B6F0D5308B1CEAB] = gettime();
      continue;
    }

    self.triggerinsidetimes[_id_6B6F0D5308B1CEAB] = gettime();
  }
}

triggerexitthink(_id_BE3314F77FEF5D6B, _id_0768B0479668F27B) {
  level endon("game_ended");
  self endon("death");

  for(;;) {
    waittillframeend;
    _id_291148D7C3E8D5E3 = gettime();

    foreach(_id_F8ED6D4543FB3B7B, ent in self.triggerenterents) {
      if(!isDefined(ent)) {
        self.triggerenterents[_id_F8ED6D4543FB3B7B] = undefined;
        self.triggerinsidetimes[_id_F8ED6D4543FB3B7B] = undefined;
        continue;
      }

      if(self.triggerinsidetimes[_id_F8ED6D4543FB3B7B] < _id_291148D7C3E8D5E3) {
        self notify("trigger_exit", ent);

        if(isDefined(_id_BE3314F77FEF5D6B))
          ent thread[[_id_BE3314F77FEF5D6B]](ent, self);

        if(isDefined(_id_0768B0479668F27B))
          ent notify(_id_0768B0479668F27B, self);

        self.triggerenterents[_id_F8ED6D4543FB3B7B] = undefined;
        self.triggerinsidetimes[_id_F8ED6D4543FB3B7B] = undefined;
      }
    }

    waitframe();
  }
}