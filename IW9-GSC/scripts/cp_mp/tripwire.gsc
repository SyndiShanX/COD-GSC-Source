/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\tripwire.gsc
***********************************************/

init() {
  tripwiremodelprecache();
  spawntripwirelevelstruct();
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("trap_device", ::_id_6CAE226462403BCC);

  if(!isDefined(level._id_CBE618F35B332990))
    level._id_CBE618F35B332990 = spawn("script_origin", (0, 0, 0));

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("tripwire", "init"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("tripwire", "init")]]();

  level._id_E9A6FC11B0AA7EB2 = ::_id_186D7AC95077704B;
  level._id_D9D80893720B39DF = ::_id_56FD20503D89EED8;
  level._id_F1BFF73A86C35C52 = ::_id_391D956C772FB03F;
  setdvarifuninitialized("debug_tripwire", 0);
  _id_7992E35C1ABECADD = scripts\engine\utility::getStructArray("tripwire_start", "script_noteworthy");

  foreach(startstruct in _id_7992E35C1ABECADD) {
    if(!isDefined(startstruct.target)) {}

    if(isDefined(startstruct._id_C9F2956DD819DE38)) {
      continue;
    }
    startstruct._id_C9F2956DD819DE38 = 1;
    _id_0036743E75FE4A30 = scripts\engine\utility::getStructArray(startstruct.target, "targetname");

    if(_id_0036743E75FE4A30.size < 1) {}

    foreach(_id_D0697AF2ECA83D63 in _id_0036743E75FE4A30)
    buildtripwire(startstruct, _id_D0697AF2ECA83D63);
  }
}

tripwiremodelprecache() {
  precachemodel("equipment_wm_tripwire_standard_cp");
  precachemodel("equipment_wm_tripwire_standard_cp");
  precachemodel("equipment_wm_tripwire_standard_cp");
  precachemodel("equipment_wm_tripwire_wall_after");
  precachemodel("equipment_wm_tripwire_wall_after_01");
  precachemodel("equipment_wm_tripwire_wall_after_02");
  precachemodel("equipment_wm_tripwire_wall_after_03");
  precachemodel("equipment_wm_tripwire_wall_after_04");
  precachemodel("equipment_wm_tripwire_ceiling_after");
  precachemodel("equipment_wm_tripwire_floor_after");
  precachemodel("offhand_2h_wm_grenade_frag_v0");
  precachemodel("offhand_2h_wm_grenade_semtex_v0");
  precachemodel("offhand_2h_wm_c4_v0");
}

spawntripwirelevelstruct() {
  if(!isDefined(level.tripwires)) {
    level.tripwires = spawnStruct();
    level.tripwires.traptypes = [];
    level.tripwires.tripwires = [];
    level.tripwires.traps = [];
  }
}

precache(type, model) {}

precachetrap(type, model, candisarm) {
  if(!isDefined(level.tripwires))
    spawntripwirelevelstruct();

  if(!isDefined(level.tripwires.traptypes[type])) {
    level.tripwires.traptypes[type] = spawnStruct();
    level.tripwires.traptypes[type].model = model;
    level.tripwires.traptypes[type].triggerfunc = gettriggerfunc(type);
    level.tripwires.traptypes[type].candisarm = candisarm;

    if(candisarm)
      level.tripwires.traptypes[type].disarmfunc = getdisarmfunc(type);
  }

  precachemodel(model);
}

buildtripwire(startstruct, _id_D0697AF2ECA83D63, _id_AA6923872CF5D7BB) {
  if(!isDefined(_id_D0697AF2ECA83D63.script_animname))
    _id_D0697AF2ECA83D63.script_animname = "wall";

  _id_801C53C0ED06495B = spawntripwire(startstruct, _id_D0697AF2ECA83D63);
  _id_801C53C0ED06495B inittripwireanims(_id_D0697AF2ECA83D63.script_animname);
  _id_801C53C0ED06495B inittripwirestaticmodel(_id_D0697AF2ECA83D63.script_animname);
  _id_801C53C0ED06495B thread tripwirethink();
  _id_801C53C0ED06495B thread triggertripwirefuncthink(::triggerfunctripwire);

  if(isDefined(_id_AA6923872CF5D7BB))
    _id_801C53C0ED06495B.targets = scripts\engine\utility::array_add(_id_801C53C0ED06495B.targets, _id_AA6923872CF5D7BB);

  _id_801C53C0ED06495B processtripwiretarget(_id_D0697AF2ECA83D63);
  level.tripwires.tripwires = scripts\engine\utility::array_add(level.tripwires.tripwires, _id_801C53C0ED06495B);
  return _id_801C53C0ED06495B;
}

processtripwiretarget(_id_D0697AF2ECA83D63) {
  msg = "script_struct_tripwire_end at location " + _id_D0697AF2ECA83D63.origin + " has no target.Target the ent you want the tripwire to trigger, or another script_struct_tripwire_end to continue the tripwire chain";

  if(!isDefined(_id_D0697AF2ECA83D63.target)) {
    return;
  }
  _id_46A0BF001612E712 = scripts\engine\utility::getStructArray(_id_D0697AF2ECA83D63.target, "targetname");
  _id_FD5EF62C4BDE358E = getEntArray(_id_D0697AF2ECA83D63.target, "targetname");
  targets = scripts\engine\utility::array_combine(_id_46A0BF001612E712, _id_FD5EF62C4BDE358E);

  if(targets.size == 0) {}

  if(_id_D0697AF2ECA83D63 shouldfindnavmodifier())
    self.navmodifier = _func_ C5C9A79BF64E5CB(_id_D0697AF2ECA83D63.target, "targetname");

  foreach(target in targets) {
    if(target istripwirestruct())
      target = buildtripwire(_id_D0697AF2ECA83D63, target, self);
    else if(target istripwiretrapstruct())
      target = buildtripwiretrap(target, self);

    self.targets = scripts\engine\utility::array_add(self.targets, target);
  }
}

shouldfindnavmodifier() {
  if(isDefined(self.spawnflags) && self.spawnflags & 1)
    return 1;
  else
    return 0;
}

istripwirestruct() {
  if(isstruct(self) && isDefined(self.script_noteworthy) && self.script_noteworthy == "tripwire_end")
    return 1;
  else
    return 0;
}

istripwiretrapstruct() {
  if(isstruct(self) && isDefined(self.script_noteworthy) && issubstr(self.script_noteworthy, "tripwire_trap_"))
    return 1;
  else
    return 0;
}

hastripwirechild() {
  foreach(target in self.targets) {
    if(isDefined(target.istripwire) && target.istripwire && !isDefined(target.triggered))
      return 1;
  }

  return 0;
}

#using_animtree("script_model");

spawntripwire(startstruct, _id_D0697AF2ECA83D63) {
  _id_06A3A1033FFC2699 = startstruct.origin - _id_D0697AF2ECA83D63.origin;
  _id_801C53C0ED06495B = spawn("script_model", _id_D0697AF2ECA83D63.origin);
  _id_801C53C0ED06495B.angles = vectortoangles(_id_06A3A1033FFC2699);
  _id_801C53C0ED06495B setModel(gettripwiremodel(_id_D0697AF2ECA83D63.script_animname));
  _id_801C53C0ED06495B useanimtree(#animtree);

  if(isDefined(_id_D0697AF2ECA83D63.angles)) {
    f = anglesToForward(_id_D0697AF2ECA83D63.angles);
    r = anglestoright(_id_801C53C0ED06495B.angles);
    _id_AC0E454AC96A77AC = anglestoup(_id_801C53C0ED06495B.angles);
    _id_801C53C0ED06495B.finalangles = axistoangles(f, r, _id_AC0E454AC96A77AC);
  }

  _id_801C53C0ED06495B.targets = [];
  _id_801C53C0ED06495B.endpoint = startstruct.origin;
  _id_801C53C0ED06495B.length = length(_id_06A3A1033FFC2699);
  _id_D5B2A103934621F3 = 30;
  _id_C0EE4D060004600B = _id_801C53C0ED06495B.origin + anglesToForward(_id_801C53C0ED06495B.angles) * (0.5 * _id_801C53C0ED06495B.length);
  _id_801C53C0ED06495B.trigger = spawn("trigger_rotatable_radius", _id_801C53C0ED06495B.origin, 0, _id_D5B2A103934621F3, _id_801C53C0ED06495B.length + 10);
  _id_B1A278451F610D5A = -1 * anglestoup(_id_801C53C0ED06495B.angles);
  _id_B1A264451F60E15E = anglestoright(_id_801C53C0ED06495B.angles);
  _id_B1A267451F60E7F7 = anglesToForward(_id_801C53C0ED06495B.angles);
  _id_801C53C0ED06495B.trigger.angles = axistoangles(_id_B1A278451F610D5A, _id_B1A264451F60E15E, _id_B1A267451F60E7F7);
  _id_801C53C0ED06495B.istripwire = 1;
  _id_801C53C0ED06495B.triggered = 0;

  if(isDefined(startstruct.script_delay))
    _id_801C53C0ED06495B.delay = startstruct.script_delay;
  else
    _id_801C53C0ED06495B.delay = scripts\engine\math::factor_value(0.1, 0.35, _id_801C53C0ED06495B getnormtripwirelength());

  return _id_801C53C0ED06495B;
}

inittripwireanims(animname) {
  if(!isDefined(animname)) {}

  self.triggeranim = gettripwiretriggeranim(animname);
  self.stretchanim = gettripwirestretchanim(animname);
  self setanim(self.triggeranim, 1, 0, 0);
  self setanim(self.stretchanim, 1, 0, 0);

  if(self.length < 10 || self.length > 300) {}

  if(getdvarint("dvar_492741FF5B4AFD4A", 0))
    thread _id_3AEBDDC8D6A5A470(getnormtripwirelength());
  else
    self setanimtime(self.stretchanim, getnormtripwirelength());
}

inittripwirestaticmodel(animname) {
  if(!isDefined(animname)) {}

  self.staticmodel = gettripwirestaticmodel(animname);
}

gettripwiretriggersound(_id_D70A4921808926E2) {
  if(_id_D70A4921808926E2)
    return "tripwire_pop_first";
  else if(hastripwirechild())
    return "tripwire_pop";
  else
    return "tripwire_pop_last";
}

tripwirethink() {
  self endon("tripwire_trigger");
  self endon("death");
  self.trigger endon("death");

  for(;;) {
    self.trigger waittill("trigger", _id_FA8D840338038893);
    _id_D447527401B9B4A9 = 1;
    _id_D70A4921808926E2 = 1;

    if(tripwireshouldtrigger(_id_FA8D840338038893))
      self notify("trigger", _id_FA8D840338038893, _id_D447527401B9B4A9, _id_D70A4921808926E2);
  }
}

tripwireshouldtrigger(_id_FA8D840338038893) {
  if(!isDefined(self) || !isDefined(self.origin) || !isDefined(self.endpoint))
    return 0;

  if(!isDefined(_id_FA8D840338038893) || _id_FA8D840338038893 isragdoll())
    return 0;

  if(!isalive(_id_FA8D840338038893))
    return 0;

  _id_C3FBB6661B91750F = scripts\engine\trace::create_contents(1, 0, 0, 0, 1, 1, 0, 0, 1);
  trace = scripts\engine\trace::ray_trace_ents(self.origin, self.endpoint, _id_FA8D840338038893, _id_C3FBB6661B91750F);

  if(!isDefined(trace["fraction"]))
    return 0;

  if(trace["fraction"] < 1)
    return 1;
  else
    return 0;
}

buildtripwiretrap(struct, _id_AA6923872CF5D7BB) {
  if(!isDefined(struct.trap)) {
    if(!isDefined(struct.angles))
      angles = (0, 0, 0);
    else
      angles = struct.angles;

    struct.trap = spawn("script_model", struct.origin);
    struct.trap.angles = angles;
    struct.trap setModel(level.tripwires.traptypes[struct.script_noteworthy].model);
    struct.trap thread triggertrapfuncthink(level.tripwires.traptypes[struct.script_noteworthy].triggerfunc);
    struct.trap thread damagetrapfuncthink();
    struct.trap.candisarm = level.tripwires.traptypes[struct.script_noteworthy].candisarm;
    struct.trap.istrap = 1;

    if(isDefined(level.tripwires.traptypes[struct.script_noteworthy].disarmfunc))
      struct.trap thread disarmfuncthink(level.tripwires.traptypes[struct.script_noteworthy].disarmfunc, struct);

    if(isDefined(struct.script_parameters)) {
      _id_AF462E92BEAC4F4E = strtok(struct.script_parameters, " ");
      struct.trap.grenadeweaponoverride = _id_AF462E92BEAC4F4E[0];
    }

    struct.trap.parenttripwires = [];
    level.tripwires.traps = scripts\engine\utility::array_add(level.tripwires.traps, struct.trap);
  }

  struct.trap.parenttripwires = scripts\engine\utility::array_add(struct.trap.parenttripwires, _id_AA6923872CF5D7BB);
  return struct.trap;
}

_id_3AEBDDC8D6A5A470(_id_CDCAC684A1DBC685) {
  _id_B93FBB948FDA0F7C = 0.2;
  _id_95206942F9C28AA5 = 0.4;
  _id_F868A88235CAC998 = 0.6;
  _id_177CCDB7CE1114FD = 0.8;
  _id_87744FF4B9F7472E = [];
  _id_87744FF4B9F7472E[_id_87744FF4B9F7472E.size] = _id_8F1B1EF7B8A59EB7();

  if(_id_CDCAC684A1DBC685 > _id_B93FBB948FDA0F7C)
    _id_87744FF4B9F7472E[_id_87744FF4B9F7472E.size] = _id_8F1B1EF7B8A59EB7();

  if(_id_CDCAC684A1DBC685 > _id_95206942F9C28AA5)
    _id_87744FF4B9F7472E[_id_87744FF4B9F7472E.size] = _id_8F1B1EF7B8A59EB7();

  if(_id_CDCAC684A1DBC685 > _id_F868A88235CAC998)
    _id_87744FF4B9F7472E[_id_87744FF4B9F7472E.size] = _id_8F1B1EF7B8A59EB7();

  self hide();
  _id_B1DBA2EE7FFD4131 = _id_CDCAC684A1DBC685 * 2.23;
  waittime = scripts\engine\math::factor_value(1, 300, _id_B1DBA2EE7FFD4131);
  waittime = waittime * 0.05;
  _id_75A5138B4FEAC645 = "tripwireStretchAnimTime";
  _id_6B86DC130A1FA946 = anglesToForward(self.angles);
  _id_63A301303B3B2934 = anglestoup(self.angles);
  _id_C8292D490A70D031 = vectorcross(_id_6B86DC130A1FA946, _id_63A301303B3B2934);
  _id_3C86AD8A86338503 = self.origin + _id_C8292D490A70D031 * 100 - self.origin;
  _id_D1389D74DFDCE48E = self.origin + _id_63A301303B3B2934 * 100 - self.origin;
  _id_9601C225B7890378 = vectorNormalize(_id_D1389D74DFDCE48E);
  _id_9601C525B7890A11 = vectorNormalize((0, 0, 1));
  _id_C5F68CDF7B9421D9 = scripts\engine\math::anglebetweenvectors(_id_9601C225B7890378, _id_9601C525B7890A11);
  _id_C5F68CDF7B9421D9 = scripts\engine\math::anglebetweenvectorssigned(_id_9601C225B7890378, _id_9601C525B7890A11, vectorNormalize(_id_3C86AD8A86338503));
  _id_64D53BB94497F357 = _id_3C86AD8A86338503[0] + 90 > 0;

  foreach(part in _id_87744FF4B9F7472E)
  part scriptmodelplayanim(%tripwire_trigger_standard_stretch, _id_75A5138B4FEAC645, 0, 0.01);

  _id_83ECC93F05088653(waittime);

  foreach(part in _id_87744FF4B9F7472E) {
    part scriptmodelpauseanim(1);
    part rotateTo(vectortoangles(_id_C8292D490A70D031), 0.1, 0.05, 0.05);
  }

  _id_83ECC93F05088653(0.15);

  foreach(part in _id_87744FF4B9F7472E)
  part rotateroll(_id_C5F68CDF7B9421D9 * -1, 3, 1, 1);

  scripts\engine\utility::waittill_any_2("tripwire_trigger", "tripwire_defused");

  foreach(part in _id_87744FF4B9F7472E)
  part delete();

  self show();
}

_id_8F1B1EF7B8A59EB7() {
  _id_B107426CA7117029 = spawn("script_model", self.origin);
  _id_B107426CA7117029.angles = self.angles;
  _id_B107426CA7117029 setModel(self.model);
  return _id_B107426CA7117029;
}

getnormtripwirelength() {
  return scripts\engine\math::normalize_value(10, 300, self.length);
}

_id_83ECC93F05088653(_id_246AEE6688CC8EAE) {
  level endon("game_ended");
  _id_48974A7856F3CBAA = 0;

  while(_id_48974A7856F3CBAA < _id_246AEE6688CC8EAE) {
    _id_48974A7856F3CBAA = _id_48974A7856F3CBAA + level.framedurationseconds;
    waitframe();
  }
}

tripwirehastraps() {
  foreach(target in self.targets) {
    if(isDefined(target.istrap) && !isDefined(target.triggered))
      return 1;
  }

  return 0;
}

triggertripwirefuncthink(triggerfunc) {
  for(;;) {
    self waittill("trigger", _id_FA8D840338038893, _id_4482194AC72A29C0, _id_D70A4921808926E2);

    if(_id_4482194AC72A29C0) {
      break;
    } else if(!tripwirehastraps()) {
      break;
    }
  }

  if(isDefined(_id_FA8D840338038893))
    _id_FA8D840338038893.lasttriptime = gettime();

  self notify("tripwire_trigger");
  self.triggered = 1;
  self[[triggerfunc]](_id_FA8D840338038893, _id_4482194AC72A29C0, _id_D70A4921808926E2);
}

triggertrapfuncthink(triggerfunc) {
  for(;;) {
    self waittill("trigger", _id_FA8D840338038893, _id_4482194AC72A29C0);

    if(_id_4482194AC72A29C0) {
      break;
    }
  }

  self notify("trap_trigger");
  self.triggered = 1;

  if(isDefined(self.defusehintstruct) && !isDefined(self.defusehintstruct.defused)) {
    if(isent(self.defusehintstruct)) {
      self.defusehintstruct makeunusable();
      self.defusehintstruct delete();
    }
  }

  self[[triggerfunc]](_id_FA8D840338038893);
  level notify("tripwire_detonated", self.origin);
}

gettriggerfunc(type) {
  switch (type) {
    case "tripwire_trap_c4":
      return::triggerfuncc4;
    case "tripwire_trap_semtex":
      return::triggerfuncsemtex;
    case "tripwire_trap_frag":
      return::triggerfuncfrag;
    default:
  }
}

gettripwiretriggeranim(animname) {
  switch (animname) {
    case "ceiling":
      return scripts\engine\utility::random([%tripwire_trigger_standard_ceiling]);
    case "floor":
      return scripts\engine\utility::random([%tripwire_trigger_standard_floor]);
    case "wall":
      if(shouldusewallsize1()) {
        return scripts\engine\utility::random([%tripwire_trigger_standard_wall_01]);
        return;
      }

      if(shouldusewallsize2()) {
        return scripts\engine\utility::random([%tripwire_trigger_standard_wall_02]);
        return;
      }

      if(shouldusewallsize3()) {
        return scripts\engine\utility::random([%tripwire_trigger_standard_wall_03]);
        return;
      }

      if(shouldusewallsize4()) {
        return scripts\engine\utility::random([%tripwire_trigger_standard_wall_04]);
        return;
      }

      return scripts\engine\utility::random([%tripwire_trigger_standard_wall]);
      return;
      return;
      return;
      return;
  }
}

gettripwirestaticmodel(animname) {
  switch (animname) {
    case "ceiling":
      return "equipment_wm_tripwire_ceiling_after";
    case "floor":
      return "equipment_wm_tripwire_floor_after";
    case "wall":
      if(shouldusewallsize1()) {
        return "equipment_wm_tripwire_wall_after_01";
        return;
      }

      if(shouldusewallsize2()) {
        return "equipment_wm_tripwire_wall_after_02";
        return;
      }

      if(shouldusewallsize3()) {
        return "equipment_wm_tripwire_wall_after_03";
        return;
      }

      if(shouldusewallsize4()) {
        return "equipment_wm_tripwire_wall_after_04";
        return;
      }

      return "equipment_wm_tripwire_wall_after";
      return;
      return;
      return;
      return;
  }
}

gettripwirestretchanim(animname) {
  switch (animname) {
    case "ceiling":
      return % tripwire_trigger_standard_stretch;
    case "floor":
      return % tripwire_trigger_standard_stretch;
    case "wall":
      return % tripwire_trigger_standard_stretch;
  }
}

gettripwiremodel(animname) {
  if(!isDefined(animname)) {}

  if(level.script == "cp_raid1_boss1")
    return "equipment_wm_tripwire_standard_raid1_boss1";

  switch (animname) {
    case "ceiling":
      return "equipment_wm_tripwire_standard_cp";
    case "floor":
      return "equipment_wm_tripwire_standard_cp";
    case "wall":
      return "equipment_wm_tripwire_standard_cp";
  }
}

shouldusewallsize1() {
  return self.length >= 51 && self.length < 69;
}

shouldusewallsize2() {
  return self.length >= 69 && self.length < 100;
}

shouldusewallsize3() {
  return self.length > 10 && self.length < 37;
}

shouldusewallsize4() {
  return self.length >= 37 && self.length < 51;
}

triggerfunctripwire(_id_FA8D840338038893, _id_D447527401B9B4A9, _id_D70A4921808926E2) {
  if(isDefined(self.trigger) && isent(self.trigger))
    self.trigger delete();

  self setanimrate(self.triggeranim, 1);
  self setanim(%tripwire_stretch_overlay, 0, 0.2, 1);
  thread swaptostaticmodel();
  self playSound("tripwire_pop");
  _id_FFBAD4B01F6FC4CE = gettripwiretriggersound(_id_D70A4921808926E2);

  if(isDefined(self.finalangles))
    thread rotatetofinalangles();

  if(isPlayer(_id_FA8D840338038893)) {
    _id_FA8D840338038893 playRumbleOnEntity("damage_light");
    earthquake(0.1, 0.2, _id_FA8D840338038893.origin, 2000);
  }

  wait(self.delay);

  if(isDefined(self.navmodifier))
    destroynavobstacle(self.navmodifier);

  _id_D70A4921808926E2 = 0;

  if(isDefined(self.targets)) {
    foreach(target in self.targets)
    target notify("trigger", _id_FA8D840338038893, _id_D447527401B9B4A9, _id_D70A4921808926E2);
  }
}

rotatetofinalangles() {
  self endon("death");
  wait 0.25;
  self rotateTo(self.finalangles, 0.25);
}

swaptostaticmodel() {
  self endon("death");
  _id_EB5B1F36E255152D = getanimlength(self.triggeranim);
  wait(_id_EB5B1F36E255152D);
  self setModel(self.staticmodel);
}

delete_trapfunc() {
  _id_109C02356EF49223 = 1;

  foreach(_id_AA6923872CF5D7BB in self.parenttripwires) {
    _id_AA6923872CF5D7BB thread triggerfunctripwire(undefined, 1, _id_109C02356EF49223);
    _id_109C02356EF49223 = 0;
  }
}

triggerfuncsemtex(_id_FA8D840338038893) {
  if(isDefined(self.grenadeweaponoverride))
    _id_195927E09B405481 = self.grenadeweaponoverride;
  else
    _id_195927E09B405481 = "semtex_tripwire";

  _id_9F6FB768C9C55D2D = magicgrenademanual(_id_195927E09B405481, self.origin, (0, 0, 0), 0.25);
  _id_9F6FB768C9C55D2D.angles = self.angles;
  _id_9F6FB768C9C55D2D.origin = self.origin;
  _id_9F6FB768C9C55D2D linkTo(self);
  self hide();
  _id_9F6FB768C9C55D2D waittill("explode");
  radiusdamage(self.origin, 384, 256, 40, undefined, "MOD_EXPLOSIVE", "semtex_mp");
  playrumbleonposition("grenade_rumble", self.origin);
  earthquake(0.45, 0.7, self.origin, 800);
  wait 0.1;
  self notify("cancel_death_hint");
  self delete();
}

triggerfuncfrag(_id_FA8D840338038893) {
  if(isDefined(self.grenadeweaponoverride))
    _id_195927E09B405481 = self.grenadeweaponoverride;
  else
    _id_195927E09B405481 = "frag_tripwire";

  frag = magicgrenademanual(_id_195927E09B405481, self.origin, (0, 0, 0), 0.25);
  frag.angles = self.angles;
  frag.origin = self.origin;
  frag linkTo(self);
  self hide();
  frag waittill("explode");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("tripwire", "damageFunc")) {
    _id_EE6983A991436671 = scripts\cp_mp\utility\script_utility::getsharedfunc("tripwire", "damageFunc");
    level thread[[_id_EE6983A991436671]](self, _id_FA8D840338038893);
  } else {
    radiusdamage(self.origin, 384, 256, 40, undefined, "MOD_EXPLOSIVE", "frag_grenade_mp");
    playrumbleonposition("grenade_rumble", self.origin);
    earthquake(0.45, 0.7, self.origin, 800);
  }

  wait 0.1;
  self notify("cancel_death_hint");
  self delete();
}

triggerfuncc4(_id_FA8D840338038893) {
  if(isDefined(self.grenadeweaponoverride))
    _id_195927E09B405481 = self.grenadeweaponoverride;
  else
    _id_195927E09B405481 = "c4_mp";

  c4 = magicgrenademanual(_id_195927E09B405481, self.origin, (0, 0, 0), 0.25);
  c4.angles = self.angles;
  c4.origin = self.origin;
  c4 linkTo(self);
  self hide();
  c4 setscriptablepartstate("effects", "explode", 0);
  c4 notify("detonateExplosive");
  radiusdamage(self.origin, 384, 256, 40, undefined, "MOD_EXPLOSIVE", "c4_mp");
  self playSound("iw9_frag_grenade_expl_trans");

  if(istrue(level._id_D744DAB15887349D)) {
    if(isDefined(_id_FA8D840338038893) && isPlayer(_id_FA8D840338038893)) {
      _id_FA8D840338038893.shouldskipdeathsshield = 1;
      _id_FA8D840338038893 dodamage(self.health + 100, self.origin, _id_FA8D840338038893, _id_FA8D840338038893, "MOD_SUICIDE", "c4_mp");
    }
  }

  playrumbleonposition("grenade_rumble", self.origin);
  earthquake(0.45, 0.7, self.origin, 800);
  self delete();
}

damagetrapfuncthink(_id_1BA137D944D10B5A, struct) {
  self endon("trap_trigger");
  self setCanDamage(1);
  self.health = 99999;

  for(;;) {
    self waittill("damage", damage, attacker, direction_vec, point, type, modelname, tagname, partname, idflags, objweapon, origin, angles, normal, inflictor);

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("tripwire", "blowTripWire"))
      self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("tripwire", "blowTripWire")]](attacker, type);

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("tripwire", "canTripTrap")) {
      _id_EE6983A991436671 = scripts\cp_mp\utility\script_utility::getsharedfunc("tripwire", "canTripTrap");

      if(self[[_id_EE6983A991436671]](attacker, objweapon, type, damage, point)) {
        break;
      }
    } else if(cantriptrap(attacker, type, damage)) {
      break;
    }

    self.health = self.health + damage;
  }

  self.triggered = 1;

  if(isDefined(self.defusehintstruct) && !isDefined(self.defusehintstruct.defused)) {
    if(isent(self.defusehintstruct)) {
      self.defusehintstruct makeunusable();
      self.defusehintstruct delete();
    }
  }

  _id_D447527401B9B4A9 = 0;
  _id_D70A4921808926E2 = 1;
  self makeunusable();

  foreach(_id_AA6923872CF5D7BB in self.parenttripwires)
  _id_AA6923872CF5D7BB notify("trigger", attacker, _id_D447527401B9B4A9, _id_D70A4921808926E2);

  self notify("trigger", attacker, 1);
}

cantriptrap(attacker, type, damage) {
  if(!isDefined(attacker))
    return 0;

  if(isPlayer(attacker) && (type == "MOD_GRENADE_SPLASH" || type == "MOD_PROJECTILE_SPLASH") && damage > 150)
    return 1;

  return 0;
}

disarmfuncthink(disarmfunc, struct) {
  self endon("trap_trigger");

  if(isDefined(struct.radius))
    _id_7C46CA1BDCC9E980 = struct.radius;
  else
    _id_7C46CA1BDCC9E980 = 128;

  _id_10653A9B07EE3ECE = (0, 0, 0);
  self.defusehintstruct = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("tripwire", "createHintObject")) {
    _id_EE6983A991436671 = scripts\cp_mp\utility\script_utility::getsharedfunc("tripwire", "createHintObject");
    self.defusehintstruct = [[_id_EE6983A991436671]](struct.origin, undefined, undefined, undefined, undefined, "duration_medium", "hide", 128, 35, 84, 35);
  } else
    self.defusehintstruct = struct scripts\engine\utility::spawn_script_origin();

  self.deletefunc = ::delete_trapfunc;
  self.defusehintstruct waittill("trigger", _id_FA8D840338038893);
  level.lasttripwiredefusedtime = gettime();
  self.defusehintstruct.defused = 1;
  self.triggered = 1;
  _id_D447527401B9B4A9 = 0;
  _id_D70A4921808926E2 = 1;

  if(isent(self.defusehintstruct)) {
    self.defusehintstruct makeunusable();
    self.defusehintstruct delete();
  }

  foreach(_id_AA6923872CF5D7BB in self.parenttripwires)
  _id_AA6923872CF5D7BB notify("trigger", _id_FA8D840338038893, _id_D447527401B9B4A9, _id_D70A4921808926E2);

  self[[disarmfunc]](_id_FA8D840338038893);
}

getdisarmfunc(type) {
  switch (type) {
    case "tripwire_trap_semtex":
      return::disarmfuncsemtex;
    case "tripwire_trap_frag":
      return::disarmfuncfrag;
    default:
  }
}

disarmfuncsemtex(_id_FA8D840338038893) {
  _id_FA8D840338038893 disarmgiveweapon("semtex", "Semtex", self.origin, self.angles);
  self delete();
}

disarmfuncfrag(_id_FA8D840338038893) {
  _id_FA8D840338038893 disarmgiveweapon("frag", "M67 Frag", self.origin, self.angles);
  self delete();
}

disarmgiveweapon(weapon, _id_A1093166DE09E6B8, _id_49FDE142EA9EE7A4, _id_40559A644F5CC3E6) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("tripwire", "disarmGiveWeapon")) {
    _id_EE6983A991436671 = scripts\cp_mp\utility\script_utility::getsharedfunc("tripwire", "disarmGiveWeapon");
    thread[[_id_EE6983A991436671]](weapon, _id_A1093166DE09E6B8, self, _id_49FDE142EA9EE7A4, _id_40559A644F5CC3E6);
  }
}

_id_391D956C772FB03F() {
  precachetrap("tripwire_trap_frag", "offhand_2h_wm_grenade_frag_v0", 1);
  precachetrap("tripwire_trap_semtex", "offhand_2h_wm_grenade_semtex_v0", 1);
  precachetrap("tripwire_trap_c4", "offhand_2h_wm_c4_v0", 0);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("tripwire", "sort"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("tripwire", "sort")]]();
}

_id_0041E381609B6AB0(_id_FFCAA31C31962D79) {
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("trap_device", ::_id_6CAE226462403BCC);
  tripwires = getentitylessscriptablearray(_id_FFCAA31C31962D79, "classname");

  if(!isDefined(level._id_CBE618F35B332990))
    level._id_CBE618F35B332990 = spawn("script_origin", (0, 0, 0));

  foreach(_id_801C53C0ED06495B in tripwires) {
    _id_801C53C0ED06495B _id_E532C2521845CE4A();
    _id_801C53C0ED06495B thread _id_4D63A162B2FB4275();
  }

  level.tripwires.tripwires = scripts\engine\utility::array_combine(level.tripwires.tripwires, tripwires);
}

_id_186D7AC95077704B(_id_801C53C0ED06495B) {
  _id_801C53C0ED06495B _id_E532C2521845CE4A();
  _id_801C53C0ED06495B thread _id_4D63A162B2FB4275();
  _id_801C53C0ED06495B.enabled = 1;
  level.tripwires.tripwires[level.tripwires.tripwires.size] = _id_801C53C0ED06495B;
  return _id_801C53C0ED06495B;
}

_id_56FD20503D89EED8(_id_801C53C0ED06495B) {
  array = scripts\engine\utility::_id_53C4C53197386572(_id_801C53C0ED06495B.array, getentitylessscriptablearray(_id_801C53C0ED06495B.target, "targetname"));
  _id_801C53C0ED06495B.enabled = 0;

  foreach(item in array) {
    if(item getscriptablehaspart("trap_device")) {
      item setscriptablepartstate("trap_device", "off");
      continue;
    }

    if(item.classname == "scriptable_dmz_tripwire") {
      item setscriptablepartstate("wire", "off");
      continue;
    }

    item setscriptablepartstate("wall_pin", "invisible");
  }

  _id_801C53C0ED06495B setscriptablepartstate("wire", "off");
}

_id_E532C2521845CE4A() {
  _id_801C53C0ED06495B = self;
  _id_801C53C0ED06495B setscriptablepartstate("wire", "wire_taut");
  _id_801C53C0ED06495B.targets = [];
  _id_801C53C0ED06495B.length = 64;
  _id_801C53C0ED06495B.istripwire = 1;
  _id_801C53C0ED06495B.triggered = 0;
  _id_801C53C0ED06495B.delay = 0.35;
  _id_C2306C15EF050DFC = 0;
  array = scripts\engine\utility::_id_53C4C53197386572(_id_801C53C0ED06495B.array, getentitylessscriptablearray(_id_801C53C0ED06495B.target, "targetname"));
  _id_801C53C0ED06495B._id_FA02BB233FA52688 = undefined;
  scriptablename = undefined;

  foreach(item in array) {
    if(item getscriptablehaspart("trap_device")) {
      _id_801C53C0ED06495B._id_FA02BB233FA52688 = item;
      _id_801C53C0ED06495B._id_FA02BB233FA52688._id_801C53C0ED06495B = _id_801C53C0ED06495B;
      scriptablename = getsubstr(_id_801C53C0ED06495B._id_FA02BB233FA52688.classname, 11);
      continue;
    }

    if(item.classname == "scriptable_dmz_tripwire") {
      item setscriptablepartstate("wire", "wire_taut");
      _id_801C53C0ED06495B._id_1FE6421C9BCD4D80 = item;
      _id_C2306C15EF050DFC = 15;
      continue;
    }

    item setscriptablepartstate("wall_pin", "visible");
  }

  _id_801C53C0ED06495B._id_FA02BB233FA52688 setscriptablepartstate("trap_device", "active");
  _id_D5B2A103934621F3 = 5;
  _id_B1A278451F610D5A = -1 * anglestoup(_id_801C53C0ED06495B.angles);
  _id_B1A264451F60E15E = anglestoright(_id_801C53C0ED06495B.angles);
  _id_B1A267451F60E7F7 = anglesToForward(_id_801C53C0ED06495B.angles);
  _id_801C53C0ED06495B.trigger = spawn("trigger_rotatable_radius", _id_801C53C0ED06495B.origin - _id_C2306C15EF050DFC * _id_B1A267451F60E7F7, 0, _id_D5B2A103934621F3, _id_801C53C0ED06495B.length + _id_C2306C15EF050DFC);
  _id_801C53C0ED06495B.trigger.angles = axistoangles(_id_B1A278451F610D5A, _id_B1A264451F60E15E, _id_B1A267451F60E7F7);
  _id_8CCBFD19BC4BA967 = _id_801C53C0ED06495B.origin + _id_B1A267451F60E7F7 * 32;
  _id_801C53C0ED06495B.navobstacleid = createnavobstaclebybounds(_id_8CCBFD19BC4BA967, (40, 30, 64 + _id_C2306C15EF050DFC), _id_801C53C0ED06495B.angles);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("tripwire", "onTripwireCreate"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("tripwire", "onTripwireCreate")]](_id_801C53C0ED06495B);
}

_id_4D63A162B2FB4275() {
  _id_801C53C0ED06495B = self;
  _id_801C53C0ED06495B endon("tripwire_defused");
  _id_801C53C0ED06495B.trigger waittill("trigger", _id_2D9552508615D396);
  _id_FB4B4FA0CEE578BD(_id_2D9552508615D396, _id_801C53C0ED06495B);
}

_id_FB4B4FA0CEE578BD(_id_2D9552508615D396, _id_801C53C0ED06495B) {
  if(istrue(_id_801C53C0ED06495B.triggered)) {
    return;
  }
  _id_801C53C0ED06495B.triggered = 1;

  if(isDefined(_id_801C53C0ED06495B._id_1FE6421C9BCD4D80)) {
    _id_801C53C0ED06495B._id_1FE6421C9BCD4D80 setscriptablepartstate("wire", "wire_snap");
    _id_801C53C0ED06495B setscriptablepartstate("wire", "off");
  } else
    _id_801C53C0ED06495B setscriptablepartstate("wire", "wire_snap");

  _id_801C53C0ED06495B._id_FA02BB233FA52688 setscriptablepartstate("trap_device", "off");
  frag = magicgrenademanual("frag_tripwire", _id_801C53C0ED06495B._id_FA02BB233FA52688.origin, (0, 0, 0), 0.25);
  frag waittill("explode");
  level._id_CBE618F35B332990 radiusdamage(_id_801C53C0ED06495B._id_FA02BB233FA52688.origin, 384, 200, 40, level._id_CBE618F35B332990, "MOD_EXPLOSIVE", "frag_grenade_mp");
  playrumbleonposition("grenade_rumble", _id_801C53C0ED06495B._id_FA02BB233FA52688.origin);
  earthquake(0.45, 0.7, _id_801C53C0ED06495B._id_FA02BB233FA52688.origin, 800);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("tripwire", "onTripwireTriggered"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("tripwire", "onTripwireTriggered")]](_id_2D9552508615D396, _id_801C53C0ED06495B);

  wait 0.1;
  destroynavobstacle(_id_801C53C0ED06495B.navobstacleid);
  _id_801C53C0ED06495B.trigger delete();
}

_id_6CAE226462403BCC(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  if(part == "trap_device") {
    instance setscriptablepartstate("trap_device", "off");

    if(isDefined(instance._id_801C53C0ED06495B._id_1FE6421C9BCD4D80)) {
      instance._id_801C53C0ED06495B._id_1FE6421C9BCD4D80 setscriptablepartstate("wire", "wire_snap");
      instance._id_801C53C0ED06495B setscriptablepartstate("wire", "off");
    } else
      instance._id_801C53C0ED06495B setscriptablepartstate("wire", "wire_snap");

    instance._id_801C53C0ED06495B notify("tripwire_defused");

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("tripwire", "onTripwireDefused"))
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("tripwire", "onTripwireDefused")]](player, instance._id_801C53C0ED06495B);

    destroynavobstacle(instance._id_801C53C0ED06495B.navobstacleid);
    instance._id_801C53C0ED06495B.trigger delete();
    _id_259B17A170041609 = undefined;
    instance._id_801C53C0ED06495B.disabled = 1;

    switch (instance.classname) {
      case "scriptable_dmz_tripwire_frag":
        _id_259B17A170041609 = "brloot_offhand_frag";
        break;
      default:
        _id_259B17A170041609 = "brloot_offhand_frag";
        break;
    }

    _id_CB4FAD49263E20C4 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("tripwire", "createLootDropInfo")]](instance.origin, instance.angles, undefined, 0, 0, undefined, 1);
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("tripwire", "spawnPickup")]](_id_259B17A170041609, _id_CB4FAD49263E20C4, 1, 1);
  }
}