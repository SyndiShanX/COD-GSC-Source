/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\_zm_light_zombie.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\_burnplayer;
#using scripts\shared\ai\archetype_utility;
#using scripts\shared\ai\systems\behavior_tree_utility;
#using scripts\shared\ai\systems\blackboard;
#using scripts\shared\ai\systems\debug;
#using scripts\shared\ai\systems\gib;
#using scripts\shared\ai\zombie_utility;
#using scripts\shared\ai_shared;
#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\flagsys_shared;
#using scripts\shared\fx_shared;
#using scripts\shared\math_shared;
#using scripts\shared\scene_shared;
#using scripts\shared\spawner_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm_devgui;
#using scripts\zm\_zm_elemental_zombies;
#namespace zm_light_zombie;

function autoexec __init__sytem__() {
  system::register("zm_light_zombie", &__init__, undefined, undefined);
}

function __init__() {
  register_clientfields();
  thread function_ff8b7145();
}

function private register_clientfields() {
  clientfield::register("actor", "light_zombie_clientfield_aura_fx", 15000, 1, "int");
  clientfield::register("actor", "light_zombie_clientfield_death_fx", 15000, 1, "int");
  clientfield::register("actor", "light_zombie_clientfield_damaged_fx", 15000, 1, "counter");
}

function function_a35db70f() {
  ai_zombie = self;
  var_715d2624 = zm_elemental_zombie::function_4aeed0a5("light");
  if(!isDefined(level.var_4a762097) || var_715d2624 < level.var_4a762097) {
    if(!isDefined(ai_zombie.is_elemental_zombie) || ai_zombie.is_elemental_zombie == 0) {
      ai_zombie.is_elemental_zombie = 1;
      ai_zombie.var_9a02a614 = "light";
      ai_zombie.health = int(ai_zombie.health * 1);
      ai_zombie thread light_zombie_death();
      ai_zombie thread function_68da949();
      ai_zombie thread function_cb744db7();
    }
  }
}

function function_cb744db7() {
  self endon("death");
  wait(2);
  self clientfield::set("light_zombie_clientfield_aura_fx", 1);
}

function function_68da949() {
  self endon("entityshutdown");
  self endon("death");
  while(true) {
    self waittill("damage");
    if(randomint(100) < 50) {
      self clientfield::increment("light_zombie_clientfield_damaged_fx");
    }
    wait(0.05);
  }
}

function light_zombie_death() {
  ai_zombie = self;
  ai_zombie waittill("death", attacker);
  if(!isDefined(ai_zombie) || ai_zombie.nuked === 1) {
    return;
  }
  v_origin = ai_zombie.origin;
  v_origin = v_origin + vectorscale((0, 0, 1), 2);
  ai_zombie clientfield::set("light_zombie_clientfield_death_fx", 1);
  ai_zombie zombie_utility::gib_random_parts();
  wait(0.05);
  var_e0d84aa = "MOD_EXPLOSIVE";
  radiusdamage(ai_zombie.origin + vectorscale((0, 0, 1), 35), 128, 30, 10, self, var_e0d84aa);
  a_players = getplayers();
  foreach(player in a_players) {
    player thread function_4745b0a9(ai_zombie.origin);
  }
  ai_zombie hide();
  ai_zombie notsolid();
}

function function_4745b0a9(flash_origin) {
  self endon("death");
  self endon("disconnect");
  player = self;
  dist_sq = distancesquared(player.origin, flash_origin);
  var_bfff29b1 = 16384;
  var_1536d9e9 = 4096;
  var_b79af7d4 = var_bfff29b1 - var_1536d9e9;
  if(dist_sq <= var_bfff29b1 && (!(isDefined(player.var_442e1e5b) && player.var_442e1e5b))) {
    if(dist_sq < var_1536d9e9) {
      flash_time = 1;
    } else {
      var_ff8b2f91 = (var_bfff29b1 - dist_sq) / var_b79af7d4;
      var_6e07e9bc = var_ff8b2f91 * 0.5;
      flash_time = 1 - var_6e07e9bc;
    }
    if(isDefined(flash_time)) {
      flash_time = math::clamp(flash_time, 0.5, 1);
      player thread function_2335214f(flash_time);
    }
  }
}

function function_2335214f(flash_time) {
  self endon("death");
  self endon("disconnect");
  player = self;
  player.var_442e1e5b = 1;
  player shellshock("light_zombie_death", flash_time, 0);
  wait(5);
  player.var_442e1e5b = 0;
}

function function_ff8b7145() {
  wait(0.05);
  level waittill("start_zombie_round_logic");
  wait(0.05);
  str_cmd = "";
  adddebugcommand(str_cmd);
  str_cmd = "";
  adddebugcommand(str_cmd);
  while(true) {
    string = getdvarstring("");
    if(string == "") {
      a_zombies = zm_elemental_zombie::function_d41418b8();
      if(a_zombies.size > 0) {
        foreach(zombie in a_zombies) {
          zombie function_a35db70f();
        }
      }
      setdvar("", "");
    }
    if(string == "") {
      a_zombies = zm_elemental_zombie::function_d41418b8();
      if(a_zombies.size > 0) {
        a_zombies = arraysortclosest(a_zombies, level.players[0].origin);
        a_zombies[0] function_a35db70f();
      }
      setdvar("", "");
    }
    wait(0.05);
  }
}