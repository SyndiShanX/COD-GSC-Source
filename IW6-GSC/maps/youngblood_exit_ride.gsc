/*****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\youngblood_exit_ride.gsc
*****************************************/

exit_ride_setup() {
  var_0 = maps\_utility::spawn_anim_model("player_rig", level.player.origin);
  common_scripts\utility::flag_set("truck_pickup_npcs");
  level.elias maps\_utility::delaythread(0.1, maps\_utility::smart_dialogue, "youngblood_els_itoldyouto");
  var_1 = getdvarint("awesome", 1);
  var_2 = getdvarint("scr_art_tweak", 0);

  if(!var_1)
    var_3 = getvehiclenode("start_truck_part3", "script_noteworthy");
  else
    var_3 = getvehiclenode("start_truck_part3_2", "script_noteworthy");

  level.truck attachpath(var_3);
  level.truck thread maps\_vehicle::vehicle_paths(var_3);
  level.truck startpath(var_3);
  thread city_collapse();
  level.hesh linkto(level.truck, "tag_body");
  level.elias linkto(level.truck, "tag_body");
  thread hesh_getin_truck();
  level.truck thread maps\_anim::anim_loop_solo(var_0, "youngblood_truck_exit_idle_player");
  level.truck thread maps\_anim::anim_generic_loop(level.elias, "youngblood_truck_exit_idle_elias");
  level.player playerlinktodelta(var_0, "tag_player", 0.5, 0, 45, 25, 25);
  var_0 show();
  var_0 linkto(level.truck, "tag_body");
  level.player shellshock("ygb_end_lite", 999);
  level notify("stop_vfx_on_player");
  level.player_outside = 1;
  level.player_location_vfx = "vfx_yb_onplayer_city_vista_a";
  level.player thread maps\youngblood_code::vfx_on_player_location_to_odin();
  wait 1.5;

  if(var_1)
    maps\_utility::delaythread(0, maps\_utility::vision_set_fog_changes, "", 2.3);

  level thread maps\_hud_util::fade_in(0.6);
  level.player setblurforplayer(0, 3.0);

  if(var_2) {
    level.truck vehicle_setspeed(0, 4, 4);
    return;
  }

  level.truck vehicle_setspeed(10, 1);

  if(!isDefined(level.prologue) || isDefined(level.prologue) && level.prologue == 0) {
    wait 7;
    mission_finished();
    return;
  }

  level.player common_scripts\utility::delaycall(5.75, ::setblurforplayer, 8, 6);
  level maps\_utility::delaythread(5.25, maps\_hud_util::fade_out, 8.0);
  maps\_utility::delaythread(5.75, ::fade_in_logo);
  wait 12;
  var_4 = maps\_hud_util::get_optional_overlay("black");
  var_4.sort = 3;
  var_4.foreground = 0;
  var_4 fadeovertime(1);
  level.logo fadeovertime(1);
  level.logo2 fadeovertime(1);
  level.logo2.alpha = 0.25;
  level.player setclienttriggeraudiozone("youngblood_end_fade_out", 3.0);
  wait 1.2;
  level.logo fadeovertime(1);
  level.logo.alpha = 0;
  level.logo2 fadeovertime(1);
  level.logo2.alpha = 0;
  wait 2;
  mission_finished();
}

city_collapse() {
  maps\_utility::trigger_wait("city_rog_trig", "script_noteworthy");
  maps\_utility::activate_trigger_with_noteworthy("building_collapse_trig");
}

hesh_getin_truck() {
  level.hesh maps\_utility::delaythread(0.1, maps\youngblood_util::_set_anim_time, "youngblood_truck_exit_getin_hesh", 0.23);
  level.truck maps\_anim::anim_single_solo(level.hesh, "youngblood_truck_exit_getin_hesh");
  level.truck thread maps\_anim::anim_loop_solo(level.hesh, "youngblood_truck_exit_idle_hesh");
}

fade_in_logo() {
  var_0 = maps\_hud_util::get_optional_overlay("black");
  var_0.sort = 3;
  var_0.foreground = 0;
  wait 0.5;
  var_1 = level.player maps\_hud_util::createclienticon("logo_game_big_blur_blend", 500, 250);
  var_1.sort = 4;
  var_1 maps\_hud_util::setpoint("CENTER", "CENTER", 0, 0, 0);
  var_1.alpha = 0;
  var_1 fadeovertime(1);
  var_1.alpha = 0.8;
  wait 0.25;
  var_2 = level.player maps\_hud_util::createclienticon("logo_game_big", 500, 250);
  var_2.sort = 5;
  var_2 maps\_hud_util::setpoint("CENTER", "CENTER", 0, 0, 0);
  var_2.alpha = 0;
  var_2 fadeovertime(1);
  var_2.alpha = 1;
  level.logo = var_2;
  level.logo2 = var_1;
}

spawn_and_setup_elias() {
  common_scripts\utility::trigger_off("player_get_in_truck", "targetname");
  level.truck = maps\_vehicle::spawn_vehicle_from_targetname("truck");
  level.truck.animname = "pickup";
  level.truck useanimtree(level.scr_animtree["pickup"]);
  level.truck thread maps\_anim::anim_single_solo(level.truck, "youngblood_truck_gate_open");
  var_0 = getvehiclenode("start_truck_drive_in_b", "script_noteworthy");
  level.truck vehicle_teleport(var_0.origin, var_0.angles);
  level.truck maps\_vehicle::vehicle_lights_on("headlights");
  maps\youngblood_util::spawn_elias();
  var_1 = common_scripts\utility::getstruct("elias_pickup_exit_spawn", "targetname");
  level.elias forceteleport(var_1.origin, var_1.angles);
  level.elias linkto(level.truck, "tag_origin");
  level.truck thread maps\_anim::anim_generic_loop(level.elias, "youngblood_truck_exit_idle_elias", "elias_car_stop");
  level.truck attachpath(var_0);
  level.truck thread maps\_vehicle::vehicle_paths(var_0);
  level.truck startpath(var_0);
  common_scripts\utility::flag_wait("truck_2nd_position");
  var_0 = getvehiclenode("start_truck_part2", "script_noteworthy");
  level.truck attachpath(var_0);
  level.truck thread maps\_vehicle::vehicle_paths(var_0);
  level.truck startpath(var_0);
  common_scripts\utility::flag_wait("truck_3rd_position");
  level.truck notify("elias_car_stop");
  waittillframeend;
  level.player setclienttriggeraudiozone("youngblood_end_black", 3.0);
  level.elias maps\_utility::delaythread(2, maps\_utility::smart_dialogue, "youngblood_els_getinthetruck");
  level.truck maps\_anim::anim_generic(level.elias, "youngblood_truck_exit_getin_elias");
  level.truck thread maps\_anim::anim_generic_loop(level.elias, "youngblood_truck_exit_idle_elias", "elias_car_stop");

  if(getdvarint("chaos_long_end") == 1) {
    level.player setblurforplayer(10, 1.8);
    level maps\_hud_util::fade_out(3.6);
    wait 5;
  }

  level.player setblurforplayer(10, 1.8);
  level maps\_hud_util::fade_out(3.6);
  common_scripts\utility::flag_set("truck_1st_position");
  var_0 = getvehiclenode("start_truck_part3", "script_noteworthy");
  level.truck attachpath(var_0);
  level.truck thread maps\_vehicle::vehicle_paths(var_0);
  level.truck startpath(var_0);
  level.hesh linkto(level.truck, "tag_origin");
  level.truck thread maps\_anim::anim_loop_solo(level.hesh, "youngblood_truck_exit_idle_hesh");
  var_2 = maps\_utility::spawn_anim_model("player_rig", level.player.origin);
  maps\youngblood_util::viewmodel_anim_on();
  level.truck maps\_anim::anim_first_frame_solo(var_2, "youngblood_truck_exit_getin_player");
  level.player playerlinktodelta(var_2, "tag_player", 1, 45, 45, 25, 25);
  var_2 show();
  level.truck maps\_anim::anim_single_solo(var_2, "youngblood_truck_exit_getin_player");
  level.truck thread maps\_anim::anim_loop_solo(var_2, "youngblood_truck_exit_idle_player");
  var_2 linkto(level.truck, "tag_origin");
  level.player lerpfov(65, 0.1);
  level thread maps\_hud_util::fade_in(3.0);
  level.player setblurforplayer(0, 6.0);
  wait 1;
  common_scripts\utility::flag_set("truck_pickup_npcs");
  level.truck vehicle_setspeed(10, 3);
  level.player thread player_chaos_blur();
  wait 1.0;
  setslowmotion(1, 0.3, 3);
  wait 3.0;
  level.player setblurforplayer(10, 2);
  level maps\_hud_util::fade_out(4.0);
  thread mission_finished();
}

player_chaos_blur() {
  self endon("dying");

  for(;;) {
    wait 0.05;

    if(randomint(100) > 10) {
      continue;
    }
    var_0 = randomint(2) + 4;
    var_1 = randomfloatrange(0.1, 0.3);
    var_2 = randomfloatrange(0.3, 1);
    setblur(var_0 * 1.2, var_1);
    wait(var_1);
    setblur(0, var_2);
    wait(var_2);
    wait(randomfloatrange(0, 1.5));
    common_scripts\utility::waittill_notify_or_timeout("blur", 5);
  }
}

mission_finished() {
  maps\_utility::nextmission();
}