/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\load_shared.gsc
***********************************************/

#include scripts\core_common\activecamo_shared;
#include scripts\core_common\array_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\delete;
#include scripts\core_common\flag_shared;
#include scripts\core_common\hud_util_shared;
#include scripts\core_common\math_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\trigger_shared;
#include scripts\core_common\util_shared;
#include scripts\core_common\values_shared;

#namespace load;

autoexec __init__system__() {
  system::register(#"load", &__init__, undefined, undefined);
}

init_flags() {
  level flag::init("all_players_connected");
  level flag::init("all_players_spawned");
  level flag::init("first_player_spawned");
}

first_frame() {
  level.first_frame = 1;
  waitframe(1);
  level.first_frame = undefined;
}

__init__() {
  init_flags();
  thread first_frame();

  level thread level_notify_listener();
  level thread client_notify_listener();
  level thread load_checkpoint_on_notify();
  level thread save_checkpoint_on_notify();

  level.var_8a3a9ca4 = spawnStruct();
  defaultaspectratio = 1;

  if(sessionmodeiscampaigngame()) {
    level.game_mode_suffix = "_cp";
    defaultaspectratio = 1.77778;
  } else if(sessionmodeiszombiesgame()) {
    level.game_mode_suffix = "_zm";
  } else {
    level.game_mode_suffix = "_mp";
    defaultaspectratio = 1.77778;
  }

  level.script = util::get_map_name();
  level.clientscripts = getdvarstring(#"cg_usingclientscripts") != "";
  level.campaign = "american";
  level.clientscripts = getdvarstring(#"cg_usingclientscripts") != "";

  if(!isDefined(level.timeofday)) {
    level.timeofday = "day";
  }

  if(getdvarstring(#"scr_requiredmapaspectratio") == "") {
    setdvar(#"scr_requiredmapaspectratio", defaultaspectratio);
  }

  setdvar(#"tu6_player_shallowwaterheight", "0.0");
  util::registerclientsys("levelNotify");
  level thread all_players_spawned();
  level thread keep_time();
  level thread count_network_frames();
  callback::on_spawned(&on_spawned);
  self thread playerdamagerumble();
  array::thread_all(getEntArray("water", "targetname"), &water_think);
  array::thread_all_ents(getEntArray("badplace", "targetname"), &badplace_think);
  weapon_ammo();
  set_objective_text_colors();
  link_ents();
  hide_ents();
}

count_network_frames() {
  level.network_frame = 0;

  while(true) {
    util::wait_network_frame();
    level.network_frame++;
    level.var_58bc5d04 = gettime();
  }
}

keep_time() {
  while(true) {
    level.time = gettime();
    waitframe(1);
  }
}

level_notify_listener() {
  while(true) {
    val = getdvarstring(#"level_notify");

    if(val != "<dev string:x38>") {
      toks = strtok(val, "<dev string:x3b>");

      if(toks.size == 3) {
        level notify(toks[0], {
          #param1: toks[1], 
          #param2: toks[2]
        });
      } else if(toks.size == 2) {
        level notify(toks[0], {
          #param1: toks[1]
        });
      } else {
        level notify(toks[0]);
      }

      setdvar(#"level_notify", "<dev string:x38>");
    }

    wait 0.2;
  }
}

client_notify_listener() {
  while(true) {
    val = getdvarstring(#"client_notify");

    if(val != "<dev string:x38>") {
      util::clientnotify(val);
      setdvar(#"client_notify", "<dev string:x38>");
    }

    wait 0.2;
  }
}

load_checkpoint_on_notify() {
  while(true) {
    level waittill(#"save");
    checkpointcreate();
    checkpointcommit();
  }
}

save_checkpoint_on_notify() {
  while(true) {
    level waittill(#"load");
    checkpointrestore();
  }
}

weapon_ammo() {
  ents = getEntArray();

  for(i = 0; i < ents.size; i++) {
    if(isDefined(ents[i].classname) && getsubstr(ents[i].classname, 0, 7) == "weapon_") {
      weap = ents[i];
      change_ammo = 0;
      clip = undefined;
      extra = undefined;

      if(isDefined(weap.script_ammo_clip)) {
        clip = weap.script_ammo_clip;
        change_ammo = 1;
      }

      if(isDefined(weap.script_ammo_extra)) {
        extra = weap.script_ammo_extra;
        change_ammo = 1;
      }

      if(change_ammo) {
        if(!isDefined(clip)) {
          assertmsg("<dev string:x3f>" + weap.classname + "<dev string:x4a>" + weap.origin + "<dev string:x4e>");
        }

        if(!isDefined(extra)) {
          assertmsg("<dev string:x3f>" + weap.classname + "<dev string:x4a>" + weap.origin + "<dev string:x81>");
        }

        weap itemweaponsetammo(clip, extra);
        weap itemweaponsetammo(clip, extra, 1);
      }
    }
  }
}

badplace_think(badplace) {
  if(!isDefined(level.badplaces)) {
    level.badplaces = 0;
  }

  level.badplaces++;
  badplace_box("badplace" + level.badplaces, -1, badplace.origin, badplace.radius, "all");
}

playerdamagerumble() {
  while(true) {
    self waittill(#"damage");

    if(isDefined(self.specialdamage)) {
      continue;
    }

    self playrumbleonentity("damage_heavy");
  }
}

map_is_early_in_the_game() {
  if(isDefined(level.testmap)) {
    return true;
  }

  if(!isDefined(level.early_level[level.script])) {
    level.early_level[level.script] = 0;
  }

  return isDefined(level.early_level[level.script]) && level.early_level[level.script];
}

player_throwgrenade_timer() {
  self endon(#"death", #"disconnect");
  self.lastgrenadetime = 0;

  while(true) {
    while(!self isthrowinggrenade()) {
      wait 0.05;
    }

    self.lastgrenadetime = gettime();

    while(self isthrowinggrenade()) {
      wait 0.05;
    }
  }
}

water_think() {
  assert(isDefined(self.target));
  targeted = getent(self.target, "targetname");
  assert(isDefined(targeted));
  waterheight = targeted.origin[2];
  targeted = undefined;
  level.depth_allow_prone = 8;
  level.depth_allow_crouch = 33;
  level.depth_allow_stand = 50;

  while(true) {
    waitframe(1);
    players = getplayers();

    for(i = 0; i < players.size; i++) {
      if(players[i].inwater) {
        players[i] allowprone(1);
        players[i] allowcrouch(1);
        players[i] allowstand(1);
      }
    }

    waitresult = self waittill(#"trigger");
    other = waitresult.activator;

    if(!isplayer(other)) {
      continue;
    }

    while(true) {
      players = getplayers();
      players_in_water_count = 0;

      for(i = 0; i < players.size; i++) {
        if(players[i] istouching(self)) {
          players_in_water_count++;
          players[i].inwater = 1;
          playerorg = players[i] getorigin();
          d = playerorg[2] - waterheight;

          if(d > 0) {
            continue;
          }

          newspeed = int(level.default_run_speed - abs(d * 5));

          if(newspeed < 50) {
            newspeed = 50;
          }

          assert(newspeed <= 190);

          if(abs(d) > level.depth_allow_crouch) {
            players[i] allowcrouch(0);
          } else {
            players[i] allowcrouch(1);
          }

          if(abs(d) > level.depth_allow_prone) {
            players[i] allowprone(0);
          } else {
            players[i] allowprone(1);
          }

          continue;
        }

        if(players[i].inwater) {
          players[i].inwater = 0;
        }
      }

      if(players_in_water_count == 0) {
        break;
      }

      wait 0.5;
    }

    waitframe(1);
  }
}

calculate_map_center() {
  if(!isDefined(level.mapcenter)) {
    nodes = getallnodes();

    if(isDefined(nodes[0])) {
      level.nodesmins = nodes[0].origin;
      level.nodesmaxs = nodes[0].origin;
    } else {
      level.nodesmins = (0, 0, 0);
      level.nodesmaxs = (0, 0, 0);
    }

    for(index = 0; index < nodes.size; index++) {
      if(nodes[index].type == #"bad node") {
        println("<dev string:xb4>", nodes[index].origin);
        continue;
      }

      origin = nodes[index].origin;
      level.nodesmins = math::expand_mins(level.nodesmins, origin);
      level.nodesmaxs = math::expand_maxs(level.nodesmaxs, origin);
    }

    level.mapcenter = math::find_box_center(level.nodesmins, level.nodesmaxs);
    println("<dev string:xf8>", level.mapcenter);
    setmapcenter(level.mapcenter);
  }
}

set_objective_text_colors() {
  if(isdedicated()) {
    return;
  }

  my_textbrightness_default = "1.0 1.0 1.0";
  my_textbrightness_90 = "0.9 0.9 0.9";

  if(level.script == "armada") {
    setsaveddvar(#"con_typewritercolorbase", my_textbrightness_90);
    return;
  }

  setsaveddvar(#"con_typewritercolorbase", my_textbrightness_default);
}

lerp_trigger_dvar_value(trigger, dvar, value, time) {
  trigger.lerping_dvar[dvar] = 1;
  steps = time * 20;
  curr_value = getdvarfloat(dvar, 0);
  diff = (curr_value - value) / steps;

  for(i = 0; i < steps; i++) {
    curr_value -= diff;
    setsaveddvar(dvar, curr_value);
    waitframe(1);
  }

  setsaveddvar(dvar, value);
  trigger.lerping_dvar[dvar] = 0;
}

set_fog_progress(progress) {
  anti_progress = 1 - progress;
  startdist = self.script_start_dist * anti_progress + self.script_start_dist * progress;
  halfwaydist = self.script_halfway_dist * anti_progress + self.script_halfway_dist * progress;
  color = self.script_color * anti_progress + self.script_color * progress;
  setvolfog(startdist, halfwaydist, self.script_halfway_height, self.script_base_height, color[0], color[1], color[2], 0.4);
}

ascii_logo() {
  println("<dev string:x107>");
}

all_players_spawned() {
  level flag::wait_till("all_players_connected");
  waittillframeend();
  level.host = util::gethostplayer();

  while(true) {
    if(getnumconnectedplayers() == 0) {
      waitframe(1);
      continue;
    }

    players = getplayers();
    count = 0;

    for(i = 0; i < players.size; i++) {
      if(players[i].sessionstate == "playing") {
        count++;
      }
    }

    waitframe(1);

    if(count > 0) {
      level flag::set("first_player_spawned");
    }

    if(count == players.size) {
      break;
    }
  }

  level flag::set("all_players_spawned");
}

shock_onpain() {
  self endon(#"death", #"disconnect", #"killonpainmonitor");

  if(getdvarstring(#"blurpain") == "") {
    setdvar(#"blurpain", "on");
  }

  while(true) {
    oldhealth = self.health;
    waitresult = self waittill(#"damage");
    mod = waitresult.mod;
    damage = waitresult.amount;

    if(isDefined(level.shock_onpain) && !level.shock_onpain) {
      continue;
    }

    if(isDefined(self.shock_onpain) && !self.shock_onpain) {
      continue;
    }

    if(self.health < 1) {
      continue;
    }

    if(mod == "MOD_PROJECTILE") {
      continue;
    }

    if(mod == "MOD_GRENADE_SPLASH" || mod == "MOD_GRENADE" || mod == "MOD_EXPLOSIVE" || mod == "MOD_PROJECTILE_SPLASH") {
      self shock_onexplosion(damage);
      continue;
    }

    if(getdvarstring(#"blurpain") == "on") {
      self shellshock(#"pain", 0.5);
    }
  }
}

shock_onexplosion(damage) {
  time = 0;
  multiplier = self.maxhealth / 100;
  scaled_damage = damage * multiplier;

  if(scaled_damage >= 90) {
    time = 4;
  } else if(scaled_damage >= 50) {
    time = 3;
  } else if(scaled_damage >= 25) {
    time = 2;
  } else if(scaled_damage > 10) {
    time = 1;
  }

  if(time) {}
}

shock_ondeath() {
  self waittill(#"death");

  if(isDefined(level.shock_ondeath) && !level.shock_ondeath) {
    return;
  }

  if(isDefined(self.shock_ondeath) && !self.shock_ondeath) {
    return;
  }

  if(isDefined(self.specialdeath)) {
    return;
  }

  if(getdvarint(#"r_texturebits", 0) == 16) {
    return;
  }
}

on_spawned() {
  if(!isDefined(self.player_inited) || !self.player_inited) {
    if(sessionmodeiscampaigngame()) {
      self thread shock_ondeath();
      self thread shock_onpain();
      self flag::init("player_is_invulnerable");
    }

    waitframe(1);

    if(isDefined(self)) {
      self.player_inited = 1;
    }
  }
}

link_ents() {
  foreach(ent in getEntArray()) {
    if(isDefined(ent.linkto)) {
      e_link = getent(ent.linkto, "linkname");

      if(isDefined(e_link)) {
        ent enablelinkto();
        ent linkto(e_link);
      }
    }
  }
}

hide_ents() {
  foreach(ent in getEntArray()) {
    if(isDefined(ent.script_hide) && ent.script_hide) {
      ent val::set(#"script_hide", "hide", 1);
    }
  }
}

art_review() {
  dvarvalue = getdvarint(#"art_review", 0);

  switch (dvarvalue) {
    case 1:
    case 2:

      hud = hud::function_f5a689d("<dev string:x118>", 1.2);
      hud hud::setpoint("<dev string:x124>", "<dev string:x124>", 0, -200);
      hud.sort = 1001;
      hud.color = (1, 0, 0);
      hud settext("<dev string:x12d>");
      hud.foreground = 0;
      hud.hidewheninmenu = 0;

      if(sessionmodeiszombiesgame()) {
        setdvar(#"zombie_cheat", 2);

        if(dvarvalue == 1) {
          setdvar(#"zombie_devgui", "<dev string:x13a>");
        }

      } else {
        foreach(trig in trigger::get_all()) {
          trig triggerenable(0);
        }
      }

      level.prematchperiod = 0;
      level waittill(#"forever");
      break;
  }
}