/******************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: destructible_scripts\toy_locker_double.gsc
******************************************************/

#include common_scripts\_destructible;
#using_animtree("destructibles");

main() {
  destructible_create("toy_locker_double", "tag_origin", 150, undefined, 32, "no_melee");

  destructible_anim(%locker_broken_both_doors_1, #animtree, "setanimknob", undefined, 0, "locker_broken_both_doors_1");
  destructible_fx("tag_fx", "fx/props/locker_double_des_02_right", undefined, undefined, 0);
  destructible_sound("lockers_fast", undefined, 0);

  destructible_anim(%locker_broken_both_doors_2, #animtree, "setanimknob", undefined, 1, "locker_broken_both_doors_2");
  destructible_fx("tag_fx", "fx/props/locker_double_des_01_left", undefined, undefined, 1);
  destructible_sound("lockers_fast", undefined, 1);

  destructible_anim(%locker_broken_both_doors_4, #animtree, "setanimknob", undefined, 2, "locker_broken_both_doors_4");
  destructible_fx("tag_fx", "fx/props/locker_double_des_03_both", undefined, undefined, 2);
  destructible_sound("lockers_double", undefined, 2);

  destructible_anim(%locker_broken_door1_fast, #animtree, "setanimknob", undefined, 3, "locker_broken_door1_fast");
  destructible_fx("tag_fx", "fx/props/locker_double_des_01_left", undefined, undefined, 3);
  destructible_sound("lockers_fast", undefined, 3);

  destructible_anim(%locker_broken_door2_fast, #animtree, "setanimknob", undefined, 4, "locker_broken_door2_fast");
  destructible_fx("tag_fx", "fx/props/locker_double_des_02_right", undefined, undefined, 4);
  destructible_sound("lockers_fast", undefined, 4);

  destructible_anim(%locker_broken_both_doors_3, #animtree, "setanimknob", undefined, 5, "locker_broken_both_doors_3");
  destructible_fx("tag_fx", "fx/misc/no_effect", undefined, undefined, 5);
  destructible_sound("lockers_minor", undefined, 5);

  destructible_anim(%locker_broken_door1_slow, #animtree, "setanimknob", undefined, 6, "locker_broken_door1_slow");
  destructible_fx("tag_fx", "fx/misc/no_effect", undefined, undefined, 6);
  destructible_sound("lockers_minor", undefined, 6);

  destructible_anim(%locker_broken_door2_slow, #animtree, "setanimknob", undefined, 7, "locker_broken_door2_slow");
  destructible_fx("tag_fx", "fx/misc/no_effect", undefined, undefined, 7);
  destructible_sound("lockers_minor", undefined, 7);

  destructible_state(undefined, "com_locker_double_destroyed", undefined, undefined, "no_melee");
}