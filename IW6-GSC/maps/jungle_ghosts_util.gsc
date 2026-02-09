/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\jungle_ghosts_util.gsc
***************************************/

cull_distance_logic() {
  switch (level.start_point) {
    case "e3":
    case "jungle_corridor":
    case "parachute":
    case "default":
      if(game_is_ng())
        setculldist(5000);
      else
        setculldist(5000);

      level.player waittill("start_falling_anim");

      if(game_is_ng())
        setculldist(5000);
      else
        setculldist(4500);

      common_scripts\utility::flag_wait("jungle_entrance");

      if(game_is_ng())
        setculldist(6000);
      else
        setculldist(4500);

      common_scripts\utility::flag_wait("hill_pos_1");
    case "jungle_hill":
      if(game_is_ng())
        setculldist(19000);
      else
        setculldist(15000);

      common_scripts\utility::flag_wait_any("waterfall_approach", "e3_warp");
      setculldist(0);
  }
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

game_is_ng() {
  if(game_is_pc())
    return 1;

  if(level.ps4)
    return 1;

  if(level.xb3)
    return 1;

  return 0;
}

stream_waterfx(var_0, var_1) {
  self endon("death");
  var_2 = 0;

  if(isDefined(var_1))
    var_2 = 1;

  if(isDefined(var_0)) {
    common_scripts\utility::flag_assert(var_0);
    level endon(var_0);
  }

  for(;;) {
    wait(randomfloatrange(0.15, 0.3));
    var_3 = self.origin + (0, 0, 150);
    var_4 = self.origin - (0, 0, 150);
    var_5 = bulletTrace(var_3, var_4, 0, undefined);

    if(var_5["surfacetype"] != "water") {
      continue;
    }
    var_6 = "water_movement";

    if(isPlayer(self)) {
      if(distance(self getvelocity(), (0, 0, 0)) < 5)
        var_6 = "water_stop";
    } else if(isDefined(level._effect["water_" + self.a.movement]))
      var_6 = "water_" + self.a.movement;

    var_7 = common_scripts\utility::getfx(var_6);
    var_3 = var_5["position"];
    var_8 = (0, self.angles[1], 0);
    var_9 = anglesToForward(var_8);
    var_10 = anglestoup(var_8);
    playFX(var_7, var_3, var_10, var_9);

    if(var_6 != "water_stop" && var_2)
      thread common_scripts\utility::play_sound_in_space(var_1, var_3);
  }
}

player_jump_watcher() {
  level endon("player_jump_watcher_stop");
  var_0 = "player_jumping";

  if(!common_scripts\utility::flag_exist(var_0))
    common_scripts\utility::flag_init(var_0);
  else
    common_scripts\utility::flag_clear(var_0);

  notifyoncommand("playerjump", "+gostand");
  notifyoncommand("playerjump", "+moveup");

  for(;;) {
    level.player waittill("playerjump");
    wait 0.1;

    if(!level.player isonground())
      common_scripts\utility::flag_set(var_0);

    while(!level.player isonground())
      wait 0.05;

    common_scripts\utility::flag_clear(var_0);
  }
}

bigjump_player_blend_to_anim(var_0) {
  var_1 = var_0 common_scripts\utility::spawn_tag_origin();
  var_1 linkto(var_0, "tag_player", (5, 0, 3), (0, 0, 0));
  var_2 = 0.5;
  level.player playerlinktoblend(var_1, "tag_origin", var_2);
  wait(var_2);
  level.player playerlinktodelta(var_1, "tag_origin", 1, 0, 0, 0, 0, 1);
  var_0 show();
  common_scripts\utility::waitframe();
  level.player lerpviewangleclamp(1, 1, 0, 12, 12, 25, 20);
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
    var_1 = "vfx_atmos_bokeh_jungle";

  for(;;) {
    playFXOnTag(common_scripts\utility::getfx(var_1), level.player.bokeh_ent, "tag_origin");
    wait(randomfloatrange(var_3, var_4));
  }
}

kill_me_from_closest_enemy() {
  self endon("death");
  var_0 = getaiarray("allies");
  var_0 = sortbydistance(var_0, self.origin);
  wait(randomfloatrange(0.5, 2.5));

  foreach(var_2 in var_0) {
    if(bullettracepassed(var_2 gettagorigin("tag_flash"), self getEye(), 1, self)) {
      magicbullet("ak47", var_2 gettagorigin("tag_flash"), self getEye());
      maps\_utility::die();
      return;
    }
  }

  if(isalive(self))
    maps\_utility::die();
}

stream_trig_logic() {
  level endon("tall_grass_begin");
  level endon("player_jump_watcher_stop");
  common_scripts\utility::flag_wait("jungle_entrance");

  for(;;) {
    if(level.player istouching(self))
      level.player allowprone(0);
    else
      level.player allowprone(1);

    wait 0.05;
  }
}

escape_earthquake_on_missile_impact() {
  while(isDefined(self))
    wait 0.05;

  earthquake(0.3, 0.5, level.player.origin, 300);
  level.player playrumbleonentity("grenade_rumble");
}

set_flag_when_x_remain(var_0, var_1, var_2) {
  level endon(var_2);

  while(var_0.size > var_1) {
    var_0 = maps\_utility::array_removedead_or_dying(var_0);

    if(var_0.size == 1) {
      if(!isDefined(var_0[0].imminent_death))
        var_0[0] thread timeout_death(10);
    }

    wait 1;
  }

  if(!common_scripts\utility::flag(var_2))
    common_scripts\utility::flag_set(var_2);
}

set_flag_when_x_remain_custom_stream(var_0, var_1) {
  level endon(var_1);

  while(level.stream_baddies.size > var_0) {
    level.stream_baddies = maps\_utility::array_removedead_or_dying(level.stream_baddies);

    if(level.stream_baddies.size == 1) {
      if(!isDefined(level.stream_baddies[0].imminent_death))
        level.stream_baddies[0] thread timeout_death(10);
    }

    wait 1;
  }

  if(!common_scripts\utility::flag(var_1))
    common_scripts\utility::flag_set(var_1);
}

timeout_death(var_0) {
  self endon("death");

  if(isDefined(self.imminent_death)) {
    return;
  }
  self.imminent_death = 1;
  wait(var_0);
  thread kill_me_from_closest_enemy();
}

start_raining() {
  if(!isDefined(level.rain_effect))
    level.rain_effect = common_scripts\utility::getfx("rain_light");

  level endon("stop_rain");
  var_0 = 0;
  var_1 = 0;

  for(;;) {
    if(var_0 > 10) {
      level.rain_effect = common_scripts\utility::getfx("rain_heavy");
      var_1 = 1024;
    }

    playFX(level.rain_effect, level.player.origin + (0, 0, var_1));
    wait 0.333333;
    var_0++;
  }
}

thunder_and_lightning(var_0, var_1) {
  level notify("stop_lightning");
  level endon("stop_lightning");

  for(;;) {
    do_lightning();
    wait(randomintrange(var_0, var_1));
  }
}

do_lightning() {
  if(common_scripts\utility::flag("doing_lightning")) {
    return;
  }
  common_scripts\utility::flag_set("doing_lightning");
  var_0 = anglesToForward(level.player.angles);
  var_1 = anglestoup(level.player.angles);
  var_2 = getmapsunlight();
  playFX(common_scripts\utility::getfx("lightning"), level.player.origin, var_0, var_1);
  setsunlight(2, 2, 2);
  wait 0.25;
  setsunlight(var_2[0], var_2[1], var_2[2]);
  wait(randomfloatrange(0.35, 0.85));
  level.player thread maps\_utility::play_sound_on_entity("thunder_strike");
  common_scripts\utility::flag_clear("doing_lightning");
}

manually_alert_me() {
  if(isDefined(self.script_stealth))
    maps\_stealth_shared_utilities::group_flag_set("_stealth_spotted");
}

blend_wind_setting_internal(var_0, var_1) {
  var_2 = getdvarfloat(var_1, 0);

  if(var_2 == var_0) {
    return;
  }
  if(var_0 > var_2) {
    while(var_0 >= var_2) {
      var_2 = var_2 + 0.02;
      setsaveddvar(var_1, var_2);
      wait 0.05;
    }
  } else if(var_0 < var_2) {
    while(var_0 <= var_2) {
      var_2 = var_2 - 0.02;
      setsaveddvar(var_1, var_2);
      wait 0.05;
    }
  }
}

has_script_parameters(var_0) {
  if(!isDefined(self.script_parameters))
    return 0;

  if(self.script_parameters != var_0)
    return 0;

  return 1;
}

adjust_moving_grass(var_0, var_1, var_2, var_3) {
  if(isDefined(var_1))
    setsaveddvar("r_reactiveMotionWindAreaScale", var_1);

  if(isDefined(var_0))
    thread blend_wind_setting_internal(var_0, "r_reactiveMotionWindStrength");

  if(isDefined(var_2))
    thread blend_wind_setting_internal(var_2, "r_reactiveMotionWindAmplitudeScale");

  if(isDefined(var_3))
    thread blend_wind_setting_internal(var_3, "r_reactiveMotionWindFrequencyScale");
}

stealth_ai_idle(var_0, var_1, var_2, var_3) {
  if(isDefined(var_3)) {}

  var_0 maps\_stealth_utility::stealth_insure_enabled();
  var_4 = var_0 maps\_stealth_shared_utilities::group_get_flagname("_stealth_spotted");

  if(common_scripts\utility::flag(var_4)) {
    return;
  }
  var_5 = "stop_loop";
  var_0.allowdeath = 1;

  if(!isDefined(var_3))
    thread maps\_anim::anim_generic_custom_animmode_loop(var_0, "gravity", var_1, var_2);
  else
    thread maps\_anim::anim_generic_loop(var_0, var_1, var_2);

  maps\_utility::add_wait(maps\_utility::waittill_msg, "stop_idle_proc");
  maps\_utility::add_func(maps\_stealth_utility::stealth_ai_clear_custom_idle_and_react);
  thread maps\_stealth_utility::do_wait_thread();
}

arm_player(var_0, var_1, var_2) {
  level.player takeallweapons();

  foreach(var_4 in var_0) {
    level.player giveweapon(var_4);
    level.player givemaxammo(var_4);
  }

  level.player switchtoweapon(var_0[0]);

  if(isDefined(var_1))
    level.player giveweapon("fraggrenade");
}

move_player_to_start(var_0) {
  var_1 = common_scripts\utility::getstruct(var_0, "targetname");

  if(!isDefined(var_1)) {
    var_1 = getent(var_0, "targetname");

    if(!isDefined(var_1))
      return;
  }

  level.player setorigin(var_1.origin);
  var_2 = undefined;

  if(isDefined(var_1.target))
    var_2 = getent(var_1.target, "targetname");

  if(isDefined(var_2))
    level.player setplayerangles(vectortoangles(var_2.origin - var_1.origin));
  else
    level.player setplayerangles(var_1.angles);

  wait 0.1;
}

grenade_ammo_probability(var_0) {
  self endon("death");

  if(randomint(100) > var_0)
    self.grenadeammo = 0;
}

print3d_on_me(var_0) {}

fade_out_in(var_0, var_1, var_2, var_3) {
  var_4 = newhudelem();
  var_4.x = 0;
  var_4.y = 0;
  var_4 setshader(var_0, 640, 480);
  var_4.alignx = "left";
  var_4.aligny = "top";
  var_4.horzalign = "fullscreen";
  var_4.vertalign = "fullscreen";
  var_4.alpha = 1;
  var_4.sort = -2;

  if(isDefined(var_1))
    level waittill(var_1);
  else
    wait(var_2);

  if(!isDefined(var_3))
    var_3 = 0.5;

  var_4 fadeovertime(var_3);
  var_4.alpha = 0;
  wait 1;
  var_4 destroy();
}

play_hand_signal_for_player() {
  self.did_handsignal = undefined;
  self waittill("trigger");

  if(isDefined(self.did_handsignal)) {
    return;
  }
  if(isDefined(level.doing_hand_signal) && level.doing_hand_signal)
    return;
  else
    level.doing_hand_signal = 1;

  self.did_handsignal = 1;
  var_0 = getaiarray("allies");

  if(var_0.size == 0) {
    return;
  }
  var_1 = maps\_utility::get_closest_to_player_view(var_0, level.player, 1);
  var_1 maps\_utility::disable_ai_color();
  var_1 do_hand_signal();
  var_1 maps\_utility::enable_ai_color();
  wait 5;
  level.doing_hand_signal = 0;
}

do_hand_signal() {
  if(isDefined(self.node)) {
    var_0 = self.node.type;

    if(tolower(var_0) == "cover right")
      var_1 = "signal_enemy_coverR";
    else if(tolower(var_0) == "cover left")
      var_1 = "signal_moveout_coverL";
    else
      var_1 = "signal_go";
  } else
    var_1 = "signal_onme_cqb";

  if(isDefined(self.animname)) {
    if(self.animname != "generic")
      self.old_animname = self.animname;
  }

  self.animname = "generic";

  if(isDefined(self.old_animname))
    self.animname = self.old_animname;
}

delete_ai_array_safe(var_0) {
  if(isDefined(var_0))
    thread maps\_utility::ai_delete_when_out_of_sight(var_0, 800);
}

isdefined_and_alive(var_0) {
  if(!isDefined(var_0))
    return 0;

  if(!isalive(var_0))
    return 0;

  if(!var_0 maps\_vehicle::isvehicle()) {
    if(var_0 maps\_utility::doinglongdeath())
      return 0;
  }

  return 1;
}

delete_if_player_cant_see_me() {
  self endon("death");

  if(!isdefined_and_alive(self)) {
    return;
  }
  while(maps\_utility::player_can_see_ai(self))
    wait 0.15;

  self delete();
}

spawn_ai_throttled_targetname(var_0, var_1, var_2) {
  var_3 = getEntArray(var_0, "targetname");
  var_4 = [];

  foreach(var_6 in var_3) {
    var_7 = var_6 maps\_utility::spawn_ai(1);
    var_4 = common_scripts\utility::array_add(var_4, var_7);
    wait(randomfloatrange(var_1, var_2));
  }

  level notify("done_throttled_spawn");
  return var_4;
}

spawn_ai_from_spawner_send_to_volume(var_0, var_1, var_2) {
  var_3 = [];
  var_0.count = var_1;

  for(var_4 = 0; var_4 < var_1; var_4++) {
    var_5 = var_0 stalingradspawn();
    wait 0.05;
    var_5 setgoalvolumeauto(var_2);
    var_5 laserforceon();
    var_3 = common_scripts\utility::add_to_array(var_3, var_5);
  }

  return var_3;
}

do_nags_til_flag(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(common_scripts\utility::flag(var_0) || common_scripts\utility::flag("waterfall_ambush_begin") || common_scripts\utility::flag("stream_backend_start")) {
    return;
  }
  level endon(var_0);
  level endon("waterfall_ambush_begin");
  level endon("stream_backend_start");
  var_8 = [];
  var_8[0] = var_3;

  if(isDefined(var_4))
    var_8[1] = var_4;

  if(isDefined(var_5))
    var_8[2] = var_5;

  if(isDefined(var_6))
    var_8[3] = var_6;

  if(isDefined(var_7))
    var_8[4] = var_7;

  while(!common_scripts\utility::flag(var_0) && !common_scripts\utility::flag("waterfall_ambush_begin")) {
    foreach(var_10 in var_8) {
      maps\jungle_ghosts_jungle::do_story_line(var_10);
      wait(randomintrange(var_1, var_2));
    }

    wait 0.15;
  }
}

battle_chatter_controller_friendlies() {
  level endon("field_halfway");

  for(;;) {
    maps\_utility::battlechatter_off("allies");

    if(!common_scripts\utility::flag("ambush_open_fire"))
      common_scripts\utility::flag_wait_any("_stealth_spotted", "ambush_open_fire");
    else
      common_scripts\utility::flag_wait("_stealth_spotted");

    maps\_utility::battlechatter_on("allies");

    if(common_scripts\utility::flag("ambush_open_fire"))
      common_scripts\utility::flag_wait("field_entrance");

    common_scripts\utility::flag_waitopen("_stealth_spotted");
    common_scripts\utility::waitframe();
  }
}

squad_manager(var_0) {
  var_1 = var_0.size;

  for(;;) {
    var_0 = maps\_utility::array_removedead_or_dying(var_0);

    if(var_0.size != var_1) {
      if(!isDefined(var_0["leader"])) {
        foreach(var_3 in var_0) {
          if(isdefined_and_alive(var_3)) {
            var_3 notify("elected_squad_leader");
            var_0["leader"] = var_3;
            var_3 thread squad_leader_logic();
            common_scripts\utility::array_thread(var_0, ::reset_my_leader, var_3);
            break;
          }
        }
      }

      if(var_0.size == 0) {
        return;
      }
      var_1 = var_0.size;
    }

    wait 0.5;
  }
}

create_a_squad_from_spawner(var_0, var_1, var_2) {
  var_3 = var_2;
  var_0.count = var_3;
  var_4 = undefined;

  for(var_5 = 0; var_5 < var_3; var_5++) {
    if(!isDefined(var_4)) {
      var_6 = var_0 stalingradspawn();
      wait 0.05;
      var_1["leader"] = var_6;
      var_6 thread squad_leader_logic();
      var_1 = common_scripts\utility::add_to_array(var_1, var_6);
      wait 1.5;
      var_4 = 1;
      continue;
    }

    var_6 = var_0 stalingradspawn();
    wait 0.05;
    var_6 thread squad_member_logic(var_1);
    var_1 = common_scripts\utility::add_to_array(var_1, var_6);
  }

  return var_1;
}

reset_my_leader(var_0) {
  self.leader = var_0;
}

squad_leader_logic() {
  self laserforceon();
  self.baseaccuracy = 3;
  maps\_utility::disable_long_death();

  while(isalive(self)) {
    self.goalradius = randomintrange(800, 1200);
    self setgoalpos(level.player.origin);
    wait(randomintrange(3, 5));
  }
}

squad_member_logic(var_0) {
  self endon("death");
  self laserforceon();
  maps\_utility::disable_long_death();
  self endon("elected_squad_leader");
  self.fixednode = 0;
  self.goalradius = randomintrange(200, 500);
  self.leader = var_0["leader"];

  for(;;) {
    if(isDefined(self.leader)) {
      self setgoalpos(self.leader.origin);
      wait(randomfloatrange(2.5, 3));
      continue;
    }

    iprintln("squad member has no leader to follow");
    wait 1;
  }
}

player_swim_think() {
  level.player setblurforplayer(6, 0.2);
  wait 0.3;
  thread enable_player_swim();
  level.player setblurforplayer(0, 0.8);
  level.player maps\_utility::player_speed_percent(20, 0.1);
  common_scripts\utility::flag_wait("player_out_of_water");
}

enable_player_swim() {
  setsaveddvar("hud_showStance", "0");
  setsaveddvar("compass", "0");
  level.player_view_pitch_down = getDvar("player_view_pitch_down");
  level.bg_viewbobmax = getDvar("bg_viewBobMax");
  level.player_sprintcamerabob = getDvar("player_sprintCameraBob");
  setsaveddvar("player_view_pitch_down", 5);
  setsaveddvar("bg_viewBobMax", 0);
  level.player allowstand(1);
  level.player allowcrouch(0);
  level.player allowprone(0);
  level.player allowjump(0);
  level.player disableweapons();
  level.player allowsprint(0);
  level.player allowmelee(0);
  level.player setstance("stand");
}

player_water_wade() {
  for(;;) {
    common_scripts\utility::flag_wait("player_is_moving");
    childthread player_water_wade_sounds();
    childthread player_water_wade_speed();
    wait 0.1;
    common_scripts\utility::flag_waitopen("player_is_moving");
    level.player notify("stop_water_sounds");
  }
}

player_water_wade_sounds() {
  level.player endon("stop_water_sounds");
  wait(randomfloatrange(0, 1));

  for(;;) {
    level.player maps\_utility::play_sound_on_entity("scn_prague_swim_slow_plr");
    wait(randomfloatrange(0.5, 1.5));
  }
}

player_water_wade_speed() {
  level endon("player_swim_faster");
  level.player endon("stop_water_sounds");

  while(!common_scripts\utility::flag("player_swim_faster")) {
    level.player thread maps\_utility::play_sound_on_entity("scn_prague_swim_slow_plr");
    thread maps\_utility::player_speed_percent(27, 1);
    wait 1;
    thread maps\_utility::player_speed_percent(18, 0.3);
    wait 0.5;
  }
}

custom_waterfx(var_0, var_1) {
  self endon("death");

  if(isDefined(var_0)) {
    common_scripts\utility::flag_assert(var_0);
    level endon(var_0);
  }

  if(!isDefined(var_1))
    var_1 = (0, 0, 0);

  for(;;) {
    wait(randomfloatrange(0.15, 0.3));
    var_2 = self.origin + (0, 0, 150);
    var_3 = self.origin - (0, 0, 150);
    var_4 = bulletTrace(var_2, var_3, 0, undefined);

    if(var_4["surfacetype"] != "water") {
      continue;
    }
    var_5 = "water_movement";

    if(isPlayer(self)) {
      if(distance(self getvelocity(), (0, 0, 0)) < 5)
        var_5 = "water_stop";
    } else if(isDefined(level._effect["water_" + self.a.movement]))
      var_5 = "water_" + self.a.movement;

    var_6 = common_scripts\utility::getfx(var_5);
    var_2 = var_4["position"] + var_1;
    var_7 = (0, self.angles[1], 0);
    var_8 = anglesToForward(var_7);
    var_9 = anglestoup(var_7);
    playFX(var_6, var_2, var_9, var_8);
  }
}

enable_ai_swim() {
  self.animname = "generic";
  maps\_utility::disable_cqbwalk();
  maps\_utility::disable_sprint();
  self stopanimscripted();
  set_generic_idle_forever("swim_idle");
  maps\_utility::set_moveplaybackrate(1);
  maps\_utility::set_generic_run_anim("swim_fast", 1);
  self pushplayer(1);
  self.disableexits = 1;
  self.disablearrivals = 1;
  self.a.disablepain = 1;
  self.ignoreall = 1;
  thread custom_waterfx("player_out_of_water", (0, 0, -0.5));
  thread ai_swim_sound();
  maps\_utility::putgunaway();
}

ai_swim_sound() {
  self endon("stop_swimming");
  childthread ai_swim_sound_idle();

  for(;;) {
    self waittill("moveanim", var_0);

    if(var_0 == "ps_scn_prague_swim_slow_npc" || var_0 == "end")
      maps\_utility::play_sound_on_entity("scn_prague_swim_slow_npc");

    wait 0.2;
  }
}

ai_swim_sound_idle() {
  self endon("stop_swimming");

  for(;;) {
    self waittill("Special_idle", var_0);

    if(var_0 == "ps_scn_prague_swim_idle_npc" || var_0 == "end")
      maps\_utility::play_sound_on_entity("scn_prague_swim_idle_npc");

    wait 0.2;
  }
}

set_generic_idle_forever(var_0) {
  thread set_generic_idle_internal(var_0);
}

set_generic_idle_internal(var_0) {
  self endon("death");
  self endon("clear_idle_anim");

  for(;;) {
    maps\_utility::set_generic_idle_anim(var_0);
    self waittill("clearing_specialIdleAnim");
  }
}

pitch_and_roll() {
  self endon("stop_bob");
  self endon("death");
  var_0 = self;
  var_1 = (0, var_0.angles[1], 0);
  var_2 = 20;

  if(isDefined(var_0.script_max_left_angle))
    var_2 = var_0.script_max_left_angle;

  var_3 = var_2 * 0.5;
  var_4 = 4;

  if(isDefined(var_0.script_duration))
    var_4 = var_0.script_duration;

  var_5 = var_4 * 0.5;
  var_0 = undefined;

  for(;;) {
    var_6 = (randomfloatrange(var_3, var_2), 0, randomfloatrange(var_3, var_2));
    var_7 = randomfloatrange(var_5, var_4);
    self rotateto(var_1 + var_6, var_7, var_7 * 0.2, var_7 * 0.2);
    self waittill("rotatedone");
    self rotateto(var_1 - var_6, var_7, var_7 * 0.2, var_7 * 0.2);
    self waittill("rotatedone");
  }
}

stop_anim_on_damage_stealth(var_0) {
  self endon("death");
  level endon("_stealth_spotted");
  self waittill("damage");
  var_0 notify("stop_loop");
  maps\_utility::anim_stopanimscripted();
}

stop_anim_on_spotted_or_chopper_leaves(var_0) {
  self endon("death");
  level common_scripts\utility::waittill_any("_stealth_spotted", "stream_heli_out");
  var_0 notify("stop_loop");
  maps\_utility::anim_stopanimscripted();
}

generic_ignore_on() {
  self.ignoreme = 1;
  self.ignoreall = 1;
}

generic_ignore_off() {
  self.ignoreme = 0;
  self.ignoreall = 0;
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

hud_on(var_0) {
  var_1 = 0;
  var_2 = 1;

  if(!var_0) {
    var_1 = 1;
    var_2 = 0;
  }

  setsaveddvar("compass", var_2);
  setsaveddvar("ammoCounterHide", var_1);
  setsaveddvar("actionSlotsHide", var_1);
  setsaveddvar("hud_showStance", var_2);
  setsaveddvar("hud_drawhud", var_2);
}

waittill_x_passed(var_0) {
  while(level.player.origin[0] < var_0)
    common_scripts\utility::waitframe();
}

waittill_y_passed(var_0) {
  while(level.player.origin[1] < var_0)
    common_scripts\utility::waitframe();
}

enemy_weapons_force_use_init() {
  level.jg_enemy_smgs = [];
  level.jg_enemy_smgs = common_scripts\utility::array_add(level.jg_enemy_smgs, "kriss+silencer_sp");
  level.jg_enemy_smgs = common_scripts\utility::array_add(level.jg_enemy_smgs, "microtar+silencer_sp");
  level.jg_enemy_ars = [];
  level.jg_enemy_ars = common_scripts\utility::array_add(level.jg_enemy_ars, "cz805bren+silencer_sp");
  level.jg_enemy_ars = common_scripts\utility::array_add(level.jg_enemy_ars, "ak12+silencer_sp");
  level.jg_enemy_ars = common_scripts\utility::array_add(level.jg_enemy_ars, "honeybadger");
  level.jg_enemy_ars = common_scripts\utility::array_add(level.jg_enemy_ars, "sc2010+silencer_sp");
}

enemy_weapons_force_use_silencer() {
  if(!isDefined(self)) {
    return;
  }
  if(!isDefined(self.classname)) {
    return;
  }
  self endon("death");

  if(self.classname == "actor_enemy_fed_army_smg_nohelmet") {
    var_0 = common_scripts\utility::array_randomize(level.jg_enemy_smgs);
    maps\_utility::forceuseweapon(var_0[0], "primary");
  }

  if(self.classname == "actor_enemy_fed_army_ar_nohelmet") {
    var_0 = common_scripts\utility::array_randomize(level.jg_enemy_ars);
    maps\_utility::forceuseweapon(var_0[0], "primary");
  }
}

friendly_jungle_stealth_color_behavior() {
  var_0["hidden"] = ::do_nothing;
  var_0["spotted"] = ::do_nothing;
  maps\_stealth_utility::stealth_color_state_custom(var_0);
}

do_nothing() {}

music_start() {
  level endon("_stealth_spotted");
  level endon("stop_music_jg");
  wait 0.1;
  thread music_stealth_tension_loop();
}

music_stealth_tension_loop() {
  level endon("_stealth_spotted");
  level endon("stop_tension_music_jg");
  level notify("stop_stealth_music_jg");
  thread music_stealth_broken();

  for(;;) {
    var_0 = "mus_jungle_tension";

    if(common_scripts\utility::flag("second_distant_sat_launch") && !common_scripts\utility::flag("to_grassy_field"))
      var_0 = "mus_jungle_stealth";
    else if(common_scripts\utility::flag("second_distant_sat_launch") && common_scripts\utility::flag("to_grassy_field"))
      var_0 = "mus_jungle_reveal";

    if(!common_scripts\utility::flag("jungle_entrance")) {
      common_scripts\utility::flag_wait("intro_lines");
      var_0 = "mus_jungle_tension_reveal";
    }

    music_play_jg(var_0, 4, 0, 1);
    common_scripts\utility::waitframe();
  }
}

music_stealth_broken() {
  level endon("stop_stealth_music_jg");
  level common_scripts\utility::waittill_any("_stealth_spotted", "ambush_open_fire");
  level notify("stop_tension_music_jg");
  var_0 = "mus_jungle_stealthbreak1";

  if(common_scripts\utility::cointoss())
    var_0 = "mus_jungle_stealthbreak2";

  if(common_scripts\utility::flag("second_distant_sat_launch") && !common_scripts\utility::flag("to_grassy_field") && !common_scripts\utility::flag("player_in_ambush_position")) {
    maps\_utility::music_stop(2);
    var_0 = "mus_jungle_chopper_crash_battle";

    if(common_scripts\utility::flag("smaw_target_detroyed"))
      wait 7;
  }

  var_1 = 0;

  if(common_scripts\utility::flag("player_in_ambush_position"))
    var_1 = 1;

  music_play_jg(var_0, 0.5, 1, 0, var_1);

  if(common_scripts\utility::flag("intro_lines")) {
    while(common_scripts\utility::flag("_stealth_spotted") || common_scripts\utility::flag("ambush_open_fire") && !common_scripts\utility::flag("field_halfway"))
      wait 1;
  }

  thread music_stealth_tension_loop();
}

music_tall_grass() {
  if(!common_scripts\utility::flag("_stealth_spotted"))
    stop_music_jg(0);

  var_0 = "mus_jungle_tall_grass_intro";
  common_scripts\utility::flag_waitopen("_stealth_spotted");
  thread music_play_jg(var_0, 1);
  thread music_stealth_broken();
}

music_escape_hot() {
  stop_music_jg(0);
  var_0 = "mus_jungle_escape";
  maps\_utility::music_play(var_0, 1);
}

music_end_jump_stinger() {
  if(!common_scripts\utility::flag("choppers_saw_player"))
    maps\_utility::music_stop(4);
  else {
    if(level.start_point != "escape_river" && level.start_point != "underwater") {
      maps\_utility::music_crossfade("mus_jungle_end_stinger", 0.5);
      return;
    }

    maps\_utility::music_play("mus_jungle_end_stinger", 0.5);
  }
}

music_play_jg(var_0, var_1, var_2, var_3, var_4) {
  level endon("stop_music_jg");
  var_5 = maps\_utility::musiclength(var_0);
  var_6 = 15;
  var_7 = 35;

  if(!isDefined(var_1))
    var_1 = 0.5;

  if(!isDefined(var_4))
    var_4 = 0;

  if(isDefined(var_3) && var_3 && common_scripts\utility::flag("_stealth_spotted")) {
    return;
  }
  maps\_utility::music_play(var_0, var_1);

  if(!isDefined(var_2) || !var_2 || var_4)
    wait(randomfloatrange(var_5 + var_6, var_5 + var_7));
  else {
    while(common_scripts\utility::flag("_stealth_spotted") || var_0 == "mus_jungle_chopper_crash_battle" && !common_scripts\utility::flag("stream_clear"))
      wait 1;

    maps\_utility::music_stop(4);
    wait 8;
  }
}

stop_music_jg(var_0) {
  level notify("stop_music_jg");
  level notify("stop_tension_music_jg");
  level notify("stop_stealth_music_jg");

  if(var_0)
    maps\_utility::music_stop(4);
}

set_death_quote(var_0) {
  setDvar("ui_deadquote", var_0);
}

give_jg_achievement() {
  if(!level.was_spotted)
    level.player maps\_utility::player_giveachievement_wrapper("LEVEL_9A");
}

dialogue_stop() {
  level.hesh stopsounds();
  level.merrick stopsounds();
  level.alpha1 stopsounds();
  level.alpha2 stopsounds();
  common_scripts\utility::waitframe();
}