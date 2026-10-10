/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_78ee1f1787a2e6a4.gsc
*************************************************/

#using scripts\asm\asm_bb;
#using scripts\common\ai;
#using scripts\common\utility;
#using scripts\engine\utility;
#namespace ai;

function spawner_fields(spawner) {
  spawner function_2222444238558aaa();

  if(isDefined(spawner.script_dontshootwhilemoving)) {
    self.dontshootwhilemoving = 1;
    self.script_dontshootwhilemoving = undefined;
  }

  if(isDefined(spawner.script_deathflag)) {
    self.script_deathflag = spawner.script_deathflag;
    thread ai_deathflag();
  }

  if(isDefined(spawner.script_attackeraccuracy)) {
    self.attackeraccuracy = spawner.script_attackeraccuracy;
    self.script_attackeraccuracy = undefined;
  }

  if(isDefined(spawner.script_startrunning)) {
    thread spawn_running();
    self.script_startrunning = undefined;
  }

  if(isDefined(spawner.script_nosurprise)) {
    disable_surprise();
    self.script_nosurprise = undefined;
  }

  if(isDefined(spawner.script_nobloodpool)) {
    self.skipbloodpool = 1;
    self.script_nobloodpool = undefined;
  }

  if(isDefined(spawner.script_animname)) {
    self.animname = self.script_animname;
    self.script_animname = undefined;
  }

  if(isDefined(spawner.script_laser)) {
    thread function_b571948011d94c21();
  }

  if(isDefined(spawner.script_danger_react)) {
    time = self.script_danger_react;

    if(time == 1) {
      time = 8;
    }

    enable_danger_react(time);
  }

  if(isDefined(spawner.script_faceenemydist)) {
    self.maxfaceenemydist = spawner.script_faceenemydist;
  }

  if(isDefined(spawner.script_forcecolor)) {
    function_f3bb4f4911a1beb2("colors", "set_force_color", self.script_forcecolor);
  }

  if(isDefined(spawner.dontdropweapon)) {
    self.dropweapon = 0;
  }

  if(isDefined(spawner.script_team)) {
    self.script_team = spawner.script_team;
    self.team = self.script_team;
  }

  if(isDefined(spawner.script_fixednode)) {
    self.fixednode = spawner.script_fixednode == 1;
    self.script_fixednode = undefined;
  } else if(utility::issp()) {
    self.fixednode = self.team == "allies";
  }

  self.providecoveringfire = self.team == "allies" && self.fixednode;

  if(isDefined(spawner.script_no_reorient) && spawner.script_no_reorient == 1) {
    self.no_reorient = 1;
    self.script_no_reorient = undefined;
  }

  if(isDefined(spawner.script_goalvolume) && !(isDefined(spawner.script_moveoverride) && spawner.script_moveoverride == 1 || isDefined(self.script_stealthgroup))) {
    self.script_goalvolume = spawner.script_goalvolume;
    thread function_691ff0cbc56cf8d3();
  }

  if(isDefined(spawner.script_threatbiasgroup)) {
    self.script_threatbiasgroup = spawner.script_threatbiasgroup;
    createthreatbiasgroup(self.script_threatbiasgroup);
    self setthreatbiasgroup(self.script_threatbiasgroup);
  } else if(self.team == "neutral") {
    if(!threatbiasgroupexists("civilian")) {
      createthreatbiasgroup("civilian");
    }

    self setthreatbiasgroup("civilian");
  } else {
    if(!threatbiasgroupexists(self.team)) {
      createthreatbiasgroup(self.team);
    }

    self setthreatbiasgroup(self.team);
  }

  if(isDefined(spawner.script_bcdialog)) {
    self.script_bcdialog = spawner.script_bcdialog;
    utility::set_battlechatter(self.script_bcdialog);
  }

  if(isDefined(spawner.script_accuracy)) {
    self.baseaccuracy = spawner.script_accuracy;
    self.script_accuracy = undefined;
  }

  if(isDefined(spawner.script_ignoreme)) {
    assertex(spawner.script_ignoreme == 1, "script_ignoreme set to something other than true (1) in Radiant. The only valid values are true or undefined. Defaulting to true.");
    self.ignoreme = 1;
    self.script_ignoreme = undefined;
  }

  if(isDefined(spawner.script_ignore_suppression)) {
    assertex(spawner.script_ignore_suppression == 1, "script_ignore_suppression set to something other than true (1) in Radiant. The only valid values are true or undefined. Defaulting to true.");
    self.ignoresuppression = 1;
    self.script_ignore_suppression = undefined;
  }

  if(isDefined(spawner.script_ignoreall)) {
    assertex(spawner.script_ignoreall == 1, "script_ignoreall set to something other than true (1) in Radiant. The only valid values are true or undefined. Defaulting to true.");
    self.ignoreall = 1;
    self clearenemy();
  }

  if(isDefined(spawner.script_offhands)) {
    set_grenadeweapon(spawner.script_offhands);
    self.script_offhands = undefined;
  }

  if(isDefined(spawner.script_favoriteenemy)) {
    if(spawner.script_favoriteenemy == "player") {
      self.favoriteenemy = function_5be4133799f4425d();
    }
  }

  if(isDefined(spawner.script_sightrange)) {
    self.maxsightdistsqrd = squared(spawner.script_sightrange);
    self.script_sightrange = undefined;
  }

  if(isDefined(spawner.script_fightdist)) {
    self.pathenemyfightdist = spawner.script_fightdist;
    self.script_fightdist = undefined;
  }

  if(isDefined(spawner.script_maxdist)) {
    self.pathenemylookahead = spawner.script_maxdist;
    self.script_maxdist = undefined;
  }

  if(isDefined(spawner.script_longdeath)) {
    if(self.script_longdeath == 0) {
      disable_long_death();
    } else if(self.script_longdeath == 1) {
      enable_long_death();
    } else {
      enable_long_death();
      self.forcelongdeath = self.script_longdeath;
    }
  }

  if(isDefined(spawner.script_forcebalconydeath)) {
    self.forcebalconydeath = 1;
    self.script_forcebalconydeath = undefined;
  }

  if(isDefined(spawner.script_diequietly)) {
    assertex(self.script_diequietly, "Quiet deaths are disabled by default so don't set script_diequietly to false, check ai with export " + self.export);
    self.diequietly = 1;
    self.script_diequietly = undefined;
  }

  if(isDefined(spawner.script_noragdoll)) {
    assertex(spawner.script_noragdoll, "noragdoll is disabled by default so don't set script_noragdoll to false, check ai with export " + self.export);
    self.noragdoll = 1;
    self.script_noragdoll = undefined;
  }

  if(isDefined(spawner.script_pacifist)) {
    self.pacifist = 1;
    self.script_pacifist = undefined;
  }

  if(isDefined(spawner.script_bulletshield)) {
    assertex(spawner.script_bulletshield, "bulletshield is disabled by default so don't set script_bulletshield to false, check ai with export " + self.export);
    magic_bullet_shield();
    self.script_bulletshield = undefined;
  }

  if(isDefined(spawner.script_startinghealth)) {
    self.health = spawner.script_startinghealth;
    self.script_startinghealth = undefined;
  }

  if(isDefined(spawner.script_nodrop)) {
    self.nodrop = spawner.script_nodrop;
    self.script_nodrop = undefined;
  }

  if(isDefined(spawner.script_noloot)) {
    self.noloot = self.script_noloot;
    self.script_noloot = spawner;
  }

  if(isDefined(spawner.script_armored)) {
    self.armored = spawner.script_armored;
    self.script_armored = undefined;
  }

  if(isDefined(spawner.script_demeanor)) {
    utility::demeanor_override(spawner.script_demeanor);
    self.script_demeanor = undefined;
  }

  if(isDefined(spawner.script_civilian_state)) {
    scripts\asm\asm_bb::bb_setcivilianstate(spawner.script_civilian_state);
    self.script_civilian_state = undefined;
  }

  if(isDefined(spawner.script_speed)) {
    set_movement_speed(spawner.script_speed);
    self.script_speed = undefined;
  }

  if(isDefined(spawner.script_noflashlight)) {
    self.noflashlight = spawner.script_noflashlight;
    self.script_noflashlight = undefined;
  }

  if(isDefined(spawner.script_combatmode)) {
    self.combatmode = spawner.script_combatmode;
  }

  if(isDefined(self.script_combatbehavior)) {
    if(self.script_combatbehavior == "cqb") {
      utility::enable_cqbwalk();
    }
  }

  self.spawnpoint = spawner;

  if(!issp()) {
    self.script_stealth_region_group = spawner.script_stealth_region_group;
    self.script_dialogue = spawner.script_dialogue;
    self.script_parameters = spawner.script_parameters;
    self.script_squadname = spawner.script_squadname;
    self.script_stealthgroup = spawner.script_stealthgroup;
    self.script_linkto = spawner.script_linkto;
    self.script_linkname = spawner.script_linkname;
    self.script_demeanor_post = spawner.script_demeanor_post;
    self.script_goalheight = spawner.script_goalheight;
    self.script_radius = spawner.script_radius;
    self.script_goalradius = spawner.script_goalradius;
    self.dontkilloff = spawner.dontkilloff;
    self.script_patroller = spawner.script_patroller;
    self.equip_helmet = spawner.equip_helmet;
    self.is_on_platform = spawner.is_on_platform;
    self.door_spawner = spawner.door_spawner;
    self.dont_enter_combat = spawner.dont_enter_combat;
    self.script_origin_other = spawner.script_origin_other;
    self.script_forcegoal = spawner.script_forcegoal;
    self.target = spawner.target;
  }

  self.aitype = spawner.aitype;

  if(isDefined(spawner.script_noflashlight)) {
    if(isstring(spawner.script_noflashlight) && spawner.script_noflashlight != "") {
      self.noflashlight = int(spawner.script_noflashlight);
    } else if(isint(spawner.script_noflashlight)) {
      self.noflashlight = spawner.script_noflashlight;
    }
  }

  if(isDefined(spawner.script_enemyselector)) {
    self.enemyselector = spawner.script_enemyselector;
    self.script_enemyselector = undefined;
  }
}

function private function_2222444238558aaa() {
  if(utility::issp()) {
    return;
  }

  if(is_equal(self.target, "default")) {
    self.target = undefined;
  }

  if(is_equal(self.script_noteworthy, "default")) {
    self.script_noteworthy = undefined;
  }

  if(is_equal(self.script_forcespawn, 0)) {
    self.script_forcespawn = undefined;
  }

  if(is_equal(self.script_team, "axis")) {
    self.script_team = undefined;
  }

  if(is_equal(self.script_radius, 0)) {
    self.script_radius = undefined;
  }

  if(is_equal(self.script_goalheight, 0)) {
    self.script_goalheight = undefined;
  }

  if(is_equal(self.script_origin_other, (0, 0, 0))) {
    self.script_origin_other = undefined;
  }

  if(is_equal(self.script_count, 0)) {
    self.script_count = undefined;
  }

  if(is_equal(self.script_timeout, 0)) {
    self.script_timeout = undefined;
  }

  if(is_equal(self.script_dot, 0)) {
    self.script_dot = undefined;
  }

  if(is_equal(self.script_dist_only, 0)) {
    self.script_dist_only = undefined;
  }

  if(is_equal(self.script_demeanor, "default")) {
    self.script_demeanor = undefined;
  }

  if(is_equal(self.script_speed, 0)) {
    self.script_speed = undefined;
  }

  if(is_equal(self.script_linkto, "default")) {
    self.script_linkto = undefined;
  }

  if(is_equal(self.script_linkname, "default")) {
    self.script_linkname = undefined;
  }

  if(isDefined(self.script_unload)) {
    if(isstring(self.script_unload) && is_equal(self.script_unload, "-1")) {
      self.script_unload = undefined;
      return;
    }

    if(isint(self.script_unload) && is_equal(self.script_unload, -1)) {
      self.script_unload = undefined;
    }
  }
}

function spawn_running() {
  self endon("death");
  self.disableexits = 1;
  wait 3;
  self.disableexits = 0;
}

function function_691ff0cbc56cf8d3() {
  waittillframeend();

  if(!isDefined(self)) {
    return;
  }

  thread set_goal_volume();
}

function private function_5be4133799f4425d() {
  if(!isDefined(level.players)) {
    return level.player;
  }

  sorted = sortbydistance(level.players, self.origin);
  return sorted[0];
}