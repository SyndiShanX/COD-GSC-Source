/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\_busing.csc
**************************************/

#include clientscripts\_utility;

businit() {
  level.activebusstate = "";
  level.nextbusstate = "";
  level.busstates = [];
  registerdefaults();
  thread updatebus(1);
  thread bussavewait();
  clientscripts\_utility::registersystem("busCmd", ::buscmdhandler);
}

bussavewait() {
  for(;;) {
    level waittill("save_restore");

    if(level.nextbusstate == "")
      level.nextbusstate = level.activebusstate;

    level.activebusstate = "";

    if(level.nextbusstate == "") {
      busstatedeactivate();
      busstateactivate("slow_on");
    }

    println("resetting bus state to " + level.nextbusstate);

    thread updatebus(0);
  }
}

buscmdhandler(clientnum, state, oldstate) {
  if(clientnum != 0) {
    return;
  }
  level.nextbusstate = state;

  println("bussing debug: got state '" + state + "'");

  level notify("new_bus");
}

setbusstate(state) {
  level.nextbusstate = state;

  println("bussing debug: set state '" + state + "'");

  level notify("new_bus");
}

updatebus(forcefade) {
  level endon("save_restore");

  if(forcefade) {
    busstatedeactivate();
    busstateactivate("immediate_off");
    wait 1.0;
    busstatedeactivate();
    busstateactivate("slow_on");
  }

  while(true) {
    if(level.activebusstate == level.nextbusstate)
      level waittill("new_bus");

    println("got bus change current'" + level.activebusstate + "' next '" + level.nextbusstate + "'");

    if(level.activebusstate == level.nextbusstate) {
      continue;
    }
    assert(isDefined(level.nextbusstate));
    assert(isDefined(level.activebusstate));
    busstatedeactivate();
    next = level.nextbusstate;

    if(next != "")
      busstateactivate(next);

    level.activebusstate = next;
  }
}

busstateactivate(name) {
  println("activating bus '" + name + "'");

  state = level.busstates[name];

  if(!isDefined(state)) {
    println("invalid bus state '" + name + "'");

    return;
  }

  assert(isDefined(state.time));
  keys = getarraykeys(state.levels);
  assert(isDefined(keys));
}

busstatedeactivate() {
  println("deactivating bus ");
}

declarebusstate(name) {
  if(!isDefined(level.busstates)) {
    return;
  }
  level.busdeclarename = name;

  if(isDefined(level.busstates[name])) {
    return;
  }
  level.busstates[name] = spawnstruct();
  level.busstates[name].time = 0.5;
  level.busstates[name].levels = [];
}

busvolume(busname, value) {
  level.busstates[level.busdeclarename].levels[busname] = value;
}

busfadetime(time) {
  level.busstates[level.busdeclarename].time = time;
}

busisin(bus, names) {
  for(j = 0; j < names.size; j++) {
    if(bus == names[j])
      return true;
  }

  return false;
}

busvolumes(names, value) {
  for(j = 0; j < names.size; j++)
    busvolume(names[j], value);
}

busvolumeall(value) {
}

argsasdict(a, b, c, d, e, f, g, h, i) {
  names = [];

  if(isDefined(a))
    names[0] = a;

  if(isDefined(b))
    names[1] = b;

  if(isDefined(c))
    names[2] = c;

  if(isDefined(d))
    names[3] = d;

  if(isDefined(e))
    names[4] = e;

  if(isDefined(f))
    names[5] = f;

  if(isDefined(g))
    names[6] = g;

  if(isDefined(h))
    names[7] = h;

  if(isDefined(i))
    names[8] = i;

  return names;
}

busvolumesexcept(a, b, c, d, e, f, g, h, i) {
  args = argsasdict(a, b, c, d, e, f, g, h, i);
  value = args[args.size - 1];
  names = [];

  for(i = 0; i < args.size - 1; i++)
    names[i] = args[i];
}

registerdefaults() {
  declarebusstate("map_load");
  busfadetime(0.25);
  busvolumesexcept("music", "ui", 0);
  declarebusstate("map_start");
  busfadetime(1);
  busvolumeall(1);
  declarebusstate("default");
  busfadetime(0.25);
  busvolumeall(1);
  declarebusstate("all_off");
  busvolumeall(0);
  declarebusstate("map_end");
  busfadetime(2);
  busvolumesexcept("music", "ui", 0);
  declarebusstate("last_stand_start");
  busfadetime(0.1);
  busvolumesexcept("full_vol", "ui", 0.6);
  declarebusstate("last_stand_duration");
  busfadetime(29.9);
  busvolumesexcept("full_vol", "ui", 0.05);
  declarebusstate("immediate_off");
  busfadetime(0.01);
  busvolumesexcept("ui", 0.0);
  declarebusstate("slow_on");
  busvolumesexcept("ui", 1.0);
  busfadetime(1);
  declarebusstate("zombie_death");
  busvolumesexcept("music", 0.0);
  busfadetime(10);
}