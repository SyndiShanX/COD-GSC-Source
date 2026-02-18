/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_544e81d6e48b88c0.csc
***********************************************/

#using scripts\core_common\territory_util;
#namespace namespace_99c84a33;

function function_99652b58(name, index, team) {
  cameras = getEntArray(0, index, "targetname");

  if(cameras.size) {
    addobjectivecamerapoint(index, team, #"none", cameras[0].origin, cameras[0].angles);
  }
}

function function_bb3bbc2c(name, index, team) {
  cameras = territory::function_5c7345a3(index, "targetname");

  if(cameras.size) {
    addobjectivecamerapoint(index, team, #"none", cameras[0].origin, cameras[0].angles);
  }
}