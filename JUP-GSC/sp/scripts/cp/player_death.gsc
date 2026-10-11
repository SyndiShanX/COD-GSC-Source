/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\cp\player_death.gsc
***********************************************/

#using script_48324b060b129b7b;
#using scripts\common\damage_effects;
#using scripts\common\gameskill;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp\cp_analytics;
#using scripts\cp\cp_gameskill;
#using scripts\cp\utility;
#using scripts\cp\utility\player;
#using scripts\engine\math;
#using scripts\engine\trace;
#using scripts\engine\utility;
#namespace player_death;

function init_player_death() {
  precacheshader("hud_icon_grenade_incoming_frag_sp");
  precacheshader("hud_burningcaricon");
  precacheshader("hud_icon_exploding_car_red");
  precacheshader("hud_destructibledeathicon");
  precacheshader("hud_burningbarrelicon");
  precacheshader("ui_player_death_overlay");
  precacheshader("ui_player_death_tunnel_overlay");
  precacheshader("ui_player_death_black_overlay");
  precachestring(&"SCRIPT/GRENADE_DEATH");
  precachestring(&"SCRIPT/GRENADE_SUICIDE");
  precachestring(&"SCRIPT/EXPLODING_VEHICLE_DEATH");
  precachestring(&"SCRIPT/EXPLODING_DESTRUCTIBLE_DEATH");
  precachestring(&"SCRIPT/EXPLODING_BARREL_DEATH");
  precachestring(&"SCRIPT/JUGGDEATH_1");
  precachestring(&"SCRIPT/JUGGDEATH_2");
  precachestring(&"SCRIPT/JUGGDEATH_3");
  initdeathvfx();
  init_player_animated_death();

  setdvarifuninitialized(@ "hash_26b05071ada59342", "<dev string:x1c>");
  setdvarifuninitialized(@ "hash_74440f96ecf38e11", "<dev string:x1c>");
  setdvarifuninitialized(@ "debug_player_death", 0);

  thread main();
}

function initdeathvfx() {
  level.g_effect["player_death_fire"] = loadfx("vfx/iw8/core/player/vfx_player_death_fire.vfx");
}

function init_player_animated_death() {
  while(!isDefined(level.players[0])) {
    waitframe();
  }

  level.players[0].death = spawnStruct();
  level.players[0].death.deaths = [];
  register_deaths();
  setDvar(@ "hash_72b7a039560ba3d2", 1);
}

function register_deaths() {
  if(!isDefined(level.player_death_override)) {
    register_player_death("fire", "stand", "vm_death_fire_01", ["player_death_fall_left", "plr_death_flop"], "origin", 0);
    register_player_death("default", "stand", "vm_death_b_01", ["player_death_fall_left", "plr_death_flop"], "forward", 100);
    register_player_death("default", "stand", "vm_death_b_02", ["player_death_fall_back", "plr_death_flop"], "forward", 70);
    register_player_death("default", "stand", "vm_death_f_01", ["player_death_stand_left", "plr_death_flop"], "back", 45);
    register_player_death("default", "stand", "vm_death_f_02", ["player_death_stand_left", "plr_death_flop"], "back", 100);
    register_player_death("default", "stand", "vm_death_f_03", ["player_death_stand_left", "plr_death_flop"], "forward", 70);
    register_player_death("default", "stand", "vm_death_l_01", ["player_death_stand_left", "plr_death_flop"], "left", 74);
    register_player_death("default", "stand", "vm_death_r_01", ["player_death_stand_left", "plr_death_flop"], "right", 64);
    register_player_death("default", "stand", "vm_death_generic_01", ["player_death_fall_back", "plr_death_flop"], "origin", 0);
  }

  setDvar(@ "hash_c8da45de891dc5cb", 0);
  setDvar(@ "hash_c8da46de891dc7fe", 0);
  setDvar(@ "hash_c8da47de891dca31", 0);
}

function register_player_death(type, stance, gesture, soundalias, direction, falldist, deathfunc) {
  if(stance != "stand" && stance != "crouch" && stance != "prone") {
    assertmsg("stance " + stance + "does not = <stand> <crouch> or <prone>");
  }

  death = spawnStruct();
  death.gesture = gesture;
  death.soundalias = soundalias;
  death.type = type;
  death.stance = stance;
  death.falldir = direction;
  death.falldist = falldist;

  if(isDefined(deathfunc)) {
    death.function = deathfunc;
  }

  level.players[0].death.deaths = array_add_safe(level.players[0].death.deaths, death);
  return death;
}

function main() {
  thread debug_draw_slope_angles();

  level.players[0] thread player_throwgrenade_timer();
  level.players[0] waittill("killed_player", attacker, cause, objweapon, inflictor);
  movingplatform = undefined;

  if(isDefined(attacker) && is_equal(attacker.asmname, "suicidebomber") && !istrue(level.players[0].suicide_bomber_death_quote_skip)) {
    if(!isDefined(level.custom_death_quote)) {
      set_custom_death_quote(57);
    }
  }

  level.players[0] scripts\cp\cp_gameskill::auto_adjust_playerdied();
  weaponname = undefined;

  if(isDefined(objweapon)) {
    weaponname = getcompleteweaponname(objweapon);
  }

  level.players[0] scripts\cp\cp_analytics::logevent_playerdeath(attacker, cause, weaponname);
  level.players[0] setpriorityclienttriggeraudiozonepartial("deathsdoor", "deathsdoor", "reverb");
  level.players[0] scripts\common\damage_effects::function_501be800abf11f33();
  level.players[0] shellshock("default_nosound", 3);
  level.players[0] playSound("deaths_door_death");
  level.players[0] thread deathmusic();
  level.players[0] thread namespace_23750629c2b7a3d3::stop_deaths_door_audio();
  level.players[0] allowmelee(0);
  level.players[0] hidelegsandshadow();
  level.players[0] val::set_array("cp_death", ["nvg", "autoreload"], 0);
  function_537904608904bafe();
  setsaveddvar(@ "cg_drawcrosshair", 0);

  if(isDefined(level.players[0].var_5d845f5108d98419)) {
    level.players[0][[level.players[0].var_5d845f5108d98419]]();
    function_202cb21796eab2c0();
    return;
  }

  stance = get_stance();
  running = playerwasrunning();
  deathscene = get_animated_player_death(stance, running, cause, movingplatform, attacker);
  level.players[0] thread setdeathangles(attacker, stance, deathscene, movingplatform);

  if(isDefined(deathscene)) {
    thread gesture_death_anim(deathscene);
  } else {
    thread non_gesture_death_anim();
  }

  level.players[0] thread deathfx(cause);

  if(isDefined(level.var_428685eb57081750)) {
    wait level.var_428685eb57081750;
  } else {
    wait 1.4;
  }

  thread set_death_hint(attacker, cause, weaponname, inflictor);
  wait 1;
  wait_remaining_time_or_player_input(3.2);
  function_202cb21796eab2c0();
}

function function_202cb21796eab2c0() {
  setDvar(@ "hash_72b7a039560ba3d2", 1);
}

function get_stance() {
  if(level.players[0] issprintsliding()) {
    return "crouch";
  }

  if(level.players[0] isdiving()) {
    return "prone";
  }

  return level.players[0] getstance();
}

function wait_remaining_time_or_player_input(waittime) {
  level.players[0] endon("use_pressed");
  level.players[0] endon("weapon_switch_pressed");
  level.players[0] endon("jump_pressed");
  level.players[0] endon("stance_pressed");
  wait waittime;
}

function timerwait(time) {
  waittime = time - self.waitedtime;

  if(waittime <= 0) {
    return;
  }

  wait time - self.waitedtime;
  self.waitedtime += time;
}

function non_gesture_death_anim() {
  tossgun();
  level.players[0] takeallweapons();
}

function playerwasrunning() {
  stance = level.players[0] getstance();
  sliding = level.players[0] issprintsliding();

  if(level.players[0] getnormalizedmovement()[0] > 0.7 && isDefined(stance) && stance == "stand" && !sliding) {
    running = 1;
    return;
  }

  running = 0;
}

function get_animated_player_death(stance, running, cause, movingplatform, attacker) {
  if(!player_death_animation_enabled()) {
    return;
  }

  if(isDefined(movingplatform)) {
    return;
  }

  overridecause = getDvar(@ "hash_26b05071ada59342");

  if(isDefined(overridecause) && overridecause != "<dev string:x1c>") {
    cause = overridecause;
  }

  if(!level.players[0] isonground()) {
    return;
  }

  death_scene = pick_death(stance, running, cause, attacker);

  if(isDefined(death_scene)) {
    return death_scene;
  }

  return;
}

function pick_death(stance, running, cause, attacker) {
  death = undefined;

  if(deathisanimexempt(cause)) {
    return undefined;
  }

  type = getdeathtypefromcause(cause);
  deaths = getdeathsfortypeandstance(type, stance);
  death = try_deaths(deaths, cause, attacker);

  if(getdvarint(@ "debug_player_death", 0) == 1) {
    if(deaths.size == 0) {
      println("<dev string:x1d>");
    } else if(!isDefined(death)) {
      println("<dev string:x4c>");
    }
  }

  return death;
}

function getdeathsfortypeandstance(type, stance) {
  deaths = level.players[0].death.deaths;

  foreach(death in deaths) {
    if(death.type != type || death.stance != stance) {
      deaths = array_remove(deaths, death);
    }
  }

  onground = level.players[0] isonground();

  foreach(death in deaths) {
    if(!onground && death.falldir != "origin") {
      deaths = array_remove(deaths, death);
    }
  }

  return deaths;
}

function getdeathtypefromcause(cause) {
  if(isDefined(cause) && damage_is_fire(cause)) {
    return "fire";
  }

  if(isDefined(cause) && damage_is_explosive(cause)) {
    return "explo";
  }

  return "default";
}

function deathisanimexempt(cause) {
  if(!isDefined(cause)) {
    return true;
  }

  if(cause == "MOD_SUICIDE" || cause == "MOD_TRIGGER_HURT") {
    return true;
  }

  if(isnullweapon(level.players[0] getcurrentweapon())) {
    return true;
  }

  return false;
}

function try_deaths(deaths, cause, attacker) {
  deaths = array_randomize(deaths);

  foreach(death in deaths) {
    if(death validatefalldirection(cause, attacker)) {
      return death;
    }
  }

  return undefined;
}

function tossgun(model) {
  if(!isDefined(model)) {
    model = getweaponmodel(level.players[0] getcurrentprimaryweapon());
  }

  gun_model = spawn("script_model", level.players[0].origin + (0, -7, 20));
  gun_model setModel(model);

  if(!gun_model physics_getnumbodies()) {
    gun_model delete();
    return;
  }

  gun_model.angles = level.players[0].angles + (randomintrange(-20, 20), randomintrange(-20, 20), randomintrange(-20, 20));
  launchforce = anglesToForward(level.players[0].angles);
  launchforce *= randomfloatrange(600, 750);
  forcex = launchforce[0];
  forcey = launchforce[1];
  forcez = randomfloatrange(400, 600);
  gun_model physicslaunchserver(gun_model.origin, (forcex, forcey, forcez));
}

function validatefalldirection(cause, attacker) {
  starttrace = level.players[0].origin + (0, 0, 2);
  endtrace = undefined;

  if(cause == "MOD_GRENADE" || cause == "MOD_GRENADE_SPLASH") {
    var_85e28f54b572f39f = angleclamp(vectortoyaw(level.players[0].dmgpoint - level.players[0].origin) - level.players[0].angles[1]);
  } else {
    var_85e28f54b572f39f = angleclamp(vectortoyaw(attacker.origin - level.player.origin) - level.player.angles[1]);
  }

  if(cause == "MOD_FIRE" || self.falldir == "origin") {
    endtrace = starttrace;
  } else if(var_85e28f54b572f39f > 135 && var_85e28f54b572f39f <= 225 && self.falldir == "forward") {
    endtrace = starttrace + anglesToForward(level.players[0].angles) * self.falldist;
  } else if(var_85e28f54b572f39f > 45 && var_85e28f54b572f39f <= 135 && self.falldir == "right") {
    endtrace = starttrace + anglestoright(level.players[0].angles) * self.falldist;
  } else if((var_85e28f54b572f39f <= 45 || var_85e28f54b572f39f >= 315) && self.falldir == "back") {
    endtrace = starttrace + anglesToForward(level.players[0].angles) * -1 * self.falldist;
  } else if(var_85e28f54b572f39f > 225 && var_85e28f54b572f39f < 315 && self.falldir == "left") {
    endtrace = starttrace + anglestoleft(level.players[0].angles) * self.falldist;
  } else {
    if(getdvarint(@ "debug_player_death", 0) == 1) {
      println("<dev string:x84>" + self.falldir + "<dev string:x87>");
    }

    return 0;
  }

  if(capsule_check(starttrace, endtrace)) {
    debug_player_death(self.falldir, endtrace, "passed");
    return 1;
  }

  debug_player_death(self.falldir, endtrace, "failed");
  return 0;
}

function capsule_check(start, end) {
  if(scripts\engine\trace::capsule_trace_passed(start, end, 15, 72, (0, 0, 0), level.players[0])) {
    return true;
  }

  return false;
}

function debug_player_death(falldir, endtrace, outcome) {
  color = (1, 0, 0);

  if(getdvarint(@ "debug_player_death", 0) == 1) {
    if(outcome == "<dev string:x9a>") {
      println("<dev string:xa1>" + falldir + "<dev string:xa4>");
      color = (0, 1, 0);
      draw_capsule(level.players[0].origin, 15, 72, color, (0, 0, 0), 0, 200);
      draw_arrow_time(level.players[0].origin, endtrace, (0, 1, 0), 200);
    } else {
      println("<dev string:x84>" + falldir + "<dev string:xb5>");
    }

    if(falldir != "<dev string:xc5>") {
      draw_capsule(endtrace, 15, 72, color, (0, 0, 0), 0, 200);
    }
  }

}

function gesture_death_anim(death) {
  takeweaponsexceptcurrent();
  level.players[0].ignoreme = 1;
  anim_time = level.players[0] getgestureanimlength(death.gesture);

  if(getdvarint(@ "debug_player_death", 0) == 1) {
    println("<dev string:xcc>" + death.falldir + "<dev string:xe9>" + death.type);
  }

  if(isDefined(death.function)) {
    level thread[[death.function]]();
  }

  if(isarray(death.soundalias)) {
    foreach(alias in death.soundalias) {
      level.players[0] thread play_sound_in_space(alias, level.players[0].origin);
    }
  } else {
    level.players[0] playSound(death.soundalias);
  }

  bool = level.players[0] forceplaygestureviewmodel(death.gesture, undefined, 0.15, undefined, 1, 1);
}

function setdeathangles(attacker, stance, gesturedeath, movingplatform) {
  freeze_player_controls(stance);
  abovemovingplatform = 0;

  if(isDefined(movingplatform)) {
    var_6db2d5a220eeab39 = scripts\engine\trace::create_playerclip_contents();
    trace = scripts\engine\trace::ray_trace(self.origin, self.origin - (0, 0, 1000), self, var_6db2d5a220eeab39);
    hitent = undefined;

    if(isDefined(trace)) {
      hitent = trace["entity"];
    }

    if(isDefined(hitent) && hitent == movingplatform) {
      abovemovingplatform = 1;
    } else {
      abovemovingplatform = 0;
    }
  }

  if(!isDefined(movingplatform) || !abovemovingplatform) {
    while(!self isonground()) {
      wait 0.05;
    }
  }

  if(isDefined(attacker) && attacker == self) {
    var_e2064085ef59a3a9 = self.angles;
  } else {
    var_e2064085ef59a3a9 = get_angles_to_attacker(attacker);
  }

  playerangles = level.player getplayerangles();

  if(isDefined(gesturedeath)) {
    rotatetoattackertime = 0.75;
    var_ca59f0c3b6b71635 = 0;
    extraroll = 0;
  } else {
    playerf = anglesToForward(playerangles);
    attackerf = anglesToForward(var_e2064085ef59a3a9);
    dot = vectordot(attackerf, playerf);
    dotfactor = math::normalize_value(-1, 1, dot);
    rotatetoattackertime = math::factor_value(0.4, 0.2, dotfactor);
    var_f1fd8e00747372e5 = geteyeheightfromstance(stance);
    var_ca59f0c3b6b71635 = 13 - var_f1fd8e00747372e5;
    extraroll = randomfloatrange(20, 40);

    if(cointoss()) {
      extraroll *= -1;
    }
  }

  anchor = level.players[0] spawn_tag_origin();
  anchor.angles = playerangles;
  goalangles = (var_e2064085ef59a3a9[0], var_e2064085ef59a3a9[1], var_e2064085ef59a3a9[2] + extraroll);
  downwardoffset = anglestoup(goalangles) * var_ca59f0c3b6b71635;
  goalpos = self.origin + downwardoffset;
  thread function_75d6b697583ffbb7(anchor, rotatetoattackertime * 0.5);

  if(getdvarint(@ "debug_player_death")) {
    linelength = 30;
    var_fe48d2bf2a03fbb0 = self.origin + anglesToForward(goalangles) * linelength;
    var_ef19226e6d4de8fc = self.origin + anglestoright(goalangles) * linelength;
    var_b29ebe00f415a2f1 = self.origin + anglestoup(goalangles) * linelength;
    line(self.origin, var_fe48d2bf2a03fbb0, (1, 0, 0), 1, 0, 1000);
    line(self.origin, var_ef19226e6d4de8fc, (0, 1, 0), 1, 0, 1000);
    line(self.origin, var_b29ebe00f415a2f1, (0, 0, 1), 1, 0, 1000);
    upoffset = (0, 0, 45);
    line(self.origin + upoffset, attacker.origin + upoffset, (1, 1, 1), 1, 0, 1000);
  }

  if(isDefined(movingplatform) && abovemovingplatform) {
    anchor linkTo(movingplatform);
    anchor thread updatelinkedoriginandangles(goalpos, goalangles, rotatetoattackertime, movingplatform);
    return;
  }

  anchor rotateTo(goalangles, rotatetoattackertime, rotatetoattackertime * 0.25, rotatetoattackertime * 0.75);
  anchor moveTo(goalpos, rotatetoattackertime, rotatetoattackertime * 0.9, rotatetoattackertime * 0.1);
}

function function_75d6b697583ffbb7(anchor, time) {
  self playerlinkTo(anchor, "tag_origin", 1, 0, 0, 0, 0);
}

function updatelinkedoriginandangles(targetorigin, targetangles, rotatetoattackertime, parent) {
  timer = rotatetoattackertime;
  targetoriginrelative = rotatevectorinverted(targetorigin - parent.origin, parent.angles);
  startingoriginrelative = rotatevectorinverted(self.origin - parent.origin, parent.angles);
  targetfrelative = rotatevectorinverted(anglesToForward(targetangles), parent.angles);
  targetrrelative = rotatevectorinverted(anglestoright(targetangles), parent.angles);
  targeturelative = rotatevectorinverted(anglestoup(targetangles), parent.angles);
  startingfrelative = rotatevectorinverted(anglesToForward(self.angles), parent.angles);
  startingrrelative = rotatevectorinverted(anglestoright(self.angles), parent.angles);
  startingurelative = rotatevectorinverted(anglestoup(self.angles), parent.angles);
  safeorigin = parent.origin;
  safeangles = parent.angles;

  while(true) {
    if(timer <= 0) {
      break;
    }

    if(isDefined(parent)) {
      safeorigin = parent.origin;
      safeangles = parent.angles;
    }

    timefactor = math::normalize_value(0, rotatetoattackertime, timer);

    if(self islinked()) {
      self unlink();
    }

    targetorigin = rotatevector(targetoriginrelative, safeangles) + safeorigin;
    startingorigin = rotatevector(startingoriginrelative, safeangles) + safeorigin;
    targetf = rotatevector(targetfrelative, safeangles);
    targetr = rotatevector(targetrrelative, safeangles);
    targetu = rotatevector(targeturelative, safeangles);
    startingf = rotatevector(startingfrelative, safeangles);
    startingr = rotatevector(startingrrelative, safeangles);
    startingu = rotatevector(startingurelative, safeangles);
    f = vectorNormalize(math::factor_value(targetf, startingf, timefactor));
    r = vectorNormalize(math::factor_value(targetr, startingr, timefactor));
    u = vectorNormalize(math::factor_value(targetu, startingu, timefactor));
    self.origin = math::factor_value(targetorigin, startingorigin, timefactor);
    self.angles = axistoangles(f, r, u);

    if(isDefined(parent)) {
      self linkTo(parent);
    }

    timer -= 0.05;
    wait 0.05;
  }

  if(self islinked()) {
    self unlink();
  }

  if(isDefined(parent)) {
    safeorigin = parent.origin;
    safeangles = parent.angles;
  }

  f = rotatevector(targetfrelative, safeangles);
  r = rotatevector(targetrrelative, safeangles);
  u = rotatevector(targeturelative, safeangles);
  self.origin = rotatevector(targetoriginrelative, safeangles) + safeorigin;
  self.angles = axistoangles(f, r, u);

  if(isDefined(parent)) {
    self linkTo(parent);
  }
}

function geteyeheightfromstance(stance) {
  height = level.players[0] getplayerviewheight(stance);
  return height;
}

function get_ground_slope_angles(direction) {
  direction = vectorNormalize(direction);
  up = (0, 0, 60);
  out = 15 * direction;
  resulta = scripts\engine\trace::ray_trace(self.origin + out + up, self.origin + out - up, [self]);
  resultb = scripts\engine\trace::ray_trace(self.origin - out + up, self.origin - out - up, [self]);

  if(resulta["hittype"] == "hittype_none") {
    pointa = self.origin;
  } else {
    pointa = resulta["position"];
  }

  if(resultb["hittype"] == "hittype_none") {
    pointb = self.origin;
  } else {
    pointb = resultb["position"];
  }

  dist = distance2d(pointa, pointb);

  if(dist > 0) {
    slope = atan((pointb[2] - pointa[2]) / dist);

    if(abs(slope) > 45) {
      return 0;
    }

    return slope;
  }

  return 0;
}

function get_angles_to_attacker(attacker) {
  if(!isDefined(attacker)) {
    return self.angles;
  }

  maxpitch = 30;
  ang = vectortoangles(attacker.origin - self.origin);
  ang = (0, angleclamp180(ang[1]), angleclamp180(ang[2]));
  return ang;
}

function debug_draw_slope_angles() {
  while(true) {
    if(getdvarint(@ "hash_fa41fbd3ef1e4209")) {
      pitch = level.players[0] get_ground_slope_angles(anglesToForward(level.players[0].angles));
      roll = level.players[0] get_ground_slope_angles(anglestoright(level.players[0].angles));
      eyepos = level.players[0] getEye();
      line(eyepos, eyepos + rotatevector((cos(pitch), 0, -1 * sin(pitch)) * 50, level.players[0].angles), (0, 1, 0), 1, 0, 1);
      line(eyepos, eyepos + rotatevector((0, cos(roll), sin(roll)) * 50, level.players[0].angles), (0, 0, 1), 1, 0, 1);
    }

    wait 0.05;
  }
}

function freeze_player_controls(stance) {
  level.gameskill_breath_func = &empty_breathing_func;
  level.players[0] freezecontrols(1);

  if(stance == "prone") {
    level.players[0] allowprone(1);
    level.players[0] allowstand(0);
    level.players[0] allowcrouch(0);
  } else if(stance == "crouch") {
    level.players[0] allowcrouch(1);
    level.players[0] allowstand(0);
    level.players[0] allowprone(0);
  } else {
    level.players[0] allowstand(1);
    level.players[0] allowprone(0);
    level.players[0] allowcrouch(0);
  }

  level.players[0] disableweaponswitch();
  level.players[0] disableoffhandsecondaryweapons();
  level.players[0] allowoffhandshieldweapons(0);
  level.players[0] disableoffhandweapons();
  level.players[0] allowjump(0);
  level.players[0] allowfire(0);
  level.players[0] freezecontrols(0);
}

function deathfx(cause) {
  blackfadetime = 3;
  blurfadetime = 2;
  level.players[0].death.huds = [];

  if(isDefined(level.players[0].death.skip_screen_fx)) {
    return;
  }

  if(utility::iswegameplatform()) {
    return;
  }

  level.players[0] scripts\cp\utility\player::remove_damage_effects_instantly(1);
  visionsetpain("damage_dead", 0.2);
  namespace_23750629c2b7a3d3::set_slowmo_dialogue_start();
  setslowmotion(1, 0.8, 4.5);
  setsaveddvar(@ "hash_b61c9c6a24b5671e", 100);
  self painvisionon();

  if(isDefined(cause) && cause == "MOD_FIRE") {
    thread deathfxfire();
  } else {
    thread deathfxoverlay("death_overlay", "ui_player_death_overlay", 0, 0, 18);
  }

  thread deathfxoverlay("death_tunnel", "ui_player_death_tunnel_overlay", 1, 3, 19);
  thread deathfxoverlay("death_black", "ui_player_death_black_overlay", 1, blackfadetime, 20);
  wait 4;
  level.players[0] setblurforplayer(6, blurfadetime);
}

function deathmusic() {
  clearmusicstate();
  self clearsoundsubmix("jup_global_igc_skip");
  self setsoundsubmix("jup_global_death", 2);
  wait 1;

  if(soundexists("jup_spl_death_stinger_lr")) {
    self playSound("jup_spl_death_stinger_lr");
  }
}

function deathfxoverlay(name, shader, delay, fadetime, sort) {
  wait delay;
  level.players[0].death.huds[name] = create_death_hudelem();
  level.players[0].death.huds[name] setshader(shader, 640, 480);

  if(fadetime > 0) {
    level.players[0].death.huds[name] fadeovertime(fadetime);
  }

  level.players[0].death.huds[name].alpha = 1;
  level.players[0].death.huds[name].sort = sort;
}

function deathfxfire() {
  playFX(level.g_effect["player_death_fire"], level.players[0].origin, anglesToForward(level.players[0].angles), anglestoup(level.players[0].angles));
}

function player_can_see_an_enemy() {
  enemies = getaiarray("axis");

  foreach(enemy in enemies) {
    if(!within_fov(level.players[0].origin, level.players[0].angles, enemy.origin, 0.173648)) {
      continue;
    }

    if(can_trace_to_ai(level.players[0] getEye(), enemy, [level.players[0]])) {
      return true;
    }
  }

  return false;
}

function create_death_hudelem() {
  overlay = newclienthudelem(self);
  overlay.x = 0;
  overlay.y = 0;
  overlay.splatter = 1;
  overlay.alignx = "left";
  overlay.aligny = "top";
  overlay.sort = 1;
  overlay.foreground = 0;
  overlay.lowresbackground = 1;
  overlay.horzalign = "fullscreen";
  overlay.vertalign = "fullscreen";
  overlay.alpha = 0;
  overlay.enablehudlighting = 1;
  return overlay;
}

function takeweaponsexceptcurrent() {
  keepers = [];
  current_gun = level.players[0] getcurrentweapon();
  keepers[keepers.size] = current_gun;

  if(current_gun.isalternate) {
    keepers[keepers.size] = current_gun getnoaltweapon();
  } else if(current_gun.hasalternate) {
    keepers[keepers.size] = current_gun getaltweapon();
  }

  foreach(weapon in level.players[0] getweaponslistall()) {
    if(!array_contains(keepers, weapon)) {
      level.players[0] takeweapon(weapon);
    }
  }
}

function player_throwgrenade_timer() {
  self endon("death");
  self.lastgrenadetime = 0;

  while(true) {
    while(!self isthrowinggrenade()) {
      wait 0.05;
    }

    self.lastgrenadetime = gettime();

    while(self isthrowinggrenade()) {
      wait 0.05;
    }
  }
}

function vehicle_death(inflictor) {
  if(!isDefined(inflictor)) {
    return false;
  }

  if(inflictor.code_classname != "scriptable") {
    return false;
  }

  if(!isDefined(inflictor.destructible_type) || inflictor.destructible_type != "vehicle") {
    return false;
  }

  level notify("new_quote_string4");
  setomnvar("ui_death_hint", 3);
  return true;
}

function destructible_death(attacker) {
  if(!isDefined(attacker) || !isDefined(attacker.destructible_type)) {
    return false;
  }

  level notify("new_quote_string");

  if(isDefined(attacker.destructible_type) && issubstr(attacker.destructible_type, "vehicle")) {
    setomnvar("ui_death_hint", 3);
  } else {
    setomnvar("ui_death_hint", 4);
  }

  return true;
}

function exploding_barrel_death(inflictor, weaponname) {
  if(!isDefined(inflictor)) {
    return false;
  }

  if(inflictor is_red_barrel()) {
    level notify("new_quote_string");
    setomnvar("ui_death_hint", 5);
    return true;
  }

  return false;
}

function is_red_barrel() {
  if(isDefined(self.targetname) && self.targetname == "phys_barrel_destructible") {
    return true;
  }

  if(isDefined(self.model) && issubstr(self.model, "barrel") && issubstr(self.model, "red")) {
    return true;
  }

  return false;
}

function set_custom_death_quote(var_54a746638868babe, var_9a2d6fd311c8922a) {
  level.custom_death_quote = var_54a746638868babe;
  level.var_6f691dd8b1000ea5 = var_9a2d6fd311c8922a;
}

function clear_custom_death_quote() {
  level.custom_death_quote = undefined;
}

function set_death_hint_standard() {
  index = 100;
  var_52069547004fbedb = undefined;
  var_fa6e42ecc66a5fb5 = tablelookup("cp/death_hints.csv", 0, index, 1);

  while(isDefined(var_fa6e42ecc66a5fb5) && var_fa6e42ecc66a5fb5 != "__END_OF_DEADQUOTE__") {
    var_52069547004fbedb = index;
    var_fa6e42ecc66a5fb5 = tablelookup("cp/death_hints.csv", 0, index, 1);
    index++;
  }

  while(true) {
    deadquoteindex = randomintrange(100, var_52069547004fbedb);

    if(!function_46f8b8c2648b7356(deadquoteindex)) {
      break;
    }

    waitframe();
  }

  function_e3fc2e2cf55641cd(deadquoteindex);
  setomnvar("ui_death_hint", deadquoteindex);
}

function set_death_hint(attacker, cause, weaponname, inflictor) {
  var_c5950a5e5a6f62ad = undefined;
  var_1532dcb8b7dc97cc = istrue(level.var_6f691dd8b1000ea5);

  if(isDefined(level.custom_death_quote) && (!var_1532dcb8b7dc97cc || !function_46f8b8c2648b7356(level.custom_death_quote))) {
    var_c5950a5e5a6f62ad = level.custom_death_quote;
  }

  if(getdvarint(@ "hash_74440f96ecf38e11") > 0) {
    var_c5950a5e5a6f62ad = getdvarint(@ "hash_74440f96ecf38e11");
  }

  if(isDefined(var_c5950a5e5a6f62ad)) {
    if(var_c5950a5e5a6f62ad > 0) {
      setomnvar("ui_death_hint", var_c5950a5e5a6f62ad);

      if(var_1532dcb8b7dc97cc) {
        function_e3fc2e2cf55641cd(var_c5950a5e5a6f62ad);
      }
    } else {
      iprintln("<dev string:xed>");

      set_death_hint_standard();
    }

    return;
  }

  if(isDefined(cause)) {
    if(cause == "MOD_GRENADE" || cause == "MOD_GRENADE_SPLASH" || cause == "MOD_SUICIDE" || cause == "MOD_EXPLOSIVE") {
      if(level.gameskill >= 2) {
        if(!scripts\common\gameskill::map_is_early_in_the_game()) {
          set_death_hint_standard();
          return;
        }
      }
    }

    switch (cause) {
      case #"hash_f20a45acf43bdb30":
        if(weaponname == "none" || weaponname == "iw9_drown_mp" || weaponname == "jltv_mg_mp") {
          set_death_hint_standard();
          return;
        }

        setomnvar("ui_death_hint", 2);
        break;
      case #"hash_a911a1880d996edb":
        if(level.players[0] exploding_barrel_death(inflictor, weaponname)) {
          return;
        }

        if(level.players[0] destructible_death(attacker)) {
          return;
        }

        if(level.players[0] vehicle_death(inflictor)) {
          return;
        }

        set_death_hint_standard();
        break;
      case #"hash_66cb246f3e55fbe2":
      case #"hash_c22b13f81bed11f0":
        if(!function_6e7ab751d65f6321() && isDefined(weaponname) && !isweapondetonationtimed(weaponname)) {
          set_death_hint_standard();
          return;
        }

        setomnvar("ui_death_hint", 1);
        break;
      default:
        set_death_hint_standard();
        break;
    }

    return;
  }

  if(isDefined(attacker) && isDefined(attacker.subclass) && attacker.subclass == "juggernaut") {
    setomnvar("ui_death_hint", randomintrange(73, 75));
    return;
  }

  set_death_hint_standard();
}

function function_6e7ab751d65f6321() {
  if(!isDefined(level.players[0].overkillweapon)) {
    return 0;
  }

  return isweapondetonationtimed(level.players[0].overkillweapon);
}

function function_e3fc2e2cf55641cd(var_17fc9f1bd5b7597e) {
  setDvar(@ "hash_c8da47de891dca31", getdvarint(@ "hash_c8da46de891dc7fe"));
  setDvar(@ "hash_c8da46de891dc7fe", getdvarint(@ "hash_c8da45de891dc5cb"));
  setDvar(@ "hash_c8da45de891dc5cb", var_17fc9f1bd5b7597e);
}

function function_46f8b8c2648b7356(var_17fc9f1bd5b7597e) {
  if(var_17fc9f1bd5b7597e == getdvarint(@ "hash_c8da45de891dc5cb")) {
    return true;
  }

  if(var_17fc9f1bd5b7597e == getdvarint(@ "hash_c8da46de891dc7fe")) {
    return true;
  }

  if(var_17fc9f1bd5b7597e == getdvarint(@ "hash_c8da47de891dca31")) {
    return true;
  }

  return false;
}

function lookupdeathquote(index) {
  quote = tablelookup("sp/deathQuoteTable.csv", 0, index, 1);

  if(tolower(quote[0]) != tolower("@")) {
    quote = "@" + quote;
  }

  return quote;
}

function set_death_icon(shader, iwidth, iheight, fdelay) {
  if(!isDefined(fdelay)) {
    fdelay = 1.5;
  }

  wait fdelay;
  overlay = newhudelem();
  overlay.x = 0;
  overlay.y = 40;
  overlay setshader(shader, iwidth, iheight);
  overlay.alignx = "center";
  overlay.aligny = "middle";
  overlay.horzalign = "center";
  overlay.vertalign = "middle";
  overlay.foreground = 1;
  overlay.alpha = 0;
  overlay fadeovertime(1);
  overlay.alpha = 1;
}

function damage_is_explosive(type) {
  if(issubstr(type, "SPLASH")) {
    return true;
  }

  if(issubstr(type, "GRENADE")) {
    return true;
  }

  return false;
}

function damage_is_fire(type) {
  if(type == "MOD_FIRE") {
    return true;
  }

  return false;
}

function empty_breathing_func(alias) {}

function player_death_animation_enabled() {
  return getdvarint(@ "hash_72b7a039560ba3d2");
}

function explosive_up_func() {
  wait 1;
  tossgun();
}

function fall_back_func() {
  tossgun();
}