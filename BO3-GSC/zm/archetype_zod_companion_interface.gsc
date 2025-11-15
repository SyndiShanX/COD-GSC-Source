/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\archetype_zod_companion_interface.gsc
*************************************************/

#using scripts\shared\ai\systems\ai_interface;
#using scripts\zm\archetype_zod_companion;
#namespace zodcompanioninterface;

function registerzodcompanioninterfaceattributes() {
  ai::registermatchedinterface("zod_companion", "sprint", 0, array(1, 0));
}