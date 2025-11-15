/*********************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_island_side_ee_spore_hallucinations.gsc
*********************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\ai\systems\gib;
#using scripts\shared\ai\zombie_shared;
#using scripts\shared\ai\zombie_utility;
#using scripts\shared\ai_shared;
#using scripts\shared\array_shared;
#using scripts\shared\audio_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\exploder_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\laststand_shared;
#using scripts\shared\scene_shared;
#using scripts\shared\system_shared;
#using scripts\shared\trigger_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm_audio;
#using scripts\zm\_zm_devgui;
#using scripts\zm\_zm_equipment;
#using scripts\zm\_zm_unitrigger;
#using scripts\zm\_zm_utility;
#using scripts\zm\_zm_zonemgr;
#using scripts\zm\zm_island_util;
#namespace zm_island_side_ee_spore_hallucinations;

function autoexec __init__sytem__() {
  system::register("zm_island_side_ee_spore_hallucinations", & __init__, undefined, undefined);
}

function __init__() {
  clientfield::register("toplayer", "hallucinate_bloody_walls", 9000, 1, "int");
  clientfield::register("toplayer", "hallucinate_spooky_sounds", 9000, 1, "int");
  callback::on_spawned( & on_player_spawned);
  callback::on_connect( & on_player_connected);
  level.var_40e8eaa5 = [];
  level.var_40e8eaa5["bloody_walls"] = getent("vol_hallucinate_bloody_walls", "targetname");
  level.var_40e8eaa5["corpses"] = getent("vol_hallucinate_corpses", "targetname");
}

function main() {
  level thread function_c6d55b0d();
}

function on_player_connected() {
  self flag::init("hallucination_spookysounds_on");
  self flag::init("hallucination_bloodywalls_on");
}

function on_player_spawned() {
  self.var_5f5af9f0 = 0;
  self thread function_e58be395();
}

function function_e58be395() {
  self endon("death");
  self thread function_b200c473();
  while(true) {
    self waittill("hash_ece519d9");
    self.var_5f5af9f0++;
    if(self.var_5f5af9f0 > 5) {
      self thread function_51d3efd();
    }
    if(self.var_5f5af9f0 > 15) {
      self thread function_5d6bcf98();
    }
  }
}

function function_b200c473() {
  self endon("death");
  while(true) {
    wait(300);
    if(self.var_5f5af9f0 > 0) {
      self.var_5f5af9f0--;
    }
  }
}

function function_51d3efd() {
  self endon("death");
  if(!self flag::get("hallucination_spookysounds_on")) {
    self flag::set("hallucination_spookysounds_on");
    while(self.var_5f5af9f0 >= 5) {
      var_2499b02a = self zm_island_util::function_1867f3e8(800);
      if(var_2499b02a <= 3 && !self laststand::player_is_in_laststand()) {
        self function_5d3a5f36();
        wait(randomintrange(360, 480));
      }
      wait(5);
    }
    self flag::clear("hallucination_spookysounds_on");
  }
}

function function_5d6bcf98() {
  self endon("death");
  if(!self flag::get("hallucination_bloodywalls_on")) {
    self flag::set("hallucination_bloodywalls_on");
    var_558d1e01 = getent("vol_hallucinate_bloody_walls", "targetname");
    var_58077680 = array("zone_jungle_lab_upper", "zone_swamp_lab_inside", "zone_operating_rooms");
    while(self.var_5f5af9f0 >= 15) {
      if(self zm_island_util::function_f2a55b5f(var_58077680) && self istouching(var_558d1e01)) {
        self function_f0e36b57();
        wait(randomintrange(360, 480));
      }
      wait(5);
    }
    self flag::clear("hallucination_bloodywalls_on");
  }
}

function function_5d3a5f36() {
  self hallucinate_spooky_sounds(1);
  wait(randomintrange(10, 20));
  self hallucinate_spooky_sounds(0);
}

function function_f0e36b57() {
  self hallucinate_bloody_walls(1);
  exploder::exploder("ex_ee_redtanks");
  wait(randomintrange(10, 20));
  self hallucinate_bloody_walls(0);
  exploder::stop_exploder("ex_ee_redtanks");
}

function hallucinate_bloody_walls(b_on = 1) {
  self clientfield::set_to_player("hallucinate_bloody_walls", b_on);
}

function hallucinate_spooky_sounds(b_on = 1) {
  self clientfield::set_to_player("hallucinate_spooky_sounds", b_on);
}

function function_c6d55b0d() {
  zm_devgui::add_custom_devgui_callback( & function_4c6daca1);
  adddebugcommand("");
  adddebugcommand("");
  adddebugcommand("");
  adddebugcommand("");
  adddebugcommand("");
}

function function_4c6daca1(cmd) {
  switch (cmd) {
    case "": {
      level.activeplayers[0] thread function_f0e36b57();
      return true;
    }
    case "": {
      level.activeplayers[0] thread function_5d3a5f36();
      return true;
    }
    case "": {
      level thread function_ef6cd11(5);
      return true;
    }
    case "": {
      level thread function_ef6cd11(10);
      return true;
    }
    case "": {
      level thread function_ef6cd11(20);
      return true;
    }
  }
  return false;
}

function function_ef6cd11(var_7156fcfa) {
  foreach(player in level.activeplayers) {
    player.var_5f5af9f0 = var_7156fcfa;
    if(var_7156fcfa > 5) {
      player thread function_51d3efd();
    }
    if(var_7156fcfa > 15) {
      player thread function_5d6bcf98();
    }
  }
}