/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\_swimming.csc
***************************************/

#include clientscripts\_utility;
#include clientscripts\_audio;
#include clientscripts\_ambientpackage;
#include clientscripts\_swimming;

main() {
  if(isDefined(level.swimmingfeature) && !level.swimmingfeature) {
    return;
  }
  if(level.createfx_enabled) {
    return;
  }
  settings();
  fx();
  anims();
  wait 0.01;
  player = level.localplayers[0];

  if(isDefined(player))
    player on_player_connect(0);
  else
    onplayerconnect_callback(::on_player_connect);

  register_clientflag_callback("player", level.cf_player_underwater, ::player_underwater_flag_handler);
}

settings() {
  level._swimming = spawnstruct();
  level._swimming.swim_times[0] = 0;
  level._swimming.swim_times[1] = 15;
  level._swimming.swim_times[2] = 25;
  level._swimming.swim_times[3] = 32;
  level._swimming.swim_times[4] = 37;
  level._swimming.num_phases = level._swimming.swim_times.size - 1;
  level._swimming.drown_reset_times[0] = 1;
  level._swimming.drown_reset_times[1] = 2;
  level._swimming.drown_reset_times[2] = 2;
  level._swimming.drown_reset_times[3] = 4;
  level._swimming.drown_reset_times[4] = 4;
  self._swimming.is_swimming_enabled = 1;
  level._swimming.is_overriding_swim_movement = 0;
  level._swimming.override_swim_movement = (0, 0, 0);
  level._swimming.swim_anim_rate = 1.0;
}

player_underwater_flag_handler(localclientnum, set, newent) {
  if(set)
    self clientscripts\_swimming::underwater();
  else
    self clientscripts\_swimming::surface();
}

fx() {
  level._effect["underwater"] = loadfx("env/water/fx_water_particles_surface_fxr");
  level._effect["deep"] = loadfx("env/water/fx_water_particle_dp_spawner");
  level._effect["drowning"] = loadfx("bio/player/fx_player_underwater_bubbles_drowning");
  level._effect["exhale"] = loadfx("bio/player/fx_player_underwater_bubbles_exhale");
  level._effect["hands_bubbles_left"] = loadfx("bio/player/fx_player_underwater_bubbles_hand_fxr");
  level._effect["hands_bubbles_right"] = loadfx("bio/player/fx_player_underwater_bubbles_hand_fxr_right");
  level._effect["hands_debris_left"] = loadfx("bio/player/fx_player_underwater_hand_emitter");
  level._effect["hands_debris_right"] = loadfx("bio/player/fx_player_underwater_hand_emitter_right");
  level._effect["sediment"] = loadfx("bio/player/fx_player_underwater_sediment_spawner");
  level._effect["wake"] = loadfx("bio/player/fx_player_water_swim_wake");
  level._effect["ripple"] = loadfx("bio/player/fx_player_water_swim_ripple");
}

#using_animtree("player");

anims() {
  level._swimming.anims["breaststroke"][0] = % viewmodel_swim_breaststroke_a;
  level._swimming.anims["breaststroke"][1] = % viewmodel_swim_breaststroke_b;
  level._swimming.anims["breaststroke"][2] = % viewmodel_swim_breaststroke_c;
  level._swimming.anims["backwards"][0] = % viewmodel_swim_backwards_a;
  level._swimming.anims["backwards"][1] = % viewmodel_swim_backwards_b;
  level._swimming.anims["backwards"][2] = % viewmodel_swim_backwards_c;
  level._swimming.anims["left"][0] = % viewmodel_swim_to_left;
  level._swimming.anims["right"][0] = % viewmodel_swim_to_right;
  level._swimming.anims["tread"][0] = % viewmodel_swim_tread_water;
}

on_player_connect(clientnum) {
  while(!clienthassnapshot(clientnum))
    wait 0.05;

  wait 0.35;
  self init_player();
  self thread on_save_restore();

  println("^4_swimming - client: client player connect");

  self thread enable_swimming();
  self thread disable_swimming();
  self thread toggle_arms();
  self thread swimmingdrown();
  self thread waterleveltag(clientnum);
  self thread toggle_swimming();

  if(self swimming())
    self notify("swimming_begin");
}

on_save_restore() {
  while(true) {
    level waittill("save_restore");
    self._swimming.is_underwater = 0;
    self notify("surface");

    println("^4_swimming - client: save restore");

    if(self swimming())
      self notify("swimming_begin");
  }
}

init_player() {
  if(!isDefined(self._swimming)) {
    println("^4_swimming - client: defining self._swimming.");

    self._swimming = spawnstruct();
  }

  self._swimming.is_arms_enabled = 1;
  self._swimming.is_swimming = 0;
  self._swimming.is_drowning = 0;
  self._swimming.is_underwater = 0;
  self._swimming.resetting_vision = 0;
  self._swimming.surface_vox = "chr_swimming_vox_surface_default";
  self._swimming.vec_movement = (0, 0, 0);
  self notify("swimming_init");
}

disable_swimming() {
  self endon("disconnect");

  while(true) {
    level waittill("_swimming:disable");

    println("^4_swimming - client: swimming disabled");

    self notify("swimming_end");
    level._swimming.is_swimming_enabled = 0;
  }
}

enable_swimming() {
  self endon("disconnect");

  while(true) {
    level waittill("_swimming:enable");

    println("^4_swimming - client: swimming enabled");

    if(self swimming())
      self notify("swimming_begin");

    level._swimming.is_swimming_enabled = 1;
  }
}

hide_arms() {
  self endon("disconnect");

  while(true) {
    level waittill("_swimming:hide_arms");
    self._swimming.is_arms_enabled = 0;
    self notify("_swimming:hide_arms");

    println("^4_swimming - client: hide arms");

  }
}

show_arms() {
  self endon("disconnect");

  while(true) {
    level waittill("_swimming:show_arms");
    self._swimming.is_arms_enabled = 1;
    self notify("_swimming:show_arms");

    println("^4_swimming - client: show arms");

  }
}

set_default_water_for_settings() {
  setwaterfog(0, 119.8, 0, -70.13, 0.149, 0.145, 0.118, 1.33, 0.212, 0.2, 0.157, -0.269, -0.506, 0.82, 0, 91.86, 0.994);
}

toggle_swimming() {
  self endon("disconnect");

  while(true) {
    self waittill("swimming_begin");
    self._swimming.is_swimming = 1;

    println("^4_swimming - client: swimming begin");

    self thread swimmingtracker();
    self swimmingfx();
    self waittill("swimming_end");
    self._swimming.is_swimming = 0;

    println("^4_swimming - client: swimming end");

  }
}

toggle_arms() {
  self endon("disconnect");
  self thread show_arms();
  self thread hide_arms();

  while(true) {
    waitforclient(0);
    self waittill_any("underwater", "_swimming:show_arms");
    self thread swimmingarms();
    self waittill_any("surface", "swimming_end", "_swimming:hide_arms");
  }
}

swimmingtracker() {
  self endon("disconnect");
  self endon("swimming_end");

  while(true) {
    waitforclient(0);

    if(level._swimming.is_swimming_enabled)
      self._swimming.current_depth = get_swimming_depth();
    else
      self._swimming.current_depth = 0;

    wait 0.1;
  }
}

underwater() {
  if(!self._swimming.is_underwater) {
    self._swimming.reset_time = 0;
    self._swimming.is_underwater = 1;
    self._swimming.surface_vox = "chr_swimming_vox_surface_default";
    self notify("underwater");

    println("^4_swimming - client: underwater");

  }
}

surface() {
  if(self._swimming.is_underwater) {
    self._swimming.is_underwater = 0;
    self notify("surface");

    println("^4_swimming - client: surface");

  }
}

get_swimming_depth() {
  eye_height = self get_eye()[2];
  water_height = getwaterheight(self.origin);
  return water_height - eye_height;
}

swimmingdrown() {
  self endon("disconnect");
  phase = 0;
  last_phase = 0;
  self._swimming.swim_time = 0;
  self._swimming.reset_time = 0;

  while(true) {
    wait 0.2;
    waitforclient(0);

    if(!self._swimming.is_underwater && !self._swimming.resetting_vision) {
      self._swimming.resetting_vision = 1;
      self thread swimmingdrownvision(0, last_phase);
    }

    phase = self advance_drowning_phase(last_phase);

    if(phase != last_phase) {
      self notify("drowning");
      self thread swimmingdrowndamage(phase);
      self thread swimmingdrownvision(phase, last_phase);
      self thread swimmingdrownfx(phase);
      self.drowning_phase = phase;
      last_phase = phase;

      println("^4_swimming - client: phase " + phase);

    }
  }
}

advance_drowning_phase(phase) {
  if(getdvarint(#"_id_79A1DCC2") == 1)
    return 0;

  if(isDefined(level._disable_drowning) && level._disable_drowning)
    return 0;

  t_delta = swimming_get_time();

  if(self._swimming.is_underwater) {
    self._swimming.swim_time = self._swimming.swim_time + t_delta;

    for(phase = level._swimming.num_phases; phase >= 0; phase--) {
      if(self._swimming.swim_time >= get_phase_time(phase))
        return phase;
    }
  } else {
    self._swimming.reset_time = self._swimming.reset_time + t_delta;

    if(self._swimming.reset_time >= get_reset_time(phase)) {
      self._swimming.swim_time = 0;
      return 0;
    }
  }

  return phase;
}

swimming_get_time() {
  t_now = getrealtime();
  t_delta = 0;

  if(isDefined(self._swimming.last_get_time)) {
    t_delta = t_now - self._swimming.last_get_time;

    if(t_delta >= 500) {
      println("^4_swimming - client: IGNORING TIME (" + t_delta + ")");

      t_delta = 0;
    }
  }

  self._swimming.last_get_time = t_now;
  return t_delta;
}

get_phase_time(phase) {
  return level._swimming.swim_times[phase] * 1000;
}

get_reset_time(phase) {
  return level._swimming.drown_reset_times[phase] * 1000;
}

swimmingdrowndamage(phase) {
  self endon("disconnect");
  self notify("stop_swimming_drown_damage");
  self endon("stop_swimming_drown_damage");
  self endon("surface");
  self endon("swimming_end");
  pause = 1;
  rumble = undefined;

  if(phase == 1 || phase == 2) {
    pause = 3;
    rumble = "damage_light";
  } else if(phase == 3)
    rumble = "damage_heavy";

  while(isDefined(rumble)) {
    self playrumbleonentity(self getlocalclientnumber(), rumble);
    wait(pause);
  }
}

swimmingdrownvision(phase, last_phase) {
  if(phase == 0) {
    println("^4_swimming - client: resetting client-side blur.");

    self setblur(0, level._swimming.drown_reset_times[last_phase]);

    if(self._swimming.is_drowning)
      self._swimming.is_drowning = 0;
  } else {
    self._swimming.resetting_vision = 0;

    if(phase == 2) {
      println("^4_swimming - client: setting client-side blur.");

      self setblur(10, level._swimming.swim_times[4] - level._swimming.swim_times[2]);
    } else if(phase == 3) {
      println("^4_swimming - client: setting drowning vision set.");

      self._swimming.is_drowning = 1;
    }
  }
}

swimmingfx() {
  self thread underwaterfx();
}

waterleveltag(clientnum) {
  self endon("disconnect");
  self._swimming.water_level_fx_tag = spawn(clientnum, self.origin, "script_model");
  self._swimming.water_level_fx_tag setmodel("tag_origin");

  while(true) {
    waitforclient(clientnum);

    for(last_org = (0, 0, 0); self._swimming.is_swimming; last_org = new_org) {
      waitforclient(clientnum);
      self._swimming.water_level_fx_tag.origin = (self.origin[0], self.origin[1], getwaterheight(self.origin));
      new_org = self._swimming.water_level_fx_tag.origin;

      if(last_org != (0, 0, 0) && new_org != last_org) {
        self._swimming.vec_movement = new_org - last_org;
        self._swimming.water_level_fx_tag.angles = vectortoangles(self._swimming.vec_movement * -1);
      } else
        self._swimming.is_stationary = 1;

      wait 0.1;
    }

    wait 0.1;
  }
}

underwaterfx() {
  self endon("swimming_end");
  fx_handle_underwater = undefined;
  fx_handle_deep = undefined;
  fx_handle_hand_le = undefined;
  fx_handle_hand_rt = undefined;

  while(true) {
    self waittill("swim_arms_spawned");
    self thread exhalefx();
    self thread debrisfx();
    self thread sedimentfx();
    fx_handle_hand_le = playfxontag(self getlocalclientnumber(), level._effect["hands_bubbles_left"], self._swimming_arms, "J_WristTwist_LE");
    fx_handle_hand_rt = playfxontag(self getlocalclientnumber(), level._effect["hands_bubbles_right"], self._swimming_arms, "J_WristTwist_RI");

    if(self._swimming.current_depth > 500) {
      if(isDefined(fx_handle_underwater))
        deletefx(self getlocalclientnumber(), fx_handle_underwater, 1);

      fx_handle_deep = playfxontag(self getlocalclientnumber(), level._effect["deep"], self._swimming_arms, "tag_origin");

      println("^4_swimming - client: deep fx");

    } else {
      if(isDefined(fx_handle_deep))
        deletefx(self getlocalclientnumber(), fx_handle_deep, 0);

      fx_handle_underwater = playfxontag(self getlocalclientnumber(), level._effect["underwater"], self._swimming.water_level_fx_tag, "tag_origin");

      println("^4_swimming - client: underwater fx");

    }

    self thread underwaterfxdelete(fx_handle_underwater, fx_handle_deep, fx_handle_hand_le, fx_handle_hand_rt);
  }
}

underwaterfxdelete(fx_handle_underwater, fx_handle_deep, fx_handle_hand_le, fx_handle_hand_rt) {
  self waittill_any("surface", "swimming_end");
  waitforclient(0);

  if(isDefined(fx_handle_underwater))
    deletefx(self getlocalclientnumber(), fx_handle_underwater, 1);

  if(isDefined(fx_handle_deep))
    deletefx(self getlocalclientnumber(), fx_handle_deep, 0);

  if(isDefined(fx_handle_hand_le))
    deletefx(self getlocalclientnumber(), fx_handle_hand_le, 1);

  if(isDefined(fx_handle_hand_rt))
    deletefx(self getlocalclientnumber(), fx_handle_hand_rt, 1);
}

exhalefx() {
  self endon("disconnect");
  self endon("surface");
  self endon("swimming_end");
  self endon("drowning");
  wait 3;

  while(isDefined(self._swimming_arms)) {
    waitforclient(0);
    playfxontag(self getlocalclientnumber(), level._effect["exhale"], self._swimming_arms, "tag_origin");
    wait(randomfloatrange(2.5, 3.5));
  }
}

swimmingdrownfx(phase) {
  if(phase == 3) {
    if(isDefined(self._swimming_arms))
      playfxontag(self getlocalclientnumber(), level._effect["drowning"], self._swimming_arms, "tag_origin");
  }
}

debrisfx() {
  self endon("disconnect");
  self endon("surface");
  self endon("swimming_end");

  while(isDefined(self._swimming_arms)) {
    fx_handle_hand_le = playfxontag(self getlocalclientnumber(), level._effect["hands_debris_left"], self._swimming_arms, "J_WristTwist_LE");
    fx_handle_hand_rt = playfxontag(self getlocalclientnumber(), level._effect["hands_debris_right"], self._swimming_arms, "J_WristTwist_RI");
    self thread killunderwaterfx(fx_handle_hand_le, 3);
    self thread killunderwaterfx(fx_handle_hand_rt, 3);
    wait 1.5;
  }
}

sedimentfx() {
  self endon("disconnect");
  self endon("surface");
  self endon("swimming_end");

  while(true) {
    player_angles = self getplayerangles();
    player_forward = anglestoforward(player_angles);
    fx_pos = self getorigin();
    fx_handle = playfx(self getlocalclientnumber(), level._effect["sediment"], fx_pos);
    self thread killunderwaterfx(fx_handle, 10);
    wait 1;
  }
}

killunderwaterfx(fx_handle, time_out) {
  self endon("disconnect");
  endon_string = get_kill_fx_endon();
  self endon(endon_string);
  self thread notify_delay(endon_string, time_out);
  self waittill_any("surface", "swimming_end");
  waitforclient(0);

  if(isDefined(fx_handle))
    deletefx(self getlocalclientnumber(), fx_handle, 1);
}

get_kill_fx_endon() {
  if(!isDefined(level._swimming.fx_num))
    level._swimming.fx_num = 0;
  else
    level._swimming.fx_num++;

  endon_string = "swimmin_fx_" + level._swimming.fx_num;
  return endon_string;
}

onwaterfx() {
  self endon("disconnect");
  self endon("swimming_end");

  while(true) {
    if(!self._swimming.is_underwater) {
      if(length(self._swimming.vec_movement) > 0.4) {
        self onwaterwakefxspawn();
        self onwaterripplefxdelete();
      } else {
        self onwaterwakefxdelete();
        self onwaterripplefxspawn();
      }
    }

    wait 0.1;
  }
}

onwaterwakefxspawn() {
  if(!isDefined(self._swimming.fx_handle_wake)) {
    self notify("new_on_water_fx");

    println("^4_swimming - client: spawning wake");

    self._swimming.fx_handle_wake = playfxontag(self getlocalclientnumber(), level._effect["wake"], self._swimming.water_level_fx_tag, "tag_origin");
    self thread onwaterwakefxdeletewhendone();
  }
}

onwaterwakefxdeletewhendone() {
  self endon("new_on_water_fx");
  self waittill_any("underwater", "swimming_end");
  self onwaterwakefxdelete();
}

onwaterwakefxdelete() {
  if(isDefined(self._swimming.fx_handle_wake)) {
    println("^4_swimming - client: deleting wake");

    deletefx(self getlocalclientnumber(), self._swimming.fx_handle_wake, 0);
    self._swimming.fx_handle_wake = undefined;
  }
}

onwaterripplefxspawn() {
  if(!isDefined(self._swimming.fx_handle_ripple)) {
    self notify("new_on_water_fx");

    println("^4_swimming - client: spawning ripple");

    self._swimming.fx_handle_ripple = playfxontag(self getlocalclientnumber(), level._effect["ripple"], self._swimming.water_level_fx_tag, "tag_origin");
    self thread onwaterripplefxdeletewhendone();
  }
}

onwaterripplefxdeletewhendone() {
  self endon("new_on_water_fx");
  self waittill_any("underwater", "swimming_end");
  self onwaterripplefxdelete();
}

onwaterripplefxdelete() {
  if(isDefined(self._swimming.fx_handle_ripple)) {
    println("^4_swimming - client: deleting ripple");

    deletefx(self getlocalclientnumber(), self._swimming.fx_handle_ripple, 0);
    self._swimming.fx_handle_ripple = undefined;
  }
}

swimmingarmsspawn() {
  self endon("disconnect");
  self endon("swimming_end");
  self endon("surface");

  println("^4_swimming - client: swimmingArmsSpawn");

  if(!self._swimming.is_underwater)
    self waittill("underwater");

  if(!self._swimming.is_arms_enabled)
    self waittill("_swimming:show_arms");

  self thread swimmingarmshide();

  println("^4_swimming - client: spawning arms");

  self._swimming_arms = spawn_player_arms();
  self._swimming_arms linktocamera();
  self notify("swim_arms_spawned");
  wait 0.2;

  println("^4_swimming - client: linking arms");

  self._swimming_arms useanimtree(#animtree);
}

swimmingarmshide() {
  self endon("disconnect");
  msg = self waittill_any_return("swimming_end", "surface", "_swimming:hide_arms");

  if(msg == "_swimming:hide_arms")
    self endon("_swimming:show_arms");
  else
    self endon("underwater");

  self._swimming_arms waittillmatch("swimming_anim", "end");
  self._swimming_arms delete();
}

swimmingarms() {
  self endon("disconnect");
  self endon("swimming_end");
  self endon("surface");
  self swimmingarmsspawn();
  self._swimming_arms endon("death");
  new_swim_state = 100;

  while(true) {
    waitforclient(0);
    move = self getnormalizedmovement();

    if(level._swimming.is_overriding_swim_movement)
      move = level._swimming.override_swim_movement;

    len = length(move);
    old_swim_state = new_swim_state;

    if(len < 0.5)
      new_swim_state = 0;
    else if(abs(move[0]) > abs(move[1])) {
      if(move[0] > 0)
        new_swim_state = 1;
      else
        new_swim_state = 2;
    } else if(move[1] < 0)
      new_swim_state = 3;
    else
      new_swim_state = 4;

    rand_anim = random(level._swimming.anims["tread"]);

    switch (new_swim_state) {
      case 100:
        break;
      case 0:

        println("_swimming: swim idle");

        rand_anim = random(level._swimming.anims["tread"]);
        break;
      case 1:

        println("_swimming: swim forward");

        rand_anim = random(level._swimming.anims["breaststroke"]);
        break;
      case 2:

        println("_swimming: swim backwards");

        rand_anim = random(level._swimming.anims["backwards"]);
        break;
      case 3:

        println("_swimming: swim left");

        rand_anim = random(level._swimming.anims["left"]);
        break;
      case 4:

        println("_swimming: swim right");

        rand_anim = random(level._swimming.anims["right"]);
        break;
    }

    self._swimming_arms.current_anim = rand_anim;
    self._swimming_arms setflaggedanim("swimming_anim", rand_anim, 1, 0.2, level._swimming.swim_anim_rate);
    self._swimming_arms waittillmatch("swimming_anim", "end");
    self._swimming_arms clearanim(rand_anim, 0.0);
  }
}