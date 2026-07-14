/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: hashed\script\script_78ee1f1787a2e6a4.gsc
*****************************************************/

#using scripts\asm\asm_bb;
#using scripts\common\ai;
#using scripts\common\utility;
#using scripts\engine\utility;
#namespace ai;

function spawner_fields(spawner) {
  spawner function_899f9270828661fb();

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
    self.animname = spawner.script_animname;
    self.script_animname = undefined;
  }

  if(isDefined(spawner.script_laser)) {
    thread function_49e800ef9cab0f20();
  }

  if(isDefined(spawner.script_danger_react)) {
    self.script_danger_react = spawner.script_danger_react;
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
    self.script_forcecolor = spawner.script_forcecolor;
    utility::callsharedfunc(#"colors", #"set_force_color", self.script_forcecolor);
  }

  if(isDefined(spawner.dontdropweapon)) {
    self.shoulddropweapon = 0;
  }

  if(isDefined(spawner.script_team)) {
    self.script_team = spawner.script_team;
    self.team = self.script_team;
  }

  if(isDefined(spawner.script_fixednode)) {
    self.fixednode = spawner.script_fixednode == 1;
    self.script_fixednode = undefined;
  } else if(utility::issp()) {
    self.fixednode = self.team == "O\x15\x1b\xad\x9ff";
  }

  self.providecoveringfire = self.team == "O\x15\x1b\xad\x9ff" && self.fixednode;

  if(isDefined(spawner.script_no_reorient) && spawner.script_no_reorient == 1) {
    self.no_reorient = 1;
    self.script_no_reorient = undefined;
  }

  if(isDefined(spawner.script_goalvolume) && !(isDefined(spawner.script_moveoverride) && spawner.script_moveoverride == 1 || isDefined(self.script_stealthgroup))) {
    self.script_goalvolume = spawner.script_goalvolume;
    thread function_dcff3b8e050ec85a();
  }

  if(isDefined(spawner.script_threatbiasgroup)) {
    self.script_threatbiasgroup = spawner.script_threatbiasgroup;
    createthreatbiasgroup(self.script_threatbiasgroup);
    self setthreatbiasgroup(self.script_threatbiasgroup);
  } else if(self.team == "\xba\xa5\x1f\xc9m\x80i") {
    if(!threatbiasgroupexists("75\xffQ\x95\xfe`\x9a")) {
      createthreatbiasgroup("75\xffQ\x95\xfe`\x9a");
    }

    self setthreatbiasgroup("75\xffQ\x95\xfe`\x9a");
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
    assert(spawner.script_ignoreme == 1, "<dev string:x24>");
    set_ignoreme(1);
    self.script_ignoreme = undefined;
  }

  if(isDefined(spawner.script_ignore_suppression)) {
    assert(spawner.script_ignore_suppression == 1, "<dev string:xa9>");
    self.ignoresuppression = 1;
    self.script_ignore_suppression = undefined;
  }

  if(isDefined(spawner.script_ignoreall)) {
    assert(spawner.script_ignoreall == 1, "<dev string:x138>");
    set_ignoreall(1);
    self clearenemy();
  }

  if(isDefined(spawner.script_offhands)) {
    set_grenadeweapon(spawner.script_offhands);
    self.script_offhands = undefined;
  }

  if(isDefined(spawner.script_favoriteenemy)) {
    if(spawner.script_favoriteenemy == "K_p\x84a\x01") {
      self.favoriteenemy = function_9755c3c5207e4918();
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
    self.script_longdeath = spawner.script_longdeath;

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
    assert(spawner.script_diequietly, "<dev string:x1be>" + self.export);
    self.diequietly = 1;
    self.script_diequietly = undefined;
  }

  if(isDefined(spawner.script_noragdoll)) {
    assert(spawner.script_noragdoll, "<dev string:x225>" + self.export);
    self.noragdoll = 1;
    self.script_noragdoll = undefined;
  }

  if(isDefined(spawner.script_pacifist)) {
    self.pacifist = 1;
    self.script_pacifist = undefined;
  }

  if(isDefined(spawner.script_bulletshield)) {
    assert(spawner.script_bulletshield, "<dev string:x287>" + self.export);
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
    self.noloot = spawner.script_noloot;
    self.script_noloot = undefined;
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
    asm_bb::bb_setcivilianstate(spawner.script_civilian_state);
    self.script_civilian_state = undefined;
  }

  if(isDefined(spawner.script_civilian_control)) {
    self function_8370876f66d11ea2(spawner.script_civilian_control, 0);
    self.script_civilian_control = undefined;
  }

  if(isDefined(spawner.script_speed)) {
    utility::set_movement_speed(spawner.script_speed);
    self.script_speed = undefined;
  }

  if(isDefined(spawner.script_noflashlight)) {
    self.noflashlight = spawner.script_noflashlight;
    self.script_noflashlight = undefined;
  }

  if(isDefined(spawner.script_combatmode)) {
    self.combatmode = spawner.script_combatmode;
  }

  if(isDefined(spawner.script_combatbehavior)) {
    self.script_combatbehavior = spawner.script_combatbehavior;

    if(self.script_combatbehavior == "\x15'\xa3") {
      utility::enable_cqbwalk();
    }
  }

  self.spawnpoint = spawner;

  if(!isai(spawner)) {
    self.script_stealth_region_group = spawner.script_stealth_region_group;
    self.script_dialogue = spawner.script_dialogue;
    self.script_noteworthy = spawner.script_noteworthy;
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

function private function_899f9270828661fb() {
  if(utility::issp()) {
    return;
  }

  if(self.target == "\x91\xca\xcc\v\xab\xd8:") {
    self.target = undefined;
  }

  if(self.script_noteworthy == "\x91\xca\xcc\v\xab\xd8:") {
    self.script_noteworthy = undefined;
  }

  if(self.script_forcespawn == 0) {
    self.script_forcespawn = undefined;
  }

  if(self.script_team == "?\xb1\xc0\x9a") {
    self.script_team = undefined;
  }

  if(self.script_radius == 0) {
    self.script_radius = undefined;
  }

  if(self.script_goalheight == 0) {
    self.script_goalheight = undefined;
  }

  if(self.script_origin_other == (0, 0, 0)) {
    self.script_origin_other = undefined;
  }

  if(self.script_count == 0) {
    self.script_count = undefined;
  }

  if(self.script_timeout == 0) {
    self.script_timeout = undefined;
  }

  if(self.script_dot == 0) {
    self.script_dot = undefined;
  }

  if(self.script_dist_only == 0) {
    self.script_dist_only = undefined;
  }

  if(self.script_demeanor == "\x91\xca\xcc\v\xab\xd8:") {
    self.script_demeanor = undefined;
  }

  if(self.script_speed == 0) {
    self.script_speed = undefined;
  }

  if(self.script_linkto == "\x91\xca\xcc\v\xab\xd8:") {
    self.script_linkto = undefined;
  }

  if(self.script_linkname == "\x91\xca\xcc\v\xab\xd8:") {
    self.script_linkname = undefined;
  }

  if(isDefined(self.script_unload)) {
    if(isstring(self.script_unload) && self.script_unload == "Bf") {
      self.script_unload = undefined;
      return;
    }

    if(isint(self.script_unload) && self.script_unload == -1) {
      self.script_unload = undefined;
    }
  }
}

function spawn_running() {
  self endon("\x1e\xfd\xd1\xa2\a");
  self.disableexits = 1;
  wait 3;
  self.disableexits = 0;
}

function function_dcff3b8e050ec85a() {
  waittillframeend();

  if(!isDefined(self)) {
    return;
  }

  thread set_goal_volume();
}

function private function_9755c3c5207e4918() {
  if(!isDefined(level.players)) {
    return level.player;
  }

  sorted = sortbydistance(level.players, self.origin);
  return sorted[0];
}