/**************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\ai_subclass\_subclass_militia.gsc
**************************************************/

#include maps\_utility;
#include common_scripts\utility;
#include animscripts\combat_utility;
#include animscripts\utility;
#include animscripts\ai_subclass\anims_table_militia;

subclass_militia() {
  if(self.type != "human") {
    return;
  }
  if(!issniper() && !usingshotgun()) {
    self.rambochance = 1.0;
    self.a.favor_blindfire = 1;
    self.a.favor_suppressedbehavior = 1;
  }

  self.a.neverlean = 1;
  self disable_react();
  self.noheatanims = 1;
  self.a.disablereacquire = 1;
  self.a.disablewoundedset = 1;
  self.grenadeawareness = 0;
  self.a.allow_sidearm = 0;
  self.a.nosmgpistolweaponanims = 1;
  self.aggressivemode = 1;
  self.canflank = 1;

  if(isDefined(level.randomizemilitiaarray) && level.randomizemilitiaarray) {
    if(randomint(100) > 50)
      setup_militia_anim_array();
  } else
    setup_militia_anim_array();
}