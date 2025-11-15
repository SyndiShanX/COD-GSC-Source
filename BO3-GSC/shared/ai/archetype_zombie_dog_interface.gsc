/********************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\ai\archetype_zombie_dog_interface.gsc
********************************************************/

#using scripts\shared\ai\behavior_zombie_dog;
#using scripts\shared\ai\systems\ai_interface;
#namespace zombiedoginterface;

function registerzombiedoginterfaceattributes() {
  ai::registermatchedinterface("zombie_dog", "gravity", "normal", array("low", "normal"), & zombiedogbehavior::zombiedoggravity);
  ai::registermatchedinterface("zombie_dog", "min_run_dist", 500);
  ai::registermatchedinterface("zombie_dog", "sprint", 0, array(1, 0));
}