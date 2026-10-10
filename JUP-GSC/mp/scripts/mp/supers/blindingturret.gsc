/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\supers\blindingturret.gsc
***************************************************/

#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\utility\shellshock_utility;
#using scripts\engine\math;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\damage;
#using scripts\mp\hostmigration;
#using scripts\mp\sentientpoolmanager;
#using scripts\mp\utility\player;
#namespace blindingturret;

function blindingturret_unset() {
  self notify("blindingTurret_unset");
}

function function_f6f76571fbd09f18(data) {
  attacker = data.attacker;
  objweapon = data.objweapon;
  type = data.meansofdeath;
  damage = data.damage;

  if(istrue(scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, attacker))) {
    attacker notify("destroyed_equipment");
  }

  function_7d3a3fe4313463b4();
}

function function_b02438cf4822a79e(grenade) {
  self endon("disconnect");
  level endon("game_ended");
  grenade waittill("missile_stuck");
  turret = function_2beaf4844e5a4d16(grenade);

  if(!isDefined(turret)) {
    return;
  }

  maxhealth = 100;
  turret thread scripts\mp\damage::monitordamage(maxhealth, "hitequip", &function_f6f76571fbd09f18, undefined, 0, 0);
  turret thread function_cad43242ef6c86b5();
  turret thread function_b310f71f299cbc78();
}

function function_b310f71f299cbc78() {
  level endon("game_ended");
  self endon("death");

  while(true) {
    if(!istrue(self.stunned) && !istrue(self.isactive)) {
      function_74b09da5a1249ff7();
    }

    if(!istrue(self.stunned) && !istrue(self.isidling)) {
      thread function_a100143a05b7b873();
    }

    if(!istrue(self.stunned) && !isDefined(self.flashtarget) && !istrue(self.oncooldown)) {
      function_a8320570b3ed2b35();
    }

    if(!istrue(self.stunned) && isDefined(self.flashtarget)) {
      function_3fe776cabee63724();
    }

    if(!istrue(self.stunned) && istrue(self.var_e9765f437a2de9c0) && isDefined(self.flashtarget)) {
      function_83f4dd119acbf873();
    }

    if(istrue(self.stunned)) {
      function_c471c1f93412cb6c();
    }

    if(isDefined(self.flashtarget)) {
      function_987732d93502e3f();
    }

    waitframe();
  }
}

function function_83f4dd119acbf873() {
  cansee = function_59b368c4c2bdc737(self.flashtarget);

  if(cansee) {
    self.flashtarget _shellshock("flash_grenade_mp", "flash", 4, 1);
  }

  thread function_6584a53d3d4d1fa8();
}

function private function_6584a53d3d4d1fa8(time) {
  if(!isDefined(time)) {
    time = 1;
  }

  self.oncooldown = 1;
  wait time;
  self.oncooldown = undefined;
}

function function_59b368c4c2bdc737(target) {
  if(!isDefined(target)) {
    return 0;
  }

  icansee = 0;
  tracecontents = scripts\engine\trace::create_contents(0, 1, 0, 1, 1, 1, 0, 1);
  defaultorigin = self.origin;
  headpos = target gettagorigin("j_head");

  if(scripts\engine\utility::issharedfuncdefined("player", "isReallyAlive")) {
    headpos = target[[scripts\engine\utility::getsharedfunc("player", "getStanceTop")]]();
  }

  centerpos = "j_spineupper";

  if(scripts\engine\utility::issharedfuncdefined("player", "isReallyAlive")) {
    centerpos = target[[scripts\engine\utility::getsharedfunc("player", "getStanceCenter")]]();
  }

  tracepoints = [headpos, centerpos, defaultorigin];
  ignorelist = [self, target];
  vehicle = target scripts\cp_mp\utility\player_utility::getvehicle();

  if(isDefined(vehicle)) {
    ignorelist[ignorelist.size] = vehicle;
    vehiclechildren = vehicle getlinkedchildren(1);

    foreach(child in vehiclechildren) {
      ignorelist[ignorelist.size] = vehicle;
    }
  }

  for(i = 0; i < tracepoints.size; i++) {
    if(!scripts\engine\trace::ray_trace_passed(defaultorigin, tracepoints[i], ignorelist, tracecontents)) {
      continue;
    }

    icansee = 1;
    break;
  }

  return icansee;
}

function function_c471c1f93412cb6c() {}

function function_987732d93502e3f() {
  if(!isDefined(self.var_894380476a44e139)) {
    self.var_894380476a44e139 = [];
  }

  self.var_894380476a44e139[self.var_894380476a44e139.size] = self.flashtarget;
  self.flashtarget = undefined;
  self cleartargetentity();
  self.isidling = 0;
  self.var_e9765f437a2de9c0 = 0;
}

function function_3fe776cabee63724() {
  if(!isDefined(self.flashtarget)) {
    return;
  }

  self endon("death");
  self endon("stunned");
  self.flashtarget endon("death_or_disconnect");
  self notify("blindingTurret_stopIdleMovements");
  self.var_e9765f437a2de9c0 = 0;
  self cleartargetentity();
  waitframe();
  self setconvergencetime(0.75, "pitch");
  self setconvergencetime(0.75, "yaw");
  self.aimtarget linkTo(self.flashtarget, "tag_shield_back", (0, 0, 0), (0, 0, 0));
  self settargetentity(self.aimtarget);
  waitframe();
  vectorbetween = flatten_vector(self.aimtarget.origin - self.origin);
  turretfwd = flatten_vector(anglesToForward(self gettagangles("tag_flash")));
  angbetween = math::anglebetweenvectors(turretfwd, vectorbetween);

  while(angbetween > 8) {
    angbetween = math::anglebetweenvectors(turretfwd, vectorbetween);
    turretfwd = flatten_vector(anglesToForward(self gettagangles("tag_flash")));
    waitframe();
  }

  self.var_e9765f437a2de9c0 = 1;
}

function function_126dd09da824d606(player, betweenvec) {
  if(!isDefined(player)) {
    return false;
  }

  if(player.team == self.owner.team) {
    return false;
  }

  if(!isreallyalive(player)) {
    return false;
  }

  if(!istrue(scripts\cp_mp\utility\player_utility::playersareenemies(player, self.owner))) {
    return false;
  }

  if(distancesquared(player.origin, self.origin) > 562500) {
    return false;
  }

  if(isDefined(self.var_894380476a44e139) && array_contains(self.var_894380476a44e139, player)) {
    return false;
  }

  anglebet = math::anglebetweenvectors(anglesToForward(self.angles), betweenvec);

  if(anglebet >= 90) {
    return false;
  }

  return true;
}

function function_a100143a05b7b873() {
  self endon("death");
  self endon("blindTurret_stopIdleMovements");
  self.isidling = 1;
  self.aimtarget unlink();
  direction = 1;
  startangles = self.angles;
  upmult = getdvarfloat(@ "hash_8bf7c4a92a43762", 15);
  fwdmult = getdvarfloat(@ "hash_476655d41cf371fa", 30);
  sidemult = getdvarfloat(@ "hash_59d07e54a840556c", 100);
  startloc = self gettagorigin("tag_aim_pivot") + anglesToForward(startangles) * fwdmult + anglestoup(startangles) * upmult;
  self.aimtarget.origin = startloc;
  self setconvergencetime(2.5, "pitch");
  self setconvergencetime(2.5, "yaw");

  while(true) {
    self cleartargetentity();
    waitframe();
    self settargetentity(self.aimtarget);
    direction *= -1;
    self.aimtarget.origin = startloc + anglestoright(startangles) * sidemult * direction;
    vecbetween = flatten_vector(self.aimtarget.origin - self.origin);
    turretangles = self gettagangles("tag_flash");
    anglebetween = math::anglebetweenvectors(anglesToForward(turretangles), vecbetween);

    while(anglebetween > 8) {
      turretangles = self gettagangles("tag_flash");
      anglebetween = math::anglebetweenvectors(flatten_vector(anglesToForward(turretangles)), vecbetween);
      waitframe();
    }
  }
}

function function_a8320570b3ed2b35() {
  possibletargets = [];
  var_124a2a5957983db8 = [];

  foreach(player in level.characters) {
    betweenvec = player.origin - self.origin;

    if(!function_126dd09da824d606(player, betweenvec)) {
      continue;
    }

    distratio = 1 - distancesquared(player.origin, self.origin) / 562500;
    distratio = clamp(distratio, 0, 1);
    angratio = 1 - math::anglebetweenvectors(anglesToForward(self.angles), betweenvec) / 90;
    angratio = clamp(angratio, 0, 1);
    weight = distratio * 0.75 + angratio * 0.25;
    possibletargets[possibletargets.size] = player;
    var_124a2a5957983db8[var_124a2a5957983db8.size] = weight;
  }

  if(possibletargets.size == 0) {
    return;
  }

  for(i = 0; i < var_124a2a5957983db8.size - 1; i++) {
    swapped = 0;

    for(j = 0; j < var_124a2a5957983db8.size - 1; j++) {
      if(var_124a2a5957983db8[j] < var_124a2a5957983db8[j + 1]) {
        tempplayer = possibletargets[j];
        tempweight = var_124a2a5957983db8[j];
        possibletargets[j] = possibletargets[j + 1];
        var_124a2a5957983db8[j] = var_124a2a5957983db8[j + 1];
        possibletargets[j + 1] = tempplayer;
        var_124a2a5957983db8[j + 1] = tempweight;
        swapped = 1;
      }
    }

    if(!swapped) {
      break;
    }
  }

  self.flashtarget = possibletargets[0];
}

function function_74b09da5a1249ff7() {
  self.isactive = 1;
  self setdefaultdroppitch(-89);
  self setmode("manual_target");

  if(!issentient(self)) {
    scripts\mp\sentientpoolmanager::registersentient("Killstreak_Ground", self.owner);
  }
}

function function_7d3a3fe4313463b4() {
  self notify("death");
  self delete();
}

function function_cad43242ef6c86b5() {
  self endon("death");
  function_b305f54dd4a77190();
  thread function_7d3a3fe4313463b4();
}

function function_b305f54dd4a77190() {
  level endon("game_ended");
  self.owner endon("disconnect");
  self.owner endon("joined_team");
  self.owner endon("joined_spectators");
  self.owner endon("blindingTurret_unset");
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(30);
}

function function_2beaf4844e5a4d16(grenade) {
  turretfwd = grenade.origin - self.origin;
  turretorientation = vectortoangles(flatten_vector(turretfwd));
  turret = spawnturret("misc_turret", grenade.origin, "blinding_turret_mp", 0);
  turret setModel("weapon_wm_mg_sentry_turret");
  turret makeunusable();
  turret setnodeploy(1);
  turret setdefaultdroppitch(0);
  turret maketurretinoperable();
  turret setleftarc(90);
  turret setrightarc(90);
  turret setbottomarc(50);
  turret settoparc(60);
  turret setconvergencetime(2.5, "pitch");
  turret setconvergencetime(2.5, "yaw");
  turret setconvergenceheightpercent(0.65);
  turret setdefaultdroppitch(-89);
  turret setturretmodechangewait(1);
  turret setmode("manual_target");
  turret.angles = turretorientation;
  turret.owner = self;
  turret setturretowner(self);
  turret setturretteam(self.team);
  turret.aimtarget = spawn_tag_origin(turret.origin, turret.angles);
  turret.aimtarget linkTo(turret, "tag_flash", (0, 0, 0), (0, 0, 0));
  turret.isidling = 0;
  grenade delete();
  return turret;
}