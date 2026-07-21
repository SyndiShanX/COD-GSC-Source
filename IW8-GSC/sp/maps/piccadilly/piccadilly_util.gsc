/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\maps\piccadilly\piccadilly_util.gsc
**************************************************/

shadow_manager(var_0) {
  self endon("death");

  if(!isDefined(var_0))
    var_0 = 600;

  var_1 = var_0 * var_0;

  for(;;) {
    while(distancesquared(self.origin, level.player.origin) < var_1)
      wait 1;

    self dontcastshadows();

    while(distancesquared(self.origin, level.player.origin) > var_1)
      wait 1;

    self castshadows();
  }
}

generic_damage_monitor() {
  while(isalive(self)) {
    self waittill("damage", var_0, var_1, var_2, var_2, var_3, var_2, var_2, var_2, var_2, var_4, var_2, var_2, var_2, var_5);

    if(!isai(self)) {
      if(isDefined(var_1))
        self.lastattacker = var_1;

      if(isDefined(var_3))
        self.damagemod = var_3;
    }
  }
}

acievement_monitor() {
  level endon("stop_monitoring_acievement");
  self endon("entitydeleted");
  self endon("stop_monitor_achievement");
  self dontcastshadows();

  while(isalive(self)) {
    scripts\engine\utility::waittill_any_return("damage", "death");
    waittillframeend;
    var_0 = undefined;

    if(isDefined(self.lastattacker))
      var_0 = self.lastattacker;

    if(!isDefined(var_0)) {
      continue;
    }
    if(self.behaviortreeasset == "civilian" && isDefined(var_0) && var_0 == level.player) {
      if(getdvarint("scr_debug_achievement")) {}

      print_no_achievement();
      level.gotachievement = 0;
      level notify("stop_monitoring_acievement");
      return;
    }
  }
}

print_no_achievement() {
  if(isDefined(self.targetname))
    var_0 = self.targetname;
  else
    var_0 = "none";

  if(isDefined(self.animname))
    var_1 = self.animname;
  else
    var_1 = "none";
}

check_player_psycho(var_0) {
  self endon("entitydeleted");

  for(;;) {
    self waittill("friendlyfire_notify", var_1, var_2, var_3, var_4, var_5, var_6);

    if(isDefined(var_6) && isDefined(var_2) && var_2 == level.player) {
      if(!mydeathaccidental()) {
        level thread civdeathinstafail();
        return;
      }
    }
  }
}

mydeathaccidental() {
  var_0 = getaiarrayinradius(self.origin, 2000, "axis");

  foreach(var_2 in var_0) {
    if(in_screen_center(var_2.origin + (0, 0, 25), 130)) {
      if(sighttrace_from_player(var_2)) {
        if(getdvarint("scr_instafail_debug")) {}

        return 1;
      }
    }
  }

  var_4 = level.player scripts\sp\friendlyfire::get_most_recent_dmg_or_death_time();

  if(gettime() - var_4 <= 1000) {
    if(getdvarint("scr_instafail_debug")) {}

    return 1;
  }

  if(getdvarint("scr_instafail_debug")) {}

  return 0;
}

in_screen_center(var_0, var_1) {
  var_2 = level.player worldpointtoscreenpos(var_0, level.player.currentfov);

  if(isDefined(var_2)) {
    var_3 = length2dsquared(var_2);

    if(getdvarint("scr_instafail_debug")) {}

    var_4 = scripts\engine\utility::ter_op(isDefined(var_1), squared(var_1), 2500);

    if(var_3 <= var_4) {
      if(getdvarint("scr_instafail_debug")) {}

      return 1;
    }
  }

  return 0;
}

sighttrace_from_player(var_0) {
  var_1 = level.player getEye();
  var_2 = var_0.origin;

  if(sighttracepassed(var_1, var_2, 0, level.player, var_0))
    return 1;

  var_3 = var_0 getEye();

  if(sighttracepassed(var_1, var_3, 0, level.player, var_0))
    return 1;

  var_4 = (var_3 + var_2) * 0.5;

  if(sighttracepassed(var_1, var_4, 0, level.player, var_0))
    return 1;

  return 0;
}

civdeathinstafail() {
  if(getdvarint("scr_instafail_debug")) {
    iprintlnbold("INSTAFAIL");
    return;
  }

  level thread scripts\sp\hud_util::fade_out(0);
  scripts\sp\player_death::set_custom_death_quote(scripts\engine\utility::array_randomize([9, 30])[0]);
  scripts\sp\utility::missionfailedwrapper();
}

is_upright() {
  return self gettagorigin("tag_eye")[2] - self.origin[2] > 30;
}

music_transition() {
  if(scripts\sp\starts::is_after_start("hostage")) {
    return;
  }
  setmusicstate("mx_piccadilly_battleintro_lp");
}

colornode_arrived_func(var_0) {
  self endon("death");

  if(istrue(self.tryingcolorgesture)) {
    return;
  }
  self.tryingcolorgesture = 1;

  if(istrue(self.providecoveringfire))
    self.providecoveringfire = 0;

  if(!isDefined(self.lastgesturetime))
    self.lastgesturetime = gettime();
  else if(gettime() - self.lastgesturetime < 7000) {
    self.tryingcolorgesture = 0;
    return;
  } else
    self.lastgesturetime = gettime();

  childthread scripts\asm\gesture::ai_request_gesture("advance");
  wait 3;
  self waittill("goal");

  if(isDefined(self.enemy))
    childthread scripts\asm\gesture::ai_request_gesture("military_point", self.enemy);
  else
    childthread scripts\asm\gesture::ai_request_gesture("getdown");

  self.tryingcolorgesture = undefined;
}

notify_nearby_casual_killers(var_0, var_1) {
  var_2 = getaiarrayinradius(var_1, 500, "axis");

  if(var_2.size)
    scripts\engine\utility::array_thread(var_2, scripts\engine\sp\utility::notify_delay, "stop_killing_civs", 0.4 + randomfloat(0.8));
}

clear_favorite_enemy(var_0) {
  wait(var_0);
  self.favoriteenemy = undefined;
}

kill_civs_til_player_sees_me() {
  self endon("death");

  while(self isinscriptedstate())
    waitframe();

  self setthreatbiasgroup("kill_civs");
  var_0 = 1;
  scripts\asm\juggernaut\juggernaut::enable_casual_killer();
  var_1 = getdvarfloat("NSPNRRQRLN", 0.91);
  var_2 = getdvarfloat("NOPOKQNMR", 1.06);

  if(var_2 <= var_1)
    var_2 = var_1 + 0.01;

  self.speedscalemult = randomfloatrange(var_1, var_2);
  civ_killer_internal();
  level thread notify_nearby_casual_killers(self, self.origin);
  var_3 = self.enemy;
  self setthreatbiasgroup("axis");
  self notify("stop_going_to_node");
  scripts\asm\juggernaut\juggernaut::disable_casual_killer();
  self.favoriteenemy = level.player;
  self forcethreatupdate();
  thread clear_favorite_enemy(5);

  if(istrue(self.ignoreme))
    self.ignoreme = 0;

  while(isDefined(self.enemy) && isDefined(var_3) && !isPlayer(self.enemy) && self.enemy == var_3)
    waitframe();

  if(!isDefined(self.enemy))
    self getenemyinfo(level.player);

  while(!isDefined(self.enemy))
    waitframe();

  while(istrue(self.casualkiller))
    waitframe();

  if(isDefined(self.weapon.classname) && self.weapon.classname == "mg") {
    scripts\engine\utility::set_movement_speed(randomfloatrange(130.0, 150.0));
    self.maxfaceenemydist = 512;
    waitframe();
    charge_enemy(5);
  }

  self.goalradius = 700;
  self notify("civ_killer_end");
}

charge_enemy(var_0) {
  self endon("death");

  if(isPlayer(self.enemy)) {
    var_1 = self.enemy;
    self setgoalentity(var_1);
    var_2 = gettime() + var_0 * 1000;
    self.goalradius = 32;
    self.meleechargedistvsplayer = 400;
    self.meleemaxzdiff = 500;
    self.meleetargetallowedoffmeshdistsq = 225;
    self.meleetryhard = 1;

    while(isalive(self.enemy) && isalive(var_1) && self.enemy == var_1 && gettime() < var_2) {
      self setgoalentity(var_1);
      var_3 = distance2d(self.origin, var_1.origin);

      if(var_3 < 150 && abs(self.lookaheaddist - var_3) < 20) {
        break;
      }

      wait 0.1;
    }
  }

  self setgoalpos(self.origin);
  self.meleechargedistvsplayer = 200;
  self.meleemaxzdiff = 36;
  self.meleetargetallowedoffmeshdistsq = undefined;
  self.meleetryhard = undefined;
}

civ_killer_internal() {
  self endon("stop_killing_civs");
  var_0 = 0;
  var_1 = 60;
  var_2 = 0;
  var_3 = 120;
  var_4 = cos(10);
  var_5 = cos(45);
  var_6 = gettime();
  var_7 = 0;

  for(;;) {
    if(isDefined(self.lastattacker) && (isPlayer(self.lastattacker) || scripts\engine\utility::within_fov(level.player.origin, level.player.angles, self.origin, cos(75)))) {
      break;
    }

    var_8 = scripts\engine\trace::ray_trace_passed(level.player getEye(), self getEye(), [level.player, self], scripts\engine\trace::create_contents(1, 1, 0, 1, 0, 1, 0, 1, 1));

    if(distancesquared(self.origin, level.player.origin) <= 90000 && var_8) {
      break;
    }

    if(!istrue(self.ignoreme) && distancesquared(self.origin, level.player.origin) <= 640000 && scripts\engine\utility::within_fov(level.player.origin, level.player.angles, self.origin, var_4) && var_8) {
      var_0++;

      if(var_0 == var_1) {
        break;
      }

      if(!istrue(var_7) && isDefined(level.player.lastweaponfiredtime) && gettime() - level.player.lastweaponfiredtime <= 500) {
        break;
      }
    } else if(!istrue(self.ignoreme) && distancesquared(self.origin, level.player.origin) <= 1440000 && scripts\engine\utility::within_fov(level.player.origin, level.player.angles, self.origin, var_5) && var_8) {
      var_2++;

      if(var_2 == var_3) {
        break;
      } else if(isDefined(self._blackboard) && istrue(self._blackboard.shootparams_starttime) && gettime() - self._blackboard.shootparams_starttime >= 3000) {
        break;
      }
    } else
      var_9 = 0;

    waitframe();
  }
}

open_goalradius_on_player_sight() {
  self endon("death");
  waitframe();

  if(istrue(self.using_goto_node))
    scripts\engine\utility::waittill_any("reached_path_end", "stop_going_to_node");

  var_0 = 0;

  for(;;) {
    if(distancesquared(self.origin, level.player.origin) <= 640000 && player_sees_my_location()) {
      var_0++;

      if(var_0 == 15) {
        break;
      }
    } else
      var_0 = 0;

    waitframe();
  }

  if(istrue(self.fixednode))
    self.fixednode = 0;

  self.goalradius = 2048;
  scripts\aitypes\cover::lookforbettercover_internal(self.covernode);
}

player_sees_my_location() {
  if(level.player scripts\engine\trace::can_see_origin(self.origin, 0))
    return 1;

  if(level.player scripts\engine\trace::can_see_origin(self getEye(), 0))
    return 1;

  var_0 = self.origin + (0, 0, 60) + anglestoright(self.angles) * 25;

  if(level.player scripts\engine\trace::can_see_origin(var_0, 0))
    return 1;

  var_1 = self.origin + (0, 0, 60) + anglestoright(self.angles) * -1 * 25;

  if(level.player scripts\engine\trace::can_see_origin(var_1, 0))
    return 1;

  return 0;
}

waittill_within_fov_from_dist(var_0, var_1, var_2) {
  self endon("death");
  var_3 = 0;
  var_4 = scripts\engine\utility::ter_op(isDefined(var_2), var_2, 20);
  var_0 = squared(var_0);

  for(;;) {
    if(distancesquared(self.origin, var_1) <= var_0 && scripts\engine\trace::can_see_origin(var_1, 0)) {
      var_3++;

      if(var_3 == var_4)
        return;
    } else
      var_3 = 0;

    waitframe();
  }
}

lerp_fov_over_dist(var_0, var_1, var_2) {
  level.player endon("stop_lerp_fov");
  level.player modifybasefov(var_1, 0.2);
  var_3 = scripts\engine\utility::getStruct(var_0, "targetname");
  var_4 = scripts\engine\utility::getStruct(var_3.target, "targetname");
  var_5 = distance(var_3.origin, var_4.origin);
  var_6 = 0;

  for(;;) {
    var_7 = pointonsegmentnearesttopoint(var_3.origin, var_4.origin, level.player.origin);
    var_8 = distance(var_7, var_3.origin);
    var_9 = var_8 / var_5;

    if(var_9 > var_6) {
      var_6 = var_9;
      var_10 = scripts\engine\math::factor_value(var_1, var_2, var_9);
      level.player modifybasefov(var_10, 0.2);
    }

    if(var_9 == 1) {
      break;
    }

    waitframe();
  }
}

get_closest_bomber_target() {
  self endon("death");
  var_0 = [];

  foreach(var_2 in level.piccadilly.civilians) {
    if(isai(var_2))
      var_0[var_0.size] = var_2;
  }

  if(!isalive(self)) {
    return;
  }
  var_4 = getaiarray("allies");
  var_5 = scripts\engine\utility::array_combine(var_0, var_4);
  var_6 = sortbydistance(var_5, self.origin)[0];

  if(isDefined(self) && isalive(var_6) && distance(var_6.origin, self.origin) < distance(self.bombertarget.origin, self.origin))
    bomber_set_target(var_6);
}

bomber_set_detonation_dist_squared(var_0) {
  self.bomberexplodedistance = var_0;
}

bomber_set_target(var_0) {
  self.bombertarget = var_0;
  self getenemyinfo(var_0);
}

initanimteddoor(var_0, var_1, var_2, var_3) {
  var_4 = getstartorigin(var_0.origin, var_0.angles, var_2);
  var_5 = getstartangles(var_0.origin, var_0.angles, var_2);
  var_6 = scripts\engine\sp\utility::spawn_anim_model("animated_door", var_4, var_5);
  var_7 = getEntArray(var_1, "targetname");
  var_8 = undefined;
  var_9 = undefined;
  var_10 = undefined;

  foreach(var_12 in var_7) {
    if(var_12.classname == "script_brushmodel")
      var_8 = var_12;

    if(var_12.classname == "script_model") {
      var_10 = var_12;
      continue;
    }

    if(var_12.classname == "script_origin")
      var_9 = var_12;
  }

  if(isDefined(var_10))
    var_10 linkTo(var_9);

  var_8 linkTo(var_9);

  if(isDefined(var_3))
    var_9 linkTo(var_6, "tag_origin", (0, 0, 0), (0, 0, 0));
  else
    var_9 linkTo(var_6);

  var_6.prop = var_8;
  return var_6;
}

waittill_player_looks_or_timeout(var_0, var_1) {
  level.player endon("death");
  level endon("lookat_timeout");
  level thread scripts\engine\sp\utility::notify_delay("lookat_timeout", var_1);
  var_2 = cos(50);

  while(!scripts\engine\utility::within_fov(level.player.origin, level.player getplayerangles(), var_0, var_2))
    wait 0.05;
}

has_ceiling() {
  var_0 = scripts\engine\trace::create_contents(0, 1, 1, 1, 0, 0, 1, 0);
  return !scripts\engine\trace::ray_trace_passed(self.origin, self.origin + (0, 0, 1200), self, var_0);
}

ragdoll_death_after_anim() {
  self waittillmatch("single anim", "end");

  if(isDefined(self.magic_bullet_shield))
    scripts\common\ai::stop_magic_bullet_shield();

  if(self islinked())
    self unlink();

  self.ragdoll_immediate = 1;
  self.allowdeath = 1;
  scripts\engine\sp\utility::die();
}

get_longest_animating_ent(var_0, var_1) {
  var_2 = var_0[0];
  var_3 = getanimlength(var_2 scripts\engine\utility::getanim(var_1));

  for(var_4 = 1; var_4 < var_0.size; var_4++) {
    var_5 = getanimlength(var_0[var_4] scripts\engine\utility::getanim(var_1));

    if(var_5 > var_3) {
      var_3 = var_5;
      var_2 = var_0[var_4];
    }
  }

  return var_2;
}

spawn_sas_redshirts() {
  if(isDefined(level.street_friendlies)) {
    scripts\engine\utility::array_thread(level.street_friendlies, scripts\common\ai::stop_magic_bullet_shield);
    level.ctbuddy = level.street_friendlies[0];
    level.ctpassenger = level.street_friendlies[1];
  } else {
    var_0 = getspawnerarray("sicario_street_friendly");
    level.ctbuddy = var_0[0] scripts\engine\sp\utility::spawn_ai(1);
    level.ctpassenger = var_0[1] scripts\engine\sp\utility::spawn_ai(1);
  }

  level.sas = [level.ctbuddy, level.ctpassenger];
  level.sas = scripts\engine\utility::array_removedead(level.sas);
  level.sas = scripts\engine\utility::array_removeundefined(level.sas);
  scripts\engine\utility::flag_set("ally_setup_done");
  scripts\engine\utility::array_thread(level.sas, scripts\engine\sp\utility::set_force_color, "y");
  scripts\engine\utility::array_thread(level.sas, ::disable_covering_fire);
}

disable_covering_fire() {
  self.providecoveringfire = 0;
}

disable_sas_color() {
  if(isDefined(level.sas)) {
    foreach(var_1 in level.sas) {
      if(isalive(var_1))
        var_1 scripts\engine\sp\utility::disable_ai_color();
    }
  }
}

spawn_price() {
  level.price = scripts\engine\sp\utility::spawn_targetname("price", 1);
  level.price.goalradius = 32;
  level.price scripts\engine\sp\utility::set_force_color("o");
  level.price.script_pushable = 0;
  level.price.anim_playvo_func = scripts\engine\utility::playsoundontag;
  level.price thread price_face_swap();
  level.price enableavoidance(0);
  return level.price;
}

price_face_swap() {
  self detach(self.headmodel);
  self.headmodel = "head_hero_price";
  self attach(self.headmodel);
}

spawn_price_redshirt() {
  var_0 = scripts\engine\sp\utility::spawn_targetname("price_sas", 1);
  var_0 thread scripts\common\ai::magic_bullet_shield();
  var_0.goalradius = 32;
  return var_0;
}

breadcrumb_objective(var_0, var_1) {
  var_2 = scripts\engine\utility::getclosest(level.player.origin, var_1);
  var_3 = undefined;
  var_4 = var_2;

  for(;;) {
    for(;;) {
      var_5 = sortbydistance(var_1, level.player.origin)[0];

      if(abs(var_5.origin[2] - level.player.origin[2]) < 60 && distancesquared(level.player.origin, var_5.origin) < squared(var_5.radius)) {
        var_2 = var_5;
        break;
      }

      wait 0.05;
    }

    if(isDefined(var_2.target)) {
      if(var_2 == var_4 && distancesquared(level.player.origin, var_2.origin) > squared(var_2.radius))
        var_3 = var_4;
      else
        var_3 = scripts\engine\utility::getStruct(var_2.target, "targetname");

      scripts\engine\sp\objectives::objective_update(var_0, undefined, var_3.origin);

      while(distancesquared(level.player.origin, var_2.origin) < squared(var_2.radius))
        wait 0.05;
    } else
      return;

    wait 0.05;
  }
}

crowd_screams(var_0, var_1, var_2) {
  thread scripts\engine\utility::play_sound_in_space("scared_crowd_screams", var_0);
}

piccadilly_spawnStruct() {
  if(!isDefined(level.piccadilly))
    level.piccadilly = spawnStruct();
}

piccadilly_weapons() {
  if(level.start_point == "trailer_car_jumper") {
    return;
  }
  var_0 = [];
  var_1 = [];

  if(scripts\sp\starts::is_after_start("combat")) {
    var_0[var_0.size] = "iw8_ar_akilo47";
    var_0[var_0.size] = "iw8_pi_papa320";
  } else
    var_0[var_0.size] = "iw8_pi_papa320";

  foreach(var_4, var_3 in var_0) {
    if(var_3 == "iw8_pi_papa320")
      var_1[var_4] = scripts\sp\utility::make_weapon_special("papa320_black_rain");
    else
      var_1[var_4] = scripts\sp\utility::make_weapon(var_3);

    level.player giveweapon(var_1[var_4], 0, 0, 0, 1);

    if(var_3 == "iw8_pi_papa320" && getdvarint("TTMRSTRO") <= 1)
      level.player setweaponammostock("iw8_pi_papa320", 40);
  }

  level.player switchtoweaponimmediate(var_1[0]);
  level.player setshadowmodel("default_character_shadow");
  level.player setviewmodel("viewhands_kyle_sas_urban");
  scripts\sp\utility::context_melee_set_arms("viewhands_kyle_sas_urban");
}

notetrack_nag(var_0, var_1, var_2) {
  level endon(var_1);

  if(isDefined(var_2))
    level endon(var_2);

  for(;;) {
    foreach(var_4 in var_0) {
      self waittill("nag");
      scripts\engine\sp\utility::smart_dialogue(var_4);
    }

    level.player thread scripts\sp\player::focus_display_hint(undefined, 6);
  }
}

raindrop_fx_manager() {
  var_0 = scripts\engine\utility::spawn_tag_origin();
  var_0 thread raindrop_fx_thread();
  var_1 = getEntArray("turn_off_exterior_fx", "script_noteworthy");

  foreach(var_3 in var_1)
  thread raindrop_fx_trigger_think(var_3, var_0);
}

raindrop_fx_thread() {
  self endon("stop_raindrop_fx");
  level notify("stop_rain_brute_force");
  level endon("stop_rain_brute_force");
  var_0 = "tag_origin";
  var_1 = 0;

  for(;;) {
    wait 0.3;
    var_2 = angleclamp180(level.player getplayerangles()[0]);

    if(var_2 < -35 && !var_1) {
      self.currentfx = "vfx_pic_rain_screenfx_up";
      playFXOnTag(level._effect[self.currentfx], self, "tag_origin");
      var_1 = 1;
      continue;
    }

    if(var_2 >= -35 && var_1) {
      if(isDefined(self.currentfx))
        stopFXOnTag(level._effect[self.currentfx], self, "tag_origin");

      var_1 = 0;
    }
  }
}

raindrop_fx_trigger_think(var_0, var_1) {
  for(;;) {
    var_0 waittill("trigger", var_2);
    var_1 notify("stop_raindrop_fx");

    if(isDefined(var_1.currentfx)) {
      stopFXOnTag(level._effect[var_1.currentfx], var_1, "tag_origin");
      var_1.currentfx = undefined;
    }

    while(isalive(var_2) && isDefined(var_0) && var_2 istouching(var_0))
      wait 0.05;

    var_1 thread raindrop_fx_thread();
  }
}

picc_spawn_ai(var_0, var_1) {
  make_room_for_ai();
  var_2 = getspawner(var_0, "targetname");
  var_3 = var_2 scripts\engine\sp\utility::spawn_ai(1, var_1);
  var_3.animname = var_3.targetname;
  var_3 setgoalpos(var_3.origin);
  return var_3;
}

make_room_for_ai(var_0, var_1, var_2) {
  if(!isDefined(var_0))
    var_0 = 30;

  if(!isDefined(var_1))
    var_1 = "civilian";

  if(!isDefined(var_2))
    var_2 = 0;

  if(var_1 == "civilian") {
    if(getaicount() <= var_0) {
      return;
    }
    debug_print("deleting civ because we're out of space: " + getaicount() + " Allowed: " + var_0);
    var_3 = [];

    foreach(var_5 in getaiarray()) {
      if(var_5.asmname == "civilian")
        var_3[var_3.size] = var_5;
    }

    var_7 = find_ai_to_kill(var_3);

    if(isDefined(var_7.magic_bullet_shield))
      var_7 scripts\common\ai::stop_magic_bullet_shield();

    var_7 kill();

    while(var_2 && level.piccadilly.civilians.size > var_0) {
      var_7 = find_ai_to_kill(var_3);

      if(isDefined(var_7.magic_bullet_shield))
        var_7 scripts\common\ai::stop_magic_bullet_shield();

      var_7 kill();
      waitframe();
    }
  } else if(var_1 == "enemy" || var_1 == "axis") {
    if(getaicount("axis") <= var_0) {
      return;
    }
    debug_print("deleting enemy because we're out of space: " + getaicount("axis") + " Allowed: " + var_0);
    var_8 = find_ai_to_kill(getaiarray("axis"));
    var_8 kill();

    while(var_2 && getaicount("axis") > var_0) {
      var_8 = find_ai_to_kill(getaiarray("axis"));
      var_8 kill();
      waitframe();
    }
  }
}

find_ai_to_kill(var_0) {
  var_0 = scripts\engine\utility::array_removedead_or_dying(var_0);
  var_1 = scripts\engine\utility::array_sort_with_func(var_0, ::starttime_compare);

  foreach(var_3 in var_0)
  var_3.normalized_starttime = 1 - scripts\engine\math::normalize_value(var_1[0].starttime, var_1[var_1.size - 1].starttime, var_3.starttime);

  var_1 = sortbydistance(var_0, level.player.origin);

  foreach(var_3 in var_0)
  var_3.normalized_distance = scripts\engine\math::normalize_value(distance2dsquared(level.player.origin, var_1[0].origin), distance2dsquared(level.player.origin, var_1[var_1.size - 1].origin), distance2dsquared(level.player.origin, var_3.origin));

  foreach(var_3 in var_0)
  var_3.normalized_kill = var_3.normalized_starttime + var_3.normalized_distance;

  var_1 = scripts\engine\utility::array_sort_with_func(var_0, ::normalize_compare);

  foreach(var_3 in var_1) {
    if(!scripts\anim\utility_common.gsc::player_can_see_ai(level.player, var_3))
      return var_3;
  }

  return var_1[0];
}

starttime_compare(var_0, var_1) {
  return var_0.starttime <= var_1.starttime;
}

distance_compare(var_0, var_1) {
  var_2 = distance2dsquared(level.player.origin, var_0.origin);
  var_3 = distance2dsquared(level.player.origin, var_1.origin);
  return var_2 >= var_3;
}

normalize_compare(var_0, var_1) {
  return var_0.normalized_kill >= var_1.normalized_kill;
}

make_room_and_activate_trigger(var_0, var_1, var_2, var_3, var_4) {
  scripts\engine\sp\utility::activate_trigger(var_3, var_4, level.player);
  scripts\engine\utility::delaythread(0.1, ::make_room_for_ai, var_0, var_1, var_2);
}

enemy_spawn_logic() {
  make_room_for_ai();
}

block_while_alive(var_0) {
  foreach(var_2 in var_0) {
    while(isDefined(var_2) && isalive(var_2))
      waitframe();
  }
}

block_while_enemy_count(var_0) {
  level endon("stop enemy count");
  level.player endon("death");

  for(;;) {
    var_1 = getaicount("axis");

    if(var_1 <= var_0) {
      return;
    }
    waitframe();
  }
}

player_heartbeat() {
  level endon("stop_player_heartbeat");

  for(;;) {
    self playlocalsound("breathing_heartbeat");
    wait 0.5;
  }
}

set_goal_volume_for_substr(var_0, var_1, var_2) {
  var_3 = getaiarray("axis");
  var_4 = getEnt(var_0, "targetname");

  foreach(var_6 in var_3) {
    if(isDefined(var_6.script_noteworthy) && var_6.script_noteworthy == "ignore_goalvolumes")
      var_3 = scripts\engine\utility::array_remove(var_3, var_6);
  }

  foreach(var_6 in var_3) {
    if(isDefined(var_6.script_goalvolume) && issubstr(var_6.script_goalvolume, var_1)) {
      continue;
    }
    var_3 = scripts\engine\utility::array_remove(var_3, var_6);
  }

  if(isDefined(var_2)) {
    foreach(var_6 in var_3) {
      if(!isDefined(var_6)) {
        continue;
      }
      var_6 setgoalvolumeauto(var_4);
      wait(randomfloatrange(0.25, 1));
    }
  } else
    scripts\engine\utility::array_call(var_3, ::setgoalvolumeauto, var_4);

  return var_3;
}

set_goal_volume_for_all(var_0, var_1) {
  var_2 = getaiarray("axis");
  var_3 = getEnt(var_0, "targetname");

  foreach(var_5 in var_2) {
    if(isDefined(var_5.script_noteworthy) && var_5.script_noteworthy == "ignore_goalvolumes")
      var_2 = scripts\engine\utility::array_remove(var_2, var_5);
  }

  if(isDefined(var_1)) {
    foreach(var_5 in var_2) {
      var_5 setgoalvolumeauto(var_3);
      wait(randomfloatrange(0.25, 1));
    }
  } else
    scripts\engine\utility::array_call(var_2, ::setgoalvolumeauto, var_3);

  return var_2;
}

turn_off_flood_spawner(var_0) {
  var_1 = getEnt(var_0, "script_noteworthy");
  var_2 = getspawnerarray(var_1.target);

  foreach(var_4 in var_2)
  var_4.count = 0;
}

ai_turret_shoot(var_0, var_1) {
  self endon("death");
  var_0 endon("death");

  if(!isDefined(var_1))
    var_1 = 1;

  for(;;) {
    if(!var_1 || self cansee(var_0)) {
      magicbullet(self.weapon, self gettagorigin("tag_flash"), var_0.origin + anglestoup(var_0.angles) * randomintrange(35, 60) + anglestoright(self.angles) * randomintrange(-48, 48));
      wait(randomfloatrange(0.2, 0.5));
      continue;
    }

    waitframe();
  }
}

show_all_cover_nodes() {
  wait 1;
  var_0 = getallnodes();

  foreach(var_2 in var_0) {
    if(isDefined(var_2.script_color_allies)) {}
  }

  var_4 = getarraykeys(level.arrays_of_colorcoded_nodes["allies"]);

  foreach(var_6 in var_4) {
    foreach(var_2 in level.arrays_of_colorcoded_nodes["allies"][var_6]) {}
  }
}

veh_magic_bullet_array(var_0) {
  foreach(var_2 in var_0) {
    var_3 = self.origin + (0, 0, var_2[0]) + anglesToForward(self.angles) * var_2[2] + anglestoright(self.angles) * var_2[4];
    var_4 = self.origin + (0, 0, var_2[1]) + anglesToForward(self.angles) * var_2[3];
    magicbullet("iw8_ar_mike4", var_3, var_4);

    if(!isDefined(var_2[5])) {
      waitframe();

      if(scripts\engine\utility::cointoss())
        waitframe();
    }

    waitframe();
  }
}

start_player_anim(var_0) {
  level.player_rig show();
  level.player allowmovement(0);
  level.player scripts\common\utility::allow_jump(0);
  level.player scripts\common\utility::allow_prone(0);
  level.player scripts\common\utility::allow_crouch(0);
  level.player scripts\common\utility::allow_fire(0);
  level.player disableweapons();
  level.player playerlinktodelta(level.player_rig, "tag_player", 0, 35, 35, 20, 20);

  if(isDefined(var_0) || var_0)
    level.player springcamenabled(0, 5, 5);
}

stop_player_anim() {
  level.player_rig hide();
  level.player allowmovement(1);
  level.player scripts\common\utility::allow_jump(1);
  level.player scripts\common\utility::allow_prone(1);
  level.player scripts\common\utility::allow_crouch(1);
  level.player scripts\common\utility::allow_fire(1);
  level.player enableweapons();
  level.player unlink();
}

debug_print(var_0) {}

debug_print3d(var_0, var_1, var_2, var_3, var_4, var_5) {}

delete_targetname(var_0) {
  var_1 = getEnt(var_0, "targetname");
  var_1 delete();
}

kill_array_of_ai() {
  foreach(var_1 in self)
  var_1 kill();
}

within_player_fov() {
  var_0 = scripts\engine\utility::within_fov(level.player getEye(), level.player getplayerangles(), self.origin, cos(35));
  return var_0;
}

get_all_good_guys() {
  var_0 = getaiarray("allies");
  var_0 = scripts\engine\utility::array_add(var_0, level.player);
  return var_0;
}

delete_trigger_with_targetname(var_0) {
  var_1 = getEnt(var_0, "targetname");
  var_1 delete();
}

delete_trigger_with_noteworthy(var_0) {
  var_1 = getEnt(var_0, "script_noteworthy");
  var_1 delete();
}

delete_all_bad_guys() {
  var_0 = getaiarray("axis");

  foreach(var_2 in var_0)
  var_2 delete();
}

#using_animtree("scriptables");

use_scriptables_animtree() {
  self useanimtree(#animtree);
}

pain_vo(var_0) {
  var_1 = get_gender();
  var_2 = randomintrange(1, 8);

  if(var_1 == "male")
    var_3 = "generic_pain_friendly_" + var_2;
  else
    var_3 = "woman_pain_friendly_" + var_2;

  say(var_3);
}

death_vo(var_0) {
  var_1 = get_gender();
  var_2 = randomintrange(1, 8);

  if(var_1 == "male")
    var_3 = "generic_death_friendly_" + var_2;
  else
    var_3 = "woman_death_friendly_" + var_2;

  say(var_3);
}

get_gender() {
  switch (self.voice) {
    case "unitednationsfemale":
      var_0 = "female";
      break;
    default:
      var_0 = "male";
      break;
  }

  return var_0;
}

is_police() {
  return strtok(self.classname, "_")[3] == "police";
}

add_to_chatter(var_0, var_1, var_2, var_3) {
  var_4 = undefined;

  if(!isDefined(level.vo_chatter))
    level thread init_chatter();

  if(!isDefined(var_1))
    var_1 = "none";

  if(isDefined(level.vo_chatter.insert_index)) {
    level.vo_chatter.queue scripts\engine\utility::array_insert(level.vo_chatter.queue, var_0, level.vo_chatter.insert_index);
    level.vo_chatter.origins scripts\engine\utility::array_insert(level.vo_chatter.origins, var_1, level.vo_chatter.insert_index);
    level.vo_chatter.insert_index++;
  } else {
    level.vo_chatter.queue[level.vo_chatter.queue.size] = var_0;
    level.vo_chatter.origins[level.vo_chatter.origins.size] = var_1;
  }

  if(isDefined(var_2))
    level.vo_chatter thread remove_on_notify(var_0, var_2, var_3);

  level.vo_chatter notify("item_added");
}

add_say_on_closest_ally_to_chatter(var_0, var_1, var_2, var_3) {
  var_4 = [::say_line_on_closest_ally, [var_0]];
  add_to_chatter([var_4], var_1, var_2, var_3);
}

start_inserting_chatter() {
  level.vo_chatter.insert_index = 0;
}

stop_inserting_chatter() {
  level.vo_chatter.insert_index = undefined;
}

remove_on_notify(var_0, var_1, var_2) {
  self endon("terminate_chatter");

  if(!isDefined(var_2))
    var_2 = level;

  if(isarray(var_1))
    var_2 scripts\engine\utility::waittill_any_in_array_return(var_1);
  else
    var_2 waittill(var_1);

  foreach(var_5, var_4 in level.vo_chatter.queue) {
    if(compare(var_4, var_0)) {
      level.vo_chatter.queue = scripts\engine\utility::array_remove_index(level.vo_chatter.queue, var_5);
      level.vo_chatter.origins = scripts\engine\utility::array_remove_index(level.vo_chatter.origins, var_5);
      return;
    }
  }
}

init_chatter() {
  level.vo_chatter = spawnStruct();
  level.vo_chatter.queue = [];
  level.vo_chatter.origins = [];
  level.vo_chatter.speaking = 0;
  level.vo_chatter.waiting = [];
  level.vo_chatter.interval = 2;
  thread chatter_loop();
}

chatter_loop() {
  level.vo_chatter endon("terminate_chatter");
  level.vo_chatter.stopped = 0;

  for(;;) {
    chatter_loop_internal();

    while(level.vo_chatter.stopped)
      level.vo_chatter waittill("start_chatter");
  }
}

chatter_loop_internal() {
  level.vo_chatter endon("stop_chatter");

  for(;;) {
    if(level.vo_chatter.queue.size == 0)
      level.vo_chatter waittill("item_added");

    wait(level.vo_chatter.interval);

    if(level.vo_chatter.queue.size == 0) {
      continue;
    }
    var_0 = get_chatter_item_index();

    if(!isDefined(var_0)) {
      continue;
    }
    var_1 = level.vo_chatter.queue[var_0];
    level.vo_chatter.queue = scripts\engine\utility::array_remove_index(level.vo_chatter.queue, var_0);
    level.vo_chatter.origins = scripts\engine\utility::array_remove_index(level.vo_chatter.origins, var_0);

    if(isarray(var_1)) {
      level do_as_chatter(::say_sequence, [var_1], 1);
      continue;
    }

    level do_as_chatter(::say_vo_item, [var_1], 1);
  }
}

get_chatter_item_index() {
  var_0 = undefined;
  var_1 = undefined;

  foreach(var_12, var_3 in level.vo_chatter.queue) {
    var_4 = level.vo_chatter.origins[var_12];

    if(isstring(var_4) && var_4 == "none") {
      if(!isDefined(var_0))
        var_0 = var_12;

      continue;
    }

    if(!isarray(var_4))
      var_4 = [var_4];

    foreach(var_6 in var_4) {
      if(isint(var_6) || isfloat(var_6))
        var_7 = var_6;
      else {
        var_8 = anglesToForward(level.player getplayerangles());
        var_9 = level.player.origin - var_6;
        var_10 = scripts\engine\math::anglebetweenvectors(var_8, var_9) / 180;
        var_10 = (1 - var_10) / 4 + 0.75;
        var_7 = length2d(var_9) * var_10;
      }

      if(!isDefined(var_1) || var_7 < var_1) {
        var_1 = var_7;
        var_0 = var_12;
      }
    }
  }

  return var_0;
}

terminate_chatter() {
  level.vo_chatter notify("terminate_chatter");
  level.vo_chatter = undefined;
}

say_sequence(var_0, var_1) {
  var_2 = self;

  foreach(var_4 in var_0)
  var_2 = var_2 say_vo_item(var_4, var_1);
}

say_vo_item(var_0, var_1) {
  var_2 = self;

  if(isarray(var_0)) {
    if((isint(var_0[0]) || isfloat(var_0[0])) && isint(var_0[1]) || isfloat(var_0[1]))
      wait(randomfloatrange(var_0[0], var_0[1]));
    else if(isbuiltinfunction(var_0[0]) || isbuiltinmethod(var_0[0]) || isanimation(var_0[0]))
      var_2 call_with_params(var_0[0], var_0[1]);
    else {}

    return var_2;
  }

  if(isent(var_0) || isstruct(var_0))
    var_2 = var_0;
  else if(isstring(var_0))
    var_2 say(var_0, var_1);
  else if(isint(var_0) || isfloat(var_0))
    wait(var_0);
  else if(isbuiltinfunction(var_0) || isbuiltinmethod(var_0) || isanimation(var_0))
    var_2 call_with_params(var_0);
  else if(scripts\engine\sp\utility::is_deck(var_0))
    var_2 = var_2 say_vo_item(var_0 scripts\engine\sp\utility::deck_draw(), var_1);

  return var_2;
}

say(var_0, var_1) {
  if(!soundexists(var_0))
    return 0;

  if(is_dead_or_dying(self))
    return 0;

  self notify("started_speaking", var_0);

  if(istrue(var_1)) {
    if(isstruct(self))
      scripts\engine\sp\utility::smart_radio_dialogue_interrupt(var_0);
    else if(isPlayer(self))
      scripts\engine\sp\utility::smart_player_dialogue_interrupt(var_0);
    else if(isDefined(self.animname)) {
      self stopsounds();
      waitframe();
      scripts\engine\sp\utility::smart_dialogue(var_0);
    } else {
      if(issentient(self))
        self playsoundatviewheight(var_0);
      else
        self playSound(var_0);

      wait(lookupsoundlength(var_0) / 1000);
    }
  } else if(isstruct(self))
    scripts\engine\sp\utility::smart_radio_dialogue(var_0);
  else if(isPlayer(self))
    scripts\engine\sp\utility::smart_player_dialogue(var_0);
  else if(isDefined(self.animname))
    scripts\engine\sp\utility::smart_dialogue(var_0);
  else {
    if(issentient(self))
      self playsoundatviewheight(var_0);
    else
      self playSound(var_0);

    wait(lookupsoundlength(var_0) / 1000);
  }

  self notify("finished_say", var_0);
  return 1;
}

say_as_chatter(var_0, var_1, var_2, var_3) {
  return do_as_chatter(::say, [var_0, var_1], undefined, var_1, var_2, var_3);
}

say_sequence_as_chatter(var_0, var_1, var_2, var_3) {
  return do_as_chatter(::say_sequence, [var_0], undefined, var_1, var_2, var_3);
}

say_line_as_chatter_on_closest_ally(var_0, var_1, var_2, var_3) {
  return do_as_chatter(::say_line_on_closest_ally, [var_0], undefined, var_1, var_2, var_3);
}

wait_for_break_in_chatter(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_4 = 0.5;
  var_5 = 0;

  if(!level.vo_chatter.speaking)
    return 1;

  level.vo_chatter.waiting = scripts\engine\utility::array_add(level.vo_chatter.waiting, var_3);

  if(isDefined(var_0))
    var_5 = var_3 scripts\engine\utility::waittill_notify_or_timeout_return("proceed", var_0) == "timeout";
  else
    var_3 waittill("proceed");

  level.vo_chatter.waiting = scripts\engine\utility::array_remove(level.vo_chatter.waiting, var_3);
  return var_5;
}

do_as_chatter(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(!isDefined(level.vo_chatter))
    thread init_chatter();

  level.vo_chatter endon("terminate_chatter");
  var_8 = spawnStruct();
  thread do_as_chatter_internal(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_8);
  var_8 waittill("done", var_9);
  return var_9;
}

do_as_chatter_internal(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  level.vo_chatter endon("terminate_chatter");
  var_8 = 0.5;
  var_9 = gettime();

  if(level.vo_chatter.speaking && (!istrue(var_3) || isDefined(var_4)))
    var_10 = wait_for_break_in_chatter(var_4);
  else
    var_10 = 0;

  var_11 = undefined;

  if(!level.vo_chatter.speaking || !var_10 || istrue(var_3)) {
    if(!istrue(var_2))
      pause_chatter();

    level.vo_chatter notify("started_speaking", self, var_0, var_1);
    level.vo_chatter.speaking++;

    if(isDefined(var_4))
      var_4 = var_4 - (gettime() - var_9);
    else
      var_4 = var_8 * 4;

    if(var_4 > 0 && istrue(var_8))
      wait_combat_cooldown(var_8, var_4);

    var_11 = call_with_params(var_0, var_1);
    level.vo_chatter.speaking--;

    if(!istrue(var_2))
      resume_chatter();

    level.vo_chatter notify("done_speaking", self, var_0, var_1);
  }

  if(!level.vo_chatter.speaking && isDefined(level.vo_chatter.waiting[0]))
    level.vo_chatter.waiting[0] notify("proceed");

  var_7 notify("done", var_11);
}

pause_chatter() {
  if(!isDefined(level.vo_chatter)) {
    return;
  }
  level.vo_chatter.stopped++;
  level.vo_chatter notify("stop_chatter");
}

resume_chatter(var_0) {
  if(!level.vo_chatter.stopped) {
    return;
  }
  if(istrue(var_0))
    level.vo_chatter.stopped = 0;
  else
    level.vo_chatter.stopped--;

  level.vo_chatter notify("start_chatter");
}

say_line_on_closest_ally(var_0, var_1) {
  var_2 = getaiarray("allies");
  var_2 = scripts\engine\utility::array_removedead_or_dying(var_2);
  var_3 = sortbydistance(var_2, level.player.origin)[0];

  if(!isDefined(var_1))
    var_1 = 1;

  var_4 = gettime();

  while(!isDefined(var_3) || istrue(var_3 iswaitingonsound())) {
    waitframe();
    var_2 = scripts\engine\utility::array_removedead_or_dying(var_2);
    var_3 = sortbydistance(var_2, level.player.origin)[0];

    if(scripts\engine\utility::time_has_passed(var_4, var_1))
      return undefined;
  }

  if(var_3 == level.sas[0])
    level.sas[0] say(var_0[0]);
  else if(var_3 == level.sas[1])
    level.sas[1] say(var_0[1]);
  else if(isDefined(var_3.vo_index))
    var_3 say(var_0[var_3.vo_index]);
  else {
    if(!isDefined(level.police_vo_indexes))
      level.police_vo_indexes = scripts\engine\sp\utility::create_deck([2, 3]);

    if(!isDefined(var_3.animname))
      var_3.animname = "police_" + var_3 scripts\engine\utility::get_ai_number();

    var_3.vo_index = level.police_vo_indexes scripts\engine\sp\utility::deck_draw();
    var_3 say(var_0[var_3.vo_index]);
  }

  return var_3;
}

compare(var_0, var_1) {
  if(isarray(var_0)) {
    if(isarray(var_1))
      return compare_arrays(var_0, var_1);
    else
      return 0;
  } else if(isarray(var_1))
    return 0;
  else
    return var_0 == var_1;
}

compare_arrays(var_0, var_1) {
  if(var_0.size != var_1.size)
    return 0;

  foreach(var_5, var_3 in var_0) {
    if(!isDefined(var_1[var_5]))
      return 0;

    var_4 = var_1[var_5];

    if(compare(var_4, var_3))
      return 0;
  }

  return 1;
}

array_deck_shuffle() {
  var_0 = self;
  var_0.index = 0;
  var_0.items = scripts\engine\utility::array_randomize(var_0.items);

  if(!var_0.prevent_redraw || !isDefined(var_0.last_drawn) || var_0.items.size <= 1) {
    return;
  }
  var_1 = compare(var_0.items[0], var_0.last_drawn);

  if(var_1) {
    var_2 = randomintrange(1, var_0.items.size);
    var_3 = var_0.items[0];
    var_0.items[0] = var_0.items[var_2];
    var_0.items[var_2] = var_3;
  }
}

call_with_params(var_0, var_1) {
  if(isbuiltinfunction(var_0))
    return call_with_params_script(var_0, var_1);
  else if(isbuiltinmethod(var_0) || isanimation(var_0))
    return call_with_params_builtin(var_0, var_1);
  else {}
}

call_with_params_script(var_0, var_1) {
  if(!isDefined(var_1))
    return self[[var_0]]();

  if(!isarray(var_1))
    return self[[var_0]](var_1);

  switch (var_1.size) {
    case 0:
      return self[[var_0]]();
    case 1:
      return self[[var_0]](var_1[0]);
    case 2:
      return self[[var_0]](var_1[0], var_1[1]);
    case 3:
      return self[[var_0]](var_1[0], var_1[1], var_1[2]);
    case 4:
      return self[[var_0]](var_1[0], var_1[1], var_1[2], var_1[3]);
    case 5:
      return self[[var_0]](var_1[0], var_1[1], var_1[2], var_1[3], var_1[4]);
    case 6:
      return self[[var_0]](var_1[0], var_1[1], var_1[2], var_1[3], var_1[4], var_1[5]);
    case 7:
      return self[[var_0]](var_1[0], var_1[1], var_1[2], var_1[3], var_1[4], var_1[5], var_1[6]);
    case 8:
      return self[[var_0]](var_1[0], var_1[1], var_1[2], var_1[3], var_1[4], var_1[5], var_1[6], var_1[7]);
    case 9:
      return self[[var_0]](var_1[0], var_1[1], var_1[2], var_1[3], var_1[4], var_1[5], var_1[6], var_1[7], var_1[8]);
    default:
      break;
  }
}

call_with_params_builtin(var_0, var_1) {
  if(!isDefined(var_1))
    return self[[var_0]]();

  if(!isarray(var_1))
    return self call[[var_0]](var_1);

  switch (var_1.size) {
    case 0:
      return self call[[var_0]]();
    case 1:
      return self call[[var_0]](var_1[0]);
    case 2:
      return self call[[var_0]](var_1[0], var_1[1]);
    case 3:
      return self call[[var_0]](var_1[0], var_1[1], var_1[2]);
    case 4:
      return self call[[var_0]](var_1[0], var_1[1], var_1[2], var_1[3]);
    case 5:
      return self call[[var_0]](var_1[0], var_1[1], var_1[2], var_1[3], var_1[4]);
    case 6:
      return self call[[var_0]](var_1[0], var_1[1], var_1[2], var_1[3], var_1[4], var_1[5]);
    case 7:
      return self call[[var_0]](var_1[0], var_1[1], var_1[2], var_1[3], var_1[4], var_1[5], var_1[6]);
    case 8:
      return self call[[var_0]](var_1[0], var_1[1], var_1[2], var_1[3], var_1[4], var_1[5], var_1[6], var_1[7]);
    case 9:
      return self call[[var_0]](var_1[0], var_1[1], var_1[2], var_1[3], var_1[4], var_1[5], var_1[6], var_1[7], var_1[8]);
    default:
      break;
  }
}

forward_notify(var_0, var_1, var_2) {
  self endon("death");

  if(!isDefined(var_2))
    var_2 = self;

  var_2 endon("death");

  if(!isDefined(var_1))
    var_1 = var_0;

  self waittill(var_0);
  var_2 notify(var_1);
}

is_dead_or_dying(var_0) {
  if(!isDefined(var_0))
    return 1;

  if(isai(var_0))
    return !isalive(var_0) || var_0 scripts\engine\utility::doinglongdeath();
  else if(issentient(var_0))
    return !isalive(var_0);

  return 0;
}

create_nag(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  var_9 = spawnStruct();
  var_9.times_nagged = 0;
  var_0 = set_if_undefined(var_0, 1);
  var_1 = set_if_undefined(var_1, 1);
  var_2 = set_if_undefined(var_2, 999999999);
  var_3 = set_if_undefined(var_3, 999999999);
  var_4 = set_if_undefined(var_4, 0);
  var_5 = set_if_undefined(var_5, 0);
  var_6 = set_if_undefined(var_6, 1);
  var_7 = set_if_undefined(var_7, 1);
  var_8 = set_if_undefined(var_8, 1);
  var_9.starting_duration = var_0;
  var_9.starting_randomness = var_1;
  var_9.max_duration = var_2;
  var_9.max_randomness = var_3;
  var_9.duration_increase = var_4;
  var_9.randomness_increase = var_5;
  var_9.duration_multiplier = var_6;
  var_9.randomness_multiplier = var_7;
  var_9.nags_before_increase = var_8;
}

set_if_undefined(var_0, var_1) {
  if(!isDefined(var_0))
    return var_1;

  return var_0;
}

nag_wait() {
  var_0 = self;
  wait(randomfloatrange(var_0.duration - var_0.randomness, var_0.duration + var_0.randomness));
  var_0.times_nagged++;

  if(var_0.times_nagged % var_0.nags_before_increase == 0) {
    var_0.duration = min(var_0.duration + var_0.duration_increase, var_0.max_duration);
    var_0.duration = min(var_0.duration * var_0.duration_multiplier, var_0.max_duration);
    var_0.randomness = min(var_0.randomness + var_0.randomness_increase, var_0.max_randomness);
    var_0.randomness = min(var_0.randomness * var_0.randomness_multiplier, var_0.max_randomness);
  }
}

deck_nag(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  var_11 = create_nag(var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_10);
  deck_nag_internal(var_11, var_0, var_9);
  return var_11;
}

deck_nag_internal(var_0, var_1, var_2) {
  if(isDefined(var_2)) {
    level endon(var_2);
    self endon(var_2);
  }

  for(;;) {
    var_0 nag_wait();
    say(var_1 scripts\engine\sp\utility::deck_draw());
  }
}

track_player_weapon_fire_time() {
  level.player endon("death");
  var_0 = -9999;

  for(;;) {
    var_1 = level.player scripts\engine\utility::waittill_any_return("weapon_fired", "aim") == "weapon_fired";

    if(var_1) {
      level.player.last_weapon_fire_time = gettime();
      continue;
    }

    if(gettime() - var_0 > 50)
      level.player.last_weapon_aim_time = gettime();

    var_0 = gettime();
  }
}

wait_combat_cooldown(var_0, var_1, var_2) {
  while(!isDefined(var_1) || var_1 > 0) {
    if(!is_in_combat(var_0, var_2))
      return 0;

    waitframe();

    if(isDefined(var_1))
      var_1 = var_1 - 0.05;
  }

  return 1;
}

is_in_combat(var_0, var_1) {
  var_2 = isDefined(level.player.last_weapon_fire_time) && !scripts\engine\utility::time_has_passed(level.player.last_weapon_fire_time, var_0);
  var_3 = isDefined(level.player.last_weapon_aim_time) && !scripts\engine\utility::time_has_passed(level.player.last_weapon_aim_time, var_0);
  var_4 = level.player scripts\sp\player::damageflag(2);

  if(istrue(var_1)) {
    var_5 = getaiarrayinradius(level.player.origin, var_1, "axis");

    foreach(var_7 in var_5) {
      if(!scripts\engine\utility::time_has_passed(var_7 ai_last_weapon_fire_time(), var_0))
        return 1;
    }
  }

  return level.player isfiring() || var_2 || var_3 || var_4;
}

ai_last_weapon_fire_time() {
  if(!isDefined(self.a) || !isDefined(self.a.lastshoottime))
    return 0;

  return self.a.lastshoottime;
}

ai_is_shooting() {
  if(isDefined(self._blackboard)) {
    if(istrue(self._blackboard.bfire))
      return 1;

    if(istrue(self._blackboard.shootparams_starttime) && gettime() - self._blackboard.shootparams_starttime < 250)
      return 1;
  }

  return 0;
}

get_random_civilian_speed() {
  var_0 = getdvarint("LSKTNKPTRT", 170);
  var_1 = getdvarint("MNMNLKRRQP", 230);

  if(var_1 <= var_0)
    var_1 = var_0 + 1;

  return randomintrange(var_0, var_1);
}

osa_distance(var_0, var_1) {
  var_2 = var_0.size;
  var_3 = var_1.size;
  var_4 = [];

  for(var_5 = 0; var_5 <= var_2; var_5++) {
    var_4[var_5] = [];
    var_4[var_5][0] = var_5;
  }

  for(var_6 = 0; var_6 <= var_3; var_6++)
    var_4[0][var_6] = var_6;

  for(var_5 = 1; var_5 <= var_2; var_5++) {
    for(var_6 = 1; var_6 <= var_3; var_6++) {
      var_7 = var_0[var_5 - 1] != var_1[var_6 - 1];
      var_4[var_5][var_6] = min(min(var_4[var_5][var_6 - 1] + 1, var_4[var_5 - 1][var_6] + 1), var_4[var_5 - 1][var_6 - 1] + var_7);

      if(var_5 > 1 && var_6 > 1 && var_0[var_5 - 1] == var_1[var_6 - 2] && var_0[var_5 - 2] == var_1[var_6 - 1])
        var_4[var_5][var_6] = min(var_4[var_5][var_6], var_4[var_5 - 2][var_6 - 2] + var_7);
    }
  }

  return var_4[var_2][var_3];
}

osa_percentile(var_0, var_1) {
  var_2 = max(var_0.size, var_1.size);
  return 1 - osa_distance(var_0, var_1) / var_2;
}

mark_all_civs() {
  for(;;) {
    var_0 = getEntArray();

    foreach(var_2 in var_0) {
      if(!isDefined(var_2)) {
        continue;
      }
      if(!issentient(var_2))
        continue;
    }

    waitframe();
  }
}

display_all_ent_names(var_0) {
  for(;;) {
    if(isDefined(var_0))
      var_1 = getentarrayinradius(undefined, undefined, level.player.origin, var_0);
    else
      var_1 = getaiarray();

    foreach(var_3 in var_1) {
      if(!isDefined(var_3)) {
        continue;
      }
      var_4 = 70;
      var_5 = 3.5;

      if(isDefined(var_3.classname))
        var_4 = var_4 + var_5;

      var_6 = var_3.script_noteworthy;

      if(isDefined(var_6)) {
        var_6 = var_3 get_value_with_index(var_6, "script_noteworthy");
        var_4 = var_4 + var_5;
      }

      var_6 = var_3.targetname;

      if(isDefined(var_6)) {
        var_6 = var_3 get_value_with_index(var_6, "targetname");
        var_4 = var_4 + var_5;
      }

      if(isDefined(var_3.voice))
        var_4 = var_4 + var_5;

      if(isDefined(var_3.animname))
        var_4 = var_4 + var_5;
    }

    waitframe();
  }
}

get_value_with_index(var_0, var_1) {
  var_2 = getEntArray(var_0, var_1);

  if(var_2.size == 1)
    return var_0;

  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    if(var_2[var_3] == self)
      return var_0 + " [" + var_3 + "]";
  }

  return var_0;
}

display_all_last_anims(var_0) {
  for(;;) {
    var_1 = getEntArray();

    foreach(var_3 in var_1) {
      if(!isDefined(var_3) || !isDefined(var_3.animname) || !isDefined(var_3._lastanime)) {
        continue;
      }
      if(isDefined(var_0) && var_3.animname != var_0) {
        continue;
      }
      if(var_3 tagexists("j_head")) {
        var_4 = var_3 gettagorigin("j_head");
        continue;
      }

      var_4 = var_3.origin + (0, 0, 60);
    }

    waitframe();
  }
}

get_last_anim_name() {
  return getanimname(scripts\engine\utility::getanim(self._lastanime));
}

get_last_anim_frame() {
  return int((gettime() - self.last_anim_time) / 1000 * 30);
}

print_last_anim_info(var_0) {
  var_1 = get_last_anim_name();
  var_2 = get_last_anim_frame();
  scripts\engine\utility::launcher_write_clipboard(var_1 + " | Frame " + var_2 + " | " + var_0);
}

easy_position_creator() {
  for(;;) {
    while(!level.player buttonPressed("button_back"))
      waitframe();

    self notify("position_created");
    thread new_position("position_created");

    while(level.player buttonPressed("button_back"))
      waitframe();
  }
}

new_position(var_0) {
  if(isDefined(var_0))
    self endon(var_0);

  var_1 = anglesToForward(level.player getplayerangles());
  var_2 = scripts\engine\trace::ray_trace_detail(level.player getEye(), level.player getEye() + var_1 * 1000, level.player);
  var_3 = var_2["position"];
  var_4 = 40;
  var_5 = 0;
  scripts\engine\utility::launcher_write_clipboard("is_near ( " + var_3 + ", " + var_4 + " );");

  for(;;) {
    draw_cool_circle(var_3, var_4, var_5);

    if(level.player buttonPressed("dpad_right")) {
      var_4 = var_4 + 2;
      scripts\engine\utility::launcher_write_clipboard("is_near ( " + var_3 + ", " + var_4 + " );");
    } else if(level.player buttonPressed("dpad_left")) {
      var_4 = var_4 - 2;
      scripts\engine\utility::launcher_write_clipboard("is_near ( " + var_3 + ", " + var_4 + " );");
    }

    waitframe();
  }
}

draw_cool_circle(var_0, var_1, var_2) {
  var_3 = 50;

  for(var_4 = 0; var_4 < var_3; var_4++) {
    scripts\engine\utility::draw_circle(var_0 + (0, 0, var_2), var_1, (1, 1, 1), 1 - var_4 / var_3, 1, 1);
    var_2 = var_2 + 0.5 * (var_1 / 80);
  }
}