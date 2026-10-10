/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\common\concussion_utility.gsc
****************************************************/

#using scripts\common\utility;
#using scripts\engine\utility;
#namespace concussion_utility;

function calculateinterruptdelay(duration) {
  return max(0, duration - 2.6) * 1000;
}