/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_dpad_asset.gsc
**************************************/

#include maps\_utility;
#include common_scripts\utility;
#include maps\_anim;
#using_animtree("generic_human");
rocket_barrage_init() {
  level._effect["target_smoke"] = loadfx("env/smoke/fx_smoke_ground_marker_green_w");
  level._effect["rocket_trail"] = loadfx("weapon/rocket/fx_lci_rocket_geotrail");
  level._effect["grenade_smoke"] = loadfx("weapon/grenade/fx_smoke_grenade_generic");

  level._effect["target_arrow"] = loadfx("misc/fx_ui_airstrike");
  level._effect["target_arrow_confirm"] = loadfx("misc/fx_ui_airstrike_confirm");

  level._effect["target_arrow_green"] = loadfx("misc/fx_ui_airstrike_smk_green");
  level._effect["target_arrow_yellow"] = loadfx("misc/fx_ui_airstrike_smk_yellow");
  level._effect["target_arrow_red"] = loadfx("misc/fx_ui_airstrike_smk_red");

  level.rocketbarrage_traceLength = 4000;

  level.barrage_charge_time = 35;

  level.rocket_barrage_allowed = false;
  level.friendly_check_radius = 500;
  level.rocket_barrage_firing_positions = [];
  level.rocket_barrage_no_zones = getEntArray("rocket_barrage_no_zone", "targetname");
  level.rocket_barrage_first_barrage = true;
  level.rocket_barrage_max_x = 5000;
  level.rocket_barrage_min_x = -800;
  level.rocket_barrage_max_y = -3500;
  level.rocket_barrage_min_y = -8200;
}
rocket_barrage_player_init() {
  self.rocket_targeting_on = false;
  self.is_firing_rocket_barrage = false;
  self.rockets_are_out_times = 0;
  self.rocket_barrage_ai_was_hit = false;
  self.rocket_barrage_bunker_was_hit = false;
  self.rocket_barrage_vehicle_was_hit = false;

  self.rocket_barrage_ok = false;
  self.rocket_barrage_generic_fire_count = 1;
  self.rocket_barrage_hit_ai_count = 1;
  self.rocket_barrage_ready_count = 1;
  self.rocket_barrage_recharging_count = 1;

  self.rocket_barrage_at_major_target = false;

  self thread rocket_barrage_watcher();
}
rocket_barrage_watcher() {
  self endon("death");
  self endon("disconnect");

  if(!isDefined(self.is_firing_rocket_barrage)) {
    return;
  }

  if(!isDefined(level.rocket_barrage_allowed)) {
    return;
  }

  for(;;) {
    if(!self.is_firing_rocket_barrage && level.rocket_barrage_allowed) {
      weap = self getcurrentweapon();

      if(self getcurrentweapon() == "rocket_barrage" && !self.rocket_targeting_on && !self.usingturret) {
        self thread rocket_barrage_targeting();
        self.rocket_targeting_on = true;

        wait 0.5;
      } else if((self getcurrentweapon() != "rocket_barrage" || self.usingturret) && self.rocket_targeting_on) {
        self.Rocket_Targeting_On = false;

        self notify("end rocket barrage targeting");

        delete_spotting_target();

        wait 0.5;
      } else if(self getcurrentweapon() != "rocket_barrage" || self.usingturret) {
        self.Rocket_Targeting_On = false;

        self notify("end rocket barrage targeting");

        delete_spotting_target();

        wait 0.5;
      }
    } else if(self.is_firing_rocket_barrage && level.rocket_barrage_allowed && !self.usingturret) {
      if(self getcurrentweapon() == "rocket_barrage") {
        self notify("activate pressed during barage");
        wait 0.1;
      }
    }

    wait(0.05);
  }
}
rocket_barrage_targeting() {
  self endon("end rocket barrage targeting");
  self endon("rocket barrage firing");
  self endon("death");
  self endon("disconnect");

  self notify("start rocket barrage targeting");

  targetpoint = spawn("script_model", get_players()[0].origin);
  targetpoint.angles += (270, 0, 0);
  targetpoint setModel("tag_origin");
  self.rocket_barrage_target = targetpoint;

  self thread draw_smoke(targetpoint);

  for(;;) {
    direction = self getPlayerAngles();
    direction_vec = anglesToForward(direction);
    eye = self getEye();

    trace = bulletTrace(eye, eye + vector_multiply(direction_vec, level.rocketbarrage_traceLength), 0, undefined);
    trace2 = bulletTrace(trace["position"] + (0, 0, 2), trace["position"] - (0, 0, 100000), 0, undefined);

    tracepos = trace2["position"];
    if(tracepos[2] < -650) {
      tracepos = (tracepos[0], tracepos[1], -650);
      trace2["position"] = tracepos;
    }

    if(isDefined(self.rocket_barrage_target)) {
      self.rocket_barrage_target.origin = trace2["position"];
      self.rocket_barrage_target rotateTo(vectortoangles(trace2["normal"]), 0.15);
    }

    friends = getaiarray("allies");
    players = get_players();

    friends = array_merge(friends, players);

    touching_no_zone = false;
    for(i = 0; i < level.rocket_barrage_no_zones.size; i++) {
      if(targetpoint istouching(level.rocket_barrage_no_zones[i])) {
        touching_no_zone = true;
      }
    }

    for(i = 0; i < friends.size; i++) {
      if(distance(targetpoint.origin, friends[i].origin) > level.friendly_check_radius) {
        if(self.usingturret) {
          self.rocket_barrage_ok = false;
        } else if(level.rocket_barrage_first_barrage && targetpoint.origin[1] > -11000 && targetpoint.origin[0] > 1000 && targetpoint.origin[0] < 3000) {
          self.rocket_barrage_ok = true;
        } else if(targetpoint.origin[0] > level.rocket_barrage_max_x || targetpoint.origin[0] < level.rocket_barrage_min_x) {
          self.rocket_barrage_ok = false;
        } else if(targetpoint.origin[1] > level.rocket_barrage_max_y || targetpoint.origin[1] < level.rocket_barrage_min_y) {
          self.rocket_barrage_ok = false;
        } else if(touching_no_zone) {
          self.rocket_barrage_ok = false;
        } else {
          self.rocket_barrage_ok = true;
        }
      } else {
        self.rocket_barrage_ok = false;
      }
    }

    self.rocket_barrage_at_major_target = false;
    for(i = 0; i < level.rocket_barrage_targets.size; i++) {
      if(level.rocket_barrage_targets[i] istouching(self.rocket_barrage_target)) {
        self.rocket_barrage_at_major_target = true;
      }
    }

    self thread rocket_barrage_fire_watch(targetpoint.origin);

    wait(0.05);
  }
}
draw_smoke(targetpoint) {
  self endon("target smoke deleted");
  self endon("death");
  self endon("disconnect");

  while(1) {
    playercolor0 = getDvar("cg_ScoresColor_Player_0");
    playercolor1 = getDvar("cg_ScoresColor_Player_1");
    playercolor2 = getDvar("cg_ScoresColor_Player_2");
    playercolor3 = getDvar("cg_ScoresColor_Player_3");

    if(self.rocket_barrage_ok) {
      playFXOnTag(level._effect["target_arrow_yellow"], targetpoint, "tag_origin");
    } else {
      playFXOnTag(level._effect["target_arrow_red"], targetpoint, "tag_origin");
    }
    wait 0.1;
  }
}
rocket_barrage_fire_watch(fire_point) {
  self endon("death");
  self endon("disconnect");

  if(self attackbuttonPressed() && !self.is_firing_rocket_barrage && self.rocket_barrage_ok && level.rocket_barrage_first_barrage) {
    self.is_firing_rocket_barrage = true;

    self thread rocket_barrage_switch_back();

    self notify("rocket barrage firing");
    level notify("used rocket once");

    self.rocket_barrage_confirm = spawn("script_model", fire_point);
    self.rocket_barrage_confirm setModel("tag_origin");
    self.rocket_barrage_confirm.angles = self.rocket_barrage_target.angles;
    self.rocket_barrage_confirm thread play_confirm();
    thread delete_confirm_arrow();

    delete_spotting_target();

    self SetWeaponAmmoClip("rocket_barrage", 0);

    level notify("do big barrage");
    level waittill("do aftermath");

    wait 15;
    level notify("rockets available anytime");

    level.rocket_barrage_first_barrage = false;
    self.is_firing_rocket_barrage = false;

    wait 0.1;

    while(self maps\_laststand::player_is_in_laststand()) {
      wait 0.1;
    }

    self giveweapon("rocket_barrage");
    self GiveMaxAmmo("rocket_barrage");
  }

  if(self attackbuttonPressed() && !self.is_firing_rocket_barrage && self.rocket_barrage_ok && !level.rocket_barrage_first_barrage && self.rocket_barrage_at_major_target) {
    self.is_firing_rocket_barrage = true;
    self thread rocket_barrage_switch_back();

    level thread rocket_barrage_radio_guy("confirm_bunker");

    self thread rocket_barrage_fire(fire_point);
  } else if(self attackbuttonPressed() && !self.is_firing_rocket_barrage && self.rocket_barrage_ok && !level.rocket_barrage_first_barrage) {
    self.is_firing_rocket_barrage = true;
    self thread rocket_barrage_switch_back();

    level thread rocket_barrage_radio_guy("fire_generic" + self.rocket_barrage_generic_fire_count);
    self.rocket_barrage_generic_fire_count++;

    if(self.rocket_barrage_generic_fire_count > 5) {
      self.rocket_barrage_generic_fire_count = 1;
    }

    self thread rocket_barrage_fire(fire_point);
  } else if(self attackbuttonPressed() && !self.rocket_barrage_ok && !level.rocket_barrage_first_barrage) {
    level thread rocket_barrage_radio_guy("cant_fire");
  } else if(self attackbuttonPressed() && self.is_firing_rocket_barrage && !level.rocket_barrage_first_barrage) {
    level thread rocket_barrage_radio_guy("charging" + self.rocket_barrage_recharging_count);
    self.rocket_barrage_recharging_count++;

    if(self.rocket_barrage_recharging_count > 2) {
      self.rocket_barrage_recharging_count = 0;
    }
  }
}

rocket_barrage_switch_back() {
  primaryWeapons = self GetWeaponsListPrimaries();

  if(isDefined(primaryWeapons)) {
    if(maps\_collectibles::has_collectible("collectible_sticksstones") || maps\_collectibles::has_collectible("collectible_berserker"))
      self SwitchToWeapon(primaryWeapons[0]);
  }

  self.rocket_targeting_on = false;
}

delete_confirm_arrow() {
  self endon("death");
  self endon("disconnect");

  wait(5);

  if(isDefined(self.rocket_barrage_confirm)) {
    self.rocket_barrage_confirm notify("end_confirm");
    self.rocket_barrage_confirm delete();
  }
}

play_confirm() {
  self endon("end_confirm");

  while(1) {
    playFXOnTag(level._effect["target_arrow_green"], self, "tag_origin");
    wait 0.1;
  }
}
rocket_barrage_fire(fire_point) {
  self endon("death");
  self endon("disconnect");

  self notify("rocket barrage firing");

  if(level.script == "pel1") {
    thread maps\pel1_amb::player_fired_rockets();
  }

  self thread populate_and_fire_lci_rockets(fire_point);

  self.rocket_barrage_confirm = spawn("script_model", fire_point);
  self.rocket_barrage_confirm setModel("tag_origin");
  self.rocket_barrage_confirm.angles = self.rocket_barrage_target.angles;

  self.rocket_barrage_confirm thread play_confirm();
  thread delete_confirm_arrow();

  self SetWeaponAmmoClip("rocket_barrage", 0);

  delete_spotting_target();

  self thread confirm_targets_hit();

  self thread monitor_charge_time(level.barrage_charge_time);
  wait(level.barrage_charge_time);

  self notify("rockets_recharged");

  while(self maps\_laststand::player_is_in_laststand()) {
    wait 0.1;
  }

  self giveweapon("rocket_barrage");
  self GiveMaxAmmo("rocket_barrage");

  self.rocket_barrage_fired_at_time = gettime();

  self.is_firing_rocket_barrage = false;

  level thread rocket_barrage_radio_guy("ready" + self.rocket_barrage_ready_count);

  self.rocket_barrage_ready_count++;
  if(self.rocket_barrage_ready_count > 8) {
    self.rocket_barrage_ready_count = 1;
  }
}

monitor_charge_time(time_to_wait) {
  players = get_players();
  if(players.size > 1) {
    return;
  }

  self endon("rockets_recharged");

  if(time_to_wait - 25 <= 0) {
    return;
  }

  wait(time_to_wait - 25);
  level thread rocket_barrage_radio_guy("counting25");

  wait(10);
  level thread rocket_barrage_radio_guy("counting15");

  wait(5);
  level thread rocket_barrage_radio_guy("counting10");

  wait(5);
  level thread rocket_barrage_radio_guy("counting5");
}

confirm_targets_hit() {
  self endon("rockets_recharged");

  wait 8;
  if(self.rocket_barrage_bunker_was_hit) {
    level thread rocket_barrage_radio_guy("hit_bunker");
  } else if(self.rocket_barrage_ai_was_hit || self.rocket_barrage_vehicle_was_hit) {
    level thread rocket_barrage_radio_guy("hit_ai" + self.rocket_barrage_hit_ai_count);
    self.rocket_barrage_hit_ai_count++;

    if(self.rocket_barrage_hit_ai_count > 3) {
      self.rocket_barrage_hit_ai_count = 1;
    }
  } else if(!self.rocket_barrage_ai_was_hit) {
    level thread rocket_barrage_radio_guy("missed");
  }

  self.rocket_barrage_ai_was_hit = false;
  self.rocket_barrage_bunker_was_hit = false;
  self.rocket_barrage_vehicle_was_hit = false;
}
delete_spotting_target() {
  self endon("death");
  self endon("disconnect");

  if(isDefined(self.rocket_barrage_target)) {
    self.rocket_barrage_target delete();
  }
  self notify("target smoke deleted");
}
rocket_barrage_hud_elements_think() {
  self endon("death");
  self endon("disconnect");

  x_placement = 100;
  y_placement = 425;

  barsize_x = 72;
  barsize_y = 10;
  bar_difference_x = 6;
  bar_difference_y = 4;

  self.rocket_hud_elem_background = newclienthudelem(self);
  self.rocket_hud_elem_background.x = x_placement;
  self.rocket_hud_elem_background.y = y_placement;
  self.rocket_hud_elem_background setshader("black", barsize_x, barsize_y);
  self.rocket_hud_elem_background.alignX = "left";
  self.rocket_hud_elem_background.alignY = "bottom";
  self.rocket_hud_elem_background.alpha = 1;
  self.rocket_hud_elem_background.foreground = true;
  self.rocket_hud_elem_background.sort = 1;

  self.rocket_hud_elem_foreground = newclienthudelem(self);
  self.rocket_hud_elem_foreground.x = x_placement + (bar_difference_x / 2);
  self.rocket_hud_elem_foreground.y = y_placement - (bar_difference_y / 2);
  self.rocket_hud_elem_foreground setshader("white", (barsize_x - bar_difference_x), (barsize_y - bar_difference_y));
  self.rocket_hud_elem_foreground.alignX = "left";
  self.rocket_hud_elem_foreground.alignY = "bottom";
  self.rocket_hud_elem_foreground.alpha = 1;
  self.rocket_hud_elem_foreground.foreground = true;
  self.rocket_hud_elem_foreground.sort = 2;

  thread rocket_barrage_hud_elements_show();

  while(1) {
    self waittill("rocket barrage firing");
    self.rocket_hud_elem_foreground ScaleOverTime(0.05, 1, (barsize_y - bar_difference_y));
    self.rocket_hud_elem_foreground.color = (1, 0, 0);
    wait(0.05);
    self.rocket_hud_elem_foreground ScaleOverTime(level.barrage_charge_time - 0.05, (barsize_x - bar_difference_x), (barsize_y - bar_difference_y));
    wait(level.barrage_charge_time / 3);
    self.rocket_hud_elem_foreground.color = (1, 0.5, 0);
    wait(level.barrage_charge_time / 3);
    self.rocket_hud_elem_foreground.color = (1, 1, 0);
    wait(level.barrage_charge_time / 3);
    self.rocket_hud_elem_foreground.color = (1, 1, 1);
  }
}
rocket_barrage_hud_elements_show() {
  self endon("death");
  self endon("disconnect");

  while(1) {
    self.rocket_hud_elem_background.alpha = 0;
    self.rocket_hud_elem_foreground.alpha = 0;
    self waittill_any("start rocket barrage targeting", "activate pressed during barage");
    self.rocket_hud_elem_background.alpha = 1;
    self.rocket_hud_elem_foreground.alpha = 1;
    self waittill_any("end rocket barrage targeting", "rocket barrage firing", "activate pressed during barage");
  }
}
rocket_barrage_radio_guy(anim_sound) {
  if(!isDefined(level.radioguy)) {
    return;
  }

  if(isDefined(level.radioguy.isplayingsound) && level.radioguy.isplayingsound) {
    return;
  }

  if(level.radioguy depthinwater() > 0) {
    return;
  }

  level.radioguy.animname = "radioguy";

  switch (anim_sound) {
    case "confirm_bunker":
      level.radioguy.isplayingsound = true;
      level.radioguy anim_single_solo(level.radioguy, "rb_bunker_confirmed");
      break;

    case "hit_bunker":
      level.radioguy.isplayingsound = true;
      level.radioguy anim_single_solo(level.radioguy, "rb_hit_bunker");
      break;

    case "missed":
      level.radioguy.isplayingsound = true;
      level.radioguy anim_single_solo(level.radioguy, "rb_miss1");
      break;

    case "fire_generic1":
      level.radioguy.isplayingsound = true;
      level.radioguy anim_single_solo(level.radioguy, "rb_fire_generic1");
      break;

    case "fire_generic2":
      level.radioguy.isplayingsound = true;
      level.radioguy anim_single_solo(level.radioguy, "rb_fire_generic2");
      break;

    case "fire_generic3":
      level.radioguy.isplayingsound = true;
      level.radioguy anim_single_solo(level.radioguy, "rb_fire_generic3");
      break;

    case "fire_generic4":
      level.radioguy.isplayingsound = true;
      level.radioguy anim_single_solo(level.radioguy, "rb_fire_generic4");
      break;

    case "fire_generic5":
      level.radioguy.isplayingsound = true;
      level.radioguy anim_single_solo(level.radioguy, "rb_fire_generic5");
      break;

    case "hit_ai1":
      level.radioguy.isplayingsound = true;
      level.radioguy anim_single_solo(level.radioguy, "rb_hit_enemy1");
      break;

    case "hit_ai2":
      level.radioguy.isplayingsound = true;
      level.radioguy anim_single_solo(level.radioguy, "rb_hit_enemy2");
      break;

    case "hit_ai3":
      level.radioguy.isplayingsound = true;
      level.radioguy anim_single_solo(level.radioguy, "rb_hit_enemy3");
      break;

    case "charging1":
      level.radioguy.isplayingsound = true;
      level.radioguy anim_single_solo(level.radioguy, "rb_charging1");
      break;

    case "charging2":
      level.radioguy.isplayingsound = true;
      level.radioguy anim_single_solo(level.radioguy, "rb_charging2");
      break;

    case "counting":
      level.radioguy.isplayingsound = true;
      level.radioguy anim_single_solo(level.radioguy, "rb_counting");
      break;

    case "counting55":
      level.radioguy.isplayingsound = true;
      level.radioguy anim_single_solo(level.radioguy, "rb_counting_55");
      break;

    case "counting45":
      level.radioguy.isplayingsound = true;
      level.radioguy anim_single_solo(level.radioguy, "rb_counting_45");
      break;

    case "counting40":
      level.radioguy.isplayingsound = true;
      level.radioguy anim_single_solo(level.radioguy, "rb_counting_40");
      break;

    case "counting35":
      level.radioguy.isplayingsound = true;
      level.radioguy anim_single_solo(level.radioguy, "rb_counting_35");
      break;

    case "counting30":
      level.radioguy.isplayingsound = true;
      level.radioguy anim_single_solo(level.radioguy, "rb_counting_30");
      break;

    case "counting25":
      level.radioguy.isplayingsound = true;
      level.radioguy anim_single_solo(level.radioguy, "rb_counting_25");
      break;

    case "counting20":
      level.radioguy.isplayingsound = true;
      level.radioguy anim_single_solo(level.radioguy, "rb_counting_20");
      break;

    case "counting15":
      level.radioguy.isplayingsound = true;
      level.radioguy anim_single_solo(level.radioguy, "rb_counting_15");
      break;

    case "counting10":
      level.radioguy.isplayingsound = true;
      level.radioguy anim_single_solo(level.radioguy, "rb_counting_10");
      break;

    case "counting5":
      level.radioguy.isplayingsound = true;
      level.radioguy anim_single_solo(level.radioguy, "rb_counting_5");
      break;

    case "ready1":
      level.radioguy.isplayingsound = true;
      level.radioguy anim_single_solo(level.radioguy, "rb_ready_1");
      break;

    case "ready2":
      level.radioguy.isplayingsound = true;
      level.radioguy anim_single_solo(level.radioguy, "rb_ready_2");
      break;

    case "ready3":
      level.radioguy.isplayingsound = true;
      level.radioguy anim_single_solo(level.radioguy, "rb_ready_3");
      break;

    case "ready4":
      level.radioguy.isplayingsound = true;
      level.radioguy anim_single_solo(level.radioguy, "rb_ready_4");
      break;

    case "ready5":
      level.radioguy.isplayingsound = true;
      level.radioguy anim_single_solo(level.radioguy, "rb_ready_5");
      break;

    case "ready6":
      level.radioguy.isplayingsound = true;
      level.radioguy anim_single_solo(level.radioguy, "rb_ready_6");
      break;

    case "ready7":
      level.radioguy.isplayingsound = true;
      level.radioguy anim_single_solo(level.radioguy, "rb_ready_7");
      break;

    case "ready8":
      level.radioguy.isplayingsound = true;
      level.radioguy anim_single_solo(level.radioguy, "rb_ready_8");
      break;

    case "cant_fire":
      level.radioguy.isplayingsound = true;
      level.radioguy anim_single_solo(level.radioguy, "rb_cant_fire_there");
      break;

    default:
      ASSERTMSG("No sound / anim specifified for radio guy.");
  }

  level.radioguy.isplayingsound = false;
}
populate_and_fire_lci_rockets(fire_point) {
  self endon("death");
  self endon("disconnect");

  num_rockets = 8;

  ship = level.rocket_barrage_firing_positions[randomint(level.rocket_barrage_firing_positions.size)];

  start_points = [];

  orgs = getstructarray(ship, "targetname");

  for(i = 0; i < num_rockets; i++) {
    start_points[i] = orgs[i].origin;
  }

  if(level.script == "pel1") {
    pa_fire = getent("pa_fire_right", "targetname");
    playsoundatposition("pa_fire", pa_fire.origin);

    wait(0.4);
    pa_fire_b = getent("pa_fire_left", "targetname");
    pa_fire_b playSound("pa_fire");
  }

  self thread lci_rocket_fire(fire_point, start_points, 1, self);
}
lci_player_rocket_fly_think(destination_pos, which_player) {
  thread throw_object_with_gravity(self, destination_pos);

  wait(0.5);

  while(1) {
    if(self.origin[2] <= destination_pos[2]) {
      damageradius = 300;

      playFX(level._effect["lci_rocket_impact"], self.origin);
      playsoundatposition("rocket_impact", self.origin);

      earthquake(0.5, 3, self.origin, 2050);

      thread rocket_rumble_on_all_players("damage_light", "damage_heavy", self.origin, 400, 800);

      self hide();
      rocket_barrage_check_if_bunker_hit(damageradius, self.origin, which_player);
      rocket_barrage_check_if_ai_hit(damageradius, self.origin, which_player);
      rocket_barrage_check_if_vehicle_hit(damageradius, self.origin, which_player);

      radiusdamage(self.origin + (0, 0, 16), damageradius, 500, 400, which_player, "MOD_CRUSH");

      radiusdamage(self.origin + (0, 0, 16), damageradius, 500, 400, which_player);
      radiusdamage(self.origin + (0, 0, 64), damageradius, 500, 400, which_player);
      radiusdamage(self.origin + (0, 0, 100), damageradius, 500, 400, which_player);
      break;
    }

    wait(0.05);
  }

  self notify("remove thrown object");

  wait(2);
  if(isDefined(self)) {
    self delete();
  }
}
rocket_barrage_check_if_ai_hit(damageradius, hitpoint, which_player) {
  ai = getaiarray("axis");

  killed_ai = 0;

  for(i = 0; i < ai.size; i++) {
    if(isDefined(ai[i])) {
      if(distance(hitpoint, ai[i].origin) <= damageradius) {
        if(isDefined(which_player)) {
          which_player.rocket_barrage_ai_was_hit = true;

          killed_ai++;
          thread arcademode_assignpoints("arcademode_score_enemyexitingcar", which_player);

          if(killed_ai == 4) {
            thread give_achivement_for_mass_kill(which_player);
          }

          if(isDefined(ai[i].banzai_is_waiting) && isDefined(ai[i].banzai_is_waiting)) {
            which_player giveachievement_wrapper("ANY_ACHIEVEMENT_GRASSJAP");
            println("gave grass guy achivement");
          }
        }
      }
    }
  }
}

rocket_barrage_check_if_vehicle_hit(damageradius, hitpoint, which_player) {
  vehicles = getEntArray("script_vehicle", "classname");

  hit_vehicles = 0;

  for(i = 0; i < vehicles.size; i++) {
    if(isDefined(vehicles[i])) {
      if(distance(hitpoint, vehicles[i].origin) <= damageradius) {
        if(vehicles[i].model == "vehicle_jap_tracked_type97shinhoto" || vehicles[i].model == "vehicle_jap_wheeled_type94") {
          if(isDefined(which_player)) {
            hit_vehicles++;
            which_player.rocket_barrage_vehicle_was_hit = true;
            thread arcademode_assignpoints("arcademode_score_tankassist", which_player);
          }
        }
      }
    }
  }
}
rocket_barrage_check_if_bunker_hit(damageradius, hitpoint, which_player) {
  targets = level.rocket_barrage_targets;

  for(i = 0; i < targets.size; i++) {
    if(isDefined(targets[i])) {
      if(distance(hitpoint, targets[i].origin) <= damageradius) {
        if(isDefined(which_player)) {
          which_player.rocket_barrage_bunker_was_hit = true;
        }
      }
    }
  }
}

give_achivement_for_mass_kill(which_player) {
  which_player giveachievement_wrapper("PEL1_ACHIEVEMENT_MASS");
}
throw_object_with_gravity(object, target_pos, velocity_strength) {
  if(!isDefined(velocity_strength)) {
    velocity_strength = 2000;
  }

  start_pos = object.origin;

  gravity = GetDvarInt("g_gravity") * -1;

  dist = Distance(start_pos, target_pos);
  time = dist / velocity_strength;

  delta = target_pos - start_pos;

  drop = 0.5 * gravity * (time * time);

  velocity = ((delta[0] / time), (delta[1] / time), (delta[2] - drop) / time);

  object MoveGravity(velocity, time);

  object rotatepitch(100, time);

  object waittill("movedone");
  object.origin = target_pos;

  wait 2;
  if(isDefined(object)) {
    object delete();
  }
}
lci_rocket_fire(dest_point, start_points, is_player_controlled, which_player) {
  thread play_sound_in_space("rocket_launch", start_points[0]);

  for(i = 0; i < start_points.size; i++) {
    rocket = spawn("script_model", start_points[i]);
    rocket setModel("peleliu_aerial_rocket");
    yaw_vec = vectortoangles(dest_point - rocket.origin);

    rocket.angles = (315, yaw_vec[1], 0);

    playFX(level._effect["rocket_launch"], rocket.origin, anglesToForward(rocket.angles + (20, 0, 0)));
    playFXOnTag(level._effect["rocket_trail"], rocket, "tag_origin");

    if(level.script == "pel1") {
      level thread maps\pel1_amb::play_rocket_sound(rocket);
    }

    rocket thread lci_player_rocket_fly_think((dest_point[0] - 150 + randomint(300), dest_point[1] - 150 + randomint(300), dest_point[2] - (32)), which_player);
    wait(randomfloatrange(0.2, 0.4));
  }
}

rocket_rumble_on_all_players(high_rumble_string, low_rumble_string, rumble_org, high_rumble_range, low_rumble_range) {
  players = get_players();

  for(i = 0; i < players.size; i++) {
    if(isDefined(high_rumble_range) && isDefined(low_rumble_range) && isDefined(rumble_org)) {
      if(distance(players[i].origin, rumble_org) < high_rumble_range) {
        players[i] playrumbleonentity(high_rumble_string);
      } else if(distance(players[i].origin, rumble_org) < low_rumble_range) {
        players[i] playrumbleonentity(low_rumble_string);
      }
    } else {
      players[i] playrumbleonentity(high_rumble_string);
    }
  }
}