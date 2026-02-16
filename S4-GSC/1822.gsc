/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1822.gsc
*************************************************/

_id_7F50() {
  level._id_E69A = scripts\engine\utility::getstruct("damage_starting_door", "script_noteworthy");

  if(!isDefined(level._id_E69A)) {
    return;
  }
  var_0 = getEntArray(level._id_E69A.target, "targetname");

  foreach(var_2 in var_0) {
    var_2 thread _id_10B08();
  }

  _id_0748::_id_D625(6);
}

_id_10B08() {
  level endon("new_objective_chosen");
  level._id_E69A waittill("open_doors", var_0);

  if(self.classname == "script_brushmodel") {
    self _meth_8093();
    self notsolid();
  }

  if(var_0 == "Tactical Breaching Hammer") {
    level notify("objective_completed");
    _id_0748::_id_395F();
    var_1 = scripts\cp\utility::_id_6AC2("damage_door");

    foreach(var_3 in level.players) {
      _id_0748::_id_3960(var_3);
    }

    _id_0748::_id_D625(7);
  }
}

_id_68C7() {
  var_0 = "cp/zombies/coop_destruction_table.csv";
  level._id_3E49 = [];

  for(var_1 = 1; var_1 <= 2; var_1++) {
    var_2 = _func_0222(var_0, 0, var_1, 1);
    level._id_3E49[var_2] = spawnStruct();
    level._id_3E49[var_2]._id_3E46 = var_1;
    level._id_3E49[var_2]._id_3E45 = var_2;
    level._id_3E49[var_2]._id_B5BD = _id_6C41(var_2);
    level._id_3E49[var_2]._id_B5BE = _func_0222(var_0, 0, var_1, 3);
    level._id_3E49[var_2]._id_B5BF = _func_0222(var_0, 0, var_1, 4);
    level._id_3E49[var_2]._id_B5C0 = _func_0222(var_0, 0, var_1, 5);
    level._id_3E49[var_2]._id_A84E = _id_6BBB(var_2);
    level._id_3E49[var_2]._id_A84F = _func_0222(var_0, 0, var_1, 7);
  }

  level._id_6016["scriptModelPlayAnim"] = ::_meth_82CB;
}

#using_animtree("script_model");

_id_6BBB(var_0) {
  switch (var_0) {
    case "Tactical Breaching Hammer":
      return % wm_equip_c4_attach_c4;
    case "Breach Charge":
      return % wm_equip_c4_attach_c4;
  }
}

_id_6C41(var_0) {
  switch (var_0) {
    case "Tactical Breaching Hammer":
      return % wm_equip_c4_attach;
    case "Breach Charge":
      return % wm_equip_c4_attach;
  }
}

_id_7F57() {
  var_0 = _func_0415();

  if(_func_0121(var_0) || !var_0) {
    level._effect["breach_explode"] = loadfx("vfx/core/blank.vfx");
  } else {
    level._effect["breach_explode"] = loadfx("vfx/iw8_mp/breaches/vfx_gen_door_breach_thick.vfx");
  }

  level thread _id_68C7();
  _id_06C6::_id_812F();

  if(!isDefined(level._id_CC49)) {
    level._id_CC49 = [];
  }

  if(!isDefined(level._id_CC3B)) {
    level._id_CC3B = [];
  }

  anim._id_2F52["TeleportEnt"] = _id_0706::_id_F023;
  anim._id_2F52["ShouldDoAnim"] = _id_0706::_id_DA85;
  anim._id_2F52["DoAnimation"] = _id_0706::_id_4BDE;
  anim._id_2F52["DoFacialAnim"] = _id_0706::_id_4BF7;
  level._id_487E = [];
  level thread _id_10AFD();
  wait 3;
  level thread _id_7F50();
  _id_0FB7("destructible_door_double", "targetname");
}

_id_0FB7(var_0, var_1) {
  var_2 = getEntArray(var_0, var_1);

  foreach(var_4 in var_2) {
    var_5 = spawnStruct();
    _id_0FB6(var_5, var_4);
    var_5 _id_1D1E(level._id_EF89);
    var_5 thread _id_FD82();

    if(!isDefined(level._id_487E[var_0])) {
      level._id_487E[var_0] = [];
    }

    level._id_487E[var_0][level._id_487E[var_0].size] = var_5;
    var_5 _id_BD3B("init");
  }
}

_id_BE86() {
  wait 16;

  foreach(var_1 in level._id_487E["destructible_door_double"]) {
    foreach(var_3 in var_1._id_5526) {
      if(isDefined(var_3.classname)) {
        if(var_3.classname == "script_model" || var_3.classname == "script_origin" || var_3.classname == "script_brushmodel") {
          var_3 delete();
        }
      }
    }
  }

  foreach(var_11, var_7 in level._id_FE48) {
    foreach(var_10, var_9 in var_7) {
      var_9 delete();
    }
  }
}

_id_CDBE(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  level._id_CC34["planter"] = #animtree;
  level._id_CC31["planter"]["plant"] = % wm_equip_c4_attach;
  level._id_CC32["planter"]["plant"] = "wm_equip_c4_attach";
  level._id_CC3B["planter"]["plant"] = "equip_c4_attach";
  level._id_CC49["planter"]["plant"] = "vm_equip_c4_attach";
  level._id_CC34["lightswitch"] = #animtree;
  level._id_CC31["lightswitch"]["interact_on"] = var_0;
  level._id_CC32["lightswitch"]["interact_on"] = var_1;
  level._id_CC3B["lightswitch"]["interact_on"] = var_2;
  level._id_CC49["lightswitch"]["interact_on"] = var_3;

  if(isDefined(var_6)) {
    level._id_CC34[var_6] = #animtree;
    level._id_CC31[var_6]["plant"] = var_4;
    level._id_CC32[var_6]["plant"] = var_5;
  }

  if(var_6 == "c4") {
    level._id_2B66 = _func_0079(level._id_CC31["planter"]["plant"]);
  } else {
    level._id_2B66 = _func_0079(level._id_CC31["lightswitch"]["interact_on"]);
  }
}

_id_3F5D(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_0) || isDefined(var_0._id_B5A4)) {
    return;
  }
  var_0._id_18AF = var_1;

  if(!isDefined(var_2)) {
    var_2 = "viewhands_base_iw8";
  }

  var_0 _meth_8282(var_0.origin);
  var_4 = spawn("script_arms", var_0.origin, 0, 0, var_0);
  var_4.player = var_0;
  var_0._id_B5A4 = var_4;
  var_0._id_B5A4 hide();
  var_0._id_B5A4._id_18AF = var_1;
  var_0._id_B5A4 useanimtree(#animtree);
  var_0 scripts\common\utility::_id_153E(0);
  var_0 scripts\common\utility::_id_151F(0);

  if(isDefined(var_1) && var_1 == "planter") {
    var_0 playerlinktodelta(var_0._id_B5A4, "tag_player", 0, 0, 0, 0, 0, 0, 0);
  } else {
    var_0 playerlinktodelta(var_0._id_B5A4, "tag_player", 1, 0, 0, 0, 0, 0, 0);
  }

  var_0 _id_10A7E();
  _id_C436(var_0);
}

_id_C436(var_0) {
  if(!isDefined(var_0) || !isDefined(var_0._id_B5A4) || !isDefined(var_0.origin)) {
    return;
  }
  var_0 unlink();

  if(isDefined(var_0 _meth_812D(var_0.origin))) {
    var_0 setorigin(var_0 _meth_812D(var_0.origin));
  }

  var_0._id_B5A4 delete();
  var_0._id_B5A4 = undefined;
  var_0 scripts\common\utility::_id_153E(1);
  var_0 scripts\common\utility::_id_151F(1);
  var_0 notify("remove_rig");
}

_id_10A7E(var_0) {
  scripts\engine\utility::waittill_any_3("remove_rig", "death", "disconnect");
}

_id_0FB6(var_0, var_1) {
  if(!isDefined(var_0._id_5526)) {
    var_0._id_5526 = [];
  }

  var_0 _id_C0A1(var_1);
  var_0 _id_C09D(var_1);
  var_0._id_5526[var_0._id_5526.size] = var_1;
  var_1.parent = var_0;

  if(isDefined(var_1.target)) {
    var_2 = getEntArray(var_1.target, "targetname");
    var_3 = scripts\engine\utility::getStructArray(var_1.target, "targetname");

    if(isDefined(var_2) && var_2.size > 0) {
      foreach(var_5 in var_2) {
        _id_0FB6(var_0, var_5);
      }
    }

    if(isDefined(var_3) && var_3.size > 0) {
      foreach(var_8 in var_3) {
        _id_0FB6(var_0, var_8);
      }
    }
  }
}

_id_C0A1(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  if(!isDefined(self._id_BC26)) {
    self._id_BC26 = [];
  }

  if(!isDefined(var_0.classname)) {
    if(isDefined(var_0._id_CE18)) {
      switch (var_0._id_CE18) {
        case "bomb_preview_2":
        case "bomb_preview":
          var_1 = var_0._id_CD99;
          var_2 = var_0._id_CE18;

          if(isDefined(var_2)) {
            self._id_BC26[var_0._id_CE18] = var_0;
          }

          break;
      }
    }
  } else {
    switch (var_0.classname) {
      case "trigger_use_touch":
        var_3 = var_0.name;

        if(isDefined(var_3)) {
          switch (var_3) {
            case "bomb_trigger_1":
            case "bomb_trigger_2":
              self._id_FE17[var_3] = var_0;
              break;
          }
        }

        break;
      case "script_model":
        var_1 = var_0._id_CD99;
        var_2 = var_0._id_CE18;

        if(isDefined(var_2)) {
          if(var_0._id_CD99 == self._id_5526[0].name) {
            self._id_BC26[var_0._id_CD99] = var_0;
          }
        }

        var_4 = var_0.name;

        if(isDefined(var_4)) {
          self._id_10DE4 = var_4;
        }

        break;
    }
  }
}

_id_C09D(var_0) {
  if(!isDefined(var_0._id_039B)) {
    return;
  }
  var_1 = strtok(var_0._id_039B, ",");

  foreach(var_3 in var_1) {
    var_4 = strtok(var_3, "|");

    if(!isDefined(var_4)) {
      return;
    }
    if(var_4.size < 2) {
      return;
    }
    var_3 = var_4[0];

    if(!isDefined(var_0._id_0E8E)) {
      var_0._id_0E8E = [];
    }

    if(!isDefined(var_0._id_0E8E[var_3])) {
      var_0._id_0E8E[var_3] = [];
    }

    for(var_5 = 1; var_5 < var_4.size; var_5++) {
      var_0._id_0E8E[var_3][var_0._id_0E8E[var_3].size] = var_4[var_5];
    }
  }
}

_id_BD3B(var_0) {
  if(!isDefined(self._id_5526)) {
    return;
  }
  foreach(var_2 in self._id_5526) {
    if(isDefined(var_2._id_0E8E) && isDefined(var_2._id_0E8E[var_0])) {
      foreach(var_4 in var_2._id_0E8E[var_0]) {
        var_2 _id_0E8C(var_4, self);
      }
    }
  }

  self._id_E747 = var_0;
}

_id_BD3C(var_0, var_1, var_2) {
  if(!isDefined(self._id_5526)) {
    return;
  }
  foreach(var_4 in self._id_5526) {
    if(isDefined(var_4._id_0E8E) && isDefined(var_4._id_0E8E[var_0])) {
      foreach(var_6 in var_4._id_0E8E[var_0]) {
        if(var_6 == var_1) {
          var_6 = var_2;
        }

        var_4 _id_0E8C(var_6, self);
      }
    }
  }

  self._id_E747 = var_0;
}

_id_0E8C(var_0, var_1) {
  switch (var_0) {
    case "onuse":
      if(isDefined(level._id_0E8D) && isDefined(level._id_0E8D["onuse"])) {
        level[[level._id_0E8D["onuse"]]](var_1);
      }

      break;
    case "show":
      if(isent(self)) {
        self show();
      }

      break;
    case "hide":
      if(isent(self)) {
        self hide();
      }

      break;
    case "solid":
      if(isent(self)) {
        self solid();
      }

      break;
    case "notsolid":
      if(isent(self)) {
        self notsolid();
      }

      break;
    case "disconnectpaths":
      if(isent(self)) {
        self _meth_80B5();
      }

      break;
    case "connectpaths":
      if(isent(self)) {
        self _meth_8093();
      }

      break;
    case "bomb_explosion":
      var_2 = self.origin;
      var_3 = scripts\engine\utility::ter_op(isDefined(self.angles), self.angles, (0, 0, 0));
      var_4 = undefined;
      var_4 = spawnfx(level._effect["breach_explode"], var_2, anglesToForward(var_3) * -1.0, (0, 0, 1));
      triggerfx(var_4);
      physicsexplosionsphere(var_2, 200, 100, 3);

      foreach(var_6 in level.players) {
        if(distancesquared(var_6.origin, var_2) > 562500) {
          continue;
        }
        var_6 shellshock("bradley_mp_turret", 2);
      }

      earthquake(0.5, 1.0, var_2, 1000);

      if(_func_0205("breach_c4_expl_trans")) {
        playsoundatpos(var_2, "breach_c4_expl_trans");
      }

      waitframe();
      var_4 delete();
      break;
    case "crowbar_break":
      var_2 = self.origin;
      earthquake(0.2, 1.0, var_2, 1000);

      if(_func_0205("breach_c4_expl_trans")) {
        playsoundatpos(var_2, "breach_c4_expl_trans");
      }

      break;
  }
}

_id_4870() {
  if(getdvarint("#x3d15d4ac8efb6b5f1", 0) == 0) {
    _id_0737::_id_C266("destructible_door_double", ::_id_2B62, ::_id_B1C8, ::_id_8155);
  }
}

_id_2B62(var_0, var_1) {
  var_2 = "";

  if(isDefined(level._id_5FF0)) {
    return [[level._id_5FF0]](var_0, var_1);
  }

  if(scripts\cp\utility::_id_89AE() || level._id_AB30) {
    if((!isDefined(var_1._id_BADE["power_c4"]) || var_1._id_BADE["power_c4"]._id_3411 <= 0) && istrue(var_1._id_74E2)) {
      var_1 thread _id_F0D0(var_0, var_1);
      var_1._id_8388 _meth_84DA("hud_icon_door_breach");
      var_1._id_8388 sethintrequiresholding(1);
      var_1._id_8388 setuseholdduration("duration_long");
      var_1._id_8388 _meth_84D4(96);
      var_1._id_8388 sethintdisplayfov(270);
      var_1._id_8388 setuserange(96);
      var_1._id_8388 setusefov(270);
      var_2 = &"COOP_CRAFTING/BREACH_CROWBAR_HINT";
    } else if(isDefined(var_1._id_BADE["power_c4"]) || !istrue(var_1._id_74E2) || istrue(var_1._id_5E8C)) {
      var_1._id_8388 _meth_84DA("hud_icon_c4_plant");
      var_2 = &"COOP_CRAFTING/BREACH_HINT";
    }
  } else if((!isDefined(var_1._id_BADE["power_c4"]) || var_1._id_BADE["power_c4"]._id_3411 <= 0) && istrue(var_1._id_74E2)) {
    var_1 thread _id_F0D0(var_0, var_1);

    if(!_id_896B(var_0.origin, var_1)) {
      var_1._id_8F31 = undefined;
      var_1._id_8388 _meth_84DA("hud_icon_loot_helmet");
      var_2 = &"CP_SURIVAL/BARN_BREACH";
      var_1._id_8388 _meth_8557(1);
    } else {
      var_1._id_8F31 = undefined;
      var_1._id_8388 _meth_84DA("hud_icon_door_breach");
      var_1._id_8388 sethintrequiresholding(1);
      var_1._id_8388 setuseholdduration("duration_medium");
      var_2 = &"COOP_CRAFTING/BREACH_CROWBAR_HINT";
    }
  } else if(isDefined(var_1._id_BADE["power_c4"]) || istrue(var_1._id_5E8C)) {
    var_1._id_8388 _meth_84DA("hud_icon_c4_plant");
    var_2 = &"COOP_CRAFTING/BREACH_HINT";
  }

  return var_2;
}

_id_F0D0(var_0, var_1) {
  var_1 notify("testAnimationDuringUseDuration");
  var_1 endon("testAnimationDuringUseDuration");
  var_2 = var_1 scripts\engine\utility::_id_1088C(var_1._id_8388, "trigger_progress");

  if(!isDefined(var_0._id_039B) || var_0._id_039B != "destructible_door_double") {
    return;
  }
  var_1 thread _id_B1C8(var_0, var_1, 1);
  var_1 endon("set_interaction_point");
  var_1 thread _id_50E3(var_1);
  var_2 = var_1 scripts\engine\utility::_id_1088C(var_1._id_8388, "trigger", var_1, "set_interaction_point", var_1, "starting_interaction_search", var_1, "left_early", level, "door_breached");

  if(isDefined(var_2) && var_2 != "left_early") {
    var_1 notify("trigger_success");
  }

  _id_C436(var_1);

  if(isDefined(var_1._id_9515)) {
    var_1 unlink();
    var_1._id_9515 delete();
    var_1._id_9515 = undefined;
  }

  var_1._id_8791 = 0;
  var_1 _meth_8494("ges_vest_replace");
}

_id_50E3(var_0) {
  var_0 endon("death");
  var_0 endon("disconnect");
  var_0 endon("set_interaction_point");
  var_0 endon("trigger_success");

  while(var_0 useButtonPressed()) {
    waitframe();
  }

  var_0 notify("left_early");
}

_id_8155(var_0) {
  foreach(var_2 in var_0) {
    if(var_2._id_039B == "destructible_door_double") {
      _id_0FB6(var_2, var_2);
      _id_E9CA(var_2);
      var_2 thread _id_38A1(var_2);

      foreach(var_4 in var_0) {
        if(var_4 != var_2) {
          if(var_2.target == var_4.target) {
            var_2._id_AC47 = var_4;
            _id_E9CA(var_2._id_AC47);
          }
        }
      }
    }
  }
}

_id_2B65(var_0, var_1) {
  if(level.gametype == "cp_survival") {
    level notify("defend_sequence_started");
    _id_0737::_id_C4AB(var_0._id_039B);
  }
}

_id_896B(var_0, var_1) {
  level endon("game_ended");
  var_2 = 0;

  foreach(var_4 in level.players) {
    if(var_4 != var_1) {
      if(distance(var_4.origin, var_0) <= 96) {
        var_2 = 1;
        break;
      }
    }
  }

  return var_2;
}

_id_E9CA(var_0) {
  if(!isDefined(level._id_FE48)) {
    level._id_FE48 = [];
  }

  level._id_FE48[level._id_FE48.size] = var_0;
}

_id_10AFD() {
  level endon("game_ended");

  for(;;) {
    level waittill("connected", var_0);
    var_0 thread _id_DC83();
  }
}

_id_DC83() {
  self endon("disconnect");
  self endon("death");
  level endon("game_ended");
  self notify("one_instance_of_showhidebreachobjfunc");
  self endon("one_instance_of_showhidebreachobjfunc");

  for(;;) {
    var_0 = scripts\engine\utility::_id_10897("disable_breach_hint", "enable_breach_hint");

    if(!isDefined(var_0)) {
      continue;
    }
    if(!isDefined(level._id_FE48)) {
      continue;
    }
    switch (var_0) {
      case "disable_breach_hint":
        foreach(var_2 in level._id_FE48) {
          if(isDefined(var_2) && scripts\engine\utility::array_contains(level._id_417B, var_2)) {
            var_2._id_F04C = 1;
            _id_0737::_id_C3C5(var_2);
          }
        }

        break;
      case "enable_breach_hint":
        foreach(var_2 in level._id_FE48) {
          if(isDefined(var_2)) {
            if(isDefined(var_2._id_F04C) && var_2._id_F04C == 1) {
              var_2._id_F04C = 0;
              _id_0737::_id_1037(var_2);
            }
          }
        }

        break;
    }
  }
}

_id_38A1(var_0) {
  self waittill("delete_this_thread_for_" + var_0.target);

  switch (var_0.name) {
    case "bomb_preview":
      foreach(var_2 in var_0._id_5526) {
        if(isDefined(var_2.classname)) {
          if(var_2.classname == "script_model" || var_2.classname == "script_origin" || var_2.classname == "script_brushmodel") {
            var_2 delete();
          }
        }
      }

      break;
    case "bomb_preview_2":
      foreach(var_2 in var_0._id_5526) {
        if(isDefined(var_2.classname)) {
          if(var_2.classname == "script_model" || var_2.classname == "script_origin" || var_2.classname == "script_brushmodel") {
            var_2 delete();
          }
        }
      }

      break;
  }
}

_id_68C3(var_0) {
  foreach(var_2 in level._id_3E49) {
    if(var_2._id_3E45 == var_0) {
      return var_2;
    }
  }
}

_id_361D() {
  var_0 = ["Breach Charge"];
  var_1 = scripts\engine\utility::random(var_0);
  return var_1;
}

_id_75A3(var_0) {
  foreach(var_2 in self._id_3E4A) {
    if(var_0 == var_2) {
      return 1;
    }
  }

  return 0;
}

_id_B1C8(var_0, var_1, var_2) {
  var_1 endon("left_early");
  var_1 endon("breach_restart");

  if(var_0._id_039B != "destructible_door_double") {
    return;
  }
  if(isDefined(level._id_5FED)) {
    return self[[level._id_5FED]](var_0, var_1);
  }

  if(isDefined(level._id_5FEE)) {
    if(!istrue([[level._id_5FEE]](var_0, var_1))) {
      return;
    }
  }

  var_3 = 1;

  if(!level._id_AB30) {
    var_4 = 2;
  } else {
    var_4 = 1;
  }

  if((!isDefined(var_1._id_BADE["power_c4"]) || var_1._id_BADE["power_c4"]._id_3411 <= 0) && isDefined(var_2) && istrue(var_1._id_74E2)) {
    var_5 = 3.3;
    var_6 = 1.0;
    _id_40A9(var_1, var_0, var_3, var_4, var_5, var_6);
    return 1;
  } else if(!isDefined(var_1._id_F1B3) && !isDefined(self._id_B1CB)) {
    _id_2629(var_1, var_0);
    return 1;
  }

  return 0;
}

_id_2629(var_0, var_1) {
  if(isDefined(var_0._id_5E8C) && !var_0._id_5E8C) {
    var_0 thread _id_0753::_id_BA96(-1, var_0._id_BADE["power_c4"]._id_DDEF);
  }

  if(istrue(var_0._id_2B6D)) {
    return;
  }
  var_0._id_2B6D = 1;

  if(isPlayer(var_0)) {
    var_1 _id_25F7(var_0, var_1);
  }

  var_1 thread _id_0E8C("onuse", var_1);

  if(isPlayer(var_0)) {
    _id_C436(var_0);
  }

  var_1 thread _id_261B(var_0, var_1);
}

_id_25F7(var_0, var_1) {
  _id_0737::_id_C3C5(var_1);
  var_1._id_B785 = -1;

  if(isDefined(var_1._id_AC47)) {
    _id_0737::_id_C3C5(var_1._id_AC47);
  }

  _id_CDBE(%wm_equip_c4_attach, "wm_equip_c4_attach", "equip_c4_attach", "vm_equip_c4_attach", %wm_equip_c4_attach_c4, "wm_equip_c4_attach_c4", "c4");

  if(!isDefined(var_0._id_8388)) {
    return;
  }
  thread _id_10BD6(var_0);
  var_0._id_9515 = var_0 scripts\engine\utility::spawn_tag_origin();
  var_0 playerlinktodelta(var_0._id_9515, "tag_origin", 1, 0, 0, 0, 0, 0);
  var_0._id_9515 moveto(var_1.origin, 0.25, 0.1, 0.1);

  if(!isDefined(var_1.angles)) {
    var_1.angles = (0, 0, 0);
  }

  var_0._id_9515 rotateto(var_1.angles, 0.25, 0.1, 0.1);
  var_0 setstance("stand");
  wait 0.29;

  if(istrue(self._id_3163)) {
    return 0;
  }

  var_0 unlink();
  var_0._id_9515 delete();
  var_0._id_9515 = undefined;
  thread _id_3F5D(var_0, "planter");
  var_0 thread _id_0706::_id_17FD(var_0, var_0._id_B5A4, "plant");
  var_0 setstance("stand");
  var_2 = spawn("script_model", var_1.origin);
  var_2 setModel("offhand_wm_c4");
  var_2._id_18AF = "c4";
  var_2 useanimtree(#animtree);
  self._id_B1CB = var_2;
  var_1 thread _id_06C6::_id_1845(var_2, "plant");
  wait(_func_0079(level._id_CC31["planter"]["plant"]));

  if(istrue(self._id_3163)) {
    return 0;
  }
}

_id_261B(var_0, var_1) {
  var_1 endon("stop_bomb_think");

  if(!isDefined(self._id_2B6C)) {
    if(!isDefined(level._id_2B6C)) {
      level._id_2B6C = 0;
    } else {
      level._id_2B6C++;
    }

    self._id_2B6C = level._id_2B6C;
  }

  var_0._id_2B6D = undefined;

  if(!istrue(var_1._id_A513)) {
    _id_260A(var_1);
  }

  _id_BD3B("destroyed");
  var_1 _id_BD3B("destroyed");
  _id_0737::_id_C3C5(var_1);

  if(isDefined(var_1._id_AC47)) {
    _id_0737::_id_C3C5(var_1._id_AC47);
  }

  wait 0.1;

  if(isDefined(self._id_B1CB)) {
    if(isDefined(var_0)) {
      self._id_B1CB radiusdamage(self._id_B1CB.origin, 300, 1000, 100, var_0, "MOD_EXPLOSIVE");
    } else {
      self._id_B1CB radiusdamage(self._id_B1CB.origin, 300, 1000, 100, undefined, "MOD_EXPLOSIVE");
    }
  }

  level notify("door_breached", self.origin, var_1);

  if(isDefined(self._id_B1CB)) {
    self._id_B1CB delete();
    self._id_B1CB = undefined;
  }

  var_2 = getEntArray("final_breach_collision", "targetname");
  var_3 = scripts\engine\utility::_id_6969(var_1.origin, var_2, 100);

  if(isDefined(var_3)) {
    var_3 _meth_8093();
    var_3 delete();
  }

  if(isDefined(level._id_5FEF)) {
    thread[[level._id_5FEF]](self.origin);
  }

  var_1 notify("delete_this_thread_for_" + var_1.target);
}

_id_260A(var_0) {
  var_1 = gettime();
  var_2 = int(var_1 + 5000);
  var_3 = var_2 - var_1;

  while(var_3 > 0) {
    var_1 = gettime();
    var_3 = var_2 - var_1;

    if(var_3 < 1500) {
      if(var_3 <= 250) {
        if(_func_0205("breach_warning_beep_05")) {
          self._id_B1CB playSound("breach_warning_beep_05");
        }
      } else if(var_3 < 500) {
        if(_func_0205("breach_warning_beep_04")) {
          self._id_B1CB playSound("breach_warning_beep_04");
        }
      } else if(var_3 < 1500) {
        if(_func_0205("breach_warning_beep_03")) {
          self._id_B1CB playSound("breach_warning_beep_03");
        }
      } else if(_func_0205("breach_warning_beep_02"))
        self._id_B1CB playSound("breach_warning_beep_02");

      wait 0.25;
    } else if(var_3 < 3500) {
      if(_func_0205("breach_warning_beep_02")) {
        self._id_B1CB playSound("breach_warning_beep_02");
      }

      wait 0.5;
    } else {
      if(_func_0205("breach_warning_beep_01")) {
        self._id_B1CB playSound("breach_warning_beep_01");
      }

      wait 1.0;
    }

    if(var_3 < 0) {
      break;
    }
  }
}

_id_40A9(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(_id_40A7(var_0, var_1, var_2, var_3, var_4 - var_5)) {
    thread _id_40A8(var_0, var_1);
    _id_BD3B("onuse");
    _id_0E8C("onuse", self);
    self notify("breach_complete");
    _id_0737::_id_C3C5(var_1);
    _id_0737::_id_C3C5(var_1._id_AC47);
    return 1;
  } else {
    _id_C436(var_0);
    var_0._id_8791 = 0;
    return 0;
  }
}

_id_40A7(var_0, var_1, var_2, var_3, var_4) {
  _id_40A6(var_0, var_1, var_2);
  wait(var_4);

  if(istrue(self._id_3163)) {
    return 0;
  }

  var_2 = _id_6BB8(var_1);

  if(var_2 >= var_3) {
    return 1;
  }

  return 0;
}

_id_40A6(var_0, var_1, var_2) {
  _id_CDBE(%wm_eq_fusebox_turn_on_plr, "wm_eq_fusebox_turn_on_plr", "equip_c4_attach", "vm_eq_fusebox_turn_on_plr", %wm_equip_c4_attach_c4, "wm_equip_c4_attach_c4", "c4");

  if(!(var_1._id_039B == "destructible_door_double")) {
    return;
  }
  thread _id_10BD6(var_0);
  var_0._id_9515 = var_0 scripts\engine\utility::spawn_tag_origin();
  var_0 playerlinktodelta(var_0._id_9515, "tag_origin", 1, 0, 0, 0, 0, 0);
  var_0._id_8791 = 1;
  var_2 = _id_6BB8(var_1);
  _id_D4A6(var_2, var_0, var_1);

  if(!isDefined(var_0._id_2B6B)) {
    var_0._id_2B6B = 1;
  }

  if(var_0._id_2B6B == 1) {
    if(distance(var_0.origin, var_1.origin) > 3) {
      var_0._id_9515 moveto((var_1.origin + var_0.origin) / 2, 0.25, 0.05, 0.05);
    } else {
      var_0._id_9515 moveto(var_1.origin, 0.25, 0.05, 0.05);
    }

    var_3 = _id_6C5B(var_1, var_0);
    var_0._id_9515 rotateto(var_3, 0.25, 0.05, 0.05);
  } else if(var_0._id_2B6B == 2) {
    if(distance(var_0.origin, var_1.origin) > 3) {
      var_0._id_9515 moveto((var_1.origin + var_0.origin) / 2, 0.25, 0.05, 0.05);
    } else {
      var_0._id_9515 moveto(var_1.origin, 0.25, 0.05, 0.05);
    }

    var_3 = _id_6C5B(var_1, var_0);
    var_0._id_9515 rotateto(var_3, 0.25, 0.05, 0.05);
  }

  var_0 setstance("stand");
  wait 0.29;

  if(istrue(self._id_3163)) {
    return 0;
  }

  if(isDefined(var_0._id_9515)) {
    var_0 unlink();
    var_0._id_9515 delete();
    var_0._id_9515 = undefined;
  }

  thread _id_3F5D(var_0);
  var_4 = 2.0;
  var_0 _meth_84AF("ges_vest_replace");
  wait(var_4);

  if(istrue(self._id_3163)) {
    return 0;
  }

  var_0 _meth_84AF("ges_zombies_revive_jock");
  waitframe();

  if(istrue(self._id_3163)) {
    return 0;
  }

  var_0 _meth_84AF("ges_vest_replace");

  if(var_2 == 1) {
    for(var_5 = 0; var_5 < 1; var_5++) {
      wait(var_4);

      if(istrue(self._id_3163)) {
        return 0;
      }

      var_0 _meth_84AF("ges_zombies_revive_jock");
      waitframe();

      if(istrue(self._id_3163)) {
        return 0;
      }

      var_0 _meth_84AF("ges_vest_replace");
    }
  }
}

_id_40A8(var_0, var_1) {
  if(!isDefined(self._id_2B6C)) {
    if(!isDefined(level._id_2B6C)) {
      level._id_2B6C = 0;
    } else {
      level._id_2B6C++;
    }

    self._id_2B6C = level._id_2B6C;
  }

  var_1 _id_BD3C("destroyed", "bomb_explosion", "crowbar_break");
  wait 0.1;
  level notify("door_breached", self.origin);
  _id_C436(var_0);
  var_1 notify("delete_this_thread_for_" + var_1.target);
}

_id_6C5B(var_0, var_1) {
  var_2 = var_0.origin - var_1.origin;
  var_3 = var_0._id_AC47.origin - var_1.origin;
  var_4 = (var_2 + var_3) / 2;
  var_5 = vectortoangles(var_4);
  return var_5;
}

_id_6BB8(var_0) {
  var_1 = 0;

  foreach(var_3 in level.players) {
    if(istrue(var_3._id_8791)) {
      if(distance(var_3.origin, var_0.origin) <= 96) {
        var_3._id_8F31 = var_0;
      }
    }

    if(isDefined(var_3._id_8F31) && isDefined(var_3._id_8F31.target)) {
      if(var_0.target == var_3._id_8F31.target) {
        if(istrue(var_3._id_8791)) {
          var_1++;
        }
      }
    }
  }

  return var_1;
}

_id_6C69(var_0) {
  var_1 = [];
  var_2 = 0;

  foreach(var_4 in level.players) {
    var_2++;

    if(isDefined(var_4._id_8F31) && isDefined(var_4._id_8F31.target)) {
      if(var_0.target == var_4._id_8F31.target) {
        if(isDefined(var_4._id_8791) && var_4._id_8791) {
          var_1[var_2] = var_4;
        }
      }
    }
  }

  return var_1;
}

_id_D4A6(var_0, var_1, var_2) {
  var_3 = 1;

  if(var_0 == 1) {
    var_1._id_2B6B = var_3;
  } else if(var_0 == 2) {
    foreach(var_5 in _id_6C69(var_2)) {
      var_1._id_2B6B = var_3;
      var_3++;
    }
  }
}

_id_FEEA(var_0, var_1) {
  while(_id_FEE0(var_0, var_1)) {
    var_0._id_4143 = var_0._id_4143 + 50 * var_0._id_FEB1;

    if(var_0._id_4143 >= var_0._id_FEE7) {
      return var_1 scripts\cp_mp\utility\player_utility::_isalive();
    }

    waitframe();
  }

  return 0;
}

_id_FEE0(var_0, var_1) {
  if(!isDefined(var_0)) {
    return 0;
  }

  if(!var_1 scripts\cp_mp\utility\player_utility::_isalive()) {
    return 0;
  }

  if(!var_1 useButtonPressed()) {
    return 0;
  }

  if(!isnullweapon(var_1 getheldoffhand())) {
    return 0;
  }

  if(var_1 meleeButtonPressed()) {
    return 0;
  }

  if(var_0._id_4143 >= var_0._id_FEE7) {
    return 0;
  }

  return 1;
}

_id_10BD6(var_0) {
  self endon("breach_complete");
  var_0 endon("disconnect");
  self._id_3163 = 0;

  for(;;) {
    if(!isDefined(var_0) || !var_0 scripts\cp_mp\utility\player_utility::_isalive()) {
      var_1 = undefined;

      foreach(var_3 in self._id_5526) {
        foreach(var_5 in var_3.parent._id_BC26) {
          if(var_5._id_CD99 == "bomb_preview" || var_5._id_CD99 == "bomb_preview_2") {
            var_1 = var_5;
          }
        }
      }

      self._id_FE96[var_1._id_CD99] show();

      if(isDefined(self._id_B1CB)) {
        self._id_B1CB delete();
        self._id_B1CB = undefined;
      }

      self._id_3163 = 1;
      break;
    }

    waitframe();
  }
}

_id_FD82() {
  level endon("game_ended");

  for(;;) {
    level waittill("connected", var_0);
    _id_19D9(var_0);
  }
}

_id_1D1E(var_0) {
  foreach(var_2 in level.players) {
    _id_19D9(var_2);
  }
}

_id_19D9(var_0) {
  var_0 endon("disconnect");

  if(level.gametype == "cp_pvpve") {
    return;
  }
  var_1 = undefined;

  foreach(var_3 in self._id_5526) {
    if(!isDefined(var_3)) {
      continue;
    }
    if(!isDefined(var_3.parent._id_BC26)) {
      continue;
    }
    foreach(var_5 in var_3.parent._id_BC26) {
      if(var_5._id_CD99 == "bomb_preview" || var_5._id_CD99 == "bomb_preview_2") {
        var_1 = var_5;
      }
    }
  }

  if(isDefined(self._id_FE96)) {
    foreach(var_9 in self._id_FE96) {
      var_9 _meth_80E0(var_0);
      var_9 showtoplayer(var_0);
    }
  }
}

_id_8DF2(var_0) {
  level endon("game_ended");

  for(;;) {
    var_0 waittill("trigger", var_1);

    if(isDefined(var_1)) {
      if(isPlayer(var_1)) {
        var_1 suicide();
        var_2 = var_1 _meth_8122();
        var_2 hide(1);
        var_2._id_B00A = 1;

        if(var_1._id_965F == "archetype_scout") {
          playFX(level._effect["reaper_kill_robot"], var_1.origin + (0, 0, 12));
        } else {
          playFX(level._effect["grinder_kill"], var_1.origin + (0, 0, 12));
        }

        continue;
      }

      if(isDefined(var_1.classname) && var_1.classname == "script_vehicle") {
        if(isDefined(var_1.streakname)) {
          if(var_1.streakname == "minijackal") {
            var_1 notify("minijackal_end");
            continue;
          }

          if(var_1.streakname == "venom") {
            var_1 notify("venom_end", var_1.origin);
          }
        }
      }
    }
  }
}

_id_506F() {
  wait 1;
  var_0 = spawn("trigger_radius", (256, 800, 16), 0, 256, 500);
  var_0 hide();
  level._id_506F[level._id_506F.size] = var_0;
}