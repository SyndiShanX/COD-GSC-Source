/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\la_2_debug.gsc
**************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\la_utility;

main() {
  wait_for_first_player();
  wait 1;
}

monitor_potus_health() {
  while(true) {
    if(!isDefined(level.convoy.vh_potus) || level.convoy.vh_potus.armor <= 0)
      str_text = "DEAD";
    else {
      n_health = level.convoy.vh_potus.armor;
      n_health_max = level.convoy.vh_potus.armor_max;
      str_text = n_health + " / " + n_health_max;
    }

    self debug_hud_elem_set_text("President: " + str_text);
    wait 0.5;
  }
}

monitor_g20_1_health() {
  while(true) {
    if(!isDefined(level.convoy.vh_g20_1) || level.convoy.vh_g20_1.armor <= 0)
      str_text = "DEAD";
    else {
      n_health = level.convoy.vh_g20_1.armor;
      n_health_max = level.convoy.vh_g20_1.armor_max;
      str_text = n_health + " / " + n_health_max;
    }

    self debug_hud_elem_set_text("G20 1: " + str_text);
    wait 0.5;
  }
}

monitor_g20_2_health() {
  while(true) {
    if(!isDefined(level.convoy.vh_g20_2) || level.convoy.vh_g20_2.armor <= 0)
      str_text = "DEAD";
    else {
      n_health = level.convoy.vh_g20_2.armor;
      n_health_max = level.convoy.vh_g20_2.armor_max;
      str_text = n_health + " / " + n_health_max;
    }

    self debug_hud_elem_set_text("G20 2: " + str_text);
    wait 0.5;
  }
}

monitor_lead_vehicle() {
  while(true) {
    if(!isDefined(level.convoy.leader))
      str_text = "UNDEFINED";
    else
      str_text = level.convoy.leader.targetname;

    self debug_hud_elem_set_text("Leader: " + str_text);
    wait 0.5;
  }
}

monitor_f35_health() {
  flag_wait("player_flying");

  while(true) {
    if(!isDefined(level.f35) || level.f35.health <= 0)
      str_text = "DEAD";
    else {
      n_health = level.f35.health_regen.health;
      n_health_max = level.f35.health_regen.health_max;
      str_text = n_health + " / " + n_health_max;
    }

    self debug_hud_elem_set_text("F35: " + str_text);
    wait 0.5;
  }
}

monitor_vehicle_counts() {
  while(true) {
    b_can_show = isDefined(level.aerial_vehicles);

    if(b_can_show) {
      n_planes = getvehiclearray().size;
      n_allies = level.aerial_vehicles.allies.size;
      n_axis = level.aerial_vehicles.axis.size;
      n_circling = level.aerial_vehicles.circling.size;
      debug_hud_elem_set_text("Vehicle count: " + n_planes + ": " + n_allies + " ally, " + n_axis + " axis. " + n_circling + " circling");
    }

    wait 1;
  }
}

monitor_distance_to_convoy() {
  while(!isDefined(level.convoy.distance_to_convoy))
    wait 0.5;

  while(true) {
    debug_hud_elem_set_text("Distance to convoy: " + level.convoy.distance_to_convoy);
    wait 0.5;
  }
}

monitor_distance_to_failure() {
  while(!isDefined(level.convoy.distance_max))
    wait 0.5;

  while(true) {
    n_warning_distance = level.convoy.distance_warning;
    n_fail_distance = level.convoy.distance_max;
    debug_hud_elem_set_text("Warning distance: " + n_warning_distance + ". Failure distance: " + n_fail_distance);
    wait 0.5;
  }
}

monitor_ai_count() {
  while(true) {
    a_axis = getaiarray("axis");
    n_count = a_axis.size;
    debug_hud_elem_set_text("Enemy AI count: " + n_count);
    wait 1;
  }
}