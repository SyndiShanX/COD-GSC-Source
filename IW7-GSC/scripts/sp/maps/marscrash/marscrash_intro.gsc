/*********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\marscrash\marscrash_intro.gsc
*********************************************************/

_id_9AF2() {
  scripts\engine\utility::flag_init("begin_dropship_bink");
  scripts\engine\utility::flag_init("dropship_bink_finished");
  scripts\engine\utility::flag_init("pause_dynamic_dof");
  scripts\engine\utility::flag_init("player_hands_up");
  scripts\engine\utility::flag_init("player_exiting_crashed_jackal");
  scripts\engine\utility::flag_init("player_exited_crashed_jackal");
  scripts\engine\utility::flag_init("level_fade_in");
  scripts\engine\utility::flag_init("o2_start");
  scripts\engine\utility::flag_init("o2_level1_finished");
  scripts\engine\utility::flag_init("o2_level2_finished");
  scripts\engine\utility::flag_init("o2_level3_finished");
  scripts\engine\utility::flag_init("o2_level4_finished");
  scripts\engine\utility::flag_init("oxygen_grab_started");
  scripts\engine\utility::flag_init("oxygen_grab");
  scripts\engine\utility::flag_init("player_out_safe");
  scripts\engine\utility::flag_init("max_heat_threshold");
  scripts\engine\utility::flag_init("disable_meter");
  scripts\engine\utility::flag_init("temp_alert_played");
  scripts\engine\utility::flag_init("pressure_applied");
  scripts\engine\utility::flag_init("kash_heart_stop");
  scripts\engine\utility::flag_init("debris_lift_started");
  scripts\engine\utility::flag_init("time_to_die");
  scripts\engine\utility::flag_init("close_enough_to_interact");
  scripts\engine\utility::flag_init("safe_to_talk");
  scripts\engine\utility::flag_init("flag_mons_crashed");
  scripts\engine\utility::flag_init("post_mons_crash_dialog");
  scripts\engine\utility::flag_init("dropship_triage_callout");
  scripts\engine\utility::flag_init("kashima_is_dead");
  scripts\engine\utility::flag_init("level_change");
  scripts\engine\utility::flag_init("mons_crash_dialogue_done");
}

_id_9ACD() {
  scripts\sp\maps\marsbase\marsbase_sky_cowbell::_id_1DF2();
  precacheitem("iw7_gunlessinjured");
  var_0 = ["veh_mil_air_un_dropship_hero_wing_right_dmg", "veh_mil_air_un_dropship_hero_wing_left_dmg", "veh_mil_air_un_dropship_hero_cockpit_dmg", "veh_mil_air_un_dropship_hero_body_dmg", "veh_mil_air_un_dropship_hero_interior_dmg", "veh_mil_air_un_dropship_hero_door_right_dmg", "veh_mil_air_un_dropship_hero_door_left_dmg", "veh_mil_air_un_dropship_hero_side_piece_dmg", "veh_mil_air_un_dropship_hero_door_rear_dmg", "veh_mil_air_un_dropship_hero_tail_dmg", "airplane_debris_destroyed_03", "vm_hero_protagonist_arms_blood", "vm_hero_protagonist_arms"];

  foreach(var_2 in var_0) {
    precachemodel(var_2);
  }

  precacherumble("mars_kashima_grab_arm");
  precacheshader("hud_jackal_overlay_damage");
  scripts\sp\utility::_id_16EB("kashima_pressure", &"MARSCRASH_BOTH_TRIGS", ::_id_A549);
  precachestring(&"MARSCRASH_BOTH_TRIGS");
  precachestring(&"MARSCRASH_BOTH_STICKS");
  precachestring(&"MARSCRASH_GRAB_CANOPY");
  precachestring(&"MARSCRASH_OPEN_CANOPY");
  precachestring(&"MARSCRASH_GRAB_DEBRIS");
  precachestring(&"MARSCRASH_LIFT_DEBRIS");
}

_id_A549() {
  return scripts\engine\utility::flag("pressure_applied");
}

_id_FA12() {
  wait 0.1;
  level.player scripts\sp\utility::_id_11428();
  var_0 = "iw7_gunlessinjured";
  level.player giveweapon(var_0);
  level.player switchtoweaponimmediate(var_0);
  level.player allowdoublejump(0);
  level.player allowads(0);
  level.player setviewmodel("vm_hero_protagonist_arms");
  setsaveddvar("player_sprintspeedscale", 1.1);
}

_id_FA16(var_0) {
  level.player _meth_80D8(20, 20);
  level.player shellshock("player_limp", 1000000);
  level.player allowjump(0);
  level.player allowmantle(0);
  level.player allowcrouch(0);
  level.player allowprone(0);
  setsaveddvar("player_viewmodelMoveAnimScale", 0.4);

  if(isDefined(var_0)) {
    thread _id_5F7D();
  }
}

_id_FA15(var_0) {
  level.player _meth_80A6();
  level.player allowjump(0);
  level.player allowmantle(0);
  level.player scripts\engine\utility::allow_doublejump(0);
  level.player allowsprint(1);
  level.player allowcrouch(1);
  level.player allowprone(1);
  setsaveddvar("player_viewmodelMoveAnimScale", 0.6);

  if(isDefined(var_0)) {
    var_1 = level._id_D2D0;
  } else {
    var_1 = 50;
  }

  while(var_1 <= 50) {
    level.player thread scripts\sp\utility::_id_D2CD(50, 2);
    var_1++;
    wait 0.5;
  }
}

_id_D85C() {
  level.player setstance("stand");
}

_id_DF3E() {
  level.player unlink();
}

_id_CD7E(var_0, var_1, var_2) {
  var_3 = scripts\engine\utility::spawn_tag_origin();
  var_3 endon("death");
  thread scripts\engine\utility::delete_on_death(var_3);
  var_3.origin = self.origin;
  var_3.angles = self.angles;
  var_3 linkTo(self, "tag_origin", (0, 0, 0), (0, 0, 0));
  var_3 playLoopSound(var_0);
  wait(var_1);
  var_3 _meth_8278(0, var_2);
  wait(var_2);
  var_3 delete();
}

_id_5F7D(var_0) {
  level endon("stop_dynamic_dof");
  var_1 = 2;
  level._id_B439 = 200;

  if(!isDefined(var_0)) {
    var_0 = 5;
  }

  for(;;) {
    while(scripts\engine\utility::flag("pause_dynamic_dof")) {
      wait 0.05;
    }

    var_2 = anglesToForward(level.player getplayerangles());
    var_3 = level.player getEye() + var_2 * 20;
    var_4 = level.player getEye() + var_2 * 10000;
    var_5 = scripts\common\trace::ray_trace(var_3, var_4, level.player);
    var_6 = distance2d(level.player.origin, var_5["position"]);
    var_7 = scripts\engine\utility::ter_op(var_6 < level._id_B439, var_6, level._id_B439);
    thread _id_0B0A::_id_583F(0, var_0, 2, var_7, var_7 + 500, 2, var_1);
    _id_5F7E(var_1);
  }
}

_id_1017E() {
  level notify("stop_dynamic_dof");
  _id_0B0A::_id_583D(1);
  scripts\engine\utility::flag_clear("pause_dynamic_dof");
}

_id_5F7E(var_0) {
  level endon("pause_dynamic_dof");
  wait(var_0);
}

_id_481B() {
  level thread crash_transients();
}

crash_transients() {
  scripts\sp\utility::_id_13705();
  scripts\sp\utility::_id_12641("marscrash_prime_tr");
}

_id_4816() {
  setomnvar("ui_hide_hud", 1);
  thread _id_FA12();
  thread _id_FA16();
  thread _id_4814();
  thread _id_4813();
  thread _id_480B();
  thread scripts\sp\maps\marsbase\marsbase_sky_cowbell::_id_1DC7("ambient_crash_start", "stop_ambient_jackals", "friendly", 30);
  thread scripts\sp\maps\marsbase\marsbase_sky_cowbell::_id_A136();
  thread scripts\sp\maps\marsbase\marsbase_sky_cowbell::_id_1DC7("ambient_jackal_paths_near", "stop_ambient_jackals_near", "friendly", 60);
  thread scripts\sp\maps\marsbase\marsbase_sky_cowbell::_id_1DC7("ambient_jackal_paths_far", "stop_ambient_jackals_far", "enemy_chase_friendly", 10);
  thread _id_6086();
  setblur(10, 0.05);
  thread scripts\sp\maps\marscrash\marscrash_util::_id_1069C("sp_dead_bodies");

  if(scripts\sp\utility::_id_93A6()) {
    scripts\sp\specialist_MAYBE::_id_F3FF(1);
    scripts\sp\specialist_MAYBE::_id_4CFB(0, 0);
    scripts\sp\specialist_MAYBE::_id_4CFB(0, 0);
  }

  scripts\engine\utility::flag_wait("player_exited_crashed_jackal");
}

_id_47F7() {
  thread _id_FA12();
  thread scripts\sp\maps\marscrash\marscrash_util::_id_1069C("sp_dead_bodies");
  level._id_126B1 = scripts\engine\utility::getStruct("player_climbout_anim", "targetname");
  level._id_126B1._id_A056 = scripts\sp\utility::_id_10639("player_crashed_jackal", level._id_126B1.origin, level._id_126B1.angles);
  level._id_126B1._id_A056 _id_0BDC::_id_A226();
  level._id_126B1._id_A056 _id_B3AD();
  level._id_126B1 thread scripts\sp\anim::_id_1F35(level._id_126B1._id_A056, "intro_climbout_exit");
  level thread _id_480B();
  thread scripts\sp\maps\marsbase\marsbase_sky_cowbell::_id_1DC7("ambient_crash_start", "stop_ambient_jackals", "friendly", 30);
  thread scripts\sp\maps\marsbase\marsbase_sky_cowbell::_id_A136();
  thread scripts\sp\maps\marsbase\marsbase_sky_cowbell::_id_1DC7("ambient_jackal_paths_near", "stop_ambient_jackals_near", "friendly", 60);
  thread scripts\sp\maps\marsbase\marsbase_sky_cowbell::_id_1DC7("ambient_jackal_paths_far", "stop_ambient_jackals_far", "enemy_chase_friendly", 10);
  thread _id_6086();

  if(scripts\sp\utility::_id_93A6()) {
    scripts\sp\specialist_MAYBE::_id_F3FF(1);
    scripts\sp\specialist_MAYBE::_id_4CFB(0, 0, 0);
    scripts\sp\specialist_MAYBE::_id_4CFB(0, 0, 0);
  }
}

_id_4814() {
  level.player scripts\engine\utility::delaythread(1.25, scripts\sp\utility::_id_1034D, "marscrash_plr_crashwake");
  level.player thread _id_CD7E("flashbang_tinnitus_loop", 3, 4);
  level.player thread _id_B38A();
  level._id_6ABB = scripts\sp\hud_util::_id_7B4F();
  level._id_6ABB.alpha = 1;

  if(scripts\sp\utility::_id_93A6()) {
    level._id_6ABB.sort = 2;
  }

  level thread _id_4817();
  scripts\engine\utility::flag_set("o2_start");
  thread _id_81D0();
  wait 1;
  setmusicstate("mx_182_marscrash_levelstart");
  wait 2.0;
  scripts\engine\utility::flag_set("level_fade_in");
  level._id_6ABB fadeovertime(10);
  level._id_6ABB.alpha = 0;
  var_0 = scripts\sp\vehicle::_id_1080C("crashing_jackal");
  var_0 thread _id_0BDC::_id_A373("intro_jackal_crash", 500);
  var_0 scripts\engine\utility::delaythread(4.2, _id_0C24::_id_0118);
  wait 10;
  level._id_6ABB destroy();
}

_id_4817() {
  wait 2;
  var_0 = spawn("script_origin", (-47565, -9883, -14200));
  var_1 = spawn("script_origin", (-47569, -9890, -14214));
  var_0 playLoopSound("mars_player_ship_alarm_1", 1);
  var_1 playLoopSound("mars_player_ship_alarm_2", 1);
  level.player scripts\engine\utility::waittill_any("temperature_sfx_cooldown", "death");

  if(isalive(level.player)) {
    var_0 scripts\sp\utility::_id_10460(3, 1);
    var_1 scripts\sp\utility::_id_10460(3, 1);
  } else {
    var_0 stoploopsound();
    var_1 stoploopsound();
    var_0 delete();
    var_1 delete();
  }
}

_id_B38A() {
  level.player setsoundsubmix("mars_crash_intro");
  level waittill("trapped_done");
  level.player clearsoundsubmix();
}

_id_A29D() {
  var_0 = scripts\sp\vehicle::_id_1080C("crashing_jackal");
  var_0._id_2714 = 1;
  var_1 = var_0 _id_0BDC::_id_A372("intro_jackal_crash_2");
  var_0 thread _id_0BDC::_id_A1EF(var_1, 300, 64);
  var_0 scripts\sp\utility::_id_135F1("scripted_explode", 5);
  playFX(scripts\engine\utility::getfx("vfx_jackal_explode"), var_0.origin, anglesToForward(var_0.angles), anglestoup(var_0.angles));
  var_0 playSound("jackal_mars_explode");
  earthquake(0.25, 1, var_0.origin, 1000);
  wait 0.5;
  var_0 thread scripts\sp\maps\marsbase\marsbase_sky_cowbell::_id_A12F();
}

_id_B3AD() {
  var_0 = _id_0A2F::_id_D9FB();
  self._id_4F5E = spawn("script_model", self.origin);
  self._id_4F5E setModel(var_0);
  self._id_4F5E linkTo(self, "tag_body", (0, 0, 0), (0, 0, 0));
}

_id_4813() {
  level.player setviewmodel("vm_hero_protagonist_arms");
  level.player freezecontrols(1);
  level.player allowmelee(0);
  thread _id_5F7D(1000);
  level._id_126B1 = scripts\engine\utility::getStruct("player_climbout_anim", "targetname");
  level._id_126B1.player = scripts\sp\utility::_id_10639("player_rig", level._id_126B1.origin, level._id_126B1.angles);
  level._id_126B1._id_A056 = scripts\sp\utility::_id_10639("player_crashed_jackal", level._id_126B1.origin, level._id_126B1.angles);
  level._id_D127 = level._id_126B1._id_A056;
  level._id_D127 _id_B3AD();
  level._id_D127 _id_0BDC::_id_A110();
  level._id_D127 scripts\engine\utility::delaythread(0.2, _id_0BDC::_id_A10D, "damage_alarm");

  if(!scripts\sp\utility::_id_93A6()) {
    level._id_D127 scripts\engine\utility::delaythread(2, _id_0BDC::_id_A112, "jackal_hud_warningcritical", 2);
  }

  level.player _id_D85C();
  var_0 = 2;
  level.player freezecontrols(0);
  var_1 = spawn("script_model", level.player.origin);
  var_1.angles = level.player.angles;
  var_1 linkTo(level._id_126B1.player, "tag_player");
  level.player setworldupreference(var_1);
  level.player _meth_823C(level._id_126B1.player, "tag_player", 0);
  thread _id_D0A3();
  level._id_126B1 thread scripts\sp\anim::_id_1EC3(level._id_126B1._id_A056, "intro_climbout_exit");
  level._id_126B1 scripts\sp\anim::_id_1F35(level._id_126B1.player, "intro_climbout_start");
  level._id_126B1 thread scripts\sp\anim::_id_1EEA(level._id_126B1.player, "intro_climbout_idle");
  level.player playerlinktodelta(level._id_126B1.player, "tag_player", 1, 5, 5, 10, 15, 1);
  level notify("stop_player_glitch_hud");
  wait 1;
  level._id_99FD = scripts\engine\utility::getStruct("canopy_grab", "targetname");
  level._id_99FD.origin = level._id_99FD.origin + (10, -10, 0);
  level.player notifyonplayercommand("bash_pressed", "+usereload");
  level.player notifyonplayercommand("bash_pressed", "+activate");
  level._id_99FD _id_0E46::_id_48C4(undefined, undefined, &"MARSCRASH_OPEN_CANOPY", undefined, 256, 256, undefined, 1);
  level.player waittill("bash_pressed");
  scripts\engine\utility::flag_set("player_hands_up");
  level.player playSound("mars_canopy_stress_lr");
  level thread _id_A29D();
  level._id_126B1 notify("stop_loop");
  level._id_126B1 scripts\sp\anim::_id_1F35(level._id_126B1.player, "intro_climbout_canopy");
  level._id_126B1 thread scripts\sp\anim::_id_1EEA(level._id_126B1.player, "intro_climbout_canopy_idle");
  scripts\engine\utility::delaythread(1, ::_id_1017E);
  thread _id_126B5();
  level waittill("trapped_done");
  level._id_6D3E = 0;
  scripts\sp\utility::_id_D020();
  level._id_126B8 thread scripts\sp\utility::_id_E7C7(0.25);
  level._id_99FD _id_0E46::_id_DFE3();
  level.player playSound("mars_canopy_open_lr");
  scripts\engine\utility::flag_set("player_exiting_crashed_jackal");
  scripts\engine\utility::flag_set("oxygen_grab_started");

  if(isDefined(level.player._id_FB50)) {
    level.player._id_FB50 delete();
  }

  thread _id_E393();
  level._id_126B1 notify("stop_loop");
  level.player setworldupreference(undefined);
  var_1 delete();
  thread _id_761D();
  thread _id_CFCB();
  thread _id_D217();
  level._id_126B1 thread scripts\sp\anim::_id_1F35(level._id_126B1._id_A056, "intro_climbout_exit");
  level._id_126B1 scripts\sp\anim::_id_1F35(level._id_126B1.player, "intro_climbout_exit");
  level._id_126B1.player delete();
  level.player _id_DF3E();
  scripts\sp\utility::_id_16AE(level._id_126B1._id_A056, "intro_cleanup_ents");
  level.player allowmelee(1);
  thread _id_9ACB();
  scripts\engine\utility::flag_set("player_exited_crashed_jackal");
}

_id_BC38(var_0) {
  wait 0.1;
  var_0 _id_0E46::_id_DFE3();
  var_0.origin = var_0.origin + (0, 10, 0);
  var_0 _id_0E46::_id_48C4(undefined, undefined, &"MARSCRASH_OPEN_CANOPY", undefined, 256, 256, undefined, 1);
}

_id_D072() {
  var_0 = scripts\engine\utility::getStruct("canopy_grab", "targetname");
  var_1 = scripts\engine\utility::spawn_tag_origin(var_0.origin + (-30, 15, -30), var_0.angles);
  var_2 = var_1.origin;
  playFXOnTag(scripts\engine\utility::getfx("vfx_mars_fire_crash_site_sm_nosmoke"), var_1, "tag_origin");
  wait 5;
  var_1 movez(30, 10);
  wait 5;
  level waittill("trapped_done");
  stopFXOnTag(scripts\engine\utility::getfx("vfx_mars_fire_crash_site_sm_nosmoke"), var_1, "tag_origin");
  wait 2;
  var_1 moveTo(var_2, 0.05);
  playFXOnTag(scripts\engine\utility::getfx("vfx_mars_fire_crash_site_sm_nosmoke"), var_1, "tag_origin");
}

_id_FC25() {
  level.player endon("death");
  var_0 = spawn("script_origin", level.player.origin);
  var_0 playSound("mars_crash_cockpit_temperature_warning");
  level.player waittill("temperature_sfx_cooldown");
  wait 2.5;
  var_0 stopsounds();

  if(isalive(level.player)) {
    var_0 playLoopSound("mars_crash_cockpit_temperature_warning_med_lp");
    var_0 scripts\engine\utility::delaycall(4, ::_meth_8278, 0.2, 8);
  }

  level.player waittill("stop_temperature_sfx");
  var_0 stopsounds();
  var_0 delete();
  level.player playSound("mars_crash_cockpit_temperature_warning_end");
}

_id_81D0() {
  thread _id_B441();
  thread _id_D072();
  wait 5;
  level._id_6D3E = 1;
  var_0 = undefined;
  var_1 = 200;
  var_2 = 1;
  var_3 = 400;
  var_0 = undefined;
  thread _id_6F0B();
  thread _id_FC25();

  while(level._id_6D3E && isalive(level.player)) {
    wait 0.05;
    var_1 = var_1 + var_2;
    var_1 = clamp(var_1, 0, var_3);

    if(var_1 == var_3) {
      scripts\engine\utility::flag_set("max_heat_threshold");
    }

    level.player setclientomnvar("ui_helmet_meter_temperature", var_1);
  }

  var_2 = -4;
  wait 0.2;
  level.player notify("temperature_sfx_cooldown");

  while(!level._id_6D3E && isalive(level.player) && var_1 >= 30) {
    wait 0.15;
    var_1 = var_1 + var_2;
    var_1 = clamp(var_1, 0, var_3);
    level.player setclientomnvar("ui_helmet_meter_temperature", var_1);
  }

  wait 0.5;
  level.player setclientomnvar("ui_show_temperature_gauge", 0);
  level.player notify("stop_temperature_sfx");
  var_1 = 20;
  level.player setclientomnvar("ui_helmet_meter_temperature", var_1);
}

_id_6F0B() {
  wait 2;
  setomnvar("ui_hide_hud", 0);
  level.player setclientomnvar("ui_show_temperature_gauge", 1);
  _id_E7F6(6);
  wait 1;
  _id_E7F6(6);
}

_id_E7F6(var_0) {
  for(var_1 = 0; var_1 < var_0; var_1++) {
    wait 0.05;
    setomnvar("ui_hide_hud", 1);
    wait 0.05;
    setomnvar("ui_hide_hud", 0);
  }
}

_id_B441() {
  scripts\engine\utility::flag_wait("max_heat_threshold");
  wait 3.5;

  if(!scripts\engine\utility::flag("player_out_safe") && level._id_6D3E == 1) {
    scripts\engine\utility::waitframe();
    level._id_126B1 notify("stop_loop");
    scripts\engine\utility::flag_set("time_to_die");
    wait 0.15;
    level.player thread scripts\sp\utility::_id_1034D("marscrash_plr_burnedtodeath");

    if(isDefined(level._id_126B8)) {
      level._id_126B8 thread scripts\sp\utility::_id_E7C7(0.25);
    }

    level._id_99FD _id_0E46::_id_DFE3();

    if(scripts\engine\utility::flag("player_hands_up")) {
      level._id_126B1 thread scripts\sp\anim::_id_1F35(level._id_126B1.player, "intro_climbout_canopy_death");
      wait 1;
    }

    wait 1;
    level._id_6ABB = scripts\sp\hud_util::_id_7B4F("black");
    level._id_6ABB.alpha = 0;
    level._id_6ABB fadeovertime(3);
    level._id_6ABB.alpha = 1;
    setomnvar("ui_hide_hud", 1);
    wait 4.5;
    level.player _meth_81D0();
    return;
  }
}

_id_D217() {
  scripts\engine\utility::flag_set("player_out_safe");
  wait 10;
  scripts\engine\utility::flag_set("disable_meter");
}

_id_761D() {
  wait 1;
  var_0 = getEnt("fxanim_sp_mars_rock_debris_cockpit", "targetname");
  var_0 scripts\sp\utility::_id_23B7("cockpit_rocks");
  var_0 scripts\sp\anim::_id_1F35(var_0, "fxanim_cockpit_rocks");
}

_id_D0A3() {
  var_0 = 0.4;
  level.player _meth_809A(var_0, 1);
  level.player thread _id_D0A4();
  level scripts\sp\utility::_id_135F1("stop_player_glitch_hud", 10);

  while(var_0 > 0) {
    var_0 = var_0 - 0.05;

    if(var_0 < 0) {
      var_0 = 0;
    }

    level.player _meth_809A(var_0, 1);
    wait 0.15;
  }

  level.player _meth_809A(0, 1);
}

_id_D0A4() {
  var_0 = spawn("script_origin", level.player.origin);
  var_0 playSound("cockpit_hud_glitch", "snd_done");
  var_0 waittill("snd_done");
  var_0 delete();
}

_id_CFCB() {
  wait 4.5;
  level.player thread _id_C876(3);
  thread _id_5F7D(1000);
  scripts\engine\utility::delaythread(6.5, ::_id_1017E);
}

_id_480B() {
  var_0 = getEntArray("fxanim_wires_hanging_01", "targetname");
  var_1 = getEntArray("fxanim_wires_hanging_02", "targetname");
  var_2 = scripts\engine\utility::array_combine(var_0, var_1);
  var_3 = getEntArray("fxanim_wires_hanging_03", "targetname");
  var_2 = scripts\engine\utility::array_combine(var_2, var_3);
  thread scripts\engine\utility::array_thread_safe(var_2, ::_id_10D5E, randomfloatrange(0.25, 1), "wires", "wires_hanging");
  wait(randomfloatrange(0.1, 0.5));
  var_4 = getEntArray("fxanim_gp_wire_sparking_ground_01", "targetname");
  var_5 = getEntArray("fxanim_gp_wire_sparking_sml", "targetname");
  var_6 = getEntArray("fxanim_gp_wire_sparking_med_thick", "targetname");
  var_7 = getEntArray("fxanim_wires_crash_site", "targetname");
  thread scripts\engine\utility::array_thread_safe(var_4, ::_id_10D5E, randomfloatrange(0.25, 1), "wires", "wires_ground");
  wait(randomfloatrange(0.1, 0.5));
  thread scripts\engine\utility::array_thread_safe(var_5, ::_id_10D5E, randomfloatrange(0.25, 1), "wires", "wires_small");
  wait(randomfloatrange(0.1, 0.5));
  thread scripts\engine\utility::array_thread_safe(var_6, ::_id_10D5E, randomfloatrange(0.25, 1), "wires", "wires_thick");
  wait(randomfloatrange(0.1, 0.5));
  thread scripts\engine\utility::array_thread_safe(var_7, ::_id_10D5E, randomfloatrange(0.25, 1), "wires", "wires_crash_site");
}

_id_10D5E(var_0, var_1) {
  scripts\sp\utility::_id_23B7(var_0);
  thread scripts\sp\anim::_id_1EEA(self, var_1);
}

_id_6086() {
  var_0 = scripts\engine\utility::getStruct("s_elevator_start", "targetname");
  var_1 = scripts\engine\utility::getStruct("s_elevator_end", "targetname");
  var_2 = getEnt("marscrash_elevator_carriage", "targetname");
  var_3 = var_2 scripts\engine\utility::spawn_tag_origin();
  var_2 delete();
  var_4 = scripts\engine\utility::getStructArray("s_elevator_carriage_fx_top", "targetname");
  var_5 = scripts\engine\utility::getStructArray("s_elevator_carriage_fx_bottom", "targetname");
  var_6 = scripts\engine\utility::getStructArray("s_elevator_carriage_fx_corner_top", "targetname");
  var_7 = scripts\engine\utility::getStructArray("s_elevator_carriage_fx_corner_bottom", "targetname");

  foreach(var_9 in var_4) {
    var_10 = scripts\engine\utility::spawn_tag_origin(var_9.origin, var_9.angles);
    playFXOnTag(scripts\engine\utility::getfx("vfx_mars_light_glow_blue_elevator_vista"), var_10, "tag_origin");
    var_10 linkTo(var_3);
  }

  for(;;) {
    var_3 hide();
    var_3.origin = var_0.origin;
    scripts\engine\utility::waitframe();
    var_3 moveTo(var_1.origin, 60, 15);
    var_3 waittill("movedone");
  }
}

_id_126B5() {
  level endon("trapped_done");
  level._id_126B9 = "idle";
  level._id_126B3 = 0;
  level._id_126B8 = scripts\sp\utility::_id_7C23();
  level._id_126B8 scripts\sp\utility::_id_F581(0);
  level._id_126BA = 0;
  thread _id_126B4();
  thread _id_126BB();

  for(;;) {
    if(level._id_126B3 && !scripts\engine\utility::flag("time_to_die")) {
      _id_126B6();
    } else if(level._id_126B9 != "idle" && !scripts\engine\utility::flag("time_to_die")) {
      _id_126B7();
    }

    wait 0.05;
  }
}

_id_126BB() {
  level endon("trapped_done");

  for(;;) {
    if(level._id_126B9 == "idle" && !scripts\engine\utility::flag("time_to_die")) {
      level._id_126BA = 0;
    } else if(level._id_126B9 == "pushing" && !scripts\engine\utility::flag("time_to_die")) {
      level._id_126BA++;
    } else if(level._id_126B9 == "releasing" && !scripts\engine\utility::flag("time_to_die")) {
      if(level._id_126BA > 5) {
        level._id_126BA = level._id_126BA - 5;
      } else {
        level._id_126BA = 0;
      }
    }

    wait 0.05;
  }
}

_id_126B6() {
  level endon("trapped_done");

  if(level._id_126B9 == "idle" && !scripts\engine\utility::flag("time_to_die")) {
    level._id_126B1 notify("stop_loop");
    level._id_126B1 thread scripts\sp\anim::_id_1EEA(level._id_126B1.player, "intro_climbout_canopy_push");
    level._id_126B8 thread scripts\sp\utility::_id_E7C8(0.25);
    level._id_126B9 = "pushing";
  } else if(level._id_126B9 == "pushing" && !scripts\engine\utility::flag("time_to_die")) {
    if(level._id_126BA >= 50) {
      level notify("trapped_done");
    } else if(level._id_126BA < 50) {
      level._id_126B8 thread scripts\sp\utility::_id_E7C9(1.0, 2.5);
      screenshake(level.player.origin, 0.4, 0, 0, 0.5, -1, 0, 0, 6);
    } else if(level._id_126BA < 25) {
      level._id_126B8 thread scripts\sp\utility::_id_E7C9(0.5, 2.5);
      screenshake(level.player.origin, 0.2, 0, 0, 0.5, -1, 0, 0, 3);
    }
  } else if(level._id_126B9 == "releasing" && !scripts\engine\utility::flag("time_to_die")) {
    level._id_126B1 notify("stop_loop");
    level._id_126B1 thread scripts\sp\anim::_id_1EEA(level._id_126B1.player, "intro_climbout_canopy_push");
    level._id_126B9 = "pushing";
  }
}

_id_126B7() {
  level endon("trapped_done");

  if(level._id_126B9 == "releasing") {
    if(level._id_126BA <= 0) {
      level._id_126B8 thread scripts\sp\utility::_id_E7C7(0.25);
      level._id_126B1 notify("stop_loop");
      level._id_126B1 thread scripts\sp\anim::_id_1EEA(level._id_126B1.player, "intro_climbout_canopy_idle");
      level._id_126B9 = "idle";
    } else if(level._id_126BA <= 50) {
      level._id_126B8 thread scripts\sp\utility::_id_E7C9(0.5, 2.5);
      screenshake(level.player.origin, 0.4, 0, 0, 0.5, -1, 0, 0, 6);
    } else if(level._id_126BA <= 100) {
      level._id_126B8 thread scripts\sp\utility::_id_E7C9(1.0, 2.5);
      screenshake(level.player.origin, 0.6, 0, 0, 0.5, -1, 0, 0, 12);
    }
  } else if(level._id_126B9 == "pushing") {
    level._id_126B1 notify("stop_loop");
    level.player playSound("mars_crash_cockpit_release_f");
    level._id_126B1 thread scripts\sp\anim::_id_1EEA(level._id_126B1.player, "intro_climbout_canopy_idle");
    level._id_126B9 = "releasing";
  }
}

_id_126B4() {
  level endon("trapped_done");
  level.player notifyonplayercommand("bash_pressed", "+usereload");
  level.player notifyonplayercommand("bash_pressed", "+activate");

  for(;;) {
    var_0 = level.player scripts\engine\utility::waittill_notify_or_timeout_return("bash_pressed", 0.75);

    if(isDefined(var_0)) {
      level._id_126B3 = 0;
      continue;
    }

    level._id_126B3 = 1;
  }
}

_id_E393() {
  thread _id_E314();
  level thread scripts\sp\utility::_id_C12D("stop_ret_jackals", 7);
  var_0 = scripts\sp\vehicle::_id_1080D("crashing_ret");
  var_0 _id_0BB8::_id_397F(0, 1);
  var_0 _id_0BB8::_id_397E();
  wait 0.1;
  playFXOnTag(scripts\engine\utility::getfx("vfx_mars_retribution_damaged"), var_0, "tag_origin");
  var_1 = spawn("script_origin", var_0.origin);
  var_1 linkTo(var_0);
  var_1 playLoopSound("retribution_intro_falling_main");
  var_0 thread _id_0BB8::_id_39CE("high");
  wait 0.05;
  var_0 _id_0BB8::_id_39D0("off");
  var_0 _id_0BB8::_id_39CD("off");
  thread _id_E391();
  thread _id_E392();
  thread _id_E3E8(16);
  var_0 waittillmatch("noteworthy", "impact");
  level notify("ret_impact");
  thread _id_5F7D();
  var_2 = 3;
  stopFXOnTag(scripts\engine\utility::getfx("vfx_mars_retribution_damaged"), var_0, "tag_origin");
  var_1 stoploopsound(1.5);
  var_1 playSound("retribution_intro_impact");
  scripts\engine\utility::exploder("vfx_exp_retribution_crash_site");
  var_1 playSound("retribution_intro_explo_secondary");
  wait 1;
  thread _id_D256(var_0.origin, 40);
  earthquake(0.75, var_2, level.player.origin, 100);
  level.player _meth_8244("damage_heavy");
  wait(var_2);
  thread _id_8E25();
  level.player stoprumble("damage_heavy");
  var_0 delete();
  wait 10;
  var_1 delete();
}

_id_E3E8(var_0) {
  earthquake(0.15, var_0, level.player.origin, 5000);
  level.player _meth_8244("damage_heavy");
  scripts\engine\utility::exploder("vfx_exp_cliff_rock_crumble");
  level scripts\engine\utility::waittill_notify_or_timeout("ret_impact", var_0);
  scripts\sp\utility::_id_10FEC("vfx_exp_cliff_rock_crumble");
  level.player stoprumble("damage_heavy");
}

_id_E391() {
  level scripts\sp\utility::_id_10350("marscrash_gtr_engineshavecriticalfailures");
  level scripts\sp\utility::_id_10350("marscrash_gtr_warshipcantmaintain");
  wait 1.5;
  level scripts\sp\utility::_id_10350("marscrash_gtr_everyoneabandonshipabandon");
  wait 2.0;
  level scripts\sp\utility::_id_10350("marscrash_gtr_retributiongoingdownwere");
}

_id_E392() {
  level.player endon("death");
  wait 2.5;
  level.player thread scripts\sp\utility::_id_1034D("marscrash_plr_no");
  level waittill("ret_impact");
  wait 5.0;
  level._id_C253 = 1;
  level.player thread scripts\sp\utility::_id_D090("ges_radio");
  level.player scripts\engine\utility::delaycall(0.5, ::playsound, "ges_plr_radio_on");
  level.player scripts\sp\utility::_id_1034D("marscrash_plr_retributioncomein");
  wait 1.0;
  level.player scripts\sp\utility::_id_1034D("marscrash_plr_gator");
  wait 1.0;
  level.player playSound("ges_plr_radio_off");
  level.player scripts\sp\utility::_id_1102B("ges_radio");
  level._id_C253 = 1;
  wait 0.5;
  scripts\engine\utility::flag_set("post_mons_crash_dialog");
}

_id_E314() {
  level endon("stop_ret_jackals");

  for(;;) {
    var_0 = getcsplineidarray("ret_jackal");
    var_0 = scripts\engine\utility::array_randomize(var_0);

    foreach(var_2 in var_0) {
      var_3 = scripts\sp\vehicle::_id_1080C("crashing_jackal");
      wait 0.05;
      var_4 = getcsplinepointposition(var_2, 0);
      var_3 vehicle_teleport(var_4, var_3.angles);
      var_5 = randomintrange(650, 700);
      var_3 thread _id_0BDC::_id_A1EF(var_2, var_5);
      wait(randomfloatrange(0.25, 0.8));
    }

    wait 0.05;
  }
}

_id_398B(var_0) {
  self endon("death");
  self endon("stop_flickering_thrusters");
  var_1 = undefined;

  switch (var_0) {
    case "fwd":
    case "forward":
      var_1 = _id_0BB8::_id_39CD;
      break;
    case "vertical":
    case "vert":
      var_1 = _id_0BB8::_id_39D0;
      break;
  }

  for(;;) {
    if(scripts\engine\utility::cointoss()) {
      var_2 = "heavy";
    } else {
      var_2 = "idle";
    }

    self[[var_1]](var_2);
    wait(randomfloatrange(0.05, 1));
    self[[var_1]]("off");
    wait(randomfloatrange(0.05, 1));
  }
}

_id_10C8A() {
  level.player scripts\sp\utility::_id_11633(scripts\engine\utility::getStruct("player_start_intro", "targetname"));
  thread _id_FA16();
  scripts\engine\utility::flag_set("player_exited_crashed_jackal");
  level._id_1386D = 1;
  thread _id_9ACB();
  thread _id_E393();
}

_id_B1FD() {
  scripts\sp\utility::_id_2669("main_intro");
  thread _id_A552();
  thread _id_4872();
  thread _id_1386E();
  thread _id_12F7D();
  thread _id_C419();
  thread _id_D6DE();
  wait 0.25;
}

_id_1386E() {
  var_0 = scripts\sp\maps\marsbase\marsbase_sky_cowbell::_id_10207("walk_jackal_crash_1", 1, "allies", 200, 0);
  var_0 = scripts\sp\utility::_id_22B9(var_0);

  foreach(var_2 in var_0) {
    var_2 notify("notify_stop_thrust_audio");
    wait 3.2;

    if(isDefined(var_0[0])) {
      var_0[0] playSound("mars_crash_jackal_flyby_01");
      var_0[0] scripts\engine\utility::delaycall(0.5, ::playsound, "mars_crash_jackal_flyby_swt_01");
    }
  }
}

_id_12F7D() {
  scripts\sp\utility::_id_13630("trig_uphill_jackal_flyover");
  level scripts\engine\utility::flag_wait("flag_mons_crashed");
  var_0 = scripts\sp\maps\marsbase\marsbase_sky_cowbell::_id_10207("uphill_jackal_flyover", 0, "allies", 300, 0);
  var_0[0] scripts\engine\utility::delaycall(1.8, ::playsound, "mars_crash_jackal_flyby_swt_02");
  var_0 = scripts\sp\utility::_id_22B9(var_0);

  foreach(var_2 in var_0) {
    var_2._id_2714 = 1;
  }

  foreach(var_2 in var_0) {
    var_2 notify("notify_stop_thrust_audio");
  }

  if(isDefined(var_0[0])) {
    var_0[0] waittill("uphill_jackal_overhead");
    earthquake(0.25, 1, level.player.origin, 500);
    level.player playRumbleOnEntity("damage_heavy");
    var_0[0] playSound("jackal_hill_flyby");
    scripts\engine\utility::exploder("vfx_exp_jackal_flyby");
  }
}

_id_3B77() {
  level.player thread scripts\sp\utility::_id_D2CD(60, 0.05);
  scripts\engine\utility::exploder("vfx_exp_retribution_crash_site");
  thread _id_12F7D();
}

_id_9ACB() {
  level._id_D2D0 = 25;
  level._id_386C = 1;
  level.player scripts\sp\utility::_id_D2CD(level._id_D2D0);
  level._id_C861 = ["marsbase_plr_effort1", "asteroid_plr_exertion1", "rogue_plr_fall"];
  level.player scripts\sp\utility::_id_65E0("fall");
  level.player scripts\sp\utility::_id_65E0("collapse");
  level._id_11184 = 1;
  level._id_D0F0 = 0;
  thread _id_C5A3();
  thread _id_C543();
  thread _id_102EA();
  wait 3;
  setblur(0, 5);
}

_id_C5A3() {
  while(!scripts\engine\utility::flag("dropship_triage_callout")) {
    if(level.player _meth_8439() && !level._id_D0F0) {
      level._id_D0F0 = 1;
      level.player scripts\sp\utility::_id_D2CD(55, 0.5);
      wait 1.0;

      if(level._id_386C) {
        level.player thread scripts\sp\utility::_id_1034D(scripts\engine\utility::random(level._id_C861));
      }

      level._id_386C = 0;
      _id_C5A7(1);
      level._id_D0F0 = 0;
    }

    wait 0.05;
  }
}

_id_10ABE() {
  for(;;) {
    if(!level.player _meth_8439()) {
      wait 5;
      level._id_10AB8 = 1;
    }

    wait 1;
  }
}

_id_C543() {
  while(!scripts\engine\utility::flag("debris_lift_started")) {
    if(level.player _meth_81CE() && !level._id_D0F0) {
      level._id_D0F0 = 1;

      if(level._id_386C) {
        level.player thread scripts\sp\utility::_id_1034D(scripts\engine\utility::random(level._id_C861));
      }

      level._id_386C = 0;
      _id_C5A7(1);
      level._id_D0F0 = 0;
    }

    wait 0.05;
  }
}

_id_C5A7(var_0) {
  level endon("debris_lift_started");
  level.player playRumbleOnEntity("damage_heavy");

  if(isDefined(var_0) && var_0) {
    thread _id_C876();
  }

  level._id_C253 = 0;
  level.player scripts\sp\utility::_id_D08C("ges_stumble_" + level._id_11184);
  level.player scripts\sp\utility::_id_D2CD(10, 0.05);
  wait 0.15;
  level.player scripts\sp\utility::_id_D2CD(level._id_D2D0, 5);
  wait 3;
  level._id_386C = 1;
  level._id_C253 = 1;
  wait 3;
  level.player setstance("stand");
  level._id_11184 = scripts\engine\utility::ter_op(level._id_11184 == 1, 2, 1);
}

_id_102EA() {
  level endon("oxygen_grab");
  level.player waittill("stop_sliding");
  level.player viewkick(80, level.player.origin);
  level._id_D2D0 = 30;
  _id_C5A7();
  setsaveddvar("player_viewmodelMoveAnimScale", 0.6);
  level thread _id_1017E();
}

_id_D256(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = level.player.origin;
  }

  earthquake(0.25, 2, var_0, 20000);

  if(isDefined(var_1)) {
    level._id_D2D0 = var_1;
  } else {
    level._id_D2D0 = 50;
  }

  level.player scripts\sp\utility::_id_D2CD(level._id_D2D0, 3);
  _id_C5A7();
  setsaveddvar("player_viewmodelMoveAnimScale", 0.6);
  level thread _id_1017E();
}

_id_C254() {
  level._id_C261 = 1;
  level._id_C260 = scripts\engine\utility::getStruct("air_boss_interact", "targetname");
  scripts\engine\utility::waitframe();
  level._id_C253 = 1;
  level._id_C25F = 1;
  level._id_C25B = 1;
  level._id_C259 = 0.5;
  level._id_C25A = 0.6;
  level._id_C252 = 2;
  level._id_C25D = 0.75;
  thread _id_C258();
  thread _id_C251();
  thread _id_C25C();
  scripts\engine\utility::flag_wait("o2_start");
  thread _id_2FC4();
  thread _id_C257(20, "o2_level1_finished");
  scripts\engine\utility::flag_wait("o2_level1_finished");
  level notify("o2_level_switch");
  level._id_C25F = 0.5;
  level._id_C25B = 0.75;
  level._id_C259 = 0.6;
  level._id_C25A = 0.7;
  level._id_C252 = 1;
  level._id_C25D = 0.4;
  thread _id_C257(15, "o2_level2_finished");
  wait 2.0;
  level.player thread _id_C256("marscrash_cmp_lowoxygenlowoxygen");
  scripts\engine\utility::flag_wait("o2_level2_finished");
  level notify("o2_level_switch");
  level._id_C25F = 0.25;
  level._id_C25B = 0.5;
  level._id_C259 = 0.7;
  level._id_C25A = 0.9;
  level._id_C252 = 0.4;
  level._id_C25D = 0.2;
  thread _id_C257(15, "o2_level3_finished");
  level.player thread _id_C256("marscrash_cmp_oxygenlevelscritical");
  wait 0.5;
  level.player scripts\engine\utility::delaythread(4, scripts\sp\utility::_id_1034D, "marscrash_plr_runningoutofair");
  scripts\engine\utility::flag_wait("o2_level3_finished");
  level notify("o2_level_switch");
  level._id_C25F = 0.1;
  level._id_C25B = 0.25;
  level._id_C259 = 0.8;
  level._id_C25A = 0.9;
  level._id_C252 = 0.1;
  level._id_C25D = 0.0;
  scripts\engine\utility::flag_set("o2_level4_finished");
  wait 7.0;

  if(!scripts\engine\utility::flag("oxygen_grab_started")) {
    scripts\sp\utility::_id_B8D1();
  }
}

_id_C257(var_0, var_1) {
  level endon("o2_level_switch");
  wait(var_0);
  scripts\engine\utility::flag_set(var_1);
}

_id_C256(var_0) {
  while(!level._id_C253) {
    wait 0.1;
  }

  if(!scripts\engine\utility::flag("oxygen_grab")) {
    thread scripts\sp\utility::_id_10347(var_0);
  }
}

_id_C25E() {
  level.player endon("death");
  var_0 = "oxygenLowWarning";
  var_1 = 1;
  var_2 = 0;
  scripts\engine\utility::flag_wait("level_fade_in");
  wait 1;

  while(!scripts\engine\utility::flag("oxygen_grab") && !scripts\engine\utility::flag("missionfailed")) {
    if(scripts\engine\utility::flag("o2_level2_finished")) {
      var_0 = "oxygenCriticalWarning";
    }

    if(scripts\engine\utility::flag("o2_level4_finished") && var_2) {
      var_2 = 0;
      var_0 = "oxygenDepletedWarning";
      var_1 = 0;
    }

    level.player _meth_849C(var_0);
    wait(level._id_C25F + 0.1);

    if(var_1) {
      level.player _meth_849D();
      wait(level._id_C25F + 0.1);
    }
  }

  level.player _meth_849D();
}

_id_C251() {
  level.player endon("death");

  while(!scripts\engine\utility::flag("oxygen_grab")) {
    level.player scripts\sp\utility::play_sound_on_entity("cracked_helmet_o2_beep");
    wait(level._id_C252);
  }

  level.player scripts\sp\utility::play_sound_on_entity("cracked_helmet_o2_beep");
}

_id_C258() {
  level.player endon("death");
  scripts\engine\utility::flag_wait("level_fade_in");
  var_0 = scripts\sp\hud_util::_id_48B7("vfx_ui_player_pain_overlay", 0, level.player);
  var_0._id_02B4 = 1;
  var_0.enablehudlighting = 1;
  var_0.alpha = 0;

  while(!scripts\engine\utility::flag("oxygen_grab")) {
    var_0 fadeovertime(level._id_C25B);
    var_0.alpha = level._id_C259;
    wait(level._id_C25B + 0.1);
    var_0 fadeovertime(level._id_C25B);
    var_0.alpha = level._id_C25A;
    wait(level._id_C25B + 0.1);
  }

  while(level._id_C25A > 0) {
    var_0 fadeovertime(level._id_C25B);
    var_0.alpha = level._id_C259;
    wait(level._id_C25B + 0.1);
    var_0 fadeovertime(level._id_C25B);
    var_0.alpha = level._id_C25A;
    wait(level._id_C25B + 0.1);
    level._id_C259 = level._id_C259 - 0.1;

    if(level._id_C259 <= 0) {
      level._id_C259 = 0;
    }

    level._id_C25A = level._id_C25A - 0.1;

    if(level._id_C25A <= 0) {
      level._id_C25A = 0;
    }

    level._id_C25B = level._id_C25B + 0.1;
  }

  var_0 destroy();
}

_id_C25C() {
  level._id_C25D = 0.4;
  level.player endon("death");
  var_0 = ["breathing_heartbeat", "breathing_heartbeat_alt"];
  var_1 = 4;

  if(!isDefined(level._id_1386D)) {
    for(var_2 = 0; var_2 < var_1; var_2++) {
      level.player scripts\sp\utility::play_sound_on_entity(scripts\engine\utility::random(var_0));
    }
  }

  while(!scripts\engine\utility::flag("oxygen_grab")) {
    level.player playRumbleOnEntity("damage_light");
    level.player scripts\sp\utility::play_sound_on_entity(scripts\engine\utility::random(var_0));
    wait(level._id_C25D);
  }

  while(level._id_C25D < 0.6) {
    level.player playRumbleOnEntity("damage_light");
    level.player scripts\sp\utility::play_sound_on_entity(scripts\engine\utility::random(var_0));
    wait(level._id_C25D);
    level._id_C25D = level._id_C25D + 0.1;
  }
}

_id_C876(var_0, var_1) {
  var_2 = scripts\sp\hud_util::_id_48B7("vfx_ui_player_pain_overlay", 0, level.player);
  var_2._id_02B4 = 1;
  var_2.enablehudlighting = 1;

  if(!isDefined(var_1)) {
    var_1 = 0.5;
  }

  var_2 fadeovertime(var_1);
  var_2.alpha = 0.7;
  var_3 = scripts\engine\utility::ter_op(isDefined(var_0), var_0, 1);

  if(isstring(var_3)) {
    level waittill(var_3);
  } else {
    wait(var_3);
  }

  var_2 fadeovertime(1.5);
  var_2.alpha = 0;
  wait 2;
  var_2 destroy();
}

_id_2FC4() {
  level.player endon("death");
  level endon("oxygen_grab");
  level endon("player_exiting_crashed_jackal");
  level.player scripts\sp\utility::_id_65E0("pause_breathing");
  var_0 = 0;
  var_1 = spawnStruct();
  var_1._id_94D0 = "cracked_helmet_inhale_slow";
  var_1._id_6939 = "cracked_helmet_exhale_slow";
  var_2 = spawnStruct();
  var_2._id_94D0 = "cracked_helmet_inhale_med";
  var_2._id_6939 = "cracked_helmet_exhale_med";
  var_3 = spawnStruct();
  var_3._id_94D0 = "cracked_helmet_inhale_fast";
  var_3._id_6939 = "cracked_helmet_exhale_fast";
  var_4 = var_1;
  var_5 = 0.6;
  var_6 = 1;
  var_7 = 0.9;
  var_8 = 2.0;
  var_9 = 1.75;
  var_10 = 0.8;
  var_11 = 25;
  var_12 = 70;
  level.player._id_FB50 = spawn("script_origin", level.player.origin);
  level.player._id_FB50 linkTo(level.player);
  thread _id_1AFF();
  wait 2.5;

  while(!scripts\engine\utility::flag("player_exiting_crashed_jackal")) {
    level.player._id_FB50._id_CBE9 = 1;
    level.player._id_FB50._id_1352E = 1;
    level.player._id_FB50._id_1B00 = 25;
    level.player._id_FB50 _meth_8277(level.player._id_FB50._id_CBE9);
    level.player._id_FB50 _meth_8278(level.player._id_FB50._id_1352E);

    if(scripts\engine\utility::flag("o2_level1_finished")) {
      var_4 = var_2;
    } else if(scripts\engine\utility::flag("o2_level2_finished")) {
      var_4 = var_3;
    }

    if(var_0) {
      var_13 = var_4._id_94D0;
      var_0 = 0;
    } else {
      var_13 = var_4._id_6939;
      var_0 = 1;
    }

    if(var_4 != var_1 && var_13 == var_4._id_94D0 && randomint(100) < level.player._id_FB50._id_1B00) {
      if(!scripts\engine\utility::flag("oxygen_grab_started")) {
        _id_1AFF();
      }
    } else {
      level.player._id_FB50 playSound(var_13, "sounddone", 1);
      level.player._id_FB50 scripts\engine\utility::waittill_any("sounddone", "interupted");
    }

    while(isDefined(level.player._id_FB50._id_9A92) || level.player scripts\sp\utility::_id_65DB("pause_breathing")) {
      wait 0.05;
    }
  }
}

_id_9A91(var_0) {
  if(isDefined(level.player._id_FB50._id_9A92)) {
    return;
  }
  level.player._id_FB50._id_9A92 = 1;
  level.player._id_FB50 stopsounds();
  level.player._id_FB50 notify("interupted");
  wait 0.1;
  level.player scripts\sp\utility::play_sound_on_entity(var_0);
  level.player._id_FB50._id_9A92 = undefined;
}

_id_1AFF() {
  level.player scripts\sp\utility::_id_65E1("pause_breathing");
  _id_9A91("weap_sniper_breathin");
  wait(randomfloatrange(0.25, 1.2));
  _id_9A91("weap_sniper_breathin");
  wait(randomintrange(2, 4));
  level.player scripts\sp\utility::_id_65DD("pause_breathing");
}

_id_C419() {
  scripts\engine\utility::flag_wait("spawn_mons");
  level._id_BA43 = scripts\sp\vehicle::_id_1080D("crash_mons");
  wait 0.1;
  level._id_BA43 _id_0BB8::_id_397F(1);
  level._id_BA43 _id_0BB8::_id_397E();
  playFXOnTag(scripts\engine\utility::getfx("vfx_mars_mons_damaged"), level._id_BA43, "tag_origin");
  thread _id_BADF();
  level._id_BA43 _id_0BB8::_id_39D0("off");
  level._id_BA43 _id_0BB8::_id_39CD("off");
  wait 3.0;
  thread _id_BADE(14);
  level._id_BA43 waittillmatch("noteworthy", "crashing");
  thread _id_D5DC();
  level._id_BA43 waittillmatch("noteworthy", "crash");
  level._id_BA43 notify("stop_dmg_fx");
  stopFXOnTag(scripts\engine\utility::getfx("vfx_mars_mons_damaged"), level._id_BA43, "tag_origin");
  var_0 = 3;
  level notify("mons_crashed");
  scripts\engine\utility::exploder("vfx_exp_mons_crash_impact");
  wait 2;
  earthquake(0.25, var_0, level.player.origin, 10000);
  level.player _meth_8244("damage_heavy");
  wait(var_0);
  level.player stoprumble("damage_heavy");
  level.player thread scripts\sp\utility::_id_D2CD(60, 2);
  level.player notify("stop_sprint_stumble");
  level.player notify("stop_move_pains");
  level._id_BA43 _id_0BB8::_id_397C();
  level._id_BA43 scripts\engine\utility::delaycall(3, ::delete);
  level scripts\engine\utility::flag_set_delayed("flag_mons_crashed", 1);
}

_id_8E25() {
  wait 3;
  var_0 = scripts\engine\utility::getStruct("kash_death_player", "targetname");
  var_1 = scripts\engine\utility::spawn_tag_origin(var_0.origin + (2500, -700, -200), var_0.angles);
  var_1 playSound("scn_mars_flare_launch");
  playFXOnTag(scripts\engine\utility::getfx("vfx_marscrash_flare"), var_1, "tag_origin");
}

_id_BADF() {
  var_0 = spawn("script_origin", level._id_BA43.origin);
  var_0 linkTo(level._id_BA43);
  wait 0.1;
  var_0 playLoopSound("mothership_intro_falling_main");
  level waittill("mons_crashed");
  var_0 playSound("mothership_intro_impact");
  wait 0.2;
  var_0 stoploopsound();
  var_0 delete();
}

_id_BADE(var_0) {
  earthquake(0.15, var_0, level.player.origin, 5000);
  level.player _meth_8244("damage_heavy");
  scripts\engine\utility::exploder("vfx_exp_cliff_rock_crumble");
  var_1 = getEnt("fxanim_sp_mars_rockslide_crash", "targetname");
  var_1 scripts\sp\utility::_id_23B7("mdl_rockslide");
  var_1 thread scripts\sp\anim::_id_1F35(var_1, "fxanim_rockslide");
  level scripts\engine\utility::waittill_notify_or_timeout("mons_crashed", var_0);
  scripts\sp\utility::_id_10FEC("vfx_exp_cliff_rock_crumble");
  level.player stoprumble("damage_heavy");
}

_id_D5DC() {
  scripts\engine\utility::flag_wait("mons_crash_dialogue_done");
  wait 4;
  level.player scripts\sp\utility::_id_1034D("marscrash_plr_ethan");
  scripts\engine\utility::flag_set("safe_to_talk");
}

_id_D8F5() {
  for(;;) {
    var_0 = distance(level.player.origin, level._id_BA43.origin);
    wait 0.1;
  }
}

_id_C411() {
  self endon("stop_dmg_fx");
  var_0 = scripts\sp\utility::_id_7CCC(self.model);
  var_1 = 0;
  var_2 = 5;

  for(;;) {
    var_0 = scripts\engine\utility::array_randomize(var_0);

    foreach(var_4 in var_0) {
      thread _id_D485(var_4, randomintrange(4, 7));
      wait(randomfloatrange(0.15, 0.4));
      var_1++;

      if(var_1 >= var_2) {
        wait 4;
        var_1 = 0;
      }
    }
  }
}

_id_D485(var_0, var_1) {
  self endon("death");
  playFXOnTag(scripts\engine\utility::getfx("debris_geotrail"), self, var_0);
  wait(var_1);
  stopFXOnTag(scripts\engine\utility::getfx("debris_geotrail"), self, var_0);
}

_id_D6DE() {
  level.player endon("death");
  scripts\engine\utility::flag_wait("post_mons_crash_dialog");
  level scripts\sp\utility::_id_10350("marscrash_brk_wehaveacritical");
  level._id_386C = 0;
  level.player scripts\sp\utility::_id_1034D("marscrash_plr_brooksbrookscan");
  level scripts\sp\utility::_id_10350("marscrash_brk_static");
  wait 1.0;
  level.player scripts\sp\utility::_id_1034D("marscrash_plr_negativecopy11t");
  level._id_386C = 1;
  scripts\engine\utility::flag_set("mons_crash_dialogue_done");
}

_id_10C24() {
  thread _id_A552();
  level.player scripts\sp\utility::_id_11633(scripts\engine\utility::getStruct("dropship_approach_player", "targetname"));
  level scripts\engine\utility::flag_set("flag_mons_crashed");
  scripts\engine\utility::flag_set("safe_to_talk");
  thread _id_4872();
}

_id_B1C6() {
  scripts\sp\utility::_id_2669("main_dropship_approach");
  thread _id_FA15();
  thread _id_5ECB();
  thread _id_5DA1();
  level._id_10274 = 0.35;
  scripts\engine\utility::flag_wait("kash_arrive");
}

_id_3B57() {}

_id_5ECB(var_0) {
  thread _id_B3AE();
  thread _id_5ECC();
  level._id_12708 = 0;
  level._id_1270C = scripts\sp\utility::_id_107EA("dropship_triage_medic");
  level._id_1270A = scripts\sp\utility::_id_107EA("dropship_triage_injured");
  level._id_1270C._id_1FBB = "medic";
  level._id_1270A._id_1FBB = "injured";
  thread _id_1270B();
  var_1 = scripts\engine\utility::getStruct("injured_marine", "targetname");
  var_2 = scripts\engine\utility::getStruct("e_flare", "targetname");
  var_3 = var_1 scripts\engine\utility::spawn_tag_origin();
  var_4 = scripts\engine\utility::spawn_tag_origin(var_2.origin + (0, 0, 0), var_2.angles + (0, 75, 0));
  playFXOnTag(scripts\engine\utility::getfx("vfx_marscrash_flare_ground"), var_4, "tag_origin");

  if(!scripts\engine\utility::is_true(var_0)) {
    var_3 thread scripts\sp\anim::_id_1EEA(level._id_1270C, "triage_idle");
    var_3 thread scripts\sp\anim::_id_1EEA(level._id_1270A, "triage_idle");
    scripts\engine\utility::flag_wait("dropship_triage_callout");
    var_3 notify("stop_loop");
    var_3 thread scripts\sp\anim::_id_1F35(level._id_1270C, "triage_call");
    var_3 scripts\sp\anim::_id_1F35(level._id_1270A, "triage_call");
    var_3 thread scripts\sp\anim::_id_1EEA(level._id_1270C, "triage_idle");
    var_3 thread scripts\sp\anim::_id_1EEA(level._id_1270A, "triage_idle");

    while(distance(level.player.origin, level._id_1270C.origin) > 160) {
      wait 0.1;
    }

    level._id_1270C notify("player_near");
    var_3 notify("stop_loop");
    var_3 thread scripts\sp\anim::_id_1F35(level._id_1270C, "triage_point");
    var_3 scripts\sp\anim::_id_1F35(level._id_1270A, "triage_point");
  }

  var_3 thread scripts\sp\anim::_id_1EEA(level._id_1270C, "triage_idle");
  var_3 thread scripts\sp\anim::_id_1EEA(level._id_1270A, "triage_idle");
  level.player thread scripts\sp\utility::_id_D2CD(80, 2);
}

_id_1270B() {
  level endon("debris_lift_started");

  for(;;) {
    level._id_1270A playSound("marscrash_un1_woundedpain");
    wait 17.0;
  }
}

_id_B3AE() {
  wait 35;
  setmusicstate("");
  wait 8;
  setmusicstate("mx_218_marscrash_wounded");
}

_id_5ECC() {
  scripts\engine\utility::flag_wait("dropship_triage_callout");
  level._id_1270C waittillmatch("single anim", "vo_marscrash_un1_captainoverheresir");
  wait 1.5;

  if(scripts\engine\utility::flag("safe_to_talk")) {
    level._id_386C = 0;
    level.player thread scripts\sp\utility::_id_D090("ges_mars_marines", level._id_1270C);
    level.player thread scripts\sp\utility::_id_1034D("marscrash_plr_marines");
  }

  level._id_1270C waittillmatch("single anim", "vo_marscrash_un1_commandergladyoumade");
  wait 3;

  if(scripts\engine\utility::flag("safe_to_talk")) {
    level._id_386C = 0;
    level.player scripts\sp\utility::_id_1034D("marscrash_plr_thanksprivate");
    wait 0.45;
    level.player scripts\sp\utility::_id_1034D("marscrash_plr_takecareofhim");
  }
}

_id_5ECD(var_0, var_1) {
  if(isDefined(level._id_12709)) {
    return;
  }
  level._id_12708 = 1;

  if(!isDefined(var_1)) {
    scripts\sp\utility::_id_1034D(var_0);
  } else {
    scripts\sp\utility::_id_10346(var_0);
  }

  level._id_12708 = 0;
  wait 0.05;
}

_id_5DA1() {}

_id_A546() {
  thread _id_FA15();
  thread _id_A552();
  thread _id_5DA1();
  thread _id_5ECB(1);
  level._id_12708 = 0;
  scripts\sp\utility::_id_11633(scripts\engine\utility::getStruct("kash_death_player", "targetname"));
  thread _id_4872();
  scripts\engine\utility::flag_set("flag_crawler_guy");
}

_id_A53E() {
  scripts\engine\utility::flag_wait("kash_arrive");
  thread _id_13BED();
  thread _id_5E09();
  scripts\sp\utility::_id_2669("Help Kashima");
  wait 0.5;
  level._id_10274 = 0.4;
  var_0 = level._id_A54A;

  while(level._id_12708) {
    wait 0.05;
  }

  level._id_12709 = 1;
  thread _id_30F7();
  scripts\engine\utility::delaythread(2, scripts\engine\utility::exploder, "vfx_exp_cockpit_elec_burst");
  var_0.node notify("stop_loop");
  scripts\engine\utility::waitframe();
  var_0.node thread scripts\sp\anim::_id_1EEA(var_0._id_1684["kashima"], "kash_death_idle");
  var_0.node scripts\sp\anim::_id_1F35(var_0._id_1684["brooks"], "kash_death_call");
  var_0.node thread scripts\sp\anim::_id_1EEA(var_0._id_1684["brooks"], "kash_death_start_idle");
  wait 0.5;
  var_1 = scripts\engine\utility::getStruct("kash_scene_interact", "targetname").origin;

  while(!scripts\sp\utility::_id_D40E(400, var_1)) {
    scripts\engine\utility::waitframe();
  }

  level._id_30F6 scripts\engine\utility::delaythread(3, scripts\sp\utility::_id_10346, "marscrash_brk_hangintherebuddy");
  level._id_A54E scripts\engine\utility::delaythread(6, scripts\sp\utility::_id_10346, "marscrash_ksh_noproblemsir");
  var_0.node scripts\sp\anim::_id_1F35(var_0._id_1684["brooks"], "kash_death_kneel");
  var_0.node notify("stop_loop");
  scripts\engine\utility::waitframe();
  scripts\engine\utility::flag_set("close_enough_to_interact");
  var_0.node thread scripts\sp\anim::_id_1EE7(var_0._id_1684["kash_brooks"], "kash_death_idle");
  var_0.node scripts\sp\anim::_id_1EC3(var_0._id_1684["player"], "kash_death_lift_start");
  wait 2.25;
  thread _id_A540();
  var_0._id_99F4 _id_0E46::_id_48C4(undefined, (10, 0, -20), undefined, undefined, 700, 96);
  var_0._id_99F4 waittill("trigger");
  scripts\engine\utility::flag_set("debris_lift_started");
  level._id_30F6.name = "";
  setsaveddvar("player_sprintspeedscale", 1.4);
  var_0._id_A55A = 1;
  level.player scripts\engine\utility::delaycall(5, ::_meth_8244, "damage_light");
  setsaveddvar("player_viewmodelMoveAnimScale", 1.0);
  thread scripts\sp\maps\marscrash\marscrash_util::_id_5569();
  var_2 = getEnt("kashima_debris_clip", "targetname");
  var_2 delete();
  var_0.node notify("stop_loop");
  scripts\sp\utility::dyndof();
  level.dyndof.nearend = 1000;
  scripts\engine\utility::waitframe();
  var_0.node thread scripts\sp\anim::_id_1F2C(var_0._id_1684["kash_brooks_reyes"], "kash_death_lift_start");
  thread _id_2B73(var_0._id_1684["player"]);
  wait 0.5;
  var_0.node waittill("kash_death_lift_start");
  level thread _id_D841();
  level notify("debrislift_started");
  level._id_A54E scripts\engine\utility::delaythread(1, scripts\sp\utility::_id_10346, "heist_ksh_effortaghnonono1");
  level._id_A54E scripts\engine\utility::delaythread(3, scripts\sp\utility::_id_10346, "marscrash_ksh_efforts2");
  var_0.node notify("stop_loop");
  var_0.node scripts\sp\anim::_id_1F2C(var_0._id_1684["everyone"], "kash_death_lift");
  setmusicstate("");
  level.player _meth_82C0("marscrash_kashima_scene", 10.0);
  level.dyndof.farstart = 1000;
  level.dyndof.farend = 2000;
  var_0.node notify("stop_loop");
  level._id_A54D = scripts\engine\utility::spawn_tag_origin(level._id_A54E gettagorigin("j_head"), level._id_A54E gettagangles("j_head"));
  level._id_A54D scripts\engine\utility::delaycall(2.6, ::playsound, "marscrash_ksh_efforts1");
  level.player stoprumble("damage_light");
  var_0.node thread scripts\sp\anim::_id_1F35(var_0._id_4E7A[0], "kash_death_lift_finish");
  var_0.node scripts\sp\anim::_id_1F2C(var_0._id_1684["kash_brooks_reyes"], "kash_death_lift_finish");
  var_0._id_A55B = 1;
  level._id_A54A._id_8CCC = 0.1;
  thread _id_A555();
  var_0.node notify("stop_loop");
  level thread _id_A545();
  level.player _meth_82C0("marscrash_end_mission", 10.0);
  var_0.node thread _id_30F8(var_0._id_1684["brooks"]);
  var_0.node scripts\sp\anim::_id_1F2C(var_0._id_1684["stars"], "kash_death_pressure_intro");
  level._id_A54A._id_1684["kashima"] thread _id_4C3D("j_shoulder_ri");
  var_0.node scripts\sp\anim::_id_1F2C(var_0._id_1684["stars"], "kash_death_pressure_1_a");
  var_0.node scripts\sp\anim::_id_1F35(var_0._id_1684["player"], "kash_death_pressure_2_a");
  var_0.node thread scripts\sp\anim::_id_1F35(var_0._id_1684["kashima"], "kash_death_pressure_3_a");
  var_0.node scripts\sp\anim::_id_1F35(var_0._id_1684["player"], "kash_death_pressure_3_a");
  level notify("kash_dies");
  level thread _id_A55C();
  thread _id_A547();
  var_0.node scripts\sp\anim::_id_1F2C(var_0._id_1684["stars"], "kash_death");
  level notify("kash_dead");
  wait 0.25;
  scripts\sp\maps\marscrash\marscrash_util::_id_6229();
  level.player _meth_82C0("marscrash_end_mission_bink", 0.6);
  scripts\sp\utility::_id_BF95();
}

_id_13BED() {
  wait 20;

  if(!scripts\engine\utility::flag("close_enough_to_interact")) {
    var_0 = scripts\engine\utility::getStruct("kash_scene_interact", "targetname");
    objective_add(scripts\sp\utility::_id_C264("kash_location"), "current", "", var_0.origin);
  }

  scripts\engine\utility::flag_wait("close_enough_to_interact");
  objective_delete(scripts\sp\utility::_id_C264("kash_location"));
}

_id_2B73(var_0) {
  level.player _meth_823C(var_0, "tag_player", 0.5, 0.5, 0);
  level.player scripts\engine\utility::delaycall(8.5, ::playerlinktodelta, var_0, "tag_player", 1, 0, 0, 0, 0, 1);
  wait 0.5;
  var_0 show();
  wait 8.5;
  level.player lerpviewangleclamp(1, 0, 0, 1, 5, 15, 15);
}

_id_30F7() {
  var_0 = scripts\engine\utility::getStruct("kash_scene_interact", "targetname").origin;

  while(!scripts\sp\utility::_id_D40E(600, var_0)) {
    scripts\engine\utility::waitframe();
  }

  level._id_30F6 thread scripts\sp\utility::_id_10346("marscrash_brk_captain");
}

#using_animtree("generic_human");

_id_A541() {
  var_0 = level._id_A54A._id_1684["kashima"];
  level waittill("kashima_mayhem_start_a");
  _id_A543(var_0);
  var_0 _meth_82A2(%mayhem_mars_10_2b_kash_dies_mr2_scene2_held_down, 1.0, 0.0, 1.0);
  level waittill("kashima_mayhem_switch_a");
  var_0 _meth_82A2(%mayhem_mars_10_2b_kash_dies_mr2_scene2_held_down, 1.0, 0.0, 1.0);
  level waittill("kashima_mayhem_end_a");
  var_0 clearanim(%mayhem_mars_10_2b_kash_dies_mr2_scene2_held_down, 0.0);
  _id_A542(var_0);
}

_id_A543(var_0) {
  var_0 hidepart("j_head", var_0.headmodel);
  var_0 hidepart("j_eyeball_le");
  var_0 hidepart("j_eyeball_ri");
  var_0 hidepart("j_tongue_1");
}

_id_A542(var_0) {
  var_0 showpart("j_head", var_0.headmodel);
  var_0 showpart("j_eyeball_le");
  var_0 showpart("j_eyeball_ri");
  var_0 showpart("j_tongue_1");
}

_id_D841() {
  scripts\sp\utility::_id_12651(["marscrash_vista_tr", "marscrash_prime_tr"]);
  thread scripts\sp\utility::_id_BF97();
}

_id_A55C() {
  wait 3;
  scripts\engine\utility::exploder("vfx_exp_kashima_sparks_rain");
  wait 3;
  playFXOnTag(scripts\engine\utility::getfx("vfx_mars_sparks_kashima_helmet_runner"), level._id_A54E, "j_head");
  level.player playSound("mars_crash_end_rain");
  wait 3;
  stopFXOnTag(scripts\engine\utility::getfx("vfx_mars_sparks_kashima_helmet_runner"), level._id_A54E, "j_head");
}

_id_30F8(var_0) {
  scripts\sp\anim::_id_1F35(var_0, "kash_death_pressure_wait_exit");
  var_0 delete();
}

_id_4872() {
  var_0 = scripts\engine\utility::getStruct("crawling_marine", "targetname");
  var_1 = getEnt("sp_crash_site_crawler", "targetname");
  var_1._id_ED1B = 1;
  var_2 = var_1 scripts\sp\utility::_id_10619(1);
  var_2 scripts\sp\utility::_id_86E4();
  var_2._id_1FBB = "crawler_guy";
  var_0 scripts\sp\anim::_id_1EC3(var_2, "crash_site_crawler");
  scripts\engine\utility::flag_wait("flag_crawler_guy");

  while(!level.player scripts\sp\utility::_id_3849(var_2 gettagorigin("j_head"))) {
    scripts\engine\utility::waitframe();
  }

  var_0 scripts\sp\anim::_id_1F35(var_2, "crash_site_crawler");
  var_2 _meth_81D0();
}

_id_436F() {
  var_0 = scripts\engine\utility::getStruct("dropship_marine", "targetname");
  var_1 = getEnt("sp_crash_site_collapser", "targetname");
  var_1._id_ED1B = 1;
  var_2 = var_1 scripts\sp\utility::_id_10619(1);
  var_2 scripts\sp\utility::_id_86E4();
  var_2._id_1FBB = "collapser_guy";
  var_0 scripts\sp\anim::_id_1EC3(var_2, "crash_site_collapser");
  scripts\engine\utility::flag_wait("flag_collapser_guy");
  var_2 thread _id_4370();
  var_0 scripts\sp\anim::_id_1F35(var_2, "crash_site_collapser");
  var_2 _meth_81D0();
}

_id_4370() {
  self endon("death");
  scripts\sp\utility::_id_75C4("vfx_mars_fire_player_arm_left", "j_shoulder_le");
  scripts\sp\utility::_id_75C4("vfx_mars_fire_player_arm_right", "j_shoulder_ri");
  scripts\sp\utility::_id_75C4("vfx_mars_fire_player_chest", "j_chest");
  scripts\sp\utility::_id_75C4("vfx_mars_fire_player_legs", "j_hip_le");
  scripts\sp\utility::_id_75C4("vfx_mars_fire_player_legs", "j_hip_ri");
  level waittill("collapser_guy_landed");
  scripts\engine\utility::exploder("vfx_exp_dust_impact");
  stopFXOnTag(scripts\engine\utility::getfx("vfx_mars_fire_player_arm_left"), self, "j_shoulder_le");
  scripts\engine\utility::waitframe();
  stopFXOnTag(scripts\engine\utility::getfx("vfx_mars_fire_player_arm_right"), self, "j_shoulder_ri");
  scripts\engine\utility::waitframe();
  stopFXOnTag(scripts\engine\utility::getfx("vfx_mars_fire_player_chest"), self, "j_chest");
  scripts\engine\utility::waitframe();
  stopFXOnTag(scripts\engine\utility::getfx("vfx_mars_fire_player_legs"), self, "j_hip_le");
  scripts\engine\utility::waitframe();
  stopFXOnTag(scripts\engine\utility::getfx("vfx_mars_fire_player_legs"), self, "j_hip_ri");
  scripts\engine\utility::waitframe();
  scripts\sp\utility::_id_75C4("vfx_mars_embers_player_arms", "j_shoulder_le");
  scripts\sp\utility::_id_75C4("vfx_mars_embers_player_arms", "j_shoulder_ri");
  scripts\sp\utility::_id_75C4("vfx_mars_embers_player_chest", "j_chest");
  scripts\sp\utility::_id_75C4("vfx_mars_embers_player_legs", "j_hip_le");
  scripts\sp\utility::_id_75C4("vfx_mars_embers_player_legs", "j_hip_ri");
}

_id_5E09() {
  var_0 = getEnt("fxanim_sp_mars_dropship_debris", "targetname");
  var_0 scripts\sp\utility::_id_23B7("wing");
  var_0 scripts\sp\anim::_id_1F35(var_0, "hanging_wing");
}

_id_A545() {
  level waittill("player_looks_up");
  scripts\engine\utility::exploder("vfx_exp_cockpit_elec_burst");
  level waittill("player_looks_up");
  scripts\engine\utility::exploder("vfx_exp_cockpit_elec_burst");
  level waittill("kash_grabs_arm");
  level waittill("player_looks_up");
  scripts\engine\utility::exploder("vfx_exp_cockpit_elec_burst");
}

_id_A544() {
  level endon("kash_dies");
  var_0 = level._id_A54A.node scripts\engine\utility::spawn_tag_origin();
  level._id_A54A._id_CF6A = var_0;
  var_0._id_1684["player"] = level._id_A54A._id_1684["player"];
  var_0 scripts\sp\anim::_id_1F35(var_0._id_1684["player"], "kash_death_pressure_intro");

  for(;;) {
    if(level._id_D86F) {
      if(level._id_D86F) {
        var_0 notify("stop_loop");
        var_0 scripts\sp\anim::_id_1F35(var_0._id_1684["player"], "kash_death_pressure_apply");
        var_0 thread scripts\sp\anim::_id_1EEA(var_0._id_1684["player"], "kash_death_pressure_on");
      }
    } else if(!level._id_D86F) {
      var_0 notify("stop_loop");
      var_0 scripts\sp\anim::_id_1F35(var_0._id_1684["player"], "kash_death_pressure_release");
      var_0 thread scripts\sp\anim::_id_1EEA(var_0._id_1684["player"], "kash_death_pressure_off");
      level.player _meth_8496(&"MARSCRASH_BOTH_TRIGS");
    }

    wait 0.1;
  }
}

_id_A53D() {}

_id_489D(var_0) {
  self._id_1FB3 = spawnStruct();
  self._id_1FB3.origin = var_0.origin;
  self._id_1FB3.angles = var_0.angles;
}

_id_A55E() {
  self.name = "Kashima";
  scripts\sp\utility::_id_86E4();
  self._id_1FBB = "kashima";
  level._id_A54E = self;
  self._id_6B14 = 1;
}

_id_A552() {
  var_0 = spawnStruct();
  var_0.node = scripts\engine\utility::getStruct("kash_death_anim_ent", "targetname");
  var_0._id_99F4 = scripts\engine\utility::getStruct("kash_scene_interact", "targetname");
  var_0._id_1684 = [];
  var_0._id_4E7A = [];
  var_0._id_4E7A[0] = ::scripts\sp\utility::_id_10639("door", var_0.node.origin);
  playFXOnTag(scripts\engine\utility::getfx("vfx_marscrash_door_dmg"), var_0._id_4E7A[0], "tag_origin");
  var_0._id_1684["player"] = ::scripts\sp\utility::_id_10639("player_rig", var_0.node.origin);
  level.player._id_D267 = var_0._id_1684["player"];
  var_0._id_1684["player_bloody"] = ::scripts\sp\utility::_id_10639("player_rig_bloody", var_0.node.origin);
  level.player._id_D267 = var_0._id_1684["player"];
  var_0._id_1684["player_bloody"] _id_489D(var_0.node);
  var_0._id_1684["player_bloody"] hide();
  var_0._id_1684["player"] _id_489D(var_0.node);
  var_0._id_1684["player"] hide();
  scripts\sp\maps\marscrash\marscrash_util::_id_1065E("kash_death_anim_ent");
  var_0._id_1684["brooks"] = level._id_30F6;
  var_0._id_1684["brooks"]._id_1FBB = "brooks";
  var_0._id_1684["kashima"] = ::scripts\sp\utility::_id_107EA("kashima", 1);
  var_0._id_1684["kashima"] _id_A55E();
  var_0._id_1684["kash_brooks"] = [var_0._id_1684["brooks"], var_0._id_1684["kashima"]];
  var_0._id_1684["everyone"] = [var_0._id_1684["player"], var_0._id_1684["brooks"], var_0._id_1684["kashima"], var_0._id_4E7A[0]];
  var_0._id_1684["stars"] = [var_0._id_1684["player"], var_0._id_1684["kashima"]];
  var_0._id_1684["kash_brooks_reyes"] = [var_0._id_1684["brooks"], var_0._id_1684["kashima"], var_0._id_1684["player"]];
  level._id_A54E._id_7429 = "Kashima";
  level._id_30F6._id_7429 = "Brooks";

  foreach(var_2 in var_0._id_1684["kash_brooks"]) {
    var_2 _id_489D(var_0.node);
    var_2 scripts\sp\maps\marscrash\marscrash_util::_id_12984();
  }

  level._id_A54E thread _id_8DE4();
  var_0._id_1684["kashima"] notsolid();
  level thread _id_A548();
  var_0.node thread scripts\sp\anim::_id_1EC1(var_0._id_4E7A, "kash_death_lift");
  var_0.node thread scripts\sp\anim::_id_1EE7(var_0._id_1684["kash_brooks"], "kash_death_start_idle");
  var_4 = getEnt("kashima_door_clip", "targetname");
  var_4 linkTo(var_0._id_4E7A[0]);
  level._id_A54A = var_0;
  scripts\sp\utility::_id_16AE(var_0._id_4E7A[0], "intro_cleanup_ents");
  scripts\sp\utility::_id_16AE(var_0._id_1684["player"], "intro_cleanup_ents");
  scripts\sp\utility::_id_16AE(var_0._id_1684["kashima"], "intro_cleanup_ents");
}

_id_8DE4() {
  scripts\engine\utility::flag_wait("kash_arrive");

  while(!scripts\engine\utility::flag("debris_lift_started")) {
    var_0 = randomfloatrange(0.05, 0.15);
    scripts\sp\maps\marscrash\marscrash_util::_id_12958();
    wait(var_0);
    scripts\sp\maps\marscrash\marscrash_util::_id_12984();
    wait(randomfloatrange(0.05, 0.15));
    scripts\sp\maps\marscrash\marscrash_util::_id_12958();
    wait(randomfloatrange(0.05, 0.15));
    scripts\sp\maps\marscrash\marscrash_util::_id_12984();
    wait(randomfloatrange(0.05, 0.15));
    scripts\sp\maps\marscrash\marscrash_util::_id_12958();
    wait(randomfloatrange(0.05, 0.15));
    scripts\sp\maps\marscrash\marscrash_util::_id_12984();
    wait(randomfloatrange(0.05, 0.15));
    scripts\sp\maps\marscrash\marscrash_util::_id_12958();
    var_0 = randomfloatrange(0.5, 0.7);
    wait(var_0);
    scripts\sp\maps\marscrash\marscrash_util::_id_12984();
    wait(randomfloatrange(0.05, 0.15));
    scripts\sp\maps\marscrash\marscrash_util::_id_12958();
    wait(randomfloatrange(0.05, 0.15));
    scripts\sp\maps\marscrash\marscrash_util::_id_12984();
    var_0 = randomfloatrange(0.5, 0.7);
    wait(var_0);
  }

  wait 0.5;
  var_0 = randomfloatrange(0.05, 0.15);
  scripts\sp\maps\marscrash\marscrash_util::_id_12958();
  wait(var_0);
  scripts\sp\maps\marscrash\marscrash_util::_id_12984();
  wait(randomfloatrange(0.05, 0.15));
  scripts\sp\maps\marscrash\marscrash_util::_id_12958();
  wait(randomfloatrange(0.05, 0.15));
  scripts\sp\maps\marscrash\marscrash_util::_id_12984();
  wait(randomfloatrange(0.05, 0.15));
  scripts\sp\maps\marscrash\marscrash_util::_id_12958();
  wait(randomfloatrange(0.05, 0.15));
  scripts\sp\maps\marscrash\marscrash_util::_id_12984();
  wait(randomfloatrange(0.05, 0.15));
  scripts\sp\maps\marscrash\marscrash_util::_id_12958();
  var_0 = randomfloatrange(0.5, 0.7);
  wait(var_0);
  scripts\sp\maps\marscrash\marscrash_util::_id_12984();
  wait(randomfloatrange(0.05, 0.15));
  scripts\sp\maps\marscrash\marscrash_util::_id_12958();
  wait(randomfloatrange(0.05, 0.15));
  scripts\sp\maps\marscrash\marscrash_util::_id_12984();
  var_0 = randomfloatrange(0.5, 0.7);
  wait(var_0);
  scripts\sp\maps\marscrash\marscrash_util::_id_12984();
  var_0 = randomfloatrange(0.5, 0.7);
  wait(var_0);
  scripts\sp\maps\marscrash\marscrash_util::_id_12958();
}

_id_A548() {
  var_0 = getEnt("kash_death_hanging_body", "targetname");
  var_1 = getEnt("kash_death_hanging_body_02", "targetname");
  var_2 = getEnt("kash_death_hanging_body_03", "targetname");
  var_0._id_ED1B = 1;
  var_1._id_ED1B = 1;
  var_2._id_ED1B = 1;
  var_3 = scripts\sp\utility::_id_107EA("kash_death_hanging_body", 1);
  var_3 scripts\sp\utility::_id_86E4();
  var_3._id_1FBB = "hanging_body";
  var_4 = scripts\sp\utility::_id_107EA("kash_death_hanging_body_02", 1);
  var_4 scripts\sp\utility::_id_86E4();
  var_4._id_1FBB = "hanging_body";
  var_5 = scripts\sp\utility::_id_107EA("kash_death_hanging_body_03", 1);
  var_5 scripts\sp\utility::_id_86E4();
  var_5._id_1FBB = "hanging_body";
  var_6 = scripts\engine\utility::getStruct("s_kash_death_hanging_body", "targetname");
  var_6 thread scripts\sp\anim::_id_1EEA(var_3, "kash_death_hanging_body", "stop_hanging_guy");
  var_6 thread scripts\sp\anim::_id_1EEA(var_4, "kash_death_hanging_body_02", "stop_hanging_guy");
  var_6 thread scripts\sp\anim::_id_1EEA(var_5, "kash_death_hanging_body_03", "stop_hanging_guy");
}

_id_A540() {
  var_0 = level._id_A54A;
  wait 10;

  if(isDefined(var_0._id_A55A)) {
    return;
  }
  var_0._id_99F4 _id_0E46::_id_DFE3();
  level._id_30F6 scripts\sp\utility::_id_10346("marsbase_brk_deepbreathsattaboy");
  var_0._id_99F4 _id_0E46::_id_48C4(undefined, (10, 0, -20), undefined, undefined, 700, 96);
  wait 10;

  if(isDefined(var_0._id_A55A)) {
    return;
  }
  var_0._id_99F4 _id_0E46::_id_DFE3();
  level._id_30F6 scripts\sp\utility::_id_10346("marscrash_brk_youreokaykashimayoure");
  var_0._id_99F4 _id_0E46::_id_48C4(undefined, (10, 0, -20), undefined, undefined, 700, 96);
  wait 10;

  if(isDefined(var_0._id_A55A)) {
    return;
  }
  var_0._id_99F4 _id_0E46::_id_DFE3();
  level._id_30F6 scripts\sp\utility::_id_10346("marsbase_brk_staywithmekash");
  var_0._id_99F4 _id_0E46::_id_48C4(undefined, (10, 0, -20), undefined, undefined, 700, 96);
  wait 10;

  if(isDefined(var_0._id_A55A)) {
    return;
  }
  var_0._id_99F4 _id_0E46::_id_DFE3();
  level._id_30F6 scripts\sp\utility::_id_10346("marsbase_brk_youllbealright");
  var_0._id_99F4 _id_0E46::_id_48C4(undefined, (10, 0, -20), undefined, undefined, 700, 96);
}

_id_A53F() {
  var_0 = level._id_A54A;
  wait 5;

  if(isDefined(var_0._id_A55B)) {
    return;
  }
  var_0._id_1684["kashima"] _id_0E46::_id_DFE3();
  var_0.node notify("stop_loop");
  var_0.node thread scripts\sp\anim::_id_1EEA(var_0._id_1684["kashima"], "kash_death_pressure_wait");
  var_0.node scripts\sp\anim::_id_1F35(var_0._id_1684["brooks"], "kash_death_pressure_wait_nag");
  var_0.node notify("stop_loop");
  var_0.node thread scripts\sp\anim::_id_1EE7(var_0._id_1684["kash_brooks"], "kash_death_pressure_wait");
  var_0._id_1684["kashima"] _id_0E46::_id_48C4("J_chest", (0, 0, 0), undefined, undefined, 128, 64, 0, 0);
}

_id_D10F() {
  return level.player adsButtonPressed() && level.player attackButtonPressed();
}

_id_D110(var_0, var_1) {
  level._id_BF11 = 0;
  level._id_C3CC = 0;
  level endon("kash_dead");

  for(;;) {
    if(_id_D10F()) {
      if(!level._id_BF11) {
        var_0 notify("stop_loop");
        level._id_BF11 = 1;
        level._id_C3CC = 0;
        var_0 scripts\sp\anim::_id_1F35(var_1, "kash_death_pressure_apply");
        var_0 thread scripts\sp\anim::_id_1EEA(var_1, "kash_death_pressure_on");
      }
    } else if(!_id_D10F()) {
      if(!level._id_C3CC) {
        var_0 notify("stop_loop");
        level._id_C3CC = 1;
        level._id_BF11 = 0;
        var_0 scripts\sp\anim::_id_1F35(var_1, "kash_death_pressure_release");
        var_0 thread scripts\sp\anim::_id_1EEA(var_1, "kash_death_pressure_off");
      }
    }

    wait 0.1;
  }
}

_id_A553() {
  level.player notifyonplayercommand("bash_pressed", "+usereload");
  level.player notifyonplayercommand("bash_pressed", "+activate");
  var_0 = level._id_A54A;
  var_1 = var_0._id_1684["everyone"];
  var_0._id_C633 = 1;
  var_2 = getanimlength(%mars_10_2b_kash_dies_mr1_door_lift);
  var_3 = var_2 / var_0._id_C633;
  scripts\engine\utility::flag_init("kashima_blood_started");
  scripts\engine\utility::flag_init("debris_lift_sound_1");
  scripts\engine\utility::flag_init("debris_lift_sound_2");
  scripts\engine\utility::flag_init("debris_lift_sound_3");
  scripts\engine\utility::flag_init("debris_lift_sound_4");

  for(;;) {
    level.player waittill("bash_pressed");
    var_4 = var_0 _id_4E9E(0.25, 1);

    if(isDefined(var_4)) {
      continue;
    }
    var_0.node notify("stop_loop");

    foreach(var_6 in var_1) {
      var_6 _meth_83A1();
    }

    var_0.node scripts\sp\anim::_id_1F2C(var_1, "kash_death_lift");
    level.player playRumbleOnEntity("damage_heavy");
  }
}

_id_4E9D(var_0) {
  self endon("debrislift_pull_failed");
  wait(var_0);
  self notify("debrislift_complete");
  level notify("debrislift_complete");
}

_id_4E9F() {
  self endon("stop_debris_lift");
  self endon("debrislift_complete");
  var_0 = scripts\sp\utility::_id_7DC1("kash_death_lift");
  var_1 = _id_0A1E::_id_2356("Knobs", "body");
  self clearanim(var_1, 0);
  self animmode("zonly_physics");
  self _meth_82A2(var_0, 1, 0.2, level._id_A54A._id_C633);
  level waittill("ever");
}

_id_4E9E(var_0, var_1) {
  self endon("debrislift_complete");
  var_0 = var_0 * 1000;
  var_2 = gettime();

  for(;;) {
    if(gettime() - var_2 > var_0) {
      return;
    }
    var_3 = level.player scripts\engine\utility::waittill_notify_or_timeout_return("bash_pressed", 0.4);

    if(isDefined(var_3)) {
      break;
    }

    var_4 = level.player._id_D267 islegacyagent(level.player._id_D267 scripts\sp\utility::_id_7DC1("kash_death_lift"));

    if(var_4 > 0.1 && !scripts\engine\utility::flag("kashima_blood_started")) {
      scripts\engine\utility::flag_set("kashima_blood_started");
      thread _id_A539(20);
    }

    if(var_4 > 0.008 && !scripts\engine\utility::flag("debris_lift_sound_1")) {
      scripts\engine\utility::flag_set("debris_lift_sound_1");
      level.player._id_D267 playSound("mars_crash_end_lift_door_1_f");
    }

    if(var_4 > 0.244 && !scripts\engine\utility::flag("debris_lift_sound_2")) {
      scripts\engine\utility::flag_set("debris_lift_sound_2");
      level.player._id_D267 playSound("mars_crash_end_lift_door_2_f");
    }

    if(var_4 > 0.48 && !scripts\engine\utility::flag("debris_lift_sound_3")) {
      scripts\engine\utility::flag_set("debris_lift_sound_3");
      level.player._id_D267 playSound("mars_crash_end_lift_door_3_f");
    }

    if(var_4 > 0.717 && !scripts\engine\utility::flag("debris_lift_sound_4")) {
      scripts\engine\utility::flag_set("debris_lift_sound_4");
      level.player._id_D267 playSound("mars_crash_end_lift_door_4_f");
    }
  }

  scripts\engine\utility::flag_clear("kashima_blood_started");
  scripts\engine\utility::flag_clear("debris_lift_sound_1");
  scripts\engine\utility::flag_clear("debris_lift_sound_2");
  scripts\engine\utility::flag_clear("debris_lift_sound_3");
  scripts\engine\utility::flag_clear("debris_lift_sound_4");
  self notify("debrislift_pull_failed");
  level.player._id_D267 stopsounds();
  return 1;
}

_id_A539(var_0) {
  level.player endon("kash_dies");

  for(var_1 = 0; var_1 < var_0; var_1++) {
    var_2 = level._id_A54A._id_1684["kashima"] gettagorigin("j_spine4");
    var_3 = scripts\engine\utility::spawn_tag_origin(var_2 + (0, 0, 1), (0, 0, 0));
    playFXOnTag(scripts\engine\utility::getfx("blood_spurt_large"), var_3, "tag_origin");
    wait(randomfloatrange(0.1, 0.35));
    var_3 delete();
  }
}

_id_A53A(var_0) {
  while(!scripts\engine\utility::flag("kash_heart_stop")) {
    if(!level.player adsButtonPressed() && !level.player attackButtonPressed()) {
      var_1 = level._id_A54A._id_1684["kashima"] gettagorigin("j_spine4");
      var_2 = scripts\engine\utility::spawn_tag_origin(var_1 + (1, 0, 0), (0, 0, 0));
      var_3 = scripts\engine\utility::spawn_tag_origin(var_1 + (-5, 2, 1), (0, 0, 0));
      playFXOnTag(scripts\engine\utility::getfx("blood_spurt_large"), var_2, "tag_origin");
      playFXOnTag(scripts\engine\utility::getfx("blood_spurt_large"), var_3, "tag_origin");
      wait(randomfloatrange(0.1, 0.35));
      stopFXOnTag(scripts\engine\utility::getfx("blood_spurt_large"), var_2, "tag_origin");
      stopFXOnTag(scripts\engine\utility::getfx("blood_spurt_large"), var_3, "tag_origin");
      scripts\engine\utility::waitframe();
      var_2 delete();
      var_3 delete();
    }

    wait 0.05;
  }
}

_id_A547() {
  wait 7;
  scripts\engine\utility::flag_set("kash_heart_stop");
}

_id_A54F() {
  level waittill("debrislift_complete");
  level._id_A54A._id_1684["kashima"] thread _id_4C3E(2);
}

_id_4C3D(var_0) {
  var_1 = self gettagorigin(var_0);
  var_2 = self gettagangles(var_0);
  var_3 = anglesToForward(var_2);
  var_4 = anglestoup(var_2);
  var_5 = anglestoright(var_2);
  var_1 = var_1 + var_3 * -8.5 + var_4 * 5 + var_5 * 0;
  var_6 = bulletTrace(var_1 + (0, 0, 30), var_1 - (0, 0, 100), 0, undefined);

  if(var_6["normal"][2] > 0.9) {
    playFX(level._effect["kashima_blood_pool"], var_1);
  }
}

_id_4C3E(var_0) {
  level endon("bloddsmear_timeout");
  level thread scripts\sp\utility::_id_C12D("bloddsmear_timeout", var_0);
  var_1 = "J_SpineLower";
  var_2 = "tag_origin";
  var_3 = 0.25;
  var_4 = level._effect["crawling_death_blood_smear"];

  while(var_3) {
    var_5 = self gettagorigin(var_1);
    var_6 = self gettagangles(var_2);
    var_7 = anglestoright(var_6);
    var_8 = anglesToForward((270, 0, 0));
    playFX(var_4, var_5, var_8, var_7);
    wait(var_3);
  }
}

_id_A554() {
  level endon("kash_dead");
  wait 2.0;
  thread _id_8CCC();
  var_0 = ["breathing_heartbeat", "breathing_heartbeat_alt"];

  for(;;) {
    level.player playRumbleOnEntity("damage_heavy");
    level.player scripts\sp\utility::play_sound_on_entity(scripts\engine\utility::random(var_0));
    wait(level._id_A54A._id_8CCC);
  }
}

_id_A555() {
  wait 2.0;
  level._id_A54A._id_8CCD = 0.5;
  scripts\sp\utility::_id_56BE("kashima_pressure", 7);
  level._id_A54D _meth_8278(0, 1);
  wait 2.0;
  thread _id_A53A(100);
  level._id_A54A._id_8CCC = 0.5;
  level._id_E7CD = "damage_light";
  thread _id_8CCC();

  while(!scripts\engine\utility::flag("kash_heart_stop")) {
    if(level.player adsButtonPressed() && level.player attackButtonPressed()) {
      scripts\engine\utility::flag_set("pressure_applied");
      playworldsound("breathing_heartbeat", level.player.origin + (0, 0, 40));
      level.player playRumbleOnEntity(level._id_E7CD);
      wait 0.2;
      level.player playRumbleOnEntity(level._id_E7CD);
      wait 0.2;
      level.player stoprumble(level._id_E7CD);
      wait(level._id_A54A._id_8CCD);
    }

    scripts\engine\utility::waitframe();
    scripts\engine\utility::flag_clear("pressure_applied");
  }

  level.player stoprumble(level._id_E7CD);
}

_id_8CCC() {
  wait 10;
  level._id_A54A._id_8CCD = 0.75;
  wait 5;
  level._id_A54A._id_8CCD = 1.25;
  wait 4;
  level._id_A54A._id_8CCD = 1.75;
  wait 4;
  level._id_A54A._id_8CCD = 2.0;
}

_id_5D9E() {
  var_0 = scripts\sp\utility::_id_7A8F();
  self.partnerheli = [];
  var_1 = [];

  foreach(var_3 in var_0) {
    var_4 = spawn("script_model", var_3.origin);
    var_4.angles = var_3.angles;
    var_4 setModel(var_3.model);
    var_1[var_1.size] = var_4;
    var_4.script_noteworthy = var_3.script_noteworthy;

    if(var_4.script_noteworthy == "body_outer") {
      self.partnerheli[var_4.script_noteworthy] = var_4;
      var_4 linkTo(self, "tag_origin");
      self._id_E6E5 = var_4;
      var_4 show();
    }
  }

  foreach(var_4 in var_1) {
    self.partnerheli[var_4.script_noteworthy] = var_4;

    if(var_4.script_noteworthy == "cockpit" || var_4.script_noteworthy == "side_cover" || var_4.script_noteworthy == "body_inner") {
      var_4._id_C008 = 1;
    }

    if(var_4.script_noteworthy == "body_outer") {
      continue;
    } else {
      var_4 linkTo(self._id_E6E5, "tag_origin");
    }

    var_4 show();
  }
}

_id_5D9B(var_0) {
  foreach(var_2 in self.partnerheli) {
    if(var_2 == self._id_E6E5) {
      continue;
    }
    _id_5D9C(var_2);
  }

  if(!isDefined(var_0)) {
    _id_5D9C(self._id_E6E5);
  }
}

_id_5D9D(var_0) {
  foreach(var_2 in var_0) {
    var_3 = self.partnerheli[var_2];
    _id_5D9C(var_3);
    wait(randomfloatrange(0.05, 0.15));
  }
}

_id_5D9C(var_0) {
  if(isDefined(var_0._id_C008)) {
    self.partnerheli[var_0.script_noteworthy] = undefined;

    if(var_0.script_noteworthy != "body_inner") {
      var_0 delete();
    }
  } else {
    if(!isDefined(var_0)) {
      return;
    }
    self.partnerheli[var_0.script_noteworthy] = undefined;
    var_1 = anglesToForward(self.angles);

    if(var_0.script_noteworthy != "body_outer") {
      var_1 = var_1 + (randomfloat(1), 0, randomfloat(1));
    }

    var_2 = self.origin + var_1 * 800;
    var_3 = var_1 * 70000;
    playFX(scripts\engine\utility::getfx("dropship_explode"), var_0.origin);
    playFXOnTag(scripts\engine\utility::getfx("dropship_part_bolted"), var_0, "tag_origin");
    thread scripts\engine\utility::noself_delaycall(6, ::stopfxontag, scripts\engine\utility::getfx("dropship_part_bolted"), var_0, "tag_origin");
    var_0 unlink();

    if(var_0.script_noteworthy == "body_outer") {
      var_4 = undefined;
      var_5 = var_0 _meth_843F();

      if(isDefined(var_5["unscaled"])) {
        var_4 = var_5["unscaled"];
      } else if(isDefined(var_5["scaled"])) {
        var_4 = var_5["scaled"];
      }

      var_4 = scripts\engine\utility::ter_op(isDefined(var_4), var_4, var_0.origin + (0, 0, 70));
      var_0 physicslaunchserver(var_4, var_3);
      return;
    }

    var_0 physicslaunchserver(var_0.origin + scripts\engine\utility::randomvectorrange(-50, 50), var_3);
  }
}

_id_482D() {}