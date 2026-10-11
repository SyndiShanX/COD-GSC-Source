/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\sp\mgturret.gsc
***********************************************/

#using scripts\anim\shared;
#using scripts\common\utility;
#using scripts\engine\sp\utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\sp\mg_penetration;
#using scripts\sp\mgturret;
#using scripts\sp\spawner;
#using scripts\sp\utility;
#namespace mgturret;

function init_mgturretsettings() {
  level.mgturretsettings["easy"]["convergenceTime"] = 2.5;
  level.mgturretsettings["easy"]["suppressionTime"] = 3;
  level.mgturretsettings["easy"]["accuracy"] = 0.38;
  level.mgturretsettings["easy"]["aiSpread"] = 2;
  level.mgturretsettings["easy"]["playerSpread"] = 0.5;
  level.mgturretsettings["medium"]["convergenceTime"] = 1.5;
  level.mgturretsettings["medium"]["suppressionTime"] = 3;
  level.mgturretsettings["medium"]["accuracy"] = 0.38;
  level.mgturretsettings["medium"]["aiSpread"] = 2;
  level.mgturretsettings["medium"]["playerSpread"] = 0.5;
  level.mgturretsettings["hard"]["convergenceTime"] = 0.8;
  level.mgturretsettings["hard"]["suppressionTime"] = 3;
  level.mgturretsettings["hard"]["accuracy"] = 0.38;
  level.mgturretsettings["hard"]["aiSpread"] = 2;
  level.mgturretsettings["hard"]["playerSpread"] = 0.5;
  level.mgturretsettings["fu"]["convergenceTime"] = 0.4;
  level.mgturretsettings["fu"]["suppressionTime"] = 3;
  level.mgturretsettings["fu"]["accuracy"] = 0.38;
  level.mgturretsettings["fu"]["aiSpread"] = 2;
  level.mgturretsettings["fu"]["playerSpread"] = 0.5;
}

function main() {
  if(getDvar(@ "mg42") == "") {
    setDvar(@ "mgturret", "off");
  }

  level.magic_distance = 24;
  create_func_ref("turret_disableLinkedTurretAngles", &mgturret_disablelinkedturretangles);
  create_func_ref("turret_enableLinkedTurretAngles", &mgturret_enablelinkedturretangles);
  turretinfos = getEntArray("turretInfo", "targetname");

  for(index = 0; index < turretinfos.size; index++) {
    turretinfos[index] delete();
  }

  create_lock("mg42_drones");
  create_lock("mg42_drones_target_trace");
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
  possible_turrets = getEntArray("misc_turret", "code_classname");
  var_adafff1d14cac7cb = [];

  foreach(possible_turret in possible_turrets) {
    var_adafff1d14cac7cb = array_add(var_adafff1d14cac7cb, possible_turret);
  }

  foreach(turret in var_adafff1d14cac7cb) {
    if(isDefined(turret.targetname) && turret.targetname == "zulu23_turret") {
      turret thread zuluinit();
    }
  }
}

function portable_mg_behavior() {
  self detach("weapon_mg42_carry", "tag_origin");
  self endon("death");
  self.goalradius = level.default_goalradius;

  if(isDefined(self.target)) {
    node = getnode(self.target, "targetname");

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
    node = getnode(self.target, "targetname");
    turret_node = node;
  }

  if(!isDefined(turret_node)) {
    turret_node = self.node;
  }

  if(!isDefined(turret_node)) {
    return;
  }

  if(turret_node.type != "Turret") {
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

  scripts\sp\mg_penetration::gunner_think(turret_node.turret);
}

function mg42_trigger() {
  self waittill("trigger");
  level notify(self.targetname);
  level.mg42_trigger[self.targetname] = 1;
  self delete();
}

function mgturret_auto(trigger) {
  trigger waittill("trigger");
  ai = getaiarray("bad_guys");

  for(i = 0; i < ai.size; i++) {
    if(isDefined(ai[i].script_mg42auto) && trigger.script_mg42auto == ai[i].script_mg42auto) {
      ai[i] notify("auto_ai");
      println("<dev string:x1c>");
    }
  }

  spawners = getspawnerarray();

  for(i = 0; i < spawners.size; i++) {
    if(isDefined(spawners[i].script_mg42auto) && trigger.script_mg42auto == spawners[i].script_mg42auto) {
      spawners[i].ai_mode = "auto_ai";
      println("<dev string:x2b>", i, "<dev string:x36>");
    }
  }

  scripts\sp\spawner::kill_trigger(trigger);
}

function mg42_suppressionfire(targets) {
  self endon("death");
  self endon("stop_suppressionFire");

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
  self waittill("auto_ai");
  mg42 notify("stopfiring");
  mg42 setmode("auto_ai");
  mg42 settargetentity(level.player);
}

function burst_fire_settings(setting) {
  if(setting == "delay") {
    return 0.2;
  }

  if(setting == "delay_range") {
    return 0.5;
  }

  if(setting == "burst") {
    return 0.5;
  }

  if(setting == "burst_fire_rate") {
    return 0.1;
  }

  return 1.5;
}

function burst_fire_unmanned() {
  self endon("death");
  self endon("stop_burst_fire_unmanned");

  if(isDefined(self.script_delay_min)) {
    mg42_delay = self.script_delay_min;
  } else {
    mg42_delay = burst_fire_settings("delay");
  }

  if(isDefined(self.script_delay_max)) {
    mg42_delay_range = self.script_delay_max - mg42_delay;
  } else {
    mg42_delay_range = burst_fire_settings("delay_range");
  }

  if(isDefined(self.script_burst_min)) {
    mg42_burst = self.script_burst_min;
  } else {
    mg42_burst = burst_fire_settings("burst");
  }

  if(isDefined(self.script_burst_max)) {
    mg42_burst_range = self.script_burst_max - mg42_burst;
  } else {
    mg42_burst_range = burst_fire_settings("burst_range");
  }

  if(isDefined(self.script_burst_fire_rate)) {
    var_8651842fb899f562 = self.script_burst_fire_rate;
  } else {
    var_8651842fb899f562 = burst_fire_settings("burst_fire_rate");
  }

  pauseuntiltime = gettime();
  turretstate = "start";

  if(isDefined(self.shell_fx)) {
    thread turret_shell_fx();
  }

  for(;;) {
    duration = (pauseuntiltime - gettime()) * 0.001;

    if(self isfiringturret() && duration <= 0) {
      if(turretstate != "fire") {
        turretstate = "fire";
        thread doshoot(var_8651842fb899f562);
      }

      duration = mg42_burst + randomfloat(mg42_burst_range);
      thread turrettimer(duration);
      self waittill("turretstatechange");
      duration = mg42_delay + randomfloat(mg42_delay_range);
      pauseuntiltime = gettime() + int(duration * 1000);
      continue;
    }

    if(turretstate != "aim") {
      turretstate = "aim";
    }

    thread turrettimer(duration);
    self waittill("turretstatechange");
  }
}

function doshoot(var_5ba6fa0508a68649) {
  self endon("death");
  self endon("turretstatechange");
  fire_rate = 0.1;

  if(isDefined(var_5ba6fa0508a68649)) {
    fire_rate = var_5ba6fa0508a68649;
  }

  for(;;) {
    self shootturret();
    wait fire_rate;
  }
}

function turret_shell_fx() {
  self endon("death");
  self endon("stop_burst_fire_unmanned");

  if(isDefined(self.shell_sound)) {
    self.shell_sound_enabled = 1;
  }

  while(true) {
    self waittill("turret_fire");
    playFXOnTag(self.shell_fx, self, "tag_origin");

    if(isDefined(self.shell_sound_enabled) && self.shell_sound_enabled) {
      thread turret_shell_sound();
    }
  }
}

function turret_shell_sound() {
  self endon("death");
  self.shell_sound_enabled = 0;
  tag_origin = self gettagorigin("tag_origin");
  origin = drop_to_ground(tag_origin, -30);
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

  self endon("turretstatechange");
  wait duration;

  if(isDefined(self)) {
    self notify("turretstatechange");
  }
}

function random_spread(ent) {
  self endon("death");
  self notify("stop random_spread");
  self endon("stop random_spread");
  self endon("stopfiring");
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
  self notify("stop_using_built_in_burst_fire");
  self endon("stop_using_built_in_burst_fire");
  mg42 stopfiring();

  while(true) {
    mg42 waittill("startfiring");
    thread burst_fire(mg42);
    mg42 startfiring();
    mg42 waittill("stopfiring");
    mg42 stopfiring();
  }
}

function burst_fire(mg42, manual_target) {
  mg42 endon("entitydeleted");
  mg42 endon("stopfiring");
  self endon("stop_using_built_in_burst_fire");

  if(isDefined(mg42.script_delay_min)) {
    mg42_delay = mg42.script_delay_min;
  } else {
    mg42_delay = scripts\sp\mgturret::burst_fire_settings("delay");
  }

  if(isDefined(mg42.script_delay_max)) {
    mg42_delay_range = mg42.script_delay_max - mg42_delay;
  } else {
    mg42_delay_range = scripts\sp\mgturret::burst_fire_settings("delay_range");
  }

  if(isDefined(mg42.script_burst_min)) {
    mg42_burst = mg42.script_burst_min;
  } else {
    mg42_burst = scripts\sp\mgturret::burst_fire_settings("burst");
  }

  if(isDefined(mg42.script_burst_max)) {
    mg42_burst_range = mg42.script_burst_max - mg42_burst;
  } else {
    mg42_burst_range = scripts\sp\mgturret::burst_fire_settings("burst_range");
  }

  while(true) {
    mg42 startfiring();

    if(isDefined(manual_target)) {
      mg42 thread random_spread(manual_target);
    }

    wait mg42_burst + randomfloat(mg42_burst_range);
    mg42 stopfiring();
    wait mg42_delay + randomfloat(mg42_delay_range);
  }
}

function _spawner_mg42_think() {
  if(!isDefined(self.flagged_for_use)) {
    self.flagged_for_use = 0;
  }

  if(!isDefined(self.targetname)) {
    return;
  }

  node = getnode(self.targetname, "target");

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
        self waittill("get new user");
      }
    }

    if(!node.mg42_enabled) {
      node waittill("enable mg42");
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
      ai = scripts\engine\sp\utility::get_closest_ai_exclude(node.origin, undefined, excluders);
    } else {
      ai = scripts\engine\sp\utility::get_closest_ai(node.origin, undefined);
    }

    excluders = undefined;

    if(isDefined(ai)) {
      ai notify("stop_going_to_node");
      ai thread scripts\sp\spawner::go_to_node(node);
      ai waittill("death");
      continue;
    }

    self waittill("get new user");
  }
}

function mg42_think() {
  if(!isDefined(self.ai_mode)) {
    self.ai_mode = "manual_ai";
  }

  node = getnode(self.target, "targetname");

  if(!isDefined(node)) {
    println("<dev string:x43>", self.origin, "<dev string:x4f>");
    return;
  }

  mg42 = getEnt(node.target, "targetname");
  mg42.org = node.origin;

  if(isDefined(mg42.target)) {
    if(!isDefined(level.mg42_trigger) || !isDefined(level.mg42_trigger[mg42.target])) {
      level.mg42_trigger[mg42.target] = 0;
      getEnt(mg42.target, "targetname") thread mg42_trigger();
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
      mg42_gunner = spawn_ai();
      wait 1;
    }

    mg42_gunner thread mg42_gunner_think(mg42, trigger, self.ai_mode);
    mg42_gunner thread mg42_firing(mg42);
    mg42_gunner waittill("death");

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
  self endon("death");

  if(ai_mode == "manual_ai") {
    while(true) {
      thread mg42_gunner_manual_think(mg42, trigger);
      self waittill("auto_ai");
      move_use_turret(mg42, "auto_ai");
      self waittill("manual_ai");
    }

    return;
  }

  while(true) {
    move_use_turret(mg42, "auto_ai", level.player);
    self waittill("manual_ai");
    thread mg42_gunner_manual_think(mg42, trigger);
    self waittill("auto_ai");
  }
}

function player_safe() {
  if(!isDefined(level.player_covertrigger)) {
    return false;
  }

  if(level.player getstance() == "prone") {
    return true;
  }

  if(level.player_covertype == "cow" && level.player getstance() == "crouch") {
    return true;
  }

  return false;
}

function stance_num() {
  if(level.player getstance() == "prone") {
    return (0, 0, 5);
  } else if(level.player getstance() == "crouch") {
    return (0, 0, 25);
  }

  return (0, 0, 50);
}

function mg42_gunner_manual_think(mg42, trigger) {
  self endon("death");
  self endon("auto_ai");
  self.pacifist = 1;
  self setgoalpos(mg42.org);
  self.goalradius = level.magic_distance;
  self waittill("goal");

  if(trigger) {
    if(!level.mg42_trigger[mg42.target]) {
      level waittill(mg42.target);
    }
  }

  self.pacifist = 0;
  mg42 setmode("auto_ai");
  mg42 cleartargetentity();
  targ_org = spawn("script_origin", (0, 0, 0));
  tempmodel = spawn("script_model", (0, 0, 0));
  tempmodel.scale = 3;

  if(getDvar(@ "mg42") != "off") {
    tempmodel setModel("temp");
  }

  tempmodel thread temp_think(mg42, targ_org);
  level thread kill_objects(self, "death", targ_org, tempmodel);
  level thread kill_objects(self, "auto_ai", targ_org, tempmodel);
  mg42.player_target = 0;
  mg42timer = 0;
  targets = getEntArray("mg42_target", "targetname");

  if(targets.size > 0) {
    script_targets = 1;
    current_org = targets[randomint(targets.size)].origin;
    thread shoot_mg42_script_targets(targets);
    move_use_turret(mg42);
    self.target_entity = targ_org;
    mg42 setmode("manual_ai");
    mg42 settargetentity(targ_org);
    mg42 notify("startfiring");
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
        self notify("next_target");
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
          target = getEntArray(level.player_covertrigger.target, "targetname");
          target = target[randomint(target.size)];
          targ_org.origin = target.origin + (randomfloat(30) - 15, randomfloat(30) - 15, randomfloat(40) - 60);
          wait 0.1;
        }
      }

      self notify("next_target");

      while(player_safe()) {
        current_org = targ_org.origin;

        if(distance(current_org, targets[self.gun_targ].origin) > mindist) {
          temp_vec = vectorNormalize(targets[self.gun_targ].origin - current_org);
          temp_vec *= mindist;
          current_org += temp_vec;
        } else {
          self notify("next_target");
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

    mg42 setmode("manual_ai");
    move_use_turret(mg42);
    mg42 notify("startfiring");
    shoot_timer = gettime() + 1500 + randomfloat(4000);

    while(shoot_timer > gettime()) {
      if(isDefined(level.player_covertrigger)) {
        target = getEntArray(level.player_covertrigger.target, "targetname");
        target = target[randomint(target.size)];
        targ_org.origin = target.origin + (randomfloat(30) - 15, randomfloat(30) - 15, randomfloat(40) - 60);
        mg42 settargetentity(targ_org);
        tempmodel.targent = targ_org;
        wait randomfloat(1);
        continue;
      }

      break;
    }

    mg42 notify("stopfiring");
    move_use_turret(mg42);

    if(mg42.player_target) {
      mg42 setmode("auto_ai");
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
  self endon("death");

  while(true) {
    targ_filled = [];

    for(i = 0; i < targets.size; i++) {
      targ_filled[i] = 0;
    }

    for(i = 0; i < targets.size; i++) {
      self.gun_targ = randomint(targets.size);
      self waittill("next_target");

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
  self waittill("goal");

  if(isDefined(aitype) && aitype == "auto_ai") {
    mg42 setmode("auto_ai");

    if(isDefined(target)) {
      mg42 settargetentity(target);
    } else {
      mg42 cleartargetentity();
    }
  }

  self useturret(mg42);
}

function temp_think(mg42, targ) {
  if(getDvar(@ "mg42") == "off") {
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
  turret = getEnt(node.auto_mg42_target, "targetname");
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
    turret waittill("turret_deactivate");
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
      savekeepclaimed = ai[i].keepclaimednodeifvalid;
      ai[i].keepclaimednodeifvalid = 0;

      if(!ai[i] usecovernode(node)) {
        ai[i].keepclaimednodeifvalid = savekeepclaimed;
      }
    }
  }
}

function setdifficulty() {
  init_mgturretsettings();
  mg42s = getEntArray("misc_turret", "code_classname");
  difficulty = utility::getdifficulty();

  for(index = 0; index < mg42s.size; index++) {
    if(isDefined(mg42s[index].script_skilloverride)) {
      switch (mg42s[index].script_skilloverride) {
        case #"hash_22ce4003c1e5227b":
          difficulty = "easy";
          break;
        case #"hash_c71b112fe04823d6":
          difficulty = "medium";
          break;
        case #"hash_cc9157548a55043c":
          difficulty = "hard";
          break;
        case #"hash_fa14cdf6bd53b8e4":
          difficulty = "fu";
          break;
        default:
          continue;
      }
    }

    mg42_setdifficulty(mg42s[index], difficulty);
  }
}

function mg42_setdifficulty(mg42, difficulty) {
  mg42.convergencetime = level.mgturretsettings[difficulty]["convergenceTime"];
  mg42.suppressiontime = level.mgturretsettings[difficulty]["suppressionTime"];
  mg42.accuracy = level.mgturretsettings[difficulty]["accuracy"];
  mg42.aispread = level.mgturretsettings[difficulty]["aiSpread"];
  mg42.playerspread = level.mgturretsettings[difficulty]["playerSpread"];
}

function mg42_target_drones(nonai, team, dotrange) {
  if(!isDefined(dotrange)) {
    dotrange = 0.88;
  }

  self endon("death");
  self notify("stop_mg42_target_drones");
  self endon("stop_mg42_target_drones");
  self.dronefailed = 0;

  if(!isDefined(self.script_fireondrones)) {
    self.script_fireondrones = 0;
  }

  if(!isDefined(nonai)) {
    nonai = 0;
  }

  self setmode("manual_ai");
  difficulty = utility::getdifficulty();

  if(!isDefined(level.drones)) {
    waitfornewdrone = 1;
  } else {}

  for(waitfornewdrone = 0; true; waitfornewdrone = 1) {
    if(waitfornewdrone) {
      if(isDefined(self.drones_targets_sets_to_default)) {
        self setmode(self.defaultonmode);
      } else if(nonai) {
        self setmode("auto_nonai");
      } else {
        self setmode("auto_ai");
      }

      level waittill("new_drone");
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

    if(team == "allies") {
      targetteam = "axis";
    } else {
      targetteam = "allies";
    }

    while(level.drones[targetteam].lastindex) {
      lock("mg42_drones");

      if(!level.drones[targetteam].lastindex) {
        unlock("mg42_drones");
        break;
      }

      target = get_bestdrone(targetteam, dotrange);
      unlock("mg42_drones");

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
        self setmode("manual");
      } else {
        self setmode("manual_ai");
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
      waitfornewdrone = 0;
      continue;
    }
  }
}

function drone_target(drone, time, dotrange) {
  self endon("death");
  drone endon("death");
  timer = gettime() + time * 1000;
  startedfiring = 0;

  while(timer > gettime() || startedfiring) {
    lock("mg42_drones_target_trace");
    turrettarget = self getturrettarget(1);

    if(!scripts\engine\trace::_bullet_trace_passed(self gettagorigin("tag_flash"), drone.origin + (0, 0, 40), 0, drone)) {
      unlock("mg42_drones_target_trace");
      break;
    } else if(isDefined(turrettarget) && distance(turrettarget.origin, self.origin) < distance(self.origin, drone.origin)) {
      unlock("mg42_drones_target_trace");
      break;
    }

    if(!startedfiring) {
      self startfiring();
      startedfiring = 1;
    }

    unlock_wait("mg42_drones_target_trace");
  }

  self stopfiring();
  scripts\engine\sp\utility::structarray_shuffle(level.drones[drone.team], 1);
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

    if(!scripts\engine\trace::_bullet_trace_passed(self gettagorigin("tag_flash"), ent getcentroid(), 0, ent)) {
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
  possible_turrets = getEntArray("misc_turret", "code_classname");
  turrets = [];

  foreach(possible_turret in possible_turrets) {
    if(isDefined(possible_turret.targetname)) {
      continue;
    }

    if(isDefined(possible_turret.script_turret_autonomous) && possible_turret.script_turret_autonomous) {
      continue;
    }

    if(isDefined(possible_turret.isvehicleattached)) {
      assertex(possible_turret.isvehicleattached != 0, "Setting must be either true or undefined");
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
      if(node.type == "Path") {
        continue;
      }

      if(node.type == "Begin") {
        continue;
      }

      if(node.type == "End") {
        continue;
      }

      nodeforward = anglesToForward((0, node.angles[1], 0));
      turretforward = anglesToForward((0, turret.angles[1], 0));
      dot = vectordot(nodeforward, turretforward);

      if(dot < 0.9) {
        continue;
      }

      unclaimed = array_remove(unclaimed, turret);
      node.turretinfo = spawn("script_origin", turret.origin);
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
    assertmsg("<dev string:x5c>" + turret.origin + "<dev string:x6e>");
  }
}

function auto_mgturretlink() {
  possible_turrets = getEntArray("misc_turret", "code_classname");
  turrets = [];

  foreach(possible_turret in possible_turrets) {
    if(!isDefined(possible_turret.targetname) || tolower(possible_turret.targetname) != "auto_mgturret") {
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
      if(node.type == "Path") {
        continue;
      }

      if(node.type == "Begin") {
        continue;
      }

      if(node.type == "End") {
        continue;
      }

      nodeforward = anglesToForward((0, node.angles[1], 0));
      turretforward = anglesToForward((0, turret.angles[1], 0));
      dot = vectordot(nodeforward, turretforward);

      if(dot < 0.9) {
        continue;
      }

      unclaimed = array_remove(unclaimed, turret);
      node.turret = turret;
      turret.node = node;
      turret.issetup = 1;
      assertex(isDefined(turret.export), "Turret at " + turret.origin + " does not have a .export value but is near a cover node. If you do not want them to link, use .script_dont_link_turret.");
    }
  }

  if(unclaimed.size) {
    println("<dev string:x8b>");
    println("<dev string:xd6>");

    foreach(u in unclaimed) {
      println(u.origin);
    }

    assertex(0, "<dev string:x125>");
  }
}

function save_turret_sharing_info() {
  self.shared_turrets = [];
  self.shared_turrets["connected"] = [];
  self.shared_turrets["ambush"] = [];

  if(!isDefined(self.export)) {
    assertex(!isDefined(self.script_turret_share), "Turret at " + self.origin + " has script_turret_share but has no .export value, so script_turret_share won't have any effect.");
    assertex(!isDefined(self.script_turret_ambush), "Turret at " + self.origin + " has script_turret_ambush but has no .export value, so script_turret_ambush won't have any effect.");
    return;
  }

  if(!isDefined(level.shared_portable_turrets)) {
    level.shared_portable_turrets = [];
  }

  level.shared_portable_turrets[self.export] = self;

  if(isDefined(self.script_turret_share)) {
    strings = strtok(self.script_turret_share, " ");

    for(i = 0; i < strings.size; i++) {
      self.shared_turrets["connected"][strings[i]] = 1;
    }
  }

  if(isDefined(self.script_turret_ambush)) {
    strings = strtok(self.script_turret_ambush, " ");

    for(i = 0; i < strings.size; i++) {
      self.shared_turrets["ambush"][strings[i]] = 1;
    }
  }
}

function restoredefaultpitch() {
  self notify("gun_placed_again");
  self endon("gun_placed_again");
  self waittill("restore_default_drop_pitch");
  wait 1;
  self restoredefaultdroppitch();
}

function dropturret() {
  thread dropturretproc();
}

function dropturretproc() {
  turret = spawn("script_model", (0, 0, 0));
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
  self endon("kill_turret_detach_thread");
  self endon("dropped_gun");
  self waittill("death");

  if(!isDefined(self)) {
    return;
  }

  dropturret();
}

function turretdetacher() {
  self endon("death");
  self endon("kill_turret_detach_thread");
  self waittill("dropped_gun");
  self detach(self.turretmodel, level.portable_mg_gun_tag);
}

function restoredefaults() {
  self.run_overrideanim = undefined;
}

function restorepitch() {
  self waittill("turret_deactivate");
  self restoredefaultdroppitch();
}

function update_enemy_target_pos_while_running(ent) {
  self endon("death");
  self endon("end_mg_behavior");
  self endon("stop_updating_enemy_target_pos");

  for(;;) {
    self waittill("saw_enemy");
    ent.origin = self.last_enemy_sighting_position;
  }
}

function move_target_pos_to_new_turrets_visibility(ent, new_spot) {
  self endon("death");
  self endon("end_mg_behavior");
  self endon("stop_updating_enemy_target_pos");
  old_turret_pos = self.turret.origin + (0, 0, 16);
  dest_pos = new_spot.origin + (0, 0, 16);

  for(;;) {
    wait 0.05;

    if(sighttracepassed(ent.origin, dest_pos, 0, undefined)) {
      continue;
    }

    angles = vectortoangles(old_turret_pos - ent.origin);
    forward = anglesToForward(angles);
    forward *= 8;
    ent.origin += forward;
  }
}

function record_bread_crumbs_for_ambush(ent) {
  self endon("death");
  self endon("end_mg_behavior");
  self endon("stop_updating_enemy_target_pos");
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
  new_spot = array["spot"];
  connection_type = array["type"];

  if(!isDefined(new_spot)) {
    return;
  }

  reserve_turret(new_spot);
  thread update_enemy_target_pos_while_running(ent);
  thread move_target_pos_to_new_turrets_visibility(ent, new_spot);

  if(connection_type == "ambush") {
    thread record_bread_crumbs_for_ambush(ent);
  }

  if(new_spot.issetup) {
    leave_gun_and_run_to_new_spot(new_spot);
  } else {
    pickup_gun(new_spot);
    run_to_new_spot_and_setup_gun(new_spot);
  }

  self notify("stop_updating_enemy_target_pos");

  if(connection_type == "ambush") {
    aim_turret_at_ambush_point_or_visible_enemy(new_spot, ent);
  }

  new_spot settargetentity(ent);
}

function snap_lock_turret_onto_target(turret) {
  turret setmode("manual");
  wait 0.5;
  turret setmode("manual_ai");
}

function leave_gun_and_run_to_new_spot(spot) {
  assert(spot.reserved == self);
  self stopuseturret();
  scripts\anim\shared::placeweaponon(self.primaryweapon, "none");
  setup_anim = get_turret_setup_anim(spot);
  org = getstartorigin(spot.origin, spot.angles, setup_anim);
  assertmsg("this turret functionality is no longer supported. query your local neighborhood ai programmer for details.");
  assertex(distance(org, self.goalpos) < self.goalradius, "Tried to set the run pos outside the goalradius");
  self waittill("runto_arrived");
  use_the_turret(spot);
}

function pickup_gun(spot) {
  self stopuseturret();
  self.turret hide_turret();
}

function get_turret_setup_anim(turret) {
  spot_types = [];
  spot_types["saw_bipod_stand"] = level.mg_animmg["bipod_stand_setup"];
  spot_types["saw_bipod_crouch"] = level.mg_animmg["bipod_crouch_setup"];
  spot_types["saw_bipod_prone"] = level.mg_animmg["bipod_prone_setup"];
  return spot_types[turret.weaponinfo];
}

function run_to_new_spot_and_setup_gun(spot) {
  assert(spot.reserved == self);
  oldhealth = self.health;
  spot endon("turret_deactivate");
  self.mg42 = spot;
  self endon("death");
  self endon("dropped_gun");
  setup_anim = get_turret_setup_anim(spot);
  self.turretmodel = "weapon_mg42_carry";
  self notify("kill_get_gun_back_on_killanimscript_thread");
  scripts\anim\shared::placeweaponon(self.weapon, "none");

  if(self isbadguy()) {
    self.health = 1;
  }

  self attach(self.turretmodel, level.portable_mg_gun_tag);
  thread turretdeathdetacher();
  org = getstartorigin(spot.origin, spot.angles, setup_anim);
  assertmsg("this turret functionality is no longer supported. query your local neighborhood ai programmer for details.");
  assertex(distance(org, self.goalpos) < self.goalradius, "Tried to set the run pos outside the goalradius");
  wait 0.05;
  clear_exception("move");
  set_exception("cover_crouch", &hold_indefintely);
  assertmsg("this turret functionality is no longer supported. query your local neighborhood ai programmer for details.");

  while(distance(self.origin, org) > 16) {
    wait 0.05;
  }

  self notify("kill_turret_detach_thread");

  if(self isbadguy()) {
    self.health = oldhealth;
  }

  if(soundexists("weapon_setup")) {
    playsoundatpos(self.origin, "weapon_setup");
  }

  self animScripted("setup_done", spot.origin, spot.angles, setup_anim);
  restoredefaults();
  self waittillmatch("setup_done", "end");
  spot notify("restore_default_drop_pitch");
  spot show_turret();
  scripts\anim\shared::placeweaponon(self.primaryweapon, "right");
  use_the_turret(spot);
  self detach(self.turretmodel, level.portable_mg_gun_tag);
  self notify("bcs_portable_turret_setup");
}

function hold_indefintely() {
  self endon("killanimscript");
  self waittill("death");
}

function using_a_turret() {
  if(!isDefined(self.turret)) {
    return false;
  }

  return self.turret.owner == self;
}

function turret_user_moves() {
  if(!using_a_turret()) {
    clear_exception("move");
    return;
  }

  array = find_connected_turrets("connected");
  new_spots = array["spots"];

  if(!new_spots.size) {
    clear_exception("move");
    return;
  }

  turret_node = self.node;

  if(!isDefined(turret_node) || !array_contains(new_spots, turret_node)) {
    taken_nodes = gettakennodes();

    for(i = 0; i < new_spots.size; i++) {
      turret_node = random(new_spots);

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

  scripts\sp\mg_penetration::gunner_think(turret_node.turret);
}

function use_the_turret(spot) {
  turretwasused = self useturret(spot);

  if(turretwasused) {
    set_exception("move", &turret_user_moves);
    self.turret = spot;
    thread mg42_firing(spot);
    spot setmode("manual_ai");
    spot thread restorepitch();
    self.turret = spot;
    spot.owner = self;
    return 1;
  }

  spot restoredefaultdroppitch();
  return 0;
}

function get_portable_mg_spot(ent) {
  find_spot_funcs = [];
  find_spot_funcs[find_spot_funcs.size] = &find_different_way_to_attack_last_seen_position;
  find_spot_funcs[find_spot_funcs.size] = &find_good_ambush_spot;
  find_spot_funcs = array_randomize(find_spot_funcs);

  for(i = 0; i < find_spot_funcs.size; i++) {
    array = [[find_spot_funcs[i]]](ent);

    if(!isDefined(array["spots"])) {
      continue;
    }

    array["spot"] = random(array["spots"]);
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
  array["type"] = connection_type;
  array["spots"] = usable_spots;
  return array;
}

function find_good_ambush_spot(ent) {
  return find_connected_turrets("ambush");
}

function find_different_way_to_attack_last_seen_position(ent) {
  array = find_connected_turrets("connected");
  usable_spots = array["spots"];

  if(!usable_spots.size) {
    return;
  }

  good_spot = [];

  for(i = 0; i < usable_spots.size; i++) {
    if(!within_fov(usable_spots[i].origin, usable_spots[i].angles, ent.origin, 0.75)) {
      continue;
    }

    if(!sighttracepassed(ent.origin, usable_spots[i].origin + (0, 0, 16), 0, undefined)) {
      continue;
    }

    good_spot[good_spot.size] = usable_spots[i];
  }

  array["spots"] = good_spot;
  return array;
}

function portable_mg_spot() {
  save_turret_sharing_info();
  turret_preplaced = 1;
  self.issetup = 1;
  assert(!isDefined(self.reserved));
  self.reserved = undefined;

  if(isDefined(self.isvehicleattached)) {
    return;
  }

  if(self.spawnflags &turret_preplaced) {
    return;
  }

  hide_turret();
}

function hide_turret() {
  assert(self.issetup);
  self notify("stop_checking_for_flanking");
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
  self endon("stop_checking_for_flanking");
  self waittill("turret_deactivate");

  if(isalive(self.owner)) {
    self.owner notify("end_mg_behavior");
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
  turret endon("turret_deactivate");
  self endon("death");
  self waittill("end_mg_behavior");
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
  self endon("death");

  while(true) {
    self waittill("missile_fire", missile);
    missile thread missile_explode_quakes();
  }
}

function missile_explode_quakes() {
  self waittill("explode", position);
  earthquake(0.18, 0.75, position, 500);
  playrumbleonposition("artillery_rumble_light", position);
}

function turret_getplayerusefuncs() {
  usefuncs = spawnStruct();
  usefuncs.startfuncs = [ &turretplayerstartfunc];
  usefuncs.stopfuncs = [ &turretplayerstopfunc];
  return usefuncs;
}

function turret_watchplayeruse(usefuncs) {
  self endon("death");

  while(true) {
    self waittill("turretownerchange");
    turretowner = self getturretowner();

    if(isDefined(turretowner) && isPlayer(turretowner)) {
      foreach(startfunc in usefuncs.startfuncs) {
        self thread[[startfunc]]();
      }

      turretowner notify("turret_mount");
      self waittill("turretownerchange");

      foreach(stopfunc in usefuncs.stopfuncs) {
        self thread[[stopfunc]]();
      }

      turretowner notify("turret_dismount");
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