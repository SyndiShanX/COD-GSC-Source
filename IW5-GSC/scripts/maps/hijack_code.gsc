/****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\hijack_code.gsc
****************************************/

start_logic() {
  level.commander = maps\_utility::spawn_targetname("commander");
  level.commander maps\_utility::magic_bullet_shield();
  level.advisor = maps\_utility::spawn_targetname("advisor");
  level.advisor maps\_utility::magic_bullet_shield();
}

spawn_ally(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = level.start_point + "_" + var_0;
  }
  var_2 = spawn_noteworthy_at_struct_targetname(var_0, var_1);
  return var_2;
}

spawn_noteworthy_at_struct_targetname(var_0, var_1) {
  var_2 = getEnt(var_0, "script_noteworthy");
  var_3 = common_scripts\utility::getStruct(var_1, "targetname");
  var_2.origin = var_3.origin;

  if(isDefined(var_3.angles)) {
    var_2.angles = var_3.angles;
  }
  var_4 = var_2 maps\_utility::spawn_ai();
  return var_4;
}

try_activate_trigger_targetname(var_0) {
  var_1 = getEnt(var_0, "targetname");

  if(isDefined(var_1) && !isDefined(var_1.trigger_off)) {
    var_1 maps\_utility::activate_trigger();
  }
}

array_wait_any(var_0, var_1, var_2) {
  var_3 = "array_wait_any_" + var_1;

  foreach(var_5 in var_0) {}
  var_5 thread array_wait_set(var_1, var_3);

  if(!isDefined(var_2)) {
    level waittill(var_3);
  } else {
    level common_scripts\utility::waittill_any_timeout(var_2, var_3);
  }
}

array_wait_set(var_0, var_1) {
  self waittill(var_0);
  level notify(var_1);
}

ai_civilian_think() {
  var_0 = getEnt(self.target, "targetname");
  var_1 = var_0.script_noteworthy;
  self.allowdeath = 1;
  self.animname = "generic";
  self.health = 1;
  self.noragdoll = 1;
  self.no_pain_sound = 1;
  self.deathanim = level.scr_anim["generic"][var_1];
  self.a.nodeath = 1;
  self.delete_on_death = 0;
  self.nofriendlyfire = 1;
  self.ignoreme = 1;
  var_0 thread maps\_anim::anim_single_solo(self, var_1);
  wait 0.2;
  self kill();
}

cold_breath_hijack() {
  var_0 = "TAG_EYE";
  self endon("death");
  self notify("stop personal effect");
  self endon("stop personal effect");
  self.has_cold_breath = 1;

  while(isDefined(self)) {
    wait 0.05;

    if(!isDefined(self)) {
      break;
    }

    playFXOnTag(level._effect["cold_breath"], self, var_0);
    wait(2.5 + randomfloat(2.5));
  }
}

plane_rumbling() {
  level endon("stop_rumbling");

  for(;;) {
    earthquake(0.15, 0.05, level.player.origin, 80000);
    wait 0.05;
  }
}

setup_player_for_animation() {
  get_player_rig();
  level.player allowcrouch(0);
  level.player allowprone(0);
  level.player allowsprint(0);
  level.player allowjump(0);
}

unsetup_player_after_animation() {
  level.player unlink();
  level.player allowcrouch(1);
  level.player allowprone(1);
  level.player allowsprint(1);
  level.player allowjump(1);
  level.player_rig delete();
}

get_player_rig() {
  if(!isDefined(level.player_rig)) {
    level.player_rig = maps\_utility::spawn_anim_model("player_rig");
  }
  return level.player_rig;
}

no_grenades() {
  self.grenadeammo = 0;
}

background_chatter(var_0, var_1) {
  if(!isDefined(var_1)) {
    return;
  }
  if(isDefined(var_1.deleteme)) {
    var_1 delete();
  }
  var_1 playSound(var_0, "done");
  var_1 waittill("done");
}

check_player_for_prone(var_0) {
  self endon("player_clear_of_idle");
  self endon("stop_prone_check");

  for(;;) {
    var_1 = distance(level.player.origin, self.origin);

    if(level.player getstance() == "prone" && var_1 < 50) {
      self invisiblenotsolid();
      level.player allowcrouch(0);
      level.player allowstand(0);
    } else {
      self visiblesolid();
      level.player allowcrouch(1);
      level.player allowstand(1);
      wait 0.05;

      if(isDefined(var_0) && var_0 == "true") {
        self notify("player_clear_of_idle");
      }
    }

    wait 0.05;
  }
}

rotate_rollers_roll(var_0, var_1, var_2, var_3) {
  self rotateroll(var_0, var_1, var_2, var_3);
}

rotate_rollers_pitch(var_0, var_1, var_2, var_3) {
  self rotatepitch(var_0, var_1, var_2, var_3);
}

rotate_rollers_to(var_0, var_1, var_2, var_3) {
  self rotateTo(var_0, var_1, var_2, var_3);
}

gravity_shift(var_0, var_1, var_2) {
  setsaveddvar("phys_gravityChangeWakeupRadius", 1600);
  setphysicsgravitydir((var_0, var_1, var_2));
}

hjk_beginsliding(var_0, var_1, var_2) {
  var_3 = self;
  var_3 thread maps\_utility::play_sound_on_entity("foot_slide_plr_start");
  var_3 thread maps\_utility::play_loop_sound_on_tag("foot_slide_plr_loop");
  var_4 = isDefined(level.custom_linkto_slide);

  if(!isDefined(var_0)) {
    var_0 = var_3 getvelocity() + (0, 0, -10);
  }
  if(!isDefined(var_1)) {
    var_1 = 10;
  }
  if(!isDefined(var_2)) {
    var_2 = 0.035;
  }
  var_5 = spawn("script_origin", var_3.origin);
  var_5.angles = var_3.angles;
  var_3.slidemodel = var_5;
  var_5 moveslide((0, 0, 15), 15, var_0);

  if(var_4) {
    var_3 playerlinktodelta(var_5, undefined, 0);
  } else {
    var_3 playerlinkTo(var_5, undefined, 0, 180, 180, 180, 180, 1);
  }
  if(!isDefined(level.custom_linkto_slide_allow_prone)) {
    var_3 allowprone(0);
  }
  var_3 thread maps\_utility_code::doslide(var_5, var_1, var_2);
}

hjk_endsliding() {
  var_0 = self;

  if(!isDefined(var_0.slidemodel)) {
    return;
  }
  var_0 notify("stop soundfoot_slide_plr_loop");
  var_0 thread maps\_utility::play_sound_on_entity("foot_slide_plr_end");
  var_0 unlink();
  var_0 setvelocity(var_0.slidemodel.slidevelocity);
  var_0.slidemodel delete();
  var_0 allowprone(1);
  var_0 allowstand(1);
  var_0 notify("stop_sliding");
}

rockingplane() {
  level endon("stop_rocking");
  var_0 = level.org_view_roll;
  var_1 = common_scripts\utility::spawn_tag_origin();
  var_2 = undefined;

  if(!isDefined(var_0)) {
    var_1.angles = (0, 0, 0);
  } else {
    var_1.origin = var_0.origin;
    var_1.angles = var_0.angles;
  }

  var_3 = 1;
  level.rocking_mag[0] = 0.25;
  level.rocking_mag[1] = 0.625;

  for(;;) {
    var_4 = randomfloatrange(6.0, 7.0);
    var_5 = var_3 * randomfloatrange(level.rocking_mag[0], level.rocking_mag[1]);
    var_3 = -1 * var_3;
    var_6 = (0, 0, var_5);
    common_scripts\utility::array_thread(level.arollers, ::rotate_rollers_to, var_6, var_4, var_4 / 3, var_4 / 3);
    wait(var_4);
  }
}

stoprocking(var_0) {
  common_scripts\utility::flag_wait("obj_capturesub_complete");
  level notify("stop_rocking");
  level.player playersetgroundreferenceent(undefined);
  self delete();

  if(isDefined(var_0)) {
    var_0 delete();
  }
}

set_grav(var_0) {
  level endon("stop_rocking");
  thread reset_grav();
  var_1 = 0;
  var_2 = common_scripts\utility::getStruct("jolter", "targetname");

  for(;;) {
    var_3 = anglestoup(var_0.angles);
    var_4 = -1 * var_3;
    var_5 = var_4 * (1, 10, 0.75);
    var_6 = vectorNormalize(var_5);
    setphysicsgravitydir(var_6);
    var_1++;

    if(var_1 > 10) {
      physicsjitter(var_2.origin, 1000, 800, 0.01, 0.1);
      var_1 = 0;
    }

    wait 0.05;
  }
}

reset_grav() {
  level waittill("stop_rocking");
  wait 0.05;
  setphysicsgravitydir((0, 0, -1));
}

setup_ent_rockers() {
  level.rockers = [];
  level.rockers_opp = [];
  level.rocker_hangers = [];
  var_0 = getEntArray("sub_pressuredoor_rocker", "targetname");

  foreach(var_2 in var_0) {
    var_3 = getEnt(var_2.target, "targetname");
    var_2 linkTo(var_3);
    level.rockers[level.rockers.size] = var_3;
  }

  var_0 = getEntArray("sub_pressuredoor_rocker_opposite", "targetname");

  foreach(var_2 in var_0) {
    var_3 = getEnt(var_2.target, "targetname");
    var_2 linkTo(var_3);
    level.rockers_opp[level.rockers_opp.size] = var_3;
  }

  var_7 = getEntArray("dyn_hanger", "targetname");

  foreach(var_9 in var_7) {
    var_3 = getEnt(var_9.target, "targetname");
    var_9 linkTo(var_3);
    level.rocker_hangers[level.rocker_hangers.size] = var_3;
  }
}

turbulence(var_0) {
  thread turbulence_loop();
  var_1 = var_0;
  wait(var_1);
  common_scripts\utility::flag_set("stop_turbulence");
  var_2 = abs(level.turbangles[0]) / 8;
  level.org_view_roll rotateTo((0, 0, 0), var_2, 0, 0);
  wait(var_2);
}

turbulence_loop() {
  level endon("stop_turbulence");
  var_0 = 1;
  level.rocking_mag[0] = 0.3;
  level.rocking_mag[1] = 0.5;
  level.pitch_mag[0] = 2;
  level.pitch_mag[1] = 5;

  for(;;) {
    var_1 = randomfloatrange(0.1, 0.2);
    var_2 = var_0 * randomfloatrange(level.pitch_mag[0], level.pitch_mag[1]);
    var_3 = var_0 * randomfloatrange(level.rocking_mag[0], level.rocking_mag[1]);
    var_4 = var_0 * randomfloatrange(level.rocking_mag[0], level.rocking_mag[1]);
    var_0 = -1 * var_0;
    level.turbangles = (var_2, var_3, var_4);
    earthquake(0.1, var_1, level.player.origin, 80000);
    level.org_view_roll rotateTo(level.turbangles, var_1, var_1 / 3, var_1 / 3);
    wait(var_1);
  }
}

launch_object(var_0, var_1) {
  var_2 = randomfloatrange(0, 0.9);
  wait(var_2);
  var_0 = var_0 * level.objectmass[self.model];
  var_3 = var_1 * var_0;
  self physicslaunchclient(self.origin, var_3);
}

start_phys_explosion_on_delay(var_0, var_1, var_2) {
  var_3 = randomfloatrange(0, 0.9);
  wait(var_3);
  physicsexplosionsphere(self.origin, var_0, var_1, var_2);
}

fade_out(var_0, var_1) {
  var_2 = get_black_overlay();

  if(var_0) {
    var_2 fadeovertime(var_0);
  }
  if(isDefined(var_1)) {
    var_2.alpha = var_1;
  } else {
    var_2.alpha = 1;
  }
  wait(var_0);
}

fade_in(var_0) {
  if(level.missionfailed) {
    return;
  }
  level notify("now_fade_in");
  var_1 = get_black_overlay();

  if(var_0) {
    var_1 fadeovertime(var_0);
  }
  var_1.alpha = 0;
  wait(var_0);
}

get_black_overlay() {
  if(!isDefined(level.black_overlay)) {
    level.black_overlay = maps\_hud_util::create_client_overlay("black", 0, level.player);
  }
  level.black_overlay.sort = -1;
  level.black_overlay.foreground = 0;
  return level.black_overlay;
}

airmask_setup() {
  self.dummy = spawn("script_origin", self.origin + (0, 0, 30));
  self.dummy.angles = level.org_view_roll.angles;
  level.arollers = maps\_utility::array_add(level.arollers, self.dummy);
  self linkTo(self.dummy);
  self.dummy movez(45, 0.1);
  self hide();
}

airmask_think() {
  if(getDvar("airmasks") == "0") {
    return;
  }
  self show();
  var_0 = randomfloatrange(0.75, 1.2);
  self.dummy movez(-55, var_0, var_0 / 3, var_0 / 3);
  wait(var_0);
  self.dummy movez(10, var_0 / 2);
  wait(var_0 / 2);
}

ai_array_killcount_flag_set(var_0, var_1, var_2, var_3) {
  maps\_utility::waittill_dead_or_dying(var_0, var_1, var_3);
  common_scripts\utility::flag_set(var_2);
}

temp_dialogue(var_0, var_1, var_2) {
  level notify("temp_dialogue", var_0, var_1, var_2);
  level endon("temp_dialogue");

  if(!isDefined(var_2)) {
    var_2 = 4;
  }
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

hjk_red_light_pulsing(var_0) {
  var_1 = 0.15;
  var_2 = 0.6;
  var_3 = var_2;

  for(;;) {
    while(var_3 > var_1) {
      var_3 = max(var_3 - var_2 / 7.5, var_1);
      self setlightintensity(var_3);
      wait 0.05;
    }

    wait 0.15;
    pulsing_light_fx(var_0);

    while(var_3 < var_2) {
      var_3 = min(var_3 + var_2 / 10, var_2);
      self setlightintensity(var_3);
      wait 0.05;
    }

    wait 0.15;
  }
}

pulsing_light_fx(var_0) {
  switch (var_0) {
    case 0:
      common_scripts\utility::exploder("light_0");
      break;
    case 1:
      common_scripts\utility::exploder("light_1");
      break;
    case 2:
      common_scripts\utility::exploder("light_2");
      break;
    case 3:
      common_scripts\utility::exploder("light_3");
      break;
    default:
      break;
  }
}

so_remove_entities_by_script_difficulty() {
  var_0 = "";

  switch (level.gameskill) {
    case 1:
    case 0:
      var_0 = "regular";
      break;
    case 2:
      var_0 = "hardened";
      break;
    case 3:
      var_0 = "veteran";
      break;
    default:
      break;
  }

  var_1 = getEntArray();

  foreach(var_3 in var_1) {
    if(!isDefined(var_3.script_difficulty)) {
      continue;
    }
    if(so_should_delete_entity_by_difficulty(var_3, var_0, maps\_utility::is_coop())) {
      var_3 delete();
    }
  }
}

so_should_delete_entity_by_difficulty(var_0, var_1, var_2) {
  var_3 = [];
  var_4 = strtok(var_0.script_difficulty, ",");
  var_5 = 0;

  foreach(var_7 in var_4) {
    var_3[var_5] = strtok(var_7, "_");
    var_5++;
  }

  foreach(var_10 in var_3) {
    var_11 = maps\_utility::array_contains(var_10, "coop");
    var_12 = maps\_utility::array_contains(var_10, "sp");

    if(var_11 || var_12) {
      if(var_2 && !var_11) {
        continue;
      }
      if(!var_2 && !var_12) {
        continue;
      }
    }

    var_13 = maps\_utility::array_contains(var_10, "regular");
    var_14 = maps\_utility::array_contains(var_10, "hardened");
    var_15 = maps\_utility::array_contains(var_10, "veteran");

    if(var_13 || var_14 || var_15) {
      if(var_1 == "regular" && !var_13) {
        continue;
      }
      if(var_1 == "hardened" && !var_14) {
        continue;
      }
      if(var_1 == "veteran" && !var_15) {
        continue;
      }
    }

    return 0;
  }

  return 1;
}