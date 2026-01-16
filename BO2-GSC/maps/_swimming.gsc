/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_swimming.gsc
**************************************/

#include maps\_utility;
#include common_scripts\utility;
#include maps\_swimming;

main() {
  if(is_false(level.swimmingfeature)) {
    return;
  }
  settings();
  enable();
  anims();
  fx();
  setdvar("player_swimTime", 1000);
  onplayerconnect_callback(::on_player_connect);
  onsaverestored_callback(::on_save_restored);
}

enable_swimming() {
  assert(isDefined(self._swimming), "swimming feature has not been initialized. Call _swimming::main to enable this feature.");
  self maps\_swimming::enable();
}

disable_swimming() {
  assert(isDefined(self._swimming), "swimming feature has not been initialized. Call _swimming::main to enable this feature.");
  self maps\_swimming::disable();
}

hide_swimming_arms() {
  self clientnotify("_swimming:hide_arms");
}

show_swimming_arms() {
  self clientnotify("_swimming:show_arms");
}

set_swimming_depth_of_field(toggle, set_values, near_start, near_end, far_start, far_end, near_blur, far_blur) {
  assert(isDefined(toggle), "toggle must be set to true or false");

  if(toggle) {
    level._swimming.toggle_depth_of_field = 1;

    println("depth of field enabled");

    if(isDefined(set_values) && set_values) {
      println("DOF enabled and values are being overwritten");

      assert(isDefined(near_start), "Depth of Field value near_start undefined");
      assert(isDefined(near_end), "Depth of Field value near_end undefined");
      assert(isDefined(far_start), "Depth of Field value far_start undefined");
      assert(isDefined(far_end), "Depth of Field value far_end undefined");
      assert(isDefined(near_blur), "Depth of Field value near_blur undefined");
      assert(isDefined(far_blur), "Depth of Field value far_blur undefined");
      assert(near_start < near_end, "Depth of Field value near_start must be < near_end");
      assert(far_start < far_end, "Depth of Field value far_start must be < far_end");
      level._swimming.dof_near_start = near_start;
      level._swimming.dof_near_end = near_end;
      level._swimming.dof_far_start = far_start;
      level._swimming.dof_far_end = far_end;
      level._swimming.dof_near_blur = near_blur;
      level._swimming.dof_far_blur = far_blur;
    }
  } else if(!toggle) {
    println("swimming depth of field disabled");

    level._swimming.toggle_depth_of_field = 0;
  }
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
  level._swimming.toggle_depth_of_field = 0;
  level._swimming.dof_near_start = 10;
  level._swimming.dof_near_end = 60;
  level._swimming.dof_far_start = 341;
  level._swimming.dof_far_end = 2345;
  level._swimming.dof_near_blur = 6;
  level._swimming.dof_far_blur = 2.16;
  setdvar("bg_bobAmplitudeSwimming", "2 2");
}

on_player_connect() {
  println("^4_swimming - server: server player connect");

  init_player();
  wait 1;
  setsaveddvar("phys_buoyancy", 1);
  self thread swimmingtracker();
  self thread swimmingdrown();
  self thread underwaterfx();
}

test() {
  while(true) {
    show_swimming_arms();
    wait 5;
    hide_swimming_arms();
    wait 5;
  }

}

on_save_restored() {
  wait 2;
  player = get_players()[0];
  eye_height = player get_eye()[2];
  water_height = getwaterheight(player.origin);
  player._swimming.current_depth = water_height - eye_height;

  if(player._swimming.current_depth > 0) {
    println("^4_swimming - server: save restore, underwater");

    player._swimming.is_underwater = 1;
    player notify("underwater");
    player setclientflag(level.cf_player_underwater);
  } else {
    println("^4_swimming - server: save restore, not underwater");

  }
}

disable() {
  self._swimming.is_swimming_enabled = 0;
  self clientnotify("_swimming:disable");
}

enable() {
  self._swimming.is_swimming_enabled = 1;
  self clientnotify("_swimming:enable");
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

init_player() {
  self._swimming = spawnstruct();
  self._swimming.is_swimming = 0;
  self._swimming.is_underwater = 0;
  self._swimming.is_swimming_enabled = 1;
}

swimmingtracker() {
  self endon("death");
  self endon("disconnect");

  while(true) {
    if(self._swimming.is_swimming_enabled) {
      eye_height = self get_eye()[2];
      water_height = getwaterheight(self.origin);
      self._swimming.current_depth = water_height - eye_height;
    } else
      self._swimming.current_depth = 0;

    if(self._swimming.current_depth > 0) {
      if(!self._swimming.is_underwater) {
        self._swimming.reset_time = 0;
        self._swimming.is_underwater = 1;
        self notify("underwater");
        self setclientflag(level.cf_player_underwater);
      }
    } else if(self._swimming.is_underwater) {
      self._swimming.is_underwater = 0;
      self notify("surface");
      self clearclientflag(level.cf_player_underwater);
    }

    wait 0.05;
  }
}

underwaterfx() {
  self endon("death");
  self endon("disconnect");
  self endon("swimming_end");

  while(true) {
    self waittill("underwater");

    if(level._swimming.toggle_depth_of_field == 1) {
      println("^4_swimming - server: depth of field ON");

      self setdepthoffield(level._swimming.dof_near_start, level._swimming.dof_near_end, level._swimming.dof_far_start, level._swimming.dof_far_end, level._swimming.dof_near_blur, level._swimming.dof_far_blur);
    } else {
      println("^4_swimming - server: depth of field is NOT used.");

    }

    self waittill("surface");

    if(level._swimming.toggle_depth_of_field == 1) {
      println("^4_swimming - server: depth of field OFF");

      near_start = level._swimming.dof_near_end;
      far_start = level._swimming.dof_far_end;
      self setdepthoffield(near_start, level._swimming.dof_near_end, far_start, level._swimming.dof_far_end, level._swimming.dof_near_blur, level._swimming.dof_far_blur);
    }
  }
}

swimmingdrown() {
  self endon("death");
  self endon("disconnect");
  phase = 0;
  last_phase = 0;
  self._swimming.swim_time = 0;
  self._swimming.reset_time = 0;

  while(phase < level._swimming.num_phases || !self._swimming.is_underwater) {
    wait 0.05;
    phase = self advance_drowning_phase(last_phase);

    if(phase != last_phase) {
      last_phase = phase;

      println("^4_swimming - server: phase " + phase);

      if(phase == level._swimming.num_phases)
        wait 2;
    }
  }

  self suicide();
}

advance_drowning_phase(phase) {
  t_delta = swimming_get_time();

  if(isgodmode(self))
    return 0;

  if(getdvarint(#"_id_79A1DCC2") == 1)
    return 0;

  if(isDefined(level.disable_drowning) && level.disable_drowning)
    return 0;

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
  t_now = gettime();
  t_delta = 0;

  if(isDefined(self._swimming.last_get_time))
    t_delta = t_now - self._swimming.last_get_time;

  self._swimming.last_get_time = t_now;
  return t_delta;
}

get_phase_time(phase) {
  return level._swimming.swim_times[phase] * 1000;
}

get_reset_time(phase) {
  return level._swimming.drown_reset_times[phase] * 1000;
}