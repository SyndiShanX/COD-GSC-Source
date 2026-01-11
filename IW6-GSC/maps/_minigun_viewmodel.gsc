/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_minigun_viewmodel.gsc
***************************************/

#using_animtree("vehicles");

player_viewhands_minigun(var_0, var_1, var_2) {
  if(!isDefined(var_1)) {
    var_1 = "viewhands_player_us_army";
  }

  var_0 useanimtree(#animtree);

  if(!isDefined(var_2)) {
    var_0.animname = "suburban_hands";
  } else {
    var_0.animname = var_2;
  }

  var_0.has_hands = 0;
  var_0 show_hands(var_1);
  var_0 set_idle();
  var_0 thread player_viewhands_minigun_hand("LEFT");
  var_0 thread player_viewhands_minigun_hand("RIGHT");
  var_0 thread handle_mounting(var_1);
}

set_idle() {
  self setanim(maps\_utility::getanim("idle_L"), 1, 0, 1);
  self setanim(maps\_utility::getanim("idle_R"), 1, 0, 1);
}

handle_mounting(var_0) {
  var_1 = self;
  var_1 endon("death");

  for(;;) {
    var_1 waittill("turretownerchange");
    var_2 = var_1 getturretowner();

    if(!isalive(var_2)) {
      hide_hands(var_0);
      continue;
    }

    show_hands(var_0);
  }
}

show_hands(var_0) {
  if(!isDefined(var_0)) {
    var_0 = "viewhands_player_us_army";
  }

  var_1 = self;

  if(var_1.has_hands) {
    return;
  }
  var_1 dontcastshadows();
  var_1.has_hands = 1;
  var_1 attach(var_0, "tag_player");
}

hide_hands(var_0) {
  if(!isDefined(var_0)) {
    var_0 = "viewhands_player_us_army";
  }

  var_1 = self;

  if(!var_1.has_hands) {
    return;
  }
  var_1 castshadows();
  var_1.has_hands = 0;
  var_1 detach(var_0, "tag_player");
}

anim_minigun_hands() {
  level.scr_animtree["suburban_hands"] = #animtree;
  level.scr_model["suburban_hands"] = "viewhands_player_us_army";
  level.scr_anim["suburban_hands"]["idle_L"] = % player_suburban_minigun_idle_l;
  level.scr_anim["suburban_hands"]["idle_R"] = % player_suburban_minigun_idle_r;
  level.scr_anim["suburban_hands"]["idle2fire_L"] = % player_suburban_minigun_idle2fire_l;
  level.scr_anim["suburban_hands"]["idle2fire_R"] = % player_suburban_minigun_idle2fire_r;
  level.scr_anim["suburban_hands"]["fire2idle_L"] = % player_suburban_minigun_fire2idle_l;
  level.scr_anim["suburban_hands"]["fire2idle_R"] = % player_suburban_minigun_fire2idle_r;
}

player_viewhands_minigun_hand(var_0) {
  self endon("death");
  var_1 = undefined;

  if(var_0 == "LEFT") {
    var_1 = ::spinbuttonpressed;
  } else if(var_0 == "RIGHT") {
    var_1 = ::firebuttonpressed;
  }

  for(;;) {
    if(level.player[[var_1]]()) {
      thread player_viewhands_minigun_presed(var_0);

      while(level.player[[var_1]]()) {
        wait 0.05;
      }

      continue;
    }

    thread player_viewhands_minigun_idle(var_0);

    while(!level.player[[var_1]]()) {
      wait 0.05;
    }
  }
}

spinbuttonpressed() {
  if(level.player adsbuttonpressed()) {
    return 1;
  }

  if(level.player attackbuttonpressed()) {
    return 1;
  }

  return 0;
}

firebuttonpressed() {
  return level.player attackbuttonpressed();
}

player_viewhands_minigun_idle(var_0) {
  var_1 = undefined;

  if(var_0 == "LEFT") {
    var_1 = "L";
  } else if(var_0 == "RIGHT") {
    var_1 = "R";
  }

  self clearanim(maps\_utility::getanim("idle2fire_" + var_1), 0.2);
  self setflaggedanimrestart("anim", maps\_utility::getanim("fire2idle_" + var_1));
  self waittillmatch("anim", "end");
  self clearanim(maps\_utility::getanim("fire2idle_" + var_1), 0.2);
  self setanim(maps\_utility::getanim("idle_" + var_1));
}

player_viewhands_minigun_presed(var_0) {
  var_1 = undefined;

  if(var_0 == "LEFT") {
    var_1 = "L";
  } else if(var_0 == "RIGHT") {
    var_1 = "R";
  }

  self clearanim(maps\_utility::getanim("idle_" + var_1), 0.2);
  self setanim(maps\_utility::getanim("idle2fire_" + var_1));
}