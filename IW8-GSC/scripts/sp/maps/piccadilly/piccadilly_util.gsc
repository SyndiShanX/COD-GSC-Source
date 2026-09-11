/**********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\maps\piccadilly\piccadilly_util.gsc
**********************************************************/

function shadow_manager(var0) {
  self endon("death");

  if(!isDefined(var0)) {
    var0 = 600;
  }

  var1 = var0 * var0;

  for(;;) {
    while(distancesquared(self.origin, level.player.origin) < var1) {
      wait 1;
    }

    self dontcastshadows();

    while(distancesquared(self.origin, level.player.origin) > var1) {
      wait 1;
    }

    self castshadows();
  }
}

function generic_damage_monitor() {
  while(isalive(self)) {
    self waittill("damage", var0, var1, var2, var2, var3, var2, var2, var2, var2, var4, var2, var2, var2, var5);

    if(!isai(self)) {
      if(isDefined(var1)) {
        self.lastattacker = var1;
      }

      if(isDefined(var3)) {
        self.damagemod = var3;
      }
    }
  }
}

function acievement_monitor() {
  level endon("stop_monitoring_acievement");
  self endon("entitydeleted");
  self endon("stop_monitor_achievement");
  self dontcastshadows();

  while(isalive(self)) {
    scripts\engine\utility::waittill_any_return("damage", "death");
    waittillframeend();
    var0 = undefined;

    if(isDefined(self.lastattacker)) {
      var0 = self.lastattacker;
    }

    if(!isDefined(var0)) {
      continue;
    }

    if(self.behaviortreeasset == "civilian" && isDefined(var0) && var0 == level.player) {
      if(getdvarint("scr_debug_achievement")) {}

      print_no_achievement();
      level.gotachievement = 0;
      level notify("stop_monitoring_acievement");
      return;
    }
  }
}

function print_no_achievement() {
  if(isDefined(self.targetname)) {
    var0 = self.targetname;
  } else {
    var0 = "none";
  }

  if(isDefined(self.animname)) {
    var1 = self.animname;
    return;
  }

  var1 = "none";
}

function check_player_psycho(var0) {
  self endon("entitydeleted");

  for(;;) {
    self waittill("friendlyfire_notify", var1, var2, var3, var4, var5, var6);

    if(isDefined(var6) && isDefined(var2) && var2 == level.player) {
      if(!mydeathaccidental()) {
        thread civdeathinstafail();
        return;
      }
    }
  }
}

function mydeathaccidental() {
  var0 = getaiarrayinradius(self.origin, 2000, "axis");

  foreach(var2 in var0) {
    if(in_screen_center(var2.origin + (0, 0, 25), 130)) {
      if(sighttrace_from_player(var2)) {
        if(getdvarint("scr_instafail_debug")) {}

        return true;
      }
    }
  }

  var4 = level.player scripts\sp\friendlyfire::get_most_recent_dmg_or_death_time();

  if(gettime() - var4 <= 1000) {
    if(getdvarint("scr_instafail_debug")) {}

    return true;
  }

  if(getdvarint("scr_instafail_debug")) {}

  return false;
}

function in_screen_center(var0, var1) {
  var2 = level.player worldpointtoscreenpos(var0, level.player.currentfov);

  if(isDefined(var2)) {
    var3 = length2dsquared(var2);

    if(getdvarint("scr_instafail_debug")) {}

    var4 = scripts\engine\utility::ter_op(isDefined(var1), squared(var1), 2500);

    if(var3 <= var4) {
      if(getdvarint("scr_instafail_debug")) {}

      return true;
    }
  }

  return false;
}

function sighttrace_from_player(var0) {
  var1 = level.player getEye();
  var2 = var0.origin;

  if(sighttracepassed(var1, var2, 0, level.player, var0)) {
    return true;
  }

  var3 = var0 getEye();

  if(sighttracepassed(var1, var3, 0, level.player, var0)) {
    return true;
  }

  var4 = (var3 + var2) * 0.5;

  if(sighttracepassed(var1, var4, 0, level.player, var0)) {
    return true;
  }

  return false;
}

function civdeathinstafail() {
  if(getdvarint("scr_instafail_debug")) {
    iprintlnbold("INSTAFAIL");
    return;
  }

  level thread scripts\sp\hud_util::fade_out(0);
  scripts\sp\player_death::set_custom_death_quote(scripts\engine\utility::array_randomize([9, 30])[0]);
  scripts\sp\utility::missionfailedwrapper();
}

function is_upright() {
  return self gettagorigin("tag_eye")[2] - self.origin[2] > 30;
}

function music_transition() {
  if(scripts\sp\starts::is_after_start("hostage")) {
    return;
  }

  setmusicstate("mx_piccadilly_battleintro_lp");
}

function colornode_arrived_func(var0) {
  self endon("death");

  if(istrue(self.tryingcolorgesture)) {
    return;
  }

  self.tryingcolorgesture = 1;

  if(istrue(self.providecoveringfire)) {
    self.providecoveringfire = 0;
  }

  if(!isDefined(self.lastgesturetime)) {
    self.lastgesturetime = gettime();
  } else if(gettime() - self.lastgesturetime < 7000) {
    self.tryingcolorgesture = 0;
    return;
  } else {
    self.lastgesturetime = gettime();
  }

  childthread scripts\asm\gesture::ai_request_gesture("advance");
  wait 3;
  self waittill("goal");

  if(isDefined(self.enemy)) {
    childthread scripts\asm\gesture::ai_request_gesture("military_point", self.enemy);
  } else {
    childthread scripts\asm\gesture::ai_request_gesture("getdown");
  }

  self.tryingcolorgesture = undefined;
}

function notify_nearby_casual_killers(var0, var1) {
  var2 = getaiarrayinradius(var1, 500, "axis");

  if(var2.size) {
    scripts\engine\utility::array_thread(var2, &scripts\engine\sp\utility::notify_delay, "stop_killing_civs", 0.4 + randomfloat(0.8));
    return;
  }
}

function clear_favorite_enemy(var0) {
  wait var0;
  self.favoriteenemy = undefined;
}

function kill_civs_til_player_sees_me() {
  self endon("death");

  while(self isinscriptedstate()) {
    waitframe();
  }

  self setthreatbiasgroup("kill_civs");
  var0 = 1;
  scripts\asm\juggernaut\juggernaut::enable_casual_killer();
  var1 = getdvarfloat("NSPNRRQRLN", 0.91);
  var2 = getdvarfloat("NOPOKQNMR", 1.06);

  if(var2 <= var1) {
    var2 = var1 + 0.01;
  }

  self.speedscalemult = randomfloatrange(var1, var2);
  civ_killer_internal();
  thread notify_nearby_casual_killers(level, self);
  var3 = self.enemy;
  self setthreatbiasgroup("axis");
  self notify("stop_going_to_node");
  scripts\asm\juggernaut\juggernaut::disable_casual_killer();
  self.favoriteenemy = level.player;
  self forcethreatupdate();
  thread clear_favorite_enemy(5);

  if(istrue(self.ignoreme)) {
    self.ignoreme = 0;
  }

  while(isDefined(self.enemy) && isDefined(var3) && !isPlayer(self.enemy) && self.enemy == var3) {
    waitframe();
  }

  if(!isDefined(self.enemy)) {
    self getenemyinfo(level.player);
  }

  while(!isDefined(self.enemy)) {
    waitframe();
  }

  while(istrue(self.casualkiller)) {
    waitframe();
  }

  if(isDefined(self.weapon.classname) && self.weapon.classname == "mg") {
    scripts\engine\utility::set_movement_speed(randomfloatrange(130, 150));
    self.maxfaceenemydist = 512;
    waitframe();
    charge_enemy(5);
  }

  self.goalradius = 700;
  self notify("civ_killer_end");
}

function charge_enemy(var0) {
  self endon("death");

  if(isPlayer(self.enemy)) {
    var1 = self.enemy;
    self setgoalentity(var1);
    var2 = gettime() + var0 * 1000;
    self.goalradius = 32;
    self.meleechargedistvsplayer = 400;
    self.meleemaxzdiff = 500;
    self.meleetargetallowedoffmeshdistsq = 225;
    self.meleetryhard = 1;

    while(isalive(self.enemy) && isalive(var1) && self.enemy == var1 && gettime() < var2) {
      self setgoalentity(var1);
      var3 = distance2d(self.origin, var1.origin);

      if(var3 < 150 && abs(self.lookaheaddist - var3) < 20) {
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

function civ_killer_internal() {
  self endon("stop_killing_civs");
  var0 = 0;
  var1 = 60;
  var2 = 0;
  var3 = 120;
  var4 = cos(10);
  var5 = cos(45);
  var6 = gettime();
  var7 = 0;

  for(;;) {
    if(isDefined(self.lastattacker) && (isPlayer(self.lastattacker) || scripts\engine\utility::within_fov(level.player.origin, level.player.angles, self.origin, cos(75)))) {
      break;
    }

    var8 = scripts\engine\trace::ray_trace_passed(level.player getEye(), self getEye(), [level.player, self], scripts\engine\trace::create_contents(1, 1, 0, 1, 0, 1, 0, 1, 1));

    if(distancesquared(self.origin, level.player.origin) <= 90000 && var8) {
      break;
    }

    if(!istrue(self.ignoreme) && distancesquared(self.origin, level.player.origin) <= 640000 && scripts\engine\utility::within_fov(level.player.origin, level.player.angles, self.origin, var4) && var8) {
      var0++;

      if(var0 == var1) {
        break;
      }

      if(!istrue(var7) && isDefined(level.player.lastweaponfiredtime) && gettime() - level.player.lastweaponfiredtime <= 500) {
        break;
      }
    } else if(!istrue(self.ignoreme) && distancesquared(self.origin, level.player.origin) <= 1440000 && scripts\engine\utility::within_fov(level.player.origin, level.player.angles, self.origin, var5) && var8) {
      var2++;

      if(var2 == var3) {
        break;
      } else if(isDefined(self._blackboard) && istrue(self._blackboard.shootparams_starttime) && gettime() - self._blackboard.shootparams_starttime >= 3000) {
        break;
      }
    } else {
      var9 = 0;
    }

    waitframe();
  }
}

function open_goalradius_on_player_sight() {
  self endon("death");
  waitframe();

  if(istrue(self.using_goto_node)) {
    scripts\engine\utility::waittill_any("reached_path_end", "stop_going_to_node");
  }

  var0 = 0;

  for(;;) {
    if(distancesquared(self.origin, level.player.origin) <= 640000 && player_sees_my_location()) {
      var0++;

      if(var0 == 15) {
        break;
      }
    } else {
      var0 = 0;
    }

    waitframe();
  }

  if(istrue(self.fixednode)) {
    self.fixednode = 0;
  }

  self.goalradius = 2048;
  scripts\aitypes\cover::lookforbettercover_internal(self.covernode);
}

function player_sees_my_location() {
  if(level.player scripts\engine\trace::can_see_origin(self.origin, 0)) {
    return true;
  }

  if(level.player scripts\engine\trace::can_see_origin(self getEye(), 0)) {
    return true;
  }

  var0 = self.origin + (0, 0, 60) + anglestoright(self.angles) * 25;

  if(level.player scripts\engine\trace::can_see_origin(var0, 0)) {
    return true;
  }

  var1 = self.origin + (0, 0, 60) + anglestoright(self.angles) * -1 * 25;

  if(level.player scripts\engine\trace::can_see_origin(var1, 0)) {
    return true;
  }

  return false;
}

function waittill_within_fov_from_dist(var0, var1, var2) {
  self endon("death");
  var3 = 0;
  var4 = scripts\engine\utility::ter_op(isDefined(var2), var2, 20);
  var0 = squared(var0);

  for(;;) {
    if(distancesquared(self.origin, var1) <= var0 && scripts\engine\trace::can_see_origin(var1, 0)) {
      var3++;

      if(var3 == var4) {
        return;
      }
    } else {
      var3 = 0;
    }

    waitframe();
  }
}

function lerp_fov_over_dist(var0, var1, var2) {
  level.player endon("stop_lerp_fov");
  level.player modifybasefov(var1, 0.2);
  var3 = scripts\engine\utility::getStruct(var0, "targetname");
  var4 = scripts\engine\utility::getStruct(var3.target, "targetname");
  var5 = distance(var3.origin, var4.origin);
  var6 = 0;

  for(;;) {
    var7 = pointonsegmentnearesttopoint(var3.origin, var4.origin, level.player.origin);
    var8 = distance(var7, var3.origin);
    var9 = var8 / var5;

    if(var9 > var6) {
      var6 = var9;
      var10 = scripts\engine\math::factor_value(var1, var2, var9);
      level.player modifybasefov(var10, 0.2);
    }

    if(var9 == 1) {
      break;
    }

    waitframe();
  }
}

function get_closest_bomber_target() {
  self endon("death");
  var0 = [];

  foreach(var2 in level.piccadilly.civilians) {
    if(isai(var2)) {
      var0 = var2;
    }
  }

  if(!isalive(self)) {
    return;
  }

  var4 = getaiarray("allies");
  var5 = scripts\engine\utility::array_combine(var0, var4);
  var6 = sortbydistance(var5, self.origin)[0];

  if(isDefined(self) && isalive(var6) && distance(var6.origin, self.origin) < distance(self.bombertarget.origin, self.origin)) {
    bomber_set_target(var6);
    return;
  }
}

function bomber_set_detonation_dist_squared(var0) {
  self.bomberexplodedistance = var0;
}

function bomber_set_target(var0) {
  self.bombertarget = var0;
  self getenemyinfo(var0);
}

function initanimteddoor(var0, var1, var2, var3) {
  var4 = getstartorigin(var0.origin, var0.angles, var2);
  var5 = getstartangles(var0.origin, var0.angles, var2);
  var6 = scripts\engine\sp\utility::spawn_anim_model("animated_door", var4, var5);
  var7 = getEntArray(var1, "targetname");
  var8 = undefined;
  var9 = undefined;
  var10 = undefined;

  foreach(var12 in var7) {
    if(var12.classname == "script_brushmodel") {
      var8 = var12;
    }

    if(var12.classname == "script_model") {
      var10 = var12;
      continue;
    }

    if(var12.classname == "script_origin") {
      var9 = var12;
    }
  }

  if(isDefined(var10)) {
    var10 linkTo(var9);
  }

  var8 linkTo(var9);

  if(isDefined(var3)) {
    var9 linkTo(var6, "tag_origin", (0, 0, 0), (0, 0, 0));
  } else {
    var9 linkTo(var6);
  }

  var6.prop = var8;
  return var6;
}

function waittill_player_looks_or_timeout(var0, var1) {
  level.player endon("death");
  level endon("lookat_timeout");
  level thread scripts\engine\sp\utility::notify_delay("lookat_timeout", var1);
  var2 = cos(50);

  while(!scripts\engine\utility::within_fov(level.player.origin, level.player getplayerangles(), var0, var2)) {
    wait 0.05;
  }
}

function has_ceiling() {
  var0 = scripts\engine\trace::create_contents(0, 1, 1, 1, 0, 0, 1, 0);
  return !scripts\engine\trace::ray_trace_passed(self.origin, self.origin + (0, 0, 1200), self, var0);
}

function ragdoll_death_after_anim() {
  self waittillmatch("single anim", "end");

  if(isDefined(self.magic_bullet_shield)) {
    scripts\common\ai::stop_magic_bullet_shield();
  }

  if(self islinked()) {
    self unlink();
  }

  self.ragdoll_immediate = 1;
  self.allowdeath = 1;
  scripts\engine\sp\utility::die();
}

function get_longest_animating_ent(var0, var1) {
  var2 = var0[0];
  var3 = getanimlength(var2 scripts\engine\utility::getanim(var1));

  for(var4 = 1; var4 < var0.size; var4++) {
    var5 = getanimlength(var0[var4] scripts\engine\utility::getanim(var1));

    if(var5 > var3) {
      var3 = var5;
      var2 = var0[var4];
    }
  }

  return var2;
}

function spawn_sas_redshirts() {
  if(isDefined(level.street_friendlies)) {
    scripts\engine\utility::array_thread(level.street_friendlies, &scripts\common\ai::stop_magic_bullet_shield);
    level.ctbuddy = level.street_friendlies[0];
    level.ctpassenger = level.street_friendlies[1];
  } else {
    var0 = getspawnerarray("sicario_street_friendly");
    level.ctbuddy = var0[0] scripts\engine\sp\utility::spawn_ai(1);
    level.ctpassenger = var0[1] scripts\engine\sp\utility::spawn_ai(1);
  }

  level.sas = [level.ctbuddy, level.ctpassenger];
  level.sas = scripts\engine\utility::array_removedead(level.sas);
  level.sas = scripts\engine\utility::array_removeundefined(level.sas);
  scripts\engine\utility::flag_set("ally_setup_done");
  scripts\engine\utility::array_thread(level.sas, &scripts\engine\sp\utility::set_force_color, "y");
  scripts\engine\utility::array_thread(level.sas, &disable_covering_fire);
}

function disable_covering_fire() {
  self.providecoveringfire = 0;
}

function disable_sas_color() {
  if(isDefined(level.sas)) {
    foreach(var1 in level.sas) {
      if(isalive(var1)) {
        var1 scripts\engine\sp\utility::disable_ai_color();
      }
    }

    return;
  }
}

function spawn_price() {
  level.price = scripts\engine\sp\utility::spawn_targetname("price", 1);
  level.price.goalradius = 32;
  level.price scripts\engine\sp\utility::set_force_color("o");
  level.price.script_pushable = 0;
  level.price.anim_playvo_func = &scripts\engine\utility::playsoundontag;
  thread price_face_swap();
  level.price enableavoidance(0);
  return level.price;
}

function price_face_swap() {
  self detach(self.headmodel);
  self.headmodel = "head_hero_price";
  self attach(self.headmodel);
}

function spawn_price_redshirt() {
  var0 = scripts\engine\sp\utility::spawn_targetname("price_sas", 1);
  var0 thread scripts\common\ai::magic_bullet_shield();
  var0.goalradius = 32;
  return var0;
}

function breadcrumb_objective(var0, var1) {
  var2 = scripts\engine\utility::getclosest(level.player.origin, var1);
  var3 = undefined;
  var4 = var2;

  for(;;) {
    for(;;) {
      var5 = sortbydistance(var1, level.player.origin)[0];

      if(abs(var5.origin[2] - level.player.origin[2]) < 60 && distancesquared(level.player.origin, var5.origin) < squared(var5.radius)) {
        var2 = var5;
        break;
      }

      wait 0.05;
    }

    if(isDefined(var2.target)) {
      if(var2 == var4 && distancesquared(level.player.origin, var2.origin) > squared(var2.radius)) {
        var3 = var4;
      } else {
        var3 = scripts\engine\utility::getStruct(var2.target, "targetname");
      }

      scripts\engine\sp\objectives::objective_update(var0, undefined, var3.origin);

      while(distancesquared(level.player.origin, var2.origin) < squared(var2.radius)) {
        wait 0.05;
      }
    } else {
      return;
    }

    wait 0.05;
  }
}

function crowd_screams(var0, var1, var2) {
  thread scripts\engine\utility::play_sound_in_space("scared_crowd_screams", var0);
}

function piccadilly_spawnStruct() {
  if(!isDefined(level.piccadilly)) {
    level.piccadilly = spawnStruct();
    return;
  }
}

function piccadilly_weapons() {
  if(level.start_point == "trailer_car_jumper") {
    return;
  }

  var0 = [];
  var1 = [];

  if(scripts\sp\starts::is_after_start("combat")) {
    var0 = "iw8_ar_akilo47";
    var0 = "iw8_pi_papa320";
  } else {
    var0 = "iw8_pi_papa320";
  }

  foreach(var4, var3 in var0) {
    if(var3 == "iw8_pi_papa320") {
      var1 = scripts\sp\utility::make_weapon_special("papa320_black_rain");
    } else {
      var1 = scripts\sp\utility::make_weapon(var3);
    }

    level.player giveweapon(var1[var4], 0, 0, 0, 1);

    if(var3 == "iw8_pi_papa320" && getdvarint("TTMRSTRO") <= 1) {
      level.player setweaponammostock("iw8_pi_papa320", 40);
    }
  }

  level.player switchtoweaponimmediate(var1[0]);
  level.player setshadowmodel("default_character_shadow");
  level.player setviewmodel("viewhands_kyle_sas_urban");
  scripts\sp\utility::context_melee_set_arms("viewhands_kyle_sas_urban");
}

function notetrack_nag(var0, var1, var2) {
  level endon(var1);
  jumpiffalse(isDefined(var2)) LOC_00000010;
  level endon(var2);

  for(;;) {
    foreach(var4 in var0) {
      self waittill("nag");
      scripts\engine\sp\utility::smart_dialogue(var4);
    }

    level.player thread scripts\sp\player::focus_display_hint(undefined, 6);
  }
}

function raindrop_fx_manager() {
  var0 = scripts\engine\utility::spawn_tag_origin();
  thread raindrop_fx_thread();
  var1 = getEntArray("turn_off_exterior_fx", "script_noteworthy");

  foreach(var3 in var1) {
    thread raindrop_fx_trigger_think(var3, var0);
  }
}

function raindrop_fx_thread() {
  self endon("stop_raindrop_fx");
  level notify("stop_rain_brute_force");
  level endon("stop_rain_brute_force");
  var0 = "tag_origin";

  for(var1 = 0;; var1 = 0) {
    wait 0.3;
    var2 = angleclamp180(level.player getplayerangles()[0]);

    if(var2 < -35 && !var1) {
      self.currentfx = "vfx_pic_rain_screenfx_up";
      playFXOnTag(level._effect[self.currentfx], self, "tag_origin");
      var1 = 1;
      continue;
    }

    if(var2 >= -35 && var1) {
      if(isDefined(self.currentfx)) {
        stopFXOnTag(level._effect[self.currentfx], self, "tag_origin");
      }
    }
  }
}

function raindrop_fx_trigger_think(var0, var1) {
  for(;;) {
    var0 waittill("trigger", var2);
    var1 notify("stop_raindrop_fx");

    if(isDefined(var1.currentfx)) {
      stopFXOnTag(level._effect[var1.currentfx], var1, "tag_origin");
      var1.currentfx = undefined;
    }

    while(isalive(var2) && isDefined(var0) && var2 istouching(var0)) {
      wait 0.05;
    }

    thread raindrop_fx_thread();
  }
}

function picc_spawn_ai(var0, var1) {
  make_room_for_ai();
  var2 = getspawner(var0, "targetname");
  var3 = var2 scripts\engine\sp\utility::spawn_ai(1, var1);
  var3.animname = var3.targetname;
  var3 setgoalpos(var3.origin);
  return var3;
}

function make_room_for_ai(var0, var1, var2) {
  if(!isDefined(var0)) {
    var0 = 30;
  }

  if(!isDefined(var1)) {
    var1 = "civilian";
  }

  if(!isDefined(var2)) {
    var2 = 0;
  }

  if(var1 == "civilian") {
    if(getaicount() <= var0) {
      return;
    }

    debug_print("deleting civ because we're out of space: " + getaicount() + " Allowed: " + var0);
    var3 = [];

    foreach(var5 in getaiarray()) {
      if(var5.asmname == "civilian") {
        var3 = var5;
      }
    }

    var7 = find_ai_to_kill(var3);

    if(isDefined(var7.magic_bullet_shield)) {
      var7 scripts\common\ai::stop_magic_bullet_shield();
    }

    var7 kill();

    while(var2 && level.piccadilly.civilians.size > var0) {
      var7 = find_ai_to_kill(var3);

      if(isDefined(var7.magic_bullet_shield)) {
        var7 scripts\common\ai::stop_magic_bullet_shield();
      }

      var7 kill();
      waitframe();
    }

    return;
  }

  if(var1 == "enemy" || var1 == "axis") {
    if(getaicount("axis") <= var0) {
      return;
    }

    debug_print("deleting enemy because we're out of space: " + getaicount("axis") + " Allowed: " + var0);
    var8 = find_ai_to_kill(getaiarray("axis"));
    var8 kill();

    while(var2 && getaicount("axis") > var0) {
      var8 = find_ai_to_kill(getaiarray("axis"));
      var8 kill();
      waitframe();
    }

    return;
  }
}

function find_ai_to_kill(var0) {
  var0 = scripts\engine\utility::array_removedead_or_dying(var0);
  var1 = scripts\engine\utility::array_sort_with_func(var0, &starttime_compare);

  foreach(var3 in var0) {
    var3.normalized_starttime = 1 - scripts\engine\math::normalize_value(var1[0].starttime, var1[var1.size - 1].starttime, var3.starttime);
  }

  var1 = sortbydistance(var0, level.player.origin);

  foreach(var3 in var0) {
    var3.normalized_distance = scripts\engine\math::normalize_value(distance2dsquared(level.player.origin, var1[0].origin), distance2dsquared(level.player.origin, var1[var1.size - 1].origin), distance2dsquared(level.player.origin, var3.origin));
  }

  foreach(var3 in var0) {
    var3.normalized_kill = var3.normalized_starttime + var3.normalized_distance;
  }

  var1 = scripts\engine\utility::array_sort_with_func(var0, &normalize_compare);

  foreach(var3 in var1) {
    if(!scripts\anim\utility_common::player_can_see_ai(level.player, var3)) {
      return var3;
    }
  }

  return var1[0];
}

function starttime_compare(var0, var1) {
  return var0.starttime <= var1.starttime;
}

function distance_compare(var0, var1) {
  var2 = distance2dsquared(level.player.origin, var0.origin);
  var3 = distance2dsquared(level.player.origin, var1.origin);
  return var2 >= var3;
}

function normalize_compare(var0, var1) {
  return var0.normalized_kill >= var1.normalized_kill;
}

function make_room_and_activate_trigger(var0, var1, var2, var3, var4) {
  scripts\engine\sp\utility::activate_trigger(var3, var4, level.player);
  scripts\engine\utility::delaythread(0.1, &make_room_for_ai, var0, var1, var2);
}

function enemy_spawn_logic() {
  make_room_for_ai();
}

function block_while_alive(var0) {
  foreach(var2 in var0) {
    while(isDefined(var2) && isalive(var2)) {
      waitframe();
    }
  }
}

function block_while_enemy_count(var0) {
  level endon("stop enemy count");
  level.player endon("death");

  for(;;) {
    var1 = getaicount("axis");

    if(var1 <= var0) {
      return;
    }

    waitframe();
  }
}

function player_heartbeat() {
  level endon("stop_player_heartbeat");

  for(;;) {
    self playlocalsound("breathing_heartbeat");
    wait 0.5;
  }
}

function set_goal_volume_for_substr(var0, var1, var2) {
  var3 = getaiarray("axis");
  var4 = getEnt(var0, "targetname");

  foreach(var6 in var3) {
    if(isDefined(var6.script_noteworthy) && var6.script_noteworthy == "ignore_goalvolumes") {
      var3 = scripts\engine\utility::array_remove(var3, var6);
    }
  }

  foreach(var6 in var3) {
    if(isDefined(var6.script_goalvolume) && issubstr(var6.script_goalvolume, var1)) {
      continue;
    }

    var3 = scripts\engine\utility::array_remove(var3, var6);
  }

  if(isDefined(var2)) {
    foreach(var6 in var3) {
      if(!isDefined(var6)) {
        continue;
      }

      var6 setgoalvolumeauto(var4);
      wait randomfloatrange(0.25, 1);
    }
  } else {
    scripts\engine\utility::array_call(var3, &setgoalvolumeauto, var4);
  }

  return var3;
}

function set_goal_volume_for_all(var0, var1) {
  var2 = getaiarray("axis");
  var3 = getEnt(var0, "targetname");

  foreach(var5 in var2) {
    if(isDefined(var5.script_noteworthy) && var5.script_noteworthy == "ignore_goalvolumes") {
      var2 = scripts\engine\utility::array_remove(var2, var5);
    }
  }

  if(isDefined(var1)) {
    foreach(var5 in var2) {
      var5 setgoalvolumeauto(var3);
      wait randomfloatrange(0.25, 1);
    }
  } else {
    scripts\engine\utility::array_call(var2, &setgoalvolumeauto, var3);
  }

  return var2;
}

function turn_off_flood_spawner(var0) {
  var1 = getEnt(var0, "script_noteworthy");
  var2 = getspawnerarray(var1.target);

  foreach(var4 in var2) {
    var4.count = 0;
  }
}

function ai_turret_shoot(var0, var1) {
  self endon("death");
  var0 endon("death");

  if(!isDefined(var1)) {
    var1 = 1;
  }

  for(;;) {
    if(!var1 || self cansee(var0)) {
      magicbullet(self.weapon, self gettagorigin("tag_flash"), var0.origin + anglestoup(var0.angles) * randomintrange(35, 60) + anglestoright(self.angles) * randomintrange(-48, 48));
      wait randomfloatrange(0.2, 0.5);
      continue;
    }

    waitframe();
  }
}

function show_all_cover_nodes() {
  wait 1;
  var0 = getallnodes();

  foreach(var2 in var0) {
    if(isDefined(var2.script_color_allies)) {}
  }

  var4 = getarraykeys(level.arrays_of_colorcoded_nodes["allies"]);

  foreach(var6 in var4) {
    foreach(var2 in level.arrays_of_colorcoded_nodes["allies"][var6]) {}
  }
}

function veh_magic_bullet_array(var0) {
  foreach(var2 in var0) {
    var3 = self.origin + (0, 0, var2[0]) + anglesToForward(self.angles) * var2[2] + anglestoright(self.angles) * var2[4];
    var4 = self.origin + (0, 0, var2[1]) + anglesToForward(self.angles) * var2[3];
    magicbullet("iw8_ar_mike4", var3, var4);

    if(!isDefined(var2[5])) {
      waitframe();

      if(scripts\engine\utility::cointoss()) {
        waitframe();
      }
    }

    waitframe();
  }
}

function start_player_anim(var0) {
  level.player_rig show();
  level.player allowmovement(0);
  level.player scripts\common\utility::allow_jump(0);
  level.player scripts\common\utility::allow_prone(0);
  level.player scripts\common\utility::allow_crouch(0);
  level.player scripts\common\utility::allow_fire(0);
  level.player disableweapons();
  level.player playerlinktodelta(level.player_rig, "tag_player", 0, 35, 35, 20, 20);

  if(isDefined(var0) || var0) {
    level.player springcamenabled(0, 5, 5);
    return;
  }
}

function stop_player_anim() {
  level.player_rig hide();
  level.player allowmovement(1);
  level.player scripts\common\utility::allow_jump(1);
  level.player scripts\common\utility::allow_prone(1);
  level.player scripts\common\utility::allow_crouch(1);
  level.player scripts\common\utility::allow_fire(1);
  level.player enableweapons();
  level.player unlink();
}

function debug_print(var0) {}

function debug_print3d(var0, var1, var2, var3, var4, var5) {}

function delete_targetname(var0) {
  var1 = getEnt(var0, "targetname");
  var1 delete();
}

function kill_array_of_ai() {
  foreach(var1 in self) {
    var1 kill();
  }
}

function within_player_fov() {
  var0 = scripts\engine\utility::within_fov(level.player getEye(), level.player getplayerangles(), self.origin, cos(35));
  return var0;
}

function get_all_good_guys() {
  var0 = getaiarray("allies");
  var0 = scripts\engine\utility::array_add(var0, level.player);
  return var0;
}

function delete_trigger_with_targetname(var0) {
  var1 = getEnt(var0, "targetname");
  var1 delete();
}

function delete_trigger_with_noteworthy(var0) {
  var1 = getEnt(var0, "script_noteworthy");
  var1 delete();
}

function delete_all_bad_guys() {
  var0 = getaiarray("axis");

  foreach(var2 in var0) {
    var2 delete();
  }
}

#using_animtree("scriptables");

function use_scriptables_animtree() {
  self useanimtree(#animtree);
}

function pain_vo(var0) {
  var1 = get_gender();
  var2 = randomintrange(1, 8);

  if(var1 == "male") {
    var3 = "generic_pain_friendly_" + var2;
  } else {
    var3 = "woman_pain_friendly_" + var3;
  }

  say(var3);
}

function death_vo(var0) {
  var1 = get_gender();
  var2 = randomintrange(1, 8);

  if(var1 == "male") {
    var3 = "generic_death_friendly_" + var2;
  } else {
    var3 = "woman_death_friendly_" + var3;
  }

  say(var3);
}

function get_gender() {
  switch (self.voice) {
    case "unitednationsfemale":
      var0 = "female";
      break;
    default:
      var0 = "male";
      break;
  }

  return var0;
}

function is_police() {
  return strtok(self.classname, "_")[3] == "police";
}

function add_to_chatter(var0, var1, var2, var3) {
  var4 = undefined;

  if(!isDefined(level.vo_chatter)) {
    thread init_chatter();
  }

  if(!isDefined(var1)) {
    var1 = "none";
  }

  if(isDefined(level.vo_chatter.insert_index)) {
    level.vo_chatter.queue scripts\engine\utility::array_insert(level.vo_chatter.queue, var0, level.vo_chatter.insert_index);
    level.vo_chatter.origins scripts\engine\utility::array_insert(level.vo_chatter.origins, var1, level.vo_chatter.insert_index);
    level.vo_chatter.insert_index++;
  } else {
    level.vo_chatter.queue[level.vo_chatter.queue.size] = var0;
    level.vo_chatter.origins[level.vo_chatter.origins.size] = var1;
  }

  if(isDefined(var2)) {
    thread remove_on_notify(level.vo_chatter, var0, var2);
  }

  level.vo_chatter notify("item_added");
}

function add_say_on_closest_ally_to_chatter(var0, var1, var2, var3) {
  var4 = [ &say_line_on_closest_ally, [var0]];
  add_to_chatter([var4], var1, var2, var3);
}

function start_inserting_chatter() {
  level.vo_chatter.insert_index = 0;
}

function stop_inserting_chatter() {
  level.vo_chatter.insert_index = undefined;
}

function remove_on_notify(var0, var1, var2) {
  self endon("terminate_chatter");

  if(!isDefined(var2)) {
    var2 = level;
  }

  if(isarray(var1)) {
    var2 scripts\engine\utility::waittill_any_in_array_return(var1);
  } else {
    var2 waittill(var1);
  }

  foreach(var4 in level.vo_chatter.queue) {
    if(compare(var4, var0)) {
      level.vo_chatter.queue = scripts\engine\utility::array_remove_index(level.vo_chatter.queue, var5);
      level.vo_chatter.origins = scripts\engine\utility::array_remove_index(level.vo_chatter.origins, var5);
      return;
    }
  }
}

function init_chatter() {
  level.vo_chatter = spawnStruct();
  level.vo_chatter.queue = [];
  level.vo_chatter.origins = [];
  level.vo_chatter.speaking = 0;
  level.vo_chatter.waiting = [];
  level.vo_chatter.interval = 2;
  thread chatter_loop();
}

function chatter_loop() {
  level.vo_chatter endon("terminate_chatter");
  level.vo_chatter.stopped = 0;

  for(;;) {
    chatter_loop_internal();

    while(level.vo_chatter.stopped) {
      level.vo_chatter waittill("start_chatter");
    }
  }
}

function chatter_loop_internal() {
  level.vo_chatter endon("stop_chatter");

  for(;;) {
    if(level.vo_chatter.queue.size == 0) {
      level.vo_chatter waittill("item_added");
    }

    wait level.vo_chatter.interval;

    if(level.vo_chatter.queue.size == 0) {
      continue;
    }

    var0 = get_chatter_item_index();

    if(!isDefined(var0)) {
      continue;
    }

    var1 = level.vo_chatter.queue[var0];
    level.vo_chatter.queue = scripts\engine\utility::array_remove_index(level.vo_chatter.queue, var0);
    level.vo_chatter.origins = scripts\engine\utility::array_remove_index(level.vo_chatter.origins, var0);

    if(isarray(var1)) {
      do_as_chatter(level, &say_sequence, [var1], 1);
      continue;
    }

    do_as_chatter(level, &say_vo_item, [var1], 1);
  }
}

function get_chatter_item_index() {
  var0 = undefined;
  var1 = undefined;

  foreach(var12, var3 in level.vo_chatter.queue) {
    var4 = level.vo_chatter.origins[var12];

    if(isstring(var4) && var4 == "none") {
      if(!isDefined(var0)) {
        var0 = var12;
      }

      continue;
    }

    if(!isarray(var4)) {
      var4 = [var4];
    }

    foreach(var6 in var4) {
      if(isint(var6) || isfloat(var6)) {
        var7 = var6;
      } else {
        var8 = anglesToForward(level.player getplayerangles());
        var9 = level.player.origin - var6;
        var10 = scripts\engine\math::anglebetweenvectors(var8, var9) / 180;
        var10 = (1 - var10) / 4 + 0.75;
        var7 = length2d(var9) * var10;
      }

      if(!isDefined(var1) || var7 < var1) {
        var1 = var7;
        var0 = var12;
      }
    }
  }

  return var0;
}

function terminate_chatter() {
  level.vo_chatter notify("terminate_chatter");
  level.vo_chatter = undefined;
}

function say_sequence(var0, var1) {
  var2 = self;

  foreach(var4 in var0) {
    var2 = say_vo_item(var2, var4, var1);
  }
}

function say_vo_item(var0, var1) {
  var2 = self;

  if(isarray(var0)) {
    if((isint(var0[0]) || isfloat(var0[0])) && isint(var0[1]) || isfloat(var0[1])) {
      wait randomfloatrange(var0[0], var0[1]);
    } else if(isbuiltinfunction(var0[0]) || isbuiltinmethod(var0[0]) || isanimation(var0[0])) {
      call_with_params(var2, var0[0], var0[1]);
    }

    return var2;
  }

  if(isent(var0) || isstruct(var0)) {
    var2 = var0;
  } else if(isstring(var0)) {
    say(var2, var0, var1);
  } else if(isint(var0) || isfloat(var0)) {
    wait var0;
  } else if(isbuiltinfunction(var0) || isbuiltinmethod(var0) || isanimation(var0)) {
    call_with_params(var2, var0);
  } else if(scripts\engine\sp\utility::is_deck(var0)) {
    var2 = say_vo_item(var2, var0 scripts\engine\sp\utility::deck_draw(), var1);
  }

  return var2;
}

function say(var0, var1) {
  if(!soundexists(var0)) {
    return false;
  }

  if(is_dead_or_dying(self)) {
    return false;
  }

  self notify("started_speaking", var0);

  if(istrue(var1)) {
    if(isstruct(self)) {
      scripts\engine\sp\utility::smart_radio_dialogue_interrupt(var0);
    } else if(isPlayer(self)) {
      scripts\engine\sp\utility::smart_player_dialogue_interrupt(var0);
    } else if(isDefined(self.animname)) {
      self stopsounds();
      waitframe();
      scripts\engine\sp\utility::smart_dialogue(var0);
    } else {
      if(issentient(self)) {
        self playsoundatviewheight(var0);
      } else {
        self playSound(var0);
      }

      wait lookupsoundlength(var0) / 1000;
    }
  } else if(isstruct(self)) {
    scripts\engine\sp\utility::smart_radio_dialogue(var0);
  } else if(isPlayer(self)) {
    scripts\engine\sp\utility::smart_player_dialogue(var0);
  } else if(isDefined(self.animname)) {
    scripts\engine\sp\utility::smart_dialogue(var0);
  } else {
    if(issentient(self)) {
      self playsoundatviewheight(var0);
    } else {
      self playSound(var0);
    }

    wait lookupsoundlength(var0) / 1000;
  }

  self notify("finished_say", var0);
  return true;
}

function say_as_chatter(var0, var1, var2, var3) {
  return do_as_chatter(&say, [var0, var1], undefined, var1, var2, var3);
}

function say_sequence_as_chatter(var0, var1, var2, var3) {
  return do_as_chatter(&say_sequence, [var0], undefined, var1, var2, var3);
}

function say_line_as_chatter_on_closest_ally(var0, var1, var2, var3) {
  return do_as_chatter(&say_line_on_closest_ally, [var0], undefined, var1, var2, var3);
}

function wait_for_break_in_chatter(var0, var1, var2) {
  var3 = spawnStruct();
  var4 = 0.5;
  var5 = 0;

  if(!level.vo_chatter.speaking) {
    return 1;
  }

  level.vo_chatter.waiting = scripts\engine\utility::array_add(level.vo_chatter.waiting, var3);

  if(isDefined(var0)) {
    var5 = var3 scripts\engine\utility::waittill_notify_or_timeout_return("proceed", var0) == "timeout";
  } else {
    var3 waittill("proceed");
  }

  level.vo_chatter.waiting = scripts\engine\utility::array_remove(level.vo_chatter.waiting, var3);
  return var5;
}

function do_as_chatter(var0, var1, var2, var3, var4, var5, var6, var7) {
  if(!isDefined(level.vo_chatter)) {
    thread init_chatter();
  }

  level.vo_chatter endon("terminate_chatter");
  var8 = spawnStruct();
  thread do_as_chatter_internal(var0, var1, var2, var3, var4, var5, var6, var8);
  var8 waittill("done", var9);
  return var9;
}

function do_as_chatter_internal(var0, var1, var2, var3, var4, var5, var6, var7) {
  level.vo_chatter endon("terminate_chatter");
  var8 = 0.5;
  var9 = gettime();

  if(level.vo_chatter.speaking && (!istrue(var3) || isDefined(var4))) {
    var10 = wait_for_break_in_chatter(var4);
  } else {
    var10 = 0;
  }

  var11 = undefined;

  if(!level.vo_chatter.speaking || !var10 || istrue(var4)) {
    if(!istrue(var3)) {
      pause_chatter();
    }

    level.vo_chatter notify("started_speaking", self, var1, var2);
    level.vo_chatter.speaking++;

    if(isDefined(var5)) {
      var5 -= gettime() - var10;
    } else {
      var5 = var9 * 4;
    }

    if(var5 > 0 && istrue(var9)) {
      wait_combat_cooldown(var9, var5);
    }

    var11 = call_with_params(var1, var2);
    level.vo_chatter.speaking--;

    if(!istrue(var3)) {
      resume_chatter();
    }

    level.vo_chatter notify("done_speaking", self, var1, var2);
  }

  if(!level.vo_chatter.speaking && isDefined(level.vo_chatter.waiting[0])) {
    level.vo_chatter.waiting[0] notify("proceed");
  }

  var8 notify("done", var11);
}

function pause_chatter() {
  if(!isDefined(level.vo_chatter)) {
    return;
  }

  level.vo_chatter.stopped++;
  level.vo_chatter notify("stop_chatter");
}

function resume_chatter(var0) {
  if(!level.vo_chatter.stopped) {
    return;
  }

  if(istrue(var0)) {
    level.vo_chatter.stopped = 0;
  } else {
    level.vo_chatter.stopped--;
  }

  level.vo_chatter notify("start_chatter");
}

function say_line_on_closest_ally(var0, var1) {
  var2 = getaiarray("allies");
  var2 = scripts\engine\utility::array_removedead_or_dying(var2);
  var3 = sortbydistance(var2, level.player.origin)[0];

  if(!isDefined(var1)) {
    var1 = 1;
  }

  var4 = gettime();

  while(!isDefined(var3) || istrue(var3 iswaitingonsound())) {
    waitframe();
    var2 = scripts\engine\utility::array_removedead_or_dying(var2);
    var3 = sortbydistance(var2, level.player.origin)[0];

    if(scripts\engine\utility::time_has_passed(var4, var1)) {
      return undefined;
    }
  }

  if(var3 == level.sas[0]) {
    say(level.sas[0], var0[0]);
  } else if(var3 == level.sas[1]) {
    say(level.sas[1], var0[1]);
  } else if(isDefined(var3.vo_index)) {
    say(var3, var0[var3.vo_index]);
  } else {
    if(!isDefined(level.police_vo_indexes)) {
      level.police_vo_indexes = scripts\engine\sp\utility::create_deck([2, 3]);
    }

    if(!isDefined(var3.animname)) {
      var3.animname = "police_" + var3 scripts\engine\utility::get_ai_number();
    }

    var3.vo_index = level.police_vo_indexes scripts\engine\sp\utility::deck_draw();
    say(var3, var0[var3.vo_index]);
  }

  return var3;
}

function compare(var0, var1) {
  if(isarray(var0)) {
    if(isarray(var1)) {
      return compare_arrays(var0, var1);
    }

    return 0;
  }

  if(isarray(var1)) {
    return 0;
  }

  return var0 == var1;
}

function compare_arrays(var0, var1) {
  if(var0.size != var1.size) {
    return false;
  }

  foreach(var3 in var0) {
    if(!isDefined(var1[var5])) {
      return false;
    }

    var4 = var1[var5];

    if(compare(var4, var3)) {
      return false;
    }
  }

  return true;
}

function array_deck_shuffle() {
  var0 = self;
  var0.index = 0;
  var0.items = scripts\engine\utility::array_randomize(var0.items);

  if(!var0.prevent_redraw || !isDefined(var0.last_drawn) || var0.items.size <= 1) {
    return;
  }

  var1 = compare(var0.items[0], var0.last_drawn);

  if(var1) {
    var2 = randomintrange(1, var0.items.size);
    var3 = var0.items[0];
    var0.items[0] = var0.items[var2];
    var0.items[var2] = var3;
    return;
  }
}

function call_with_params(var0, var1) {
  if(isbuiltinfunction(var0)) {
    return call_with_params_script(var0, var1);
  }

  if(isbuiltinmethod(var0) || isanimation(var0)) {
    return call_with_params_builtin(var0, var1);
  }
}

function call_with_params_script(var0, var1) {
  if(!isDefined(var1)) {
    return self[[var0]]();
  }

  if(!isarray(var1)) {
    return self[[var0]](var1);
  }

  switch (var1.size) {
    case 0:
      return self[[var0]]();
    case 1:
      return self[[var0]](var1[0]);
    case 2:
      return self[[var0]](var1[0], var1[1]);
    case 3:
      return self[[var0]](var1[0], var1[1], var1[2]);
    case 4:
      return self[[var0]](var1[0], var1[1], var1[2], var1[3]);
    case 5:
      return self[[var0]](var1[0], var1[1], var1[2], var1[3], var1[4]);
    case 6:
      return self[[var0]](var1[0], var1[1], var1[2], var1[3], var1[4], var1[5]);
    case 7:
      return self[[var0]](var1[0], var1[1], var1[2], var1[3], var1[4], var1[5], var1[6]);
    case 8:
      return self[[var0]](var1[0], var1[1], var1[2], var1[3], var1[4], var1[5], var1[6], var1[7]);
    case 9:
      return self[[var0]](var1[0], var1[1], var1[2], var1[3], var1[4], var1[5], var1[6], var1[7], var1[8]);
    default:
      break;
  }
}

function call_with_params_builtin(var0, var1) {
  if(!isDefined(var1)) {
    return self[[var0]]();
  }

  if(!isarray(var1)) {
    return self builtin[[var0]](var1);
  }

  switch (var1.size) {
    case 0:
      return self builtin[[var0]]();
    case 1:
      return self builtin[[var0]](var1[0]);
    case 2:
      return self builtin[[var0]](var1[0], var1[1]);
    case 3:
      return self builtin[[var0]](var1[0], var1[1], var1[2]);
    case 4:
      return self builtin[[var0]](var1[0], var1[1], var1[2], var1[3]);
    case 5:
      return self builtin[[var0]](var1[0], var1[1], var1[2], var1[3], var1[4]);
    case 6:
      return self builtin[[var0]](var1[0], var1[1], var1[2], var1[3], var1[4], var1[5]);
    case 7:
      return self builtin[[var0]](var1[0], var1[1], var1[2], var1[3], var1[4], var1[5], var1[6]);
    case 8:
      return self builtin[[var0]](var1[0], var1[1], var1[2], var1[3], var1[4], var1[5], var1[6], var1[7]);
    case 9:
      return self builtin[[var0]](var1[0], var1[1], var1[2], var1[3], var1[4], var1[5], var1[6], var1[7], var1[8]);
    default:
      break;
  }
}

function forward_notify(var0, var1, var2) {
  self endon("death");

  if(!isDefined(var2)) {
    var2 = self;
  }

  var2 endon("death");

  if(!isDefined(var1)) {
    var1 = var0;
  }

  self waittill(var0);
  var2 notify(var1);
}

function is_dead_or_dying(var0) {
  if(!isDefined(var0)) {
    return true;
  }

  if(isai(var0)) {
    return (!isalive(var0) || var0 scripts\engine\utility::doinglongdeath());
  } else if(issentient(var0)) {
    return !isalive(var0);
  }

  return false;
}

function create_nag(var0, var1, var2, var3, var4, var5, var6, var7, var8) {
  var9 = spawnStruct();
  var9.times_nagged = 0;
  var0 = set_if_undefined(var0, 1);
  var1 = set_if_undefined(var1, 1);
  var2 = set_if_undefined(var2, 999999999);
  var3 = set_if_undefined(var3, 999999999);
  var4 = set_if_undefined(var4, 0);
  var5 = set_if_undefined(var5, 0);
  var6 = set_if_undefined(var6, 1);
  var7 = set_if_undefined(var7, 1);
  var8 = set_if_undefined(var8, 1);
  var9.starting_duration = var0;
  var9.starting_randomness = var1;
  var9.max_duration = var2;
  var9.max_randomness = var3;
  var9.duration_increase = var4;
  var9.randomness_increase = var5;
  var9.duration_multiplier = var6;
  var9.randomness_multiplier = var7;
  var9.nags_before_increase = var8;
}

function set_if_undefined(var0, var1) {
  if(!isDefined(var0)) {
    return var1;
  }

  return var0;
}

function nag_wait() {
  var0 = self;
  wait randomfloatrange(var0.duration - var0.randomness, var0.duration + var0.randomness);
  var0.times_nagged++;

  if(var0.times_nagged % var0.nags_before_increase == 0) {
    var0.duration = min(var0.duration + var0.duration_increase, var0.max_duration);
    var0.duration = min(var0.duration * var0.duration_multiplier, var0.max_duration);
    var0.randomness = min(var0.randomness + var0.randomness_increase, var0.max_randomness);
    var0.randomness = min(var0.randomness * var0.randomness_multiplier, var0.max_randomness);
    return;
  }
}

function deck_nag(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10) {
  var11 = create_nag(var1, var2, var3, var4, var5, var6, var7, var8, var10);
  deck_nag_internal(var11, var0, var9);
  return var11;
}

function deck_nag_internal(var0, var1, var2) {
  if(isDefined(var2)) {
    level endon(var2);
    self endon(var2);
  }

  for(;;) {
    nag_wait(var0);
    say(var1 scripts\engine\sp\utility::deck_draw());
  }
}

function track_player_weapon_fire_time() {
  level.player endon("death");

  for(var0 = -9999;; var0 = gettime()) {
    var1 = level.player scripts\engine\utility::waittill_any_return("weapon_fired", "aim") == "weapon_fired";

    if(var1) {
      level.player.last_weapon_fire_time = gettime();
      continue;
    }

    if(gettime() - var0 > 50) {
      level.player.last_weapon_aim_time = gettime();
    }
  }
}

function wait_combat_cooldown(var0, var1, var2) {
  while(!isDefined(var1) || var1 > 0) {
    if(!is_in_combat(var0, var2)) {
      return false;
    }

    waitframe();

    if(isDefined(var1)) {
      var1 -= 0.05;
    }
  }

  return true;
}

function is_in_combat(var0, var1) {
  var2 = isDefined(level.player.last_weapon_fire_time) && !scripts\engine\utility::time_has_passed(level.player.last_weapon_fire_time, var0);
  var3 = isDefined(level.player.last_weapon_aim_time) && !scripts\engine\utility::time_has_passed(level.player.last_weapon_aim_time, var0);
  var4 = level.player scripts\sp\player::damageflag(2);

  if(istrue(var1)) {
    var5 = getaiarrayinradius(level.player.origin, var1, "axis");

    foreach(var7 in var5) {
      if(!scripts\engine\utility::time_has_passed(ai_last_weapon_fire_time(var7), var0)) {
        return true;
      }
    }
  }

  return level.player isfiring() || var2 || var3 || var4;
}

function ai_last_weapon_fire_time() {
  if(!isDefined(self.a) || !isDefined(self.a.lastshoottime)) {
    return 0;
  }

  return self.a.lastshoottime;
}

function ai_is_shooting() {
  if(isDefined(self._blackboard)) {
    if(istrue(self._blackboard.bfire)) {
      return true;
    }

    if(istrue(self._blackboard.shootparams_starttime) && gettime() - self._blackboard.shootparams_starttime < 250) {
      return true;
    }
  }

  return false;
}

function get_random_civilian_speed() {
  var0 = getdvarint("LSKTNKPTRT", 170);
  var1 = getdvarint("MNMNLKRRQP", 230);

  if(var1 <= var0) {
    var1 = var0 + 1;
  }

  return randomintrange(var0, var1);
}

function osa_distance(var0, var1) {
  var2 = var0.size;
  var3 = var1.size;
  var4 = [];

  for(var5 = 0; var5 <= var2; var5++) {
    var4 = [];
    var4[0] = var5;
  }

  for(var6 = 0; var6 <= var3; var6++) {
    var4[var6] = var6;
  }

  for(var5 = 1; var5 <= var2; var5++) {
    for(var6 = 1; var6 <= var3; var6++) {
      var7 = var0[var5 - 1] != var1[var6 - 1];
      var4[var6] = min(min(var4[var5][var6 - 1] + 1, var4[var5 - 1][var6] + 1), var4[var5 - 1][var6 - 1] + var7);

      if(var5 > 1 && var6 > 1 && var0[var5 - 1] == var1[var6 - 2] && var0[var5 - 2] == var1[var6 - 1]) {
        var4[var6] = min(var4[var5][var6], var4[var5 - 2][var6 - 2] + var7);
      }
    }
  }

  return var4[var2][var3];
}

function osa_percentile(var0, var1) {
  var2 = max(var0.size, var1.size);
  return 1 - osa_distance(var0, var1) / var2;
}

function mark_all_civs() {
  for(;;) {
    var0 = getEntArray();

    foreach(var2 in var0) {
      if(!isDefined(var2)) {
        continue;
      }

      if(!issentient(var2)) {}
    }

    waitframe();
  }
}

function display_all_ent_names(var0) {
  for(;;) {
    if(isDefined(var0)) {
      var1 = getentarrayinradius(undefined, undefined, level.player.origin, var0);
    } else {
      var1 = getaiarray();
    }

    foreach(var3 in var1) {
      if(!isDefined(var3)) {
        continue;
      }

      var4 = 70;
      var5 = 3.5;

      if(isDefined(var3.classname)) {
        var4 += var5;
      }

      var6 = var3.script_noteworthy;

      if(isDefined(var6)) {
        var6 = get_value_with_index(var3, var6, "script_noteworthy");
        var4 += var5;
      }

      var6 = var3.targetname;

      if(isDefined(var6)) {
        var6 = get_value_with_index(var3, var6, "targetname");
        var4 += var5;
      }

      if(isDefined(var3.voice)) {
        var4 += var5;
      }

      if(isDefined(var3.animname)) {
        var4 += var5;
      }
    }

    waitframe();
  }
}

function get_value_with_index(var0, var1) {
  var2 = getEntArray(var0, var1);

  if(var2.size == 1) {
    return var0;
  }

  for(var3 = 0; var3 < var2.size; var3++) {
    if(var2[var3] == self) {
      return (var0 + " [" + var3 + "]");
    }
  }

  return var0;
}

function display_all_last_anims(var0) {
  for(;;) {
    var1 = getEntArray();

    foreach(var3 in var1) {
      if(!isDefined(var3) || !isDefined(var3.animname) || !isDefined(var3._lastanime)) {
        continue;
      }

      if(isDefined(var0) && var3.animname != var0) {
        continue;
      }

      if(var3 tagexists("j_head")) {
        var4 = var3 gettagorigin("j_head");
        continue;
      }

      var4 = var3.origin + (0, 0, 60);
    }

    waitframe();
  }
}

function get_last_anim_name() {
  return getanimname(scripts\engine\utility::getanim(self._lastanime));
}

function get_last_anim_frame() {
  return int((gettime() - self.last_anim_time) / 1000 * 30);
}

function print_last_anim_info(var0) {
  var1 = get_last_anim_name();
  var2 = get_last_anim_frame();
  scripts\engine\utility::launcher_write_clipboard(var1 + " | Frame " + var2 + " | " + var0);
}

function easy_position_creator() {
  for(;;) {
    while(!level.player buttonPressed("button_back")) {
      waitframe();
    }

    self notify("position_created");
    thread new_position("position_created");

    while(level.player buttonPressed("button_back")) {
      waitframe();
    }
  }
}

function new_position(var0) {
  if(isDefined(var0)) {
    self endon(var0);
  }

  var1 = anglesToForward(level.player getplayerangles());
  var2 = scripts\engine\trace::ray_trace_detail(level.player getEye(), level.player getEye() + var1 * 1000, level.player);
  var3 = var2["position"];
  var4 = 40;
  var5 = 0;
  scripts\engine\utility::launcher_write_clipboard("is_near ( " + var3 + ", " + var4 + " );");

  for(;;) {
    draw_cool_circle(var3, var4, var5);

    if(level.player buttonPressed("dpad_right")) {
      var4 += 2;
      scripts\engine\utility::launcher_write_clipboard("is_near ( " + var3 + ", " + var4 + " );");
    } else if(level.player buttonPressed("dpad_left")) {
      var4 -= 2;
      scripts\engine\utility::launcher_write_clipboard("is_near ( " + var3 + ", " + var4 + " );");
    }

    waitframe();
  }
}

function draw_cool_circle(var0, var1, var2) {
  var3 = 50;

  for(var4 = 0; var4 < var3; var4++) {
    scripts\engine\utility::draw_circle(var0 + (0, 0, var2), var1, (1, 1, 1), 1 - var4 / var3, 1, 1);
    var2 += 0.5 * var1 / 80;
  }
}