/*****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\rumble_invasion\br_ri_ui.gsc
*****************************************************/

_id_13EEE() {
  var_0 = "_encstr_9A19040BCDBC";
  var_1 = level.start_reach_exhaust_waste._id_12E2C.ground_detection_think + vectorNormalize(level.start_reach_exhaust_waste._id_12E2C._id_136A8["_encstr_8E8405EA382B2A"]) * level.start_reach_exhaust_waste._id_12E2C.circle_radius * level.start_reach_exhaust_waste._id_12E2C._id_13631;
  var_2 = scripts\mp\gameobjects::createobjidobject(var_1, "_encstr_A7A408B9CA5D1D4E2C63", (0, 0, 0), undefined, var_0, 0);
  var_2.origin = var_1;
  scripts\mp\objidpoolmanager::update_objective_ownerteam(var_2.objidnum, "_encstr_8E8405EA382B2A");
  scripts\mp\objidpoolmanager::objective_teammask_addtomask(var_2.objidnum, "_encstr_8E8405EA382B2A");
  scripts\mp\objidpoolmanager::objective_set_play_intro(var_2.objidnum, 0);
  var_2.lockupdatingicons = 0;
  scripts\mp\objidpoolmanager::objective_pin_global(var_2.objidnum, 0);
  scripts\mp\objidpoolmanager::update_objective_icon(var_2.objidnum, "_encstr_8AF71A4B63BFC8B7D302D0A0DA6C9DC32768CF28FE63901B7DBA70E0");
  scripts\mp\objidpoolmanager::update_objective_setbackground(var_2.objidnum, 6);
  objective_state(var_2.objidnum, "_encstr_930B07BB1B6B3854FF");
  var_2.lockupdatingicons = 1;
  var_2.team = "_encstr_8E8405EA382B2A";
  level.spawn_set_jugg_value.choosecrouchorstandtac = var_2;
  level.spawn_set_jugg_value.choosecrouchorstandtac thread _id_13EF2();
  var_2 = scripts\mp\gameobjects::createobjidobject(var_1, "_encstr_A7A408B9CA5D1D4E2C63", (0, 0, 0), undefined, var_0, 0);
  var_2.origin = var_1;
  scripts\mp\objidpoolmanager::update_objective_ownerteam(var_2.objidnum, "_encstr_8E8405EA382B2A");
  scripts\mp\objidpoolmanager::objective_teammask_addtomask(var_2.objidnum, "_encstr_9A8507BA4040188D08");
  scripts\mp\objidpoolmanager::objective_set_play_intro(var_2.objidnum, 0);
  var_2.lockupdatingicons = 0;
  scripts\mp\objidpoolmanager::objective_pin_global(var_2.objidnum, 0);
  scripts\mp\objidpoolmanager::update_objective_icon(var_2.objidnum, "_encstr_AAD017D28DDE73D7BB582F1CEDA573A3EB86177D95B92B6BBC");
  scripts\mp\objidpoolmanager::update_objective_setbackground(var_2.objidnum, 7);
  objective_state(var_2.objidnum, "_encstr_930B07BB1B6B3854FF");
  var_2.lockupdatingicons = 1;
  var_2.team = "_encstr_8E8405EA382B2A";
  level.spawn_set_jugg_value.choosebestpropforkillcam = var_2;
  level.spawn_set_jugg_value.choosebestpropforkillcam thread _id_13EF2();
  level.spawn_set_jugg_value.choosebestpropforkillcam thread _encstr_8EB9354A267D0AD02B300E0F4028BFF22B4D1340178B63473193D75FD058756BBB5FDF71FE03DA52D850DF6F80D32943737865A5EC77F2::_id_11AFF("_encstr_8E8405EA382B2A");
  var_1 = level.start_reach_exhaust_waste._id_12E2C.ground_detection_think + vectorNormalize(level.start_reach_exhaust_waste._id_12E2C._id_136A8["_encstr_9A8507BA4040188D08"]) * level.start_reach_exhaust_waste._id_12E2C.circle_radius * level.start_reach_exhaust_waste._id_12E2C._id_13631;
  var_2 = scripts\mp\gameobjects::createobjidobject(var_1, "_encstr_A7A408B9CA5D1D4E2C63", (0, 0, 0), undefined, var_0, 0);
  var_2.origin = var_1;
  scripts\mp\objidpoolmanager::update_objective_ownerteam(var_2.objidnum, "_encstr_9A8507BA4040188D08");
  scripts\mp\objidpoolmanager::objective_teammask_addtomask(var_2.objidnum, "_encstr_9A8507BA4040188D08");
  scripts\mp\objidpoolmanager::objective_set_play_intro(var_2.objidnum, 0);
  var_2.lockupdatingicons = 0;
  scripts\mp\objidpoolmanager::objective_pin_global(var_2.objidnum, 0);
  scripts\mp\objidpoolmanager::update_objective_icon(var_2.objidnum, "_encstr_8AF71A4B63BFC8B7D302D0A0DA6C9DC32768CF28FE63901B7DBA70E0");
  scripts\mp\objidpoolmanager::update_objective_setbackground(var_2.objidnum, 6);
  objective_state(var_2.objidnum, "_encstr_930B07BB1B6B3854FF");
  var_2.lockupdatingicons = 1;
  var_2.team = "_encstr_9A8507BA4040188D08";
  level.spawn_set_jugg_value.brjugg_cleanupents = var_2;
  level.spawn_set_jugg_value.brjugg_cleanupents thread _id_13EF2();
  var_2 = scripts\mp\gameobjects::createobjidobject(var_1, "_encstr_A7A408B9CA5D1D4E2C63", (0, 0, 0), undefined, var_0, 0);
  var_2.origin = var_1;
  scripts\mp\objidpoolmanager::update_objective_ownerteam(var_2.objidnum, "_encstr_9A8507BA4040188D08");
  scripts\mp\objidpoolmanager::objective_teammask_addtomask(var_2.objidnum, "_encstr_8E8405EA382B2A");
  scripts\mp\objidpoolmanager::objective_set_play_intro(var_2.objidnum, 0);
  var_2.lockupdatingicons = 0;
  scripts\mp\objidpoolmanager::objective_pin_global(var_2.objidnum, 0);
  scripts\mp\objidpoolmanager::update_objective_icon(var_2.objidnum, "_encstr_AAD017D28DDE73D7BB582F1CEDA573A3EB86177D95B92B6BBC");
  scripts\mp\objidpoolmanager::update_objective_setbackground(var_2.objidnum, 7);
  objective_state(var_2.objidnum, "_encstr_930B07BB1B6B3854FF");
  var_2.lockupdatingicons = 1;
  var_2.team = "_encstr_9A8507BA4040188D08";
  level.spawn_set_jugg_value.briskillstreakallowed = var_2;
  level.spawn_set_jugg_value.briskillstreakallowed thread _id_13EF2();
  level.spawn_set_jugg_value.briskillstreakallowed thread _encstr_8EB9354A267D0AD02B300E0F4028BFF22B4D1340178B63473193D75FD058756BBB5FDF71FE03DA52D850DF6F80D32943737865A5EC77F2::_id_11AFF("_encstr_9A8507BA4040188D08");
}

_id_13EF2() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  scripts\mp\flags::gameflagwait("_encstr_B26119F0F51873D0A9E68D5FFF3A9BA9FF2628F61968B09893D2D8");
  var_0 = scripts\engine\utility::ter_op(self.team == "_encstr_8E8405EA382B2A", level.spawn_set_jugg_value.chosen, level.spawn_set_jugg_value.choppersupport_watchtargetrange);

  if(!isDefined(var_0)) {
    return;
  }
  self.origin = var_0;
  scripts\mp\objidpoolmanager::update_objective_position(self.objidnum, var_0);
}

_id_13EE7() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(self.team == "_encstr_9A8507BA4040188D08") {
    scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(level.spawn_set_jugg_value.brjugg_cleanupents.objidnum, self);
    scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(level.spawn_set_jugg_value.choosebestpropforkillcam.objidnum, self);
  } else {
    scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(level.spawn_set_jugg_value.briskillstreakallowed.objidnum, self);
    scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(level.spawn_set_jugg_value.choosecrouchorstandtac.objidnum, self);
  }
}

_id_12425(var_0, var_1, var_2) {
  var_3 = undefined;

  if(isDefined(var_2)) {
    var_3 = spawnStruct();
    var_3.intvar = var_2;
  }

  if(isalive(var_0))
    _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::displayplayersplash(var_0, var_1, var_3);
  else
    var_0 thread _id_12981(_encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::displayplayersplash(var_0, var_1, var_3));
}

_id_12424(var_0, var_1) {
  foreach(var_3 in level.players) {
    if(!isDefined(var_3)) {
      continue;
    }
    var_4 = undefined;

    if(isalive(var_3)) {
      if(isDefined(var_1)) {
        var_4 = spawnStruct();
        var_4.intvar = var_1;
      }

      _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::displayplayersplash(var_3, var_0, var_4);
      continue;
    }

    if(!isDefined(var_4))
      var_4 = spawnStruct();

    var_4.intvar = var_1;
    var_4._id_136F3 = var_0;
    var_3 thread _id_12981(var_4);
  }
}

_id_12981(var_0) {
  self notify("_encstr_999A1C873190FC61366933FF9753A921E8997B4FEE50925A046F1FBB930D");
  self endon("_encstr_999A1C873190FC61366933FF9753A921E8997B4FEE50925A046F1FBB930D");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(!isDefined(self.isflagcarrymode))
    self.isflagcarrymode = [];

  self.isflagcarrymode = scripts\engine\utility::array_add(self.isflagcarrymode, var_0);

  while(self.isflagcarrymode.size > 0) {
    if(isalive(self)) {
      wait 0.5;

      foreach(var_2 in self.isflagcarrymode)
      _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::displayplayersplash(self, var_2._id_136F3, var_2);

      self.isflagcarrymode = [];
      break;
    }

    wait 1.0;
  }
}