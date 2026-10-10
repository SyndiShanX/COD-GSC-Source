/*********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\cp_mp\vehicles\vehicle_utility.gsc
*********************************************************/

#using scripts\engine\utility;
#namespace vehicle_utility;

function function_bbdfa26a1db6eb7b() {
  return isDefined(self) && isDefined(level.escortvehicles) && array_contains(level.escortvehicles, self);
}