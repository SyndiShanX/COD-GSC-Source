/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\_zm_ai_raz.csc
*************************************************/

#using scripts\shared\ai_shared;
#using scripts\shared\system_shared;
#using scripts\shared\visionset_mgr_shared;
#namespace zm_ai_raz;

function autoexec __init__sytem__() {
  system::register("zm_ai_raz", & __init__, & __main__, undefined);
}

function autoexec __init__() {
  level._effect["fx_raz_eye_glow"] = "dlc3/stalingrad/fx_raz_eye_glow";
  ai::add_archetype_spawn_function("raz", & function_f87a1709);
}

function __main__() {}

function function_f87a1709(localclientnum) {
  self._eyeglow_fx_override = level._effect["fx_raz_eye_glow"];
  self._eyeglow_tag_override = "tag_eye_glow";
}