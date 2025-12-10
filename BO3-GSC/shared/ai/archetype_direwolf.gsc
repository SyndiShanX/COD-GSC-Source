/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\ai\archetype_direwolf.gsc
*************************************************/

#using scripts\shared\ai\behavior_zombie_dog;
#using scripts\shared\ai\systems\ai_interface;
#using scripts\shared\ai_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\spawner_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#namespace archetypedirewolf;

function autoexec __init__sytem__() {
  system::register("direwolf", &__init__, undefined, undefined);
}

function __init__() {
  spawner::add_archetype_spawn_function("direwolf", &zombiedogbehavior::archetypezombiedogblackboardinit);
  spawner::add_archetype_spawn_function("direwolf", &direwolfspawnsetup);
  ai::registermatchedinterface("direwolf", "sprint", 0, array(1, 0));
  ai::registermatchedinterface("direwolf", "howl_chance", 0.3);
  ai::registermatchedinterface("direwolf", "can_initiateaivsaimelee", 1, array(1, 0));
  ai::registermatchedinterface("direwolf", "spacing_near_dist", 120);
  ai::registermatchedinterface("direwolf", "spacing_far_dist", 480);
  ai::registermatchedinterface("direwolf", "spacing_horz_dist", 144);
  ai::registermatchedinterface("direwolf", "spacing_value", 0);
  if(ai::shouldregisterclientfieldforarchetype("direwolf")) {
    clientfield::register("actor", "direwolf_eye_glow_fx", 1, 1, "int");
  }
}

function private direwolfspawnsetup() {
  self setteam("team3");
  self allowpitchangle(1);
  self setpitchorient();
  self setavoidancemask("avoid all");
  self pushactors(1);
  self ai::set_behavior_attribute("spacing_value", randomfloatrange(-1, 1));
  self clientfield::set("direwolf_eye_glow_fx", 1);
}