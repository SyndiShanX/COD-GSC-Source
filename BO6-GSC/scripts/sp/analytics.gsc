/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\analytics.gsc
**************************************/

#using scripts\engine\sp\utility;
#using scripts\engine\utility;
#using scripts\sp\equipment\offhands;
#using scripts\sp\utility;
#namespace analytics;

function main() {
  setdvarifuninitialized(@ "hash_e10567ef7a26589d", 0);
  level.analytics = spawnStruct();
  level.analytics.missionstarttime = level.player getplayerprogression("\x9b\xfd\x96\xa2\xe9\xd4C\xee\x93\xb7\x80\x02\xe1\xd6\xbe\xcf\xf1");
  level.analytics.startingdifficulty = getdifficultylevel();
  level.analytics.sp_counter = 0;
  level.analytics.sp_skip = 0;
  setDvar(@ "hash_237093776d23c007", 0);
  thread analyticsthread();
}

function analyticsthread() {
  level.player setplayerprogression("E\xbcdc5,2M&\x13\xac\xc8F\xb8-f8\xc0MG\xab\xa3\xcd\xb3\xe4F", 0);
  level.player setplayerprogression("I\xab\xda\x83\xbf\x05\xad\x16~!F=\xc5{t\xe1\x89\x13", 0);
  level.player setplayerprogression("j\xf0\xce\x86\x8b\x98AT\x1e\xa9tn", 0);
  level.player thread analytics_tracking_player_mount();
  level.player thread function_642f76b2c2346417();
  level.player thread function_2fdafe2cb734dd8f();
  level.player thread function_1a56d544736d730f();
  utility::registersharedfunc(#"analytics", #"playerspotted", &analytics_playerspotted);

  while(true) {
    if(!isalive(level.player)) {
      wait 10;
      continue;
    }

    if(issaverecentlyloaded() || getdvarint(@ "hash_237093776d23c007")) {
      function_e7dcaed5f0dd0b2b();

      if(issaverecentlyloaded()) {
        wait 2;
      }
    }

    wait 0.5;
  }
}

function function_e7dcaed5f0dd0b2b() {
  setDvar(@ "hash_237093776d23c007", 0);
  setDvar(@ "hash_83208d256c505088", gettime());
  setDvar(@ "hash_327cf97ac22238cf", gettime());
}

function analytics_tracking_player_mount() {
  while(true) {
    while(self playermount() < 0.5) {
      wait 0.1;
    }

    self notify("\xdcG\xb0\x93\xa3_\xc1\xb1\xb0\x97\xb2\xe4\xd7\xd6\xf6]\xdc\xe8");
    mounts = level.player getplayerprogression("I\xab\xda\x83\xbf\x05\xad\x16~!F=\xc5{t\xe1\x89\x13");
    level.player setplayerprogression("I\xab\xda\x83\xbf\x05\xad\x16~!F=\xc5{t\xe1\x89\x13", mounts + 1);

    while(self playermount() >= 0.5) {
      wait 0.1;
    }

    wait 0.1;
  }
}

function analytics_upload_during_nextmission() {
  if(isDefined(level.script) && isDefined(level.player)) {
    function_895762e4c0b1ba38("\x05\xcb\x97\x03O\xa3-4\xc5\x19M", level.player getplayerprogression("I\xab\xda\x83\xbf\x05\xad\x16~!F=\xc5{t\xe1\x89\x13"), level.script);
  }
}

function analytics_lui_mission_end_dlog() {
  setomnvar("\xba\x96\xbe\xad\xb47\xcd\x96o7_\x957d}\xc8\xd8og", 1);
}

function analytics_skip_start_point() {
  level.analytics.sp_skip = 1;
}

function analytics_fake_start_point(name, bool) {
  if(istrue(bool)) {
    level.analytics.sp_counter++;
    name += level.analytics.sp_counter;
  }

  start_point_update(name);
  start_point_reset();
}

function analytics_kleenex_update(name) {
  analytics_kleenex_upload(name);
}

function analytics_kleenex_upload(name) {
  current = int((gettime() - getdvarint(@ "hash_327cf97ac22238cf")) / 1000);
  duration = float(current + level.player getplayerprogression("E\xbcdc5,2M&\x13\xac\xc8F\xb8-f8\xc0MG\xab\xa3\xcd\xb3\xe4F"));
  level.player dlog_recordplayerevent("^\xc9\xfaO\xaf\xf5\xd6\x01O\x93Q*\xac\xbf\xf8jk]\x12\xf1$'\x1b\x92\xaf\xb1\xe9oZ.\xc5V\x10\xec\x14\xa38[\xe8", ["\x9c\x84\xf1Y/\x06whb", level.script, "\xf67\xc8\x7f\xf4L\x1f", name, "Zk7\x97O\x91\xb6\xc6", duration]);
  setDvar(@ "hash_327cf97ac22238cf", gettime());
  level.player setplayerprogression("E\xbcdc5,2M&\x13\xac\xc8F\xb8-f8\xc0MG\xab\xa3\xcd\xb3\xe4F", 0);
  println("<dev string:x24>" + name + "<dev string:x2d>" + duration);
}

function start_point_setup() {
  if(level.analytics.sp_skip) {
    level.analytics.sp_skip = 0;
    return;
  }

  start_point_reset();
}

function start_point_check(startname) {
  if(!level.analytics.sp_skip) {
    start_point_update(startname);
  }
}

function start_point_reset() {
  setDvar(@ "hash_83208d256c505088", gettime());
  level.player setplayerprogression("\xe3\x8ds\xe30'\x96S\x12i\xf5(\xd8}\b{", 0);
  level.player setplayerprogression("9+[l=rKp\xae\xf6zu\xf5\x1cB", 0);
  level.player setplayerprogression("`\xf1u@R\xfb\xdc\xf5\xc0\x0e\xabl\xd1\x95\x8aCLR9", 0);
  level.player setplayerprogression("j\xf0\xce\x86\x8b\x98AT\x1e\xa9tn", 0);
}

function start_point_update(name, bypass) {
  if(istrue(level.nextmission) && !isDefined(bypass)) {
    return;
  }

  current = int((gettime() - getdvarint(@ "hash_83208d256c505088")) / 1000);
  duration = float(current + level.player getplayerprogression("`\xf1u@R\xfb\xdc\xf5\xc0\x0e\xabl\xd1\x95\x8aCLR9"));
  deaths = level.player getplayerprogression("\xe3\x8ds\xe30'\x96S\x12i\xf5(\xd8}\b{");
  fails = level.player getplayerprogression("9+[l=rKp\xae\xf6zu\xf5\x1cB");
  diff = get_gameskill_as_string();
  level.analytics.sp_counter++;
  level.player dlog_recordplayerevent("\xfb~\xeaiiZ\xcbM\x1b<\xdd(u\x7f\x96!uE\x9ee8e\x1d\xb2\xeb$o<\x03\x84\xa9\xec4\xc2\xcd\x80", ["\x9c\x84\xf1Y/\x06whb", level.script, "\x1f\xad\v\xde8", name, "Zk7\x97O\x91\xb6\xc6", duration, "\x1bC\xf9\fo\x1b", deaths, "\x02\xf3\xb1\x87P", fails, "\x17\xe8y\bl\xe4?\x04\xd8\xb1", diff]);
  println("<dev string:x33>" + level.script + "<dev string:x2d>" + name + "<dev string:x55>" + duration + "<dev string:x5c>" + deaths + "<dev string:x67>" + fails + "<dev string:x74>" + diff);
  focus = level.player getplayerprogression("j\xf0\xce\x86\x8b\x98AT\x1e\xa9tn");
  analytics_event_upload("O\xe4\x96\x9a\x8f\xfdAK\xad\x9d3\xdf\xc0x\x18r\x9a}q8u~\xd3", focus);
}

function get_gameskill_as_string() {
  diff = level.player utility_sp::get_player_gameskill();

  if(diff == 0) {
    return "Iw\xc9\t\xbe$\t";
  }

  if(diff == 1) {
    return "\\\xf4\xe1\x82\xb7\x7f\x8f";
  }

  if(diff == 2) {
    return "\x1dO\x86 \xb6\x1aV\x10";
  }

  if(diff == 3) {
    return "\xb7\x0f\xe8\xd2\x8d\xe3/";
  }

  if(diff == 4) {
    return "\x0e\x91\x8c\x10\x0e\x9d\x86";
  }
}

function analytics_obj_failed(failreason = "\x12F\x9e\xe1\xc4\x1f\xe7") {
  updatetotalgameplaytime();
  failed = 1 + level.player getplayerprogression("9+[l=rKp\xae\xf6zu\xf5\x1cB");
  level.player setplayerprogression("9+[l=rKp\xae\xf6zu\xf5\x1cB", failed);
  function_895762e4c0b1ba38("\x95\b\x9b\xf5\xc6\xe9\xe2\x11\xbf\xae\xee\xc5>", failreason, failed);
}

function function_a7b33e28c76eecd4(dtname, dtchoice) {
  function_895762e4c0b1ba38("\xe8\xee\"X\xc8\xad\xe8\f\xb4\xe0\x94\xf1P`\xb4\xec", dtname, dtchoice);
}

function update_focus_counter() {
  focus = level.player getplayerprogression("j\xf0\xce\x86\x8b\x98AT\x1e\xa9tn");
  focus++;
  level.player setplayerprogression("j\xf0\xce\x86\x8b\x98AT\x1e\xa9tn", focus);
  function_895762e4c0b1ba38("3\xb7\xc6\xab7\xfa\x0e\xe4\xca\x9b7e#", focus);
}

function playerdeath() {
  updatetotalgameplaytime();
  deaths = level.player getplayerprogression("\xe3\x8ds\xe30'\x96S\x12i\xf5(\xd8}\b{");
  level.player setplayerprogression("\xe3\x8ds\xe30'\x96S\x12i\xf5(\xd8}\b{", deaths + 1);
  setDvar(@ "hash_237093776d23c007", 1);
}

function updatetotalgameplaytime() {
  totalgameplaytime = level.player getplayerprogression("\x9b\xfd\x96\xa2\xe9\xd4C\xee\x93\xb7\x80\x02\xe1\xd6\xbe\xcf\xf1");
  var_bb4a97efda87909b = level.player getplayerprogression("`\xf1u@R\xfb\xdc\xf5\xc0\x0e\xabl\xd1\x95\x8aCLR9");
  var_983c80060a2bd243 = int((gettime() - getdvarint(@ "hash_83208d256c505088")) / 1000);
  time = var_bb4a97efda87909b + var_983c80060a2bd243;
  level.player setplayerprogression("`\xf1u@R\xfb\xdc\xf5\xc0\x0e\xabl\xd1\x95\x8aCLR9", time);
  var_768e10f5bcb47e1d = level.player getplayerprogression("E\xbcdc5,2M&\x13\xac\xc8F\xb8-f8\xc0MG\xab\xa3\xcd\xb3\xe4F");
  var_3779e86a8154f62a = int((gettime() - getdvarint(@ "hash_327cf97ac22238cf")) / 1000);
  time2 = var_768e10f5bcb47e1d + var_3779e86a8154f62a;
  level.player setplayerprogression("E\xbcdc5,2M&\x13\xac\xc8F\xb8-f8\xc0MG\xab\xa3\xcd\xb3\xe4F", time2);

  if(var_983c80060a2bd243 > 0) {
    totalgameplaytime += var_983c80060a2bd243;
    level.player setplayerprogression("\x9b\xfd\x96\xa2\xe9\xd4C\xee\x93\xb7\x80\x02\xe1\xd6\xbe\xcf\xf1", totalgameplaytime);
  }

  println("<dev string:x80>" + var_983c80060a2bd243 + "<dev string:x97>" + totalgameplaytime);
  return totalgameplaytime;
}

function getdifficultylevel() {
  difficulty = getdvarint(@ "g_gameskill") + 1;

  if(utility_sp::in_specialist_mode()) {
    difficulty = 5;
  } else if(utility_sp::in_yolo_mode()) {
    difficulty = 6;
  }

  return difficulty;
}

function analytics_event_upload(eventstring, num) {
  level.player dlog_recordplayerevent("\xe5| \x97WL\xebd\xdc\x1b\xe4o\x9e\x1cs\xb4e<\f\x83Q\xd7z\xcf\xb4mLi\x9e\byV\xf5\xfa\b\x9ex", ["\x9c\x84\xf1Y/\x06whb", level.script, "Q\xec\xac\xdcG", eventstring, "D*\x17-c\xf8\xc7", num], 1);
}

function get_spheader() {
  levelname = "\r+x5";
  startpoint = "\r+x5";
  origin = (0, 0, 0);
  angles = (0, 0, 0);
  name = getDvar(@ "g_mapname");

  if(isDefined(name)) {
    levelname = name;
  }

  if(isDefined(level.player)) {
    vec = level.player getorigin();

    if(isDefined(vec)) {
      origin = vec;
    }

    vec = level.player getplayerangles();

    if(isDefined(vec)) {
      angles = vec;
    }
  }

  if(isDefined(level.start_point)) {
    startpoint = level.start_point;
  }

  diff = get_gameskill_as_string();

  if(!isDefined(diff)) {
    diff = "B@\xb0\x1d\xbc\xf7\x1f";
  }

  array = ["7+\xd4E2\x1cL\xdd\xa7\x82", levelname, "\xa5L\x11\xf3\xce>\x1b\x96", gettime(), "\x89-iX\xea\xb2\xa7", origin[0], "dd1%M\xe5Z", origin[1], "\xd1\x9d\x99]\v\xc6-", origin[2], "\xb0\xf3\x16\x95H\x89\xbez", angles[1], "\x8e\xc0\xefa]\x9a\x86(`\x0e", angles[0], "\xff\xe6\xa1\fv\x11m\xc9\xcc\xeb", startpoint, "\x17\xe8y\bl\xe4?\x04\xd8\xb1", diff];
  return array;
}

function function_d1fefefc35d01f33() {
  version = getbuildversion();

  if(version == "gy\x8b\xd7") {
    return true;
  }

  return false;
}

function function_1a56d544736d730f() {
  if(function_d1fefefc35d01f33()) {
    return;
  }

  self endon("\x1e\xfd\xd1\xa2\a");

  for(freq = 0; true; freq++) {
    wait 5;
    function_d093e6b36786de32(freq);
  }
}

function analytics_playerdamage(attacker, objweapon, damage, damagemod, partname) {
  function_cf642abfd12da8b9("v:4\x81\x05\xb7Y\"\x96\xbf'#\xd6\x90\xebb*\xd1Go", attacker, objweapon, damage, damagemod, partname);
}

function analytics_playerdeath(attacker, objweapon, damage, damagemod, partname) {
  function_cf642abfd12da8b9("\xea\x1e@\x90\xde\xac\xfaG\x8d\x83\x9f\xc5}\xc12u\xb9%\xee", attacker, objweapon, damage, damagemod, partname);
}

function function_cf642abfd12da8b9(event, attacker, objweapon, damage, damagemod, partname) {
  if(function_d1fefefc35d01f33()) {
    return;
  }

  spheader = get_spheader();
  attid = "B@\xb0\x1d\xbc\xf7\x1f";
  atttype = "B@\xb0\x1d\xbc\xf7\x1f";
  attclassname = "B@\xb0\x1d\xbc\xf7\x1f";
  attweapon = "B@\xb0\x1d\xbc\xf7\x1f";
  attpos = (0, 0, 0);
  attyaw = 0;
  victimdied = 1;
  attcombat = "B@\xb0\x1d\xbc\xf7\x1f";
  attignoreme = 0;
  attignoreall = 0;
  attfovcos = 0;
  var_9d7ee559801923a = 0;
  attanimname = "B@\xb0\x1d\xbc\xf7\x1f";
  attlaststand = 0;

  if(isDefined(attacker)) {
    num = attacker getentitynumber();

    if(isDefined(num)) {
      attid = "\xe2\x92" + num;
    }

    if(isDefined(attacker.type)) {
      atttype = attacker.type;
    }

    if(isDefined(attacker.classname)) {
      attclassname = attacker.classname;
    }

    if(isDefined(objweapon)) {
      attweapon = getweaponbasename(objweapon);
    }

    if(isDefined(attacker.origin)) {
      attpos = attacker.origin;
    }

    if(isDefined(attacker.angles)) {
      attyaw = attacker.angles[1];
    }

    if(isalive(attacker)) {
      victimdied = 0;
    }

    if(isDefined(attacker.combatmode)) {
      attcombat = attacker.combatmode;
    }

    if(isDefined(attacker.ignoreme)) {
      attignoreme = attacker.ignoreme;
    }

    if(isDefined(attacker.ignoreall)) {
      attignoreall = attacker.ignoreall;
    }

    if(isDefined(attacker.animname)) {
      attanimname = attacker.animname;
    }

    if(isDefined(attacker.laststand)) {
      attlaststand = attacker.laststand;
    }

    if(isDefined(attacker.maxsightdistsqrd)) {
      var_9d7ee559801923a = attacker.maxsightdistsqrd;
    }
  }

  dmg = 0;
  dmgtype = "SOe$v\x97b";
  dmgloc = "SOe$v\x97b";

  if(isDefined(damage)) {
    dmg = damage;
  } else if(isDefined(level.player.dmgtoplayer)) {
    dmg = level.player.dmgtoplayer;
  }

  if(isDefined(damagemod)) {
    dmgtype = damagemod;
  }

  if(isDefined(partname)) {
    dmgloc = partname;
  }

  weapon = "\r+x5";
  weaponammo = 0;
  weaponmax = 0;
  currentweapon = level.player getcurrentweapon();

  if(isDefined(currentweapon)) {
    weapon = getweaponbasename(currentweapon);
    weaponammo = level.player getweaponammoclip(currentweapon);
    weaponmax = weaponclipsize(currentweapon);
  }

  backupweapon = "\r+x5";
  backupammo = 0;
  backupmax = 0;

  if(isDefined(level.player.primaryweapons)) {
    foreach(weap in level.player.primaryweapons) {
      if(weap != currentweapon) {
        backupweapon = getweaponbasename(weap);
        backupammo = level.player getweaponammoclip(weap);
        backupmax = weaponclipsize(weap);
      }
    }
  }

  lethal = "\r+x5";
  lethalammo = 0;
  lethalmax = 0;
  offhand = level.player getcurrentoffhand("\xa9\nC\xc9\v\xda\xbdS\xa8\xe9?t\x14\x1e");

  if(isDefined(offhand)) {
    lethal = getweaponbasename(offhand);

    if(isDefined(offhand.clipsize)) {
      lethalammo = offhand.clipsize;
    }

    if(isDefined(offhand.maxammo)) {
      lethalmax = offhand.maxammo;
    }
  }

  tact = "\r+x5";
  tactammo = 0;
  tactmax = 0;
  offhand = level.player getcurrentoffhand("\xfe\x06E\x80wqb\x96\xaa\xa0\x8b\xaaY\x92e\x9e");

  if(isDefined(offhand)) {
    tact = getweaponbasename(offhand);

    if(isDefined(offhand.clipsize)) {
      tactammo = offhand.clipsize;
    }

    if(isDefined(offhand.maxammo)) {
      tactmax = offhand.maxammo;
    }
  }

  level.player dlog_recordplayerevent(event, ["}\x8fA\x03\xa1R\xcb\xfe\xf2", spheader, "P\xdc^$?\x89\xefad\xe3", attid, "eY\x9d\xf2\xd9:\x9b\xca\xf2\x8c,\xfb", atttype, "q\bz,\x15\xbc\bzm(.\x94\x05\xff\x1c}\xb5", attclassname, "\xc2\xa3\x8e\v6\xb5+'wY\x85\x83\xbd7", attweapon, "a9\x94\x18\xe3\xbbs\x15\xc9", attpos[0], "#`\xf6\x0f\xe0f\xdf\x1f\xae", attpos[1], "Xl2\xae\x18:,_q", attpos[2], "C\x14\xf7c]mP\xba\xdbq;", attyaw, ",t\x8e\xc2\x1b\xd6+9\xb1{m\x98\xc2\x1d\xad{2Y", attcombat, "\xde\x9f\xe9\xcf}\xba+,2\xb8\x1dk\xa5u-\x99", attignoreme, "\xa8}\x16\x9brc\"\x1d\x19\xf3\xbc\xbf\x1f\x85\xe4\"\xd4", attignoreall, "n\xe1\xa0c\xb7B\ag\xa65\xd6\xae\x817", attfovcos, "4y@\x11e5\x7f=\xd4n9{\x180q\xe2\xe79@\x04g\x1f*T", var_9d7ee559801923a, "X:G\x16\x8dm\xb2\x9c,n\xa5\xb6\xb9\xb0[\xac", attanimname, "\xe8\x9f\x9e\x18h\xc9\x9c(V\xb6\xa1\x86\xcc&\x9a\xf4\xb4", attlaststand, "\fU`\xc0y\x95", dmg, "Z\xfem\xba\xea4H ]\xde", dmgtype, "/\xd0\x9a\x817\x9e\xac\aY\x0f\r\xc5\xc5\xd8", dmgloc, "\tJwy\x98D\xd5+\x85!", victimdied, "\xb3|\xdb- \xa7\xa9\x9c}\xbf\xbc", weapon, "9Tv\xd6p%/\xe0x\xee\xf4?\xb3\x05Q\xbeR\xa2\xaeY\x0e|", weaponammo, "X\xf5H-\x9a\xc2\xf2_\x1fZ\xce\\o\xb0\xf8@&\xf9\x90t", weaponmax, "1\xa9\xa9>s\xccFA\x0ec\x89\xb0\xf3\t", backupweapon, "]\xdb\xce\xac\x14\x10\xeb\x06\x19\x88i\xc3\xdb\x90\xd2~\xf1\xe1\x14\xaa~4L\xff9", backupammo, "\xf3U\x05\"-WKwl\x8b;\xa6x\xda~\xb5\r\xf2\xda\xcc\x9f\xfe:", backupmax, "\x04k\xb7\x8ewD/\xe9\x13@\xbe\xd0\x944", lethal, "\xe2,\xdd\x80\x9e*\x1b$\xb4rrA\a\x84O\x87\xbb\xc0\xfb\xbe\xe0\x06\xd6\x1a\x91", lethalammo, "1\x8b\xd2\xd0\xf2#\xbc;\xa6<*\x90\xed\xf1\xd4$\"\x94\xc1[\f\xe0\x91", lethalmax, "\xb7FB\x8b:\x80}\xd63\x16\x96\x0e\xdc\xc3\xda^", tact, "o\x05w\xce\x9d\xcb\xc3\xb8\f*\xf3\x95\x90G\x9b\xe8a\xb4\xfa\x04\xf9\x06\xa5\xf1\xc0R=", tactammo, "j\xed\xcd\xd9\xda\xcd\xeec2|\x1b}\x1f,?\xe2r\xf5\x1f\xd6\x1a\x9cD\xe6\xd0", tactmax]);
}

function analytics_playerspotted(player, bestai) {
  spheader = get_spheader();
  player dlog_recordplayerevent("hFC;g\xad\xe1\xc8\x01\xfc)?SAz\x0f\xe3\x91\xa3y8R\xc6\xed4\xb5\x95\xfd", ["}\x8fA\x03\xa1R\xcb\xfe\xf2", spheader, "\xf3\xd0\x81Z\xe7\xcaq\x910", bestai.origin[0], "q\x1c\x864\xe0\x97\v<\xbf", bestai.origin[1], "\x12\xb4]p\x110s\xc4L", bestai.origin[2]]);
}

function function_642f76b2c2346417() {
  if(function_d1fefefc35d01f33()) {
    return;
  }

  self endon("\x1e\xfd\xd1\xa2\a");

  while(true) {
    self waittill("KJ\xdf\x82,\x83\x8e\xab\xbb\xcc\r\xd9\x9c\xf3\xb6Bc\x97^\x19\x1c", groundweapon);
    currentweapon = self getcurrentweapon();

    if(isDefined(groundweapon) && isDefined(currentweapon)) {
      basename1 = getweaponbasename(currentweapon);
      basename2 = getweaponbasename(groundweapon);
      function_c8ec7096acd1c8e6("\x92J\xe8\xbf+\xcd@\x89\t\x9b\x9f'\x8e", basename1, basename2);
    }
  }
}

function function_2fdafe2cb734dd8f() {
  if(function_d1fefefc35d01f33()) {
    return;
  }

  self endon("\x1e\xfd\xd1\xa2\a");

  while(true) {
    self waittill("\x1d\x95S\xfd\xf0\xa8", newweapon, oldweapon);

    if(isDefined(oldweapon) && isDefined(newweapon)) {
      basename1 = getweaponbasename(oldweapon);
      basename2 = getweaponbasename(newweapon);

      if(basename1 != "\r+x5" && basename2 != "\r+x5") {
        function_c8ec7096acd1c8e6("\xc1!\x88V\t\"DW\xfa\xac|\x1d\\", basename1, basename2);
      }
    }
  }
}

function function_5ebdee87090ce61d(weapon) {
  if(function_d1fefefc35d01f33()) {
    return;
  }

  subevent = "\r+x5";
  weaponname = "\xdc\x9boB";

  if(isDefined(weapon)) {
    type = offhands::getweaponoffhandtype(weapon);

    if(isDefined(type)) {
      if(type == "\xa9\nC\xc9\v\xda\xbdS\xa8\xe9?t\x14\x1e") {
        subevent = "\xddeXp{\x9b\xfa\xc6et\xd0\x16c\xf5\xd1\x1a\xc9{\xees";
      } else if(type == "\xfe\x06E\x80wqb\x96\xaa\xa0\x8b\xaaY\x92e\x9e") {
        subevent = "XF`\xbb\x85XH\xb6m.s\x06\xa1{\xf9\xc6\xf7\x9b\x8d\xc4\x03\xaa";
      }
    }

    basename = getweaponbasename(weapon);

    if(isDefined(basename)) {
      weaponname = basename;
    }
  }

  function_c8ec7096acd1c8e6(subevent, weaponname);
}

function function_c8ec7096acd1c8e6(subevent, weaponname, param0) {
  if(function_d1fefefc35d01f33()) {
    return;
  }

  spheader = get_spheader();

  if(!isDefined(subevent)) {
    subevent = "\r+x5";
  }

  if(!isDefined(weaponname)) {
    weaponname = "\xdc\x9boB";
  }

  if(!isDefined(param0)) {
    param0 = "\xdc\x9boB";
  }

  level.player dlog_recordplayerevent("B\x88:\x8fm\xf4\x9e\xde\xe2g-+\xfa\xf8\f6\xf0\r", ["}\x8fA\x03\xa1R\xcb\xfe\xf2", spheader, "=\t\xea\xf9\x93\xc6v[", subevent, "\xe5\x06\xb0\bE\x16", weaponname, "\xda\xe3\xeeH\x84\xff", param0]);
}

function function_3728b4e402533bc4(player, lethalequip, tacticalequip, missionabilityequip, items, duration, activationmethod) {
  assert(isarray(items) && items.size == 8);
  spheader = get_spheader();
  player dlog_recordplayerevent("\xaf}\xd2<\xa7\fb2\xf7r\xe7\xd5LT\xf4\xfa\xdb8\xa68\r\x84b\xbd\xbehLO\x18\xd49-\xab5\x06,W]", ["}\x8fA\x03\xa1R\xcb\xfe\xf2", spheader, "\xfd\x93\x14\t\x9f\xdeI:\xb8\x88x\xb8K\x9f\xc9\xf8", lethalequip, "\xc0X\xaa\xaa\xbc\xa0\xef\xea\x87\x90\x8e\xa0\x06P\x19e\x1eQ", tacticalequip, "\x8aW\xa7\x01\tN\x1b\r7\xad2,\rY\x13\x11\x826\xa5\x99V\xe3\xfe\x1fs", missionabilityequip, "7\xe4_\x8f^\xe3/\x14\xd8\x97}\x86\b8\xc3\xff}\x98\xba\xb0$,", items[0], "\x86\xed\x13!t\xd8\x02\xcfj\x94\x90c-Q+e&.m\xdc\\\xc4", items[1], "\x84\x9c\x8e\xca\b\x1c\x7f\x0f\x96'\xe4\xbc\x1d\x018\xd8e \xe1\a\x8e\xb4", items[2], "P\x9b\xa7\xd0\xdc^\xc5He\x9f\xf8\f\x13\xbf#\xfc\"q\xde\rk\x8a", items[3], "\xdb\xb1\x1fji\xb0+\xfb\nq5\xc3icAO\xf1\xe4\x0fZWF", items[4], "QL\xf7\xb6\xf0\x93le\xed\xc5\xff\xb0\x82w8\xb9\x01(\x9f\xc0\f\xfa", items[5], "\xd2\xd1\x89\xec\x99~n(\xe3p\xf4]\xddu|\\\xb0-\xbf`\xbf\x96", items[6], "\xcbb\x0f\x1e\xc2Ku\x1d_\x97Z\n\xa8;F=\x86+\xcb\xcd\xe3\xd3", items[7], "\x0f\xaf\x1e3\xc6\x92,\x1b\x1c\x1e \x17\x03r\x1a,\xb8\t\xc1\x16", duration, "a\xc6\xa3\xb4\xd9X\xe8-\xb7\xb9\xafk\xca\xa3\x86\xf6\x91", activationmethod]);
}

function function_486ab2ff479a88e1(player, var_91c53f219282444d, numenemiestagged, wasphototaken, durationseconds, var_5dcbb67b744c0710) {
  spheader = get_spheader();
  player dlog_recordplayerevent("\\\by\xe6\xf8\xf9\xadfl\xac\xf1\x1e\xd5\xab\x87HA\xccK\xc4\xf7\xd8-a", ["}\x8fA\x03\xa1R\xcb\xfe\xf2", spheader, "'\x06\x7f\x9e\x02l1yw\xcdwf\xdd\xe7", var_91c53f219282444d, "\xe4\xfc\xbdUn\xde\xd70\x98\x8b\x80\xbf\x8a\xfc", numenemiestagged, "\x0fOJ\xa7\xe8\xee\x91z\xaa\xa9q", wasphototaken, ">/\xde\xc8G\xdd\xe9E\xbeqx\xc4\xf1\x9c6\x8c\x03\xecS\xbf<", durationseconds, "Y\x9a1\xdeV;\x94\xde\xc9&\x03\xda\x922\xf1\b\x85\xd6", var_5dcbb67b744c0710]);
}

function function_999e41d213a4c651(player, killstreakname) {
  spheader = get_spheader();
  player dlog_recordplayerevent("\x8f=\xe0\x88\xd1\x93l\xed\xbd@A\xb02q\x05\xe6\xcf\xbeq*H*\xc8\xb5\x9d\x1d\xb3p\f\xf0l\xa6\b\xf5\xd8", ["}\x8fA\x03\xa1R\xcb\xfe\xf2", spheader, "\xdai6\x8ds\xd1\xe4\xaca\xad\xf5\xcd\xc2\xdae", killstreakname]);
}

function function_396a8a3375c65d3d(victim, attacker, objweapon) {
  if(function_d1fefefc35d01f33()) {
    return;
  }

  spheader = get_spheader();
  vicid = "B@\xb0\x1d\xbc\xf7\x1f";
  victype = "B@\xb0\x1d\xbc\xf7\x1f";
  vicclassname = "B@\xb0\x1d\xbc\xf7\x1f";
  viccombat = "B@\xb0\x1d\xbc\xf7\x1f";
  vicignoreme = 0;
  vicignoreall = 0;
  vicfovcos = 0;
  var_18de64527c90184f = 0;
  vicanimname = "B@\xb0\x1d\xbc\xf7\x1f";
  viclaststand = 0;
  vicpos = (0, 0, 0);
  dmg = 0;
  dmgtype = "SOe$v\x97b";
  dmgloc = "SOe$v\x97b";

  if(isDefined(victim)) {
    num = victim getentitynumber();

    if(isDefined(num)) {
      vicid = "\xe2\x92" + num;
    }

    if(isDefined(victim.type)) {
      victype = victim.type;
    }

    vicpos = victim.origin;

    if(isDefined(victim.classname)) {
      vicclassname = victim.classname;
    }

    if(isDefined(victim.combatmode)) {
      viccombat = victim.combatmode;
    }

    if(isDefined(victim.ignoreme)) {
      vicignoreme = victim.ignoreme;
    }

    if(isDefined(victim.ignoreall)) {
      vicignoreall = victim.ignoreall;
    }

    if(isDefined(victim.fovcosine)) {
      vicfovcos = victim.fovcosine;
    }

    if(isDefined(victim.animname)) {
      vicanimname = victim.animname;
    }

    if(isDefined(victim.laststand)) {
      viclaststand = victim.laststand;
    }

    if(isDefined(victim.maxsightdistsqrd)) {
      var_18de64527c90184f = victim.maxsightdistsqrd;
    }

    if(isDefined(victim.damagetaken)) {
      dmg = victim.damagetaken;
    }

    if(isDefined(victim.damagemod)) {
      dmgtype = victim.damagemod;
    }

    if(isDefined(victim.damagelocation)) {
      dmgloc = victim.damagelocation;
    }
  }

  attid = "B@\xb0\x1d\xbc\xf7\x1f";
  atttype = "B@\xb0\x1d\xbc\xf7\x1f";
  attclassname = "B@\xb0\x1d\xbc\xf7\x1f";
  attweapon = "B@\xb0\x1d\xbc\xf7\x1f";
  attpos = (0, 0, 0);
  attyaw = 0;
  victimdied = 1;
  attcombat = "B@\xb0\x1d\xbc\xf7\x1f";
  attignoreme = 0;
  attignoreall = 0;
  attfovcos = 0;
  var_9d7ee559801923a = 0;
  attanimname = "B@\xb0\x1d\xbc\xf7\x1f";
  attlaststand = 0;

  if(isent(attacker)) {
    num = attacker getentitynumber();

    if(isDefined(num)) {
      attid = "\xe2\x92" + num;
    }

    if(isDefined(attacker.type)) {
      atttype = attacker.type;
    }

    if(isDefined(attacker.classname)) {
      attclassname = attacker.classname;
    }

    if(isDefined(objweapon)) {
      attweapon = getweaponbasename(objweapon);
    }

    if(isDefined(attacker.origin)) {
      attpos = attacker.origin;
    }

    if(isDefined(attacker.angles)) {
      attyaw = attacker.angles[1];
    }

    if(isalive(attacker)) {
      victimdied = 0;
    }

    if(isDefined(attacker.combatmode)) {
      attcombat = attacker.combatmode;
    }

    if(isDefined(attacker.ignoreme)) {
      attignoreme = attacker.ignoreme;
    }

    if(isDefined(attacker.ignoreall)) {
      attignoreall = attacker.ignoreall;
    }

    if(isDefined(attacker.fovcosine)) {
      attfovcos = attacker.fovcosine;
    }

    if(isDefined(attacker.animname)) {
      attanimname = attacker.animname;
    }

    if(isDefined(attacker.laststand)) {
      attlaststand = attacker.laststand;
    }

    if(isDefined(attacker.maxsightdistsqrd)) {
      var_9d7ee559801923a = attacker.maxsightdistsqrd;
    }
  }

  level.player dlog_recordplayerevent("V\xcfG\x90\xe8\x8aw\r\x9aX\xe2#\xba\x97\xd2\xbf\xbd0|^v", ["}\x8fA\x03\xa1R\xcb\xfe\xf2", spheader, "mA\xec%\x0eI\x19\x94", vicid, "\x1b\xe6[]\xc3?\xe5\xce\x93\xb0", victype, "u\x9f\xf3\xff\x1a\xb2\xc7\xa5\xf4\x87\x13b\xcf\x18_", vicclassname, "v\xb4c:\xb4m\xf0", vicpos[0], "\xf7\xeb\xcf\xf9s\xd0\x9b", vicpos[1], "\x99\x82\xca\xdb`\xc3\xf4", vicpos[2], "7\x16\xc9$\xca~@\x1a\xc2\x1d\x85\x86>\x0e\x9f\xcc", viccombat, "\x1b\xe6[]\xc3?\xa2/c\xa4\xb2\xa4\x902", vicignoreme, "t\xb1\x8b\xdb_\x9e\xc8QXm\xb8\x97\n@'", vicignoreall, "\x1dA=h\xd0\xb4\xe8H\x98\xafw\xb1", vicfovcos, "h\xcb\x9f\xb9/Q\x97\x80\xc3,\x0e\xf9\xa0\xeep\x99\xc5n\xdd\xf1\x14\xdf", var_18de64527c90184f, "\xee\x8dU\xef\xf7\xd9#\x80\x8a\x94G|\x82^", vicanimname, "\r\x98\xdfv!\xcd\x1a\xbe!7\xa4Z\x1c\xd0\xca", viclaststand, "P\xdc^$?\x89\xefad\xe3", attid, "eY\x9d\xf2\xd9:\x9b\xca\xf2\x8c,\xfb", atttype, "q\bz,\x15\xbc\bzm(.\x94\x05\xff\x1c}\xb5", attclassname, "\xc2\xa3\x8e\v6\xb5+'wY\x85\x83\xbd7", attweapon, "a9\x94\x18\xe3\xbbs\x15\xc9", attpos[0], "#`\xf6\x0f\xe0f\xdf\x1f\xae", attpos[1], "Xl2\xae\x18:,_q", attpos[2], "C\x14\xf7c]mP\xba\xdbq;", attyaw, ",t\x8e\xc2\x1b\xd6+9\xb1{m\x98\xc2\x1d\xad{2Y", attcombat, "\xde\x9f\xe9\xcf}\xba+,2\xb8\x1dk\xa5u-\x99", attignoreme, "\xa8}\x16\x9brc\"\x1d\x19\xf3\xbc\xbf\x1f\x85\xe4\"\xd4", attignoreall, "n\xe1\xa0c\xb7B\ag\xa65\xd6\xae\x817", attfovcos, "4y@\x11e5\x7f=\xd4n9{\x180q\xe2\xe79@\x04g\x1f*T", var_9d7ee559801923a, "X:G\x16\x8dm\xb2\x9c,n\xa5\xb6\xb9\xb0[\xac", attanimname, "\xe8\x9f\x9e\x18h\xc9\x9c(V\xb6\xa1\x86\xcc&\x9a\xf4\xb4", attlaststand, "\fU`\xc0y\x95", dmg, "Z\xfem\xba\xea4H ]\xde", dmgtype, "/\xd0\x9a\x817\x9e\xac\aY\x0f\r\xc5\xc5\xd8", dmgloc, "\tJwy\x98D\xd5+\x85!", victimdied]);
}

function analytics_aispawn(ai) {
  if(function_d1fefefc35d01f33()) {
    return;
  }

  spheader = get_spheader();
  actorid = "B@\xb0\x1d\xbc\xf7\x1f";
  aitype = "B@\xb0\x1d\xbc\xf7\x1f";
  aiclassname = "B@\xb0\x1d\xbc\xf7\x1f";
  aiacc = 0;
  aiweapon = "\r+x5";
  aiteam = "\r+x5";
  aialert = "B@\xb0\x1d\xbc\xf7\x1f";
  var_432960f1c8020b77 = 0;
  var_8d80d7d772d6911f = 0;
  var_9570283ceb4927c9 = 0;
  var_18990c4b6983ac95 = 0;
  var_8d237e6628de60b = 0;
  aihealth = 0;

  if(isDefined(ai)) {
    num = ai getentitynumber();

    if(isDefined(num)) {
      actorid = "\xe2\x92" + num;
    }

    if(isDefined(ai.type)) {
      aitype = ai.type;
    }

    if(isDefined(ai.classname)) {
      aiclassname = ai.classname;
    }

    if(isDefined(ai.team)) {
      aiteam = ai.team;
    }

    if(isDefined(ai.alertlevel)) {
      aialert = ai.alertlevel;
    }

    if(isDefined(ai.grenadeawareness)) {
      var_432960f1c8020b77 = ai.grenadeawareness;
    }

    if(isDefined(ai.engagemaxdist)) {
      var_8d80d7d772d6911f = ai.engagemaxdist;
    }

    if(isDefined(ai.engagemaxfalloffdist)) {
      var_9570283ceb4927c9 = ai.engagemaxfalloffdist;
    }

    if(isDefined(ai.engagemindist)) {
      var_18990c4b6983ac95 = ai.engagemindist;
    }

    if(isDefined(ai.engageminfalloffdist)) {
      var_8d237e6628de60b = ai.engageminfalloffdist;
    }

    if(isDefined(ai.health)) {
      aihealth = ai.health;
    }
  }

  level.player dlog_recordplayerevent("#\xb1\xb7g\xafV\xec+\xdct\xeb\xe6\x0e\xeba\xd27\x0e\x16w7", ["\xf9\x8e\xfdY%\x9f\x18", actorid, "a\x96\x1d\x97\xc1+", aitype, "\"\v\xb2aQU6h`", aiclassname, "v!\xffzTWM{", aiacc, "\xe5\x06\xb0\bE\x16", aiweapon, "\x03\x94=b", aiteam, "\\*\xe3\xec\x10\xab\x1a\xbc\xc0\xa0", aialert, "\xd9\xe4V\xcd\xb0\xc8ea\xddXr\xb2nen\xb9", var_432960f1c8020b77, "\x8c\x96\x9e\xdbU\x7f\xfb\xeb*\x98\xf8\xe6\xc1", var_8d80d7d772d6911f, "?\x94I\"\xc7\xa0z#HL\xd8\xeb\n\xea\xb4#\vI\x98z", var_9570283ceb4927c9, "\x06\xd7\x89a\xcd\xfe\xa0\x16\xc1}\xc5\x88\xb2", var_18990c4b6983ac95, "\xf6+\xf4/\xf4\xca\xa7\xc5\xc4\xdes\x80\x8c\x90\xf3%k\xb0\x9an", var_8d237e6628de60b, "\f8\xcb.\xc8\xe5", aihealth]);
}

function function_d093e6b36786de32(freq) {
  if(function_d1fefefc35d01f33()) {
    return;
  }

  spheader = get_spheader();
  ads = 0;
  seqnum = 0;
  motionstate = "B@\xb0\x1d\xbc\xf7\x1f";
  stance = "B@\xb0\x1d\xbc\xf7\x1f";
  speed = 0;
  health = 0;

  if(isDefined(level.player)) {
    if(level.player utility_sp::isads()) {
      ads = 1;
    }

    if(isDefined(freq)) {
      seqnum = freq;
    }

    state = function_30422944ffc9c09d();

    if(isDefined(state)) {
      motionstate = state;
    }

    st = level.player getstance();

    if(isDefined(st)) {
      stance = st;
    }

    sp = length(level.player getvelocity());

    if(isDefined(sp)) {
      speed = sp;
    }

    if(isDefined(level.player.health)) {
      health = level.player.health;
    }
  }

  level.player dlog_recordplayerevent("J\x15\x9a.N\xe3\xce\x06\xb6\a\v\x11\xa8\xd7\xe0\xbf*\x1b\xfb\xaf\xc9e\xf6\xea\xc3", ["}\x8fA\x03\xa1R\xcb\xfe\xf2", spheader, "\x14v\xd7+\x81\xe5", ads, "\x1e\xc5\x02\xf9j\xde\xbb\xfa\xff7\x86\xd4", seqnum, "x'\xd9.z\xd4QcS\xd8\x199", motionstate, "\xed\xf3n&\x85\xff", stance, "\xa2\xac\xd9\xd7H", speed, "\f8\xcb.\xc8\xe5", health]);
}

function function_30422944ffc9c09d() {
  if(self isonladder()) {
    return "\x9ct\n\x94\t\x10";
  }

  if(self issprintsliding()) {
    return "\x06\x9f\xb3\xa4\x8dQ\x11\xc5G/3";
  }

  if(self issupersprinting()) {
    return "\xe7\x1aM\x85+z\x1b\x89\x0fU9";
  }

  if(self issprinting()) {
    return "\x05\xb1\x1c\x86\x11\xc7";
  }

  if(self isjumping()) {
    return "j\xbak\xc1\xb4ng";
  }

  if(self isparachuting()) {
    return "\xf6\xc5\x148\x9d\x04\xaf\xcb\x966\xd6";
  }

  if(self isinfreefall()) {
    return "\xa3(\x05[\x99Y\"3";
  }

  if(self islinked()) {
    return "DBO\xa9\xc1n";
  }

  if(self playermounttype() != "\x13\xab\xa7\xab~\xc9\xbc\x80\x02\xe7") {
    return self playermounttype();
  }

  if(self isufo()) {
    return "\ttP";
  }

  if(self isnoclip()) {
    return "b\xf2\xb1\xbc\xeb{";
  }

  return "<\x1cu\xbe@x";
}

function function_ada8a71b8c2bbd77(subevent) {
  if(function_d1fefefc35d01f33()) {
    return;
  }

  spheader = get_spheader();

  if(!isDefined(subevent)) {
    subevent = "B@\xb0\x1d\xbc\xf7\x1f";
  }

  kills = 0;
  killmelee = 0;
  killexplosive = 0;
  deaths = 0;
  headshots = 0;
  shotshit = 0;
  shotsmissed = 0;
  weapon = "\r+x5";
  weaponammo = 0;
  weaponmax = 0;
  currentweapon = level.player getcurrentweapon();

  if(isDefined(currentweapon)) {
    weapon = getweaponbasename(currentweapon);
    weaponammo = level.player getweaponammoclip(currentweapon);
    weaponmax = weaponclipsize(currentweapon);
  }

  lethal = "\r+x5";
  lethalammo = 0;
  lethalmax = 0;
  offhand = level.player getcurrentoffhand("\xa9\nC\xc9\v\xda\xbdS\xa8\xe9?t\x14\x1e");

  if(isDefined(offhand)) {
    lethal = getweaponbasename(offhand);

    if(isDefined(offhand.clipsize)) {
      lethalammo = offhand.clipsize;
    }

    if(isDefined(offhand.maxammo)) {
      lethalmax = offhand.maxammo;
    }
  }

  tact = "\r+x5";
  tactammo = 0;
  tactmax = 0;
  offhand = level.player getcurrentoffhand("\xfe\x06E\x80wqb\x96\xaa\xa0\x8b\xaaY\x92e\x9e");

  if(isDefined(offhand)) {
    tact = getweaponbasename(offhand);

    if(isDefined(offhand.clipsize)) {
      tactammo = offhand.clipsize;
    }

    if(isDefined(offhand.maxammo)) {
      tactmax = offhand.maxammo;
    }
  }

  weapons = [];

  for(i = 0; i <= 4; i++) {
    weapons[i] = get_weapon_info(i);
  }

  shotstats = [];

  for(i = 0; i <= 2; i++) {
    shotstats[i] = function_6054222d108902ba(i);
  }

  level.player dlog_recordplayerevent("'\xbc\xc8\x17TEN4\"^X\xd1\xf5\xd0D\a-LE\xf5RC\x8e\x16\x18", ["=\t\xea\xf9\x93\xc6v[", subevent, "E\xb9\xf4j\x0f", kills, "\xfb\xbekj@\x19\x1a\x94\xb8\x06", killmelee, "\x14!b\xdc\xa1\x83\x12E\x91\xdcCI\x9e\xa5", killexplosive, "\x1aC\xf9\fo\x1b", deaths, "\x86\xb2\x16\x8c\xcdC\xde\x1ds", headshots, "\xc5\x81\x04\xc4\x18\x1b\xef\xcf", shotshit, "\xbb?f\x04\x7f\xb4\"\xa6\xe6\xef\xf0", subevent, "/\x04\xf3\xfa2\x7fA#A\xc10\xe0\xfa\xa2", weapon, "\xef\x1a]\x0e\xee=\x19[\x0fU>\x0f\xc2\xe0z<e\xb1\x8aP\v\xcb\xca\xa2x", weaponammo, "}v6|T/\xe8\x86t\xd3+CN\xbf\xe1\x9d\xbe\x06RM\f\xeaq", weaponmax, "\xb3|\xdb- \xa7\xa9\x9c}\xbf\xbc", weapon, "9Tv\xd6p%/\xe0x\xee\xf4?\xb3\x05Q\xbeR\xa2\xaeY\x0e|", weaponammo, "X\xf5H-\x9a\xc2\xf2_\x1fZ\xce\\o\xb0\xf8@&\xf9\x90t", weaponmax, "\x04k\xb7\x8ewD/\xe9\x13@\xbe\xd0\x944", lethal, "\xe2,\xdd\x80\x9e*\x1b$\xb4rrA\a\x84O\x87\xbb\xc0\xfb\xbe\xe0\x06\xd6\x1a\x91", lethalammo, "1\x8b\xd2\xd0\xf2#\xbc;\xa6<*\x90\xed\xf1\xd4$\"\x94\xc1[\f\xe0\x91", lethalmax, "\xb7FB\x8b:\x80}\xd63\x16\x96\x0e\xdc\xc3\xda^", tact, "o\x05w\xce\x9d\xcb\xc3\xb8\f*\xf3\x95\x90G\x9b\xe8a\xb4\xfa\x04\xf9\x06\xa5\xf1\xc0R=", tactammo, "j\xed\xcd\xd9\xda\xcd\xeec2|\x1b}\x1f,?\xe2r\xf5\x1f\xd6\x1a\x9cD\xe6\xd0", tactmax, "*e\xca\xfb\xfc\xdfl\xb3\xd3Bv\x1c,", weapons[0][0], "\x15`5O[\xe9_\x82\xc3f\xf0\x10\xf6i\xdbD\x10\x8a\x84\xf7\xf8\xca\x9fQ", weapons[0][1], "6=\x80\x97!\xc5\xc4\x93\xbbA7\x1d\xf1\xe4\xdb\x9e\xbf\xb09\x9a\a\xaf", weapons[0][2], "Op\xc8s\xb3]mP\xf3\xd0n\xd8\x7f", weapons[1][0], "\x90\x19\b\x19\xd6\xb1\xdd}\xd5\xfa\xb7\xd6$\xed\xf2\x89\xbf&m\xf6#\x1e\x93\xcb", weapons[1][1], "hyug8\xc9dG\xe2\xbd\xaa^\x7f\x11hZ\x8a\x18d1`,", weapons[1][2], "\xb1(Y\xb1\x1a \x8c\xff\xfaK\xaf\x1dk", weapons[2][0], "W\x0ee\xc6*\x11\xedfc\xad1\xcf'S\x98UW\xccK$v\xf4\xac2", weapons[2][1], "\xd8\x8bk`\xf8U\xb5\x04\x95\xc5e\x1e\x82\xa3Z\xe0\xd8\xd9\xad\x01[\x10", weapons[2][2], "\x16\xc5\x9a\xd8\xcd\xd3\xcbU}D\xfb\x06\xfb", weapons[3][0], "\xdb\xe8hY\x9c\xf5\xbb\x95\xb0p{s}\x16\xadk\xb7}c\xf6u\xe6\xa3f", weapons[3][1], "\xa5d\x8c8\xba\xd4m$0dR\r\xbdt=\xed\xe5\xce\x840\xc8\x95", weapons[3][2], "\x849\xad\x9c\aH=\x9b4\xab\xbc\xbe\x1a", weapons[4][0], "p\x06\x17\xe00\xbc\xf2o\xfa\xc1>\x90y\xc6z\ra%\x8d\xef\xee\x9345", weapons[4][1], "\xacu\xfe\xd7\x82\xa4\xb3\xcd\xdd\x16\xde52\xa3}\x8aKLn\xfa\xf35", weapons[4][2], "a9\x04J\x96eS\x96UP\x11G\x97\xcca\xaa\x9c", shotstats[0][0], "\xe6\r\xdeGn\x1d\xb0\x8es\xbewY\v\xc1\xdb\xe6\xeb\xcd4\xf6\xd1\xb9\xeb\x99\xa5'\xca\x91\xc0", shotstats[0][1], "\xa6w7uM6\x9bxXl0F\xff\r\x91\xce\xc7\x151\xd8\xcc\xf9\\\x98\x88)\x7f", shotstats[0][2], "\xde\a\xd5\x026\xab\x89\x8fX5\x1f\xbe`\x91\xe9\xb9\xf7\xe6\x90\x15\fo\xf8", shotstats[0][3], "{\xe5C\xd9\xbf\xb1F\a\xbf\xf8\x91\x7f\xab\x01~9\x10", shotstats[1][0], "(\xa9\x803SMW\r\x01,\x897\x9dJ\xf7\x12p\xcf\x9a\x81\x05\x02('7{n}\xb8", shotstats[1][1], "\xcf\xf1\x1b\a#\x9b\xf4\xa0\xc4\x8c&\xbe\xc0\xb5\xba\xbc\xc6\x83\xed\xef\xee]J(\x91\xe5\xfb", shotstats[1][2], "\xc1\xee\x01|Js\xf6\x984=\x14\xe3\xcag\xa7p\x9e\xa8\xd9\xa8\x7fKq", shotstats[1][3], "\x1b\xf0\xe3\v\xa0\xae\x1f\xe8\x06\xd2{>\xba\x98\xb4\x80-", shotstats[2][0], "\xb6A\xb7\xb7\xbe\xf4?\x90\xecB\xed\xfb\x8c\xc7\xe1\x90\"$D\xba-\xd70\xf8\x92\xc3\xd0\xc6\xb4", shotstats[2][1], ".\x12\x18\xe4:\xa1\x9e\x1dM\x19\xc0\xfb\xd4G\xaf\xbd^\xf4\xc6u\x1fh6sOlu", shotstats[2][2], "\x04\xe8r\xad\xe8\xaeJ^\x85m7\xf2e\xb04\xf5\xc7\x06+\xeb\xd6!_", shotstats[2][3]]);
}

function function_97899e80fefc3258(struct) {
  if(function_d1fefefc35d01f33()) {
    return;
  }

  spheader = get_spheader();
  prompt = "B@\xb0\x1d\xbc\xf7\x1f";
  promptclass = "B@\xb0\x1d\xbc\xf7\x1f";
  promptmodel = "\r+x5";
  promptorigin = (0, 0, 0);

  if(isDefined(struct)) {
    if(isDefined(struct.script_noteworthy)) {
      prompt = struct.script_noteworthy;
    } else if(isDefined(struct.targetname)) {
      prompt = struct.targetname;
    }

    if(isDefined(struct.classname)) {
      promptclass = struct.classname;
    }

    if(isDefined(struct.model)) {
      promptmodel = struct.model;
    }

    if(isDefined(struct.origin)) {
      promptorigin = struct.origin;
    }
  }

  level.player dlog_recordplayerevent("\x19\xd8{\xec\xeb+\x9de7\xe8_\xe68\xd7i7:e\x9c\x85\xc6\x1d", ["}\x8fA\x03\xa1R\xcb\xfe\xf2", spheader, "K5\xe7h\x8d\x84", prompt, "\xf1\xf71$\xae\xe2'\xc0\xdd\xf9\xf7C\x97b\x14", promptclass, "JH\xa8\xc1\xf5&\x16>\xf3\x0ep", promptmodel, "\bN\x11\xba\x84\xd9)", promptorigin[0], "\x19\x18\xf4Qn{t", promptorigin[1], "6D+\b\xef\xe4\xb9", promptorigin[2]]);
}

function function_895762e4c0b1ba38(subevent, param0, param1, param2) {
  if(function_d1fefefc35d01f33()) {
    return;
  }

  spheader = get_spheader();

  if(!isDefined(subevent)) {
    subevent = "\r+x5";
  }

  param0 = function_2f8493812755ce1a(param0);
  param1 = function_2f8493812755ce1a(param1);
  param2 = function_2f8493812755ce1a(param2);
  level.player dlog_recordplayerevent("\xef\xd8\xd5\x11\x8b\x1dK\xf1\xdfI-Wpj\t\x9b\xaa\xad\x86\xe88\x03]\x01\rx\x95", ["}\x8fA\x03\xa1R\xcb\xfe\xf2", spheader, "=\t\xea\xf9\x93\xc6v[", subevent, "\xda\xe3\xeeH\x84\xff", param0, ":\x1b\xc1\xce\xea\xff", param1, "G\x84\x16\n\xb2p", param2]);
}

function function_2f8493812755ce1a(param) {
  if(!isDefined(param)) {
    param = "\xdc\x9boB";
  } else if(isint(param) || isfloat(param)) {
    param = "" + param;
  }

  return param;
}

function function_23ce4b1441335ad6(subevent, objname) {
  if(function_d1fefefc35d01f33()) {
    return;
  }

  spheader = get_spheader();

  if(!isDefined(subevent)) {
    subevent = "B@\xb0\x1d\xbc\xf7\x1f";
  }

  if(!isDefined(objname)) {
    objname = "B@\xb0\x1d\xbc\xf7\x1f";
  }

  kills = 0;
  killmelee = 0;
  killexplosive = 0;
  deaths = 0;
  headshots = 0;
  shotshit = 0;
  shotsmissed = 0;
  weapon = "\r+x5";
  weaponammo = 0;
  weaponmax = 0;
  currentweapon = level.player getcurrentweapon();

  if(isDefined(currentweapon)) {
    weapon = getweaponbasename(currentweapon);
    weaponammo = level.player getweaponammoclip(currentweapon);
    weaponmax = weaponclipsize(currentweapon);
  }

  lethal = "\r+x5";
  lethalammo = 0;
  lethalmax = 0;
  offhand = level.player getcurrentoffhand("\xa9\nC\xc9\v\xda\xbdS\xa8\xe9?t\x14\x1e");

  if(isDefined(offhand)) {
    lethal = getweaponbasename(offhand);

    if(isDefined(offhand.clipsize)) {
      lethalammo = offhand.clipsize;
    }

    if(isDefined(offhand.maxammo)) {
      lethalmax = offhand.maxammo;
    }
  }

  tact = "\r+x5";
  tactammo = 0;
  tactmax = 0;
  offhand = level.player getcurrentoffhand("\xfe\x06E\x80wqb\x96\xaa\xa0\x8b\xaaY\x92e\x9e");

  if(isDefined(offhand)) {
    tact = getweaponbasename(offhand);

    if(isDefined(offhand.clipsize)) {
      tactammo = offhand.clipsize;
    }

    if(isDefined(offhand.maxammo)) {
      tactmax = offhand.maxammo;
    }
  }

  weapons = [];

  for(i = 0; i <= 4; i++) {
    weapons[i] = get_weapon_info(i);
  }

  shotstats = [];

  for(i = 0; i <= 2; i++) {
    shotstats[i] = function_6054222d108902ba(i);
  }

  level.player dlog_recordplayerevent("\b\xd0\xb9\xc9\xd5\x8e\xcb\x80\x05[\xce5I\xd8\xb3\t\t\xfc\xa1I\xe7\x94y\x8b", ["=\t\xea\xf9\x93\xc6v[", subevent, "\x03H\xd2\xe9\xea\xaeZVG\xa9!\xf6E", objname, "E\xb9\xf4j\x0f", kills, "\xfb\xbekj@\x19\x1a\x94\xb8\x06", killmelee, "\x14!b\xdc\xa1\x83\x12E\x91\xdcCI\x9e\xa5", killexplosive, "\x1aC\xf9\fo\x1b", deaths, "\x86\xb2\x16\x8c\xcdC\xde\x1ds", headshots, "\xc5\x81\x04\xc4\x18\x1b\xef\xcf", shotshit, "\xbb?f\x04\x7f\xb4\"\xa6\xe6\xef\xf0", subevent, "/\x04\xf3\xfa2\x7fA#A\xc10\xe0\xfa\xa2", weapon, "\xef\x1a]\x0e\xee=\x19[\x0fU>\x0f\xc2\xe0z<e\xb1\x8aP\v\xcb\xca\xa2x", weaponammo, "}v6|T/\xe8\x86t\xd3+CN\xbf\xe1\x9d\xbe\x06RM\f\xeaq", weaponmax, "\xb3|\xdb- \xa7\xa9\x9c}\xbf\xbc", weapon, "9Tv\xd6p%/\xe0x\xee\xf4?\xb3\x05Q\xbeR\xa2\xaeY\x0e|", weaponammo, "X\xf5H-\x9a\xc2\xf2_\x1fZ\xce\\o\xb0\xf8@&\xf9\x90t", weaponmax, "\x04k\xb7\x8ewD/\xe9\x13@\xbe\xd0\x944", lethal, "\xe2,\xdd\x80\x9e*\x1b$\xb4rrA\a\x84O\x87\xbb\xc0\xfb\xbe\xe0\x06\xd6\x1a\x91", lethalammo, "1\x8b\xd2\xd0\xf2#\xbc;\xa6<*\x90\xed\xf1\xd4$\"\x94\xc1[\f\xe0\x91", lethalmax, "\xb7FB\x8b:\x80}\xd63\x16\x96\x0e\xdc\xc3\xda^", tact, "o\x05w\xce\x9d\xcb\xc3\xb8\f*\xf3\x95\x90G\x9b\xe8a\xb4\xfa\x04\xf9\x06\xa5\xf1\xc0R=", tactammo, "j\xed\xcd\xd9\xda\xcd\xeec2|\x1b}\x1f,?\xe2r\xf5\x1f\xd6\x1a\x9cD\xe6\xd0", tactmax, "*e\xca\xfb\xfc\xdfl\xb3\xd3Bv\x1c,", weapons[0][0], "\x15`5O[\xe9_\x82\xc3f\xf0\x10\xf6i\xdbD\x10\x8a\x84\xf7\xf8\xca\x9fQ", weapons[0][1], "6=\x80\x97!\xc5\xc4\x93\xbbA7\x1d\xf1\xe4\xdb\x9e\xbf\xb09\x9a\a\xaf", weapons[0][2], "Op\xc8s\xb3]mP\xf3\xd0n\xd8\x7f", weapons[1][0], "\x90\x19\b\x19\xd6\xb1\xdd}\xd5\xfa\xb7\xd6$\xed\xf2\x89\xbf&m\xf6#\x1e\x93\xcb", weapons[1][1], "hyug8\xc9dG\xe2\xbd\xaa^\x7f\x11hZ\x8a\x18d1`,", weapons[1][2], "\xb1(Y\xb1\x1a \x8c\xff\xfaK\xaf\x1dk", weapons[2][0], "W\x0ee\xc6*\x11\xedfc\xad1\xcf'S\x98UW\xccK$v\xf4\xac2", weapons[2][1], "\xd8\x8bk`\xf8U\xb5\x04\x95\xc5e\x1e\x82\xa3Z\xe0\xd8\xd9\xad\x01[\x10", weapons[2][2], "\x16\xc5\x9a\xd8\xcd\xd3\xcbU}D\xfb\x06\xfb", weapons[3][0], "\xdb\xe8hY\x9c\xf5\xbb\x95\xb0p{s}\x16\xadk\xb7}c\xf6u\xe6\xa3f", weapons[3][1], "\xa5d\x8c8\xba\xd4m$0dR\r\xbdt=\xed\xe5\xce\x840\xc8\x95", weapons[3][2], "\x849\xad\x9c\aH=\x9b4\xab\xbc\xbe\x1a", weapons[4][0], "p\x06\x17\xe00\xbc\xf2o\xfa\xc1>\x90y\xc6z\ra%\x8d\xef\xee\x9345", weapons[4][1], "\xacu\xfe\xd7\x82\xa4\xb3\xcd\xdd\x16\xde52\xa3}\x8aKLn\xfa\xf35", weapons[4][2], "a9\x04J\x96eS\x96UP\x11G\x97\xcca\xaa\x9c", shotstats[0][0], "\xe6\r\xdeGn\x1d\xb0\x8es\xbewY\v\xc1\xdb\xe6\xeb\xcd4\xf6\xd1\xb9\xeb\x99\xa5'\xca\x91\xc0", shotstats[0][1], "\xa6w7uM6\x9bxXl0F\xff\r\x91\xce\xc7\x151\xd8\xcc\xf9\\\x98\x88)\x7f", shotstats[0][2], "\xde\a\xd5\x026\xab\x89\x8fX5\x1f\xbe`\x91\xe9\xb9\xf7\xe6\x90\x15\fo\xf8", shotstats[0][3], "{\xe5C\xd9\xbf\xb1F\a\xbf\xf8\x91\x7f\xab\x01~9\x10", shotstats[1][0], "(\xa9\x803SMW\r\x01,\x897\x9dJ\xf7\x12p\xcf\x9a\x81\x05\x02('7{n}\xb8", shotstats[1][1], "\xcf\xf1\x1b\a#\x9b\xf4\xa0\xc4\x8c&\xbe\xc0\xb5\xba\xbc\xc6\x83\xed\xef\xee]J(\x91\xe5\xfb", shotstats[1][2], "\xc1\xee\x01|Js\xf6\x984=\x14\xe3\xcag\xa7p\x9e\xa8\xd9\xa8\x7fKq", shotstats[1][3], "\x1b\xf0\xe3\v\xa0\xae\x1f\xe8\x06\xd2{>\xba\x98\xb4\x80-", shotstats[2][0], "\xb6A\xb7\xb7\xbe\xf4?\x90\xecB\xed\xfb\x8c\xc7\xe1\x90\"$D\xba-\xd70\xf8\x92\xc3\xd0\xc6\xb4", shotstats[2][1], ".\x12\x18\xe4:\xa1\x9e\x1dM\x19\xc0\xfb\xd4G\xaf\xbd^\xf4\xc6u\x1fh6sOlu", shotstats[2][2], "\x04\xe8r\xad\xe8\xaeJ^\x85m7\xf2e\xb04\xf5\xc7\x06+\xeb\xd6!_", shotstats[2][3]]);
}

function function_59e3c31c2166f067(subevent, ai) {
  if(function_d1fefefc35d01f33()) {
    return;
  }

  spheader = get_spheader();
  origin = (0, 0, 0);
  alertlevel = 0;

  if(!isDefined(subevent)) {
    subevent = "\r+x5";
  }

  if(isDefined(ai)) {
    if(isDefined(ai.origin)) {
      origin = ai.origin;
    }

    if(isDefined(ai.alertlevel)) {
      alertlevel = ai.alertlevel;
    }
  }

  level.player dlog_recordplayerevent("\xef\xd8\xd5\x11\x8b\x1dK\xf1\xdfI-Wpj\t\x9b\xaa\xad\x86\xe88\x03]\x01\rx\x95", ["=\t\xea\xf9\x93\xc6v[", subevent, "\xf7\xec2\xaf\x97]", origin[0], "\xe0\xde;RN4", origin[1], "~\x01\x88\xde]e", origin[2], "\\*\xe3\xec\x10\xab\x1a\xbc\xc0\xa0", alertlevel]);
}

function get_weapon_info(i) {
  weapon = [];

  if(isDefined(level.player.primaryweapons[i])) {
    current = level.player.primaryweapons[i];
    weapon[0] = getweaponbasename(current);
    weapon[1] = level.player getweaponammoclip(current);
    weapon[2] = weaponclipsize(current);
  } else {
    weapon[0] = "\xdc\x9boB";
    weapon[1] = 0;
    weapon[2] = 0;
  }

  return weapon;
}

function function_6054222d108902ba(i) {
  weapon = [];
  weapon[0] = "\r+x5";
  weapon[1] = 0;
  weapon[2] = 0;
  weapon[3] = 0;
  return weapon;
}