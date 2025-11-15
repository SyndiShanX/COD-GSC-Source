/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_moon_ffotd.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\ai\zombie_utility;
#using scripts\shared\array_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\flagsys_shared;
#using scripts\shared\math_shared;
#using scripts\shared\util_shared;
#namespace zm_moon_ffotd;

function main_start() {
  level thread spawned_collision_ffotd();
}

function main_end() {
  spawncollision("collision_player_64x64x256", "collider", (76, 5552, 328), vectorscale((0, 1, 0), 270));
  spawncollision("collision_player_64x64x256", "collider", (76, 5552, 584), vectorscale((0, 1, 0), 270));
  spawncollision("collision_player_64x64x256", "collider", (140, 5552, 328), vectorscale((0, 1, 0), 270));
  spawncollision("collision_player_64x64x256", "collider", (140, 5552, 584), vectorscale((0, 1, 0), 270));
  spawncollision("collision_player_wall_512x512x10", "collider", (1473, 6312, 712), vectorscale((0, 1, 0), 240));
  spawncollision("collision_player_wall_256x256x10", "collider", (-590, 1165, -165), (0, 0, 0));
  spawncollision("collision_player_wall_256x256x10", "collider", (66.933, 7228.8, 221.5), vectorscale((0, 1, 0), 322.599));
  spawncollision("collision_player_wall_256x256x10", "collider", (45.067, 7200.2, 221.5), vectorscale((0, 1, 0), 322.599));
  spawncollision("collision_player_wall_256x256x10", "collider", (175.961, 7144.78, 223.472), vectorscale((0, 1, 0), 322.399));
  spawncollision("collision_player_wall_256x256x10", "collider", (153.995, 7116.25, 223.472), vectorscale((0, 1, 0), 322.399));
  spawncollision("collision_player_slick_wedge_32x256", "collider", (198.789, 7135.46, 344.998), (271.276, 284.062, 128.652));
  spawncollision("collision_player_slick_wedge_32x256", "collider", (170.789, 7098.46, 344.998), (271.276, 284.062, 128.652));
  spawncollision("collision_player_slick_wedge_32x256", "collider", (76.289, 7229.46, 344.998), (271.276, 284.062, 128.652));
  spawncollision("collision_player_slick_wedge_32x256", "collider", (48.289, 7192.46, 344.998), (271.276, 284.062, 128.652));
  spawncollision("collision_player_slick_wedge_32x256", "collider", (-155.692, 3850.08, -52.5), vectorscale((0, 1, 0), 175.099));
}

function spawned_collision_ffotd() {
  level flagsys::wait_till("start_zombie_round_logic");
}