/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_zod_archetype.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\ai\zombie_utility;
#using scripts\shared\array_shared;
#namespace zm_zod_archetype;

function autoexec init() {
  zombie_utility::register_ignore_player_handler("margwa", &function_478e89a7);
  zombie_utility::register_ignore_player_handler("zombie", &function_478e89a7);
  level.raps_can_reach_inaccessible_location = &raps_can_reach_inaccessible_location;
  level.is_player_accessible_to_raps = &is_player_accessible_to_raps;
}

function private function_478e89a7() {
  self.ignore_player = [];
  foreach(player in level.players) {
    if(isDefined(player.teleporting) && player.teleporting) {
      array::add(self.ignore_player, player);
      continue;
    }
    if(isDefined(player.on_train) && player.on_train) {
      var_d3443466 = [[level.o_zod_train]] - > function_3e62f527();
      if(!(isDefined(self.locked_in_train) && self.locked_in_train) && (!(isDefined(var_d3443466) && var_d3443466))) {
        touching = [[level.o_zod_train]] - > is_touching_train_volume(self);
        if(!touching) {
          array::add(self.ignore_player, player);
        }
      }
    }
    if(isDefined(self.var_81ac9e79) && self.var_81ac9e79 && (!(isDefined(player.is_in_defend_area) && player.is_in_defend_area))) {
      array::add(self.ignore_player, player);
      continue;
    }
    if(isDefined(self.var_de609f65) && player !== self.var_de609f65) {
      array::add(self.ignore_player, player);
      continue;
    }
  }
}

function raps_can_reach_inaccessible_location() {
  if([[level.o_zod_train]] - > is_touching_train_volume(self)) {
    return true;
  }
  return false;
}

function is_player_accessible_to_raps(player) {
  if(isDefined(player.on_train) && player.on_train) {
    var_d3443466 = [[level.o_zod_train]] - > function_3e62f527();
    if(!(isDefined(self.locked_in_train) && self.locked_in_train) && (!(isDefined(var_d3443466) && var_d3443466))) {
      return false;
    }
  }
  return true;
}