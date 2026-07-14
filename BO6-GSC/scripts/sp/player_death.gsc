/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\player_death.gsc
***************************************/

#using scripts\common\gameskill;
#using scripts\common\utility;
#using scripts\common\weapon;
#using scripts\engine\math;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\sp\analytics;
#using scripts\sp\audio;
#using scripts\sp\gameskill;
#using scripts\sp\player;
#using scripts\sp\utility;
#namespace player_death;

function init_player_death() {
  precacheshader("\xaeF\xe6\x8fRS\xac\x1f\xd1\xf5\xe2Rc\x9a\x15\xf0\xf6*0F\x94\xab<");
  precacheshader("'\x88\xa1\x0fe\xfb\x9f\xc7l\xe6\xe9X@\f\xe1\xfd#\xcaUdTFb\"8L\xe9\x93\xd1b");
  precacheshader("\xe7]\x7f\xb5\x89\xfa\xf9\xc5\xb2n\xba\xf4\n\xcbEp;\xb1g\xdb\xf7\xa0G\v0\x1e\xc4\xf19");
  initdeathvfx();
  init_player_animated_death();
  function_f39e3834d71e3bf5();

  setdvarifuninitialized(@ "hash_17edfd031d47e913", "<dev string:x24>");
  setdvarifuninitialized(@ "hash_76e4f253d7621975", "<dev string:x24>");
  setdvarifuninitialized(@ "hash_a66a95ab85344847", 0);
  setdvarifuninitialized(@ "hash_a126f17e11fdab38", "<dev string:x24>");
  setdvarifuninitialized(@ "hash_7716aef47c7b4751", "<dev string:x28>");
  setdvarifuninitialized(@ "hash_fc4a5c8230aa7828", "<dev string:x31>");
  setdvarifuninitialized(@ "hash_8205d45106eab55d", 70);

  thread main();
}

function initdeathvfx() {
  level.g_effect["\x94s.?W\x13$\x9d\xfa\x16\x8c\xab\xc6\x16\xe3P\xa1"] = loadfxasset("\xc4n\xd2\x0e!\x0e\xfc?\xfe\xfe\xc1\xdf\xef\xdf\xa0}\xd6\x1aL\xf4\xaf\av\xe7\x918\x83Z\xe1\xac");
}

function init_player_animated_death() {
  level.player.death = spawnStruct();
  level.player.death.deaths = [];
  register_deaths();
  setDvar(@ "hash_72b7a039560ba3d2", 1);
}

function register_deaths() {
  gestures = undefined;

  if(isDefined(level.gamemodebundle.deathgestures)) {
    gestures = getscriptbundle(level.gamemodebundle.deathgestures);

    if(isDefined(gestures.gestures)) {
      foreach(item in gestures.gestures) {
        aliases = [];

        if(isDefined(item.sounds)) {
          foreach(snd in item.sounds) {
            aliases[aliases.size] = snd.alias;
          }
        }

        register_player_death(item.type ?? "\x91\xca\xcc\v\xab\xd8:", item.stance ?? "\x8b\x90\xb5\xc4W", item.gesture, aliases, item.dir ?? "\xb0$R\x8b\xc9\x17", item.dist ?? 0, item.pitch ?? 0, undefined, item.riotshield, item.akimbo);
      }
    }
  }

  level.player.death.timetotal = gestures.timetotal ?? 4.2;
  level.player.death.timedeathquote = gestures.timedeathquote ?? 1.4;
  level.player.death.var_46ccf9fe7a973af5 = gestures.var_46ccf9fe7a973af5 ?? 1;
  level.player.death.timeblackfadestart = gestures.timeblackfadestart ?? 1;
  level.player.death.timeblackfadeend = gestures.timeblackfadeend ?? 4;
  level.player.death.var_621176c200255662 = gestures.var_621176c200255662 ?? 4;
  level.player.death.var_2bcc7497011b67cf = gestures.var_2bcc7497011b67cf ?? 6;
  setDvar(@ "hash_c8da45de891dc5cb", -1);
  setDvar(@ "hash_c8da46de891dc7fe", -1);
  setDvar(@ "hash_c8da47de891dca31", -1);
}

function register_player_death(type, stance, gesture, soundalias, falldirection, falldist, abspitch, deathfunc, riotshield, akimbo) {
  if(stance != "\x8b\x90\xb5\xc4W" && stance != "1x\xc5\xb4\xabx" && stance != "GX\xa9]\x82") {
    assertmsg("<dev string:x3c>" + stance + "<dev string:x47>");
  }

  death = spawnStruct();
  death.gesture = gesture;
  death.soundalias = soundalias;
  death.type = type;
  death.stance = stance;
  death.falldir = falldirection;
  death.falldist = falldist;
  death.abspitch = abspitch;
  death.riotshield = riotshield;
  death.akimbo = akimbo;

  if(istrue(riotshield)) {
    level.player.death.hasriotshield = 1;
  }

  if(isDefined(deathfunc)) {
    death.function = deathfunc;
  }

  level.player.death.deaths = utility::array_add_safe(level.player.death.deaths, death);
  return death;
}

function main() {
  level.player function_7e16a34db75d9622();

  thread debug_draw_slope_angles();

  level.player thread player_throwgrenade_timer();
  level.player waittill("\x1e\xfd\xd1\xa2\a", attacker, cause, objweapon, movingplatform, inflictor, test1, test2, test3, test4);

  if(getdvarint(@ "hash_a66a95ab85344847") && isDefined(attacker.classname)) {
    iprintln(attacker.classname + "<dev string:x71>");
  }

  if(isDefined(attacker) && attacker.asmname == "\xce\xe4\x15\xda\x967&F\xc34\xff5N" && !istrue(level.player.suicide_bomber_death_quote_skip)) {
    if(!isDefined(level.custom_death_quote)) {
      set_custom_death_quote(%"hash_2e17eae01a88b848");
    }
  }

  gameskill::auto_adjust_playerdied();
  analytics::analytics_playerdeath(attacker, objweapon, undefined, cause, undefined);
  weaponname = undefined;

  if(isDefined(objweapon)) {
    weaponname = getcompleteweaponname(objweapon);
  }

  level.player setpriorityclienttriggeraudiozonepartial("\x1b\x84:m\xb0\x8137N9", "\x1b\x84:m\xb0\x8137N9", "\a&\x99\xdb\xed\xb3");
  level.player audio::function_c7cd0252a2ba2d42();
  level.player shellshock("\x04d\xff]x\xf00\xa1\v\xffu\x12m)T", 3);

  if(isDefined(level.gamemodebundle.var_39fe25015a2529fd) && soundexists(level.gamemodebundle.var_39fe25015a2529fd)) {
    level.player playSound(level.gamemodebundle.var_39fe25015a2529fd);

    if(isDefined(self.heartbeatalias)) {
      self stoplocalsound(self.heartbeatalias);
    }
  }

  level.player thread audio::stop_deaths_door_audio();
  level.player thread deathmusic();
  level.player allowmelee(0);
  level.player hidelegsandshadow();
  function_b55560e96a7e436f();
  setomnvar("\xa4'\x84\xaf]u\xf9E\xa0\xe9\xf7Zt", -1);
  setomnvar("d\a~\x1b\xe8#\xa3Q\x87\xf3D\xf7\xde/<\xa2", "\xa3{s\x88\x9c*\x01\xcf\x97\x10");
  setomnvar("\xfb\nX{\x88\b\x89\x9cV~m\xefg\xe8g\xfc-\xfc\xef", 1);
  setomnvar("p(\xfe\xf3\xd0p\xebN\x95\x89\x0fG\x95N", 1);
  setomnvar("0\xc0\xc4\x8d\xb6\x169\x02\xd4\x92\xda\x8a \x95?\x99\x8e\t\xb3", 0);
  setsaveddvar(@ "hash_4e8225c28298a6ad", 0);
  setsaveddvar(@ "hash_9d7a2fa032e463d5", 1);
  setsaveddvar(@ "cg_drawcrosshair", 0);

  if(isDefined(level.player.var_60ecc0ce2add4820)) {
    level.player[[level.player.var_60ecc0ce2add4820]]();
    function_67578ea128d1f469();
    return;
  }

  stance = get_stance();
  running = playerwasrunning();
  deathscene = get_animated_player_death(stance, running, cause, movingplatform, attacker);
  level.player thread setdeathangles(attacker, stance, deathscene, movingplatform, deathscene.pitch);
  anim_time = 0;
  start_time = gettime();

  if(isDefined(deathscene)) {
    anim_time = gesture_death_anim(deathscene);
  } else {
    thread non_gesture_death_anim();
  }

  level.player thread deathfx(cause, objweapon);
  deathquotewait = level.player.death.timedeathquote;

  if(isDefined(level.var_e55942a1f1e9d091)) {
    deathquotewait = level.var_e55942a1f1e9d091;
  }

  wait deathquotewait;
  thread set_death_hint(attacker, cause, weaponname, inflictor, objweapon);

  if(getomnvar("\xa4'\x84\xaf]u\xf9E\xa0\xe9\xf7Zt") == -1) {
    wait level.player.death.timetotal - deathquotewait;
  } else {
    wait level.player.death.var_46ccf9fe7a973af5;
    wait_remaining_time_or_player_input(level.player.death.timetotal - level.player.death.var_46ccf9fe7a973af5);
  }

  function_67578ea128d1f469();
}

function function_67578ea128d1f469() {
  setomnvar("p(\xfe\xf3\xd0p\xebN\x95\x89\x0fG\x95N", 0);
  setDvar(@ "hash_72b7a039560ba3d2", 1);
  analytics::playerdeath();
  setsaveddvar(@ "g_deathdelay", 0);
  finishplayerdeath(utility_sp::in_yolo_mode());
}

function get_stance() {
  if(level.player issprintsliding()) {
    return "1x\xc5\xb4\xabx";
  }

  if(level.player isdiving()) {
    return "GX\xa9]\x82";
  }

  return level.player getstance();
}

function wait_remaining_time_or_player_input(waittime) {
  level.player endon(":\x8dYuZ$\xf8\x8b^<(");
  level.player endon("3\xf4\xbfq\xca\x04~L|\x8el\xbc3\x81ts\xd4\xec\xac\xf2\xc3");
  level.player endon("{FD\xcb\x90\x17\xfe^]\xfe\xdf\x1b");
  level.player endon("&\xa1\xd6%\xf2\xce\x81t\x84\xcb\x04\xe3j\x8d");
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
  level.player takeallweapons();
}

function playerwasrunning() {
  stance = level.player getstance();
  sliding = level.player issprintsliding();

  if(level.player getnormalizedmovement()[0] > 0.7 && isDefined(stance) && stance == "\x8b\x90\xb5\xc4W" && !sliding) {
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

  overridecause = getDvar(@ "hash_17edfd031d47e913");

  if(isDefined(overridecause) && overridecause != "<dev string:x24>") {
    cause = overridecause;
  }

  if(!level.player isonground()) {
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

  var_6389ac266862412b = getDvar(@ "hash_a126f17e11fdab38", "<dev string:x24>");

  if(var_6389ac266862412b != "<dev string:x24>") {
    var_8a5127c10d8d482e = getDvar(@ "hash_7716aef47c7b4751", "<dev string:x24>");
    var_64f078a60c5eb90b = getDvar(@ "hash_fc4a5c8230aa7828", "<dev string:x24>");
    var_ce10a82f2c0ff2fa = getdvarint(@ "hash_8205d45106eab55d", 0);
    death = spawnStruct();
    death.gesture = var_6389ac266862412b;
    death.soundalias = undefined;
    death.type = "<dev string:x83>";
    death.stance = var_8a5127c10d8d482e;
    death.falldir = var_64f078a60c5eb90b;
    death.falldist = var_ce10a82f2c0ff2fa;
    return death;
  }

  if(deathisanimexempt(cause)) {
    return undefined;
  }

  type = getdeathtypefromcause(cause);
  deaths = getdeaths(type, stance, level.player getcurrentweapon());
  death = try_deaths(deaths, cause, attacker);

  if(getdvarint(@ "hash_a66a95ab85344847", 0) == 1) {
    if(deaths.size == 0) {
      println("<dev string:x8e>");
    } else if(!isDefined(death)) {
      println("<dev string:xc0>");
    }
  }

  return death;
}

function getdeaths(type, stance, weapon) {
  onground = level.player isonground();
  deaths = [];
  requireriotshield = undefined;

  if(isDefined(weapon) && istrue(level.player.death.hasriotshield)) {
    requireriotshield = weapon.type == "k\xad\xb8<9\xcey\xdc\x14\xac";
  }

  foreach(death in level.player.death.deaths) {
    riotshieldvalid = !isDefined(requireriotshield) || requireriotshield == (death.riotshield ?? 0);
    dirvalid = death.falldir == "\xb0$R\x8b\xc9\x17" || onground;

    if(death.type == type && death.stance == stance && dirvalid && riotshieldvalid) {
      deaths[deaths.size] = death;
    }
  }

  return deaths;
}

function getdeathtypefromcause(cause) {
  if(isDefined(cause) && damage_is_fire(cause)) {
    return "\xcciN\xca";
  }

  if(isDefined(cause) && damage_is_explosive(cause)) {
    return "\xa3\xe9jL|";
  }

  return "\x91\xca\xcc\v\xab\xd8:";
}

function deathisanimexempt(cause) {
  if(!isDefined(cause)) {
    return true;
  }

  if(cause == "2a\\\xe1g5\xbf\xbf\xe0\xc6\x8c" || cause == "\xba\xe8\xabU\xbd\xe8\x85(\x12\x9f|\x03`\x1e\x19Y") {
    return true;
  }

  if(isnullweapon(level.player getcurrentweapon())) {
    return true;
  }

  return false;
}

function try_deaths(deaths, cause, attacker) {
  deaths = utility::array_randomize(deaths);
  currweapon = level.player getcurrentweapon();
  akimbo = weapon::isakimbo(currweapon);

  foreach(death in deaths) {
    if(death validatefalldirection(cause, attacker, akimbo)) {
      return death;
    }
  }

  return undefined;
}

function tossgun(model) {
  if(!isDefined(model)) {
    model = getweaponmodel(level.player getcurrentprimaryweapon());
  }

  gun_model = spawn("7l\x9ci\xc1\xa3}\xda\xf6\x19\xca6", level.player.origin + (0, -7, 20));
  gun_model setModel(model);

  if(!gun_model physics_getnumbodies()) {
    gun_model delete();
    return;
  }

  gun_model.angles = level.player.angles + (randomintrange(-20, 20), randomintrange(-20, 20), randomintrange(-20, 20));
  launchforce = anglesToForward(level.player.angles);
  launchforce *= randomfloatrange(600, 750);
  forcex = launchforce[0];
  forcey = launchforce[1];
  forcez = randomfloatrange(400, 600);
  gun_model physicslaunchserver(gun_model.origin, (forcex, forcey, forcez));
}

function validatefalldirection(cause, attacker, akimbo) {
  starttrace = level.player.origin + (0, 0, 2);
  endtrace = undefined;

  if(istrue(self.akimbo) != istrue(akimbo)) {
    if(getdvarint(@ "hash_a66a95ab85344847", 0) == 1) {
      println("<dev string:xfb>");
    }

    return 0;
  }

  if(cause == "\x9az\x88\xfat)*\xe4\x14\x11\x15" || cause == "9\xe6R?Wcx5\xf2F%Q3W\x06z\xfe\a") {
    var_675290f1688b4cce = angleclamp(vectortoyaw(level.player.dmgpoint - level.player.origin) - level.player.angles[1]);
  } else {
    var_675290f1688b4cce = angleclamp(vectortoyaw(attacker.origin - level.player.origin) - level.player.angles[1]);
  }

  if(cause == "\b\x89z\xc1\xf1\xd4I\xf3" || self.falldir == "\xb0$R\x8b\xc9\x17") {
    endtrace = starttrace;
  } else if(var_675290f1688b4cce > 135 && var_675290f1688b4cce <= 225 && self.falldir == "\xa17\xd3\x9fT\x14P") {
    endtrace = starttrace + anglesToForward(level.player.angles) * self.falldist;
  } else if(var_675290f1688b4cce > 45 && var_675290f1688b4cce <= 135 && self.falldir == "o0\xee\xc1\x8c") {
    endtrace = starttrace + anglestoright(level.player.angles) * self.falldist;
  } else if((var_675290f1688b4cce <= 45 || var_675290f1688b4cce >= 315) && self.falldir == "\x8a+\xf04") {
    endtrace = starttrace + anglesToForward(level.player.angles) * -1 * self.falldist;
  } else if(var_675290f1688b4cce > 225 && var_675290f1688b4cce < 315 && self.falldir == "=\xff0b") {
    endtrace = starttrace + anglestoleft(level.player.angles) * self.falldist;
  } else {
    if(getdvarint(@ "hash_a66a95ab85344847", 0) == 1) {
      println("<dev string:x110>" + self.falldir + "<dev string:x116>");
    }

    return 0;
  }

  if(capsule_check(starttrace, endtrace)) {
    debug_player_death(self.falldir, endtrace, "i\xb1Nh\xe5+");
    return 1;
  }

  debug_player_death(self.falldir, endtrace, "\x1c?\xa2\xb9\\\x05");
  return 0;
}

function capsule_check(start, end) {
  if(trace::capsule_trace_passed(start, end, 15, 72, (0, 0, 0), level.player)) {
    return true;
  }

  return false;
}

function debug_player_death(falldir, endtrace, outcome) {
  color = (1, 0, 0);

  if(getdvarint(@ "hash_a66a95ab85344847", 0) == 1) {
    if(outcome == "<dev string:x12c>") {
      println("<dev string:x136>" + falldir + "<dev string:x13c>");
      color = (0, 1, 0);
      utility::draw_capsule(level.player.origin, 15, 72, color, (0, 0, 0), 0, 200);
      utility::draw_arrow_time(level.player.origin, endtrace, (0, 1, 0), 200);
    } else {
      println("<dev string:x110>" + falldir + "<dev string:x150>");
    }

    if(falldir != "<dev string:x163>") {
      utility::draw_capsule(endtrace, 15, 72, color, (0, 0, 0), 0, 200);
    }
  }

}

function gesture_death_anim(death) {
  anim_time = 0;
  profilestart();
  takeweaponsexceptcurrent();
  level.player.ignoreme = 1;
  anim_time = level.player getgestureanimlength(death.gesture);

  if(getdvarint(@ "hash_a66a95ab85344847", 0) == 1) {
    iprintln("<dev string:x16d>" + death.gesture + "<dev string:x18a>" + death.falldir + "<dev string:x194>" + death.type);
  }

  if(isDefined(death.function)) {
    level thread[[death.function]]();
  }

  if(isarray(death.soundalias)) {
    foreach(alias in death.soundalias) {
      level.player thread utility::play_sound_in_space(alias, level.player.origin);
    }
  } else if(isDefined(death.soundalias)) {
    level.player playSound(death.soundalias);
  }

  bool = level.player forceplaygestureviewmodel(death.gesture, undefined, 0.15, undefined, 1, 1);
  profilestop();
  return anim_time;
}

function setdeathangles(attacker, stance, gesturedeath, movingplatform, maxabspitch) {
  freeze_player_controls(stance);
  abovemovingplatform = 0;

  if(isDefined(movingplatform)) {
    var_be44991f2bdaf064 = trace::create_playerclip_contents();
    trace = trace::ray_trace(self.origin, self.origin - (0, 0, 1000), self, var_be44991f2bdaf064);
    hitent = undefined;

    if(isDefined(trace)) {
      hitent = trace["\x1f\xa8\x10WP\xa9"];
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

  playerangles = level.player getplayerangles();

  if(attacker == self) {
    var_9a1e30b1ccc8226c = playerangles;
  } else {
    var_9a1e30b1ccc8226c = get_angles_to_attacker(attacker, maxabspitch);
  }

  if(isDefined(gesturedeath)) {
    rotatetoattackertime = 0.75;
    var_db30074a3cdc2f8c = 0;
    extraroll = 0;
  } else {
    playerf = anglesToForward(playerangles);
    attackerf = anglesToForward(var_9a1e30b1ccc8226c);
    dot = vectordot(attackerf, playerf);
    dotfactor = math::normalize_value(-1, 1, dot);
    rotatetoattackertime = math::factor_value(0.4, 0.2, dotfactor);
    var_b051a105ffc87b9c = geteyeheightfromstance(stance);
    var_db30074a3cdc2f8c = 13 - var_b051a105ffc87b9c;
    extraroll = randomfloatrange(20, 40);

    if(utility::cointoss()) {
      extraroll *= -1;
    }
  }

  anchor = level.players[0] utility::spawn_tag_origin();
  anchor.angles = playerangles;
  goalangles = (var_9a1e30b1ccc8226c[0], var_9a1e30b1ccc8226c[1], var_9a1e30b1ccc8226c[2] + extraroll);
  downwardoffset = anglestoup(goalangles) * var_db30074a3cdc2f8c;
  goalpos = self.origin + downwardoffset;
  thread function_a77a45a718a075ee(anchor, rotatetoattackertime * 0.5);

  if(getdvarint(@ "hash_a66a95ab85344847")) {
    linelength = 30;
    var_8ba6cde6f2a5f369 = self.origin + anglesToForward(goalangles) * linelength;
    var_2972d268fe3b7e15 = self.origin + anglestoright(goalangles) * linelength;
    var_2a831992b8b1c980 = self.origin + anglestoup(goalangles) * linelength;
    line(self.origin, var_8ba6cde6f2a5f369, (1, 0, 0), 1, 0, 1000);
    line(self.origin, var_2972d268fe3b7e15, (0, 1, 0), 1, 0, 1000);
    line(self.origin, var_2a831992b8b1c980, (0, 0, 1), 1, 0, 1000);
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

function function_a77a45a718a075ee(anchor, time) {
  self playerlinkTo(anchor, "\xec\xbfK|\au\xcd\xc2\x19<", 1, 0, 0, 0, 0);
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
  height = level.player getplayerviewheight(stance);
  return height;
}

function get_ground_slope_angles(direction) {
  direction = vectorNormalize(direction);
  up = (0, 0, 60);
  out = 15 * direction;
  resulta = trace::ray_trace(self.origin + out + up, self.origin + out - up, [self]);
  resultb = trace::ray_trace(self.origin - out + up, self.origin - out - up, [self]);

  if(resulta[")\x9a\x94]\xee}s"] == "\x90\x17\x030\x83m\x0f}D\x02f\xd9") {
    pointa = self.origin;
  } else {
    pointa = resulta["\xc1\xbd\xdci\xe8i{7"];
  }

  if(resultb[")\x9a\x94]\xee}s"] == "\x90\x17\x030\x83m\x0f}D\x02f\xd9") {
    pointb = self.origin;
  } else {
    pointb = resultb["\xc1\xbd\xdci\xe8i{7"];
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

function get_angles_to_attacker(attacker, maxabspitch = 0) {
  if(!isDefined(attacker)) {
    return self.angles;
  }

  ang = vectortoangles(attacker.origin - self.origin);

  if(maxabspitch > 0) {
    ang = (clamp(ang[0], -1 * maxabspitch, maxabspitch), angleclamp180(ang[1]), angleclamp180(ang[2]));
  } else {
    ang = (0, angleclamp180(ang[1]), angleclamp180(ang[2]));
  }

  return ang;
}

function debug_draw_slope_angles() {
  while(true) {
    if(getdvarint(@ "hash_fa41fbd3ef1e4209")) {
      pitch = level.player get_ground_slope_angles(anglesToForward(level.player.angles));
      roll = level.player get_ground_slope_angles(anglestoright(level.player.angles));
      eyepos = level.player getEye();
      line(eyepos, eyepos + rotatevector((cos(pitch), 0, -1 * sin(pitch)) * 50, level.player.angles), (0, 1, 0), 1, 0, 1);
      line(eyepos, eyepos + rotatevector((0, cos(roll), sin(roll)) * 50, level.player.angles), (0, 0, 1), 1, 0, 1);
    }

    wait 0.05;
  }
}

function freeze_player_controls(stance) {
  level.gameskill_breath_func = &utility::empty_init_func;
  level.player freezecontrols(1);

  if(stance == "GX\xa9]\x82") {
    level.player allowprone(1);
    level.player allowstand(0);
    level.player allowcrouch(0);
  } else if(stance == "1x\xc5\xb4\xabx") {
    level.player allowcrouch(1);
    level.player allowstand(0);
    level.player allowprone(0);
  } else {
    level.player allowstand(1);
    level.player allowprone(0);
    level.player allowcrouch(0);
  }

  level.player disableweaponswitch();
  level.player disableoffhandsecondaryweapons();
  level.player allowoffhandshieldweapons(0);
  level.player disableoffhandweapons();
  level.player allowjump(0);
  level.player allowfire(0);
  level.player freezecontrols(0);
}

function deathfx(cause, objweapon) {
  blackfadetime = level.player.death.timeblackfadeend - level.player.death.timeblackfadestart;
  blurfadetime = level.player.death.var_2bcc7497011b67cf - level.player.death.var_621176c200255662;
  level.player.death.huds = [];

  if(isDefined(level.player.death.skip_screen_fx)) {
    return;
  }

  if(utility::iswegameplatform()) {
    return;
  }

  player_sp::remove_damage_effects_instantly(1);
  [[level.sharedfuncs[#"fullscreenfx"][#"setpain"]]]({
    #transitiontime: 0.2, #postfxbundlename: undefined, #visionsetname: "\x9e=^/\x01\xaa\x1e\x8d\xa7\xc2\x1e"});
  audio::set_slowmo_dialogue_start();
  setslowmotion(1, 0.8, 4.5);
  setsaveddvar(@ "hash_b61c9c6a24b5671e", 100);
  self painvisionon();

  if(cause == "\b\x89z\xc1\xf1\xd4I\xf3") {
    thread deathfxfire();
  } else if(function_d528417027d33402(cause, objweapon)) {
    thread function_7ad41e481e43bea8(objweapon);
  } else if(isstring(level.player.death.var_d26ec91c3612adbd)) {
    thread function_7ad41e481e43bea8(level.player.death.var_d26ec91c3612adbd);
  } else {
    thread deathfxoverlay("\x98uZ\xd9\x0e\xc0\xed6T{\xfa\xcc\t", "\xaeF\xe6\x8fRS\xac\x1f\xd1\xf5\xe2Rc\x9a\x15\xf0\xf6*0F\x94\xab<", 0, 0, 18);
  }

  thread deathfxoverlay("_z\x114\x8cco\xba\x7fi\xcd\xa9", "'\x88\xa1\x0fe\xfb\x9f\xc7l\xe6\xe9X@\f\xe1\xfd#\xcaUdTFb\"8L\xe9\x93\xd1b", 1, 3, 19);
  thread deathfxoverlay("L\xbc\x81\xefs\xd9\xe2'\xed\"\r", "\xe7]\x7f\xb5\x89\xfa\xf9\xc5\xb2n\xba\xf4\n\xcbEp;\xb1g\xdb\xf7\xa0G\v0\x1e\xc4\xf19", level.player.death.timeblackfadestart, blackfadetime, 20);
  wait level.player.death.var_621176c200255662;
  setblur(6, blurfadetime);
}

function deathmusic() {
  clearmusicstate();
  self clearsoundsubmix("r\xd1a\xed\xf7\x83s##2\xdf\ao'Gck\xd2e");
  self setsoundsubmix("o\xc3UG_#\xaf\x82r>\x96o\xa4D\xdbH", 2);
  wait 1;

  if(soundexists("5]8_n8\xb1\xbe2\xac\x16\xe8\x86\xaf\xdc\x1d\xa5\xdc\xb3\x95'}l'")) {
    self playSound("5]8_n8\xb1\xbe2\xac\x16\xe8\x86\xaf\xdc\x1d\xa5\xdc\xb3\x95'}l'");
  }
}

function deathfxoverlay(name, shader, delay, fadetime, sort) {
  wait delay;
  level.player.death.huds[name] = create_death_hudelem();
  level.player.death.huds[name] setshader(shader, 640, 480);

  if(fadetime > 0) {
    level.player.death.huds[name] fadeovertime(fadetime);
  }

  level.player.death.huds[name].alpha = 1;
  level.player.death.huds[name].sort = sort;
}

function deathfxfire() {
  playFX(level.g_effect["\x94s.?W\x13$\x9d\xfa\x16\x8c\xab\xc6\x16\xe3P\xa1"], level.player.origin, anglesToForward(level.player.angles), anglestoup(level.player.angles));
}

function function_7ad41e481e43bea8(grenade) {
  grenadename = isstring(grenade) ? grenade : grenade.basename;
  level.player playRumbleOnEntity("\x8c\xc2[a\xec+_\xa1\xacX\xec\xe5");

  if(isstring(grenadename)) {
    magicgrenademanual(grenadename, level.player getEye(), (0, 0, 0), 0.01);
  }
}

function player_can_see_an_enemy() {
  enemies = getaiarray("?\xb1\xc0\x9a");

  foreach(enemy in enemies) {
    if(!utility::within_fov(level.player.origin, level.player.angles, enemy.origin, 0.173648)) {
      continue;
    }

    if(utility::can_trace_to_ai(level.player getEye(), enemy, [level.player])) {
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
  overlay.alignx = "=\xff0b";
  overlay.aligny = "\x1d Q";
  overlay.sort = 1;
  overlay.foreground = 0;
  overlay.lowresbackground = 1;
  overlay.horzalign = "?\xcbkk\xe0\x0f\xae\x12\xd2\xce";
  overlay.vertalign = "?\xcbkk\xe0\x0f\xae\x12\xd2\xce";
  overlay.alpha = 0;
  overlay.enablehudlighting = 1;
  return overlay;
}

function takeweaponsexceptcurrent() {
  keepers = [];
  current_gun = level.player getcurrentweapon();
  keepers[keepers.size] = current_gun;

  if(current_gun.isalternate) {
    keepers[keepers.size] = current_gun getnoaltweapon();
  } else if(current_gun.hasalternate) {
    keepers[keepers.size] = current_gun getaltweapon();
  }

  foreach(weapon in level.player getweaponslistall()) {
    if(!arraycontains(keepers, weapon)) {
      level.player takeweapon(weapon);
    }
  }
}

function player_throwgrenade_timer() {
  self endon("\x1e\xfd\xd1\xa2\a");
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

function c4_death(weaponname, attacker) {
  c4_death = 0;

  if(isDefined(weaponname) && issubstr(weaponname, "\x8dh")) {
    c4_death = 1;
  } else if(isDefined(attacker) && isPlayer(attacker)) {
    if(isDefined(attacker.overkillweapon)) {
      if(isDefined(attacker.overkillweapon.basename) && issubstr(attacker.overkillweapon.basename, "\x8dh")) {
        c4_death = 1;
      }
    }
  }

  if(istrue(c4_death)) {
    level notify("G`\xcf\xfbf\x1e&Yv\xd1o6\r,\x87\xe1");
    index = function_c5efec7ebf2d47c5(%"hash_40fb94d5b461ddca");
    setomnvar("\xa4'\x84\xaf]u\xf9E\xa0\xe9\xf7Zt", index);
    return true;
  }

  return false;
}

function vehicle_death(inflictor) {
  if(!isDefined(inflictor)) {
    return false;
  }

  if(inflictor.code_classname != "\xb4\xeb\xfa\xa0\xd0Nv\xf3\xa7x\x86\x99S\x8e") {
    if(inflictor.code_classname != "X\xf2Z\x1b\xc3\x03\xb9\xee\xd1\x95") {
      return false;
    }

    if(!isDefined(inflictor.destructible_type) || inflictor.destructible_type != "\xb3VC-\xc6c\xb2") {
      return false;
    }
  }

  level notify("W(~\x022\xea\xe7yR\xa2\x1d\xcd\xd4\xfai5\xf4");
  index = function_c5efec7ebf2d47c5(%"hash_52c6694fd05b62a8");
  setomnvar("\xa4'\x84\xaf]u\xf9E\xa0\xe9\xf7Zt", index);
  return true;
}

function destructible_death(attacker) {
  if(!(isDefined(attacker) && isDefined(attacker.destructible_type))) {
    return false;
  }

  level notify("G`\xcf\xfbf\x1e&Yv\xd1o6\r,\x87\xe1");

  if(isDefined(attacker.destructible_type) && issubstr(attacker.destructible_type, "\xb3VC-\xc6c\xb2")) {
    index = function_c5efec7ebf2d47c5(%"hash_52c6694fd05b62a8");
    setomnvar("\xa4'\x84\xaf]u\xf9E\xa0\xe9\xf7Zt", index);
  } else {
    index = function_c5efec7ebf2d47c5(%"hash_587b428369a22228");
    setomnvar("\xa4'\x84\xaf]u\xf9E\xa0\xe9\xf7Zt", index);
  }

  return true;
}

function exploding_barrel_death(inflictor, weaponname) {
  if(!isDefined(inflictor)) {
    return false;
  }

  if(inflictor is_red_barrel()) {
    level notify("G`\xcf\xfbf\x1e&Yv\xd1o6\r,\x87\xe1");
    index = function_c5efec7ebf2d47c5(%"hash_24c5abe4d82afd16");
    setomnvar("\xa4'\x84\xaf]u\xf9E\xa0\xe9\xf7Zt", index);
    return true;
  }

  return false;
}

function is_red_barrel() {
  if(isDefined(self.targetname) && self.targetname == "ER\rv_Y\x03*\xeb \ru\xe77\x12\xf7|c\xdf\xaa\x9d\x849\x03") {
    return true;
  }

  if(isDefined(self.model) && issubstr(self.model, "\x80\x83\vzF\x9f") && issubstr(self.model, "\x9b\x9b\v")) {
    return true;
  }

  if(self.code_classname == "X\xf2Z\x1b\xc3\x03\xb9\xee\xd1\x95" && isDefined(self.classname) && issubstr(self.classname, "\x80\x83\vzF\x9f")) {
    return true;
  }

  return false;
}

function set_custom_death_quote(var_c0ea2e96bf3f4e52, var_6fb585c00676a3bf) {
  var_cc1575b084e9cd21 = function_c5efec7ebf2d47c5(var_c0ea2e96bf3f4e52);
  level.custom_death_quote = var_cc1575b084e9cd21;
  level.var_cea07ddc11b5c728 = var_6fb585c00676a3bf;
}

function function_c5efec7ebf2d47c5(var_a96188df8be1eb3f) {
  if(isDefined(level.var_f2adcd6d25078d35)) {
    return level.var_f2adcd6d25078d35[var_a96188df8be1eb3f];
  }

  return -1;
}

function function_f39e3834d71e3bf5() {
  if(!isDefined(level.var_296d42717456c588) && isDefined(level.gamemodebundle.var_f2adcd6d25078d35)) {
    var_93f46792e1a34a75 = getscriptbundle(level.gamemodebundle.var_f2adcd6d25078d35);
    var_f2adcd6d25078d35 = var_93f46792e1a34a75.list;
    var_da5777570aa5d9bf = 0;

    for(i = 0; i < var_f2adcd6d25078d35.size; i++) {
      hintname = var_f2adcd6d25078d35[i].bundle;
      level.var_f2adcd6d25078d35[hintname] = i;
      hintbundle = getscriptbundle(hintname);

      if(istrue(hintbundle.isstandard)) {
        level.var_f024581985e7ec2e[var_da5777570aa5d9bf] = i;
        var_da5777570aa5d9bf++;
      }
    }
  }
}

function clear_custom_death_quote() {
  level.custom_death_quote = undefined;
}

function set_death_hint_standard() {
  if(!isDefined(level.var_f024581985e7ec2e)) {
    return;
  }

  if(level.var_f024581985e7ec2e.size > 3) {
    while(true) {
      deadquoteindex = utility::array_random(level.var_f024581985e7ec2e);

      if(!function_49ab8b504a0dc65b(deadquoteindex)) {
        break;
      }

      waitframe();
    }
  } else {
    deadquoteindex = utility::array_random(level.var_f024581985e7ec2e);
  }

  function_33765b31df8f9764(deadquoteindex);
  setomnvar("\xa4'\x84\xaf]u\xf9E\xa0\xe9\xf7Zt", deadquoteindex);
}

function set_death_hint(attacker, cause, weaponname, inflictor, objweapon) {
  var_9705ad49ae3b5eac = undefined;
  var_2a8228a7112af1ad = istrue(level.var_cea07ddc11b5c728);

  if(isDefined(level.custom_death_quote) && (!var_2a8228a7112af1ad || !function_49ab8b504a0dc65b(level.custom_death_quote))) {
    var_9705ad49ae3b5eac = level.custom_death_quote;
  }

  if(getdvarint(@ "hash_76e4f253d7621975") > 0) {
    var_9705ad49ae3b5eac = getdvarint(@ "hash_76e4f253d7621975");
  }

  if(isDefined(var_9705ad49ae3b5eac)) {
    if(var_9705ad49ae3b5eac > 0) {
      setomnvar("\xa4'\x84\xaf]u\xf9E\xa0\xe9\xf7Zt", var_9705ad49ae3b5eac);

      if(var_2a8228a7112af1ad) {
        function_33765b31df8f9764(var_9705ad49ae3b5eac);
      }
    } else {
      iprintln("<dev string:x19e>");

      set_death_hint_standard();
    }

    return;
  }

  if(isDefined(cause)) {
    if(cause == "\x9az\x88\xfat)*\xe4\x14\x11\x15" || cause == "9\xe6R?Wcx5\xf2F%Q3W\x06z\xfe\a" || cause == "2a\\\xe1g5\xbf\xbf\xe0\xc6\x8c" || cause == "\xa2rl\xdaDn\x17b\xd9I\xc9=N" || cause == "~<I\xc8\xe9\xd0Z\xf0\xbdRk") {
      if(level.gameskill >= 2) {
        if(!gameskill::map_is_early_in_the_game()) {
          set_death_hint_standard();
          return;
        }
      }
    }

    switch (cause) {
      case #"hash_f20a45acf43bdb30":
        if(!function_d528417027d33402("2a\\\xe1g5\xbf\xbf\xe0\xc6\x8c", objweapon)) {
          return;
        }

        index = function_c5efec7ebf2d47c5(%"hash_7cc5a3b29207def1");
        setomnvar("\xa4'\x84\xaf]u\xf9E\xa0\xe9\xf7Zt", index);
        break;
      case #"hash_a911a1880d996edb":
        if(level.player exploding_barrel_death(inflictor, weaponname)) {
          return;
        }

        if(level.player destructible_death(attacker)) {
          return;
        }

        if(level.player vehicle_death(inflictor)) {
          return;
        }

        if(level.player c4_death(weaponname, attacker)) {
          return;
        }

        set_death_hint_standard();
        break;
      case #"hash_66cb246f3e55fbe2":
      case #"hash_c22b13f81bed11f0":
        if(!function_8fba45cf2b042e20() && isDefined(weaponname) && !isweapondetonationtimed(weaponname)) {
          set_death_hint_standard();
          return;
        }

        if(isDefined(attacker) && isDefined(attacker.unittype) && attacker.unittype == "\x9b\x11\"\xd6\xfb;") {
          set_death_hint_standard();
          return;
        }

        index = function_c5efec7ebf2d47c5(%"hash_278cfd7f449eb027");
        setomnvar("\xa4'\x84\xaf]u\xf9E\xa0\xe9\xf7Zt", index);
        break;
      case #"hash_b15027ffbdc0ecb":
        index = function_c5efec7ebf2d47c5(%"hash_18b2d60a376b55c0");
        setomnvar("\xa4'\x84\xaf]u\xf9E\xa0\xe9\xf7Zt", index);
        break;
      default:
        set_death_hint_standard();
        break;
    }

    return;
  }

  if(isDefined(attacker) && isDefined(attacker.subclass) && attacker.subclass == "\xab\xbf\xbe\xe2\xcdvJ\x14/c") {
    deathquotearray = [%"hash_44b054b5c29771af", %"hash_44b055b5c2977362", %"hash_44b056b5c2977515"];
    quote = utility::array_randomize(deathquotearray)[0];
    index = function_c5efec7ebf2d47c5(quote);
    setomnvar("\xa4'\x84\xaf]u\xf9E\xa0\xe9\xf7Zt", index);
    return;
  }

  set_death_hint_standard();
}

function function_d528417027d33402(death_case, objweapon) {
  if(death_case != "2a\\\xe1g5\xbf\xbf\xe0\xc6\x8c") {
    return false;
  }

  if(!isDefined(objweapon) || objweapon.type != ",\xe1\x93So\x98\r") {
    return false;
  }

  if(level.player.lastgrenadetime - gettime() > 3500) {
    return false;
  }

  return true;
}

function function_8fba45cf2b042e20() {
  if(!isDefined(level.player.overkillweapon)) {
    return 0;
  }

  return isweapondetonationtimed(level.player.overkillweapon);
}

function function_33765b31df8f9764(var_7d4c9ec976a7638b) {
  setDvar(@ "hash_c8da47de891dca31", getdvarint(@ "hash_c8da46de891dc7fe"));
  setDvar(@ "hash_c8da46de891dc7fe", getdvarint(@ "hash_c8da45de891dc5cb"));
  setDvar(@ "hash_c8da45de891dc5cb", var_7d4c9ec976a7638b);
}

function function_49ab8b504a0dc65b(var_7d4c9ec976a7638b) {
  if(var_7d4c9ec976a7638b == getdvarint(@ "hash_c8da45de891dc5cb")) {
    return true;
  }

  if(var_7d4c9ec976a7638b == getdvarint(@ "hash_c8da46de891dc7fe")) {
    return true;
  }

  if(var_7d4c9ec976a7638b == getdvarint(@ "hash_c8da47de891dca31")) {
    return true;
  }

  return false;
}

function lookupdeathquote(index) {
  quote = tablelookup("\xfe\xe4_(\xd4\xd2\xa8Q#\xaa\xce\x96*\xa9\xc6\xdc\xc0\xce]&\xd8\xfc", 0, index, 1);

  if(tolower(quote[0]) != tolower("\x17")) {
    quote = "\x17" + quote;
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
  overlay.alignx = "O\xd5!\xe8\xd4\x9d";
  overlay.aligny = "#\xb8\xfd\xf5\x1a@";
  overlay.horzalign = "O\xd5!\xe8\xd4\x9d";
  overlay.vertalign = "#\xb8\xfd\xf5\x1a@";
  overlay.foreground = 1;
  overlay.alpha = 0;
  overlay fadeovertime(1);
  overlay.alpha = 1;
}

function damage_is_explosive(type) {
  if(issubstr(type, "\xdf>0\xb3\xa1\xb9")) {
    return true;
  }

  if(issubstr(type, "(\xf1\x9bWm\x88-")) {
    return true;
  }

  return false;
}

function damage_is_fire(type) {
  if(type == "\b\x89z\xc1\xf1\xd4I\xf3") {
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