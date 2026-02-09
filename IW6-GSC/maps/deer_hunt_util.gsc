/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\deer_hunt_util.gsc
*****************************************************/

disable_twitches() {
  self.a.bdisablemovetwitch = 1;
}

enable_twitches() {
  self.a.bdisablemovetwitch = undefined;
}

if_flag_and_not_flag(var_0, var_1, var_2) {
  if(common_scripts\utility::flag(var_0) && !common_scripts\utility::flag(var_1)) {
    if(isDefined(var_2))
      common_scripts\utility::flag_set(var_2);

    return 1;
  }

  return 0;
}

play_loop_sound_in_space_stop_on_flag(var_0, var_1, var_2) {
  var_3 = spawn("script_origin", (0, 0, 0));

  if(!isDefined(var_1))
    var_1 = self.origin;

  var_3.origin = var_1;
  var_3 playLoopSound(var_0);
  common_scripts\utility::flag_wait(var_2);
  var_3 delete();
}

spawn_model_and_linkto_me(var_0, var_1) {
  var_2 = spawn("script_model", self gettagorigin(var_1));
  var_2 setModel(var_0);
  var_2.angles = self gettagangles(var_1);
  var_2 linkto(self, var_1);
  return var_2;
}

dog_attack_guy(var_0) {
  level.dog maps\_utility::disable_ai_color();
  level.dog setgoalentity(var_0);
  level.dog.ignoreall = 0;
  var_0 waittill("death");
  level.dog maps\_utility::enable_ai_color();
  level.dog.ignoreall = 1;
}

disable_turns_arrivals_exits() {
  maps\_utility::disable_arrivals();
  maps\_utility::disable_exits();
  maps\_utility::disable_turnanims();
}

enable_turns_arrivals_exits() {
  maps\_utility::enable_arrivals();
  maps\_utility::enable_exits();
  maps\_utility::enable_turnanims();
}

dog_node_wait(var_0, var_1) {
  while(distance2dsquared(level.dog.origin, var_0.origin) > 100)
    wait 0.05;

  if(isDefined(var_1))
    common_scripts\utility::flag_set(var_1);

  return;
}

spawn_model_on_me(var_0) {
  var_1 = spawn("script_model", self.origin);
  var_1.angles = self.angles;
  var_1 setModel(var_0);
  return var_1;
}

try_slide_hint(var_0, var_1) {
  if(common_scripts\utility::flag("did_slide_hint")) {
    return;
  }
  level endon(var_1);
  common_scripts\utility::flag_wait(var_0);

  while(!level.player issprinting())
    wait 0.25;

  thread maps\_utility::display_hint_timeout("slide_hint", 7);
  common_scripts\utility::flag_set("did_slide_hint");
}

magicburst(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_3))
    var_4 = randomintrange(5, 9);
  else
    var_4 = var_3;

  for(var_5 = 0; var_5 < var_4; var_5++) {
    magicbullet(var_0, var_1, var_2);
    wait(randomfloatrange(0.05, 0.35));
  }
}

hesh_calls_riley(var_0, var_1) {
  level endon(var_1);
  var_2 = ["stop_color_move", "stop_going_to_node", "goal_changed path_set", "node_relinquished"];

  for(;;) {
    self waittill("stop_color_move");
    maps\_utility::delaythread(var_0, ::call_riley, 1);
  }
}

call_riley(var_0, var_1) {
  if(isDefined(var_0))
    var_2 = ["deerhunt_hsh_rileyhere_2", "deerhunt_hsh_riley_2", "deerhunt_hsh_cmonboy_2", "deerhunt_hsh_rileyfollow_2"];
  else
    var_2 = ["deerhunt_hsh_rileyhere_3", "deerhunt_hsh_riley_3", "deerhunt_hsh_cmonboy_3", "deerhunt_hsh_rileyfollow_3"];

  var_2 = common_scripts\utility::array_randomize(var_2);

  if(isDefined(self.last_call_line))
    var_3 = get_random_from_array_except(var_2, self.last_call_line);
  else
    var_3 = common_scripts\utility::random(var_2);

  maps\_utility::smart_dialogue_generic(var_3);
  self.last_call_line = var_3;

  if(isDefined(var_1)) {
    var_4 = ["deerhunt_dogcall_1", "deerhunt_dogcall_2", "deerhunt_dogcall_3"];
    maps\_utility::play_sound_on_entity(common_scripts\utility::random(var_4));
  }
}

get_random_from_array_except(var_0, var_1) {
  var_0 = common_scripts\utility::array_randomize(var_0);

  foreach(var_3 in var_0) {
    if(var_3 != var_1)
      return var_3;
  }

  return undefined;
}

hesh_nag_til_flag(var_0, var_1, var_2) {
  if(common_scripts\utility::flag(var_0)) {
    return;
  }
  level endon(var_0);

  if(isDefined(var_2))
    self waittill("goal");

  if(isDefined(var_1))
    wait(var_1);

  var_3 = ["deerhunt_hsh_cmonwegottakeep", "deerhunt_hsh_letskeepmovin", "deerhunt_hsh_letsgologan"];
  var_3 = common_scripts\utility::array_randomize(var_3);

  while(!common_scripts\utility::flag(var_0)) {
    foreach(var_5 in var_3) {
      hesh_line(var_5);
      wait(randomintrange(8, 13));
    }
  }
}

return_struct_spline(var_0) {
  var_1 = var_0;
  var_2 = [];
  var_2[0] = var_1;

  for(;;) {
    var_3 = common_scripts\utility::getstruct(var_1.target, "targetname");

    if(isDefined(var_3)) {
      if(var_3 == var_0 || maps\_utility::is_in_array(var_2, var_3))
        return var_2;
      else {
        var_2 = common_scripts\utility::add_to_array(var_2, var_3);
        var_1 = var_3;
      }
    }
  }
}

set_and_enable_color(var_0) {
  maps\_utility::set_force_color(var_0);
  maps\_utility::enable_ai_color();
}

create_dog_start_point_ent(var_0, var_1) {
  if(isstring(var_1))
    var_1 = level.dog maps\_utility::getanim(var_1);

  var_2 = getstartorigin(var_0.origin, var_0.angles, var_1);
  var_3 = getstartangles(var_0.origin, var_0.angles, var_1);
  var_4 = spawn("script_origin", var_2);
  var_4.angles = var_3;
  return var_4;
}

convo_generator(var_0) {
  foreach(var_2 in var_0) {
    var_3 = strtok(var_2, "_");

    if(var_3[1] == "els") {
      elias_line(var_2);
      continue;
    }

    hesh_line(var_2);
  }
}

hesh_line(var_0) {
  level.hesh maps\_utility::smart_dialogue_generic(var_0);
  vo_wait();
}

elias_line(var_0) {
  level.elias maps\_utility::smart_dialogue(var_0);
  vo_wait();
}

vo_wait(var_0) {
  wait(randomfloatrange(0.15, 0.25));

  if(isDefined(var_0))
    wait(var_0);
}

#using_animtree("generic_human");

drone_civs_init() {
  level.drone_anims["neutral"]["stand"]["idle"] = % casual_stand_idle;
  level.drone_anims["neutral"]["stand"]["run"] = % unarmed_scared_run;
  level.drone_anims["neutral"]["stand"]["death"] = % exposed_death;
  level.attachpropsfunction = animscripts\civilian\civilian_init::attachprops;
}

manual_hint_display(var_0, var_1) {
  var_2 = 5625;
  thread manual_clear_hint_on_trigger();
  self endon(var_1);

  for(;;) {
    if(distance2dsquared(self.origin, level.player.origin) > var_2)
      clear_hints();
    else if(distance2dsquared(self.origin, level.player.origin) < var_2)
      thread keyhint("matv_enter", undefined, undefined, 1);

    wait 0.25;
  }
}

manual_clear_hint_on_trigger() {
  self waittill("trigger");
  clear_hints();
}

retain_alert_level(var_0, var_1) {
  self endon("death");
  self endon("damage");

  if(isDefined(var_1))
    level endon(var_1);

  self.alertlevelint = var_0;

  while(isalive(self)) {
    if(self.alertlevelint != var_0)
      self.alertlevelint = var_0;

    wait 0.05;
  }
}

flag_set_delayed(var_0, var_1) {
  wait(var_0);
  common_scripts\utility::flag_set(var_1);
}

registeractionbinding(var_0, var_1, var_2) {
  if(!isDefined(level.actionbinds[var_0]))
    level.actionbinds[var_0] = [];

  var_3 = spawnStruct();
  var_3.binding = var_1;
  var_3.hint = var_2;
  var_3.keytext = undefined;
  var_3.hinttext = undefined;
  precachestring(var_2);
  level.actionbinds[var_0][level.actionbinds[var_0].size] = var_3;
}

getactionbind(var_0) {
  for(var_1 = 0; var_1 < level.actionbinds[var_0].size; var_1++) {
    var_2 = level.actionbinds[var_0][var_1];
    var_3 = getkeybinding(var_2.binding);

    if(!var_3["count"]) {
      continue;
    }
    return level.actionbinds[var_0][var_1];
  }

  return level.actionbinds[var_0][0];
}

keyhint(var_0, var_1, var_2, var_3) {
  clear_hints();
  level endon("clearing_hints");
  level.hintelem = create_custom_hint();
  var_4 = getactionbind(var_0);
  level.hintelem settext(var_4.hint);

  if(!isDefined(var_3)) {
    var_5 = "did_action_" + var_0;

    for(var_6 = 0; var_6 < level.actionbinds[var_0].size; var_6++) {
      var_4 = level.actionbinds[var_0][var_6];
      notifyoncommand(var_5, var_4.binding);
    }

    if(isDefined(var_1))
      level.player thread notifyontimeout(var_5, var_1);

    level.player waittill(var_5);
    level.hintelem fadeovertime(0.5);
    level.hintelem.alpha = 0;
    wait 0.5;
    clear_hints();
  }
}

create_custom_hint() {
  var_0 = 2;

  if(isDefined(level.hint_fontscale))
    var_0 = level.hint_fontscale;

  var_1 = maps\_hud_util::createfontstring("default", var_0);
  var_1.hidewheninmenu = 1;
  var_1.sort = 0.5;
  var_1.alpha = 0.9;
  var_1.x = 0;
  var_1.y = -68;
  var_1.alignx = "center";
  var_1.aligny = "middle";
  var_1.horzalign = "center";
  var_1.vertalign = "middle";
  var_1.foreground = 0;
  var_1.hidewhendead = 1;
  var_1.hidewheninmenu = 1;
  return var_1;
}

clear_hints() {
  if(isDefined(level.hintelem))
    level.hintelem maps\_hud_util::destroyelem();

  if(isDefined(level.iconelem))
    level.iconelem maps\_hud_util::destroyelem();

  if(isDefined(level.iconelem2))
    level.iconelem2 maps\_hud_util::destroyelem();

  if(isDefined(level.iconelem3))
    level.iconelem3 maps\_hud_util::destroyelem();

  if(isDefined(level.hintbackground))
    level.hintbackground maps\_hud_util::destroyelem();

  level notify("clearing_hints");
}

notifyontimeout(var_0, var_1) {
  self endon(var_0);
  wait(var_1);
  self notify(var_0);
}

set_flag_on_weapon_pickup(var_0) {
  self waittill("trigger");
  set_flag_if_not_set(var_0);
}

player_is_using_missile_launcher() {
  return level.player getcurrentweapon() != "maaws";
}

set_dog_master(var_0, var_1) {
  self setdoghandler(var_0);
  self setgoalentity(var_0);
  self setdogattackradius(800);
  self setdogcommand("attack");
}

clear_dog_master() {
  self setdoghandler(undefined);
  self setdogattackradius(1024);
  self setdogcommand("attack");
}

dog_drag_to_cover(var_0, var_1) {
  var_2 = var_0.script_index;
  var_3 = "dog_drag_" + var_2;
  var_4 = [level.hesh, level.dog];
  level.dog.animname = "dog";
  var_5 = getstartorigin(var_0.origin, var_0.angles, level.dog maps\_utility::getanim(var_3));
  var_6 = getstartangles(var_0.origin, var_0.angles, level.dog maps\_utility::getanim(var_3));
  var_7 = getnode(var_0.target, "targetname");
  level.hesh maps\_utility::disable_ai_color();
  level.hesh.goalradius = 32;
  level.hesh setgoalnode(var_7);
  var_8 = spawn("script_origin", var_5);
  var_8.angles = var_6;
  var_9 = spawn("script_origin", var_0.origin);
  var_9.angles = var_0.angles;
  level.dog maps\_utility::disable_ai_color();
  level.dog maps\_utility::delaythread(2, maps\_utility::set_goal_radius, 8);
  var_9 maps\_anim::anim_reach_and_approach([level.dog], var_3, undefined, "Exposed");
  var_8 thread maps\_anim::anim_loop_solo(level.dog, "dog_drag_bark_loop", "stop_barking");

  if(isstring(var_1))
    level waittill(var_1);
  else
    wait(var_1);

  var_0 thread maps\_anim::anim_reach_solo(level.hesh, var_3);
  var_10 = level.hesh common_scripts\utility::waittill_notify_or_timeout_return("anim_reach_complete", 20);

  if(!isDefined(var_10)) {
    var_8 notify("stop_barking");
    waittillframeend;
    level.hesh maps\_utility::delaythread(2, maps\_utility::smart_dialogue_generic, "deerhunt_hsh_easyboyeasssyy");
    var_0 maps\_anim::anim_single(var_4, var_3);
  } else {
    var_8 notify("stop_barking");
    level.hesh notify("new_anim_reach");
  }

  level.hesh thread maps\_utility::smart_dialogue_generic("deerhunt_hsh_rileygo");
  level.dog.animname = "generic";
  level.dog maps\_utility::enable_ai_color();
  level.hesh setgoalnode(var_7);
  level.hesh maps\_utility::delaythread(7, maps\_utility::enable_ai_color);
  common_scripts\utility::flag_set("drag_complete");
}

dog_drag_failsafe() {}

get_anim_start_time(var_0, var_1) {
  return var_0 / getanimlength(maps\_utility::getanim(var_1));
}

get_world_relative_offset(var_0, var_1, var_2) {
  var_3 = cos(var_1[1]);
  var_4 = sin(var_1[1]);
  var_5 = var_2[0] * var_3 - var_2[1] * var_4;
  var_6 = var_2[0] * var_4 + var_2[1] * var_3;
  var_5 = var_5 + var_0[0];
  var_6 = var_6 + var_0[1];
  return (var_5, var_6, var_0[2] + var_2[2]);
}

set_forcegoal_nosight() {
  if(isDefined(self.set_forcedgoal)) {
    return;
  }
  self.oldfightdist = self.pathenemyfightdist;
  self.oldmaxdist = self.pathenemylookahead;
  self.pathenemyfightdist = 8;
  self.pathenemylookahead = 8;
  self.set_forcedgoal = 1;
}

unset_forcegoal_nosight() {
  if(!isDefined(self.set_forcedgoal)) {
    return;
  }
  self.pathenemyfightdist = self.oldfightdist;
  self.pathenemylookahead = self.oldmaxdist;
  self.set_forcedgoal = undefined;
}

ragdoll_corpses() {
  var_0 = getcorpsearray();

  foreach(var_2 in var_0) {
    if(var_2 isragdoll() == 0)
      var_2 startragdoll();
  }
}

kill_me_from_closest_enemy(var_0) {
  self endon("death");

  if(self.team == "axis")
    var_1 = "allies";
  else
    var_1 = "axis";

  self.a.disablelongdeath = 1;
  wait(randomfloatrange(0.5, 2.5));
  var_2 = getaiarray(var_1);

  if(var_2.size == 0) {
    maps\_utility::die();
    return;
  }

  var_2 = sortbydistance(var_2, self.origin);

  if(isDefined(var_0)) {
    shoot_from_ai_to_ai(var_2[0], self);
    maps\_utility::die();
    return;
  }

  foreach(var_4 in var_2) {
    if(!isDefined(var_4.a.doinglongdeath) && bullettracepassed(var_4 gettagorigin("tag_flash"), self getEye(), 1, self)) {
      shoot_from_ai_to_ai(var_4, self);
      maps\_utility::die();
      return;
    }
  }

  if(isalive(self)) {
    shoot_from_ai_to_ai(var_2[0], self);
    maps\_utility::die();
  }
}

shoot_from_ai_to_ai(var_0, var_1) {
  var_2 = var_0 return_base_weapon_name();

  if(isDefined(var_2) && isDefined(var_0 gettagorigin("tag_flash")))
    magicbullet(var_2, var_0 gettagorigin("tag_flash"), var_1 getEye());
}

return_base_weapon_name() {
  var_0 = strtok(self.weapon, "+");
  return var_0[0];
}

is_behind_player() {
  var_0 = (level.player.angles[0], level.player.angles[1], 0);
  var_1 = anglesToForward(var_0);
  var_2 = level.player.origin - (0, 0, level.player.origin[2]);
  var_3 = self.origin - (0, 0, self.origin[2]);
  var_4 = vectornormalize(var_3 - var_2);
  var_5 = vectordot(var_4, var_1);
  return var_5 < -0.1;
}

get_my_vehicle_death_fx(var_0) {
  if(!isDefined(var_0))
    var_0 = 0;

  return level.vehicle_death_fx[self.classname][var_0].effect;
}

array_is_defined(var_0) {
  foreach(var_2 in var_0) {
    if(!isDefined(var_2))
      return 0;
  }

  return 1;
}

do_bokeh(var_0, var_1, var_2, var_3, var_4) {
  level.player notify("stop_bokeh");
  level.player endon("stop_bokeh");

  if(isDefined(var_0))
    level endon(var_0);

  if(isDefined(var_2))
    level.player thread maps\_utility::notify_delay("stop_bokeh", var_2);

  if(!isDefined(var_3))
    var_3 = 10;

  if(!isDefined(var_4))
    var_4 = 30;

  if(!isDefined(level.player.bokeh_ent)) {
    var_5 = anglesToForward(level.player.angles);
    var_6 = level.player.origin + var_5 * 60;
    var_7 = level.player getEye();
    level.player.bokeh_ent = spawn("script_model", var_6);
    level.player.bokeh_ent setModel("tag_origin");
    level.player.bokeh_ent linktoplayerview(level.player, "tag_origin", (5, 0, 0), (0, 0, 0), 1);
  }

  if(!isDefined(var_1))
    var_1 = "vfx_atmos_bokeh_deer";

  for(;;) {
    playFXOnTag(common_scripts\utility::getfx(var_1), level.player.bokeh_ent, "tag_origin");
    wait(randomfloatrange(var_3, var_4));
  }
}

get_spot_in_front_of_ent(var_0) {
  if(self == level.player)
    var_1 = level.player getplayerangles();
  else
    var_1 = self.angles;

  var_1 = (0, var_1[1], 0);
  var_2 = anglesToForward(var_1);
  var_3 = var_2 * var_0;
  var_4 = self.origin + var_3;
  return var_4;
}

has_script_noteworthy(var_0) {
  if(!isDefined(self.script_noteworthy))
    return 0;

  if(self.script_noteworthy != var_0)
    return 0;

  if(self.script_noteworthy == var_0)
    return 1;
}

shoot_single(var_0) {
  var_1 = self gettagorigin(self.shoot_tag) - (0, 0, 80);
  var_2 = level.player getplayerangles();
  var_2 = (0, var_2[1], 0);
  var_3 = anglesToForward(var_2);
  var_4 = var_3 * 375;
  var_5 = level.player.origin + var_4;
  magicbullet(var_0, var_1, var_5);
}

shoot_rocket(var_0, var_1) {
  if(!isDefined(var_1)) {
    while(!common_scripts\utility::within_fov(self.origin, self.angles, level.player.origin, cos(70)))
      wait 0.25;
  } else {
    while(!common_scripts\utility::within_fov(self.origin, self.angles, var_1, cos(70)))
      wait 0.25;
  }

  var_2 = 300;
  var_3 = maps\_utility::getdifficulty();

  switch (var_3) {
    case "easy":
      var_2 = 400;
      break;
    case "medium":
      var_2 = 350;
      break;
    case "fu":
    case "hard":
      var_2 = 80;
      break;
  }

  if(common_scripts\utility::cointoss())
    var_4 = "tag_missile_right";
  else
    var_4 = "tag_missile_left";

  var_5 = self gettagorigin(var_4) - (0, 0, 50);

  if(isDefined(var_1))
    var_6 = var_1;
  else {
    var_7 = level.player getplayerangles();
    var_7 = (0, var_7[1], 0);
    var_8 = anglesToForward(var_7);
    var_9 = var_8 * var_2;
    var_6 = level.player.origin + var_9;
  }

  var_10 = magicbullet(var_0, var_5, var_6);
  return var_10;
}

shootflares(var_0) {
  var_1 = maps\_utility::spawn_anim_model("flare_rig");
  var_1.origin = self gettagorigin("tag_flare");
  var_1.angles = self gettagangles("tag_flare");
  var_2 = [];
  var_3 = ["flare_right_top", "flare_left_bot", "flare_right_bot"];

  foreach(var_5 in var_3) {
    var_6 = common_scripts\utility::spawn_tag_origin();
    var_6 linkto(var_1, var_5, (0, 0, 0), (0, 0, 0));
    var_6 thread flare_trackvelocity();
    var_2[var_5] = var_6;
  }

  self.flares = var_2;
  var_8 = level.scr_anim["flare_rig"]["flare"].size;
  var_9 = level.scr_anim["flare_rig"]["flare"][2];
  var_1 setflaggedanim("flare_anim", var_9, 1, 0, 1);
  var_10 = common_scripts\utility::getfx("chopper_flare");
  var_2 = common_scripts\utility::array_randomize(var_2);

  foreach(var_5, var_6 in var_2) {
    if(isDefined(var_6)) {
      playFXOnTag(var_10, var_2[var_5], "tag_origin");
      var_6 playSound("chopper_flare_fire");
    }
  }

  if(isDefined(var_0))
    var_0 missile_settargetent(common_scripts\utility::random(var_2));

  var_1 waittillmatch("flare_anim", "end");

  foreach(var_5, var_6 in var_2) {
    if(isDefined(var_6))
      stopFXOnTag(var_10, var_2[var_5], "tag_origin");
  }

  var_1 delete();
  var_2 = common_scripts\utility::array_removeundefined(var_2);
  common_scripts\utility::array_thread(var_2, ::flare_doburnout);
  return var_2;
}

flare_trackvelocity() {
  self endon("death");
  self.velocity = 0;
  var_0 = self.origin;

  for(;;) {
    self.velocity = self.origin - var_0;
    var_0 = self.origin;
    wait 0.05;
  }
}

flare_doburnout() {
  self endon("death");
  self movegravity(14 * self.velocity, 0.2);
  wait 0.2;

  if(!isDefined(self) || isDefined(self.mytarget)) {
    return;
  }
  self delete();
}

game_is_pc() {
  if(level.xenon)
    return 0;

  if(level.ps3)
    return 0;

  if(level.ps4)
    return 0;

  if(level.xb3)
    return 0;

  return 1;
}

gameskill_is_difficult() {
  var_0 = maps\_utility::getdifficulty();

  if(var_0 == "easy" || var_0 == "medium")
    return 0;

  return 1;
}

set_flag_if_not_set(var_0) {
  if(!common_scripts\utility::flag(var_0))
    common_scripts\utility::flag_set(var_0);
}

delete_me_on_notifies(var_0, var_1, var_2) {
  if(!isDefined(var_1) && !isDefined(var_2))
    var_3 = common_scripts\utility::waittill_any_return(var_0);
  else if(!isDefined(var_2))
    var_3 = common_scripts\utility::waittill_any_return(var_0, var_1);
  else
    var_3 = common_scripts\utility::waittill_any_return(var_0, var_1, var_2);

  if(isDefined(level.custom_flavorburst_ents))
    level.custom_flavorburst_ents = common_scripts\utility::array_remove(level.custom_flavorburst_ents, self);

  self delete();
}

get_random_death_sound() {
  var_0 = randomintrange(1, 8);
  return "generic_death_enemy_" + var_0;
}

cqb_off_sprint_on() {
  if(isDefined(self.cqbwalking)) {
    if(self.cqbwalking == 1)
      maps\_utility::disable_cqbwalk();
  }

  maps\_utility::enable_sprint();
}

cqb_on_sprint_off() {
  if(isDefined(self.sprint)) {
    if(self.sprint == 1)
      maps\_utility::disable_sprint();
  }

  maps\_utility::enable_cqbwalk();
}

activate_trig_if_not_flag(var_0) {
  if(!common_scripts\utility::flag(var_0))
    maps\_utility::activate_trigger_with_targetname(var_0);
}

dog_growl() {
  maps\_utility::play_sound_on_entity("anml_dog_attack_miss");
}

waittill_player_moves_or_timeout_controller(var_0) {
  var_1 = 130;
  thread return_after_time(var_0, "player_moved_ahead");
  thread return_on_velocity(var_1);
  self waittill("returned", var_2);
  self notify("kill");
  return var_2;
}

waittill_player_moves_or_timeout_kb(var_0) {
  var_1 = 40000;
  thread return_after_time(var_0, "player_moved_ahead");
  thread return_on_movement(var_1);
  self waittill("returned", var_2);
  self notify("kill");
  return var_2;
}

is_moving() {
  self endon("death");
  var_0 = self.origin;
  wait 0.2;
  var_1 = self.origin;

  if(var_0 == var_1)
    return 0;

  return 1;
}

return_on_movement(var_0) {
  self endon("kill");
  level.player endon("death");
  var_1 = level.player.origin;

  for(;;) {
    wait 0.1;
    var_2 = level.player.origin;

    if(distance2dsquared(var_1, var_2) >= var_0)
      self notify("returned", "has_moved");
  }
}

return_on_velocity(var_0) {
  self endon("kill");

  for(;;) {
    var_1 = level.player getvelocity();

    if(var_1 != (0, 0, 0)) {
      var_2 = distance2d((0, 0, 0), var_1);

      if(var_2 >= var_0 || var_2 <= var_0 * -1)
        self notify("returned", "player_moved_ahead");
    }

    wait 0.5;
  }
}

return_after_time(var_0, var_1) {
  self endon("kill");
  self endon(var_1);
  wait(var_0);
  self notify("returned", "timed_out");
}

array_is_greater_than(var_0, var_1) {
  if(!isDefined(var_0))
    return 0;

  if(isDefined(var_0.size)) {
    if(var_0.size > var_1)
      return 1;
  }

  return 0;
}

only_take_damage_from_player(var_0) {
  self endon("death");
  var_1 = 2;
  var_2 = 0;

  if(isDefined(var_0))
    level endon(var_0);

  thread maps\_utility::magic_bullet_shield();

  for(;;) {
    self waittill("damage", var_3, var_4);

    if(isDefined(var_4)) {
      if(var_4 == level.player) {
        var_2++;

        if(var_2 >= var_1) {
          maps\_utility::stop_magic_bullet_shield();
          maps\_utility::die();
        }
      }
    }
  }
}

set_flag_on_targetname_trigger_by_player(var_0) {
  if(!common_scripts\utility::flag_exist(var_0))
    common_scripts\utility::flag_init(var_0);

  var_1 = getent(var_0, "targetname");

  for(;;) {
    var_1 waittill("trigger", var_2);

    if(isPlayer(var_2)) {
      common_scripts\utility::flag_set(var_0);
      return;
    }
  }
}

hesh_says_on_you() {
  if(common_scripts\utility::cointoss())
    level.hesh maps\_utility::smart_dialogue_generic("deerhunt_hsh_onyou");
  else
    level.hesh maps\_utility::smart_dialogue_generic("deerhunt_hsh_onyourgo");
}

hesh_radio_aknowledge() {
  var_0 = ["deerhunt_hsh_rogteam2out", "deerhunt_hsh_copythatlifeguard", "deerhunt_hsh_team2copiesall"];
  var_0 = common_scripts\utility::array_randomize(var_0);
  level.hesh maps\_utility::smart_radio_dialogue(common_scripts\utility::random(var_0));
}

music_on_flag(var_0, var_1, var_2) {
  common_scripts\utility::flag_wait(var_0);

  if(isDefined(var_2))
    wait(var_2);

  maps\_utility::music_play(var_1);
}

print3d_on_me(var_0) {}

grenades_by_difficulty() {
  var_0 = 0;
  var_1 = maps\_utility::getdifficulty();

  switch (var_1) {
    case "easy":
      var_0 = 0;
      break;
    case "medium":
      var_0 = 1;
      break;
    case "fu":
    case "hard":
      var_0 = 2;
      break;
  }

  if(randomint(100) < 40)
    self.grenadeammo = var_0;
  else
    self.grenadeammo = 0;
}

fade_out_in(var_0, var_1, var_2, var_3) {
  var_4 = newhudelem();
  var_4.x = 0;
  var_4.y = 0;
  var_4 setshader(var_0, 640, 480);
  var_4.alignx = "left";
  var_4.aligny = "top";
  var_4.horzalign = "fullscreen";
  var_4.vertalign = "fullscreen";
  var_4.alpha = 0;

  if(isDefined(var_3))
    var_4 fadeovertime(var_3);

  var_4.alpha = 1;
  var_4.sort = -2;

  if(isDefined(var_1))
    level waittill(var_1);
  else
    wait(var_2);

  var_4 fadeovertime(0.5);
  var_4.alpha = 0;
  wait 1;
  var_4 destroy();
}

disable_dontattackme() {
  if(isDefined(self.dontattackme))
    self.dontattackme = undefined;
}

ignore_me_ignore_all() {
  self.ignoreme = 1;
  self.ignoreall = 1;
}

ignore_me_ignore_all_off() {
  self.ignoreme = 0;
  self.ignoreall = 0;
}

shop_door_open(var_0) {
  wait 1.15;
  self rotateto(self.angles + (0, 90, 0), 2.2, 0.6, 1.6);
  self connectpaths();
  self waittill("rotatedone");
}

is_array_close(var_0, var_1) {
  foreach(var_3 in var_0) {
    if(distance2dsquared(self.origin, var_3.origin) < var_1)
      return 1;
  }

  return 0;
}

arm_player(var_0) {
  level.player takeallweapons();

  foreach(var_2 in var_0) {
    level.player giveweapon(var_2);
    level.player givemaxammo(var_2);
  }

  level.player switchtoweapon(var_0[0]);
}

switch_from_cqb_to_creepwalk() {
  if(isDefined(self.cqbwalking)) {
    if(self.cqbwalking == 1) {
      maps\_utility::disable_cqbwalk();
      maps\_utility::set_archetype("creepwalk");
      self.moveloopoverridefunc = ::play_move_transition;
      self.deerhunttransitionanim = % cqb_run_to_creepwalk_iw6;

      if(isDefined(self.aim_while_moving_thread))
        animscripts\run::endfaceenemyaimtracking();
    }
  } else
    maps\_utility::set_archetype("creepwalk");

  disable_turns_arrivals_exits();
}

switch_from_creepwalk_to_cqb() {
  maps\_utility::enable_cqbwalk();
  enable_turns_arrivals_exits();

  if(isDefined(self.animarchetype)) {
    if(self.animarchetype == "creepwalk") {
      maps\_utility::clear_archetype();
      self.moveloopoverridefunc = ::play_move_transition;
      self.deerhunttransitionanim = % creepwalk_to_cqb_run_iw6;
    }
  }
}

play_move_transition() {
  self.moveloopoverridefunc = undefined;
  self clearanim(%body, 0.2);
  self setflaggedanimknoballrestart("creepwalk_transition", self.deerhunttransitionanim, %body);
  animscripts\shared::donotetracks("creepwalk_transition");
  self clearanim(%body, 0.2);
  self.deerhunttransitionanim = undefined;
}

switch_from_cqb_to_gundown() {
  if(isDefined(self.cqbwalking)) {
    if(self.cqbwalking == 1)
      maps\_utility::disable_cqbwalk();
  }

  maps\_utility::set_archetype("gundown_archetype");
  disable_turns_arrivals_exits();
}

switch_from_gundown_to_cqb() {
  maps\_utility::enable_cqbwalk();
  maps\_utility::clear_archetype();
  enable_turns_arrivals_exits();
}

makestruct() {
  var_0 = spawnStruct();
  var_0.origin = self.origin;
  var_0.angles = self.angles;
  return var_0;
}

custom_anim_reach_together(var_0, var_1, var_2, var_3) {
  thread custom_moveplaybackrate_together(var_0);
  maps\_anim::anim_reach_with_funcs(var_0, var_1, var_2, var_3, ::hack_reach_start_func, ::hack_reach_end_func);
}

custom_moveplaybackrate_together(var_0) {
  var_1 = 0.5;
  waittillframeend;

  for(;;) {
    var_0 = maps\_utility::remove_dead_from_array(var_0);
    var_2 = [];
    var_3 = 0;

    foreach(var_8, var_5 in var_0) {
      var_6 = var_5.goalpos;

      if(isDefined(var_5.reach_goal_pos))
        var_6 = var_5.reach_goal_pos;

      var_7 = distance(var_5.origin, var_6);
      var_2[var_5.unique_id] = var_7;

      if(var_7 <= 4) {
        var_0[var_8] = undefined;
        continue;
      }

      var_3 = var_3 + var_7;
    }

    if(var_0.size <= 1) {
      break;
    }

    var_3 = var_3 / var_0.size;

    foreach(var_5 in var_0) {
      var_10 = var_2[var_5.unique_id] - var_3;
      var_11 = var_10 * 0.003;

      if(var_11 > var_1)
        var_11 = var_1;
      else if(var_11 < var_1 * -1)
        var_11 = var_1 * -1;

      var_12 = 1;

      if(isDefined(var_5.anim_reach_playback_scale))
        var_12 = var_5.anim_reach_playback_scale;

      var_5.moveplaybackrate = 1 * var_12 + var_11;
    }

    wait 0.05;
  }

  foreach(var_5 in var_0) {
    if(isalive(var_5))
      var_5.moveplaybackrate = 1;
  }
}

hack_reach_start_func(var_0) {
  self.oldgoalradius = self.goalradius;
  self.oldpathenemyfightdist = self.pathenemyfightdist;
  self.oldpathenemylookahead = self.pathenemylookahead;
  self.pathenemyfightdist = 128;
  self.pathenemylookahead = 128;
  maps\_utility::disable_ai_color();
  maps\_anim::anim_changes_pushplayer(1);
  self.nododgemove = 0;
  self.og_interval = self.interval;
  self.interval = 50;
  self.fixednodewason = self.fixednode;
  self.fixednode = 0;

  if(!isDefined(self.scriptedarrivalent)) {
    self.old_disablearrivals = self.disablearrivals;
    self.disablearrivals = 1;
  }

  self.reach_goal_pos = undefined;
  return var_0;
}

hack_reach_end_func() {
  maps\_anim::reach_with_standard_adjustments_end();
  self.interval = self.og_interval;
  self.og_interval = undefined;
}

radial_push_player(var_0, var_1, var_2, var_3) {
  level endon(var_3);
  var_1 = squared(var_1);
  var_2 = anglesToForward(var_2) * 20;

  for(;;) {
    wait 0.05;

    if(distancesquared(level.player.origin, var_0) < var_1) {
      level.player pushplayervector(var_2);
      continue;
    }

    level.player pushplayervector((0, 0, 0));
  }
}