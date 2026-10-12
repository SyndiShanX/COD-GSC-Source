/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\tripwire.gsc
***********************************************/

#using scripts\common\utility;
#using scripts\cp_mp\utility\debug_utility;
#using scripts\engine\math;
#using scripts\engine\scriptable;
#using scripts\engine\trace;
#using scripts\engine\utility;
#namespace tripwire;

function init() {
  tripwiremodelprecache();
  spawntripwirelevelstruct();
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("trap_device", &function_6cae226462403bcc);

  if(!isDefined(level.var_cbe618f35b332990)) {
    level.var_cbe618f35b332990 = spawn("script_origin", (0, 0, 0));
  }

  if(scripts\engine\utility::issharedfuncdefined("tripwire", "init")) {
    [[scripts\engine\utility::getsharedfunc("tripwire", "init")]]();
  }

  level.var_e9a6fc11b0aa7eb2 = &tripwire_enable;
  level.var_d9d80893720b39df = &tripwire_disable;
  level.var_f1bff73a86c35c52 = &function_391d956c772fb03f;
  setdvarifuninitialized(@ "debug_tripwire", 0);
  var_7992e35c1abecadd = getStructArray("tripwire_start", "script_noteworthy");

  foreach(startstruct in var_7992e35c1abecadd) {
    if(!isDefined(startstruct.target)) {
      assertmsg("<dev string:x1c>" + startstruct.origin + "<dev string:x49>");
    }

    if(isDefined(startstruct.initted)) {
      continue;
    }

    startstruct.initted = 1;
    endstructs = getStructArray(startstruct.target, "targetname");

    if(endstructs.size < 1) {
      assertmsg("<dev string:x1c>" + startstruct.origin + "<dev string:xa4>");
    }

    foreach(endstruct in endstructs) {
      buildtripwire(startstruct, endstruct);
    }
  }
}

function tripwiremodelprecache() {
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

function spawntripwirelevelstruct() {
  if(!isDefined(level.tripwires)) {
    level.tripwires = spawnStruct();
    level.tripwires.traptypes = [];
    level.tripwires.tripwires = [];
    level.tripwires.traps = [];
  }
}

function precache(type, model) {}

function precachetrap(type, model, candisarm) {
  if(!isDefined(level.tripwires)) {
    spawntripwirelevelstruct();
  }

  if(!isDefined(level.tripwires.traptypes[type])) {
    level.tripwires.traptypes[type] = spawnStruct();
    level.tripwires.traptypes[type].model = model;
    level.tripwires.traptypes[type].triggerfunc = gettriggerfunc(type);
    level.tripwires.traptypes[type].candisarm = candisarm;

    if(candisarm) {
      level.tripwires.traptypes[type].disarmfunc = getdisarmfunc(type);
    }
  }

  precachemodel(model);
}

function buildtripwire(startstruct, endstruct, parenttripwire) {
  if(!isDefined(endstruct.script_animname)) {
    endstruct.script_animname = "wall";
  }

  tripwire = spawntripwire(startstruct, endstruct);
  tripwire inittripwireanims(endstruct.script_animname);
  tripwire inittripwirestaticmodel(endstruct.script_animname);
  tripwire thread tripwirethink();
  tripwire thread triggertripwirefuncthink(&triggerfunctripwire);

  if(isDefined(parenttripwire)) {
    tripwire.targets = array_add(tripwire.targets, parenttripwire);
  }

  tripwire processtripwiretarget(endstruct);
  level.tripwires.tripwires = array_add(level.tripwires.tripwires, tripwire);
  return tripwire;
}

function processtripwiretarget(endstruct) {
  msg = "script_struct_tripwire_end at location " + endstruct.origin + " has no target.Target the ent you want the tripwire to trigger, or another script_struct_tripwire_end to continue the tripwire chain";

  if(!isDefined(endstruct.target)) {
    return;
  }

  targetstructs = getStructArray(endstruct.target, "targetname");
  targetents = getEntArray(endstruct.target, "targetname");
  targets = array_combine(targetstructs, targetents);

  if(targets.size == 0) {
    assertmsg(msg);
  }

  if(endstruct shouldfindnavmodifier()) {
    self.navmodifier = createnavmodifier(endstruct.target, "targetname");
  }

  foreach(target in targets) {
    if(target istripwirestruct()) {
      target = buildtripwire(endstruct, target, self);
    } else if(target istripwiretrapstruct()) {
      target = buildtripwiretrap(target, self);
    }

    self.targets = array_add(self.targets, target);
  }
}

function shouldfindnavmodifier() {
  if(isDefined(self.spawnflags) && self.spawnflags & 1) {
    return 1;
  }

  return 0;
}

function istripwirestruct() {
  if(isstruct(self) && isDefined(self.script_noteworthy) && self.script_noteworthy == "tripwire_end") {
    return 1;
  }

  return 0;
}

function istripwiretrapstruct() {
  if(isstruct(self) && isDefined(self.script_noteworthy) && issubstr(self.script_noteworthy, "tripwire_trap_")) {
    return 1;
  }

  return 0;
}

function hastripwirechild() {
  foreach(target in self.targets) {
    if(isDefined(target.istripwire) && target.istripwire && !isDefined(target.triggered)) {
      return true;
    }
  }

  return false;
}

#using_animtree("script_model");

function spawntripwire(startstruct, endstruct) {
  vec = startstruct.origin - endstruct.origin;
  tripwire = spawn("script_model", endstruct.origin);
  tripwire.angles = vectortoangles(vec);
  tripwire setModel(gettripwiremodel(endstruct.script_animname));
  tripwire useanimtree(#animtree);

  if(isDefined(endstruct.angles)) {
    f = anglesToForward(endstruct.angles);
    r = anglestoright(tripwire.angles);
    u = anglestoup(tripwire.angles);
    tripwire.finalangles = axistoangles(f, r, u);
  }

  tripwire.targets = [];
  tripwire.endpoint = startstruct.origin;
  tripwire.length = length(vec);
  tripwiretriggerradius = 30;
  triggerorg = tripwire.origin + anglesToForward(tripwire.angles) * 0.5 * tripwire.length;
  tripwire.trigger = spawn("trigger_rotatable_radius", tripwire.origin, 0, tripwiretriggerradius, tripwire.length + 10);
  trigger_f = -1 * anglestoup(tripwire.angles);
  trigger_r = anglestoright(tripwire.angles);
  trigger_u = anglesToForward(tripwire.angles);
  tripwire.trigger.angles = axistoangles(trigger_f, trigger_r, trigger_u);
  tripwire.istripwire = 1;
  tripwire.triggered = 0;

  if(isDefined(startstruct.script_delay)) {
    tripwire.delay = startstruct.script_delay;
  } else {
    tripwire.delay = math::factor_value(0.1, 0.35, tripwire getnormtripwirelength());
  }

  if(getdvarint(@ "debug_tripwire", 0) != 0) {
    thread scripts\cp_mp\utility\debug_utility::drawline(tripwire.origin, triggerorg, 99999, (1, 0, 0));
  }

  return tripwire;
}

function inittripwireanims(animname) {
  if(!isDefined(animname)) {
    assertmsg("<dev string:x106>");
  }

  self.triggeranim = gettripwiretriggeranim(animname);
  self.stretchanim = gettripwirestretchanim(animname);
  self setanim(self.triggeranim, 1, 0, 0);
  self setanim(self.stretchanim, 1, 0, 0);

  if(self.length < 10 || self.length > 300) {
    assertmsg("<dev string:x176>" + self.origin + "<dev string:x18f>" + 10 + "<dev string:x1a4>" + 300 + "<dev string:x1ad>");
  }

  if(getdvarint(@ "hash_492741ff5b4afd4a", 0)) {
    thread function_3aebddc8d6a5a470(getnormtripwirelength());
    return;
  }

  self setanimtime(self.stretchanim, getnormtripwirelength());
}

function inittripwirestaticmodel(animname) {
  if(!isDefined(animname)) {
    assertmsg("<dev string:x106>");
  }

  self.staticmodel = gettripwirestaticmodel(animname);
}

function gettripwiretriggersound(firsttriggered) {
  if(firsttriggered) {
    return "tripwire_pop_first";
  }

  if(hastripwirechild()) {
    return "tripwire_pop";
  }

  return "tripwire_pop_last";
}

function tripwirethink() {
  self endon("tripwire_trigger");
  self endon("death");
  self.trigger endon("death");

  while(true) {
    self.trigger waittill("trigger", who);
    triggertraps = 1;
    firsttriggered = 1;

    if(tripwireshouldtrigger(who)) {
      self notify("trigger", who, triggertraps, firsttriggered);
    }
  }
}

function tripwireshouldtrigger(who) {
  if(!isDefined(self) || !isDefined(self.origin) || !isDefined(self.endpoint)) {
    return 0;
  }

  if(!isDefined(who) || who isragdoll()) {
    return 0;
  }

  if(!isalive(who)) {
    return 0;
  }

  contentsoverride = create_contents(1, 0, 0, 0, 1, 1, 0, 0, 1);
  trace = ray_trace_ents(self.origin, self.endpoint, who, contentsoverride);

  if(!isDefined(trace["fraction"])) {
    return 0;
  }

  if(trace["fraction"] < 1) {
    return 1;
  }

  return 0;
}

function buildtripwiretrap(struct, parenttripwire) {
  if(!isDefined(struct.trap)) {
    if(!isDefined(struct.angles)) {
      angles = (0, 0, 0);
    } else {
      angles = struct.angles;
    }

    struct.trap = spawn("script_model", struct.origin);
    struct.trap.angles = angles;
    struct.trap setModel(level.tripwires.traptypes[struct.script_noteworthy].model);
    struct.trap thread triggertrapfuncthink(level.tripwires.traptypes[struct.script_noteworthy].triggerfunc);
    struct.trap thread damagetrapfuncthink();
    struct.trap.candisarm = level.tripwires.traptypes[struct.script_noteworthy].candisarm;
    struct.trap.istrap = 1;

    if(isDefined(level.tripwires.traptypes[struct.script_noteworthy].disarmfunc)) {
      struct.trap thread disarmfuncthink(level.tripwires.traptypes[struct.script_noteworthy].disarmfunc, struct);
    }

    if(isDefined(struct.script_parameters)) {
      [struct.trap.grenadeweaponoverride] = strtok(struct.script_parameters, " ");
    }

    struct.trap.parenttripwires = [];
    level.tripwires.traps = array_add(level.tripwires.traps, struct.trap);
  }

  struct.trap.parenttripwires = array_add(struct.trap.parenttripwires, parenttripwire);
  return struct.trap;
}

function function_3aebddc8d6a5a470(length_factor) {
  var_b93fbb948fda0f7c = 0.2;
  var_95206942f9c28aa5 = 0.4;
  var_f868a88235cac998 = 0.6;
  var_177ccdb7ce1114fd = 0.8;
  tripwire_parts = [];
  tripwire_parts[tripwire_parts.size] = function_8f1b1ef7b8a59eb7();

  if(length_factor > var_b93fbb948fda0f7c) {
    tripwire_parts[tripwire_parts.size] = function_8f1b1ef7b8a59eb7();
  }

  if(length_factor > var_95206942f9c28aa5) {
    tripwire_parts[tripwire_parts.size] = function_8f1b1ef7b8a59eb7();
  }

  if(length_factor > var_f868a88235cac998) {
    tripwire_parts[tripwire_parts.size] = function_8f1b1ef7b8a59eb7();
  }

  self hide();
  stretchfactor = length_factor * 2.23;
  waittime = math::factor_value(1, 300, stretchfactor);
  waittime *= 0.05;
  animnotify = "tripwireStretchAnimTime";
  var_6b86dc130a1fa946 = anglesToForward(self.angles);
  var_63a301303b3b2934 = anglestoup(self.angles);
  tomatch = vectorcross(var_6b86dc130a1fa946, var_63a301303b3b2934);
  var_3c86ad8a86338503 = self.origin + tomatch * 100 - self.origin;
  var_d1389d74dfdce48e = self.origin + var_63a301303b3b2934 * 100 - self.origin;
  vec1 = vectorNormalize(var_d1389d74dfdce48e);
  vec2 = vectorNormalize((0, 0, 1));
  angbetween = math::anglebetweenvectors(vec1, vec2);
  angbetween = anglebetweenvectorssigned(vec1, vec2, vectorNormalize(var_3c86ad8a86338503));
  var_64d53bb94497f357 = var_3c86ad8a86338503[0] + 90 > 0;

  foreach(part in tripwire_parts) {
    part scriptmodelplayanim(%tripwire_trigger_standard_stretch, animnotify, 0, 0.01);
  }

  function_83ecc93f05088653(waittime);

  foreach(part in tripwire_parts) {
    part scriptmodelpauseanim(1);
    part rotateTo(vectortoangles(tomatch), 0.1, 0.05, 0.05);
  }

  function_83ecc93f05088653(0.15);

  foreach(part in tripwire_parts) {
    part rotateroll(angbetween * -1, 3, 1, 1);
  }

  waittill_any_2("tripwire_trigger", "tripwire_defused");

  foreach(part in tripwire_parts) {
    part delete();
  }

  self show();
}

function function_8f1b1ef7b8a59eb7() {
  tripwire_stretch = spawn("script_model", self.origin);
  tripwire_stretch.angles = self.angles;
  tripwire_stretch setModel(self.model);
  return tripwire_stretch;
}

function getnormtripwirelength() {
  return math::normalize_value(10, 300, self.length);
}

function function_83ecc93f05088653(durationseconds) {
  level endon("game_ended");
  durationprogress = 0;

  while(durationprogress < durationseconds) {
    durationprogress += level.framedurationseconds;
    waitframe();
  }
}

function tripwirehastraps() {
  foreach(target in self.targets) {
    if(isDefined(target.istrap) && !isDefined(target.triggered)) {
      return true;
    }
  }

  return false;
}

function triggertripwirefuncthink(triggerfunc) {
  while(true) {
    self waittill("trigger", who, triggertrap, firsttriggered);

    if(triggertrap) {
      break;
    }

    if(!tripwirehastraps()) {
      break;
    }
  }

  if(isDefined(who)) {
    who.lasttriptime = gettime();
  }

  self notify("tripwire_trigger");
  self.triggered = 1;
  self[[triggerfunc]](who, triggertrap, firsttriggered);
}

function triggertrapfuncthink(triggerfunc) {
  while(true) {
    self waittill("trigger", who, triggertrap);

    if(triggertrap) {
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

  self[[triggerfunc]](who);
  level notify("tripwire_detonated", self.origin);
}

function gettriggerfunc(type) {
  switch (type) {
    case #"hash_32670e2a61b99a3b":
      return &triggerfuncc4;
    case #"hash_4beeaacc1db7b8cc":
      return &triggerfuncsemtex;
    case #"hash_496a20490fb91698":
      return &triggerfuncfrag;
    default:
      assertmsg("<dev string:x1be>" + type + "<dev string:x1e5>");
      break;
  }
}

function gettripwiretriggeranim(animname) {
  switch (animname) {
    case #"hash_28b4e95012259360":
      return random([%tripwire_trigger_standard_ceiling]);
    case #"hash_3e7681464ca7b9fd":
      return random([%tripwire_trigger_standard_floor]);
    case #"hash_bdea657441323e75":
      if(shouldusewallsize1()) {
        return random([%tripwire_trigger_standard_wall_01]);
      } else if(shouldusewallsize2()) {
        return random([%tripwire_trigger_standard_wall_02]);
      } else if(shouldusewallsize3()) {
        return random([%tripwire_trigger_standard_wall_03]);
      } else if(shouldusewallsize4()) {
        return random([%tripwire_trigger_standard_wall_04]);
      } else {
        return random([%tripwire_trigger_standard_wall]);
      }

      break;
  }
}

function gettripwirestaticmodel(animname) {
  switch (animname) {
    case #"hash_28b4e95012259360":
      return "equipment_wm_tripwire_ceiling_after";
    case #"hash_3e7681464ca7b9fd":
      return "equipment_wm_tripwire_floor_after";
    case #"hash_bdea657441323e75":
      if(shouldusewallsize1()) {
        return "equipment_wm_tripwire_wall_after_01";
      } else if(shouldusewallsize2()) {
        return "equipment_wm_tripwire_wall_after_02";
      } else if(shouldusewallsize3()) {
        return "equipment_wm_tripwire_wall_after_03";
      } else if(shouldusewallsize4()) {
        return "equipment_wm_tripwire_wall_after_04";
      } else {
        return "equipment_wm_tripwire_wall_after";
      }

      break;
  }
}

function gettripwirestretchanim(animname) {
  switch (animname) {
    case #"hash_28b4e95012259360":
      return % tripwire_trigger_standard_stretch;
    case #"hash_3e7681464ca7b9fd":
      return % tripwire_trigger_standard_stretch;
    case #"hash_bdea657441323e75":
      return % tripwire_trigger_standard_stretch;
  }
}

function gettripwiremodel(animname) {
  if(!isDefined(animname)) {
    assertmsg("<dev string:x106>");
  }

  if(level.script == "cp_raid1_boss1") {
    return "equipment_wm_tripwire_standard_raid1_boss1";
  }

  switch (animname) {
    case #"hash_28b4e95012259360":
      return "equipment_wm_tripwire_standard_cp";
    case #"hash_3e7681464ca7b9fd":
      return "equipment_wm_tripwire_standard_cp";
    case #"hash_bdea657441323e75":
      return "equipment_wm_tripwire_standard_cp";
  }
}

function shouldusewallsize1() {
  return self.length >= 51 && self.length < 69;
}

function shouldusewallsize2() {
  return self.length >= 69 && self.length < 100;
}

function shouldusewallsize3() {
  return self.length > 10 && self.length < 37;
}

function shouldusewallsize4() {
  return self.length >= 37 && self.length < 51;
}

function triggerfunctripwire(who, triggertraps, firsttriggered) {
  if(isDefined(self.trigger) && isent(self.trigger)) {
    self.trigger delete();
  }

  self setanimrate(self.triggeranim, 1);
  self setanim(%tripwire_stretch_overlay, 0, 0.2, 1);
  thread swaptostaticmodel();
  self playSound("tripwire_pop");
  triggersound = gettripwiretriggersound(firsttriggered);

  if(isDefined(self.finalangles)) {
    thread rotatetofinalangles();
  }

  if(isPlayer(who)) {
    who playRumbleOnEntity("damage_light");
    earthquake(0.1, 0.2, who.origin, 2000);
  }

  wait self.delay;

  if(isDefined(self.navmodifier)) {
    destroynavobstacle(self.navmodifier);
  }

  firsttriggered = 0;

  if(isDefined(self.targets)) {
    foreach(target in self.targets) {
      target notify("trigger", who, triggertraps, firsttriggered);
    }
  }
}

function rotatetofinalangles() {
  self endon("death");
  wait 0.25;
  self rotateTo(self.finalangles, 0.25);
}

function swaptostaticmodel() {
  self endon("death");
  animtime = getanimlength(self.triggeranim);
  wait animtime;
  self setModel(self.staticmodel);
}

function delete_trapfunc() {
  firsttrigger = 1;

  foreach(parenttripwire in self.parenttripwires) {
    parenttripwire thread triggerfunctripwire(undefined, 1, firsttrigger);
    firsttrigger = 0;
  }
}

function triggerfuncsemtex(who) {
  if(isDefined(self.grenadeweaponoverride)) {
    grenadetype = self.grenadeweaponoverride;
  } else {
    grenadetype = "semtex_tripwire";
  }

  semtex = magicgrenademanual(grenadetype, self.origin, (0, 0, 0), 0.25);
  semtex.angles = self.angles;
  semtex.origin = self.origin;
  semtex linkTo(self);
  self hide();
  semtex waittill("explode");
  radiusdamage(self.origin, 384, 256, 40, undefined, "MOD_EXPLOSIVE", "semtex_mp");
  playrumbleonposition("grenade_rumble", self.origin);
  earthquake(0.45, 0.7, self.origin, 800);
  wait 0.1;
  self notify("cancel_death_hint");
  self delete();
}

function triggerfuncfrag(who) {
  if(isDefined(self.grenadeweaponoverride)) {
    grenadetype = self.grenadeweaponoverride;
  } else {
    grenadetype = "frag_tripwire";
  }

  frag = magicgrenademanual(grenadetype, self.origin, (0, 0, 0), 0.25);
  frag.angles = self.angles;
  frag.origin = self.origin;
  frag linkTo(self);
  self hide();
  frag waittill("explode");

  if(scripts\engine\utility::issharedfuncdefined("tripwire", "damageFunc")) {
    var_ee6983a991436671 = scripts\engine\utility::getsharedfunc("tripwire", "damageFunc");
    level thread[[var_ee6983a991436671]](self, who);
  } else {
    radiusdamage(self.origin, 384, 256, 40, undefined, "MOD_EXPLOSIVE", "frag_grenade_mp");
    playrumbleonposition("grenade_rumble", self.origin);
    earthquake(0.45, 0.7, self.origin, 800);
  }

  wait 0.1;
  self notify("cancel_death_hint");
  self delete();
}

function triggerfuncc4(who) {
  if(isDefined(self.grenadeweaponoverride)) {
    grenadetype = self.grenadeweaponoverride;
  } else {
    grenadetype = "c4_mp";
  }

  c4 = magicgrenademanual(grenadetype, self.origin, (0, 0, 0), 0.25);
  c4.angles = self.angles;
  c4.origin = self.origin;
  c4 linkTo(self);
  self hide();
  c4 setscriptablepartstate("effects", "explode", 0);
  c4 notify("detonateExplosive");
  radiusdamage(self.origin, 384, 256, 40, undefined, "MOD_EXPLOSIVE", "c4_mp");
  self playSound("iw9_frag_grenade_expl_trans");

  if(istrue(level.var_d744dab15887349d)) {
    if(isDefined(who) && isPlayer(who)) {
      who.shouldskipdeathsshield = 1;
      who dodamage(self.health + 100, self.origin, who, who, "MOD_SUICIDE", "c4_mp");
    }
  }

  playrumbleonposition("grenade_rumble", self.origin);
  earthquake(0.45, 0.7, self.origin, 800);
  self delete();
}

function damagetrapfuncthink(damagefunc, struct) {
  self endon("trap_trigger");
  self setCanDamage(1);
  self.health = 99999;

  while(true) {
    self waittill("damage", damage, attacker, direction_vec, point, type, modelname, tagname, partname, idflags, objweapon, origin, angles, normal, inflictor);

    if(scripts\engine\utility::issharedfuncdefined("tripwire", "blowTripWire")) {
      self thread[[scripts\engine\utility::getsharedfunc("tripwire", "blowTripWire")]](attacker, type);
    }

    if(scripts\engine\utility::issharedfuncdefined("tripwire", "canTripTrap")) {
      var_ee6983a991436671 = scripts\engine\utility::getsharedfunc("tripwire", "canTripTrap");

      if(self[[var_ee6983a991436671]](attacker, objweapon, type, damage, point)) {
        break;
      }
    } else if(cantriptrap(attacker, type, damage)) {
      break;
    }

    self.health += damage;
  }

  self.triggered = 1;

  if(isDefined(self.defusehintstruct) && !isDefined(self.defusehintstruct.defused)) {
    if(isent(self.defusehintstruct)) {
      self.defusehintstruct makeunusable();
      self.defusehintstruct delete();
    }
  }

  triggertraps = 0;
  firsttriggered = 1;
  self makeunusable();

  foreach(parenttripwire in self.parenttripwires) {
    parenttripwire notify("trigger", attacker, triggertraps, firsttriggered);
  }

  self notify("trigger", attacker, 1);
}

function cantriptrap(attacker, type, damage) {
  if(!isDefined(attacker)) {
    return false;
  }

  if(isPlayer(attacker) && (type == "MOD_GRENADE_SPLASH" || type == "MOD_PROJECTILE_SPLASH") && damage > 150) {
    return true;
  }

  return false;
}

function disarmfuncthink(disarmfunc, struct) {
  self endon("trap_trigger");

  if(isDefined(struct.radius)) {
    var_7c46ca1bdcc9e980 = struct.radius;
  } else {
    var_7c46ca1bdcc9e980 = 128;
  }

  hint_offset = (0, 0, 0);
  self.defusehintstruct = undefined;

  if(scripts\engine\utility::issharedfuncdefined("tripwire", "createHintObject")) {
    var_ee6983a991436671 = scripts\engine\utility::getsharedfunc("tripwire", "createHintObject");
    self.defusehintstruct = [[var_ee6983a991436671]](struct.origin, undefined, undefined, undefined, undefined, "duration_medium", "hide", 128, 35, 84, 35);
  } else {
    self.defusehintstruct = struct spawn_script_origin();
  }

  self.deletefunc = &delete_trapfunc;
  self.defusehintstruct waittill("trigger", who);
  level.lasttripwiredefusedtime = gettime();
  self.defusehintstruct.defused = 1;
  self.triggered = 1;
  triggertraps = 0;
  firsttriggered = 1;

  if(isent(self.defusehintstruct)) {
    self.defusehintstruct makeunusable();
    self.defusehintstruct delete();
  }

  foreach(parenttripwire in self.parenttripwires) {
    parenttripwire notify("trigger", who, triggertraps, firsttriggered);
  }

  self[[disarmfunc]](who);
}

function getdisarmfunc(type) {
  switch (type) {
    case #"hash_4beeaacc1db7b8cc":
      return &disarmfuncsemtex;
    case #"hash_496a20490fb91698":
      return &disarmfuncfrag;
    default:
      assertmsg("<dev string:x217>" + type + "<dev string:x23e>");
      break;
  }
}

function disarmfuncsemtex(who) {
  who disarmgiveweapon("semtex", "semtex", self.origin, self.angles);
  self delete();
}

function disarmfuncfrag(who) {
  who disarmgiveweapon("frag", "frag", self.origin, self.angles);
  self delete();
}

function disarmgiveweapon(weapon, lootname, grenade_origin, grenade_angles) {
  if(scripts\engine\utility::issharedfuncdefined("tripwire", "disarmGiveWeapon")) {
    var_ee6983a991436671 = scripts\engine\utility::getsharedfunc("tripwire", "disarmGiveWeapon");
    thread[[var_ee6983a991436671]](weapon, lootname, self, grenade_origin, grenade_angles);
  }
}

function function_391d956c772fb03f() {
  precachetrap("tripwire_trap_frag", "offhand_2h_wm_grenade_frag_v0", 1);
  precachetrap("tripwire_trap_semtex", "offhand_2h_wm_grenade_semtex_v0", 1);
  precachetrap("tripwire_trap_c4", "offhand_2h_wm_c4_v0", 0);

  if(!isDefined(level.tripwireweaponname)) {
    level.tripwireweaponname = "frag_grenade_mp";
  }

  if(scripts\engine\utility::issharedfuncdefined("tripwire", "sort")) {
    [[scripts\engine\utility::getsharedfunc("tripwire", "sort")]]();
  }

  setDvar(@ "hash_c6241d315c0f6bcf", 0);
  level thread function_b96a88fafd4943c5();
}

function function_41e381609b6ab0(var_ffcaa31c31962d79) {
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("trap_device", &function_6cae226462403bcc);
  tripwires = getentitylessscriptablearray(var_ffcaa31c31962d79, "classname");

  if(!isDefined(level.var_cbe618f35b332990)) {
    level.var_cbe618f35b332990 = spawn("script_origin", (0, 0, 0));
  }

  foreach(tripwire in tripwires) {
    tripwire function_e532c2521845ce4a();
    tripwire thread function_4d63a162b2fb4275();
  }

  level.tripwires.tripwires = array_combine(level.tripwires.tripwires, tripwires);
}

function tripwire_enable(tripwire, ownerteam, tripwiretargets) {
  tripwire function_e532c2521845ce4a(ownerteam, tripwiretargets);
  tripwire thread function_4d63a162b2fb4275();
  tripwire.enabled = 1;
  level.tripwires.tripwires[level.tripwires.tripwires.size] = tripwire;
}

function tripwire_disable(tripwire) {
  tripwire.enabled = 0;
  assertex(isDefined(tripwire.targetarray), "<dev string:x269>");

  foreach(item in tripwire.targetarray) {
    if(item getscriptablehaspart("trap_device")) {
      item setscriptablepartstate("trap_device", "off");
      continue;
    }

    if(item.classname == "scriptable_dmz_tripwire" || item.classname == "scriptable_ob_tripwire") {
      item setscriptablepartstate("wire", "off");
      continue;
    }

    if(item getscriptablehaspart("wall_pin")) {
      item setscriptablepartstate("wall_pin", "invisible");
      continue;
    }

    assertmsg("<dev string:x291>" + tripwire.origin);
  }

  tripwire setscriptablepartstate("wire", "off");
}

function function_e532c2521845ce4a(var_8eca5bdf48ccf8e6, targets) {
  tripwire = self;
  tripwire setscriptablepartstate("wire", "wire_taut");
  tripwire.targets = [];
  tripwire.length = 64;
  tripwire.istripwire = 1;
  tripwire.triggered = 0;
  tripwire.delay = 0.35;
  var_c2306c15ef050dfc = 0;

  if(!isDefined(targets)) {
    targets = getentitylessscriptablearray(tripwire.target, "targetname");
  }

  tripwire.targetarray = targets;
  tripwire.trapdevice = undefined;
  scriptablename = undefined;
  var_303f68b800b31d41 = [];

  foreach(item in tripwire.targetarray) {
    if(item getscriptablehaspart("trap_device")) {
      tripwire.trapdevice = item;
      tripwire.trapdevice.tripwire = tripwire;
      scriptablename = getsubstr(tripwire.trapdevice.classname, 11);
      continue;
    }

    if(item.classname == "scriptable_dmz_tripwire" || item.classname == "scriptable_ob_tripwire") {
      item setscriptablepartstate("wire", "wire_taut");
      tripwire.extrawire = item;
      var_c2306c15ef050dfc = 15;
      continue;
    }

    if(item getscriptablehaspart("wall_pin")) {
      item setscriptablepartstate("wall_pin", "visible", 1);
      var_303f68b800b31d41[var_303f68b800b31d41.size] = item.origin;
      continue;
    }

    assertmsg("<dev string:x291>" + tripwire.origin);
  }

  tripwire.trapdevice setscriptablepartstate("trap_device", "active");
  var_302b1852ac0137d4 = var_303f68b800b31d41.size == 2;
  tripwiretriggerradius = 5;
  trigger_f = -1 * anglestoup(tripwire.angles);
  trigger_r = anglestoright(tripwire.angles);
  trigger_u = anglesToForward(tripwire.angles);
  triggerlength = tripwire.length + var_c2306c15ef050dfc;
  triggerpos = tripwire.origin - var_c2306c15ef050dfc * trigger_u;

  if(var_302b1852ac0137d4) {
    var_802d90d64037ba83 = var_303f68b800b31d41[0] - var_303f68b800b31d41[1];
    tripwire.length = length(var_802d90d64037ba83);
    triggerlength = tripwire.length;
    triggerpos = tripwire.origin;
  }

  tripwire.trigger = spawn("trigger_rotatable_radius", triggerpos, 0, tripwiretriggerradius, triggerlength);
  tripwire.trigger.angles = axistoangles(trigger_f, trigger_r, trigger_u);
  var_4a2359165feb7717 = tripwire.origin + trigger_u * 32;
  var_248f2537e91d1766 = (40, 30, 64 + var_c2306c15ef050dfc);

  if(var_302b1852ac0137d4) {
    var_4a2359165feb7717 = tripwire.origin + trigger_u * tripwire.length * 0.5;
    var_d3e09f5f7bbb6484 = getdvarint(@ "hash_b20f014ff8301b42", 4);
    var_437c30771383edb0 = getdvarint(@ "hash_b64fa5855f75fdb5", 7);
    var_dc33914a50fc9820 = getdvarint(@ "hash_9950ea4c303f6053", 10);
    var_35e885a65f4c35f = tripwire.length * 0.5;
    var_248f2537e91d1766 = (var_35e885a65f4c35f + var_d3e09f5f7bbb6484, var_437c30771383edb0, var_dc33914a50fc9820);
  }

  if(getdvarint(@ "debug_tripwire", 0) != 0) {
    thread scripts\cp_mp\utility\debug_utility::drawsphere(var_4a2359165feb7717, 10, 600, (0, 1, 0));
  }

  if(isDefined(var_8eca5bdf48ccf8e6)) {
    tripwire.navobstacleid = createnavbadplacebybounds(var_4a2359165feb7717, var_248f2537e91d1766, tripwire.angles, var_8eca5bdf48ccf8e6);
  } else {
    tripwire.navobstacleid = createnavobstaclebybounds(var_4a2359165feb7717, var_248f2537e91d1766, tripwire.angles);
  }

  if(scripts\engine\utility::issharedfuncdefined("tripwire", "onTripwireCreate")) {
    [[scripts\engine\utility::getsharedfunc("tripwire", "onTripwireCreate")]](tripwire);
  }
}

function function_4d63a162b2fb4275() {
  tripwire = self;
  tripwire endon("tripwire_defused");
  tripwire.trigger waittill("trigger", triggeringent);
  function_fb4b4fa0cee578bd(triggeringent, tripwire);
}

function function_fb4b4fa0cee578bd(triggeringent, tripwire) {
  if(istrue(tripwire.triggered)) {
    return;
  }

  tripwire.triggered = 1;

  if(isDefined(tripwire.extrawire)) {
    tripwire.extrawire setscriptablepartstate("wire", "wire_snap");
    tripwire setscriptablepartstate("wire", "off");
  } else {
    tripwire setscriptablepartstate("wire", "wire_snap");
  }

  tripwire.trapdevice setscriptablepartstate("trap_device", "off");
  grenadename = "frag_tripwire";

  if(isDefined(tripwire.script_parameters)) {
    grenadename = tripwire.script_parameters;
  } else if(isDefined(tripwire.var_70587812595fd991) && tripwire.var_70587812595fd991 != "") {
    grenadename = tripwire.var_70587812595fd991;
  }

  frag = magicgrenademanual(grenadename, tripwire.trapdevice.origin, (0, 0, 0), 0.25);
  frag waittill("explode");

  if(isDefined(tripwire.script_parameters) && scripts\engine\utility::issharedfuncdefined("tripwire", tripwire.script_parameters)) {
    [[scripts\engine\utility::getsharedfunc("tripwire", tripwire.script_parameters)]](triggeringent, tripwire);
  } else if(scripts\engine\utility::issharedfuncdefined("tripwire", "tripwire_override")) {
    [[scripts\engine\utility::getsharedfunc("tripwire", "tripwire_override")]](triggeringent, tripwire);
  } else {
    function_5edfa6cc73a7922d(tripwire);
  }

  if(scripts\engine\utility::issharedfuncdefined("tripwire", "onTripwireTriggered")) {
    [[scripts\engine\utility::getsharedfunc("tripwire", "onTripwireTriggered")]](triggeringent, tripwire);
  }

  wait 0.1;
  destroynavobstacle(tripwire.navobstacleid);
  tripwire.trigger delete();
}

function function_5edfa6cc73a7922d(tripwire) {
  level.var_cbe618f35b332990 radiusdamage(tripwire.trapdevice.origin, 384, 200, 40, level.var_cbe618f35b332990, "MOD_GRENADE", level.tripwireweaponname);
  playrumbleonposition("grenade_rumble", tripwire.trapdevice.origin);
  earthquake(0.45, 0.7, tripwire.trapdevice.origin, 800);
}

function function_6cae226462403bcc(instance, part, state, player, bautouse, usestring) {
  if(part == "trap_device") {
    instance setscriptablepartstate("trap_device", "off");

    if(isDefined(instance.tripwire.extrawire)) {
      instance.tripwire.extrawire setscriptablepartstate("wire", "wire_snap");
      instance.tripwire setscriptablepartstate("wire", "off");
    } else {
      instance.tripwire setscriptablepartstate("wire", "wire_snap");
    }

    instance.tripwire notify("tripwire_defused");

    if(scripts\engine\utility::issharedfuncdefined("tripwire", "onTripwireDefused")) {
      [[scripts\engine\utility::getsharedfunc("tripwire", "onTripwireDefused")]](player, instance.tripwire);
    }

    destroynavobstacle(instance.tripwire.navobstacleid);

    if(isent(instance.tripwire.trigger)) {
      instance.tripwire.trigger delete();
    }

    var_259b17a170041609 = undefined;
    instance.tripwire.disabled = 1;

    switch (instance.classname) {
      case #"hash_fa19f0086a89d0b2":
        var_259b17a170041609 = "brloot_offhand_frag";
        break;
      default:
        var_259b17a170041609 = "brloot_offhand_frag";
        break;
    }

    if(scripts\engine\utility::issharedfuncdefined("tripwire", "createLootDropInfo", 0)) {
      dropinfo = [[scripts\engine\utility::getsharedfunc("tripwire", "createLootDropInfo")]](instance.origin, instance.angles, undefined, 0, 0, undefined, 1);
      [[scripts\engine\utility::getsharedfunc("tripwire", "spawnPickup")]](var_259b17a170041609, dropinfo, 1, 1);
    }
  }
}

function function_b96a88fafd4943c5() {
  level endon("<dev string:x2c5>");
  tripwires = getentitylessscriptablearray("<dev string:x2d3>", "<dev string:x2ee>");
  enabledcolor = (0, 1, 0);
  disabledcolor = (1, 0, 0);
  var_7b32db7c7f51bac5 = (0, 0, 1);

  while(true) {
    if(getdvarint(@ "hash_c6241d315c0f6bcf", 0) == 1) {
      foreach(tripwire in tripwires) {
        if(istrue(tripwire.enabled)) {
          thread scripts\cp_mp\utility\debug_utility::drawsphere(tripwire.origin, 32, 1, enabledcolor);
        }
      }
    } else if(getdvarint(@ "hash_c6241d315c0f6bcf", 0) == 2) {
      foreach(tripwire in tripwires) {
        if(!istrue(tripwire.enabled)) {
          thread scripts\cp_mp\utility\debug_utility::drawsphere(tripwire.origin, 32, 1, disabledcolor);
        }
      }
    } else if(getdvarint(@ "hash_c6241d315c0f6bcf", 0) == 3) {
      foreach(tripwire in tripwires) {
        if(istrue(tripwire.triggered) || istrue(tripwire.disarmed)) {
          thread scripts\cp_mp\utility\debug_utility::drawsphere(tripwire.origin, 32, 1, var_7b32db7c7f51bac5);
          continue;
        }

        if(istrue(tripwire.enabled)) {
          thread scripts\cp_mp\utility\debug_utility::drawsphere(tripwire.origin, 32, 1, enabledcolor);
          continue;
        }

        thread scripts\cp_mp\utility\debug_utility::drawsphere(tripwire.origin, 32, 1, disabledcolor);
      }
    } else if(getdvarint(@ "hash_c6241d315c0f6bcf", 0) == 4) {
      foreach(tripwire in tripwires) {
        if(istrue(tripwire.triggered) || istrue(tripwire.disarmed)) {
          thread scripts\cp_mp\utility\debug_utility::drawsphere(tripwire.origin, 32, 1, var_7b32db7c7f51bac5);
        }
      }
    }

    wait 1;
  }
}

# /