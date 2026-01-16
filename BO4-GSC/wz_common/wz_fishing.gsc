/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: wz_common\wz_fishing.gsc
***********************************************/

#include script_cb32d07c95e5628;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\flagsys_shared;
#include scripts\core_common\player\player_stats;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\core_common\values_shared;
#include scripts\mp_common\item_world;
#include scripts\mp_common\laststand_warzone;

#namespace wz_fishing;

autoexec __init__system__() {
  system::register(#"wz_fishing", &__init__, undefined, undefined);
}

__init__() {
  level.var_99ca6467 = (isDefined(getgametypesetting(#"hash_697d65a68cc6c6f1")) ? getgametypesetting(#"hash_697d65a68cc6c6f1") : 0) || (isDefined(getgametypesetting(#"hash_473fee16f796c84e")) ? getgametypesetting(#"hash_473fee16f796c84e") : 0);
  clientfield::register("scriptmover", "fishing_splash", 21000, 1, "int");
  clientfield::register("scriptmover", "fishing_buoy_splash", 21000, 1, "int");
  clientfield::register("toplayer", "player_fishing", 21000, 1, "int");
  fishing_rocks = getdynentarray("fishing_rock");

  if(level.var_99ca6467) {
    callback::on_downed(&function_7bf61c45);
    callback::on_weapon_change(&function_e2877ac6);
    callback::on_item_drop(&function_57232538);

    foreach(rock in fishing_rocks) {
      rock.onuse = &function_4cfd3896;
      rock.dropping_item = 0;
      rock.var_fb09ad1c = 0;
      rock.isfishing = 0;

      if(isDefined(rock.target)) {
        buoy = getent(rock.target, "targetname");

        if(isDefined(buoy)) {
          rock.var_87de0f0d = buoy.origin;
          rock.buoy = buoy;
          buoy hide();
        }
      }
    }

    level thread function_c0cfa434();
    return;
  }

  foreach(rock in fishing_rocks) {
    setdynentstate(rock, 2);
  }
}

function_57232538(s_item) {
  fishing_rocks = getdynentarray("fishing_rock");

  foreach(rock in fishing_rocks) {
    if(isplayer(rock.fisherman) && rock.fisherman == self && isDefined(rock.isfishing) && rock.isfishing) {
      self stopallboasts();
      self function_ed446f40(rock);
    }
  }
}

function_7bf61c45() {
  fishing_rocks = getdynentarray("fishing_rock");

  foreach(rock in fishing_rocks) {
    if(rock.isfishing && isplayer(rock.fisherman) && rock.fisherman === self) {
      self stopallboasts();
      self function_ed446f40(rock);
    }
  }
}

function_e2877ac6() {
  fishing_rocks = getdynentarray("fishing_rock");

  foreach(rock in fishing_rocks) {
    if(rock.isfishing && isplayer(rock.fisherman) && rock.fisherman === self) {
      self stopallboasts();
      self function_ed446f40(rock);
    }
  }
}

function_c0cfa434() {
  level endon(#"game_ended");
  flagsys::wait_till(#"hash_507a4486c4a79f1d");
  fishing_rocks = getdynentarray("fishing_rock");

  foreach(rock in fishing_rocks) {
    if(rock.isfishing && isplayer(rock.fisherman)) {
      rock.fisherman notify(#"hash_61bb9580151c93d5");
      rock.fisherman stopallboasts();
      rock.fisherman function_ed446f40(rock);
    }
  }
}

function_12747006(boast) {
  if(self util::is_female()) {
    self playboast("f_" + boast);
    return;
  }

  self playboast("m_" + boast);
}

function_e1cd5954(v_origin) {
  self notify("58ed1cc25dba79a1");
  self endon("58ed1cc25dba79a1");
  trace = bulletTrace(v_origin + (0, 0, 40), v_origin + (0, 0, -150), 0, undefined);

  if(trace[#"fraction"] < 1) {
    v_origin = trace[#"position"];
  }

  return v_origin + (0, 0, 3);
}

fake_physicslaunch(start_pos, target_pos, power, var_b37bfb00) {
  self notify("734213b674966fed");
  self endon("734213b674966fed");
  dist = distance(start_pos, target_pos);
  time = dist / power;
  delta = target_pos - start_pos;
  up = (0, 0, dist);
  velocity = delta + up;
  self movegravity(velocity, time);
  return time;
}

fishing_buoy_splash() {
  self notify("affb149f13915ab");
  self endon("affb149f13915ab");
  self clientfield::set("fishing_buoy_splash", 1);
  wait 0.5;
  self clientfield::set("fishing_buoy_splash", 0);
}

fishing_splash() {
  self notify("23dba81fc67053dc");
  self endon("23dba81fc67053dc");
  self clientfield::set("fishing_splash", 1);
  wait 1;
  self clientfield::set("fishing_splash", 0);
}

function_7a1e21a9(fishing_rock, v_origin, player) {
  self notify("47f64769ffeb67ce");
  self endon("47f64769ffeb67ce");
  self endon(#"delete");
  self.origin = v_origin + (0, 0, 10);
  height_offset = 16;
  final_origin = fishing_rock.origin + (0, 0, height_offset);
  dest_origin = function_e1cd5954(final_origin);

  if(isDefined(fishing_rock.target)) {
    buoy = getent(fishing_rock.target, "targetname");
  }

  buoy thread fishing_splash();
  time = self fake_physicslaunch(buoy.origin, final_origin, 200, height_offset);
  wait time;
  fishing_rock.dropping_item = 0;

  if(isDefined(self)) {
    self.origin = final_origin;
  }
}

function_e8c63c15(player) {
  self notify("148aaf4bd55078f9");
  self endon("148aaf4bd55078f9");

  if(isDefined(self.target)) {
    buoy = getent(self.target, "targetname");
  }

  if(isDefined(buoy)) {
    v_origin = buoy.origin;
    items = buoy namespace_65181344::function_fd87c780("fishing_hole_items", 1);
  } else {
    v_origin = self.origin;
    items = self namespace_65181344::function_fd87c780("fishing_hole_items", 1);
  }

  for(i = 0; i < items.size; i++) {
    item = items[i];

    if(isDefined(item)) {
      item thread function_7a1e21a9(self, v_origin, player);
    }

    waitframe(1);
  }
}

function_4cfd3896(activator, laststate, state) {
  if(isDefined(self.isfishing) && self.isfishing) {
    return;
  }

  if(!isplayer(activator)) {
    return;
  }

  if(!activator isonground()) {
    return;
  }

  self.isfishing = 1;

  if(isDefined(self.buoy)) {
    self.buoy show();
  } else {
    assert(isDefined(self.buoy), "<dev string:x38>");
  }

  self.fisherman = activator;
  self.dropping_item = 0;
  activator thread function_6c71782a(self);
}

function_ee4ce537(dynent) {
  self endon(#"death", #"hash_21d06dbd3684fc31");

  while(true) {
    if(isDefined(dynent.isfishing) && dynent.isfishing) {
      if(!self function_15049d95()) {
        self function_ed446f40(dynent);
        self notify(#"hash_21d06dbd3684fc31");
        break;
      }
    }

    waitframe(1);
  }
}

function_6c71782a(dynent) {
  self notify("48d65f5f22c36da2");
  self endon("48d65f5f22c36da2");
  self endon(#"death", #"hash_61bb9580151c93d5", #"hash_667fd08050e0942b");

  if(!isplayer(self)) {
    return;
  }

  if(!isDefined(dynent)) {
    return;
  }

  self disableweaponcycling();
  self disableusability();
  self disableoffhandweapons();
  self val::set(#"fishing", "freezecontrols_allowlook", 1);
  self val::set(#"fishing", "disablegadgets", 1);

  if(dynent.var_fb09ad1c == 1 || dynent.var_fb09ad1c == 2) {
    return;
  }

  dynent.var_fb09ad1c = 1;
  var_9f816ad8 = dynent.var_87de0f0d - dynent.origin;
  var_9f816ad8 = vectortoangles(var_9f816ad8);
  self setplayerangles(var_9f816ad8);
  dynent.buoy.origin = self.origin;
  self stopallboasts();
  self function_12747006("fishing_in");
  self clientfield::set_to_player("player_fishing", 1);
  self thread function_ee4ce537(dynent);
  self waittill(#"fishing_buoy_toss");
  time = dynent.buoy fake_physicslaunch(self.origin, dynent.var_87de0f0d, 200);
  dynent.buoy thread function_8e8c4fef(time, dynent.var_87de0f0d);
  self waittill(#"fishing_minigame_start");

  if(dynent.var_fb09ad1c === 2) {
    return;
  }

  dynent.var_fb09ad1c = 2;
  self function_12747006("fishing_loop");
  dynent.buoy.origin = dynent.var_87de0f0d;
  dynent.var_be4b82e0 = dynent.var_87de0f0d;
  dynent.buoy thread function_b828bd39(self, dynent);
  self thread function_16e4e507(dynent);
  self thread function_176e516(dynent);
}

function_8e8c4fef(time, pos) {
  self notify("230f045151c08d1e");
  self endon("230f045151c08d1e");
  self endon(#"death", #"fishing_done");
  wait time;
  self.origin = pos;
}

function_b828bd39(player, dynent) {
  self notify("1fa6d3899117f2a");
  self endon("1fa6d3899117f2a");

  if(!isplayer(player)) {
    return;
  }

  if(!isDefined(dynent)) {
    return;
  }

  if(!isDefined(dynent.var_be4b82e0)) {
    return;
  }

  self endon(#"fishing_done");
  player endon(#"death", #"hash_61bb9580151c93d5");
  dynent.var_3fa8a746 = 0;
  self.origin = dynent.var_be4b82e0;

  while(dynent.var_fb09ad1c == 2 && !dynent.dropping_item) {
    time = randomintrange(5, 7);
    wait time;
    dynent.var_3fa8a746 = 1;
    player playrumbleonentity("fishing_rumble");
    self thread fishing_buoy_splash();
    new_pos = self.origin + (0, 0, -5);
    self moveto(new_pos, 0.5);
    self waittill(#"movedone");
    new_pos = self.origin + (0, 0, 5);
    self moveto(new_pos, 0.5);
    self waittill(#"movedone");
    dynent.var_3fa8a746 = 0;
    waitframe(1);
  }
}

function_16e4e507(dynent) {
  self notify("651631a8d4cdd907");
  self endon("651631a8d4cdd907");
  self endoncallback(&function_73532e4f, #"death", #"hash_61bb9580151c93d5");

  if(!isplayer(self)) {
    return;
  }

  if(!isDefined(dynent)) {
    return;
  }

  while(dynent.var_fb09ad1c != 3) {
    if(self attackbuttonpressed() && dynent.var_fb09ad1c != 3) {
      dynent.var_fb09ad1c = 3;

      if(isDefined(dynent.buoy)) {
        self function_12747006("fishing_out");
        self thread function_54a3ec41(dynent);
        self waittill(#"fishing_end_minigame");
        self thread function_ed446f40(dynent);
        break;
      }
    }

    waitframe(1);
  }
}

function_ed446f40(dynent) {
  self notify("694f2b46b5345051");
  self endon("694f2b46b5345051");

  if(isplayer(self)) {
    self enableweaponcycling();
    self enableusability();
    self enableoffhandweapons();
    self val::set(#"fishing", "freezecontrols_allowlook", 0);
    self val::set(#"fishing", "disablegadgets", 0);
    self clientfield::set_to_player("player_fishing", 0);
  }

  dynent.dropping_item = 0;
  dynent.var_fb09ad1c = 0;

  if(isDefined(dynent.buoy)) {
    dynent.buoy notify(#"fishing_done");
    dynent.buoy moveto(dynent.var_87de0f0d, 1);
    dynent.buoy hide();
  }

  wait 2;
  dynent.fisherman = undefined;
  dynent.isfishing = 0;
}

function_176e516(dynent) {
  self notify("110650c21bf60e88");
  self endon("110650c21bf60e88");

  if(!isDefined(dynent) || !isplayer(self)) {
    return;
  }

  self endoncallback(&function_73532e4f, #"death", #"hash_61bb9580151c93d5");

  while(dynent.var_fb09ad1c != 3) {
    if(dynent.var_fb09ad1c != 3 && (self jumpbuttonpressed() || self stancebuttonpressed())) {
      dynent.var_fb09ad1c = 3;
      self function_12747006("fishing_cancel");
      self waittill(#"fishing_end_minigame");
      self function_ed446f40(dynent);
      break;
    }

    waitframe(1);
  }
}

function_54a3ec41(dynent) {
  self notify("28b87437c2b95c62");
  self endon("28b87437c2b95c62");
  self endon(#"death");

  if(isDefined(dynent.var_3fa8a746) && dynent.var_3fa8a746) {
    self waittill(#"fishing_caught_minigame");

    if(dynent.dropping_item === 0) {
      dynent.dropping_item = 1;
      dynent function_e8c63c15(self);
    }

    return;
  }

  if(isDefined(dynent.buoy)) {
    dynent.buoy notify(#"fishing_done");
  }
}

function_73532e4f() {
  self notify("76a99663ad9702eb");
  self endon("76a99663ad9702eb");

  if(isplayer(self)) {
    self enableweaponcycling();
    self enableusability();
    self enableoffhandweapons();
    self val::set(#"fishing", "freezecontrols_allowlook", 0);
    self val::set(#"fishing", "disablegadgets", 0);
    self clientfield::set_to_player("player_fishing", 0);
  }

  fishing_rocks = getdynentarray("fishing_rock");

  foreach(rock in fishing_rocks) {
    rock.dropping_item = 0;
    rock.var_fb09ad1c = 0;
    rock.isfishing = 0;

    if(isDefined(rock.buoy) && isDefined(rock.var_87de0f0d)) {
      rock.buoy notify(#"fishing_done");
      rock.buoy moveto(rock.var_87de0f0d, 0.1);
      rock.buoy hide();
    }
  }
}