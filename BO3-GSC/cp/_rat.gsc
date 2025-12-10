/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: cp\_rat.gsc
*************************************************/

#using scripts\cp\_util;
#using scripts\shared\rat_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#namespace rat;

function autoexec __init__sytem__() {
  system::register("", &__init__, undefined, undefined);
}

function __init__() {
  rat_shared::init();
  level.rat.common.gethostplayer = &util::gethostplayer;
}