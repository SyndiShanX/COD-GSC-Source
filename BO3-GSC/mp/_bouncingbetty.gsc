/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: mp\_bouncingbetty.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\mp\_util;
#using scripts\shared\callbacks_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\shared\weapons\_bouncingbetty;
#namespace bouncingbetty;

function autoexec __init__sytem__() {
  system::register("bouncingbetty", & __init__, undefined, undefined);
}

function __init__() {
  init_shared();
  level.trackbouncingbettiesonowner = 1;
}