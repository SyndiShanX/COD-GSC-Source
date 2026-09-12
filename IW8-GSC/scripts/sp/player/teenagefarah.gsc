/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\player\teenagefarah.gsc
***********************************************/

function teenage_farah_precache() {
  precachesuit("iw8_teenager_sneak");
  precachesuit("iw8_teenager_combat");
}

function teenage_farah_setup() {
  scripts\common\utility::allow_armor(0);

  if(level.player ispcplayer()) {
    setsaveddvar("r_zPlanes", "0.1 500 1.5 10000");
    return;
  }
}

function teenage_farah_cell_setup() {
  level.player.currentsetup = "cell";
  level.player setsuit("iw8_teenager_sneak");
  set_player_viewmodel("viewhands_farah_55inch_prisoner", undefined, "default_character_shadow");
  level.player.currentspeedscale = 0.25;
  level.player.currentpronespeedscale = 1;

  if(level.player getstance() == "prone") {
    level.player setmovespeedscale(level.player.currentpronespeedscale);
  } else {
    level.player setmovespeedscale(level.player.currentspeedscale);
  }

  thread prone_speedup();
  level.player modifybasefov(50, 0.1);
  var_0 = scripts\sp\utility::make_weapon("iw8_gunless_teen_farah");
  level.player giveweapon(var_0);
  level.player switchtoweapon(var_0);
  level.player scripts\common\utility::allow_melee(0, "cell_setup");
  level.player scripts\common\utility::allow_mantle(0, "cell_setup");
}

function teenage_farah_stealth_setup() {
  if(isDefined(level.player.currentsetup) && level.player.currentsetup == "cell") {
    level.player setsuit("iw8_teenager_sneak");
    level thread scripts\sp\maps\captive\captive_util::player_speed_lerp(0.4, 1, 10);
    level.player.currentpronespeedscale = 1.25;

    if(level.player getstance() == "prone") {
      level.player setmovespeedscale(level.player.currentpronespeedscale);
    }

    level.player scripts\common\utility::allow_mantle(1, "cell_setup");
    level.player scripts\common\utility::allow_melee(1, "cell_setup");
    level.player scripts\sp\utility::take_weapon("iw8_gunless_teen_farah");
  } else {
    level.player.currentsetup = "stealth";
    level.player setsuit("iw8_teenager_sneak");
    set_player_viewmodel("viewhands_farah_55inch_prisoner", undefined, "default_character_shadow");
    level.player.currentspeedscale = 1;
    level.player.currentpronespeedscale = 1.25;

    if(level.player getstance() == "prone") {
      level.player setmovespeedscale(level.player.currentpronespeedscale);
    } else {
      level.player setmovespeedscale(level.player.currentspeedscale);
    }

    thread prone_speedup();
    level.player modifybasefov(50, 0.05);
  }

  var_0 = scripts\sp\utility::make_weapon("iw8_farahspoon_sp");
  level.player giveweapon(var_0);
  level.player switchtoweapon(var_0);
}

function teenage_farah_combat_setup() {
  if(isDefined(level.player.currentsetup)) {
    level.player.currentsetup = "combat";
    level.player setsuit("iw8_teenager_combat");
    level.player.currentspeedscale = 1;
    level.player.currentpronespeedscale = 1.15;
    return;
  }

  level.player.currentsetup = "combat";
  level.player setsuit("iw8_teenager_combat");
  set_player_viewmodel("viewhands_farah_55inch_prisoner_dirt", undefined, "default_character_shadow");
  level.player.currentspeedscale = 1;
  level.player.currentpronespeedscale = 1.15;

  if(level.player getstance() == "prone") {
    level.player setmovespeedscale(level.player.currentpronespeedscale);
  } else {
    level.player setmovespeedscale(level.player.currentspeedscale);
  }

  thread prone_speedup();
  var_0 = scripts\sp\utility::make_weapon("iw8_pi_golf21_tfarah");
  level.player scripts\sp\utility::give_weapon(var_0);
  var_1 = scripts\sp\utility::make_weapon("iw8_ar_akilo47_tfarah");
  level.player giveweapon(var_1);
  level.player switchtoweapon(var_1);
  level.player modifybasefov(55, 0.05);
}

function set_player_viewmodel(var_0, var_1, var_2) {
  if(isDefined(var_0)) {
    level.player setviewmodel(var_0);
  }

  if(isDefined(var_1)) {}

  if(isDefined(var_2)) {
    level.player setshadowmodel(var_2);
    return;
  }
}

function prone_speedup() {
  for(;;) {
    while(self getstance() != "prone") {
      waitframe();
    }

    self setmovespeedscale(level.player.currentpronespeedscale);

    while(self getstance() == "prone") {
      waitframe();
    }

    self setmovespeedscale(level.player.currentspeedscale);
  }
}

function set_to_combat_speed() {
  level.player.currentspeedscale = 1;
  level.player.currentpronespeedscale = 1.25;

  if(level.player getstance() == "prone") {
    level.player setmovespeedscale(level.player.currentpronespeedscale);
    return;
  }

  level.player setmovespeedscale(level.player.currentspeedscale);
}