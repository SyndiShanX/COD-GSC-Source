/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\youngblood_util.gsc
*****************************************************/

trigger_moveto(var_0) {
  if(!isDefined(level.mover_candidates)) {
    level.mover_candidates = getEntArray("script_brushmodel", "classname");
    level.mover_candidates = common_scripts\utility::array_combine(level.mover_candidates, getEntArray("script_model", "classname"));
    level.mover_object = common_scripts\utility::spawn_tag_origin();
  }

  var_1 = getEntArray(self.target, "targetname");
  common_scripts\utility::array_thread(var_1, ::moveto_volume_think, self);
}

moveto_volume_think(var_0) {
  var_1 = [];
  var_2 = self;

  foreach(var_4 in level.mover_candidates) {
    level.mover_object.origin = var_4.origin;

    if(level.mover_object istouching(var_2)) {
      level.mover_candidates = common_scripts\utility::array_remove(level.mover_candidates, var_4);
      var_1 = common_scripts\utility::array_add(var_1, var_4);
    }
  }

  var_6 = undefined;

  foreach(var_4 in var_1) {
    if(isDefined(var_4.script_noteworthy) && var_4.script_noteworthy == "mover" || isDefined(var_4.targetname) && var_4.targetname == "mover") {
      var_6 = var_4;
      break;
    }
  }

  foreach(var_4 in var_1) {
    if(var_6 != var_4)
      var_4 linkto(var_6);
  }

  var_11 = common_scripts\utility::get_target_ent();

  if(!isDefined(var_11.angles))
    var_11.angles = (0, 0, 0);

  var_6.origin = var_11.origin;
  var_6.angles = var_11.angles;
  var_12 = undefined;
  var_13 = 5;
  var_14 = 0;
  var_15 = 0;

  if(isDefined(var_11.script_duration))
    var_13 = var_11.script_duration;

  if(isDefined(var_11.script_accel))
    var_14 = var_11.script_accel;

  if(isDefined(var_11.script_decel))
    var_15 = var_11.script_decel;

  if(isDefined(var_11.script_earthquake))
    var_12 = var_11.script_earthquake;

  var_0 waittill("trigger");
  var_11 maps\_utility::script_delay();

  if(isDefined(var_11.target))
    var_11 = var_11 common_scripts\utility::get_target_ent();
  else
    var_11 = undefined;

  while(isDefined(var_11)) {
    if(isDefined(var_12)) {
      if(issubstr(var_12, "constant"))
        var_6 thread constant_quake(var_12);
    }

    if(!isDefined(var_11.angles))
      var_11.angles = (0, 0, 0);

    var_6 moveto_rotateto(var_11, var_13, var_14, var_15);
    var_6 notify("stop_constant_quake");
    var_13 = 5;
    var_14 = 0;
    var_15 = 0;
    var_12 = undefined;
    var_11 maps\_utility::script_delay();

    if(isDefined(var_11.script_duration))
      var_13 = var_11.script_duration;

    if(isDefined(var_11.script_accel))
      var_14 = var_11.script_accel;

    if(isDefined(var_11.script_decel))
      var_15 = var_11.script_decel;

    if(isDefined(var_11.script_earthquake))
      var_12 = var_11.script_earthquake;

    var_16 = var_11 common_scripts\utility::get_linked_ents();

    if(var_16.size > 0) {
      if(issubstr(var_16[0].classname, "trigger"))
        var_16[0] waittill("trigger");
    }

    if(isDefined(var_11.target)) {
      var_11 = var_11 common_scripts\utility::get_target_ent();
      continue;
    }

    var_11 = undefined;
  }
}

trigger_sort_and_attach(var_0) {
  if(!isDefined(level.mover_candidates)) {
    level.mover_candidates = getEntArray("script_brushmodel", "classname");
    level.mover_candidates = common_scripts\utility::array_combine(level.mover_candidates, getEntArray("script_model", "classname"));
    level.mover_object = common_scripts\utility::spawn_tag_origin();
  }

  var_1 = getEntArray(self.target, "targetname");
  common_scripts\utility::array_thread(var_1, ::attach_in_volume, self);
}

attach_in_volume(var_0) {
  var_1 = [];
  var_2 = self;

  foreach(var_4 in level.mover_candidates) {
    level.mover_object.origin = var_4.origin;

    if(level.mover_object istouching(var_2)) {
      level.mover_candidates = common_scripts\utility::array_remove(level.mover_candidates, var_4);
      var_1 = common_scripts\utility::array_add(var_1, var_4);
    }
  }

  var_6 = undefined;

  foreach(var_4 in var_1) {
    if(isDefined(var_4.script_noteworthy) && var_4.script_noteworthy == "mover" || isDefined(var_4.targetname) && var_4.targetname == "link_to_trigger") {
      var_6 = var_4;
      break;
    }
  }

  foreach(var_4 in var_1) {
    if(var_6 != var_4)
      var_4 linkto(var_6);
  }
}

constant_quake(var_0) {
  self endon("stop_constant_quake");

  for(;;) {
    thread common_scripts\utility::do_earthquake(var_0, self.origin);
    wait(randomfloatrange(0.1, 0.2));
  }
}

moveto_rotateto_speed(var_0, var_1, var_2, var_3) {
  var_4 = var_0.origin;
  var_5 = self.origin;
  var_6 = distance(var_5, var_4);
  var_7 = var_6 / var_1;

  if(!isDefined(var_2))
    var_2 = 0;

  if(!isDefined(var_3))
    var_3 = 0;

  self rotateto(var_0.angles, var_7, var_7 * var_2, var_7 * var_3);
  self moveto(var_4, var_7, var_7 * var_2, var_7 * var_3);
  self waittill("movedone");
}

moveto_rotateto(var_0, var_1, var_2, var_3) {
  self moveto(var_0.origin, var_1, var_2, var_3);
  self rotateto(var_0.angles, var_1, var_2, var_3);
  self waittill("movedone");
}

set_start_positions(var_0) {
  var_1 = common_scripts\utility::getstructarray(var_0, "targetname");

  foreach(var_3 in var_1) {
    switch (var_3.script_noteworthy) {
      case "player":
        level.player setorigin(var_3.origin);
        level.player setplayerangles(var_3.angles);
        break;
      case "hesh":
        level.hesh forceteleport(var_3.origin, var_3.angles);
        level.hesh setgoalpos(var_3.origin);

        if(isDefined(var_3.animation))
          var_3 thread maps\_anim::anim_generic(level.hesh, var_3.animation);

        if(isDefined(var_3.target)) {
          var_3 = var_3 common_scripts\utility::get_target_ent();
          level.hesh thread maps\_utility::follow_path_and_animate(var_3);
        }

        break;
      case "elias":
        level.elias forceteleport(var_3.origin, var_3.angles);
        level.elias setgoalpos(var_3.origin);

        if(isDefined(var_3.animation))
          var_3 thread maps\_anim::anim_generic(level.elias, var_3.animation);

        if(isDefined(var_3.target)) {
          var_3 = var_3 common_scripts\utility::get_target_ent();
          level.elias thread maps\_utility::follow_path_and_animate(var_3);
        }

        break;
    }
  }
}

spawn_hesh() {
  var_0 = common_scripts\utility::get_target_ent("hesh");
  level.hesh = var_0 maps\_utility::spawn_ai(1);
  level.hesh thread maps\_utility::deletable_magic_bullet_shield();
  level.hesh.animname = "hesh";
  level.hesh set_ignore_states();
  level.hesh maps\_utility::set_force_color("r");
  level.hesh.alertlevel = "noncombat";
  level.hesh set_move_rate(0.98);
  level.hesh maps\_utility::walkdist_zero();
  level.hesh.goalradius = 64;
  level.hesh.turnrate = 0.2;
}

spawn_elias() {
  var_0 = common_scripts\utility::get_target_ent("elias");
  level.elias = var_0 maps\_utility::spawn_ai(1);
  level.elias thread maps\_utility::deletable_magic_bullet_shield();
  level.elias.animname = "elias";
  level.elias set_ignore_states();
  level.elias maps\_utility::set_force_color("o");
  level.elias.alertlevel = "noncombat";
  level.elias set_move_rate(1);
  level.elias maps\_utility::walkdist_zero();
  level.elias.goalradius = 64;
  level.elias.turnrate = 0.2;
}

set_ignore_states() {
  maps\_utility::set_ignoreall(1);
  maps\_utility::set_ignoreme(1);
}

clear_ignore_states() {
  maps\_utility::set_ignoreall(0);
  maps\_utility::set_ignoreall(0);
}

set_move_rate(var_0) {
  self.moveplaybackrate = var_0;
  self.movetransitionrate = var_0;
}

enable_team_color() {
  if(isDefined(level.hesh))
    level.hesh maps\_utility::enable_ai_color();

  if(isDefined(level.elias))
    level.elias maps\_utility::enable_ai_color();
}

disable_team_color() {
  if(isDefined(level.hesh))
    level.hesh maps\_utility::disable_ai_color();

  if(isDefined(level.elias))
    level.elias maps\_utility::disable_ai_color();
}

viewmodel_anim_on() {
  level.player allowstand(1);
  level.player allowcrouch(0);
  level.player allowprone(0);
  level.player allowjump(0);
  level.player allowmelee(0);
  level.player allowsprint(0);
}

viewmodel_anim_off() {
  level.player allowstand(1);
  level.player allowcrouch(1);
  level.player allowprone(1);
  level.player allowjump(1);
  level.player allowsprint(1);
}

anim_generic_reach_and_animate(var_0, var_1, var_2, var_3) {
  maps\_anim::anim_generic_reach(var_0, var_1, var_2);
  self notify("starting_anim");
  var_0 notify("starting_anim");

  if(isDefined(var_3))
    maps\_anim::anim_generic_custom_animmode(var_0, var_3, var_1, var_2);
  else
    maps\_anim::anim_generic(var_0, var_1, var_2);
}

disable_awareness() {
  self.awareness = 0;
  self.ignoreall = 1;
  self.dontmelee = 1;
  maps\_utility::disable_surprise();
  self.ignorerandombulletdamage = 1;
  maps\_utility::disable_bulletwhizbyreaction();
  maps\_utility::disable_pain();
  maps\_utility::disable_danger_react();
  self.grenadeawareness = 0;
  self.ignoreme = 1;
  maps\_utility::enable_dontevershoot();
  self.disablefriendlyfirereaction = 1;
}

enable_awareness() {
  self.awareness = 1;
  self.ignoreall = 0;
  self.dontmelee = undefined;
  maps\_utility::enable_surprise();
  self.ignorerandombulletdamage = 0;
  maps\_utility::enable_bulletwhizbyreaction();
  maps\_utility::enable_pain();
  maps\_utility::enable_danger_react(3);
  self.grenadeawareness = 1;
  self.ignoreme = 0;
  maps\_utility::disable_dontevershoot();
  self.disablefriendlyfirereaction = undefined;
}

yb_player_speed_percent(var_0, var_1) {
  level.saved_speed_percent = var_0;
  var_2 = int(getdvar("g_speed"));

  if(!isDefined(level.player.g_speed))
    level.player.g_speed = var_2;

  var_3 = int(level.player.g_speed * var_0 * 0.01);
  level.player maps\_utility::player_speed_set(var_3, var_1);
}

trigger_activate_targetname_safe(var_0) {
  var_1 = getent(var_0, "targetname");

  if(isDefined(var_1))
    var_1 notify("trigger");
}

bloom_fadein() {
  setblur(10, 0);
  thread maps\_utility::vision_set_fog_changes("coup_sunblind", 0);
  wait 0.5;
  setblur(0, 2);
  thread maps\_utility::vision_set_fog_changes("ygb_chaos_a", 3);
}

bloom_fadeout() {
  thread maps\_utility::vision_set_fog_changes("coup_sunblind", 0);
}

reset_player_sprint_speed_scale() {
  set_player_sprint_speed_scale(1.5);
}

set_player_sprint_speed_scale(var_0) {
  var_0 = gt_op(var_0, 0);
  setsaveddvar("player_sprintSpeedScale", var_0);
}

gt_op(var_0, var_1, var_2) {
  if(isDefined(var_0) && isDefined(var_1))
    return common_scripts\utility::ter_op(var_0 > var_1, var_0, var_1);

  if(isDefined(var_0) && !isDefined(var_1))
    return var_0;

  if(!isDefined(var_0) && isDefined(var_1))
    return var_1;

  return var_2;
}

heroes_light_earthquake(var_0) {
  level.no_tremor = 0;
  waittillframeend;
  level.player yb_player_speed_percent(25, 0.75);
  level.player playrumbleonentity("light_2s");
  earthquake(0.3, 2.5, level.player.origin, 64);
  setblur(1, 0.1);
  level.player allowsprint(0);
  level.player thread maps\_player_limp::stumble((8, 2, 7), 0.75, 2);
  wait 2;
  setblur(0, 0.1);
  level.player yb_player_speed_percent(var_0, 1);
  level.no_tremor = 1;

  if(common_scripts\utility::flag("new_treefall"))
    level.player allowsprint(1);
}

heavy_quake(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = 25;

  level.player playrumbleonentity("light_2s");
  earthquake(0.4, 2.5, level.player.origin, 512);
  level.player thread yb_player_speed_percent(var_1, 0.75);
  level.player thread maps\_player_limp::stumble((20, 5, 35), 0.75, 2);
  level.player allowsprint(0);
  wait 2;
  level.player thread yb_player_speed_percent(var_0, 1.5);

  if(common_scripts\utility::flag("new_treefall"))
    level.player allowsprint(1);
}

enable_elias_walk() {
  maps\_utility::disable_turnanims();
  maps\_utility::disable_surprise();
  self.uphill = 0;
  self.anim_blend_time_override = 0.75;
  self.pathrandompercent = 0;
  self.ignoreall = 1;
  self.ignoreme = 1;
  self.no_pistol_switch = 1;
  self.ignoresuppression = 1;
  self.dontmelee = 1;
  self.norunreload = 1;
  self.ammocheatinterval = 2000;
  self.disablebulletwhizbyreaction = 1;
  self.usechokepoints = 0;
  self.disabledoorbehavior = 1;
  self.combatmode = "no_cover";
  self.oldgrenadeawareness = self.grenadeawareness;
  self.grenadeawareness = 0;
  self.oldgrenadereturnthrow = self.nogrenadereturnthrow;
  self.nogrenadereturnthrow = 1;
  self.awareness = 0;
  maps\_utility::disable_surprise();
  self.ignorerandombulletdamage = 1;
  maps\_utility::disable_bulletwhizbyreaction();
  maps\_utility::disable_pain();
  maps\_utility::disable_danger_react();
  maps\_utility::enable_dontevershoot();
  self.disablefriendlyfirereaction = 1;
  init_elias_animset();
  self.a.pose = "stand";
  self allowedstances("stand");
}

enable_hesh_walk() {
  maps\_utility::disable_turnanims();
  maps\_utility::disable_surprise();
  self.uphill = 0;
  self.pathrandompercent = 0;
  self.ignoreall = 1;
  self.ignoreme = 1;
  self.no_pistol_switch = 1;
  self.ignoresuppression = 1;
  self.dontmelee = 1;
  self.norunreload = 1;
  self.ammocheatinterval = 2000;
  self.disablebulletwhizbyreaction = 1;
  self.usechokepoints = 0;
  self.disabledoorbehavior = 1;
  self.combatmode = "no_cover";
  self.oldgrenadeawareness = self.grenadeawareness;
  self.grenadeawareness = 0;
  self.oldgrenadereturnthrow = self.nogrenadereturnthrow;
  self.nogrenadereturnthrow = 1;
  self.awareness = 0;
  maps\_utility::disable_surprise();
  self.ignorerandombulletdamage = 1;
  maps\_utility::disable_bulletwhizbyreaction();
  maps\_utility::disable_pain();
  maps\_utility::disable_danger_react();
  maps\_utility::enable_dontevershoot();
  self.disablefriendlyfirereaction = 1;
  init_hesh_animset();
  self.a.pose = "stand";
  self allowedstances("stand");
}

#using_animtree("generic_human");

init_elias_animset() {
  self notify("movemode");
  self.run_overrideanim = undefined;
  self.walk_overrideanim = undefined;
  maps\_utility::clear_generic_idle_anim();
  maps\_utility::disable_turnanims();
  maps\_utility::disable_surprise();
  self.uphill = 0;
  var_0 = [];
  var_0["sprint"] = % youngblood_jog_hesh;
  var_0["straight"] = % youngblood_elias_walk;
  var_0["walk"] = % youngblood_elias_walk;
  var_0["move_f"] = % civilian_walk_hurried_1;
  var_0["move_l"] = % walk_left;
  var_0["move_r"] = % walk_right;
  var_0["move_b"] = % walk_backward;
  self.custommoveanimset["run"] = var_0;
  self.custommoveanimset["crouch"] = var_0;
  self.custommoveanimset["walk"] = var_0;
  self.customidleanimset = [];
  self.customidleanimset["stand"] = [ % youngblood_hesh_calm_idle];
  self.customidleanimweights["stand"] = [1];
  self.a.pose = "stand";
  self allowedstances("stand");
  self.custommovetransition = ::yb_calm_startmovetransition;
  self.customarrivalfunc = ::yb_calm_stopmovetransition;
  self.permanentcustommovetransition = 1;
}

init_hesh_animset() {
  self notify("movemode");
  self.run_overrideanim = undefined;
  self.walk_overrideanim = undefined;
  maps\_utility::clear_generic_idle_anim();
  maps\_utility::disable_turnanims();
  maps\_utility::disable_surprise();
  self.uphill = 0;
  var_0 = [];
  var_0["sprint"] = % youngblood_hesh_sprint;
  var_0["straight"] = % youngblood_walk_hesh;
  var_0["walk"] = % youngblood_walk_hesh;
  var_0["move_f"] = % civilian_walk_hurried_1;
  var_0["move_l"] = % walk_left;
  var_0["move_r"] = % walk_right;
  var_0["move_b"] = % walk_backward;
  var_0["crouch"] = % crouch_sprint;
  var_0["crouch_l"] = % crouch_fastwalk_l;
  var_0["crouch_r"] = % crouch_fastwalk_r;
  var_0["crouch_b"] = % crouch_fastwalk_b;
  var_0["stairs_up"] = % traverse_stair_run_01;
  var_0["stairs_down"] = % traverse_stair_run_down;
  self.custommoveanimset["run"] = var_0;
  self.custommoveanimset["crouch"] = var_0;
  self.custommoveanimset["walk"] = var_0;
  self.customidleanimset = [];
  self.customidleanimset["stand"] = [ % youngblood_hesh_calm_idle];
  self.customidleanimweights["stand"] = [1];
  self.a.pose = "stand";
  self allowedstances("stand");
  level.hesh_anim_set = 1;
  self.custommovetransition = ::yb_calm_startmovetransition;
  self.customarrivalfunc = ::yb_calm_stopmovetransition;
  self.permanentcustommovetransition = 1;
}

init_jog_animset() {
  self notify("movemode");
  self.run_overrideanim = undefined;
  self.walk_overrideanim = undefined;
  maps\_utility::clear_generic_idle_anim();
  maps\_utility::disable_turnanims();
  maps\_utility::disable_surprise();
  self.uphill = 0;
  var_0 = [];
  var_0["sprint"] = % youngblood_hesh_sprint;
  var_0["straight"] = % youngblood_jog_hesh;
  var_0["walk"] = % youngblood_jog_hesh;
  var_0["move_f"] = % civilian_walk_hurried_1;
  var_0["move_l"] = % walk_left;
  var_0["move_r"] = % walk_right;
  var_0["move_b"] = % walk_backward;
  var_0["crouch"] = % crouch_sprint;
  var_0["crouch_l"] = % crouch_fastwalk_l;
  var_0["crouch_r"] = % crouch_fastwalk_r;
  var_0["crouch_b"] = % crouch_fastwalk_b;
  var_0["stairs_up"] = % traverse_stair_run_01;
  var_0["stairs_down"] = % traverse_stair_run_down;
  self.custommoveanimset["run"] = var_0;
  self.custommoveanimset["crouch"] = var_0;
  self.custommoveanimset["walk"] = var_0;
  self.customidleanimset = [];
  self.customidleanimset["stand"] = [ % youngblood_hesh_calm_idle];
  self.customidleanimweights["stand"] = [1];
  self.a.pose = "stand";
  self allowedstances("stand");
  level.hesh_anim_set = 1;
}

init_chaos_animset() {
  self notify("movemode");
  self.run_overrideanim = undefined;
  self.walk_overrideanim = undefined;
  maps\_utility::clear_generic_idle_anim();
  maps\_utility::disable_turnanims();
  maps\_utility::disable_surprise();
  maps\_utility::disable_arrivals();
  maps\_utility::disable_exits();
  self.uphill = 0;
  var_0 = [];
  var_0["sprint"] = % youngblood_hesh_sprint;
  var_0["straight"] = % youngblood_hesh_run_faster;
  var_0["straight_twitch"] = [ % youngblood_hesh_run_twitch_a, %youngblood_hesh_run_twitch_b];
  var_0["walk"] = % youngblood_hesh_run_faster;
  var_0["move_f"] = % youngblood_hesh_run_faster;
  var_0["move_l"] = % walk_left;
  var_0["move_r"] = % walk_right;
  var_0["move_b"] = % walk_backward;
  var_0["crouch"] = % crouch_sprint;
  var_0["crouch_l"] = % crouch_fastwalk_l;
  var_0["crouch_r"] = % crouch_fastwalk_r;
  var_0["crouch_b"] = % crouch_fastwalk_b;
  var_0["stairs_up"] = % youngblood_hesh_jog_upstairs;
  var_0["stairs_down"] = % traverse_stair_run_down;
  self.custommoveanimset["run"] = var_0;
  self.custommoveanimset["crouch"] = var_0;
  self.custommoveanimset["walk"] = var_0;
  self.customidleanimset = [];
  self.customidleanimset["stand"] = [ % youngblood_hesh_alert_idle_1];
  self.customidleanimweights["stand"] = [1];
  self.a.pose = "stand";
  self allowedstances("stand");
  level.hesh_anim_set = 1;
  self.custommovetransition = ::yb_alert_startmovetransition;
  self.customarrivalfunc = ::yb_alert_stopmovetransition;
  self.permanentcustommovetransition = 1;
}

init_jog_animset_alert() {
  self notify("movemode");
  self.run_overrideanim = undefined;
  self.walk_overrideanim = undefined;
  maps\_utility::clear_generic_idle_anim();
  maps\_utility::disable_turnanims();
  maps\_utility::disable_surprise();
  self.uphill = 0;
  self.turnrate = 0.3;
  var_0 = [];
  var_0["sprint"] = % youngblood_hesh_run;
  var_0["straight"] = % youngblood_jog_hesh;
  var_0["walk"] = % youngblood_jog_hesh;
  var_0["move_f"] = % youngblood_jog_hesh;
  var_0["move_l"] = % walk_left;
  var_0["move_r"] = % walk_right;
  var_0["move_b"] = % walk_backward;
  var_0["crouch"] = % crouch_sprint;
  var_0["crouch_l"] = % crouch_fastwalk_l;
  var_0["crouch_r"] = % crouch_fastwalk_r;
  var_0["crouch_b"] = % crouch_fastwalk_b;
  var_0["stairs_up"] = % traverse_stair_run_01;
  var_0["stairs_down"] = % traverse_stair_run_down;
  self.custommoveanimset["run"] = var_0;
  self.custommoveanimset["crouch"] = var_0;
  self.custommoveanimset["walk"] = var_0;
  self.customidleanimset = [];

  if(self == level.hesh)
    self.customidleanimset["stand"] = [ % youngblood_hesh_alert_idle_r];
  else if(self == level.elias)
    self.customidleanimset["stand"] = [ % youngblood_hesh_alert_idle_l];
  else
    self.customidleanimset["stand"] = [ % youngblood_hesh_alert_idle_1];

  self.customidleanimweights["stand"] = [1];
  self.a.pose = "stand";
  self allowedstances("stand");
  level.hesh_anim_set = 1;
  self.custommovetransition = ::yb_alert_startmovetransition;
  self.customarrivalfunc = ::yb_alert_stopmovetransition;
  self.permanentcustommovetransition = 1;
}

init_run_animset_alert() {
  self notify("movemode");
  self.run_overrideanim = undefined;
  self.walk_overrideanim = undefined;
  maps\_utility::clear_generic_idle_anim();
  self.uphill = 0;
  maps\_utility::disable_turnanims();
  maps\_utility::disable_surprise();
  self.turnrate = 0.3;
  var_0 = [];
  var_0["sprint"] = % youngblood_hesh_sprint;
  var_0["straight"] = % youngblood_hesh_run;
  var_0["walk"] = % youngblood_hesh_run;
  var_0["move_f"] = % youngblood_jog_hesh;
  var_0["move_l"] = % walk_left;
  var_0["move_r"] = % walk_right;
  var_0["move_b"] = % walk_backward;
  var_0["crouch"] = % crouch_sprint;
  var_0["crouch_l"] = % crouch_fastwalk_l;
  var_0["crouch_r"] = % crouch_fastwalk_r;
  var_0["crouch_b"] = % crouch_fastwalk_b;
  var_0["stairs_up"] = % traverse_stair_run_01;
  var_0["stairs_down"] = % traverse_stair_run_down;
  self.custommoveanimset["run"] = var_0;
  self.custommoveanimset["crouch"] = var_0;
  self.custommoveanimset["walk"] = var_0;
  self.customidleanimset = [];

  if(self == level.hesh)
    self.customidleanimset["stand"] = [ % youngblood_hesh_alert_idle_r];
  else if(self == level.elias)
    self.customidleanimset["stand"] = [ % youngblood_hesh_alert_idle_l];
  else
    self.customidleanimset["stand"] = [ % youngblood_hesh_alert_idle_1];

  self.customidleanimweights["stand"] = [1];
  self.a.pose = "stand";
  self allowedstances("stand");
  level.hesh_anim_set = 1;
  self.custommovetransition = ::yb_alert_startmovetransition;
  self.customarrivalfunc = ::yb_alert_stopmovetransition;
  self.permanentcustommovetransition = 1;
}

yb_calm_startmovetransition() {
  if(!animscripts\exit_node::checktransitionpreconditions()) {
    return;
  }
  if(self.a.movement != "stop") {
    return;
  }
  var_0 = animscripts\exit_node::getexitnode();
  self orientmode("face angle", self.angles[1]);
  self animmode("zonly_physics", 0);
  var_1 = randomfloatrange(0.9, 1.1);
  var_2 = % youngblood_hesh_calm_idle_2_walk;
  self setflaggedanimknoballrestart("startmove", var_2, %body, 1, 0.1, var_1);
  animscripts\shared::donotetracks("startmove");
  self orientmode("face default");
  self animmode("none", 0);

  if(animhasnotetrack(var_2, "code_move"))
    animscripts\shared::donotetracks("startmove");
}

yb_calm_stopmovetransition() {
  if(isDefined(self.disablearrivals)) {
    return;
  }
  var_0 = % youngblood_hesh_walk_2_calm_idle;
  self clearanim(%body, 0.2);
  self setflaggedanimrestart("coverArrival", var_0, 1, 0.2, self.movetransitionrate);
  animscripts\face::playfacialanim(var_0, "run");
  animscripts\shared::donotetracks("coverArrival", animscripts\cover_arrival::handlestartaim);
  self.a.pose = "stand";
  self.a.movement = "stop";
  self.a.arrivaltype = self.approachtype;
  self clearanim(%root, 0.3);
  self.lastapproachaborttime = undefined;
}

yb_alert_startmovetransition() {
  if(!animscripts\exit_node::checktransitionpreconditions()) {
    return;
  }
  if(self.a.movement != "stop") {
    return;
  }
  var_0 = animscripts\exit_node::getexitnode();
  self orientmode("face angle", self.angles[1]);
  self animmode("zonly_physics", 0);
  var_1 = randomfloatrange(0.9, 1.1);
  var_2 = % youngblood_hesh_alert_idle_2_run;
  self setflaggedanimknoballrestart("startmove", var_2, %body, 1, 0.1, var_1);
  animscripts\shared::donotetracks("startmove");
  self orientmode("face default");
  self animmode("none", 0);

  if(animhasnotetrack(var_2, "code_move"))
    animscripts\shared::donotetracks("startmove");
}

yb_alert_stopmovetransition() {
  if(isDefined(self.disablearrivals)) {
    return;
  }
  var_0 = % youngblood_hesh_run_2_alert_idle;
  self clearanim(%body, 0.2);
  self setflaggedanimrestart("coverArrival", var_0, 1, 0.2, self.movetransitionrate);
  animscripts\face::playfacialanim(var_0, "run");
  animscripts\shared::donotetracks("coverArrival", animscripts\cover_arrival::handlestartaim);
  self.a.pose = "stand";
  self.a.movement = "stop";
  self.a.arrivaltype = self.approachtype;
  self clearanim(%root, 0.3);
  self.lastapproachaborttime = undefined;
}

init_uphill_jog_animset() {
  maps\_utility::set_generic_run_anim("youngblood_hesh_jog_uphill_A");
  maps\_utility::set_generic_idle_anim("youngblood_hesh_calm_idle");
}

init_hesh_hurt_animset() {
  self.uphill = 0;
  var_0 = [];
  var_0["sprint"] = % youngblood_stumble_walk_hesh;
  var_0["straight"] = % youngblood_stumble_walk_hesh;
  var_0["walk"] = % youngblood_stumble_walk_hesh;
  var_0["move_f"] = % youngblood_stumble_walk_hesh;
  var_0["move_l"] = % walk_left;
  var_0["move_r"] = % walk_right;
  var_0["move_b"] = % walk_backward;
  var_0["crouch"] = % crouch_sprint;
  var_0["crouch_l"] = % crouch_fastwalk_l;
  var_0["crouch_r"] = % crouch_fastwalk_r;
  var_0["crouch_b"] = % crouch_fastwalk_b;
  self.custommoveanimset["run"] = var_0;
  self.custommoveanimset["crouch"] = var_0;
  self.custommoveanimset["walk"] = var_0;
  self.customidleanimset = [];
  self.customidleanimset["stand"] = [ % youngblood_hesh_calm_idle];
  self.customidleanimweights["stand"] = [1];
  self.a.pose = "stand";
  self allowedstances("stand");
}

init_uphill_walk_animset() {
  maps\_utility::set_generic_run_anim("youngblood_hesh_walk_uphill");
  maps\_utility::set_generic_idle_anim("youngblood_hesh_calm_idle");
}

uphill_trigger() {
  level endon("start_transition_to_odin");

  for(;;) {
    self waittill("trigger", var_0);

    if(isai(var_0)) {
      if(!var_0.uphill) {
        var_0.uphill = 1;

        if(var_0.script == "move" && level.woods_movement == "walk")
          var_0 thread maps\_anim::anim_generic_gravity(var_0, "youngblood_hesh_walk_uphill_2_IN");

        switch (level.woods_movement) {
          case "walk":
            var_0 thread init_uphill_walk_animset();
            break;
          case "jog":
            var_0 thread init_uphill_jog_animset();
            break;
        }
      }
    }
  }
}

flat_trigger() {
  level endon("start_transition_to_odin");

  for(;;) {
    self waittill("trigger", var_0);

    if(isai(var_0)) {
      if(var_0.uphill) {
        var_0.uphill = 0;

        if(var_0.script == "move" && level.woods_movement == "walk")
          var_0 thread maps\_anim::anim_generic_gravity(var_0, "youngblood_hesh_walk_uphill_2_OUT");

        var_0 notify("movemode");
        var_0.run_overrideanim = undefined;
        var_0.walk_overrideanim = undefined;
        var_0 maps\_utility::clear_generic_idle_anim();
      }
    }
  }
}

player_heartbeat() {
  level endon("stop_player_heartbeat");

  for(;;) {
    self playlocalsound("breathing_heartbeat");
    wait 0.5;
  }
}

videotaper_think() {
  self endon("death");
  var_0 = self.spawner;

  if(isDefined(self.spawner.target)) {
    var_1 = self.spawner common_scripts\utility::get_target_ent();

    if(!isDefined(var_1.classname))
      var_0 = var_1;
    else if(!issubstr(var_1.classname, "trigger"))
      var_0 = var_1;
  }

  var_2 = undefined;

  if(self.animation == "bunker_toss_idle_guy1") {
    wait 0.1;
    self delete();
    return;
  }

  if(self.animation == "roadkill_videotaper_3B_explosion_idle") {
    if(self.model == "body_us_civ_male_b") {
      self detach(self.headmodel, "");

      if(isDefined(self.hatmodel))
        self detach(self.hatmodel, "");

      var_3 = ["a", "e", "i"];
      var_4 = common_scripts\utility::random(var_3);
      var_5 = "head_us_civ_male_" + var_4;
      self setModel("body_us_civ_male_" + var_4);
      self attach(var_5, "", 1);
      self.headmodel = var_5;
    }
  }

  if(issubstr(self.animation, "videotaper") || issubstr(self.animation, "texting")) {
    var_6 = "electronics_camera_cellphone_low";

    switch (self.animation) {
      case "roadkill_videotaper_1B_explosion_idle":
        var_6 = "electronics_camera_pointandshoot_low";
        break;
    }

    var_2 = spawn("script_model", (0, 0, 0));
    var_2 setModel(var_6);
    var_2 linkto(self, "tag_inhand", (0, 0, 0), (0, 0, 0));
  }

  if(isDefined(self.script_parameters) && self.script_parameters == "approach") {
    var_0 thread maps\_anim::anim_generic_first_frame(self, self.animation + "_start");

    if(!isDefined(self.target)) {
      while(distance(level.player.origin, self.origin) < 400)
        wait 0.05;

      waittill_player_lookat_drone(0.7);
    } else {
      var_7 = common_scripts\utility::get_target_ent();
      var_7 waittill("trigger");
    }

    var_0 maps\_anim::anim_generic(self, self.animation + "_start");
  }

  var_0 thread maps\_anim::anim_generic_loop(self, self.animation);
  level waittill("start_mansion");
  self delete();

  if(isDefined(var_0.classname))
    var_0 delete();

  if(isDefined(var_2))
    var_2 delete();
}

waittill_player_lookat_drone(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(var_5))
    var_5 = level.player;

  var_6 = spawnStruct();

  if(isDefined(var_3))
    var_6 thread maps\_utility::notify_delay("timeout", var_3);

  var_6 endon("timeout");

  if(!isDefined(var_0))
    var_0 = 0.92;

  if(!isDefined(var_1))
    var_1 = 0;

  var_7 = int(var_1 * 20);
  var_8 = var_7;
  self endon("death");
  var_9 = undefined;

  for(;;) {
    var_9 = self gettagorigin("j_head");

    if(var_5 maps\_utility::player_looking_at(var_9, var_0, var_2, self)) {
      var_8--;

      if(var_8 <= 0)
        return 1;
    } else
      var_8 = var_7;

    wait 0.05;
  }
}

falling_debris(var_0) {
  var_1 = spawn("script_model", var_0.origin);
  var_1 setModel("tag_origin");
  var_1.angles = (-90, 0, 0);

  if(isDefined(var_0.target)) {
    var_2 = var_0 common_scripts\utility::get_target_ent();
    var_3 = var_2.origin;
    var_4 = bulletTrace(var_1.origin, var_3, 0, var_1, 1);
    var_3 = var_4["position"];
  } else {
    var_4 = bulletTrace(var_1.origin, var_1.origin - (0, 0, 7000), 0, var_1, 1);
    var_3 = var_4["position"];
  }

  var_5 = 1000.0;
  var_6 = distance(var_1.origin, var_3);
  var_7 = var_6 / var_5;
  var_1 moveto(var_3, var_7, 0, 0);
  var_1 maps\_utility::delaythread(max(var_7 - 1.75, 0), maps\_utility::play_sound_on_entity, "debris_inc_whoosh");
  common_scripts\utility::noself_delaycall(max(var_7 - 1.75, 0), ::playfxontag, common_scripts\utility::getfx("ygb_chaos_debris_smk"), var_1, "tag_origin");
  wait(var_7);
  do_player_crash_fx(var_3);
  earthquake(0.6, randomfloatrange(0.75, 1.25), var_3, 1024);
  playFX(level._effect["vfx_lrg_vehicle_exp"], var_3);
  thread common_scripts\utility::play_sound_in_space("exp_rock_big_debris_s1", var_3);
  stopFXOnTag(common_scripts\utility::getfx("ygb_chaos_debris_smk"), var_1, "tag_origin");
  common_scripts\utility::waitframe();
  var_1 delete();
}

do_player_crash_fx(var_0) {
  if(common_scripts\utility::flag("do_player_crash_fx")) {
    return;
  }
  common_scripts\utility::flag_set("do_player_crash_fx");
  thread maps\_utility::flag_clear_delayed("do_player_crash_fx", 1);
  var_1 = distancesquared(level.player.origin, var_0);

  if(var_1 < squared(1500)) {
    level.player playrumblelooponentity("tank_rumble");
    level.player common_scripts\utility::delaycall(1.0, ::stoprumble, "tank_rumble");
    earthquake(0.5, 1, var_0, 2000);

    if(common_scripts\utility::flag("suppress_crash_player_fx")) {
      return;
    }
    var_2 = bulletTrace(level.player.origin, level.player.origin - (0, 0, 5), 0, level.player);

    if(var_2["fraction"] < 0.99) {
      level.player setvelocity(anglestoup(level.player.angles) * 210);

      if(var_1 < squared(650)) {
        level.player allowsprint(0);
        level.player allowstand(0);
        level.player allowprone(0);
        level.player setstance("crouch");
        level.player maps\_utility::blend_movespeedscale(0.5);
        level.player maps\_utility::delaythread(0.1, maps\_utility::playlocalsoundwrapper, "breathing_hurt");
        var_3 = 1;
        level.player maps\_utility::delaythread(0.5, maps\_utility::blend_movespeedscale, level.saved_speed_percent * 0.01, 1.0);
        level.player maps\_utility::delaythread(var_3 + 0.25, maps\_utility::playlocalsoundwrapper, "breathing_better");
        level.player common_scripts\utility::delaycall(var_3, ::allowsprint, 1);
        level.player common_scripts\utility::delaycall(var_3, ::allowstand, 1);
        level.player common_scripts\utility::delaycall(var_3, ::allowprone, 1);
        level.player common_scripts\utility::delaycall(var_3, ::setstance, "stand");
      }
    }
  }
}

neighborhood_fail_if_too_far() {
  level endon("player_safe");

  for(;;) {
    if(getdvarint("no_fail", 0) || getdvarint("scr_art_tweak", 0)) {
      return;
    }
    if(distance2d(level.player.origin, level.hesh.origin) > 800) {
      level notify("new_quote_string");
      setdvar("ui_deadquote", &"YOUNGBLOOD_LEFTBEHIND");
      maps\_utility::missionfailedwrapper();
      break;
    } else if(distance2d(level.player.origin, level.hesh.origin) > 500) {
      maps\_utility::display_hint("hint_sprint");
      wait 5;
    }

    wait 0.5;
  }
}

chaos_player_kill() {
  var_0 = anglesToForward(level.player.angles);
  playFX(level._effect["vfx_yb_explosion_fire_med"], level.player getEye() + var_0 * 32, (0, 0, 1), anglestoright(level.player.angles));
  thread common_scripts\utility::play_sound_in_space("scn_yb_house_collapse", level.player.origin + (0, 0, 0));
  wait 0.25;
  level.player kill();
}

chaos_kill_after_time(var_0) {
  level endon("player_safe");
  common_scripts\utility::flag_set("player_unsafe");
  wait(var_0);

  if(getdvarint("no_fail", 0) || getdvarint("scr_art_tweak", 0)) {
    return;
  }
  thread chaos_player_kill();
}

chaos_checkpoint_trigger() {
  self waittill("trigger");
  level notify("chaos_checkpoint");

  if(self.script_duration) {
    maps\_utility::autosave_by_name_silent("chaos");
    thread chaos_checkpoint(self.script_duration);
  }

  self delete();
}

chaos_checkpoint(var_0) {
  level.player endon("death");
  level notify("chaos_checkpoint");
  level endon("chaos_checkpoint");

  if(getdvarint("no_fail", 0) || getdvarint("scr_art_tweak", 0)) {
    return;
  }
  if(level.gameskill < 2)
    var_0 = var_0 + 3;
  else if(level.gameskill == 2)
    var_0 = var_0 + 1;

  if(var_0 > 5) {
    wait(var_0 - 5);
    playFX(level._effect["vfx_lrg_vehicle_exp"], level.player.origin + (0, 0, 0));
    thread common_scripts\utility::play_sound_in_space("exp_rock_big_debris_s1", level.player.origin + (0, 0, 0));
    earthquake(0.5, 0.7, level.player.origin, 512);
    wait 0.2;
    level.player dodamage(99, level.player.origin + (0, 0, 80));
    level.player viewkick(50, level.player.origin + (0, 0, 80));
    maps\_utility::display_hint_timeout("hint_sprint", 5);
    wait 5;
  } else
    wait(var_0);

  earthquake(0.5, 0.7, level.player.origin, 512);
  level notify("new_quote_string");
  setdvar("ui_deadquote", &"YOUNGBLOOD_LEFTBEHIND");
  chaos_player_kill();
}

time_countdown(var_0) {
  for(;;) {
    iprintlnbold(var_0);
    wait 1;
    var_0 = var_0 - 1;
  }
}

chaos_kill_if_too_far() {
  level endon("player_safe");

  for(;;) {
    if(getdvarint("no_fail", 0) || getdvarint("scr_art_tweak", 0)) {
      return;
    }
    if(distance2d(level.player.origin, level.hesh.origin) > 800) {
      thread chaos_player_kill();
      break;
    } else if(distance2d(level.player.origin, level.hesh.origin) > 500) {
      playFX(level._effect["vfx_lrg_vehicle_exp"], level.player.origin + (0, 0, 80));
      thread common_scripts\utility::play_sound_in_space("exp_rock_big_debris_s1", level.player.origin + (0, 0, 80));
      wait 0.2;
      level.player dodamage(99, level.player.origin + (0, 0, 80));
      level.player viewkick(50, level.player.origin + (0, 0, 80));
      maps\_utility::display_hint_timeout("hint_sprint", 5);
      wait 6;
    }

    wait 0.5;
  }
}

check_close_to_hesh() {
  return distance2d(level.player.origin, level.hesh.origin) < 400 && !common_scripts\utility::flag("player_unsafe");
}

player_unlink_slide_on_death() {
  level.player waittill("death");
  level.player notify("stop_slide");

  if(level.player maps\_utility::issliding())
    level.player unlink();
}

chaos_chunk_fall() {
  var_0 = common_scripts\utility::get_target_ent();
  var_1 = maps\_utility::get_linked_structs();
  var_0 hide();
  self waittill("trigger");
  var_0 show();
  var_0 thread maps\_utility::play_sound_on_entity("scn_yb_final_street_piece_incoming");
  var_0 moveto_rotateto(var_1[0], 1.5, 1.5, 0);
  earthquake(0.6, 1, var_0.origin, 1024);
  playFX(level._effect["vfx_lrg_vehicle_exp"], var_0.origin);
  var_0 thread maps\_utility::play_sound_on_entity("scn_yb_final_street_piece_hit");

  if(!common_scripts\utility::flag("do_player_crash_fx")) {
    thread heavy_quake(80, 75);

    if(distance2d(level.player.origin, var_0.origin) < 500)
      level.player shellshock("ygb_crash", 2);
  }

  thread do_player_crash_fx(var_0.origin);
  common_scripts\utility::flag_wait("truck_landed_exit_scene");
  var_0 delete();
}

rog_strikes() {
  level endon("stop_rog_strikes");
  wait 1;

  for(;;) {
    thread rog_incoming();
    wait(randomfloatrange(10, 20));
  }
}

rog_incoming() {
  var_0 = common_scripts\utility::randomvectorrange(2000, 3000);
  var_0 = (var_0[0], var_0[1], 0);
  thread common_scripts\utility::play_sound_in_space("yb_rog_distant_sky_flash", level.player.origin + (0, 0, 5000) + var_0);
  thread common_scripts\utility::play_sound_in_space("yb_rog_distant_sky_flash", level.player.origin + (0, 0, 5000) - var_0);
  rog_incoming_light();
}

rog_incoming_light() {
  var_0 = (-45, 65, 0);
  var_1 = (-40, 55, 0);
  thread lerp_sun_angles(var_0, var_1);
  fade_sun_in_out();
  resetsunlight();
}

lerp_sun_angles(var_0, var_1) {
  var_2 = 2;
  lerpsunangles(var_0, var_1, var_2, var_2 * 0.2, var_2 * 0.6);
  wait(var_2 * 1.1);
  lerpsunangles(var_1, var_0, 4.5, 0.5, 3);
}

fade_sun_in_out() {
  var_0 = randomfloatrange(0.15, 0.25);
  var_1 = (1, 0.98, 0.866);

  if(maps\_utility::is_gen4()) {
    var_2 = 9;
    var_3 = 1;
  } else {
    var_2 = 1.6;
    var_3 = 0.75;
  }

  var_1 = var_1 * var_2;
  var_4 = (234, 157, 83);
  var_4 = var_4 / 255.0;
  var_5 = var_4 * randomfloatrange(3, 3.5) * var_2 * var_3;
  var_6 = 0;

  while(var_6 < var_0) {
    var_7 = var_6 / var_0;
    var_8 = lerp_value(var_1[0], var_5[0], var_7);
    var_9 = lerp_value(var_1[1], var_5[1], var_7);
    var_10 = lerp_value(var_1[2], var_5[2], var_7);
    setsunlight(var_8, var_9, var_10);
    var_6 = var_6 + 0.05;
    wait 0.05;
  }

  thread sun_flicker(var_5);
  wait 1.4;
  level notify("stop_sun_flicker");
  var_0 = 0.4;
  var_6 = 0;
  var_11 = level.current_sun;
  wait 0.4;
  var_0 = 0.5;
  var_6 = 0;

  while(var_6 < var_0) {
    var_7 = var_6 / var_0;
    var_8 = lerp_value(var_11[0], var_1[0], var_7);
    var_9 = lerp_value(var_11[1], var_1[1], var_7);
    var_10 = lerp_value(var_11[2], var_1[2], var_7);
    setsunlight(var_8, var_9, var_10);
    var_6 = var_6 + 0.05;
    wait 0.05;
  }
}

sun_flicker(var_0) {
  level endon("stop_sun_flicker");
  var_1 = 0;
  var_2 = 0;

  for(;;) {
    var_3 = var_0 * (sin(var_1 + 90) + 0.3) * 0.75;
    var_4 = var_0 * sin(var_1) * 0.5;
    var_5 = var_0 + var_3 + var_4;
    var_6 = var_1;
    var_5 = var_0 + var_0 * 0.3 * ((sin(var_6 + 90) + 0.3) * 0.75 + sin(var_6 * 10) * randomfloatrange(0.2, 0.3) * (sin(var_6 + 90) + 1));
    level.current_sun = var_5;
    setsunlight(var_5[0], var_5[1], var_5[2]);
    var_1 = var_1 + 7;
    var_2 = var_2 + 80;
    wait 0.05;
  }
}

lerp_value(var_0, var_1, var_2) {
  var_3 = var_0 + (var_1 - var_0) * var_2;
  return var_3;
}

_set_anim_time(var_0, var_1) {
  self setanimtime(maps\_utility::getanim(var_0), var_1);
}

yb_follow_path_and_animate(var_0, var_1) {
  self endon("death");
  self endon("stop_path");
  self notify("stop_going_to_node");
  self notify("follow_path");
  self endon("follow_path");
  wait 0.1;
  var_2 = var_0;
  var_3 = undefined;
  var_4 = undefined;

  if(!isDefined(var_1))
    var_1 = 300;

  self.current_follow_path = var_2;
  var_2 maps\_utility::script_delay();

  while(isDefined(var_2)) {
    self.current_follow_path = var_2;

    if(isDefined(var_2.lookahead)) {
      break;
    }

    if(isDefined(level.struct_class_names["targetname"][var_2.targetname]))
      var_4 = ::yb_follow_path_animate_set_struct;
    else if(isDefined(var_2.classname))
      var_4 = ::yb_follow_path_animate_set_ent;
    else
      var_4 = ::yb_follow_path_animate_set_node;

    if(isDefined(var_2.radius) && var_2.radius != 0)
      self.goalradius = var_2.radius;

    if(self.goalradius < 16)
      self.goalradius = 16;

    if(isDefined(var_2.height) && var_2.height != 0)
      self.goalheight = var_2.height;

    var_5 = self.goalradius;
    self childthread[[var_4]](var_2);

    if(isDefined(var_2.animation))
      var_2 waittill(var_2.animation);
    else {
      for(;;) {
        self waittill("goal");

        if(distance(var_2.origin, self.origin) < var_5 + 10 || self.team != "allies") {
          break;
        }
      }
    }

    var_2 notify("trigger", self);

    if(isDefined(var_2.script_flag_set))
      common_scripts\utility::flag_set(var_2.script_flag_set);

    if(isDefined(var_2.script_parameters)) {
      var_6 = strtok(var_2.script_parameters, " ");

      for(var_7 = 0; var_7 < var_6.size; var_7++) {
        if(isDefined(level.custom_followpath_parameter_func))
          self[[level.custom_followpath_parameter_func]](var_6[var_7], var_2);

        if(self.type == "dog") {
          continue;
        }
        switch (var_6[var_7]) {
          case "enable_cqb":
            maps\_utility::enable_cqbwalk();
            break;
          case "disable_cqb":
            maps\_utility::disable_cqbwalk();
            break;
          case "deleteme":
            self delete();
            return;
        }
      }
    }

    if(!isDefined(var_2.script_requires_player) && var_1 > 0 && self.team == "allies") {
      while(isalive(level.player)) {
        if(maps\_utility::follow_path_wait_for_player(var_2, var_1)) {
          break;
        }

        if(isDefined(var_2.animation)) {
          self.goalradius = var_5;
          self setgoalpos(self.origin);
        }

        wait 0.05;
      }
    }

    if(!isDefined(var_2.target)) {
      break;
    }

    if(isDefined(var_2.script_flag_wait))
      common_scripts\utility::flag_wait(var_2.script_flag_wait);

    var_2 maps\_utility::script_delay();
    var_2 = var_2 common_scripts\utility::get_target_ent();
  }

  self notify("path_end_reached");
}

yb_follow_path_animate_set_node(var_0) {
  self notify("follow_path_new_goal");

  if(isDefined(var_0.animation)) {
    var_0 maps\_anim::anim_generic_reach(self, var_0.animation);
    self notify("starting_anim", var_0.animation);

    if(isDefined(var_0.script_parameters) && issubstr(var_0.script_parameters, "gravity"))
      var_0 maps\_anim::anim_generic_gravity(self, var_0.animation);
    else
      var_0 maps\_anim::anim_generic_run(self, var_0.animation);

    self setgoalpos(self.origin);
  } else
    maps\_utility::set_goal_node(var_0);
}

yb_follow_path_animate_set_ent(var_0) {
  self notify("follow_path_new_goal");

  if(isDefined(var_0.animation)) {
    var_0 maps\_anim::anim_generic_reach(self, var_0.animation);
    self notify("starting_anim", var_0.animation);

    if(isDefined(var_0.script_parameters) && issubstr(var_0.script_parameters, "gravity"))
      var_0 maps\_anim::anim_generic_gravity(self, var_0.animation);
    else
      var_0 maps\_anim::anim_generic_run(self, var_0.animation);

    self setgoalpos(self.origin);
  } else
    maps\_utility::set_goal_ent(var_0);
}

yb_follow_path_animate_set_struct(var_0) {
  self notify("follow_path_new_goal");

  if(isDefined(var_0.animation)) {
    var_0 maps\_anim::anim_generic_reach(self, var_0.animation);
    self notify("starting_anim", var_0.animation);
    var_1 = isDefined(self.disableexits) && self.disableexits;
    maps\_utility::disable_exits();

    if(isDefined(var_0.script_parameters) && issubstr(var_0.script_parameters, "gravity"))
      var_0 maps\_anim::anim_generic_gravity(self, var_0.animation);
    else
      var_0 maps\_anim::anim_generic_run(self, var_0.animation);

    if(!var_1)
      maps\_utility::delaythread(0.1, maps\_utility::enable_exits);

    self setgoalpos(self.origin);
  } else
    maps\_utility::set_goal_pos(var_0.origin);
}

mansion_exploders(var_0, var_1) {
  level notify("stop_mansion_exploders");
  level endon("stop_mansion_exploders");

  for(;;) {
    wait(randomfloatrange(0.5, 1.25));
    common_scripts\utility::exploder(var_0 + randomintrange(1, var_1 + 1));
  }
}

flashes_on_player() {
  level endon("player_goes_into_mansion");

  for(;;) {
    wait(randomfloatrange(0.75, 3.5));
    var_0 = randomfloatrange(-45, 45);
    var_1 = (cos(var_0), sin(var_0), 0);
    var_1 = var_1 * randomfloatrange(100, 200);
    var_1 = var_1 + (0, 0, 300);
    playFX(common_scripts\utility::getfx("vfx_yb_onplayer_cloud_flash_a"), level.player.origin + var_1);
  }
}