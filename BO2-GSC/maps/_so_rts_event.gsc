/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_so_rts_event.gsc
**************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_scene;
#include maps\_music;
#include maps\_so_rts_event;
#include maps\_so_rts_support;
#include maps\_utility_code;

init() {
  level.rts.events = [];
  level.rts.event_queue = [];
  level.rts.events_dialogchannellock = undefined;
  level.rts.voxids = [];
  level.rts.voxids["allies"] = [];
  flag_init("rts_event_ready");
  types = [];
  types[0] = "dialog";
  types[1] = "sfx";
  types[2] = "music";
  types[3] = "fx";
  types[4] = "callback";
  types[5] = "multi";
  level.rts.event_types = types;
  event_populate("sp/so_rts/rts.csv");
  event_populate(level.rts_def_table);
  maps\_so_rts_event::register_event("friendly_select", maps\_so_rts_event::make_event_param(4, maps\_so_rts_support::get_selection_alias_from_targetname), 850);
  level thread event_process();
}

lookup_value(ref, idx, column_index, table) {
  assert(isDefined(idx));
  return tablelookup(table, 0, idx, column_index);
}

get_event_ref_by_index(idx, table) {
  return tablelookup(table, 0, idx, 1);
}

event_populate(table) {
  types = [];
  types["dialog"] = 0;
  types["sfx"] = 1;
  types["music"] = 2;
  types["fx"] = 3;
  types["multi"] = 5;

  for(i = 500; i <= 800; i++) {
    ref = get_event_ref_by_index(i, table);

    if(!isDefined(ref) || ref == "") {
      continue;
    }
    type = lookup_value(ref, i, 2, table);
    param1 = lookup_value(ref, i, 3, table);
    param2 = lookup_value(ref, i, 4, table);
    param3 = lookup_value(ref, i, 5, table);
    cooldown = float(lookup_value(ref, i, 6, table));
    latency = float(lookup_value(ref, i, 7, table));
    triggernotify = lookup_value(ref, i, 8, table);
    maxplays = int(lookup_value(ref, i, 9, table));
    priority = int(lookup_value(ref, i, 10, table));
    daisy = lookup_value(ref, i, 11, table);
    unique = int(lookup_value(ref, i, 12, table));
    assert(isDefined(types[type]), "Illegal type parsed in event table:" + type);
    type = types[type];

    if(param1 == "")
      param1 = undefined;

    if(param2 == "")
      param2 = undefined;

    if(param3 == "")
      param3 = undefined;

    if(cooldown == 0)
      cooldown = undefined;

    if(latency == 0)
      latency = undefined;

    if(triggernotify == "")
      triggernotify = undefined;

    if(maxplays == 0)
      maxplays = undefined;

    if(daisy == "")
      daisy = undefined;

    if(type == 5)
      assert(isDefined(param1), "param1 must contain the list of event refs to trigger seperated by a space");

    register_event(ref, make_event_param(type, param1, param2, param3), cooldown, latency, triggernotify, maxplays, priority, daisy, unique);
  }
}

event_clearall(type) {
  if(!isDefined(type))
    level.rts.event_queue = [];
  else {
    unprocessed = [];

    for(i = 0; i < level.rts.event_queue.size; i++) {
      event = level.rts.event_queue[i];

      if(event.data.type != type)
        unprocessed[unprocessed.size] = event;
    }

    level.rts.event_queue = unprocessed;
  }
}

event_clearqueuebyref(ref) {
  unprocessed = [];

  for(i = 0; i < level.rts.event_queue.size; i++) {
    event = level.rts.event_queue[i];

    if(event.def.ref != ref)
      unprocessed[unprocessed.size] = event;
  }

  level.rts.event_queue = unprocessed;
}

event_process() {
  while(true) {
    processed = [];
    unprocessed = [];

    if(level.rts.event_queue.size > 0) {
      time = gettime();

      for(i = 0; i < level.rts.event_queue.size; i++) {
        event = level.rts.event_queue[i];

        if(isDefined(event.def.latency)) {
          if(time > event.timestamp + event.def.latency) {
            event.executedat = time;
            event.expired = 1;
            processed[processed.size] = event;
            continue;
          }
        }

        if(isDefined(event.def.lastexecutedat) && isDefined(event.def.cooldown)) {
          if(time < event.def.lastexecutedat + event.def.cooldown)
            continue;
        }

        result = event_trigger(event);
        assert(isDefined(result), "event callbacks need to return result");

        if(result) {
          event.executedat = time;
          processed[processed.size] = event;
          continue;
        }
      }

      for(i = 0; i < level.rts.event_queue.size; i++) {
        if(!isDefined(level.rts.event_queue[i].executedat))
          unprocessed[unprocessed.size] = level.rts.event_queue[i];
      }

      level.rts.event_queue = unprocessed;

      for(i = 0; i < processed.size; i++) {
        event = processed[i];
        assert(isDefined(event.executedat));
        level notify("rts_event_" + event.def.ref);

        param = isDefined(event.data.param1) ? event.data.param1 : "";

        if(isDefined(event.expired) && event.expired)
          param = "n/a";

        if(level.rts.event_types[event.data.type] == "callback")
          param = "n/a";

        if(level.rts.event_types[event.data.type] == "sfx" || level.rts.event_types[event.data.type] == "fx")
          tabtype = "\\t\\t\\t";
        else
          tabtype = "\\t\\t";

        println("[Events in queue: " + level.rts.event_queue.size + "]\\t" + isDefined(event.expired) && event.expired ? "EXPIRED: " : "processed: " + event.executedat + "\\t\\tType: " + level.rts.event_types[event.data.type] + tabtype + "(" + event.def.priority + ")Event (" + event.def.ref + ")\\t\\tTriggered: " + isDefined(event.dynamic_alias) ? event.dynamic_alias : param);

        event.def.lastexecutedat = event.executedat;
      }
    }

    wait 0.05;
  }
}

make_event_param(type, param1, param2, param3) {
  dataparam = spawnstruct();
  dataparam.type = type;
  dataparam.param1 = param1;
  dataparam.param2 = param2;
  dataparam.param3 = param3;
  return dataparam;
}

register_event(ref, dataparam, cooldown, latency, trignotify, onetimeonly, priority, daisy, unique) {
  if(!isDefined(priority))
    priority = 0;

  if(!isDefined(unique))
    unique = 0;

  assert(!isDefined(level.rts.events[ref]), "Event with this ref name already exists");
  event = spawnstruct();
  event.ref = ref;
  event.cooldown = cooldown;
  event.latency = latency;
  event.data = dataparam;
  event.onnotify = trignotify;
  event.onetimeonly = onetimeonly;
  event.priority = priority;
  event.count = 0;
  event.daisy = daisy;
  event.unique = unique;

  if(isDefined(event.onnotify))
    level thread event_listener(event);

  if(isDefined(event.latency) && event.latency <= 0)
    event.latency = 100;

  level.rts.events[ref] = event;
}

event_listener(event) {
  level endon("rts_event_" + event.ref);
  level waittill(event.onnotify);
  add_event_to_trigger(event);

  if(isDefined(event.onetimeonly) && event.onetimeonly)
    return;
  else
    level thread event_listener(event);
}

priorityeventcompfunc(e1, e2, param) {
  return e1.def.priority >= e2.def.priority;
}

add_event_to_trigger(event_ref, param) {
  timestamp = gettime();

  if(isDefined(event_ref.lastexecutedat) && isDefined(event_ref.cooldown)) {
    if(timestamp < event_ref.lastexecutedat + event_ref.cooldown)
      return false;
  }

  if(isDefined(event_ref.onetimeonly) && event_ref.onetimeonly && event_ref.count > 0)
    return false;

  if(event_ref.unique) {
    foreach(ev in level.rts.event_queue) {
      if(ev.def.ref == event_ref.ref)
        return false;
    }
  }

  if(event_ref.data.type == 5) {
    refs = strtok(event_ref.data.param1, " ");

    for(i = 0; i < refs.size; i++)
      trigger_event(refs[i], param);

    return true;
  }

  event = spawnstruct();
  event.def = event_ref;
  event.data = event_ref.data;
  event.timestamp = timestamp;
  event.dparam = param;
  event_ref.count++;
  level.rts.event_queue[level.rts.event_queue.size] = event;

  if(level.rts.event_queue.size > 1)
    level.rts.event_queue = maps\_utility_code::mergesort(level.rts.event_queue, ::priorityeventcompfunc);

  if(isDefined(event_ref.daisy))
    trigger_event(event_ref.daisy, param);

  return true;
}

trigger_event(ref, param) {
  if(!flag("rts_event_ready"))
    return 0;

  if(isDefined(level.rts.events[ref]))
    return add_event_to_trigger(level.rts.events[ref], param);
  else {
    println("@@@@@ (" + gettime() + ") WARNING: Event triggered but no reference was found (" + ref + ")");

  }

  return 0;
}

event_notesendondeath(note) {
  num = self getentitynumber();
  level endon(note + "done");
  self waittill("death");

  if(isDefined(level.rts.events_dialogchannellock) && level.rts.events_dialogchannellock == num) {
    level.rts.events_dialogchannellock = undefined;

    println("[Event ** ABORT **]\\t\\t\\t\\t\\t\\tUnlocking channel due to entity death(" + num + "," + note + ")");

  }

  level notify(note + "done");
}

event_playsound(alias, note, guy) {
  level.rts.events_dialogchannellock = guy getentitynumber();

  guy thread event_notesendondeath(note);
  guy playsound(alias, note);
  guy waittill(note);
  level.rts.events_dialogchannellock = undefined;
  level notify(note + "_done");
}

event_trigger(event) {
  time = gettime();

  switch (event.data.type) {
    case 0:
      if(isDefined(level.rts.events_dialogchannellock))
        return 0;

      alias = event.data.param1;
      assert(isDefined(alias), "Unexpected data passed to event_trigger Type:" + event.data.type + " Ref:" + event.def.ref);

      if(isDefined(event.data.param2)) {
        if(event.data.param2 == "player")
          target = level.rts.player;
        else
          target = getent(event.data.param2, "targetname");
      }

      if(isDefined(target) && (target == level.rts.player || isDefined(target.rts_unloaded)))
        thread event_playsound(alias, event.def.ref, target);
      else {
        target = event.data.param3;
        assert(target == "allies" || target == "axis" || target == "dparam", "Unexpected data passed to event_trigger Type:" + event.data.type + " Ref:" + event.def.ref);

        if(target == "dparam")
          assert(isDefined(event.dparam), "Unexpected data passed to event_trigger Type:" + event.data.type + " Ref:" + event.def.ref);

        guys = getvalidvoxlist(target, event.dparam);

        if(guys.size == 0)
          return 0;

        guy = guys[randomint(guys.size)];

        if(!isDefined(guy))
          return 0;

        if(issubstr(alias, "#%#")) {
          tokens = strtok(alias, "#%#");
          alias = tokens[0] + guy.voxid + tokens[1];
        }

        event.dynamic_alias = alias;
        thread event_playsound(alias, event.def.ref, guy);
      }

      return 1;
    case 1:
      alias = event.data.param1;
      assert(isDefined(alias), "Unexpected data passed to event_trigger Type:" + event.data.type + " Ref:" + event.def.ref);

      if(isDefined(event.data.param2)) {
        if(event.data.param2 == "player")
          position = level.rts.player.origin;
        else {
          target = getent(event.data.param2, "targetname");
          assert(isDefined(target), "entity not found");

          if(isDefined(target))
            position = target.origin;
        }
      }

      if(isDefined(event.dparam))
        entity = event.dparam;

      if(isDefined(entity))
        entity playsound(alias);
      else if(isDefined(position))
        playsoundatposition(alias, position);
      else
        level.rts.player playlocalsound(alias);

      return 1;
    case 2:
      alias = event.data.param1;
      assert(isDefined(alias), "Unexpected data passed to event_trigger Type:" + event.data.type + " Ref:" + event.def.ref);
      setmusicstate(alias);
      return 1;
    case 3:
      alias = event.data.param1;
      assert(isDefined(alias), "Unexpected data passed to event_trigger Type:" + event.data.type + " Ref:" + event.def.ref);
      assert(isDefined(level._effect[alias]), "Undefined FX alias passed to event_trigger Type:" + event.data.type + " Ref:" + event.def.ref);
      tag = event.data.param3;

      if(isDefined(tag)) {
        if(isDefined(event.dparam))
          entity = event.dparam;
        else if(isDefined(event.data.param2))
          entity = getent(event.data.param2, "targetname");

        assert(isDefined(entity), "Unexpected data passed to event_trigger Type:" + event.data.type + " Ref:" + event.def.ref);
        playfxontag(level._effect[alias], entity, tag);
      } else {
        if(isDefined(event.dparam))
          position = event.dparam;
        else if(isDefined(event.data.param2)) {
          if(event.data.param2 == "player")
            position = level.rts.player.origin;
          else {
            entity = getent(event.data.param2, "targetname");
            assert(isDefined(entity), "entity not found");
            position = entity.origin;
          }
        }

        assert(isDefined(position), "Unexpected data passed to event_trigger Type:" + event.data.type + " Ref:" + event.def.ref);
        playfx(level._effect[alias], position);
      }

      return 1;
    case 4:
      assert(isDefined(event.data.param1), "Unexpected data passed to event_trigger Type:" + event.data.type + " Ref:" + event.def.ref);
      return [
        [event.data.param1]
      ](event.dparam, event.data.param2, event.data.param3);
  }

  assert(0, "Unhandled event type");
  return 1;
}

allocvoxid(param) {
  if(!isDefined(level.rts.voxids[self.team])) {
    return;
  }
  if(isDefined(level.rts.customvoxallocid))
    return [
      [level.rts.customvoxallocid]
    ](param);

  for(i = 0; i <= 5; i++) {
    voxid = "so" + i;

    if(!isDefined(level.rts.voxids["allies"][voxid])) {
      level.rts.voxids["allies"][voxid] = self;
      self.voxid = voxid;
      self thread voxdeallocatewatch();
      return;
    }
  }
}

voxdeallocatewatch() {
  team = self.team;
  voxid = self.voxid;
  self waittill("death");
  level.rts.voxids[team][voxid] = undefined;
}

getvalidvoxlist(team, dparam) {
  if(isDefined(level.rts.customvoxlist))
    return [
      [level.rts.customvoxlist]
    ](team, dparam);

  guys = [];

  for(i = 0; i <= 5; i++) {
    voxid = "so" + i;

    if(isDefined(level.rts.voxids["allies"][voxid]))
      guys[guys.size] = level.rts.voxids["allies"][voxid];
  }

  return guys;
}