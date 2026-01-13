/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 2867.gsc
*********************************************/

func_95F3() {
  scripts\engine\utility::add_func_ref_MAYBE("setsaveddvar", ::setsaveddvar);
  scripts\engine\utility::add_func_ref_MAYBE("useanimtree", ::glinton);
  scripts\engine\utility::add_func_ref_MAYBE("setanim", ::give_attacker_kill_rewards);
  scripts\engine\utility::add_func_ref_MAYBE("setanimknob", ::setanimknob);
  scripts\engine\utility::add_func_ref_MAYBE("setflaggedanimknob", ::give_left_powers);
  scripts\engine\utility::add_func_ref_MAYBE("setflaggedanimknobrestart", ::func_82E7);
  scripts\engine\utility::add_func_ref_MAYBE("setanimlimited", ::func_82AC);
  scripts\engine\utility::add_func_ref_MAYBE("setanimtime", ::func_82B0);
  scripts\engine\utility::add_func_ref_MAYBE("getanimtime", ::getscoreinfocategory);
  scripts\engine\utility::add_func_ref_MAYBE("getanimlength", ::getanimlength);
  scripts\engine\utility::add_func_ref_MAYBE("clearanim", ::clearanim);
  scripts\engine\utility::add_func_ref_MAYBE("kill", ::func_81D0);
  scripts\engine\utility::add_func_ref_MAYBE("magicgrenade", ::magicgrenade);
  scripts\engine\utility::add_func_ref_MAYBE("connectPaths", ::connectpaths);
  scripts\engine\utility::add_func_ref_MAYBE("disconnectPaths", ::disconnectpaths);
  scripts\engine\utility::add_func_ref_MAYBE("makeEntitySentient", ::makeentitysentient);
  scripts\engine\utility::add_func_ref_MAYBE("laserForceOn", ::func_81D6);
  scripts\engine\utility::add_func_ref_MAYBE("laserForceOff", ::func_81D5);
  scripts\engine\utility::add_func_ref_MAYBE("badPlaceDelete", ::badplace_delete);
  scripts\engine\utility::add_func_ref_MAYBE("badPlaceCylinder", ::badplace_cylinder);
  scripts\engine\utility::add_func_ref_MAYBE("freeEntitySentient", ::freeentitysentient);
  scripts\engine\utility::add_func_ref_MAYBE("stat_track_kill_func", ::func_81D5);
  scripts\engine\utility::add_func_ref_MAYBE("laserForceOff", ::func_81D5);
  scripts\engine\utility::add_func_ref_MAYBE("getspawner", ::getspawner);
  level.var_5A5E = 1;
  level.var_2681 = 1;
  level.getnodefunction = ::getnode;
  level.getnodearrayfunction = ::getnodearray;
  level.var_179C = ::getnodeyawfromoffsettable;
  level.func_8134 = ::getspawnerarray;
}