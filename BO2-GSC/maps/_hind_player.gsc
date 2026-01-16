/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_hind_player.gsc
**************************************/

#include maps\_vehicle;
#include maps\_utility;
#include common_scripts\utility;
#include maps\_anim;
#using_animtree("vehicles");

main() {
  self useanimtree(#animtree);
  init_vehicle_anims();
  self.tut_hud = [];
  self.tut_hud["fly_controls"] = 0;
  self.tut_hud["gun_controls"] = 0;
  self.tut_hud["rocket_controls"] = 0;
  self ent_flag_init("arming_rockets");
  self ent_flag_init("reloading_rockets");
  self.console_models = array("t5_veh_helo_hind_ckpitdmg0", "t5_veh_helo_hind_ckpitdmg1", "t5_veh_helo_hind_ckpitdmg2");
  self thread landed_animation();
  self thread watch_for_cockpit_switch();
  self thread create_tutorial_hud();
}

precache_models() {
  precachemodel("t5_veh_helo_hind_cockpitview");
  precachemodel("t5_veh_helo_hind_ckpitdmg0");
  precachemodel("t5_veh_helo_hind_ckpitdmg1");
  precachemodel("t5_veh_helo_hind_ckpitdmg2");
}

precache_weapons() {
  precacheitem("hind_minigun_pilot");
  precacheitem("hind_rockets");
  precacherumble("minigun_rumble");
  precacherumble("damage_light");
}

precache_hud() {
  precacheshader("hud_hind_cannon01");
  precacheshader("hud_hind_cannon02");
  precacheshader("hud_hind_cannon03");
  precacheshader("hud_hind_cannon04");
  precacheshader("hud_hind_cannon05");
  precacheshader("hud_hind_rocket");
  precacheshader("hud_hind_rocket_border_left");
  precacheshader("hud_hind_rocket_border_right");
}

watch_for_cockpit_switch() {
  self endon("death");
  self endon("animated_switch");
  self.cockpit_models = array("t5_veh_helo_hind_cockpitview", "t5_veh_helo_hind_cockpit_damg_low", "t5_veh_helo_hind_cockpit_damg_med", "t5_veh_helo_hind_cockpit_damg_high");
  self.current_cockpit_state = 0;

  while(true) {
    while(true) {
      self waittill("enter_vehicle", player);
      self hidepart("tag_instrument_warning", "t5_veh_helo_hind_cockpitview");

      if(isDefined(player) && isplayer(player)) {
        self setmodel(self.cockpit_models[self.current_cockpit_state]);
        self.console_model = maps\_utility::spawn("script_model", self.origin);
        self.console_model setmodel("t5_veh_helo_hind_ckpitdmg0");
        self.console_model linkto(self, "origin_animate_jnt", (0, 0, 0), (0, 0, 0));
        self hidepart("tag_window_l_dmg_0a", "t5_veh_helo_hind_cockpitview");
        self hidepart("tag_window_l_dmg_0b", "t5_veh_helo_hind_cockpitview");
        self hidepart("tag_window_c_dmg_0", "t5_veh_helo_hind_cockpitview");
        self hidepart("tag_window_r_dmg_0", "t5_veh_helo_hind_cockpitview");
        self hidepart("tag_window_l_dmg_1", "t5_veh_helo_hind_cockpitview");
        self hidepart("tag_window_c_dmg_1", "t5_veh_helo_hind_cockpitview");
        self hidepart("tag_window_r_dmg_1", "t5_veh_helo_hind_cockpitview");
        self hidepart("tag_window_l_dmg_2", "t5_veh_helo_hind_cockpitview");
        self hidepart("tag_window_c_dmg_2", "t5_veh_helo_hind_cockpitview");
        self hidepart("tag_window_r_dmg_2", "t5_veh_helo_hind_cockpitview");
        self thread hind_weapons_think();
        break;
      }
    }

    while(true) {
      self waittill("exit_vehicle", player);

      if(isDefined(player) && isplayer(player)) {
        self notify("hind weapons disabled");
        self setmodel("t5_veh_helo_hind_blockout");
        break;
      }
    }
  }
}

flash_warning_indicator() {
  self endon("stop_warning_indicator");
  self thread stop_warning_indicator();

  for(;;) {
    self showpart("tag_instrument_warning", "t5_veh_helo_hind_cockpitview");
    wait 0.2;
    self hidepart("tag_instrument_warning", "t5_veh_helo_hind_cockpitview");
    wait 0.2;
  }
}

stop_warning_indicator() {
  self waittill("stop_warning_indicator");
  waittillframeend;
  self hidepart("tag_instrument_warning", "t5_veh_helo_hind_cockpitview");
}

next_cockpit_damage_state() {
  self.current_cockpit_state++;
  assert(self.current_cockpit_state <= self.console_models.size, "Tried to switch the hind to a cockpit damage state that does not exist");

  if(self.current_cockpit_state > 2)
    return false;

  if(self.current_cockpit_state - 1 < 0)
    self detach(self.console_models[self.console_models.size - 1], "origin_animate_jnt");
  else
    self detach(self.console_models[self.current_cockpit_state - 1], "origin_animate_jnt");

  self attach(self.console_models[self.current_cockpit_state], "origin_animate_jnt");

  if(self.current_cockpit_state == 0) {
    self showpart("tag_window_l_dmg_0a", "t5_veh_helo_hind_cockpitview");
    self showpart("tag_window_l_dmg_0b", "t5_veh_helo_hind_cockpitview");
    self showpart("tag_window_c_dmg_0", "t5_veh_helo_hind_cockpitview");
    self showpart("tag_window_r_dmg_0", "t5_veh_helo_hind_cockpitview");
    self hidepart("tag_window_l_dmg_1", "t5_veh_helo_hind_cockpitview");
    self hidepart("tag_window_c_dmg_1", "t5_veh_helo_hind_cockpitview");
    self hidepart("tag_window_r_dmg_1", "t5_veh_helo_hind_cockpitview");
    self hidepart("tag_window_l_dmg_2", "t5_veh_helo_hind_cockpitview");
    self hidepart("tag_window_c_dmg_2", "t5_veh_helo_hind_cockpitview");
    self hidepart("tag_window_r_dmg_2", "t5_veh_helo_hind_cockpitview");
    return true;
  } else if(self.current_cockpit_state == 1) {
    self hidepart("tag_window_l_dmg_0a", "t5_veh_helo_hind_cockpitview");
    self hidepart("tag_window_l_dmg_0b", "t5_veh_helo_hind_cockpitview");
    self hidepart("tag_window_c_dmg_0", "t5_veh_helo_hind_cockpitview");
    self hidepart("tag_window_r_dmg_0", "t5_veh_helo_hind_cockpitview");
    self showpart("tag_window_l_dmg_1", "t5_veh_helo_hind_cockpitview");
    self showpart("tag_window_c_dmg_1", "t5_veh_helo_hind_cockpitview");
    self showpart("tag_window_r_dmg_1", "t5_veh_helo_hind_cockpitview");
    self hidepart("tag_window_l_dmg_2", "t5_veh_helo_hind_cockpitview");
    self hidepart("tag_window_c_dmg_2", "t5_veh_helo_hind_cockpitview");
    self hidepart("tag_window_r_dmg_2", "t5_veh_helo_hind_cockpitview");
    return true;
  } else if(self.current_cockpit_state == 2) {
    self hidepart("tag_window_l_dmg_0a", "t5_veh_helo_hind_cockpitview");
    self hidepart("tag_window_l_dmg_0b", "t5_veh_helo_hind_cockpitview");
    self hidepart("tag_window_c_dmg_0", "t5_veh_helo_hind_cockpitview");
    self hidepart("tag_window_r_dmg_0", "t5_veh_helo_hind_cockpitview");
    self hidepart("tag_window_l_dmg_1", "t5_veh_helo_hind_cockpitview");
    self hidepart("tag_window_c_dmg_1", "t5_veh_helo_hind_cockpitview");
    self hidepart("tag_window_r_dmg_1", "t5_veh_helo_hind_cockpitview");
    self showpart("tag_window_l_dmg_2", "t5_veh_helo_hind_cockpitview");
    self showpart("tag_window_c_dmg_2", "t5_veh_helo_hind_cockpitview");
    self showpart("tag_window_r_dmg_2", "t5_veh_helo_hind_cockpitview");
    return false;
  }
}

debug_cycle_damage_states() {
  self endon("death");

  while(true) {
    self next_cockpit_damage_state();
    wait 5;

    if(self.current_cockpit_state + 1 >= self.cockpit_models.size)
      self.current_cockpit_state = -1;
  }
}

hind_weapons_think() {
  self thread watch_weapon_systems();
}

disable_driver_weapons() {
  self notify("hind weapons disabled");
  self disable_driver_turret();
  self disablegunnerfiring(0, 1);
  player = get_players()[0];
  player stoploopsound();
}

enable_driver_weapons() {
  self enable_driver_turret();
  self thread watch_for_rocket_firing();
}

watch_weapon_systems() {
  self thread watch_for_rockets();
  self thread watch_for_minigun();
}

watch_for_rockets() {
  self endon("death");

  while(true) {
    self waittill("switch_to_rockets");
    self switchto_rockets();
  }
}

watch_for_minigun() {
  self endon("death");

  while(true) {
    self waittill("switch_to_minigun");
    self switchto_minigun();
  }
}

switchto_rockets() {
  self setvehweapon("hind_rockets");
  players = get_players();
  players[0] setclientdvar("vehHelicopterHeadSwayDontSwayTheTurret", 0);
}

switchto_minigun() {
  self setvehweapon("hind_minigun_pilot");
  players = get_players();
  players[0] setclientdvar("vehHelicopterHeadSwayDontSwayTheTurret", 0);
}

create_tutorial_hud(no_wait) {
  if(!isDefined(no_wait))
    self waittill("enter_vehicle");

  self thread destroy_tutorial_hud();
  level.fly_up_hud = newhudelem();
  level.fly_up_hud.fontscale = 1.25;
  level.fly_up_hud.x = 25;
  level.fly_up_hud.y = 53;
  level.fly_up_hud.alignx = "left";
  level.fly_up_hud.aligny = "top";
  level.fly_up_hud.horzalign = "left";
  level.fly_up_hud.vertalign = "top";
  level.fly_up_hud.foreground = 1;

  if(self.tut_hud["fly_controls"])
    level.fly_up_hud settext("Press [{+smoke}] to fly up");

  level.fly_down_hud = newhudelem();
  level.fly_down_hud.fontscale = 1.25;
  level.fly_down_hud.x = 25;
  level.fly_down_hud.y = 68;
  level.fly_down_hud.alignx = "left";
  level.fly_down_hud.aligny = "top";
  level.fly_down_hud.horzalign = "left";
  level.fly_down_hud.vertalign = "top";
  level.fly_down_hud.foreground = 1;

  if(self.tut_hud["fly_controls"])
    level.fly_down_hud settext("Press [{+speed_throw}] to fly down");

  level.fire_hud = newhudelem();
  level.fire_hud.fontscale = 1.25;
  level.fire_hud.x = 25;
  level.fire_hud.y = 93;
  level.fire_hud.alignx = "left";
  level.fire_hud.aligny = "top";
  level.fire_hud.horzalign = "left";
  level.fire_hud.vertalign = "top";
  level.fire_hud.foreground = 1;

  if(self.tut_hud["gun_controls"])
    level.fire_hud settext("[{+attack}] mini-gun");

  level.rocket_hud = newhudelem();
  level.rocket_hud.fontscale = 1;
  level.rocket_hud.x = 25;
  level.rocket_hud.y = 107;
  level.rocket_hud.alignx = "left";
  level.rocket_hud.aligny = "top";
  level.rocket_hud.horzalign = "left";
  level.rocket_hud.vertalign = "top";
  level.rocket_hud.foreground = 1;

  if(self.tut_hud["rocket_controls"])
    level.rocket_hud settext("[{+speed_throw}] rocket pods - [{+usereload}] reload");
}

update_tutorial_hud() {
  if(self.tut_hud["fly_controls"])
    level.fly_up_hud settext("Press [{+smoke}] to fly up");
  else
    level.fly_up_hud settext("");

  if(self.tut_hud["fly_controls"])
    level.fly_down_hud settext("Press [{+speed_throw}] to fly down.");
  else
    level.fly_down_hud settext("");

  if(self.tut_hud["gun_controls"])
    level.fire_hud settext("[{+attack}] mini-gun");
  else
    level.fire_hud settext("");

  if(self.tut_hud["rocket_controls"])
    level.rocket_hud settext("[{+speed_throw}] rocket pods - [{+usereload}] reload");
  else
    level.rocket_hud settext("");
}

destroy_tutorial_hud() {
  self waittill("exit_vehicle");
  self thread create_tutorial_hud();
  level.fly_up_hud destroy();
  level.fly_down_hud destroy();
  level.fire_hud destroy();
  level.rocket_hud destroy();
}

watch_for_rocket_firing() {
  self endon("death");
  self endon("hind weapons disabled");
  self setup_rockets();

  self thread debug_rocket_targetting();

  self disablegunnerfiring(0, 1);
  self thread fire_rockets();

  while(true) {
    player = get_players()[0];

    while(!player throwbuttonpressed() || self._rocket_pods.free_rockets <= 0)
      wait 0.05;

    self ent_flag_clear("reloading_rockets");
    self ent_flag_set("arming_rockets");
    player = get_players()[0];

    while(player throwbuttonpressed())
      wait 0.05;

    self ent_flag_clear("arming_rockets");
    self notify("fire_rockets");
  }
}

fire_rockets() {
  self endon("death");
  self endon("hind weapons disabled");

  while(true) {
    rockets = self arm_rockets();

    for(i = 0; i < rockets.size; i++)
      self fire_rocket(rockets[i]);

    if(isDefined(level.pow_demo) && level.pow_demo) {
      if(self._rocket_pods.free_rockets < 3)
        self._rocket_pods.free_rockets = self._rocket_pods.total_rockets;
    }

    self.armed_rockets = 0;
    wait 0.05;
  }
}

arm_rockets() {
  self ent_flag_wait("arming_rockets");
  armed_rockets = [];

  while(armed_rockets.size < self._rocket_pods.total_rockets && self._rocket_pods.free_rockets > 0) {
    for(pod_index = self._rocket_pods.pod_index; pod_index < self._rocket_pods.pods.size; pod_index++) {
      pod = self._rocket_pods.pods[pod_index];

      for(rocket_index = 0; rocket_index < pod.rockets.size; rocket_index++) {
        rocket = pod.rockets[rocket_index];

        if(!rocket.is_armed) {
          arm_time = 0;

          if(armed_rockets.size)
            arm_time = self._rocket_pods.arm_time;

          rocket = arm_single_rocket(rocket, arm_time);

          if(self ent_flag("arming_rockets")) {
            armed_rockets = add_to_array(armed_rockets, rocket);
            self._rocket_pods.free_rockets--;
            self.armed_rockets = armed_rockets.size;
            self notify("charged_rocket");
            advance_pod_index();
            playsoundatposition("wpn_rocket_prime_chopper_trigger", (0, 0, 0));

            if(armed_rockets.size > 1)
              playsoundatposition("wpn_rocket_prime_chopper", (0, 0, 0));

            break;
          } else {
            level thread reload_chopper_sounds();
            return armed_rockets;
          }
        }
      }
    }
  }

  self waittill("fire_rockets");
  return armed_rockets;
}

reload_chopper_sounds() {
  if(!isDefined(level.reload_string))
    level.reload_string = "left";

  if(level.reload_string == "left") {
    playsoundatposition("wpn_rocket_reload_chopper_left_battery", (0, 0, 0));
    level.reload_string = "right";
  } else {
    playsoundatposition("wpn_rocket_reload_chopper_right_battery", (0, 0, 0));
    level.reload_string = "left";
  }
}

advance_pod_index() {
  if(self._rocket_pods.pod_index == self._rocket_pods.pods.size - 1)
    self._rocket_pods.pod_index = 0;
  else
    self._rocket_pods.pod_index++;
}

arm_single_rocket(rocket, time) {
  self endon("fire_rockets");
  wait(time);
  rocket.is_armed = 1;
  return rocket;
}

setup_rockets() {
  self.armed_rockets = 0;
  self add_rocket_pod(self, "tag_flash_gunner1", 4);
  self add_rocket_pod(create_right_rocket_pod(), undefined, 4);
  self track_available_rockets();
}

add_rocket_pod(entity, tag, num_rockets) {
  if(!isDefined(self._rocket_pods)) {
    self._rocket_pods = spawnstruct();
    self._rocket_pods.arm_time = 0.6;
    self._rocket_pods.fire_wait = 0.15;
    self._rocket_pods.total_rockets = 0;
    self._rocket_pods.free_rockets = 0;
    self._rocket_pods.pod_index = 0;
    self thread cleanup_rocket_pods();
  }

  self._rocket_pods.total_rockets = self._rocket_pods.total_rockets + num_rockets;
  self._rocket_pods.free_rockets = self._rocket_pods.free_rockets + num_rockets;

  if(!isDefined(self._rocket_pods.pods))
    self._rocket_pods.pods = [];

  pod_index = self._rocket_pods.pods.size;
  self._rocket_pods.pods[pod_index] = spawnstruct();
  self._rocket_pods.pods[pod_index].ent = entity;
  self._rocket_pods.pods[pod_index].tag = tag;
  rockets = [];

  for(i = 0; i < num_rockets; i++) {
    rockets[i] = spawnstruct();
    rockets[i].pod_index = pod_index;
    rockets[i].is_armed = 0;
  }

  self._rocket_pods.pods[pod_index].rockets = rockets;
}

track_available_rockets() {
  assert(isDefined(self._rocket_pods.free_rockets), "Hind rockets don't have a defined ammo amount");
  self thread rocket_reload();
  self thread rocket_reload_button();
}

rocket_regen() {
  self endon("death");
  self endon("hind weapons disabled");

  while(true) {
    if(!self ent_flag("arming_rockets") && self._rocket_pods.free_rockets < self._rocket_pods.total_rockets) {
      wait 3;

      if(!self ent_flag("arming_rockets"))
        self._rocket_pods.free_rockets++;
    } else
      wait 0.05;
  }
}

rocket_reload() {
  self endon("death");
  self endon("hind weapons disabled");

  while(true) {
    while(self._rocket_pods.free_rockets > 0 || self ent_flag("arming_rockets"))
      wait 0.1;

    if(!self ent_flag("reloading_rockets")) {
      self notify("rocket_reload", self._rocket_pods.free_rockets);
      self ent_flag_set("reloading_rockets");
      wait 1.5;

      while(self._rocket_pods.free_rockets < self._rocket_pods.total_rockets && ent_flag("reloading_rockets")) {
        self._rocket_pods.free_rockets++;
        level thread reload_chopper_sounds();
        self notify("reloaded_rocket");
        wait 0.5;
      }

      self ent_flag_clear("reloading_rockets");
      playsoundatposition("wpn_rocket_reload_chopper_reloaded_buzzer", (0, 0, 0));
    }
  }
}

rocket_reload_button() {
  self endon("death");
  self endon("hind weapons disabled");
  player = get_players()[0];

  while(true) {
    while(self._rocket_pods.free_rockets >= self._rocket_pods.total_rockets || self ent_flag("arming_rockets") || self ent_flag("reloading_rockets"))
      wait 0.1;

    while(!player usebuttonpressed())
      wait 0.05;

    if(!self ent_flag("reloading_rockets")) {
      self notify("rocket_reload", self._rocket_pods.free_rockets);
      self ent_flag_set("reloading_rockets");

      while(self._rocket_pods.free_rockets < self._rocket_pods.total_rockets && ent_flag("reloading_rockets")) {
        self._rocket_pods.free_rockets++;
        level thread reload_chopper_sounds();
        self notify("reloaded_rocket");
        wait 0.5;
      }

      self ent_flag_clear("reloading_rockets");
      playsoundatposition("wpn_rocket_reload_chopper_reloaded_buzzer", (0, 0, 0));
    }
  }
}

cleanup_rocket_pods() {
  self waittill("death");

  for(pod_index = 0; pod_index < self._rocket_pods.pods.size; pod_index++) {
    pod = self._rocket_pods.pods[pod_index];
    array_delete(pod.rockets);
    pod delete();
  }

  self._rocket_pods delete();
}

create_right_rocket_pod() {
  rocket_pod_origin = self gettagorigin("tag_flash_gunner1");
  rocket_pod_offset = self.origin - rocket_pod_origin;
  rocket_pod = spawn("script_origin", rocket_pod_origin);
  rocket_pod.origin = (self.origin[0] + rocket_pod_offset[0], self.origin[1] + rocket_pod_offset[1], rocket_pod_origin[2]);
  rocket_pod linkto(self);
  return rocket_pod;
}

get_rocket_pod_fire_pos(pod_index) {
  pod = self._rocket_pods.pods[pod_index];
  pos = pod.ent.origin;

  if(isDefined(pod.tag))
    pos = pod.ent gettagorigin(pod.tag);

  return pos;
}

fire_rocket(rocket) {
  trace_origin = self gettagorigin("tag_flash");
  trace_angles = self gettagangles("tag_flash");
  forward = anglestoforward(trace_angles);
  start_origin = get_rocket_pod_fire_pos(rocket.pod_index);
  trace_origin = self gettagorigin("tag_flash");
  trace_direction = self gettagangles("tag_barrel");
  trace_direction = anglestoforward(trace_direction) * 5000;
  trace = bullettrace(trace_origin, trace_origin + trace_direction, 0, self);
  trace_dist_sq = distancesquared(trace_origin, trace["position"]);

  if(trace_dist_sq < 25000000 && trace_dist_sq > 250000)
    end_origin = trace["position"];
  else
    end_origin = start_origin + forward * 1000;

  get_players()[0] playrumbleonentity("damage_light");
  magicbullet("hind_rockets", start_origin, end_origin, self);
  rocket.is_armed = 0;
  self notify("fired_rocket");
  wait(self._rocket_pods.fire_wait);
}

update_rocket_hud(rocket_count, ammo_left, reloading) {
  if(isDefined(self.rocket_reloading) && self.rocket_reloading && !isDefined(reloading)) {
    return;
  }
  if(!isDefined(level._rocket_hud)) {
    level._rocket_hud = newclienthudelem(get_players()[0]);
    level._rocket_hud.horzalign = "center";
    level._rocket_hud.vertalign = "middle";
    level._rocket_hud.alignx = "center";
    level._rocket_hud.aligny = "bottom";
    level._rocket_hud.y = 5;
  }

  if(!isDefined(level._rocket_hud_ammo)) {
    level._rocket_hud_ammo = newclienthudelem(get_players()[0]);
    level._rocket_hud_ammo.horzalign = "center";
    level._rocket_hud_ammo.vertalign = "middle";
    level._rocket_hud_ammo.alignx = "center";
    level._rocket_hud_ammo.aligny = "bottom";
    level._rocket_hud_ammo.y = 30;
  }

  if(isDefined(rocket_count))
    level._rocket_hud settext(rocket_count);
  else
    level._rocket_hud settext("");

  if(isDefined(reloading) && reloading) {
    self.rocket_reloading = 1;
    level._rocket_hud_ammo settext("*Reloading*");
  } else if(isDefined(reloading) && !reloading) {
    self.rocket_reloading = 0;
    level._rocket_hud_ammo settext("Rocket Ammo: " + ammo_left);
  } else
    level._rocket_hud_ammo settext("Rocket Ammo: " + ammo_left);
}

debug_rocket_targetting() {
  if(1) {
    return;
  }
  for(;;) {
    rocket_pod_origin = self gettagorigin("tag_flash_gunner1");
    rocket_pod_angles = self gettagangles("tag_flash_gunner1");
    forward = anglestoforward(rocket_pod_angles);
    line(rocket_pod_origin + 2500 * forward, rocket_pod_origin + 8000 * forward, (1, 0, 0), 20, 1, 1);
    line(self.other_rocket_pod.origin + 2500 * forward, self.other_rocket_pod.origin + 8000 * forward, (1, 0, 0), 20, 1, 1);
    wait 0.05;
  }

}

hud_rocket_create() {
  if(!isDefined(self.rocket_hud))
    self.rocket_hud = [];

  self.rocket_hud["border_left"] = newhudelem();
  self.rocket_hud["border_left"].alignx = "left";
  self.rocket_hud["border_left"].aligny = "bottom";
  self.rocket_hud["border_left"].horzalign = "user_left";
  self.rocket_hud["border_left"].vertalign = "user_bottom";
  self.rocket_hud["border_left"].y = 0;
  self.rocket_hud["border_left"].x = 2;
  self.rocket_hud["border_left"].alpha = 1.0;
  self.rocket_hud["border_left"] fadeovertime(0.05);
  self.rocket_hud["border_left"] setshader("hud_hind_rocket_border_left", 72, 20);
  self.rocket_hud["border_left"].hidewheninmenu = 1;
  self.rocket_hud["ammo7"] = newhudelem();
  self.rocket_hud["ammo7"].alignx = "left";
  self.rocket_hud["ammo7"].aligny = "bottom";
  self.rocket_hud["ammo7"].horzalign = "user_left";
  self.rocket_hud["ammo7"].vertalign = "user_bottom";
  self.rocket_hud["ammo7"].y = -8;
  self.rocket_hud["ammo7"].x = -2;
  self.rocket_hud["ammo7"].alpha = 0.55;
  self.rocket_hud["ammo7"] fadeovertime(0.05);
  self.rocket_hud["ammo7"] setshader("hud_hind_rocket", 48, 48);
  self.rocket_hud["ammo7"].hidewheninmenu = 1;
  self.rocket_hud["ammo5"] = newhudelem();
  self.rocket_hud["ammo5"].alignx = "left";
  self.rocket_hud["ammo5"].aligny = "bottom";
  self.rocket_hud["ammo5"].horzalign = "user_left";
  self.rocket_hud["ammo5"].vertalign = "user_bottom";
  self.rocket_hud["ammo5"].alpha = 0.55;
  self.rocket_hud["ammo5"] fadeovertime(0.05);
  self.rocket_hud["ammo5"].y = -8;
  self.rocket_hud["ammo5"].x = 8;
  self.rocket_hud["ammo5"] setshader("hud_hind_rocket", 48, 48);
  self.rocket_hud["ammo5"].hidewheninmenu = 1;
  self.rocket_hud["ammo3"] = newhudelem();
  self.rocket_hud["ammo3"].alignx = "left";
  self.rocket_hud["ammo3"].aligny = "bottom";
  self.rocket_hud["ammo3"].horzalign = "user_left";
  self.rocket_hud["ammo3"].vertalign = "user_bottom";
  self.rocket_hud["ammo3"].alpha = 0.55;
  self.rocket_hud["ammo3"] fadeovertime(0.05);
  self.rocket_hud["ammo3"].y = -8;
  self.rocket_hud["ammo3"].x = 18;
  self.rocket_hud["ammo3"] setshader("hud_hind_rocket", 48, 48);
  self.rocket_hud["ammo3"].hidewheninmenu = 1;
  self.rocket_hud["ammo1"] = newhudelem();
  self.rocket_hud["ammo1"].alignx = "left";
  self.rocket_hud["ammo1"].aligny = "bottom";
  self.rocket_hud["ammo1"].horzalign = "user_left";
  self.rocket_hud["ammo1"].vertalign = "user_bottom";
  self.rocket_hud["ammo1"].alpha = 0.55;
  self.rocket_hud["ammo1"] fadeovertime(0.05);
  self.rocket_hud["ammo1"].y = -8;
  self.rocket_hud["ammo1"].x = 28;
  self.rocket_hud["ammo1"] setshader("hud_hind_rocket", 48, 48);
  self.rocket_hud["ammo1"].hidewheninmenu = 1;
  self.rocket_hud["button"] = newhudelem();
  self.rocket_hud["button"].alignx = "left";
  self.rocket_hud["button"].aligny = "bottom";
  self.rocket_hud["button"].horzalign = "user_left";
  self.rocket_hud["button"].vertalign = "user_bottom";
  self.rocket_hud["button"].y = -8;
  self.rocket_hud["button"].foreground = 1;
  self.rocket_hud["button"] settext("[{+speed_throw}]");
  self.rocket_hud["button"].hidewheninmenu = 1;

  if(level.ps3) {
    self.rocket_hud["button"].x = 56;
    self.rocket_hud["button"].fontscale = 2.5;
  } else {
    self.rocket_hud["button"].x = 60;
    self.rocket_hud["button"].fontscale = 1;
  }

  self.rocket_hud["border_right"] = newhudelem();
  self.rocket_hud["border_right"].alignx = "left";
  self.rocket_hud["border_right"].aligny = "bottom";
  self.rocket_hud["border_right"].horzalign = "user_left";
  self.rocket_hud["border_right"].vertalign = "user_bottom";
  self.rocket_hud["border_right"].y = 0;
  self.rocket_hud["border_right"].x = 61;
  self.rocket_hud["border_right"].alpha = 1.0;
  self.rocket_hud["border_right"] fadeovertime(0.05);
  self.rocket_hud["border_right"] setshader("hud_hind_rocket_border_right", 72, 20);
  self.rocket_hud["border_right"].hidewheninmenu = 1;
  self.rocket_hud["ammo2"] = newhudelem();
  self.rocket_hud["ammo2"].alignx = "left";
  self.rocket_hud["ammo2"].aligny = "bottom";
  self.rocket_hud["ammo2"].horzalign = "user_left";
  self.rocket_hud["ammo2"].vertalign = "user_bottom";
  self.rocket_hud["ammo2"].alpha = 0.55;
  self.rocket_hud["ammo2"] fadeovertime(0.05);
  self.rocket_hud["ammo2"].y = -8;
  self.rocket_hud["ammo2"].x = 58;
  self.rocket_hud["ammo2"] setshader("hud_hind_rocket", 48, 48);
  self.rocket_hud["ammo2"].hidewheninmenu = 1;
  self.rocket_hud["ammo4"] = newhudelem();
  self.rocket_hud["ammo4"].alignx = "left";
  self.rocket_hud["ammo4"].aligny = "bottom";
  self.rocket_hud["ammo4"].horzalign = "user_left";
  self.rocket_hud["ammo4"].vertalign = "user_bottom";
  self.rocket_hud["ammo4"].alpha = 0.55;
  self.rocket_hud["ammo4"] fadeovertime(0.05);
  self.rocket_hud["ammo4"].y = -8;
  self.rocket_hud["ammo4"].x = 68;
  self.rocket_hud["ammo4"] setshader("hud_hind_rocket", 48, 48);
  self.rocket_hud["ammo4"].hidewheninmenu = 1;
  self.rocket_hud["ammo6"] = newhudelem();
  self.rocket_hud["ammo6"].alignx = "left";
  self.rocket_hud["ammo6"].aligny = "bottom";
  self.rocket_hud["ammo6"].horzalign = "user_left";
  self.rocket_hud["ammo6"].vertalign = "user_bottom";
  self.rocket_hud["ammo6"].alpha = 0.55;
  self.rocket_hud["ammo6"] fadeovertime(0.05);
  self.rocket_hud["ammo6"].y = -8;
  self.rocket_hud["ammo6"].x = 78;
  self.rocket_hud["ammo6"] setshader("hud_hind_rocket", 48, 48);
  self.rocket_hud["ammo6"].hidewheninmenu = 1;
  self.rocket_hud["ammo8"] = newhudelem();
  self.rocket_hud["ammo8"].alignx = "left";
  self.rocket_hud["ammo8"].aligny = "bottom";
  self.rocket_hud["ammo8"].horzalign = "user_left";
  self.rocket_hud["ammo8"].vertalign = "user_bottom";
  self.rocket_hud["ammo8"].alpha = 0.55;
  self.rocket_hud["ammo8"] fadeovertime(0.05);
  self.rocket_hud["ammo8"].y = -8;
  self.rocket_hud["ammo8"].x = 88;
  self.rocket_hud["ammo8"] setshader("hud_hind_rocket", 48, 48);
  self.rocket_hud["ammo8"].hidewheninmenu = 1;
  self thread hud_rocket_think();
  self thread hud_rocket_destroy();
}

hud_rocket_destroy() {
  self waittill("hind weapons disabled");
  self.rocket_hud["border_left"] destroy();
  self.rocket_hud["ammo7"] destroy();
  self.rocket_hud["ammo5"] destroy();
  self.rocket_hud["ammo3"] destroy();
  self.rocket_hud["ammo1"] destroy();
  self.rocket_hud["button"] destroy();
  self.rocket_hud["border_right"] destroy();
  self.rocket_hud["ammo2"] destroy();
  self.rocket_hud["ammo4"] destroy();
  self.rocket_hud["ammo6"] destroy();
  self.rocket_hud["ammo8"] destroy();
}

hud_rocket_think() {
  self waittill("activate_hud");
  self endon("hind weapons disabled");

  while(true) {
    for(i = 1; i < 9; i++) {
      if(i - 1 < self._rocket_pods.free_rockets) {
        self.rocket_hud["ammo" + i] setshader("hud_hind_rocket", 48, 48);
        self.rocket_hud["ammo" + i].alpha = 0.45;
        self.rocket_hud["ammo" + i] fadeovertime(0.05);
        continue;
      }

      if(i <= self._rocket_pods.free_rockets + self.armed_rockets) {
        self.rocket_hud["ammo" + i] setshader("hud_hind_rocket", 48, 48);
        self.rocket_hud["ammo" + i].alpha = 0.9;
        self.rocket_hud["ammo" + i] fadeovertime(0.05);
        continue;
      }

      self.rocket_hud["ammo" + i] setshader("hud_hind_rocket", 48, 48);
      self.rocket_hud["ammo" + i].alpha = 0;
      self.rocket_hud["ammo" + i] fadeovertime(0.05);
    }

    wait 0.05;
  }
}

hud_minigun_create() {
  if(!isDefined(self.minigun_hud))
    self.minigun_hud = [];

  self.minigun_hud["gun"] = newhudelem();
  self.minigun_hud["gun"].alignx = "right";
  self.minigun_hud["gun"].aligny = "bottom";
  self.minigun_hud["gun"].horzalign = "user_right";
  self.minigun_hud["gun"].vertalign = "user_bottom";
  self.minigun_hud["gun"].alpha = 0.55;
  self.minigun_hud["gun"] fadeovertime(0.05);
  self.minigun_hud["gun"] setshader("hud_hind_cannon01", 64, 64);
  self.minigun_hud["gun"].hidewheninmenu = 1;
  self.minigun_hud["button"] = newhudelem();
  self.minigun_hud["button"].alignx = "right";
  self.minigun_hud["button"].aligny = "bottom";
  self.minigun_hud["button"].horzalign = "user_right";
  self.minigun_hud["button"].vertalign = "user_bottom";
  self.minigun_hud["button"].x = -52;
  self.minigun_hud["button"].y = -6;
  self.minigun_hud["button"].foreground = 1;
  self.minigun_hud["button"] settext("[{+attack}]");
  self.minigun_hud["button"].hidewheninmenu = 1;

  if(level.ps3) {
    self.minigun_hud["button"].x = -55;
    self.minigun_hud["button"].fontscale = 2.5;
  } else {
    self.minigun_hud["button"].x = -52;
    self.minigun_hud["button"].fontscale = 1.0;
  }

  self thread hud_minigun_think();
  self thread hud_minigun_destroy();
}

hud_minigun_destroy() {
  self waittill("hind weapons disabled");
  self.minigun_hud["gun"] destroy();
  self.minigun_hud["button"] destroy();
}

minigun_sound() {
  self waittill("activate_hud");
  self endon("hind weapons disabled");
  player = get_players()[0];

  while(true) {
    while(!player attackbuttonpressed())
      wait 0.05;

    while(player attackbuttonpressed()) {
      wait 0.05;
      player playloopsound("wpn_hind_pilot_fire_loop_plr");
    }

    player stoploopsound();
    player playsound("wpn_hind_pilot_stop_plr");
  }
}

hud_minigun_think() {
  self waittill("activate_hud");
  self endon("hind weapons disabled");
  player = get_players()[0];

  while(true) {
    while(!player attackbuttonpressed())
      wait 0.05;

    swap_counter = 1;
    self.minigun_hud["gun"] fadeovertime(0.05);
    self.minigun_hud["gun"].alpha = 0.65;

    while(player attackbuttonpressed()) {
      wait 0.05;
      player playloopsound("wpn_hind_pilot_fire_loop_plr");
      self.minigun_hud["gun"] setshader("hud_hind_cannon0" + swap_counter, 64, 64);

      if(swap_counter == 5)
        swap_counter = 1;
      else
        swap_counter++;
    }

    self.minigun_hud["gun"] setshader("hud_hind_cannon01", 64, 64);
    self.minigun_hud["gun"] fadeovertime(0.05);
    self.minigun_hud["gun"].alpha = 0.55;
    player stoploopsound();
    player playsound("wpn_hind_pilot_stop_plr");
  }
}

make_player_usable() {
  self endon("disable player entry");
  init_player_anims();

  if(!isDefined(self.enter_trig)) {
    trig_origin = self gettagorigin("tag_driver");
    self.enter_trig = spawn("trigger_radius", trig_origin - vectorscale((0, 0, 1), 500.0), 0, 52, 1000);
  }

  while(true) {
    self.enter_trig waittill("trigger", who);

    if(isplayer(who)) {
      if(who getstance() != "stand") {
        while(who.divetoprone)
          wait 0.2;

        who freezecontrols(1);
        who setstance("stand");
        wait 0.5;
        who freezecontrols(0);
      }

      self notify("animated_switch");
      playsoundatposition("evt_hind_climb_1", (0, 0, 0));
      level.animating_helicopter = self;
      self player_enter_animation(who);
      self notify("player_entered");
      return;
    } else
      wait 0.05;
  }
}

make_player_unusable() {
  self notify("disable player entry");
}

swap_for_interior(guy, no_attach) {
  level.animating_helicopter setmodel("t5_veh_helo_hind_cockpitview");

  if(!isDefined(no_attach) || !no_attach)
    level.animating_helicopter attach("t5_veh_helo_hind_ckpitdmg0", "origin_animate_jnt");

  level.animating_helicopter hidepart("tag_window_l_dmg_1", "t5_veh_helo_hind_cockpitview");
  level.animating_helicopter hidepart("tag_window_c_dmg_1", "t5_veh_helo_hind_cockpitview");
  level.animating_helicopter hidepart("tag_window_r_dmg_1", "t5_veh_helo_hind_cockpitview");
  level.animating_helicopter hidepart("tag_window_l_dmg_2", "t5_veh_helo_hind_cockpitview");
  level.animating_helicopter hidepart("tag_window_c_dmg_2", "t5_veh_helo_hind_cockpitview");
  level.animating_helicopter hidepart("tag_window_r_dmg_2", "t5_veh_helo_hind_cockpitview");
  level.animating_helicopter notify("switch_climbin_anim");
  level.animating_helicopter = undefined;
}

swap_for_exterior(guy) {
  level.animating_helicopter setmodel("t5_veh_helo_hind_blockout");
  level.animating_helicopter notify("switch_climbout_anim");
  level.animating_helicopter = undefined;
}

player_enter_animation(player) {
  player allowpickupweapons(0);
  player_body = spawn_anim_model("hind_body", player.origin, player.angles);
  self.player_body = player_body;
  player_body hide();
  player_body linkto(self, "origin_animate_jnt");
  self notify("playing takeoff animation");
  self thread maps\_anim::anim_single_aligned(player_body, "playable_hind_climbin", "origin_animate_jnt");
  self thread exterior_window_anim();
  wait 0.1;
  player thread take_and_giveback_weapons("playable_hind_climbin");
  player playerlinktoabsolute(player_body, "tag_player");
  player_body attach("t5_veh_helo_hind_cockpit_control", "tag_weapon");
  player_body show();

  while(self getspeed() > 0.1)
    wait 0.05;

  self waittill("playable_hind_climbin");
  player notify("playable_hind_climbin");
  player allowpickupweapons(1);
}

player_exit_animation(player) {
  self notify("animated_switch");
  level.animating_helicopter = self;

  if(!isDefined(self.player_body)) {
    player_body = spawn_anim_model("hind_body", player.origin, player.angles);
    self.player_body = player_body;
    player_body hide();
    player_body linkto(self, "origin_animate_jnt");
  } else {
    player_body = self.player_body;
    self.player_body.animname = "hind_body";
  }

  self notify("playing landing animation");
  self thread maps\_anim::anim_single_aligned(player_body, "playable_hind_climbout", "origin_animate_jnt");
  self thread interior_window_anim_exit();
  wait 0.1;
  self useby(player);
  self notify("hind weapons disabled");
  player thread take_and_giveback_weapons("playable_hind_climbout");
  player playerlinktoabsolute(player_body, "tag_player");
  player_body show();
  self waittill("playable_hind_climbout");
  player notify("playable_hind_climbout");
  player unlink();
  player_body delete();
  trace_start = player.origin + vectorscale((0, 0, 1), 200.0);
  trace_end = player.origin + vectorscale((0, 0, -1), 100.0);
  player_trace = bullettrace(trace_start, trace_end, 0, self);
  player setorigin(player_trace["position"]);
}

#using_animtree("player");

init_player_anims() {
  assert(isDefined(level.player_interactive_model), "The playable hind requires that you set a player_interactive_model in _loadout.gsc");
  level.scr_animtree["hind_body"] = #animtree;
  level.scr_model["hind_body"] = level.player_interactive_model;
  level.scr_anim["hind_body"]["playable_hind_climbin"] = % int_pow_b03_cockpit_inandup;
  maps\_anim::addnotetrack_customfunction("hind_body", "swap", ::swap_for_interior, "playable_hind_climbin");
  level.scr_anim["hind_body"]["playable_hind_climbout"] = % int_pow_b03_cockpit_exit;
  maps\_anim::addnotetrack_customfunction("hind_body", "swap", ::swap_for_exterior, "playable_hind_climbout");
}

#using_animtree("vehicles");

init_vehicle_anims() {
  level.scr_anim["hind"]["climbout_exterior"] = % v_pow_b03_hind_exit_exterior;
  level.scr_anim["hind"]["climbout_interior"] = % v_pow_b03_hind_exit_interior;
  level.scr_anim["hind"]["climbin_exterior"] = % v_pow_b03_hind_climbin_exterior;
  level.scr_anim["hind"]["climbin_interior"] = % v_pow_b03_hind_climbin_interior;
  level.scr_anim["hind"]["landed"] = % v_pow_b03_hind_landed;
}

exterior_window_anim() {
  self clearanim(level.scr_anim["hind"]["landed"], 0);
  self setanim(level.scr_anim["hind"]["climbin_exterior"], 1);
  self waittill("switch_climbin_anim");
  self interior_window_anim();
}

interior_window_anim() {
  self clearanim(level.scr_anim["hind"]["climbin_exterior"], 0.15);
  self setanim(level.scr_anim["hind"]["climbin_interior"], 1);
  self waittill("player_entered");
}

interior_window_anim_exit() {
  self clearanim(level.scr_anim["hind"]["landed"], 0);
  self animscripted("hind_exit_anim", self.origin, self.angles, level.scr_anim["hind"]["climbout_interior"]);
  self waittill("playable_hind_climbout");
  self exterior_window_anim_exit();
}

exterior_window_anim_exit() {
  self animscripted("hind_exit_anim", self.origin, self.angles, level.scr_anim["hind"]["climbout_exterior"]);
}

landed_animation() {
  self setanim(level.scr_anim["hind"]["landed"], 1);
}