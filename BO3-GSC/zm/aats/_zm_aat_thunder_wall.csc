/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\aats\_zm_aat_thunder_wall.csc
*************************************************/

#using scripts\shared\aat_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\system_shared;
#namespace zm_aat_thunder_wall;

function autoexec __init__sytem__() {
  system::register("zm_aat_thunder_wall", & __init__, undefined, undefined);
}

function __init__() {
  if(!(isDefined(level.aat_in_use) && level.aat_in_use)) {
    return;
  }
  aat::register("zm_aat_thunder_wall", "zmui_zm_aat_thunder_wall", "t7_icon_zm_aat_thunder_wall");
}