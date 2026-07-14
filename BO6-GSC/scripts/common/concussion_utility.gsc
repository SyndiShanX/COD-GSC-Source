/*************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\common\concussion_utility.gsc
*************************************************/

#namespace concussion_utility;

function calculateinterruptdelay(duration) {
  return max(0, duration - 2.6) * 1000;
}