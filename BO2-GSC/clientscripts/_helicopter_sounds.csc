/************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\_helicopter_sounds.csc
************************************************/

#include clientscripts\_utility;
#include clientscripts\_music;
#include clientscripts\_audio;
#include clientscripts\_helicopter_sounds;

init() {
  level.jet_stick_turn_rate = 0.5;
  level.jet_stick_down_rate = 0.3;
  level.jet_stick_up_rate = 0.3;
  level.jet_stick_pitch_turn_rate = 0.9;
  level.jet_stick_pitch_down_rate = 0.9;
  level.jet_stick_pitch_up_rate = 0.9;
  level.pitch_run_rate = 0.9;
  level._entityshutdowncbfunc = clientscripts\_helicopter_sounds::heli_linkto_sound_ents_delete;
  level.helisoundvalues = [];
  init_heli_sound_values("f35", "idle", 95, 0.3, 0.8, 95, 1, 1.05);
  init_heli_sound_values("f35", "forward", 95, 0.05, 0.1, 95, 1, 1);
  init_heli_sound_values("f35", "up", 95, 0.05, 0.1, 95, 1, 1.05);
  init_heli_sound_values("plane_x78", "steady", 40, 0.4, 1, 45, 0.9, 1.1);
  init_heli_sound_values("plane_x78", "down", 40, 0.3, 1, 45, 0.9, 1.1);
  init_heli_sound_values("plane_x78", "up", 40, 0.3, 1, 45, 0.9, 1.1);
  init_heli_sound_values("drone_firescout", "turbine", 95, 0.6, 1, 35, 0.9, 1.1);
  init_heli_sound_values("drone_firescout", "distant", 95, 0.6, 1, 40, 0.9, 1.1);
  init_heli_sound_values("drone_firescout", "close", 95, 0.6, 1, 40, 0.9, 1.1);
  init_heli_sound_values("f35_la2", "forward", 90, 0.7, 1, 90, 1, 1);
  init_heli_sound_values("f35_vtol", "steady", 400, 0.2, 1, 300, 1, 1.3);
  init_heli_sound_values("f35_vtol", "steady_low", 160, 0.4, 1, 650, 1, 1.15);
  init_heli_sound_values("f35_vtol", "steady_hum", 95, 0.6, 1, 400, 1, 1.1);
  init_heli_sound_values("f35_vtol", "turn", 300, 0.01, 1, 600, 1, 1.25);
  init_heli_sound_values("f35_vtol", "turn_rattle", 400, 0.01, 1, 500, 1, 1.05);
  init_heli_sound_values("f35_vtol", "up", 300, 0.01, 1, 600, 1, 1.25);
  init_heli_sound_values("f35_vtol", "up_rattle", 500, 0.01, 0.5, 500, 1, 1.05);
  init_heli_sound_values("f35_vtol", "down", 495, 0.01, 1, 685, 1, 1.4);
  init_heli_sound_values("f35_vtol", "afterburn", 800, 0.4, 1, 500, 1, 1.1);
  init_heli_sound_values("f35_vtol", "turn_whine", 895, 0.01, 1, 1, 1, 1.4);
  init_heli_sound_values("littlebird", "turbine", 25, 0.75, 0.8, 65, 1, 1);
  init_heli_sound_values("littlebird", "top_rotor", 15, 0.85, 1, 25, 0.95, 1);
  init_heli_sound_values("littlebird", "tail_rotor", 25, 0.95, 1, 35, 0.95, 1);
  init_heli_sound_values("huey", "cockpit", 65, 0.6, 0.8, 65, 1, 1.1);
  init_heli_sound_values("huey", "cockpit2", 45, 0.5, 1, 45, 0.95, 1.1);
  init_heli_sound_values("huey", "int_eng", 45, 0.5, 1, 45, 0.95, 1.1);
  init_heli_sound_values("huey", "int_eng2", 45, 0.5, 1, 45, 0.95, 1.1);
  init_heli_sound_values("huey", "int_eng3", 45, 0.5, 1, 45, 0.95, 1.1);
  init_heli_sound_values("huey", "ext_rotor", 45, 0.5, 1, 45, 0.95, 1.1);
  init_heli_sound_values("huey", "tail_rotor", 45, 0.5, 1, 45, 0.95, 1.1);
  init_heli_sound_values("huey", "tail_rotor", 45, 0.5, 1, 45, 0.95, 1.1);
  init_heli_sound_values("hind", "cockpit", 95, 0.6, 0.8, 95, 1, 1.1);
  init_heli_sound_values("hind", "cockpit2", 95, 0.5, 0.8, 95, 1, 1.2);
  init_heli_sound_values("hind", "int_eng", 65, 0.5, 0.8, 65, 1, 1.1);
  init_heli_sound_values("hind", "int_eng2", 65, 0.4, 0.9, 65, 1, 1.1);
  init_heli_sound_values("hind", "eng_dmg", 40, 0.3, 0.5, 65, 1, 1.1);
  init_heli_sound_values("hind", "ext_rotor", 70, 0.5, 1, 70, 0.95, 1.1);
  init_heli_sound_values("hip", "turbine", 25, 0.85, 1, 40, 0.95, 1.0);
  init_heli_sound_values("hip", "top_rotor", 25, 0.85, 1, 40, 0.95, 1);
  init_heli_sound_values("hip", "tail_rotor", 25, 0.85, 1, 40, 0.95, 1.1);
  init_heli_sound_values("hip", "hip_dist", 25, 0.85, 1, 40, 0.95, 1.0);
  init_heli_sound_values("heli_osprey", "steady", 15, 0.75, 1, 30, 0.9, 1.05);
  init_heli_sound_values("heli_osprey", "up", 15, 0.5, 1, 30, 0.9, 1);
  init_heli_sound_values("heli_osprey", "down", 15, 0.5, 1, 30, 0.95, 1.05);
  init_heli_sound_values("plane_v78_rts", "steady", 20, 0.75, 1, 30, 0.9, 1.05);
  init_heli_sound_values("plane_v78_rts", "down", 20, 0.6, 1, 30, 0.9, 1.05);
  init_heli_sound_values("plane_v78_rts", "up", 20, 0.6, 1, 30, 0.9, 1.05);
  init_heli_sound_values("plane_v78_rts", "int", 20, 0.8, 1, 35, 0.92, 1);
  init_heli_sound_values("plane_v78_rts", "side", 20, 0.65, 1, 30, 1, 1.08);
  init_heli_sound_values("heli_alouette", "turbine", 50, 0.85, 1, 50, 0.95, 1.1);
  init_heli_sound_values("heli_alouette", "top_rotor", 50, 0.85, 1, 50, 0.95, 1.05);
  init_heli_sound_values("heli_alouette", "tail_rotor", 50, 0.85, 1, 50, 0.95, 1.1);
  init_heli_sound_values("hind_enemy", "turbine", 45, 0.6, 0.8, 65, 1, 1.0);
  init_heli_sound_values("hind_enemy", "top_rotor", 15, 0.5, 1, 25, 0.95, 1.0);
  init_heli_sound_values("hind_enemy", "tail_rotor", 45, 0.5, 1, 45, 0.95, 1.0);
  init_heli_sound_values("hind_enemy", "distant", 45, 0.5, 1, 45, 0.95, 1.0);
  init_heli_sound_values("huey_toda", "turbine", 25, 0.75, 0.8, 65, 0.9, 1);
  init_heli_sound_values("huey_toda", "top_rotor", 15, 0.85, 1, 25, 0.95, 1);
  init_heli_sound_values("huey_toda", "tail_rotor", 25, 0.95, 1, 35, 0.95, 1);
  init_heli_sound_values("huey_toda", "distant", 25, 0.75, 0.8, 65, 0.9, 1);
  init_heli_sound_values("heli_chinook", "turbine", 15, 0.8, 1, 35, 0.95, 1.05);
  init_heli_sound_values("heli_chinook", "top_rotor", 15, 0.8, 1, 35, 0.95, 1.05);
  init_heli_sound_values("huey_player", "turbine", 65, 0.6, 0.8, 65, 1, 1.1);
  init_heli_sound_values("huey_player", "top_rotor", 45, 0.5, 1, 45, 0.95, 1.1);
  init_heli_sound_values("huey_player", "tail_rotor", 45, 0.5, 1, 45, 0.95, 1.0);
  init_heli_sound_values("huey_player", "wind_rt", 45, 0.5, 1, 45, 0.95, 1.0);
  init_heli_sound_values("huey_player", "wind_lft", 45, 0.5, 1, 45, 0.95, 1.0);
  init_heli_sound_values("heli_pavelow_la2", "turbine", 100, 0.95, 1, 100, 0.95, 1.0);
  init_heli_sound_values("qrdrone", "turbine_idle", 20, 0.8, 0.0, 16, 0.9, 1);
  init_heli_sound_values("qrdrone", "turbine_moving", 20, 0.0, 1, 20, 1, 1);
  init_heli_sound_values("qrdrone", "distant", 20, 1, 1, 20, 1, 1);
  init_heli_sound_values("qrdrone", "close", 20, 1, 1, 20, 1, 1);
  init_heli_sound_values("qrdrone_so", "turbine_idle", 20, 0.8, 0.0, 16, 0.9, 1);
  init_heli_sound_values("qrdrone_so", "turbine_moving", 20, 0.0, 0.8, 20, 0.9, 1);
  init_heli_sound_values("qrdrone_so", "turn", 5, 0, 1, 1, 1, 1);
  init_heli_sound_values("osprey", "turbine", 65, 0.7, 1, 65, 1, 1.1);
  init_heli_sound_values("osprey", "top_rotor", 35, 0.95, 1, 100, 1, 1.1);
  init_heli_sound_values("osprey", "tail_rotor", 35, 0.95, 1, 45, 1, 1.1);
  init_heli_sound_values("vtol", "turbine", 45, 0.6, 0.8, 65, 1, 1.0);
  init_heli_sound_values("vtol", "top_rotor", 15, 0.5, 1, 25, 0.95, 1.0);
  init_heli_sound_values("blackhawk", "turbine", 65, 0.6, 0.8, 65, 1, 1.1);
  init_heli_sound_values("blackhawk", "top_rotor", 45, 0.7, 1, 45, 0.95, 1.1);
  init_heli_sound_values("blackhawk", "tail_rotor", 65, 0.6, 1, 65, 1, 1.1);
  init_heli_sound_values("heli_future", "turbine", 50, 0.7, 1, 60, 0.9, 1.1);
  init_heli_sound_values("heli_future", "rotor", 35, 0.7, 1, 45, 0.9, 1.1);
  init_heli_sound_values("jetwing", "steady", 40, 0.7, 1, 50, 0.95, 1.05);
  thread stupiddelayfix();

  if(getdvar(#"_id_21D60E03") == "")
    setdvar("helisounds", "");

  level thread command_parser();
  level thread command_parserpitch();
}

stupiddelayfix() {
  wait 1;
  register_clientflag_callback("helicopter", 2, ::updatestatus);
}

updatestatus(localclientnum, flag, set, newent) {
  self.should_not_play_sounds = set;
}

init_heli_sound_values(heli_type, part_type, max_speed_vol, min_vol, max_vol, max_speed_pitch, min_pitch, max_pitch) {
  if(!isDefined(level.helisoundvalues[heli_type]))
    level.helisoundvalues[heli_type] = [];

  if(!isDefined(level.helisoundvalues[heli_type][part_type]))
    level.helisoundvalues[heli_type][part_type] = spawnstruct();

  level.helisoundvalues[heli_type][part_type].speedvolumemax = max_speed_vol;
  level.helisoundvalues[heli_type][part_type].speedpitchmax = max_speed_pitch;
  level.helisoundvalues[heli_type][part_type].volumemin = min_vol;
  level.helisoundvalues[heli_type][part_type].volumemax = max_vol;
  level.helisoundvalues[heli_type][part_type].pitchmin = min_pitch;
  level.helisoundvalues[heli_type][part_type].pitchmax = max_pitch;

  if(getdvarint(#"_id_55AD9BED") > 0) {
    println("Init Heli Sounds heli_type: " + heli_type);
    println("Init Heli Sounds part_type: " + part_type);
    println("Init Heli Sounds max_speed_vol: " + max_speed_vol);
    println("Init Heli Sounds min_vol: " + min_vol);
    println("Init Heli Sounds max_vol: " + max_vol);
    println("Init Heli Sounds max_speed_pitch: " + max_speed_pitch);
    println("Init Heli Sounds min_pitch: " + min_pitch);
    println("Init Heli Sounds max_pitch: " + max_pitch);
  }

}

command_parser() {
  while(true) {
    command = getdvar(#"_id_21D60E03");

    if(command != "") {
      success = 1;
      tokens = strtok(command, " ");

      if(!isDefined(tokens[0]) || !isDefined(level.helisoundvalues[tokens[0]])) {
        if(isDefined(tokens[0]))
          println("helisounds Did not recognize helicopter type:" + tokens[0]);
        else
          println("helisounds Did not recognize helicopter type");

        println("helisounds usage: helisounds <heli name> <part name> <value name> <value>");
        success = 0;
      } else if(!isDefined(tokens[1])) {
        if(isDefined(tokens[1]))
          println("helisounds Did not recognize helicopter part:" + tokens[0] + " for heli: " + tokens[1]);
        else
          println("helisounds Did not recognize helicopter part for heli: " + tokens[0]);

        println("helisounds usage: helisounds <heli name> <part name> <value name> <value>");
        success = 0;
      } else if(!isDefined(tokens[2])) {
        println("helisounds Did not recognize helicopter value name for heli:" + tokens[0] + " part: " + tokens[1]);
        println("helisounds usage: helisounds <heli name> <part name> <value name> <value>");
        success = 0;
      } else if(!isDefined(tokens[3])) {
        println("helisounds Did not recognize helicopter value for heli:" + tokens[0] + " part: " + tokens[1]);
        println("helisounds usage: helisounds <heli name> <part name> <value name> <value>");
        success = 0;
      }

      if(success) {
        heli_type = tokens[0];
        heli_part = tokens[1];
        value_name = tokens[2];
        value = float(tokens[3]);

        switch (value_name) {
          case "volumemin":
            level.helisoundvalues[heli_type][heli_part].volumemin = value;
            println("Setting volumeMin to " + value);
            break;
          case "volumemax":
            level.helisoundvalues[heli_type][heli_part].volumemax = value;
            println("Setting volumeMax to " + value);
            break;
          case "pitchmin":
            level.helisoundvalues[heli_type][heli_part].pitchmin = value;
            println("Setting pitchMin to " + value);
            break;
          case "pitchmax":
            level.helisoundvalues[heli_type][heli_part].pitchmax = value;
            println("Setting pitchMax to " + value);
            break;
          case "speedvolumemax":
            level.helisoundvalues[heli_type][heli_part].speedvolumemax = value;
            println("Setting speedVolumeMax to " + value);
            break;
          case "speedpitchmax":
            level.helisoundvalues[heli_type][heli_part].speedpitchmax = value;
            println("Setting speedPitchMax to " + value);
            break;
          default:
            println("no case match - helisounds usage: helisounds <heli name> <part name> <value name> <value>");
        }
      }

      setdvar("helisounds", "");
    }

    wait 0.1;
  }

}

command_parserpitch() {
  while(true) {
    command = getdvar(#"_id_595BC324");

    if(command != "") {
      tokens = strtok(command, " ");
      value_name = tokens[0];
      value = float(tokens[1]);

      switch (value_name) {
        case "turnrate":
          level.jet_stick_pitch_turn_rate = value;
          println("Setting volumeMin to " + value);
          break;
        case "downrate":
          level.jet_stick_pitch_down_rate = value;
          println("Setting volumeMax to " + value);
          break;
        case "uprate":
          level.jet_stick_pitch_up_rate = value;
          println("Setting pitchMin to " + value);
          break;
        case "runrate":
          level.pitch_run_rate = value;
          println("Setting runrate to " + value);
          break;
        default:
          println("no case match - helisounds usage: helisounds <heli name> <part name> <value name> <value>");
      }

      setdvar("jetsounds", "");
    }

    wait 0.1;
  }

}

init_heli_sounds_f35_vtol() {
  self endon("heli_entityshutdown");
  wait 0.1;
  self setup_heli_sounds("steady", "engine", "tag_engine", "veh_f35_steady");
  self setup_heli_sounds("turn", "engine", "tag_engine", "veh_f35_turn");
  self setup_heli_sounds("up", "engine", "tag_engine", "veh_f35_up");
  self setup_heli_sounds("down", "engine", "tag_engine", "veh_f35_down");
  self setup_heli_sounds("afterburn", "engine", "tag_engine", "veh_f35_afterburn");
  self setup_heli_sounds("turn_whine", "engine", "tag_engine", "veh_f35_turn_whine");
  self setup_heli_sounds("steady_low", "engine", "tag_engine", "veh_f35_steady_low");
  self setup_heli_sounds("steady_hum", "engine", "tag_engine", "veh_f35_hum");
  self setup_heli_sounds("turn_rattle", "engine", "tag_engine", "veh_f35_rattle_turn");
  self setup_heli_sounds("up_rattle", "engine", "tag_engine", "veh_f35_rattle_up");
  self setup_heli_sounds("telemetry", "engine", "tag_engine", "veh_f35_telemetry");

  if(!isDefined(level.is_in_jet)) {
    level waittill("start_f35_snap");
    level.is_in_jet = 1;
    wait 12;
  }

  self thread play_f35_vtol_sounds();
}

init_heli_sounds_firescout() {
  self setup_heli_sounds("turbine", "engine", "tag_origin", "veh_fire_scout_run");
  self setup_heli_sounds("distant", "engine", "tag_origin", "veh_fire_scout_run_dist");
  self setup_heli_sounds("close", "engine", "tag_origin", "veh_fire_scout_run_close");
}

init_heli_sounds_plane_x78() {
  self setup_heli_sounds("steady", "engine", "tag_body", "veh_osp_steady");
  self setup_heli_sounds("up", "engine", "tag_body", "veh_osp_up");
  self setup_heli_sounds("down", "engine", "tag_body", "veh_osp_down");
}

init_heli_sounds_heli_osprey() {
  self setup_heli_sounds("steady", "engine", "tag_origin", "veh_heli_osp_steady");
  self setup_heli_sounds("up", "engine", "tag_origin", "veh_heli_osp_up");
  self setup_heli_sounds("down", "engine", "tag_origin", "veh_heli_osp_down");
  self setup_heli_sounds("lfe", "engine", "tag_origin", "veh_heli_osp_lfe");
}

init_heli_sounds_heli_osprey_rts() {
  self setup_heli_sounds("steady", "engine", "tag_body", "veh_heli_osp_steady");
  self setup_heli_sounds("up", "engine", "tag_body", "veh_heli_osp_up");
  self setup_heli_sounds("down", "engine", "tag_body", "veh_heli_osp_down");
  self setup_heli_sounds("int", "engine", "tag_gunner_mount1", "veh_heli_osp_interior");
  self setup_heli_sounds("side", "engine", "tag_fx_engine_left1", "veh_heli_osp_side_engine");
  self setup_heli_sounds("lfe", "engine", "tag_body", "veh_heli_osp_lfe");
}

init_heli_sounds_f35_la2() {
  self setup_heli_sounds("forward", "engine", "tag_engine", "veh_f35_la2_engine");
}

init_heli_sounds_f35() {
  self setup_heli_sounds("idle", "engine", "tag_engine", "blk_f35_low_loop");
  self setup_heli_sounds("forward", "engine", "tag_engine", "blk_f35_low_loop");
  self setup_heli_sounds("up", "engine", "tag_engine", "blk_f35_high_loop");
  self setup_heli_sounds("lateral", "engine", "tag_engine", "blk_f35_lateral_loop");
}

init_heli_sounds_huey_toda() {
  self setup_heli_sounds("turbine", "engine", "snd_rotor", "veh_hind_turbine");
  self setup_heli_sounds("top_rotor", "engine", "snd_rotor", "veh_hind_rotor");
  self setup_heli_sounds("tail_rotor", "engine", "snd_tail_rotor", "veh_hind_tail");
  self setup_heli_sounds("lfe", "engine", "snd_rotor", "veh_hind_rotor_lfe");
  self setup_heli_sounds("distant", "engine", "snd_rotor", "veh_hind_run_dist");
}

init_heli_sounds_littlebird() {
  self setup_heli_sounds("turbine", "engine", "TAG_BODY", "veh_hind_turbine");
  self setup_heli_sounds("top_rotor", "engine", "main_rotor_jnt", "veh_hind_rotor");
  self setup_heli_sounds("tail_rotor", "engine", "tail_rotor_jnt", "veh_hind_tail");
  self setup_heli_sounds("lfe", "engine", "tag_main_rotor", "veh_hind_rotor_lfe");
  self setup_heli_sounds("distant", "engine", "tag_origin", "veh_hind_run_dist");
}

init_heli_sounds_apache() {
  self setup_heli_sounds("turbine", "engine", "snd_rotor", "veh_hind_turbine");
  self setup_heli_sounds("top_rotor", "engine", "snd_rotor", "veh_hind_rotor");
  self setup_heli_sounds("tail_rotor", "engine", "snd_tail_rotor", "veh_hind_tail");
  self setup_heli_sounds("lfe", "engine", "snd_rotor", "veh_hind_rotor_lfe");
  self setup_heli_sounds("distant", "engine", "tag_origin", "veh_hind_run_dist");
}

init_heli_sounds_alouette() {
  self setup_heli_sounds("turbine", "engine", "snd_rotor", "veh_alouette_turbine");
  self setup_heli_sounds("top_rotor", "engine", "snd_rotor", "veh_alouette_rotor");
  self setup_heli_sounds("tail_rotor", "engine", "snd_tail_rotor", "veh_alouette_tail");
  self setup_heli_sounds("lfe", "engine", "snd_rotor", "veh_alouette_lfe");
}

init_heli_sounds_huey() {
  self setup_heli_sounds("cockpit", "engine", "snd_cockpit", "veh_huey_whine_int_idle");
  self setup_heli_sounds("cockpit2", "engine", "snd_rotor", "veh_huey_hf_int_idle");
  self setup_heli_sounds("int_eng", "engine", "snd_rotor", "veh_huey_lf_int_idle");
  self setup_heli_sounds("int_eng2", "engine", "snd_tail_rotor", "veh_huey_dist_idle");
  self setup_heli_sounds("int_eng3", "engine", "snd_wind_right", "veh_huey_ringing_dist");
  self setup_heli_sounds("ext_rotor", "engine", "snd_wind_left", "veh_huey_rotor_idle");
}

init_heli_sounds_hind() {
  self setup_heli_sounds("cockpit", "engine", "snd_cockpit", "veh_hind_whine_int_idle");
  self setup_heli_sounds("cockpit2", "engine", "snd_cockpit", "veh_hind_hf_int_idle");
  self setup_heli_sounds("int_eng", "engine", "snd_int_rotor", "veh_hind_lf_int_idle");
  self setup_heli_sounds("int_eng2", "engine", "snd_int_rotor", "veh_hind_dist_idle1");
  self setup_heli_sounds("ext_rotor", "engine", "snd_rotor", "veh_hind_rotor_idle");
  self setup_heli_sounds("eng_dmg", "engine", "snd_int_rotor", "veh_hind_sputter");
  self setup_heli_sounds("eng_dmg_alarm", "engine", "snd_cockpit", "veh_hind_alarm_damage_high_loop");
}

init_heli_sounds_hip() {
  self setup_heli_sounds("turbine", "engine", "snd_rotor", "veh_hip_turbine");
  self setup_heli_sounds("top_rotor", "engine", "snd_rotor", "veh_hip_rotor");
  self setup_heli_sounds("hip_dist", "engine", "snd_rotor", "veh_hip_dist");
  self setup_heli_sounds("tail_rotor", "engine", "snd_rotor", "veh_hip_tail");
  self setup_heli_sounds("lfe", "engine", "snd_rotor", "veh_hip_rotor_lfe");
}

init_heli_sounds_chinook() {
  self setup_heli_sounds("turbine", "engine", "tag_origin", "veh_chinook_turbine");
  self setup_heli_sounds("top_rotor", "engine", "main_rotor_jnt", "veh_chinook_rotor");
  self setup_heli_sounds("top_rotor", "engine", "tail_rotor_jnt", "veh_chinook_rotor");
  self setup_heli_sounds("lfe", "engine", "tag_origin", "veh_chinook_rotor_lfe");
}

init_heli_sounds_hind_enemy() {
  self setup_heli_sounds("lfe", "engine", "tag_origin", "veh_hind_epow_rotor_lfe");
  self setup_heli_sounds("turbine", "engine", "tag_origin", "veh_hind_epow_turbine");
  self setup_heli_sounds("top_rotor", "engine", "tag_origin", "veh_hind_epow_rotor");
  self setup_heli_sounds("tail_rotor", "engine", "tag_origin", "veh_hind_epow_tail");
  self setup_heli_sounds("distant", "engine", "tag_origin", "veh_hind_run_dist");
}

init_heli_sounds_hind_vorkuta() {
  self setup_heli_sounds("lfe", "engine", "tag_origin", "veh_hind_rotor_lfe");
  self setup_heli_sounds("turbine", "engine", "tag_origin", "veh_hind_turbine");
  self setup_heli_sounds("top_rotor", "engine", "tag_origin", "veh_hind_rotor");
  self setup_heli_sounds("tail_rotor", "engine", "tag_origin", "veh_hind_tail");
  self setup_heli_sounds("distant", "engine", "tag_origin", "veh_hind_run_dist");
}

init_heli_sounds_pavelow_la2() {
  self setup_heli_sounds("turbine", "engine", "main_rotor_jnt", "veh_pavelow_turbine");
}

init_heli_sounds_huey_player() {
  setup_heli_sounds("lfe", "engine", "snd_cockpit", "veh_huey_rotor_lfe");
  setup_heli_sounds("turbine", "engine", "snd_rotor", "veh_huey_turbine");
  setup_heli_sounds("top_rotor", "engine", "snd_rotor", "veh_huey_rotor");
  setup_heli_sounds("tail_rotor", "engine", "snd_tail_rotor", "veh_huey_tail");
  setup_heli_sounds("wind_rt", "engine", "snd_wind_right", "veh_huey_door_wind");
  setup_heli_sounds("wind_lft", "engine", "snd_wind_left", "veh_huey_door_wind");
  setup_heli_sounds("radio", "engine", "snd_cockpit", "veh_huey_radio");
}

init_heli_sounds_player_drone_so() {
  setup_heli_sounds("turbine_idle", "engine", "tag_origin", "veh_qrdrone_turbine_idle");
  setup_heli_sounds("turbine_moving", "engine", "tag_origin", "veh_qrdrone_turbine_moving");
  setup_heli_sounds("turn", "engine", "tag_origin", "veh_qrdrone_idle_rotate");
  self.warning_tag = "tag_origin";
}

init_heli_sounds_blackhawk() {
  setup_heli_sounds("turbine", "engine", "tag_origin", "veh_bhawk_turbine");
  setup_heli_sounds("top_rotor", "engine", "tag_origin", "veh_bhawk_rotor");
  setup_heli_sounds("tail_rotor", "engine", "tag_origin", "veh_bhawk_tail");
  setup_heli_sounds("lfe", "engine", "tag_origin", "veh_bhawk_rotor_lfe");
}

init_heli_sounds_osprey() {
  setup_heli_sounds("lfe", "engine", "tag_origin", "veh_osprey_rotor_lfe");
  setup_heli_sounds("turbine", "engine", "tag_origin", "veh_osprey_turbine");
  setup_heli_sounds("top_rotor", "engine", "tag_origin", "veh_osprey_rotor");
}

init_heli_sounds_vtol() {
  self setup_heli_sounds("lfe", "engine", "tag_origin", "veh_vtol_rotor_lfe");
  self setup_heli_sounds("turbine", "engine", "tag_origin", "veh_vtol_turbine");
  self setup_heli_sounds("top_rotor", "engine", "tag_origin", "veh_vtol_rotor");
}

init_heli_sounds_heli_future() {
  self setup_heli_sounds("lfe", "engine", "tag_origin", "veh_heli_future_lfe");
  self setup_heli_sounds("turbine", "engine", "snd_cockpit", "veh_heli_future_turbine");
  self setup_heli_sounds("rotor", "engine", "snd_cockpit", "veh_heli_future_rotor");
}

init_heli_sounds_jetwing() {
  self setup_heli_sounds("steady", "engine", "tag_origin", "veh_jetwing_npc");
}

setup_heli_sounds(bone_location, type, tag, run, dmg1, dmg2, dmg3, distancecheck) {
  self.heli[bone_location] = spawnstruct();
  self.heli[bone_location].sound_type = type;
  self.heli[bone_location].run = spawn(0, self.origin, "script_origin");
  self.heli[bone_location].run linkto(self, tag);
  self.heli[bone_location].run.alias = run;
  self.sound_ents[self.sound_ents.size] = self.heli[bone_location].run;

  if(isDefined(distancecheck))
    self thread delete_loop_distance(self.heli[bone_location].run);

  if(isDefined(dmg1)) {
    self.heli[bone_location].dmg1 = spawn(0, self.origin, "script_origin");
    self.heli[bone_location].dmg1 linkto(self, tag);
    self.heli[bone_location].dmg1.alias = dmg1;
    self.sound_ents[self.sound_ents.size] = self.heli[bone_location].dmg1;
  }

  if(isDefined(dmg2)) {
    self.heli[bone_location].idle = spawn(0, self.origin, "script_origin");
    self.heli[bone_location].idle linkto(self, tag);
    self.heli[bone_location].idle.alias = dmg2;
    self.sound_ents[self.sound_ents.size] = self.heli[bone_location].dmg2;
  }

  if(isDefined(dmg3)) {
    self.heli[bone_location].idle = spawn(0, self.origin, "script_origin");
    self.heli[bone_location].idle linkto(self, tag);
    self.heli[bone_location].idle.alias = dmg3;
    self.sound_ents[self.sound_ents.size] = self.heli[bone_location].dmg3;
  }
}

init_terrain_sounds() {
  self.surface_type = [];
  self.surface_type["default"] = "dirt";
  self.surface_type["metal"] = "dirt";
  self.surface_type["concrete"] = "dirt";
  self.surface_type["wood"] = "dirt";
  self.surface_type["dirt"] = "dirt";
  self.surface_type["gravel"] = "dirt";
  self.surface_type["grass"] = "dirt";
  self.surface_type["mud"] = "dirt";
  self.surface_type["snow"] = "dirt";
  self.surface_type["asphalt"] = "dirt";
  self.surface_type["brick"] = "dirt";
  self.surface_type["glass"] = "dirt";
  self.surface_type["plaster"] = "dirt";
  self.surface_type["sand"] = "dirt";
  self.surface_type["rock"] = "dirt";
  self.surface_type["water"] = "water";
  self.surface_type["foliage"] = "dirt";
  self setup_terrain_sounds("dirt", "veh_chopper_prop_wash_dirt");
  self setup_terrain_sounds("water", "veh_chopper_prop_wash_water");
}

setup_terrain_sounds(surface_type, alias) {
  self.terrain_ent_array[surface_type] = spawn(0, self.origin, "script_origin");
  self.terrain_ent_array[surface_type].alias = alias;
  self thread terrain_loop_sound_delete(self.terrain_ent_array[surface_type]);
}

start_helicopter_sounds(localclientnum) {
  if(isDefined(self.vehicletype)) {
    self.heli = [];
    self.terrain = [];
    self.sound_ents = [];
    self.cur_speed = 0;
    self.idle_run_trans_speed = 5;
    play_terrain_sounds = 0;

    switch (self.vehicletype) {
      case "heli_littlebird":
        self init_heli_sounds_littlebird();
        self play_littlebird_sounds();

        println("helicopter type: " + self.vehicletype + " found; playing helicopter sounds");

        break;
      case "heli_apache":
      case "heli_future":
        self init_heli_sounds_apache();
        self play_apache_sounds();

        println("helicopter type: " + self.vehicletype + " found; playing helicopter sounds");

        break;
      case "plane_f35":
        self init_heli_sounds_f35();
        self play_f35_sounds();

        println("helicopter type: " + self.vehicletype + " found; playing helicopter sounds");

        break;
      case "plane_f35_fast_la2":
        self init_heli_sounds_f35_la2();
        self play_f35_la2_sounds();

        println("helicopter type: " + self.vehicletype + " found; playing helicopter sounds");

        break;
      case "plane_f35_player":
      case "plane_f35_player_vtol":
      case "plane_f35_player_vtol_dogfight":
      case "plane_f35_player_vtol_fast":
      case "plane_f35_vtol":
      case "plane_f35_vtol_nocockpit":
      case "plane_fa38_hero":
        self thread init_heli_sounds_f35_vtol();

        println("helicopter type: " + self.vehicletype + " found; playing helicopter sounds");

        break;
      case "heli_v78_blackout":
      case "heli_v78_yemen":
      case "plane_x78":
        self thread flying_booster_rotate_update();
      case "plane_fa38_prototype":
        self init_heli_sounds_plane_x78();
        self play_plane_x78_sounds();

        println("helicopter type: " + self.vehicletype + " found; playing helicopter sounds");

        break;
      case "heli_alouette":
      case "heli_alouette_angola_river":
        self init_heli_sounds_alouette();
        self play_alouette_sounds();

        println("helicopter type: " + self.vehicletype + " found; playing helicopter sounds");

        break;
      case "drone_firescout":
      case "drone_firescout_allies":
      case "drone_firescout_axis":
      case "drone_firescout_isi":
      case "heli_huey_small":
        self init_heli_sounds_firescout();
        self play_firescout_sounds();
        level.pitch_run_rate = 0.15;
        break;
      case "heli_huey_gunship":
        self init_heli_sounds_huey();
        self play_huey_sounds();

        println("helicopter type: " + self.vehicletype + " found; playing helicopter sounds");

        break;
      case "heli_hind":
      case "heli_hind_doublesize":
      case "heli_hind_doublesize_uwb":
      case "heli_hind_river":
      case "heli_hind_so":
        self init_heli_sounds_hind_enemy();
        self play_hind_enemy_sounds();

        println("helicopter type: " + self.vehicletype + " found; playing helicopter sounds");

        break;
      case "heli_cobra":
      case "heli_hind_afghan":
      case "heli_hind_afghan_rts":
      case "heli_hip":
      case "heli_hip_afghan":
      case "heli_hip_afghanistan":
      case "heli_hip_afghanistan_land":
      case "heli_hip_noseturret":
      case "hip_soviet":
        self init_heli_sounds_hip();
        self play_hip_sounds();

        println("helicopter type: " + self.vehicletype + " found; playing helicopter sounds");

        break;
      case "heli_hind_angola":
      case "heli_hind_pakistan":
      case "heli_huey":
      case "heli_huey_assault":
      case "heli_huey_assault_river":
      case "heli_huey_gunship_river":
      case "heli_huey_heavyhog_river":
      case "heli_huey_medivac_khesanh":
      case "heli_huey_medivac_river":
      case "heli_huey_player":
      case "heli_huey_side_minigun":
      case "heli_huey_usmc":
      case "heli_huey_vista":
        self init_heli_sounds_huey_toda();
        self play_huey_toda_sounds();

        println("helicopter type: " + self.vehicletype + " found; playing helicopter sounds");

        break;
      case "heli_chinook":
      case "heli_seaknight":
        self init_heli_sounds_chinook();
        self play_chinook_sounds();

        println("helicopter type: " + self.vehicletype + " found; playing helicopter sounds");

        break;
      case "heli_hip_so":
      case "heli_pavelow":
      case "heli_pavelow_la2":
        self init_heli_sounds_pavelow_la2();
        self play_pavelow_sounds_la2();

        println("helicopter type: " + self.vehicletype + " found; playing helicopter sounds");

        break;
      case "heli_osprey":
      case "heli_osprey_pakistan":
      case "heli_v78":
      case "heli_v78_yemen_player":
        self init_heli_sounds_heli_osprey();
        self play_heli_osprey_sounds();
        self thread flying_booster_rotate_update();

        println("helicopter type: " + self.vehicletype + " found; playing helicopter sounds");

        break;
      case "heli_osprey_rts_axis":
      case "heli_v78_rts":
        self init_heli_sounds_heli_osprey_rts();
        self play_heli_osprey_rts_sounds();
        self thread flying_booster_rotate_update();
        break;
      case "heli_quadrotor":
        self play_player_drone_sounds();

        println("helicopter type: " + self.vehicletype + " found; playing helicopter sounds");

        break;
      case "heli_quadrotor_rts":
      case "heli_quadrotor_rts_player":
      case "heli_quadrotor_rtsafghan_player":
        self init_heli_sounds_player_drone_so();
        self play_player_drone_sounds_so();

        println("helicopter type: " + self.vehicletype + " found; playing helicopter sounds");

        break;
      case "plane_osprey":
        self init_heli_sounds_osprey();
        self play_osprey_sounds();

        println("helicopter type: " + self.vehicletype + " found; playing helicopter sounds");

        break;
      case "drone_avenger_blackout":
      case "drone_avenger_fast":
      case "drone_avenger_fast_blackout":
      case "drone_pegasus_blackout":
      case "drone_pegasus_fast":
      case "drone_pegasus_fast_blackout":
      case "drone_pegasus_fast_la2_2x":
      case "drone_pegasus_low_la2":
      case "plane_f35_fast":
      case "plane_f35_low":
      case "plane_fa38_prototype_blackout":
      case "plane_mig23":
        play_terrain_sounds = 0;
        break;
      case "heli_blackhawk_rts":
      case "heli_blackhawk_rts_axis":
      case "heli_blackhawk_stealth":
      case "heli_blackhawk_stealth_axis":
      case "heli_blackhawk_stealth_la2":
      case "heli_future_la2":
        self init_heli_sounds_blackhawk();
        self play_heli_sounds_blackhawk();

        println("helicopter type: " + self.vehicletype + " found; playing helicopter sounds");

        break;
      case "heli_v78_blackout_low":
      case "heli_vtol":
        self init_heli_sounds_vtol();
        self play_heli_sounds_vtol();

        println("helicopter type: " + self.vehicletype + " found; playing helicopter sounds");

        break;
      case "heli_future_pakistan":
        self init_heli_sounds_heli_future();
        self play_heli_future_sounds();

        println("helicopter type: " + self.vehicletype + " found; playing helicopter sounds");

        break;
      case "plane_jetwing_haiti_ai_hero":
        self init_heli_sounds_jetwing();
        self play_jetwing_sounds();

        println("helicopter type: " + self.vehicletype + " found; playing helicopter sounds");

        break;
      case "heli_v78_haiti_ending":
      case "heli_v78_low":
        self thread flying_booster_rotate_update();
        break;
      default:
        play_terrain_sounds = 0;

        if(getdvarint(#"_id_55AD9BED") > 0)
          println("^5helicopter type: " + self.vehicletype + " NOT FOUND; playing NO helicopter sounds");

        break;
    }

    if(play_terrain_sounds) {
      self init_terrain_sounds();
      self thread terrain_trace();
    }
  } else {
    println("^6helicopter type: " + self.vehicletype + " not defined");

  }
}

delete_loop_distance(real_ent) {
  self endon("heli_entityshutdown");
  self waittill("outOfRange");

  println("heli_script: outOfRange");

  if(isDefined(real_ent)) {
    println("heli_script: killing DRONE sound ent");

    real_ent stoploopsound(0);
    real_ent delete();
  }
}

terrain_loop_sound_delete(real_ent) {
  self waittill("entityshutdown");
  self notify("heli_entityshutdown");

  println("heli_script: deleting terrain ents");

  if(isDefined(real_ent)) {
    real_ent stoploopsound(4);
    real_ent delete();
  }
}

heli_linkto_sound_ents_delete(localclientnum, entity) {
  entity notify("heli_entityshutdown");
  array_thread(entity.sound_ents, ::heli_delete_sound_loops);
}

heli_delete_sound_loops() {
  println("heli_script: deleting linkto ents");

  if(isDefined(self)) {
    self stoploopsound(4);
    self delete();
  }
}

drone_delete_sound_loops() {
  println("heli_script: deleting linkto ents");

  if(isDefined(self))
    self delete();
}

play_f35_sounds() {
  self thread heli_idle_run_transition("f35", "idle");
  self thread heli_idle_run_transition("f35", "forward");
  self thread heli_idle_run_transition("f35", "up");
  self thread heli_idle_run_transition("f35", "lateral");
}

play_f35_la2_sounds() {
  self thread heli_idle_run_transition("f35_la2", "forward");
}

play_f35_vtol_sounds() {
  self endon("heli_entityshutdown");
  wait 0.1;
  self thread jet_idle_run_transition("f35_vtol", "steady");
  self thread jet_idle_run_transition("f35_vtol", "steady_low");
  self thread jet_idle_run_transition("f35_vtol", "steady_hum");
  self thread jet_turn_rattle_transition("f35_vtol", "turn_rattle");
  self thread jet_turn_transition("f35_vtol", "turn");
  self thread jet_up_rattle_transition("f35_vtol", "up_rattle");
  self thread jet_up_transition("f35_vtol", "up");
  self thread jet_down_transition("f35_vtol", "down");
  self thread jet_afterburn("f35_vtol", "afterburn");
  self thread heli_sound_play(self.heli["telemetry"]);
}

play_plane_x78_sounds() {
  self thread jet_idle_run_transition("plane_x78", "steady");
  self thread jet_up_transition("plane_x78", "up");
  self thread jet_down_transition("plane_x78", "down");
}

play_heli_osprey_sounds() {
  self thread heli_sound_play(self.heli["lfe"]);
  self thread jet_idle_run_transition("heli_osprey", "steady");
  self thread jet_up_transition("heli_osprey", "up");
  self thread jet_down_transition("heli_osprey", "down");
}

play_heli_osprey_rts_sounds() {
  self thread heli_sound_play(self.heli["lfe"]);
  self thread heli_idle_run_transition("plane_v78_rts", "steady");
  self thread heli_idle_run_transition("plane_v78_rts", "int");
  self thread heli_idle_run_transition("plane_v78_rts", "side");
  self thread jet_up_transition("plane_v78_rts", "up");
  self thread jet_down_transition("plane_v78_rts", "down");
}

play_hind_sounds() {
  self thread heli_idle_run_transition("hind", "cockpit");
  self thread heli_idle_run_transition("hind", "cockpit2");
  self thread heli_idle_run_transition("hind", "int_eng");
  self thread heli_idle_run_transition("hind", "int_eng2");
  self thread heli_idle_run_transition("hind", "ext_rotor");
}

play_hind_enemy_sounds() {
  self thread heli_sound_play(self.heli["lfe"]);
  self thread heli_idle_run_transition("hind_enemy", "turbine");
  self thread heli_idle_run_transition("hind_enemy", "top_rotor");
  self thread heli_idle_run_transition("hind_enemy", "tail_rotor");
  self thread heli_idle_run_transition("hind_enemy", "distant");
}

play_firescout_sounds() {
  self thread heli_idle_run_transition("drone_firescout", "turbine");
  self thread heli_idle_run_transition("drone_firescout", "close");
  self thread heli_idle_run_transition("drone_firescout", "distant");
}

play_huey_sounds() {
  self thread heli_sound_play(self.heli["lfe"]);
  self thread heli_idle_run_transition("huey", "cockpit");
  self thread heli_idle_run_transition("huey", "cockpit2");
  self thread heli_idle_run_transition("huey", "int_eng");
  self thread heli_idle_run_transition("huey", "int_eng2");
  self thread heli_idle_run_transition("huey", "int_eng3");
  self thread heli_idle_run_transition("huey", "ext_rotor");
}

play_hip_sounds() {
  self thread heli_sound_play(self.heli["lfe"]);
  self thread heli_idle_run_transition("hip", "turbine");
  self thread heli_idle_run_transition("hip", "hip_dist");
  self thread heli_idle_run_transition("hip", "top_rotor");
  self thread heli_idle_run_transition("hip", "tail_rotor");
}

play_alouette_sounds() {
  self thread heli_sound_play(self.heli["lfe"]);
  self thread heli_idle_run_transition("heli_alouette", "turbine");
  self thread heli_idle_run_transition("heli_alouette", "top_rotor");
  self thread heli_idle_run_transition("heli_alouette", "tail_rotor");
}

play_huey_toda_sounds() {
  self thread heli_sound_play(self.heli["lfe"]);
  self thread heli_idle_run_transition("huey_toda", "turbine");
  self thread heli_idle_run_transition("huey_toda", "top_rotor");
  self thread heli_idle_run_transition("huey_toda", "tail_rotor");
  self thread heli_idle_run_transition("huey_toda", "distant");
}

play_littlebird_sounds() {
  self thread heli_sound_play(self.heli["lfe"]);
  self thread heli_idle_run_transition("huey_toda", "turbine");
  self thread heli_idle_run_transition("huey_toda", "top_rotor");
  self thread heli_idle_run_transition("huey_toda", "tail_rotor");
  self thread heli_idle_run_transition("huey_toda", "distant");
}

play_apache_sounds() {
  self thread heli_sound_play(self.heli["lfe"]);
  self thread heli_idle_run_transition("huey_toda", "turbine");
  self thread heli_idle_run_transition("huey_toda", "top_rotor");
  self thread heli_idle_run_transition("huey_toda", "tail_rotor");
  self thread heli_idle_run_transition("huey_toda", "distant");
}

play_chinook_sounds() {
  self thread heli_idle_run_transition("heli_chinook", "top_rotor");
  self thread heli_idle_run_transition("heli_chinook", "turbine");
  self thread heli_sound_play(self.heli["lfe"]);
}

play_hind_sounds_vorkuta() {
  self thread heli_idle_run_transition("hip", "turbine");
  self thread heli_idle_run_transition("hip", "top_rotor");
  self thread heli_idle_run_transition("hip", "tail_rotor");
}

play_pavelow_sounds_la2() {
  self thread heli_idle_run_transition("heli_pavelow_la2", "turbine");
}

play_heli_sounds_huey_player() {
  self thread heli_sound_play(self.heli["lfe"]);
  self thread heli_sound_play(self.heli["radio"]);
  self thread heli_idle_run_transition("huey_player", "turbine");
  self thread heli_idle_run_transition("huey_player", "top_rotor");
  self thread heli_idle_run_transition("huey_player", "tail_rotor");
  self thread heli_idle_run_transition("huey_player", "wind_rt");
  self thread heli_idle_run_transition("huey_player", "wind_lft");
}

play_player_drone_sounds() {
  self thread quad_idle_run_transition("qrdrone", "turbine_idle", "turbine_moving", "distant", "close", 0, 0.2);
}

play_player_drone_sounds_so() {
  self thread heli_idle_run_transition("qrdrone_so", "turbine_idle", 1);
  self thread heli_idle_run_transition("qrdrone_so", "turbine_moving", 1);
  self thread drone_up_down_transition();
  self thread drone_rotate_angle("qrdrone_so", "turn");
}

play_osprey_sounds() {
  self thread heli_idle_run_transition("osprey", "turbine");
  self thread heli_idle_run_transition("osprey", "top_rotor");
  self thread heli_sound_play(self.heli["lfe"]);
}

play_heli_sounds_vtol() {
  self thread heli_idle_run_transition("vtol", "turbine");
  self thread heli_idle_run_transition("vtol", "top_rotor");
}

play_heli_sounds_blackhawk() {
  self thread heli_idle_run_transition("blackhawk", "turbine");
  self thread heli_idle_run_transition("blackhawk", "top_rotor");
  self thread heli_idle_run_transition("blackhawk", "tail_rotor");
  self thread heli_sound_play(self.heli["lfe"]);
}

play_heli_future_sounds() {
  self thread heli_idle_run_transition("heli_future", "turbine");
  self thread heli_idle_run_transition("heli_future", "rotor");
  self thread heli_sound_play(self.heli["lfe"]);
}

play_jetwing_sounds() {
  self thread heli_idle_run_transition("jetwing", "steady");
}

heli_sound_play(heli_bone) {
  self endon("heli_entityshutdown");
  self endon("entityshutdown");

  while(!clienthassnapshot(0))
    wait 0.05;

  if(!isDefined(heli_bone)) {
    println("AUDIO ERROR: Undefined call toheli_sound_play( heli_bone ); ");

    return;
  }

  if(!isDefined(heli_bone.run)) {
    println("AUDIO ERROR: Undefined heli_bone.run ");

    return;
  }

  while(true) {
    if(isDefined(self.should_not_play_sounds) && self.should_not_play_sounds && isDefined(heli_bone.run)) {
      heli_bone.run stoploopsound(0.5);
      self waittill("play_heli_sounds");
    }

    if(isDefined(heli_bone.run)) {
      heli_bone.run playloopsound(heli_bone.run.alias, 2);
      self waittill("stop_heli_sounds");
    } else
      wait 0.05;
  }
}

init_heli_sounds_player_drone() {
  setup_heli_sounds("turbine_idle", "engine", "tag_origin", "veh_qr_idle", undefined, undefined, undefined, 1);
  setup_heli_sounds("turbine_moving", "engine", "tag_origin", "veh_qr_move", undefined, undefined, undefined, 1);
  setup_heli_sounds("distant", "engine", "tag_origin", "veh_qr_distant", undefined, undefined, undefined, 1);
  setup_heli_sounds("close", "engine", "tag_origin", "veh_qr_close", undefined, undefined, undefined, 1);
}

quad_idle_run_transition(heli_type, heli_part1, heli_part2, heli_part3, heli_part4, updown, delay, distancecheck) {
  self endon("entityshutdown");

  while(!clienthassnapshot(0))
    wait 0.05;

  wait(randomfloat(0.5));
  self init_heli_sounds_player_drone();
  self.deletedfakeents = 0;

  if(!isDefined(delay))
    delay = 0.05;

  if(!isDefined(updown))
    updown = 0;

  heli_bone1 = self.heli[heli_part1];
  heli_bone2 = self.heli[heli_part2];
  heli_bone3 = self.heli[heli_part3];
  heli_bone4 = self.heli[heli_part4];
  run_id1 = undefined;
  run_id2 = undefined;
  run_id4 = undefined;
  heli_damage = "none";

  if(!isDefined(level.helisoundvalues[heli_type])) {
    println("^5a speed vol/pitch parameter was not defined for heli_type '" + heli_type + "'.");

    return;
  }

  if(!isDefined(level.helisoundvalues[heli_type][heli_part1])) {
    println("^5a speed vol/pitch parameter was not defined for heli_type '" + heli_type + "' and heli_part '" + heli_part1 + "'.");

    return;
  }

  if(!isDefined(level.helisoundvalues[heli_type][heli_part2])) {
    println("^5a speed vol/pitch parameter was not defined for heli_type '" + heli_type + "' and heli_part '" + heli_part2 + "'.");

    return;
  }

  if(!isDefined(level.helisoundvalues[heli_type][heli_part3])) {
    println("^5a speed vol/pitch parameter was not defined for heli_type '" + heli_type + "' and heli_part '" + heli_part3 + "'.");

    return;
  }

  if(!isDefined(level.helisoundvalues[heli_type][heli_part4])) {
    println("^5a speed vol/pitch parameter was not defined for heli_type '" + heli_type + "' and heli_part '" + heli_part4 + "'.");

    return;
  }

  last_speed = 0;

  while(isDefined(self)) {
    last_pos = self.origin[2];
    wait 0.2;

    if(isDefined(self.should_not_play_sounds) && self.should_not_play_sounds) {
      heli_bone1.run stoploopsound(0.5);
      heli_bone2.run stoploopsound(0.5);
      heli_bone4.run stoploopsound(0.5);
      run_id1 = undefined;
      run_id2 = undefined;
      run_id4 = undefined;
      self waittill("play_heli_sounds");
      continue;
    }

    player = getlocalplayers()[0];
    playerdistance = distancesquared(self.origin, player.origin);

    if(playerdistance > 1000000) {
      if(!self.deletedfakeents)
        wait 0.5;
    } else {
      if(self.deletedfakeents) {
        self init_heli_sounds_player_drone();
        wait 0.5;
        self.deletedfakeents = 0;
        run_id1 = heli_bone1.run playloopsound(heli_bone1.run.alias, 0.5);
        run_id2 = heli_bone2.run playloopsound(heli_bone2.run.alias, 0.5);
        self thread heli_sound_play(self.heli["close"]);
      }

      if(!isDefined(run_id1)) {
        run_id1 = heli_bone1.run playloopsound(heli_bone1.run.alias, 0.5);
        run_id2 = heli_bone2.run playloopsound(heli_bone2.run.alias, 0.5);
        self thread heli_sound_play(self.heli["distant"]);
        self thread heli_sound_play(self.heli["close"]);
      }

      self.cur_speed = self getspeed() / 17.6;

      if(last_speed != self.cur_speed) {
        last_speed = self.cur_speed;
        run_volume1 = scale_speed(0, 25, 0.8, 0.0, self.cur_speed);
        run_pitch1 = scale_speed(0, 16, 9, 1.1, self.cur_speed);
        run_volume2 = scale_speed(0, 25, 0.0, 1.0, self.cur_speed);
        run_pitch2 = scale_speed(0, 25, 0.9, 1.1, self.cur_speed);
        updown = 0;

        if(updown) {
          self.qrdrone_z_difference = last_pos - self.origin[2];

          if(!isDefined(self.qrdrone_z_difference))
            self.qrdrone_z_difference = 0;

          run_volume_vertical = scale_speed(0, 15, 0, 1, abs(self.qrdrone_z_difference));
          run_volume_vertical_smooth = run_volume_vertical * run_volume_vertical * run_volume_vertical;
          run_volume1 = run_volume1 - run_volume_vertical_smooth;
          run_volume2 = run_volume2 + run_volume_vertical_smooth;
        }

        if(isDefined(run_volume1) && isDefined(run_pitch1)) {
          heli_bone1.run setloopstate(heli_bone1.run.alias, run_volume1, run_pitch1, 1, level.pitch_run_rate);
          heli_bone2.run setloopstate(heli_bone2.run.alias, run_volume2, run_pitch2, 1, level.pitch_run_rate);
        }
      }
    }

    if(getdvarint(#"_id_55AD9BED") > 0 && isDefined(run_volume1) && isDefined(run_pitch1)) {
      println("^5a self.cur_speed = " + self.cur_speed);
      println("^5a run_pitch . " + run_pitch1);
      println("^5a self.cur_speed = " + self.cur_speed);
      println("^5a run_volume. " + run_volume1);
    }

  }
}

heli_idle_run_transition(heli_type, heli_part, updown, delay) {
  self endon("entityshutdown");

  while(!clienthassnapshot(0))
    wait 0.05;

  wait(randomfloat(0.5));

  if(!isDefined(delay))
    delay = 0.05;

  if(!isDefined(updown))
    updown = 0;

  heli_bone = self.heli[heli_part];
  run_id = undefined;
  heli_damage = "none";

  if(!isDefined(level.helisoundvalues[heli_type])) {
    println("^5a speed vol/pitch parameter was not defined for heli_type '" + heli_type + "'.");

    return;
  }

  if(!isDefined(level.helisoundvalues[heli_type][heli_part])) {
    println("^5a speed vol/pitch parameter was not defined for heli_type '" + heli_type + "' and heli_part '" + heli_part + "'.");

    return;
  }

  last_speed = 0;

  while(isDefined(self)) {
    wait(delay);

    if(isDefined(self.should_not_play_sounds) && self.should_not_play_sounds) {
      if(isDefined(heli_bone.run)) {
        heli_bone.run stoploopsound(0.5);
        run_id = undefined;
      }

      self waittill("play_heli_sounds");
      continue;
    }

    if(!isDefined(run_id)) {
      if(isDefined(heli_bone.run))
        run_id = heli_bone.run playloopsound(heli_bone.run.alias, 0.5);
      else
        continue;
    }

    max_speed_vol = level.helisoundvalues[heli_type][heli_part].speedvolumemax;
    min_vol = level.helisoundvalues[heli_type][heli_part].volumemin;
    max_vol = level.helisoundvalues[heli_type][heli_part].volumemax;
    max_speed_pitch = level.helisoundvalues[heli_type][heli_part].speedpitchmax;
    min_pitch = level.helisoundvalues[heli_type][heli_part].pitchmin;
    max_pitch = level.helisoundvalues[heli_type][heli_part].pitchmax;
    plr_vel = self getvelocity();
    self.cur_speed = abs(sqrt(vectordot(plr_vel, plr_vel))) / 17.6;

    if(last_speed != self.cur_speed) {
      last_speed = self.cur_speed;
      run_volume = scale_speed(self.idle_run_trans_speed, max_speed_vol, min_vol, max_vol, self.cur_speed);
      run_pitch = scale_speed(self.idle_run_trans_speed, max_speed_pitch, min_pitch, max_pitch, self.cur_speed);

      if(updown) {
        if(!isDefined(self.qrdrone_z_difference))
          self.qrdrone_z_difference = 0;

        run_volume_vertical = scale_speed(5, 50, 0, 1, abs(self.qrdrone_z_difference));
        run_volume = run_volume - run_volume_vertical;
      }

      if(isDefined(run_volume) && isDefined(run_pitch) && isDefined(heli_bone.run))
        heli_bone.run setloopstate(heli_bone.run.alias, run_volume, run_pitch, 1, level.pitch_run_rate);
    }

    if(isDefined(self.isdamaged) && heli_damage == "none") {
      return;
    }
    if(getdvarint(#"_id_55AD9BED") > 0 && isDefined(run_volume) && isDefined(run_pitch)) {
      println("^5a self.cur_speed = " + self.cur_speed);
      println("^5a run_pitch . " + run_pitch);
      println("^5a self.cur_speed = " + self.cur_speed);
      println("^5a run_volume. " + run_volume);
    }

  }
}

jet_afterburn(heli_type, heli_part) {
  self endon("entityshutdown");

  while(!clienthassnapshot(0))
    wait 0.05;

  level.sndvtolmode = 1;
  heli_bone = self.heli[heli_part];
  run_id = undefined;
  heli_damage = "none";

  if(!isDefined(level.helisoundvalues[heli_type])) {
    println("^5a speed vol/pitch parameter was not defined for heli_type '" + heli_type + "'.");

    return;
  }

  if(!isDefined(level.helisoundvalues[heli_type][heli_part])) {
    println("^5a speed vol/pitch parameter was not defined for heli_type '" + heli_type + "' and heli_part '" + heli_part + "'.");

    return;
  }

  while(isDefined(self)) {
    wait 0.05;

    if(level.sndvtolmode) {
      if(isDefined(heli_bone.run)) {
        heli_bone.run stoploopsound(0.5);
        run_id = undefined;
      }

      level waittill("snd_jet_start");
      continue;
    }

    if(!isDefined(run_id) && isDefined(heli_bone.run))
      run_id = heli_bone.run playloopsound(heli_bone.run.alias, 0.5);

    max_speed_vol = level.helisoundvalues[heli_type][heli_part].speedvolumemax;
    min_vol = level.helisoundvalues[heli_type][heli_part].volumemin;
    max_vol = level.helisoundvalues[heli_type][heli_part].volumemax;
    max_speed_pitch = level.helisoundvalues[heli_type][heli_part].speedpitchmax;
    min_pitch = level.helisoundvalues[heli_type][heli_part].pitchmin;
    max_pitch = level.helisoundvalues[heli_type][heli_part].pitchmax;
    self.cur_speed = self getspeed() / 17.6;
    run_volume = scale_speed(self.idle_run_trans_speed, max_speed_vol, min_vol, max_vol, self.cur_speed);
    run_pitch = scale_speed(self.idle_run_trans_speed, max_speed_pitch, min_pitch, max_pitch, self.cur_speed);

    if(isDefined(run_id))
      setsoundvolume(run_id, run_volume);
  }
}

jet_idle_run_transition(heli_type, heli_part) {
  self endon("entityshutdown");

  while(!clienthassnapshot(0))
    wait 0.05;

  heli_bone = self.heli[heli_part];
  run_id = undefined;
  heli_damage = "none";

  if(!isDefined(level.helisoundvalues[heli_type])) {
    println("^5a speed vol/pitch parameter was not defined for heli_type '" + heli_type + "'.");

    return;
  }

  if(!isDefined(level.helisoundvalues[heli_type][heli_part])) {
    println("^5a speed vol/pitch parameter was not defined for heli_type '" + heli_type + "' and heli_part '" + heli_part + "'.");

    return;
  }

  while(isDefined(self)) {
    wait 0.05;

    if(isDefined(self.should_not_play_sounds) && self.should_not_play_sounds) {
      if(isDefined(heli_bone.run)) {
        heli_bone.run stoploopsound(0.5);
        run_id = undefined;
      }

      self waittill("play_heli_sounds");
      continue;
    }

    if(!isDefined(run_id) && isDefined(heli_bone.run))
      run_id = heli_bone.run playloopsound(heli_bone.run.alias, 0.5);

    max_speed_vol = level.helisoundvalues[heli_type][heli_part].speedvolumemax;
    min_vol = level.helisoundvalues[heli_type][heli_part].volumemin;
    max_vol = level.helisoundvalues[heli_type][heli_part].volumemax;
    max_speed_pitch = level.helisoundvalues[heli_type][heli_part].speedpitchmax;
    min_pitch = level.helisoundvalues[heli_type][heli_part].pitchmin;
    max_pitch = level.helisoundvalues[heli_type][heli_part].pitchmax;
    self.cur_speed = self getspeed() / 17.6;
    run_volume = scale_speed(self.idle_run_trans_speed, max_speed_vol, min_vol, max_vol, self.cur_speed);
    run_pitch = scale_speed(self.idle_run_trans_speed, max_speed_pitch, min_pitch, max_pitch, self.cur_speed);
    movement = self getnormalizedcameramovement();
    jet_stick_turn = movement[1];

    if(jet_stick_turn <= 0)
      jet_stick_turn = jet_stick_turn * -1;

    jet_stick_pitch = movement[0];

    if(jet_stick_pitch <= 0)
      jet_stick_pitch = jet_stick_pitch * -1;

    jet_stick_movement = jet_stick_turn + jet_stick_pitch;
    jet_stick_move_pitch = scale_speed(0, 1.6, 0.5, 1.5, jet_stick_movement);

    if(isDefined(run_volume) && isDefined(run_pitch) && isDefined(run_id)) {
      if(isDefined(heli_bone.run))
        heli_bone.run setloopstate(heli_bone.run.alias, run_volume, run_pitch, 1, level.pitch_run_rate);

      if(isDefined(self.isdamaged) && heli_damage == "none") {
        return;
      }
      if(getdvarint(#"_id_55AD9BED") > 0) {
        println("^5a self.cur_speed = " + self.cur_speed);
        println("^5a run_pitch . " + run_pitch);
        println("^5a self.cur_speed = " + self.cur_speed);
        println("^5a run_volume. " + run_volume);
      }

    }
  }
}

jet_turn_transition(heli_type, heli_part) {
  self endon("entityshutdown");

  while(!clienthassnapshot(0))
    wait 0.05;

  heli_bone = self.heli[heli_part];
  run_id = undefined;
  heli_damage = "none";

  if(!isDefined(level.helisoundvalues[heli_type])) {
    println("^5a speed vol/pitch parameter was not defined for heli_type '" + heli_type + "'.");

    return;
  }

  if(!isDefined(level.helisoundvalues[heli_type][heli_part])) {
    println("^5a speed vol/pitch parameter was not defined for heli_type '" + heli_type + "' and heli_part '" + heli_part + "'.");

    return;
  }

  while(isDefined(self)) {
    wait 0.05;
    max_speed_vol = level.helisoundvalues[heli_type][heli_part].speedvolumemax;
    min_vol = level.helisoundvalues[heli_type][heli_part].volumemin;
    max_vol = level.helisoundvalues[heli_type][heli_part].volumemax;
    max_speed_pitch = level.helisoundvalues[heli_type][heli_part].speedpitchmax;
    min_pitch = level.helisoundvalues[heli_type][heli_part].pitchmin;
    max_pitch = level.helisoundvalues[heli_type][heli_part].pitchmax;
    self.cur_speed = self getspeed() / 17.6;
    run_volume = scale_speed(self.idle_run_trans_speed, max_speed_vol, min_vol, max_vol, self.cur_speed);
    run_pitch = scale_speed(self.idle_run_trans_speed, max_speed_pitch, min_pitch, max_pitch, self.cur_speed);

    if(isDefined(self.should_not_play_sounds) && self.should_not_play_sounds && isDefined(heli_bone.run)) {
      heli_bone.run stoploopsound(0.5);
      run_id = undefined;
      self waittill("play_heli_sounds");
      continue;
    }

    if(!isDefined(run_id) && isDefined(heli_bone.run))
      run_id = heli_bone.run playloopsound(heli_bone.run.alias, 0.5);

    angular_velocity = self.angles;
    turning_speed = abs(angular_velocity[2] / 90);
    jet_stick_vol = scale_speed(0, 0.7, 0, 1, turning_speed);
    jet_stick_pitch = scale_speed(0, 0.7, 1, 1.2, turning_speed);

    if(isDefined(run_id) && isDefined(jet_stick_vol) && isDefined(jet_stick_pitch) && isDefined(heli_bone.run))
      heli_bone.run setloopstate(heli_bone.run.alias, jet_stick_vol, jet_stick_pitch, 0.5, level.jet_stick_pitch_turn_rate);
  }
}

jet_turn_rattle_transition(heli_type, heli_part) {
  self endon("entityshutdown");

  while(!clienthassnapshot(0))
    wait 0.05;

  heli_bone = self.heli[heli_part];
  run_id = undefined;
  heli_damage = "none";

  if(!isDefined(level.helisoundvalues[heli_type])) {
    println("^5a speed vol/pitch parameter was not defined for heli_type '" + heli_type + "'.");

    return;
  }

  if(!isDefined(level.helisoundvalues[heli_type][heli_part])) {
    println("^5a speed vol/pitch parameter was not defined for heli_type '" + heli_type + "' and heli_part '" + heli_part + "'.");

    return;
  }

  while(isDefined(self)) {
    wait 0.05;
    max_speed_vol = level.helisoundvalues[heli_type][heli_part].speedvolumemax;
    min_vol = level.helisoundvalues[heli_type][heli_part].volumemin;
    max_vol = level.helisoundvalues[heli_type][heli_part].volumemax;
    max_speed_pitch = level.helisoundvalues[heli_type][heli_part].speedpitchmax;
    min_pitch = level.helisoundvalues[heli_type][heli_part].pitchmin;
    max_pitch = level.helisoundvalues[heli_type][heli_part].pitchmax;
    self.cur_speed = self getspeed() / 17.6;
    run_volume = scale_speed(self.idle_run_trans_speed, max_speed_vol, min_vol, max_vol, self.cur_speed);
    run_pitch = scale_speed(self.idle_run_trans_speed, max_speed_pitch, min_pitch, max_pitch, self.cur_speed);

    if(isDefined(self.should_not_play_sounds) && self.should_not_play_sounds) {
      if(isDefined(heli_bone.run)) {
        heli_bone.run stoploopsound(0.5);
        run_id = undefined;
      }

      self waittill("play_heli_sounds");
      continue;
    }

    if(!isDefined(run_id) && isDefined(heli_bone.run))
      run_id = heli_bone.run playloopsound(heli_bone.run.alias, 0.5);

    angular_velocity = self.angles;
    turning_speed = abs(angular_velocity[2] / 90);
    jet_stick_vol = scale_speed(0, 0.7, 0, 1, turning_speed);
    jet_stick_pitch = scale_speed(0, 0.7, 1, 1.2, turning_speed);

    if(isDefined(run_id) && isDefined(jet_stick_vol) && isDefined(jet_stick_pitch) && isDefined(heli_bone.run))
      heli_bone.run setloopstate(heli_bone.run.alias, jet_stick_vol, jet_stick_pitch, 0.5, level.jet_stick_pitch_turn_rate);
  }
}

jet_down_transition(heli_type, heli_part) {
  self endon("entityshutdown");

  while(!clienthassnapshot(0))
    wait 0.05;

  heli_bone = self.heli[heli_part];
  run_id = undefined;
  heli_damage = "none";

  if(!isDefined(level.helisoundvalues[heli_type])) {
    println("^5a speed vol/pitch parameter was not defined for heli_type '" + heli_type + "'.");

    return;
  }

  if(!isDefined(level.helisoundvalues[heli_type][heli_part])) {
    println("^5a speed vol/pitch parameter was not defined for heli_type '" + heli_type + "' and heli_part '" + heli_part + "'.");

    return;
  }

  while(isDefined(self)) {
    wait 0.05;
    max_speed_vol = level.helisoundvalues[heli_type][heli_part].speedvolumemax;
    min_vol = level.helisoundvalues[heli_type][heli_part].volumemin;
    max_vol = level.helisoundvalues[heli_type][heli_part].volumemax;
    max_speed_pitch = level.helisoundvalues[heli_type][heli_part].speedpitchmax;
    min_pitch = level.helisoundvalues[heli_type][heli_part].pitchmin;
    max_pitch = level.helisoundvalues[heli_type][heli_part].pitchmax;
    self.cur_speed = self getspeed() / 17.6;
    run_volume = scale_speed(self.idle_run_trans_speed, max_speed_vol, min_vol, max_vol, self.cur_speed);
    run_pitch = scale_speed(self.idle_run_trans_speed, max_speed_pitch, min_pitch, max_pitch, self.cur_speed);

    if(isDefined(self.should_not_play_sounds) && self.should_not_play_sounds) {
      if(isDefined(heli_bone.run)) {
        heli_bone.run stoploopsound(0.5);
        run_id = undefined;
      }

      self waittill("play_heli_sounds");
      continue;
    }

    if(!isDefined(run_id) && isDefined(heli_bone.run))
      run_id = heli_bone.run playloopsound(heli_bone.run.alias, 0.5);

    movement = self getnormalizedcameramovement();
    jet_stick_down = movement[0];

    if(jet_stick_down <= 0)
      jet_stick_down = jet_stick_down * -1;
    else
      jet_stick_down = 0;

    jet_stick_down = scale_speed(0, 1, 0.1, 1, jet_stick_down);
    jet_stick_down_rate = level.jet_stick_down_rate;

    if(isDefined(run_id) && isDefined(jet_stick_down) && isDefined(heli_bone.run))
      heli_bone.run setloopstate(heli_bone.run.alias, jet_stick_down, run_pitch, jet_stick_down_rate, level.jet_stick_pitch_down_rate);
  }
}

jet_up_transition(heli_type, heli_part) {
  self endon("entityshutdown");

  while(!clienthassnapshot(0))
    wait 0.05;

  heli_bone = self.heli[heli_part];
  run_id = undefined;
  heli_damage = "none";

  if(!isDefined(level.helisoundvalues[heli_type])) {
    println("^5a speed vol/pitch parameter was not defined for heli_type '" + heli_type + "'.");

    return;
  }

  if(!isDefined(level.helisoundvalues[heli_type][heli_part])) {
    println("^5a speed vol/pitch parameter was not defined for heli_type '" + heli_type + "' and heli_part '" + heli_part + "'.");

    return;
  }

  while(isDefined(self)) {
    wait 0.05;
    max_speed_vol = level.helisoundvalues[heli_type][heli_part].speedvolumemax;
    min_vol = level.helisoundvalues[heli_type][heli_part].volumemin;
    max_vol = level.helisoundvalues[heli_type][heli_part].volumemax;
    max_speed_pitch = level.helisoundvalues[heli_type][heli_part].speedpitchmax;
    min_pitch = level.helisoundvalues[heli_type][heli_part].pitchmin;
    max_pitch = level.helisoundvalues[heli_type][heli_part].pitchmax;
    self.cur_speed = self getspeed() / 17.6;
    run_volume = scale_speed(self.idle_run_trans_speed, max_speed_vol, min_vol, max_vol, self.cur_speed);
    run_pitch = scale_speed(self.idle_run_trans_speed, max_speed_pitch, min_pitch, max_pitch, self.cur_speed);

    if(isDefined(self.should_not_play_sounds) && self.should_not_play_sounds) {
      if(isDefined(heli_bone.run)) {
        heli_bone.run stoploopsound(0.5);
        run_id = undefined;
      }

      self waittill("play_heli_sounds");
      continue;
    }

    if(!isDefined(run_id) && isDefined(heli_bone.run))
      run_id = heli_bone.run playloopsound(heli_bone.run.alias, 0.5);

    movement = self getnormalizedcameramovement();
    jet_stick_up = movement[0];

    if(jet_stick_up <= 0)
      jet_stick_up = 0;

    jet_stick_up = scale_speed(0, 1, 0.1, 1, jet_stick_up);
    jet_stick_up_rate = level.jet_stick_up_rate;

    if(isDefined(run_id) && isDefined(jet_stick_up) && isDefined(heli_bone.run))
      heli_bone.run setloopstate(heli_bone.run.alias, jet_stick_up, run_pitch, jet_stick_up_rate, level.jet_stick_pitch_up_rate);
  }
}

jet_up_rattle_transition(heli_type, heli_part) {
  self endon("entityshutdown");

  while(!clienthassnapshot(0))
    wait 0.05;

  heli_bone = self.heli[heli_part];
  run_id = undefined;
  heli_damage = "none";

  if(!isDefined(level.helisoundvalues[heli_type])) {
    println("^5a speed vol/pitch parameter was not defined for heli_type '" + heli_type + "'.");

    return;
  }

  if(!isDefined(level.helisoundvalues[heli_type][heli_part])) {
    println("^5a speed vol/pitch parameter was not defined for heli_type '" + heli_type + "' and heli_part '" + heli_part + "'.");

    return;
  }

  while(isDefined(self)) {
    wait 0.05;
    max_speed_vol = level.helisoundvalues[heli_type][heli_part].speedvolumemax;
    min_vol = level.helisoundvalues[heli_type][heli_part].volumemin;
    max_vol = level.helisoundvalues[heli_type][heli_part].volumemax;
    max_speed_pitch = level.helisoundvalues[heli_type][heli_part].speedpitchmax;
    min_pitch = level.helisoundvalues[heli_type][heli_part].pitchmin;
    max_pitch = level.helisoundvalues[heli_type][heli_part].pitchmax;
    self.cur_speed = self getspeed() / 17.6;
    run_volume = scale_speed(self.idle_run_trans_speed, max_speed_vol, min_vol, max_vol, self.cur_speed);
    run_pitch = scale_speed(self.idle_run_trans_speed, max_speed_pitch, min_pitch, max_pitch, self.cur_speed);

    if(isDefined(self.should_not_play_sounds) && self.should_not_play_sounds) {
      if(isDefined(heli_bone.run)) {
        heli_bone.run stoploopsound(0.5);
        run_id = undefined;
      }

      self waittill("play_heli_sounds");
      continue;
    }

    if(!isDefined(run_id) && isDefined(heli_bone.run))
      run_id = heli_bone.run playloopsound(heli_bone.run.alias, 0.5);

    movement = self getnormalizedcameramovement();
    jet_stick_up = movement[0];

    if(jet_stick_up <= 0)
      jet_stick_up = 0;

    jet_stick_up = scale_speed(0, 1, 0.1, 1, jet_stick_up);
    jet_stick_up_rate = level.jet_stick_up_rate;

    if(isDefined(run_id) && isDefined(jet_stick_up) && isDefined(heli_bone.run))
      heli_bone.run setloopstate(heli_bone.run.alias, jet_stick_up, run_pitch, jet_stick_up_rate, level.jet_stick_pitch_up_rate);
  }
}

jet_turn_whine(heli_type, heli_part) {
  self endon("entityshutdown");

  while(!clienthassnapshot(0))
    wait 0.05;

  heli_bone = self.heli[heli_part];
  run_id = undefined;

  if(!isDefined(level.helisoundvalues[heli_type])) {
    println("^5a speed vol/pitch parameter was not defined for heli_type '" + heli_type + "'.");

    return;
  }

  if(!isDefined(level.helisoundvalues[heli_type][heli_part])) {
    println("^5a speed vol/pitch parameter was not defined for heli_type '" + heli_type + "' and heli_part '" + heli_part + "'.");

    return;
  }

  while(isDefined(self)) {
    if(isDefined(self.should_not_play_sounds) && self.should_not_play_sounds) {
      if(isDefined(heli_bone.run)) {
        heli_bone.run stoploopsound(0.5);
        run_id = undefined;
      }

      self waittill("play_heli_sounds");
      continue;
    }

    if(!isDefined(run_id) && isDefined(heli_bone.run))
      run_id = heli_bone.run playloopsound(heli_bone.run.alias, 0.5);

    angular_velocity = self.angles;
    turning_speed = abs(angular_velocity[2] / 90);
    jet_stick_vol = scale_speed(0, 1, 0, 1, turning_speed);
    jet_stick_pitch = scale_speed(0, 1, 0.9, 1, turning_speed);

    if(isDefined(run_id) && isDefined(jet_stick_vol) && isDefined(heli_bone.run))
      heli_bone.run setloopstate(heli_bone.run.alias, jet_stick_vol, jet_stick_pitch, 0.9);
  }
}

terrain_trace() {
  self endon("entityshutdown");
  trace = undefined;
  trace_ent = self;
  pre_terrain = undefined;
  next_terrain = undefined;
  pre_trace_real_ent = undefined;
  trace_real_ent = undefined;
  pre_origin = vectorscale((1, 1, 1), 100000.0);

  while(isDefined(self)) {
    wait(1 + randomfloatrange(0.0, 0.2));

    if(isDefined(self.should_not_play_sounds) && self.should_not_play_sounds) {
      if(isDefined(pre_trace_real_ent))
        pre_trace_real_ent stoploopsound();

      if(isDefined(trace_real_ent))
        trace_real_ent stoploopsound();

      self waittill("play_heli_sounds");
      continue;
    }

    if(distancesquared(pre_origin, trace_ent.origin) < 144) {
      continue;
    }
    pre_origin = trace_ent.origin;
    trace = tracepoint(trace_ent.origin, trace_ent.origin - vectorscale((0, 0, 1), 100000.0));
    trace_surface_type = trace["surfacetype"];

    if(!isDefined(trace)) {
      continue;
    }
    pre_terrain = next_terrain;
    next_terrain = trace_surface_type;

    if(!isDefined(pre_terrain) || !isDefined(next_terrain)) {
      continue;
    }
    if(!isDefined(self.surface_type[next_terrain]) || !isDefined(self.surface_type[pre_terrain])) {
      continue;
    }

    surf_type = self.surface_type[next_terrain];
    trace_real_ent = self.terrain_ent_array[surf_type];
    pre_surf_type = self.surface_type[pre_terrain];
    pre_trace_real_ent = self.terrain_ent_array[pre_surf_type];

    if(!isDefined(trace["position"])) {
      if(isDefined(pre_trace_real_ent))
        pre_trace_real_ent stoploopsound(0.5);

      continue;
    }

    trace_real_ent.origin = trace["position"];
    pre_trace_real_ent.origin = trace["position"];

    if(isDefined(surf_type)) {
      if(surf_type == pre_surf_type && pre_trace_real_ent isplayingloopsound()) {
        continue;
      }
      pre_trace_real_ent stoploopsound(0.5);
      trace_real_ent playloopsound(trace_real_ent.alias, 0.5);
    }
  }
}

update_helicopter_sounds() {
  if(isDefined(self.engine_damage_low) && self.engine_damage_low) {
    switch (self.vehicletype) {
      case "heli_hind_player":
        if(!isDefined(self.low_dmg))
          self thread heli_idle_run_transition("hind", "eng_dmg");

        self.low_dmg = 1;
        playsound(0, "veh_hind_alarm_damage_high", (0, 0, 0));
        level.helisoundvalues["hind"]["cockpit"].volumemax = 1;
        level.helisoundvalues["hind"]["ext_rotor"].pitchmax = 1.3;

        println("^5a activating heli sound damage stage 1");

        break;
      default:

        println("^5helicopter type: " + self.vehicletype + " vehicletype; has no helicopter damage sounds");

        break;
    }
  }

  if(isDefined(self.engine_damage_high) && self.engine_damage_high && isDefined(self.engine_damage_low) && !self.engine_damage_low) {
    switch (self.vehicletype) {
      case "heli_hind_player":
        level.helisoundvalues["hind"]["eng_dmg"].volumemax = 1;
        level.helisoundvalues["hind"]["ext_rotor"].pitchmax = 1.5;
        wait 0.1;
        level.helisoundvalues["hind"]["eng_dmg"].volumemin = 1;

        println("^5a activating heli sound damage stage 2");

        break;
      default:

        println("^5helicopter type: " + self.vehicletype + " vehicletype; has no helicopter damage sounds");

        break;
    }
  }

  if(isDefined(self.engine_damage_high) && self.engine_damage_high && isDefined(self.engine_damage_low) && self.engine_damage_low) {
    switch (self.vehicletype) {
      case "heli_hind_player":
        playsound(0, "veh_hind_alarm_damage_high", (0, 0, 0));
        level.helisoundvalues["hind"]["eng_dmg"].volumemax = 1;
        level.helisoundvalues["hind"]["ext_rotor"].pitchmax = 1.5;
        wait 0.1;
        level.helisoundvalues["hind"]["eng_dmg"].volumemin = 1;

        println("^5a activating heli sound damage stage 3");

        break;
      default:

        println("^5helicopter type: " + self.vehicletype + " vehicletype; has no helicopter damage sounds");

        break;
    }
  }

  if(isDefined(self.engine_damage_low) && !self.engine_damage_low && isDefined(self.engine_damage_high) && !self.engine_damage_high) {
    println("^5helicopter type: " + self.vehicletype + " vehicletype; Atempting to reset Defaults");

    switch (self.vehicletype) {
      case "heli_hind_player":
        init_heli_sound_values("hind", "cockpit", 95, 0.6, 0.8, 95, 1, 1.1);
        init_heli_sound_values("hind", "cockpit2", 95, 0.5, 0.8, 95, 1, 1.2);
        init_heli_sound_values("hind", "int_eng", 65, 0.5, 0.8, 65, 1, 1.1);
        init_heli_sound_values("hind", "int_eng2", 65, 0.4, 0.9, 65, 1, 1.3);
        init_heli_sound_values("hind", "eng_dmg", 40, 0.2, 0.4, 65, 1, 1.1);
        init_heli_sound_values("hind", "ext_rotor", 70, 0.5, 1, 70, 0.95, 1.1);

        println("^5a Setting Defaults ");

        break;
      default:

        println("^5helicopter type: " + self.vehicletype + " vehicletype; has no helicopter damage sounds");

        break;
    }
  }
}

veh_throttle() {
  return;
  vehicle = self;
  self.idle = spawn(0, self.origin, "script_origin");
  self.idle linkto(self, "tag_origin");
  self.offidle = spawn(0, self.origin, "script_origin");
  self.offidle linkto(self, "tag_origin");
  self.onlow = spawn(0, self.origin, "script_origin");
  self.onlow linkto(self, "tag_origin");
  self.offlow = spawn(0, self.origin, "script_origin");
  self.offlow linkto(self, "tag_origin");
  self.onmid = spawn(0, self.origin, "script_origin");
  self.onmid linkto(self, "tag_origin");
  self.offmid = spawn(0, self.origin, "script_origin");
  self.offmid linkto(self, "tag_origin");
  self.onhigh = spawn(0, self.origin, "script_origin");
  self.onhigh linkto(self, "tag_origin");
  self.offhigh = spawn(0, self.origin, "script_origin");
  self.offhigh linkto(self, "tag_origin");
  idle = self.idle playloopsound("blk_car_idle_plr", 1);
  self thread playdrivesounds(idle, -1, 0, 0.16, 0.274, 1, 0.133);
  offidle = self.offidle playloopsound("blk_car_idle_plr", 1);
  self thread playdrivesounds(offidle, -1, 0, 0.16, 0.274, 0, 0.133);
  onlow = self.onlow playloopsound("blk_car_onlow_plr", 1);
  setsoundvolume(onlow, 0);
  self thread playdrivesounds(onlow, 0.16, 0.274, 0.38, 0.55, 1, 0.343);
  offlow = self.offlow playloopsound("blk_car_offlow_plr", 1);
  setsoundvolume(offlow, 0);
  self thread playdrivesounds(offlow, 0.16, 0.274, 0.38, 0.55, 0, 0.343);
  onmid = self.onmid playloopsound("blk_car_onmid_plr", 1);
  setsoundvolume(onmid, 0);
  self thread playdrivesounds(onmid, 0.38, 0.55, 0.71, 0.84, 1, 0.459);
  offmid = self.offmid playloopsound("blk_car_offmid_plr", 1);
  setsoundvolume(offmid, 0);
  self thread playdrivesounds(offmid, 0.38, 0.55, 0.71, 0.84, 0, 0.459);
  onhigh = self.onhigh playloopsound("blk_car_onhigh_plr", 1);
  setsoundvolume(onhigh, 0);
  self thread playdrivesounds(onhigh, 0.71, 0.84, 1.4, 1.5, 1, 0.684);
  offhigh = self.offhigh playloopsound("blk_car_offhigh_plr", 1);
  setsoundvolume(offhigh, 0);
  self thread playdrivesounds(offhigh, 0.71, 0.84, 1.4, 1.5, 0, 0.684);
}

playdrivesounds(sound, fadeinstart, startfullthreshold, endfullthreshold, fadeoutend, onload, throttlepitchref) {
  loadsmoothing = 0.04;
  throttlesmoothing = 0.025;
  currentloadsmoothing = 0.04;
  currentthrottlesmoothing = 0.025;
  throttle = 0;
  loadfilter = 0;
  load = 0;
  globalvolume = 0;
  maxspeed = 1500;
  self.onground = 1;
  speedpercentage = 1;
  throttlepercentage = 1;
  onloadprint = 0;
  offloadprint = 0;
  currentgear = 1;
  nextgear = 2;
  upshiftpoint = 2200;
  downshiftpoint = 1300;
  throttlesmoothingstart = throttlesmoothing;
  usesgears = 1;

  while(true) {
    wait 0.0000001;
    throttleinput = self getthrottle();

    if(self iswheelcolliding("back_left") && self iswheelcolliding("back_right")) {
      self.onground = 1;
      throttlesmoothing = currentthrottlesmoothing;
      loadsmoothing = currentloadsmoothing;
      currentloadsmoothing = throttlesmoothing;
      currentloadsmoothing = loadsmoothing;
    } else {
      self.onground = 0;
      loadsmoothing = 0.08;
      throttlesmoothing = 0.04;
      throttlesmoothing = currentthrottlesmoothing * 2;
      loadsmoothing = currentloadsmoothing * 2;
      throttleinput = throttleinput + 0.15;
    }

    fakerpm = scale_speed(0, 1, 0, 9000, throttle);

    if(usesgears) {
      if(fakerpm > upshiftpoint && currentgear + 1 == nextgear && currentgear != 7) {
        currentgear = currentgear + 1;
        nextgear = currentgear + 1;
        downshiftpoint = upshiftpoint - 1000;
        upshiftpoint = 5000 + currentgear * 1000 / 2;
        currentthrottlesmoothing = throttlesmoothingstart + currentgear * 0.002;
        throttleinput = 0;
      } else if(fakerpm < downshiftpoint && currentgear != 1) {
        currentgear = currentgear - 1;
        upshiftpoint = 5000 + currentgear * 1000 / 2;
        downshiftpoint = upshiftpoint - 1000;
        nextgear = currentgear + 1;
        currentthrottlesmoothing = throttlesmoothingstart - currentgear * 0.002;
      } else {
        loadsmoothing = currentloadsmoothing;
        throttlesmoothing = currentthrottlesmoothing;
      }
    }

    curspeed = self getspeed();
    maxspeed = self getmaxspeed();
    speedratio = int(curspeed / maxspeed * 100 * throttle);
    previousthrottle = throttle;
    throttle = throttle * (1 - throttlesmoothing) + throttleinput * throttlesmoothing;
    loadfilter = loadfilter * (1 - loadsmoothing) + (throttle - previousthrottle) * loadsmoothing;
    load = 10 * loadfilter + 0.5;

    if(throttle < 0.14)
      throttle = 0.14;

    sound_pitch = throttle / throttlepitchref;
    crossfadein = scale_speed(fadeinstart, startfullthreshold, 0, 1, throttle);
    crossfadeout = scale_speed(endfullthreshold, fadeoutend, 1, 0, throttle);
    speedpercentage = scale_speed(0, maxspeed, 1, 100, curspeed);
    throttlepercentage = scale_speed(0.14, 1, 1, 100, throttle);
    throttletospeed = speedpercentage / throttlepercentage;

    if(onload) {
      globalvolume = scale_speed(0.433, 0.562, 0, 1, load);
      onloadprint = globalvolume;
    } else {
      globalvolume = scale_speed(0.433, 0.534, 0.6, 0, load);
      offloadprint = globalvolume;
    }

    fadevolume = 0.0;

    if(throttle >= fadeinstart && throttle <= startfullthreshold)
      fadevolume = sin(crossfadein * 90);
    else if(throttle >= startfullthreshold && throttle <= endfullthreshold)
      fadevolume = 1.0;
    else if(throttle >= endfullthreshold && throttle <= fadeoutend)
      fadevolume = sin(crossfadeout * 90);

    setsoundpitch(sound, sound_pitch);
    setsoundvolume(sound, fadevolume * (globalvolume * globalvolume * globalvolume));

    printthrottle = int(throttle * 1000);
    printload = int(load * 1000);
    printcurspeed = int(curspeed);
    onloadprint = int(onloadprint * 100);
    offloadprint = int(offloadprint * 100);
    printfakerpm = int(fakerpm);
    print3d(self.origin + vectorscale((0, 0, -1), 100.0) + anglestoforward(self.angles) * 2000, "SPEED- " + printcurspeed + " SPEED RATIO- " + speedratio, vectorscale((0, 1, 0), 0.8), 1, 3, 1);
    print3d(self.origin + anglestoforward(self.angles) * 2000, "LOAD- " + printload + " THROTTLE- " + printthrottle, vectorscale((0, 1, 0), 0.8), 1, 3, 1);
    print3d(self.origin + vectorscale((0, 0, 1), 100.0) + anglestoforward(self.angles) * 2000, "FAKE RPM- " + printfakerpm + " GEAR " + currentgear, vectorscale((0, 1, 0), 0.8), 1, 3, 1);
    print3d(self.origin + vectorscale((0, 0, 1), 200.0) + anglestoforward(self.angles) * 2000, "ONGROUND- " + self.onground, vectorscale((0, 1, 0), 0.8), 1, 3, 1);
    print3d(self.origin + vectorscale((0, 0, 1), 300.0) + anglestoforward(self.angles) * 2000, "THROTTLE/SPEED- " + throttletospeed, vectorscale((0, 1, 0), 0.8), 1, 3, 1);
    print3d(self.origin + vectorscale((0, 0, 1), 400.0) + anglestoforward(self.angles) * 2000, "SPEED%- " + speedpercentage, vectorscale((0, 1, 0), 0.8), 1, 3, 1);
    print3d(self.origin + vectorscale((0, 0, 1), 500.0) + anglestoforward(self.angles) * 2000, "THROTTLE%- " + throttlepercentage, vectorscale((0, 1, 0), 0.8), 1, 3, 1);
    print3d(self.origin + vectorscale((0, 0, 1), 600.0) + anglestoforward(self.angles) * 2000, "ONVOL- " + onloadprint, vectorscale((0, 1, 0), 0.8), 1, 3, 1);
    print3d(self.origin + vectorscale((0, 0, 1), 700.0) + anglestoforward(self.angles) * 2000, "OFFVOL- " + offloadprint, vectorscale((0, 1, 0), 0.8), 1, 3, 1);

  }
}

drone_up_down_transition() {
  self endon("entityshutdown");
  qr_ent_up = spawn(0, self.origin, "script_origin");
  qr_ent_down = spawn(0, self.origin, "script_origin");
  qr_ent_either = spawn(0, self.origin, "script_origin");
  qr_ent_up thread qr_ent_cleanup(self);
  qr_ent_down thread qr_ent_cleanup(self);
  qr_ent_either thread qr_ent_cleanup(self);
  self.qrdrone_z_difference = 0;
  down = qr_ent_down playloopsound("veh_qrdrone_move_down");
  qr_ent_down setloopstate("veh_qrdrone_move_down", 0, 0);
  up = qr_ent_up playloopsound("veh_qrdrone_move_up");
  qr_ent_up setloopstate("veh_qrdrone_move_up", 0, 0);
  either = qr_ent_either playloopsound("veh_qrdrone_vertical");
  qr_ent_either setloopstate("veh_qrdrone_vertical", 0, 0);
  tag = "tag_origin";
  qr_ent_up linkto(self, tag);
  qr_ent_down linkto(self, tag);
  qr_ent_either linkto(self, tag);
  self thread drone_button_watch();

  while(true) {
    last_pos = self.origin[2];
    wait 0.1;
    self.qrdrone_z_difference = last_pos - self.origin[2];

    if(self.qrdrone_z_difference < 0) {
      up_difference = self.qrdrone_z_difference * -1;
      run_volume_up = scale_speed(5, 40, 0, 1, up_difference);
      run_pitch_up = scale_speed(5, 40, 0.9, 1.1, up_difference);
      run_volume_either = scale_speed(5, 50, 0, 1, up_difference);
      run_pitch_either = scale_speed(5, 50, 0.9, 1.1, up_difference);
    } else {
      run_volume_up = 0;
      run_pitch_up = 1;
      run_volume_either = scale_speed(5, 50, 0, 1, self.qrdrone_z_difference);
      run_pitch_either = scale_speed(5, 50, 0.95, 0.8, self.qrdrone_z_difference);
    }

    run_volume_down = scale_speed(5, 50, 0, 1, self.qrdrone_z_difference);
    run_pitch_down = scale_speed(5, 50, 1, 0.8, self.qrdrone_z_difference);
    qr_ent_down setloopstate("veh_qrdrone_move_down", run_volume_down, run_pitch_down, 1);
    qr_ent_up setloopstate("veh_qrdrone_move_up", run_volume_up, run_pitch_up, 1);
    qr_ent_either setloopstate("veh_qrdrone_vertical", run_volume_either, run_pitch_either, 1);
  }
}

qr_ent_cleanup(veh_ent) {
  veh_ent waittill("entityshutdown");
  self delete();
}

drone_rotate_angle(heli_type, heli_part) {
  self endon("entityshutdown");
  qr_ent_angle = spawn(0, self.origin, "script_origin");
  qr_ent_angle thread qr_ent_cleanup(self);
  angle = qr_ent_angle playloopsound("veh_qrdrone_idle_rotate");
  setsoundvolume(angle, 0);
  tag = "tag_origin";
  qr_ent_angle linkto(self, tag);

  while(true) {
    last_angle = abs(self.angles[1]);
    wait 0.1;
    turning_speed = last_angle - abs(self.angles[1]);
    abs_turning_speed = abs(turning_speed);
    jet_stick_vol = scale_speed(0, 5, 0, 0.4, abs_turning_speed);
    jet_stick_pitch = scale_speed(0, 4, 0.9, 1.05, abs_turning_speed);
    qr_ent_angle setloopstate("veh_qrdrone_idle_rotate", jet_stick_vol, jet_stick_pitch, 2.5);
  }
}

drone_button_watch() {
  self endon("entityshutdown");
  player = getlocalplayers()[0];
  return_to_zero = 1;

  println(self.qrdrone_z_difference);

  while(true) {
    if(abs(self.qrdrone_z_difference) > 5 && return_to_zero) {
      self playsound(0, "veh_qrdrone_move_start");
      return_to_zero = 0;
    } else if(abs(self.qrdrone_z_difference) < 5 && !return_to_zero)
      return_to_zero = 1;

    wait 0.05;
  }
}

#using_animtree("vehicles");

flying_booster_rotate_update() {
  self endon("entityshutdown");
  left_anim = % veh_anim_v78_vtol_engine_left;
  right_anim = % veh_anim_v78_vtol_engine_right;
  self setanim(left_anim, 1, 0, 0);
  self setanim(right_anim, 1, 0, 0);
  prev_yaw = self.angles[1];
  delta_yaw = 0;

  while(true) {
    speed = self getspeed();

    if(isDefined(self.booster_speed_override))
      speed = self.booster_speed_override;

    anim_time = 0.5;

    if(speed > 0)
      anim_time = anim_time - speed / 1200 * 0.5;
    else
      anim_time = anim_time + speed * -1 / 1200 * 0.5;

    frame_delta_yaw = angleclamp180(self.angles[1] - prev_yaw) / 3;
    frame_delta_yaw = frame_delta_yaw < 0.1 ? 0 : frame_delta_yaw;
    delta_yaw = angleclamp180(delta_yaw + (frame_delta_yaw - delta_yaw) * 0.1);
    delta_yaw = clamp(delta_yaw, -0.1, 0.1);
    prev_yaw = self.angles[1];
    left_anim_time = clamp(anim_time + delta_yaw, 0, 1);
    right_anim_time = clamp(anim_time - delta_yaw, 0, 1);
    self setanimtime(left_anim, left_anim_time);
    self setanimtime(right_anim, right_anim_time);
    wait 0.01;
  }
}