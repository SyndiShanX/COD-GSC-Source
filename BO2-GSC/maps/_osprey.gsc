/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_osprey.gsc
**************************************/

#include maps\_vehicle;
#include common_scripts\utility;

main() {
  self.script_badplace = 0;
  init_fastrope();
  build_aianims(::setanims, ::set_vehicle_anims);
  build_attach_models(::set_attached_models);
  build_unload_groups(::unload_groups);
  self.vehicle_numdrivers = 2;

  if(!self has_spawnflag(2)) {
    if(isDefined(self.script_doorstate) && self.script_doorstate == 0) {
      self thread close_hatch();
      self raise_gear();
    }

    if(self.vehicletype == "heli_v78_rts" || self.vehicletype == "heli_osprey_rts_axis" || self.vehicletype == "heli_osprey_rts" || self.vehicletype == "heli_osprey")
      self raise_gear();
    else if(self.vehicletype == "heli_v78_yemen" || self.vehicletype == "heli_v78_low") {
      self thread close_hatch();
      self raise_gear();
    }

    self thread waittill_unloaded();
  }
}

#using_animtree("vehicles");

set_vehicle_anims(positions) {
  positions[2].vehicle_getoutanim = % v_vtol_hover_idle;
  positions[2].vehicle_getoutanim_clear = 0;
  positions[3].vehicle_getoutanim = % v_vtol_doors_open;
  positions[3].vehicle_getoutanim_clear = 0;
  positions[2].vehicle_getoutsound = "osprey_door_open";
  positions[2].vehicle_getinsound = "osprey_door_close";
  positions[1].delay = getanimlength( % v_vtol_doors_open) - 1.7;
  positions[2].delay = getanimlength( % v_vtol_doors_open) - 1.7;
  positions[3].delay = getanimlength( % v_vtol_doors_open) - 1.7;
  positions[4].delay = getanimlength( % v_vtol_doors_open) - 1.7;
  anim_for_client_script = % veh_anim_v78_vtol_engine_left;
  anim_for_client_script = % veh_anim_v78_vtol_engine_right;
  return positions;
}

init_fastrope() {
  self.fastropeoffset = 833;
}

#using_animtree("generic_human");

setanims() {
  positions = [];
  num_positions = issubstr(self.vehicletype, "heli_v78") ? 7 : 6;

  for(i = 0; i < num_positions; i++)
    positions[i] = spawnstruct();

  positions[0].bhasgunwhileriding = 0;
  positions[1].bhasgunwhileriding = 0;
  positions[0].idle[0] = % ai_crew_vtol_pilot1_idle;
  positions[0].idle[1] = % ai_crew_vtol_pilot1_idle_twitch_clickpanel;
  positions[0].idle[2] = % ai_crew_vtol_pilot1_idle_twitch_lookback;
  positions[0].idle[3] = % ai_crew_vtol_pilot1_idle_twitch_lookoutside;
  positions[0].idleoccurrence[0] = 500;
  positions[0].idleoccurrence[1] = 100;
  positions[0].idleoccurrence[2] = 100;
  positions[0].idleoccurrence[3] = 100;
  positions[1].idle[0] = % ai_crew_vtol_pilot2_idle;
  positions[1].idle[1] = % ai_crew_vtol_pilot2_idle_twitch_clickpanel;
  positions[1].idle[2] = % ai_crew_vtol_pilot2_idle_twitch_lookoutside;
  positions[1].idleoccurrence[0] = 450;
  positions[1].idleoccurrence[1] = 100;
  positions[1].idleoccurrence[2] = 100;
  positions[0].sittag = "tag_driver";
  positions[1].sittag = "tag_passenger";
  positions[2].sittag = "tag_detach";
  positions[3].sittag = "tag_detach";
  positions[4].sittag = "tag_detach";
  positions[5].sittag = "tag_detach";
  positions[2].idle = % ai_crew_vtol_1_idle;
  positions[3].idle = % ai_crew_vtol_2_idle;
  positions[4].idle = % ai_crew_vtol_3_idle;
  positions[5].idle = % ai_crew_vtol_4_idle;
  positions[2].getout = % ai_crew_vtol_1_drop;
  positions[3].getout = % ai_crew_vtol_2_drop;
  positions[4].getout = % ai_crew_vtol_3_drop;
  positions[5].getout = % ai_crew_vtol_4_drop;
  positions[2].getoutstance = "crouch";
  positions[3].getoutstance = "crouch";
  positions[4].getoutstance = "crouch";
  positions[5].getoutstance = "crouch";
  positions[2].ragdoll_getout_death = 1;
  positions[3].ragdoll_getout_death = 1;
  positions[4].ragdoll_getout_death = 1;
  positions[5].ragdoll_getout_death = 1;
  positions[2].getoutrig = "rope_test_ri";
  positions[3].getoutrig = "rope_test_ri";
  positions[4].getoutrig = "rope_test_ri";
  positions[5].getoutrig = "rope_test_ri";

  if(num_positions == 7) {
    positions[6].sittag = "tag_gunner1";
    positions[6].vehiclegunner = 1;
    positions[6].idle = % ai_50cal_gunner_aim;
    positions[6].aimup = % ai_50cal_gunner_aim_up;
    positions[6].aimdown = % ai_50cal_gunner_aim_down;
  }

  return positions;
}

unload_groups() {
  unload_groups = [];
  unload_groups["back"] = [];
  unload_groups["front"] = [];
  unload_groups["both"] = [];
  unload_groups["back"][unload_groups["back"].size] = 2;
  unload_groups["back"][unload_groups["back"].size] = 3;
  unload_groups["back"][unload_groups["back"].size] = 4;
  unload_groups["back"][unload_groups["back"].size] = 5;
  unload_groups["both"][unload_groups["both"].size] = 2;
  unload_groups["both"][unload_groups["both"].size] = 3;
  unload_groups["both"][unload_groups["both"].size] = 4;
  unload_groups["both"][unload_groups["both"].size] = 5;
  unload_groups["default"] = unload_groups["both"];
  return unload_groups;
}

set_attached_models() {
  array = [];
  array["rope_test_ri"] = spawnstruct();
  array["rope_test_ri"].model = "rope_test_ri";
  array["rope_test_ri"].tag = "TAG_FastRope_RI";
  array["rope_test_ri"].idleanim = % o_vtol_rope_idle_ri;
  array["rope_test_ri"].dropanim = % o_vtol_rope_drop_ri;
  return array;
}

precache_extra_models() {
  precachemodel("rope_test_ri");
}

#using_animtree("vehicles");

open_hatch() {
  self setanim( % v_vtol_doors_open, 1, 0.1, 1);
}

close_hatch(close_time) {
  if(!isDefined(close_time))
    close_time = undefined;

  self endon("death");

  if(!isDefined(close_time)) {
    self setanim( % v_vtol_doors_open, 1, 0.1, 0);
    self setanimtime( % v_vtol_doors_open, 0);
  } else {
    max_close_time = close_time;

    while(close_time > 0) {
      t = close_time / max_close_time;
      self setanimtime( % v_vtol_doors_open, t);
      close_time = close_time - 0.05;
      wait 0.05;
    }

    self setanimtime( % v_vtol_doors_open, 0);
    self setanim( % v_vtol_doors_open, 1, 0.1, 0);
  }
}

raise_gear() {
  self setanim( % v_vtol_gear_up, 1, 0.1, 1);
}

lower_gear() {
  self setanim( % v_vtol_gear_down, 1, 0.1, 1);
}

waittill_unloaded() {
  self endon("death");
  self waittill("unloaded");
  self clearanim( % v_vtol_hover_idle, 0.1);
  self thread close_hatch(1);
}