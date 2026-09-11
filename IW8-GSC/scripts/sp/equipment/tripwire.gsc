/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\equipment\tripwire.gsc
***********************************************/

function precache(var_0, var_1) {
  if(!isDefined(level.tripwires)) {
    tripwiremodelprecache();
    spawntripwirelevelstruct();
    return;
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

function precachetrap(var_0, var_1, var_2) {
  spawntripwirelevelstruct();

  if(!isDefined(level.tripwires.traptypes[var_0])) {
    level.tripwires.traptypes[var_0] = spawnStruct();
    level.tripwires.traptypes[var_0].model = var_1;
    level.tripwires.traptypes[var_0].triggerfunc = gettriggerfunc(var_0);
    level.tripwires.traptypes[var_0].candisarm = var_2;

    if(var_2) {
      level.tripwires.traptypes[var_0].disarmfunc = getdisarmfunc(var_0);
    }
  }

  precachemodel(var_1);
}

function spawntripwirelevelstruct() {
  if(!isDefined(level.tripwires)) {
    level.tripwires = spawnStruct();
    level.tripwires.traptypes = [];
    level.tripwires.tripwires = [];
    level.tripwires.traps = [];
    level.tripwires.dangerzones = [];
    return;
  }
}

function init() {
  if(!isDefined(level.tripwires)) {
    return;
  }

  setdvarifuninitialized("debug_tripwire", 0);
  var_0 = scripts\engine\utility::getStructArray("tripwire_start", "script_noteworthy");

  foreach(var_2 in var_0) {
    if(isDefined(var_2.target)) {}

    var_3 = scripts\engine\utility::getStructArray(var_2.target, "targetname");

    if(var_3.size < 1) {}

    foreach(var_5 in var_3) {
      buildtripwire(var_2, var_5);
    }
  }
}

function buildtripwire(var_0, var_1, var_2) {
  if(!isDefined(var_1.script_animname)) {
    var_1.script_animname = "wall";
  }

  var_3 = spawntripwire(var_0, var_1);
  inittripwireanims(var_3, var_1.script_animname);
  inittripwirestaticmodel(var_3, var_1.script_animname);
  thread tripwirethink();
  thread triggertripwirefuncthink(var_3);

  if(isDefined(var_2)) {
    var_3.targets = scripts\engine\utility::array_add(var_3.targets, var_2);
  }

  processtripwiretarget(var_3, var_1);
  level.tripwires.tripwires = scripts\engine\utility::array_add(level.tripwires.tripwires, var_3);
  return var_3;
}

function processtripwiretarget(var_0) {
  var_1 = "script_struct_tripwire_end at location " + var_0.origin + " has no target.Target the ent you want the tripwire to trigger, or another script_struct_tripwire_end to continue the tripwire chain";

  if(!isDefined(var_0.target)) {
    return;
  }

  var_2 = scripts\engine\utility::getStructArray(var_0.target, "targetname");
  var_3 = getEntArray(var_0.target, "targetname");
  var_4 = scripts\engine\utility::array_combine(var_2, var_3);

  if(var_4.size == 0) {}

  if(shouldfindnavmodifier(var_0)) {
    self.navmodifier = createnavmodifier(var_0.target, "targetname");
  }

  foreach(var_6 in var_4) {
    if(istripwirestruct(var_6)) {
      var_6 = buildtripwire(var_0, var_6, self);
    } else if(istripwiretrapstruct(var_6)) {
      var_6 = buildtripwiretrap(var_6, self);
    }

    self.targets = scripts\engine\utility::array_add(self.targets, var_6);
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
  foreach(var_1 in self.targets) {
    if(isDefined(var_1.istripwire) && var_1.istripwire && !isDefined(var_1.triggered)) {
      return true;
    }
  }

  return false;
}

#using_animtree("script_model");

function spawntripwire(var_0, var_1) {
  var_2 = var_0.origin - var_1.origin;
  var_3 = spawn("script_model", var_1.origin);
  var_3.angles = vectortoangles(var_2);
  var_3 setModel(gettripwiremodel(var_1.script_animname));
  var_3 useanimtree(#animtree);

  if(isDefined(var_1.angles)) {
    var_4 = anglesToForward(var_1.angles);
    var_5 = anglestoright(var_3.angles);
    var_6 = anglestoup(var_3.angles);
    var_3.finalangles = axistoangles(var_4, var_5, var_6);
  }

  var_3.targets = [];
  var_3.endpoint = var_0.origin;
  var_3.length = length(var_2);
  var_7 = 30;
  var_8 = var_3.origin + anglesToForward(var_3.angles) * 0.5 * var_3.length;
  var_3.trigger = spawn("trigger_rotatable_radius", var_3.origin, 0, var_7, var_3.length + 10);
  var_9 = -1 * anglestoup(var_3.angles);
  var_10 = anglestoright(var_3.angles);
  var_11 = anglesToForward(var_3.angles);
  var_3.trigger.angles = axistoangles(var_9, var_10, var_11);
  var_3.istripwire = 1;

  if(isDefined(var_0.script_delay)) {
    var_3.delay = var_0.script_delay;
  } else {
    var_3.delay = scripts\engine\math::factor_value(0.1, 0.35, getnormtripwirelength(var_3));
  }

  return var_3;
}

function inittripwireanims(var_0) {
  if(isDefined(var_0)) {}

  self.triggeranim = gettripwiretriggeranim(var_0);
  self.stretchanim = gettripwirestretchanim(var_0);
  self setanim(self.triggeranim, 1, 0, 0);
  self setanim(self.stretchanim, 1, 0, 0);

  if(self.length < 10 || self.length > 300) {}

  self setanimtime(self.stretchanim, getnormtripwirelength());
}

function inittripwirestaticmodel(var_0) {
  if(isDefined(var_0)) {}

  self.staticmodel = gettripwirestaticmodel(var_0);
}

function gettripwiretriggersound(var_0) {
  if(var_0) {
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
    self.trigger waittill("trigger", var_0);
    var_1 = 1;
    var_2 = 1;

    if(tripwireshouldtrigger(var_0)) {
      self notify("trigger", var_0, var_1, var_2);
    }
  }
}

function tripwireshouldtrigger(var_0) {
  var_1 = scripts\engine\trace::create_contents(1, 0, 0, 0, 1, 1, 0, 0, 1);
  var_2 = scripts\engine\trace::ray_trace_ents(self.origin, self.endpoint, var_0, var_1);

  if(var_2["fraction"] < 1) {
    return 1;
  }

  return 0;
}

function buildtripwiretrap(var_0, var_1) {
  if(!isDefined(var_0.trap)) {
    if(!isDefined(var_0.angles)) {
      var_2 = (0, 0, 0);
    } else {
      var_2 = var_1.angles;
    }

    var_1.trap = spawn("script_model", var_1.origin);
    var_1.trap.angles = var_2;
    var_1.trap setModel(level.tripwires.traptypes[var_1.script_noteworthy].model);
    thread triggertrapfuncthink(var_1.trap);
    thread damagetrapfuncthink();
    var_1.trap.candisarm = level.tripwires.traptypes[var_1.script_noteworthy].candisarm;
    var_1.trap.istrap = 1;

    if(isDefined(level.tripwires.traptypes[var_1.script_noteworthy].disarmfunc)) {
      thread disarmfuncthink(var_1.trap, level.tripwires.traptypes[var_1.script_noteworthy].disarmfunc);
    }

    if(isDefined(var_1.script_parameters)) {
      var_3 = strtok(var_1.script_parameters, " ");
      var_1.trap.grenadeweaponoverride = var_3[0];
    }

    var_1.trap.parenttripwires = [];
    level.tripwires.traps = scripts\engine\utility::array_add(level.tripwires.traps, var_1.trap);
  }

  var_1.trap.parenttripwires = scripts\engine\utility::array_add(var_1.trap.parenttripwires, var_2);
  return var_1.trap;
}

function getnormtripwirelength() {
  return scripts\engine\math::normalize_value(10, 300, self.length);
}

function tripwirehastraps() {
  foreach(var_1 in self.targets) {
    if(isDefined(var_1.istrap) && !isDefined(var_1.triggered)) {
      return true;
    }
  }

  return false;
}

function gettripwiretraps() {
  var_0 = [];

  foreach(var_2 in self.targets) {
    if(isDefined(var_2.istrap) && !isDefined(var_2.triggered)) {
      var_0 = scripts\engine\utility::array_add(var_0, var_2);
    }
  }

  return var_0;
}

function triggertripwirefuncthink(var_0) {
  for(;;) {
    self waittill("trigger", var_1, var_2, var_3);

    if(var_2) {
      break;
    }

    if(!tripwirehastraps()) {
      break;
    }
  }

  if(isDefined(var_1)) {
    var_1.lasttriptime = gettime();
  }

  self notify("tripwire_trigger");
  self.triggered = 1;
  thread trapdangerzoneproc();
  self[[var_0]](var_1, var_2, var_3);
}

function trapdangerzoneproc() {
  if(!tripwirehastraps()) {
    return;
  }

  var_0 = gettripwiretraps();

  foreach(var_2 in var_0) {
    thread spawntrapdangerzone();
  }
}

function spawntrapdangerzone() {
  var_0 = spawn("trigger_radius", self.origin, 0, 300, 300);
  level.tripwires.dangerzones = scripts\engine\utility::array_add(level.tripwires.dangerzones, var_0);
  wait 1;
  level.tripwires.dangerzones = scripts\engine\utility::array_remove(level.tripwires.dangerzones, var_0);
  var_0 delete();
}

function playerintripwiredangerzone() {
  if(!isDefined(level.tripwires)) {
    return false;
  }

  foreach(var_1 in level.tripwires.dangerzones) {
    if(level.player istouching(var_1)) {
      return true;
    }
  }

  return false;
}

function triggertrapfuncthink(var_0) {
  for(;;) {
    self waittill("trigger", var_1, var_2);

    if(var_2) {
      break;
    }
  }

  self notify("trap_trigger");
  self.triggered = 1;

  if(isDefined(self.defusehintstruct) && !isDefined(self.defusehintstruct.defused)) {
    self.defusehintstruct scripts\sp\player\cursor_hint::remove_cursor_hint();
  }

  self[[var_0]](var_1);
}

function gettriggerfunc(var_0) {
  switch (var_0) {
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

function gettripwiretriggeranim(var_0) {
  switch (var_0) {
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

function gettripwirestaticmodel(var_0) {
  switch (var_0) {
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

function gettripwirestretchanim(var_0) {
  switch (var_0) {
    case "ceiling":
      return % tripwire_trigger_standard_stretch;
    case "floor":
      return % tripwire_trigger_standard_stretch;
    case "wall":
      return % tripwire_trigger_standard_stretch;
  }
}

function gettripwiremodel(var_0) {
  if(isDefined(var_0)) {}

  switch (var_0) {
    case "ceiling":
      return "equipment_wm_tripwire_standard";
    case "floor":
      return "equipment_wm_tripwire_standard";
    case "wall":
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

function triggerfunctripwire(var_0, var_1, var_2) {
  self.trigger delete();
  self setanimrate(self.triggeranim, 1);
  self setanim(%tripwire_stretch_overlay, 0, 0.2, 0);
  thread swaptostaticmodel();
  var_3 = gettripwiretriggersound(var_2);
  thread scripts\engine\utility::play_sound_in_space(var_3, self.origin);

  if(isDefined(self.finalangles)) {
    thread rotatetofinalangles();
  }

  if(var_0 == level.player) {
    level.player playRumbleOnEntity("damage_light");
    earthquake(0.1, 0.2, level.player.origin, 2000);
  }

  wait self.delay;

  if(isDefined(self.navmodifier)) {
    destroynavobstacle(self.navmodifier);
  }

  var_2 = 0;

  foreach(var_5 in self.targets) {
    var_5 notify("trigger", var_0, var_1, var_2);
  }
}

function rotatetofinalangles() {
  self endon("death");
  wait 0.25;
  self rotateTo(self.finalangles, 0.25);
}

function swaptostaticmodel() {
  var_0 = getanimlength(self.triggeranim);
  wait var_0;
  self setModel(self.staticmodel);
}

function triggerfuncsemtex(var_0) {
  if(isDefined(self.grenadeweaponoverride)) {
    var_1 = self.grenadeweaponoverride;
  } else {
    var_1 = "semtex_tripwire";
  }

  var_2 = magicgrenademanual(var_1, self.origin, (0, 0, 0), 0.25);
  var_2.angles = self.angles;
  var_2.origin = self.origin;
  var_2 linkTo(self);
  self hide();
  thread death_hint_think(60, "MOD_GRENADE_SPLASH");
  var_2 waittill("explode");
  level notify("tripwire_grenade_explode", self);
  playrumbleonposition("grenade_rumble", self.origin);
  earthquake(0.45, 0.7, self.origin, 800);
  wait 0.1;
  self notify("cancel_death_hint");
  self delete();
}

function triggerfuncfrag(var_0) {
  if(isDefined(self.grenadeweaponoverride)) {
    var_1 = self.grenadeweaponoverride;
  } else {
    var_1 = "frag_tripwire";
  }

  var_2 = magicgrenademanual(var_1, self.origin, (0, 0, 0), 0.25);
  var_2.angles = self.angles;
  var_2.origin = self.origin;
  var_2 linkTo(self);
  self hide();
  thread death_hint_think(60, "MOD_GRENADE_SPLASH");
  var_2 waittill("explode");
  level notify("tripwire_grenade_explode", self);
  playrumbleonposition("grenade_rumble", self.origin);
  earthquake(0.45, 0.7, self.origin, 800);
  wait 0.1;
  self notify("cancel_death_hint");
  self delete();
}

function triggerfuncc4(var_0) {
  if(isDefined(self.grenadeweaponoverride)) {
    var_1 = self.grenadeweaponoverride;
  } else {
    var_1 = "c4_sp_tripwire";
  }

  var_2 = magicgrenademanual(var_1, self.origin, (0, 0, 0), 0.25);
  var_2.angles = self.angles;
  var_2.origin = self.origin;
  thread scripts\engine\utility::play_sound_in_space("minefield_click", self.origin);
  var_2 linkTo(self);
  self hide();
  var_2 setscriptablepartstate("plant", "active", 0);
  var_2 waittill("explode");
  thread scripts\engine\utility::play_sound_in_space("frag_grenade_expl_trans", self.origin);
  playrumbleonposition("grenade_rumble", self.origin);
  earthquake(0.45, 0.7, self.origin, 800);
  self delete();
}

function death_hint_think(var_0, var_1) {
  self endon("cancel_death_hint");
  level.player waittill("death", var_2, var_3, var_4, var_5, var_6);

  if(var_3 == var_1) {
    scripts\sp\player_death::set_custom_death_quote(var_0);
    return;
  }
}

function damagetrapfuncthink(var_0, var_1) {
  self endon("trap_trigger");
  self setCanDamage(1);
  self.health = 99999;

  for(;;) {
    self waittill("damage", var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14, var_15);

    if(candamagetrap(var_3, var_6, var_2)) {
      break;
    }

    self.health += var_2;
  }

  self.triggered = 1;

  if(isDefined(self.defusehintstruct) && !isDefined(self.defusehintstruct.defused)) {
    self.defusehintstruct scripts\sp\player\cursor_hint::remove_cursor_hint();
  }

  var_16 = 0;
  var_17 = 1;

  foreach(var_19 in self.parenttripwires) {
    var_19 notify("trigger", var_3, var_16, var_17);
  }

  self notify("trigger", var_3, 1);
}

function candamagetrap(var_0, var_1, var_2) {
  if(!isDefined(var_0)) {
    return false;
  }

  if(var_0 == level.player && (var_1 == "MOD_GRENADE_SPLASH" || var_1 == "MOD_PROJECTILE_SPLASH") && var_2 > 150) {
    if(level.player getplayerprogression("achievementBoom") != "true") {
      thread trapachievementboom();
    }

    return true;
  }

  return false;
}

function trapachievementboom() {
  var_0 = strtok(level.player getplayerprogression("achievementBoom"), ",");
  var_1 = "" + self.origin[0] + self.origin[1];

  if(level.player getplayerprogression("achievementBoom") == "") {
    level.player setplayerprogression("achievementBoom", var_1);
    return;
  }

  if(var_0.size == 1 && var_0[0] != var_1) {
    level.player setplayerprogression("achievementBoom", var_0[0] + "," + var_1);
    return;
  }

  if(var_0.size == 2 && !isstartstr(var_0[0], var_1) && !isstartstr(var_0[1], var_1)) {
    level.player setplayerprogression("achievementBoom", "true");
    level thread scripts\sp\utility::giveachievement_wrapper("boom");
    return;
  }
}

function disarmfuncthink(var_0, var_1) {
  self endon("trap_trigger");

  if(isDefined(var_1.radius)) {
    var_2 = var_1.radius;
  } else {
    var_2 = 64;
  }

  var_3 = (0, 0, 0);
  self.defusehintstruct = var_2 scripts\engine\utility::spawn_script_origin();
  self.defusehintstruct scripts\sp\player\cursor_hint::create_cursor_hint(undefined, var_3, &"SCRIPT/DEFUSE", 2, var_2, 64, 0, 0, 0, undefined, "duration_medium");
  self.defusehintstruct waittill("trigger", var_4);
  level.lasttripwiredefusedtime = gettime();
  self.defusehintstruct.defused = 1;
  self.triggered = 1;
  var_5 = 0;
  var_6 = 1;

  foreach(var_8 in self.parenttripwires) {
    var_8 notify("trigger", var_4, var_5, var_6);
  }

  self[[var_1]](var_4);
}

function getdisarmfunc(var_0) {
  switch (var_0) {
    case "tripwire_trap_semtex":
      return &disarmfuncsemtex;
    case "tripwire_trap_frag":
      return &disarmfuncfrag;
    default:
      break;
  }
}

function disarmfuncsemtex(var_0) {
  disarmgiveweapon(var_0, "semtex", "Semtex");
  self delete();
}

function disarmfuncfrag(var_0) {
  disarmgiveweapon(var_0, "frag", "M67 Frag");
  self delete();
}

function disarmgiveweapon(var_0, var_1) {
  if(self == level.player) {
    if(!hasequipmentoftype(var_0)) {
      level.player scripts\engine\sp\utility::give_offhand(var_0);
      level.player setweaponammoclip(var_0, 0);
    }

    if(scripts\engine\sp\utility::player_has_equipment(var_0)) {
      scripts\sp\loot::lootfuncandnotification(var_1);
      return;
    }

    return;
  }
}

function hasequipmentoftype(var_0) {
  var_1 = var_0;

  if(isstring(var_0)) {
    var_1 = asmdevgetallstates(var_0);
  }

  var_2 = level.player.offhandinventory;

  foreach(var_4 in var_2) {
    if(issameoffhandtype(var_4, var_1)) {
      return true;
    }
  }

  return false;
}

function issameoffhandtype(var_0, var_1) {
  if(scripts\sp\equipment\offhands::getweaponoffhandtype(var_0) == scripts\sp\equipment\offhands::getweaponoffhandtype(var_1)) {
    return true;
  }

  return false;
}