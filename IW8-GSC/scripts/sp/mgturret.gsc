/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\mgturret.gsc
***********************************************/

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
  if(getDvar("mg42") == "") {
    setDvar("mgTurret", "off");
  }

  level.magic_distance = 24;
  scripts\engine\utility::create_func_ref("turret_disableLinkedTurretAngles", &mgturret_disablelinkedturretangles);
  scripts\engine\utility::create_func_ref("turret_enableLinkedTurretAngles", &mgturret_enablelinkedturretangles);
  var0 = getEntArray("turretInfo", "targetname");

  for(var1 = 0; var1 < var0.size; var1++) {
    var0[var1] delete();
  }

  scripts\engine\utility::create_lock("mg42_drones");
  scripts\engine\utility::create_lock("mg42_drones_target_trace");
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
  var0 = getEntArray("misc_turret", "code_classname");
  var1 = [];

  foreach(var3 in var0) {
    var1 = scripts\engine\utility::array_add(var1, var3);
  }

  foreach(var6 in var1) {
    if(isDefined(var6.targetname) && var6.targetname == "zulu23_turret") {
      thread zuluinit();
    }
  }
}

function portable_mg_behavior() {
  self detach("weapon_mg42_carry", "tag_origin");
  self endon("death");
  self.goalradius = level.default_goalradius;

  if(isDefined(self.target)) {
    var0 = getnode(self.target, "targetname");

    if(isDefined(var0)) {
      if(isDefined(var0.radius)) {
        self.goalradius = var0.radius;
      }

      self setgoalnode(var0);
    }
  }

  while(!isDefined(self.node)) {
    wait 0.05;
  }

  var1 = undefined;

  if(isDefined(self.target)) {
    var0 = getnode(self.target, "targetname");
    var1 = var0;
  }

  if(!isDefined(var1)) {
    var1 = self.node;
  }

  if(!isDefined(var1)) {
    return;
  }

  if(var1.type != "Turret") {
    return;
  }

  var2 = gettakennodes();
  var2[self.node.origin + ""] = undefined;

  if(isDefined(var2[var1.origin + ""])) {
    return;
  }

  var3 = var1.turret;

  if(isDefined(var3.reserved)) {
    return;
  }

  reserve_turret(var3);

  if(var3.issetup) {
    leave_gun_and_run_to_new_spot(var3);
  } else {
    run_to_new_spot_and_setup_gun(var3);
  }

  scripts\sp\mg_penetration::gunner_think(var1.turret);
}

function mg42_trigger() {
  self waittill("trigger");
  level notify(self.targetname);
  level.mg42_trigger[self.targetname] = 1;
  self delete();
}

function mgturret_auto(var0) {
  var0 waittill("trigger");
  var1 = getaiarray("bad_guys");

  for(var2 = 0; var2 < var1.size; var2++) {
    if(isDefined(var1[var2].script_mg42auto) && var0.script_mg42auto == var1[var2].script_mg42auto) {
      var1[var2] notify("auto_ai");
    }
  }

  var3 = getspawnerarray();

  for(var2 = 0; var2 < var3.size; var2++) {
    if(isDefined(var3[var2].script_mg42auto) && var0.script_mg42auto == var3[var2].script_mg42auto) {
      var3[var2].ai_mode = "auto_ai";
    }
  }

  scripts\sp\spawner::kill_trigger(var0);
}

function mg42_suppressionfire(var0) {
  self endon("death");
  self endon("stop_suppressionFire");

  if(!isDefined(self.suppresionfire)) {
    self.suppresionfire = 1;
  }

  for(;;) {
    while(self.suppresionfire) {
      self settargetentity(var0[randomint(var0.size)]);
      wait 2 + randomfloat(2);
    }

    self cleartargetentity();

    while(!self.suppresionfire) {
      wait 1;
    }
  }
}

function manual_think(var0) {
  var1 = self.origin;
  self waittill("auto_ai");
  var0 notify("stopfiring");
  var0 setmode("auto_ai");
  var0 settargetentity(level.player);
}

function burst_fire_settings(var0) {
  if(var0 == "delay") {
    return 0.2;
  }

  if(var0 == "delay_range") {
    return 0.5;
  }

  if(var0 == "burst") {
    return 0.5;
  }

  if(var0 == "burst_fire_rate") {
    return 0.1;
  }

  return 1.5;
}

function burst_fire_unmanned() {
  self endon("death");
  self endon("stop_burst_fire_unmanned");

  if(isDefined(self.script_delay_min)) {
    var0 = self.script_delay_min;
  } else {
    var0 = burst_fire_settings("delay");
  }

  if(isDefined(self.script_delay_max)) {
    var1 = self.script_delay_max - var0;
  } else {
    var1 = burst_fire_settings("delay_range");
  }

  if(isDefined(self.script_burst_min)) {
    var2 = self.script_burst_min;
  } else {
    var2 = burst_fire_settings("burst");
  }

  if(isDefined(self.script_burst_max)) {
    var3 = self.script_burst_max - var2;
  } else {
    var3 = burst_fire_settings("burst_range");
  }

  if(isDefined(self.script_burst_fire_rate)) {
    var4 = self.script_burst_fire_rate;
  } else {
    var4 = burst_fire_settings("burst_fire_rate");
  }

  var5 = gettime();
  var6 = "start";
  jumpiffalse(isDefined(self.shell_fx)) LOC_000000d3;
  thread turret_shell_fx();

  for(;;) {
    var7 = (var5 - gettime()) * 0.001;

    if(self isfiringturret() && var7 <= 0) {
      if(var6 != "fire") {
        var6 = "fire";
        thread doshoot(var4);
      }

      var7 = var3 + randomfloat(var4);
      thread turrettimer(var7);
      self waittill("turretstatechange");
      var7 = var2 + randomfloat(var3);
      var5 = gettime() + int(var7 * 1000);
      continue;
    }

    if(var6 != "aim") {
      var6 = "aim";
    }

    thread turrettimer(var7);
    self waittill("turretstatechange");
  }
}

function doshoot(var0) {
  self endon("death");
  self endon("turretstatechange");
  var1 = 0.1;

  if(isDefined(var0)) {
    var1 = var0;
  }

  for(;;) {
    self shootturret();
    wait var1;
  }
}

function turret_shell_fx() {
  self endon("death");
  self endon("stop_burst_fire_unmanned");

  if(isDefined(self.shell_sound)) {
    self.shell_sound_enabled = 1;
  }

  for(;;) {
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
  var0 = self gettagorigin("tag_origin");
  var1 = scripts\engine\utility::drop_to_ground(var0, -30);
  var2 = var0[2] - var1[2];
  var3 = var2 / 300;
  wait var3;
  playworldsound(self.shell_sound, var1);
  wait 1;
  self.shell_sound_enabled = 1;
}

function turrettimer(var0) {
  if(var0 <= 0) {
    return;
  }

  self endon("turretstatechange");
  wait var0;

  if(isDefined(self)) {
    self notify("turretstatechange");
    return;
  }
}

function random_spread(var0) {
  self endon("death");
  self notify("stop random_spread");
  self endon("stop random_spread");
  self endon("stopfiring");
  self settargetentity(var0);

  for(;;) {
    if(isPlayer(var0)) {
      var0.origin = self.manual_target getorigin();
    } else {
      var0.origin = self.manual_target.origin;
    }

    var0.origin += (20 - randomfloat(40), 20 - randomfloat(40), 20 - randomfloat(60));
    wait 0.2;
  }
}

function mg42_firing(var0) {
  self notify("stop_using_built_in_burst_fire");
  self endon("stop_using_built_in_burst_fire");
  var0 stopfiring();

  for(;;) {
    var0 waittill("startfiring");
    thread burst_fire(var0);
    var0 startfiring();
    var0 waittill("stopfiring");
    var0 stopfiring();
  }
}

function burst_fire(var0, var1) {
  var0 endon("entitydeleted");
  var0 endon("stopfiring");
  self endon("stop_using_built_in_burst_fire");

  if(isDefined(var0.script_delay_min)) {
    var2 = var0.script_delay_min;
  } else {
    var2 = burst_fire_settings("delay");
  }

  if(isDefined(var1.script_delay_max)) {
    var3 = var1.script_delay_max - var2;
  } else {
    var3 = burst_fire_settings("delay_range");
  }

  if(isDefined(var2.script_burst_min)) {
    var4 = var2.script_burst_min;
  } else {
    var4 = burst_fire_settings("burst");
  }

  if(isDefined(var2.script_burst_max)) {
    var5 = var2.script_burst_max - var4;
  } else {
    var5 = burst_fire_settings("burst_range");
  }

  for(;;) {
    var3 startfiring();

    if(isDefined(var3)) {
      thread random_spread(var3);
    }

    wait var5 + randomfloat(var5);
    var3 stopfiring();
    wait var4 + randomfloat(var4);
  }
}

function _spawner_mg42_think() {
  if(!isDefined(self.flagged_for_use)) {
    self.flagged_for_use = 0;
  }

  if(!isDefined(self.targetname)) {
    return;
  }

  var0 = getnode(self.targetname, "target");

  if(!isDefined(var0)) {
    return;
  }

  if(!isDefined(var0.script_mg42)) {
    return;
  }

  if(!isDefined(var0.mg42_enabled)) {
    var0.mg42_enabled = 1;
  }

  self.script_mg42 = var0.script_mg42;
  var1 = 1;

  for(;;) {
    if(var1) {
      var1 = 0;

      if(isDefined(var0.targetname) || self.flagged_for_use) {
        self waittill("get new user");
      }
    }

    if(!var0.mg42_enabled) {
      var0 waittill("enable mg42");
      var0.mg42_enabled = 1;
    }

    var2 = [];
    var3 = getaiarray();

    for(var4 = 0; var4 < var3.size; var4++) {
      var5 = 1;

      if(isDefined(var3[var4].script_mg42) && var3[var4].script_mg42 == self.script_mg42) {
        var5 = 0;
      }

      if(isDefined(var3[var4].used_an_mg42)) {
        var5 = 1;
      }

      if(var5) {
        var2 = var3[var4];
      }
    }

    if(var2.size) {
      var3 = scripts\engine\sp\utility::get_closest_ai_exclude(var0.origin, undefined, var2);
    } else {
      var3 = scripts\engine\sp\utility::get_closest_ai(var0.origin, undefined);
    }

    var2 = undefined;

    if(isDefined(var3)) {
      var3 notify("stop_going_to_node");
      var3 thread scripts\sp\spawner::go_to_node(var0);
      var3 waittill("death");
      continue;
    }

    self waittill("get new user");
  }
}

function mg42_think() {
  if(!isDefined(self.ai_mode)) {
    self.ai_mode = "manual_ai";
  }

  var0 = getnode(self.target, "targetname");

  if(!isDefined(var0)) {
    return;
  }

  var1 = getEnt(var0.target, "targetname");
  var1.org = var0.origin;

  if(isDefined(var1.target)) {
    if(!isDefined(level.mg42_trigger) || !isDefined(level.mg42_trigger[var1.target])) {
      level.mg42_trigger[var1.target] = 0;
      thread mg42_trigger();
    }

    var2 = 1;
    goto LOC_000000a0;
  }

  var2 = 0;

  for(;;) {
    if(self.count == 0) {
      return;
    }

    var3 = undefined;

    while(!isDefined(var3)) {
      var3 = scripts\engine\sp\utility::spawn_ai();
      wait 1;
    }

    thread mg42_gunner_think(var3, var2, var2);
    thread mg42_firing(var3);
    var3 waittill("death");

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

function kill_objects(var0, var1, var2, var3) {
  var0 waittill(var1);

  if(isDefined(var2)) {
    var2 delete();
  }

  if(isDefined(var3)) {
    var3 delete();
    return;
  }
}

function mg42_gunner_think(var0, var1, var2) {
  self endon("death");

  if(var2 == "manual_ai") {
    for(;;) {
      thread mg42_gunner_manual_think(var0, var1);
      self waittill("auto_ai");
      move_use_turret(var0, "auto_ai");
      self waittill("manual_ai");
    }

    return;
  }

  for(;;) {
    move_use_turret(var0, "auto_ai", level.player);
    self waittill("manual_ai");
    thread mg42_gunner_manual_think(var0, var1);
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

function mg42_gunner_manual_think(var0, var1) {
  self endon("death");
  self endon("auto_ai");
  self.pacifist = 1;
  self setgoalpos(var0.org);
  self.goalradius = level.magic_distance;
  self waittill("goal");

  if(var1) {
    if(!level.mg42_trigger[var0.target]) {
      level waittill(var0.target);
    }
  }

  self.pacifist = 0;
  var0 setmode("auto_ai");
  var0 cleartargetentity();
  var2 = spawn("script_origin", (0, 0, 0));
  var3 = spawn("script_model", (0, 0, 0));
  var3.scale = 3;

  if(getDvar("mg42") != "off") {
    var3 setModel("temp");
  }

  thread temp_think(var3, var0);
  thread kill_objects(level, self, "death", var2);
  thread kill_objects(level, self, "auto_ai", var2);
  var0.player_target = 0;
  var4 = 0;
  var5 = getEntArray("mg42_target", "targetname");
  jumpiffalse(var5.size > 0) LOC_00000378;
  var6 = 1;
  var7 = var5[randomint(var5.size)].origin;
  thread shoot_mg42_script_targets(var5);
  move_use_turret(var0);
  self.target_entity = var2;
  var0 setmode("manual_ai");
  var0 settargetentity(var2);
  var0 notify("startfiring");
  var8 = 15;
  var9 = 0.08;
  var10 = 0.05;
  var2.origin = var5[randomint(var5.size)].origin;
  var11 = 0;

  for(;;) {
    jumpiftrue(isDefined(level.player_covertrigger)) LOC_000001de;
    var7 = var2.origin;

    if(distance(var7, var5[self.gun_targ].origin) > var8) {
      var12 = vectorNormalize(var5[self.gun_targ].origin - var7);
      var12 *= var8;
      var7 += var12;
    } else {
      self notify("next_target");
    }

    var2.origin = var7;
    wait 0.1;
  }

  for(;;) {
    var13 = 0;

    while(var13 < 1) {
      var2.origin = var7 * (1 - var13) + (level.player getorigin() + stance_num()) * var13;

      if(player_safe()) {
        var13 = 2;
      }

      wait var9;
      var13 += var10;
    }

    var14 = level.player getorigin();

    while(!player_safe()) {
      var2.origin = level.player getorigin();
      var15 = var2.origin - var14;
      var2.origin = var2.origin + var15 + stance_num();
      var14 = level.player getorigin();
      wait 0.1;
    }

    if(player_safe()) {
      var11 = gettime() + 1500 + randomfloat(4000);

      while(player_safe() && isDefined(level.player_covertrigger.target) && gettime() < var11) {
        var16 = getEntArray(level.player_covertrigger.target, "targetname");
        var16 = var16[randomint(var16.size)];
        var2.origin = var16.origin + (randomfloat(30) - 15, randomfloat(30) - 15, randomfloat(40) - 60);
        wait 0.1;
      }
    }

    self notify("next_target");

    while(player_safe()) {
      var7 = var2.origin;

      if(distance(var7, var5[self.gun_targ].origin) > var8) {
        var12 = vectorNormalize(var5[self.gun_targ].origin - var7);
        var12 *= var8;
        var7 += var12;
      } else {
        self notify("next_target");
      }

      var2.origin = var7;
      wait 0.1;
    }
  }

  return;
}

function shoot_mg42_script_targets(var0) {
  self endon("death");

  for(;;) {
    var1 = [];

    for(var2 = 0; var2 < var0.size; var2++) {
      var1 = 0;
    }

    for(var2 = 0; var2 < var0.size; var2++) {
      self.gun_targ = randomint(var0.size);
      self waittill("next_target");

      while(var1[self.gun_targ]) {
        self.gun_targ++;

        if(self.gun_targ >= var0.size) {
          self.gun_targ = 0;
        }
      }

      var1 = 1;
    }
  }
}

function move_use_turret(var0, var1, var2) {
  self setgoalpos(var0.org);
  self.goalradius = level.magic_distance;
  self waittill("goal");

  if(isDefined(var1) && var1 == "auto_ai") {
    var0 setmode("auto_ai");

    if(isDefined(var2)) {
      var0 settargetentity(var2);
    } else {
      var0 cleartargetentity();
    }
  }

  self useturret(var0);
}

function temp_think(var0, var1) {
  if(getDvar("mg42") == "off") {
    return;
  }

  self.targent = self;

  for(;;) {
    self.origin = var1.origin;
    wait 0.1;
  }
}

function turret_think(var0) {
  var1 = getEnt(var0.auto_mg42_target, "targetname");
  var2 = 0.5;

  if(isDefined(var1.script_turret_reuse_min)) {
    var2 = var1.script_turret_reuse_min;
  }

  var3 = 2;

  if(isDefined(var1.script_turret_reuse_max)) {
    var2 = var1.script_turret_reuse_max;
  }

  for(;;) {
    var1 waittill("turret_deactivate");
    wait var2 + randomfloat(var3 - var2);

    while(!isturretactive(var1)) {
      turret_find_user(var0, var1);
      wait 1;
    }
  }
}

function turret_find_user(var0, var1) {
  var2 = getaiarray();

  for(var3 = 0; var3 < var2.size; var3++) {
    if(var2[var3] isingoal(var0.origin) && var2[var3] canuseturret(var1)) {
      var4 = var2[var3].keepclaimednodeifvalid;
      var2[var3].keepclaimednodeifvalid = 0;

      if(!var2[var3] usecovernode(var0)) {
        var2[var3].keepclaimednodeifvalid = var4;
      }
    }
  }
}

function setdifficulty() {
  init_mgturretsettings();
  var0 = getEntArray("misc_turret", "code_classname");
  var1 = scripts\common\utility::getdifficulty();

  for(var2 = 0; var2 < var0.size; var2++) {
    if(isDefined(var0[var2].script_skilloverride)) {
      switch (var0[var2].script_skilloverride) {
        case "easy":
          var1 = "easy";
          break;
        case "medium":
          var1 = "medium";
          break;
        case "hard":
          var1 = "hard";
          break;
        case "fu":
          var1 = "fu";
          break;
        default:
          continue;
      }
    }

    mg42_setdifficulty(var0[var2], var1);
  }
}

function mg42_setdifficulty(var0, var1) {
  var0.convergencetime = level.mgturretsettings[var1]["convergenceTime"];
  var0.suppressiontime = level.mgturretsettings[var1]["suppressionTime"];
  var0.accuracy = level.mgturretsettings[var1]["accuracy"];
  var0.aispread = level.mgturretsettings[var1]["aiSpread"];
  var0.playerspread = level.mgturretsettings[var1]["playerSpread"];
}

function mg42_target_drones(var0, var1, var2) {
  if(!isDefined(var2)) {
    var2 = 0.88;
  }

  self endon("death");
  self notify("stop_mg42_target_drones");
  self endon("stop_mg42_target_drones");
  self.dronefailed = 0;

  if(!isDefined(self.script_fireondrones)) {
    self.script_fireondrones = 0;
  }

  if(!isDefined(var0)) {
    var0 = 0;
  }

  self setmode("manual_ai");
  var3 = scripts\common\utility::getdifficulty();

  if(!isDefined(level.drones)) {
    var4 = 1;
    goto LOC_00000068;
  }

  for(var4 = 0;; var4 = 1) {
    if(var4) {
      if(isDefined(self.drones_targets_sets_to_default)) {
        self setmode(self.defaultonmode);
      } else if(var1) {
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

    if(!var1) {
      var5 = self getturretowner();

      if(!isalive(var5) || isPlayer(var5)) {
        wait 0.05;
        continue;
      } else {
        var2 = var5.team;
      }
    } else {
      var5 = undefined;
    }

    if(var2 == "allies") {
      var6 = "axis";
    } else {
      var6 = "allies";
    }

    while(level.drones[var6].lastindex) {
      scripts\engine\utility::lock("mg42_drones");

      if(!level.drones[var6].lastindex) {
        scripts\engine\utility::unlock("mg42_drones");
        break;
      }

      var7 = get_bestdrone(var6, var3);
      scripts\engine\utility::unlock("mg42_drones");

      if(!isDefined(self.script_fireondrones) || !self.script_fireondrones) {
        wait 0.05;
        break;
      }

      if(!isDefined(var7)) {
        wait 0.05;
        break;
      }

      if(isDefined(self.anim_wait_func)) {
        [[self.anim_wait_func]]();
      }

      if(var1) {
        self setmode("manual");
      } else {
        self setmode("manual_ai");
      }

      self settargetentity(var7, (0, 0, 32));
      drone_target(var7, 1, var3);
      self cleartargetentity();
      self stopfiring();

      if(!var1 && !(isDefined(self getturretowner()) && self getturretowner() == var5)) {
        break;
      }
    }

    self.convergencetime = self.oldconvergencetime;
    self.oldconvergencetime = undefined;
    self cleartargetentity();
    self stopfiring();

    if(level.drones[var6].lastindex) {
      var4 = 0;
      continue;
    }
  }
}

function drone_target(var0, var1, var2) {
  self endon("death");
  var0 endon("death");
  var3 = gettime() + var1 * 1000;
  var4 = 0;

  while(var3 > gettime() || var4) {
    scripts\engine\utility::lock("mg42_drones_target_trace");
    var5 = self getturrettarget(1);

    if(!scripts\engine\trace::_bullet_trace_passed(self gettagorigin("tag_flash"), var0.origin + (0, 0, 40), 0, var0)) {
      scripts\engine\utility::unlock("mg42_drones_target_trace");
      break;
    } else if(isDefined(var5) && distance(var5.origin, self.origin) < distance(self.origin, var0.origin)) {
      scripts\engine\utility::unlock("mg42_drones_target_trace");
      break;
    }

    if(!var4) {
      self startfiring();
      var4 = 1;
    }

    scripts\engine\utility::unlock_wait("mg42_drones_target_trace");
  }

  self stopfiring();
  scripts\engine\sp\utility::structarray_shuffle(level.drones[var0.team], 1);
}

function get_bestdrone(var0, var1) {
  if(level.drones[var0].lastindex < 1) {
    return;
  }

  var2 = undefined;
  var3 = anglesToForward(self.angles);

  for(var4 = 0; var4 < level.drones[var0].lastindex; var4++) {
    if(!isDefined(level.drones[var0].array[var4])) {
      continue;
    }

    var5 = vectortoangles(level.drones[var0].array[var4].origin - self.origin);
    var6 = anglesToForward(var5);

    if(vectordot(var3, var6) < var1) {
      continue;
    }

    var2 = level.drones[var0].array[var4];

    if(!scripts\engine\trace::_bullet_trace_passed(self gettagorigin("tag_flash"), var2 getcentroid(), 0, var2)) {
      var2 = undefined;
      continue;
    }

    break;
  }

  var7 = self getturrettarget(1);

  if(!isDefined(self.prefers_drones)) {
    if(isDefined(var2) && isDefined(var7) && distancesquared(self.origin, var7.origin) < distancesquared(self.origin, var2.origin)) {
      var2 = undefined;
    }
  }

  return var2;
}

function saw_mgturretlink() {
  var0 = getEntArray("misc_turret", "code_classname");
  var1 = [];

  foreach(var3 in var0) {
    if(isDefined(var3.targetname)) {
      continue;
    }

    if(isDefined(var3.script_turret_autonomous) && var3.script_turret_autonomous) {
      continue;
    }

    if(isDefined(var3.isvehicleattached)) {
      continue;
    }

    var1 = var3;
  }

  if(!var1.size) {
    return;
  }

  var5 = var1;

  foreach(var7 in var1) {
    foreach(var9 in getnodesinradius(var7.origin, 50, 0)) {
      if(var9.type == "Path") {
        continue;
      }

      if(var9.type == "Begin") {
        continue;
      }

      if(var9.type == "End") {
        continue;
      }

      var10 = anglesToForward((0, var9.angles[1], 0));
      var11 = anglesToForward((0, var7.angles[1], 0));
      var12 = vectordot(var10, var11);

      if(var12 < 0.9) {
        continue;
      }

      var5 = scripts\engine\utility::array_remove(var5, var7);
      var9.turretinfo = spawn("script_origin", var7.origin);
      var9.turretinfo.angles = var7.angles;
      var9.turretinfo.node = var9;
      var9.turretinfo.leftarc = 45;
      var9.turretinfo.rightarc = 45;
      var9.turretinfo.toparc = 15;
      var9.turretinfo.bottomarc = 15;

      if(isDefined(var7.leftarc)) {
        var9.turretinfo.leftarc = min(var7.leftarc, 45);
      }

      if(isDefined(var7.rightarc)) {
        var9.turretinfo.rightarc = min(var7.rightarc, 45);
      }

      if(isDefined(var7.toparc)) {
        var9.turretinfo.toparc = min(var7.toparc, 15);
      }

      if(isDefined(var7.bottomarc)) {
        var9.turretinfo.bottomarc = min(var7.bottomarc, 15);
      }

      var7 delete();
    }
  }
}

function auto_mgturretlink() {
  var0 = getEntArray("misc_turret", "code_classname");
  var1 = [];

  foreach(var3 in var0) {
    if(!isDefined(var3.targetname) || tolower(var3.targetname) != "auto_mgturret") {
      continue;
    }

    if(!isDefined(var3.export)) {
      continue;
    }

    if(!isDefined(var3.script_dont_link_turret)) {
      var1 = var3;
    }
  }

  if(!var1.size) {
    return;
  }

  var5 = var1;

  foreach(var7 in var1) {
    foreach(var9 in getnodesinradius(var7.origin, 70)) {
      if(var9.type == "Path") {
        continue;
      }

      if(var9.type == "Begin") {
        continue;
      }

      if(var9.type == "End") {
        continue;
      }

      var10 = anglesToForward((0, var9.angles[1], 0));
      var11 = anglesToForward((0, var7.angles[1], 0));
      var12 = vectordot(var10, var11);

      if(var12 < 0.9) {
        continue;
      }

      var5 = scripts\engine\utility::array_remove(var5, var7);
      var9.turret = var7;
      var7.node = var9;
      var7.issetup = 1;
    }
  }
}

function save_turret_sharing_info() {
  self.shared_turrets = [];
  self.shared_turrets["connected"] = [];
  self.shared_turrets["ambush"] = [];

  if(!isDefined(self.export)) {
    return;
  }

  if(!isDefined(level.shared_portable_turrets)) {
    level.shared_portable_turrets = [];
  }

  level.shared_portable_turrets[self.export] = self;

  if(isDefined(self.script_turret_share)) {
    var0 = strtok(self.script_turret_share, " ");

    for(var1 = 0; var1 < var0.size; var1++) {
      self.shared_turrets["connected"][var0[var1]] = 1;
    }
  }

  if(isDefined(self.script_turret_ambush)) {
    var0 = strtok(self.script_turret_ambush, " ");

    for(var1 = 0; var1 < var0.size; var1++) {
      self.shared_turrets["ambush"][var0[var1]] = 1;
    }

    return;
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
  var0 = spawn("script_model", (0, 0, 0));
  var0.origin = self gettagorigin(level.portable_mg_gun_tag);
  var0.angles = self gettagangles(level.portable_mg_gun_tag);
  var0 setModel(self.turretmodel);
  var1 = anglesToForward(self.angles);
  var1 *= 100;
  var0 movegravity(var1, 0.5);
  self detach(self.turretmodel, level.portable_mg_gun_tag);
  self.turretmodel = undefined;
  wait 0.7;
  var0 delete();
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

function update_enemy_target_pos_while_running(var0) {
  self endon("death");
  self endon("end_mg_behavior");
  self endon("stop_updating_enemy_target_pos");

  for(;;) {
    self waittill("saw_enemy");
    var0.origin = self.last_enemy_sighting_position;
  }
}

function move_target_pos_to_new_turrets_visibility(var0, var1) {
  self endon("death");
  self endon("end_mg_behavior");
  self endon("stop_updating_enemy_target_pos");
  var2 = self.turret.origin + (0, 0, 16);
  var3 = var1.origin + (0, 0, 16);

  for(;;) {
    wait 0.05;

    if(sighttracepassed(var0.origin, var3, 0, undefined)) {
      continue;
    }

    var4 = vectortoangles(var2 - var0.origin);
    var5 = anglesToForward(var4);
    var5 *= 8;
    var0.origin += var5;
  }
}

function record_bread_crumbs_for_ambush(var0) {
  self endon("death");
  self endon("end_mg_behavior");
  self endon("stop_updating_enemy_target_pos");
  var0.bread_crumbs = [];

  for(;;) {
    var0.bread_crumbs[var0.bread_crumbs.size] = self.origin + (0, 0, 50);
    wait 0.35;
  }
}

function aim_turret_at_ambush_point_or_visible_enemy(var0, var1) {
  if(!isalive(self.current_enemy) && self cansee(self.current_enemy)) {
    var1.origin = self.last_enemy_sighting_position;
    return;
  }

  var2 = anglesToForward(var0.angles);

  for(var3 = var1.bread_crumbs.size - 3; var3 >= 0; var3--) {
    var4 = var1.bread_crumbs[var3];
    var5 = vectorNormalize(var4 - var0.origin);
    var6 = vectordot(var2, var5);

    if(var6 < 0.75) {
      continue;
    }

    var1.origin = var4;

    if(sighttracepassed(var0.origin, var4, 0, undefined)) {
      continue;
    }

    break;
  }
}

function find_a_new_turret_spot(var0) {
  var1 = get_portable_mg_spot(var0);
  var2 = var1["spot"];
  var3 = var1["type"];

  if(!isDefined(var2)) {
    return;
  }

  reserve_turret(var2);
  thread update_enemy_target_pos_while_running(var0);
  thread move_target_pos_to_new_turrets_visibility(var0, var2);

  if(var3 == "ambush") {
    thread record_bread_crumbs_for_ambush(var0);
  }

  if(var2.issetup) {
    leave_gun_and_run_to_new_spot(var2);
  } else {
    pickup_gun(var2);
    run_to_new_spot_and_setup_gun(var2);
  }

  self notify("stop_updating_enemy_target_pos");

  if(var3 == "ambush") {
    aim_turret_at_ambush_point_or_visible_enemy(var2, var0);
  }

  var2 settargetentity(var0);
}

function snap_lock_turret_onto_target(var0) {
  var0 setmode("manual");
  wait 0.5;
  var0 setmode("manual_ai");
}

function leave_gun_and_run_to_new_spot(var0) {
  self stopuseturret();
  scripts\anim\shared::placeweaponon(self.primaryweapon, "none");
  var1 = get_turret_setup_anim(var0);
  var2 = getstartorigin(var0.origin, var0.angles, var1);
  self waittill("runto_arrived");
  use_the_turret(var0);
}

function pickup_gun(var0) {
  self stopuseturret();
  hide_turret(self.turret);
}

function get_turret_setup_anim(var0) {
  var1 = [];
  GscBinSkip0(0x2e, "saw_bipod_stand", level.mg_animmg["bipod_stand_setup"]);
}

function run_to_new_spot_and_setup_gun(var0) {
  var1 = self.health;
  var0 endon("turret_deactivate");
  self.mg42 = var0;
  self endon("death");
  self endon("dropped_gun");
  var2 = get_turret_setup_anim(var0);
  self.turretmodel = "weapon_mg42_carry";
  self notify("kill_get_gun_back_on_killanimscript_thread");
  scripts\anim\shared::placeweaponon(self.weapon, "none");

  if(self isbadguy()) {
    self.health = 1;
  }

  self attach(self.turretmodel, level.portable_mg_gun_tag);
  thread turretdeathdetacher();
  var3 = getstartorigin(var0.origin, var0.angles, var2);
  wait 0.05;
  scripts\engine\utility::clear_exception("move");
  scripts\engine\sp\utility::set_exception("cover_crouch", &hold_indefintely);

  while(distance(self.origin, var3) > 16) {
    wait 0.05;
  }

  self notify("kill_turret_detach_thread");

  if(self isbadguy()) {
    self.health = var1;
  }

  if(soundexists("weapon_setup")) {
    playworldsound("weapon_setup", self.origin);
  }

  self animScripted("setup_done", var0.origin, var0.angles, var2);
  restoredefaults();
  self waittillmatch("setup_done", "end");
  var0 notify("restore_default_drop_pitch");
  show_turret(var0);
  scripts\anim\shared::placeweaponon(self.primaryweapon, "right");
  use_the_turret(var0);
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
    scripts\engine\utility::clear_exception("move");
    return;
  }

  var0 = find_connected_turrets("connected");
  var1 = var0["spots"];

  if(!var1.size) {
    scripts\engine\utility::clear_exception("move");
    return;
  }

  var2 = self.node;

  if(!isDefined(var2) || !scripts\engine\utility::array_contains(var1, var2)) {
    var3 = gettakennodes();

    for(var4 = 0; var4 < var1.size; var4++) {
      var2 = scripts\engine\utility::random(var1);

      if(isDefined(var3[var2.origin + ""])) {
        return;
      }
    }
  }

  var5 = var2.turret;

  if(isDefined(var5.reserved)) {
    return;
  }

  reserve_turret(var5);

  if(var5.issetup) {
    leave_gun_and_run_to_new_spot(var5);
  } else {
    run_to_new_spot_and_setup_gun(var5);
  }

  scripts\sp\mg_penetration::gunner_think(var2.turret);
}

function use_the_turret(var0) {
  var1 = self useturret(var0);

  if(var1) {
    scripts\engine\sp\utility::set_exception("move", &turret_user_moves);
    self.turret = var0;
    thread mg42_firing(var0);
    var0 setmode("manual_ai");
    thread restorepitch();
    self.turret = var0;
    var0.owner = self;
    return 1;
  }

  var0 restoredefaultdroppitch();
  return 0;
}

function get_portable_mg_spot(var0) {
  var1 = [];
  GscBinSkip0(0x2e, var1.size, &find_different_way_to_attack_last_seen_position);
}

function gettakennodes() {
  var0 = [];
  var1 = getaiarray();

  for(var2 = 0; var2 < var1.size; var2++) {
    if(!isDefined(var1[var2].node)) {
      continue;
    }

    var0 = 1;
  }

  return var0;
}

function find_connected_turrets(var0) {
  var1 = level.shared_portable_turrets;
  var2 = [];
  var3 = getarraykeys(var1);
  var4 = gettakennodes();
  var4[self.node.origin + ""] = undefined;

  for(var5 = 0; var5 < var3.size; var5++) {
    var6 = var3[var5];

    if(var1[var6] == self.turret) {
      continue;
    }

    var7 = getarraykeys(self.turret.shared_turrets[var0]);

    for(var8 = 0; var8 < var7.size; var8++) {
      if(var1[var6].export+"" != var7[var8]) {
        continue;
      }

      if(isDefined(var1[var6].reserved)) {
        continue;
      }

      if(isDefined(var4[var1[var6].node.origin + ""])) {
        continue;
      }

      if(distance(self.goalpos, var1[var6].origin) > self.goalradius) {
        continue;
      }

      var2 = var1[var6];
    }
  }

  var9 = [];
  GscBinSkip0(0x2e, "type", var0);
}

function find_good_ambush_spot(var0) {
  return find_connected_turrets("ambush");
}

function find_different_way_to_attack_last_seen_position(var0) {
  var1 = find_connected_turrets("connected");
  var2 = var1["spots"];

  if(!var2.size) {
    return;
  }

  var3 = [];

  for(var4 = 0; var4 < var2.size; var4++) {
    if(!scripts\engine\utility::within_fov(var2[var4].origin, var2[var4].angles, var0.origin, 0.75)) {
      continue;
    }

    if(!sighttracepassed(var0.origin, var2[var4].origin + (0, 0, 16), 0, undefined)) {
      continue;
    }

    var3 = var2[var4];
  }

  var1 = var3;
  return var1;
}

function portable_mg_spot() {
  save_turret_sharing_info();
  var0 = 1;
  self.issetup = 1;
  self.reserved = undefined;

  if(isDefined(self.isvehicleattached)) {
    return;
  }

  if(self.spawnflags &var0) {
    return;
  }

  hide_turret();
}

function hide_turret() {
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
  self.issetup = 1;
  thread stop_mg_behavior_if_flanked();
}

function stop_mg_behavior_if_flanked() {
  self endon("stop_checking_for_flanking");
  self waittill("turret_deactivate");

  if(isalive(self.owner)) {
    self.owner notify("end_mg_behavior");
    return;
  }
}

function turret_is_mine(var0) {
  var1 = var0 getturretowner();

  if(!isDefined(var1)) {
    return false;
  }

  return var1 == self;
}

function end_turret_reservation(var0) {
  waittill_turret_is_released(var0);
  var0.reserved = undefined;
}

function waittill_turret_is_released(var0) {
  var0 endon("turret_deactivate");
  self endon("death");
  self waittill("end_mg_behavior");
}

function reserve_turret(var0) {
  var0.reserved = self;
  thread end_turret_reservation(var0);
}

function zuluinit() {
  thread turret_watchplayeruse(turret_getplayerusefuncs());
  thread turret_impactquakes();
}

function turret_impactquakes() {
  self endon("death");

  for(;;) {
    self waittill("missile_fire", var0);
    thread missile_explode_quakes();
  }
}

function missile_explode_quakes() {
  self waittill("explode", var0);
  earthquake(0.18, 0.75, var0, 500);
  playrumbleonposition("artillery_rumble_light", var0);
}

function turret_getplayerusefuncs() {
  var0 = spawnStruct();
  var0.startfuncs = [ &turretplayerstartfunc];
  var0.stopfuncs = [ &turretplayerstopfunc];
  return var0;
}

function turret_watchplayeruse(var0) {
  self endon("death");

  for(;;) {
    self waittill("turretownerchange");
    var1 = self getturretowner();

    if(isDefined(var1) && isPlayer(var1)) {
      foreach(var3 in var0.startfuncs) {
        self thread[[var3]]();
      }

      var1 notify("turret_mount");
      self waittill("turretownerchange");

      foreach(var6 in var0.stopfuncs) {
        self thread[[var6]]();
      }

      var1 notify("turret_dismount");
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