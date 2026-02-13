/***************************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\s4_base_gameplay_modifiers.gsc
***************************************************************/

_id_6F2A(var_0) {
  if(!var_0 scripts\mp\utility\perk::_hasperk("specialty_extra_deadly")) {
    var_0 scripts\mp\utility\perk::_id_6FC2("specialty_extra_deadly");
  }
}

_id_ED94(var_0) {
  if(var_0 scripts\mp\utility\perk::_hasperk("specialty_extra_deadly")) {
    var_0 scripts\mp\utility\perk::removeperk("specialty_extra_deadly");
  }
}

_id_4C17() {}

_id_6F2E(var_0) {
  var_0 _id_F711("specialty_pistoldeath");
}

_id_ED95(var_0) {
  var_0 _id_F724("specialty_pistoldeath");
}

_id_F711(var_0) {
  var_1 = self;

  if(!var_1 scripts\mp\utility\perk::_hasperk(var_0)) {
    var_1 scripts\mp\utility\perk::_id_6FC2(var_0);
  }
}

_id_F724(var_0) {
  var_1 = self;

  if(var_1 scripts\mp\utility\perk::_hasperk(var_0)) {
    var_1 scripts\mp\utility\perk::removeperk(var_0);
  }
}

_id_6F25(var_0) {
  _id_D331(var_0);
}

_id_D331(var_0) {
  _id_07EA::_id_9453(var_0, 175, 0);
}

_id_ED92(var_0) {
  _id_07EA::_id_9455(var_0);
}

_id_D3FC() {
  level thread _id_CA16();
}

_id_FA43() {
  level notify("unset_uav_active");

  if(!getdvarint("#x3b7962a72bff84142", 1)) {
    foreach(var_1 in level.players) {
      var_1 setclientomnvar("ui_hide_minimap", 0);
    }
  }
}

_id_CA16(var_0) {
  level endon("unset_uav_active");

  if(isDefined(var_0)) {
    var_1 = level._id_EF6A[var_0]["players"];
    level notify("run_uav_" + var_0);
    level endon("run_uav_" + var_0);
    level endon("end_uav_" + var_0);
  } else
    var_1 = level.players;

  for(;;) {
    wait 1;

    foreach(var_3 in var_1) {
      if(!isDefined(var_3)) {
        continue;
      }
      var_3._id_0358 = _func_00E0();
      var_3._id_024A = 0;
      var_3.hasradar = 1;
      var_3.radarshowenemydirection = 0;
      var_3.radarmode = "normal_radar";
      var_3 setclientomnvar("ui_hide_minimap", 0);
      var_3 setclientomnvar("ui_show_hardcore_minimap", 1);
      _func_0253(var_3);
      var_3 _meth_85C0(2);
    }
  }
}

_id_404B(var_0, var_1) {
  var_2 = newclienthudelem(self);
  var_2.elemtype = "timer";
  var_2.font = var_0;
  var_2.fontscale = var_1;
  var_2._id_22B8 = var_1;
  var_2.x = 0;
  var_2.y = 0;
  var_2.width = 0;
  var_2.height = int(level.fontheight * var_1);
  var_2.xoffset = 0;
  var_2.yoffset = 0;
  var_2.children = [];
  var_2.hidden = 0;
  return var_2;
}

_id_FA48() {
  var_0 = self;
  var_0 notify("unset_weapons_mod_override");
  var_0._id_1A72 = undefined;
  var_0._id_1A73 = undefined;
}

_id_D44D(var_0, var_1, var_2) {}

_id_EBEF() {
  var_0 = self;
  var_0 endon("disconnect");
  var_0 endon("unset_weapons_mod_override");
  var_1 = 3;

  while(isDefined(var_0._id_1A72)) {
    if(var_0 _meth_8109(var_0._id_1A73) < var_1) {
      var_0 setweaponammoclip(var_0._id_1A73, var_1);
    }

    wait 0.125;
  }
}