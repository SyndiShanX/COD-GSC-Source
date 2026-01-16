/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\trigger_shared.csc
*************************************************/

#namespace trigger;

function function_d1278be0(ent, on_enter_payload, on_exit_payload) {
  ent endon("entityshutdown");
  if(ent ent_already_in(self)) {
    return;
  }
  add_to_ent(ent, self);
  if(isdefined(on_enter_payload)) {
    [
      [on_enter_payload]
    ](ent);
  }
  while (isdefined(ent) && ent istouching(self)) {
    wait(0.016);
  }
  if(isdefined(ent) && isdefined(on_exit_payload)) {
    [
      [on_exit_payload]
    ](ent);
  }
  if(isdefined(ent)) {
    remove_from_ent(ent, self);
  }
}

function ent_already_in(trig) {
  if(!isdefined(self._triggers)) {
    return false;
  }
  if(!isdefined(self._triggers[trig getentitynumber()])) {
    return false;
  }
  if(!self._triggers[trig getentitynumber()]) {
    return false;
  }
  return true;
}

function add_to_ent(ent, trig) {
  if(!isdefined(ent._triggers)) {
    ent._triggers = [];
  }
  ent._triggers[trig getentitynumber()] = 1;
}

function remove_from_ent(ent, trig) {
  if(!isdefined(ent._triggers)) {
    return;
  }
  if(!isdefined(ent._triggers[trig getentitynumber()])) {
    return;
  }
  ent._triggers[trig getentitynumber()] = 0;
}

function death_monitor(ent, ender) {
  ent waittill("death");
  self endon(ender);
  self remove_from_ent(ent);
}