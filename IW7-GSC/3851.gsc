/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3851.gsc
**************************************/

_id_D7F7() {
  level._effect["vfx_breach_explosion"] = loadfx("vfx/iw7/core/expl/weap/breach/vfx_exp_breach.vfx");
  level._effect["vfx_breach_light_black"] = loadfx("vfx/iw7/core/expl/weap/breach/vfx_exp_breach_light_black.vfx");
  level._effect["vfx_breach_light_green"] = loadfx("vfx/iw7/core/expl/weap/breach/vfx_exp_breach_light_green.vfx");
  level._effect["vfx_breach_light_amber"] = loadfx("vfx/iw7/core/expl/weap/breach/vfx_exp_breach_light_amber.vfx");
  level._effect["vfx_breach_light_red"] = loadfx("vfx/iw7/core/expl/weap/breach/vfx_exp_breach_light_red.vfx");
  level._effect["vfx_breach_decomp"] = loadfx("vfx/iw7/core/expl/weap/breach/vfx_exp_breach_decomp.vfx");
  level._effect["vfx_exp_breach_piston"] = loadfx("vfx/iw7/core/expl/weap/breach/vfx_exp_breach_piston.vfx");
  level._effect["vfx_exp_breach_start"] = loadfx("vfx/iw7/core/expl/weap/breach/vfx_exp_breach_start.vfx");
  level._effect["vfx_sa_vips_breach_edge_long"] = loadfx("vfx/iw7/levels/sa_vips/vfx_sa_vips_breach_edge_long.vfx");
  level._effect["vfx_sa_vips_breach_edge_short"] = loadfx("vfx/iw7/levels/sa_vips/vfx_sa_vips_breach_edge_short.vfx");
  _id_F51D();
  _id_F2FD();
  _id_F2E8();
}

_id_F8E7() {
  level._id_2F7F = [];
  level._id_2F80 = [];
  var_0 = getEntArray("hull_breach_point", "script_noteworthy");

  foreach(var_2 in var_0) {
    var_2 thread _id_F8E6();
  }
}

_id_F8E6() {
  if(isDefined(self.targetname)) {
    level._id_2F80[self.targetname] = self;
  }

  level._id_2F7F[level._id_2F7F.size] = self;
  self._id_53D5 = 2;
  self._id_99FA = 400;
  self.hintstring = &"SHIP_ASSAULT_OBJ_BREACH_HINT_STRING";
  self._id_4EA1 = 0;
  var_0 = scripts\sp\utility::_id_7A8F();

  foreach(var_2 in var_0) {
    if(isDefined(var_2.script_exploder) && !isDefined(self._id_69AE)) {
      self._id_69AE = var_2.script_exploder;
    }

    if(isDefined(var_2.classname) && scripts\engine\utility::string_starts_with(var_2.classname, "actor")) {
      if(isDefined(var_2.script_noteworthy) && var_2.script_noteworthy == "hull_breach_xray") {
        var_2 thread _id_8EF1();
      } else {
        if(!isDefined(self._id_DC22)) {
          self._id_DC22 = [];
        }

        var_2 scripts\sp\utility::_id_1747(::_id_DC1C);
        self._id_DC22 = scripts\engine\utility::array_add(self._id_DC22, var_2);
      }
    }

    if(var_2.classname == "trigger_multiple") {
      self._id_B308 = var_2;
      self._id_B308._id_4EA1 = 0;
      self._id_B308.init_func = ::_id_9675;
      self._id_B308._id_11786 = ::_id_B30F;
      self._id_B308._id_6CF8 = ::_id_B30B;
    }

    if(var_2.classname == "trigger_multiple_flag_set_touching") {
      self._id_B308._id_BFFB = var_2;
      self._id_B308._id_BFFB thread _id_B309();
      self._id_B308._id_BFFB._id_10E65 = 0;
    }
  }

  self._id_91C5 = ::_id_5024;
  self._id_4DE3 = ::_id_2F5B;
}

_id_DC1C() {
  self._id_9320 = 1;
}

_id_1592(var_0, var_1, var_2, var_3, var_4) {
  if(!isarray(self)) {
    _id_1593(var_0, var_1, var_2, var_3, var_4);
  } else {
    foreach(var_6 in self) {
      var_6 _id_1593(var_0, var_1, var_2, var_3, var_4);
    }
  }
}

_id_1593(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_0)) {
    var_0 = &"SHIP_ASSAULT_OBJ_BREACH_TEXT";
  }

  if(!isDefined(level._id_C265)) {
    level._id_C265 = [];
  }

  if(isDefined(var_1)) {
    var_1 = scripts\engine\utility::getStruct(var_1, "targetname");
  }

  for(var_5 = 1; isDefined(level._id_C265["breach_hull_" + var_5]); var_5++) {}

  var_6 = scripts\sp\utility::_id_C264("breach_hull_" + var_5);
  objective_add(var_6, "current", var_0, self.origin);
  objective_setpointertextoverride(var_6, &"SHIP_ASSAULT_OBJ_BREACH");
  _func_2E9(var_6, 1);
  _func_2F7(var_6, 0);
  self._id_32D9 = scripts\engine\utility::spawn_tag_origin(self.origin, self.angles);
  self._id_32D9 _id_0E46::_id_48C4("tag_origin", undefined, self.hintstring, 500, self._id_99FA);
  self._id_32D9 waittill("trigger");

  if(isDefined(var_4)) {
    foreach(var_8 in var_4) {
      while(!istransientloaded(var_8)) {
        wait 0.05;
        waitfortransient(var_8);
      }
    }
  }

  self._id_32D9 _id_0E46::_id_DFE3();
  level notify("breach_start");
  scripts\sp\utility::_id_C27C(var_6);
  level.player._id_1FBB = "player_arms";
  var_10 = scripts\sp\utility::_id_10639("player_arms");
  var_10 hide();

  if(isDefined(var_1)) {
    var_1 thread scripts\sp\anim::_id_1EC3(var_10, var_2);
  } else {
    thread scripts\sp\anim::_id_1EC3(var_10, "plant_breach_player");
  }

  var_11 = scripts\engine\utility::spawn_tag_origin();
  var_11.origin = level.player.origin;
  var_11.angles = level.player getplayerangles();
  level.player _meth_823B(var_11, "tag_origin");
  level.player dontinterpolate();
  scripts\engine\utility::waitframe();
  level.player _meth_823C(var_10, "tag_player", 0.65, 0.3, 0.3);
  level.player _id_5569();
  wait 0.65;
  var_10 show();
  var_11 delete();
  var_12 = scripts\sp\utility::_id_10639("charge", self.origin, self.angles);
  var_12 playSound("sa_hull_breach_device");

  if(isDefined(var_1)) {
    var_1 thread scripts\sp\anim::_id_1F35(var_12, var_2);
  } else {
    thread scripts\sp\anim::_id_1F35(var_12, "plant_breach_charge");
  }

  if(isDefined(var_3)) {
    level.player _meth_8545();
    level.player forceplaygestureviewmodel(var_3);
  } else {
    level.player _meth_8545();
    level.player forceplaygestureviewmodel("ges_zg_wallbreach");
  }

  if(isDefined(var_1)) {
    var_1 scripts\sp\anim::_id_1F35(var_10, var_2);
  } else {
    scripts\sp\anim::_id_1F35(var_10, "plant_breach_player");
  }

  level.player unlink();
  var_10 delete();
  level.player _id_6229();
  self thread[[self._id_91C5]]();
  self[[self._id_4DE3]]();
  var_13 = scripts\engine\utility::spawn_tag_origin();
  var_13 scripts\sp\math::_id_F47F(anglesToForward(self.angles));
  scripts\engine\utility::exploder("vfx_vips_breach");
  scripts\engine\utility::exploder("vfx_vips_decomp");
  var_13 playSound("sa_explo_hull_breach_explode_runner");
  var_13 playSound("sa_explo_hull_breach_screams");
  var_12 delete();
  level notify("breach_detonation");
  thread _id_69EC(level.script);
  wait 2;

  if(isDefined(self._id_B308)) {
    self._id_B308[[self._id_B308.init_func]]();
  }
}

_id_69EC(var_0) {
  if(!isDefined(var_0)) {
    visionsetnaked("sa_vips_explosion", 0.5);
    wait 0.5;
    visionsetnaked("", 0.75);
  } else if(isDefined(var_0) && var_0 == "sa_moon") {
    visionsetnaked("sa_vips_explosion", 0.5);
    wait 0.5;
    visionsetnaked("sa_moon", 0.75);
  }
}

_id_935B() {
  for(;;) {
    level.player waittill("switch_weapon");
    var_0 = level.player getplayerangles();
    var_1 = anglesToForward(var_0);
    level.player setvelocity(var_1 * 100, 1);
  }
}

_id_5024() {
  if(!isDefined(self._id_69AE)) {
    return;
  }
  wait 0.5;
  scripts\engine\utility::exploder(self._id_69AE);
  level.player _meth_8545();
  level.player forceplaygestureviewmodel("ges_zg_wallbreach_explode");
  screenshake(level.player.origin, 10, 10, 0, 0.75, 0, 0.3, 0, 4, 4, 0);
}

_id_5569() {
  level.player freezecontrols(1);
  level.player scripts\engine\utility::allow_offhand_secondary_weapons(0);
  level.player disableoffhandweapons();
  level.player setstance("stand");
  level.player allowprone(0);
  level.player allowcrouch(0);
  level.player allowsprint(0);
  level.player _meth_80D1();
}

_id_6229() {
  level.player allowsprint(1);
  level.player allowprone(1);
  level.player allowcrouch(1);
  level.player _meth_80A1();
  level.player scripts\engine\utility::allow_offhand_secondary_weapons(1);
  level.player enableoffhandweapons();
  level.player freezecontrols(0);
}

_id_2F5B() {
  if(!isDefined(self._id_DC22)) {
    return;
  }
  foreach(var_1 in self._id_DC22) {
    if(!isDefined(var_1.target)) {
      continue;
    }
    var_2 = scripts\engine\utility::getStructArray(var_1.target, "targetname");

    foreach(var_5, var_4 in var_2) {
      if(isDefined(var_2[var_5].script_noteworthy)) {
        switch (var_2[var_5].script_noteworthy) {
          case "dead":
          default:
            var_1 thread _id_1F69(var_2[var_5]);
            break;
          case "alive":
            var_1 thread _id_1F68(var_2[var_5]);
            break;
          case "ragdoll":
            var_1 thread _id_DC13(var_2[var_5]);
            break;
          case "grab":
            if(!isDefined(var_1._id_847E)) {
              var_1._id_847E = [];
            }

            var_1._id_847E[var_1._id_847E.size] = var_2[var_5];
            break;
        }
      } else
        var_1 thread _id_1F69(var_2[var_5]);

      scripts\engine\utility::waitframe();
    }

    if(isDefined(var_1._id_847E)) {
      var_1 thread _id_735C();
    }
  }
}

_id_735C() {
  var_0 = level.player getEye();
  var_1 = self._id_847E[0];
  var_2 = distance(var_0, self._id_847E[0].origin);

  foreach(var_4 in self._id_847E) {
    if(var_2 > distance(var_0, var_4.origin)) {
      var_1 = var_4;
      var_2 = distance(var_0, var_4.origin);
    }

    var_5 = scripts\sp\utility::_id_10619(1);

    if(isai(var_5)) {
      var_5 _id_0F31::_id_6553();
    }

    var_5 dontinterpolate();
    var_5 scripts\sp\utility::_id_11624(var_1);

    if(isai(var_5)) {
      var_5 scripts\sp\utility::_id_F2A8(1);
    }

    var_5._id_1FBB = "breach_guy";
    var_6 = var_1 scripts\engine\utility::spawn_tag_origin();
    var_5 linkTo(var_6, "tag_origin");
    var_5 thread scripts\sp\anim::_id_1F35(var_5, "frame_grab", "tag_origin");
    var_5 waittillmatch("single anim", "let_go");
    var_7 = scripts\engine\utility::getStruct(var_1.target, "targetname");
    var_8 = var_6.origin + (var_7.origin - var_6.origin) * 2.5;
    var_6 moveTo(var_8, 3.5, 0.5, 1);
    var_5 waittillmatch("single anim", "end");
    var_5 scripts\sp\anim::_id_1F35(var_5, "choke01", "tag_origin");

    if(isai(var_5)) {
      var_5.a.nodeath = 1;
      var_5 scripts\sp\utility::_id_54C6();
    }

    level waittill("clear_breach_bodies");
    var_5 delete();
  }
}

_id_DC13(var_0) {
  if(isDefined(var_0.script_delay)) {
    wait(var_0.script_delay);
  }

  self.origin = var_0.origin;
  var_1 = scripts\sp\utility::_id_10619(1);
  var_1 _id_0F31::_id_6553();
  var_1 dontinterpolate();
  var_1 _meth_80F1(var_0.origin, var_0.angles);

  if(isDefined(var_0.target)) {
    var_2 = scripts\engine\utility::getStruct(var_0.target, "targetname");
    var_3 = (var_2.origin - var_0.origin) * 5;
    var_1 scripts\sp\utility::_id_54C6();
    var_1 _meth_839B("torso_upper", var_3);
  } else
    var_1 scripts\sp\utility::_id_54C6();

  var_1 scripts\anim\shared::_id_5D1A();
  level waittill("clear_breach_bodies");
  var_1 delete();
}

_id_1F69(var_0) {
  self.origin = var_0.origin;
  var_1 = scripts\sp\utility::_id_10619(1);
  var_1 motionblurhqenable();

  if(isai(var_1)) {
    var_1 _id_0F31::_id_6553();
  }

  var_1 scripts\sp\utility::_id_11624(var_0);

  if(isai(var_1)) {
    var_1 scripts\sp\utility::_id_F2A8(1);
  }

  var_1._id_1FBB = "breach_guy";
  var_2 = ["choke01", "choke02"];
  var_3 = scripts\engine\utility::random(var_2);
  var_4 = var_0 scripts\engine\utility::spawn_tag_origin();
  var_1 linkTo(var_4, "tag_origin");

  if(isDefined(var_0.script_delay)) {
    wait(var_0.script_delay);
  }

  var_1 thread scripts\sp\anim::_id_1F35(var_1, var_3, "tag_origin");

  if(isDefined(var_0.target)) {
    var_5 = scripts\engine\utility::getStruct(var_0.target, "targetname");

    if(isDefined(var_5)) {
      var_6 = var_4.origin + (var_5.origin - var_4.origin) * 3;
      var_4 moveTo(var_6, getanimlength(var_1 scripts\sp\utility::_id_7DC1(var_3)), 0, 9);
    }
  }

  var_1 waittillmatch("single anim", "end");
  var_1 motionblurhqdisable();

  if(isai(var_1)) {
    var_1.a.nodeath = 1;
    var_1 scripts\sp\utility::_id_54C6();
  }

  level waittill("clear_breach_bodies");
  var_1 delete();
}

_id_1F68(var_0) {
  self.origin = var_0.origin;
  var_1 = scripts\sp\utility::_id_10619(1);
  var_1 motionblurhqenable();
  var_1 _id_0F31::_id_6553();
  var_1 endon("death");
  var_1._id_1FBB = "breach_guy";
  var_2 = [["float01_loop", "float01_exit"], ["float02_loop", "float02_exit"], ["float03_loop", "float03_exit"]];
  var_1._id_6F39 = scripts\engine\utility::random(var_2);
  var_1._id_BCDA = var_0 scripts\engine\utility::spawn_tag_origin();
  var_1 linkTo(var_1._id_BCDA, "tag_origin", (0, 0, 0), (0, 0, 0));

  if(isDefined(var_0.script_delay)) {
    wait(var_0.script_delay);
  }

  var_1._id_BCDA thread scripts\sp\anim::_id_1EEA(var_1, var_1._id_6F39[0], "float_loop_stop", "tag_origin");
  var_1 scripts\sp\utility::_id_F2A8(1);
  var_3 = scripts\engine\utility::getStruct(var_0.target, "targetname");
  var_1._id_BCDA rotateTo(var_3.angles, 3, 0, 1);
  var_1._id_BCDA moveTo(var_3.origin, 3, 0, 1);
  var_1._id_BCDA waittill("movedone");
  var_1._id_BCDA notify("float_loop_stop");
  var_1._id_BCDA scripts\sp\anim::_id_1F35(var_1, var_1._id_6F39[1], "tag_origin");
  var_1 motionblurhqdisable();
  var_1 unlink();
  var_1._id_BCDA delete();
}

#using_animtree("player");

_id_F51D() {
  level._id_EC85["player_arms"]["plant_breach_player"] = % sa_zg_wallbreach_plant_plr;
  level._id_EC85["player_arms"]["mantle_center"] = % sa_zg_wallbreach_mantle_center_plr;
  level._id_EC85["player_arms"]["mantle_over"] = % sa_zg_wallbreach_mantle_plr;
  level._id_EC85["player_arms"]["mantle_under"] = % sa_zg_wallbreach_mantle_high_plr;
  level._id_EC85["player_arms"]["mantle_left"] = % sa_zg_wallbreach_mantle_left_plr;
  level._id_EC85["player_arms"]["mantle_right"] = % sa_zg_wallbreach_mantle_right_plr;
}

#using_animtree("script_model");

_id_F2FD() {
  level._id_EC87["charge"] = #animtree;
  level._id_EC85["charge"]["plant_breach_charge"] = % sa_zg_wallbreach_plant_charge;
  level._id_EC8C["charge"] = "weapon_wallbreachcharge_wm";
}

#using_animtree("generic_human");

_id_F2E8() {
  level._id_EC85["breach_guy"]["float01_loop"][0] = % hm_zg_wallbreach_float_loop01_ar;
  level._id_EC85["breach_guy"]["float02_loop"][0] = % hm_zg_wallbreach_float_loop02_ar;
  level._id_EC85["breach_guy"]["float03_loop"][0] = % hm_zg_wallbreach_float_loop03_ar;
  level._id_EC85["breach_guy"]["float01_exit"] = % hm_zg_wallbreach_float_exit01_ar;
  level._id_EC85["breach_guy"]["float02_exit"] = % hm_zg_wallbreach_float_exit02_ar;
  level._id_EC85["breach_guy"]["float03_exit"] = % hm_zg_wallbreach_float_exit03_ar;
  level._id_EC85["breach_guy"]["choke01"] = % hm_zg_org_grav_grenade_choke01_ar;
  level._id_EC85["breach_guy"]["choke02"] = % hm_zg_org_grav_grenade_choke02_ar;
  level._id_EC85["breach_guy"]["frame_grab"] = % hm_zg_wallbreach_edge_grab_ar;
}

_id_88B6(var_0, var_1) {
  var_2 = getEnt(var_0, "targetname");

  for(;;) {
    if(scripts\engine\utility::is_true(level._id_E99E[var_1]._id_4284) && level.player istouching(var_2)) {
      break;
    }

    wait 0.05;
  }

  level._id_E99E[var_1] _id_0F05::_id_AED6(0);
  _id_0F05::_id_10B66();
  scripts\engine\utility::trigger_on("player_in_gravity_trigger", "targetname");
}

_id_9675(var_0) {
  var_1 = scripts\engine\utility::getStructArray(self.target, "targetname");
  self._id_D648 = [];

  foreach(var_4, var_3 in var_1) {
    self._id_D648[var_4] = [var_3];

    if(isDefined(var_3.target)) {
      self._id_D648[var_4][1] = ::scripts\engine\utility::getStruct(var_3.target, "targetname");
    }
  }

  if(isDefined(self._id_D648[0])) {
    var_4 = 0;
  } else {
    var_4 = 1;
  }

  self._id_4296 = spawn("script_origin", self._id_D648[var_4][0].origin);
  self._id_4296.angles = self._id_D648[var_4][0].angles;
  self._id_4296._id_1E9A = self._id_4296.angles;
  self._id_4296._id_3BAD = 0;
  self._id_4296._id_14A5 = spawn("script_origin", self._id_4296.origin);
  self._id_6D67 = 0;
  thread _id_B311();

  if(self._id_4EA1) {
    thread _id_B30A();
  }
}

_id_977C() {
  var_0 = getEntArray("mantle_test", "script_noteworthy");
  var_1 = undefined;

  foreach(var_3 in var_0) {
    if(var_3.classname == "trigger_multiple") {
      var_1 = var_3;
    }
  }

  if(!isDefined(var_1)) {
    return;
  }
  foreach(var_3 in var_0) {
    if(var_3.classname == "trigger_multiple_flag_set_touching") {
      var_1._id_BFFB = var_3;
    }
  }

  var_7 = scripts\engine\utility::getStructArray(var_1.target, "targetname");
  var_1._id_D648 = [];

  foreach(var_10, var_9 in var_7) {
    var_1._id_D648[var_10] = [var_9];

    if(isDefined(var_9.target)) {
      var_1._id_D648[var_10][1] = ::scripts\engine\utility::getStruct(var_9.target, "targetname");
    }
  }

  var_1._id_4296 = spawn("script_origin", var_1._id_D648[0][0].origin);
  var_1._id_4296.angles = var_1._id_D648[0][0].angles;
  var_1._id_4296._id_1E9A = var_1._id_D648[0][0].angles;
  var_1._id_4296._id_B116 = "mantle_over";
  var_1._id_4296._id_3BAD = 0;
  var_1._id_4296._id_14A5 = spawn("script_origin", var_1._id_4296.origin);
  var_1._id_6D67 = 0;
  var_1 thread _id_B30A();
  var_1._id_BFFB thread _id_B309();
}

_id_B311() {
  self endon("death");
  self waittill("trigger");

  for(;;) {
    self waittill("trigger");

    if(vectordot(anglesToForward(level.player getplayerangles()), anglesToForward(self._id_4296.angles)) > 0.7) {
      break;
    }

    wait 0.1;
  }

  _id_B30B(0);
}

_id_B30F() {
  self endon("death");
  var_0 = spawnStruct();

  for(;;) {
    var_1 = level.player getEye();
    var_2 = level.player getplayerangles();
    var_1 = var_1 + anglesToForward(var_2) * 32;
    var_3 = distance(var_1, self._id_4296.origin);

    foreach(var_5 in self._id_D648) {
      var_0.origin = var_5[0].origin;
      var_0.angles = var_5[0].angles;

      if(var_5.size == 2) {
        var_0.origin = pointonsegmentnearesttopoint(var_5[0].origin, var_5[1].origin, var_1);
      }

      if(distance(var_0.origin, var_1) <= distance(self._id_4296.origin, var_1)) {
        self._id_4296.origin = var_0.origin;
        self._id_4296.angles = var_0.angles;
        var_3 = distance(var_0.origin, var_1);

        if(isDefined(var_5[0].script_noteworthy) && var_5[0].script_noteworthy == "center_mantle") {
          self._id_4296._id_3BAD = 1;
          continue;
        }

        self._id_4296._id_3BAD = 0;
      }
    }

    if(self._id_4296._id_3BAD) {
      self._id_4296 _id_1BE2();
      self._id_4296._id_B115 = self._id_4296.angles;
      self._id_4296._id_B116 = "mantle_center";
      self._id_4296._id_B119 = "ges_zg_wallbreach_mantle_center";
    } else
      self._id_4296 _id_67CE();

    wait 0.5;
  }
}

_id_B310() {
  var_0 = spawnStruct();
  var_1 = level.player getEye();
  var_2 = level.player getplayerangles();
  var_1 = var_1 + anglesToForward(var_2) * 32;
  var_3 = distance(var_1, self._id_4296.origin);

  foreach(var_5 in self._id_D648) {
    var_0.origin = var_5[0].origin;
    var_0.angles = var_5[0].angles;

    if(var_5.size == 2) {
      var_0.origin = pointonsegmentnearesttopoint(var_5[0].origin, var_5[1].origin, var_1);
    }

    if(distance(var_0.origin, var_1) <= distance(self._id_4296.origin, var_1)) {
      self._id_4296.origin = var_0.origin;
      self._id_4296.angles = var_0.angles;
      var_3 = distance(var_0.origin, var_1);

      if(isDefined(var_5[0].script_noteworthy) && var_5[0].script_noteworthy == "center_mantle") {
        self._id_4296._id_3BAD = 1;
        continue;
      }

      self._id_4296._id_3BAD = 0;
    }
  }

  if(self._id_4296._id_3BAD) {
    self._id_4296 _id_1BE2();
    self._id_4296._id_B115 = self._id_4296.angles;
    self._id_4296._id_B116 = "mantle_center";
    self._id_4296._id_B119 = "ges_zg_wallbreach_mantle_center";
  } else
    self._id_4296 _id_67CE();
}

_id_67CD() {
  var_0 = level.player getplayerangles();
  var_1 = anglesdelta((0, 0, self.angles[2]), (0, 0, var_0[2]));
  var_2 = var_1;
  self._id_B116 = "mantle_over";
  self._id_B119 = "ges_zg_wallbreach_mantle";
  self._id_B115 = self.angles;
  var_3 = anglesdelta((0, 0, (int(self.angles[2]) + 180) % 360), (0, 0, var_0[2]));
  var_4 = anglesdelta((0, 0, (int(self.angles[2]) + 90) % 360), (0, 0, var_0[2]));
  var_5 = anglesdelta((0, 0, (int(self.angles[2]) + 270) % 360), (0, 0, var_0[2]));

  if(var_2 > var_3) {
    var_2 = var_3;
    self._id_B116 = "mantle_under";
    self._id_B119 = "ges_zg_wallbreach_mantle_high";
    self._id_B115 = (self.angles[0], self.angles[1], (int(self.angles[2]) + 180) % 360);
  }

  if(var_2 > var_4) {
    var_2 = var_4;
    self._id_B116 = "mantle_right";
    self._id_B119 = "ges_zg_wallbreach_mantle_right";
    self._id_B115 = (self.angles[0], self.angles[1], (int(self.angles[2]) + 90) % 360);
  }

  if(var_2 > var_5) {
    var_2 = var_5;
    self._id_B116 = "mantle_left";
    self._id_B119 = "ges_zg_wallbreach_mantle_left";
    self._id_B115 = (self.angles[0], self.angles[1], (int(self.angles[2]) + 270) % 360);
  }
}

_id_67CE() {
  var_0 = level.player getplayerangles();
  self._id_B116 = "mantle_over";
  self._id_B119 = "ges_zg_wallbreach_mantle";
  self._id_B115 = self.angles;
  self._id_14A5 dontinterpolate();
  self._id_14A5.origin = self.origin;
  self._id_14A5.angles = self.angles;
  self._id_14A5 _id_1BE2();
  var_1 = anglesdelta((0, 0, self.angles[2]), (0, 0, self._id_14A5.angles[2]));
  var_2 = var_1;
  var_3 = anglesdelta((0, 0, (int(self.angles[2]) + 180) % 360), (0, 0, self._id_14A5.angles[2]));
  var_4 = anglesdelta((0, 0, (int(self.angles[2]) + 90) % 360), (0, 0, self._id_14A5.angles[2]));
  var_5 = anglesdelta((0, 0, (int(self.angles[2]) + 270) % 360), (0, 0, self._id_14A5.angles[2]));

  if(var_2 > var_3) {
    var_2 = var_3;
    self._id_B116 = "mantle_under";
    self._id_B119 = "ges_zg_wallbreach_mantle_high";
    self._id_B115 = (self.angles[0], self.angles[1], (int(self.angles[2]) + 180) % 360);
  }

  if(var_2 > var_4) {
    var_2 = var_4;
    self._id_B116 = "mantle_right";
    self._id_B119 = "ges_zg_wallbreach_mantle_right";
    self._id_B115 = (self.angles[0], self.angles[1], (int(self.angles[2]) + 90) % 360);
  }

  if(var_2 > var_5) {
    var_2 = var_5;
    self._id_B116 = "mantle_left";
    self._id_B119 = "ges_zg_wallbreach_mantle_left";
    self._id_B115 = (self.angles[0], self.angles[1], (int(self.angles[2]) + 270) % 360);
  }
}

_id_B30A() {
  self endon("death");

  for(;;) {
    foreach(var_1 in self._id_D648) {
      foreach(var_3 in var_1) {
        scripts\sp\debug::_id_5B24(var_3.origin, (1, 0, 0), var_3.angles, 16);
      }
    }

    var_6 = (1, 1, 1);

    switch (self._id_4296._id_B116) {
      case "mantle_over":
        var_6 = (0, 1, 0);
        break;
      case "mantle_under":
        var_6 = (0, 0, 1);
        break;
      case "mantle_right":
        var_6 = (0, 0.5, 0.5);
        break;
      case "mantle_left":
        var_6 = (0.5, 0, 0.5);
        break;
      default:
        break;
    }

    scripts\sp\debug::_id_5B24(self._id_4296.origin, var_6, self._id_4296.angles, 16);
    scripts\engine\utility::waitframe();
  }
}

_id_B30B(var_0) {
  self endon("death");

  for(;;) {
    if(self._id_BFFB._id_10E65 == 1) {
      self._id_BFFB delete();
    }

    level notify("zero_g_mantle_started");
    _id_B310();
    scripts\engine\utility::trigger_off();
    scripts\engine\utility::waitframe();
    level.player._id_1FBB = "player_arms";
    level.player _id_5569();
    var_1 = scripts\sp\utility::_id_10639("player_arms");
    var_1 dontinterpolate();
    var_1 hide();
    var_2 = spawnStruct();
    var_2.origin = self._id_4296.origin;
    var_2.angles = self._id_4296._id_B115;
    var_2 scripts\sp\anim::_id_1EC3(var_1, self._id_4296._id_B116);
    level.player _meth_823C(var_1, "tag_player", 0.5, 0.25);
    wait 0.5;
    level.player _meth_8545();
    level.player forceplaygestureviewmodel(self._id_4296._id_B119);
    var_2 scripts\sp\anim::_id_1F35(var_1, self._id_4296._id_B116);
    level notify("breach_entered");
    level.player dontinterpolate();
    level.player unlink();
    level.player _id_6229();
    var_3 = level.player getplayerangles();
    var_4 = anglesToForward(var_3);
    var_5 = getmovedelta(level.player scripts\sp\utility::_id_7DC1("mantle_over"), 0.9, 1);
    var_6 = getanimlength(level.player scripts\sp\utility::_id_7DC1("mantle_over"));
    var_7 = var_4 * length(var_5) * 1 / (var_6 * 0.1);
    level.player setvelocity(var_7);
    var_1 delete();

    if(isDefined(var_0) && var_0) {
      scripts\engine\utility::trigger_on();
      continue;
    }

    self._id_4296 delete();
    self delete();
    return;
  }
}

_id_B309() {
  self endon("death");

  if(!scripts\engine\utility::flag_exist("no_mantle_zone")) {
    scripts\engine\utility::flag_init("no_mantle_zone");
  }

  for(;;) {
    scripts\engine\utility::flag_wait("no_mantle_zone");
    level.player scripts\engine\utility::allow_mantle(0);
    level.player _meth_8512(0);
    level.player allowwallrun(0);
    scripts\engine\utility::flag_waitopen("no_mantle_zone");
    level.player scripts\engine\utility::allow_mantle(1);
    level.player _meth_8512(1);
    level.player allowwallrun(1);
  }
}

_id_956C(var_0) {
  self._id_D648 = scripts\engine\utility::getStructArray(self.target, "targetname");
  self._id_4296 = spawn("script_origin", self._id_D648[0].origin);
  self._id_4296.angles = self._id_D648[0].angles;
  self._id_4296._id_1E9A = self._id_4296.angles;
  self._id_4296._id_B116 = "mantle_center";
  self._id_4296._id_B119 = "ges_zg_wallbreach_mantle_center";
  self._id_6D67 = 0;
  thread _id_3BAE();
  thread _id_B30B(var_0);
}

_id_1BE2() {
  var_0 = anglestoup(level.player getplayerangles());
  var_1 = anglesToForward(self.angles);
  var_2 = anglestoup(self.angles);
  var_3 = anglestoright(self.angles);
  var_4 = scripts\sp\math::_id_13198(var_0, var_1);
  var_5 = vectordot(var_2, var_4);
  var_6 = acos(clamp(var_5, -1.0, 1.0));
  var_6 = var_6 * scripts\engine\utility::sign(vectordot(var_3, var_4));
  self.angles = self.angles + (0, 0, var_6);
  self dontinterpolate();
}

_id_3BAE() {
  self endon("death");
  thread _id_4EB9();

  for(;;) {
    self._id_4296 _id_1BE2();
    self._id_4296._id_B115 = self._id_4296.angles;
    wait 0.5;
  }
}

_id_8EF1() {
  if(!scripts\engine\utility::flag_exist("no_mantle_zone")) {
    scripts\engine\utility::flag_init("no_mantle_zone");
  }

  scripts\engine\utility::flag_wait("no_mantle_zone");
  level waittill("breach_started");
  wait 1.5;
  var_0 = scripts\engine\utility::getStructArray(self.target, "targetname");
  self.enemies = [];

  foreach(var_2 in var_0) {
    self.origin = var_2.origin;
    var_3 = scripts\sp\utility::_id_10619(1);
    var_3._id_EF68 = var_2;
    self.enemies[self.enemies.size] = var_3;
    var_3 thread _id_8EEE();
    wait 0.05;
  }
}

_id_8EEE() {
  scripts\sp\utility::_id_9326(1);
  scripts\sp\utility::_id_86E4();
  self.ignoreall = 1;
  self.ignoreme = 1;
  self _meth_847C();
  self._id_1FBB = "breach_x_ray";

  if(isDefined(self._id_EF68) && isDefined(self._id_EF68.animation)) {
    self._id_EF68 thread scripts\sp\anim::_id_1F35(self, self._id_EF68.animation);
    thread _id_C772();
    var_0 = getanimlength(scripts\sp\utility::_id_7DC1(self._id_EF68.animation));
    wait(var_0 - 1.0);
    _id_C773();
  } else {
    _id_C772();
    _id_C773();
  }
}

_id_C772() {
  level endon("breach_start");
  self endon("death");
  wait(randomfloat(1));
  var_0 = 0.13;
  var_1 = 0;

  while(var_0 > 0.01) {
    scripts\sp\utility::_id_91A8(var_1);
    var_1 = !var_1;
    var_0 = var_0 - 0.01;
    wait(var_0 * randomfloatrange(0.5, 1.0));
  }

  scripts\sp\utility::_id_91A8(1);
  wait(randomfloatrange(1.0, 2.0));
}

_id_C773() {
  self endon("death");
  var_0 = 0.13;
  var_1 = 0;

  while(var_0 > 0.01) {
    scripts\sp\utility::_id_91A8(var_1);
    var_1 = !var_1;
    var_0 = var_0 - 0.01;
    wait(var_0 * randomfloatrange(0.5, 1.0));
  }

  scripts\sp\utility::_id_91A8(0);
  self delete();
}

_id_4EB9() {
  self endon("death");

  for(;;) {
    scripts\sp\debug::_id_5B24(self._id_4296.origin, (1, 0, 0), self._id_4296.angles, 32);
    scripts\engine\utility::waitframe();
  }
}