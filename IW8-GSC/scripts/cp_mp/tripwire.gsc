/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\tripwire.gsc
***********************************************/

function precache(var0, var1) {
  if(!isDefined(level.tripwires)) {
    tripwiremodelprecache();
    spawntripwirelevelstruct();
    return;
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
}

function precachetrap(var0, var1, var2) {
  spawntripwirelevelstruct();

  if(!isDefined(level.tripwires.traptypes[var0])) {
    level.tripwires.traptypes[var0] = spawnStruct();
    level.tripwires.traptypes[var0].model = var1;
    level.tripwires.traptypes[var0].triggerfunc = gettriggerfunc(var0);
    level.tripwires.traptypes[var0].candisarm = var2;

    if(var2) {
      level.tripwires.traptypes[var0].disarmfunc = getdisarmfunc(var0);
    }
  }

  precachemodel(var1);
}

function spawntripwirelevelstruct() {
  if(!isDefined(level.tripwires)) {
    level.tripwires = spawnStruct();
    level.tripwires.traptypes = [];
    level.tripwires.tripwires = [];
    level.tripwires.traps = [];
    return;
  }
}

function init() {
  if(!isDefined(level.tripwires)) {
    return;
  }

  [[scripts\cp_mp\utility\script_utility::getsharedfunc("tripwire", "init")]]();
  setdvarifuninitialized("debug_tripwire", 0);
  var0 = scripts\engine\utility::getStructArray("tripwire_start", "script_noteworthy");

  foreach(var2 in var0) {
    if(isDefined(var2.target)) {}

    var3 = scripts\engine\utility::getStructArray(var2.target, "targetname");

    if(var3.size < 1) {}

    foreach(var5 in var3) {
      buildtripwire(var2, var5);
    }
  }
}

function buildtripwire(var0, var1, var2) {
  if(!isDefined(var1.script_animname)) {
    var1.script_animname = "wall";
  }

  var3 = spawntripwire(var0, var1);
  inittripwireanims(var3, var1.script_animname);
  inittripwirestaticmodel(var3, var1.script_animname);
  thread tripwirethink();
  thread triggertripwirefuncthink(var3);

  if(isDefined(var2)) {
    var3.targets = scripts\engine\utility::array_add(var3.targets, var2);
  }

  processtripwiretarget(var3, var1);
  level.tripwires.tripwires = scripts\engine\utility::array_add(level.tripwires.tripwires, var3);
  return var3;
}

function processtripwiretarget(var0) {
  var1 = "script_struct_tripwire_end at location " + var0.origin + " has no target.Target the ent you want the tripwire to trigger, or another script_struct_tripwire_end to continue the tripwire chain";

  if(!isDefined(var0.target)) {
    return;
  }

  var2 = scripts\engine\utility::getStructArray(var0.target, "targetname");
  var3 = getEntArray(var0.target, "targetname");
  var4 = scripts\engine\utility::array_combine(var2, var3);

  if(var4.size == 0) {}

  if(shouldfindnavmodifier(var0)) {
    self.navmodifier = createnavmodifier(var0.target, "targetname");
  }

  foreach(var6 in var4) {
    if(istripwirestruct(var6)) {
      var6 = buildtripwire(var0, var6, self);
    } else if(istripwiretrapstruct(var6)) {
      var6 = buildtripwiretrap(var6, self);
    }

    self.targets = scripts\engine\utility::array_add(self.targets, var6);
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
  foreach(var1 in self.targets) {
    if(isDefined(var1.istripwire) && var1.istripwire && !isDefined(var1.triggered)) {
      return true;
    }
  }

  return false;
}

#using_animtree("script_model");

function spawntripwire(var0, var1) {
  var2 = var0.origin - var1.origin;
  var3 = spawn("script_model", var1.origin);
  var3.angles = vectortoangles(var2);
  var3 setModel(gettripwiremodel(var1.script_animname));
  var3 useanimtree(#animtree);

  if(isDefined(var1.angles)) {
    var4 = anglesToForward(var1.angles);
    var5 = anglestoright(var3.angles);
    var6 = anglestoup(var3.angles);
    var3.finalangles = axistoangles(var4, var5, var6);
  }

  var3.targets = [];
  var3.endpoint = var0.origin;
  var3.length = length(var2);
  var7 = 30;
  var8 = var3.origin + anglesToForward(var3.angles) * 0.5 * var3.length;
  var3.trigger = spawn("trigger_rotatable_radius", var3.origin, 0, var7, var3.length + 10);
  var9 = -1 * anglestoup(var3.angles);
  var10 = anglestoright(var3.angles);
  var11 = anglesToForward(var3.angles);
  var3.trigger.angles = axistoangles(var9, var10, var11);
  var3.istripwire = 1;
  var3.triggered = 0;

  if(isDefined(var0.script_delay)) {
    var3.delay = var0.script_delay;
  } else {
    var3.delay = scripts\engine\math::factor_value(0.1, 0.35, getnormtripwirelength(var3));
  }

  return var3;
}

function inittripwireanims(var0) {
  if(isDefined(var0)) {}

  self.triggeranim = gettripwiretriggeranim(var0);
  self.stretchanim = gettripwirestretchanim(var0);
  self setanim(self.triggeranim, 1, 0, 0);
  self setanim(self.stretchanim, 1, 0, 0);

  if(self.length < 10 || self.length > 300) {}

  self setanimtime(self.stretchanim, getnormtripwirelength());
}

function inittripwirestaticmodel(var0) {
  if(isDefined(var0)) {}

  self.staticmodel = gettripwirestaticmodel(var0);
}

function gettripwiretriggersound(var0) {
  if(var0) {
    return "tripwire_pop_first";
  }

  if(hastripwirechild()) {
    return "tripwire_pop";
  }

  return "tripwire_pop_last";
}

function tripwirethink() {
  self endon("tripwire_trigger");

  for(;;) {
    self.trigger waittill("trigger", var0);
    var1 = 1;
    var2 = 1;

    if(tripwireshouldtrigger(var0)) {
      self notify("trigger", var0, var1, var2);
    }
  }
}

function tripwireshouldtrigger(var0) {
  if(!isDefined(self) || !isDefined(self.origin) || !isDefined(self.endpoint)) {
    return 0;
  }

  if(!isDefined(var0) || var0 isragdoll()) {
    return 0;
  }

  if(!isalive(var0)) {
    return 0;
  }

  var1 = scripts\engine\trace::create_contents(1, 0, 0, 0, 1, 1, 0, 0, 1);
  var2 = scripts\engine\trace::ray_trace_ents(self.origin, self.endpoint, var0, var1);

  if(!isDefined(var2["fraction"])) {
    return 0;
  }

  if(var2["fraction"] < 1) {
    return 1;
  }

  return 0;
}

function buildtripwiretrap(var0, var1) {
  if(!isDefined(var0.trap)) {
    if(!isDefined(var0.angles)) {
      var2 = (0, 0, 0);
    } else {
      var2 = var1.angles;
    }

    var1.trap = spawn("script_model", var1.origin);
    var1.trap.angles = var2;
    var1.trap setModel(level.tripwires.traptypes[var1.script_noteworthy].model);
    thread triggertrapfuncthink(var1.trap);
    thread damagetrapfuncthink();
    var1.trap.candisarm = level.tripwires.traptypes[var1.script_noteworthy].candisarm;
    var1.trap.istrap = 1;

    if(isDefined(level.tripwires.traptypes[var1.script_noteworthy].disarmfunc)) {
      thread disarmfuncthink(var1.trap, level.tripwires.traptypes[var1.script_noteworthy].disarmfunc);
    }

    if(isDefined(var1.script_parameters)) {
      var3 = strtok(var1.script_parameters, " ");
      var1.trap.grenadeweaponoverride = var3[0];
    }

    var1.trap.parenttripwires = [];
    level.tripwires.traps = scripts\engine\utility::array_add(level.tripwires.traps, var1.trap);
  }

  var1.trap.parenttripwires = scripts\engine\utility::array_add(var1.trap.parenttripwires, var2);
  return var1.trap;
}

function getnormtripwirelength() {
  return scripts\engine\math::normalize_value(10, 300, self.length);
}

function tripwirehastraps() {
  foreach(var1 in self.targets) {
    if(isDefined(var1.istrap) && !isDefined(var1.triggered)) {
      return true;
    }
  }

  return false;
}

function triggertripwirefuncthink(var0) {
  for(;;) {
    self waittill("trigger", var1, var2, var3);

    if(var2) {
      break;
    }

    if(!tripwirehastraps()) {
      break;
    }
  }

  if(isDefined(var1)) {
    var1.lasttriptime = gettime();
  }

  self notify("tripwire_trigger");
  self.triggered = 1;
  self[[var0]](var1, var2, var3);
}

function triggertrapfuncthink(var0) {
  for(;;) {
    self waittill("trigger", var1, var2);

    if(var2) {
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

  self[[var0]](var1);
}

function gettriggerfunc(var0) {
  switch (var0) {
    case "tripwire_trap_c4":
      return &triggerfuncc4;
    case "tripwire_trap_semtex":
      return &triggerfuncsemtex;
    case "tripwire_trap_frag":
      return &triggerfuncfrag;
    default:
      break;
  }
}

#using_animtree("");

function gettripwiretriggeranim(var0) {
  switch (var0) {
    case "ceiling":
      return scripts\engine\utility::random([%tripwire_trigger_standard_ceiling]);
    case "floor":
      return scripts\engine\utility::random([%tripwire_trigger_standard_floor]);
    case "wall":
      if(shouldusewallsize1()) {
        return scripts\engine\utility::random([%tripwire_trigger_standard_wall_01]);
      }

      if(shouldusewallsize2()) {
        return scripts\engine\utility::random([%tripwire_trigger_standard_wall_02]);
      }

      if(shouldusewallsize3()) {
        return scripts\engine\utility::random([%tripwire_trigger_standard_wall_03]);
      }

      if(shouldusewallsize4()) {
        return scripts\engine\utility::random([%tripwire_trigger_standard_wall_04]);
      }

      return scripts\engine\utility::random([%tripwire_trigger_standard_wall]);
  }
}

function gettripwirestaticmodel(var0) {
  switch (var0) {
    case "ceiling":
      return "equipment_wm_tripwire_ceiling_after";
    case "floor":
      return "equipment_wm_tripwire_floor_after";
    case "wall":
      if(shouldusewallsize1()) {
        return "equipment_wm_tripwire_wall_after_01";
      }

      if(shouldusewallsize2()) {
        return "equipment_wm_tripwire_wall_after_02";
      }

      if(shouldusewallsize3()) {
        return "equipment_wm_tripwire_wall_after_03";
      }

      if(shouldusewallsize4()) {
        return "equipment_wm_tripwire_wall_after_04";
      }

      return "equipment_wm_tripwire_wall_after";
  }
}

function gettripwirestretchanim(var0) {
  switch (var0) {
    case "ceiling":
      return % tripwire_trigger_standard_stretch;
    case "floor":
      return % tripwire_trigger_standard_stretch;
    case "wall":
      return % tripwire_trigger_standard_stretch;
  }
}

function gettripwiremodel(var0) {
  if(isDefined(var0)) {}

  switch (var0) {
    case "ceiling":
      return "equipment_wm_tripwire_standard_cp";
    case "floor":
      return "equipment_wm_tripwire_standard_cp";
    case "wall":
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

function triggerfunctripwire(var0, var1, var2) {
  self.trigger delete();
  self setanimrate(self.triggeranim, 1);
  self setanim(%tripwire_stretch_overlay, 0, 0.2, 1);
  thread swaptostaticmodel();
  self playSound("tripwire_pop_cp");
  var3 = gettripwiretriggersound(var2);

  if(isDefined(self.finalangles)) {
    thread rotatetofinalangles();
  }

  wait self.delay;

  if(isDefined(self.navmodifier)) {
    destroynavobstacle(self.navmodifier);
  }

  var2 = 0;

  foreach(var5 in self.targets) {
    var5 notify("trigger", var0, var1, var2);
  }
}

function rotatetofinalangles() {
  self endon("death");
  wait 0.25;
  self rotateTo(self.finalangles, 0.25);
}

function swaptostaticmodel() {
  var0 = getanimlength(self.triggeranim);
  wait var0;
  self setModel(self.staticmodel);
}

function last_phone_check_fail() {
  var0 = 1;

  foreach(var2 in self.parenttripwires) {
    thread triggerfunctripwire(var2, undefined, 1);
    var0 = 0;
  }
}

function triggerfuncsemtex(var0) {
  if(isDefined(self.grenadeweaponoverride)) {
    var1 = self.grenadeweaponoverride;
  } else {
    var1 = "semtex_tripwire";
  }

  var2 = magicgrenademanual(var1, self.origin, (0, 0, 0), 0.25);
  var2.angles = self.angles;
  var2.origin = self.origin;
  var2 linkTo(self);
  self hide();
  var2 waittill("explode");
  radiusdamage(self.origin, 384, 256, 40, undefined, "MOD_EXPLOSIVE", "semtex_mp");
  playrumbleonposition("grenade_rumble", self.origin);
  earthquake(0.45, 0.7, self.origin, 800);
  wait 0.1;
  self notify("cancel_death_hint");
  self delete();
}

function triggerfuncfrag(var0) {
  if(isDefined(self.grenadeweaponoverride)) {
    var1 = self.grenadeweaponoverride;
  } else {
    var1 = "frag_tripwire";
  }

  var2 = magicgrenademanual(var1, self.origin, (0, 0, 0), 0.25);
  var2.angles = self.angles;
  var2.origin = self.origin;
  var2 linkTo(self);
  self hide();
  var2 waittill("explode");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("tripwire", "damageFunc")) {
    var3 = scripts\cp_mp\utility\script_utility::getsharedfunc("tripwire", "damageFunc");
    level thread[[var3]](self, var1);
  } else {
    radiusdamage(self.origin, 384, 256, 40, undefined, "MOD_EXPLOSIVE", "frag_grenade_mp");
    playrumbleonposition("grenade_rumble", self.origin);
    earthquake(0.45, 0.7, self.origin, 800);
  }

  wait 0.1;
  self notify("cancel_death_hint");
  self delete();
}

function triggerfuncc4(var0) {
  if(isDefined(self.grenadeweaponoverride)) {
    var1 = self.grenadeweaponoverride;
  } else {
    var1 = "c4_sp_tripwire";
  }

  var2 = magicgrenademanual(var1, self.origin, (0, 0, 0), 0.25);
  var2.angles = self.angles;
  var2.origin = self.origin;
  var2 linkTo(self);
  self hide();
  var2 setscriptablepartstate("plant", "active", 0);
  var2 waittill("explode");
  radiusdamage(self.origin, 384, 256, 40, undefined, "MOD_EXPLOSIVE", "c4_mp_p");
  self playSound("frag_grenade_expl_trans");
  playrumbleonposition("grenade_rumble", self.origin);
  earthquake(0.45, 0.7, self.origin, 800);
  self delete();
}

function damagetrapfuncthink(var0, var1) {
  self endon("trap_trigger");
  self setCanDamage(1);
  self.health = 99999;

  for(;;) {
    self waittill("damage", var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12, var13, var14, var15);

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("tripwire", "blowTripWire")) {
      self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("tripwire", "blowTripWire")]](var3, var6);
    }

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("tripwire", "canTripTrap")) {
      var16 = scripts\cp_mp\utility\script_utility::getsharedfunc("tripwire", "canTripTrap");

      if(self[[var16]](var3, var11, var6, var2, var5)) {
        break;
      }
    } else if(cantriptrap(var2, var5, var1)) {
      break;
    }

    self.health += var1;
  }

  self.triggered = 1;

  if(isDefined(self.defusehintstruct) && !isDefined(self.defusehintstruct.defused)) {
    if(isent(self.defusehintstruct)) {
      self.defusehintstruct makeunusable();
      self.defusehintstruct delete();
    }
  }

  var17 = 0;
  var18 = 1;
  self makeunusable();

  foreach(var20 in self.parenttripwires) {
    var20 notify("trigger", var2, var17, var18);
  }

  self notify("trigger", var2, 1);
}

function cantriptrap(var0, var1, var2) {
  if(!isDefined(var0)) {
    return false;
  }

  if(var0 == level.player && (var1 == "MOD_GRENADE_SPLASH" || var1 == "MOD_PROJECTILE_SPLASH") && var2 > 150) {
    return true;
  }

  return false;
}

function disarmfuncthink(var0, var1) {
  self endon("trap_trigger");

  if(isDefined(var1.radius)) {
    var2 = var1.radius;
  } else {
    var2 = 128;
  }

  var3 = (0, 0, 0);
  self.defusehintstruct = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("tripwire", "createHintObject")) {
    var4 = scripts\cp_mp\utility\script_utility::getsharedfunc("tripwire", "createHintObject");
    self.defusehintstruct = [[var4]](var2.origin, undefined, undefined, undefined, undefined, "duration_medium", "hide", 128, 35, 84, 35);
  } else {
    self.defusehintstruct = var2 scripts\engine\utility::spawn_script_origin();
  }

  self.deletefunc = &last_phone_check_fail;
  self.defusehintstruct waittill("trigger", var5);
  level.lasttripwiredefusedtime = gettime();
  self.defusehintstruct.defused = 1;
  self.triggered = 1;
  var6 = 0;
  var7 = 1;

  if(isent(self.defusehintstruct)) {
    self.defusehintstruct makeunusable();
    self.defusehintstruct delete();
  }

  foreach(var9 in self.parenttripwires) {
    var9 notify("trigger", var5, var6, var7);
  }

  self[[var1]](var5);
}

function getdisarmfunc(var0) {
  switch (var0) {
    case "tripwire_trap_semtex":
      return &disarmfuncsemtex;
    case "tripwire_trap_frag":
      return &disarmfuncfrag;
    default:
      break;
  }
}

function disarmfuncsemtex(var0) {
  disarmgiveweapon(var0, "semtex", "Semtex");
  self delete();
}

function disarmfuncfrag(var0) {
  disarmgiveweapon(var0, "frag", "M67 Frag");
  self delete();
}

function disarmgiveweapon(var0, var1) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("tripwire", "disarmGiveWeapon")) {
    var2 = scripts\cp_mp\utility\script_utility::getsharedfunc("tripwire", "disarmGiveWeapon");
    GscBinSkip1(0x74, var2, var0, var1, self);
  }
}