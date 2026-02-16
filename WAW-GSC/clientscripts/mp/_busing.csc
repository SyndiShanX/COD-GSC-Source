/****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\mp\_busing.csc
****************************************/

busInit() {
  level.activeBusState = "";
  level.nextBusState = "";
  level.busStates = [];

  registerDefaults();

  thread updateBus();

  clientscripts\mp\_utility::registerSystem("busCmd", ::busCmdHandler);
}

busCmdHandler(clientNum, state, oldState) {
  if(clientNum != 0) {
    return;
  }

  level.nextBusState = state;

  println("bussing debug: got state '" + state + "'");

  level notify("new_bus");
}

updateBus() {
  while(1) {
    if(level.activeBusState == level.nextBusState) {
      level waittill("new_bus");
    }

    if(level.activeBusState == level.nextBusState) {
      continue;
    }
    assert(isDefined(level.nextBusState));
    assert(isDefined(level.activeBusState));

    busStateDeactivate();

    next = level.nextBusState;

    if(next != "") {
      busStateActivate(next);
    }

    level.activeBusState = next;
  }
}

busStateActivate(name) {
  state = level.busStates[name];

  if(!isDefined(state)) {
    println("invalid bus state '" + name + "'");
    return;
  }

  assert(isDefined(state.time));

  setBusFadeTime(state.time);

  keys = getArrayKeys(state.levels);

  assert(isDefined(keys));

  for(i = 0; i < keys.size; i++) {
    setBusVolume(keys[i], state.levels[keys[i]]);
  }
}

busStateDeactivate() {
  setBusFadeTime(.5);

  for(i = 0; i < GetBusCount(); i++) {
    setBusVolume(GetBusName(i), 1.0);
  }
}

declareBusState(name) {
  if(!isDefined(level.busStates)) {
    return;
  }

  level.busDeclareName = name;

  if(isDefined(level.busStates[name])) {
    return;
  }

  level.busStates[name] = spawnStruct();
  level.busStates[name].time = 0.5;
  level.busStates[name].levels = [];
}

busVolume(busname, value) {
  level.busStates[level.busDeclareName].levels[busname] = value;
}

busFadeTime(time) {
  level.busStates[level.busDeclareName].time = time;
}

busIsIn(bus, names) {
  for(j = 0; j < names.size; j++) {
    if(bus == names[j]) {
      return true;
    }
  }
  return false;
}

busVolumes(names, value) {
  for(j = 0; j < names.size; j++) {
    busVolume(names[j], value);
  }
}

busVolumeAll(value) {
  for(i = 0; i < GetBusCount(); i++) {
    busVolume(GetBusName(i), value);
  }
}

argsAsDict(a, b, c, d, e, f, g) {
  names = [];

  if(isDefined(a)) {
    names[0] = a;
  }
  if(isDefined(b)) {
    names[1] = b;
  }
  if(isDefined(c)) {
    names[2] = c;
  }
  if(isDefined(d)) {
    names[3] = d;
  }
  if(isDefined(e)) {
    names[4] = e;
  }
  if(isDefined(f)) {
    names[5] = f;
  }
  if(isDefined(g)) {
    names[6] = g;
  }
  return names;
}

busVolumesExcept(a, b, c, d, e, f, g) {
  args = argsAsDict(a, b, c, d, e, f, g);

  value = args[args.size - 1];
  names = [];

  for(i = 0; i < args.size - 1; i++) {
    names[i] = args[i];
  }

  for(i = 0; i < GetBusCount(); i++) {
    name = GetBusName(i);
    if(!busIsIn(GetBusName(i), names)) {
      busVolume(name, value);
    }
  }

}

registerDefaults() {
  declareBusState("map_load");
  busFadeTime(.25);
  busVolumesExcept("music", "ui", 0);

  declareBusState("map_start");
  busFadeTime(2);
  busVolumeAll(1);

  declareBusState("default");
  busFadeTime(.25);
  busVolumeAll(1);

  declareBusState("all_off");
  busVolumeAll(0);

  declareBusState("map_end");
  busFadeTime(2);
  busVolumesExcept("music", "ui", "voice", 0);
}