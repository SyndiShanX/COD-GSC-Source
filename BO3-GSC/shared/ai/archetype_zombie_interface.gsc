/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\ai\archetype_zombie_interface.gsc
*************************************************/

#using scripts\shared\ai\systems\ai_interface;
#using scripts\shared\ai\zombie;
#namespace zombieinterface;

function registerzombieinterfaceattributes() {
  ai::registermatchedinterface("zombie", "can_juke", 0, array(1, 0));
  ai::registermatchedinterface("zombie", "suicidal_behavior", 0, array(1, 0));
  ai::registermatchedinterface("zombie", "spark_behavior", 0, array(1, 0));
  ai::registermatchedinterface("zombie", "use_attackable", 0, array(1, 0));
}