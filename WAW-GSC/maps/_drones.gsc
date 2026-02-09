/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_drones.gsc
**************************************/

#include maps\_utility;
#include animscripts\Utility;
#include animscripts\SetPoseMovement;
#include animscripts\Combat_utility;
#include animscripts\shared;
#include common_scripts\Utility;
#include maps\_spawner;
#using_animtree("fakeshooters");
init() {
  if(getdebugdvar("replay_debug") == "1") {
    println("File: _drones.gsc. Function: init()\n");
  }

  if(getDvar("r_reflectionProbeGenerate") == "1") {
    return;
  }

  setAnimArray();
  level.drone_impact = loadfx("impacts/flesh_hit");
  level.drone_muzzleflash = loadfx("weapon/muzzleflashes/standardflashworld");

  if(!isDefined(level.traceHeight)) {
    level.traceHeight = 400;
  }

  if(!isDefined(level.droneStepHeight)) {
    level.droneStepHeight = 100;
  }

  if(!isDefined(level.max_drones)) {
    level.max_drones = [];
  }

  if(!isDefined(level.max_drones["axis"])) {
    level.max_drones["axis"] = 32;
  }
  if(level.max_drones["axis"] > 32) {
    level.max_drones["axis"] = 32;
  }
  if(!isDefined(level.max_drones["allies"])) {
    level.max_drones["allies"] = 32;
  }
  if(level.max_drones["allies"] > 32) {
    level.max_drones["allies"] = 32;
  }
  if(isSplitScreen()) {
    level.max_drones["axis"] = 8;
    level.max_drones["allies"] = 8;
  }

  if(!isDefined(level.drones)) {
    level.drones = [];
  }

  if(!isDefined(level.drones["axis"])) {
    level.drones["axis"] = struct_arrayspawn();
  }

  if(!isDefined(level.drones["allies"])) {
    level.drones["allies"] = struct_arrayspawn();
  }

  init_struct_targeted_origins();

  array_thread(getEntArray("drone_axis", "targetname"), ::drone_triggers_think);
  array_thread(getEntArray("drone_allies", "targetname"), ::drone_triggers_think);

  if(getdebugdvar("replay_debug") == "1") {
    println("File: _drones.gsc. Function: init() - COMPLETE\n");
  }
}

build_struct_targeted_origins() {
  if(!isDefined(self.target)) {
    return;
  }

  self.targeted = level.struct_targetname[self.target];

  if(!isDefined(self.targeted)) {
    self.targeted = [];
  }
}

init_struct_targeted_origins() {
  level.struct_targetname = [];

  count = level.struct.size;

  for(i = 0; i < count; i++) {
    struct = level.struct[i];
    if(!isDefined(struct.targetname)) {
      continue;
    }
    struct_targetname = level.struct_targetname[struct.targetname];
    if(!isDefined(struct_targetname)) {
      targetname_count = 0;
    } else {
      targetname_count = struct_targetname.size;
    }
    level.struct_targetname[struct.targetname][targetname_count] = struct;
  }

  for(i = 0; i < count; i++) {
    struct = level.struct[i];
    if(!isDefined(struct.target)) {
      continue;
    }
    struct.targeted = level.struct_targetname[struct.target];
  }
}

drone_triggers_think() {
  self endon("death");

  if(self.targetname == "drone_allies") {
    team = "allies";
  } else {
    team = "axis";
  }

  self build_struct_targeted_origins();

  qFakeDeath = true;
  if((isDefined(self.script_allowdeath)) && (self.script_allowdeath == 0)) {
    qFakeDeath = false;
  }

  qSightTrace = false;
  if((isDefined(self.script_trace)) && (self.script_trace > 0)) {
    qSightTrace = true;
  }

  assert(isDefined(self.targeted));
  assert(isDefined(self.targeted[0]));

  if(isDefined(self.script_ender)) {
    level endon(self.script_ender);
  }

  self waittill("trigger");

  if(!isDefined(self.script_repeat)) {
    repeat_times = 999999;
  } else {
    repeat_times = self.script_repeat;
  }

  if(((isDefined(self.script_noteworthy)) && (self.script_noteworthy == "looping")) || ((isDefined(self.script_looping)) && (self.script_looping > 0))) {
    assert(isDefined(self.script_delay) || (isDefined(self.script_delay_min) && isDefined(self.script_delay_max)));
    self endon("stop_drone_loop");
    for(i = 0; i < repeat_times; i++) {
      level notify("new drone spawn wave");

      spawnSize = undefined;
      if(isDefined(self.script_drones_min)) {
        max = self.targeted.size;
        if(isDefined(self.script_drones_max)) {
          max = self.script_drones_max;
        }
        if(self.script_drones_min == max) {
          spawnSize = max;
        } else {
          spawnSize = (self.script_drones_min + randomint(max - self.script_drones_min));
        }
      }

      self thread drone_spawngroup(self.targeted, qFakeDeath, spawnSize, qSightTrace, team);

      if(isDefined(self.script_delay)) {
        if(self.script_delay < 0) {
          return;
        }
        wait(self.script_delay);
      } else {
        wait(self.script_delay_min + randomfloat(self.script_delay_max - self.script_delay_min));
      }
      if((isDefined(self.script_requires_player)) && (self.script_requires_player > 0)) {
        self waittill("trigger");
      }

      if(!isDefined(self.script_repeat)) {
        repeat_times = 999999;
      }
    }
  } else {
    spawnSize = undefined;
    if(isDefined(self.script_drones_min)) {
      max = self.targeted.size;
      if(isDefined(self.script_drones_max)) {
        max = self.script_drones_max;
      }
      if(self.script_drones_min == max) {
        spawnSize = max;
      } else {
        spawnSize = (self.script_drones_min + randomint(max - self.script_drones_min));
      }
    }

    self drone_triggers_delay_first_spawn();

    self thread drone_spawngroup(self.targeted, qFakeDeath, spawnSize, qSightTrace, team);

    if(isDefined(self.count) && self.count > 1) {
      wait(0.05);
      self.count--;
      self thread drone_triggers_think();
    }
  }
}
drone_triggers_delay_first_spawn() {
  if(isDefined(self.script_delay)) {
    if(self.script_delay > 0) {
      wait(self.script_delay);
    }
  } else if(isDefined(self.script_delay_min) && isDefined(self.script_delay_max)) {
    if(self.script_delay_max > self.script_delay_min) {
      wait(RandomFloatRange(self.script_delay_min, self.script_delay_max));
    }
  }
}

drone_spawngroup(spawnpoint, qFakeDeath, spawnSize, qSightTrace, team) {
  spawncount = spawnpoint.size;
  if(isDefined(spawnSize)) {
    spawncount = spawnSize;
    spawnpoint = array_randomize(spawnpoint);
  }

  if(spawncount > spawnpoint.size) {
    spawncount = spawnpoint.size;
  }

  for(i = 0; i < spawncount; i++) {
    if(isDefined(self.script_int)) {
      wait randomfloat(0.1, 1.0);
    }

    while(!self ok_to_trigger_spawn()) {
      wait_network_frame();
    }

    spawnpoint[i] thread drone_spawn(qFakeDeath, qSightTrace, team);

    level._numTriggerSpawned++;
  }
}

#using_animtree("fakeshooters");
drone_spawn(qFakeDeath, qSightTrace, team) {
  level endon("new drone spawn wave");

  if(!isDefined(qFakeDeath)) {
    qFakeDeath = false;
  }

  if(!isDefined(qSightTrace)) {
    qSightTrace = false;
  }

  while((qSightTrace) && (self spawnpoint_playersView())) {
    wait 0.2;
  }

  if(level.drones[team].lastindex > level.max_drones[team]) {
    return;
  }

  guy = spawn("script_model", groundpos(self.origin));

  if(isDefined(self.angles)) {
    guy.angles = self.angles;
  } else if(isDefined(self.targeted)) {
    guy.angles = VectorToAngles(self.targeted[0].origin - guy.origin);
  }

  assert(isDefined(level.drone_spawnFunction[team]));
  guy[[level.drone_spawnFunction[team]]]();
  guy drone_assign_weapon(team);
  guy.targetname = "drone";
  guy.script_noteworthy = self.script_noteworthy;
  guy MakeFakeAI();
  guy.team = team;
  guy.fakeDeath = qFakeDeath;
  guy.drone_run_cycle = % combat_run_fast_3;
  guy thread drone_think(self);

  if(guy.fakeDeath && maps\_collectibles::has_collectible("collectible_berserker")) {
    guy thread maps\_collectibles_game::berserker_death();
  }
}

spawnpoint_playersView() {
  if(!isDefined(level.cos80)) {
    level.cos80 = cos(80);
  }

  players = get_players();
  player_view_count = 0;
  success = false;

  for(i = 0; i < players.size; i++) {
    prof_begin("drone_math");
    forwardvec = anglesToForward(players[i].angles);
    normalvec = vectorNormalize(self.origin - players[i] GetOrigin());
    vecdot = vectordot(forwardvec, normalvec);
    prof_end("drone_math");

    if(vecdot > level.cos80) {
      prof_begin("drone_math");
      success = bullettracepassed(players[i] getEye(), self.origin + (0, 0, 48), false, self);
      prof_end("drone_math");

      if(success) {
        player_view_count++;
      }
    }
  }

  if(player_view_count != 0) {
    return true;
  }

  return false;
}

drone_assign_weapon(team) {
  if(team == "allies") {
    if(isDefined(level.drone_weaponlist_allies) && level.drone_weaponlist_allies.size > 0) {
      randWeapon = randomint(level.drone_weaponlist_allies.size);

      self.weapon = level.drone_weaponlist_allies[randWeapon];
      ASSERTEX(isDefined(self.weapon), "_drones::couldn't assign weapon from level.drone_weaponlist because the array value is undefined.");
    } else {
      switch (level.campaign) {
        case "american":
          self.weapon = drone_allies_assignWeapon_american();
          break;
        case "british":
          self.weapon = drone_allies_assignWeapon_british();
          break;
        case "russian":
          self.weapon = drone_allies_assignWeapon_russian();
          break;
      }
    }
  } else {
    if(isDefined(level.drone_weaponlist_axis) && level.drone_weaponlist_axis.size > 0) {
      randWeapon = randomint(level.drone_weaponlist_axis.size);

      self.weapon = level.drone_weaponlist_axis[randWeapon];
      ASSERTEX(isDefined(self.weapon), "_drones::couldn't assign weapon from level.drone_weaponlist because the array value is undefined.");
    } else {
      switch (level.campaign) {
        case "american":
          self.weapon = drone_axis_assignWeapon_japanese();
          break;
        case "british":
          self.weapon = drone_axis_assignWeapon_german();
          break;
        case "russian":
          self.weapon = drone_axis_assignWeapon_german();
          break;
      }
    }
  }

  weaponModel = GetWeaponModel(self.weapon);
  self Attach(weaponModel, "tag_weapon_right");
  self.bulletsInClip = WeaponClipSize(self.weapon);
}

drone_allies_assignWeapon_american() {
  array = [];
  array[array.size] = "m1garand";

  return array[randomint(array.size)];
}

drone_allies_assignWeapon_british() {
  array = [];
  array[array.size] = "lee_enfield";

  return array[randomint(array.size)];
}

drone_allies_assignWeapon_russian() {
  array = [];
  array[array.size] = "mosin_rifle";
  array[array.size] = "ppsh";

  return array[randomint(array.size)];
}

drone_axis_assignWeapon_german() {
  array = [];
  array[array.size] = "kar98k";

  return array[randomint(array.size)];
}

drone_axis_assignWeapon_japanese() {
  array = [];
  array[array.size] = "type99_rifle";

  return array[randomint(array.size)];
}

drone_setName() {
  wait(0.25);
  if(!isDefined(self)) {
    return;
  }

  if(self.team != "allies") {
    return;
  }

  if(!isDefined(level.names)) {
    maps\_names::setup_names();
  }

  if(isDefined(self.script_friendname)) {
    self.name = self.script_friendname;
  } else {
    switch (level.campaign) {
      case "american":
        self maps\_names::get_name_for_nationality("american");
        break;
      case "russian":
        self maps\_names::get_name_for_nationality("russian");
        break;
      case "british":
        self maps\_names::get_name_for_nationality("british");
        break;
    }
  }
  assert(isDefined(self.name));

  subText = undefined;
  if(!isDefined(self.weapon)) {
    subText = (&"WEAPON_RIFLEMAN");
  } else {
    switch (self.weapon) {
      case "m1garand":
      case "m1garand_wet":
      case "lee_enfield":
      case "m1carbine":
      case "SVT40":
      case "mosin_rifle":
        subText = (&"WEAPON_RIFLEMAN");
        break;
      case "thompson":
      case "thompson_wet":
        subText = (&"WEAPON_SUBMACHINEGUNNER");
        break;
      case "BAR":
      case "ppsh":
        subText = (&"WEAPON_SUPPORTGUNNER");
        break;
    }
  }

  if((isDefined(self.model)) && (issubstr(self.model, "medic"))) {
    subText = (&"WEAPON_MEDICPLACEHOLDER");
  }
  assert(isDefined(subText));

  self setlookattext(self.name, subText);
}

drone_think(firstNode) {
  self endon("death");

  self.health = 1000000;
  self thread drone_setName();

  level thread maps\_friendlyfire::friendly_fire_think(self);
  self thread drones_clear_variables();

  structarray_add(level.drones[self.team], self);

  level notify("new_drone");
  if(level.script != "pel1") {
    self.turrettarget = spawn("script_origin", self.origin + (0, 0, 50));
    self.turrettarget linkto(self);
  }
  self endon("drone_death");
  assert(isDefined(firstNode));

  if((isDefined(self.fakeDeath)) && (self.fakeDeath == true)) {
    self thread drone_fakeDeath();
  }

  self endon("drone_shooting");

  if(isDefined(level.drone_think_func)) {
    self[[level.drone_think_func]]();
  }

  self.no_death_sink = false;
  if(isDefined(firstNode.script_drone_no_sink) && firstNode.script_drone_no_sink) {
    self.no_death_sink = true;
  }

  self drone_runChain(firstNode);

  wait(0.05);

  self.running = undefined;

  idle_org = self.origin;
  idle_ang = self.angles;
  self useAnimTree(#animtree);
  idleAnim[0] = % stand_alert_1;
  idleAnim[1] = % stand_alert_2;
  idleAnim[2] = % stand_alert_3;

  while(isDefined(self)) {
    self AnimScripted("drone_idle_anim", idle_org, idle_ang, idleAnim[randomint(idleAnim.size)]);
    self waittillmatch("drone_idle_anim", "end");
  }
}

#using_animtree("fakeshooters");
drone_mortarDeath(direction) {
  self useAnimTree(#animtree);
  switch (direction) {
    case "up":
      self thread drone_doDeath(%death_explosion_up10);
      break;
    case "forward":
      self thread drone_doDeath(%death_explosion_forward13);
      break;
    case "back":
      self thread drone_doDeath(%death_explosion_back13);
      break;
    case "left":
      self thread drone_doDeath(%death_explosion_left11);
      break;
    case "right":
      self thread drone_doDeath(%death_explosion_right13);
      break;
  }
}

#using_animtree("fakeshooters");
drone_fakeDeath(instant) {
  if(!isDefined(instant)) {
    instant = false;
  }

  self endon("delete");
  self endon("drone_death");

  explosivedeath = false;
  explosion_ori = (0, 0, 0);
  flamedeath = false;

  while(isDefined(self)) {
    if(!instant) {
      self setCanDamage(true);
      self waittill("damage", amount, attacker, direction_vec, damage_ori, type);

      if(type == "MOD_GRENADE" || type == "MOD_GRENADE_SPLASH" || type == "MOD_EXPLOSIVE" || type == "MOD_EXPLOSIVE_SPLASH" || type == "MOD_PROJECTILE" || type == "MOD_PROJECTILE_SPLASH") {
        self.damageweapon = "none";
        explosivedeath = true;
        explosion_ori = damage_ori;
      } else if(type == "MOD_BURNED") {
        flamedeath = true;
      }

      self notify("death", attacker, type);

      if(self.team == "axis" && (isPlayer(attacker) || attacker == level.playervehicle)) {
        level notify("player killed drone");
      }
    }

    if((isDefined(self.customFirstAnim)) && (self.customFirstAnim == true)) {
      self waittill("customFirstAnim done");
    }

    if(!isDefined(self)) {
      return;
    }

    self notify("Stop shooting");
    self.dontDelete = true;

    deathAnim = undefined;
    self useAnimTree(#animtree);

    if(explosivedeath) {
      direction = drone_get_explosion_death_dir(self.origin, self.angles, explosion_ori, 50);

      self thread drone_mortarDeath(direction);
      return;
    } else if(flamedeath) {
      deaths[0] = % ai_flame_death_a;
      deaths[1] = % ai_flame_death_b;
      deaths[2] = % ai_flame_death_c;
      deaths[3] = % ai_flame_death_d;
    } else if(isDefined(self.running)) {
      deaths[0] = % death_run_stumble;
      deaths[1] = % death_run_onfront;
      deaths[2] = % death_run_onleft;
      deaths[3] = % death_run_forward_crumple;
    } else {
      deaths[0] = % death_stand_dropinplace;
    }

    self thread drone_doDeath(deaths[randomint(deaths.size)]);
    return;
  }
}

#using_animtree("fakeshooters");
drone_delayed_bulletdeath(waitTime, deathRemoveNotify) {
  self endon("delete");
  self endon("drone_death");

  self.dontDelete = true;

  if(!isDefined(waitTime)) {
    waitTime = 0;
  }

  if(waitTime > 0) {
    wait(waitTime);
  }

  self thread drone_fakeDeath(true);
}

do_death_sound() {
  camp = level.campaign;
  team = self.team;

  alias = undefined;

  if(camp == "american" && team == "allies") {
    alias = "generic_death_american";
  }
  if(camp == "american" && team == "axis") {
    alias = "generic_death_japanese";
  }
  if(camp == "russian" && team == "allies") {
    alias = "generic_death_russian";
  }
  if(camp == "russian" && team == "axis") {
    alias = "generic_death_german";
  }

  if(isDefined(alias) && SoundExists(alias)) {
    self thread play_sound_in_space(alias);
  }
}

#using_animtree("fakeshooters");
drone_doDeath(deathAnim, deathRemoveNotify) {
  self moveTo(self.origin, 0.05, 0, 0);

  traceDeath = false;

  if((isDefined(self.running)) && self.running) {
    traceDeath = true;
  }

  self.running = undefined;
  self notify("drone_death");
  self notify("Stop shooting");
  self unlink();
  self useAnimTree(#animtree);
  self thread drone_doDeath_impacts();

  do_death_sound();

  prof_begin("drone_math");
  cancelRunningDeath = false;
  if(traceDeath) {
    offset = getcycleoriginoffset(self.angles, deathAnim);
    endAnimationLocation = (self.origin + offset);
    endAnimationLocation = physicstrace((endAnimationLocation + (0, 0, 128)), (endAnimationLocation - (0, 0, 128)));

    d1 = abs(endAnimationLocation[2] - self.origin[2]);

    if(d1 > 20) {
      cancelRunningDeath = true;
    } else {
      forwardVec = anglesToForward(self.angles);
      rightVec = anglestoright(self.angles);
      upVec = anglestoup(self.angles);
      relativeOffset = (50, 0, 0);
      secondPos = endAnimationLocation;
      secondPos += vector_multiply(forwardVec, relativeOffset[0]);
      secondPos += vector_multiply(rightVec, relativeOffset[1]);
      secondPos += vector_multiply(upVec, relativeOffset[2]);
      secondPos = physicstrace((secondPos + (0, 0, 128)), (secondPos - (0, 0, 128)));
      d2 = abs(secondPos[2] - self.origin[2]);
      if(d2 > 20) {
        cancelRunningDeath = true;
      }
    }
  }
  prof_end("drone_math");

  if(cancelRunningDeath) {
    deathAnim = % death_stand_dropinplace;
  }

  self animscripted("drone_death_anim", self.origin, self.angles, deathAnim, "deathplant");
  self thread drone_ragdoll(deathAnim);
  self waittillmatch("drone_death_anim", "end");

  if(!isDefined(self)) {
    return;
  }

  self setcontents(0);
  if(isDefined(deathRemoveNotify)) {
    level waittill(deathRemoveNotify);
  } else {
    wait 3;
  }

  if(!isDefined(self)) {
    return;
  }

  if(!isDefined(self.no_death_sink) || (isDefined(self.no_death_sink) && !self.no_death_sink)) {
    self MoveTo(self.origin - (0, 0, 100), 7);

    wait(3);
  }

  if(!isDefined(self)) {
    return;
  }

  self.dontDelete = undefined;
  self thread drone_delete();
}

drone_ragdoll(deathAnim) {
  time = self GetAnimTime(deathAnim);

  wait(time * 0.55);

  if(isDefined(self.weapon)) {
    weaponModel = GetWeaponModel(self.weapon);
    if(isDefined(weaponModel)) {
      self detach(weaponModel, "tag_weapon_right");
    }
  }

  self StartRagDoll();
}

drone_doDeath_impacts() {
  bone[0] = "J_Knee_LE";
  bone[1] = "J_Ankle_LE";
  bone[2] = "J_Clavicle_LE";
  bone[3] = "J_Shoulder_LE";
  bone[4] = "J_Elbow_LE";

  impacts = (1 + randomint(2));
  for(i = 0; i < impacts; i++) {
    playFXOnTag(level.drone_impact, self, bone[randomint(bone.size)]);
    self playSound("bullet_small_flesh");
    wait(0.05);
  }
}

drone_runChain(point_start) {
  self endon("drone_death");
  self endon("drone_shooting");

  runPos = undefined;
  while(isDefined(self)) {
    if(isDefined(point_start.script_death)) {
      self.dontDelete = true;
      self thread drone_delayed_bulletdeath(0);
    } else
    if((isDefined(point_start.script_death_min)) && (isDefined(point_start.script_death_max))) {
      self.dontDelete = true;
      self thread drone_delayed_bulletdeath(point_start.script_death_min + randomfloat(point_start.script_death_max - point_start.script_death_min));
    }

    if((isDefined(point_start.script_delete)) && (point_start.script_delete >= 0)) {
      self thread drone_delete(point_start.script_delete);
    }

    if(!isDefined(point_start.targeted)) {
      break;
    }

    point_end = point_start.targeted;

    if((!isDefined(point_end)) || (!isDefined(point_end[0]))) {
      break;
    }

    index = randomint(point_end.size);

    runPos = groundpos(point_end[index].origin);

    if(isDefined(point_end[index].radius)) {
      assert(point_end[index].radius > 0);

      if(!isDefined(self.droneRunOffset)) {
        self.droneRunOffset = (0 - 1 + (randomfloat(2)));
      }

      if(!isDefined(point_end[index].angles)) {
        point_end[index].angles = (0, 0, 0);
      }

      prof_begin("drone_math");
      forwardVec = anglesToForward(point_end[index].angles);
      rightVec = anglestoright(point_end[index].angles);
      upVec = anglestoup(point_end[index].angles);
      relativeOffset = (0, (self.droneRunOffset * point_end[index].radius), 0);
      runPos += vector_multiply(forwardVec, relativeOffset[0]);
      runPos += vector_multiply(rightVec, relativeOffset[1]);
      runPos += vector_multiply(upVec, relativeOffset[2]);
      prof_end("drone_math");
    }

    if(isDefined(point_start.script_noteworthy)) {
      self ShooterRun(runPos, point_start.script_noteworthy);
    } else {
      self ShooterRun(runPos);
    }

    point_start = point_end[index];
  }

  if(isDefined(runPos)) {
    if(isDefined(point_start.script_noteworthy)) {
      self ShooterRun(runPos, point_start.script_noteworthy);
    } else {
      self ShooterRun(runPos);
    }
  }

  if((isDefined(point_start.script_delete)) && (point_start.script_delete >= 0)) {
    self thread drone_delete(point_start.script_delete);
  }
}

drones_clear_variables() {
  if(isDefined(self.voice)) {
    self.voice = undefined;
  }
}

drone_delete(delayTime) {
  if((isDefined(delayTime)) && (delayTime > 0)) {
    wait(delayTime);
  }

  if(!isDefined(self)) {
    return;
  }

  self notify("drone_death");
  self notify("drone_idle_anim");

  if(!(is_in_array(level.drones[self.team].array, self))) {
    return;
  }

  structarray_remove(level.drones[self.team], self);
  if(!isDefined(self.dontDelete)) {
    if(isDefined(self.turrettarget)) {
      self.turrettarget delete();
    }

    if(isDefined(self.shootTarget)) {
      self.shootTarget delete();
    }

    self detachall();
    self delete();
  }
}

#using_animtree("fakeShooters");
ShooterRun(destinationPoint, event) {
  if(!isDefined(self)) {
    return;
  }

  self notify("Stop shooting");
  self UseAnimTree(#animtree);

  prof_begin("drone_math");

  d = distance(self.origin, destinationPoint);

  if(!isDefined(self.droneRunRate)) {
    self.droneRunRate = 200;
  }

  speed = (d / self.droneRunRate);

  self.lowheight = false;
  self turnToFacePoint(destinationPoint, speed);

  customFirstAnim = undefined;
  if(isDefined(event)) {
    switch (event) {
      case "jump":
        customFirstAnim = % jump_across_100;
        break;

      case "jumpdown":
        customFirstAnim = % jump_down_56;
        break;

      case "wall_hop":
        customFirstAnim = % traverse_wallhop;
        break;

      case "step_up":
        customFirstAnim = % step_up_low_wall;
        break;

      case "trench_jump_out":
        customFirstAnim = % trench_jump_out;
        break;

      case "low_height":
        self.lowheight = true;
        break;

      case "mortardeath_up":
        self thread drone_mortarDeath("up");
        return;

      case "mortardeath_forward":
        self thread drone_mortarDeath("forward");
        return;

      case "mortardeath_back":
        self thread drone_mortarDeath("back");
        return;

      case "mortardeath_left":
        self thread drone_mortarDeath("left");
        return;

      case "mortardeath_right":
        self thread drone_mortarDeath("right");
        return;

      case "shoot":
        forwardVec = anglesToForward(self.angles);
        rightVec = anglestoright(self.angles);
        upVec = anglestoup(self.angles);
        relativeOffset = (300, 0, 64);
        shootPos = self.origin;
        shootPos += vector_multiply(forwardVec, relativeOffset[0]);
        shootPos += vector_multiply(rightVec, relativeOffset[1]);
        shootPos += vector_multiply(upVec, relativeOffset[2]);
        self.shootTarget = spawn("script_origin", shootPos);

        self thread ShooterShoot(self.shootTarget);

        return;

      case "shoot_then_run_after_notify":
        forwardVec = anglesToForward(self.angles);
        rightVec = anglestoright(self.angles);
        upVec = anglestoup(self.angles);
        relativeOffset = (300, 0, 64);
        shootPos = self.origin;
        shootPos += vector_multiply(forwardVec, relativeOffset[0]);
        shootPos += vector_multiply(rightVec, relativeOffset[1]);
        shootPos += vector_multiply(upVec, relativeOffset[2]);
        self.shootTarget = spawn("script_origin", shootPos);

        self thread ShooterShoot(self.shootTarget);
        self waittill("Stop shooting");
        self clearanim(%combat_directions, 0);
        self clearanim(%exposed_reload, 0);
        break;

      case "cover_stand":
        self thread drone_cover(event);

        self waittill("drone out of cover");

        self setFlaggedAnimKnob("cover_exit", %coverstand_trans_OUT_M, 1, .1, 1);
        self waittillmatch("cover_exit", "end");
        break;

      case "cover_crouch":
        self thread drone_cover(event);

        self waittill("drone out of cover");

        self setFlaggedAnimKnob("cover_exit", %covercrouch_run_out_M, 1, .1, 1);
        self waittillmatch("cover_exit", "end");
        break;

      case "sniper_distance_walk":
        walkanims = [];
        walkanims[0] = "weary_walka";
        walkanims[1] = "weary_walkb";
        walkanims[2] = "weary_walkc";
        walkanims[3] = "weary_walkd";
        rand = randomint(3);
        self.droneRunRate = 50;
        self.drone_run_cycle = level.drone_run_cycle[walkanims[rand]];
        self.running = false;
        self thread ShooterRun_doRunAnim();
        break;

      case "lowwalk":
        walkanim = "sneaking_walk";
        self.drone_run_cycle = level.drone_run_cycle[walkanim];
        self.droneRunRate = 140;
        self.running = false;
        self thread ShooterRun_doRunAnim();
        break;

      case "water_deep":
        rand = randomint(2);

        if(rand == 1) {
          self.droneRunRate = 100;
          self.drone_run_cycle = level.drone_run_cycle["run_deep_a"];
          self.running = false;
          self thread ShooterRun_doRunAnim();
        } else {
          self.droneRunRate = 100;
          self.drone_run_cycle = level.drone_run_cycle["run_deep_b"];
          self.running = false;
          self thread ShooterRun_doRunAnim();
        }

        randomAnimRate = undefined;

        d = distance(self.origin, destinationPoint);
        speed = (d / self.droneRunRate);
        break;

      case "run_fast":
        self.droneRunRate = 200;
        self.drone_run_cycle = % combat_run_fast_3;
        self.running = false;
        self thread ShooterRun_doRunAnim();

        randomAnimRate = undefined;

        d = distance(self.origin, destinationPoint);
        speed = (d / self.droneRunRate);
        break;
    }
  }

  minRate = 0.5;
  maxRate = 1.5;
  randomAnimRate = minRate + randomfloat(maxRate - minRate);

  if(isDefined(customFirstAnim)) {
    self.customFirstAnim = true;
    self.running = undefined;
    randomAnimRate = undefined;
    angles = VectorToAngles(destinationPoint - self.origin);
    offset = getcycleoriginoffset(angles, customFirstAnim);
    endPos = self.origin + offset;
    endPos = physicstrace((endPos + (0, 0, 64)), (endPos - (0, 0, level.traceHeight)));

    t = getanimlength(customFirstAnim);
    assert(t > 0);

    self clearanim(self.drone_run_cycle, 0);
    self notify("stop_run_anim");

    self moveto(endPos, t, 0, 0);

    self setflaggedanimknobrestart("drone_custom_anim", customFirstAnim);
    self waittillmatch("drone_custom_anim", "end");

    self.origin = endPos;
    self notify("customFirstAnim done");

    d = distance(self.origin, destinationPoint);
    speed = (d / self.droneRunRate);

    if(((isDefined(event)) && (event == "jumpdown")) && (level.script == "duhoc_assault")) {
      structarray_remove(level.drones[self.team], self);
      if(isDefined(self.turrettarget)) {
        self.turrettarget delete();
      }

      if(isDefined(self.shootTarget)) {
        self.shootTarget delete();
      }

      self detachall();
      self delete();
      return;
    }
  }

  self.customFirstAnim = undefined;

  self thread ShooterRun_doRunAnim(randomAnimRate);

  self drone_runto(destinationPoint, speed);

  prof_end("drone_math");
}

drone_runto(destinationPoint, totalMoveTime) {
  if(totalMoveTime < 0.1) {
    return;
  }

  percentIncrement = 0.1;
  percentage = 0.0;
  incements = (1 / percentIncrement);
  dividedMoveTime = (totalMoveTime * percentIncrement);
  startingPos = self.origin;
  oldZ = startingPos[2];
  for(i = 0; i < incements; i++) {
    prof_begin("drone_math");

    percentage += percentIncrement;
    x = (destinationPoint[0] - startingPos[0]) * percentage + startingPos[0];
    y = (destinationPoint[1] - startingPos[1]) * percentage + startingPos[1];
    if(self.lowheight == true) {
      percentageMark = physicstrace((x, y, destinationPoint[2] + 64), (x, y, destinationPoint[2] - level.traceHeight));
    } else {
      percentageMark = physicstrace((x, y, destinationPoint[2] + level.traceHeight), (x, y, destinationPoint[2] - level.traceHeight));
    }

    if((percentageMark[2] - oldZ) > level.droneStepHeight) {
      percentageMark = (percentageMark[0], percentageMark[1], oldZ);
    }

    oldZ = percentageMark[2];

    prof_end("drone_math");

    self moveTo(percentageMark, dividedMoveTime, 0, 0);
    wait(dividedMoveTime);
  }
}

ShooterShoot(target) {
  self thread ShooterShootThread(target);
}

#using_animtree("fakeShooters");
ShooterShootThread(target) {
  self notify("Stop shooting");

  if(!isDefined(self.script_noteworthy)) {
    self notify("drone_shooting");
  } else if(isDefined(self.script_noteworthy) && self.script_noteworthy != "run_n_gun_drones") {
    self notify("drone_shooting");
  }

  self endon("Stop shooting");
  self UseAnimTree(#animtree);
  self.running = undefined;
  self thread aimAtTargetThread(target, "Stop shooting");

  shootAnimLength = 0;
  while(isDefined(self)) {
    if(self.bulletsInClip <= 0) {
      weaponModel = getWeaponModel(self.weapon);
      if(isDefined(self.weaponModel)) {
        weaponModel = self.weaponModel;
      }

      numAttached = self getattachsize();
      attachName = [];
      for(i = 0; i < numAttached; i++) {
        attachName[i] = self getattachmodelname(i);
      }

      self setflaggedanimknoballrestart("reloadanim", %exposed_reload, %root, 1, 0.4);

      self.bulletsInClip = randomintrange(4, 8);
      self waittillmatch("reloadanim", "end");
    }

    self Set3FlaggedAnimKnobs("no flag", "aim", "stand", 1, 0.3, 1);
    wait(1 + randomfloat(2));

    if(!isDefined(self)) {
      return;
    }

    numShots = randomint(4) + 1;
    if(numShots > self.bulletsInClip) {
      numShots = self.bulletsInClip;
    }

    for(i = 0; i < numShots; i++) {
      if(!isDefined(self)) {
        return;
      }

      self Set3FlaggedAnimKnobsRestart("shootinganim", "shoot", "stand", 1, 0.05, 1);

      playFXOnTag(level.drone_muzzleflash, self, "tag_flash");
      if(self.team == "axis") {
        switch (level.campaign) {
          case "american":

            break;
          case "russian":
            self playSound("weap_kar98k_fire");
            break;
          case "british":
            self playSound("weap_kar98k_fire");
            break;
        }
      } else {
        switch (level.campaign) {
          case "american":
            self playSound("weap_m1garand_fire");
            break;
          case "russian":
            self playSound("weap_nagant_fire");
            break;
          case "british":
            self playSound("weap_enfield_fire");
            break;
        }
      }

      self.bulletsInClip--;

      if(shootAnimLength == 0) {
        shootAnimLength = gettime();
        self waittillmatch("shootinganim", "end");
        shootAnimLength = (gettime() - shootAnimLength) / 1000;
      } else {
        wait(shootAnimLength - 0.1 + randomfloat(0.3));
        if(!isDefined(self)) {
          return;
        }
      }
    }
  }
}

ShooterRun_doRunAnim(animRateMod) {
  if(isDefined(self.running) && self.running) {
    return;
  }

  self notify("stop_shooterrun");
  self endon("stop_shooterrun");

  self.running = true;

  if(!isDefined(animRateMod)) {
    animRateMod = 1.0;
  }

  self endon("stop_run_anim");
  adjustAnimRate = true;
  while((isDefined(self.running)) && (self.running == true)) {
    animRate = (self.droneRunRate / 200);

    if(adjustAnimRate) {
      animRate = (animRate * animRateMod);
      adjustAnimRate = false;
    }

    self setflaggedanimknobrestart("drone_run_anim", self.drone_run_cycle, 1, .2, 1);
    self waittillmatch("drone_run_anim", "end");

    if(!isDefined(self)) {
      return;
    }
  }
}

drone_debugLine(fromPoint, toPoint, color, durationFrames) {
  for(i = 0; i < durationFrames * 20; i++) {
    line(fromPoint, toPoint, color);
    wait(0.05);
  }
}

turnToFacePoint(point, speed) {
  desiredAngles = VectorToAngles(point - self.origin);

  if(!isDefined(speed)) {
    speed = 0.5;
  } else if(speed > 0.5) {
    speed = 0.5;
  }

  if(speed < 0.1) {
    return;
  }

  self rotateTo((0, desiredAngles[1], 0), speed, 0, 0);
}

Set3FlaggedAnimKnobs(animFlag, animArray, pose, weight, blendTime, rate) {
  if(!isDefined(self)) {
    return;
  }

  self setAnimKnob(%combat_directions, weight, blendTime, rate);
  self SetFlaggedAnimKnob(animFlag, level.drone_animArray[animArray][pose]["up"], 1, blendTime, 1);
  self SetAnimKnob(level.drone_animArray[animArray][pose]["straight"], 1, blendTime, 1);
  self SetAnimKnob(level.drone_animArray[animArray][pose]["down"], 1, blendTime, 1);
}

Set3FlaggedAnimKnobsRestart(animFlag, animArray, pose, weight, blendTime, rate) {
  if(!isDefined(self)) {
    return;
  }

  self setAnimKnobRestart(%combat_directions, weight, blendTime, rate);
  self SetFlaggedAnimKnobRestart(animFlag, level.drone_animArray[animArray][pose]["up"], 1, blendTime, 1);
  self SetAnimKnobRestart(level.drone_animArray[animArray][pose]["straight"], 1, blendTime, 1);
  self SetAnimKnobRestart(level.drone_animArray[animArray][pose]["down"], 1, blendTime, 1);
}

applyBlend(offset) {
  if(offset < 0) {
    unstraightAnim = % combat_down;
    self setanim(%combat_up, 0.01, 0, 1);
    offset *= -1;
  } else {
    unstraightAnim = % combat_up;
    self setanim(%combat_down, 0.01, 0, 1);
  }

  if(offset > 1) {
    offset = 1;
  }

  unstraight = offset;

  if(unstraight >= 1.0) {
    unstraight = 0.99;
  }

  if(unstraight <= 0) {
    unstraight = 0.01;
  }
  straight = 1 - unstraight;
  self setanim(unstraightAnim, unstraight, 0, 1);
  self setanim(%combat_straight, straight, 0, 1);
}

aimAtTargetThread(target, stopString) {
  self endon(stopString);
  while(isDefined(self)) {
    targetPos = target.origin;
    turnToFacePoint(targetPos);
    offset = getTargetUpDownOffset(targetPos);
    applyBlend(offset);
    wait(0.05);
  }
}

getTargetUpDownOffset(target) {
  pos = self.origin;
  dir = (target[0] - pos[0], target[1] - pos[1], target[2] - pos[2]);
  dir = VectorNormalize(dir);
  return dir[2];
}

setAnimArray() {
  level.drone_animArray["aim"]["stand"]["down"] = % stand_aim_down;
  level.drone_animArray["aim"]["stand"]["straight"] = % stand_aim_straight;
  level.drone_animArray["aim"]["stand"]["up"] = % stand_aim_up;

  level.drone_animArray["aim"]["crouch"]["down"] = % crouch_aim_down;
  level.drone_animArray["aim"]["crouch"]["straight"] = % crouch_aim_straight;
  level.drone_animArray["aim"]["crouch"]["up"] = % crouch_aim_up;

  level.drone_animArray["auto"]["stand"]["down"] = % stand_shoot_auto_down;
  level.drone_animArray["auto"]["stand"]["straight"] = % stand_shoot_auto_straight;
  level.drone_animArray["auto"]["stand"]["up"] = % stand_shoot_auto_up;

  level.drone_animArray["auto"]["crouch"]["down"] = % crouch_shoot_auto_down;
  level.drone_animArray["auto"]["crouch"]["straight"] = % crouch_shoot_auto_straight;
  level.drone_animArray["auto"]["crouch"]["up"] = % crouch_shoot_auto_up;

  level.drone_animArray["shoot"]["stand"]["down"] = % stand_shoot_down;
  level.drone_animArray["shoot"]["stand"]["straight"] = % stand_shoot_straight;
  level.drone_animArray["shoot"]["stand"]["up"] = % stand_shoot_up;

  level.drone_animArray["shoot"]["crouch"]["down"] = % crouch_shoot_down;
  level.drone_animArray["shoot"]["crouch"]["straight"] = % crouch_shoot_straight;
  level.drone_animArray["shoot"]["crouch"]["up"] = % crouch_shoot_up;
}

drone_cover(type) {
  self endon("drone_stop_cover");

  if(!isDefined(self.a)) {
    self.a = spawnStruct();
  }

  self.running = undefined;

  anim_array = [];

  if(type == "cover_stand") {
    anim_array["hide_idle"] = % coverstand_hide_idle;
    anim_array["hide_idle_twitch"] = array(%coverstand_hide_idle_twitch01, %coverstand_hide_idle_twitch02, %coverstand_hide_idle_twitch03, %coverstand_hide_idle_twitch04, %coverstand_hide_idle_twitch05);

    anim_array["hide_idle_flinch"] = array(%coverstand_react01, %coverstand_react02, %coverstand_react03, %coverstand_react04);

    self.a.array = anim_array;

    self setFlaggedAnimKnobRestart("cover_approach", %coverstand_trans_IN_M, 1, .3, 1);
    self waittillmatch("cover_approach", "end");

    self thread drone_cover_think();
  } else if(type == "cover_crouch") {
    anim_array["hide_idle"] = % covercrouch_hide_idle;
    anim_array["hide_idle_twitch"] = array(%covercrouch_twitch_1, %covercrouch_twitch_2, %covercrouch_twitch_3, %covercrouch_twitch_4);

    self.a.array = anim_array;

    self setFlaggedAnimKnobRestart("cover_approach", %covercrouch_run_in_M, 1, .3, 1);
    self waittillmatch("cover_approach", "end");

    self thread drone_cover_think();
  }
}

drone_cover_think() {
  self endon("drone_stop_cover");

  while(1) {
    useTwitch = (randomint(2) == 0);
    if(useTwitch) {
      idleanim = animArrayPickRandom("hide_idle_twitch");
    } else {
      idleanim = animarray("hide_idle");
    }

    self drone_playIdleAnimation(idleAnim, useTwitch);
  }
}

drone_playIdleAnimation(idleAnim, needsRestart) {
  self endon("drone_stop_cover");

  if(needsRestart) {
    self setFlaggedAnimKnobRestart("idle", idleAnim, 1, .1, 1);
  } else {
    self setFlaggedAnimKnob("idle", idleAnim, 1, .1, 1);
  }

  self.a.coverMode = "hide";

  self waittillmatch("idle", "end");
}
drone_get_explosion_death_dir(self_pos, self_angle, explosion_pos, up_distance) {
  if(Distance2D(self_pos, explosion_pos) < up_distance) {
    return "up";
  }

  p1 = self_pos - vectornormalize(anglesToForward(self_angle)) * 10000;
  p2 = self_pos + vectornormalize(anglesToForward(self_angle)) * 10000;
  p_intersect = PointOnSegmentNearestToPoint(p1, p2, explosion_pos);

  side_away_dist = Distance2D(p_intersect, explosion_pos);
  side_close_dist = Distance2D(p_intersect, self_pos);

  if(side_close_dist != 0) {
    angle = ATan(side_away_dist / side_close_dist);

    dot_product = vectordot(anglesToForward(self_angle), vectornormalize(explosion_pos - self_pos));
    if(dot_product < 0) {
      angle = 180 - angle;
    }

    if(angle < 45) {
      return "back";
    } else if(angle > 135) {
      return "forward";
    }
  }

  self_right_angle = vectornormalize(AnglesToRight(self_angle));
  right_point = self_pos + self_right_angle * (up_distance * 0.5);

  if(Distance2D(right_point, explosion_pos) < Distance2D(self_pos, explosion_pos)) {
    return "left";
  } else {
    return "right";
  }
}