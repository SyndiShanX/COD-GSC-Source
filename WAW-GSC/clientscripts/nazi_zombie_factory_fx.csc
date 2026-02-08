/****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\nazi_zombie_factory_fx.csc
****************************************************/

#include clientscripts\_utility;
#include clientscripts\_fx;
#include clientscripts\_music;

main() {
  clientscripts\createfx\nazi_zombie_factory_fx::main();
  clientscripts\_fx::reportNumEffects();

  footsteps();
  precache_scripted_fx();
  precache_createfx_fx();

  level thread trap_fx_monitor("warehouse_trap", "warehouse");
  level thread trap_fx_monitor("wuen_trap", "wuen");
  level thread trap_fx_monitor("bridge_trap", "bridge");

  disableFX = GetDvarInt("disable_fx");
  if(!isDefined(disableFX) || disableFX <= 0) {
    precache_scripted_fx();
  }

  level thread perk_wire_fx("pw0", "pad_0_wire", "t01");
  level thread perk_wire_fx("pw1", "pad_1_wire", "t11");
  level thread perk_wire_fx("pw2", "pad_2_wire", "t21");

  level thread teleporter_map_light("sm_light_tp_0", "t01");
  level thread teleporter_map_light("sm_light_tp_1", "t11");
  level thread teleporter_map_light("sm_light_tp_2", "t21");
  level.map_light_receiver_on = false;
  level thread teleporter_map_light_receiver();

  level thread dog_start_monitor();
  level thread dog_stop_monitor();

  level thread light_model_swap("smodel_light_electric", "lights_indlight_on");
  level thread light_model_swap("smodel_light_electric_milit", "lights_milit_lamp_single_int_on");
  level thread light_model_swap("smodel_light_electric_tinhatlamp", "lights_tinhatlamp_on");

  level thread flytrap_lev_objects();

  level thread clientscripts\_zombie_mode::init_perk_machines();
}

trap_fx_monitor(name, side) {
  while(1) {
    level waittill(name);

    fire_points = getstructarray(name, "targetname");

    for(i = 0; i < fire_points.size; i++) {
      fire_points[i] thread electric_trap_fx(name, side);
    }
  }

}

electric_trap_fx(name, side) {
  ang = self.angles;
  forward = anglesToForward(ang);
  up = anglestoup(ang);

  if(isDefined(self.loopFX)) {
    for(i = 0; i < self.loopFX.size; i++) {
      self.loopFX[i] delete();
    }

    self.loopFX = [];
  }

  if(!isDefined(self.loopFX)) {
    self.loopFX = [];
  }

  players = getlocalplayers();

  for(i = 0; i < players.size; i++) {
    self.loopFX[i] = SpawnFx(i, level._effect["zapper"], self.origin, 0, forward, up);
    triggerfx(self.loopFX[i]);
  }

  level waittill(side + "off");

  for(i = 0; i < self.loopFX.size; i++) {
    self.loopFX[i] delete();
  }

  self.loopFX = [];
}

footsteps() {
  clientscripts\_utility::setFootstepEffect("asphalt", LoadFx("bio/player/fx_footstep_dust"));
  clientscripts\_utility::setFootstepEffect("brick", LoadFx("bio/player/fx_footstep_dust"));
  clientscripts\_utility::setFootstepEffect("carpet", LoadFx("bio/player/fx_footstep_dust"));
  clientscripts\_utility::setFootstepEffect("cloth", LoadFx("bio/player/fx_footstep_dust"));
  clientscripts\_utility::setFootstepEffect("concrete", LoadFx("bio/player/fx_footstep_dust"));
  clientscripts\_utility::setFootstepEffect("dirt", LoadFx("bio/player/fx_footstep_sand"));
  clientscripts\_utility::setFootstepEffect("foliage", LoadFx("bio/player/fx_footstep_dust"));
  clientscripts\_utility::setFootstepEffect("gravel", LoadFx("bio/player/fx_footstep_sand"));
  clientscripts\_utility::setFootstepEffect("grass", LoadFx("bio/player/fx_footstep_sand"));
  clientscripts\_utility::setFootstepEffect("metal", LoadFx("bio/player/fx_footstep_dust"));
  clientscripts\_utility::setFootstepEffect("mud", LoadFx("bio/player/fx_footstep_mud"));
  clientscripts\_utility::setFootstepEffect("paper", LoadFx("bio/player/fx_footstep_dust"));
  clientscripts\_utility::setFootstepEffect("plaster", LoadFx("bio/player/fx_footstep_dust"));
  clientscripts\_utility::setFootstepEffect("rock", LoadFx("bio/player/fx_footstep_sand"));
  clientscripts\_utility::setFootstepEffect("sand", LoadFx("bio/player/fx_footstep_sand"));
  clientscripts\_utility::setFootstepEffect("water", LoadFx("bio/player/fx_footstep_water"));
  clientscripts\_utility::setFootstepEffect("wood", LoadFx("bio/player/fx_footstep_dust"));
}

precache_scripted_fx() {
  level._effect["zombie_grain"] = LoadFx("misc/fx_zombie_grain_cloud");
  level._effect["electric_short_oneshot"] = loadfx("env/electrical/fx_elec_short_oneshot");
  level._effect["switch_sparks"] = loadfx("env/electrical/fx_elec_wire_spark_burst");

  level._effect["zapper_fx"] = loadfx("misc/fx_zombie_zapper_powerbox_on");
  level._effect["zapper_wall"] = loadfx("misc/fx_zombie_zapper_wall_control_on");
  level._effect["elec_trail_one_shot"] = loadfx("misc/fx_zombie_elec_trail_oneshot");

  level._effect["zapper_light_ready"] = loadfx("maps/zombie/fx_zombie_light_glow_green");
  level._effect["zapper_light_notready"] = loadfx("maps/zombie/fx_zombie_light_glow_red");
  level._effect["wire_sparks_oneshot"] = loadfx("env/electrical/fx_elec_wire_spark_dl_oneshot");

  level._effect["wire_spark"] = loadfx("maps/zombie/fx_zombie_wire_spark");
  level._effect["eye_glow"] = LoadFx("misc/fx_zombie_eye_single");
  level._effect["powerup_on"] = loadfx("misc/fx_zombie_powerup_on");
}

precache_createfx_fx() {
  level._effect["mp_battlesmoke_lg"] = loadfx("maps/mp_maps/fx_mp_battlesmoke_thin_lg");
  level._effect["mp_fire_distant_150_150"] = loadfx("maps/mp_maps/fx_mp_fire_150x150_tall_distant");
  level._effect["mp_fire_distant_150_600"] = loadfx("maps/mp_maps/fx_mp_fire_150x600_tall_distant");
  level._effect["mp_fire_static_small_detail"] = loadfx("maps/mp_maps/fx_mp_fire_small_detail");
  level._effect["mp_fire_window_smk_rt"] = loadfx("maps/mp_maps/fx_mp_fire_window_smk_rt");
  level._effect["mp_fire_window_smk_lf"] = loadfx("maps/mp_maps/fx_mp_fire_window_smk_lf");
  level._effect["mp_fire_window"] = loadfx("maps/mp_maps/fx_mp_fire_window");
  level._effect["mp_fire_rubble_small"] = loadfx("maps/mp_maps/fx_mp_fire_rubble_small");
  level._effect["mp_fire_rubble_md_smk"] = loadfx("maps/mp_maps/fx_mp_fire_rubble_md_smk");
  level._effect["mp_fire_rubble_md_lowsmk"] = loadfx("maps/mp_maps/fx_mp_fire_rubble_md_lowsmk");
  level._effect["mp_fire_rubble_detail_grp"] = loadfx("maps/mp_maps/fx_mp_fire_rubble_detail_grp");
  level._effect["mp_ray_fire_thin"] = loadfx("maps/mp_maps/fx_mp_ray_fire_thin");
  level._effect["mp_ray_fire_ribbon"] = loadfx("maps/mp_maps/fx_mp_ray_fire_ribbon");
  level._effect["mp_fire_column_lg"] = loadfx("maps/mp_maps/fx_mp_fire_column_lg");
  level._effect["mp_fire_furnace"] = loadfx("maps/mp_maps/fx_mp_fire_furnace");

  level._effect["mp_ray_light_sm"] = loadfx("maps/mp_maps/fx_mp_ray_moon_sm");
  level._effect["mp_ray_light_md"] = loadfx("maps/mp_maps/fx_mp_ray_moon_md");
  level._effect["mp_ray_light_md"] = loadfx("maps/mp_maps/fx_mp_ray_moon_md");
  level._effect["mp_ray_light_lg"] = loadfx("maps/mp_maps/fx_mp_ray_moon_lg");
  level._effect["fx_mp_ray_fire_ribbon"] = loadfx("maps/mp_maps/fx_mp_ray_fire_ribbon");
  level._effect["fx_mp_ray_fire_ribbon_med"] = loadfx("maps/mp_maps/fx_mp_ray_fire_ribbon_med");
  level._effect["mp_ray_light_lg_1sd"] = loadfx("maps/mp_maps/fx_mp_ray_moon_lg_1sd");

  level._effect["mp_smoke_fire_column"] = loadfx("maps/mp_maps/fx_mp_smoke_fire_column");
  level._effect["mp_smoke_plume_lg"] = loadfx("maps/mp_maps/fx_mp_smoke_plume_lg");
  level._effect["mp_smoke_hall"] = loadfx("maps/mp_maps/fx_mp_smoke_hall");
  level._effect["mp_ash_and_embers"] = loadfx("maps/mp_maps/fx_mp_ash_falling_large");
  level._effect["mp_light_glow_indoor_short"] = loadfx("maps/mp_maps/fx_mp_light_glow_indoor_short_loop");
  level._effect["mp_light_glow_outdoor_long"] = loadfx("maps/mp_maps/fx_mp_light_glow_outdoor_long_loop");
  level._effect["mp_insects_lantern"] = loadfx("maps/mp_maps/fx_mp_insects_lantern");
  level._effect["fx_mp_fire_torch_noglow"] = loadfx("maps/mp_maps/fx_mp_fire_torch_noglow");

  level._effect["a_embers_falling_sm"] = loadfx("env/fire/fx_embers_falling_sm");

  level._effect["transporter_beam"] = loadfx("maps/zombie/fx_transporter_beam");
  level._effect["transporter_pad_start"] = loadfx("maps/zombie/fx_transporter_pad_start");
  level._effect["transporter_start"] = loadfx("maps/zombie/fx_transporter_start");
  level._effect["transporter_ambient"] = loadfx("maps/zombie/fx_transporter_ambient");
  level._effect["zombie_mainframe_link_all"] = loadfx("maps/zombie/fx_zombie_mainframe_link_all");
  level._effect["zombie_mainframe_link_single"] = loadfx("maps/zombie/fx_zombie_mainframe_link_single");
  level._effect["zombie_mainframe_linked"] = loadfx("maps/zombie/fx_zombie_mainframe_linked");
  level._effect["zombie_mainframe_beam"] = loadfx("maps/zombie/fx_zombie_mainframe_beam");
  level._effect["zombie_mainframe_flat"] = loadfx("maps/zombie/fx_zombie_mainframe_flat");
  level._effect["zombie_mainframe_flat_start"] = loadfx("maps/zombie/fx_zombie_mainframe_flat_start");
  level._effect["zombie_mainframe_beam_start"] = loadfx("maps/zombie/fx_zombie_mainframe_beam_start");
  level._effect["zombie_flashback_american"] = loadfx("maps/zombie/fx_zombie_flashback_american");
  level._effect["gasfire2"] = LoadFx("destructibles/fx_dest_fire_vert");
  level._effect["mp_light_lamp"] = Loadfx("maps/mp_maps/fx_mp_light_lamp");
  level._effect["zombie_difference"] = loadfx("maps/zombie/fx_zombie_difference");
  level._effect["zombie_mainframe_steam"] = loadfx("maps/zombie/fx_zombie_mainframe_steam");
  level._effect["zombie_heat_sink"] = loadfx("maps/zombie/fx_zombie_heat_sink");
  level._effect["mp_smoke_stack"] = loadfx("maps/mp_maps/fx_mp_smoke_stack");
  level._effect["mp_elec_spark_fast_random"] = loadfx("maps/mp_maps/fx_mp_elec_spark_fast_random");
  level._effect["zombie_elec_gen_idle"] = loadfx("misc/fx_zombie_elec_gen_idle");
  level._effect["zombie_moon_eclipse"] = loadfx("maps/zombie/fx_zombie_moon_eclipse");
  level._effect["zombie_clock_hand"] = loadfx("maps/zombie/fx_zombie_clock_hand");
  level._effect["zombie_elec_pole_terminal"] = loadfx("maps/zombie/fx_zombie_elec_pole_terminal");
  level._effect["mp_elec_broken_light_1shot"] = loadfx("maps/mp_maps/fx_mp_elec_broken_light_1shot");
  level._effect["mp_light_lamp_no_eo"] = loadfx("maps/mp_maps/fx_mp_light_lamp_no_eo");

  level._effect["zombie_packapunch"] = loadfx("maps/zombie/fx_zombie_packapunch");
  level._effect["zapper"] = loadfx("misc/fx_zombie_electric_trap");
}
perk_wire_fx(notify_wait, init_targetname, done_notify) {
  level waittill(notify_wait);

  players = getlocalplayers();
  for(i = 0; i < players.size; i++) {
    players[i] thread perk_wire_fx_client(i, init_targetname, done_notify);
  }
}
perk_wire_fx_client(clientnum, init_targetname, done_notify) {
  println("perk_wire_fx_client for client #" + clientnum);
  targ = getstruct(init_targetname, "targetname");
  if(!isDefined(targ)) {
    return;
  }

  mover = spawn(clientnum, targ.origin, "script_model");
  mover setModel("tag_origin");
  fx = playFXOnTag(clientnum, level._effect["wire_spark"], mover, "tag_origin");

  fake_ent = spawnfakeent(0);
  setfakeentorg(0, fake_ent, mover.origin);
  playSound(0, "tele_spark_hit", mover.origin);
  playLoopSound(0, fake_ent, "tele_spark_loop");
  mover thread tele_spark_audio_mover(fake_ent);

  while(isDefined(targ)) {
    if(isDefined(targ.target)) {
      println("perk_wire_fx_client#" + clientnum + " next target: " + targ.target);
      target = getstruct(targ.target, "targetname");

      mover MoveTo(target.origin, 0.1);
      wait(0.1);

      targ = target;
    } else {
      break;
    }
  }
  level notify("spark_done");
  mover Delete();
  deletefakeent(0, fake_ent);

  level notify(done_notify);
}

tele_spark_audio_mover(fake_ent) {
  level endon("spark_done");

  while(1) {
    realwait(0.05);
    setfakeentorg(0, fake_ent, self.origin);
  }
}
dog_start_monitor() {
  while(1) {
    level waittill("dog_start");

    SetVolFog(229.0, 200.0, 380.0, 200.0, 0.16, 0.204, 0.274, 7);
  }
}
dog_stop_monitor() {
  while(1) {
    level waittill("dog_stop");
    SetVolFog(404.39, 1543.52, 460.33, -244.014, 0.65, 0.84, 0.79, 6);
  }
}
light_model_swap(name, model) {
  level waittill("pl1");

  players = getlocalplayers();
  for(p = 0; p < players.size; p++) {
    lamps = getEntArray(p, name, "targetname");
    for(i = 0; i < lamps.size; i++) {
      lamps[i] setModel(model);
    }
  }
}
get_guide_struct_angles(ent) {
  guide_structs = GetStructArray("map_fx_guide_struct", "targetname");
  if(guide_structs.size > 0) {
    guide = guide_structs[0];
    dist = DistanceSquared(ent.origin, guide.origin);
    for(i = 1; i < guide_structs.size; i++) {
      new_dist = DistanceSquared(ent.origin, guide_structs[i].origin);
      if(new_dist < dist) {
        guide = guide_structs[i];
        dist = new_dist;
      }
    }

    return guide.angles;
  }

  return (0, 0, 0);
}
teleporter_map_light(light_name, on_msg) {
  level waittill("pl1");

  players = getlocalplayers();
  for(p = 0; p < players.size; p++) {
    lamps = getEntArray(p, light_name, "targetname");
    for(i = 0; i < lamps.size; i++) {
      lamps[i] setModel("zombie_zapper_cagelight_red");
      if(isDefined(lamps[i].fx)) {
        lamps[i].fx delete();
      }
      angles = lamps[i].angles;
      println(light_name + "- model angles : " + angles[0] + ", " + angles[1] + ", " + angles[2]);

      angles = get_guide_struct_angles(lamps[i]);
      lamps[i].fx = SpawnFx(p, level._effect["zapper_light_notready"], lamps[i].origin, 0, anglesToForward(angles));
      TriggerFX(lamps[i].fx);
    }
  }

  level waittill(on_msg);

  players = getlocalplayers();
  for(p = 0; p < players.size; p++) {
    lamps = getEntArray(p, light_name, "targetname");
    for(i = 0; i < lamps.size; i++) {
      lamps[i] setModel("zombie_zapper_cagelight_green");
      if(isDefined(lamps[i].fx)) {
        lamps[i].fx delete();
      }
      angles = get_guide_struct_angles(lamps[i]);
      lamps[i].fx = SpawnFx(p, level._effect["zapper_light_ready"], lamps[i].origin, 0, anglesToForward(angles));
      TriggerFX(lamps[i].fx);
    }
  }
}
teleporter_map_light_receiver() {
  level waittill("pl1");

  level thread teleporter_map_light_receiver_flash();

  players = getlocalplayers();
  for(p = 0; p < players.size; p++) {
    lamps = getEntArray(p, "sm_light_tp_r", "targetname");
    for(i = 0; i < lamps.size; i++) {
      lamps[i] setModel("zombie_zapper_cagelight_red");
      if(isDefined(lamps[i].fx)) {
        lamps[i].fx delete();
      }
      angles = get_guide_struct_angles(lamps[i]);
      lamps[i].fx = SpawnFx(p, level._effect["zapper_light_notready"], lamps[i].origin, 0, anglesToForward(angles));
      TriggerFX(lamps[i].fx);
    }
  }

  level waittill("pap1");
  wait(1.5);

  level.map_light_receiver_on = true;
  players = getlocalplayers();
  for(p = 0; p < players.size; p++) {
    lamps = getEntArray(p, "sm_light_tp_r", "targetname");
    for(i = 0; i < lamps.size; i++) {
      lamps[i] setModel("zombie_zapper_cagelight_green");
      if(isDefined(lamps[i].fx)) {
        lamps[i].fx delete();
      }
      angles = get_guide_struct_angles(lamps[i]);
      lamps[i].fx = SpawnFx(p, level._effect["zapper_light_ready"], lamps[i].origin, 0, anglesToForward(angles));
      TriggerFX(lamps[i].fx);
    }
  }
}
teleporter_map_light_receiver_flash() {
  level endon("pap1");
  level waittill("TRf");

  level endon("TRs");
  level thread teleporter_map_light_receiver_stop();

  while(1) {
    players = getlocalplayers();
    for(p = 0; p < players.size; p++) {
      lamps = getEntArray(p, "sm_light_tp_r", "targetname");
      for(i = 0; i < lamps.size; i++) {
        lamps[i] setModel("zombie_zapper_cagelight_red");
        if(isDefined(lamps[i].fx)) {
          lamps[i].fx delete();
        }
        angles = get_guide_struct_angles(lamps[i]);
        lamps[i].fx = SpawnFx(p, level._effect["zapper_light_notready"], lamps[i].origin, 0, anglesToForward(angles));
        TriggerFX(lamps[i].fx);
      }
    }
    wait(0.5);

    players = getlocalplayers();
    for(p = 0; p < players.size; p++) {
      lamps = getEntArray(p, "sm_light_tp_r", "targetname");
      for(i = 0; i < lamps.size; i++) {
        lamps[i] setModel("zombie_zapper_cagelight");
        if(isDefined(lamps[i].fx)) {
          lamps[i].fx delete();
        }
      }
    }
    wait(0.5);
  }
}
teleporter_map_light_receiver_stop() {
  level endon("pap1");

  level waittill("TRs");

  players = getlocalplayers();
  for(p = 0; p < players.size; p++) {
    lamps = getEntArray(p, "sm_light_tp_r", "targetname");
    for(i = 0; i < lamps.size; i++) {
      lamps[i] setModel("zombie_zapper_cagelight_red");
      if(isDefined(lamps[i].fx)) {
        lamps[i].fx delete();
      }
      angles = get_guide_struct_angles(lamps[i]);
      lamps[i].fx = SpawnFx(p, level._effect["zapper_light_notready"], lamps[i].origin, 0, anglesToForward(angles));
      TriggerFX(lamps[i].fx);
    }
  }

  level thread teleporter_map_light_receiver_flash();
}
flytrap_lev_objects() {
  level waittill("ag1");

  i = 0;
  hover_spots = [];
  hover_spots[i] = GetStruct("trap_ag_spot0", "targetname");
  while(isDefined(hover_spots[i].target)) {
    hover_spots[i + 1] = GetStruct(hover_spots[i].target, "targetname");
    i++;
  }

  players = getlocalplayers();
  for(p = 0; p < players.size; p++) {
    floaters = getEntArray(p, "ee_floaty_stuff", "targetname");
    for(k = 0; k < floaters.size; k++) {
      floaters[k] thread anti_grav_move(p, hover_spots, k);
    }
  }
}
anti_grav_move(clientnum, spots, start_index) {
  sound_ent = spawnfakeent(0);
  setfakeentorg(0, sound_ent, self.origin);
  playLoopSound(0, sound_ent, "flytrap_loop");
  self thread flytrap_audio_mover(sound_ent);

  playFXOnTag(clientnum, level._effect["powerup_on"], self, "tag_origin");
  playSound(0, "flytrap_spin", self.origin);
  self MoveTo(spots[start_index].origin, 4);
  wait(4);

  stop_spinning = false;
  index = start_index;
  interval = 0.4;
  z_increment = 0;
  offset = 0;
  while(!stop_spinning) {
    index++;
    if(index >= spots.size) {
      index = 0;
    }
    if(index == start_index) {
      interval = interval - 0.1;
      z_increment = 15;
    }
    if(interval <= 0.1 && index == 0) {
      stop_spinning = true;
    }
    offset = offset + z_increment;
    self MoveTo(spots[index].origin + (0, 0, offset), interval);
    wait(interval);
  }

  end_spot = GetStruct("trap_flyaway_spot", "targetname");
  self MoveTo(end_spot.origin + (RandomFloatRange(-100, 100), 0, 0), 5);
  playSound(0, "shoot_off", self.origin);
  wait(4.7);

  level notify("delete_sound_ent");
  deletefakeent(0, sound_ent);
  self delete();
}

flytrap_audio_mover(sound_ent) {
  level endon("delete_sound_ent");

  while(1) {
    realwait(0.05);
    setfakeentorg(0, sound_ent, self.origin);
  }
}