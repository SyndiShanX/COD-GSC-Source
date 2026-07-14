/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\common\ai.gsc
**************************************/

#using scripts\asm\shared\utility;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\engine\math;
#using scripts\engine\utility;
#namespace ai;

function ai_init() {
  flag_name = self.animsetname + "_animsetname_init";

  if(!utility::flag(flag_name)) {
    utility::flag_set(flag_name);
    callback::callback("on_first_ai_init");
  }

  callback::function_99edd620ee45cd95(#"ai");
  callback::function_99edd620ee45cd95(self.type);
  callback::function_99edd620ee45cd95(self.animsetname);

  if(isDefined(self.subclass)) {
    callback::function_99edd620ee45cd95(self.subclass);
  }

  utility::ent_flag_set("ai_init_complete");
  callback::callback("on_ai_init");
}

function function_6560fe052bc053d() {
  for(i = 0; i < level.players.size; i++) {
    player = level.players[i];
    player function_9349715a3ded9d8();
  }
}

function function_9349715a3ded9d8() {
  self function_533d1ea1bc485146();
}

function set_forcegoal() {
  if(isDefined(self.set_forcedgoal)) {
    return;
  }

  self.oldfightdist = self.pathenemyfightdist;
  self.oldmaxdist = self.pathenemylookahead;
  self.oldmaxsight = self.maxsightdistsqrd;
  self.pathenemyfightdist = 8;
  self.pathenemylookahead = 8;
  self.maxsightdistsqrd = 1;
  self.set_forcedgoal = 1;
}

function unset_forcegoal() {
  if(!isDefined(self.set_forcedgoal)) {
    return;
  }

  self.pathenemyfightdist = self.oldfightdist;
  self.pathenemylookahead = self.oldmaxdist;
  self.maxsightdistsqrd = self.oldmaxsight;
  self.set_forcedgoal = undefined;
}

function disable_exits() {
  self.disableexits = 1;
}

function enable_exits() {
  self.disableexits = 0;
}

function disable_turnanims() {
  self.turnanimsenabled = 0;
}

function enable_turnanims() {
  self.turnanimsenabled = 1;
}

function disable_arrivals() {
  self.disablearrivals = 1;
}

function enable_arrivals() {
  self endon("death");
  waittillframeend();
  self.disablearrivals = 0;
}

function set_rebel(var_ce2840db99be60d0) {
  self._blackboard.wildfireenabled = var_ce2840db99be60d0;
}

function disable_long_death() {
  assert(isalive(self), "<dev string:x24>");
  self.allowlongdeath = 0;
}

function enable_long_death() {
  assert(isalive(self), "<dev string:x59>");
  self.allowlongdeath = 1;
}

function enable_danger_react(duration) {
  duration *= 1000;
  assert(isai(self));
  self.dodangerreact = 1;
  self.dangerreactduration = duration;
  self.neversprintforvariation = undefined;
}

function disable_danger_react() {
  assert(isai(self));
  self.dodangerreact = 0;
  self.neversprintforvariation = 1;
}

function disable_surprise() {
  self.newenemyreactiondistsq = 0;
}

function get_ignoreme() {
  return val::get("ignoreme");
}

function set_ignoreme(val) {
  assert(issentient(self), "<dev string:x8d>");

  if(val) {
    val::set("set_ignoreme", "ignoreme", 1);
    return;
  }

  val::reset("set_ignoreme", "ignoreme");
}

function function_924749876ac28aae(contributor, val) {
  assert(issentient(self), "<dev string:x8d>");

  if(val) {
    val::set(contributor, "ignoreme", 1);
    return;
  }

  val::reset(contributor, "ignoreme");
}

function get_ignoreall() {
  assert(issentient(self), "<dev string:xad>");
  return val::get("ignoreall");
}

function set_ignoreall(val) {
  assert(issentient(self), "<dev string:xce>");

  if(val) {
    val::set("set_ignoreall", "ignoreall", 1);
    return;
  }

  val::reset("set_ignoreall", "ignoreall");
}

function spawn_failed(ent) {
  if(!isalive(ent)) {
    return true;
  }

  if(utility::issp() && !isDefined(ent.finished_spawning)) {
    ent utility::waittill_any("finished spawning", "death");
  }

  if(isalive(ent)) {
    return false;
  }

  return true;
}

function gun_remove() {
  if(isai(self)) {
    utility::script_func("anim_placeweaponon", self.weapon, "none");
    return;
  }

  if(isDefined(self.fake_weapon_models)) {
    gun_remove_fake();
    self.var_e39aa0eaeb58fa70 = 1;
    return;
  }

  if(isweapon(self.weapon)) {
    weaponmodel = getweaponmodel(self.weapon);

    if(isDefined(weaponmodel) && weaponmodel != "") {
      self detach(weaponmodel, "tag_weapon_right");
    }
  }
}

function gun_remove_fake() {
  if(isDefined(self.fake_weapon_models)) {
    for(i = self.fake_weapon_models.size - 1; i >= 0; i--) {
      if(i == 0) {
        self detach(self.fake_weapon_models[i], "tag_weapon_right");
        continue;
      }

      self detach(self.fake_weapon_models[i]);
    }

    self.fake_weapon_models = undefined;
  }
}

function gun_create_fake(models) {
  foreach(model in models) {
    if(issubstr(model, "toprail") || issubstr(model, "railcust")) {
      if(models.size > 1) {
        models = arrayremove(models, model);
        arrayinsert(models, model, 1);
      }
    }
  }

  for(i = 0; i < models.size; i++) {
    if(i == 0) {
      self attach(models[i], "tag_weapon_right");
      continue;
    }

    self attach(models[i]);
  }

  self.fake_weapon_models = models;
}

function gun_recall() {
  if(isai(self)) {
    utility::script_func("anim_placeweaponon", self.weapon, "right");
    return;
  }

  weaponobject = self.weapon;

  if(isweapon(self.weapon_object) && !isnullweapon(self.weapon_object) && isnullweapon(self.weapon)) {
    weaponobject = self.weapon_object;
  }

  if(self.var_e39aa0eaeb58fa70) {
    gun_create_fake(getweaponattachmentworldmodels(weaponobject));
    self.var_e39aa0eaeb58fa70 = undefined;
    return;
  }

  self attach(getweaponmodel(weaponobject), "tag_weapon_right");
}

function set_gunpose(type, gundiscipline) {
  validtypes["<dev string:xef>"] = 1;
  validtypes["<dev string:xfc>"] = 1;
  validtypes["<dev string:x108>"] = 1;
  validtypes["<dev string:x111>"] = 1;
  validtypes["<dev string:x118>"] = 1;
  assert(isDefined(validtypes[type]), "<dev string:x123>" + type + "<dev string:x133>");

  if(type == "automatic") {
    type = undefined;
  }

  self.gunposeoverride = type;
  self.gundiscipline = istrue(gundiscipline);
}

function reset_gunpose() {
  self.gunposeoverride = undefined;
  self.gundiscipline = 1;
}

function poi_enable(val, startstruct) {
  utility::toggle_poi(val, startstruct);
}

function stop_use_turret() {
  self notify("stop_use_turret");
  self unlink();
  self._blackboard.requestedturret = undefined;
  self._blackboard.requestedturretpose = undefined;
}

function magic_bullet_shield(var_9f4fc29bebb432cc = 0) {
  if(isai(self)) {
    assert(isalive(self), "<dev string:x14d>");
    assert(!self.delayeddeath, "<dev string:x18c>");
    assert(!self.doinglongdeath, "<dev string:x1c6>");
    assert(!isDefined(self.syncedmeleetarget) || !self.in_melee, "<dev string:x201>");
  } else {
    self.health = 100000;
  }

  assert(!isDefined(self.magic_bullet_shield), "<dev string:x262>");

  if(isai(self)) {
    val::set("magic_bullet_shield", "attackeraccuracy", 0.1);
    self.var_bb9911e6ba53bdb3 = self.var_5609d8c260be3f0e;
    self.var_5609d8c260be3f0e = 0;
  }

  if(!var_9f4fc29bebb432cc) {
    thread magic_bullet_death_detection();
  }

  val::set("magic_bullet_shield", "damageshield", 1);
  self.magic_bullet_shield = 1;
}

function stop_magic_bullet_shield() {
  self notify("stop_magic_bullet_shield");
  assert(isDefined(self.magic_bullet_shield) && self.magic_bullet_shield, "<dev string:x300>");
  val::reset_all("magic_bullet_shield");
  self.var_5609d8c260be3f0e = self.var_bb9911e6ba53bdb3 ?? 1;
  self.var_bb9911e6ba53bdb3 = undefined;
  self.magic_bullet_shield = undefined;
}

function magic_bullet_death_detection() {
  self endon("<dev string:x349>");
  export = self.export;
  entnum = self getentitynumber();
  self waittill("<dev string:x365>");

  if(isDefined(self)) {
    assert(0, "<dev string:x36e>" + export +"<dev string:x396>");
  } else {
    assert(0, "<dev string:x36e>" + export +"<dev string:x3a9>");
  }

  export =
  export;
}

function force_long_death_on_back_with_pistol(skipcrawl) {
  self.forcelongdeath = 4;

  if(skipcrawl) {
    self.skipdyingbackcrawl = 1;
  }

  self asmsetstate(self.asmname, "choose_long_death");
}

function function_d3e4c703216f33e9(skipcrawl, skipintro) {
  assert(self asmhasstate(self.asmname, "<dev string:x3db>"), "<dev string:x3f0>" + self.asmname + "<dev string:x404>");
  var_1152d8d3fdbd53eb = [29, 31, 33, 35];
  randind = randomint(4);
  self.forcelongdeath = var_1152d8d3fdbd53eb[randind];

  if(isDefined(skipintro)) {
    self.var_7733428de091931d = skipintro;
  }

  if(isDefined(skipcrawl)) {
    self.skipdyingbackcrawl = skipcrawl;
  }

  self asmsetstate(self.asmname, "choose_long_death");
}

function function_f87586c8c1aaa78d(skipcrawl, skipintro) {
  self.forcelongdeath = 37;

  if(isDefined(skipintro)) {
    self.var_7733428de091931d = skipintro;
  }

  if(isDefined(skipcrawl)) {
    self.skipdyingbackcrawl = skipcrawl;
  }

  self asmsetstate(self.asmname, "choose_long_death");
}

function force_long_death_crawling_away() {
  self.forcelongdeath = 3;
}

function force_long_death_stumbling() {
  self.forcelongdeath = 2;
}

function find_and_teleport_to_cover(coverselector) {
  var_2eeae21cc17eff42 = 0;
  frompoint = undefined;
  searchcentered = 1;
  cover_node = self findbestcovernode(coverselector, var_2eeae21cc17eff42, frompoint, searchcentered);

  if(isDefined(cover_node)) {
    coverangles = cover_node.angles;
    coverorigin = cover_node.origin;

    if(!issubstr(cover_node.type, "Prone")) {
      if(issubstr(cover_node.type, "Left")) {
        coverangles += (0, 90, 0);
      } else if(issubstr(cover_node.type, "Right") || issubstr(cover_node.type, "Cover Crouch") || issubstr(cover_node.type, "Conceal") || issubstr(cover_node.type, "Cover Stand")) {
        coverangles -= (0, 90, 0);
      }
    }

    self forceteleport(coverorigin, coverangles);
    self usecovernode(cover_node, 1);
    self setgoalnode(cover_node);
    return true;
  }

  return false;
}

function aigroundturret_requestmount(turret) {
  if(self._blackboard.aigroundturretstate == "none") {
    self._blackboard.aigroundturretstate = "turret_mount_requested";
    self._blackboard.aigroundturretref = turret;
    return true;
  }

  return false;
}

function aigroundturret_mountcompleted() {
  if(self._blackboard.aigroundturretstate == "turret_mount_requested") {
    self._blackboard.aigroundturretstate = "turret_mounted";
  }
}

function aigroundturret_cancel() {
  if(self._blackboard.aigroundturretstate != "none") {
    if(self._blackboard.aigroundturretstate == "turret_mount_requested") {
      self._blackboard.aigroundturretstate = "none";
      self._blackboard.aigroundturretref = undefined;
      return true;
    } else if(self._blackboard.aigroundturretstate == "turret_mounted") {
      self._blackboard.aigroundturretstate = "turret_dismount_requested";
      return true;
    }
  }

  return false;
}

function aigroundturret_dismountcompleted() {
  if(self._blackboard.aigroundturretstate == "turret_dismount_requested") {
    self._blackboard.aigroundturretstate = "none";
    self._blackboard.aigroundturretref = undefined;
  }
}

function ai_operate_turret(turret_operator, turret) {
  if(!isDefined(turret_operator) || !isalive(turret_operator)) {
    return;
  }

  var_21563db4c6325185 = turret_operator aigroundturret_requestmount(turret);

  if(var_21563db4c6325185) {
    turret_operator.ignoreall = 1;
    turret_operator.ignoreme = 1;
  }
}

function ai_dismount_turret(turret_operator) {
  if(!isDefined(turret_operator) || !isalive(turret_operator)) {
    return;
  }

  canceled = turret_operator aigroundturret_cancel();

  if(canceled) {
    turret_operator.ignoreall = 0;
    turret_operator.ignoreme = 0;
  }
}

function function_44db761e7499dbd(minhide, maxhide, cooldown, usesuppression) {
  if(isai(self)) {
    if(isDefined(minhide)) {
      self.vehicleminhide = minhide;
    }

    if(isDefined(maxhide)) {
      self.vehiclemaxhide = maxhide;
    }

    if(isDefined(cooldown)) {
      self.var_79f6979827ca5037 = cooldown;
    }

    if(isDefined(usesuppression)) {
      self.vehicleusesuppression = usesuppression;
    }
  }
}

function function_abdc267a17a7f5e6() {
  if(isai(self)) {
    self.vehicleminhide = undefined;
    self.vehiclemaxhide = undefined;
    self.var_79f6979827ca5037 = undefined;
    self.vehicleusesuppression = 0;
  }
}

function function_ddafb76466c3a847(strength) {
  setdvarifuninitialized(@ "scr_wind_debug", 0);
  level.currentwind = strength;
  utility::flag_wait("scriptables_ready");

  while(gettime() < 3000) {
    wait 0.1;
  }

  guys = getaiarray();
  ents = getEntArray();

  foreach(ent in ents) {
    if(ent.script_wind) {
      guys[guys.size] = ent;
    }
  }

  if(getdvarint(@ "scr_wind_debug")) {
    utility::array_thread(guys, &wind_debug);
  }

  foreach(guy in guys) {
    if(!guy isscriptable()) {
      if(getdvarint(@ "scr_wind_debug")) {
        if(isDefined(guy.model)) {
          println("<dev string:x428>" + guy.classname + "<dev string:x458>" + guy.model);
        } else {
          println("<dev string:x428>" + guy.classname);
        }
      }

      continue;
    }

    switch (level.currentwind) {
      case 0:
        guy setscriptablepartstate("wind", "0", 0);
        break;
      case 1:
        guy setscriptablepartstate("wind", "10", 0);
        break;
      case 2:
        guy setscriptablepartstate("wind", "20", 0);
        break;
      case 3:
        guy setscriptablepartstate("wind", "30", 0);
        break;
      case 4:
        guy setscriptablepartstate("wind", "40", 0);
        break;
      case 5:
        guy setscriptablepartstate("wind", "50", 0);
        break;
      case 6:
        guy setscriptablepartstate("wind", "60", 0);
        break;
      case 7:
        guy setscriptablepartstate("wind", "70", 0);
        break;
      case 8:
        guy setscriptablepartstate("wind", "80", 0);
        break;
      case 9:
        guy setscriptablepartstate("wind", "90", 0);
        break;
      case 10:
        guy setscriptablepartstate("wind", "100", 0);
        break;
      default:
        assertmsg("<dev string:x45d>" + level.currentwind + "<dev string:x46b>");
        break;
    }
  }
}

function wind_debug() {
  self endon("death");
  self notify("stop_wind_debug");
  self endon("stop_wind_debug");

  while(true) {
    print3d(self.origin, "<dev string:x47d>", (1, 1, 1), 1, 0.25, 10, 1);

    wait 0.5;
  }
}

function set_deathanim(deathanim) {
  deathxanim = undefined;

  if(isstring(deathanim)) {
    deathxanim = utility::getanim(deathanim);
  } else {
    deathxanim = deathanim;
  }

  assert(isanimation(deathxanim));
  self.deathanim = deathxanim;
  self.isdeathanimdefined = 1;
}

function clear_deathanim() {
  self.deathanim = undefined;
  self.isdeathanimdefined = 0;
}

function function_95ca99d9c8bdf6e8(death_func) {
  self.deathfunction = death_func;

  if(isDefined(death_func)) {
    self.isdeathfunctiondefined = 1;
    return;
  }

  self.isdeathfunctiondefined = 0;
}

function remove_blackboard_isburning(guy) {
  waitframe();

  if(!isDefined(guy)) {
    return;
  }

  if(isDefined(guy._blackboard)) {
    guy._blackboard.isburning = undefined;
  }
}

function function_9b5d55d642edff87(grenade, target) {
  if(isDefined(target.asmname) && !target.var_b73c033f1d73bd80 && target asmhaspainstate(target.asmname)) {
    target._blackboard.isburning = 1;
    target.burningtodeath = 0;
    target.burningdirection = undefined;
    target.semtexstuckto = 1;
    enemyright = anglestoright(target.angles);
    var_4ee847e684562943 = vectorNormalize(grenade.origin - target.origin);

    if(vectordot(enemyright, var_4ee847e684562943) > 0) {
      target.burningdirection = "right";
    } else {
      target.burningdirection = "left";
    }

    target asmevalpaintransition(target.asmname);
    level thread remove_blackboard_isburning(target);
    grenade.stucktoai = target;
  }
}

function function_7bcb54b16c07d1ec(num_points, cylinder_origin, cylinder_height, outer_radius, inner_radius, use_throttle, begin_yaw, end_yaw, up_dist = 200) {
  level endon("game_ended");
  spawn_points = [];

  if(!isDefined(use_throttle)) {
    use_throttle = 1;
  }

  throttle_count = 0;

  for(i = 0; i < num_points; i++) {
    failed_attempts = 0;

    while(failed_attempts < 5) {
      disk_center = cylinder_origin + (0, 0, cylinder_height);
      random_point = math::function_562709d61af16bd4(disk_center, outer_radius, inner_radius, begin_yaw, end_yaw);
      ground_point = utility::function_5918594658d3ffba(random_point, up_dist);

      if(isDefined(ground_point)) {
        spawn_points[spawn_points.size] = ground_point;
        break;
      } else {
        failed_attempts++;
      }

      if(use_throttle) {
        throttle_count++;

        if(throttle_count % 3 == 0) {
          waitframe();
        }
      }
    }
  }

  return spawn_points;
}

function function_38dbe69f03da5207(max_health) {
  self.maxhealth = max_health;
  callback::callback("on_ai_set_max_health");
}

function function_7497ee33e6422649(origin, team, species, subclass, max_dist, filter) {
  all_ai = [];

  if(isDefined(species)) {
    all_ai = getaispeciesarray(team, species);
  } else if(max_dist > 0) {
    all_ai = getaiarrayinradius(origin, max_dist, team);
  } else {
    all_ai = getaiarray(team);
  }

  closest_ai = undefined;
  closest_dist_sqr = isDefined(max_dist) ? squared(max_dist) : undefined;

  foreach(ai in all_ai) {
    if(isDefined(subclass) && ai.subclass != subclass) {
      continue;
    }

    if(isDefined(filter) && ![[filter]](ai)) {
      continue;
    }

    dist_sqr = distancesquared(ai.origin, origin);

    if(!isDefined(closest_dist_sqr) || dist_sqr < closest_dist_sqr) {
      closest_ai = ai;
      closest_dist_sqr = dist_sqr;
    }
  }

  return closest_ai;
}

function function_5b4f66c4d86eea91(smokeorigin, duration = 8.25, lightsmokeradius = 250, heavysmokeradius = 150, owner) {
  if(lightsmokeradius < heavysmokeradius) {
    lightsmokeradius = heavysmokeradius;
  }

  assert(!isDefined(owner) || isPlayer(owner) || isagent(owner));
  addActiveSmoke(smokeorigin, duration, lightsmokeradius, heavysmokeradius, isPlayer(owner) || isagent(owner) ? owner : undefined);
}

function mgladdactivesmoke(smokeorigin, smoketype) {
  delay = 0;
  duration = undefined;
  lightradius = undefined;
  heavyradius = undefined;

  switch (smoketype) {
    case 0:
      delay = getdvarfloat(@ "hash_3fc2c1569ac6d8e", 1);
      duration = getdvarfloat(@ "hash_1a91f99ed9835cab", 3.25);
      lightradius = getdvarint(@ "hash_a29b7c7eac63a6b0", 220);
      heavyradius = getdvarint(@ "hash_372e7fe80817d5e5", 135);
      break;
    case 1:
      delay = getdvarfloat(@ "hash_f0dc25d5e4277d02", 0);
      duration = getdvarfloat(@ "hash_314fdf30c2156f67", 7.5);
      lightradius = getdvarint(@ "hash_85175f3fbfc3ccc4", 400);
      heavyradius = getdvarint(@ "hash_ce8793c0e589ab81", 360);
      break;
    case 2:
      delay = getdvarfloat(@ "hash_ff93be3566f3591f", 0.25);
      duration = getdvarfloat(@ "hash_b322661c8cdd2910", 2.2);
      lightradius = getdvarint(@ "hash_230d4f148436bcbf", 200);
      heavyradius = getdvarint(@ "hash_25852663e024a0e6", 150);
      break;
    case 3:
      delay = getdvarfloat(@ "hash_31266fe06e688a9", 0);
      duration = getdvarfloat(@ "hash_48315e1f1bc3a24a", 18);
      lightradius = getdvarint(@ "hash_7ad30cecc84cb4d", 300);
      heavyradius = getdvarint(@ "hash_2a401f3b20b48474", 250);
      break;
    default:
      assertmsg("<dev string:x487>");
      break;
  }

  wait delay;
  function_5b4f66c4d86eea91(smokeorigin, duration, lightradius, heavyradius);
}

function ai_deathflag() {
  level.deathflags[self.script_deathflag]["ai"][self.unique_id] = self;
  ai_number = self.unique_id;
  deathflag = self.script_deathflag;

  if(isDefined(self.script_deathflag_longdeath)) {
    function_68ee59bed92c0434();
  } else {
    self waittill("death");
  }

  level.deathflags[deathflag]["ai"][ai_number] = undefined;
  update_deathflag(deathflag);
}

function function_68ee59bed92c0434() {
  self endon("death");
  self waittill("long_death");
}

function update_deathflag(deathflag) {
  level notify("updating_deathflag_" + deathflag);
  level endon("updating_deathflag_" + deathflag);
  waittillframeend();

  foreach(array in level.deathflags[deathflag]) {
    if(getarraykeys(array).size > 0) {
      return;
    }
  }

  utility::flag_set(deathflag);
}

function laser_on_thread() {
  self endon("entitydeleted");

  if(!isalive(self)) {
    return;
  }

  if(self.health <= 1) {
    return;
  }

  self laserforceon();
  self waittill("death");
  self laserforceoff();
}

function get_cover_volume_forward() {
  if(isDefined(self.goalvolumecoveryaw)) {
    return anglesToForward((0, self.goalvolumecoveryaw, 0));
  }

  return undefined;
}

function set_goal_volume(volume) {
  if(self.team == "allies") {
    self.fixednode = 0;
  }

  if(!isDefined(volume)) {
    volume = level.goalvolumes[self.script_goalvolume];

    if(!isDefined(volume)) {
      return;
    }
  }

  goal = undefined;

  if(isDefined(volume.target)) {
    node = getnode(volume.target, #targetname);
    ent = getEnt(volume.target, #targetname);
    struct = utility::getStruct(volume.target, "targetname");

    if(isDefined(node)) {
      goal = node;
      self setgoalnode(goal);
    } else if(isDefined(ent)) {
      goal = ent;
      self setgoalpos(goal.origin);
    } else if(isDefined(struct)) {
      goal = struct;
      self setgoalpos(goal.origin);
    }

    if(isDefined(goal)) {
      if(isDefined(goal.radius) && goal.radius != 0) {
        self.goalradius = goal.radius;
      }

      if(isDefined(goal.goalheight) && goal.goalheight != 0) {
        self.goalheight = goal.goalheight;
      }
    }
  }

  if(isDefined(goal)) {
    self setgoalvolume(volume);
    return;
  }

  self setgoalvolumeauto(volume, volume get_cover_volume_forward());
}

function set_grenadeweapon(types) {
  offhands = strtok(types, " ");
  self.grenadeweapon = makeweapon(offhands[randomint(offhands.size)]);
}

function function_b60d6069848011a2(name, cooldown_ms) {
  assert(isint(cooldown_ms));
  self function_786bb6aa1b76c7ee(name, gettime() + cooldown_ms);
}

function function_ac0938be41101ad6(name) {
  cooldown_timestamp = self getaiblackboarddynamic(name) ?? 0;
  cooldown = max(cooldown_timestamp - gettime(), 0);
  return cooldown;
}

function function_3972558ecac29bf2(name, cooldown_ms) {
  assert(isint(cooldown_ms));
  function_b60d6069848011a2(name, max(function_ac0938be41101ad6(name), cooldown_ms));
}

function function_e8e1e069df6dfd10(name, cooldown_ms) {
  assert(isint(cooldown_ms));
  function_b60d6069848011a2(name, min(function_ac0938be41101ad6(name), cooldown_ms));
}

function function_ee66f847eebf97cc(name, cooldown_ms) {
  assert(isint(cooldown_ms));
  function_b60d6069848011a2(name, function_ac0938be41101ad6(name) - cooldown_ms);
}

function is_warlord() {
  return isDefined(self.subclass) && issubstr(self.subclass, "warlord");
}

function function_9c67144145079cca() {
  if(self.aicategory == "special" || self.aicategory == "elite" || self.aicategory == "hvt" || self.aicategory == "boss" || is_warlord()) {
    return true;
  }

  return false;
}

function is_boss() {
  if(self.aicategory == "boss") {
    return true;
  }

  return false;
}

function is_floating() {
  is_floating = self.var_69623111d7e6b9a4 > 0 || self.var_ed3c19fec55b26cc > 0;
  return is_floating;
}

function should_do_immediate_ragdoll() {
  if(self.do_immediate_ragdoll) {
    return true;
  }

  if(self.forceragdollimmediate) {
    return true;
  }

  if(self.diedintransition && !isDefined(self.vehicledeathwait)) {
    return true;
  }

  return false;
}

function go_to_interaction(goto_func, node) {
  self endon("death");

  if(!node.var_433da69892ae9b9f) {
    if(isDefined(node.target)) {
      node.interactionid = getinteractionidfortargetname(node.target);
      node.interactionidarray = getinteractionidsfortargetname(node.target);
    }

    node.var_433da69892ae9b9f = 1;
  }

  var_630ad472236f172c = node.script_onlyidle && self.var_7a84781005a5b751;

  if(isDefined(node.interaction) && !isDefined(node.interactionid)) {
    angles = node.angles;

    if(!isDefined(angles)) {
      angles = (0, 0, 0);
    }

    interactiontoks = strtok(node.interaction, "+");
    interaction = utility::random(interactiontoks);
    node.interactionid = spawninteraction(interaction, node.origin, angles);
  }

  self[[goto_func]](node);
  self waittill("goal");

  if(isDefined(node.interactionidarray)) {
    node.interactionid = utility::array_random(node.interactionidarray);
  }

  if(isDefined(node.interactionid)) {
    self._blackboard.idlenode = node;

    if(getdvarint(@ "hash_75d5a192711fbacb", 0) != 0) {
      print3d(self.origin + (0, 0, randomintrange(40, 150)), "<dev string:x4c4>" + node.interactionid, (1, 1, 1), 1, 1, 1000);
    }

    interactionid = self getinteractionid();
    var_4aa98c5499f1d2c4 = self.var_e3720ab742ffee98;

    if(!isDefined(interactionid)) {
      self function_895b16b8fcd857ba(node.interactionid);
      self.interactionplayed = 1;
      self.var_e3720ab742ffee98 = 1;
    }

    self waittill("bseq_user_deleted");
    self._blackboard.idlenode = undefined;
    self.var_e3720ab742ffee98 = var_4aa98c5499f1d2c4;

    if(isDefined(node.interaction) && isDefined(node.interactionid)) {
      despawninteraction(node.interactionid);
      node.interactionid = undefined;
    }
  }
}

function function_29ab862ec4f51541(aitype_name) {
  if(!isDefined(level.var_a706785ff83cb223)) {
    level.var_a706785ff83cb223 = [];
  }

  if(!isDefined(level.var_d85265655f6db38a)) {
    level.var_d85265655f6db38a = [];
  }

  if(!isDefined(level.var_a706785ff83cb223[aitype_name])) {
    if(isaitypenamevalid(aitype_name)) {
      full_aitype_name = aitype_name;

      if(!isstartstr(full_aitype_name, "actor_")) {
        full_aitype_name = "actor_" + full_aitype_name;
      }

      aitypescriptbundle = getaitypescriptbundle(full_aitype_name);
      subclass = getscriptbundlefieldvalue(hashcat(%"hash_138dab78b1b28a0f", aitypescriptbundle.subclass), "name");
      aisettingsbundlename = aitypescriptbundle.zombieaisetting;
      aicategory = getscriptbundlefieldvalue(hashcat(%"zombieaisettings:", aisettingsbundlename), "aicategory");
      level.var_d85265655f6db38a[subclass] = aicategory;
      level.var_a706785ff83cb223[aitype_name] = subclass;
      return subclass;
    }
  }

  return level.var_a706785ff83cb223[aitype_name];
}

function function_30edc8bae00fca30(threatbias_id, threat_added) {
  assert(isxhash(threatbias_id));

  if(!isDefined(self.threatbias_stack)) {
    self.threatbias_stack = [];
  }

  initial_set = !isDefined(self.threatbias_stack[threatbias_id]) && isDefined(threat_added);

  if(initial_set || !(self.threatbias_stack[threatbias_id] === threat_added)) {
    self.threatbias_stack[threatbias_id] = threat_added;
    final_threatbias = 0;

    foreach(threatbias in self.threatbias_stack) {
      if(isDefined(threatbias)) {
        final_threatbias += threatbias;
      }
    }

    self.threatbias = final_threatbias;

    if(getdvarint(@ "debug_threatbias_stack", 0) > 0) {
      i = 0;

      foreach(threatbias_id, threatbias_score in self.threatbias_stack) {
        print3d(self.origin + (0, 0, 72 + i * 20), getxhashsourcename(threatbias_id) + "<dev string:x4e0>" + threatbias_score, (1, 0, 0), 1, 0.6);
        i += 1;
      }
    }

  }
}

function function_dd7b3233e5b07718(bnocorpse) {
  if(!isDefined(self.group)) {
    assert(self.birthtime < gettime(), "<dev string:x4e6>", "<dev string:x51a>", self.origin);
  } else {
    assert(self.birthtime < gettime(), "<dev string:x51f>" + self.group.group_name, "<dev string:x51a>", self.origin);
  }

  if(self.birthtime >= gettime()) {
    waitframe();
  }

  if(bnocorpse) {
    self.nocorpse = 1;
  }

  self.died_poorly = 1;
  self.died_poorly_health = self.health;
  self.var_70fbc1727d54c322 = 1;

  if(isDefined(self.magic_bullet_shield)) {
    stop_magic_bullet_shield();
  }

  self kill();
}

function function_4dfef669cb588e3f(ai) {
  if(ai isintraverse()) {
    return true;
  }

  if(ai function_d5dd650fd35ceafb()) {
    return true;
  }

  return false;
}