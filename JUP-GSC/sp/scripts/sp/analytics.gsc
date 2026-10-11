/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\sp\analytics.gsc
***********************************************/

#using scripts\common\utility;
#using scripts\engine\sp\utility;
#using scripts\engine\sp\utility_code;
#using scripts\engine\utility;
#using scripts\sp\equipment\offhands;
#using scripts\sp\utility;
#namespace analytics;

function main() {
  setdvarifuninitialized(@ "hash_e10567ef7a26589d", 0);
  level.analytics = spawnStruct();
  level.analytics.missionstarttime = level.player getplayerprogression("totalGameplayTime");
  level.analytics.startingdifficulty = getdifficultylevel();
  level.analytics.sp_counter = 0;
  level.analytics.sp_skip = 0;
  setDvar(@ "hash_237093776d23c007", 0);
  thread analyticsthread();
}

function analyticsthread() {
  level.player setplayerprogression("kleenexSessionGameplayTime", 0);
  level.player setplayerprogression("playerMountCounter", 0);
  level.player setplayerprogression("focusCounter", 0);
  level.player thread analytics_tracking_player_mount();
  level.player thread function_e1b9d15ec94cb4e();
  level.player thread function_403ba6e8e350384a();
  level.player thread function_62d66ac3e68e3942();

  while(true) {
    if(!isalive(level.player)) {
      wait 10;
      continue;
    }

    if(issaverecentlyloaded() || getdvarint(@ "hash_237093776d23c007")) {
      function_1c2e57f669be05b2();

      if(issaverecentlyloaded()) {
        wait 2;
      }
    }

    wait 0.5;
  }
}

function function_1c2e57f669be05b2() {
  setDvar(@ "hash_237093776d23c007", 0);
  setDvar(@ "hash_83208d256c505088", gettime());
  setDvar(@ "hash_327cf97ac22238cf", gettime());
}

function analytics_tracking_player_mount() {
  while(true) {
    while(self playermount() < 0.5) {
      wait 0.1;
    }

    self notify("start_player_mount");
    mounts = level.player getplayerprogression("playerMountCounter");
    level.player setplayerprogression("playerMountCounter", mounts + 1);

    while(self playermount() >= 0.5) {
      wait 0.1;
    }

    wait 0.1;
  }
}

function analytics_upload_during_nextmission() {
  if(isDefined(level.script) && isDefined(level.player)) {
    function_78ecf8f9be6b2e4d("mount_total", level.player getplayerprogression("playerMountCounter"), level.script);
  }
}

function analytics_lui_mission_end_dlog() {
  setomnvar("ui_mission_end_dlog", 1);
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
  duration = float(current + level.player getplayerprogression("kleenexSessionGameplayTime"));
  level.player dlog_recordplayerevent("dlog_event_analytics_sp_kleenex_session", ["levelname", level.script, "Section", name, "Duration", duration]);
  setDvar(@ "hash_327cf97ac22238cf", gettime());
  level.player setplayerprogression("kleenexSessionGameplayTime", 0);
  println("<dev string:x1c>" + name + "<dev string:x22>" + duration);
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
  level.player setplayerprogression("startPointDeaths", 0);
  level.player setplayerprogression("startPointFails", 0);
  level.player setplayerprogression("sessionGameplayTime", 0);
  level.player setplayerprogression("focusCounter", 0);
}

function start_point_update(name, bypass) {
  if(istrue(level.nextmission) && !isDefined(bypass)) {
    return;
  }

  current = int((gettime() - getdvarint(@ "hash_83208d256c505088")) / 1000);
  duration = float(current + level.player getplayerprogression("sessionGameplayTime"));
  deaths = level.player getplayerprogression("startPointDeaths");
  fails = level.player getplayerprogression("startPointFails");
  diff = get_gameskill_as_string();
  level.analytics.sp_counter++;
  level.player dlog_recordplayerevent("dlog_event_analytics_sp_start_points", ["levelname", level.script, "Start", name, "Duration", duration, "Deaths", deaths, "Fails", fails, "difficulty", diff]);
  println("<dev string:x25>" + level.script + "<dev string:x22>" + name + "<dev string:x44>" + duration + "<dev string:x48>" + deaths + "<dev string:x50>" + fails + "<dev string:x5a>" + diff);
  focus = level.player getplayerprogression("focusCounter");
  analytics_event_upload("startPoint_focusCounter", focus);
}

function get_gameskill_as_string() {
  diff = level.player get_player_gameskill();

  if(diff == 0) {
    return "Recruit";
  }

  if(diff == 1) {
    return "Regular";
  }

  if(diff == 2) {
    return "Hardened";
  }

  if(diff == 3) {
    return "Veteran";
  }

  if(diff == 4) {
    return "Realism";
  }
}

function analytics_obj_failed() {
  failed = level.player getplayerprogression("startPointFails");
  level.player setplayerprogression("startPointFails", failed + 1);
}

function update_focus_counter() {
  focus = level.player getplayerprogression("focusCounter");
  focus++;
  level.player setplayerprogression("focusCounter", focus);
  function_78ecf8f9be6b2e4d("focus_pressed", focus);
}

function playerdeath() {
  updatetotalgameplaytime();
  deaths = level.player getplayerprogression("startPointDeaths");
  level.player setplayerprogression("startPointDeaths", deaths + 1);
  setDvar(@ "hash_237093776d23c007", 1);
}

function updatetotalgameplaytime() {
  totalgameplaytime = level.player getplayerprogression("totalGameplayTime");
  var_7f901be676ffdc5a = level.player getplayerprogression("sessionGameplayTime");
  var_bf30f615d3c9cc66 = int((gettime() - getdvarint(@ "hash_83208d256c505088")) / 1000);
  time = var_7f901be676ffdc5a + var_bf30f615d3c9cc66;
  level.player setplayerprogression("sessionGameplayTime", time);
  var_8be67aa3c92c2c34 = level.player getplayerprogression("kleenexSessionGameplayTime");
  currentsessiontime = int((gettime() - getdvarint(@ "hash_327cf97ac22238cf")) / 1000);
  time2 = var_8be67aa3c92c2c34 + currentsessiontime;
  level.player setplayerprogression("kleenexSessionGameplayTime", time2);

  if(var_bf30f615d3c9cc66 > 0) {
    totalgameplaytime += var_bf30f615d3c9cc66;
    level.player setplayerprogression("totalGameplayTime", totalgameplaytime);
  }

  println("<dev string:x63>" + var_bf30f615d3c9cc66 + "<dev string:x77>" + totalgameplaytime);
  return totalgameplaytime;
}

function getdifficultylevel() {
  difficulty = getdvarint(@ "g_gameskill") + 1;

  if(in_specialist_mode()) {
    difficulty = 5;
  } else if(in_yolo_mode()) {
    difficulty = 6;
  }

  return difficulty;
}

function analytics_event_upload(eventstring, num) {
  level.player dlog_recordplayerevent("dlog_event_analytics_sp_kleenex_event", ["levelname", level.script, "Event", eventstring, "Integer", num], 1);
}

function get_spheader() {
  levelname = "none";
  startpoint = "none";
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
    diff = "unknown";
  }

  array = ["level_name", levelname, "gametime", gettime(), "originx", origin[0], "originy", origin[1], "originz", origin[2], "angleyaw", angles[1], "anglepitch", angles[0], "startpoint", startpoint, "difficulty", diff];
  return array;
}

function function_82971a8b14a8ad8a() {
  version = getbuildversion();

  if(version == "SHIP") {
    return true;
  }

  return false;
}

function function_62d66ac3e68e3942() {
  if(function_82971a8b14a8ad8a()) {
    return;
  }

  self endon("death");

  for(freq = 0; true; freq++) {
    wait 5;
    function_1d85814a1517480f(freq);
  }
}

function analytics_playerdamage(attacker, objweapon, damage, damagemod, partname) {
  function_f2a009b8402cd364("dlog_event_sp_damage", attacker, objweapon, damage, damagemod, partname);
}

function analytics_playerdeath(attacker, objweapon, damage, damagemod, partname) {
  function_f2a009b8402cd364("dlog_event_sp_death", attacker, objweapon, damage, damagemod, partname);
}

function function_f2a009b8402cd364(event, attacker, objweapon, damage, damagemod, partname) {
  if(function_82971a8b14a8ad8a()) {
    return;
  }

  spheader = get_spheader();
  attid = "unknown";
  atttype = "unknown";
  attclassname = "unknown";
  attweapon = "unknown";
  attpos = (0, 0, 0);
  attyaw = 0;
  victimdied = 1;
  attcombat = "unknown";
  attignoreme = 0;
  attignoreall = 0;
  attfovcos = 0;
  var_d8b49b4111c2f083 = 0;
  attanimname = "unknown";
  attlaststand = 0;

  if(isDefined(attacker)) {
    num = attacker getentitynumber();

    if(isDefined(num)) {
      attid = "$e" + num;
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
      var_d8b49b4111c2f083 = attacker.maxsightdistsqrd;
    }
  }

  dmg = 0;
  dmgtype = "no_data";
  dmgloc = "no_data";

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

  weapon = "none";
  weaponammo = 0;
  weaponmax = 0;
  currentweapon = level.player getcurrentweapon();

  if(isDefined(currentweapon)) {
    weapon = getweaponbasename(currentweapon);
    weaponammo = level.player getweaponammoclip(currentweapon);
    weaponmax = weaponclipsize(currentweapon);
  }

  backupweapon = "none";
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

  lethal = "none";
  lethalammo = 0;
  lethalmax = 0;
  offhand = level.player getcurrentoffhand("primaryoffhand");

  if(isDefined(offhand)) {
    lethal = getweaponbasename(offhand);

    if(isDefined(offhand.clipsize)) {
      lethalammo = offhand.clipsize;
    }

    if(isDefined(offhand.maxammo)) {
      lethalmax = offhand.maxammo;
    }
  }

  tact = "none";
  tactammo = 0;
  tactmax = 0;
  offhand = level.player getcurrentoffhand("secondaryoffhand");

  if(isDefined(offhand)) {
    tact = getweaponbasename(offhand);

    if(isDefined(offhand.clipsize)) {
      tactammo = offhand.clipsize;
    }

    if(isDefined(offhand.maxammo)) {
      tactmax = offhand.maxammo;
    }
  }

  level.player dlog_recordplayerevent(event, ["sp_header", spheader, "attackerid", attid, "attackertype", atttype, "attackerclassname", attclassname, "attackerweapon", attweapon, "attackerx", attpos[0], "attackery", attpos[1], "attackerz", attpos[2], "attackeryaw", attyaw, "attackercombatmode", attcombat, "attackerignoreme", attignoreme, "attackerignoreall", attignoreall, "attackerfovcos", attfovcos, "attackermaxsightdistsqrd", var_d8b49b4111c2f083, "attackeranimname", attanimname, "attackerlaststand", attlaststand, "damage", dmg, "damagetype", dmgtype, "damagelocation", dmgloc, "victimdied", victimdied, "current_gun", weapon, "current_gun_ammo_count", weaponammo, "current_gun_ammo_max", weaponmax, "current_backup", backupweapon, "current_backup_ammo_count", backupammo, "current_backup_ammo_max", backupmax, "current_lethal", lethal, "current_lethal_ammo_count", lethalammo, "current_lethal_ammo_max", lethalmax, "current_tactical", tact, "current_tactical_ammo_count", tactammo, "current_tactical_ammo_max", tactmax]);
}

function function_e1b9d15ec94cb4e() {
  if(function_82971a8b14a8ad8a()) {
    return;
  }

  self endon("death");

  while(true) {
    self waittill("weapon_switch_started", groundweapon);
    currentweapon = self getcurrentweapon();

    if(isDefined(groundweapon) && isDefined(currentweapon)) {
      basename1 = getweaponbasename(currentweapon);
      basename2 = getweaponbasename(groundweapon);
      function_620657ef3e312b63("weapon_switch", basename1, basename2);
    }
  }
}

function function_403ba6e8e350384a() {
  if(function_82971a8b14a8ad8a()) {
    return;
  }

  self endon("death");

  while(true) {
    self waittill("pickup", null, oldweapon);
    endtime = gettime() + 200;

    while(true) {
      newweapon = self getcurrentweapon();

      if(isDefined(newweapon) && !isnullweapon(newweapon)) {
        break;
      }

      if(gettime() > endtime) {
        newweapon = undefined;
        break;
      }

      waitframe();
    }

    if(isDefined(oldweapon) && isDefined(newweapon)) {
      basename1 = getweaponbasename(oldweapon);
      basename2 = getweaponbasename(newweapon);

      if(!is_equal(basename1, "none") && !is_equal(basename2, "none")) {
        function_620657ef3e312b63("weapon_pickup", basename1, basename2);
      }
    }
  }
}

function function_5cf6c6af86fd4710(weapon) {
  if(function_82971a8b14a8ad8a()) {
    return;
  }

  subevent = "none";
  weaponname = "null";

  if(isDefined(weapon)) {
    type = scripts\sp\equipment\offhands::getweaponoffhandtype(weapon);

    if(isDefined(type)) {
      if(type == "primaryoffhand") {
        subevent = "weapon_lethal_thrown";
      } else if(type == "secondaryoffhand") {
        subevent = "weapon_tactical_thrown";
      }
    }

    basename = getweaponbasename(weapon);

    if(isDefined(basename)) {
      weaponname = basename;
    }
  }

  function_620657ef3e312b63(subevent, weaponname);
}

function function_620657ef3e312b63(subevent, weaponname, param0) {
  if(function_82971a8b14a8ad8a()) {
    return;
  }

  spheader = get_spheader();

  if(!isDefined(subevent)) {
    subevent = "none";
  }

  if(!isDefined(weaponname)) {
    weaponname = "null";
  }

  if(!isDefined(param0)) {
    param0 = "null";
  }

  level.player dlog_recordplayerevent("dlog_event_sp_weap", ["sp_header", spheader, "subevent", subevent, "weapon", weaponname, "param0", param0]);
}

function function_7212c89168020e04(victim, attacker, objweapon) {
  if(function_82971a8b14a8ad8a()) {
    return;
  }

  spheader = get_spheader();
  vicid = "unknown";
  victype = "unknown";
  vicclassname = "unknown";
  viccombat = "unknown";
  vicignoreme = 0;
  vicignoreall = 0;
  vicfovcos = 0;
  var_3deaf3d1300142a = 0;
  vicanimname = "unknown";
  viclaststand = 0;
  vicpos = (0, 0, 0);
  dmg = 0;
  dmgtype = "no_data";
  dmgloc = "no_data";

  if(isDefined(victim)) {
    num = victim getentitynumber();

    if(isDefined(num)) {
      vicid = "$e" + num;
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
      var_3deaf3d1300142a = victim.maxsightdistsqrd;
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

  attid = "unknown";
  atttype = "unknown";
  attclassname = "unknown";
  attweapon = "unknown";
  attpos = (0, 0, 0);
  attyaw = 0;
  victimdied = 1;
  attcombat = "unknown";
  attignoreme = 0;
  attignoreall = 0;
  attfovcos = 0;
  var_d8b49b4111c2f083 = 0;
  attanimname = "unknown";
  attlaststand = 0;

  if(isDefined(attacker)) {
    num = attacker getentitynumber();

    if(isDefined(num)) {
      attid = "$e" + num;
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
      var_d8b49b4111c2f083 = attacker.maxsightdistsqrd;
    }
  }

  level.player dlog_recordplayerevent("dlog_event_sp_aideath", ["sp_header", spheader, "victimid", vicid, "victimtype", victype, "victimclassname", vicclassname, "victimx", vicpos[0], "victimy", vicpos[1], "victimz", vicpos[2], "victimcombatmode", viccombat, "victimignoreme", vicignoreme, "victimignoreall", vicignoreall, "victimfovcos", vicfovcos, "victimmaxsightdistsqrd", var_3deaf3d1300142a, "victimanimname", vicanimname, "victimlaststand", viclaststand, "attackerid", attid, "attackertype", atttype, "attackerclassname", attclassname, "attackerweapon", attweapon, "attackerx", attpos[0], "attackery", attpos[1], "attackerz", attpos[2], "attackeryaw", attyaw, "attackercombatmode", attcombat, "attackerignoreme", attignoreme, "attackerignoreall", attignoreall, "attackerfovcos", attfovcos, "attackermaxsightdistsqrd", var_d8b49b4111c2f083, "attackeranimname", attanimname, "attackerlaststand", attlaststand, "damage", dmg, "damagetype", dmgtype, "damagelocation", dmgloc, "victimdied", victimdied]);
}

function analytics_aispawn(ai) {
  if(function_82971a8b14a8ad8a()) {
    return;
  }

  spheader = get_spheader();
  actorid = "unknown";
  aitype = "unknown";
  aiclassname = "unknown";
  aiacc = 0;
  aiweapon = "none";
  aiteam = "none";
  aialert = "unknown";
  var_dc111601c4bb8cf2 = 0;
  var_ab8c7786c92812ae = 0;
  var_d79a8d8dc465f158 = 0;
  var_abaf8986c94e81fc = 0;
  var_b85d035e58c86482 = 0;
  aihealth = 0;

  if(isDefined(ai)) {
    num = ai getentitynumber();

    if(isDefined(num)) {
      actorid = "$e" + num;
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
      var_dc111601c4bb8cf2 = ai.grenadeawareness;
    }

    if(isDefined(ai.engagemaxdist)) {
      var_ab8c7786c92812ae = ai.engagemaxdist;
    }

    if(isDefined(ai.engagemaxfalloffdist)) {
      var_d79a8d8dc465f158 = ai.engagemaxfalloffdist;
    }

    if(isDefined(ai.engagemindist)) {
      var_abaf8986c94e81fc = ai.engagemindist;
    }

    if(isDefined(ai.engageminfalloffdist)) {
      var_b85d035e58c86482 = ai.engageminfalloffdist;
    }

    if(isDefined(ai.health)) {
      aihealth = ai.health;
    }
  }

  level.player dlog_recordplayerevent("dlog_event_sp_aispawn", ["actorid", actorid, "aitype", aitype, "classname", aiclassname, "accuracy", aiacc, "weapon", aiweapon, "team", aiteam, "alertlevel", aialert, "grenadeawareness", var_dc111601c4bb8cf2, "engagemaxdist", var_ab8c7786c92812ae, "engagemaxfalloffdist", var_d79a8d8dc465f158, "engagemindist", var_abaf8986c94e81fc, "engageminfalloffdist", var_b85d035e58c86482, "health", aihealth]);
}

function function_1d85814a1517480f(freq) {
  if(function_82971a8b14a8ad8a()) {
    return;
  }

  spheader = get_spheader();
  ads = 0;
  seqnum = 0;
  motionstate = "unknown";
  stance = "unknown";
  speed = 0;
  health = 0;

  if(isDefined(level.player)) {
    if(level.player isads()) {
      ads = 1;
    }

    if(isDefined(freq)) {
      seqnum = freq;
    }

    state = function_49cdf8f1128b54a4();

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

  level.player dlog_recordplayerevent("dlog_event_sp_breadcrumbs", ["sp_header", spheader, "is_ads", ads, "sequence_num", seqnum, "motion_state", motionstate, "stance", stance, "speed", speed, "health", health]);
}

function function_49cdf8f1128b54a4() {
  if(self isonladder()) {
    return "ladder";
  }

  if(self issprintsliding()) {
    return "sprintslide";
  }

  if(self issupersprinting()) {
    return "supersprint";
  }

  if(self issprinting()) {
    return "sprint";
  }

  if(self isjumping()) {
    return "jumping";
  }

  if(self isparachuting()) {
    return "parachuting";
  }

  if(self isinfreefall()) {
    return "freefall";
  }

  if(self islinked()) {
    return "linked";
  }

  if(self playermounttype() != "mount_none") {
    return self playermounttype();
  }

  if(self isufo()) {
    return "ufo";
  }

  if(self isnoclip()) {
    return "noClip";
  }

  return "ground";
}

function function_3afc9084a564d28a(subevent) {
  if(function_82971a8b14a8ad8a()) {
    return;
  }

  spheader = get_spheader();

  if(!isDefined(subevent)) {
    subevent = "unknown";
  }

  kills = 0;
  killmelee = 0;
  killexplosive = 0;
  deaths = 0;
  headshots = 0;
  shotshit = 0;
  shotsmissed = 0;
  weapon = "none";
  weaponammo = 0;
  weaponmax = 0;
  currentweapon = level.player getcurrentweapon();

  if(isDefined(currentweapon)) {
    weapon = getweaponbasename(currentweapon);
    weaponammo = level.player getweaponammoclip(currentweapon);
    weaponmax = weaponclipsize(currentweapon);
  }

  lethal = "none";
  lethalammo = 0;
  lethalmax = 0;
  offhand = level.player getcurrentoffhand("primaryoffhand");

  if(isDefined(offhand)) {
    lethal = getweaponbasename(offhand);

    if(isDefined(offhand.clipsize)) {
      lethalammo = offhand.clipsize;
    }

    if(isDefined(offhand.maxammo)) {
      lethalmax = offhand.maxammo;
    }
  }

  tact = "none";
  tactammo = 0;
  tactmax = 0;
  offhand = level.player getcurrentoffhand("secondaryoffhand");

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
    shotstats[i] = function_4bc745ebda95abaf(i);
  }

  level.player dlog_recordplayerevent("dlog_event_sp_startpoints", ["subevent", subevent, "kills", kills, "killsmelee", killmelee, "killsexplosive", killexplosive, "deaths", deaths, "headshots", headshots, "shotshit", shotshit, "shotsmissed", subevent, "current_inhand", weapon, "current_inhand_ammo_count", weaponammo, "current_inhand_ammo_max", weaponmax, "current_gun", weapon, "current_gun_ammo_count", weaponammo, "current_gun_ammo_max", weaponmax, "current_lethal", lethal, "current_lethal_ammo_count", lethalammo, "current_lethal_ammo_max", lethalmax, "current_tactical", tact, "current_tactical_ammo_count", tactammo, "current_tactical_ammo_max", tactmax, "other_weapon0", weapons[0][0], "other_weapon_ammo_count0", weapons[0][1], "other_weapon_ammo_max0", weapons[0][2], "other_weapon1", weapons[1][0], "other_weapon_ammo_count1", weapons[1][1], "other_weapon_ammo_max1", weapons[1][2], "other_weapon2", weapons[2][0], "other_weapon_ammo_count2", weapons[2][1], "other_weapon_ammo_max2", weapons[2][2], "other_weapon3", weapons[3][0], "other_weapon_ammo_count3", weapons[3][1], "other_weapon_ammo_max3", weapons[3][2], "other_weapon4", weapons[4][0], "other_weapon_ammo_count4", weapons[4][1], "other_weapon_ammo_max4", weapons[4][2], "shotstats_weapon0", shotstats[0][0], "shotstats_weapon_shots_fired0", shotstats[0][1], "shotstats_weapon_shots_hit0", shotstats[0][2], "shotstats_weapon_kills0", shotstats[0][3], "shotstats_weapon1", shotstats[1][0], "shotstats_weapon_shots_fired1", shotstats[1][1], "shotstats_weapon_shots_hit1", shotstats[1][2], "shotstats_weapon_kills1", shotstats[1][3], "shotstats_weapon2", shotstats[2][0], "shotstats_weapon_shots_fired2", shotstats[2][1], "shotstats_weapon_shots_hit2", shotstats[2][2], "shotstats_weapon_kills2", shotstats[2][3]]);
}

function function_c307039c62aa3ec9(struct) {
  if(function_82971a8b14a8ad8a()) {
    return;
  }

  spheader = get_spheader();
  prompt = "unknown";
  promptclass = "unknown";
  promptmodel = "none";
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

  level.player dlog_recordplayerevent("dlog_event_sp_interact", ["sp_header", spheader, "prompt", prompt, "promptclassname", promptclass, "promptmodel", promptmodel, "promptx", promptorigin[0], "prompty", promptorigin[1], "promptz", promptorigin[2]]);
}

function function_78ecf8f9be6b2e4d(subevent, param0, param1, param2) {
  if(function_82971a8b14a8ad8a()) {
    return;
  }

  spheader = get_spheader();

  if(!isDefined(subevent)) {
    subevent = "none";
  }

  param0 = function_7d4e1468e4a96223(param0);
  param1 = function_7d4e1468e4a96223(param1);
  param2 = function_7d4e1468e4a96223(param2);
  level.player dlog_recordplayerevent("dlog_event_sp_notifications", ["sp_header", spheader, "subevent", subevent, "param0", param0, "param1", param1, "param2", param2]);
}

function function_7d4e1468e4a96223(param) {
  if(!isDefined(param)) {
    param = "null";
  } else if(isint(param) || isfloat(param)) {
    param = "" + param;
  }

  return param;
}

function function_568756429ff7407(subevent, objname) {
  if(function_82971a8b14a8ad8a()) {
    return;
  }

  spheader = get_spheader();

  if(!isDefined(subevent)) {
    subevent = "unknown";
  }

  if(!isDefined(objname)) {
    objname = "unknown";
  }

  kills = 0;
  killmelee = 0;
  killexplosive = 0;
  deaths = 0;
  headshots = 0;
  shotshit = 0;
  shotsmissed = 0;
  weapon = "none";
  weaponammo = 0;
  weaponmax = 0;
  currentweapon = level.player getcurrentweapon();

  if(isDefined(currentweapon)) {
    weapon = getweaponbasename(currentweapon);
    weaponammo = level.player getweaponammoclip(currentweapon);
    weaponmax = weaponclipsize(currentweapon);
  }

  lethal = "none";
  lethalammo = 0;
  lethalmax = 0;
  offhand = level.player getcurrentoffhand("primaryoffhand");

  if(isDefined(offhand)) {
    lethal = getweaponbasename(offhand);

    if(isDefined(offhand.clipsize)) {
      lethalammo = offhand.clipsize;
    }

    if(isDefined(offhand.maxammo)) {
      lethalmax = offhand.maxammo;
    }
  }

  tact = "none";
  tactammo = 0;
  tactmax = 0;
  offhand = level.player getcurrentoffhand("secondaryoffhand");

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
    shotstats[i] = function_4bc745ebda95abaf(i);
  }

  level.player dlog_recordplayerevent("dlog_event_sp_objectives", ["subevent", subevent, "objectivename", objname, "kills", kills, "killsmelee", killmelee, "killsexplosive", killexplosive, "deaths", deaths, "headshots", headshots, "shotshit", shotshit, "shotsmissed", subevent, "current_inhand", weapon, "current_inhand_ammo_count", weaponammo, "current_inhand_ammo_max", weaponmax, "current_gun", weapon, "current_gun_ammo_count", weaponammo, "current_gun_ammo_max", weaponmax, "current_lethal", lethal, "current_lethal_ammo_count", lethalammo, "current_lethal_ammo_max", lethalmax, "current_tactical", tact, "current_tactical_ammo_count", tactammo, "current_tactical_ammo_max", tactmax, "other_weapon0", weapons[0][0], "other_weapon_ammo_count0", weapons[0][1], "other_weapon_ammo_max0", weapons[0][2], "other_weapon1", weapons[1][0], "other_weapon_ammo_count1", weapons[1][1], "other_weapon_ammo_max1", weapons[1][2], "other_weapon2", weapons[2][0], "other_weapon_ammo_count2", weapons[2][1], "other_weapon_ammo_max2", weapons[2][2], "other_weapon3", weapons[3][0], "other_weapon_ammo_count3", weapons[3][1], "other_weapon_ammo_max3", weapons[3][2], "other_weapon4", weapons[4][0], "other_weapon_ammo_count4", weapons[4][1], "other_weapon_ammo_max4", weapons[4][2], "shotstats_weapon0", shotstats[0][0], "shotstats_weapon_shots_fired0", shotstats[0][1], "shotstats_weapon_shots_hit0", shotstats[0][2], "shotstats_weapon_kills0", shotstats[0][3], "shotstats_weapon1", shotstats[1][0], "shotstats_weapon_shots_fired1", shotstats[1][1], "shotstats_weapon_shots_hit1", shotstats[1][2], "shotstats_weapon_kills1", shotstats[1][3], "shotstats_weapon2", shotstats[2][0], "shotstats_weapon_shots_fired2", shotstats[2][1], "shotstats_weapon_shots_hit2", shotstats[2][2], "shotstats_weapon_kills2", shotstats[2][3]]);
}

function function_54cc61a225fd48da(subevent, ai) {
  if(function_82971a8b14a8ad8a()) {
    return;
  }

  spheader = get_spheader();
  origin = (0, 0, 0);
  alertlevel = 0;

  if(!isDefined(subevent)) {
    subevent = "none";
  }

  if(isDefined(ai)) {
    if(isDefined(ai.origin)) {
      origin = ai.origin;
    }

    if(isDefined(ai.alertlevel)) {
      alertlevel = ai.alertlevel;
    }
  }

  level.player dlog_recordplayerevent("dlog_event_sp_notifications", ["subevent", subevent, "otherx", origin[0], "othery", origin[1], "otherz", origin[2], "alertlevel", alertlevel]);
}

function get_weapon_info(i) {
  weapon = [];

  if(isDefined(level.player.primaryweapons[i])) {
    current = level.player.primaryweapons[i];
    weapon[0] = getweaponbasename(current);
    weapon[1] = level.player getweaponammoclip(current);
    weapon[2] = weaponclipsize(current);
  } else {
    weapon[0] = "null";
    weapon[1] = 0;
    weapon[2] = 0;
  }

  return weapon;
}

function function_4bc745ebda95abaf(i) {
  weapon = [];
  weapon[0] = "none";
  weapon[1] = 0;
  weapon[2] = 0;
  weapon[3] = 0;
  return weapon;
}