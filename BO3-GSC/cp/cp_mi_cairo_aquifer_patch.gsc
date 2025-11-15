/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: cp\cp_mi_cairo_aquifer_patch.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\cp\_load;
#using scripts\cp\_objectives;
#using scripts\cp\_util;
#using scripts\shared\ai_shared;
#using scripts\shared\array_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\spawner_shared;
#using scripts\shared\trigger_shared;
#using scripts\shared\util_shared;
#using scripts\shared\vehicle_shared;
#using scripts\shared\vehicles\_quadtank;
#namespace namespace_a52a2a1d;

function function_7403e82b() {
  spawncollision("collision_clip_wall_512x512x10", "collider", (11119, 2965, 2620), vectorscale((0, 1, 0), 270));
}