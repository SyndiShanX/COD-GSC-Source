/************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\yard\yard_ending.gsc
************************************************/

_id_6342() {
  setdvarifuninitialized("new_ending", 0);
  precachemodel("sdf_yard_ring_section");
  precachemodel("vm_hero_protagonist_helmet_glass_crack");
  precachemodel("vm_hero_protagonist_helmet_glass_crack_05");
  precachemodel("vm_hero_protagonist_helmet_glass_crack_06");
  precachemodel("vm_hero_protagonist_helmet_glass_crack_07");
  precachemodel("vm_hero_protagonist_helmet_glass_crack_08");
  precacheshader("vfx_ui_player_freeze_overlay_02");
  scripts\engine\utility::flag_init("end_started");
  _id_0BA9::_id_39C7("veh_mil_air_ca_destroyer_yard_end");
}

_id_10C3C() {
  scripts\sp\maps\yard\yard_central::_id_3BE5();
  _id_0F35::main();
  scripts\sp\maps\yard\yard_util::_id_106D9("org_ethan_hack");
  scripts\sp\maps\yard\yard_util::_id_107BE("org_salter_ship");
  level.player scripts\sp\utility::_id_11633(scripts\engine\utility::getStruct("continue_central_hack_ethan_player", "targetname"));
  scripts\sp\maps\yard\yard_util::_id_1723("obj_yard_main", "current", &"YARD_OBJ_TARGET");
  var_0 = getEnt("lift_light", "targetname");

  if(isDefined(var_0))
    var_0 delete();

  thread scripts\sp\maps\yard\yard_central::_id_8E71();
  thread scripts\sp\maps\yard\yard_central::_id_8E78();
}

_id_B1DA() {
  scripts\sp\utility::_id_2669("ending");
  var_0 = scripts\engine\utility::getStruct("ending_anim_struct", "targetname");
  var_0 thread _id_6339();
  thread _id_6355();
  thread ending_preload();
  var_1 = _id_6357();
  var_0 thread _id_633D();
  _id_633C(var_1);
  var_2 = level._id_6337;
  var_2[var_1._id_1FBB] = var_1;
  thread _id_6358();
  thread _id_634E(var_2["destroyer_salter"], var_2["carrier_ram"]);
  thread _id_6343(var_2["ending_missile"]);
  thread _id_6345();
  thread _id_6349();
  thread _id_6344();
  thread _id_6347();
  thread _id_6340();
  level.player scripts\sp\maps\yard\yard_central::_id_13E39();
  var_2["destroyer_salter"] thread _id_634C(var_2["carrier_ram"], var_2["carrier_attack"]);
  scripts\engine\utility::flag_set("end_started");
  var_0 thread scripts\sp\anim::_id_1F2C(var_2, "end_scene");
  scripts\engine\utility::noself_delaycall(2, ::visionsetnaked, "yard_ext_rip", 1);

  foreach(var_4 in level._id_633F)
  var_4 show();

  wait(getanimlength(var_1 scripts\sp\utility::_id_7DC1("end_scene")) - 3);
  var_6 = scripts\sp\hud_util::_id_48B7("black", 0, level.player);
  var_7 = 3;
  var_6 fadeovertime(var_7);
  var_6.alpha = 1;
  var_6.sort = 999;
  wait(var_7);
  wait 3;
  thread ending_epilogue_text();
  wait 2;
  scripts\sp\utility::_id_BF95(12);
}

_id_633C(var_0) {
  thread scripts\sp\maps\yard\yard_central::_id_87A3();
  thread scripts\sp\maps\yard\yard_audio::_id_2585();
  level._id_EAD6 thread scripts\sp\maps\yard\yard_central::_id_F5E7();
  var_0 thread scripts\sp\maps\yard\yard_fx::_id_132FC();
  var_0 thread scripts\sp\maps\yard\yard_central::_id_3BE7();
  var_0 thread scripts\sp\maps\yard\yard_central::_id_3BE4();
  var_1 = scripts\engine\utility::getStruct("org_escape", "targetname");
  var_1 notify("stop_loop");
  var_1 scripts\sp\anim::_id_1F35(var_0, "escape_button_press");
}

_id_633D() {
  thread _id_634F();
  level waittill("end_scene_salter");
  level._id_EAD6._id_1FBB = "destroyer_salter";
  thread scripts\sp\anim::_id_1F35(level._id_EAD6, "escape_button_press");
}

_id_634F() {
  level waittill("ending_salter_pip");
  scripts\sp\pip_util::_id_2ADF("yard_hud_salter_pip_04");
}

_id_6339(var_0) {
  if(!isDefined(var_0))
    wait 10;

  var_1 = [];
  var_2 = level._id_EAD6;
  var_2._id_EF30 = "veh_mil_air_ca_destroyer_yard_end";
  var_2 scripts\engine\utility::delaythread(0.5, _id_0BA9::_id_39C9);
  var_2._id_1FBB = "destroyer_salter";
  var_2 thread _id_5174(1);
  level._id_5301 = var_2;
  var_1[var_2._id_1FBB] = var_2;
  var_3 = scripts\sp\utility::_id_10639("ending_turret");
  var_3 notsolid();
  var_1[var_3._id_1FBB] = var_3;
  var_4 = getEnt("ending_ram_carrier_spawner", "targetname");
  var_4._id_EEF9 = "cannon_small_ca cannon_large_ca missile_tube_ca";
  var_5 = scripts\sp\vehicle::_id_1080C("ending_ram_carrier_spawner");
  var_5 _id_0BB8::_id_39BB();
  var_5 _id_0BB8::_id_3980();
  var_5._id_1FBB = "carrier_ram";
  var_5 thread _id_5174(1);
  var_1[var_5._id_1FBB] = var_5;
  var_4 = getEnt("ending_attack_carrier_spawner", "targetname");
  var_4._id_EEF9 = "cannon_small_ca cannon_large_ca missile_tube_ca";
  var_5 = scripts\sp\vehicle::_id_1080C("ending_attack_carrier_spawner");
  var_5 _id_0BB8::_id_39BB();
  var_5 _id_0BB8::_id_3980();
  var_5._id_1FBB = "carrier_attack";
  var_5 thread _id_5174(1);
  var_1[var_5._id_1FBB] = var_5;
  var_6 = scripts\sp\utility::_id_10639("secret_skelter");
  var_6 notsolid();
  var_6 hide();
  var_6 dontcastshadows();
  var_1[var_6._id_1FBB] = var_6;
  var_7 = scripts\sp\utility::_id_10639("ending_missile");
  var_7 notsolid();
  var_7 dontcastshadows();
  playFXOnTag(scripts\engine\utility::getfx("vfx_yard_impact_missile"), var_7, "tag_origin");
  var_1[var_7._id_1FBB] = var_7;
  level._id_633F = [];

  for(var_8 = 1; var_8 < 14; var_8++) {
    var_9 = scripts\sp\utility::_id_10639("debris_" + var_8);
    var_9 notsolid();
    var_9 hide();
    var_1[var_9._id_1FBB] = var_9;
    level._id_633F[level._id_633F.size] = var_9;
  }

  thread scripts\sp\anim::_id_1EC1(var_1, "end_scene");
  level._id_6337 = var_1;
}

_id_5174(var_0) {
  scripts\engine\utility::flag_wait("end_started");
  wait(getanimlength(scripts\sp\utility::_id_7DC1("end_scene")));

  if(isDefined(var_0))
    _id_0BA9::_id_397B();
  else
    self delete();
}

_id_6355() {
  wait 0.1;
  var_0 = scripts\engine\utility::getStructArray("yard_ring_scriptables", "targetname");
  var_1 = [];

  foreach(var_3 in var_0) {
    var_4 = spawn("script_model", var_3.origin);
    var_4 setModel("sdf_yard_ring_section");
    var_4.angles = var_3.angles;
    var_1[var_1.size] = var_4;

    if(isDefined(var_3.script_noteworthy))
      var_4 thread _id_634A(var_3.script_noteworthy);
  }

  scripts\engine\utility::flag_wait("end_started");
  level thread scripts\sp\utility::_id_C12D("ring_r_1_explode", 25.75);
  level thread scripts\sp\utility::_id_C12D("ring_r_2_explode", 26.75);
  level thread scripts\sp\utility::_id_C12D("ring_r_3_explode", 27.75);
  var_6 = 35.95;

  for(var_7 = 4; var_7 < 11; var_7++) {
    level thread scripts\sp\utility::_id_C12D("ring_r_" + var_7 + "_explode", var_6);
    var_6 = var_6 + randomfloatrange(1, 1.25);
  }
}

_id_634A(var_0) {
  level waittill(var_0 + "_explode");
  self setscriptablepartstate("root", "dead");
}

_id_634B() {
  wait 38.5;
  scripts\engine\utility::exploder("yard_space_station_ram");
}

_id_5302() {
  wait 30.5;
  var_0 = [];
  var_1 = ["veh_mil_air_ca_destroyer_scr_craters_03", "veh_mil_air_ca_destroyer_scr_12", "veh_mil_air_ca_destroyer_scr_craters_02", "veh_mil_air_ca_destroyer_scr_08", "veh_mil_air_ca_destroyer_scr_craters_01", "veh_mil_air_ca_destroyer_scr_01", "veh_mil_air_ca_destroyer_scr_craters_01", "veh_mil_air_ca_destroyer_scr_03"];

  foreach(var_10, var_3 in level._id_EAD6._id_EF3C) {
    if(!scripts\engine\utility::array_contains(var_1, var_3.model)) {
      continue;
    }
    var_4 = _id_EF2D(var_3.model);

    foreach(var_6 in var_4) {
      if(var_6 == "tag_origin") {
        continue;
      }
      var_7 = var_3 gettagorigin(var_6);
      var_8 = spawnStruct();
      var_8.origin = var_7;
      var_0[var_0.size] = var_8;
    }
  }

  var_11 = sortbydistance(var_0, level.player.origin);
  var_12 = scripts\engine\utility::array_reverse(var_11);

  foreach(var_8 in var_12)
  radiusdamage(var_8.origin, 1, 99999, 99999);
}

_id_52EE(var_0) {
  var_1 = level._id_EAD6._id_EF3C[var_0];
  var_2 = _id_EF2D(var_1.model);

  foreach(var_4 in var_2) {
    if(var_4 == "tag_origin") {
      continue;
    }
    var_5 = var_1 gettagorigin(var_4);
    radiusdamage(var_5, 1, 99999, 99999);
  }
}

_id_EF2D(var_0) {
  var_1 = [];
  var_2 = getnumparts(var_0);

  for(var_3 = 0; var_3 < var_2; var_3++) {
    var_4 = tolower(getpartname(var_0, var_3));
    var_1[var_1.size] = var_4;
  }

  return var_1;
}

_id_6357() {
  var_0 = scripts\sp\player_rig::get_player_score();
  var_1 = 0;
  level.player playerlinktodelta(var_0, "tag_player", 1, var_1, var_1, var_1, var_1, 1);
  level.player setplayerangles(var_0 gettagangles("tag_player"));
  level.player _meth_80CB(1);
  level.player setstance("stand");
  level.player allowprone(0);
  level.player allowcrouch(0);
  level.player allowreload(0);
  level.player scripts\engine\utility::allow_offhand_weapons(0);
  level.player scripts\engine\utility::allow_weapon_switch(0);
  level.player scripts\engine\utility::allow_usability(0);
  level.player scripts\engine\utility::allow_weapon(0);
  return var_0;
}

_id_6343(var_0) {
  level waittill("ending_missile_explode");
  thread _id_52EE(15);
  playFX(scripts\engine\utility::getfx("vfx_yard_missile_impact"), var_0.origin);
  level.player playRumbleOnEntity("artillery_rumble");
  earthquake(0.25, 1, var_0.origin, 999999);
  var_0 delete();
}

_id_634E(var_0, var_1) {
  level waittill("carrier_start_ram");
  level.player _meth_8244("steady_rumble");
  var_1 playSound("yard_capship_collide_pt1");
  level._id_3AC0 = var_1.origin;
  thread _id_EA82();
  thread _id_EA83(var_0, var_1);
  level waittill("carrier_end_ram");
  var_2 = scripts\engine\utility::spawn_tag_origin();
  var_2.origin = var_0.origin;
  var_2.angles = var_0.angles;
  var_2 linkTo(var_0);
  playFXOnTag(scripts\engine\utility::getfx("vfx_yard_capship_smolder"), var_2, "tag_origin");
  radiusdamage(level.player.origin, 9999, 25, 25);
  level.player stoprumble("steady_rumble");
}

_id_EA83(var_0, var_1) {
  level endon("carrier_end_ram");

  for(var_2 = 0; var_2 < 10; var_2++) {
    var_3 = anglesToForward(var_1.angles);
    var_4 = anglestoup(var_1.angles);
    var_5 = anglestoright(var_1.angles) * -1;
    var_6 = var_1.origin + var_3 * 14000;
    var_6 = var_6 + var_5 * 2000;
    var_6 = var_6 + var_4 * 500;
    level._id_3AC0 = var_6;
    playFX(scripts\engine\utility::getfx("vfx_heist_cap_ship_ram_expl"), var_6);
    wait 0.25;
  }
}

_id_EA82() {
  level endon("carrier_end_ram");

  for(;;) {
    earthquake(0.55, 1, level._id_3AC0, 5500);
    wait 0.05;
  }
}

_id_6350(var_0) {
  playFXOnTag(scripts\engine\utility::getfx("vfx_yard_cannon_muzflash"), var_0, "tag_flash_1");
  var_0 thread scripts\sp\utility::play_sound_on_entity("tigris_cannon_fire");
  earthquake(0.15, 1, var_0.origin, 999999);
  level.player playRumbleOnEntity("artillery_rumble");
}

_id_6351(var_0) {
  playFXOnTag(scripts\engine\utility::getfx("vfx_yard_cannon_muzflash"), var_0, "tag_flash_2");
  var_0 thread scripts\sp\utility::play_sound_on_entity("tigris_cannon_fire");
  earthquake(0.15, 1, var_0.origin, 999999);
  level.player playRumbleOnEntity("artillery_rumble");
}

_id_6349() {
  scripts\sp\utility::_id_228A(getEntArray("ending_explode_capitalships", "targetname"));
  var_0 = scripts\sp\vehicle::_id_1080E("ending_ring_capitalships");
  var_1 = scripts\sp\utility::_id_2299(var_0);

  foreach(var_3 in var_1)
  var_3 _id_0BB8::_id_39BB();

  level waittill("capital_ship_explode_1");
  var_1[0] thread _id_633B(undefined, 5);
  level waittill("capital_ship_explode_2");
  var_1[1] thread _id_633B(1);
}

_id_633B(var_0, var_1) {
  if(isDefined(var_0) && var_0) {
    self._id_10250 = 1;
    self._id_12FF3 = 1;
    var_2 = _id_0BA9::_id_39AA(self.origin, 1);
    var_2 notsolid();

    foreach(var_4 in var_2._id_CB53)
    var_4 notsolid();
  } else {
    self notify("death");
    scripts\engine\utility::waitframe();

    if(isDefined(var_1))
      wait(var_1);

    _id_0BA9::_id_397B();
  }
}

sfx_ending_debris_hits() {
  level waittill("hit_debris_1");
  level.player playSound("yard_plr_impact_effort1");
  level waittill("hit_debris_2");
  level.player playSound("scn_yard_plr_debris_impact_02_lr");
  level.player playSound("yard_plr_impact_effort2");
  level waittill("hit_ship_1");
  level.player playSound("scn_yard_plr_ship_impact_01_lr");
  level.player scripts\engine\utility::delaycall(0.9, ::playsound, "scn_yard_onboard_ship_explos_lr");
  level.player scripts\engine\utility::delaycall(3.1, ::playsound, "scn_yard_plr_ship_impact_02_lr");
  level waittill("player_grab_ship");
  level.player playSound("scn_yard_plr_ship_grab_01");
  level.player playSound("yard_plr_grab_hold");
  level.player scripts\engine\utility::delaycall(8.53, ::playsound, "yard_capship_pre_collide");
  level.player scripts\engine\utility::delaycall(2.4, ::playsound, "scn_yard_cls_cannon_seq_fire_lr");
  level waittill("carrier_end_ram");
  level.player playSound("yard_plr_grab_release");
  level.player scripts\engine\utility::delaycall(4.1, ::playsound, "scn_yard_explos_seq_metal_structure_lr");
  level.player scripts\engine\utility::delaycall(5.0, ::playsound, "scn_yard_crump_dist_explos");
}

_id_6345() {
  level.player _meth_8244("steady_rumble");
  level.player scripts\engine\utility::delaycall(2, ::stoprumble, "steady_rumble");
  thread sfx_ending_debris_hits();
  level waittill("hit_debris_1");
  thread _id_633A();
  earthquake(0.15, 1, level.player.origin, 999999);
  level.player playRumbleOnEntity("artillery_rumble");
  radiusdamage(level.player.origin, 9999, 25, 25);
  level waittill("hit_debris_2");
  thread _id_633A();
  earthquake(0.15, 1, level.player.origin, 999999);
  level.player playRumbleOnEntity("artillery_rumble");
  radiusdamage(level.player.origin, 9999, 25, 25);
  level waittill("hit_ship_1");
  thread _id_633A();
  earthquake(0.15, 1, level.player.origin, 999999);
  level.player playRumbleOnEntity("artillery_rumble");
  radiusdamage(level.player.origin, 9999, 25, 25);
  level waittill("player_grab_ship");
  earthquake(0.15, 1, level.player.origin, 999999);
  level.player playRumbleOnEntity("artillery_rumble");
}

_id_634C(var_0, var_1) {
  level._id_B81B = 30;
  thread _id_0BB6::_id_3966(1, 1, var_1);
  var_1 thread _id_0BB6::_id_3966(1, 1, self);
  var_0 thread _id_0BB6::_id_3966(1, 1, self);
  var_0 scripts\engine\utility::delaythread(10, _id_0BB6::_id_3983, self);
  scripts\engine\utility::delaythread(13, _id_0BB6::_id_3983, var_0);
  scripts\engine\utility::delaythread(35, ::_id_634D, 8, var_0);
  scripts\engine\utility::delaythread(40, ::_id_634D, 1000, var_1);
  wait 30;
  self solid();
  var_1 solid();
  var_0 solid();
}

_id_634D(var_0, var_1) {
  var_2 = gettime();
  var_0 = var_0 * 1000;
  var_3 = ["amb_missile_l_1", "amb_missile_l_2", "amb_missile_l_3", "amb_missile_l_4", "amb_missile_l_5", "amb_missile_l_6", "amb_missile_r_1", "amb_missile_r_2", "amb_missile_r_3", "amb_missile_r_4", "amb_missile_r_5", "amb_missile_r_6"];

  while(gettime() - var_2 < var_0) {
    var_4 = undefined;

    if(!isarray(var_1)) {
      var_5 = var_1;
      var_5 endon("death");
      var_6 = ["amb_missile_g_l_1", "amb_turret_l_4", "amb_missile_r_4", "fx_antenna_light_2", "amb_turret_bs_r_2", "amb_turret_l_6"];
      var_7 = scripts\engine\utility::random(var_6);
      var_4 = var_5 gettagorigin(var_7);
      var_4 = var_4 + anglestoup(var_5 gettagangles(var_7)) * 200;
    } else {
      var_8 = scripts\engine\utility::random(var_1);
      var_4 = var_8.origin;
    }

    var_9 = self gettagorigin(scripts\engine\utility::random(var_3));
    var_10 = magicbullet("spaceship_homing_missile_yard", var_9, var_4, level.player);
    var_10 thread scripts\sp\maps\yard\yard_central::_id_5EFC(var_4);
    wait(randomfloatrange(0.1, 0.4));
  }
}

sfx_ending_helmet() {
  var_0 = spawn("script_origin", level.player.origin);
  var_0 linkTo(level.player);
  level waittill("crack_glass_1");
  level.player scripts\engine\utility::delaycall(2.5, ::playsound, "scn_yard_end_explos_init_lr");
  level.player playSound("scn_yard_helmet_crack_01");
  level.player playRumbleOnEntity("artillery_rumble");
  wait 0.2;
  level.player playSound("scn_yard_helmet_air_leak");
  var_0 playLoopSound("plr_helmet_o2_level_low_lp");
  level waittill("crack_glass_2");
  level.player playSound("scn_yard_helmet_crack_02");
  var_0 stoploopsound("plr_helmet_o2_level_low_lp");
  var_0 playLoopSound("plr_helmet_o2_level_critical_lp");
  level.player playRumbleOnEntity("artillery_rumble");
  level waittill("crack_glass_3");
  level.player scripts\engine\utility::delaycall(1.14, ::playsound, "scn_yard_final_big_explo_lr");
  level.player playSound("scn_yard_helmet_crack_03");
  level.player playRumbleOnEntity("artillery_rumble");
  wait 0.5;
  level.player playSound("scn_yard_helmet_spidering");
  level waittill("crack_glass_4");
  level.player playSound("scn_yard_helmet_crack_04");
  var_0 scripts\sp\utility::_id_10460(0.5, 1);
  level.player playRumbleOnEntity("artillery_rumble");
  wait 0.2;
  level.player playSound("scn_yard_helmet_shatter");
  level.player _meth_8244("steady_rumble");
  level.player scripts\engine\utility::delaycall(2, ::stoprumble, "steady_rumble");
  wait 0.1;
  level.player playSound("scn_yard_glass_whoosh_lr");
  wait 1;
  level.player playSound("scn_yard_blackout_end_lr");
}

_id_6347() {
  if(scripts\sp\utility::_id_93A6())
    level.player.helmet = level._id_10964.helmet;

  thread sfx_ending_helmet();
  level waittill("crack_glass_1");
  level.player.helmet attach("vm_hero_protagonist_helmet_glass_crack_05", "tag_origin");
  playFXOnTag(scripts\engine\utility::getfx("vfx_yard_player_visor_break"), level.player.helmet, "tag_origin");
  level waittill("crack_glass_2");
  level.player.helmet detach("vm_hero_protagonist_helmet_glass_crack_05", "tag_origin");
  level.player.helmet attach("vm_hero_protagonist_helmet_glass_crack_06", "tag_origin");
  level waittill("crack_glass_3");
  level.player.helmet detach("vm_hero_protagonist_helmet_glass_crack_06", "tag_origin");
  level.player.helmet attach("vm_hero_protagonist_helmet_glass_crack_07", "tag_origin");
  level waittill("crack_glass_4");
  level.player.helmet detach("vm_hero_protagonist_helmet_glass_crack_07", "tag_origin");
  level.player.helmet attach("vm_hero_protagonist_helmet_glass_crack_08", "tag_origin");
  level.player.helmet detach("vm_hero_protagonist_helmet_glass_crack_08", "tag_origin");
  var_0 = scripts\sp\utility::_id_10639("glass_break");
  var_0 _meth_81E2(level.player, "tag_origin", (0, 0, 0), (0, 0, 0), 1);
  var_0 thread scripts\sp\anim::_id_1F35(var_0, "end_scene");
  thread _id_7451();
}

_id_7451() {
  level._id_7452 = newclienthudelem(level.player);
  level._id_7452.foreground = 1;
  level._id_7452.alignx = "left";
  level._id_7452.aligny = "top";
  level._id_7452.horzalign = "fullscreen";
  level._id_7452.vertalign = "fullscreen";
  level._id_7452 setshader("vfx_ui_player_freeze_overlay_02", 640, 480);
  level._id_7452.alpha = 0;
  level._id_7452 scripts\sp\hud_util::_id_6AAB(0.75, 12);
}

_id_6340() {
  wait 5.0;
  _id_0B0A::_id_583F(10.0, 200, 4.0, 400, 30000, 2.0, 0.25);
  wait 12.0;
  _id_0B0A::_id_583F(0.0, 0, 4.0, 400, 30000, 6.0, 0.5);
  wait 6.0;
  _id_0B0A::_id_583F(10, 1500, 4.0, 0, 0, 0.0, 1.0);
  wait 8.0;
  _id_0B0A::_id_583F(10, 1500, 4.0, 25000, 90000, 2.0, 3.0);
  wait 8.0;
  _id_0B0A::_id_583F(0, 0, 2.0, 125000, 168000, 2.0, 2.0);
}

_id_6344() {
  wait 68;
  scripts\sp\utility::_id_C27C(scripts\sp\utility::_id_C264("obj_yard_main"));
}

_id_633A() {
  var_0 = scripts\sp\hud_util::_id_48B7("black", 0.5, level.player);
  var_1 = 0.1;
  var_0 fadeovertime(var_1);
  var_0.alpha = 0;
  wait(var_1);
  var_0 destroy();
}

ending_preload() {
  wait 1;
  thread scripts\sp\utility::_id_1264E("yard_base_tr");
  scripts\engine\utility::flag_wait("end_started");
  level thread scripts\sp\utility::_id_BF97();
}

ending_epilogue_text() {
  setomnvar("ui_epilogue_lines", 0);
  wait 1;
  thread _id_6680();
  setomnvar("ui_epilogue_line1", "shipcrib_epilogue_line1");
  setomnvar("ui_epilogue_line2", "shipcrib_epilogue_line2");
  setomnvar("ui_epilogue_line3", "shipcrib_epilogue_line3_alt");
  setomnvar("ui_epilogue_line4", "shipcrib_epilogue_line4");
  setomnvar("ui_epilogue_lines", 1);
  wait 11;
  setomnvar("ui_epilogue_lines", 0);
}

_id_6680() {
  var_0 = 1.7;
  thread _id_CE71(1);
  wait(var_0);
  thread _id_CE71(1.2);
  wait(var_0);
  thread _id_CE71(0.6);
  wait(var_0);
  _id_CE71(0.8);
  level waittill("second_text");
}

_id_CE71(var_0, var_1) {
  var_2 = "ui_chyron_box_lp";
  var_3 = spawn("script_origin", level.player.origin);
  var_3 linkTo(level.player);

  if(isDefined(var_1))
    var_3 _meth_8278(var_1);

  var_3 playLoopSound(var_2);
  wait(var_0);
  var_3 stoploopsound(var_2);
  wait 0.1;
  var_3 delete();
}

_id_3B65() {}

_id_6358() {}

_id_6359() {
  thread ending_epilogue_text();
  var_0 = scripts\engine\utility::getStruct("ending_anim_struct", "targetname");
  scripts\sp\maps\yard\yard_central::_id_3BE5();
  var_0 _id_6339(1);
  var_1 = _id_6357();
  thread _id_6355();
  level._id_6337[var_1._id_1FBB] = var_1;
  var_0 thread scripts\sp\anim::_id_1F2C(level._id_6337, "end_scene");
  scripts\engine\utility::waitframe();
  var_0 scripts\sp\anim::_id_1F27(level._id_6337, "end_scene", 10);
  wait 4;
  var_0 scripts\sp\anim::_id_1F27(level._id_6337, "end_scene", 1);
}