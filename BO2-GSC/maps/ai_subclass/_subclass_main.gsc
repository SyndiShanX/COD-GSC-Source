/***********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\ai_subclass\_subclass_main.gsc
***********************************************/

#include maps\_utility;
#include common_scripts\utility;
#include animscripts\combat_utility;
#include animscripts\utility;
#include animscripts\ai_subclass\anims_table_militia;
#include maps\ai_subclass\_subclass_militia;
#include animscripts\ai_subclass\anims_table_dualwield;
#include maps\ai_subclass\_subclass_dualwield;
#include animscripts\ai_subclass\anims_table_elite;
#include maps\ai_subclass\_subclass_elite;

subclass_setup_spawn_functions() {
  if(!isDefined(level.subclass_spawn_functions))
    level.subclass_spawn_functions = [];

  level.subclass_spawn_functions["regular"] = ::subclass_regular;
  level.subclass_spawn_functions["militia"] = ::subclass_militia;
  level.subclass_spawn_functions["dualwield"] = ::subclass_dualwield;
  level.subclass_spawn_functions["elite"] = ::subclass_elite;
}

run_subclass_spawn_function() {
  assert(isDefined(level.subclass_spawn_functions[self.subclass]), "subclass spawn function not defined for '" + self.subclass + "'");
  [[level.subclass_spawn_functions[self.subclass]]]();
}

subclass_regular() {
  if(self.team == "allies")
    subclass_regular_allies();
  else
    subclass_regular_axis();
}

subclass_regular_allies() {
  self.a.disablewoundedset = 1;
  self.a.neversprintforvariation = 1;
  self.a.favor_lean = 1;
  self.maxfaceenemydist = 350;
}

subclass_regular_axis() {
}