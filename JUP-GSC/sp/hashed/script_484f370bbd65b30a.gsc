/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_484f370bbd65b30a.gsc
*************************************************/

#using script_19163c4e4e504a5e;
#using script_1db908936531314b;
#using script_4b7698942d6f679a;
#using script_51f0a664afd44022;
#using script_53f4e6352b0b2425;
#using script_54110734a7546551;
#using script_6bf6c8e2e1fdccaa;
#using script_760b8e170bd1e20d;
#using scripts\anim\dialogue;
#using scripts\anim\shared;
#using scripts\common\ai;
#using scripts\common\anim;
#using scripts\common\exploder;
#using scripts\common\scene;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\engine\sp\objectives;
#using scripts\engine\sp\utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\sp\anim;
#using scripts\sp\hud_util;
#using scripts\sp\maps\sp_jup_vip\sp_jup_vip_lighting;
#using scripts\sp\player;
#using scripts\sp\player\cursor_hint;
#using scripts\sp\player_rig;
#using scripts\sp\utility;
#namespace namespace_c1af6f027faee73;

function function_9282638b76e87b0a() {}

function function_86a88b13dcfe495e() {
  thread scripts\sp\maps\sp_jup_vip\sp_jup_vip_lighting::cp_intro();
  thread function_e39d8a96b86719ce(1);
  set_start_location("intro", [level.player]);
}

function function_43de679a99606c07() {
  thread function_f104d3f59e3fdd6();
  thread function_871fc21b56c849b5();
  intro_anim_scene();
}

function function_67284e12c35a9944() {
  flag_set("flag_obj_get_to_gulag_activate");
  flag_set("vip_play_music_scuba_intro");
  flag_set("cine_intro_end");
  thread namespace_165c742e346e899e::function_96cc4e998f08aca5();
}

function function_edd523d9d52759e8() {
  var_e86b25000c0fb10e = getStruct("scene_vip_0001_intro", "targetname");
  var_148062269544a623 = var_e86b25000c0fb10e scene::get_entity("ally1");
  var_dc6e89e2d0743120 = var_e86b25000c0fb10e scene::get_entity("ally2");
  var_120270b0cfc78cda = var_e86b25000c0fb10e scene::get_entity("FakePlayer");
  waitframe();
  var_dc6e89e2d0743120 notify("ally2_glowstick_on");
  waitframe();
  var_148062269544a623 notify("ally1_glowstick_on");
  waitframe();
  flag_set("cine_intro_glow_break");
  flag_set("cine_intro_dpv_light_ally");
  waitframe();
  var_120270b0cfc78cda notify("player_glowsticks_on");
  waitframe();
  flag_set("cine_intro_glow_break_2");
  waitframe();
  level notify("cine_intro_shake_on");
  waitframe();
  level notify("cine_intro_shake_off");
  waitframe();
  level notify("cine_intro_shake_on");
  waitframe();
  flag_set("flag_ally2_glowstick_attach");
  flag_set("cine_intro_end");
  flag_set("lgt_emerge_v2_swim_end");
}

function function_5c55148c6770a5e9() {
  flag_set("lgt_emerge_v2_start");
  flag_set("lgt_scuba_emerge_start");
  waitframe();
  level.ally1 notify("notify_switch_wall_idle");
  waitframe();
  flag_set("lgt_emerge_v2_swim_end");
}

function function_f0130740538b7590() {
  flag_set("lgt_scuba_emerge_start");
}

function function_a7dd8cac82fd443a() {
  function_64f815da552ce8c6();
  wait 8;
  level.player say("dx_sp_jvip_jvrl_koa2_allteamsalpha21beadv");
  level.player.vo_handler say("dx_sp_jvip_jvrl_koc1_charliecopieswereset");
  level.ally1 say("dx_sp_jvip_jvrl_koa1_rogerthatmovingtopha");
  level.ally1 say("dx_sp_jvip_jvrl_koa1_patrolboattwooclockl");
}

function function_8b09f4e11779ca18(music_delay) {
  flag_wait("cine_intro_end");
}

function intro_anim_scene() {
  level.player player::focusdisable();
  function_1ae8f046dee579e0(1);
  setsaveddvar(@ "hash_fa84e9dc55b9d406", 0);
  level.player fade_out(0, "black");
  spawn_allies();
  function_5ab38289fd2ee60a();
  start_origin = getStruct("intro", "targetname");
  struct = spawn_script_origin(start_origin.origin + (0, 0, -250), start_origin.angles);
  teleport_player(struct);
  waitframe();
  level.player fade_in(0, "black");
  level thread scripts\sp\maps\sp_jup_vip\sp_jup_vip_lighting::function_9a73cff3a0f6f2c5();
  array = [level.ally1, level.ally2];
  animnode = getStruct("scene_vip_0000_intro", "targetname");
  var_e86b25000c0fb10e = getStruct("scene_vip_0001_intro", "targetname");
  var_479df2f396f53c1c = animnode scene::get_entity("FakePlayer");
  var_479df5f396f542b5 = var_e86b25000c0fb10e scene::get_entity("FakePlayer");
  thread function_de6d4086f35c3f42();
  flag_set("vip_play_music_scuba_intro");
  thread function_a7dd8cac82fd443a();
  thread function_8b09f4e11779ca18(1.5);

  if(isDefined(animnode)) {
    animnode thread function_57ac36ea7abb5af4(undefined, array, "shot_020");
    var_479df2f396f53c1c = animnode scene::get_entity("FakePlayer");
    var_479df2f396f53c1c setModel("body_c_jup_sp_enemy_pmc_scuba_01");
    var_479df2f396f53c1c detach(var_479df2f396f53c1c.headmodel);
    var_479df2f396f53c1c.headmodel = "head_c_jup_sp_enemy_pmc_scuba_01";
    var_479df2f396f53c1c attach(var_479df2f396f53c1c.headmodel);
    var_479df2f396f53c1c.name = "";
    boat_1 = animnode scene::get_entity("Prop 5");
    boat_2 = animnode scene::get_entity("Prop 6");
    var_a4674cc45c73983e = playFXOnTag(getfx("vfx_vip_light_searchlight_boat"), boat_1, "tag_light_front_left");
    var_a4674bc45c73960b = playFXOnTag(getfx("vfx_vip_light_searchlight_boat"), boat_2, "tag_light_front_left");
    var_e79ff62bf78d657e = getEnt("boat_searchlight_4", "targetname");
    var_e79ff62bf78d657e setlightintensity(2000);
    var_cd6e8c3833e8aada = spawn_tag_origin(boat_2.origin, boat_2.angles);
    var_e79ff62bf78d657e linkTo(boat_2, "tag_light_front_left", (20, 0, 0), (0, 0, 0));
    animnode waittill("scene_complete");
  }

  if(isDefined(var_e86b25000c0fb10e)) {
    var_e86b25000c0fb10e thread function_57ac36ea7abb5af4(undefined, array, "shot_030");
    thread namespace_165c742e346e899e::function_a206babc50297a7e();
    var_479df5f396f542b5 = var_e86b25000c0fb10e scene::get_entity("FakePlayer");
    var_479df5f396f542b5 setModel("body_c_jup_sp_enemy_pmc_scuba_01");
    var_479df5f396f542b5 detach(var_479df5f396f542b5.headmodel);
    var_479df5f396f542b5.headmodel = "head_c_jup_sp_enemy_pmc_scuba_01";
    var_479df5f396f542b5 attach(var_479df5f396f542b5.headmodel);
    var_479df5f396f542b5.name = "";
    flag_set("flag_glowstickstart");
    level.player take_weapon(level.smg);
    level.player take_weapon(level.startweapon);
    level.player give_weapon(level.var_5d30013b94a2135d);
    level.player switchtoweapon(level.var_5d30013b94a2135d);
    grappling_gun = utility::spawn_model("misc_wm_grappling_gun_prison_v0");
    grappling_gun linktoplayerview(level.player, "tag_sling", (0, 0, 0), (0, 0, 0), 0);
    level.grappling_gun = grappling_gun;
    wait 1.5;

    iprintlnbold("<dev string:x1c>");

    wait 5.5;
    function_edd523d9d52759e8();
    flag_wait("cine_intro_end");
    level.player setclientomnvar("ui_chyron_level_index", 1);
    wait 2;
    var_e86b25000c0fb10e scene::stop();
  }

  level.ally1 function_36d8c0ddc6500bb7(1);
  level.ally2 function_36d8c0ddc6500bb7(1);
  level.player function_92212af9ed2ce636(1);
  level notify("cine_intro_end");
  var_e79ff62bf78d657e setlightintensity(0);
  flag_set("player_scuba_start");
  level.player player::focusenable();
  function_1ae8f046dee579e0(0);
  setsaveddvar(@ "hash_fa84e9dc55b9d406", 1);
}

function function_de6d4086f35c3f42() {
  animnode = getStruct("scene_vip_0000_intro", "targetname");
  var_e86b25000c0fb10e = getStruct("scene_vip_0001_intro", "targetname");
  flag_wait("flag_glowstickstart");
  ally1 = var_e86b25000c0fb10e scene::get_entity("ally1");
  ally2 = var_e86b25000c0fb10e scene::get_entity("ally2");
  fakeplayer = var_e86b25000c0fb10e scene::get_entity("FakePlayer");
  level.fakeplayer = fakeplayer;
  var_e86b25000c0fb10e scene::function_8207074e79f22926(fakeplayer, "player_glowsticks_on", "FakePlayer");
  var_e86b25000c0fb10e scene::function_8207074e79f22926(ally1, "ally1_glowstick_on", "ally1");
  var_e86b25000c0fb10e scene::function_8207074e79f22926(ally2, "ally2_glowstick_on", "ally2");
  var_e86b25000c0fb10e scene::function_8207074e79f22926(level.player, "fov_start_90_1", "level.player_rig");
  var_efbfff0726c683b0 = var_e86b25000c0fb10e scene::get_entity("Prop 10");
  ally1_glowstick_on = var_e86b25000c0fb10e scene::get_entity("Prop 7");
  var_a75b3906f1c3367b = var_e86b25000c0fb10e scene::get_entity("Prop 16");
  var_e3bb812f6073a78d = var_e86b25000c0fb10e scene::get_entity("Prop 12");
  ally2_glowstick_on = var_e86b25000c0fb10e scene::get_entity("Prop 9");
  var_2c78472f95d7c18e = var_e86b25000c0fb10e scene::get_entity("Prop 18");
  var_8fa31955e3b7a652 = var_e86b25000c0fb10e scene::get_entity("Prop 11");
  var_948a093a5ae43398 = var_e86b25000c0fb10e scene::get_entity("Prop 8");
  var_f64043562f527791 = var_e86b25000c0fb10e scene::get_entity("Prop 17");
  level.glowsticks = [var_efbfff0726c683b0, ally1_glowstick_on, var_a75b3906f1c3367b, var_e3bb812f6073a78d, ally2_glowstick_on, var_2c78472f95d7c18e, var_8fa31955e3b7a652, var_948a093a5ae43398, var_f64043562f527791];
  ally1_glowstick_on hide();
  ally2_glowstick_on hide();
  var_948a093a5ae43398 hide();
  ally1 waittill("ally1_glowstick_on");
  ally1_glowstick_on show();
  var_efbfff0726c683b0 hide();
  ally2 waittill("ally2_glowstick_on");
  var_2c78472f95d7c18e show();
  var_e3bb812f6073a78d hide();
  fakeplayer waittill("player_glowsticks_on");
  var_948a093a5ae43398 show();
  var_8fa31955e3b7a652 hide();
  flag_wait("scene_complete");
  ally1_glowstick_on hide();
  ally2_glowstick_on hide();
  var_948a093a5ae43398 hide();
}

function function_4cada0b6b8467c49() {
  self endon("end_dpv");
  self notifyonplayercommand("sprint_enable", "+breath_sprint");
  self notifyonplayercommand("sprint_enable", "+sprint");
  self notifyonplayercommand("sprint_disable", "-forward");
  self notifyonplayercommand("sprint_disable", "+back");
  self notifyonplayercommand("sprint_disable", "-back");
  self notifyonplayercommand("sprint_disable", "+moveleft");
  self notifyonplayercommand("sprint_disable", "-moveleft");
  self notifyonplayercommand("sprint_disable", "+moveright");
  self notifyonplayercommand("sprint_disable", "-moveright");
  level.player.var_6bf248d598370bf1 = 0;
}

function function_92212af9ed2ce636(play_fx) {
  if(istrue(play_fx)) {}
}

function function_36d8c0ddc6500bb7(play_fx) {
  if(istrue(play_fx)) {
    playFXOnTag(level._effect["vfx_vip_water_diver_bubble_01"], self, "j_chest");
    return;
  }

  stopFXOnTag(level._effect["vfx_vip_water_diver_bubble_01"], self, "j_chest");
}

function spin_propeller() {
  level.player endon("end_dpv");
  setsaveddvar(@ "hash_d7685846e216c7b3", 0.95);
  wait 1;
  self linktoplayerview(level.player, "j_propeller");
  angle = 0;

  while(true) {
    velocity = level.player getvelocity();
    forward = anglesToForward(level.player getplayerviewangles());
    forward_speed = vectordot(velocity, forward);
    speed = forward_speed * 10;

    if(speed > 0) {
      angle += speed * 0.05;

      if(angle > 360) {
        angle -= 360;
      }
    }

    self function_b2018129f140ef5d(level.player, (0, 0, angle), 1);
    waitframe();
  }
}

function function_1ef6967993effd57() {
  thread scripts\sp\player::disable_player_weapon_info();
  level.player disableweaponswitch();
  level.player function_8b7829a01e6b58aa(0);
  level.player val::set("vip_dpv", "fire", 0);
  level.player val::set("vip_dpv", "melee", 0);
  level.player val::set("vip_dpv", "mantle", 0);
  level.player val::set("vip_dpv", "ads", 0);
  level.player thread function_fa3174a787595b01();
  flag_wait("flag_start_wall_ascend");
  level.player notify("end_dpv");
  level.player function_9354c4c50c43abc0(1);

  if(isDefined(level.grappling_gun)) {
    grappling_gun = level.grappling_gun;
    grappling_gun unlinkfromplayerview(level.player);
    grappling_gun delete();
  }

  level.player take_weapon(level.var_5d30013b94a2135d);
  level.player enableweaponswitch();
  level.player function_8b7829a01e6b58aa(1);
  level.player val::reset_all("vip_dpv");
  level.player function_92212af9ed2ce636(0);
  level.ally1 function_36d8c0ddc6500bb7(0);
  level.ally2 function_36d8c0ddc6500bb7(0);
  flag_set("vip_fov_scuba_gameplay_end");
}

function function_fa3174a787595b01() {
  self endon("end_playermove");

  while(true) {
    if(level.player isswimunderwater()) {
      var_ff99c4fde1caa810 = level.player getnormalizedmovement(0.2, 0.2);
      var_bd837da502678594 = var_ff99c4fde1caa810[0];
      var_df78441a978e79e3 = var_ff99c4fde1caa810[1];

      if(var_bd837da502678594 <= 0 || var_df78441a978e79e3 > 0 || var_df78441a978e79e3 < 0) {
        level.player notify("sprint_disable");
      }
    }

    wait 0.1;
  }
}

function function_18cb72f43f56aa7c() {
  setsaveddvar(@ "hash_fa84e9dc55b9d406", 0);
  level.player fade_out(0, "black");
  level.player player::focusdisable();
  level.player freezecontrols(1);
  function_1ae8f046dee579e0(1);
  character_array = [level.ally1, level.ally2];
  var_d683d17bf2124d5e = ["shot_010", "shot_020"];
  animnode = getStruct("scene_vip_0100_scuba_alpha", "targetname");
  var_a6faa64bf8570cef = getStruct("vip_0160_scuba_emerge", "targetname");
  var_a6faa64bf8570cef scene::function_8207074e79f22926(level.ally1, "notify_switch_wall_idle", "ally1");
  var_a6faa64bf8570cef scene::function_8207074e79f22926(level.ally2, "notify_player_breached_surface", "ally2");
  var_a6e2d5850ed102cc = animnode scene::get_entity("Prop 3");
  var_a6e2d8850ed10965 = animnode scene::get_entity("Prop 4");
  var_a6e2d7850ed10732 = var_a6faa64bf8570cef scene::get_entity("Prop 3");
  var_a6e2d2850ed0fc33 = var_a6faa64bf8570cef scene::get_entity("Prop 4");
  var_a6e2d1850ed0fa00 = var_a6faa64bf8570cef scene::get_entity("Prop 5");
  array = [var_a6e2d5850ed102cc, var_a6e2d8850ed10965, var_a6e2d7850ed10732, var_a6e2d2850ed0fc33, var_a6e2d1850ed0fa00];

  if(!isDefined(level.ally1)) {
    iprintlnbold("<dev string:x36>");
  }

  if(!isDefined(level.ally2)) {
    iprintlnbold("<dev string:x47>");
  }

  thread function_8b09f4e11779ca18(0);
  animnode thread scene::play(character_array, "shot_010");
  gun = spawn("script_model", level.player.origin);
  gun setModel("misc_wm_grappling_gun_v0");
  waitframe();
  flag_set("flag_scuba_path");
  animnode scene::stop();
  thread scripts\sp\maps\sp_jup_vip\sp_jup_vip_lighting::function_361103be5fb28520();
  thread function_ec9ece71a79e97b0();
  var_d683d17bf2124d5e = ["shot_010"];
  thread function_5c55148c6770a5e9();
  waitframe();
  flag_wait("lgt_emerge_v2_swim_end");
  thread function_b2c23647d71787b();
  thread function_5fa1163ea2815b93();
  flag_set("pushthroughkelp_flag");

  if(flag("flag_skipped_intro")) {
    level thread scripts\sp\maps\sp_jup_vip\sp_jup_vip_lighting::function_9a73cff3a0f6f2c5(1);
  }

  flag_set("introscreen_start_wait");
  wait 4.75;
  var_d683d17bf2124d5e = ["shot_020"];
  start_fraction = 0.209821;
  var_a6faa64bf8570cef thread function_57ac36ea7abb5af4(undefined, character_array, var_d683d17bf2124d5e, start_fraction);
  thread function_f0130740538b7590();
  waitframe();
  level.player fade_in(1, "black");
  var_a6faa64bf8570cef waittill("scene_complete");
  flag_set("flag_start_wall_ascend");
  level.player freezecontrols(0);
  level.player player::focusenable();
  function_1ae8f046dee579e0(0);
  setsaveddvar(@ "hash_fa84e9dc55b9d406", 1);

  if(isDefined(level.glowsticks)) {
    foreach(stick in level.glowsticks) {
      if(isDefined(stick)) {
        stick show();
        waitframe();
        stick delete();
      }
    }
  }

  foreach(stick in array) {
    if(isDefined(stick)) {
      stick show();
      waitframe();
      stick delete();
    }
  }
}

function function_b2c23647d71787b() {
  if(!isDefined(level.ally1)) {
    iprintlnbold("<dev string:x36>");
  }

  if(!isDefined(level.ally2)) {
    iprintlnbold("<dev string:x47>");
  }

  level.ally1 waittill("notify_switch_wall_idle");
  thread function_4f1b7657a4c9d1e();
  character_array = [level.ally1, level.ally2];
  shot_array = ["shot_010"];
  animnode = getStruct("scene_vip_0300_wallascend_infil", "targetname");
  animnode thread scene::play(character_array, shot_array);
}

function function_5fa1163ea2815b93() {
  if(!isDefined(level.ally2)) {
    iprintlnbold("<dev string:x47>");
  }

  level.ally2 waittill("notify_player_breached_surface");
  thread namespace_165c742e346e899e::function_96cc4e998f08aca5();
}

function function_8534f1015a66ec6() {
  println("<dev string:x58>");

  while(true) {
    waterheight = getwaterheightatlocation(level.player.origin);

    if(isDefined(waterheight)) {
      var_7601b59440541c5f = (level.player.origin[0], level.player.origin[1], waterheight);
      println("<dev string:x79>" + level.player.origin + "<dev string:x8b>" + waterheight);
    } else {
      println("<dev string:x79>" + level.player.origin);
    }

    waitframe();
  }
}

function function_ec9ece71a79e97b0() {
  level.player endon("death");
  function_3ededc5fdbcba820();
  flag_wait("lgt_emerge_end");

  var_41d4ecb14a6d8d2f = spawn_tag_origin(level.player.origin, level.player.angles);
  level.player playerlinkTo(var_41d4ecb14a6d8d2f);

  while(true) {
    waterheightz = getwaterheightatlocation(level.player.origin);

    if(isDefined(waterheightz)) {
      zdiff = var_41d4ecb14a6d8d2f.origin[2] - waterheightz;

      if(var_41d4ecb14a6d8d2f.origin[2] > waterheightz) {
        error("lerpPlayerToAboveWater() Scuba De-Gear animation - transition fix may not work please report to Gameplay team!");
      }

      if(abs(zdiff) > 49) {
        level.player unlink();
        return;
      }

      var_41d4ecb14a6d8d2f.origin = (var_41d4ecb14a6d8d2f.origin[0], var_41d4ecb14a6d8d2f.origin[1], var_41d4ecb14a6d8d2f.origin[2] - 1);
    }

    waitframe();
  }
}

function function_3ededc5fdbcba820() {
  level.var_167611e6bdcf818d = getdvarint(@ "hash_25fd1d18d38c336a");
  setsaveddvar(@ "hash_25fd1d18d38c336a", 20);
  level.var_c6eed567148e0ee8 = getdvarint(@ "hash_863a2044d629615");
  setsaveddvar(@ "hash_863a2044d629615", 58);
  level.var_744ae38c66429ebe = getdvarint(@ "hash_26a4610780ec66f6");
  setsaveddvar(@ "hash_26a4610780ec66f6", 1);
  level.var_add8087225735c9b = getdvarint(@ "hash_c6d1dde462e39873");
  setsaveddvar(@ "hash_c6d1dde462e39873", 1);
  thread function_7d10e386d9539d95();
}

function function_7d10e386d9539d95() {
  flag_wait("flag_wait_attach");
  setsaveddvar(@ "hash_25fd1d18d38c336a", level.var_167611e6bdcf818d);
  setsaveddvar(@ "hash_863a2044d629615", level.var_c6eed567148e0ee8);
  setsaveddvar(@ "hash_26a4610780ec66f6", level.var_744ae38c66429ebe);
  setsaveddvar(@ "hash_c6d1dde462e39873", level.var_add8087225735c9b);
}

function function_f104d3f59e3fdd6() {
  gulag_spotlights = getStructArray("gulag_spotlights", "targetname");

  foreach(spotlight in gulag_spotlights) {
    spotlight thread function_61b55cdcabab7c9f();
  }
}

function function_871fc21b56c849b5() {
  var_cc20bb0a8d2ae3b5 = getEntArray("static_infil_grapple", "targetname");

  foreach(rope in var_cc20bb0a8d2ae3b5) {
    if(isDefined(rope)) {
      rope hide();
    }
  }

  flag_wait("flag_wall_ascend_shoot_gun_2");

  foreach(rope in var_cc20bb0a8d2ae3b5) {
    if(isDefined(rope)) {
      rope show();
    }
  }

  flag_wait("flag_obj_infil__pipe_room_complete");

  foreach(rope in var_cc20bb0a8d2ae3b5) {
    if(isDefined(rope)) {
      rope delete();
    }
  }
}

function function_61b55cdcabab7c9f() {
  level endon("flag_player_in_piperoom");
  spotlight_tag = spawn_tag_origin(self.origin, self.angles);
  waitframe();
  playFXOnTag(getfx("vfx_vip_light_searchlight_ocean_01"), spotlight_tag, "tag_origin");
  wait 1;
  spotlight_tag rotateby((0, 120, 0), 10, 3, 3);
  flag_wait("scuba_underwater");
  killfxontag(getfx("vfx_vip_light_searchlight_ocean_01"), spotlight_tag, "tag_origin");
  flag_wait("netcut_success");
  playFXOnTag(getfx("vfx_vip_light_searchlight_ocean_01"), spotlight_tag, "tag_origin");

  while(true) {
    spotlight_tag rotateby((0, 120, 0), 10, 3, 3);
    wait 11;
    spotlight_tag rotateby((0, -120, 0), 10, 3, 3);
    wait 11;
  }

  flag_wait("flag_player_over_wall");

  if(self.script_noteworthy == "gulag_spotlight_turn_off") {
    killfxontag(getfx("vfx_vip_light_searchlight_ocean_01"), spotlight_tag, "tag_origin");
  }

  fx_to_delete = getent_or_struct("fx_to_delete", "targetname");
  fx_to_delete delete();
}

function function_87a9b4cdc02935a4() {}

function function_4a5007e839e4aed4() {
  level.player fade_out(0, "black");
  level.player player::focusdisable();
  function_1ae8f046dee579e0(1);
  thread scripts\sp\maps\sp_jup_vip\sp_jup_vip_lighting::cp_scuba();
  thread function_e39d8a96b86719ce(1);
  thread function_871fc21b56c849b5();
  set_start_location("scuba", [level.player]);
  spawn_allies();
  thread function_5ab38289fd2ee60a();
  flag_set("flag_skipped_intro");
  flag_set("cine_intro_end");
}

function function_63309bd4e738c785() {
  trigger_off("out_of_bounds", "targetname");
  trigger_off("kill_volume", "targetname");
  level thread function_18cb72f43f56aa7c();
  thread function_c2f36ea9f72514f0();
  thread function_6f65ebd58d8e0010();
  thread function_1ef6967993effd57();
  thread function_a2a1414e250d9f13();
  thread function_3c253b47edbac811();
}

function function_e4045a2c8864391a() {
  flag_set("flag_scuba_end");
  flag_set("flag_start_wall_ascend");
  flag_set("player_scuba_start");
  flag_set("flag_obj_get_to_gulag_net_cut");
  flag_set("netcut_success");
  flag_set("hatch_prompt");
  flag_set("flag_start_hatch_opening");
  flag_set("pushthroughkelp_flag");
  flag_set("vip_fov_scuba_gameplay_start");
  flag_set("vip_fov_scuba_gameplay_end");
}

function function_3c253b47edbac811() {
  character_array = [level.ally1, level.ally2];

  if(!isDefined(level.ally1)) {
    iprintlnbold("<dev string:x36>");
  }

  if(!isDefined(level.ally2)) {
    iprintlnbold("<dev string:x47>");
  }

  flag_wait("player_scuba_start");
  wait 1;
}

function function_2ab4c1d1448d35d2() {
  if(self == level.player) {
    playFXOnTag(getfx("vfx_vip_glowstick_glow_red"), self, "j_gun");
    flag_wait("flag_start_wall_ascend");
    wait 1;
    killfxontag(getfx("vfx_vip_glowstick_glow_red"), self, "j_gun");
    return;
  }

  if(self == level.ally1) {
    playFXOnTag(getfx("vfx_vip_glowstick_glow_red"), self, "j_hipholster_le");
    flag_wait("flag_start_wall_ascend");
    killfxontag(getfx("vfx_vip_glowstick_glow_red"), self, "j_hipholster_le");
    return;
  }

  playFXOnTag(getfx("vfx_vip_glowstick_glow_red"), self, "j_hipholster_le");
  flag_wait("flag_start_wall_ascend");
  wait 0.5;
  killfxontag(getfx("vfx_vip_glowstick_glow_red"), self, "j_hipholster_le");
}

function function_c2f36ea9f72514f0() {
  var_e86b26000c0fb341 = getStruct("scene_vip_0230_scuba_debris_v2", "targetname");
  var_e86b26000c0fb341 scene::function_8207074e79f22926(level.player, "notify_level_slowmotion", "Player");
  var_e86b26000c0fb341 scene::function_8207074e79f22926(level.player, "notify_switch_to_land", "Player");
  flag_init("scubastart_flag1");
  flag_init("scubastart_flag3");
  flag_init("flag_light_past_1");
  flag_init("flag_light_past_2");
  rain = snd_play("temp_quad_city_ext_rain_lp", level.player);
  function_e70d88e85d5fb19a(rain, 3, 0);
  flag_set("flag_obj_get_to_gulag_activate");
  snd_stop(rain, 2.5);
  flag_set("scubastart_flag1");
  flag_set("scubastart_flag3");
  waitframe();
  thread function_ae27179cfeed7c4b();
  flag_set("player_scuba_start");
  scripts\sp\maps\sp_jup_vip\sp_jup_vip_lighting::function_73dfa61909504f41();
  thread autosave_by_name("diving");
  flag_wait("flag_scuba1");
  thread autosave_by_name("Begin Scuba");
  flag_set("flag_light_past_1");
  flag_set("flag_light_past_2");
  flag_wait("flag_scuba_path");
  flag_set("flag_scuba_end");
  level.player take_weapon(level.startweapon);
  level.player take_melee_weapon();
  flag_wait("pushthroughkelp_flag");
  thread autosave_by_name("Ready to rappel");
}

function function_a2a1414e250d9f13() {
  setDvar(@ "hash_42deeb1fb385c72", 0);
  level.var_e08155a589fd83f5 = &function_a321dae0bbf65610;
  level.player enableplayerbreathsystem(0);
  level.player enableoffhandweapons(0);
  level.player enableoffhandprimaryweapons(0);
  level.player enableoffhandsecondaryweapons(0);
  level.player enableslowaim(0.25, 0.1);
  level.player function_8b7829a01e6b58aa(0);
  level.player val::set("vip_infil", "melee", 0);
  level.player val::set("vip_infil", "mantle", 0);
  level.player val::set("vip_infil", "nvg", 0);
  flag_wait("pushthroughkelp_flag");
  level.player function_8b7829a01e6b58aa(1);
  level.player disableslowaim();
  level.player val::set("vip_infil", "nvg", 0);
  level.player take_weapon(level.startweapon);
  level.player take_melee_weapon();
}

function function_a321dae0bbf65610() {
  return false;
}

function function_ae27179cfeed7c4b() {
  wait 1.5;
  flag_set("player_scuba_start");
  wait 0.2;
}

function function_6f65ebd58d8e0010() {
  var_4880f1320be4987d = getEntArray("amb_model", "targetname");

  foreach(var_4a149d80c55d2afc in var_4880f1320be4987d) {
    var_4a149d80c55d2afc thread function_df3d62af98610288();
  }
}

function function_df3d62af98610288(animation) {
  self endon("death");

  if(isDefined(self.script_hidden)) {
    self hide();
  }

  if(isDefined(self.script_flag_wait)) {
    flag_wait(self.script_flag_wait);
  }

  if(isDefined(self.script_hidden)) {
    self show();
  }

  goal = undefined;

  if(isDefined(self.target)) {
    goal = getStruct(self.target, "targetname");
  }

  if(isDefined(goal)) {
    if(isDefined(self.script_float)) {
      self moveTo(goal.origin, self.script_float);
      self rotateTo(goal.angles, self.script_float);
      wait self.script_float;
    } else {
      self moveTo(goal.origin, 3);
      self rotateTo(goal.angles, 3);
      wait 1;
    }

    if(isDefined(goal.script_wait)) {
      wait goal.script_wait;
    }

    if(isDefined(goal.script_flag)) {
      flag_set(goal.script_flag);
    }

    if(istrue(goal.script_delete)) {
      self delete();
      return;
    }
  } else {
    return;
  }

  if(istrue(self.script_delete)) {
    self delete();
    return;
  }

  if(isDefined(goal.target)) {
    currentnode = goal;
    newgoal = getStruct(currentnode.target, "targetname");

    while(isDefined(newgoal)) {
      if(isDefined(newgoal.script_flag_wait)) {
        flag_wait(newgoal.script_flag_wait);
      }

      if(isDefined(currentnode.script_float)) {
        self moveTo(newgoal.origin, currentnode.script_float);
        self rotateTo(newgoal.angles, currentnode.script_float);
        wait currentnode.script_float;
      } else {
        self moveTo(newgoal.origin, 1);
        self rotateTo(newgoal.angles, 1);
        wait 1;
      }

      if(isDefined(currentnode.script_wait)) {
        wait currentnode.script_wait;
      }

      if(isDefined(newgoal.script_flag)) {
        flag_set(newgoal.script_flag);
      }

      if(istrue(newgoal.script_delete)) {
        self delete();
        return;
      }

      if(isDefined(newgoal.target)) {
        newgoal = getStruct(newgoal.target, "targetname");
      } else {
        newgoal = undefined;
      }

      waitframe();
    }
  }
}

function function_efbac668dca48fa6() {}

function function_65a5cbf78d6b21f2() {
  thread scripts\sp\maps\sp_jup_vip\sp_jup_vip_lighting::cp_wall();
  thread function_e39d8a96b86719ce(1);
  set_start_location("wall", [level.player]);
}

function function_4d72aea895f54ad4() {
  flag_wait("flag_fx_lightning_01");
  thread fx_lightning_01();
}

function function_bedfa3bff2319b7f() {
  level.connection_interact = getStruct("rappel_anchor", "targetname");
  level.connection_interact endon("trigger");
  wait 2;
  level.ally1 thread say("dx_sp_jvip_wasc_koa1_hooksup");
  wait 10;
  variation = 0;

  while(true) {
    if(variation == 0) {
      level.ally1 say("dx_sp_jvip_wabn_koa1_launchhooks");
    } else if(variation == 1) {
      level.ally1 say("dx_sp_jvip_wasn_koa1_onyou21firehooks");
    } else if(variation == 2) {
      level.ally1 say("dx_sp_jvip_wasn_koa1_sendhooks21");
    } else {
      level.ally1 say("dx_sp_jvip_wasn_koa1_21shoothooks");
    }

    variation++;

    if(variation > 3) {
      variation = 0;
    }

    wait 10;
  }
}

function function_5e51a1e92cc1c4de() {
  var_2e2e1ffa730e3db3 = getStruct("start_rappel_interact", "targetname");
  var_2e2e1ffa730e3db3 endon("trigger");
  wait 2;
  level.ally1 thread say("dx_sp_jvip_wlap_koa1_onme");
  wait 4;
  level.ally1 say("dx_sp_jvip_wabn_koa1_letsgetupthere");
  wait 10;
  variation = 0;

  while(true) {
    if(variation == 0) {
      level.ally1 say("dx_sp_jvip_wabn_koa1_takeposition21");
    } else if(variation == 1) {
      level.ally1 say("dx_sp_jvip_wabn_koa1_onthewall21");
    } else {
      level.ally1 say("dx_sp_jvip_wabn_koa1_21movein");
    }

    variation++;

    if(variation > 2) {
      variation = 0;
    }

    wait 10;
  }
}

function function_e277f03964910976() {
  flag_wait("flag_start_wall_ascend");
  thread function_5e51a1e92cc1c4de();
  flag_wait("vo_player_raised_line_launcher");
  thread function_bedfa3bff2319b7f();
  flag_wait("vo_player_shot_line");
  thread wall_music();
  wait 4.6;
  level.player say("dx_sp_jvip_wasc_koa2_goodhookletsgetuptop");
}

function wall_music() {
  setmusicstate("mx_vip_wall");
}

function function_d9013be857e37ea3() {
  ally_1 = getEnt("ally_01", "targetname");
  ally_2 = getEnt("ally_03", "targetname");
  ally_1 hide();
  ally_2 hide();
  thread function_e277f03964910976();
  animnode = getStruct("scene_vip_0300_wallascend_infil", "targetname");
  level.player val::set("vip_infil", "melee", 0);
  level.player val::set("vip_infil", "dtp", 0);
  level.player val::set("vip_infil", "swimming_underwater", 0);
  level.player val::set("vip_infil", "allow_jump", 0);
  level.player val::set("vip_infil", "ads", 0);
  level.player val::set("vip_infil", "mantle", 0);

  if(!isDefined(level.ally1)) {
    spawn_allies();
    thread function_4f1b7657a4c9d1e();
    character_array = [level.ally1, level.ally2];
    shot_array = ["shot_010"];
    animnode thread scene::play(character_array, shot_array);
  }

  level.ai_grapple = make_weapon("jup_ar_mike4_sp_grappling_gun");
  level.ally1 scripts\anim\shared::forceuseweapon(level.ai_grapple, "primary");
  level.ally2 scripts\anim\shared::forceuseweapon(level.ai_grapple, "primary");
  flag_wait("flag_start_wall_ascend");
  utility::disable_trigger_with_targetname("killvolume_infil_01");
  utility::disable_trigger_with_targetname("killvolume_infil_02");
  trigger_on("out_of_bounds", "targetname");
  trigger_on("kill_volume", "targetname");
  thread scripts\sp\player::disable_player_weapon_info();
  thread scripts\sp\maps\sp_jup_vip\sp_jup_vip_lighting::function_bddf445e41d4f976();
  thread autosave_by_name("reached_wall");
  thread function_509115a6d7f4e772();
  level.player scripts\engine\sp\utility::function_6078d3c20d55c620();
  gunlessweapon = make_weapon("iw9_gunless");
  level.player give_weapon(gunlessweapon);
  level.player switchtoweaponimmediate(gunlessweapon);
  level.player function_9354c4c50c43abc0(0.7);
  rappel_interact = getStruct("start_rappel_interact", "targetname");
  rappel_interact create_cursor_hint(undefined, (0, 0, 0), &"SP_JUP_VIP/INTERACT_BRACE", 90, 800, 60, 1, undefined, 0);
  rappel_interact waittill("trigger");
  setsaveddvar(@ "hash_fa84e9dc55b9d406", 0);
  level.player val::set("vip_infil", "allow_movement", 0);
  level.player function_5ee68a5b461ab5b8(1);
  wait 0.1;

  while(level.player isgestureplaying("ges_equip_nvg_puton") || level.player isgestureplaying("ges_equip_nvg_puton_pistol")) {
    wait 0.1;
  }

  if(level.player isnightvisionon()) {
    level.player forceplaygestureviewmodel("ges_equip_nvg_takeoff_pistol");
    wait 0.2;

    while(level.player isgestureplaying("ges_equip_nvg_takeoff_pistol")) {
      wait 0.1;
    }
  }

  flag_set("flag_vip_wall_player_grabbed_brace");
  thread namespace_165c742e346e899e::function_5ec1f44b04115fd7();
  level.player enableslowaim(0, 0);
  level notify("start_rappel_dof");
  character_array = [level.ally1, level.ally2];
  shot_array = ["shot_020"];
  animnode scene::play(character_array, shot_array);
  level.player function_5ee68a5b461ab5b8(0);
  level.player val::set("vip_infil", "nvg", -1);
  level.player val::set("vip_infil", "allow_movement", 0);
  level.player unlink();
  waitframe();
  shot_link = spawn_tag_origin(rappel_interact.origin + (0, -20, 0), level.player getplayerangles());
  level.player enableslowaim(0.1, 0.1);
  var_4ecb5fe54eeb05ef = 25;
  var_9366824b3b7badf4 = 25;
  var_325d1535876a1326 = 7.5;
  var_7c2e7c229980e9ea = 0;
  level.player lerpfovscalefactor(0, 2.5);
  level.player playerlinktodelta(shot_link, "tag_origin", 1, var_4ecb5fe54eeb05ef, var_9366824b3b7badf4, var_325d1535876a1326, var_7c2e7c229980e9ea, 0, 1, 0, 1, 0.7, 0.2, 1);
  flag_set("vo_player_raised_line_launcher");
  thread namespace_165c742e346e899e::function_853e7e2a9a736f5();
  level.player take_weapon(gunlessweapon);
  level.player give_weapon(level.var_2d3ac368e2984df7);
  level.player val::set("vip_infil", "ads", 0);
  thread scripts\sp\player::disable_player_weapon_info();
  level.player switchtoweaponimmediate(level.var_2d3ac368e2984df7);
  level.player setweaponammoclip(level.var_2d3ac368e2984df7, 1);
  level.player setweaponammostock(level.var_2d3ac368e2984df7, 0);
  level.player val::set("vip_infil", "fire", 0);
  level.player player_recoilscaleon(255);
  level thread function_29b6cd032d120925();
  thread function_4d72aea895f54ad4();
  flag_set_delayed("flag_player_raised_line_launcher", 1);
  flag_wait("flag_wait_attach");
  level.player function_5ee68a5b461ab5b8(1);
  level.player unlink();
  thread namespace_165c742e346e899e::function_2695736be1020d66();
  level.enemy_top_wall = utility::spawn_targetname("enemy_top_wall", 1);
  level.enemy_top_wall context_melee_allow(0);
  level.enemy_top_wall visiblenotsolid();
  character_array = [level.ally1, level.ally2, level.enemy_top_wall];
  shot_array = ["shot_030"];
  level.player player::focusdisable();
  function_1ae8f046dee579e0(1);
  var_e63bd682741ed0 = animnode;
  animnode thread function_57ac36ea7abb5af4(undefined, character_array, shot_array);
  var_e63bd682741ed0 thread function_57ac36ea7abb5af4(undefined, character_array, "shot_030_player");
  thread function_9196cb662717ed67();
  thread function_e5c6c0fef85baaa8();
  flag_set("vo_player_shot_line");
  level.player val::set("vip_infil", "fire", 0);
  thread function_42d2c4a4c83d8207();
  flag_wait("flag_wall_drop_grapplegun");
  gunlessweapon = make_weapon("iw9_gunless");
  thread namespace_165c742e346e899e::ascend();
  level.player give_weapon(gunlessweapon);
  level.player switchtoweapon(gunlessweapon);
  wait 1;
  level.player take_weapon(level.var_2d3ac368e2984df7);
  level.player player_recoilscaleon(45);
  pistol = make_weapon("iw9_pi_golf17", ["silencer01_pi"]);
  level.ally1 scripts\anim\shared::forceuseweapon(pistol, "primary");
  level.ally2 scripts\anim\shared::forceuseweapon(gunlessweapon, "primary");
  thread scripts\sp\maps\sp_jup_vip\sp_jup_vip_lighting::function_76a901b98ffd8919();
  thread scripts\sp\maps\sp_jup_vip\sp_jup_vip_lighting::function_996c7c0ab957b783();
  flag_wait("flag_wall_ascend_hide_ascender");
  var_fa3cbb5b6c14860c = animnode scene::get_entity("Prop 3");
  var_5fdb1d716743eacb = utility::spawn_model("misc_wm_ascender", var_fa3cbb5b6c14860c.origin, var_fa3cbb5b6c14860c.angles);
  waitframe();
  var_fa3cbb5b6c14860c hide();
  flag_wait("flag_wall_ascend_shoot_gun");
  level.player lerpfovscalefactor(1, 2.5);
  level.ally1 shoot();
  thread namespace_165c742e346e899e::function_ea6067a2ca8fb1ff();
  flag_wait("flag_wall_ascend_attatch_rifles");
  level.ally1 scripts\anim\shared::forceuseweapon(level.var_be6774d0f9d79daf, "primary");
  level.ally2 scripts\anim\shared::forceuseweapon(level.var_be6774d0f9d79daf, "primary");
  level.ally1.sidearm = nullweapon();
  flag_wait("flag_wall_ascend_shoot_gun_2");
  level.ally1 shoot();
  var_5fdb1d716743eacb delete();
  level.player val::set("vip_infil", "crouch", 0);
  level.player val::set("vip_infil", "prone", 0);
  flag_wait("flag_wall_end");
  wait 1;
  setsaveddvar(@ "hash_e3b392663b07939c", 0);
  thread function_e39d8a96b86719ce(0);
  level.player take_weapon(gunlessweapon);
  level.player give_weapon(level.startweapon);
  level.player give_weapon(level.smg);
  level.player give_offhand("semtex");
  level.player give_offhand("smoke");
  level.player switchtoweaponimmediate(level.startweapon);
  thread scripts\sp\player::allow_player_weapon_info(1);
  level.player givemaxammo(level.startweapon);
  level.player givemaxammo(level.smg);
  var_e63bd682741ed0 waittill_any_timeout(2, "scene_complete");
  level.player disableslowaim();
  level.player enableoffhandprimaryweapons(1);
  level.player enableoffhandsecondaryweapons(1);
  level.player val::reset_all("vip_infil");
  level.player function_5ee68a5b461ab5b8(0);
  level.player player::focusenable();
  function_1ae8f046dee579e0(0);
  setsaveddvar(@ "hash_fa84e9dc55b9d406", 1);
  flag_set("flag_obj_get_to_gulag_complete");
  animnode thread function_e2898202e5675001();
}

function function_42d2c4a4c83d8207() {
  wait 0.1;

  while(level.player isgestureplaying("ges_equip_nvg_puton")) {
    wait 0.1;
  }

  if(level.player isnightvisionon()) {
    level.player forceplaygestureviewmodel("ges_equip_nvg_takeoff");
  }
}

function function_e2898202e5675001() {
  self waittill("scene_complete");
  waitframe();
  function_52b5aaee35540c0b(1);
}

function function_9196cb662717ed67() {
  level.player enableslowaim(0, 0);
  wait 3;
  level.player enableslowaim(0.1, 0.1);
  wait 1;
  pitch = 0.1;
  yaw = 0.1;
  pitch_inc = (0.33 - pitch) / 60;
  yaw_inc = (0.33 - yaw) / 60;

  while(pitch < 0.33 && yaw < 0.33) {
    level.player enableslowaim(pitch, yaw);
    pitch += pitch_inc;
    yaw += yaw_inc;
    waitframe();
  }
}

function function_e5c6c0fef85baaa8() {
  flag_wait("flag_enemy_top_wall_last_frame");
  level.enemy_top_wall.skipdeathanim = 1;
  level.enemy_top_wall.noragdoll = 1;
  level.enemy_top_wall.diequietly = 1;
  waitframe();
  level.enemy_top_wall kill();
}

function fx_lightning_01() {
  exploder("wall_lightning_01");
}

function function_f8e1b4fc7ed86dd0() {
  wait 3;
  exploder("wall_wind_01");
}

function function_90624d43f9fdb0d8() {
  flag_set("flag_start_wall_ascend");
  flag_set("flag_vip_wall_player_grabbed_brace");
  flag_set("flag_obj_get_to_gulag_complete");
  thread namespace_165c742e346e899e::function_ea293b64d8fecd6d();
  clearmusicstate();
  setmusicstate("mx_vip_wall");
}

function function_18260f3a76fe4289() {
  level.player endon("end_rappel");
  level.player waittill("player_on_wall");

  while(true) {
    struct = getStruct(self.target, "targetname");
    distance_value = distance(self.origin, struct.origin);
    time = distance_value / 80;
    self moveTo(struct.origin, time, 0.5, 0.5);
    wait time;

    if(isDefined(struct.script_noteworthy)) {
      if(struct.script_noteworthy == "flag_top_of_wall") {
        level.player waittill("player_disconnect");
        self hide();
        waitframe();
        level.player notify("end_rappel");
        break;
      } else {
        flag_wait(struct.script_noteworthy);
      }
    }

    self.target = struct.target;
  }
}

function function_79109c70b90b0a26() {
  flag_wait("flag_wait_lights_out");
  wait 2;
  thread temp_dialogue("PMC 1", "Get up that wall.", 2);
  flag_wait("flag_chopper_incoming");
  thread temp_dialogue("PMC 1", "Heli patrol, hug that wall and blend.", 2);
  wait 2;

  iprintlnbold("<dev string:x96>");
}

function function_29b6cd032d120925() {
  level.player thread function_2ff829ac71af5e1f();
  struct = getStruct("rappel_interact", "targetname");
  struct create_cursor_hint(undefined, (0, 0, 6), &"SP_JUP_VIP/INTERACT_RAPPEL");
  struct waittill("trigger");
}

function function_409f8618118b58d2(laser_group) {
  foreach(laser in laser_group) {
    script_origin = spawn_script_origin(laser.origin, laser.angles);
    script_origin thread function_14d1b3c1fc80c027(self);
    script_origin linkTo(self);
  }
}

function function_587d14c181e07bce() {
  struct = spawn_script_origin(self.origin, (0, 0, 0));
  view_range = getEnt("camera_view_1", "targetname");
  view_range linkTo(self);
  waitframe();
  self linkTo(struct);
  self.health = 1;
  self setCanDamage(1);
  self waittill("damage");
  self notify("destroyed");
  struct notify("destroyed");
  view_range hide();
  self hide();
  flag_set("flag_camera_1_destroyed");
}

function function_587d13c181e0799b() {
  struct = spawn_script_origin(self.origin, (0, 0, 0));
  view_range = getEnt("camera_view_2", "targetname");
  view_range linkTo(self);
  waitframe();
  self linkTo(struct);
  waitframe();
  struct thread camera_rotation(1);
  self.health = 1;
  self setCanDamage(1);
  self waittill("damage");
  self notify("destroyed");
  struct notify("destroyed");
  view_range hide();
  self hide();
  flag_set("flag_camera_2_destroyed");
}

function function_511781114d769f73() {
  struct = spawn_script_origin(self.origin, (0, 0, 0));
  self linkTo(struct);
  self.health = 1;
  self setCanDamage(1);
  self waittill("damage");
  self notify("destroyed");
  struct notify("destroyed");
  self hide();
}

function camera_rotation(invert_rotation) {
  self endon("destroyed");
  rotation_controller = spawn_script_origin(self.origin, self.angles);
  self linkTo(rotation_controller);
  min_rotation = self.angles - (0, 85, 0);
  max_rotation = self.angles + (0, 85, 0);

  while(true) {
    if(!invert_rotation) {
      rotation_controller rotateTo(min_rotation, 6, 1, 1);
      wait 6;
      rotation_controller rotateTo(max_rotation, 6, 1, 1);
      wait 6;
      continue;
    }

    if(invert_rotation) {
      rotation_controller rotateTo(max_rotation, 6, 1, 1);
      wait 6;
      rotation_controller rotateTo(min_rotation, 6, 1, 1);
      wait 6;
    }
  }
}