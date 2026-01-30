/***************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\mp\mp_prison_precache.gsc
***************************************************/

main() {
  common_scripts\utility::add_destructible_type_function("toy_locker_double", destructible_scripts\toy_locker_double::main);
  destructible_scripts\toy_locker_double::main();
}