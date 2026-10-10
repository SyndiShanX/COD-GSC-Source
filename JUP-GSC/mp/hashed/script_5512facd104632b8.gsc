/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_5512facd104632b8.gsc
*************************************************/

#using scripts\engine\utility;
#namespace zombie_pain;

function isinpain(taskid, params) {
  if(!ent_flag("in_pain")) {
    return anim.failure;
  }

  return anim.success;
}