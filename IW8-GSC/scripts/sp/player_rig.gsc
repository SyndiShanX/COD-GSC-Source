/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\player_rig.gsc
***********************************************/

#using_animtree("");

function init_player_rig(var0, var1, var2) {
  if(isDefined(var0)) {
    precachemodel(var0);
  }

  if(isDefined(var1)) {
    precachemodel(var1);
  }

  if(isDefined(var0)) {
    level.scr_animtree["player_rig"] = #animtree;
    level.scr_model["player_rig"] = var0;
  }

  if(isDefined(var1)) {
    level.scr_animtree["player_legs"] = $;
    level.scr_model["player_legs"] = var1;
  }

  if(isDefined(var2)) {
    init_player_body(var2);
    return;
  }
}

function init_player_rig_no_precache(var0, var1, var2) {
  if(isDefined(var0)) {
    level.scr_animtree["player_rig"] = #animtree;
    level.scr_model["player_rig"] = var0;
  }

  if(isDefined(var1)) {
    level.scr_animtree["player_legs"] = #animtree;
    level.scr_model["player_legs"] = var1;
  }

  if(isDefined(var2)) {
    init_player_body(var2);
    return;
  }
}

#using_animtree("generic_human");

function init_player_body(var0) {
  level.scr_model["player_body"] = var0;
  level.scr_animtree["player_body"] = #animtree;
}

function get_player_rig(var0) {
  if(!isDefined(level.player_rig)) {
    level.player_rig = scripts\engine\sp\utility::spawn_anim_model("player_rig");
    level.player_rig dontcastshadows();
    var0 = 1;
  }

  if(isDefined(var0)) {
    level.player_rig.origin = level.player.origin;
    level.player_rig.angles = level.player.angles;
  }

  return level.player_rig;
}

function get_player_legs() {
  if(!isDefined(level.player_legs)) {
    level.player_legs = scripts\engine\sp\utility::spawn_anim_model("player_legs");
    level.player_legs.origin = level.player.origin;
    level.player_legs.angles = level.player.angles;
  }

  return level.player_legs;
}

function get_player_body() {
  if(!isDefined(level.player_body)) {
    level.player_body = scripts\engine\sp\utility::spawn_anim_model("player_body");
    level.player_body.origin = level.player.origin;
    level.player_body.angles = level.player.angles;
  }

  return level.player_body;
}

function link_player_to_arms(var0, var1, var2, var3) {
  if(!isDefined(var0)) {
    var0 = 30;
  }

  if(!isDefined(var1)) {
    var1 = 30;
  }

  if(!isDefined(var2)) {
    var2 = 30;
  }

  if(!isDefined(var3)) {
    var3 = 30;
  }

  var4 = get_player_rig();
  var4 show();
  level.player playerlinktoabsolute(var4, "tag_player");
  level.player playerlinktodelta(var4, "tag_player", 1, var0, var1, var2, var3, 1);
}

function blend_player_to_arms(var0) {
  if(!isDefined(var0)) {
    var0 = 0.7;
  }

  var1 = get_player_rig();
  var1 show();
  level.player playerlinktoblend(var1, "tag_player", var0);
}

function set_player_rig_allows(var0) {
  if(!isDefined(var0)) {
    var0 = ["weapon", "offhand_weapons", "melee", "sprint", "jump", "mantle"];
  }

  level.player_rig.allows = var0;
}

function link_player_to_rig(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11) {
  var12 = get_player_rig(1);
  var12 endon("unlink_player");

  if(isDefined(var10)) {
    var12[[var10]]();
  }

  if(!isDefined(var12.allows)) {
    set_player_rig_allows();
  }

  var12 hide();

  if(!istrue(var11)) {
    thread scripts\sp\utility::delete_live_grenades();
  }

  if(isDefined(var0)) {
    thread scripts\common\anim::anim_first_frame_solo(var12, var0);
  }

  var12.ogstance = level.player getstance();

  if(!isDefined(var1)) {
    var1 = "stand";
  }

  var12.stance = var1;

  switch (var1) {
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

  level.player setstance(var1);
  level.player enablequickweaponswitch(1);
  level.player scripts\common\utility::allow_array(var12.allows, 0, "player_rig");

  if(!isDefined(var2)) {
    var2 = 1;
  }

  if(var2) {
    if(!isDefined(var3)) {
      var3 = 0.2;
    }

    level.player playerlinktoblend(var12, "tag_player", var3);
    wait var3;
    waitframe();
  }

  if(istrue(var4)) {
    level.player playerlinktoabsolute(var12, "tag_player");
  } else {
    if(!isDefined(var9)) {
      var9 = 0;
    }

    level.player playerlinktodelta(var12, "tag_player", 1, 0, 0, 0, 0, var9);

    if(!isDefined(var5)) {
      var5 = 45;
    }

    if(!isDefined(var6)) {
      var6 = 45;
    }

    if(!isDefined(var7)) {
      var7 = 15;
    }

    if(!isDefined(var8)) {
      var8 = 15;
    }

    if(var5 || var6 || var7 || var8) {
      level.player lerpviewangleclamp(0.2, 0.1, 0.1, var5, var6, var7, var8);
    }
  }

  var12 show();
  scripts\sp\utility::nvidiaansel_scriptdisable(1);
  return var12;
}

function unlink_player_from_rig(var0, var1, var2, var3) {
  var4 = level.player_rig;
  var4 notify("unlink_player");

  if(!scripts\engine\utility::is_equal(level.player getlinkedparent(), var4)) {
    return;
  }

  switch (var4.stance) {
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

  if(istrue(var0)) {
    var1 = var4.ogstance;
  }

  if(isDefined(var1)) {
    if(istrue(var2)) {
      level.player setstance(var1, 1, 1, 1);
      var5 = scripts\engine\utility::drop_to_ground(level.player getEye(), 0, -60, (0, 0, 1));
      level.player setOrigin(var5, 1);
    } else if(var1 != var4.stance) {
      level.player setstance(var1);
    }
  }

  level.player unlink();
  level.player enablequickweaponswitch(0);
  level.player scripts\common\utility::allow_array(var4.allows, 1, "player_rig");

  if(!istrue(var3)) {
    var4 delete();
  }

  scripts\sp\utility::nvidiaansel_scriptdisable(0);
}

function anim_lerp_from_player_pos(var0, var1, var2) {
  var3 = level.player_rig;
  var4 = getstartorigin(self.origin, self.angles, level.scr_anim[var3.animname][var0]);
  var5 = getstartangles(self.origin, self.angles, level.scr_anim[var3.animname][var0]);
  var6 = level.player.angles - var5;
  var7 = level.player.origin + rotatevector(self.origin - var4, var6);
  var8 = level.player.angles + self.angles - var5;
  var9 = scripts\engine\utility::spawn_script_origin(var7, var8);
  var10 = getanimlength(var3 scripts\engine\utility::getanim(var0));

  if(!isDefined(var1)) {
    var1 = var10;
  }

  var9 moveTo(self.origin, var1, var1 * 0.5, var1 * 0.5);

  if(!isDefined(var2)) {
    var2 = var10;
  }

  var9 rotateTo(self.angles, var2, var2 * 0.5, var2 * 0.5);
  var3 linkTo(var9);
  var9 thread scripts\common\anim::anim_single_solo(var3, var0);
  var3 thread scripts\engine\utility::waittillmatch_notify("single anim", "end", "anim_end");
  var3 scripts\engine\utility::waittill_any("anim_end", "unlink_player");
  var9 delete();
}

function player_rig_allow_weapon(var0) {
  player_rig_allow_internal(var0, "weapon");
}

function player_rig_allow_internal(var0, var1) {
  var0.allows = scripts\engine\utility::array_remove(var0.allows, var1);
  level.player thread[[level.allow_funcs[var1]]](1, "player_rig");
}