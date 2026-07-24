/*******************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\titan\titan_hot_landing.gsc
*******************************************************/

_id_11A5A() {
  scripts\engine\utility::flag_set("tower_destruction_vision_fx");
  var_0 = _id_0BDC::_id_1079F("player_rooftop_jackal", "hot_landing_jackal");
  _id_0BDC::_id_10CD1(var_0);
  scripts\sp\maps\titanjackal\titanjackal_code::_id_10732();
  level._id_EAD6 _id_1162E();
  wait 0.3;
  scripts\engine\utility::flag_set_delayed("flag_pipeline_exploded", 2);
}

_id_1162E() {
  var_0 = level._id_D127.angles;
  var_1 = level._id_D127.origin;
  var_2 = anglesToForward(var_0) * -1000;
  var_3 = anglestoright(var_0) * 0;
  var_4 = anglestoup(var_0) * 300;
  self vehicle_teleport(var_1 + var_2 + var_3 + var_4, var_0);
}

_id_11A58() {
  scripts\engine\utility::flag_set("tower_destruction_vision_fx");
  thread _id_F542();
  thread _id_1351B();
  var_0 = scripts\engine\utility::getStruct("tower_explosions", "targetname");

  while(!level._id_D127 _id_0BDC::_id_9B92(var_0, 80000) || !level._id_D127 _id_0BDC::_id_9C87(var_0, 0.35))
    wait 0.25;

  level notify("player_sees_tower");
  scripts\sp\maps\titanjackal\titanjackal_code::_id_EAB8("titan_slt_letslightthiscandle");
  wait 3;
  scripts\sp\utility::_id_56BE("destroy_refinery_pipes", 5);
  var_1 = getEntArray("tower_destruction_object", "targetname");

  foreach(var_3 in var_1) {
    var_3 setCanDamage(1);
    var_3.health = 10;
    var_3 scripts\sp\utility::_id_9196(1, 1, 1);
    var_3 thread _id_B9AB();
  }

  thread _id_F56E(var_1);
  scripts\engine\utility::flag_wait("flag_tower_triggered");
  level._id_EAD6 notify("salter_tower_idle_position");
  _id_0BDC::_id_A161();

  foreach(var_3 in var_1) {
    var_3 setCanDamage(0);
    var_3 scripts\sp\utility::_id_9193();
  }

  level._id_D127 _id_0BDC::_id_137F6(var_0, 0.6, 5, 0.05);
  thread _id_11A57();
  scripts\engine\utility::delaythread(8, ::post_tower_destruction_vo);
  scripts\engine\utility::delaythread(19, ::_id_AA5A);
  wait 19;
  setmusicstate("mx_011_towerexplosion");
  wait 2;
  scripts\sp\maps\titanjackal\titanjackal_code::_id_7707("titan_nav_thatsquiteaflare");
  scripts\sp\maps\titanjackal\titanjackal_code::_id_D1D5("titan_plr_goodtoseeyou");
  scripts\sp\maps\titanjackal\titanjackal_code::_id_EAB8("titan_slt_wethoughtyouwere");
  scripts\sp\maps\titanjackal\titanjackal_code::_id_7707("titan_nav_ithoughtiwas");
  scripts\sp\maps\titanjackal\titanjackal_code::_id_D1D5("titan_plr_wellletsget");
  scripts\sp\maps\titanjackal\titanjackal_code::_id_EAB8("titan_slt_goodtogoraider");
  scripts\sp\maps\titanjackal\titanjackal_code::_id_EAB8("titan_slt_makethecall");
  _id_241C();
  setsaveddvar("sm_sunsamplesizenear", 4.5);
  setsaveddvar("sm_sunCascadeSizeMultiplier1", 2);
}

post_tower_destruction_vo() {
  scripts\sp\maps\titanjackal\titanjackal_code::_id_D1D5("titan_plr_holyhell");
  scripts\sp\maps\titanjackal\titanjackal_code::_id_EAB8("titan_slt_isdcallthatdetonationconfirmed");
}

_id_F56E(var_0) {
  var_1 = scripts\engine\utility::spawn_tag_origin();
  var_1.origin = (0, 0, 0);
  var_2 = (0, 0, 0);

  foreach(var_4 in var_0)
  var_2 = var_2 + var_4.origin;

  var_1.origin = var_2 / var_0.size;
  target_set(var_1, (0, 0, 60));
  target_setshader(var_1, "apache_target_lock");
  target_setoffscreenshader(var_1, "hud_offscreenobjectivepointer");
  scripts\engine\utility::flag_wait("flag_tower_triggered");
  var_1 delete();
}

_id_B9AB() {
  self waittill("death");
  scripts\engine\utility::flag_set("flag_tower_triggered");
}

_id_AA5A() {
  var_0 = getEnt("return_retribution", "targetname");
  var_1 = getEnt("ally01_jackal_launch", "targetname");
  var_2 = getEnt("ally02_jackal_launch", "targetname");
  level._id_E35D = var_0 scripts\sp\vehicle::_id_1080B();
  level._id_E35D _id_0BB8::_id_39AE();
  level._id_E35D _id_0BB8::_id_39D0("idle");
  level._id_E35D scripts\engine\utility::delaythread(0, _id_0BB8::_id_39CD, "idle");
  thread _id_AA59();
  level._id_E35D scripts\engine\utility::delaythread(5, _id_0BB8::_id_39D0, "max", 0.25);
  level._id_E35D scripts\engine\utility::delaythread(11, _id_0BB8::_id_39D0, "idle", 0.2);
  level._id_E35D scripts\engine\utility::delaycall(2.0, ::playsound, "scn_titan_retribution_arena_flyin");
  level._id_E35D scripts\engine\utility::delaycall(4.5, ::playsound, "scn_titan_retribution_arena_ducking");
}

_id_AA59() {
  var_0 = getEnt("ally01_jackal_launch", "targetname");
  var_1 = getEnt("ally02_jackal_launch", "targetname");
  level._id_DE1C = var_0 scripts\sp\utility::_id_10808();
  level._id_DE1F = var_1 scripts\sp\utility::_id_10808();
  level._id_DE1C thread _id_DE27("ally01_jackal_takeoff_position", 1);
  level._id_DE1F thread _id_DE27("ally02_jackal_takeoff_position", 0);
}

_id_DE27(var_0, var_1) {
  level endon("stop_ally_offset_updates");
  wait(var_1);
  _id_0BDC::_id_19A0();
  var_2 = scripts\sp\utility::_id_7C9A(self.target);
  var_3 = getcsplinepointposition(var_2, 0);
  var_4 = getcsplinepointposition(var_2, 1);
  var_5 = vectortoangles(var_4 - var_3);
  self vehicle_teleport(var_3, var_5);
  self setneargoalnotifydist(4000);
  self _meth_8479(var_2);
  self _meth_847B(0.05, self.origin);
  _id_0BDC::_id_19AB(420, 220, 300, 300);
  self waittill("near_goal");
  _id_0BDC::_id_19B0("fly");
  _id_0BDC::_id_19AB(175, 220, undefined, 25);
  thread _id_0BDC::_id_A1F4(var_0, 1, 2100, 1);
  self waittill("near_goal");
  var_6 = scripts\engine\utility::getStruct(var_0, "targetname");
  _id_0BDC::_id_19B2("face angle", var_6.angles);
  _id_0BDC::_id_19B0("hover");
  _id_0BDC::_id_19AB(30, 250, 45, 15);
}

_id_AA58(var_0, var_1) {
  level endon("stop_ally_offset_updates");
  _id_0BDC::_id_19B0("fly");
  self waittill("near_goal");
  thread _id_0BDC::_id_A1EC(var_0.origin, 1, 9000);
  self waittill("near_goal");
  _id_0BDC::_id_19B0("hover");
  _id_0BDC::_id_19AB(75, 220, undefined, 25);
  thread _id_0BDC::_id_A1EC(var_0.origin, 1, 5500);
  self waittill("near_goal");
  _id_0BDC::_id_19B2("face angle", var_0.angles);
  _id_0BDC::_id_19AB(75, 160, undefined, 28);
  thread _id_0BDC::_id_A1EC(var_0.origin, 1, 2000);
  self waittill("near_goal");
  _id_0BDC::_id_19AB(50, 100, undefined, 45);
}

_id_AA5B() {
  level endon("stop_ally_offset_updates");
  level._id_EAD6 notify("stop_hovering_between_structs");
  level._id_EAD6 _id_0BDC::_id_1990(0);
  level._id_EAD6 _id_0BDC::_id_19A0();
  level._id_EAD6 _id_0BDC::_id_19B0("hover");
  level._id_EAD6 _id_0BDC::_id_19AB(175, 220, undefined, 25);
  level._id_EAD6 thread _id_0BDC::_id_A1F4("slater_jackal_takeoff_position", 1, 1500, 1);
  level._id_EAD6 waittill("near_goal");
  var_0 = scripts\engine\utility::getStruct("slater_jackal_takeoff_position", "targetname");
  level._id_EAD6 _id_0BDC::_id_19B2("face angle", var_0.angles);
  level._id_EAD6 _id_0BDC::_id_19AB(45, 90, 50, 25);
}

_id_AA53() {
  level endon("stop_ally_offset_updates");
  var_0 = spawnStruct();
  var_0.player = scripts\engine\utility::spawn_tag_origin();
  var_0._id_EA2C = scripts\engine\utility::spawn_tag_origin();
  var_0._id_DE1C = scripts\engine\utility::spawn_tag_origin();
  var_0._id_DE1F = scripts\engine\utility::spawn_tag_origin();
  var_1 = scripts\engine\utility::getStruct("player_jackal_takeoff_position", "targetname");
  var_2 = scripts\engine\utility::getStruct("slater_jackal_takeoff_position", "targetname");
  var_3 = scripts\engine\utility::getStruct("ally01_jackal_takeoff_position", "targetname");
  var_4 = scripts\engine\utility::getStruct("ally02_jackal_takeoff_position", "targetname");
  var_0.player.origin = var_1.origin;
  var_0.player.angles = var_1.angles;
  var_0._id_EA2C.origin = var_2.origin;
  var_0._id_EA2C.angles = var_2.angles;
  var_0._id_DE1C.origin = var_3.origin;
  var_0._id_DE1C.angles = var_3.angles;
  var_0._id_DE1F.origin = var_4.origin;
  var_0._id_DE1F.angles = var_3.angles;
  wait 0.05;
  var_0._id_EA2C linkTo(var_0.player);
  var_0._id_DE1C linkTo(var_0.player);
  var_0._id_DE1F linkTo(var_0.player);
  level._id_1D0E = var_0;

  for(;;) {
    level._id_1D0E.player.origin = level._id_D127.origin;
    wait 0.05;
  }
}

_id_AA52() {
  level notify("stop_ally_offset_updates");
  level._id_1D0E.player delete();
  level._id_1D0E._id_EA2C delete();
  level._id_1D0E._id_DE1C delete();
  level._id_1D0E._id_DE1F delete();
}

_id_F542() {
  thread _id_AA53();
  var_0 = getEnt("trigger_jackal_in_takeoff_position", "targetname");

  for(;;) {
    var_0 waittill("trigger", var_1);

    if(var_1 == level._id_D127) {
      break;
    }
  }

  scripts\engine\utility::flag_set("flag_player_ready_for_launch");
  scripts\sp\maps\titan\titan_jackal_arena_dogfight::_id_4051();
  thread _id_AA5B();
  _id_0BDC::_id_A155();
  _id_0BDC::_id_A1DD("hover");
  _id_0BDC::_id_D16C(scripts\engine\utility::getStruct("player_jackal_takeoff_position", "targetname"), 1, 0.0, 0);
  var_2 = 4000;

  while(distance(scripts\engine\utility::getStruct("player_jackal_takeoff_position", "targetname").origin, level._id_D127.origin) > var_2)
    wait 0.1;

  _id_0BDC::_id_A14A(1);
  _id_0BDC::_id_D16C(scripts\engine\utility::getStruct("player_jackal_takeoff_position", "targetname"), 0.5, 0, 1);
  scripts\engine\utility::flag_wait("flag_tower_triggered");
  _id_0BDC::_id_D165(scripts\engine\utility::getStruct("player_jackal_tower_lookat", "targetname"), 0.35, 0.5, 3);
}

_id_1351B() {
  level endon("player_sees_tower");
  wait 8;
  scripts\sp\maps\titanjackal\titanjackal_code::_id_134B7("titan_slt_reesecanyousee", 1);
}

_id_11A59() {
  visionsetnaked("titan_hotlanding_02", 0.1);
  getEnt("brushmodel_sky_blend", "targetname") show();
  scripts\engine\utility::exploder("hotlanding_planet");
  scripts\sp\utility::_id_10FEC("jackal_cloud_ceiling");
  scripts\engine\utility::exploder("hotlanding_planet_clouds");
  scripts\sp\utility::_id_10FEC("fx_sunflare");
}

_id_241C() {
  _id_3737();
  var_0 = _id_509A();
  _id_0BDC::_id_D165(level._id_E35D.origin, 1, 0, 2);

  while(!_id_0B76::_id_9C19(level._id_E35D))
    wait 0.1;

  _id_D23A();
  thread _id_AA6D();
  thread _id_AA6F();
  thread _id_AA6E();
  thread _id_D2D8();
  _id_D7D1();
  level._id_EAD6 notify("stop_hovering_between_structs");
  thread _id_AA4F(0.3, level._id_EAD6, 0.3, var_0, (1500, 1000, 650), (1350, 600, 450));
  thread _id_AA4F(0.2, level._id_DE1F, 0.1, var_0, (3500, 200, 1400), (5500, 200, 1400));
  thread _id_AA4F(0.4, level._id_DE1C, 0.7, var_0, (2800, -1100, 400), (2600, -1100, 600));
  thread _id_AA51(var_0);
  wait 2;
  thread _id_90B6();
  level._id_D127 thread _id_0BDB::_id_11479();
  _id_0BDB::_id_1147B(7);
  var_1 = 5;
  _id_0BDB::_id_CFE0(var_1);
  level notify("player_launch");
  scripts\sp\maps\titanjackal\titanjackal_arena_events::_id_A3A2();
  thread _id_AA97();
  launch_player();
  _id_AA52();
}

_id_D23A() {
  scripts\engine\utility::flag_set("flag_player_launched");
  var_0 = scripts\engine\utility::getStruct("player_jackal_takeoff_position", "targetname");

  while(distance(level._id_D127.origin, var_0.origin) > 512)
    scripts\engine\utility::waitframe();

  var_1 = scripts\engine\utility::getStruct("player_jackal_takeoff_position", "targetname");
  _id_0BDC::_id_D165(var_1.origin + anglesToForward(var_1.angles) * 1000, 1, 0, 2);
  wait 0.5;
  scripts\sp\utility::_id_56BA("launch_hint");

  while(!level.player useButtonPressed())
    wait 0.05;

  _id_F539();
  scripts\engine\utility::flag_clear("flag_player_launched");
}

#using_animtree("jackal");

_id_D2D8() {
  thread _id_0BDC::_id_A2B0(%jackal_pilot_launch_button, %jackal_vehicle_launch_button, 1.1, 0.5);
  wait 2.1;
  earthquake(0.25, 0.75, level._id_D127.origin, 5000);
  level.player playRumbleOnEntity("damage_light");
  thread _id_104EB();
  level._id_D127 notify("notify_player_can_launch");
}

_id_F539() {
  _id_0BDC::_id_A38E(16, 0.7, 0.7, 1.5);
}

_id_F528() {
  _id_0BDC::_id_A38E(30, 0.7, 0.7, 1.5);
}

_id_F538() {
  _id_0BDC::_id_A38E(10, 0.5, 0.5, 1.5);
}

_id_416D() {
  _id_0BDC::_id_A38E(undefined, undefined, undefined, 1.5);
}

_id_104EB() {
  _id_0BDC::_id_A250();
  setomnvar("ui_jackal_autopilot", 0);
  thread _id_104EC();
  thread _id_104EE();
  thread _id_104F1();
  thread _id_104F0();
  thread _id_104F2();
}

_id_104EF() {
  level notify("launch_hud_off");
  _id_0BDC::_id_A250(0);
}

_id_104EC() {
  level endon("launch_hud_off");
  level._id_1161E = 0;

  for(;;) {
    var_0 = level._id_D127.origin[2];
    var_0 = var_0 - level._id_1161E;
    var_1 = scripts\sp\math::_id_C097(-109728, 80000, var_0);
    var_2 = scripts\sp\math::_id_6A8E(0, 310000, var_1);
    setomnvar("ui_jackal_launch_alt", int(var_2));
    wait 0.05;
  }
}

_id_104EE() {
  setomnvar("ui_jackal_launch_gforce", 0.0);
  level._id_D127 waittill("notify_player_launch");
  thread scripts\sp\utility::_id_AB89("ui_jackal_launch_gforce", 2, 2);
  wait 2;
  thread scripts\sp\utility::_id_AB89("ui_jackal_launch_gforce", 9.5, 65);
  level waittill("flag_player_boosters_disengaged");
  thread scripts\sp\utility::_id_AB89("ui_jackal_launch_gforce", 0, 15);
}

_id_104F1() {
  setomnvar("ui_jackal_launch_speed", 0);
  level._id_D127 waittill("notify_player_launch");
  scripts\sp\utility::_id_AB8B("ui_jackal_launch_speed", 235, 2);
  thread scripts\sp\utility::_id_AB8B("ui_jackal_launch_speed", 500, 2);
  wait 2;
  thread scripts\sp\utility::_id_AB8B("ui_jackal_launch_speed", 40500, 65);
  level waittill("flag_player_boosters_disengaged");
  thread scripts\sp\utility::_id_AB8B("ui_jackal_launch_speed", 0, 15);
}

_id_104F0() {
  level endon("launch_hud_off");

  for(;;) {
    var_0 = level._id_D127 gettagangles("tag_body");
    var_1 = anglesToForward(var_0);
    var_2 = vectortoangles(var_1);
    setomnvar("ui_jackal_launch_pitch", abs(360 - var_2[0]));
    wait 0.05;
  }
}

_id_104F2() {
  wait 2;
  setomnvar("ui_jackal_launch_state", 1);
  wait 2.5;
  setomnvar("ui_jackal_launch_state", 0);
  level._id_D127 waittill("notify_player_launch");
  wait 10.5;
  setomnvar("ui_jackal_launch_state", 1);
  wait 2.5;
  setomnvar("ui_jackal_launch_state", 2);
}

_id_104ED() {
  level endon("launch_hud_off");
  setomnvar("ui_jackal_launch_fuel", 100);
  level._id_D127 waittill("notify_player_launch");
  var_0 = level._id_D2A1 islegacyagent(level._id_EC85["sled_jackal"]["moon_launch_boost"]);
  var_1 = 0.7;

  for(;;) {
    var_2 = level._id_D2A1 islegacyagent(level._id_EC85["sled_jackal"]["moon_launch_boost"]);
    var_3 = 1 - scripts\sp\math::_id_C097(var_0, var_1, var_2);
    var_4 = scripts\sp\math::_id_6A8E(0, 100, var_3);
    var_4 = scripts\sp\utility::_id_E753(var_4, 2);
    setomnvar("ui_jackal_launch_fuel", var_4);
    wait 0.05;
  }
}

_id_AA6D() {
  scripts\sp\maps\titanjackal\titanjackal_code::_id_D1D5("titan_plr_alljackalspreparefor");
  scripts\sp\maps\titanjackal\titanjackal_code::_id_DE1E("titan_s21_solidcopyrtb");
  scripts\engine\utility::delaythread(1.9, scripts\sp\maps\titanjackal\titanjackal_code::_id_EAB8, "titan_slt_launchsystemsengaged");
  level._id_D127 waittill("notify_player_launch");
  scripts\sp\maps\titanjackal\titanjackal_code::_id_D1D5("titan_plr_igniting");
  wait 2;
  scripts\sp\maps\titanjackal\titanjackal_code::_id_DE1E("titan_s21_normalgains");
  scripts\sp\maps\titanjackal\titanjackal_code::_id_D1D5("titan_plr_retributiongoflight");
  scripts\sp\maps\titanjackal\titanjackal_code::_id_7707("titan_nav_rogerthatjackals");
  scripts\sp\maps\titanjackal\titanjackal_code::_id_7707("titan_nav_retgoingthru19thousand");
  scripts\sp\maps\titanjackal\titanjackal_code::_id_DE1E("titan_twr_roger");
  scripts\sp\maps\titanjackal\titanjackal_code::_id_7707("titan_nav_35000goingthru");
  scripts\sp\maps\titanjackal\titanjackal_code::_id_DE1E("titan_s22_radarspickingup");
}

_id_AA6E() {
  level waittill("mons_fly_by");
  wait 2;
  scripts\sp\maps\titanjackal\titanjackal_code::_id_D1D5("titan_plr_itsthemonsall");
  setmusicstate("mx_016_monsambush");
}

_id_AA6F() {
  level.player waittill("mons_hit_player");
  var_0 = ["titan_plr_argshit", "titan_cmp_boostcouplingsdamaged", "titan_un3_captainshit", "titan_slt_pulloutpullout", "titan_plr_imdeadstickin", "titan_plr_comeoncome", "titan_slt_themonsisright", "titan_slt_evasivemaneuvers"];
  scripts\sp\maps\titanjackal\titanjackal_code::_id_48BD(var_0);
  var_0 = ["titan_plr_workdammit"];
  thread scripts\sp\maps\titanjackal\titanjackal_code::_id_48BD(var_0);
  level.player _meth_8463("lookat");
  earthquake(0.5, 0.85, level._id_D127.origin, 512);
  _id_0BDC::_id_D165(level._id_6348, 0, 0, 0);
  _id_0BDC::_id_D165(level._id_6348, 0, 1, 0, 1);
  _id_0BDC::_id_D165(level._id_6348, 1, 0, 10, 1);
  wait 1;
  level notify("player_systems_online");
}

_id_11961() {
  level waittill("ending_dialog_started");
  scripts\sp\maps\titanjackal\titanjackal_code::_id_D1D5("titan_plr_ahhhhhshiit");
  scripts\sp\maps\titanjackal\titanjackal_code::_id_6750("titan_eth_hitiscriticalsirwe");
  scripts\sp\maps\titanjackal\titanjackal_code::_id_D1D5("titan_plr_tryin");
  scripts\sp\maps\titanjackal\titanjackal_code::_id_6750("titan_eth_captainweshould");
  scripts\sp\maps\titanjackal\titanjackal_code::_id_D1D5("titan_plr_noicangetusin");
  scripts\sp\maps\titanjackal\titanjackal_code::_id_6750("titan_eth_impactimminentsi");
  scripts\sp\maps\titanjackal\titanjackal_code::_id_6750("titan_eth_maydaymayday11");
  scripts\sp\maps\titanjackal\titanjackal_code::_id_7707("titan_gtr_hullbreachcompa");
  scripts\sp\maps\titanjackal\titanjackal_code::_id_D1D5("titan_plr_retributionbrea");
  scripts\sp\maps\titanjackal\titanjackal_code::_id_7707("titan_gtr_multiplesignaturesi");
  scripts\sp\maps\titanjackal\titanjackal_code::_id_D1D5("titan_plr_getoutofthecomb");
  scripts\sp\maps\titanjackal\titanjackal_code::_id_D1D5("titan_plr_gatordropoutthats");
  scripts\sp\maps\titanjackal\titanjackal_code::_id_7707("titan_gtr_rogersir");
  scripts\sp\maps\titanjackal\titanjackal_code::_id_D1D5("titan_plr_fairwinds141");
  level._id_E35D _id_0BB8::_id_3991();
  scripts\sp\maps\titanjackal\titanjackal_code::_id_A25A("titan_cmp_lmasystemson");
  level._id_BA43 _id_0BB8::_id_3991();
  scripts\sp\maps\titanjackal\titanjackal_code::_id_6750("titan_eth_captainyoursuit");
  scripts\sp\maps\titanjackal\titanjackal_code::_id_D1D5("titan_plr_tookahitinthecockp");
  scripts\sp\maps\titanjackal\titanjackal_code::_id_6750("titan_eth_unsettlingreportsir");
  scripts\sp\maps\titanjackal\titanjackal_code::_id_6750("titan_eth_captainitwontstop");
  scripts\sp\maps\titanjackal\titanjackal_code::_id_D1D5("titan_plr_letitgoethan");
  scripts\sp\maps\titanjackal\titanjackal_code::_id_6750("titan_eth_icantsiryouremyc");
  scripts\sp\maps\titanjackal\titanjackal_code::_id_D1D5("titan_plr_whosays");
  scripts\sp\maps\titanjackal\titanjackal_code::_id_6750("titan_eth_imhardwaresirultim");
  scripts\sp\maps\titanjackal\titanjackal_code::_id_D1D5("titan_plr_noethanyouremyb");
  scripts\sp\maps\titanjackal\titanjackal_code::_id_6750("titan_eth_yourtalkingrobotbr");
  scripts\sp\maps\titanjackal\titanjackal_code::_id_D1D5("titan_plr_affirmative");
  scripts\sp\maps\titanjackal\titanjackal_code::_id_6750("titan_eth_iamthehandsomeo");
  scripts\sp\maps\titanjackal\titanjackal_code::_id_D1D5("titan_plr_nodoubt");
  scripts\sp\maps\titanjackal\titanjackal_code::_id_D1D5("titan_plr_endofthelineherepa");
  scripts\sp\maps\titanjackal\titanjackal_code::_id_6750("titan_eth_ithinkimscaredcapt");
  scripts\sp\maps\titanjackal\titanjackal_code::_id_D1D5("titan_plr_metoo");
  scripts\sp\maps\titanjackal\titanjackal_code::_id_6750("titan_eth_staywithmesir");
  scripts\sp\maps\titanjackal\titanjackal_code::_id_6750("titan_eth_sir");
  scripts\sp\maps\titanjackal\titanjackal_code::_id_6750("titan_eth_captaincaptain");
  wait 2.5;
  level notify("load_next_mission");
}

_id_AA6B() {
  var_0 = 5.2;
  setomnvar("ui_jackal_atmo_launch_countdown", gettime() + int(var_0 * 1000));
  thread scripts\sp\maps\titanjackal\titanjackal_code::_id_A25A("titan_cmp_fivefour");
  wait(var_0);
  level notify("player_launch");
  setomnvar("ui_jackal_atmo_launch_countdown", 0);
}

_id_509A() {
  var_0 = spawnStruct();
  var_0._id_98F7 = 200;
  var_0._id_98F8 = 0.3;
  var_0._id_C75D = 11000;
  var_0._id_C75E = 0.8;
  return var_0;
}

_id_AA97(var_0) {
  level._id_D127 _id_13811(getEnt("start_player_sled_path", "targetname"));
  var_1 = getvehiclenode("ret_launch_path", "targetname");
  level._id_E35D thread scripts\sp\vehicle::_id_2471(var_1);
  thread _id_AA96();
  level._id_E35D _id_0BB8::_id_39D0("max", 0.1);
  level._id_E35D thread scripts\sp\utility::play_sound_on_tag("scn_titan_retribution_launch", "tag_engine_rear");
  level._id_E35D _id_0BB8::_id_39D0("launch", 0.3);
  wait 9.8;
  level._id_E35D _id_0BB8::_id_39CD("launch", 0.1);
  wait 1;
  earthquake(0.45, 2, level._id_D127.origin, 5000);
  level._id_E35D _id_0BB8::_id_39D0("off", 0.2);
}

_id_AA96() {
  level._id_E35D vehicle_setspeed(950, 400, 50);
  wait 1.75;
  level._id_E35D vehicle_setspeed(250, 100, 50);
}

_id_AA4F(var_0, var_1, var_2, var_3, var_4, var_5) {
  wait(var_0);
  var_1 _id_0BDC::_id_19A0(0);
  self._id_843F = 1;
  var_6 = var_1.origin - level._id_D127.origin;
  var_6 = rotatevectorinverted(var_6, level._id_D127.angles);
  var_1 _id_0BDC::_id_19B2("face motion", level._id_D127.angles);
  var_1 _id_0BDC::_id_19AB(200, 150, undefined, 18);
  var_1 _id_0BDC::_id_1994(level._id_D127, var_6, 50, 0.2, 5000, 1.0);
  wait 0.05;
  var_1 thread _id_0BDC::_id_199D(6, var_5, 50, 0.2, 5000, 1.0);
  level waittill("player_launch");
  var_7 = rotatevectorinverted(anglesToForward(level._id_D127.angles) * (-1100 * var_2), level._id_D127.angles);
  var_1 thread _id_0BDC::_id_199D(var_2, var_5 + var_7, 50, 0.2, 5000, 1.0);
  wait(var_2);
  var_1 thread _id_0BDC::_id_199D(2, var_5, var_3._id_98F7, var_3._id_98F8, var_3._id_C75D, var_3._id_C75E);
  wait 0.05;
  var_1 _id_0BDC::_id_19A6(1);
  var_1 _id_0BDC::_id_19AB(200, 130, undefined, 45);
  var_1 notify("ignition");
}

_id_AA51(var_0) {
  level waittill("jackals_scatter");
  thread _id_EAA6(var_0);
  thread _id_DE1D(var_0);
  thread _id_DE20(var_0);
}

_id_EAA6(var_0) {
  level._id_EAD6 endon("death");
  level._id_EAD6 thread _id_0BDC::_id_199D(3, (2800, 600, 450), var_0._id_98F7, var_0._id_98F8, var_0._id_C75D, var_0._id_C75E);
  wait 3;
  level._id_EAD6 thread _id_0BDC::_id_199D(5, (2800, 500, -1600), var_0._id_98F7, var_0._id_98F8, var_0._id_C75D, var_0._id_C75E);
  wait 5;
  level._id_EAD6 thread _id_0BDC::_id_199D(3, (2550, 600, 450), var_0._id_98F7, var_0._id_98F8, var_0._id_C75D, var_0._id_C75E);
}

_id_DE1D(var_0) {
  level._id_DE1C endon("death");
  level._id_DE1C thread _id_0BDC::_id_199D(4, (3500, -1100, 600), var_0._id_98F7, var_0._id_98F8, var_0._id_C75D, var_0._id_C75E);
  wait 3;
  level._id_DE1C thread _id_0BDC::_id_199D(5, (3500, -1600, -2200), var_0._id_98F7, var_0._id_98F8, var_0._id_C75D, var_0._id_C75E);
  wait 5;
  level._id_DE1C thread _id_0BDC::_id_199D(3, (2600, -1100, 600), var_0._id_98F7, var_0._id_98F8, var_0._id_C75D, var_0._id_C75E);
}

_id_DE20(var_0) {
  level._id_DE1F endon("death");
  level._id_DE1F thread _id_0BDC::_id_199D(2, (5500, 200, 1400), var_0._id_98F7, var_0._id_98F8, var_0._id_C75D, var_0._id_C75E);
  wait 3;
  level._id_DE1F thread _id_0BDC::_id_199D(5, (6500, -400, -1800), var_0._id_98F7, var_0._id_98F8, var_0._id_C75D, var_0._id_C75E);
  wait 5;
  level._id_DE1F thread _id_0BDC::_id_199D(3, (5500, 200, 1400), var_0._id_98F7, var_0._id_98F8, var_0._id_C75D, var_0._id_C75E);
}

_id_D7D1() {
  thread _id_241E();
  thread _id_AA9B();
  level._id_D299 = _id_FA18();
  thread _id_0BDC::_id_A159(1);
  setomnvar("ui_jackal_autopilot", 1);
  _id_0BDC::_id_D165(level._id_D299._id_AFEB, 0.0, 0.0, 0);
  _id_0BDC::_id_D16C(scripts\engine\utility::getStruct("player_jackal_takeoff_position", "targetname"), 0.17, 0.01, 10);
  _id_0BDC::_id_D165(level._id_D299._id_AFEB, 0.06, 0.0, 10);

  while(!level._id_D299 _id_0BDC::_id_9C1B(0.25))
    scripts\engine\utility::waitframe();
}

launch_player(var_0) {
  scripts\engine\utility::flag_set("player_ending_launch_triggered");
  level._id_D299 thread scripts\sp\vehicle_paths::_id_845A();
  _id_0BDC::_id_A38E(16, 0.7, 0.7, 1.5);
  _id_0BDC::_id_D165(level._id_D299._id_AFEB, 0.15, 0.0, 2);
  _id_0BDC::_id_A14D(1);
  level.player thread _id_11989();
  earthquake(0.25, 1, level._id_D127.origin, 5000);
  _id_0BDC::_id_D165(level._id_D299._id_AFEB, 0, 0, 0);
  _id_0BDC::_id_D16C(level._id_D299, 0, 0, 0);
  _id_0BDC::_id_D165(level._id_D299._id_AFEB, 0, 1, 0, 1);
  _id_0BDC::_id_D16C(level._id_D299, 0, 1, 0, 1);
  _id_0BDC::_id_D165(level._id_D299._id_AFEB, 1, 0, 2, 1);
  thread _id_D1C5();
  thread _id_90C3();
  _id_0BDC::_id_A1DD(0);
  _id_0BDC::_id_A0BE();
  setomnvar("ui_jackal_atmo_launch", 1);
}

_id_90C3() {
  wait 5;
  var_0 = scripts\engine\utility::spawn_tag_origin();
  var_1 = anglesToForward(level._id_D127.angles);
  var_2 = level._id_D127.origin;
  var_1 = var_1 * 2000;
  var_0.angles = level._id_D127.angles;
  var_0.origin = var_2 + var_1;
  var_0 linkTo(level._id_D127);
  playFXOnTag(scripts\engine\utility::getfx("vfx_titan_jackal_flyout_cloud_run"), var_0, "tag_origin");
  scripts\sp\utility::_id_10FEC("fx_sunflare");
  scripts\sp\utility::_id_10FEC("rtd_lf");
  scripts\sp\utility::_id_10FEC("rtd_lf2");
  scripts\sp\utility::_id_10FEC("fx_ship_water_wash");
  wait 2;
  wait 20;
  stopFXOnTag(scripts\engine\utility::getfx("vfx_titan_jackal_flyout_cloud_run"), var_0, "tag_origin");
  scripts\engine\utility::exploder("hotlanding_planet_clouds");
  wait 1.0;
  scripts\sp\maps\titanjackal\titanjackal_arena_events::_id_A3A3();
}

_id_11989() {
  level.player playSound("scn_titan_jackal_takeoff_plr");
  wait 0.5;
  level.player playSound("scn_titan_jackal_takeoff_npcs");
  level.player _meth_82C2("titan_jackal_launch", "mix");
  wait 25;
  setglobalsoundcontext("atmosphere", "space", 4);
  wait 1;
  level.player clearclienttriggeraudiozone(0);
  level.player _meth_82C0("jackal_cockpit", 4);
}

_id_AA9B() {
  var_0 = (-15, 110, 0);
  var_1 = (-22, 110, 0);
  wait 12;
  lerpsunangles(var_0, var_1, 8);
}

_id_D1C5() {
  _id_0BDC::_id_D16C(level._id_D299, 0.599, 0, 6, 1);
}

_id_D1C0() {
  var_0 = scripts\sp\utility::_id_7C23();
  _id_D1C2(var_0);
  _id_D1C1(var_0);
}

_id_D1C2(var_0) {
  level endon("notify_player_impact");
  var_0 scripts\sp\utility::_id_E7C9(0.3, 0.3);

  for(;;) {
    earthquake(randomfloatrange(0.1, 0.15), 0.5, level._id_D127.origin, 5000);
    wait(randomfloatrange(0.2, 0.3));
  }
}

_id_D1C1(var_0) {
  level endon("player_regain_control");
  var_0 _id_5183("player_regain_control");
  var_0 scripts\sp\utility::_id_E7C9(0.7, 0.3);

  for(;;) {
    earthquake(randomfloatrange(0.15, 0.19), 0.5, level._id_D127.origin, 5000);
    wait(randomfloatrange(0.2, 0.3));
  }
}

_id_5183(var_0) {
  level waittill(var_0);
  self delete();
}

_id_FA18() {
  var_0 = getEnt("player_sled", "targetname");
  var_1 = scripts\sp\vehicle::_id_13237(var_0);
  var_1._id_AFEB = scripts\engine\utility::spawn_tag_origin();
  var_1._id_AFEB.origin = var_1.origin + anglesToForward(var_1.angles) * 15000;
  var_1._id_AFEB linkTo(var_1);
  var_1 setvehicleteam("allies");
  return var_1;
}

_id_102D2() {
  self endon("entitydeleted");

  for(;;)
    wait 0.05;
}

_id_E7B6() {
  var_0 = level._id_D299;
  self._id_EBA8 = 1.0;
  var_1 = 0.5;
  var_2 = 4000;
  var_3 = 0;
  thread _id_DC66();
  scripts\engine\utility::flag_init("flag_rubberband_speed");
  scripts\engine\utility::flag_set("flag_rubberband_speed");

  while(scripts\engine\utility::flag("flag_rubberband_speed")) {
    var_4 = distance(level._id_D299.origin, level._id_D299._id_AFEB.origin);
    var_5 = distance(level._id_D127.origin, level._id_D299._id_AFEB.origin);
    var_6 = var_5 - var_4;
    var_7 = scripts\sp\math::_id_C097(var_3, var_2, var_6);
    var_8 = scripts\sp\math::_id_6A8E(var_1, self._id_EBA8, var_7);
    _id_0BDC::_id_A301(var_8, 0.0, "takeoff_scale");
    scripts\engine\utility::waitframe();
  }

  _id_0BDC::_id_A301(1, 2, "takeoff_scale");
}

_id_DC66() {
  var_0 = 4;
  var_1 = 0.01;

  while(self._id_EBA8 < var_0) {
    self._id_EBA8 = self._id_EBA8 + var_1;
    wait 0.05;
  }

  self._id_EBA8 = var_0;
}

_id_1277F() {
  _id_13811(getEnt("start_player_sled_path", "targetname"));
  level._id_D299 scripts\sp\vehicle_paths::_id_845A();
}

_id_13811(var_0) {
  for(;;) {
    var_0 waittill("trigger", var_1);

    if(var_1 == self) {
      break;
    }
  }
}

_id_90BA() {
  scripts\engine\utility::flag_set("hot_landing_vision_fx");
  level._id_D127 = _id_0BDC::_id_1079F("player_rooftop_jackal", "hl_start_carrier_run");
  scripts\engine\utility::flag_set("player_in_control");
  _id_0BDC::_id_10CD1(level._id_D127);
  _id_9064();
  scripts\sp\utility::_id_10FEC("fx_sunflare");
  _id_90B9();
  _id_0BDC::_id_A24B("building1_landing_pad", 0);
  lerpsunangles((0, 0, 0), (-22, 110, 0), 0.1);
}

_id_90B8() {}

_id_D0E0() {
  var_0 = getEntArray("trigger_multiple", "code_classname");
  var_1 = getEntArray("actor_enemy_sdf_ar", "classname");
  var_2 = scripts\engine\utility::array_combine(var_0, var_1);
  var_3 = 0;
  var_4 = level._id_D127.origin[2];
  var_4 = var_4 - 40000;

  foreach(var_6 in var_2) {
    if(var_6.origin[2] < var_4) {
      var_6 delete();
      var_3++;
    }
  }
}

_id_3737() {
  var_0 = "player_ready_for_launch";
  level endon(var_0);
  thread _id_C0BF(var_0);

  for(;;)
    wait 0.1;
}

_id_C0BF(var_0) {
  scripts\engine\utility::flag_wait("flag_player_ready_for_launch");
  level notify(var_0);
}

_id_137D4() {
  _id_0BDC::_id_D165(level._id_E35D.origin, 1, 1, 2);

  while(!_id_0B76::_id_9C19(level._id_E35D))
    scripts\engine\utility::waitframe();

  scripts\engine\utility::flag_init("flag_player_launched");
  scripts\engine\utility::flag_set("flag_player_launched");
  scripts\sp\utility::_id_56BA("launch_hint");

  while(!level.player buttonPressed("BUTTON_X"))
    wait 0.05;

  scripts\engine\utility::flag_clear("flag_player_launched");
  thread _id_0BDC::_id_A159(1);
}

_id_AA7C() {
  return !scripts\engine\utility::flag("flag_player_launched");
}

_id_90B6() {
  level._id_E35D _id_13811(getEnt("mons_attack", "targetname"));
  level.player scripts\engine\utility::delaycall(1.5, ::playsound, "scn_titan_launch_mons_attack");
  wait 4;
  level notify("mons_fly_by");
  level._id_E35D notify("stop_wash");
  level.player scripts\engine\utility::delaycall(4.5, ::playsound, "scn_titan_mons_ram_flyby");
  thread _id_D1C4();
  thread _id_AA4E(4);
  _id_AA89(0.1);
  thread _id_D158("mons_hit_player");
  level._id_D127 _id_13811(getEnt("start_hot_landing", "targetname"));
  var_0 = getEnt("sky_swirl_clouds_dome", "targetname");
  var_0 hide();
}

_id_D1C4() {
  var_0 = getEntArray("trigger_multiple", "code_classname");
  var_1 = getEntArray("actor_enemy_sdf_ar", "classname");
  var_2 = scripts\engine\utility::array_combine(var_0, var_1);
  var_3 = 0;
  var_4 = level._id_D127.origin[2];

  foreach(var_6 in var_2) {
    if(var_6.origin[2] < var_4) {
      var_6 delete();
      var_3++;
    }
  }
}

_id_AA4E(var_0) {
  level._id_EAD6 thread _id_AA54(3, %jackal_titan_launch_evade_salter);
  level._id_DE1C thread _id_AA54(3.25, %jackal_titan_launch_evade_redshirt_1);
  level._id_DE1F thread _id_AA54(3.5, %jackal_titan_launch_evade_redshirt_2);
  wait(var_0);
  level notify("jackals_scatter");
}

_id_AA54(var_0, var_1) {
  self endon("death");
  var_2 = 4;
  wait(var_0);
  self _meth_82A2(var_1);
  wait 5;
  self _meth_82A2(%jackal_evade_overlay, 0, var_2);
}

_id_AA89(var_0) {
  var_1 = [];
  var_1 = _id_48BB();
  var_2 = "notify_player_impact";
  level._id_EAD6._id_843F = 1;
  level._id_DE1C._id_843F = 1;
  level._id_DE1F._id_843F = 1;
  var_3 = getEnt("mons_hot_landing_1", "targetname");
  level._id_BA43 = var_3 scripts\sp\vehicle::_id_1080B();
  level._id_BA43 _id_0BB8::_id_39CD("idle");
  level._id_BA43 _id_0BB8::_id_39AE();
  level._id_BA43 _id_BA8D();
  wait(var_0);
  level._id_EAD6 thread _id_AA76(4, 0.3, 1);
  level._id_DE1C thread _id_AA76(4, 0.2, 0);
  level._id_DE1F thread _id_AA76(3, 0.3, 2);
  level._id_BA43 _id_BA8E(var_1, 0.35, var_2, 4000, 2000, 0.1);
  level waittill(var_2);

  foreach(var_5 in var_1)
  var_5 delete();
}

_id_D158(var_0) {
  level.player playRumbleOnEntity("damage_heavy");
  level._id_D127 dodamage(90, level._id_D127.origin);
  thread _id_D159();
  earthquake(0.6, 2, level._id_D127.origin, 5000);
  setomnvar("ui_jackal_atmo_launch_damage", 1);
  level.player _meth_8489("body", %jackal_pilot_missle_hit, 0.2, %jackal_vehicle_missle_hit);

  if(isDefined(var_0))
    level.player notify(var_0);

  wait(getanimlength(%jackal_pilot_missle_hit) - 0.25);
  level.player _meth_8489("blendout", %jackal_pilot_missle_hit, 1.0, %jackal_vehicle_missle_hit);
  wait 0.05;
  level.player _meth_8489("body", %jackal_pilot_destabilized_idle, 0.2, %jackal_vehicle_destabilized_idle);
}

_id_D159() {
  wait 0.05;
  level.player playSound("scn_titan_jackal_missile_hit_plr_lr");
  level._id_D127 playSound("scn_titan_launch_jackal_hit_eng");
}

_id_48BB() {
  var_0 = [];
  var_0[0] = level._id_D127 scripts\engine\utility::spawn_tag_origin();
  var_0[1] = level._id_D127 scripts\engine\utility::spawn_tag_origin();
  var_0[2] = level._id_D127 scripts\engine\utility::spawn_tag_origin();
  var_0[3] = level._id_D127 scripts\engine\utility::spawn_tag_origin();
  var_0[4] = level._id_D127 scripts\engine\utility::spawn_tag_origin();
  var_0[5] = level._id_D127 scripts\engine\utility::spawn_tag_origin();
  var_0[6] = level._id_D127 scripts\engine\utility::spawn_tag_origin();
  var_0[7] = level._id_D127 scripts\engine\utility::spawn_tag_origin();
  var_0[8] = level._id_D127 scripts\engine\utility::spawn_tag_origin();
  var_0[0] linkTo(level._id_D127, "tag_origin", (18000, 0, 6000), (0, 0, 0));
  var_0[1] linkTo(level._id_D127, "tag_origin", (14000, -300, -2500), (0, 0, 0));
  var_0[2] linkTo(level._id_D127, "tag_origin", (13000, 500, 500), (0, 0, 0));
  var_0[3] linkTo(level._id_D127, "tag_origin", (11000, -700, -1300), (0, 0, 0));
  var_0[4] linkTo(level._id_D127, "tag_origin", (9000, 2500, 500), (0, 0, 0));
  var_0[5] linkTo(level._id_D127, "tag_origin", (8000, -500, -400), (0, 0, 0));
  var_0[6] linkTo(level._id_D127, "tag_origin", (6000, -1000, 0), (0, 0, 0));
  var_0[7] linkTo(level._id_D127, "tag_origin", (5000, 1500, -500), (0, 0, 0));
  var_0[8] linkTo(level._id_D127, "tag_origin", (2000, 150, 0), (0, 0, 0));
  return var_0;
}

_id_BA8D(var_0) {
  if(!isDefined(var_0))
    var_0 = "right";

  self._id_871C = [];
  self._id_871C[0] = scripts\engine\utility::spawn_tag_origin();
  self._id_871C[1] = scripts\engine\utility::spawn_tag_origin();
  self._id_871C[2] = scripts\engine\utility::spawn_tag_origin();

  if(var_0 == "right") {
    self._id_871C[0] linkTo(self, "tag_origin", (6000, -7000, 500), (-20, 270, 0));
    self._id_871C[1] linkTo(self, "tag_origin", (7500, -7000, 500), (-20, 270, 0));
    self._id_871C[2] linkTo(self, "tag_origin", (9000, -7000, 500), (-20, 270, 0));
  } else {
    self._id_871C[0] linkTo(self, "tag_origin", (6500, 7000, 500), (-20, -270, 0));
    self._id_871C[1] linkTo(self, "tag_origin", (7500, 7000, 500), (-20, -270, 0));
    self._id_871C[2] linkTo(self, "tag_origin", (9000, 7000, 500), (-20, -270, 0));
  }
}

_id_BA8E(var_0, var_1, var_2, var_3, var_4, var_5) {
  level notify("end_mons_guns_shoot");
  level endon("end_mons_guns_shoot");
  var_6 = undefined;

  if(!isDefined(level._id_11937))
    level._id_11937 = 0.05;

  var_7 = 0;

  foreach(var_9 in var_0) {
    if(var_9 == var_0[var_0.size - 1])
      var_6 = var_2;

    thread _id_6D11(self._id_871C[var_7], var_9, var_6, var_3, var_4, var_5);
    var_7++;

    if(var_7 >= self._id_871C.size)
      var_7 = 0;

    wait(var_1);
  }
}

_id_BA8F() {
  level endon("stop_mons_guns");

  for(;;) {
    for(var_0 = 0; var_0 < self._id_871C.size; var_0++) {
      thread _id_6D13(self._id_871C[var_0], level.player);
      wait 1;
    }
  }
}

_id_6D13(var_0, var_1) {
  var_2 = (randomfloatrange(0, 1), randomfloatrange(0, 1), randomfloatrange(0, 1));
  var_3 = randomfloatrange(2500, 3500);
  var_4 = var_0 scripts\engine\utility::spawn_tag_origin();
  var_5 = var_0 scripts\engine\utility::spawn_tag_origin();
  var_4 thread _id_0B76::_id_A332(level.player, 0, var_5, undefined, var_3, var_2, 0, ["vfx_mons_hl_cannon_impact", "scn_titan_flak_bursts", 5], undefined, 5, 1);
  wait 1;
  var_5 delete();
  var_4 waittill("death");

  if(!iscinematicplaying())
    level._id_D127 dodamage(500, level._id_D127.origin);
}

_id_6D11(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = (randomfloatrange(-250, 250), randomfloatrange(-250, 250), randomfloatrange(-250, 250));

  if(!isDefined(var_3))
    var_3 = randomfloatrange(2500, 3500);

  var_7 = var_0 scripts\engine\utility::spawn_tag_origin();
  var_8 = var_0 scripts\engine\utility::spawn_tag_origin();
  var_7 thread _id_0B76::_id_A332(var_1, 0, var_8, undefined, var_3, var_6, 0, ["vfx_mons_hl_cannon_impact", "scn_titan_flak_bursts", 5], var_4, 0, var_5, 0);
  var_7.script_noteworthy = "antiship_missile";

  if(isDefined(var_2))
    var_7 thread _id_B81E(var_2);

  wait 1;

  if(isDefined(var_8))
    var_8 delete();
}

_id_B81E(var_0) {
  self waittill("death");
  level notify(var_0);
}

_id_6636() {
  for(;;) {
    var_0 = _id_7997();
    var_1 = 0;

    foreach(var_4, var_3 in var_0)
    var_1 = var_1 + var_3;

    var_0 = undefined;
    wait 1;
  }
}

_id_7997() {
  var_0 = getEntArray();
  var_1 = [];

  foreach(var_3 in var_0) {
    if(!isDefined(var_3.classname))
      var_4 = "UNKNOWN WTF?";
    else
      var_4 = var_3.classname;

    if(isDefined(var_3._id_49BD))
      var_4 = "CREATEFX " + var_3.classname;

    if(var_4 == "script_model")
      var_4 = var_4 + (" " + var_3.model);

    if(!isDefined(var_1[var_4]))
      var_1[var_4] = 0;

    var_1[var_4]++;
  }

  var_1 = _id_1041D(var_1);
  return var_1;
}

_id_1041D(var_0) {
  var_1 = getarraykeys(var_0);

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    var_3 = var_1[var_2];

    for(var_4 = var_2; var_4 < var_1.size; var_4++) {
      if(var_0[var_1[var_2]] < var_0[var_1[var_4]]) {
        var_5 = var_1[var_4];
        var_1[var_4] = var_1[var_2];
        var_1[var_2] = var_5;
      }
    }
  }

  var_6 = [];

  for(var_2 = 0; var_2 < var_1.size; var_2++)
    var_6[var_1[var_2]] = var_0[var_1[var_2]];

  return var_6;
}

_id_663A() {
  for(;;) {
    _id_6637();
    wait 0.05;
  }
}

_id_6637() {
  if(!isDefined(level._id_126F))
    level._id_126F = [];

  var_0 = getEntArray();

  foreach(var_2 in var_0) {
    if(!isDefined(var_2)) {
      continue;
    }
    if(!isDefined(var_2.origin)) {
      continue;
    }
    if(!isDefined(var_2._id_65D9)) {
      var_2._id_65D9 = gettime();
      level thread _id_65F3(var_2);
    }
  }
}

_id_65F3(var_0) {
  var_0 endon("death");
  var_1 = 60;
  var_2 = 1;
  var_3 = var_2 / var_1;
  var_4 = (1, 1, 0);
  var_5 = (0.2, 0.2, 0.2);
  var_6 = (var_4 - var_5) / var_1;

  for(var_7 = 0; var_7 < var_1; var_7++) {
    if(!isDefined(var_0)) {
      return;
    }
    var_8 = var_2 - var_3 * var_7;
    var_9 = var_4 - var_6 * var_7;
    var_8 = clamp(var_8, 0, 1);
    wait 0.05;
  }
}

_id_482B() {
  thread _id_90B4();
  scripts\engine\utility::flag_set("flag_scipted_jackal_landing");
  var_0 = scripts\engine\utility::get_target_ent("hl_crash_origin");
  var_1 = scripts\engine\utility::getStruct("jackal_mover_animnode", "targetname");
  var_2 = scripts\engine\utility::spawn_tag_origin(var_1.origin, var_1.angles);
  var_2._id_1FBB = "crash";
  var_2 scripts\sp\anim::_id_F64A();
  var_2._id_1FBD = var_1;
  var_3 = scripts\engine\utility::get_target_ent("hl_landing_drone");
  level._id_9065 = spawn("script_model", var_3.origin);
  level._id_9065.angles = var_3.angles;
  level._id_9065 setModel("landing_drone");
  level._id_9065._id_1FBB = "crash";
  level._id_9065 scripts\sp\anim::_id_F64A();
  level._id_9066 = scripts\engine\utility::spawn_tag_origin(level._id_9065.origin + anglesToForward(level._id_9065.angles) * -200);
  level._id_9066 linkTo(level._id_9065);
  var_2._id_1FBD thread scripts\sp\anim::_id_1EC3(var_2, "hl_jackal_mover");
  var_0 thread scripts\sp\anim::_id_1EC3(level._id_9065, "hl_sled_enter");
  var_4 = scripts\engine\utility::spawn_tag_origin(var_2.origin + anglesToForward(var_2.angles) * 3000);
  var_4 linkTo(var_2);
  _id_0BDC::_id_A15C(1);
  _id_0BDC::_id_A153(1);
  _id_0BDC::_id_A14A(1);
  _id_0BDC::_id_A14D(1);
  _id_135E0(32000, var_0);
  thread _id_102D3();
  level._id_FD6E._id_E35D thread _id_0B51::_id_E3C6(0);
  _id_0BDC::_id_A301(0.5, 0, "finale_speed");
  var_5 = scripts\engine\utility::get_target_ent("trig_crash_landing");
  var_5 _id_D18E();
  var_6 = getvehiclenode("hl_mons_last_pos", "targetname");
  level._id_BA43 vehicle_teleport(var_6.origin + (-6000, 0, -4000), var_6.angles);
  playFX(level._effect["zerog_exp_1"], level._id_D2F8[1].origin, anglesToForward(level._id_D2F8[1].angles), anglestoup(level._id_D2F8[1].angles));
  earthquake(randomfloatrange(0.5, 0.6), 0.5, level._id_D2F8[1].origin, 4000);

  if(_id_D1A3(4000, level._id_D2F8[1].origin))
    level._id_D127 playRumbleOnEntity("light_2s");

  _id_0BDC::_id_D165(var_4, 1, 0, 0.2, 1);
  level._id_D127 _id_0BDC::_id_D164(var_2, 1);
  level.player playSound("scn_titan_crash_land");
  setomnvar("ui_jackal_autopilot", 1);
  wait 0.2;
  level.player scripts\engine\utility::delaycall(8, ::playsound, "scn_titan_warp_build");
  scripts\engine\utility::noself_delaycall(8, ::visionsetnaked, "titan_ftl", 12.5);
  level._id_9065 scripts\engine\utility::delaycall(8, ::delete);
  level._id_FD6E._id_E35D thread _id_0B51::_id_C5FC(0.9);
  level._id_9065 notify("stop_loop");
  var_2._id_1FBD thread scripts\sp\anim::_id_1F35(var_2, "hl_jackal_mover");
  thread _id_13315();
  var_0 thread scripts\sp\anim::_id_1F35(level._id_9065, "hl_sled");
  level.player _meth_8489("body", %titan_hot_landing_player_jackal, 0.05, %titan_hot_landing_player_jackal_pilot);
  level._id_FD6E._id_E35D._id_E8AD _id_0BDB::_id_A2F1();
  thread _id_D134();
  scripts\engine\utility::flag_wait("hl_mons_salvo_fire_bink");
  wait 1.0;
  thread _id_BAC1();
  wait 3.7;
  wait 2.0;
  scripts\sp\hud_util::_id_6AA3(0.05, "white");
  level notify("end_om_flak_defense");
  level notify("end_defense_turrets");
  level notify("end_shoot_missiles");
  level._id_D127 scripts\sp\vehicle::_id_8441();
  _id_0BDC::_id_D190();
  level.player _meth_8489("blendout", %titan_hot_landing_player_jackal, 0.05, %titan_hot_landing_player_jackal_pilot);
}

_id_2405() {
  var_0 = _id_0BDC::_id_1079F("player_rooftop_jackal", "player_asteroid_arrive");
  _id_0BDC::_id_10CD1(var_0);
}

_id_2404() {
  var_0 = scripts\engine\utility::getStruct("player_asteroid_arrive", "targetname");
  var_1 = var_0 scripts\engine\utility::spawn_tag_origin();
  var_2 = scripts\engine\utility::getStruct("ret_asteroid_arrive", "targetname");
  level._id_FD6E._id_E35D.origin = var_2.origin;
  level._id_FD6E._id_E35D.angles = var_2.angles;
  level._id_D127 _id_0BDC::_id_D164(var_1, 0.05);
  level._id_D127 stopsounds();
  level._id_D127 _meth_8491("none");
  scripts\sp\hud_util::_id_6A99(0.25, "white");
  _id_2407();
  wait 2;
  wait 2;
  scripts\sp\utility::_id_BF95();
}

_id_2407() {
  wait 1.5;
  wait 1.5;
  wait 1.5;
  wait 1.5;
}

_id_62C8() {}

_id_D0DC(var_0) {
  earthquake(randomfloatrange(0.5, 0.6), 0.5, level._id_D2F8[1].origin, 4000);
  level._id_D127 playRumbleOnEntity("light_2s");
}

_id_D0DD(var_0) {
  earthquake(randomfloatrange(0.5, 0.6), 0.5, level._id_D2F8[1].origin, 4000);
  level._id_D127 playRumbleOnEntity("light_2s");
  thread _id_62C8();
}

_id_1023C(var_0) {
  earthquake(randomfloatrange(0.5, 0.6), 0.5, level._id_D2F8[1].origin, 4000);
  level._id_D127 playRumbleOnEntity("light_2s");
  level notify("end_landing_drone_broken");
}

_id_62DE(var_0) {
  scripts\engine\utility::flag_set("hl_mons_salvo_fire_bink");
}

_id_83BC() {
  setsaveddvar("bg_cinematicFullScreen", "1");
  setsaveddvar("bg_cinematicCanPause", "1");
  cinematicingame("shipcrib_titan_hot_landing");
  wait 0.1;

  while(iscinematicplaying())
    wait 0.05;
}

_id_970A() {
  var_0 = scripts\engine\utility::getStructArray("hl_defense_turret", "targetname");

  foreach(var_2 in var_0)
  var_2 thread _id_E309();
}

_id_C473() {
  level endon("end_om_flak_defense");
  scripts\engine\utility::flag_wait("hl_mons_flak");

  for(var_0 = 0; var_0 < 3; var_0++) {
    wait 2.2;
    level._id_C47A++;
    level._id_C479 = level._id_C479 - 0.2;
    level._id_C478 = level._id_C478 - 0.2;
  }

  level._id_D127 _id_13811(getEnt("trigger_under_mons", "targetname"));
  level._id_C479 = 0.3;
  level._id_C478 = 0.45;
}

_id_C477() {
  level endon("end_om_flak_defense");
  var_0 = [];
  level._id_C47A = 1;
  level._id_C479 = 1.4;
  level._id_C478 = 1.6;
  var_1 = scripts\engine\utility::get_target_ent("om_flak_cannons");
  var_2 = 0;
  thread _id_C473();

  for(;;) {
    var_0 = _id_0BCE::_id_7DB5();

    foreach(var_4 in var_0) {
      if(var_4.classname != "script_vehicle_jackal_friendly" && var_4.classname != "script_vehicle_jackal_friendly_heist")
        var_0 = scripts\engine\utility::array_remove(var_0, var_4);
    }

    if(isDefined(var_0[0])) {
      var_0 = scripts\engine\utility::array_randomize(var_0);

      for(var_6 = 0; var_6 < var_0.size; var_6++) {
        if(var_0[var_6] istouching(var_1)) {
          if(var_2 <= level._id_C47A) {
            var_2++;

            if(isalive(var_0[var_6]))
              var_0[var_6] thread _id_6E80();
          }

          scripts\engine\utility::flag_set("hl_mons_flak");
        }
      }
    }

    wait(randomfloatrange(level._id_C479, level._id_C478));
    var_2 = 0;
  }
}

_id_AA76(var_0, var_1, var_2) {
  level endon("end_om_flak_defense");
  self endon("death");
  wait(var_2);

  while(var_0 > 0) {
    _id_6E80(8000);
    var_0--;
    wait(var_1);
  }
}

_id_6E80(var_0) {
  level endon("end_om_flak_defense");
  self endon("death");

  if(isDefined(var_0))
    var_0 = anglesToForward(self.angles) * var_0;
  else
    var_0 = (0, 0, 0);

  var_1 = spawnStruct();
  var_1.origin = self.origin;
  var_1.angles = self.angles;
  var_1.origin = var_1.origin + (randomfloatrange(-1700, -750), randomfloatrange(-1300, 1300), randomfloatrange(-1300, 1300)) + var_0;
  wait(randomfloatrange(0.3, 0.8));
  playFX(level._effect["om_flak_expl"], var_1.origin, anglesToForward(var_1.angles), anglestoup(var_1.angles));
  playworldsound("scn_titan_flak_bursts", var_1.origin);
  var_2 = 4000;
  earthquake(randomfloatrange(0.5, 0.6), 0.5, var_1.origin, var_2);

  if(_id_D1A3(var_2, var_1.origin)) {
    level._id_D127 playRumbleOnEntity("light_2s");
    var_3 = randomintrange(30, 100);
    level._id_D127 dodamage(var_3, var_1.origin);
  }

  wait(randomfloatrange(0.2, 0.3));
}

_id_D1A3(var_0, var_1) {
  if(!isDefined(level._id_D127))
    return 0;

  var_2 = distance(var_1, level._id_D127.origin);

  if(var_2 < var_0)
    return 1;

  return 0;
}

_id_E309() {
  level endon("end_defense_turrets");
  self endon("death");
  var_0 = [];

  for(;;) {
    wait 0.1;
    var_0 = getEntArray("antiship_missile", "script_noteworthy");
    var_0 = sortbydistance(var_0, self.origin);

    if(isDefined(var_0[0])) {
      var_1 = distance(var_0[0].origin, self.origin);

      if(var_1 <= 12000) {
        var_2 = randomintrange(3, 6);

        for(var_3 = 0; var_3 < var_2; var_3++) {
          if(isDefined(var_0[0])) {
            var_4 = vectorNormalize(var_0[0].origin - self.origin);
            playFX(level._effect["defense_turret_muzzle"], self.origin, var_4, anglestoup(self.angles));
            magicbullet("iw7_flaredefense", self.origin, var_0[0].origin + (randomfloatrange(-35, 35), randomfloatrange(-35, 35), randomfloatrange(-35, 35)), level.player);
            wait(randomfloatrange(0, 0.25));
          }
        }

        wait(randomfloatrange(0.05, 0.12));
      }
    }
  }
}

_id_BAC1() {
  var_0 = [];
  var_1 = [];
  var_1 = scripts\engine\utility::getStructArray("hl_last_salvo_targets", "targetname");

  foreach(var_3 in var_1) {
    var_4 = scripts\engine\utility::spawn_tag_origin(var_3.origin, var_3.angles);
    var_0 = scripts\engine\utility::array_add(var_0, var_4);
  }

  var_0 = scripts\engine\utility::array_randomize(var_0);
  var_6 = [];
  var_7 = [];
  var_7 = scripts\engine\utility::getStructArray("hl_mons_last_salvo", "targetname");

  foreach(var_3 in var_7) {
    var_4 = scripts\engine\utility::spawn_tag_origin(var_3.origin, var_3.angles);
    var_6 = scripts\engine\utility::array_add(var_6, var_4);
  }

  var_6 = scripts\engine\utility::array_randomize(var_6);
  var_10 = 0;

  foreach(var_12 in var_0) {
    wait(randomfloatrange(0, 0.2));
    thread _id_6D12(var_6[var_10], var_12);
    var_10++;

    if(var_10 >= var_6.size)
      var_10 = 0;
  }

  wait 1;
  var_0 = scripts\engine\utility::array_randomize(var_0);
  var_6 = scripts\engine\utility::array_randomize(var_6);

  foreach(var_12 in var_0) {
    wait(randomfloatrange(0.2, 0.25));
    thread _id_6D12(var_6[var_10], var_12);
    var_10++;

    if(var_10 >= var_6.size)
      var_10 = 0;
  }

  wait 0.15;

  foreach(var_12 in var_0) {
    wait(randomfloatrange(0.01, 0.03));
    thread _id_6D12(var_6[var_10], var_12);
    var_10++;

    if(var_10 >= var_6.size)
      var_10 = 0;
  }
}

_id_6D12(var_0, var_1) {
  var_2 = (0, 0, randomfloatrange(-250, 250));
  var_3 = 150;
  var_4 = 150;
  var_5 = var_0 scripts\engine\utility::spawn_tag_origin();
  var_6 = var_0 scripts\engine\utility::spawn_tag_origin();
  var_5 thread _id_0B76::_id_A332(var_1, 0, var_6, undefined, var_3, var_2, 0, ["vfx_mons_hl_cannon_impact", "scn_titan_flak_bursts", 5], var_4, 5, 1);
  var_5.script_noteworthy = "antiship_missile";
  wait 1;

  if(isDefined(var_6))
    var_6 delete();
}

_id_D18E() {
  for(;;) {
    self waittill("trigger", var_0);

    if(var_0 == level._id_D127) {
      break;
    }
  }
}

_id_12957() {
  level notify("stop_mons_guns");
}

_id_C47B() {
  level notify("om_weapons_off");
  level endon("om_weapons_off");
  self._id_871C = [];
  self._id_871C[0] = scripts\engine\utility::spawn_tag_origin();
  self._id_871C[1] = scripts\engine\utility::spawn_tag_origin();
  self._id_871C[2] = scripts\engine\utility::spawn_tag_origin();
  self._id_871E = "none";

  for(;;) {
    var_0 = anglestoright(level._id_BA43.angles);
    var_1 = vectorNormalize(level._id_D127.origin - level._id_BA43.origin);
    var_2 = vectordot(var_1, var_0);

    if(var_2 > 0 && self._id_871E != "right") {
      self._id_871E = "right";
      self._id_871C[0] unlink();
      self._id_871C[1] unlink();
      self._id_871C[2] unlink();
      self._id_871C[0] linkTo(self, "tag_origin", (6500, -7000, 500), (-20, 270, 0));
      self._id_871C[1] linkTo(self, "tag_origin", (7500, -7000, 500), (-20, 270, 0));
      self._id_871C[2] linkTo(self, "tag_origin", (8500, -7000, 500), (-20, 270, 0));
    } else if(var_2 < 0 && self._id_871E != "left") {
      self._id_871E = "left";
      self._id_871C[0] unlink();
      self._id_871C[1] unlink();
      self._id_871C[2] unlink();
      self._id_871C[0] linkTo(self, "tag_origin", (6500, 7000, 500), (-20, -270, 0));
      self._id_871C[1] linkTo(self, "tag_origin", (7500, 7000, 500), (-20, -270, 0));
      self._id_871C[2] linkTo(self, "tag_origin", (8500, 7000, 500), (-20, -270, 0));
    }

    wait 1;
  }
}

_id_13315() {
  wait 1.6;
  playFX(level._effect["zerog_exp_1"], level._id_D2F8[1].origin, anglesToForward(level._id_D2F8[1].angles), anglestoup(level._id_D2F8[1].angles));
  earthquake(randomfloatrange(0.5, 0.6), 0.5, level._id_D2F8[1].origin, 4000);

  if(_id_D1A3(4000, level._id_D2F8[1].origin))
    level._id_D127 playRumbleOnEntity("light_2s");

  wait 0.7;
  playFX(level._effect["zerog_exp_1"], level._id_D2F8[2].origin, anglesToForward(level._id_D2F8[2].angles), anglestoup(level._id_D2F8[2].angles));
  earthquake(randomfloatrange(0.5, 0.6), 0.5, level._id_D2F8[2].origin, 4000);

  if(_id_D1A3(4000, level._id_D2F8[2].origin))
    level._id_D127 playRumbleOnEntity("light_2s");

  thread scripts\sp\maps\titanjackal\titanjackal_code::_id_D1D5("titan_plr_argshit");
  playFX(level._effect["zerog_small_exp"], level._id_9065.origin, anglesToForward(level._id_9065.angles), anglestoup(level._id_9065.angles));
  playFXOnTag(level._effect["lander_smoke_trail"], level._id_9066, "tag_origin");
  thread _id_A7E0();
}

_id_A7E0() {
  level endon("end_landing_drone_broken");
  level._id_9065 endon("death");

  for(;;) {
    playFX(level._effect["zerog_spark_burst"], level._id_9065.origin + (randomfloatrange(150, 240), randomfloatrange(400, 550), randomfloatrange(-30, 0)));
    wait(randomfloatrange(0.4, 1));
  }
}

_id_102D3() {
  var_0 = scripts\engine\utility::get_target_ent("hl_crash_origin");
  var_0 scripts\sp\anim::_id_1F35(level._id_9065, "hl_sled_enter");
  var_0 thread scripts\sp\anim::_id_1EEA(level._id_9065, "hl_sled_idle");
}

_id_D134() {
  setomnvar("ui_jackal_hot_landing", 1);
}

_id_135E0(var_0, var_1) {
  var_2 = distance(level._id_D127.origin, var_1.origin);
  var_3 = var_2;

  while(var_3 > var_0) {
    var_3 = distance(level._id_D127.origin, var_1.origin);
    var_4 = scripts\sp\math::_id_C097(var_0, var_2, var_3);
    wait 0.05;
  }
}

_id_A80B(var_0, var_1, var_2, var_3) {
  var_4 = distance(level._id_D127.origin, var_3.origin);
  var_5 = var_4;

  while(var_5 > var_2) {
    var_5 = distance(level._id_D127.origin, var_3.origin);
    var_6 = scripts\sp\math::_id_C097(var_2, var_4, var_5);
    var_7 = scripts\sp\math::_id_6A8E(var_1, var_0, var_6);
    wait 0.05;
  }
}

_id_A236(var_0, var_1) {
  var_0 linkTo(self);
  scripts\sp\anim::_id_1F35(var_0, var_1);
}

_id_A1B3(var_0, var_1) {
  scripts\sp\anim::_id_1F35(var_0, var_1);
  wait 1;
  var_0 delete();
}

_id_9064() {
  var_0 = getEnt("hl_salter_jackal_spawn", "targetname");
  level._id_EAD6 = var_0 scripts\sp\utility::_id_10808();
  level._id_EAD6 thread _id_0BDC::_id_A342(scripts\sp\utility::_id_7C9A("hl_spline_left"), 0.2, 1);
  var_1 = getEnt("hl_redshirt1_jackal_spawn", "targetname");
  level._id_DE1C = var_1 scripts\sp\utility::_id_10808();
  level._id_DE1C thread _id_0BDC::_id_A342(scripts\sp\utility::_id_7C9A("hl_spline_right"), 0.2, 1);
  var_2 = getEnt("hl_redshirt2_jackal_spawn", "targetname");
  level._id_DE1F = var_2 scripts\sp\utility::_id_10808();
  level._id_DE1F thread _id_0BDC::_id_A342(scripts\sp\utility::_id_7C9A("hl_spline_middle"), 0.2, 1);
  level._id_6338 = [level._id_EAD6, level._id_DE1C, level._id_DE1F];
}

_id_9063() {
  setsaveddvar("spaceshipAiFlySpeed", 10000.0);
  var_0 = 1500;
  var_1 = 20000;
  level.space = 1;

  while(!isDefined(level._id_EAD6))
    wait 0.05;

  level._id_EAD6._id_843F = 1;
  level._id_DE1C._id_843F = 1;
  level._id_DE1F._id_843F = 1;
  wait 0.25;
  level._id_EAD6 _id_0BDC::_id_19A6(0);
  level._id_EAD6 _id_0BDC::_id_19B7();
  level._id_EAD6 thread _id_0BDC::_id_A1F0("hl_spline_left", var_0, 3000, 5, var_1);
  level._id_DE1C _id_0BDC::_id_19A6(0);
  level._id_DE1C _id_0BDC::_id_19B7();
  level._id_DE1C thread _id_0BDC::_id_A1F0("hl_spline_right", var_0, 3000, 5, var_1);
  level._id_DE1F _id_0BDC::_id_19A6(0);
  level._id_DE1F _id_0BDC::_id_19B7();
  level._id_DE1F thread _id_0BDC::_id_A1F0("hl_spline_middle", var_0, 3000, 5, var_1);
}

_id_1196F() {
  scripts\engine\utility::flag_set("hot_landing_vision_fx");
  scripts\sp\utility::_id_10FEC("fx_sunflare");
  _id_11971();
  _id_0BDC::_id_137D6();
  thread _id_D0E0();

  if(!scripts\engine\utility::flag("player_in_control"))
    _id_D25A();

  thread _id_9063();
  thread _id_25C4();
  level._id_7495 = "titan_hotlanding_02";
  var_0 = [];
  var_1 = [];
  var_2 = scripts\engine\utility::spawn_tag_origin();
  var_3 = scripts\engine\utility::spawn_tag_origin();
  var_4 = scripts\sp\utility::_id_10639("moving_origin");
  var_5 = scripts\sp\utility::_id_10639("debris");
  level._id_6346 = scripts\sp\utility::_id_10639("ending_player_jackal");
  level._id_633E = scripts\sp\utility::_id_10639("ending_player_jackal");
  level._id_6341 = scripts\sp\utility::_id_10639("ending_eth3n");
  level.player._id_1E9C = scripts\sp\utility::_id_10639("player_rig_torn");
  var_1 = scripts\engine\utility::array_add(var_1, var_5);
  var_1 = scripts\engine\utility::array_add(var_1, level.player._id_1E9C);
  var_1 = scripts\engine\utility::array_add(var_1, level._id_6341);
  var_1 = scripts\engine\utility::array_add(var_1, level._id_6346);
  level._id_6346 hide();
  level._id_633E hide();

  foreach(var_7 in var_1)
  var_7 hide();

  var_0 = scripts\engine\utility::add_to_array(var_0, level._id_6348);
  _id_11970();
  var_0 = scripts\engine\utility::add_to_array(var_0, level._id_BA43);
  var_2.origin = level._id_6348.origin;
  var_2.angles = level._id_6348.angles;
  var_2 scripts\sp\anim::_id_1EC3(level._id_BA43, "titan_ending_intro");
  var_2 scripts\sp\anim::_id_1EC3(var_4, "titan_ending");
  var_3.origin = var_4.origin;
  var_3.angles = var_4.angles;
  var_3 scripts\sp\anim::_id_1EC3(level._id_6346, "titan_ending");
  var_3 scripts\sp\anim::_id_1EC3(level._id_633E, "titan_ending_crash");
  var_3 scripts\sp\anim::_id_1EC3(var_5, "titan_ending");

  if(isDefined(level._id_D299)) {
    var_9 = 1;
    _id_0BDC::_id_D16C(level._id_D299, 0, 1, var_9);
    _id_0BDC::_id_D16C(level._id_D299, 0, 1, var_9, 1);
  }

  _id_0BDC::_id_A2FC(0.45);
  _id_0BDC::_id_A301(0.5, 1);
  _id_0BDC::_id_A0BE(1);
  level._id_EAD6 _id_13811(getEnt("trigger_mons_whale_breach", "targetname"));
  scripts\engine\utility::delaythread(3, _id_0BDC::_id_A2FC, 0.7);
  var_2 thread scripts\sp\anim::_id_1F35(level._id_BA43, "titan_ending_intro");
  scripts\engine\utility::delaythread(2, scripts\engine\utility::play_sound_in_space, "scn_titan_mons_surface", level._id_BA43.origin);
  level.player scripts\sp\utility::_id_C12D("mons_surfacing", 2);
  thread _id_11968(3);
  thread _id_11967();
  thread _id_AA4E(3);
  level._id_D127 _id_13811(getEnt("trigger_under_mons", "targetname"));
  thread lerp_cam_shake();
  _id_0BDC::_id_A159(1);
  level._id_D127 thread _id_11966(3);
  thread _id_FB8F();
  thread _id_1195E();
  _id_0BDC::_id_A0BE(0);
  _id_0BDC::_id_A301(2, 1);
  _id_0BDC::_id_D164(var_3, 3);
  _id_0BDC::_id_A153(1);
  level.player scripts\sp\utility::_id_11428();
  scripts\sp\maps\titanjackal\titanjackal_code::_id_D85C();

  while(distance(level._id_D127.origin, var_3.origin) > 3000)
    scripts\engine\utility::waitframe();

  _id_11960();
  level notify("end_om_flak_defense");
  level._id_6346 thread _id_11966(5);
  earthquake(0.45, 1.5, var_3.origin, 5000);
  level._id_D127 _id_0BDC::_id_F358("instant");
  level._id_D127 _id_0BDC::_id_F448("instant");
  level._id_D127 notify("player_exit_jackal");
  level._id_D127 notify("jackal_cockpit_VO_interupt");
  level._id_D127 _id_0BDB::_id_E073();

  foreach(var_7 in var_1)
  var_7 show();

  var_2 thread scripts\sp\anim::_id_1F2C(var_0, "titan_ending");
  var_2 thread scripts\sp\anim::_id_1F35(var_4, "titan_ending");
  var_2 thread scripts\sp\anim::_id_1F35(level._id_633E, "titan_ending_crash");
  level._id_6346 show();
  level.player._id_1E9C linkTo(var_4, "tag_origin");
  level._id_6341 linkTo(var_4, "tag_origin");
  var_5 linkTo(var_4, "tag_origin");
  level._id_6346 linkTo(var_4, "tag_origin");
  level.player playerlinktodelta(level.player._id_1E9C, "tag_player", 1, 20, 20, 20, 20, 1);
  level.player _meth_8392(0.5);
  scripts\engine\utility::flag_set("start_hot_landing_robot_romance_dof");
  thread _id_1195D();
  var_3 scripts\sp\anim::_id_1F2C(var_1, "titan_ending");
}

lerp_cam_shake() {
  level thread scripts\sp\utility::_id_C12D("stop_temp_shake", 3);
  level endon("stop_temp_shake");
  earthquake(0.7, 0.1, _id_0C1A::_id_7BA7(), 5000);
  wait 0.1;

  for(;;) {
    earthquake(randomfloatrange(0.45, 0.54), 0.1, _id_0C1A::_id_7BA7(), 5000);
    wait 0.1;
  }
}

_id_1195D() {
  scripts\sp\utility::_id_1264E("titan_jackal_refinery_tr");
  setpreloadimageprimeset("shipcrib_rogue_primeimg");
  level scripts\engine\utility::delaythread(5, scripts\sp\utility::_id_BF97);
  level.player waittill("dof_fun_clear");
  setomnvar("ui_hide_hud", 1);
  level.player playSound("scn_titan_blackout_end_lr");
  wait 18;
  scripts\sp\utility::_id_BF95();
}

_id_11971() {
  var_0 = getEnt("retribution_outro_veh_spawner", "targetname");
  var_0._id_EEF9 = _id_11965();
  level._id_6348 = var_0 scripts\sp\utility::_id_10808();
  level._id_6348 _id_0B51::_id_10635();
  level._id_6348._id_1FBB = "retribution";
  level._id_6348 _id_0BB8::_id_39AE();
  level._id_6348 scripts\sp\anim::_id_1EC3(level._id_6348, "titan_ending");
  level._id_6348 solid();
  level._id_6348._id_24C2 = 90;
}

_id_11970() {
  var_0 = getEnt("mons_hot_landing_2", "targetname");
  var_0._id_EEF9 = "none";
  level._id_BA43 = var_0 scripts\sp\utility::_id_10808();
  level._id_BA43._id_1FBB = "mons";
  level._id_BA43 _id_0BB8::_id_39AE();
  level._id_BA43 thread _id_11964();
  level._id_BA43 solid();
  level._id_BA43._id_24C2 = 90;
}

_id_11965() {
  var_0 = "missile_cluster_turret_un cannon_small_un,1,1,amb_turret_sml_t_l_1,amb_turret_sml_t_l_2,amb_turret_sml_t_l_3,amb_turret_sml_t_l_4,amb_turret_sml_t_r_1,amb_turret_sml_t_r_2,amb_turret_sml_t_r_3,amb_turret_sml_t_r_4";
  return var_0;
}

_id_11964() {
  _id_0BB6::_id_39E1();
  var_0 = "cannon_small_ca_mons";
  var_1 = "cannon_missile_ca_hardpoint";
  var_2 = ["amb_missile_l_1", "amb_missile_l_2", "amb_missile_r_1", "amb_missile_r_2"];
  var_3 = "";
  var_3 = var_3 + var_0 + " ";
  self._id_EEF9 = var_3;
  _id_0BB6::_id_39E8();
  thread _id_11963();
}

_id_11963() {
  var_0 = ["amb_turret_sml_l_5", "amb_turret_sml_l_6", "amb_turret_l_1", "amb_turret_l_2", "amb_turret_sml_l_2", "amb_turret_sml_l_3", "amb_turret_sml_l_4", "amb_turret_sml_l_7", "amb_turret_l_3", "amb_turret_l_4", "amb_turret_sml_l_8", "amb_turret_sml_l_10", "amb_turret_l_5", "amb_turret_l_6", "amb_turret_l_4", "amb_turret_sml_l_9", "amb_turret_sml_l_11", "amb_turret_sml_l_12", "amb_turret_l_7", "amb_turret_l_8", "amb_turret_l_9", "amb_turret_sml_l_13"];
  var_1 = ["amb_turret_r_5", "amb_turret_r_6", "amb_turret_sml_r_7", "amb_turret_sml_r_9", "amb_turret_sml_r_10", "amb_turret_r_4", "amb_turret_sml_r_8", "amb_turret_r_3", "amb_turret_r_7", "amb_turret_sml_r_2", "amb_turret_sml_r_3", "amb_turret_r_1", "amb_turret_r_2", "amb_turret_sml_r_4", "amb_turret_r_8", "amb_turret_r_9", "amb_turret_r_10", "amb_turret_r_11", "amb_turret_r_12", "amb_turret_r_13", "amb_turret_r_14", "amb_turret_r_15"];
  var_2 = ["amb_turret_sml_r_11", "amb_turret_sml_r_12", "amb_turret_sml_r_13", "amb_turret_sml_r_14", "amb_turret_sml_r_15", "amb_turret_sml_r_16", "amb_turret_sml_r_17", "amb_turret_sml_r_18"];
  self._id_12A39["one"] = [];
  self._id_12A39["two"] = [];
  self._id_12A39["three"] = [];

  foreach(var_4 in self.turrets) {
    foreach(var_6 in var_4) {
      if(isDefined(var_6)) {
        if(scripts\engine\utility::array_contains(var_0, var_6._id_AD42)) {
          self._id_12A39["one"][self._id_12A39["one"].size] = var_6;
          continue;
        }

        if(scripts\engine\utility::array_contains(var_1, var_6._id_AD42)) {
          self._id_12A39["two"][self._id_12A39["two"].size] = var_6;
          continue;
        }

        if(scripts\engine\utility::array_contains(var_2, var_6._id_AD42))
          self._id_12A39["three"][self._id_12A39["three"].size] = var_6;
      }
    }
  }

  self._id_8B45["left_1"] = [];
  self._id_8B45["left_2"] = [];
  self._id_8B45["left_3"] = [];
  self._id_8B45["left_4"] = [];
  self._id_8B45["right_1"] = [];
  self._id_8B45["right_2"] = [];
  self._id_8B45["right_3"] = [];
  self._id_8B45["right_4"] = [];
  self._id_8B45["center"] = [];
  var_9 = 10;

  foreach(var_11 in self._id_8B4F) {
    foreach(var_13 in var_11) {
      if(isDefined(var_13)) {
        if(scripts\engine\utility::array_contains(self._id_8B46["left_1"], var_13._id_AD42))
          self._id_8B45["left_1"][self._id_8B45["left_1"].size] = var_13;
        else if(scripts\engine\utility::array_contains(self._id_8B46["right_1"], var_13._id_AD42))
          self._id_8B45["right_1"][self._id_8B45["right_1"].size] = var_13;
        else if(scripts\engine\utility::array_contains(self._id_8B46["left_2"], var_13._id_AD42))
          self._id_8B45["left_2"][self._id_8B45["left_2"].size] = var_13;
        else if(scripts\engine\utility::array_contains(self._id_8B46["right_2"], var_13._id_AD42))
          self._id_8B45["right_2"][self._id_8B45["right_2"].size] = var_13;
        else if(scripts\engine\utility::array_contains(self._id_8B46["left_3"], var_13._id_AD42))
          var_13 delete();
        else if(scripts\engine\utility::array_contains(self._id_8B46["right_3"], var_13._id_AD42))
          var_13 delete();
        else if(scripts\engine\utility::array_contains(self._id_8B46["left_4"], var_13._id_AD42))
          self._id_8B45["left_4"][self._id_8B45["left_4"].size] = var_13;
        else if(scripts\engine\utility::array_contains(self._id_8B46["right_4"], var_13._id_AD42))
          self._id_8B45["right_4"][self._id_8B45["right_4"].size] = var_13;
        else if(scripts\engine\utility::array_contains(self._id_8B46["center"], var_13._id_AD42))
          self._id_8B45["center"][self._id_8B45["center"].size] = var_13;

        var_9--;

        if(var_9 <= 0) {
          wait 0.05;
          var_9 = 10;
        }
      }
    }
  }
}

_id_1195E() {
  wait 1.0;
  level._id_6348 thread _id_0BB6::_id_3966(1, 1, level._id_BA43);
  level._id_BA43 thread _id_0BB6::_id_3966(1, 1, level._id_6348);

  foreach(var_1 in level._id_BA43.turrets) {
    foreach(var_3 in var_1) {
      if(isDefined(var_3)) {
        var_3 setbottomarc(15);
        var_3 setleftarc(175);
        var_3 setrightarc(175);
      }
    }
  }
}

_id_1195F() {
  foreach(var_1 in self.turrets) {
    if(isDefined(var_1)) {
      foreach(var_3 in var_1) {
        if(isDefined(var_3))
          var_3 delete();
      }
    }
  }
}

_id_11960() {
  if(isDefined(level._id_EAD6))
    level._id_EAD6 delete();

  if(isDefined(level._id_DE1C))
    level._id_DE1C delete();

  if(isDefined(level._id_DE1F))
    level._id_DE1F delete();
}

_id_11968(var_0) {
  wait(var_0);
  playFXOnTag(scripts\engine\utility::getfx("vfx_titan_mons_hotlanding_wisps_run"), level._id_BA43, "tag_origin");
}

_id_11967() {
  var_0 = [];
  var_1 = scripts\engine\utility::getStructArray("hl_mons_shots_r", "targetname");
  level._id_D2F8 = _id_1079E();

  foreach(var_3 in var_1) {
    var_4 = scripts\engine\utility::spawn_tag_origin(var_3.origin, var_3.angles);
    var_0 = scripts\engine\utility::array_add(var_0, var_4);
  }

  var_0 = scripts\engine\utility::array_combine(var_0, level._id_D2F8);
  var_0 = sortbyhvtkills(var_0);
  scripts\engine\utility::delaythread(3, ::_id_C477);
  level._id_BA43 scripts\sp\vehicle::_id_8441();
  level._id_BA43 _id_0BB8::_id_39D0("idle");
  playFXOnTag(scripts\engine\utility::getfx("vfx_titan_mons_hotlanding_wisps_run"), level._id_BA43, "tag_origin");
  level._id_BA43 _id_BA8D("left");
  level._id_BA43 thread _id_BA8E(var_0, 0.5, undefined, 1000, 500, 0.1);
  wait 0.05;
  thread _id_BABA();
  scripts\engine\utility::flag_wait("hl_mons_flak_right_cleanup");
  var_0 = scripts\engine\utility::array_remove_array(var_0, level._id_D2F8);

  foreach(var_7 in var_0) {
    if(isDefined(var_7))
      var_7 delete();
  }
}

_id_1196A() {
  level notify("ending_dialog_started");
  level.player playRumbleOnEntity("damage_heavy");
  level._id_D127 dodamage(90, level._id_D127.origin);
  _id_D134();
  thread _id_D159();
  earthquake(0.6, 2, level._id_D127.origin, 5000);
  setomnvar("ui_jackal_atmo_launch_damage", 1);
  level.player _meth_8489("body", %jackal_pilot_missle_hit, 0.2, %jackal_vehicle_missle_hit);
}

_id_11966(var_0) {
  for(var_1 = 0; var_1 < var_0; var_1++) {
    var_2 = anglesToForward(self.angles) * 3500;
    var_3 = self.origin + scripts\engine\utility::randomvectorrange(-3, 3) + var_2;
    playFX(scripts\engine\utility::getfx("om_flak_expl"), var_3, anglesToForward(self.angles), anglestoup(self.angles));
    thread scripts\engine\utility::play_sound_in_space("scn_titan_jackal_flak_bursts_plr", var_3);
    wait(randomfloatrange(1.25, 1.75));
  }
}

_id_1196E() {
  return getanimlength(%jackal_pilot_missle_hit) - 0.2;
}

_id_90B7() {
  _id_0BDC::_id_137D6();
  thread _id_D0E0();
  var_0 = scripts\engine\utility::getStruct("ret_hot_landing_starting_spot", "targetname");
  level._id_FD6E._id_E35D.origin = var_0.origin;
  level._id_FD6E._id_E35D.angles = var_0.angles;

  if(!scripts\engine\utility::flag("player_in_control"))
    _id_D25A();

  thread _id_9063();
  var_1 = 16;
  var_2 = scripts\engine\utility::getStruct("ret_hot_landing_final_spot", "targetname");
  level._id_FD6E._id_E35D moveTo(var_2.origin, var_1, var_1 * 0.3, var_1 * 0.3);
  level._id_FD6E._id_E35D rotateTo(var_2.angles, var_1, var_1 * 0.3, var_1 * 0.3);
  thread _id_5402();
  thread _id_90B3();
  _id_482B();
}

_id_90B3() {
  var_0 = [];
  var_1 = scripts\engine\utility::getStructArray("hl_mons_shots_r", "targetname");
  level._id_D2F8 = _id_1079E();

  foreach(var_3 in var_1) {
    var_4 = scripts\engine\utility::spawn_tag_origin(var_3.origin, var_3.angles);
    var_0 = scripts\engine\utility::array_add(var_0, var_4);
  }

  var_0 = scripts\engine\utility::array_combine(var_0, level._id_D2F8);
  var_0 = sortbyhvtkills(var_0);
  level._id_D127 _id_13811(getEnt("trigger_mons_whale_breach", "targetname"));
  thread _id_C477();
  var_6 = getEnt("mons_hot_landing_2", "targetname");
  level._id_BA43 = var_6 scripts\sp\vehicle::_id_1080B();
  level._id_BA43 scripts\sp\vehicle::_id_8441();
  level._id_BA43 _id_0BB8::_id_39D0("idle");
  level._id_BA43 playSound("scn_titan_crashland_mons");
  level._id_BA43 thread scripts\sp\utility::play_loop_sound_on_tag("scn_monsintro_mons_idle_loop_high", "fx_engine_l_1");
  level._id_BA43 thread scripts\sp\utility::play_loop_sound_on_tag("scn_monsintro_mons_lfe_lp", "fx_engine_l_1");
  playFXOnTag(scripts\engine\utility::getfx("vfx_titan_mons_hotlanding_wisps_run"), level._id_BA43, "tag_origin");
  wait 4.0;
  level._id_BA43 _id_BA8D("right");
  level._id_BA43 thread _id_BA8E(var_0, 0.5, undefined, 1000, 500, 0.1);
  scripts\sp\maps\titanjackal\titanjackal_code::_id_A25A("titan_s22_shitmantheresflak");
  wait 0.05;
  thread _id_BABA();
  wait 5;
  scripts\engine\utility::flag_wait("hl_mons_flak_right_cleanup");
  var_0 = scripts\engine\utility::array_remove_array(var_0, level._id_D2F8);

  foreach(var_8 in var_0) {
    if(isDefined(var_8))
      var_8 delete();
  }
}

_id_BABA() {
  if(!isDefined(level._id_DE1F)) {
    return;
  }
  var_0 = "redshirt_2_killed";
  level._id_DE1F._id_843F = 0;
  thread _id_6D43(level._id_BA43._id_871C[0], level._id_DE1F, var_0, 400, 100, 0.1);
  level waittill("redshirt_2_killed");
  scripts\engine\utility::delaythread(0.5, scripts\engine\utility::play_sound_in_space, "jackal_explode", (-72414, 46443, 77013));
  scripts\sp\maps\titanjackal\titanjackal_code::_id_D1D5("titan_plr_22isdown");
}

_id_53F3() {
  level endon("ending_dialog_started");
  wait 0.5;
}

_id_6D43(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = (randomfloatrange(-250, 250), randomfloatrange(-250, 250), randomfloatrange(-250, 250));

  if(!isDefined(var_3))
    var_3 = randomfloatrange(340, 341);

  level._id_11AA9 = var_0 scripts\engine\utility::spawn_tag_origin();
  var_7 = var_0 scripts\engine\utility::spawn_tag_origin();
  level._id_11AA9 thread _id_0B76::_id_A332(var_1, 0, var_7, undefined, var_3, var_6, 0, ["vfx_mons_hl_cannon_impact", "scn_titan_flak_bursts", 5], var_4, 0, var_5, 0);

  if(isDefined(var_2))
    level._id_11AA9 thread _id_B81E(var_2);

  wait 1;

  if(isDefined(var_7))
    var_7 delete();
}

_id_90B4() {
  var_0 = scripts\engine\utility::get_target_ent("hl_crash_origin");
  _id_135E0(30000, var_0);
  level notify("end_mons_guns_shoot");
  var_1 = [];
  var_2 = scripts\engine\utility::getStructArray("hl_mons_shots", "targetname");

  foreach(var_4 in var_2) {
    var_5 = scripts\engine\utility::spawn_tag_origin(var_4.origin, var_4.angles);
    var_1 = scripts\engine\utility::array_add(var_1, var_5);
  }

  var_1 = sortbyhvtkills(var_1);
  level._id_BA43 _id_BA8D("left");
  level._id_BA43 thread _id_BA8E(var_1, 0.7, undefined, 1000, 500, 0.1);
  scripts\engine\utility::flag_set("hl_mons_flak_right_cleanup");
}

_id_D900() {
  _id_0BDC::_id_137CF();

  for(;;) {
    iprintln(length(level._id_D127.spaceship_vel));
    wait 0.5;
  }
}

_id_BA73() {
  for(;;) {
    for(var_0 = 0; var_0 < self._id_871C.size; var_0++)
      scripts\sp\utility::draw_circle(self._id_871C[var_0].origin, 128, (1, 0, 0), 0, 1, 2);

    wait 1.9;
  }
}

_id_1079E() {
  var_0 = [];
  var_0 = scripts\engine\utility::array_add(var_0, (2400, -100, 310));
  var_0 = scripts\engine\utility::array_add(var_0, (2200, 280, 100));
  var_0 = scripts\engine\utility::array_add(var_0, (1450, -330, 30));
  var_0 = scripts\engine\utility::array_add(var_0, (3000, -500, 150));
  var_1 = [];
  var_2 = anglesToForward(level._id_D127.angles);
  var_3 = anglestoright(level._id_D127.angles);
  var_4 = anglestoup(level._id_D127.angles);

  foreach(var_6 in var_0) {
    var_7 = scripts\engine\utility::spawn_tag_origin();
    var_7.origin = level._id_D127.origin + var_2 * var_6[0] + (var_3 * var_6[1] + var_4 * var_6[2]);
    var_7 linkTo(level._id_D127);
    var_1 = scripts\engine\utility::array_add(var_1, var_7);
  }

  return var_1;
}

_id_2F2A() {
  self endon("entitydeleted");

  for(;;)
    wait 0.05;
}

_id_5402() {
  scripts\sp\maps\titanjackal\titanjackal_code::_id_A25A("titan_cmp_boostersdisengaged");
  scripts\sp\maps\titanjackal\titanjackal_code::_id_D1D5("titan_plr_finally");
}

sortbyhvtkills(var_0) {
  var_1 = [];

  for(var_2 = 0; var_0.size > 0; var_2++) {
    var_3 = _id_7F86(var_0);
    var_1[var_2] = var_3;
    var_0 = scripts\engine\utility::array_remove(var_0, var_3);
  }

  return var_1;
}

_id_7F86(var_0) {
  var_1 = 1000000;
  var_2 = undefined;

  foreach(var_4 in var_0) {
    if(var_4.origin[1] < var_1) {
      var_2 = var_4;
      var_1 = var_4.origin[1];
    }
  }

  return var_2;
}

_id_D25A() {
  level._id_D127 _id_13811(getEnt("player_regain_control", "targetname"));
  _id_0BDC::_id_A159(0);
  var_0 = 1;
  level._id_D299._id_AFEB unlink();
  level._id_D299._id_AFEB.origin = level._id_6348.origin;
  _id_0BDC::_id_D165(level._id_D299._id_AFEB, 1, 0, var_0);
  level._id_D127 notify("launch_complete");
  _id_104EF();
  setomnvar("ui_jackal_atmo_launch", 0);
  scripts\sp\utility::_id_2669("launch_complete");
  level notify("player_regain_control");
  level waittill("player_systems_online");
  var_1 = ["titan_cmp_boostersdisengaged", "titan_plr_finally", "titan_slt_reesegetyourass", "titan_slt_gatorspoolupwere", "titan_nav_ayesir"];
  thread scripts\sp\maps\titanjackal\titanjackal_code::_id_48BD(var_1);
  level.player _meth_8489("blendout", %jackal_pilot_destabilized_idle, 0.5, %jackal_vehicle_destabilized_idle);
  _id_0BDC::_id_A153(0);
  _id_0BDC::_id_A386(0);
  _id_0BDC::_id_A155(0);
  level._id_D127 _meth_849F(1);
  setomnvar("ui_jackal_atmo_launch", 0);
  setomnvar("ui_jackal_atmo_launch_damage", 1);
  setomnvar("ui_jackal_autopilot", 0);
  setomnvar("ui_hud_in_space", 1);
}

_id_90B5(var_0) {
  if(!iscinematicplaying())
    _id_BA8F();
}

_id_F9D0() {
  var_0 = "pipeline_";
  var_1 = 1;
  var_2 = var_0 + var_1;

  for(var_3 = scripts\engine\utility::getStruct(var_2, "targetname"); isDefined(var_3); var_3 = scripts\engine\utility::getStruct(var_2, "targetname")) {
    var_3.collision = getEnt(var_2, "targetname");
    var_3._id_D952 = var_3 _id_107CC();
    var_3._id_B4E1 = var_3 _id_7AD2(var_3.script_modelname);
    var_1++;
    var_2 = var_0 + var_1;
  }
}

_id_7AD2(var_0) {
  switch (var_0) {
    case "vfx_destr_titan_fuelline_pipe_small":
      return "vfx_mayh_titan_fuelline_destruction_small";
    case "vfx_destr_titan_fuelline_pipe_mid":
      return "vfx_mayh_titan_fuelline_destruction_mid";
    case "vfx_destr_titan_fuelline_pipe_long":
      return "vfx_mayh_titan_fuelline_destruction_long";
    case "vfx_destr_titan_fuelline_pipe_xl":
      return "vfx_mayh_titan_fuelline_destruction_xl";
    default:
      return undefined;
  }
}

_id_107CC() {
  var_0 = spawn("script_model", self.origin);
  var_0.angles = self.angles;
  var_0 setModel(self.script_modelname);
  return var_0;
}

_id_CBD1() {
  level endon("tower_destroyed");
  var_0 = "pipeline_";
  var_1 = 1;
  var_2 = 0;
  var_3 = 1;
  level._id_1635 = 0;
  setsaveddvar("sm_sunSampleSizeNear", 0.03);
  var_4 = getEntArray("bridge_main_connector_01", "targetname");
  var_5 = getEntArray("bridge_main_connector_shutter", "targetname");
  var_6 = var_0 + var_1;
  var_7 = scripts\engine\utility::getStruct(var_6, "targetname");

  while(isDefined(var_7)) {
    while(level._id_1635 >= 2)
      scripts\engine\utility::waitframe();

    spawnmayhem(var_7.targetname, var_7._id_B4E1, var_7.origin, var_7.angles);
    thread _id_52CE(var_4, var_5, var_7.origin);
    scripts\sp\utility::_id_10FEC("bridge_lights");
    level._id_1635++;
    var_7._id_D952 delete();
    var_7.collision delete();
    thread _id_40A4(var_7);

    if(isDefined(var_7.script_parameters)) {
      var_8 = strtok(var_7.script_parameters, " ");

      foreach(var_10 in var_8)
      scripts\engine\utility::exploder(var_10);
    }

    if(isDefined(var_7._id_ED9E))
      scripts\engine\utility::flag_set(var_7._id_ED9E);

    var_1++;
    var_6 = var_0 + var_1;
    var_7 = scripts\engine\utility::getStruct(var_6, "targetname");

    if(isDefined(var_7)) {
      var_7 _id_D339(var_7, 20000 + var_2, randomfloatrange(0.5, 0.6), 7.5 * var_3);
      var_2 = var_2 + 1000;
      var_3 = var_3 * 0.5;
    }
  }

  wait 0.4;
  scripts\engine\utility::flag_set("flag_pipeline_exploded");
  scripts\sp\utility::_id_2669("tower_destroyed");
}

_id_52CE(var_0, var_1, var_2) {
  var_3 = sortbydistance(var_1, var_2);
  var_4 = sortbydistance(var_0, var_2);
  var_5 = getEnt("bridge_main_connector_shutter_locator_01", "targetname");

  for(var_6 = 0; var_6 < 2; var_6++) {
    var_7 = var_4[var_6];
    var_8 = randomintrange(1, 5);
    var_9 = spawn("script_model", var_7.origin);
    var_9 setModel("bridge_main_connector_01_destroyed_0" + var_8);
    var_9.angles = var_7.angles;
    var_10 = scripts\engine\utility::spawn_tag_origin((0, 0, 0), (0, 0, 0));
    var_10 linkTo(var_9, "bridge_main_connector_01_lod0_destroyed_0" + var_8, (0, 0, 0), var_9.angles);
    var_11 = scripts\engine\utility::getfx("pipe_bridge_main_connector_01");
    playFXOnTag(var_11, var_10, "tag_origin");
    wait 0.2;
    var_7 hide();
    var_12 = distance(var_7.origin, var_5.origin);

    if(var_12 < 3400) {
      for(var_13 = 0; var_13 < 6; var_13++)
        var_3[var_13] hide();
    }
  }

  var_3[0] hide();
  var_3[1] hide();
}

_id_40A4(var_0) {
  wait 1.9;
  killmayhem(var_0.targetname);
  level._id_1635--;
}

_id_D339(var_0, var_1, var_2, var_3) {
  level endon("tower_destroyed");
  var_4 = "crossed_dot";
  self endon(var_4);
  thread _id_11915(var_3, var_4);
  wait(var_2);

  for(;;) {
    var_5 = distance(self.origin, var_0.origin);
    var_6 = distance(level._id_D127.origin, var_0.origin);
    var_7 = var_6 - var_5;

    if(var_7 < var_1) {
      break;
    }

    wait 0.05;
  }
}

_id_11915(var_0, var_1) {
  wait(var_0);
  self notify(var_1);
}

_id_11A57() {
  scripts\engine\utility::exploder("rtd_lf");
  scripts\engine\utility::exploder("rtd_lf2");
  scripts\engine\utility::exploder("tower_vfx_debris_xmodels");
  scripts\engine\utility::exploder("fx_tower_splashes");
  scripts\engine\utility::exploder("fx_tower_ripple");
  scripts\engine\utility::exploder("fx_ship_water_wash");
  scripts\engine\utility::exploder("fx_ship_cloud_entry");
  scripts\sp\utility::_id_10FEC("fx_turbine_fires");
  setsaveddvar("sm_sunSampleSizeNear", 0.03);
  var_0 = scripts\engine\utility::getStruct("tower_explosions", "targetname");
  playworldsound("titan_tower_explosions", var_0.origin);
  wait 0.75;
  level notify("tower_destroyed");
  scripts\engine\utility::flag_set("refinery_tower_destroyed");
  playmayhem("mayhem_titan_tower");
  thread _id_69F0();

  if(!isDefined(level._id_11A6E))
    level._id_11A6E = [];

  level._id_11A6E = scripts\engine\utility::array_add(level._id_11A6E, "mayhem_titan_tower");
  wait 2.5;
  scripts\sp\utility::_id_10FEC("fx_tower_red_beacon");
  scripts\sp\utility::_id_10FEC("fx_splash_field");
}

_id_69F0() {
  wait 1.2;
  setsaveddvar("r_mbRadialOverrideStrength", 0.02);
  setsaveddvar("r_mbRadialOverrideRadius", 0.15);
  setsaveddvar("r_mbRadialOverrideDistortion", 0.05);
  var_0 = 0.1;
  var_1 = 2 - var_0;

  while(var_1 > 0) {
    setsaveddvar("r_mbRadialOverrideStrength", 0.027 * var_1);
    var_1 = var_1 - var_0;
    wait(var_0);
  }

  setsaveddvar("r_mbRadialOverrideStrength", 0.0);
}

_id_90B9() {
  wait 1;
}

_id_2ADE() {
  scripts\sp\utility::_id_A6F2();
  setsaveddvar("bg_cinematicFullScreen", "1");
  setsaveddvar("bg_cinematicCanPause", "1");
  cinematicingame("shipcrib_titan_hot_landing");
  wait 0.1;

  while(iscinematicplaying())
    wait 0.05;

  scripts\sp\utility::_id_BF95();
}

_id_241E() {
  level._id_D127 _id_13811(getEnt("player_enter_clouds", "targetname"));
  thread _id_10286();
  var_0 = scripts\engine\utility::spawn_tag_origin();
  var_1 = anglesToForward(level._id_D127.angles);
  var_2 = level._id_D127.origin;
  var_1 = var_1 * 2000;
  var_0.angles = level._id_D127.angles;
  var_0.origin = var_2 + var_1;
  var_0 linkTo(level._id_D127);
  scripts\engine\utility::exploder("hotlanding_planet");
  level._id_D127 _id_13811(getEnt("player_exit_clouds", "targetname"));
  scripts\sp\utility::_id_241F(0);
  level notify("end_skyblend");
  scripts\sp\utility::_id_10FEC("jackal_cloud_ceiling");
}

_id_10286() {
  visionsetnaked("titan_cloud_fog_lower", 3);
  wait 3;
  getEnt("brushmodel_sky_blend", "targetname") show();
  var_0 = 16.55;
  visionsetnaked("titan_hotlanding_02", var_0);
  wait(var_0);
}

_id_FB8F() {
  wait 0.1;
  level.player notify("plr_flak_damage");
  level.player playSound("scn_titan_jackal_missile_hit_plr_lr");
  level.player scripts\engine\utility::delaycall(1.6, ::playsound, "scn_titan_jackal_canopy_crack");
  level._id_D127 thread _id_FBAA();
  wait 1;
  level.player playSound("scn_titan_jackal_flak_impact");
  level.player scripts\engine\utility::delaycall(2.9, ::playsound, "scn_titan_jackal_canopy_crack_air_leak");
  level.player scripts\engine\utility::delaycall(4.5, ::playsound, "scn_titan_jackal_canopy_crack_spidering_lg_01");
  level.player scripts\engine\utility::delaycall(8.2, ::playsound, "scn_titan_jackal_canopy_crack_spidering_sm_01");
  level.player scripts\engine\utility::delaycall(8.5, ::playsound, "scn_titan_jackal_canopy_crack_spidering_lg_02");
  level.player scripts\engine\utility::delaycall(8.2, ::playsound, "scn_titan_jackal_canopy_crack_spidering_sm_02");
  thread _id_FB57();
}

_id_FBAA() {
  var_0 = spawn("script_origin", self.origin);
  var_0 linkTo(self);
  var_0 playLoopSound("scn_titan_jackal_alarm_damaged");
  wait 5;
  var_0 stoploopsound("scn_titan_jackal_alarm_damaged");
  var_0 playLoopSound("scn_titan_jackal_alarm_severe");
  level.player waittill("canopy_off");
  wait 0.1;
  var_0 scripts\sp\utility::_id_10460(2.5, 1);
}

_id_FB57() {
  level.player waittill("canopy_off");
  level.player playSound("scn_titan_jackal_canopy_eject_lr");
  scripts\engine\utility::delaythread(1.25, ::_id_FBB8);
  wait 2.2;
  level.player playSound("scn_titan_jackal_canopy_ethan_grab_lr");
}

_id_FB84() {
  level.player waittill("mons_ftl");
  var_0 = spawn("script_origin", level.player.origin);
  var_0 linkTo(level.player);
  wait 3;
  level.player playSound("scn_titan_suit_air_leak");
  var_0 thread _id_FB47();
  wait 12;
  level.player notify("o2_lvl_2");
  wait 17.5;
  level.player notify("o2_lvl_3");
  wait 21.9;
  level.player notify("o2_lvl_4");
}

_id_FB47() {
  scripts\sp\utility::_id_10461("plr_helmet_o2_level_ok_lp", 1, 2, 1);
  wait 2.2;
  level.player thread scripts\sp\utility::_id_10350("titan_cmp_oxygendepleted");
  scripts\engine\utility::delaythread(6.4, scripts\engine\utility::play_sound_in_space, "scn_titan_plr_last_breaths", level.player.origin);
  level.player waittill("o2_lvl_2");
  self stoploopsound();
  self playLoopSound("plr_helmet_o2_level_low_lp");
  thread scripts\sp\utility::_id_10350("titan_cmp_oxygendepleted");
  level.player waittill("o2_lvl_3");
  self stoploopsound();
  self playLoopSound("plr_helmet_o2_level_critical_lp");
  thread scripts\sp\utility::_id_10350("titan_cmp_oxygenlevelcrit");
  level.player waittill("o2_lvl_4");
  thread scripts\sp\utility::_id_10350("titan_cmp_oxygenlevelcrit");
  wait 0.5;
  level.player playSound("scn_titan_suit_drone_lr");
  level waittill("notify_player_fade_out");
  scripts\sp\utility::_id_10460(10);
}

_id_FBB8() {
  level.player playSound("scn_titan_jackal_helmet_boot_up_lr");
  scripts\sp\maps\titanjackal\titanjackal_code::_id_A25A("titan_cmp_lmasystemson");
}

_id_25C4() {
  level.player waittill("mons_surfacing");
  level.player waittill("plr_flak_damage");
  level.player _meth_82C0("titanjackal_flak", 2);
  wait 1;
  level.player waittill("canopy_off");
  setglobalsoundcontext("atmosphere", "space", 2);
  setmusicstate("");
  wait 0.2;
  level.player _meth_82C0("titanjackal_eject", 1);
  level.player waittill("plr_jackal_crash");
  setmusicstate("mx_325_finalscene");
  level.player _meth_82C0("titanjackal_space_float", 2);
  level.player waittill("mons_ftl");
  wait 3;
  level waittill("notify_player_fade_out");
  level.player _meth_82C0("titanjackal_fade_to_black", 9);
  level.player waittill("dof_fun_clear");
  setmusicstate("mx_325_finalscene");
  level.player playSound("scn_titan_blackout");
}