/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3836.gsc
**************************************/

_id_967E() {
  precachemodel("sdf_cruise_missile_rack_clamp_01");
  precachemodel("sdf_cruise_missile_rack_link_01");
  precachemodel("sdf_cruise_missile_rack_01_rig");
  precachemodel("sdf_cruise_missile_rack_02_rig");
  precachemodel("sdf_cruise_missile_closed_01_black");
  precachemodel("sdf_cruise_missile_decals_black");
  precachemodel("sdf_cruise_missile_closed_01");
  precachemodel("sdf_cruise_missile_decals_white");
  precachemodel("sdf_cruise_missile_closed_01_red");
  precachemodel("sdf_cruise_missile_decals_red");
  _id_B7DF();
  _id_B7DE();
}

#using_animtree("script_model");

_id_B7DF() {
  level._id_EC87["missile_racks1"] = #animtree;
  level._id_EC8C["missile_racks1"] = "sdf_cruise_missile_rack_01_rig";
  level._id_EC87["missile_red_rack1"] = #animtree;
  level._id_EC8C["missile_red_rack1"] = "sdf_cruise_missile_closed_01_red";
  level._id_EC87["missile_red_dec_rack1"] = #animtree;
  level._id_EC8C["missile_red_dec_rack1"] = "sdf_cruise_missile_decals_red";
  level._id_EC87["missile_white_rack1"] = #animtree;
  level._id_EC8C["missile_white_rack1"] = "sdf_cruise_missile_closed_01";
  level._id_EC87["missile_white_dec_rack1"] = #animtree;
  level._id_EC8C["missile_white_dec_rack1"] = "sdf_cruise_missile_decals_white";
  level._id_EC87["missile_black_rack1"] = #animtree;
  level._id_EC8C["missile_black_rack1"] = "sdf_cruise_missile_closed_01_black";
  level._id_EC87["missile_black_dec_rack1"] = #animtree;
  level._id_EC8C["missile_black_dec_rack1"] = "sdf_cruise_missile_decals_black";
  level._id_EC87["missile_clamp_rack1"] = #animtree;
  level._id_EC8C["missile_clamp_rack1"] = "sdf_cruise_missile_rack_clamp_01";
  level._id_EC87["missile_link_rack1"] = #animtree;
  level._id_EC8C["missile_link_rack1"] = "sdf_cruise_missile_rack_link_01";
  level._id_EC87["missile_racks1"] = #animtree;
  level._id_EC85["missile_racks1"]["missile_racks_01"][0] = % sa_armory_missile_rack_01_loop;
  level._id_EC89["missile_racks1"]["missile_racks_01"] = 0;
  level._id_EC85["missile_racks1"]["missile_racks_01_fast"][0] = % sa_armory_missile_rack_01_loop_fast;
  level._id_EC89["missile_racks1"]["missile_racks_01_fast"] = 0;
  level._id_EC85["missile_racks1"]["missile_racks_01_slow"][0] = % sa_armory_missile_rack_01_loop_slow;
  level._id_EC89["missile_racks1"]["missile_racks_01_slow"] = 0;
  level._id_EC85["missile_racks1"]["missile_racks_01_slower"][0] = % sa_armory_missile_rack_01_loop_slower;
  level._id_EC89["missile_racks1"]["missile_racks_01_slower"] = 0;
  level._id_EC85["missile_racks1"]["missile_racks_01_slowest"][0] = % sa_armory_missile_rack_01_loop_slowest;
  level._id_EC89["missile_racks1"]["missile_racks_01_slowest"] = 0;
  level._id_EC87["missile_racks2"] = #animtree;
  level._id_EC8C["missile_racks2"] = "sdf_cruise_missile_rack_02_rig";
  level._id_EC87["missile_black_rack2"] = #animtree;
  level._id_EC8C["missile_black_rack2"] = "sdf_cruise_missile_closed_01_black";
  level._id_EC87["missile_black_dec_rack2"] = #animtree;
  level._id_EC8C["missile_black_dec_rack2"] = "sdf_cruise_missile_decals_black";
  level._id_EC87["missile_clamp_rack2"] = #animtree;
  level._id_EC8C["missile_clamp_rack2"] = "sdf_cruise_missile_rack_clamp_01";
  level._id_EC87["missile_link_rack2"] = #animtree;
  level._id_EC8C["missile_link_rack2"] = "sdf_cruise_missile_rack_link_01";
  level._id_EC87["missile_racks2"] = #animtree;
  level._id_EC85["missile_racks2"]["missile_racks_02"][0] = % sa_armory_missile_rack_02_loop;
  level._id_EC89["missile_racks2"]["missile_racks_02"] = 0;
  level._id_EC85["missile_racks2"]["missile_racks_02_fast"][0] = % sa_armory_missile_rack_02_loop_fast;
  level._id_EC89["missile_racks2"]["missile_racks_02_fast"] = 0;
  level._id_EC85["missile_racks2"]["missile_racks_02_slow"][0] = % sa_armory_missile_rack_02_loop_slow;
  level._id_EC89["missile_racks2"]["missile_racks_02_slow"] = 0;
  level._id_EC85["missile_racks2"]["missile_racks_02_slower"][0] = % sa_armory_missile_rack_02_loop_slower;
  level._id_EC89["missile_racks2"]["missile_racks_02_slower"] = 0;
  level._id_EC85["missile_racks2"]["missile_racks_02_slowest"][0] = % sa_armory_missile_rack_02_loop_slowest;
  level._id_EC89["missile_racks2"]["missile_racks_02_slowest"] = 0;
}

_id_B7DE() {
  scripts\sp\anim::_id_17F6("missile_racks1", "move", ::_id_B827, "missile_racks_01");
  scripts\sp\anim::_id_17F6("missile_racks1", "move", ::_id_B828, "missile_racks_01_fast");
  scripts\sp\anim::_id_17F6("missile_racks1", "move", ::_id_B829, "missile_racks_01_slow");
  scripts\sp\anim::_id_17F6("missile_racks1", "move", ::_id_B82A, "missile_racks_01_slower");
  scripts\sp\anim::_id_17F6("missile_racks1", "move", ::_id_B82B, "missile_racks_01_slowest");
  scripts\sp\anim::_id_17F6("missile_racks2", "move", ::_id_B827, "missile_racks_02");
  scripts\sp\anim::_id_17F6("missile_racks2", "move", ::_id_B828, "missile_racks_02_fast");
  scripts\sp\anim::_id_17F6("missile_racks2", "move", ::_id_B829, "missile_racks_02_slow");
  scripts\sp\anim::_id_17F6("missile_racks2", "move", ::_id_B82A, "missile_racks_02_slower");
  scripts\sp\anim::_id_17F6("missile_racks2", "move", ::_id_B82B, "missile_racks_02_slowest");
}

_id_F9D7() {
  if(isDefined(self.script_noteworthy) && self.script_noteworthy == "alt_rack") {
    var_0 = scripts\engine\utility::spawn_tag_origin(self._id_C6EA);
    var_1 = scripts\sp\utility::_id_10639("missile_racks2", var_0.origin);
    _id_892A(var_1, var_0, 15, 15, 14);
    wait(randomfloatrange(0.25, 1.75));
    var_2 = randomintrange(1, 5);

    switch (var_2) {
      case 1:
        var_0 scripts\sp\anim::_id_1EEA(var_1, "missile_racks_02");
      case 2:
        var_0 scripts\sp\anim::_id_1EEA(var_1, "missile_racks_02_fast");
      case 3:
        var_0 scripts\sp\anim::_id_1EEA(var_1, "missile_racks_02_slow");
      case 4:
        var_0 scripts\sp\anim::_id_1EEA(var_1, "missile_racks_02_slower");
      case 5:
        var_0 scripts\sp\anim::_id_1EEA(var_1, "missile_racks_02_slowest");
    }
  } else {
    var_0 = scripts\engine\utility::spawn_tag_origin(self._id_C6EA);
    var_1 = scripts\sp\utility::_id_10639("missile_racks1", var_0.origin);
    _id_892A(var_1, var_0, 20, 20, 19);
    wait(randomfloatrange(0.25, 1.75));
    var_2 = randomintrange(1, 5);

    switch (var_2) {
      case 1:
        var_0 scripts\sp\anim::_id_1EEA(var_1, "missile_racks_01");
      case 2:
        var_0 scripts\sp\anim::_id_1EEA(var_1, "missile_racks_01_fast");
      case 3:
        var_0 scripts\sp\anim::_id_1EEA(var_1, "missile_racks_01_slow");
      case 4:
        var_0 scripts\sp\anim::_id_1EEA(var_1, "missile_racks_01_slower");
      case 5:
        var_0 scripts\sp\anim::_id_1EEA(var_1, "missile_racks_01_slowest");
    }
  }
}

_id_4097() {
  if(isDefined(self._id_B893)) {
    self[[self._id_B893]]();
    self._id_B893 = undefined;
  }
}

_id_B892() {
  scripts\sp\utility::anim_stopanimScripted();

  if(isDefined(self._id_DBBD)) {
    foreach(var_1 in self._id_DBBD)
    var_1 delete();
  }
}

_id_892A(var_0, var_1, var_2, var_3, var_4) {
  self._id_B893 = ::_id_B892;
  self._id_DBBD = [];
  self._id_DBBC = var_0;
  self._id_DBBB = var_1;

  if(isDefined(self.script_noteworthy) && self.script_noteworthy == "alt_rack") {
    for(var_5 = 1; var_5 <= var_2; var_5++) {
      var_6 = scripts\sp\utility::_id_10639("missile_clamp_rack2", var_1.origin);
      var_6 linkTo(var_0, "tag_clamp_" + var_5, (0, 0, 0), (0, 0, 0));
      self._id_DBBD[self._id_DBBD.size] = var_6;
    }

    for(var_5 = 1; var_5 <= var_3; var_5++) {
      var_7 = scripts\sp\utility::_id_10639("missile_black_rack2", var_1.origin);
      var_7 linkTo(var_0, "tag_missile_" + var_5, (0, 0, 0), (0, 0, 0));
      self._id_DBBD[self._id_DBBD.size] = var_7;
    }

    for(var_5 = 1; var_5 <= var_4; var_5++) {
      var_8 = scripts\sp\utility::_id_10639("missile_link_rack1", var_1.origin);
      var_8 linkTo(var_0, "tag_link_" + var_5, (0, 0, 0), (0, 0, 0));
      self._id_DBBD[self._id_DBBD.size] = var_8;
    }
  }

  if(isDefined(self.script_noteworthy) && self.script_noteworthy == "black") {
    for(var_5 = 1; var_5 <= var_2; var_5++) {
      var_6 = scripts\sp\utility::_id_10639("missile_clamp_rack1", var_1.origin, var_1.angles);
      var_6 linkTo(var_0, "tag_clamp_" + var_5, (0, 0, 0), (0, 0, 0));
      self._id_DBBD[self._id_DBBD.size] = var_6;
    }

    for(var_5 = 1; var_5 <= var_3; var_5++) {
      var_7 = scripts\sp\utility::_id_10639("missile_black_rack1", var_1.origin, var_1.angles);
      var_7 linkTo(var_0, "tag_missile_" + var_5, (0, 0, 0), (0, 0, 0));
      self._id_DBBD[self._id_DBBD.size] = var_7;
    }

    for(var_5 = 1; var_5 <= var_4; var_5++) {
      var_8 = scripts\sp\utility::_id_10639("missile_link_rack1", var_1.origin, var_1.angles);
      var_8 linkTo(var_0, "tag_link_" + var_5, (0, 0, 0), (0, 0, 0));
      self._id_DBBD[self._id_DBBD.size] = var_8;
    }
  }

  if(isDefined(self.script_noteworthy) && self.script_noteworthy == "white") {
    for(var_5 = 1; var_5 <= var_2; var_5++) {
      var_6 = scripts\sp\utility::_id_10639("missile_clamp_rack1", var_1.origin, var_1.angles);
      var_6 linkTo(var_0, "tag_clamp_" + var_5, (0, 0, 0), (0, 0, 0));
      self._id_DBBD[self._id_DBBD.size] = var_6;
    }

    for(var_5 = 1; var_5 <= var_3; var_5++) {
      var_7 = scripts\sp\utility::_id_10639("missile_white_rack1", var_1.origin, var_1.angles);
      var_7 linkTo(var_0, "tag_missile_" + var_5, (0, 0, 0), (0, 0, 0));
      self._id_DBBD[self._id_DBBD.size] = var_7;
    }

    for(var_5 = 1; var_5 <= var_4; var_5++) {
      var_8 = scripts\sp\utility::_id_10639("missile_link_rack1", var_1.origin, var_1.angles);
      var_8 linkTo(var_0, "tag_link_" + var_5, (0, 0, 0), (0, 0, 0));
      self._id_DBBD[self._id_DBBD.size] = var_8;
    }
  }

  if(isDefined(self.script_noteworthy) && self.script_noteworthy == "red") {
    for(var_5 = 1; var_5 <= var_2; var_5++) {
      var_6 = scripts\sp\utility::_id_10639("missile_clamp_rack1", var_1.origin, var_1.angles);
      var_6 linkTo(var_0, "tag_clamp_" + var_5, (0, 0, 0), (0, 0, 0));
      self._id_DBBD[self._id_DBBD.size] = var_6;
    }

    for(var_5 = 1; var_5 <= var_3; var_5++) {
      var_7 = scripts\sp\utility::_id_10639("missile_red_rack1", var_1.origin, var_1.angles);
      var_7 linkTo(var_0, "tag_missile_" + var_5, (0, 0, 0), (0, 0, 0));
      self._id_DBBD[self._id_DBBD.size] = var_7;
    }

    for(var_5 = 1; var_5 <= var_4; var_5++) {
      var_8 = scripts\sp\utility::_id_10639("missile_link_rack1", var_1.origin, var_1.angles);
      var_8 linkTo(var_0, "tag_link_" + var_5, (0, 0, 0), (0, 0, 0));
      self._id_DBBD[self._id_DBBD.size] = var_8;
    }
  }
}

_id_B827(var_0) {
  thread scripts\engine\utility::play_sound_in_space("missile_rack_load", var_0.origin + (0, 0, 310));
  var_0 playSound("white_rack_fast");
}

_id_B828(var_0) {
  thread scripts\engine\utility::play_sound_in_space("missile_rack_load", var_0.origin + (0, 0, 310));
  var_0 playSound("black_rack_fastest");
}

_id_B829(var_0) {
  thread scripts\engine\utility::play_sound_in_space("missile_rack_load", var_0.origin + (0, 0, 310));
  var_0 playSound("white_rack_fast");
}

_id_B82A(var_0) {
  thread scripts\engine\utility::play_sound_in_space("missile_rack_load", var_0.origin + (0, 0, 310));
  var_0 playSound("red_rack_slow");
}

_id_B82B(var_0) {
  thread scripts\engine\utility::play_sound_in_space("missile_rack_load", var_0.origin + (0, 0, 310));
  var_0 playSound("white_rack_slowest");
}