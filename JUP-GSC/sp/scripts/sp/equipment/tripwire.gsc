/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\equipment\tripwire.gsc
***********************************************/



#using scripts\common\utility;
#using scripts\common\values;
#using scripts\engine\math;
#using scripts\engine\sp\utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\sp\equipment\bottle;
#using scripts\sp\equipment\offhands;
#using scripts\sp\loot;
#using scripts\sp\player\cursor_hint;
#using scripts\sp\player_death;
#using scripts\sp\utility;
#namespace tripwire;

function precache() {
  if(!isDefined(level.tripwires)) {
    tripwiremodelprecache();
    spawntripwirelevelstruct();
  }
}

function tripwiremodelprecache() {
  precachemodel("equipment_wm_tripwire_standard");
  precachemodel("equipment_wm_tripwire_standard");
  precachemodel("equipment_wm_tripwire_standard");
  precachemodel("equipment_wm_tripwire_wall_after");
  precachemodel("equipment_wm_tripwire_wall_after_01");
  precachemodel("equipment_wm_tripwire_wall_after_02");
  precachemodel("equipment_wm_tripwire_wall_after_03");
  precachemodel("equipment_wm_tripwire_wall_after_04");
  precachemodel("equipment_wm_tripwire_ceiling_after");
  precachemodel("equipment_wm_tripwire_floor_after");
}

function precachetrap(type, model, candisarm, var_fa943467b1592255, cursorhintstring) {
  precache();

  if(!isDefined(level.tripwires.traptypes[type])) {
    level.tripwires.traptypes[type] = spawnStruct();
    level.tripwires.traptypes[type].model = model;
    level.tripwires.traptypes[type].triggerfunc = gettriggerfunc(type);
    level.tripwires.traptypes[type].setmodelfunc = getsetmodelfunc(type);
    level.tripwires.traptypes[type].candisarm = candisarm;
    level.tripwires.traptypes[type].var_fa943467b1592255 = var_fa943467b1592255;
    level.tripwires.traptypes[type].cursorhintstring = cursorhintstring;

    if(candisarm) {
      level.tripwires.traptypes[type].disarmfunc = getdisarmfunc(type);
    }
  }

  precachemodel(model);
}

function spawntripwirelevelstruct() {
  if(!isDefined(level.tripwires)) {
    level.tripwires = spawnStruct();
    level.tripwires.traptypes = [];
    level.tripwires.tripwires = [];
    level.tripwires.traps = [];
    level.tripwires.dangerzones = [];
    level.tripwires.var_ba1d822da3e54246 = [];
  }
}

function init() {
  if(!isDefined(level.tripwires)) {
    return;
  }

  setdvarifuninitialized(@ "debug_tripwire", 0);
  var_7992e35c1abecadd = getStructArray("tripwire_start", "script_noteworthy");

  foreach(startstruct in var_7992e35c1abecadd) {
    if(!isDefined(startstruct.target)) {
      assertmsg("script_struct_tripwire_start at location " + startstruct.origin + " has no target.Target a script_struct_tripwire_end where you want the tripwire to end");
    }

    endstructs = getStructArray(startstruct.target, "targetname");

    if(endstructs.size < 1) {
      assertmsg("script_struct_tripwire_start at location " + startstruct.origin + " has no target struct.Target a script_struct_tripwire_end where you want the tripwire to end");
    }

    foreach(endstruct in endstructs) {
      buildtripwire(startstruct, endstruct);
    }
  }
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

function function_fe9aa5559bc83b58() {
  if(isDefined(self.spawnflags) && self.spawnflags & 2) {
    return 1;
  }

  return 0;
}

function function_f48a6c353ff5d960() {
  if(isDefined(self.spawnflags) && self.spawnflags & 4) {
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

  if(endstruct function_fe9aa5559bc83b58()) {
    tripwire.trigger = spawn("trigger_rotatable_radius", tripwire.origin, 7, tripwiretriggerradius, tripwire.length + 10);
  } else {
    tripwire.trigger = spawn("trigger_rotatable_radius", tripwire.origin, 0, tripwiretriggerradius, tripwire.length + 10);
  }

  tripwire.var_d8ec40ff894a8d81 = endstruct function_f48a6c353ff5d960();
  trigger_f = -1 * anglestoup(tripwire.angles);
  trigger_r = anglestoright(tripwire.angles);
  trigger_u = anglesToForward(tripwire.angles);
  tripwire.trigger.angles = axistoangles(trigger_f, trigger_r, trigger_u);
  tripwire.istripwire = 1;

  if(isDefined(startstruct.script_delay)) {
    tripwire.delay = startstruct.script_delay;
  } else {
    tripwire.delay = math::factor_value(0.1, 0.35, tripwire getnormtripwirelength());
  }

  return tripwire;
}

function function_e27e699a875868d8() {
  length = 10;

  while(true) {
    if(!isDefined(self)) {
      return;
    }

    u = anglestoup(self.angles);
    f = anglesToForward(self.angles);
    r = anglestoright(self.angles);
    line(self.origin, self.origin + u * length, (0, 0, 1), 1, 0, 1);
    line(self.origin, self.origin + f * length, (1, 0, 0), 1, 0, 1);
    line(self.origin, self.origin + r * length, (0, 1, 0), 1, 0, 1);
    waitframe();
  }
}

function inittripwireanims(animname) {
  if(!isDefined(animname)) {
    assertmsg("tripwire struct found with missing script_animname KVP.Reopen your map, save, and compile only ents to fix");
  }

  self.triggeranim = gettripwiretriggeranim(animname);
  self.stretchanim = gettripwirestretchanim(animname);
  self setanim(self.triggeranim, 1, 0, 0);
  self setanim(self.stretchanim, 1, 0, 0);

  if(self.length < 10 || self.length > 300) {
    assertmsg("tripwire at location " + self.origin + " must be between " + 10 + " and " + 300 + " units apart.");
  }

  self setanimtime(self.stretchanim, getnormtripwirelength());
}

function inittripwirestaticmodel(animname) {
  if(!isDefined(animname)) {
    assertmsg("tripwire struct found with missing script_animname KVP.Reopen your map, save, and compile only ents to fix");
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

  while(true) {
    self.trigger waittill("trigger", who);

    if(getdvarint(@ "debug_tripwire")) {
      line(self.origin, self.origin + anglesToForward(self.angles) * self.length, (1, 0, 0), 1, 0, 1);
    }

    triggertraps = 1;
    firsttriggered = 1;

    if(tripwireshouldtrigger(who)) {
      self notify("trigger", who, triggertraps, firsttriggered);
    }
  }
}

function tripwireshouldtrigger(who) {
  contentsoverride = create_contents(1, 0, 0, 0, 1, 1, 0, 0, 1);
  trace = ray_trace_ents(self.origin, self.endpoint, who, contentsoverride);

  if(trace["fraction"] < 1) {
    return 1;
  }

  return 0;
}

function buildtripwiretrap(struct, parenttripwire) {
  if(!isDefined(struct.trap)) {
    [[level.tripwires.traptypes[struct.script_noteworthy].setmodelfunc]](struct);
    struct.trap thread triggertrapfuncthink(level.tripwires.traptypes[struct.script_noteworthy].triggerfunc, struct);
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

function getnormtripwirelength() {
  return math::normalize_value(10, 300, self.length);
}

function tripwirehastraps() {
  foreach(target in self.targets) {
    if(isDefined(target.istrap) && !isDefined(target.triggered)) {
      return true;
    }
  }

  return false;
}

function gettripwiretraps() {
  traps = [];

  foreach(target in self.targets) {
    if(isDefined(target.istrap) && !isDefined(target.triggered)) {
      traps = array_add(traps, target);
    }
  }

  return traps;
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
  thread trapdangerzoneproc();
  self[[triggerfunc]](who, triggertrap, firsttriggered);
}

function trapdangerzoneproc() {
  if(!tripwirehastraps()) {
    return;
  }

  traps = gettripwiretraps();

  foreach(trap in traps) {
    trap thread spawntrapdangerzone();
  }
}

function spawntrapdangerzone() {
  dangerzone = spawn("trigger_radius", self.origin, 0, 300, 300);
  level.tripwires.dangerzones = array_add(level.tripwires.dangerzones, dangerzone);
  wait 1;
  level.tripwires.dangerzones = array_remove(level.tripwires.dangerzones, dangerzone);
  dangerzone delete();
}

function playerintripwiredangerzone() {
  if(!isDefined(level.tripwires)) {
    return false;
  }

  foreach(dangerzone in level.tripwires.dangerzones) {
    if(level.player istouching(dangerzone)) {
      return true;
    }
  }

  return false;
}

function triggertrapfuncthink(triggerfunc, struct) {
  while(true) {
    self waittill("trigger", who, triggertrap);

    if(triggertrap) {
      break;
    }
  }

  self notify("trap_trigger");
  self.triggered = 1;

  if(isDefined(self.defusehintstruct) && !isDefined(self.defusehintstruct.defused) && !level.tripwires.traptypes[struct.script_noteworthy].var_fa943467b1592255) {
    self.defusehintstruct scripts\sp\player\cursor_hint::remove_cursor_hint();
  }

  self[[triggerfunc]](who);
}

function gettriggerfunc(type) {
  switch (type) {
    case #"hash_32670e2a61b99a3b":
      return &triggerfuncc4;
    case #"hash_4beeaacc1db7b8cc":
      return &triggerfuncsemtex;
    case #"hash_496a20490fb91698":
      return &triggerfuncfrag;
    case #"hash_e0b40680bb70bdb4":
      return &function_ff147402c60ccd89;
    case #"hash_996be0d30bf84ba0":
      return &function_69edfcd6ffcd5561;
    default:
      assertmsg("Add a triggerFunc for trigger trap " + type + " to scriptsspequipment\tripwire::getTriggerFunc");
      break;
  }
}

function getsetmodelfunc(type) {
  switch (type) {
    case #"hash_32670e2a61b99a3b":
      return &function_dc3cd630742e5ae9;
    case #"hash_4beeaacc1db7b8cc":
      return &function_dc3cd630742e5ae9;
    case #"hash_496a20490fb91698":
      return &function_dc3cd630742e5ae9;
    case #"hash_e0b40680bb70bdb4":
      return &function_dc3cd630742e5ae9;
    case #"hash_996be0d30bf84ba0":
      return &function_af551bcedf90478;
    default:
      assertmsg("Add a setModelFunc for trigger trap " + type + " to scriptsspequipment\tripwire::getSetModelFunc");
      break;
  }
}

function function_dc3cd630742e5ae9(struct) {
  if(!isDefined(struct.angles)) {
    angles = (0, 0, 0);
  } else {
    angles = struct.angles;
  }

  struct.trap = spawn("script_model", struct.origin);
  struct.trap.angles = angles;
  struct.trap setModel(level.tripwires.traptypes[struct.script_noteworthy].model);
}

function function_af551bcedf90478(struct) {
  weaponentity = getEnt(struct.target, "targetname");

  if(!isDefined(weaponentity.angles)) {
    angles = (0, 0, 0);
  } else {
    angles = weaponentity.angles;
  }

  struct.trap = spawn("script_model", weaponentity.origin);
  struct.trap.angles = angles;
  weaponbasename = getweaponbasename(weaponentity);
  weaponattachments = getweaponattachments(weaponentity);
  struct.trap.weaponobject = make_weapon(weaponbasename, weaponattachments);
  struct.trap utility::make_weapon_model(weaponbasename, struct.trap.weaponobject.attachments);
  struct.trap.script_ammo_clip = weaponentity.script_ammo_clip;
  struct.trap.var_e84ad86715d85cc = struct.trap gettagorigin("tag_flash");
  struct.trap.var_6a862672391c9895 = struct.trap.var_e84ad86715d85cc + anglesToForward(struct.trap gettagangles("tag_flash")) * 100;
  struct.trap.targetname = weaponentity.targetname;
  weaponentity delete();
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
    assertmsg("tripwire struct found with missing script_animname KVP.Reopen your map, save, and compile only ents to fix");
  }

  switch (animname) {
    case #"hash_28b4e95012259360":
      return "equipment_wm_tripwire_standard";
    case #"hash_3e7681464ca7b9fd":
      return "equipment_wm_tripwire_standard";
    case #"hash_bdea657441323e75":
      return "equipment_wm_tripwire_standard";
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
  self.trigger delete();
  self setanimrate(self.triggeranim, 1);
  self setanim(%tripwire_stretch_overlay, 0, 0.2, 0);

  if(!self.var_d8ec40ff894a8d81) {
    thread swaptostaticmodel();
  }

  triggersound = gettripwiretriggersound(firsttriggered);
  thread play_sound_in_space(triggersound, self.origin);

  if(isDefined(self.finalangles) && !self.var_d8ec40ff894a8d81) {
    thread rotatetofinalangles();
  }

  if(who == level.player) {
    level.player playRumbleOnEntity("damage_light");
    earthquake(0.1, 0.2, level.player.origin, 2000);
  }

  wait self.delay;

  if(isDefined(self.navmodifier)) {
    destroynavobstacle(self.navmodifier);
  }

  firsttriggered = 0;

  foreach(target in self.targets) {
    target notify("trigger", who, triggertraps, firsttriggered);
  }

  if(self.var_d8ec40ff894a8d81) {
    self delete();
  }
}

function rotatetofinalangles() {
  self endon("death");
  wait 0.25;
  self rotateTo(self.finalangles, 0.25);
}

function swaptostaticmodel() {
  animtime = getanimlength(self.triggeranim);
  wait animtime;
  self setModel(self.staticmodel);
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
  thread death_hint_think(60, "MOD_GRENADE_SPLASH");
  semtex waittill("explode");
  level notify("tripwire_grenade_explode", self);
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
  thread death_hint_think(60, "MOD_GRENADE_SPLASH");
  frag waittill("explode");
  level notify("tripwire_grenade_explode", self);
  playrumbleonposition("grenade_rumble", self.origin);
  earthquake(0.45, 0.7, self.origin, 800);
  wait 0.1;
  self notify("cancel_death_hint");
  self delete();
}

function triggerfuncc4(who) {
  if(isDefined(self.grenadeweaponoverride)) {
    grenadetype = self.grenadeweaponoverride;
  } else {
    grenadetype = "c4_sp_tripwire";
  }

  c4 = magicgrenademanual(grenadetype, self.origin, (0, 0, 0), 0.25);
  c4.angles = self.angles;
  c4.origin = self.origin;
  thread play_sound_in_space("minefield_click", self.origin);
  self hide();
  c4 setscriptablepartstate("plant", "active", 0);
  c4 waittill("explode");
  thread play_sound_in_space("iw9_frag_grenade_expl_trans", self.origin);
  playrumbleonposition("grenade_rumble", self.origin);
  earthquake(0.45, 0.7, self.origin, 800);
  self delete();
}

function function_ff147402c60ccd89(who) {
  if(isDefined(self.grenadeweaponoverride)) {
    grenadetype = self.grenadeweaponoverride;
  } else {
    grenadetype = "bottle";
  }

  bottle = magicgrenademanual(grenadetype, self.origin, (0, 0, 0));
  bottle.angles = self.angles;
  bottle.origin = self.origin;
  self delete();
  who thread scripts\sp\equipment\bottle::function_4b06c81b27875a14(bottle);
}

function function_69edfcd6ffcd5561(who) {
  thread overkill_manager();
  magicbullet(self.weaponobject, self.var_e84ad86715d85cc, self.var_6a862672391c9895);

  if(!isDefined(level.stealth)) {
    return;
  }

  if(flag("stealth_spotted")) {
    radius = function_61b03c8c194a6733("spotted", "gunshot");
  } else {
    radius = function_61b03c8c194a6733("hidden", "gunshot");
  }

  aiarray = getaiarrayinradius(self.origin, radius);

  foreach(ai in aiarray) {
    if(!isDefined(ai.stealth)) {
      continue;
    }

    ai aieventlistenerevent("gunshot", who, self.origin);
  }
}

function overkill_manager() {
  level.player val::set("trap", "shotgun_overkill", 1);
  waitframe();

  if(isalive(level.player)) {
    level.player val::set("trap", "shotgun_overkill", 0);
  }
}

function death_hint_think(quote, var_74cf69ce872e454a) {
  self endon("cancel_death_hint");
  level.player waittill("death", attacker, cause, objweapon, movingplatform, inflictor);

  if(cause == var_74cf69ce872e454a) {
    scripts\sp\player_death::set_custom_death_quote(quote);
  }
}

function damagetrapfuncthink(damagefunc, struct) {
  self endon("trap_trigger");
  self setCanDamage(1);
  self.health = 99999;

  while(true) {
    self waittill("damage", damage, attacker, direction_vec, point, type, modelname, tagname, partname, idflags, objweapon, origin, angles, normal, inflictor);

    if(candamagetrap(attacker, type, damage)) {
      break;
    }

    self.health += damage;
  }

  self.triggered = 1;

  if(isDefined(self.defusehintstruct) && !isDefined(self.defusehintstruct.defused) && !level.tripwires.traptypes[struct.script_noteworthy].var_fa943467b1592255) {
    self.defusehintstruct scripts\sp\player\cursor_hint::remove_cursor_hint();
  }

  triggertraps = 0;
  firsttriggered = 1;

  foreach(parenttripwire in self.parenttripwires) {
    parenttripwire notify("trigger", attacker, triggertraps, firsttriggered);
  }

  self notify("trigger", attacker, 1);
}

function candamagetrap(attacker, type, damage) {
  if(!isDefined(attacker)) {
    return false;
  }

  if(attacker == level.player && (type == "MOD_GRENADE_SPLASH" || type == "MOD_PROJECTILE_SPLASH") && damage > 150) {
    if(level.player getplayerprogression("achievementBoom") != "true") {
      thread trapachievementboom();
    }

    return true;
  }

  return false;
}

function trapachievementboom() {
  tok = strtok(level.player getplayerprogression("achievementBoom"), ",");
  string_origin = "" + self.origin[0] + self.origin[1];

  if(level.player getplayerprogression("achievementBoom") == "") {
    level.player setplayerprogression("achievementBoom", string_origin);
    return;
  }

  if(tok.size == 1 && tok[0] != string_origin) {
    level.player setplayerprogression("achievementBoom", tok[0] + "," + string_origin);
    return;
  }

  if(tok.size == 2 && !isstartstr(tok[0], string_origin) && !isstartstr(tok[1], string_origin)) {
    level.player setplayerprogression("achievementBoom", "true");
    level thread scripts\sp\utility::giveachievement_wrapper("boom");
  }
}

function disarmfuncthink(disarmfunc, struct) {
  if(!level.tripwires.traptypes[struct.script_noteworthy].var_fa943467b1592255) {
    self endon("trap_trigger");
  }

  if(isDefined(struct.radius)) {
    var_7c46ca1bdcc9e980 = struct.radius;
  } else {
    var_7c46ca1bdcc9e980 = 64;
  }

  hint_offset = (0, 0, 0);
  self.defusehintstruct = struct spawn_script_origin();

  if(isDefined(level.tripwires.traptypes[struct.script_noteworthy].cursorhintstring)) {
    self.defusehintstruct scripts\sp\player\cursor_hint::create_cursor_hint(undefined, hint_offset, level.tripwires.traptypes[struct.script_noteworthy].cursorhintstring, 2, var_7c46ca1bdcc9e980, 64, 0, 0, 0, undefined, "duration_medium");
  } else {
    self.defusehintstruct scripts\sp\player\cursor_hint::create_cursor_hint(undefined, hint_offset, &"SCRIPT/DEFUSE", 2, var_7c46ca1bdcc9e980, 64, 0, 0, 0, undefined, "duration_medium");
  }

  if(isDefined(struct.script_spotlight)) {
    self.defusehintstruct.script_spotlight = struct.script_spotlight;
  }

  self.defusehintstruct waittill("trigger", who);
  level.lasttripwiredefusedtime = gettime();
  self.defusehintstruct.defused = 1;
  self.triggered = 1;
  triggertraps = 0;
  firsttriggered = 1;

  if(isDefined(self.var_e8c8fefe0dfaabde)) {
    self[[self.var_e8c8fefe0dfaabde]]();
  }

  self[[disarmfunc]](who);

  foreach(parenttripwire in self.parenttripwires) {
    parenttripwire notify("trigger", who, triggertraps, firsttriggered);
  }

  if(isDefined(self.var_68eed041e77be27)) {
    self[[self.var_68eed041e77be27]]();
  }

  self delete();
}

function getdisarmfunc(type) {
  switch (type) {
    case #"hash_4beeaacc1db7b8cc":
      return &disarmfuncsemtex;
    case #"hash_496a20490fb91698":
      return &disarmfuncfrag;
    case #"hash_e0b40680bb70bdb4":
      return &function_a7f90b357bc11ab5;
    case #"hash_996be0d30bf84ba0":
      return &function_7b932c4705fd44b5;
    default:
      assertmsg("Add a disarm func for trigger trap " + type + " to scriptsspequipment\tripwire::getDisarmFunc");
      break;
  }
}

function disarmfuncsemtex(who) {
  who function_fcbf46aca1ddde2a("semtex", "semtex");
}

function disarmfuncfrag(who) {
  who function_fcbf46aca1ddde2a("frag", "frag");
}

function function_a7f90b357bc11ab5(who) {
  who function_fcbf46aca1ddde2a("bottle", "bottle");
}

function function_7b932c4705fd44b5(who) {
  if(!isPlayer(who)) {
    return;
  }

  if(who player_has_weapon(self.weaponobject)) {
    ammoamount = self.script_ammo_clip;
    var_9eabbd13591b6dfb = who getweaponammostock(getweaponbasename(self.weaponobject)) + ammoamount;
    who setweaponammostock(self.weaponobject, var_9eabbd13591b6dfb);
    who notify("ammo_pickup", ammoamount, getweaponammopoolname(self.weaponobject));
    return;
  }

  primaryweapons = who.primaryweapons;

  foreach(primaryweapon in primaryweapons) {
    if(is_equal(primaryweapon.basename, "none")) {
      primaryweapons = array_remove(primaryweapons, primaryweapon);
    }
  }

  if(primaryweapons.size >= 2) {
    if(weaponcandrop(who.currentweapon)) {
      var_b375af50d8d557a3 = who getweaponammostock(who.currentweapon);
      var_3b508d61581b138d = who getweaponammoclip(who.currentweapon);
      var_cd028c8593c6371d = getweaponattachments(who.currentweapon);
      droppedweaponname = who.currentweapon.basename;

      foreach(var_443a58b864c0b11c in var_cd028c8593c6371d) {
        droppedweaponname += "+" + var_443a58b864c0b11c;
      }

      droppedweapon = spawn("weapon_" + droppedweaponname, who.origin + (0, 0, 15));
      droppedweapon itemweaponsetammo(var_3b508d61581b138d, var_b375af50d8d557a3);
      who notify("pickup", undefined, droppedweapon);
    } else {
      who notify("pickup");
    }

    who takeweapon(who.currentweapon);
    who giveweapon(self.weaponobject);
    who switchtoweapon(self.weaponobject);
    return;
  }

  who notify("pickup");
  who giveweapon(self.weaponobject);
  who switchtoweapon(self.weaponobject);
}

function function_fcbf46aca1ddde2a(equipmentname, lootname) {
  if(self == level.player) {
    if(!hasequipmentoftype(equipmentname)) {
      level.player give_offhand(equipmentname);
      level.player setweaponammoclip(equipmentname, 0);
    }

    if(scripts\engine\sp\utility::player_has_equipment(equipmentname)) {
      scripts\sp\loot::lootfuncandnotification(lootname);
    }
  }
}

function hasequipmentoftype(weap) {
  objweapon = weap;

  if(isstring(weap)) {
    objweapon = makeweaponfromstring(weap);
  }

  equiplist = level.player.offhandinventory;

  foreach(weapon in equiplist) {
    if(issameoffhandtype(weapon, objweapon)) {
      return true;
    }
  }

  return false;
}

function issameoffhandtype(weapon, objweapon) {
  if(scripts\sp\equipment\offhands::getweaponoffhandtype(weapon) == scripts\sp\equipment\offhands::getweaponoffhandtype(objweapon)) {
    return true;
  }

  return false;
}