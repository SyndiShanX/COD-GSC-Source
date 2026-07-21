/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\player_rig.gsc
***********************************************/

#using_animtree("player");

init_player_rig(var_0, var_1, var_2) {
  if(isDefined(var_0))
    precachemodel(var_0);

  if(isDefined(var_1))
    precachemodel(var_1);

  if(isDefined(var_0)) {
    level.scr_animtree["player_rig"] = #animtree;
    level.scr_model["player_rig"] = var_0;
  }

  if(isDefined(var_1)) {
    level.scr_animtree["player_legs"] = #animtree;
    level.scr_model["player_legs"] = var_1;
  }

  if(isDefined(var_2))
    init_player_body(var_2);
}

init_player_rig_no_precache(var_0, var_1, var_2) {
  if(isDefined(var_0)) {
    level.scr_animtree["player_rig"] = #animtree;
    level.scr_model["player_rig"] = var_0;
  }

  if(isDefined(var_1)) {
    level.scr_animtree["player_legs"] = #animtree;
    level.scr_model["player_legs"] = var_1;
  }

  if(isDefined(var_2))
    init_player_body(var_2);
}

#using_animtree("generic_human");

init_player_body(var_0) {
  level.scr_model["player_body"] = var_0;
  level.scr_animtree["player_body"] = #animtree;
}

get_player_rig(var_0) {
  if(!isDefined(level.player_rig)) {
    level.player_rig = scripts\engine\sp\utility::spawn_anim_model("player_rig");
    level.player_rig dontcastshadows();
    var_0 = 1;
  }

  if(isDefined(var_0)) {
    level.player_rig.origin = level.player.origin;
    level.player_rig.angles = level.player.angles;
  }

  return level.player_rig;
}

get_player_legs() {
  if(!isDefined(level.player_legs)) {
    level.player_legs = scripts\engine\sp\utility::spawn_anim_model("player_legs");
    level.player_legs.origin = level.player.origin;
    level.player_legs.angles = level.player.angles;
  }

  return level.player_legs;
}

get_player_body() {
  if(!isDefined(level.player_body)) {
    level.player_body = scripts\engine\sp\utility::spawn_anim_model("player_body");
    level.player_body.origin = level.player.origin;
    level.player_body.angles = level.player.angles;
  }

  return level.player_body;
}

link_player_to_arms(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_0))
    var_0 = 30;

  if(!isDefined(var_1))
    var_1 = 30;

  if(!isDefined(var_2))
    var_2 = 30;

  if(!isDefined(var_3))
    var_3 = 30;

  var_4 = get_player_rig();
  var_4 show();
  level.player playerlinktoabsolute(var_4, "tag_player");
  level.player playerlinktodelta(var_4, "tag_player", 1, var_0, var_1, var_2, var_3, 1);
}

blend_player_to_arms(var_0) {
  if(!isDefined(var_0))
    var_0 = 0.7;

  var_1 = get_player_rig();
  var_1 show();
  level.player playerlinktoblend(var_1, "tag_player", var_0);
}

set_player_rig_allows(var_0) {
  if(!isDefined(var_0))
    var_0 = ["weapon", "offhand_weapons", "melee", "sprint", "jump", "mantle"];

  level.player_rig.allows = var_0;
}

link_player_to_rig(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  var_12 = get_player_rig(1);
  var_12 endon("unlink_player");

  if(isDefined(var_10))
    var_12[[var_10]]();

  if(!isDefined(var_12.allows))
    set_player_rig_allows();

  var_12 hide();

  if(!istrue(var_11))
    thread scripts\sp\utility::delete_live_grenades();

  if(isDefined(var_0))
    thread scripts\common\anim::anim_first_frame_solo(var_12, var_0);

  var_12.ogstance = level.player getstance();

  if(!isDefined(var_1))
    var_1 = "stand";

  var_12.stance = var_1;

  switch (var_1) {
    case "stand":
      level.player scripts\common\utility::allow_crouch(0, "player_rig");
      level.player scripts\common\utility::allow_prone(0, "player_rig");
      break;
    case "crouch":
      level.player scripts\common\utility::allow_stand(0, "player_rig");
      level.player scripts\common\utility::allow_prone(0, "player_rig");
      break;
    case "prone":
      level.player scripts\common\utility::allow_stand(0, "player_rig");
      level.player scripts\common\utility::allow_crouch(0, "player_rig");
      break;
  }

  level.player setstance(var_1);
  level.player enablequickweaponswitch(1);
  level.player scripts\common\utility::allow_array(var_12.allows, 0, "player_rig");

  if(!isDefined(var_2))
    var_2 = 1;

  if(var_2) {
    if(!isDefined(var_3))
      var_3 = 0.2;

    level.player playerlinktoblend(var_12, "tag_player", var_3);
    wait(var_3);
    waitframe();
  }

  if(istrue(var_4))
    level.player playerlinktoabsolute(var_12, "tag_player");
  else {
    if(!isDefined(var_9))
      var_9 = 0;

    level.player playerlinktodelta(var_12, "tag_player", 1, 0, 0, 0, 0, var_9);

    if(!isDefined(var_5))
      var_5 = 45;

    if(!isDefined(var_6))
      var_6 = 45;

    if(!isDefined(var_7))
      var_7 = 15;

    if(!isDefined(var_8))
      var_8 = 15;

    if(var_5 || var_6 || var_7 || var_8)
      level.player lerpviewangleclamp(0.2, 0.1, 0.1, var_5, var_6, var_7, var_8);
  }

  var_12 show();
  scripts\sp\utility::nvidiaansel_scriptdisable(1);
  return var_12;
}

unlink_player_from_rig(var_0, var_1, var_2, var_3) {
  var_4 = level.player_rig;
  var_4 notify("unlink_player");

  if(!scripts\engine\utility::is_equal(level.player getlinkedparent(), var_4)) {
    return;
  }
  switch (var_4.stance) {
    case "stand":
      level.player scripts\common\utility::allow_crouch(1, "player_rig");
      level.player scripts\common\utility::allow_prone(1, "player_rig");
      break;
    case "crouch":
      level.player scripts\common\utility::allow_stand(1, "player_rig");
      level.player scripts\common\utility::allow_prone(1, "player_rig");
      break;
    case "prone":
      level.player scripts\common\utility::allow_stand(1, "player_rig");
      level.player scripts\common\utility::allow_crouch(1, "player_rig");
      break;
  }

  if(istrue(var_0))
    var_1 = var_4.ogstance;

  if(isDefined(var_1)) {
    if(istrue(var_2)) {
      level.player setstance(var_1, 1, 1, 1);
      var_5 = scripts\engine\utility::drop_to_ground(level.player getEye(), 0, -60, (0, 0, 1));
      level.player setOrigin(var_5, 1);
    } else if(var_1 != var_4.stance)
      level.player setstance(var_1);
  }

  level.player unlink();
  level.player enablequickweaponswitch(0);
  level.player scripts\common\utility::allow_array(var_4.allows, 1, "player_rig");

  if(!istrue(var_3))
    var_4 delete();

  scripts\sp\utility::nvidiaansel_scriptdisable(0);
}

anim_lerp_from_player_pos(var_0, var_1, var_2) {
  var_3 = level.player_rig;
  var_4 = getstartorigin(self.origin, self.angles, level.scr_anim[var_3.animname][var_0]);
  var_5 = getstartangles(self.origin, self.angles, level.scr_anim[var_3.animname][var_0]);
  var_6 = level.player.angles - var_5;
  var_7 = level.player.origin + rotatevector(self.origin - var_4, var_6);
  var_8 = level.player.angles + (self.angles - var_5);
  var_9 = scripts\engine\utility::spawn_script_origin(var_7, var_8);
  var_10 = getanimlength(var_3 scripts\engine\utility::getanim(var_0));

  if(!isDefined(var_1))
    var_1 = var_10;

  var_9 moveTo(self.origin, var_1, var_1 * 0.5, var_1 * 0.5);

  if(!isDefined(var_2))
    var_2 = var_10;

  var_9 rotateTo(self.angles, var_2, var_2 * 0.5, var_2 * 0.5);
  var_3 linkTo(var_9);
  var_9 thread scripts\common\anim::anim_single_solo(var_3, var_0);
  var_3 thread scripts\engine\utility::waittillmatch_notify("single anim", "end", "anim_end");
  var_3 scripts\engine\utility::waittill_any("anim_end", "unlink_player");
  var_9 delete();
}

player_rig_allow_weapon(var_0) {
  player_rig_allow_internal(var_0, "weapon");
}

player_rig_allow_internal(var_0, var_1) {
  var_0.allows = scripts\engine\utility::array_remove(var_0.allows, var_1);
  level.player thread[[level.allow_funcs[var_1]]](1, "player_rig");
}