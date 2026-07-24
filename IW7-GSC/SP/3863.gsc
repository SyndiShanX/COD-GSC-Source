/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3863.gsc
**************************************/

_id_2FA4() {
  level.player notifyonplayercommand("grapple_used", "+smoke");
  level._id_72EF = 1;
  precachemodel("fx_org_view");
  precachemodel("com_teddy_bear");
  _id_2F9C();
  _id_2F9E();

  if(!level.player scripts\sp\utility::_id_65DF("player_gravity_off"))
    level.player scripts\sp\utility::_id_65E0("player_gravity_off");

  level.player scripts\sp\utility::_id_65E0("player_window_event");
  scripts\engine\utility::flag_init("window_breach_windows_off");
  level._id_E9F7 = getEntArray("sa_window_in_use_trigger", "script_noteworthy");
  level._id_2FA5 = [];
  level._id_2FA3 = [];
  level._id_2FA3["small"]["radius"] = 128;
  level._id_2FA3["medium"]["radius"] = 350;
  level._id_2FA3["large"]["radius"] = 350;
  level._id_2FA3["small"]["radius_disabled"] = 256;
  level._id_2FA3["medium"]["radius_disabled"] = 512;
  level._id_2FA3["large"]["radius_disabled"] = 512;
  level._id_2FA3["small"]["radius_max"] = 512;
  level._id_2FA3["medium"]["radius_max"] = 700;
  level._id_2FA3["large"]["radius_max"] = 700;
  var_0 = scripts\engine\utility::getStructArray("breach_window", "targetname");

  foreach(var_2 in level._id_E9F7) {
    foreach(var_4 in var_0) {
      if(ispointinvolume(var_4.origin, var_2)) {
        var_4._id_E9F6 = var_2;
        var_2._id_13D35 = var_4;
      }
    }
  }

  foreach(var_4 in var_0) {
    var_4 _id_2F9F();
    var_4 thread _id_2FA1();
  }

  level._id_2FA3["structs"] = var_0;
}

_id_2F9E() {
  level._effect["breach_wind"] = loadfx("vfx/iw7/core/expl/weap/breach/vfx_exp_breach_decomp_nomodel.vfx");
  level._effect["vfx_mr_cracked_visor_crack_11"] = loadfx("vfx/_requests/moon/vfx_mr_cracked_helmet_crack_11");
}

_id_2F9C() {
  _id_2F9A();
  _id_2F9B();
}

#using_animtree("generic_human");

_id_2F9A() {
  level._id_EC85["generic"]["window_breach_near1"] = % hm_grnd_org_exposed_pain_window_break_near_01;
  level._id_EC85["generic"]["window_breach_near2"] = % hm_grnd_org_exposed_pain_window_break_near_02;
  level._id_EC85["generic"]["window_breach_near3"] = % hm_grnd_org_exposed_pain_window_break_near_03;
  level._id_EC85["generic"]["window_breach_near4"] = % hm_grnd_org_exposed_pain_window_break_near_04;
  level._id_EC85["generic"]["window_breach_far1"] = % hm_grnd_org_exposed_pain_window_break_far_01;
  level._id_EC85["generic"]["window_breach_far2"] = % hm_grnd_org_exposed_pain_window_break_far_02;
  level._id_EC85["generic"]["window_breach_far3"] = % hm_grnd_org_exposed_pain_window_break_far_03;
  level._id_EC85["generic"]["window_breach_far4"] = % hm_grnd_org_exposed_pain_window_break_far_04;
}

_id_2F9B() {}

_id_2F9F() {
  if(isDefined(self._id_E9F6) && isDefined(self._id_E9F6._id_EF20))
    level._id_2FA5[self._id_E9F6._id_EF20] = self;

  var_0 = [];
  var_1 = undefined;
  var_2 = undefined;
  var_3 = undefined;
  var_4 = undefined;
  var_5 = scripts\engine\utility::getStructArray(self.target, "targetname");

  foreach(var_7 in var_5) {
    switch (var_7.script_noteworthy) {
      case "inspacespot":
        var_1 = var_7;
        break;
      case "fxspot":
        var_0[var_0.size] = var_7;
        break;
      case "framestart":
        var_2 = var_7;
        break;
      case "hintspot":
        var_3 = var_7;
        break;
      case "grapplespot":
        var_4 = var_7;
        break;
    }
  }

  self._id_9923 = var_1;
  self.fxtag = var_0;
  self._id_735F = var_2;
  self._id_9025 = var_3;
  self._id_84B7 = var_4;
  var_9 = undefined;
  var_10 = undefined;
  self._id_127C9 = [];
  var_11 = getEntArray(self.target, "targetname");

  foreach(var_13 in var_11) {
    switch (var_13.script_noteworthy) {
      case "door":
        self._id_2FA7 = var_13;
        self._id_2FA7._id_C632 = self._id_2FA7.origin;
        break;
      case "bulletclip":
        self._id_3244 = var_13;
        break;
      case "trigger":
        self._id_127C9[self._id_127C9.size] = var_13;
        break;
      case "shutter_clip":
        self._id_10186 = var_13;
        self._id_10186._id_C632 = self._id_10186.origin;
        break;
      case "glass_unbroken_inner":
        self._id_83CD = var_13;
        break;
      case "glass_unbroken_outer":
        self._id_83CE = var_13;
        break;
      case "glass_broken_inner":
        self._id_83C8 = var_13;
        self._id_83C8 hide();
        self._id_83C8 notsolid();
        break;
      case "glass_broken_outer":
        self._id_83C9 = var_13;
        self._id_83C9 hide();
        self._id_83C9 notsolid();
        break;
      case "fake_glass_trigger":
        self._id_6AED = var_13;
        break;
    }
  }

  self._id_3244 setCanDamage(1);
  self._id_2FA7 hide();
  self._id_13D74 = getglass(self.target);
  self._id_13D77 = self.script_noteworthy;
  self._id_13D72 = 0;
  var_15 = self.origin - self._id_9923.origin;
  self._id_54E8 = -1 * var_15[0];
  self._id_54EA = -1 * var_15[1];
  self._id_54EB = -1 * var_15[2];

  foreach(var_17 in level._id_E6E0) {
    if(isDefined(self._id_84B7)) {
      if(ispointinvolume(self._id_84B7.origin, var_17)) {
        if(!isDefined(var_17._id_13D76))
          var_17._id_13D76 = [];

        var_17._id_13D76 = scripts\engine\utility::array_add(var_17._id_13D76, self);
        self._id_E6E4 = var_17;
      }
    }
  }
}

_id_2FA1(var_0) {
  if(isDefined(self._id_13D74)) {
    while(!isglassdestroyed(self._id_13D74))
      wait 0.05;
  } else {
    var_1 = 0;

    while(var_1 < 100) {
      self._id_6AED waittill("damage", var_2, var_3, var_4, var_5, var_6);

      if(!isDefined(var_3) || !(isai(var_3) || var_3 == level.player)) {
        continue;
      }
      if(var_3 == level.player && isDefined(var_6) && isDefined(level.player._id_4B21)) {
        if(level.player._id_4B21 == "offhandshield" && var_6 == "MOD_MELEE")
          continue;
      }

      if(var_3 != level.player) {
        var_7 = distance(level.player.origin, self.origin);
        var_8 = distance(var_3.origin, self.origin);

        if(var_8 > 1024 || var_7 > 512)
          continue;
      }

      if(scripts\engine\utility::is_true(self._id_13D5C) || !scripts\engine\utility::flag("holdGravityShift"))
        var_1 = var_1 + var_2;
    }
  }

  self._id_2FA7.delay = 2.5;
  self._id_13D72 = 1;
  self notify("window_breached");
  self._id_3244 delete();

  if(isDefined(self._id_83CD))
    self._id_83CD delete();

  if(isDefined(self._id_83CE))
    self._id_83CE delete();

  if(isDefined(self._id_6AED))
    self._id_6AED delete();

  self._id_83C8 show();

  if(scripts\engine\utility::is_true(self._id_2FA7._id_4284)) {
    return;
  }
  if(scripts\engine\utility::is_true(self._id_13DBC))
    thread _id_13D41(var_0);
  else if(scripts\engine\utility::is_true(self._id_13D5C))
    thread _id_13D40();
  else if(!(level.player scripts\sp\utility::_id_65DF("player_inside_ship") && level.player scripts\sp\utility::_id_65DB("player_inside_ship")))
    thread _id_13D40();
  else if(scripts\engine\utility::player_is_in_jackal())
    thread _id_13D40();
  else
    thread _id_13D41(var_0);
}

_id_13D41(var_0) {
  if(!scripts\engine\utility::is_true(self._id_C023)) {
    physics_setgravity((self._id_54E8 * 10, self._id_54EA * 10, self._id_54EB * 10));
    scripts\engine\utility::flag_set("holdGravityShift");
    var_1 = [];
    var_1 = _id_CE98(var_1);
    thread _id_0F0A::_id_AC66(1);
    thread _id_13D43(self._id_9923, var_1, self._id_735F, self._id_84B7, var_0);
    thread _id_13D39(self._id_735F);
    var_2 = scripts\engine\utility::waittill_notify_or_timeout_return("player_thrown_out", 2.5);

    if(!isDefined(var_2))
      self waittill("player_window_event_done");

    self notify("breach_event_done");
    level notify("breach_event_done");
    scripts\engine\utility::flag_set("hack_life_support_cooling");
    _id_40DE(var_1);
    scripts\sp\utility::_id_228A(var_1);
    scripts\engine\utility::flag_clear("holdGravityShift");
  }

  if(scripts\engine\utility::is_true(self._id_13D5E) && scripts\engine\utility::is_true(self._id_51A8))
    self._id_2FA7 delete();
  else if(!scripts\engine\utility::is_true(self._id_2FA7._id_4284))
    thread _id_13D3F();

  if(scripts\engine\utility::is_true(level._id_8845) || scripts\engine\utility::flag("player_in_gravity")) {
    physics_setgravity((0, 0, -386.09));
    _id_0F35::_id_FB24(0, level.player);
    _id_0F35::_id_FB25(0, 0);
    _id_0F31::_id_E0C8();
    _id_0F31::_id_E0CE();
    _id_0F31::_id_E0CD();
  } else
    physics_setgravity((0, 0, 0));

  wait 3;
  scripts\engine\utility::flag_clear("hack_life_support_cooling");
}

_id_13D43(var_0, var_1, var_2, var_3, var_4) {
  level.player endon("death");
  level.player._id_2F99 = self;
  var_5 = scripts\engine\utility::getStruct(var_2.target, "targetname");
  var_6 = scripts\engine\utility::getStruct(var_5.target, "targetname");
  var_7 = _id_13D4C(var_2, var_5, var_6);

  if(!isalive(level.player)) {
    return;
  }
  level.player _meth_8251((0, 0, 0));
  thread _id_11059();

  if(!isDefined(var_7)) {
    _id_13D49();
    return;
  }

  if(!isDefined(level._id_72EF) || level._id_72EF == 0)
    thread _id_13D44(var_2, var_5, var_6);

  _id_13D4E(var_0, var_1, var_3, var_4);
}

_id_13D4E(var_0, var_1, var_2, var_3) {
  self notify("player_thrown_out");
  level.player scripts\sp\utility::_id_65E1("player_window_event");
  level.player scripts\sp\utility::_id_65E1("player_gravity_off");
  level.player scripts\engine\utility::allow_ads(0);
  var_4 = level.player scripts\engine\utility::spawn_tag_origin();
  var_4.origin = level.player.origin;
  var_4.angles = level.player.angles;
  level.player playerlinktodelta(var_4, "tag_origin", 1);
  level.player _meth_823C(var_4, "tag_origin", 0.5);
  level.player freezecontrols(1);
  thread _id_13D4F();
  var_4 moveTo(var_0.origin, 0.5, 0.25, 0.25);
  var_4 rotateTo(var_0.angles, 0.5);
  wait 0.25;
  thread _id_13D47(var_1);
  thread _id_13D4D();
  wait 0.25;
  level.player notify("outsideWindow");
  var_5 = anglesToForward(var_4.angles) * -1;
  var_4 moveTo(var_4.origin + var_5 * 200, 4);
  var_6 = scripts\engine\utility::spawn_tag_origin();
  var_6.origin = var_2.origin;
  var_6.angles = var_2.angles;
  _id_0F35::_id_FB24(1, level.player);
  _id_0F35::_id_FB25(1, 1, 1, 0);
  level.player _meth_8501(var_6);
  level.player _id_0F31::_id_D35F(0);
  var_7 = undefined;

  if(isDefined(level._id_72EF) && level._id_72EF == 1) {
    wait 0.3;
    level.player unlink(1);
    level.player freezecontrols(1);
    var_4 delete();
    level.player notify("grapple_used");
    scripts\engine\utility::waitframe();
    level.player _meth_8516(var_6);
  } else {
    var_7 = level.player scripts\engine\utility::waittill_either("grapple_used", "death");

    if(isDefined(var_7)) {
      return;
    }
    level.player unlink(1);
    level.player freezecontrols(1);
    var_4 delete();
    scripts\engine\utility::waitframe();
    level.player _meth_8516(var_6);
  }

  level.player waittill("spacejump_land");
  level.player freezecontrols(0);
  level.player scripts\engine\utility::allow_ads(1);
  level.player._id_2F99 = undefined;
  level.player scripts\sp\utility::_id_65DD("player_gravity_off");
  level.player scripts\sp\utility::_id_65DD("player_window_event");
  self notify("player_window_event_done");
  _id_0F35::_id_FB25(0, 0);
  level.player _id_0F31::_id_D35F(1);

  if(isDefined(var_3))
    thread _id_0BDC::_id_10CD1(var_3);
}

_id_13D4C(var_0, var_1, var_2) {
  self endon("breach_event_done");
  var_3 = 25;

  for(;;) {
    wait 0.05;

    if(!isalive(level.player)) {
      return;
    }
    var_4 = distance(level.player.origin, self.origin);

    if(var_4 > level._id_2FA3[self._id_13D77]["radius"]) {
      continue;
    }
    if(level.player scripts\sp\utility::_id_65DB("player_window_event")) {
      continue;
    }
    var_5 = pointonsegmentnearesttopoint(var_0.origin, var_1.origin, level.player.origin);
    var_6 = pointonsegmentnearesttopoint(var_1.origin, var_2.origin, level.player.origin);
    var_7 = (var_5[0], var_5[1], var_6[2]);
    var_8 = vectorNormalize(var_7 - level.player.origin);
    level.player _meth_8251(var_8 * var_3, 1);

    if(distance(level.player.origin, var_7) <= 75) {
      break;
    }

    var_3 = var_3 + 10;
  }

  return 1;
}

_id_13D4B() {
  if(isDefined(level.player._id_8A0C)) {
    return;
  }
  level.player._id_8A0C = 1;
  level.player forceplaygestureviewmodel("ges_window_break_far", undefined, 0.05);
  level.player scripts\engine\utility::allow_reload(0);
  level.player scripts\engine\utility::allow_ads(0);
  level.player scripts\engine\utility::allow_offhand_weapons(0);
  level.player scripts\engine\utility::allow_autoreload(0);
}

_id_13D4A() {
  level.player._id_8A0C = 1;
  var_0 = vectorNormalize(self.origin - level.player.origin);
  var_1 = vectorNormalize(level.player getplayerangles());
  var_2 = vectordot(var_0, var_1);

  if(var_2 < -0.5 || var_2 > 0.5)
    level.player forceplaygestureviewmodel("ges_window_break_near_b1", undefined, 0.05);
  else if(var_2 <= 0.5 && var_2 >= -0.5)
    level.player forceplaygestureviewmodel("ges_window_break_near_f1", undefined, 0.05);

  wait 1;
  _id_13D49();
}

_id_13D49() {
  if(!isDefined(level.player._id_8A0C)) {
    return;
  }
  level.player scripts\engine\utility::allow_reload(1);
  level.player scripts\engine\utility::allow_ads(1);
  level.player scripts\engine\utility::allow_offhand_weapons(1);
  level.player scripts\engine\utility::allow_autoreload(1);
  level.player._id_8A0C = undefined;
}

_id_13D4F() {
  level.player disableweapons();
  level.player disableweaponswitch();
  level.player disableoffhandweapons();
  level.player scripts\engine\utility::allow_offhand_secondary_weapons(0);
  level.player waittill("outsideWindow");
  level.player enableweapons();
  level.player waittill("spacejump_land");
  level.player enableoffhandweapons();
  level.player enableweaponswitch();
  level.player scripts\engine\utility::allow_offhand_secondary_weapons(1);
}

_id_13D47(var_0) {
  var_1 = 0;

  foreach(var_3 in var_0) {
    if(var_1 == 0)
      var_1 = 1;
  }

  level.player _meth_82C0("window_breach_space", 1.0);
  level.player scripts\sp\utility::_id_135F1("spacejump_land", 1);
  level.player notify("stop_heartbeat");
  soundresettimescale();
}

_id_13D4D() {
  soundsettimescalefactor("weap_plr_fire_3_2d", 0);
  soundsettimescalefactor("foley_plr_mvmt_unres_2d_lim", 0);
  soundsettimescalefactor("weap_plr_fire_2_2d", 0);
  soundsettimescalefactor("scn_fx_res_3d", 0);
  _id_0B0B::_id_F5A0();
  setslowmotion(1, 0.25, 0.5);

  if(!isDefined(level._id_72EF) || level._id_72EF == 0)
    var_0 = level.player scripts\engine\utility::waittill_either("grapple_used", "death");

  level.player thread scripts\sp\utility::play_sound_on_entity("window_breach_slowmo_out");
  setslowmotion(0.25, 1, 0.5);
  _id_0B0B::_id_F59F();
}

_id_13D44(var_0, var_1, var_2) {
  level.player endon("grapple_used");
  level.player waittill("outsideWindow");
  thread _id_13D45();
  wait 0.5;
  var_3 = vectorNormalize(var_1.origin - var_0.origin);
  var_4 = _id_7BF6(var_0.origin, var_1.origin, var_3);
  var_3 = vectorNormalize(var_2.origin - var_1.origin);
  var_5 = _id_7BF6(var_1.origin, var_2.origin, var_3);
  var_4 = (var_4[0], var_4[1], var_5[2]);
  var_6 = spawn("script_model", var_4);
  var_6 setModel("com_teddy_bear");
  var_6.angles = (randomint(360), randomint(360), randomint(360));
  var_7 = anglesToForward(level.player.angles);
  var_8 = var_7 * -1;
  var_9 = level.player getEye() + var_8 * 20;
  var_10 = var_6 scripts\engine\utility::spawn_tag_origin();
  var_6 linkTo(var_10);
  var_10 moveTo(var_9, 0.4);
  var_10 rotateTo((randomint(360), randomint(360), randomint(360)), 0.4);

  while(distance(var_6.origin, level.player getEye()) > 57)
    scripts\engine\utility::waitframe();

  var_6 unlink();
  var_10 delete();
  var_6 moveTo(var_6.origin + var_7 * 60, 2);
  var_6 rotateTo((randomint(360), randomint(360), randomint(360)), 2);
  setDvar("player_death_animated", 0);
  var_11 = spawn("script_model", (0, 0, 0));
  var_11 setModel("fx_org_view");
  var_11 _meth_81E2(level.player, "tag_origin", (15, 0, 0), (180, 0, 0), 1);
  playFXOnTag(scripts\engine\utility::getfx("vfx_mr_cracked_visor_crack_11"), var_11, "tag_origin");
  playworldsound("window_breach_helmet_shatter", level.player.origin);
  level.player scripts\sp\utility::_id_54C6();
  scripts\sp\utility::_id_B8D1();
}

_id_13D45() {
  thread _id_13D46();
  level.player scripts\sp\utility::play_sound_on_entity("space_breathe_player_inhale_slomo");
  wait 0.1;
  level.player scripts\sp\utility::play_sound_on_entity("space_breathe_player_exhale_slomo");
}

_id_13D46() {
  level.player endon("stop_heartbeat");
  level.player endon("death");

  for(;;)
    level.player scripts\sp\utility::play_sound_on_entity("window_breach_heartbeat");
}

_id_13D39(var_0) {
  self endon("breach_event_done");
  var_1 = getaiarray("axis", "team3");

  foreach(var_3 in var_1) {
    var_4 = distance(var_3.origin, self.origin);

    if(var_4 > level._id_2FA3[self._id_13D77]["radius_max"])
      continue;
    else {
      if(var_4 > level._id_2FA3[self._id_13D77]["radius_disabled"]) {
        thread _id_13D3A(var_3, "window_breach_far");
        continue;
      }

      if(var_4 > level._id_2FA3[self._id_13D77]["radius"]) {
        thread _id_13D3A(var_3, "window_breach_near");
        continue;
      }

      thread _id_13D3C(var_3, var_0);
    }
  }
}

_id_13D3A(var_0, var_1) {
  level.player endon("death");
  var_0 endon("death");
  var_2 = var_0;

  if(var_2 scripts\sp\utility::_id_58DA()) {
    var_2 _meth_81D0();
    return;
  }

  var_2.ignoreall = 1;
  var_2.allowdeath = 1;
  var_2.forceragdollimmediate = 1;
  var_2._id_1FBB = "generic";
  var_3 = randomintrange(1, 4);
  wait(randomfloatrange(0.05, 0.5));
  var_2 scripts\sp\anim::_id_1F35(var_2, var_1 + var_3);
  var_2.ignoreall = 0;
}

_id_13D3C(var_0, var_1) {
  var_0 endon("death");

  if(isDefined(var_0._id_2A8B)) {
    return;
  }
  var_0._id_2A8B = 1;
  var_2 = scripts\engine\utility::getStruct(var_1.target, "targetname");
  var_3 = scripts\engine\utility::getStruct(var_2.target, "targetname");
  var_4 = pointonsegmentnearesttopoint(var_1.origin, var_2.origin, var_0 gettagorigin("j_SpineUpper"));
  var_5 = pointonsegmentnearesttopoint(var_2.origin, var_3.origin, var_0 gettagorigin("j_SpineUpper"));
  var_6 = (var_4[0], var_4[1], var_5[2]);
  var_7 = vectorNormalize(var_6 - var_0 gettagorigin("j_SpineUpper"));
  var_8 = 0.2;
  var_9 = level._id_2FA3[self._id_13D77]["radius"];
  var_10 = distance2d(var_0.origin, var_6);
  var_11 = var_10 / var_9;
  var_12 = var_8 * var_11;
  wait(var_12);

  if(isDefined(var_0._id_B14F))
    var_0 scripts\sp\utility::_id_1101B();

  var_0._id_13D68 = var_7 * 5000;
  var_0._id_4E46 = ::_id_13D3B;
  scripts\engine\utility::waitframe();
  var_0 scripts\sp\utility::_id_54C6();
}

_id_13D3B() {
  scripts\anim\shared::_id_5D1A();
  self _meth_839B("torso_upper", self._id_13D68);
  return 1;
}

_id_13D5D(var_0) {
  wait 0.5;

  foreach(var_2 in var_0)
  level._id_2FA5[var_2] thread _id_13D5C();
}

_id_13D5C() {
  self._id_13D5C = 1;

  if(isDefined(self._id_6AED)) {
    self._id_6AED notify("damage", 999, level.player);
    wait 0.05;
  } else if(isDefined(self._id_13D74))
    deleteglass(self._id_13D74);
}

_id_13D5E(var_0, var_1) {
  self._id_13D5E = 1;

  if(scripts\engine\utility::is_true(var_0))
    self._id_51A8 = 1;

  if(scripts\engine\utility::is_true(var_1))
    self._id_C023 = 1;

  if(isDefined(self._id_6AED)) {
    self._id_6AED notify("damage", 999, level.player);
    wait 0.05;
    self._id_6AED delete();
  }

  if(isDefined(self._id_13D74))
    destroyglass(self._id_13D74);
}

_id_88C2() {
  level._id_2FA5[self._id_13D75]._id_2FA7 delete();

  if(!isDefined(self._id_69AE)) {
    return;
  }
  scripts\engine\utility::exploder(self._id_69AE);
  thread _id_88C3(self._id_13D75);
}

_id_88C3(var_0) {
  level.player endon("death");
  var_1 = getEnt(var_0, "targetname");
  var_1 endon("death");
  var_2 = scripts\engine\utility::getStructArray(var_1.target, "targetname");

  for(;;) {
    var_1 waittill("trigger");
    scripts\engine\utility::flag_set("player_entered_ship");
    var_2 = sortbydistance(var_2, level.player.origin);
    var_3 = level.player scripts\engine\utility::spawn_tag_origin();
    var_3.angles = level.player getplayerangles();
    var_3.origin = level.player.origin;
    level.player _meth_823B(var_3, "tag_origin");
    wait 0.05;
    var_4 = 0.5;
    var_5 = 2.0;
    var_3 moveTo(var_2[0].origin, var_4, var_4, 0.0);
    wait(var_4);
    var_3 moveTo(scripts\engine\utility::getStruct(var_2[0].target, "targetname").origin, var_5, 0.0, 0.0);
    wait(var_5);
    level.player unlink();
    var_3 delete();
  }
}

_id_CE98(var_0) {
  var_1 = 0;

  foreach(var_3 in self.fxtag) {
    var_4 = var_3 scripts\engine\utility::spawn_tag_origin();
    var_4.angles = var_4.angles + (90, 90, 0);
    playFXOnTag(scripts\engine\utility::getfx("breach_wind"), var_4, "tag_origin");

    if(var_1 == 0)
      var_1 = 1;

    var_0[var_0.size] = var_4;
  }

  level.player playSound("sa_window_break_alarm_01");
  level.player playSound("sa_window_break_air_01");
  return var_0;
}

_id_40DE(var_0) {
  var_1 = 0;

  foreach(var_3 in var_0) {
    if(var_1 == 0)
      var_1 = 1;
  }

  level.player clearclienttriggeraudiozone(0.2);
}

_id_13D3F() {
  if(!isDefined(self._id_2FA7)) {
    return;
  }
  if(isDefined(self._id_2FA7._id_4284)) {
    return;
  }
  self._id_2FA7._id_4284 = 1;

  if(isDefined(self._id_2FA7.delay))
    wait(self._id_2FA7.delay);

  while(level.player scripts\sp\utility::_id_65DB("player_window_event"))
    wait 0.05;

  if(isDefined(self._id_3244))
    self._id_3244 solid();

  var_0 = self._id_2FA7;
  var_1 = self._id_10186;
  var_0 thread scripts\sp\utility::play_sound_on_entity("sa_breach_window_close");
  var_0 moveTo(var_0._id_C632 - (0, 0, 64), 0.25, 0, 0);
  var_1 moveTo(var_1._id_C632 - (0, 0, 64), 0.25, 0, 0);
  var_0 show();
  var_0 waittill("movedone");
}

_id_13D40() {
  if(!isDefined(self._id_2FA7)) {
    return;
  }
  if(isDefined(self._id_2FA7._id_4284)) {
    return;
  }
  self._id_2FA7._id_4284 = 1;

  if(isDefined(self._id_3244))
    self._id_3244 solid();

  var_0 = self._id_2FA7;
  var_1 = self._id_10186;
  var_0 moveTo(var_0._id_C632 - (0, 0, 64), 0.25, 0, 0);
  var_1 moveTo(var_1._id_C632 - (0, 0, 64), 0.25, 0, 0);
  var_0 show();
}

_id_13D42() {
  if(self._id_13D72) {
    return;
  }
  self._id_2FA7._id_4284 = undefined;
  var_0 = self._id_2FA7;
  var_1 = self._id_10186;
  var_0 thread scripts\sp\utility::play_sound_on_entity("sa_breach_window_open");
  var_0 moveTo(var_0._id_C632, 0.25, 0, 0);
  var_1 moveTo(var_1._id_C632, 0.25, 0, 0);
  var_0 show();
  var_0 waittill("movedone");
  var_0 hide();
}

_id_11059() {
  level notify("window_breach_windows_off");
  level endon("window_breach_windows_off");
  level.player endon("death");

  if(!scripts\engine\utility::flag("window_breach_windows_off")) {
    foreach(var_1 in level._id_2FA3["structs"]) {
      if(var_1._id_13D72) {
        continue;
      }
      var_1._id_3244 notsolid();
    }
  }

  level.player scripts\sp\utility::_id_65E8("player_window_event");
  wait 30;
  level notify("window_breach_windows_on");

  foreach(var_1 in level._id_2FA3["structs"]) {
    if(var_1._id_13D72) {
      continue;
    }
    var_1._id_3244 solid();
  }
}

_id_13D50(var_0) {
  level endon("window_breach_windows_on");
  self endon("window_breached");

  for(;;) {
    var_0 waittill("damage", var_1, var_2);

    if(isDefined(var_2) && var_2 != level.player) {
      continue;
    }
    var_0 notsolid();
    thread _id_13D1D(var_0);
  }
}

_id_13D1D(var_0) {
  self endon("window_breached");
  self notify("player_shot");
  self endon("player_shot");
  wait 0.5;
  var_0 solid();
}

_id_7BF6(var_0, var_1, var_2) {
  var_3 = distance(var_0, var_1);
  var_4 = var_0 + var_2 * randomint(int(var_3));
  return var_4;
}