/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\mgturret.gsc
**************************************/

#using scripts\anim\shared;
#using scripts\common\utility;
#using scripts\engine\sp\utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\sp\mg_penetration;
#using scripts\sp\spawner;
#namespace mgturret;

function init_mgturretsettings() {
  level.mgturretsettings["2\x9fR\xb1"]["C,%\xa4J\x01\x85,\x1f\xb2T\xec\xc3\xed\x8b"] = 2.5;
  level.mgturretsettings["2\x9fR\xb1"]["-c\xb7\x8d\x9fC\xf1\xd4\xf53\xeb\x1d\f%\x82"] = 3;
  level.mgturretsettings["2\x9fR\xb1"]["v!\xffzTWM{"] = 0.38;
  level.mgturretsettings["2\x9fR\xb1"][",\x96\xd4\xe09\xb2\xb02"] = 2;
  level.mgturretsettings["2\x9fR\xb1"]["\x8a8\xcc\xba\x1f\xd3\xa6u\xb5\xac\x01\xdf"] = 0.5;
  level.mgturretsettings["w=&\x15\xbd\xae"]["C,%\xa4J\x01\x85,\x1f\xb2T\xec\xc3\xed\x8b"] = 1.5;
  level.mgturretsettings["w=&\x15\xbd\xae"]["-c\xb7\x8d\x9fC\xf1\xd4\xf53\xeb\x1d\f%\x82"] = 3;
  level.mgturretsettings["w=&\x15\xbd\xae"]["v!\xffzTWM{"] = 0.38;
  level.mgturretsettings["w=&\x15\xbd\xae"][",\x96\xd4\xe09\xb2\xb02"] = 2;
  level.mgturretsettings["w=&\x15\xbd\xae"]["\x8a8\xcc\xba\x1f\xd3\xa6u\xb5\xac\x01\xdf"] = 0.5;
  level.mgturretsettings["\xec\xacV\a"]["C,%\xa4J\x01\x85,\x1f\xb2T\xec\xc3\xed\x8b"] = 0.8;
  level.mgturretsettings["\xec\xacV\a"]["-c\xb7\x8d\x9fC\xf1\xd4\xf53\xeb\x1d\f%\x82"] = 3;
  level.mgturretsettings["\xec\xacV\a"]["v!\xffzTWM{"] = 0.38;
  level.mgturretsettings["\xec\xacV\a"][",\x96\xd4\xe09\xb2\xb02"] = 2;
  level.mgturretsettings["\xec\xacV\a"]["\x8a8\xcc\xba\x1f\xd3\xa6u\xb5\xac\x01\xdf"] = 0.5;
  level.mgturretsettings["\xf0\x93"]["C,%\xa4J\x01\x85,\x1f\xb2T\xec\xc3\xed\x8b"] = 0.4;
  level.mgturretsettings["\xf0\x93"]["-c\xb7\x8d\x9fC\xf1\xd4\xf53\xeb\x1d\f%\x82"] = 3;
  level.mgturretsettings["\xf0\x93"]["v!\xffzTWM{"] = 0.38;
  level.mgturretsettings["\xf0\x93"][",\x96\xd4\xe09\xb2\xb02"] = 2;
  level.mgturretsettings["\xf0\x93"]["\x8a8\xcc\xba\x1f\xd3\xa6u\xb5\xac\x01\xdf"] = 0.5;
}

function main() {
  if(getDvar(@ "mg42") == "") {
    setDvar(@ "mgturret", "\xf8\x88m");
  }

  level.magic_distance = 24;
  utility::create_func_ref("\x9f$\x01V\t\x1c\xdc\x96\x95\xd8^o\xa1\xed\xb4?y\x16s\xf2\x1f,\xd1Z\xf3\xc9\xa5+<\xd1\xaf_", &mgturret_disablelinkedturretangles);
  utility::create_func_ref("\xf2\xa7f\xec\xc4)\fYO>\x89\x89\x1d|\x1b\x80\xfa\x9b\xc8?zn\xb7\x9c-GK\xfc\x13\xf2c", &mgturret_enablelinkedturretangles);
  turretinfos = getEntArray("Fc\xad\xe5\x1b\x80zj\xaeP", #targetname);

  for(index = 0; index < turretinfos.size; index++) {
    turretinfos[index] delete();
  }

  utility::create_lock("\xda\xec\r\x91\xd7#\xe4o\xb9Vn");
  utility::create_lock("B\xfeq\x84a\x12m\x03\x1f\xad?\x8f\xec\x7fR\xf4?\x06\xf9<\xe2c:I");
  thread auto_mgturretlink();
  thread saw_mgturretlink();
  thread turretinits();
}

function mgturret_disablelinkedturretangles() {
  level.player playerlinkedturretanglesdisable();
}

function mgturret_enablelinkedturretangles() {
  level.player playerlinkedturretanglesenable();
}

function turretinits() {
  possible_turrets = getEntArray("?\x96%o2\x88V\xd4\x98\a\xdc", #code_classname);
  var_f903cdba2f2bdb92 = [];

  foreach(possible_turret in possible_turrets) {
    var_f903cdba2f2bdb92 = utility::array_add(var_f903cdba2f2bdb92, possible_turret);
  }

  foreach(turret in var_f903cdba2f2bdb92) {
    if(isDefined(turret.targetname) && turret.targetname == "\x83\xd4\xfc\x0e?\xb7\x8d\xd2\x1a`\xf3\xf2\xbc") {
      turret thread zuluinit();
    }
  }
}

function portable_mg_behavior() {
  self detach("\xc0v\xf1w-<\x9b\xf7\xff\x93\xd1\xc2\xd3\xfd'\xe5\xd6", "\xec\xbfK|\au\xcd\xc2\x19<");
  self endon("\x1e\xfd\xd1\xa2\a");
  self.goalradius = level.default_goalradius;

  if(isDefined(self.target)) {
    node = getnode(self.target, #targetname);

    if(isDefined(node)) {
      if(isDefined(node.radius)) {
        self.goalradius = node.radius;
      }

      self setgoalnode(node);
    }
  }

  while(!isDefined(self.node)) {
    wait 0.05;
  }

  turret_node = undefined;

  if(isDefined(self.target)) {
    node = getnode(self.target, #targetname);
    turret_node = node;
  }

  if(!isDefined(turret_node)) {
    turret_node = self.node;
  }

  if(!isDefined(turret_node)) {
    return;
  }

  if(turret_node.type != "v0\x8c@\x88d") {
    return;
  }

  taken_nodes = gettakennodes();
  taken_nodes[self.node.origin + ""] = undefined;

  if(isDefined(taken_nodes[turret_node.origin + ""])) {
    return;
  }

  turret = turret_node.turret;

  if(isDefined(turret.reserved)) {
    assert(turret.reserved != self);
    return;
  }

  reserve_turret(turret);

  if(turret.issetup) {
    leave_gun_and_run_to_new_spot(turret);
  } else {
    run_to_new_spot_and_setup_gun(turret);
  }

  mg_penetration::gunner_think(turret_node.turret);
}

function mg42_trigger() {
  self waittill("\x91`\xb1\xe7T\x97>");
  level notify(self.targetname);
  level.mg42_trigger[self.targetname] = 1;
  self delete();
}

function mgturret_auto(trigger) {
  trigger waittill("\x91`\xb1\xe7T\x97>");
  ai = getaiarray("\x9a\x1f\x83\x1bs=\x13\xf8");

  for(i = 0; i < ai.size; i++) {
    if(isDefined(ai[i].script_mg42auto) && trigger.script_mg42auto == ai[i].script_mg42auto) {
      ai[i] notify("m\xbbwc0\xe3\b");
      println("<dev string:x24>");
    }
  }

  spawners = getspawnerarray();

  for(i = 0; i < spawners.size; i++) {
    if(isDefined(spawners[i].script_mg42auto) && trigger.script_mg42auto == spawners[i].script_mg42auto) {
      spawners[i].ai_mode = "m\xbbwc0\xe3\b";
      println("<dev string:x36>", i, "<dev string:x44>");
    }
  }

  spawner::kill_trigger(trigger);
}

function mg42_suppressionfire(targets) {
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("\x13Dc\xf1G\xb3vvvq%{\xf3m\x7f\x0e&Y~\xe5");

  if(!isDefined(self.suppresionfire)) {
    self.suppresionfire = 1;
  }

  for(;;) {
    while(self.suppresionfire) {
      self settargetentity(targets[randomint(targets.size)]);
      wait 2 + randomfloat(2);
    }

    self cleartargetentity();

    while(!self.suppresionfire) {
      wait 1;
    }
  }
}

function manual_think(mg42) {
  org = self.origin;
  self waittill("m\xbbwc0\xe3\b");
  mg42 notify("\xdc\x8e\xb7\x83\x99\xd2rZ7;");
  mg42 setmode("m\xbbwc0\xe3\b");
  mg42 settargetentity(level.player);
}

function burst_fire_settings(setting) {
  if(setting == "C\xd3\x9by\xa3") {
    return 0.2;
  }

  if(setting == "\xd5\xe5h\ak\xd9\xff\xd0B\x87;") {
    return 0.5;
  }

  if(setting == "V\x0e\xa9\xda\xc5") {
    return 0.5;
  }

  if(setting == "\xe1\xe3sS\x8e\xa01\xb6\xcb\x9b\xdb\xc4\xb1\x1a\f") {
    return 0.1;
  }

  return 1.5;
}

function burst_fire_unmanned() {
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("\xe6UP\xe4\xccE\x91Cn\x99|@\x9e\xea7\xe3Xy\x1e\x9d\a\xb2\x9b\x92");

  if(isDefined(self.script_delay_min)) {
    mg42_delay = self.script_delay_min;
  } else {
    mg42_delay = burst_fire_settings("C\xd3\x9by\xa3");
  }

  if(isDefined(self.script_delay_max)) {
    var_35eeeaea2c37f58 = self.script_delay_max - mg42_delay;
  } else {
    var_35eeeaea2c37f58 = burst_fire_settings("\xd5\xe5h\ak\xd9\xff\xd0B\x87;");
  }

  if(isDefined(self.script_burst_min)) {
    mg42_burst = self.script_burst_min;
  } else {
    mg42_burst = burst_fire_settings("V\x0e\xa9\xda\xc5");
  }

  if(isDefined(self.script_burst_max)) {
    var_2b1802e361955dcd = self.script_burst_max - mg42_burst;
  } else {
    var_2b1802e361955dcd = burst_fire_settings("&WNn\xa3\xbeNXn;e");
  }

  if(isDefined(self.script_burst_fire_rate)) {
    var_b64e5c54c0e0ed77 = self.script_burst_fire_rate;
  } else {
    var_b64e5c54c0e0ed77 = burst_fire_settings("\xe1\xe3sS\x8e\xa01\xb6\xcb\x9b\xdb\xc4\xb1\x1a\f");
  }

  pauseuntiltime = gettime();
  turretstate = "\x17\xad\v\xde8";

  if(isDefined(self.shell_fx)) {
    thread turret_shell_fx();
  }

  for(;;) {
    duration = (pauseuntiltime - gettime()) * 0.001;

    if(self isfiringturret() && duration <= 0) {
      if(turretstate != "\xcciN\xca") {
        turretstate = "\xcciN\xca";
        thread doshoot(var_b64e5c54c0e0ed77);
      }

      duration = mg42_burst + randomfloat(var_2b1802e361955dcd);
      thread turrettimer(duration);
      self waittill("\xa7\xedfBu\xe0\xfd.\xfc7w\x16\xbeB\r\x8b\xa7");
      duration = mg42_delay + randomfloat(var_35eeeaea2c37f58);
      pauseuntiltime = gettime() + int(duration * 1000);
      continue;
    }

    if(turretstate != "\xb5\x10\xb9") {
      turretstate = "\xb5\x10\xb9";
    }

    thread turrettimer(duration);
    self waittill("\xa7\xedfBu\xe0\xfd.\xfc7w\x16\xbeB\r\x8b\xa7");
  }
}

function doshoot(var_9e1554f90c54597c) {
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("\xa7\xedfBu\xe0\xfd.\xfc7w\x16\xbeB\r\x8b\xa7");
  fire_rate = 0.1;

  if(isDefined(var_9e1554f90c54597c)) {
    fire_rate = var_9e1554f90c54597c;
  }

  for(;;) {
    self shootturret();
    wait fire_rate;
  }
}

function turret_shell_fx() {
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("\xe6UP\xe4\xccE\x91Cn\x99|@\x9e\xea7\xe3Xy\x1e\x9d\a\xb2\x9b\x92");

  if(isDefined(self.shell_sound)) {
    self.shell_sound_enabled = 1;
  }

  while(true) {
    self waittill("9\x1a\xe6\x9f\xd7b\x8f\xcc\x9e\xe4t");
    playFXOnTag(self.shell_fx, self, "\xec\xbfK|\au\xcd\xc2\x19<");

    if(isDefined(self.shell_sound_enabled) && self.shell_sound_enabled) {
      thread turret_shell_sound();
    }
  }
}

function turret_shell_sound() {
  self endon("\x1e\xfd\xd1\xa2\a");
  self.shell_sound_enabled = 0;
  tag_origin = self gettagorigin("\xec\xbfK|\au\xcd\xc2\x19<");
  origin = utility::drop_to_ground(tag_origin, -30);
  dist = tag_origin[2] - origin[2];
  time = dist / 300;
  wait time;
  playsoundatpos(origin, self.shell_sound);
  wait 1;
  self.shell_sound_enabled = 1;
}

function turrettimer(duration) {
  if(duration <= 0) {
    return;
  }

  self endon("\xa7\xedfBu\xe0\xfd.\xfc7w\x16\xbeB\r\x8b\xa7");
  wait duration;

  if(isDefined(self)) {
    self notify("\xa7\xedfBu\xe0\xfd.\xfc7w\x16\xbeB\r\x8b\xa7");
  }
}

function random_spread(ent) {
  self endon("\x1e\xfd\xd1\xa2\a");
  self notify("\xafY\x17W\xe7\t\xb2L\xe9\x8df\x13X\xd0K\x90nn");
  self endon("\xafY\x17W\xe7\t\xb2L\xe9\x8df\x13X\xd0K\x90nn");
  self endon("\xdc\x8e\xb7\x83\x99\xd2rZ7;");
  self settargetentity(ent);

  while(true) {
    if(isPlayer(ent)) {
      ent.origin = self.manual_target getorigin();
    } else {
      ent.origin = self.manual_target.origin;
    }

    ent.origin += (20 - randomfloat(40), 20 - randomfloat(40), 20 - randomfloat(60));
    wait 0.2;
  }
}

function mg42_firing(mg42) {
  self notify("?\x96\xd1\xf5\xe7\a1\x14\x99\xb8P\x9d\xfc@\xfa\xdb\xbe8\xb9\xaa]\x193:\x1b%\x83\x8b\xf5\x81");
  self endon("?\x96\xd1\xf5\xe7\a1\x14\x99\xb8P\x9d\xfc@\xfa\xdb\xbe8\xb9\xaa]\x193:\x1b%\x83\x8b\xf5\x81");
  mg42 stopfiring();

  while(true) {
    mg42 waittill("gQ\xe9\xa5D\xce\xe0 \xc6\xdd\xb5");
    thread burst_fire(mg42);
    mg42 startfiring();
    mg42 waittill("\xdc\x8e\xb7\x83\x99\xd2rZ7;");
    mg42 stopfiring();
  }
}

function burst_fire(mg42, manual_target) {
  mg42 endon("\xd3\xad\x11\xca%\xf7@\xabk_L\xff\x19");
  mg42 endon("\xdc\x8e\xb7\x83\x99\xd2rZ7;");
  self endon("?\x96\xd1\xf5\xe7\a1\x14\x99\xb8P\x9d\xfc@\xfa\xdb\xbe8\xb9\xaa]\x193:\x1b%\x83\x8b\xf5\x81");

  if(isDefined(mg42.script_delay_min)) {
    mg42_delay = mg42.script_delay_min;
  } else {
    mg42_delay = burst_fire_settings("C\xd3\x9by\xa3");
  }

  if(isDefined(mg42.script_delay_max)) {
    var_35eeeaea2c37f58 = mg42.script_delay_max - mg42_delay;
  } else {
    var_35eeeaea2c37f58 = burst_fire_settings("\xd5\xe5h\ak\xd9\xff\xd0B\x87;");
  }

  if(isDefined(mg42.script_burst_min)) {
    mg42_burst = mg42.script_burst_min;
  } else {
    mg42_burst = burst_fire_settings("V\x0e\xa9\xda\xc5");
  }

  if(isDefined(mg42.script_burst_max)) {
    var_2b1802e361955dcd = mg42.script_burst_max - mg42_burst;
  } else {
    var_2b1802e361955dcd = burst_fire_settings("&WNn\xa3\xbeNXn;e");
  }

  while(true) {
    mg42 startfiring();

    if(isDefined(manual_target)) {
      mg42 thread random_spread(manual_target);
    }

    wait mg42_burst + randomfloat(var_2b1802e361955dcd);
    mg42 stopfiring();
    wait mg42_delay + randomfloat(var_35eeeaea2c37f58);
  }
}

function _spawner_mg42_think() {
  if(!isDefined(self.flagged_for_use)) {
    self.flagged_for_use = 0;
  }

  if(!isDefined(self.targetname)) {
    return;
  }

  node = getnode(self.targetname, #target);

  if(!isDefined(node)) {
    return;
  }

  if(!isDefined(node.script_mg42)) {
    return;
  }

  if(!isDefined(node.mg42_enabled)) {
    node.mg42_enabled = 1;
  }

  self.script_mg42 = node.script_mg42;
  first_run = 1;

  while(true) {
    if(first_run) {
      first_run = 0;

      if(isDefined(node.targetname) || self.flagged_for_use) {
        self waittill("\xfac;V(5\xa4\xce\xdb\xf3\xf8\x16");
      }
    }

    if(!node.mg42_enabled) {
      node waittill("\x9e\x98\xa0>\xbd\x91\x9f\xa0\xf0>,");
      node.mg42_enabled = 1;
    }

    excluders = [];
    ai = getaiarray();

    for(i = 0; i < ai.size; i++) {
      excluded = 1;

      if(isDefined(ai[i].script_mg42) && ai[i].script_mg42 == self.script_mg42) {
        excluded = 0;
      }

      if(isDefined(ai[i].used_an_mg42)) {
        excluded = 1;
      }

      if(excluded) {
        excluders[excluders.size] = ai[i];
      }
    }

    if(excluders.size) {
      ai = utility_sp::get_closest_ai_exclude(node.origin, undefined, excluders);
    } else {
      ai = utility_sp::get_closest_ai(node.origin, undefined);
    }

    excluders = undefined;

    if(isDefined(ai)) {
      ai notify("\x83\xcb\xd4\xd6XoZ\xca)\xadaz\x95\x9e\xcf\xa6\xe2\xf1");
      ai thread spawner::go_to_node(node);
      ai waittill("\x1e\xfd\xd1\xa2\a");
      continue;
    }

    self waittill("\xfac;V(5\xa4\xce\xdb\xf3\xf8\x16");
  }
}

function mg42_think() {
  if(!isDefined(self.ai_mode)) {
    self.ai_mode = "\xc1w\x05\xf01z'f\xe6";
  }

  node = getnode(self.target, #targetname);

  if(!isDefined(node)) {
    println("<dev string:x54>", self.origin, "<dev string:x63>");
    return;
  }

  mg42 = getEnt(node.target, #targetname);
  mg42.org = node.origin;

  if(isDefined(mg42.target)) {
    if(!isDefined(level.mg42_trigger) || !isDefined(level.mg42_trigger[mg42.target])) {
      level.mg42_trigger[mg42.target] = 0;
      getEnt(mg42.target, #targetname) thread mg42_trigger();
    }

    trigger = 1;
  } else {
    trigger = 0;
  }

  while(true) {
    if(self.count == 0) {
      return;
    }

    mg42_gunner = undefined;

    while(!isDefined(mg42_gunner)) {
      mg42_gunner = utility_sp::spawn_ai();
      wait 1;
    }

    mg42_gunner thread mg42_gunner_think(mg42, trigger, self.ai_mode);
    mg42_gunner thread mg42_firing(mg42);
    mg42_gunner waittill("\x1e\xfd\xd1\xa2\a");

    if(isDefined(self.script_delay)) {
      wait self.script_delay;
      continue;
    }

    if(isDefined(self.script_delay_min) && isDefined(self.script_delay_max)) {
      wait self.script_delay_min + randomfloat(self.script_delay_max - self.script_delay_min);
      continue;
    }

    wait 1;
  }
}

function kill_objects(owner, msg, temp1, temp2) {
  owner waittill(msg);

  if(isDefined(temp1)) {
    temp1 delete();
  }

  if(isDefined(temp2)) {
    temp2 delete();
  }
}

function mg42_gunner_think(mg42, trigger, ai_mode) {
  self endon("\x1e\xfd\xd1\xa2\a");

  if(ai_mode == "\xc1w\x05\xf01z'f\xe6") {
    while(true) {
      thread mg42_gunner_manual_think(mg42, trigger);
      self waittill("m\xbbwc0\xe3\b");
      move_use_turret(mg42, "m\xbbwc0\xe3\b");
      self waittill("\xc1w\x05\xf01z'f\xe6");
    }

    return;
  }

  while(true) {
    move_use_turret(mg42, "m\xbbwc0\xe3\b", level.player);
    self waittill("\xc1w\x05\xf01z'f\xe6");
    thread mg42_gunner_manual_think(mg42, trigger);
    self waittill("m\xbbwc0\xe3\b");
  }
}

function player_safe() {
  if(!isDefined(level.player_covertrigger)) {
    return false;
  }

  if(level.player getstance() == "GX\xa9]\x82") {
    return true;
  }

  if(level.player_covertype == "\x9a0u" && level.player getstance() == "1x\xc5\xb4\xabx") {
    return true;
  }

  return false;
}

function stance_num() {
  if(level.player getstance() == "GX\xa9]\x82") {
    return (0, 0, 5);
  } else if(level.player getstance() == "1x\xc5\xb4\xabx") {
    return (0, 0, 25);
  }

  return (0, 0, 50);
}

function mg42_gunner_manual_think(mg42, trigger) {
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("m\xbbwc0\xe3\b");
  self.pacifist = 1;
  self setgoalpos(mg42.org);
  self.goalradius = level.magic_distance;
  self waittill("\x83\xd6\xaf\x11");

  if(trigger) {
    if(!level.mg42_trigger[mg42.target]) {
      level waittill(mg42.target);
    }
  }

  self.pacifist = 0;
  mg42 setmode("m\xbbwc0\xe3\b");
  mg42 cleartargetentity();
  targ_org = spawn("\xdcc9-p\xd1\xbe\xedr\xa5v-\xdc", (0, 0, 0));
  tempmodel = spawn("7l\x9ci\xc1\xa3}\xda\xf6\x19\xca6", (0, 0, 0));
  tempmodel.scale = 3;

  if(getDvar(@ "mg42") != "\xf8\x88m") {
    tempmodel setModel("\x1a1\xdb\xc8");
  }

  tempmodel thread temp_think(mg42, targ_org);
  level thread kill_objects(self, "\x1e\xfd\xd1\xa2\a", targ_org, tempmodel);
  level thread kill_objects(self, "m\xbbwc0\xe3\b", targ_org, tempmodel);
  mg42.player_target = 0;
  mg42timer = 0;
  targets = getEntArray("\xf3\xc3Z\x82\xbcW\xe5\x86\xf3^\xf2", #targetname);

  if(targets.size > 0) {
    script_targets = 1;
    current_org = targets[randomint(targets.size)].origin;
    thread shoot_mg42_script_targets(targets);
    move_use_turret(mg42);
    self.target_entity = targ_org;
    mg42 setmode("\xc1w\x05\xf01z'f\xe6");
    mg42 settargetentity(targ_org);
    mg42 notify("gQ\xe9\xa5D\xce\xe0 \xc6\xdd\xb5");
    mindist = 15;
    wait_time = 0.08;
    dif = 0.05;
    targ_org.origin = targets[randomint(targets.size)].origin;
    shoot_timer = 0;

    while(!isDefined(level.player_covertrigger)) {
      current_org = targ_org.origin;

      if(distance(current_org, targets[self.gun_targ].origin) > mindist) {
        temp_vec = vectorNormalize(targets[self.gun_targ].origin - current_org);
        temp_vec *= mindist;
        current_org += temp_vec;
      } else {
        self notify("\x9a\xe76\xeaJ)\x83w\xcb:\x82");
      }

      targ_org.origin = current_org;
      wait 0.1;
    }

    while(true) {
      i = 0;

      while(i < 1) {
        targ_org.origin = current_org * (1 - i) + (level.player getorigin() + stance_num()) * i;

        if(player_safe()) {
          i = 2;
        }

        wait wait_time;
        i += dif;
      }

      old_org = level.player getorigin();

      while(!player_safe()) {
        targ_org.origin = level.player getorigin();
        vec_dif = targ_org.origin - old_org;
        targ_org.origin = targ_org.origin + vec_dif + stance_num();
        old_org = level.player getorigin();
        wait 0.1;
      }

      if(player_safe()) {
        shoot_timer = gettime() + 1500 + randomfloat(4000);

        while(player_safe() && isDefined(level.player_covertrigger.target) && gettime() < shoot_timer) {
          target = getEntArray(level.player_covertrigger.target, #targetname);
          target = target[randomint(target.size)];
          targ_org.origin = target.origin + (randomfloat(30) - 15, randomfloat(30) - 15, randomfloat(40) - 60);
          wait 0.1;
        }
      }

      self notify("\x9a\xe76\xeaJ)\x83w\xcb:\x82");

      while(player_safe()) {
        current_org = targ_org.origin;

        if(distance(current_org, targets[self.gun_targ].origin) > mindist) {
          temp_vec = vectorNormalize(targets[self.gun_targ].origin - current_org);
          temp_vec *= mindist;
          current_org += temp_vec;
        } else {
          self notify("\x9a\xe76\xeaJ)\x83w\xcb:\x82");
        }

        targ_org.origin = current_org;
        wait 0.1;
      }
    }

    return;
  }

  while(true) {
    move_use_turret(mg42);

    while(!isDefined(level.player_covertrigger)) {
      if(!mg42.player_target) {
        mg42 settargetentity(level.player);
        mg42.player_target = 1;
        tempmodel.targent = level.player;
      }

      wait 0.2;
    }

    mg42 setmode("\xc1w\x05\xf01z'f\xe6");
    move_use_turret(mg42);
    mg42 notify("gQ\xe9\xa5D\xce\xe0 \xc6\xdd\xb5");
    shoot_timer = gettime() + 1500 + randomfloat(4000);

    while(shoot_timer > gettime()) {
      if(isDefined(level.player_covertrigger)) {
        target = getEntArray(level.player_covertrigger.target, #targetname);
        target = target[randomint(target.size)];
        targ_org.origin = target.origin + (randomfloat(30) - 15, randomfloat(30) - 15, randomfloat(40) - 60);
        mg42 settargetentity(targ_org);
        tempmodel.targent = targ_org;
        wait randomfloat(1);
        continue;
      }

      break;
    }

    mg42 notify("\xdc\x8e\xb7\x83\x99\xd2rZ7;");
    move_use_turret(mg42);

    if(mg42.player_target) {
      mg42 setmode("m\xbbwc0\xe3\b");
      mg42 cleartargetentity();
      mg42.player_target = 0;
      tempmodel.targent = tempmodel;
      tempmodel.origin = (0, 0, 0);
    }

    while(isDefined(level.player_covertrigger)) {
      wait 0.2;
    }

    wait 0.75 + randomfloat(0.2);
  }
}

function shoot_mg42_script_targets(targets) {
  self endon("\x1e\xfd\xd1\xa2\a");

  while(true) {
    targ_filled = [];

    for(i = 0; i < targets.size; i++) {
      targ_filled[i] = 0;
    }

    for(i = 0; i < targets.size; i++) {
      self.gun_targ = randomint(targets.size);
      self waittill("\x9a\xe76\xeaJ)\x83w\xcb:\x82");

      while(targ_filled[self.gun_targ]) {
        self.gun_targ++;

        if(self.gun_targ >= targets.size) {
          self.gun_targ = 0;
        }
      }

      targ_filled[self.gun_targ] = 1;
    }
  }
}

function move_use_turret(mg42, aitype, target) {
  self setgoalpos(mg42.org);
  self.goalradius = level.magic_distance;
  self waittill("\x83\xd6\xaf\x11");

  if(isDefined(aitype) && aitype == "m\xbbwc0\xe3\b") {
    mg42 setmode("m\xbbwc0\xe3\b");

    if(isDefined(target)) {
      mg42 settargetentity(target);
    } else {
      mg42 cleartargetentity();
    }
  }

  self useturret(mg42);
}

function temp_think(mg42, targ) {
  if(getDvar(@ "mg42") == "\xf8\x88m") {
    return;
  }

  self.targent = self;

  while(true) {
    self.origin = targ.origin;

    line(self.origin, mg42.origin, (0.2, 0.5, 0.8), 0.5);

    wait 0.1;
  }
}

function turret_think(node) {
  turret = getEnt(node.auto_mg42_target, #targetname);
  mintime = 0.5;

  if(isDefined(turret.script_turret_reuse_min)) {
    mintime = turret.script_turret_reuse_min;
  }

  maxtime = 2;

  if(isDefined(turret.script_turret_reuse_max)) {
    mintime = turret.script_turret_reuse_max;
  }

  assert(maxtime >= mintime);

  for(;;) {
    turret waittill("\xa3\xba\xe4\x93V\xa3\xeb\xc8\xca\v6tK\xec\x16\xd1+");
    wait mintime + randomfloat(maxtime - mintime);

    while(!isturretactive(turret)) {
      turret_find_user(node, turret);
      wait 1;
    }
  }
}

function turret_find_user(node, turret) {
  ai = getaiarray();

  for(i = 0; i < ai.size; i++) {
    if(ai[i] isingoal(node.origin) && ai[i] canuseturret(turret)) {
      var_4552f8cd00750d0b = ai[i].keepclaimednodeifvalid;
      ai[i].keepclaimednodeifvalid = 0;

      if(!ai[i] usecovernode(node)) {
        ai[i].keepclaimednodeifvalid = var_4552f8cd00750d0b;
      }
    }
  }
}

function setdifficulty() {
  init_mgturretsettings();
  mg42s = getEntArray("?\x96%o2\x88V\xd4\x98\a\xdc", #code_classname);
  difficulty = utility::getdifficulty();

  for(index = 0; index < mg42s.size; index++) {
    if(isDefined(mg42s[index].script_skilloverride)) {
      switch (mg42s[index].script_skilloverride) {
        case #"hash_22ce4003c1e5227b":
          difficulty = "2\x9fR\xb1";
          break;
        case #"hash_c71b112fe04823d6":
          difficulty = "w=&\x15\xbd\xae";
          break;
        case #"hash_cc9157548a55043c":
          difficulty = "\xec\xacV\a";
          break;
        case #"hash_fa14cdf6bd53b8e4":
          difficulty = "\xf0\x93";
          break;
        default:
          continue;
      }
    }

    mg42_setdifficulty(mg42s[index], difficulty);
  }
}

function mg42_setdifficulty(mg42, difficulty) {
  mg42.convergencetime = level.mgturretsettings[difficulty]["C,%\xa4J\x01\x85,\x1f\xb2T\xec\xc3\xed\x8b"];
  mg42.suppressiontime = level.mgturretsettings[difficulty]["-c\xb7\x8d\x9fC\xf1\xd4\xf53\xeb\x1d\f%\x82"];
  mg42.accuracy = level.mgturretsettings[difficulty]["v!\xffzTWM{"];
  mg42.aispread = level.mgturretsettings[difficulty][",\x96\xd4\xe09\xb2\xb02"];
  mg42.playerspread = level.mgturretsettings[difficulty]["\x8a8\xcc\xba\x1f\xd3\xa6u\xb5\xac\x01\xdf"];
}

function mg42_target_drones(nonai, team, dotrange) {
  if(!isDefined(dotrange)) {
    dotrange = 0.88;
  }

  self endon("\x1e\xfd\xd1\xa2\a");
  self notify("\xfa\xcbpq\xaf\xd1\x8co\xb8\xe8\xf8b\xb1\x90\xf1\xbc\xddL\xedD\xae\x80\xf7");
  self endon("\xfa\xcbpq\xaf\xd1\x8co\xb8\xe8\xf8b\xb1\x90\xf1\xbc\xddL\xedD\xae\x80\xf7");
  self.dronefailed = 0;

  if(!isDefined(self.script_fireondrones)) {
    self.script_fireondrones = 0;
  }

  if(!isDefined(nonai)) {
    nonai = 0;
  }

  self setmode("\xc1w\x05\xf01z'f\xe6");
  difficulty = utility::getdifficulty();

  if(!isDefined(level.drones)) {
    var_999bd953d74cb3da = 1;
  } else {}

  for(var_999bd953d74cb3da = 0; true; var_999bd953d74cb3da = 1) {
    if(var_999bd953d74cb3da) {
      if(isDefined(self.drones_targets_sets_to_default)) {
        self setmode(self.defaultonmode);
      } else if(nonai) {
        self setmode("\xb6\xae1\x04\xa1c{\xbb\xab\x90");
      } else {
        self setmode("m\xbbwc0\xe3\b");
      }

      level waittill("\x97sY\x9dp\x85\x7f\xbc\xba");
    }

    if(!isDefined(self.oldconvergencetime)) {
      self.oldconvergencetime = self.convergencetime;
    }

    self.convergencetime = 2;

    if(!nonai) {
      turretowner = self getturretowner();

      if(!isalive(turretowner) || isPlayer(turretowner)) {
        wait 0.05;
        continue;
      } else {
        team = turretowner.team;
      }
    } else {
      assert(isDefined(team));
      turretowner = undefined;
    }

    if(team == "O\x15\x1b\xad\x9ff") {
      targetteam = "?\xb1\xc0\x9a";
    } else {
      targetteam = "O\x15\x1b\xad\x9ff";
    }

    while(level.drones[targetteam].lastindex) {
      utility::lock("\xda\xec\r\x91\xd7#\xe4o\xb9Vn");

      if(!level.drones[targetteam].lastindex) {
        utility::unlock("\xda\xec\r\x91\xd7#\xe4o\xb9Vn");
        break;
      }

      target = get_bestdrone(targetteam, dotrange);
      utility::unlock("\xda\xec\r\x91\xd7#\xe4o\xb9Vn");

      if(!isDefined(self.script_fireondrones) || !self.script_fireondrones) {
        wait 0.05;
        break;
      }

      if(!isDefined(target)) {
        wait 0.05;
        break;
      }

      if(isDefined(self.anim_wait_func)) {
        [[self.anim_wait_func]]();
      }

      if(nonai) {
        self setmode("\x80Gk\xed2\x17");
      } else {
        self setmode("\xc1w\x05\xf01z'f\xe6");
      }

      self settargetentity(target, (0, 0, 32));
      drone_target(target, 1, dotrange);
      self cleartargetentity();
      self stopfiring();

      if(!nonai && !(isDefined(self getturretowner()) && self getturretowner() == turretowner)) {
        break;
      }
    }

    self.convergencetime = self.oldconvergencetime;
    self.oldconvergencetime = undefined;
    self cleartargetentity();
    self stopfiring();

    if(level.drones[targetteam].lastindex) {
      var_999bd953d74cb3da = 0;
      continue;
    }
  }
}

function drone_target(drone, time, dotrange) {
  self endon("\x1e\xfd\xd1\xa2\a");
  drone endon("\x1e\xfd\xd1\xa2\a");
  timer = gettime() + time * 1000;
  startedfiring = 0;

  while(timer > gettime() || startedfiring) {
    utility::lock("B\xfeq\x84a\x12m\x03\x1f\xad?\x8f\xec\x7fR\xf4?\x06\xf9<\xe2c:I");
    turrettarget = self getturrettarget(1);

    if(!trace::_bullet_trace_passed(self gettagorigin("\xfd\xef\xc3\r\xb4\xad\x84p\x84"), drone.origin + (0, 0, 40), 0, drone)) {
      utility::unlock("B\xfeq\x84a\x12m\x03\x1f\xad?\x8f\xec\x7fR\xf4?\x06\xf9<\xe2c:I");
      break;
    } else if(isDefined(turrettarget) && distance(turrettarget.origin, self.origin) < distance(self.origin, drone.origin)) {
      utility::unlock("B\xfeq\x84a\x12m\x03\x1f\xad?\x8f\xec\x7fR\xf4?\x06\xf9<\xe2c:I");
      break;
    }

    if(!startedfiring) {
      self startfiring();
      startedfiring = 1;
    }

    utility::unlock_wait("B\xfeq\x84a\x12m\x03\x1f\xad?\x8f\xec\x7fR\xf4?\x06\xf9<\xe2c:I");
  }

  self stopfiring();
  utility_sp::structarray_shuffle(level.drones[drone.team], 1);
}

function get_bestdrone(team, dotrange) {
  if(level.drones[team].lastindex < 1) {
    return;
  }

  ent = undefined;
  dotforward = anglesToForward(self.angles);

  for(i = 0; i < level.drones[team].lastindex; i++) {
    if(!isDefined(level.drones[team].array[i])) {
      continue;
    }

    angles = vectortoangles(level.drones[team].array[i].origin - self.origin);
    forward = anglesToForward(angles);

    if(vectordot(dotforward, forward) < dotrange) {
      continue;
    }

    ent = level.drones[team].array[i];

    if(!trace::_bullet_trace_passed(self gettagorigin("\xfd\xef\xc3\r\xb4\xad\x84p\x84"), ent getcentroid(), 0, ent)) {
      ent = undefined;
      continue;
    }

    break;
  }

  aitarget = self getturrettarget(1);

  if(!isDefined(self.prefers_drones)) {
    if(isDefined(ent) && isDefined(aitarget) && distancesquared(self.origin, aitarget.origin) < distancesquared(self.origin, ent.origin)) {
      ent = undefined;
    }
  }

  return ent;
}

function saw_mgturretlink() {
  possible_turrets = getEntArray("?\x96%o2\x88V\xd4\x98\a\xdc", #code_classname);
  turrets = [];

  foreach(possible_turret in possible_turrets) {
    if(isDefined(possible_turret.targetname)) {
      continue;
    }

    if(isDefined(possible_turret.script_turret_autonomous) && possible_turret.script_turret_autonomous) {
      continue;
    }

    if(isDefined(possible_turret.isvehicleattached)) {
      assert(possible_turret.isvehicleattached != 0, "<dev string:x73>");
      continue;
    }

    turrets[turrets.size] = possible_turret;
  }

  if(!turrets.size) {
    return;
  }

  unclaimed = turrets;

  foreach(turret in turrets) {
    foreach(node in getnodesinradius(turret.origin, 50, 0)) {
      if(node.type == "L\xc7\xb3\x91") {
        continue;
      }

      if(node.type == "\x90\xcav-7") {
        continue;
      }

      if(node.type == "9\xdb\x90") {
        continue;
      }

      nodeforward = anglesToForward((0, node.angles[1], 0));
      turretforward = anglesToForward((0, turret.angles[1], 0));
      dot = vectordot(nodeforward, turretforward);

      if(dot < 0.9) {
        continue;
      }

      unclaimed = arrayremove(unclaimed, turret);
      node.turretinfo = spawn("\xdcc9-p\xd1\xbe\xedr\xa5v-\xdc", turret.origin);
      node.turretinfo.angles = turret.angles;
      node.turretinfo.node = node;
      node.turretinfo.leftarc = 45;
      node.turretinfo.rightarc = 45;
      node.turretinfo.toparc = 15;
      node.turretinfo.bottomarc = 15;

      if(isDefined(turret.leftarc)) {
        node.turretinfo.leftarc = min(turret.leftarc, 45);
      }

      if(isDefined(turret.rightarc)) {
        node.turretinfo.rightarc = min(turret.rightarc, 45);
      }

      if(isDefined(turret.toparc)) {
        node.turretinfo.toparc = min(turret.toparc, 15);
      }

      if(isDefined(turret.bottomarc)) {
        node.turretinfo.bottomarc = min(turret.bottomarc, 15);
      }

      turret delete();
    }
  }

  foreach(turret in unclaimed) {
    assertmsg("<dev string:x9f>" + turret.origin + "<dev string:xb4>");
  }
}

function auto_mgturretlink() {
  possible_turrets = getEntArray("?\x96%o2\x88V\xd4\x98\a\xdc", #code_classname);
  turrets = [];

  foreach(possible_turret in possible_turrets) {
    if(!isDefined(possible_turret.targetname) || tolower(possible_turret.targetname) != ",\x8c\x01\xf4\xb8\xd0\xeb\xea\x06\x16\xe6\xc5i") {
      continue;
    }

    if(!isDefined(possible_turret.export)) {
      continue;
    }

    if(!isDefined(possible_turret.script_dont_link_turret)) {
      turrets[turrets.size] = possible_turret;
    }
  }

  if(!turrets.size) {
    return;
  }

  unclaimed = turrets;

  foreach(turret in turrets) {
    foreach(node in getnodesinradius(turret.origin, 70)) {
      if(node.type == "L\xc7\xb3\x91") {
        continue;
      }

      if(node.type == "\x90\xcav-7") {
        continue;
      }

      if(node.type == "9\xdb\x90") {
        continue;
      }

      nodeforward = anglesToForward((0, node.angles[1], 0));
      turretforward = anglesToForward((0, turret.angles[1], 0));
      dot = vectordot(nodeforward, turretforward);

      if(dot < 0.9) {
        continue;
      }

      unclaimed = arrayremove(unclaimed, turret);
      node.turret = turret;
      turret.node = node;
      turret.issetup = 1;
      assert(isDefined(turret.export), "<dev string:xd4>" + turret.origin + "<dev string:xe2>");
    }
  }

  if(unclaimed.size) {
    println("<dev string:x15d>");
    println("<dev string:x1ab>");

    foreach(u in unclaimed) {
      println(u.origin);
    }

    assert(0, "<dev string:x1fd>");
  }
}

function save_turret_sharing_info() {
  self.shared_turrets = [];
  self.shared_turrets["Z\xc4\x9eQ\xd37_m%"] = [];
  self.shared_turrets["<|\xd8\x8dF\x85"] = [];

  if(!isDefined(self.export)) {
    assert(!isDefined(self.script_turret_share), "<dev string:xd4>" + self.origin + "<dev string:x23d>");
    assert(!isDefined(self.script_turret_ambush), "<dev string:xd4>" + self.origin + "<dev string:x2a1>");
    return;
  }

  if(!isDefined(level.shared_portable_turrets)) {
    level.shared_portable_turrets = [];
  }

  level.shared_portable_turrets[self.export] = self;

  if(isDefined(self.script_turret_share)) {
    strings = strtok(self.script_turret_share, "\xda");

    for(i = 0; i < strings.size; i++) {
      self.shared_turrets["Z\xc4\x9eQ\xd37_m%"][strings[i]] = 1;
    }
  }

  if(isDefined(self.script_turret_ambush)) {
    strings = strtok(self.script_turret_ambush, "\xda");

    for(i = 0; i < strings.size; i++) {
      self.shared_turrets["<|\xd8\x8dF\x85"][strings[i]] = 1;
    }
  }
}

function restoredefaultpitch() {
  self notify("g\xd5\xcd\xeb\x1c\xd8a6YF\xaf\v\xce\x16-\xb9");
  self endon("g\xd5\xcd\xeb\x1c\xd8a6YF\xaf\v\xce\x16-\xb9");
  self waittill("\x9a\xd6\xf8\xdf\x18'\x0f\xae\xc9O\xb7\x1b\xdf:s>[\xb4\x9a\x7f\xdcy\x8e\xcb\xa9\xee");
  wait 1;
  self restoredefaultdroppitch();
}

function dropturret() {
  thread dropturretproc();
}

function dropturretproc() {
  turret = spawn("7l\x9ci\xc1\xa3}\xda\xf6\x19\xca6", (0, 0, 0));
  turret.origin = self gettagorigin(level.portable_mg_gun_tag);
  turret.angles = self gettagangles(level.portable_mg_gun_tag);
  turret setModel(self.turretmodel);
  forward = anglesToForward(self.angles);
  forward *= 100;
  turret movegravity(forward, 0.5);
  self detach(self.turretmodel, level.portable_mg_gun_tag);
  self.turretmodel = undefined;
  wait 0.7;
  turret delete();
}

function turretdeathdetacher() {
  self endon("\x12K\xab$>aV\xed[\xb3z\xe6\x1d\xbf\xe6!$\x17C,$om\xed\x8b");
  self endon("X\xc1\xf5\x86\x87S\xf5\x02\\A\xe8");
  self waittill("\x1e\xfd\xd1\xa2\a");

  if(!isDefined(self)) {
    return;
  }

  dropturret();
}

function turretdetacher() {
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("\x12K\xab$>aV\xed[\xb3z\xe6\x1d\xbf\xe6!$\x17C,$om\xed\x8b");
  self waittill("X\xc1\xf5\x86\x87S\xf5\x02\\A\xe8");
  self detach(self.turretmodel, level.portable_mg_gun_tag);
}

function restoredefaults() {
  self.run_overrideanim = undefined;
}

function restorepitch() {
  self waittill("\xa3\xba\xe4\x93V\xa3\xeb\xc8\xca\v6tK\xec\x16\xd1+");
  self restoredefaultdroppitch();
}

function update_enemy_target_pos_while_running(ent) {
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("U\x9cXW\t\xd5\x1a\t\t\x16\xb8\xb6\xbex\x91");
  self endon("}a\x9f\xc2d\bn\x8b\xaew\x11\xaa\x84\x8fM/\xa4I\xf6\xed\xf6\xf8\x13\x8f\x181\x1f\x97\xff\\");

  for(;;) {
    self waittill("\xb1\xa4\xe6\xfd\x1e\xaf\xd3O{");
    ent.origin = self.last_enemy_sighting_position;
  }
}

function move_target_pos_to_new_turrets_visibility(ent, new_spot) {
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("U\x9cXW\t\xd5\x1a\t\t\x16\xb8\xb6\xbex\x91");
  self endon("}a\x9f\xc2d\bn\x8b\xaew\x11\xaa\x84\x8fM/\xa4I\xf6\xed\xf6\xf8\x13\x8f\x181\x1f\x97\xff\\");
  var_8672815f5a699291 = self.turret.origin + (0, 0, 16);
  dest_pos = new_spot.origin + (0, 0, 16);

  for(;;) {
    wait 0.05;

    if(sighttracepassed(ent.origin, dest_pos, 0, undefined)) {
      continue;
    }

    angles = vectortoangles(var_8672815f5a699291 - ent.origin);
    forward = anglesToForward(angles);
    forward *= 8;
    ent.origin += forward;
  }
}

function record_bread_crumbs_for_ambush(ent) {
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("U\x9cXW\t\xd5\x1a\t\t\x16\xb8\xb6\xbex\x91");
  self endon("}a\x9f\xc2d\bn\x8b\xaew\x11\xaa\x84\x8fM/\xa4I\xf6\xed\xf6\xf8\x13\x8f\x181\x1f\x97\xff\\");
  ent.bread_crumbs = [];

  for(;;) {
    ent.bread_crumbs[ent.bread_crumbs.size] = self.origin + (0, 0, 50);
    wait 0.35;
  }
}

function aim_turret_at_ambush_point_or_visible_enemy(turret, ent) {
  if(!isalive(self.current_enemy) && self cansee(self.current_enemy)) {
    ent.origin = self.last_enemy_sighting_position;
    return;
  }

  forward = anglesToForward(turret.angles);

  for(i = ent.bread_crumbs.size - 3; i >= 0; i--) {
    crumb = ent.bread_crumbs[i];
    normal = vectorNormalize(crumb - turret.origin);
    dot = vectordot(forward, normal);

    if(dot < 0.75) {
      continue;
    }

    ent.origin = crumb;

    if(sighttracepassed(turret.origin, crumb, 0, undefined)) {
      continue;
    }

    break;
  }
}

function find_a_new_turret_spot(ent) {
  array = get_portable_mg_spot(ent);
  new_spot = array["\x11\xb6P\x81"];
  connection_type = array["FD\xa8\xa6"];

  if(!isDefined(new_spot)) {
    return;
  }

  reserve_turret(new_spot);
  thread update_enemy_target_pos_while_running(ent);
  thread move_target_pos_to_new_turrets_visibility(ent, new_spot);

  if(connection_type == "<|\xd8\x8dF\x85") {
    thread record_bread_crumbs_for_ambush(ent);
  }

  if(new_spot.issetup) {
    leave_gun_and_run_to_new_spot(new_spot);
  } else {
    pickup_gun(new_spot);
    run_to_new_spot_and_setup_gun(new_spot);
  }

  self notify("}a\x9f\xc2d\bn\x8b\xaew\x11\xaa\x84\x8fM/\xa4I\xf6\xed\xf6\xf8\x13\x8f\x181\x1f\x97\xff\\");

  if(connection_type == "<|\xd8\x8dF\x85") {
    aim_turret_at_ambush_point_or_visible_enemy(new_spot, ent);
  }

  new_spot settargetentity(ent);
}

function snap_lock_turret_onto_target(turret) {
  turret setmode("\x80Gk\xed2\x17");
  wait 0.5;
  turret setmode("\xc1w\x05\xf01z'f\xe6");
}

function leave_gun_and_run_to_new_spot(spot) {
  assert(spot.reserved == self);
  self stopuseturret();
  shared::placeweaponon(self.primaryweapon, "\r+x5");
  setup_anim = get_turret_setup_anim(spot);
  org = getstartorigin(spot.origin, spot.angles, setup_anim);
  assertmsg("<dev string:x307>");
  assert(distance(org, self.goalpos) < self.goalradius, "<dev string:x375>");
  self waittill("\xe8Y\xa3WN\xb4J\xd5\xec\x1f\xdaK\x9d");
  use_the_turret(spot);
}

function pickup_gun(spot) {
  self stopuseturret();
  self.turret hide_turret();
}

function get_turret_setup_anim(turret) {
  spot_types = [];
  spot_types["\x10\x14KrG\xc1\xc6`\x16~\x83\xb5F\xd5\xea"] = level.mg_animmg["\xedO\xdb\an\xdbG\\(D\xbfD;\xccF|{"];
  spot_types["\xcc\x1a\xae\xb3f\xdc\x85q\x89?/\xf4\xd3=Wj"] = level.mg_animmg["\x9a\xbe\x8d\xccu@\xb3\xa1\x88.\xa7s\xde\x0f\xb9q}\xc1"];
  spot_types["\x9e\xbc\xf9\x04Kf\x04\xc1,\x8e\xc2n\xd3\x88\xf5"] = level.mg_animmg["\xd6\xf2\x1f\xd5\x82\n|t\xb7\xa4\x85@\xc6\x1eH\xc2P"];
  return spot_types[turret.weaponinfo];
}

function run_to_new_spot_and_setup_gun(spot) {
  assert(spot.reserved == self);
  oldhealth = self.health;
  spot endon("\xa3\xba\xe4\x93V\xa3\xeb\xc8\xca\v6tK\xec\x16\xd1+");
  self.mg42 = spot;
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("X\xc1\xf5\x86\x87S\xf5\x02\\A\xe8");
  setup_anim = get_turret_setup_anim(spot);
  self.turretmodel = "\xc0v\xf1w-<\x9b\xf7\xff\x93\xd1\xc2\xd3\xfd'\xe5\xd6";
  self notify("\x7f\x02\x94t\xdc\x93\x0f\xe3\x91\x8e4\xcf\at\x8a\xf8|a\xc4\x94\xdc\xd1\xafb\xa2O\x02\xafd\x05\xa2\xe8]\x8b\x15Fnb\xfe\xf2r\x7f");
  shared::placeweaponon(self.weapon, "\r+x5");

  if(self isbadguy()) {
    self.health = 1;
  }

  self attach(self.turretmodel, level.portable_mg_gun_tag);
  thread turretdeathdetacher();
  org = getstartorigin(spot.origin, spot.angles, setup_anim);
  assertmsg("<dev string:x307>");
  assert(distance(org, self.goalpos) < self.goalradius, "<dev string:x375>");
  wait 0.05;
  utility::clear_exception("\x80[\xb3\x9d");
  utility_sp::set_exception("\x01f\xf6\xa5\xff\xb80W\x86\xe9\xb7\xe5", &hold_indefintely);
  assertmsg("<dev string:x307>");

  while(distance(self.origin, org) > 16) {
    wait 0.05;
  }

  self notify("\x12K\xab$>aV\xed[\xb3z\xe6\x1d\xbf\xe6!$\x17C,$om\xed\x8b");

  if(self isbadguy()) {
    self.health = oldhealth;
  }

  if(soundexists("\x9f\xb7\xef\xc2v\xc1aQ\xf6\xad\x83A")) {
    playsoundatpos(self.origin, "\x9f\xb7\xef\xc2v\xc1aQ\xf6\xad\x83A");
  }

  self animScripted("&Kh\x9a\x7f#\xc0\x17\xa3\x06", spot.origin, spot.angles, setup_anim);
  restoredefaults();
  self waittillmatch("&Kh\x9a\x7f#\xc0\x17\xa3\x06", "8\xdb\x90");
  spot notify("\x9a\xd6\xf8\xdf\x18'\x0f\xae\xc9O\xb7\x1b\xdf:s>[\xb4\x9a\x7f\xdcy\x8e\xcb\xa9\xee");
  spot show_turret();
  shared::placeweaponon(self.primaryweapon, "o0\xee\xc1\x8c");
  use_the_turret(spot);
  self detach(self.turretmodel, level.portable_mg_gun_tag);
  self notify("b\xc6\xdc_\x1c\xf69\x1dab\xd8V\xaf\xa3\xba\x9c\x93\x95\x1d\xfa7\xca\xa3\xea\xe0");
}

function hold_indefintely() {
  self endon("\xbb\x91a^\xe9\x1dr\x1e\x1cks\xf5y@");
  self waittill("\x1e\xfd\xd1\xa2\a");
}

function using_a_turret() {
  if(!isDefined(self.turret)) {
    return false;
  }

  return self.turret.owner == self;
}

function turret_user_moves() {
  if(!using_a_turret()) {
    utility::clear_exception("\x80[\xb3\x9d");
    return;
  }

  array = find_connected_turrets("Z\xc4\x9eQ\xd37_m%");
  new_spots = array["\x1fpx\xf7\xf9"];

  if(!new_spots.size) {
    utility::clear_exception("\x80[\xb3\x9d");
    return;
  }

  turret_node = self.node;

  if(!isDefined(turret_node) || !arraycontains(new_spots, turret_node)) {
    taken_nodes = gettakennodes();

    for(i = 0; i < new_spots.size; i++) {
      turret_node = utility::random(new_spots);

      if(isDefined(taken_nodes[turret_node.origin + ""])) {
        return;
      }
    }
  }

  turret = turret_node.turret;

  if(isDefined(turret.reserved)) {
    assert(turret.reserved != self);
    return;
  }

  reserve_turret(turret);

  if(turret.issetup) {
    leave_gun_and_run_to_new_spot(turret);
  } else {
    run_to_new_spot_and_setup_gun(turret);
  }

  mg_penetration::gunner_think(turret_node.turret);
}

function use_the_turret(spot) {
  turretwasused = self useturret(spot);

  if(turretwasused) {
    utility_sp::set_exception("\x80[\xb3\x9d", &turret_user_moves);
    self.turret = spot;
    thread mg42_firing(spot);
    spot setmode("\xc1w\x05\xf01z'f\xe6");
    spot thread restorepitch();
    self.turret = spot;
    spot.owner = self;
    return 1;
  }

  spot restoredefaultdroppitch();
  return 0;
}

function get_portable_mg_spot(ent) {
  var_e771b62caf645292 = [];
  var_e771b62caf645292[var_e771b62caf645292.size] = &find_different_way_to_attack_last_seen_position;
  var_e771b62caf645292[var_e771b62caf645292.size] = &find_good_ambush_spot;
  var_e771b62caf645292 = utility::array_randomize(var_e771b62caf645292);

  for(i = 0; i < var_e771b62caf645292.size; i++) {
    array = [[var_e771b62caf645292[i]]](ent);

    if(!isDefined(array["\x1fpx\xf7\xf9"])) {
      continue;
    }

    array["\x11\xb6P\x81"] = utility::random(array["\x1fpx\xf7\xf9"]);
    return array;
  }
}

function gettakennodes() {
  array = [];
  ai = getaiarray();

  for(i = 0; i < ai.size; i++) {
    if(!isDefined(ai[i].node)) {
      continue;
    }

    array[ai[i].node.origin + ""] = 1;
  }

  return array;
}

function find_connected_turrets(connection_type) {
  spots = level.shared_portable_turrets;
  usable_spots = [];
  spot_exports = getarraykeys(spots);
  taken_nodes = gettakennodes();
  taken_nodes[self.node.origin + ""] = undefined;

  for(i = 0; i < spot_exports.size; i++) {
    export = spot_exports[i];

    if(spots[export] == self.turret) {
      continue;
    }

    keys = getarraykeys(self.turret.shared_turrets[connection_type]);

    for(p = 0; p < keys.size; p++) {
      if(spots[export].export+"" != keys[p]) {
        continue;
      }

      if(isDefined(spots[export].reserved)) {
        continue;
      }

      if(isDefined(taken_nodes[spots[export].node.origin + ""])) {
        continue;
      }

      if(distance(self.goalpos, spots[export].origin) > self.goalradius) {
        continue;
      }

      usable_spots[usable_spots.size] = spots[export];
    }
  }

  array = [];
  array["FD\xa8\xa6"] = connection_type;
  array["\x1fpx\xf7\xf9"] = usable_spots;
  return array;
}

function find_good_ambush_spot(ent) {
  return find_connected_turrets("<|\xd8\x8dF\x85");
}

function find_different_way_to_attack_last_seen_position(ent) {
  array = find_connected_turrets("Z\xc4\x9eQ\xd37_m%");
  usable_spots = array["\x1fpx\xf7\xf9"];

  if(!usable_spots.size) {
    return;
  }

  good_spot = [];

  for(i = 0; i < usable_spots.size; i++) {
    if(!utility::within_fov(usable_spots[i].origin, usable_spots[i].angles, ent.origin, 0.75)) {
      continue;
    }

    if(!sighttracepassed(ent.origin, usable_spots[i].origin + (0, 0, 16), 0, undefined)) {
      continue;
    }

    good_spot[good_spot.size] = usable_spots[i];
  }

  array["\x1fpx\xf7\xf9"] = good_spot;
  return array;
}

function portable_mg_spot() {
  save_turret_sharing_info();
  var_c2ac23986656e909 = 1;
  self.issetup = 1;
  assert(!isDefined(self.reserved));
  self.reserved = undefined;

  if(isDefined(self.isvehicleattached)) {
    return;
  }

  if(self.spawnflags &var_c2ac23986656e909) {
    return;
  }

  hide_turret();
}

function hide_turret() {
  assert(self.issetup);
  self notify("l|T\xd3\x8f\xfdz\xaa\xf1 ;\x8c$iuX\xb9\xd3E\xce2\xeb\xbd\x0e\x14\xef");
  self.issetup = 0;
  self hide();
  self.solid = 0;
  self makeunusable();
  self setdefaultdroppitch(0);
  thread restoredefaultpitch();
}

function show_turret() {
  self show();
  self.solid = 1;
  self makeusable();
  assert(!self.issetup);
  self.issetup = 1;
  thread stop_mg_behavior_if_flanked();
}

function stop_mg_behavior_if_flanked() {
  self endon("l|T\xd3\x8f\xfdz\xaa\xf1 ;\x8c$iuX\xb9\xd3E\xce2\xeb\xbd\x0e\x14\xef");
  self waittill("\xa3\xba\xe4\x93V\xa3\xeb\xc8\xca\v6tK\xec\x16\xd1+");

  if(isalive(self.owner)) {
    self.owner notify("U\x9cXW\t\xd5\x1a\t\t\x16\xb8\xb6\xbex\x91");
  }
}

function turret_is_mine(turret) {
  owner = turret getturretowner();

  if(!isDefined(owner)) {
    return false;
  }

  return owner == self;
}

function end_turret_reservation(turret) {
  waittill_turret_is_released(turret);
  turret.reserved = undefined;
}

function waittill_turret_is_released(turret) {
  turret endon("\xa3\xba\xe4\x93V\xa3\xeb\xc8\xca\v6tK\xec\x16\xd1+");
  self endon("\x1e\xfd\xd1\xa2\a");
  self waittill("U\x9cXW\t\xd5\x1a\t\t\x16\xb8\xb6\xbex\x91");
}

function reserve_turret(turret) {
  turret.reserved = self;
  thread end_turret_reservation(turret);
}

function zuluinit() {
  thread turret_watchplayeruse(turret_getplayerusefuncs());
  thread turret_impactquakes();
}

function turret_impactquakes() {
  self endon("\x1e\xfd\xd1\xa2\a");

  while(true) {
    self waittill("?\x80\x96\x17\xba\xc2\x16\xe1\x93u\xc1{", missile);
    missile thread missile_explode_quakes();
  }
}

function missile_explode_quakes() {
  self waittill("*\x83\xc10XI\x1e", position);
  earthquake(0.18, 0.75, position, 500);
  playrumbleonposition("\xdc\x15?\xcf\x9ch\xba\x91\xbd\xaa6\xf3\xbe\"|\x9a{*o:\xb3u", position);
}

function turret_getplayerusefuncs() {
  usefuncs = spawnStruct();
  usefuncs.startfuncs = [ &turretplayerstartfunc];
  usefuncs.stopfuncs = [ &turretplayerstopfunc];
  return usefuncs;
}

function turret_watchplayeruse(usefuncs) {
  self endon("\x1e\xfd\xd1\xa2\a");

  while(true) {
    self waittill("\xca|\xae[\x93\xec\r-\xe5a\"\x847\xa8\x11RC");
    turretowner = self getturretowner();

    if(isDefined(turretowner) && isPlayer(turretowner)) {
      foreach(startfunc in usefuncs.startfuncs) {
        self thread[[startfunc]]();
      }

      turretowner notify("\xa5\xa0\xdb\xa6\xbc\xe6X\xce\xe1\x95\xc0\xb1");
      self waittill("\xca|\xae[\x93\xec\r-\xe5a\"\x847\xa8\x11RC");

      foreach(stopfunc in usefuncs.stopfuncs) {
        self thread[[stopfunc]]();
      }

      turretowner notify("@\xc1\x19 .\x9d\x11\vr\x01\x92\x16\x82\v\xa0");
    }
  }
}

function turretplayerstartfunc() {
  self.ogplayerweapon = level.player getcurrentweapon();
  level.player giveweapon(self.weaponinfo);
  level.player switchtoweaponimmediate(self.weaponinfo);
  level.player hideviewmodel();
}

function turretplayerstopfunc() {
  level.player takeweapon(self.weaponinfo);

  if(isDefined(self.ogplayerweapon)) {
    level.player switchtoweaponimmediate(self.ogplayerweapon);
  }

  level.player showviewmodel();
}