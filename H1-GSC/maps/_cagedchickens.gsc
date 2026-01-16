/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\_cagedchickens.gsc
********************************/

initchickens() {
  waittillframeend;
  var_0 = getentarray("caged_chicken", "targetname");
  common_scripts\utility::array_thread(var_0, ::spawnchicken);
}

spawnchicken() {
  var_0 = maps\_utility::spawn_anim_model("chicken");
  thread maps\_anim::anim_single_solo(var_0, "cage_freakout");
  var_1 = var_0 maps\_utility::getanim("cage_freakout");
  var_2 = randomfloatrange(0, 1.0);
  var_0 setanimtime(var_1, var_2);

  for (;;) {
    var_0 playsound("animal_chicken_idle", "sounddone");
    var_0 waittill("sounddone");
  }
}