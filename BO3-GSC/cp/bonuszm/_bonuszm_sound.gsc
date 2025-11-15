/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: cp\bonuszm\_bonuszm_sound.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\cp\_load;
#using scripts\cp\_oed;
#using scripts\cp\_util;
#using scripts\cp\cybercom\_cybercom;
#using scripts\cp\cybercom\_cybercom_gadget;
#using scripts\cp\cybercom\_cybercom_tactical_rig;
#using scripts\cp\cybercom\_cybercom_util;
#using scripts\cp\gametypes\_battlechatter;
#using scripts\cp\gametypes\_globallogic_player;
#using scripts\cp\gametypes\_save;
#using scripts\shared\_oob;
#using scripts\shared\abilities\_ability_util;
#using scripts\shared\ai\archetype_utility;
#using scripts\shared\ai\systems\blackboard;
#using scripts\shared\ai\systems\shared;
#using scripts\shared\ai\zombie_shared;
#using scripts\shared\ai\zombie_utility;
#using scripts\shared\ai_shared;
#using scripts\shared\ammo_shared;
#using scripts\shared\archetype_shared\archetype_shared;
#using scripts\shared\array_shared;
#using scripts\shared\audio_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\clientids_shared;
#using scripts\shared\containers_shared;
#using scripts\shared\demo_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\flagsys_shared;
#using scripts\shared\gameobjects_shared;
#using scripts\shared\gameskill_shared;
#using scripts\shared\laststand_shared;
#using scripts\shared\load_shared;
#using scripts\shared\math_shared;
#using scripts\shared\music_shared;
#using scripts\shared\scene_shared;
#using scripts\shared\spawner_shared;
#using scripts\shared\system_shared;
#using scripts\shared\turret_shared;
#using scripts\shared\tweakables_shared;
#using scripts\shared\util_shared;
#using scripts\shared\vehicle_shared;
#using scripts\shared\weapons_shared;
#namespace namespace_36e5bc12;

function autoexec init() {
  if(!sessionmodeiscampaignzombiesgame()) {
    return;
  }
  level.var_a5375ea0 = 0;
  level.var_5de673a6 = spawn("script_origin", (0, 0, 0));
  level.var_af2fbbad = spawn("script_origin", (0, 0, 0));
  level.var_e96fb1cb = spawn("script_origin", (0, 0, 0));
  level.var_971e6055 = spawn("script_origin", (0, 0, 0));
  level.var_c9205007 = & function_cf21d35c;
  level.var_9b1300c2 = & function_ef0ce9fb;
  level.var_c75c7dba = & function_b4a3e925;
  level.var_4f24fec0 = & function_45809471;
  level.bzm_sceneseqendedcallback = & bzm_sceneseqended;
}

function bzm_sceneseqended(scenename) {
  level notify("bzm_sceneseqended");
  if(isDefined(level.var_5de673a6.var_478c7e3e)) {
    level.var_5de673a6 stopsound(level.var_5de673a6.var_478c7e3e);
  }
  level.var_5de673a6 notify("hash_2d8828d0");
  if(isDefined(level.var_af2fbbad.var_478c7e3e)) {
    level.var_af2fbbad stopsound(level.var_af2fbbad.var_478c7e3e);
  }
  level.var_af2fbbad notify("hash_2d8828d0");
  if(isDefined(level.var_e96fb1cb.var_478c7e3e)) {
    level.var_e96fb1cb stopsound(level.var_e96fb1cb.var_478c7e3e);
  }
  level.var_e96fb1cb notify("hash_2d8828d0");
  if(isDefined(level.var_971e6055.var_478c7e3e)) {
    level.var_971e6055 stopsound(level.var_971e6055.var_478c7e3e);
  }
  level.var_971e6055 notify("hash_2d8828d0");
}

function private say(alias) {
  self notify("hash_2d8828d0");
  self endon("hash_2d8828d0");
  if(isDefined(self.var_478c7e3e)) {
    self stopsound(self.var_478c7e3e);
  }
  wait(0.1);
  uniquenotify = (alias + " ") + level.var_a5375ea0;
  level.var_a5375ea0 = level.var_a5375ea0 + 1;
  if(isDefined(level.scr_sound) && isDefined(level.scr_sound["generic"])) {
    str_vox_file = level.scr_sound["generic"][alias];
  } else {
    return;
  }
  if(!isDefined(str_vox_file)) {
    return;
  }
  self.var_478c7e3e = str_vox_file;
  self playsoundwithnotify(str_vox_file, uniquenotify);
  self util::waittill_any("death", "bzm_cancel_speaking", uniquenotify);
}

function function_cf21d35c(alias, blocking = 1) {
  assert(sessionmodeiscampaignzombiesgame());
  assert(isDefined(level.var_5de673a6));
  if(blocking) {
    level.var_5de673a6 say(alias);
  } else {
    level.var_5de673a6 thread say(alias);
  }
}

function function_ef0ce9fb(alias, blocking = 1) {
  assert(sessionmodeiscampaignzombiesgame());
  if(blocking) {
    level.var_971e6055 say(alias);
  } else {
    level.var_971e6055 thread say(alias);
  }
}

function function_b4a3e925(alias, blocking = 1) {
  assert(sessionmodeiscampaignzombiesgame());
  if(blocking) {
    level.var_af2fbbad say(alias);
  } else {
    level.var_af2fbbad thread say(alias);
  }
}

function function_45809471(alias, blocking = 1) {
  assert(sessionmodeiscampaignzombiesgame());
  if(blocking) {
    level.var_e96fb1cb say(alias);
  } else {
    level.var_e96fb1cb thread say(alias);
  }
}

function function_f46e57be() {
  self endon("death");
  self.zmb_vocals_attack = "zmb_vocals_zombie_attack";
  self thread function_f93398c4();
  self thread function_b7efd00a();
  self thread function_acd6c6f8();
}

function function_b7efd00a() {
  self endon("death");
  while(true) {
    self waittill("bhtn_action_notify", notify_string);
    if(isDefined(level.bzm_worldpaused) && level.bzm_worldpaused) {
      continue;
    }
    if(self isinscriptedstate()) {
      continue;
    }
    switch (notify_string) {
      case "attack_melee":
      case "behind":
      case "close":
      case "death":
      case "electrocute": {
        level thread function_dc28c71b(self, notify_string, 1);
        break;
      }
      case "ambient":
      case "crawler":
      case "sprint":
      case "taunt":
      case "teardown": {
        level thread function_dc28c71b(self, notify_string, 0);
        break;
      }
      default: {
        if(isDefined(level.var_61e4e12e)) {
          if(isDefined(level.var_61e4e12e[notify_string])) {
            level thread function_dc28c71b(self, notify_string, 0);
          }
        }
        break;
      }
    }
  }
}

function function_dc28c71b(zombie, type, override) {
  zombie endon("death");
  if(!isDefined(zombie)) {
    return;
  }
  if(!isDefined(zombie.voiceprefix)) {
    return;
  }
  alias = (("zmb_vocals_" + zombie.voiceprefix) + "_") + type;
  if(sndisnetworksafe()) {
    if(isDefined(override) && override) {
      if(type == "death") {
        zombie playSound(alias);
      } else {
        zombie playsoundontag(alias, "j_neck");
      }
    } else if(!(isDefined(zombie.talking) && zombie.talking)) {
      zombie.talking = 1;
      zombie playsoundwithnotify(alias, "sounddone", "j_neck");
      zombie waittill("sounddone");
      zombie.talking = 0;
    }
  }
}

function function_f93398c4() {
  self endon("death");
  wait(randomfloatrange(1, 3));
  while(true) {
    type = "ambient";
    if(!isDefined(self.zombie_move_speed)) {
      wait(0.5);
      continue;
    }
    switch (self.zombie_move_speed) {
      case "walk": {
        type = "ambient";
        break;
      }
      case "run": {
        type = "sprint";
        break;
      }
      case "sprint": {
        type = "sprint";
        break;
      }
    }
    if(isDefined(self.missinglegs) && self.missinglegs) {
      type = "crawler";
    }
    self notify("bhtn_action_notify", type);
    wait(randomfloatrange(1, 4));
  }
}

function function_acd6c6f8() {
  self endon("disconnect");
  self waittill("death", attacker, meansofdeath);
  if(isDefined(self)) {
    level thread function_dc28c71b(self, "death", 1);
  }
}

function networksafereset() {
  while(true) {
    level.var_384c508a = 0;
    util::wait_network_frame();
  }
}

function sndisnetworksafe() {
  if(!isDefined(level.var_384c508a)) {
    level thread networksafereset();
  }
  if(level.var_384c508a >= 2) {
    return false;
  }
  level.var_384c508a++;
  return true;
}

function function_b80a73a4() {
  level endon("unloaded");
  self endon("death_or_disconnect");
  if(!isDefined(level._zbv_vox_last_update_time)) {
    level._zbv_vox_last_update_time = 0;
    level._audio_zbv_shared_ent_list = getaiteamarray("axis");
  }
  while(true) {
    wait(1);
    t = gettime();
    if(t > (level._zbv_vox_last_update_time + 1000)) {
      level._zbv_vox_last_update_time = t;
      level._audio_zbv_shared_ent_list = getaiteamarray("axis");
    }
    zombs = level._audio_zbv_shared_ent_list;
    played_sound = 0;
    for(i = 0; i < zombs.size; i++) {
      if(!isDefined(zombs[i])) {
        continue;
      }
      if(isDefined(self.archetype) && self.archetype != "zombie") {
        level._audio_zbv_shared_ent_list = array::remove_index(level._audio_zbv_shared_ent_list, i);
        continue;
      }
      dist = 250;
      z_dist = 50;
      if(distancesquared(zombs[i].origin, self.origin) < (dist * dist)) {
        var_3bd0b11d = vectortoangles(zombs[i].origin - self.origin);
        yaw = self.angles[1] - var_3bd0b11d[1];
        yaw = angleclamp180(yaw);
        z_diff = self.origin[2] - zombs[i].origin[2];
        if(yaw < -95 || yaw > 95 && abs(z_diff) < 50) {
          zombs[i] notify("bhtn_action_notify", "behind");
          played_sound = 1;
          break;
        }
      }
    }
    if(played_sound) {
      wait(5);
    }
  }
}