/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3816.gsc
**************************************/

#using_animtree("player");

_id_CF6C(var_0, var_1) {
  level._id_EC87["player_rig"] = #animtree;
  level._id_EC8C["player_rig"] = "viewmodel_base_viewhands_iw7";

  if(isDefined(var_0))
    level._id_EC85["player_rig"]["player_terminal_enter"] = var_0;
  else {
    level._id_EC85["player_rig"]["player_terminal_enter"] = % shipcrib_armory_player_terminal_interact;
    level._id_EC85["player_rig"]["player_terminal_enter_goggles"] = % shipcrib_armory_player_terminal_goggles_on;
    level._id_EC85["player_rig"]["player_terminal_enter_twostep"] = % shipcrib_armory_player_terminal_enter_twostep;
    level._id_EC85["player_rig"]["player_terminal_enter_twostep_titan"] = % shipcrib_armory_player_terminal_enter_twostep_titan;
    level._id_EC85["player_rig"]["player_terminal_exit_twostep"] = % shipcrib_armory_player_walk_off;
    level._id_EC85["player_rig"]["player_terminal_exit_quick"] = % shipcrib_armory_player_terminal_exit_quick;
  }

  if(isDefined(var_1))
    level._id_EC85["player_rig"]["player_terminal_exit"] = var_1;
  else {
    level._id_EC85["player_rig"]["player_terminal_exit"] = % shipcrib_armory_player_terminal_exit;
    level._id_EC85["player_rig"]["player_terminal_exit_camo"] = % shipcrib_armory_player_terminal_exit_camo;
    level._id_EC85["player_rig"]["player_terminal_exit_goggles"] = % shipcrib_armory_player_terminal_goggles_off;
    level._id_EC85["player_rig"]["player_terminal_exit_noweapon"] = % shipcrib_armory_player_terminal_goggles_off_noturn;
  }

  level._id_EC85["player_rig"]["player_terminal_exit_ake"] = % shipcrib_armory_player_terminal_exit_eak47;
  level._id_EC85["player_rig"]["player_terminal_exit_ar57"] = % shipcrib_armory_player_terminal_exit_ar57;
  level._id_EC85["player_rig"]["player_terminal_exit_kbm4"] = % shipcrib_armory_player_terminal_exit_kbm4;
  level._id_EC85["player_rig"]["player_terminal_exit_lmgturret"] = % shipcrib_armory_player_terminal_exit_lmgturret;
  level._id_EC85["player_rig"]["player_terminal_exit_sdflmg"] = % shipcrib_armory_player_terminal_exit_sdflmg;
  level._id_EC85["player_rig"]["player_terminal_exit_fmg"] = % shipcrib_armory_player_terminal_exit_fmg;
  level._id_EC85["player_rig"]["player_terminal_exit_sdfar"] = % shipcrib_armory_player_terminal_exit_sdfar;
  level._id_EC85["player_rig"]["player_terminal_exit_m1"] = % shipcrib_armory_player_terminal_exit_m1;
  level._id_EC85["player_rig"]["player_terminal_exit_m8garand"] = % shipcrib_armory_player_terminal_exit_m8garand;
}

#using_animtree("script_model");

_id_DA94(var_0) {
  level._id_EC87["player_locker"] = #animtree;

  if(isDefined(var_0))
    level._id_EC85["player_locker"]["player_terminal_exit"] = var_0;
  else
    level._id_EC85["player_locker"]["player_terminal_exit"] = % shipcrib_armory_rack_terminal_exit;

  level._id_EC87["goggles"] = #animtree;
  level._id_EC85["goggles"]["player_terminal_enter_goggles"] = % shipcrib_armory_terminal_goggles_on;
  level._id_EC85["goggles"]["player_terminal_exit_goggles"] = % shipcrib_armory_terminal_goggles_off;
  level._id_EC87["vr_rifle"] = #animtree;
  level._id_EC87["vr_pistol"] = #animtree;
}

_id_2252(var_0, var_1, var_2, var_3) {
  scripts\engine\utility::flag_init("august_gl");
  scripts\engine\utility::flag_init("acceped_vr");
  scripts\engine\utility::flag_init("in_vr_mode");
  scripts\engine\utility::flag_init("in_weapon_room");
  scripts\engine\utility::flag_init("camo_applied");
  scripts\engine\utility::flag_init("terminal_menu_finished");
  scripts\engine\utility::flag_init("getting_shipcrib_loadout");

  if(!scripts\engine\utility::flag_exist("is_armory"))
    scripts\engine\utility::flag_init("is_armory");

  if(!scripts\engine\utility::flag_exist("is_shipcrib"))
    scripts\engine\utility::flag_init("is_shipcrib");

  setdvarifuninitialized("loadout_tut_string", "none");
  setdvarifuninitialized("loadout_weapon_string", "none");
  level._id_D833 = [];
  level._id_D833["primary"] = "iw7_ar57";
  level._id_D833["secondary"] = "iw7_fmg";
  level._id_D833["offhand"] = "frag";
  level._id_D833["item"] = undefined;
  level _id_116DB();
  scripts\engine\utility::flag_init("at_terminal");
  scripts\engine\utility::flag_init("armory_chose_loadout");
  scripts\engine\utility::flag_init("armory_chose_quickly");

  if(!scripts\engine\utility::flag_exist("is_armory"))
    scripts\engine\utility::flag_init("is_armory");

  if(!scripts\engine\utility::flag_exist("is_shipcrib"))
    scripts\engine\utility::flag_init("is_shipcrib");

  scripts\engine\utility::flag_set("is_armory");

  if(issubstr(level.script, "shipcrib") || level.script == "marscrib" || level.script == "vr_firing_range") {
    scripts\engine\utility::flag_set("is_shipcrib");
    level thread _id_0F2D::_id_1355D();
  }

  level._id_116E3 = scripts\engine\utility::getStructArray("loadout_interact", "script_noteworthy");
  level._id_116D8 = spawnStruct();

  if(isDefined(var_3))
    scripts\engine\utility::flag_wait(var_3);

  level thread _id_CF6C(var_0, var_1);
  level thread _id_DA94(var_2);
  _id_FA81();

  foreach(var_5 in level._id_116E3) {
    var_6 = scripts\engine\utility::getStructArray(var_5.target, "targetname");

    foreach(var_8 in var_6) {
      switch (var_8.script_noteworthy) {
        case "loadout_moveto_loc":
          var_5._id_BC97 = var_8;
          break;
        case "loadout_moveaway_loc":
          var_5._id_BC0C = var_8;
          break;
        case "teleport_return_loc":
          var_5._id_E466 = var_8;
          break;
      }
    }

    if(_id_92BC(var_5, "player_terminal"))
      var_5 thread _id_C894();

    if(_id_92BC(var_5, "lounge_terminal")) {
      var_10 = _id_0EE7::_id_7D64("lounge");
      var_11 = var_10._id_13C28["locker_primary_weapons"];

      foreach(var_13 in var_11)
      var_13 hide();

      var_15 = var_10._id_AF14;
      var_15 hide();
    }

    if(_id_92BC(var_5, "lounge_terminal_2")) {
      var_10 = _id_0EE7::_id_7D64("lounge_2");
      var_11 = var_10._id_13C28["locker_primary_weapons"];

      foreach(var_13 in var_11)
      var_13 hide();

      var_15 = var_10._id_AF14;
      var_15 hide();
    }

    var_5 thread _id_FA5C();
  }

  level._id_CF6F = _id_0EFB::_id_FE02("player_rig");
  level._id_CF6F hide();
  level._id_116D8._id_13558 = 0;

  if(!issubstr(scripts\engine\utility::get_template_script_MAYBE(), "crib"))
    level thread _id_0A2F::_id_12642();
}

_id_116DB() {
  level._effect["vfx_sc_armory_terminal_handscanner"] = loadfx("vfx/iw7/levels/ship_crib/global/vfx_sc_armory_terminal_handscanner.vfx");
  level._effect["vfx_ui_core_terminal_nameplate_omar"] = loadfx("vfx/iw7/core/ui/vfx_ui_core_terminal_nameplate_omar.vfx");
  level._effect["vfx_ui_core_terminal_nameplate_salter"] = loadfx("vfx/iw7/core/ui/vfx_ui_core_terminal_nameplate_salter.vfx");
  level._effect["vfx_ui_core_terminal_nameplate_reyes"] = loadfx("vfx/iw7/core/ui/vfx_ui_core_terminal_nameplate_reyes.vfx");
  level._effect["vfx_ui_locked_weapon"] = loadfx("vfx/iw7/core/ui/vfx_ui_locked_weapon.vfx");
  level._effect["vfx_ui_armory_terminal_use"] = loadfx("vfx/iw7/core/ui/vfx_ui_armory_terminal_use.vfx");
}

_id_11718() {
  var_0 = _id_0EE7::_id_7D64("player");
  var_1 = _id_7CF3("player_terminal");
  var_2 = var_1 scripts\engine\utility::spawn_tag_origin();
  playFXOnTag(scripts\engine\utility::getfx("vfx_ui_armory_terminal_use"), var_2, "tag_origin");
}

_id_FA5C() {
  var_0 = getEntArray("vr_goggles", "targetname");
  var_1 = getEntArray("vr_pistol", "targetname");
  var_2 = getEntArray("vr_rifle", "targetname");

  foreach(var_4 in var_0) {
    if(isDefined(var_4.script_parameters)) {
      if(self.script_parameters == var_4.script_parameters) {
        var_5 = self._id_BC97;
        var_4._id_1FBB = "goggles";
        var_4 scripts\sp\anim::_id_F64A();
        var_4 notsolid();
        self._id_8443 = var_4;
      }
    }
  }

  foreach(var_8 in var_1) {
    if(isDefined(var_8.script_parameters)) {
      if(self.script_parameters == var_8.script_parameters) {
        var_5 = self._id_BC97;
        var_8._id_1FBB = "vr_pistol";
        var_8 scripts\sp\anim::_id_F64A();
        var_8 notsolid();
        self._id_1355E = var_8;
      }
    }
  }

  foreach(var_11 in var_2) {
    if(isDefined(var_11.script_parameters)) {
      if(self.script_parameters == var_11.script_parameters) {
        var_5 = self._id_BC97;
        var_11._id_1FBB = "vr_rifle";
        var_11 scripts\sp\anim::_id_F64A();
        var_11 notsolid();
        self._id_13562 = var_11;
      }
    }
  }

  var_13 = _id_0EE7::_id_7D64("player");
  var_14 = _id_0EE7::_id_7D64("terminal_2");
  var_15 = _id_0EE7::_id_7D64("terminal_3");
  var_16 = [var_13, var_14, var_15];

  foreach(var_18 in var_16) {
    if(isDefined(var_18)) {
      if(self.script_parameters == var_18.script_parameters) {
        var_5 = self._id_BC97;
        var_19 = var_18._id_AF14;
        var_19._id_1FBB = "player_locker";
        var_19 scripts\sp\anim::_id_F64A();
        var_5 scripts\sp\anim::_id_1EE0(var_19, "player_terminal_exit");
      }
    }
  }
}

_id_F9E5() {
  if(strtok(level.script, "_")[0] != "shipcrib" && level.script != "marscrib") {
    return;
  }
  var_0 = [];
  var_1 = getEntArray("body_metrics_image", "targetname");
  var_2 = getEntArray("terminal_glass", "targetname");

  foreach(var_4 in var_2) {
    var_5 = var_4.origin + anglestoup(var_4.angles) * 40;

    if(isDefined(var_4.script_parameters)) {
      if(var_4.script_parameters == "player_terminal") {
        var_6 = scripts\engine\utility::spawn_tag_origin(var_5, var_4.angles);
        playFXOnTag(scripts\engine\utility::getfx("vfx_ui_core_terminal_nameplate_reyes"), var_6, "tag_origin");
        continue;
      }

      if(var_4.script_parameters == "terminal_2") {
        var_6 = scripts\engine\utility::spawn_tag_origin(var_5, var_4.angles);

        if(level.script == "shipcrib_titan")
          playFXOnTag(scripts\engine\utility::getfx("vfx_ui_core_terminal_nameplate_omar"), var_6, "tag_origin");
        else
          playFXOnTag(scripts\engine\utility::getfx("vfx_ui_core_terminal_nameplate_salter"), var_6, "tag_origin");

        continue;
      }

      if(var_4.script_parameters == "terminal_3") {}
    }
  }

  foreach(var_9 in var_1) {
    if(isDefined(var_9.script_parameters)) {
      switch (var_9.script_parameters) {
        case "player_terminal":
          var_9 hide();
          break;
        case "terminal_2":
          var_9 show();
          break;
        case "terminal_3":
          if(level.script != "shipcrib_europa")
            var_9 hide();
          else
            var_9 show();

          break;
        case "lounge_terminal":
          var_9 show();
          break;
        case "lounge_terminal_2":
          if(level.script == "shipcrib_moon" || level.script == "shipcrib_gravity")
            var_9 hide();
          else
            var_9 show();

          break;
        default:
          var_9 hide();
          break;
      }
    }
  }
}

_id_FA81() {
  _id_0EE7::_id_13C2A();
}

_id_D800(var_0) {
  var_1 = [];
  var_1 = scripts\engine\utility::array_add(var_1, getweaponmodel("iw7_ar57"));
  var_1 = scripts\engine\utility::array_add(var_1, getweaponmodel("iw7_ake"));
  var_1 = scripts\engine\utility::array_add(var_1, getweaponmodel("iw7_crb"));
  var_1 = scripts\engine\utility::array_add(var_1, getweaponmodel("iw7_devastator"));
  var_1 = scripts\engine\utility::array_add(var_1, getweaponmodel("iw7_erad"));
  var_1 = scripts\engine\utility::array_add(var_1, getweaponmodel("iw7_m4"));
  var_1 = scripts\engine\utility::array_add(var_1, getweaponmodel("iw7_nrg"));
  var_1 = scripts\engine\utility::array_add(var_1, getweaponmodel("iw7_kbs"));
  var_1 = scripts\engine\utility::array_add(var_1, getweaponmodel("iw7_steeldragon"));

  foreach(var_3 in var_1)
  precachemodel(var_3);
}

_id_30D4() {
  var_0 = _id_0EE7::_id_7D64("player");
  var_1 = undefined;
  var_2 = undefined;

  if(isDefined(level._id_FDFA)) {
    if(issubstr(level._id_FDFA, "sa_"))
      var_1 = 1;

    if(issubstr(level._id_FDFA, "ja_"))
      var_2 = 1;
  }

  level thread _id_0A2F::_id_12644();
  var_3 = undefined;

  if(scripts\engine\utility::flag("is_shipcrib")) {
    if(level.script != "marscrib" && !issubstr(level.script, "heist"))
      var_3 = _id_0EE7::_id_7D64("terminal_2");
  }

  var_4 = var_0._id_13C28["locker_primary_weapons"];
  var_5 = var_0._id_AF14;
  var_5._id_1FBB = "player_locker";
  var_5 scripts\sp\anim::_id_F64A();
  var_6 = var_0._id_D8D3;
  var_7 = var_0._id_F0BA;

  if(isDefined(var_3))
    var_3 notify("locker_raise");

  _id_F46D(var_0);
  var_6 unlink();
  var_6.origin = var_0._id_D8D2.origin;
  var_6.angles = var_0._id_D8D2.angles;

  if(!isDefined(var_2) || !var_2) {
    level._id_EFED = "safe";
    level.player scripts\sp\utility::_id_F526("safe");
  }

  if(!isDefined(level._id_21AD) || level._id_21AD != 1) {
    if(isDefined(var_2) && var_2)
      self._id_BC97 thread _id_1F7F(var_5, var_6, self._id_8443);
    else {
      var_0 scripts\engine\utility::delaythread(1.0, _id_0EE7::_id_CD79);
      self._id_BC97 thread _id_1F7F(var_5, var_6, self._id_8443);
      level waittill("show_locker_weapons");
      var_6 show();
      var_7 show();
      level._id_AF1F show();
      level.lockerattachobject2 show();
      level waittill("terminal_anim_exit_done");
      _id_0A2F::_id_82FF();
      _id_0A2F::_id_8315();
      _id_8311();
    }

    setDvar("loadout_chosen", 1);
    setDvar("loadout_shipcrib", 1);
  } else {
    var_0._id_CB3A _id_1F7F(undefined, undefined);
    setDvar("loadout_chosen", 1);
    level notify("armory_alt_complete");
  }

  wait 0.1;
  scripts\engine\utility::noself_delaycall(0.05, ::setomnvar, "ui_hide_hud", 0);

  if(!scripts\engine\utility::flag("is_shipcrib"))
    level.player switchtoweaponimmediate(level.player getcurrentprimaryweapon());

  wait 0.42;

  if(isDefined(var_3))
    var_3 notify("locker_lower");

  scripts\engine\utility::flag_clear("getting_shipcrib_loadout");
  level notify("terminal_bring_in_weapon_finished");
  _id_4166(var_0);

  if(!issubstr(scripts\engine\utility::get_template_script_MAYBE(), "crib"))
    scripts\sp\utility::_id_13C3C();
}

_id_8311() {
  level.player scripts\sp\utility::_id_11428();
  var_0 = level.player _meth_84C6("selectedLoadout");
  scripts\sp\loadout::_id_82FB();
}

_id_F46D(var_0) {
  var_1 = undefined;
  var_2 = level.player _meth_84C6("selectedLoadout");
  var_3 = level.player _meth_84C6("loadouts", var_2, "weaponSetups", 0, "weapon");
  var_4 = level.player _meth_84C6("loadouts", var_2, "weaponSetups", 1, "weapon");
  var_5 = undefined;
  var_6 = level.player _meth_84C6("loadouts", var_2, "weaponSetups", 0, "attachment", 0);
  var_7 = level.player _meth_84C6("loadouts", var_2, "weaponSetups", 0, "attachment", 1);
  var_8 = level.player _meth_84C6("loadouts", var_2, "weaponSetups", 0, "attachment", 2);

  if(!isDefined(level._id_AF1F)) {
    level._id_AF1F = scripts\engine\utility::spawn_tag_origin();
    level.lockerattachobject2 = scripts\engine\utility::spawn_tag_origin();
  }

  if(isDefined(var_3) && var_3 != "none") {
    var_1 = undefined;
    var_1 = getweaponviewmodel(var_3);

    if(isDefined(var_1)) {
      var_0._id_D8D3 setModel(var_1);
      var_0._id_D8D3 hide();
      _id_12D8(var_3, var_0._id_D8D3);
      var_9 = _id_7839(var_3, var_6);
      var_10 = _id_783A(var_3, var_6);

      if(isDefined(var_9) && var_9 != "") {
        var_11 = "tag_" + var_10;

        if(var_6 == "none")
          var_11 = "tag_scope";

        if(scripts\sp\utility::hastag(var_1, var_11) || scripts\sp\utility::hastag(var_1, var_11 + "_2")) {
          if(scripts\sp\utility::hastag(var_1, var_11 + "_2"))
            var_11 = var_11 + "_2";

          level._id_AF1F setModel(var_9);
          level._id_AF1F linkTo(var_0._id_D8D3, var_11, (0, 0, 0), (0, 0, 0));
          level._id_AF1F hide();
        }
      }

      var_12 = undefined;

      if(isDefined(var_7) && issubstr(var_7, "silenc"))
        var_12 = var_7;

      if(isDefined(var_8) && issubstr(var_8, "silenc"))
        var_12 = var_8;

      var_13 = _id_7839(var_3, var_12);
      var_14 = _id_783A(var_3, var_12);

      if(isDefined(var_13) && var_13 != "") {
        var_11 = "tag_" + var_14;

        if(var_7 == "none")
          var_11 = "tag_silencer";

        if(scripts\sp\utility::hastag(var_1, var_11) || scripts\sp\utility::hastag(var_1, var_11 + "_2")) {
          if(scripts\sp\utility::hastag(var_1, var_11 + "_2"))
            var_11 = var_11 + "_2";

          level.lockerattachobject2 setModel(var_13);
          level.lockerattachobject2 linkTo(var_0._id_D8D3, var_11, (0, 0, 0), (0, 0, 0));
          level.lockerattachobject2 hide();
        }
      }
    }
  }

  if(isDefined(var_4) && var_4 != "none" && var_4 != "iw7_steeldragon") {
    if(weaponclass(var_4) != "pistol") {
      var_1 = undefined;
      var_1 = getweaponviewmodel(var_4);

      if(isDefined(var_1)) {
        var_0._id_F0BA setModel(var_1);
        var_0._id_F0BA hide();
        _id_12D8(var_4, var_0._id_F0BA);
      }
    }
  }

  if(isDefined(var_5) && var_5 != "none" && var_5 != "iw7_ar57noair") {
    var_1 = undefined;
    var_1 = getweaponviewmodel(var_5);

    if(isDefined(var_1)) {
      var_0._id_8CED setModel(var_1);
      var_0._id_8CED hide();
    }
  }
}

_id_7839(var_0, var_1) {
  var_2 = undefined;

  if(isDefined(var_0) && isDefined(var_1)) {
    var_3 = _id_0A2F::build_attach_models(var_0, var_1);

    if(isDefined(var_3)) {
      var_4 = strtok(var_3, "+");
      var_3 = var_4[0];
      var_5 = tablelookuprownum("sp/attachmenttable.csv", 4, var_3);
      var_2 = tablelookupbyrow("sp/attachmenttable.csv", var_5, 8);

      if(var_2 == "" && var_4.size > 1) {
        var_5 = tablelookuprownum("sp/attachmenttable.csv", 4, var_4[1]);
        var_2 = tablelookupbyrow("sp/attachmenttable.csv", var_5, 8);
      }
    }
  }

  return var_2;
}

_id_783A(var_0, var_1) {
  var_2 = undefined;

  if(isDefined(var_0) && isDefined(var_1)) {
    var_3 = _id_0A2F::build_attach_models(var_0, var_1);

    if(isDefined(var_3)) {
      var_4 = strtok(var_3, "+");
      var_3 = var_4[0];
      var_5 = tablelookuprownum("sp/attachmenttable.csv", 4, var_3);
      var_2 = tablelookupbyrow("sp/attachmenttable.csv", var_5, 5);

      if(var_2 == "" && var_4.size > 1) {
        var_5 = tablelookuprownum("sp/attachmenttable.csv", 4, var_4[1]);
        var_2 = tablelookupbyrow("sp/attachmenttable.csv", var_5, 5);
      }
    }
  }

  return var_2;
}

_id_4166(var_0) {
  var_0._id_D8D3 setModel("tag_origin");
  var_0._id_D8D3 hide();
  var_0._id_F0BA setModel("tag_origin");
  var_0._id_F0BA hide();
  var_0._id_8CED setModel("tag_origin");
  var_0._id_8CED hide();
}

flag_wait_or_timeout_msg(var_0, var_1) {
  var_2 = var_1 * 1000;
  var_3 = gettime();

  for(;;) {
    if(scripts\engine\utility::flag(var_0))
      return "flag";

    if(gettime() >= var_3 + var_2)
      return "timeout";

    var_4 = var_2 - (gettime() - var_3);
    var_5 = var_4 / 1000;
    scripts\engine\utility::wait_for_flag_or_time_elapses(var_0, var_5);
  }
}

_id_C894() {
  self endon("disable_terminal");
  scripts\engine\utility::flag_waitopen("getting_shipcrib_loadout");
  self.enabled = 1;
  self.hint_string = &"SHIPCRIB_USETERMINAL";

  if(issubstr(scripts\engine\utility::get_template_script_MAYBE(), "crib")) {
    if(level.console)
      scripts\engine\utility::flag_wait("flag_armory_weapons_loaded");
    else {
      var_0 = flag_wait_or_timeout_msg("flag_armory_weapons_loaded", 15);

      if(var_0 == "timeout") {
        iprintlnbold("yo yo yo");
        waitforalltransients();
      }
    }
  }

  _id_0E46::_id_48C4(undefined, undefined, self.hint_string, 180, 110, 60, 0, undefined, undefined, undefined, 1);
  self waittill("trigger");
  scripts\engine\utility::flag_clear("armory_chose_loadout");
  scripts\engine\utility::flag_set("getting_shipcrib_loadout");
  game["shipcrib_loadout"] = undefined;
  self.enabled = undefined;

  if(!_id_92BC(self, "lounge_terminal") && !_id_92BC(self, "lounge_terminal_2"))
    var_1 = _id_0EE7::_id_7D64("player");

  scripts\engine\utility::flag_set("at_terminal");
  scripts\engine\utility::flag_clear("terminal_menu_finished");

  if(isDefined(level._id_FDFA) && level._id_FDFA == "sa_empambush") {
    wait 0.1;
    level notify("fade_done");
    level thread scripts\sp\utility::_id_9145("shipcrib_mandatory_loadout_a");
    level.player _meth_84C7("selectedLoadout", 0);
  } else {
    self._id_BC97 thread _id_1F7D(self._id_8443);
    self._id_E466 = self._id_BC97;
    level waittill("fade_done");
    setsaveddvar("bg_cinematicAboveUI", "1");
    setsaveddvar("bg_cinematicFullScreen", "1");
    setsaveddvar("bg_cinematicCanPause", "1");
    _id_0F2D::_id_CE8D(undefined, 1);
    thread _id_C608(1);
    level waittill("exit_bink_wait_done");
  }

  game["shipcrib_loadout"] = 1;
  scripts\engine\utility::flag_clear("at_terminal");
  scripts\engine\utility::flag_set("armory_chose_loadout");
  level notify("player_chose_loadout");
  setomnvar("ui_open_loadout_menu", 0);
  setsaveddvar("selectingLoadout", "0");
  scripts\engine\utility::noself_delaycall(1.5, ::setsaveddvar, "bg_cinematicAboveUI", "0");
  setsaveddvar("bg_cinematicFullScreen", "1");
  setsaveddvar("bg_cinematicCanPause", "1");
  thread _id_E211();
}

_id_C608(var_0) {
  player_weapon_room_stream_init();
  setomnvar("ui_open_loadout_menu", 1);
  setsaveddvar("selectingLoadout", "1");
  thread _id_82E6();

  if(scripts\engine\utility::flag_exist("is_shipcrib") && scripts\engine\utility::flag("is_shipcrib")) {
    level._id_EFED = "inside";
    wait 0.05;
    level.player scripts\sp\utility::_id_F526("normal");
  } else
    level.player scripts\sp\utility::_id_11428();

  level thread _id_D34F(self._id_E466);
  level.player _meth_84C7("selectedLoadout", 0);

  for(;;) {
    level.player waittill("luinotifyserver", var_1, var_2);

    if(var_1 == "give_player_loadout") {
      break;
    }

    if(issubstr(var_1, "give_player_loadout_vr_")) {
      var_3 = var_2;
      var_4 = getsubstr(var_1, 23, var_1.size);
      scripts\engine\utility::flag_set("acceped_vr");
      break;
    }

    if(var_1 == "edit_loadout_reset") {
      if(isDefined(level._id_FDFA)) {
        scripts\sp\loadout::_id_F56D(level._id_FDFA);
        continue;
      }

      if(level.script == "shipcrib_moon") {
        scripts\sp\loadout::_id_F56D("moon_port");
        continue;
      }

      if(level.script == "marscrib") {
        scripts\sp\loadout::_id_F56D("marsbase");
        continue;
      }

      scripts\sp\loadout::_id_F56D("shipcrib_titan");
    }
  }

  if(scripts\engine\utility::flag("acceped_vr")) {
    level notify("cancel_loadout_menu_tutorial");
    level._id_11592 = 1;
    _id_0F2D::_id_CE8D(undefined, 0);
    setomnvar("ui_open_loadout_menu", 0);
    setsaveddvar("selectingLoadout", "0");
    level thread _id_0F2D::_id_661E(0);
  } else {
    level notify("cancel_loadout_menu_tutorial");
    level notify("test_loadout_echievement");
    level._id_11592 = 1;
    _id_0F2D::_id_CE8D("scn_vr_exit", 0);
    level notify("exit_bink_wait_done");
  }
}

_id_115A1() {
  level endon("cancel_loadout_menu_tutorial");

  if(isDefined(level._id_11592) && !level._id_11592) {
    setdvarifuninitialized("loadout_tut_string", "none");
    setDvar("loadout_tut_string", "none");
    setomnvar("ui_loadout_tut_index", 0);
    setsaveddvar("bg_cinematicAboveUI", "1");
    setsaveddvar("bg_cinematicFullScreen", "1");
    setsaveddvar("bg_cinematicCanPause", "1");
    wait 0.15;
    setomnvar("ui_loadouts_menu_disabled", 1);
    wait 0.25;
    setomnvar("ui_loadouts_menu_disabled", 1);
    setomnvar("ui_loadout_tut_index", 0);
    wait 0.5;
    cinematicingame("sc_moon_loadout_tutorial_scrap");

    while(!iscinematicplaying())
      wait 0.05;

    level thread _id_12AB5(["sc_moon_slt_runninglowgriff", "sc_moon_grf_couldntrestock", "sc_moon_grf_thisstuffislike"]);
    setomnvar("ui_loadout_tut_index", 6);

    while(iscinematicplaying())
      wait 0.05;

    stopcinematicingame();
    wait 0.15;
    cinematicingame("sc_moon_loadout_tutorial_edit");

    while(!iscinematicplaying())
      wait 0.05;

    level thread _id_12AB5(["sc_moon_grf_youregoingtowalt"]);

    while(iscinematicplaying())
      wait 0.05;

    stopcinematicingame();
    setomnvar("ui_loadouts_menu_disabled", 0);
    _id_115A3("edit_loadout_page");
    setomnvar("ui_loadouts_menu_disabled", 1);
    setomnvar("ui_loadout_tut_index", 0);
    wait 0.5;
    cinematicingame("sc_moon_loadout_tutorial_primary");

    while(!iscinematicplaying())
      wait 0.05;

    setomnvar("ui_loadout_tut_index", 2);

    while(iscinematicplaying())
      wait 0.05;

    stopcinematicingame();
    setomnvar("ui_loadouts_menu_disabled", 0);
    _id_115A3("choose_primary_page");
    setomnvar("ui_loadouts_menu_disabled", 1);
    setomnvar("ui_loadout_tut_index", 0);
    wait 0.5;
    cinematicingame("sc_moon_loadout_tutorial_weapon");

    while(!iscinematicplaying())
      wait 0.05;

    setomnvar("ui_loadout_tut_index", 3);

    while(iscinematicplaying())
      wait 0.05;

    stopcinematicingame();
    setomnvar("ui_loadouts_menu_disabled", 0);
    _id_115A3("edit_loadout_page");
    setomnvar("ui_loadouts_menu_disabled", 1);
    setomnvar("ui_loadout_tut_index", 0);
    wait 0.5;
    cinematicingame("sc_moon_loadout_tutorial_attachment");

    while(!iscinematicplaying())
      wait 0.05;

    level thread _id_12AB5(["sc_moon_grf_gotsomeattach"]);
    setomnvar("ui_loadout_tut_index", 4);

    while(iscinematicplaying())
      wait 0.05;

    stopcinematicingame();
    setomnvar("ui_loadouts_menu_disabled", 0);
    _id_115A3("exit_primary_attach");
    setomnvar("ui_loadouts_menu_disabled", 1);
    setomnvar("ui_loadout_tut_index", 0);
    wait 0.5;
    cinematicingame("sc_moon_loadout_tutorial_equipment");

    while(!iscinematicplaying())
      wait 0.05;

    level thread _id_12AB5(["sc_moon_grf_nowtoroundyou"]);
    setomnvar("ui_loadout_tut_index", 5);

    while(iscinematicplaying())
      wait 0.05;

    stopcinematicingame();
    setomnvar("ui_loadouts_menu_disabled", 0);
    _id_115A3("exit_loadouts_page");
    level.player thread scripts\sp\utility::play_sound_on_entity("sc_moon_grf_itsallyourscom");
  }

  var_0 = level.player _meth_84C6("scTaughtVR");

  if(level.script == "shipcrib_titan") {
    if(!isDefined(var_0) || !var_0) {
      wait 0.15;
      setomnvar("ui_loadouts_menu_disabled", 1);
      wait 0.25;
      setomnvar("ui_loadouts_menu_disabled", 1);
    }
  }
}

_id_82E6() {
  var_0 = level.player _meth_84C6("achievementMakeItPersonal");

  if(isDefined(var_0) && var_0) {
    return;
  }
  var_1 = [];
  var_2 = [];
  var_3 = [];
  var_4 = [];
  var_5 = [];
  var_6 = [];
  var_7 = [];
  var_8 = [];
  var_9 = [];
  var_10 = [];
  var_11 = [];
  var_12 = [];
  var_13 = [];

  for(var_14 = 0; var_14 < 4; var_14++) {
    var_15 = level.player _meth_84C6("loadouts", var_14, "weaponSetups", 0, "weapon");
    var_16 = level.player _meth_84C6("loadouts", var_14, "weaponSetups", 1, "weapon");
    var_17 = level.player _meth_84C6("loadouts", var_14, "weaponSetups", 0, "attachment", 0);
    var_18 = level.player _meth_84C6("loadouts", var_14, "weaponSetups", 0, "attachment", 1);
    var_19 = level.player _meth_84C6("loadouts", var_14, "weaponSetups", 0, "attachment", 2);
    var_20 = level.player _meth_84C6("loadouts", var_14, "weaponSetups", 1, "attachment", 0);
    var_21 = level.player _meth_84C6("loadouts", var_14, "weaponSetups", 1, "attachment", 1);
    var_22 = level.player _meth_84C6("loadouts", var_14, "weaponSetups", 1, "attachment", 2);
    var_23 = level.player _meth_84C6("loadouts", var_14, "equipment", 0);
    var_24 = level.player _meth_84C6("loadouts", var_14, "offhandEquipment", 0);
    var_25 = level.player _meth_84C6("loadouts", var_14, "equipment", 1);
    var_26 = level.player _meth_84C6("loadouts", var_14, "offhandEquipment", 1);
    var_27 = var_14;
    var_13[var_27] = [];
    var_13[var_27] = scripts\engine\utility::array_add(var_13[var_27], var_15);
    var_13[var_27] = scripts\engine\utility::array_add(var_13[var_27], var_16);
    var_13[var_27] = scripts\engine\utility::array_add(var_13[var_27], var_17);
    var_13[var_27] = scripts\engine\utility::array_add(var_13[var_27], var_18);
    var_13[var_27] = scripts\engine\utility::array_add(var_13[var_27], var_19);
    var_13[var_27] = scripts\engine\utility::array_add(var_13[var_27], var_20);
    var_13[var_27] = scripts\engine\utility::array_add(var_13[var_27], var_21);
    var_13[var_27] = scripts\engine\utility::array_add(var_13[var_27], var_22);
    var_13[var_27] = scripts\engine\utility::array_add(var_13[var_27], var_23);
    var_13[var_27] = scripts\engine\utility::array_add(var_13[var_27], var_24);
    var_13[var_27] = scripts\engine\utility::array_add(var_13[var_27], var_25);
    var_13[var_27] = scripts\engine\utility::array_add(var_13[var_27], var_26);
  }

  level waittill("test_loadout_echievement");
  var_28 = level.player _meth_84C6("selectedLoadout");
  var_29 = level.player _meth_84C6("loadouts", var_28, "weaponSetups", 0, "weapon");
  var_30 = level.player _meth_84C6("loadouts", var_28, "weaponSetups", 1, "weapon");
  var_31 = level.player _meth_84C6("loadouts", var_28, "weaponSetups", 0, "attachment", 0);
  var_32 = level.player _meth_84C6("loadouts", var_28, "weaponSetups", 0, "attachment", 1);
  var_33 = level.player _meth_84C6("loadouts", var_28, "weaponSetups", 0, "attachment", 2);
  var_34 = level.player _meth_84C6("loadouts", var_28, "weaponSetups", 1, "attachment", 0);
  var_35 = level.player _meth_84C6("loadouts", var_28, "weaponSetups", 1, "attachment", 1);
  var_36 = level.player _meth_84C6("loadouts", var_28, "weaponSetups", 1, "attachment", 2);
  var_23 = level.player _meth_84C6("loadouts", var_28, "equipment", 0);
  var_24 = level.player _meth_84C6("loadouts", var_28, "offhandEquipment", 0);
  var_25 = level.player _meth_84C6("loadouts", var_28, "equipment", 1);
  var_26 = level.player _meth_84C6("loadouts", var_28, "offhandEquipment", 1);
  var_37 = [var_29, var_30, var_31, var_32, var_33, var_23, var_25, var_24, var_26, var_34, var_35, var_36];
  var_38 = undefined;
  var_39 = var_13[var_28];

  foreach(var_41 in var_37) {
    if(!scripts\engine\utility::array_contains(var_39, var_41)) {
      var_38 = 1;
      break;
    }
  }

  if(isDefined(var_38) && var_38) {
    scripts\sp\utility::_id_834F("CHANGE_LOADOUT");
    level.player _meth_84C7("achievementMakeItPersonal", 1);
  }
}

_id_12AB5(var_0) {
  foreach(var_2 in var_0)
  level.player scripts\sp\utility::play_sound_on_entity(var_2);
}

_id_115A2(var_0) {
  level notify("start_tut_wait");
  level endon("start_tut_wait");

  for(;;) {
    level.player waittill("luinotifyserver", var_1, var_2);

    if(var_1 == var_0 || var_2 == 2) {
      break;
    }

    wait 0.05;
  }
}

_id_115A3(var_0) {
  setDvar("loadout_tut_string", "none");

  for(;;) {
    if(getDvar("loadout_tut_string") == var_0) {
      break;
    }

    wait 0.05;
  }
}

_id_E211() {
  if(scripts\engine\utility::flag_exist("is_shipcrib") && scripts\engine\utility::flag("is_shipcrib")) {
    level.player giveweapon("iw7_gunless");
    level.player switchtoweaponimmediate("iw7_gunless");
    level.player scripts\sp\utility::_id_F526("safe");
  }

  var_0 = getEnt("plr_weaponview_link", "targetname");
  _id_0A2F::_id_DA4E();

  if(_id_92BC(self, "lounge_terminal") || _id_92BC(self, "lounge_terminal_2")) {
    if(isDefined(var_0))
      scripts\engine\utility::flag_waitopen("in_weapon_room");

    self._id_BC97 _id_1F7F(undefined, undefined, self._id_8443);
    scripts\engine\utility::flag_clear("getting_shipcrib_loadout");
    level._id_EFED = "inside";
    level.player scripts\sp\utility::_id_F526("safe");
    level.player unlink();
    scripts\engine\utility::flag_set("terminal_menu_finished");
    scripts\engine\utility::flag_clear("at_terminal");
    thread _id_C894();

    if(!issubstr(scripts\engine\utility::get_template_script_MAYBE(), "crib"))
      scripts\sp\utility::_id_13C3C();

    return;
  } else {
    if(isDefined(var_0))
      scripts\engine\utility::flag_waitopen("in_weapon_room");

    scripts\engine\utility::flag_set("terminal_menu_finished");
    scripts\engine\utility::flag_clear("at_terminal");
    scripts\engine\utility::delaythread(2.0, ::_id_C894);
    thread _id_30D4();
  }
}

_id_737F() {
  var_0 = scripts\engine\utility::spawn_tag_origin();
  self _meth_823B(var_0, "tag_player");
}

_id_1F7D(var_0) {
  level._id_CF6F _id_0EFB::_id_FDD7(1);
  level._id_21B7 = scripts\engine\utility::spawn_script_origin();
  var_1 = undefined;
  var_2 = undefined;
  level thread _id_660F();

  if(isDefined(level._id_FDFA) && level._id_FDFA == "titan" && !isDefined(self.is_titan_firsttime))
    self.is_titan_firsttime = 1;

  if(isDefined(level._id_FDFA) && _id_92BC(self, "player_terminal")) {
    if(issubstr(level._id_FDFA, "sa_") || issubstr(level._id_FDFA, "ja_"))
      var_1 = 1;
  }

  if(isDefined(var_1) || isDefined(self.is_titan_firsttime) && self.is_titan_firsttime && _id_92BC(self, "player_terminal")) {
    level._id_21B7 scripts\sp\anim::_id_1EC3(level._id_CF6F, "player_terminal_enter_twostep");
    var_2 = 1;
  } else
    level._id_21B7 scripts\sp\anim::_id_1EC3(level._id_CF6F, "player_terminal_enter");

  wait 0.05;
  level.player setstance("stand");
  level.player playerlinkTo(level._id_CF6F);
  level.player _meth_823C(level._id_CF6F, "tag_player", 0.5, 0.2, 0.2);
  wait 0.55;
  level.player playerlinktodelta(level._id_CF6F, "tag_player", 0, 0, 0, 0, 0, 1);
  level._id_CF6F show();

  if((isDefined(var_1) || isDefined(self.is_titan_firsttime) && self.is_titan_firsttime) && _id_92BC(self, "player_terminal")) {
    if(isDefined(self.is_titan_firsttime) && self.is_titan_firsttime && !isDefined(var_1) && _id_92BC(self, "player_terminal")) {
      level waittill("start_titan_armory");
      level._id_EFF6 = 0;
    }

    if(level.script != "marscrib")
      thread _id_6618(var_2);

    if(isDefined(self.is_titan_firsttime) && self.is_titan_firsttime) {
      level._id_21B7 scripts\sp\anim::_id_1F35(level._id_CF6F, "player_terminal_enter_twostep_titan");
      self.is_titan_firsttime = 0;
    } else
      level._id_21B7 scripts\sp\anim::_id_1F35(level._id_CF6F, "player_terminal_enter_twostep");

    level._id_21B7 scripts\sp\anim::_id_1F35(level._id_CF6F, "player_terminal_enter");
  } else {
    if(level.script != "marscrib")
      thread _id_6618(var_2);

    level._id_21B7 scripts\sp\anim::_id_1F35(level._id_CF6F, "player_terminal_enter");
  }

  level notify("fade_done");
  level._id_CF6F hide();
}

_id_660F() {
  if(level.player getcurrentweapon() == "iw7_gunless" || level.player getcurrentweapon() == "none") {
    return;
  }
  level.player scripts\sp\utility::_id_D090("ges_quick_drop");
  wait 0.25;
  level.player giveweapon("iw7_gunless");
  level.player switchtoweaponimmediate("iw7_gunless");
}

_id_6618(var_0) {
  var_1 = _id_7CF3("player_terminal");

  if(isDefined(self.script_parameters)) {
    switch (self.script_parameters) {
      case "player_terminal":
        var_1 = _id_7CF3(self.script_parameters);
        break;
      case "lounge_terminal":
        var_1 = _id_7CF3(self.script_parameters);
        break;
      case "terminal_2":
        var_1 = _id_7CF3(self.script_parameters);
        break;
      case "terminal_3":
        var_1 = _id_7CF3(self.script_parameters);
        break;
      case "lounge_terminal_2":
        var_1 = _id_7CF3(self.script_parameters);
        break;
    }
  }

  var_2 = var_1 scripts\engine\utility::spawn_tag_origin();

  if(isDefined(var_0) && var_0)
    wait 2.36;
  else
    wait 0.36;

  playFXOnTag(scripts\engine\utility::getfx("vfx_ui_armory_terminal_use"), var_2, "tag_origin");
  wait 2.0;
  var_2 delete();
}

_id_1F7F(var_0, var_1, var_2) {
  if(!isDefined(level._id_21B7))
    level._id_21B7 = scripts\engine\utility::spawn_script_origin();

  var_3 = undefined;
  var_4 = 0;

  if(isDefined(level._id_FDFA)) {
    if(issubstr(level._id_FDFA, "sa_"))
      var_3 = 1;

    if(issubstr(level._id_FDFA, "ja_"))
      var_4 = 1;
  }

  if(scripts\engine\utility::flag("camo_applied") && !var_4 || isDefined(level._id_21AD) && level._id_21AD) {
    var_5 = "player_terminal_exit";
    thread _id_13311(var_0, 0);
  } else if(!_id_92BC(self, "lounge_terminal") && !_id_92BC(self, "lounge_terminal_2") && !var_4) {
    var_5 = "player_terminal_exit_camo";
    thread _id_13311(var_0, 2.3);
  } else
    var_5 = "player_terminal_exit_quick";

  level._id_21B7 scripts\sp\anim::_id_1EC3(level._id_CF6F, var_5);
  wait 0.05;

  if(isDefined(var_1)) {
    var_1 unlink();
    var_1.origin = level._id_CF6F gettagorigin("TAG_WEAPON");
    var_1.angles = level._id_CF6F gettagangles("TAG_WEAPON");
    var_1 linkTo(level._id_CF6F, "TAG_WEAPON");
    var_1 notsolid();
  }

  level.player playerlinkTo(level._id_CF6F);
  level.player _meth_823C(level._id_CF6F, "tag_player", 0.05, 0, 0);
  wait 0.05;
  level._id_CF6F show();
  level.player playerlinktodelta(level._id_CF6F, "tag_player", 0, 0, 0, 0, 0, 1);

  if(var_4) {
    level.player _meth_84C7("currentViewModel", "viewmodel_base_viewhands_iw7");
    level._id_CF6F _id_0EFB::_id_FDD7(1);
    level._id_21B7 scripts\sp\anim::_id_1F35(level._id_CF6F, "player_terminal_exit_quick");
  } else if(isDefined(level._id_21AD) && level._id_21AD)
    level._id_21B7 scripts\sp\anim::_id_1F35(level._id_CF6F, "player_terminal_exit");
  else {
    level.player scripts\sp\utility::_id_11428();

    if(!scripts\engine\utility::flag("camo_applied"))
      level thread _id_1F80();

    level._id_21B7 scripts\sp\anim::_id_1F35(level._id_CF6F, var_5);

    if(isDefined(var_1) && isDefined(var_0)) {
      var_6 = level.player _meth_84C6("selectedLoadout");
      var_7 = level.player _meth_84C6("loadouts", var_6, "weaponSetups", 0, "weapon");
      var_8 = "player_terminal_exit_ake";

      if(issubstr(var_7, "ake") || issubstr(var_7, "ake_gold"))
        var_8 = "player_terminal_exit_ake";
      else if(issubstr(var_7, "lmg03"))
        var_8 = "player_terminal_exit_sdflmg";
      else if(issubstr(var_7, "ar57"))
        var_8 = "player_terminal_exit_ar57";
      else if(issubstr(var_7, "m4"))
        var_8 = "player_terminal_exit_kbm4";
      else if(issubstr(var_7, "fmg"))
        var_8 = "player_terminal_exit_fmg";
      else if(issubstr(var_7, "mauler"))
        var_8 = "player_terminal_exit_lmgturret";
      else if(issubstr(var_7, "sdflmg") || issubstr(var_7, "repeater"))
        var_8 = "player_terminal_exit_sdflmg";
      else if(issubstr(var_7, "sdfar") || issubstr(var_7, "gambit"))
        var_8 = "player_terminal_exit_sdfar";
      else if(issubstr(var_7, "m8"))
        var_8 = "player_terminal_exit_m8garand";
      else if(issubstr(var_7, "kbs") || issubstr(var_7, "stasis"))
        var_8 = "player_terminal_exit_m8garand";
      else if(issubstr(var_7, "m1"))
        var_8 = "player_terminal_exit_m1";

      if(isDefined(var_0)) {
        level._id_21B7 thread scripts\sp\anim::_id_1F35(var_0, "player_terminal_exit");
        var_0 scripts\engine\utility::delaycall(4.2, ::playsound, "sc_weapon_rack_close_down");
      }

      level notify("show_locker_weapons");
      level thread scripts\sp\utility::_id_C12D("player_grabbed_weapon", 1.75);
      level._id_21B7 scripts\sp\anim::_id_1F35(level._id_CF6F, var_8);
      var_1 unlink();
      var_1 hide();
      level._id_AF1F hide();
      level.lockerattachobject2 hide();
      level thread scripts\sp\utility::_id_9145("fluff_messages_magboots");
    }
  }

  level notify("terminal_anim_exit_done");
  level._id_CF6F hide();

  if(isDefined(var_3) && !_id_92BC(self, "lounge_terminal") && !_id_92BC(self, "lounge_terminal_2"))
    level._id_21B7 scripts\sp\anim::_id_1F35(level._id_CF6F, "player_terminal_exit_twostep");

  level.player unlink();
  level._id_21B7 delete();
}

_id_1F80() {
  var_0 = undefined;
  var_1 = level._id_CF6F scripts\sp\utility::_id_7DC1("player_terminal_exit_camo");
  var_2 = getnotetracktimes(var_1, "start_camo_change")[0] * getanimlength(var_1);
  wait(var_2);

  if(isDefined(level._id_FDFA)) {
    if(level._id_FDFA == "titan")
      var_0 = "Desert";
    else
      var_0 = "Urban";
  } else
    var_0 = "Urban";

  level _id_0EFB::_id_FDD6(level._id_CF6F, var_0);
  scripts\engine\utility::flag_set("camo_applied");
}

_id_1F7E() {
  level.player disableusability();
  var_0 = _id_7CF3("player_terminal");
  var_0 _id_0E46::_id_DFE3();
  var_0._id_BC97 scripts\sp\anim::_id_1EC3(level._id_CF6F, "player_terminal_enter_twostep_titan");
  level.player playerlinkTo(level._id_CF6F);
  level.player _meth_823C(level._id_CF6F, "tag_player", 0.05, 0, 0);
  var_0 notify("trigger");
  level.player enableusability();
}

_id_13665(var_0, var_1) {
  if(var_0 > 0)
    wait(var_0);

  level.player _meth_823B(var_1, "tag_player");
  var_1 show();
}

_id_92BC(var_0, var_1) {
  if(isDefined(var_0.script_parameters)) {
    if(var_0.script_parameters == var_1)
      return 1;
    else
      return 0;
  } else
    return 0;
}

_id_7CF3(var_0) {
  foreach(var_2 in level._id_116E3) {
    if(isDefined(var_2.script_parameters)) {
      if(var_2.script_parameters == var_0)
        return var_2;
    }
  }
}

_id_3DB1(var_0) {
  var_1 = level.script;

  if(var_1 == var_0)
    return 1;
  else
    return 0;
}

player_weapon_room_stream_init() {
  var_0 = getEnt("plr_weaponview_link", "targetname");
  var_1 = getEnt("player_weapon_model", "targetname");
  var_2 = level.player _meth_84C6("loadouts", 0, "weaponSetups", 0, "weapon");

  if(isDefined(var_2) && isDefined(var_0) && isDefined(var_1)) {
    var_3 = getweaponviewmodel(var_2);
    var_1 setModel(var_3);
    level.player _meth_8240(var_0.origin);
  }
}

_id_D34F(var_0) {
  level endon("acceped_vr");
  var_1 = getEnt("plr_weaponview_link", "targetname");

  if(!isDefined(var_1)) {
    scripts\engine\utility::flag_set("in_weapon_room");
    return;
  }

  level._id_37BD = scripts\engine\utility::spawn_script_origin(var_1.origin + anglestoup(var_1.angles) * -66, var_1.angles);
  var_2 = getEnt("player_weapon_model", "targetname");

  if(!isDefined(level._id_B671))
    level._id_B671 = scripts\engine\utility::spawn_tag_origin();

  if(!isDefined(level._id_13C2D))
    level._id_13C2D = scripts\engine\utility::spawn_script_origin(var_2.origin, var_2.angles);

  var_3 = level._id_13C2D.origin;
  var_4 = level._id_13C2D.angles;
  scripts\sp\utility::_id_11633(level._id_37BD);
  level.player playerlinktodelta(level._id_37BD, undefined, 1, 0, 0, 0, 0, 1);
  level.player scripts\sp\utility::_id_11428();
  scripts\engine\utility::flag_set("in_weapon_room");
  var_5 = "tag_origin";
  level._id_13C45 = var_5;
  var_2 setModel(var_5);
  var_6 = (0, -20, 0);
  var_7 = 0;
  var_8 = 0;
  var_9 = 0;
  var_2.angles = var_2.angles + var_6;
  level thread _id_D351(var_2);
  level thread _id_D350(level._id_37BD, var_2, var_3, var_4);
  level thread _id_1308(var_2, var_3, var_4);
  var_10 = scripts\engine\utility::flag_wait_any_return("acceped_vr", "armory_chose_loadout");

  if(isDefined(var_0) && isDefined(var_10) && var_10 == "armory_chose_loadout") {
    level.player scripts\sp\utility::_id_11633(var_0);
    level.player _meth_823B(level._id_CF6F);
  }

  scripts\engine\utility::flag_clear("in_weapon_room");
}

_id_1308(var_0, var_1, var_2) {
  level.player endon("player_vr_exit_request");
  level endon("acceped_vr");
  level endon("armory_chose_loadout");
  var_3 = undefined;
  var_4 = undefined;
  var_5 = (0, -20, 0);
  var_6 = 0;
  var_7 = 0;
  var_8 = 0;
  var_9 = "none";

  for(;;) {
    for(;;) {
      if(getDvar("loadout_weapon_string") != var_9) {
        var_9 = getDvar("loadout_weapon_string");
        break;
      }

      wait 0.05;
    }

    if(issubstr(var_9, "iw7") && !issubstr(var_9, "give_player_loadout")) {
      var_4 = level.player _meth_84C6("weaponsScanned", var_9);

      if(isDefined(var_4) && (var_4 == "scanned" || var_4 == "unlocked")) {
        var_10 = var_9;
        level._id_13C45 = var_10;

        if(isDefined(var_3)) {
          killfxontag(scripts\engine\utility::getfx("vfx_ui_locked_weapon"), var_0, "tag_origin");
          var_3 = undefined;
        }

        var_11 = getweaponviewmodel(var_10);
        var_0 setModel(var_11);
      } else {
        if(isDefined(var_3))
          killfxontag(scripts\engine\utility::getfx("vfx_ui_locked_weapon"), var_0, "tag_origin");

        level._id_13C45 = "tag_origin";
        var_0 setModel("tag_origin");
        playFXOnTag(scripts\engine\utility::getfx("vfx_ui_locked_weapon"), var_0, "tag_origin");
        var_3 = 1;
      }
    } else {
      level._id_13C45 = "tag_origin";
      var_0 setModel("tag_origin");
      killfxontag(scripts\engine\utility::getfx("vfx_ui_locked_weapon"), var_0, "tag_origin");
      var_3 = undefined;
    }

    switch (level._id_13C45) {
      case "iw7_ar57":
        var_6 = -27;
        var_7 = 10;
        var_8 = -6.5;
        break;
      case "iw7_ake":
      case "iw7_ake_gold":
        var_6 = -25;
        var_7 = 14;
        var_8 = -7;
        break;
      case "iw7_m4":
        var_6 = -22;
        var_7 = 13;
        var_8 = -6.5;
        break;
      case "iw7_fmg":
        var_6 = -25;
        var_7 = 12;
        var_8 = -7;
        break;
      case "iw7_sdfar":
        var_6 = -22;
        var_7 = 16;
        var_8 = -5;
        break;
      case "iw7_gambit":
        var_6 = -22;
        var_7 = 16;
        var_8 = -5;
        break;
      case "iw7_sdflmg":
        var_6 = -15;
        var_7 = 22;
        var_8 = -10;
        break;
      case "iw7_repeater":
        var_6 = -15;
        var_7 = 22;
        var_8 = -10;
        break;
      case "iw7_lmg03":
        var_6 = -23;
        var_7 = 18;
        var_8 = -10;
        break;
      case "iw7_erad":
        var_6 = -25;
        var_7 = 10;
        var_8 = -7;
        break;
      case "iw7_ump45":
        var_6 = -25;
        var_7 = 13;
        var_8 = -7;
        break;
      case "iw7_ripper":
        var_6 = -30;
        var_7 = 8;
        var_8 = -7;
        break;
      case "iw7_fhr":
        var_6 = -27;
        var_7 = 10;
        var_8 = -7;
        break;
      case "iw7_counterweight":
        var_6 = -27;
        var_7 = 10;
        var_8 = -7;
        break;
      case "iw7_crb":
        var_6 = -25;
        var_7 = 11;
        var_8 = -6;
        break;
      case "iw7_m8":
        var_6 = -17;
        var_7 = 20;
        var_8 = -7;
        break;
      case "iw7_kbs":
        var_6 = -10;
        var_7 = 25;
        var_8 = -7;
        break;
      case "iw7_m1":
        var_6 = -15;
        var_7 = 18;
        var_8 = -9;
        break;
      case "iw7_stasis":
        var_6 = -10;
        var_7 = 25;
        var_8 = -7;
        break;
      case "iw7_devastator":
        var_6 = -28;
        var_7 = 11;
        var_8 = -6;
        break;
      case "iw7_sonic":
        var_6 = -18;
        var_7 = 18;
        var_8 = -7;
        break;
      case "iw7_sdfshotty":
        var_6 = -23;
        var_7 = 18;
        var_8 = -4;
        break;
      case "iw7_emc":
        var_6 = -35;
        var_7 = 5;
        var_8 = -7;
        break;
      case "iw7_g18":
        var_6 = -38;
        var_7 = 3;
        var_8 = -8;
        break;
      case "iw7_nrg":
        var_6 = -30;
        var_7 = 6;
        var_8 = -6;
        break;
      case "iw7_chargeshot":
        var_6 = -23;
        var_7 = 12;
        var_8 = -5;
        break;
      case "iw7_atomizer":
        var_6 = -30;
        var_7 = 11;
        var_8 = -5.5;
        break;
      case "iw7_mauler":
        var_6 = -12;
        var_7 = 24;
        var_8 = -6;
        break;
      case "iw7_lockon":
        var_6 = -15;
        var_7 = 18;
        var_8 = -7;
        break;
      case "iw7_steeldragon":
        var_6 = 10;
        var_7 = 38;
        var_8 = -3;
        break;
      case "iw7_penetrationrail":
        var_6 = -12;
        var_7 = 24;
        var_8 = -5;
        break;
    }

    _id_12D7(level._id_13C45, var_0);
    _id_134A(level._id_13C45, var_0);

    if(isDefined(var_4) && var_4 == "locked") {
      var_6 = -23;
      var_7 = 15;
      var_8 = -8;
    }

    var_12 = anglesToForward(level._id_37BD.angles) * var_6;
    var_13 = anglestoright(level._id_37BD.angles) * var_7;
    var_14 = anglestoup(level._id_37BD.angles) * var_8;
    var_0.origin = var_1 + var_12 + var_13 + var_14;
    var_0 dontinterpolate();
    wait 0.05;
  }
}

_id_12D7(var_0, var_1) {
  switch (var_0) {
    case "iw7_ar57":
      var_1 hidepart("tag_sight_off");
      break;
    case "iw7_ake":
    case "iw7_ake_gold":
      var_1 hidepart("tag_sight_off");
      var_1 hidepart("j_eak_lgn_strap_01");
      break;
    case "iw7_m4":
      var_1 hidepart("j_kbm4_strap_01");
      var_1 hidepart("tag_sight_off");
      var_1 hidepart("tag_zerog_off");
      break;
    case "iw7_fmg":
      var_1 hidepart("tag_sight_off");
      var_1 hidepart("tag_sight_off2");
      break;
    case "iw7_gambit":
    case "iw7_sdfar":
      var_1 hidepart("tag_sight_off");
      break;
    case "iw7_sdflmg":
    case "iw7_repeater":
      var_1 hidepart("tag_sight_off");
      break;
    case "iw7_lmg03":
      var_1 hidepart("tag_sight_off");
      break;
    case "iw7_erad":
      var_1 hidepart("tag_sight_off");
      break;
    case "iw7_ump45":
      var_1 hidepart("j_loose_round");
      var_1 hidepart("tag_sight_off");
      break;
    case "iw7_ripper":
      var_1 hidepart("tag_sight_off");
      var_1 hidepart("tag_sight_off2");
      var_1 hidepart("tag_zerog_off");
      break;
    case "iw7_counterweight":
    case "iw7_fhr":
      var_1 hidepart("tag_sight_off");
      break;
    case "iw7_crb":
      var_1 hidepart("j_loose_round");
      var_1 hidepart("tag_sight_off");
      var_1 hidepart("tag_sight_off2");
      break;
    case "iw7_m8":
      var_1 hidepart("j_m8_strap_01");
      var_1 hidepart("tag_zerog_off");
      break;
    case "iw7_stasis":
    case "iw7_kbs":
      break;
    case "iw7_devastator":
      var_1 hidepart("tag_sight_off");
      break;
    case "iw7_sonic":
      var_1 hidepart("j_strapfar1");
      var_1 hidepart("tag_sight_off");
      var_1 hidepart("tag_sight_off2");
      var_1 hidepart("tag_zerog_off");
      break;
    case "iw7_sdfshotty":
      var_1 hidepart("tag_sight_off");
      break;
    case "iw7_emc":
      var_1 hidepart("tag_sight_off");
      break;
    case "iw7_g18":
      var_1 hidepart("j_loose_round");
      var_1 hidepart("tag_sight_off");
      break;
    case "iw7_nrg":
      break;
    case "iw7_chargeshot":
      break;
    case "iw7_atomizer":
      break;
    case "iw7_mauler":
      var_1 hidepart("tag_sight_off");
      var_1 hidepart("tag_sight_off2");
      break;
    case "iw7_lockon":
      var_1 hidepart("j_mag1");
      var_1 hidepart("j_mag2");
      var_1 hidepart("tag_sight_off");
      break;
    case "iw7_steeldragon":
      break;
    case "iw7_penetrationrail":
      var_1 hidepart("j_bullet_loose");
      var_1 hidepart("j_casing_loose");
      break;
    case "iw7_m1":
      var_1 hidepart("j_clip");
      var_1 hidepart("j_mag2");
      var_1 hidepart("tag_zerog_off");
      var_1 hidepart("j_m1_cmn_strap_01");
      var_1 hidepart("j_m1_cmn_strap_02");
      var_1 hidepart("j_m1_cmn_strap_03");
      var_1 hidepart("j_m1_cmn_strap_04");
      var_1 hidepart("j_m1_cmn_strap_05");
      var_1 hidepart("j_m1_cmn_strap_06");
      var_1 hidepart("j_m1_cmn_strap_07");
      var_1 hidepart("j_m1_cmn_strap_08");
      break;
  }
}

_id_12D8(var_0, var_1) {
  switch (var_0) {
    case "iw7_ar57":
      var_1 hidepart("tag_sight_off");
      break;
    case "iw7_ake":
    case "iw7_ake_gold":
      var_1 hidepart("tag_sight_off");
      var_1 hidepart("j_eak_lgn_strap_01");
      break;
    case "iw7_m4":
      var_1 hidepart("j_kbm4_strap_01");
      var_1 hidepart("tag_sight_off");
      var_1 hidepart("tag_zerog_off");
      break;
    case "iw7_fmg":
      var_1 hidepart("tag_sight_off");
      var_1 hidepart("tag_sight_off2");
      break;
    case "iw7_gambit":
    case "iw7_sdfar":
      var_1 hidepart("tag_sight_off");
      break;
    case "iw7_sdflmg":
    case "iw7_repeater":
      var_1 hidepart("tag_sight_off");
      break;
    case "iw7_lmg03":
      var_1 hidepart("tag_sight_off");
      break;
    case "iw7_erad":
      var_1 hidepart("tag_sight_off");
      break;
    case "iw7_ump45":
      var_1 hidepart("j_loose_round");
      var_1 hidepart("tag_sight_off");
      break;
    case "iw7_ripper":
      var_1 hidepart("tag_sight_off");
      var_1 hidepart("tag_sight_off2");
      var_1 hidepart("tag_zerog_off");
      break;
    case "iw7_counterweight":
    case "iw7_fhr":
      var_1 hidepart("tag_sight_off");
      break;
    case "iw7_crb":
      var_1 hidepart("j_loose_round");
      var_1 hidepart("tag_sight_off");
      var_1 hidepart("tag_sight_off2");
      break;
    case "iw7_m8":
      var_1 hidepart("j_m8_strap_01");
      var_1 hidepart("j_bipod_re");
      var_1 hidepart("j_bipod_le");
      var_1 hidepart("tag_zerog_off");
      break;
    case "iw7_stasis":
    case "iw7_kbs":
      break;
    case "iw7_devastator":
      var_1 hidepart("tag_sight_off");
      break;
    case "iw7_sonic":
      var_1 hidepart("j_strapfar1");
      var_1 hidepart("tag_sight_off");
      var_1 hidepart("tag_sight_off2");
      var_1 hidepart("tag_zerog_off");
      break;
    case "iw7_sdfshotty":
      var_1 hidepart("tag_sight_off");
      break;
    case "iw7_emc":
      var_1 hidepart("tag_sight_off");
      break;
    case "iw7_g18":
      var_1 hidepart("j_loose_round");
      var_1 hidepart("tag_sight_off");
      break;
    case "iw7_nrg":
      break;
    case "iw7_chargeshot":
      break;
    case "iw7_atomizer":
      break;
    case "iw7_mauler":
      var_1 hidepart("tag_sight_off");
      var_1 hidepart("tag_sight_off2");
      break;
    case "iw7_lockon":
      var_1 hidepart("j_mag1");
      var_1 hidepart("j_mag2");
      var_1 hidepart("tag_sight_off");
      break;
    case "iw7_steeldragon":
      break;
    case "iw7_penetrationrail":
      var_1 hidepart("j_bullet_loose");
      var_1 hidepart("j_casing_loose");
      var_1 hidepart("j_panel01");
      var_1 hidepart("j_panel02");
      var_1 hidepart("j_panel03");
      var_1 hidepart("tag_laser_attach");
      var_1 hidepart("tag_glass_hip");
      var_1 hidepart("tag_glass_ads");
      break;
    case "iw7_m1":
      var_1 hidepart("j_clip");
      var_1 hidepart("j_mag2");
      var_1 hidepart("tag_zerog_off");
      var_1 hidepart("j_m1_cmn_strap_01");
      var_1 hidepart("j_m1_cmn_strap_02");
      var_1 hidepart("j_m1_cmn_strap_03");
      var_1 hidepart("j_m1_cmn_strap_04");
      var_1 hidepart("j_m1_cmn_strap_05");
      var_1 hidepart("j_m1_cmn_strap_06");
      var_1 hidepart("j_m1_cmn_strap_07");
      var_1 hidepart("j_m1_cmn_strap_08");
      break;
  }
}

menu_sys(var_0, var_1, var_2) {
  var_3 = level.player _meth_84C6("selectedLoadout");
  var_4 = level.player _meth_84C6("loadouts", var_3, "weaponSetups", var_1, "attachment", 0);
  var_5 = _id_7839(var_0, var_4);

  if(isDefined(var_5) && var_5 != "") {
    var_6 = "tag_" + var_4;

    if(scripts\sp\utility::hastag(var_2, var_6)) {
      level._id_B671 setModel(var_5);
      level._id_B671 linkTo(var_2, var_6, (0, 0, 0), (0, 0, 0));
      level._id_B671 show();
      return;
    }
  } else {
    level._id_B671 setModel("tag_origin");
    level._id_B671 hide();
  }
}

_id_134A(var_0, var_1) {
  if(isDefined(level._id_B671)) {
    level._id_B671 setModel("tag_origin");
    level._id_B671 hide();
  }

  switch (var_0) {
    case "iw7_ar57":
      break;
    case "iw7_ake":
    case "iw7_ake_gold":
      break;
    case "iw7_m4":
      break;
    case "iw7_fmg":
      break;
    case "iw7_sdfar":
      break;
    case "iw7_gambit":
      break;
    case "iw7_sdflmg":
      break;
    case "iw7_repeater":
      break;
    case "iw7_lmg03":
      break;
    case "iw7_erad":
      break;
    case "iw7_ump45":
      break;
    case "iw7_ripper":
      break;
    case "iw7_fhr":
      break;
    case "iw7_counterweight":
      break;
    case "iw7_crb":
      var_1 hidepart("j_loose_round");
      break;
    case "iw7_m8":
      level._id_B671 setModel("weapon_m8garandscope_vm");
      level._id_B671 linkTo(var_1, "tag_scope", (0, 0, 0), (0, 0, 0));
      level._id_B671 show();
      break;
    case "iw7_kbs":
      level._id_B671 setModel("weapon_kbsniper_scope_vm");
      level._id_B671 linkTo(var_1, "tag_scope", (0, 0, 0), (0, 0, 0));
      level._id_B671 show();
      break;
    case "iw7_stasis":
      break;
    case "iw7_devastator":
      break;
    case "iw7_sonic":
      break;
    case "iw7_sdfshotty":
      break;
    case "iw7_emc":
      break;
    case "iw7_g18":
      break;
    case "iw7_nrg":
      break;
    case "iw7_chargeshot":
      break;
    case "iw7_atomizer":
      break;
    case "iw7_mauler":
      break;
    case "iw7_lockon":
      break;
    case "iw7_steeldragon":
      break;
    case "iw7_penetrationrail":
      break;
    case "iw7_m1":
      break;
  }
}

_id_1280() {
  var_0 = getEnt("plr_weaponview_link", "targetname");
  level._id_37BD = scripts\engine\utility::spawn_script_origin(var_0.origin + anglestoup(var_0.angles) * -66, var_0.angles);
  scripts\sp\utility::_id_11633(level._id_37BD);
  level.player playerlinktodelta(level._id_37BD, undefined, 1, 0, 0, 0, 0, 1);
}

_id_D351(var_0) {
  var_1 = 0.5;
  level.player endon("player_vr_exit_request");
  level endon("acceped_vr");
  level endon("armory_chose_loadout");
  var_2 = var_0.angles[1];
  var_3 = var_0.angles[2];
  var_4 = var_2;
  var_5 = var_3;
  var_6 = getsticksconfig();
  var_7 = undefined;

  if(isDefined(level.console) && level.console || level.player usinggamepad()) {
    if(issubstr(var_6, "southpaw"))
      var_7 = 1;
  }

  for(;;) {
    var_8 = level.player _meth_814B();

    if(isDefined(var_7) && var_7)
      var_8 = level.player getnormalizedmovement();

    var_9 = var_8[1];
    var_10 = var_8[0];
    var_11 = _id_0C4C::_id_6F41(var_9, -1, 1, -30, 50);
    var_12 = _id_0C4C::_id_6F41(var_10, -1, 1, -65, 65);
    var_4 = var_4 + (var_11 - var_4) * var_1;
    var_5 = var_5 + (var_12 - var_5) * var_1;
    var_0.angles = (var_0.angles[0], var_4 + var_2, var_5 + var_3);
    scripts\engine\utility::waitframe();
  }
}

_id_D350(var_0, var_1, var_2, var_3) {
  scripts\engine\utility::flag_wait_any("acceped_vr", "armory_chose_loadout");
  level waittill("vr_transition_bink_full_opacity");
  var_0 delete();
  var_1.origin = level._id_13C2D.origin;
  var_1.angles = level._id_13C2D.angles;
  var_1 setModel("tag_origin");

  if(isDefined(level._id_B671)) {
    level._id_B671 setModel("tag_origin");
    level._id_B671 hide();
  }

  level._id_13C45 = "tag_origin";
  killfxontag(scripts\engine\utility::getfx("vfx_ui_locked_weapon"), var_1, "tag_origin");
  level.player _meth_822F();
}

_id_F55A() {
  var_0 = level.script;

  switch (var_0) {
    case "shipcrib_titan":
      level._id_D833["primary"] = "iw7_ar57";
      level._id_D833["secondary"] = "iw7_erad";
      level._id_D833["offhand"] = "frag";
      level._id_D833["item"] = "offhandshield";
      break;
    case "shipcrib_europa":
      level._id_D833["primary"] = "iw7_ar57";
      level._id_D833["secondary"] = "iw7_nrg";
      level._id_D833["offhand"] = "emp";
      level._id_D833["item"] = undefined;
      break;
    case "shipcrib_moon":
      level._id_D833["primary"] = "iw7_ar57";
      level._id_D833["secondary"] = "iw7_nrg";
      level._id_D833["offhand"] = "frag";
      level._id_D833["item"] = undefined;
      break;
    case "shipcrib_rogue":
      level._id_D833["primary"] = "iw7_ar57";
      level._id_D833["secondary"] = "iw7_nrg";
      level._id_D833["offhand"] = "frag";
      level._id_D833["item"] = "supportdrone";
      break;
    case "shipcrib_gravity":
      level._id_D833["primary"] = "iw7_ar57";
      level._id_D833["secondary"] = "iw7_nrg";
      level._id_D833["offhand"] = "frag";
      level._id_D833["item"] = undefined;
      break;
    case "shipcrib_prisoner":
      level._id_D833["primary"] = "iw7_ar57";
      level._id_D833["secondary"] = "iw7_nrg";
      level._id_D833["offhand"] = "frag";
      level._id_D833["item"] = undefined;
      break;
  }
}

_id_13311(var_0, var_1) {
  if(!_id_3DB1("marscrib")) {
    wait(var_1);
    var_2 = scripts\engine\utility::spawn_tag_origin(var_0.origin);
    var_2 linkTo(var_0, "gun_rack_jt", (0, 0, 0), (0, 0, 0));
    var_3 = scripts\engine\utility::spawn_tag_origin(var_0.origin);
    playFXOnTag(scripts\engine\utility::getfx("vfx_sc_gun_rack_opening"), var_2, "tag_origin");
    playFXOnTag(scripts\engine\utility::getfx("vfx_sc_gun_rack_open"), var_3, "tag_origin");
  }
}

_id_FA5A() {
  var_0 = getEntArray("vr_goggles", "targetname");
  var_1 = getEntArray("vr_pistol", "targetname");
  var_2 = getEntArray("vr_rifle", "targetname");

  foreach(var_4 in var_0) {
    if(isDefined(var_4.script_parameters)) {
      if(var_4.script_parameters == "lounge_terminal_2") {
        var_4 notsolid();
        var_4 hide();
      }
    }
  }

  foreach(var_7 in var_1) {
    if(isDefined(var_7.script_parameters)) {
      if(var_7.script_parameters == "lounge_terminal_2")
        var_7 notsolid();
    }
  }

  foreach(var_10 in var_2) {
    if(isDefined(var_10.script_parameters)) {
      if(var_10.script_parameters == "lounge_terminal_2") {
        var_10 notsolid();
        var_10 hide();
      }
    }
  }
}