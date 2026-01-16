/****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\mp\_busing.csc
****************************************/

#include clientscripts\mp\_utility;

businit() {
  level.activebusstate = "";
  level.nextbusstate = "";
  level.busstates = [];
  registerdefaults();
  thread updatebus();
  clientscripts\mp\_utility::registersystem("busCmd", ::buscmdhandler);
}

buscmdhandler(clientnum, state, oldstate) {
  if(clientnum != 0) {
    return;
  }
  level.nextbusstate = state;

  println("bussing debug: got state '" + state + "'");

  level notify("new_bus");
}

updatebus() {
  while(true) {
    if(level.activebusstate == level.nextbusstate)
      level waittill("new_bus");

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

argsasdict(a, b, c, d, e, f, g) {
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

  return names;
}

busvolumesexcept(a, b, c, d, e, f, g) {
  args = argsasdict(a, b, c, d, e, f, g);
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
  busfadetime(2);
  busvolumeall(1);
  declarebusstate("default");
  busfadetime(0.25);
  busvolumeall(1);
  declarebusstate("all_off");
  busvolumeall(0);
  declarebusstate("map_end");
  busfadetime(2);
  busvolumesexcept("music", "ui", "voice", 0);
}