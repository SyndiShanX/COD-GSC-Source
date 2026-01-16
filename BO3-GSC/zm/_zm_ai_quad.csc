/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\_zm_ai_quad.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\system_shared;
#using scripts\shared\visionset_mgr_shared;
#namespace zm_ai_quad;

function autoexec __init__sytem__() {
  system::register("zm_ai_quad", & __init__, undefined, undefined);
}

function __init__() {
  visionset_mgr::register_overlay_info_style_blur("zm_ai_quad_blur", 21000, 1, 0.1, 0.5, 4);
}