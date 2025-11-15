/*****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\oilrocks_achievement.gsc
*****************************************/

main() {
  var_0 = spawnStruct();
  var_0.count = 0;
  var_0.total = 0;
  var_0 endon("got_achievement");
  var_1 = ["oilrocks_storagetank_lg", "oilrocks_storagetank_sml", "oilrocks_gastank1_scale1pt5", "oilrocks_gastank1_large"];
  var_2 = [];

  foreach(var_4 in getscriptablearray()) {
    if(common_scripts\utility::array_contains(var_1, var_4.model)) {
      var_2[var_2.size] = var_4;
      var_4.basemodel = var_4.model;
    }
  }

  var_0 childthread detect_scriptables_death(var_2);

  foreach(var_7 in getEntArray("script_model", "code_classname")) {
    if(common_scripts\utility::array_contains(var_1, var_7.model))
      var_0 childthread detect_exploder_death(var_7, var_7.model);
  }
}

detect_scriptables_death(var_0) {
  self.total = self.total + var_0.size;
  var_1 = 0;

  for(;;) {
    foreach(var_3 in var_0) {
      var_1++;
      var_1 = var_1 % 5;

      if(var_1 == 0)
        wait 0.05;

      if(!isDefined(var_3)) {
        continue;
      }
      if(isDefined(var_3.achieved)) {
        continue;
      }
      if(var_3.model != var_3.basemodel) {
        var_3.achieved = 1;
        achievement_add_count();
      }
    }

    wait 0.05;
  }
}

detect_exploder_death(var_0, var_1) {
  self.total++;
  var_0 waittill("entitydeleted");
  achievement_add_count();
}

achievement_add_count() {
  self.count++;

  if(self.count > 80) {
    level.player maps\_utility::player_giveachievement_wrapper("LEVEL_8A");
    self notify("got_achievement");
  }
}