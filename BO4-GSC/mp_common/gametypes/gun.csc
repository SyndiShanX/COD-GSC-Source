/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp_common\gametypes\gun.csc
***********************************************/

#namespace gun;

event_handler[gametype_init] main(eventstruct) {
  level.isgungame = 1;
  setdvar(#"hash_137c8b2b96ac6c72", 0.2);
  setdvar(#"compassradarpingfadetime", 0.75);
}