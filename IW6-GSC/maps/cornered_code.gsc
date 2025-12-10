/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\cornered_code.gsc
*****************************************************/

setup_common() {
  level.const_baker = 0;
  level.const_rorke = 1;
  level.decrementing_slide = 0;
}

setup_player() {
  var_0 = level.start_point + "_start";
  var_1 = common_scripts\utility::getstruct(var_0, "targetname");

  if(isDefined(var_1)) {
    level.player setorigin(var_1.origin);

    if(isDefined(var_1.angles))
      level.player setplayerangles(var_1.angles);
    else
      iprintlnbold("Your script_struct " + level.start_point + "_start has no angles! Set some.");
  } else {}

  setup_common();
  level.player player_flap_sleeves_setup();

  if(isDefined(level.start_point) && level.start_point != "default" && level.start_point != "intro" && level.start_point != "e3" && level.start_point != "zipline") {
    return;
  }
  level.player thread setup_rooftop_dof();
}

spawn_allies() {
  if(is_e3() && isDefined(level.allies) && level.allies.size == 2) {
    return;
  }
  maps\_utility::add_global_spawn_function("allies", ::disable_sniper_glint);
  level.allies = [];
  level.allies[0] = spawn_ally("baker");
  level.allies[0].animname = "baker";
  level.allies[1] = spawn_ally("rorke");
  level.allies[1].animname = "rorke";
  level.allies[1].grenadeammo = 0;

  if(is_e3()) {
    level.allies[0].name = "";
    level.allies[1].name = "";
  }

  maps\_utility::flavorbursts_off("allies");
}

spawn_ally(var_0, var_1) {
  var_2 = undefined;

  if(!isDefined(var_1))
    var_2 = level.start_point + "_" + var_0;
  else
    var_2 = var_1 + "_" + var_0;

  var_3 = var_0;

  if(var_0 == "rorke" && getdvar("intro_mask") != "0" && isDefined(level.start_point) && level.start_point != "default" && level.start_point != "intro" && level.start_point != "e3")
    var_3 = "rorke_mask";

  var_4 = spawn_targetname_at_struct_targetname(var_3, var_2);

  if(!isDefined(var_4))
    return undefined;

  var_4 maps\_utility::make_hero();

  if(!isDefined(var_4.magic_bullet_shield))
    var_4 maps\_utility::magic_bullet_shield();

  var_4 maps\_utility::disable_surprise();

  if(level.start_point == "bar" || level.start_point == "junction" || level.start_point == "rappel" || level.start_point == "garden" || level.start_point == "hvt_capture" || level.start_point == "stairwell" || level.start_point == "atrium")
    var_4 maps\_utility::forceuseweapon("kriss+eotechsmg_sp+silencer_sp", "primary");
  else
    var_4 maps\_utility::forceuseweapon("imbel+acog_sp+silencer_sp", "primary");

  var_4.lastweapon = var_4.weapon;

  if(level.start_point != "intro") {}

  return var_4;
}

spawn_targetname_at_struct_targetname(var_0, var_1) {
  var_2 = getent(var_0, "targetname");
  var_3 = common_scripts\utility::getstruct(var_1, "targetname");

  if(isDefined(var_2) && isDefined(var_3)) {
    var_2.origin = var_3.origin;

    if(isDefined(var_3.angles))
      var_2.angles = var_3.angles;

    var_4 = var_2 maps\_utility::spawn_ai();
    return var_4;
  }

  if(isDefined(var_2)) {
    var_4 = var_2 maps\_utility::spawn_ai();
    iprintlnbold("Add a script struct called: " + var_1 + " to spawn him in the correct location.");
    var_4 teleport(level.player.origin, level.player.angles);
    return var_4;
  }

  iprintlnbold("failed to spawn " + var_0 + " at " + var_1);
  return undefined;
}

ally_goggle_glow_on() {
  var_0 = self gettagorigin("j_head");
  var_1 = self gettagangles("j_head");
  var_2 = spawn("script_model", var_0);
  var_2.angles = var_1;
  var_2 setModel("head_cnd_test_goggles_glow");
  waittillframeend;
  var_2 linkto(self, "j_head");
  self.glowmodel = var_2;
}

ally_goggle_glow_off() {
  self.glowmodel unlink();
  self.glowmodel delete();
}

cornered_falling_death() {
  level endon("c_rappel_player_on_rope");
  level endon("player_is_starting_zipline");
  level endon("player_has_exited_the_building");

  while(!level.player istouching(self))
    wait 0.1;

  if(level.player getstance() != "stand")
    level.player setstance("stand");

  var_0 = maps\_utility::spawn_anim_model("player_bldg_fall");
  var_0 hide();
  var_0.origin = level.player.origin;
  var_0.angles = (0, level.player.angles[1], 0);
  level.player playerlinktoblend(var_0, "tag_player", 0.5);

  if(level.player getcurrentweapon() == "imbel+acog_sp+silencer_sp")
    level.player hideviewmodel();

  level.player common_scripts\utility::_disableweapon();
  level.player freezecontrols(1);
  level.player player_hideviewmodelsleeveflaps();
  var_0 thread maps\_anim::anim_single_solo(var_0, "player_icepicker_left_fall");
  common_scripts\utility::flag_set("player_falling");
  level notify("friendlyfire_mission_fail");
  wait 0.5;
  var_0 show();
  wait 3.0;
  setdvar("ui_deadquote", &"CORNERED_FALL_FAIL");
  maps\_utility::missionfailedwrapper();
}

anim_generic_gravity_run(var_0, var_1, var_2, var_3) {
  thread maps\_anim::anim_generic_gravity(var_0, var_1, var_2);

  if(isDefined(var_3))
    var_0 thread maps\_anim::anim_set_rate_internal(var_1, var_3, "generic");

  var_4 = getanimlength(maps\_utility::getanim_generic(var_1));
  wait(var_4 - 0.2);
  var_0 clearanim(maps\_utility::getanim_generic(var_1), 0.2);
  var_0 notify("killanimscript");

  if(isDefined(var_3))
    var_0 maps\_utility::set_moveplaybackrate(var_3);
}

handle_intro_fx() {
  var_0 = getEntArray("intro_fans", "targetname");

  foreach(var_2 in var_0)
  var_2 thread rotatefan();
}

rotatefan() {
  self endon("death");

  for(;;) {
    self rotateyaw(-360, 1);
    wait 1;
  }
}

unlimited_ammo() {
  self endon("death");
  level endon("stop_manage_player_rappel_movement");
  wait 0.1;

  for(;;) {
    var_0 = self getcurrentweapon();

    if(var_0 != "none") {
      var_1 = self getfractionmaxammo(var_0);

      if(var_1 < 0.5)
        self givemaxammo(var_0);
    }

    wait 1;
  }
}

watch_tv_for_damage(var_0, var_1, var_2, var_3) {
  level endon(var_1);
  var_0 setCanDamage(1);
  var_0 waittill("damage");
  radiusdamage(var_0.origin, 20, 200, 150);

  if(isDefined(var_2)) {
    if(isalive(self))
      self notify("enemy_aware");
  }

  if(isDefined(var_0))
    var_0 delete();

  if(isDefined(var_3)) {
    var_3 delete();
    var_4 = getent("building_entry_tv_light", "targetname");

    if(isDefined(var_4))
      var_4 setlightintensity(0.01);
  }
}

check_ai_array_for_death(var_0, var_1, var_2) {
  if(isDefined(var_2))
    maps\_utility::waittill_dead_or_dying(var_0, var_2);
  else
    maps\_utility::waittill_dead_or_dying(var_0);

  common_scripts\utility::flag_set(var_1);
}

death_func() {
  self endon("stop_death_func");
  self.health = 9999;
  var_0 = maps\_utility::getgenericanim("regular_death");
  self.deathanim = var_0[randomint(var_0.size)];
  self waittill("damage", var_1, var_2, var_3, var_4, var_5);
  self notify("enemy_above_shot");
  self notify("stop_loop");

  if(!isDefined(level.enemies_above_killed))
    level.enemies_above_killed = 0;

  level.enemies_above_killed++;

  if(isDefined(var_2) && isplayer(var_2))
    level notify("player_shot_above_enemy");

  if(self.script_noteworthy == "p1_junction") {
    balcony_death_func();
    return;
  }

  if(level.balcony_fall_deaths < 2 && balcony_check()) {
    return;
  }
  self kill();
  level.total_balcony_deaths++;
  level.last_balcony_death = 0;
}

balcony_check() {
  if(!isDefined(self))
    return 0;

  if(self.a.pose == "prone")
    return 0;

  if(!isDefined(self.prevnode))
    return 0;

  if(!isDefined(self.prevnode.script_balcony))
    return 0;

  var_0 = self.angles[1];
  var_1 = self.prevnode.angles[1];
  var_2 = abs(angleclamp180(var_0 - var_1));

  if(var_2 > 45)
    return 0;

  var_3 = distance(self.origin, self.prevnode.origin);

  if(var_3 > 16) {
    if(isDefined(self.isanimating) && !self.isanimating)
      return 0;
  }

  if(level.last_balcony_death)
    return 0;

  if(!level.last_balcony_death) {
    if(isDefined(level.last_balcony_death_time)) {
      var_4 = gettime() - level.last_balcony_death_time;

      if(var_4 < 5000)
        return 0;
    }
  }

  level.last_balcony_death_time = gettime();
  thread balcony_death_func();
  level.balcony_fall_deaths++;
  level.total_balcony_deaths++;
  level.last_balcony_death = 1;
  return 1;
}

balcony_death_func() {
  if(!isalive(self)) {
    return;
  }
  self.dontdonotetracks = 1;
  self.ignoreme = 1;
  self setlookattext("", &"");
  maps\_utility::gun_remove();
  self setCanDamage(0);
  self.team = "neutral";
  self.a.nodeath = 1;
  maps\_utility::magic_bullet_shield();
  self.balcony_death = 1;
  thread watch_hit_player();
  var_0 = randomintrange(1, 3);

  if(var_0 == level.last_balcony_death_idx) {
    var_0++;

    if(var_0 >= 2)
      var_0 = 1;
  }

  level.last_balcony_death_idx = var_0;
  var_1 = "balcony_death_" + var_0;
  self.random_death_anim = var_1;
  self animcustom(::custom_balcony_death_animscript);
}

watch_hit_player() {
  self endon("death");

  for(;;) {
    var_0 = distance(level.player.origin, self.origin);
    var_1 = level.player.maxhealth * 0.5;

    if(var_0 <= 120) {
      level.player enabledeathshield(1);
      level.player dodamage(var_1, level.player.origin);
      level.player enabledeathshield(0);
      break;
    }

    wait 0.05;
  }
}

waittill_enemies_above_killed(var_0, var_1) {
  var_2 = gettime() + var_1 * 1000;

  while(gettime() < var_2) {
    if(level.enemies_above_killed >= var_0) {
      return;
    }
    common_scripts\utility::waitframe();
  }
}

death_only_ragdoll() {
  self stopanimscripted();
  self startragdoll();
}

generic_prop_raven_anim(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  var_9 = undefined;
  var_10 = undefined;

  if(!isDefined(var_5))
    var_5 = 1;

  var_11 = maps\_utility::spawn_anim_model(var_1);

  if(isDefined(var_3))
    var_9 = getent(var_3, "targetname");

  if(isDefined(var_4))
    var_10 = getent(var_4, "targetname");

  var_0 maps\_anim::anim_first_frame_solo(var_11, var_2);
  var_12 = var_11 gettagorigin("J_prop_1");
  var_13 = var_11 gettagangles("J_prop_1");
  var_14 = var_11 gettagorigin("J_prop_2");
  var_15 = var_11 gettagangles("J_prop_2");
  common_scripts\utility::waitframe();

  if(isDefined(var_3) && var_9.classname == "script_model") {
    var_9.origin = var_12;

    if(var_5 == 1)
      var_9.angles = var_13;
  }

  if(isDefined(var_4) && var_10.classname == "script_model") {
    var_10.origin = var_14;

    if(var_5 == 1)
      var_10.angles = var_15;
  }

  common_scripts\utility::waitframe();

  if(isDefined(var_3))
    var_9 linkto(var_11, "J_prop_1");

  if(isDefined(var_4))
    var_10 linkto(var_11, "J_prop_2");

  common_scripts\utility::flag_wait(var_6);

  if(isDefined(self.script_delay))
    wait(self.script_delay);

  var_0 thread maps\_anim::anim_single_solo(var_11, var_2);

  if(isDefined(var_8))
    wait(var_8);
  else
    var_11 waittillmatch("single anim", "end");

  if(isDefined(var_7) && var_7 == 1) {
    if(isDefined(var_3))
      var_9 delete();

    if(isDefined(var_4))
      var_10 delete();

    var_11 delete();
  } else {
    if(isDefined(var_3))
      var_9 unlink();

    if(isDefined(var_4))
      var_10 unlink();

    var_11 delete();
  }
}

setup_object_friction_mass() {
  level.objectmass = [];
  level.objectmass["me_fruit_orange"] = 0.5;
  level.objectmass["me_fruit_mango_green"] = 0.5;
  level.objectmass["me_fruit_mango_redorange"] = 0.5;
  level.objectmass["paris_fruit_apple"] = 0.5;
  level.objectmass["com_computer_keyboard"] = 8;
  level.objectmass["com_computer_mouse"] = 8;
  level.objectmass["com_widescreen_monitor"] = 8;
  level.objectmass["hjk_tablet_01"] = 8;
  level.objectmass["bowl_wood_modern_01"] = 0.75;
  level.objectmass["paris_bookstore_book01"] = 5;
  level.objectmass["paris_bookstore_book02"] = 5;
  level.objectmass["paris_bookstore_book03"] = 5;
  level.objectmass["paris_bookstore_book04"] = 5;
  level.objectmass["paris_bookstore_book05"] = 5;
  level.objectmass["paris_bookstore_book06"] = 5;
  level.objectmass["paris_bookstore_book07"] = 5;
  level.objectmass["paris_bookstore_book08"] = 5;
  level.objectmass["paris_bookstore_book09"] = 5;
  level.objectmass["paris_bookstore_book10"] = 5;
  level.objectmass["paris_bookstore_book11"] = 5;
  level.objectmass["paris_bookstore_book12"] = 5;
  level.objectmass["paris_bookstore_book13"] = 5;
  level.objectmass["paris_bookstore_book14"] = 5;
  level.objectmass["paris_bookstore_book15"] = 5;
  level.objectmass["paris_bookstore_book16"] = 5;
  level.objectmass["paris_bookstore_book17"] = 5;
  level.objectmass["paris_bookstore_book18"] = 5;
  level.objectmass["debris_rubble_chunk_01_phys"] = 20;
  level.objectmass["debris_rubble_chunk_02_phys"] = 20;
  level.objectmass["debris_rubble_chunk_03_phys"] = 20;
  level.objectmass["debris_rubble_chunk_04_phys"] = 20;
  level.objectmass["debris_rubble_chunk_05_phys"] = 20;
  level.objectmass["debris_rubble_chunk_06_phys"] = 20;
  level.objectmass["debris_rubble_chunk_07_phys"] = 20;
  level.objectmass["debris_rubble_chunk_08_phys"] = 20;
  level.objectmass["debris_rubble_chunk_09_phys"] = 20;
  level.objectmass["debris_rubble_chunk_10_phys"] = 20;
  level.objectmass["debris_rubble_chunk_11_phys"] = 20;
  level.objectmass["debris_rubble_chunk_12_phys"] = 20;
  level.objectmass["cnd_coffee_air_pot_open_01"] = 6;
  level.objectmass["cnd_coffee_cup_crunched_01"] = 0.1;
  level.objectmass["cnd_office_chair_01_phys"] = 3;
  level.objectmass["cnd_conference_chair_red_01"] = 3;
  level.objectfriction = [];
  level.objectfriction["me_fruit_orange"] = 0.41;
  level.objectfriction["me_fruit_mango_green"] = 0.43;
  level.objectfriction["me_fruit_mango_redorange"] = 0.43;
  level.objectfriction["paris_fruit_apple"] = 0.41;
  level.objectfriction["com_computer_keyboard"] = 0.3;
  level.objectfriction["com_computer_mouse"] = 0.24;
  level.objectfriction["com_widescreen_monitor"] = 0.45;
  level.objectfriction["hjk_tablet_01"] = 0.27;
  level.objectfriction["bowl_wood_modern_01"] = 0.46;
  level.objectfriction["paris_bookstore_book01"] = 0.3;
  level.objectfriction["paris_bookstore_book02"] = 0.3;
  level.objectfriction["paris_bookstore_book03"] = 0.3;
  level.objectfriction["paris_bookstore_book04"] = 0.3;
  level.objectfriction["paris_bookstore_book05"] = 0.3;
  level.objectfriction["paris_bookstore_book06"] = 0.3;
  level.objectfriction["paris_bookstore_book07"] = 0.3;
  level.objectfriction["paris_bookstore_book08"] = 0.3;
  level.objectfriction["paris_bookstore_book09"] = 0.3;
  level.objectfriction["paris_bookstore_book10"] = 0.3;
  level.objectfriction["paris_bookstore_book11"] = 0.3;
  level.objectfriction["paris_bookstore_book12"] = 0.3;
  level.objectfriction["paris_bookstore_book13"] = 0.3;
  level.objectfriction["paris_bookstore_book14"] = 0.3;
  level.objectfriction["paris_bookstore_book15"] = 0.3;
  level.objectfriction["paris_bookstore_book16"] = 0.3;
  level.objectfriction["paris_bookstore_book17"] = 0.3;
  level.objectfriction["paris_bookstore_book18"] = 0.3;
  level.objectfriction["debris_rubble_chunk_01_phys"] = 0.6;
  level.objectfriction["debris_rubble_chunk_02_phys"] = 0.59;
  level.objectfriction["debris_rubble_chunk_03_phys"] = 0.58;
  level.objectfriction["debris_rubble_chunk_04_phys"] = 0.53;
  level.objectfriction["debris_rubble_chunk_05_phys"] = 0.53;
  level.objectfriction["debris_rubble_chunk_06_phys"] = 0.6;
  level.objectfriction["debris_rubble_chunk_07_phys"] = 0.6;
  level.objectfriction["debris_rubble_chunk_08_phys"] = 0.6;
  level.objectfriction["debris_rubble_chunk_09_phys"] = 0.6;
  level.objectfriction["debris_rubble_chunk_10_phys"] = 0.57;
  level.objectfriction["debris_rubble_chunk_11_phys"] = 0.6;
  level.objectfriction["debris_rubble_chunk_12_phys"] = 0.55;
  level.objectfriction["cnd_coffee_air_pot_open_01"] = 0.5;
  level.objectfriction["cnd_coffee_cup_crunched_01"] = 0.3;
  level.objectfriction["cnd_office_chair_01_phys"] = 0.2;
  level.objectfriction["cnd_conference_chair_red_01"] = 0.2;
}

debris_spawner(var_0, var_1, var_2, var_3, var_4, var_5) {
  level endon("begin_atrium_fall");
  level endon("teleported");

  for(;;) {
    if(isDefined(var_4))
      var_6 = randomintrange(-104, 104);
    else
      var_6 = 0;

    if(isDefined(var_5))
      var_7 = randomintrange(-104, 104);
    else
      var_7 = 0;

    var_8 = randomintrange(0, 16);
    var_9 = randomintrange(0, 12);
    level.randomitem = undefined;
    pick_debris(var_9);
    var_10 = spawn("script_model", self.origin + (var_6, var_7, var_8));
    var_10 setModel(level.randomitem);
    var_11 = var_3;
    var_12 = var_2 * level.objectmass[var_10.model];
    var_13 = var_11 * var_12;
    var_10 physicslaunchclient(var_10.origin, var_13);
    var_10 thread debris_remove_after_time(7.0);
    var_14 = randomfloatrange(var_0, var_1);
    wait(var_14);
  }
}

debris_remove_after_time(var_0) {
  wait(var_0);
  self delete();
}

pick_debris(var_0) {
  switch (var_0) {
    case 0:
      level.randomitem = "debris_rubble_chunk_04_phys";
      break;
    case 1:
      level.randomitem = "debris_rubble_chunk_05_phys";
      break;
    case 2:
      level.randomitem = "debris_rubble_chunk_12_phys";
      break;
    case 3:
      level.randomitem = "com_computer_keyboard";
      break;
    case 4:
      level.randomitem = "com_computer_mouse";
      break;
    case 5:
      level.randomitem = "paris_bookstore_book01";
      break;
    case 6:
      level.randomitem = "paris_bookstore_book02";
      break;
    case 7:
      level.randomitem = "paris_bookstore_book03";
      break;
    case 8:
      level.randomitem = "paris_bookstore_book04";
      break;
    case 9:
      level.randomitem = "paris_bookstore_book05";
      break;
    case 10:
      level.randomitem = "paris_bookstore_book06";
      break;
    case 11:
      level.randomitem = "paris_bookstore_book07";
      break;
    case 12:
      level.randomitem = "paris_bookstore_book08";
      break;
    case 13:
      level.randomitem = "hjk_tablet_01";
      break;
  }
}

littlebird_handle_spotlight(var_0, var_1, var_2, var_3, var_4, var_5) {
  maps\_utility::ent_flag_init("spotlight_on");
  self.spotlight = spawnturret("misc_turret", self gettagorigin("tag_flash"), "heli_spotlight");
  self.spotlight setmode("manual");
  self.spotlight setModel("com_blackhawk_spotlight_on_mg_setup");
  self.spotlight linkto(self, "tag_flash", (0, 0, -7), (-20, 0, 0));
  thread littlebird_spotlight_think(var_0, var_1, var_2, var_3, var_4, var_5);
  thread littlebird_spotlight_death();
}

littlebird_spotlight_death() {
  var_0 = self.spotlight;
  self waittill("death");

  if(isDefined(var_0))
    var_0 delete();
}

littlebird_spotlight_on() {
  playFXOnTag(common_scripts\utility::getfx("spotlight"), self.spotlight, "tag_flash");
}

littlebird_spotlight_off() {
  stopFXOnTag(common_scripts\utility::getfx("spotlight"), self.spotlight, "tag_flash");
}

littlebird_spotlight_think(var_0, var_1, var_2, var_3, var_4, var_5) {
  self endon("death");
  self notify("stop_littlebird_spotlight");
  self endon("stop_littlebird_spotlight");

  if(!isDefined(var_0))
    var_0 = 0;

  if(!isDefined(var_2))
    var_2 = (0, 0, 0);

  if(!isDefined(var_3))
    var_3 = 0;

  if(var_0 > 0)
    maps\_utility::delaythread(var_0, ::littlebird_spotlight_on);
  else
    littlebird_spotlight_on();

  if(isDefined(var_1) && var_1) {
    for(;;) {
      self.spotlight settargetentity(level.player, var_2 + common_scripts\utility::randomvector(var_3));
      wait(randomfloatrange(2, 3));
    }
  } else if(isDefined(var_4)) {
    for(;;) {
      self.spotlight settargetentity(var_4, var_2 + common_scripts\utility::randomvector(var_3));
      wait(randomfloatrange(2, 3));
    }
  } else if(isDefined(var_5)) {
    self.spotlight setconvergencetime(0.5, "yaw");
    self.spotlight setconvergencetime(0.5, "pitch");

    for(;;) {
      var_6 = common_scripts\utility::random(var_5);
      var_7 = randomfloatrange(1.5, 3.0);
      var_8 = 0.0;

      while(var_8 <= var_7) {
        self.spotlight settargetentity(var_6, var_2 + common_scripts\utility::randomvector(var_3));
        var_8 = var_8 + 0.05;
        wait 0.05;
      }
    }
  } else {
    var_9 = anglesToForward(self.spotlight.angles);
    var_10 = spawn("script_origin", self.spotlight.origin + var_9 * 500 + (0, 0, -500));
    var_10 linkto(self);
    self.spotlight settargetentity(var_10, var_2 + common_scripts\utility::randomvector(var_3));
    var_8 = 1;

    for(;;) {
      self.spotlight settargetentity(var_10, var_2 + common_scripts\utility::randomvector(var_3));
      wait(randomfloatrange(2, 3));
    }
  }
}

send_to_node_and_set_flag_if_specified_when_reached(var_0, var_1) {
  maps\_utility::set_goalradius(16);
  self setgoalnode(var_0);

  if(isDefined(var_1)) {
    self waittill("goal");
    common_scripts\utility::flag_set(var_1);
  }
}

temp_dialogue(var_0, var_1, var_2) {
  level notify("temp_dialogue", var_0, var_1, var_2);
  level endon("temp_dialogue");

  if(!isDefined(var_2))
    var_2 = 4;

  if(isDefined(level.tmp_subtitle)) {
    level.tmp_subtitle destroy();
    level.tmp_subtitle = undefined;
  }

  level.tmp_subtitle = newhudelem();
  level.tmp_subtitle.x = -60;
  level.tmp_subtitle.y = -62;
  level.tmp_subtitle settext("^2" + var_0 + ": ^7" + var_1);
  level.tmp_subtitle.fontscale = 1.46;
  level.tmp_subtitle.alignx = "center";
  level.tmp_subtitle.aligny = "middle";
  level.tmp_subtitle.horzalign = "center";
  level.tmp_subtitle.vertalign = "bottom";
  level.tmp_subtitle.sort = 1;
  wait(var_2);
  thread temp_dialogue_fade();
}

temp_dialogue_fade() {
  level endon("temp_dialogue");

  for(var_0 = 1.0; var_0 > 0.0; var_0 = var_0 - 0.1) {
    level.tmp_subtitle.alpha = var_0;
    wait 0.05;
  }

  level.tmp_subtitle destroy();
}

watch_player_pitch_in_volume(var_0, var_1, var_2, var_3, var_4) {
  self endon("death");

  if(isDefined(var_4))
    level endon(var_4);

  var_5 = getent(var_0, "targetname");
  var_5 endon("death");
  var_6 = 0;

  while(!common_scripts\utility::flag(var_2)) {
    var_7 = self getplayerangles()[1];
    var_8 = self getplayerangles()[0];

    if(self istouching(var_5)) {
      if(var_1 == "copymachine") {
        if(var_8 < -30) {
          if(var_7 < 25 && var_7 > -110)
            common_scripts\utility::flag_set(var_2);
        }
      } else if(var_1 == "player_has_looked_up_for_count") {
        if(var_8 < -30) {
          if(var_7 < 50 && var_7 > -30) {
            if(var_6 == var_3)
              common_scripts\utility::flag_set(var_2);
            else
              var_6++;
          } else if(var_6 > 0)
            var_6 = 0;
        }
      } else if(var_1 == "fx") {
        if(var_8 > -30)
          common_scripts\utility::flag_set(var_2);
      } else if(var_1 == "grenade") {
        if(var_8 > -30) {
          if(var_7 > -45 && var_7 < -15) {
            if(var_6 == var_3)
              common_scripts\utility::flag_set(var_2);
            else
              var_6++;
          } else if(var_6 > 0)
            var_6 = 0;
        }
      } else if(var_1 == "rorke_building_entry") {
        if(var_8 > -30) {
          if(var_7 < -25)
            common_scripts\utility::flag_set(var_2);
        }
      }
    }

    common_scripts\utility::waitframe();
  }
}

wait_till_shot(var_0, var_1, var_2) {
  self endon("death");

  if(isDefined(var_0))
    level endon(var_0);

  self addaieventlistener("grenade danger");
  self addaieventlistener("gunshot");
  self addaieventlistener("gunshot_teammate");
  self addaieventlistener("silenced_shot");
  self addaieventlistener("bulletwhizby");
  self addaieventlistener("projectile_impact");
  self waittill("ai_event", var_3);

  if(isDefined(var_1))
    common_scripts\utility::flag_set(var_1);

  if(isDefined(var_2))
    self notify(var_2);
}

alert_all(var_0, var_1, var_2) {
  self endon("death");

  if(isDefined(var_2))
    common_scripts\utility::flag_wait_any("enemies_aware", var_0, var_1, var_2);
  else if(isDefined(var_1))
    common_scripts\utility::flag_wait_any("enemies_aware", var_0, var_1);
  else if(isDefined(var_0))
    common_scripts\utility::flag_wait_any("enemies_aware", var_0);
  else
    common_scripts\utility::flag_wait("enemies_aware");

  self notify("enemy_aware");
}

watch_for_death_and_alert_all_in_volume(var_0, var_1) {
  self endon("enemy_aware");

  if(isDefined(var_0))
    level endon(var_0);

  self waittill("death");
  var_2 = self.volume maps\_utility::get_ai_touching_volume("axis");

  if(isDefined(var_2) && var_2.size != 0) {
    if(isDefined(var_1))
      common_scripts\utility::flag_set(var_1);
    else {
      foreach(var_4 in var_2)
      var_4 notify("enemy_aware");
    }
  }
}

watch_for_player_to_shoot_while_in_volume(var_0, var_1, var_2) {
  notifyoncommand("player_shoots", "+attack");

  while(!common_scripts\utility::flag(var_2)) {
    level.player waittill("player_shoots");

    if(self istouching(var_0)) {
      common_scripts\utility::flag_set(var_1);
      break;
    }

    wait 0.05;
  }
}

waittill_dead_set_flag(var_0, var_1, var_2) {
  level endon("first_floor_enemies_dead");
  var_0 = maps\_utility::array_removedead(var_0);
  maps\_utility::waittill_dead_or_dying(var_0, 1);
  common_scripts\utility::flag_set(var_1);
}

coordinated_kills(var_0, var_1, var_2, var_3, var_4) {
  level endon(var_3);

  if(isDefined(var_4))
    level endon(var_4);

  common_scripts\utility::flag_wait(var_2);
  level.player common_scripts\utility::waittill_notify_or_timeout("damage", 1);

  if(isDefined(var_4))
    ally_stealth_kill(var_0, var_1, var_4);
  else
    ally_stealth_kill(var_0, var_1);
}

ally_to_magicbullet(var_0, var_1, var_2) {
  var_1 = maps\_utility::array_removedead(var_1);
  var_3 = var_1.size;

  if(var_1.size > 0) {
    var_4 = randomint(var_1.size);
    var_5 = var_1[var_4];

    while(isDefined(var_5) && isalive(var_5)) {
      var_6 = var_0 gettagorigin("j_head");
      var_7 = var_5 gettagorigin("j_head");
      var_8 = vectornormalize(var_7 - var_6);
      var_9 = var_6 + var_8 * (distance(var_7, var_6) - 10);
      var_5.health = 1;
      magicbullet(var_0.weapon, var_9, var_7);
      wait 0.1;
    }
  }

  if(isDefined(var_2))
    common_scripts\utility::flag_set(var_2);
}

ally_can_see_any_enemy() {
  var_0 = 0;
  var_1 = getaiarray("axis");

  foreach(var_3 in var_1) {
    if(self cansee(var_3)) {
      var_0 = 1;
      break;
    }
  }

  return var_0;
}

ally_stealth_kill(var_0, var_1, var_2) {
  if(getdvar("useTagFlashSilenced") == "1") {
    ally_to_magicbullet(var_0, var_1, var_2);
    return;
  }

  var_1 = maps\_utility::array_removedead(var_1);

  if(var_1.size > 0) {
    var_0 maps\cornered_code_rappel_allies::ally_rappel_set_perfect_accuracy(1);
    var_0 maps\cornered_code_rappel_allies::ally_rappel_start_shooting();
    maps\_utility::waittill_dead(var_1, var_1.size);
    var_0 maps\cornered_code_rappel_allies::ally_rappel_stop_shooting();
    var_0 maps\cornered_code_rappel_allies::ally_rappel_set_perfect_accuracy(0);
  }

  if(isDefined(var_2))
    common_scripts\utility::flag_set(var_2);
}

time_to_pass_before_hint(var_0, var_1, var_2, var_3, var_4) {
  level.player endon("death");

  if(!isDefined(level.player) || !isalive(level.player)) {
    return;
  }
  if(common_scripts\utility::flag(var_2)) {
    return;
  }
  if(!isDefined(var_3))
    var_3 = 0;

  if(!isDefined(var_4))
    var_4 = 0;

  level endon(var_2);
  wait(var_0);

  for(;;) {
    level.player maps\_utility::ent_flag_waitopen("global_hint_in_use");

    if(!var_3 && var_4 == 0) {
      level.player thread maps\_utility::display_hint(var_1);
      continue;
    }

    if(!var_3) {
      level.player thread maps\_utility::display_hint_timeout_mintime(var_1, 60, var_4);
      continue;
    }

    if(var_4 == 0) {
      level.player thread maps\_utility::display_hint_stick(var_1, "_pc", "_gamepad", "_gamepad_l", "_gamepad_no_glyph", "_gamepad_l_no_glyph", 0);
      continue;
    }

    level.player thread maps\_utility::display_hint_stick_timeout_mintime(var_1, 60, var_4, "_pc", "_gamepad", "_gamepad_l", "_gamepad_no_glyph", "_gamepad_l_no_glyph", 0);
  }
}

watch_player_in_volume(var_0, var_1, var_2, var_3) {
  if(isDefined(var_2))
    level endon(var_2);

  var_4 = 0;

  for(;;) {
    if(level.player istouching(var_0)) {
      if(isDefined(var_3)) {
        if(var_4 == var_3) {
          common_scripts\utility::flag_set(var_1);
          break;
        } else
          var_4++;
      } else {
        common_scripts\utility::flag_set(var_1);
        break;
      }
    } else if(isDefined(var_3)) {
      if(var_4 > 0)
        var_4 = 0;
    }

    wait 0.05;
  }
}

nag_until_flag(var_0, var_1, var_2, var_3, var_4) {
  if(common_scripts\utility::flag(var_1)) {
    return;
  }
  for(var_5 = -1; !common_scripts\utility::flag(var_1); var_3 = var_3 + var_4) {
    var_6 = randomfloatrange(var_2, var_3);
    wait(var_6);
    var_7 = randomint(var_0.size);

    if(var_7 == var_5) {
      var_7++;

      if(var_7 >= var_0.size)
        var_7 = 0;
    }

    var_8 = var_0[var_7];

    if(common_scripts\utility::flag(var_1)) {
      break;
    }

    thread radio_dialog_add_and_go(var_8);
    var_5 = var_7;
    var_2 = var_2 + var_4;
  }
}

entity_cleanup(var_0) {
  if(isDefined(var_0))
    common_scripts\utility::flag_wait(var_0);

  if(isDefined(self))
    self delete();
}

delete_if_defined(var_0) {
  if(isDefined(var_0))
    var_0 delete();
}

custom_fade_out(var_0, var_1, var_2) {
  if(!isDefined(var_0))
    var_0 = 0.3;

  var_3 = maps\_hud_util::get_optional_overlay(var_1);

  if(var_0 > 0)
    var_3 fadeovertime(var_0);

  if(!isDefined(var_2))
    var_3.alpha = 1;
  else
    var_3.alpha = var_2;

  wait(var_0);
}

custom_cornered_stealth_settings() {
  var_0["ai_eventDistDeath"] = [];
  var_0["ai_eventDistPain"] = [];
  var_0["ai_eventDistExplosion"] = [];
  var_0["ai_eventDistBullet"] = [];
  var_0["ai_eventDistFootstep"] = [];
  var_0["ai_eventDistFootstepWalk"] = [];
  var_0["ai_eventDistFootstepSprint"] = [];
  var_0["ai_eventDistGunShot"] = [];
  var_0["ai_eventDistGunShotTeam"] = [];
  var_0["ai_eventDistNewEnemy"] = [];
  var_0["ai_eventDistDeath"]["spotted"] = 1024;
  var_0["ai_eventDistDeath"]["hidden"] = 128;
  var_0["ai_eventDistPain"]["spotted"] = 512;
  var_0["ai_eventDistPain"]["hidden"] = 128;
  var_0["ai_eventDistExplosion"]["spotted"] = 4000;
  var_0["ai_eventDistExplosion"]["hidden"] = 4000;
  var_0["ai_eventDistBullet"]["spotted"] = 768;
  var_0["ai_eventDistBullet"]["hidden"] = 512;
  var_0["ai_eventDistFootstep"]["spotted"] = 256;
  var_0["ai_eventDistFootstep"]["hidden"] = 64;
  var_0["ai_eventDistFootstepWalk"]["spotted"] = 128;
  var_0["ai_eventDistFootstepWalk"]["hidden"] = 32;
  var_0["ai_eventDistFootstepSprint"]["spotted"] = 400;
  var_0["ai_eventDistFootstepSprint"]["hidden"] = 256;
  var_0["ai_eventDistGunShot"]["spotted"] = 1536;
  var_0["ai_eventDistGunShot"]["hidden"] = 1024;
  var_0["ai_eventDistSilencedShot"]["spotted"] = 768;
  var_0["ai_eventDistSilencedShot"]["hidden"] = 512;
  var_0["ai_eventDistGunShotTeam"]["spotted"] = 750;
  var_0["ai_eventDistGunShotTeam"]["hidden"] = 750;
  var_0["ai_eventDistNewEnemy"]["spotted"] = 750;
  var_0["ai_eventDistNewEnemy"]["hidden"] = 512;
  maps\_stealth_utility::stealth_ai_event_dist_custom(var_0);
  var_1["prone"] = 200;
  var_1["crouch"] = 300;
  var_1["stand"] = 400;
  var_2["prone"] = 400;
  var_2["crouch"] = 600;
  var_2["stand"] = 1200;
  maps\_stealth_utility::stealth_detect_ranges_set(var_1, var_2);
  var_3["player_dist"] = 500;
  var_3["sight_dist"] = 500;
  var_3["detect_dist"] = 200;
  maps\_stealth_utility::stealth_corpse_ranges_custom(var_3);
}

custom_bar_stealth_setting() {
  var_0["prone"] = 200;
  var_0["crouch"] = 240;
  var_0["stand"] = 300;
  var_1["prone"] = 300;
  var_1["crouch"] = 400;
  var_1["stand"] = 550;
  maps\_stealth_utility::stealth_detect_ranges_set(var_0, var_1);
  var_2["player_dist"] = 400;
  var_2["sight_dist"] = 400;
  var_2["detect_dist"] = 256;
  maps\_stealth_utility::stealth_corpse_ranges_custom(var_2);
}

custom_bar_enemy_state_spotted(var_0) {
  self.fovcosine = 0.01;
  self.ignoreall = 0;
  self.dontattackme = undefined;
  self.dontevershoot = undefined;

  if(isDefined(self.oldfixednode))
    self.fixednode = self.oldfixednode;

  if(self.type != "dog") {
    self.diequietly = 0;

    if(!isDefined(var_0)) {
      maps\_utility::clear_run_anim();
      maps\_stealth_shared_utilities::enemy_stop_current_behavior();
    }
  } else {
    self.script_growl = undefined;
    self.script_nobark = undefined;
  }

  if(isDefined(var_0)) {
    return;
  }
  if(isDefined(level._stealth.group.spotted_enemy)) {
    var_1 = level._stealth.group.spotted_enemy[self.script_stealthgroup];

    if(isDefined(var_1))
      self getenemyinfo(var_1);
  }
}

ally_stealth_settings() {
  self endon("death");
  level endon("rorke_stealth_end");

  for(;;) {
    common_scripts\utility::flag_waitopen("_stealth_spotted");
    self clearenemy();
    self.grenadeammo = 0;
    self.ignoreme = 1;
    maps\_utility::enable_dontevershoot();
    maps\_utility::enable_cqbwalk();
    maps\_utility::set_ignoreall(1);
    maps\_utility::set_baseaccuracy(1);
    self pushplayer(1);
    common_scripts\utility::flag_wait("_stealth_spotted");
    self.grenadeammo = 3;
    self.ignoreme = 0;
    maps\_utility::disable_dontevershoot();
    maps\_utility::disable_cqbwalk();
    maps\_utility::set_ignoreall(0);
    maps\_utility::set_baseaccuracy(0.75);
    self pushplayer(0);
    self allowedstances("prone", "crouch", "stand");
  }
}

delete_wrapper() {
  self delete();
}

launch_rope(var_0, var_1, var_2, var_3) {
  var_0 maps\_anim::anim_single_solo(var_1, var_2);
  var_0 thread maps\_anim::anim_loop_solo(var_1, var_3, "stop_" + var_3);
  common_scripts\utility::flag_wait("player_detach");
  var_0 notify("stop_" + var_3);
  var_1 delete();
}

delete_building_glow() {
  var_0 = getent("building_glow", "targetname");

  if(isDefined(var_0))
    var_0 delete();
}

delete_window_reflectors() {
  var_0 = getEntArray("window_reflectors", "targetname");

  foreach(var_2 in var_0) {
    if(isDefined(var_2))
      var_2 delete();
  }
}

set_emissive_window_brushes_visible(var_0) {
  if(!isDefined(level.ps3) || !level.ps3) {
    return;
  }
  for(var_1 = 10; var_1 <= 20; var_1++) {
    var_2 = getEntArray("emissive_window_brush_" + var_1, "targetname");

    foreach(var_4 in var_2) {
      if(var_0) {
        var_4 show();
        continue;
      }

      var_4 hide();
    }
  }
}

ai_array_killcount_flag_set(var_0, var_1, var_2, var_3) {
  maps\_utility::waittill_dead_or_dying(var_0, var_1, var_3);
  common_scripts\utility::flag_set(var_2);
}

lerp_entity_to_position_accurate(var_0, var_1, var_2, var_3) {
  var_4 = spawn("script_model", var_0.origin);
  var_4 setModel("tag_origin");
  var_4.angles = var_0.angles;
  var_0 linkto(var_4, "tag_origin", (0, 0, 0), (0, 0, 0));
  var_4 moveto(var_1, var_3);
  var_4 rotateto(var_2, var_3);
  wait(var_3);
  var_4 delete();
}

setup_trig_constants() {
  level.cosine["1"] = cos(1);
  level.cosine["2"] = cos(2);
  level.cosine["3"] = cos(3);
  level.cosine["4"] = cos(4);
  level.cosine["5"] = cos(5);
}

to_string(var_0) {
  return "" + var_0;
}

within_player_rappel_fov_2d(var_0, var_1, var_2) {
  var_3 = self getplayerangles();

  if(isDefined(level.plyr_rpl_groundref))
    var_4 = combineangles(level.plyr_rpl_groundref.angles, var_3);
  else
    var_4 = var_3;

  var_5 = maps\_utility::within_fov_2d(var_0 getEye(), var_4, var_1 gettagorigin("j_spine4"), var_2);
  return var_5;
}

player_get_favorite_enemy(var_0) {
  if(!self adsbuttonpressed()) {
    return;
  }
  var_1 = getaiarray("axis");
  var_2 = undefined;
  var_3 = undefined;
  var_4 = 1;
  var_5 = 5;
  var_6 = 1;
  var_7 = var_0 * var_0;

  for(var_8 = var_4; var_8 <= var_5; var_8 = var_8 + var_6) {
    foreach(var_10 in var_1) {
      if(!within_player_rappel_fov_2d(self, var_10, level.cosine[to_string(var_8)])) {
        continue;
      }
      var_11 = distancesquared(self.origin, var_10.origin);

      if(var_11 > var_7) {
        continue;
      }
      if(!isDefined(var_3) || var_11 < var_3) {
        var_2 = var_10;
        var_3 = var_11;
      }
    }

    if(isDefined(var_2)) {
      break;
    }
  }

  return var_2;
}

rappel_get_angle_facing_wall(var_0) {
  if(var_0 == "combat")
    return -33.7;
  else
    return 90.0;
}

rappel_get_plane_normal_left(var_0) {
  if(var_0 == "combat") {
    var_1 = rappel_get_angle_facing_wall("combat");
    var_2 = var_1 + 180;
    var_3 = (0, var_2, 0);
    var_4 = vectornormalize(anglestoright(var_3));
    return var_4;
  } else
    return (-1, 0, 0);
}

rappel_get_plane_normal_out(var_0) {
  if(var_0 == "combat") {
    var_1 = rappel_get_angle_facing_wall("combat");
    var_2 = var_1 + 180;
    var_3 = (0, var_2, 0);
    var_4 = vectornormalize(anglesToForward(var_3));
    return var_4;
  } else
    return (0, -1, 0);
}

rappel_get_plane_d(var_0, var_1) {
  var_2 = -1 * vectordot(var_0, var_1);
  return var_2;
}

waittill_player_looking_at_rorke(var_0) {
  var_1 = level.allies[level.const_rorke];
  var_2 = 0.7;
  waittill_player_looking_at_ent(var_1, var_0, var_2);
}

waittill_player_looking_at_ent(var_0, var_1, var_2) {
  if(!isDefined(var_2))
    var_2 = 0.9;

  var_3 = gettime() + var_1 * 1000;

  while(gettime() < var_3) {
    var_4 = vectornormalize(var_0.origin - level.player.origin);
    var_5 = get_rappel_player_angles();
    var_6 = anglesToForward(var_5);
    var_7 = vectordot(var_6, var_4);

    if(var_7 >= var_2) {
      return;
    }
    common_scripts\utility::waitframe();
  }
}

get_rappel_player_angles() {
  var_0 = level.player getplayerangles();

  if(!isDefined(level.plyr_rpl_groundref))
    return var_0;

  var_1 = combineangles(level.plyr_rpl_groundref.angles, var_0);
  return var_1;
}

waittill_player_close_to(var_0, var_1) {
  var_2 = var_1 * var_1;

  while(isDefined(var_0)) {
    var_3 = distance2dsquared(level.player.origin, var_0.origin);

    if(var_3 < var_2) {
      break;
    }

    common_scripts\utility::waitframe();
  }
}

#using_animtree("player");

player_flap_sleeves_setup(var_0) {
  if(isDefined(self.sleeve_flap_l) || isDefined(self.sleeve_flap_r)) {
    return;
  }
  if(!isDefined(var_0))
    var_0 = 0;

  self.sleeve_flap_l = spawn("script_model", self.origin);
  self.sleeve_flap_l.angles = self.angles;
  self.sleeve_flap_l setModel("cnd_sleeve_flap_LE");
  self.sleeve_flap_l useanimtree(#animtree);

  if(!var_0) {
    self.sleeve_flap_l linktoplayerview(self, "J_WristTwist_LE", (0, 0, 0), (0, 0, 0), 1);
    self.sleeve_flap_l.is_view_linked = 1;
  } else
    self.sleeve_flap_l linkto(self, "J_WristTwist_LE", (0, 0, 0), (0, 0, 0));

  self.sleeve_flap_r = spawn("script_model", self.origin);
  self.sleeve_flap_r.angles = self.angles;
  self.sleeve_flap_r setModel("cnd_sleeve_flap_RI");
  self.sleeve_flap_r useanimtree(#animtree);

  if(!var_0) {
    self.sleeve_flap_r linktoplayerview(self, "J_WristTwist_RI", (0, 0, 0), (0, 0, 0), 1);
    self.sleeve_flap_r.is_view_linked = 1;
  } else
    self.sleeve_flap_r linkto(self, "J_WristTwist_RI", (0, 0, 0), (0, 0, 0));

  if(!var_0)
    thread player_hide_flaps_death();

  _sleeves_idle();
}

player_hide_flaps_death() {
  self waittill("death");
  player_hideviewmodelsleeveflaps();
}

player_flap_sleeves() {
  if(isDefined(self.sleeves_flapping) && self.sleeves_flapping) {
    return;
  }
  self.sleeves_flapping = 1;
  thread _sleeves_flap_internal();
}

player_stop_flap_sleeves() {
  self.sleeves_flapping = undefined;
  self notify("stop_sleeves");
}

_sleeves_idle(var_0) {
  if(!isDefined(var_0))
    var_0 = 1.0;

  self.sleeve_flap_l setanimknob( % player_sleeve_pose, 1.0, var_0, 1.0);
  self.sleeve_flap_r setanimknob( % player_sleeve_pose, 1.0, var_0, 1.0);
}

_sleeves_flap_internal() {
  var_0 = 0.2;
  var_1 = 5.0;
  var_2 = 0.8;
  var_3 = 1.2;
  var_4 = 0.45;

  while(isDefined(self.sleeves_flapping)) {
    var_5 = randomfloatrange(var_2, var_3);
    var_6 = 0.2;
    var_7 = 0;

    if(isDefined(level.rpl) && isDefined(level.rpl.wind_strength)) {
      var_8 = level.rpl.wind_strength;
      var_5 = clamp(var_8, var_4, var_8);
      var_7 = 1;
    }

    self.sleeve_flap_l setanimknob( % player_sleeve_flapping, 1.0, var_6, var_5);
    self.sleeve_flap_r setanimknob( % player_sleeve_flapping, 1.0, var_6, var_5);
    var_9 = randomfloatrange(var_0, var_1);

    if(var_7)
      var_9 = 0.05;

    var_10 = common_scripts\utility::waittill_notify_or_timeout_return("stop_sleeves", var_9);

    if(!isDefined(var_10)) {
      thread _sleeves_idle();
      return;
    }
  }
}

hide_player_arms() {
  level.cornered_player_arms hide();
  hide_player_arms_sleeve_flaps();
}

show_player_arms() {
  level.cornered_player_arms show();
  show_player_arms_sleeve_flaps();
}

hide_player_arms_sleeve_flaps() {
  if(isDefined(level.cornered_player_arms.sleeve_flap_l))
    level.cornered_player_arms.sleeve_flap_l hide();

  if(isDefined(level.cornered_player_arms.sleeve_flap_r))
    level.cornered_player_arms.sleeve_flap_r hide();
}

show_player_arms_sleeve_flaps() {
  if(isDefined(level.cornered_player_arms.sleeve_flap_l))
    level.cornered_player_arms.sleeve_flap_l show();

  if(isDefined(level.cornered_player_arms.sleeve_flap_r))
    level.cornered_player_arms.sleeve_flap_r show();
}

player_hideviewmodel() {
  self hideviewmodel();
  player_hideviewmodelsleeveflaps();
}

player_showviewmodel() {
  self showviewmodel();
  player_showviewmodelsleeveflaps();
}

player_hideviewmodelsleeveflaps() {
  if(isDefined(self.sleeve_flap_l) && self.sleeve_flap_l.is_view_linked) {
    self.sleeve_flap_l.is_view_linked = 0;
    self.sleeve_flap_l unlinkfromplayerview(self);
    self.sleeve_flap_l hide();
  }

  if(isDefined(self.sleeve_flap_r) && self.sleeve_flap_r.is_view_linked) {
    self.sleeve_flap_r.is_view_linked = 0;
    self.sleeve_flap_r unlinkfromplayerview(self);
    self.sleeve_flap_r hide();
  }
}

player_showviewmodelsleeveflaps() {
  if(isDefined(self.sleeve_flap_l) && !self.sleeve_flap_l.is_view_linked) {
    self.sleeve_flap_l.is_view_linked = 1;
    self.sleeve_flap_l linktoplayerview(self, "J_WristTwist_LE", (0, 0, 0), (0, 0, 0), 1);
    self.sleeve_flap_l show();
  }

  if(isDefined(self.sleeve_flap_r) && !self.sleeve_flap_r.is_view_linked) {
    self.sleeve_flap_r.is_view_linked = 1;
    self.sleeve_flap_r linktoplayerview(self, "J_WristTwist_RI", (0, 0, 0), (0, 0, 0), 1);
    self.sleeve_flap_r show();
  }
}

disable_sniper_glint() {
  self.disable_sniper_glint = 1;
}

ally_get_vertical_stop_anim_distance(var_0) {
  var_1 = self.animname == "rorke" && var_0 == "down_away" || self.animname == "baker" && var_0 == "down_back";
  var_2 = self.animname == "baker" && var_0 == "down_away" || self.animname == "rorke" && var_0 == "down_back";

  if(var_0 == "down")
    return 26.776;
  else if(var_1)
    return 24.982;
  else if(var_2)
    return 40.89;
  else
    return 0;
}

ally_get_horizontal_stop_distance(var_0) {
  if(var_0 == "left")
    return 119.4;
  else
    return 118.1;
}

ally_get_horizontal_start_distance(var_0) {
  if(var_0 == "left")
    return 45.9;
  else
    return 26.56;
}

cleanup_outside_ents_on_entry() {
  var_0 = getEntArray("cnd_wood_furniture_delete", "script_noteworthy");

  foreach(var_2 in var_0)
  var_2 delete();

  var_4 = getEntArray("cnd_garden_chair_02_delete", "script_noteworthy");

  foreach(var_2 in var_4)
  var_2 delete();
}

is_e3() {
  return getdvar("e3", "0") == "1";
}

head_swap(var_0) {
  self detach(self.headmodel, "");
  self attach(var_0, "", 1);
  self.headmodel = var_0;
}

interest_of_time_transition() {
  level.player freezecontrols(1);
  level.player enableinvulnerability();
  var_0 = 2;
  var_1 = 2;
  var_2 = 2;
  thread demo_setup_allies(var_0);
  thread demo_switch_transients(var_0);
  thread demo_switch_checkpoints(var_0);
  thread demo_setup_sound(var_0, var_1, var_2);
  wait(var_0);
  e3_text_hud(&"CORNERED_E3_TIME", var_1);
  thread maps\_hud_util::fade_in(var_2, "black");
  level notify("demo_checkpoint_go");
  wait 0.5;
  level.player freezecontrols(0);
  level.player disableinvulnerability();
}

demo_setup_sound(var_0, var_1, var_2) {
  soundfade(0, var_0);
  wait(var_0);
  maps\_utility::music_stop();

  if(isDefined(level.aud_outside_crowd))
    level.aud_outside_crowd stoploopsound();

  if(isDefined(level.aud_outside_crowd_rear))
    level.aud_outside_crowd_rear stoploopsound();

  if(isDefined(level.aud_outside_music))
    level.aud_outside_music stoploopsound();

  common_scripts\utility::waitframe();
  soundfade(1, var_2);
  thread maps\cornered_audio::aud_collapse("collapse_music");
}

demo_setup_allies(var_0) {
  wait(var_0);

  foreach(var_2 in level.allies)
  var_2 stopanimscripted();

  if(isDefined(level.rorke_inverted_kill_knife))
    level.rorke_inverted_kill_knife delete();
}

demo_switch_checkpoints(var_0) {
  maps\_hud_util::fade_out(var_0, "black");
  maps\cornered::e3_transition_start();
  common_scripts\utility::flag_set("rescue_finished");
  level waittill("demo_checkpoint_go");
  common_scripts\utility::flag_set("inverted_rappel_finished");
}

demo_switch_transients(var_0) {
  wait(var_0);
  maps\_utility::transient_unload("cornered_start_tr");
  maps\_utility::transient_load("cornered_end_tr");
}

end_level() {
  var_0 = 2;
  soundfade(0, var_0);
  maps\_hud_util::fade_out(var_0, "black");
  wait 5;
  setsaveddvar("ui_nextMission", "0");
  changelevel("", 0, 1);
}

e3_text_hud(var_0, var_1) {
  var_2 = 27;
  var_3 = newhudelem();
  var_3.alignx = "center";
  var_3.aligny = "middle";
  var_3.horzalign = "center";
  var_3.vertalign = "middle";
  var_3.x = 0;
  var_3.y = 0;
  var_3 settext(var_0);
  var_3.alpha = 0;
  var_3.font = "objective";
  var_3.foreground = 1;
  var_3.sort = 150;
  var_3.color = (0.85, 0.93, 0.92);
  var_3.fontscale = 1.75;
  var_3 fadeovertime(0.5);
  var_3.alpha = 1;
  var_3 fadeovertime(1);
  var_3.alpha = 1;
  wait 1;
  wait(var_1);
  var_3 fadeovertime(1);
  var_3.alpha = 0;
  wait 1;
  var_3 destroy();
}

waittill_notetrack_type(var_0, var_1) {
  var_1 endon("die");
  self waittill(var_0, var_2);
  var_1 notify("returned", var_2);
}

waittill_single_or_looping_notetrack() {
  var_0 = spawnStruct();
  childthread waittill_notetrack_type("single anim", var_0);
  childthread waittill_notetrack_type("looping anim", var_0);
  var_0 waittill("returned", var_1);
  var_0 notify("die");
  return var_1;
}

ally_rappel_footsteps() {
  self notify("stop_rappel_footsteps");
  self endon("stop_rappel_footsteps");
  var_0 = "left_down";
  var_1 = "right_down";

  for(;;) {
    var_2 = waittill_single_or_looping_notetrack();

    if(var_2 == var_0 || var_2 == var_1)
      thread maps\cornered_audio::aud_rappel("foot_npc");
  }
}

#using_animtree("generic_human");

custom_balcony_death_animscript() {
  self setflaggedanimknoballrestart("deathanim", level.scr_anim[self.animname][self.random_death_anim], % body, 1, 0.1);
  thread translate_off_edge();

  for(;;) {
    self waittill("deathanim", var_0);

    if(var_0 == "start_ragdoll" || var_0 == "end") {
      maps\_utility::stop_magic_bullet_shield();
      self startragdoll();
      self kill();
      break;
    }
  }
}

translate_off_edge() {
  wait 1;
  var_0 = vectornormalize(anglesToForward(self.angles));
  var_1 = -1 * var_0;
  self animmode("nogravity");
  var_2 = 20;
  var_3 = 0;

  while(var_2 > 0 || var_3) {
    var_4 = self.origin + var_0;
    self forceteleport(var_4, self.angles);
    var_2--;
    common_scripts\utility::waitframe();

    if(var_2 <= 0) {
      var_5 = self.origin + var_1 * 15;
      var_6 = var_5 + (0, 0, -200);
      var_7 = bulletTrace(var_5, var_6, 0, level.player, 0, 0, 0, 1, 0);
      var_3 = var_7["fraction"] < 0.9;
    }
  }

  self animmode("gravity");
}

waittill_no_radio_dialog() {
  while(radio_dialog_playing())
    common_scripts\utility::waitframe();
}

radio_dialog_playing() {
  return isDefined(level.player_radio_emitter) && isDefined(level.player_radio_emitter.function_stack) && level.player_radio_emitter.function_stack.size > 0;
}

waittill_no_char_dialog() {
  while(allies_dialog_playing())
    common_scripts\utility::waitframe();
}

allies_dialog_playing() {
  var_0 = isDefined(level.allies[0].function_stack) && level.allies[0].function_stack.size > 0;
  var_1 = isDefined(level.allies[1].function_stack) && level.allies[1].function_stack.size > 0;
  return var_0 || var_1;
}

radio_dialog_add_and_go(var_0, var_1) {
  waittill_no_char_dialog();
  maps\_utility::radio_add(var_0);
  maps\_utility::radio_dialogue(var_0, var_1);
}

radio_dialog_add_and_go_interrupt(var_0) {
  waittill_no_char_dialog();
  maps\_utility::radio_add(var_0);
  maps\_utility::radio_dialogue_stop();
  maps\_utility::radio_dialogue_interupt(var_0);
}

char_dialog_add_and_go(var_0) {
  waittill_no_radio_dialog();

  if(!isDefined(self) || !isalive(self)) {
    return;
  }
  level.scr_sound[self.animname][var_0] = var_0;
  maps\_utility::dialogue_queue(var_0);
}

setup_rooftop_dof() {
  var_0 = level.player getweaponslistprimaries();
  level.custom_dof_trace = ::dof_process_ads_rooftop;
  level.dof_blend_interior_ads_scalar = 0.5;
  common_scripts\utility::flag_wait("player_is_starting_zipline");
  level.custom_dof_trace = undefined;
  level.dof_blend_interior_ads_scalar = undefined;
}

dof_process_ads_rooftop() {
  var_0 = self playerads();
  var_1 = 100000;
  var_2 = getdvarfloat("ads_dof_maxEnemyDist", 0);
  var_3 = getdvarint("ads_dof_playerForgetEnemyTime", 5000);
  var_4 = getdvarfloat("ads_dof_nearStartScale", 0.25);
  var_5 = getdvarfloat("ads_dof_nearEndScale", 0.85);
  var_6 = getdvarfloat("ads_dof_farStartScale", 1.15);
  var_7 = getdvarfloat("ads_dof_farEndScale", 3);
  var_8 = getdvarfloat("ads_dof_nearBlur", 4);
  var_9 = getdvarfloat("ads_dof_farBlur", 2.5);
  var_10 = self getEye();
  var_11 = self getplayerangles();

  if(isDefined(self.dof_ref_ent))
    var_12 = combineangles(self.dof_ref_ent.angles, var_11);
  else
    var_12 = var_11;

  var_13 = vectornormalize(anglesToForward(var_12));
  var_14 = bulletTrace(var_10, var_10 + var_13 * var_1, 1, self, 1, 0, 0, 0, 0);

  if(var_14["fraction"] == 1)
    var_1 = 86000;
  else
    var_1 = distance(var_10, var_14["position"]);

  var_15 = var_1 * var_4;
  var_16 = var_1 * var_6;

  if(var_15 > var_16)
    var_15 = var_16 - 256;

  if(var_15 > var_1)
    var_15 = var_1 - 30;

  if(var_15 < 1)
    var_15 = 1;

  if(var_16 < var_1)
    var_16 = var_1;

  var_17 = var_15 * var_4;
  var_18 = var_16 * var_7;
  maps\_art::dof_enable_ads(var_17, var_15, var_8, var_16, var_18, var_9, var_0);
}

player_move_on_rappel_hint() {
  thread time_to_pass_before_hint(3, "rappel_movement", "player_moved_during_rappel", 1);

  for(;;) {
    wait 0.05;
    var_0 = level.player getnormalizedmovement();

    if(var_0[0] < -0.1 || var_0[0] > 0.1) {
      if(var_0[0] < -0.1 || var_0[0] > 0.1) {
        if(var_0[0] < -0.1 || var_0[0] > 0.1) {
          break;
        }
      }
    }
  }

  common_scripts\utility::flag_set("player_moved_during_rappel");
  thread clear_rappel_move_flag();
}

clear_rappel_move_flag() {
  wait 5;
  common_scripts\utility::flag_clear("player_moved_during_rappel");
}

take_away_offhands() {
  level.player disableoffhandweapons();
  level.player setweaponammoclip("fraggrenade", 0);
  level.player setweaponammostock("fraggrenade", 0);
  level.player setweaponammoclip("flash_grenade", 0);
  level.player setweaponammostock("flash_grenade", 0);
}

give_back_offhands() {
  level.player enableoffhandweapons();
  level.player giveweapon("fraggrenade");
  var_0 = weaponmaxammo("fraggrenade");
  var_1 = weaponclipsize("fraggrenade");
  level.player setweaponammoclip("fraggrenade", var_1);
  level.player setweaponammostock("fraggrenade", var_0);
  level.player giveweapon("flash_grenade");
  var_0 = weaponmaxammo("flash_grenade");
  var_1 = weaponclipsize("flash_grenade");
  level.player setweaponammoclip("flash_grenade", var_1);
  level.player setweaponammostock("flash_grenade", var_0);
}