/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_7845ba34dcf9b77b.gsc
*************************************************/

#using script_d74ae0b4aa21186;
#using scripts\engine\utility;
#using scripts\mp\gameobjects;
#namespace namespace_746991ada5f529ec;

function createevent() {
  event = function_c74368899713e7e6();
  event.result = [];
  eventstream = self.mind.eventstream;
  eventstream.var_d338b2cc0965fdb3 = event;
  eventstream.events[eventstream.events.size] = event;
}

function getevent() {
  event = self.mind.eventstream.var_d338b2cc0965fdb3;

  if(!event.evaluated) {
    if(event.result.size > 0) {
      event.result = [];
    }

    if(!isDefined(level.allfobs)) {
      return event.result;
    }

    foreach(fob in level.allfobs) {
      var_b9100d06b4fcec73 = fob.trigger.gameobject;

      if(!var_b9100d06b4fcec73 scripts\mp\gameobjects::caninteractwith(self.team)) {
        continue;
      }

      event.result[event.result.size] = fob;
    }

    event.evaluated = 1;
  }

  return event.result;
}