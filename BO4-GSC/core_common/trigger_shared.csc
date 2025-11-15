/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\trigger_shared.csc
***********************************************/

#namespace trigger;

function_thread(ent, on_enter_payload, on_exit_payload) {
  ent endon(#"death");

  if(!isDefined(self)) {
    return;
  }

  myentnum = self getentitynumber();

  if(ent ent_already_in(myentnum)) {
    return;
  }

  add_to_ent(ent, myentnum);

  if(isDefined(on_enter_payload)) {
    [[on_enter_payload]](ent);
  }

  while(isDefined(ent) && isDefined(self) && ent istouching(self)) {
    waitframe(1);
  }

  if(isDefined(ent)) {
    if(isDefined(on_exit_payload)) {
      [
        [on_exit_payload]
      ](ent);
    }

    remove_from_ent(ent, myentnum);
  }
}

ent_already_in(var_d35ff8d8) {
  if(!isDefined(self._triggers)) {
    return false;
  }

  if(!isDefined(self._triggers[var_d35ff8d8])) {
    return false;
  }

  if(!self._triggers[var_d35ff8d8]) {
    return false;
  }

  return true;
}

add_to_ent(ent, var_d35ff8d8) {
  if(!isDefined(ent._triggers)) {
    ent._triggers = [];
  }

  ent._triggers[var_d35ff8d8] = 1;
}

remove_from_ent(ent, var_d35ff8d8) {
  if(!isDefined(ent._triggers)) {
    return;
  }

  if(!isDefined(ent._triggers[var_d35ff8d8])) {
    return;
  }

  ent._triggers[var_d35ff8d8] = 0;
}

death_monitor(ent, ender) {
  ent waittill(#"death");
  self endon(ender);
  self remove_from_ent(ent);
}

trigger_wait(n_clientnum) {
  self endon(#"trigger");

  if(isDefined(self.targetname)) {
    trig = getent(n_clientnum, self.targetname, "target");

    if(isDefined(trig)) {
      trig waittill(#"trigger");
    }
  }
}