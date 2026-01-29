/*******************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\so_survival_mp_shipbreaker.gsc
*******************************************************/

main() {
  level.wave_table = "sp/so_survival/tier_2.csv";
  level.loadout_table = "sp/so_survival/tier_2.csv";
  maps\so_survival_mp_shipbreaker_precache::main();
  maps\mp\mp_shipbreaker_precache::main();
  maps\createart\mp_shipbreaker_art::main();
  maps\mp\mp_shipbreaker_fx::main();
  maps\createfx\mp_shipbreaker_fx::main();
  maps\_so_survival::_id_3F65();
  maps\_load::main();
  ambientplay("ambient_mp_shipbreaker");
  maps\_utility::set_vision_set("mp_shipbreaker", 0);
  maps\_so_survival::_id_3F66();
  maps\_compass::setupminimap("compass_map_mp_shipbreaker");
  maps\_so_survival::_id_3F67();
  level thread _id_0618::_id_6F52();
  level thread dog_at_ladder();
}

dog_at_ladder() {
  level endon("special_op_terminated");
  var_0 = getent("dog_at_ladder", "targetname");
  var_1 = getent("ladder_clip", "targetname");
  var_1 maps\_utility::_id_27C5();
  var_1 connectpaths();

  for(;;) {
    var_0 waittill("trigger", var_2);

    if(isDefined(var_2) && isDefined(var_2.type) && var_2.type == "dog") {
      var_1 maps\_utility::_id_27C6();
      var_1 disconnectpaths();
      wait 3.0;
      var_1 maps\_utility::_id_27C5();
      var_1 connectpaths();
    }
  }
}