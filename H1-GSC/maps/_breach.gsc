/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\_breach.gsc
********************************/

main() {
  level._effect["_breach_doorbreach_detpack"] = loadfx("fx\explosions\exp_pack_doorbreach");
  level._effect["_breach_doorbreach_kick"] = loadfx("fx\dust\door_kick");
  level.scr_sound["_breach_doorbreach_detpack"] = "detpack_explo_main";
  level.scr_sound["breach_wooden_door"] = "";
  level.scr_sound["breach_wood_door_kick"] = "wood_door_kick";
  common_scripts\utility::array_call(getentarray("breached_door", "script_noteworthy"), ::hide);
  common_scripts\utility::array_call(getentarray("breached_door", "script_noteworthy"), ::notsolid);
  common_scripts\utility::flag_init("begin_the_breach");
}

breach_think(var_0, var_1, var_2, var_3, var_4, var_5) {
  self endon("breach_abort");

  if(isdefined(var_5) && var_5 == 0)
    anim.fire_notetrack_functions["scripted"] = ::breach_fire_straight;

  self.flashthrown = 0;
  self.closestai = undefined;
  self.animent = undefined;
  self.breached = 0;
  self.breachers = 0;
  self.breachersready = 0;
  self.singlebreacher = 0;
  self.readytobreach = 0;
  self.aiareintheroom = 0;
  self.abouttobebreached = 0;
  self.cleared = 0;
  self.hasdoor = 1;
  self.hasflashbangs = 0;
  self.hostilesspawned = 0;
  var_6 = getentarray(self.targetname, "targetname");
  var_7 = self.targetname;
  self.sbadplacename = "badplace_" + var_7;
  self.badplace = getent("badplace_" + var_7, "targetname");

  if(isdefined(self.badplace)) {}

  self.breachtrigger = getent("trigger_" + var_7, "targetname");

  if(!isdefined(var_4))
    var_4 = 1;

  if(isdefined(self.breachtrigger)) {
    switch (self.breachtrigger.classname) {
      case "trigger_use":
        self.triggerhintstring = var_2;
        break;
      case "trigger_use_touch":
        self.triggerhintstring = var_2;
        break;
      case "trigger_radius":
        break;
      case "trigger_multiple":
        break;
      default:
        break;
    }
  }

  switch (var_1) {
    case "explosive_breach_left":
      break;
    case "shotgunhinges_breach_left":
      break;
    case "flash_breach_no_door_right":
      self.hasdoor = 0;
      self.hasflashbangs = 1;
      break;
    default:
      break;
  }

  if(self.hasdoor == 1) {
    var_8 = undefined;

    if(isdefined(self.target))
      var_8 = getent(self.target, "targetname");

    if(isdefined(var_8) && isdefined(var_8.script_noteworthy) && var_8.script_noteworthy == "breach_anim_ent")
      self.animent = var_8;

    self.edoor = getent(self.script_linkto, "script_linkname");

    if(self.edoor.classname == "script_model") {
      self.edoorpivot = spawn("script_origin", self.edoor.origin);
      self.edoorpivot.angles = self.edoor.angles;
    } else if(self.edoor.classname == "script_brushmodel" && !isdefined(self.animent)) {
      self.edoorpivot = getent(self.edoor.target, "targetname");
      self.edoor.vector = anglestoforward(self.edoorpivot.angles);
    }

    if(!isdefined(self.animent))
      self.animent = self.edoorpivot;

    self.animent.type = "Cover Right";
    self.eexploderorigin = getent(self.edoor.script_linkto, "script_linkname");
    self.iexplodernum = self.eexploderorigin.script_exploder;

    if(isdefined(self.eexploderorigin.script_linkto)) {
      var_9 = getent(self.eexploderorigin.script_linkto, "script_linkname");

      if(isdefined(var_9) && isdefined(var_9.script_noteworthy) && var_9.script_noteworthy == "breached_door")
        self.ebreacheddoor = var_9;
    }
  } else if(self.hasdoor == 0)
    self.animent = getent(self.script_linkto, "script_linkname");

  if(self.hasflashbangs == 1) {
    self.grenadeorigin = getent("flashthrow_" + var_7, "targetname");
    self.grenadedest = getent(self.grenadeorigin.target, "targetname");
  }

  thread breach_abort(var_0);
  thread breach_cleanup(var_0);
  thread breach_play_fx(var_1, var_4);
  var_10 = 0;

  for (var_11 = 0; var_11 < var_0.size; var_11++) {
    if(isdefined(var_0[var_11].firstbreacher)) {
      var_10++;
      self.closestai = var_0[var_11];
    }
  }

  if(var_10 > 0) {} else
    self.closestai = common_scripts\utility::getclosest(self.edoorpivot.origin, var_0);

  if(var_0.size == 1)
    self.singlebreacher = 1;

  for (var_11 = 0; var_11 < var_0.size; var_11++)
    var_0[var_11] thread breacher_think(self, var_1, var_5);

  while (self.breachers < var_0.size)
    wait 0.05;

  self notify("ready_to_breach");
  self.readytobreach = 1;

  if(isdefined(self.breachtrigger)) {
    self.breachtrigger thread breach_trigger_think(self);
    self waittill("execute_the_breach");
  } else
    self notify("execute_the_breach");

  common_scripts\utility::flag_set("begin_the_breach");
  self.abouttobebreached = 1;

  if(isdefined(var_3) && var_3 == 1) {
    var_12 = getentarray("hostiles_" + var_7, "targetname");
    self waittill("spawn_hostiles");
    spawnbreachhostiles(var_12);
    self.hostilesspawned = 1;
  }

  if(isdefined(self.badplace))
    badplace_cylinder(self.sbadplacename, -1, self.badplace.origin, self.badplace.radius, 200, "bad_guys");

  var_13 = getaiarray("bad_guys");
  var_14 = [];

  for (var_11 = 0; var_11 < var_13.size; var_11++) {
    if(var_13[var_11] istouching(self))
      var_14[var_14.size] = var_13[var_11];
  }

  if(var_14.size > 0)
    common_scripts\utility::array_thread(var_14, ::breach_enemies_stunned, self);

  while (!self.aiareintheroom)
    wait 0.05;

  self notify("breach_complete");

  if(!var_14.size) {
    return;
  }
  while (!self.cleared) {
    wait 0.05;

    for (var_11 = 0; var_11 < var_14.size; var_11++) {
      if(!isalive(var_14[var_11]))
        var_14 = common_scripts\utility::array_remove(var_14, var_14[var_11]);

      if(var_14.size == 0)
        self.cleared = 1;
    }
  }
}

breach_dont_fire() {
  while (self.breaching == 1) {
    self waittillmatch("single anim", "fire");
    self.a.lastshoottime = gettime();
  }
}

breacher_think(var_0, var_1, var_2) {
  self.breaching = 1;
  self.breachdonotfire = undefined;

  if(!isdefined(var_2))
    var_2 = 1;

  self pushplayer(1);
  thread give_infinite_ammo();
  var_0 endon("breach_abort");
  self.ender = "stop_idle_" + self getentitynumber();
  var_3 = undefined;
  var_4 = undefined;
  var_5 = undefined;
  var_6 = undefined;
  var_7 = undefined;

  if(self == var_0.closestai)
    var_3 = "01";
  else
    var_3 = "02";

  if(var_0.singlebreacher == 1 && var_1 == "explosive_breach_left")
    var_3 = "02";

  switch (var_1) {
    case "explosive_breach_left":
      if(isdefined(self.usebreachapproach) && self.usebreachapproach == 0)
        var_4 = "detcord_stack_left_start_no_approach_" + var_3;
      else
        var_4 = "detcord_stack_left_start_" + var_3;

      var_5 = "detcord_stack_leftidle_" + var_3;
      var_6 = "detcord_stack_leftbreach_" + var_3;
      break;
    case "shotgunhinges_breach_left":
      var_4 = "shotgunhinges_breach_left_stack_start_" + var_3;
      var_5 = "shotgunhinges_breach_left_stack_idle_" + var_3;
      var_6 = "shotgunhinges_breach_left_stack_breach_" + var_3;
      break;
    case "flash_breach_no_door_right":
      if(var_0.singlebreacher == 1) {
        var_4 = "flash_stack_right_start_single";
        var_5 = "flash_stack_right_idle_single";
        var_6 = "flash_stack_right_breach_single";
        var_7 = "flash_stack_right_flash_single";
      } else {
        var_4 = "flash_stack_right_start_" + var_3;
        var_5 = "flash_stack_right_idle_" + var_3;
        var_6 = "flash_stack_right_breach_" + var_3;
        var_7 = "flash_stack_right_flash_" + var_3;
      }

      break;
    default:
      break;
  }

  breach_set_goaladius(64);

  if(!isdefined(self.usebreachapproach) || self.usebreachapproach)
    var_0.animent maps\_anim::anim_generic_reach(self, var_4);
  else {
    self.scriptedarrivalent = var_0.animent;
    var_0.animent maps\_anim::anim_generic_reach_and_arrive(self, var_4);
  }

  var_0.animent maps\_anim::anim_generic(self, var_4);
  var_0.animent thread maps\_anim::anim_generic_loop(self, var_5, self.ender);
  self.setgoalpos = self.origin;
  var_0.breachers++;
  self.scriptedarrivalent = undefined;
  var_0 waittill("execute_the_breach");

  if(!var_0.flashthrown && isdefined(var_7)) {
    var_0.animent notify(self.ender);
    var_0.animent thread maps\_anim::anim_generic(self, var_7);
    wait 1;

    if(var_3 == "02" || var_0.singlebreacher == 1) {
      var_8 = "J_Mid_LE_1";
      self attach("projectile_m84_flashbang_grenade", var_8);
      var_9 = self.grenadeweapon;
      self.grenadeweapon = "flash_grenade";
      self.grenadeammo++;

      if(var_3 == "02")
        self waittillmatch("single anim", "grenade_throw");

      if(var_0.singlebreacher == 1 && var_3 == "01")
        self waittillmatch("single anim", "fire");

      self magicgrenade(var_0.grenadeorigin.origin, var_0.grenadedest.origin, level.iflashfuse);
      self detach("projectile_m84_flashbang_grenade", var_8);
      self.grenadeweapon = var_9;
      self.grenadeammo = 0;
    }

    self waittillmatch("single anim", "end");
    var_0.animent thread maps\_anim::anim_generic_loop(self, var_5, self.ender);
    wait 0.1;
  }

  var_0.animent notify(self.ender);

  if(var_2 == 0)
    self.breachdonotfire = 1;

  var_0.animent thread maps\_anim::anim_generic(self, var_6);

  if(var_1 == "explosive_breach_left") {
    if(var_3 == "02") {
      var_0.edoor thread door_animation("explosive", var_0);
      thread detcord_logic(var_0);
      self waittillmatch("single anim", "pull fuse");
      wait 1;
      var_0 notify("spawn_hostiles");
      var_0 notify("detpack_about_to_blow");
      self waittillmatch("single anim", "explosion");
      var_0 notify("detpack_detonated");
      var_0.breached = 1;
      var_0.edoor thread door_open("explosive", var_0);
      var_0 notify("play_breach_fx");
    }
  } else if(var_1 == "shotgunhinges_breach_left") {
    if(var_3 == "01") {
      var_0.edoor thread door_animation("shotgun", var_0);
      var_0 notify("spawn_hostiles");
      self waittillmatch("single anim", "kick");
      var_0.edoor thread door_open("shotgun", var_0);
      var_0 notify("play_breach_fx");
    }
  } else if(var_1 == "flash_breach_no_door_right") {}

  self waittillmatch("single anim", "end");
  self notify("breach_complete");

  if(var_2 == 0)
    self.breachdonotfire = undefined;

  if(isdefined(level.friendly_breach_thread))
    self thread[[level.friendly_breach_thread]](var_0);

  var_0.aiareintheroom = 1;
  self pushplayer(0);
  breach_reset_animname();

  while (!var_0.cleared)
    wait 0.05;

  self.breaching = 0;
}

breach_fire_straight() {
  if(isdefined(self.breachdonotfire)) {
    return;
  }
  animscripts\notetracks::fire_straight();
}

detcord_logic(var_0) {
  thread sound_effect_play(var_0);
  self waittillmatch("single anim", "attach prop right");
  var_1 = "TAG_INHAND";
  self attach("weapon_detcord", var_1);
  self waittillmatch("single anim", "detach prop right");
  var_2 = self gettagorigin(var_1);
  var_3 = self gettagangles(var_1);
  self detach("weapon_detcord", var_1);
  var_4 = spawn("script_model", var_2);
  var_4 setmodel("weapon_detcord");
  var_4.angles = var_3;
  var_0 waittill("detpack_detonated");
  radiusdamage(var_4.origin, 64, 50, 25);
  var_4 delete();
}

sound_effect_play(var_0) {
  self waittillmatch("single anim", "sound effect");
  thread common_scripts\utility::play_sound_in_space("detpack_plant_arming", var_0.edoorpivot.origin);
}

breach_enemies_stunned(var_0) {
  self endon("death");
  var_0 endon("breach_aborted");
  var_0 waittill("detpack_detonated");

  if(distance(self.origin, var_0.edoorpivot.origin) <= level.detpackstunradius) {
    level.stunnedanimnumber++;

    if(level.stunnedanimnumber > 2)
      level.stunnedanimnumber = 1;

    var_1 = "exposed_flashbang_v" + level.stunnedanimnumber;
    self.allowdeath = 1;
    maps\_anim::anim_generic_custom_animmode(self, "gravity", var_1);
    breach_reset_animname();
  }
}

breach_trigger_think(var_0) {
  var_0 endon("execute_the_breach");
  var_0 endon("breach_aborted");
  thread breach_trigger_cleanup(var_0);
  self waittill("trigger");
  var_0 notify("execute_the_breach");
}

breach_trigger_cleanup(var_0) {
  var_0 waittill("execute_the_breach");
  common_scripts\utility::trigger_off();

  if(isdefined(var_0.ebreachmodel))
    var_0.ebreachmodel delete();
}

breach_abort(var_0) {
  self endon("breach_complete");
  self waittill("breach_abort");
  self.cleared = 1;
  thread breach_cleanup(var_0);
}

breach_cleanup(var_0) {
  while (!self.cleared)
    wait 0.05;

  if(isdefined(self.badplace))
    badplace_delete(self.sbadplacename);

  while (!self.cleared)
    wait 0.05;

  common_scripts\utility::array_thread(var_0, ::breach_ai_reset, self);
}

breach_ai_reset(var_0) {
  self endon("death");
  breach_reset_animname();
  breach_reset_goaladius();
  var_0.animent notify(self.ender);
  self notify("stop_infinite_ammo");
  self pushplayer(0);
}

breach_play_fx(var_0, var_1) {
  self endon("breach_aborted");
  self endon("breach_complete");

  switch (var_0) {
    case "explosive_breach_left":
      self waittill("play_breach_fx");
      common_scripts\_exploder::exploder(self.iexplodernum);
      thread common_scripts\utility::play_sound_in_space(level.scr_sound["breach_wooden_door"], self.eexploderorigin.origin);
      thread common_scripts\utility::play_sound_in_space(level.scr_sound["_breach_doorbreach_detpack"], self.eexploderorigin.origin);

      if(var_1)
        playfx(level._effect["_breach_doorbreach_detpack"], self.eexploderorigin.origin, anglestoforward(self.eexploderorigin.angles));

      break;
    case "shotgunhinges_breach_left":
      self waittill("play_breach_fx");
      common_scripts\_exploder::exploder(self.iexplodernum);

      if(var_1)
        playfx(level._effect["_breach_doorbreach_kick"], self.eexploderorigin.origin, anglestoforward(self.eexploderorigin.angles));

      break;
    case "flash_breach_no_door_right":
      break;
    default:
      break;
  }
}

spawnhostile(var_0) {
  var_1 = var_0 dospawn();
  maps\_utility::spawn_failed(var_1);
  return var_1;
}

spawnbreachhostiles(var_0) {
  var_1 = [];

  for (var_2 = 0; var_2 < var_0.size; var_2++) {
    var_3 = spawnhostile(var_0[var_2]);
    var_1[var_1.size] = var_3;
  }

  return var_1;
}

give_infinite_ammo() {
  self endon("death");
  self endon("stop_infinite_ammo");

  while (isdefined(self.weapon)) {
    if(isdefined(self.weapon) && self.weapon == "none") {
      break;
    }

    self.bulletsinclip = weaponclipsize(self.weapon);
    wait 0.5;
  }
}

door_animation(var_0, var_1) {
  var_2 = "breach_door";

  if(!isdefined(level.scr_anim[var_2])) {
    return;
  }
  var_3 = undefined;

  switch (var_0) {
    case "explosive":
      var_3 = "explosive_breach_left_door";
      break;
    case "shotgun":
      var_3 = "shotgunhinges_breach_left_door";
      break;
  }

  if(!isdefined(var_3)) {
    return;
  }
  if(!isdefined(level.scr_anim[var_2][var_3])) {
    return;
  }
  var_4 = common_scripts\utility::ter_op(isdefined(var_1.ebreacheddoor), var_1.ebreacheddoor, self);
  var_4 maps\_utility::assign_animtree(var_2);
  var_4 thread maps\_anim::anim_single_solo(var_4, var_3);
  var_1.isdooranimated = 1;
}

door_open(var_0, var_1, var_2) {
  var_3 = self;

  if(isdefined(var_1.ebreacheddoor)) {
    self hide();
    self notsolid();
    var_1.ebreacheddoor show();
    var_1.ebreacheddoor solid();
    var_3 = var_1.ebreacheddoor;
  }

  if(!isdefined(var_2))
    var_2 = 1;

  if(var_2 == 1)
    self playsound(level.scr_sound["breach_wood_door_kick"]);

  switch (var_0) {
    case "explosive":
      if(!isdefined(var_1.isdooranimated) || !var_1.isdooranimated)
        var_3 thread door_fall_over(var_1.edoorpivot);

      door_connectpaths();
      self playsound(level.scr_sound["breach_wooden_door"]);
      earthquake(0.4, 1, self.origin, 1000);
      radiusdamage(self.origin, 56, level.maxdetpackdamage, level.mindetpackdamage);
      break;
    case "shotgun":
      if(!isdefined(var_1.isdooranimated) || !var_1.isdooranimated)
        var_3 thread door_fall_over(var_1.edoorpivot);

      door_connectpaths();
      self playsound(level.scr_sound["breach_wooden_door"]);
      break;
  }
}

door_connectpaths() {
  if(self.classname == "script_brushmodel")
    self connectpaths();
  else {
    var_0 = getent(self.target, "targetname");
    var_0 hide();
    var_0 notsolid();
    var_0 connectpaths();
  }
}

door_fall_over(var_0) {
  var_1 = undefined;

  if(self.classname == "script_model")
    var_1 = anglestoforward(self.angles);
  else if(self.classname == "script_brushmodel")
    var_1 = self.vector;
  else {}

  var_2 = (var_1[0] * 20, var_1[1] * 20, var_1[2] * 20);
  self moveto(self.origin + var_2, 0.5, 0, 0.5);
  var_3 = spawn("script_origin", (0, 0, 0));
  var_3.angles = var_0.angles;
  var_3.origin = (self.origin[0], self.origin[1], var_0.origin[2]);
  self linkto(var_3);
  var_3 rotatepitch(90, 0.45, 0.4);
  wait 0.45;
  var_3 rotatepitch(-4, 0.2, 0, 0.2);
  wait 0.2;
  var_3 rotatepitch(4, 0.15, 0.15);
  wait 0.15;
  self unlink();
  var_3 delete();
}

breach_set_goaladius(var_0) {
  if(!isdefined(self.old_goalradius))
    self.old_goalradius = self.goalradius;

  self.goalradius = var_0;
}

breach_reset_goaladius() {
  if(isdefined(self.old_goalradius))
    self.goalradius = self.old_goalradius;

  self.old_goalradius = undefined;
}

breach_set_animname(var_0) {
  if(!isdefined(self.old_animname))
    self.old_animname = self.animname;

  self.animname = var_0;
}

breach_reset_animname() {
  if(isdefined(self.old_animname))
    self.animname = self.old_animname;

  self.old_animname = undefined;
}