/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_39ae84cf3eeebf70.gsc
*************************************************/

#using script_3ed005fe9b78b9da;
#using scripts\cp_mp\emp_debuff;
#using scripts\cp_mp\utility\damage_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\gametypes\br_circle;
#using scripts\mp\hud_util;
#using scripts\mp\supers\super_emp_pulse;
#using scripts\mp\utility\game;
#using scripts\mp\utility\player;
#namespace namespace_f46cce884171ed03;

function function_51e961150661d4b4() {
  cooldowntime = getdvarfloat(@ "hash_1003a1525408b1fb", 7);
  addpowerbutton(self, "jump", ["+speed_throw", "+toggleads_throw", "+ads_akimbo_accessible"], &playerzombiejump, 0, undefined, &playerzombiejumpcleanup, undefined, &"MP_ZXP/CHARGED_JUMP", undefined, cooldowntime, "jumpStatus", "jumpProgress");
  addpowerbutton(self, "jumpStop", ["-speed_throw", "-toggleads_throw", "-ads_akimbo_accessible"], &playerzombiejumpstop, 0);
}

function function_58b5b82e9532c92b() {
  cooldowntime = getdvarfloat(@ "hash_5c6f048df99cb933", 4.5);
  addpowerbutton(self, "jump", ["+speed_throw", "+toggleads_throw", "+ads_akimbo_accessible"], &playerzombiejump, 0, undefined, &playerzombiejumpcleanup, undefined, &"MP_ZXP/CHARGED_JUMP", undefined, cooldowntime, "jumpStatus", "jumpProgress");
  addpowerbutton(self, "jumpStop", ["-speed_throw", "-toggleads_throw", "-ads_akimbo_accessible"], &playerzombiejumpstop, 0);
}

function playerzombiejump(powerstruct, powerref) {
  if(!isDefined(self)) {
    return;
  }

  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("zombie_unset");
  self endon("playerZombieJumpStop");
  var_4ca6e232b3a08ae5 = -1;
  self.var_ee75699e65f68166 = undefined;

  if(function_77bab0532bc12f0e()) {
    function_e63114420500fb();
    function_ae8ecf6e5f68f1ea(self.var_ee75699e65f68166);
    thread function_f2ddb7c78178c1be(powerstruct, powerref);
    return;
  }

  var_e8b1539c9f6ccbc1 = getdvarfloat(@ "hash_2fc6c2dc7f9c722a", 1);
  var_eec1ca5327266614 = getdvarfloat(@ "hash_f3adfe2ba0c4e72e", 0.25);
  var_6b00aa3867c7f0d9 = getdvarint(@ "hash_69111e35067f9d8f", var_4ca6e232b3a08ae5);
  var_57bd73d0ecaee169 = var_e8b1539c9f6ccbc1 * level.framedurationseconds;
  self.var_17c60a92aea65107 = 0;
  self allowmelee(0);
  self disableoffhandweapons();
  thread function_647ba9e9a0d700c7();
  thread superjumpfov();
  var_715d7709363e068c = undefined;
  progress = 0;

  if(!isDefined(self.var_741cb4edf0f0590c) || gettime() > self.var_741cb4edf0f0590c) {
    self playSound("jup_mp_mode_mutation_zombie_superjump_charge");
    self.var_741cb4edf0f0590c = gettime() + 500;
  }

  if(isDefined(powerstruct.powers[powerref].statusupdate)) {
    function_936f0ef6e203a7fc(powerstruct.powers[powerref].statusupdate, 0);
  }

  while(!function_77bab0532bc12f0e()) {
    if(level.var_ec4da42b3bbf344c.hudserver) {
      self.powershud[powerref].barelem updatebar(self.var_17c60a92aea65107, 0);
    } else {
      self.powershud[powerref].frac = self.var_17c60a92aea65107;
    }

    prevfrac = self.var_17c60a92aea65107;
    self.var_17c60a92aea65107 += var_57bd73d0ecaee169;

    if(self.var_17c60a92aea65107 >= 1) {
      self.var_17c60a92aea65107 = 1;

      if(var_6b00aa3867c7f0d9 >= 0) {
        if(!isDefined(var_715d7709363e068c)) {
          var_715d7709363e068c = gettime() + var_6b00aa3867c7f0d9 * 1000;

          if(level.var_ec4da42b3bbf344c.hudserver) {
            thread playerzombiejumpmaxholdwarning(powerref, var_6b00aa3867c7f0d9);
          }
        }

        if(gettime() >= var_715d7709363e068c) {
          break;
        }
      }
    }

    if(level.var_ec4da42b3bbf344c.hudserver && prevfrac < var_eec1ca5327266614 && self.var_17c60a92aea65107 >= var_eec1ca5327266614) {
      self.powershud[powerref].barelem.bar.color = (0, 1, 0);
    }

    if(prevfrac < 1 && self.var_17c60a92aea65107 >= 1) {
      self playlocalsound("zxp_charge_jump_full");
    }

    if(isDefined(powerstruct.powers[powerref].progressupdate)) {
      progress = max(int(self.var_17c60a92aea65107 * 100), 0);
      function_936f0ef6e203a7fc(powerstruct.powers[powerref].progressupdate, progress);
    }

    waitframe();
  }

  thread function_a1b195bc24dae315(powerstruct, powerref);
}

function playerzombiejumpcleanup(powerstruct, powerref, docooldown) {
  if(istrue(docooldown)) {
    thread playerpowerstartcooldown(powerstruct, powerref);
  }

  self setcamerathirdperson(0);
  self enableoffhandweapons();
  self.var_e11136acf00d18f = undefined;
  self.var_17c60a92aea65107 = undefined;
}

function function_77bab0532bc12f0e() {
  zombie = self;

  if(scripts\mp\utility\game::function_d75b73c443421047()) {
    if(!isDefined(zombie) || !scripts\mp\utility\game::function_7586e7f1e96dc16d()) {
      return true;
    }
  }

  if(scripts\mp\utility\game::ismutationgamemode()) {
    if(!isDefined(zombie) || !zombie scripts\mp\utility\game::ismutationgamemodezombie()) {
      return true;
    }
  }

  if(zombie meleeButtonPressed() || zombie attackButtonPressed()) {
    zombie.var_e11136acf00d18f = 1;
    return true;
  }

  if(zombie getstance() == "prone") {
    zombie.var_ee75699e65f68166 = "MP_BR_INGAME/ZMB_CHARGED_JUMP_ERROR_PRONE";
    return true;
  }

  if(zombie isswimunderwater()) {
    zombie.var_ee75699e65f68166 = "MP_BR_INGAME/ZMB_CHARGED_JUMP_ERROR_UNDERWATER";
    return true;
  }

  if(zombie ishanging()) {
    zombie.var_ee75699e65f68166 = "MP_BR_INGAME/ZMB_CHARGED_JUMP_ERROR_HANGING";
    return true;
  }

  if(zombie isparachuting()) {
    zombie.var_ee75699e65f68166 = "MP_BR_INGAME/ZMB_CHARGED_JUMP_ERROR_PARACHUTING";
    return true;
  }

  if(zombie isonladder()) {
    zombie.var_ee75699e65f68166 = "MP_BR_INGAME/ZMB_CHARGED_JUMP_ERROR_LADDER";
    return true;
  }

  if(zombie isinvehicle()) {
    return true;
  }

  return false;
}

function function_d4e7d5bfedb0b977() {
  if(level.var_ec4da42b3bbf344c.var_854edaec88caf865 != 0) {
    end = self.origin + (0, 0, level.var_ec4da42b3bbf344c.var_854edaec88caf865);
    result = playerphysicstrace(self.origin, end);

    if(result != end) {
      return false;
    }
  }

  if(level.var_ec4da42b3bbf344c.var_854ed7ec88caf1cc != 0) {
    start = self getEye();
    end = start + (0, 0, level.var_ec4da42b3bbf344c.var_854ed7ec88caf1cc);
    radius = 10;
    height = 20;
    contents = scripts\engine\trace::create_contents(0, 1, 0, 1, 0, 0, 1);
    result = scripts\engine\trace::capsule_trace(start, end, radius, height, (0, 0, 0), self, contents);

    if(result["fraction"] != 1) {
      return false;
    }
  }

  return true;
}

function superjumpfov() {
  player = self;
  player endon("death_or_disconnect");
  player notify("applyFOVPresentation");
  player endon("applyFOVPresentation");
  player lerpfovbypreset("zombiearcade");
  player waittill("endSuperJumpFov");
  player lerpfovbypreset("zombiedefault");
}

function playerzombiejumpmaxholdwarning(powerref, time) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("zombie_unset");
  self endon("playerZombieJumpStop");
  self endon("playerZombieJumpChargeEnd");

  if(time <= 0) {
    return;
  }

  waittimes = scripts\mp\gametypes\br_circle::array_init_distribute(time, int(time * 5), 1);
  color = 1;

  for(i = 0; i < waittimes.size; i++) {
    if(color) {
      self.powershud[powerref].barelem.bar.color = (1, 0, 0);
    } else {
      self.powershud[powerref].barelem.bar.color = (0, 1, 0);
    }

    wait waittimes[i];
    color = !color;
  }
}

function function_a3335da8620d547c(var_dd967d0c568c7873) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self allowjump(0);
  self setscriptablepartstate("skydiveVfx", "enabled_zombie", 0);
  wait 0.2;
  self enableoffhandweapons();
  self notify("endSuperJumpFov");

  if(!isbot(self)) {
    self forceplaygestureviewmodel("ges_zombie_superjump");
  }

  thread function_a0810cb7bb46ccdb();

  while(!function_bd2a29feef8f2889()) {
    waitframe();
  }

  self notify("zombie_jump_complete");
  fwd = vectorNormalize(anglesToForward(flat_angle(self.angles)));
  grenadeorigin = self.origin + fwd * 16 + (0, 0, 4);
  jumpdistance = distance2d(var_dd967d0c568c7873, self.origin);

  if(jumpdistance < getdvarint(@ "hash_bd303228300d36d7", 715)) {
    self.var_f56a71aaddbdd434 = 1;
  }

  if(is_equal(self.curclass, "default2")) {
    gren = magicgrenademanual("jup_mutant_leap_emp_impact_mp", grenadeorigin, (0, 0, 0), 0.1);
    gren detonate(self);
    thread function_58a7c3eb64d82c49();
  } else {
    gren = magicgrenademanual("jup_mutant_leap_impact_mp", grenadeorigin, (0, 0, 0), 0.1);
    gren detonate(self);
  }

  self stopgestureviewmodel("ges_zombie_superjump");
  self setscriptablepartstate("skydiveVfx", "default", 0);
  self playsoundtoplayer("zxp_splat_plr", self, self);
  self playSound("zmb_npc_breath_land_hi", self, self);
  self playSound("zxp_splat_npc", self, self);
  wait 0.2;
  self allowmelee(1);
  self allowjump(1);
  self.var_f56a71aaddbdd434 = undefined;
  self.var_1a7940ce78dd1720 = undefined;
}

function function_58a7c3eb64d82c49() {
  position = self.origin;
  ents = empdebuff_get_emp_ents(position, 500);
  objweapon = makeweapon("jup_mutant_leap_emp_impact_mp");
  self.var_3ff0b2483ea046e3 = [];

  foreach(ent in ents) {
    entowner = ent.owner;

    if(isDefined(entowner)) {
      if(!playersareenemies(self, entowner)) {
        continue;
      }
    }

    data = packdamagedata(self, ent, 1, objweapon, "MOD_EXPLOSIVE", self, position);
    thread function_25310643899068a8(data, 4);
  }

  players = getplayersinradius(position, 500);

  foreach(player in players) {
    if(!function_641436d9bd65f63c(self, player)) {
      continue;
    }

    data = packdamagedata(self, player, 1, objweapon, "MOD_EXPLOSIVE", self, position);
    thread emppulse_apply_player(data, 4);
  }
}

function function_a0810cb7bb46ccdb() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("zombie_jump_complete");

  while(true) {
    waittill_any_2("gas_grenade_finished", "zombie_shouting_finished");
    self forceplaygestureviewmodel("ges_zombie_superjump");
  }
}

function function_dd8a4b0712217000() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("zombie_unset");
  var_4992594dd7ee57b6 = getdvarfloat(@ "hash_1df491267fcc6307", 400);

  if(var_4992594dd7ee57b6 <= 0) {
    return;
  }

  maxspeed = getdvarfloat(@ "hash_a60f6bc28d9bc0c6", 1400);
  wait 0.2;

  while(!function_bd2a29feef8f2889()) {
    movementinput = self getnormalizedmovement();

    if(length(movementinput) > 0) {
      worlddir = rotatevector((movementinput[0], -1 * movementinput[1], 0), self.angles);
      velocity = self getvelocity();
      speed = length(velocity);
      var_3b61b63c7e59f697 = worlddir * var_4992594dd7ee57b6 * level.framedurationseconds;
      newvel = velocity + var_3b61b63c7e59f697;
      newspeed = length(newvel);

      if(newspeed <= maxspeed) {
        self setvelocity(newvel);
      } else if(speed < maxspeed) {
        newvel = vectorNormalize(newvel) * maxspeed;
        self setvelocity(newvel);
      }
    }

    waitframe();
  }
}

function function_bd2a29feef8f2889() {
  return self isonground() || self isonladder() || self ismantling() || self isswimming() || isinvehicle();
}

function playerapplyjumpvelocity(angledir, maxjumpvelocity, fraction, startoffset) {
  var_355760d151d56e05 = 1;
  var_b2d80e99c4ea7f00 = (0, 0, 20);

  if(!isDefined(startoffset)) {
    startoffset = var_b2d80e99c4ea7f00;
  }

  player_angles = angledir;
  ground_normal = (0, 0, 1);
  fwd = (1, 0, 0);

  if(getdvarint(@ "hash_ce6d7d66848cdbcc", var_355760d151d56e05)) {
    if(istrue(level.var_ec4da42b3bbf344c.var_5ba111ae6c83effe)) {
      ground_normal = get_ground_normal();

      if(!isDefined(ground_normal)) {
        ground_normal = (0, 0, 1);
      }
    }

    yawangles = (0, player_angles[1], 0);
    right = anglestoright(yawangles);
    fwd = vectorcross(ground_normal, right);
    fwd_angles = vectortoangles(fwd);
    ground_pitch = angleclamp180(fwd_angles[0]);
    min_pitch = -85;
    max_pitch = ground_pitch;
    player_pitch = player_angles[0];

    if(player_pitch > ground_pitch) {
      player_pitch = ground_pitch;
    }

    var_e6bc250926c6d64d = getdvarfloat(@ "hash_9ec479015407c245", -45);
    var_e6980f09269e2b33 = getdvarfloat(@ "hash_9ee78301542e1ffb", 0);
    frac = (player_pitch - min_pitch) / (max_pitch - min_pitch);
    var_aee49e405bf58492 = var_e6980f09269e2b33 + frac * (var_e6bc250926c6d64d - var_e6980f09269e2b33);
    player_angles = (player_pitch + var_aee49e405bf58492, player_angles[1], player_angles[2]);
  }

  pitch_add = getdvarfloat(@ "hash_cf56037c34ea141f", 0);

  if(pitch_add != 0) {
    player_angles = (player_angles[0] + pitch_add, player_angles[1], player_angles[2]);
  }

  dir = anglesToForward(player_angles);
  velocity = dir * fraction * maxjumpvelocity;
  velocity = (velocity[0], velocity[1], 450);
  var_53f40d8cc4675af8 = getdvarint(@ "hash_ba9532dc6da18eb8", 1);
  var_b9afb0cd7767d692 = getdvarint(@ "hash_439104b2c59c3927", 350);
  var_3bd94d9437370541 = getdvarint(@ "hash_601ddb2b970335e6", 1.3);

  if(var_53f40d8cc4675af8) {
    player_pitch = self getplayerangles()[0];

    if(player_pitch > 5) {
      velocity = (velocity[0] * var_3bd94d9437370541, velocity[1] * var_3bd94d9437370541, var_b9afb0cd7767d692);
    }
  }

  startorg = self.origin + startoffset;
  self setOrigin(startorg, 0);
  self setvelocity(velocity);
  glassradiusdamage(self.origin + (0, 0, 30), 30, 50, 51);
  fwddir = anglesToForward(self.angles);
  var_cc05c7fa92d3f6ba = self.origin + (0, 0, 30) + fwddir * 15;
  radiusdamage(var_cc05c7fa92d3f6ba, 100, 1, 1);
}

function get_ground_normal(traceignore, debug) {
  if(!isDefined(traceignore)) {
    ignore = self;
  } else {
    ignore = traceignore;
  }

  if(!isDefined(debug)) {
    debug = 0;
  }

  ignorelist = [ignore];
  tracepoints = [self.origin];
  i = -1;

  while(i <= 1) {
    j = -1;

    while(j <= 1) {
      corner = ignore getpointinbounds(i, j, 0);
      corner = (corner[0], corner[1], self.origin[2]);
      tracepoints[tracepoints.size] = corner;
      j += 2;
    }

    i += 2;
  }

  avgnormal = (0, 0, 0);
  tracehitcount = 0;

  foreach(point in tracepoints) {
    trace = scripts\engine\trace::_bullet_trace(point + (0, 0, 4), point + (0, 0, -16), 0, ignorelist);
    tracehit = trace["fraction"] > 0 && trace["fraction"] < 1;

    if(tracehit) {
      avgnormal += trace["normal"];
      tracehitcount++;
    }

    if(debug) {
      if(tracehit) {
        line(point, point + trace["<dev string:x1c>"] * 30, (0, 1, 0));
        continue;
      }

      sphere(point, 3, (1, 0, 0));
    }
  }

  if(tracehitcount > 0) {
    avgnormal /= tracehitcount;

    if(debug) {
      line(self.origin, self.origin + avgnormal * 20, (1, 1, 1));
    }

    return avgnormal;
  }

  if(debug) {
    sphere(self.origin, 5, (1, 0, 0));
  }

  return undefined;
}

function playerzombiejumpstop(powerstruct, powerref) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  waittillframeend();

  if(isDefined(self.var_17c60a92aea65107)) {
    function_a1b195bc24dae315(powerstruct, "jump");
    return;
  }

  self notify("playerZombieJumpStop");
}

function function_a1b195bc24dae315(powerstruct, powerref) {
  self stopgestureviewmodel("ges_zombie_superjumpcharge");
  self notify("playerZombieJumpChargeEnd");
  self notify("playerZombieJumpStop");
  var_eec1ca5327266614 = getdvarfloat(@ "hash_f3adfe2ba0c4e72e", 0.25);
  var_e5482b00771c4909 = getdvarint(@ "hash_2a5201ccbcd3b1a1", 1);
  var_b13a0e71ef0de57c = 1;

  if(self.var_17c60a92aea65107 >= var_eec1ca5327266614 && !function_77bab0532bc12f0e() && function_d4e7d5bfedb0b977() && !self ismantling() && !isinvehicle()) {
    self playsoundtoplayer("zxp_superjump_vo", self, self);
    self playsoundonmovingent("zxp_superjump_sfx_npc");
    self playsoundonmovingent("jup_mp_mode_mutation_zombie_superjump_leap");
    self playsoundonmovingent("jup_mp_mode_mutation_zombie_superjump_whoosh");
    maxjumpvelocity = getdvarfloat(@ "hash_fd6822a1c2607510", 1300);
    player_angles = self getplayerangles();
    self.var_1a7940ce78dd1720 = 1;
    thread function_a3335da8620d547c(self.origin);
    playerapplyjumpvelocity(player_angles, maxjumpvelocity, self.var_17c60a92aea65107);
    thread function_dd8a4b0712217000();
    self.var_f07121951ba8e9a5 = undefined;
    self.var_741cb4edf0f0590c = undefined;
  } else {
    if(var_e5482b00771c4909) {
      if(level.var_ec4da42b3bbf344c.hudserver) {
        self.powershud[powerref].barelem.bar.frac = 0;
      } else {
        self.powershud[powerref].frac = 0;
      }

      function_936f0ef6e203a7fc(powerstruct.powers[powerref].progressupdate, 0);
      self enableoffhandweapons();
      self allowmelee(1);
      self notify("endSuperJumpFov");
    }

    function_e63114420500fb();
    thread function_f2ddb7c78178c1be(powerstruct, powerref);

    if(istrue(self.var_e11136acf00d18f)) {
      function_936f0ef6e203a7fc(powerstruct.powers[powerref].progressupdate, 100);
      var_b13a0e71ef0de57c = 0;
    }
  }

  playerzombiejumpcleanup(powerstruct, powerref, var_b13a0e71ef0de57c);
}