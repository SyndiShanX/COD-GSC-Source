/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\clockwork_code.gsc
*****************************************************/

clockwork_init() {
  precachemodel("viewhands_fed_army_arctic");
  precachemodel("clk_watch_viewhands");
  precachemodel("clk_watch_viewhands_off");
  precachemodel("weapon_proximity_mine_small");
  precachemodel("weapon_proximity_mine_small_obj");
  precachemodel("weapon_electric_claymore_small");
  precachemodel("weapon_electric_claymore_small_obj");
  precachemodel("weapon_sentry_smg_collapsed_small");
  precachemodel("weapon_sentry_smg_collapsed_small_obj");
  precacheitem("thermobaric_mine");
  precacheitem("teargas_grenade");
  precacheitem("shockwave");
  precacheminimapsentrycodeassets();
  common_scripts\_sentry::setup_sentry_globals();
  setnorthyaw(255);
  level.dog_alt_melee_func = ::dog_alt_combat_check_clockwork;
}

setup_common() {
  level.player setviewmodel("viewhands_fed_army_arctic");
  level.player takeallweapons();
  level.player giveweapon("gm6+scopegm6_sp+silencer03_sp");
  level.player giveweapon("cz805bren+reflex_sp+silencer_sp");
  level.player switchtoweaponimmediate("cz805bren+reflex_sp+silencer_sp");
  level.player setoffhandprimaryclass("frag");
  level.player setoffhandsecondaryclass("flash");
  level.player giveweapon("fraggrenade");
  level.player giveweapon("flash_grenade");
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
}

spawn_allies() {
  maps\_utility::add_global_spawn_function("allies", ::disable_sniper_glint);
  level.allies = [];
  level.allies[0] = spawn_ally("baker");
  level.allies[0].animname = "baker";
  level.allies[0].name = "Merrick";
  level.allies[1] = spawn_ally("keegan");
  level.allies[1].animname = "keegan";
  level.allies[1].name = "Keegan";
  level.allies[2] = spawn_ally("cipher");
  level.allies[2].animname = "cypher";
  level.allies[2].name = "Hesh";
  level.allies[0].npcid = "mrk";
  level.allies[1].npcid = "kgn";
  level.allies[2].npcid = "hsh";
  spawn_dog();
  setup_dufflebag_anims();
}

spawn_ally(var_0, var_1) {
  var_2 = undefined;

  if(!isDefined(var_1))
    var_2 = level.start_point + "_" + var_0;
  else
    var_2 = var_1 + "_" + var_0;

  var_3 = spawn_targetname_at_struct_targetname(var_0, var_2);

  if(!isDefined(var_3))
    return undefined;

  var_3 maps\_utility::make_hero();

  if(!isDefined(var_3.magic_bullet_shield))
    var_3 maps\_utility::magic_bullet_shield();

  var_3.countryid = "US";
  return var_3;
}

spawn_dog() {
  if(!level.woof) {
    return;
  }
  level.player takeweapon("flash_grenade");
  var_0 = spawn_ally("dog");
  var_0.meleealwayswin = 1;
  level.dog = var_0;
  level.dog.animname = "dog";
  level.dog.name = "Riley";
  var_0.goalradius = 64;
  var_0.goalheight = 128;
  var_0.pathenemyfightdist = 0;
  var_0 setdogattackradius(64);
  maps\ally_attack_dog::init_ally_dog(level.player, var_0, 1);
  level.player_dog = var_0;
}

disable_sniper_glint() {
  self.disable_sniper_glint = 1;
}

clockwork_timer(var_0, var_1, var_2) {
  level endon("kill_timer");

  if(getdvar("notimer") == "1") {
    return;
  }
  if(!isDefined(var_2))
    var_2 = 0;

  level.hudtimerindex = 20;
  level.timer = maps\_hud_util::get_countdown_hud(-250);
  level.timer setpulsefx(30, 900000, 700);
  level.timer.label = var_1;
  level.timer settenthstimer(var_0);
  level.start_time = gettime();

  while(isDefined(level.timer)) {
    if(level.start_time + var_0 > gettime())
      killtimer();

    wait 1;
  }
}

#using_animtree("generic_human");

setup_dufflebag_anims() {
  var_0 = [];
  var_0["cqb"]["straight"] = % dufflebag_cqb_run;
  var_0["cqb"]["straight_twitch"] = [%dufflebag_cqb_run_alt];
  var_0["cqb"]["move_f"] = % dufflebag_cqb_walk;
  var_0["run"]["straight"] = % dufflebag_lowready_run;
  var_0["run"]["straight_twitch"] = [];
  maps\_utility::register_archetype("dufflebag", var_0);
  var_1 = [];
  var_1["stand"] = [];
  var_1["stand"][0] = % dufflebag_casual_idle;
  var_1["stand"][1] = % dufflebag_casual_idle_fidget_01;
  var_1["stand"][2] = % dufflebag_casual_idle_fidget_02;
  var_1["stand"][3] = % dufflebag_casual_idle_fidget_03;
  var_2 = [];
  var_2["stand"] = [];
  var_2["stand"][0] = 2;
  var_2["stand"][1] = 1;
  var_2["stand"][2] = 1;
  var_2["stand"][3] = 1;
  level.allies[0].customidleanimset = var_1;
  level.allies[0].customidleanimweights = var_2;
  level.allies[0].animarchetype = "dufflebag";
  var_3 = [];
  var_3["stand"] = [];
  var_3["stand"][0] = % dufflebag_casual_keegan_idle;
  var_3["stand"][1] = % dufflebag_casual_keegan_idle_fidget_01;
  var_3["stand"][2] = % dufflebag_casual_keegan_idle_fidget_02;
  var_3["stand"][3] = % dufflebag_casual_keegan_idle_fidget_03;
  var_4 = [];
  var_4["stand"] = [];
  var_4["stand"][0] = 2;
  var_4["stand"][1] = 1;
  var_4["stand"][2] = 1;
  var_4["stand"][3] = 1;
  level.allies[1].customidleanimset = var_1;
  level.allies[1].customidleanimweights = var_2;
  level.allies[1].animarchetype = "dufflebag";
  var_5 = [];
  var_5["stand"] = [];
  var_5["stand"][0] = % dufflebag_casual_cypher_idle;
  var_5["stand"][1] = % dufflebag_casual_cypher_idle_fidget_01;
  var_5["stand"][2] = % dufflebag_casual_cypher_idle_fidget_02;
  var_5["stand"][3] = % dufflebag_casual_cypher_idle_fidget_03;
  var_6 = [];
  var_6["stand"] = [];
  var_6["stand"][0] = 2;
  var_6["stand"][1] = 1;
  var_6["stand"][2] = 1;
  var_6["stand"][3] = 1;
  level.allies[2].customidleanimset = var_1;
  level.allies[2].customidleanimweights = var_2;
  level.allies[2].animarchetype = "dufflebag";
}

init_animated_dufflebags() {
  if(!isDefined(level.bags) || !isDefined(level.bags[0])) {
    level.bags = [];
    level.bags[0] = maps\_utility::spawn_anim_model("baker_bag");
    level.bags[0].animname = "baker_bag";
    level.allies[0].animatedduffle = level.bags[0];
    level.bags[1] = maps\_utility::spawn_anim_model("keegan_bag");
    level.bags[1].animname = "keegan_bag";
    level.allies[1].animatedduffle = level.bags[1];
    level.bags[2] = maps\_utility::spawn_anim_model("cipher_bag");
    level.bags[2].animname = "cipher_bag";
    level.allies[2].animatedduffle = level.bags[2];
  }

  if(!isDefined(level.player_bag))
    level.player_bag = maps\_utility::spawn_anim_model("player_bag");
}

init_animated_dufflebags_candk() {
  level.bags[1] = maps\_utility::spawn_anim_model("keegan_bag");
  level.bags[1].animname = "keegan_bag";
  level.allies[1].animatedduffle = level.bags[1];
  level.bags[2] = maps\_utility::spawn_anim_model("cipher_bag");
  level.bags[2].animname = "cipher_bag";
  level.allies[2].animatedduffle = level.bags[2];
}

init_animated_dufflebags_baker() {
  if(!isDefined(level.bags) || !isDefined(level.bags[0])) {
    level.bags = [];
    level.bags[0] = maps\_utility::spawn_anim_model("baker_bag");
    level.bags[0].animname = "baker_bag";
    level.allies[0].animatedduffle = level.bags[0];
  }

  if(!isDefined(level.player_bag))
    level.player_bag = maps\_utility::spawn_anim_model("player_bag");
}

get_bag_parts() {
  var_0 = [];
  var_0[var_0.size] = "J_Cog";
  return var_0;
}

show_dufflebags(var_0) {
  foreach(var_2 in level.allies) {
    var_3 = get_bag_parts();

    foreach(var_5 in var_3)
    var_2 showpart(var_5);
  }

  if(isDefined(var_0) && var_0 == 1) {
    foreach(var_9 in level.bags)
    var_9 hide();
  }
}

hide_dufflebags(var_0) {
  foreach(var_2 in level.allies) {
    var_3 = get_bag_parts();

    foreach(var_5 in var_3)
    var_2 hidepart(var_5);
  }

  if(isDefined(var_0) && var_0 == 1) {
    foreach(var_9 in level.bags)
    var_9 show();
  }
}

hide_dufflebag(var_0) {
  var_1 = get_bag_parts();

  foreach(var_3 in var_1)
  self hidepart(var_3);

  if(isDefined(var_0) && var_0 && isDefined(self.animatedduffle))
    self.animatedduffle show();
}

show_dufflebag(var_0) {
  var_1 = get_bag_parts();

  foreach(var_3 in var_1)
  self showpart(var_3);

  if(isDefined(var_0) && var_0 && isDefined(self.animatedduffle))
    self.animatedduffle hide();
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

ai_array_killcount_flag_set(var_0, var_1, var_2, var_3) {
  maps\_utility::waittill_dead_or_dying(var_0, var_1, var_3);
  common_scripts\utility::flag_set(var_2);
}

array_spawn_targetname_allow_fail(var_0, var_1) {
  var_2 = getEntArray(var_0, "targetname");
  var_3 = array_spawn_allow_fail(var_2);
  return var_3;
}

array_spawn_allow_fail(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in var_0) {
    var_4.count = 1;
    var_5 = var_4 maps\_utility::spawn_ai(var_1);

    if(isDefined(var_5))
      var_2[var_2.size] = var_5;
  }

  return var_2;
}

reassign_goal_volume(var_0, var_1) {
  if(!isarray(var_0))
    var_0 = maps\_utility::make_array(var_0);

  var_0 = maps\_utility::array_removedead_or_dying(var_0);
  var_2 = getent(var_1, "targetname");

  foreach(var_4 in var_0)
  var_4 setgoalvolumeauto(var_2);
}

safe_activate_trigger_with_targetname(var_0) {
  var_1 = getent(var_0, "targetname");

  if(isDefined(var_1) && !isDefined(var_1.trigger_off))
    var_1 maps\_utility::activate_trigger();
}

safe_disable_trigger_with_targetname(var_0) {
  var_1 = getent(var_0, "targetname");

  if(isDefined(var_1))
    var_1 common_scripts\utility::trigger_off();
}

safe_delete_trigger_with_targetname(var_0) {
  var_1 = getent(var_0, "targetname");

  if(isDefined(var_1))
    var_1 delete();
}

hold_fire_unless_ads(var_0) {
  level notify("ads_done");
  level endon("ads_done");
  level.player notifyonplayercommand("playerisfiring", "+attack");
  level.player notifyonplayercommand("playerisfiring", "+attack_akimbo_accessible");
  var_1 = "cz805bren+reflex_sp+silencer_sp";
  var_2 = "cz805bren_disguise+reflex_sp+silencer_sp";
  level.player disableweaponswitch();
  level.player disableweaponpickup();
  level.player giveweapon(var_2, 0, 0, 0, 1);
  level.player switchtoweapon(var_2);

  if(!level.player hasweapon(var_1))
    level.player giveweapon(var_1, 0, 0, 0, 1);

  while(!common_scripts\utility::flag(var_0) &!common_scripts\utility::flag("exfil_fire_fail")) {
    level.player allowfire(0);
    level.player common_scripts\utility::waittill_any("playerisfiring", "player_cancel_hold_fire", "grenade_fire");
    common_scripts\utility::waitframe();

    if(isDefined(level.player.isanimating)) {
      continue;
    }
    if(common_scripts\utility::flag(var_0)) {
      continue;
    }
    if(level.player playerads() > 0) {
      level.player allowfire(1);

      while(level.player playerads() > 0) {
        if(level.player isfiring()) {
          while(level.player playerads() == 1)
            wait 0.05;

          level.player switchtoweapon(var_1);
          wait 0.6;
          level.player allowfire(1);
          wait 0.2;
          level.player takeweapon(var_2);
          level.player enableweaponswitch();
          level.player enableweaponpickup();
          return;
        }

        wait 0.05;
      }
    } else {
      level.player switchtoweapon(var_1);
      wait 0.6;
      level.player allowfire(1);
      wait 0.2;
      level.player takeweapon(var_2);
      level.player enableweaponswitch();
      level.player enableweaponpickup();
      return;
    }

    wait 0.05;
  }

  level.player enableweaponswitch();
  level.player enableweaponpickup();
  level.player switchtoweapon(var_1);
  level.player allowfire(1);

  if(var_0 == "nvgs_on")
    wait 3;
  else
    wait 0.8;

  level.player takeweapon(var_2);
}

blend_movespeedscale_custom(var_0, var_1) {
  var_2 = self;

  if(!isplayer(var_2))
    var_2 = level.player;

  var_2 notify("blend_movespeedscale_custom");
  var_2 endon("blend_movespeedscale_custom");

  if(!isDefined(var_2.baseline_speed))
    var_2.baseline_speed = 1.0;

  var_3 = var_0 * 0.01;
  var_4 = var_2.baseline_speed;

  if(isDefined(var_1)) {
    var_5 = var_3 - var_4;
    var_6 = 0.05;
    var_7 = var_1 / var_6;
    var_8 = var_5 / var_7;

    while(abs(var_3 - var_4) > abs(var_8 * 1.1)) {
      var_4 = var_4 + var_8;
      var_2.baseline_speed = var_4;

      if(!common_scripts\utility::flag("player_dynamic_move_speed"))
        level.player setmovespeedscale(var_2.baseline_speed);

      wait(var_6);
    }
  }

  var_2.baseline_speed = var_3;

  if(!common_scripts\utility::flag("player_dynamic_move_speed"))
    level.player setmovespeedscale(var_2.baseline_speed);
}

dog_run() {
  level.dog maps\_utility_dogs::disable_dog_walk();
  level notify("dog_set_running");
}

dog_walk(var_0) {
  level.dog maps\_utility_dogs::enable_dog_walk(var_0);
}

dog_walk_until_flag(var_0, var_1) {
  level notify("new_dog_walkwait");
  level endon("new_dog_walkwait");
  level endon("dog_set_running");
  dog_walk(var_1);
  common_scripts\utility::flag_wait(var_0);
  dog_run();
}

dog_walk_for_time(var_0, var_1) {
  level notify("new_dog_walkwait");
  level endon("new_dog_walkwait");
  level endon("dog_set_running");
  dog_walk(var_1);
  wait(var_0);
  dog_run();
}

player_dms_get_plane() {
  var_0 = level.player.origin;
  var_1 = self.origin + anglestoright(self.angles) * -5000;
  var_2 = self.origin + anglestoright(self.angles) * 5000;
  return pointonsegmentnearesttopoint(var_1, var_2, var_0);
}

player_dms_ahead_test() {
  var_0 = 0;

  if(isDefined(self.last_set_goalent))
    var_0 = self[[level.drs_ahead_test]](self.last_set_goalent, 50);
  else if(isDefined(self.last_set_goalnode))
    var_0 = self[[level.drs_ahead_test]](self.last_set_goalnode, 50);

  return var_0;
}

switch_active() {
  self notifyonplayercommand("switchturret", "weapnext");
  wait 0.05;
  self endon("switchtoturret");

  for(;;) {
    foreach(var_1 in level.playerjeep.mgturret) {
      var_1 turretfiredisable();
      var_1 turretsetbarrelspinenabled(0);
    }

    level.switchactive = 1;
    level.player notify("grenade_turret_active");
    self waittill("switchturret");

    foreach(var_1 in level.playerjeep.mgturret) {
      var_1 turretfireenable();
      var_1 turretsetbarrelspinenabled(1);
    }

    level.switchactive = 0;
    self waittill("switchturret");
    wait 0.25;
  }
}

fire_grenade() {
  level.player endon("missionend");
  level.player endon("playercrash");
  level.player thread switch_active();
  var_0 = 2;
  var_1 = 1;
  var_2 = gettime();
  var_3 = gettime();
  var_4 = 0;
  var_5 = 0;
  level.player notifyonplayercommand("fire_grenade", "+attack");
  level.player notifyonplayercommand("fire_grenade", "+attack_akimbo_accessible");

  while(!isDefined(level.missionend)) {
    var_6 = level.player common_scripts\utility::waittill_any_return("fire_grenade", "grenade_turret_active");

    if(!level.switchactive) {
      continue;
    }
    if(isDefined(var_6) && var_6 == "fire_grenade")
      var_7 = 1;
    else
      var_7 = level.player attackbuttonpressed();

    while(var_7 && level.switchactive) {
      if(var_3 < gettime()) {
        var_4 = 0;
        var_8 = level.player getEye();
        var_9 = level.player getplayerangles();
        var_10 = anglesToForward(var_9);
        var_11 = anglestoright(var_9);
        var_12 = var_8 + var_10 * 12 * 2000;
        var_13 = self.mgturret[0] gettagorigin("TAG_LAUNCHER");
        var_14 = var_13 + var_10 * 32 + (0, 0, 5);

        if(common_scripts\utility::flag("en_headon_road") && !common_scripts\utility::flag("enemy_cave_spawn"))
          var_14 = var_13 + var_10 * 32;

        var_15 = magicbullet("xm25_fast", var_13 + var_10 * 32 + (0, 0, 5), var_12, level.player);
        playFXOnTag(common_scripts\utility::getfx("grenade_muzzleflash"), self.mgturret[0], "TAG_LAUNCHER");
        level.player playrumbleonentity("damage_light");
        thread screenshakefade(0.03, 0.5, 0.01, 0.2);
        thread maps\clockwork_audio::chase_concussion();
        var_2 = gettime() + var_0 * 1000;
        var_3 = gettime() + var_1 * 1000;
      } else {
        common_scripts\utility::waitframe();
        var_4++;

        if(!common_scripts\utility::flag("rpg_spawn"))
          var_4 = 0;
        else if(var_4 > 200 && !common_scripts\utility::flag("enemy_cave_spawn")) {
          var_4 = 0;

          if(var_5) {
            level.allies[0] thread char_dialog_add_and_go("clockwork_bkr_shoottheice");
            var_5 = 0;
          } else {
            level.allies[0] thread char_dialog_add_and_go("clockwork_bkr_usegrenades");
            var_5 = 1;
          }
        }
      }

      wait 0.1;
      var_7 = level.player attackbuttonpressed();
    }
  }
}

vehicle_hit_drift() {
  var_0 = getEntArray("exfil_drift_trigger", "targetname");

  foreach(var_2 in var_0)
  var_2 thread drift_hit();
}

drift_hit() {
  for(;;) {
    self waittill("trigger", var_0);

    if(var_0 maps\_vehicle::isvehicle() && isDefined(var_0) && isalive(var_0)) {
      if(var_0 == level.playerjeep)
        playFX(loadfx("fx/treadfx/bigjump_land_snow_night"), var_0.origin);
      else {
        var_1 = anglesToForward(var_0.angles);
        var_2 = var_1 * 20;
        playFX(loadfx("fx/treadfx/bigjump_land_snow_night"), var_0.origin + var_2);
      }
    }

    wait 0.75;
  }
}

handle_grenade_launcher() {
  level endon("death");
  common_scripts\utility::flag_wait("start_icehole_shooting");
  level.playerjeephitcount = 0;

  for(;;) {
    self waittill("missile_fire", var_0, var_1);
    thread handle_grenade_explode(var_0);
    wait 0.01;
  }
}

handle_grenade_explode(var_0) {
  level notify("cancel_my_grenade");
  level endon("cancel_my_grenade");
  var_0 waittill("explode", var_1);
  thread add_ice_radius(50, var_1);
  thread maps\clockwork_audio::chase_crack_icehole(var_1);
}

add_ice_radius(var_0, var_1) {
  level endon("death");
  var_2 = common_scripts\utility::drop_to_ground(var_1, var_1[2]);
  var_3 = var_2[2];

  if(var_3 < 224 && var_1[2] < 300) {
    var_4 = maps\_utility::getvehiclearray();
    var_5 = var_0 * var_0;

    if(level.icehole_to_move < 4)
      level.icehole_to_move++;
    else
      level.icehole_to_move = 1;

    var_6 = "icehole_" + level.icehole_to_move;
    var_7 = getent(var_6, "targetname");
    var_7 moveto(var_2, 0.01);

    if(level.icehole_to_move == 1) {
      var_8 = maps\_utility::spawn_anim_model("cw_icehole", var_2);
      var_8 thread maps\_anim::anim_single_solo(var_8, "ice_a");
    } else if(level.icehole_to_move == 2) {
      var_8 = maps\_utility::spawn_anim_model("cw_icehole", var_2);
      var_8 thread maps\_anim::anim_single_solo(var_8, "ice_b");
    } else if(level.icehole_to_move == 3) {
      var_8 = maps\_utility::spawn_anim_model("cw_icehole", var_2);
      var_8 thread maps\_anim::anim_single_solo(var_8, "ice_c");
    } else {
      var_8 = maps\_utility::spawn_anim_model("cw_icehole", var_2);
      var_8 thread maps\_anim::anim_single_solo(var_8, "ice_b");
    }

    playFX(level._effect["mortar"]["water"], var_2);

    foreach(var_10 in var_4) {
      var_11 = distancesquared(var_10.origin, var_2);

      if(var_5 > var_11) {
        if(isDefined(var_10) && isalive(var_10) && var_10 == level.playerjeep) {
          if(!common_scripts\utility::flag("enemy_cave_spawn"))
            dynamic_player_crash(var_10, 1, var_2);

          continue;
        }

        if(isDefined(var_10) && isalive(var_10)) {
          if(isDefined(level.endingjeep) && var_10 == level.endingjeep && !common_scripts\utility::flag("kill_endingjeep")) {
            continue;
          }
          var_10 notify("icehole_occured");
          var_10 thread play_crash_anim(var_2);
          thread common_scripts\utility::play_sound_in_space("clkw_scn_ice_chase_hole", var_2);
          thread maps\clockwork_audio::chase_pileup_counter();
        }
      }
    }

    var_13 = spawn("trigger_radius", var_2, 16, var_0, 50);
    var_13.angles = level.playerjeep.angles;
    var_13 thread handle_vehicles_near_iceholes();
    wait 10;
    var_13 delete();

    if(isDefined(var_8)) {
      var_8 delete();
      return;
    }
  } else {
    var_4 = maps\_utility::getvehiclearray();
    var_5 = (var_0 + var_0) * (var_0 + var_0);

    foreach(var_10 in var_4) {
      var_11 = distancesquared(var_10.origin, var_2);

      if(var_5 > var_11) {
        var_15 = var_10.origin[2];

        if(isDefined(var_10) && isalive(var_10) && var_10 == level.playerjeep) {
          if(var_15 < 224) {
            if(!common_scripts\utility::flag("enemy_cave_spawn"))
              dynamic_player_crash(var_10, 1, var_2);
          }
        } else if(isDefined(var_10) && isalive(var_10)) {
          if(var_15 < 224) {
            if(isDefined(level.endingjeep) && var_10 == level.endingjeep && !common_scripts\utility::flag("kill_endingjeep")) {} else {
              var_10 notify("icehole_occured");
              var_10 thread play_crash_anim(var_2);
              thread common_scripts\utility::play_sound_in_space("clkw_scn_ice_chase_hole", var_2);
              thread maps\clockwork_audio::chase_pileup_counter();
            }
          }
        }
      }
    }
  }
}

handle_vehicles_near_iceholes() {
  level endon("death");

  for(;;) {
    self waittill("trigger", var_0);
    var_1 = 1;

    foreach(var_3 in level.allcrashes) {
      if(var_3 == var_0)
        var_1 = 0;
    }

    if(var_0 maps\_vehicle::isvehicle() && var_1 && isDefined(var_0) && isalive(var_0) && var_0 == level.playerjeep) {
      if(!common_scripts\utility::flag("enemy_cave_spawn")) {
        level.allcrashes[level.allcrashes.size] = var_0;
        dynamic_player_crash(var_0, 1, var_0.origin);
      }

      continue;
    }

    if(var_0 maps\_vehicle::isvehicle() && var_1) {
      if(isDefined(level.endingjeep) && var_0 == level.endingjeep && !common_scripts\utility::flag("kill_endingjeep")) {
        continue;
      }
      level.allcrashes[level.allcrashes.size] = var_0;
      var_0 thread play_icehole_anim(self);
      thread common_scripts\utility::play_sound_in_space("clkw_scn_ice_chase_hole", var_0.origin);
      thread maps\clockwork_audio::chase_pileup_counter();
    }
  }
}

play_crash_anim(var_0) {
  if(isDefined(self) && self.model == "vehicle_snowmobile") {
    common_scripts\utility::array_thread(self.riders, ::vehicle_crash_guy, self);
    var_1 = self gettagorigin("tag_passenger");
    physicsexplosioncylinder(var_1, 300, 300, 0.25);

    if(isDefined(self.attachedguys[0]))
      self.attachedguys[0] kill();
  }

  if(self.model == "vehicle_chinese_brave_warrior_anim" || self.model == "vehicle_gaz_tigr_base") {
    if(isDefined(self)) {
      common_scripts\utility::array_thread(self.riders, ::vehicle_crash_guy, self);
      var_1 = self gettagorigin("tag_guy1");
      physicsexplosioncylinder(var_1, 300, 300, 0.25);
    }

    thread icehole_achievement();
    var_2 = self vehicle_getvelocity();
    var_3 = vectornormalize(var_2);
    var_4 = anglesToForward(self.angles);
    var_5 = vectornormalize(var_4);
    var_6 = vectordot(var_5, var_3);

    if(var_6 > 0.9) {
      var_7 = randomintrange(1, 4);

      if(var_7 == 1 && !level.justplayed) {
        play_long_crash();
        level.justplayed = 1;
        return;
      }

      dynamic_icehole_crash(self, 2);
      level.justplayed = 0;
      return;
    } else {
      var_8 = vectortoangles(var_0 - self.origin);
      var_9 = anglestoright(var_8);
      var_10 = vectornormalize(var_9);
      var_11 = vectordot(var_10, var_3);

      if(var_11 > 0)
        dynamic_icehole_crash(self, 0);
      else
        dynamic_icehole_crash(self, 1);
    }
  }
}

play_icehole_anim(var_0) {
  self notify("icehole_occured");

  if(isDefined(self) && self.model == "vehicle_snowmobile") {
    common_scripts\utility::array_thread(self.riders, ::vehicle_crash_guy, self);
    var_1 = self gettagorigin("tag_passenger");
    physicsexplosioncylinder(var_1, 300, 300, 0.25);

    if(isDefined(self.attachedguys[0]))
      self.attachedguys[0] kill();
  }

  if(self.model == "vehicle_chinese_brave_warrior_anim" || self.model == "vehicle_gaz_tigr_base") {
    if(isDefined(self)) {
      common_scripts\utility::array_thread(self.riders, ::vehicle_crash_guy, self);
      var_1 = self gettagorigin("tag_guy1");
      physicsexplosioncylinder(var_1, 300, 300, 0.25);
    }

    wait 0.01;
    thread icehole_achievement();
    var_2 = self vehicle_getvelocity();
    var_3 = vectornormalize(var_2);
    var_4 = anglesToForward(self.angles);
    var_5 = vectornormalize(var_4);
    var_6 = vectordot(var_5, var_3);
    var_7 = vectornormalize(var_0.origin - self.origin);
    var_8 = vectordot(var_3, var_7);
    var_9 = randomint(2);

    if(var_8 >= 0.9) {
      var_10 = randomintrange(1, 4);

      if(var_10 == 1 && !level.justplayed) {
        play_long_crash();
        level.justplayed = 1;
        return;
      }

      dynamic_icehole_crash(self, 2);
      level.justplayed = 0;
      return;
    } else if(var_8 < 0.9) {
      var_11 = vectortoangles(var_0.origin - self.origin);
      var_12 = anglestoright(var_11);
      var_13 = vectornormalize(var_12);
      var_14 = vectordot(var_13, var_3);

      if(var_14 > 0) {
        if(var_6 < 0.95) {
          if(var_14 > 0)
            dynamic_icehole_crash(self, 0);
          else if(var_8 > 0.965)
            dynamic_icehole_crash(self, 2);
          else
            dynamic_icehole_crash(self, 1);
        } else
          dynamic_icehole_crash(self, 1);
      } else if(var_6 < 0.95) {
        if(var_14 > 0)
          dynamic_icehole_crash(self, 1);
        else if(var_8 > 0.965)
          dynamic_icehole_crash(self, 2);
        else
          dynamic_icehole_crash(self, 0);
      } else
        dynamic_icehole_crash(self, 0);
    }
  }
}

play_long_crash() {
  var_0 = anglesToForward(self.angles);
  var_1 = self.origin;
  var_2 = self.origin + var_0 * 100000;
  var_3 = bulletTrace(var_1, var_2, 1, self);
  var_4 = distancesquared(self.origin, var_3["position"]);

  if(var_4 > 20000) {
    thread maps\clockwork_audio::chase_sink(self.origin);
    anim_spawn_replace_with_model(self.model, "icehole_crashes", "icehole_crash_longa");
    var_5 = (self.origin[0], self.origin[1], 200);
    var_6 = maps\_utility::spawn_anim_model("cw_ice_shards_longa", var_5);
    var_6.angles = (0, self.angles[1], 0);
    var_6 thread maps\_anim::anim_single_solo(var_6, "ice_crash");
    self delete();
  } else
    dynamic_icehole_crash(self, 1);
}

dynamic_icehole_crash(var_0, var_1) {
  if(isDefined(var_0)) {
    var_0 notify("dying");
    var_0.dontunloadonend = 1;
    common_scripts\utility::array_thread(var_0.riders, ::vehicle_crash_guy, var_0);
    var_0 thread vehicle_crash_launch_guys();

    if(var_1 == 0)
      var_2 = randomint(45) + 45;
    else if(var_1 == 1)
      var_2 = 45 - randomint(90);
    else if(randomint(1))
      var_2 = randomint(90);
    else
      var_2 = randomint(90) + 270;

    var_0 vehphys_enablecrashing();
    var_3 = rotate_vector((0, var_2, 0), var_0.angles);
    var_0 vehphys_launch(var_3, 1.0);
    var_0.spline = 0;

    foreach(var_5 in level.enemy_jeep_s) {
      if(var_5 == var_0) {
        var_0.spline = 1;
        break;
      }
    }

    if(var_0.spline == 1) {
      if(isDefined(var_0))
        var_0 maps\_vehicle::godoff();

      if(isDefined(var_0))
        var_0 maps\_vehicle::force_kill();
    } else {
      if(isDefined(var_0))
        var_0 waittill_still(randomint(3) + 1, 200);

      if(isDefined(var_0))
        var_0 maps\_vehicle::godoff();

      if(isDefined(var_0)) {
        if(randomint(4) > 3)
          var_0 maps\_vehicle::force_kill();
      }
    }
  }
}

dynamic_player_crash(var_0, var_1, var_2) {
  if(isDefined(level.player.jeep_is_crashing) && level.player.jeep_is_crashing) {
    return;
  }
  level.missionend = 1;
  level.player.jeep_is_crashing = 1;
  level.player disableinvulnerability();
  common_scripts\utility::waitframe();
  level notify("player_jeep_crashing");
  level.player kill();
  thread common_scripts\utility::play_sound_in_space("clkw_scn_ice_chase_hole", var_2);
  thread maps\clockwork_audio::chase_pileup_counter();

  if(var_1 == 0)
    var_3 = randomint(180) - 180;
  else if(var_1 == 1)
    var_3 = 0 - randomint(180);
  else if(randomint(1))
    var_3 = randomint(90);
  else
    var_3 = randomint(90) + 270;

  var_0 vehphys_enablecrashing();
  var_4 = rotate_vector((0, var_3, 0), var_0.angles);
  var_0 vehphys_launch(var_4, 1.0);

  while(isalive(level.playerjeep) && abs(angleclamp180(level.playerjeep.angles[2])) < 80)
    common_scripts\utility::waitframe();

  if(level.player islinked()) {
    level.player unlink();
    level.player setorigin(level.player.origin + (0, 0, 60));
  }

  foreach(var_6 in level.allies) {
    if(isDefined(var_6.magic_bullet_shield))
      var_6 maps\_utility::stop_magic_bullet_shield();

    var_6 stopanimscripted();
    var_6.ragdoll_immediate = 1;
    var_6 kill();
  }

  if(level.woof)
    level.dog hide();
}

#using_animtree("vehicles");

anim_spawn_replace_with_model(var_0, var_1, var_2) {
  var_3 = self.origin;
  var_4 = angles_clamp(self.angles);
  var_5 = spawn("script_model", var_3);
  var_5 setModel(var_0);
  var_5.angles = var_4;
  var_5 useanimtree(#animtree);
  var_5.animname = var_1;
  var_5 thread maps\_anim::anim_single_solo(var_5, var_2);
  return var_5;
}

angles_clamp(var_0) {
  return (0, var_0[1], 0);
}

spawn_enemy_bike_at_spawer(var_0) {
  var_1 = maps\_vehicle_spline_zodiac::get_player_targ();
  var_2 = maps\_vehicle_spline_zodiac::get_player_progress();
  var_3 = maps\_vehicle_spline_zodiac::get_spawn_position(var_1, var_2 - 1000 - level.pos_lookahead_dist);
  var_4 = var_3["targ"];
  var_5 = getent(var_0, "targetname");
  var_6 = maps\_vehicle::vehicle_spawn(var_5);
  var_6.offset_percent = var_3["offset"];
  var_6 vehphys_setspeed(90);
  var_6 thread maps\_vehicle_spline_zodiac::crash_detection();
  var_6.left_spline_path_time = gettime() - 3000;
  var_4 thread maps\_vehicle_spline_zodiac::bike_drives_path(var_6);
  return var_6;
}

driver_dies(var_0) {
  if(isDefined(var_0) && isDefined(var_0.driver)) {
    var_0.driver waittill("death");

    if(isDefined(var_0)) {
      var_0 notify("dying");
      var_0.dontunloadonend = 1;
      common_scripts\utility::array_thread(var_0.riders, ::vehicle_crash_guy, var_0);
      var_0 thread vehicle_crash_launch_guys();
      var_0 vehphys_enablecrashing();
      var_1 = rotate_vector((64, randomint(512) - 256, 0), var_0.angles);
      var_0 vehphys_launch(var_1 * 2, 1.0);

      if(var_0.spline == 1) {
        wait 1;

        if(isDefined(var_0))
          var_0 maps\_vehicle::godoff();

        if(isDefined(var_0))
          var_0 maps\_vehicle::force_kill();
      } else {
        if(isDefined(var_0))
          var_0 waittill_still(randomint(3) + 1, 200);

        if(isDefined(var_0))
          var_0 maps\_vehicle::godoff();

        if(isDefined(var_0)) {
          if(randomint(4) >= 3)
            var_0 maps\_vehicle::force_kill();
        }
      }
    }
  }
}

vehicle_crash_guy(var_0) {
  if(!isDefined(self) || self.vehicle_position == 0)
    return;
  else {
    self.deathanim = undefined;
    self.noragdoll = undefined;
    var_0.riders = common_scripts\utility::array_remove(var_0.riders, self);
    self.ragdoll_immediate = 1;

    if(isDefined(self)) {
      if(!isDefined(self.magic_bullet_shield))
        self kill();
    }
  }
}

vehicle_crash_launch_guys() {
  wait 0.1;

  if(isDefined(self)) {
    var_0 = self gettagorigin("tag_guy1");
    physicsexplosioncylinder(var_0, 300, 300, 0.25);
  }
}

waittill_still(var_0, var_1) {
  mytimeoutent(var_0) endon("timeout");

  if(!isDefined(var_1))
    var_1 = 50;

  var_2 = self vehicle_getvelocity();
  var_2 = abs(var_2[0]) + abs(var_2[1]) + abs(var_2[2]);

  while(var_2 > var_1) {
    if(isDefined(self))
      var_2 = self vehicle_getvelocity();
    else
      break;

    var_2 = abs(var_2[0]) + abs(var_2[1]) + abs(var_2[2]);
    wait 0.05;
  }
}

rotate_vector(var_0, var_1) {
  var_2 = anglestoright(var_1) * -1;
  var_3 = anglesToForward(var_1);
  var_4 = anglestoup(var_1);
  var_5 = var_3 * var_0[0] + var_2 * var_0[1] + var_4 * var_0[2];
  return var_5;
}

mytimeoutent(var_0) {
  var_1 = spawnStruct();
  var_1 maps\_utility::delaythread(var_0, maps\_utility::send_notify, "timeout");
  return var_1;
}

player_viewhands_minigun(var_0, var_1) {
  level.player endon("missionend");

  if(!isDefined(var_1))
    var_1 = "viewhands_player_us_army";

  var_0 useanimtree(#animtree);
  var_0.animname = "suburban_hands";
  var_0.has_hands = 0;
  var_0 show_hands(var_1);
  var_0 set_idle();
  var_0 thread player_viewhands_minigun_hand("LEFT");
  var_0 thread player_viewhands_minigun_hand("RIGHT");
  var_0 thread handle_mounting(var_1);
}

set_idle() {
  self setanim(%player_suburban_minigun_idle_l, 1, 0, 1);
  self setanim(%player_suburban_minigun_idle_r, 1, 0, 1);
}

handle_mounting(var_0) {
  var_1 = self;
  var_1 endon("death");

  for(;;) {
    var_1 waittill("turretownerchange");
    var_2 = var_1 getturretowner();

    if(!isalive(var_2)) {
      hide_hands(var_0);
      continue;
    }

    show_hands(var_0);
  }
}

show_hands(var_0) {
  if(!isDefined(var_0))
    var_0 = "viewhands_player_us_army";

  var_1 = self;

  if(var_1.has_hands) {
    return;
  }
  var_1 dontcastshadows();
  var_1.has_hands = 1;
  var_1 attach(var_0, "tag_player");
}

hide_hands(var_0) {
  if(!isDefined(var_0))
    var_0 = "viewhands_player_us_army";

  var_1 = self;

  if(!var_1.has_hands) {
    return;
  }
  var_1 castshadows();
  var_1.has_hands = 0;
  var_1 detach(var_0, "tag_player");
}

player_viewhands_minigun_hand(var_0) {
  self endon("death");
  level.player endon("missionend");
  var_1 = undefined;

  if(var_0 == "LEFT")
    var_1 = ::spinbuttonpressed;
  else if(var_0 == "RIGHT")
    var_1 = ::firebuttonpressed;

  var_2 = undefined;

  if(var_0 == "LEFT")
    var_2 = "L";
  else if(var_0 == "RIGHT")
    var_2 = "R";

  for(;;) {
    if(common_scripts\utility::flag("hand_wait")) {
      self clearanim(maps\_utility::getanim("fire2idle_" + var_2), 0.2);
      common_scripts\utility::flag_clear("hand_wait");
      common_scripts\utility::flag_wait("hand_wait");
      common_scripts\utility::flag_clear("hand_wait");
    }

    if(level.player[[var_1]]()) {
      thread player_viewhands_minigun_presed(var_0);

      while(level.player[[var_1]]())
        wait 0.05;

      continue;
    }

    thread player_viewhands_minigun_idle(var_0);

    while(!level.player[[var_1]]())
      wait 0.05;
  }
}

spinbuttonpressed() {
  if(level.player adsbuttonpressed())
    return 1;

  if(level.player attackbuttonpressed())
    return 1;

  return 0;
}

firebuttonpressed() {
  return level.player attackbuttonpressed();
}

player_viewhands_minigun_idle(var_0) {
  level.player endon("missionend");
  var_1 = undefined;

  if(var_0 == "LEFT")
    var_1 = "L";
  else if(var_0 == "RIGHT")
    var_1 = "R";

  self clearanim(maps\_utility::getanim("idle2fire_" + var_1), 0.2);
  self setflaggedanimrestart("anim", maps\_utility::getanim("fire2idle_" + var_1));
  self waittillmatch("anim", "end");
  self clearanim(maps\_utility::getanim("fire2idle_" + var_1), 0.2);
  self setanim(maps\_utility::getanim("idle_" + var_1));
}

player_viewhands_minigun_presed(var_0) {
  level.player endon("missionend");
  var_1 = undefined;

  if(var_0 == "LEFT")
    var_1 = "L";
  else if(var_0 == "RIGHT")
    var_1 = "R";

  self clearanim(maps\_utility::getanim("idle_" + var_1), 0.2);
  self setanim(maps\_utility::getanim("idle2fire_" + var_1));
}

ice_effects_init() {
  if(!isDefined(anim._effect))
    anim._effect = [];

  anim._effect["snowmobile_leftground"] = loadfx("fx/treadfx/bigair_snow_night_emitter");
  anim._effect["snowmobile_bumpbig"] = loadfx("fx/treadfx/bigjump_land_snow_night");
  anim._effect["snowmobile_bump"] = loadfx("fx/treadfx/smalljump_land_snow_night");
  anim._effect["snowmobile_sway_left"] = loadfx("fx/treadfx/leftturn_snow_night");
  anim._effect["snowmobile_sway_right"] = loadfx("fx/treadfx/rightturn_snow_night");
  anim._effect["snowmobile_collision"] = loadfx("fx/treadfx/bigjump_land_snow_night");
}

snowmobile_sounds() {
  thread sm_listen_leftground();
  thread sm_listen_landed();
  thread sm_listen_jolt();
  thread sm_listen_collision();
}

sm_listen_leftground() {
  self endon("death");

  for(;;) {
    self waittill("veh_leftground");
    thread maps\clockwork_audio::chase_sm_leftground(self.origin);

    if(self.kill_my_fx == 0) {
      self.event_time = gettime();
      wait 1;
    }
  }
}

sm_listen_landed() {
  self endon("death");

  for(;;) {
    self waittill("veh_landed");

    if(self.kill_my_fx == 0) {
      if(self.event_time + self.bigjump_timedelta < gettime()) {
        thread maps\clockwork_audio::chase_sm_collision(self.origin);
        continue;
      }

      thread maps\clockwork_audio::chase_sm_collision(self.origin);
    }
  }
}

sm_listen_jolt() {
  self endon("death");

  for(;;) {
    self waittill("veh_jolt", var_0);

    if(self.kill_my_fx == 0) {
      if(var_0[1] >= 0) {
        thread maps\clockwork_audio::chase_sm_collision(self.origin);
        continue;
      }

      thread maps\clockwork_audio::chase_sm_collision(self.origin);
    }
  }
}

sm_listen_collision() {
  self endon("death");

  for(;;) {
    self waittill("veh_collision", var_0, var_1);

    if(self.kill_my_fx == 0)
      thread maps\clockwork_audio::chase_sm_collision(self.origin);
  }
}

start_ice_effects() {
  self.bigjump_timedelta = 500;
  self.event_time = -1;
  thread listen_leftground();
  thread listen_landed();
  thread listen_jolt();
  thread listen_collision();
  thread listen_vehicle_roof();
  thread listen_vehicle_death();
}

listen_vehicle_roof() {
  var_0 = common_scripts\utility::spawn_tag_origin();
  var_0.angles = self gettagangles("tag_turret");
  var_0.origin = self gettagorigin("tag_turret");
  var_0.origin = var_0.origin + (32, 32, 0);
  var_0 linkto(self, "tag_turret");
  var_1 = common_scripts\utility::spawn_tag_origin();
  var_1.angles = self gettagangles("tag_turret");
  var_1.origin = self gettagorigin("tag_turret");
  var_1.origin = var_1.origin + (-32, 32, 0);
  var_1 linkto(self, "tag_turret");
  var_2 = common_scripts\utility::spawn_tag_origin();
  var_2.angles = self gettagangles("tag_turret");
  var_2.origin = self gettagorigin("tag_turret");
  var_2.origin = var_2.origin + (32, -32, 0);
  var_2 linkto(self, "tag_turret");
  var_3 = common_scripts\utility::spawn_tag_origin();
  var_3.angles = self gettagangles("tag_turret");
  var_3.origin = self gettagorigin("tag_turret");
  var_3.origin = var_3.origin + (-32, -32, 0);
  var_3 linkto(self, "tag_turret");
  wait 5;

  while(isalive(self) && isDefined(self) && self.veh_speed > 5) {
    if(var_0.origin[2] < 224) {
      thread maps\clockwork_audio::chase_land_roof(var_0.origin);
      var_4 = common_scripts\utility::drop_to_ground(var_0.origin, 224, 0);
      playFX(loadfx("fx/treadfx/smalljump_land_snow_night"), var_4);
    } else if(var_1.origin[2] < 224) {
      thread maps\clockwork_audio::chase_land_roof(var_1.origin);
      var_4 = common_scripts\utility::drop_to_ground(var_1.origin, 224, 0);
      playFX(loadfx("fx/treadfx/smalljump_land_snow_night"), var_4);
    } else if(var_2.origin[2] < 224) {
      thread maps\clockwork_audio::chase_land_roof(var_2.origin);
      var_4 = common_scripts\utility::drop_to_ground(var_2.origin, 224, 0);
      playFX(loadfx("fx/treadfx/smalljump_land_snow_night"), var_4);
    } else if(var_3.origin[2] < 224) {
      thread maps\clockwork_audio::chase_land_roof(var_3.origin);
      var_4 = common_scripts\utility::drop_to_ground(var_3.origin, 224, 0);
      playFX(loadfx("fx/treadfx/smalljump_land_snow_night"), var_4);
    }

    wait 0.5;
  }

  self notify("kill_tread");
  var_0 delete();
  var_1 delete();
  var_2 delete();
  var_3 delete();
  wait 10;

  if(isDefined(self))
    self delete();
}

snowmobile_fx(var_0) {
  if(self.model == "vehicle_chinese_brave_warrior_anim") {
    if(isDefined(anim._effect[var_0]))
      playFXOnTag(anim._effect[var_0], self, "tag_deathfx");
  }

  if(self.model == "vehicle_gaz_tigr_base") {
    if(isDefined(anim._effect[var_0]))
      playFXOnTag(anim._effect[var_0], self, "tag_guy0");
  }
}

listen_leftground() {
  self endon("death");

  for(;;) {
    self waittill("veh_leftground");
    thread maps\clockwork_audio::chase_leftground(self.origin);

    if(!isDefined(self.kill_my_fx)) {
      self.event_time = gettime();
      snowmobile_fx("snowmobile_leftground");
    }
  }
}

listen_vehicle_death() {
  var_0 = 2000;
  self waittill("death");

  if(isDefined(self)) {
    var_1 = distance(level.player.origin, self.origin);

    if(var_1 < var_0) {
      thread maps\clockwork_audio::chase_crashmix(self.origin);
      return;
    }
  } else {}
}

listen_landed() {
  self endon("death");

  for(;;) {
    self waittill("veh_landed");

    if(!isDefined(self.kill_my_fx)) {
      if(self.event_time + self.bigjump_timedelta < gettime()) {
        thread maps\clockwork_audio::chase_land_tires_big(self.origin);
        snowmobile_fx("snowmobile_bumpbig");
        continue;
      }

      thread maps\clockwork_audio::chase_land_tires_small(self.origin);
      snowmobile_fx("snowmobile_bump");
    }
  }
}

listen_jolt() {
  self endon("death");

  for(;;) {
    self waittill("veh_jolt", var_0);

    if(!isDefined(self.kill_my_fx)) {
      if(var_0[1] >= 0) {
        snowmobile_fx("snowmobile_sway_left");
        thread maps\clockwork_audio::chase_collision(self.origin);
        continue;
      }

      snowmobile_fx("snowmobile_sway_right");
      thread maps\clockwork_audio::chase_collision(self.origin);
    }
  }
}

listen_collision() {
  self endon("death");

  for(;;) {
    self waittill("veh_collision", var_0, var_1);
    thread maps\clockwork_audio::chase_collision(self.origin);

    if(!isDefined(self.kill_my_fx))
      snowmobile_fx("snowmobile_collision");
  }
}

listen_player_collision() {
  for(;;) {
    self waittill("veh_collision", var_0, var_1);
    thread maps\clockwork_audio::chase_player_collision();

    if(!isDefined(self.kill_my_fx)) {
      snowmobile_fx("snowmobile_collision");
      screenshakefade(0.35, 1);
    }
  }
}

listen_player_jolt() {
  for(;;) {
    self waittill("veh_jolt", var_0);

    if(!isDefined(self.kill_my_fx)) {
      if(var_0[1] >= 0) {
        thread maps\clockwork_audio::chase_player_jolt();
        snowmobile_fx("snowmobile_sway_left");
        snowmobile_fx("sparks");
        thread screen_shake_exfil();
        continue;
      }

      thread maps\clockwork_audio::chase_player_jolt();
      snowmobile_fx("snowmobile_sway_right");
      snowmobile_fx("sparks");
      thread screen_shake_exfil();
    }
  }
}

screen_shake_exfil() {
  thread play_rumble_seconds("damage_heavy", 1);
  screenshakefade(0.08, 0.75, 0.01, 0.25);
  screenshakefade(0.05, 0.25);
  screenshakefade(0.08, 0.5, 0.25, 0.01);
}

play_rumble_seconds(var_0, var_1) {
  for(var_2 = 0; var_2 < var_1 * 20; var_2++) {
    level.player playrumbleonentity(var_0);
    wait 0.05;
  }
}

watch_tick(var_0) {
  level endon("stop_watch_tick");
  var_1 = "J_Watch_Face_Time_2";

  for(var_2 = 2; var_2 < 10; var_2++) {
    var_3 = var_1 + var_2;
    var_0 hidepart(var_3);
  }

  common_scripts\utility::flag_wait("intro_watch_on");

  for(var_2 = 2; var_2 < 10; var_2++) {
    var_3 = var_1 + var_2;
    var_0 showpart(var_3);
  }

  var_4 = 2;

  for(;;) {
    wait 1;
    var_3 = var_1 + var_4;
    var_4++;
    var_0 hidepart(var_3);
  }
}

watch_light_fx(var_0, var_1) {
  common_scripts\utility::flag_wait("intro_watch_on");
  playFXOnTag(common_scripts\utility::getfx("vfx/moments/clockwork/vfx_intro_watch_glow"), var_0, "tag_gasmask2");
  common_scripts\utility::flag_wait("intro_watch_off");
  level notify("stop_watch_tick");
  var_2 = "J_Watch_Face_Time_2";

  for(var_3 = 2; var_3 < 10; var_3++) {
    var_4 = var_2 + var_3;
    var_1 hidepart(var_4);
  }

  stopFXOnTag(common_scripts\utility::getfx("vfx/moments/clockwork/vfx_intro_watch_glow"), var_0, "tag_gasmask2");
}

waittill_movement(var_0) {
  self endon("death");
  var_1 = 0;

  if(isDefined(var_0))
    var_2 = var_0 * var_0;

  var_3 = self.origin;
  var_4 = -1;

  while(var_4 < var_1) {
    common_scripts\utility::waitframe();

    if(self.origin != var_3)
      var_4 = distancesquared(self.origin, var_3);
  }
}

delete_on_path_end(var_0, var_1) {
  if(isDefined(var_0))
    level endon(var_0);

  self waittill("reached_path_end");

  if(isDefined(var_1))
    self thread[[var_1]]();

  if(!raven_player_can_see_ai(self))
    self delete();
}

killtimer() {
  level notify("kill_timer");

  if(isDefined(level.timer))
    level.timer destroy();
}

cool_walk(var_0) {
  self.ignoreall = var_0;
  self.disablearrivals = var_0;
  self.disableexits = var_0;

  if(var_0 == 1) {
    self.animname = "generic";
    maps\_utility::set_run_anim("walk_gun_unwary");
  } else
    maps\_utility::clear_run_anim();
}

fast_walk(var_0) {
  if(var_0 == 1) {
    self.animname = "generic";
    maps\_utility::set_run_anim("clock_walk", 1);
    self.moveplaybackrate = 1;
  } else {
    maps\_utility::clear_run_anim();
    self.moveplaybackrate = 1;
  }
}

fast_jog(var_0) {
  if(var_0 == 1) {
    self.animname = "generic";
    maps\_utility::set_run_anim("clock_jog");
    self.moveplaybackrate = 1;
  } else {
    maps\_utility::clear_run_anim();
    self.moveplaybackrate = 1;
  }
}

walkout_idle(var_0) {
  level endon("exfil_fire_fail");

  while(!common_scripts\utility::flag("exfil_fire_fail")) {
    self waittill("idle");

    if(!common_scripts\utility::flag("exfil_fire_fail")) {
      maps\_utility::clear_generic_idle_anim();
      self.animname = "generic";
      maps\_utility::set_generic_idle_anim(var_0);
    } else
      maps\_utility::clear_generic_idle_anim();

    wait 0.05;
  }
}

die_quietly() {
  if(isDefined(self.magic_bullet_shield) && self.magic_bullet_shield == 1)
    maps\_utility::stop_magic_bullet_shield();

  self.no_pain_sound = 1;
  self.diequietly = 1;
  maps\_utility::die();
}

fight_back(var_0) {
  if(!isDefined(var_0))
    var_0 = 3;

  self endon("death");
  wait(var_0);
  self.ignoreall = 0;
}

attack_targets(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(var_5))
    var_5 = 0;

  if(!isDefined(var_2))
    var_2 = 0;

  if(!isDefined(var_3))
    var_3 = 0;

  if(!isDefined(var_4))
    var_4 = 0;

  var_6 = 0;

  for(var_7 = 0; var_6 < var_1.size; var_6++) {
    if(isDefined(var_1[var_6]) && isalive(var_1[var_6]) && !isDefined(var_1[var_6].fake_dead) && !isDefined(var_1[var_6].leave_for_dog)) {
      if(var_4 == 1) {
        var_1[var_6].ignoreme = 0;
        thread snipe_till_dead(var_0[var_7], var_1[var_6], var_5);
      } else {
        var_1[var_6].ignoreme = 0;
        var_0[var_7] getenemyinfo(var_1[var_6]);
        var_1[var_6] thread fight_back();
      }

      if(var_3 > 0) {
        var_8 = var_3;

        if(var_2 < var_3)
          var_8 = randomfloatrange(var_2, var_3);

        wait(var_8);
      }

      var_7++;

      if(var_7 >= var_0.size)
        var_7 = 0;
    }
  }
}

snipe_till_dead(var_0, var_1, var_2) {
  var_3 = 0.3;
  var_0 maps\_utility::cqb_aim(var_1);
  wait(var_3);

  while(isalive(var_1) && !isDefined(var_1.fake_dead)) {
    var_4 = var_0 gettagorigin("tag_flash");
    var_5 = var_1 gettagorigin("j_head");
    var_6 = 1;

    if(!var_2)
      var_6 = sighttracepassed(var_4, var_5, 1, var_0, var_1);

    if(var_6) {
      var_0 maps\_utility::cqb_aim(var_1);
      magicbullet(var_0.weapon, var_4, var_5);
      var_0 shootblank();

      if(randomint(100) > 50) {
        wait 0.1;
        magicbullet(var_0.weapon, var_4, var_5);
        var_0 shootblank();
      }
    }

    wait 0.25;
    var_0 maps\_utility::cqb_aim(undefined);
  }
}

fail_on_player_kill() {
  if(self.team == "none" || self.team == "neutral") {
    self.maxhealth = 250;
    self.health = 250;
    self waittill("death", var_0);

    if(isDefined(var_0) && isplayer(var_0)) {
      setdvar("ui_deadquote", &"CLOCKWORK_YOU_KILLED_A_CIVILIAN");
      maps\_utility::missionfailedwrapper();
      wait 20;
    }
  }
}

scientist_set_cowered_anim() {
  self endon("death");
  level waittill("defend_shoot_air");
  wait 1;
  maps\_utility::set_generic_idle_anim("scientist_idle");
}

ambient_animate(var_0, var_1, var_2, var_3) {
  var_4 = undefined;
  var_5 = undefined;
  var_6 = self.target;
  var_7 = self.animation;

  if(!isDefined(var_3))
    var_3 = 1;

  if(isDefined(var_2) && var_2 == 1)
    var_8 = maps\_utility::dronespawn_bodyonly(self);
  else {
    var_2 = 0;
    var_8 = maps\_utility::spawn_ai();
  }

  if(isDefined(var_8)) {
    var_8 endon("death");

    if(var_2 == 0) {
      if(isDefined(var_1))
        var_8 thread prepare_to_be_shot(var_1, var_3);

      var_8 maps\_utility::set_allowdeath(1);
    }

    if(isDefined(var_7)) {
      var_8.animname = "generic";

      if(var_2 == 0 && var_3 == 1) {
        var_8 thread scientist_set_cowered_anim();
        var_8 thread fail_on_player_kill();
      }

      if(isDefined(var_6)) {
        var_4 = common_scripts\utility::getstruct(var_6, "targetname");

        if(!isDefined(var_4))
          var_5 = getnode(var_6, "targetname");

        if(isDefined(var_4))
          var_4 thread maps\_anim::anim_generic_loop(var_8, var_7);

        if(isDefined(var_5)) {
          var_8 maps\_utility::disable_arrivals();
          var_8 maps\_utility::disable_turnanims();
          var_8 maps\_utility::disable_exits();
          var_8 maps\_utility::set_run_anim(var_7);

          if(isDefined(var_0) && var_0 == 1)
            var_8 thread delete_on_complete(1);
        }
      } else if(isarray(level.scr_anim["generic"][var_7]))
        var_8 thread maps\_anim::anim_generic_loop(var_8, var_7);
      else {
        var_8 maps\_utility::disable_turnanims();
        var_8.ignoreall = 1;

        if(var_2 == 0)
          var_8.allowdeath = 1;

        var_8 thread maps\_anim::anim_single_solo(var_8, var_7);

        if(isDefined(var_0) && var_0 == 1)
          var_8 thread delete_on_complete(0);
      }
    }
  }

  return var_8;
}

delete_on_complete(var_0) {
  if(!var_0) {
    self waittillmatch("single anim", "end");
    self notify("killanimscript");
  } else
    self waittill("reached_path_end");

  if(!raven_player_can_see_ai(self))
    self delete();
}

prepare_to_be_shot(var_0, var_1) {
  self endon("death");
  level waittill(var_0);
  self.ignoreme = 0;
  self.ignoreall = 0;
  maps\_utility::anim_stopanimscripted();

  if(var_1 == 1)
    maps\_utility::set_generic_idle_anim("scientist_idle");

  maps\_utility::enable_arrivals();
  maps\_utility::enable_exits();
  maps\_utility::enable_turnanims();
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
  var_2 = isDefined(level.allies[2].function_stack) && level.allies[2].function_stack.size > 0;
  return var_0 || var_1 || var_2;
}

radio_dialog_add_and_go(var_0, var_1) {
  waittill_no_char_dialog();
  maps\_utility::radio_add(var_0);
  maps\_utility::radio_dialogue(var_0, var_1);
}

char_dialog_add_and_go(var_0) {
  waittill_no_radio_dialog();

  if(!isDefined(self) || !isalive(self)) {
    return;
  }
  level.scr_sound[self.animname][var_0] = var_0;
  maps\_utility::dialogue_queue(var_0);
}

screenshakefade(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_2))
    var_2 = 0;

  if(!isDefined(var_3))
    var_3 = 0;

  var_4 = var_1 * 10;
  var_5 = var_2 * 10;

  if(var_5 > 0)
    var_6 = var_0 / var_5;
  else
    var_6 = var_0;

  var_7 = var_3 * 10;
  var_8 = var_4 - var_7;

  if(var_7 > 0)
    var_9 = var_0 / var_7;
  else
    var_9 = var_0;

  var_10 = 0.1;
  var_0 = 0;

  for(var_11 = 0; var_11 < var_4; var_11++) {
    if(var_11 <= var_5)
      var_0 = var_0 + var_6;

    if(var_11 > var_8)
      var_0 = var_0 - var_9;

    earthquake(var_0, var_10, level.player.origin, 500);
    wait(var_10);
  }
}

introscreen_generic_black_fade_in_on_flag(var_0, var_1, var_2) {
  introscreen_generic_fade_in_on_flag("black", var_0, var_1, var_2);
}

introscreen_generic_fade_in_on_flag(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_2))
    var_2 = 1.5;

  if(!isDefined(var_3))
    maps\_hud_util::start_overlay();
  else
    maps\_hud_util::fade_out(var_3);

  common_scripts\utility::flag_wait(var_1);
  maps\_hud_util::fade_in(var_2);
  wait(var_2);
  setsaveddvar("com_cinematicEndInWhite", 0);
}

glass_destroy_targetname(var_0) {
  var_1 = getglassarray(var_0);

  foreach(var_3 in var_1)
  destroyglass(var_3);
}

nvg_goggles_off() {
  if(maps\_nightvision::nightvision_check(level.player)) {
    waittill_forceviewmodel_weapon_ready();
    level.player playSound("item_nightvision_off");
    var_0 = level.player getcurrentweapon();
    level.player forceviewmodelanimation(var_0, "nvg_up");
    level.player nightvisiongogglesforceoff();
    level.player notify("night_vision_off");
    waittill_forceviewmodel_done();
  }
}

nvg_goggles_on() {
  if(!maps\_nightvision::nightvision_check(level.player)) {
    waittill_forceviewmodel_weapon_ready();
    level.player playSound("item_nightvision_on");
    var_0 = level.player getcurrentweapon();
    level.player forceviewmodelanimation(var_0, "nvg_down");
    level.player nightvisiongogglesforceon();
    level.player notify("night_vision_on");
    waittill_forceviewmodel_done();
  }
}

waittill_forceviewmodel_done() {
  wait 2;
  level.player enableweaponpickup();
  level.player enableweaponswitch();
}

waittill_forceviewmodel_weapon_ready() {
  level.player disableweaponpickup();
  level.player disableweaponswitch();

  while(level.player isswitchingweapon() || level.player getcurrentweapon() == "none")
    common_scripts\utility::waitframe();
}

overheard_radio_chatter(var_0, var_1, var_2) {
  if(1) {
    return;
  }
  common_scripts\utility::flag_wait_or_timeout(var_2, var_1);

  if(common_scripts\utility::flag(var_2)) {
    return;
  }
  if(!isDefined(level.background_radio_emitter)) {
    var_3 = spawn("script_origin", (0, 0, 0));
    var_3 linkto(level.player, "", (0, 0, 0), (0, 0, 0));
    level.background_radio_emitter = var_3;
  }

  maps\_utility::bcs_scripted_dialogue_start();
  var_4 = level.background_radio_emitter maps\_utility::function_stack(maps\_utility::play_sound_on_tag, var_0, undefined, 1);
  return var_4;
}

glowstick_hacking_on(var_0) {
  playFXOnTag(level._effect["glowstick"], var_0, "J_prop_1");
  common_scripts\utility::flag_wait("thermite_start");
  glowstick_off(var_0);
}

glowstick1_on(var_0) {
  playFXOnTag(level._effect["vfx/moments/clockwork/vfx_vault_glowstick1"], var_0, "J_prop_1");
  common_scripts\utility::flag_wait("thermite_start");
  stopFXOnTag(level._effect["vfx/moments/clockwork/vfx_vault_glowstick1"], var_0, "J_prop_1");
  playFXOnTag(level._effect["vfx/moments/clockwork/vfx_vault_glowstick1_fade"], var_0, "J_prop_1");
}

glowstick2_on(var_0) {
  playFXOnTag(level._effect["vfx/moments/clockwork/vfx_vault_glowstick2"], var_0, "J_prop_1");
  common_scripts\utility::flag_wait("thermite_start");
  stopFXOnTag(level._effect["vfx/moments/clockwork/vfx_vault_glowstick2"], var_0, "J_prop_1");
  playFXOnTag(level._effect["vfx/moments/clockwork/vfx_vault_glowstick2_fade"], var_0, "J_prop_1");
}

glowstick_off(var_0) {
  stopFXOnTag(level._effect["glowstick"], var_0, "J_prop_1");
}

unhide_prop(var_0) {
  var_1 = 0;

  switch (var_0.animname) {
    case "vault_spool_prop":
      level.spool show();
      var_1 = 1;
      break;
    case "vault_glowstick1_prop":
      level.glowstick1 show();
      var_1 = 1;
      break;
    case "vault_glowstick2_prop":
      level.glowstick2 show();
      var_1 = 1;
      break;
    case "vault_tablet_prop":
      level.tablet show();
      var_1 = 1;
      break;
    case "vault_drill_prop":
      common_scripts\utility::array_thread(level.drill_pickup, maps\_utility::show_entity);
      var_1 = 1;
      wait 2;
      common_scripts\utility::flag_set("drill_pickup_ready");
  }

  if(!var_1)
    var_0 show();
}

raven_player_can_see_ai(var_0, var_1) {
  var_2 = gettime();

  if(!isDefined(var_1))
    var_1 = 0;

  if(isDefined(var_0.playerseesmetime) && var_0.playerseesmetime + var_1 >= var_2)
    return var_0.playerseesme;

  var_0.playerseesmetime = var_2;

  if(!common_scripts\utility::within_fov(level.player.origin, level.player.angles, var_0.origin, 0.766)) {
    var_0.playerseesme = 0;
    return 0;
  }

  var_3 = level.player getEye();
  var_4 = var_0.origin;

  if(sighttracepassed(var_3, var_4, 0, level.player)) {
    var_0.playerseesme = 1;
    return 1;
  }

  var_5 = var_0 getEye();

  if(sighttracepassed(var_3, var_5, 0, level.player)) {
    var_0.playerseesme = 1;
    return 1;
  }

  var_6 = (var_5 + var_4) * 0.5;

  if(sighttracepassed(var_3, var_6, 0, level.player)) {
    var_0.playerseesme = 1;
    return 1;
  }

  var_0.playerseesme = 0;
  return 0;
}

toggle_visibility(var_0, var_1) {
  var_2 = getEntArray(var_0, "targetname");

  foreach(var_4 in var_2) {
    if(var_1) {
      var_4 show();
      continue;
    }

    var_4 hide();
  }
}

waittill_player_close_to_or_aiming_at(var_0, var_1, var_2) {
  var_3 = var_1 * var_1;

  while(isDefined(var_0) && isalive(var_0)) {
    var_4 = distance2dsquared(level.player.origin, var_0.origin);

    if(var_4 < var_3) {
      break;
    }

    var_5 = level.player getEye();
    var_6 = var_0 getEye();
    var_7 = bulletTrace(var_5, var_6, 1, level.player, 0, 0);

    if(isDefined(var_7["entity"]) && var_7["entity"] == var_0) {
      break;
    }

    if(level.player worldpointinreticle_circle(var_6, 65, var_2)) {
      break;
    }

    common_scripts\utility::waitframe();
  }
}

safe_hide() {
  if(isDefined(self))
    self hide();
}

setup_drill(var_0) {
  if(isDefined(level.drill_pickup)) {
    return;
  }
  level.drill_pickup = getEntArray("pickup_drill", "targetname");

  foreach(var_2 in level.drill_pickup) {}

  level.drill_pickup = common_scripts\utility::array_removeundefined(level.drill_pickup);

  if(isDefined(var_0) && var_0)
    common_scripts\utility::array_thread(level.drill_pickup, ::safe_hide);
}

dog_setup() {
  if(getdvarint("dog_enabled", 0)) {
    level.woof = 1;
    maps\hud_outline_objective::outline_enable();
  }
}

link_dog_to_jeep(var_0) {
  level.dog linkto(var_0, "tag_body");
  var_0 thread maps\_anim::anim_loop_solo(level.dog, "veh_idle", "stop_dog_loop", "tag_body", (-55, -10, -10));
}

dog_alt_combat_check_clockwork(var_0) {
  if(isDefined(self.enemy) && isDefined(self.enemy.type) && self.enemy.type == "dog")
    return 1;

  if(isDefined(self.enemy) && self.enemy.team == "allies")
    return 1;

  return 0;
}

transient_switch_to_end() {
  maps\_utility::transient_unload("clockwork_start_tr");
  maps\_utility::transient_load("clockwork_end_tr");
}

walkout_do_stop_transition_anim(var_0) {
  if(!common_scripts\utility::flag("exfil_fire_fail")) {
    self.go_to_waiting = isDefined(var_0.script_delay) && var_0.script_delay > 0.5 || isDefined(var_0.script_delay_post) && var_0.script_delay_post > 0.5 || isDefined(var_0.script_flag_wait) && !common_scripts\utility::flag(var_0.script_flag_wait) || (isDefined(var_0.script_wait) || isDefined(self.script_wait_min) && isDefined(self.script_wait_max)) || isDefined(var_0.script_requires_player);

    if(!self.go_to_waiting || self isinscriptedstate()) {
      return;
    }
    var_1 = "enter_idle_l";
    var_2 = "idle_l";

    if(self.idle_right) {
      var_1 = "enter_idle_r";
      var_2 = "idle_r";
    }

    maps\_utility::set_generic_idle_anim(var_2);
    maps\_anim::anim_single_solo(self, var_1);
    self setgoalpos(self.origin);
  }
}

walkout_do_start_transition_anim(var_0) {
  if(!common_scripts\utility::flag("exfil_fire_fail")) {
    while(self.go_to_waiting && self isinscriptedstate())
      common_scripts\utility::waitframe();

    if(!self.go_to_waiting || self isinscriptedstate()) {
      return;
    }
    merrick_script_delay_post(var_0);
    var_1 = "exit_idle_l";

    if(self.idle_right)
      var_1 = "exit_idle_r";

    thread maps\_anim::anim_single_solo(self, var_1);
    thread transition_start_anim(var_1);
    self.go_to_waiting = undefined;
  }
}

transition_start_anim(var_0) {
  var_1 = getanimlength(level.scr_anim[self.animname][var_0]);
  thread maps\_anim::anim_single_solo(self, var_0);
  wait(var_1 - 0.05);
  maps\_utility::clear_generic_idle_anim();
  self stopanimscripted();
}

merrick_script_delay_post(var_0) {
  if(var_0.script_flag_wait != "chaos_footstairs_anims" || self.animname != "baker") {
    return;
  }
  wait 2;
}

enemy_stop_stealth() {
  self stopanimscripted();

  if(self.type != "dog")
    maps\_utility::gun_recall();

  self.ignoreall = 0;
  self.ignoreme = 0;
}

guy_runtovehicle_loaded_custom(var_0, var_1) {
  var_0 endon("stop_loading");
  maps\_vehicle_aianim::guy_runtovehicle_loaded(var_0, var_1);
}

vehicle_runtooverride(var_0) {
  level thread guy_runtovehicle_custom(var_0, self);
}

guy_runtovehicle_custom(var_0, var_1, var_2, var_3) {
  var_1 endon("stop_loading");
  var_4 = 1;

  if(!isDefined(var_2))
    var_2 = 0;

  var_5 = level.vehicle_aianims[var_1.classname];
  var_1 endon("death");
  var_0 endon("death");
  var_0 endon("stop_loading");
  var_1.runningtovehicle[var_1.runningtovehicle.size] = var_0;
  thread guy_runtovehicle_loaded_custom(var_0, var_1);
  var_6 = [];
  var_7 = undefined;
  var_8 = 0;
  var_9 = 0;

  for(var_10 = 0; var_10 < var_5.size; var_10++) {
    if(isDefined(var_5[var_10].getin))
      var_9 = 1;
  }

  if(!var_9) {
    var_0 notify("enteredvehicle");
    var_1 maps\_vehicle_aianim::guy_enter(var_0, var_4);
    return;
  }

  if(!isDefined(var_0.get_in_moving_vehicle)) {
    while(var_1 vehicle_getspeed() > 1)
      wait 0.05;
  }

  var_11 = var_1 maps\_vehicle_aianim::get_availablepositions(var_3);

  if(isDefined(var_0.script_startingposition))
    var_7 = var_1 maps\_vehicle_aianim::vehicle_getinstart(var_0.script_startingposition);
  else if(!var_1.usedpositions[0]) {
    var_7 = var_1 maps\_vehicle_aianim::vehicle_getinstart(0);

    if(var_2) {
      var_0 thread maps\_utility::magic_bullet_shield();
      thread maps\_vehicle_aianim::remove_magic_bullet_shield_from_guy_on_unload_or_death(var_0);
    }
  } else if(var_11.availablepositions.size)
    var_7 = common_scripts\utility::getclosest(var_0.origin, var_11.availablepositions);
  else
    var_7 = undefined;

  if(!var_11.availablepositions.size && var_11.nonanimatedpositions.size) {
    var_0 notify("enteredvehicle");
    var_1 maps\_vehicle_aianim::guy_enter(var_0, var_4);
    return;
  } else if(!isDefined(var_7)) {
    return;
  }
  var_8 = var_7.origin;
  var_12 = var_7.angles;
  var_0.forced_startingposition = var_7.vehicle_position;
  var_1.usedpositions[var_7.vehicle_position] = 1;
  var_0.script_moveoverride = 1;
  var_0 notify("stop_going_to_node");
  var_0 maps\_utility::set_forcegoal();
  var_0 maps\_utility::disable_arrivals();
  var_0.goalradius = 16;
  var_0 setgoalpos(var_8);
  var_0 waittill("goal");
  var_0 maps\_utility::enable_arrivals();
  var_0 maps\_utility::unset_forcegoal();
  var_0 notify("boarding_vehicle");
  var_0.boarding_vehicle = 1;
  var_13 = maps\_vehicle_aianim::anim_pos(var_1, var_7.vehicle_position);

  if(isDefined(var_13.delay)) {
    var_0.delay = var_13.delay;

    if(isDefined(var_13.delayinc))
      self.delayer = var_0.delay;
  }

  if(isDefined(var_13.delayinc)) {
    self.delayer = self.delayer + var_13.delayinc;
    var_0.delay = self.delayer;
  }

  var_1 maps\_vehicle_aianim::link_to_sittag(var_0, var_13.sittag, var_13.sittag_offset, var_13.linktoblend);
  var_0.allowdeath = 0;
  var_13 = var_5[var_7.vehicle_position];

  if(isDefined(var_7)) {
    if(isDefined(var_13.vehicle_getinanim)) {
      if(isDefined(var_13.vehicle_getoutanim)) {
        var_14 = isDefined(var_0.no_vehicle_getoutanim);

        if(!var_14)
          var_1 clearanim(var_13.vehicle_getoutanim, 0);
      }

      var_1 = var_1 maps\_vehicle_aianim::getanimatemodel();
      var_1 thread maps\_vehicle_aianim::setanimrestart_once(var_13.vehicle_getinanim, var_13.vehicle_getinanim_clear);
      level thread maps\_anim::start_notetrack_wait(var_1, "vehicle_anim_flag");
    }

    if(isDefined(var_13.vehicle_getinsoundtag))
      var_8 = var_1 gettagorigin(var_13.vehicle_getinsoundtag);
    else
      var_8 = var_1.origin;

    if(isDefined(var_13.vehicle_getinsound))
      thread common_scripts\utility::play_sound_in_space(var_13.vehicle_getinsound, var_8);

    var_15 = undefined;
    var_16 = undefined;

    if(isDefined(var_13.getin_enteredvehicletrack)) {
      var_15 = [];
      var_15[0] = var_13.getin_enteredvehicletrack;
      var_16 = [];
      var_16[0] = maps\_vehicle_aianim::entered_vehicle_notify;
      var_1 maps\_vehicle_aianim::link_to_sittag(var_0, var_13.sittag, var_13.sittag_offset, var_13.linktoblend);
    }

    var_1 maps\_vehicle_aianim::animontag(var_0, var_13.sittag, var_13.getin, var_15, var_16);
  }

  var_0 notify("enteredvehicle");
  var_1 maps\_vehicle_aianim::guy_enter(var_0, var_4);
}

set_run_anim_ref(var_0, var_1) {
  if(isDefined(var_1))
    self.alwaysrunforward = var_1;
  else
    self.alwaysrunforward = 1;

  maps\_utility::disable_turnanims();
  self.run_overrideanim = var_0;
  self.walk_overrideanim = self.run_overrideanim;
}

icehole_achievement() {
  level.icehole_achievement++;

  if(level.icehole_achievement == 8)
    level.player maps\_utility::player_giveachievement_wrapper("LEVEL_10A");
}