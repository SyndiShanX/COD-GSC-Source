/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_6e30b5532e5a1cd2.gsc
*************************************************/

#using script_3a8f9ace195c9da9;
#using scripts\common\utility;
#using scripts\cp_mp\fogofwar;
#using scripts\engine\utility;
#namespace namespace_a552950f139412a7;

function init() {
  scripts\engine\utility::registersharedfunc("fogofwar", "should_play_intro", &namespace_1170726b2799ea65::should_play_intro);
  setDvar(@ "hash_77d113f022f794", 1);
  setDvar(@ "hash_d79899fb31780dea", 0);
  setDvar(@ "hash_f74d46256f1f1833", 0);
  setDvar(@ "hash_5ea4ad60f090ee37", 0);
  setDvar(@ "hash_5cb9a2edac290a5a", 1150);
  setDvar(@ "hash_a5977b1881c200f9", 0.05);
  setDvar(@ "hash_b99ee24d4ab44550", 30);
  setDvar(@ "hash_f14b5a58d0c4c968", 600);
  setDvar(@ "hash_6122be3e1bbfdd4b", 590);
  setDvar(@ "hash_63a6ae1db0e57d7", 1);
  setDvar(@ "hash_9d6e77cba023265", 0.5);
  setDvar(@ "hash_83d363a370e55b35", 2);
  setDvar(@ "hash_4c33a1fbcdd8f052", 1);
  scripts\cp_mp\fogofwar::init();
}